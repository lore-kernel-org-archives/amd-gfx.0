Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF89C61DC2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 15:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B15710EA7F;
	Tue, 25 Aug 2026 15:36:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UAH367IP";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012004.outbound.protection.outlook.com
 [40.107.200.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A24A510EA7F
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 15:36:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7XZr+Re/RW0xHeZah5HPBZeF87rmbz5tAYQAMbG4S6kDvaaPbbYmj3PGmDRKB4NZIzrP4yqTTal2mRcjNuL8/9ka7RrMLwwQpBk+1WmrY9jSS9vrk8qk6K6jQpeoHOVKnjvmewdIK9P3iO5NvOLdMyNgPbb0p9ZDuDnF2xqh3WVSWfnANmd34CFZ4xyE+GZQsKD7mylIF6GmqgP8HC426luzcZMXlDtF6f6MtrzGPfaytOJFoosW8Tu8fiuJcGxaCsUHFEHuAkdJra6vh0Si7zJr9XMz6nxBPsXwuF3t8ZIL8UPb/J2rq/tLj/mdNPxS8FS860VOENqmWnVRdDktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xE8chTthEjORl+isKkQcd7MvrKAljBnDekswjJAweKY=;
 b=JPSA7aregMwACNmj8DF6t5swJCF/HwgiJHtUD9fbL6iFOV4+ihwrjYdiatCkgYGyL004uvTjLG3P6cO8IMFbVyzw9m0quxhKgkFh3Mk+LTM5Yr8o1ysAn5Afw6F8aCnOzOEl64fSD1DRNKRCpF+p3OS2SqRi319f8cYq8cwQMPBPKjln2Jp+hjT3uvIrXkrVLoTP9a2xUPlLM0qiJEN257BWXzgyl2wOk5ODGbljquUHpNnRefPL84qoyIZ1a5rlFLmjb43KKArpGsdngUcCoj5XjBnYNcdbNajOmnfjJMCW5zN+HGxG+pfIr7N1UQqUVQ5QXBDxTuWNFEzlbGnXBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xE8chTthEjORl+isKkQcd7MvrKAljBnDekswjJAweKY=;
 b=UAH367IP8fzTfZIyWgdQrvwISwVrwz9TLa4z2whye33Kk/ytFdzlldP4xCb7BlBWqCh9KdFb0N/h+npPKdyMQN3dRYHhRDEq71FARfcgPJzHiFC76oUQclm7ZVoZHPkSA4Qgx0LXc++LmegjCzuhk0nb7iNFhxsOvRqdLDTaVhk=
Received: from MN0P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::29)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 25 Aug
 2026 15:35:50 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::95) by MN0P220CA0001.outlook.office365.com
 (2603:10b6:208:52e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 15:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb08.amd.com (149.199.90.133) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 15:35:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 10:35:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 10:35:42 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 10:35:41 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: pull colorops into state when recreating a
 plane
Date: Tue, 25 Aug 2026 11:35:39 -0400
Message-ID: <20260825153539.213495-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: a454c57d-8c8d-4ad3-fa52-08df02be876e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|56012099006|10067099003|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: W41C9UMt+bj4OVAK3h6aqfuo+jh0PnGTwB19ioNKgaNL+yUelnKHNNMl1tfUk9vebDEgiVmi3CedHjybc05b84veUZDc5Al54rRHNw0oi6T3i7oMctdfTTZkm/o47cmvFbsMj8dj0EQ17QkMVlAv9L7OcLyU0H+32weBKh6Gst1oWuOehYseeV915vij0U2+Vi9Tgd5gYgEXjudoxc3Pa0iZK7DN945+1DBadMTshf50aTVqc6t5TERsLpRje0hTsWzArvn1emoX4NhzZLxCBBetzcbidiJosDJSfNufp1jYlRxqEh39m3FA5c5VU1uJHtx7c5P3HWFHC27a3th42wpCxpXDSCVIy58IA4P0/Wx/bpNr1/nZ35/N1yc7qibu71904qjinnQmAFmL9RqcP6glZD3uro29cYuEybxsu2Ko034MQPcK0xn58C+pG8tvezOAwG4E+Ej8Jya3SqE9B80D8+6xgZCjKqGYecZJDx0FliTnDMObrftfyd0JVMn2SHW7FyP+jHXIOfF7rP2o2q2kqNVFPnG/j+DBorCR8/Wg4lxI3b163AwjT9DgMouutu7vPfPglpmQpCJOgkNWIbJvFkG9s7CksdUXjaJnU6OwVS0p6/s1p+8SXufmEmhD8v5WIrUsFXTOuE5ea8CWKhefGeOFK+PJ5gmzXatIt2rnGJYIcBNSVLW81gfOoDkUzLcUj51v3OWq5/DgDWZgPA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9SsXxr/9ARy4YUIqtRD/HeBQasrIIDgEUKFaZCSAhlmPJWnaA5Ks1/AYCmn+T9IyfGmYSwSG/fSWPJFZIdZHfzUQp0H5KqllnBaBuHDur2EVpgq5qvM53+SJVoBq14smMrobRmkjqWu73zxLyeRawJSxOrjkFDXPZwCaPe5vOOtUkMBMSgYk0MEW6OX0F/A8QkApA0ZEOZrr3+YtaJdaFS3TBUmDXEflGpo1IeDHpveBxHmtEWS+h7SQhovhvYdgM7ZQCvoFtBkSdByrkIzG09yVZw3QxZYur0d5p1bM8uYzLmpb41Pgdun4XtlB1VW+mdZ4Sl6qCL4i3G5KUD6mXF7OJd/5CE5WabWxQ+k8JsFrsXRV9oUQooGFsqlnUdyOvX2hCNzZvwDvetKWNXPG+s/17/aA5nAoHpMFXV/fY2/OwF0vT23oH8BILogPSYg5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 15:35:44.7930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a454c57d-8c8d-4ad3-fa52-08df02be876e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990
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

[Why]
When should_reset_plane() forces a plane's dc_plane_state to be
recreated (e.g. on every ALLOW_MODESET commit on DCN < 3.2),
fill_dc_plane_attributes() re-derives the plane's color pipeline from
the DRM colorop states. The per-stage helpers look up each colorop
with for_each_new_colorop_in_state(), which only iterates colorops
attached to the current commit. If userspace didn't touch color in
that commit the colorops are absent, so the fixed matrix (YUV->RGB),
shaper, 3D LUT and regamma all silently fall back to bypass. This
corrupts the plane's colors - e.g. an HDR P010 video losing its
color-space conversion - until the pipeline happens to be re-committed.

[How]
When recreating a plane that has an active color_pipeline, call
drm_atomic_add_affected_colorops() so the plane's colorops are pulled
into the commit and the derivation sees the current pipeline instead
of defaulting every stage to bypass. This mirrors what the core
already does on a modeset via drm_atomic_add_affected_planes().

Assisted-by: Copilot:claude-opus-4.8
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 49f1a22f2888..4ee677f5b8b7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6337,6 +6337,19 @@ static int dm_update_plane_state(struct dc *dc,
 		if (ret)
 			goto out;
 
+		/*
+		 * Recreating the plane re-derives its DC color pipeline from the
+		 * colorop states in this commit. Pull the plane's colorops in so
+		 * the derivation sees the current pipeline; otherwise every stage
+		 * silently defaults to bypass (dropping YUV->RGB, shaper, 3D LUT
+		 * and regamma) when userspace didn't touch color in this commit.
+		 */
+		if (new_plane_state->color_pipeline) {
+			ret = drm_atomic_add_affected_colorops(state, plane);
+			if (ret)
+				goto out;
+		}
+
 		WARN_ON(dm_new_plane_state->dc_state);
 
 		dc_new_plane_state = dc_create_plane_state(dc);
-- 
2.55.0

