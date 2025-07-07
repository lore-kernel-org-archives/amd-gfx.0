Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CC0C71130
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C2A10E53C;
	Mon,  7 Jul 2025 19:04:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R8xWjGWM";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF8AB10E533
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKiq5dcUkPlFgF6hslJn/WxGER7/C4aii/YrngDgp+eWyH9CaYR9/XU1MSbB8k4FU54bb8Tq/hBiPisCYysvncH5VM1lYcybYKE4rOGxX+gwls86mmydIaLULq4YABh0MQxXYxv4dvz8mDhtQ6ZfPbtTpwtVxQ8XZQWBQnuMImJN/A+h1SvIe3RM6MxeBAipb4/eBr/H0vz7/iPQM831yI1QH/0oUlrkQWESR3js52XJR//+HEBbSzIocjN2bULgt5CdGVperueBdjhE393GqjPHa6z2q3kiM4pQvxFqeOE00w/4vtMXLElJulAPMFKDeivDdQS4V+KvGO3dmv5QbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqZ1FINP5TvFCQyT0yalu+fAPA5FjdmKH8JaA6APBq4=;
 b=UDq7xQpz3VGAK64rWfoGapfIEGlFQjbqgdzeBqgNXhYl7Q+56xK3j7aj+NaSWRPa99lTTlgeUJwdcC9EuFRMkeGB4/p3IjVHgRWWksfgeogYCHUZiMlKuqlolo9rQRe3twTWpEZn9OfwWbtzEzv8QKcMN/EFrjTmgeirbE9SVJDQXeDD6EsfWKlwzA9iPbhJYZ3O1VQk/hqy6s2rquiNfjdJDsPpABC93idHqdhOZnl1F/UhexMBuWA/Uc8EiwNvp2u1t3vvcPNW/4/IxD2iXcxB6YqzRiPix0SNudrDJpQ3kOfs32ZDYF7P3wYl1LeotwcbJpVhFhHEsZhfyz3LRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqZ1FINP5TvFCQyT0yalu+fAPA5FjdmKH8JaA6APBq4=;
 b=R8xWjGWMuEH1qu9b+jDpLnTrTOeqCAAJf7KjxFsGsUn+QxJmCAhD+NVdtYZ4GLr/1xDTRZu7iuT4bjimSAm1lLN+uKIAVdnJ+KTBIJXIMSNGAk8qf0d3wRBFX8R0mV7BvHEDW5eTLr7Md6r5qVvwBZKlBLuD8gtB2LotbHOyTCQ=
Received: from DM6PR11CA0031.namprd11.prod.outlook.com (2603:10b6:5:190::44)
 by CY8PR12MB8265.namprd12.prod.outlook.com (2603:10b6:930:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 19:04:24 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::f8) by DM6PR11CA0031.outlook.office365.com
 (2603:10b6:5:190::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 19/36] drm/amdgpu/sdma6: re-emit unprocessed state on ring
 reset
Date: Mon, 7 Jul 2025 15:03:38 -0400
Message-ID: <20250707190355.837891-20-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|CY8PR12MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d341814-674c-4f42-2f33-08ddbd891664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e0nVTsmp2qgEHePyVW9IkUB3HtLWUCDd8E0rtRa3vV116bxy4MnxXuwp1ZNl?=
 =?us-ascii?Q?Q2+KqzzVYuBJxToZVOk6kckm0lYG9L98qRXpOw3X+NXsDMi0p2cvvldyvO2g?=
 =?us-ascii?Q?6F3EELkjMeBih8gGoA87oyFXfYWqyF1L+wM+L0tTZEyElm1qytwxSckjbGsR?=
 =?us-ascii?Q?GGXy2gaunvY03Ck6YUtznJ//TLX6mnO1RjyVftAtYCA3Ovzx5scgetatBB5y?=
 =?us-ascii?Q?cy4rsd+OzUEjTiPgypfMcJon6rEx2J2I9oGTX/Ipie7nNwBtNb7grdEPDv5R?=
 =?us-ascii?Q?Z5rODJrIVl9WJ/Aln34kyeP5btmBBTFsoBfeQ7x+Yyce1AsfwuqzCUPTrw3X?=
 =?us-ascii?Q?ghTx3UR+yG7ifXsiskmGrUEAjgFoSlfhPm5m90+UttFY1m1uXgcUATMlW1jI?=
 =?us-ascii?Q?P4rluXslZKt7ImlaGmjGGZ9jJtmRw0AJkIQLU4tHn4mZxtxg2Fr26Vc6CT1e?=
 =?us-ascii?Q?Pfa2lotPZtbCv8EMVDJSWz9tQcpjU/W+hpCYUBt4bhJCK+On3YQp2iikuSzo?=
 =?us-ascii?Q?0R06RmFqKx9cvGwCfqXpeA2tU6Qv+Fr6C7r/BIMXTHriefq/31KQmJgAFdkA?=
 =?us-ascii?Q?gVfcbGVbFiYgzP/3kiNDbHwpsGKhn84fIhO3lOMpYymRI66s1cOcBng6drRs?=
 =?us-ascii?Q?88Tf04dj7bZiZokQYaxpNfD56pwDgzy5zlDkk/gtCH5rF6VmTsYxRJXMlPCb?=
 =?us-ascii?Q?24RMo4JnzGsvUNjE0F3mcDnxUVi3HKxrF1nqKNnXMJMRE+hn2icIz97jz25k?=
 =?us-ascii?Q?ltGtFlblSoP1I88Kk73yT4aNLzb/HgejbqmheUs+J3eGClKhvZnOtHCDnqE/?=
 =?us-ascii?Q?rSqaIcJTzkIGlGnc2QD+sjZem79mT5V3pnI4V3Vr9EY4WIDxeLB9XdrZh0oZ?=
 =?us-ascii?Q?H5IxjMaS/1Y/RkxDhoRPW+AS3L5nDYaQguC9pLTNQHPZRMaNeYfN+m0TnepP?=
 =?us-ascii?Q?+tuwOit8bZRlAduESyqWneYk82UGrxSWERaExHZX30YT+5MtZq/3VoByCfKp?=
 =?us-ascii?Q?hN2ptTNa66v85H/bJPq2GyDLcjcwItyJrq9yqK6mHWVR8ttbBOh2Aj1d+Frf?=
 =?us-ascii?Q?QS0+LIp74wfRR8AHQ1qsakrG7ykrOm1wAbLhMZuJnoFz8lg1n8YB4jnltd3c?=
 =?us-ascii?Q?28n6bQVLa6K16/L3A8ymIlqLGaRI/4MXPKYiSlOim6mCIAWqIGa3vvrxK8kG?=
 =?us-ascii?Q?WsCjPW82E9xSyHA7GQrRtuxHibh97gcWWT07K4Qk8m67jWGEGQDx8AHbG6Uc?=
 =?us-ascii?Q?dSeMT4zwPXZB1Zlb0Ucr4TffLCCx+L4HiSLXG3k4emkqhnmdfPvZNadrHGqv?=
 =?us-ascii?Q?bxUEsjNJmvbMM5qFlvrheNKlV0jYXXwqDNSaQhl6ThIb2jmvZPHItUd7c37S?=
 =?us-ascii?Q?0CGg/GpffKDuh5ma6JGnKA1LGvmr8ZmCWwHnS9KRh+3ZlPdEFukgmj5JSt/f?=
 =?us-ascii?Q?52A8vVZYbQoCjiSChvP8a6Bx1y5gkzDYCwFKFjEtL5VJrgHA3cITG2R0K47u?=
 =?us-ascii?Q?rlozyDlX6gPsdrHJi1FyK95O/7o0csuNJVhg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:23.9417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d341814-674c-4f42-2f33-08ddbd891664
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8265
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

Re-emit the unprocessed state after resetting the queue.

Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 99be92efb74c1..44882cdd8d47f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1585,7 +1585,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
 	if (r)
@@ -1594,9 +1594,8 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 	r = sdma_v6_0_gfx_resume_instance(adev, ring->me, true);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int sdma_v6_0_set_trap_irq_state(struct amdgpu_device *adev,
-- 
2.50.0

