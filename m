Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3588C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96CBE10E3CE;
	Wed, 28 Feb 2024 18:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KOGnMAxk";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE6010E47F
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llcYyKpuwMCxyLqpQLwphs/YEVBqOLLJqcy8bNB+3ZcBB2/aLShzU7sKsrLepxY9pj/BXsVNmwF9MWGOHfO8jWlWx9BetRCnjSOsejm/NjLAdLkZ7BavbUC4J2OwVP3QJeUV4SLjryyEDy6n6vz26ugB3Ozh2t47fCEd6vJut0m0CpxBdglxPAqNiyc4MABD+gq2Ow7xb3xF+cRLxUY5IvZj5WT0uRio/nizB/tJKLg5acrOjpZ+o08R8Syh2dg2Qxb7AFVTTG0rl8SGnjR2Mhfg/sjt5FItluga2g6c30bAYL9PIBZrr/YPokSZRfQyGI/Bck6NIBWfzMfXiA0zVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HfXB18F20X7vre23/kWe1AyhblsXDTyKV1qUkZnsuE=;
 b=bYb2YQBlbGZ97r6PJBcVR40FoVV1fLCS/qovslfjKgimOq+NUHoUUv1/CW2XUXqYLObGE77wMespubqmo1tFgnYu6kBJrp5KtBDgi1Ct3df1SQpHW3d95IO/L07QcNjJTPlSsjy0qBzZ/CghzqnTflpYcmacLbSw7dcWN3zPcnj9w6Ekca9vatUkkIUJ/n0Tuv2n/Nb2J7GxSjYN565gRPoBqvcO8W+hAZO9oQsKrlQE89DUpx9MVuOUtEYz5Cmihtt0bZH/dp6tRCJeTptZ2WI7Gx1axrSFji5Jh/6lXismqQY3AHsdrTu748rTvl2a+eVNL8TaO0FONdigGSUjsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HfXB18F20X7vre23/kWe1AyhblsXDTyKV1qUkZnsuE=;
 b=KOGnMAxkpYNzbCLHiB1Z9up+PhGE79UWg4ol25aP0CR3EJ52AAruVP5fySki7Eaz+hB3HNtWpFW+UynbxAqnoEZ1+9UKdymJild5RTcymn8BnJXhb5BpYJYJFZ68Bte/aEAUgeetJDcdMgMCMN4cdf/D0b0k3spYQkVYJ+TOlUc=
Received: from CH2PR14CA0026.namprd14.prod.outlook.com (2603:10b6:610:60::36)
 by BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 18:41:28 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:610:60:cafe::5c) by CH2PR14CA0026.outlook.office365.com
 (2603:10b6:610:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Wed, 28 Feb 2024 18:41:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:41:27 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:41:24 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Chaitanya Dhere <chaitanya.dhere@amd.com>, "Alex
 Hung" <alex.hung@amd.com>
Subject: [PATCH 03/34] drm/amd/display: Add some forward declarations
Date: Wed, 28 Feb 2024 11:39:09 -0700
Message-ID: <20240228183940.1883742-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: a26c7e85-dff6-4055-f51c-08dc388cdf5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrngA6xbwU7m7Un5WGxyEcVEy4ah8A54ZrD/wqZhO/6jLDOuVKNCPE8VDnJkBHMt2K49iJT5ETDiMWXTf2ZjMMwzTbLlbMwLLjsa1sFloNTGy6ceQ2RtzSauxZPndMwjP7rEqbJCdxcInRrje95w14Pzme5pGWs4Ba8KzkiX7kDhxW1EABqyCjLmBh6BSSC0O3Q11v5ZywMV0BX0R0gDkNu0P2N5QZ05tn6zSb+wQN6ZCoDRl6hHyfF0JzfdvpTps8H22lKoEhpRmCpyC378V9UuvMbvrw/97r8Fmc36Mfe3nDiWT7kLYrWo90cFlkpLnxS9jgp0iWgSHLE9gzcJEgXwP3LVjLevS7WEA71Gc1fS7zIWaEjfYDp2Sbql+vFI0+spqrYTaJvyrTXN3A+K8RJftLsFyLTwjKJkEWcDr5GvIaMrUxO0AFCU1kWX7K/0wYUTSpLkQ1OzsUg94YzM6QnRNJcZ2WgvNfHafFijBm4JKhoy+ACaMisfOYnLWp8zK6pfXNamP7JlyDwLcj+vQg22dWicRlpiGqnkJC2e5dpKGzE3W1GkyLleuVhzPCo/qVKGh3yskU/JsqAUs6/+jrCmIRj1aaKhdYtXMDjSiqszQDc+aLBKg0mLENmxdX/RcAJJfkD54ZRLvZ6DNttg4uzQkjHDUWtcw59b7uA6+Am/C/+8asArxhE5ML4yjJzUR201UzcpCB3mC1z+zGFLF3e36auQFj2Lp7biSf2qZRu4ozqZ5kN5it4w1m1l1jeV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:41:27.2596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a26c7e85-dff6-4055-f51c-08dc388cdf5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[WHAT]
Add DML2 pipe and config struct forward declaration as a
preparation for DML2.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.h
index 2f91244a7b01..1538b708d8be 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.h
@@ -30,6 +30,8 @@
 #include "dml2_dc_types.h"
 
 struct dml2_context;
+struct dml2_dml_to_dc_pipe_mapping;
+struct dml_display_cfg_st;
 
 /*
  * dml2_map_dc_pipes - Creates a pipe linkage in dc_state based on current display config.
-- 
2.34.1

