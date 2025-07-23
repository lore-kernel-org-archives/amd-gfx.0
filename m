Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5C8C83F17
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 05:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37CE010E08B;
	Wed, 23 Jul 2025 05:15:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iKctGtVE";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D436F10E08B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 05:15:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbzkb6jytL8DahRVNNCY058cYxOY7aGYyKS/p6wG/UGmXq+692BYEoFFXvcRWBHtczdCSlAyYWC/IiSJr62zE1ne0SV+C7DPx1fIP7whzsv/PwzSifBjcTmb8JJOj3VTVqFneDYRJpm9ZvqFoYNcc/eKP497Lz/XUsVrpSlNbG9roHfbBZt3iO2mridmnS9ipyEkRHRRBHXS4pL1oW6FhuPi34NduczteaWmw0ZSmIYxI+YDswCRiwTnBBGGZr2XzrhVCOIQFZ6Cshtj2hYMC6JYzOlbS6jursTrlgJR1xm8R+tCiNrJuHl3zjXaC3535Z0aPcVUYl2CUXdq/Lls1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Gx3qI+kEVk3SN1kLwBjp5IOUWnXy9jNevT5Aj3ETpI=;
 b=NvuKkgzvJiHe4vHvitrxwIZQc6xt4z6nyH7WRZE7KNiBa9Qhbb1Su/zSROHensSUs+VcJTuuyeBArDBa6L7903peZkGa0/7vLq7DekVIQlNfA2XA8mMDlQl2R/GF/XO1DD7PWeE0hnANEPZsrMTAABxWx1zLCtJYezhBFRvMy+RdN+c5zSmj4uxSueQpaV4CJPzFvbicROR81dYEL3oKuTf4ZEdSFQetA7vjbNwkaeEB6+/QBbs2YlDNpHItjfp+tmCPPRlbE9jVZS69pgR8X3By8LMZbde5/vERw0+MfGrOqamSpQTGWfU8NwEgXII99GM6yGhvNIusXo5ATT2LQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Gx3qI+kEVk3SN1kLwBjp5IOUWnXy9jNevT5Aj3ETpI=;
 b=iKctGtVE4XbTjzzJfnstO1a66wZg5piA3UMoAxSrQZqSNjNCogmgShV1pWvoLmIrCKVFK6TbFSxRhj1ikklguFD5Ks1dOsLBtky6eI78AJEg+VnmQeHiR9WbqfuAfbSwQ8gMUxFzsODnBbvoF7/0zDnqhVOPNMEQ6AXqhsZt7Y8=
Received: from CH2PR20CA0008.namprd20.prod.outlook.com (2603:10b6:610:58::18)
 by LV8PR12MB9336.namprd12.prod.outlook.com (2603:10b6:408:208::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 05:15:51 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::85) by CH2PR20CA0008.outlook.office365.com
 (2603:10b6:610:58::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Wed,
 23 Jul 2025 05:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 05:15:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 00:15:48 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Log reset source during recovery
Date: Wed, 23 Jul 2025 10:45:26 +0530
Message-ID: <20250723051526.1596437-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|LV8PR12MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f64deb-a43a-4d98-63db-08ddc9a7fd9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CzoomBfrnGGgM83SbrPc26gAKZBMJ3ESnYj7yQ2hJe+NPWeecgXJm8ozVp/6?=
 =?us-ascii?Q?G1AY1nKiQR0zPpRwNGnRyYhihlDFioyhH0Mml15dQwWO/suHSg6tsTTQFx2Z?=
 =?us-ascii?Q?RBpr07igqu5F8EJMmry/+A48BthLs6mfQeXjfStXWlAbGv1yQYXfPnD4oQKT?=
 =?us-ascii?Q?WLkEc4itrP+a6nIxNSbd8pc5U8mFmjLmtFdtRHytzaDWLsKHOf8PQl7mPrnv?=
 =?us-ascii?Q?taY9bsTLWXGAxmzHw0VLOf0ayGPj/7xy8XkjIHmt9atN7b+qYONta5Mzz4P5?=
 =?us-ascii?Q?Tk6z7LF4b5/Qd7mWgVsTcB7Li5IU+ZtbzfCgW3jMeIAwlMmJAQP9OyzY4vWM?=
 =?us-ascii?Q?OhS0M5HJvabL9u7/z9B6hK/qcqN1/x11sZrUlGmf0n1HLyEIE5SQySUtZR6p?=
 =?us-ascii?Q?Y9E1piTfkiQf0YOcFDvJDBw608jVLbe5kPYmrrg0qif5X2L9JmPP6fEEyh3W?=
 =?us-ascii?Q?hs+Tc/r35KW9M6NSfvnV8NW0ll2Iq+Rj2wWGGyFIXMPL4dmCapKwmsNiRrJE?=
 =?us-ascii?Q?Ig0mcolrbBjodiGpupTJYnOvhUGX6bDwC1YvbC2+e6NMEBwms9Zs1FUd3D5v?=
 =?us-ascii?Q?Vb25aN8hJcprvG1yZ8hKd+wTN/n2UObiZvM0UvMpUORflopZiypVC13+AZMb?=
 =?us-ascii?Q?5bHblo19BxVCZ1ta+dw+RuzPZfSBiN8C263oYNL3+73LM2iOdKDVfx0DO3M8?=
 =?us-ascii?Q?x7AUOyUuhrnNhfuyA0ZY8TpDflkpQ2BOwCtfZNPA11jaIcXvpXWeb/JSfdwj?=
 =?us-ascii?Q?27GNf/p7gQXfwpnuA3uzkEDCCaWWeNtYz/9wWZaAzWSx54CkGCRtX1lQASzq?=
 =?us-ascii?Q?jAYUmyQxglWn8kNrYj2XDW9hz5E1bJoXcd6AXodfe76dFi8DCoPujDuGhXyS?=
 =?us-ascii?Q?NtDs5ACZNv666LB1eYEmFwlSAGEl96k+3QDXBeu0I6Ji0Y6X68J90wRW1TVQ?=
 =?us-ascii?Q?5wNerkgHXr0PKv8hZFKzsJPo0HJZUaYmIZjEskmZfmny7VqCZda0usEvJkq1?=
 =?us-ascii?Q?ZWEQLeT2Sim+SSOzG8RDDn5VmyvLlfPvOJ8mFnUs3CiSdMhjRhka3OFOZlej?=
 =?us-ascii?Q?uhf5/cWhy/leq5NLsF9tJGyxj2KrGodCLIIHlr4UdKWGjBqVuTXTDtmP+LDq?=
 =?us-ascii?Q?6HEqO6TycDStS2DI0v1csp+BZdArHYayklH4Gz5ZzMPaDRTyrC7efrj7hCoy?=
 =?us-ascii?Q?b4gILa+ODbxoUDl938dv+b3SBCc5P+Y6DFNcy4BjC5YNt/RD6XZLrMK/KSnO?=
 =?us-ascii?Q?z+2A+6O6lXw5gF/h88DZsvbJZeJ8WkSRDsDd76XVrEqTEdSWruesu7ab5Udw?=
 =?us-ascii?Q?LfXImjJBHB/69m5uTc+tWOfrdYw+FO1wE2oYcCRmcXiS/RRmT4YrhDVMwGRV?=
 =?us-ascii?Q?liauSEBEG2gILGlExGvujlDp1xjDl9GhEJBtIBWTpBU6DYJamhLZsB+crRbQ?=
 =?us-ascii?Q?bEKMVhOlHYJuWRgu06DSKrgUR68HTOJOPBGD+bfJFw+Ogol/BWdj9+M+hDnV?=
 =?us-ascii?Q?7dqIK+ylfZi8tjkuH/m10qlrt059eGfj7D2U?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 05:15:50.7643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f64deb-a43a-4d98-63db-08ddc9a7fd9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9336
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

To get more context, add reset source to identify the source of gpu
recovery - job timeout, RAS, HWS hang etc.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 685cc602357e..4fe74341aa13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6442,8 +6442,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		emergency_restart();
 	}
 
-	dev_info(adev->dev, "GPU %s begin!\n",
-		need_emergency_restart ? "jobs stop":"reset");
+	dev_info(adev->dev, "GPU %s begin!. Source:  %d\n",
+		 need_emergency_restart ? "jobs stop" : "reset",
+		 reset_context->src);
 
 	if (!amdgpu_sriov_vf(adev))
 		hive = amdgpu_get_xgmi_hive(adev);
-- 
2.49.0

