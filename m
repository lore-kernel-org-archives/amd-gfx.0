Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB14C8303C
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B6F010E632;
	Tue,  1 Jul 2025 18:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nlJwX0aG";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89E4510E2D8
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXzBopPTfPSdS2rQGZwbzDnX/M2XWzfcLbw5rTJFOq0YcB0E4enzUB2bnCVRnwulJ8gNg4HTjEpf2SMg+OY6Hh7+9zMGybir/3kpEQyxh0+SLdFZ0MYrOXLKDZ9Eu1XfololylBfF9XA0c0XDQJj3BW/zJm8TEaulyQYhs4ipulRkpWjfWjxwNZAqqsqXgLo6DptW+4H5yZSTA2iY1J5t/cJIpCoEge1wWxOir2BoOq/WVuyTC4101aZ0l1f8y3BDPk3VnIw4mVOTGY2nNcDDRD49zNKNMM6OhqzjsV1Bzr0UKSIuPHtWMKX4QP+3J4V/8fR40xtLFUTjGWHWAyqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKra5JSPgZKJaqQ8ouDFDfjsID6k4vQp0phYGWJQGQg=;
 b=uteJ0icuy8GUzpTzSs8QY9+5fRf7zzlq8MoLWwayjmIb2EGCcJaDp8evGrSI66ItR300uZKCSbwsVBgbw7C6U0pTzJOZ0aulGo2zAi6202I2W9I0pWCRF6CYjqGMdf2a1FW8kEtO+GUxYkgygfUFpNMu7Vx5HU4VkWsbyTy7Wsa9ZeCC17HN56DK7HMlaoQFkNFE2ampln2mrsCBHAwUmykV12XEJV0Q1mfQiBnHnz+jf7GUFtcxTHO/RQ9izMxgNe7NXJQC0xbJyUyRbrZ75RPo//ywJ2c4/8fO4qPGpnI3PfjWSiff9eRKXHGr08/Zl34hVPVcvB/bddliYEjJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKra5JSPgZKJaqQ8ouDFDfjsID6k4vQp0phYGWJQGQg=;
 b=nlJwX0aGein4e3dx80RFtIXRAJejVlORk/V3TDgGrKNdYNMimL+KbF1xQD9iFKB3uaxb6ixMZTKSvqe631+r3jNfPir6aNYM3p0FraRFr0oAhFtp+WSCzg0b8QsZxphsgAwZk8PYvL8AW6mYNGh+QhKXcGKjru7MDz8huEpK2kg=
Received: from SN7PR04CA0022.namprd04.prod.outlook.com (2603:10b6:806:f2::27)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Tue, 1 Jul
 2025 18:45:17 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::cd) by SN7PR04CA0022.outlook.office365.com
 (2603:10b6:806:f2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Tue,
 1 Jul 2025 18:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 15/28] drm/amdgpu/jpeg3: re-emit unprocessed state on ring
 reset
Date: Tue, 1 Jul 2025 14:44:38 -0400
Message-ID: <20250701184451.11868-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 0046393a-dcc8-4568-ebde-08ddb8cf6c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c52RQd2htdy2AYJvYBan+mO9po/vBIGgkRJ3YEhbnzP1CrjTMHjXmem9L8lV?=
 =?us-ascii?Q?or0wRHap4CKcLgvj/tz8DIQKGWDgNItnf5UmgYLpgKcGxOn/oV8tK2r0N44C?=
 =?us-ascii?Q?jSheoCKGEub3dKATMSIakdaF5vozydJHe2sJKYKcVntJd6tZDkkhm93gYEH7?=
 =?us-ascii?Q?RRNLC2RcM8rPZgnXbw78SbcxHU/nGb7jCo3gtPmEmus/Hggi1koTsR79W5V/?=
 =?us-ascii?Q?Da4niW0Nlm1StdtsRnqazLhAAxsoFHd4QKMA8dPMU9vkAllpcWESejVQ7xxF?=
 =?us-ascii?Q?kwWCYnDnfdkAeb4L1ByykZ9nMGhPFFB3nAcqto3WiSa874r6BhGtHDzsWyou?=
 =?us-ascii?Q?vCDasR3quzIM9cpMyoGE/YQUaitbbEraSpvmnVAT463BMLxzncE5jtAdbTfs?=
 =?us-ascii?Q?P4iLBIypvNGWwOBhdZLPhPyyHusWBW0PNCddSKSnM+kYCZTOEbADEfy/3vDH?=
 =?us-ascii?Q?fbyj3N27AEPzQYWhcfciKfDry1LV/d75GnX01UZJXHSCOnaQsgh7i1JgnXyr?=
 =?us-ascii?Q?sx2ehtqX5Cj/aVtIP3kH2hRDenKtPPLucoFDSKlKNPZoekpQ3JHU/MMrLIy7?=
 =?us-ascii?Q?UKTPXbp+wg+sn3egg282K1aZezwd8k4r3X++SbJVqGdIeQSp3JLLLyWYT2h7?=
 =?us-ascii?Q?/hzrf9Lxc9AH2ZNFFrSOiy9MVDbwckYkZyrA+juVT/+DeOY4bfq9959bn3mr?=
 =?us-ascii?Q?C5PZ06AoWHlOcyz+IoyxelAlg/t4l2QAYIhMjNoIt89zXJ4S52SM8ERG3kCF?=
 =?us-ascii?Q?WvY/JA1YBqUM9fuPHtmElm8WbM+j899slsM4RMT4G+48KvQ/mNDeb/ouCHfJ?=
 =?us-ascii?Q?MK3sE9EKCi1tzcyYS79O2j/0a2M3VN+TtW3UQcqDfTb+i+lC+RQhz7ndqOeG?=
 =?us-ascii?Q?XDugIJ6gNXcztWOOm0egEcrMmkVHj7j1Hc/fUcsRRNl48m04MZINS/RmmoE7?=
 =?us-ascii?Q?7Ild72RJIHRBYvNSmBnuSCwxTi1gYJGM508RaSaOQ9zeaz25sHgtVUtVeWZq?=
 =?us-ascii?Q?+DEEMmHoi7oFNYTRaL06eaoD8LPxxcKgmMgRIkMdXYPCBtL48J5XWnkoGMQk?=
 =?us-ascii?Q?0YwfNdlO++SiGU7dYWCG596Gdb6HHsKACnU5JtFSj47yFx+rBlThnrUs5r9D?=
 =?us-ascii?Q?wZY8e8yOD4o2qURO4Z9tNoSZ941bWyibTS2BfZtCPm6vsz5HSM6gZ2fzpNZt?=
 =?us-ascii?Q?TWSfmjJCtTbnhV5NxfGCWjDryhQ2xhCtrecKbjvFAAH5hRpVESZ/DLHp6csQ?=
 =?us-ascii?Q?ByFduL7qTiWI1Qdbkyq/NdmY8OFj9GL0t8bGHfgLGVz1yo2AMAuZkkN1iCCV?=
 =?us-ascii?Q?nxHfzrjgvgW4vC3Rk2hSftof5qtbdAYAR1p1t6IFA1HAM8MgyF5+73rWeX/3?=
 =?us-ascii?Q?cJKSh0MVcyt8Sg7hBW393Qb3IuQxbEA13bayNSmcKcx172liSF4KHOZmrXQ7?=
 =?us-ascii?Q?e/IEAbwogy3gjOgaCRM+LXrUU/UMGi7KKBqdz2HXdoKQtgJ/4dbL25Gzsn4Z?=
 =?us-ascii?Q?+u2/8dAgMTT2JZNBD87tm9p4eOHn2w9nMiOp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:16.7525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0046393a-dcc8-4568-ebde-08ddb8cf6c1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
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

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index a24bd833d6442..5598fa40764a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -559,17 +559,10 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v3_0_stop(ring->adev);
 	jpeg_v3_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
-- 
2.50.0

