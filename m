Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F0EC46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F11C510F658;
	Wed, 24 Jan 2024 07:03:57 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5945E10F64B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcdX6HfeWGhUYR77HGovU5XV19p1Z2LZnpOZ4LvHxQtwQrLqoFHORaLKDDunzm1Ujy3diaLoDtTSQaBJQkthbDxi27Lwf8lXTEMyz6QBoRBg4ogv4z8EIB6gNBSL58VgeCKPut81BWqkn0za1+TzKe50lsgY5bTRo5itgk5DvIYp78zByRml/7wnEx6awJxYmpTUQAReeGleKtn26b8i/9tTRbFoLoKN5le+M2LgHz/TDxsM6LS68q8gRu3IpUDYGx7FkihrVK7lCQTPVXjyYnECXJv5aPjP/cJRN9iXx4F6PA7+qg3Wevm9c6EcX+KHccN1MHkXeA/svN/I1DREsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGy4buJJL9dfFc6rdcVD4X8ovl2VlXJbwFElMDZPqnA=;
 b=jdaG2CZJH6DTmfqPSqLN8GEKCFrSBSwYg4oiFtz9PqDx7IZmK617SFZEvGYw5t+pfdOvTjqpVTQyV6KHuAqVKGG8hEYq2kIRHEe6VtL7W4KiMXrBEHAB0sMfSc+/YBXUUZtXD8rawXjDrYTRUqcNFE7uYhrdat0kq35JhkJ8f+xjonNJxJrvauC56iuly2PyVc7UE/69WNLsmRZ0Oljetn7csvIrTbE25zbeq7p56xbtw1MGHm2C+W0BHsZW+IgtTLiPq4bsuvDajuRWe/vHXmKMy0MAh37S7OsrWSVFz7gjaGzuoTlckryJErDk4W7MrF7kRrbnHRdY0GTs+1eDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGy4buJJL9dfFc6rdcVD4X8ovl2VlXJbwFElMDZPqnA=;
 b=IFfpir4Xb9k/qAmo2oLSiHqsIba5HeXeQWnZZFg/J8Y6vzwf3Dwn+hTsPSvCtvYnnTucU/h3mK75y/vylqxJtr+Qg6WMPlLZ3nbHQYnJ0ojctvKDfHz+lkqYyRmN25xckwS/CiDmggv1uS+Avh6hhkC68y+P8uw2DmieO/StHkI=
Received: from MW4PR03CA0180.namprd03.prod.outlook.com (2603:10b6:303:8d::35)
 by SJ2PR12MB8135.namprd12.prod.outlook.com (2603:10b6:a03:4f3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Wed, 24 Jan
 2024 07:03:52 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:8d:cafe::5d) by MW4PR03CA0180.outlook.office365.com
 (2603:10b6:303:8d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.38 via Frontend
 Transport; Wed, 24 Jan 2024 07:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:03:52 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:03:46 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 23 Jan
 2024 23:03:09 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:03:07 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/22] drm/amd/display: fix DP audio settings
Date: Wed, 24 Jan 2024 15:01:54 +0800
Message-ID: <20240124070159.1900622-18-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SJ2PR12MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3c2014-2ab4-4420-0d96-08dc1caa9f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EAK44SB7UCeEwmqLke3zHSzhJ2rHGnU7/SU591UCxSxVVqSxp02kv7Y/yRd8UUy2HqLxhdPbZ2rurgkxzMlh22eAvpEBQOh0hPfe2Ey/ty05wtvwyf4ywpNkIX60pjmS2Kh91hqZgJblssxKUwoV4hSoNioN7JmC7M9HwuoB6zmor3w8owlAurxXh9BKCOkmz7OhM3vJgz7cTGun5a92vs3yWWD+R1ZaM6J7CYOP1jkHi6hKfZKXWQEnKzN0A0cJgOvYBGBhaGA18Vg3A+9D0mIGmwzABw9rvaE8hJz6VmOpnEJP89PpL77jbPoLCUPlgf7XSPVkATktCxocz1KbRBPsEjIl5YGS9fpSfoBqsxh1gWZwpcsvn2Fp7oR2DeljqFmxDRGV10NuV7PbQjd9COzI+PBWXCb027HRF9NGmYZraem2Iu+SAw/LFqoe3MNOIu+lm/tWENIYVI7Fx5oyH/cA+7mocPV9uMxAd5Gf0cZvYQI1+oNWJEQIZwAwXaBp7dKjlbWwphLKikWZmNViLC4lyKNgqz8b574ovKpQOTcdqw6vId93Dx0p+m/Xm0RXMG+pYQYTAopxQDT55kyeHE6Clnw62c4KIR7BcplGree/1Ou0a8iRv0oGX/z0NABkV57D3bqjWLK9D9aTq8lD+EJLDya7T67uDcZSaCCZzMnr3fbnjI8MoYApaBtO3dCNr0fv/6/ZtuuAdnHkOhi4gjivUcf013JXwhn8g3xZaX0ryYQSz+ECGHhrua12ytVnwYOPqBzmN8eB9ePL5yTPQJlLTsySqFrNKKLcpcgv+T9Qe2unECQRPEevS/1ioRIZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(82310400011)(64100799003)(451199024)(186009)(1800799012)(36840700001)(40470700004)(46966006)(2013699003)(336012)(6666004)(7696005)(426003)(2616005)(2906002)(26005)(41300700001)(47076005)(36860700001)(83380400001)(5660300002)(8676002)(478600001)(70586007)(316002)(4326008)(70206006)(54906003)(8936002)(36756003)(81166007)(86362001)(82740400003)(6916009)(356005)(1076003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:03:52.2907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3c2014-2ab4-4420-0d96-08dc1caa9f6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8135
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
Cc: Charlene Liu <charlene.liu@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Zhan Liu <zhan.liu@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

[why]
Audio channel layout for 5.1ch is not correct

[how]
Add the audio layout for 5.1ch (channel_count = 6).
Add divided by zero check.

Reviewed-by: Zhan Liu <zhan.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index 07b507150c51..12f3c35b3a34 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -282,7 +282,7 @@ static void get_audio_layout_config(
 			output->layouts_per_sample_denom = 4;
 			output->symbols_per_layout = 40;
 			output->max_layouts_per_audio_sdp = 1;
-		} else if (channel_count == 8) {
+		} else if (channel_count == 8 || channel_count == 6) {
 			output->layouts_per_sample_denom = 1;
 			output->symbols_per_layout = 40;
 			output->max_layouts_per_audio_sdp = 1;
@@ -292,7 +292,7 @@ static void get_audio_layout_config(
 			output->layouts_per_sample_denom = 4;
 			output->symbols_per_layout = 10;
 			output->max_layouts_per_audio_sdp = 1;
-		} else if (channel_count == 8) {
+		} else if (channel_count == 8 || channel_count == 6) {
 			output->layouts_per_sample_denom = 1;
 			output->symbols_per_layout = 10;
 			output->max_layouts_per_audio_sdp = 1;
@@ -489,6 +489,11 @@ static void check_audio_bandwidth_dp(
 	get_audio_layout_config(
 			channel_count, dp_link_info->encoding, &layout_config);
 
+	if (layout_config.max_layouts_per_audio_sdp == 0 ||
+		layout_config.symbols_per_layout == 0 ||
+		layout_config.layouts_per_sample_denom == 0) {
+		return;
+	}
 	if (available_hblank_bw < calculate_required_audio_bw_in_symbols(
 			crtc_info, &layout_config, channel_count, 192000,
 			av_stream_map_lane_count, audio_sdp_overhead))
-- 
2.34.1

