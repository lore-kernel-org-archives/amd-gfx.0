Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CB8C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 00:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A04E10E352;
	Thu, 15 Aug 2024 00:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D5I6Fpwu";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F32E310E33F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 00:05:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdXjCQ+wgpF6nxNbfQGd4IF6V2q7OgaHXkwWpHeiix4og/lXsQ2qafqKQmJnaeT2SvK2EpkY1HgoCXE8imcnAuxT6nqr9MiBkajvsS4/RRZfdA2cEibnII6R4NjLnRsJX6FvqcrLKuoVA9DySk952vdzV99AGf8yGKjE1xEObQN7y67nhq67NK7RSqd7Izd/2GkrvW7tR3fUMK5irRquRk+KM3bgeXT56/9wOyewV0sk8ZTLr3RmD6X5mGGTsITpOrMRoRFT0pJRy5RzTMjQrAzlTOsiAlUwa5k5HcFD8ITCHtOf06CTWV1qvTKFqjxlJFhMtv4tqw74FD99YXRt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeaWYRzsr4i2WshczX8nEvIpGeTvQgGee6nElgorz0U=;
 b=IzVgJKiKQz6kTjJO5p1vJQE0IYK5UwM6F71BBM8AKTIqDxIHzAnBrS2FvAlZD5xiY5J12I9/4lyS+imKvzEJ5Vgd5SBDbw/t9pbANlJdEZPLMgwzdYshbnirKixn78E7kfpmtvzPAAxIAw2UoipPhaiFIYLFJmhyYy6KCcX9269/Ax3KUi6rE+6ar5+CMOH3W4I3hI2B4z61/Y42Td4X9Zy3TGDQltSFzKyOYwLiyriUUvSV+4aJAOOMdNjFGoOjpXZ1NO9CKXmWy84/yRp1EHOK9Xv/mrxD/ES/DdFFqSyskSXvuGXWPXBBwcypsqf2mj8urLY2FayaXqAQ9LsvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeaWYRzsr4i2WshczX8nEvIpGeTvQgGee6nElgorz0U=;
 b=D5I6FpwusJ/Y8JsOrQDD3/PGi8Dtx2MBuo76lh9iJNLF8p8KtOb3TQxQihpIQrY43t1jgq/33XQ0VhPSwsAm0rgUR+BYsc0tSAVNSx5pkgrmVFMUArOx4Eo17VS33hcZ+r+jBqXBMvQrW+YKi69lBEjM5Wmbctc3l6GNFy2E10s=
Received: from MN2PR04CA0014.namprd04.prod.outlook.com (2603:10b6:208:d4::27)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 00:05:30 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::34) by MN2PR04CA0014.outlook.office365.com
 (2603:10b6:208:d4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 00:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 00:05:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 19:05:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 16/17] drm/amdgpu/gfx_v9_4_3: Apply Isolation Enforcement to
 GFX & Compute rings
Date: Wed, 14 Aug 2024 20:05:00 -0400
Message-ID: <20240815000501.1845226-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815000501.1845226-1-alexander.deucher@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dec6e27-5f70-4c97-9ddd-08dcbcbdf9b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vzd3WHhPeXNPdVcvNG12RDlVZng0M1dEaFE5QnRaV2NYcTBjRm1sRDZkWHNo?=
 =?utf-8?B?Z0hLb2daakJ1ZXhQUnRpQjZWNmdTWFpRVEVHMmR3WXpRaE56SVJkdS9CT0J2?=
 =?utf-8?B?endtTXozUnpMWU9EUVZzR1IyRmQybVhldTVNVmZWN2hMLytQc2FqTlFRK0Fr?=
 =?utf-8?B?aWpCc1BQWXVMU1FpN0c1UGFTYm1SSUZySXFFbUtkRThYLzFBL0JBaDFtbW1o?=
 =?utf-8?B?MVQ4bFdENVJsdC9XZGZYdmRIRzBMQVRaOS9XMG9HNVBEbmc0L0JZQnQ1OGZ4?=
 =?utf-8?B?TFlYUFkwbjByL1RaS2N2V2pSb09aaTVMMUNRN0hGZXk3c1dyNS9hUzVYOVFF?=
 =?utf-8?B?dmNUcUxjZ2VQNGl1akZJSWozMFJ5VndZUkxTdk51WjhxVU1rc2VoZDkzZGFL?=
 =?utf-8?B?anYrL2lRcVdhTFRuVHJ2aEpLU3dMOGpiYzlPcFRyNG5Oa3JETkV0Tjh3R0JO?=
 =?utf-8?B?ZFJ1bHB1V0dsY2s3RHlEcHFLTElrQXRkczZ4UjMxWkNpenBpaCs1RXpHZVRy?=
 =?utf-8?B?UVdOVkpHdFp3eThkbjMzU2VTSW9tNGF2cHhpQWV4QzZZeEpPM2R6bGpKQllD?=
 =?utf-8?B?L3oxN0pFY2tBZE15OWpaUmRabXVaNmFQNjErTzdSV1pkdHNtQkdZd0NHOTBq?=
 =?utf-8?B?YXJOWTdqMmQ4Vy9RWGJWeWJhYU5OL3Z0UXVzbldYamM0RDFrYnBTUngzelRQ?=
 =?utf-8?B?UjBxM2lFck5QS0VDbkwwQnVxWkhKc0Y5REtoMk1JL0xEVDBJaWV6Y3JqYlZl?=
 =?utf-8?B?M3lORzE0cVZhY1k4RXdjZFZOVERnODVPaUdlZ3pMdEFnVmN5a2JadHBMd0Nl?=
 =?utf-8?B?V0RrQUtoUlc5d0tkcG9Mek0yN1BXUVBzSFVXUlBDOElWNGdORXBrYy95Q2Vm?=
 =?utf-8?B?eU9OcGNBQ0hTdjFvdVR0V3g4TVh2ZWdUb09yZFhYb1FsclVmMjZrTGFKM0ht?=
 =?utf-8?B?OU03YUJDN28zeVo1L1JNMnFoL0JRT0EyMkIxdnJQLzN2T1ZHbDM3MExUVDd2?=
 =?utf-8?B?QWx2d3JScnl2Qks3YWdlRExiZVd0YjVud29HYnVzZHBYQkIxVy9KVnNWb0Zl?=
 =?utf-8?B?L3JxY3dCNzBRc2FhVW1aMkNhME45UnA3WG5PUm01cTB5VnhKYzVMN3Nsb2tJ?=
 =?utf-8?B?NTk0OW9yUUcvWEhBUnoydGt2VWUxd0NUUlg0bTRxeE1BdTcwN05iSEQ3SGFw?=
 =?utf-8?B?cUpCajdwYWZqeU51WUZLQUVRa3Zrckt0VjRBQ2xvUWpjMDlZZURnSXd0QTlV?=
 =?utf-8?B?cE1YbGF5TkVyb1o0NnBzVWp2bmdKZ1g2eXBObU1KSVdLajlCR2w0U0hPTnE3?=
 =?utf-8?B?YU95bC9xZlJCSllqUGM0cTdyY2VvNjdFNUpBbTViQTg2aTgxSUhLdGo5UmZT?=
 =?utf-8?B?cXVDbWN0M1BHLzEzeFhieDNnSWR0RmxCYVZYWWFsdGFJRUJyc3Z1RkNYbGtz?=
 =?utf-8?B?S0IzR2ZKZm1Mc2REY2crZmNieUU4SS8zWXJoR1FKRmhVL0hNL050ZVNlN002?=
 =?utf-8?B?V2s2NU5QY2ZyeW1sUURHNjFySW9uMXBDeXpnZWo3OUVtbENTUG9oby9zRFMr?=
 =?utf-8?B?K3daTHBFV09xVTA0eDM5dVd6bjk4aWUzWXdrTWd6L2VHZElNRzR3RnVVY21Q?=
 =?utf-8?B?VnJBMEkvaklCZ0xMUWdPVHRwUjJPdkRtNERCU1YxYWUvZVdKNzAvVlp5QVVH?=
 =?utf-8?B?NHBDNHpGd1RmcVJOM2dUU2duaFYzWmFMbU1DbVdjRkE3eXNLTWpXQ2hqSHYv?=
 =?utf-8?B?dml2RlhUd21jT0JoSWNyYjlzRVIvUDNNV09pUXFBRGhlTGp0cnhudmxwTE9Z?=
 =?utf-8?B?NkdMZG5XSGtLSE1JZ0huU1RReXM5L1BjazVPcmh3ekd0OHlnSDg0WnZ5YmlG?=
 =?utf-8?B?aThITW1qcGV3a0Vrbnc5dytpR0N6WllEcWlzQzVGWHYyRHdQcy9KayswNmhp?=
 =?utf-8?Q?PN/sFIiz6HnWT5oyeXrDUwXDJjWsWvbv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:05:30.3609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dec6e27-5f70-4c97-9ddd-08dcbcbdf9b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

This commit applies isolation enforcement to the GFX and Compute rings
in the gfx_v9_4_3 module.

The commit sets `amdgpu_gfx_enforce_isolation_ring_begin_use` and
`amdgpu_gfx_enforce_isolation_ring_end_use` as the functions to be
called when a ring begins and ends its use, respectively.

`amdgpu_gfx_enforce_isolation_ring_begin_use` is called when a ring
begins its use. This function cancels any scheduled
`enforce_isolation_work` and, if necessary, signals the Kernel Fusion
Driver (KFD) to stop the runqueue.

`amdgpu_gfx_enforce_isolation_ring_end_use` is called when a ring ends
its use. This function schedules `enforce_isolation_work` to be run
after a delay.

These functions are part of the Enforce Isolation Handler, which
enforces shader isolation on AMD GPUs to prevent data leakage between
different processes.

The commit also includes a check for the type of the ring. If the type
of the ring is `AMDGPU_RING_TYPE_COMPUTE`, the `xcp_id` of the
`enforce_isolation` structure in the `gfx` structure of the
`amdgpu_device` is set to the `xcp_id` of the ring. This ensures that
the correct `xcp_id` is used when enforcing isolation on compute rings.
The `xcp_id` is an identifier for an XCP partition, and different rings
can be associated with different XCP partitions.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 228fd4dd32f1..26e2188101e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -75,6 +75,8 @@ static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
 	uint32_t inst_mask;
 
 	ring->xcp_id = AMDGPU_XCP_NO_PARTITION;
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)
+		adev->gfx.enforce_isolation[0].xcp_id = ring->xcp_id;
 	if (adev->xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
 		return;
 
@@ -103,6 +105,8 @@ static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
 	for (xcp_id = 0; xcp_id < adev->xcp_mgr->num_xcps; xcp_id++) {
 		if (adev->xcp_mgr->xcp[xcp_id].ip[ip_blk].inst_mask & inst_mask) {
 			ring->xcp_id = xcp_id;
+			if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)
+				adev->gfx.enforce_isolation[xcp_id].xcp_id = xcp_id;
 			break;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index fa6752585a72..2067f26d3a9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4671,6 +4671,8 @@ static const struct amdgpu_ring_funcs gfx_v9_4_3_ring_funcs_compute = {
 	.emit_wave_limit = gfx_v9_4_3_emit_wave_limit,
 	.reset = gfx_v9_4_3_reset_kcq,
 	.emit_cleaner_shader = gfx_v9_4_3_ring_emit_cleaner_shader,
+	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
+	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_4_3_ring_funcs_kiq = {
-- 
2.46.0

