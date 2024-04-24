Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6222C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 484BC11394A;
	Wed, 24 Apr 2024 08:50:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HCqrh6nZ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E83E11394A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bje4pH2nhxQqPU+nyfPXfANmOMyxsa1xcseKTRNuWvTnk24BmS+ZAA6bWyh6i5aDmjTv15rmFchJetroxy7FYd9/76/mlRfpBJ3DewAZtU0I+MznuknynAd92afBWwOIScPJMHA1wIfMy0S6b/QmpXSmqtChAGXlRclrmsyFsMqQFw042W/AhWRxELHVkPBgYSGTCMFo1ZacvQkXbgFEmPw/Yl5PEYtg2jw/+czyXPpbRTexBEdY2SQiXJpWy0bdteDzfV5ZFhSQTUbPzJw0wZj5Y4/Ko1oGoBztf4381oS9GSixpuoQqRQCxPofKn4NK81NoSh3TPkM6WsQBeNiLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+p1eetydjF0l7cCdrJDGWObo+m/urGHem2Pl2AXZuyw=;
 b=YCiJ+akLcB6CuuS8NwVVwcBrAa67lEFpbgEl95+xxSg8i6KwPKQJb+leWylVfe2kQX7kJ7+s9dZl+Kz1QTjcxml7hLv4hAXlsjeK3qkTJGeL8DVGMjluozI+uX+J7Ie8Ql1QwDqDhY5XiPJuVdPsPoMJimsbdiQz7WJDZ++GP7mmcUhWr5VvkDO6ogqI4Ic4QtUFUM2PufhYcJT/xJB7N8MSXd8hQgR8jjKfWft5DxssGbewBSYocsG0GvDtsqEGHM4ot1x4Y2QkxPd9VIq5CePlXgF8ofmK5oZQznFekkeDXFgIXBIVy8kj+6bsFFzIEqLHCJpduZD1Nw1rS0mkSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p1eetydjF0l7cCdrJDGWObo+m/urGHem2Pl2AXZuyw=;
 b=HCqrh6nZ5FeKGLiHKVjF+dnz9hZLaCOc3oEkaxNN/8gWor/2YN9np+S6SPTQ9pIMqPePwlzNN6zRsNBzMjcUPXbBbYm9zp0NgS19VtxTzCW3ZU8fqbPGFpRzQcfaJPEFKDyf8+dMDoDXMmJOP0S2Pmy9/K6Lgf0dYQN4lc2ek20=
Received: from BN0PR07CA0014.namprd07.prod.outlook.com (2603:10b6:408:141::7)
 by IA0PR12MB8714.namprd12.prod.outlook.com (2603:10b6:208:488::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:50:11 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::11) by BN0PR07CA0014.outlook.office365.com
 (2603:10b6:408:141::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:50:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:50:10 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:49:56 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Sun peng Li <sunpeng.li@amd.com>
Subject: [PATCH 02/46] drm/amd/display: Always use legacy way of setting
 cursor on DCE
Date: Wed, 24 Apr 2024 16:48:47 +0800
Message-ID: <20240424084931.2656128-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|IA0PR12MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: 446aecd2-38d4-44e8-e8d0-08dc643b8d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pjWOZB4u8iU4JYrGgaZAWbcFyCfffIAGUi9m4phAuQY2D8pTs28P6qbSYL9H?=
 =?us-ascii?Q?k+tfqy1kdiPCK5pmAFocFggvGyt8/QMwB0HlLW1oHsFxoHlbkSixbKYxBwAH?=
 =?us-ascii?Q?tzIj8ySQnvypXzJV85VUkwoL3UT4S0HFpla0rZBWIenJ58SCLtLk4Z+n/Qmp?=
 =?us-ascii?Q?o6AnhRhGpHOpDSrCmpXQ/xGVTgLwk8cLsQtCP2H6QRTS9UWLxKEOednASKqq?=
 =?us-ascii?Q?VoRMc+4KTk+Lpfme5cZDy3kg8R5CVGSlbwKKaqbh3toIgId/DaG2cs9oKdIF?=
 =?us-ascii?Q?x3l3Gl8u6H++hA/nn3P/ZuH13QA6Ehhg+5fTlQ7zPmNyaB8cvwxcnH8nXXOx?=
 =?us-ascii?Q?GupC8SdMp3q3LHGSsjN+C3BcQWEKi7VG0Ufq7Ik/e47g9zrwYcuGcALWcqAL?=
 =?us-ascii?Q?0d0A2jP70boUUcubMlkeu1qcovg1fasV8/drzDy6A7B2dlVhDJUBqnM7BWk1?=
 =?us-ascii?Q?Sr8wwfLK3xiROA2pi5u80Yczebe789dx7OYlWX6yQ1/TUV1+RuqzSEqJsncP?=
 =?us-ascii?Q?MID0aoTn041sEJizOrllJZ8Ks5hHJI+J7OxK+oeXX3HNgLaLaFFnhpvCzU/t?=
 =?us-ascii?Q?rzPRtQ3B6WB0ppqKMod/fGqUiny7rkIyL2/jrDYzOfSdQWcKD6JO3h32XI6f?=
 =?us-ascii?Q?CDi5Wwd+TY5YPtvK2OJl13Uo0rr+z0LIgYcp1LBCDqeXgqZvvUJGUThLeypO?=
 =?us-ascii?Q?1QDfeTfy/PSsez5B2MU9g5Z2iL/Tq+RPvq2aNYbJKivRh43h3XmdD1LJ4EBk?=
 =?us-ascii?Q?C/v2Vk3XineKc4QlI/SuBivvXaFZvoqCq647P5pB2s/Y4oFQU7qN7ULqtMWq?=
 =?us-ascii?Q?J9r39HSQxop01efaK2Qe/o0DS9Xoak5j5amDA/KxsO/+Be1bn50rz+w/BVXy?=
 =?us-ascii?Q?/XrqqCyWzo8xnQtS1SdyfzDrpFNYSvNtpeILCzN5RYLY06PCRDFfa0qZr73w?=
 =?us-ascii?Q?iR21dqrKAoHJ4SEzSR0jdxOqKoiXtEuL+mnh1YOK/i1Q+2+tzWL/byNoVLyY?=
 =?us-ascii?Q?+4QEtqsRZfYZxamVTTHXL6xhD1rhd1+JvczvFRGYNW8iCKDfNR+/MMLOj/yj?=
 =?us-ascii?Q?R983LOqYjpvHjVhIWwQqnDeZGjgxOp193/hRhD7OZt4o8WpqjKTJkus9bKuF?=
 =?us-ascii?Q?iBdxZlUwRFHeSLNFmRyTbB4ksI7xW01yfFyac22kFrN4/ovLgaTtC0iePR5m?=
 =?us-ascii?Q?XO+eqM/+q8s6AR6UWZassD1eUM+DhpqRz2gB9VKQf8Q02s4DgmnMy8hMHEKs?=
 =?us-ascii?Q?FpFoE4DFtH5q4WCaZQhtYuOPWCH/cEPrYkY9c74Y+l8r5gt9KtIHIY1DZ6kS?=
 =?us-ascii?Q?gBYyqF0jlP0Va7iaGXi7zzfM7q5oE3jLeQRnZM1iXxmJGnU/sNxZ5ILH5X5d?=
 =?us-ascii?Q?qGdajPUXvgq8qTYpWUZrpXFWoFHc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:50:11.1646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 446aecd2-38d4-44e8-e8d0-08dc643b8d0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8714
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

From: Harry Wentland <harry.wentland@amd.com>

Some IGT tests fail with the new atomic cursor updates
when running on older DCE-based ASICs. To work around
these issues keep calling the amdgpu_dm_commit_cursors
for each cursor update on DCE, even if those cursor
updates coincide with other plane updates.

Reviewed-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 75b65b243f1e..9d36dba914e9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8498,7 +8498,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			if ((fb && crtc == pcrtc) ||
 			    (old_plane_state->fb && old_plane_state->crtc == pcrtc)) {
 				cursor_update = true;
-				amdgpu_dm_update_cursor(plane, old_plane_state, &bundle->stream_update);
+				if (amdgpu_ip_version(dm->adev, DCE_HWIP, 0) != 0)
+					amdgpu_dm_update_cursor(plane, old_plane_state, &bundle->stream_update);
 			}
 
 			continue;
@@ -8850,7 +8851,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	 * This avoids redundant programming in the case where we're going
 	 * to be disabling a single plane - those pipes are being disabled.
 	 */
-	if (acrtc_state->active_planes && !updated_planes_and_streams)
+	if (acrtc_state->active_planes &&
+	    (!updated_planes_and_streams || amdgpu_ip_version(dm->adev, DCE_HWIP, 0) == 0))
 		amdgpu_dm_commit_cursors(state);
 
 cleanup:
-- 
2.37.3

