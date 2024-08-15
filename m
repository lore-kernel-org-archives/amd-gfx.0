Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B65C52D7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 11:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A92C10E159;
	Thu, 15 Aug 2024 11:39:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vJ4V7QnO";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C149310E159
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 11:39:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGagpTXNBrzfe+/c/DjuU7h5cwm+g5XV+wPCmMK/vHnJTir1uHwVCdoPLm1FQrhRVnq4Drq4FTtpOntXUbeOAeDxZ9eevD+AVyDz4BLx9SknX6OyGE58zY8VME8q8Jpz8uQZnunYap068KijgfH8lYocqu46jFxzleGHOapxeT62g/1LCV7LMWhde4C++fZcXeAo5I2YmCe7b753soSa1YhRzZZErHocf7XVmJGGKT2jvtoiKVFEUFbQRW6IaTqIaPeKqAwNDtnul+hsymZYeFcCwcvVXIlyTC3P2fgAKvGpS2JauHbAjh4JEGfA47PNNEL5maFT9s6NrqlMCyNv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSJM1lVQY9BtoqbKnEMwoBthj6fyNRNYVrKNxtg15iU=;
 b=RQhSHsrQhhfXr1E/a4mDjHNM8JVqc0L/tvvnsAIodyhivlZU5y0oSNauuk9Qpn2QoaN1/hgd3tYn63ZkmnS0jJRvpFaim++zzc4IZYMGWpvFAt7nuGwfCk3D2nz5RsOmad7u5F+zDlWYRKfywC2B3aewgDnoZfOKbQ4+J8jvHzuop/CxJO6pqn2kTV5drXKFLTgCCYY9VC9rk9GvwRZoNnRjB+QIYU0CbApazxevUDaFNlBKf4vNR2EuOuJbS0WcTmHlCYQUBhyjizrrVQ2Kmeb/LR5EaPDJ63eB6Z58I40Uz+WviIpbp9yKSDMtQuczd8zZ5UgNSIN4ocotWgzkpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSJM1lVQY9BtoqbKnEMwoBthj6fyNRNYVrKNxtg15iU=;
 b=vJ4V7QnOv+7cnJfLE7ag6b6WByhShYbp6svvvP0XNdh8gDtgA/lrul2CkkpqNy5UhlnY6QI8h2DtOR7kFuoKMVSH3sakZoUQMOoEeN0YUlCN7L/3uo6Tj48CNErd6stSt2TEtOYfSby5zObx/5bcDs6YFhvIkCDEC36jdR66O1U=
Received: from BN1PR12CA0011.namprd12.prod.outlook.com (2603:10b6:408:e1::16)
 by SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 11:38:57 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::c5) by BN1PR12CA0011.outlook.office365.com
 (2603:10b6:408:e1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 11:38:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 11:38:57 +0000
Received: from lps-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 06:38:55 -0500
From: <Trigger.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunil.khatri@amd.com>, <alexander.deucher@amd.com>, Trigger Huang
 <Trigger.Huang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Change the timing of doing coredump
Date: Thu, 15 Aug 2024 19:38:36 +0800
Message-ID: <20240815113836.399377-4-Trigger.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815113836.399377-1-Trigger.Huang@amd.com>
References: <20240815113836.399377-1-Trigger.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|SJ0PR12MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 8746c537-2a64-49d8-a5b0-08dcbd1ed966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N4dL61sjf93FLqtF0QPYI3S/S0Q4LqHWZhy4Q9lSUynxaZWKset6KY24bvqk?=
 =?us-ascii?Q?3nGOjYSElbfhG7fMU73EhLvKiMeq8+TT60GmEGstSmTQFU9FTZbiYpjDEIak?=
 =?us-ascii?Q?QUTTB10qzxO7qveYEdOzKoQrAk0e2G1cA6zrdAmCLLI+q6vV0Hp4EdzWgEWY?=
 =?us-ascii?Q?Vdhe86qSRcQGs2+XC1MRtiCb99np8VBMR+T0glEQ4H+c3ToBVLJM0IoxHmn0?=
 =?us-ascii?Q?RFOcP8cJY5hrKYUE9giThtvxznAJqCcCeas4eIXNO9m1G8fGF5S18lu+1fST?=
 =?us-ascii?Q?zsjOWZfqPcsLjSI+VxOQhyM3Oi+2I66s4X4NeY9x+2qMCXZ6UiUSgzgv7m/e?=
 =?us-ascii?Q?HSdXClSDhrVo6T0JwfcaNnWSL1rzD9MRuaRsQle7wWXz6u93HXubUCA5iFkw?=
 =?us-ascii?Q?CY2uZvzxCXEgyWD1jNcnJk0BP4SZdzvOfLkm34+S0waq1VJ0iptcSn5ICo6T?=
 =?us-ascii?Q?sFH+CzKXZn+Lkk6vv190yqyMmXR+B5bHYXSNduxlGiXoRej+khQdgyRMzSay?=
 =?us-ascii?Q?ZtIL1q+22S7WRy/9de/ucKBKEXy2xAPGvKb9lWorU5nph/OEmXjXLN3CZQQ4?=
 =?us-ascii?Q?ufUBp2E2BXSTfrMNey4Mz92hvPavcBHTUsOZyiCW5QMQXHzlsKyfDNmU3mDm?=
 =?us-ascii?Q?rEvENVZBG3xLDKo5gWqLDOOLCZMqXaRw53dTvoMs9kKM3iwX5+0lTcWxrRuK?=
 =?us-ascii?Q?EXBrIDYnDVYDxHsZ+AIYIC0F61xvIh4Js8Sppxv9dA1zsEIkM9tTIV5Mvwqj?=
 =?us-ascii?Q?MfRxd4zUeohjqnc0584n7rTuK/9CEzkoSgrxNePEDfSWObXkgiOUb2jWiSsJ?=
 =?us-ascii?Q?lOFOsjEhtxCOJXIg5dS+OsTH54p4p9fEOtLA3eU+EHhREwuuuTdudGg//SX/?=
 =?us-ascii?Q?e4aRaPdZFXIpwVNmvI2KWGwfH7L+cm+sot84gIquvcG1ZWg4g2hkvu+HqKpV?=
 =?us-ascii?Q?osDKM0RC8rNWJsXEyG0aoxOx/SR0NO2bPUjII4LbCM3GF3g1o3l224BPmPZ4?=
 =?us-ascii?Q?TuA3h3CN0znl7VdSRXLU31MxEEw8aiVqOkw5SAu7m0ffdp2R8tM6uYxsPqNX?=
 =?us-ascii?Q?ZHJqWeeLZbzLJb3+ov5K43vv/voPfoL/sKSTVAv+FuOKRFM+LH1bduwBzenx?=
 =?us-ascii?Q?sXvOFezvX4xDdEjGdebg2BRgJigmwt8gS3Y4e01k/Rn/d0SQjSHgpfOnJ5AB?=
 =?us-ascii?Q?V69R2lQVSQSAg8agN9S9gLtWv+DIak++x6MdQx47c8CNvxXF991NrO1wH2BT?=
 =?us-ascii?Q?izQQ4L37e5LAYSfRqiazy5fSDX2oDfiSb1a84NTkwaudEWHflPPIM1UXruLi?=
 =?us-ascii?Q?CGAO3ejymGnsfoT5i7pRvhNzyWi2ClbsJZ/Ur6VVhZM+BC22eCl0voYLXtYK?=
 =?us-ascii?Q?0NVGR1d5Oc7T9gDSCZjTc5dzbeShnQJj02TrXzjrJQn1OuyXTLcYB01zoSBr?=
 =?us-ascii?Q?Nq3sJj6uwms=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 11:38:57.3038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8746c537-2a64-49d8-a5b0-08dcbd1ed966
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067
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

From: Trigger Huang <Trigger.Huang@amd.com>

Do the coredump immediately after a job timeout to get a closer
representation of GPU's error status. For other code paths that
need to do the coredump, keep the original logic unchanged, except:
1,All the coredump operations will be under the control of parameter
amdgpu_gpu_coredump
2, Do the ip dump and register to dev codedump system together.

Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 +++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 10 ++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 69d6a5b7ca34..a8eb76d82921 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5341,15 +5341,9 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 			}
 		}
 
-		if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
-			dev_info(tmp_adev->dev, "Dumping IP State\n");
-			/* Trigger ip dump before we reset the asic */
-			for (i = 0; i < tmp_adev->num_ip_blocks; i++)
-				if (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
-					tmp_adev->ip_blocks[i].version->funcs
-						->dump_ip_state((void *)tmp_adev);
-			dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
-		}
+		if (amdgpu_gpu_coredump &&
+		    (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)))
+			amdgpu_device_gpu_coredump_single(tmp_adev, job);
 
 		if (need_full_reset)
 			r = amdgpu_device_ip_suspend(adev);
@@ -5444,10 +5438,6 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 					goto out;
 
 				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
-
-				if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags))
-					amdgpu_coredump(tmp_adev, vram_lost, reset_context);
-
 				if (vram_lost) {
 					DRM_INFO("VRAM is lost due to GPU reset!\n");
 					amdgpu_inc_vram_lost(tmp_adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index c6a1783fc9ef..63869820c334 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -48,6 +48,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		return DRM_GPU_SCHED_STAT_ENODEV;
 	}
 
+	/*
+	 * Do the coredump immediately after a job timeout to get a closer
+	 * representation of GPU's error status.
+	 */
+	if (amdgpu_gpu_coredump)
+		amdgpu_device_gpu_coredump(adev, job);
 
 	adev->job_hang = true;
 
@@ -101,6 +107,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		reset_context.src = AMDGPU_RESET_SRC_JOB;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 
+		/* To avoid a double coredump, as we have already done it */
+		if (amdgpu_gpu_coredump)
+			set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
+
 		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
 		if (r)
 			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
-- 
2.34.1

