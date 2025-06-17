Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01497C7115E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ACF910E49B;
	Tue, 17 Jun 2025 03:08:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="grMeo1fH";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09A1410E47F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfyPkLdhNTDP5fBNDdbNZLToL0GQT1/KUTvyR0s4EE0hrPaW0S42NG6L8zI5jA9g9cfCyG+zdX+2DqdEFEzpypifSN7Zs7W9ZM158lxVzuG9uKl6xdPMNRxPfj3UmtXbIFqzzMALsTFWlKF56XcraLRHP2E2txLFFxGXc9uBiTEvkDjO9PuULh7mKB59LzjiFsGQt8IOJ7ZgnaSdFVpR6ywP3MydaDcmYNBAQNMdTrfEBI/OM9iSMP0XPl1c+4EHuzNKv9NVqwRJOwMSiS1u+CurpGGwVcbWbXOQQnObdhUFRnxl+JH5UCBNcZtley5PI56qpDqIbQTL3HsMC05djw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Dd79sY7uQUBVGuaEb8PiwJoECh4Vj10Akc5/pp6Zyw=;
 b=ZUoWzVYx9jlypI1galVzsrDyypycocWVTF18yiTQ2GjZ7quUHTBDYGwxdYNDe1sSbUpceHHwCt1C6QjC7u+/IMywZadXNdaXPGikiJ8WbRhnRLjZzLW7AbXw9qTKNKVqgCkbS8566gwn39/2+YHnosLauBdo8QSIMtv3Mgv3MVwkRXuVLaHG6rexyARuoqB6LjC/Tq0A7o2vKll5BfvoMXoL7M5TyzX/b2fuPTUs6tjGVvPCyTGC3g5MTz+M/Ue8BE5UeGkl+/4RqYFLM/q+SruF7dnTMiRdMt8QmHuYBygWtFbICQVFqlpEN3nIn8ofWdDrLejqvOrHFiwuWJKYKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Dd79sY7uQUBVGuaEb8PiwJoECh4Vj10Akc5/pp6Zyw=;
 b=grMeo1fHvougSwi12UGGApE6Kl2qajogq9NOcO/snKyvnuoj/U0hQFXfG217VqAlkhb4WqMDSg+iSvQ/mpGpu/aJzPcKiJwc5o5V+arDCp+BvPxQO+t4BcVbv9DikVTvzCAWZlmViDieum0xpsGqbxaXV+KSY94rUoMm7YwLVqI=
Received: from MW4PR03CA0162.namprd03.prod.outlook.com (2603:10b6:303:8d::17)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Tue, 17 Jun 2025 03:08:51 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::16) by MW4PR03CA0162.outlook.office365.com
 (2603:10b6:303:8d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 17 Jun 2025 03:08:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 30/36] drm/amdgpu/vcn4.0.3: re-emit unprocessed state on ring
 reset
Date: Mon, 16 Jun 2025 23:08:09 -0400
Message-ID: <20250617030815.5785-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f70013-7f9e-40da-6cb4-08ddad4c492e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+pjxY+nmzzNE5KP16zszwmJHYZtf1I4+mHbyyOj3i1E3IxjeFLHmNr3cehfp?=
 =?us-ascii?Q?tpIWfr+AjjiHMyHiy1HfZUoTEyKGrkBAZaEjbVK0xssb0Ff6RMyzeVjn6uIy?=
 =?us-ascii?Q?XF7II+WP2tz2eIgk64IHjKrRw6VjwCATyMVhCcHnxrJjN0LWJHiPGM2xFRPg?=
 =?us-ascii?Q?DxPoLOVBpHEgRujuLI2ILSaN0wqt+WnA8OkWloN/plAfL9TNxSyxJbInW94n?=
 =?us-ascii?Q?PgMMkVoVUz8jbfk9aJEfJqqvlpnVYEJKSyqBk1fyJxj7cTXesKuWPN+yLsur?=
 =?us-ascii?Q?qr4jj6k1dTb+uS70bqUNgUl/fdNGdXdQN+3HCaixx6SqosLQGH76K7n2tnj2?=
 =?us-ascii?Q?dpI9z/yuvZHDlwA62605DtA0P1hGtXG2eq3VtPsx8AdeSK6jt8tBMBX0UVnG?=
 =?us-ascii?Q?f8SrMuReYUKHqLop5wRK0e2VLm883O+OaiUVYRj/Fk7d3L8nagbeWcyp96ec?=
 =?us-ascii?Q?A/YjhmFkGAaVE5enHG977U1RIEVhjBsyT03Tra5dDAfHEIRgW5cL41DbtFyz?=
 =?us-ascii?Q?y67BI6swteR2rtw6LYIhe34flHIjmm7bK2LKo2vlXPV+lL4iYkpMhOYZsRSr?=
 =?us-ascii?Q?nR8f7MOnyV3xy6gAFusFfShqffvCfeONJh4/S8AlGR98SZJm2bM16GQFKqwU?=
 =?us-ascii?Q?h3tyWHtpgZd2F32zcpXKh+osoHLxyNMbbpoYjCT6NQEK27+VXBRVVw/XVccC?=
 =?us-ascii?Q?qOfpGoKlw7o39wxzHdpPz8z/OvhYp0083RXRHKpV2eml84XLUmgZOJ3hhDuX?=
 =?us-ascii?Q?uMxV2RY9rEklSAXBx6AOsvFZczsAQDK55irWtWi/X9HpTkW9lcwNpvSBUxsF?=
 =?us-ascii?Q?1nA1ZM4QiDA6fYMCU3oBcTJhOeBezlP0Ll78Hh4z+DTlhn3JDL66AHUeL7EL?=
 =?us-ascii?Q?Y+iPIcD1hJLQ3lE4IbgKPWWPU7EzFYo11jJvb8Id/GAGVk4FZHXTEdJNF7ei?=
 =?us-ascii?Q?gfJYvcKHnb3Abz/SslFOnLPcUD1xJ4HaxPeC1/oUZctcvP7S/KgX3y/tkISP?=
 =?us-ascii?Q?tAKoBc5+RlFHaNglXD1+Tp6YqaLftcPjWFOZEUMXTdx5odTuPNmCL4rVex5S?=
 =?us-ascii?Q?VD2WXVJnxFg4Y5eh1tdIRbdauhm3STfusuke1n+SKp7Fk0z/BkzgtNnWoNHe?=
 =?us-ascii?Q?SUZEbycwD4kx0N1Ba0ppVULNha8CEBdhYVNXGIE+5B6QgJU9q138xxJj3W0l?=
 =?us-ascii?Q?2bNqIEIyXT/bIBx3aLUyX8C493fivazu3U6PcEYz0A+oFDTGmyAuCBnp8BCG?=
 =?us-ascii?Q?lL+U1/7y9mHMJKf4wYO4TzcH9LVHetQ7axHlIgLb5S3XwVtfD5utExm02vbP?=
 =?us-ascii?Q?9vF6aMHFou0bhlWo/uZ8evWWNJsI/iBRNot7gJl+btkpTIjJSy8NpkzL/wW+?=
 =?us-ascii?Q?768bpUPM6Q661X7+T+gH/HxiviNz1bfAPCFlJj9CBWgYAaMDDB74Kl91XF3v?=
 =?us-ascii?Q?TgvRTsiN2YVvWvrggtNzaXv3tvbs6YGRAwOV+2ZM9TcVAjp0oPFcFJdhGpvx?=
 =?us-ascii?Q?l5KkwgF7rZjhg68wU6rvulvMdtZtP7RhPENc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:51.2050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f70013-7f9e-40da-6cb4-08ddad4c492e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 31cd27721782f..fcb0f5954ea06 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1609,7 +1609,7 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
 
 	vcn_inst = GET_INST(VCN, ring->me);
 	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
@@ -1624,12 +1624,8 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
 	vcn_v4_0_3_hw_init_inst(vinst);
 	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, guilty_fence);
 }
 
 static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
-- 
2.49.0

