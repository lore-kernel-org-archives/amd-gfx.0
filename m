Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6993EC19F29
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 10:30:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E94198C0D;
	Thu, 28 Jul 2022 10:30:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2B0C98C01
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 10:30:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ko1pOM+ICu061M9WMJL6zyckhwOy80YogEQ08GU89UoJDapEXg3Nut8QNe1gGUgAaVh5W1yInQM0x+RQu3QgOoTfM//fGtjI/ALBdJPtZ/RANsK2YuTWnGSzJsQU3iuLwU/WPjj0NKVQhMfcLIXR1/4ckrN39JYO+feP3HOLWq4N16oagxqnMs5/qm0BGMml90V3uUuDw81YYhf3Pt4107CpFliFo4YzoGGuk/7HlxAcJd0/8AUZ4wX9l88jey0qdJusjbDQ8czd5OrXdley2bOO2259xGozgk4VyRC+9Ztsf+X0AqItgQY2cw0s2Rg5RWb/ooF2WfGmqWb4GjcMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPeIpRSRaMv3padO1uhqm6qUdoo3gFmxaY7qmLfmuqA=;
 b=Xq1SIxWAqmJQEr9dZMw4uUYgiT8uKbCntwasXjln5B/kAaGjVuiWuKsXusz0PUbn19LTOlNfp4vl/NubHOOGy+dNRMz0qUr20jXSQqFGbGYROazvZ4m1PNH3lJWM71GbE5KJeTPVTvSLPFWESaexvxrV7kVgH+q+kRhl7ldlVZ13IPncMsJVIFOrmacVzrc7gmhQ1PQaQKAkfylnbX20GqymhlyldQ27wiNDeiVAtvMS7DvB9dSQaVwBL6lXzPDE7tmQ90nA0e+QPfgfoo5VCDuKB8pHyFjeLu0eAZjH1C7dwSNSk8UgLBq0DvkXZ4vPBOwq51PzxRShrSlM1Jo8ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPeIpRSRaMv3padO1uhqm6qUdoo3gFmxaY7qmLfmuqA=;
 b=vTckHPXHVe1Vx8/IyjavL2EjU6ZQ5AKo7rR2R1kavyyN09SL7V21i86BsqT5485IwVKyXv9KK1E6IwOJy6ctmRY50nmtMOmpGw8JWu1/Wf5vn1VDQwb2GDnHY4mX0iAc88ii0eoew/Nc1JZISTzWPxE6GmjLBRNGdJJkxYLZR2I=
Received: from BN1PR10CA0013.namprd10.prod.outlook.com (2603:10b6:408:e0::18)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Thu, 28 Jul
 2022 10:30:40 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::de) by BN1PR10CA0013.outlook.office365.com
 (2603:10b6:408:e0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Thu, 28 Jul 2022 10:30:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 10:30:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 05:30:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 05:30:40 -0500
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 28 Jul 2022 05:30:38 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/6] drm/amdgpu: let mode2 reset fallback to default when
 failure
Date: Thu, 28 Jul 2022 18:30:23 +0800
Message-ID: <20220728103027.27255-2-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728103027.27255-1-Victor.Zhao@amd.com>
References: <20220728103027.27255-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0f3ffbc-3ab5-4338-f39b-08da7084383f
X-MS-TrafficTypeDiagnostic: IA1PR12MB6284:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vvRIrHBIV5CmJcFwWaftPQ+nqjRD5Ctfh/XO36g3MM3WGlwV/Z9a2FNTJimki9OMeVrajzr3gzDYnbuyXLOBBOeVpm7Zsm8wxyy1Wur0BldHJXDSbO1bEWgWaY+SOU5/Fn9IxhcY2fxT1piYTvhQeipOrOhr05UpkY5lUHcHL8tLoexkrG6SlVALKBak+WLOn5AtWkKVzWMXJxHgqI3gH8i+s6fsrASmPEqXSxCp8hpzOyVV9YU5QZBzzv1T5cbkwuWlOdqqcnWTejFCJ5Gg/YxPEVlqPGuoQ6xxmb2tQvD6Us83neMxCr5dJNmUGRrVwNSAYufGQR00PjL2dR6XPrEPAJKjjKm+OIwCyCErWzFvZBWMQ3+ofu67H5c9TDll+aqYcy3/MivzdXEGMLrFeMQlROiDvQihobNAdxIOwek9uutZdN81oFD0ufL3LCFHsYpz/ZpBjbgh0ViQwJngms/zv4LQZaC+JMSrvOCyDqyUxeTjs7QE3wYUeaQjqVo3pxvTgegNRKkpmeqZkF1QO9PUJsiba36BNMfYOlbJnYvZTusHvxdprtoJ7dBdnDPVALE6+F+D/I5yLLaQIzbjxAGos57j55gKxTR3+mNQFXmCW88wW+9KHDaDsq352hFIQqIPo1tH3y3FAX6OL3M5zKnzJH39cZDhwzoCCMFJ7/57pFo8/6lXosm6JezYMRJbC0AEBpwt3FLCR2UihvmSwnz+8O+QPHoaO75xPQoi+WFyFmDsZ71qzcH+p1kgL8pouJrD/lJS0EeAR+TdojS8cRWqxGL5RIS66rpjiUym68YlD9xMHro9M8oKjuObc5+qqGML1+pMz2uEpqECkxgnYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(136003)(396003)(346002)(40470700004)(36840700001)(46966006)(26005)(82740400003)(4326008)(8676002)(70586007)(70206006)(5660300002)(8936002)(356005)(2906002)(81166007)(478600001)(47076005)(336012)(426003)(186003)(1076003)(40460700003)(83380400001)(41300700001)(6666004)(2616005)(6916009)(316002)(54906003)(7696005)(36860700001)(40480700001)(86362001)(36756003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 10:30:40.7430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f3ffbc-3ab5-4338-f39b-08da7084383f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
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
Cc: emily.deng@amd.com, Victor Zhao <Victor.Zhao@amd.com>,
 Andrey.Grodzovsky@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- introduce AMDGPU_SKIP_MODE2_RESET flag
- let mode2 reset fallback to default reset method if failed

v2: move this part out from the asic specific part

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      | 1 +
 9 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 5e53a5293935..091415a4abf0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -135,6 +135,7 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
 	reset_context.method = AMD_RESET_METHOD_NONE;
 	reset_context.reset_req_dev = adev;
 	clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+	clear_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 041bd906449d..f03750b64f61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5147,6 +5147,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	reset_context->job = job;
 	reset_context->hive = hive;
+
 	/*
 	 * Build list of devices to reset.
 	 * In case we are in XGMI hive mode, resort the device list
@@ -5266,8 +5267,11 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			amdgpu_ras_resume(adev);
 	} else {
 		r = amdgpu_do_asic_reset(device_list_handle, reset_context);
-		if (r && r == -EAGAIN)
+		if (r && r == -EAGAIN) {
+			set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags);
+			adev->asic_reset_res = 0;
 			goto retry;
+		}
 	}
 
 skip_hw_reset:
@@ -5695,6 +5699,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	reset_context.reset_req_dev = adev;
 	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 	set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
+	set_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 	adev->no_hw_access = true;
 	r = amdgpu_device_pre_asic_reset(adev, &reset_context);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 5071b96be982..6c3e7290153f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -71,6 +71,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		clear_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
 		if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ff5361f5c2d4..ab9ba5a9c33d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1949,6 +1949,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		clear_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index f778466bb9db..831fb222139c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -74,6 +74,9 @@ int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *adev,
 {
 	struct amdgpu_reset_handler *reset_handler = NULL;
 
+	if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
+		return -ENOSYS;
+
 	if (adev->reset_cntl && adev->reset_cntl->get_reset_handler)
 		reset_handler = adev->reset_cntl->get_reset_handler(
 			adev->reset_cntl, reset_context);
@@ -90,6 +93,9 @@ int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
 	int ret;
 	struct amdgpu_reset_handler *reset_handler = NULL;
 
+	if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
+		return -ENOSYS;
+
 	if (adev->reset_cntl)
 		reset_handler = adev->reset_cntl->get_reset_handler(
 			adev->reset_cntl, reset_context);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 9e55a5d7a825..cc4b2eeb24cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -30,6 +30,7 @@ enum AMDGPU_RESET_FLAGS {
 
 	AMDGPU_NEED_FULL_RESET = 0,
 	AMDGPU_SKIP_HW_RESET = 1,
+	AMDGPU_SKIP_MODE2_RESET = 2,
 };
 
 struct amdgpu_reset_context {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 12906ba74462..a2f04b249132 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -290,6 +290,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		clear_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index e07757eea7ad..a977f0027928 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -317,6 +317,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		clear_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index 288c414babdf..fd14fa9b9cd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -529,6 +529,7 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		clear_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 	}
-- 
2.25.1

