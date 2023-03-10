Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F279BC6FD1C
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 09:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A90C10E9B5;
	Fri, 10 Mar 2023 09:33:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD02110E9B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 09:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoChJr1DImjGbJfNYDc3EcXuxQjby9ejwYlp/YdIrZ+VB211M1f/jLZsSDkkFD+4cckRw3MITQxdgRbnL8UiwNbYNCtZROJEvHHQwSFx+HiAQh+VnxIen9cSmhmWhau7JqY1lBZJaXD//V+9Oj1tgnp5RKzGGtoMg9aFNrl/ZwVq9X5PsOG9FZZdu4tgwN6Gz7AsBTL8nafta9DKyWkJinharnMJPWITHZKOyotrYKbTkJlt0B+QAsU6+Xtk4+oySXLsPk9mZMxabPZD8sp7qIZ3TQ/ofZ+W3pE74atAAZWrCCHeRLe0VaBq6zly5UoBn8HAuuK5xpd/A5ZkGvItIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CPP42sol1oh0XTVHDKSZCav0ZSL93B3k3L3pMmNW+s=;
 b=WA07wXwpNBDNA26xi4Xmo+aj5OjHT4CDUkBXFAfwzInYkVnseIfL6j/VT2LbMWA4bbLSafRiagsTt+3R6t6wN0eX1RbKqpjdytSutHVtIBudlKu6gCsN7N5PDB7jxs4VowgLLkfX/dsw0WB7OV1J/cdU6FGSsIncjeAPlJBgAwACr7oxJVJ44X1scVjF5GinBQZsXDhZVy6EVGHM3jtMYBFgEQpkwp0j/QsJw5bo0bcHrNmDQkl8OesRHHaAtyBBMGc3LgrSsfJKZRd0n8oU3EJ7LSUqe7UsgInWKxs7O/1sAS/pIaSbCYmzAU7eSOEIaaGSC2xr0XOdzQUbhVJ7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CPP42sol1oh0XTVHDKSZCav0ZSL93B3k3L3pMmNW+s=;
 b=kW60SYFDvFr7GFFhTEYc9JstNcKH5HoaHXm87LKYYCf73H14r6pPUk5W1id7A7INBKHNqba7m9Q040SPs9RYiqTHyYEchxWGh3FxcBPP62KO9lrjrw/WmZq3aCuMrBef/ZVOhptkQJ7gKHPZF3G9/P0EYzNS8RYn77A+SzpmSsk=
Received: from BYAPR06CA0027.namprd06.prod.outlook.com (2603:10b6:a03:d4::40)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 09:33:27 +0000
Received: from CO1PEPF00001A61.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::b7) by BYAPR06CA0027.outlook.office365.com
 (2603:10b6:a03:d4::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 09:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A61.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 09:33:26 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 03:33:21 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/19] drm/amd/display: [FW Promotion] Release 0.0.158.0
Date: Fri, 10 Mar 2023 04:31:16 -0500
Message-ID: <20230310093117.3030-19-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310093117.3030-1-qingqing.zhuo@amd.com>
References: <20230310093117.3030-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A61:EE_|CY5PR12MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 35975297-9c85-457c-cbe0-08db214a8054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LSg83IejleKqO68qA5FBdzI9z0o7POtaf7VBAlrk60UUx6Bwz2fswQFeMMx30tMdocpLTrhOHp344ECXyI9mJYiThUnG3qxHKBFC/WAhnmTyO2CUzuoejKLwjfycRy3HQo1uZ0znn+SEyCPFAbPtHuaTWUbDCjvdGCARerheq+oQWxqzejAPzzzl4Mm6ySqvEB50sLJNAicMj9pkAspgalv7KH8G1DBULcqT6TODa09BP/YkybsyzBSJ/fn5EWe8lwgOkp/Wv+FE0n8t+wgGV0pS75l0+3hp9TSi0ycI5QxLXhTZX7fm2baRbwt2xWqrSfu633+QygZHQNEjysnRIjooWlZGFoUsW/1Eo5kgox5Jl0p9bKJaxyoilAoW7TDHBdfK1vi3ZJcm6WuWiEbG9u1QNzQ3PWlOIWAQVRDwnMOfAeUfwZytnsG7TDN3pxDjG1B6MNqDr6QtLFMp/aV2Dwm/Lut+p/2AuvNKBx8x0gvnqqVyl2Uuj9HdMlm+gjc8XRutDGBJqrMQWfMIRc0yw24NQvtrxZhUkjXIpXL8e5VNfqnCDpTVgzkCuJv/6mNJ3SZOZ/VwE+gNVsp34fQaZC9H+q60LcM2W9fY+0JXbfkdUHIa4j95TZa2SGRu1d2Ei0MGNr7IjG5ZmrMdbyVJz0RoeJKYX0sUVRD1NUjy2LLM6bsdy+pE5Ns3/Ho71KDmgZTkIieZ2HqW2o6w88R1EV7WrnE/exwWv9EZYMN1aK8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(36860700001)(82740400003)(83380400001)(426003)(47076005)(36756003)(40480700001)(81166007)(478600001)(54906003)(316002)(356005)(2616005)(336012)(41300700001)(40460700003)(186003)(1076003)(6666004)(26005)(16526019)(70206006)(5660300002)(44832011)(8936002)(70586007)(4326008)(6916009)(2906002)(86362001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:33:26.5832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35975297-9c85-457c-cbe0-08db214a8054
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why & How]
Add boot control bit to control dispclk and dppclk deep sleep

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 734b34902fa7..3175a4fe4d52 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -410,8 +410,8 @@ union dmub_fw_boot_options {
 		uint32_t usb4_cm_version: 1; /**< 1 CM support */
 		uint32_t dpia_hpd_int_enable_supported: 1; /* 1 if dpia hpd int enable supported */
 		uint32_t usb4_dpia_bw_alloc_supported: 1; /* 1 if USB4 dpia BW allocation supported */
-
-		uint32_t reserved : 15; /**< reserved */
+		uint32_t disable_clk_ds: 1; /* 1 if disallow dispclk_ds and dppclk_ds*/
+		uint32_t reserved : 14; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
-- 
2.34.1

