Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F01D1D467
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C10C310E770;
	Thu,  8 Jan 2026 14:49:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PdXsEP/9";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013009.outbound.protection.outlook.com
 [40.93.196.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7FBA10E772
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCQpvQUOSgsrfWgt9mnaC1ArmLWVu9Uuyr8VpELH4zRDRUDaniYL3mEKE34O80DPQ7NoOmPAX78LjbiTgo9mtbSDBL0TgOY0NtsW/GofiUEdMBrEkY6cHWlTNbs1Ps+2kG22iWGYE+IG7ee4vmLNbqgtv/DxO4RBouIHWQJYPocDJDh6hwkIhz9g3IpEwHQk/CnNwpJJtX5+u1qUDFL/qL8WcGa7/KFSlX+Zcylqr/4LjzaIxUZwLa0tQ+5J0av56qI5hMF7SwOyKSfHJYCpf6PTTQQFDXGIMJ7WPWmxjR+MSNoR7vS2u6mLzYGQRAhXK6J9ArRSr2Aj5TB4l2Rlbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01g6EG8+3u3M+JMtqpfevho47aVVSK7OFvVEZWmAaJk=;
 b=TV0823krg9X2VAJyg3+1ehuX28jXcnbB3gISTBfBX0grg7GNmtRXinNFU2C3mjvIi+i2dlq6bF6ZY1Ibzy8l/0KkLBagRbwGwwNcFVgeUhB4xLt7dQ/fiVnzJ+sfISVqmzSLb0yP/OEiIu856jN2HWsbjyZf85TrLOw5pbXtZWWg1WTO2dl+QEZpnmhjMW8cby4FSuflg+Jyv48zCc9LYhtVlskLn5HhjgYEq2A7yyzqOZaIci+ZEWP/uZeKuBf9cgvCqqVWQa5ER88NNoxDEtMVYPjL7dvyilN6tNDVKhgnhyOCiIDgryAHvna0Yw2p4+zawCJb/aeyD9T3oFkgXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01g6EG8+3u3M+JMtqpfevho47aVVSK7OFvVEZWmAaJk=;
 b=PdXsEP/9OAHBHKGE3IeuVykv30zGE++5xmz1gg6qqzgvrDAkD0i0YtHoF/91RuZFDFVBWwnpwpcOt+TzKQ1VaKBC5UrVJFIyQ6HFEu7t6pSgFth2imKLYHBCdJNcmoBeBWtBSFGxfn0rCQ1Xk59MlU9kJXJAfWwDPMQwQxWIHrU=
Received: from BL0PR02CA0144.namprd02.prod.outlook.com (2603:10b6:208:35::49)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:49:13 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::45) by BL0PR02CA0144.outlook.office365.com
 (2603:10b6:208:35::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Thu, 8
 Jan 2026 14:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:03 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 06:49:03 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:49:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 29/42] drm/amdgpu: don't call drm_sched_stop/start() in asic
 reset
Date: Thu, 8 Jan 2026 09:48:30 -0500
Message-ID: <20260108144843.493816-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e4dadf-14fd-4214-146c-08de4ec516c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8CvhuIbvOi0WRhREuKai+hn2XhyEi1pMqUO7tbctigWCSXsSKUWgn3rzjVi1?=
 =?us-ascii?Q?XUzMMXWHob7sXaCbZeP0AeUh85YKvqFqbu4NFt57aDFkLesg6V/+VfrxJLA0?=
 =?us-ascii?Q?scirAKTjbQ+FswpYhz/IL9DV05E0vt1Xc1/C755EiQrnF9WcAYXiHzKS4hlf?=
 =?us-ascii?Q?WQpT2m+tTomq+2Buud93tXJcQS24FttrbHSi3rSGi9ilbL1ongipZ6LVvDDg?=
 =?us-ascii?Q?UkKS1YFKnUke5YeECeWGmyz8XkI2PkkwCmMNKgM+pyP4YxHFVe0IEZzfk07Q?=
 =?us-ascii?Q?PPUXqxjjVJsfzica5b2zYJZJiKLnQ4Wow7/w2qZBq7DUNCLQU9kDcxKGUKEv?=
 =?us-ascii?Q?Dnqe7RR8pkDWTaRAQ68f67w0QUqdHIR3p1EK6oCU/iWqbnobsId6lgPNrbQg?=
 =?us-ascii?Q?rMZiz1FQkIh1dE+YSzURBTQ9hiee8xlFYL1iFYtjsonRXAidTyVR8LCP4t0d?=
 =?us-ascii?Q?Mzn6zOP/gYzNsqbxgWQ1E9PCt348bj7R2ub9dDEwIIeIf+kovKu1TyZaJ7Np?=
 =?us-ascii?Q?G6jhfeWZjaqbBz5IRN0ULQ00YTt4wqTXi5w+oW7Et+OWAV+loWg4IaxMNcOP?=
 =?us-ascii?Q?mOOh53FVD0pJLC5NOyKUAsxeSsQF9YKDIH+1ZbewHRewkJjsX+bJ43BUoDFO?=
 =?us-ascii?Q?xJEqo8Ur/tZR8tJTnzoUJ5TsHUdfM2Ybr3qe/8u1m/7ZU8pZz5XQwUKs1U2o?=
 =?us-ascii?Q?fR4gIYgWRWvjPnf1Pr1Dm7DDYcXrW9CpK55Dr/Mu3Vtw7P5nx+oDz71bAyge?=
 =?us-ascii?Q?nykhTuvQThoeM2DMBCa7iEj8BwHPH7MpIfEvqVwdgK+v0PEQI6qdIPPePUme?=
 =?us-ascii?Q?6B5uNLEZLN4X6HJBnaMItvpSUyafq3TY4A3Iq8znSa3AP86Lekh3gycWy4Jr?=
 =?us-ascii?Q?nXEWtCXlUzxdSHSBWwLf4k7EsnNmdogLrlWvhnBBbFReZMqJuSv7j/PIR2fZ?=
 =?us-ascii?Q?dGUZhPZZXyorsl659KItQuDx5Ei7e+CXoavfGwWr/prBNIhYqiDwGS2KHAvE?=
 =?us-ascii?Q?01GDfYx/5ygO0w5dTQcy/UmUbdod7Mfyc+tl96rw7UzsuYi7in224ntr2UOl?=
 =?us-ascii?Q?qU61fMdwbCGvFiuXNp21yfhoy0zFe+KQa2BSfzbaexdk91kZclnHZrRU1jSt?=
 =?us-ascii?Q?nMTFdbLiKgLkie6N1e9NPSAv4hi2gQ+fGE7hep+YP1N/lKPpMlMZfVyqymHU?=
 =?us-ascii?Q?ZnuwSOOBB/0o8X8KOsnqGPsJlFA4a+LWhC8MkShsy1tmpH+RknuySayNiPzC?=
 =?us-ascii?Q?r0Gf9ID8pBM9j3twclnuDHprQcJmKw+/HJlelpyZskcm5qUEnanlxhuo/4ps?=
 =?us-ascii?Q?VGny0jSfMJ7x3mjugHS88cGMHoK4CSzWgMBF5JzraJyU0dM/uPQYYoP9eBhK?=
 =?us-ascii?Q?5qR77njCTkNb+AcaSqkGBFZG86SsAPF6b4GH8sBx/lZqOPtSQeqS4eMD7z9z?=
 =?us-ascii?Q?bEpd2OYtGBgSkmVBfi0aOPU33KYnRReG9Uzl0hCdhkBhPv8gja0ZSj6x17mQ?=
 =?us-ascii?Q?7F4+YUjzSRQl9ztG74Bu1yxBS7rRMIoqnoCldPT9SRX3pJqiZH4obXGUEKzn?=
 =?us-ascii?Q?KsyJdqUBrXQ0neQY2vc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:13.0029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e4dadf-14fd-4214-146c-08de4ec516c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714
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

We only want to stop the work queues, not mess with the
pending list so just stop the work queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 80572f71ff627..868ab5314c0d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6301,7 +6301,7 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
-			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
+			drm_sched_wqueue_stop(&ring->sched);
 
 			if (need_emergency_restart)
 				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
@@ -6385,7 +6385,7 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
 			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
-			drm_sched_start(&ring->sched, 0);
+			drm_sched_wqueue_start(&ring->sched);
 		}
 
 		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)
-- 
2.52.0

