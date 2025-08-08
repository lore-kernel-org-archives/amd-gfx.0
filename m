Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFD3C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 20:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EC0B10E02E;
	Fri,  8 Aug 2025 20:28:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UeIDkm6M";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 392F010E00A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 20:28:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udW9mbcYic9wC11trFZlPoeq62ih0vm+kajriZVNj6vLwhZ8WE4RamIk8G4t8cs5kLoveCz72zhGfNKKMpcncy3yNH/yXOC16ceaKLmqorR/Y/UrEYLKe1qMSW5VB2gDisTUB/+Y0nSMsysud4OQ4dNoqtLMg9mReL3yuO+HHXQ/GhAHuNXkJyDOksgGenznS+I/aJsjopgOzTumh+0heiSxjPPFnWRmEn69uUjFq+QCsT7/rO8BgBaTfMpTUuiLiok32SzBqhbOHv+yXNxwMC/Q+/SV4kWYJ9LMyDWIuj0QMjcYoV1ulQOTzNacOcrurRacuT8/BDARFf2ds0447Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkcI0YXjQ/uOkXXhN5XoiUUE0B7vdYJGVBhtQVgkzpE=;
 b=TjP+UGn36pMdQfB7O9wkTJGOeU3qEOHjYXXwgFPWTRc/D5sxSzO2zoHsYUepxO/AOhL6WwEVm65bIAGa6uQSH5TlWUi9uBt2sgL5iUcsV8KVzATIpZnH0Z6f7+rxYSQEw724ybCRi9CaJxA18ve3eN8/en3mr11sXNKKb/EuSGjcPdshAEW2KZ56gOE30IeGG383tRrw+li1sIC5ewK/HaUv9ma6i7CB5m5I3fOYEvHQgSseu5QHNwuuh1GtrPAp2MzJ4d3fm5lgRtZX0SlXjyfMpDT/gSRRvoKpWcfQdAeeyL+F7cPZ9aVOxQzG08sj496kQLCMAhyAE874OnL19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkcI0YXjQ/uOkXXhN5XoiUUE0B7vdYJGVBhtQVgkzpE=;
 b=UeIDkm6MoJYPscOFjyjudkMNnhcT0W7U0KC9Uyv/grbZ4l/NWu4EofVZ+p12kIN+bHPldqaqfCWDXq8SVL5Z4NKMe+zDCZDYz9EMnF4mmxVziw8Sq02thleGXwh+Paiv6hdRjrpGwZ8/Otp8IKmgboBqbYg1QwP/FonBVHqVTuo=
Received: from DM6PR02CA0071.namprd02.prod.outlook.com (2603:10b6:5:177::48)
 by PH8PR12MB6697.namprd12.prod.outlook.com (2603:10b6:510:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 20:28:40 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:5:177:cafe::14) by DM6PR02CA0071.outlook.office365.com
 (2603:10b6:5:177::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Fri,
 8 Aug 2025 20:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.0 via Frontend Transport; Fri, 8 Aug 2025 20:28:38 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 15:28:38 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdkfd: Handle lack of READ permissions in SVM mapping
Date: Fri, 8 Aug 2025 16:28:20 -0400
Message-ID: <20250808202820.187372-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|PH8PR12MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: 31baec85-ccf8-405a-1d2f-08ddd6ba287f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rya1jprE87cfJrzdNBLcDMfuUxcJ8zaPddRzTvAADpLSl64dasxls8qeElx9?=
 =?us-ascii?Q?UWYGhIBTYff9rT2hGz/NxmkKDT+LJmUxPyJoydGxVVcrJdfn/31Xb6YMGufy?=
 =?us-ascii?Q?4/EPtqokpW+snm6VmBH9UCEIZTHaSZ/mrp3M/cvZiyUCFhkOQHdMvaxeqeYY?=
 =?us-ascii?Q?qJRrv5KFdKXJWdVTpV4E3Y9f779nox3HBxRI8Yt2L55wiyPZ1KBp6Ih30JPe?=
 =?us-ascii?Q?61Ykbhux7/u9NQpj4sO2TsLvO7tCY2pYOmZ/KIRFYrz+ovI7nSR1PgZ87A5J?=
 =?us-ascii?Q?PX6Do4fwuipoBNFTIeLbP9joDGx3D6tXEAdreHvu7IpDlolJK1mPKNfDziCk?=
 =?us-ascii?Q?LD37xqiM8CEF9VGAYuLzYR4Rpe0+bvUORRHLwIIWcRSZ+5YZJ1KFe5GILU1f?=
 =?us-ascii?Q?d4Hj61yjWiZr6YPg3uEShdebWhunlNI8E40QD1vyLjPk6C6focJK1DlfjBXN?=
 =?us-ascii?Q?j7NkNMTdxSxu2oMXOdHawNY10j4J/7EIqCR+3M1h/nAfJNuHFE+X1jNMyxmw?=
 =?us-ascii?Q?eEdE2l3PW49FyemCGO8HFo2TGbgbcad/ZcBcGTkMlcsAJqWBm8F9taONuX+V?=
 =?us-ascii?Q?fRkOdIVCLb281UdvNU2rQBncBwYywoWNDFWMl5u9ZsKIZHGlPyoPXAo3hQmV?=
 =?us-ascii?Q?KQrhz04mr0s3Ns314gqQThmielwbAjaQWEd0SFWKYy415DRLWRJux9tPns3p?=
 =?us-ascii?Q?r43rTe9eUH4fdgbjdS69BgE0mp9/lmpXok2ddGs0zpXm7+KvXlnCPic9f2th?=
 =?us-ascii?Q?zlfJZwM/C21+fD8g40GN/CSabnzssUdhkAPvhdTzfRCBSzL7RpHMWIdyEbjw?=
 =?us-ascii?Q?czdjyu9MUAtc7ulOPV15rTldUMZXFLpM3hSwKhGkQ+5j6fwRAtSPzQEmeKcj?=
 =?us-ascii?Q?8n3M0DrNFG7xvMOTdYr+utz4xf9jecQHAYKxmCjieMlN4zzUX5pTTG1ZOAyT?=
 =?us-ascii?Q?H6T5I3wlqr1R85HcxB4TG8IETsrybFAA+X84zuf/iY4GLyJW1VwjaWSuH7HR?=
 =?us-ascii?Q?XAd7ajc4RKTKQNQaY1nw3psCCqext8jQv2d/2Ki+A3UEYDHHyP6s1t9CVgFm?=
 =?us-ascii?Q?/YvIsd991hZ3vuflIekPtuJK+b73rVFo1z3XcawLNZO+5ZnGR+ieSYD2r0BG?=
 =?us-ascii?Q?5B5oca5zIlzOC69mjUsFI1Gfav9hlhYX3jLL904J9AL8tcnWOwcWj6YNwBMY?=
 =?us-ascii?Q?mV8lBsggDCxGfWMYH8wnsvZf3LzGsklZt4/cfIEkobsTbRBN2bFq75wOSTa/?=
 =?us-ascii?Q?XSSDLvEIiIrHp3AzeKd1UCJZgodThAnjtZBUeSnpgdMXxNAG/80j7e5lcRTb?=
 =?us-ascii?Q?wdS/X34P9HQHNvR/HA+pnlrxn8yMw9Fy68rHiBfSIf8odCnT9uA758zxRila?=
 =?us-ascii?Q?V92wwFklIalOVtkiGMyc+4dVg4OBCAj57RKQaEYhkXYbFa5X3pvJ1/q1Ke5g?=
 =?us-ascii?Q?xi94XtRHkzGqf2Xjs4YzN3kUBkOvrQkAH1hS88UI1ZjE7cWkGOaa7bcmmf2M?=
 =?us-ascii?Q?D7LWEgeAE1UBa2M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 20:28:38.7603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31baec85-ccf8-405a-1d2f-08ddd6ba287f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6697
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e23b5a0f31f2..521c14c7a789 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1713,6 +1713,29 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
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
+				svm_range_unlock(prange);
+				/* If unmap returns non-zero, we'll bail on the next for loop
+				 * iteration, so just leave r and continue
+				 */
+				addr = next;
+				continue;
+			}
+
 			WRITE_ONCE(p->svms.faulting_task, current);
 			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
 						       readonly, owner, NULL,
-- 
2.43.0

