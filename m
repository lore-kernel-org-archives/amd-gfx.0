Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B20C2BD09
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 08:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D2A10E33D;
	Mon,  1 Jul 2024 08:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4IgiiKrx";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE5610E346
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 08:11:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOuyid/72W+u9o/93T1lGtJgtf+6EszVrPSDb4Oy2r8jFObWojEMWr2HSFapvkPmvb5DBkLiZhB8fEl87V4Sv4cXVZUDCZ00VG4eiBO9ou0AFTVtgWYBGIrzDVtmNF0wUQWWzet+AilW140Jjh0I0XuuW/R6GBw0GSJ1vpz20ImWUizD8yIERJutZjVZX4+4VNuEbmAnp/IgwfgmYIK4csyAAmM6ZNTU20/HXtpbgcehK+sQdICOMNXXsaZROkZK0MB6cIpmpIT6IobJvbk8A/C0Le0rPG3u1Lw1cVoUKaOevV35kJyOL+T3a6YLeMyxzIKjC/BRikUjDdS7UzxD8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGm/o9SuKGi6Zz2630J+H83ofFr3Hp6J0s/WKAllx28=;
 b=AnNd/Y1gPU7WRFKiDzNgkzHDbpJ2UMnF9WRToL2iwAwpDyS3Ratdc4kp6VwVnVRza1RYBwWoEcpfg6c2rzKWB1zYFOjcEqbx9/cix5ZasKny1/+uUkoOVSe6Fa/u/AyrKqYCEjTmUA0ZRQxsSTnilmlWj3esuJSJH/CZA5vxvg361VeSWtv6/ZxaShWFAhn4P9U3g/rl7FB6lIbw4Fl26sbkcWHdmhm6e86UQv6AnSbcKvnzlJmW72G8vqVQYZUSoyHfVHm3ono+vQpU78c9dBGKHN13h7Wiuf4Ve4eMgJvT19i9SEUeZRqID/h5Igjz3C+j2R2jZKNeUXSgu+GcTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGm/o9SuKGi6Zz2630J+H83ofFr3Hp6J0s/WKAllx28=;
 b=4IgiiKrxsiD5REBaqqaVoNO7NsDMGwuUfDZZmLco9OlJBBc1gtS7hT4g2RwqqLoTQKDse2xDQeSRlZBaS2a+JqR+0Em86kTJnnpJrAgE4uelf5Mx7rrqtOKAw4//pxoiPtIWkK2XTUcsXUe+8FEvLWtWeuskFqLowoXLuHzerT4=
Received: from SJ0PR13CA0215.namprd13.prod.outlook.com (2603:10b6:a03:2c1::10)
 by PH8PR12MB8429.namprd12.prod.outlook.com (2603:10b6:510:258::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Mon, 1 Jul
 2024 08:11:10 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::b0) by SJ0PR13CA0215.outlook.office365.com
 (2603:10b6:a03:2c1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21 via Frontend
 Transport; Mon, 1 Jul 2024 08:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 08:11:10 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 03:11:07 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: sysfs node disable query error count during gpu
 reset
Date: Mon, 1 Jul 2024 16:10:50 +0800
Message-ID: <20240701081050.21825-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|PH8PR12MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 286fe2da-57d4-40ad-a172-08dc99a55e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0nMxHdTHRvCysvUrdNaThv67H1hEygv34fzdq2RrzKC/fd2HrmCJEfDRvzAd?=
 =?us-ascii?Q?aQGMuXyofxKYST4j8Mx/xcJ9SrzFF2uEizTr5RSltrbwQhlJKtM23+HcKBXx?=
 =?us-ascii?Q?7UP4XB3ZRITGP+lyqHSiFqGE3nkt5QDURKrPk/5nCwz1vCXe3rVbUc6byFnK?=
 =?us-ascii?Q?E9dlRSBGRHKSMSdKQByK2e+Ih45m41BL84FfKFgpRPo/wXBW4N7pHaJrUwVw?=
 =?us-ascii?Q?PQsOs5ePLOEetD8UwBtPKawbNs3Udq9WAwh+frcLzDDqRawyjC91dmrjGKJG?=
 =?us-ascii?Q?+cdcxahI/9Xq+hFHVYJI7jYs9SPTBWOED2qoRBn7w1vSMo1+KilAAQI1k30M?=
 =?us-ascii?Q?sTM8HXd0JUtx0clZM8SXReWbvme+r248rt5qcjI1nllwGloaFVe7UB5HwN+L?=
 =?us-ascii?Q?daAmBVjkDAF0bDJK8nlqUAE3HODWu2dSA7m0OlMcTe6RZzKpBn1pyLI+GUyp?=
 =?us-ascii?Q?qRZMmFpL9QRxKk/g8s5zr6rbCRfm/Ha+DsMPacRdNMtC24k7bFutpia1kPPr?=
 =?us-ascii?Q?nJk+rr8jzqzFur4thF5SFgPaT8wklf3hZ9koCCueJiM5srHw3uxKatattQaV?=
 =?us-ascii?Q?DL/pb2KNanHwhjkFG/I4P0NxAp5HSn/psuOGiMFLK6ySZt3HcR7J/Ep3WTvs?=
 =?us-ascii?Q?T1LHt++4WK2lqZCRPNPoQRcXaMqv5qphlvQy7wu3hVv7484Gh5PAfr4/xTIT?=
 =?us-ascii?Q?TC0yZ03PvdBJfAfxnUjVqAP/0MBFBGUG4nClBMFQrGQSto4VVdqzrGzfUu6Y?=
 =?us-ascii?Q?lsh7l1TVtKCiEfzZ6Au73J0A3CSHO3smymmcFPIFz0R02we7N2hDUHEQpFqg?=
 =?us-ascii?Q?Eg+f4t/Hf7Jb08Skr5Q6AViuTg2+VwGimm8OU/yLVPP96lXS0v+0UdASSRUl?=
 =?us-ascii?Q?pRbRz4dx13aPPU/pcTSpV3ntViUPKs7dMuwvoL1kAR+6+Wo8gKBAgoty+WB4?=
 =?us-ascii?Q?iL4R4nb7COrrgKJLHWJYey3u34aJxT1Vdo0bWVKXYJ9tCn77Pnx92nfvtXeZ?=
 =?us-ascii?Q?zzcPYIew53rNAc4xdK3ToJizYG8Avg8EaiLGpfFUUM2dMnSozeIYkUsUDYNY?=
 =?us-ascii?Q?NYaQvpPN1do9mUfCszCpxB1aquMttiyX5XugOwRGB6fbjwgZlDBrx0wJHz9X?=
 =?us-ascii?Q?QoqNaWA9etTGvDx7BFqL+I+tx1abXW8GXTEJmZb328PHE+DCm6egp2tlavhL?=
 =?us-ascii?Q?FzxiY5miLnqaOdKkxKOuwyHGwDMf5SPEyajnaS0qwerSF8qnTW/ciS0dfFNh?=
 =?us-ascii?Q?ofRQpPzeWqYQWtTZ/e/SpbIYiHgFr6gFyc+XXiEbuhl2aPF0By68rceC1qe5?=
 =?us-ascii?Q?r+I4//xiDrC+yTOEldaIrj/ql76Mzb/DsHi0WM9JZpxNhbzegUvqOIcp49KY?=
 =?us-ascii?Q?5zXPYIemqMGU6Cla39lnHWG+52OlUkMFN2KGGfGGJd056Yf/6oDIPny5x5Oy?=
 =?us-ascii?Q?N93GkIuaUw/cQ9Eaccnn0Nk2sWa5qD5d?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 08:11:10.4220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 286fe2da-57d4-40ad-a172-08dc99a55e04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8429
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

Sysfs node disable query error count during gpu reset.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c     | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 3 +++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index d0a8da67dc2a..b0f95a7649bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -316,8 +316,6 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.late_initialized = true;
 	}
 
-	amdgpu_ras_set_error_query_ready(adev, true);
-
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e133a9982a77..41689aa24e67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3157,7 +3157,8 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	amdgpu_ras_set_error_query_ready(adev, true);
+	if (!amdgpu_in_reset(adev))
+		amdgpu_ras_set_error_query_ready(adev, true);
 
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ac7ded01dad0..e2abc04112d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1295,6 +1295,9 @@ ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attribute *a
 		.head = obj->head,
 	};
 
+	if (!amdgpu_ras_get_error_query_ready(obj->adev))
+		return sysfs_emit(buf, "Query currently inaccessible\n");
+
 	if (amdgpu_ras_query_error_status(obj->adev, &info))
 		return -EINVAL;
 
-- 
2.34.1

