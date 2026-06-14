Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690B8CD8CA8
	for <amd-gfx@archiver.kernel.org>; Sun, 14 Jun 2026 21:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4DA710E11F;
	Sun, 14 Jun 2026 21:15:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RQv10U2R";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E783810E11F
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Jun 2026 21:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9hOG/lfegaG62LdERP+npTcXXdsjVR1GXhivVTHnaJRvdvw6xvDqwJwWUZMpmWr1w2Dz7CDn/M7wZyhpsxeBkyUEF2voaO7LjXihxtg+p56DFV0So4BvpT6U1GgBALVcX2+Wmd5WNJ4BpD+/RfaeiPfoIWo8+olexM/S3EbivS7zGAzO1fTEayqgLxF1XaS486LiCqAiRQ5T3aj3KJRai3137e53V6rPqWHBbiradVnoDD839wUQbdRdpuGGALHOKItj7WtgzW8jDemMGz0+W+/fTGyIhDPYir/NlGQAL/FEYJ0cPgWVkbXg0gDuk5J1csx5mAF8eXjk+RXVBd3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ktjzVLfSUl1eitIfVb0au6aAhRwxLWROLyk6JU2w5o=;
 b=MAkIbrPQ+y0TVmGqvw5PfsNIpqF+Rt6plgj+buUHdVie87sTlfcOR4dybRCL8/q94BPnTzavk04QsepRbQA5eHW6HHfVbXEwRe2ux1YfXASTGLRh48Dm6RYRKfbtkobMu0ixNUpCzyJ+0S52dyP1EgXXce+SvQMeaLrdYppmNI5IOoOuUPdMo7vv2gl2ux0+ePf3sFzzX22aVFD7U02ECUonleyO8Sdd2/bPWp5eFxUBEVVyvXM6EH+wdMqUf3P2jFPuUHkvUtQhnYwxGKpApJmq0nsIR+hQ5wBcectekDT5JM4oWQiH0i43nwm2oSUx5AVrovZ3vzYqXtc7p42BEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ktjzVLfSUl1eitIfVb0au6aAhRwxLWROLyk6JU2w5o=;
 b=RQv10U2RlSGn26IXRQZCc+vLMpMV3LjN2DYG0Z6T+UezxW0jF1IrnZsbdGkFYHBJ8hP3sWBkwnUhKi3LIYDBV47ph/2IxBpv4MUHetGcpGhs3nEknV+0JrJ44BATUwAUgqV4I+kbXD81nyp0OPPt6FC/uTj3u2ME0aGM7WtgVSI=
Received: from SA9PR13CA0110.namprd13.prod.outlook.com (2603:10b6:806:24::25)
 by DS5PPFDF2DDE6CD.namprd12.prod.outlook.com (2603:10b6:f:fc00::665)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 21:15:38 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::15) by SA9PR13CA0110.outlook.office365.com
 (2603:10b6:806:24::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.6 via Frontend Transport; Sun, 14
 Jun 2026 21:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sun, 14 Jun 2026 21:15:37 +0000
Received: from rocm-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 14 Jun
 2026 16:15:36 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <jesse.zhang@amd.com>,
 <shaoyun.liu@amd.com>
CC: Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Add queue reset support to gfx12.0
Date: Sun, 14 Jun 2026 17:15:18 -0400
Message-ID: <20260614211518.2125426-2-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260614211518.2125426-1-Amber.Lin@amd.com>
References: <20260614211518.2125426-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|DS5PPFDF2DDE6CD:EE_
X-MS-Office365-Filtering-Correlation-Id: 1760d22c-fe8d-4be5-8ebf-08deca5a14d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|18002099003|6133799003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 2H0GJchAN/ysW48x0m39osxAAaBm9bPm7XL5galNPNBziDX/nNxoJAUncR/TxHhQNNydYFPTQtk+j6Y67JZdjpJFUCStQdUJzSgAQ6r20SpP5v4rzuOEoUI85qVLSKu6P23PQEl6r2AqQ0k5JyB0JkZfvOIOcn/KIIUKbMwLXk2+gKrG6RlfZJjnAHyG+7BUYK53CjcAOLmZkVw7VI6DNKJwcdL2PAB7oyhR5ybK7T2FqU9Jw+aLZ2+1TSm/HzoXa1Iaq186oHHkonND/h/bL+L51T/ME/bp9PTaYAtoEnyoI52q9d+KP9+0zDtp4F1GADQxAgTp0jvdlBGDVi79G/m5TvCfnEEsTJ8fujUyyMKhEGuthgcke8Y3Lmi8Ay59/FbFcJMqs11eZcjFM+WlL9QoKg1QgzbNWzveOFUJUq/Toz/0qbR7sifv+mpkSCGoJQHiMCVlluiRh9tgsrKKqlNQijLe3EircWpcG//6XosyQP2RjSEWzrKjiUspyW/bkSdmbwOLuNBdlMlRcW5OYvQ4Na0BHMxyZOHHaXayi97+EgY9pi2/YBoRiMhC9nYISoNNvn4IMkLV8u7RWgCDbSU6beSatdqjIfVCJYcxOdRcdXyRywrcTQsTZ6r4MQ+ByQ/qKlOC7ZWt0mO/CXpXjwSIANoLgfZmaW2rPmi+MswBCr1xiXUmn+XksGW+rn2u1rB1os0Q3/6pIejYApRFelTPJ+PDB3OPsUhG+RbO9ys=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(6133799003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z6jiIbt2MvSEnRaBhGA5NW4EtFtvAc0w41DQMWyTsDUjBp6R9I5mkwII7eOOFmbw5dZkGU+39TmF0dwWVcx9b6xNRS4pjZZ2tTt0A6huYK/MiHCweOHlTq86CXX4JSIJQAUrQK6k7KkH1tzWDfJcrIsqiyyZBJjyUfpqQPmqhCoLIl8yu0tM4yXESkDL+I23oNNthXPY3z3r1ZpNXf9CS83FW5a0KvSJINSDxVBouPX27LEGeWePGv29iSpsgGkXm9ah87FTndU4sibDE+mBHBWJKXUMEMeuAOWHXq3oHv+0lVQI6wfwS9QsFkpaeHHZ9GRhS2dzGuyLcbwARm/wpgC6NUzbJw983nk0s4ejkondFDPjKk+2qM0zz5WPOoDKKjC1YfJf0Wle0de5JBM7iWhYCOS/KDUjpdEhixAOfnvFHmte9TPKkyM2O/HIFcot
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 21:15:37.7976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1760d22c-fe8d-4be5-8ebf-08deca5a14d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDF2DDE6CD
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

This adds gfx 12.0 queue reset support to KFD topology.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index a9879cf8539e..7688156d476a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2025,14 +2025,15 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 		    KFD_GC_VERSION(dev->gpu) == IP_VERSION(11, 0, 3))
 			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 
-		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 0, 0))
+		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 0, 0)) {
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED;
+			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
+		}
 
 		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 1, 0)) {
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
-			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 			dev->node_props.capability2 |=
 				HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED;
 		}
-- 
2.34.1

