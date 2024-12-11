Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025D6E77180
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 17:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F02D10EBC0;
	Wed, 11 Dec 2024 17:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1xT3MRze";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C931A10EBC0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 17:13:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJr/1ZfNaxt54NL+J/IiFzqRf10a7lYTVVHms3ooE6pkxQ6HwAcRQLl3Tu2Wpx5L3vMUN+kK8vwylvtM4Y9t2cT9M31S3/rG0JIOQakRg5+sMg08qJrMBoWwHT58nhpbBpKfU1euC2VrE6EBkMySgIdnamHIxn5F3JlA/HeBln8RpVHcdak9N53xqIuDl7iGJetoO0bQKM2jswl2DeYVe6zFjCeGM4Y85ONRP1XT4QSAqKZAm2GQ6LzDicMe/B5belwiHG9m1/O7TqMkEn/ZZMBkiRiFHUpVXDNbq4A53IcQIOdTzVZWsFhbKi2s9cHPBFWDktdXlxZ0LijSwSDiFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzzYFjapxPN3s9BCB2/n8L7JojpTqCfQsO9mXT8OjC0=;
 b=OW7ftyJKJ0rMOuzcQSdqB95DH2w6jOUS8x4bo1iWx2+AD2HgJfpnerQrz68OzvsyrEQzie8Ve2fgZZ7nI81ZNrj72GkfqJ/C5K/3LtzyfAen4P8cxtT4OPty/NECZiMcDgMN3M9rVQHZwiVm8JJve4pAM9hkEhBXcvG4TXJUhoVAEZ2KtvMX0jjdmW7aS25YPNL/UVBOckOfkuCPRIGufavtlXe+qHNRBChNhI8FhS8wNdbOEovlKwL4kxSqVuWzjTcn2c00wqiKY/NjnGiPbjiFz5t4aLgfoSZvVL86ogAlo5ZTvq4XPACujK0vq7oGUIhaNz3jGpCwbhGOGpL4Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzzYFjapxPN3s9BCB2/n8L7JojpTqCfQsO9mXT8OjC0=;
 b=1xT3MRzeNID+c6/M7l5+ji+hZMBAx0a6JI8XLrXQ5f22wmISwUvKVWwbqq8Qw2lHQvihnaQ2a/HcqLF7tn+ENidpcDlzK5LBFM7KdEislSWhH8zCktqS7TxbOjppD99ZscGwaVeEkhIYvGhExWYu+/AYxbbpLHqgPvShM78aONA=
Received: from SJ0PR13CA0091.namprd13.prod.outlook.com (2603:10b6:a03:2c5::6)
 by SJ0PR12MB6736.namprd12.prod.outlook.com (2603:10b6:a03:47a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 17:13:04 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::c1) by SJ0PR13CA0091.outlook.office365.com
 (2603:10b6:a03:2c5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 17:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 17:13:04 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 11:12:58 -0600
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: remove useless init from amdgpu_job_alloc
Date: Wed, 11 Dec 2024 18:10:50 +0100
Message-ID: <20241211171238.805137-3-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211171238.805137-1-pierre-eric.pelloux-prayer@amd.com>
References: <20241211171238.805137-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|SJ0PR12MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6bcdc8-30f8-4282-3c03-08dd1a07130c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2XJbLec1z5psaHe08/b1nyDHSzAXgjptC7C2yBDh6Hi+6G3aeHY3S00fBFNF?=
 =?us-ascii?Q?3T07qXE739aAn1KcpabpEdFjPfcHCbDhatDb78lg27P8dUqFhEIVsz3CsK8J?=
 =?us-ascii?Q?MvloeUEtTkHEMdILNl9rM+iZjJFwNbebU0Ea7QUsV9lF5B4gmlsCt1uk2T1C?=
 =?us-ascii?Q?I9i0tzOFfdZ42f+NzIRiywSTL/Fsr6gvesV566TsoltOTlV3zKVvpU1C4WhF?=
 =?us-ascii?Q?b0BRBhR+57F9k03fczwqYWJR7Esh4b4TJN8aKte+Fzu/lL+TaDI+fJseYnTA?=
 =?us-ascii?Q?v9CKYMd62GxvYZRz2OaWA5uClqnlNw6GKZ2GovORfw8XrEry3suOWtz7WB0o?=
 =?us-ascii?Q?8UiJs/RQmx8KWeG8at0onpJdV99MQB/UAtfnuQhqW8mcA0r3gQsgeZHl9lbg?=
 =?us-ascii?Q?nUUQrAWUlhboosOZ3CsnqHILEOrxjjgJ6JSNlC8iVh+B7Huo2G2Uk1RcHLU+?=
 =?us-ascii?Q?0obtWb6aP9wj5u9ndqBWJY/1eiYb4h30GHiHfGeVfBFAF16RPDedJul9mMj9?=
 =?us-ascii?Q?tXuoGdcXxd/CTo3xkg1hRd96wqN/AkvrSNo9ldlrH9qR3a1HQ7kQAgs2lI41?=
 =?us-ascii?Q?UOZn4CfpdmRHsPxWDd9GsmRQ1QChYZk1oUBY3eSZxzYANWWxrRCNyGn+NYsB?=
 =?us-ascii?Q?V7z3Cc2vLB5fSzzwyiKoXQT/vuGnoFIq97KE1b7dvZ5DgXbjsLsB9hlxBW0z?=
 =?us-ascii?Q?6cUO0fOkM0q1kdq+z+RE2pH/2NDRkljLjkGrb77noG+stics6mqtHNHstkLE?=
 =?us-ascii?Q?BJ+OAkH2ypjiF8j1ctM2ArIQZG0zEPVR5nYdvQtFRVLv3w5IHO1H/gHuNxTb?=
 =?us-ascii?Q?OO7C2QXU2moLKHOFo2+bFQPMTpLhU2jQ38YqLWLcR4jifosdmMPSVfh7jq0y?=
 =?us-ascii?Q?waxs2fo6FlZshkXR5LCXaCtO+l8F+Sq9g7QOufvjr9MuLHDyCuJPJLnBqs+h?=
 =?us-ascii?Q?0GVMKHaNYATwENnYJ9jwcMDPNbcVM6zx7I/nbdW/9M63/iKC4DtKOr+15S3u?=
 =?us-ascii?Q?WoY0WwrJgoDzQdSd16VmVswtpYniiWrgQGErakhe5du2tBF4NETzfevfj3dM?=
 =?us-ascii?Q?YNTBkGfEuIVJDgar8BGdabf8OKPvovGv0Cw0VSkUyCusI3b1/3xB7ptqiPRQ?=
 =?us-ascii?Q?nQFnxU3NsqTHaOLfTjLTfrqvJjzQz8fU0l/zQliCiPJPHoj+N+V9asem2AhE?=
 =?us-ascii?Q?Hz1xyi5Kk9LsjmAaAyNs+v65bUl8q1NnmqvCtiNawEdXiLPY07GjUSN3JpSi?=
 =?us-ascii?Q?H/5KBSFnazkpt6oq4fvtZKSka5SaRkBiAJXRuB/oWe9V490fES+Pu1JhQPk7?=
 =?us-ascii?Q?GDdpgXpkW6EDwGClmMz0/9MLWMmgi+quNzGquRHNbOgOzA/97eJhnNwXV6I6?=
 =?us-ascii?Q?VwmDVJ1esjdDKMZxdT6uDz/5x3fF6KTlakt+PG36rIO6MexyPvQvxLp/YJYz?=
 =?us-ascii?Q?oFxqW2NFuYjd1EgSDNUEIkNudXq2N8Qw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 17:13:04.1578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6bcdc8-30f8-4282-3c03-08dd1a07130c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6736
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

This init is useless because base.sched will be cleared to 0 in drm_sched_job_init
because of 2320c9e6a768 ("drm/sched: memset() 'job' in drm_sched_job_init()").

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index e9e2e107ed45..72973568cd1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -198,11 +198,6 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!*job)
 		return -ENOMEM;
 
-	/*
-	 * Initialize the scheduler to at least some ring so that we always
-	 * have a pointer to adev.
-	 */
-	(*job)->base.sched = &adev->rings[0]->sched;
 	(*job)->vm = vm;
 
 	amdgpu_sync_create(&(*job)->explicit_sync);
-- 
2.43.0

