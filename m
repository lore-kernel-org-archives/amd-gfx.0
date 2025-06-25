Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D4EC7EE2A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EC5B10E7ED;
	Wed, 25 Jun 2025 21:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OsKfHZW8";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3002110E260
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yz+olcPAVSl9tGDFxN6HWDKk7Aw1Y2GNnfbcHulMde43NNVXnj+TrsM3065rr3dLwkJd2R61xkl/jdMiD9ir3FbZAN6YPtoTrFEZvCWPeSX+A7RkM3AWSIOmhitwUhxpSaCrz9RfSSqDlfrFD45iPkVZO64dpu26O3/ig1Vzsl8cMudKskrhCp1LfhoMcRGMVRyiqTUOkdIkvtnLIb93iUM9xpl/b6jKUbTFY8g03YKDRegh1L3TTyO1nUq4/JYOB8+lqgQZOTvAz4XqlE67y25a9fFmqA5IlR4a3W0pHTVOjkBho8dDuy+qmgZaE/YJv9rl8UOwpFanSVwuPlZm0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRdkEcYAFo7gnn2HjHxbcDsbY91GPduySpaNlOixQ2g=;
 b=U7sUHjSFzkdwJFQqsA9GA8DuEnRruJs862orqa5TgoxsciKchhFSCxMyKJY962YxOdIPlWwHootajIhkavNimk5Ilu0rwQL32vvQ8JKllBm1KWRMYuR3p56EYftYG+2kybVsGGgUSjPhFPlAFeTNPcaTg+K7JOhFIOJQGbiVZn32Yp76/nlZ92iWQNUahjVFZhfJJBeMX6sM1j5fkw5zyS77TM+Y8BTsX1VDB6+cuAPHY8l3B9jAqSely8aMQHwD/tFkPW9oAXQO3VmW8FrNkxc+3UtZ9uzFEi3lbQ8db/VBjFKATSRTlFrZqt3Wv6KO5Mxf+BVf0A/RG8B5QpDQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRdkEcYAFo7gnn2HjHxbcDsbY91GPduySpaNlOixQ2g=;
 b=OsKfHZW8q/woYF6ads3R9jthOcJRTGoHd+bJiLiaTuM6rJPQoS16IXHOUD2Ul1ngzKu6QuQ0tKvkTB37Yi7LOZeEbsoc0voGHr7RCaTVihFLCNYIF/u/yocBsxsS8y2hKNdyQjDYe3MbXjU4vi/9/5TEZgT0dNSr+qSVvPzIFlA=
Received: from BYAPR02CA0071.namprd02.prod.outlook.com (2603:10b6:a03:54::48)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 21:07:04 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::d0) by BYAPR02CA0071.outlook.office365.com
 (2603:10b6:a03:54::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.18 via Frontend Transport; Wed,
 25 Jun 2025 21:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:06:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/30] drm/amdgpu/sdma6: re-emit unprocessed state on ring
 reset
Date: Wed, 25 Jun 2025 17:06:21 -0400
Message-ID: <20250625210638.422479-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 34fcd59b-ee65-47fc-d5a0-08ddb42c3c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZSJlRK30fcz7u1rhNxD1sjSsSXS5cXbiKx+CRt0fqfKJOlu2nFpf0WlO0wHr?=
 =?us-ascii?Q?6iI0yl2jN+dUHhGU5YWCaOerbeKL7oKgxCdhh03kLaHqpxJRmd/QHPUYCrqE?=
 =?us-ascii?Q?iTtFo4CGdvzQnLk/mVbQv9auP19YbJuvrNd41vPuNqwx8g/GnWJ1/3+ZNCvb?=
 =?us-ascii?Q?R75obPLBKukrWJVDPQ9pGirNV+l1T7b0tSN2E5uuVRn3u9EyH0HZC5DuiB/5?=
 =?us-ascii?Q?tb3f15cH0YGjCWZG6zkkCKxOauC+wzR6Ip/w4zLmBMZESmfBSmFtwsyfRQTk?=
 =?us-ascii?Q?WaTJWXV7UgXCXfnrNaGFJP+XNjzpyHEChrx7ar0g5NZJ5Fz/7kKIKgLEjPel?=
 =?us-ascii?Q?giDFxjWziUuCLU9rRxgBvoA1qptArk2RgSN2+WRrYB/HB+4EXkI3PRovyhOB?=
 =?us-ascii?Q?7yKAZVmBT2zxtV+fIYR7kaReDP7S9Ix1pCQplXqLUj/pNB2dzVnicWGZGnU1?=
 =?us-ascii?Q?lJZR+HFFfdotU+38pfiovbkn+hl8U1RtfmUhONmZ8D3S6QjDpqAnfK+hZfR9?=
 =?us-ascii?Q?IHiJLYjimlmSQHJkN2VizPucCAB5+cp6RoU9T6kROu7Bki5beTHC6KnsQh53?=
 =?us-ascii?Q?WbUxOpsTLSND99H8BmqV1l6z1Y4J7zHMhwQowURXSInRmVvHg3E8B9Mrz+Tt?=
 =?us-ascii?Q?yGDB4zvzfYFClo/uOPNIjMYhJif+Gt5cTQftQeNKWFW7dlkxccTC3/i9Tp6a?=
 =?us-ascii?Q?54n0FcHD0zrqvQHypsn26oV5W0iJlIpSfvMYF6t4uWzfSpI83hB8qehX82Tu?=
 =?us-ascii?Q?IccfjvkW63dgmXPq/E/+YflCYPjHVrDf71zhpbv+d8ThAZddW/+ENW2E93Rd?=
 =?us-ascii?Q?a0yFw4Ni29F1Y1/ERLTNOeS9nIZAhlFLyRGmEVJvOgY6b4+r+g+vxthg9rFR?=
 =?us-ascii?Q?6UAx6KZOF9s4LqcRXVirhHypAQ15+SFLTHHUn2k4Z4xE9jhNxNlGSHQ4E6Kh?=
 =?us-ascii?Q?dsTr14nAzCyUuaL2EuFaLgclLTsgvIqngY47Vo1kYVtvL4puAQlM53QvVRfq?=
 =?us-ascii?Q?3vISJvm9ta9y+odFpUw3XH/Blkz2EjqUXT6lgFrCUwpbgdCGdObHe6vRdAEr?=
 =?us-ascii?Q?mxFU0OB+tOc4UJMf8GP5hs+ge8yx1xkKI8Z1ipojyDS8aIlCIG6pGzVSH2EG?=
 =?us-ascii?Q?xkv2up2WNcqWUYl7ag0BXOuFkrK915LpxkqROKskCRFWJFYeG3unXwrtDATF?=
 =?us-ascii?Q?Agiv6Yay3qJOif6ojwoIvM8MKA9r7Nnsnr8v/lsCfSaOh6ZGAEAbQ5t7IgB8?=
 =?us-ascii?Q?SwnYNMtQc8VNnYf2Uqv++oOPI/s4zQyaZ1/cQkv/C/qbUc6Iv6rJf3ZDX8z7?=
 =?us-ascii?Q?0QFIcytdYc6OI7F20mI6yOCT1bWAlDbtUendG40vRrYm8yW2uvfS9VSgGTQu?=
 =?us-ascii?Q?cme8cH0NWJby2YiEfAMWpSpqsC5nh1mso4/xlW08ygK3hh8+XY3DgvEDfDiS?=
 =?us-ascii?Q?LNL3e4fF/4+Z+y04jPuA01p7+DpKnzsSNimFwy+pKN6fcsFlfKXF8sIf38Nl?=
 =?us-ascii?Q?kYUY8RcBmo63Mm7OQsqncr2Uoqf9ebzRyIzC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:04.0255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fcd59b-ee65-47fc-d5a0-08ddb42c3c69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 103e5ec7aa63b..a9f3aa8194051 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1571,33 +1571,27 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i, r;
+	int r;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (ring == &adev->sdma.instance[i].ring)
-			break;
-	}
-
-	if (i == adev->sdma.num_instances) {
+	if (ring->me >= adev->sdma.num_instances) {
 		DRM_ERROR("sdma instance not found\n");
 		return -EINVAL;
 	}
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
 	if (r)
 		return r;
 
-	r = sdma_v6_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v6_0_gfx_resume_instance(adev, ring->me, true);
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

