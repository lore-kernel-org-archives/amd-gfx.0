Return-Path: <SRS0=Ro4j=7H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED6DC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4560920723
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2020 18:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vQonTfto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4560920723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F17489BF0;
	Mon, 25 May 2020 18:14:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 097E889BC2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2020 18:14:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COeWe5sDkvAmlVPP6+4sKfHr29owBVc57ZUpYsxhgzxX/rrKhMhCjQfMfO6DF9ByQEo79vzUlzJFJ6ARy7kmJdXWHiSBx6C7eLgQPy2gWxcLFBkI5BqLcaQmjIuPmz0FOjGVBqR1+Zh2Vc2+YBMPU5SzcPIG8WnMQ41Hf1fNITcu5VUVIVJFGJg2JVfG9PeUoKG2LmffIdfRvL3KyiQhQTl2jIvWGGHT/aEpLt5Ku4Lu9QANlgd9mi5a72PsqHekPz7RrJnvOk5WqZE9Jxn4DW+BHgIbp6CUBZjjtcZWXHUOflWQ+bxyUN80wk071hLjp5RfNjMzh9pbnhSv5SUtOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2icj0EqkpOAkq3yLOd4qIuFKc+Ep569fD910b/Xywhg=;
 b=i2cxqq7O1bMaQaUyC1mXVajYs47YtQQgA4vRIGXPrkeWmht6qmwI23hdLdrGBtm0wzhQfzysfmDWEKR1kAWp1O76kdJhf+Ap1DHMGe4T3L/okLSLnPvE+glFZZbhdE7ACq1bCjoVnnjyg8fGCcmiEaeOg6VmP5iSfvr9OePNsD4mucdtmwCc4KJOSGMEfxb6SbXoiNAH2PQiH/eWiuOI5fw0phtZKFmlgEPaS4cSaEjmwksV0ohX+yCfGVTr5SmqbxqBu9/ALNiwVZ/EfgSMuhr41gHKSQGzMxz/aGrCRq2jsNIZ74/lD82OC4g8SgqcDmL0yS1m0AkSVCD0LcyuWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2icj0EqkpOAkq3yLOd4qIuFKc+Ep569fD910b/Xywhg=;
 b=vQonTftoZjMl25V73ZRyI9Cw/RRQqTHjb6bmirmRjOFMEpGao/u4IOYxqcQy9j5yOxsloZTzUFnR6wMr+GLqc6bf0GsUCNiBOCZkQ7hv3L/6Fb7HIeS/13RzxXnxjeU1K1F4ag8/4l65aQmeTthgHuZZTRdt3nb090MYILW1H0c=
Received: from DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23)
 by DM6PR12MB2665.namprd12.prod.outlook.com (2603:10b6:5:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Mon, 25 May
 2020 18:14:45 +0000
Received: from DM6PR12MB4482.namprd12.prod.outlook.com
 ([fe80::e058:9371:1bd6:9b4a]) by DM6PR12MB4482.namprd12.prod.outlook.com
 ([fe80::e058:9371:1bd6:9b4a%4]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 18:14:45 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: check whether SMU IP is enabled before
 access
Thread-Topic: [PATCH] drm/amd/powerplay: check whether SMU IP is enabled
 before access
Thread-Index: AQHWMl8QvInynKuFzUS/GNqNysiV0ai5Gee6
Date: Mon, 25 May 2020 18:14:45 +0000
Message-ID: <DM6PR12MB4482BECF79B7DD26C4F362E5F0B30@DM6PR12MB4482.namprd12.prod.outlook.com>
References: <20200525063751.19222-1-evan.quan@amd.com>
In-Reply-To: <20200525063751.19222-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-25T18:14:44.576Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b00d1de1-4dda-439a-feaf-08d800d780f8
x-ms-traffictypediagnostic: DM6PR12MB2665:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2665CF1F45EA8254AFB2D066F0B30@DM6PR12MB2665.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0414DF926F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iSp4wYAGintoNSIhwR/2cbj4je6c8rtNfAFTL1SBpF3mEoMAPHgLihhNqsy6fUCl8ir29dDf73+khMAxT+eG4s94ZiZclgy36j5tooOc9EHp+clyZVpnBbqzDbcH8wnY9npnGxf9Lh6KCkwySTtL82O3rPmaO/dzC0mqtMYuMOOPlUng7XVrzpOU0eUB1pRbnQedsDWcEoHvOBJkQuUzQioH/S+ZRTOolopl4H0LvFOchX+YwZ72b2SOZRO0T2Lt9jEK9E2x7IYzVOfqVfrKtxC3AF4xWzyS5jKFLfyugVrsBunKhTzKvyMXzlQP9Ecw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4482.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(316002)(30864003)(6506007)(53546011)(8936002)(186003)(478600001)(86362001)(2906002)(4326008)(33656002)(7696005)(26005)(52536014)(91956017)(5660300002)(66946007)(76116006)(71200400001)(66476007)(66556008)(64756008)(66446008)(9686003)(55016002)(19627405001)(8676002)(110136005)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: s8K2pS/r2jVMrywapf4RFUceSWopg/o3J96hSu4o8Oq1phvmfK4kvU38vARKJhDAmZl6SgWuyCd/KAR+bUqBTv5st8faxMo1UAMT6QRRYBWJl73Q2vdylGgiCceAu8n+xS9De0xHzFmcStQnkMmX3Ae/pkzj0n1GrWj0W8DTcfVFpdLGG+7SaC2DKilofF73hGgdGxghys4LSW2To8Nmn+d+omv0X+cZbJ7AhH2TwfDD4h7Ahd6A6oOgaXyXKADacAmKXp7D5QGaNPPQgUE6vl5kU8NRiIYwhA+ZnZ+ovQTVMypQnRIwEWXBht5H9BuZhTcs6pH4F4Z3597Dlw0qv8CBHU7srykGpSW8CvCRxPtv32Nu7Zh8knJ1RF2k5I1bo7UycDg5m9mseaNGvPIPua6PhOgYreeMWz41wn5lCF2UJdCimU/67kmdr9WXfT5EXi4JEub7vfsYA5aFbiutnh8vTOsWhQuBGrPfqu60iCpKI3UWafjUpuFXUf5ISlu0
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00d1de1-4dda-439a-feaf-08d800d780f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 18:14:45.3132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mmEGW9N74cD3xop9Qwf7EDId0R808F3wEgyRv95mvS75UAD4GS3Kk6vkobK/P0mt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2665
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/mixed; boundary="===============0289765650=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0289765650==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4482BECF79B7DD26C4F362E5F0B30DM6PR12MB4482namp_"

--_000_DM6PR12MB4482BECF79B7DD26C4F362E5F0B30DM6PR12MB4482namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Have an improvement suggestion inline. Whether it is accepted or not, the p=
atch is

Reviewed-by: Yong Zhao <Yong.Zhao@amd.com>
Tested-by: Yong Zhao <Yong.Zhao@amd.com>

________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Monday, May 25, 2020 2:37 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhao, Yong <Yong.Zhao@a=
md.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/powerplay: check whether SMU IP is enabled before =
access

Since on early phase of bringup, the SMU IP may be not enabled or
supported. Without this, we may hit null pointer dereference on
accessing smu->adev.

Change-Id: I644175e926cd4fef8259f89002d6f8eda04fe42c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 266 +++++++++------------
 1 file changed, 113 insertions(+), 153 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index a78a1f542ea9..f7428996cc74 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -61,7 +61,6 @@ const char *smu_get_feature_name(struct smu_context *smu,=
 enum smu_feature_mask

 size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         size_t size =3D 0;
         int ret =3D 0, i =3D 0;
         uint32_t feature_mask[2] =3D { 0 };
@@ -70,8 +69,8 @@ size_t smu_sys_get_pp_feature_mask(struct smu_context *sm=
u, char *buf)
         uint32_t sort_feature[SMU_FEATURE_COUNT];
         uint64_t hw_feature_count =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -155,10 +154,9 @@ int smu_sys_set_pp_feature_mask(struct smu_context *sm=
u, uint64_t new_mask)
         uint64_t feature_2_enabled =3D 0;
         uint64_t feature_2_disabled =3D 0;
         uint64_t feature_enables =3D 0;
-       struct amdgpu_device *adev =3D smu->adev;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -436,11 +434,10 @@ bool smu_clk_dpm_is_enabled(struct smu_context *smu, =
enum smu_clk_type clk_type)
 int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
                            bool gate)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         switch (block_type) {
         case AMD_IP_BLOCK_TYPE_UVD:
@@ -577,11 +574,10 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
 int smu_sys_get_pp_table(struct smu_context *smu, void **table)
 {
         struct smu_table_context *smu_table =3D &smu->smu_table;
-       struct amdgpu_device *adev =3D smu->adev;
         uint32_t powerplay_table_size;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         if (!smu_table->power_play_table && !smu_table->hardcode_pptable)
                 return -EINVAL;
@@ -603,12 +599,11 @@ int smu_sys_get_pp_table(struct smu_context *smu, voi=
d **table)
 int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size)
 {
         struct smu_table_context *smu_table =3D &smu->smu_table;
-       struct amdgpu_device *adev =3D smu->adev;
         ATOM_COMMON_TABLE_HEADER *header =3D (ATOM_COMMON_TABLE_HEADER *)b=
uf;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         if (header->usStructureSize !=3D size) {
                 pr_err("pp table size not matched !\n");
@@ -1622,15 +1617,11 @@ static int smu_resume(void *handle)
 int smu_display_configuration_change(struct smu_context *smu,
                                      const struct amd_pp_display_configura=
tion *display_config)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int index =3D 0;
         int num_of_active_display =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
-
-       if (!is_support_sw_smu(smu->adev))
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         if (!display_config)
                 return -EINVAL;
@@ -1691,15 +1682,11 @@ int smu_get_current_clocks(struct smu_context *smu,
                            struct amd_pp_clock_info *clocks)
 {
         struct amd_pp_simple_clock_info simple_clocks =3D {0};
-       struct amdgpu_device *adev =3D smu->adev;
         struct smu_clock_info hw_clocks;
         int ret =3D 0;

-       if (!is_support_sw_smu(smu->adev))
-               return -EINVAL;
-
-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -1855,11 +1842,10 @@ int smu_handle_task(struct smu_context *smu,
                     enum amd_pp_task task_id,
                     bool lock_needed)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         if (lock_needed)
                 mutex_lock(&smu->mutex);
@@ -1894,12 +1880,11 @@ int smu_switch_power_profile(struct smu_context *sm=
u,
                              bool en)
 {
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
-       struct amdgpu_device *adev =3D smu->adev;
         long workload;
         uint32_t index;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
                 return -EINVAL;
@@ -1929,11 +1914,10 @@ int smu_switch_power_profile(struct smu_context *sm=
u,
 enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *sm=
u)
 {
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
-       struct amdgpu_device *adev =3D smu->adev;
         enum amd_dpm_forced_level level;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
                 return -EINVAL;
@@ -1948,11 +1932,10 @@ enum amd_dpm_forced_level smu_get_performance_level=
(struct smu_context *smu)
 int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forc=
ed_level level)
 {
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
                 return -EINVAL;
@@ -1976,11 +1959,10 @@ int smu_force_performance_level(struct smu_context =
*smu, enum amd_dpm_forced_lev

 int smu_set_display_count(struct smu_context *smu, uint32_t count)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);
         ret =3D smu_init_display_count(smu, count);
@@ -1995,11 +1977,10 @@ int smu_force_clk_levels(struct smu_context *smu,
                          bool lock_needed)
 {
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         if (smu_dpm_ctx->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL) {
                 pr_debug("force clock level is for dpm manual mode only.\n=
");
@@ -2031,6 +2012,9 @@ int smu_set_mp1_state(struct smu_context *smu,
         uint16_t msg;
         int ret;

+       if (!smu->pm_enabled)
+               return -EOPNOTSUPP;
[yz] Is this needed? We can just check the condition at the entry functions=
 rather than all functions. This also applies to other similar places like =
this.
+
         mutex_lock(&smu->mutex);

         switch (mp1_state) {
@@ -2067,11 +2051,10 @@ int smu_set_mp1_state(struct smu_context *smu,
 int smu_set_df_cstate(struct smu_context *smu,
                       enum pp_df_cstate state)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         if (!smu->ppt_funcs || !smu->ppt_funcs->set_df_cstate)
                 return 0;
@@ -2089,11 +2072,10 @@ int smu_set_df_cstate(struct smu_context *smu,

 int smu_allow_xgmi_power_down(struct smu_context *smu, bool en)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         if (!smu->ppt_funcs || !smu->ppt_funcs->allow_xgmi_power_down)
                 return 0;
@@ -2127,10 +2109,9 @@ int smu_set_watermarks_for_clock_ranges(struct smu_c=
ontext *smu,
                 struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges=
)
 {
         void *table =3D smu->smu_table.watermarks_table;
-       struct amdgpu_device *adev =3D smu->adev;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         if (!table)
                 return -EINVAL;
@@ -2155,11 +2136,10 @@ int smu_set_watermarks_for_clock_ranges(struct smu_=
context *smu,

 int smu_set_ac_dc(struct smu_context *smu)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         /* controlled by firmware */
         if (smu->dc_controlled_by_gpio)
@@ -2219,11 +2199,10 @@ const struct amdgpu_ip_block_version smu_v12_0_ip_b=
lock =3D

 int smu_load_microcode(struct smu_context *smu)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2237,11 +2216,10 @@ int smu_load_microcode(struct smu_context *smu)

 int smu_check_fw_status(struct smu_context *smu)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2269,11 +2247,10 @@ int smu_set_gfx_cgpg(struct smu_context *smu, bool =
enabled)

 int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2290,12 +2267,11 @@ int smu_get_power_limit(struct smu_context *smu,
                         bool def,
                         bool lock_needed)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

         if (lock_needed) {
-               if (!adev->pm.dpm_enabled)
-                       return -EINVAL;
+               if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+                       return -EOPNOTSUPP;

                 mutex_lock(&smu->mutex);
         }
@@ -2311,11 +2287,10 @@ int smu_get_power_limit(struct smu_context *smu,

 int smu_set_power_limit(struct smu_context *smu, uint32_t limit)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2329,11 +2304,10 @@ int smu_set_power_limit(struct smu_context *smu, ui=
nt32_t limit)

 int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type clk_ty=
pe, char *buf)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2347,11 +2321,10 @@ int smu_print_clk_levels(struct smu_context *smu, e=
num smu_clk_type clk_type, ch

 int smu_get_od_percentage(struct smu_context *smu, enum smu_clk_type type)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2365,11 +2338,10 @@ int smu_get_od_percentage(struct smu_context *smu, =
enum smu_clk_type type)

 int smu_set_od_percentage(struct smu_context *smu, enum smu_clk_type type,=
 uint32_t value)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2385,11 +2357,10 @@ int smu_od_edit_dpm_table(struct smu_context *smu,
                           enum PP_OD_DPM_TABLE_COMMAND type,
                           long *input, uint32_t size)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2405,11 +2376,10 @@ int smu_read_sensor(struct smu_context *smu,
                     enum amd_pp_sensors sensor,
                     void *data, uint32_t *size)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2423,11 +2393,10 @@ int smu_read_sensor(struct smu_context *smu,

 int smu_get_power_profile_mode(struct smu_context *smu, char *buf)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2444,11 +2413,10 @@ int smu_set_power_profile_mode(struct smu_context *=
smu,
                                uint32_t param_size,
                                bool lock_needed)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         if (lock_needed)
                 mutex_lock(&smu->mutex);
@@ -2465,11 +2433,10 @@ int smu_set_power_profile_mode(struct smu_context *=
smu,

 int smu_get_fan_control_mode(struct smu_context *smu)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2483,11 +2450,10 @@ int smu_get_fan_control_mode(struct smu_context *sm=
u)

 int smu_set_fan_control_mode(struct smu_context *smu, int value)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2501,11 +2467,10 @@ int smu_set_fan_control_mode(struct smu_context *sm=
u, int value)

 int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *speed)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2519,11 +2484,10 @@ int smu_get_fan_speed_percent(struct smu_context *s=
mu, uint32_t *speed)

 int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2537,11 +2501,10 @@ int smu_set_fan_speed_percent(struct smu_context *s=
mu, uint32_t speed)

 int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2555,11 +2518,10 @@ int smu_get_fan_speed_rpm(struct smu_context *smu, =
uint32_t *speed)

 int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2573,11 +2535,10 @@ int smu_set_deep_sleep_dcefclk(struct smu_context *=
smu, int clk)

 int smu_set_active_display_count(struct smu_context *smu, uint32_t count)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         if (smu->ppt_funcs->set_active_display_count)
                 ret =3D smu->ppt_funcs->set_active_display_count(smu, coun=
t);
@@ -2589,11 +2550,10 @@ int smu_get_clock_by_type(struct smu_context *smu,
                           enum amd_pp_clock_type type,
                           struct amd_pp_clocks *clocks)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2608,11 +2568,10 @@ int smu_get_clock_by_type(struct smu_context *smu,
 int smu_get_max_high_clocks(struct smu_context *smu,
                             struct amd_pp_simple_clock_info *clocks)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2628,11 +2587,10 @@ int smu_get_clock_by_type_with_latency(struct smu_c=
ontext *smu,
                                        enum smu_clk_type clk_type,
                                        struct pp_clock_levels_with_latency=
 *clocks)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2648,11 +2606,10 @@ int smu_get_clock_by_type_with_voltage(struct smu_c=
ontext *smu,
                                        enum amd_pp_clock_type type,
                                        struct pp_clock_levels_with_voltage=
 *clocks)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2668,11 +2625,10 @@ int smu_get_clock_by_type_with_voltage(struct smu_c=
ontext *smu,
 int smu_display_clock_voltage_request(struct smu_context *smu,
                                       struct pp_display_clock_request *clo=
ck_req)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2687,11 +2643,10 @@ int smu_display_clock_voltage_request(struct smu_co=
ntext *smu,

 int smu_display_disable_memory_clock_switch(struct smu_context *smu, bool =
disable_memory_clock_switch)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D -EINVAL;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2705,11 +2660,10 @@ int smu_display_disable_memory_clock_switch(struct =
smu_context *smu, bool disabl

 int smu_notify_smu_enable_pwe(struct smu_context *smu)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2724,11 +2678,10 @@ int smu_notify_smu_enable_pwe(struct smu_context *s=
mu)
 int smu_set_xgmi_pstate(struct smu_context *smu,
                         uint32_t pstate)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2742,11 +2695,10 @@ int smu_set_xgmi_pstate(struct smu_context *smu,

 int smu_set_azalia_d3_pme(struct smu_context *smu)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2770,6 +2722,9 @@ bool smu_baco_is_support(struct smu_context *smu)
 {
         bool ret =3D false;

+       if (!smu->pm_enabled)
+               return false;
+
         mutex_lock(&smu->mutex);

         if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
@@ -2796,6 +2751,9 @@ int smu_baco_enter(struct smu_context *smu)
 {
         int ret =3D 0;

+       if (!smu->pm_enabled)
+               return -EOPNOTSUPP;
+
         mutex_lock(&smu->mutex);

         if (smu->ppt_funcs->baco_enter)
@@ -2810,6 +2768,9 @@ int smu_baco_exit(struct smu_context *smu)
 {
         int ret =3D 0;

+       if (!smu->pm_enabled)
+               return -EOPNOTSUPP;
+
         mutex_lock(&smu->mutex);

         if (smu->ppt_funcs->baco_exit)
@@ -2824,6 +2785,9 @@ int smu_mode2_reset(struct smu_context *smu)
 {
         int ret =3D 0;

+       if (!smu->pm_enabled)
+               return -EOPNOTSUPP;
+
         mutex_lock(&smu->mutex);

         if (smu->ppt_funcs->mode2_reset)
@@ -2837,11 +2801,10 @@ int smu_mode2_reset(struct smu_context *smu)
 int smu_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
                                          struct pp_smu_nv_clock_table *max=
_clocks)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2857,11 +2820,10 @@ int smu_get_uclk_dpm_states(struct smu_context *smu=
,
                             unsigned int *clock_values_in_khz,
                             unsigned int *num_states)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2876,10 +2838,9 @@ int smu_get_uclk_dpm_states(struct smu_context *smu,
 enum amd_pm_state_type smu_get_current_power_state(struct smu_context *smu=
)
 {
         enum amd_pm_state_type pm_state =3D POWER_STATE_TYPE_DEFAULT;
-       struct amdgpu_device *adev =3D smu->adev;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

@@ -2894,11 +2855,10 @@ enum amd_pm_state_type smu_get_current_power_state(=
struct smu_context *smu)
 int smu_get_dpm_clock_table(struct smu_context *smu,
                             struct dpm_clocks *clock_table)
 {
-       struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0;

-       if (!adev->pm.dpm_enabled)
-               return -EINVAL;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;

         mutex_lock(&smu->mutex);

--
2.26.2


--_000_DM6PR12MB4482BECF79B7DD26C4F362E5F0B30DM6PR12MB4482namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Have an improvement suggestion inline. Whether it is accepted or not, the p=
atch is</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; backgrou=
nd-color: rgb(255, 255, 255); display: inline !important">Tested-by: Yong Z=
hao &lt;Yong.Zhao@amd.com&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Monday, May 25, 2020 2:37 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhao, Yong=
 &lt;Yong.Zhao@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: check whether SMU IP is enabled =
before access</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Since on early phase of bringup, the SMU IP may be=
 not enabled or<br>
supported. Without this, we may hit null pointer dereference on<br>
accessing smu-&gt;adev.<br>
<br>
Change-Id: I644175e926cd4fef8259f89002d6f8eda04fe42c<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 266 &#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;------------<br>
&nbsp;1 file changed, 113 insertions(&#43;), 153 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index a78a1f542ea9..f7428996cc74 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -61,7 &#43;61,6 @@ const char *smu_get_feature_name(struct smu_context *=
smu, enum smu_feature_mask<br>
&nbsp;<br>
&nbsp;size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf=
)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t size =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0, i =3D 0;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask[2] =
=3D { 0 };<br>
@@ -70,8 &#43;69,8 @@ size_t smu_sys_get_pp_feature_mask(struct smu_context=
 *smu, char *buf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sort_feature[SMU_=
FEATURE_COUNT];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t hw_feature_count =
=3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -155,10 &#43;154,9 @@ int smu_sys_set_pp_feature_mask(struct smu_context=
 *smu, uint64_t new_mask)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t feature_2_enabled=
 =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t feature_2_disable=
d =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t feature_enables =
=3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -436,11 &#43;434,10 @@ bool smu_clk_dpm_is_enabled(struct smu_context *s=
mu, enum smu_clk_type clk_type)<br>
&nbsp;int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_ty=
pe,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; bool gate)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (block_type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_UVD=
:<br>
@@ -577,11 &#43;574,10 @@ bool is_support_sw_smu(struct amdgpu_device *adev=
)<br>
&nbsp;int smu_sys_get_pp_table(struct smu_context *smu, void **table)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t powerplay_table_s=
ize;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_table-&gt;power_p=
lay_table &amp;&amp; !smu_table-&gt;hardcode_pptable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -603,12 &#43;599,11 @@ int smu_sys_get_pp_table(struct smu_context *smu,=
 void **table)<br>
&nbsp;int smu_sys_set_pp_table(struct smu_context *smu,&nbsp; void *buf, si=
ze_t size)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATOM_COMMON_TABLE_HEADER *=
header =3D (ATOM_COMMON_TABLE_HEADER *)buf;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (header-&gt;usStructure=
Size !=3D size) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_err(&quot;pp table size not matched !\n&quot;);<br=
>
@@ -1622,15 &#43;1617,11 @@ static int smu_resume(void *handle)<br>
&nbsp;int smu_display_configuration_change(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; co=
nst struct amd_pp_display_configuration *display_config)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int index =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int num_of_active_display =
=3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!is_support_sw_smu(smu-&gt;adev))=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!display_config)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -1691,15 &#43;1682,11 @@ int smu_get_current_clocks(struct smu_context *=
smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; struct amd_pp_clock_info *clocks)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_simple_clock=
_info simple_clocks =3D {0};<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_clock_info hw_c=
locks;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!is_support_sw_smu(smu-&gt;adev))=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -1855,11 &#43;1842,10 @@ int smu_handle_task(struct smu_context *smu,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pp_task task_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool lock_needed)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (lock_needed)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mutex);<br>
@@ -1894,12 &#43;1880,11 @@ int smu_switch_power_profile(struct smu_context=
 *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; bool en)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long workload;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(type &lt; PP_SMC_POW=
ER_PROFILE_CUSTOM))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -1929,11 &#43;1914,10 @@ int smu_switch_power_profile(struct smu_context=
 *smu,<br>
&nbsp;enum amd_dpm_forced_level smu_get_performance_level(struct smu_contex=
t *smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dpm_forced_level =
level;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;is_apu &amp;&=
amp; !smu_dpm_ctx-&gt;dpm_context)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -1948,11 &#43;1932,10 @@ enum amd_dpm_forced_level smu_get_performance_l=
evel(struct smu_context *smu)<br>
&nbsp;int smu_force_performance_level(struct smu_context *smu, enum amd_dpm=
_forced_level level)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;is_apu &amp;&=
amp; !smu_dpm_ctx-&gt;dpm_context)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -1976,11 &#43;1959,10 @@ int smu_force_performance_level(struct smu_cont=
ext *smu, enum amd_dpm_forced_lev<br>
&nbsp;<br>
&nbsp;int smu_set_display_count(struct smu_context *smu, uint32_t count)<br=
>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_init_display_c=
ount(smu, count);<br>
@@ -1995,11 &#43;1977,10 @@ int smu_force_clk_levels(struct smu_context *sm=
u,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 bool lock_needed)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_dpm_ctx-&gt;dpm_le=
vel !=3D AMD_DPM_FORCED_LEVEL_MANUAL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;force clock level is for dpm manual mo=
de only.\n&quot;);<br>
@@ -2031,6 &#43;2012,9 @@ int smu_set_mp1_state(struct smu_context *smu,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t msg;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;</div>
<div class=3D"PlainText">[yz] Is this needed? We can just check the conditi=
on at the entry functions rather than all functions. This also applies to o=
ther similar places like this.&nbsp;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (mp1_state) {<br>
@@ -2067,11 &#43;2051,10 @@ int smu_set_mp1_state(struct smu_context *smu,<=
br>
&nbsp;int smu_set_df_cstate(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_df_cstate=
 state)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;ppt_funcs || =
!smu-&gt;ppt_funcs-&gt;set_df_cstate)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -2089,11 &#43;2072,10 @@ int smu_set_df_cstate(struct smu_context *smu,<=
br>
&nbsp;<br>
&nbsp;int smu_allow_xgmi_power_down(struct smu_context *smu, bool en)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;ppt_funcs || =
!smu-&gt;ppt_funcs-&gt;allow_xgmi_power_down)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -2127,10 &#43;2109,9 @@ int smu_set_watermarks_for_clock_ranges(struct s=
mu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_r=
anges)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *table =3D smu-&gt;sm=
u_table.watermarks_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!table)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -2155,11 &#43;2136,10 @@ int smu_set_watermarks_for_clock_ranges(struct =
smu_context *smu,<br>
&nbsp;<br>
&nbsp;int smu_set_ac_dc(struct smu_context *smu)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* controlled by firmware =
*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;dc_controlled_=
by_gpio)<br>
@@ -2219,11 &#43;2199,10 @@ const struct amdgpu_ip_block_version smu_v12_0_=
ip_block =3D<br>
&nbsp;<br>
&nbsp;int smu_load_microcode(struct smu_context *smu)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2237,11 &#43;2216,10 @@ int smu_load_microcode(struct smu_context *smu)=
<br>
&nbsp;<br>
&nbsp;int smu_check_fw_status(struct smu_context *smu)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2269,11 &#43;2247,10 @@ int smu_set_gfx_cgpg(struct smu_context *smu, b=
ool enabled)<br>
&nbsp;<br>
&nbsp;int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed)<br=
>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2290,12 &#43;2267,11 @@ int smu_get_power_limit(struct smu_context *smu=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool =
def,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool =
lock_needed)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (lock_needed) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&gt;adev-&gt;pm.dpm_enabled)=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EOPN=
OTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -2311,11 &#43;2287,10 @@ int smu_get_power_limit(struct smu_context *smu=
,<br>
&nbsp;<br>
&nbsp;int smu_set_power_limit(struct smu_context *smu, uint32_t limit)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2329,11 &#43;2304,10 @@ int smu_set_power_limit(struct smu_context *smu=
, uint32_t limit)<br>
&nbsp;<br>
&nbsp;int smu_print_clk_levels(struct smu_context *smu, enum smu_clk_type c=
lk_type, char *buf)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2347,11 &#43;2321,10 @@ int smu_print_clk_levels(struct smu_context *sm=
u, enum smu_clk_type clk_type, ch<br>
&nbsp;<br>
&nbsp;int smu_get_od_percentage(struct smu_context *smu, enum smu_clk_type =
type)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2365,11 &#43;2338,10 @@ int smu_get_od_percentage(struct smu_context *s=
mu, enum smu_clk_type type)<br>
&nbsp;<br>
&nbsp;int smu_set_od_percentage(struct smu_context *smu, enum smu_clk_type =
type, uint32_t value)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2385,11 &#43;2357,10 @@ int smu_od_edit_dpm_table(struct smu_context *s=
mu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; enum PP_OD_DPM_TABLE_COMMAND type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; long *input, uint32_t size)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2405,11 &#43;2376,10 @@ int smu_read_sensor(struct smu_context *smu,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pp_sensors sensor,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *data, uint32_t *size)<b=
r>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2423,11 &#43;2393,10 @@ int smu_read_sensor(struct smu_context *smu,<br=
>
&nbsp;<br>
&nbsp;int smu_get_power_profile_mode(struct smu_context *smu, char *buf)<br=
>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2444,11 &#43;2413,10 @@ int smu_set_power_profile_mode(struct smu_conte=
xt *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t param_size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool lock_needed)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (lock_needed)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mutex);<br>
@@ -2465,11 &#43;2433,10 @@ int smu_set_power_profile_mode(struct smu_conte=
xt *smu,<br>
&nbsp;<br>
&nbsp;int smu_get_fan_control_mode(struct smu_context *smu)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2483,11 &#43;2450,10 @@ int smu_get_fan_control_mode(struct smu_context=
 *smu)<br>
&nbsp;<br>
&nbsp;int smu_set_fan_control_mode(struct smu_context *smu, int value)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2501,11 &#43;2467,10 @@ int smu_set_fan_control_mode(struct smu_context=
 *smu, int value)<br>
&nbsp;<br>
&nbsp;int smu_get_fan_speed_percent(struct smu_context *smu, uint32_t *spee=
d)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2519,11 &#43;2484,10 @@ int smu_get_fan_speed_percent(struct smu_contex=
t *smu, uint32_t *speed)<br>
&nbsp;<br>
&nbsp;int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed=
)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2537,11 &#43;2501,10 @@ int smu_set_fan_speed_percent(struct smu_contex=
t *smu, uint32_t speed)<br>
&nbsp;<br>
&nbsp;int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed)<b=
r>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2555,11 &#43;2518,10 @@ int smu_get_fan_speed_rpm(struct smu_context *s=
mu, uint32_t *speed)<br>
&nbsp;<br>
&nbsp;int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2573,11 &#43;2535,10 @@ int smu_set_deep_sleep_dcefclk(struct smu_conte=
xt *smu, int clk)<br>
&nbsp;<br>
&nbsp;int smu_set_active_display_count(struct smu_context *smu, uint32_t co=
unt)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;ppt_funcs-&gt;=
set_active_display_count)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu-&gt;ppt_funcs-&gt;set_active_display_coun=
t(smu, count);<br>
@@ -2589,11 &#43;2550,10 @@ int smu_get_clock_by_type(struct smu_context *s=
mu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; enum amd_pp_clock_type type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; struct amd_pp_clocks *clocks)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2608,11 &#43;2568,10 @@ int smu_get_clock_by_type(struct smu_context *s=
mu,<br>
&nbsp;int smu_get_max_high_clocks(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; struct amd_pp_simple_clock_info *clocks)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2628,11 &#43;2587,10 @@ int smu_get_clock_by_type_with_latency(struct s=
mu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; enum smu_clk_type clk_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct pp_clock_levels_with_latency *clocks)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2648,11 &#43;2606,10 @@ int smu_get_clock_by_type_with_voltage(struct s=
mu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; enum amd_pp_clock_type type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct pp_clock_levels_with_voltage *clocks)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2668,11 &#43;2625,10 @@ int smu_get_clock_by_type_with_voltage(struct s=
mu_context *smu,<br>
&nbsp;int smu_display_clock_voltage_request(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct pp_display_clock_request *clock_req)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2687,11 &#43;2643,10 @@ int smu_display_clock_voltage_request(struct sm=
u_context *smu,<br>
&nbsp;<br>
&nbsp;int smu_display_disable_memory_clock_switch(struct smu_context *smu, =
bool disable_memory_clock_switch)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2705,11 &#43;2660,10 @@ int smu_display_disable_memory_clock_switch(str=
uct smu_context *smu, bool disabl<br>
&nbsp;<br>
&nbsp;int smu_notify_smu_enable_pwe(struct smu_context *smu)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2724,11 &#43;2678,10 @@ int smu_notify_smu_enable_pwe(struct smu_contex=
t *smu)<br>
&nbsp;int smu_set_xgmi_pstate(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t pstate)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2742,11 &#43;2695,10 @@ int smu_set_xgmi_pstate(struct smu_context *smu=
,<br>
&nbsp;<br>
&nbsp;int smu_set_azalia_d3_pme(struct smu_context *smu)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2770,6 &#43;2722,9 @@ bool smu_baco_is_support(struct smu_context *smu)=
<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret =3D false;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;ppt_funcs &amp=
;&amp; smu-&gt;ppt_funcs-&gt;baco_is_support)<br>
@@ -2796,6 &#43;2751,9 @@ int smu_baco_enter(struct smu_context *smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;ppt_funcs-&gt;=
baco_enter)<br>
@@ -2810,6 &#43;2768,9 @@ int smu_baco_exit(struct smu_context *smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;ppt_funcs-&gt;=
baco_exit)<br>
@@ -2824,6 &#43;2785,9 @@ int smu_mode2_reset(struct smu_context *smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;ppt_funcs-&gt;=
mode2_reset)<br>
@@ -2837,11 &#43;2801,10 @@ int smu_mode2_reset(struct smu_context *smu)<br=
>
&nbsp;int smu_get_max_sustainable_clocks_by_dc(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct pp_smu_nv_clock_table *max_clocks)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2857,11 &#43;2820,10 @@ int smu_get_uclk_dpm_states(struct smu_context =
*smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; unsigned int *clock_values_in_khz,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; unsigned int *num_states)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2876,10 &#43;2838,9 @@ int smu_get_uclk_dpm_states(struct smu_context *=
smu,<br>
&nbsp;enum amd_pm_state_type smu_get_current_power_state(struct smu_context=
 *smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_state_type pm_=
state =3D POWER_STATE_TYPE_DEFAULT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
@@ -2894,11 &#43;2855,10 @@ enum amd_pm_state_type smu_get_current_power_st=
ate(struct smu_context *smu)<br>
&nbsp;int smu_get_dpm_clock_table(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; struct dpm_clocks *clock_table)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;pm.dpm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled || !smu-&=
gt;adev-&gt;pm.dpm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
-- <br>
2.26.2<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB4482BECF79B7DD26C4F362E5F0B30DM6PR12MB4482namp_--

--===============0289765650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0289765650==--
