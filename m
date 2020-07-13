Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EB5C433EA
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 06:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C1E82065F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 06:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="viZ0UMpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1E82065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D83E36E212;
	Mon, 13 Jul 2020 06:19:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 553846E212
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 06:19:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1KvwceDeqK90Coe5jjWWeG7h2nVHH5oDF0K5oBLGIuhOvJRID5qyXi2MA7H+yl6bL5sX7HJJNdsls3ZNmNCdRunN7RsVU6dTEDriNfm9JjKYn4D/E5mYw7dRHkogG9MQfutMRdpmH/JQ0Bswg9UMi8SUvbYIg7GLwX7wOy7TI2DwhR06F2eX6GN7M8+AmxYD3HpyrA/3WhRDmDXYTs/ywvCcdCpZ7uitGDXdiDEiEvbUf4djkjdjTDGAHO/dmlBAbGQxC6AmZ8m2dH3Z4Rbg4TIyiOKb1KGfG9BmfHj6CBhZdIATCQRyCBn0yQaKTqi0VlR60oxrqqbV+XITlxy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttGXnFxiACM5SGPIgDxqwwzmelEovRx2s3IoGPWSUFA=;
 b=bpEHc5vTATEC3HUCsbZ52+1qL8CKclERHCZhKNTcrTSb7leGwo15Hsny5VDL+BwD22gC9EwR8fGy6vFjwnnr68yIMStUE4SHIciQdl3j0JmCR1axrLgyft5prZtElplzYGFEVd5w8zHWSHzg0rgJedSSdBnH7k+4+CNVZdtACJ9UuIEW6IdbqFULz5gkRp1liBJcDVejYboQsvGp3HovYSM+1oLjD5MrQW3Z/W3PluQAAMGxh40hOlEXXmN6SGmCbv+Srk4Ik+D5gq1NX0OeNDllemPebd8lfS3pZZdavY6RJyoapRBFxpPGM6ErtO+VbnnyXD+cuSct0WVtGVGUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttGXnFxiACM5SGPIgDxqwwzmelEovRx2s3IoGPWSUFA=;
 b=viZ0UMpHJXzvz3sDs4oGQ0nzW3vGV7IETDsMINP/DCDgIm8Sn0mzK7yuY7NNNCYfCO1bMv1dEZzDsWc+Ln5FwPjZuNl25BGcw78492dSJkzbqNh0T0Hj8BaIZV3SMeQ/1wjsUV4YxLMvUVKrjRSdKbTvinjt/6k6or4XMD4Bl00=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM5PR1201MB0235.namprd12.prod.outlook.com (2603:10b6:4:4f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Mon, 13 Jul 2020 06:18:59 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::2d85:c08d:4782:e3a]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::2d85:c08d:4782:e3a%7]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 06:18:59 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Sheng, Wenhui"
 <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amd/powerplay: add SMU mode1 reset
Thread-Topic: [PATCH 1/3] drm/amd/powerplay: add SMU mode1 reset
Thread-Index: AQHWVsTL/B1wTK9UIke47JK1V8NEGqkE19tAgAAJ/YCAACHLAIAABFoA
Date: Mon, 13 Jul 2020 06:18:59 +0000
Message-ID: <DM5PR12MB25333F04BBB9745AD1D59A6EED600@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20200710141644.1601-1-Wenhui.Sheng@amd.com>
 <DM5PR12MB2533B100C25989F0C3D0C78DED600@DM5PR12MB2533.namprd12.prod.outlook.com>
 <CH2PR12MB4101D498C8C59200A3BF0D1D8C600@CH2PR12MB4101.namprd12.prod.outlook.com>
 <DM6PR12MB4075113EBF562D18A0589349FC600@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075113EBF562D18A0589349FC600@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-13T05:43:48Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=5540e6a8-fe29-48b0-8daa-0000a9420c9e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a643d93c-1089-47a1-23d0-08d826f4a160
x-ms-traffictypediagnostic: DM5PR1201MB0235:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0235517B00F82BBC16FFA896ED600@DM5PR1201MB0235.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hCxjVEsrJAviRdO3Oq5nUYmWrXKJ/HVk6g9N2UdInvO3ZqXIaHD1nu/P5jwdTdiHlLec/PQk6AKhTh6Mkrg0M9MLdeaprsFJWPQlmQIEjshrlVJ2SQwwWdgvQ78VceI0aGV9oS8zHQFF+H/niVrLi5Z5axtDle1VgiJxexwWuclHqBndyCpuTuFxLo2PpYjDK5k4iuN91xIWz6efY7VPA7j+3Zh84SJ36K8Ktt8JO5ddmRBW1eqHy73Do/CiIHpLM5MOM57M7uXscTgAbvKrgEfV787C/Y77N8+7dlYA4RnK0QJ/HtRPM6AxqXKncfk2/+HQH+Orq9fWkq+T8uILSTON6A+K0TeZXgjK8mLyEc0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(71200400001)(33656002)(2906002)(4326008)(9686003)(55016002)(8936002)(110136005)(966005)(53546011)(8676002)(478600001)(45080400002)(7696005)(6506007)(316002)(76116006)(186003)(26005)(66946007)(66476007)(66556008)(66446008)(64756008)(30864003)(86362001)(5660300002)(83380400001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: CRxITStxlYABhJDwTKKen4pUkAuEtNRs7WXlhFoNBnq3Rnxm66ZbCe+yro3vrtOuOyMxx6RA2tX7L7wvRHgwQ7+io7pNcL8ZCEx0jdaeShFpzmGPZtSDhs6G+HWYSsVgYF4NjCcQktKkNims0SnTtcYk7ShxBMpHhKwgTqFPxcbrFHj0CYFqEiZTA/m3fsRNtjwZ8a43FcJ9z1hhJTt7D2jBRcR8bENXPV1GmMEFOSuzrzJY9Taftitem2w1D+YrbQm+89ujg2HUl43R3r0UsB4nFKhrRWTHvNXHZUu1Dk9OPPIQ6wuGVLS8m4MfmQp8ov+DLpBsFzBFjpXRjlRSwzAZG7jbld37WSz91QlIzfQ5CkB2H2BGppW/ga7SCBXqHkw91XtmYoNyDkpaBRzIETCeXRQZmDBuNePghYo+xRWsTfpRznU+4UMpmEb1iYuUGJjanSVCjCtAc8QH3pDbBKDXMCzH7XghE3JA7ZO3qKT7O+xmsXYrQxobmdWi8/Kz
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a643d93c-1089-47a1-23d0-08d826f4a160
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 06:18:59.2814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fojHp9vH19hb1YAA5ERxKl2DB37gt5gvH1kcmTmwn7VWH0YFAfmJmAgv8zvDh3QS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0235
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi, Hawking,
      Got it. Thanks for your expiation. It looks good to me now.

Reviewed-by: Dennis Li <Dennis.Li@amd.com>

Best Regards
Dennis Li
-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Monday, July 13, 2020 1:44 PM
To: Sheng, Wenhui <Wenhui.Sheng@amd.com>; Li, Dennis <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>
Subject: RE: [PATCH 1/3] drm/amd/powerplay: add SMU mode1 reset

[AMD Public Use]

RE - [Dennis Li] It is better change to use RREG32_SOC15_NO_KIQ, because when GPU hang, RREG32_SOC15 will fail if it use RREG32_KIQ to read register

RREG32_SOC15_NO_KIQ should have no difference from RREG32_SOC15 for this use scenario. This is the feature only supported in bare-metal environment and never run from guest environment.
But this do remind us to exclude the feature from guest run-time environment by checking amdgpu_vf_sriov()

Regards,
Hawking

-----Original Message-----
From: Sheng, Wenhui <Wenhui.Sheng@amd.com>
Sent: Monday, July 13, 2020 11:43
To: Li, Dennis <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 1/3] drm/amd/powerplay: add SMU mode1 reset

[AMD Official Use Only - Internal Distribution Only]

Ok, will refine it.


Brs
Wenhui

-----Original Message-----
From: Li, Dennis <Dennis.Li@amd.com>
Sent: Monday, July 13, 2020 11:10 AM
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
@@ -1141,6 +1141,26 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
 	return 0;
 }
 
+bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev) {
+	struct smu_context *smu = &adev->smu;
+
+	if (is_support_sw_smu(adev))
+		return smu_mode1_reset_is_support(smu);
+
+	return false;
+}
+
+int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev) {
+	struct smu_context *smu = &adev->smu;
+
+	if (is_support_sw_smu(adev))
+		return smu_mode1_reset(smu);
+
+	return -EOPNOTSUPP;
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
+	bool ret = false;
+
+	if (!smu->pm_enabled)
+		return false;
+
+	mutex_lock(&smu->mutex);
+
+	if (smu->ppt_funcs && smu->ppt_funcs->mode1_reset_is_support)
+		ret = smu->ppt_funcs->mode1_reset_is_support(smu);
+
+	mutex_unlock(&smu->mutex);
+
+	return ret;
+}
+
+int smu_mode1_reset(struct smu_context *smu) {
+	int ret = 0;
+
+	if (!smu->pm_enabled)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&smu->mutex);
+
+	if (smu->ppt_funcs->mode1_reset)
+		ret = smu->ppt_funcs->mode1_reset(smu);
+
+	mutex_unlock(&smu->mutex);
+
+	return ret;
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
+	bool (*mode1_reset_is_support)(struct smu_context *smu);
+	int (*mode1_reset)(struct smu_context *smu);
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
+	__SMU_DUMMY_MAP(Mode1Reset), \
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
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
 	MSG_MAP(PowerDownJpeg,			PPSMC_MSG_PowerDownJpeg),
 	MSG_MAP(BacoAudioD3PME,			PPSMC_MSG_BacoAudioD3PME),
 	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3),
+	MSG_MAP(Mode1Reset,			PPSMC_MSG_Mode1Reset),
 };
 
 static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = { @@ -1760,13 +1761,35 @@ static bool sienna_cichlid_is_baco_supported(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t val;
 
-	if (!smu_v11_0_baco_is_support(smu))
+	if (amdgpu_sriov_vf(adev) || (!smu_v11_0_baco_is_support(smu)))
 		return false;
 
 	val = RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
 	return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false;  }
 
+static bool sienna_cichlid_is_mode1_reset_supported(struct smu_context
+*smu) {
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t val;
+	u32 smu_version;
+
+	/**
+	 * SRIOV env will not support SMU mode1 reset
+	 * PM FW support mode1 reset from 58.26
+	 */
+	smu_get_smc_version(smu, NULL, &smu_version);
+	if (amdgpu_sriov_vf(adev) || (smu_version < 0x003a1a00))
+		return false;
+
+	/**
+	 * mode1 reset relies on PSP, so we should check if
+	 * PSP is alive.
+	 */
+	val = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
+	return val != 0x0;

[Dennis Li] It is better to changed to use RREG32_SOC15_NO_KIQ, because when GPU hang, RREG32_SOC15 will fail if it use RREG32_KIQ to read register.

+}
+
 static int sienna_cichlid_set_thermal_range(struct smu_context *smu,
 				       struct smu_temperature_range range)  { @@ -2538,6 +2561,8 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.baco_set_state = smu_v11_0_baco_set_state,
 	.baco_enter = smu_v11_0_baco_enter,
 	.baco_exit = smu_v11_0_baco_exit,
+	.mode1_reset_is_support = sienna_cichlid_is_mode1_reset_supported,
+	.mode1_reset = smu_v11_0_mode1_reset,
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
+	int ret = 0;
+
+	ret = smu_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
+	if (!ret)
+		msleep(SMU11_MODE1_RESET_WAIT_TIME);
+
+	return ret;
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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CDennis.Li%40amd.com%7C5125fa5f71e245a34f4608d824dbec23%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637299874279933866&amp;sdata=DDzKv9mwDCDUyGQUYfKDk4nM0kqt07Qt45Iyr6RQQQU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
