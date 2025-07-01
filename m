Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341C6C8303F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C20C110E2DB;
	Tue,  1 Jul 2025 18:45:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="puh8bDIM";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D39310E2ED
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofpK+0v22Fbgo1KTHMTOPXpaDvVgrObjlUhXQY8UTGZzc040oTSck85bbuY8FA2c4YiGFpg2mgCqOFB8tI0CTYXjbgoC2W1FCUxfQgqBidfQBNTwQyuSDGmjgjt7gpdOR2ty39u7RGbXivuxCiNdH7xBF5D9MRBbSDP12dA63NDYywfAi4M21xlE47dTlNQjpJ/OGGTZXt+nqm5axdz4g0FfUbHgZ/DgFiU8S/+CRJhFqqPOeWJkkLpwUqCD7FYyYzgtdFS8Bw/Tx9LI6WcUQPuGHAQAPng6MEG0A7bqK75/BGfSn1/3Vzmp0oEyytDZdrEiWhzm8V4KvumBKVRcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfNeoHSh0PIJDYAwtOXZYf7u0R8IIOPFJ9fm2hsXSjI=;
 b=YwVTCeeaI3yORe9PPhuboitGxI9cARVaP27P6CDahLti3N5/dgUrIgtRJfzU+lWh5qYnaiHi7wCgL1beDKgO/DLNZF25isJNOmEteiCRGJfIXN0rkmtDWDzQUAKxSED0Q9lBlB7q1LaDXfMBvibXfouo1ckKUu0TcEH0n3S5A+dNRqX7ri3Eu0DdVSVohqOXCggmP+Ke43VVZcQdiuSj2Ri2YZ6m96qyOwoy453256Y7xDOKQIbY3ph1OsDtKQnIeXe7ysqJaiT+h2gNIfjGhDqpD7zoPRI1SbWYnEcec9EHrLvQ2XYdjS3W+vTpUJioeWeWr1gLubVyd7UCmhhKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfNeoHSh0PIJDYAwtOXZYf7u0R8IIOPFJ9fm2hsXSjI=;
 b=puh8bDIMGuilg9vAiiaGEt36G2GPuljWeeiFhrGliT5DnoCZeUw3BZD74C6IZMArxvOzEqfJsT0M9id8Gyj0GrhHF1UURgUeYqnn0ODhgNOrX+qxZrc0hfRGx3R0Rqy5da629rNKiTJaJ4Izeh+y9lnP22zA4u7+lvh4rnYKML4=
Received: from SJ0PR03CA0128.namprd03.prod.outlook.com (2603:10b6:a03:33c::13)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 18:45:10 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::35) by SJ0PR03CA0128.outlook.office365.com
 (2603:10b6:a03:33c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 18:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/28] drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq
 reset
Date: Tue, 1 Jul 2025 14:44:28 -0400
Message-ID: <20250701184451.11868-6-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8c294b-6107-4688-4229-08ddb8cf686e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xKkUfDTSSTpPHCTMTFKSd+C7cQXxdc5N8y5NiPLHg31c9/l/8+ESXL4vwfjT?=
 =?us-ascii?Q?/ik55maOX9/IF2oRW9fOBfc3BUNXfPPW48p22RdleoOvSHtCxRtajnatY7Sw?=
 =?us-ascii?Q?lUcd2rSGL85rNPNs75sx/iwF0bBthdID3cFYycACtzThOSeR01JkiIEtInN+?=
 =?us-ascii?Q?CxcUADAWt+iZ/itNCI9/kKc2GTpEUb6NQ+IoPfXZyIzQNV/PoZbYUzlvgdrB?=
 =?us-ascii?Q?j4E2XjMMeqcJeyJyETVYrjd1vIZnh/WRaEidMhjHSqiUelEUUwz+u3lSX5p/?=
 =?us-ascii?Q?TrwUU0k7/sjT5raS/bUkFXIh/ITFK8iqaNeE+li4bHUUliKDWGHJm19gwLyO?=
 =?us-ascii?Q?TSK0lsWt+b3ywX2JKz0w0Q32qIQmwkV58VyMA1MDwXeCvm+3nBEtTUyc5HbI?=
 =?us-ascii?Q?JOJacGqxw6bX3yBIdEoYcAkoTPFdf2rYcBr1Bet5y/xV1u+G/4CL30NucOYr?=
 =?us-ascii?Q?246e1mA6OYnO2Yjm02ealU07wVtjERqW2tqw+7hnHeOCLzi63RHQjyp6zZ+T?=
 =?us-ascii?Q?uTmfL3/dNk+1i7j531ywBHEJhUMgUHitLuM/+gNgGQ84o7oqKLGAJrK038R8?=
 =?us-ascii?Q?C4xynFz+8ewnCzXxt8PDeaqxSHrFd+Dxov2BXpFRnaE+ny9MKIZZ4i8Wduej?=
 =?us-ascii?Q?1i/Zeq3e+Vnlb90aEcMknZda8OprwTfppD7FW382HWD4FQB+5lxRGAapv6k8?=
 =?us-ascii?Q?ELN14Tzwld3/asCgfVczWvAYsfDpRfMR8R2rtiEsPSL1u0N+FpTgXGty7uP6?=
 =?us-ascii?Q?Su3fSpbO7d7GOwksqBn2UBwp32D5HguZyMVIGOJbaUKa4/5tvQI8zBZvJspm?=
 =?us-ascii?Q?k2aoogvjXvgFdlPPkC9vEvI7i5s8TkbK8Nb7ZqxGQ/eaaHGThjDHul/ZDSIF?=
 =?us-ascii?Q?J7L2saG+LXapBx6pmlK6NPW0oqyLjNoiyau3eUQ4WVIeZS07eClG6e2NgtSR?=
 =?us-ascii?Q?hiqDOwZ4WkWjgQ8YMQ+URLbnOfThKXhdZGuXM7QwZ0xna3lKii2eeuwAVWR2?=
 =?us-ascii?Q?arELWvRF3YitDvLmtTCXOayEcqWJcw5mszqWzWw44NmZeTsukqyzGCkNPxpm?=
 =?us-ascii?Q?/VLSRruHWsIyP9YIakyFsrRPgPMG/qixhwbZKN73QKgryn4KofIUFfRhAngl?=
 =?us-ascii?Q?a+x27Bp/eabvNMKsKIlOP2YIUzPEMNZuZyq4NnzhgOKXnOsgExS/ux/RyajL?=
 =?us-ascii?Q?PBgNjyZwpqTc09odGhm9nTbP8QOmknpHmAjajQs1U2daKKsJwOaUoKVSuI6X?=
 =?us-ascii?Q?zf2XY3pNMISfevaafAlB0QD8QToXnHBvAOec7SWIM7CbHS8hWXhAgoNGh4iO?=
 =?us-ascii?Q?V+WVhi1q3zJNDBp3P2Fqa7Nhen6GUtbuYx8omPEauWeB5EjmD1sQ07u45JuG?=
 =?us-ascii?Q?qtmgjqd08hF/VgSIhUG3ZDFPA8sB1hNGxwk7pk0Eo8V0xTJOzyqCCa+kO4s/?=
 =?us-ascii?Q?2e+F2HcgHwRw4JrkMD6wHYRcxinyYpgVjzSkq0TJbUgYnPnfQhTyhczjrISe?=
 =?us-ascii?Q?IrkOhqmV91FzHT6Lv0W+OWOybfKgVkb9lpml?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:10.4929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8c294b-6107-4688-4229-08ddb8cf686e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458
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

