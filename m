Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2026C83F1B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6242010EAE0;
	Fri, 11 Jul 2025 22:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AXYsVT0Q";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF5F10EAEA
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mkn4D6Cw5Rdvcbl704L7ksBV88VyLjq+bFVbDWkkFNIoshZB8sHroUl5YfXctrFaY1ZGhhbNPjCCsrcf+7VeuMzOsldrgQYQSSW6pC4WVxqm1Ya/Uw+aYnmy5eAsP/KD88BzIug9HWFhJmxSN3mghXc14AOEDH9TdAHvKvOiL9BFeCTcV5Cg43oW6NCu1yGagPfmC2xJS1xBfNy7qHRXahY0CaxwiCFNBDoOgZLU/n2m211WCsOfoBgv4wKF7bQBQa0qgmL/M11fE6oEeSn8eaEPYzTzTyOnqS5B1NUqiYEkCdK9N3V1dJ0qT5E5hcwuPv70YLQQ9nCNUwQ/Me4leA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaTlVaRG7jAGJ6XOZ9I8cVofTH7ibDaRC9dcM/O2sPc=;
 b=K7IFcm0FHrNVCAtGvGzMvVLhC3KIGzLvKriEQwGEE5QoAbCW50QAadAGdF+1VPZmGS1J9ImZfvXkwCDzc5hBsJu5juqPxnR3vncg28P0Mc/rOz+zvzogaDlBGviuNt6Vcf5M03kpZ3qWZNde/xIxbYKoh0Urm7MW2J3PgAUF2wCMW0DHvxv/PIpRKBh3e+6yqu8Gh/MKAzNdSKr5ms4Lj5dXyXRRpDPkmrKhSGh0XjA/6jckgMK9Qm2YB/NH/RP/HaJmg13welnYXDqF5lhqsRBghNIXFtKMMdWQQddKZAx+PrmSPDn79iGqPChaIjPb2iGTtb0jvSPRqhtd+bjSyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaTlVaRG7jAGJ6XOZ9I8cVofTH7ibDaRC9dcM/O2sPc=;
 b=AXYsVT0QCDwY8jou9ZBU70ocrgbsdImTwzupbUDPa5K9GECKy2J19lNsXCLKsMqnNFUZpfCn5vkTAIpoa8O+4UMjjDHevWdbB9oHSeyJ1ZyqYY08oNtQddEMTbHIeL0eJoSydhLLtWtI1LgOj5XFU+KNhl3hHPHNWfqPalqtPuM=
Received: from SJ0PR03CA0222.namprd03.prod.outlook.com (2603:10b6:a03:39f::17)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 22:40:51 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::fc) by SJ0PR03CA0222.outlook.office365.com
 (2603:10b6:a03:39f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.27 via Frontend Transport; Fri,
 11 Jul 2025 22:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 20/33] drm/amdgpu/jpeg3: re-emit unprocessed state on ring
 reset
Date: Fri, 11 Jul 2025 18:40:11 -0400
Message-ID: <20250711224024.410506-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: e56d7951-a487-44de-8273-08ddc0cbfd1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T25EU5YnEuJXx548vdeoeU8BUUWCNx5KzYIr+m/SaL6Em7xsyfwbDxfpwdyj?=
 =?us-ascii?Q?ubKhT2XI28HAOFARoEnUNMTjsEilzHg/ZHEs9h0d/ZxKMgFm2p5sV+u7mYiC?=
 =?us-ascii?Q?vSlc5bViFDmNPsuB0ob0W9NIk+494TwZ165oqnoS663WrvG7uPiokxNHyegM?=
 =?us-ascii?Q?WbhmIY6skhv91QHUCEaiWHX7TLDSnmmpNgWFAOQVoEwM0hwz1Jje5Fh9u2DP?=
 =?us-ascii?Q?GkOeAEM0Xw9HC9zaWjvJuDiYMmeSiErLxpvXDBzKQ97AqCjwBAkR+Czhhnpq?=
 =?us-ascii?Q?x5HZ6E83rVz03i6j9GLE6fTUVrbFfEaPQJIh4RXRFK+ZG1yUY3/LHGz2BqqL?=
 =?us-ascii?Q?47RzfYs5d73MSvLO5qN0Sy0pRfYsmZy7i7zAxthyPGe1dEG1UAfr7fo9JKDE?=
 =?us-ascii?Q?rLNRVmf/AhshogKth+Zhl5UWRboNEdjMMBjL+e9w0VIltFc0A7HdV4LzhUK3?=
 =?us-ascii?Q?3QiRO/u7LtWOetMzLBuLhP9Jfzcbf5rtcTUdRq4m/PY+vnQyMZt4LqOn6GRe?=
 =?us-ascii?Q?5QLCVhurtb00MUFb0unihiyfGa9wfhcQxObKHoCfd4LiQHD5p5ZngbZKBJJ0?=
 =?us-ascii?Q?Se0UoDxQptK9DSjdKja2eZ5H3Pl7Nr6//YTg9Dj1XWC4GJcmT+KGPiPKnMJU?=
 =?us-ascii?Q?UC1IQ9zlODN1IWAozeUhxcRsumDLiAtyxLYmzziEBYS7Kx6Q6QQO9X919HOL?=
 =?us-ascii?Q?KUSuxr0TWweGK4KFTrYaNJ7AbF943r+igBbSv4OL5gX2EgNoBh6YS0MeSVME?=
 =?us-ascii?Q?aPDFjH70LxkDB/XYnsT4lK5wrO1UzlDuo6FiBNelAzanSmQfOcuzWuysbFtN?=
 =?us-ascii?Q?hHU73H1mcDHNLi7KCkxT3tRDnfuaV4vbbDie5arc2K7zkqrHlV4ggdb10uZJ?=
 =?us-ascii?Q?10BCWLkIgittSSzup6374PPedO+pZBEK1AK0x0pyviYgQTouU6ZyrSbzhytG?=
 =?us-ascii?Q?1Q3Orm1tsMgEk8fCjfJUgeCGxeiqTKYs23/6j3TEOBxlc14RxpajjfIO3LkX?=
 =?us-ascii?Q?JyNzzjUQvjKd5vfehLF8+/2+afz8xhbGRh7t8eBq1uS74OAVWv5Pc2euOU95?=
 =?us-ascii?Q?bu50bAZYrwxCi1IhRAi/oTcpMkRRWOLynaxoHeidbrJ2h4AVSfOTrhU78VKo?=
 =?us-ascii?Q?zSCxoCTWYjk/xVzT9UZbDFLN80AH2DGRjf3W3BRB/WW3HNRd4vi6AkcVN99f?=
 =?us-ascii?Q?pdD/dKlfLYAzmiA+gMZd2t5eq0ilr73cSIw9DYukRPljwOpsQeTW4nky5Uyc?=
 =?us-ascii?Q?s64UTE5pAIVTrvuRiR3zc4o2seuvEjoQrG+q19NtOAOwCyfB4K7resOJlc8d?=
 =?us-ascii?Q?rleXF7vZPYGY1IrVLqt3VLtfL2lZNB8iIOS0zACHqwpw2duq/voSlWpLxf63?=
 =?us-ascii?Q?TdUaxLYN4E2P2+YgFrm3je42VazBg2ne1j4k5XKn9IrrfRapQmOGMCXM/u/k?=
 =?us-ascii?Q?SaLWNBF225B0/o0FSQXu6YVA2wOyU4rCSxh444pb74hwHqWuRlaeaRe3o7aX?=
 =?us-ascii?Q?JL4a+sHe6+GQW2SwWVnd4Te3wtGxLbhwSNv8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:51.2857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e56d7951-a487-44de-8273-08ddc0cbfd1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723
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

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 5d54c882d889c..d4bc4fca460c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -565,19 +565,14 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = jpeg_v3_0_stop(ring->adev);
 	if (r)
 		return r;
 	r = jpeg_v3_0_start(ring->adev);
 	if (r)
 		return r;
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
-- 
2.50.0

