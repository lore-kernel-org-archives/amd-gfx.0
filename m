Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57585C001DE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 18:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBFD110E4DC;
	Wed, 19 Jul 2023 18:33:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86A1810E4DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 18:33:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlQLXb6MuQC9a4lk0tff7htuSaJ3NJ0NuGtMLAhQ3wlD0wGliYdVe0vy4pzkP+UUEuVqg7XlWUWXPf3GJ5x2vQ1NOwqkaUMNYFvitlQc3EjidTuT7Fp93s7uKL7JLDudanh9plOMzBSnrCKE1gcoI/nv5TpDNqXV+IaSyKsqDTElMMRQLZ+wpttYLdnmfS7E7YP6lbKlHrUgCcIYcKLcnQ7QftU81mBVLcB75ORVRWU1PAHepl/RluXlo6aO1+6BtU54VGFJsVm65m/oN+CbxpMETJf+co53O5HCHTysUhknwTuW2TMA9YhgAdsF8eewJECvCuTJIeAZubtgXsDjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyJTIXWETEjGt5pC1DaQDiDierhTjF9Neh6Pbezhs84=;
 b=ZW1BHyTmkTf+bjb4LsOLWkVZmvvtwn3onWPas7nJJOIimWNenebdjmxFv2dC+OaHpWW1rZb0usYwCmTWlmgJOQk32cCavtfoucITKx9UF2nZGCoCPBwKXn2tyofqL7kVzTpCyOA3cUILkOVT2aLnNWmcI3kb/wYL7NLsSeXDB61KMRRgXaujn4NZW9humanGnPiP0WE7USKYZXvVz2QNfaXpNpfff84b69DCfTxy2aHlVls7ATbhD9Qyg9mAm7YXKKevMsfPQ4AqYk61fzXa5/bIcVyPzADfEzQaWDN81AyZBPZduLy4Sar6B13ow8ECIWPUZ6mZBbvAJ06Kz4lj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyJTIXWETEjGt5pC1DaQDiDierhTjF9Neh6Pbezhs84=;
 b=lNq8lxAV7vQtJEDxomx89eE4+49gLr/o1/jueGj/ojBHBThCA9NEsmB8XT4zXw+8xRFScyH7uEhScWB7ryDA4NZGhKp9vbracTbjwO80LkDbBFxXiHjy6ngWV9AN5cfpmpmOO2GIFj1Uk/PjVvH2gyp9gtr1b0xt6TPvMHj6CwA=
Received: from BN0PR08CA0009.namprd08.prod.outlook.com (2603:10b6:408:142::13)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 18:33:46 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::e7) by BN0PR08CA0009.outlook.office365.com
 (2603:10b6:408:142::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 18:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 18:33:46 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 13:33:43 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/16] drm/amd/display: Prevent invalid pipe connections
Date: Wed, 19 Jul 2023 12:27:54 -0600
Message-ID: <20230719183211.153690-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183211.153690-1-alex.hung@amd.com>
References: <20230719183211.153690-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ea01c4-04c4-4fd9-385a-08db8886b04d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTm+odf98QL2Cs14/TBjtQOogut2brg/4xiQT0BQ82GzlnjlRqQi8Y7r8wdkXpyUZ1YatlExmj/Aa+rHmNUMNli1J9mK7UsXiFu22LoDhCys0Y+oVMcMHohQV8eeOOOVBFexG/Sabdgj2oL+EnSu6fL00oIARKxqKoV9JbCNwoDRoO9PvF31tPVjz8uidZE/+GW/7nVS1aFa2dEld3w7/1OMMtlO4OW0Az0fj+Fhy+2GWSqJb6ofaVXy2LnW/lBaKacpjLXIbZYYyAy2psF9bczcfjViZvY5g+LilMyrZQx0tTG50C5KKRi50pzFdGBdOu1lqm7cnhAP0073wmRS02Ak7B/94bxs85HpaOKPWQ3P1kWxlCNrax+nfStluHh3v3yhxmdyMPZSFkutqV2L76H42Wlw095Zxq9kG8mA+raqn2EAJ99Y5GpAb3IhxDLlPz+UX8r8Crr9wbuScjPSJd+L+RttH9xl/2Ih5EHtQ/xavAQTgCbmnjZPAhAj8jEVmz6HibskaIUOEexuEfV3bUhJK/ERQko3/WxD9lsb4A+zuotGBrQk6xU7SVT9uKgSbkfPG0Huj3YEJnwPsqK9CYXEj1LzzEXCRUvu9cg31aqat34ekVQW/xnYJlAqul+ujj99g5bAacmy8vHTl0YGkwhrMjShhnSRWyWxz5kbJF1M0Wz1UNse9f37rEmY+hpIMZoe+6KBG6zWHun51sTUSwF1QkfWcers2zmiEJdJhROzrVQDqHGWgRICx2lgtgud3ex684BpM7rbJD4n5nrcaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(54906003)(7696005)(36860700001)(478600001)(6666004)(186003)(1076003)(16526019)(336012)(2906002)(26005)(6916009)(4326008)(316002)(70206006)(44832011)(5660300002)(8676002)(8936002)(81166007)(356005)(82740400003)(70586007)(86362001)(40460700003)(83380400001)(426003)(36756003)(2616005)(47076005)(40480700001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:33:46.7590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ea01c4-04c4-4fd9-385a-08db8886b04d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Ethan Bitnun <ethan.bitnun@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ethan Bitnun <ethan.bitnun@amd.com>

[Description]
 - Prevent ODM pipe connections between pipes that are not part
   of the same plane when adding a plane to context
 - Re-attach child pipes of ODM slice about to be disconnected
   to prevent any lost pipes with invalid tops/bottoms
 - We cannot split if head_pipe is not in ODM. Preventing this
   avoids creating an invalid context with an invalid pipe.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ethan Bitnun <ethan.bitnun@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 37 +++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 1859350dffc6..a680ae3e8577 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -75,6 +75,9 @@
 
 #define DC_LOGGER_INIT(logger)
 
+#define HEAD_NOT_IN_ODM -2
+#define UNABLE_TO_SPLIT -1
+
 enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 {
 	enum dce_version dc_version = DCE_VERSION_UNKNOWN;
@@ -1471,7 +1474,24 @@ static int acquire_first_split_pipe(
 			return i;
 		} else if (split_pipe->prev_odm_pipe &&
 				split_pipe->prev_odm_pipe->plane_state == split_pipe->plane_state) {
+
+			// Fix case where ODM slice has child planes
+			// Re-attach child planes
+			struct pipe_ctx *temp_head_pipe = resource_get_head_pipe_for_stream(res_ctx, split_pipe->stream);
+
+			if (split_pipe->bottom_pipe && temp_head_pipe) {
+
+				struct pipe_ctx *temp_tail_pipe = resource_get_tail_pipe(res_ctx, temp_head_pipe);
+
+				if (temp_tail_pipe) {
+
+					split_pipe->bottom_pipe->top_pipe = temp_tail_pipe;
+					temp_tail_pipe->bottom_pipe = split_pipe->bottom_pipe;
+				}
+			}
+
 			split_pipe->prev_odm_pipe->next_odm_pipe = split_pipe->next_odm_pipe;
+
 			if (split_pipe->next_odm_pipe)
 				split_pipe->next_odm_pipe->prev_odm_pipe = split_pipe->prev_odm_pipe;
 
@@ -1479,6 +1499,11 @@ static int acquire_first_split_pipe(
 				resource_build_scaling_params(split_pipe->prev_odm_pipe);
 
 			memset(split_pipe, 0, sizeof(*split_pipe));
+
+			// We cannot split if head pipe is not odm
+			if (temp_head_pipe && !temp_head_pipe->next_odm_pipe && !temp_head_pipe->prev_odm_pipe)
+				return HEAD_NOT_IN_ODM;
+
 			split_pipe->stream_res.tg = pool->timing_generators[i];
 			split_pipe->plane_res.hubp = pool->hubps[i];
 			split_pipe->plane_res.ipp = pool->ipps[i];
@@ -1491,7 +1516,7 @@ static int acquire_first_split_pipe(
 			return i;
 		}
 	}
-	return -1;
+	return UNABLE_TO_SPLIT;
 }
 
 bool dc_add_plane_to_context(
@@ -1543,6 +1568,10 @@ bool dc_add_plane_to_context(
 			int pipe_idx = acquire_first_split_pipe(&context->res_ctx, pool, stream);
 			if (pipe_idx >= 0)
 				free_pipe = &context->res_ctx.pipe_ctx[pipe_idx];
+			else if (pipe_idx == HEAD_NOT_IN_ODM)
+				break;
+			else
+				ASSERT(false);
 		}
 
 		if (!free_pipe) {
@@ -1699,12 +1728,14 @@ bool dc_add_plane_to_context(
 						(free_pipe->plane_state->clip_rect.x + free_pipe->plane_state->clip_rect.width <=
 						free_pipe->stream->src.x + free_pipe->stream->src.width/2))) {
 					if (!free_pipe->next_odm_pipe &&
-						tail_pipe->next_odm_pipe && tail_pipe->next_odm_pipe->bottom_pipe) {
+						tail_pipe->next_odm_pipe && tail_pipe->next_odm_pipe->bottom_pipe &&
+						tail_pipe->next_odm_pipe->bottom_pipe->plane_state == free_pipe->plane_state) {
 						free_pipe->next_odm_pipe = tail_pipe->next_odm_pipe->bottom_pipe;
 						tail_pipe->next_odm_pipe->bottom_pipe->prev_odm_pipe = free_pipe;
 					}
 					if (!free_pipe->prev_odm_pipe &&
-						tail_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe->bottom_pipe) {
+						tail_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe->bottom_pipe &&
+						tail_pipe->prev_odm_pipe->bottom_pipe->plane_state == free_pipe->plane_state) {
 						free_pipe->prev_odm_pipe = tail_pipe->prev_odm_pipe->bottom_pipe;
 						tail_pipe->prev_odm_pipe->bottom_pipe->next_odm_pipe = free_pipe;
 					}
-- 
2.41.0

