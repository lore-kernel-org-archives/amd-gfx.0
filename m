Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC398C64EC4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A9610E6EB;
	Fri,  3 Mar 2023 15:52:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7D9810E6EB
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cB9QzuDUcH68LrFeNWcNQaXhulZ23hqD0LAdG2mqY/w08rw/znGK4E/HV/D8Ld0DO5DsQ7zd+Eratn+VYOzbo3k7ZZFlNs89pndlj4T6emPMVB7pWR9xJ4PQaVuFb4repf11G5jQSwo6oHatNDbz6xVhbmsLKdJgRQmEcmPOzQs7xkOW6V4/u1yHAACm6a1SV39so5XiGY7gB8DSyqWr7aq5zO84EyPZ72SaDHQuI8frHtSL+BS3v7npG3GvcQ6CD9ab414H2mEwLdP/O93i1fqKYPaJXYtLSNaPquFiobkqlo9o6K02BKT/bbDmh7/vgsEGAfmXOJ2vhXH5NrL0xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqmv3+slERWXacOSKPAiDUmYfSoLL7sI6NpIRAAiVMg=;
 b=YJmvIPJvqgU0GwtOoXZKCiGmS7hIwUexkt75J+unU2Dyg+nw8k6BuUChvoZh8GAE0yWRyeESu1QOIwuEleIBZU6U5YWOt21rJj/rdkPUoVoJ3yzpSBpq0eC3kVdQ/76/l983WUGUfxQxgLyPSWti8fu5kRGdUBlH9kqmXRxDOVIx3fG3SJi2qeOKQCYXUjkI5Go2gkbKMai1MDK8nIILRQJB7BV61xRUQ4dsw7ejUm6N7yChGVRhKAv8/s/A4an+0iB6iIgvFLCnkjRW9IuSV7O/nlDCdb6oAMIxaTYM1fe8DfkRJvvyv3/WxE5gfARFkPEAO0u72J8jfGKuPxZ9JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqmv3+slERWXacOSKPAiDUmYfSoLL7sI6NpIRAAiVMg=;
 b=ZXqVLlgcM4xqijBrqT79bdAY2CL2UOUsCM46pQJlg5vEpvzmfl2W6K79FiQ7kesVBwHHbufW+PJBjca1KrvgoxvXB1w8Vk7TKXQMxoqgYmnaqhPmx+chl9ngVFIEvBgKKksYtmwZBWGJlWpEoj2lTWaKmKlVPscwNelmokr7WlY=
Received: from DM6PR02CA0100.namprd02.prod.outlook.com (2603:10b6:5:1f4::41)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 15:52:12 +0000
Received: from DS1PEPF0000E633.namprd02.prod.outlook.com
 (2603:10b6:5:1f4:cafe::20) by DM6PR02CA0100.outlook.office365.com
 (2603:10b6:5:1f4::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.20 via Frontend
 Transport; Fri, 3 Mar 2023 15:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E633.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.16 via Frontend Transport; Fri, 3 Mar 2023 15:52:12 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:52:03 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/33] drm/amd/display: Add wrapper to call planes and stream
 update
Date: Fri, 3 Mar 2023 10:40:20 -0500
Message-ID: <20230303154022.2667-32-qingqing.zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E633:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c944347-8b23-4219-cd88-08db1bff40f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7+5oHENVJuZn3X6Yi4VUSJE703APBEaAB0TbyKQ1g+BBeaMjEfCX0F/S9dscH5W8MtHqnCKmLa5uXIdselsLi/ahD88YNGe8rZHrIB8UYtea0RmQueEXIVjZXtVmJAMaRAaqKSNuxSv2Sg/vsGiY7LWWj+oTBZGZVpgCZaX+b3yK5OdBeike5sViRNN3jCMafCRZY+Q1DFRkXwZ/nqXJS0iNBiu4JUx2s8jzze88L3DevgGZOucnY8jOLDGUfk/Q6qaBzI57fu5W8F2l38jLNRfJaSYmqTWZ8gQyF24rLP3ghTYWOjsnnM5NVgUwzd+mnRynJcgPnDWybo/gPrMAZ3RN8Jl6eKF5j7VTsUHR1EtkNXch+ahAtTe7JiIU31i04oxalcZZvNkoj5olIDN7krCxMsM4Vk1P2+QeWZ9vAYcANvF0d+lOKLOejyMmmwo4aIalOpx/QIt1WVJB7o7WryTRLOXYQXiYce8nZn2H3Vc8XUdslp84yjXVF+pdhoFpVjPQz9Xb/l8qgy3Zgz5wDRQ0AQGUDhp4cZGSJnddtIU6gwr8KYJY1RISNh07xJvjA4dGZbfvPnTOccPyK8GDA0aC8RGJpPSevS7Kemh5bCmUITA4AI8hmjQLBwjIw7JVOLC0T9a87PHCgysUA4FUdknB17g5P98A3mJFhFbHsMpFqrS/z+yMxJmWcIPwThNa9LznS5rVTzF3kCp8JDnCvpI+V4ko+dIRkU7YzKTbQc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(15650500001)(186003)(70586007)(70206006)(47076005)(426003)(36756003)(478600001)(40480700001)(40460700003)(16526019)(2906002)(6666004)(26005)(86362001)(1076003)(356005)(2616005)(336012)(316002)(44832011)(41300700001)(8676002)(8936002)(54906003)(81166007)(82310400005)(5660300002)(82740400003)(6916009)(36860700001)(4326008)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:52:12.1930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c944347-8b23-4219-cd88-08db1bff40f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E633.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[Why & How]
This commit is part of a sequence of changes that replaces the commit
sequence used in the DC with a new one. As a result of this transition,
we moved some specific parts from the commit sequence and brought them
to amdgpu_dm. This commit adds a wrapper inside DM that enable our
drivers to do any necessary preparation or change before we offload the
plane/stream update to DC.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51 +++++++++++++++----
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fadbeaaf5499..63d9d7ffb103 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -348,6 +348,35 @@ static inline bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
 		return false;
 }
 
+/**
+ * update_planes_and_stream_adapter() - Send planes to be updated in DC
+ *
+ * DC has a generic way to update planes and stream via
+ * dc_update_planes_and_stream function; however, DM might need some
+ * adjustments and preparation before calling it. This function is a wrapper
+ * for the dc_update_planes_and_stream that does any required configuration
+ * before passing control to DC.
+ */
+static inline bool update_planes_and_stream_adapter(struct dc *dc,
+						    int update_type,
+						    int planes_count,
+						    struct dc_stream_state *stream,
+						    struct dc_stream_update *stream_update,
+						    struct dc_surface_update *array_of_surface_update)
+{
+	/*
+	 * Previous frame finished and HW is ready for optimization.
+	 */
+	if (update_type == UPDATE_TYPE_FAST)
+		dc_post_update_surfaces_to_stream(dc);
+
+	return dc_update_planes_and_stream(dc,
+					   array_of_surface_update,
+					   planes_count,
+					   stream,
+					   stream_update);
+}
+
 /**
  * dm_pflip_high_irq() - Handle pageflip interrupt
  * @interrupt_params: ignored
@@ -2673,11 +2702,12 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 				true;
 		}
 
-		dc_update_planes_and_stream(dm->dc,
-			bundle->surface_updates,
-			dc_state->stream_status->plane_count,
-			dc_state->streams[k],
-			&bundle->stream_update);
+		update_planes_and_stream_adapter(dm->dc,
+					 UPDATE_TYPE_FULL,
+					 dc_state->stream_status->plane_count,
+					 dc_state->streams[k],
+					 &bundle->stream_update,
+					 bundle->surface_updates);
 	}
 
 cleanup:
@@ -8163,11 +8193,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				acrtc_state->stream->link->psr_settings.psr_allow_active)
 			amdgpu_dm_psr_disable(acrtc_state->stream);
 
-		dc_update_planes_and_stream(dm->dc,
-					    bundle->surface_updates,
-					    planes_count,
-					    acrtc_state->stream,
-					    &bundle->stream_update);
+		update_planes_and_stream_adapter(dm->dc,
+					 acrtc_state->update_type,
+					 planes_count,
+					 acrtc_state->stream,
+					 &bundle->stream_update,
+					 bundle->surface_updates);
 
 		/**
 		 * Enable or disable the interrupts on the backend.
-- 
2.34.1

