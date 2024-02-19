Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B867C48BC3
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Feb 2024 08:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F11C10E030;
	Mon, 19 Feb 2024 08:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WLl9Zmbv";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA64610E030
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Feb 2024 08:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HG5LTr07l9AsHkd6VFKgEul8wnvaPECpv917F6NGlwD2Jn9GRnfOz+a4GAAY3q7W0DPb+n9wTCph61fi2oXnyzRcJY2j8jOC8w6yJYApyIhJisDckkA5UcnAcIOW5fwK+L6wN3aPzxH6BXeM76btcYDbMCsA6cXtaoAFxbA7GbVl3tVl2KvWk2X1MeM5HzJ03VtFq9hOfFc2Rp1EUELHjMGvw4cV7rsuVboXwZyq52vkNXqMcbroacoFK7GBwyRc4yX14CHrPtLWSAi4CcUKhTGJqqZkXKrZ6lALe/os34EeAI/N9uIji24ELK8MBO9TkS+sCsn88REJ306UGQRFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1G0jWfFjuUECH1uQwHPa4TM/GYSNrOg/T9r5NIkG8wM=;
 b=OTjCoeThMlnpWtIq/m3jTAwZwJzb5hq8Y/qjOhprUl/DHFcKnA2iG9dv1ZyW75M6RY/icTUay2ORTZcqkmoWYo9Ni+HPhTkRJUamICOUpE68ghKZXeHR++98hWqOHi6I5Jk2j72NdtBf7Bif9oALegubdjiIoAE1NzvpMHVl5peExBss6om/FwWU3w1fYmKPqro/Cu2GUj+QHgzkwNuO8rjwtpRKBs4PHbreWMfq5qDMeA3Y4Gj/UEhyOEy67/o0nAyB1cwlke1iukD+TBACGIw3nsNkhaLM0ShBj61dMrdMHYi6L75W8LWnXfY19ijegQD+ptmSZtyU4ZNFozrGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1G0jWfFjuUECH1uQwHPa4TM/GYSNrOg/T9r5NIkG8wM=;
 b=WLl9ZmbvQSqtNaViWYx37iQ/PppkTn5z2Ks8sXnI4ygp50wHPQVdKgceok5+HtXc2n/z/ET2HcMei7UXX2xi0+8gsIydXzVq6af0Ur69LEgR4RDgm5GBDJI74p5fmi25z2TXgv97S1WUYHDKuQdrljZKm5SW8p4LbTuReOYMYow=
Received: from CYZPR14CA0006.namprd14.prod.outlook.com (2603:10b6:930:8f::21)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 08:15:32 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::21) by CYZPR14CA0006.outlook.office365.com
 (2603:10b6:930:8f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38 via Frontend
 Transport; Mon, 19 Feb 2024 08:15:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 19 Feb 2024 08:15:31 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 02:15:30 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: add new bit definitions for GC 9.0
 PROTECTION_FAULT_STATUS
Date: Mon, 19 Feb 2024 16:15:16 +0800
Message-ID: <20240219081520.316064-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: a626f39d-54b2-4016-e535-08dc3122f0c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+4vzVJpCkpYGW92CqZcwCURk3WSP1KXCvaQYAKCONSiSD55fWA9F/l87AMuiqVuSwkUwavknEhLkwnHqCNVJW/UC/4/ube/wQ2UwuokrH6A1gipsaDPaf9LXFu4HoO9u12+vgPcBVLN/oE/2rcNcYjOZ3Dz2ZjAAu4kBNEjjSgVYt/TF6GHpkYW86JKWk7i8bBd25fKF6a1L8CXj9XOiulBzfHouAY0iXbm1VpOUGqaXoggU26KH2jZDs2lPEX53wP5wJey1Ow8gxfnIzEzOkUQ/cKvoiDKhEWpKieXXSS/GgU+RUOCXcV5R7GmmHufETVzXfuckkEbVGwCcdY2TTBx2BUl7VPVfVts8fqSqaLjQB3HxojRnBN/Sa8JBv7Cdxwh78AGTWG/O1bnaRHngNPXil04Z3VEZjR8RFQ8v5yRFlmHJIolTBqmg1mw5GJ+vLlrXYZ5/KQW7tMrhXuJismcz0SeHqsojgnmGM92BEtcba3y77NfpwA8BUoBiU9ubezMyMIa3xaAI5+52SeW7Qt75YM+VGZOFLLPfydLaMNEyxdyRhyT5S3DJgnCoZRvxWk9V3Llv9/bVMFxYf7qiypAzW+yYIeLNErfxehxbb7acWClqb3G02GuNmYqkB8Zn0BI5pgLD+R9ITK+PaSLPAnXnUTWDAdxi3EiZH/aJ3M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(36860700004)(1800799012)(186009)(82310400011)(451199024)(40470700004)(46966006)(41300700001)(6916009)(82740400003)(4326008)(2906002)(8676002)(8936002)(70206006)(70586007)(5660300002)(86362001)(356005)(6666004)(36756003)(316002)(7696005)(478600001)(336012)(1076003)(26005)(426003)(2616005)(16526019)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 08:15:31.6627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a626f39d-54b2-4016-e535-08dc3122f0c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155
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

Add UCE and FED bit definitions.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
index efc16ddf274a..2dfa0e5b1aa3 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
@@ -6822,6 +6822,8 @@
 #define VM_L2_PROTECTION_FAULT_STATUS__VMID__SHIFT                                                            0x14
 #define VM_L2_PROTECTION_FAULT_STATUS__VF__SHIFT                                                              0x18
 #define VM_L2_PROTECTION_FAULT_STATUS__VFID__SHIFT                                                            0x19
+#define VM_L2_PROTECTION_FAULT_STATUS__UCE__SHIFT                                                             0x1d
+#define VM_L2_PROTECTION_FAULT_STATUS__FED__SHIFT                                                             0x1e
 #define VM_L2_PROTECTION_FAULT_STATUS__MORE_FAULTS_MASK                                                       0x00000001L
 #define VM_L2_PROTECTION_FAULT_STATUS__WALKER_ERROR_MASK                                                      0x0000000EL
 #define VM_L2_PROTECTION_FAULT_STATUS__PERMISSION_FAULTS_MASK                                                 0x000000F0L
@@ -6832,6 +6834,8 @@
 #define VM_L2_PROTECTION_FAULT_STATUS__VMID_MASK                                                              0x00F00000L
 #define VM_L2_PROTECTION_FAULT_STATUS__VF_MASK                                                                0x01000000L
 #define VM_L2_PROTECTION_FAULT_STATUS__VFID_MASK                                                              0x1E000000L
+#define VM_L2_PROTECTION_FAULT_STATUS__UCE_MASK                                                               0x20000000L
+#define VM_L2_PROTECTION_FAULT_STATUS__FED_MASK                                                               0x40000000L
 //VM_L2_PROTECTION_FAULT_ADDR_LO32
 #define VM_L2_PROTECTION_FAULT_ADDR_LO32__LOGICAL_PAGE_ADDR_LO32__SHIFT                                       0x0
 #define VM_L2_PROTECTION_FAULT_ADDR_LO32__LOGICAL_PAGE_ADDR_LO32_MASK                                         0xFFFFFFFFL
-- 
2.34.1

