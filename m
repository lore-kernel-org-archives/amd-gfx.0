Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8046EC7EE2A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 08:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2440010E530;
	Tue, 24 Jun 2025 08:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xlaoJdfP";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E5810E527
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 08:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVgSZXkHrETl3+aJ7my0taLKo+lMt0X34WOeEhcsVrr8psTYc5UpCsu7pWqncPxdTL8WCkWO7QgzwyPkOBYxsQvPQWRopDTFmWL8eNLvfwk/MkLKkvD5WKbU1pWixc+P447n9/OiRwSHGs+EUqw5Y+Xwy9td+0bG7OwwLLvSAuBM+uUEO9wIDCtzkLaDQV29o+nfXHlypF2u9bZQYeLh6q0qR1JBMlF50XiO9js3eSJZB/mQQGU4Z/Q6BSO7MTaTAXG8/G7NmnYvXDa4OQ7Gf6QXXxJEBWIVsnXNYRY/mcLYUeTK1yalTP4L32jtqe5b9zoFFgYAMA5yKfxeddK7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yxoaCzYAl6ecKNzfxJMcuuEdeGLOmnpgenaJBx03OE=;
 b=j0VAx0JqfTgV0cu+r4SOsm2Hl6EABuxsbpUS+EVBnDXBmHhjMgBK4uEy6WI5ybSMUHNmQ9Z23aW6MPkagatCbFFr66ogmYwjtKVpC186viYEOpJpN/oQeakKNkUQAVlCQZMgxKjpptvz/3tvTIS+huJdpyZBzrZQ33gR+QEZ4kVAxCDqWLcXPOhYsGjKYLxeyPQYcc9VMV2pxxvXyLN6/grBZZ4+bqLeLhnQWjNuK/tcDSYQsJ9NyWG1oMhaB4RayPwSATXgSjV6S4WVTzjUnQJRujuWfsVoUtNtPkyfbUBtejwxFLRv2rbiuW+AU8OYt6sPDiZuQTKmOxu74F+q+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yxoaCzYAl6ecKNzfxJMcuuEdeGLOmnpgenaJBx03OE=;
 b=xlaoJdfP8ZUoXVOHZB/B4Ud3tw9a0pfxqCqIviJeIzU23v5EiKGt5P0mvblofWfYZZeC2jtAwtfH7TJeCr8GjVe4IrxhBiP2AwMPhCgLidljUenGm997IaPDlD+uX0HZZ+z0vC0LT/KrkvHK9LAN89Uk9Ym+PVIzPyJ3g4oO1jc=
Received: from BYAPR11CA0069.namprd11.prod.outlook.com (2603:10b6:a03:80::46)
 by MW6PR12MB8867.namprd12.prod.outlook.com (2603:10b6:303:249::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 08:46:04 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::8e) by BYAPR11CA0069.outlook.office365.com
 (2603:10b6:a03:80::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 08:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 08:46:04 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 03:46:01 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v4 11/11] drm/amdgpu: clean up the amdgpu_userq_active()
Date: Tue, 24 Jun 2025 16:45:35 +0800
Message-ID: <20250624084535.1178476-11-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624084535.1178476-1-Prike.Liang@amd.com>
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|MW6PR12MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a30c7a-10cd-4538-aa61-08ddb2fb8df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yY0F+g70DIegMglGhhgd73CC17IEqCwO/JozRGUaNbFiH1AwZboEK734yk+K?=
 =?us-ascii?Q?WCG1tRRo7BYP64R1XYCzhgjj5g0RFr+CPJFnjoWFy+oW8EB5t+pv6RKQjmbw?=
 =?us-ascii?Q?7+Uy7MsDUAMLvLWRrZhgfZx4CLcE+h+gkpYnZ/apXf8u1nwuH4ASBexpssB4?=
 =?us-ascii?Q?TOL/N3VC7KLQ033EeH81PGPXUYviqNMGYqGHF2pligYq5zdo8gIRTg5LfP6B?=
 =?us-ascii?Q?oT4bCkpeFD+HJ9x/6KQCge9K/6o4P82EA9SHZ797sDrxgmw/LwIQ9R+7I9gU?=
 =?us-ascii?Q?0ATjnnyB1SuxupFmspp1IFC8OQ7teHW5GOEJDR7l+09qjpdYqZp3EPQHXNLL?=
 =?us-ascii?Q?kn+psMh+TrPL6sAcJDt0l7SiOLB/BfGbFm3aAh0h7Po2EA9efmjCWZputHdl?=
 =?us-ascii?Q?PPl5l0lcwa/VwlxrqmopJ89r+fnf1fc5Q64XsY5eYBp4NgVYZtroq0kB770C?=
 =?us-ascii?Q?BV4kpFf27l/3CYK2EszL/MQHz9hztrQAqf4kSPdy19uOrCkKUdnGWkldNjVA?=
 =?us-ascii?Q?Q+NmuWbXEiOa5OiYi2N/4TZqD9JW8W4i/0sdnYRIUQIH5yII6oZMN01zCCY+?=
 =?us-ascii?Q?InqvAScJdoPOxmpdYKlMQaXhCOQonPuLwGjAgOqeeJrBlBmzPkvWI16zqu65?=
 =?us-ascii?Q?CPEDqe/RYiit88NfPxUEimT/9Utf1qp+wb78aR9h7eRAXXvQF9Gc/1P1grod?=
 =?us-ascii?Q?UzWgvZGK3vrvg9a3R0fncx9ovKez81rC5iT7n4ED5hl7rpbKMZ8bKLWJEthz?=
 =?us-ascii?Q?r/zMAcu1B5vKZL9gzBjeimn04ttAgPql6LGbolDtGIrjsI/Qaljz3ygg4pln?=
 =?us-ascii?Q?WRwgHjmlH6jhwdzPzNkwW0TMuF4KbP4yddn94/8695b2oYK8VBnLuqNmEKbb?=
 =?us-ascii?Q?kY/xegUjU59cq9dFcLxO2h48cqT+eMFQIzhLIyV/QJT+776ftQ6R38ftfcv0?=
 =?us-ascii?Q?/joj+0lqK94g5yPaR+y9OIJcjCupGGz7Wf1MSqUAiDvHFIXGvan3758Pm+Rj?=
 =?us-ascii?Q?mFm+7Gy8PrFQ6ubELaHaS5dQuKLvfb8JILdYwMKFnEvP3mmVhKmII50JK+Ux?=
 =?us-ascii?Q?OPf/EAWccnXft4QQlbOvnH7Wm9Gyyz566OI//vU834uZUWd7spapsDJSdAp1?=
 =?us-ascii?Q?X/PmWpkLhIdza6PmKJ1ZegRHxgmuNR/18mIK6hjAt1iQDzwKZFyyiSoz7/jD?=
 =?us-ascii?Q?VGiBbK1Ma0X8Celd0fdBJep3jMoDQqfVwXrv0zpnonoUZ8pvl9ntt7VNk7jz?=
 =?us-ascii?Q?snXQfimWus2H4fbk1Zd4IOYVCP7I45aWRCy+cJoeDcuIE238dXFMwHRpTBUm?=
 =?us-ascii?Q?3xfzHiZ09wPMoQMFV+3gtz5zxH3mU5ZkfQoKGz/BdakNufd/G5iL5IP7y2Sp?=
 =?us-ascii?Q?y5vcWPywaU2dvgHIL506oynOcSf4mdX5kdHS17XVUjYwr2n16DQdXdab5ncD?=
 =?us-ascii?Q?jZgFWE8G0PiuVzEya3B5rbyinIw/r9U1wAFns33qnL4B3ClTdmGGfF2pBunH?=
 =?us-ascii?Q?qCgyz1itpIJB0n5MJPBTkGfitLUNvVQsExTb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 08:46:04.3495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a30c7a-10cd-4538-aa61-08ddb2fb8df0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8867
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

This is no invocation for amdgpu_userq_active().

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 --
 2 files changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 5243512c9cec..d5d95864d0d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -276,22 +276,6 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	kfree(queue);
 }
 
-int
-amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr)
-{
-	struct amdgpu_usermode_queue *queue;
-	int queue_id;
-	int ret = 0;
-
-	mutex_lock(&uq_mgr->userq_mutex);
-	/* Resume all the queues for this process */
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id)
-		ret += queue->state == AMDGPU_USERQ_STATE_MAPPED;
-
-	mutex_unlock(&uq_mgr->userq_mutex);
-	return ret;
-}
-
 static struct amdgpu_usermode_queue *
 amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 08c49d738ec1..687583688c6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -121,8 +121,6 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 			struct amdgpu_eviction_fence *ev_fence);
 
-int amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr);
-
 void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
 				  struct amdgpu_eviction_fence_mgr *evf_mgr);
 
-- 
2.34.1

