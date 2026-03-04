Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A51EDEC14
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 06:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1DA110E5A1;
	Wed,  4 Mar 2026 06:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gtXiypbU";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1460510E5A1
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 06:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFTh3IWVqnieYPCgA24hKA3hk4pdZA5ecH7Y8dHf6dzrhwO1G2uuwcLeSCD/CImlCccPSFIiNhFnJXMsY9zUa/On7rR3wnJn4GyPbMXPIbWV/auuCxYSzk58tkIyqWMS2O4aviofAJtxtSHN1Z5PzXeVrh2uASLHjE5qDbbHG3Gi7po80vssCYOpXfte2cTVpKebNNP6P0OFxQACeFNR/A2L6J2vWmGBijmgyVI7NNtZ2uST2oZL0oItjcsIHRzPsDuBGnjjUzkFkgrYs4RSrA+MwgSIGQY/IEkmAjW3/98KGU90aqtYMpftlzjHmEZ+FbeVbn2Uthlkco7Xoh3Xww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDscGiZqO2ffINjuYYWMfTJ1O568Za6eSUOoG13DdPQ=;
 b=G9Ud8fC+tZz2t9SELrOkV+cOMbzvdNAGWR19KUxWfftqzNtAkd5B6Qs5lUfhnySPGenrWGs6KEOItD64WV8Qvw9hIA6cNMA+lS4Bb0JKsU39/0CwxJLZH7prwLooyJL5dPdjUfpYCL0EgZYwOb1rSPZ+qpj7TGbFFRnRwUdQkfKHtAO3wLxhvPKIOL6PfBY5pAMckvvHe6UFkvQik2V+inHoih64SnqXCmc1mOJY2c2+aiO+z/YIlL/VKjiWn3aYEC2od2HD3qoyfjPcMjsuVfdxUGPjTCFvSUJrPzBU2Hmqa0NAFkd0q+ST3MzlOf+soN2pbgANuKyuAOwMm9yVOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDscGiZqO2ffINjuYYWMfTJ1O568Za6eSUOoG13DdPQ=;
 b=gtXiypbUV3gxPcScTypNHk3F55OrzqXtBtW/1r4IR0j92feg33YeLtFYwupuudlV8GXA7c8gYpN5FuatWGACjAdkBT6VU/drRtqS+khKm2v+g4RF7Qk17Lmunu+Dd0XTCMdgiVTBzKbDISTslsl45IccbS489uQGBfLBm8nbkp4=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 06:14:27 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 06:14:27 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: add missing od setting
 PP_OD_FEATURE_ZERO_FAN_BIT for smu v13
Thread-Topic: [PATCH 1/2] drm/amd/pm: add missing od setting
 PP_OD_FEATURE_ZERO_FAN_BIT for smu v13
Thread-Index: AQHcq4Fm8+OkFAoE5UK0CHEhBbrDtLWdsE6AgAAwUlA=
Date: Wed, 4 Mar 2026 06:14:27 +0000
Message-ID: <DM6PR12MB2972A6D3002D4824AE045B7A827CA@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260304024811.897237-1-kevinyang.wang@amd.com>
 <CADnq5_NhvdRV-GrnP+9DnTVK0zL2jNRsDrHM9XEYFM-bDaiLYQ@mail.gmail.com>
In-Reply-To: <CADnq5_NhvdRV-GrnP+9DnTVK0zL2jNRsDrHM9XEYFM-bDaiLYQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-04T05:57:44.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|LV8PR12MB9112:EE_
x-ms-office365-filtering-correlation-id: 42a6b8e2-f9f8-4c6d-1dfd-08de79b54a09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: RhmxhbLq16wbN8CWtmJUnzPA1TsGs1Sc1Ih3iMm4snFHe+0AIw+h1GMLVPKSMEvI60hDiitrBlrnFBnV7iIKyWdJpxfQRvSb6deMEfBdh9v2okuIvvgzjw0iloonMoONYLz/ghPQOtUkItehTqFevIoizdnhF51Pt8cShSRlCYqqAktTqvSIk8Nw0JJsszhiW5go8g2FEU5KtbGnlBIVkLgiSI4S9uct3mxuDzJe5FFI41uT/gsMC/+UO7ToQlEI/pwyb9SE6NgNhiM7Iulv/3RKh1QfPpDJwIe3d/MKfMsUC9VREBopyrfzYLKZcetmkIZQacfkRdS/gdu4WPW089zb8vUh7x0DaitZailjp0HDSbCGFYQfeRTuu+6KJQQ3Hay2IiyfiRmhyHYKswBmSyS4i3t+DE58n0b/lOpKEUsjOXlPBG341BkUmA7d1f522ETBSALJFveNnBzYxVE8w6SJr15K7RFg7dXRIOr0Peu8IQ7p2cWMG+j5mTf27ulvpLKisU4ItH8RlTyR9sGPe7gnTHuzEz3+GXI4r4Sfv2HUS1ecAn18U0OJchjkzAGQEqLpR9Tu8TK0ddxVKhZ0ZsRmRST1VxZfaervEPnwdhbiZNk+1qx9ZITi8GAsKDF4ctsmaUipz7UkLoICzLNFCehd/+JG+GKKp5pC6JPPD1/5oXs+Yq9Wk2lAh+wYzO0mAGxSLtnp4tXPkn3L0Llh4ZwL8fu0d/Fzp1Fn8lvuNtxi5Ezj/1DC+vsEJmeBWxfQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UElMYURXUElSWW1GZHV4UkRpa0NLMVZWZ2xPc0pDZ3hLVk43QUVzQ2pNTW1X?=
 =?utf-8?B?V2x2S0lCNjE1bGM1VlRxeFJWdFMwbUJJVE5XUlBCdXZ0TU1tMllUUExiVkRF?=
 =?utf-8?B?RHhxYVY1dVJwS2lPTEdKQ2F3RVExemxtdXZSOHdZcjlYLzdVUy9CRi83OVV5?=
 =?utf-8?B?NmtuNEFFRDB5QTN4UUgxZk0zcnBaWGFMMm9WWkt5V0VZaXByRWsrTjhXUXVI?=
 =?utf-8?B?V2NHSjduTGNtbXpSL3h5cWpkWGRnTVlrK1lxSnFkOTRTR0VRM3NBYWFlODFh?=
 =?utf-8?B?T2dnREpjVXFJall5Vk40REp5dWVvbUFnUnM0WVhTMGFpcE80aGNLMFMzTWVB?=
 =?utf-8?B?R3JHTjY1VnlmT1Z3Zm9wNUZrZXEvbjlwRWdQRklVaXczejZmZ05QdTVsd05U?=
 =?utf-8?B?aHE2dFpMeUF6SysrMk1FMitDM1hyL0lKTU5qV3plV2RvdmZsSW8rMnVYS2Nh?=
 =?utf-8?B?QXpQUXF3WE1hRWRyMEMwdXFsTUI4bTExNUR2UUxNRkl0bjMvVDNJUjFBMERG?=
 =?utf-8?B?ZVc1L1ZERG9URU1pMlpmNk9FWmNvZFZPaklNMG1NaE5xems2SEFuQndJK0hx?=
 =?utf-8?B?cktha0dpY25WeEVkZzVMaFN3VldCNlVlL0tmNGt4d2Z6d0FaTnRyS3k3VUZT?=
 =?utf-8?B?MDh6R3RHaWM1WUxXMFAraXc4NHg2ZGMvcTA1SEJKOG10QzRrRXc1NHo5U29I?=
 =?utf-8?B?a29WUGQ0S2RlZTZtM3F6NCtZWjlZZ3hYYnhyMjM2MmZjcEtueStMdVcybzkx?=
 =?utf-8?B?Rm5EMUVTaTlBaDhOaCtlaFFrbklyejNxNnprejFtMFQ1SXJWOGtuamhCUDhn?=
 =?utf-8?B?QVNZSlArcmQ0MkdncnZkUzZwcnBkVnp2Vm91VE5ad0svZFRDK2ZTclRXVi9O?=
 =?utf-8?B?cEU5ZElDSVg5OVdldDR2cm5meXNhNXBYbkw1NHhKSCsveXYyVGNTV1pWS2pi?=
 =?utf-8?B?OWxIYk9MNU1yYjJQeWFmS3RqN3VwZHA2dzFHVUpLdVNKS3lpZW9uL0g3QXcz?=
 =?utf-8?B?T3NwaTg3ekFUcjVrN0VmNDdBNUFjb1BvV3BhOTNmUUdDaXgzQ0FmTTFBY0ZR?=
 =?utf-8?B?MW1xc05aRXdqYktxa0pGTng0UEJTU3Q3RUhWL0w1bXlHWHROV1EvZDBONG0x?=
 =?utf-8?B?Vk9aQytPeGg3VmErY2hKMlcwMlZqZXVJR1R3KzU2UERSNEF1bFpYNFI2SlRy?=
 =?utf-8?B?WUlRRGRCSzZaejRNcExGb1B0OXJpMHJ1TWN3Tk1lZzNnNGYxVDlzSmdsaTQ0?=
 =?utf-8?B?NS9YTUMzOGVEeVNQUDAzaTNkclAvYWxVd21DUXIvWWgzOEpyTGQxMit0RURH?=
 =?utf-8?B?TCtTaytOVGJRdFFxTmNxaHU1VHkza3laVEY0UEVKUVp4WEw1TU9EMEtyZW4v?=
 =?utf-8?B?Ump1N0hRRFVDRlhkdG9HSU45NklsbUdNYVNkTlVyeSsrTnlwUytnZmZHUkI5?=
 =?utf-8?B?a3IyZWxmMmZvRDh6UitkSVhzNUltQXhiMkRETWNNa3B4WUNQWUdFbDZOelJL?=
 =?utf-8?B?dWFwa3JJakpZUlZjYStXUDhrZDB0MmtQZCtMY0dhL2lzSUJJVHl0bjVNM016?=
 =?utf-8?B?a1ExRmwxdlA0STEyS2ExeU91MUdTd013blRpRUpLK0RXbzdzUEN2Q2J6TGJF?=
 =?utf-8?B?dlE5R200MlpJWEZ6clNiTUFBeTltY29GM01RNHhRaVYzSDZNWnFvWGUyak92?=
 =?utf-8?B?NWIyNEU5YkNIeHJucitjRG0wWVQ3T3dXcUVqV2ZVK1l0WmNYbkVxeEtYUko0?=
 =?utf-8?B?Q29CWk40VHQ1OTk0bm5YOFVGRWpmMnl3SFNya0RheDFyN3pwNU1veWhjR29p?=
 =?utf-8?B?UVRZY2drMlB5MUIzTzdCNzdKQk9KbGxRbGlyZmZsSmJDYjVWK0JHV2dLT3FS?=
 =?utf-8?B?VE5hSkxsWjRjbHVyMU8ydlRTSHpMVXczWW4rTUR2ajlhTTRmZkRBbjdPUVpY?=
 =?utf-8?B?aWVVUjgwRzFZWEhtWVdVQWsvZFNhVjYvM21CanRJeVVpMi90K3RoVWVNQmk0?=
 =?utf-8?B?ZURWQ1V3aHZIWHJqdWg1ZTJhVXlyVjF6Mm80Z3BuZkZvYnZOc3JzQnE4RGQy?=
 =?utf-8?B?OUNROEdWbzFycmRnK2dhSk1Fczk2dUdVNTZVenpWeFBBMUVKdWIrTVNQZm5U?=
 =?utf-8?B?YVUrMitucnBQdWY5ZnUrK0hDTmFMVHlsYUdUekJCZlJldGlQbXUzaWxkLzk1?=
 =?utf-8?B?RTc4M3V6S0wrNGlLbE1HZUtBLytXaWhFK0xrV0xFaFZTOGYrTjdGTURudnhL?=
 =?utf-8?B?MDd4d3FGQUJEUlF4Zkk3R0pNWWRDOCtsYzR3dDVsNlFBektMKyt4cUZJRlY4?=
 =?utf-8?Q?utAj0k6qfsn6XH01jB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a6b8e2-f9f8-4c6d-1dfd-08de79b54a09
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 06:14:27.0998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/mQEqE6dLdtBTeMfidnHQaFY3K4SjN8PDR04BdNH3t1OkoFzZjHu6aj+S4N1y3l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112
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
Cg0KPj4gSXMgaXQgb2sgdG8gYWx3YXlzIHNldCB0aGVzZSwgb3Igc2hvdWxkIHRoZXkgb25seSBi
ZSByZXN0b3JlZCBiYXNlZCBvbiB0aGUgdXNlcidzIHNldHRpbmdzPyAgU2FtZSBxdWVzdGlvbiBm
b3IgdGhlIGV4aXN0aW5nIGZlYXR1cmUgYml0cy4NCmh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxk
cy9saW51eC9ibG9iL21hc3Rlci9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3Nt
dV92MTNfMF8wX3BwdC5jI0wxODcxDQogICAgICAgICAgICAgICAgLyoNCiAgICAgICAgICAgICAg
ICAgKiBUaGUgbWVtYmVyIGJlbG93IGluc3RydWN0cyBQTUZXIHRoZSBzZXR0aW5ncyBmb2N1c2Vk
IGluDQogICAgICAgICAgICAgICAgICogdGhpcyBzaW5nbGUgb3BlcmF0aW9uLg0KICAgICAgICAg
ICAgICAgICAqIGB1aW50MzJfdCBGZWF0dXJlQ3RybE1hc2s7YA0KICAgICAgICAgICAgICAgICAq
IEl0IGRvZXMgbm90IGNvbnRhaW4gYWN0dWFsIGluZm9ybWF0aW9ucyBhYm91dCB1c2VyJ3MgY3Vz
dG9tDQogICAgICAgICAgICAgICAgICogc2V0dGluZ3MuIFRodXMgd2UgZG8gbm90IGNhY2hlIGl0
Lg0KICAgICAgICAgICAgICAgICAqLw0KUGxlYXNlIGNoZWNrIGFib3ZlIGNvZGUgY29tbWVudHMg
Zmlyc3QuDQpBbmQgYWNjb3JkaW5nIHRvIHRoZSBjdXJyZW50IFBNRlcvT0QgZmVhdHVyZSBkZXNp
Z24sIGFsbCBPRCBmZWF0dXJlIHN3aXRjaCBpcyBub3QgbG9jYXRlZCBpbiAnRmVhdHVyZUN0cmxN
YXNrJy4NCklmIGEgY2VydGFpbiBiaXQgaXMgbm90IHNldCwgUE1GVyB3aWxsIG92ZXJ3cml0ZSB0
aGUgdmFsdWVzIGluIE9EIHVzaW5nIGVpdGhlciB0aGUgZGVmYXVsdCB2YWx1ZXMgaW4gJ0RlZmF1
bHQgT3ZlckRyaXZlclRhYmxlIGJ1aWx0LWluIFBNRlcnIG9yIHRoZSBQUFRhYmxlIHZhbHVlcy4N
CmFuZCBhbGwgT0QgYWN0dWFsIGluZm9ybWF0aW9uIGRhdGEgaGFzIGJlZW4gc2F2ZWQgaW4gdGhl
ICd1c2VyX29kX3RhYmxlJyBzdHJ1Y3R1cmUgYmVmb3JlIGVudGVyaW5nIFMzLg0KVGhlcmVmb3Jl
LCB0aGUgRHJpdmVyIGNhbiBzYWZlbHkgY29uZmlndXJlIHRoZXNlIE9EIEJJVE1BU0sgZGlyZWN0
bHkgd2l0aG91dCBhZGRpdGlvbmFsIGNoZWNrcyBpbiBvZCByZXN0b3JlIHN0YWdlLg0KDQpCZXN0
IFJlZ2FyZHMsDQpLZXZpbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxl
eCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQpTZW50OiBXZWRuZXNkYXksIE1hcmNo
IDQsIDIwMjYgMTE6MDUgQU0NClRvOiBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldhbmdA
YW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tp
bmcuWmhhbmdAYW1kLmNvbT47IEZlbmcsIEtlbm5ldGggPEtlbm5ldGguRmVuZ0BhbWQuY29tPg0K
U3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGRybS9hbWQvcG06IGFkZCBtaXNzaW5nIG9kIHNldHRp
bmcgUFBfT0RfRkVBVFVSRV9aRVJPX0ZBTl9CSVQgZm9yIHNtdSB2MTMNCg0KT24gVHVlLCBNYXIg
MywgMjAyNiBhdCA5OjQ44oCvUE0gWWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQuY29tPiB3
cm90ZToNCj4NCj4gYWRkIG1pc3Npbmcgb2Qgc2V0dGluZyBQUF9PRF9GRUFUVVJFX1pFUk9fRkFO
X0JJVCBmb3Igc211DQo+IHYxMy4wLjAvMTMuMC43DQo+DQo+IEZpeGVzOiBjZmZmZDk4MGJmMjEg
KCJkcm0vYW1kL3BtOiBhZGQgemVybyBSUE0gT0Qgc2V0dGluZyBzdXBwb3J0IGZvcg0KPiBTTVUx
MyIpDQo+IENsb3NlczogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9p
c3N1ZXMvNTAxOA0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFdhbmcgPGtldmlueWFuZy53YW5n
QGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9z
bXVfdjEzXzBfMF9wcHQuYyB8IDMgKystDQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211MTMvc211X3YxM18wXzdfcHB0LmMgfCAzICsrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF8wX3BwdC5jDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfMF9wcHQuYw0KPiBpbmRleCAzNWQz
NmYyZmU3ZGQuLjBhNzMwN2Y1ZWI0YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfMF9wcHQuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF8wX3BwdC5jDQo+IEBAIC0yMjIzLDcgKzIy
MjMsOCBAQCBzdGF0aWMgaW50IHNtdV92MTNfMF8wX3Jlc3RvcmVfdXNlcl9vZF9zZXR0aW5ncyhz
dHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkNCj4gICAgICAgICB1c2VyX29kX3RhYmxlLT5PdmVyRHJp
dmVUYWJsZS5GZWF0dXJlQ3RybE1hc2sgPSBCSVQoUFBfT0RfRkVBVFVSRV9HRlhDTEtfQklUKSB8
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgQklUKFBQX09EX0ZFQVRVUkVfVUNMS19CSVQpIHwNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVQoUFBfT0RfRkVBVFVSRV9HRlhf
VkZfQ1VSVkVfQklUKSB8DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQklUKFBQX09EX0ZFQVRVUkVfRkFOX0NVUlZFX0JJVCk7DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQklU
KFBQX09EX0ZFQVRVUkVfRkFOX0NVUlZFX0JJVCkgfA0KPiArDQo+ICsgQklUKFBQX09EX0ZFQVRV
UkVfWkVST19GQU5fQklUKTsNCg0KSXMgaXQgb2sgdG8gYWx3YXlzIHNldCB0aGVzZSwgb3Igc2hv
dWxkIHRoZXkgb25seSBiZSByZXN0b3JlZCBiYXNlZCBvbiB0aGUgdXNlcidzIHNldHRpbmdzPyAg
U2FtZSBxdWVzdGlvbiBmb3IgdGhlIGV4aXN0aW5nIGZlYXR1cmUgYml0cy4NCg0KQWxleA0KDQo+
ICAgICAgICAgcmVzID0gc211X3YxM18wXzBfdXBsb2FkX292ZXJkcml2ZV90YWJsZShzbXUsIHVz
ZXJfb2RfdGFibGUpOw0KPiAgICAgICAgIHVzZXJfb2RfdGFibGUtPk92ZXJEcml2ZVRhYmxlLkZl
YXR1cmVDdHJsTWFzayA9IDA7DQo+ICAgICAgICAgaWYgKHJlcyA9PSAwKQ0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYw0K
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzdfcHB0LmMN
Cj4gaW5kZXggNGY3MjlmNTRhNjRjLi5mYTIzZjNkNGEzZmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wXzdfcHB0LmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzBfN19wcHQuYw0KPiBA
QCAtMjIyNSw3ICsyMjI1LDggQEAgc3RhdGljIGludCBzbXVfdjEzXzBfN19yZXN0b3JlX3VzZXJf
b2Rfc2V0dGluZ3Moc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpDQo+ICAgICAgICAgdXNlcl9vZF90
YWJsZS0+T3ZlckRyaXZlVGFibGUuRmVhdHVyZUN0cmxNYXNrID0gQklUKFBQX09EX0ZFQVRVUkVf
R0ZYQ0xLX0JJVCkgfA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEJJVChQUF9PRF9GRUFUVVJFX1VDTEtfQklUKSB8DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQklUKFBQX09E
X0ZFQVRVUkVfR0ZYX1ZGX0NVUlZFX0JJVCkgfA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJJVChQUF9PRF9GRUFUVVJFX0ZBTl9DVVJW
RV9CSVQpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEJJVChQUF9PRF9GRUFUVVJFX0ZBTl9DVVJWRV9CSVQpIHwNCj4gKw0KPiArIEJJ
VChQUF9PRF9GRUFUVVJFX1pFUk9fRkFOX0JJVCk7DQo+ICAgICAgICAgcmVzID0gc211X3YxM18w
XzdfdXBsb2FkX292ZXJkcml2ZV90YWJsZShzbXUsIHVzZXJfb2RfdGFibGUpOw0KPiAgICAgICAg
IHVzZXJfb2RfdGFibGUtPk92ZXJEcml2ZVRhYmxlLkZlYXR1cmVDdHJsTWFzayA9IDA7DQo+ICAg
ICAgICAgaWYgKHJlcyA9PSAwKQ0KPiAtLQ0KPiAyLjQ3LjMNCj4NCg==
