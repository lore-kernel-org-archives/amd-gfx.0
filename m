Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C615C54E41
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 20:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 069D410FC51;
	Tue,  5 Mar 2024 20:57:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m1XX5qkS";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E399B10FC51
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 20:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPz30iY/OdgFoQM/UfuSeZ/utlQSr30rYwJ3ai9Hvl0MtxEju/AZxbhy3BpE0vSzXeuMF0xUbmunCsznvg7fRFcxOHIz+G4YIQS70BkcP9yoYsEKszsnnJ8qdz6dcnqD1o/91CUL1NvWh19QC9V0lV4Z3Rx4iLRA5shprxQyuB4Ow5ncZgHBe5KNizEow5gmtNaeB7GNZ8/u0MDWVJBT6mKD0KkkusfMFQVgU3T+bN+FQ0KHbeIe14403434nNuTHevYDso7GnV4v85vN5CAO5xgwfWWjve8FamnaAFsX441VFZIpAyfqaWEe5exiDPvLmdvkW+sfQK7DG+fOcgR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScACTw9DU1YVHAcEH18M61OS3K1DyoeSM0fwyAwkQBg=;
 b=POmxO33EECGgPwErvHmpCb4f/LOOQRAgExA29TFPrfF8hlBhVfNm5MBP9OoSve4oWf/jFfw+Lm1fFXqKQEbxoc+2JNlSBdNRRgzXaQjKmW5nmP+0gOY8xorFri5+A8UIhGQhZ8klsbUUJv/5ZC3GLeKLQgY+apl/AmREhWeczscoi1NQYHg5Kxkxzu8juDKqZVSfwg0UNm6PYJcMXK96YNdVQX3do130WkJGlCYsktNJK2U5/VJmhmpjldoKjS6rj4+N6qryrpgaxjv5bPe3Y/wlEYeCGb5eHNr0pZE/XbGtrLuCwOzm6QvsHeT5oYVFvGwwfXY+IRbEwU918dku7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScACTw9DU1YVHAcEH18M61OS3K1DyoeSM0fwyAwkQBg=;
 b=m1XX5qkSpFiKpdjOkf1IZ1DmGtgYlCrRDXrCKjqAAySYE2lJXNNBktQ31IFwcBnX4BVVrSoY57KKnLFzmdtaLMYivF9sIrZfY2OVK7d7codqzMOLMxMOWsTOSD+oOzDW8ma0wxZf0o4tGYIfgqK7aPFGP4m0a4yXMK33tphARRs=
Received: from CH2PR20CA0012.namprd20.prod.outlook.com (2603:10b6:610:58::22)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 20:57:38 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::9f) by CH2PR20CA0012.outlook.office365.com
 (2603:10b6:610:58::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 5 Mar 2024 20:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 20:57:36 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 14:57:35 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd/display: Use freesync when
 `DRM_EDID_FEATURE_CONTINUOUS_FREQ` found
Date: Tue, 5 Mar 2024 14:57:23 -0600
Message-ID: <20240305205723.43651-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: c93ca839-1b75-4396-6019-08dc3d56e326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2mYJQKDg01JWmRyJkXL/s5p2os1391ulZQQKklPT1AkTNxq/j+iP2jrQWvKBBEE4W8eCBAqI11pBsMOOgJtl5T5wI/Are7pFNGkjBUdLdqTjbi2FmFZ5RWKCU8ngYvA+ZkuMhORxmQUfFOGezzCwY1MKWK1tNEv4y7Eo+2X2BS4hT3kUeLWqLK9+MxOi9F9dUQPu6O36GO8J/Ws5K5CHhPk+IXC5KNlSorPvUbCpBoyqBq+NLX7mKsbDTQYUZe9hCs/q40wFECC23r4IerriFsE/ldwCIeXzZvDUkkQ7dpVvaszd8lS5Do+nt9Y/+OzFQaedbtKfkuPtMA5hgG4a82NtIV1UB40F1T5cCN6BK7ZQB1g8d9dw1JKj0jEuLE+67RKaNd6Z5wwG7MpezSuBXGs9hBnAoOCOVo/J34bH4RrzyvMp5tjJn5/83puKXqX+w69x03Wqgvpq2qW+9qzxdsFxftVEXnZRjKhC07N7z0XSeiSJXIvff36ZgrXwrmGYt+K0EA/eJrB+xMSX5axIggQ8Vx0DfkCEGQ6GkBX5+hbCBBjcxHh5PaN5SxHcv/GHYjjQGKyFUPplA4y3Id+JlwR+CrHjbWJ66cPBhjNX505YXtgZ5C6L19bY2n27ELSXvvzJb2x/ihgUA7/LPTGfpEYQ4kIgXp34qpnAc1i6GSL4517UsBZT6fqQSW5UXvy9dvxKBZ61XOQmCATgJynOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 20:57:36.6567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c93ca839-1b75-4396-6019-08dc3d56e326
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342
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

The monitor shipped with the Framework 16 supports VRR [1], but it's not
being advertised.

This is because the detailed timing block doesn't contain
`EDID_DETAIL_MONITOR_RANGE` which amdgpu looks for to find min and max
frequencies.  This check however is superfluous for this case because
update_display_info() calls drm_get_monitor_range() to get these ranges
already.

So if the `DRM_EDID_FEATURE_CONTINUOUS_FREQ` EDID feature is found then
turn on freesync without extra checks.

Closes: https://www.reddit.com/r/framework/comments/1b4y2i5/no_variable_refresh_rate_on_the_framework_16_on/
Closes: https://www.reddit.com/r/framework/comments/1b6vzcy/framework_16_variable_refresh_rate/
Closes: https://community.frame.work/t/resolved-no-vrr-freesync-with-amd-version/42338
Link: https://gist.github.com/superm1/e8fbacfa4d0f53150231d3a3e0a13faf [1]
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5b7293da5453..38186d669a85 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11238,9 +11238,12 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		bool edid_check_required = false;
 
 		if (edid) {
-			edid_check_required = is_dp_capable_without_timing_msa(
-						adev->dm.dc,
-						amdgpu_dm_connector);
+			if (edid->features & DRM_EDID_FEATURE_CONTINUOUS_FREQ)
+				freesync_capable = true;
+			else
+				edid_check_required = is_dp_capable_without_timing_msa(
+							adev->dm.dc,
+							amdgpu_dm_connector);
 		}
 
 		if (edid_check_required == true && (edid->version > 1 ||
-- 
2.34.1

