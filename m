Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DB5C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 22:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0862510E192;
	Fri, 25 Mar 2022 22:55:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C23310E192
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 22:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTeAmkwZK1Bz+A/sSSNZMqSdsdXFvY0BEzKtoWCN70rPZndobBtzPb5bQPtZphoAwKHnzSmbOpLKfu3XiDPn4NUWcW33UOeB4bfW4yapqoUMZ/p30TRtoFtjbxsygW4a5xK5BAkltQwzadwOP/Kxoxw3NaANtaV1hyc1yACEn0u4X2cnRGSgTzH7BPwl5dCj8RqmCG4CMRjDqzjxvsDBiYPlEK27lorb2qATuzSmQFzlS76cxHDOIf7BHkGEB/bKz+NjMbKmgyl9QZhhW+whgyB/skoqEDIdGKX7uVRK84Ba20oA9F47bms+c1pJnm3I3uKnpH6U154D+IUIhVlzEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNOuhG6UNSlwA0rflE+xc/mzLaBk5mKRGDMHe5RI5NM=;
 b=hF1A3anpkYmRfm5aKdstQTIJMeSG80KyZM9ZSKqyptaKOQ//BBnVkkKbsNg9fJe5GJySlc+MHbWQxsC4lNXbaNFw3d7LpOU3txX9r7UXF20UU8QR8aIcqfsJB7glx+XPZdJf9DHG6qArGPU3Y/Vt1mBPAc2EckNh3j/SDzz2Ke2s8LJcJdHNfSjM3jIukVtUMIKJBl+cLix4iK/8KzcmrBsZ6D6InqHxW1+o3UpWeqe633K+cnqbnjcwuc/fviCFHs9V4kdvgH5owROUIcLKm9RjrrRqSWox6bqSYVdzxzAtjjiPTmq/sNOfBRYZ9IO2t8ZbXs2CLgbvZisGLJIqKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNOuhG6UNSlwA0rflE+xc/mzLaBk5mKRGDMHe5RI5NM=;
 b=LRW2xcUA+zdkMnh/EZxx/jDle8X/RNQq0Yii0ffrKzDg3DpUvB1mBZH6XsPg14JcEC0JgZwO0F+HMVv1722yfvQzVAjZpjM5B242q6uD2weedWdedvg6WGCvvnK6X325Mv8B+x6RpOW4AZewRJg6ZcYfZKPZkaTx3XsZm9Z/KIM=
Received: from MW4P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::10)
 by MWHPR12MB1312.namprd12.prod.outlook.com (2603:10b6:300:11::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 22:55:13 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::97) by MW4P222CA0005.outlook.office365.com
 (2603:10b6:303:114::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 22:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 22:55:12 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 17:55:09 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/16] drm/amd/display: Remove SW w/a for HDCP 1.4 1A-07
 failure based on ECO fix
Date: Fri, 25 Mar 2022 16:53:48 -0600
Message-ID: <20220325225402.469841-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325225402.469841-1-alex.hung@amd.com>
References: <20220325225402.469841-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bcc7b16-104d-4552-31dc-08da0eb2850a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1312:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1312BB50F30954BEDC654BB5F71A9@MWHPR12MB1312.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nq+0kvRb1qxw0bQOqksYoTrIy6V8UGvKK2Z7tzU0a+OL8FLqPInz8Fxm+RVCBBXbFVspmO7UZ47qYdqtGQY9SaTEhbTwg7WYnng+OIYtDOWzf5PPlmMwWjWQD6bFi0Ck+jul7uyHbjuCt7WqFMEMtTG3KhytNMpnyPWTmA30PHf+R/xeZ7jmZrSRR14ibWcAJL1aROgPLTQNTm7LpWlVWXyjorrx3M9cnC1XkXWlSYtg7q/NITasACz9hXw4GOtwXckf0C6rflqFtOoUtzfx2omSGsXTyS/WAeqXW5ItTwpZipZmb6xiyl0Bl85A/SE0XL4IHGT6sSMGYxWTqYRGVHOPgpztItlMzpq809YbAaRzWdbre53Cq25tE8Ouh09vQ1ArqSrB4nFU+80fTHY55SJpg+E8ANioZmZwLxN9SQOf63EpEKfEXbgAKesUdKWNGdU0mJynVIXBTRBRHURrNe7PQBNxXu6+PeHfQdPBuzRrTVai5BujgnuCerb95fijvWbHPsbmS7X/B8u+qElkS5MfrBVWQPGV8tYfR0OhK51ZkO/5V6JPA5CmXiVFZtkwsgHiFFdZNLDAeElNHE/bM0J4GeuN69Wr9nlwR2e/AQraqaSgMPbEaOoTMX41fUI6MrUTiLKqNZp+Gc6EDsDrn9QdXZAkbYRKqWqWnEKkwFXz7tYMkL0n/5I7ir0hjIUWgG9ax5JW9iWkjgE0tS3WpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(83380400001)(40460700003)(8676002)(508600001)(6666004)(7696005)(336012)(70586007)(70206006)(6916009)(426003)(54906003)(1076003)(82310400004)(86362001)(186003)(4326008)(2616005)(16526019)(2906002)(81166007)(47076005)(36860700001)(36756003)(8936002)(356005)(5660300002)(44832011)(26005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 22:55:12.3477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcc7b16-104d-4552-31dc-08da0eb2850a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1312
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Oliver Logush <oliver.logush@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oliver Logush <oliver.logush@amd.com>

[why]
W/a no longer needed

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Oliver Logush <oliver.logush@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 3 +--
 drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index fadb89326999..e6f9312e3a48 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1758,11 +1758,10 @@ static bool dcn315_resource_construct(
 	pool->base.mpcc_count = pool->base.res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 600;
 	dc->caps.i2c_speed_in_khz = 100;
-	dc->caps.i2c_speed_in_khz_hdcp = 5; /*1.4 w/a applied by default*/
+	dc->caps.i2c_speed_in_khz_hdcp = 100;
 	dc->caps.max_cursor_size = 256;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
-
 	dc->caps.max_slave_planes = 1;
 	dc->caps.max_slave_yuv_planes = 1;
 	dc->caps.max_slave_rgb_planes = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index d73145dab173..d5c195749a81 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -1760,11 +1760,10 @@ static bool dcn316_resource_construct(
 	pool->base.mpcc_count = pool->base.res_cap->num_timing_generator;
 	dc->caps.max_downscale_ratio = 600;
 	dc->caps.i2c_speed_in_khz = 100;
-	dc->caps.i2c_speed_in_khz_hdcp = 5; /*1.4 w/a applied by default*/
+	dc->caps.i2c_speed_in_khz_hdcp = 100;
 	dc->caps.max_cursor_size = 256;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
-
 	dc->caps.max_slave_planes = 1;
 	dc->caps.max_slave_yuv_planes = 1;
 	dc->caps.max_slave_rgb_planes = 1;
-- 
2.35.1

