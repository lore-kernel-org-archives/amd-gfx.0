Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1061CCCFA19
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A63A610E812;
	Thu,  6 Nov 2025 06:08:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NgJ9h/YJ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79A8110E80F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:08:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRN34fGfDCzkBKC4TBeSNeYFmdDiLEJyt2s5pGMrh+3I/F0jetYWltPLaaxj4W67HCvBXe7vH227mN2AL7faSZhbApjRmodCxXnYt9jl9xKufucTwY8+Af0kYzfHWAGFL4XOhUWCI4cbWViBS2kg/CGbcXgvdYUvhj2oUaQA/UecI2Du2zqR630xHNbM41SEJWZDWMX2dmGMnvhD2WI5uw1EK2Q6mTPFYL8q9W6NHnVD8uGYZhbqgal3KoaFnnLIKjXV/MS+EPXZpoms8F5tI/rqeg1xpfnC253OVBOIt1ppHzN4XPpjHzhewnm1RjPEqjZBP0ARoJEWD0oSLK9tCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbJVa7mzg2FbZMhN5d7Vkeb+Z8HXxPHxOb6E6lLNrT8=;
 b=bVgzQym+CwhedOwqfVmWWNX3K5O468oqO7bX+kgunwAn4+Rptu61q1/pmabrA3MvpovHj25qCSi6ZxaLOUwXWv9TVQ6k0kTcACQuzd8K7+BcsQefk2e+IX6QL6v49CTbRNZ7uQpQyXGlkm8/zcmxEftqxWoYQhqpQIgT7v+wZQSXxghysayq9+6YZ4RO1VoFbEtJh0HgcNB1/2rHa+HayAghB5uR3Ji7pWyvImjnV1hsM/U3+xvj4jBCMgknuePftmA25HWznjfACANDqf3qIA3tqMT2tjJcYPAt/WrHDIQOJyvcH+LdRa0yZdY9fP2qSxKrjZq3oXcQz/e7E+zAzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbJVa7mzg2FbZMhN5d7Vkeb+Z8HXxPHxOb6E6lLNrT8=;
 b=NgJ9h/YJpXsnr3pUDE29P7BX4IFHFfmth/1Ye6C45QP+xpWame8hOpwR+D3ANyItlhdjkjqw4mtANugP6XTkRdhygJdx7fMIreNIn3ybMPzKixjv+DLM0cUKMnwH3VrdVlCv1Oml7/T9macrDk1EPWWs+Q2l1TS0RawSpTR4m5A=
Received: from BY3PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:39b::7)
 by SN7PR12MB8171.namprd12.prod.outlook.com (2603:10b6:806:322::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 06:08:28 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::8c) by BY3PR05CA0032.outlook.office365.com
 (2603:10b6:a03:39b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.6 via Frontend Transport; Thu, 6
 Nov 2025 06:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:08:27 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:08:26 -0800
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V7 13/18] amdkfd: introduce new helper kfd_lookup_process_by_id
Date: Thu, 6 Nov 2025 14:07:34 +0800
Message-ID: <20251106060739.2281-14-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|SN7PR12MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: bb270063-6a05-4b75-4052-08de1cfae735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qPpMWwGAiCuHGM3Tb06/Zz4/+GWH42Kze44dcas/T96aoJvCKsMTIQQwlDuO?=
 =?us-ascii?Q?ON748cjq1fFYw2HSdg9QE7ZFL46jUcAdsNvQtwIulM88/DSLf070We54Gtvw?=
 =?us-ascii?Q?Dd1sIW7WTvgsTvhd7e3xGk9TO7lAJIwxVCIqkOOfPd14/oOzDuv1XEQfTvLn?=
 =?us-ascii?Q?dKfmXLIoMPhs60KaHgvgU+hwvhb5sSllxqKBPzJPucYSLvI/7u3RABMWbxpm?=
 =?us-ascii?Q?iMB3saKuLKGcftd+newbO1I5sv1WAPi5DKWl8GDLVjxNUbPe6m5VTk0VcQED?=
 =?us-ascii?Q?yb+a2Iy/nyMfiLVNE09bh3Vu+HO3oJwbL6iHRvSDg6peBq2Ff6Rwpc69+8e+?=
 =?us-ascii?Q?jKFzto1rbjUljtGCCgZ71EUjwKCU2tDAKyPrmzt3VXSnK8fTL569+mH1eZ/o?=
 =?us-ascii?Q?xUYpwpJk0XSV1xPnMNKhYAdSPxBcF9CmgS2gXT19yF9YnUA6IvEBla4CO8Qs?=
 =?us-ascii?Q?XeSxjCt0mysfcmKpRwiYPjEe5hlIdPbtPtNtoFAmBXZINxBBNl8kxOUEfs3w?=
 =?us-ascii?Q?GjiENIGUkkG9NjUD+SKrkxh4dGgL3oVZAIjso1WCIiwze4MsQbTixu5RiI2I?=
 =?us-ascii?Q?NB1j4XrHNC+2zCusMe7P40pZ2976mOixOoQUZ3L0eaMs28QSCSIYtqIcXg2b?=
 =?us-ascii?Q?CeM4YjuSvsYobhzzdERRXn1zGPMP6sskxiznUx122qedvQ/oOwrR1RutW6Qn?=
 =?us-ascii?Q?inmK7VLij7IgauDOO71pCMkt3pFPhVWNxjBqxsiRbQN+nyot3qeWqsQzsz4M?=
 =?us-ascii?Q?AC6ns3xYHjGjp2+ov1q9wNV6FSx/QQcxZ4kWUpSGoPnpW1CBgWIFIM7ErCC2?=
 =?us-ascii?Q?VO26HElHAtgs3RpP6Xp8+ePZfddJgY4KCxXT6/oCePzDtZ2FL1y0LOFzgAWB?=
 =?us-ascii?Q?ScH9F0MwyBF+PdlZwEMoS8dKU0TucobrcH7AmMNkogbLzeWap7mQpTqQ101t?=
 =?us-ascii?Q?bO9oAfBLhNFAuEIYGOh18QcykMbsTbByH40vR2AagLr9dQ21vxdNp/+AOEZQ?=
 =?us-ascii?Q?W8W3EN3PGKjRVOW2TdLUIEbFH0yo0pTOpUotQw7aCu2D7A45IIJBdiLS5LUu?=
 =?us-ascii?Q?SAKMFAnOHp70H68A3Ctv6JqD1Qr9hHXWbxa95wyDI/ztc54NMkN+LaTkUFkl?=
 =?us-ascii?Q?uXLQ19b+daD88l4sPGcX8AwKJiAUW4pNKrovJbKc5htHr48txu7IdHFIjPI3?=
 =?us-ascii?Q?631L4X67WMLd7VKi8on10xdmCUfqmOnzQa3T4Xa7psQQyD7TmN3pN2Iyy7Vj?=
 =?us-ascii?Q?KaVS/BRWMio84gpuVrdodphslGHTi7RoMyIJvtAxR+LPFWm1yMIy0oOM5p89?=
 =?us-ascii?Q?LQMAJU/I3RsI1T7YOkeDRaHHeki+WQxsKKtrZ2gaBFNEiaW7aLsdpOPvnWYy?=
 =?us-ascii?Q?ZEGVDFwgdkLmQC4H2Pn1ih8rV+fBqPw0IrMbbOoTVl8ZDL/KpJDF6pqcubjd?=
 =?us-ascii?Q?d5+8g8XdCF/hOzMMqFgo+tleALq1XCz46hMCxJEJ9YP5rs8YxU8wz3sVhANx?=
 =?us-ascii?Q?YV0ukqeWvprTWdeWF7rreFiExpHCqaoS8Qw/rs+EVL1HOhc9sGd9VuPJ/uXD?=
 =?us-ascii?Q?3Rd0UybvlKAX2A1hzS8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:08:27.8283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb270063-6a05-4b75-4052-08de1cfae735
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8171
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

This commit introduces a new helper function
kfd_lookup_process_by_id which can find a
kfd process that identified by its context id from
the kfd process table

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index b6ad546c400c..44ecdaf02657 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1062,6 +1062,7 @@ int kfd_create_process_sysfs(struct kfd_process *process);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
 						 struct kfd_process_device **pdd);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
+struct kfd_process *kfd_lookup_process_by_id(const struct mm_struct *mm, u16 id);
 
 int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id);
 int kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 6b39d6314a0d..4350552e9648 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1955,6 +1955,27 @@ struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm)
 	return p;
 }
 
+/* This increments the process->ref counter. */
+struct kfd_process *kfd_lookup_process_by_id(const struct mm_struct *mm, u16 id)
+{
+	struct kfd_process *p, *ret_p = NULL;
+	unsigned int temp;
+
+	int idx = srcu_read_lock(&kfd_processes_srcu);
+
+	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
+		if (p->mm == mm && p->context_id == id) {
+			kref_get(&p->ref);
+			ret_p = p;
+			break;
+		}
+	}
+
+	srcu_read_unlock(&kfd_processes_srcu, idx);
+
+	return ret_p;
+}
+
 /* kfd_process_evict_queues - Evict all user queues of a process
  *
  * Eviction is reference-counted per process-device. This means multiple
-- 
2.51.0

