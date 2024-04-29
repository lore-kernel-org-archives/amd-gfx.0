Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48012C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 02:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8354210FF0A;
	Mon, 29 Apr 2024 02:10:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nhKajcHL";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E124010FF0A
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 02:10:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzM3hLWHSSOL6mq6S42BG57aStYtHjNderYv3tf2u2m5n/MBwnPqWergdPw931LThoszC/6UbFYN0fyZi7R0pG7Te5Sq1Rxo407jxfIxN5DRsoJPgfwZP41gAivRJi//5uJ2EqaDSwQ3Bi1jl895T07vTVo1f1N08UA0EeH3qxWt5hQ4bLVWbgCmIayyECSHF4d5xSQubgMzHvoxauDEEwlijlDMirQY1bGSmdnd15SWtmJ67YsP2vPhfdVYvCPL4jLjr7ES9FvHahMo20srgx9M12oubcbphAoQLWHujlIX9BsaA98F3gQA3zZUJS5xQCXprK5KW2V/KT3bED0KJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BoeN8lNWIR7bF1RS2w6siaEZBqBokXqjC33WIkMokY=;
 b=POSTv32BI12Tni8V3WIpqBADdJRZksX8r0dDscw+ZLeU+2BIqVugyIe8gdNz/5lV1kuwcIbqy6oySdRzBv3ANWQ7YIxA507ikMv8GqWXw2QUEGvUDPzCzTP7jKgbn5fIhRzWA7mZ6NHp/N9Aot5ErfSvmdfWMAyvzcHt8uQ2zmdvQpZDE7Go+9x9NmDE6Tx76Qo4XKCGavOHG0UW0UNOaYzywTlEE0ko02GyQPM+zKt6jX4CaKozMiyoSb/QrGTJPesay8Wpz75jpn1mIe1ffbwAv+panuZufIBH3orampuY0VwE/ELL3Sg3dauhg2UXdjam6ic4g7K6DHGcLHOeUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BoeN8lNWIR7bF1RS2w6siaEZBqBokXqjC33WIkMokY=;
 b=nhKajcHL+RJgvIEjzUDbz4RdG6LJSmfPlbo/qcSO9Gcg2avajbVCIvxKIGcdQShoKvNryK26lSwFteQFxlTwv6zdddEB6J88GLjzO1/ELsLssxnwxo6DSxlso0KyFdlEp4nSukbUDM98frIyPVq+sQRuFWC/dqYMXJR5XmA0cVE=
Received: from CH0P221CA0032.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::11)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 02:10:34 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:11d:cafe::68) by CH0P221CA0032.outlook.office365.com
 (2603:10b6:610:11d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 02:10:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Mon, 29 Apr 2024 02:10:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 28 Apr
 2024 21:10:33 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Sun, 28 Apr 2024 21:10:26 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 3/3 V2] drm/amd/pm: fix the uninitialized scalar variable
 warning
Date: Mon, 29 Apr 2024 10:10:26 +0800
Message-ID: <20240429021026.2059764-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|LV2PR12MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: e79b8330-dbe6-4af1-676f-08dc67f18d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400014|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P4n2bILx3wHGCfVdRc8/SSj3EEcTAmwbOj+sYIm/o+j+9196wqPolIK+EcNU?=
 =?us-ascii?Q?xw3cGT5i7tmTAvReaouw9KoXCCdlEYWArDId/QlrdqxcGmsQOZ0eFnw/N47e?=
 =?us-ascii?Q?Yc6RKT/NhfLTXrRrPZI0qjDUBCdriregmWnX1zKo1q6FyKDvJQ49yp7c1VGh?=
 =?us-ascii?Q?wfprYzbIYwpD5vIkdt+jyJsH0MU+NFJfQBh1brm7qJQo9KbwIb9T3IdDW+/Q?=
 =?us-ascii?Q?ZQpL3ow0EKSW4jbYBHJZQ++MYWChNJoXyd8ouJfXtPqcdbA9o24iM45kQ6oH?=
 =?us-ascii?Q?AQG08Zv2VXxLxHwUIJFCqCSAJVw6K9KnIcFXrlZdAolbubJOu92XKwQpxf3D?=
 =?us-ascii?Q?Pk396SWZn5c5zgCk5djbynVZIO14GHRSBQ1Z+TAiaFczrKlt+z35MNSrZfGu?=
 =?us-ascii?Q?l7ATTg70iMZEHD4LyD2BI6OUYYdm9FZKyf8MG5MG9AoHa98aR7iHytjskYNp?=
 =?us-ascii?Q?b9R4ECCwlDgdkCmwq6enZEB9gToHtRhE4a0QJH5/MLajoZh7gx0Eqq2ZETlX?=
 =?us-ascii?Q?B9JO4XacDDonbP2Y9/2f1O6r4mIcThE5RlTagrbOsB4+XF5LSGZNvtc307Oi?=
 =?us-ascii?Q?635eApHeYzvbdJZ5XS4hv+XfwenYJguNFAusUNofWegOGowHwPV7R7rKGJCl?=
 =?us-ascii?Q?EUyLsNGNYk3mG5bf0T8wXi20M4zTETyibXhgzZ7rRlsfgv3x0/aAY7lbgGdo?=
 =?us-ascii?Q?ILNNviCpKOI9v1DxtWiWVxv4qQ1c1hy74uIguvY/Krmn56VSXaxQ+Xko4qaj?=
 =?us-ascii?Q?Fv00FnNwKVMdnzGLLqyIRwo8rWuu55TL9feeExw8vf4neO5rX6N5EbnX5592?=
 =?us-ascii?Q?BK/D59xj2n4JabaNw5O1XodRDHvmaRGu60OvOiqS2LlI1+bqP5u0B1R5VLmz?=
 =?us-ascii?Q?q0GNLlOsFWOgJveyC5zofCbfbO+a7GiuzwbDEtpwGUqvTkxRVEIdBG+xfv7b?=
 =?us-ascii?Q?ED9hlfbbvUcoYbkP5NVqQLyczPcW4ul/z1HTwHI9yeYxe+kn6RIqfGG/lxcz?=
 =?us-ascii?Q?U9qdU+FgYz91ZtdLvMaA/ypSNr3xLntQrb1DwVjqJS35n5ZSIUszI/5Wkyto?=
 =?us-ascii?Q?V+0VfjSbDSzoMhsyf4axpX/kDlcEyTB/qlrWkLVdqVAXxd1xMZy8teiPPM72?=
 =?us-ascii?Q?eDKTXm4mCueHvIixFa2PZqVVyoe4xeBPeNefr5PIxf4iyiettcgPC6OboXjS?=
 =?us-ascii?Q?L7iSXK3monMEvkNd8iSHg+FSge0UN8FfRQedQxI8MdLaMM/K+o6Jo4yDHzEd?=
 =?us-ascii?Q?jUh04046K6TSEyxsEEw6x44iQtbLmwxUjOVofpc69/FbqDWkJXviaTUifDje?=
 =?us-ascii?Q?JsXtA/imCClFtbRFgtWW3UQ5MFC354sTyznmOxd5P5/YRNOC8NFQg7U1p22i?=
 =?us-ascii?Q?dbpcVcN99JMMKGJZs7unO56vh3ck?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 02:10:33.8776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e79b8330-dbe6-4af1-676f-08dc67f18d8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895
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

Fix warning for using uninitialized values sclk_mask, mck_mask and soc_mask.
 v2: Init the variables in the renoir_get_profiling_clk_mask(Tim Huang)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 8908bbb3ff1f..546a2268823a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -253,6 +253,10 @@ static int renoir_get_profiling_clk_mask(struct smu_context *smu,
 					 uint32_t *mclk_mask,
 					 uint32_t *soc_mask)
 {
+	*sclk_mask = 0;
+	/* mclk levels are in reverse order */
+	*mclk_maks = NUM_MEMCLK_DPM_LEVELS - 1;
+	*sock_mask = 0;
 
 	if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) {
 		if (sclk_mask)
-- 
2.25.1

