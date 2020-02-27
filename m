Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFE2C4BA2D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 13:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CCDF21556
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 13:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="I4UZ7VhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCDF21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC066E8B0;
	Thu, 27 Feb 2020 13:25:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F4876E8B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 13:25:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Obt3nvPLtdczFZ6drQnfCS2uacB80tZt7Pyy0rvJmCZ9qW+aVRJ4kwzC0BXi8C9pHce5zJFHxwK4Rov1w1zjaIHKIbGsLGSwrFcP6wCC6AnYtw9n4mlSucTGQGrKzV7StuvFLcI4/PlW5rJU9CDh7xqjG6Wqgss3s9CDTX+SMwH48IVOluigubeG6YWEekkrvBTughXgB2ywLoNii/an5ESR4W7XxIDmdxn47OBZ8ykq1g/jPCoXVbBU1cJJSE+WNHjoqYrlvASBFnlZyorPe4uENTLpvpGyejhgPf+BcTOqQj3S17ofsQ85Q45R/ks6MPZ8RXM0fV+OytQAi9Vspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOMoBeXOReSvgquICW01bKIiPHfsrNjPtPTX+9ZqDQs=;
 b=BeNOTmJSqpV2evWjTwzf/9UM4028mVzdg4AgrRdFiKzUtlRHyzod5SGLzgLaPL7cjIrAHmWTTILT0+ZmuOjMXzNKzqwtZtriORkPopaQth9JD/01HQFpHPJHj9Xi0BsF0k3lnfh0YdxuhEsGvwHxPODK2Kk4tnwTRkgwlVthgDaLRkra/hg3IxTj7k4W0EU0rkl2HtcBjOVKVsUPnjfuwrs0okp8DFZI0cEeLni9/fV+XkhIv4XNOTpF9lNfsOVOnhqyXjHFH+tz7dcs9IvS0O9h8B4ATfFb79Ns216MUe9UhrNEwhNBj38uaxiIuv2UazepHCv7B7iToUFgwtj+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOMoBeXOReSvgquICW01bKIiPHfsrNjPtPTX+9ZqDQs=;
 b=I4UZ7VhLFsJXHRBqSS6Wu5nB5uNSAmMm6TYMLQUls5/V/sPU5xOu+GCNisy1TZzUkvhXl4nKdaYcjcIvIjkKUDVKBPKrvbZ2UT7GrVXCe//TR1yuvl9XKQnAtIfPaBIa0peBmLHcmzHoUlpYupSlGwUnHRoVHyX4Nc9jv7xkU3s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jacob.He@amd.com; 
Received: from BN8PR12MB3363.namprd12.prod.outlook.com (2603:10b6:408:48::21)
 by BN8PR12MB3011.namprd12.prod.outlook.com (2603:10b6:408:4a::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 13:25:34 +0000
Received: from BN8PR12MB3363.namprd12.prod.outlook.com
 ([fe80::78f8:d32:5ca1:e21e]) by BN8PR12MB3363.namprd12.prod.outlook.com
 ([fe80::78f8:d32:5ca1:e21e%7]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 13:25:34 +0000
From: Jacob He <jacob.he@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Initialize SPM_VMID with 0xf
Date: Thu, 27 Feb 2020 21:25:01 +0800
Message-Id: <20200227132501.4561-1-jacob.he@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:202:17::34) To BN8PR12MB3363.namprd12.prod.outlook.com
 (2603:10b6:408:48::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jacob-Linux.amd.com (180.167.199.189) by
 HK2PR03CA0064.apcprd03.prod.outlook.com (2603:1096:202:17::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.10 via Frontend Transport; Thu, 27 Feb 2020 13:25:33 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ad40a92-2538-4417-ddb6-08d7bb88867f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3011:|BN8PR12MB3011:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3011246CD48FCD93BB637C219BEB0@BN8PR12MB3011.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(66476007)(66556008)(6916009)(44832011)(66946007)(16526019)(52116002)(186003)(2906002)(7696005)(2616005)(1076003)(36756003)(956004)(26005)(316002)(4326008)(6486002)(86362001)(6666004)(8936002)(5660300002)(8676002)(81166006)(478600001)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3011;
 H:BN8PR12MB3363.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RHliim7WWB/py4LkiE1nB1GJCSEDC+YT/TwUKE7MiMDp0RpzLJV7qJrG6DmqUZ5BeHZMo4m3i7i4SGNpINNV8A5OC8gG+KO7c5U/8xuP7JVq1cLFnHjum7dh8ZmcwqQEqnMq4SSZHg7upxvhZrVCkCKEEn0tAo5r8OW5MYWWsKsuPPjYbiJg6FKgLQiaxREkiurd+h5qFMfdO8Oj8RUJm8rrdNuUWiAwkx45/FvOvEbzi53WU86NEv7WaRgk1QXdNpY+kcv/uvKrGV+2ypf6c5Cw4N8eVwqyWXfbaVF9aW8LCMU+o+FlWiKQ9g8MiR6HcExRCxyx+0pnP8kIwnzrhhuLJxlvmNaNIpMhnv9b7YSfXtfYVJ4v2/agp1G2vzTz3lNBcgF8AAXrR7ige5PBKK0v+J5PcKRLI2UyKjzPRRKYVoGQ3VkSWGCD7Ih1sHn4
X-MS-Exchange-AntiSpam-MessageData: V1Li3S9Ky2hxgyK1MWD1Ej+etV1LuANtXtPsieqGJoInoaThukfRWvw5I+IcEs2mM/WFhaO7136iUpFfIDRNCZ6yg+E9LAQIkLXQ7l8n0zhRLZ9S/eXBZp6WbYXyURR9RpnTaM50wobHObbyDsb3lQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad40a92-2538-4417-ddb6-08d7bb88867f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 13:25:34.5915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrcKnqLA0qPc2rabz3tKeBEv3ECqN6vGs3GhSuTj2gTvkNPoAyRboiZVE+rLal9h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3011
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
Cc: Jacob He <jacob.he@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SPM_VMID is a global resource, SPM access the video memory according to
SPM_VMID. The initial valude of SPM_VMID is 0 which is used by kernel.
That means UMD can overwrite the memory of VMID0 by enabling SPM, that
is really dangerous.

Initialize SPM_VMID with 0xf, it messes up other user mode process at
most.

Change-Id: Ieb54f6a16869b827504355a90a98663908d5087c
Signed-off-by: Jacob He <jacob.he@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 19 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 19 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 19 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 19 ++++++++++++++++++-
 5 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index d3d4707f2168..52509c254cbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -126,6 +126,7 @@ struct amdgpu_rlc_funcs {
 	void (*stop)(struct amdgpu_device *adev);
 	void (*reset)(struct amdgpu_device *adev);
 	void (*start)(struct amdgpu_device *adev);
+	void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
 };
 
 struct amdgpu_rlc {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 7b6158320400..9fe5bdfa87ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1016,6 +1016,10 @@ static int gfx_v10_0_rlc_init(struct amdgpu_device *adev)
 			return r;
 	}
 
+    /* init spm vmid with 0xf */
+    if (adev->gfx.rlc.funcs->update_spm_vmid)
+        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
+
 	return 0;
 }
 
@@ -4214,6 +4218,18 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
+{
+	u32 data;
+
+	data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
+
+	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
+	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
+
+	WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
+}
+
 static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
 	.is_rlc_enabled = gfx_v10_0_is_rlc_enabled,
 	.set_safe_mode = gfx_v10_0_set_safe_mode,
@@ -4224,7 +4240,8 @@ static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
 	.resume = gfx_v10_0_rlc_resume,
 	.stop = gfx_v10_0_rlc_stop,
 	.reset = gfx_v10_0_rlc_reset,
-	.start = gfx_v10_0_rlc_start
+	.start = gfx_v10_0_rlc_start,
+	.update_spm_vmid = gfx_v10_0_update_spm_vmid
 };
 
 static int gfx_v10_0_set_powergating_state(void *handle,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 8f20a5dd44fe..80a959755cf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3346,6 +3346,10 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *adev)
 			return r;
 	}
 
+    /* init spm vmid with 0xf */
+    if (adev->gfx.rlc.funcs->update_spm_vmid)
+        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
+
 	return 0;
 }
 
@@ -3570,6 +3574,18 @@ static int gfx_v7_0_rlc_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void gfx_v7_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
+{
+	u32 data;
+
+	data = RREG32(mmRLC_SPM_VMID);
+
+	data &= ~RLC_SPM_VMID__RLC_SPM_VMID_MASK;
+	data |= (vmid & RLC_SPM_VMID__RLC_SPM_VMID_MASK) << RLC_SPM_VMID__RLC_SPM_VMID__SHIFT;
+
+	WREG32(mmRLC_SPM_VMID, data);
+}
+
 static void gfx_v7_0_enable_cgcg(struct amdgpu_device *adev, bool enable)
 {
 	u32 data, orig, tmp, tmp2;
@@ -4221,7 +4237,8 @@ static const struct amdgpu_rlc_funcs gfx_v7_0_rlc_funcs = {
 	.resume = gfx_v7_0_rlc_resume,
 	.stop = gfx_v7_0_rlc_stop,
 	.reset = gfx_v7_0_rlc_reset,
-	.start = gfx_v7_0_rlc_start
+	.start = gfx_v7_0_rlc_start,
+	.update_spm_vmid = gfx_v7_0_update_spm_vmid
 };
 
 static int gfx_v7_0_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index fa245973de12..2174f9dc5335 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1318,6 +1318,10 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *adev)
 			return r;
 	}
 
+    /* init spm vmid with 0xf */
+    if (adev->gfx.rlc.funcs->update_spm_vmid)
+        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
+
 	return 0;
 }
 
@@ -5589,6 +5593,18 @@ static void gfx_v8_0_unset_safe_mode(struct amdgpu_device *adev)
 	}
 }
 
+static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
+{
+	u32 data;
+
+	data = RREG32(mmRLC_SPM_VMID);
+
+	data &= ~RLC_SPM_VMID__RLC_SPM_VMID_MASK;
+	data |= (vmid & RLC_SPM_VMID__RLC_SPM_VMID_MASK) << RLC_SPM_VMID__RLC_SPM_VMID__SHIFT;
+
+	WREG32(mmRLC_SPM_VMID, data);
+}
+
 static const struct amdgpu_rlc_funcs iceland_rlc_funcs = {
 	.is_rlc_enabled = gfx_v8_0_is_rlc_enabled,
 	.set_safe_mode = gfx_v8_0_set_safe_mode,
@@ -5600,7 +5616,8 @@ static const struct amdgpu_rlc_funcs iceland_rlc_funcs = {
 	.resume = gfx_v8_0_rlc_resume,
 	.stop = gfx_v8_0_rlc_stop,
 	.reset = gfx_v8_0_rlc_reset,
-	.start = gfx_v8_0_rlc_start
+	.start = gfx_v8_0_rlc_start,
+	.update_spm_vmid = gfx_v8_0_update_spm_vmid
 };
 
 static void gfx_v8_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1c7a16b91686..db388383faa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1847,6 +1847,10 @@ static int gfx_v9_0_rlc_init(struct amdgpu_device *adev)
 		break;
 	}
 
+    /* init spm vmid with 0xf */
+    if (adev->gfx.rlc.funcs->update_spm_vmid)
+        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
+
 	return 0;
 }
 
@@ -4705,6 +4709,18 @@ static int gfx_v9_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
+{
+	u32 data;
+
+	data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
+
+	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
+	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
+
+	WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
+}
+
 static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
 	.is_rlc_enabled = gfx_v9_0_is_rlc_enabled,
 	.set_safe_mode = gfx_v9_0_set_safe_mode,
@@ -4716,7 +4732,8 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
 	.resume = gfx_v9_0_rlc_resume,
 	.stop = gfx_v9_0_rlc_stop,
 	.reset = gfx_v9_0_rlc_reset,
-	.start = gfx_v9_0_rlc_start
+	.start = gfx_v9_0_rlc_start,
+	.update_spm_vmid = gfx_v9_0_update_spm_vmid
 };
 
 static int gfx_v9_0_set_powergating_state(void *handle,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
