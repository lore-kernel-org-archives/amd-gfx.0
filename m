Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4818C369A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 17:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FB2F10E633;
	Mon, 14 Apr 2025 17:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XQ6INNQO";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5DFB10E2EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 17:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F36GPDIQJ0nXuz/ZHMjpVGeYOzdQJMleUZHi6irTiureTKWruR2kEnC0LdhmouqMVf4Qz9KxmXrc3AdUk8gVMc3nyAZ3eHo2TcSiBLgC7vP3yXH/IQJvmHEc/tYo8/oJrb8ZqychCqBrcNqanb7MkMiImCvJN+ljUz77uJZFu7n45984CzYgb0xxYR14FkIhPCShI1aCKH2QIYNcbNKilqa9hmwtLzEAERoTeACReLitRiQY99Uw1HEZJ6opy5QlyM2oJq2ZScHAph3VvIYYR/V4r1kJPWIPZ60YKN2s4DRznvBTZj5ScIAp4VNo27ZyDuT3wC69Vwjyb1d10IEqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWaCsR3OtAoe5klB05wCVKGI5kC/kPrGtrqZ7CCcw08=;
 b=oNFiHsnjoVFo9bnGBpmANZkDUbbKg7H/QjIPiR3kXn4AbAmGCBxwftd8xIKFAK9tB12/uWF1kKp1xN4pajvxgo6BuKtkPr7GRtDRY215fwhtkNKe4f35bc/+P4GIbpAHUMM5otb7g4j8GqjUqEF0CAgLoj7SP1JaydJBkS2dJsF/f2tetnIJd6qpgK4rZzHEg78ItAmivbZa1WWFj9DEcTJLbyFLy4w0+AtOMYGvVqmWgC8AGP1dxHtN7N4PQJafKesJU+XKhx+M+B8d1gE5jJxjScNJUhzW+rOjT4NfApoZ7zBXM498Hrv7yGs4Afek+gaenSdQhmhv1pBjv69atA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWaCsR3OtAoe5klB05wCVKGI5kC/kPrGtrqZ7CCcw08=;
 b=XQ6INNQOYFR/XNxanSkWSpcYLGuKif9VxeMpxtZcuM1JBMIILvpFQP+Fw0PwCHLWAO4T5T21fJuZaQlG94OcrgyjG5hyivmWUWTdXz8eofswsuZ8iKufx5yxTWskKJOyMIEqCNBOJYT2NbEl8X5jE4JPczszLjwjtxTu1KIlev4=
Received: from BL1PR13CA0320.namprd13.prod.outlook.com (2603:10b6:208:2c1::25)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 17:13:15 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::a2) by BL1PR13CA0320.outlook.office365.com
 (2603:10b6:208:2c1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.10 via Frontend Transport; Mon,
 14 Apr 2025 17:13:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 17:13:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 12:13:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/userq: integrate with enforce isolation
Date: Mon, 14 Apr 2025 13:12:59 -0400
Message-ID: <20250414171259.2996574-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414171259.2996574-1-alexander.deucher@amd.com>
References: <20250414171259.2996574-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c42d93-1625-4d9d-1659-08dd7b77a4f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N3dEalkFqMatN51CovJc4jbyjUIQgZyyRA4bVIkQZeVuRNmX2vA8TUmtM7vu?=
 =?us-ascii?Q?IPoniONI0ZImGTDp7MUYkmw3cWFknm6QAxX6Ozgi0msDma57zi54y5l0wZBo?=
 =?us-ascii?Q?ss0nQCkqEpRV5GvzmU8AnCH9hWxaCt1iQUC9RqVBDS8H51WE8YgFCKDKITVv?=
 =?us-ascii?Q?c2goMHsXSoNYKJH/ALi4mQML9ArNXxRsrC7eIUqrkfJQ4pePmhUAYM6YTl2C?=
 =?us-ascii?Q?9tvdRlhEAoxYMdAVm1ps3/jFmW4L6I5+Yo/CIxv28+pbJaJW4u6fj55VZAXe?=
 =?us-ascii?Q?kYMYXWn5hpVftZ5Kgd1GkLXMLkXHb7KmLkUCPZZCfd4CnQqLDjQYAlE/ax1e?=
 =?us-ascii?Q?SVcbse7PePeI5XCPgZhMlKjwIx+i92S/FApO5tAY8r/Z+AfGEBn1SQwnbss0?=
 =?us-ascii?Q?/KPWy5eYPU3XWIy0DqMM/LO+2SrvPHPMDjfUjh7eTEq1BLbx9xS5GVkl7fYq?=
 =?us-ascii?Q?ZKw9NtHJI5gfhAxblEF+Fkp25wk+N8CrPtIcQEpbKJTUJM8Vi+Zw1JOfUIq2?=
 =?us-ascii?Q?bRz2aUXy7wikIahSMpFfNrC8a5d5rubSFO4mEloBe5n7KaKI5qugf5hMPP9b?=
 =?us-ascii?Q?2Vw56QJjtJ3moFXHEMOITJT67yDgc0VuOTDHi9roJDqs/7Fvx2wrVpYnCQlo?=
 =?us-ascii?Q?Wr4zkhOxkuD2V/j4OkcCjEksh848M9LxHKsN1Y2JhVfETkvo/7SUwATswP9s?=
 =?us-ascii?Q?80QGk3xB6SnGVeCi6y4KzT/SRSSNCqZiML3XVzQSK15JcUAg1fYHFe7r4xtf?=
 =?us-ascii?Q?LQNJC5iSoaNMTBBTtMp92/WEz4A3A36zvP5ZC0QnUTkgJlCjQ9D6de8fbOYF?=
 =?us-ascii?Q?xphZ5gmt2KzCLWjCixsRkav13/KvTauOEFr4qQ5SbZxw8C2fwS9VIwRI6g2e?=
 =?us-ascii?Q?cMOqF0ezaFrCuk6cN87FylLPr7rcBJKiYwkNXJUBsw4USacc5imBdSL3JYoj?=
 =?us-ascii?Q?UqgnbF/B1EP40+AHREXupH5AcwcQQqeGu5ymqqI0MusN+mmLFfbj32lANg2v?=
 =?us-ascii?Q?DyUJJ/8NiYRonipkVTmrQfody8K7AENZxpYMoZHaY3/IxcYhoZGiyRSq60Lx?=
 =?us-ascii?Q?OGQKaMdyMH/xrQHAI+JK0rCd2Id8vl11k8TE810QNnpbZZ1oj2XglINlFlwX?=
 =?us-ascii?Q?pqeG/hrY2CliFOdUU7dKQ+8yBEcT7gy/fLTANjv/y/BAC3RikPVuTSsI+o9T?=
 =?us-ascii?Q?UDBOuExJke3emEIVwz754bq+LCQiOeWoxZQexJ/U1xldPL3KdgWU08bqohdx?=
 =?us-ascii?Q?QySE1uqUy2/oAEvgVq0vAsJX/tY3oCpsTcPniroUaorxsb7R8cGWXGqcyOk4?=
 =?us-ascii?Q?xPio5ZTwZucC9tVH2VK4zXpnhSIV8Fp/I1LBeNKalckIrbT0ONKBN4iB48V+?=
 =?us-ascii?Q?YAabDZQfwI3usbi3T982E6mrCkQy0J4XyKLl0TRYD0GhqzmtlwB52Hi9s/ty?=
 =?us-ascii?Q?WZa40MDjiqhq0jIPtlZqWhvJI0UYWdDtB5c3Qdr56LnG+9qDRA4O7jHMod9v?=
 =?us-ascii?Q?VEHvgxcDCJZay4eKIORajhEmiWi88ySbQfYf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:13:15.4728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c42d93-1625-4d9d-1659-08dd7b77a4f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610
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

Enforce isolation serializes access to the GFX IP.  User
queues are isolated in the MES scheduler, but we still
need to serialize between kernel queues and user queues.
For enforce isolation, group KGD user queues with KFD user
queues.

v2: split out variable renaming, add config guards

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c58d32983c45e..71c8b30b1659c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1970,6 +1970,9 @@ static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_device *adev, u32 idx,
 		if (adev->gfx.userq_sch_req_count[idx] == 0) {
 			cancel_delayed_work_sync(&adev->gfx.enforce_isolation[idx].work);
 			if (!adev->gfx.userq_sch_inactive[idx]) {
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+				amdgpu_userq_stop_sched(adev, idx);
+#endif
 				if (adev->kfd.init_complete)
 					amdgpu_amdkfd_stop_sched(adev, idx);
 				adev->gfx.userq_sch_inactive[idx] = true;
@@ -2027,6 +2030,9 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
 		/* Tell KFD to resume the runqueue */
 		WARN_ON_ONCE(!adev->gfx.userq_sch_inactive[idx]);
 		WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx]);
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+		amdgpu_userq_start_sched(adev, idx);
+#endif
 		if (adev->kfd.init_complete)
 			amdgpu_amdkfd_start_sched(adev, idx);
 		adev->gfx.userq_sch_inactive[idx] = false;
-- 
2.49.0

