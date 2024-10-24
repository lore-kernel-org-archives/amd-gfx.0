Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A914ED0BB46
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 00:40:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E3DE10E873;
	Thu, 24 Oct 2024 00:40:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L2iL0Kvt";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81F9110E24F
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 00:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=la+anl9VuMOoxHETAD8WSuzPqnBWRLJ2c+VHm3QGwlsYUGcEbH06x4Hm//hlgtN7Pl7z7bbsIF6KQcsfOrrVlEZboGkAGRXeDwf0XjfUxZdR8QVHVI1ga6Bv5Q/soz6sTlzzuM+UBtpjndDK5AihRKTW6Iquh7s46KyQeSpj0l3i1zkDy0d4nSD5rGAxp041NziQhX921ogf1FGZB/sWC5tPvjZTuc9alsDJWIsZnYN/+ZGa6mYUVMn7TsshZTTtn4pq3uYnJDvXFN4V5IFZk2FqiDmpticbRRLsxmqFD2C7R9LUe+q0kYwdTb1/dSmBtkWIxT0Cey2OIlorjDza+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBjR+depI+qSGo1mplr1Ix/u9megV4kSoaEm3PnBqnE=;
 b=mSi1pKNyJ6YEdKVw5KuDk/cnMU0d42+pDE7BnCn+JBJuqIoSghlQf38ZcIROuNzr1yob0tHkIPp+9qgz2doVewC4wOYOdKM7YjCx+ojjmFSRzwZM6pHqA6Fbc2Uc/tI+x6j/ZT4T1zjtk+7vrc8N7ZTNn0Nsmr4L7wbQqgWyq4DihQTecf7msqmc7pImRvdOr/MNxPVvzznUPrbCNPZHZzouN0JgKV/SRUcU8TqT9oykhfJI4Pu73N/f5NjvKee7HeXzoPCqQ80Jyxv5d5eElUSBymVDAk0nK7Qx10hGPfbwug26EIi2EkhPJ8kguqkTBvP7m/U7UwIUfBme+cqBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBjR+depI+qSGo1mplr1Ix/u9megV4kSoaEm3PnBqnE=;
 b=L2iL0Kvtf4xNfVk0sn7ITA6W0GEj+1MqiAR68oI2Ef22gScdfM63P5MeTvZskANn7lBccE8gp2Lwj16axr8LGHI3FoCV2mto/suZkmEPZJSPirLbjMLpDKzpKVAh/iNRs/DaMTtV6uHnbWStneTWXxppWYu1to9LrfBow150DC8=
Received: from SJ0PR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:33f::11)
 by DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Thu, 24 Oct
 2024 00:40:17 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::5e) by SJ0PR05CA0036.outlook.office365.com
 (2603:10b6:a03:33f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Thu, 24 Oct 2024 00:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 00:40:16 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 19:40:16 -0500
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amd/amdgpu: limit single process inside MES
Date: Wed, 23 Oct 2024 20:40:04 -0400
Message-ID: <20241024004004.1216961-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|DS7PR12MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 5079ea4b-fe32-46f8-c448-08dcf3c46e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HXRi0IoJ8FW+yFFOCmE20G4Bn52PsXHwbvNLQ1/PeiDRbr4rY61lFgU1B7B7?=
 =?us-ascii?Q?aXYdKn2rx+5hUxegdfcs3KTVUr8sWPBYRYc6ZD03erBadwn7XQycngbA7q6b?=
 =?us-ascii?Q?/GYT2JFuqgbVxL1adkQ3I3JLG+tZC7i0ZEHarwq6oU6TU3VlrmHX5gcZf3Ma?=
 =?us-ascii?Q?w4ss6bDSLklyD7vgkVbqyKB1gVJBnuOXBto/mh1Ond9Co/txCYc2fR37U4CI?=
 =?us-ascii?Q?SwiFiqCblm2gFf4XZbqw6IxDDkeV8isgto4R9SQ5WKFjdr3Xjc4ZRSECL6d6?=
 =?us-ascii?Q?vKOChRD0WfT+q2cTuQ5lYrY2sPCYdYtWST4BJl14Q+0XkbjKA7OVkLllm/GE?=
 =?us-ascii?Q?oyLJ4Px11rOd6Tw50UFVg9auAB5kzNEkKNVhAidRQPrfa3yd3/aOJQMasR0X?=
 =?us-ascii?Q?cGQUcuF9QR3NwQiou837MQhELNiTn+Rr4X4suDtxUOt+TQFANmJVJEQ2VAHf?=
 =?us-ascii?Q?VnOcQrWyeHAy/wY9zi6CD4L0iKtP9hu2ASedSTNJE4hn7Wx+nZUPo9/RPgeG?=
 =?us-ascii?Q?l3WZUAU1XAoenNh4eicNsUAfKChXmL13ln+9svS2W9D7HDtHD8uxm+Y1UadE?=
 =?us-ascii?Q?1k+FOsopqJXpAJIODhjgKOrGrnapfVUHKV9F3srd69C1pbLVYVizALzchiTM?=
 =?us-ascii?Q?OXyMEizoKPNs8uRNSTLpOuc8mV+vqplXyL1I5kwZGToGVaNHAG8xPrkXWubL?=
 =?us-ascii?Q?Xgw/8PnKGTlalazzoyihFGqL54+pg2kXOnR9Q2vgV/6VTWbOURg3ezFn6Wo8?=
 =?us-ascii?Q?el9f6USkCjzACXAhjQSvBBFe67qJ+qkvqQMsTKw3BlrunUVbr7GUb+tsp24H?=
 =?us-ascii?Q?VOVJVMMC+nyp5n2n/U1M7Hfnyom439IkB/+C1B7S+qVBKdWFb1KnITAfX7o9?=
 =?us-ascii?Q?Fe3CnaWpbluApEQxvx7YPMb3GyQ7xDnygkVLnxO0TIOSvxHY7nwafPqo5QIe?=
 =?us-ascii?Q?vfUw8Wmnjwnag09WAsvtBcPHBzz/Db+VYE3p/dCSxtFDNcj/n6FKBjzocsiC?=
 =?us-ascii?Q?6T4C3oLD0+fPU7Gbfrr+mIXePgMrSGhBOpnXJCI8P5AMWA9CTLlquQ5B+7Tv?=
 =?us-ascii?Q?cipAtGqyICeQroSDwixlc1vcIVcl10VtGNfbyEOJod0rMyV7yyLxW/TTqCpv?=
 =?us-ascii?Q?dEg9vEUgm5rNs9SoAi9WNrjhuPQlcHlb+PIzwJc8FsXFmhawbsJlte8oobAj?=
 =?us-ascii?Q?AA6RdpqEXAqPJIGbWSymCG0bGmdqHNgKDl/Do9lk+6IOayH/4Lqakdfcsb/n?=
 =?us-ascii?Q?M343Ba45T6EgV1i5axAzEzjN1voc8xoqL/lEjCyWWN0ToXYJQtHjulLTYcNM?=
 =?us-ascii?Q?voZNGP0sXvHzStifPw35iGv2Xs6bo5WZl6bKuiwNxytvqkkoZZhJ36C27jX1?=
 =?us-ascii?Q?/p9hjBXU1CV4pm6ODPwwFW5FCkBfz0jeKyypQdK1/c3z/nRDgw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 00:40:16.8328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5079ea4b-fe32-46f8-c448-08dcf3c46e53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720
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
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 11 +++++++++++
 5 files changed, 71 insertions(+)

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
index bf584e9bcce4..dfc7d320fcbc 100644
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
+		dev_err(adev->dev,"mes change config is not supported!\n");
+		r = -EINVAL;
+		goto error;
+	}
+
+	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	if (r)
+		dev_err(adev->dev, "failed to change_config.\n");
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
index 57db0c006c8f..c621ba805433 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -644,6 +644,18 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 				sizeof(misc_pkt.set_shader_debugger.tcp_watch_cntl));
 		misc_pkt.set_shader_debugger.trap_en = input->set_shader_debugger.trap_en;
 		break;
+	case MES_MISC_OP_CHANGE_CONFIG:
+		if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) < 0x63) {
+			dev_err(adev->dev, "MES FW versoin must be larger than 0x63 to support limit single process feature.\n");
+			return -EINVAL;
+		}
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
@@ -719,6 +731,9 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 					mes->event_log_gpu_addr;
 	}
 
+	if (enforce_isolation)
+		mes_set_hw_res_pkt.limit_single_process =1;
+
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
 			offsetof(union MESAPI_SET_HW_RESOURCES, api_status));
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 9d0e342a2f81..26d1b82721ce 100644
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
 
+	if (enforce_isolation)
+		mes_set_hw_res_pkt.limit_single_process =1;
+
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
 			offsetof(union MESAPI_SET_HW_RESOURCES, api_status));
-- 
2.34.1

