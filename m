Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE99EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2BD110E5B5;
	Wed, 12 Jul 2023 17:13:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2E2210E5B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:13:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2KnNOl2FMj8/iXFFYo8zXSQ/vcyZbMjNMwMgJKlJrpkv04VGECzGCrozzPt8ibKBsWawaYyRi8ApRu5o6IlJ4BhW6F7NiSGyhxiwuGdWJ97cq8Z/cIvY6ZPvCABZMQ4swf0N3EwmNH1TWdJNu3LxC9sBCtB89kkOxW5brGAmMWu9rXqVAHI2Z7L55pHyi7+kpkXrxDK9HHaa4DCc+vs47/cGklDH1bWxiTvDPwqQdowVuqdLJr8dyN6owSjGRkfAKXntWlX9W/Za9L4FH3Sgp00ix+qUeW5xitA0rJaFhHZg2YpqaWijXPNDa2V/egeKnGyqkqHY2csuwpexzY4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9q0OtSUCxvB1wUZKTHj265uKlkMh19CW2o6ud7xjLLw=;
 b=Fl3cDaxX3sDilryZ/4FwzbnDsTt6dqULlvDTH7/zNI9jOBdJx1VtrCT9UTst4qA/kbIVfF/sTPHFbMo9T605c3fEk5aEzyXkFIv8JJHu20oaUnLY2k2GOQDW/jXquwuy9T+rt8N5TPmID8ghLAdOvg3sdOopm+dH2E+FAymbr/aT3646h47vZADBd1TD0S+4L9qArwvoC0en34I8FxKLECo9ivzlEaR6FqudvqM5vxSeWj5jYprFSUbxIKp2uwMFToLzsb+DHyYLn/LWYHsAqWCAU6KuNCNCXosJIsbkQUQ+ACE154WLT7Tqm7eJEIhaTdRAD+5TLaDyzMm8cmOyvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9q0OtSUCxvB1wUZKTHj265uKlkMh19CW2o6ud7xjLLw=;
 b=B1CqtkxpIyHeffTXO5cFH9+CjlssnD267Mk+LMvXRjNADbGoGdrxas/cEqrl8K0Ux+exjSaN1CXTA/BAodUL6ht//GOumCt1+A4TUWQYNHmKAu0ioRgmtFBuB0VLoL6tKfaT+22TnzfNoly6dSxJGEO/TdcigxAcg+9maTuympE=
Received: from BN9PR03CA0679.namprd03.prod.outlook.com (2603:10b6:408:10e::24)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 17:13:43 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::48) by BN9PR03CA0679.outlook.office365.com
 (2603:10b6:408:10e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:13:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:13:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:13:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:13:42 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:13:38 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/33] drm/amd/display: Add stream overhead in BW calculations
 for 128b/132b
Date: Thu, 13 Jul 2023 01:11:22 +0800
Message-ID: <20230712171137.3398344-19-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: e46bc4fe-4dab-49b7-fa37-08db82fb5812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0MhNizhaosRfAYdkG0yvfUA8mmAUSJH7B/PqVdbyr2bev+wRbfDVJBpFoIeFTOmnV2dd4TTgtO377Y3okv8yScY0vsjbnBrrlhaFkbEgJla6sz/V6Kn5jl/PIavS43uEPVliGkv0XNcAVgg2PeUYw+H2k03SlOlu1RRi6jWRxulcNFojXnuHxIm36vcgxVCOrCDbDpBcYsObXjvLcR27bVP6L6IuXkByXto+4z6Remfhyt1HbXBUh1ocIdtWInHIvcwCHuMh71B85h8ITIvTXLO+mvlboAIWUAbcTnTMTJgTw0Z6gCxMHI20QKZg1TN3hJ8Bz6A3V6lb3TU1Qxe7MMoC1FlqpiI+N+Yo26z6iXXKHSVScB4uM7J+ADsujzO/EAzfN0rBx+prwwIOVKBfJTYMUPsVFFVtus5MKlkU3zeSurhAyOlFmlW2KkP7Z1Yyp4dzgX7QaLZkTHkgPoU0LsWebmyMcr0lJxDGE+tU9475nqvZhg3vFjF0WzpgQW6Mqhb9g4bBuJ25/InhAzaclobD+hdggIcdsiLO9kSl+h5j1YooXV+cHNyOybEg/+w9+pms3CFU417I8j5Iqix6Ek/xsTJCk8W4gyG082dHlvjbmjepPptK9ym4vxllIKbj35Fkyt1AuWvU6s2E+iKh8OHT8SHiFz80J8wkPZXJVUeyF6gcWAkwyEWuIYE9QiCSGapfDE0dPpCe147kGjRV3vBLozzxPbCFfjwC0xVL4SqCjaSSdVtEZHgy9pZzwAbZfpmlRmLiWAZy4PsbZ0MYFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(86362001)(40460700003)(82310400005)(8676002)(8936002)(186003)(36756003)(36860700001)(426003)(336012)(47076005)(2616005)(2906002)(5660300002)(1076003)(26005)(40480700001)(82740400003)(6666004)(81166007)(54906003)(356005)(70206006)(70586007)(83380400001)(6916009)(7696005)(4326008)(478600001)(316002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:13:42.8629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e46bc4fe-4dab-49b7-fa37-08db82fb5812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Current BW calculations do not account for the additional padding added
for uncompressed pixel-to-symbol packing.

This results in X.Y being too low for 128b/132b SST streams in certain
scenarios. If X.Y is too low, end user can observe image corruption.

[How]
Add function to calculate stream overhead to timing BW calculation for
128b/132b SST cases.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h         |  2 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 42 +++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 819c326baefe..7aa7085c3bec 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1410,6 +1410,8 @@ struct dc_plane_state *dc_get_surface_for_mpcc(struct dc *dc,
 
 uint32_t dc_get_opp_for_plane(struct dc *dc, struct dc_plane_state *plane);
 
+void dc_set_disable_128b_132b_stream_overhead(bool disable);
+
 /* The function returns minimum bandwidth required to drive a given timing
  * return - minimum required timing bandwidth in kbps.
  */
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 58dd62cce4bb..aed0d3dafa24 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -40,6 +40,8 @@ static bool dsc_policy_enable_dsc_when_not_needed;
 
 static bool dsc_policy_disable_dsc_stream_overhead;
 
+static bool disable_128b_132b_stream_overhead;
+
 #ifndef MAX
 #define MAX(X, Y) ((X) > (Y) ? (X) : (Y))
 #endif
@@ -47,6 +49,41 @@ static bool dsc_policy_disable_dsc_stream_overhead;
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
 #endif
 
+/* Need to account for padding due to pixel-to-symbol packing
+ * for uncompressed 128b/132b streams.
+ */
+static uint32_t apply_128b_132b_stream_overhead(
+	const struct dc_crtc_timing *timing, const uint32_t kbps)
+{
+	uint32_t total_kbps = kbps;
+
+	if (disable_128b_132b_stream_overhead)
+		return kbps;
+
+	if (!timing->flags.DSC) {
+		struct fixed31_32 bpp;
+		struct fixed31_32 overhead_factor;
+
+		bpp = dc_fixpt_from_int(kbps);
+		bpp = dc_fixpt_div_int(bpp, timing->pix_clk_100hz / 10);
+
+		/* Symbols_per_HActive = HActive * bpp / (4 lanes * 32-bit symbol size)
+		 * Overhead_factor = ceil(Symbols_per_HActive) / Symbols_per_HActive
+		 */
+		overhead_factor = dc_fixpt_from_int(timing->h_addressable);
+		overhead_factor = dc_fixpt_mul(overhead_factor, bpp);
+		overhead_factor = dc_fixpt_div_int(overhead_factor, 128);
+		overhead_factor = dc_fixpt_div(
+			dc_fixpt_from_int(dc_fixpt_ceil(overhead_factor)),
+			overhead_factor);
+
+		total_kbps = dc_fixpt_ceil(
+			dc_fixpt_mul_int(overhead_factor, total_kbps));
+	}
+
+	return total_kbps;
+}
+
 uint32_t dc_bandwidth_in_kbps_from_timing(
 	const struct dc_crtc_timing *timing)
 {
@@ -1165,6 +1202,11 @@ void dc_dsc_policy_set_disable_dsc_stream_overhead(bool disable)
 	dsc_policy_disable_dsc_stream_overhead = disable;
 }
 
+void dc_set_disable_128b_132b_stream_overhead(bool disable)
+{
+	disable_128b_132b_stream_overhead = disable;
+}
+
 void dc_dsc_get_default_config_option(const struct dc *dc, struct dc_dsc_config_options *options)
 {
 	options->dsc_min_slice_height_override = dc->debug.dsc_min_slice_height_override;
-- 
2.34.1

