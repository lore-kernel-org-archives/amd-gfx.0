Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648EDC43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 20:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1652B2077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 20:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eM5+Gie5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1652B2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0BAE6E06B;
	Wed, 11 Dec 2019 20:25:59 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690059.outbound.protection.outlook.com [40.107.69.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 372F56E06B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 20:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHKcRF1/Fw9iFfN05urmu8GxlRJvgvBQXYOis8dcRXq+2yZiAp/iYeCcYv5Ag7zq3q57FcEuOczfUk/FMJuit2wjWtRMtzgXK+/wVvW4dWGJjuckSRgqQsEB6M92LVSGJhNmfJhmx2/QgNqdqyUPQuXDFqhZqLrwyyJF9IE23PZAAXfCcnLvGyCy8+dY3M+t916ATp99Fls00lxKagxO7oU9VFqw+7bP0PE1VQboI6RQ7XajZxq/jD5uE49Lj72jdYg//GyjWyAIwTGufKeIJJpx/AwHf6ru1wSAn/BVYSC0dUP/5TfZahdkJKo5xYCdzME/Nj9OPVG+xdOSJ3D2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUzJJsrP/9dtOMD0a6aJn0b27lrwXybXnXYDB2CcNhA=;
 b=IT40m5w9rOp9IbuEVyW3kY51PzNiecSuO/Uh4TH5hsRZ+topaabBAv1IXyjS5Y8yy5+da/2+nKq3FjCqOOFtnqs7AmRSmfyxllknTkM9Dqfzq98War8Gg3iOuP7fdz5Vo6qzqJuWr20RizH0O5Q0KjZVA7JxLCjWiGGSotFdnxtY9Gi+Mzt4UtdwwwHLz5V0/EUeUobX1vH7bdB49gCY36QDLBf/rL6uaE5bh4UCeXuo6I7CHu26A16vel4/lQQyjDyjlqztVN9zF9+eWmYqN35rNBltO4hWaHXwT6nlXqfCSjjbRLZDj/RJh96T5juUOEBRhK/l+5REEmpiQNH0vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUzJJsrP/9dtOMD0a6aJn0b27lrwXybXnXYDB2CcNhA=;
 b=eM5+Gie5K99CI3uT0HjFih6w8EquxbQJ8DpprOWSpD4KX1Awtz2idusv9ILBPxTH5/crHkYCUKxyjQ8psDtmnckP5Mtf7ULmZFpQEYT9ZYPVfLFLFpFe8Gf182P929xxvM0s48qQMKkzWQf/SCEd+IN3U3WZZPPh+kdThbel6JA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com (10.174.106.18) by
 DM5PR1201MB0218.namprd12.prod.outlook.com (10.174.246.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Wed, 11 Dec 2019 20:25:55 +0000
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22]) by DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22%9]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 20:25:55 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add CU info print log
Date: Wed, 11 Dec 2019 15:25:42 -0500
Message-Id: <20191211202542.637-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::18)
 To DM5PR1201MB0137.namprd12.prod.outlook.com
 (2603:10b6:4:54::18)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2cc59a0-9ca4-4642-7eb9-08d77e7852d6
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0218:|DM5PR1201MB0218:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB021876CB2DA5DB2F720E6BF6F05A0@DM5PR1201MB0218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(478600001)(6916009)(66556008)(186003)(6506007)(8936002)(36756003)(52116002)(1076003)(316002)(5660300002)(6666004)(26005)(2906002)(6512007)(81156014)(66476007)(4326008)(6486002)(86362001)(2616005)(81166006)(8676002)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0218;
 H:DM5PR1201MB0137.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsf9JFUBxG1DOfKbNn8TO7ucjElm+ggwtdPpZtyFsADa8tIV7AFBwu/7gJ0/6hDh+qXjjDI8jvsbjpD11skJwOsqM1a8UpA+dMeNQyikjEJLhouyzXYM+O5TdXePHAJHlubq8GKbw0EKkVcnxgDB8kSEnfEHK/vrWx23gYHUztOkgXte23CwRZ4IutDaj+kQjRn1bA5vl6+50a9iUEy9Ih8jzH6i1dEnlD/nir0AlQckDgS6qvaadxH+k+F99m/r4RMXZ4xwSfxFncrWIbOnVCcESfL7hBqT5BUZvDITIFOi545ApIfi1eW/vOmc+bpJBqwNiAc/MvXe9PSG6i/OaP+yM4G1+u/TafEEeWstMT2sR4xwmYso/KVDvk8NxACkeWN2K4f57+9hYxP7CKSXldC7M62n7Ae9JwFLTeVh4392p2kA0NbQelfymLBW0JHz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cc59a0-9ca4-4642-7eb9-08d77e7852d6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 20:25:55.2566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzhJhlC3ab7iG6cnNVox8XZp0E0QVT1snggLRmPkniagqmaLhSbwjHOAisUWpfJ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0218
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The log will be useful for easily getting the CU info on various
emulation models or ASICs.

Change-Id: Ic1c914938aa3445d8dbfdf6a237bc1d58b0d5267
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 2 ++
 7 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8992506541d8..df9732510012 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1529,6 +1529,12 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 		adev->gfx.config.max_shader_engines = le32_to_cpu(gpu_info_fw->gc_num_se);
 		adev->gfx.config.max_cu_per_sh = le32_to_cpu(gpu_info_fw->gc_num_cu_per_sh);
 		adev->gfx.config.max_sh_per_se = le32_to_cpu(gpu_info_fw->gc_num_sh_per_se);
+
+		DRM_INFO("gpu_info: SE %d, SH per SE %d, CU per SH %d\n",
+				adev->gfx.config.max_shader_engines,
+				adev->gfx.config.max_sh_per_se,
+				adev->gfx.config.max_cu_per_sh);
+
 		adev->gfx.config.max_backends_per_se = le32_to_cpu(gpu_info_fw->gc_num_rb_per_se);
 		adev->gfx.config.max_texture_channel_caches =
 			le32_to_cpu(gpu_info_fw->gc_num_tccs);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f95092741c38..8001a067700c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -388,6 +388,12 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 	adev->gfx.config.max_cu_per_sh = 2 * (le32_to_cpu(gc_info->gc_num_wgp0_per_sa) +
 					      le32_to_cpu(gc_info->gc_num_wgp1_per_sa));
 	adev->gfx.config.max_sh_per_se = le32_to_cpu(gc_info->gc_num_sa_per_se);
+
+	DRM_INFO("discovery: SE %d, SH per SE %d, CU per SH %d\n",
+			adev->gfx.config.max_shader_engines,
+			adev->gfx.config.max_sh_per_se,
+			adev->gfx.config.max_cu_per_sh);
+
 	adev->gfx.config.max_backends_per_se = le32_to_cpu(gc_info->gc_num_rb_per_se);
 	adev->gfx.config.max_texture_channel_caches = le32_to_cpu(gc_info->gc_num_gl2c);
 	adev->gfx.config.max_gprs = le32_to_cpu(gc_info->gc_num_gprs);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8cdef79de9d4..a26892e71680 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5432,6 +5432,8 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
 	cu_info->ao_cu_mask = ao_cu_mask;
 	cu_info->simd_per_cu = NUM_SIMD_PER_CU;
 
+	DRM_INFO("active_cu_number: %d\n", cu_info->number);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 95bb2422b27c..bb05a94690d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3620,6 +3620,8 @@ static void gfx_v6_0_get_cu_info(struct amdgpu_device *adev)
 
 	cu_info->number = active_cu_number;
 	cu_info->ao_cu_mask = ao_cu_mask;
+
+	DRM_INFO("active_cu_number: %d\n", cu_info->number);
 }
 
 const struct amdgpu_ip_block_version gfx_v6_0_ip_block =
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 648d767d14e7..6d16216d5c7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -5159,6 +5159,8 @@ static void gfx_v7_0_get_cu_info(struct amdgpu_device *adev)
 	cu_info->max_scratch_slots_per_cu = 32;
 	cu_info->wave_front_size = 64;
 	cu_info->lds_size = 64;
+
+	DRM_INFO("active_cu_number: %d\n", cu_info->number);
 }
 
 const struct amdgpu_ip_block_version gfx_v7_0_ip_block =
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 8b9f440688ed..1073eb5c3cec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -7141,6 +7141,8 @@ static void gfx_v8_0_get_cu_info(struct amdgpu_device *adev)
 	cu_info->max_scratch_slots_per_cu = 32;
 	cu_info->wave_front_size = 64;
 	cu_info->lds_size = 64;
+
+	DRM_INFO("active_cu_number: %d\n", cu_info->number);
 }
 
 const struct amdgpu_ip_block_version gfx_v8_0_ip_block =
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 147c08fb5531..e9d55ab33da7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6562,6 +6562,8 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
 	cu_info->ao_cu_mask = ao_cu_mask;
 	cu_info->simd_per_cu = NUM_SIMD_PER_CU;
 
+	DRM_INFO("active_cu_number: %d\n", cu_info->number);
+
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
