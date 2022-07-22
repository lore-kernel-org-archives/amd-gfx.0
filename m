Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB93C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC77D93937;
	Fri, 22 Jul 2022 20:44:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F3DA938BF
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LduK1pAD5VkncTtGL7lscCHIV2VdSpawmT/u7mqtIg+iVOJS+KWTttz08oChIMCwxC+yQQKjyScDxW1FYsf2GPh+GovDPaxtMvPmJpmJnqvZHSgxjH+JfgqO/2xXD2jj7+71c1kT4I1lLXzeEz2Nu7L9jRvgii5ghAG40ZrS3WgFgUx7snq3rbdc3IZ3NDxkvh+h/ln/2O7mT7R2t7SYSxw73LONK+qgZRLWpYQp2Xa893oQq5RFvAhH0pR2ioFvRmyrd1V95L9853cKz7OlZ1c11T4NsLsCGdLewknn+naelRKm8gFji17ebf//JHVZAZyXhm+8x0lPON81YkCiag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZklcLKYET3x8gxMT/WAntu4FR6H8UvY270Hbeq0bts=;
 b=BSnJN2ayHCEQNnVHtIxlu/PCK8SJBoRWVxBRttHKaPyc+tK28gsHjtMNCDMcVDYxreIEOpWpvTYtDC9PuT1cGZu0JitF50bU8w/08xuZ9weC8wJjsIrHp69FqJDB1XzYfFmNc6rP25ImYQVxVZi/lLmvk5J300Xag4CBgRw565n33AflFOvwUygoivBXrQ9vSnbw78b8wDR7htKR7PgfpHr+98JsmsjbeajWGtbf/PCvGXiT8rzVv/1VB1QS7zDGqYHJFfhYj3uVH+1PNRbkZyuqV0hNAGo1XGi61M2fRJ1CO9dUHJ1K3ik0EZulwTiyk7AfpoUUOtAYxrLBekT9dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZklcLKYET3x8gxMT/WAntu4FR6H8UvY270Hbeq0bts=;
 b=RFG+Hz0S3fn4mX2YHWxnzEYLGeJu9rwwUQUtqfXK/gz0liMJh6TU3cSPwF/6PySlZCacHxCJLUYpn9cK0esYp81yBMtYChdhTtM/ZtirTU2p/dWa9DJDLgyUfl8ruhA6GzD5HTp8MtkwoDJBgU74qtNWRPjHoaZadDNXxoZAICk=
Received: from MW4PR03CA0061.namprd03.prod.outlook.com (2603:10b6:303:b6::6)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:44:25 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::b4) by MW4PR03CA0061.outlook.office365.com
 (2603:10b6:303:b6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Fri, 22 Jul 2022 20:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:44:24 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:44:21 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/31] drm/amd/display: 3.2.196
Date: Fri, 22 Jul 2022 14:31:37 -0600
Message-ID: <20220722203137.4043516-32-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2db219e4-9b7d-4bb4-729e-08da6c22f68d
X-MS-TrafficTypeDiagnostic: CY5PR12MB6059:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTZwpdihR9LUTwHXsFBUKK+azNPO8T9GkxWX2weAvrF+boMHzfAvZNyKp1tKppZXB+XImgmibvkuEyb7LsPlTzS9a10YNtr9Gv+MGpOnrzRIKzREVGwFqOQj7PahAACcpCPopGxLOdvFtnHs3Lt+GagdbQQOtFh1K35Gzv2RSgOVhWEfqYQgQO4is54/ZBgtK8nsG4Nq6hZKefrlw75gbc2Lomk1//MCZI+/Tr6IQnz4QUsDgu8SWgXaVtgZKN5AvuD+X7DCeJvfzy1drG7j1X7EzYB+5yRvSHZ9lYkm0THRL3zVuGx2/9D1lPWCOE2l4Zm9BqAJzNcu5iEnOUZNz68MkDT+H+TkvpE4thw3hIH+tL2XH1toLqeS5O2GNglQLHZSblzBdWird4EmJ+d3J0hNZL5y1gShe90i6GGRXm9vYccLTbdsz6VeLAS/j3CBKWjz96R25H1Q4rQQZYrBJhDt+dI/t9yuwcehjAJGctJzQ+LbNG08dHTk5gnfM/6ih3Ei1Px+RQJI5H4i6nXy+uusbKOsQb2wHBR0E8r1oykYiiWQj8YWnt3Px0IOfi22CODMbfe5EeNGTvwce1U9UiYWuJY4qWcU8F7oJjpZ7nOlW9HmKHRcbVHdHEqntTo7wnS9rkZrsCLJZGxmHprjQYkyCepN/pNz35KSae1tm8fWyLL1QsxovrRiMXzLgcLI4FEXohpoCQLtWYREK7G74v+qMtU01Jz3UyZrSmcNEMHxg87MQXtnF3yKLPSWISBb+4dyEHanP6NpBiPPdW74J7ffpzUKMMHqs6rKyoI1PnitSztMNGq9KZ0p7wrBd9NDUO+qHmFVCrNEP6ELR41Ovg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(346002)(46966006)(40470700004)(36840700001)(478600001)(5660300002)(86362001)(40480700001)(8936002)(2616005)(426003)(336012)(47076005)(6666004)(2906002)(41300700001)(1076003)(26005)(44832011)(186003)(16526019)(7696005)(40460700003)(36756003)(83380400001)(82310400005)(70586007)(356005)(70206006)(54906003)(316002)(36860700001)(82740400003)(8676002)(81166007)(6916009)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:44:24.5624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db219e4-9b7d-4bb4-729e-08da6c22f68d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com,
 Anthony Koo <anthony.koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, daniel.wheeler@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

This version brings along following fixes:

- Copy crc_skip_count when duplicating CRTC state
- Add debug option for idle optimizations on cursor updates
- Disable MPC split for DCN32/321
- Add missing ODM 2:1 policy logic
- Update DCN32 and DCN321 SR latencies
- Add reinstate dram in the FPO logic
- Add dc_ctx to link_enc_create() parameters
- Cache cursor when cursor exceeds 64x64
- Add support for manual DMUB FAMS trigger
- Fix dpstreamclk programming
- Add missing AUDIO_DTO_SEL reg field
- Add OTG/ODM functions
- Use correct clock source constructor for DCN314
- Use correct DTO_SRC_SEL for 128b/132b encoding
- Add pixel rate div calcs and programming
- Remove FPU flags from DCN30 Makefile
- Create patch bounding box function for isolate FPU
- Move mclk calculation function to DML
- Remove FPU operations from dcn201 resources
- Fallback to SW cursor if SubVP + cursor too big
- Drop unnecessary FPU flags on dcn302 files
- Reboot while unplug hdcp enabled dp from mst hub
- Reset pipe count when iterating for DET override
- Calculate MALL cache lines based on Mblks required
- Fix two MPO videos in single display ODM combine mode
- Guard against zero memory channels
- Updates SubVP + SubVP DRR cases updates
- Fix OPTC function pointers for DCN314
- Add enable/disable FIFO callbacks to stream setup
- Avoid MPC infinite loop

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d05bbe193bfa..8e1e40083ec8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.195"
+#define DC_VER "3.2.196"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.37.1

