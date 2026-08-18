Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC36C5DF8B
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B1410ECE5;
	Tue, 18 Aug 2026 20:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OXAah3Fu";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013010.outbound.protection.outlook.com
 [40.93.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4711010EC8D
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isTAEJdjxFZ6DYyv+ACBc358ZmwRx1Fqgoyp4GfZEN+4o6adxThxwoaOvR6r7hcXr88gAHjMAii3Kedve6pjrD0YwwRtDRpUOJEYf93MgwPAkXclrOP6AgVyAXWUOjEGaSqWZMa1Zh6+e53v/j5CaBCSNc2+lF1Wla+Bzb55ifCVjRp5Ipp/IENwuAfmOop0mc+X15YIXkqF3gqeKfqcJC0EgRGo4oGX2z6LwMOKt9bzvet4DrEj/TJZn8Q/FUT5qs7Jj1JqY/xtX8x/GTu6pi9qMf5YwruSO0vrV/tm/NLS2CpR53QN7XvB3v5jyDMd1fasLiH1xECea0ZcIIUKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIXt91wtnfsOn4WKycUqt3XLp/MsRlqrYPd4dOAu8vI=;
 b=JZC0eBwXW8A+DzA3tIQ+VuYs6GqidyCpARV286SzfjyeoWP3F6Rkic5FVsiJ+8uGTSw6RJ6JV99s+EcTCWDsCCiTbYTfVquqTOr7RZo6TdvChqhAlFXz2CDd5KlIPjjj4fQ2XZzOwL+MYxmj9YCd7we7zg3t4Cl0RuyHnCmxzzFRqXDhefcl9ntK43PRMFfoaHjAE2a6BGASSXqKDSbhkQGoMlG1F452TAXpdU09cXIsos4WdsJYeTJ1eiN16+WnaWb4/0TVt5EEkCYmb28aZMkGHeh+j/PZoGn3ewjAd09Dlo2xTtx/iAjf4+bRnrK2HmRZxkMPZmiPxpeOnxoF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIXt91wtnfsOn4WKycUqt3XLp/MsRlqrYPd4dOAu8vI=;
 b=OXAah3FuQl74EKpxfZm9pm4GXQA80JrRYgyFxjphCaSga2sDt5AFap6wUulaX667t1w/tDeVUR9zcxiNhrqoW/ljFEhY8ic/hQMffu/gDexezia+O1uUY23CrmBtZWNsasyPv/YKxY5P43fBYoOl3PwBWJYG+iSJAO0+gndsVoQ=
Received: from BN1PR10CA0023.namprd10.prod.outlook.com (2603:10b6:408:e0::28)
 by CH1PPF2EB7CF87B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Tue, 18 Aug
 2026 20:21:58 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::6b) by BN1PR10CA0023.outlook.office365.com
 (2603:10b6:408:e0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:21:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:21:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:21:56 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:21:56 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:21:51 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 04/82] drm/amd/display: Use fast update path for address-only
 plane flips
Date: Tue, 18 Aug 2026 16:14:56 -0400
Message-ID: <20260818202139.4172592-5-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|CH1PPF2EB7CF87B:EE_
X-MS-Office365-Filtering-Correlation-Id: eee603e2-afef-4497-307b-08defd665a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|11063799006|56012099006|22082099003|18002099003|3023799007|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: umtj5t66RwtwYMx6nYzh6VYALoOm+q0u3dut2TEKWvDsRdiSqJLQeb65miN+ii+Q7Et9+F3f6p57Juf31OwDVz7PFHmzxJC+NjQdPqUTdQktljgp5hte8EP7ThzGRJujTUPdsDHPAkGnWwOkTz7WWxUHsmYaZ7IFo28smm9ad0Gs/Q4Ws0xhrH3rq35RfUE2PjTzjsFnFfwIlQZQ9HB1kVUG5VlZLipDfv/DR6ZBalWfj/7oE7vMRS4QDBF9GdQkTB7IGqkvvQKs/Jyf/Rid1xM5C/orBj3PFKyl6U5/XsChJ9xCQrL+j7642BolEjYi80/nMyXK5cNmr+kZhdCZsHQMPLi/R9wJdRZw9qSZsL6LsxnuI64mC1THTMUf0JCxqvUHA3irg6F5I0ldBNAS8lY2y+tIOYIaJKdQPxO811L8mEQhpzvr5Npkqoidjuk2uyZA1C1euN1LSiCyNOFNjUZopIUr4POPzJVwWPgJQ2EIT+7d26zF4S0wCcBIbdbisHHgr6EceipqcYr/4+5xlk6ydWb9sT4i6f+wZlNqWd5EZuSbxuztJ0ijCucMfC+m7whBx+3GlJnr/pmuAetZvX6ktI757U3Zd6PuWNrG47eauGdkTwRWmXnObBrjOkErQWyDi+glADut4XeDkmpQPh/thKQzZJUfnyng4TGSQ2f54dn4b7d4pgW0twtBnuCwSLtZjTvtY/CxJ06HsfQEjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007)(5023799004)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gq6JqfoqqQjovnq0dibcA7Ci9qSbg0vFw7SyoU3cyIX45/0+nz43pmYSKYbRb1M2RU23tFxqLclBykc7KhupVbax8Zg02kSO62681cGzwyLnMVPYUHYSiEAHHpd03F/i6OeQUj3hIOvjQFl8o19fsYcJsz19/NIQMOLdmeeiItelpyfBuFZNUqglc5WS02ghXLaMkoWjUw1gttRO36b+/rj9qjBsEWuVgqDEg0SVboQOFgop1wePs7LRsYu1Uh+7fdn/6ehm1aJNIfRaiECS9GVhryrGuzx/QSAnuD4ca9KLhpWBU9b1+0Q+osMH9ieprLd7bIx1O1oWrK474OWFSdwJsdlCnVeKZvZ4EJYX4gMd8896khaiYR0pI6pi6BPiaZBZf1nuepfTmmg+4ec/DM0Tj5x2YQIJMR9csmq7DutGbjAfExePCa/b+TfrWL4q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:21:57.1722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eee603e2-afef-4497-307b-08defd665a08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2EB7CF87B
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

From: James Lin <pinglei.lin@amd.com>

[Why]
amdgpu_dm_commit_planes() unconditionally attaches plane_info and
scaling_info to every dc_surface_update, even for pure page flips that
only change the surface address. In DC, full_update_required() treats a
non-NULL plane_info or scaling_info pointer as a reason to force a full
update, so fast_update_only() always returns false and every commit is
routed through commit_planes_for_stream() instead of the lightweight
commit_planes_for_stream_fast() path. The heavy path acquires the DMU
global lock and waits for its ACK on every commit (spinning ~27ms),
serializing the kernel against the firmware even though the flip is
address-only.

Tracing the two commit paths during a steady 60Hz flip on two outputs
shows the heavy path is taken on every frame, while the update_type that
DC computed for those same commits is already UPDATE_TYPE_FAST - i.e.
nothing actually changed and the full path is chosen solely because the
optional pointers are present:

  before:  commit_planes_for_stream      (FULL) = 550
           commit_planes_for_stream_fast (FAST) = 0
           (all commits carried update_type == UPDATE_TYPE_FAST)

[How]
Only attach plane_info and scaling_info to the surface update when the
update is not UPDATE_TYPE_FAST. fill_dc_plane_info_and_addr() is still
called so the flip address is populated for the fast path, and the
scaling info is still computed into the bundle; only the pointers that
would otherwise force a full update are withheld for fast updates.

This is safe because every consumer already NULL-checks these optional
pointers (copy_surface_update_to_plane(), get_plane_info_update_type()
via det_surface_update(), full_update_required() and
commit_planes_for_stream()), det_surface_update() clears
surface->update_bits on every check so no stale state is left behind, and
UPDATE_TYPE_FAST guarantees no plane_info/scaling_info field has changed.
It also mirrors the existing flip_immediate logic, which already relies
on acrtc_state->update_type == UPDATE_TYPE_FAST. Non-fast updates
(modeset, rotation, format, DCC, scaling, MPO, cursor, PSR/Replay) keep
carrying plane_info/scaling_info and are unaffected.

With the change the same workload takes the fast path on every flip:

  after:   commit_planes_for_stream      (FULL) = 0
           commit_planes_for_stream_fast (FAST) = 449

Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 567bf04979ee5..e1fdd0cb65b34 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3884,8 +3884,9 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 		amdgpu_dm_plane_fill_dc_scaling_info(dm->adev, new_plane_state,
 				     &bundle->scaling_infos[planes_count]);
 
-		bundle->surface_updates[planes_count].scaling_info =
-			&bundle->scaling_infos[planes_count];
+		if (acrtc_state->update_type != UPDATE_TYPE_FAST)
+			bundle->surface_updates[planes_count].scaling_info =
+				&bundle->scaling_infos[planes_count];
 
 		plane_needs_flip = old_plane_state->fb && new_plane_state->fb;
 
@@ -3906,8 +3907,9 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 				 new_plane_state->plane->index,
 				 bundle->plane_infos[planes_count].dcc.enable);
 
-		bundle->surface_updates[planes_count].plane_info =
-			&bundle->plane_infos[planes_count];
+		if (acrtc_state->update_type != UPDATE_TYPE_FAST)
+			bundle->surface_updates[planes_count].plane_info =
+				&bundle->plane_infos[planes_count];
 
 		if (acrtc_state->stream->link->psr_settings.psr_feature_enabled ||
 		    acrtc_state->stream->link->replay_settings.replay_feature_enabled) {
-- 
2.43.0

