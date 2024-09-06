Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9962BCE7B03
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 12:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF9EB10EA42;
	Fri,  6 Sep 2024 12:52:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UBtkzfRZ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96A610EA3F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 12:52:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeK73gkRtNgy9wDEgjA/5ria3fAxVyQH3PP/IgAHD09thzuhWYQbH0GdPHB0clr/pRxgDnecFQmFbuCF39PE5isQbD4uDm4D7bEGcqcQjzg31qBU3wXK71JZSlsB3vP+YJymvvXLm5gu3cTzK5cB2HYocT5XFZ7WWx14U7wmHNoVSX4dx36VLr2ufXZHymklkWCLQLFFkajV2cwVcDeT7+GVsZMs+8SAk+9VnL0nW7aCkrksjTqcTyePn6AevszUNMWXn2di6eUpjOM1ZLtm0XvLljIdTHZd9vP2C70q7z1IgLJaju5CCryQn0ZtFYgxYMvynw/G6/fKyK7dZ7aEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Y89y0kalMxgk/OljySJwkbaOxeT1qe0qvRUvId2FPM=;
 b=PTFs64v5o0uI+Y4kRs/Dwci2aI9qowVuPaGMT3NU7nStccrr1G2SOBcYn5VfzUS6fLlVkY9bbWOkXZ2jX260EIWz+AEAVau3WBtDHjqHSHssUny4VugPhYEfteG2bUNu8zNJpXPcASCKYymdNaqGvscHaUiR4+QcP6EM/qgRla53Rj+ALaTXCgJD2mlSPpZGo/m4bC9bJKL6cB5+LI9SAjWJHsn30i4u1eN6JXVAoExa0Q9I1+7GJ2jBJju4hn6GSClwR4NaegkEF7+/bkJnoVLvbXY8qWdvFGdDerj372fGZ2394LM931ZwlUGDjj9nn/hlrfuwLr+ewy/WUTJ7lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y89y0kalMxgk/OljySJwkbaOxeT1qe0qvRUvId2FPM=;
 b=UBtkzfRZe4ldy6K49fArHSLraqpJjav1OdtgHkLJfS5wazyAdtnpYpvITqRfGKPRxqCSx+/O9R6TX9xCriwWk7eG+X5opDM9Hl7fXD6C0vScTTWPa3waQRDwMNgixx+fwa4ovpSqXKX33VAg0d7QflncQ+fYsB75+NTrEgBb6yE=
Received: from SJ0PR03CA0113.namprd03.prod.outlook.com (2603:10b6:a03:333::28)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Fri, 6 Sep 2024 12:52:47 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::5a) by SJ0PR03CA0113.outlook.office365.com
 (2603:10b6:a03:333::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Fri, 6 Sep 2024 12:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 12:52:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 07:52:46 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Fri, 6 Sep 2024 07:52:45 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix the pp_dpm_pcie issue on smu v14.0.2/3
Date: Fri, 6 Sep 2024 20:52:42 +0800
Message-ID: <20240906125242.263564-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: c981fd02-ecc5-4879-e224-08dcce72cec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1+Cz7p/2eh/1ne93tp3Yj8C4t6CfRvPYNwzUEuPAX5bWyPEuYGAXpwF7BjH0?=
 =?us-ascii?Q?AmSAKpB2wwdl0Uqe5WJRBUUZ9fZlFWTOzZ4AEeDKtSoxHsRHWDf4Le6l7iW+?=
 =?us-ascii?Q?nUT83LsT5yW5r2mDPAAjuygXflB+9SsobOHCGn0vxcCUQH6ptd8QfzKj5C8m?=
 =?us-ascii?Q?IWi6BtQx4BzH89vzTJG83U1fQ0GJ1KCcCu/DcwUDPSDFHVJmeF0IxsEUYUkf?=
 =?us-ascii?Q?kANUEv7GSgeNxLDdAaXpWjK694g/V9nFN1oV2+ErOONlp9ev8jqlKqsXbEz6?=
 =?us-ascii?Q?21l+lSWejoQy5IxMUN+hN8YG1MCuVzmck9o/gLAnNvlYLIXB67TA8MG/sQkW?=
 =?us-ascii?Q?4KNNG6D00bPfSN5F11jw99HHRDY3khH3lY85s+tz+LlUd3Xn70Pl3R4KhUr3?=
 =?us-ascii?Q?PwWbJ2oGrZf8tM+Ls/CLfgGA5ak0ZhkZqN/AB85Fd7XI3gM5qJuCtS1lBxw8?=
 =?us-ascii?Q?0OiTV9pia3LKNep2WGWp+odIS5tREXNqV/fhuRlAShGV2KvJkrPmRCT+BIMd?=
 =?us-ascii?Q?0gNk9NRekjn0TKMLZaZTnPJoTgqqTlBmYtLqi1hfohrafQMq6oWSYq3OX+yy?=
 =?us-ascii?Q?z2A5F+ZkB4717qJgP+W8AhSku8flVhzkJMX+lr7LqTiu4L/eNj+wsoLFn4br?=
 =?us-ascii?Q?WF0jlxeGmibT5EkzjN2Pcl0dzmHNOYS5/OACCOMUvxiwVnAuy4d0Fg45sLkw?=
 =?us-ascii?Q?yHgEZiOfN2Zpz/iHwO9U0haGH6F+Ng//8cre96NQgvYvxgBEA3qyxz7ahoxM?=
 =?us-ascii?Q?0WliK9hXneGE9BKauc5nF7VB8FMZQ94vbRaRivfViEEYzGkHTMJA7MieklD5?=
 =?us-ascii?Q?RY0FWfWGuUfSHIfAMJP48WuFFSFCQ9fImS0653w1nZOwudEdYryEb4AKSh5M?=
 =?us-ascii?Q?3BF0s/xBE3arheOLUWeRK28dQu7Rc0ElsLmmc59qBPTX7/9U5B6oIV5na3hk?=
 =?us-ascii?Q?+LZoTzhuTvGPqWz8cwu3I3dDyK5V1B29bxAoz6XtSNZ1I+ImcWNZvzWhBPbt?=
 =?us-ascii?Q?lu2Sg2m5MTABLPEnHq9r+HF/RAj0MXkNSnGAVkAM9zpw+9amzxN2jplKQ7qp?=
 =?us-ascii?Q?cYZmbr0ZJ6NIpaQiucyf8Z393pRb6QfnuMqmH/CY4gX5gBNAXR6cDa/7p7P4?=
 =?us-ascii?Q?C5HJFPDQK/ivkeKBn1xW0Ubi/Ismj24vBSf0LJbomQkWcxPpT13ZOJdV/OG2?=
 =?us-ascii?Q?66ukdd6dBl1aq8SUYby9QX3Agbl0fjacikziQH/ESRBzT7wQ1lIdYOrkEygK?=
 =?us-ascii?Q?ZgqQtN8lnVuUkijaGL39bIcnpEYq+6sPnubKQPr+j892gqZ4cdC6rkOZaQf6?=
 =?us-ascii?Q?dyLbV3WP0dg6PmixumNjvYwNMZDf5CwnaPdH6+o4R7FAuh+UU++mvVnG3ONn?=
 =?us-ascii?Q?Io/DROtcNZcefPPv8c13gDuy2xi+GhfbY7nir9g71tA+7RqKl1vdCvXig+g+?=
 =?us-ascii?Q?IvKxf/reQ41OziKmB7rT2oOYpkodwnCZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 12:52:46.9655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c981fd02-ecc5-4879-e224-08dcce72cec5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204
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

fix the pp_dpm_pcie issue on smu v14.0.2/3 as below:
0: 2.5GT/s, x4 250Mhz
1: 8.0GT/s, x4 616Mhz *
2: 8.0GT/s, x4 1143Mhz *
the middle level can be removed since it is always skipped on
smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index a31fae5feedf..30f6cf0d9555 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -687,6 +687,9 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 		pcie_table->clk_freq[pcie_table->num_of_link_levels] =
 					skutable->LclkFreq[link_level];
 		pcie_table->num_of_link_levels++;
+
+		if (link_level == 0)
+			link_level++;
 	}
 
 	/* dcefclk dpm table setup */
-- 
2.34.1

