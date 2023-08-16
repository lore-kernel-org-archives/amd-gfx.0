Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8067EC25B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08CB210E3C8;
	Wed, 16 Aug 2023 21:30:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B01C10E3C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:30:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxB2L4jz/6fywtdbKm+0rV6r2LXbLCUvvE/FgFS2rRNVFhzjaVXmKh8f+Hk1zJGU4jKL/u84fHKaPkCcg6mNs75cJ+2dJtH2GRiqlBbRq40XcngDFIaN1tPSOuy+Ay4R++tpwsMIVHcGzG4FZEeX48xl7PWLMIdL/Pa4sOIndooQvc2tfdEZjAAwCJAizKc2/mHjCJbslHcfHqKNbFqPx8vfZYI2tvISL2nvRtJIXephdPRomtnYhUOZg4hXZj/AncdlStlMZnfD/TpqawtdWp+ZDF3PJOlzTc54iKdsNUKe1m1m8q04yMIeAzWR9CofMKdhuQXdbzQ+wMYP3pZezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3OKbg6rXvCtoEGsHncjBbSBuQgF0AfoaAu+ptM5Iwo=;
 b=iugpjrDswrmBMIkt3NQG9ys6nXwx/0d2SyOu5auqa+rlOY+Rvq9PXy5h62NS9U4RVzBgYIOycD12XfEIzOvajWmwDsuvxcwPbHzde0yGrjyC5dgJ35/DNzPEm4KopxoTsMMjzzDIB2JB4Pz+iuV//KS+wp9uBtJKgS6CtuvgfhLU/XfVFhTSkXaXK4zQCN6E4+x0+asNHHsSV/A19Uq825u5bl6ZtLhMLyGPHzWGKxniBgFTLFy/UWmst/p/CCYxB5JUFrP75JN3hTQwFuJ4nR4Vs+Zyrk+4r1k9I+DqXbB+uKHSIvcSoa82bPztVy58BgKlOxMqrrGtup3ffcphJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3OKbg6rXvCtoEGsHncjBbSBuQgF0AfoaAu+ptM5Iwo=;
 b=121TLo665gAvpuFmtSvZXZUXzbOvYfyQciNdSk8keHktD6Se+jzxJvRTNvgJKxEu85Iq7kKrwARTp7KSVqiew9d0iZHhEyeL0828oTByjVBC8iV/RVgFrDfXTaEtjo5GSeo56/+hqiAs1brqqTK5vw3t0ab1NFCaVaaDD1TKvzc=
Received: from CYZPR05CA0014.namprd05.prod.outlook.com (2603:10b6:930:89::6)
 by BN9PR12MB5051.namprd12.prod.outlook.com (2603:10b6:408:134::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 21:30:52 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:89:cafe::d7) by CYZPR05CA0014.outlook.office365.com
 (2603:10b6:930:89::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Wed, 16 Aug 2023 21:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 21:30:52 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:30:50 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/18] drm/amd/display: Add writeback enable/disable in dc
Date: Wed, 16 Aug 2023 15:26:19 -0600
Message-ID: <20230816212626.987519-12-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|BN9PR12MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: b2811214-13d2-4a13-95e7-08db9ea0111e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTL73lB3MKiwVsUJWs8ZpgvrnPAzXBqFIHVpS4ifWszpP/uLVDeAdIsvU0bKAUpbC9bovPOij0U3mKHOWB/S7mRds/sLhHlRpPZCAwH7YdBLTAGn+6CmSQrShTk0lmnV9lQC3gIaRM60m6S4hA+WVMKVhZSxl/DKcXa9QGyQ1hidAaceZmKqRrQbpJipHbZSXiThLCc/gUrNfoTzHWKXLDNe/i/brOPJ/CubwpaBvP6MVqFazFH0rM0F+R/AngV89rMHXtTenuJZH+yjNd9hBoO+FS+I6KRXMVsXoWUhFjF+OAX+viU0OS0UJcSKsMTV2sNOaDjRPpGuXbkRWABKnjcU7BICjL+w92QLikYez7YaEIEjdCm2jsDleO2S3x0vl9/4bMcRuLujexE4RW54R+i5P/5+vPaR1+1TSlA5wIbsEXqzOymzbbZoQvkgsAgA3DZN8n8NYvBsvMpd2EB01Lk4d7JBzYWblVA4EM2mFFcnh6fWIbJXWuN8vd+Lt2Mi+LzS7xebdO9b2AZiTNbLxqvCZsZBcXOhJQDiVCVFd5cfOjdjbIE4RJ4VJ3SXzOj240CzVdFvacmRJNfnMShxB/UApAdgn7fix55GbIwmjOjPWuqnBvar6GVdRobAyKzzDLRjtfE/CEzCt0743UE+tT1vo244+N5FKNwGDxFJlyl9O+COesGn4vyDR0PI2lGpO5xif2nZq9gTUgfR+oXhV3kahivmQ/WcRgHlwMeZnO06OWN1ZPkKKHKLZacAWQRVKFmY/NeUNpRQg4Sy6TWzdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:30:52.1136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2811214-13d2-4a13-95e7-08db9ea0111e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5051
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

[WHAT]
The enable and disable writeback calls need to be included in the
coressponding functions in dc_stream.

Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 33 +++++++++++++++++++
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  4 +++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 01fe2d2fd241..0157d9e55ca0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -516,6 +516,25 @@ bool dc_stream_add_writeback(struct dc *dc,
 		struct dwbc *dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
 		dwb->otg_inst = stream_status->primary_otg_inst;
 	}
+
+	if (!dc->hwss.update_bandwidth(dc, dc->current_state)) {
+		dm_error("DC: update_bandwidth failed!\n");
+		return false;
+	}
+
+	/* enable writeback */
+	if (dc->hwss.enable_writeback) {
+		struct dwbc *dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
+
+		if (dwb->funcs->is_enabled(dwb)) {
+			/* writeback pipe already enabled, only need to update */
+			dc->hwss.update_writeback(dc, wb_info, dc->current_state);
+		} else {
+			/* Enable writeback pipe from scratch*/
+			dc->hwss.enable_writeback(dc, wb_info, dc->current_state);
+		}
+	}
+
 	return true;
 }
 
@@ -560,6 +579,20 @@ bool dc_stream_remove_writeback(struct dc *dc,
 	}
 	stream->num_wb_info = j;
 
+	/* recalculate and apply DML parameters */
+	if (!dc->hwss.update_bandwidth(dc, dc->current_state)) {
+		dm_error("DC: update_bandwidth failed!\n");
+		return false;
+	}
+
+	/* disable writeback */
+	if (dc->hwss.disable_writeback) {
+		struct dwbc *dwb = dc->res_pool->dwbc[dwb_pipe_inst];
+
+		if (dwb->funcs->is_enabled(dwb))
+			dc->hwss.disable_writeback(dc, dwb_pipe_inst);
+	}
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 6cef62d7a2e5..d97c7da33b6e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -330,6 +330,10 @@ void dcn30_enable_writeback(
 	DC_LOG_DWB("%s dwb_pipe_inst = %d, mpcc_inst = %d",\
 		__func__, wb_info->dwb_pipe_inst,\
 		wb_info->mpcc_inst);
+
+	/* Warmup interface */
+	dcn30_mmhubbub_warmup(dc, 1, wb_info);
+
 	/* Update writeback pipe */
 	dcn30_set_writeback(dc, wb_info, context);
 
-- 
2.41.0

