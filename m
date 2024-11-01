Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5411E6B27D
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E76010E9CA;
	Fri,  1 Nov 2024 13:50:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nIsSLnO0";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04BF610E9CA
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 13:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRR/2Sfe+AqUTytT2Gu0/p4qsOOxUj4Ie7nqZZbe60fXVxzBBt1XFaKAMhYrk+nC+Mt2GfDtWgbqWlKfeE2DshV7UqES6LqhBsnfyfDW26r9tIf+BuXW4RXyk9kjh+zEbDee1xauvvC6wNqF1r3E6Q6JZAmwavgUHGtT/z8NXxB/bQSqpePbGcJANNpCS1JSlhjr6zKBcK97IQ2rMGZ3E08tJ5vbkcaIt2xH3pa6AVZW6Hi1HELqBYCV7zoxHDhYrg5q80NUnSCE43ZA2ah9W6WgOE0VWuNnGZd7Kn/YvE+wfEWM04xieshHY5ITtN/yGDE+zYRJL2VJfr8/q+jjHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XgUICwQBZfVFSvhK6GQkIRAitVseb106CtWtDhWeMY=;
 b=F5J6qri/6QXGn30/Bhlqa6BfI0tfuADOhcnhbVZ7wakwr0k9m/zz8y3ZJjrCYfekUF/l8bkodBRUlSAUjz9iB8tskEjmI+BeNCd7vK9pgMcfofsjdxpIRVaDFZlcUuzBvSAURij+2tDP2Ey744LqCEHLLq8AqvlvvB2CXhQMWmrSqmQ1yR5FhxOrvKw+jARu6k1IUoWVu+u89fH9f8B0VpD40Ttxo5ZLExkrK9s+KfLQ9yVzDCmMhW/N4hkGVL7oAmK7dJ3uGcrBv5rcxBXlx2yWUgIqhheL+g8lmqNWgtirvsK0MBTcWdu2/deXXcPGm7tdALyoNxSCP9wZ6OJ1kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XgUICwQBZfVFSvhK6GQkIRAitVseb106CtWtDhWeMY=;
 b=nIsSLnO0HFCITSMvmZYqjeIwDSgVwK3+oDwclAsVOYpDFCSHdvh4ojnEa+PgyC7YWp5yP4H9QyeSinvQz4oEY/ovPiDChzrTHHGVcef2uxuOlllsNvMPg8JVMdFVORZpdIojZe3CjTqNt8w6wxguYKh3G3u4fbqQE8J/BBqOukU=
Received: from BN0PR02CA0027.namprd02.prod.outlook.com (2603:10b6:408:e4::32)
 by DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Fri, 1 Nov
 2024 13:50:12 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::b7) by BN0PR02CA0027.outlook.office365.com
 (2603:10b6:408:e4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.25 via Frontend
 Transport; Fri, 1 Nov 2024 13:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 13:50:12 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 08:50:11 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 07/17] drm/amd/display: Fix brightness level not retained over
 reboot
Date: Fri, 1 Nov 2024 09:49:30 -0400
Message-ID: <20241101134940.1426653-8-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 5293b805-2a65-44eb-27ca-08dcfa7c1ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2aA7M+vwTVFb1PjWq/c6T6QNIsZq0oKVjPgTTa3Tj0QxzvXjBJzpBYpRUrf5?=
 =?us-ascii?Q?RpWdQQPRaGSxwjvG+4TeycSADsYWo//xhHnX+6BY8McrOVt5RiN+sGe7Qyka?=
 =?us-ascii?Q?2p9YTOIlfswDV0h2yFGcbwF8IV0QRKPDMWEudl98IpNTwsobqQ6+kvlEcfJb?=
 =?us-ascii?Q?z5IFWyYVtTiGo8eIqLiROYMOPVAWRSGAZwaHQEtvsLc/YGyaL60Ej1VDzXdR?=
 =?us-ascii?Q?FzNwH3HsE83mU3kyAK8O69pJhkjTEa9h1Fa7qE5wnWXPFeLv9+NW4Egl7dOR?=
 =?us-ascii?Q?/fPbMcECOQmqTZ54LUyhW/QhPIC0DJ0O6NG7TShNpmDlP9NGVLES1laPQuSr?=
 =?us-ascii?Q?xEhH/HAo7oThf6vU/mxvKFa4YpiHnnawCWeXd552YVMVw3F6gDkq0zcji0Ot?=
 =?us-ascii?Q?0vBgNqVxH9SLygZR8wPERmhiD0B1OWu39d6uy8XWErosBr9LOcBNfo3Ii5uR?=
 =?us-ascii?Q?o8+QMrbr3b+Nz5mjaQHkG+zRQqn1YS3oczqLWlhJYNV6TIiejUuWKhXtmGZu?=
 =?us-ascii?Q?5ZO2yAROBqCG+5hxlpG7Rj3bXIHcTBq+bBAsrV9Cw/fKveE09aUdwaiqozm/?=
 =?us-ascii?Q?K+M5q1fVQaz123tpJ0mOENwpVu0NknFBluFVSDXOMIu+Ru+OSpWCym5gR+8F?=
 =?us-ascii?Q?Vxohtcg72CYUJ7Zy+/CYdf8KQxgzlbAgvv61mrr/0mV1+JBEFRhswUJUgByH?=
 =?us-ascii?Q?gP/pwI0eIsf3onSYdv2IEtKtjsmLkhbCPXSNaLtjAItP/6sVIZBqv49vF0Ar?=
 =?us-ascii?Q?D4deG1FjlDUmxHmRFZNGHh9vVdr5z3rg8YqfmucOemDUWkSIf9e0G5GWpDYp?=
 =?us-ascii?Q?0+2jKx16g84C0rpbckhrAPJNU4HXdZCx2EMM1I3yVtGy0ULAmrp3YqsMndtL?=
 =?us-ascii?Q?ze+rdAs3kuzcDH9ngluX7Cgcm6PRqre/wN9iPwyTw3RA5kXMWp1sdJxNKV7R?=
 =?us-ascii?Q?2nBaS7oYrYpVzbJfV6rNrYLejTWqehR8oaEZ73kKxFFDtf3kUxlsRbqIGrho?=
 =?us-ascii?Q?lndPqEecsXkXL4vzU9FiyTQAExpI0o0vGBtAc9+w9IxbZqbxCyYoUHnS2K8n?=
 =?us-ascii?Q?RE+k2Po1lbiuXgPXQ6ksKosBCKrlM77Ik4medzAWRb6AdW9vaKHuY4P4YLoy?=
 =?us-ascii?Q?d5MkFIfRbHdWzd2DQpkGUyNFheCJCUEzfJVymsMZ6pz/CWt6dsztFZY2A2L9?=
 =?us-ascii?Q?vVlkA2bpLyheFBE8jOfGmVJ3D6HIJirnN7qp0E93tINZtZjLU6CNTpbTagKo?=
 =?us-ascii?Q?eai1MI0Q54gEG1iiJps+8XEQoQY8oI8KFhWnxiPJoWAjXBIlA7QIukvA0QJA?=
 =?us-ascii?Q?E07S3ikkrFbcF65BTllAoNVP+IEwnY2hfVf95PbLgUHwj4RQgWYcgystDJP2?=
 =?us-ascii?Q?G94CvApEOc7EbLOklya7zu/rTpAK7qpne2z5U8itYkAoB6I/tw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:50:12.5706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5293b805-2a65-44eb-27ca-08dcfa7c1ba3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
During boot up and resume the DC layer will reset the panel
brightness to fix a flicker issue.

It will cause the dm->actual_brightness is not the current panel
brightness level. (the dm->brightness is the correct panel level)

[How]
Set the backlight level after do the set mode.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bbfc47f6595f..2599a99509de 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9411,6 +9411,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 	bool mode_set_reset_required = false;
 	u32 i;
 	struct dc_commit_streams_params params = {dc_state->streams, dc_state->stream_count};
+	bool set_backlight_level = false;
 
 	/* Disable writeback */
 	for_each_old_connector_in_state(state, connector, old_con_state, i) {
@@ -9530,6 +9531,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 			acrtc->hw_mode = new_crtc_state->mode;
 			crtc->hwmode = new_crtc_state->mode;
 			mode_set_reset_required = true;
+			set_backlight_level = true;
 		} else if (modereset_required(new_crtc_state)) {
 			drm_dbg_atomic(dev,
 				       "Atomic commit: RESET. crtc id %d:[%p]\n",
@@ -9581,6 +9583,19 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 				acrtc->otg_inst = status->primary_otg_inst;
 		}
 	}
+
+	/* During boot up and resume the DC layer will reset the panel brightness
+	 * to fix a flicker issue.
+	 * It will cause the dm->actual_brightness is not the current panel brightness
+	 * level. (the dm->brightness is the correct panel level)
+	 * So we set the backlight level with dm->brightness value after set mode
+	 */
+	if (set_backlight_level) {
+		for (i = 0; i < dm->num_of_edps; i++) {
+			if (dm->backlight_dev[i])
+				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
+		}
+	}
 }
 
 static void dm_set_writeback(struct amdgpu_display_manager *dm,
-- 
2.34.1

