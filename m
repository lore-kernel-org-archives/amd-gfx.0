Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36BBE77199
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B6F910EB16;
	Tue,  7 Jan 2025 15:31:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YbozHHpE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 599A510EB16
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:31:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnOWwJ8LCSEfkKkCovHR7gnlqz57qkoNo/KjZbUdpk05ku0C9BjHWVf64jLxa8qt8HkAUpFMtl6we7h0f7VoBGkURl8TE02J46REeVkajFKIuV9H7/nZ9M+V6SdRcDtxWzodFoDvgIS+JWXsXPFUaXcINxm5DDrw7p3bjAW8HlR4B/HAAuhzyPFWIR7pg8O72ZspSjqQ3jslJMf8YbBkXwkDnJS9hrpyvlHfP9PAq/TNoEf0jB94mXXi4y5nzKtmzeEBZseaYvkb08ksOVChznJb/otp+LAOCwJqyyGRyz0EMbLOLmTJXAWyCqyCaQlFTa0MeEi4rUmS8G15CCTBRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3ytHd8KI+OOotEZwkS7S8bPDZS95ZnA/K0T7Gq7pwk=;
 b=Z96MCIWRpqxFsiiol8aDa3VgDLasW+xIW25RjX94hJBjrkDQvldGR5wke1oQX2zjbg4Tmsc7d0BpggkU0jTfbY/sI9T7RhWKUOh2ZixCaIRtW5jre/t04DywfR4YKjLPpitw1MHkMxBO49ixoVOn9Qz5hL58rlXfOb1DazMilWNMZri4+XzYh1wVemXS571lGcgzHPTq0P1iVvNR8B3VlYBAT+qaPENcK0f8EewtZww1QBJ4GWk1Tv7Hlh9wTWvJfPV+YOkjHlXgZOhPoRIuxFRW8JqhHf8jCQ13gkYGUMQQgNpcSnTsXMeVW9Z+NJ4NEtw+5vGVlJ6ByhWOTBxYrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3ytHd8KI+OOotEZwkS7S8bPDZS95ZnA/K0T7Gq7pwk=;
 b=YbozHHpEL3sZPKQB2UpKKOt8JKtnR9ox0KaVF2a+uurLgJw/prOcQLfUtkEGHdMi4l6YvvmYTNllfU7otH1t2+DXPk7lHjhm4ZclQAsjZ/3SvydE+SEih8+ly4uiCHyca74Pa+D/5CTtbVr55V0D/kahsLc3xaXGC2ALWLdgmqI=
Received: from MN0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::18)
 by SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 15:31:29 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::c8) by MN0P220CA0024.outlook.office365.com
 (2603:10b6:208:52e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 15:30:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:30:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:25 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:30:24 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:30:22 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 16/24] drm/amd/display: Do not elevate mem_type change to full
 update
Date: Tue, 7 Jan 2025 23:28:47 +0800
Message-ID: <20250107152855.2953302-17-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|SN7PR12MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db95a92-24e0-43d6-fb2e-08dd2f30358c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VdLqHCXVeY8lPlAGgMhzyfVuUkudWmytho2vu4DM8R2kLxsG/OsmfS6nxn5T?=
 =?us-ascii?Q?dcRwz2J7lNeRKakqIVDnnTyoD79JG7btvY8DqysA3aoDH3yN0JP7+QNl0UOU?=
 =?us-ascii?Q?oSc09TFxzNFDYEyinqiiHRFqqwxeR2mQENta3oud9VnpdLCoxtSV5pVZzMYk?=
 =?us-ascii?Q?hWcFlm3Pauksto287GUZFo9QenFQwV5JVxf4XND0K5tHu2MsLZwk6HMRXEMx?=
 =?us-ascii?Q?QG7HTkA6Bfr0T6DR7Bxm9XRdixy3t362abUgxwNZg1oLkQbSWdIIwB3cdJkO?=
 =?us-ascii?Q?z1O/jYD5IDNo2IkocrfUljPVzjzL8kwrLUJZUh+wpY5Eg9hc3aWTyL44Ie6R?=
 =?us-ascii?Q?EOtiZp6CkSMI/X/ob6Vz3D6/dgUiz9b5mkcXiBweUHjkSIgFWgRMg4AJrBDj?=
 =?us-ascii?Q?AmWGEQPjb6ypP8ybC6HrRoah7Kx94j9qD5KQaGmMjr9K+ChBDM6py/MWRPu0?=
 =?us-ascii?Q?C+7Pm8u3X6f9B4NHbHjIsX0VsBTE0mv9j2JUPH0ZfQ6joZjw77YMGj3p2g2r?=
 =?us-ascii?Q?7RmP/z2i7uMS7y5EWwD8CU5ujEUljooHDR90wFqKv9kVoAVA2AiwLMiRHpqq?=
 =?us-ascii?Q?STuzB8q9nC0T2UU21ZTiFo3/joLBA9e/+Sh95dPjrosfVQDgwSUI4gZkoeD8?=
 =?us-ascii?Q?15+AvjS+m/KYlqExLBjUBTDf/I/rrc1W9PRNgxLhmTlgC0v6Jip7CLUXUY17?=
 =?us-ascii?Q?ejIYzFmjjr2IzKjYZqqBagg6tnvxQy1w367Sdh1PXDOaDSOT8EaBIDUXjl0f?=
 =?us-ascii?Q?hnb7DpUj7az/B2BGcjklc46RZs/7djbb14XzOxTV9hN6BvNYVIT6gfJ70WD9?=
 =?us-ascii?Q?zg0dj4eDYMjqGldghlobzPVtCHkqC1w+lCDqE4n01J1JeT3riLQAmGomOoIy?=
 =?us-ascii?Q?8zNTlBg2CHxRw5woEVlUCb8SsNUTFnMJp/zu0/PiqdwVOU19REf2X/H2MX8k?=
 =?us-ascii?Q?Y7fm4uDqJiufGp3CSAxzfvh9u6Y1QFoG+hAQKb7NMDX+HqiJtlC3aj8E+vbk?=
 =?us-ascii?Q?n0k9c5Er6zFf8BBEVaq9f+lRSrgUCbT/qQVz8EHfL2cwcY+Y51Sh2hEJ2gbn?=
 =?us-ascii?Q?66wbTztHKdKOsOx2zl4d4lxuWvWbeCGVIz2BbxigNaEmOzLPaPIa5cv/OT/D?=
 =?us-ascii?Q?4xwCY5ZWMCtLJc5kFJ++kiqJBMymKxGEd3qvdUQiZBgDCt+HNpq/4nlU9Tr8?=
 =?us-ascii?Q?tpAoqWLRKX9xJetctm5lM/odNfXoBqodQ3RG2W3J0oeIQNeBLNh0BubUf3en?=
 =?us-ascii?Q?Zsc6IDaoojKlZvdIaOUtPuPaDwLj49oJ6YuA7nhGObmV7ahQv1L8Qvfw6O5R?=
 =?us-ascii?Q?NVnhLrozq27Qf3qzUA+9i2l5mR8WV1PVcUFzT/2BS5NJMYWP3KCPV4eISp+R?=
 =?us-ascii?Q?B9Tlk3p4sqWrMHZRRHAAefZlptGeY4QdYplBeM6OVSsFRYKfBOzMo9g8A5O5?=
 =?us-ascii?Q?riXT+1YWgT/ricj+REqAw2xbo2RsDTXiKs3YMXoFZQo3HEyOgtzSxYfiiaNO?=
 =?us-ascii?Q?9ffVMxW/rsOs67M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:30:25.8283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db95a92-24e0-43d6-fb2e-08dd2f30358c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226
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

There should not be any need to revalidate bandwidth on memory placement
change, since the fb is expected to be pinned to DCN-accessable memory
before scanout. For APU it's DRAM, and DGPU, it's VRAM. However, async
flips + memory type change needs to be rejected.

[How]

Do not set lock_and_validation_needed on mem_type change. Instead,
reject an async_flip request if the crtc's buffer(s) changed mem_type.

This may fix stuttering/corruption experienced with PSR SU and PSR1
panels, if the compositor allocates fbs in both VRAM carveout and GTT
and flips between them.

Fixes: a7c0cad0dc06 ("drm/amd/display: ensure async flips are only accepted for fast updates")

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 +++++++++++++++----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6bc3a1d5e85d..ceb8ca19e3d6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11388,6 +11388,25 @@ static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 	return 0;
 }
 
+static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
+					    struct drm_atomic_state *state,
+					    struct drm_crtc_state *crtc_state)
+{
+	struct drm_plane *plane;
+	struct drm_plane_state *new_plane_state, *old_plane_state;
+
+	drm_for_each_plane_mask(plane, dev, crtc_state->plane_mask) {
+		new_plane_state = drm_atomic_get_plane_state(state, plane);
+		old_plane_state = drm_atomic_get_plane_state(state, plane);
+
+		if (old_plane_state->fb && new_plane_state->fb &&
+		    get_mem_type(old_plane_state->fb) != get_mem_type(new_plane_state->fb))
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * amdgpu_dm_atomic_check() - Atomic check implementation for AMDgpu DM.
  *
@@ -11585,10 +11604,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 	/* Remove exiting planes if they are modified */
 	for_each_oldnew_plane_in_descending_zpos(state, plane, old_plane_state, new_plane_state) {
-		if (old_plane_state->fb && new_plane_state->fb &&
-		    get_mem_type(old_plane_state->fb) !=
-		    get_mem_type(new_plane_state->fb))
-			lock_and_validation_needed = true;
 
 		ret = dm_update_plane_state(dc, state, plane,
 					    old_plane_state,
@@ -11883,9 +11898,11 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 		/*
 		 * Only allow async flips for fast updates that don't change
-		 * the FB pitch, the DCC state, rotation, etc.
+		 * the FB pitch, the DCC state, rotation, mem_type, etc.
 		 */
-		if (new_crtc_state->async_flip && lock_and_validation_needed) {
+		if (new_crtc_state->async_flip &&
+		    (lock_and_validation_needed ||
+		     amdgpu_dm_crtc_mem_type_changed(dev, state, new_crtc_state))) {
 			drm_dbg_atomic(crtc->dev,
 				       "[CRTC:%d:%s] async flips are only supported for fast updates\n",
 				       crtc->base.id, crtc->name);
-- 
2.34.1

