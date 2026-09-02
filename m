Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2B1C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD46210EFC7;
	Wed,  2 Sep 2026 05:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X6I4acCG";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013027.outbound.protection.outlook.com
 [40.107.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0943E10EFC7
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnPR9z+FtgzTiTkjon9q//KuBbjhfEQCfg2gkrFZWHOv6Xq5ApAkpKw2XeBStbZpt9Dca4kvEIwFcrfDl+HaMlStyD3jRdnlK+o03gLAtbuTL0I5iDkPZ4pzazl8PbqFxM2BqfwosdSwHBil1DHD/A8vW0KQNeX8R1iuoZmPvdoeQfhuXNhCHio1mPXu8MRgSarf+aU2AqOtrhH2cgGm66xRIOJq2X9nTow/ah+I+433H1WtfC1x5Ui0THjvhlhp6eZj9ruK3Tzx+kmhxJPTAoszOkmZ8lU45lUBRF0FcGP8OaJf3Fx6P+tAxexFFqF9UEavKnfNTkNx/N+X0l2LWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGTwfWt4ietVhFwcltFXjVDNS3LGI9roQuj5+elmtqM=;
 b=lhnpnbMMWlznLXa9RVu6YtycdljXcW7CAkDpyE95CCd+6ORSAAbeZsYu78jiy7JRChxs7xgPRRmFKwmXyanaOefROJIHUw4ZYke9y41o6QkulzNz6dwoHM61r5lSZOkm0h+BgFfm4b/PyQgdeFDsPRlv9sBGzB8B/VS14zExujA6YYIAluZfLgLk86i0FWIS5kjZqjt59xe7J4tovLLUOFjpoOiR+guAWTsjf4PzHwhgc5PxVl/pFZX1Z4ZsmowapxC2vjUYDGLeEmP19Zb6eBlRU3nGRBepf3kx57igB9wj/HOWoP8Pb12LEvmQ0ux6uWOd7hg2VOW7urynOeO0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGTwfWt4ietVhFwcltFXjVDNS3LGI9roQuj5+elmtqM=;
 b=X6I4acCGuqn6zE6xEo9Pt12evtCsoQ2h3qIMpJeHmUxFsM3K2scey8lftrWul1UJL59ygGstgiYL6KWgFxzDyv9Qh5jZEtSd66vrcXTz4nar6Wz/8pFsdvEkCp7pQYaulcSUyCuyjAE7cCqKhFXQPL9ekvvkXLVqBvSC9Hv8BEk=
Received: from DS1P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:453::8) by
 SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Wed, 2 Sep 2026 05:07:24 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:8:453:cafe::9b) by DS1P223CA0003.outlook.office365.com
 (2603:10b6:8:453::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 05:07:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:07:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:07:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:07:22 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:07:14 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 20/40] drm/amd/display: Exit IPS before connector detection on
 resume
Date: Wed, 2 Sep 2026 12:58:42 +0800
Message-ID: <20260902050411.3473916-21-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|SA1PR12MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5477e3-eb74-4d29-23be-08df08b01313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: t5m9ORg95igjL2IFirLEuuyJI8+Vn4Tv/3AHkovOyTWxHAv39va7mxam31ZsImQ0tl16EUofy3ecwB6I+hW5bu/F0Io+ayI7kXvBmhYdBTcPQ+9nAbagNTA1mOfK+zdQ4S7cVIDIPOU6ZoVE9F7H25TZ++oHjpiLfYT49Ip4XIu8yDUXLQaj51wfDEgN1XU05vIt/z02NQ7oZ3U/7cSGGUr+zrq9u/E9fzEQWvdLcI9mBE7dxFBidnDj+zHxRXCWUyUrkGtbw3Bmvp9WJx3YZ+kQa5EwNJqprlDjrvFsDd+Cdvi+BookeA54CTIYUmDU75G5+hobfMDPans1JFB0ifLQFqvaSQjMWH4eSFPQXopPYii4UxW4EvtbklnBeCq9Eu2DVtKUHWgracMfgakWcinYhfhvoOXhV0e/JVlCY+cpf+omuFjBvWkmLf/hgnk9hqTHUS9/PmQxknLYy2A0Bnz46DrbBhHebEg99Nyl44dreNidvQ2nDqiCqQCJqOPjYLnNCIGyZOEiLw89JQ8Z31FbFp2krbde+y8Nvt4Ji5j/PVX88aeF+oC5BkUj49yL/LwioBL0TY+8TkF/3TdI77JWZkDJpDHLNSL0c4mL23QqwKjT6SW5ijCnUTBS21Wab/VtUKtCeFoUm3r5OemkVR+fO4f0qYBciDDuNv8Q3sjLj9Bvti2hA3S7EvmFX1TSL6JI6bS0V0lVcDyw9h7IeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Gb9JRAscP7/6t/GbcKI12Gp2YKyXF530kagihP/lZD4D0R458x+RdF+VSePYIyZAWWmiQFWOhC+r/Xhv45F/9IfPf9RnklxW7u/rwR8tqFJ05MW/JzxjQAnSZW4Yjvqw0JZgkfbLokNau1axlYRGSDfVRXXJa9lHh3MfID8Vr7mu7kuP4vfPK6YZWQwVP5L0RY92lGm4P4cmnSW2VI1+e7T9OslhE5nYXrDzg/aRWnr+6nTrrGlMdlro5N8UOThx1cVHTXOQ0toE7pMZm8JEVZnmQJSURxP4bjQH4bQyK/cYwnKHj3loGafKYdv8/4eyje/8egGA+SrsszlV1OxyawBKQbyVprWd5vFov+gzZ2ZunLfT0qsQKYs/S6G8PAwPsxkvEsbYE2Eotw+whQJVTfxWR+2li6hbIrk/900mbFsDrWWV6++f+zZh0JqGXPfQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:07:23.6448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5477e3-eb74-4d29-23be-08df08b01313
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173
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

From: Fangzhi Zuo <jerry.zuo@amd.com>

[Why & How]
On resume, dm_resume() walks the connector list and, for each connector,
calls dc_link_detect_connection_type() at the top of the loop iteration
before the per-connector dc_exit_ips_for_hw_access() that sits in the
detection branch. There is no dc_exit_ips_for_hw_access() before the loop,
so the very first HW access relies on an earlier connector having already
taken the display out of IPS.

Commit d1d51519bc3b ("drm/amd/display: Skip eDP detection when no sink")
skips the eDP connector when no panel is present. On a DCN3.5 APU whose
eDP link has no sink, the eDP iteration - which used to bring the HW out
of IPS first - is now skipped, so a downstream DP connector becomes the
first one processed. Its initial DDC/AUX access then runs while the HW is
still idle, the AUX transfers time out (-ETIMEDOUT), and the EDID read
fails:

  [drm:dm_helpers_read_local_edid [amdgpu]] *ERROR* EDID err: 2, on connector: DP-1
  amdgpu: [drm] *ERROR* No EDID read.

Take the display out of IPS once before the detection loop so the first
connector processed no longer touches the AUX/DDC engine while the HW is
still in idle power state. This keeps the eDP-skip boot/resume
optimization while fixing the DP EDID read failure.

Fixes: d1d51519bc3b ("drm/amd/display: Skip eDP detection when no sink")
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8879196b2675..da379c48a5aa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2023,6 +2023,10 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	/* On resume we need to rewrite the MSTM control bits to enable MST*/
 	s3_handle_mst(ddev, false);
 
+	/* Exit IPS before the detection loop's first AUX/DDC access. */
+	scoped_guard(mutex, &dm->dc_lock)
+		dc_exit_ips_for_hw_access(dm->dc);
+
 	/* Do detection*/
 	drm_connector_list_iter_begin(ddev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
-- 
2.43.0

