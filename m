Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3DDC05027
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 07:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6EC210E15A;
	Mon,  6 Feb 2023 07:59:27 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3DF710E15A
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 07:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFtr7JIAEQB8in+543WpnC7V16IzJETodS5WaW0RVplDHPdNwPmLu2mmQXogUL5FTJ9hHv9z4pfMD6MCC7S+UAf3diI3FQ/ll29MTMUmwpEBU27qW30sODS1FsvXrDIWninn2F3HkRQgKxmBAIVItlVvj95v1OQOEzpRGnPN5Oagi4JKRiCtveRiUOmK3yrVyAubkUmEGbBeT/C1N+eUCKYCvgdZx4gm+ozI6MEpYCfQaxKHQ5RL0b7ZOE7Rb+SphBwEVa8bS41zcaHu8ts2aPM53ZZKkVe/uiA+21eJwUtlGaX+VK1udbwwEMXnM+bqgM9PYTvyTlEzLgAXZhIwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VR5e0ANXJAv6jQpOc3oOyS5QPRAQ5SUT25+obeZvVuk=;
 b=U+huCy7mZeF84IcdCN3UKyUeYidTVOo6Mv0Wbj/TR57XWIfXOtvaUNeA6bK1oNgQJD8qP0pZbKDDBwvMjoUEQV5bwQPpHfhiY6JQhvQi1ol57EStNiNMlnAUuJGXQuJ/kZO/mXdSdutTwz6o7Irh0jGGX9Ht79t1EgbV6RKFh1WAqMMYdErZUJX6UXrekPJh1pF6nQ3BPi3Ajo+pz1uD2b6PpttA8R6cpXloBZ7L2bAKPicVO99dTPbrlxCc6cz6M1sqyNYRXKNmURjDe+nlYkn0KS2jf45yCIkWDhzVyrTXDsi/ja1WAUIWkmIbp8VFSlXcz2GVvkJujaCKW6P+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VR5e0ANXJAv6jQpOc3oOyS5QPRAQ5SUT25+obeZvVuk=;
 b=so9oI5FeSEMQjRiB4cf5+GHM3yoMNvi+PRavD0KtjAlx4ILWEPA5nyZ53GpHd4oC79VwEM8t4Q0xkmiFfM7zbTAAXA4zFB3tIhIM1oHOuZzCJRMBS46nj8FsZD0FNO/cvflbkBhbu/xP/sHU56oxkaIkERy/vQe0PPAcQw3KaJc=
Received: from MW4PR04CA0213.namprd04.prod.outlook.com (2603:10b6:303:87::8)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 07:59:22 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::e5) by MW4PR04CA0213.outlook.office365.com
 (2603:10b6:303:87::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34 via Frontend
 Transport; Mon, 6 Feb 2023 07:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.34 via Frontend Transport; Mon, 6 Feb 2023 07:59:21 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 01:59:19 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 5 Feb
 2023 23:58:51 -0800
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 6 Feb 2023 01:58:49 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Disable migration to ensure consistency of
 per-CPU variable
Date: Mon, 6 Feb 2023 15:58:46 +0800
Message-ID: <20230206075846.3841054-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT009:EE_|CH2PR12MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f28322-c4a6-4af5-1134-08db08180e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Nxh2iv0/AyGgknQwceOrCsc9WPXwpzImkM7F47p7YOlapfEJSjuXbKtcrfklkwmtOO81VTcEtf7EuGwDU0jONTkc7mLjc76CpYtzZPxDJRXL9QYz6yOYF8z4/S435AlvINvcRNpbhHhSDJZY8e+E0nToaMPTxG/E2OHUJKHcGdX071qmZi5IZZnmY9M0fBfY4Yiztqj9iMhcAgHKGAlxrcreJPBE27f92U8edhVklCcQ7AtVPVZWPGtRRMqGb2X3eoIrztNWwY3cRb3UPHUFWqozLYQZG/EZjoOQ/4Xci/tcZUChsnlqwBsz0Nv9zrYOyAX8R3NI0J2DvPxmFlte1eaas69TIAmIpQScs05yta2AcA/liI2srjM3wNfzSlJm9EYgDCRRvQAUqGo/nS6OSQvfWfFvmHIlYpH7Jq0nOJNiXs6fcCjrjGDA83BASEhCCI0tabO/igzYt34+DooLvnzkYCU6QrtOXKsmF42ruNuynqRdfKaqRtG4GZ3scFDuQSgng3+gkP4hQCpioO9TcMwiOKkeSi2vDxj4wmATG64qkvv/EALMOnfj4Cmv2fNFouoUh/Q96p3j1nJueGBfcjfq+fnGCd51Uk/HoVXW4TjiuQcBnD9t3iPp5e6XVln+WGr2Gn9kRbjzHQZFnyuObPLIYsdq7t90fBMXOrxgJ8YFea0EwScujxkQpqvFzyvXe6M3QNYv+QxIVdGhpNLnDAVkKOQRMPY261H/lq2GpQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199018)(46966006)(36840700001)(40470700004)(81166007)(356005)(82740400003)(82310400005)(36756003)(6666004)(1076003)(186003)(26005)(40460700003)(47076005)(478600001)(86362001)(4326008)(336012)(70206006)(70586007)(2616005)(8676002)(6916009)(426003)(316002)(36860700001)(54906003)(44832011)(7696005)(2906002)(41300700001)(8936002)(5660300002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 07:59:21.2090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f28322-c4a6-4af5-1134-08db08180e35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
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
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Tianci Yin <tianci.yin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: tiancyin <tianci.yin@amd.com>

[why]
Since the variable fpu_recursion_depth is per-CPU type, it has one copy
on each CPU, thread migration causes data consistency issue, then the
call trace shows up. And preemption disabling can't prevent migration.

[how]
Disable migration to ensure consistency of fpu_recursion_depth.

Signed-off-by: tiancyin <tianci.yin@amd.com>
---
 amdgpu_dm/dc_fpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/amdgpu_dm/dc_fpu.c b/amdgpu_dm/dc_fpu.c
index 1743ca0a36..c42aa947c9 100644
--- a/amdgpu_dm/dc_fpu.c
+++ b/amdgpu_dm/dc_fpu.c
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

