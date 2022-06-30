Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE70C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91ADB12A671;
	Thu, 30 Jun 2022 19:14:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9743F11A3A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnFCyKdtXftvB8S9aZiIZflUXcvJefhOsQ7lAR69USHkbVPikOAPaHFsfAmjTu+PvKwQAkiqrhCC0ipWZ1Z605SvKD+r57ngxRJElNOtDGgABicVCwlo57u4u6BMD0l2N9aHntmz5cZlHtgmatBC6IHPozDofTzuto8xFlm8WsaHLFGZCTQi10mVeKN1TsSW/gU3iM/5CCWJJZF24J3CwJkUCP3PvHWCuoPV5oHWql6COOYIm/pwvvF4nbA8T15LLHY4Hk5SGSDR1RwUloQCRXB78KRfsqTxp/EJJO6BHktbHOn0ElVJpXA3jK6J6wOZstm4TVALKtFOsFf9pUQwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKKO7df68zWQ4rFruRuAiC8dygyd2/pSoTnd+R9pdbo=;
 b=b7aD1asrSJPn9eIRGCwNhgv+MOf3hIWmhx6PtT80ATlerV09JvdXVgy3Vo7FpomuU2dQF+CeOmKZZLdQJGw+e7DWZSdfBbgJ8amMVDYN9sokxb27Tt331KF69cjO2bFHfnA9CYwwBw+5IG8/mQdCcQqjX/u+dF+mT/SUVSPdfDE7nOgy/cs1iUqLHZSJ0QiBkVSvtWkeoMT3B7F+PxJJHXMSqfC3DXE2b67/cYClDGdBCfmpaqc2nViP/X84TLyTK2DKRh8z2dx1AfRBz9kiApBP+nGSzWQFMZVgmkAYh1SerNAxrKRRpkGxROHhFXhmocESeOyOthh9fa3ilB7PGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKKO7df68zWQ4rFruRuAiC8dygyd2/pSoTnd+R9pdbo=;
 b=cl2ORzFwuySMJNuFjKMYk38Q5j/R4IlUQCckrSbxa13i0IJ4mOwSwgADxxdcpiPpaUqL9yy7mJBzc+iDRhd2VdFSpqaNHwk6Nu+188c3ab1YHfuGT1B+asyiDyKa4ENzDiWI5bmhYzADO4WrIFjgYc1fSPAyqJbRUwKJTZG2v24=
Received: from BN9PR03CA0518.namprd03.prod.outlook.com (2603:10b6:408:131::13)
 by CY4PR1201MB0038.namprd12.prod.outlook.com (2603:10b6:910:19::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 19:14:00 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::b1) by BN9PR03CA0518.outlook.office365.com
 (2603:10b6:408:131::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:13:59 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:13:57 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/40] drm/amd/display: Update gpuvm_max_page_table_levels IP
 param
Date: Thu, 30 Jun 2022 15:12:51 -0400
Message-ID: <20220630191322.909650-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18d15b20-2f69-4805-baa8-08da5accaffd
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0038:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dMWn1k3re24/fZg/Hz2YeeDk44wmDwNyUhQxCcCZjiUx3m5C0ZZ9o+c7a3v0vPO0o9mBcY1buNuzgrbvJRyXPgYv4Y73fxAeK4dDv3lnIgW3bUc2TBIWR0glaHvNJLCOC8zvT4wuKJ3Kxf/xRaP6mt87Lg9q3VihbPo01Po61Szf6oSAJ7S1uZhO9kxkXd86POyPCSy2NRqpfmUyRdAih3GHhsZ3ZBYo4baPp8mB/4fJMycXunIKE62RjtCwQyZOjAye21KXGk6Kpdzhw0ZeGYojJn+LnHKgkMqgsYf7qAO+dEd6p7DCdBwkWxcvgf1QIrjHOwDvV8pGr8QeoBCsUkLPQrYmdfd2GaX/2Ll6GVwqDYbGfphL2JIWGorjx3sYrkGuWxTenVmB6d4veGrFI95PwM/cmMCsgE0N5Sp6W2YEgJj4UFBIusrTUe1V7MnUfyVN/FhdmflOPnT9dieDo3cdm90zQPQ9VUhWWAZEDT7dxJiMOY8n5Uh8mz8a+0MELK2O+L42wHOCG1KM3k4r3WJBfRkAA6Vx6x0/Rj0+wE0DvmcK85XMkn2Z/CJ6bbWFeJxbS8uTJuvN7hFtcVhbds2KamTqb4AZr76mFBNg7ptAAq/dWggyKQdJHyO03bdlNVz6HkAEsw10u7PF+Z4YoJsy3WJ2QZ3OBoR8+gPaU9n+72CnBfV2BF1P31blxggbswgo1HhaKSobVVqEtMyEEseEm4jUZ3ulp59zibjZsI2KbLgeWwUIkYRoAaxGBw1ZovrQXkSXXaaRvxBGIh8hrPlnMKZZRJ2DZUdgm4djJzYqe4fW7zBiKnPoy0T5xEvfOggSw3KEs0rkyksyWUNO4GIQn5R9WfpWusKsvanByU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966006)(36840700001)(40470700004)(83380400001)(36860700001)(1076003)(8936002)(186003)(16526019)(36756003)(82740400003)(40480700001)(4326008)(2616005)(356005)(7696005)(5660300002)(70586007)(8676002)(26005)(81166007)(82310400005)(70206006)(2906002)(40460700003)(6916009)(41300700001)(6666004)(336012)(47076005)(54906003)(426003)(478600001)(15650500001)(316002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:13:59.8190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d15b20-2f69-4805-baa8-08da5accaffd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0038
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

After some experimental tests, we noticed that we need to set
gpuvm_max_page_table_levels to '4' to meet the hardware requirements.

Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 63227c55a2f0..1f2af676191b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -121,7 +121,7 @@ static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C
 
 struct _vcs_dpi_ip_params_st dcn3_2_ip = {
 	.gpuvm_enable = 1,
-	.gpuvm_max_page_table_levels = 1,
+	.gpuvm_max_page_table_levels = 4,
 	.hostvm_enable = 0,
 	.rob_buffer_size_kbytes = 128,
 	.det_buffer_size_kbytes = DCN3_2_DEFAULT_DET_SIZE,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 644f00f2def0..1a9bdfc35f2c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -124,7 +124,7 @@ static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C
 
 struct _vcs_dpi_ip_params_st dcn3_21_ip = {
 	.gpuvm_enable = 1,
-	.gpuvm_max_page_table_levels = 1,
+	.gpuvm_max_page_table_levels = 4,
 	.hostvm_enable = 0,
 	.rob_buffer_size_kbytes = 128,
 	.det_buffer_size_kbytes = DCN3_2_DEFAULT_DET_SIZE,
-- 
2.25.1

