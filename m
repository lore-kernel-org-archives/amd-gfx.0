Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D69CA0EDC
	for <amd-gfx@archiver.kernel.org>; Sun, 17 Aug 2025 09:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FFBD10E0C8;
	Sun, 17 Aug 2025 09:13:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jkmHTZq5";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E79210E0C8
 for <amd-gfx@lists.freedesktop.org>; Sun, 17 Aug 2025 09:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZEi7/vycQA2NA7hQEtcJ9pagy/G/MKa3q+AoDvmlxph8to3JfTUqMBYhhElhXc+gT2euSSmLGFW6L+VfhKn+vUSb1//tKw0PcmCVHy42gUHhcMAXJ+W+vOyKjWu5jg/1gfTX9M0CtdKcQaBwsle3aj2wudlIYbPuTMwhGPfN6KBQINwPKJRQ8WvitifSdYNvahGQSn+loJCyclBiwTTE1ZH6ia/33C2ZXvypFJKWKHjuJg8AKnrEHJpDoh/RpAbrrb+oqEH4E48avPifiBR+OxnPWtvVVmaPE8PAXqDtGGCAU9K+Jli9gwdQZqhfOJ7xfGhP7s2Ln7WLEK/8wJBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yt5QuG9WRW5tzeo8aTnF6z2I7jFMo1gfO6NzIFM0NEw=;
 b=UqC8ADJ1V80rX2xiBenk+uBMb8Z/8ZuI/Rp99PEVP/HZjbIICeuULGvJCcL1hT9uugRgdzsNDisooLSeins35LyCUgDJDB1afOZ6yBjS5n/8B1oG/YbpgZaJnZZ7o6le5llJCwmKrXKGAwRy4GIIILQ6CE+hs7i2Q+9NrqRQYcwIiGrLeDJ3mNdSJ4V+PgtdMG5NcXEPcCbEqRSPNMGVQKnqz1uB6yiJiGDOZL3qzj6p5JIBnr1PKYOImljEaFdlhdJMGm6cQG8LiFtepGm3fu+QxXTu4XCJ1tcn4ksVetigjYFek1Dxle6t024UTv/64h7Ys7TNj3lp1LTE761pCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yt5QuG9WRW5tzeo8aTnF6z2I7jFMo1gfO6NzIFM0NEw=;
 b=jkmHTZq5YRSpCGsTB+4M/thzfnYvnq7193RKBIIuZ+ZJeYOgOiH1YUn80R4qXTArdlQgMlR1C3YPrerqVilDjlegryVMpi+XwVZ5HTgSO3rq5ib97TPB5PofPlsCKUOdcTQa2VNic42wTU49dq+isRNFg1PL0lD/Hqi3gZmJRtg=
Received: from BYAPR07CA0085.namprd07.prod.outlook.com (2603:10b6:a03:12b::26)
 by CY1PR12MB9700.namprd12.prod.outlook.com (2603:10b6:930:108::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Sun, 17 Aug
 2025 09:13:44 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:12b:cafe::bc) by BYAPR07CA0085.outlook.office365.com
 (2603:10b6:a03:12b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Sun,
 17 Aug 2025 09:13:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Sun, 17 Aug 2025 09:13:44 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Aug
 2025 04:13:41 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <Stanley.Yang@amd.com>, <Hawking.Zhang@amd.com>,
 <kevinyang.wang@amd.com>, <YiPeng.Chai@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 3/4 v4] drm/amdgpu: Add a mutex lock to protect poison
 injection
Date: Sun, 17 Aug 2025 17:13:32 +0800
Message-ID: <20250817091332.308824-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|CY1PR12MB9700:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c037de5-a2ed-4da7-47f5-08dddd6e5d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?++4uADjwFX5+fvqQ2qYnjeGVnmHzgFmGC8zsgCFxEoKmh8nnmYel8lNGwAIz?=
 =?us-ascii?Q?W0ZLLcRHecBa27nviEnSvv8PMGxl0/LGjCDv8pAsx0alQf2myQ6/23fNdHeg?=
 =?us-ascii?Q?WI1BEgs389Mnhkk6PUlgjyOU6+gcKIedcPDzg4UAyzUjZmO+zIQzqi++K01C?=
 =?us-ascii?Q?QGkyMSj+7slq1kgcnR7tbn8I2fbw10XPYQzHRcRT0pKc6+thFCQU/6Lng1si?=
 =?us-ascii?Q?zbkwtbJO8x01YqvcmpGCS56UEF5YzdXpeKDLQKZYIDbTy5NTb7vym4kJqthG?=
 =?us-ascii?Q?SVbLcr31uOvrUGjrfz6D8zPByktMhb5zaonm/1YykF/DFhgjQ7gqubZmDuwL?=
 =?us-ascii?Q?xjLXoNzvKRlVhII8HMVV3b0hBd1lAdKR0PgZceFndr/0h3Wk5V/pM4Wf8IO9?=
 =?us-ascii?Q?ZFvEZam59/2dcVK9UDX4CNn6FhDT1OJtS0n9OFC7iLmWf1lEZKGSSQELDadi?=
 =?us-ascii?Q?mOt7eAsDPa58twfXDS8cqQnXRKDBXN8YIQHVVSkbUppMwaFKi1x61kYxEZTE?=
 =?us-ascii?Q?5r33MHWo6WYFc/4dCUd5jypftJe1M827jG37s/zework6L086dWJJkyeAdsG?=
 =?us-ascii?Q?OtMJj/WTIWlcTyw7sx9xrhwYTFpdEkmN6IchicT89Ff5K36i9XG4XPFqX/0I?=
 =?us-ascii?Q?kFZSMSU8tp4oumtkPU6eqLF/ILVwWseIhGH4GEWTpIPAW3rRAu/iqpyHBu6E?=
 =?us-ascii?Q?ZEOo4ur3OLfsKoXhSoPG/qJPn1zUbPD+nUCAYviFV3Rrwlnzx0PYFqPCSfXM?=
 =?us-ascii?Q?q9uCD4BDqh5FsYQGpqyg/MsixcnVNsdCFlWw9AtWve2TuXqcA5fhlu7Uj+di?=
 =?us-ascii?Q?piI/IAXSg62y+D1awF1Ne8+vOfh2iA//+bXS/y9cUSCC54HBjstqm6sJe4Xw?=
 =?us-ascii?Q?pbSbC5uQPCYdpUZw0GlDLYZUrQKBoZkev1vClxIyvW/kdYG/pWFXO5uPHqdf?=
 =?us-ascii?Q?Oc8k0jU7Ha6V/s96DGeJyBhLLuSmXDoajydWosU7jBRCCgN+Yyiydb43wXem?=
 =?us-ascii?Q?vzcTjMp9kTbTNSj4eOewu6QASRQECeDtpkHiRz3ANx1o8gu6W5S+KtGYEqjn?=
 =?us-ascii?Q?2St5GwwMNgL0pq5L4trL0kFfL4qA5FfVd1uyfMm6Y2mqPvz0h0Swdp8te7yW?=
 =?us-ascii?Q?+p27VBBMRvG1A9y5VEpXxJ5wlcdIfGEn6RpsoAaWpbmA7+Pk78GtRwsrHsyB?=
 =?us-ascii?Q?IXKT/27ikZpnSyYXUJTtx9b/b9oTaYkfetpz7GX6tCporLCIfZO5R7vdZOS1?=
 =?us-ascii?Q?vUhQJgP4W9KR+UvtggAwU/+mbfRtgf9EyHgcml2C7YGyvS2lsVb9sWbO1IhA?=
 =?us-ascii?Q?2sLboWJIvwX2W7f2m6JO1YWh2xMdpZAvnm+qUsSz7dYAasIRT1iQOLaL5mvG?=
 =?us-ascii?Q?FRPtU0tXtTMBE2NWRbqfJ/Kw7ib9qXJ/ajXEuMbVpCX4S9EC9nbxFC0VA9ig?=
 =?us-ascii?Q?XmHP9umLaLaIZK4RU//6i6+R29ROwWdXwZ8D3aPzAGlRzmTB7V+GoXHE5rzl?=
 =?us-ascii?Q?yEJapbUEU83fYyZs7ZarBn8p96Izt142prkj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 09:13:44.0887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c037de5-a2ed-4da7-47f5-08dddd6e5d8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9700
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

When poison is triggered multiple times, competition will occur.
Add a mutex lock to protect poison injection

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 185b9e538f98..31850a47a41f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3503,6 +3503,7 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 		if (kthread_should_stop())
 			break;
 
+		mutex_lock(&con->poison_lock);
 		gpu_reset = 0;
 
 		do {
@@ -3560,6 +3561,7 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 			/* Wake up work to save bad pages to eeprom */
 			schedule_delayed_work(&con->page_retirement_dwork, 0);
 		}
+		mutex_unlock(&con->poison_lock);
 #endif
 	}
 
@@ -3657,6 +3659,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool init_bp_info)
 	mutex_init(&con->page_rsv_lock);
 	INIT_KFIFO(con->poison_fifo);
 	mutex_init(&con->page_retirement_lock);
+	mutex_init(&con->poison_lock);
 	init_waitqueue_head(&con->page_retirement_wq);
 	atomic_set(&con->page_retirement_req_cnt, 0);
 	atomic_set(&con->poison_creation_count, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7f10a7402160..6265dac0e1c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -573,6 +573,9 @@ struct amdgpu_ras {
 
 	pid_t init_task_pid;
 	char init_task_comm[TASK_COMM_LEN];
+
+	/* Protect poison injection */
+	struct mutex poison_lock;
 };
 
 struct ras_fs_data {
-- 
2.34.1

