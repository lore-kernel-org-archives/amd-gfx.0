Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7844DCCA479
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 953DE10F383;
	Fri, 17 Jun 2022 19:35:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AFEF10F369
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctFhnD3VtK3509KzoBILXAx6G48OI0hMOiu/+N2QpePD7VGncRdm8k7l2Kn4FWgVPkSYBe0QYfmwSy6/mi4wLc5jVltriv3lcWwB7Q4QBQKvb4zM4gjFjpVsrIXVtObswoC7+gFihq32yRv2NcBVE0MMXdZFTZhSLNkkofruX5ustYgM1ss2CJn69dEZ1sLN0O8MPpT48YQ9PeiwE9NdbVZdloq0MWNP6O9ugsf3DVhPiHr03J/oAkEi9MkixE+0cMwQ6QBjM7d0NP6vK+M+Dj9GE75YKVBsbxfysi5SA46PF1e6ySc45PxbT071+B/OpYUomgmqaOSg3NCgisKhxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5I1OngqFpC7XY8UZHJ/lWQphmkYuEL8FSDtxIzPi5g=;
 b=Ck2V/uMcyVGR64MMNonqslTUN2iD5nGElQzrP4eUYhH+KdVddmMgNjpOEQmV8eoLCjTNcuLU0yMUVAkfrCvlbGQAORIO7k1ucrn0z1ggfgeJQ94oH0ziYW4Pl5xyQ12R5CgaE8dKzyVWwwZIZdH+jvkEY+biKndIWf0Jkdu3t1jIKSHkJhp9TWiA2BBonE0VVWLNhNZXaR5wl2cRIFb3k7FVZ0xDv9GgRp07wAF3YWB3TCcmV1MnVBKJ3d+D744tkKwX/BaxylzLmjzb+SK4kRLiLYtj6INCIAYNgJtwk9HFf3Kg0wRLc3XBy+SLiH7/bt8SCI8pViQnKFkjePiFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5I1OngqFpC7XY8UZHJ/lWQphmkYuEL8FSDtxIzPi5g=;
 b=dAIrGgCEshdnXBMlppz360O4xsaL6hmthNhFnp5YphHHs8DqRmmW5v2Ht4Zwcr+uNsLkqFMchlsN/ZoJWlFg/8iBzrAxkgQxYjZC8zhEA2CqQo7rSGXt5YiTy6Zi08mg8gq/zet7SIE3h1qNAfhN7eAru+jupw7YuKPfkn/FUa0=
Received: from BN9PR03CA0146.namprd03.prod.outlook.com (2603:10b6:408:fe::31)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Fri, 17 Jun
 2022 19:35:49 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::d0) by BN9PR03CA0146.outlook.office365.com
 (2603:10b6:408:fe::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Fri, 17 Jun 2022 19:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:35:48 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:46 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/31] drm/amd/display: Fix DC warning at driver load
Date: Fri, 17 Jun 2022 15:34:52 -0400
Message-ID: <20220617193512.3471076-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f1ca643-d187-4e62-3853-08da509894cf
X-MS-TrafficTypeDiagnostic: PH7PR12MB5760:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5760D4F01326575500A788FE98AF9@PH7PR12MB5760.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFu0Iekez0X1pRMigW/ZkI+FxhfIuW9w5Fr3c/w9n5IM99gc32UAZpFwPZIqJDNEqaJ0mWYjdoR5BimI9Lous2ETVLzxTH6zauYoYdOTR4nAOdBdBcLl2mHMGb7bZDt+yK6JSFX7z4px51stBx9+TNF9wXKjxcFuGcU+aov3IIQJGCRyIeITzT7oBG4t0DtVrg+W+nj1VixlDEeq8I/INnpYZJR2iYuc8GfQMyTMKrDuk7MPaDxrfvzUhqFkM8X6z3VXB36BJ6HP18AE2FCcKuOm5qcwYfdP/EmhS4pBNsIWZGdEqXkW5Mvn1JhcpXQ9q8VxEOY+OWgA4bx6GujMK8ICsHmHcxel0uOhDRzqH0Qd+H3xujByFBlVVPSp54ltghxLlqGh0TOT2Nv4rTcLh1jGO+1GS338KPW78mdx8s6Z2NZg0Gv11DB7yr1FdZE2bMn/P+ymSJNUWpHmBJWCm7XPT5yYEeTWz7RqcvWoSMcpJOGirSSgE1EJ4c72nC8uM7RyFtziQbyjBZusAGRV10CMbBqJIJ1pn7PF2pYPr0AYcQO7UI2F5ygUhC72/VkkcAnPX03x1ZuwpHgUbdzkiNnHYmMV4a90w30ggbWLD3exHozv/dUPQIAoJJXkSn7dmnlpGMPTyMAmot4g/XL6O3tM5UXK1ckWQgH3elKu2y36tQUl5Lj/Z9dWuud6NPHGPFsVHoaC+rs5Ey65LPHhGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(426003)(8676002)(40460700003)(4326008)(70586007)(36860700001)(356005)(83380400001)(81166007)(6916009)(47076005)(86362001)(82310400005)(26005)(54906003)(6666004)(70206006)(16526019)(336012)(316002)(36756003)(2906002)(8936002)(5660300002)(186003)(498600001)(1076003)(2616005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:35:48.7580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1ca643-d187-4e62-3853-08da509894cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why]
Wrong index was checked for dcfclk_mhz, causing false warning.

[How]
Fix the assertion index.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index fb4ae800e919..f4381725b210 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -550,7 +550,7 @@ static void dcn315_clk_mgr_helper_populate_bw_params(
 		if (!bw_params->clk_table.entries[i].dtbclk_mhz)
 			bw_params->clk_table.entries[i].dtbclk_mhz = def_max.dtbclk_mhz;
 	}
-	ASSERT(bw_params->clk_table.entries[i].dcfclk_mhz);
+	ASSERT(bw_params->clk_table.entries[i-1].dcfclk_mhz);
 	bw_params->vram_type = bios_info->memory_type;
 	bw_params->num_channels = bios_info->ma_channel_number;
 	if (!bw_params->num_channels)
-- 
2.25.1

