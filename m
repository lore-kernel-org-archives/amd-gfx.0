Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB47C54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58EF8112CFA;
	Tue, 12 Mar 2024 09:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="retzrlnZ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71A4A112CFA
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfR7oQikY71weFpIXbBtcV3fnk85WDKe10tVYNsAUmNs+/5UA7ag9XyijNia6OeEQjLli2OkzhQFR8g7k0HVBAo3DGEIwA+yTZ4aQVLJ2f77AZi1YghS9ui7w5EF6cWzOilvui4Erb/nYRK4kgMpG0F9sjLQ2F3so9ZMroV65LUnGKKDDfyJl3Km01+skxPHlluPeEDbpE9cfo0mqKLqL52/+5dy67uuq5rrYMVNVal2g0a4b8fsfOYw3qhhXkR8OdM+YZ9Now2woyPDL4bTZ6BSKpe5nglIoSu3cgzhiV78u+OCpUOgyZt+97Sz94owOMawlpaBynHOW26JHO+9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAMXijLrQkkzYSeotDdvA1q6JlZbrqLVeVzu4mDRFI4=;
 b=gXHO1pkoqzVLjjDD0A6L2NgM0jiIyAN7xKQMuLKF/JQLADoAgV02vc+QHzzq90Ny71WUd9VlaqNWi+kndC/4lTbTiQl8p6/1K+eO2PMXWZY7DPmwuA8VBjmHKpBoisrIKbURFu4pumk9dRP3ySMmOsGbaiEioyzZ8pODpyb15LWwHQRa5a1QgcudEU6j/bhjha2d1t8TFWy1li2DI5fbVEmI7tIVyd4X8Tf9/l4SM2daJNCn5GB6IuBqF7YOiQKC62KXtA+F86LBd3ip3I81h7Iaz1CBEnQmQDwJJ8DwS+jQ5P5HGmrJOEBVi0wjwo4KPc7j7jheXbkUHwrqS5ktpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAMXijLrQkkzYSeotDdvA1q6JlZbrqLVeVzu4mDRFI4=;
 b=retzrlnZ1+Q9OumJQgGqK98VgcL0Z+nl8j9F6HLmHhEy72uzah2z+gG4fCvROgT8ufYLe0KA/rIpWfJDCT1+xec6Y52I3uQ/zGeZPb0uAvJ9Gvmf+8Ghs5p16J3TG3AEjCUEUyWiLp3LSlp4GoaVRN0hCpXNQLFvP+UsjBNOhbg=
Received: from DS7PR03CA0128.namprd03.prod.outlook.com (2603:10b6:5:3b4::13)
 by DS0PR12MB8293.namprd12.prod.outlook.com (2603:10b6:8:f3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Tue, 12 Mar 2024 09:24:07 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::e9) by DS7PR03CA0128.outlook.office365.com
 (2603:10b6:5:3b4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 09:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:24:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:24:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:24:06 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:24:01 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Chris Park <chris.park@amd.com>
Subject: [PATCH 31/43] drm/amd/display: change aux_init to apu version
Date: Tue, 12 Mar 2024 17:20:24 +0800
Message-ID: <20240312092036.3283319-32-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DS0PR12MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb3c5f0-324f-4590-2565-08dc42762b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFwdM8fvJ/UQnhiiuiCCw6lGrO3P7o4fDG0OpUyJX0HvghTnFhzRxZ7D9PSQ0JPcRuoPQNXkeBy5OEOjTeWu5P/UjPogO0saw2IfnvvVQen85Jzi92MJ8E+EgXkp08pU5ySMdTquJp+sRykTak0p9M9o6e8+BmqXwbOjncHSfn5NX0JN6Y8hO/jW8jCLCz9FaGBhqgWrNCthItPbUwCALFRhPCHjE6NnOh1dC3QR0glMur3i1OHQKUZRTT0JMSdSyDn8evcQlpMZNDu81GK8sKclr2S2m8VmDblzAIASLy6Q4jK6BTNYi2jmSUZxanlodJYzxweOistdQD0rwKPHWUV66z6CqnEul0faqgO5460R/aL3JDc+iJuCYZzzdUFQZES3tEOBCjBdZiQXJxx21RPuWjVTC8t+B7MYMLElz/WOyLWK9M26xuF8NKTheDN+cydIXZ+PkKfrnl5z2yva8F4EgiC9hxJKZyOqajBjnK7AJORSO5cbePPtMIC1FuYPyfxmwSo10KqJKdkTf45ZTroIKbpGDl6a+ceCMsarlrSLHRWdiCcb8KRmfZ6qnxREqmkfNSA3wD7w5x3540nipf/tCXjAI/aj8ZGu1kiLqFmfDcI/0Qrj6R+eC46oPeSnrjdl3hbgwGWSoqHZj4w7YqikVbWNf5vdoFzNuEuB2ptAXgF6UD6Q7G1rkMbYwsitSk8R3h7rGimHmFVxsnuoYctIMYI9W5ORfRC6vkxqyqS8BK2uxPk4wzstD1CRvyTc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:24:07.3990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb3c5f0-324f-4590-2565-08dc42762b00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8293
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

From: Charlene Liu <charlene.liu@amd.com>

[why]
APU has different refclk as dGPU which is used for AUX_DPHY setup

Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index 26be5fee7411..b2cea59ba5d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -205,7 +205,7 @@ void dcn31_link_encoder_set_dio_phy_mux(
 	}
 }
 
-static void enc31_hw_init(struct link_encoder *enc)
+void enc31_hw_init(struct link_encoder *enc)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
index 221671563a0b..b5dfd404676a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.h
@@ -283,4 +283,6 @@ bool dcn31_link_encoder_is_in_alt_mode(
 void dcn31_link_encoder_get_max_link_cap(struct link_encoder *enc,
 	struct dc_link_settings *link_settings);
 
+void enc31_hw_init(struct link_encoder *enc);
+
 #endif /* __DC_LINK_ENCODER__DCN31_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
index 81e349d5835b..6e6ae3de08e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
@@ -119,7 +119,7 @@ void dcn35_link_encoder_setup(
 
 void dcn35_link_encoder_init(struct link_encoder *enc)
 {
-	enc32_hw_init(enc);
+	enc31_hw_init(enc);
 	dcn35_link_encoder_set_fgcg(enc, enc->ctx->dc->debug.enable_fine_grain_clock_gating.bits.dio);
 }
 
-- 
2.37.3

