Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C258D65C42
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2024 06:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D33F610E794;
	Thu, 14 Nov 2024 06:35:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q/BBw8fN";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5322F10E794
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2024 06:35:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrQZt7gIpFCmtphG8cxAOYCSl2AXBQ5OrRRxLdpM/QuvVR4BZrVl6VmbZ7rrdcd+55HMRMmcp90ds2qVmC1gfLceTWEt+L1U3rhc01aJ5gsv5SG6gtLPFeiOwOtmvYxMkI3QM0dTp08hIxSsp3JSVMqb+nXpJl7xe+gKbR/hr3VISmLWVPYER3Cny8GJhFQpwnmJpPj6QTgP7McY18hdSaFaZeWJChmGuIoTLn2Fes7s/7O0w3h8V8rzdSKefjufiSPdUH4TuSj4HhU4CC/DkpdghgB3I5Fcq5kaMlWvyH4qABcn4vVzx4nxu1JBWq+ies+wjHfw9hClgD5jsseG1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7FVOimlBTymWjELXeGwG+aHD2iHgaZ7OwxLAgPfCsI=;
 b=SV+3rxTIDPVcGfvj2wJKnEJ8mVGflVkBH/rYge4dP8e3rtyEprRt3IJg5RVqunVwEaciwo0/NrZqSLrLJ9nNihWtsYDVkMqrtig31wbBpVCBCuJcdpAEuUR82dhmQPRxYZnLrrZeFD/7QjdqxSo+tEsJ8r3Ro5xt6Q65Aw7UvEbUeI3HUzLFJf5eplTbd0PrwrvNQvKwgcYQg3248Cm4JrF1AUVAnn2P2YWgH+qIwfV/0kXnd8G+biRQB2FEC4YVySYujiSRnRMZ6tKEb6r4+BbGgaB0BpLFd/oR8XxSPFJaMH9FGamnY/akRr7F/QjfG2QfoAlsMd1xLnn+5F7o1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7FVOimlBTymWjELXeGwG+aHD2iHgaZ7OwxLAgPfCsI=;
 b=q/BBw8fNvcduD8EBFNBg3kaNdiq5WqMLoTAzpdnLIWmjWmknZY9Bqebs8b4x3a3obUiMEQZOT2hIAGrrV+0bhRqfs6n+m9SRrjW98YDqcBZfgt/TEv2kvc88HixnGvoaOjc6yjI6UBTtS7xwW+VIJcfrPrRCRM5yLA6vfkAw1LM=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 06:35:16 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8137.021; Thu, 14 Nov 2024
 06:35:16 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Add missing kdoc 'inst' parameter in
 'amdgpu_device_ip_set_powergating_state'
Thread-Topic: [PATCH] drm/amd/amdgpu: Add missing kdoc 'inst' parameter in
 'amdgpu_device_ip_set_powergating_state'
Thread-Index: AQHbM+OxBC38qrgb1UKAPbUu8ZJSgrK2VquAgAAAIOA=
Date: Thu, 14 Nov 2024 06:35:16 +0000
Message-ID: <BL1PR12MB5753F66139DF0A597DD509B6935B2@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20241111024436.1881300-1-srinivasan.shanmugam@amd.com>
 <IA0PR12MB8208EA2FB6311968DF1E9A03905B2@IA0PR12MB8208.namprd12.prod.outlook.com>
In-Reply-To: <IA0PR12MB8208EA2FB6311968DF1E9A03905B2@IA0PR12MB8208.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=78214b06-5f60-488f-8486-f4659bdef2da;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-14T06:34:08Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|CH3PR12MB8187:EE_
x-ms-office365-filtering-correlation-id: ebe38674-8585-437f-0f8d-08dd04768089
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eHowMzdnbExrTDRzNEFzWmRJTnBJaEl6V2ZUZ1ZKY2NCUUJtakZMTmR5N0tO?=
 =?utf-8?B?NVpncE92TVdHbkdTN1QxN0lIYWhzNUMyRUZic1Zzc05wczBpZm8ySGU1QndT?=
 =?utf-8?B?RXRBcmU3eEFDOG9BNStvdUkyZno4TVZMQUlsdU4rTU54bkF3dnNQb2dBbFVH?=
 =?utf-8?B?L282NnZLTHE2Rm5kTDhxVHJtaFhieHpKKzVEb3dycU85a1lFUDlFcTM0bTY4?=
 =?utf-8?B?Q0RLZituYk45T1lQRjU5WGp4WnFDcGtwcjBGRjBPNElIRHZTb2JnVE9EUXp0?=
 =?utf-8?B?Y3EwbG16ZENjaEJsUExod1FENXA1SWcyVnRnanl6cHNBV05sL095UnEyR3lJ?=
 =?utf-8?B?L1VtOG83ZzFkWnI5ZWVYMm1GR1VaLzJmT0hXZ25FNkg1RlpOUVZHVGp4ZHRs?=
 =?utf-8?B?V1JYeFAySU9CUkt2SVpSMEZidkt1dXBJMzlUNzlDV2FNeWc0L3U1MitWYlNt?=
 =?utf-8?B?Ri9NTlpXOFMzY0tGWkVPTEpzVis5YXNEaXdjZkEwTkVLa1FneVF5WHcxWkdJ?=
 =?utf-8?B?c3JiS0JFWUNzdFQvUDU5Z3RPc1BXNTEweW5mQWFENG1TazBFcmpPU29MWC92?=
 =?utf-8?B?QUJZUk5BcE5iN2UzSzc3aWpNbjdQVysxR1RyU25Vc0JVZCtDZGNGKy91angy?=
 =?utf-8?B?Q0E2Ni9KdVRXMmJJd2ptanU5d250bEt0VnRnYldiM2lzV0RZbHpIWkNodDRx?=
 =?utf-8?B?RFlRWnBFWDJnVmVZZHpIV2RTY1V6czd0aUhDR0NLVkM0WW9tL3p0T1NKSkFz?=
 =?utf-8?B?Y0l2ajNJMHEvVmZlZkFhT29FdVY4b3VNdGpScDdFakYrV1BWWmxrdWFnNjNr?=
 =?utf-8?B?WTVqNmUxb2F0SHVTSnVhekpRV3VaMG9WYklKY3BwdVc1Z2tJemk5SVRoUWpT?=
 =?utf-8?B?OWtMeER5eDZTMzMxR3dycHV1d0k1VFY3MWErdytNTFpObk51eWt2MHBJTDBN?=
 =?utf-8?B?TE9RSFpjL2c2QWFpQVpIbUVNbmdYaEswRktQSWpHb1RYR1ljc0h6RjRyV2JS?=
 =?utf-8?B?d2Z4MWhFQWU3OEtFMjB0TzhLcWFLcDBXYUMrYTlkS0lVVTVTSFZweGtzTXUy?=
 =?utf-8?B?SGppaHcxNGtFZ2Npd1VuaGxIL0xRMUJJS0NuOUdzRXZCVG1aMU9jR3I3dE8y?=
 =?utf-8?B?MkpjSDdTc0pUM3ozRGp6R0RwT2pDVlIwUzY0VU9BWVdmMVJOdnROYVpkTFdZ?=
 =?utf-8?B?UURFeHlNcmhLYXRzTmRMaFIyRUU1R3ZMWUhEb2wwd0xES3RienA1WFIyYnpL?=
 =?utf-8?B?bXBWMkM0VUR0MU0xYnBreVFQTytudHRXSGFPYVBYSEJVRG16WXNaV1pzSU4x?=
 =?utf-8?B?Sk5wSGRwenVVREU2MlZDWVdLa2hGUks2bGpKNDFreitHaEczT29kODJCWHlV?=
 =?utf-8?B?ODZzUEpOV3BNaWxyc1dXOFRLQWY2aEVNNHg4TWEzRUxZQXN2QThnNE9xcVlX?=
 =?utf-8?B?VXJEbzl0TUhOVnBLcXBURVFIQ2EzWGVyQzBtOTRTMGhzaUxTOFNBVnpsV2NH?=
 =?utf-8?B?aWhOMUdhLzBLWXZuaUR0SVNxR3kxSGNyK0FuUndOb2Q5eEw1dkEzWThaYlRv?=
 =?utf-8?B?K3hqZStHczFBSUUyTGZONDFDdWFLaTVVS3lMZitWOHpweFVqTmpxOHZ2MWpl?=
 =?utf-8?B?RzJDR2k5Q1NHbis4N0cvS0QvVUhsZDJoZmMzSFVlUmxYMXU2SEs4K0dqQysx?=
 =?utf-8?B?TkRnYWJaT0JMLzVVcVZWRS9oSlBrbU52czYzK1crWXVkRlhFWmQ0UDRsYUJv?=
 =?utf-8?B?cXl5ZG1FQS9vVkF3S3JSTExrbHVmNzhqUjVnNXBMb1N6VmpkVWVkQ0p0K25G?=
 =?utf-8?Q?TRm/2lvkgWEZqj5gNCTW01TbctRsEWY7QEJXg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0padHpqdnpZbFZNeUtFTFJ1VXVXVlFoL2NPZzZOTHh3cVh5NnNQZ1NXS2w2?=
 =?utf-8?B?bVRSUy92SktBR1R2UGh2cDErR1RNbGtCU0Q4VWFRaGZBb1VkWk90Vk9aZFVp?=
 =?utf-8?B?ei9nTlErbUsvUkYxMUM3Zm5qVHZmcm0xSHFzMlFFSHAwUzNQT1NqM3NTVnUr?=
 =?utf-8?B?UUhsY0NiWlErSUFOV1BXMGNta1VBVVBmZFIzUU9wbmxMSDJDcGJ1aHlYaGha?=
 =?utf-8?B?M1RyRlVWaGxEdXU2YUFHcnZENUxVNDFRcEUybDZIN2podWJYTGlBOHlQK2Vk?=
 =?utf-8?B?Z3pzbFc3aGdpeG1ua0d6M2ROU3RYZm42NnpQZnlDZXQ4QS9mcU9KdGIrWlFr?=
 =?utf-8?B?ZmRCUmk1YjZ1R2FtVWY3aWhZVUtZZ2xDczZ4L0x6VmxHTHU3bXhZVlkvQWlM?=
 =?utf-8?B?aDQvdjdFMXpEdXVkcXBHQ0Z5K2dFczlvR01DYnl4a2ZhME5QSU5kRldQRDhO?=
 =?utf-8?B?eTIxNlB6NUJVcXRHV0libEI4ZjFDallUN0hpUDFKbGNZTWdYV0k3UlFRY2NU?=
 =?utf-8?B?bmh6TlNWNHFUck44ZEFYS25zNTZ5elpPMFE5eC8wcTRBNWVKTUR3VzJwNElY?=
 =?utf-8?B?L0xIU1pFeVRPbDMxTzVQSXUwSmJNa21YM0ZTdlYremNWSTQvMmxtWWNtQVU0?=
 =?utf-8?B?bVkwNE14ci9WYWtKN3ZpaVhDQkZPRkpTTlA2QkZkN1FxK3BicTYwK2IxRTBZ?=
 =?utf-8?B?MGpGbEdwMDRCb2xMTTRMNmRSVFZSa09hS0U4bkZrcTBjVzJRMWkrT2hFUXYv?=
 =?utf-8?B?VnNNc05UM3ZoNHZnM3FaWGU1QkZQajR3bXVjWUlwK1ZOaDFWZUZQMWJXQVBs?=
 =?utf-8?B?bUpkNlNURWZYbk1NMnBKV3pDNzI3S0poR0N2RE90SXJpbFN6UlRFV0h4V3dp?=
 =?utf-8?B?eldua2RMbitjY1Nvd2ZyeUY4OXZsL0xseDYwN2E4SFJjRkhkV2trbVhqRE1G?=
 =?utf-8?B?eEZqcGFaa2xiSVI3RUZPWnh1dUZQdEFNK0tEK3d5Q1dLUzF5Z3NGN25MdEx4?=
 =?utf-8?B?NlJYQmlNLzJCNFVhRWFsU05FYkNVNzBSMVJYQkNZSVBZRm5UcDRyQWNEK2ZK?=
 =?utf-8?B?WXJFVHJhTm40TXNUaklBdEpBR2l1Q2FFRi9QYmJ4TzBlaEtsRU95ZzVHL1kz?=
 =?utf-8?B?RXYrTDkwa0g3K1RoOENPZWt3bm1CMnRsRU9NZWYyU2JNaGdjWWljRFVzQmda?=
 =?utf-8?B?aExRQzlNeisxaUo0QTZyUzFwZi81eDNMV1NmdTh1amdIdWJuRHkvZjVNdHNz?=
 =?utf-8?B?NGY3aEhUK2FZWGdaTWk3am5QRkUxaElEbGhvem9HY09iZGRFVzUrNG4wVzdE?=
 =?utf-8?B?Nk81QmRQSEN3WGtYek5lM3lPOHNJT0w3NnVXNW9DMjZLN25XQ3l1VEgxZ3hw?=
 =?utf-8?B?bTdBb1pMZHlyZnNvMFVDYW9IOEtrKytnRXozQ3lwVWFhWnNYeE93MXVSVGxo?=
 =?utf-8?B?d21rckgweEtJWDB6ekE0UGtCZ3RUVVdZS0RZQjdnQS94UWpYVDU1SXRiQVFI?=
 =?utf-8?B?N2Z1bWtuUjFudmxXMmQxb1NMeVN5N1oxaS9TY2JNY3lBTzlEbDZ3SmZhU09C?=
 =?utf-8?B?eEkxeTl2eXBtaUxPYXZtWTZQVFBua3djaG1MZjREUGd0Mmhic1NXMWF3K09o?=
 =?utf-8?B?eFNNWFRTbVZFSnNMMXNRWmdRWVB0UDRuOCtxVnJ2UnVpRWp6VmdaNnVlVWdQ?=
 =?utf-8?B?cDdKNTQ5VEt4OERGb0YxMUtHYjhSdDcvOFVYcUpuTHM3cjRueGdFSmQwQXV4?=
 =?utf-8?B?Vm12bmU3aFBMZy9lUFNnaW0xL1pkUmhKZmV5SXdVVjZhTmFsR1BSUEpHdDha?=
 =?utf-8?B?U2hpcnc2MnpGOUUzdFBoWExaUGxtTWhLeEtZa2t4RldiU0VnQU82RCtkdXJL?=
 =?utf-8?B?cnpSSkYxV09FNlJJZDJ2c1pwaldWUzh1L0FJenFFdVlzUmpBUEw3Njh5c2Qx?=
 =?utf-8?B?ZnhZcDlKTTRGWGtaakRQR2ZXbHpnREFFR1FaRGFiWERyRXJDMVFIakI1WEdX?=
 =?utf-8?B?bWprTWl1MTh2ZmFlZm5vTEVWQlpqYU5QeDdmdTBDWjdITnJQUmJuZFhFbzlK?=
 =?utf-8?B?WlRYRkp3MTZEOHJmM0JHNUdCYzBPTmZkUDRhUWN0R0FOdmxNU2h6ZUdWSGVJ?=
 =?utf-8?Q?ShTQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe38674-8585-437f-0f8d-08dd04768089
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 06:35:16.5169 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdeWprX2dMzOOfhcXVFkgFsdEqzoUeV506I16PZaBwvAI5KI7cJhIAg0cgQBvUujNDhrKhUIWgNgz7xoN/jsJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187
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
Cg0KU2FtZSBoZXJlIHRvby4gU3luYyB0aGUgY29kZSB5b3Ugd2lsbCBzZWUgdGhlIGNoYW5nZXMg
bWVyZ2VkIGFscmVhZHkuDQoNClJlZ2FyZHMNClN1bmlsIGtoYXRyaQ0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIFNIQU5NVUdBTSwgU1JJTklWQVNBTg0KU2VudDogVGh1
cnNkYXksIE5vdmVtYmVyIDE0LCAyMDI0IDEyOjA0IFBNDQpUbzogS29lbmlnLCBDaHJpc3RpYW4g
PENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3Vi
amVjdDogUkU6IFtQQVRDSF0gZHJtL2FtZC9hbWRncHU6IEFkZCBtaXNzaW5nIGtkb2MgJ2luc3Qn
IHBhcmFtZXRlciBpbiAnYW1kZ3B1X2RldmljZV9pcF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUnDQoN
CltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHld
DQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9u
bHldDQoNClBpbmchPw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU0hBTk1V
R0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPg0KU2VudDogTW9u
ZGF5LCBOb3ZlbWJlciAxMSwgMjAyNCA4OjE1IEFNDQpUbzogS29lbmlnLCBDaHJpc3RpYW4gPENo
cmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgU0hBTk1V
R0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPg0KU3ViamVjdDog
W1BBVENIXSBkcm0vYW1kL2FtZGdwdTogQWRkIG1pc3Npbmcga2RvYyAnaW5zdCcgcGFyYW1ldGVy
IGluICdhbWRncHVfZGV2aWNlX2lwX3NldF9wb3dlcmdhdGluZ19zdGF0ZScNCg0KRml4ZXMgdGhl
IGJlbG93IHdpdGggZ2NjIFc9MToNCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYzoyMTgyOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3Igc3RydWN0IG1lbWJl
ciAnaW5zdCcgbm90IGRlc2NyaWJlZCBpbiAnYW1kZ3B1X2RldmljZV9pcF9zZXRfcG93ZXJnYXRp
bmdfc3RhdGUnDQoNCkNjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+DQpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KU2lnbmVk
LW9mZi1ieTogU3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5j
b20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA1
ICsrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KaW5kZXggYmI1
MzBkZDJiM2UzLi44NGNkYTQ4MzQ0NWIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYw0KQEAgLTIxNjcsOSArMjE2NywxMCBAQCBpbnQgYW1kZ3B1X2Rldmlj
ZV9pcF9zZXRfY2xvY2tnYXRpbmdfc3RhdGUodm9pZCAqZGV2LA0KIC8qKg0KICAqIGFtZGdwdV9k
ZXZpY2VfaXBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRlIC0gc2V0IHRoZSBQRyBzdGF0ZQ0KICAqDQot
ICogQGRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyDQorICogQGRldjogICAgICAgIGFtZGdwdV9k
ZXZpY2UgcG9pbnRlcg0KICAqIEBibG9ja190eXBlOiBUeXBlIG9mIGhhcmR3YXJlIElQIChTTVUs
IEdGWCwgVVZELCBldGMuKQ0KLSAqIEBzdGF0ZTogcG93ZXJnYXRpbmcgc3RhdGUgKGdhdGUgb3Ig
dW5nYXRlKQ0KKyAqIEBzdGF0ZTogICAgICBwb3dlcmdhdGluZyBzdGF0ZSAoZ2F0ZSBvciB1bmdh
dGUpDQorICogQGluc3Q6ICAgICAgIGluc3RhbmNlIG9mIHRoZSBoYXJkd2FyZSBJUCBibG9jaw0K
ICAqDQogICogU2V0cyB0aGUgcmVxdWVzdGVkIHBvd2VyZ2F0aW5nIHN0YXRlIGZvciBhbGwgaW5z
dGFuY2VzIG9mDQogICogdGhlIGhhcmR3YXJlIElQIHNwZWNpZmllZC4NCi0tDQoyLjM0LjENCg0K
