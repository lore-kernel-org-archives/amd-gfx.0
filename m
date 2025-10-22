Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09943CCD1BC
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E23E10E6E1;
	Wed, 22 Oct 2025 07:31:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nqDBEcwD";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 763C910E6DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/q6Uo2oMJHd5L2JX8wJsjqzcBQHy/vJSy+6Sj+gPyQegs9uHIY8oqSatnF8Bq50oqdUusCnrwmDzvNAtDdE7ON4U/OguSGA255oubOzQIZu2t8hmXg6KsIIknnz09se6+C2KO4BLS9l9ZeULKkq/JPl+0kJnF7qg/QR3y+NpJonf+WadtIpFuxkWeC7VmAucUh3Y4r7OEsfLLB8qLIXG/D8e70n1idHF7HnKAUPtlkXMCohqCsn73pSHLrc9+76w719umsZPTyeZk9m9dFEWHXOQ4oX1qukgC4dwxm5EZCUFLZwSA0grBhpoY45jPUoy5paCte1HZY9MB/AN3py7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbJVa7mzg2FbZMhN5d7Vkeb+Z8HXxPHxOb6E6lLNrT8=;
 b=s00gHm5K1oZYJN3J+An7Gn1NaMs+nUrkTx2Gp45yMU/Tpl4CxghuLiMRbpzmcl8xPhYEsesEbBHcIhrrCf8/7v4ZQblfQUP4eUaoD7SJ6RacxVpBUxfA+IovfSqzQCqt9eyiMFYxkV+9q4VCWoMJYk7EZ7a2JzKjz0omYe9KHlEEeWvml7UFtNbk20AOmLvaQofTBy2TH7ZbAtVLVsRz295P63FPXRzCyJRufzCrxXin2GQWaviidgtUT7f2E+/0m45FR5ukakwarjlWhax/g4HZ8svcHnTx/QjusEdP+6S0vh34w8cLIWHJCjA4NvWYVBhfjYsKhIPcXaukpjdCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbJVa7mzg2FbZMhN5d7Vkeb+Z8HXxPHxOb6E6lLNrT8=;
 b=nqDBEcwDxP4L366SpcXnpEck9div2q5Wv69LULErrxt8wkpeD0326NNSLXvmHT9W0kaaUPtWHPFWs1MwN0/f17ai4WdAljV+mtwEsB/9xnqHkwf1XzFvKtNG0dZbJxaxqBo9MOfkNH7mj2b8THmYVccEQr+JDPifoIcEwgZUchM=
Received: from MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::14)
 by LV8PR12MB9692.namprd12.prod.outlook.com (2603:10b6:408:295::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:31:32 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::43) by MW4P221CA0009.outlook.office365.com
 (2603:10b6:303:8b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Wed,
 22 Oct 2025 07:31:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:31:32 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:31:30 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V6 13/18] amdkfd: introduce new helper kfd_lookup_process_by_id
Date: Wed, 22 Oct 2025 15:30:38 +0800
Message-ID: <20251022073043.13009-14-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022073043.13009-1-lingshan.zhu@amd.com>
References: <20251022073043.13009-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|LV8PR12MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: 32401e3d-b510-47f8-2abd-08de113d05e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uNG97PkVKgw0xFXrZyV6UvU1izruBNxgcS4qLwxIQY/Mhb3/CiXROJQY0FIJ?=
 =?us-ascii?Q?uVcPBonw8ir/VMN1j2KowBQn/DDV0HQqkgtGWf2RnFY/amBxOGpbehErfupp?=
 =?us-ascii?Q?F2Q0GdG0hxEnpotGC5PGZ1RNgulQ5lmIqFBmVfxU0wVbuCtq/R+gbPGGgqNx?=
 =?us-ascii?Q?DXsbeYO5XybvgPluTNYwM5voXqITIsamwgfHDbKJW3Zm1EEkxtxoQMjDvB1P?=
 =?us-ascii?Q?4WhPmDIYV1adx1O888qDAIHEASolaxohONJi7Mnu407i8rHiP/ITakCJvAf+?=
 =?us-ascii?Q?82hvFwD0zwNojOTkP5NWE8YTsrc1esnNb3cbI6h8ooyXyG0EgGTz0IVu83Yp?=
 =?us-ascii?Q?SvWJpnSE47TpWCnREla2sIT7sKUXUjwIiuBwDJPqIWkaRLLf1RYS0hMBUja3?=
 =?us-ascii?Q?gbYxBsjF3YOLBihwJn3bs5G7TMBsIFivp/qN34PHul+tUNjrUteIr9Aqndsw?=
 =?us-ascii?Q?0u6fTt5ljOuG6SforloPdiJmE78h0+gzG+sDthuXAQ9MFLHBXksTb0fOPmMm?=
 =?us-ascii?Q?BycMHFnedrmbqChRX+CiSYSi9gbJeYlGu6Kd7oBWUzyQ1N3L43xdVczhXCpN?=
 =?us-ascii?Q?JxJpNUh0NzCBkqtKII8OlBcSWkiUtcKnMh3rcufOH4BCVeuyHmUN8cQBMGUz?=
 =?us-ascii?Q?lUx1irUaDUyXm85TqAgiy2P3+F6PHMKlH8AlKr8hNa2MC2lYuhdiSMCbwdei?=
 =?us-ascii?Q?10GocP0siziTzSKlz0lKnQ2kX41SGn09cfU8/SWE7laenwWSfaMAuJvIfOrx?=
 =?us-ascii?Q?dprUc4X55SaDjgJLVPEU8iRwBn8KdDHIgOOO72E1uaqGbO/kKWbXJ5OG+LqF?=
 =?us-ascii?Q?No3Bj44kVhWilmmsnCDHuQNy6Lmhm/KWkxO1lqzNor013VqNdB6PBcw1Yij/?=
 =?us-ascii?Q?KFri4zMgdmkpP+Hw2IE9zncJB9w6+5P+2AebCVCqXTtL6EmNM9BZ4udZzHrU?=
 =?us-ascii?Q?PzpiuQ6VeHCDuT4UZbOiwCEUiG2NEEDzsEM2MdiYo22QRAoKpYEfjuhQW6gm?=
 =?us-ascii?Q?J2+COFc1vWDK+6k2FBrb0SyB94OF7j5U5gwZjByEuaF+lz6HJ74BQCg34M9A?=
 =?us-ascii?Q?tMmkTHCq2uFPic5U2b1j3NvfbCSUv+PE2+YgQMGOMg6/icuDDJcP7XvODuIx?=
 =?us-ascii?Q?FUV2Bt+i7OKt0CxS+LkraY7EaRfHwXoWlEwxkAO3Yl2ckdhN9WVvxqbSM16y?=
 =?us-ascii?Q?O3uUTrqICfgucgXiJESd0iS6vvc6qHxf4goQcg5qWGsY0kFf/M3AGdpYvLoy?=
 =?us-ascii?Q?OxsD6mZXJ4YqaJvaae+NVpwV7qvxGvWrW6yNQzW8oOr5O9wxpoavzzHpjkos?=
 =?us-ascii?Q?w6Eeor8DrW//8CWIfVKY+otFHSho4poS/eqh5i4tnsqFDuGDjzqkwp4q8cIx?=
 =?us-ascii?Q?hT9AY4bKnY39x6LwmSYS1S6L8ulaGsuVqc5NmNSgvDznePPf+LDUWjpWo3Ku?=
 =?us-ascii?Q?8AXjuHDzzbTjIVfi+ytjr6FYY0oIrRBdPp4YxPTi2rdwHvrCSR7REl8JQPJR?=
 =?us-ascii?Q?X6MOES5czHI6vNXl+FHFSy0B8ZnOOzq7HAKKP39xuT383BHFytMFOsYZYPDi?=
 =?us-ascii?Q?H52YjG6csXpaJGnzFag=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:31:32.1568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32401e3d-b510-47f8-2abd-08de113d05e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9692
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

