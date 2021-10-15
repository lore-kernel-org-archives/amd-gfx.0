Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CDEC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B65D61041
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B65D61041
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 130956EDDE;
	Fri, 15 Oct 2021 18:44:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 763806EDE0
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/Nmw/2Xj0sKapauc5tjPioK2hi6xF1Ecse0MHPwkEsP9XEomvQYSk5oc1DFXk+kgPTJIrl8ByByXjC8GjPPFYNgOoaGtyGuTOHX6Fna8/YyUisWvQdFZh0K5Sga8AASqof08NNWtrsLXJmUzZ6MzjuIrH9/uJre0YpZhqNldg4FeL6axQ5pCKigP67vsae6kGG89eH5k2li8w8pPpuDC/E+Iu/poYEuntia6ixpNsFAlKk8HSFvpP3r0W5T2TWnu789l/40YyYUJmjR2XO5uTHMfyJQ1p/xptmd06vrK+l6+2Iu+a1AmZVfi9QY/skj1TOaIYUI2LKROU+vrIBwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6nw4s6KatTgZ4+YD0Pn6f+PGC6trDLHyFwY88weJJo=;
 b=czj4gMU+oDAENc5qmMfoQI43Sq68VrK1VwYiTqGpSeFWaxquQZlrEnwlkPeyquTJ21oZlOSUTcilaMS+3Q0SMn8YimItFggGI1C/ZRpW8AUb2dfSxZiLmRKk6M75b3pdl8b1p1uXrh8Udt55N7ZNutVRwGCWlUqL9QsY6CiY8oBZ9WcC04WalUEDnoPzOnv1LVi+i8oA86zcEQ/FBj5h3HNxfkIu7Nwv8s3Sk0L5z6WV2H0pVVB0c3fcajsV4EGSzyGJPZughAY4K7OHeWBUmfP0vEC4X4k52iBvJO+m4TxL3OOaYRkYgawKNu85I7A2nPlSctjgypI7kGpn60g85w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6nw4s6KatTgZ4+YD0Pn6f+PGC6trDLHyFwY88weJJo=;
 b=0v9KSyg2FE3UX4mfjXjDqVfnHGwIiqco5S630qoaPeXAW2DQydimNFs1fOXPyr7suQWDeo+FwpZ1pcQw0tR6cwBIBpl55Qvqnc+4vB7BeNmEYxGXnVAwLpuWB5tNwtmSeGSP2APUvqfW3dHIfjAswjNfUopKrNN5cU22ijl2xl8=
Received: from DS7PR06CA0034.namprd06.prod.outlook.com (2603:10b6:8:54::18) by
 SN6PR12MB2687.namprd12.prod.outlook.com (2603:10b6:805:73::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Fri, 15 Oct 2021 18:44:05 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::cf) by DS7PR06CA0034.outlook.office365.com
 (2603:10b6:8:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 18:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:44:04 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:44:03 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Eric Yang <Eric.Yang2@amd.com>, "Nicholas
 Kazlauskas" <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH 16/27] drm/amd/display: increase Z9 latency to workaround
 underflow in Z9
Date: Fri, 15 Oct 2021 14:43:21 -0400
Message-ID: <20211015184332.221091-17-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e99c6c6c-b426-456f-3e97-08d9900bc36b
X-MS-TrafficTypeDiagnostic: SN6PR12MB2687:
X-Microsoft-Antispam-PRVS: <SN6PR12MB268708BC896A464BD398C386F5B99@SN6PR12MB2687.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FUc7K33pVZqtu0cU0DTmd+T50JqFw+tXzwOS6WBcQswXw/FDjpnS/YTkY4v9RqG5pv2elKhE0ilOJsfRgWFg+D2Bed+xiujhD3sIkvPLSuslKRoooj+Odp+5yoOrDs9PHiFGSV4X+HnP2mN+0olbwEITtac0G9MZE6wUvu2dVQl7IzBhkqopt210ACN6VQymqvd1zvbktoqS+wqMfYjFokY7KTEgRftLI68VuvQ+avpSenMcR5kkqE0xiAdJWdrmniqNw+gyaU2WR8rV/3zufS6xfyj3PjZFxavP6x1x90HnguWpZfUUgkEo1QEg+cYyo4dxqtierJ7E/hqvGlV0BRZfT8+N+gMJ+f+dbIdRclBpel4igLYVdnQeG0+vj383Hm/R8U2fn77jDCdpCDNTFEt8uvLefbzR656ADQnNRcDHMMLVxQt6nhVt5ruUV2zuBmqICJ7VHgMVOV/jt16Zoec0nvmncgIqXDMzz7iOQwTjaaf5bcP0jha8facA9fblSsDZr08E/JA6sI4zFfFdDpuS/kkthomZK31yP5VrIlUKyVUD2DovJ3n/y+vCUanxnvLPFLhvbbOwDqAEXkkn9D9anCQVlTPiI5zxqSGkNp1QaVBu0NLZq6/2N/GXG/GAMyFUmZoJau5SnoJuo2WovpELWg/l08gnmZSDQ61YHS5u36VdGPw+fTV4MWMCr9XexAU3szDqKm5HCwXUNMt4erUUG8ifnuqaRZUqmSGhaqU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(8676002)(70586007)(316002)(356005)(2906002)(83380400001)(26005)(36756003)(36860700001)(508600001)(6666004)(5660300002)(70206006)(54906003)(2616005)(4326008)(44832011)(186003)(16526019)(47076005)(336012)(86362001)(6916009)(426003)(82310400003)(1076003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:44:04.6451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e99c6c6c-b426-456f-3e97-08d9900bc36b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
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

From: Eric Yang <Eric.Yang2@amd.com>

[Why]
Z9 latency is higher than when we originally tuned the watermark
parameters, causing underflow. Increasing the value until the latency
issues is resolved.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index c9d3d691f4c6..12ebd9f8912f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -222,8 +222,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_1_soc = {
 	.num_states = 5,
 	.sr_exit_time_us = 9.0,
 	.sr_enter_plus_exit_time_us = 11.0,
-	.sr_exit_z8_time_us = 402.0,
-	.sr_enter_plus_exit_z8_time_us = 520.0,
+	.sr_exit_z8_time_us = 442.0,
+	.sr_enter_plus_exit_z8_time_us = 560.0,
 	.writeback_latency_us = 12.0,
 	.dram_channel_width_bytes = 4,
 	.round_trip_ping_latency_dcfclk_cycles = 106,
-- 
2.25.1

