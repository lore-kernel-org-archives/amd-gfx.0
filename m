Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C0ECD5BB4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD1B910E504;
	Tue, 26 May 2026 07:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xRfMK/3/";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C1610E507
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:18:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWcFw/QEehTCN0HZI6hW1aoywRn6VaFOy6wZx8a4WlZRYnyjrKpl5MQDA4FlCCXKv7+2NY7ouNt9h/lUAYZT93Vdw5933GA9B1Ms03K6vjmHR3cZDkAKVUWIbKrlzDu1acdD/n+nsOViVrXZyulLxof2uwWBAn9HE0r3SvX2cZx8UmatiO555wxF3fgmbDHT748w4xJHpF0hdH571wM9eGCGYqCx2D1+1PFNzfA0HWnyr/AqKbcx4tul1K4abqZtdQ0O4GkuMps1vHKLkRQ8reAuQyhKFhRutPAdvsNS6fLXscyhNlTVI/QCf/Vx7Q1rqaRjbylaahr6qXoKSPNJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/yhlHheplHQxxka9XSaFM2pVMsQQyvGRSO2xoj4Y9A=;
 b=Jjq/BgVpsbYgk2Bqp3FTeDGmsVNpanYUrA8hmtViP0hozjlBnyrE2DItzYnqObFtQGbtFtZBiIlN8C/eKaWxJSzxhYrBlY8amlYA9VRSCnzFZLdqoSRTh1zX8LllQumS4LLNZn9GvTSk22EiypDQxOFHyrGp1Enz5R77gNRHeJAQt509LHxUijQrgO1g/eh3BiO9LiVTbjb2c+Ve9oT0W7mbk2kIUWszIbdHps8HOzx5sIJGagFHABTY/6shBFuzkgfHLqYqt+fZYajy+b70Gc/vcoCuMm0fRtahd9wyremiwkePjKl4BApulSP0W1CBbUJlIVdY8Doim5dvYvxNYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/yhlHheplHQxxka9XSaFM2pVMsQQyvGRSO2xoj4Y9A=;
 b=xRfMK/3/dgc/P2jjz/y+mq6Fws/b8OozuNvn/NwO3USJrsjDAF5xWnOyhSNxzfwHK73LI4S473jOiKpNAJTpu57HvSZF4LaGndqLDCqfY3JV2FDvT+GfbHYBUT2n38VYTFOpxqvD4x4cI4ccdN9PZZ0HaErAxNKueTc8aYCYkPo=
Received: from SJ0PR05CA0012.namprd05.prod.outlook.com (2603:10b6:a03:33b::17)
 by BN3PR12MB9569.namprd12.prod.outlook.com (2603:10b6:408:2ca::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:18:44 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::1a) by SJ0PR05CA0012.outlook.office365.com
 (2603:10b6:a03:33b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:18:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:18:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 00:18:42 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:18:34 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 30/41] drm/amd/display: Clean up PSR helper functions
Date: Tue, 26 May 2026 15:01:53 +0800
Message-ID: <20260526071413.2181251-31-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|BN3PR12MB9569:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f632cd7-0682-4a3b-8b5c-08debaf70566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: 0P188MTbHNYCFs0B+Co8HpsVci6EwHvclaLGL9sVFUqS1eA3pV1SaH7oUgDyv86Ti86d1jOvi41GhjTlw/Mrcn0GOLqRqPFcBJDHVk6LXpUeGTNxn065rStLSrVv580KW5t6X/gaE1FxaocsZhKNBaJ76Rh1RIkdCFEpGTEvjrmKVK5yyqygX6pofVc3zBm0N8XHwhTiYzhnkFZAeUAVWRf9spJMGxUbnM0lTUcKgFIObvQ1YKBkLs5CRpkCqxbuxEgfs/RXiMwbuInLCK6h0BWNtAlWy1EC6zLQIqQyUVlBU0jJ4+bjosZoSZiUTIyL0GDW1FILvtlAPx6PkiG4k9eYyOjzO0friob2mqEYIC80u9dRNexx17hi6Y4tLsaxK/hNeMYRTSpgZlL4/8LHfrUdUvrZE6kDurEpobu0Db5DW7ZACIVoOM3qLKBmpiIWNKGZRzGmd6MMtfWtvKfNl0ic6cXTV950WT4juZ26phbKFYV4skDu4abj7g90D2ABvtIuQfrAB6inmWMuY7pu6TjvJxWbi2fVv08DlAzdqVDaplX76JYh9jxAyTyhee93gw/sstvdf3/CDa01hVhF0I/wg+kQVmJac6m8r4GJ1j9LaB6yoNGS5flx5cLwpxrMP9+c8ah+6c29sWR1nf/sTcmsNFCIZJAw4RWGKfuBy7hNgR3mIOVhuk33ICvxdhvVt65G8J//SnydgaV0fo/vg/Ud5AuSdRAC52B1pYkA1ao=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CqtEMZ3Pl9U5JrWtPMX6OIFAwp19a+r26OOIb30qscDzW5Ru6lvu21eY5U808ru6TziVT4ytkQ3mBZ7Mz4JqatpEfjq5xcP5pGOQSPb4zf1MqZFqpMI3fCyqz5Yzm+f2hiuJIN2SA0EHMPyRkdqGpcGOeWv4r1cqZESZMAz5G6EKwNQx54yWPyFn4d4i4IcrhsZ/2z4YxJCv9x9O1Fvm3vIuHCJSxbpEQ++BR2P0A+L/4HXb30daQqdHRIOISRIq9Dh5XeP1YOsp3PH2UKT+/NoZ4g0+0Pce6Ba381BTVes0MLR7uHBBRPKdbSHiNBV+lqruAsspoiMwFqiHPODmQTA6qt53rdp5GbQuieWDeU68w8aiuDIhpZlMD7KrmrtUJ6eM3l/ao0JewWhJ4IPWWA8kympu8PoMeWmFXs6qrXEw0ST6w4v3cZRbWYDEYarF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:18:44.2691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f632cd7-0682-4a3b-8b5c-08debaf70566
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9569
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

From: Alex Hung <alex.hung@amd.com>

[Why & How]
Use the existing local dc variable in amdgpu_dm_set_psr_caps() instead
of redundantly dereferencing link->ctx->dc.

Simplify amdgpu_dm_psr_is_active_allowed() by replacing with early
return and inlining the intermediate stream variable.

No functional changes.

Assisted-by: Copilot:Claude-Sonnet-4.6

Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index dd26de9a57e5..85caa8534184 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -123,7 +123,7 @@ bool amdgpu_dm_set_psr_caps(struct dc_link *link, struct amdgpu_dm_connector *ac
 		return false;
 
 	/*disable allow psr/psrsu/replay on eDP1*/
-	if (dc_get_edp_link_panel_inst(link->ctx->dc, link, &panel_inst) && panel_inst == 1)
+	if (dc_get_edp_link_panel_inst(dc, link, &panel_inst) && panel_inst == 1)
 		return false;
 
 	if (link_supports_psrsu(link))
@@ -145,22 +145,17 @@ bool amdgpu_dm_set_psr_caps(struct dc_link *link, struct amdgpu_dm_connector *ac
 bool amdgpu_dm_psr_is_active_allowed(struct amdgpu_display_manager *dm)
 {
 	unsigned int i;
-	bool allow_active = false;
 
-	for (i = 0; i < dm->dc->current_state->stream_count ; i++) {
-		struct dc_link *link;
-		struct dc_stream_state *stream = dm->dc->current_state->streams[i];
+	for (i = 0; i < dm->dc->current_state->stream_count; i++) {
+		const struct dc_link *link = dm->dc->current_state->streams[i]->link;
 
-		link = stream->link;
 		if (!link)
 			continue;
-		if (link->psr_settings.psr_feature_enabled &&
-		    link->psr_settings.psr_allow_active) {
-			allow_active = true;
-			break;
-		}
+
+		if (link->psr_settings.psr_feature_enabled && link->psr_settings.psr_allow_active)
+			return true;
 	}
-	return allow_active;
+	return false;
 }
 
 /*
-- 
2.43.0

