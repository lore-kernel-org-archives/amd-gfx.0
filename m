Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4579C369A2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E2F710E392;
	Thu, 10 Apr 2025 18:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gpLfK1rG";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CD8610E390
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDqufRHgNH/MZ0iuhaNarnWTAgzULEveZsnoiXHLEgMNhQ19wv7UpU8rEMMwZjval/TWCV14tTBhBh8GfePL4J+Vet2lxpcMRxigYXzmmdK1D0HUVGIAXjQURJRmaog2jyxls+75PM4WJcdaJcOOM4SQycUzX3haqm2KUsHKP7o5DpLGv+c3jUTqDOwhVKA/ZHPVaWPnRpV2ZlXjzbFcObC2G9x0MRvGF/d3p8ZgXhSUlejX3DCeU227iO2+lrUit8LTh9srkDTpd47IuU4aNWMCwbSNIttk5Y4hwSG0Ys0JmGmth+ehRqNx7ygg5VbmzNnHAeWN1sMclgOCGpdNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqNEVyVFbek3yDtyR/I+eIllJqB/Vua/ILPmzz//0gE=;
 b=tuhUrWingj9oMF2KhMIKHegBlHq4d5j7eqJO4NquOA/2+eYkfZg8UYeHvzzqLE+XOxgHss2RcJys5dJ63uKcSnN5z1Y+JtLSodeivULXnVM3HvtHRHrH43Ek6kmpEUSzlzf/+eFo3075Zr2oVLSEwdxkjzxFFjqxtLwcSLCXSVj4MkvPhf6S1iMkpEXtR3/YCoYGn3VXzroFVtgynehkuOZHpHLCbbCQuza3jGaS/HvPuaXd9O6yIZj3bCSqe1AuEuwm48uu48YFsthIc0bne5kRVrrD46Zc4BELeCnxe2rm5F7PLt/DbAt0nCbE8oFYxtNe9r9cN0EMPbYPChD8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqNEVyVFbek3yDtyR/I+eIllJqB/Vua/ILPmzz//0gE=;
 b=gpLfK1rGhsoDjdOLCJC3Zd1STXyMXQlW1O2NEPfgfjtxMwJiBjJYj5/irnaBqIKORzpimFSU44I+lHshpvt2dvVgi79+QxpRfx7fcb69JOJUFf3llnVWSDyxuMWS3PGdlX3+5RCuuwTzxW8mwjiXW1FCb0Iiadsg4dsTLPBFPo0=
Received: from BN0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:408:e7::30)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.25; Thu, 10 Apr
 2025 18:54:18 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::42) by BN0PR03CA0055.outlook.office365.com
 (2603:10b6:408:e7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 18:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:54:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:54:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/13] drm/amdgpu/userq: add UAPI for setting up secure queues
Date: Thu, 10 Apr 2025 14:53:57 -0400
Message-ID: <20250410185402.2352109-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410185402.2352109-1-alexander.deucher@amd.com>
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 933248f9-332a-49d9-730f-08dd7861194b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wCuBzrdpimgXcljal2YsVPb809sRGa8oTr4JD3YNPif0SZYaHgipQPidTIbm?=
 =?us-ascii?Q?2+CoCTvHNOBRg/ndyALZpcHYFoaSYJYzcOD4LT0oN43rQ0vHAFXbddEWIEpj?=
 =?us-ascii?Q?s2b64QBd5MyRh+HP2En7PXDwoLALyT6MMEtzw1IbEghqmb7X3JRTv0QfPJFj?=
 =?us-ascii?Q?hc2oZFA46UGVVIcEc4+II16fI9TDVAOUKX34p/vOQi++1oDw2FI67AypvgdN?=
 =?us-ascii?Q?4IpRMyIq5JkYjGB8AopTH5O4hrvWzDpDhev8YQtDznSVFs0Yc136Lr0W2K+T?=
 =?us-ascii?Q?Mm1qlymV+Iq0xmk3J1H2WrWHWx/S5JIPtUkJPdPzOoBQeYfmA4asGCsuzvIH?=
 =?us-ascii?Q?UMym+f4F1ipHusWflJPAxBD4uC2RYKT5OpCcuXKzlQjx4O6qXPA9f60Fmv2u?=
 =?us-ascii?Q?LaLnKKWAojICOJwCDbwjrKSLOghaEIkGEPsLnTAu1+QSAzCjzpYH/oZQX7ks?=
 =?us-ascii?Q?ymZNwZ6uII7L3S/7cTA6DplP7O+EuaF2zDzNuFcyZT09E47vvP7eqlR1tiAm?=
 =?us-ascii?Q?Cz2yqYKzqsjW5jPPOYYR+2loP7JYQS4a+B4bgrOn/ZOKj63Sz5vXdXjTPTjF?=
 =?us-ascii?Q?72yAZulE0GnjXbfIog7ho+mRGEFmFXpcA5aaywuARIhysvUEfNi/ZeJE9r/J?=
 =?us-ascii?Q?AI25q8TnM3TL4MLz/n3/BYuiaG4NxOS/9Pt5u6rIoUJAgK3Wd+yTvyRnx5IK?=
 =?us-ascii?Q?Afhst6E7+K7ZaZbsHeoF8IiFmYhGg1pEjH1OtKQcfk7XFJTlfn8RFfXn/u9l?=
 =?us-ascii?Q?t+w5wTFgwRs+R1G5VFYWjRwT3/eIl71WZp3Sd6rntfSPd6t6nM8wkw04Qp0A?=
 =?us-ascii?Q?fXFoEhxo7LMNu+8yqcm3Fcua5+QX+rP0UtTSuXhqJeFUJ2SYyj6jv1ef0k6q?=
 =?us-ascii?Q?+F/+itPplLqpBBUpFGeZJSNo2qm+vJHqHgcxLVvlhevIlUy1SZ6ZCqqCk2mO?=
 =?us-ascii?Q?VU0coqEKYl2lTPql+lpFDVtfT7eqWCUhpdXUBDwzDdzNyp6XQy9DsHFDclDP?=
 =?us-ascii?Q?1QZGCjYEx7qbCaSC1ZmcmDRCylMAweuf5QhoxmI5V3gGCHr1uKQyBUStqGu1?=
 =?us-ascii?Q?Q/e8gbggPTv980B7xJWCR5yF+HxczzrmMenB0DtAiw6xaGFTcqEdK0JMyy2+?=
 =?us-ascii?Q?9sP4tCCqVNum5uxySwyOBSCIpCVWGYqE/pY7sTw7V3WVFcXD0/QXLZAZkC/G?=
 =?us-ascii?Q?Rb6wRm7WT1nCHLwqv+BxJvnA7Qfeqs9AotbeuaplFH/+7z34HaHQUuFx5LRf?=
 =?us-ascii?Q?c/3+hsM/8TkoAEyxa2gflO6hGyWbammiICAiJb13QQwZjTvDTgR5BTbI0EyI?=
 =?us-ascii?Q?LOCSyK7gjN4+uI9ywUZffXRQTDu4LHnICQoz2W2tUcoMr2aAv7CUVsyTf3xK?=
 =?us-ascii?Q?tEeuCI+1ZNM75Wxkj1vS2TwR6er6iqFiqN3pknA4QJmBYHCdKw4+EyGyUVNr?=
 =?us-ascii?Q?CNmF7AX/WIqATi4ULdbfG6TlDuenw9TLD296rR47zXXUgv+oB8FX3FOPwFPK?=
 =?us-ascii?Q?7Dj2kieh9viZbo062UOAJD8PKxWfUcGefwlq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:54:18.7584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 933248f9-332a-49d9-730f-08dd7861194b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518
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

If the queues needs to access TMZ surfaces, it must
be set up as secure.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 8719754c777b4..0ca4b3b961eb3 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -336,6 +336,8 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_LOW 1
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_NORMAL_HIGH 2
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH 3 /* admin only */
+/* for queues that need access to protected content */
+#define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
 
 /*
  * This structure is a container to pass input configuration
-- 
2.49.0

