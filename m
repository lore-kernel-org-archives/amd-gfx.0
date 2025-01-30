Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734ABC0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 22:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC16F10E0F9;
	Thu, 30 Jan 2025 22:25:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dwLwXoyL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B2210E0F9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 22:25:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uP351qa3Qx6/8BeBkudl7JRRCo6UIqu9j8qBfjf4oN3ZD0BUKJ/6uTH5XvO4/fYTLufWemmlZ+FEx3bFKzPmveupNJ1s/rpndnO5eelLopMerkw747l9X48loCPAdHeo97+1mtfVxszqZDIc7U2QWjg14GfSOmCxRC5hpXvuzt/pqLx0pXqao0YkDo8riTNPPHD67kbsaR7L9rY3huiDOUVpYNL5cPNOU0d2Jlg5+MaDt8PlKVq4Pf840CLUG0Qe85pgv5dfyt/FSLJd+n4/2gFyC0CjkAy4P5NlujxPejn6Ls7hbvvGQZlCwcVpijmYrWskyGbTmY9X/EG6cGzANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5w/rvYS7aR5ImfM5LGrnqjKIM8rOWtG7wYo1GT+UG2Y=;
 b=s2VwhhxYvLhuSoQBCjkOvHi78cBNqKynb77PyXpLve1PfXHFVQN7gjVC3cTuhOitSWbaYSznjmOlunyqO9LjuTNyv13eg58J/UnTXMHUwGajNPLbKvnt3aOo26n1bR4mQpKB/LVTJT7yiFFNNe16hb3au00PlH43EKP9CnUrSm+ypXP6O6s1hioTisEHc8xumZo1gulsK/abLJruSql4x6f+x4rF+TKBDdxxp8tSa9dVxjV2LvxrkqWoDgbclhTjV27e8mMwwr9/w78AoK4vqcRnoeG36ZGPGpkTexRWo1xobVeBKEfFyGkqWZtkKJptH4eCyKJSBN2cNiAqY7Aqbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5w/rvYS7aR5ImfM5LGrnqjKIM8rOWtG7wYo1GT+UG2Y=;
 b=dwLwXoyL1yk3JNRt3Psci+UMwKRGfeHc505Yla0YaWn91JRo1CeJwexSKKTAnEzSt2Qvg0PTkZ9Ofh8uTDa3P8T6Y9KgPGxvE9QfB+9bcqDnu0on/H4IweKKBnBii61XaFl7m0WmSo0rAAOhzqHRktU5xt2XJTDl5VuKs8SnER0=
Received: from MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::15)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 22:25:33 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::c) by MW4P220CA0010.outlook.office365.com
 (2603:10b6:303:115::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Thu,
 30 Jan 2025 22:25:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 22:25:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 16:25:31 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?B=C5=82a=C5=BCej=20Szczygie=C5=82?= <mumei6102@gmail.com>, "Sergey
 Kovalenko" <seryoga.engineering@gmail.com>
Subject: [PATCH] drm/amdgpu/gfx9: manually control gfxoff for CS on RV
Date: Thu, 30 Jan 2025 17:25:16 -0500
Message-ID: <20250130222516.1075812-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: a310ff7c-2408-4b16-b84d-08dd417d02ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Uzg4ZEFQc1VxTmd5QUNsNW1FR3RSdDQ1SzE3Z1JlSzNPZTdEK1RsV2RiUWsv?=
 =?utf-8?B?ek56NnNKeWFJb1F6b3YwUGZEcFB3MDhMVE14ZTZzdUwrdzVmM0hqa3l1ZGdY?=
 =?utf-8?B?eU8xRTJ6ZzY3dWRLbUNDNzYwbHVzbmprN0kybzBVYzh0QSswRWhJWGFNamRE?=
 =?utf-8?B?RnYvcEpCZitsaVEwSHRuN2dWSktxNUhKUnNtNnMyYVJLZVZkZTJwbG1SV1dI?=
 =?utf-8?B?TjBlTTJIUFN2dkVyZEY4QldLc2JPVDEyZjhzajV0eHpKUER5dWx4OEdhYjFh?=
 =?utf-8?B?bG8yc2U1UHNQS2pLQVo4MEZteGlIVzRoZEVCUUZLbC9MbkdhVW95ZUhUU2hu?=
 =?utf-8?B?dHZoTVpXd1hMVERiMlI4azF0RU5BaUY5a2RhTXZ2a0JBbFdrQU80ME5YNEY5?=
 =?utf-8?B?ejNsQlZCeVk2ODIxajdMRDdEaVMzcktnZFZHY1EzeTJEd3hFdFkxbk1xU1BL?=
 =?utf-8?B?SWlRa3VuSER3RWkwWitTME5pMlc3VzdCQnMycThVZUNBQ1lITUFlZmxnZzhD?=
 =?utf-8?B?ZnB5MEV2UzYxdGNYTjNTV3RnTEhiNlFiTjI0eFpYVFh4TE4zeGU5b2YzMjM4?=
 =?utf-8?B?QTcydWJZTWw2NXZZMVA2cWVrRXY3b0hVcWt0TDZYK0dRcU9wTHBSdFVPYm5B?=
 =?utf-8?B?VStKQU9BVmYvMFJwYVhwWEdld3o0STRoemNWVVYwQytMalhFeHBrTWFQeG9H?=
 =?utf-8?B?WUh3cXREa2RlYjR5N01Xc0oydmNoQUVRV3NuU0hVaC9XWDM3dlA0YVFFZ0pM?=
 =?utf-8?B?a0Y2MXA0bUVLYVluM3FyU0grSjMrbC9HWm5rZkVoOEdNWW8rZkx4eWVpc3RU?=
 =?utf-8?B?UHp1NXVoeUNYWVd5MXYzR2VoR0JjNUNJbEZwd2RwNWhNd3RtUTRNK0s2dnRO?=
 =?utf-8?B?TmkveUZ5cnNLaE10ajlxaFhhTEJ1OVkzb1dHSDRLWUgvQ3Y5b0RZRUswbFM4?=
 =?utf-8?B?azhCNkY3bzdFSXVRQVEvbUdxeXYrSEFhWlNPaldieWdxTG8yMThuekxsN1BH?=
 =?utf-8?B?emlzR1JadnJiM3J4ejhrYzdWbWhXYStZQ0c2TDlxdS9rOEU5NUFnUlpDaDYw?=
 =?utf-8?B?anRKTTFkM2RYT2Y5c3k1aW5TVW9Ga2psbEVQcVBtaG5kcVhYSGJDY09mYkNW?=
 =?utf-8?B?N2JSK000dTJraTk4UTVmLzR2Tm9zdS9zdVQvRUxMdjFrTTcwejlwZlRiV0Fp?=
 =?utf-8?B?ZmFiSGZyWEhycWJHRFZiRG1tSEc4c3JZaTlOWnZYV2VyUFJ3cFl2QzRGQlRr?=
 =?utf-8?B?Z3dVNXlMUDY3Q2kwaDM2YjJRS0tOc1dHNStZeVhSaXhIb1FsZ3g2b2k3R2t0?=
 =?utf-8?B?QmxOOGFKLy9vYUpuSGJFNmFHYmtJeGN6cVdFRUJqK0dtZytET1Z1WnhtYVc5?=
 =?utf-8?B?dm9kVUtDenY1UHJtY1pTSGxhc1Ftc0N1Zzk1NXRoYUNPTXBMZDdJVE95NTZB?=
 =?utf-8?B?TGZlTE82SGl3d1JGVklScTZhUFczL2p4ZlBzZWZwbmFlSnhkQzV6TXJpdHli?=
 =?utf-8?B?MDBIOEEySXhWVUpIdTViOWZieHdqVWxPNUFyQ2RLWUl1Z2JXdDdTeTJlZ3BM?=
 =?utf-8?B?OGVsMllycExNWUoyQzkrWjNFVVJsN3FLNnNxS1BYZktkSjA4MllVcFlTZWlP?=
 =?utf-8?B?Zkt3R0lBWnFsWkZmYjBJdW1PZkZaUDVpanN1ZWFOc1RkZHd6VklVcmlrcFF0?=
 =?utf-8?B?NnlnYnlzK21BcFNUN2NIOEFTSGU5ZGM3Q0Y5ZUdQdDI2UzRGTUYxdUNNbUZh?=
 =?utf-8?B?ZTJ5bW9ueERtSnpjbGo1S0cvTFBwajRjTDJBT3dnUUxzRTlZb2ZzeE5SM3BT?=
 =?utf-8?B?TDY2SWhQVGJrbHdNY1Bzd2dRazVJTTNZb0IzS0hOdE95Z28xbXBtekNvVGNv?=
 =?utf-8?B?a3diUTc4TFVIQTNpb0VQYlJHZ24zTE1xTE92aVJPaWJsN0c5YTBhOUNkb21I?=
 =?utf-8?Q?9oCygO8WoCc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 22:25:32.8579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a310ff7c-2408-4b16-b84d-08dd417d02ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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

When mesa started using compute queues more often
we started seeing additional hangs with compute queues.
Disabling gfxoff seems to mitigate that.  Manually
control gfxoff and gfx pg with command submissions to avoid
any issues related to gfxoff.  KFD already does the same
thing for these chips.

v2: limit to compute
v3: limit to APUs
v4: limit to Raven/PCO
v5: only update the compute ring_funcs
v6: Disable GFX PG

Suggested-by: Błażej Szczygieł <mumei6102@gmail.com>
Suggested-by: Sergey Kovalenko <seryoga.engineering@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3861
Link: https://lists.freedesktop.org/archives/amd-gfx/2025-January/119116.html
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 36 +++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 874acb8631c9e..058f55f1e3fcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7440,6 +7440,38 @@ static void gfx_v9_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
 }
 
+static void gfx_v9_0_ring_begin_use_compute(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ip_block *gfx_block =
+		amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
+
+	/* Raven and PCO APUs seem to have stability issues
+	 * with compute and gfxoff and gfx pg.  Disable gfx pg during
+	 * submission and allow again afterwards.
+	 */
+	if (gfx_block && amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 1, 0))
+		gfx_v9_0_set_powergating_state(gfx_block, AMD_PG_STATE_UNGATE);
+
+	amdgpu_gfx_enforce_isolation_ring_begin_use(ring);
+}
+
+static void gfx_v9_0_ring_end_use_compute(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ip_block *gfx_block =
+		amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
+
+	amdgpu_gfx_enforce_isolation_ring_end_use(ring);
+
+	/* Raven and PCO APUs seem to have stability issues
+	 * with compute and gfxoff and gfx pg.  Disable gfx pg during
+	 * submission and allow again afterwards.
+	 */
+	if (gfx_block && amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 1, 0))
+		gfx_v9_0_set_powergating_state(gfx_block, AMD_PG_STATE_GATE);
+}
+
 static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
 	.name = "gfx_v9_0",
 	.early_init = gfx_v9_0_early_init,
@@ -7616,8 +7648,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
 	.reset = gfx_v9_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
-	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
-	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
+	.begin_use = gfx_v9_0_ring_begin_use_compute,
+	.end_use = gfx_v9_0_ring_end_use_compute,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
-- 
2.48.1

