Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62CFCA0EDC
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 01:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D67710E26B;
	Thu, 21 Aug 2025 01:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a6QOUZVm";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE1510E26B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 01:41:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHfIeEFBHAxPcaxtVobvpfboCyTfmtMqt4J0DY7+/jJSuOSe33/ZPxEqQNvE6SNw4z/U3kubahuX59TvpmciqJpgcqBL4+RcKSVXyLAx9KPSXODfTJ5CCe2/hd/oDKo97ztUDE/38Hmgc6R4p5QNAfWI7pRi2fCHpe7wRO7/FlRwktOz1LPT/829/Tlc/Z7kIgbNMb3AH+IkKWXtRNQ4PqrzwtJCrXGRu04VmDtGXEU1FuRRortfqRHeGYnzUsFyNo3tNkvJzYw4/yoF7fhDSTgYSq4xRYSX8BLLcWMMXdT4tqfE3pKtVQCLEBvryY67t/9y53nJT4ALWSBk1D94lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDODB/dVZvCaF2BJ0EiCcrH6SUvQbwa+9imZKu1wnOw=;
 b=IvkJyREVCwJ/ZF5xdVO9O71S5vQ2kWq0jdZU5iss3XF1EEJlkSzXNOGmgYXHRuDzool+2JS2Pd63m42YMOxkJBPo6AYJuS5qOGyluEY2Hnd8chtYXs7nhsLT8z8j0gFGbxIGAwGDT8LK/0sicRmY8WmXZerU/lVNAndrYToHyXhzdk+MnzZ3uL/8PX6SUgJgfIlJ9uCkpHaLb82UCBfzJxg4u0rfPdR9pjdAgp2ZYPx49ReaMLVmViPH6nlH7FiR/TlweBMDvoLtQ7XRvNlJBq5Ab/XPflxo2QuWqZJ4GTsN0mmWKrADl8zoLUPzgEAGLu8RCNK1FqEpH5x0HnSm0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDODB/dVZvCaF2BJ0EiCcrH6SUvQbwa+9imZKu1wnOw=;
 b=a6QOUZVmiiNws+wEb74sZQuDmC9GsnNw31Br/+thIDzw6VD7T3aaEPGZZ59pq5RdWhWiB1WrvtodRdhSDxjPfg6fC1M6zMtLNlWaS3PbkDaut9oCZz2w6RTqUj2CSnNzlVFKA75YgoJLYcd2iGF8+oAtpF3jhMMXdI9fJtN2Vso=
Received: from BLAPR03CA0149.namprd03.prod.outlook.com (2603:10b6:208:32e::34)
 by IA0PPFFEC453979.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::beb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Thu, 21 Aug
 2025 01:41:28 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::d5) by BLAPR03CA0149.outlook.office365.com
 (2603:10b6:208:32e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Thu,
 21 Aug 2025 01:41:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 01:41:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 20:41:27 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 18:41:27 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 20:41:21 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v9 01/11] drm/amdgpu: Add preempt and restore callbacks to userq
 funcs
Date: Thu, 21 Aug 2025 09:36:03 +0800
Message-ID: <20250821014115.566598-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|IA0PPFFEC453979:EE_
X-MS-Office365-Filtering-Correlation-Id: 123f7fd5-1b13-447c-048e-08dde053d8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T+fGKfJUjOg5M4au4AxhNVJUT+PUzzqjJueLUaELn9x/59qD0GdHSMQCWKTg?=
 =?us-ascii?Q?YRMj0OcNqNqiZj7rbppBpfCgEKnBsmg5ujpXKZv5AvEk72RbD9EiHbqGmXde?=
 =?us-ascii?Q?LeTXBM+kzKFAX5Jo+KSJ6qb7+b7BXhrjGzQo6Wo1k+0hRoksF65lmjGPWdmx?=
 =?us-ascii?Q?0/c3uMkeqgU4sa9dXlOXiRjJ3jo2lEmtATvzVavG96ghRK0/SMlNmQxhI6Kc?=
 =?us-ascii?Q?IDO8drmOo7lkNG9xSOiS7wD+dwcrTkBgL+/Uav0PBPp07fD0s44D3u5GO0m4?=
 =?us-ascii?Q?HiVHjDORB5uXLQnqECbuEbwuzvsKX8DjCddKZ0ZS6/iY33Y4NjrYCjRuRhDG?=
 =?us-ascii?Q?azqS0vwTyCM5PmXOeFSg5un82WygJnrkgf6wiZAYRQ/NVXinxr8q4qT1BpZI?=
 =?us-ascii?Q?l7qlYmei7cvlXRix60NwdkDS1ikfgWJ5B9PDJM1HxxOP1ENGzLLToXD+uHNH?=
 =?us-ascii?Q?ObljHJI1Q2ptmKoa9+wQauGnQc846tBu41mGXyBQP0BsVuDzI0VUyRtZTgFP?=
 =?us-ascii?Q?1Ii3rYhhPN5pQD4acbXUhfSwxuZRCAGdY0CtvNYWZDgp9EVCFTe/nTurMYt7?=
 =?us-ascii?Q?GcWAhzItb+ibrZVHp3Cddw5OprqId3q+nTFJhl6gSN5N9U27SY+UDCsNR1fN?=
 =?us-ascii?Q?Kx0QcemsSTqUXBGHYbNAKf5c2Ds8GLrfp9jDs6TclGgsn0n0sBw74Y05AJWN?=
 =?us-ascii?Q?CkpcyZFPzwXD+ZSxgDWNelc+SJN3GesYpE18+i1AIKFuYaGM7QMhvzMaDR7v?=
 =?us-ascii?Q?PubLltV31KCF/Qyu0f3HuV4ojPBowIGhnDHuUJv7G98l5qr4Muj9/hj6ZZBN?=
 =?us-ascii?Q?iG3uTfshmatI16rnTy98wv1MjWMYo6GoWvkbtPJwi6QHEUIlULx5quCJrF0P?=
 =?us-ascii?Q?AZWXVEiDG3DSeIWSmuI9/kSd7cwROkeGXm2yPlnxzUtISFukpz7rME3sZSGy?=
 =?us-ascii?Q?Xh8cThxr1f8MERz0ybbTW0oUWcrdevEC8nJKlqyGbiFVrRD02UGG4vtd98+t?=
 =?us-ascii?Q?y0FS6+vUGcdhKmrppCAng7Lb3MRdKl5erFlkGJ+xU51+BZXnPOIW7efr3u7h?=
 =?us-ascii?Q?tQbUJszD/EuvpMasoYVH3RCHD3bKDR7WrhtCBGO6PHhjn6ZFYA8+yMe9CGf5?=
 =?us-ascii?Q?23GN/VuG4/dQ8pkeChczTxvWcfzvwq8MnosM1SjZJN6+vleYxmUuD1kE0Gud?=
 =?us-ascii?Q?7/4OErSl2DWRn1ONu1eHzZxBTxmvdKy8An2A6ZaM1UHEpPS9Uo+WaCfcADTB?=
 =?us-ascii?Q?Y/0Ww+kum1PhyaH0UVNKtbrlO6tsRzHxm4DsjhTZj+b30TqndnWag3zzzjHT?=
 =?us-ascii?Q?WFP5iz5mlKZua1UWOh7gw9snBT3Arcq5qz8AP8dVeBZHXyLVNAFFAQ8zK9Jx?=
 =?us-ascii?Q?eBngA6sjn9ipTRg/eaxLIFfqgBs0n7HUGKV2FWNxZapzUzBTnqEQ4iPG5ZVI?=
 =?us-ascii?Q?d9afMl4VlccMwuXoMx8nTFw+Z5esml0+i4ZM/emhAa5nl0ibjVJ0WPHDdVT0?=
 =?us-ascii?Q?CjTNW6+Rll9GxTCNRv40FarmCxy1aadxvp3/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 01:41:27.8405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 123f7fd5-1b13-447c-048e-08dde053d8b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFFEC453979
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

From: Alex Deucher <alexander.deucher@amd.com>

Add two new function pointers to struct amdgpu_userq_funcs:
- preempt: To handle preemption of user mode queues
- restore: To restore preempted user mode queues

These callbacks will allow the driver to properly manage queue
preemption and restoration when needed, such as during context
switching or priority changes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9..5111d7dce86f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -77,6 +77,10 @@ struct amdgpu_userq_funcs {
 		     struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*preempt)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
+	int (*restore)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.49.0

