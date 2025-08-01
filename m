Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8543DC87FCA
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 18:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B1D410E8D7;
	Fri,  1 Aug 2025 18:19:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ghMASnDi";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01B8510E8D7
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 18:19:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIsbeqr1zJkxtYfm+Nw1JsnNh04gu7Ka/DfZe7HZaRe9OFFwaWVW1Mcp/eMzeadE9OuIEgtzanI4xBhXSUwailkBtupesB6o0brqyo2Yg4yR9ol9YC+SVB7x1CyHFeHsf20OisVbByzKZhTsPagYjceAa9BRd9t5eB1k7L41Lg4id18RmH5w3wr0H9b03hEucDAdg3p5RTj5YeKcc5kG1R6kdI3wysdlVntYpG9hfQGw7eJhhOc0+tzw6+5td3OGgmz5vvtsPLUfOhHn9d1MCw5yUyyO20PLU0O75yvIHw8x603bDsIPU0hT5lAM7EfmhgKHh3nGJrS6zl+uvkd31w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrUWoJNhE2uFPWRrpMFtEdcfvruQAyGvWhLivLJCV74=;
 b=Hy/iS4OHn7cp/HG/suzieQNX/aYF4QLzYzS8h/eIpa8g1UuQEGjqtvUh2pdkNt5tWV3OViQlasUsOhwaWaoGy5oEMylht7J4wS3LH0+BGhBfZoeILG85NiHzO4AORVtVK9Z59Z0f4VDDkzmQNl8a+oFJByPtdTmH3v6uOsCpb02rnBsoHdveQZB0wBcvshFPrzXiF0JLg2j4naPJHwJFWDaoiJzWSKFawzZhn27LL42qUB+gecPR+R9JPXsG8ZjZHTNOZltoNbfSlGuAgrtEiNKXq6/T7qE39ka5kBAMDyLJ1SXH+77gs3pHxGJRTdTltOJoJm0VDHOrqOEvi/E2Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrUWoJNhE2uFPWRrpMFtEdcfvruQAyGvWhLivLJCV74=;
 b=ghMASnDiqXrfXOayAr+Ib+x7eMf5JjRMl8gMnyQIMlSuKXn7klAnGeiyPIArj0G8gjCNq3nx+zB+eimf0EO57+DC2p2/73ml9FGgESr0uD0I+gcdaq8aVqiFBUzYCaNjWby9iaXiYAtqw1ZJVWju1QHxVmotxTib2CcAUYwtv9A=
Received: from CH2PR05CA0013.namprd05.prod.outlook.com (2603:10b6:610::26) by
 DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.16; Fri, 1 Aug 2025 18:19:09 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::8) by CH2PR05CA0013.outlook.office365.com
 (2603:10b6:610::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Fri,
 1 Aug 2025 18:19:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 18:19:09 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 13:19:06 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Allow static metrics table query in VF
Date: Fri, 1 Aug 2025 23:48:50 +0530
Message-ID: <20250801181850.1712440-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|DM4PR12MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: cf29d892-81a4-4c84-e12c-08ddd127e879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IcqcAHK4GU4oYhEIdShWc6WAOtH4sI0nSZiLuvuLQW3TQm3I8Y+OJtoGlDCI?=
 =?us-ascii?Q?SZsQKcmi7/EUjk3R65hJH+m8u2GhWMfK9xOrBXp4J8lqvNTz7UFS1KCA93wy?=
 =?us-ascii?Q?mrsOIt9XhYeXjtWgNozKgDh6boppoO8BdC6ZSfRK9uOoiw468Tcks7SAv/qe?=
 =?us-ascii?Q?pJI8GBOmbFyxTz7knY9+hGUsnj4Q1DJP2f03i0qhXPYcq7GtSmgF59hRu5QD?=
 =?us-ascii?Q?83M59GaNYy8a2vYlMbBo+zGh7audWm9kIXq+bbi7k4RuMw97TBBnR00qu40I?=
 =?us-ascii?Q?5QeSuqxmu9NvJt8gWgHiRqbr8m/kfztC3n9ZzDWiFQxDCMA5RqK736kuDBdW?=
 =?us-ascii?Q?znA/RVkMUwUwJQXvaeew+WoGDgjz3bFwSs64I+xEgCKu3oR2cY7DB4dPBu5Y?=
 =?us-ascii?Q?hO2Mq4p0zoYjMKa7PyFP82spjggdUwVh1CmZRIXhNUodiapwTa1WH4IqBoS0?=
 =?us-ascii?Q?lrgjJ6NG40X4UkaEmmuTGD1fa34/oAshCVVtBEbaPIAXgczqSlZPBA8b8IEU?=
 =?us-ascii?Q?OP7gV6nM+V60pZeYC9ShYWfHr7LT9Pd4v01zEPGZtUNV03hUe2MLkNVVlZOk?=
 =?us-ascii?Q?OFDG4l+1aHFTN0cuRMWhpfNMX1LT/ZLKb6SiTdAXMSqhH4uuQinYPaB89w4h?=
 =?us-ascii?Q?zN74MutN9MCxgvHr+xgO6IB0diJdec1Cx1/RYhgWMzq4TOgUCDaOWClYGD+7?=
 =?us-ascii?Q?ag6nQK1s5kWuev+Wh0mDpTfZH2VBgYZktnfMTsXcbebK4jbPc5EUretqrrBF?=
 =?us-ascii?Q?m4zI/QKCzP3NeFOn0KiRyuQqAMF7OP0ltYJklc0P/RmPQmQrb43dse4zyeQ7?=
 =?us-ascii?Q?NOyouue+gGbxeL5AVhem2O9M+IxM+ZdE5Tw4SJkX4Mwhoyj9pT87qbIWuSvK?=
 =?us-ascii?Q?EMOn62xOSRpn6khs1gN4ydfj/j3VJVb6+xdXhzgTi90khu1qOkwnR24WJmfH?=
 =?us-ascii?Q?scWhc4e74QzR1YzIpJpGv9XSgYlegsR7XIShN5SibTJJ5SRMIv6NzQ7Uhxg0?=
 =?us-ascii?Q?k7sMnEQ0fyqmqNTF/xs3Pcy8p/EwSUi0hBufwmO3/WaF3wkBc9ywPX2Dhlkf?=
 =?us-ascii?Q?JVx6FikUEbDQUwtIZu7tL1IlAmUXvxAJRNQ7rS6dPL/iZRfY6CXezk+zcslB?=
 =?us-ascii?Q?1B8Q0p2zUYG8ZDQtOn/hHEPjfPj/0ogP/s+M3AFkmg8q9iJqCAs6ne015HJp?=
 =?us-ascii?Q?1g2PSEU3f9j7MpyMbUtnlY/udcgWIe3KnYr0M/bHRjQpg4MHsNIcTJo2NfT6?=
 =?us-ascii?Q?5PJgYE3DSHK4xm/QZqW0Inu0TPLql1sPwfG6nIC1ADWNd7tQf8fBmyNSNk18?=
 =?us-ascii?Q?X0I5PwZZRUO5Z7y+9qx4YVE0ZUDtYvRqEOd7czghfjsHU79wKUvzPgHq2J9U?=
 =?us-ascii?Q?uKNvSRbCZ7hiaYVnCBZXw1czVyxEQyN9dFyTJiN2L2E4ieoVbwOe1XSnVWLM?=
 =?us-ascii?Q?y/6b2E6bw6kSu/7ORuJUAtbNbEpE98axr1hOXZNt3EBHq5yb6tnQpr+SZIGD?=
 =?us-ascii?Q?RxvpLiXy0tiY40NaP5UPouFXF3LS4Y8fMMMj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 18:19:09.0155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf29d892-81a4-4c84-e12c-08ddd127e879
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747
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

Allow statics metrics table to be queried on SMUv13.0.6 SOCs in VF mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9cc294f4708b..148941d7ba51 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -177,7 +177,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlingPolicy,             0),
 	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
 	MSG_MAP(ResetVCN,                            PPSMC_MSG_ResetVCN,                       0),
-	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           0),
+	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           1),
 };
 
 // clang-format on
-- 
2.49.0

