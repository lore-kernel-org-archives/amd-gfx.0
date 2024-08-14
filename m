Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F511C3DA4A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 13:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8A7E10E478;
	Wed, 14 Aug 2024 13:20:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uHoxnN6T";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6AD610E478
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 13:20:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxwJjnLAMY1uEaV1ksS/hNmS+YJLPpwGzVg8/isqGlHJgm3WqSEifqQJw3er9kmYF9LQ0SPZvEamCRywbdTd4JDlQPw0ur9QYeNrW1or+4kpvad27ouh2kk3oG592xAG8JpL1PhkFn5jFJWst0Xt2bVZT4C2YPKfIMLbgnVi7rUxGxyyjirL0dGUa7nwH6YGotYpiBHFup2puAdV/ahvn8BsqcpmbpToOi5I3u9sbFTN4/ewu0UmDU5hkSZRFElpS5FLZaOawB9NM0IfISSK+JUvVcRhE2e5bAhdw0PH4S6L4EIGWWpMKR/2W0KnUGbHGRKM0geIFD7RQxB4tv4cew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQRZJS7o8g59+GnmsaR5pnEqYXg/kv+Tb1UYMyvpqS0=;
 b=H9KZci86Fig+e2KEh4k19GDgK6/b8pltH5IbJFPJOd4BIGH9DLaQWKseKFDZsaKWbMrXTbU3etFdii+29LiDBn5j1Qi2EswYZsW9azIcPdpTpo8dsODfso0tQiXDkCd4FpNw6z+yku5jfDXRsPUX9z0xlomzJprpwT1uH6LQwUc5ID9UQjU5MwrjGnq9eMZXKSB6Ns0mpA8et++rOJrPnYF+kHIweSK0b03qdgW+8G/R+F2RVs57ERJj5YnN8qpruW1GJAshLC5POoDC9eJSTYILGxZ1cbQ5CcpWHgB7dp/+awyQ53LP/nLWyDq0KIbe7CdegtmcLNbkjmtTWOOgQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQRZJS7o8g59+GnmsaR5pnEqYXg/kv+Tb1UYMyvpqS0=;
 b=uHoxnN6TRPxbVHHqxszlRF8UQCCnfu5W1pclPAvSrNG8vZD+XwYdFOcV+p/J0YMr4ENUzxetJiU8vuLaA70A7Z7eHcPWPEsMIs6maidKkFYgQ19Ae6hiKydeE+VTl6FYM4OGqQV89zYDZKTgiljKjZHZsxr8gbXq6Ex1f7tTTXw=
Received: from BN9PR03CA0872.namprd03.prod.outlook.com (2603:10b6:408:13c::7)
 by SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Wed, 14 Aug
 2024 13:20:14 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:13c:cafe::9a) by BN9PR03CA0872.outlook.office365.com
 (2603:10b6:408:13c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Wed, 14 Aug 2024 13:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 14 Aug 2024 13:20:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 08:20:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx11: return early in preempt_ib()
Date: Wed, 14 Aug 2024 09:20:00 -0400
Message-ID: <20240814132000.670048-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|SJ1PR12MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f82b38-96e3-41af-2e1d-08dcbc63d52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VS3JBgASWSNzRucXK1kNrOEjKXV5sxIwC5JhLT9hcB3ROV9ZBvfceLE6L4Tx?=
 =?us-ascii?Q?TtU0xKU4drVaHwW8chwr2+qqkGbBt4CKmy0xaBkUSshp05EQAZL56Kl0F7X8?=
 =?us-ascii?Q?Sv5LM4DNEwyXK1igsOqmA9lkbcm/AqjohsT7M004jb/TFNL7gZEDH8+In977?=
 =?us-ascii?Q?m2sLBRxZfU6p0YohTKBp0w1pnhWrA7EjhYXSfchldwuKZx4jS7NRvSlJg1op?=
 =?us-ascii?Q?WVObKsgHSdtzg46Jv8aC/JZpjdKm7do8dLMG/WL6G/si2maTH6C4pLAck+SM?=
 =?us-ascii?Q?cfOjZmLCnp+rrXwM1385sQZ/LUBWWPptBYwv3sHoqzvLAHA5kkrXIiS/uvfS?=
 =?us-ascii?Q?aC/xoijuWEm7sdmf98duH13bzOWNqNpxV+B0blnGvC6B6VkLjROszU4k45eM?=
 =?us-ascii?Q?XFi0f/Pos0nuygruQtGIUsu4r7PRAJLVSd+jz2MoUNJ1D6mte4jKWxlrlPJw?=
 =?us-ascii?Q?MHZ00WnYoAef2TQ5zZ47px5IhLdiR+5+3jpAxyurZIIafejUd84z7MIrypcl?=
 =?us-ascii?Q?t7gJIiOSMq2uI1nI2mM1sRryr3TNVfT1QLGjgaoh/q9pTugHfhfGpZbDEFZY?=
 =?us-ascii?Q?Ay9F+huk9vaO9LdrUt1ZvgRvvpksmWmelojVlmNspL/7YTfGu37oSNgoYh6C?=
 =?us-ascii?Q?UacBthI1odPrca18ASG5KHQUChhdLZIullWb1oY2xVFnwzpASz2URTLRmdb4?=
 =?us-ascii?Q?OL2xbsMLQOGj6ijihd1t0/lqASgSpRM7CmOZ2SR0SRbreDbnkbDZ1BFOmdYI?=
 =?us-ascii?Q?Yq3tskkx6Q0M57CJvUTlEQQimfVaHiI3xICLmWOOsY1j0mlizzZeL5XAEzv3?=
 =?us-ascii?Q?P+jSJsjNGuIrCrIEZj4AOu5HAhI2AM58rsxyM8L528v5EvlTNtpELWzSvx6I?=
 =?us-ascii?Q?71dxlNWXPgzTfaFWFdD+nyY/s/y+8enKOJIcXyOFZkui2G0a8en9T0DbTfJq?=
 =?us-ascii?Q?AAm0etoc74OU3eTYP7JJVKvrWcn7Qzc/WKF5EgtvX6wLS0nW5+YIc+3jpcR1?=
 =?us-ascii?Q?kUPYkMjGZb8L/nAjpvoTkLZu5PFOV9WULu95YZOEPts1hrtuweI1nQjbJcbR?=
 =?us-ascii?Q?65mB5hVLUlo7v3kbxVUzhq6CO4+2KO/InzIsri+Qm6zj27oCoqaW6xcMqSWJ?=
 =?us-ascii?Q?G0y4VslHFk6m4xefPSb5SSBBvFanbz0+fclHb+Pw6aJWmGhlUJjb1PT/tUrK?=
 =?us-ascii?Q?6iR+vzvXJFiqWUI5X1ZXT2SYuAM+L97Kp9c1Rudx/9XzDY1pnQfG0GxVY4Ar?=
 =?us-ascii?Q?uOaqTSBTJB4+KfJzY87p6gMzyOacGn9HVA6y+9flZedyLm+UtJrD8WZZfL8x?=
 =?us-ascii?Q?+DAoTCROCQPx1Uid6i8CGVUTSR0/5LhBUZR0+HzIlaELKZisSWWzQinpye89?=
 =?us-ascii?Q?Z9F1F+A0sa7w6h0JJPA4DKxQ2YsjXzbCqIkx8VbvYL6JPlQaS6kCda7fIcVn?=
 =?us-ascii?Q?7ibUfRyGipCBlqFoSMjGWxTpFH8jykaQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 13:20:14.3303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f82b38-96e3-41af-2e1d-08dcbc63d52b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6124
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

When MES is enabled KIQ is not available.  Return an error
when someone uses the debugfs preempt test interface in
that case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 22bb35278691..cbeddb88c936 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5920,6 +5920,9 @@ static int gfx_v11_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
 
+	if (adev->enable_mes)
+		return -EINVAL;
+
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-- 
2.46.0

