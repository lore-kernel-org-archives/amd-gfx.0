Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C781ECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:31:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92DF410F307;
	Mon, 29 Aug 2022 14:31:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4A7410F2FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9fqukvBxP3ipCBW2bxPSrDLbmiPQRDgG0EowDjLO8yPEVnwyjdfc2f08hMhjILX3ph/hiAQKRuAzR1z4qfXQyGiLmHSPq3Ga7lYQE6D7AB0vYkrL2nuVKG7E5JtGxxGx2PE6Nhk+ZnmikON1/MOVV2DS3/DBwnPJ2CCrOfWakJFiSA/xrtshKJEJa9Ro2ZXo+7S7h19OXN+C4ZO3ZvKOXMrJeJCv1UXkLOeFIdc/6zwju84M2gosoKdaVSwobLruolHsy2kbqJcMrb+TMsu/aon+Iz2Jw6h5sm9bFI1yCHJElt9WaNa/dgCv65/eR3knni0+Jl5kvWbPVEMFNqIvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNArw5aI9bgkDcL9AOfYnRf1tRmB6IgO+bIhy3y/jiY=;
 b=Bo070kdXA+6rG1+lS9Nofg3zeGa16SaBkiBbXb8lHNFR+11T9Y8HHOIrUn3vmNnd024OBIJblHqZe03vq8/WtgN83Lw4kwv8aIa9MSARBUtVZRMcoRm+WPjzS9RYWvTxvxne98bbF1kom0kTsn6CQYH+/KfmZ7TinfbJWL7ZUdKV5Hiv6UYhL24R0s6/UdViu5sFZBH1RPSuOW98xwXQpj1hRODLKje70YBgogx5vBo5LPwjw7c8oFFOAiylYGpk8tdyEgORifhH7aPQ3F7lJqHKPX54dd/wuHZKBxJtiGE9/+LyF942NhbbNexMJnwQdhPxZqA82nxR4qyuiNNXpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNArw5aI9bgkDcL9AOfYnRf1tRmB6IgO+bIhy3y/jiY=;
 b=dNkgrABGAy6szy4IDOk4RDJTcAmNR0nJt6/vpGUlWkl38t7BlV1Udt0Ar/WyxrwhTRQ+c8HNTIFdJlb87ukT7YpfmOcM1ORbgirY9DEtza2814s7EYgyPppyJzJVCPA3umbj7pC478K+gtOkkKx5z6VVwKuiDBpmCHV0DsgfQTI=
Received: from MW4PR04CA0115.namprd04.prod.outlook.com (2603:10b6:303:83::30)
 by BL0PR12MB5556.namprd12.prod.outlook.com (2603:10b6:208:1cf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 14:31:09 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::b5) by MW4PR04CA0115.outlook.office365.com
 (2603:10b6:303:83::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:08 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:44 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/29] drm/amdgpu: add gfx9.4.2 hw debug mode enable and
 disable calls
Date: Mon, 29 Aug 2022 10:30:06 -0400
Message-ID: <20220829143026.1509027-10-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829143026.1509027-1-jonathan.kim@amd.com>
References: <20220829143026.1509027-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5892eb3-dc22-4c88-5c10-08da89cb1d4d
X-MS-TrafficTypeDiagnostic: BL0PR12MB5556:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0v+8irROHjUZfl5xqHSOqi4m3FIgTleBRX78GoHlnLFuKAWrsHWj5hUDDORAdadznF5Yp+X097G/9iCH+7n9gv0shuRXj/BGrAHM3zD4ET1FlwKHU0CarXwovDGwT9WwT8vS4PvZ+vNKVN9S1ZHlUkLoSwrH1S2eSc+8L4W9NNTkvo8NQPEcKLW2A3sxpkHseLK6fQJHDJoSOmtlx2o0tKHQvOnWu6h4TNeU1xsxcwFwGOr+yH9WTIiHkEKJDAa/7QMcNj9P6SBG14dj02F29JV4WQORoYVu689FiEQdk3k47Z5xqhha2Z1HmaRh0G8Rr2kF77S7VG3Y3cQlx3njpcc/t2dJeUMRUb6EdssZPtJ6hXKE5VFddeHxl3Y1eOMLcs/OysVqWQMqemTwnxU1FatfvwE9TbCql1MIQEt40kVxpFvvfjYfnS74gVm6OwRSK4Hw22zhIAtoDOA9OeVECcn8LcGCi1H/l/KF0tC6NkXAIwUSz1cTDqJnweJdSlvPTPLuUnezaF8Di3LsRjfCzQVT6DR20TVGPjXhey35kRdlNmKwqiTIIMd/dfAK1iuTlFFXmPkpdkTvQTiyAEMLZK+TIPTNgBYZN5BCvfCek/FvD8DfNTlcOiOuhOOCPeQ+PMFjyGyxi5AzRIecdgvGLupFAHY4cXo32kPvAUSK/ap1Qy4wkXh0l/bidlWf8c0NthzPBEVTyciAtjVh8dzbFvtBvnz1kwFADOAlTFRKwHIhggbXCTJtdGsxizUkYNeAxXxt01UQU8sUTKF6UbJeWw2S0JnyC/GxW0JFoiiK/9lOW8FmRRpZddQAZSx8pAG+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(36840700001)(46966006)(40470700004)(26005)(316002)(1076003)(81166007)(54906003)(86362001)(4326008)(40460700003)(8676002)(6916009)(70586007)(70206006)(5660300002)(478600001)(356005)(36756003)(8936002)(41300700001)(2616005)(6666004)(82740400003)(44832011)(82310400005)(7696005)(2906002)(426003)(336012)(16526019)(36860700001)(40480700001)(47076005)(83380400001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:08.7603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5892eb3-dc22-4c88-5c10-08da89cb1d4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5556
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
Cc: Felix.Kuehling@amd.com, Lancelot.Six@amd.com, Laurent.Morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFX9.4.2 now supports per-VMID debug mode controls registers
(SPI_GDBG_PER_VMID_CNTL).

Because the KFD lets the HWS handle PASID-VMID mapping, the KFD will
forward all debug mode setting register writes to the HWS scheduler
using a new MAP_PROCESS API, so instead of writing to registers, return
the required register values that the HWS needs to write on debug enable
and disable.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index c8935d718207..42491a31f352 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -23,6 +23,36 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_amdkfd_arcturus.h"
 #include "amdgpu_amdkfd_gfx_v9.h"
+#include "gc/gc_9_4_2_offset.h"
+#include "gc/gc_9_4_2_sh_mask.h"
+
+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
+static uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,
+					    bool restore_dbg_registers,
+					    uint32_t vmid)
+{
+	uint32_t data = 0;
+
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, 0);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, 0);
+
+	return data;
+}
+
+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
+static uint32_t kgd_aldebaran_disable_debug_trap(struct amdgpu_device *adev,
+						bool keep_trap_enabled,
+						uint32_t vmid)
+{
+	uint32_t data = 0;
+
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, keep_trap_enabled);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, 0);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, 0);
+
+	return data;
+}
 
 const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
@@ -41,5 +71,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.get_atc_vmid_pasid_mapping_info =
 				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
-	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
+	.enable_debug_trap = kgd_aldebaran_enable_debug_trap,
+	.disable_debug_trap = kgd_aldebaran_disable_debug_trap,
+	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 };
-- 
2.25.1

