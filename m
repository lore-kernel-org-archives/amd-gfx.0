Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE079C369A2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 18:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAED510EC5D;
	Fri, 11 Apr 2025 18:48:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w0kC7AWX";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FEEB10EC5D
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 18:48:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VC6CVZ86v+K9W7rjdYnVJmeV8ZdhFlg7W6rAgBowfUa7xUo8CHwjCsviU0Tw7CYSB3Oc114QWr6AvKFu1a0IC1khrU9bckZKKKvCOiNC6OzRPREdU2wfDD/1E85Pzf3CDGXx5kv1qnIkRfuRLzePGV3arQhmxsbN0llPsQroLmwqANbSqFBy0Y7FdiIeBYGK8f8xAhAMIV60wKy5S9UE0XdTeCFJb1UtFGmDwumu80LojUb68kRjI6J1dN3jCik3t/ZVCQMMR3+gSrR/rXs2K20zPixTPcMw4NuI1xkZB5uBjQrJ8nKo7siYko2+be5pfec1JnEXwwm5Fpz8kBK8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=573QuDRCI4EEyxqzt/sbhyWoC9evtUjLFND0fkgl25Q=;
 b=YFL6WnDTFFYgp+wmaXaxckpSewljuAQAsXLM40nHVgrkbPDuJrOFWsmEC15O8saUr1JNAgqb0G2uHCRhENBqX3qwlBxNncjIAq4U9kLVeKSrMWxP7+s1R0ys1GZFi1iSo21OAdmWqk4VpAwSc7dtcYg2R/X8Zpi4/tCvvvNBlyRN9+alGK/494bqX/0JGrKXer+ofFckKjXwX8znhkR+/D9J9pC+FRfTSoL31uru92uIRBX7DZegoqKnsrAfoXLniKqp8ttcMbP9PXCrIEZySL4qGjjO3R49A1RRECxW+voAQ/jJBulXTPQ/x2VMxBHdugq8g3L7p6rTR5ZZVUYJzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=573QuDRCI4EEyxqzt/sbhyWoC9evtUjLFND0fkgl25Q=;
 b=w0kC7AWXx0AKjODhZCHc1en0lo7Fs6CVW0AY5U0UaVVpFnIXrz6N9SnR/ai4mtg118vXLmYezxWeUWZxgSm8pLiePp7UJU0DtCcMFBjcWUOcQgw6vRFF7Zy+nr3dxQKi+MyO0DJ9nwflmKFDWhCuEOiuT0kej+mcTCi30fA0ADk=
Received: from MN0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::23)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 18:48:42 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:52e:cafe::6d) by MN0P220CA0011.outlook.office365.com
 (2603:10b6:208:52e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.29 via Frontend Transport; Fri,
 11 Apr 2025 18:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Fri, 11 Apr 2025 18:48:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 13:48:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 07/10] drm/amdgpu: don't swallow errors in
 amdgpu_userqueue_resume_all()
Date: Fri, 11 Apr 2025 14:48:22 -0400
Message-ID: <20250411184825.2890189-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411184825.2890189-1-alexander.deucher@amd.com>
References: <20250411184825.2890189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 61146189-798e-4a8b-c4bf-08dd79297b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wumCqLUtVr+4z/2QJ0NrjCoi98wevl8zIkTs7jOJPViyAio3hSS44WC/iX+U?=
 =?us-ascii?Q?4/5g7xcOEh2xmbKEG5EAJf9Buk2/7Sbci6rVqm7/vmY2LmF1r8aYXp7VEiac?=
 =?us-ascii?Q?8rlHsLY2/SDTgR+kMTP+Bq1ZQeU+HA/+KisI5TQnN/zug7Sc7advEQNZjgCK?=
 =?us-ascii?Q?sGPOlT2N4FJX/iur7I1EqfuJ0aIPE5WkHoAq+dB4ZaSspW0GQnlsF2WQ+TLm?=
 =?us-ascii?Q?F2Hd5ZEX0urOYF1PlGQOUg2y4zpDhsJoEZAZFyK7IfRXrUqmxmCXEOaUFGxO?=
 =?us-ascii?Q?jiWf6bLcllZ978F9SoASEA3UFTOAfsaxaDnFDjtyfpi8mS1ORYqabwZgLYct?=
 =?us-ascii?Q?FFGQoQoKD0IGNnd+oo3UTe9bohLsoC8ASvt3dU3N+6iSBG8RH7OCC/IjRMpp?=
 =?us-ascii?Q?oo3iWVV4lNlAU8Lo37mR7sZULNkSkzeOYSLlgJVTAHO7j5cbmP9bY1FwRnnS?=
 =?us-ascii?Q?wKKfSa2hSx3OtEm1GbcZyN31BsdNogMmh5ayUan+a4qh7CEMj08derL4B3zp?=
 =?us-ascii?Q?r3zViyLmSn6kN6SPoY5NBh+jE6G666aX8ikjae94/1dPPnjbZi9nPHbSZSh/?=
 =?us-ascii?Q?8doWf5xkCDMkpZ4olii/a4yDhzegRX3xOkUEE/7+JT0rUrlFMF7vVtsz/c3D?=
 =?us-ascii?Q?LYAONGnnwrGC2qNgBBhqR5baCgX0cXwgMJS20ssw7Rir9+cidtDLxGrBfr3w?=
 =?us-ascii?Q?l34eD0pr6lpPrDI/fzJ8lkDsqJQyBp6nkqCizEgpZpCYN7syopUZn8LCanki?=
 =?us-ascii?Q?tg0Gy8FlB2FYoVy2ODw+fpbSaOb44ubMRu7jrQVnbzb/GuJAnCuT5GHCNdRf?=
 =?us-ascii?Q?lhOp6ILoS8jmytQkmNQwyt6EHTsij+vdDo7i/oM+a+61V8FTFb7FaL1+0SVw?=
 =?us-ascii?Q?wFP9GTC7fwWRR+ha3ZDSGunKScf5NQaa1gDDghXcVjGbvdK7g+Zo2/LFgNfo?=
 =?us-ascii?Q?77/lirCseTk1XZgolBh09PgI4xhiRagG4Wwg7RaqA3TUFTZjUIejjZPFS3Aj?=
 =?us-ascii?Q?45FLHEh7cv1XKe5mLkDwo1OT5uEBcN88uIrAqjqRMp58RnqjyZGKdRU1J+fn?=
 =?us-ascii?Q?UVcgh9floYKzJtm7HXFeNrvqqSgq8Sb0CE4gpdXyQUuYy7V3p9pmJByh6RkC?=
 =?us-ascii?Q?4AEZi3DKZUjqRK/6C69QMWclROayDYvk/7VDqWM5c8/id1LmspCzcXpSb9zf?=
 =?us-ascii?Q?MTiKU3WhmHqK8NGmeVHWUINK956oLhQCeBol1GWGMNIgHWHQAxbKWbN/j/YG?=
 =?us-ascii?Q?aurizBtxw/vtVF/EQSNoK/Aj/9fFsUm3Ez3JTjoZdWbWV9R/hPzSxe27A19a?=
 =?us-ascii?Q?BvGTnfPRgd4MH7rBAz19GKr93iustn0nRuunRcvQh6gAVqHrgcsxURl+HT61?=
 =?us-ascii?Q?95PiaPyIocuzQPPOk0Sfmc0WFgDbv5B0CejFNjCzBA0TMCqSDCGPHEtq8Eet?=
 =?us-ascii?Q?F0l2DAegzoy72KmR71cjTv9HKamZFsAevAtGqXFknGvj4j38iyj6W9gBaRkL?=
 =?us-ascii?Q?coeSsKADOuyRZm32OQMRQCDCdDYYFv0POdkV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:48:42.6613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61146189-798e-4a8b-c4bf-08dd79297b60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030
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

since we loop through the queues |= the errors.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index f5c2489baae43..aa7222137c31d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -423,7 +423,7 @@ amdgpu_userqueue_resume_all(struct amdgpu_userq_mgr *uq_mgr)
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
 		userq_funcs = adev->userq_funcs[queue->queue_type];
-		ret = userq_funcs->map(uq_mgr, queue);
+		ret |= userq_funcs->map(uq_mgr, queue);
 	}
 
 	if (ret)
-- 
2.49.0

