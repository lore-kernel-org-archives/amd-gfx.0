Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FDFD29FEF
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 11:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B466610E02B;
	Wed, 14 Jan 2026 11:29:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r90O2NkH";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011020.outbound.protection.outlook.com
 [40.93.194.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC06010E02B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 11:29:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjfOnLbSOExfls0bLGN6Aaqck8okV7cMgywnhplff1O/OOBm3ITp8rddVJwGnYVBuXIObU3SJua6BN3+SJat6JyCp+63wD9SYLqsw7hB9RY5VDeE3Bhx/rrN6Jp58jZbqObM5572Kygx8nx3N2kb8q8vjUemVfgU3o/p3iXQiWy/HCjHhS1EipLopXQWJTcGknHAq1r90faGRF0j3oM/caXV6SeI1xDSJpnMbT9fDRWFiwANOQY0xAwiPk5/374e8avo9UCyjEBBMLgTRWZYWPso3S9uRoeaxZCTYicuzzfZsUm7+pZyskXKmWOpcEdDaixyEnuLAA5Q7Kz68iQAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyzdIuXK50z7dTvbe7BBwTDaBupxsWPqsMe8Awuh600=;
 b=XZ9CfGyCRfnHosrLOBdsG8cKFBx/0E4BW9xp7G6M93Wwhit/5HAcB0E9vu4Oqphqg/JFXVe0pR6PNpxAp2OqxT0/krb19uQVMUCvBJ7PSLlaEOlYB6301cNfxIligHXo4cMf8fK6Aeqxqf303cHOYkS74fZ4kSQwjhN3lZ+r/zc7s0603VuZ8SHbnite96rIO9AHxZMfK0xgq/iPAMySbGF8eDwXj9xn/NiViwa7ZeiURmRmIcv+zBy6D2byGiBpelk8hL9YhA8JOKh0iDjG65qQVvqa/ILkOIghtQRY/CT4n5bn44ol4NyPiMyQdWxdlzHp9IukQJvxzRoZjYBh4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyzdIuXK50z7dTvbe7BBwTDaBupxsWPqsMe8Awuh600=;
 b=r90O2NkHIZonSUs2PT2XEFhfvJuhwIQJlTw2utjg5Iv7N0yfDmKOLxSUyBew9lV+qXKWMWagr92rmsfxluwtBG+h8zAm1tZfrthT/alnYRsvL2GKBuG59jJJrx6NX8Vs0R+8RQicvi40ET3Y7ucaiR0qNT0Xcooznf2D1B6eDCo=
Received: from BN0PR04CA0165.namprd04.prod.outlook.com (2603:10b6:408:eb::20)
 by DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 11:29:34 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:eb:cafe::4a) by BN0PR04CA0165.outlook.office365.com
 (2603:10b6:408:eb::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 11:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 11:29:34 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 14 Jan 2026 05:29:32 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amdgpu/userq: Fix fence reference leak on queue
 teardown v2
Date: Wed, 14 Jan 2026 16:58:43 +0530
Message-ID: <20260114112843.122884-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: 29303b0d-c1c4-41c4-df6b-08de53603156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3hnTHl1UkRoM1p5eXNnMytrUTJ4VXcwRWZPcnZxM0NMVGFCVElIVnlnV016?=
 =?utf-8?B?QnZYMUtTVmNXM0JtT1FsajFoWGVBa2t3cXFIMHZuSUNYdTBjL0dhZmc4L28y?=
 =?utf-8?B?b0ViUDZodHpIRWNsUTZzS2hVM2d3QmVpMWtHVk5wMWxuR0JTWnNKaWlkcm9v?=
 =?utf-8?B?TEV0VVQyc3MxSDZrUnNnZ09EUUVKNGZEcGhZVVQ3V29tTEh3Sm5qWklKR2JY?=
 =?utf-8?B?cVNIbEtPcWRNM1JiWm9pQ3RFRlR1Z28rUXlKU3RKWXlyQ1dLbDIwQm9SZ2Uz?=
 =?utf-8?B?ODdsdTdpZVpqaGxSMHFRb3VxS01CYkk4QksvS2FJdGt4d2psbGhoblFJSzZX?=
 =?utf-8?B?RGg3bkVKcmg4bDJZNGhxUjI1WlhBL3ExUWtJSHdYSExMQWJJRzl3bVJLWWhD?=
 =?utf-8?B?dzdKSDVkTjVBMTFDSTFtTnowUkJlbWg0WUNDUytiNnlQZHRvc0lEeGNWa0kw?=
 =?utf-8?B?Tm1oQVFMc24xTy9NUUdKaUJrb01TWmFaVVNsSkdPdGZSOTEwUVNSc3BHcXNh?=
 =?utf-8?B?d1VsNzBmZTZHa0JMRDNxaDUxa3d6NWtvdGM3c3NQUURNNW94VTlEVExUVEJm?=
 =?utf-8?B?NEpJYkQ4eXduYWxMME9HS2dGNm5DQWJtNDVtSGRjU2JQQWlDQnFaeTJzYnkr?=
 =?utf-8?B?K3ZFbXFqUUR4b2J3eUpDdXNNcEt6cndLbk9TTzY0dGdHa2lIL1BBSjRiZXZU?=
 =?utf-8?B?WVhFWXZqWUxqZVRYMGUwZ1lSQytXRlE1UmIvWUNmdEEzUkl3S09JZGpHZTBS?=
 =?utf-8?B?OWExbUZ6aHJXQU85dFBaOUhxYUdQZUdpSjlNeUNOVnlobkFGNytlMnk4Vk9I?=
 =?utf-8?B?aDI0UXBYTFF5dGcxdk9ucVlKNWhWRERGQ1RZNXI3dVhlZnJKVFB5Mmp5Mjdu?=
 =?utf-8?B?SVl1QXFEVFE4MGFNQ0szMXhuN05xb05TY2VLQnRvMjhxUFNBZGNKdEZKU01q?=
 =?utf-8?B?dE1ZSzVzOXU2WldKamduSVRnZEE3RGVzVG00Umx4bEVkUEE3NUk3U0I3eEpw?=
 =?utf-8?B?NlBYWm10cjNzbG1KSHhpaXFxWE8zT2x1Q2ZLUmFIYzFSQnB6RmNrKzhjN3Ew?=
 =?utf-8?B?M1oyV29nWUhETzRseEx1UzQ4WFF4MWJ3ZTVJc0Qvb1NadUowMU5mWnh5U1BO?=
 =?utf-8?B?bHpURVBBZTVDOFRWLzBRZFVWK2xFN1RINGh0TkhWUWRvZXp5Rm1pa2UrQ3ZS?=
 =?utf-8?B?QUVJbE5tcTVMdktTSWJsM0VGNEtQSEcydkNROUE1LzdiNzErNnVVR2ZidWFw?=
 =?utf-8?B?N3Jmak0rRC9oaFFLUEpqbW1UY2svNzBwUzdXRW9JVURlZll1SGpDeTFVbVUy?=
 =?utf-8?B?OTFmOFRjYVpLN3JTaVJFRW44R1l2NEVnRERzbHpoUkJJTVV3WXBoa3l4VnF5?=
 =?utf-8?B?OVBwdHlzdTFjN1lma0ZJSHBCMStyZXNWcTRKSkg4WnN3Sm5SVVIrMWJpbXo4?=
 =?utf-8?B?cVczaUJoL3JCaGZZaUlMb0MyTUdlVlMzcmwvTFI0Zkl2NldVbXhFaTUxdm9h?=
 =?utf-8?B?Rlo4ZXZVVmxzZmVNNVhOdWlkU1cwcWtRZnlzSVVNVUZOT0Z0ZWNmVk5VVVYz?=
 =?utf-8?B?ZVJ0MlRFellYNWdzT1puZExRb2YwWlVjMTRNRXBrRXdZRnlZVmF5UDYzNUJr?=
 =?utf-8?B?a0l3TUJ6emt3MW5FS3RpU29DelJaZUFES0Z3bW9BbVpkY0tHNUd4UTlGYU1S?=
 =?utf-8?B?MHpkQkd5NERwVVMvMDV0a21HOEFUU2xSSnFQZHk5NVhXOEZqLzNxVnRJNmQ4?=
 =?utf-8?B?aE1rVmk0UVVvdGUwSlBzZFVIRzg0Qm5YUW1MMldpM1JsZ3FQOGdMQ1BIQkZi?=
 =?utf-8?B?M2hLKzlreFkzSng5ZWJSTFF6U0VtYW5mSXl6cGJVR2FpZ2U5cXdURU1GRGNE?=
 =?utf-8?B?dDRFcVdzVSsyUUtFZ1c1eDlCakNqSzJoQ01PR3JXLzdObFpSYloySEpXek9q?=
 =?utf-8?B?b3NGdmhVWEptZDQ1MmRDU2hjT1A3aGR0N2Z1YkRWV3NHWmxsbGFQVWFiRGMr?=
 =?utf-8?B?UGV2YlBIQk10WW8wYk9GUFoxaGp5V3dFeFR5dVpSaHBnQUcydkdaaWVkK0NG?=
 =?utf-8?B?U3EvQ3VkMVNDVUVRRnFTUTZFamJlUE5qZUluTWFHVWY3b2xUS3BHY0d5cFpZ?=
 =?utf-8?B?T29PSnNLS0tUS3VNKzEvWGZxRk9CeGl6TFhubjJkdmJVY2Q0dUFUWThDWStr?=
 =?utf-8?B?czV4NUdJZ0hlRGJpMURTUllKdHJpWU1hSnpCbVI3aWI2TjVoS2hibXZiQ0ZW?=
 =?utf-8?B?WWg4V1hvY2pRV2hXSktYTkRjbzBBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 11:29:34.2494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29303b0d-c1c4-41c4-df6b-08de53603156
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436
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

The user mode queue keeps a pointer to the most recent fence in
userq->last_fence. This pointer holds an extra dma_fence reference.

When the queue is destroyed, we free the fence driver and its xarray,
but we forgot to drop the last_fence reference.

Because of the missing dma_fence_put(), the last fence object can stay
alive when the driver unloads. This leaves an allocated object in the
amdgpu_userq_fence slab cache and triggers

This is visible during driver unload as:

  BUG amdgpu_userq_fence: Objects remaining on __kmem_cache_shutdown()
  kmem_cache_destroy amdgpu_userq_fence: Slab cache still has objects
  Call Trace:
    kmem_cache_destroy
    amdgpu_userq_fence_slab_fini
    amdgpu_exit
    __do_sys_delete_module

Fix this by putting userq->last_fence and clearing the pointer during
amdgpu_userq_fence_driver_free().

This makes sure the fence reference is released and the slab cache is
empty when the module exits.

v2: Update to only release userq->last_fence with dma_fence_put()
    (Christian)

Fixes: edc762a51c71 ("drm/amdgpu/userq: move some code around")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3c6bd5531627..8d7420a9a113 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -141,6 +141,8 @@ static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
 void
 amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
 {
+	dma_fence_put(userq->last_fence);
+
 	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
 	xa_destroy(&userq->fence_drv_xa);
 	/* Drop the fence_drv reference held by user queue */
-- 
2.34.1

