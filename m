Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B97C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 06:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0CE620674
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 06:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cFKJ8J9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CE620674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8996E176;
	Mon, 13 Jul 2020 06:23:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A5566E176
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 06:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpZIvs4WZWwm9CzDU2iZEmv0EcHQk4s1QsQQApCSyYIWuPOFpDDd61VRrxWTMMkKgthuf+q89bRtzeLnncwBhVN9WZiSNpTGCmbjGLUvHZjtlie8Xd8+xTy7aA5t637LTVLLQNohOa+D+qHhauKhQk3FHk2dzu8ylyM+mLLwFFaZ+wdGUPLjjUpVociz6VgcBUTILiGV61EzI5x2A+7FBSQNUwdBsy/mDsFGsQrA8+ywLhM08DEVUMrqfePtDGbBPgPNjcfSo0/ikfqcECRNh2esrNWVHRVgzFh8eBy5HrNCZmxd/fIwXWpC0en4pOojATjRNg0fm1OqgKV7Ag1J+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlSLCOf8LN857GGICOu87qTc6KvK527hvuRU0Qn8rBw=;
 b=CDxAB/s/iVFyaRlITF7xxEx8EHYO25PXWMm5Bv2K4On29N78FIlporAyNyWakjWz9hBQQ7uMCV5ZJeSIz+wRiu1/9691EGEbBSePm9wf+PP8yiOlZ/ECPGMRIPeFPirFbaeE7rrz/OvK2Ak5/2ohZmEzLMkOTFd0+Iy0GtVmmyucbli9zEl6YBn0DlWjSR/ozoJUiT6Dtma6mDt9rV0w69jlErZnkH5QQF7FfZXQz5JZdJXzvqB/tfHXUZJT5AoxmivIdge2jTNvnMjDwKt2TglXixGo3HFZuH7oTQ+tT92rfnWorS7IOBYewY/07kVHZDcqYdD/rHwkgDrb3mObww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlSLCOf8LN857GGICOu87qTc6KvK527hvuRU0Qn8rBw=;
 b=cFKJ8J9Wbg/p/PeSXyQmglPRS9PJ1VICNDoNv4TlhuPeHbQVxU5MrmNEbsngw1n/29OPskTQoU7AzayrFd1nRhbxlccWjLKehcC3+vbruR74PZ2b0OOSMcd22SbQq2nLcENR/Xv4BC7oG9zfUOWbW20XaCrnoZ/2oj/o/b07sY8=
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB3893.namprd12.prod.outlook.com (2603:10b6:610:21::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Mon, 13 Jul
 2020 06:23:21 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%8]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 06:23:21 +0000
From: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Dennis"
 <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amd/powerplay: add SMU mode1 reset
Thread-Topic: [PATCH 1/3] drm/amd/powerplay: add SMU mode1 reset
Thread-Index: AQHWVsTGFOy2KJGq4UKGt0BgUalmGKkE2MaAgAAI5+CAACH3AIAACe6g
Date: Mon, 13 Jul 2020 06:23:21 +0000
Message-ID: <CH2PR12MB410110FC3291B75990EBB50C8C600@CH2PR12MB4101.namprd12.prod.outlook.com>
References: <20200710141644.1601-1-Wenhui.Sheng@amd.com>
 <DM5PR12MB2533B100C25989F0C3D0C78DED600@DM5PR12MB2533.namprd12.prod.outlook.com>
 <CH2PR12MB4101D498C8C59200A3BF0D1D8C600@CH2PR12MB4101.namprd12.prod.outlook.com>
 <DM6PR12MB4075113EBF562D18A0589349FC600@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075113EBF562D18A0589349FC600@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
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
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-13T06:23:18Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: d5d522f9-d9b8-4912-a60c-0000590c8991
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e314ccb5-cf15-44fb-b642-08d826f53dd3
x-ms-traffictypediagnostic: CH2PR12MB3893:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB38931CACC4CD9696D1743E308C600@CH2PR12MB3893.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f8e6eCOc1hPltzYYPCJTKPAb/QZpZvHLNiPyRXi70gWfkeeOo7SrVmv88+ggMJpbqFvXBc3TY95JKO9PfFxuB6NaPm7Tx07S72HH5Hci2M0RYqP/EDFc+pm77r4cX7L/Qa2JHPB4HejVGomxWG0YF55fx1XT66laVzBg2lR5X0jNaOXNwOg49OC5e4LcSJc7cTDWUhQhTTxTjfxv72WqkYU1C5GYJJKSbI0pzxWDdR3f58c+Rh9ZG6jyWbPgrG06LqyJLzbL8LubeKVCOqswY/jS8qkWO5T7MEhetwjaMSqdmy+xChW1unZU3AR4EDqOA+j6TSoOMuWYI86t39xcjcQeQbBsQt/KkcU5Km7+Ow8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(110136005)(76116006)(5660300002)(52536014)(8676002)(30864003)(71200400001)(83380400001)(7696005)(33656002)(186003)(86362001)(26005)(55016002)(2906002)(316002)(9686003)(966005)(66446008)(64756008)(8936002)(66476007)(6506007)(478600001)(53546011)(45080400002)(4326008)(66556008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: IRwYXJdqrvd48BkItIXFzzDiukwbk8Uz2+YjBwcCkIoAuUfOpYOpJDV5Gw3UwRjk44jlvq9wcKfeJyWTZpaQfuhn9rwvbYbGsxz0VJDgvsAmjx/YD4QWbYKGCdVIsQga0RCBQcmvwRhM76oWEsqdF5zUjsYp3zUjoccjlEkAoIA8T1F61Wy6AVtkCcZyPgcli+J9zPYa5/Suy5/aePkQq4BD2vwaNmQ95rKT66DSqmYKzrksp0X1trJRtjiL5aCWXqdKw5UmOLiBxXaFZDu0oGTmwVWwbPwk2tgIsAXzrDMe631XK14pRm0kKGYo2LgIGgMxMwwAPRqQkGPUFR3rNUBBl4DrgOGycgNEiKDwxWo+qyo4hZD9wmv0RZYUhTnpcLYrO7GV09JyVwQTfhFnxOQVAZyyA3utRA8Sdg0WpbMJ/8czVEFLeVEgRBfUe1y5Q3LFOmqC+s0FxwKgvr0B3zTgT0qIPVOZlBDcGIDSXBmIn7YAGUMxYaFMq1ugC74S
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e314ccb5-cf15-44fb-b642-08d826f53dd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 06:23:21.6773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OkakZQh5h0Qcnn7518vwfTtrn0gVzx9LhERRdin7T5UjdLtCWE7Ej/JxmoMELk+SGRUalFO980zHCG/8UjAoqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3893
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

Hi Hawking,

Not sure If there is a situation that we pass through the physical device to  a vm, the condition check " if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev)) " in function amdgpu_mm_rreg  should be true when we call RREG32_SOC15, is it correct?


Brs
Wenhui

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
