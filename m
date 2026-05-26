Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40215CD5BB4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 06:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C52A110E46C;
	Tue, 26 May 2026 06:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lCiDOndi";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1966410E46C
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 06:06:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i78cdb1/l3MCg+WqMXmRcJTD5GVv3tDs9lbjXX8WjOlpjcjcK3qlmuAgI6oypnV34joPzPQjwil7AhA1rw8+zvlSLd4aBGr/fyRfw8AMkVWsSgpir6hFJ88Rc8LgUjznj9nyN5l0xrITlMJB0d0LfUxv1l2zL8henreanNuFeZuTKMdTTaxIg4JGpCYNAO4WD2AZWOodtEX0dHMOGqLLuLv0qbN5Qbjspe8jfIoxtdiU0Vhed2tXZ/aUXOyxJyk5i2cqOiwc/hj+hNmhDCOXVKTn3sdm3OTDSMjDR4ZAeQl1vnQ97O2yAFDGfXbInJ/Rg/f1maBMOR+Zw33dFrbJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/jF8Y38SQLhG16Td/CoT+4QCFwcVXsNE/vih4FstMc=;
 b=d2QuJyoM/K1eTrA+LoHFePPDgI69cXY9QrqF3ZM3dNRgUgrRNdZbgNHajjzqyDNKsapycJFEchtr0HGF0v4E4JJiAe2V3TSDfKUUDPAtb1VBHd34me5WlYMvg6LFZ4u0OpG+SO4TTwJ7xygliecuRmhYoiY8/jM/775e7JzQk6HMQ6OmlnvA3k1+WsCVpZ4jVvUJsuNdhQhPB4EZY+FGj9tFMwRFhEwcTNTeNmYHoz8hcmP7xsERk0mSiTG6hz0eXi+ipGeym7oG7ahAc3Hg66fZf+qT44CzaNtxkczm2Z96fmD9YT6jtPKbmOJdp/fqPVvYjQLaGZg2oL8eLzbT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/jF8Y38SQLhG16Td/CoT+4QCFwcVXsNE/vih4FstMc=;
 b=lCiDOndiuOfEFzReCEYBIfuYUKb6Av/nL7RG40jaCRrXPnCIW3sOpIjrHwf6AtJhKx3p8Dd7em/vpJhA6eIDPF0yldEWL6Dd6OB32HY7D4P63dorgL59d/ORQGZ7yglLfdPcJbMQeU6E2nEqWyIS9E1DP95grpdb65D36NoxYqM=
Received: from SJ0PR03CA0049.namprd03.prod.outlook.com (2603:10b6:a03:33e::24)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 26 May
 2026 06:06:18 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:33e:cafe::c) by SJ0PR03CA0049.outlook.office365.com
 (2603:10b6:a03:33e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 06:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 06:06:17 +0000
Received: from stanley-test.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 01:06:15 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>,
 <Candice.Li@amd.com>, Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH 1/2] drm/amd/ras: Return RAS TA injection result to userspace
Date: Tue, 26 May 2026 14:06:01 +0800
Message-ID: <20260526060602.69082-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 0168caf5-4fc6-4804-a269-08debaece6bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: yCladr6vtnPT5TE6lslrcCEmOXf/MZboRFhHkrR0UcIjyvUpbSwvNyt0vtBzuaY9NPmGWnYUsnS1x04LcqvLO5dHPlvuySrON0yZYa36illSijo4rHT240mLpSdwqMBEsCT/w5FLZHBgEoTIkrqld+iGhZmDNReygN6jpTcPa1srA0chJ5LzMEpkrS278Gxx8GDSjB+KnO2FPC6baA2sLdV+/WNbLrOJcHZm6Xf0+jvBG4bp3N/eTW1lDlTyKiZ+cHBj/EMq+ks+mPRMzZZ6uIQR/Qk9oElXJFvCogkq4XWeV+QnWIk7ZnKcoWCAwULjWvLVlJEDB8U96V1kpImVhJebEm/vbsemleEGmcEeyFYX24l0BRitITZFv/Ha9M+r689J4yEnP+yTCCVFU6Hp97aUqCfzYqOncdcO/eYuOFKvQeu2cQEZHFO3+PqkJGO3Y3Z7C50byDoNSbu8Gm0Xa4hzplIfZS4T8gbQBUvGAcXgpEF/fXa3+pVwiPmrIU7Bc6FGCE/a11/2S0XcbPcXEZPBb5WYqB2mLoFnqi1ZVela1cgrZWFB6JTHIhunHov3s9aGGMt39q6XYUquVKcf3nHA7zF1F7Co0dZunIFp/pV0QQVekayEe8Rfu71kid7basqSP6D5IDS3k40W5zs+wsWjl/kh/jl3MMDq9//xKEqSVFX2m4xsGkscCe7ysxeY+FP6CvQB+DZCOHjareL1K73UcoA90CAR9WXfs2plkuQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s+V0jurAX4gQTb7ciMhRTygV+lIZZnsN4Yh9jM0We9BDlNe+oS1A1gHAgNnLl1Z2tJivO5UaT2EfI2zNNC/TrRoZH1GZKum31ZWcHxCjo+35Oc1+sV9rbLXeC/XenZEbJCxstfvSnWb4FbmmQfuy3r1qmtbI4bRufSi685dLP2jRuhBbvpyb9d5UUuh9yuD2s+VqwX8hfKqpuZ80qqINjatu8uJAFz8ZXdK0QKGTVOy5nCmDmFE6dwmvc+u6uvoxIqfqMOXiwVPT4lPiC4VDeaB7cTOsrAvTZTxF3k6Q2ER2dXd0U7SMLcUvFnFWW2SUUcTdE+ACI4FPHYKJe9Ak56DEyADiguXrzITmxGhSZe71ulMgkIoaWl8aeQQcx1TutPnkN1Hpcy+yf0zSOMZALPerLv0jz36leJ3CMNsvDdOgYDvjpooyxykHSIF1YMpA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:06:17.8667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0168caf5-4fc6-4804-a269-08debaece6bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
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

Return RAS TA injection result to userspace that avoid
app continue to load work once injection failed.

Changed from V1:
	refactor function __check_ras_ta_cmd_resp return
	ras ta corresponding error.
	return res instead of RAS_CMD__SUCCESS in function
	amdgpu_ras_submit_cmd.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  |  2 +-
 drivers/gpu/drm/amd/ras/rascore/ras_psp.c     | 21 ++++++++++---------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
index c22e53e84207..ff7f9af980d5 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
@@ -288,5 +288,5 @@ int amdgpu_ras_submit_cmd(struct ras_core_context *ras_core, struct ras_cmd_ctx
 		return RAS_CMD__SUCCESS_EXEED_BUFFER;
 	}
 
-	return RAS_CMD__SUCCESS;
+	return res;
 }
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
index 5d556e2a7000..358f602b167d 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
@@ -317,36 +317,37 @@ static int send_psp_cmd(struct ras_core_context *ras_core,
 	return ret;
 }
 
-static void __check_ras_ta_cmd_resp(struct ras_core_context *ras_core,
+static int __check_ras_ta_cmd_resp(struct ras_core_context *ras_core,
 			struct ras_ta_cmd *ras_cmd)
 {
-
 	if (ras_cmd->ras_out_message.flags.err_inject_switch_disable_flag) {
 		RAS_DEV_WARN(ras_core->dev, "ECC switch disabled\n");
 		ras_cmd->ras_status = RAS_TA_STATUS__ERROR_RAS_NOT_AVAILABLE;
-	} else if (ras_cmd->ras_out_message.flags.reg_access_failure_flag)
+	} else if (ras_cmd->ras_out_message.flags.reg_access_failure_flag) {
 		RAS_DEV_WARN(ras_core->dev, "RAS internal register access blocked\n");
+		ras_cmd->ras_status = RAS_TA_STATUS__TEE_ERROR_ACCESS_DENIED;
+	}
 
 	switch (ras_cmd->ras_status) {
+	case RAS_TA_STATUS__SUCCESS:
+		return 0;
 	case RAS_TA_STATUS__ERROR_UNSUPPORTED_IP:
 		RAS_DEV_WARN(ras_core->dev,
 			 "RAS WARNING: cmd failed due to unsupported ip\n");
-		break;
+		return -EINVAL;
 	case RAS_TA_STATUS__ERROR_UNSUPPORTED_ERROR_INJ:
 		RAS_DEV_WARN(ras_core->dev,
 			 "RAS WARNING: cmd failed due to unsupported error injection\n");
-		break;
-	case RAS_TA_STATUS__SUCCESS:
-		break;
+		return -EINVAL;
 	case RAS_TA_STATUS__TEE_ERROR_ACCESS_DENIED:
 		if (ras_cmd->cmd_id == RAS_TA_CMD_ID__TRIGGER_ERROR)
 			RAS_DEV_WARN(ras_core->dev,
 				 "RAS WARNING: Inject error to critical region is not allowed\n");
-		break;
+		return -EACCES;
 	default:
 		RAS_DEV_WARN(ras_core->dev,
 			 "RAS WARNING: ras status = 0x%X\n", ras_cmd->ras_status);
-		break;
+		return -EINVAL;
 	}
 }
 
@@ -417,7 +418,7 @@ static int send_ras_ta_runtime_cmd(struct ras_core_context *ras_core,
 	if (!ras_cmd->ras_status && out && out_size)
 		memcpy(out, &ras_cmd->ras_out_message, out_size);
 
-	__check_ras_ta_cmd_resp(ras_core, ras_cmd);
+	ret = __check_ras_ta_cmd_resp(ras_core, ras_cmd);
 
 unlock:
 	mutex_unlock(&ta_ctx->ta_mutex);
-- 
2.43.0

