Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1196C27C50
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF80C10E6C2;
	Fri, 31 May 2024 16:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Bj2SPdK";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E95110E583
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJWkV+5jZsQxlJj76mIUyV5hdQftGRstAgfguCZxEdTWxEjCyctOAhSv5mIxWqMB/Hwd0X5hXo644tkXZ4YmhJncMZwlVhgbSgADhQHna0S/4hkrbDyDdPvkcBM1MKV/da1HZfjC9eleZKZdicqC0dN7xdVtV2bzQB0xGdDnPr6kkRb6NU0KZIEAWhz0RXu9Aia/WZ30HGWn25YFzJoLqMmz8A9ZzrG4JBG+VYXEClzUtAbzt2hZSDGatOvdqlINej5PeVYtTGb6SZ+JzpyNlQ2hj17JQnMfjmMSG55d3goAmQi9KgpLuWNPcuhmIgtg1u7FYIuEaNjU0A7yS6o22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5SwMO1BR9bYkJ4QPR+qftnvlvQFcjOr2u8urTfznWQ=;
 b=DC31KseZxLUcmw9aRXKq3wOZw2zrh+0fn5DqMlmAOzfaE5ZfuLxnYubIhSeiSQZc5zc615hILzMeWU+p/G2bysX1HJBYiPNoZ408oIYM6zks+WOZ7v6FERTGkP1hnVSH87qnVlwSv+LZbGxPNAnde9pRERaoYG6zAJnLhMN8fCnRhm8v9/g+f+yTx2MKriwbkdTSAq7Wp/oSlL9FOUGQ2wg+LUq9uvhPTgVPD6KKPVfjZ+htRLdOfJDVMlA+ajfri4YtJZfun7RO99fMWCNjSUbXuhGFdsLCfh49pTqliHq3CpxDFYRtSdvjcfXjwQzfp3TmQkTe4iDh+Qp+xmUW8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5SwMO1BR9bYkJ4QPR+qftnvlvQFcjOr2u8urTfznWQ=;
 b=1Bj2SPdK7wZ6c6jCuBk4Gm5tA+QlnVPDrHZwaZOrl1ZqK7g+t/r21fwIS8m/VHXD5qjh6LvZLWDvvWMptEPEzC6gPHQ54lzEseyGTcPHiY5JqXTIS+EPOn1BB9mT4Vnj050yWQmWfuuzjI0UwcwOTXvFZAm5I1QmqoO+UZahguM=
Received: from PH7PR10CA0018.namprd10.prod.outlook.com (2603:10b6:510:23d::15)
 by SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 16:52:56 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::73) by PH7PR10CA0018.outlook.office365.com
 (2603:10b6:510:23d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.20 via Frontend
 Transport; Fri, 31 May 2024 16:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:56 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:51 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 32/32] SWDEV-1 - dc: 3.2.287
Date: Fri, 31 May 2024 12:51:45 -0400
Message-ID: <20240531165145.1874966-33-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SN7PR12MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c67bef-821c-4f71-41ca-08dc81921eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7By+6yBKMF7aypOT+2IBQ65tv9Xor3OuZMGLDiuAFpkJd6pK2PsijfptY5Df?=
 =?us-ascii?Q?wOYg0NW9Q9mPDYkv1RRs5brQzavUC7SOJivwu+5phxOMvEpfrBbwfYJKoCWL?=
 =?us-ascii?Q?Tt7JR9hKolpbCY0dYs6Pnhkx05j1txJjZRAgCGtIm/bZsd2g3zlyfmfYpfnl?=
 =?us-ascii?Q?csFHnAjTeCquf+RGFw8gNXG4Lvw1g/gG3GRw/gohmpJCejgRhSGMZKTbN0T6?=
 =?us-ascii?Q?mpVdgt05MXPoNND0cUcdA5uLJQpKHO1mYUHYxHOK4pXoUy+bgOAl3Yks2tPk?=
 =?us-ascii?Q?eaQ2Oedfly3KH3AiyNWruGxHZ7o9sUaPuPhmRdZ3WkXn8u+h0AmyAz8ZEFWy?=
 =?us-ascii?Q?EYL+FZSVBJ202I7K3uVfCs6YUPou2s+ADF/5yMGaB5L0Icy/BL32k0TMr55D?=
 =?us-ascii?Q?wJ2Hfc8rJ63Lzwr/cLXpzPxGXid6+o87GEghljHHqfwm57eypP0ZiIR6ED11?=
 =?us-ascii?Q?z1V+i/pnmYiUIoW1gwcetxexOQBprLeXCBL0S2+pX+RFtT66nUQd7ahI4v7R?=
 =?us-ascii?Q?85FiyJ3w2A3Gi3uTKwvlhKHiS3PuVETz3s4xhLRvOwcjAIHbL9Fwfg6qxfxu?=
 =?us-ascii?Q?ovZCNc98hAFgXl+xozKgUg2RRtAJUu9+Ez2MCzEAT8AgxNFlxXTcl1VETTAp?=
 =?us-ascii?Q?K2zTKKEYbSj+LEQAvxeg2zJFsxjR3NEI/xnCj5HIB4Fsj1VVJPXd8HKISuqa?=
 =?us-ascii?Q?GIT9covGG17QewdYpKxPXuZkIHloBljSHxkCbrmUPLA4aecXatLkpD2W30Bu?=
 =?us-ascii?Q?Ib79TOHzDcggHDYQ5mJgvwER/cQCOfoC5l7wJj/GLsVYR9pS0Ru10nFcg0gL?=
 =?us-ascii?Q?rs3XeP3CSF4acemIw0K/XsuIIdxl0Y1F733KVdK5zcsDmqhO9j0T0IVsPFxi?=
 =?us-ascii?Q?CpoKFOxiD+jSJ9YdWjGcxBZ0pYTQNz1k3VDqujictXqU6fRN/SzL2MqLcx6v?=
 =?us-ascii?Q?JQa12XtYszP3RZhaqbC7NaUoqOiZhGfvThwGay8v2WS4JVY2zby0N/UDMQUM?=
 =?us-ascii?Q?IttU2ANiQ+X1aiAqnavSJKAtXBjqMrtUjav/LwFo+/YMCInJOtpkfrprSIBk?=
 =?us-ascii?Q?2DGs0fmftmBjK3JCZjZ3+2Ft+uQcwM+iHyFVUZFgYsh5g56oPYSCouFGJXo/?=
 =?us-ascii?Q?TcnPr5cYP07Pr/hU9nX0FZhD/gIo2mznGoHdkd1UIzoxs9xDqwHZPKPNgmrD?=
 =?us-ascii?Q?AwvBxlbMdmFDeAPWlRY376lj4Al67MknSi81bKAenUYQvoR1Q1UjU3eK2kRb?=
 =?us-ascii?Q?r+OQnbcRa0c5qhmPISVzHEXa6OE9MMCJiijnD9Hmc/bP7UuNEwnbj15dT8Uk?=
 =?us-ascii?Q?7XspRMr8u3lOptqBPrPoQvkwSsYIAHPEgSnfDyFejvxftuWMhAWsc7Ia9nI+?=
 =?us-ascii?Q?GW7ggKF48n/I/Ytrj1CH7icHUDTG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:56.2772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c67bef-821c-4f71-41ca-08dc81921eeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6768
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

This version brings the following changes:
- Add sequential ONO sequencing for DCN35
- Add new GPINT command definitions
- reduce ODM slice count to initial new dc state only when needed
- Enable copying of bounding box data from VBIOS DMUB
- Guard reading 3DLUT registers for dcn32/dcn35

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 56d4bec1be1c..e5842c15e39a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.286"
+#define DC_VER "3.2.287"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

