Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AB3CDB475
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 03:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75D4A10E2A2;
	Wed, 24 Jun 2026 03:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kpkEi3IR";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E36310E2A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 03:41:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKBvaFXQqhluQbic91GHAaQfbjFD2JicctFa/Ig4zR/tZzxCNFXoAofyCXqWfNrwWoMhIDyWD9P7+YiO4wvEq4chGHokLy+7p4TfHTJSLNQS6/WCR0+sPGPStRXYAadeUJ80imhv7zNffd0ret2Yt5+nboIsMPFzaHSp7lQ8owzcbT2n4rX2VdXU59cf6kf1GH88o/Y5O0rOPKgCu0k1Tr3jJCmFg5qAkDdpAw0ZQoF05qdX682rBwqID6+XoGlRcyR6FQ+1uIMXL4egqroEv+sZqsYGGpBIbPNnkKlAEXBJ23Ti8Zm9T3KkR7gjR8kqb1lESlHSbDe2r+9k/vNsEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mP1x+gFfqgL7iwn2rat4lYZvtEkhRuBXeznp3poAMF0=;
 b=XuZGHHt6KoSru77BoEER5dVY8DBm2sdUVbUdcuFt1C0mH5YG0sN39CXysS5BtQTflhTPeqaWoO3yeUvidUUhEDAk2whqdX74/HBm+4cTHGd1/mO426bFXnh76Xc99h2l8ofV3ZouXQ8srTK1eIEg7uCl4rBSyUkn3Um4mh+ngI+xVUdgsOCT4CZUaFmsMLnDxfmioaQ/bha+RF50+UhqkMC772zXck0DAIKw81/5gtSdQVIbrmRdrfqcxUxmohroAAddVROawkh/jZBvKBNyawvFs8IGJVcSUJOXwRlgJtqQILbuWE/4clyVzS5ev2c+RvGprI8dPFRlrD/gcciydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP1x+gFfqgL7iwn2rat4lYZvtEkhRuBXeznp3poAMF0=;
 b=kpkEi3IRljDdo6a6t8euVn3sSyQC4b2gdzomAFJOa8quu0qs+LXd8tYixix/iot6X8HBXSaHRkZTxcR1KZMp/QWgNb8495hW2l2KOKN/q+Bzq/gYnzOFioFgc37BqmLQsSQdUJggmzsJSnWkOIm7iYvXBdqLR904i+ZRcmJio8s=
Received: from DS1PR02CA0003.namprd02.prod.outlook.com (2603:10b6:8:452::10)
 by SJ2PR12MB8808.namprd12.prod.outlook.com (2603:10b6:a03:4d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 03:40:57 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:8:452:cafe::62) by DS1PR02CA0003.outlook.office365.com
 (2603:10b6:8:452::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 03:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 03:40:57 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 22:40:56 -0500
From: Amber Lin <amber.lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Jesse.zhang@amd.com>
CC: Amber Lin <amber.lin@amd.com>, Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH 1/2] Revert "drm/amdkfd: Add queue reset support to gfx12.0"
Date: Tue, 23 Jun 2026 23:40:40 -0400
Message-ID: <20260624034041.78450-1-amber.lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SJ2PR12MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 36bfb0cb-ec44-466b-6de1-08ded1a266b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: OVt0w+R2JJuekDR//OXqXLk3emZS10IB7Ngl5Y5PTlJQiibt8lSnhmdb0kArnedML9QewBe3De7jiAYpZ7zkiRHlNQOKM3B0XpyhmHEyEzyehjL40RJ4T3VLDsmUbEvnplEYmHPDx5B7CBeskmrpcPevzlOBBE+icGXQFPhISOBm0adrONpwdFGeCdHBpuIFLN6y5rK2Ct7fCkJceNcVpLQS7GoI2Q2U7f+X2pNOqlEjRt/55WajxjwgF2dSuKXCx2sdpTWEuHE2t+rA8GjKBduKOKVgvrKrFnVIMCGWrbsrDzlfuerdvKJIuMaaVw5LSvaPV91/I0kx9ENFVPbaXP28DJ2BfcUs7cgLL7fAkh7nL0ku+y6lA42QsL5/m4HAgnx2imcIAEEzocMfCkbEk3ohLz+5wYDulFuQPQAajs0hdz7Frf4Dhu7tH+ZNCRh3IISBHmmJEJuwoy4llk7g7vlSTuxDgwA4SU6sj2BY7ieYpoNkvvHJb+dzjWFw8hHoFDvRH8gyhPYQRvauj4SCECbksDCymcdgbz4bMeL+iJ47WM91jVhtmaM6f7Ypad7UcgY/zTM+zduqIl1BCL6PE8oG01J983cciNkZfTPFYamBeYcLA87DVOHaGEEV4C7MiZ61BYhW8pPjZSMZUgVjPES3OL8MNWWWgVix4IWeK9JWZYaUqQB7Avjq56Kawcfb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(11063799006)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZsXylAIwK7tkJu62jtH5RPk5biJ7QUrX1YTbk5YBLFHyaWaCUorjOC7ThBOQluEchc4nreej691a5bMmKbaYs6yzTG1BXK3g2hGXOSM3SC0Yqt0ml5Biza8kodZ7felR5q9B6WEGPkft+6zu20tN1t1cc7nT2/p7b+BE881HTWkWPCVSvjxEYJJY2FZrn6TcYhdFUbGLO9/+nGQm9lNtO00y5R19ujHGRhvAq7Tg33o9cd1xxOEaHbwZWq+hJnow1VXffAjHeZeuTReGjtSktDprmIj4x19uEpYbSzi/L60iKliSIKBWaV2Acx9OpX2XDpl09lCGsecz7vxopjfCXso3MjOCFBeh90qTMjPbaNh4qeAlv/x7e5+ayInTIwh71qBuUTb+5EkL7127Gg0WhddGV8eYYvKR9gGsv+ovZDlZVkU76ef4lSemhwhRzqc9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 03:40:57.0665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bfb0cb-ec44-466b-6de1-08ded1a266b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8808
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

This reverts commit ecab22cd95dbde28c17e9eb34416f4c840bd50da.
This patch didn't exclude SRIOV

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index f56b55ef1edd..1bf67b6e9aac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2027,15 +2027,14 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 		     !amdgpu_sriov_vf(dev->gpu->adev))
 			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 
-		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 0, 0)) {
+		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 0, 0))
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED;
-			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
-		}
 
 		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 1, 0)) {
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
+			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 			dev->node_props.capability2 |=
 				HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED;
 		}
-- 
2.43.0

