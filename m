Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094A4C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 05:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A253410E4A8;
	Fri,  8 Aug 2025 05:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ar1gzrRS";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5F1D10E4A8
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 05:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkLWQWK6go26oXgLfirsc1c1fk/0+b2FpghJgw6FNCYXNNw3h/fBTTxR/EB9LV5D9AEknaYBj0J0b1VvJkBX4JVSSpdM8268V5kGYyAcq/nM3lC8DPSaaTpKLriztldu5gy1ZWYZFv5eMdsfCPVA+PscQV9uLqNjmNjTQVxZINZM+63BhHO1sP4pAF+rqI8ku873Gwx9SSIQNFaRab1VhA0lM+UeAcW3hm1q8YEugtSjN4sosafJ+top2LnxYyjztE8HsWX8B430K7FWlseRgd05HBp8nGTDd8QN2M0koikptXg3ym8c/a6Dyzb5+FSx5hv1vd4ClC16YinDeiaFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egguD7nAtiHK1c8zHue8lWIbSGP5L9s3ZmhRfoVmDr4=;
 b=dV5m3l1hWyEvZBdjc5j5j1PwO++2S+wUYODiyCklpNX5NBpKR0/7FWP7vBURsIn272rmgEH0dvHHbnaC4YflUB40gcJYwUO7mg73q9ckhk4+02sBJVnyDPNzeMD7dP3UePeqWYmDke+u2MfdT3wq5QPihMQMK6sWMyqDdx2F6QLKyTW6k0Ow6Ct/xvLmJPnAO8cE0KcF4bhBJwaQjgibrxcEWW3ItkT2TKBCdr09ZhPwkMnp7oEbDWL4fVmP6hkGCU3A8GJa+2uYlTdKd8+Q+djUnB1b5o89vWD1zZvJfOVsz+O/kaCR/piEtr9mMN6UUxEETjpnVB/DrgwQa4rNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egguD7nAtiHK1c8zHue8lWIbSGP5L9s3ZmhRfoVmDr4=;
 b=ar1gzrRSoXHBkg3F2IF/fCllOrkHOAC7C//FM/TQ+jK7sV//nv+qJqH0tKO35F+Cbrt9cb77+xZsGVDEEOt9BFkw0W7uBTaX3LUaGZ2aJ7XXe8UlVoqcKY/6rJHT7MwGSnY7XRSkIN8btH/p4HtWMqHZ6WjoRaGeCVVciRjz1YM=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CY8PR12MB7636.namprd12.prod.outlook.com (2603:10b6:930:9f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Fri, 8 Aug
 2025 05:03:26 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 05:03:26 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
Subject: Re: [PATCH v4] drm/amdgpu: Save and restore switch state
Thread-Topic: [PATCH v4] drm/amdgpu: Save and restore switch state
Thread-Index: AQHcCCE7r14jp0jAPUSRK+KPGlsPS7RYMv/3
Date: Fri, 8 Aug 2025 05:03:26 +0000
Message-ID: <PH7PR12MB5997EAA3BAA43D3F72CF36C7822FA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250808045909.1836770-1-lijo.lazar@amd.com>
In-Reply-To: <20250808045909.1836770-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-08T05:02:23.9132116Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CY8PR12MB7636:EE_
x-ms-office365-filtering-correlation-id: 2ee51d6c-50ef-478f-8c43-08ddd638e884
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|7053199007|38070700018|8096899003;
x-microsoft-antispam-message-info: =?gb2312?B?bUtHQVV5NGNwTHpIUmdKQUl4SzRJTGhpbjRzVE1PL0N5RnZvV2pPc3RjdDA3?=
 =?gb2312?B?ZWxQQVc0NzEwUm9JVkQ3WU1SZUlwVkVpblZLRmhGNGdVTURZemR3bDYxSElY?=
 =?gb2312?B?SmZwZEFmTVFiNlJmQVM4a1F4M0wvbkdRaXZ2Zkthb2paaXhqU3IxVW1iNkRi?=
 =?gb2312?B?U091a2wrZVQrRlZMM0p2bTlXUk5oSVYwcEpQVUE5eHRjdU15Qkw2YUNqVDh6?=
 =?gb2312?B?cENvdHFSVDZzNE93UHF4QzgwUWdTNnEycDVjWXdheHFReHc1UEVlNzY4RFpi?=
 =?gb2312?B?UkZYZXNpZ094UU5zSzR1R3JZZm1HSzBlZVpKVzh1ek40YU9QbG10cFJocjQy?=
 =?gb2312?B?cnFCWTJjaDJQR1I3T3o1WHBlMlpsMVBudUsxVVpHWDBMSUVwZzQ5TVdVUFFO?=
 =?gb2312?B?amdrd3VxTVZqT1ZDQkwydXhDV0NWUjBrY3NwcHdSTy9mMlRXSEE1dG1PZlgr?=
 =?gb2312?B?V0t6ZW93QzVLbjBQSEcxV2kyNitoYzhmaWtPcjVSNDZ4bmNEejhCaEFQbEdQ?=
 =?gb2312?B?SjltZ1RnMTBaWUhHL1V1MFY1ZWcxL0JmQXVkazQvUWN5UFVPOURmOWFTdkdn?=
 =?gb2312?B?cllLYmxCbHhSU1BsME1uUzNLcTk3blplaXJHYUEyTTh0eitaaTU1VUJoRzEy?=
 =?gb2312?B?ZnRILzB0RTZQOGhCS2pNYVBYTGh6Y2RaR3l2YUxOWWhuNmVVYmdoSEx5cFEr?=
 =?gb2312?B?Z0hGNVNHMDZnd1V4bW0zOWo0Mys1U0t5eHRicElRdkNBcnhXVzZ0K0FMQ1N2?=
 =?gb2312?B?SmxDQ2NMWmd6a21iS1N5Y3VMa05YOVNlZFNudlhTRkNtU2M1UjdVUXZLVm5D?=
 =?gb2312?B?U0NOaEptSUhRQTJrLys5L0dxZXg2amVLL1NLaFVvbnhNelpZanh0ZVVHVHV2?=
 =?gb2312?B?c1p3UEcxZFRWQ2ZmOXFzb2pzSytBTHFqek1wd2hqS0lrcVYyWlcrWk40aUtK?=
 =?gb2312?B?VkdLaUxNbk44ZUFpZlB2WXp3V1c5TVJaMmJNbit2UkIvZG55R005T2w3WkVE?=
 =?gb2312?B?TDFoYVYwU05BbVIxV3FEVFpMV2E3b25qUytpK1ZoRkR3V2ZhOUdOOERHZzBI?=
 =?gb2312?B?S3U1OHg5cm1oVmdwL2RRTnI1YkhVNThXWFdBQ0JNelpBZ1BwRnowZUpjOTQv?=
 =?gb2312?B?NDE2R2VwcXMzNWNEVERoeTVCQzZ4dExUcjdUZWVLdDRLUWhTYXV5K3RPSjVv?=
 =?gb2312?B?UVRBZnFiM1pLWjd5ZjNFNUhSeEZSK1hhUU9Hakl2TnpMNlQycHBHcEN5dzhq?=
 =?gb2312?B?Nm5odE9sS2dCRUlCcjRFaDZ3cEpCMXVVUCtUWnZXenFUUU1GNWRPTnEyNkJw?=
 =?gb2312?B?ZWRlTG5GWHRKc1FGT3hXUEMxcEFoY3RPUjllM0p6ckZUeUkzSTVMYTFHS2tO?=
 =?gb2312?B?WDBMS0J6a1pNTTBicmlZbXNJZDFta2Nteks2VFRIS256RjdVcXM2VXZqR012?=
 =?gb2312?B?YnNqMWdvejZva3ltQ0FERnVzR0luZjAyS2QxZ2krdUdFYWtJODRZaWpBMzB3?=
 =?gb2312?B?TnJ0MUpPNmVLVW94UzdGbDJkNmpqU0I5ZEVsaXlza3Z6Q2xiNnl2eTJld1dK?=
 =?gb2312?B?RTNibHlvd0JUTUJzcG9jbHFsVnRkWW1QTVBjTWlPQXNlOTB2QnZjanpxZkRo?=
 =?gb2312?B?NHZBa1dzWjA0Y3FoWEI2R0dFS1p5THpDSDBTb0l6ZEU3eDhQWE5YV1M5K2F1?=
 =?gb2312?B?ckk2T3BRbUNRNmN3QXNOS3I2NXF4TDhWOXc2YnM0a0pTQzF2VFJ3aW56MHlV?=
 =?gb2312?B?YmZlaDZRK2lhVDl0VTQzakxTZGlRYU9qUXVNNHBock1heUZwd0FKSEVVTjkx?=
 =?gb2312?B?azBycXVUSmgyV3lpTnZiaVFGWjVKQk9aR3JydzRTMGU5V0RZREFMdjhvcTJO?=
 =?gb2312?B?N2N4RGs4WkdoUnU2QkRpTk5vREZlN3g0dmZJcTFWNkFSUGNzNnJLeEZ1Zk51?=
 =?gb2312?B?V2kxZ2JoekQwV2lDeWR1RUpHNGNPMXhJOEN3SWYzaFRMbE1BbHJCMGJvZy9U?=
 =?gb2312?B?cjlnZEY5WFhRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7053199007)(38070700018)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WmRLKzNkYUxYUWgxT3VoOU9oL01WdVJ6VGU2TERFV3lUT0E2RGpzd2hIcVY4?=
 =?gb2312?B?dHI2MGhFYXFSR2Q2UFdMZU1QalZTUi9IZHkxTEJjY2hvUGFsdmUzN0U5ZE9z?=
 =?gb2312?B?dENJaWxjc296TmtjM1FwTGVSaXNYZ3owTTJaYmNHSDBOVExLUFpmbERBRmFm?=
 =?gb2312?B?THJRM2gvY05CNmMyNHJlV0haT3RXaGdiOWdEMCtqdHFQblJlRnkyVFdjTDVQ?=
 =?gb2312?B?MEtzWEYrVnpjTDdYVjFXS2ZkTkpBWnBHWGpURGR0cVZqT08yMCs4NEF4NzRG?=
 =?gb2312?B?eGxUZ2FBQjRjWWkvM0dIbmdGWitucHVLMWo4Ni9OUDg0U05SNW1iZ2FUUXQ3?=
 =?gb2312?B?b2tQc2FjWWh5M3UyL3h5amt1dmRnMGREOGJuUEZuV09RYlZQb1V4Q1NFZkJ5?=
 =?gb2312?B?VGJVSFpMYVlOYTNCV0Y3VWV6ZDZvOHhTL2Jnd1NjTURKT2R5cWM3MmJPUDNY?=
 =?gb2312?B?MkQrbXh4M1ZqekhvemNyT2NuMnpXc3RTcDVZbFNnMmVrcG5FTk1yM2g0eFds?=
 =?gb2312?B?aytOUkdlbGVTVUNISVpNMjV2cEVUTmZHczcwb3YvSXNSU25tSnRQNU9YYzJR?=
 =?gb2312?B?R3pYdC9iR1RxVXV3cnVQcTlpemoyZmZZSkdGaVFyMTc2RHZ5emo0TVMrUFVQ?=
 =?gb2312?B?NldTbFhtSksvQU9vTi9KSXlwaTMvTUNNV2dNeVQySmlZcXYvOGh4Qm9ZZjhY?=
 =?gb2312?B?YmFRaGczUWt4bjVqUHlMbktIRTdyMmhoMVlyb3dXcU1lNXdVcjErckJ2RkRk?=
 =?gb2312?B?cnQ2dnFBQTVJOHZJZEh5MmQ3bTdCZHdMeWUzbVp5K3NndE5wcUdVZXczd24z?=
 =?gb2312?B?SWljOTBSNXMwS2o5bEk2SlZscFlWUGpReXJsL3JhMkRUZElIQkRYSnl3ZW5F?=
 =?gb2312?B?aHNyVytRYjZGdWZYOGZCVzFqaWJHeWJBN2I3NlI0M2tUdEx4MTZleW5QeDhi?=
 =?gb2312?B?T0xRNllZaFZpLzZGVlhveEN5Z1dnaU1OWm9wdWNoNHkrZVJ1cXhOckF3WWtZ?=
 =?gb2312?B?ZjFZOElOT1RuTHQ4cDB1elpNUytabElicEJQTlFvZXdCTE1zQ2xpNHlxV0dN?=
 =?gb2312?B?WGVsQkJyT2lGNkU3NWJUei9ydEFBVjRSNG9UaGlyMi9EcnozZUlZNzBEMnRu?=
 =?gb2312?B?T3dwdzRJR2tOVk12a25lVFIxa1VqL09RMUxOc3dzb01YK3BGYmp2TTdpQkVw?=
 =?gb2312?B?MjNjbHlBWkcwUS9yVEtoVkpwUTh1dmw1SG9RMG1GT1FXei9UTEk0dzBBWlQ2?=
 =?gb2312?B?OGl0NWFjTHQxSFc3SnZ5ZnNwclIyRTdLSEdHWXVFK2duaHRBdkJGZVNCTE5H?=
 =?gb2312?B?dy91a2dJTjJLZFQ0OXF2VnJYckVMcFN0dmU3VHYxQU5IdGpudXI5eFNkaDEy?=
 =?gb2312?B?NFk0a1VDYTNQVjB5bkVoRlkxTU83STIwR0VzUUpQRTFEemtMM2kzOHlMWE1W?=
 =?gb2312?B?NWJiQzF1MEFCM0NNN3hvUmRXaTRsaHljejdKQ04rSFc5Y3FzY25tSFFoSVZY?=
 =?gb2312?B?cTBLSzhyNWcwTFgzWnE0UnhtYkd3Wi9CeGtldThOVmZNeXFZSlN2UHE3bGQ3?=
 =?gb2312?B?dTRGZEprRWlzR0pLTnl0MnpaSmlreUNIRkx0OUV5OUJuaVJYdUpoZlN2V29H?=
 =?gb2312?B?a2xlME4wK3BDV1hHSnZ4VEdQTXVkNElLZUNCcUQrdnR4bEs0MHlHN29VK2VZ?=
 =?gb2312?B?NzNFR2g2bDBCb25MZjd4dlQ1bm9OelUyVmhGVUUrOW43ZjF6QVN2NWM1R1I4?=
 =?gb2312?B?cjVkb3NtUHdBU2J5SmlibFZiL1pUaFBERG9TeThETVRWaFVNTlBuWVd5MStW?=
 =?gb2312?B?QUdOYmFuR2xrWU5kM3FuaWVIYnZYSXhxT0p3dVhHRWx2Z0ppeFpPS21Wb0o3?=
 =?gb2312?B?VGFkSXNTdWMxeHJGb01ua29MblBQeWJIQ21RODNhSlRTMURlaEJDL050UUFT?=
 =?gb2312?B?S2huNmZXR1FncUxqV1BOdkVWTU0xa3JjRmF2MVkyOHBhSlVoTEtmVWhTQUdI?=
 =?gb2312?B?Um1obkVQd0Rac1RWbllwVkY4SVZJNHBIYTFNWXRZZ0gvaW5PUnQxUXNoa1lX?=
 =?gb2312?B?dyswd0dUK2tvalJYSjVNRGx5dVVwMnN0ZG9pdHdzSStheVB2dHRpV0NVUEJ2?=
 =?gb2312?B?NThoRXVZa1ZDNm5mSmpOc3dkVjM1TWY0S0JEWnZEZXVRVFBIUHFtQ0R5RXdW?=
 =?gb2312?Q?f2jmVg7E6IEosF6N75pgw3K0UncvJCNnrm28FX6cefiv?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB5997EAA3BAA43D3F72CF36C7822FAPH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee51d6c-50ef-478f-8c43-08ddd638e884
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 05:03:26.3459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wzdRTiz9t6fMNYFnU+I0+/sirgOxbLFCQxJuW5wpXYaWNuqCP5k2Bt1ebT8gsIj7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7636
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

--_000_PH7PR12MB5997EAA3BAA43D3F72CF36C7822FAPH7PR12MB5997namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KUmV2aWV3ZWQtYnk6IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IExhemFyLCBMaWpvIDxMaWpvLkxh
emFyQGFtZC5jb20+DQq3osvNyrG85DogRnJpZGF5LCBBdWd1c3QgOCwgMjAyNSAxMjo1ODo1NSBQ
TQ0KytW8/sjLOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyA8YW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc+DQqzrcvNOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQu
Y29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgU3Vu
LCBDZShPdmVybG9yZCkgPENlLlN1bkBhbWQuY29tPjsgV2FuZywgWWFuZyhLZXZpbikgPEtldmlu
WWFuZy5XYW5nQGFtZC5jb20+DQrW98ziOiBbUEFUQ0ggdjRdIGRybS9hbWRncHU6IFNhdmUgYW5k
IHJlc3RvcmUgc3dpdGNoIHN0YXRlDQoNCkR1cmluZyBhIERQQyBlcnJvciBrZXJuZWwgd2FpdHMg
Zm9yIHRoZSBsaW5rIHRvIGJlIGFjdGl2ZSBiZWZvcmUNCm5vdGlmeWluZyBkb3duc3RyZWFtIGRl
dmljZXMuIE9uIGNlcnRhaW4gcGxhdGZvcm1zIHdpdGggQnJvYWRjb20gc3dpdGNoDQppbiBzeW50
aGV0aWljIG1vZGUsIHN3aXRjaCByZXNwb25kcyB3aXRoIHZhbHVlcyBldmVuIHRob3VnaCB0aGUg
bGluayBpcw0Kbm90IGZ1bGx5IHJlYWR5LiBUaGUgY29uZmlnIHNwYWNlIHJlc3RvcmF0aW9uIGRv
bmUgYnkgcGNpZSBwb3J0IGRyaXZlcg0KZm9yIFNXVVMvRFMgb2YgZEdQVSBpcyB0aHVzIG5vdCBl
ZmZlY3RpdmUgYXMgdGhlIHN3aXRjaCBpcyBzdGlsbCBkb2luZw0KaW50ZXJuYWwgZW51bWVyYXRp
b24uDQoNCkFzIGEgd29ya2Fyb3VuZCwgc2F2ZSBzdGF0ZSBvZiBTV1VTL0RTIGRldmljZSBpbiBk
cml2ZXIuIEFkZCBhZGRpdGlvbmFsDQpjaGVjayB0byBzZWUgaWYgbGluayBpcyBhY3RpdmUgYW5k
IHJlc3RvcmUgdGhlIHZhbHVlcyBkdXJpbmcgRFBDIGVycm9yDQpjYWxsYmFja3MuDQoNClNpZ25l
ZC1vZmYtYnk6IExpam8gTGF6YXIgPGxpam8ubGF6YXJAYW1kLmNvbT4NCi0tLQ0KDQp2MjogVXNl
IHVzbGVlcF9yYW5nZSBhcyBzbGVlcCBpcyBzaG9ydC4gUmVtb3ZlIGRldl9pbmZvIGxvZ3MuDQp2
MzogcmVtb3ZlIHJlZHVuZGFudCBpbmNyZW1lbnQgb2YgJ2knIGluIGxvb3AgKENlIFN1bikuDQp2
NDogQWRkIHRpbWVvdXQgZm9yIHdhaXQgKEtldmluIFdhbmcpDQoNCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHUuaCAgICAgICAgfCAgMyArDQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jIHwgODUgKysrKysrKysrKysrKysrKysrKystLQ0KIDIgZmls
ZXMgY2hhbmdlZCwgODMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1LmgNCmluZGV4IGU0ZWNjZTFjNDE5Ni4uYzhmZTNlMzRlNzg0IDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQpAQCAtOTE4LDYgKzkxOCw5IEBAIHN0
cnVjdCBhbWRncHVfcGNpZV9yZXNldF9jdHggew0KICAgICAgICAgYm9vbCBpbl9saW5rX3Jlc2V0
Ow0KICAgICAgICAgYm9vbCBvY2N1cnNfZHBjOw0KICAgICAgICAgYm9vbCBhdWRpb19zdXNwZW5k
ZWQ7DQorICAgICAgIHN0cnVjdCBwY2lfZGV2ICpzd3VzOw0KKyAgICAgICBzdHJ1Y3QgcGNpX3Nh
dmVkX3N0YXRlICpzd3VzX3BjaXN0YXRlOw0KKyAgICAgICBzdHJ1Y3QgcGNpX3NhdmVkX3N0YXRl
ICpzd2RzX3BjaXN0YXRlOw0KIH07DQoNCiAvKg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYw0KaW5kZXggMjY3MDZmYWIwZGU5Li4wZThjMTdmMzI4ZTUgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KQEAgLTE3OCw2ICsx
NzgsOCBAQCBzdHJ1Y3QgYW1kZ3B1X2luaXRfbGV2ZWwgYW1kZ3B1X2luaXRfbWluaW1hbF94Z21p
ID0gew0KICAgICAgICAgICAgICAgICBCSVQoQU1EX0lQX0JMT0NLX1RZUEVfUFNQKQ0KIH07DQoN
CitzdGF0aWMgdm9pZCBhbWRncHVfZGV2aWNlX2xvYWRfc3dpdGNoX3N0YXRlKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KTsNCisNCiBzdGF0aWMgaW5saW5lIGJvb2wgYW1kZ3B1X2lwX21lbWJl
cl9vZl9od2luaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnVtIGFtZF9pcF9ibG9ja190eXBlIGJsb2Nr
KQ0KIHsNCkBAIC01MDI3LDcgKzUwMjksOCBAQCB2b2lkIGFtZGdwdV9kZXZpY2VfZmluaV9zdyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiAgICAgICAgIGFkZXYtPnJlc2V0X2RvbWFpbiA9
IE5VTEw7DQoNCiAgICAgICAgIGtmcmVlKGFkZXYtPnBjaV9zdGF0ZSk7DQotDQorICAgICAgIGtm
cmVlKGFkZXYtPnBjaWVfcmVzZXRfY3R4LnN3ZHNfcGNpc3RhdGUpOw0KKyAgICAgICBrZnJlZShh
ZGV2LT5wY2llX3Jlc2V0X2N0eC5zd3VzX3BjaXN0YXRlKTsNCiB9DQoNCiAvKioNCkBAIC02OTg1
LDE2ICs2OTg4LDM0IEBAIHBjaV9lcnNfcmVzdWx0X3QgYW1kZ3B1X3BjaV9zbG90X3Jlc2V0KHN0
cnVjdCBwY2lfZGV2ICpwZGV2KQ0KICAgICAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKnRtcF9h
ZGV2Ow0KICAgICAgICAgc3RydWN0IGFtZGdwdV9oaXZlX2luZm8gKmhpdmU7DQogICAgICAgICBz
dHJ1Y3QgbGlzdF9oZWFkIGRldmljZV9saXN0Ow0KLSAgICAgICBpbnQgciA9IDAsIGk7DQorICAg
ICAgIHN0cnVjdCBwY2lfZGV2ICpsaW5rX2RldjsNCisgICAgICAgaW50IHIgPSAwLCBpLCB0aW1l
b3V0Ow0KICAgICAgICAgdTMyIG1lbXNpemU7DQorICAgICAgIHUxNiBzdGF0dXM7DQoNCiAgICAg
ICAgIGRldl9pbmZvKGFkZXYtPmRldiwgIlBDSSBlcnJvcjogc2xvdCByZXNldCBjYWxsYmFjayEh
XG4iKTsNCg0KICAgICAgICAgbWVtc2V0KCZyZXNldF9jb250ZXh0LCAwLCBzaXplb2YocmVzZXRf
Y29udGV4dCkpOw0KDQotICAgICAgIC8qIHdhaXQgZm9yIGFzaWMgdG8gY29tZSBvdXQgb2YgcmVz
ZXQgKi8NCi0gICAgICAgbXNsZWVwKDcwMCk7DQorICAgICAgIGlmIChhZGV2LT5wY2llX3Jlc2V0
X2N0eC5zd3VzKQ0KKyAgICAgICAgICAgICAgIGxpbmtfZGV2ID0gYWRldi0+cGNpZV9yZXNldF9j
dHguc3d1czsNCisgICAgICAgZWxzZQ0KKyAgICAgICAgICAgICAgIGxpbmtfZGV2ID0gYWRldi0+
cGRldjsNCisgICAgICAgLyogd2FpdCBmb3IgYXNpYyB0byBjb21lIG91dCBvZiByZXNldCwgdGlt
ZW91dCA9IDEwcyAqLw0KKyAgICAgICB0aW1lb3V0ID0gMTAwMDA7DQorICAgICAgIGRvIHsNCisg
ICAgICAgICAgICAgICB1c2xlZXBfcmFuZ2UoMTAwMDAsIDEwNTAwKTsNCisgICAgICAgICAgICAg
ICByID0gcGNpX3JlYWRfY29uZmlnX3dvcmQobGlua19kZXYsIFBDSV9WRU5ET1JfSUQsICZzdGF0
dXMpOw0KKyAgICAgICAgICAgICAgIHRpbWVvdXQgLT0gMTA7DQorICAgICAgIH0gd2hpbGUgKHRp
bWVvdXQgPiAwICYmIChzdGF0dXMgIT0gUENJX1ZFTkRPUl9JRF9BVEkpICYmDQorICAgICAgICAg
ICAgICAgIChzdGF0dXMgIT0gUENJX1ZFTkRPUl9JRF9BTUQpKTsNCg0KKyAgICAgICBpZiAoKHN0
YXR1cyAhPSBQQ0lfVkVORE9SX0lEX0FUSSkgJiYgKHN0YXR1cyAhPSBQQ0lfVkVORE9SX0lEX0FN
RCkpIHsNCisgICAgICAgICAgICAgICByID0gLUVUSU1FOw0KKyAgICAgICAgICAgICAgIGdvdG8g
b3V0Ow0KKyAgICAgICB9DQorDQorICAgICAgIGFtZGdwdV9kZXZpY2VfbG9hZF9zd2l0Y2hfc3Rh
dGUoYWRldik7DQogICAgICAgICAvKiBSZXN0b3JlIFBDSSBjb25mc3BhY2UgKi8NCiAgICAgICAg
IGFtZGdwdV9kZXZpY2VfbG9hZF9wY2lfc3RhdGUocGRldik7DQoNCkBAIC03MDk2LDYgKzcxMTcs
NTggQEAgdm9pZCBhbWRncHVfcGNpX3Jlc3VtZShzdHJ1Y3QgcGNpX2RldiAqcGRldikNCiAgICAg
ICAgIH0NCiB9DQoNCitzdGF0aWMgdm9pZCBhbWRncHVfZGV2aWNlX2NhY2hlX3N3aXRjaF9zdGF0
ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCit7DQorICAgICAgIHN0cnVjdCBwY2lfZGV2
ICpwYXJlbnQgPSBwY2lfdXBzdHJlYW1fYnJpZGdlKGFkZXYtPnBkZXYpOw0KKyAgICAgICBpbnQg
cjsNCisNCisgICAgICAgaWYgKHBhcmVudC0+dmVuZG9yICE9IFBDSV9WRU5ET1JfSURfQVRJKQ0K
KyAgICAgICAgICAgICAgIHJldHVybjsNCisNCisgICAgICAgLyogSWYgYWxyZWFkeSBzYXZlZCwg
cmV0dXJuICovDQorICAgICAgIGlmIChhZGV2LT5wY2llX3Jlc2V0X2N0eC5zd3VzKQ0KKyAgICAg
ICAgICAgICAgIHJldHVybjsNCisgICAgICAgLyogVXBzdHJlYW0gYnJpZGdlIGlzIEFUSSwgYXNz
dW1lIGl0J3MgU1dVUy9EUyBhcmNoaXRlY3R1cmUgKi8NCisgICAgICAgciA9IHBjaV9zYXZlX3N0
YXRlKHBhcmVudCk7DQorICAgICAgIGlmIChyKQ0KKyAgICAgICAgICAgICAgIHJldHVybjsNCisg
ICAgICAgYWRldi0+cGNpZV9yZXNldF9jdHguc3dkc19wY2lzdGF0ZSA9IHBjaV9zdG9yZV9zYXZl
ZF9zdGF0ZShwYXJlbnQpOw0KKw0KKyAgICAgICBwYXJlbnQgPSBwY2lfdXBzdHJlYW1fYnJpZGdl
KHBhcmVudCk7DQorICAgICAgIHIgPSBwY2lfc2F2ZV9zdGF0ZShwYXJlbnQpOw0KKyAgICAgICBp
ZiAocikNCisgICAgICAgICAgICAgICByZXR1cm47DQorICAgICAgIGFkZXYtPnBjaWVfcmVzZXRf
Y3R4LnN3dXNfcGNpc3RhdGUgPSBwY2lfc3RvcmVfc2F2ZWRfc3RhdGUocGFyZW50KTsNCisNCisg
ICAgICAgYWRldi0+cGNpZV9yZXNldF9jdHguc3d1cyA9IHBhcmVudDsNCit9DQorDQorc3RhdGlj
IHZvaWQgYW1kZ3B1X2RldmljZV9sb2FkX3N3aXRjaF9zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikNCit7DQorICAgICAgIHN0cnVjdCBwY2lfZGV2ICpwZGV2Ow0KKyAgICAgICBpbnQg
cjsNCisNCisgICAgICAgaWYgKCFhZGV2LT5wY2llX3Jlc2V0X2N0eC5zd2RzX3BjaXN0YXRlIHx8
DQorICAgICAgICAgICAhYWRldi0+cGNpZV9yZXNldF9jdHguc3d1c19wY2lzdGF0ZSkNCisgICAg
ICAgICAgICAgICByZXR1cm47DQorDQorICAgICAgIHBkZXYgPSBhZGV2LT5wY2llX3Jlc2V0X2N0
eC5zd3VzOw0KKyAgICAgICByID0gcGNpX2xvYWRfc2F2ZWRfc3RhdGUocGRldiwgYWRldi0+cGNp
ZV9yZXNldF9jdHguc3d1c19wY2lzdGF0ZSk7DQorICAgICAgIGlmICghcikgew0KKyAgICAgICAg
ICAgICAgIHBjaV9yZXN0b3JlX3N0YXRlKHBkZXYpOw0KKyAgICAgICB9IGVsc2Ugew0KKyAgICAg
ICAgICAgICAgIGRldl93YXJuKGFkZXYtPmRldiwgIkZhaWxlZCB0byBsb2FkIFNXVVMgc3RhdGUs
IGVycjolZFxuIiwgcik7DQorICAgICAgICAgICAgICAgcmV0dXJuOw0KKyAgICAgICB9DQorDQor
ICAgICAgIHBkZXYgPSBwY2lfdXBzdHJlYW1fYnJpZGdlKGFkZXYtPnBkZXYpOw0KKyAgICAgICBy
ID0gcGNpX2xvYWRfc2F2ZWRfc3RhdGUocGRldiwgYWRldi0+cGNpZV9yZXNldF9jdHguc3dkc19w
Y2lzdGF0ZSk7DQorICAgICAgIGlmICghcikNCisgICAgICAgICAgICAgICBwY2lfcmVzdG9yZV9z
dGF0ZShwZGV2KTsNCisgICAgICAgZWxzZQ0KKyAgICAgICAgICAgICAgIGRldl93YXJuKGFkZXYt
PmRldiwgIkZhaWxlZCB0byBsb2FkIFNXRFMgc3RhdGUsIGVycjolZFxuIiwgcik7DQorfQ0KKw0K
IGJvb2wgYW1kZ3B1X2RldmljZV9jYWNoZV9wY2lfc3RhdGUoc3RydWN0IHBjaV9kZXYgKnBkZXYp
DQogew0KICAgICAgICAgc3RydWN0IGRybV9kZXZpY2UgKmRldiA9IHBjaV9nZXRfZHJ2ZGF0YShw
ZGV2KTsNCkBAIC03MTIwLDYgKzcxOTMsOCBAQCBib29sIGFtZGdwdV9kZXZpY2VfY2FjaGVfcGNp
X3N0YXRlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KICAgICAgICAgICAgICAgICByZXR1cm4gZmFs
c2U7DQogICAgICAgICB9DQoNCisgICAgICAgYW1kZ3B1X2RldmljZV9jYWNoZV9zd2l0Y2hfc3Rh
dGUoYWRldik7DQorDQogICAgICAgICByZXR1cm4gdHJ1ZTsNCiB9DQoNCkBAIC03NTU1LDQgKzc2
MzAsNCBAQCB1NjQgYW1kZ3B1X2RldmljZV9nZXRfdWlkKHN0cnVjdCBhbWRncHVfdWlkICp1aWRf
aW5mbywNCiAgICAgICAgIH0NCg0KICAgICAgICAgcmV0dXJuIHVpZF9pbmZvLT51aWRbdHlwZV1b
aW5zdF07DQotfQ0KXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlDQorfQ0KLS0NCjIuNDkuMA0K
DQo=

--_000_PH7PR12MB5997EAA3BAA43D3F72CF36C7822FAPH7PR12MB5997namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"ltr" style=3D"font-family: Aptos, -apple-system, HelveticaNeue,=
 sans-serif; font-size: 12pt;">
Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div>
<div id=3D"ms-outlook-mobile-body-separator-line" style=3D"font-family: Apt=
os, -apple-system, HelveticaNeue, sans-serif;font-size: 12pt" dir=3D"ltr">
<span style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robo=
to, Arial, Helvetica, sans-serif; font-size: 12pt;"></span></div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"ltr"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> Lazar, =
Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> Friday, August 8, 2025 12:58:55 PM<br>
<b>=CA=D5=BC=FE=C8=CB:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.=
freedesktop.org&gt;<br>
<b>=B3=AD=CB=CD:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher,=
 Alexander &lt;Alexander.Deucher@amd.com&gt;; Sun, Ce(Overlord) &lt;Ce.Sun@=
amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;<br>
<b>=D6=F7=CC=E2:</b> [PATCH v4] drm/amdgpu: Save and restore switch state</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">During a DPC error kernel waits for the link to be=
 active before<br>
notifying downstream devices. On certain platforms with Broadcom switch<br>
in synthetiic mode, switch responds with values even though the link is<br>
not fully ready. The config space restoration done by pcie port driver<br>
for SWUS/DS of dGPU is thus not effective as the switch is still doing<br>
internal enumeration.<br>
<br>
As a workaround, save state of SWUS/DS device in driver. Add additional<br>
check to see if link is active and restore the values during DPC error<br>
callbacks.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
<br>
v2: Use usleep_range as sleep is short. Remove dev_info logs.<br>
v3: remove redundant increment of 'i' in loop (Ce Sun).<br>
v4: Add timeout for wait (Kevin Wang)<br>
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 3 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 85 ++++++++++++++++++++-=
-<br>
&nbsp;2 files changed, 83 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index e4ecce1c4196..c8fe3e34e784 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -918,6 +918,9 @@ struct amdgpu_pcie_reset_ctx {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool in_link_reset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool occurs_dpc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool audio_suspended;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev *swus;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_saved_state *swus_pcistate=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_saved_state *swds_pcistate=
;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;/*<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 26706fab0de9..0e8c17f328e5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -178,6 +178,8 @@ struct amdgpu_init_level amdgpu_init_minimal_xgmi =3D {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; BIT(AMD_IP_BLOCK_TYPE_PSP)<br>
&nbsp;};<br>
&nbsp;<br>
+static void amdgpu_device_load_switch_state(struct amdgpu_device *adev);<b=
r>
+<br>
&nbsp;static inline bool amdgpu_ip_member_of_hwini(struct amdgpu_device *ad=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_ip_block_type block)=
<br>
&nbsp;{<br>
@@ -5027,7 +5029,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_domain =3D =
NULL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pci_state);=
<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pcie_reset_ctx.swds_pc=
istate);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;pcie_reset_ctx.swus_pc=
istate);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
@@ -6985,16 +6988,34 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_d=
ev *pdev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *tmp_=
adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *h=
ive;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head device_li=
st;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0, i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev *link_dev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0, i, timeout;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 memsize;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 status;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &qu=
ot;PCI error: slot reset callback!!\n&quot;);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;reset_context,=
 0, sizeof(reset_context));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* wait for asic to come out of reset=
 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(700);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pcie_reset_ctx.swus)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; link_dev =3D adev-&gt;pcie_reset_ctx.swus;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; link_dev =3D adev-&gt;pdev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* wait for asic to come out of reset=
, timeout =3D 10s */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D 10000;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; usleep_range(10000, 10500);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D pci_read_config_word(link_dev, PCI_VENDOR_ID, &amp;status)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; timeout -=3D 10;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (timeout &gt; 0 &amp;&amp; (s=
tatus !=3D PCI_VENDOR_ID_ATI) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (status !=3D PCI_VENDOR_ID_AMD));<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((status !=3D PCI_VENDOR_ID_ATI) &=
amp;&amp; (status !=3D PCI_VENDOR_ID_AMD)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D -ETIME;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_load_switch_state(adev)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Restore PCI confspace *=
/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_load_pci_sta=
te(pdev);<br>
&nbsp;<br>
@@ -7096,6 +7117,58 @@ void amdgpu_pci_resume(struct pci_dev *pdev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
+static void amdgpu_device_cache_switch_state(struct amdgpu_device *adev)<b=
r>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev *parent =3D pci_upstre=
am_bridge(adev-&gt;pdev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (parent-&gt;vendor !=3D PCI_VENDOR=
_ID_ATI)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If already saved, return */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pcie_reset_ctx.swus)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Upstream bridge is ATI, assume it'=
s SWUS/DS architecture */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pci_save_state(parent);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pcie_reset_ctx.swds_pcistate=
 =3D pci_store_saved_state(parent);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; parent =3D pci_upstream_bridge(parent=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pci_save_state(parent);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pcie_reset_ctx.swus_pcistate=
 =3D pci_store_saved_state(parent);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pcie_reset_ctx.swus =3D pare=
nt;<br>
+}<br>
+<br>
+static void amdgpu_device_load_switch_state(struct amdgpu_device *adev)<br=
>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev *pdev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pcie_reset_ctx.swds_pci=
state ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;pci=
e_reset_ctx.swus_pcistate)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdev =3D adev-&gt;pcie_reset_ctx.swus=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pci_load_saved_state(pdev, adev=
-&gt;pcie_reset_ctx.swus_pcistate);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pci_restore_state(pdev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Failed to load SWUS state, err:%d\n=
&quot;, r);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdev =3D pci_upstream_bridge(adev-&gt=
;pdev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D pci_load_saved_state(pdev, adev=
-&gt;pcie_reset_ctx.swds_pcistate);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pci_restore_state(pdev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Failed to load SWDS state, err:%d\n=
&quot;, r);<br>
+}<br>
+<br>
&nbsp;bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D=
 pci_get_drvdata(pdev);<br>
@@ -7120,6 +7193,8 @@ bool amdgpu_device_cache_pci_state(struct pci_dev *pd=
ev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_cache_switch_state(adev=
);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -7555,4 +7630,4 @@ u64 amdgpu_device_get_uid(struct amdgpu_uid *uid_info=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return uid_info-&gt;uid[ty=
pe][inst];<br>
-}<br>
\ No newline at end of file<br>
+}<br>
-- <br>
2.49.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH7PR12MB5997EAA3BAA43D3F72CF36C7822FAPH7PR12MB5997namp_--
