Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D731FC46CD3
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B17410E5BC;
	Wed, 20 Dec 2023 16:36:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C1710E5BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiEbIGjXXy1ZCMtMSHLsCUgYF2F2oq7qSFnqsh1OgGx27Codxcyfl9GCxlN5XGpt6rvNrqnR+YgBnJKRXXhyJKetLhHbEZ44cR1apGeeseFH9qSIlOTJgghQiRFBcUN9IEnzAy5snlSzcpjv2nzDB2rlltM4ajyrpig1iv2FubDaLbc+YUb5fqG7m5uhRM99wRTHxvUoYKEt+5ZrbVkzm88B8l4obGRa8ayoARDzV7Tq0M5mivkzJNMmeWVrPQNfKa3v8VD+2uamNtVyVbAtFqpCM1wdCEjXkcFcP4+AEkLrveEDC9GdJ4jreArK2a94/UPWqo0lgpUhbimM6YM0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9n5NMV9UgI9C6M6YhzeVCfqHQPYV3zw/CYcunnz1gE=;
 b=Hn9T6ljcH6GusrmEjvDVBnETfrLbeJdIdKdT0LzDgKPrjDIwzgHTQhKKWWIl2MZUpCSmgxg+P/jDga6hkTUjkrahKWuz/8Ms8mqIZuMVM9NH7CVJ4YA8GhGogBDpJUNCgRmYqWhvNJSMqAaHMAraapsrHrzHRUaFxRa6xUlLt/Bmd1CCc85KSKoqail4EwMO74MTKpZIPUJ+Mv+voH+SytUGvtn/D8Wn7rrs3355EVAw/+93n6aF7X1oO01OuhIQBvMaf+TSMqPqZ0bOGtM/5wKCRJoXKSG6yL5dPUL997JhISDjedIaqXvQtKqPW/wpsws1T3qgtoVjoq4bdtN3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9n5NMV9UgI9C6M6YhzeVCfqHQPYV3zw/CYcunnz1gE=;
 b=J2ovJb702qkbyJw6OK1DKi7An//Sglr1lLJCyN4F+mGRuSalZ0I/s0xu1vm/B1seOmZfqL8D7db57JSAC/IgU/ObSUJ8exfw2veV9VmNui9CHY3UMo5MlW+lEJGIfTKXIiYA2AUuM1uhGNocYNjxhWztrqtiQhPSlWVMcSLrjOQ=
Received: from MN2PR07CA0006.namprd07.prod.outlook.com (2603:10b6:208:1a0::16)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 16:36:48 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::7d) by MN2PR07CA0006.outlook.office365.com
 (2603:10b6:208:1a0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 16:36:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:36:48 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:36:46 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/20] drm/amd/display: Add HDMI capacity computations using
 fixed31_32
Date: Wed, 20 Dec 2023 09:33:36 -0700
Message-ID: <20231220163538.1742834-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
References: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: 7847763d-c1cf-41e2-bc85-08dc0179dcd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tebiI3pu0+aQTeY7LTyBGGah9j9mXr9TPSgFa7txOMrYh3TnqoNAWJ2NGUgfBcFNNfhl/4yQLtEojeqTQMbI1GFQERhFsyaD0PMyXkqBS7y7iFS/XbZ/ihc8HSdDkjKRaSoBzX2QipqUlA12EX0qBz0KhJumA0XRI3haKm8BdU3dFRpHZetmjK8lg+rvNdzSHObad2t+qv6RIuNnV1Ap0Cb6URAubmtrngyH2/IeaIiXqYegIEJeM66A7uJUCNprNJpyiLSR2veNS/syVpcXA0S3evG9xuJnfDQmPnuli1D9UJe8SsVY9WzGL7H+HvlYTkl7TzHONeBya4udYh0Ld3zJiMW6Bs6KVGfPmAF8E+Zh38mt+LlvFoaKWhTSih9EnD93U7DnKwuWnApZ7JvxE+h0UfBaA8GSZ3lqxgL/tOd3tt3ExIrYorp4nbUBR2ebigJqNk4VXZvUfhynOXYDISSEbvmw5jU5GNHV5O2snoNpqRy68BB/RzUQCmTI/yemDEzBX8AK9f1wOt+Y4msh4uJTzwLeYPjLpO4uV/09Ov7feP7nYePW1lu7/X7EYdie2NWa6VCLlULA5PtCpBWjTDbzrnyw4CRdfoGvGsToUzTi6xc4kkVmb2M1WACH+4SKQEakzQKSF98v5j5V/oMDum5Q9qCLd9Ik6XxsKlFiyplMUOVKvzNMjIRsHkdYXeFCjUOCgiPBxJCfxfwt8f7EUMwTPlRu53Wk1MY64ApSUuxgFkhpdKGYmW1gWRcBoICRWYA/xqtu+WTfCcHiNWcJJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(40460700003)(356005)(336012)(2616005)(26005)(16526019)(426003)(1076003)(83380400001)(4326008)(36860700001)(47076005)(5660300002)(70586007)(2906002)(41300700001)(6666004)(8936002)(478600001)(316002)(54906003)(6916009)(70206006)(8676002)(82740400003)(86362001)(36756003)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:36:48.6364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7847763d-c1cf-41e2-bc85-08dc0179dcd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425
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
Cc: stylon.wang@amd.com, Chris Park <chris.park@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, "Leo
 \(Hanghong\) Ma" <hanghong.ma@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why]
Certain HDMI modes failed at dml cap check for uncompressed video but
they can still be supported for compressed video.

[How]
Add HDMI capacity computations using fixed31_32 in dc side.

Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                   | 2 ++
 drivers/gpu/drm/amd/display/dc/inc/resource.h         | 3 ---
 drivers/gpu/drm/amd/display/dc/link/link_validation.h | 1 +
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3ca72c097aa1..c2ee80d6f64c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1462,6 +1462,8 @@ bool dc_acquire_release_mpc_3dlut(
 		struct dc_transfer_func **shaper);
 
 bool dc_resource_is_dsc_encoding_supported(const struct dc *dc);
+void get_audio_check(struct audio_info *aud_modes,
+	struct audio_check *aud_chk);
 
 enum dc_status dc_commit_streams(struct dc *dc,
 				 struct dc_stream_state *streams[],
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index c7a00a28c3b0..c958ef37b78a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -573,9 +573,6 @@ void update_audio_usage(
 
 unsigned int resource_pixel_format_to_bpp(enum surface_pixel_format format);
 
-void get_audio_check(struct audio_info *aud_modes,
-	struct audio_check *aud_chk);
-
 bool get_temp_dp_link_res(struct dc_link *link,
 		struct link_resource *link_res,
 		struct dc_link_settings *link_settings);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.h b/drivers/gpu/drm/amd/display/dc/link/link_validation.h
index 4a954317d0da..595fb05946e9 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.h
@@ -25,6 +25,7 @@
 #ifndef __LINK_VALIDATION_H__
 #define __LINK_VALIDATION_H__
 #include "link.h"
+
 enum dc_status link_validate_mode_timing(
 		const struct dc_stream_state *stream,
 		struct dc_link *link,
-- 
2.42.0

