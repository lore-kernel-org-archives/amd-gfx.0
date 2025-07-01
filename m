Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C32C8303C
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0274710E629;
	Tue,  1 Jul 2025 18:45:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZBLgc7hk";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21BEF10E625
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcXkil+G/UnY+mexxh3boc8Z3eJKB0Mv2YfcIJjcw5nmx4PmKWaH9bXW4tXfh8bw8+GhFVVJgAmtdSQSJZ7lOIScbYoD463F0HkM8kysXfni/j9DDFV9aBZkSUv0Q9ltP7aUpWDXRa5jApm3ztFPF49sl3jiA6NmZaUHBw75EhSPKIalvBIOPMLAUp19lFd7nJFF87VqBB3M4cri4yiSCCDaNXmnAhxVv30wjwqqxUVCSRueeOZ/kWbhdll58mor+DHcAYxd7wLN5TJEZv3hocmP2KWlYkbiCPFxvKL+gqeOeSqrn4oaP7ks1Msn9rdH0WlJ2YWwI3UEnEwJrpTKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8eFJ/jVkRvKx6Ll7gObfAg3bVRNc/PMypaMrIvAxPI=;
 b=haDAILvCGrtcQ+xf7G3pOANV55DBdZRcvfALdySZizhP/6wwCAsFle2ZyahowxJNYCy4Xup83vtcZZ6tHxT1ld2OH3Q20XMt733rqWSrZ28S4gIdr3MJ8jmeJxUh7D0y1dZUgP4gUdYqyfxZn2n7Vb86G3f6GY9dP1wDPEFg/rqqISfCo+RJxGGqLOYTrQg0DYSub5jKTuu1JI6pmfVx7Bph0Gpj4gGfnwY08J0332lTJzTYkiCkq4RhVlu1Tmr9+z7Ss1sc+zfSyShMM36Gm26dtnSpEIazOIcuCVP6np4HFj+LzRlsHNq7l4g/+T434UsUAzUM/KFNdiqqfSixJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8eFJ/jVkRvKx6Ll7gObfAg3bVRNc/PMypaMrIvAxPI=;
 b=ZBLgc7hkxsntA/2F1T+j8RDADIR3wTL5X6cafN7ZyBitc3S9C7/nHPdY4PyTZM5/KLYZ70YcfFORmKObbk7mH83xdXR/g0lc8lSCn5YpGIPqY+UpVm38eEUhJCfSE/mtRvoxEUIMXGRbRvGPGcIoGAE0OlZ3KPNgEucd2G1i5y4=
Received: from SA0PR11CA0006.namprd11.prod.outlook.com (2603:10b6:806:d3::11)
 by SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Tue, 1 Jul
 2025 18:45:16 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::92) by SA0PR11CA0006.outlook.office365.com
 (2603:10b6:806:d3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 18:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 17/28] drm/amdgpu/jpeg4.0.3: re-emit unprocessed state on ring
 reset
Date: Tue, 1 Jul 2025 14:44:40 -0400
Message-ID: <20250701184451.11868-18-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|SA0PR12MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: b19820fb-1586-4022-3b38-08ddb8cf6bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d7/RANnWZntUXQRecdEmKQXMMvmV11UpWDLIYMWv6JoEMroIfr3rQfoISKE3?=
 =?us-ascii?Q?MyDXPoP4rs19AK1330S16e6bknLLiKUmvBc1/m+FWz3p5Nty1GapT5auNkgV?=
 =?us-ascii?Q?SmFUTh1E2LDnNqbAqgyg0Rb3FTIwkw5Dn+HvyQkOCQdN1Y3t6JtXWQZCwYO4?=
 =?us-ascii?Q?puqFUcVDqgjdJzcVECh05SFbWlcIOR48v0mXI7B/vJ6F/DWCJzOn+JbgCuGe?=
 =?us-ascii?Q?VuCVlqyLfukveAir2i8O8yRvcMrEdO3Tzumm0piGLG+2FKzuLXtHYKpw3+FR?=
 =?us-ascii?Q?xXxGQdNTnVgvYamhShOZKN78modgxYPb9oSStoRPkZJOGLiFseliWJlCiGm+?=
 =?us-ascii?Q?NcjzXj5MZvP3c3KYQuc/EDd8ZUgCdd9DFvrWUzX35MLc2MBMjVQ9FnYhqCq+?=
 =?us-ascii?Q?vcgCEmR6AD1+AOhoZseYe2LvGNJnc/atoA0T+o24Fcr0ln1hvkCOs9bsFyt6?=
 =?us-ascii?Q?d0UWNzvtksaJdI/bBgyDJtpO0oRVCaWgLQtN8VbFgnbPidJsFQUzZuscTeXg?=
 =?us-ascii?Q?dFl1DlhbD2DCl+FXsebsN5uMMlbxcgHAWTAtIWP7sK/HTBoT4Bcmj4R9aLjP?=
 =?us-ascii?Q?hOJBzorYj3Lq/Ri+miFnsl+H06IZH98l/2hFwSfaeNg0j4bSXsCxxtP6geYS?=
 =?us-ascii?Q?er2maHZ5F/6LgPHKhvdjF54eizUR9D2RoLskSQz7YKwlcJiMjKCXWOx2rCaE?=
 =?us-ascii?Q?1wI+mHkSvdblX1jYKmxVFWo88j4nyLSn63kmWRzRvjGYF1bzqnEHJtZvb2d3?=
 =?us-ascii?Q?GdLfKYFWUA2VYT15KNMI7fSEfi9dEgGx9w6dEv4KF9FMrHkdY7xf7h/Od6T5?=
 =?us-ascii?Q?aeo/uEzx81b8xwnyKGgeEry+8cF4+u43trcn9nHFBF9jY2HR7YK9jYuzvvLZ?=
 =?us-ascii?Q?F9+iEZTreBCiG6S4Dgz5eMUthzZbhmqdaqCL+lH2dCOLVQdgI8VIO9A2YP1S?=
 =?us-ascii?Q?S0fE/tqBupjQzlaOa2y2gMV/fOCJlxj1Y/NWM6pyuF5HbNqoTbJPYXV6ADMT?=
 =?us-ascii?Q?ElZjOl3vnhwbTXWL1H10ysIOojdR5QxtbbZjG1udTC76kcUeHFkNX7JQU8AW?=
 =?us-ascii?Q?EziqDw3Jv0HG8OBS/mYpoMFQxMwj/FQIage+PMDGaYSgMiQn0fDVvGlKJHNN?=
 =?us-ascii?Q?V7sl9H4LXXiQbn1PcnXTcTL3Dol2GuSp36CAGOURNH4iVGvMtM7PQAt9NXSx?=
 =?us-ascii?Q?duWRweflN8LCzzqqFUNY0tG3pS7596IFHV3lo4Q9WuHDCXsLcXmWrx2ozmnl?=
 =?us-ascii?Q?3OVKMgcPUECJZGiFIN/N035lD2raWZazEE0yhORrwdNJ/cRb3xxaE3o5bvJk?=
 =?us-ascii?Q?ep2NTuDAiVhNw6r8P/usJMF1CFC+3TFyj6Pc50OOjmZi1hCp8ACrMx43VpBa?=
 =?us-ascii?Q?6DUzFYrx8hrmF/GpJmAG0IOCB77hwkTsbhbHbZZ4+fMXapphSzW3Nig8to0N?=
 =?us-ascii?Q?B9Or+YszZaSB4M6PS5uWUlA9Qpx8D6mZFahrnJeMiE+YYsHMWKWSHWxKFVdY?=
 =?us-ascii?Q?lP/RuuT9vseQkOjGxIdN+yEzRgFU08jZPs8q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:16.2517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b19820fb-1586-4022-3b38-08ddb8cf6bd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7091
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
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 78441f8fce972..c3f73a2a911b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1147,20 +1147,13 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v4_0_3_core_stall_reset(ring);
 	jpeg_v4_0_3_start_jrbc(ring);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
-- 
2.50.0

