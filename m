Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A20EC0219B
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 09:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1023F10E450;
	Tue, 11 Feb 2025 09:02:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kt4wkaW+";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AAC110E450
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 09:02:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoREOW9rDxkhtcg7YsiDWU5XeFXrBUFy5nOYcQz695XzMbNXjnH1rLdW69VGMLGVoBPl0hNQmHwBqMMDdkWJZ4lz851PyWYSv0dCRb/91Mr4TVWVJ+Ekc3/BA/6WUwRxAP+XBSAWLSiB7+lPgipTDqekwGc4kA2LhwQ1n/EhWYIU4DRSxeveAlbriIrlTC0l6o75S+98PCYmE81QLu7LdJ4af+ZP9WTkQzQ2gnxIOX8+cx+Ko8yh/FoZtAcK4ruHqosa3opucNN9L1Gxy6TmIdLmRWmceWncdSldAg7Da4PICuqn/VFcHhHyq4QehokWxMk/6sOJmVCgi4Br4DtbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Af7vByz1s91vFcaJhg15BPIz4XE47+k+4wmzmPDL4Is=;
 b=q8mwL6wSQydGey0zYvhPuW/DXtMoPKPNadHReoRwVpALjoolIrQdTjynGyYtRrwI0pdzQWOyjLhY/N4zx3KQ4fWbSgTtNK/rsoTP0ihZVkf/hOtYQFf8J7CJ6kRxs1e/M4zmcXxo4Fi0Ez6pA2rBwfZsRpnWCTYPMUEhR32lzRLuEaEKNfb4M8fIeFwBkFSyNWezDowPQpW68UDYC9+aviKAWkZNtsuzQPI9CQz3cso6iGSmXQKvjpbM/oyb66wf9d1pBfz3wA3uB8fV1Nd9uWTtcyGHmA/VIJjITIqpP9gy2N7Im1xW9ILC90pjDmLAkc7v056cuz2YOGV6hnZq0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Af7vByz1s91vFcaJhg15BPIz4XE47+k+4wmzmPDL4Is=;
 b=kt4wkaW+CZARR4Vn1hXusUwCjbiuuoXfoPQAxDnSEYZq7il8WxalHYmzTvO9nlUzL4sp/qQC++Jgt49AZtT0OiiMB5kgqYbJ75VnepPrPNflyQkDrzCwZ1/8vo8SCGaN2h9aeu1rHL1vrJrYr6fTUA1O5Ufj6X5Nn4BTJENtfr0=
Received: from SN4PR0501CA0061.namprd05.prod.outlook.com
 (2603:10b6:803:41::38) by CY8PR12MB8196.namprd12.prod.outlook.com
 (2603:10b6:930:78::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 09:02:13 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:803:41:cafe::6e) by SN4PR0501CA0061.outlook.office365.com
 (2603:10b6:803:41::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.11 via Frontend Transport; Tue,
 11 Feb 2025 09:02:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 09:02:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:02:11 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:02:10 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 11 Feb 2025 03:02:09 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Add support for page queue scheduling
Date: Tue, 11 Feb 2025 17:02:03 +0800
Message-ID: <20250211090203.2866457-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|CY8PR12MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 0525ac0f-41ee-4b57-ee7b-08dd4a7ac5fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SqJNbp72/dJZM2i6mTnq1NqNNQnBMtspVt+2Miuo6NBHOX2bjPiDnkhdT05V?=
 =?us-ascii?Q?yKLgff2pa49TX08pQQqabbzKvaR6UXGmT4uJqTMlOcG17UIF6pzm7fja30GB?=
 =?us-ascii?Q?l6CL9D7vFfrXY/IcD+yI/v4HLoQEZXgJQ7h9zIRJyV9NSvxXEZwNjhiIZ4hc?=
 =?us-ascii?Q?Lyy5oxfO0Bh/lI0+jcn4ArqLuNgPg6QLepgxJsEnJReZUYAS0nBHqTjQqemp?=
 =?us-ascii?Q?nvUKIyh9jUIej2AUss9SwT9lltJRA799+gTMzmUU8hHGKF9fv3+f0N9pT4O+?=
 =?us-ascii?Q?0OJMdjXZ1QBvJfayphsc0mHTPmlOW0Fg7Z5LR+rq8IfYlEPXixdT1PtUhyRm?=
 =?us-ascii?Q?9iYPvpIcEPvncJWUY6Zhyro7dFCVuvO8ICPGo6jBpO8hpu5tio4bK9Z2uhhF?=
 =?us-ascii?Q?smEIdoMwkP4viNjVTFxMEsszCq+sZZiNs9+4KMMS0gK0IHQu5aakXW1Fb940?=
 =?us-ascii?Q?ylVi3ooLHBJHaSNzgr1ybo17kOC4yvph5sUeqhUP9XEVgef9nNedExYjBBrP?=
 =?us-ascii?Q?DHexA2DYrMzsEmjsRA1Ye4LaN1L5au5WhcBVZl40Pb3irSuE7upxtl8mHbL6?=
 =?us-ascii?Q?C08yQ5Tl5Zfzkf5xiXVjviJMjlWab6WkpvVcopvQ9uhvYFa7KGcOM7GYO546?=
 =?us-ascii?Q?PYF6dywMvD2RLhE+M72vkHfX9ICwZX0InYVgiZyDeNcd3RBjX+SmeHYadtmJ?=
 =?us-ascii?Q?1VmIoO6cn2ze0yXbjJZ5r9xfDvzTPCvYUPb/sAKdJSxTU+mrWshO51BMkOJS?=
 =?us-ascii?Q?Ka0B9CusCGPFwgEu6YQhLrWgk8cEAwa5Wtpfts2Jli1oHWD+z7jck7rKGU+Z?=
 =?us-ascii?Q?IdLDnsHpv1kCIFwoU93roWo94nP8EiHwnTYf6kPtLT5xx9zuTsWZQbZV53DX?=
 =?us-ascii?Q?7clk/UMVJBv0HJ7zdWTAq5fYhPMRfO6ljHqbhYGckhFF8Q0MgQ1evw2eLk7X?=
 =?us-ascii?Q?Y5HeETd7TKm1V0CfBFj9xyvdy0IWPk7gY3CYoCut67lC1oBy5QrTf8XrsP/6?=
 =?us-ascii?Q?GF4oQSloXfTjBKll/NOlaAuXQyei3dlbvuRNY0nOoCUUQyn1wzZGPliJZIBj?=
 =?us-ascii?Q?NFbTDDZiZ4UdIUIS7NvzF3sqNj2mRk01wm58lusByQqfa/ZSfMgsY/jbsJny?=
 =?us-ascii?Q?eU0nGZUxuKFtIseoUjqOFR5Oy7hj/U29Z4xP7smZMqmnTKhBWAULRLUlUpqO?=
 =?us-ascii?Q?Hsvw6HpB+/EjfvNVRW4UlizSM5xFUyIfqq4ww+e55SRevx5TpaVNY6CcsRHN?=
 =?us-ascii?Q?dVMCUgHh5wc6CpoWpESSWli3LLKIDSdgIp31bL4fUtje89v6o6r5rqMx1b4N?=
 =?us-ascii?Q?GFXYWBFLiTBE7/pDJcG2qkSI23oH05PjB6acPOCovc2CqhJaHLl3/E43b0Ij?=
 =?us-ascii?Q?4b7SncKAct3JZUWeLi2mfxj/7jBDMViGusLWVjJjwvUA3nNACrUBPhzTeazG?=
 =?us-ascii?Q?QgCA58Z3OaYE1ITy/HIa7J3a9i9D9uD3OmnOZCwilJYFnw4Iq5stHtj2QkLP?=
 =?us-ascii?Q?fXFLrzN9Y8cNtKI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:02:12.3563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0525ac0f-41ee-4b57-ee7b-08dd4a7ac5fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196
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

This patch updates the sdma engine to support scheduling for
the page queue. The main changes include:

- Introduce a new variable `page` to handle the page queue if it exists.
- Update the scheduling logic to conditionally set the `sched.ready` flag for
  both the sdma gfx queue and the page queue based on the provided mask.
- Ensure that the scheduling flags are updated correctly for both queues when
  the mask is applied.

The patch ensures that the SDMA engine can handle scheduling for both the sdma gfx
queue and the page queue,

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 6ba785798a4a..e82ded95540c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -358,7 +358,7 @@ static int amdgpu_debugfs_sdma_sched_mask_set(void *data, u64 val)
 	struct amdgpu_device *adev = (struct amdgpu_device *)data;
 	u32 i;
 	u64 mask = 0;
-	struct amdgpu_ring *ring;
+	struct amdgpu_ring *ring, *page;
 
 	if (!adev)
 		return -ENODEV;
@@ -369,10 +369,18 @@ static int amdgpu_debugfs_sdma_sched_mask_set(void *data, u64 val)
 
 	for (i = 0; i < adev->sdma.num_instances; ++i) {
 		ring = &adev->sdma.instance[i].ring;
-		if (val & BIT_ULL(i))
+		if (adev->sdma.has_page_queue)
+			page = &adev->sdma.instance[i].page;
+		if (val & BIT_ULL(i)) {
 			ring->sched.ready = true;
-		else
+			if (adev->sdma.has_page_queue)
+				page->sched.ready = true;
+		} else {
 			ring->sched.ready = false;
+			if (adev->sdma.has_page_queue)
+				page->sched.ready = false;
+		}
+
 	}
 	/* publish sched.ready flag update effective immediately across smp */
 	smp_rmb();
-- 
2.25.1

