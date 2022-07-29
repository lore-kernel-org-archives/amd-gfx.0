Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA862C00144
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jul 2022 20:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 851DD10E02E;
	Fri, 29 Jul 2022 20:51:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8627D10E02E
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jul 2022 20:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3sV8SE7z5ZxEf67NAncOpoCxkiSfa1E9q0UTYbQPQof3Qplk514kw4ohtfhCXxEuU+3jjR3aFk8FZ34pSc2XdD+CnQyGxtxz+kE4WbJo3WmTLOS5ZS04lc14q9dpCDG6pp1qMuXeTi+QmuSj3T9g1UIZQQEPm9izk8oMqdOM030uhhhcHT1ROYvz+9r0pyjwZQ3SKsk/YLK6mUNtR7koE/yZ9jl8K0SNbec1gXsZQLTXnJIo5ltow8KJjcz6uYtMXjgnRnGmnYGogF0PgmjrBlaRpQhLQjMOUAZG5oRF+tpW8np3XqskpYG74ls8qpE6MDVQXKFbTZAXouKimwStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ui9T65eBl/ilu/eEBsMJrFEb/FDRf2+DVNjyCWyLpbs=;
 b=A7PTbiWnWwsXcBvBtKzza2D/fneFflbmofQhywPT7Ac7q8+Hdt/5g+UfYTanh547I5Rgnj9mmcFE4jhAzrPOsgjbXYq416P3rLBA9AMXX5TAL6IUZqfFE5/6sakqfgBaeWX8NcoLGPvaHEzOzBTD61UmAc3vqCl8lzA8T5fxpQteZZWdijXV1P1BJxbVD94dM87mCydBlDmA5WlPsUZxaUNJ94mhQKfVg/KXBBOKNdmX+T/Ok6A+weRW0smttIe9rKGSIX68HBgOYBTPPcTks/GeAxkTekZ7dKm3iMiiAu0le8fX3uAx0t+IUfdvXDnKQeybSAHESBJS+8gGNJ6QNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ui9T65eBl/ilu/eEBsMJrFEb/FDRf2+DVNjyCWyLpbs=;
 b=WAiEMMOZbOJTi5IWpJeagLdyPgkMrb1virB6VMVrO6ujlonkoaNhH87zpO6TkN7UdqYYCGLEn7yVetvyGhRb3mj1UdVc53UC2xh3xSW1lCvfUnoGvUaUnTk6rEG4lpPIdilswTlRwiIWPSPtqMUwi3LodUm3jcqMUAPZoSne5Lk=
Received: from MW4PR04CA0246.namprd04.prod.outlook.com (2603:10b6:303:88::11)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Fri, 29 Jul
 2022 20:51:21 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::38) by MW4PR04CA0246.outlook.office365.com
 (2603:10b6:303:88::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12 via Frontend
 Transport; Fri, 29 Jul 2022 20:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 20:51:21 +0000
Received: from pswarnak-Sharkstooth.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 29 Jul 2022 15:51:18 -0500
From: Praful Swarnakar <praful.swarnakar@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH] drm/amd/display: Increase frame-larger-than to 4096 in dml
 Makefile
Date: Sat, 30 Jul 2022 02:20:28 +0530
Message-ID: <20220729205028.3329595-1-praful.swarnakar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94d08c8d-4a4b-467e-a146-08da71a417f4
X-MS-TrafficTypeDiagnostic: MN0PR12MB6056:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCcWufUKOn9qbGOLz52Aty1Fn6hsMdqDgFEcWXo73MQj4g8vUN2DjhyPoRChdUhNMIljxeDT/17c//Y9Hwco0I6E58DS+h7NjJsgnWUM32M15X7SxBfqRFyf4FnB+Ip9X5uerm6L/Glx/vYQDiQGAnmfCOUI7TZqBlprRjfcnr48JZ8LLkGwtxD+zyIY28h0dOwcKgH8YhmqeWbFb08X/vR+bmO4fjpOKaj8N0IcSo2n0INwfQn1wuk8Fg5U+N9t5BRNa3Z5HZBj6xs5yC+s8ax6UwDkSF06w3xk6BT/bhMd9+0Bs/zx/M/Xo+p/43PoN4d/oopBHDZrQVDujzdXrfeE0cTPhFqYXBcwOt+5ipQhW1Z+he+G5YQWQOJWaRqKwvzN0zySiQ/P9GUf2+xXoWyKIH6a6oKcOxh1OFB3QITsdKf1i0/dIRxd2aKql5F3v13hhXWYSNjbkGZx5gtm8j0gYOHbAvhLNKPIFvNp76xap9r0cJ6cfUmbu+MdgloxmLiO+QfF2UTlaTJfeceAkmz0Q27o6G8tiHdHiCzFVN5dq4slkFZne8l2fVd+wyxDeh+52mG8PRPFIousf1NE0QUXI6PO0Cs5PvrLtxJ8Pdr63vspqgUCezj0xOcQs2pNmwp+F8Pufq2HkEiV8FAXXIyAl9ufXfQA7cnREMx2W7V9weH/8SRpnBPb86s3MpMYdh/NNNtwIqqdxUtq2dF9gE6ub0QrW2TzMtesHfkISCxXdO3nMzU9jhnzt4Iy9NkJYatSxrLBCXoVQ3Q4ImbVPbYC3deRArcL49mXViyhF77PRCElG2RYxHbG5hB6oWPgt0s53Lbk47ndlgAMm6xXZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966006)(40470700004)(36840700001)(86362001)(26005)(8936002)(36860700001)(70206006)(70586007)(8676002)(2906002)(40460700003)(41300700001)(7696005)(40480700001)(82310400005)(4326008)(82740400003)(81166007)(6666004)(5660300002)(356005)(44832011)(478600001)(1076003)(316002)(336012)(83380400001)(110136005)(36756003)(47076005)(54906003)(6636002)(426003)(16526019)(186003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 20:51:21.5111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d08c8d-4a4b-467e-a146-08da71a417f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056
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
Cc: Tim Van Patten <timvp@google.com>,
 Praful Swarnakar <praful.swarnakar@amd.com>, Raul Rangel <rrangel@google.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When enabling kcov and debug kernel configuration, stack frame size
exceeds set limit, resulting into build error.

Fixes the following build warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3955:6:
error: stack frame size (2344) exceeds limit (2048) in
'dml31_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]

Fixes: 5679b6e2c887 ("drm/amd/display: Enable building new display engine with KCOV enabled")
Signed-off-by: Praful Swarnakar <praful.swarnakar@amd.com>
Signed-off-by: Tim Van Patten <timvp@google.com>
Suggested-by: Raul Rangel <rrangel@google.com>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 359f6e9a1da0..42b1df843a6c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -51,7 +51,7 @@ endif
 endif
 
 ifneq ($(CONFIG_FRAME_WARN),0)
-frame_warn_flag := -Wframe-larger-than=2048
+frame_warn_flag := -Wframe-larger-than=4096
 endif
 
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
-- 
2.25.1

