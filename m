Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7827C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38E5110EDC5;
	Fri, 14 Apr 2023 15:54:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C32E10EDC5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUbdFc6ziF62JzDjzwebzl1lFAJFiK6LmKN5+g0BvffzyjpCcn9DCKSmErJmQFOOy+BTxOMTubcbEvSjZXr6hPBZG9u3IQ5vJLzXgxsHTRBpDu0mpNa8XbCotTXddfpLlk5NM/1vPl3s9n1coGvubHrPXBfdRP0gnpCJgEQs2f9Sx9f4trb73PPpKdz4ytDzSETnVf+JfUqnn4Phm38X74YPfytsGYAV9/CNmMOGMCJTHnJr2ba9t/7L0h1SBopJa806mZgpLWToqhpFw/11P+SzMsgVOzM2JTGPTwLD9omXlhuvvJY9kokCfpqduNy0GO/BTc2lyGwAjvm3W8ACOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vltgx0muF0mxxQ17Egdvv4iUbej76UDxOxXt4o4Oq0M=;
 b=FlQXW/x5OV4anhtM8TihMh3PM80bf/6ffziRtnKk+JskdRxZ0qhHSR9ycfJSN7va/VkBUYq0H3ivExiVRFIt38hIFyr+2AnIjII6COmaOGkiGoI61zITQmIjWF+3TefA7CrVORo0TAIUDmXzatiVeLCl+wktHecJ3WZyiIjxXm0OZ5tW0KJ2v1XG7WNq6oF2yIneJEmqRkbHZ0pLrGeV4gn/l6v0+LTdMup1PzZWtCHxTTKS0foVLLvlmyqnHaPMv97ugn/WxePbED0JgZlynk4dxRalnUEoq5S1WKYOmvHh5SC7eMn2GBvvxPROwKaAbiiF7vMABjX0iIwkx/nMaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vltgx0muF0mxxQ17Egdvv4iUbej76UDxOxXt4o4Oq0M=;
 b=SA7zZSsjQlsWz/Tc6E0j2FhWKcJc2YhebY3xKP4x3Az+Pil+GXRR2IyqseVl6QOwhQ51AmAW5GZp3viMrvdlWunKzEpdOz4W8r2wn0190MT1EsqoD4odWeOpf9ssU81uZgUzcTEIK8FKq+OXYfMCXreKFu53Dx017GbDkBCHtWE=
Received: from DS7PR03CA0122.namprd03.prod.outlook.com (2603:10b6:5:3b4::7) by
 IA1PR12MB8588.namprd12.prod.outlook.com (2603:10b6:208:44f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:11 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::44) by DS7PR03CA0122.outlook.office365.com
 (2603:10b6:5:3b4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.32 via Frontend Transport; Fri, 14 Apr 2023 15:54:11 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:09 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/66] drm/amd/display: Fix hang when skipping modeset
Date: Fri, 14 Apr 2023 11:52:40 -0400
Message-ID: <20230414155330.5215-17-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|IA1PR12MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: 83cc0c46-edee-49e8-9564-08db3d007d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i3pbB4ZfcfNDvuvkQtk0tnjZvZPz3w1xAEcWRZ8zsn87PU+k1NXX9LZdOFsnGATYGGJTDdkne4v4PZG5SimKRF62vghHe5w20/rinRjfr9uZlQgwYpqQubT7Dr4405Gw7CNw7xbVLCFKgZGE1LYdqX2FyznAYkjAzSYC75TA8LZwU566fSxxG7gtajpEqxO3F9go+TAiwMvgwKTNNa6rVDiYwtaEGeeGnzr3nKSGhx0sddLNM1zcJDrM5hnWkceNuzxQunpAUHGhU59q1LfiWLfbLMOXxmsbSD1ETwdxK2rUOSXbQGDGBG8s9ksPOpY+4lxGeCct9D5DZ5hD4q0tK9eU0a3PbN/qFGiYhhkGFOdOvFGjK+jEUo04yGmyiRFw/7nsWVxOm0/RjmjrWEQMtvLH2LZGZIlhWmxc0BV2qqV6+e3rAUsaEeQlPmRLr4zEoOr1DykROYmeuumKoaK79a2RdLXpQ661XlEdTMvYZA6NP+WmE7leL+dIUm/D90MEMEKgbdA22ouhvsWBsH5f6fIHpRlvvx0RRVnOUGLlES1dGOot2N+H0wYwxOBai7BsIlgWeiMm8t1R9wWtbDZc/YoxDLZkXYY1ZNf71fN4jtfh0Z9K3Fo6oQ8pBjDiPakm/EsZqzQj1FvmkGMZ7VtcizxI8ZnB1RvO4IatyUfftsLxSW9oq/vmPNxMupDxRRXiNzyNTeQD9VKdgWACwMgAZfNTU/Kpv/7t/XQi5+ZjRLE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(336012)(47076005)(83380400001)(426003)(54906003)(2616005)(1076003)(16526019)(6666004)(316002)(26005)(478600001)(186003)(5660300002)(82740400003)(40460700003)(41300700001)(36756003)(8936002)(6916009)(4326008)(70586007)(81166007)(70206006)(356005)(82310400005)(2906002)(8676002)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:11.0595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cc0c46-edee-49e8-9564-08db3d007d1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]

When skipping full modeset since the only state change was a front porch
change, the DC commit sequence requires extra checks to handle non
existant plane states being asked to be removed from context.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index da3045fdcb6d..8b4a470a7e60 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7971,6 +7971,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			continue;
 
 		dc_plane = dm_new_plane_state->dc_state;
+		if (!dc_plane)
+			continue;
 
 		bundle->surface_updates[planes_count].surface = dc_plane;
 		if (new_pcrtc_state->color_mgmt_changed) {
@@ -9619,8 +9621,9 @@ static int dm_update_plane_state(struct dc *dc,
 			return -EINVAL;
 		}
 
+		if (dm_old_plane_state->dc_state)
+			dc_plane_state_release(dm_old_plane_state->dc_state);
 
-		dc_plane_state_release(dm_old_plane_state->dc_state);
 		dm_new_plane_state->dc_state = NULL;
 
 		*lock_and_validation_needed = true;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 85d54bfb595c..117d80cb36fb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1707,6 +1707,9 @@ bool dc_remove_plane_from_context(
 	struct dc_stream_status *stream_status = NULL;
 	struct resource_pool *pool = dc->res_pool;
 
+	if (!plane_state)
+		return true;
+
 	for (i = 0; i < context->stream_count; i++)
 		if (context->streams[i] == stream) {
 			stream_status = &context->stream_status[i];
-- 
2.34.1

