Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70C9C64EC4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA9510E6D1;
	Fri,  3 Mar 2023 15:46:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843EB10E6D1
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:46:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6fm9PaPWNMmuz4hPVvEMaknpRXhrZ+2X55ACTgc8p3X1tLNlme0i8W9vKCM1Xr38DS0QmXIxiW+l+6MpCyS0yS2G5x+5ofY3Lyhl2P0tIf8EC0SwWzuv2yDASfqBfvfSsowVcojEpT/8YHEie+Of4R1fvdho+oANSEswsZeBBRcvR7i0c9iwf3qCA4MXbe6GD5ZPaJ0CbqLgH0v/d23nhVjYE6bEOJWTw3ITHfoNmp0Mt9T1CYv0FwD7hBgCc1DOikhaZiUDfOufacvfeheb7kds1/Qiy7NoNHIWsKMpK+aBy4zRAzeJiJh1UL5OwUOdipDs74Ld+rIUwDtn9ifAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTqMCVBJ24hU1y+BQ5yzotns+obuPEnSbzinkNVDOKY=;
 b=aBO/xa7prUVroiv6kZ5iZGG53LCQGAleMZMkq5XofNW3Kpfbn1W2U4YZxokveMBmTPcIfdjI1AtnPYa9AU2CV8r9d77crZqJ8UpK2yfsgvPjguuY6As2iP+x7mlkvS5bZZNjIwJ9qJ0wIrWPVIMEBdKFaC3KO+8Jn7Xkk07xvYKJVIxKUtWg6ciP+jTU8ApFSEHQDpt9xJOhLdO3oNxFLWVurJ0HWmc1fBYskpNImJnTGzwRDD32DDXGKpdgnSAujWxwxW8Sk1kxVchBmX4ROksHTvlwHHxBLQhH95+XZ6LviMXzb4ruAHrQaTlpj4iRbBsOReGj/dncay5BkTSwdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTqMCVBJ24hU1y+BQ5yzotns+obuPEnSbzinkNVDOKY=;
 b=W3FOefKHw89xss4nekwB8HAYIe7x4/1/U40+NI+ZBwZMovxFjkd2WhvApL5jeUef56whM9XdA5a3452l3xfslGSGvQZ3mB4RH+rhrTTeqOmWGwKhbG3qZ2cK+h8JO8p3vGFlwASkN+Jm0z6keu7hXRpjuGNjTF6YL8VpjY29Fzs=
Received: from MW4PR03CA0129.namprd03.prod.outlook.com (2603:10b6:303:8c::14)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21; Fri, 3 Mar
 2023 15:46:26 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::e8) by MW4PR03CA0129.outlook.office365.com
 (2603:10b6:303:8c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Fri, 3 Mar 2023 15:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.10 via Frontend Transport; Fri, 3 Mar 2023 15:46:26 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:46:10 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/33] drm/amd/display: Fix no-DCN build
Date: Fri, 3 Mar 2023 10:39:57 -0500
Message-ID: <20230303154022.2667-9-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT012:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: c96ad6ef-c134-4c38-d5b9-08db1bfe72d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qB7HJRBoFoP2bHwOX+gqzxZBRCOVp/RJsiqmvYdZ1BLbawCyKWt/wbGE43st2alY8BqZQg9Uz+QB7oAQufWIfshe3vijAgGltWyiVKq4OI33S3968974pBrJRE4n2Q8jy95RuiMGW25bI0WJH0pKxOtl6tGK3QPzH2hf4H4d+rD9z82GIqM3yUhiolJ3RmsJtfYuSwmU8rfN5/2EgqxGitHcL22cFbj4Ma8DuMUt2pOBNwFJVzppAS0P4hY0po7tpbNOFv3NoXMqbA4MP56wnmSGNdT0yH9HTnfIiuLt9OF9DBYggHRXmEy3dw8kSSgluNb/pCVjJvazcNA6nKnM1ZtSJnnsLy2qImG8r5LPcZzBLuy4CayaukhJ9qENoXEK3uxShL3ViQcrdFMh6agwfc4aqiVrWwXuSjKWiwn7nE/NpcRWBnhoOPMiS/6vxB0+MJ8WoVRT6/2ixB7riNajzs4gL9JohuQVpPgaQkahXKxcQ2gsZERKlHckZOziNQHQyslgLCFCGy5gmDCFPGWjoCRCr1zj1AsvSrVuNtE9UmTE3ZwPfR6Cs1Qi/UHFSGTM3Mtl/8Z10BBBBXJTy3yRpV/UhQfcAxpIThyRg+Iy0TgUTwGzHwN0BVY6jjBVwBrlz28W/j9F9HSCi6sblzM2MwMRvOmSjxgBH8hXd560luQb/qgNNPYsMvDXZ5Xt80Uv6pAsHS8P8eDJh6DlqtCe2QbaURtcHJFWR7RsIiKAvA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199018)(46966006)(40470700004)(36840700001)(5660300002)(2616005)(356005)(82310400005)(336012)(478600001)(40460700003)(86362001)(1076003)(40480700001)(316002)(6666004)(26005)(186003)(16526019)(36756003)(41300700001)(44832011)(36860700001)(8676002)(6916009)(4326008)(70206006)(70586007)(83380400001)(8936002)(47076005)(426003)(81166007)(82740400003)(54906003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:46:26.2867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c96ad6ef-c134-4c38-d5b9-08db1bfe72d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[Why & How]
This fixes a couple misplaced CONFIG_DRM_AMD_DC_DCN
blocks.

Reviewed-by: Sun peng Li <Sunpeng.Li@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index e10ed2935971..19721941b069 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1427,6 +1427,7 @@ static unsigned int kbps_from_pbn(unsigned int pbn)
 static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
 					  struct dc_dsc_bw_range *bw_range)
 {
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct dc_dsc_policy dsc_policy = {0};
 
 	dc_dsc_get_policy_for_timing(&stream->timing, 0, &dsc_policy);
@@ -1438,6 +1439,8 @@ static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
 				       &stream->timing, bw_range);
 
 	return bw_range->max_target_bpp_x16 && bw_range->min_target_bpp_x16;
+#endif
+	return false;
 }
 #endif /* CONFIG_DRM_AMD_DC_DCN */
 
-- 
2.34.1

