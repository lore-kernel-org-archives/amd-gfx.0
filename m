Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18530CD1288
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 14:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A47FD112B80;
	Wed,  3 Apr 2024 14:36:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ChIAYVi9";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C700F112B80
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 14:36:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3830BayA83x401QjV+gQXG7zFVjBGe1WNM6CapOs8+Xa1M0Vkm2gX6yGficFYAJ0Op5KVM/vVAbEO5rgiDl2SmG8k64O8rUDOKvQwK77ERObo80JvAmG3EGd8wj3mknUIzwH92aK7cANVfR6l48OUc+TBJHr8sZ9sQwqhAtRifzZENncVZOLeKacd3fKiE3KEkx8Y3M09+UtCM9gepLreLTBcvtcTyV/t7DkAbcJ4ZrOUYrRiVbPbqR6S20BNgmVL3IhdIia1cMFB/JnZ6bf44xW7+3OF4fhKUFMOa5zXwvyfTQrvfI7zv3zH8xpxtn1DUwE6fVHMv46mochpOozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebPO2hDfna9tY74GXPeEtZjjuK/3wNous/mOG3JAJGU=;
 b=R8uR06PH9MSMqu0gQwKxba4WPMWMS3BD8bNMvD1U5Vb8GDHKwL+UygR7TWrrF/KVGePFy4U8QRb6XPPa8/ifqLedI3NmhCerNMx3jvY+zAPjx2/+pVxtiuQmFBtC6MPFKE9cXcJp6c9m+WBxQus0g2mj1IXRjCIi16j+/N69dElkqZpRTSLJAfU7sx38dHhGBJ3/pHZSntT5PRYjtUmR/lwTd2vFWhHZrZtfv1YkHjByRLjpS15NT3OvGB+tWrRMVH/z7crZqkhl8ey0eH3IXweichSu5bjrQEb0zyD1/SHd1WNol6V8CBKbUwqYLb/pte+/sE/nHoh1TyL/S9CCdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebPO2hDfna9tY74GXPeEtZjjuK/3wNous/mOG3JAJGU=;
 b=ChIAYVi97GyFByO20CUetpFl6XiSaDwNHDeKYHnLknSL8+ncH35oRmKl5TLJYC5E3IhBNMavXQcWYiZkPe72GPApVM1aoFFJMyp9pFjUWeC9jCQnjLFOzsk8S7pvYVQqwGCtQygozGq8U0Uh/B3oWq83Fe1kGyplQnEh0EY1qD8=
Received: from MW2PR2101CA0003.namprd21.prod.outlook.com (2603:10b6:302:1::16)
 by SA1PR12MB8987.namprd12.prod.outlook.com (2603:10b6:806:386::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 14:36:41 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:302:1:cafe::46) by MW2PR2101CA0003.outlook.office365.com
 (2603:10b6:302:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10 via Frontend
 Transport; Wed, 3 Apr 2024 14:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 14:36:41 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 09:36:38 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Sashank.Saye@amd.com>, <Jeffrey.Chan@amd.com>,
 <philip.yang@amd.com>, <lijo.lazar@amd.com>, <felix.kuehling@amd.com>,
 Zhigang Luo <Zhigang.Luo@amd.com>
Subject: [PATCH 1/2] amd/amdkfd: sync all devices to wait all processes being
 evicted
Date: Wed, 3 Apr 2024 10:36:23 -0400
Message-ID: <20240403143624.5160-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|SA1PR12MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: e7654b8c-b162-4aef-b4aa-08dc53eb7a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nTjkbk8CdLr7+UfAhyEuizPEK1mKEjNULym0D8yzD4x4YBcQEFzXvAzwBWb99P4FAGkyNSx0KTM8B8P5W/WUK/MqhU4f46imIXBblSuL/ozMhBuTJRQRm0fRTtKEfprDkBjB++B8UEphYXM5BGxR9ZyFPdomyLf8LQiMwmVYHsys/nm/R8YdUrnzqwEgl0fxF6l1OdKikfYuRzbAFYAkW9TXs+TGD5JQEzF+x2kgEjlxKb4XLJHDbu0UeWEH5qKU+4+BvZQ70l9hgHwmk+P6RyOVE6/Tup/A1wUtVB6ujxAnxyHuGisjut+CrHmT7tfq4p130g6+A1M/bW+/nEl6NooNc1YmdsnZegJ4UdhqK7oDbxNhR89SO7fYz6Nk+tDdDkjvJ3B6SWZt0yri9FNZpocyF/5nO81ejYFsRgtbRmTHdREZBhfDtWn3Xkh+/MAsdlKV5xVbHzKJPUxrsJ3CtWDRPVmYcTGi2+NwAzuI1YehhN7/QhQFRz+k3O2Sz3Sy3iK/G2wBmQb8kYyKkxwQB6JNQ1T67Z42H2rDd5/zd6wS/PgVbWTRJYtlcRT2ZxeGzd1tC2MEd5DIec7iovnXmNh/cnXs3clG5DlyRkFeY6SH9QEkpGz5EDI9B3bmeSw6EZhvZPS7pMssMYir0ds2xdGdYkSzKDvxYWirkS1VXKbvFo6OpspOnrKSKiYjiUEVlVKDO/ui4PJf4BImtM8K2kYXn9m/rxK+CfLZolU6+74UM2vU4qSe9qmE+5L0TvWi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 14:36:41.1131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7654b8c-b162-4aef-b4aa-08dc53eb7a4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8987
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

If there are more than one device doing reset in parallel, the first
device will call kfd_suspend_all_processes() to evict all processes
on all devices, this call takes time to finish. other device will
start reset and recover without waiting. if the process has not been
evicted before doing recover, it will be restored, then caused page
fault.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 041ec3de55e7..cc9ac32182a6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -960,7 +960,6 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 {
 	struct kfd_node *node;
 	int i;
-	int count;
 
 	if (!kfd->init_complete)
 		return;
@@ -968,12 +967,10 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 	/* for runtime suspend, skip locking kfd */
 	if (!run_pm) {
 		mutex_lock(&kfd_processes_mutex);
-		count = ++kfd_locked;
-		mutex_unlock(&kfd_processes_mutex);
-
 		/* For first KFD device suspend all the KFD processes */
-		if (count == 1)
+		if (++kfd_locked == 1)
 			kfd_suspend_all_processes();
+		mutex_unlock(&kfd_processes_mutex);
 	}
 
 	for (i = 0; i < kfd->num_nodes; i++) {
@@ -984,7 +981,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 
 int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 {
-	int ret, count, i;
+	int ret, i;
 
 	if (!kfd->init_complete)
 		return 0;
@@ -998,12 +995,10 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 	/* for runtime resume, skip unlocking kfd */
 	if (!run_pm) {
 		mutex_lock(&kfd_processes_mutex);
-		count = --kfd_locked;
-		mutex_unlock(&kfd_processes_mutex);
-
 		WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
-		if (count == 0)
+		if (--kfd_locked == 0)
 			ret = kfd_resume_all_processes();
+		mutex_unlock(&kfd_processes_mutex);
 	}
 
 	return ret;
-- 
2.25.1

