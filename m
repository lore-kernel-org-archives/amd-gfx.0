Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5490C19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98CDD10E2E6;
	Wed,  5 Mar 2025 05:15:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BqA1cj89";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 171F510E2E6
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ozj+K8gvh71EPX7pZ/5lxmubB0cf8m/f1FhUkwaDmtgZ8CJn+quE0gfz/vePXIBLGO63L2Yk40gfDIOB+O/jq4TrlcUG6a4nMx2M5qs3LgU+QlUj4w8njjX4mvlyzDCwLDNyOni2Bl+5RhxmlxKCAxA0arroDGZNclDQSpkcYBhxMHYBs/Fgd6g3QZJyrmgS5Sy7qS2+WQZ1DLWgSK1x17DUFZoHicdHN4NnEImbbpb/TNlRmiAmB+MCOwYbv/Zmblqz5F5XUrMZdaTZ3IPa+E7tUdUUzrxsK4g8cmRitGozKU374d3D51RJ/BXNCImkgxFxnhl/uWTVyDBjHAWvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlGynyEVhVgezOkn7jKGYpn/wBN+lJJp45BVe5d7Des=;
 b=IxJwospkQvlU8CkuiQB81vD//k6yaXShT7FZ1IyG0rroOVvz5CTZ58MJJGl4uygXfZsQQ9NGBD7sC2OCxz+3Ap3ObPcEYXlrVynxxsJoeMO7H5LR8Rj+ialCxQHTcRmUGDVTPAzhla06/g0WVUP6VhozkYBgR2cDw5BicGigoNGS1PAZbjc8tvTMF/qH8zDPH4AU7eAKsv1c87ree8CE0ksxC5w8/DAGObK/sW6mnhSkt2f9HnWYE/Ynzwon2Btb7P/yNtExQl72fluiMqwyMF+1tvl/e96+YXo7lO1Y6a/xD8X4D7cnMDZRELncgL++e8efvG/9jumudmyzQbn/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlGynyEVhVgezOkn7jKGYpn/wBN+lJJp45BVe5d7Des=;
 b=BqA1cj89Lkc4Ki6QE0qzVaDUfzoRMm0l1SG/fWAYc/LfGm0VXMy8UlS9oEgdtZ9XwZddxXFxeLt9JBKaDZSlNGbWf2pMWAslLcJvMlWtKz7Ve3XU6sFcqnowEz5hAFS6OMbGsmgSfKGqBtUop6EwC+VIJTeD4/qgHi7d2HokpnM=
Received: from BN9PR03CA0627.namprd03.prod.outlook.com (2603:10b6:408:106::32)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 05:15:16 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:408:106:cafe::39) by BN9PR03CA0627.outlook.office365.com
 (2603:10b6:408:106::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:15:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:15:15 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:15:14 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:15:06 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 06/22] drm/amd/display: Add and use new dm_prepare_suspend()
 callback
Date: Wed, 5 Mar 2025 13:13:46 +0800
Message-ID: <20250305051402.1550046-7-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 4211daa6-9b8e-438c-9bc0-08dd5ba4b6b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MgJ3RVWPTkOy4E16auGCEK0Bn4kwg9E4u47xU1Tfr/bpEMVW64K1+DXT23JL?=
 =?us-ascii?Q?De6GMgH7PZhkHAuYde94cVsIfLkXQ5OxjIBkwoXX9XQ6EXXatb9Qk7fKu1vT?=
 =?us-ascii?Q?sVVRLestOW1gJdNFDiNXxVSwRlmBG4i/4qFghSpRdKVI3qutnNfezn8y//Vo?=
 =?us-ascii?Q?fX0XIMUoRiT033QkuTLcbpI3/mB6Mq9uQrmylqwu41j5K4ytF3a+EgM2Rl1L?=
 =?us-ascii?Q?cFMCq2Ut1Bmv0UNbil0L3MiJgNklJF2fsjrOb/u5819LENP57c1aS/J1aVHf?=
 =?us-ascii?Q?zxyDTAc1t4x7gZ0W1t9k/tG3EKrTfbGhsJ3nGpLq6k8pLKInj9r/NG3dgXde?=
 =?us-ascii?Q?EilNp24oIUm2RmFJ4xumiBB7Ta9fOAUjzBXwJ6T0/QsPPcAPDMcJyeZDul9I?=
 =?us-ascii?Q?blaXKiHeuF/FpnhPN5Mf2SiyXOxNFplPKdDhFKe9iOhXTDHkE6kwf4flewL/?=
 =?us-ascii?Q?UIL8iDiaH2Yn4ZDJ69VpvtVyTHKYOSUbY/4f7Ot1HfhqmzPavtVvcBHbJaLi?=
 =?us-ascii?Q?5b0Oq/WjMBsenYk8vYz+k9RJZlvrt5jmrZYbb2V4HXCGSVHoYKeHaG7MtXPS?=
 =?us-ascii?Q?YntJ7X6zyKCh+QkDfyePm1pEX6gEROsAEVKUKWYQNF1XaQNon/cGqOWAyjpt?=
 =?us-ascii?Q?mg12QwmixZIM7bjUP+oz5H3dpUkbFgUe0gFXrHDxIr+4R4ELqwXT86hJzHnx?=
 =?us-ascii?Q?SCdwJqdxznkAmyzSpVf8RZPJTrnZ77r+/onsqlmfB2Qq3lBjFEkNguHGOrwz?=
 =?us-ascii?Q?ZSPLIt8UZT73zaJwDxX7bCnY2JHON6oG8tbw/o3dRq1kRPSMq0weNKXIMjSj?=
 =?us-ascii?Q?zz0fbZ1igrushqMt/eB27kC2Rg5U27Udwsqiqs8RhwevFEyhr/iQlE7CU36M?=
 =?us-ascii?Q?lfBpvtY6otkdQgjxaqJzBgGw5t7sAUZLKHIzLmEwiE2BvO32xhCL9gACuglO?=
 =?us-ascii?Q?6DI7w5HamdJht/WUUTgd0nHGZePazwDi1piU6ksBqJolntZGvB/A+IM3DFb4?=
 =?us-ascii?Q?mQeoCYYAbanbB5pRMdJAmZFLt3Eoc7tzSQeuvzMxnN7hsNzwpvbVid/SDPQO?=
 =?us-ascii?Q?gmuh/+rHiVWFkIFZUaUQ0/9gjJ5mNNoOKHRSO+Vlyby6oiE4r7jjNpqV3nx0?=
 =?us-ascii?Q?AO99NxBJURbhVlfrRdOsd1ZdFcI95IZWRVo1F/St2tgu2DScXFFiEi94D7yG?=
 =?us-ascii?Q?1XMD97gk1yr+85gWjiDER7iTmR+9NNEf+rqkCwnAj+das0qiTISIitIo2jNK?=
 =?us-ascii?Q?mQwkbrpxAW2P7UQ01YK/TI7MWtIp5i+JNHeYr9qQEz5HkkCJtfU0QoKZLfjh?=
 =?us-ascii?Q?zsQHm+0cucPhp4c8x/ne7ochxowXTCMxpvf5kRzEfqDFL0fqYvqQbJt2YEC6?=
 =?us-ascii?Q?yKcYnqXDJRpXKDO0wtJB9yLnBC2Rw0D0i/kliKeRSohRjnA2QgHrflKIXKgf?=
 =?us-ascii?Q?IsRz/TRIgZaW671pfYEEZWkStYsMqwpWj7wg3pqIA3KIdPYTbmIpOnd0fEFg?=
 =?us-ascii?Q?3ndBHGu82ijNL2U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:15:15.4391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4211daa6-9b8e-438c-9bc0-08dd5ba4b6b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
The displays currently don't get turned off until after other IP blocks
have been suspended.  However turning off the displays first gives a
very visible response that the system is on it's way down.

[How]
Turn off displays in a prepare_suspend() callback instead when possible.
This will help for suspend and hibernate sequences.
The shutdown sequence however will not call prepare() so check whether
the state has been already saved to decide what to do.

Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 25 ++++++++++++++++---
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 60fbf2683880..01d0643238c8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3138,6 +3138,21 @@ static void hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
 	}
 }
 
+static int dm_prepare_suspend(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (amdgpu_in_reset(adev))
+		return 0;
+
+	WARN_ON(adev->dm.cached_state);
+	adev->dm.cached_state = drm_atomic_helper_suspend(adev_to_drm(adev));
+	if (IS_ERR(adev->dm.cached_state))
+		return PTR_ERR(adev->dm.cached_state);
+
+	return 0;
+}
+
 static int dm_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -3168,10 +3183,11 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 		return 0;
 	}
 
-	WARN_ON(adev->dm.cached_state);
-	adev->dm.cached_state = drm_atomic_helper_suspend(adev_to_drm(adev));
-	if (IS_ERR(adev->dm.cached_state))
-		return PTR_ERR(adev->dm.cached_state);
+	if (!adev->dm.cached_state) {
+		adev->dm.cached_state = drm_atomic_helper_suspend(adev_to_drm(adev));
+		if (IS_ERR(adev->dm.cached_state))
+			return PTR_ERR(adev->dm.cached_state);
+	}
 
 	s3_handle_hdmi_cec(adev_to_drm(adev), true);
 
@@ -3575,6 +3591,7 @@ static const struct amd_ip_funcs amdgpu_dm_funcs = {
 	.early_fini = amdgpu_dm_early_fini,
 	.hw_init = dm_hw_init,
 	.hw_fini = dm_hw_fini,
+	.prepare_suspend = dm_prepare_suspend,
 	.suspend = dm_suspend,
 	.resume = dm_resume,
 	.is_idle = dm_is_idle,
-- 
2.34.1

