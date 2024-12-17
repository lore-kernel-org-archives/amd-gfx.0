Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70910E7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2024 01:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 240F410E62D;
	Tue, 17 Dec 2024 01:06:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mnHdx7Nd";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D8C10E62D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2024 01:06:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLe9z9zti9F3TrwArsYp/5P7ibHBemheW0aC9w4ysKAW6gDT4pbbzqTYZqsKq9XB13hHsze9PbJWYlJTpBaZ4M2iAZjRSP2y5+nV3CSGgaWuwVqNRaOU3aWA6YpI7Ld1pwgLKPGy3sTNZZ6Mn/6F17hBscOoLuqzj/jhXWl1tijWV6r7bWca+lYT9GO2CdNP2uSSHiWcTIwGNM6GpUUkdn007B6W71ylG1/Zff4odG5AY8+m5zMyzTNboElRzL8wX2XSAJALyOxZIRYY/J6CC7vzSI1rwleV8aD755vesV1NRL25kdVMw6jOV6aNoLQrbn3cI9JjWsriidkIriwrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ktcd3ETopzvX4oiW25VHti7o5XYRE0DwKKnflWxylE=;
 b=FXyQe7DxZLXpM6X1pPobwcgMMxaXgtuXwmZ3M9mgcWqNrvpZjdzbt/TnBb/Fu6ZN095d2k4C6spk2VtDYOJF4+82nroZQQ6bTG9TrjrxNxbnxvXCTLnOv0Bm9j0TARrq7KtCs8NCgx6R+JqDwywlj0QuKP++J3qx1ZXOslMwgenvseb6SzKM8aiINQKIVAkHFRLe9q9qflKB9HE2vHEVXeSyI9oEgIH+2s8al8V9jgXaywA3vn3c9Z0xyAbEa1yMAltvAd5QKCP6V3dLYZPQKC6RFVEhqrs7k+CFPa9zzAj/G2cW1h/4/Pm/MYFTCcIY9DewL2+0cVkGsc08KBLfXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ktcd3ETopzvX4oiW25VHti7o5XYRE0DwKKnflWxylE=;
 b=mnHdx7Ndmryq5UpMxPFomWy0DMZ4+W92nznBHWPH4H1aktTvUH7Inaa5zMl3HRSvzsgvKH9izTIl30/B2wv/FavFvbS2dxVdU+izvtN+a+EwSODR8dgbmLSqGeejTFiAdr0zplog/mpn1E5DP5CEaa2IQXfBF/0CfTxyM/jl7zI=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 01:06:05 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.8230.010; Tue, 17 Dec 2024
 01:06:05 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/pm: Implement SDMA queue reset for
 different asic
Thread-Topic: [PATCH 3/3] drm/amdgpu/pm: Implement SDMA queue reset for
 different asic
Thread-Index: AQHbT50RcI3aB2faBEG3nRkzMYi4wrLpoALE
Date: Tue, 17 Dec 2024 01:06:05 +0000
Message-ID: <CH3PR12MB80740CDF9B92AEA91265E9B5F6042@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20241216092929.105280-1-jesse.zhang@amd.com>
 <20241216092929.105280-3-jesse.zhang@amd.com>
In-Reply-To: <20241216092929.105280-3-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-17T01:04:27.0680289Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|PH0PR12MB7840:EE_
x-ms-office365-filtering-correlation-id: 164f5953-2680-4bec-aff6-08dd1e36fb6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?daqoPpt/obyZQnAbgZNc6SFlctb3jgAsHD+/zP6H4jXTESzj0qgaMhErDSRF?=
 =?us-ascii?Q?nKls8CiEpsxhym3/ia+ImPlDhICX8eSY8fN1usGKblGxS0LK+mHr81gCkpcn?=
 =?us-ascii?Q?+AFspFr1h8IHjf3UT2livkQfyKxPEjjT7ogHUtaSp/C7+9D2cqGR+EOY6VNH?=
 =?us-ascii?Q?IATCcWQAquhbvgRe0ZmfNBKJU7kOcswylYGPL4rZIOIK8asxSYdmefT/H/Uh?=
 =?us-ascii?Q?PNcCu+B2O81Nsn9VjInnDMObvlcDiXukzhTHT6Rw3aMLMQX1628eAA+Ye/v/?=
 =?us-ascii?Q?ATZF9zEOewL2oMA0DXGOC8NNaevbWrN6MW/zUZu3neau19O/XuiwZgpkvY9Y?=
 =?us-ascii?Q?JdUfFzH1zmvd6nBKf+IiKTfuG6PACMzRv1MZf4g3eB5cUeOWtepNvwMGbtbu?=
 =?us-ascii?Q?KbOWg9sp9WUiEQvxbEvgSJPdJe/MWzyMvjURzkCP75t6kc3ljSmxEP4fE9Ao?=
 =?us-ascii?Q?wpQV151EsAPbGONmCDbmF3udhRCjXWTxugjZtcH9y4Ji7mSHnhbyAQCUq2vW?=
 =?us-ascii?Q?OeiS/d+FPBP/pq067jxIu/N1n+a5z/whI2Ln9ivfUa3dZ7/9rgvgR7iraPBU?=
 =?us-ascii?Q?1aKPtqG1B68lPNARhEYWD5+sySTUw9jMRpYL8DOGNidYVaTGI8DtCaTFrOMf?=
 =?us-ascii?Q?rCiNNZnl3+Nu+QSZXLlVS2dM7jpPf74M8G6yyrvaVxQDC4gfPNV0VPigsd0l?=
 =?us-ascii?Q?pQYj03fNpWho14Qb5peoUPGTdM4rb+aPCNuv6/GH9vt5PW3V680JiOQJbuCF?=
 =?us-ascii?Q?Cs2MRJIcQO/ZURvMfGI/kt4QgAbccTFuOcpTlS/GN5UBAGbmE1xLEuuoQS99?=
 =?us-ascii?Q?1ANEf9fCvsM41BsacaYJ/QblMS2ZZ7xhbXyBvonby5t9Xsv1GOlz9FuCc50z?=
 =?us-ascii?Q?z8u+6vSZju22ZBG9FEZRct+vdot8j6y9oGFUPbN82CoW4RknifgNP+M2taVz?=
 =?us-ascii?Q?Ff+B14iCjCzv2rZMiZ44Y/7xL36H8I2M+SHEb6FDrh7fXi/i0aB6lXcIad+J?=
 =?us-ascii?Q?QwVUZ+VU6kOWryWNHhp+kB4ccYqvrpwk/Jo6KcYoHZ32Cj0HBozL1gbhoh/R?=
 =?us-ascii?Q?cuNu+AxYtTQy4AUyBOfkQeSQG025IsAce7D9Kn5COo1oZNznJos/jErxgxeW?=
 =?us-ascii?Q?Nfc2D/6YaaXm4b0Jx5elSeMuOC9rFS+aGPKswLI0+IfV3gHQlBbqkmtTTa1Y?=
 =?us-ascii?Q?THzca+QCoF2bsvhOQ348PDwhmlLAoxgkgqXtAJ0qXEACegBYs5JfQFPtHzw+?=
 =?us-ascii?Q?YzsZBVOo1WJ5+3/dgKsLFEBSiZtFvrFE10oiJ+CZdO3Fk6dEo1zYx2yrBOae?=
 =?us-ascii?Q?CMQGO47vJFMSw7Qkc6+Z6PyrRh06Kuz0W0RKQSiCPDdjovJeokkqcu9QGdQv?=
 =?us-ascii?Q?mPfsp5aeva5Xj+R3ACyvT0EdCFyf3BVYw6eKALZvReILGzJIplBW9LC55w6y?=
 =?us-ascii?Q?EkdlP0WOomJOnUrogqIaUr16Mht/BaX5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BWGCpBa6ETVLd2k6Shm8W4m0v5GAae7C7VlV/W0rMGaoBOk/5yWuvkyvFCUU?=
 =?us-ascii?Q?JHYhkEbG2sm5kmylazScjio5bvQXOxooTOoNkya1+ra0oJWjlj6/HKSbLWss?=
 =?us-ascii?Q?A4tPSNkmS4T3ptBfOFOQiet8S8aahjaREUOBuiZYv2bCqdVDJWdIEz+Re9T5?=
 =?us-ascii?Q?ur9IDoEkGv9FHABDd44v2IeVKcCtn2ky7DlAUns4FeyPATzB4Bq8bFNUekg8?=
 =?us-ascii?Q?GHpDAY/oe6CAhszi4vUDSkItTDSJMzLO90IMUZ4/1BE03m1GJa2sKQKangEq?=
 =?us-ascii?Q?nlmDmrkhg9Kq5ehEMcy6/cFC5qOvgUhnWsIxCc0utYTOJ45pYSst3qa5aueS?=
 =?us-ascii?Q?BPAgGH/An5O9zsMRarlfu8L286AgjahAu8wlOccugwYOnO4RBKDiKU3bKzgH?=
 =?us-ascii?Q?09fe7LFAifQ++ffdoOsxkkDOvsLExIw9VKf1nJUQL/Ej3sgiu+tTCcgedK+R?=
 =?us-ascii?Q?bTUzzjtqOCgBUDaLHKfTq0GGQAmFTf6Z88rR/50nBpjyOT5gueSu6Z5kcxYR?=
 =?us-ascii?Q?PbFDM0lQL8VAdD0ZEcjobv/JPsxyY0sSeb05U/fJL98dwiB2kiekUMlUPKC+?=
 =?us-ascii?Q?mu3+L52vWbGPMlwogGZzKOHA8XtE9sHDKGaTa2bGmWuJ3CoyJ2/HDzAzfvOW?=
 =?us-ascii?Q?EYWOFaAazW0hUpYR0JyPGxrM8Xpwhsl+302hvDML+utphT4ZbPQuI7FoLqEc?=
 =?us-ascii?Q?GT69xzOutVm917zc9AjUfemPR+PoxA1zStm9/v38IEsTyKVDmfnqQUu0Dkuv?=
 =?us-ascii?Q?g3fqUjjnr7qoLcPg7sfgr5OgZr3KHpHF6MDuPUyU+gvM+9IkWvkhcXf0mQJk?=
 =?us-ascii?Q?4mmVIVW62UgukWg2F/XZMCLIVixrLRm3EZ/hHRB5nOF+QWiOCZ45cnW10U40?=
 =?us-ascii?Q?88+s0WOwJodQSLIqiWYtHwivfurZF77l+rZxIKT9rQUG2h6xiOst5xYMs31I?=
 =?us-ascii?Q?p0Kcvb1S0YixMUbE9w+W9OC5XzX2mDafKUFlXlLOhqeOON5B1sI630Vyg5uY?=
 =?us-ascii?Q?T1JqnGxcGWh1ajiulvNwioLvdfgaReJS5KnoevmiEApjq+i/nW+HwUdrZ2Fs?=
 =?us-ascii?Q?G/nDDSHa1p9sMiSp8yZBoD+t5qV7xGiFNGGWlVNG5gRxGMQsZWb9dcE0ZYv4?=
 =?us-ascii?Q?19Mawn0bvVHYo+QjH3n1C9sv0QhX+bLy+Xo1NLUCF2ZtSGzrZqstQsxBzLl6?=
 =?us-ascii?Q?+oJ/iz2LVSozUPNnpAE/FP28Ca/ns/45eIfeJgUIm0rKc6KxBzlca4Blh93w?=
 =?us-ascii?Q?SJPjiedoLB0GP9NH3MGpqyFlngtDkFFFKo9un94hysJk3xS7lH6zxen0DopN?=
 =?us-ascii?Q?jxtDlFPO9BZB/75kE88AhSwpjtkYzDcsgt7UBStUk0XN98q2jwpaZKntLNGn?=
 =?us-ascii?Q?t3GdFRsn4bOf0MXPmroPnFjrKXzbvDM+eiOt5K5e6Xqh52iEviZ5xc4Qm0tH?=
 =?us-ascii?Q?kaU6+KDPzdtBbjagQW+rh3pNfDlm2EdJOZ+UUbPOldG8ZOK5no09ncKKVdIg?=
 =?us-ascii?Q?/Rgx7rh4uQWfU9aGnz+6GtPX/4K96dYYl/0zfJufBK/dFiytCGwdJnlcKnim?=
 =?us-ascii?Q?RJqPr3o1Yj0qtO0JjPvZp4sDv5X9Z2XEjhjfT2t7?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB80740CDF9B92AEA91265E9B5F6042CH3PR12MB8074namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164f5953-2680-4bec-aff6-08dd1e36fb6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 01:06:05.1234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MfgqKtp4PXmJPGSTK1PIP4UaxivwLq6RGyvYsacNVWumrUK9Oyyzvztp/v313h+hHSGggcs11RIU+AqCAOp6ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840
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

--_000_CH3PR12MB80740CDF9B92AEA91265E9B5F6042CH3PR12MB8074namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Looks ok to me.  This Series is,

Reviewed-by: Tim Huang <tim.huang@amd.com<mailto:tim.huang@amd.com>>



________________________________
From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
Sent: Monday, December 16, 2024 5:29:56 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhu, Jiadong <Jiadon=
g.Zhu@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Huang, Tim <Tim.Hu=
ang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/pm: Implement SDMA queue reset for differen=
t asic

Implement sdma queue reset by SMU_MSG_ResetSDMA2

Suggested-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 30 ++++++++++++++-----
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9222e7a777a6..446959145058 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2721,17 +2721,31 @@ static int smu_v13_0_6_send_rma_reason(struct smu_c=
ontext *smu)

 static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_m=
ask)
 {
-       struct amdgpu_device *adev =3D smu->adev;
+       uint32_t smu_program;
         int ret =3D 0;

-       /* the message is only valid on SMU 13.0.6 with pmfw 85.121.00 and =
above */
-       if ((adev->flags & AMD_IS_APU) ||
-           amdgpu_ip_version(adev, MP1_HWIP, 0) !=3D IP_VERSION(13, 0, 6) =
||
-           smu->smc_fw_version < 0x00557900)
-               return 0;
+       smu_program =3D (smu->smc_fw_version >> 24) & 0xff;
+       switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
+       case IP_VERSION(13, 0, 6):
+               if (((smu_program =3D=3D 7) && (smu->smc_fw_version > 0x075=
50763)) ||
+                       ((smu_program =3D=3D 0) && (smu->smc_fw_version > 0=
x00557700)))
+                       ret =3D smu_cmn_send_smc_msg_with_param(smu,
+                               SMU_MSG_ResetSDMA, inst_mask, NULL);
+               else if ((smu_program =3D=3D 4) &&
+                       (smu->smc_fw_version > 0x4556e6c))
+                       ret =3D smu_cmn_send_smc_msg_with_param(smu,
+                                     SMU_MSG_ResetSDMA2, inst_mask, NULL);
+               break;
+       case IP_VERSION(13, 0, 14):
+               if ((smu_program =3D=3D 5) &&
+                       (smu->smc_fw_version > 0x05550f00))
+                       ret =3D smu_cmn_send_smc_msg_with_param(smu,
+                                     SMU_MSG_ResetSDMA2, inst_mask, NULL);
+               break;
+       default:
+               break;
+       }

-       ret =3D smu_cmn_send_smc_msg_with_param(smu,
-                                             SMU_MSG_ResetSDMA, inst_mask,=
 NULL);
         if (ret)
                 dev_err(smu->adev->dev,
                         "failed to send ResetSDMA event with mask 0x%x\n",
--
2.25.1



--_000_CH3PR12MB80740CDF9B92AEA91265E9B5F6042CH3PR12MB8074namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"auto"><span style=3D"font-family:-apple-system, HelveticaNeue;f=
ont-size:14.6667px;display:inline !important">Looks ok to me.</span><span s=
tyle=3D"display: inline !important;">&nbsp;&nbsp;</span><span style=3D"font=
-family: -apple-system, HelveticaNeue; font-size: 14.6667px;">This
 Series is,</span></div>
<div dir=3D"auto"><br style=3D"font-family:-apple-system, HelveticaNeue;fon=
t-size:14.6667px">
<span style=3D"font-family:-apple-system, HelveticaNeue;font-size:14.6667px=
;display:inline !important">Reviewed-by:&nbsp;Tim Huang &lt;</span><a href=
=3D"mailto:tim.huang@amd.com" class=3D"ms-outlook-linkify" style=3D"font-fa=
mily: -apple-system, HelveticaNeue; font-size: 14.6667px; color: rgb(0, 120=
, 212);">tim.huang@amd.com</a><span style=3D"font-family:-apple-system, Hel=
veticaNeue;font-size:14.6667px;display:inline !important">&gt;</span><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
<div dir=3D"auto"><br>
</div>
</div>
<div id=3D"mail-editor-reference-message-container" dir=3D"auto"><br>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"divRplyFwdMsg" style=3D"font-size: 11pt;"><strong>From:</strong>=
 Jesse.zhang@amd.com &lt;jesse.zhang@amd.com&gt;<br>
<strong>Sent:</strong> Monday, December 16, 2024 5:29:56 PM<br>
<strong>To:</strong> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freede=
sktop.org&gt;<br>
<strong>Cc:</strong> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; =
Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Huang, Tim &lt;Tim.Huan=
g@amd.com&gt;; Zhu, Jiadong &lt;Jiadong.Zhu@amd.com&gt;; Zhang, Jesse(Jie) =
&lt;Jesse.Zhang@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&gt;<br>
<strong>Subject:</strong> [PATCH 3/3] drm/amdgpu/pm: Implement SDMA queue r=
eset for different asic<br>
</div>
<br>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Implement sdma queue reset by SMU_MSG_ResetSDMA2<b=
r>
<br>
Suggested-by: Tim Huang &lt;tim.huang@amd.com&gt;<br>
Signed-off-by: Jesse Zhang &lt;jesse.zhang@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c&nbsp; | 30 +++++++++++++=
+-----<br>
&nbsp;1 file changed, 22 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
index 9222e7a777a6..446959145058 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c<br>
@@ -2721,17 +2721,31 @@ static int smu_v13_0_6_send_rma_reason(struct smu_c=
ontext *smu)<br>
&nbsp;<br>
&nbsp;static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t i=
nst_mask)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t smu_program;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* the message is only valid on SMU 1=
3.0.6 with pmfw 85.121.00 and above */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;flags &amp; AMD_IS_APU)=
 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, MP1_HWIP, 0) !=3D IP_VERSION(13, 0, 6) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_f=
w_version &lt; 0x00557900)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_program =3D (smu-&gt;smc_fw_versi=
on &gt;&gt; 24) &amp; 0xff;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(smu-&gt;ade=
v, MP1_HWIP, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 6):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (((smu_program =3D=3D 7) &amp;&amp; (smu-&gt;smc_fw_version &=
gt; 0x07550763)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu_program =
=3D=3D 0) &amp;&amp; (smu-&gt;smc_fw_version &gt; 0x00557700)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_=
send_smc_msg_with_param(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_ResetSDMA, inst_mask, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if ((smu_program =3D=3D 4) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (smu-&gt;smc_fw_=
version &gt; 0x4556e6c))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_=
send_smc_msg_with_param(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG=
_ResetSDMA2, inst_mask, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 14):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((smu_program =3D=3D 5) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (smu-&gt;smc_fw_=
version &gt; 0x05550f00))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_=
send_smc_msg_with_param(smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG=
_ResetSDMA2, inst_mask, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_par=
am(smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_ResetSDMA, inst_mask, NULL=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;failed to send ResetSDMA event with mask 0x%x\n&quot;,<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font><br>
</div>
</div>
</body>
</html>

--_000_CH3PR12MB80740CDF9B92AEA91265E9B5F6042CH3PR12MB8074namp_--
