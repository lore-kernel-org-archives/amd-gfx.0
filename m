Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09611FF885E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C7E510E618;
	Mon, 27 Apr 2026 08:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iCi6b2hV";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F06110E610
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 08:36:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohL6kcaXTGZUaZoAEdEnCXLANgmOKiQnl9k1ClqVKxqe5PqEfF0A+uY7YIUeeZS3Wsul9NiLHEDZU2NRVfgQ3RnV+DP+Wx8fwWDZ1Mx/n8jTcAzbZ4eZM9c3zZVosfD/tEIwgdmAwvbq5YzwG95c3nnPRV0xyvLuby/ilXb59f3bZclAZnWkS/gFsbaAxJhWTOIb1/j0iEAnQ1398DF60il0zi1YapsZKtDKQ7DV3wGuumBVUuOFTDNyZ8HyXUAREKCTQyIXyeBYMsiCpW01XFpQlIJZxgYc8tbGgwNQbH3LvX7dmUEryUElaOh50rbp2GdybIAPeq2YLNjBrnjANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B17AOYQKaY5fV1Ipw39QGrzjDPgcbBiajKYUVbEjCRo=;
 b=HnQG0q5QO79LbDxLQJhAFnsJZm//DUOEmt7KOWUN40iSRVNoDex+GG7QxarN9gN+WB7sc+GDUhmZteGH0MyjK16QjOoSDD8NyTR094h8GEO8gO8oQVgwy15rby/jSLxzASm9SMKbdv7R8Apy3UApimwrsxlJlS6T5V5VXiD7WOK8WqlCOgh/29fWaboGZ8I2podortDwCD9D82/w/BW7OjEi1ttwwvBlf4rvVtuSSI2pjuJCNDOsaY1NZNAyAUHyDKHhlXFoV9ojBt7iFZ//OTDOEtkhOf5h8Dkwp9N0uGmfmZtd6Q367UBnLjCBz11oAii6fuOo+9rReT5Neu0stw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B17AOYQKaY5fV1Ipw39QGrzjDPgcbBiajKYUVbEjCRo=;
 b=iCi6b2hVeTkdEieYSIjAXP5mxpxicHvDhI+GrbDOVFWMo9mlTdSToBOpicZ/Okjy82e9gNgW0sq9hjeosiqtf3guSQ6uc2/JK6lT9qzEU6BFl1115200zCdd2iiQxZQLrdQNNaqwCe/4Nmi1GTSUaeQjdiiQELsWorG3grP/gus=
Received: from CH0PR04CA0110.namprd04.prod.outlook.com (2603:10b6:610:75::25)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 08:36:35 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::9f) by CH0PR04CA0110.outlook.office365.com
 (2603:10b6:610:75::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 08:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 08:36:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 03:36:34 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Apr 2026 03:36:33 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 09/11] drm/amdgpu/mes12: plumb is_user_mode_submission,
 unmap_flag_addr, NOTIFY
Date: Mon, 27 Apr 2026 16:34:35 +0800
Message-ID: <20260427083543.1328533-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
References: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|BL1PR12MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f69f3bd-fb9a-4d91-b7f5-08dea4381778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0jLcRD4eS3zpjaU3I1PoqGlzlqfeL4nbFZAY8vokYwcbUAftJgwMJvM2dHXIGbWD3NlgZeMoCZkRPqkVTuBxZcJV5TIyFcfhcC/7W1+4d7FqoEXV+1qDXZ2fkX3pWf7mm6U9Ux8xt4IlUOxG66/yj7jR10aiulMouho6TWYzJQfvN7m1U9XyI6EqWJiMLV/RZlBxhyGkpjM/DOSMFQnnDzK7iUzbaTNyjKX2So4qc8Q1q8mI7Te08FYmR6bwSj686I7FUBgWOT52FDM54HRG01MAaWsFRc3PuK/xIx13BejEzITZ1bz8/YlxSFC+rmJfSB5LmV5U0UXRg9uvNpfSureisbb+s8GMh084RPJJOo1fsJD944wNb4F9ZLr4eecbFGQWa0SHluhlpkwdWfvUtJIuW42THoKHXqkZ82WeVxSZYwVRpkrq3xeKq5/yVzIF9tzT8q8e4/KzYPorgbof+DT4bmUZLeuhcfWRCqsjiAVFtLNdmdUgqJrLMuSGoqR7S0YXsUKD1hjB51qOIhd1H6BLFTfKoKHs0Zl4Gh3BW8Zaxxusn4UZVLtN1YuF4dINauzaIwNg7EaxvZ8Qx3ZaEfORUQLplDjifzpeXpq0bSRTn1cjkyMveiJ2Y+wsQj4LRzGeL1xZJLOSs+63oYa/2GA1qiDigDzxv59QPO2U70MIcDf+uJWGHD8guS5VCxqxD4hpaTi0ryUgstdVZvw+T5MfeKC+f7Zrn5cHVwCzOjGoCneqHpK2cARBy6L5R1mtGBm15JGiwc+QKADsnVnJ6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UIgopBCfn0bT7+aJgRjsoSFryEH96aDB+SszT5+wQNK50oNoTuU766dEKV2tpZ0Q7uBfHBN9biozC7RPhp98MuOjaEABeVtwzHkJwcoyEghJSYw5uZL1Mjaiaw1AqkUZLKnfuxAifBBOUA50gP3quwlpoTwuVVkB68w2/zxJ9kK4yqwgHUWOaBIRLC1tI4svq3UjSk5viAY5MIs46BFvTuZeBdlQAhWMpBrqW7qVraCZZwpXWPQ7z4yW983uwcAw4PSJrZvi2uq5P/GyLaydXaywOxyZ7EFFrf6cLNBd8NiO3NGXDWZLfWewD4BqP31oZzKNhI5h2K4CClPl1TxxnTcFf0ieTIr28Ct4eXvJwuIJD24Pgram3vLIVGeWCCxKYQ5g0lVA5IGgxKjETxlTsFS/zjs9tqdyAM9IKOMa1XV5lfee6lO2FowJe9BCZh3z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 08:36:35.1771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f69f3bd-fb9a-4d91-b7f5-08dea4381778
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947
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

Pass is_user_mode_submission and unmap_flag_addr from
mes_add_queue_input through to MESAPI__ADD_QUEUE in both mes_v12_0
add_hw_queue paths, and route MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE
to the matching MESAPI_MISC opcode.

The kernel-side caller that actually sets is_user_mode_submission for
SDMA UMQs lives in a later patch; this one is just the engine-level
plumbing.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 023c7345ea54..5acc505533f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -342,6 +342,8 @@ static int mes_v12_0_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.trap_en = input->trap_en;
 	mes_add_queue_pkt.skip_process_ctx_clear = input->skip_process_ctx_clear;
 	mes_add_queue_pkt.is_kfd_process = input->is_kfd_process;
+	mes_add_queue_pkt.is_user_mode_submission = input->is_user_mode_submission;
+	mes_add_queue_pkt.unmap_flag_addr = input->unmap_flag_addr;
 
 	/* For KFD, gds_size is re-used for queue size (needed in MES for AQL queues) */
 	mes_add_queue_pkt.is_aql_queue = input->is_aql_queue;
@@ -697,6 +699,10 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.change_config.option.bits.limit_single_process =
 				input->change_config.option.limit_single_process;
 		break;
+	case MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE:
+		misc_pkt.opcode = MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE;
+		misc_pkt.queue_sch_level = input->notify_work.priority_level;
+		break;
 
 	default:
 		DRM_ERROR("unsupported misc op (%d)\n", input->op);
-- 
2.49.0

