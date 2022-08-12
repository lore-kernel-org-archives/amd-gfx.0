Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5306CC00140
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 02:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52D7FB4B24;
	Sat, 13 Aug 2022 02:14:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07EA8B4ACD
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 02:13:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMPbf0GccbLUe0ZGUZnMqzZiOxQDLON4UP29pX2pySFS0k43v1Z/8gkJdizZ4nnM0/zDxvUFCQnM0Hv12UehHyc2c1OWjoVp7C0lHh4vdS7CFCQUs0FqYSRSrHymfMsRyXCsdhzaQ6bAWTFJLj0MBDZq+g0J3Gbt55P8p+FlPFo2FvsoxrsEkIa5DTLTvkVYfwYF2v80fLhxuSVyACX5WGj5tx20k8DiLIMg1vN9cDzSj3P3pstsOxa5E+Yle0bFre1nWGsqLTZUzOZpJzRKZVy20VzoO7cVr/7iJ4v0cRCQ/Z8b8jYQKvKUS9JAwlkiS3ZqUeJT/gQgiu4D7/OfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIMbNvcihXtnaolIRVCPgpVgSBMgQ9RtJ1cH4i67stM=;
 b=eYlD0jiM0+qqAbu//4nKtxYnu7TTyucDQ4wmLkZ0JWbYkpeMv4ZaI/8eXol0yx+09KImayPkp1qndv4noMAWkGGLYed/JZJL4L3XMmxtUrD8JUvBdie7Mk+vC/48ZqC43eHDbUKy1XAKgvPlCjbB1JAoWEG5RWfkQNF5gUnGMN6noPLLM3qJ+lQj6EDaJ0x0DUvq2pcjNgF5+rYdaYaweHdcvdP1y5mK0JWyo8QzNfhGe3jL57v8lj1DqqHh8kmMJGl5n69HyR6X01m3qFu2JUZezQvkYpIPxfvUjh+vEhBHMpYO55f2vUEEucMrXP6f+xjH3gKP5dLa8MGWHZYJQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIMbNvcihXtnaolIRVCPgpVgSBMgQ9RtJ1cH4i67stM=;
 b=Zrgh63hGr9DRbqfO/GZ15VyNvgyrdI24hRaMEgdhapKzr131Yode5aq9xOYj1Ff4/cdb57Vd37HaP3IBA5rFLeJjXDVI+FEb892HYcuSRXC63syngRyskpZpKZRB3VXQ5W7qSoLhmz8qiERddPgzP5GZ/D+gzvKyVSgaN1NDi4g=
Received: from BN9PR03CA0078.namprd03.prod.outlook.com (2603:10b6:408:fc::23)
 by MN2PR12MB3856.namprd12.prod.outlook.com (2603:10b6:208:168::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Sat, 13 Aug
 2022 02:13:40 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::c6) by BN9PR03CA0078.outlook.office365.com
 (2603:10b6:408:fc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20 via Frontend
 Transport; Sat, 13 Aug 2022 02:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Sat, 13 Aug 2022 02:13:40 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:13:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 19:13:39 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 21:13:35
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/14] drm/amd/display: Use pitch when calculating size to
 cache in MALL
Date: Sat, 13 Aug 2022 06:12:21 +0800
Message-ID: <20220812221222.1700948-14-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812221222.1700948-1-Brian.Chang@amd.com>
References: <20220812221222.1700948-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a849176d-cb7c-4d55-fd83-08da7cd17074
X-MS-TrafficTypeDiagnostic: MN2PR12MB3856:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: miP8cpAPdkxBc7LfSKZ4kCsdF4z0tACkIenl5MOALsVCNhrMQ3upq4eqScddRDvi/RjOmmtq+SrIegmd+syG+CATqmx55D6w7vBfM6nacSrdf/YImQZcd6UV/MMWqfD8qLIbrCegdejc7r75KnrD1RUGIMtqzxxsKn+F20fxN10/Ggbr7v/GonzvhNAyYwa88y76vouln4U1OKrcCfYdAfwmstI62wd8YA6BtaUw9ILDOymuRSDWIKqE9Ia81iITcUAE9k6AUJQoe7eJExcOxZuG5yxxj1yt7C/jyUnAVCoZeZBlT445CwzGAK1fp1SL33Rm+kJekGOw3pxd0nyHEUkx2YkMZxX/7pq1pl80LmqyXyi8QasO7qWYyl3duTsZeISBuwxN5vN1rhzPUe0qrJ0/pAPD+KS5FBO/ZwKGcHS7C4P77k2NnYff0su2Rh5QvIGF3ousW90N4id9A0M0J0+7RbEiiJ8pOhs4s4p9RACjVpI6KA82oxaQXCYq5ikluednPdUT8H8KGZkWomZuPP5TZo4QrqeAvlou88PS/uuUA5Ixw9eFzS136UQ+JM8TsnHMYVJswPtYVv7++bKP8IW1ebL1N1vIZQJRm5m4NViQTU7HAtqgio7KjWo1zWF01hBJjA3jIB6ucMeJ2z1fXMa//kHOIFq7PFrUIjoL3mk2bxA6TUoPc07pyIfB2gE6UsEJcP6B2TKADX0nGnLM+TcBK+twjoDOhEh5n4uaudukVk29NR6PJVck1nK1ZMfLQ8pTF1ZppaZ2qisQSBJ67o9g8PGo7g9BBhgtZPyMkgPpjFPBz0+nb2Myyi5/OtMrsNLW+e0Ac/PEWs65+LOTYcmVXmye9wxAaqarol8bORo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(40470700004)(36840700001)(46966006)(70206006)(70586007)(4326008)(6916009)(8676002)(316002)(54906003)(5660300002)(82310400005)(40480700001)(8936002)(40460700003)(2906002)(356005)(36860700001)(82740400003)(2616005)(41300700001)(36756003)(81166007)(6666004)(7696005)(86362001)(26005)(478600001)(83380400001)(336012)(186003)(426003)(1076003)(47076005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 02:13:40.2446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a849176d-cb7c-4d55-fd83-08da7cd17074
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3856
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Samson Tam <Samson.Tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Use pitch when calculating size to cache in MALL

Reviewed-by: Samson Tam <Samson.Tam@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index b3f8503cea9c..955f52e6064d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -63,7 +63,7 @@ uint32_t dcn32_helper_calculate_num_ways_for_subvp(struct dc *dc, struct dc_stat
 		if (pipe->stream && pipe->plane_state && !pipe->top_pipe &&
 				pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
 			bytes_per_pixel = pipe->plane_state->format >= SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 ? 8 : 4;
-			mall_region_pixels = pipe->stream->timing.h_addressable * pipe->stream->timing.v_addressable;
+			mall_region_pixels = pipe->plane_state->plane_size.surface_pitch * pipe->stream->timing.v_addressable;
 
 			// For bytes required in MALL, calculate based on number of MBlks required
 			num_mblks = (mall_region_pixels * bytes_per_pixel +
-- 
2.25.1

