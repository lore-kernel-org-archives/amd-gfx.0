Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750FCC36005
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 04:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7019410E36B;
	Mon, 28 Apr 2025 04:38:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MkdgWJfd";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 910B710E36B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 04:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjLegxcYuU3QF+SQs46F9eUjet5/MosooTmwUrlzNwOXPoML4jr5IBHRWk8C7+5AUxEqKKvK6V01kMOIihJ7ejatPnydhRQsz7AlJEerPitoj44a0KAG6tRAZp48rL/JUyddAu/NHCVWPG1qRhx3pr8pcH0pGgYv6pFObpc2vnwVTfmEwJB8acs9ZRzlCLmKpdKTrroiitmo66ytJC+DK7faUd8l+eYSp4TvGPa32ZGTyZ7croQVkre0kHuq1Dxf8X61DnvrEy9e3Km+f+QpzzDdF76rxHwJp+fh91sgQH3JvndhuetivkR8ku3In45pAnBY7QvQtqBi2GYxVW4e4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCZQtC4oyQJRui/y907KL5Pz3BlrdTiKvOq2oQysoyI=;
 b=xMSmEBh/AZnIhN372ZqjWnUJnZQtdpGMrk8FHZmBS06zPOULUqeh04Nbkfs1vstLtzjjO6k6zP4cEKjUJtF9pByIssLh1vavIUiJUiya8mB+hYyBrzS1e2ztASlXq74teMk8VJjtDnna8XUwnieTQcizMxMUV775niwjWn90azFuw34N5Ea4a93mpZWr1KP5L41i1gP+uecUNNyBuQNKUX+whJX6dtt9qZTULDrVlU59bBF3PM97L9E2LftR34mtCCuV1UplhqXQaxzUe0PURuxsHX3DJvUBmYEpDpzslnVH4pb2TKpimuanr4T1OUOwDKNu6LobW/8x9Cd5mCrNHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCZQtC4oyQJRui/y907KL5Pz3BlrdTiKvOq2oQysoyI=;
 b=MkdgWJfdU6kEaf/aimemJVnYSfIchCwZu8clw6eE3hVSraHyxsDVbGi5C9LMNL74WjY12yontbS+ZwvncBeicg1yaWH7tadHrgnd32x7OSk03iks0t0Ktpa0ABfbpDLDSAXxQVZnYOA9nByIClDWfesLNYxXDJYFttTsYfytEcY=
Received: from MW3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:303:2b::28)
 by PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 04:38:13 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::bf) by MW3PR05CA0023.outlook.office365.com
 (2603:10b6:303:2b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8678.23 via Frontend Transport; Mon,
 28 Apr 2025 04:38:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 04:38:13 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Apr 2025 23:38:10 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/userq: Fix unreachable code in
 amdgpu_runtime_idle_check_userq()
Date: Mon, 28 Apr 2025 10:07:54 +0530
Message-ID: <20250428043754.1125751-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|PH8PR12MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: a2349a54-8c1b-45b7-08b3-08dd860e7c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjVlUnZ2WlRGdURHSGRuVXp6TjY5QitpUElkaFoycWhBcjZBNEZFTjhRNllt?=
 =?utf-8?B?WlROODRLNy9UTlJVYk5sdFROMk5zZnBTV3dGa09NbndaVW1PMmxITytZSyti?=
 =?utf-8?B?OHc5a3JKd2ZoR3V5UnJmLzhZbk04L3pxTlRhNExUK0tIOGVsbTY3NldLdG5q?=
 =?utf-8?B?b25RSVlSU0RnalBSMENTT0NpUTdreTYvZXk2ZlJyb21PWGMxd2IySk13blFP?=
 =?utf-8?B?QlJOOWE2THRvQkJBbi9JZEV2SGZ4amxiUTJFVE9hbWlZeWlJNFBNWUd0Z3Ix?=
 =?utf-8?B?T2hLNTBUN2Zjc0Q4alpwL3ptT2ZKU0xjRDY5WnVtb0VmZUJrZDNsYXFvcTVj?=
 =?utf-8?B?U0pnQ2sxMTU1VUZYLzRyNGF3R3UzV1FURFg1WkhDeXZ1UWphcnc2dWRCNjU0?=
 =?utf-8?B?c1VJekZMN2w2TW9tMUFEdjA1cmJWZWNkK0pvTTM3dFJIaU9lNnNhY3NwNFBO?=
 =?utf-8?B?cEVWVStnZDAxenVzN0p4K2RkdDhvdDEvdjEwQWNHZWN1aWdTN3JORWNpZHln?=
 =?utf-8?B?ZGpJV0ROVy94UVV2MVUrY2k1aDdGS1o2RVVUWEUxMUwydi9jZkg4bUxibFBw?=
 =?utf-8?B?UmlnZTdYKzJxdzZUTjJaV0ZQaEUyZjBRWnhVWnkxeUxuN2N1ZUQvQ2dpcjJI?=
 =?utf-8?B?YlIzL2IxMWpaNGtVN0wwZlU5Qzk4NjNGc2JmRTZKcUxzT3MzL3dCMVJmY3Nr?=
 =?utf-8?B?bWVZUW1PN1k1WHBaR1hmbGdaYWtkTzBFeHVEZjdaV1dRR3o0cFU5YTU5a21a?=
 =?utf-8?B?aXZMbURWSDNjMFBRckNVTUMyU3VhMEFRY3d4OW9QTE1Kc0szTm82L2NhU01I?=
 =?utf-8?B?QlpvaFpuWFgzY2lIQ1hBS0xVTmtvOUY1ZXBxTWx0Q2w4MUNzc0FTL2VEMXU4?=
 =?utf-8?B?SVI2ZzhONU1ZWi9FV1BwMEJ4WTlUdkU0WGpjWjMrd3Z2SmRTWXArYjdZcHBU?=
 =?utf-8?B?U2F4eFl5dVZNNU81eFluOTV4bTFzaGJYT1RadXdLQWRCSmpMUVhEeGMxMk81?=
 =?utf-8?B?RWhKdXJ2ZnJFTGNKbzlhWnZVRDZUWk40b3lHeVJGZlhDakxTVzVjM1lTbTdK?=
 =?utf-8?B?ZG0wNkNpOGtkSGluTkdJOStDdjRCQWM0UEVFL3RPblJxRG9NbkR5NFpFVDNV?=
 =?utf-8?B?c1hBWDhzdjM5R0pYWmNZelNLRDk4NWFBZmNxbTRKMjgxbUozaUNDOFlGU0wx?=
 =?utf-8?B?QkZ5eC81VTI5bjZiNTBvV2pyT0NRZk4xNHRsVFpFUTJvQUZGKzFIbE0xcDlB?=
 =?utf-8?B?S1orNEVSbStrbXpiZFpuVWg1NnlGejJPcmxwM1FHcmZ0L0ZOM2dKVE9OMWRF?=
 =?utf-8?B?aGhYUTFvUjhiM3gyZUszcmx2dEE4OHRwek1GbDNtTDBpNWREQVNsZjZ5S0Uz?=
 =?utf-8?B?TWhHUm9lRHpoTU5XdXdGQ0dRazZnZk40QmJIVnNnY2k4MHRRQlJpdy91UUY0?=
 =?utf-8?B?Q216cUkyYTlseEZLUkY5VWFoSEdUMDRPMFRPM2tOZHlFS2F0Y0IwMzZVYld2?=
 =?utf-8?B?R3dtdHlkZS90MmpkVlZ1enlueCtybmE1WHNqbUt4UEdTeWtRUnFXVDNFQ3pC?=
 =?utf-8?B?alk3ekgxT3lKZHRQd3lRanRLaXBqVW85OVBWblh6cFVJbkcvSTVwSUxvRnA2?=
 =?utf-8?B?ckJaWmd1bUY0cVVPZ2hWKzBLNjJSMUJxdjZ3R25oUURMMkwrVUVsTjFubTEv?=
 =?utf-8?B?VmxJdzdPbW8xODRXeHNtazZhVy9VL2o3cHoxZUVBQXgwVVpvbnFZaGdOZkM1?=
 =?utf-8?B?OGwySzJvaFpMOGprTDdjM01KZGJuemtGaFMvcnA1WERQZW41LzVFZHM3TWpo?=
 =?utf-8?B?aUpET1dhVWRuRUs0R1lRRVZGa0FySjBvaDkrcllPOHMvRWVzNEdTRGZRT1kw?=
 =?utf-8?B?R0RFUDNRSDZQZmc4ODhCTFNvaVpDZTB5c1N5Tkc4MWVNVmorbHhURlh5TXZI?=
 =?utf-8?B?T2dwZktoeFNmdXYyeVhPVGM1UjVHcHJ6d2xhaThRZ0VWV052RkRKaFNWMkRF?=
 =?utf-8?B?TFFINDVlUE1zRXdtRUZCdi9ldjV1NG53Vm1pNzlpMEZEb0hGYS9PQklPd3JK?=
 =?utf-8?Q?LEHUG2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 04:38:13.1804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2349a54-8c1b-45b7-08b3-08dd860e7c87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868
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

Changed the control flow to use break statements instead of goto to exit
loops when a busy user queue is detected.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:2751 amdgpu_runtime_idle_check_userq() warn: ignoring unreachable code.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b9a1ef343c79..801603510d56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2749,13 +2749,17 @@ static int amdgpu_runtime_idle_check_userq(struct device *dev)
 	mutex_lock(&adev->userq_mutex);
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+			/* Found an active user queue */
 			ret = -EBUSY;
-			goto done;
+			break;
 		}
+		if (ret == -EBUSY)
+			/* Exit the outer loop if busyness is found */
+			break;
 	}
-done:
 	mutex_unlock(&adev->userq_mutex);
 
+	/* Return -EBUSY if any user queue was found, otherwise 0 */
 	return ret;
 }
 
-- 
2.34.1

