Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DAAC79F9E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 03:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1868110E40B;
	Mon,  7 Sep 2026 03:34:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zJx75Itg";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 538C710E40B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 03:34:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIFIC9ay82ti3BVA0tir4uBJ7/7kpxC+4kdEq1BZyAgHnFJ9ioRWHLbJLQ/MKBtXi/yZkzUOgrE30w1RFYcZWTS0LJv31Km2GQV7CWNyM0P0G5bq17bFWCPU10wrwxLm5qis+i285yNw5fJ//qsd78DVL1R8EcturwmFneMhFjc8Qs0Esb3UM25ooi9Mv2g0TM1uAdCY+FlMJ8Q1cZ2bS58ZLD64LDIUDwbsO/zTmNLR6O8gLg5Qmdau1i024qJpO9DAhtkOCTYpjvWtR+KMAk7lGoVKQf5VL9oA5jf81JORNhZYLFioQwRXUE465C9kZ9fIngafX8dM+So3vvtq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kKJjwliHIhf33m6Z4Cio0kx5BVxldbrrWvF68n8kyw=;
 b=R4BI9xKVxmGiVYh1lqv1QIR33Zb2/OV6fFUhl6lMlfyMq3MpE0bXrmBdDuhB6P7w9CRxoVj3qByAEouruHAW6bShEaqvYip1jbEkY3Q47a8YvJNlUSTC1shPNDfS9lhHiNj9ZO8jdF+2aUGyvbJwF5YqjC3Sva1QkIeMBzg+PxY5wQcdpsswHJcM3VKosmJ1ppZkF9Kjogeun+UDXljSQKp7Q33MQuXSW9qmwyBcA8Joyf8yPK9TOXtdvN1YvgYWfZMgiWiWM+3iHw+Kzc1VeeUJpPMzAR6ZjjXmD/GZ4Ju1NA4CDgGF38YgakDGFXrYpo0JLSIhF3NS8r372GSKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kKJjwliHIhf33m6Z4Cio0kx5BVxldbrrWvF68n8kyw=;
 b=zJx75Itg1ADQLpNuY9gBj4zMiBexVAvEcy4yXxVV/XhC/54q0oXgNWkPcGLp2RkwfzUwVfNSm+xsdbyoY4mHC1RDHPw/sIt0OjjlAb0HDBohvkLxGzCs5rmvibQgzulbx9JiX9JA8lzm1sUNeBpLxcko82Xy/QKE9rPFY6hKO9E=
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6eb) by MW3PR12MB4411.namprd12.prod.outlook.com
 (2603:10b6:303:5e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 03:33:59 +0000
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6]) by BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 03:33:59 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Move GC v12.1 spm vmid init to hw init
Thread-Topic: [PATCH] drm/amdgpu: Move GC v12.1 spm vmid init to hw init
Thread-Index: AQHdO2j1Lgu0i/xXkkypuIF6Ph53m7bCfIgg
Date: Mon, 7 Sep 2026 03:33:58 +0000
Message-ID: <BN7PPFFF39339DD8BFC3A3CE83D2AAD2346FCB22@BN7PPFFF39339DD.namprd12.prod.outlook.com>
References: <20260903055603.65101-1-lijo.lazar@amd.com>
In-Reply-To: <20260903055603.65101-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-07T03:33:41.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PPFFF39339DD:EE_|MW3PR12MB4411:EE_
x-ms-office365-filtering-correlation-id: b131565a-9d2e-428d-6e63-08df0c90da7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|3023799007|22082099003|56012099006|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info: 70YifiPvmaYKSYV2dywOxAXi5clOFge1McDYVJff5a0vH3Nies5lPZ4dpT4x5+5LxMTLwUjcs+qPp7kLPWwr4DznU8BZayjW4A8cUKXgTG9Iegt8cbU0CB539K6wger8sKrWy572n2/da6YUIirfcj+4cF59kMVAH6SocjFzOUIJWPrZX3AmXeWgYXt7BgZ7iKYcjcxDCY2LW8ADT0m2A3nNOGfGowJ9W6vn3biDISFuE5ED5NHnfleyO+5GOW+PnUnKmIMxSsz+RvtenUfT1aQ8cf1KbbT/btJKNV78a2dCRUvw4skf50c3LwQJExCa3Z9PuV6fvnd0mLaE2toZCbS+oaesIHqH/zuJI4OMr9x9UgOoT6113Qs36w97sNa2/7dO2/gjl6KsjE39BQY8Nu8JPmQXqM0EPl0jGs0aYFpwvo+xAN+VrHSyRNKO9/LRD5tlqckXN4nebev7vjX3dNrquqkD0LRKGMW/H4zPV2BjmQIOLGWwn7y0ROdI9jWn1t0WovLslbFkZFwKBI6UnAH6kluGxYaH6Cbx6knJjWnLPvnJehW3OuV2e5feplpeDNsRuOaoGmOWFc9ifCiqo2XIEeiANsbSzyycaeNZptZ8sFcjEf1XYQ6vmp1RLqvKg/DWRkNtc1K3a0lgcAw0qIAftdTi0qX+55v5EvLMUV9TBdp7l6AdLfB/vn+p38Igg9ie4DexOL7Ie66PuyuEt8Mpbhw1uYNu4BTGOXdnJmA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPFFF39339DD.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(3023799007)(22082099003)(56012099006)(11063799006)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MV/Z182gTdhNJnEwlqc9Y9fCBuNJ0DmauDcomBvhRB3PWsXzxyktjawVuqay?=
 =?us-ascii?Q?xVSkFKT1ICAzXDMeF+zbD9Tdq6SZn63zYC4AeEHrS1Qf2csCIiEgcTHPxE2/?=
 =?us-ascii?Q?M+MspG0IHPDHtvo2/pvS2Q6VS33he48AvYVYTtwgRI6MkreACqUHvHDUNinZ?=
 =?us-ascii?Q?r3kh0OobliImp4ftz7I+I79QlPmhgy1KJFwQd02zF/q7wAtRcTKo6z4L0Fl1?=
 =?us-ascii?Q?fNZMiolzer1y21RbqDS25Z3WaKlR/0lVCIKHfuMChNl9bSgHbVKHSfBFCzgo?=
 =?us-ascii?Q?pAjGZbGwggnqczZzJ5Et8mPJLc8r3nN06jY2CId+sYh88I0YDE0xGN0lGkDx?=
 =?us-ascii?Q?dPPjLc0xAJb6N2YdyrOYdXf53ZfmUjg0k8iXaHIRqBG/lX9Y3LXw9jw0OZvu?=
 =?us-ascii?Q?NnO/EhqiJxy4olPII4njjwH97QfQuk5kMEUu6/iz98aGM/ZOK/uTTzwWmLwh?=
 =?us-ascii?Q?U/ceqXpOayqQClv72Oq93lBnYBpJ8g4Sv3B2+NiKQibuJgf5LSIVSP3STUda?=
 =?us-ascii?Q?JJy3DLZqLyW/gedc7I+q7OSNdr5zX4yTTtLWmx5T6Brs1YJvGbPRppAYiXyZ?=
 =?us-ascii?Q?mf7Ap+Apl1NWnaIsOprpY0dhdzfumvYI+G9f4vUgHsnqgaaJ/Kuyj8Eo2qSN?=
 =?us-ascii?Q?/6dfHL471QQyne52L9V9difoZrkqAAdVn2ByklvaN9YaK6x7Pr/Nzke1kg/9?=
 =?us-ascii?Q?qYo4SYYhnkPO6xalgmQIGscJrIH9yb0kwbR4piJlURmiKAjcUSb06eNNZReD?=
 =?us-ascii?Q?5MGUwMLt6k+MiYgAgPAy9/Y5y6rkNGyuwtwQ3lKTWHbQMVkR+pHOgoF1dzqm?=
 =?us-ascii?Q?DKujhTM/OtSoYaMudvZDA8/RGWIfBaUrZSnJqJBFDVvQWEZUN80NdeH0hkKt?=
 =?us-ascii?Q?2tJBCMPcqR3IR3YpbeFV1HXAnhht3aqGMdh1nXf+sHXTQRPOREBjWtMTok5t?=
 =?us-ascii?Q?mGlAOarXs9GE21psZmsxNwdZpOenBh2mSBbb7mmAUMfjnR/zJwuZSrjzdqxt?=
 =?us-ascii?Q?sA6s6RSB3uYkZdeM8apkWrPmW4oYIqZoUOGFlYrLN0k/I3g+guBWJBIvm57j?=
 =?us-ascii?Q?8ecR7bMJ6VQqMprEhjt6hQ9zKg/KLmvJ3y7Z7xEycLsRCxOAHY1w9pDyckKn?=
 =?us-ascii?Q?WNi169095Dg70GVLXajq2LpJqGpd7+K3K7rsAE/PU8lZ+/6MyCzMYqhfsj9s?=
 =?us-ascii?Q?FE5+0SZwE34kW54yCEaNMD2+NeaHtvfatpCL/gBiftAjlj2kEwxl9T2sy11C?=
 =?us-ascii?Q?Ga9tPF1mL964p5UGrE4RP4+ukJ7kYZwoD8JAZEtFz1Fu9z6iaxSTSCNbh6bh?=
 =?us-ascii?Q?aYE+wKGM0zPloeg8lYc+Yy5hT6gY8p2fLucXT41p42I4BhNu2J4YUnC/WQBe?=
 =?us-ascii?Q?M4WxeLF6h2XsJpjArVPpnKoZF1GDqALOa16BUZtrJRMlhUvPa+V4Hb4HGVVK?=
 =?us-ascii?Q?TJlJgmToc9T8Jtu3H3qXh1TccblnFsufUzYvkwzIFVGu9DTks1GtyautH6PQ?=
 =?us-ascii?Q?3/j5EOFCk/BD3wvFJk5e2ALYG3+H8sBi7LjoeHwo/DG7dGzZ9i+2BaO/1+zK?=
 =?us-ascii?Q?A2Q4zOW0MPl2Rip/3Wfw1EaYCgTuwLYr0YSKlEFribbRm6haGal8thO08fFL?=
 =?us-ascii?Q?X6YrJR7ePYE9iZDSLMVRVwYwT7b7MLnLxMVsyK6L53zK2+mVf8N3OmefFRuh?=
 =?us-ascii?Q?94Kl1kAhZoFX31CbAF6ypQdOY4LxJTlmaNxHWYkA7xcCV4e9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PPFFF39339DD.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b131565a-9d2e-428d-6e63-08df0c90da7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 03:33:58.9818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VlrDk+fCQk0K1xWuhvUnqLspE9qJqXfUHUhfUhCdAygIRRTYQLLSnys806dqleaqw8zDzSPIMGvO6CW0iY1yIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
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

AMD General

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, September 3, 2026 1:56 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Move GC v12.1 spm vmid init to hw init

GC reset is not released during sw init and hence it shouldn't be accessed.=
 Move spm vmid programming to hw init phase. This programming may later be =
overridden with the job's vmid.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_1.c
index f812d6d81e9c..1aa86b85ce88 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -218,6 +218,8 @@ static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu=
_device *adev,  static int gfx_v12_1_init_cp_compute_microcode_bo(struct am=
dgpu_device *adev);  static void gfx_v12_1_xcc_update_medium_grain_clock_ga=
ting(
        struct amdgpu_device *adev, bool enable, int xcc_id, bool force);
+static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev, int xcc_=
id,
+                                     struct amdgpu_ring *ring, unsigned vm=
id);

 static void gfx_v12_1_kiq_set_resources(struct amdgpu_ring *kiq_ring,
                                        uint64_t queue_mask)
@@ -695,7 +697,7 @@ static void gfx_v12_1_init_rlcg_reg_access_ctrl(struct =
amdgpu_device *adev)  static int gfx_v12_1_rlc_init(struct amdgpu_device *a=
dev)  {
        const struct cs_section_def *cs_data;
-       int r, i, num_xcc;
+       int r;

        adev->gfx.rlc.cs_data =3D gfx12_cs_data;

@@ -708,13 +710,6 @@ static int gfx_v12_1_rlc_init(struct amdgpu_device *ad=
ev)
                        return r;
        }

-       /* init spm vmid with 0xf */
-       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
-       for (i =3D 0; i < num_xcc; i++) {
-               if (adev->gfx.rlc.funcs->update_spm_vmid)
-                       adev->gfx.rlc.funcs->update_spm_vmid(adev, i, NULL,=
 0xf);
-       }
-
        return 0;
 }

@@ -2005,6 +2000,9 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_dev=
ice *adev,  {
        int r;

+       /* init spm vmid with 0xf */
+       gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, 0xf);
+
        if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
                gfx_v12_1_xcc_init_csb(adev, xcc_id);

--
2.49.0

