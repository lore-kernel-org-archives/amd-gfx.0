Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0985E7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 07:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD7810E3FA;
	Fri, 13 Dec 2024 07:08:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JsSAJQu1";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADDC210E3FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 07:08:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSuMzf7fUhrv1Mxq3vSrsTIKOCb92FBfoKKlLLm/Mq+USuZw4pBOT5HWPTdkaPrXePzQ+oFVYE0J6FQT30rhEXUOnXEkKR+NjDp1F/2tDhC3yGjb6ToHt3UfX3CZF4rTuJZoHpTsarmfZtk43FF9ro6GLsX1131/BRUpBwAGQCZVcWRDrRtA6SuuZ32p6tVqjmRCsGu7KJy6xhhAe5+xKA29AQ/k9H5QAMsas5oE+OtxrZRokK12fBBUJUoc1SK+aAZLT66roYodVJb/ApFtIMuaFR2M3Guh6RrY054wLbNYqW7a6sNj+dOb/sKtT0kKueDzO7l0DlZEpAh0U5sJ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QTV272JwFLjcdnJlzWJQgh3T1OF2l0jXnjJAkv9QR0=;
 b=t/D6WgNt6L+ZQVyOm+i8zj4Mg0G5FXCtRF2Ca3gtwowrPZ+XMLCYLNs1jEhZp7xNBPXrehxrEKdTgTu397XXWH5fTa5QnhcaGen1f1epN1nsSUH5JSNcbSNXs5uYH5t2APXW+fgMJlumaqkd51C//kQ7IlwfLNOL2yAYzMFUvQyEhJntA2SFsAP7f8XQVXWFInws9fbDnQ3MQlDiOYvq1hUbdR5YJrMwOBY+9vK7wA3QvZLEJ/CpXSnpyE3fPcKQhDoo9eUXlmKDdS/Bg9/E66khwKIEGuBpAM906aikHro7II3x1whcnM7uTLE+JXYjleRtrpwjU6tchJeTsLtkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QTV272JwFLjcdnJlzWJQgh3T1OF2l0jXnjJAkv9QR0=;
 b=JsSAJQu1IvIRvKPc7UPXZE/JNqbGJ9bRkm17Eszr1ycWsX+3G66l/CMufR/q1hSD3k9dOwtodfv+KmCj/Jq5ZmKgjBjAlQmdjf+kk/b8W4MSIwVM5eIMhB0azSJXg2ZgU6Lc955KMYlN1LIoBgGpm0BJS9GuF9sG7SNQqj0hIVk=
Received: from SA1PR05CA0001.namprd05.prod.outlook.com (2603:10b6:806:2d2::6)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 07:08:48 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::a) by SA1PR05CA0001.outlook.office365.com
 (2603:10b6:806:2d2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 07:08:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 07:08:48 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Dec 2024 01:08:46 -0600
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V2] amdkfd: wq_release signals dma_fence only when available
Date: Fri, 13 Dec 2024 15:08:28 +0800
Message-ID: <20241213070828.21365-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 89681ecb-d188-47d4-20c7-08dd1b44fd86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pd8bJ89rYJsDJ3SU6/LjpdZeu6g2HBXfEt2zkSIIXvFsDdqi7GA9Lhjl6f+d?=
 =?us-ascii?Q?GqzQoMdqOh6XPy9yw4AnIoW28mMkZDI7AgiuzibA1n1auHfhoCrOmAbEg4jU?=
 =?us-ascii?Q?lzJWG3tftOAC6fL4Q0rENyalahs2I/Gsy23EMfNZIsTCwz+TYnri+Zde+Ga/?=
 =?us-ascii?Q?Cft5wMXdKkR6U9wQWQfP4v+uxn90+QlxzxWMmzc9VN9wptQd0pFkblf40Jpn?=
 =?us-ascii?Q?coYQF9klq3AIuSVnBbfLOMM2X1P0TTOWsJ9fPZf6EplnL4ac411ttlbtxHj/?=
 =?us-ascii?Q?Hg67hbOcP5D16/loaiwPc5gvBBCs6pgnLLavRFxAM+sfe+PKKovUdu/aBzz3?=
 =?us-ascii?Q?cUEStMRS8A96IrRgM24Jx78j5YxDRqWZLaBdkgSbbN41IChBQLXHkSr02HYC?=
 =?us-ascii?Q?JXNjnfFSUaNuGz3DgGOMwqv+f6lTM4jfGYiioZIDkyDR+GCOZbNiuWflIRWb?=
 =?us-ascii?Q?ijL4KAe38Cz2qPFF/0ITPQLkNNkb9aEt/aQoDqJNdprt6hwf+TydRRqaeJtW?=
 =?us-ascii?Q?tdqT4/RLPNu7nGOtQUXPZsBWL8Wa/S6fw5LY952b7BvyIKmbgwlaNpxRzlHE?=
 =?us-ascii?Q?p6ram9MZ58EI7fJMRe0uvWEAUjw4LZSCgTxPZXqkb2tmN6pD0OsD6/g3FBmT?=
 =?us-ascii?Q?qeOpqPsfJFBmFgSkflCxMmQFMAlPQTNHcH8iSr3PzeDWhjfwpaFVP4fJoMde?=
 =?us-ascii?Q?SFMEgc0/D+ReBOvnf2zrIJSkaDnOQmd4egPHpMKrO92nmVmbrX0GiCDJaluH?=
 =?us-ascii?Q?KPIfLdXdxHvNp7J9y9U1UF9AOQOdPkogHZXTTZPxwlKVVAJDxg5IZVytn8VD?=
 =?us-ascii?Q?5GT8DWqACTTKL6xBNAIbvt7s0W0Ni938ekd6wSsYa4tREyI6jkA05OSKHgFQ?=
 =?us-ascii?Q?6OPPx9hio5ATIKf8oiB9ya7/rbY0vtrtu+WtrPhV9rUrLn0AeFqYYXVuBgev?=
 =?us-ascii?Q?ifni3BbJABFtkgyf9lb6mHTUZ6jeoLbZvT5eCwguqlmVJb6la13WDmx0U69h?=
 =?us-ascii?Q?Fb1fVTf2u/8ZuRVumjwnFlNotZLiEuPIfsYWsgwKtXjzlxaa1q/mNyn56ogm?=
 =?us-ascii?Q?I7NzCPMAd5iJ7Y8w8q/Y97rHAwEaFOW/mZKvnRAN2vpiZrZedup7ugQKe3v6?=
 =?us-ascii?Q?d7bT4YtoxM8cLSj0tV7e6n29MXqc4rVRPohvquyItRYW3Pe1BWxQB8Qk7Dyu?=
 =?us-ascii?Q?QKQi+OQjAFYZBPPux7LWAEaHefB3BETXdbGHrnaLNdonXkim5GosaE+tM902?=
 =?us-ascii?Q?RvNXZWEHZBRfw5jHOhtkdi7n3T3DxmOpbHoGybPHlC7pmXBFLscn5l9PaH9k?=
 =?us-ascii?Q?wfeVznrdFKReMe5RBhyZZ9XqzWrppp54b2e+W1kveRRxzX1ZzdgjIWiq3j5+?=
 =?us-ascii?Q?LS3phc/XNJ10Wj4irdCDt/4Wmx3n+asLejhCZ2sK1tnEhSOKl2x+T/hyywuO?=
 =?us-ascii?Q?7gcfTmBmh/eQEDyewZe1S4fM7+XgiY2DHSex/T6VcdOQODtnBuECgicGnXVJ?=
 =?us-ascii?Q?gDjOb+uTvGxT7KM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 07:08:48.0849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89681ecb-d188-47d4-20c7-08dd1b44fd86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
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

kfd_process_wq_release() signals eviction fence by
dma_fence_signal() which wanrs if dma_fence
is NULL.

kfd_process->ef is initialized by kfd_process_device_init_vm()
through ioctl. That means the fence is NULL for a new
created kfd_process, and close a kfd_process right
after open it will trigger the warning.

This commit conditionally signals the eviction fence
in kfd_process_wq_release() only when it is available.

[  503.660882] WARNING: CPU: 0 PID: 9 at drivers/dma-buf/dma-fence.c:467 dma_fence_signal+0x74/0xa0
[  503.782940] Workqueue: kfd_process_wq kfd_process_wq_release [amdgpu]
[  503.789640] RIP: 0010:dma_fence_signal+0x74/0xa0
[  503.877620] Call Trace:
[  503.880066]  <TASK>
[  503.882168]  ? __warn+0xcd/0x260
[  503.885407]  ? dma_fence_signal+0x74/0xa0
[  503.889416]  ? report_bug+0x288/0x2d0
[  503.893089]  ? handle_bug+0x53/0xa0
[  503.896587]  ? exc_invalid_op+0x14/0x50
[  503.900424]  ? asm_exc_invalid_op+0x16/0x20
[  503.904616]  ? dma_fence_signal+0x74/0xa0
[  503.908626]  kfd_process_wq_release+0x6b/0x370 [amdgpu]
[  503.914081]  process_one_work+0x654/0x10a0
[  503.918186]  worker_thread+0x6c3/0xe70
[  503.921943]  ? srso_alias_return_thunk+0x5/0xfbef5
[  503.926735]  ? srso_alias_return_thunk+0x5/0xfbef5
[  503.931527]  ? __kthread_parkme+0x82/0x140
[  503.935631]  ? __pfx_worker_thread+0x10/0x10
[  503.939904]  kthread+0x2a8/0x380
[  503.943132]  ? __pfx_kthread+0x10/0x10
[  503.946882]  ret_from_fork+0x2d/0x70
[  503.950458]  ? __pfx_kthread+0x10/0x10
[  503.954210]  ret_from_fork_asm+0x1a/0x30
[  503.958142]  </TASK>
[  503.960328] ---[ end trace 0000000000000000 ]---

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Fixes: 967d226eaae8 ("dma-buf: add WARN_ON() illegal dma-fence signaling")
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 87cd52cf4ee9..47d36f43ee8c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1159,7 +1159,8 @@ static void kfd_process_wq_release(struct work_struct *work)
 	 */
 	synchronize_rcu();
 	ef = rcu_access_pointer(p->ef);
-	dma_fence_signal(ef);
+	if (ef)
+		dma_fence_signal(ef);
 
 	kfd_process_remove_sysfs(p);
 
-- 
2.43.5

