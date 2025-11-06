Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D9ACCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FF6210E814;
	Thu,  6 Nov 2025 06:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zzepQfre";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE7F10E817
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uk5e++FjPd4M06CWJuROs2yNRqGVfyWzI3XzYaAY2X53X6zS0jLLZ8Or83jDn/gen0gwocTDzxDKucXSymI01GxHmZ5PDlXdTxDC6S25xrZtyJzoflYxJtNbebY2/AYBUGAI12sKKwEh9jDXEbY1vUboYmITfPkhe2T4iNMdF+FRjXtTzqDi62yvFRDciKv4ZHpujDu2lun6O0s5GGQ6daw1TsWuH3U/omtPYtM11V08/i41kCZMRjE9PcaUc36IWI/e2uwtQ2GlcowTjXGOeOHxbx1N6o9gzx8+YS00dxjo2WP2PW4V1ALfIFUy2XSIj6T6R5Xxn/lAypPF0DYvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2omyFlYf23IxMsGADh1Gsje4Y4iJvJY8octkVgNw8no=;
 b=IoBYCpgvB+KzGFNzy25+WkPQKcKmrQquEGmwwVeqrGLEsm4uFtzwi3RYiMs7sdVUStaOupFPMCY2YBjWuRsJ5/dCnh4pfi29K/fqO9bmWNNhhBPjLMcoTE9rKvzKuk+e7MdGHq0ymX+ZUFpoQ/Gxvd2iAwm3+ZlY8+I9ACAomAhzi2JO7Pv1wp//N2Elo45y4xT+wWtwLDXVQ31C7YCFA5zvBqfcex/TM3o2LOQ+DYX7791WWILkVm48UCjCBwdAFbuJy9QBF214k1HUVDETM0459Pq6QUQfIhWZZNj0A5ilkr4QJkBBpB2+mNCbs2CRY+W+Kpal6bxGNMWz6V4KQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2omyFlYf23IxMsGADh1Gsje4Y4iJvJY8octkVgNw8no=;
 b=zzepQfreHn8zA8aLNyt6LXqCPdHXmSJaRHjJDI5wnk5fxSNGnWBm8C8yv+8N5C2/ELYdJXiAL5+mNnqffs3vaqsFnuciN1LmcTWWF0Sz4HtRvNpweeKdTTdrTVfGqVcDCtMK45gCJgi4Cr/38rzAFQ0qEqewTpt0H1nwAddkiH0=
Received: from MW4PR03CA0186.namprd03.prod.outlook.com (2603:10b6:303:b8::11)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 06:08:35 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::f) by MW4PR03CA0186.outlook.office365.com
 (2603:10b6:303:b8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Thu,
 6 Nov 2025 06:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:08:35 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:08:33 -0800
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V7 17/18] amdkfd: process debug trap ioctl only on a primary
 context
Date: Thu, 6 Nov 2025 14:07:38 +0800
Message-ID: <20251106060739.2281-18-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106060739.2281-1-lingshan.zhu@amd.com>
References: <20251106060739.2281-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c3c8a4-2899-4c12-c945-08de1cfaeb96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e+hmQ1M/jmO54arh5nwUhdqpfrwCD5gImozI4lpfG+FjvKi/2XoAGoxWviND?=
 =?us-ascii?Q?aQrQVxA6LlHhpkdXTw4bYmc+9dK57RYiKGmXPiOlllWIjNMh9QpHafezfwXA?=
 =?us-ascii?Q?gnRBlPrKIIkBBX/geRoFZGBwjq74B4C1+VERkO1a+JoBbdrUMSyp9u3zNLfw?=
 =?us-ascii?Q?eUlcwroX1WNMiaE/iAVeu7mPkGPnKzehoiBsnKQuHr3jJop6EHL0Mvh6yedf?=
 =?us-ascii?Q?dWLty7AODeT6KZgN6AhWhTYn7I/h1j4MNXobIbiIwMSFb2/dzF/XmXvUDrCO?=
 =?us-ascii?Q?O04U5y/QUxqsyN9276zYKooOBdtPm2L3NdeL13JnLSnklrrFBMCYIPYqdCUs?=
 =?us-ascii?Q?crdY7dIjc0yN5LWaFEc99bo7lEZIw6h+pl7xP0l3TAxgw9kndwFsT4Zt1byz?=
 =?us-ascii?Q?DHvmTdpjcTEWrpjALtsxQ0xiXd0Ah7FirDLWa36mR117NzWY1pc90rBC3wXJ?=
 =?us-ascii?Q?HO3T8On7HOSxu9+GgbZ9C1hLVprNQdas24oTeJ4GX+dPTGsAobNmba36gp0X?=
 =?us-ascii?Q?PgTO14AuVYtUSYsAElKPF7wfw9itTVa/Mi4xulZcAi2EXJiId0wo/bG5xfTs?=
 =?us-ascii?Q?iaPrVmOikIvls+PATfKVUxrcoJ8Sf1ar3r7+1MuV+SvP3LiFq7KFplOz14Uq?=
 =?us-ascii?Q?Iu0zEVsbFhX2H9RDZozWaeHd0dM6E8nvYjLcdZ0ijI1Zvi97Nfm57xfgZp7j?=
 =?us-ascii?Q?4FdJYTe2B8gF31smQgWnT3MT/W/ruGEGY6Z7HfSiQ3Gk5ofhgzE0X7vHWYO1?=
 =?us-ascii?Q?vjT6u9fMLnHCVIAg/Tm9wj1GNPHQQ0nPVkU3wxk67lv+U8qs0Y907p/vTIzY?=
 =?us-ascii?Q?HsCSQZ9A3Sh+uqnMwV+oskegNO7wHW29QXIjKTy5MXNmF0t9Z7zSDxG+7NXK?=
 =?us-ascii?Q?zA0RY8vgMVsceVc5p6RkThId/xzlzVcroyFmnNSYS0fqi6gjrYiM5fQ3OLQ+?=
 =?us-ascii?Q?nevzPZfQeQvm+X9DKwWGjZqhJXFjqij55t9UhSWb50d0yLHcPvEWp3wlcxAe?=
 =?us-ascii?Q?wSlZVz9uyBl4DCs358pCbZf097jfNN5NAZut7fnop+qepxA6m3JEdzg2ackT?=
 =?us-ascii?Q?BH6Yza1gTXMFPo0dVDWK3XT+wvQvNjfySdzZ4EsHQd7WTnxDI7gsgU56QoaG?=
 =?us-ascii?Q?SiiQXNqyAHADFobAvwnm6SpTU50kBYHH+Mku36C72hKXbEZSo4R2bel0BspC?=
 =?us-ascii?Q?VO7t0LeDLT9nfpTYNHcMN0gGG15lzR9Zt4PP+6JzsJn+d55M2aeGgy4/1YQ3?=
 =?us-ascii?Q?PFQ44XigoRaS7ZmDaVVstVTIC46LAkPT4oM5qEqhD7vI6JpUhuhpllcj/U9P?=
 =?us-ascii?Q?XxS4Mu41cKas/kVMABBnuZQjyYqOglyf0ZWL528k6D/T08L/cGYPo0GL4SaP?=
 =?us-ascii?Q?bbxcCVxiMIshFBS0mUGioRa3GCr1tjY8In9LPOIp2GJzsgIh8MKuCqdYKFeN?=
 =?us-ascii?Q?FFPtIkedYjhScGxGHuaqIAxbTMhPs8xuxhAEEMp7+uL3NMnwg/bda/i3fX02?=
 =?us-ascii?Q?W6dVzEXn+tfuXP1E1Z1IhduRt9z/oNu+75ekO290uTW54qzzzN4iJEG5wdnn?=
 =?us-ascii?Q?WLprNgNnYtMS4k6DrW8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:08:35.1790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c3c8a4-2899-4c12-c945-08de1cfaeb96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185
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

Set_debug_trap ioctl should work on a specific kfd_process
even when multiple contexts feature is implemented.

For consistency, this commit allow set_debug_trap ioctl only work on the
primary kfd process of a user space program

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 73de2de8be0f..ad5ca3fd847c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2927,6 +2927,12 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 	struct kfd_process_device *pdd = NULL;
 	int r = 0;
 
+	if (p->context_id != KFD_CONTEXT_ID_PRIMARY) {
+		pr_debug("Set debug trap ioctl can not be invoked on non-primary kfd process\n");
+
+		return -EOPNOTSUPP;
+	}
+
 	if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {
 		pr_err("Debugging does not support sched_policy %i", sched_policy);
 		return -EINVAL;
@@ -2971,6 +2977,12 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 		goto out;
 	}
 
+	if (target->context_id != KFD_CONTEXT_ID_PRIMARY) {
+		pr_debug("Set debug trap ioctl not supported on non-primary kfd process\n");
+		r = -EOPNOTSUPP;
+		goto out;
+	}
+
 	/* Check if target is still PTRACED. */
 	rcu_read_lock();
 	if (target != p && args->op != KFD_IOC_DBG_TRAP_DISABLE
-- 
2.51.0

