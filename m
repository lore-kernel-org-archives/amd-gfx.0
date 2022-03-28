Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A44C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 06:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C734810E5E9;
	Mon, 28 Mar 2022 06:25:26 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2054.outbound.protection.outlook.com [40.107.100.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B62B710E5E9
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 06:25:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZ9i2qxLJx2x2XrJBhiE+V/yx6slBgc7/Zlb6GcuJfoMklbmUn26TAujRdapzgj+VBbcHkE5E8VSbe0D8DDVNUezVKGDncGuMKt+fH+X3vSp3ezgtAVIIBPbFTiaaxCpCPHqm15qvoHr/k4H5VdQXolfViIKbfQX3u4ZDYNcfYQZ3GLZG1K2TdZMldx/AINAD/ttYopI0bYXR+VQMOb4NSaZhK8Z0oUvBrLVFCina2IIjy+mDJsn0JERt2bA4KSW0okskB+viFG6VdG35zIdJ0KfgW5dCr2YT8Aq9RY54y09ibSHbJGC6ytOutl9dd04xlWT3sv8fi6a0UKNQ48NBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQ+Mj3VFy2KCLwVrTOMBPNtKJnLqURLxxoHZoFKjjS8=;
 b=ef8JZH2frZm/eYds0ZDvCxtWAD+TTF6L95FPY3jOgdvnXDl5WBk2KdnlW0rgaurw2udONYMRTiOnoUmTbg5Ya2yCRaOXndQMJy779Tc6lmvzUcGBYqq+0y8AciKCwiwgM6UO0tfWmg6EhngJMFmGK1UmfAVXtkyAxOk1QYKnE6DKfwtmVcMjha/9ic02HZg3zRXXOmYz8uL2t76Kg0m06Hx10sYJHCIWWvbTajSGKpKcguN5stc+f+zWZ+R+Yz0pZkNwTOeGwdbjgWvDXlI0pNnRfqBwXDhxdPMtYrysFHbXGWpoxhPzgq9OR4QsbGNtu9Qc9kyBQ2HZf4grjt8/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQ+Mj3VFy2KCLwVrTOMBPNtKJnLqURLxxoHZoFKjjS8=;
 b=uQyCdUF62El1vyPPo7ZBpWZyT8vngXv1naengaT/Tf9LSi89d30UoQoRbgSYt+pGhrcqGuF27tl4AL6PTDuGUphBXD3a6GMp9KFRsllxSLJuWmISaqeT2+w6uCGim/8nQSSE+ZoGhyc54ZrAse1PBppw0rGQ26mw3ULt2+hFd7w=
Received: from DM5PR21CA0046.namprd21.prod.outlook.com (2603:10b6:3:ed::32) by
 CY4PR12MB1175.namprd12.prod.outlook.com (2603:10b6:903:3d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.21; Mon, 28 Mar 2022 06:25:20 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::cd) by DM5PR21CA0046.outlook.office365.com
 (2603:10b6:3:ed::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16 via Frontend
 Transport; Mon, 28 Mar 2022 06:25:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 06:25:19 +0000
Received: from zafar-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 01:25:17 -0500
From: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 4/6] drm/amdgpu/vcn: vcn and jpeg ver 2.6 ras register
 definition
Date: Mon, 28 Mar 2022 14:24:51 +0800
Message-ID: <20220328062453.4156191-5-Mohammadzafar.ziya@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
References: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 719e23db-3719-499f-b8da-08da1083bb91
X-MS-TrafficTypeDiagnostic: CY4PR12MB1175:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1175D766BCFEDCC8892DAC1D981D9@CY4PR12MB1175.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXRD4lFy7RW4UaJhbVOrhXm33RgyirojQ4/pq+gUpxShs2TYVMR955t8P438EPGapphhenVYCINHrRa+6sm5UifdsfnvbVv82vx57L31KikdiZYmf5DqbV8gHjxDU04ldd+ked7FgP1jt8tyqKkzK7NMkQMmHuqX8q7GJB8rePoHFsLDI3ElERNVAtyIUILsTLLXAMthD1hRjk0FsvENsnkkvBrxa5H3Va8vITXTfu7feJR/XD7wkEuxAmeSjzV5iRM1QFyxANIfyPWXLZqsRkj1fZSU4R6udn24Z1iclLwZjaDn97fK4MhP9T3+vW2QNQW7PgbHqnqFKoIsWCrTTekbzduwKFS3h9WqQ3BhCUw+Is23LQxj0d5qQ7ZLCpwn7N5nol+ocw6DXbL4G6CPsJLjI8Kd7Kb6IC78EUxviPgTCFRzLbh3teFgmGdpXx0E5gg0F/YzhWG/WeXMBe3jDuFDAkednQLXHTv2wbE/MAIF1LccfdzQ0hJyLdTSLce5qj0qlWDS6fkWaOjfF+cn8KQx2hax8Xp7Tf/uxdaeB6VleZvKPZloWm2KaHW6rh9Iz0MKOmuBw4f9/Ogf6a81z+8rl+ed0zSD6s3tHDjrm72zEeO/3k9zBRvtfUNEtqtX/zJYcEB/MbNsRHQJ1hB/DqFDLFpmPRJHXT9pZH74CyhawzdhDnWZd1UDesfhT/SDoZ+6g+EiZyGWpSuVn1yACA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(356005)(81166007)(336012)(86362001)(7696005)(70206006)(70586007)(8676002)(426003)(40460700003)(4326008)(2906002)(316002)(6666004)(36860700001)(2616005)(8936002)(6916009)(54906003)(26005)(82310400004)(5660300002)(1076003)(186003)(47076005)(16526019)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:25:19.9058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 719e23db-3719-499f-b8da-08da1083bb91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1175
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
Cc: Tao.Zhou1@amd.com, lijo.lazar@amd.com,
 Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adding vcn and jpeg ver 2.6 ras register definition

Signed-off-by: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../amd/include/asic_reg/vcn/vcn_2_5_offset.h | 13 ++++++++++
 .../include/asic_reg/vcn/vcn_2_5_sh_mask.h    | 24 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_5_offset.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_5_offset.h
index 90350f46a0c4..363d2139cea2 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_5_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_5_offset.h
@@ -988,4 +988,17 @@
 #define mmMDM_WIG_PIPE_BUSY_BASE_IDX                                                                   1
 
 
+/* VCN 2_6_0 regs */
+#define mmUVD_RAS_VCPU_VCODEC_STATUS                           0x0057
+#define mmUVD_RAS_VCPU_VCODEC_STATUS_BASE_IDX                  1
+#define mmUVD_RAS_MMSCH_FATAL_ERROR                            0x0058
+#define mmUVD_RAS_MMSCH_FATAL_ERROR_BASE_IDX                   1
+
+
+/* JPEG 2_6_0 regs */
+#define mmUVD_RAS_JPEG0_STATUS                                 0x0059
+#define mmUVD_RAS_JPEG0_STATUS_BASE_IDX                        1
+#define mmUVD_RAS_JPEG1_STATUS                                 0x005a
+#define mmUVD_RAS_JPEG1_STATUS_BASE_IDX                        1
+
 #endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_5_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_5_sh_mask.h
index c41c59c30006..8de883b76d90 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_5_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_5_sh_mask.h
@@ -3606,4 +3606,28 @@
 #define UVD_LMI_CRC3__CRC32_MASK                                                                              0xFFFFFFFFL
 
 
+/* VCN 2_6_0 UVD_RAS_VCPU_VCODEC_STATUS */
+#define UVD_RAS_VCPU_VCODEC_STATUS__POISONED_VF__SHIFT          0x0
+#define UVD_RAS_VCPU_VCODEC_STATUS__POISONED_PF__SHIFT          0x1f
+#define UVD_RAS_VCPU_VCODEC_STATUS__POISONED_VF_MASK            0x7FFFFFFFL
+#define UVD_RAS_VCPU_VCODEC_STATUS__POISONED_PF_MASK            0x80000000L
+
+/* VCN 2_6_0 UVD_RAS_MMSCH_FATAL_ERROR */
+#define UVD_RAS_MMSCH_FATAL_ERROR__POISONED_VF__SHIFT           0x0
+#define UVD_RAS_MMSCH_FATAL_ERROR__POISONED_PF__SHIFT           0x1f
+#define UVD_RAS_MMSCH_FATAL_ERROR__POISONED_VF_MASK             0x7FFFFFFFL
+#define UVD_RAS_MMSCH_FATAL_ERROR__POISONED_PF_MASK             0x80000000L
+
+/* JPEG 2_6_0 UVD_RAS_JPEG0_STATUS */
+#define UVD_RAS_JPEG0_STATUS__POISONED_VF__SHIFT                0x0
+#define UVD_RAS_JPEG0_STATUS__POISONED_PF__SHIFT                0x1f
+#define UVD_RAS_JPEG0_STATUS__POISONED_VF_MASK                  0x7FFFFFFFL
+#define UVD_RAS_JPEG0_STATUS__POISONED_PF_MASK                  0x80000000L
+
+/* JPEG 2_6_0 UVD_RAS_JPEG1_STATUS */
+#define UVD_RAS_JPEG1_STATUS__POISONED_VF__SHIFT                0x0
+#define UVD_RAS_JPEG1_STATUS__POISONED_PF__SHIFT                0x1f
+#define UVD_RAS_JPEG1_STATUS__POISONED_VF_MASK                  0x7FFFFFFFL
+#define UVD_RAS_JPEG1_STATUS__POISONED_PF_MASK                  0x80000000L
+
 #endif
-- 
2.25.1

