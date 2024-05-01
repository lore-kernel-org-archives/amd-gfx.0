Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85415C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 224821130DF;
	Wed,  1 May 2024 07:21:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bR7cOrVb";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D91A1130DF
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:21:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1TKXh+0no4os73t6ActWP8rQTEjDdbvrBXcs9ZJ/QIQIaTBpOO2DNJU+5S9WlgUhhR508PqFkDD9LucNjeaLOZvzLrKyF6DZQl7KaCc14eXyi/9W0t+Dt3CQuYHpg+k5UgkcB5XgEooFbJFpLtavOPvV2KsQoyCNORrMEc12qa7uEpprbs++pPmJqiT4TyC9uvVqEZOCwQl12CRUCJMprqHRnMvv7Id8qtrqt/dpG9r/sZRx+XvrKZ/gmboE2QGIQnYEIc0tD7jxMbrMR+RhmxdSXOemlrkrLzgTSj2GB8Y5XORaSNiCpC5VTuU0sn02dwhzNSL9PIvy4Vp5/2mpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8/bfVDxlAT2P3JZJIvcl7JSuhw94R7zg6xDJR/pTX4=;
 b=SW86PL9yO8drDScV24vShYL/h3qwpR57U/R4bczK0zdUbdVDefqkTNXGKR24cs9Nqv1AKUTGy7Ewtua3SlOXjE8Pl2unbhc/ScxrYtpgUGIqik4/ywSwo8Mmk4oQOFxlOo4oNZixm63gkBsO49jtaSF5ZRtdODnQYrYCq2SKIV00zrvzD02RnkBegssR+WoqqlRIsq0G5DEyyPVrYCmfLPYxLrN92NKFHLQzt2Np1jFAsQw2CnTxVaMoWHp55gwoq4w1+QnYV0Q4EXeX3uLXrFuKDVYR3NPLGR9sxuwAsA/9uLmbIwTIb9xibk/TIZ859KDbaq9w7rxrB3W6gUoQcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8/bfVDxlAT2P3JZJIvcl7JSuhw94R7zg6xDJR/pTX4=;
 b=bR7cOrVbVP+zooawBH+SX9dX9O3LvRm6BcSrfcpQPLckCGJjcouRqfEwWoS3qdrjKeLvee1hspd6WnKSCVYetGB9tj+JFNzNkbbeeLPflIy+73sLACivbXB+NGsZkuScMFSu5N3j8ImPt64T+lcx2k3ujgsgNzuTIvIHoQeXfso=
Received: from SN4PR0501CA0120.namprd05.prod.outlook.com
 (2603:10b6:803:42::37) by SJ0PR12MB6712.namprd12.prod.outlook.com
 (2603:10b6:a03:44e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 07:21:43 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:803:42:cafe::f) by SN4PR0501CA0120.outlook.office365.com
 (2603:10b6:803:42::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.23 via Frontend
 Transport; Wed, 1 May 2024 07:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 07:21:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:21:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:21:42 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:21:39 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 45/45] drm/amd/display: 3.2.284
Date: Wed, 1 May 2024 15:16:51 +0800
Message-ID: <20240501071651.3541919-46-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e560c0-c7f0-45cb-f468-08dc69af5a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400014|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DU9oDpMP9qNx0Rzssq8Y15/1ECm+TMGPa20zp+s41Biu5uS2RJF6fZ8bt89K?=
 =?us-ascii?Q?Ec2K2J7MimvljXDlCyPdnaXiJuDcfu6sDes8fbvmPETjzXgP09lINz0O5HMh?=
 =?us-ascii?Q?Tcf+q5IQRXjXIzip7NNH+H7uxem6am2mOghfWJXjesNEqEzyrQ2pcAeQrHzk?=
 =?us-ascii?Q?XO/rHZCAJdrarcO3YXYZXR/wWQP4sxWXQtgww9du0vkE5OjKhb9Zw8FPgEmP?=
 =?us-ascii?Q?8A/ifk0Um+kozmHIDai7lZkuxZu1p37ozMwv5tQ6niS5gzHwE/pGfgiZy2s0?=
 =?us-ascii?Q?tdtqyNZY3ltkaGOnTY5cnNHsYlQKCSA6+eiKwetpKjQN02e4w7ZsrS/TF1iI?=
 =?us-ascii?Q?WmRLT3AowIqUMPKNMR1zHBsnJaA/eq7+9nunmndDPSxQ2ghcfoC6BnMc2xNF?=
 =?us-ascii?Q?xKCfCX858sbmMCHMl1ARYUTtIZKLs+JnmjFcrYzc4r7+7tPb7+8wbAXY0hRj?=
 =?us-ascii?Q?IP728YBUhs0LqChanaHIVJIx5v7J2/5kh6jfSBySPvZg/58befssMH6BiFKp?=
 =?us-ascii?Q?p9OuLwOqMbLjbWth9fUqxh+ycb37KO+LMM6qMNISLeOPe8sXdeI7G01eGJN2?=
 =?us-ascii?Q?CJKUnkOmwEzMqB6SfoM8fQtSw3YQ713OcrbT5i9t7Ui2AtzfdFfC2Z0N0Jl1?=
 =?us-ascii?Q?VZBvOnzNXLoydzdBaVLzKVdZADgMoMi5v4hYjDPsAtY9cMXM9lazmUrWqUhX?=
 =?us-ascii?Q?RD3Tmg1IAKsDOHQuvZixMFgubA24W9gWRcf3VNdLjF+0aqZ3q8T3PB0cPjlK?=
 =?us-ascii?Q?2gCWZ2rCWXopiBR8/7BlEejIGZ86e1K6kCYUolRCMYOdzoJchlmIUjcHkgwY?=
 =?us-ascii?Q?6l4JF8MApgLkQmY4vXAEvbqZQR68vlRflRn5ptXmKYjYHHTcqRip6mGJ7lSL?=
 =?us-ascii?Q?CBTbVojwyXknE8DE2elgAyTphFfCkeFkkXvvGOQ0rNMVDccS55Jm+lqmY8qz?=
 =?us-ascii?Q?QWhXJsmmZUCSIDO38/ezb5aCDD9fnV1jdT8klY9ELnTcxf3qPfQ9dBrD+sbu?=
 =?us-ascii?Q?5YFnEQTIDrHFskxD1pt3xx+sxWZqYP7irPw1kmKVZ9xsSt2ycmQ0oI1rUli6?=
 =?us-ascii?Q?MASmASNDfSmPaJp/Ax503LO/QwWCLWGZPB15wWuefUncsW63pBsI5hD542wN?=
 =?us-ascii?Q?fe1ftCLDPkNrr/y6ndfx4F4cPRue7HAaaN0yfpQO4m73wFep5dS7rSRZWF0h?=
 =?us-ascii?Q?wCGkhz3j9LnV6hidWN/JwsTTEsU8aX2G1UQH3gJP2Y9WD1bRdoFo3V6cb16L?=
 =?us-ascii?Q?l3dyBs/uwe3O3iktNKj0b+A+a/yfgaifKbIWKil9oIIQ9Y8xtzFg3tWocIHp?=
 =?us-ascii?Q?AX8Ow+KXhA69Iq6wlDPfaEJ18gBJfPzuftMA2GUSF2B1XeGGLzYOukUqVD90?=
 =?us-ascii?Q?EjrsCNWPZa+rEQtwVQG5jwMt8f3K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:21:43.4616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e560c0-c7f0-45cb-f468-08dc69af5a4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712
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

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Fix some problems reported by Coverity
- Fix idle optimization checks for multi-display and dual eDP
- Fix incorrect size calculation for loop
- Fix DSC-re-computing
- Add Replay capability and state in debugfs
- Refactor DCCG into component folder
- Refactor input mode programming for DIG FIFO
- Reset DSC clock in post unlock update
- Clean-up recout calculation for visual confirm
- Enable urgent latency adjustments for DCN35

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 235e43e10799..8698db8f3e45 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.283"
+#define DC_VER "3.2.284"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

