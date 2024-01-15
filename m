Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C75C47258
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 09:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6318D10E18B;
	Mon, 15 Jan 2024 09:48:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6487F10E18B
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 09:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+i5pOmegHiTOZz9+uMhjdp99ToO+mZcGfwfNPq/o7KC+C5PQuv3U+47XWkhgm3Rm+HCj4h/inTcN2ebDp6bHVtsqcSAUZUIEjx8ehDSm3jlbPep+uE9HZ2YkhtaSz3+kTexbb1Dg1nX9G9gAIAiP/V6QJaFRpImbP4l8GuFFBa/4weCDcMVlOck9NHzp/2w3eGExL+97TMm6f2LsKZFeoEojqxoka4sdJNihLuKk97rSjw83INjJuxtBrYZTP3dERHXRCdUQhMpTO51G+LOF5Bm5mr30WnahsRGJ7qtgHwMUN8C+ZlYTFCMj0tpmHpl//Bh7v6DYKqemH7UcDhnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vm0Tu5RmX6esJTJTW2viXP/54BMAS3hi24ogazxbzb8=;
 b=kDZu5X1+5Jb1QU6AIoSVBmqFYCZZK8RRgf3DUTxVhWTtVlyWVXN916isjCHlcaMhmGKy0GgKdwFsC0ROQdY5ZX9y816S0WTqLcfR9mMOZFlLcIEi0gqicGgTuc+Psy0uqZvVZHrJ05eZnRU8yYcS+zD2Kl6r1QE6lpJnE/YCN1McUozPH6CZ7w4qkU40RSq4Uxp4I3dQw0ySZLzZ3pbwvpsv8X0uFbq5GiJCzrWHe9+jFHcsxVa9QUu4Ug/38b7E5y/0ZIh+K5906vHuI5haNnXZi7bhlm2/XiynvAQVXv1p5bNjOSyqCiEkQU2ucjhB/5/5uXqRUWWtVCcSs+HsSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm0Tu5RmX6esJTJTW2viXP/54BMAS3hi24ogazxbzb8=;
 b=OwiAqwfGf+4U0GkWHTLLQYA3dqUmRFLgkPIqmeM0qoykijOw3AEJYQc7xabxdTcb3GrReIN5UqauUi1C/ai0QDjGzbdlksHV9ayYEzZDy6aKTuchP/u8oycqX8Lfx1+gekJnxv23AesJADPCykjQaQF1ag1+eP74Z+WRypcQGb0=
Received: from PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 15 Jan
 2024 09:48:19 +0000
Received: from PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::2371:6e68:b20:52fe]) by PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::2371:6e68:b20:52fe%4]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 09:48:19 +0000
From: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amd/amdgpu: Update RLC_SPM_MC_CNT by ring wreg
Thread-Topic: [PATCH v3] drm/amd/amdgpu: Update RLC_SPM_MC_CNT by ring wreg
Thread-Index: AQHaRe3sEuo6MqTzqUuk4vW/Zc9q2rDao70Q
Date: Mon, 15 Jan 2024 09:48:19 +0000
Message-ID: <PH0PR12MB54202D3114C225B26E3F1D44E06C2@PH0PR12MB5420.namprd12.prod.outlook.com>
References: <20240113065820.60040-1-YuanShang.Mao@amd.com>
In-Reply-To: <20240113065820.60040-1-YuanShang.Mao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f95c2d2f-1503-4a54-94ec-6b70fc42f6be;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-15T09:47:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5420:EE_|DS0PR12MB9275:EE_
x-ms-office365-filtering-correlation-id: 25ae971d-22c1-416d-5fb2-08dc15af1ad2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SwFdrPgRq/DKThdPLFMnevpoRi3UL6AISOXvmiTJCIY0aKIKNpXJGh99hC1CZIzW5AyN9+hkV3ykrkOO3/4reu9gBAiUNxedZl0bgrayxBcMbQqOdks0mU8wQMf2MXZF3rfxhKlu2i04jviP8p+eYLgZMYWvohUNVauDHPwlV2R1agWP0DjsJeQgvHhEXgnEHm9/wdF6jN2pulE1gqVnoXd5mPQgvUM1fKT7N3orZ94HPzU0SbxR9N7fH+kB8DCXYKka++X+ZcClnJu1XDagkQ9XsfjRV6q7LIL0gtDJmExNWW5thuAV9bQ6Jap7ux1ICCt6igbFs/kfzT4CzNa992IrG9kx6Dz2Z5AWe4D8FgDWdQrJKINmcym3f3ASTbf1BLsS9emQY8ho+OeIvdvtKpHdzIs/4KTk1mOgdnyrvQsW9eluvD7Uc6pesj/qPrCZOgpN078uh7uWpQ57lnD3OaKsRkiI8TpK8OMG3rfz0RK6prTgYFTKyYZnf3FmfRmMUDyN2lvukdXRKqQo1GhwuTv1BxQmVuTfPBsitqSK5XPkTb8BSpm+pMfpRAyTedQ7nGzmtqyvhzB6O6O+hxgkUf/djtDHOO42n5RsJsnQ6hD9YkFTTKIRqQGbkD1ciS7j
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(86362001)(122000001)(2906002)(38070700009)(71200400001)(41300700001)(33656002)(26005)(83380400001)(9686003)(7696005)(6506007)(53546011)(478600001)(8676002)(52536014)(5660300002)(15650500001)(55016003)(316002)(76116006)(66946007)(66556008)(66446008)(66476007)(64756008)(6916009)(38100700002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?narjWD7LrHyBMiD1Qafopo5+fJHFkusvSEoXAcz55UTA1cugyk8Z+5xVV/XW?=
 =?us-ascii?Q?Xzv5C9iH/oqX2GoaWiiWUZvhz0XVMNwLKNykHv+nFrrzMNR6xH1Jq8OOb1XA?=
 =?us-ascii?Q?TGZsC31FoiGWEe40GNAJSkxfytD1tPvR7i4CIeXqpGQtEFs3VcoBZ9IeqKHu?=
 =?us-ascii?Q?687SSFq/romIpaPCp5FA8UkGRiv2K65aMtADUMnzVD/Eu48Py/6/3CI6jWHw?=
 =?us-ascii?Q?VwZ+ASQNQtr6YiZ0rHoiASJA2sEWAdNYUv4H2kmwxujeaqY6GVA8i41TFlVo?=
 =?us-ascii?Q?8rrFfsortCLvI9rPgASRQ0JqwEy0rhvqweALdG7Q3Lr2Hhl+aZUlVZjzzulS?=
 =?us-ascii?Q?ZXFvlbd/IJ3Ul3A3K4gEsK2ECEw7V+ACbE8YnOwV62+0UOimPUbeMyC5PN/u?=
 =?us-ascii?Q?mFnk9DWNq+Pai4vugCdzMUTeASXXp5S2QHGQFu5oMtqOdbiEwsTiuoeGYXH+?=
 =?us-ascii?Q?m0yp5PIibA6C1rURHb5wZaVNzO4Er4j7CUv/+OCWyG4kcZe5GWSlQU9AvyO9?=
 =?us-ascii?Q?0bWzasI5z2JqqbAoeR+8eBzMUdyH0cmSjOH1JZnQnI3+ZqXP5VCSTaHeMAjW?=
 =?us-ascii?Q?GW8C2J1ETcFYA3Y5VDqIB2TUFh9WCxsZGTmE2QWSKDfSjICQ/+fwMgj1b+Rj?=
 =?us-ascii?Q?t/A8De+sqD7e6guhuy+EiCVYV4cPBV4LvM2HWdAMVvT/lmKMlsQiM+1esl8v?=
 =?us-ascii?Q?ESmKe8/CLjhg34/vXRmamZDoUiIzXNQv4mWHasz4h5wq6THLrjPTgGntMYRX?=
 =?us-ascii?Q?YvrpGboww8Q7AvRtaZs2gQuTf+8E4NtL8y/vzM9wRlQ7ScKygq19mtd5tchS?=
 =?us-ascii?Q?KRbA5LWW9fjQrQqv+u9kf76+Xb8StowNXbY5BLfBSYe/CRciNVXF2qJFUpuj?=
 =?us-ascii?Q?mfIoVcxH1SKm2DG4DRs/OPd7tW/jzTm9S8DNZWKOUbXYinD+1E0V1S3MmnZq?=
 =?us-ascii?Q?yJ/X0tWu4lyuKQA8RyarpY+aXumMo2rU7jpnmKlWLZEB38v60N/6lGrdmlhw?=
 =?us-ascii?Q?Ps0mqDuFf4FL+oXv0dAN/Mx3s2sbIj/bbRsyAYBPVC5ogIDgEKtdGuI8tDXs?=
 =?us-ascii?Q?gVhkH5jD3X2XCalCbjmUx3/v1POtflBi7c/zsYq+G0Qhzc6uiZKyZ/AAYZew?=
 =?us-ascii?Q?1oSec7C/D6GIIV0Oqapv+FdkNJNfKQGl0fQxqEzzER64NXD2cF7gya613NBB?=
 =?us-ascii?Q?NIzdjanQlbH/AMHd3TaClrnxBdGm9bPEFWcWXiJi3CeA+8gB8mLevaFSajjs?=
 =?us-ascii?Q?qbeYCDJX9wdLKUNHuQHwe9uomYQz0eFxXzfgWTm67SbSqE+UniJmU6/UgsiJ?=
 =?us-ascii?Q?Ye882NN6Z017FQsnCjM5X5LLh6a5lajbhjwFmr+a/IVBLZ/v2vRJKofUJEwq?=
 =?us-ascii?Q?b32+H4KOu04JGXyoW2mWbNnBwCQc4hxGgu749XEbUDBzGEk4SuTJlRmtQ92X?=
 =?us-ascii?Q?YxZhxH6LgZz95Y3i9RhpD6tS1XleT1gAn1PeROdyUhNmKlSYkY6CGt+Xchuw?=
 =?us-ascii?Q?lvNfPSK2Ib4ptn9IgvLPTK4YSis/B9uNXRd01z8n7oYkSPiYYwyYEz2/rXdZ?=
 =?us-ascii?Q?JYNnY8rnePj3gQjV5BY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ae971d-22c1-416d-5fb2-08dc15af1ad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 09:48:19.2909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rBqef1UXZAt8Keh66olvkHXPbVS+xq7w9LSzbq7rXnfC42N/P6UT0b9ShtLsEJngV4wOEoZ21pjUAIPg3i+AYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275
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

Ping...

-----Original Message-----
From: YuanShang Mao (River) <YuanShang.Mao@amd.com>
Sent: Saturday, January 13, 2024 2:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: YuanShang Mao (River) <YuanShang.Mao@amd.com>; YuanShang Mao (River) <Y=
uanShang.Mao@amd.com>
Subject: [PATCH v3] drm/amd/amdgpu: Update RLC_SPM_MC_CNT by ring wreg

[Why]
RLC_SPM_MC_CNTL can not updated by MMIO
since MMIO protection is enabled during runtime in guest machine.

[How]
Submit command of wreg in amdgpu ring to update RLC_SPM_MC_CNT.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  2 +-  drivers/gpu/drm/amd/amdgp=
u/amdgpu_vm.c  |  2 +-  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  2 +-  dr=
ivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  4 ++--
 8 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_rlc.h
index b591d33af264..5a17e0ff2ab8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -169,7 +169,7 @@ struct amdgpu_rlc_funcs {
        void (*stop)(struct amdgpu_device *adev);
        void (*reset)(struct amdgpu_device *adev);
        void (*start)(struct amdgpu_device *adev);
-       void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
+       void (*update_spm_vmid)(struct amdgpu_device *adev, struct amdgpu_r=
ing
+*ring, unsigned vmid);
        bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t r=
eg);  };

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index 7da71b6a9dc6..13b2c82e5f48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -650,7 +650,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct am=
dgpu_job *job,
                amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);

        if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
-               adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
+               adev->gfx.rlc.funcs->update_spm_vmid(adev, ring, job->vmid)=
;

        if (!ring->is_mes_queue && ring->funcs->emit_gds_switch &&
            gds_switch_needed) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index c8a3bf01743f..830ed6fe1baf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7951,7 +7951,7 @@ static void gfx_v10_0_update_spm_vmid_internal(struct=
 amdgpu_device *adev,
        WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);  }

-static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned=
 int vmid)
+static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev,
+struct amdgpu_ring *ring, unsigned int vmid)
 {
        amdgpu_gfx_off_ctrl(adev, false);

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index c659ef0f47ce..42e9976c053e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -749,7 +749,7 @@ static int gfx_v11_0_rlc_init(struct amdgpu_device *ade=
v)

        /* init spm vmid with 0xf */
        if (adev->gfx.rlc.funcs->update_spm_vmid)
-               adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
+               adev->gfx.rlc.funcs->update_spm_vmid(adev, NULL, 0xf);

        return 0;
 }
@@ -5002,7 +5002,7 @@ static int gfx_v11_0_update_gfx_clock_gating(struct a=
mdgpu_device *adev,
        return 0;
 }

-static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, unsigned=
 vmid)
+static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev,
+struct amdgpu_ring *ring, unsigned vmid)
 {
        u32 data;

@@ -5013,9 +5013,15 @@ static void gfx_v11_0_update_spm_vmid(struct amdgpu_=
device *adev, unsigned vmid)
        data &=3D ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
        data |=3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC=
_CNTL__RLC_SPM_VMID__SHIFT;

-       WREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL, data);
+       if (ring =3D=3D NULL)
+               WREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL, data);

        amdgpu_gfx_off_ctrl(adev, true);
+
+       if (ring) {
+               uint32_t reg =3D SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL=
);
+               amdgpu_ring_emit_wreg(ring, reg, data);
+       }
 }

 static const struct amdgpu_rlc_funcs gfx_v11_0_rlc_funcs =3D { diff --git =
a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7=
_0.c
index c2faf6b4c2fc..86a4865b1ae5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3274,7 +3274,7 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *ad=
ev)

        /* init spm vmid with 0xf */
        if (adev->gfx.rlc.funcs->update_spm_vmid)
-               adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
+               adev->gfx.rlc.funcs->update_spm_vmid(adev, NULL, 0xf);

        return 0;
 }
@@ -3500,7 +3500,7 @@ static int gfx_v7_0_rlc_resume(struct amdgpu_device *=
adev)
        return 0;
 }

-static void gfx_v7_0_update_spm_vmid(struct amdgpu_device *adev, unsigned =
vmid)
+static void gfx_v7_0_update_spm_vmid(struct amdgpu_device *adev, struct
+amdgpu_ring *ring, unsigned vmid)
 {
        u32 data;

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index 1943beb135c4..ea174b76ee70 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1288,7 +1288,7 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *ad=
ev)

        /* init spm vmid with 0xf */
        if (adev->gfx.rlc.funcs->update_spm_vmid)
-               adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
+               adev->gfx.rlc.funcs->update_spm_vmid(adev, NULL, 0xf);

        return 0;
 }
@@ -5579,7 +5579,7 @@ static void gfx_v8_0_unset_safe_mode(struct amdgpu_de=
vice *adev, int xcc_id)
        }
 }

-static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, unsigned =
vmid)
+static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, struct
+amdgpu_ring *ring, unsigned vmid)
 {
        u32 data;

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 69c500910746..57808be6e3ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4894,7 +4894,7 @@ static void gfx_v9_0_update_spm_vmid_internal(struct =
amdgpu_device *adev,
                WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);  }

-static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned =
int vmid)
+static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, struct
+amdgpu_ring *ring, unsigned int vmid)
 {
        amdgpu_gfx_off_ctrl(adev, false);

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 00b21ece081f..acf7d2898665 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1109,7 +1109,7 @@ static int gfx_v9_4_3_rlc_init(struct amdgpu_device *=
adev)  {
        /* init spm vmid with 0xf */
        if (adev->gfx.rlc.funcs->update_spm_vmid)
-               adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
+               adev->gfx.rlc.funcs->update_spm_vmid(adev, NULL, 0xf);

        return 0;
 }
@@ -1320,7 +1320,7 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_device=
 *adev)
        return 0;
 }

-static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
+static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
+struct amdgpu_ring *ring,
                                       unsigned vmid)
 {
        u32 reg, data;
--
2.34.1

