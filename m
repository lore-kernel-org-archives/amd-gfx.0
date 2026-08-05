Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7F6C55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 21:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0CD910EFF1;
	Wed,  5 Aug 2026 21:27:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i/xA2j3N";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 674BD10EFF1
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 21:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqWb9qHxTcCcKPvfMfgyIdi1Ru30UfAhgWcRYnAxxb2ezzQaJL3bHXhtJOPs8Whghslg/I0TRloZYG72HE3BchT9vY+kBjcNW81NEn3FkZyx/iiZ8UM4OUf500vsKW+d0NA1dZgwagGO1bdIplcKQaWbNj89ftJ0uPC7HY7hZBszt+UVjnlnZIuFc8OA7uerbSdBlBhZnGneAT7VDaETz9BID3UAiAA9y8pxJ5Eak8xUJ+7oOckeqiypu9vkNf0R5wi3tMPhWWPg2/doq2rRvCaGjytalH3TcmJPkNdO3G20CABJPi/EMd2WFjYsTSzG2AzhAhm5Xt022CQfe82VAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7sqrLV+Po/LFf4Engxq+1fUPsXGG8SuvQpe4RQPOwg=;
 b=psBddqrIcevziIjyvYsyMeZT3WJBjJCwKFAyX2pkKSJF1fCu/a8b0/ZyF/zOzMlom6k36Ht3jXiAJejaC9VB+5DlpslyYAkTN6jUlMj4KLvxDiyH+JZkRE7eW6VoaYFmZN3yRa6eSmmhGCDRFuAtpyAhxfJ/zV6SjdTqWa2syw1vbLhkIZXdYO6+FDipyXe84e1Thgl96oA3UE7Ylqc6KEFQGAJ8TT3rpdyY+39bhfuVezjIKKeBbktWVrh8XDB/9a2/58Mx/tx4iW9tuag4hE3SQ6V8w7LJsZ+kaBE5j1y+zj2J9QknTcio6INSOzsz3PvUCrYep+OUKl+wjnKcGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7sqrLV+Po/LFf4Engxq+1fUPsXGG8SuvQpe4RQPOwg=;
 b=i/xA2j3NmGEqikRh+iqEuNEpmDc94GPr0tPbYZ+A0ApTnliBmJCfEBwhKekmES+An7Z0cShP753THo3KIsh9AjXk/AfAubST4kZyWy6efPcIk1KBYw2V9BBi005I30gFlp9nRuUZ8QedbaBbpJlKMVYdkrVRnDNcpEL+tjh/eks=
Received: from CH5PR02CA0012.namprd02.prod.outlook.com (2603:10b6:610:1ed::11)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 21:27:50 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:1ed:cafe::36) by CH5PR02CA0012.outlook.office365.com
 (2603:10b6:610:1ed::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.19 via Frontend Transport; Wed, 5
 Aug 2026 21:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Wed, 5 Aug 2026 21:27:50 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 5 Aug 2026 16:27:49 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tishko.Araz@amd.com>, Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add new mes misc api for gfx11
Date: Wed, 5 Aug 2026 17:27:21 -0400
Message-ID: <20260805212722.247508-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: ad42a2cd-977f-4a82-f471-08def33866f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: TpPWaxXfVnSUm8vW2uxx83wuU6sU5QMjDoAg6NqjaFTURssd7c7cIVkaMPhnfiKySUBk+/EzWlEcdTSefUm0RwKm1VTF2VRo/KD32G4XNf93SIPm8iPWNWUXslE+JitSml6myVdK7DVH4dH88k4K64AGsyXNzmtJZDOuEYTORvKhBHwmbFhIrGUkROladjGUHqlscLwFSqXOqLJl8EA7guHJ7Mtl6KPBfaBn+EPE8gm36aCyuPBmqDw3NM0PWt6ChzIs5g/l90mDJ5WnZA2D3rqHO4KGfzTlfvoHwhQ2Ffkvpg5LYGW86jXE2fh+3UGsEmNW2hgR4i9ceKFrGnnUG2AeZkEdAV4EFFMiO6pBGMQWmxx1IgDp3dv40tZBN2XnSPUa24ypNTGheLVwHvGeyceCx4qEeR1P2lUXVIGVm0TI6RgZkXveAXjs8d9FO1s1Y4ZzubatAlmwU0uB8erWUryZCQE1w92lb8X0tOcFAqSuaUHbP4BrfA2tSgbpZ7SI2J3BsTtUnedeksGUFVaubEBNfY/NYB4WzuD58vvxMAHzTw/vhlGY7gZCp3gNmVs770jbewbawwnzXO9DlBQx2lqS55H5hFO0xCa3t3SHPwjqNk93JwJWFDADfxA8TuP/pCak1RHNPhGkaECVWrW+1o+wTrFue2Du9wWtFYThAntQmXQ9yxDcgKQSEMpkTuiqecptPFG7tp+t+fWUonKwrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p7rJ3S03Knk+JtqhfxqfUFLNwMF+m+cvqpKJgclVmkTwFh0MYt3aTtcQSkcTuCFBqDbPa9AAximOJdOfuHMogfQr6s3g/2KeqqtFnQgrCkAUgMYZUPq76dgqwDQk7INp2/rPplFvGSg7mDt0J6tFhnHHb2h6sw4VdJ2tOPGIc9FjcizxvmZKFPpd87UyrnFBVP47Gq6pxDo14bxqkiG0YlsGSSHz+ZOK/ZmH1HNxYO75nI30Uxg2DawWWMoielyrfWq4V5dADBFTV3L+k5M5g4FrTsQcuBCoeH6Kn0clIFoidc4PEGk+MNiYhG3DHLZPgMwRoSi4lgN3AdfUUT/sw23YpKLtBZBromyBNpKQ7G3bVlsYTq0rNrpw+AdAyPWC61GIDD5s/F9OBcvQqbMsuxEuEUeIHKOO50z6EO4ASN8pq7tOL2lXm7zblMJuiSqV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 21:27:50.3217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad42a2cd-977f-4a82-f471-08def33866f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
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
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  5 ++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

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
index 977c057dcce8..5230b1ba1a46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -366,6 +366,7 @@ enum mes_misc_opcode {
 	MES_MISC_OP_WRM_REG_WR_WAIT,
 	MES_MISC_OP_SET_SHADER_DEBUGGER,
 	MES_MISC_OP_CHANGE_CONFIG,
+	MES_MISC_NOTIFY_WORK_ON_UNMAPPED_QUEUE
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
index a0b874c9ee7b..bc0ee6ccfca7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -957,7 +957,10 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.change_config.option.bits.limit_single_process =
 				input->change_config.option.limit_single_process;
 		break;
-
+	case MES_MISC_NOTIFY_WORK_ON_UNMAPPED_QUEUE:
+		misc_pkt.opcode = MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE;
+		misc_pkt.queue_sch_level = AMD_PRIORITY_LEVEL_NORMAL;
+		break;
 	default:
 		drm_err(adev_to_drm(mes->adev), "unsupported misc op (%d)\n", input->op);
 		return -EINVAL;
-- 
2.34.1

