Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C57C87FD1
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 14:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8D6310E6BF;
	Tue,  5 Aug 2025 14:58:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lVeQ87E8";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBB9710E6B1
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 14:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMrI8gK0nVGW/EBcVpb9tccKykSkbsfkCdrEMWUMig6t0m158AroyLZja5ug+qgzl+H8sM3ue3QcVwKCMoKg6vJrN01jLbOPZw3XarHkFkG5+nTbgbRZlrxsuqU7XI/byA2CPWlYxE/0Nns3lwxKjPhvlcR7mkvvNqh38xmvxYWVauO5NiiLXS1ViPcpyDDbSKohX5RV1v6zMRndFfihGP/8Z5XcnLWd0fX3cYM3fqmow/S3Gj7IacLjqCZcLiHDcT6DwswwHR7DckJ7D8C92xhKxqtq/xWu3HT9T1NvjDpCCvsblHZNzUpsPBxfieI1uLuWYmfaKpiKbi9t7ISntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQ65cDOn1SNK6OAzoodQh0o1nhQrvFeKmGGS0vzLoMA=;
 b=q0hmNP8Fcby01jYGZky8hZL+OlMMJaIDoAlhz6VlnHJc1QfrOMUaIf/KQl/BPdoxwhcKwjLT+gQ90oWwCtrX1+9VaaYKioPpZFmYYexYoMDbrAVOWl3eRDzTp1cARSF7h/TgpEB3AAvKHGKqfslzukINzKNfUV/p7s1QenMb/31yiXPXGLsy1/SA/Z34vujF7hXcAD4MjDRLSa8q7JuXFNUIveippM7B33vL1FuJNpkuYo3b0TeZa8Ts85G+qoU7oW6/X4o2hMvIHaf2KqZJjbfm/c2vu2GNrAgVu/7NuNR/Gx5mduPHLMlPTadX+7pFK5DLsV6kjZOPgOFyNk9HTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQ65cDOn1SNK6OAzoodQh0o1nhQrvFeKmGGS0vzLoMA=;
 b=lVeQ87E8h8RfHDD5J4JKlkK2afc3Pp3Q2dA0Fl/MsmZ9XKVcOzPqfuT3ZIjoYGn9q1uFrSZwx56mw1eYSOOlybgSnmwhkBxU8qWiVBDSfXDmJflOgYUBSjddRBSmct/6KfBCM8Vk+HAbFDLTn0nEMz0v7fN6ZTemEHpkJFXj020=
Received: from CH0PR03CA0390.namprd03.prod.outlook.com (2603:10b6:610:119::14)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Tue, 5 Aug
 2025 14:57:56 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::5a) by CH0PR03CA0390.outlook.office365.com
 (2603:10b6:610:119::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Tue,
 5 Aug 2025 14:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 14:57:54 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 09:57:54 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdkfd: Handle lack of READ permissions in SVM mapping
Date: Tue, 5 Aug 2025 10:57:43 -0400
Message-ID: <20250805145743.104650-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: e0500643-ef16-460a-cfaa-08ddd4307559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D/ESNmJtJl6bki1xv6ERyeAQ/K3oIfi4S3vFoOaFftBEWHy6kM5BCWiAXRcD?=
 =?us-ascii?Q?Aawbf1Eyss2nA/P/c3i25lf1kf1VAAdfV5O1n946JJc3JHCV+ZTcTAAWHyyH?=
 =?us-ascii?Q?XuogMhiczYPao2zrFVpI7bLQfgJAnTtAanu5EfZqiQbwPCfVbnx+4BnxOhaD?=
 =?us-ascii?Q?sZZMTXyF6PzubBuISsZm7up+ZnwoMmXeUJujpgCGLniGjHHmCfBnPXhFYT2X?=
 =?us-ascii?Q?JEWu8Uup6IzExQodu63HKqUpEa6hW0rv6ZuJONkkfTPe0lY5oCzYW4Ip24F9?=
 =?us-ascii?Q?/Gkr2Ac7TZaV08+sOiePze35Zp2ToDIoUvZT8bQ8Fz0b9q0EOhs07IAwg8SN?=
 =?us-ascii?Q?qkpwFed9pRHUKh0SF083MVH4jaBsSe24HObicTLiwyVNjH7uBmegoe6UhS0L?=
 =?us-ascii?Q?pFlzVTO/NUZp8CEbsk8vsw4Jt8pyHVxdCBs0I1kQL/69CuOkLXRhC3I5lInf?=
 =?us-ascii?Q?T3uVtQ9mMe6BpJ60D3zl0EAY2X/nRO6eKTGJvU4Doq/PZepq1A+uzL//0QIN?=
 =?us-ascii?Q?K1hnFLw0/efpY6vBxFT9Yr4G3/DjTAP2HIhAngmIeZ2U8MrxnL/b9/DTseZP?=
 =?us-ascii?Q?JPTtb2pyWnK47uVfprxW/QXdjXbUg1v4Sgl8E7KGXcxrdpTdn8e0QkvWqSaR?=
 =?us-ascii?Q?avJ4WX4EY2rsSzXT4dDHEFcHc+JE1Q9dWY33ifMr60+l/EW/zJgXl29dNpsD?=
 =?us-ascii?Q?1kWsSM63dfhxk0EXM+b6whf+O2mD18LMQ8e3BYTOwdKoBt/yHsHQ26Sclsz+?=
 =?us-ascii?Q?1B3t3Fhjb6qqWVNDo/BfTYUk+eTntaHGixXUjIev0EE3EnJztwKTle1AJZ0o?=
 =?us-ascii?Q?LzHRl/T1hWY7fYPHcZFwIl3O/wl63Egqq9HWW3LHRf9AfXyQ50Kjr/cC1dT1?=
 =?us-ascii?Q?j6XrF7GVmusBgicIedWK/9TDT36ysFi0jVLcK293jTqVKLFpoNkzsjEMmTQe?=
 =?us-ascii?Q?hR4XRZhqqfjyODTo5UWvwllismnCRjaXZQeyV9SuMqwxBFguM0Q2v395b92r?=
 =?us-ascii?Q?rz0+VQGryTI8JjTVxM6MTIMAZoP/oTrBbfosqF/iBFKFQjEVEZN6VsgBEA18?=
 =?us-ascii?Q?yM9ldVogL2e/UDkD10hCT6mOVzICEuk6fEHW3301mUsYzKgjYMrih/lf5Mc/?=
 =?us-ascii?Q?d1faP8IDmYU6UH5/m3zeERNXx6As7fAkdmRscceisEXQawnTcSzjhUqpN6aC?=
 =?us-ascii?Q?HbLUYKga8+nCqCM2gGlMqdQgvjkgsl0zt4bzguRupkNjRdw45CKridVUIBdP?=
 =?us-ascii?Q?+gOznnwyjFoMNGCOXNdr2hG+bFO95zuTk+xrEo/kBvac4b16nTT/vXSt3jXg?=
 =?us-ascii?Q?MyKiDDnBs5GHdrocQZ9OV8bV3iBHG/zJVjQa3c5tIToOSoLxzruZF9yUYyMZ?=
 =?us-ascii?Q?6f9cipZGnjTIBm87+JkieuqRb/k1/XjB1JTVTNe8aEOaljSy2Z3no/PBSqBL?=
 =?us-ascii?Q?uLxnA7k0MK5gHG6fIE81RP4kId49XNlOVLF4Y49lDydPNvDKHLvrxvs+xy7i?=
 =?us-ascii?Q?A8sp6W4Su+FhnfLoxUKT6GS7hVZxaks1Kjn1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 14:57:54.8261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0500643-ef16-460a-cfaa-08ddd4307559
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745
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

HMM assumes that pages have READ permissions by default. Inside
svm_range_validate_and_map, we add READ permissions then add WRITE
permissions if the VMA isn't read-only. This will conflict with regions
that only have PROT_WRITE or have PROT_NONE. When that happens,
svm_range_restore_work will continue to retry, silently, giving the
impression of a hang if pr_debug isn't enabled to show the retries..

If pages don't have READ permissions, simply unmap them and continue. If
they weren't mapped in the first place, this would be a no-op. Since x86
doesn't support write-only, and PROT_NONE doesn't allow reads or writes
anyways, this will allow the svm range validation to continue without
getting stuck in a loop forever on mappings we can't use with HMM.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e23b5a0f31f2..449595aab433 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1713,6 +1713,28 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 			next = min(vma->vm_end, end);
 			npages = (next - addr) >> PAGE_SHIFT;
+			/* HMM requires at least READ permissions. If provided with PROT_NONE,
+			 * unmap the memory. If it's not already mapped, this is a no-op
+			 * If PROT_WRITE is provided without READ, warn first then unmap
+			 */
+			if (!(vma->vm_flags & VM_READ)) {
+				unsigned long e, s;
+
+				svm_range_lock(prange);
+				if (vma->vm_flags & VM_WRITE)
+					pr_debug("VM_WRITE without VM_READ is not supported");
+				s = max(start, prange->start);
+				e = min(end, prange->last);
+				if (e >= s)
+					r = svm_range_unmap_from_gpus(prange, s, e,
+						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
+				addr = next;
+				svm_range_unlock(prange);
+				if (r)
+					return r;
+				continue;
+			}
+
 			WRITE_ONCE(p->svms.faulting_task, current);
 			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
 						       readonly, owner, NULL,
-- 
2.43.0

