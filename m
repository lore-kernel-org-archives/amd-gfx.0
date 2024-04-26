Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15BFC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 00:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 735E510EB03;
	Fri, 26 Apr 2024 00:28:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XU8T3+U7";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4C7710EB03
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 00:28:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkAaMF5ZhzsCCOhcHlB8VBCkHt0oe7Q0wcEHH0JW0DJaPaKkH/GOGB0gdvgNe4FbUyQ0ja3ZKI8XxAZ3NyqQ6bBvHYwiEYbXC/dA+06+NlJ9DoB3CHoC7jR5hXlMFSz8kEcRj9Ofi3vZgILBQMmjC3iNK3v1XHnV1nYJpvvq+CJ6prQN3Sq1FGNxup2pZxe1eao+Dec7jjuf4oHEsinjlBPq1O7saq1Wudk97zkuktvvLAKGxfV9LVtXYJktlktoyXcwO5IjL886h+qWuWkS5dFN/Pt43n++7vYen8LIj/ZKOB51iHyxP/3OD5NlMT8/z7mUcG7qsjMHgpvWbNcqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3hTBBA1Gu45DUYP8kd10Erf5l8WHvEsXzVxaqbiKmU=;
 b=QCXqBoTuXhmK8S32U7GbPC8xZLBZZv61DMOGpNoAeDkWjjmGrkzJRq1xhFLp61jHpyXp3IbxlL869dbvjZrG0o8jc7I4GfptLRVi5Ls86LDB8TM3wAEUq8JV/vODIeK8ZErplRG6WjBcbaZZNW9KS4T3JkLUfNMmnRN9/3gn5Yiy/RXblY5aDplGHWeChIcWy2j9Vahuy1sjCqrsPaKDUsJZ2zjEk/fQcsjl3y3MB+flKfmp/tHIZgmAO/42+7eQLtMwxP8oM4KE9I5yEW15QqrC73BxaFD9GGrZgSog7cmk0ZZBh2AmDM8ovyXs2gtJpU5PmUDzEBEF/df6fa2rcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3hTBBA1Gu45DUYP8kd10Erf5l8WHvEsXzVxaqbiKmU=;
 b=XU8T3+U7Yd7Uig9cThdDvdgDXs4ST8FHZA5wVzzatx33v0IkH9a9/6kLyBQlEQNhL4GEPEicVbNImzWNJJkBuufe5ld+4USnngDl/jKTV4qbnpZ3h1G5TzhieXTEcATjck6aL5F/W/IKvStvwgRbioOPqP7hffqgU02iagGQvP4=
Received: from DM6PR06CA0050.namprd06.prod.outlook.com (2603:10b6:5:54::27) by
 CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Fri, 26 Apr 2024 00:27:59 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::d3) by DM6PR06CA0050.outlook.office365.com
 (2603:10b6:5:54::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.26 via Frontend
 Transport; Fri, 26 Apr 2024 00:27:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 00:27:59 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 19:27:55 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: fix overflowed array index read warning
Date: Fri, 26 Apr 2024 08:27:19 +0800
Message-ID: <20240426002719.1329953-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|CYXPR12MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: 073afefa-04af-467a-f599-08dc6587b9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DMxc66NUxsQ3yVVvHuwxIQ0Dg8Wrewbv+Sm4mRMigyXLia+P1a/wIrNzIGG4?=
 =?us-ascii?Q?b5shfYQZXAZOsXDuK+yRJST64wMhdK7G3vQXLiyuDWz5rM0fDaeilAT2Wrlu?=
 =?us-ascii?Q?kqxqNNuo5akZpBunl5OkqIxznNYZO+38r8VT9Hxy/wIxC4Rhwx427AerkQbz?=
 =?us-ascii?Q?RlMb1VcqD/DusjVlPpk2ePwHp9WNrBw+hbRNnT/jHlZf3Z7oStXVPBw9Tjon?=
 =?us-ascii?Q?Pg/2XxinFnA7PnVs0X0GD3kdLgltAHTHJGEWYQCECaH42GbGaVR/NtRnrBIn?=
 =?us-ascii?Q?3f6WEM0BLmXypYouzqB3JN/RalQCpnud+IMk2AWCf8Eru/H3wMLsJC1ASrTf?=
 =?us-ascii?Q?L9xlD8XfnDnC6lk7h+8Yi6vhFV2ddWRqtDwzOv0TdZnaKTH3+jgfflIa0GTj?=
 =?us-ascii?Q?StercItJuBXYF0V0zeKOZ4uGgpBaJujS4A9960YZH3zKzQKh0ZlWYaH5eASh?=
 =?us-ascii?Q?SH9XRUthOe70CE2K5TqMqy9XNk1A8q+AAsuxwH+o72GJUS5pBQ8tr1J9YSfY?=
 =?us-ascii?Q?RmOEqT9St+5AeTRX0V2NhSthpyZ3H/Ex4qQjcanLh3lLP058z2SmNJI8z8dn?=
 =?us-ascii?Q?o4sCb5P4/35r5bUNNLbkW0phX4rAnbCYjDoXiLec++6H+PevtELJJjDv40vX?=
 =?us-ascii?Q?SAhizWrngUbUmj3GKfJguZqaeRkXH2U4fitpjYVMyCVCU2sTSuTZXCIY6196?=
 =?us-ascii?Q?36L9Hdwti4fCYH0V/yVZHJ5InKk91mBbDwaHHzoJOIvhMj8cgnmQFSU4Ct8y?=
 =?us-ascii?Q?AArrDdGqrfnbdl9m055WFkXri6tA2fGGHJLBmg9D4DGgaMguBgrrgfaZltxG?=
 =?us-ascii?Q?eJ0UcfWc8TO4T03DXoCnIJeE+x+AUtxVdUhTt2EkMTR4us0U/pZIVd42Og8a?=
 =?us-ascii?Q?5R97iYXFgJs5bcUxReWwXUZWQGwVuTdsMIVJMp86yWjky9VeFYGZ83RXdwkd?=
 =?us-ascii?Q?ZJcDvx6/WHsJPLaPvVzPO1pAZKvhYjeozgBEDkcXEOHzIqSPZ0HdhdLcF0+a?=
 =?us-ascii?Q?4X6qJ8wjH5B+ZD6ppYcV9ZzJhCqX7iU+ySLsfBfZfBrV3FFP5X28VbHVEMCL?=
 =?us-ascii?Q?E2W9XAUcf6FFH9eeHeiBzgWcWoulXaV5Jgl3DKPlA4WDDXYFduCjdHDyxYmI?=
 =?us-ascii?Q?YGfZDiExA18ISRjlQXfriX1OlHKB6vWK1qCuW35Qxq9c7zdFqv9UQh+hGjcN?=
 =?us-ascii?Q?dMX4gsaOzK4dVjqL4G/JGPuxzSQKKSRitewXW0H+buG4a2rDcdnN6fsuQ5tX?=
 =?us-ascii?Q?8VclZ4und1XqqgmUaYRFlJxDiuOUfTy3DVXepcgvTAhjiolhkn5oFBMHT2FS?=
 =?us-ascii?Q?jO9Z14gEWXPdeT2TCNzKqrdRKPP8lApmWgBBOEaHvVgtYQrtji2VSdvfOYBV?=
 =?us-ascii?Q?lFlk8si0mRKMrnlm7fu/p76WS0RC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 00:27:59.3815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 073afefa-04af-467a-f599-08dc6587b9f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9337
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

Clear overflowed array index read warning by cast operation.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 06f0a6534a94..15c240656470 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -473,8 +473,9 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 					size_t size, loff_t *pos)
 {
 	struct amdgpu_ring *ring = file_inode(f)->i_private;
-	int r, i;
 	uint32_t value, result, early[3];
+	loff_t i;
+	int r;
 
 	if (*pos & 3 || size & 3)
 		return -EINVAL;
-- 
2.39.2

