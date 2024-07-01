Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2882AC2BD09
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 18:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0A2D10E4CD;
	Mon,  1 Jul 2024 18:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rTc7ycKc";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0390010E4CD
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 18:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwNXWyckbbZzuQpP4Jdh0kFAwQrbC/F1qYHz8gtsfs3JbVbm0bJ7RwjDDhxFxbhTBHNSJeneVqgH5R/jdimKaaVoszmG+d1fcqtsMS3+DRzrpULI2CC8nZuedGB0xRGqMnLMt+vhtXNS5PvyJe4XSVgUzbnTmiBgJarGU2ny/3lSOA9SUB5P9YhqywhVFuR2y0lGMJp82wAWg4QvRSrjMfXUDllcN8C7TIuC8z5gTLub1R2jjpFA9cf7Y+bN7vvoHU87cpAgVZAzIANp82S1h2NYAaIqtUL3Jjz94xSykGmRuEZz7FB32G6aPlxFwnz/bvFcBA0Wx9Oky9S/I4Q5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2/jVysl0HqyRUxXPihRbBQ0F7u/Q00QyBPX0DMy5Bo=;
 b=Bs9PYFAeBTKuxC/y85qCmD9HRvKRU2XydENbkgUewLmnEwCxLy2JdYZLBR2sSPB7vhQF7qnvmDo+s+5j8L8bqFTfSQndDYBFtNrqplf3QqZ0oy2iFc0d19e8yZVne6+a+Nigpg35mas8fJvkb+FiaGuun68sXDJcXxeuPF2SpjG+Jm8IwmP0HGDFzhbFuPSsDk2jkvXNGoojyMVzdqu1J3HyTEzw3RpJQ4YyqpvkAUetUx6tlWGPXRZY7FTfReQsNb9fD1s0FoK8FssRl6rb6s0vD+eqr/eCcbZ3RbjiOwNHtonTubk5ljs7xYP+wMrbRi5VGKE3JDsvYBYZryRBQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2/jVysl0HqyRUxXPihRbBQ0F7u/Q00QyBPX0DMy5Bo=;
 b=rTc7ycKcaNwjybn7cuaAlSXvsNTu7yopQAapKMcLLhrXA6kMuqLgMNqnSmgH0EkUk8RwDZ9gatQG68lQLWtXAwP7sYyWVZR5K7+Zy230AojQvWJI2yyhePrUDmjpRI9C790zBk+KCjsZD5M9pNwSnCw+b58bUeiBxDAI9ZqadM4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB8779.namprd12.prod.outlook.com (2603:10b6:510:26b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 18:04:00 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 18:04:00 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: Re: [PATCH] drm/amd/pm: avoid to load smu firmware for APUs
Thread-Topic: [PATCH] drm/amd/pm: avoid to load smu firmware for APUs
Thread-Index: AQHaywSmtLzeLhQB8kOwmcFAypVZJLHiLAT6
Date: Mon, 1 Jul 2024 18:04:00 +0000
Message-ID: <BL1PR12MB514484ABCB305F64A7E1553CF7D32@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240630154506.2292189-1-Tim.Huang@amd.com>
In-Reply-To: <20240630154506.2292189-1-Tim.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-01T18:03:59.984Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB8779:EE_
x-ms-office365-filtering-correlation-id: 5857e75c-5ba5-4895-e4db-08dc99f82f41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/pP1V4CT5ECwN4QQj9UtMtlapOSz1Gd4clpvzCKbMaBdZKLrCJxrkzE02JEf?=
 =?us-ascii?Q?GozrofhstHTzG0Wy5rIXUzzuKZBvO7MHKsh7dxRMsuqczCgwKnkOLPKWW5ym?=
 =?us-ascii?Q?xVUZIC2i6+gmJ664+s37c39XL9ebwGBD2dwpVKGWW37JBYeS97gIpvPEv+hz?=
 =?us-ascii?Q?E+yvBrYd5664v6gR/8879mOcSn+rRed7MaBPJUeAz7w3690OMYWKKdyggfS+?=
 =?us-ascii?Q?LfnV+vZOqO3VhkQn5KS2VxYDgON92qgYCYZChnaxN9ELRxErxzOv/9PFxkX7?=
 =?us-ascii?Q?OYm60a3seGSXDOufU91NyClpCXQdsirwuWaqrcumE3HsWYUjivfSuJsJTN0g?=
 =?us-ascii?Q?5RBQK0nvh+X7ZCG0BG5RQRI7U60ciEbo/kGAMEoaxtLQdYVQdRqWW3VVqxmp?=
 =?us-ascii?Q?zoehHfKu2h5AtShxg8z1sdqMOUK7fZvqXFsgh+Z8WD8ZehtROKsQXpnUFZAo?=
 =?us-ascii?Q?vv38Ew9/qKxB7UXb4OuFnwVdJ9VTL4gaoOOhr9RksD236Lsh5S3IGAtLxvDC?=
 =?us-ascii?Q?M9CRZOp240z7jHpCRooGg89AaUjiDC+rZFMPiz0BBGu5Y6L1E08CDB2y0k9X?=
 =?us-ascii?Q?Rk5Je3k8/zE9T0h0NB4FMzJJdKnYaYaksjATwa9tvG3ZhCBanub4jSB4tzDE?=
 =?us-ascii?Q?d37xrRQ8q9NGtbSB6NtWrlpX2D6F+Z5if8X9roxWLxJicpDF3BCnZAUwRoFn?=
 =?us-ascii?Q?2ij7jWT/Be3QKqeNvt3zE1sjQtbnUmXbZ5TOFZTC6Zbo9QRMitSSt2gHZICJ?=
 =?us-ascii?Q?qm6BjoRlT/V2/j4sYDk3+wojB6LhY+vYiUavU7kxEBuj52DelANAeb75fALz?=
 =?us-ascii?Q?oPB6QPYTBSWoCmyyEG1/Qhf26a3fSVKIQ23h65Hhyj8cUEfYUlR6HMSa/JJs?=
 =?us-ascii?Q?4kWMCl58uf7PH/6qwSPzPUCDFYGI3tBLsroPo8/m47Zt/qkXynGHjdPUbvA+?=
 =?us-ascii?Q?00DcfrxS4cMiOhvIDuq2U95bWMzU1DggqYMt3ZpYLL+tsLojTBjT6R1JPLne?=
 =?us-ascii?Q?wG00KM4RT5GN7Qq+YCd/XC8gAxpNZ1OVDA2XrtVIomoCgrr/tR4YSRmz1z3F?=
 =?us-ascii?Q?DRYh0igaHioN3sV8HuNkfrIiQ5E8czBzD3Ld/Vz19lWSYZcBEDN62pQ3BWTo?=
 =?us-ascii?Q?VIqiNUAzghv3wZdfz95MgikfLMC2/ckXvLxt4E6YAKGsM6sbIDFeDMm74d11?=
 =?us-ascii?Q?fPhjPqoMP9jGV+nFCgQXGnAkQOuKoVnJxN/hs5eCOGppWaBpY9OB1YBuEkJb?=
 =?us-ascii?Q?dVVQWwNV/NiYIiaD8A6O+dNLdZB9gj/LdpGjAZWIb5qyK9eTjiZTrQGXJqtQ?=
 =?us-ascii?Q?V/zTrpVyW7tABYNxNbxB42NyQqx37/caB14GAcGkk3oLtCg6m+oNDMyaPPzU?=
 =?us-ascii?Q?yvDfFKNhTaiRQIJcQuNNJc9qCbl2nQe3mfXrSTBfK5jZnwNzcA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L2kpZg+WPUWeff6rRlt869ouM0a5RDxez7wA5WhPDT1R4SHcQiX2q3FNKdFD?=
 =?us-ascii?Q?xpwlBCRqVPeJZr/RrLgy33ZLVCrhDZ5K9kAD4DirA+YigZ7TAUjai3HOOx36?=
 =?us-ascii?Q?bF3Ip7PpVvsM8C6yoNTTN1WS2Xw+o2W0hrpD+fg6Msg85LFcP4sYdCemklIT?=
 =?us-ascii?Q?6TWMRgNZy7yUJhVOAB23mF8YuWTlGQq6k8qKs3ih/3RkLj0OLk8G+xOP9Acd?=
 =?us-ascii?Q?qlVJOTiw6tr2yJtJiaumJEoQ6rmtkw5HJ7XY6krlBYk0J/psBB2NiNFemytl?=
 =?us-ascii?Q?tP9GPIJEGf6LKgo5xI4ZkE1V8elmIN1JGMwBCM2I8nk2yHfIQw/KKG6c1WQy?=
 =?us-ascii?Q?Z1R0eFeM0kg7QSzUF2AmLGOD38WqhRCHw0wXz05NoNwp4FSyFR5MHbVE8MuQ?=
 =?us-ascii?Q?/69Mv5uF8kj5QKosoKXXEg8Kb/jgjSBcU3Xu5QP01ytZ5PPWixKyy6DrfRE6?=
 =?us-ascii?Q?RGmLbFvTOVIK3YVD7u2E7zQ5Hp09z43pbYVWxU0HxS8X1LsCpyCtguYNm5+E?=
 =?us-ascii?Q?vk4z+vxrlrWa6hAbmLin2rf1Y6vgG7zJZV6WWjpktoMw67F7lg1HoLIy+YJ5?=
 =?us-ascii?Q?dgpr4JROWD5gpvlQ6uef9YvfBqqbhYDQoF7VwiiVggFyB8c1F/wZfmNZEYX7?=
 =?us-ascii?Q?eqTGUOxFCMYgXXcncuRM4q8VjuyH/8J35nkfFnM9BVFp2Wb49WImrbCGjQId?=
 =?us-ascii?Q?PaqifNdVVyTNyvs4FEbxCCGYv5H2gTGmaqKNa3JAP4g/TEphfzcACxF9zBHu?=
 =?us-ascii?Q?lbj4M8scWonoUihHxkxuxhxPwlCNh2NnbPPLH3it4pmHO92wTIuivzDxGBLm?=
 =?us-ascii?Q?ZEEIlnwMaDbRcXApIpqLwK67hUM3P59muEJ0rGS8bmQGU/FSagzOWHxO4Iuz?=
 =?us-ascii?Q?11CxwJP3V8u4GsaOyW17A2IilW9eW7oWr74XtyFjFh7Yl/RxF1jr2Jp47X2i?=
 =?us-ascii?Q?gTAwHqXRvNOEi+FVcT3FfwZAYMRGIB0ImDK4qQcwHlnIrM/JVbX8YwomsN8w?=
 =?us-ascii?Q?fIY3TGnN2qgjZ2kW/qrTQsw9ECh253cQT/wCTAbdQnwCOoNAsy9CSisxW4t6?=
 =?us-ascii?Q?/SnD+KN6M/UCEOT2FYyVngiBRG4oSAQ19Z3j6g56tMePzqmaBDoYtfofki8X?=
 =?us-ascii?Q?1R6JWTALNI2PvFB2mMYYDwlm8UmJJChJ1c3S9nRCsL99o0x6f0+OFWVq7vLV?=
 =?us-ascii?Q?JMBL+VR0MjuCPE4WQJtjwuf+a3MvpVDcuQkDvXfY7QJAnLKIG/f3WV7kmKMV?=
 =?us-ascii?Q?Ni+IgCyZPhrdtvjBkhlYYYp/vzZhtgSaYNaNdqaV+0CK78ulIseWCJaQY76J?=
 =?us-ascii?Q?UgOSs7YiP8GyXqPHHYTMPWohFu2xW+FcVAjM7yrDmXKdoJxitGoexud8uLEp?=
 =?us-ascii?Q?2ijW34S7MsmgmYyVK7YoMLexgDR1MM22rFKSe2DOZ2TTCTXgfcnPQ2E09sB4?=
 =?us-ascii?Q?4U6nq6by6LZXFm4pCMNtuF0v1Sso3diltDXbxTzHfrf1UJGkoKBPCH2QsB/i?=
 =?us-ascii?Q?Q0QyTbjbKVBi4lt2ddRM2Cw+nqtvI2xJO01TjkB6yirMs6IePJR8jEE5hbct?=
 =?us-ascii?Q?ZTct7/wD1G59zDRLN6k=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514484ABCB305F64A7E1553CF7D32BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5857e75c-5ba5-4895-e4db-08dc99f82f41
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 18:04:00.3361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/2WkftbvhxFMUGkbF3LfQ8LOei3bF6iEqe2sCEwMVXuoTuAmJEcGQ5QWPsyRBNS4cIagWq3AcsHPXNUcVmIZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8779
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

--_000_BL1PR12MB514484ABCB305F64A7E1553CF7D32BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Sunday, June 30, 2024 11:45 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>
Subject: [PATCH] drm/amd/pm: avoid to load smu firmware for APUs

Certain call paths still load the SMU firmware for APUs,
which needs to be skipped.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 8 +++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 +++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 8 +++-----
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c    | 2 +-
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 18488c02d1cf..c55518fe542c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7324,11 +7324,9 @@ static int gfx_v10_0_hw_init(void *handle)
                  * loaded firstly, so in direct type, it has to load smc u=
code
                  * here before rlc.
                  */
-               if (!(adev->flags & AMD_IS_APU)) {
-                       r =3D amdgpu_pm_load_smu_firmware(adev, NULL);
-                       if (r)
-                               return r;
-               }
+               r =3D amdgpu_pm_load_smu_firmware(adev, NULL);
+               if (r)
+                       return r;
                 gfx_v10_0_disable_gpa_mode(adev);
         }

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 38150398a31b..0ad35e96d2b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4558,11 +4558,9 @@ static int gfx_v11_0_hw_init(void *handle)
                  * loaded firstly, so in direct type, it has to load smc u=
code
                  * here before rlc.
                  */
-               if (!(adev->flags & AMD_IS_APU)) {
-                       r =3D amdgpu_pm_load_smu_firmware(adev, NULL);
-                       if (r)
-                               return r;
-               }
+               r =3D amdgpu_pm_load_smu_firmware(adev, NULL);
+               if (r)
+                       return r;
         }

         gfx_v11_0_constants_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c
index ccb26f78252a..40edda2c3003 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3306,11 +3306,9 @@ static int gfx_v12_0_hw_init(void *handle)
                  * loaded firstly, so in direct type, it has to load smc u=
code
                  * here before rlc.
                  */
-               if (!(adev->flags & AMD_IS_APU)) {
-                       r =3D amdgpu_pm_load_smu_firmware(adev, NULL);
-                       if (r)
-                               return r;
-               }
+               r =3D amdgpu_pm_load_smu_firmware(adev, NULL);
+               if (r)
+                       return r;
         }

         gfx_v12_0_constants_init(adev);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index b3b5e7b74c85..a1b8a82d77cf 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -618,7 +618,7 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *a=
dev, uint32_t *smu_versio
         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
         int r =3D 0;

-       if (!pp_funcs || !pp_funcs->load_firmware)
+       if (!pp_funcs || !pp_funcs->load_firmware || adev->flags & AMD_IS_A=
PU)
                 return 0;

         mutex_lock(&adev->pm.mutex);
--
2.43.0


--_000_BL1PR12MB514484ABCB305F64A7E1553CF7D32BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, Tim &lt;Tim.Hu=
ang@amd.com&gt;<br>
<b>Sent:</b> Sunday, June 30, 2024 11:45 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: avoid to load smu firmware for APUs</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Certain call paths still load the SMU firmware for=
 APUs,<br>
which needs to be skipped.<br>
<br>
Signed-off-by: Tim Huang &lt;Tim.Huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 8 +++-----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 +++-----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 8 +++-----<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_dpm.c&nbsp;&nbsp;&nbsp; | 2 +-<br>
&nbsp;4 files changed, 10 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 18488c02d1cf..c55518fe542c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -7324,11 +7324,9 @@ static int gfx_v10_0_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * loaded firstly, so in direct type, it has to =
load smc ucode<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * here before rlc.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS_APU)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_pm_=
load_smu_firmware(adev, NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_pm_load_smu_firmware(adev, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v10_0_disable_gpa_mode(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index 38150398a31b..0ad35e96d2b8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -4558,11 +4558,9 @@ static int gfx_v11_0_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * loaded firstly, so in direct type, it has to =
load smc ucode<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * here before rlc.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS_APU)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_pm_=
load_smu_firmware(adev, NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_pm_load_smu_firmware(adev, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v11_0_constants_init(a=
dev);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c<br>
index ccb26f78252a..40edda2c3003 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c<br>
@@ -3306,11 +3306,9 @@ static int gfx_v12_0_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * loaded firstly, so in direct type, it has to =
load smc ucode<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * here before rlc.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS_APU)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_pm_=
load_smu_firmware(adev, NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_pm_load_smu_firmware(adev, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v12_0_constants_init(a=
dev);<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c<br>
index b3b5e7b74c85..a1b8a82d77cf 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c<br>
@@ -618,7 +618,7 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *a=
dev, uint32_t *smu_versio<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs =
*pp_funcs =3D adev-&gt;powerplay.pp_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pp_funcs || !pp_funcs-&gt;load_f=
irmware)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pp_funcs || !pp_funcs-&gt;load_f=
irmware || adev-&gt;flags &amp; AMD_IS_APU)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;p=
m.mutex);<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514484ABCB305F64A7E1553CF7D32BL1PR12MB5144namp_--
