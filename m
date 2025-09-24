Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C22CCAC59A
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 07:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24FEC10E6AB;
	Wed, 24 Sep 2025 07:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eyuaEgBj";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 014FF10E6AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 07:45:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjTr4wIBR5sSbTvS7tw5KvY5BhM3BU0WXeNp/Oui/nNh50Kra2NXVtR+bxyY9WookV7nVWc37rzIyUEju53XLlpUIbZ+heU55Lvcg2SBhIvYsgsqgnY+01j3Vcok5WoEnbgkTq1F+ySb//ysdqMU0I50P4oXw+85L4h9+2P1tGhFOHbeGXLBEoBoAIHs9jovXRfVKKtv1N1dcHUzqOarorl0Ei0EgCaq5ZBXxyshvhaTkw52+zYwNnpo+uCJN9GOHsVYO7wCjyJYdW2IdJlV2ieEJBr6iUzqbF7PtW0ue3tvgaCNw6kJ/vkMeX8f7AsruQ8scWo9Em4nnl5QE94Jlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHZ541+LS62JMLBv8mlatvmnOww0xZbJc64OGsaK/zE=;
 b=COTwhnLwQ44nb/woZ6FY1WUPK8I8N7v/On0W3AkK2PCPpmFa1K720IFaqpXB2pqiJGnPazZ50Ve8SbjZteJRWd4eGvExPuZddH/bxP6ibYsBW4oZEZXJHL/CZot7u3hSvsxzgCCIwS732OY+gG76Wj5CndKWtvKtWSMg11yr+ig/9i2ERuGUcM8vkPcla8lpvXnFbf7yD75uorfmJaCPK7PmPOSZXazijODbeJklSi6fe9Rd0kEu8BMlO5uQOKQobY/1c9v+0RyfhR+QoqfpK2dCYFqW9lY4FaOtSB4F3WUsKL9mDWeWWC6Q3N7UjZzlHCCFRz01eSADlyTgWl9C0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHZ541+LS62JMLBv8mlatvmnOww0xZbJc64OGsaK/zE=;
 b=eyuaEgBjAlQXhed9XRSQfym88/tm5iYyfbcrhvr/Eox/FoSIXBbQRvBAeLM4i5Po+ft6crPVAvXgLfOcuCmVZPQ47ou3gUZ08R/Bf7+LpA7kv5tBF3BHrOVgVKlMqK0cBfYEpq+93XesBp60+ep1250tEzMXN5iIyIS5ghPoFVg=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.21; Wed, 24 Sep
 2025 07:45:38 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 07:45:38 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] drm/amdgpu: add missing comment for the new argument
Thread-Topic: [PATCH] drm/amdgpu: add missing comment for the new argument
Thread-Index: AQHcLSE1CtptLAQtBEKuLvNF9te53rSh9BuQ
Date: Wed, 24 Sep 2025 07:45:37 +0000
Message-ID: <BL1PR12MB575321BF07CA3F028F23C075931CA@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20250924070228.3159438-1-sunil.khatri@amd.com>
In-Reply-To: <20250924070228.3159438-1-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-24T07:45:23.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|MW6PR12MB8736:EE_
x-ms-office365-filtering-correlation-id: a3bf6b1f-4518-4eea-1d72-08ddfb3e5a66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?RVpicmVBbGdiWEJMUlo3dEVMVUVPNW1IcGZWZnVrZHl0VVJ5RU4yeXp6cXoy?=
 =?utf-8?B?emdQanRqbGdBbWl6empxRHhnTFJ2NHBvRWsrd1EwSmhLRmg5cWVDQXJlcEVq?=
 =?utf-8?B?WFQxbFVrTGgyZHlGcWFBYldYelBwaUwyU01qQzZscVppTU9kY3ErZFBGQnNt?=
 =?utf-8?B?UlhoNWpPSFh4UXBPSGVKd1p5T2tFdE9sNjNRSnhFRk5leGsyTXVna2xqQm5h?=
 =?utf-8?B?NU8rTkU1K1FFMTdxekFQZ2RRZWdrU09ITVZIOXd6dlVuQnkzQmtjc2gzd083?=
 =?utf-8?B?M0pIRzlscFNNcnh5RElkVTBNaC8vdHhyeU43Q0srUGR1Y1A0UERnRmV4VEZO?=
 =?utf-8?B?SUJlZXRCWUFHclYyRGVsT0dXWXJBVXVkR3owWU8yTGpCaUVkY3A0UXFxWThJ?=
 =?utf-8?B?a2xIREhjWWFuNnlHeGtBTVRmRmdtN3poeUVvUzJ5N3ZOTUYxNmlPWmdRY1Fk?=
 =?utf-8?B?cEtQRHM3TG1TbDNnandhRDdvZ0I3RkR1ek9nL0xIbDdEM1RpdGpLQVVXR1li?=
 =?utf-8?B?M21vUHU5Y3JVWkN5Qk9SSW5DV2ZlckFtZm8vYlVTMkNIdklwQm5Ud3FsZFR0?=
 =?utf-8?B?Njg5WloxNzNnMTBXeFVyMXhFVXpubW8xaDk3TTQ3Z1Q3SGRDR2w0bWRqMzFn?=
 =?utf-8?B?WXM0b3R0MEVUWlQvNUpmRUttUFAxVHIxeUkzMXpkMTRkb0RKREpsYldvdVFS?=
 =?utf-8?B?OHBzYXZza09WMkxBRGpjSWxMV0pDN1NDYWRMSnYxTEFaOWp0NHVXRWZrVmlL?=
 =?utf-8?B?RnE3VWQvd2lrYk0vR1FMeFh3SlNPZTVWc212U2FhVDhBNVMwVFpCVy9OSEJn?=
 =?utf-8?B?M2V3b2duRHVHWFlPQlBOYWtKaEMxVEZMUG5qRXFEN2FOZDczUU1wdG9kK1NF?=
 =?utf-8?B?bUNjUXMxLzNKOTVWaWpvRjlMdmJjR0NjaHU0b0trK1JFdWw1TVdsZlY3YnRQ?=
 =?utf-8?B?WmdYQndWb0l6dElyY1FvNlZsU2pDZzF0RUptMWh6MmFaTWMxY1huNnMraWF6?=
 =?utf-8?B?VlE2SmkwZ3MyeE0rSGluWUI1UDhCa210Q1RkVkVqVzdBNnlFUkJVS20wUUNs?=
 =?utf-8?B?YW5DcmRuWmZaRHVPOCtKOVpHR2h3M2hOa2dzbFpxOWJXeDd2Q3RjNVFLbDBk?=
 =?utf-8?B?T2hMSGVCUXZOb1U3Rm1ncXV4ZVE4WmxldEpWQjNrOEhTM09SZ21kWXdEbGJE?=
 =?utf-8?B?akYxaFVCZExKeTJUWnRQSVdaaDNFb3MyWjU1Qm1hNXllbVlJWGVCVEtRRGg4?=
 =?utf-8?B?Z3FNemYxdHNTdmtZSHFDNENHaWQ1NnRoOFYyQTM3RDJiODRrcGlLNW1hN1ZB?=
 =?utf-8?B?S1k2NFBHVnM0REhiaEtrT2JEdlNxd1dmR3V3ck5JdVp6VHpIZHgrWkljTlUv?=
 =?utf-8?B?RlN5MGVvcHQvanhWMTBSQXZsYTd3OVNHTDN0QUY0aU5hMVBPeU5CbkV4ZVJk?=
 =?utf-8?B?Lzg2bVdKbzJBbXJHZVZJYTNSSWhzcmt5T2I1RE5TZEJkcUVucndnTjE5R1lq?=
 =?utf-8?B?a3h3Z2dIU0xLUGp6U25KcS9udHhmRkJYRjFmQ0dNY2ZVQ0VEdjFHYW9HVVMw?=
 =?utf-8?B?VnR1WS9SaXVsTlUvR2FRZ2d5L0NPeG5sU1dKUDBUK1d5WFFISWVneFlGSG1D?=
 =?utf-8?B?aDdiNldpRTJKUVFuYTAvcWZTVVlTcWQyWUdiQlRUWVBEc1R6NzVPa0JEOTk4?=
 =?utf-8?B?d0xSaS9GcjNaZmRnZkVqWGNmSUU1VEV6RzdJS2p5WTRBTEx6U3ZDa0h2QVVD?=
 =?utf-8?B?d3VPQ01wMFIrL2ptYmpIdG81NzdrM3lURDBsYjJBeEE4ZnEreEdQRVo4em42?=
 =?utf-8?B?bEZjWEFEU2dPdTYwS3VNc3VtZnFQWEEwTlBPMUZSQWp3R29MZ1lYbyswNkRr?=
 =?utf-8?B?Mld5Q29Cc292SkdFL3ZoMkV3dU83OHY4ZXplQzNIeHUzUm9mdTRtMmVHMWEv?=
 =?utf-8?B?UDhWaFhuN1FRN2NySzZ3UGF4MzFWMnNXWkp4dmtpNkNielErSkg5V01mOUgw?=
 =?utf-8?Q?RqP+3D9yufUGl04ywwhm2lJRPfI76E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzlacVlUdVpEZVRGdU5uU0dOblh5cVFLRkZTOEl6c1dwdkNlUU0yY2JoY2pi?=
 =?utf-8?B?WmxCa3JxRkI3Y2dhbkJKZVJsVkxuOHkvSjd2cnl6YWE0ZWV3M3BqMHB1MTBZ?=
 =?utf-8?B?c0RHMGtJNzVWVUlndGNxOVJSenNuYnZ2dkxKYnk3MDNHM3lkZGg5TnBlTXB6?=
 =?utf-8?B?d0VnaFRYdm4vRmd0cnRRcDgrTk55dWk0TENZb3U0TUI0MElFSmYyZWdBUk9E?=
 =?utf-8?B?L2I1SGFhOUoxRG1saTlaYXF2dEx5WXBqMTVtdDZDRmx4K2N4MDZPdE1kTkFG?=
 =?utf-8?B?ODVPTE1Ybm5FNElKTzhwaGtnOUUrQ3hEU21hU0piMnFkNGwvU0MvSHdRUldR?=
 =?utf-8?B?SzJXMXNKUkJwZ21Jb2lPcDdqK0FmYmhrUU50YXhvM2RIWVBvY2M3OGFDWEdj?=
 =?utf-8?B?VlIzSlBoN3NjK2VUVHJWcUxHaUpOU1RKNUZOOUg0TUNJYUhYcjgxdXU0MUtr?=
 =?utf-8?B?aHo2TXBTK1laOUdGSFJTZEFrVXhDQlAxaHo2VEZPTGZsYWc3aGdyaEhSUVIz?=
 =?utf-8?B?VjAzRFpHU0pGRE1yUnNhUXMvOUREYzN4RDlnTlNrL1I3Szk4NGRTWDdwRDVa?=
 =?utf-8?B?SGE1bXBmWDNZQnFGeW8xVFBsZWpzaHowWEk5c2FTNDBWcTRvcGgxdGNWSmFq?=
 =?utf-8?B?QUY3eHFaclk1Q0RxbXVaWjdZRWlDMUUrMTFKMDRuanB4U0tDYld2VXZnNW1k?=
 =?utf-8?B?YkltdUpFUHQwdGpxY2ZQOVdkZHM0V2p5cTdDTGlOSFdpeEdERjJzYm5jMU1E?=
 =?utf-8?B?dWtNdWU0a0Q0Z25ORi9vZDcwYmgwaGdXVW9MRTVoR0pTNzFxcmhwQ1hLazZu?=
 =?utf-8?B?SUhMR20yNnhnT3M1TDlabzc0cVA3aWVuZzl2UHVWWmJwYW12WXJkcHZWMlE4?=
 =?utf-8?B?M0RQT09neDN5Y3RORHAxbmNvSkQyc1ZUczlpakY4ZFZGVEtYL0hCaFN2eHVp?=
 =?utf-8?B?MnpEVk5YVnREVVIzcjBYeExrUUhUNlVDRTVsakRBd0RGemxhOTE0bE0wYlpv?=
 =?utf-8?B?UjBLNHBjZVk2WElod1lzN0I2YUxnV0JMNTI4OHNZejFMUjFJcGxVVHNneUMy?=
 =?utf-8?B?SWhvUkxmSGhTcjFFWjlUL0RPQ1JBM2JLVGRSdzRCakVEaExBc2ZxOU9xU252?=
 =?utf-8?B?b2tteXhWY253dEFYQlR1T09qc0lSMXd0RUFEVTZpM0FjL25EODRpRE96MS94?=
 =?utf-8?B?R2srRUlQQm1KUitlSFlHUld6azhQQ1ZyQkN6TVh1OGRIY0FnNVZZQkc4SzJr?=
 =?utf-8?B?cE9jT3FENW5rR0R3RldvcENOelhhbXZ6R0JZcTJnMDlmZWlmdEVla3NyU0xp?=
 =?utf-8?B?VWFXUWF4andhWUtuOUlac2VxRWZqczR2a05oNkpSUEFKSk00clVtMzV3NTA1?=
 =?utf-8?B?aUpDSDBPSHVheERmcnMzYmxaTDdVSTIxcG9OUjNISnNjZ3h4RWxpbjhqZXZk?=
 =?utf-8?B?Ti82L0hzaFZHR0ZFaVVFeURoNUZCZlVldlFLa0VrdkxBdHZjMEpaU1hpUCtU?=
 =?utf-8?B?dUdyTjBCamsreFNTVWRNV1J4MTg1R1hubm5jR1hzQnRCUExMZEoyVXNvVDNy?=
 =?utf-8?B?K0o1VWJ4SEdYNHVXcEQrNWhmRG92OHAwc1NJY3BPVkNPOHZxdlVLdHNvWDRW?=
 =?utf-8?B?bzYvMTNWZE1wTU1yTnA5R1VlL1RmTFRsbDEya3haVW1tc1VJMkE2QW9iMkdR?=
 =?utf-8?B?RTFmVUl3WDdrU3VWQWZMWGdRRmprOHFQTk9YOGVBUzVUeTFocDBuMi9FQ3A2?=
 =?utf-8?B?a2VlakxSQ2VYeS9XRVgvdWZvZVl5c2h4VUtvc0Z5Z2tmUjdRMG91dGVsamMz?=
 =?utf-8?B?b0cyVmowR08wQ0xjR1dKQVk2OXY5NXhMN0RXZzhWVnYwN2dIVHZ4WXNDU2w2?=
 =?utf-8?B?T29aZlZZRE04bEluZEEwU3ppbWF2NTdSeWd0amNFeVljVW80RCsvWmJQKzZt?=
 =?utf-8?B?YnhKbUtnRGJIeDdqTG0waWtmQ3ZUTVpyTVZ6eHhvQ3RGcXptVkFIMTVYL29u?=
 =?utf-8?B?TTBnN3BzYzFLLzNiUUp3T1ZjSjZrZVhncHZPQ1Q3dFY2NDhrMEN5YWsyejBy?=
 =?utf-8?B?SWNiNW1Sd1hUajlVcUhncnJ3QUdaOURTd0g0Vm9jSFBicFE2UWNQNmpmZCts?=
 =?utf-8?Q?63rk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bf6b1f-4518-4eea-1d72-08ddfb3e5a66
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 07:45:37.9645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c0CQR/7mn6lLNJqLnAtsiH+2XdtDGUDIx65YOvAIgBMJuczmB2qrJQ6NACQCT8iWYPoaC81yIe3wMFihgS3baA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSWdub3JlIHBsZWFzZS4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFN1
bmlsIEtoYXRyaSA8c3VuaWwua2hhdHJpQGFtZC5jb20+DQpTZW50OiBXZWRuZXNkYXksIFNlcHRl
bWJlciAyNCwgMjAyNSAxMjozMiBQTQ0KVG86IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4u
S29lbmlnQGFtZC5jb20+OyBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+
OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IEtoYXRyaSwgU3VuaWwgPFN1bmlsLktoYXRyaUBh
bWQuY29tPjsga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQpTdWJqZWN0OiBbUEFU
Q0hdIGRybS9hbWRncHU6IGFkZCBtaXNzaW5nIGNvbW1lbnQgZm9yIHRoZSBuZXcgYXJndW1lbnQN
Cg0KSW4gZnVuY3Rpb24gJ2FtZGdwdV92bV9sb2NrX2RvbmVfbGlzdCcgdXBkYXRlIHRoZSBjb21t
ZW50IGZvciB0aGUgbmV3IGFyZ3VtZW50ICd2bScuDQoNClJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVz
dCByb2JvdCA8bGtwQGludGVsLmNvbT4NCkNsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
b2Uta2J1aWxkLWFsbC8yMDI1MDkxODAyMTEuVUFxTUUwemotbGtwQGludGVsLmNvbS8NClNpZ25l
ZC1vZmYtYnk6IFN1bmlsIEtoYXRyaSA8c3VuaWwua2hhdHJpQGFtZC5jb20+DQpSZXZpZXdlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KLS0tDQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAxICsNCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMN
CmluZGV4IGQwYzk1ZmIwZWY4MS4uMWNjZDM0OGJmNDhiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jDQpAQCAtNDg2LDYgKzQ4Niw3IEBAIGludCBhbWRncHVfdm1fbG9j
a19wZChzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwgc3RydWN0IGRybV9leGVjICpleGVjLA0KDQogLyoq
DQogICogYW1kZ3B1X3ZtX2xvY2tfZG9uZV9saXN0IC0gbG9jayBhbGwgQk9zIG9uIHRoZSBkb25l
IGxpc3QNCisgKiBAdm06IHZtIHByb3ZpZGluZyB0aGUgQk9zDQogICogQGV4ZWM6IGRybSBleGVj
dXRpb24gY29udGV4dA0KICAqIEBudW1fZmVuY2VzOiBudW1iZXIgb2YgZXh0cmEgZmVuY2VzIHRv
IHJlc2VydmUNCiAgKg0KLS0NCjIuMzQuMQ0KDQo=
