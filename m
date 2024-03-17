Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C00C54E67
	for <amd-gfx@archiver.kernel.org>; Sun, 17 Mar 2024 10:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF28610EF58;
	Sun, 17 Mar 2024 10:10:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JHo6W89A";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B03B310EF58
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 Mar 2024 10:10:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmgoFoMhgaJ+AH9ugt8m9O+8J0rOKwIOnWPLZZCvAE8jB1OUODC2EcpzbMPW34FpAY7Ng71varQSc8OSsWEpgHce6SBNhSiWYPvIX8eNEW7Z5kE1vzyp5+YI83OQyNITRzIOnfSIveXzsENZ9ipZlmWDMeeyggu/PUL9n6wgel8+uBD6YLomnJsaxG6Hrgs5fbsger41kljsq5d5GYpVq1BXnGHuQrPaTCQ+QinLW5koUbiYZIIXuGoHRO3RZByya+EF876UoyZtMCg6/gn8p77GuqLxG2BNaZKcD51DN0Ngo5gclwEOPanDwMWcXgtug6afKDFmCo5n1K5tMvcV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rizPZ/i5OHPLgWRkFGFTXAIbwDzmw3uxJEm6UZqsqrU=;
 b=cuMLeocmZso9vZ37FRdOxp1akaVgZTmWD40XKM3ECvRLpyb7G3brbtWTIaFGPmMnxWkOo83oOd077nzqPkwtQP5+L7fDwecZUJ1pH9pz5z3qJ9NUSpOS3s2Dj9r1XEAp+4uKDC15aMRe3zrKrY6pMh+nchSc61ZS2+Y0jOz3IpcHk815AU/LDM8h61EJ27j/UgpKB3p9fgQ+ll/YYaGHD/JqZVhvh3qIVGTLJG6dCzNkAhvGfKfoga2UsD42n0PrJ2fhkjJHO+yrGohCbv02i4c4sQPYMA27g5evVjAtEgybMsmlJq/OcQ6cXzSNNbPgLNAyU6x1sueN8sufwlLy0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rizPZ/i5OHPLgWRkFGFTXAIbwDzmw3uxJEm6UZqsqrU=;
 b=JHo6W89A9VFnLxWeqaSAmlg75b4/6o7jCIH9iBIr8Pbg2/Cc5QfODOwbZPTGPpOUjp5krrqoixH8yVbDBMeJwRJMVbkKTHhHC3hIo52Ka4lS48LchRwdbmo/Q5lG3b23y+nkgfxiidbBvPy6eM+3bbH6EDq2GPyieg8QPsGfK0o=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4339.namprd12.prod.outlook.com (2603:10b6:5:2af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Sun, 17 Mar
 2024 10:10:00 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7386.023; Sun, 17 Mar 2024
 10:10:00 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: make reset method configurable for RAS
 poison
Thread-Topic: [PATCH 3/3] drm/amdgpu: make reset method configurable for RAS
 poison
Thread-Index: AQHadSaXp/4veLcT0k2cozHPpudhHbE7uxIg
Date: Sun, 17 Mar 2024 10:10:00 +0000
Message-ID: <BN9PR12MB5257021E902FF9AA80E66667FC2E2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240313091155.347161-1-tao.zhou1@amd.com>
 <20240313091155.347161-3-tao.zhou1@amd.com>
In-Reply-To: <20240313091155.347161-3-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9d723123-62f6-4aca-88e6-d355f27537b0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-17T10:05:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM6PR12MB4339:EE_
x-ms-office365-filtering-correlation-id: 9d6c933a-bd7e-4c35-77cb-08dc466a67bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ksgLrtyDBdu3DEc95wOYPqMhsk8E5fvTFneyoW/dchDMDHi1ztEw5//bin0KpkcBB33yIX7ELkLzDeIOteRVRpEnDaB37hTUo0geYKghzPUkmvZXJJVnWIDfse1HJiTTYGhHz+d39jd72xt+bGFLpcUYyM4UYlCQQGGcjBkq6Jig8IgS4KaEf4o8AspTwoqgXRloL732xxnW/B4+TOsFsYNPr/LNBLLSOTlhc66THmj0teUp0z7TyWWsgfBLezrw8Rf2MtifmJc23n5htZPPx3P6pAhAwzmhjEpC3LuGOVnl5zzaqoKFTZb9nl/mfDqHI88M+c0p16ef4Uf+Sye6WUkPgCPBQeTXprC2lNujlXmO1o/MEg6KIHje59KB72uZAGruKz+Uxo1T2WMGaxrTvdas3eNq4PL/3HgVTVgKWceyOx5E4wUphr4lDn99ReYmNqad5DNbxlTEqFeWlSs3mBIebYUkhbp5M1MPoNiyjSrghYfalA9DpKIkdlnIC6OeKpW3CK/qILsMTl6iAXWtuSY5KqDDKZY7bdJjBBBx+FF2SK1lYe0WcMXmu2ym5X0EGInf3VQNa+dMWEUN7rnrbWD+3Mv21ZIdoLNaBE+/KyfXyHtclPLUlpmFCSZLGhW6EQgP5VEvWN8szRUBAnpiG36Dx6t7SuZKMs0aojUVSAdfVRCIiS/vE8sT99WWRUM/sq0jaQEo6NmGYpHhGmXWRTIHo4Yo3tUNQHypT0Zo+r0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5g7u+58ukyo2V7HWcgiOUALnBlU08c6XUdhAf2wViPI25vaiUK6n+Kk5m7bT?=
 =?us-ascii?Q?5XzZlGpfhyqmV67RxrLT24YurmNDYDqERC/cxiZa47sYLkOk1aDO9Dnb156n?=
 =?us-ascii?Q?Oz6Rah7bHQlvPl3+KPyQUGQSk0e2yIFkozbyWb30wHKINv61xplk/Tx01hvV?=
 =?us-ascii?Q?+Qrdn+3KhaWbZv46cuj5wTiv1uwmlRIylRdiyhkccGPJckFDhUD4uxROuT6r?=
 =?us-ascii?Q?/0ogrGMTZRldc4tNo3ZroB1CFuBnOa/LRQEQK8kyCd/m6HCzwUruEEGUxDhA?=
 =?us-ascii?Q?Ure2QdT3liefGNjOYFDPRIvg6STtHYUHXJ5aH5F6jEh3c152Ymq0+KAz8jxV?=
 =?us-ascii?Q?NcpOVsiuDCIh6QaORm5AnnuAjSEVHvbTlN6akX1ErqkPj1XSCSL9reWmAfeZ?=
 =?us-ascii?Q?5T/5JoUKI43vxKSf3e3JxLgoLEVwlWccritYSipuSO5ijWukDuK4Cs9spiKR?=
 =?us-ascii?Q?cpX33A+c4rWOaYLYkC1QAv1GBW2LQa7dPBJd9fSlsIUqW1Mqkdhl56nPhF0a?=
 =?us-ascii?Q?tpbqzIg92eyYlaegng/DXJSpabkYLgvOQrOLTLIjgGy9Tq6eKzEcI+8DHK5G?=
 =?us-ascii?Q?uwgicAdO0DMeb0sNa56FR/8ZvxGIaiEFwLOIIkHcdW5+KpGzXOzjPcHLIBs1?=
 =?us-ascii?Q?d1GfU/S0ulJvHhbLAcVmTs2N04/QkZ2vNhgm8q9uXOO6f+2uoNwz89+lnqw7?=
 =?us-ascii?Q?mmd3A8RULT9TiWieIFK1xO+tC00AMXBcAKyw5DKBb+8/GryxwSvx74arpfW4?=
 =?us-ascii?Q?N7dt8B1no71klXhDirR9x7nE8mvcfNP40LS29DO6t3QguPhT8UUfL+TiWUfk?=
 =?us-ascii?Q?di90XwrjOHc2K1xFT671qJRHXAPuiuSJhLkxBSOgJHRFkerbpPXIamSYLhqn?=
 =?us-ascii?Q?auCB0QM1koEFYYIs3g+lMXgWBr7zC41ZNZPISU4tfxFbMsKCRfZdPWqNniUy?=
 =?us-ascii?Q?AZ5fxwVarzECeLGKUIxdrwCl2LKaeO0tNVorNM8irHSe7nlVzdV5JKAMmUUN?=
 =?us-ascii?Q?Wyf4KrEIA6JpSfyJbtVNRK/vhMDTtESV7U6YJQqstI6de+mzF4ukUPvMLPcm?=
 =?us-ascii?Q?WnWr7qsmja+yAebmutvnFWquJvAzIQ9o4GeDSOc0sYE4VtxbiUDRLv+axtbB?=
 =?us-ascii?Q?Zq5pa5la7ANg0V8UzYrV9GjEsMgixtQcKpVVc2JCZYtmZm10DI5CtKJ1ty8p?=
 =?us-ascii?Q?vwH9hgkSVLBd6b+NB9H4rQ4EHzo03x/M1P/wpOfQayfbGLT6Q8Z+lOdgKciB?=
 =?us-ascii?Q?9O+T43VvH1DPecJwL8+Ktz160uV3vzcbipwDBzr5PUvVG2bZv1PaEm00+Rw8?=
 =?us-ascii?Q?i29ynNDzjDrDchbKLj7IR78p3pJSDzTv6oyq6N+6vjrhA5b/QEthTVAq5jUt?=
 =?us-ascii?Q?tKn9tPBUqWSceV72N7qSdAG+Z19TWHJDw4qgCkY88FbVvL0w+aLeI0eTQSz3?=
 =?us-ascii?Q?FvvQu1rIY40Hp3qvgcHsQxF6yV6Tn5tVHHhrSF1xNow6u3KoUx9AnTAbors6?=
 =?us-ascii?Q?uTenzM2d/E4JL4mGkqeyGeJop5iJu03dvjPwqlFRCSrsylff3+M5S8Qvg4Rw?=
 =?us-ascii?Q?6YFDH6qmMzQaw7WUkV0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6c933a-bd7e-4c35-77cb-08dc466a67bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2024 10:10:00.0352 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zR5VfVYL3/Mk2lOiW1bOtRUoh9WXXu2EJPEZivaRJ1ZX5EVy77mrxAFXna95lb+WPRqWghNYyzPsZ5aIfkCZOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4339
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

[AMD Official Use Only - General]

Let's not copy kfd interrupt handler and the work queue implementation from=
 v9 to v10 since the firmware/hardware design are totally different.

We shall have another patch to fix kfd int v10 for poison consumption handl=
ing and also v11.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Wednesday, March 13, 2024 17:12
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: make reset method configurable for RAS poi=
son

Each RAS block has different requirement for gpu reset in poison consumptio=
n handling.
Add support for mmhub RAS poison consumption handling.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       | 14 ++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |  4 ++--
 .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  | 20 ++++++++++++++-----
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 20 ++++++++++++++-----
 7 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 9687650b0fe3..262d20167039 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -760,7 +760,7 @@ bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev)  =
}

 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *ad=
ev,
-       enum amdgpu_ras_block block, bool reset)
+       enum amdgpu_ras_block block, uint32_t reset)
 {
        amdgpu_umc_poison_handler(adev, block, reset);  } diff --git a/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_=
amdkfd.h
index 03bf20e0e3da..ad50c7bbc326 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -400,7 +400,7 @@ void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device=
 *adev);  int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
                                struct tile_config *config);
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *ad=
ev,
-                       enum amdgpu_ras_block block, bool reset);
+                       enum amdgpu_ras_block block, uint32_t reset);
 bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);  bool amdgpu_amdkfd=
_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *mem);  void a=
mdgpu_amdkfd_block_mmu_notifications(void *p); diff --git a/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e32a186c2de1..58fe7bebdf1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2045,7 +2045,7 @@ static void amdgpu_ras_interrupt_poison_consumption_h=
andler(struct ras_manager *
                }
        }

-       amdgpu_umc_poison_handler(adev, obj->head.block, false);
+       amdgpu_umc_poison_handler(adev, obj->head.block, 0);

        if (block_obj->hw_ops && block_obj->hw_ops->handle_poison_consumpti=
on)
                poison_stat =3D block_obj->hw_ops->handle_poison_consumptio=
n(adev);
@@ -2698,7 +2698,7 @@ static int amdgpu_ras_page_retirement_thread(void *pa=
ram)
                atomic_dec(&con->page_retirement_req_cnt);

                amdgpu_umc_bad_page_polling_timeout(adev,
-                               false, MAX_UMC_POISON_POLLING_TIME_ASYNC);
+                               0, MAX_UMC_POISON_POLLING_TIME_ASYNC);
        }

        return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index 20436f81856a..2c02585dcbff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -186,9 +186,7 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_=
device *adev,
        amdgpu_umc_handle_bad_pages(adev, ras_error_status);

        if (err_data->ue_count && reset) {
-               /* use mode-2 reset for poison consumption */
-               if (!entry)
-                       con->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE=
2_RESET;
+               con->gpu_reset_flags |=3D reset;
                amdgpu_ras_reset_gpu(adev);
        }

@@ -196,7 +194,7 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_=
device *adev,  }

 int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
-                       bool reset, uint32_t timeout_ms)
+                       uint32_t reset, uint32_t timeout_ms)
 {
        struct ras_err_data err_data;
        struct ras_common_if head =3D {
@@ -238,8 +236,7 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_d=
evice *adev,
        if (reset) {
                struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);

-               /* use mode-2 reset for poison consumption */
-               con->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+               con->gpu_reset_flags |=3D reset;
                amdgpu_ras_reset_gpu(adev);
        }

@@ -247,7 +244,7 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_d=
evice *adev,  }

 int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
-                       enum amdgpu_ras_block block, bool reset)
+                       enum amdgpu_ras_block block, uint32_t reset)
 {
        int ret =3D AMDGPU_RAS_SUCCESS;

@@ -311,7 +308,8 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device=
 *adev,
                void *ras_error_status,
                struct amdgpu_iv_entry *entry)
 {
-       return amdgpu_umc_do_page_retirement(adev, ras_error_status, entry,=
 true);
+       return amdgpu_umc_do_page_retirement(adev, ras_error_status, entry,
+                               AMDGPU_RAS_GPU_RESET_MODE1_RESET);
 }

 int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev) diff --git a/driver=
s/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 26d2ae498daf..4365a20eeb49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -103,7 +103,7 @@ struct amdgpu_umc {
 int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev);  int amdgpu_umc_ra=
s_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);  =
int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
-                       enum amdgpu_ras_block block, bool reset);
+                       enum amdgpu_ras_block block, uint32_t reset);
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
                struct amdgpu_irq_src *source,
                struct amdgpu_iv_entry *entry);
@@ -123,5 +123,5 @@ int amdgpu_umc_loop_channels(struct amdgpu_device *adev=
,
                        umc_func func, void *data);

 int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
-                       bool reset, uint32_t timeout_ms);
+                       uint32_t reset, uint32_t timeout_ms);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_int_process_v10.c
index 650da18b0d87..94ab1f33fc4a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -134,6 +134,7 @@ static void event_interrupt_poison_consumption(struct k=
fd_node *dev,  {
        enum amdgpu_ras_block block =3D 0;
        int old_poison, ret =3D -EINVAL;
+       uint32_t reset =3D 0;
        struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);

        if (!p)
@@ -153,6 +154,15 @@ static void event_interrupt_poison_consumption(struct =
kfd_node *dev,
        case SOC15_IH_CLIENTID_UTCL2:
                ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
                block =3D AMDGPU_RAS_BLOCK__GFX;
+               if (ret)
+                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+               break;
+       case SOC15_IH_CLIENTID_VMC:
+       case SOC15_IH_CLIENTID_VMC1:
+               ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
+               block =3D AMDGPU_RAS_BLOCK__MMHUB;
+               if (ret)
+                       reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
                break;
        case SOC15_IH_CLIENTID_SDMA0:
        case SOC15_IH_CLIENTID_SDMA1:
@@ -160,6 +170,7 @@ static void event_interrupt_poison_consumption(struct k=
fd_node *dev,
        case SOC15_IH_CLIENTID_SDMA3:
        case SOC15_IH_CLIENTID_SDMA4:
                block =3D AMDGPU_RAS_BLOCK__SDMA;
+               reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
                break;
        default:
                break;
@@ -170,17 +181,16 @@ static void event_interrupt_poison_consumption(struct=
 kfd_node *dev,
        /* resetting queue passes, do page retirement without gpu reset
         * resetting queue fails, fallback to gpu reset solution
         */
-       if (!ret) {
+       if (!ret)
                dev_warn(dev->adev->dev,
                        "RAS poison consumption, unmap queue flow succeeded=
: client id %d\n",
                        client_id);
-               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, blo=
ck, false);
-       } else {
+       else
                dev_warn(dev->adev->dev,
                        "RAS poison consumption, fall back to gpu reset flo=
w: client id %d\n",
                        client_id);
-               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, blo=
ck, true);
-       }
+
+       amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, rese=
t);
 }

 static bool event_interrupt_isr_v10(struct kfd_node *dev, diff --git a/dri=
vers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/k=
fd_int_process_v9.c
index 11641f4645e6..2a37ab7a7150 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -145,6 +145,7 @@ static void event_interrupt_poison_consumption_v9(struc=
t kfd_node *dev,  {
        enum amdgpu_ras_block block =3D 0;
        int old_poison, ret =3D -EINVAL;
+       uint32_t reset =3D 0;
        struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);

        if (!p)
@@ -164,6 +165,15 @@ static void event_interrupt_poison_consumption_v9(stru=
ct kfd_node *dev,
        case SOC15_IH_CLIENTID_UTCL2:
                ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
                block =3D AMDGPU_RAS_BLOCK__GFX;
+               if (ret)
+                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+               break;
+       case SOC15_IH_CLIENTID_VMC:
+       case SOC15_IH_CLIENTID_VMC1:
+               ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
+               block =3D AMDGPU_RAS_BLOCK__MMHUB;
+               if (ret)
+                       reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
                break;
        case SOC15_IH_CLIENTID_SDMA0:
        case SOC15_IH_CLIENTID_SDMA1:
@@ -171,6 +181,7 @@ static void event_interrupt_poison_consumption_v9(struc=
t kfd_node *dev,
        case SOC15_IH_CLIENTID_SDMA3:
        case SOC15_IH_CLIENTID_SDMA4:
                block =3D AMDGPU_RAS_BLOCK__SDMA;
+               reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
                break;
        default:
                break;
@@ -181,17 +192,16 @@ static void event_interrupt_poison_consumption_v9(str=
uct kfd_node *dev,
        /* resetting queue passes, do page retirement without gpu reset
         * resetting queue fails, fallback to gpu reset solution
         */
-       if (!ret) {
+       if (!ret)
                dev_warn(dev->adev->dev,
                        "RAS poison consumption, unmap queue flow succeeded=
: client id %d\n",
                        client_id);
-               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, blo=
ck, false);
-       } else {
+       else
                dev_warn(dev->adev->dev,
                        "RAS poison consumption, fall back to gpu reset flo=
w: client id %d\n",
                        client_id);
-               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, blo=
ck, true);
-       }
+
+       amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, rese=
t);
 }

 static bool context_id_expected(struct kfd_dev *dev)
--
2.34.1

