Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9B5CDB481
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 13:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF32110EF20;
	Wed, 24 Jun 2026 13:12:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z9s4ilIX";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013059.outbound.protection.outlook.com
 [40.93.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA69F10EF20
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 13:12:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kko+2JkHv2x9FkBi/OG7T99/XbAgH4KbqBxsiz1uzScpotLPudxKLxIqFrw5GozQfRs56U5E7RM7Z4Y8dcqLkpo7LJrHhyNX2rIu9Bn/TdzG27Ho1HsEPX5BfHbqD/b86bzHWAV+TrItWeGVv1MbKHM4+XApSnXSnkmnFgyvs2bxNoJr47ZftX0A7WG2MSfinvqAn/UgBx/qw64JkHS1n33UoAJFHZX88gntaRBoTp3jeJfVbsmrBMsmXhBSJcFGq9r+NMCfEzPLymZkP8rgExhRI5woUqMI6VBvZloQeAdP8saNZGNI3KY4iUf1DbbJ/FoXdMNtwWN9usvTcZevdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rfh7gbvChmciOUoyRdvf8B8ONBJsDoei0LZbe/yU/zc=;
 b=DwBJY9vxJMFBF7GgrcI5yXVAU3ONt1ldPUnmNEaDuxSxK52K2sjN3vT8EF+IRfWC25Rpbij7XgHL439IhjoV5xBpXGYP3yEqNtgiY+uB9tbrtdtOwGiga1oDimS5XuB7a2BGoO2HVL6AcS3NrKVS1+vkMfHXSBd73L9Kjfaz7g7YglrFf0EH4KwITUpioq9aRH//2nVTY/e7T9dvoNuh+1JQ1nD/IxYfoPjyumsKtcEWbZTVRxea0b2KRUmdTFzzMJ3vpL8xthgEQnSCdmQDAeP1tuSJo/PV1PP507QO6W+Tx8Qr3Vr7yrEa+TAwjcSlfBjo4NixZvLVV2LvPpuYyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rfh7gbvChmciOUoyRdvf8B8ONBJsDoei0LZbe/yU/zc=;
 b=z9s4ilIXxWeunvRtsUMSITwn8olDojtTuuapoYi4YBK47lJPee1Z0gq8EhkIsAYFlQlQRyYrAHzqHFwdP7QqtPySRmfQ7RLc5otkKniCmLaQlKLyc4OotweaEF4g9QQ+QxAGtZQYx/YjJBYLh9Zd44jeE3Xdpg4icm2NWFxgk38=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Wed, 24 Jun
 2026 13:12:25 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0159.015; Wed, 24 Jun 2026
 13:12:25 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH v2 47/48] drm/amdgpu: retire legacy umc v12_0 ras functions
Thread-Topic: [PATCH v2 47/48] drm/amdgpu: retire legacy umc v12_0 ras
 functions
Thread-Index: AQHdAiOoiGGwZ3N+6U+/Lav4WDFR/7ZNsYAg
Date: Wed, 24 Jun 2026 13:12:23 +0000
Message-ID: <BN9PR12MB52573EAC983A8BB135382E7FFCED2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
 <ea319027c76364c2a73a663e059b3da6058b4442.1782117608.git.cesun102@amd.com>
In-Reply-To: <ea319027c76364c2a73a663e059b3da6058b4442.1782117608.git.cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-24T13:10:54.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA0PR12MB8207:EE_
x-ms-office365-filtering-correlation-id: f8591151-69b3-4a5e-5c44-08ded1f23b3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|5023799004|4143699003|18002099003|22082099003|6133799003|3023799007|38070700021;
x-microsoft-antispam-message-info: RccIB1poU4J146OWiB2g3/5N5WetGm5+uSITmOfO7g7HBMnHMkad/eiAd78XEGieeXr3ow5QEy0AGaZmWF5jwRJ5HjOvVOTcVDbRhh9vg0MGtRsw7tFExlw/slGFs8EsKVPDuy4wY29aIREEO2hWr0/e90hchhH0r9NyUEasbL20/mkFxmNogHBj4+7nUIH9L9BI2DLlkSn2OJNmRia0JWjNJj3j9Wuq6pazn+vEm8RL3SjWKEqAyIotJ5Yvzt3+P2YDsrwExFh3dCWCStwDdYPsQfSnxzs5UU2NjSl4R7M6RzJKPS5L/c/jdcDq2XoOpPKBCPGtEdcel2mZshx5uKCXoJUN5jZclI9nwnmsncGOtpFCr2zwAStn/Qsr2TE7uGC5wYyOHPzF0jtI5oSh7c8mNWki58817GtMTiW2omhZziT5GyTS9KHT+xu6A7OZA6bLgjZjv60P7PMFdljUljm3U2ZDGoi08J+ZpamWNrjfEbVOXd2ixfaLpwFECWPFH59BhL5gQiXub0ho4G+OTPq+C+4zbWHdQrOVcvc5YGObNeFs72SnToo8gkou2Z1y4/uX3hgEfmljagS+j5h5ErxuZQJggFN6TLnHy1HTPwS7hwiIdGfjcvyIFHcb3omr/wRHIGVEn6ameboy+kC8o4PyHbK0T3pBQS+cTW1lqZgMZhABmYupYx/A7MlxcBoiMhoTmaWr6V+sQVvlgJ3gVPeX8PoEpAE3MgEonNUfd/k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(5023799004)(4143699003)(18002099003)(22082099003)(6133799003)(3023799007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wmiefGudWYpPt7rze8ZPW1aHfvbBs/UDSnP4s05gMb8WGKbjDlGx13+K9F8e?=
 =?us-ascii?Q?LNqjb4y7h1yCf+6y3py6X5Y2gk6utRGYoWCuw41pzKDiy/DSc2ShNWESd5iZ?=
 =?us-ascii?Q?1xBN/JqieDS/K5DhEjagloJs2my5pRsOYn4nEZm7aGN/IjFZpIk1JIznNANL?=
 =?us-ascii?Q?p7QBgEnm5yJGDNPLRQOwiAm39Nz5Yoqe50CelsVPXvuiSVUhlpH9dVQd8FHJ?=
 =?us-ascii?Q?ewqrwcFjw4Wzm9DXiUY7bcsvVGWVaw9HgLy+d3YcByh523oHnAx+yWVNK8HB?=
 =?us-ascii?Q?51x08LuARD+o03u3ZcTWDPSwG6QqoUOeXiQQDbsVnaKZEyICzP5zoaWMD18X?=
 =?us-ascii?Q?kFsx83fjkomSIZj4Zb1JMYpyF8TraR/ZBTegWMMDYe684hALd8t9knpRqLYG?=
 =?us-ascii?Q?kmGy/0JECzj4WehI9JWHTdb0d+9LlhbIjDqdIJ4X6lKMxwsyB2z6A9rRPPHu?=
 =?us-ascii?Q?wwYiIJW/pgOxK4GZ/8QW3le6bCb/KiSwczmCNqRGAVNT1/G5WF8SJaVJ73jr?=
 =?us-ascii?Q?zFADBKiU72DGzCho0L5nwD4vPiuvbzRIA7cRHq8NottkOB8/BwhqwkKCAT6I?=
 =?us-ascii?Q?svDBwfHFgrO16wi/2eAAQRiCdvLvybWKJ3pwIEYD7lASk3BpzUgnHuIqyBgi?=
 =?us-ascii?Q?ODMR4wDDPQiGPzySJ7E5O7yjKCmILkf84zSIapQWLTu0ZVbfysWiV4wVP0PT?=
 =?us-ascii?Q?n9YTuQW1NMygXRkL3CD8wBuCyaBMjeHmqlYSKex0/yNoT4EHHuUY7zDSJ1oC?=
 =?us-ascii?Q?0ZRMksKTfZ8oXTd+4vL3FcKH8pvljW/XhZoa7qkYHIR/EIIFX2Y0tn7eoZAI?=
 =?us-ascii?Q?Cjopfv2ng14QjsGpYLbFZlb/IiAeJBABAuBGUf4F9zpA03TlzN1QhH7YD02Z?=
 =?us-ascii?Q?vjBJCqY3A2XxeAevWKXHdGY8T1Wi/n9317ykl99tz8Ub47OzfNh5UzNmwXJK?=
 =?us-ascii?Q?5FJbE0YcqeVjKIvhFn+ib56uFaQ81ig/SueRqcwVJ124d4bHKzy0yjgUdTCe?=
 =?us-ascii?Q?dXD4/aRQ2WHJLhKvzZBPfYUKzblrXhPYV9QW5iseSeewsyu7dxZQ/LwYzMSv?=
 =?us-ascii?Q?0BB15DECljMsDQ5HxVL47VKeQnZ3WBxGn2uJvWckAOkR9ORymDmUQPNkO1d/?=
 =?us-ascii?Q?T7fN9VJT7F4PitYSL4mdmGpqN1f/X3sPCjsk+MZTQpQ5er8eMXFueJsOMMMf?=
 =?us-ascii?Q?BgqneSSC4V1PYVS/G6pEXVgPZDxDqbPl26Rl7EcwDhVu8snzth8PVomkKLzG?=
 =?us-ascii?Q?2hUHol2fFHj6iv/AsFuI5Pdz6r4lvldDMYkHDDqXrayPFHiRXbePLebKBrs6?=
 =?us-ascii?Q?zu8mR6gO0LBFn8sy67P8DexfyvueIP85megbNVgf6V2sbyLxKU1pAFMYNn3Z?=
 =?us-ascii?Q?N+eHjb/Jypx6+ZR3E9yHGztlrEtmX0VOJ3cPYyuF9xXlg5GoAtqgOtm283l7?=
 =?us-ascii?Q?MdzrQKM0skue3VKPWtCVbmdrSjwkMM7HuGkxO44vw7EI+qUiG50/3Ewcb6Ex?=
 =?us-ascii?Q?l4ot53pGLM9IlbuX9T3PnIvuKGr4C5pXUJF5dhaLZ6wh/9zj57vALozkOH/S?=
 =?us-ascii?Q?fxOfobvqFT7Rz7hh+B8cMoyTdyjSi2f+ZAqk+LaYsv1OahT9rdFoc0Uc+0WW?=
 =?us-ascii?Q?Fi9dwLUYahshT2DgIEV318pn63HAZJL7LRcm1KIGVk67NhSJzVU4/kaepWa1?=
 =?us-ascii?Q?e+Wl77nsa8+qVtTpK+a++7KlhV8SUg0B+3l6Z3v75C7Ne+M0?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52573EAC983A8BB135382E7FFCED2BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8591151-69b3-4a5e-5c44-08ded1f23b3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 13:12:23.9201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zGA7JEiMKtxSIW7uZjCywybAbHycwfSY3oFwwKIvXlK8B/MX6zHLlgG3QGE/avCUsMSF4wI+jnhLVooSpsbYog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207
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

--_000_BN9PR12MB52573EAC983A8BB135382E7FFCED2BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General


@@ -1389,7 +1390,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_devi=
ce *adev)
                adev->umc.node_inst_num /=3D UMC_V12_0_UMC_INSTANCE_NUM;
                adev->umc.channel_offs =3D UMC_V12_0_PER_CHANNEL_OFFSET;
                if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_a=
pu)
-                       adev->umc.ras =3D &umc_v12_0_ras;
+                       adev->umc.ras =3D &umc_dummy_ras;

[Hawking]: If I understand correctly, we still rely on the umc structure an=
d its members for v12_0_0 and v12_5_0 in the UniRAS code path, so these lin=
es were not removed.
Could you please explain the impact of keeping umc.ras as NULL in the UniRA=
S code path?

+                   amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC) &&
+                   adev->umc.ras)
                        amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);

[Hawking]: If introducing a umc_dummy_ras structure is only needed to enabl=
e or disable ecc_irq, then I think we can retire gmc.ecc_irq for UMC v12_0_=
0 and v12_5_0 instead. Can we try that?

Regards,
Hawking


-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Monday, June 22, 2026 4:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH v2 47/48] drm/amdgpu: retire legacy umc v12_0 ras functions

retire legacy umc v12_0 ras functions

Signed-off-by: Ce Sun <cesun102@amd.com<mailto:cesun102@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  8 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c        | 56 --------------
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h        | 74 -------------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  1 -
 5 files changed, 6 insertions(+), 135 deletions(-)  delete mode 100644 dri=
vers/gpu/drm/amd/amdgpu/umc_v12_0.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index 5100e35027ec..3b9c3b7be482 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -113,7 +113,7 @@ amdgpu-y +=3D \

 # add UMC block
 amdgpu-y +=3D \
-       umc_v6_0.o umc_v6_1.o umc_v6_7.o umc_v8_7.o umc_v8_10.o umc_v12_0.o=
 umc_v8_14.o
+       umc_v6_0.o umc_v6_1.o umc_v6_7.o umc_v8_7.o umc_v8_10.o umc_v8_14.o

 # add IH block
 amdgpu-y +=3D \
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 1fcc0594fd0a..f6eed1470647 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -56,7 +56,6 @@
 #include "umc_v6_1.h"
 #include "umc_v6_0.h"
 #include "umc_v6_7.h"
-#include "umc_v12_0.h"
 #include "ras_umc_v12_0.h"
 #include "hdp_v4_0.h"
 #include "mca_v3_0.h"
@@ -79,6 +78,8 @@
 #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION_DCN2                        =
                                  0x05ea
 #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION_DCN2_BASE_IDX               =
                                  2

+struct amdgpu_umc_ras umc_dummy_ras;
+
 static const char * const gfxhub_client_ids[] =3D {
        "CB",
        "DB",
@@ -1389,7 +1390,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_devi=
ce *adev)
                adev->umc.node_inst_num /=3D UMC_V12_0_UMC_INSTANCE_NUM;
                adev->umc.channel_offs =3D UMC_V12_0_PER_CHANNEL_OFFSET;
                if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_a=
pu)
-                       adev->umc.ras =3D &umc_v12_0_ras;
+                       adev->umc.ras =3D &umc_dummy_ras;
                break;
        default:
                break;
@@ -2271,7 +2272,8 @@ static int gmc_v9_0_hw_fini(struct amdgpu_ip_block *i=
p_block)
                amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);

                if (adev->gmc.ecc_irq.funcs &&
-                   amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+                   amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC) &&
+                   adev->umc.ras)
                        amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
        }

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
deleted file mode 100644
index 99d19de42525..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * Copyright 2023 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software=
"),
- * to deal in the Software without restriction, including without limitati=
on
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included=
 in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-#include "umc_v12_0.h"
-#include "amdgpu_ras.h"
-#include "amdgpu_umc.h"
-#include "amdgpu.h"
-#include "umc/umc_12_0_0_offset.h"
-#include "umc/umc_12_0_0_sh_mask.h"
-#include "mp/mp_13_0_6_sh_mask.h"
-
-bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t=
 mc_umc_status) -{
-       return ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
Val) =3D=3D 1) &&
-               (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
PCC) =3D=3D 1 ||
-               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, U=
C) =3D=3D 1 ||
-               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, T=
CC) =3D=3D 1));
-}
-
-bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t m=
c_umc_status) -{
-       return (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, V=
al) =3D=3D 1 &&
-               (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
CECC) =3D=3D 1 ||
-               (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
UECC) =3D=3D 1 &&
-               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, U=
C) =3D=3D 0) ||
-               /* Identify data parity error in replay mode */
-               ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0,=
 ErrorCodeExt) =3D=3D 0x5 ||
-               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, E=
rrorCodeExt) =3D=3D 0xb) &&
-               !(umc_v12_0_is_uncorrectable_error(adev, mc_umc_status)))))=
;
-}
-
-struct amdgpu_umc_ras umc_v12_0_ras =3D {
-       .ras_block =3D {
-               .hw_ops =3D NULL,
-       },
-};
-
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.h
deleted file mode 100644
index 906dc7fa1008..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * Copyright 2023 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software=
"),
- * to deal in the Software without restriction, including without limitati=
on
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included=
 in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-#ifndef __UMC_V12_0_H__
-#define __UMC_V12_0_H__
-
-#include "soc15_common.h"
-#include "amdgpu.h"
-
-/* one piece of normalized address is mapped to 8 pieces of physical addre=
ss */
-#define UMC_V12_0_NA_MAP_PA_NUM        8
-/* R13 bit shift should be considered, double the number */ -#define UMC_V=
12_0_BAD_PAGE_NUM_PER_CHANNEL (UMC_V12_0_NA_MAP_PA_NUM * 2)
-
-/* column bits in SOC physical address */ -#define UMC_V12_0_PA_C2_BIT 15 =
-#define UMC_V12_0_PA_C3_BIT 16 -#define UMC_V12_0_PA_C4_BIT 21
-/* row bits in SOC physical address */
-#define UMC_V12_0_PA_R0_BIT 22
-#define UMC_V12_0_PA_R10_BIT 32
-#define UMC_V12_0_PA_R11_BIT 33
-#define UMC_V12_0_PA_R12_BIT 34
-#define UMC_V12_0_PA_R13_BIT 35
-/* channel bit in SOC physical address */ -#define UMC_V12_0_PA_CH4_BIT 12=
 -#define UMC_V12_0_PA_CH5_BIT 13
-/* bank bit in SOC physical address */
-#define UMC_V12_0_PA_B0_BIT 19
-#define UMC_V12_0_PA_B1_BIT 20
-/* row bits in MCA address */
-#define UMC_V12_0_MA_R0_BIT 10
-
-#define MCA_IPID_LO_2_UMC_CH(_ipid_lo) (((((_ipid_lo) >> 20) & 0x1) * 4) +=
 \
-                       (((_ipid_lo) >> 12) & 0xF))
-#define MCA_IPID_LO_2_UMC_INST(_ipid_lo) (((_ipid_lo) >> 21) & 0x7)
-
-#define MCA_IPID_2_DIE_ID(ipid)  ((REG_GET_FIELD(ipid, MCMP1_IPIDT0, Insta=
nceIdHi) >> 2) & 0x03)
-
-#define MCA_IPID_2_UMC_CH(ipid) \
-       (MCA_IPID_LO_2_UMC_CH(REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdL=
o)))
-
-#define MCA_IPID_2_UMC_INST(ipid) \
-       (MCA_IPID_LO_2_UMC_INST(REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceI=
dLo)))
-
-#define MCA_IPID_2_SOCKET_ID(ipid) \
-       (((REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo) & 0x1) << 2) | \
-        (REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi) & 0x03))
-
-bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t=
 mc_umc_status); -bool umc_v12_0_is_correctable_error(struct amdgpu_device =
*adev, uint64_t mc_umc_status);
-
-extern struct amdgpu_umc_ras umc_v12_0_ras;
-
-#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 7c5e04a1cc94..8a1e28e45a2e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -47,7 +47,6 @@
 #include "smu_cmn.h"
 #include "mp/mp_13_0_6_offset.h"
 #include "mp/mp_13_0_6_sh_mask.h"
-#include "umc_v12_0.h"

 #undef MP1_Public
 #undef smnMP1_FIRMWARE_FLAGS
--
2.34.1


--_000_BN9PR12MB52573EAC983A8BB135382E7FFCED2BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">AMD=
 General<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1389,7 +1390,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *=
adev)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;umc.node_inst_num /=3D UMC_V12_0_UMC_INSTANCE_NU=
M;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;umc.channel_offs =3D UMC_V12_0_PER_CHANNEL_OFFSE=
T;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.connected_to_cpu &amp;&amp; !adev-=
&gt;gmc.is_app_apu)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.ras =3D=
 &amp;umc_v12_0_ras;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.ras =3D=
 &amp;umc_dummy_ras;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#215E99"><span style=3D"fon=
t-size:11pt;">[Hawking]: If I understand correctly, we still rely on the um=
c structure and its members for v12_0_0 and v12_5_0 in the UniRAS code path=
, so these lines were not removed.</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#215E99"><span style=3D"fon=
t-size:11pt;">Could you please explain the impact of keeping umc.ras as NUL=
L in the UniRAS code path?</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLO=
CK__UMC) &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.ras)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ir=
q_put(adev, &amp;adev-&gt;gmc.ecc_irq, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#215E99"><span style=3D"fon=
t-size:11pt;">[Hawking]: If introducing a umc_dummy_ras structure is only n=
eeded to enable or disable ecc_irq, then I think we can retire gmc.ecc_irq =
for UMC v12_0_0 and v12_5_0 instead. Can
we try that?</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,<br>

Hawking</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<a name=3D"_MailEndCompose"></a>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt; <br>

Sent: Monday, June 22, 2026 4:45 PM<br>

To: amd-gfx@lists.freedesktop.org<br>

Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Chai, Thomas &lt;YiPeng.C=
hai@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Yang, Stanley &lt;St=
anley.Yang@amd.com&gt;; Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;<br>

Subject: [PATCH v2 47/48] drm/amdgpu: retire legacy umc v12_0 ras functions=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">reti=
re legacy umc v12_0 ras functions</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Ce Sun &lt;<a href=3D"mailto:cesun102@amd.com">cesun102@amd.com<=
/a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp; 2 +-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp; 8 +-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/umc_v12_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; | 56 --------------</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/umc_v12_0.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; | 74 -------------------</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> ...=
/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c&nbsp; |&nbsp; 1 -</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 5 f=
iles changed, 6 insertions(+), 135 deletions(-)&nbsp; delete mode 100644 dr=
ivers/gpu/drm/amd/amdgpu/umc_v12_0.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> del=
ete mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/M=
akefile</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 5100e35027ec..3b9c3b7be482 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/Makefile</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/Makefile</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
113,7 +113,7 @@ amdgpu-y +=3D \</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> # a=
dd UMC block</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> amd=
gpu-y +=3D \</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_v6_0.o umc_v6_1.o umc_v6_7.o umc_v8_7=
.o umc_v8_10.o umc_v12_0.o umc_v8_14.o</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_v6_0.o umc_v6_1.o umc_v6_7.o umc_v8_7=
.o umc_v8_10.o umc_v8_14.o</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> # a=
dd IH block</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> amd=
gpu-y +=3D \</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu=
/gmc_v9_0.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 1fcc0594fd0a..f6eed1470647 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
56,7 +56,6 @@</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;umc_v6_1.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;umc_v6_0.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;umc_v6_7.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#in=
clude &quot;umc_v12_0.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;ras_umc_v12_0.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;hdp_v4_0.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;mca_v3_0.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
79,6 +78,8 @@</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION_DCN2&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x05ea</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #de=
fine mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION_DCN2_BASE_IDX&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+str=
uct amdgpu_umc_ras umc_dummy_ras;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> sta=
tic const char * const gfxhub_client_ids[] =3D {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;CB&quot;,</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DB&quot;,</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1389,7 +1390,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *=
adev)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;umc.node_inst_num /=3D UMC_V12_0_UMC_INSTANCE_NU=
M;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; adev-&gt;umc.channel_offs =3D UMC_V12_0_PER_CHANNEL_OFFSE=
T;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.connected_to_cpu &amp;&amp; !adev-=
&gt;gmc.is_app_apu)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.ras =3D=
 &amp;umc_v12_0_ras;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.ras =3D=
 &amp;umc_dummy_ras;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
2271,7 +2272,8 @@ static int gmc_v9_0_hw_fini(struct amdgpu_ip_block *ip_bl=
ock)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&gt;gmc.vm_fault, 0);</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.ecc_irq.funcs &amp;&amp;</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLO=
CK__UMC))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLO=
CK__UMC) &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.ras)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ir=
q_put(adev, &amp;adev-&gt;gmc.ecc_irq, 0);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgp=
u/umc_v12_0.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">dele=
ted file mode 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 99d19de42525..000000000000</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
/dev/null</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1,56 +0,0 @@</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-/*<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
Copyright 2023 Advanced Micro Devices, Inc.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- *<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
Permission is hereby granted, free of charge, to any person obtaining a</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
copy of this software and associated documentation files (the &quot;Softwar=
e&quot;),</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
to deal in the Software without restriction, including without limitation</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
the rights to use, copy, modify, merge, publish, distribute, sublicense,</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
and/or sell copies of the Software, and to permit persons to whom the</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
Software is furnished to do so, subject to the following conditions:</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- *<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
The above copyright notice and this permission notice shall be included in<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
all copies or substantial portions of the Software.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- *<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, E=
XPRESS OR</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT SHA=
LL</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
OTHER DEALINGS IN THE SOFTWARE.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- *<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- */=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#in=
clude &quot;umc_v12_0.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#in=
clude &quot;amdgpu_ras.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#in=
clude &quot;amdgpu_umc.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#in=
clude &quot;amdgpu.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#in=
clude &quot;umc/umc_12_0_0_offset.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#in=
clude &quot;umc/umc_12_0_0_sh_mask.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#in=
clude &quot;mp/mp_13_0_6_sh_mask.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-boo=
l umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t mc_=
umc_status) -{</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ((REG_GET_FIELD(mc_umc_status, MCA=
_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1) &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) =3D=
=3D 1 ||</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) =3D=3D=
 1 ||</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) =3D=
=3D 1));</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-boo=
l umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_um=
c_status) -{</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (REG_GET_FIELD(mc_umc_status, MCA_=
UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=
=3D 1 ||</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=
=3D 1 &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) =3D=3D=
 0) ||</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* Identify data parity error in replay mode */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, ErrorCod=
eExt) =3D=3D 0x5 ||</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, ErrorCodeE=
xt) =3D=3D 0xb) &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; !(umc_v12_0_is_uncorrectable_error(adev, mc_umc_status)))));</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-}</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-str=
uct amdgpu_umc_ras umc_v12_0_ras =3D {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ras_block =3D {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; .hw_ops =3D NULL,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-};<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgp=
u/umc_v12_0.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">dele=
ted file mode 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 906dc7fa1008..000000000000</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
/dev/null</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1,74 +0,0 @@</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-/*<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
Copyright 2023 Advanced Micro Devices, Inc.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- *<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
Permission is hereby granted, free of charge, to any person obtaining a</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
copy of this software and associated documentation files (the &quot;Softwar=
e&quot;),</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
to deal in the Software without restriction, including without limitation</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
the rights to use, copy, modify, merge, publish, distribute, sublicense,</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
and/or sell copies of the Software, and to permit persons to whom the</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
Software is furnished to do so, subject to the following conditions:</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- *<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
The above copyright notice and this permission notice shall be included in<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
all copies or substantial portions of the Software.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- *<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, E=
XPRESS OR</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT SHA=
LL</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- * =
OTHER DEALINGS IN THE SOFTWARE.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- *<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">- */=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#if=
ndef __UMC_V12_0_H__</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine __UMC_V12_0_H__</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#in=
clude &quot;soc15_common.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#in=
clude &quot;amdgpu.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-/* =
one piece of normalized address is mapped to 8 pieces of physical address *=
/</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine UMC_V12_0_NA_MAP_PA_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-/* =
R13 bit shift should be considered, double the number */ -#define UMC_V12_0=
_BAD_PAGE_NUM_PER_CHANNEL (UMC_V12_0_NA_MAP_PA_NUM * 2)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-/* =
column bits in SOC physical address */ -#define UMC_V12_0_PA_C2_BIT 15 -#de=
fine UMC_V12_0_PA_C3_BIT 16 -#define UMC_V12_0_PA_C4_BIT 21</span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-/* =
row bits in SOC physical address */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine UMC_V12_0_PA_R0_BIT 22</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine UMC_V12_0_PA_R10_BIT 32</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine UMC_V12_0_PA_R11_BIT 33</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine UMC_V12_0_PA_R12_BIT 34</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine UMC_V12_0_PA_R13_BIT 35</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-/* =
channel bit in SOC physical address */ -#define UMC_V12_0_PA_CH4_BIT 12 -#d=
efine UMC_V12_0_PA_CH5_BIT 13</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-/* =
bank bit in SOC physical address */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine UMC_V12_0_PA_B0_BIT 19</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine UMC_V12_0_PA_B1_BIT 20</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-/* =
row bits in MCA address */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine UMC_V12_0_MA_R0_BIT 10</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine MCA_IPID_LO_2_UMC_CH(_ipid_lo) (((((_ipid_lo) &gt;&gt; 20) &amp; 0x1) =
* 4) + \</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (((_ipid_lo) &gt;&gt=
; 12) &amp; 0xF))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine MCA_IPID_LO_2_UMC_INST(_ipid_lo) (((_ipid_lo) &gt;&gt; 21) &amp; 0x7)<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine MCA_IPID_2_DIE_ID(ipid)&nbsp; ((REG_GET_FIELD(ipid, MCMP1_IPIDT0, Inst=
anceIdHi) &gt;&gt; 2) &amp; 0x03)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine MCA_IPID_2_UMC_CH(ipid) \</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (MCA_IPID_LO_2_UMC_CH(REG_GET_FIELD(ipid,=
 MCMP1_IPIDT0, InstanceIdLo)))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine MCA_IPID_2_UMC_INST(ipid) \</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (MCA_IPID_LO_2_UMC_INST(REG_GET_FIELD(ipi=
d, MCMP1_IPIDT0, InstanceIdLo)))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#de=
fine MCA_IPID_2_SOCKET_ID(ipid) \</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (((REG_GET_FIELD(ipid, MCMP1_IPIDT0, Inst=
anceIdLo) &amp; 0x1) &lt;&lt; 2) | \</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (REG_GET_FIELD(ipid, MCMP1_IPIDT0, =
InstanceIdHi) &amp; 0x03))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-boo=
l umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t mc_=
umc_status); -bool umc_v12_0_is_correctable_error(struct amdgpu_device *ade=
v, uint64_t mc_umc_status);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-ext=
ern struct amdgpu_umc_ras umc_v12_0_ras;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#en=
dif</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 7c5e04a1cc94..8a1e28e45a2e 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
47,7 +47,6 @@</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;smu_cmn.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;mp/mp_13_0_6_offset.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #in=
clude &quot;mp/mp_13_0_6_sh_mask.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-#in=
clude &quot;umc_v12_0.h&quot;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #un=
def MP1_Public</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> #un=
def smnMP1_FIRMWARE_FLAGS</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font>
</body>
</html>

--_000_BN9PR12MB52573EAC983A8BB135382E7FFCED2BN9PR12MB5257namp_--
