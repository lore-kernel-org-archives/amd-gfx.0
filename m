Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC86C61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A0F410EFD2;
	Wed,  2 Sep 2026 05:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5FCFjX8d";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1BB310EFD2
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:08:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6+TmqRh4cGPKAFoJhBe0mLP2kGi2DoMrWj5MoOHRZyJKrvWSVtthsIuQBwlnNFsmjc6pkIG5i12wiudOfS121spJ9ySHWa6OqcWHoF7rVQoGe34IYJCDkJAGbF+yQ7osPYXx+1KCPmqHqlwsvae+g1qFIfVSv4WDmp7lpd6TBIUYZFqxo+I6+19MhSXJFmrt36Q9ilUWdh0Y72Lq8KJNch4+djL3xu/JeoPgdWDaosX2xxynkDTGSnebVOVaXxDEY3mexyCHzyt1Z40yasCnsGc1lPA2Tkzf2GGdVvWYBNijQLy5ecnriBvgllfTrG7tJtMzZtQCn1GDC5GTD8aSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7dHvB+tldv0PXh8GeAFBl307idnE/ydWE84xEsGq9s=;
 b=fvedf5JqywoRaTVthRAxw93y95w922uuRa4asQiUt/CY3/Z1NNxmWadtZAOij+EEolZKuwSksTnQKx0yaHO4HXtssVieuXKYLjyLhgRb+UTbZVWUJASPjfNk+dbDRut8j5nh76BvLQaKkdEQPGnTRrNQYpVK9aKPi3ndVP9QemzmRqt8qNDJWLkjRREybkfT03j9ALlZ+hrpAQdVkCDk5Po+DRDWmwq2iBYtsJSS9HnzBKzZWQ7oWrpdazYnpXtM2c+LA+ly4c9xsmuQMVQjalv65CU/D7we8TtDTePPWnpgOOEQmtRM9WmAr6EyZKUIcJaP7+58KXsjiEqfODsYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7dHvB+tldv0PXh8GeAFBl307idnE/ydWE84xEsGq9s=;
 b=5FCFjX8dMyJSKY3zkV2iVjCRajUffr4v5Me90nyQGJOXW8gDdXOdys5J02n62m+gsyvYHFFyoSLqr5cjfdqOc3C80WMajTXsdrXv0/9IL1PeWth4eF63d7QjPmN9CxFe1leIBlzJSoJh0RiTwc6NZxux6U887KOqatQwg5jxoko=
Received: from BN0PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:143::13)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:08:00 +0000
Received: from LV8PEPF0000006B.namprd03.prod.outlook.com
 (2603:10b6:408:143:cafe::1b) by BN0PR10CA0011.outlook.office365.com
 (2603:10b6:408:143::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 05:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF0000006B.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:07:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:07:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:07:58 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:07:49 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Nevenko Stupar <Nevenko.Stupar@amd.com>, "Sridevi
 Arvindekar" <sridevi.arvindekar@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 24/40] drm/amd/display: Fix DC Hub reference frequency assert
 range
Date: Wed, 2 Sep 2026 12:58:46 +0800
Message-ID: <20260902050411.3473916-25-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006B:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: f73b0460-c691-46a5-0227-08df08b02826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: HpO9bz93whjxDkXCjxo9f0Ik8R3EomgWSeHg+RPt+ANePXE8joj7SnpRAQiiskTdEyLWZHC+X8AtmpWgV/99JSjP1spOJPwZuIBa5JYmWkjke8BqQC+cOZ60OWa9EEXILWG+kEIwe+MyvP2TaZzgYA2VLwQrqMmnpCfAw8Cy46XESHd8K3A/Mo+bj78eytgXXyuoHV4h6BBgzwVqhekcuYmoXsAdudBs+kRROpAfakTzCh6qNxEeCzIZE+26r8khTiVs01VsmZ4BiKVqMyVSWBu2e9c/95UmcI8q4zZleDvuI0rT+Vo/hVIrzJG0Obqb000lNUczVaoMJLZi5co29WcYnvQZLQ0o1Yte3jR/Z56cSH4FOUz5W65bkZFet6CTbzyaKD/tZS5SgvpWpW8Z0m4hIFdFa+aJueVXquy9xcooC+WD7upKd8bkDHuAPgREiFofOYSDHq9PywX1/MhdC5JJQ7mmbeHZkZjvBZe9t8/7c0oE78ub+nvuToy4QWuoz0BaEnThWxn1JMLq4oWILca7w9B0sJaq6DsIOYYpxDvgMvrGiwWRRxRkDIZdX3ejRysRCXv9oARKwT49MNL7hsNU0+5RGsRGS8ZF+oEXt/Dyi/EQEMRjunbyExCKJIMPrImLzzcv50iGCjpO58x7n1QeuihydcKAU1CkS0Q9/boICRzaWb0APxJcGuv4MmX8vRKqJY7//jFtdfJulYD22A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M1pwYRpwnVRc3b0p3TF8gkmWgMtXKRXvdkEIuYufvoCDxQaZvyKc7VXyupic9j8x1Pqh6/0W/y8XGZ8oPzc3QF/IzzNdbQWaC9UlcJYxE0Y30IejW2tYHi6clw3XysJ+v+NXpiN1Gvnyv+nXe2ohK8g3Pg4pdOP4SYVf2kXiGcsi21He5g2S3aSYpWP2UL21w6HpN+atEGRjcjEfZMxVPXo/3goQb8pOIPaGLUFYstyVd3MuhwmbmllKjKVqA4ZhMBTXg3JYWfTZLBGADMoH/r0vLMzcEt4VKRU/et7On0vohd4mKEKfOTcUe6HvoDrsf+UQnNBC+eyKtu7DHQwHwPJBx6PnRK9XCnFSoG2L/EO19hzPfPnE2g0m5McDXNbfouAZOdX7n9o8AvJJ4/ikzO1NrgAF1PYRGYbpGy6hTU/X7xM0G5HT6TZq4pcL8Qtc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:07:59.0323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f73b0460-c691-46a5-0227-08df08b02826
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000006B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898
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

From: Nevenko Stupar <Nevenko.Stupar@amd.com>

[Why & How]
The DC Hub reference frequency valid range was asserted incorrectly.
Correct the range to 20 to 50 MHz and update the comment accordingly.

Reviewed-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
index 053a08b6d3a3..9fb2907361c3 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
@@ -574,9 +574,8 @@ void hubbub2_get_dchub_ref_freq(struct hubbub *hubbub,
 		else
 			*dchub_ref_freq_inKhz = dccg_ref_freq_inKhz;
 
-		// DC hub reference frequency must be around 50Mhz, otherwise there may be
-		// overflow/underflow issues when doing HUBBUB programming
-		if (*dchub_ref_freq_inKhz < 40000 || *dchub_ref_freq_inKhz > 60000)
+		// DC Hub reference frequency valid range is 20 to 50 MHz
+		if (*dchub_ref_freq_inKhz < 20000 || *dchub_ref_freq_inKhz > 50000)
 			ASSERT_CRITICAL(false);
 
 		return;
-- 
2.43.0

