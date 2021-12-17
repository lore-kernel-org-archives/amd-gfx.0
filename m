Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF4EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7478C10E682;
	Fri, 17 Dec 2021 21:24:37 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5808C10E651
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AY4/tzLO4IvmuTdHhTjwlEZ61H2EoTF2uSn28tfoyjav5ZWYoutDBFNok132fR+guX05qShC9ULHYh57lWXw/KqU3P8EohBlNSek7CESQcYBtS1BVGZsRIElEUo6/uw9RDJfhQNoNxXYU05qS217+6GF4dyigAHqHn0VO2yLedpW+abd7MmvopTn6dPbohsyX2YDRMpV4uvSP0dfSJyIDrGlCqAlLM86n8O8eVM+PiTOT6+hNfJ6k1ljwZiwtQzT8V5OtWH0NzeOg74bVaNq13o4vRoz9FtdILpv3N3WT/0scPhLmdDGY0FSbhLZr1uMsGjZb4lrjI1HSVFzjvqBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjP3QiAzXIGC/LYgqXl+8s/uSh+k+/1VYk64p5ic/sU=;
 b=Z8d9G/b9bs7/vAeureXDBpYCzBq2vtsJVSbMQXk0PVrKbJj+HU59T+bg5fLbAkoXh39PUB7xQLLRBxlM1wwPvqdq+4wozqjmKZgE8dzjyFrhj1ee0T6Lvs3iPv9xV71OUpRXxcoa/jizmcBNBYmSVIGotG+u4uDvq+uaKgtD+UFpZfcItkJZnZhGHsmsuRCQOMSfcZUyj5t9dWrsGHcqrLs2vRqzUzqCO+dwpVgA8lcQP+qv1L6lrA0Orctpu+EAgtIH/JTcXgLBNH/by7RokkTK3/j/7JjPpRmipkX359dvQECCwbmgz1QJZ8PsB/6U9PUV27KGPQI7XEAQnM3new==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjP3QiAzXIGC/LYgqXl+8s/uSh+k+/1VYk64p5ic/sU=;
 b=3tlX9/1DLqibpvKeWU2jsq201EZg/TzTtb/ybhlilqrZRavExDy8hedUVT+FHq5Ab+OrNuXEB94mJ3SNRllJ19emg6blNBP2nLhap7VnAjZNb3ye58MCv9zbeb8iFGjXxhypEAdu6qeS7/ztyy57vAqMZ890zDwZ2Tn3LzGxI2o=
Received: from MW4PR03CA0144.namprd03.prod.outlook.com (2603:10b6:303:8c::29)
 by CH2PR12MB4970.namprd12.prod.outlook.com (2603:10b6:610:67::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Fri, 17 Dec
 2021 21:24:32 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::ee) by MW4PR03CA0144.outlook.office365.com
 (2603:10b6:303:8c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 21:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 21:24:31 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:24:30 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/19] drm/amd/display: Send s0i2_rdy in stream_count == 0
 optimization
Date: Fri, 17 Dec 2021 16:23:55 -0500
Message-ID: <20211217212407.3583190-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af164eb2-ac83-4001-50e2-08d9c1a39d9c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4970:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB49700A3D082AD4F4BA7166D798789@CH2PR12MB4970.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vabUYqqQostYLKcCfsS8RKrly31YAg8i7z4Gfxziw3b4kfyFLtIMxa/wAxE3vomnfH1e/gvSUVJxuBeiCU4VrcTRsHETqFhVWA+tpfx2/XuNbP4m2B03Vz9hMSqGMj+Tz3U6aJMerCJaA8IouFBOdd4qmwdf44rqx0ze7NPUx0uAX+GZF8uDBjxl71iSCPlLmi5SwXq86HRr/p30ZdOkVjeez4ERJnl60ZCj25qDnpJwJb92KKs2HpLOuKUOXKnXg39XN6/+IaFOPn+U2LcUUF4zk4Jb3OZ2JsV0Jp0Tj5kL49Q9yMJsf2nvU4cayBLrdEk0g90Nv63SzZ9Y3ErFICnCLM1s0QnBn//u+Ay/yOxCtlPFDJskiqUYiaUJI+0jIhrPzggzNwBtO3YFotdTtK1HpeuAMQKchdLSOPrFgbIAZjxXRJf25TAkSzw2JYh09jn0h/wMxU5vFz7Tn1NHdvKsTXq68p2O+1JdeRDk+TOjvAjfh8ijKyV1mrK4RfgC9or9bXoGh193swSSQdZD+9Lk3g7vuM9CoiIBqM1lsSmHoeYxf9Ea4PS2XPS5v5Ebawh+ycY2ZDRBWqVwXajj7Q5vfyS2xKKtsdN1D/3h1RDgkTRVzD3VnOx/yUrJyBSIJwq2VtVog/9EbnBVNO8im1dUGjhqjyBm/0h1rkM2IkuFCIsNVUOn6SPyz/EiSi1bADf/Vj0wk3nGjy0YWro9/DzNhd9w1eox+fuwDf2sGvpOpepz4u7vxCu7Mu8yGKc3QVsiGFlHk2iMBZxKmfH2w0BnN+xUJNOTKIIhJbg7Ut8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(40460700001)(70586007)(4326008)(8936002)(82310400004)(83380400001)(2616005)(508600001)(54906003)(6666004)(16526019)(26005)(81166007)(186003)(8676002)(2906002)(5660300002)(1076003)(6916009)(47076005)(316002)(86362001)(336012)(36756003)(356005)(70206006)(36860700001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:24:31.6014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af164eb2-ac83-4001-50e2-08d9c1a39d9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4970
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
Cc: stylon.wang@amd.com, Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Otherwise SMU won't mark Display as idle when trying to perform s2idle.

[How]
Mark the bit in the dcn31 codepath, doesn't apply to older ASIC.

It needed to be split from phy refclk off to prevent entering s2idle
when PSR was engaged but driver was not ready.

Fixes: 118a33151658 ("drm/amd/display: Add DCN3.1 clock manager support")

Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 412cc6a716f7..4162ce40089b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -158,6 +158,7 @@ void dcn31_update_clocks(struct clk_mgr *clk_mgr_base,
 				union display_idle_optimization_u idle_info = { 0 };
 				idle_info.idle_info.df_request_disabled = 1;
 				idle_info.idle_info.phy_ref_clk_off = 1;
+				idle_info.idle_info.s0i2_rdy = 1;
 				dcn31_smu_set_display_idle_optimization(clk_mgr, idle_info.data);
 				/* update power state */
 				clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
-- 
2.25.1

