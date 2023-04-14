Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7B6C77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B7810EDE8;
	Fri, 14 Apr 2023 15:54:55 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D683210EDEF
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6B9JyMVefVfCwCof/F/FoZKAgHHO+XkTTy9bYZw6oS+NqTOE1nCwseWuuvLDGL6hoRDSPTUm/1di/Mm3Hug494l/Wpw3CKVzJH+OixxYkQHwUL3boy2UBtSE26Fq8heWLoVmBr96rscXYP0cLLs3dgWESu/kEI+cpTD694UxNnvnRCWVX4zmziugbdzNh4N0Q6bKFA1kuS8N63pqiR4XUGho6bcCRMocjtWYEKxxHrvJr83lMJuCuv2d8Mk8d0+rf/Egjct/SRHONwd3KaAQiMtCHpSJ+jLOZPbHBAe36BOqj/9o0qvN4LfIHqatGCOx3AuRyk7/X1ZWe4Gortzmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njHu+nZAdzXt2oMqfWQXflinwAfJYc7UGRixPV9xXro=;
 b=ZlqTZr2hDTaX/4Lvx88pZem11hIea6DEh3WtvvxtGSBC37GlxVxsFXCXJ82ALZjjWb4KLje3cmOQmnE3AuTQzjT0kkpdHfmxe7Q5Rr3n7E36CRChcNYbgb7SyZnPwhB9RPSpJRe7XZtLuC+cF+MNlLxeDzVKE+GcH8s9Xj7eOuMm792bn6WMpGKGMySXOTDpRO9VNh6R+dBA7kzOIadR857LJ+1BlojQRtr0R/sqSnQLob39h/uL65asQ11ITiMMS0e6KxZYDomPGvYzk5Q3f06gngVRd5DZo7cGlZJpDPWguIMi3HxNQtAuoysqWiVcj2S23WXpP6rUcusrAyyUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njHu+nZAdzXt2oMqfWQXflinwAfJYc7UGRixPV9xXro=;
 b=OvouPDsfjwleA4PeHbBvI92gwIsS8I5N0Pu+yJdliMzXC7DfB/7W2x3Znpg/aJrc8FMtP7l9E9Zo5zy33iRFH8u7usZtr8R5d3n8nvw3s3wfIFxawZ4yYKpYh7w7wP3kmM6pDXP093jUyfIgpGuKOx2RrACqmrpJUx9jwj45aYM=
Received: from BN9PR03CA0781.namprd03.prod.outlook.com (2603:10b6:408:13f::6)
 by CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:49 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::62) by BN9PR03CA0781.outlook.office365.com
 (2603:10b6:408:13f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 15:54:49 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:47 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 41/66] drm/amd/display: Disable migration to ensure
 consistency of per-CPU variable
Date: Fri, 14 Apr 2023 11:53:05 -0400
Message-ID: <20230414155330.5215-42-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|CO6PR12MB5394:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d118aa-5e52-456e-d355-08db3d009400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2bf25Kh6tm3+Kw4cCn9RGtY5n5W3ttjIekxi4n/TtPYFigj3+5mToWkXecUKcSG8C9yCzVM9gxxvcMiyK6CoQZtSuvpnvLJpWah2VbVe0SW1ZZmsBZTtvRodpJbTAZrx8dGphr/Sw1ispgQZLxTyo9FgM4o1szVgrCNyM2jHuBT8WZOnLF0EsDzo764TGV8zf44wtHTroPNLVBq7/v+wPJDzT+pDo1/cfUCG/6DMbJRKSHZ0Holr0BqB+R0pue0uR/wZsx0Hjwi7IueBCbSKJAtCNro9PMeoASaq7x9cGjS1UIdaSFVJ5xNqdSPWyDGl3hq6KEOpOQWNwE+ZNGMAx/l4WciTCMPH5pStXR8KcVHFbZBcE0n4bbDrYjlPS5oFq3V3BK0ya5ERih36ePo6FhKNHKP7o77uFXui4N1AoYER3h+KhLvmsn8qQVcO2dhIoFmK8cypPezEAtzeBXw2VRZ+eC3VGUva5DtuIr2kDHVj0XQ6tZ+kgWaudfXM1d+ZIX9PCdBFHDBdn75HDWG52Ljz12iVu7WXFRMZmwPhEr1+qIDalq9QPx0bwBZe/C1kacBvMtWDeiCu68+bwf5PLe226gCLQMMnF9rzW9bLdcmhrS8xHO2nrg/LdAEzbvHSCgmeoVRw2ls44hQpqpAr5zh1j1kIcjwTQY7wuQs5fzUzffhUVi0lobIZuhR+r0xiYefGypO3mCJ5OdcmWBZtFUAANX1fRY+iXRbaXdrxWzg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(336012)(426003)(2616005)(47076005)(2906002)(40460700003)(82310400005)(36756003)(40480700001)(82740400003)(86362001)(356005)(81166007)(36860700001)(41300700001)(6916009)(6666004)(70586007)(316002)(70206006)(4326008)(8676002)(8936002)(5660300002)(54906003)(478600001)(26005)(1076003)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:49.5121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d118aa-5e52-456e-d355-08db3d009400
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5394
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Tianci Yin <tianci.yin@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tianci Yin <tianci.yin@amd.com>

[why]
Since the variable fpu_recursion_depth is per-CPU type, it has one copy
on each CPU, thread migration causes data consistency issue, then the
call trace shows up. And preemption disabling can't prevent migration.

[how]
Disable migration to ensure consistency of fpu_recursion_depth.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Tianci Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
index 1743ca0a3641..c42aa947c969 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -89,6 +89,7 @@ void dc_fpu_begin(const char *function_name, const int line)
 
 	if (*pcpu == 1) {
 #if defined(CONFIG_X86)
+		migrate_disable();
 		kernel_fpu_begin();
 #elif defined(CONFIG_PPC64)
 		if (cpu_has_feature(CPU_FTR_VSX_COMP)) {
@@ -129,6 +130,7 @@ void dc_fpu_end(const char *function_name, const int line)
 	if (*pcpu <= 0) {
 #if defined(CONFIG_X86)
 		kernel_fpu_end();
+		migrate_enable();
 #elif defined(CONFIG_PPC64)
 		if (cpu_has_feature(CPU_FTR_VSX_COMP)) {
 			disable_kernel_vsx();
-- 
2.34.1

