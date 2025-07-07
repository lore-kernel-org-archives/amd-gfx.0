Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E564FC8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CF9110E512;
	Mon,  7 Jul 2025 19:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dFeeVAct";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F46010E520
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhAv3ZxAleyzKLJVRFCjNf0UMVvsoP6Vjz3DdVVqZR2JzjDTeENGuhnSGSSf8Gqho0vJ0YXFHgLGqfKInjvv48CCoYSMKkUuSvcybV8qwH5sjSAbX4xibgQsZcUfcfyxlvnK/394QW2qEnbqmSwf12ca7KjzG9HOeBt0+EllhMS/JPDxwZ0jbswGSdsFcfE5KSBoV44MMgtndk1RgAn7nCkNFZxWDis/yWrJ5Lj7lLliKIAmyNOC8XrIE6ztQAfWEdrZgyPfBbIPxuec00Gy9Uh/PGJ4JucKH1iWer52txyNrwjd6EqB+/3Bkfy1ac1pGHjnVtQTJ4iDzup7GLhtXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBoVwS4XbkDudrTMIzgF6EyENPi3u1CpJv9iaqQ5NBE=;
 b=LQ7guU2+eawWc3A+OKJwWFcvYPZG2Q1TSUX+3JYK5RLT1nw7JoQqT3N5iaVYExJK1Ifsfuufrp4jooyww3RIrCfrH9cG5xANxn2Qz8xcR5BRGETPmkPZ7f4qoL5ujAMWtKcEBtTeFQM9jKxqp5QX0x+NRi83N4UHI6w454ycu0tu5LiQ8bvB42LmMZFjyQIScvZLei+IH3DB+wtmcXlhUYgUXXJj5CtpAhU0lCaGoXzMsECHkMTwtSSUI6HKBqlqiM2IY4mI1t4T32AunNVInMdCcCjN5b4jMzLgWtEpdEVsG4PAKNNPsw1CECAWoJjO8oOE7reNUEIuAzryy0OpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBoVwS4XbkDudrTMIzgF6EyENPi3u1CpJv9iaqQ5NBE=;
 b=dFeeVActSeasqaOdEMCv8ffay7ySnCpBpUrU4EuEKQ07iqtbSU91GlDsNzf7cL0D/xAUGtu2Plgz6nypUkAslGG9SboujfvGMeEsC5A5BpdXgOC+XcyG4B8pHHrSs67JdLozNQlc0mQnlKUdzBof7xNEp9PvqkawgmrZkxsYpOA=
Received: from PH8PR07CA0025.namprd07.prod.outlook.com (2603:10b6:510:2cf::13)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 19:04:10 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::63) by PH8PR07CA0025.outlook.office365.com
 (2603:10b6:510:2cf::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH 01/36] drm/amdgpu/gfx9: fix kiq locking in KCQ reset
Date: Mon, 7 Jul 2025 15:03:20 -0400
Message-ID: <20250707190355.837891-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 50381d85-23e0-4e31-c857-08ddbd890de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DNSoWOcj9ilI0iFC5+SxfqdP0ND6J5cAU8jDx8Tuew3JCT78Dlzfpdzghz1C?=
 =?us-ascii?Q?9uldXaaieNWwlNHpejJrlEOSM0gNY+TXoujujt1lMwT82VE60COazIIRUOsg?=
 =?us-ascii?Q?aKWpxhIbZYvS1Ir2tB8uZEtsiutdPvTM1J3qiXxwPeQgdb8fm+KQiyoT5cjp?=
 =?us-ascii?Q?jDNlEjVHqmFye5nPAdMg5sOv7CPo/8a6xN0xlkQ330MeH8B6/AJzSJr/JgfH?=
 =?us-ascii?Q?wrhXgDhk6mdV2q1bRPwAsQBBF3qZk4H97wi6c1G5CpxQ4bqiq1euDQAanmOw?=
 =?us-ascii?Q?MY08kwPu4FYhoWsCFy6kT+nenbCllQz5nG1egfDo+8eogNZxCT+T38iFaToV?=
 =?us-ascii?Q?/uDr+lafRKa+WfE+vPldTEosd9+jcipjUZ6Qi+OK/nU8LWL1XdiIJ/I8jfj+?=
 =?us-ascii?Q?bfy4WNDAMjvoLNnV6a2Wdbz0NIX5uCYvW8BpqDs7NkFuNIvEdVNaycLy95T6?=
 =?us-ascii?Q?7BcUyyLyCaDswMxQG13tfwf0YvBhisnipxoocixEA0HpbSBoF4WKLG+EmT1h?=
 =?us-ascii?Q?sxxuYjZ2PzdwTqb3Jx3/KCRehkFI41Okz69vgk3bF7A/WK2tqAUu2Y96YN5W?=
 =?us-ascii?Q?hjQJRAo2NNcFfoDJju2/R+1bO7CLu30ZI46gHVFj2lmxxhMvJp+eqEVywPFW?=
 =?us-ascii?Q?Jq+O7GTM1xZLgC7dQkvrQplzCiygKL/yNL+2f2j7/vZVlYxVSEezjta3O9wm?=
 =?us-ascii?Q?7Noyr58hYuDWXEG4fIe4QDyvTcwgnG+Y5qdutDUxryxrDdVjLcivMEk45gM6?=
 =?us-ascii?Q?sA+6M+hxX0UyHS8dAcFuQg8IxmsIP4n3js/qeLnY4/TCioMBhAsUW1BnFDhm?=
 =?us-ascii?Q?j+ZhW56dYAh2YTKCyI7ZgBQ2mJmG5RFE/byFVGxSAlpIwH/7ZwdT6cMFbZQI?=
 =?us-ascii?Q?UTZU0jAphwFrJZ1wagP9ZqWw51sl+vDnvEE8nvA6pnH7bbROZkLDjuCBu9pV?=
 =?us-ascii?Q?/HiWMablIqnt7YcoZKBmku1MDcoJVRhrj5YgLklSyV8faoevPyD09EJQHPiO?=
 =?us-ascii?Q?uOsUUVxkSetgTZULLiMbiM0HCggHZCYnpHMmyQVcUi3SMaN8jF/GF1yXwC0r?=
 =?us-ascii?Q?8+pCqIs0L8wcvaDZLynYToq0cGIQ5LmznZW2EY8+JxYX+aEwQ+GnXX2m9UzN?=
 =?us-ascii?Q?mSMLfBQv/yIUNyud+npjmYTFhztam4PyUtw43/FRzrrHCJ+Fby0N9/G1mDul?=
 =?us-ascii?Q?WfD0Xq8KaypZk0cfPqIazigZrz6zbDyHajIlpdY9HGJ6SPX4HfPQfVhm7AzS?=
 =?us-ascii?Q?Incddc1V8syPPvS8OsdD0B3j9AA8rwOQAaJSsdKLw6I2uvWCZIMMkcos6Fx0?=
 =?us-ascii?Q?6blVzDRYhA0SnI60I7IoefpfKHAVIqk4OGiSNVdeZu6Pg4a+B2WQRsCPrvfL?=
 =?us-ascii?Q?cCBW1P0H85XFiVaABqG/iMYDKxaj+D1LVbDfCdjWFulSYSuT0JqLJ/XtKOjW?=
 =?us-ascii?Q?bv5clbNK+FF8R9yzIcRO5gh9dWKKL+Fs5dCnlKxI0YC9n5AykV2hhDWdD3nb?=
 =?us-ascii?Q?/esxCxvWymSt1+ByNfbH7IExV66qEwoZ7OMP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:09.6924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50381d85-23e0-4e31-c857-08ddbd890de5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
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

The ring test needs to be inside the lock.

Fixes: fdbd69486b46 ("drm/amdgpu/gfx9: wait for reset done before remap")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 76ba664efecb3..4c61157405b07 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7238,8 +7238,8 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		DRM_ERROR("fail to remap queue\n");
 		return r;
-- 
2.50.0

