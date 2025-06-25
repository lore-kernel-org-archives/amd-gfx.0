Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1D5C7EE2A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0FAB10E260;
	Wed, 25 Jun 2025 21:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wvV+j3+h";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CD1510E7ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjxQFu0EOElPlGXqeTNvIZZg9WowdSDfHqMsALBWrjv92wAjpipq2NVw9qTM1zDkM9rOKuYbpqJk7NGKE6w54s/IPsLFrI2c1Wgqhdt72ghOyutCac+jpyCS0iWl7gTHtMxBmQeuE4PCCuF1VY2hMus7rfC/bJbqtFq3wvyhyY7svHLdjb4TSzK1L49xuY6ZRj5989WgkSjlEG3vmIU/3dEDg8pmRBHuq8DnPH84RrmBu5y2+rY6Jhj861X2LBJsx4uBR+r/4gXdTErUpppj/uI2njEfB6R/fyfTbSr2q27kJeBsfbq7pjpCfai0JM3+Zqa9r2QRXY1+M/ChvTgUVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfNeoHSh0PIJDYAwtOXZYf7u0R8IIOPFJ9fm2hsXSjI=;
 b=r8eptXcmYNdadsuNOhcKzrFd1oHh8u3eG7gZ600eovATLHyA5IOjax+b/yfh82IL+xeV04YZQ19W9maOoacfiFq2ve+Q7foP/SsycWtbbQVdaiWGj9PZ0vvwoXdxJRrVNZ0C3uE/Fy8XIJusw+E1lOc62CbxtJdHSf5Um50JkuF3KsAmAe47q/opV7a0kMj2HVRalc+zs87u1vFNQLFaaM55l/5PV/UfUECJYxUZJqaHPiMvN0Yj4VNqZwz94Y19au5BfbWwFPFb0h4LmifeRRDylNW0LwnB2xeNM5h7r0trq2G3Ub6CitD2sPtOPzZzojNM2cppxOQqNqjflJwJJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfNeoHSh0PIJDYAwtOXZYf7u0R8IIOPFJ9fm2hsXSjI=;
 b=wvV+j3+hq+qB1A0+geIMgKlkbOyu8UIBLhp49NPDj85rI1+ZccosNQjarmEx0sI2FWHioLeuFNjpWHXcdWSQ/dLESHps7O1G1iVOpUJu9bryvm6NY2WtpIs20SbZOzF+U6MjpJXLZnwpeuQW/ZiZgYykxj6ApswD+0ZPuPa7Q/U=
Received: from SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::24)
 by SA3PR12MB8809.namprd12.prod.outlook.com (2603:10b6:806:31f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 21:07:02 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::76) by SJ0P220CA0012.outlook.office365.com
 (2603:10b6:a03:41b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:06:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/30] drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq
 reset
Date: Wed, 25 Jun 2025 17:06:17 -0400
Message-ID: <20250625210638.422479-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SA3PR12MB8809:EE_
X-MS-Office365-Filtering-Correlation-Id: 33bc4d8c-1247-423e-bc66-08ddb42c3a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?95JZy0YETVCpMns+gDGtyRUJhdrgjT4FNNEGVwFsw7XPjsBqZBtXxAABF9jC?=
 =?us-ascii?Q?qvRB+MgVsgObT7ugU7/udbqPo7KkLl7OUQLQTZBdBsuQoJBHQJr9ETiq9Sub?=
 =?us-ascii?Q?X7mqPMsvzspD6Brb0gD7M9m6MXosANOykefHXK6FnFUx5etBbXgWwxTzR970?=
 =?us-ascii?Q?YnGn6XKHELdkChMH7DR8z0u+iFWb3fUn4fb5zsABBQXGq38H/vnggHImOG5I?=
 =?us-ascii?Q?meSviTlOdQbNJ8m2criT7CKtn6EVdxZ8Cz+iFX8xUCIaZbjeeLrCqKdzophd?=
 =?us-ascii?Q?2CpLpmH0feZaTgx+L1HX72KSBy3sI2B2lIS2pC9PiTdQSJbLyIjxecbLyvtF?=
 =?us-ascii?Q?VgvywqwXs7fn+d5hmsd91of2n4VMs7PQLXFa4o3XheaR+ZnqxAqoOFT3sadF?=
 =?us-ascii?Q?Z+e6IG31/48cUgKP6PA3Vxnc9FTl3z8al71ztlmT43qHKYG1uhhrzFWhmock?=
 =?us-ascii?Q?Yw34WR5ogxaRuiX9qZzvq28ADXgRk9I4aMgaUGZjt6WUM3JRZfnG3WWfJqzY?=
 =?us-ascii?Q?AFzNzkMaYmpnpyqNCVbVY/PbmfbpTl1f+ESuKeHs7mewtbcBDyXTzGT/IHHU?=
 =?us-ascii?Q?rXk0rb5ReNAoFnwYLw1ZzsU3vT/HJ9bXm8pdeDsiBboX7MSFb41Q/wVxcz9Z?=
 =?us-ascii?Q?GUOGozjHdBEdGYoRInsb+toCdYxo4rQJOnbZU8vj52f1xWyOy0LQSB4o63mG?=
 =?us-ascii?Q?FF21kBQ0sagjnsNSdv3Wkj8nEyaZi4C41SD/QE97cJkFiu0fDglDgp64iDfN?=
 =?us-ascii?Q?LMHUfR355yV/8P3DFLaXc28shAu3vm+ximRV3cbQOZF0Co8c/UdaqcRbfypy?=
 =?us-ascii?Q?iX3Y84DQWKACHNUl/On/GtLAsR+JRMoRcQRV49t+umFbID5r+R4mDZmhSW+4?=
 =?us-ascii?Q?Mm7VRhCnYxC/pgsnCnIrCnJWzPl7TjR6FfmyL7EJaAjqvBnD7BGnU95FP127?=
 =?us-ascii?Q?9+PTnb2D+PLG5zAHbrwwn5DbtJOHC42xNgfEXCbdT0x/75uuwF7q1KNv00Rd?=
 =?us-ascii?Q?CuQr+m/aMS5mUpU6jOVwZ0gTozMOZKKjv2tS83UPqjEdI8uT6OLK9w8VPp8m?=
 =?us-ascii?Q?HxxHo7YvDE78nCbKHm5cgHEbyHt35qqsvZ97qrL48O8REeHZpem6Davzg+0A?=
 =?us-ascii?Q?Lr986e85G6yEpD20XYTGGk+nJmt3E4C7XiwaetL9oyYdofRstXcGIKtF6geE?=
 =?us-ascii?Q?vyN61q9fdcr4kIvjFHjhcs/yyTnZ5Fj72JKe7VvJsKeW32LPh8UdB5aggUVd?=
 =?us-ascii?Q?Qo6LnypZ3vBdx82jCNIXAqLpJKHlRidI+jvSwfRZJPT7heo+xtdFrgBBvjj6?=
 =?us-ascii?Q?py0FiW6BerAwXds1ehj1IBZWZqJva2eU2vWuA3OIgkdZWHtXZIJjMEtAbEz4?=
 =?us-ascii?Q?vLZyGa130ZVPVL6Pd/cZakrmiGv4ehovukxNpWHJ6N1EAqxP9znA57G8TVhh?=
 =?us-ascii?Q?QoMIvNqBKH/QFNwI85z69zRvXfQpmKIPzaqy5g0cNoi4xNGlmWUW+A41CyZr?=
 =?us-ascii?Q?kC8CKs+21HyCZsU0hIO0TwP27IleRfR1FLDP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:00.8484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bc4d8c-1247-423e-bc66-08ddb42c3a84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8809
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index daed0f187bda5..21bdf9746db7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3567,7 +3567,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -3615,20 +3615,14 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		dev_err(adev->dev, "fail to remap queue\n");
 		return r;
 	}
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 enum amdgpu_gfx_cp_ras_mem_id {
-- 
2.50.0

