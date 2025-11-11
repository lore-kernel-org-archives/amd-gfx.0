Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FF6CCFA18
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Nov 2025 22:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02A3D10E642;
	Tue, 11 Nov 2025 22:09:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ur3E0Tyf";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010012.outbound.protection.outlook.com
 [40.93.198.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61DAC10E642
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Nov 2025 22:09:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpVHTJp9It4sIdamkyiHuwEyS3sGGNaDRz39Q/Xtt0WbgbSDnDmTYKMHj8WCLvr3HMUevSmF4JJLZUlJziG3oF24W8PY/H+pQVtvB9fZ7mqitXqAr4kotb25G/YQw0sNgzE/6Rh74ir7scLesO7f95I6UHTi0yDcEQYQxmZfGWttwemLqTyqmC7JcIFqT4Q+Rra2OTG1ATN4IXuST1mJO7L3xyMiIV54Qu8pIU0bMgLa2VOYJiabF7pcM3vWnLD2aB75+cVxmfq1dIsjSXTqC8zePYlHAn75Uv2lwYgWcs7RniJ8OZrLNgaAUTYgvm71+xCogXH1pw7pH/dg1kx53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+MtFVnd4eU3ASNOaMN4AUIRLj7tU3UQB4zGo3MW7Q4=;
 b=EJ9aiQLsPmbCqbiex87G0y+4PsdhjifhYY54JvKveFqo2lAu+3Wa/X5YP/IW4M7JZAkDjbqWxwP0XvQdFJ6ZQjBg5UuUm0sXBKEO7LGCBTQ06qATcUFunmQhJmYc4MgrRbS4exIV/2ZGK05Q5y+sKYY4w22dFrm6NqWMudysseKVy+GmVXsx9K0GPGG52VpttkpPzwqWPsjeUf/C+ydBwYO+SCnVxewgee4KRhHoFCFCYPDm0PNyUMfo9a1YJI09+aZB8D7GPEEZ2HtifrAnn238lk2a5vyA4RgGzhRG9pwHaQv8PXE4Y6jheJ/Yyq6rga2KGnBpET8jhHqUrYUGwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+MtFVnd4eU3ASNOaMN4AUIRLj7tU3UQB4zGo3MW7Q4=;
 b=ur3E0TyfvtDERbFhQFBccu84Txx7JDg0arWFQuGqGC4h8FVsTHsxSHq4Fmb6V7oX687ba2kcIeXbvcy8bextiJFQkDrDGsBXuXswNU0aQ1z5/5jZGc23n+rs4vp2UhckoNDNCVuQWVqpF6wkZlQZzsublqPVj/iz4ybR6LVa1oQ=
Received: from DS7PR03CA0254.namprd03.prod.outlook.com (2603:10b6:5:3b3::19)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 22:09:13 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::b3) by DS7PR03CA0254.outlook.office365.com
 (2603:10b6:5:3b3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 22:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 22:09:13 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 11 Nov 2025 14:09:12 -0800
From: Andrew Martin <andrew.martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexandru.tudor@amd.com>, Andrew Martin <andrew.martin@amd.com>
Subject: [PATCH] drm/amdkfd: Ignored various return code
Date: Tue, 11 Nov 2025 17:08:59 -0500
Message-ID: <20251111220859.491904-1-andrew.martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7803ae-e29d-428d-810a-08de216ef27c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TsLhxmn+YH4e4qc2rWGT7C690lN+pS81yeQI18UxD9dCuXeMDTgQLz8H8J6z?=
 =?us-ascii?Q?MhyHHsDW43JX9pfHPEJoyJjmle9PziZRcyIwflnP/S/bwu68FZK3rTMJWf7H?=
 =?us-ascii?Q?tczpxUhxcei7VdSvuRsm/qy+u5Cu1K0OQfOfloZGviQ0M8I1cnoZSsFWgtdm?=
 =?us-ascii?Q?Y3dN2ZWwzprzefOVHZ6nZePz8NgORFalJqj8mALuUyy/hAh+RcgZ02ejNphU?=
 =?us-ascii?Q?VxPw5LA/OtHTMMcq8rgADoSVFh/lySl9Gh/cYwzjWzT0Fl/G9wSkPwciBki8?=
 =?us-ascii?Q?ixbldPp1YJD1l3JntEbqM7akp0dpHXFHjZ3ipUs0HJazVGwCXGAdPaKchWhI?=
 =?us-ascii?Q?XvA2vPrp7R0tucSspSly9qFV7WP1Kp20I8OaaSVlt5qydPzzukuZaO3emw8m?=
 =?us-ascii?Q?m8f6RnOo1aaIFas9OdlA7ByG2d4VF5LlZjo/8HPguxI3+rTtcaoThDmohlH7?=
 =?us-ascii?Q?G5JVmqin13d6v+99jvZm2t8VRUJL2/YDdiwZRWxgRHw/wvJjc3tJXWCd3yR8?=
 =?us-ascii?Q?G4j7ZcA5TpwdEWtroYAxDURINsjZtjKroRcBX34JdNShJ0YfmnZsyhaiQDKF?=
 =?us-ascii?Q?GaCej+AEEoeKIHHqef+pml6C6Qvf7ILiaMZjk7LgS2tUzpR8PDFlmNHi5ze3?=
 =?us-ascii?Q?0ExkVh2wjH2XgmnRqML0r3GLVysSh+7fXy/Wc/1pdGYL0hJKfHH8zv2VNy8I?=
 =?us-ascii?Q?Owoz0flchntYWwg4V3q9TZ6MOi0RXbCZe6Y8Ym9cNeO7Q6AOxxr269AEqw4Z?=
 =?us-ascii?Q?279JVQy1U3+7hZgKu0g/diWpNXkvrPNwwS70myvpqtK5GoZZP6NpUbS4TYyX?=
 =?us-ascii?Q?yZEm1m1/5ln34K819bw2kCh2rxTxyK6XkGHz9ZdgxzJKFvmIj+n58FOCyU20?=
 =?us-ascii?Q?jmfpxpk7oc8MC5MX64gVPKRsk2fNxVDqiMrBR5MBQmAAJwCc/jU/uN3+yUfB?=
 =?us-ascii?Q?F1bbGn8rmomyz58QbhkuGljFbwT44kCrs7WBFE0ExDpprlpIDUNgQc1U8R/r?=
 =?us-ascii?Q?gw9GhQpFLN6pE5WIOB++Ur+1KB0VEAtIO73ZfF6p/CPmrC00R2CYc2LwH0zq?=
 =?us-ascii?Q?YwXE5qYT4VAAL4CdBmK7uVN69tu2NUfVqWks8v9L4FolR2gh4Q195mFI/0Vt?=
 =?us-ascii?Q?CT4gFFumxIhr533OdCRPzOXs7TEdpoYW66juqChOvnLa9mniBz38xDTw2mP4?=
 =?us-ascii?Q?/38gevC3MGcx8GhfmOSD7MvSG6GKHJj0C6Ks8QM8OjdsxAvVlNwXk2HeWnj9?=
 =?us-ascii?Q?Q5VIAo57M56OnaH4peNzfWhwtKCzCkv8wHbsM2aOjILu7cSd/etL54TaPXO0?=
 =?us-ascii?Q?6uM13JNhHEfF2ndCHVQJBjhYi3Ddx6HJRtoL8RY1/MnQ/c/CZDkt/M8IEP7j?=
 =?us-ascii?Q?I4VKXeEbtR6RnLrL905ztA54DzFA3YOhy+Dcfz6Q7iYnquoMWzJir82ojVei?=
 =?us-ascii?Q?UjV8BnbTH7hHuDgxGjTKTug9uNtFQtpD82BXt/GHhJq7NM+iknnUw+jqoKBZ?=
 =?us-ascii?Q?J51XD+piW7Vvp5TOKCMV4DHSRXY4CyT6DkPo+AyKAWgBAeMKmROjWj+E4luU?=
 =?us-ascii?Q?EM4YMsu7PpmXcpXOn1I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 22:09:13.0752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7803ae-e29d-428d-810a-08de216ef27c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
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

The return code of a non void function should not be ignored. In cases
where we do not care, the code needs to suppress it.

Signed-off-by: Andrew Martin <andrew.martin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c                | 9 +++++----
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 ++++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index ba99e0f258ae..cfa3f0d1888a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -565,9 +565,9 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 				continue;
 
 			if (!pdd->dev->kfd->shared_resources.enable_mes)
-				debug_refresh_runlist(pdd->dev->dqm);
+				(void)debug_refresh_runlist(pdd->dev->dqm);
 			else
-				kfd_dbg_set_mes_debug_mode(pdd, true);
+				(void)kfd_dbg_set_mes_debug_mode(pdd, true);
 		}
 	}
 
@@ -627,9 +627,10 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 			pr_err("Failed to release debug vmid on [%i]\n", pdd->dev->id);
 
 		if (!pdd->dev->kfd->shared_resources.enable_mes)
-			debug_refresh_runlist(pdd->dev->dqm);
+			(void)debug_refresh_runlist(pdd->dev->dqm);
 		else
-			kfd_dbg_set_mes_debug_mode(pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
+			(void)kfd_dbg_set_mes_debug_mode(pdd,
+							 !kfd_dbg_has_cwsr_workaround(pdd->dev));
 	}
 
 	kfd_dbg_set_workaround(target, false);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 76359c6a3f3a..dbcb64501cfa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1891,9 +1891,11 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 	}
 
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
-		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
+		(void)unmap_queues_cpsch(dqm,
+					 KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES,
+					 0, USE_DEFAULT_GRACE_PERIOD, false);
 	else
-		remove_all_kfd_queues_mes(dqm);
+		(void)remove_all_kfd_queues_mes(dqm);
 
 	dqm->sched_running = false;
 
-- 
2.43.0

