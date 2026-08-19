Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DDCC5DF81
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 20:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F7710E1B5;
	Wed, 19 Aug 2026 20:15:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c4MupS58";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012054.outbound.protection.outlook.com
 [40.93.195.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CE410E1B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 20:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+mL01xrKdq2iPB0xnrvXKDg9LEfw+9Q0D389L6Y7dNLHV0Ix7WAukxDKhPSxirCWMwW0bB3aLSI8/s53w26SJO1mV+N75CG/8PvNuIatdp/dRbJoUpTbk8W8fiiCpUujBwr8ufk8scdFdYFmy/jxfiJDxbfg+tADm/c2WvLeeoBBT54SsnRFq8Ym8Ae7G0iIQCNshwu0B+OPc5x8Zvar9chfauhBMMd8D2OieUpUfMZTicdvzkgnrLZb5DikAQorPQqCUCINSDgP91M0iL2BC9Wu6drPBT++nefhRPo4igF6wN56B1SxQMSwOHxVfnvYAOXkKmxzMWxJ+lOtuXarg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdBZPhoyxXdXPgqm5QEIWn37cMEdNyljFt1Mk0HQqNs=;
 b=ZNh4emeNa4b4qnSvliVdqrAj4mOotX75ttXr0XA7JtP2znBpaRhKz5NibNXbGljtanKu0VlaHJRIFRjiMnk/03IKlDG337h2Mf+1NJrk28f7HzXJu1k4b0a8A08cjra6qtaMS1K/GX5Jd9u5qLWvyUmU9YVeiKcB0DB1WDyhfH2JNhkgUAFw4b5wylyUqwrzw99AfBixP+X76qsD8O2GOH/yk5Uq/xS7EZSXiFtqfj5Ly8mUye7ombnnMHPXbvvCsy/ORRjMDPHXKYOLf/MzA4hPwmfj4V1u8jYfQOISTTsh/S/Vhjg977lhfustbkrq+Ooev+fliZ2nAhGerpsw2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdBZPhoyxXdXPgqm5QEIWn37cMEdNyljFt1Mk0HQqNs=;
 b=c4MupS58vZRjB8SohN1gdplyzxEyIP7AEVIYjvzFOos5ij0HN63LOn+INSSZo8MrfbgwN6r5qR4XPQrENbGFNsWgB3kyGSE2MZAxtKk5YDGs7F+8fbBGTnZiiqVqxEPwt2gMzbWDLPLY10w3GvUpcQg9SyxudbZ2trEdDnMB24E=
Received: from CH5PR05CA0004.namprd05.prod.outlook.com (2603:10b6:610:1f0::9)
 by CY1PR12MB9626.namprd12.prod.outlook.com (2603:10b6:930:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 20:15:06 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::49) by CH5PR05CA0004.outlook.office365.com
 (2603:10b6:610:1f0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 20:15:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 20:15:06 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 15:15:04 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tishko.Araz@amd.com>, <Alexander.Deucher@amd.com>, Eric Huang
 <jinhuieric.huang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add new mes misc api for gfx11
Date: Wed, 19 Aug 2026 16:14:41 -0400
Message-ID: <20260819201443.282689-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|CY1PR12MB9626:EE_
X-MS-Office365-Filtering-Correlation-Id: b76937c2-a0e2-44f8-9ae7-08defe2e8f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: TbaF0RaGp+qzaQG7YIUq62etufDiG1MozXEa/0E7qbkgsVclyJ4sU19tSDmlKBE7csH4xlEh/UQ9rZ5ZtmLcNG6nTguhr4nOa/ZDoOjSOCldvOeUDEHPMaixNuNxky2zJzFwCkAolYq7mxQTqbA8c8HtLycu508xbUq6wjWHw2Bl1GaPzwxTuWEqwfN8lxsxtEagNCv9QXE1f4wSG31FWJJaTUcql20GdH3Wc0PIL//OGEuPGxhqqFHzclOZ6/StshEFD+E6aUrT3pnVBWdDRL9sd2ywYytyA4mweRETWg5vzqCwhhYB//lztEqE0BFVE0Jlw/S+3BEES5Hgt/YmiBG5Ao1xv00HB9QGmCNK7Fjy7jTSp8pvRr3MAymFckZxw5VNVfjwa7ImLAhkOpwqzqm04YIBQ4ca8R2FWePtUMDjKoJH87De5Cmb2eOb/I/W4n8by9Ku1BRCCUHWJSwPkXaYduswtHLmYMmuQAFwLt/kDtS1a0k/yXatdYTRD0Kh/Xf0cGSDyNdWXSDDPhm9ggRwhh0LofmQg0ePy7FNFo8dynxTleNV1mvoowIIJLhkYCG3uxXhOVfikVc9Ap94kLAqvfn+cz5X38crBLR0AMNCvkbO0X6awPkwqYBgBcDmxmgo1iOLR8J4927Jpn7WhyJP9zZwfeAAstRJuD6D8bLSLeP+Av2eoZ8XcethDrEHJRHv0u/suAe1yjorwZdj4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5zcyNVzjYzuzfOZ+t4NR/QJuyiGjdn0jU049JBdga2Tq62dI3GARamh4ClcfPnPDZZjVZOul2Ba4eZbumc/4MeF1GEtnjGSU8O27AGadOQIFKBkocEZ2hmDEr5Pqak92jJCtKUc31upeb4JljwIlbTjW9gtNSpWCxHWbtYjB1yMpTyCLHiATfMhcFrRukvbH20ZhHxeOukrrlpT0SWhSgAvgrV+s2q2kJvKU3VvQTQLy0Ivk+YxpIPbfIOZnAdbZ9W8jDUnWjqrJwjlvIfeE5cT3ZI8isErE02hnPi8DRCw3sZG0Rge4xbGBSKmx4h3qs7eURntFlsc3ufswH4fG4hwJkQvHDNFk/elxvZ2YhtvzsaKSPBSYGyl2Y8Jrd63jMpzrvqKFgbPs6uhPMFdgkiJdinsTh0YMpiDfaKMrDr5c4UYrKAr4o749yjMa9X7B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 20:15:06.0226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b76937c2-a0e2-44f8-9ae7-08defe2e8f66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9626
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

new api will be used to workaround a HW scheduler issue
for 100% usage when gpu has no workload.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 10 +++++++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index b96f94e5169f..421d937c1188 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1140,6 +1140,29 @@ void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
 	amdgpu_mes_unlock(mes);
 }
 
+int amdgpu_mes_notify_unmap_queue(struct amdgpu_device *adev)
+{
+	struct mes_misc_op_input op_input = {0};
+	int r;
+
+	op_input.op = MES_MISC_NOTIFY_WORK_ON_UNMAPPED_QUEUE;
+
+	if (!adev->mes.funcs->misc_op) {
+		dev_err(adev->dev, "mes notify unmap queue is not supported!\n");
+		r = -EINVAL;
+		goto error;
+	}
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "failed to notify unmap queue.\n");
+
+error:
+	return r;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 977c057dcce8..0291ae14a1e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -366,6 +366,7 @@ enum mes_misc_opcode {
 	MES_MISC_OP_WRM_REG_WR_WAIT,
 	MES_MISC_OP_SET_SHADER_DEBUGGER,
 	MES_MISC_OP_CHANGE_CONFIG,
+	MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE
 };
 
 struct mes_misc_op_input {
@@ -643,4 +644,7 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
 				    uint32_t *index);
 void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
 				    uint32_t index);
+
+int amdgpu_mes_notify_unmap_queue(struct amdgpu_device *adev);
+
 #endif /* __AMDGPU_MES_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index c57bcb9a98b1..df71e9447b35 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -957,7 +957,15 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.change_config.option.bits.limit_single_process =
 				input->change_config.option.limit_single_process;
 		break;
-
+	case MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE:
+		if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) < 0x70) {
+			dev_warn_once(mes->adev->dev,
+				      "MES FW version must be larger than 0x70 to support notify work on unmapped queue.\n");
+			return 0;
+		}
+		misc_pkt.opcode = MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE;
+		misc_pkt.queue_sch_level = AMD_PRIORITY_LEVEL_NORMAL;
+		break;
 	default:
 		drm_err(adev_to_drm(mes->adev), "unsupported misc op (%d)\n", input->op);
 		return -EINVAL;
-- 
2.34.1

