Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155C1E6FE49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 21:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A811A10E1C8;
	Fri,  6 Sep 2024 21:20:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QuJSZ2gV";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 182F210E1C8
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 21:20:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcEoW0yRX1KpEx2/hxoFK26405HD4uN4HSX03TXCsykgtBb+XWtwwtoFcRSxQYdY6yfpI5fkwqtYUedogw7WqPelgB8jadAb48AwF4ptjp2WZe3WayFod3e0LFvXcLW/kqeKR50qxfhKt244mYzxt2cnCQTWtZDY9fNGMb7HwRPuXKGbVudgWHjok1sh7DY6iv5PatPDeT9yRymRlo5K2NvFWYHhH16lEK0FtpIygln4JZ5raHLCf0Ole2aVJ9+d8O7eQqBpQeZw47oOVuioKsqyjOqaWCdj7UAdxquaOrPsxOxWzcWCP1UHvF+5Rs03Llcl7MA3A3p7sEqagP61uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFfzGlZJA6uSFQCkMsyZzCQDf04Fh+LYg9sPiLPjdvk=;
 b=FSXMSItc45dLiyNMCLkBwC4oCN//sWSPHkVt3FSmdlFgz3ltycKPC8LkpGLevqQB1LrN01WcssCweHqblKuKapUVWfHE+j9Y6PJPImSIzuQe0sFkPPy8ZxPNIF9MqCEM09Anm9By4QuNrOowwZgJDA8EEm1Tgj3vZCDr8BVCV05NCQHBcSdortWPKZG4XxpelK5CyRjXTghLcdm5KNAbmQRyR/dMm+teHA4pXR2aTydAbuyKX4mArhFI4VaIcs6nm8zLBkRRUqoVwS4oL3SH0J/ZM5vZQ5ck/C0lIMoDDk8u+XcM5aqKTisSDWZoMGoIUV5b2K0C81qqzhmOjsCoQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFfzGlZJA6uSFQCkMsyZzCQDf04Fh+LYg9sPiLPjdvk=;
 b=QuJSZ2gVb8Fr/gXQ8oPbRHTEpHV8x4ibknvx13Vq+weWACjcB85yJUY1vbEh/Ewm4lsc3Us5rFv2vFQVY2tHW9MiOs3LP3oXSxAqGLHitxvkLxq0HXtHhNAIZynQfjxjwHOeITD7TuIgThBE69y0kzQzNclKXY4K+x5Ay2j26UA=
Received: from BYAPR06CA0068.namprd06.prod.outlook.com (2603:10b6:a03:14b::45)
 by SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 21:20:42 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::f2) by BYAPR06CA0068.outlook.office365.com
 (2603:10b6:a03:14b::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Fri, 6 Sep 2024 21:20:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 21:20:41 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 16:20:40 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <hamza.mahfooz@amd.com>,
 <rodrigo.siqueira@amd.com>, <mario.limonciello@amd.com>,
 <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH] drm/amd/display: Do not reset planes based on crtc
 zpos_changed
Date: Fri, 6 Sep 2024 17:20:21 -0400
Message-ID: <20240906212021.74460-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff2b91b-2a01-433d-d5e0-08dcceb9c30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f1aF8ujHS8cBhnYBc8xSdzE4g+cMmMARvL+TFh2IGDdFkNDBJgkq/UEXJOnn?=
 =?us-ascii?Q?xmynX5gs7/2w3Qwc4ArK/JVsGDyo+XWUiE6XHnB6tCRO5v+bUzyuvd7AF8d6?=
 =?us-ascii?Q?vrpZxWN3yWeZ549KO2Zm/TunxyH05DOuBitIWFLoZ7nbpnHVn5Bujk5BhxXC?=
 =?us-ascii?Q?96y/+kIcpPSo5nboGWR1DZYQJe4gZq+uqEQDPk7ir0+ut+7XQO865taNHDjB?=
 =?us-ascii?Q?gDLv3x5rMULetPcnLbunwXqJp3j5/8Ep6JaRfq5e4KijZ08/+0xcbFGTIiYn?=
 =?us-ascii?Q?oKCqqG2+ucnFBTRru3X5bI4KSzE/DZ4PodMZxBJ2KZk4KCrMDaYXROL5EfCS?=
 =?us-ascii?Q?41yVDMYHgot+qtAK5r8jxz3WWqCPEAs5aigLcwW0JjhbiX6PQzh2Gv1orAEF?=
 =?us-ascii?Q?f1tZGCpMrOxBspfg+TkBbI3wM0mIqWvwaHeLf1bvfU2npXbqsnsvrZ1j+RFl?=
 =?us-ascii?Q?0cV4gorOklVpIx3Bf4dAXXrWsWFNR9SoRcPgLHLzcKf3IVrwrjp+9hDxJ7vG?=
 =?us-ascii?Q?cTDQz5vkKBmG44eOzsiD4/8mfrQNK9vpWHd/j+TmpjT45Lx5FneGRf65zDzQ?=
 =?us-ascii?Q?ZAqZE3JXtpn4asljtRgPYI6d7LcY+4V08mRIyZtFSVtTwPAbHKJHaq7yI7du?=
 =?us-ascii?Q?n1o7Jg2OLRYlRRCgnyXDLmCZUUL8jp/ShBpu9kUvj14Z8Bl1PfqB1ddSXUFZ?=
 =?us-ascii?Q?LecZAekVShCDEAePIZA9SgzH93ELjt/elXvXfkN9WwEkGiU50nys/uHUKPXg?=
 =?us-ascii?Q?NACd2HzBZph+LCLpipRyJ17SrIQUIaZMqmzVfBggscbRT5O1VCrPdTsebeEV?=
 =?us-ascii?Q?oJrVQckBUTd5ZKIoQiXVsB7PbVFkcjLEaIJeFRLh2NAH+DMrozvqAiO/F+c+?=
 =?us-ascii?Q?/QzCNBRqevw5Yoau8zSwm6hIL9Kxawuukz+k2RY7vxS+NzxkRuG1DRpiJHgU?=
 =?us-ascii?Q?d7sVnOwB+PTq7z4UjSbkZyyYlUetg2UXyqItoOAVS9mV5iTyI1kvK+uFLo8m?=
 =?us-ascii?Q?HTlRx4vnCnsjAl/u2PGtu031C/PZI8YCCGH+tLg651khg42agMV8WeZ+nfHJ?=
 =?us-ascii?Q?j4PHjORN64ePbiWRBPyB6rQpKcAYl3gLicaFGGLkw4cr0cpxPCuZzt3gDzx5?=
 =?us-ascii?Q?tbK8rvTWeH81IE1BrhoHUh8Xe9JM4d5elZQj1DUdKLIbvnJhkbPLGQqTewgM?=
 =?us-ascii?Q?xgoHO8kPVpgWXXVEZQ2eFxbWDBTVa5JXIjueav3BxP1SkGYgdjDA0hQ5OFzt?=
 =?us-ascii?Q?lhlITUuVUFZkh4rqATCzH7t6AOmL3kUrY40Sr/OU7kN03oaMHzVZOIX6Cw8Q?=
 =?us-ascii?Q?3zi/knyQXO+OME2FAE9R/Zd5+lLytqYhcnarjyUDPAaJ9apDafiegVJlSoi3?=
 =?us-ascii?Q?YKWzZ46NVMqNASUa2WUmdD8QsPn5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 21:20:41.5031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff2b91b-2a01-433d-d5e0-08dcceb9c30c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

drm_normalize_zpos will set the crtc_state->zpos_changed to 1 if any of
it's assigned planes changes zpos, or is removed/added from it.

To have amdgpu_dm request a plane reset on this is too broad. For
example, if only the cursor plane was moved from one crtc to another,
the crtc's zpos_changed will be set to true. But that does not mean that
the underlying primary plane requires a reset.

[How]

Narrow it down so that only the plane that has a change in zpos will
require a reset.

As a future TODO, we can further optimize this by only requiring a reset
on z-order change. Z-order is different from z-pos, since a zpos change
doesn't necessarily mean the z-ordering changed, and DC should only
require a reset if the z-ordering changed.

For example, the following zpos update does not change z-ordering:

    Plane A: zpos 2 -> 3
    Plane B: zpos 1 -> 2
    => Plane A is still on top of plane B: no reset needed

Whereas this one does change z-ordering:

    Plane A: zpos 2 -> 1
    Plane B: zpos 1 -> 2
    => Plane A changed from on top, to below plane B: reset needed

Fixes: 38e0c3df6dbd ("drm/amd/display: Move PRIMARY plane zpos higher")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3569
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 43bf8883ddc0f..a3edaf658ae00 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10579,7 +10579,7 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	 * TODO: We can likely skip bandwidth validation if the only thing that
 	 * changed about the plane was it'z z-ordering.
 	 */
-	if (new_crtc_state->zpos_changed)
+	if (old_plane_state->normalized_zpos != new_plane_state->normalized_zpos)
 		return true;
 
 	if (drm_atomic_crtc_needs_modeset(new_crtc_state))
-- 
2.46.0

