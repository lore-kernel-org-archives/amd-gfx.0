Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C619DC3DA5D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:38:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FA5910E138;
	Wed, 17 Jul 2024 20:38:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kb6lhcgZ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 370F210E138
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:38:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FO8UTSMBzxSvWqmD17Qb89f30OS+bLs3IT1NL6xuS34aIF6cAO4iJoXGkTl+JmBU+Otsynd4ZeqhiTYVS5vL1beHqHpaURyBAhWHB5Nknan7zalGFaFT18MMZwsWNzYVMAfN0rBwof/QqTkS6KLY8WAcuAGecQB2ohNneiDvz/XMXgr2jl+6bEhHPdhz7j0dOgbm7M75aKtkktlMVaSi6dvBSxqX4ocHkH9QNZXAeBWVtUQ0fNpI3xgoH+iysoQcgeXqwjA8fhMfdO6gZC/dHp0Db5DaKSg4TXMOdxF44xqngwFQiSm3mMeJu04qxe3bDX8DyrcLsvH7zzL+D7iqcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIgc32UpKpaL9CVc1HEeZdhMXMP1mim1Boi5EMeGQTI=;
 b=fKxdqxo7qxJonIzxz5rcIleGfVMvIbbSxbVN90AgMmHveSfTSQxRMoJ64/ebORvoGNW9UIxlFwuWrcsxsleMTI8CHEb2FBH0kO4BPXYP8fmVXAPb84ykAFrh6VEx+MBHKzCWlRVgY0YjyFgLN8NgLnj0i7CiDmIKU56jDk3DcZiKTcm6vhoi+oqGfjeY+P90+n2PTTJhQtIyEUYXTKkFDFeSVYlpfd0uluhYELYTvhu0rdqfT20zXCGE+70XZeVbVWYXyyVKb/1MAUM5ENtdFWy0b/S/QkL/CUA8lSy45u85dZ5F6ShgAyN9FT4pt7/WaHvKIhSK3iF6/KGELeSrSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIgc32UpKpaL9CVc1HEeZdhMXMP1mim1Boi5EMeGQTI=;
 b=kb6lhcgZTFJwFYCiGB6MWYJ+Dpd2/rd+tX2uiSJGAfurdY85gPqjF22r+Vr5cVEpbuWdaF1BU5w9/h9FS6rkqwNVeCqoQrxzoHYWYQ34JZDYHjg39rTNMIEd0ARLxozCMl+yWeenzE19QVukhhVj6rOTMYNFlJZUvxN8IPliP20=
Received: from MN2PR18CA0002.namprd18.prod.outlook.com (2603:10b6:208:23c::7)
 by CY8PR12MB7169.namprd12.prod.outlook.com (2603:10b6:930:5e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 17 Jul
 2024 20:37:57 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:23c:cafe::47) by MN2PR18CA0002.outlook.office365.com
 (2603:10b6:208:23c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Wed, 17 Jul 2024 20:37:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Wed, 17 Jul 2024 20:37:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:37:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/7] drm/amdgpu/gfx9: enable wave kill for compute queues
Date: Wed, 17 Jul 2024 16:37:36 -0400
Message-ID: <20240717203740.14059-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717203740.14059-1-alexander.deucher@amd.com>
References: <20240717203740.14059-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|CY8PR12MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 93bbe9c0-d182-4029-fc29-08dca6a05746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HJytSig2AWomaWPvfgXnRjssF8AtU6tJNzgJd3J/jPpGI6bP5RNRFZqnSlMo?=
 =?us-ascii?Q?atk4B08wgZFH7WYNUV+KyMkC2L2n8pTrzMpaET47Z4nu+qETYrwnjNpubCDc?=
 =?us-ascii?Q?35lFo4m39VQiZsGDM+QDuFKmel6SvBc+mC0nExBcdMKJDY8yOmwQMx4eruM7?=
 =?us-ascii?Q?hPo1Pw2AOKNbbdgHzH409X4Oz2Pq15FukaqChmdnZ+nTaXSEubl56iIJuQn4?=
 =?us-ascii?Q?JPMM1PdByRvEt7I4t3A6NkZEzswCbgZmthWdU5mjMSwp+YBKnzLwr9I7xru7?=
 =?us-ascii?Q?aJuUqyVpT8Uv7oHh9saWFOb0XjJ3cUGFqOo3tgZvYIrUwA86uo/zUptRafW5?=
 =?us-ascii?Q?tKOW8dEHcKeK7pnrcNB636ftuIexd+ZVFPwRN5uGyJV3VSl0GX4NkDCsf/49?=
 =?us-ascii?Q?+pBo6xFjJoxVoQvdhmCWwQDz3Xrn3xTSqpOErnWzeJP5s1EmoEjT3x7odSER?=
 =?us-ascii?Q?Ug0iz0oa8jgCwjf1GTfL//UJa4OtzD7wElNntvbDqDKaCIKGOeHGq20JgLze?=
 =?us-ascii?Q?A+XZkzH0PjFFr+mWrrOnGdTWPkUq1ZZuGK5k1USkIk5qzT4GncW5vB1jIShm?=
 =?us-ascii?Q?bB3SO+qMwkjq+w4rappy6pJKLwbQp9REc07pg4aJJszusSnaFOvQ+BPi6cqe?=
 =?us-ascii?Q?iRjrkYE4I4Gd4Hpk+PA5vbTAlXBU60oeopXPUjoY0iIRpF21gWLX2hMALsti?=
 =?us-ascii?Q?MaUfps5494F30LsWItLPoFRIi0VD5Fo7am/mRJI4IZpV+8+RIZHboaroP3V2?=
 =?us-ascii?Q?X8tQxs7ctebGyHtW8YVU7vdgcmWDk0gVJbIJixus9MPn6NSW31K+4MNO72CF?=
 =?us-ascii?Q?+/hcktfFKTGB5NOOnwdLOY9GPNdeUwTeUz7yd19bOHAy9xZXRCy9mGmJLIkL?=
 =?us-ascii?Q?+2VVQKXUpUrgqkuz+kgJ5yA2Y7dozOJYZLz7C7QP8YKK2n5Gfop9LJS7rEuD?=
 =?us-ascii?Q?Yhf1XoTThOg6ifUu3gJBZsVXijZMIJCad3qCmE5TazT3g9n8PYJmR+K5x56T?=
 =?us-ascii?Q?ntzVGe7/8QzbwL5oHLtzuA2kHEr0Wh4IW5VsPXWgauSs6csnc0qRyTEzz+/T?=
 =?us-ascii?Q?iDK8J9kwqzQpVLJqvt8S4sFnVjH8LpmUPQ5jQ0iYylEYOyw5E4mKhTkWTpRh?=
 =?us-ascii?Q?EiiCS+e6pZLmxBpkZudysFG+5ctHUa1FbMuHO15S/5/ONwqzPwweHkAntkht?=
 =?us-ascii?Q?tXj4du4+Z6wDU+X2O1LrvRAHNR7AuNkqKVAlbXx/2RMXTweDpG3mdiC37DBG?=
 =?us-ascii?Q?aY2EB74hwTL/QiqAdUJB9LAcjzuyostCsVW5DpuA77qkGkqW1+gWJdXTBxxE?=
 =?us-ascii?Q?x6twxRbJMCHE2oRmWxS5+SpdzPC0AiHbVlct2RqZn/vRbo67e62DbU8YPCtV?=
 =?us-ascii?Q?UbkhcUI8y7fGPQdAc/ZPXgrR9nXkAyObRWfNKFwZYHLQJbpIEqsFRtKAFrpF?=
 =?us-ascii?Q?RIwAMvL1dYcA1XYMDB622mRWJFVeMstL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:37:56.8234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bbe9c0-d182-4029-fc29-08dca6a05746
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7169
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

It should work the same for compute as well as gfx.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2929c8972ea7..d4e38edc9353 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7244,6 +7244,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
+	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
 };
-- 
2.45.2

