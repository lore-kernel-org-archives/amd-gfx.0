Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FE9CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0F8D10E8C9;
	Wed,  8 Oct 2025 18:49:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ONzJ4w1s";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013052.outbound.protection.outlook.com
 [40.107.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFC2B10E8C9
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbXEEjI6n8YVq9i7DBIJI4Jd8cOXya2au5WbzRI2Wf68hsUicCDWybTsi1m8JNh7nM8ViZMPpuuNGOS0YkQJbPUwBHI6zpNQtmdkoICoWgoL++YNjq8syEQ2e4OysWRrY0UxHyH2k97Dd9AwweL0qsQUMejEPibtDpzUBFg3PV9nUIHWGpu2mYNqBRQ2PFguyB+T8gGHa/nhnHhJFi/1QMGjVvI0QMMUhR0PxlA4aHmw3ojOxkpx3gThsupwG4XtzsACgmb4ubs49pX31dMWcfvr7hBQIxJ5ZH1ElPb5iXPhevPp62AUL52YwYFsj4/mIUcI7Z2iMxgrtoXBAcxnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHRQeGVs8s+8hKgm+vj3jopZ13fIvX2wWGig/UIudzY=;
 b=ttbW0TfEOuZ024Yq6MJR29i3+eLMfIQ0VlgfLWy9O1TDY2+QHKLoQcE0m9Fg60Hus2kTbYEvuNb2fPXDRBIqBNcEmVEVsBxFgGw0n6XadmECtl1/YjZWpQdyi9R00xMIXJcloMb9CNsmso01l/vLPm4MR6cEunok9xnU2YFsQhVq3KD9MQyj9ztRPWFhsnoohxJ1XEvH9Spz0PpLUBVsp/2O1Mi7eYpajbcgUxGEvgvQQcNbKnVuAeXkBzeU8NHnPG7sMZ5JtLlVHs/spIo/g2VDnji+9Y9ozRHWLo0bv82jmUWU9Fbt5D7PHxF2mKy8nGlr0Ab34EmHed8TGM/MKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHRQeGVs8s+8hKgm+vj3jopZ13fIvX2wWGig/UIudzY=;
 b=ONzJ4w1sF4v31Q59kdU06gIvqd5lRLZazW3sBnEQSSDuzmqyOpgwscGp0tKntqaUA7rYtyEUSfw9Kj0MwuYQEHIMkko4PfRu8J0j0lpx6/D0Zp+IWMSoOiAHmtU1JAUaJjtM3pE3VZ0e+kuadv+n2WLCEmayCxKjNuDr+YHHRZ0=
Received: from BYAPR06CA0058.namprd06.prod.outlook.com (2603:10b6:a03:14b::35)
 by DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 18:49:36 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::18) by BYAPR06CA0058.outlook.office365.com
 (2603:10b6:a03:14b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.19 via Frontend Transport; Wed,
 8 Oct 2025 18:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 18:49:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:51 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Oct
 2025 13:48:51 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:50 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 16/22] drm/amd/display: Add sink/link debug logs
Date: Wed, 8 Oct 2025 14:47:10 -0400
Message-ID: <20251008184839.78916-17-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|DS0PR12MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: c25dbde4-2bab-4268-0a7d-08de069b6da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uwEr9hm11/G89MadeLFPGqfsrcaSfu8Gt96jsv7oZroz5A0FPxAxzxmuIqpY?=
 =?us-ascii?Q?wdI2L5W7iqo3v4TG1O4py29SuBMCWk6s/Jwf794B/xmvaX2y0T50dk6BEZcH?=
 =?us-ascii?Q?F5lBZxi5x2A1exXlJgIfqeyGWkEAVLd//z8xG9yQIV4fRk5bQidD2kMccxGs?=
 =?us-ascii?Q?fH0rkl+8uLZ53adnM2AHdky9ekNE6A4N2edOr94A1vOEH5REs1zq0wOHpgHY?=
 =?us-ascii?Q?0BhzmBP4mqf1+LxV7GedUlYXNCMe6kZixOQbLDGykfjTwXuBEX/tGiSo2muk?=
 =?us-ascii?Q?2uaj2r6/PecO0vCFaV7ej0QiwR1Hu2RBjqniTneW2X/jbGL0Iq+LzluH39FN?=
 =?us-ascii?Q?CuO5aFT2BYfDqht1dJpF2W4JBi/kigobuJUF3xTKgv1Zq7OQzbSp3+LhCgJ8?=
 =?us-ascii?Q?1d74WcplqQCvXlQh+ybWTo1U+yvkvj6yK0WMnljYWtoA3yP6EVNTsOz6TqxN?=
 =?us-ascii?Q?kY/Nq98Gj5qqQ+sLfVFpnzcfORNZeIP5bucfecpJDV8V5t0oBEGikGOax/jw?=
 =?us-ascii?Q?sMgfnw8qUw0JeZDRFD2IlqfwILGoHCKTEb8jFiXyGYWOBDcQzYd9LBmYJq57?=
 =?us-ascii?Q?mvtjaCcFwpWVCJ1PllXBpZNBoAn84d7IwEWDDPas+CLRXfseVsur0fLPGWR1?=
 =?us-ascii?Q?ixSlnwoSV6ZhBUfMjNhyobZL8RkTc/AL2Zy1huO8+xysdZH0waefjq8WCkKA?=
 =?us-ascii?Q?vghOUFP1UZ0sk4k0ymY+nSWQVg1ECzh+UodhXmC6xPhjR6bIF1nK6im4ByBm?=
 =?us-ascii?Q?RrpWZhWjeHuMjRqbgV91fPOli6bCfWA8Dhs7dWJR96o/iSI1zi0oY6xex1QJ?=
 =?us-ascii?Q?mqsjldncMR/SvaSPYjH/rgtMyk1TsWSds0Le2SA6IMkAYgannYhxWz12lPop?=
 =?us-ascii?Q?bL2/2rW+9dFFPENO7EItFciUXVKDHdkfwg/24r/1GzdlPCIGmrs5Di6VwZKD?=
 =?us-ascii?Q?W6D/a2GNXj7A43mOioHdwaB2HQBApribxekd7bF3WOFikhy+M3JxT+57aQtH?=
 =?us-ascii?Q?w/3DT2c2cahj5slpCDqO57gSps/RbBQ4WW3NE+WLXwcMdrETt8vmJSkkityO?=
 =?us-ascii?Q?txatN+lth/w53ikKloFeiV3r30dz6UVMCc8zbaunBH9MaRdHeSLpSo5Pgp+z?=
 =?us-ascii?Q?bL/5t8mlA2VqJ1PzYCe6ZbHFg3tSCu/vD8V6qL+IEcjg0rmlM5keXZs7qYFe?=
 =?us-ascii?Q?OVQuujZaWAs4SVfMhW8d1RzctJKuNG0o3Glw0f2Vpg+q8pNYqShZckrgfTEG?=
 =?us-ascii?Q?8cAzuVOxIokxfX5bJIaBcRZbaf2foM5lIeGT6X8mBOxbH3pDo1vS5flcoCWl?=
 =?us-ascii?Q?yZVWAOjfP56HExLAWO1Trlhd3nwjL1OJEKD2Im7aAxUrZE+gGP1+OL+AnF0/?=
 =?us-ascii?Q?yBGFnMSyq+bawoeWHAy28f6/iuGnNg06PIKBYtbPntO1ga4I3/QzALmCqLD8?=
 =?us-ascii?Q?k6wqN20lxifO6rtuJ6R1KzpsrBivehjE+aUaD3jcPLbD+ROU5IMtJBr8OYni?=
 =?us-ascii?Q?QtbvvDyfSHlXorfVD3pkJ2cFBMmcwWXFNg5/tjPtfb6pL8PxKCJUn4Wx7qpq?=
 =?us-ascii?Q?3M5V1Sz6xhfQj5XuKB8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:49:36.0883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c25dbde4-2bab-4268-0a7d-08de069b6da2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502
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

Add some extra logs to better help triage blackscreen issues.

* Dump all the links to see if they have sinks associated.
* Print the edid manufacturer & product id associated with a stream that
  was just created.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 73 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  6 +-
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6f5be090b744..5a0652e19890 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3394,6 +3394,67 @@ static void apply_delay_after_dpcd_poweroff(struct amdgpu_device *adev,
 	}
 }
 
+/**
+ * amdgpu_dm_dump_links_and_sinks - Debug dump of all DC links and their sinks
+ * @adev: amdgpu device pointer
+ *
+ * Iterates through all DC links and dumps information about local and remote
+ * (MST) sinks. Should be called after connector detection is complete to see
+ * the final state of all links.
+ */
+static void amdgpu_dm_dump_links_and_sinks(struct amdgpu_device *adev)
+{
+	struct dc *dc = adev->dm.dc;
+	struct drm_device *dev = adev_to_drm(adev);
+	int li;
+
+	if (!dc)
+		return;
+
+	for (li = 0; li < dc->link_count; li++) {
+		struct dc_link *l = dc->links[li];
+		const char *name = NULL;
+		int rs;
+
+		if (!l)
+			continue;
+		if (l->local_sink && l->local_sink->edid_caps.display_name[0])
+			name = l->local_sink->edid_caps.display_name;
+		else
+			name = "n/a";
+
+		drm_dbg_kms(dev,
+			"LINK_DUMP[%d]: local_sink=%p type=%d sink_signal=%d sink_count=%u edid_name=%s mst_capable=%d mst_alloc_streams=%d\n",
+			li,
+			l->local_sink,
+			l->type,
+			l->local_sink ? l->local_sink->sink_signal : SIGNAL_TYPE_NONE,
+			l->sink_count,
+			name,
+			l->dpcd_caps.is_mst_capable,
+			l->mst_stream_alloc_table.stream_count);
+
+		/* Dump remote (MST) sinks if any */
+		for (rs = 0; rs < l->sink_count; rs++) {
+			struct dc_sink *rsink = l->remote_sinks[rs];
+			const char *rname = NULL;
+
+			if (!rsink)
+				continue;
+			if (rsink->edid_caps.display_name[0])
+				rname = rsink->edid_caps.display_name;
+			else
+				rname = "n/a";
+			drm_dbg_kms(dev,
+				"  REMOTE_SINK[%d:%d]: sink=%p signal=%d edid_name=%s\n",
+				li, rs,
+				rsink,
+				rsink->sink_signal,
+				rname);
+		}
+	}
+}
+
 static int dm_resume(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -3579,6 +3640,12 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	}
 	drm_connector_list_iter_end(&iter);
 
+	/* Debug dump: list all DC links and their associated sinks after detection
+	 * is complete for all connectors. This provides a comprehensive view of the
+	 * final state without repeating the dump for each connector.
+	 */
+	amdgpu_dm_dump_links_and_sinks(adev);
+
 	amdgpu_dm_irq_resume_late(adev);
 
 	amdgpu_dm_smu_write_watermarks_table(adev);
@@ -5389,6 +5456,12 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		amdgpu_set_panel_orientation(&aconnector->base);
 	}
 
+	/* Debug dump: list all DC links and their associated sinks after detection
+	 * is complete for all connectors. This provides a comprehensive view of the
+	 * final state without repeating the dump for each connector.
+	 */
+	amdgpu_dm_dump_links_and_sinks(adev);
+
 	/* Software is initialized. Now we can register interrupt handlers. */
 	switch (adev->asic_type) {
 #if defined(CONFIG_DRM_AMD_DC_SI)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index ccaf37d3e7e4..096fbb8ad24c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -879,9 +879,11 @@ void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream)
 			stream->sink->sink_signal != SIGNAL_TYPE_NONE) {
 
 			DC_LOG_DC(
-					"\tdispname: %s signal: %x\n",
+					"\tsignal: %x dispname: %s manufacturer_id: 0x%x product_id: 0x%x\n",
+					stream->signal,
 					stream->sink->edid_caps.display_name,
-					stream->signal);
+					stream->sink->edid_caps.manufacturer_id,
+					stream->sink->edid_caps.product_id);
 		}
 	}
 }
-- 
2.51.0

