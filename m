Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42E2D29C46
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 17:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4370910E012;
	Mon, 19 Jan 2026 17:15:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p7JidOW7";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6592710E012
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 17:15:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQQ4W4m4WD0nh8j9j1rP5iYxwKwQosZlURPml5pKb5EUaW1yyL0J/C60g4idsNHJmMhKaPqdWmeDm1wjmaLYPgwS2jeyyTpi/62JMQY8DXxdZQ+xwShJeFkRMiPuKmD4L8dY2DyDY7kJ2PdMasScHHG2P49Fk2iyjY4J8ve+E5F9EZbF3XOpjwOpvOsm7iUqLnWI74ALiNyvOOrjbYW3QgpsqHTxhmzasmMf22RwtygfcyCRxF7zk0bz27vEMIjn/6qh3WBFX53kMb5eXRaY/qgOc+T+HgQn4Nio3vsLL6M9GJAcVxqIdpJ0sg4LHAZZaXwaVnco6xUQucdgnKbbqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dklMmMiuE1Dut0RPEjjov2duWJ/4sfCHk6cksvxrFB0=;
 b=gh0/9QrIC3Cz9lNCQntBUVQmswBaAMqvDTQmWa5JGSDuAwFHREHVUxbRkyIakTMb3rREJW1dPqslyuP/yyIu2mwu78+qkAgJepyqZYYbZWWnIqb1G8tv3Ply7lSPuUlxCVG/v1nTv/uaRChQJ59+JM2Y+2Jb2V6QVX1ys8uyuBN3Q47896enlsLIeJTiCYStJx/nqREREoiUwuDbVjSd3xrtWD0+QII314zIAGWYN82QmM2yZN4BkfB3XDhgdEcA+ZmbXtBZbCHon9RdEOaPcRQi9hnWyOLjkzCsyosw5bjRq1KQV82jcbu3QCCQ6DTtXSoRtK0NasG5rTUsdub4xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dklMmMiuE1Dut0RPEjjov2duWJ/4sfCHk6cksvxrFB0=;
 b=p7JidOW74FBViBXXo5X1viis/E8JB7VD7wgTvQnAvYfRB1WMNK36KdM8flzgiOXQpMW4bLh1XF6HxT1ks2MUZkvIrhICL8AjTpVRpTozZR8Lx7bafPWpCoLtrDBb8CVaKFPxsXba0ZoJMLuk2WC430VpWm/11YNa8Kzh+EdrKds=
Received: from DM6PR07CA0086.namprd07.prod.outlook.com (2603:10b6:5:337::19)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 17:15:14 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::b7) by DM6PR07CA0086.outlook.office365.com
 (2603:10b6:5:337::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 17:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 17:15:13 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 11:15:12 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lancelot.six@amd.com>, <Jonathan.Kim@amd.com>, <jamesz@amd.com>
Subject: [PATCH] drm/amdkfd: add mask for debug trap flag setting
Date: Mon, 19 Jan 2026 12:15:03 -0500
Message-ID: <20260119171503.624080-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: a1bccc21-559b-46a2-d098-08de577e4ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f/Fe+J4RjcXRFnCxqEN6ayiOdVaJeTmUci1EZ70MnVkiesHLQMCJaHaXxWSn?=
 =?us-ascii?Q?kaEh3IWvjpPhPqldIDRhKzjQt/k8hUz+/MM6CP1hR4Y65Cc1cA2EXWDutc6X?=
 =?us-ascii?Q?2g17Q7EF938lLHgwAyneQapEkoWf6ZdW0WK/keQ05aPUYYc9t754ygGS+CG/?=
 =?us-ascii?Q?toP59zO7bl+DGEm4+JJv3bpWIQUx9FC0R5RJUfgvfvhCpBOlHLGxMU+3DytL?=
 =?us-ascii?Q?3FobUi4RseaWycxq+ZzdylKYsB1azAHrKWEfwty2P2QLYNPkM/Mc6r8G3GoZ?=
 =?us-ascii?Q?6rK1PrvbOcXL3AILFJvM78b/fCT6tf+SJaMvt5y0ArSYDzVyexp+ekI8FOtr?=
 =?us-ascii?Q?V+sfz51722VpG7aC0mS9RKsdWGdOZO7bMGczZhdyh6YItdrpyZlnSvx3gVim?=
 =?us-ascii?Q?bppuFlZD+xce0hjak2SYMWbfy5p00vyNJ1up7yA+23Otw/yjtoaqcJWEg1xG?=
 =?us-ascii?Q?FObSLyK0cq78rIKWtBFfmmwxTeUgMXo0j8Y7CqQF4/BVJOR+M6FdaQlqfJaB?=
 =?us-ascii?Q?noknb4TvekoQGbns7IcfOFn/PeM0LHENC519nnNAHBzoCt9kpAuHcbh/IVRb?=
 =?us-ascii?Q?iXV9zqWEIZrB+nNQJ2Q3kXlUf+W/hJyTJSdHp08Y+7dku5oS8JQhJ69tmcVZ?=
 =?us-ascii?Q?sQTzxEaezC08ZY5Wz7U0TOnJqbVL7WXHFdK4T3+lSnggJ9V/sPwHXVipC8bk?=
 =?us-ascii?Q?s6iVOsbYYAefWZoKM8YpG6rFphOJk2pwHip1tZ5Ton0FwMMASvBF/6QIRlJD?=
 =?us-ascii?Q?qso1YUXEt813b9CO+Nzp1DZ4eCDuMzw2SPwOexvAY4UY8HCw3e0pRurwrJLv?=
 =?us-ascii?Q?bwvaR75FybmhmOhy5iqlOlh1dFVh/V0wBzjfTAOqNbRShb/gEaliyebouEK8?=
 =?us-ascii?Q?V711rPZqki+YQ8UaVc4RDe51ryR0w7M5nx4GI7oOmkSFaJVZjQg7o/A8hXq7?=
 =?us-ascii?Q?HiA2QEKMgExpTouEokb2sKsjNapvzfRGbCwuJS5+SjWtBkjqHM9NJ+Gd2/PC?=
 =?us-ascii?Q?RzBqnKHRYteYDhQk+OT0DRqfZGj1pXtOZ9Zz8mo53CivGtK90QLoRbRcZAlf?=
 =?us-ascii?Q?GHlBazP74scOeJIHxfnanWk14IAOqLEZyg+EQDwXuQfYnqyyAMzT7u+i5a1u?=
 =?us-ascii?Q?hY5Ay6mirMQ1cydQguzzqIoLu/lKPrnBTmM9ZNsVGjPnCH3T7a5FF8+Fesl8?=
 =?us-ascii?Q?jdB+zVXlNrX1sZfvMa8nwq72AW+tUUlRoM37EO5YWorGS2Ah/5/P2AqAs6WJ?=
 =?us-ascii?Q?AHaPau8fTomGM7iHgcjKi5/DKL/va5CSm7gVanRySVgVnte9a3StcZSGKPaD?=
 =?us-ascii?Q?gJZU0UVuP8XrBBP9gsKCEpyQ7jBKFlEoqsCGiO0CXpMrP8/BF29RAC+4VpEd?=
 =?us-ascii?Q?+afbiqNbqRa4kLQsru4XV6/qJqyZ3fJ7lKR81GmQ1OP3yz4e7GXwoceBCfJ1?=
 =?us-ascii?Q?9uEs5lCWFYctRoNCqOh2va+sEN59KKSR6KF1nCJpmCAbt3vLZePC6BqnvHmj?=
 =?us-ascii?Q?7AvksFM9jIervYE0Fy6P9/Mc4KLsJgieSg842dOxDLeUOBYjnEU08c9ZQVtK?=
 =?us-ascii?Q?18sRfMW9HqRPa/oHhuI2oo9aT4nQpjUZfhjCikYOb2i6Oyma7lY11p52bDnp?=
 =?us-ascii?Q?YAa64RUN/c8gMBGi0izIddHIKUfdc26693+le1b0Oy2TndBN9L141+hJTbwE?=
 =?us-ascii?Q?0A41Lg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 17:15:13.3379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bccc21-559b-46a2-d098-08de577e4ee1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018
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

to specify which bits are valid setting on flags.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 48 ++++++++++++------------
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  3 +-
 include/uapi/linux/kfd_ioctl.h           |  3 +-
 4 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 79586abad7fd..fd43ef7c9076 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3377,7 +3377,7 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 				args->clear_node_address_watch.id);
 		break;
 	case KFD_IOC_DBG_TRAP_SET_FLAGS:
-		r = kfd_dbg_trap_set_flags(target, &args->set_flags.flags);
+		r = kfd_dbg_trap_set_flags(target, &args->set_flags);
 		break;
 	case KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT:
 		r = kfd_dbg_ev_query_debug_event(target,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index a04875236647..279160ca71a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -512,38 +512,42 @@ static void kfd_dbg_clear_process_address_watch(struct kfd_process *target)
 			kfd_dbg_trap_clear_dev_address_watch(target->pdds[i], j);
 }
 
-int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
+int kfd_dbg_trap_set_flags(struct kfd_process *target,
+	struct kfd_ioctl_dbg_trap_set_flags_args *set_flags)
 {
 	uint32_t prev_flags = target->dbg_flags;
 	int i, r = 0, rewind_count = 0;
 
+	if (!((set_flags->flags ^ prev_flags) & set_flags->mask))
+		return 0;
+
 	for (i = 0; i < target->n_pdds; i++) {
 		struct kfd_topology_device *topo_dev =
 				kfd_topology_device_by_id(target->pdds[i]->dev->id);
 		uint32_t caps = topo_dev->node_props.capability;
 		uint32_t caps2 = topo_dev->node_props.capability2;
+		struct amdgpu_device *adev = target->pdds[i]->dev->adev;
 
-		if (!(caps & HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
-			(*flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) {
-			*flags = prev_flags;
-			return -EACCES;
-		}
-
-		if (!(caps & HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED) &&
-		    (*flags & KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP)) {
-			*flags = prev_flags;
-			return -EACCES;
-		}
-
-		if (!(caps2 & HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED) &&
-		    (*flags & KFD_DBG_TRAP_FLAG_LDS_OUT_OF_ADDR_RANGE)) {
-			*flags = prev_flags;
+		if (set_flags->mask == 0xFFFFFFFF && !set_flags->flags)
+			break;
+		if ((!(caps & HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
+			(set_flags->mask & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) ||
+			(!(caps & HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED) &&
+		    (set_flags->mask & KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP)) ||
+			(!(caps2 & HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED) &&
+		    (set_flags->mask & KFD_DBG_TRAP_FLAG_LDS_OUT_OF_ADDR_RANGE))) {
+			set_flags->flags = prev_flags;
+			dev_dbg(adev->dev, "Debug Trap set mask 0x%x caps 0x%x caps2 0x%x",
+				set_flags->mask, caps, caps2);
 			return -EACCES;
 		}
 	}
 
-	target->dbg_flags = *flags;
-	*flags = prev_flags;
+	target->dbg_flags ^= (target->dbg_flags ^ set_flags->flags) & set_flags->mask;
+	pr_debug("Debug Trap previous flags 0x%x set flags 0x%x set mask 0x%x target flags 0x%x",
+		prev_flags, set_flags->flags, set_flags->mask, target->dbg_flags);
+
+	set_flags->flags = prev_flags;
 	for (i = 0; i < target->n_pdds; i++) {
 		struct kfd_process_device *pdd = target->pdds[i];
 
@@ -555,10 +559,8 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 		else
 			r = kfd_dbg_set_mes_debug_mode(pdd, true);
 
-		if (r) {
-			target->dbg_flags = prev_flags;
+		if (r)
 			break;
-		}
 
 		rewind_count++;
 	}
@@ -596,7 +598,7 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 	int i;
 
 	if (!unwind) {
-		uint32_t flags = 0;
+		struct kfd_ioctl_dbg_trap_set_flags_args set_flags = {0, 0xFFFFFFFF};
 		int resume_count = resume_queues(target, 0, NULL);
 
 		if (resume_count)
@@ -606,7 +608,7 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 		kfd_dbg_clear_process_address_watch(target);
 		kfd_dbg_trap_set_wave_launch_mode(target, 0);
 
-		kfd_dbg_trap_set_flags(target, &flags);
+		kfd_dbg_trap_set_flags(target, &set_flags);
 	}
 
 	for (i = 0; i < target->n_pdds; i++) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index 894753818cba..34d27eb500a5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -62,7 +62,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 					uint32_t watch_address_mask,
 					uint32_t *watch_id,
 					uint32_t watch_mode);
-int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags);
+int kfd_dbg_trap_set_flags(struct kfd_process *target,
+		struct kfd_ioctl_dbg_trap_set_flags_args *set_flags);
 int kfd_dbg_trap_query_exception_info(struct kfd_process *target,
 		uint32_t source_id,
 		uint32_t exception_code,
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index e9b756ca228c..0522fe7344e4 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1515,6 +1515,7 @@ struct kfd_ioctl_dbg_trap_clear_node_address_watch_args {
  *     Sets flags for wave behaviour.
  *
  *     @flags (IN/OUT) - IN = flags to enable, OUT = flags previously enabled
+ *     @mask  (IN)     - IN = specified debug trap operation bits on flag
  *
  *     Generic errors apply (see kfd_dbg_trap_operations).
  *     Return - 0 on SUCCESS.
@@ -1522,7 +1523,7 @@ struct kfd_ioctl_dbg_trap_clear_node_address_watch_args {
  */
 struct kfd_ioctl_dbg_trap_set_flags_args {
 	__u32 flags;
-	__u32 pad;
+	__u32 mask;
 };
 
 /**
-- 
2.34.1

