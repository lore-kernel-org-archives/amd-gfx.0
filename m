Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED821E77183
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 14:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A17EB10EDFA;
	Thu, 12 Dec 2024 14:26:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cuPkYfuu";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A29A10EDFD
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 14:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+BOT9Yr4qQ8IRqiGaHm8rWlCHADRrvhFsLdpDP8+Kj1p4u9gHpyUfICCz5NluLyDnum4om9p63F82q7Scnd45d02L1JU3wRcYrLJkykj1Et8OEDs3R85u7CQUzKxYs5i8fMvq8cS2VlT6imHE0+ZDaj4lYtohcV0CtBvoeJ1ofOgt0PPDN2PB+SGLgPINmz1agdKUmbQaaZ7CF6zRZNVmKXtZWaj3dwjXz3dydoSWh1aDGOueC4Nq2h8ckgUyKOCsRm8QF0UPf955g92tTf5u7UFKSbj4kd5BnTRIf2wN2Psoy1QQ9A7pwkkV6bkevHhQvX0wfkwxBab4g2sdbpiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89GmKVp+tl1KNtxuBJgrjWWWgSDmwC0ZKwvh0mi+w38=;
 b=BaZ8s/DqVQaHqZrht+mvdY6IScwoaxgcn09+fzp34HZU0T2zBEe7t2/WUt4EUE/TjseHdJvke6tLKgAedjsPnoS4R8Aa1cIkxzt3z2dUSFzkQWl6DYWYdklwoYjzOnl+PUA2vJNUSKu1xJJq1JJz90Zn5Fq2Fn2Xszcf3eH5dTL3BnaY9CgfQVDOPkZl0gD6C/DP2bNKHyL2gt5fJLq02NsCNcFr+PjvuXM30VzT9MdEo/JuICVkGLh1RUORAlCCMSTIVDhkWTjkf18QZ2+e11YhyWlZbbxUvD7eeldmyJUlscPA2aVLwfprfzyHcNADIVteMuGp/Cv/UqGhJGMGNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89GmKVp+tl1KNtxuBJgrjWWWgSDmwC0ZKwvh0mi+w38=;
 b=cuPkYfuujFG2atKOulea/pFlnxX9VLN8ASpAbcUw36aVtziCLcm6p0r+jZdfh4ESHR9RMDmI5fnXtAwA7x7RyQPeeCxJ7qPBSvVqkDYkFKAUJ8IkpkeXcImKtiexq24FQqO+MVxlZnQp7ZqDsZo8Q3G1eitq9RIi39UnH/Pz+lU=
Received: from DS7P220CA0046.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::21) by
 CH2PR12MB9519.namprd12.prod.outlook.com (2603:10b6:610:27c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 14:26:03 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::66) by DS7P220CA0046.outlook.office365.com
 (2603:10b6:8:224::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 14:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 14:26:03 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Dec 2024 08:26:01 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2 7/7] drm/amdgpu: Apply sign extension to seq64
Date: Thu, 12 Dec 2024 19:55:33 +0530
Message-ID: <20241212142533.2164946-7-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CH2PR12MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: 13609146-fdb1-498a-85f0-08dd1ab8e86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9OS2HZgX8GE/QUSzzxU0sWpJ16lyjZ0qlXD7L0UFU05Zu1fKwOgYXCLaPKXh?=
 =?us-ascii?Q?k3cATJL7Vxfn02cdSyBNUWqw1xe/FcEsSn8a27TuC4KC2hSEuuVlbbAhZ/Wj?=
 =?us-ascii?Q?0sK+lWNzFtVI7K34zlgzgUuaXjDJB5/m6/8CykqXMqXCOxv3V0Q8lSfVLmWp?=
 =?us-ascii?Q?FH/kOzX6d4MeGNRvwETxSIVlgK3iNHZPCQp1JuBs/rev5INg0cDd3IhdzMmz?=
 =?us-ascii?Q?/A4o7Lckwrh4dMuMafZvB/CV2XAagJ1LiKpRvyli4SUVE7YAGOw3VTUlxs9s?=
 =?us-ascii?Q?5wx318Ybj/DIIqFmWZwTwAGoTbLfgC2j6EIZAI6ed6Trdgk+wrRYlOehoq/6?=
 =?us-ascii?Q?mGLTFRqee38HUiiSauXaT+hoy58mdIwqip8J6X8lnbOXmAyzA29sRvYrtW1A?=
 =?us-ascii?Q?u9ufyLBFhTUHyMnm6ge8DzzTW8yGZQMij263fiN0hr9RXrvoNNThmpckYeiY?=
 =?us-ascii?Q?0PZ9E0HAEreUHyU98aGqm5TZKUHsadlfnlbllk/U9j4oBwz9fscHfdXcn5yj?=
 =?us-ascii?Q?yCnujgPCEX59lJMSuTCKzesrPp1SucsivroD4sUvILxVFW6fbheqjvLOC6ga?=
 =?us-ascii?Q?0kWoSBkG9RV+dC52llQvBQuau5xbJQXJlUdQyX7NdObJ8bhlPiNeOUnh5chz?=
 =?us-ascii?Q?aFeaXiU86NV/sR/17LaJbkYsPnHJyhmIysvJpqlYUGI9DSncrTwzaTGq4+ka?=
 =?us-ascii?Q?L2EqenNnTazUXI8WQI1mcaACwWPs7l2vg2TKsPLu8Uan+VnKFsLl+BQ9Xfzl?=
 =?us-ascii?Q?nQy8GOsRA94DEQRAdoBYcR7L1uWQ6ur2uaCb+jDA4T2Yumv4QLmWp9dgxwTB?=
 =?us-ascii?Q?AZ8hK+mRS8MubPF9fs+gnrD5v6snSLqj/j1jOqoDkScfgqImG7RyI9mioMAU?=
 =?us-ascii?Q?bnHqpiI/uYd+EntwQs1ogISxz9BhshIxuLwTUe13MljHIHXekcg/SpPzvbHc?=
 =?us-ascii?Q?XuQdeQ4kmnlvYemdqwMUZK3GMtpH3qY/ABK2LFLDwp8hWcQZZyYurCwdeQTd?=
 =?us-ascii?Q?Xj3OsmTJPxwuQ0p3dUxQwABSiKxgAffQRV9o6HK2+lQr0yYLlQvkRIb0dUBT?=
 =?us-ascii?Q?GeAOqPjXQn1vN0jyfoDYnqRP5jYqNqv99H986bPELHUobNjAmp5wzpy/mfnB?=
 =?us-ascii?Q?dfh4TMPcLiIrFM3gcHk3Z+8UHea7W6yl/zMV7g1P632ebIINcl1+VI6sMSRl?=
 =?us-ascii?Q?CyoqxPDjcqn2qWFSRxHilseHx+uvPhgL1Q+aOESCGdjZHszQs1QUUpKPer0T?=
 =?us-ascii?Q?NQ1EjJ9qWtavxBKZPlPY3TkvD17xbCWa/Y7I9eXVyhigcU7jfqpczdreyKkj?=
 =?us-ascii?Q?Sk8LxkiV/YayQObTDKZERBZE6xW/0n/d8/JI6Uuhs+NIx26wA4pn/OBC1XR2?=
 =?us-ascii?Q?Xnq+xrftW8HsfLd5TN/pKD/ag8HtNoPavCbpslY/859szxyq1rH6S9QpueNr?=
 =?us-ascii?Q?Shxu0IoyRx3s0+yMJpFy7J0SDjK9KQwS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:26:03.1181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13609146-fdb1-498a-85f0-08dd1ab8e86d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9519
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

Apply sign extension to seq64 va address.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index 898d215a8d99..2de1a844282e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -45,7 +45,11 @@
  */
 static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device *adev)
 {
-	return AMDGPU_VA_RESERVED_SEQ64_START(adev);
+	u64 addr = AMDGPU_VA_RESERVED_SEQ64_START(adev);
+
+	addr = amdgpu_gmc_sign_extend(addr);
+
+	return addr;
 }
 
 /**
@@ -88,7 +92,7 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		goto error;
 	}
 
-	seq64_addr = amdgpu_seq64_get_va_base(adev);
+	seq64_addr = amdgpu_seq64_get_va_base(adev) & AMDGPU_GMC_HOLE_MASK;
 	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0, AMDGPU_VA_RESERVED_SEQ64_SIZE,
 			     AMDGPU_PTE_READABLE);
 	if (r) {
-- 
2.25.1

