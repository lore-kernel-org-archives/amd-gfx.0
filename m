Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9F5C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 03:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB9E20724
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 03:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PLn7Iy+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB9E20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 786E36E151;
	Mon, 13 Jul 2020 03:43:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 052D76E151
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 03:43:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqUhJpOV+/UruD2UZCXpFwsgGGuinZUaq2LKPA8wULvArv7vd6JCKJGYrCI+isZU23D1QsuWrOypSSdU/npNKmul5qNTRitImFHDXj8jgjT3Qo5fbpDlIvdN6vEOF8yUyojWdtUeMZw5QdtuDdP9BPyX45QuRsRruE+jP6PREytDPsub2448RqYYM6CZMF59DxO6GxyM/DDk3z+n/npSOMI/ufd5C7L3D38HZM2Ta14geROeg3JxA7KH9nH3C/hDCCf6vBORIGNgKHbukdGoYTANPJkuXnU1FckAQ2JA54CjYjylFvgFmwGVp6JsGnLcR6fYKQ78jFJRh0lLDfp4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2n71p51JnCJ0dyvdXZGxUNgLKN5FB6kIi3j3vGqnMw8=;
 b=F61AlSHEYYfqz0cO7iyi1kCLVaWu1Xo5Q5OE0Fkg+6VY98C/BkCyD+r1ncU5muVL4wjgmaavT/5oqTp9jj/8vwMhGf03ZLzHoA8REghgguBGm9XRzmkns9Q4APBGCszyVUdEQzuZfp9VkZQu/QaAC9xdXZTZEwaq+jXVgPS73vSfuBSHLemGqMITBvGAb5Sqy4S5sHdA7t3TYz22lsOBSVrjFCza+PRCx3XwvEIHa4FUnOcTQRDrks8/kSsPpVBJixtrvAhxQ59GMDy5PU8OHRzoXZ5kdsu5U+AMUUmRMj7oKKXu2fevLQx3QkXOOatxKNbSVfYqLT/eNN19I+vlFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2n71p51JnCJ0dyvdXZGxUNgLKN5FB6kIi3j3vGqnMw8=;
 b=PLn7Iy+5EA+JOVU3Xbo5ar3DMwMHPTjXYF38PUHGfvEXWlYW0q/VybNFQJsh5jBiZ1cZ4woY1v4u/i+OIA9JmHeWGgO/HnhJssMR5OFTjQtwlD/DY13vssE8FysdDS1FzZEIgWxrvcbz6qC0LkhRK1mQPHZQ7CcCv2TS5BwfAng=
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.24; Mon, 13 Jul
 2020 03:43:41 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%8]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 03:43:41 +0000
From: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amd/powerplay: add SMU mode1 reset
Thread-Topic: [PATCH 1/3] drm/amd/powerplay: add SMU mode1 reset
Thread-Index: AQHWVsTGFOy2KJGq4UKGt0BgUalmGKkE20iAgAAGtMA=
Date: Mon, 13 Jul 2020 03:43:41 +0000
Message-ID: <CH2PR12MB41018EC8114BB150487DCB7A8C600@CH2PR12MB4101.namprd12.prod.outlook.com>
References: <20200710141644.1601-1-Wenhui.Sheng@amd.com>
 <DM6PR12MB2619642C2D9700ED17E60BB6E4600@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619642C2D9700ED17E60BB6E4600@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
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
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-13T03:43:37Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: c4c16c1a-2cd3-45b5-ab7f-0000ac34f2e8
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ccbb621-40c4-4e76-1ca5-08d826deefad
x-ms-traffictypediagnostic: CH2PR12MB4166:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB41663D95CC42A83D6A8CACE58C600@CH2PR12MB4166.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XwjVgizVLilwMBjL2Zf4R1duhRWgX7YpfoWj946Eza2g2gpyRi2t9Sie5lULyoKczFzNENzGlOk87I6MU4Ge0eZh5k2QHUzPCvkCEAOTGcZvRmto6rbb/F69QF5XySK81c9HwlZo0qVM672S4PGBsXNE0N8sYrnrMTuNHpz1p1zoeU2iDcvCv53wsKOM/PLzBrCXOGYTmlhlhnSST20ZzOssRRpN1/3PH6tTtj4lmx6ZROvx0zqSozloxZ7llnkVFfVy0moNxYHz9aWBTsIwxXQUX+7EyqOfQjphrNk26Ix7N1sqiG2pRtkMEhngKKl8ly0UDP0ThsRD7VYzqNSS/SnIybyscjeFgX9pf65tbDw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(45080400002)(8676002)(2906002)(478600001)(83380400001)(5660300002)(4326008)(966005)(52536014)(316002)(9686003)(6506007)(53546011)(7696005)(110136005)(8936002)(86362001)(54906003)(186003)(33656002)(66556008)(55016002)(71200400001)(66476007)(66946007)(26005)(66446008)(64756008)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: oiM78bXrcVUvN7opUqzSFHL6SYZFub0WiIIpETx9ib65hsokNga2Xa6vfp8MJ4YdLdI1A3fvpW/xLu0YRFKmU8aJY8LzP9QDk427ypFrdHlfyFoX7YC7L989IXhf6QaQRU3s7taGxIFe8kgFwiWKyJ9ILjPQ5sIEWT+vXBs3lPOA02ooJD4+A58RT/bGOK6zsBsJjmMHExPxUwptxT8wDQpnqW97sUAI0S1P8BZRx/5K6rdQP6oFNfo7ITquZdk9a4PIOPNipf3n3ZDs/L9MWpIGb6l6/OOAI6rhxKse4SmWPqDt7E03+EolbnTz+JrRPvZxyt2Ns+3PjyA3qXVisL2JImPfCJUnUnlC2/7lY9Xrvr4NUSw7pPNsV0lddPVqzIPfboQihXm+oO1iLB/VNhgFKnC8dBamzPCIO2Xqv/Aa8ts7l6GcT0szc1ZzhBne66kwIIhN3gOeBMSs+OFzgAEUzOYzAdBEJR5t30eTrhKscZ+Dlz64AGUtPBnd1Nai
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccbb621-40c4-4e76-1ca5-08d826deefad
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 03:43:41.7564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ryWFdV9BgfazeS016sVJH0GhwSzL7HcHl7no/p4YyxOFyqDL0f6/cJ1bN8/+fMOwWQbYK2zqs3Vy/NPg8abKJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]

Ok will refine it.

Brs
Wenhui

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Monday, July 13, 2020 11:19 AM
To: Sheng, Wenhui <Wenhui.Sheng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 1/3] drm/amd/powerplay: add SMU mode1 reset

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
@@ -1141,6 +1141,26 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)  return 0;  }

+bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev) {
+struct smu_context *smu = &adev->smu;
+
+if (is_support_sw_smu(adev))
+return smu_mode1_reset_is_support(smu);
+
+return false;
+}
+
+int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev) { struct
+smu_context *smu = &adev->smu;
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
@@ -2737,6 +2737,40 @@ int smu_baco_exit(struct smu_context *smu)  return ret;  }

+bool smu_mode1_reset_is_support(struct smu_context *smu) { bool ret =
+false;
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
+int smu_mode1_reset(struct smu_context *smu) { int ret = 0;
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
 int smu_mode2_reset(struct smu_context *smu)  {  int ret = 0; diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 7b349e038972..ba59620950d7 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -561,6 +561,8 @@ struct pptable_funcs {  int (*baco_set_state)(struct smu_context *smu, enum smu_baco_state state);  int (*baco_enter)(struct smu_context *smu);  int (*baco_exit)(struct smu_context *smu);
+bool (*mode1_reset_is_support)(struct smu_context *smu); int
+(*mode1_reset)(struct smu_context *smu);
 int (*mode2_reset)(struct smu_context *smu);  int (*get_dpm_ultimate_freq)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t *min, uint32_t *max);  int (*set_soft_freq_limited_range)(struct smu_context *smu, enum smu_clk_type clk_type, uint32_t min, uint32_t max); @@ -672,6 +674,8 @@ int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state);  int smu_baco_enter(struct smu_context *smu);  int smu_baco_exit(struct smu_context *smu);

+bool smu_mode1_reset_is_support(struct smu_context *smu); int
+smu_mode1_reset(struct smu_context *smu);
 int smu_mode2_reset(struct smu_context *smu);

 extern int smu_get_atom_data_table(struct smu_context *smu, uint32_t table, diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
index dff2295705be..7b585e205a5a 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
@@ -173,6 +173,7 @@
 __SMU_DUMMY_MAP(GmiPwrDnControl), \
 __SMU_DUMMY_MAP(DAL_DISABLE_DUMMY_PSTATE_CHANGE), \  __SMU_DUMMY_MAP(DAL_ENABLE_DUMMY_PSTATE_CHANGE), \
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

 static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = { @@ -1760,13 +1761,35 @@ static bool sienna_cichlid_is_baco_supported(struct smu_context *smu)  struct amdgpu_device *adev = smu->adev;  uint32_t val;

-if (!smu_v11_0_baco_is_support(smu))
+if (amdgpu_sriov_vf(adev) || (!smu_v11_0_baco_is_support(smu)))
 return false;
[Quan, Evan] This seems irrelevant. Better to create a separate patch for this.

 val = RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);  return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false;  }

+static bool sienna_cichlid_is_mode1_reset_supported(struct smu_context
+*smu) {
+struct amdgpu_device *adev = smu->adev; uint32_t val;
+u32 smu_version;
+
+/**
+ * SRIOV env will not support SMU mode1 reset
+ * PM FW support mode1 reset from 58.26  */ smu_get_smc_version(smu,
+NULL, &smu_version); if (amdgpu_sriov_vf(adev) || (smu_version <
+0x003a1a00)) return false;
+
+/**
+ * mode1 reset relies on PSP, so we should check if
+ * PSP is alive.
+ */
+val = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81); return val != 0x0; }
+
 static int sienna_cichlid_set_thermal_range(struct smu_context *smu,
        struct smu_temperature_range range)  { @@ -2538,6 +2561,8 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {  .baco_set_state = smu_v11_0_baco_set_state,  .baco_enter = smu_v11_0_baco_enter,  .baco_exit = smu_v11_0_baco_exit,
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
@@ -1741,6 +1743,17 @@ int smu_v11_0_baco_exit(struct smu_context *smu)  return ret;  }

+int smu_v11_0_mode1_reset(struct smu_context *smu) { int ret = 0;
+
+ret = smu_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL); if (!ret)
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
