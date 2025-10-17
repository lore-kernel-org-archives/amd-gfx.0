Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD787CCD1A2
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 08:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C98510EB6E;
	Fri, 17 Oct 2025 08:43:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1iPvgr2G";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2D3E10EB6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 08:43:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1XAWx+rfY5MZrz79wT0f2R7kin+0WoBB6CjqzyuRFu0lZ1OVe3gZNIORzHDmXtoYnQqMt/kufyDh1jydhtaeh7/OHUXmuch4JyRWO4PH4y75mI2y3AZTbNMsb2nB3/mq7JUSa+3S7l0hMXHRUybBT+NeZ4GNZlvu8gPN9aVFC+pJjAVut1/QlsRv9Vac/wf03KnXf4pz1wAXQUi4atTiGCwVxojGtSF9VSRGh/ph89ltmfyh4+2TfgpGyQPc+NMlQALzRxdM4Zi/IYKe791tTo7gyjtLAgRddb+O05MvHwQ62pID1txT/qoG/f74ozf6Kwd9tC7RHcxRDXUDRt5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St2RhCnEpO/jwsap0AEgoHB6QHmpBxstUQf8EnP//Cs=;
 b=GAXzfkFIxodWyR/wecvzX9w+98KqXiyfVH6d4a1hLeKFuvmqfrQZCQKMexpyyz4gdC4By9ktZjZaNqjnug6WNnRbfwV6CsaCfXNyCO4f88rNNCZ45zTAeDPGLYDX/hm49qe9MUepNy2v3hFvgB1yVlCFFsjIWc5QP8cTtEQCUWo8W6X3iheJosqMeZ1W+DUbRG646tHwO3qK5pMKaKKvTJMa1ZZRWMQP5Hs5VFqWuI7MzhpSk9BG3sfU2g2ocrJ2NZN2BDC7AZplty6fZi6mwh71aCxoMC3qg8b1noM07MPp4cQqpy+DfVQJyXYYPd+l9jzAjZWSaoPusp9LRLJmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St2RhCnEpO/jwsap0AEgoHB6QHmpBxstUQf8EnP//Cs=;
 b=1iPvgr2GYXdFO4nvnFlM/sl7836su1yOyQJ9SRW74SP3GxyDok+2iiojq/idxG5ujg/C88F6aK/wWH3zYDYkXTZjVFRsrGC6ppNJ0XW4FdcqoEwZXQf/LdBTwAs/8Og9QpQu9b5qaeFK/sY/HxSUZ2KFemwrVeBhDlqpahpXpw8=
Received: from DSZP220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::16) by
 SJ5PPF4C62B9E70.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::991)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 08:43:32 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:280:cafe::cc) by DSZP220CA0009.outlook.office365.com
 (2603:10b6:5:280::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 08:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:43:30 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 01:43:29 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V5 13/18] amdkfd: introduce new helper kfd_lookup_process_by_id
Date: Fri, 17 Oct 2025 16:42:17 +0800
Message-ID: <20251017084222.54721-14-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017084222.54721-1-lingshan.zhu@amd.com>
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SJ5PPF4C62B9E70:EE_
X-MS-Office365-Filtering-Correlation-Id: ba84781d-99f2-47de-7f76-08de0d593ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?66n9htWsq9/MMs/vdmzsepbuIeAfWiApw/vRNEpX4i5edLeQfr3Rs7N04FrK?=
 =?us-ascii?Q?/Js7XlKXoPqy+Q0xVOkVouFgCAbZ8X25E68FrLU97dH+5vMVcXzuRoin2ziC?=
 =?us-ascii?Q?a3BCuBroE5qH43kCHVv1zKHOTb45BikoRpNhjAqMugliCxaNRXSKU8CQcJz+?=
 =?us-ascii?Q?yeVWz9wZJ6r/tQtxfn+Qo1UvZctvns5eyzNfzdJlGZltiaXii6WaYE8asCYa?=
 =?us-ascii?Q?ugiGzxCZ799uXzFcgs0EJsZx09Jc9NyvlODqOibMu7+Yrc4puT5L1XKqDEyu?=
 =?us-ascii?Q?G34fhjWAnHyo+r065jQywpq0WBanThd5SM9Y1Fkxh4CpxoqindOakT8BbNRW?=
 =?us-ascii?Q?pVMfZAEIEzDahn0ha+nPRSOKqrnuQhyGK4sCALQOJl0tITh2pa0TosDr4BtJ?=
 =?us-ascii?Q?VBJ3Eea2SwuFiQ5zJSAd2Lc6XsUGZDd/FJvHg+qVNu3ecgTGn+K2gIVSp1ZR?=
 =?us-ascii?Q?aZil2mG/1ajt+2xRj3po7t3vbPLWboDL3wgavVOT8U6N07/dVePcwMq66APO?=
 =?us-ascii?Q?HlAM0Q7lumHirgbouaQ5DtiMDktKzMsQ9hZt7la9KE0dYib3D5STu8tVmrlm?=
 =?us-ascii?Q?HcGkk+/jVaFbaXlKLmCDZaPNgdcf6LWbdjkl4Zod/Srix7j3DcjTn7y0lr7/?=
 =?us-ascii?Q?Gim5NhRPQmHvuEHTWCP1GTbn8glDyeJIFV3Tm/c+ro3K5X8GICXiGecwmrPQ?=
 =?us-ascii?Q?za0QvlZ0oAtEa5jueHFcXJfqYwIZs36eQpX7EeC8gTTeEqAUFeHXEnwLaVJs?=
 =?us-ascii?Q?VZ7dfvZrfrd4y+ctsoVuoOCxljg8iszUgqLvCWti5MB6wel/DPls0eTcZuh5?=
 =?us-ascii?Q?ml8k6E7QQjxubyPfHILuQLLtMptCLRuT2Am0uKYhr2Zxq325F08UCyEzI27y?=
 =?us-ascii?Q?QUyOyoSxFTQu292Te5hJOv/EJVSelPxVX9Uf40/jdlzQvXtxeHm44hPiBX/h?=
 =?us-ascii?Q?CQjEu4GlmKpUxRFbnnb4cxY1ke+aJMzPwXr2QOQsRNDXyhQJ2xX6obN/l9J5?=
 =?us-ascii?Q?OtCuA2BJwEBj/mCou9m91mm+nPZpTE7vKU/tBaPgrjEngv2Nyu9/twr269GT?=
 =?us-ascii?Q?CdlJtzaVEUJzB6/No8tcLiTtyS/uEfHiBM0H84ClaznxMttdLCfnqxpY7nGV?=
 =?us-ascii?Q?Q12bn3UNFmU1AeVyfLYjCDx1dv+RDHZIrPtstPrgevfJVOBr1mRKyZfq/6Cz?=
 =?us-ascii?Q?P4crgksKRtzLX/V/6YEdttGub6bWUBp4h3b0yLSkDfT7bPi2WFA6GQYQtLN/?=
 =?us-ascii?Q?DW6FDSBH1ALItiZBCKfpbGP64oYO5EFSnbTl1MR1BekpBjkriV/UAUqYb2es?=
 =?us-ascii?Q?QpGHEte1E/eDBylh7OVNpYFSCxmQ+1rYZv07dpW7/QWwljCa8Ixrb/GfXMNE?=
 =?us-ascii?Q?iFnA07E+rznofKIgieIdVhMTpE2TflwWwbyUZRZyq6/RgVjSLjEtMAriH7+2?=
 =?us-ascii?Q?uw7VKAbpk8RnH+o98E101K+TSTTn2aiitoDLYgdy3tc+MkSfh1mTT1S/YEBq?=
 =?us-ascii?Q?Tt1GrEZFBSvDBygtyjbjh0igEYR4lbQMAFMU623znYeTyuKr9XuRJKyhlJR0?=
 =?us-ascii?Q?Bn/hlWOfmMkU+q3umwE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:30.8845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba84781d-99f2-47de-7f76-08de0d593ff7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C62B9E70
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
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 42b6492d7682..4237c859050d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1063,6 +1063,7 @@ int kfd_create_process_sysfs(struct kfd_process *process);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
 						 struct kfd_process_device **pdd);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
+struct kfd_process *kfd_lookup_process_by_id(const struct mm_struct *mm, u16 id);
 
 int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id);
 int kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 35a9e91650ca..629a706e2a13 100644
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

