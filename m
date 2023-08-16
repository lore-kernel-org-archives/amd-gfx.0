Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15703C27C43
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6C4510E3D1;
	Wed, 16 Aug 2023 21:32:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A23C110E3CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:32:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4aHPU3FvRs+dqMkFZIRXgGjUUNz9QMWmRsgCw3JOLjrppQf7QO0s9IEsuHAr0qFaX59UtK23ypjn6UA9bosPMPLosEhFYEIQ0ZzWABzKockskj9dzqLHtczMyX93zgEWwrTa+i8sh/B55/bcpcgKX21tNJ66xYdu7rZr/5XPNYgon3VFgij+FoVp018PHaUxij7NgwteTy36DGHG8vW/4G0vp1sRvIHM1B5Ye6716kGys0+/NR4b9SWgo+XrA8jR5G7w3/lFHLr5LHjWAo9xOyXkwzSmcj8UKyaGE+fU2w/2aEGINCKFwAcg4cbs01BgiOKFT5wBLXH3+uePYlJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLpgNmbdgKyuNT/ZjJGAkNmFFOfK2VWO0MOLpNn5/O0=;
 b=OiqWxZz5gP81kNfXiQHiYfmDzEAjJN0o/TrCYWptTh/5NNdURUWSwvQgdnJwCPE23oP3BZskJSLdpbA7jy0YYmzxbZXLO2VR0rsC1MII8h1aFWAwmb405FO5lCeumEdFweBFd7hPaVsyaZN9vCjptzWoP3LeeoB3IHvpSbkuh2h3GGPiUtHRMJAs9xVccFbDO/0GgIbmxmZXfiPRmnOFBDdEoMJuLxj2Ie+yaO8SpTQ5+f7e2UKCrw+ORgJXdNxACEaF04/QOzTLnM6VYDpAZNyNhu+m1IDlGu6pCKMicUcj0PNv3Fjic8/Jw+16g9ZGjEYuYh4ukZ2aZ7cDBhlCOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLpgNmbdgKyuNT/ZjJGAkNmFFOfK2VWO0MOLpNn5/O0=;
 b=TqDazURnZvVkZbGBLej9+PCd3LOdiYXMscas04KZE7YhDULGK30kWOk2lYNRaINM/ATeMzm+34t+W8kHOIHGRTJpq/jR44xHalZhrWro2x4l4AdrXjvVe1gWaso/gL23p1BBD5hZvlm0uCHgT9y6IrC+ANQKItMVZuJDU9VAoKs=
Received: from CY5P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::19) by
 SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Wed, 16 Aug
 2023 21:32:26 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:b:cafe::63) by CY5P221CA0020.outlook.office365.com
 (2603:10b6:930:b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 21:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 21:32:26 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:32:18 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/18] drm/amd/display: Disable DWB frame capture to emulate
 oneshot
Date: Wed, 16 Aug 2023 15:26:26 -0600
Message-ID: <20230816212626.987519-19-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816212626.987519-1-alex.hung@amd.com>
References: <20230816212626.987519-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d75fb2-f496-4d38-de8e-08db9ea0491d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cs7CGXwbKPVIx0B4hD5YvsFLcgBlJhLL6PqfWR4+g3o6VyrYfjqT3shX6amUfM7I2Pafvjw1x7b275dlunLY1eY36dZBXHNGls3a4rNZhvfA2mY6Sxr9Cmf59OYneX/zc/6KN3sD5UKuRDPzifgLdbum5HLGwZUfDwc4SrWfup3iiZrZyQUa52+MCR3VY2++VFOhqkpP2OhEIWUutAVwBunf4NCUeO+KPuYtDr1e82i67/tAWCPXApOBvu7rn4NnRIyPLba/T6u8JNSWaET0zvxk5+1++VWmoMjQBxvpC/57ydgqglqflkcAPGBx+0uBIM3vFsjnSnTcbnk8elKQqb4V3N4u23xiVNvZ7CRcYZMhOtTOflcI9LZc07Yx5F7PEMUBeUsyuBr2Ok0oT+uw5+/UkUTRzfFLYyY/5xe5uRMemeOZHKgEgTMmjll6R5TLYLYHYuZTyNcUT4e/ClU89o2lcfbD7IEpmGELqJ2oE2I57b/CdYHbTaM701wK+2IPv5FSD14O1yJOp3AsxITxpCgOsPWMFKY5A4U6CTN5xJ5Gd8gBwIoRpw3HLMUox3ofq+nhc7Q7H4jq2pGjtyhTy5XGPvmoQ9jjXAx5cEbAW9OjYz9afXdAUVpQS+U5yaZyGW/UI3VTAuAKOrIhoXdc1N5OojqXkf4YVlx3mS83xsPjiLqfvCx0VRqlsFbTpnWPOfcI43Fhb1ltx3xzMdwQt2usmm7vfQyWtKzG6GGJ+lpEdTIrZdVPNlZQJkQ9bzfGqYsUpfwWP7+a3GMGoiLAwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:32:26.0613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d75fb2-f496-4d38-de8e-08db9ea0491d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689
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
Cc: alexander.deucher@amd.com, Alex Hung <alex.hung@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHY]
drm_writeback requires to capture exact one frame in each writeback
call.

[HOW]
frame_capture is disabled after each writeback is completed.

Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 27 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  4 +++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9051497eeed9..3e3efacec9e9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -589,8 +589,20 @@ static void dm_crtc_high_irq(void *interrupt_params)
 						       list_entry);
 			spin_unlock_irqrestore(&acrtc->wb_conn->job_lock, flags);
 
-			if (job)
+			if (job) {
+				unsigned int v_total, refresh_hz;
+				struct dc_stream_state *stream = acrtc->dm_irq_params.stream;
+
+				v_total = stream->adjust.v_total_max ?
+					  stream->adjust.v_total_max : stream->timing.v_total;
+				refresh_hz = div_u64((uint64_t) stream->timing.pix_clk_100hz *
+					     100LL, (v_total * stream->timing.h_total));
+				mdelay(1000 / refresh_hz);
+
 				drm_writeback_signal_completion(acrtc->wb_conn, 0);
+				dc_stream_fc_disable_writeback(adev->dm.dc,
+							       acrtc->dm_irq_params.stream, 0);
+			}
 		} else
 			DRM_ERROR("%s: no amdgpu_crtc wb_conn\n", __func__);
 		acrtc->wb_pending = false;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 0e3ade920c4d..b65d9645f6ff 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -538,6 +538,33 @@ bool dc_stream_add_writeback(struct dc *dc,
 	return true;
 }
 
+bool dc_stream_fc_disable_writeback(struct dc *dc,
+		struct dc_stream_state *stream,
+		uint32_t dwb_pipe_inst)
+{
+	struct dwbc *dwb = dc->res_pool->dwbc[dwb_pipe_inst];
+
+	if (stream == NULL) {
+		dm_error("DC: dc_stream is NULL!\n");
+		return false;
+	}
+
+	if (dwb_pipe_inst >= MAX_DWB_PIPES) {
+		dm_error("DC: writeback pipe is invalid!\n");
+		return false;
+	}
+
+	if (stream->num_wb_info > MAX_DWB_PIPES) {
+		dm_error("DC: num_wb_info is invalid!\n");
+		return false;
+	}
+
+	if (dwb->funcs->set_fc_enable)
+		dwb->funcs->set_fc_enable(dwb, DWB_FRAME_CAPTURE_DISABLE);
+
+	return true;
+}
+
 bool dc_stream_remove_writeback(struct dc *dc,
 		struct dc_stream_state *stream,
 		uint32_t dwb_pipe_inst)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 3697ea1d14c1..fac31a56b89d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -455,6 +455,10 @@ bool dc_stream_add_writeback(struct dc *dc,
 		struct dc_stream_state *stream,
 		struct dc_writeback_info *wb_info);
 
+bool dc_stream_fc_disable_writeback(struct dc *dc,
+		struct dc_stream_state *stream,
+		uint32_t dwb_pipe_inst);
+
 bool dc_stream_remove_writeback(struct dc *dc,
 		struct dc_stream_state *stream,
 		uint32_t dwb_pipe_inst);
-- 
2.41.0

