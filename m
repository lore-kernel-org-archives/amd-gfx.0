Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE7BCCD185
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 20:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7CBF10E27F;
	Wed, 15 Oct 2025 20:12:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XNFt66cl";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012015.outbound.protection.outlook.com
 [40.107.200.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F20E10E8DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 20:12:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BO7weSFRvAN4mHRdwtRBwFdrW5HIsekLcoPgZBWmiXGTvKsT+3IWfW97uBCS0NK87Iz5NbzJrErocecQ01pU6UvlV6sJt8xzASaiyZ4fVdKCO22biTGyJGA3CiRJHiKyKVQyoLf5NVGjpLKnhVqrgQglrNABoG0GLB7+WHCt5P7YGlDDigHNIW/aqjHlIkRqsBGvEH1pDXOJEfLj800UHfrApo3PLcBlFvyjHx8rf7GV3HZCDA9f4ur4Y/2RPQNuss7N9maHce9xWOnrtPHV4Ad5HZOGGrDGQalHUn6jto/F3Dm0RmzWy4/e4veljvep78nfxP+QP6z8zSI23qTVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBW6EPgBYS70+bgOAxBsicJ/ZoVQdAeF7/IFo9x7z3A=;
 b=VVkKxEBv47nj83N27sMMhF7w3Z5lYHABfuwXgD4LLXRuZz/EC4JOKTZwZBykRxo44wljh87Ycu7zBWBDlmWs6HhTrJUF7RyFKHPBonNTbs44HUPAMsZNxlXqt1PRt+hYaYPzg+MO+Ypw+hNx/kuJ4kD8fI8o/9HxasEfqjk4Zpgn/VnvHM0W20bdnHL+i4hpOe2ffu+pv0UXX2Y3w58PBPngyI4KrRJ/bgeZwGMVisAshBv4Y/elJ3kaLph973L8rYTAeYuDw4JQeFys1w9BmEpXd6s9Ag98hcLhiqJQD79Rcc0L4wOH2e+b2Zj6tHlgMtP22CCpN44WvG3PsEVbMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBW6EPgBYS70+bgOAxBsicJ/ZoVQdAeF7/IFo9x7z3A=;
 b=XNFt66clgLOiYPVZkbLUHgXYyv70qTaypOjewWpzP+svF+kuEGa93DZ+ferV/o0RdXvfEXOTijKlW4VCKlzIehuwQElqnVAwrxGVmTjy+k8dHCREesrYhdzBpQJ2OzJtaKHjRgoUe8nNJv0gn+zckY2RwzDBT9bIirHOkpo5370=
Received: from BY5PR16CA0009.namprd16.prod.outlook.com (2603:10b6:a03:1a0::22)
 by SJ1PR12MB6338.namprd12.prod.outlook.com (2603:10b6:a03:455::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 20:12:15 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::56) by BY5PR16CA0009.outlook.office365.com
 (2603:10b6:a03:1a0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 20:12:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 15 Oct 2025 20:12:15 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Oct
 2025 13:12:11 -0700
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>
Subject: [PATCH v2 2/2] drm/amdkfd: Stop user queues when process mm released
Date: Wed, 15 Oct 2025 16:11:33 -0400
Message-ID: <20251015201134.2540-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251015201134.2540-1-Philip.Yang@amd.com>
References: <20251015201134.2540-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|SJ1PR12MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f692b8-806b-4333-1c48-08de0c2722a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PDgi2B6voEi0RqKhgHsjR/O/VVcjmBXegihNJxb5wYtPcbM/uPfgN1oo0owi?=
 =?us-ascii?Q?9PAbVTusBqx6p2qjPhWsO2Pg2zBIxJvhku3rRpxsUQWXaMsxxvUivv+SfgAm?=
 =?us-ascii?Q?VsoXkNCTcKIZQGH+Wh1Scot+K4JzLOI9+6x/ax9GnzlxCedy5xLKZh5KZPRI?=
 =?us-ascii?Q?vwtyfttIa9oTX5N9B0azEU1UaTzyq/E1HpGJB5rusK+5E1sMZRuqy/le8oY3?=
 =?us-ascii?Q?JOR90DfYktfIYLHlVLV5aUhuwyKdLy+LbcUzbG6KjE53mNU1PwiaH4c3hKXm?=
 =?us-ascii?Q?B1FGAJr+VujiFfQ2J0x93tcevlJfbwc+kgZw0mbhRJETUQ13qo3xy4uy5CZ5?=
 =?us-ascii?Q?jdNwXNYTCy0S0NapPwKRZXOXNe6AyV5Eom4Bq+lYDW8HDdx9hxMNVqwrLf1S?=
 =?us-ascii?Q?mcSzI+ygIk0q+pYyZQSp4btfdp6ZgQ4oo66hMUnQzNJVY3X/sOaBsVsNLzzd?=
 =?us-ascii?Q?eTrkNYhWE4qGofErkylMtjdz/PbEE5CrIKMb9Hv1ESpkfd7lj507vLM/sGKT?=
 =?us-ascii?Q?klDr6RhaSWl/C2yd6IA88/vtERNvnjISZyACGzRUuy7xhnwpNqQ6CTuxD039?=
 =?us-ascii?Q?gIiDgDvGHKS4hXFGAyDc8LPGTymc6kyvxQ70VYby9RJBXUA3Cx+NZmZadPRo?=
 =?us-ascii?Q?OMIS6aIQdod08kiLZJn5yhDmXs99jU6jb9b5q7qeYHHmLIVogP2zmUsvVK5j?=
 =?us-ascii?Q?T1vdCmpFaYRIjQQZDHYetnyZ3D3lq7LGztKbgCuvWTdnul28GUoPzBiA3Gg3?=
 =?us-ascii?Q?VrzzIfC2T9YOwGrjEwCz6EbUfMFdY4GREqxqhxviW4ZUsRTBd+kLmQvxXAFs?=
 =?us-ascii?Q?q4ExFJ7vR/asGxbLXcdls+grY/N67RkhzWbUvTRor6QmBF1/wM5iaqDwE182?=
 =?us-ascii?Q?BWeRbHIN0zU8BUp3oqnTk/RHhy1i1daiY25Pw7qvBV2ThhSN4J1JOWNWC/JF?=
 =?us-ascii?Q?7saBCyPWGdZppfGp/ktSTrI4J89gWGk4RRcP3HMa/fZLdpefLSeJF8quUI/v?=
 =?us-ascii?Q?dGF8IMNQsMfreQ6MHRiLuH/Sk82ngi7QLwplxhEppONhikTG7+Z2MyXXhqUz?=
 =?us-ascii?Q?vU2AAT/Pfq5u2+Jy73jZBP+adc/NGCv+pPHdw70qSCvpuw4SC/JOuA8ZJcZw?=
 =?us-ascii?Q?swx+c2otBrvZjLjbl5pXEg8Xu7BFgtM0mmqC5psmLs0HhX4IXyJSFr5y+IT9?=
 =?us-ascii?Q?c76GQPOadHmpA+waVRHMd+1stwOGaYps4/Vt3dm6au97ZMSqfcg+C8HRcxmk?=
 =?us-ascii?Q?/YxrdsOyMEiKgVu11BO9r+THpDW7InEnITt9PqcHDoLGb9/nhiOy6+0drxP8?=
 =?us-ascii?Q?9Zs5OItVA1tFCrArBgzKudsYNeyYNlvIX8NgSOnV2J1Ohrxvjeq7kUwcuOVm?=
 =?us-ascii?Q?FP4d5hpy+pbkByB0bFM/XZG+gOqZEDO3b+a5K0kTYCN/+1Ms3npWlXYAr6I2?=
 =?us-ascii?Q?X0ahK3BDkd7E53fXVkkHatnZcC+5i1yA8irHfWH49gvHPGBIvqa3w5i1MU6V?=
 =?us-ascii?Q?UBtbxXc8yye7WIdnehl5J0sB4o6pn4vAOKSrz+Gw2KrTSGYCpFnO7w8sUmE9?=
 =?us-ascii?Q?TbEhIbmzKTm96smO/ag=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 20:12:15.6468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f692b8-806b-4333-1c48-08de0c2722a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6338
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

In mmu notifier release callback, stop user queues to be safe because
the SVM memory is going to unmap from CPU.

Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0341f570f3d1..e2a0ae0394b8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1221,11 +1221,16 @@ static void kfd_process_free_notifier(struct mmu_notifier *mn)
 
 static void kfd_process_notifier_release_internal(struct kfd_process *p)
 {
-	int i;
+	int i, r;
 
 	cancel_delayed_work_sync(&p->eviction_work);
 	cancel_delayed_work_sync(&p->restore_work);
 
+	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
+	r = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SVM);
+	if (r)
+		pr_debug("failed %d to quiesce KFD queues\n", r);
+
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
-- 
2.49.0

