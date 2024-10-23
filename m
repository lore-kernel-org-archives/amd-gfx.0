Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C098FCFA45E
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 17:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D32110E0F2;
	Wed, 23 Oct 2024 17:41:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aurjHy11";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06B7010E795
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 17:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPPjkt4NOKmkyLQjCqxYWb56rnORmn/b12WOMTz/y9yaIv+XhDZakNpksjOogKC8kfnjew09flCzjifwC3AhLFgJ3rfp4hiIOJPGP4PH7LiIdnh7MOFuTLN9Gu55N2o0FU6y9RwBFPqMmef/m30SMWLqlTI4OEMQ88JnahygCparWYUc+hiO6K0qH+OPfYo/Szfjx4jnbzfuF3RPbrDGlIDcb89r9ctRh8R2Yvft63xAtGLxzEzjw5mv0o9VNGtC1BXMMUYOQQlm1W2CCeAm4tq2FDQBXuiDVTbeoyxNTgLFmE/ng5D9bjNR86bZTV3sqy22GvzBk7ebG0j/Miv4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXjNQae3zbW2on7o0hu/JlR0H0qGpfRpuP6GHOYLAfg=;
 b=SVGnkRZZGPW8KcHRDbu3NCeTxzvHpkYOy0Uz5B/yFWG39oP9MDcQyxoOL0irOrjrUPjPXRsP+vD9Gml9KfeyqeTeuNcYrpekpqNLvLgdwcrPs94iz2l0qZcyLIU1HAQz9/2lE7wRLuKz/NnydCwzarMMKZZ2mVBk55cGkXFKabG8UPtyPkeQ/UA2CcIYPKRHYNgmLn+o5ylBhAvePvBEIw1C11UgDgQOwqOCvNHdxWacePmXUk7NETf4y+xe0O13s7Ar0dOdrH30KybBTLnlUPahsoYMEGNt4av/DkkjvyLjp9f/I5QhB3c298Wun38nK+Wm8O9dB44WRjG9Plcg5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXjNQae3zbW2on7o0hu/JlR0H0qGpfRpuP6GHOYLAfg=;
 b=aurjHy11NkK6AYePjEmjuatUpbrKvG6PzNYo9ZChgLtpehhCDNmxjnt+bYmmXT8DAWs7jkawaL+IHu6CdeNHKvAZN7PMjZneqWzR1CAZNon8fkrITPewfqXWkkrPIP+NdKHl7VyoUstjbAlBdCCWD+IaqjyrdUwvw005RAElYyc=
Received: from MN2PR19CA0062.namprd19.prod.outlook.com (2603:10b6:208:19b::39)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 17:41:13 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::fa) by MN2PR19CA0062.outlook.office365.com
 (2603:10b6:208:19b::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25 via Frontend
 Transport; Wed, 23 Oct 2024 17:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:41:12 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:41:12 -0500
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amd/amdgpu: limit single process inside MES
Date: Wed, 23 Oct 2024 13:40:59 -0400
Message-ID: <20241023174059.1215976-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: 4abbc542-cc82-4ad5-c024-08dcf389e34f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IqQqzKwQ3nqprJC16mGf2oqhGdCMSmk1jT8twZB1UuBj1ussRJVcS6Ei43cs?=
 =?us-ascii?Q?I/FpU7Fz3OF37pfiHSMLxWIqsby360/l+94wCBBBQjSWiac8J+SVWBTwzvKt?=
 =?us-ascii?Q?qoEfTmk0khErBg2J9pprugj5ntCXAzIqfaCH/dDCbnWVR55N4az6EYgJk+fC?=
 =?us-ascii?Q?W26yU8NULDRWhG03JQJQ1DFh1uoLCgMNep0/qVZQBOzQuLWiH/C+HbHMPlo6?=
 =?us-ascii?Q?kAW9ql/8mqnRUB25PjNdwaOTer4GYVLbHexbcTShk7BqpZg/+ZaJ7jrKq2FF?=
 =?us-ascii?Q?kEeHeYKs9MEZAn3XbKIe72qHn/8JKmq6oI/0LPcucFgzUveykUDhYbd9o1ji?=
 =?us-ascii?Q?8QkFgvSBu5TuIG+mFGGnXJyUwzsvuefUKrgvDDo1UDtBp0x0gGe3wnaUgeTB?=
 =?us-ascii?Q?cd0JEcwDucl1RC4Ypc6KV/yGL3UDevT4iDAeDJm4I0IZpObl9goooTfjb23n?=
 =?us-ascii?Q?bD3X8OQY5i6fwC+7753dzYnKTRk0I9aS0ylctXE0QlXaYU7EMiecN+jI+iL9?=
 =?us-ascii?Q?5rFtyb15oIijzCoynmBBKwQxhTnA6cRUdeTvol1sIO5/vpdOZDVavo05ukxL?=
 =?us-ascii?Q?jG2ZHXCO9urkwR2pwxwdZXt4Yo12/CTwDoqj0p6t5rZ2ftXXwPfFKIICpL9i?=
 =?us-ascii?Q?Nu6uDLxTkKGmEqcLm5z2rn/6mczr4rUF8sledmRxXESHe8FO+1hmow5KKEea?=
 =?us-ascii?Q?t/B1hOO5KtQ/VHPw0VdQbRz85HLkbsmdJZlojiDwGK6pskTPF8yWJRMqDtpn?=
 =?us-ascii?Q?kdegXngvVWVktd1DtITDUMEVSLyzlEDeBTmc1uLiugjzicdkzJzxgRIMmO6h?=
 =?us-ascii?Q?V6ect+XTzBbJ7urnQlOQGafR7QK4KAytBlGqTBnahwnvg9YgxzF++ehGfV15?=
 =?us-ascii?Q?5dSJqWYx/fzCkBL+t12fh2s5Y00L9iyuTPMRlwD2h6Bq3DY08ordBbwVvtPV?=
 =?us-ascii?Q?2a/6ds7/u5RCW8E7DU2Qj8f3I4sbLqzn1+6ZebklKk7fM0tKEqCqYohqeHzB?=
 =?us-ascii?Q?5Vlm+HMDYVszBwhUelYY7Dc1XSntSMn8KbCTmGXYfYWWW3R+t5vhPP116lrw?=
 =?us-ascii?Q?A8K9sW92iaVTiV16avPvrCvZJU3j6BKco1Y3xofU+nMnDLaS6/3kSr/hlEUj?=
 =?us-ascii?Q?IHj+pGJWdkiWKRCRF31NY8e11NTR0u4PPSSFw7/vwVP/Xm1dJ/kC4s+MpjB1?=
 =?us-ascii?Q?qzAwy965R72u2oXBQdjWWLzuk8wnKn/fyUSLbC6eWcqL+qOGXFNT6U4LSkXn?=
 =?us-ascii?Q?+i/sb+2n/BMtMGB+KiqxNvDVgnuwx7ycyEw+6SlHxsxHxgbnqG8EIGcG5y5M?=
 =?us-ascii?Q?GlrgR/Ik231xwMGUlG7l+iW3Cus8vRvLn7NBapaOBBYOcp/cQgZZTOJe5wOf?=
 =?us-ascii?Q?bHDrNdSB3r8Oyr2jkP/g35WXr5+9kxsfLbts5HsnpywByM5ZSQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:41:12.8866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abbc542-cc82-4ad5-c024-08dcf389e34f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
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

This is for MES to limit only one process for the user queues

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 11 +++++++++++
 5 files changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e96984c53e72..72e38d621a29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1576,9 +1576,11 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
 		if (adev->enforce_isolation[i] && !partition_values[i]) {
 			/* Going from enabled to disabled */
 			amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
+			amdgpu_mes_set_enforce_isolation(adev, i, false);
 		} else if (!adev->enforce_isolation[i] && partition_values[i]) {
 			/* Going from disabled to enabled */
 			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
+			amdgpu_mes_set_enforce_isolation(adev, i, true);
 		}
 		adev->enforce_isolation[i] = partition_values[i];
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index bf584e9bcce4..29b6a2baae4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1674,6 +1674,30 @@ bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
 	return is_supported;
 }
 
+/* Fix me -- node_id is used to identify the correct MES instances in the future */
+int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_id, bool enable)
+{
+	struct mes_misc_op_input op_input = {0};
+	int r;
+
+	op_input.op = MES_MISC_OP_CHANGE_CONFIG;
+	op_input.change_config.option.limit_single_process = enable ? 1 : 0;
+
+	if (!adev->mes.funcs->misc_op) {
+		DRM_ERROR("mes change config is not supported!\n");
+		r = -EINVAL;
+		goto error;
+	}
+
+	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	if (r)
+		DRM_ERROR("failed to change_config.\n");
+
+error:
+	return r;
+
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 79f13d7e5e16..91bff6443c05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -311,6 +311,7 @@ enum mes_misc_opcode {
 	MES_MISC_OP_WRM_REG_WAIT,
 	MES_MISC_OP_WRM_REG_WR_WAIT,
 	MES_MISC_OP_SET_SHADER_DEBUGGER,
+	MES_MISC_OP_CHANGE_CONFIG,
 };
 
 struct mes_misc_op_input {
@@ -349,6 +350,21 @@ struct mes_misc_op_input {
 			uint32_t tcp_watch_cntl[4];
 			uint32_t trap_en;
 		} set_shader_debugger;
+
+		struct {
+			union {
+				struct {
+					uint32_t limit_single_process : 1;
+					uint32_t enable_hws_logging_buffer : 1;
+					uint32_t reserved : 30;
+				};
+				uint32_t all;
+			} option;
+			struct {
+				uint32_t tdr_level;
+				uint32_t tdr_delay;
+			} tdr_config;
+		} change_config;
 	};
 };
 
@@ -519,4 +535,7 @@ static inline void amdgpu_mes_unlock(struct amdgpu_mes *mes)
 }
 
 bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev);
+
+int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_t node_id, bool enable);
+
 #endif /* __AMDGPU_MES_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 57db0c006c8f..1d6de7bced48 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -644,6 +644,14 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 				sizeof(misc_pkt.set_shader_debugger.tcp_watch_cntl));
 		misc_pkt.set_shader_debugger.trap_en = input->set_shader_debugger.trap_en;
 		break;
+	case MES_MISC_OP_CHANGE_CONFIG:
+		misc_pkt.opcode = MESAPI_MISC__CHANGE_CONFIG;
+		misc_pkt.change_config.opcode =
+				MESAPI_MISC__CHANGE_CONFIG_OPTION_LIMIT_SINGLE_PROCESS;
+		misc_pkt.change_config.option.bits.limit_single_process =
+				input->change_config.option.limit_single_process;
+		break;
+
 	default:
 		DRM_ERROR("unsupported misc op (%d) \n", input->op);
 		return -EINVAL;
@@ -719,6 +727,9 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 					mes->event_log_gpu_addr;
 	}
 
+	if(enforce_isolation)
+		mes_set_hw_res_pkt.limit_single_process =1;
+
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
 			offsetof(union MESAPI_SET_HW_RESOURCES, api_status));
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 9d0e342a2f81..85eff9b777c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -531,6 +531,14 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 				sizeof(misc_pkt.set_shader_debugger.tcp_watch_cntl));
 		misc_pkt.set_shader_debugger.trap_en = input->set_shader_debugger.trap_en;
 		break;
+	case MES_MISC_OP_CHANGE_CONFIG:
+		misc_pkt.opcode = MESAPI_MISC__CHANGE_CONFIG;
+		misc_pkt.change_config.opcode =
+				MESAPI_MISC__CHANGE_CONFIG_OPTION_LIMIT_SINGLE_PROCESS;
+		misc_pkt.change_config.option.bits.limit_single_process =
+				input->change_config.option.limit_single_process;
+		break;
+
 	default:
 		DRM_ERROR("unsupported misc op (%d) \n", input->op);
 		return -EINVAL;
@@ -633,6 +641,9 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 		mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr = mes->event_log_gpu_addr + pipe * AMDGPU_MES_LOG_BUFFER_SIZE;
 	}
 
+	if(enforce_isolation)
+		mes_set_hw_res_pkt.limit_single_process =1;
+
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
 			offsetof(union MESAPI_SET_HW_RESOURCES, api_status));
-- 
2.34.1

