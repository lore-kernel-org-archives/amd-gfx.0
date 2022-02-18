Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26290C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A71A410EEFA;
	Fri, 18 Feb 2022 15:04:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3DB410EEE7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 15:04:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nj5jAHtGcZTaBEYQlaTje2X71J/m+J7J/Dexh9jchb3yJaJ+NrI+BS7JF41jle8tKv2akiNVd3siIw79rFQi3O0476GSnjIh15jvNVwUWhkghS7x1IeabB+VKFFQpzNXJEkLLh09gtTZ7uUQhJ3/iEghA/IXkvH7d0EI5hHkNTM8wnXLcxsWZvBz+RBRxs/EmOxsEYCEGrRov20lumkDGwPV+WvUIcoirEZF3twuIpxsOOCisknX8p2ur4lu/nJTW5lS/RUWjDNSyWAhMaE9GaT6q3GWm97AOZM8bm9VLSLmahPz/Dx+FG89J7jRTwaHI7hdg+5I6f5iFd3NjQ5b2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEwOSIde4lZsbw9xtK2OHjcfLZ8owFwqnnzML94aQQI=;
 b=hkjgS34d/NWMuLwSdWfJmaHpcqehJQ9iBI/nrO1pMsvTpbC9fKqUcpqncaveXp7A4wG+wSLYPJ/5iHYkbga9SMMy2XLVHtpuX+4vPYucSVfdIy5U16vWok4LoG0y9DSBx4Rnq0AJjqQfHPqe7fnJfCrcdHvI5ExhmbA2KzTM8A9LUb4xvZVEKoqY8aJa3fRIAT8vZw1LH6Meb4LWciKC5hQ7kpRk4fG+rWP3I2Fo/MOwlNbqjbLAW3xwPt1w37C6GuAHGmo8LLABpYoU+zSNl5rwoWWeDugPkgJFak0k+xLfxyxhh1P5SdpBgR6/wnFDg3EAWcjOae/sTSqZjqqRww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEwOSIde4lZsbw9xtK2OHjcfLZ8owFwqnnzML94aQQI=;
 b=x99JfoGXTJ5aRwLYywP9HQOa+KawhD9uLeCd1GPnvKl2U7/L/wfNV8RMtTb+mvUmJOCMrEWHYUHbKjozCSUp4JHH5opLeqVAQ+zzIelkrcEIc4q0APeTMgFgeaVCGHYakuVk+oFh7oQXwnQuszsISAPQsn4gjq13sySHlXViBwM=
Received: from DM6PR13CA0028.namprd13.prod.outlook.com (2603:10b6:5:bc::41) by
 DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Fri, 18 Feb 2022 15:04:41 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::d3) by DM6PR13CA0028.outlook.office365.com
 (2603:10b6:5:bc::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.9 via Frontend
 Transport; Fri, 18 Feb 2022 15:04:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 15:04:40 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 09:04:34 -0600
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/12] drm/amd/display: clear remote dc_sink when stop mst
Date: Fri, 18 Feb 2022 23:03:24 +0800
Message-ID: <20220218150329.7976-8-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218150329.7976-1-solomon.chiu@amd.com>
References: <20220218150329.7976-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79d8d452-e179-4989-d41d-08d9f2effd3c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5294:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB52949DA50CBF28F9A690E70B97379@DM4PR12MB5294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UtpVlb8r8jQeHyCwy228EBS2rtlLyH0H6ufopg6/0sepa6qVFWHOZGSkSiJZ8ADF6nz5vJO7201NEvc7rzTf6F7gvY0SRhDrhBHFT3H1fEPx+lW/D2fCh9bTTvCxQWJQ2jr9+EYDfIK1rM9bioteBwmVUxTWQ9aHPLuUUlxQcH7Fa1n3iCRTBXEcB7DX7EzvlFMBvUsjU9zaLtOI3YKQzfmeyG5+kckSfyCe/tp+o8zV4gzjA41rRHVsZFRi1WJ/C0Tua6dZd+E0ZCoLc989lCASpOvCYXyC6ARzUuRY3/5Ck6gBBq1jCsGPf7nemBWSR1j5Bd9HALzAE06dq/uIGWnH4nLHDjUIapUZuTM1X5CM/ryMkw17OMiPAQ3NMQG7TYpjkWEZ3omlxTcUjysIfiT+jXUQXJri6KbhG+HCpujUnZGagKjhzevyojkZ8A1Z+2RIokyVKrsf/kDrJ2ebdYYC38kT4c1A62ACkRpn1mWPizmd173hXDFbSj/zsRyCEmZJlbzC8Nmp1L+tWa08nw0n4GKx7FRL2zMHYskJlaG1nbF5mswLJUHMpScjmqD1VGln6ML+tAVyXM0TBunkGsYWo9cVO0DEl8eMFvMxX/yq4Zg6i1hTJmG6cu7UYtOJBUDZKted8WTBdQoekaqVWRFkqUZTrlgaArXcxV5OzS7xsX6tlAHteqD2ENkCwcIUOgoVFkMkt9UzVjI20tbvpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(44832011)(8936002)(70206006)(8676002)(86362001)(5660300002)(4326008)(83380400001)(47076005)(426003)(70586007)(82310400004)(16526019)(336012)(1076003)(40460700003)(2616005)(186003)(26005)(81166007)(7696005)(356005)(6666004)(54906003)(508600001)(316002)(6916009)(36860700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:04:40.8269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d8d452-e179-4989-d41d-08d9f2effd3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294
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
 solomon.chiu@amd.com, Jerry Zuo <Jerry.Zuo@amd.com>, Aurabindo.Pillai@amd.com,
 Wayne Lin <Wayne.Lin@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Currently, we don't have code path to release remote dc_sink when unplug
MST hub from the system. After few times hotplug, we hit the limition of
maximum number of remote dc_sink and can't light up new connected monitor
anymore.

[How]
Releasing all remote dc_sink at dm_helpers_dp_mst_stop_top_mgr() was
removed by previous patch. Restore it.

Reviewed-by: Jerry Zuo <Jerry.Zuo@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 9536e819d5b3..6b2f6466abe9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -451,6 +451,7 @@ bool dm_helpers_dp_mst_stop_top_mgr(
 		struct dc_link *link)
 {
 	struct amdgpu_dm_connector *aconnector = link->priv;
+	uint8_t i;
 
 	if (!aconnector) {
 		DRM_ERROR("Failed to find connector for link!");
@@ -460,9 +461,26 @@ bool dm_helpers_dp_mst_stop_top_mgr(
 	DRM_INFO("DM_MST: stopping TM on aconnector: %p [id: %d]\n",
 			aconnector, aconnector->base.base.id);
 
-	if (aconnector->mst_mgr.mst_state == true)
+	if (aconnector->mst_mgr.mst_state == true) {
 		drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_mgr, false);
 
+		for (i = 0; i < MAX_SINKS_PER_LINK; i++) {
+			if (link->remote_sinks[i] == NULL)
+				continue;
+
+			if (link->remote_sinks[i]->sink_signal ==
+			    SIGNAL_TYPE_DISPLAY_PORT_MST) {
+				dc_link_remove_remote_sink(link, link->remote_sinks[i]);
+
+				if (aconnector->dc_sink) {
+					dc_sink_release(aconnector->dc_sink);
+					aconnector->dc_sink = NULL;
+					aconnector->dc_link->cur_link_settings.lane_count = 0;
+				}
+			}
+		}
+	}
+
 	return false;
 }
 
-- 
2.25.1

