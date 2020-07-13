Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5B9C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 03:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF522068F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 03:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OZZjQrZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF522068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64ABC6E151;
	Mon, 13 Jul 2020 03:19:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C9986E151
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 03:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJzW3fMyGHkRkEpu+j+d4PjT7vVKWGv02iHUdC9WKJdOHMq8iSsUXUM1G2sZCX3RYiR5apWtqenb/aXMkw3Q8c11lA2dd5TJGRz3krT6PuVPJKO5Myk97p77oDA/IrsC7p8HLy+9h+JXKs3vF/Gkx/QPvUd5M2++7BAqUWIzxlLfxXSX808ur5I6kdv2zjl1Ax5bAXLpBGRVBwFgl5NXlj7dWcbJlE7TN5JMuTbGJj4wJRzesE0IXqlbBNPRdikLy8yxzqOSz60KSJZd12dzrTG8l7zXYeTcxh4YmoNm1mGG2L61heSwsU08eq+MzOwzNf7sAOVrv2Ls1s1nS1VmRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9C6VMUf2K8GV6RCkZaawkJBP7n8XlLU1PqNY7dMXyA=;
 b=JzQ8AemIjssEqxMsHDeZVcUsqL2cZNvgR/J0mWeYxVApjaPZa01LYzCUVWAmjVFOv1uwPaZx35aeVQdJy4ocIvD3DKIVWEybYGqKYpys76tPipxZOrOxJQ1injsztFguKt/oDIVfEVJmFe1tLFV4YJUVOD+bslzWGNxIZ+9UubFSDQ/8hSjjMCtl5jeDjUqieCUeW5jNvuBtzucHFCLwyhTQgj/up00gU55Rln/8WziIPg7UqY2XJLQmlnETjp2b38Zj+fpuHNQeebB4c0Vv4a6iAE2czNl+Chmy1ozlIU0bHWIaeBo8wFQTqpmwI8M95mn7rmwjuYTjaCy7R1TB3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9C6VMUf2K8GV6RCkZaawkJBP7n8XlLU1PqNY7dMXyA=;
 b=OZZjQrZuZCxGF5URKZkFNxKKlO4mteWRqaS5lJTGYowzSvZWtNJsFUnwX3UIvfT1BnFUQ9LEzhx0H8jqe8BcdivYIYQfvf0yTmtA3CdWl6BE+SuDj46r1ANs1pyojNFVnVxCm7nl2lwaBIbBt3hNr5LC5dl/wft7FMDAZ4R+zKc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Mon, 13 Jul 2020 03:19:25 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Mon, 13 Jul 2020
 03:19:25 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amd/powerplay: add SMU mode1 reset
Thread-Topic: [PATCH 1/3] drm/amd/powerplay: add SMU mode1 reset
Thread-Index: AQHWVsTOTTHDWtv3nEOY8QfAwykYTakE2u0Q
Date: Mon, 13 Jul 2020 03:19:25 +0000
Message-ID: <DM6PR12MB2619642C2D9700ED17E60BB6E4600@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200710141644.1601-1-Wenhui.Sheng@amd.com>
In-Reply-To: <20200710141644.1601-1-Wenhui.Sheng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bd30342a-aa4e-40ba-9fd6-00005997e701;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-13T03:18:09Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50702f2d-fffe-460d-e49e-08d826db8bce
x-ms-traffictypediagnostic: DM5PR12MB1354:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1354BD24A6ACBDF5280B9F89E4600@DM5PR12MB1354.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KfWNaOz+RJ4WAjdykYrSyzl8rJSEXT3kCVyqnmhuCgtVl8F/SvMpz6Y3kgaV40Mky5N+5wz8XdJVhcRS3jCIdpZslRs+DudPU4qKqlCXgwjSUij+OsOobf78IarrYYtHz1TJPeOaV0I3QLJY305b4IESGF8iAFhyls4raLIbgg6/erwZTBghQPhwDrBOJJLMgWt0GXsSeJwWUe2Yb+gTZ15Ql2k/0sc1HIOB653lYxMCh55P0/ntiFlSvT4vEnhp+HqzkrC2PbtSJU/k8k/A9lVWDtpr0Prq7HN9ee89+8aOnkHCV2UCTwvc16WxO0bEJXOXciPnkscShVQv8BxdnttIdmzt5kWk/IbTnAE0oNY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(54906003)(52536014)(9686003)(5660300002)(478600001)(45080400002)(110136005)(966005)(316002)(8936002)(8676002)(71200400001)(55016002)(33656002)(2906002)(86362001)(6506007)(53546011)(186003)(66446008)(4326008)(26005)(66946007)(76116006)(83380400001)(66556008)(66476007)(64756008)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ky7Hb/EbDt3EK6ceSOXpm6GFDMqQuVC5nGBnX2G+As5qUYvtFhDouPG37vdVYzwT4/PA5suauu9k62eBAHVvlFlImL7wHB5QCgmOEY5KZIaiiMst4uWmRqza/rhF6dJTyYMoXwvQQRsNvITGFp0ZmZCB5iNv+dY0Ibuf4m6HdS9cUENIqdCebSv4gjgVoJu2+8iYpFJ6bJTvaiKIBY0OcqsfWdl87AJ7UqO+lBNnwKJc4IF9fTZMjI7TEVKhLTCmrz7yugloV9b6C3xt9ZV0Dz8VePS3cO26yr+sNHrSNoHqER7dO2lprIbhnutkny8r9n/DBKQ7UvQFz1QMTh88Bl8CAbKTH89ORABVq5MyuSqpSKVOcouew1lENlH9y8WNrPtRuG1e90uIBZ+MV7WDjApY9xTdgnMxcUJXEcDlPjEeuYpMiEqmnmovDBROBp+M3C+N2Owe8AHQEORGWEdiT97NRUFqtZHBtWSj5AJDFxjTu6hKIIbhz1bjSeFzrlGX
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50702f2d-fffe-460d-e49e-08d826db8bce
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 03:19:25.7191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +5wkK/HbTMG5GMw6gOiUvqmGF7mU8/KJxDtl6unR+HXl6uUCgfnpfrH60WFQkg8u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>, "Sheng, Wenhui" <Wenhui.Sheng@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wenhui Sheng
Sent: Friday, July 10, 2020 10:17 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 1/3] drm/amd/powerplay: add SMU mode1 reset

From PM FW 58.26.0 for sienna cichlid, SMU mode1 reset is support, driver sends PPSMC_MSG_Mode1Reset message to PM FW could trigger this reset.

v2: add mode1 reset dpm interface

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c       | 20 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h       |  3 ++
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 34 +++++++++++++++++++
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  4 +++
 drivers/gpu/drm/amd/powerplay/inc/smu_types.h |  1 +  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 ++
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 31 +++++++++++++++--
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 13 +++++++
 8 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
index 65472b3dd815..16668fc52d0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
@@ -1141,6 +1141,26 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
 return 0;
 }

+bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev) {
+struct smu_context *smu = &adev->smu;
+
+if (is_support_sw_smu(adev))
+return smu_mode1_reset_is_support(smu);
+
+return false;
+}
+
+int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev) {
+struct smu_context *smu = &adev->smu;
+
+if (is_support_sw_smu(adev))
+return smu_mode1_reset(smu);
+
+return -EOPNOTSUPP;
+}
+
 int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
     enum PP_SMC_POWER_PROFILE type,
     bool en)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
index 6a8aae70a0e6..7f3cd7185650 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
@@ -529,6 +529,9 @@ int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);

 bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev);

+bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev);
+int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev);
+
 int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
      enum pp_mp1_state mp1_state);

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index fe4948aa662f..b5a7422d9548 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -2737,6 +2737,40 @@ int smu_baco_exit(struct smu_context *smu)
 return ret;
 }

+bool smu_mode1_reset_is_support(struct smu_context *smu) {
+bool ret = false;
+
+if (!smu->pm_enabled)
+return false;
+
+mutex_lock(&smu->mutex);
+
+if (smu->ppt_funcs && smu->ppt_funcs->mode1_reset_is_support)
+ret = smu->ppt_funcs->mode1_reset_is_support(smu);
+
+mutex_unlock(&smu->mutex);
+
+return ret;
+}
+
+int smu_mode1_reset(struct smu_context *smu) {
+int ret = 0;
+
+if (!smu->pm_enabled)
+return -EOPNOTSUPP;
+
+mutex_lock(&smu->mutex);
+
+if (smu->ppt_funcs->mode1_reset)
+ret = smu->ppt_funcs->mode1_reset(smu);
+
+mutex_unlock(&smu->mutex);
+
+return ret;
+}
+
 int smu_mode2_reset(struct smu_context *smu)  {
 int ret = 0;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 7b349e038972..ba59620950d7 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -561,6 +561,8 @@ struct pptable_funcs {
 int (*baco_set_state)(struct smu_context *smu, enum smu_baco_state state);
 int (*baco_enter)(struct smu_context *smu);
 int (*baco_exit)(struct smu_context *smu);
+bool (*mode1_reset_is_support)(struct smu_context *smu);
+int (*mode1_reset)(struct smu_context *smu);
 int (*mode2_reset)(struct smu_context *smu);
 int (*get_dpm_ultimate_freq)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t *min, uint32_t *max);
 int (*set_soft_freq_limited_range)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t min, uint32_t max); @@ -672,6 +674,8 @@ int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state);  int smu_baco_enter(struct smu_context *smu);  int smu_baco_exit(struct smu_context *smu);

+bool smu_mode1_reset_is_support(struct smu_context *smu); int
+smu_mode1_reset(struct smu_context *smu);
 int smu_mode2_reset(struct smu_context *smu);

 extern int smu_get_atom_data_table(struct smu_context *smu, uint32_t table, diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
index dff2295705be..7b585e205a5a 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
@@ -173,6 +173,7 @@
 __SMU_DUMMY_MAP(GmiPwrDnControl), \
 __SMU_DUMMY_MAP(DAL_DISABLE_DUMMY_PSTATE_CHANGE), \
 __SMU_DUMMY_MAP(DAL_ENABLE_DUMMY_PSTATE_CHANGE), \
+__SMU_DUMMY_MAP(Mode1Reset), \

 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index d07bf4fe6e4a..38599112ae59 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -252,6 +252,8 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)  int smu_v11_0_baco_enter(struct smu_context *smu);  int smu_v11_0_baco_exit(struct smu_context *smu);

+int smu_v11_0_mode1_reset(struct smu_context *smu);
+
 int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
  uint32_t *min, uint32_t *max);

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index dc5ca9121db5..319480550bb7 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -39,8 +39,8 @@
 #include "nbio/nbio_2_3_sh_mask.h"
 #include "thm/thm_11_0_2_offset.h"
 #include "thm/thm_11_0_2_sh_mask.h"
-
-#include "asic_reg/mp/mp_11_0_sh_mask.h"
+#include "mp/mp_11_0_offset.h"
+#include "mp/mp_11_0_sh_mask.h"

 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -116,6 +116,7 @@ static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_message_map[SMU_MSG_MAX_C
 MSG_MAP(PowerDownJpeg,PPSMC_MSG_PowerDownJpeg),
 MSG_MAP(BacoAudioD3PME,PPSMC_MSG_BacoAudioD3PME),
 MSG_MAP(ArmD3,PPSMC_MSG_ArmD3),
+MSG_MAP(Mode1Reset,PPSMC_MSG_Mode1Reset),
 };

 static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = { @@ -1760,13 +1761,35 @@ static bool sienna_cichlid_is_baco_supported(struct smu_context *smu)
 struct amdgpu_device *adev = smu->adev;
 uint32_t val;

-if (!smu_v11_0_baco_is_support(smu))
+if (amdgpu_sriov_vf(adev) || (!smu_v11_0_baco_is_support(smu)))
 return false;
[Quan, Evan] This seems irrelevant. Better to create a separate patch for this.

 val = RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
 return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false;  }

+static bool sienna_cichlid_is_mode1_reset_supported(struct smu_context
+*smu) {
+struct amdgpu_device *adev = smu->adev;
+uint32_t val;
+u32 smu_version;
+
+/**
+ * SRIOV env will not support SMU mode1 reset
+ * PM FW support mode1 reset from 58.26
+ */
+smu_get_smc_version(smu, NULL, &smu_version);
+if (amdgpu_sriov_vf(adev) || (smu_version < 0x003a1a00))
+return false;
+
+/**
+ * mode1 reset relies on PSP, so we should check if
+ * PSP is alive.
+ */
+val = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
+return val != 0x0;
+}
+
 static int sienna_cichlid_set_thermal_range(struct smu_context *smu,
        struct smu_temperature_range range)  { @@ -2538,6 +2561,8 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 .baco_set_state = smu_v11_0_baco_set_state,
 .baco_enter = smu_v11_0_baco_enter,
 .baco_exit = smu_v11_0_baco_exit,
+.mode1_reset_is_support = sienna_cichlid_is_mode1_reset_supported,
+.mode1_reset = smu_v11_0_mode1_reset,
 .get_dpm_ultimate_freq = sienna_cichlid_get_dpm_ultimate_freq,
 .set_soft_freq_limited_range = sienna_cichlid_set_soft_freq_limited_range,
 .override_pcie_parameters = smu_v11_0_override_pcie_parameters,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 48e15885e9c3..c620dccb82e5 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -63,6 +63,8 @@ MODULE_FIRMWARE("amdgpu/sienna_cichlid_smc.bin");

 #define SMU11_VOLTAGE_SCALE 4

+#define SMU11_MODE1_RESET_WAIT_TIME 500  //500ms
+
 static int smu_v11_0_send_msg_without_waiting(struct smu_context *smu,
       uint16_t msg)
 {
@@ -1741,6 +1743,17 @@ int smu_v11_0_baco_exit(struct smu_context *smu)
 return ret;
 }

+int smu_v11_0_mode1_reset(struct smu_context *smu) {
+int ret = 0;
+
+ret = smu_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
+if (!ret)
+msleep(SMU11_MODE1_RESET_WAIT_TIME);
+
+return ret;
+}
+
 int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
  uint32_t *min, uint32_t *max)
 {
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C5125fa5f71e245a34f4608d824dbec23%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637299874326587249&amp;sdata=2pLBrCIvPkTh9tepSjuI2XU3VHhLtJjCmgm4MrzLl%2Fo%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
