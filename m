Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4088606A31B
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 23:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=20pRDqsK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 331F710E109;
	Tue,  3 Nov 2026 23:24:56 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011021.outbound.protection.outlook.com
 [40.93.194.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD6310E109
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 23:24:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+mP3dDZoo2pqzNxELFMC1StNvKcP8J6liqKqG58ODnMQxL4iaW5ed+AXCmdZEE3LX8czdz2AWslA8XDa256aYkAZJn1FtnlSpPPDTeYCLD2cpO73lvBeUVn8+zMOa6OZRXfYfPgl8QMFgvOngHqp7BgJ9rOzVvIsKrmrMGfrbGOr4MvBiEYH1sfOCg5TXnjYvohb7uhgEG1Hb2So4aavQHEdkoy/JlqiK6nLF+ljHnq92Nw5CheR/NCMSgRTPkBqiAkgVEwFWjH5OEn+w21YxlHaqlvi9144dQ4tM+hJDl+Q0hEosmxgRFFD9mESfxlfKV1/2eKFg9lPpB86+0QXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRyXMklL7T7m1ENjjfKkZN6xyWkjaCOKeU2NI6WGGH0=;
 b=VfyU6Yzsm5jBMayWi8uDuqJeyzKsONVEpgWVPX5mPwBKy3GzzxH9dVEy0elbMw52zZzJyBJ+S38t+enWqCSVzlDx0Pt8igs1WFkjzOEK1utRGK/o0bknGOtCU9lMG9+bGqG+MVhWkbLp9TjxNET8oS1aAA/RpuzhXNXHGQ6kQAF/LVRl7yRKzlrXxPpCiODayDTDqWuQlBCDIFo2JZtCy6pFncKG3sh1b9ya2Yuj22y3nal+O3kQxjdl6KMRxmTZYbsggsZxaR6EW7y1Nvly9o43uzcpDYvALLXQlkJZtujJHx3bHj3owY9B0XxirSPSZ8L0zWOk826OlqATveGZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRyXMklL7T7m1ENjjfKkZN6xyWkjaCOKeU2NI6WGGH0=;
 b=20pRDqsKKjJECRlrXbq0YDHBxYQSQzNnJdiodZkhq7HigcQnwYZcVS8mO9ogMJV0iRHyddfac7YUTS7YGl5y4eKgicqzwhMbYK6u6XlNF/6fGpvB+07g5kmmJV6mOMY0AYftcQbxUkSZO8nZOd3ffUg5+QBcU3K6BckBlbFvVUM=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by CH8PR12MB9816.namprd12.prod.outlook.com (2603:10b6:610:262::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 23:24:45 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 23:24:45 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Andrei Krautsou <an9949an@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable MGCG/FGCG/PERF_CLK for GC 11.0.2
Thread-Topic: [PATCH] drm/amdgpu: enable MGCG/FGCG/PERF_CLK for GC 11.0.2
Thread-Index: AQHdayaoxjAhYVoSKk2nrrShGbDzwbcc/hjg
Date: Tue, 3 Nov 2026 23:24:44 +0000
Message-ID: <MW4PR12MB6803349916CEC87B4278FE798E692@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20261103000130.282357-1-an9949an@gmail.com>
In-Reply-To: <20261103000130.282357-1-an9949an@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-03T23:22:31.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|CH8PR12MB9816:EE_
x-ms-office365-filtering-correlation-id: 5a129207-ef9e-4700-d041-08df3a01a523
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|10067099003|18002099003|3023799007|38070700021|56012099006|11063799006|261022105027099003|261102123227099003|261026140227099003|261028144727099003|261022075727099003|261026121527099003|261009223027099003|261021121427099003|261022113327099003;
x-microsoft-antispam-message-info: 4ezciMeeSv7EUMQE9W8XNuwWalh66AyZC01xlGgUpP7k9/OuLcYmERQCIMHfZLHiZewM5dhdBBQvSi+30oyHwSIeHqhVBwh+msQL5/1yZTibenOTGMnKNr3/4eG5riuh9Sz2FD73FYH6zSlIN9dQqzz8OfWLTwsEL9xanyCr2alC2jUzVVYInsLabkavAZprkCb7ak2BInlfb+jwVVb1Fg0mPTRcq9UoXr7cxWUR16f6/JfNpMu7wIc9iTVT/4DPkY8zXFQCHUzIZ3sf8Id2bGaMwsWb+9KIxjJ0hgIaIHtlnW2AR3cCrauXYS7eJEoD07azSPgn3YITW88Lm/hrdveWQRyaRCwE9naMu/KsY5DXuK1L8BBii+inlnIUZzRJbtVvJpH/LnUZ+IKUxmisGXfPT217laS0X0iHC/XSeVhu4yxtntQYYErwxAAb5J7Hhl+BdjMJIMWcVz0maShu+Mc6haxZvaJE90jfqUbkj8prmC9dbt2PoOm6rfLBfXprrfOZpmvRtAUNvRcmRFnTuET1aNg7u0tyQ2RhF1TXD4JCMTrN3YqrexPF2BIePZVO3Wn3++eOWJVhnnjwUNJoGsELRaPgpJvpvam7/HdXNcPIuyiJmmtsN+AHPsrAk497lQvx7wAVU90hnsAqIq4rW8x/tTRUsIX43QaH580i1VE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(10067099003)(18002099003)(3023799007)(38070700021)(56012099006)(11063799006)(261022105027099003)(261102123227099003)(261026140227099003)(261028144727099003)(261022075727099003)(261026121527099003)(261009223027099003)(261021121427099003)(261022113327099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wR9OXB6pU7xiaO6Y2rd2R51uqOIO5/i+siE1iYz5HcY1K5Zbikfl5cM2raWo?=
 =?us-ascii?Q?iC6/q7gbA/q6B905dpQo+pOlx04YTgJ+wYkynqFn1NU94w4Z7DpJQ5qzuX0L?=
 =?us-ascii?Q?wT/gSTdprCnUmPJzv7S+M4SEpJ+vYTNR0n/2JgnZUiW/h4kwAB52e1VkJS2l?=
 =?us-ascii?Q?h2CAh3k4WTqouocSF141/9ST0wkJWaInx1YS4g9DP7kwqYE2KVyqSZZDCMgp?=
 =?us-ascii?Q?a5dVsLLAhCZHvAfGS34R2jjtrOGOtgpOwq28nJi16f844OHX2KA1b0BBP1yf?=
 =?us-ascii?Q?I3hkDrFTmuGV+iPHYLQHCUS2RHLzz8TsanLQDA4n2SNHTEabyOW6Lm9oCY9Q?=
 =?us-ascii?Q?Mk0SgagtOSMrpxMitPOjCluyNHVXwvJXr2P7WCqMDyCY4G1P5iV5TlHoMkLh?=
 =?us-ascii?Q?ngRImw+nbIqlrkkKXPf1M4UN5+h8qNW7RXsuDT4kQ6eS3HoP9PtHOgjJVTVj?=
 =?us-ascii?Q?okaTuFh/XsPfxwurYEly47ZkAKue3e+tYUbtdXY6WDMpta+umjFUTHJxh8Xp?=
 =?us-ascii?Q?g8qidWRE9dQuTVZH7xe3896gd5HeCDnU2vHDj9dLcaPVJPvq6psLhIvA7mXG?=
 =?us-ascii?Q?uEDVldoDzhPTWOWcOkwj4H0mpVMI0xagSyDw0TBylq3rKcuyeTEhhi6WeJZy?=
 =?us-ascii?Q?yLyK/Mtuyrgayvkvfl8uj4a4CcB0aC7KMN6FQ336CXCoMyzpKUQcqczN4vg0?=
 =?us-ascii?Q?+yPuCIlRsVhjQUfnZPmUjSn5V8IaHzy51o/cZiWFL5qzHLBBzexHQWTjqCuw?=
 =?us-ascii?Q?So26X9Kiokgfge6btYdRbFx5Jy6QUW/3OAp/OcJfAQpgO1HwVOYzxT0L6t6/?=
 =?us-ascii?Q?LGORTCco9xTpbgk+P4kM5YW39QJO2swRfXPChLI9aui3ez7BgeZcPlceHDMJ?=
 =?us-ascii?Q?QueXo2/yoatVDe3nQqjoMB8GIIiLZ9pgeXW1SM6L3DX+wplguXF1l+Fv1Sk1?=
 =?us-ascii?Q?4v19bT917KWEDuobVdI7/H1ubJE8P/+e6z8PBBKSd7dSOxhLhGpHh/UrELWv?=
 =?us-ascii?Q?tRBfOCkujZHVHjaPXvlO7tsnNqtOi6pz8xb2rNhp0+qTKyhqbnOHfccTpMVR?=
 =?us-ascii?Q?m0XXwEuKzctR7Xt6SbsARoz4UM276iSFle89VpbMPl/zpKU10/ik5YL8GSxG?=
 =?us-ascii?Q?RS+HY6N/I3n4DiEvniYDOLlI+yGaZCOMI0QvqlZFGopP9BfXddk3D9JnIQy5?=
 =?us-ascii?Q?EtyPd5pkmK7t4M8s967hWDOsjzmbvknTdLrIWPw1hv2+untnvdidIXDk2XPL?=
 =?us-ascii?Q?+Bp7Rv4eH8GKGgm3tIC8vTalJ8OqTWVn/m1j2qGem22HZeE7HsnkhjCil+mk?=
 =?us-ascii?Q?EzjAXA+XF4ehIJJdc0jd+vE5MOEKKxUscYcsJoUP8AfTBCaJJOgJgkb/EFR/?=
 =?us-ascii?Q?aXeamsP87FDsO3V6yaaYBaZRLyxUhpZG26VjAXtEZQb8pHa9DGEeU7vcmaSV?=
 =?us-ascii?Q?3T4f4HNklJ04pXIx83PZOYv8n5QiopxeOp1ac61joutULntvo2KDLKpgogE/?=
 =?us-ascii?Q?bzYCxo6xQB7rQC1tji2gMO5eJdxxY2hFjvsLurKBlcTLGq7fHRX34kk5mmBt?=
 =?us-ascii?Q?7KEOW6g7SrDlPfgU6OQDcVyZPxNLSlMxn+YQkXIu3/WZOeRAtvM/Ap9mGBok?=
 =?us-ascii?Q?c31zOOXORtfcZwl1KP1VPeGx0weWxGBQq8YPSEyJacYrrkl6XgAP0+kMHqgG?=
 =?us-ascii?Q?deqLyuC9ZsorKqbQ/nbbkmnviGD+k1bKAZR/4KfakpHq9l1a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a129207-ef9e-4700-d041-08df3a01a523
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 23:24:44.9293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbQbHfzlZBYGicKe6TRNivmOv/Z+wxc2TUkwuyl6qMhM8fay/RBWVl21FCjGw89G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9816
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Thanks for the fix.
I just remember that there was an issue on MGCG so it was not enabled at th=
e beginning, but I forgot the details, apology.
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

-----Original Message-----
From: Andrei Krautsou <an9949an@gmail.com>
Sent: Tuesday, November 3, 2026 8:02 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Andrei Krautso=
u <an9949an@gmail.com>
Subject: [PATCH] drm/amdgpu: enable MGCG/FGCG/PERF_CLK for GC 11.0.2

[You don't often get email from an9949an@gmail.com. Learn why this is impor=
tant at https://aka.ms/LearnAboutSenderIdentification ]

GC 11.0.2 (Navi33) never got the GFX MGCG, FGCG and PERF_CLK clock gating f=
lags. GC 11.0.0, 11.0.1 and 11.0.4 have all three, GC 11.0.3 has MGCG. The =
gfx_v11_0 code behind these flags is shared by all GC 11 parts. Enable them=
 for GC 11.0.2, same as for GC 11.0.0.

Without the flags the driver does not clear the override bits in RLC_CGTT_M=
GCG_OVERRIDE (0x000605e7 under load), so this gating stays off. On RX 7600S=
 the GFX clock is limited by the GFX TDC limit
(68 A), in Linux and in Windows. With the gating off each MHz costs more GF=
X current, so PMFW stops at a lower clock than in Windows.

vkpeak fp32-scalar for 300 s, median after the first 60 s, GFX current is a=
bout 68 A (TDC limit) in all cases:

                          gfxclk    VDDGFX   GFLOPS
  current flags           2030 MHz  800 mV    8915
  + MGCG                  2261 MHz  873 mV    9921
  + MGCG, FGCG, PERF_CLK  2314 MHz  894 mV   10104
  Windows 11, AMD driver            910 mV   10157-10186

GFLOPS per MHz is the same, only the current per clock goes down.
Windows shows other clock sensors, so there I compare GFLOPS only.
With all three flags vkpeak is within 1% of Windows. MGCG gives most of the=
 gain, FGCG and PERF_CLK add about 2% more.

Tested on one laptop, ASUS TUF A16 FA617NS (RX 7600S, PMFW 82.97.0), Fedora=
 kernel 7.2.11, Mesa 26.2.5, with the same flags set by a local debug patch=
. One 300 s vkpeak run for each setting and some gaming, no amdgpu errors i=
n dmesg. Suspend/resume and long runs are not tested yet.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/6082
Signed-off-by: Andrei Krautsou <an9949an@gmail.com>
---
I have only this one Navi33 laptop. I could not find why these flags were l=
eft off for GC 11.0.2. If there is a hardware reason (errata), please tell =
me. If only FGCG or PERF_CLK is the problem, MGCG alone still gives most of=
 the gain (+11% GFLOPS), and I can send a v2 with MGCG only.

Logs, register values and the Windows numbers are in the issue linked above=
.

 drivers/gpu/drm/amd/amdgpu/soc21.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index 599d47e..635f026 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -599,7 +599,10 @@ static int soc21_common_early_init(struct amdgpu_ip_bl=
ock *ip_block)
                adev->cg_flags =3D
                        AMD_CG_SUPPORT_GFX_CGCG |
                        AMD_CG_SUPPORT_GFX_CGLS |
+                       AMD_CG_SUPPORT_GFX_MGCG |
                        AMD_CG_SUPPORT_REPEATER_FGCG |
+                       AMD_CG_SUPPORT_GFX_FGCG |
+                       AMD_CG_SUPPORT_GFX_PERF_CLK |
                        AMD_CG_SUPPORT_VCN_MGCG |
                        AMD_CG_SUPPORT_JPEG_MGCG |
                        AMD_CG_SUPPORT_ATHUB_MGCG |

base-commit: ba496bb837882eb1af58f41572fc289e46c77b8c
--
2.56.0

