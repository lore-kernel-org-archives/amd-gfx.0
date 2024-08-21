Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411E7C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 22:02:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E886410E6F8;
	Wed, 21 Aug 2024 22:02:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wAmMxe+v";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C31810E6F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 22:02:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4HNUeQgZhd+lcZSCDF457OIilEX+KbujuHkj4XClHm5xiD2vrLB+5tAhJU7D64PKwqSKm7txqi17ViB57WHSPV/YhiT8b4k6DGueBRr44veIHRnihuAZlxPeCgk8h4udmMsP0ZKgQa8zS521GfvNQckI60NyLFEqavU+mdRjbkOPUFpSijrM26dKStie3+uMipWoW3e7C2g5qFZxzXjxauhxMYwQCf6tJU4wog0bla7rrf+1MpG0/7+fNK0+qxOn+e6b4toErO7nV3RiO5DIplDoN7hQuzSHto6EJEZWDNCjhlcxSBDAjOawLRTCnTQKm0OUI0xJ9iLHw4jagRFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8NeI5/dBzTNdLTyM8chwgiXFpK1s++JjrdPUa0VDlY=;
 b=kz7pq8a5dAliNRSnkHE+S7qZWDcR/rkHeMnfvPU7rV2Xdk6GU37FgUmGdkwuhopaivOlfGB4VMOwDHqAMnM4GpGubumCcxPQPGqYaF5a7hw0isXwskVcdWRQW+g1vsmCb0LcHjDuG/kpLcDgYYuXMpJrFp2PqoRXoyYhDfo0x6Kxp/E6As9NLD+83JM+ecy+Jb2K86JXB3QqCnqs9mXB4LrlkT4M1+hZm7iXfthoBtvf0blHUIGPfPwwScZKe3oEbN2KzyeKsPD4ahfWzxFChiOw59M+50WPntLE3UHk0ihDB+rWn47mIUZfqygWTkGRYCXzRoDbvMknzEdyHW/flw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8NeI5/dBzTNdLTyM8chwgiXFpK1s++JjrdPUa0VDlY=;
 b=wAmMxe+vQiHch448T+3HN9tVGI3QLLKYz7KuRqWZ6XLQNYNJFHn+fHBdI8zpSM/4pZYbtLaOiMi7qnrslyDb0qPMm3KuiOfnpwkvG0KxBceCzNbXI2gmR/XWd7mbBnFhlKX/uzlap56cfIe3YCO8UaTeO4JT1ZdSu7oJPvm1Xec=
Received: from BN9PR03CA0848.namprd03.prod.outlook.com (2603:10b6:408:13d::13)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 22:02:31 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::8d) by BN9PR03CA0848.outlook.office365.com
 (2603:10b6:408:13d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Wed, 21 Aug 2024 22:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 22:02:30 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 17:02:29 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, 
 Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 01/16] drm/amd/display: Don't skip clock updates in
 overclocking
Date: Wed, 21 Aug 2024 18:01:41 -0400
Message-ID: <20240821220156.1498549-2-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
References: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: 829cf859-7365-48cd-acba-08dcc22cf410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VYM+AUBQTrfb/vgzQ6RY2FG2QvbCkh5CvFCzmPbVxk70l+1y1lXDkm+qpDB9?=
 =?us-ascii?Q?5tqPllmcgJdvjh40orcZOdcMQdU5LkbPExiYa0UZM6qj3CcpmsRz7kFk8+8h?=
 =?us-ascii?Q?XhuxL2FevED8YyWTHTcjYQuV8r/LJ4GA6T3XpFQdYUeY66aB5gooklgUYafG?=
 =?us-ascii?Q?kCP2q+3Uc3KoM4bHsQtjn58Kv8W0zqpw6RfrtHus7IHpZEuPQJ975ksqj3Vm?=
 =?us-ascii?Q?LlQAXzbQJE/ebR4CACl+DU+YKLMNKWGhsPitAL76mG9IinFQ2Ldq0YQJ4QkR?=
 =?us-ascii?Q?nBf8yc0P2YdbZwI4oeF5NA4I1gvhSNPzuMMfJHA0hNq0eAVkZaoCTYBMyKT8?=
 =?us-ascii?Q?gRzrZY4zY51a3Gm6PoYzPWNcoJvYvvpgEDeCn+aF5F+MG7dMZnpWFc4mqYNX?=
 =?us-ascii?Q?2JK6Cr04HSZT+gZVXO97kzrFkAJ8Dm69tHq+HrDZ7+exy6paIIbw0kB7n0BI?=
 =?us-ascii?Q?IxiArn6Slm5GyzfcEhQ3ZURRIZo7f/sYx12myWY2Jg6of9xj0H7cj6xnzuFp?=
 =?us-ascii?Q?SsQjx98bG0xhWfdyeMNqmW+7LcZbhOXkTbR4GHHpwHgBNcMbAFBA64A76IK2?=
 =?us-ascii?Q?vaAf9PwCXAvtqcv1Gy9DdSO7mDn7ojDZ/YzIyRfAwnBESWWmI+FWGrG0a+XM?=
 =?us-ascii?Q?5LHRhFJNVFf50ZEPSJ6gorspqIGqDUMopQMI/o/sVuhqjSu+UM9QJQBDpx9h?=
 =?us-ascii?Q?zFVITC/Q3wMcVpUx95DOPEM7NftXjGupiQEQvs1naDDNu0hsRm39P/j+BcU5?=
 =?us-ascii?Q?XrWLNBur9CDwWK4e3uOae2zNg1jtu/6Ytf9zlTRBRMU8y8y2SrN3irdIBnBm?=
 =?us-ascii?Q?F7JiZ3WbplzF4Gv+GoaXLgoIcf6Cdxt7D/g6kM/G5K6CRzw2U4jNNrhJ1LGV?=
 =?us-ascii?Q?m9wBVwYxpHKSXMZNRFTREtNG/8epW8ToqrHBkVZqaBjj9GYbBnYSgvdnX01q?=
 =?us-ascii?Q?yVO/CUSrUCUBvZEkL7ewfiznl5Ph/kLljQNIsoGAIWoeQN4tKi3ihXdxAmTm?=
 =?us-ascii?Q?aDCkm8h/JU69uH/MtMyAdeLkx3jjeMPBCJSbEabcVt4FYCpjd4amqua7sb6o?=
 =?us-ascii?Q?j4TtqdCpgNq6Ywgv8LrfeyZ6Ivjv1dkZvh638a1g58+EQ5OeFxSE/5hglZ1r?=
 =?us-ascii?Q?/LszCkGFfKq8qP1YcGXY5md9+69MhKOSc7j4Dg6pNfxNoKKQK+L5AwYyZ4C6?=
 =?us-ascii?Q?hm9Sw4qTioOzbLARuDWdI6FdynwgqERjgK/0YTV/wdMU7DtBE2TYDEKhs0CI?=
 =?us-ascii?Q?Q6pEQnzEM9A0+eG3aKOMqWJv0aAw7zlLOk0UeUlw0/nD5YUh3yAObhSOjN7H?=
 =?us-ascii?Q?6UxoJPljJUN+VFh+vOxsEc6b1bJm1zB6gy12E5pyPnMPal9wZwmbMkYYGqrb?=
 =?us-ascii?Q?7W9G+iyS206/5bAyZ0B0JDe2KLbLqfUO9Ow5E3rv97GvZyDPJT2HTwRf6qcL?=
 =?us-ascii?Q?T1C0xuGHs1ZIWsPUDXpmPuW6YDxYp9GC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 22:02:30.8225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 829cf859-7365-48cd-acba-08dcc22cf410
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Skipping clock updates is not a hard requirement for overclocking
and only an optimization. Remove the skip as this can cause issues
for FAMS transitions during the overclock sequence. If FAMS
is enabled we must disable UCLK switch on any full update (which
requires update clocks to be called).

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 01ea3a31e54d..8cfc5f435937 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -1366,9 +1366,6 @@ static void dcn401_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	unsigned int num_steps = 0;
 
-	if (dc->work_arounds.skip_clock_update)
-		return;
-
 	if (dc->debug.enable_legacy_clock_update) {
 		dcn401_update_clocks_legacy(clk_mgr_base, context, safe_to_lower);
 		return;
-- 
2.34.1

