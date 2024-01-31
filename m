Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB00C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 20:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E995010FCC5;
	Wed, 31 Jan 2024 20:15:52 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE8FA10FCD7
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 20:15:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frGgI3rNNC3kcLrx/Ba1FaKoFmluUmFf9UOMVXGUiAamFbZyhklfZ2eKjVZ1Q9Xdl+a7bfmaBlKgXquuLikNMgVcuhsEaAYMFcVrGsGCPz/l9Eq4i/pevQMxM0TLWMPLVzBuYOxDHnY5YMr6wdwkOqr2x9UuMF5rQF74KmzGuhi9w0s1fCmOaqUONiFsqpQs28b6JfkGpwDeF7K3mUIOS7AFPBxvkV1Lgg154EZbPPOICEQluGr3efLHsv3g/i5gZ9uIFQxnckxGAxgFHwoypxo61+4OSDyS8DiMlqAJClx8nGVZyCh1JZpv+0aCcD7GMHP7Zb+aHQ/8UjHCMznlrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeGVs8NxwCXo6pzfV8kpdf1vBQSNNc7pLiusaHnX06M=;
 b=gmbHCVE7ZdtUBN6yJOWya6405fMwJyz7mj55XfuflIz2u0EWkrCiYvSy0yF7G9seE6H6xsadYWdZYQCFPMFTo2egH9pRgWmQ9VcVch3PO6KLfRt8GuQ0/I8nWK7lMskCGLMlXM4uXAV00px+JiEGth70zQ5fZnkow8YRH7UnDHjwODg2015Hjxzr6N+cTUYBmfF+A0ORyQcHk5OTT//qvCSTUJURCzCICJIZrT0SptBLgooZB9TR8WuZtn6vwJeTc415S7/TXVdsE4wEvmXLVwTlIgjAr8vjh/enu8WVwatHA9XDYxpNWEd+VYA6BoQJyUPjFfI8bKvtJm+t5DM2Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeGVs8NxwCXo6pzfV8kpdf1vBQSNNc7pLiusaHnX06M=;
 b=lAhOXkn0R05NcjTvv5NvjCjDlTdbrTCTnwbJAXzsu0bQtGUtslta9wStLE1RuyZ+eA9+1eGnii8tmb6IpJqxR6SrTJyJVknhtRjmQWYS+EWEs4lmWiTOQcTwFL6adZQZ0yyVIU8X29kO1UblkUOI3nYn8GAVhrH2GyG1n4e+J7U=
Received: from DM6PR08CA0054.namprd08.prod.outlook.com (2603:10b6:5:1e0::28)
 by PH7PR12MB9075.namprd12.prod.outlook.com (2603:10b6:510:2f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 20:15:49 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::36) by DM6PR08CA0054.outlook.office365.com
 (2603:10b6:5:1e0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 31 Jan 2024 20:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:15:48 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:15:21 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/21] drm/amd/display: Trivial code style adjustment
Date: Wed, 31 Jan 2024 15:11:25 -0500
Message-ID: <20240131201220.19106-20-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|PH7PR12MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: 78659d55-d340-4911-518b-08dc22996a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKQXrXfnwS/tA3Dtbo1+5H9oh3eopr8VomxjCTyq0qu1jlS6tKbf40wJdJjw9qckgaXSF4P2nWLTfdJEnr++kK6YSfKS47Npg1mDSXzvZ/xvi2a2JhBhoGC8B4ISXf+aQf6ECnei4zaFKkjAl/Eh42Tr1o385iYE7elAaUMkfOk65xTG4QFg06Hoy+RqJKv++oLNhgiSfY57ZJXsKTLRLh9Rfnt8MVrhuR+pLfDpXk13YwKegACJo/OTJ/wnge4obZYbIuPfxdYc4qsU2HrLJGeNgFAlBrm/cUIVApZKNSg+Hz1P8i83/2oY8cy/Y2xrdrKk1yMxskz2pmWTuRVIaefSYSH1GJYMO0u9GtW73Eky7DDg/iOMVJG1LObXFvGqT/OoKu5oIr8dW1dLnSiN7QLM6FaL+Mqf76xZpWNvhnUlXXZZCnIRJhMQbdOB46ZmdxEBifqvH8/aNbXBuV0ulQolv5g5wFFitWCnZsB/sD3OXwpXtXqx8kVZErVw9U+3K5/IF6zjDkW9i8DJuRd65B3rqaUGICmPmrYj7ffo4qikzgwy28XC3rX7ZN7Yv6rgV1YnM67URZBuIZdJ+z9bR/H4yMqC8B+W42MidgSprRfBy55+sjNHYEYTzIXQnLdDakdovrQd/5iYi6yn1od65Js8mhakanBOSAAcXWAJv8DvKQw+ELYzq2HfhcVy4reqcOjVlXaVQId48zMLGn/ow9AJrRoxfuPwJcBbAK0yFE4UFatzizjR+jMzMEm6fnUi/CoZ0NTSmmMolzzKI+iLBR0cQ/IppLK8z9BZyWEsA81Z2u1b4J0j/4jNzUHY7d/k
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(54906003)(44832011)(8936002)(4326008)(8676002)(5660300002)(86362001)(2906002)(70206006)(70586007)(6916009)(316002)(36756003)(47076005)(36860700001)(82740400003)(81166007)(356005)(478600001)(83380400001)(1076003)(26005)(2616005)(16526019)(426003)(41300700001)(40480700001)(40460700003)(336012)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:15:48.3953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78659d55-d340-4911-518b-08dc22996a15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9075
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Just adjust the code indentation in the header and add a simple comment
in the dm_cp_psp file.

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h   | 3 +--
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h                     | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
index a34c258c19dc..c76352a817de 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
@@ -36,8 +36,7 @@
 #define DALSMC_MSG_SetCabForUclkPstate	0x12
 #define DALSMC_Result_OK				0x1
 
-void
-dcn32_smu_send_fclk_pstate_message(struct clk_mgr_internal *clk_mgr, bool enable);
+void dcn32_smu_send_fclk_pstate_message(struct clk_mgr_internal *clk_mgr, bool enable);
 void dcn32_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr);
 void dcn32_smu_set_pme_workaround(struct clk_mgr_internal *clk_mgr);
 void dcn32_smu_send_cab_for_uclk_message(struct clk_mgr_internal *clk_mgr, unsigned int num_ways);
diff --git a/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h b/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
index 4229369c57f4..f4d3f04ec857 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
@@ -26,6 +26,9 @@
 #ifndef DM_CP_PSP_IF__H
 #define DM_CP_PSP_IF__H
 
+/*
+ * Interface to CPLIB/PSP to enable ASSR
+ */
 struct dc_link;
 
 struct cp_psp_stream_config {
-- 
2.43.0

