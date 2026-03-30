Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C498D1061B20
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 19:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68EF110E7B1;
	Mon, 30 Mar 2026 19:58:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lKoCnWAt";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D58BA10E7B1
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 19:58:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/NrnmC12EKSmYtiUfL1vnD0gagUzV5yyg7GQILRkJT3YUPxm6xUjVrIfccBTW7ZgbuZBY0GJnPDvRWEOvxnQreGQWwfEZMITj5r3Rq++AMg/XvbcwWPSUP2j5G5FejdkAaYBWkdHF4ghbLg+lXZjrpklXvp7UjxlyIin6hrXqznV6HwbGRZqjBrrc9m7xAYLAT5k6rXmoHQdyYGwLH037mzHRu9hVa4ehak2PGYsujWCOjetiFiTbMiDXvKRKxRW5WYFS4dEG5XZtE/gvkgqK4aW3H67E8rJcxHdoQ3D7MwSzOukleDs9y/zI7miJBMUtzdyD/vA9wyYSgx3Z2UgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlDYE1sGNwjOIk5VdVQqedEvKWhc/Z659u/aJHvVufc=;
 b=UhvwXH2QGcveHSinntOJFXSpyD/jsRPKzASl4b3zI07CQDRxv9NTjnf47ZIW7tN8DmHaoANxxt8vz1gaUJUipfshkQdVVxytAWsPiGhwmWEVwfKF73QluXr0J4sWAKEa2//jvDF6jt1CC4EhMI1W5wI47J8p9udToCTQZbvEVqZDitg1iGjjJz2nUouD1ia3NjFRgAErHacFsD1E1niHmQekaOU3rfqDDE7lqqHMboFuz4YM7gvwhq/vp51ROZMFi3zG+8VPjDmDUx1PQ5oBHXtTa5Bp+orqmvhi3pNHqn13KXA2ep+ib4pn/t1ku4Np1El5unSEHa9X6T8WQwfh4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlDYE1sGNwjOIk5VdVQqedEvKWhc/Z659u/aJHvVufc=;
 b=lKoCnWAtX/ciDgxsuff3qGyJkB95crI6mXdJcmOTJLwb7QdhybQ41hrYi793ZI1BN/ZYq6tUwQ3+yG4M3oh4X9eirrbWR2C8aEpCAB2mMB72Tj+ARDuJ0EIquQ7xYIdKY1VtC6mOOMTi++/y4Bsu+MCJjqtultDDEwMxGFc8qJo=
Received: from DS7PR06CA0012.namprd06.prod.outlook.com (2603:10b6:8:2a::22) by
 SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Mon, 30 Mar 2026 19:58:46 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::f5) by DS7PR06CA0012.outlook.office365.com
 (2603:10b6:8:2a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 19:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 19:58:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 30 Mar
 2026 14:58:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Mar
 2026 14:58:34 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 14:58:33 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (Ming
 Qiang) Wu" <David.Wu3@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "Benjamin
 Cheng" <benjamin.cheng@amd.com>
Subject: [PATCH v4 1/5] drm/amdgpu: Add bounds checking to ib_{get,set}_value
Date: Mon, 30 Mar 2026 15:57:53 -0400
Message-ID: <20260330195757.901509-1-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: benjamin.cheng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: dc986171-d6f1-45a2-3551-08de8e96bffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7bXmgyJ1U57DYkI/tYnvgWSwi4eCFvSmNLNTzxi8CmOABpaxPrTIv0ZXyNF/FVjsJVycccRxg9YKj7dm9vbdpPWJMEZv+weKY2WO4Jeke/hHF2lANeix4la0Qp+dGt/xwK38U6GroMZDoLjEcw1jEBrhMUWqr2duMkmLR2saT+5db6JDDkOyjcQ1g75J4U8Cj4VI1YG5qH/ClES45lkgLxSqYZbkY4FKrlxJAI80K0+deq1swg8gWs3TKKWfrwwa1qw/2vN8FcJemkrIelVQm4K2rUGmYM/IxniHphzce7o9CzMkDdNr2D5dS7UOPnPuNUDixw5nJRAJSyPIX2+G8SZNQVXojJ8o7336RuOGehpGR82ZKxlw7wNxZ7Yf4NEnz42wFCt8UCXtFG/5ydtozXas+XEu2dv/dTA5yKy8sNpuEBcsr/Gt14h8EmAXtsx0iUNyRBrQKdjWJVQj+IivmWOJSbj18LWvw8l2UpPfSJGMszasrOp/YSM997EG7BdHRgBVsdGU7fD+b9lTYigq51/1H4r0qzTO7xK6baVXQiAxYjy8PW+vIbYpxbXyB+69fg6m+GkyKqXUHnLalR2f8QIe63hMfWiI8ib20TpDTNuXZrQIapMfWvGXAjcxRHkCdCYNrbfkoceKU7mQYe838QD4G28PiVXHS0oEKFdOVkrz5B8e8i2Ra3dNtiQrmD9ncUx8YFtYsG+1tRRfjGngKhPIvQ6QDn3Q+MUFeHjaKHcFoJ2tBryZaaakWvhJEEg3zu3zo/LRSVWcHZZGidcruQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: izhdNesCP7EnGjSKNripOf5atfhf4vsYFHhaMEctzh683+xEQXEhPLuF0F2YuBatMPZJM4S0MIZhxfEyEF9PtsBEy/+sBSWFxIb/HOF5MsZ6+wcp0cfo8bNgam7HsczOMstn3S/mkfHOoxjU4Tpf6ZSyizezfbuO+XJJlR9J1SEM+On/wSaXqAaDEbLG26Csf0r8mvYhXt6vRZmzyHllqBmEdJH+8VROG4Lh2MB872LKotjjM6kl+REweTURKWqi76pRvpA6Yma6Rc6+45yl3EsOpHPIixBhSdwH23Z6ndg2UV+kr6CVEnF3Dqdy5p2IKtFTwzNkaLxBAptIgdwbbR7CWdluG7EiMFvhdm+ZoUU0S+GvlFrKiBp/c5WH00UyfsjUGSCR0Em3IlOdYv/kauKCquw2aMYDt6Kw3Wf6+OOljwX5oHVzY+p+m1T1nTHQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 19:58:44.9847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc986171-d6f1-45a2-3551-08de8e96bffe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146
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

The uvd/vce/vcn code accesses the IB at predefined offsets without
checking that the IB is large enough. Check the bounds here. The caller
is responsible for making sure it can handle arbitrary return values.

Also make the idx a uint32_t to prevent overflows causing the condition
to fail.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index ce5af137ee40..715c9e43e13a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -559,15 +559,18 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 
 int amdgpu_ring_init_mqd(struct amdgpu_ring *ring);
 
-static inline u32 amdgpu_ib_get_value(struct amdgpu_ib *ib, int idx)
+static inline u32 amdgpu_ib_get_value(struct amdgpu_ib *ib, uint32_t idx)
 {
-	return ib->ptr[idx];
+	if (idx < ib->length_dw)
+		return ib->ptr[idx];
+	return 0;
 }
 
-static inline void amdgpu_ib_set_value(struct amdgpu_ib *ib, int idx,
+static inline void amdgpu_ib_set_value(struct amdgpu_ib *ib, uint32_t idx,
 				       uint32_t value)
 {
-	ib->ptr[idx] = value;
+	if (idx < ib->length_dw)
+		ib->ptr[idx] = value;
 }
 
 int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-- 
2.53.0

