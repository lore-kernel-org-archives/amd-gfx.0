Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671DFC83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 16:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F32710E31A;
	Tue, 22 Jul 2025 16:25:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5uDJP86W";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D5510E31A
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 16:25:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8xYncaqD+/7vKZv+WnUOyeVm13imcO5FfKApYSydob1t06HNJ9eqzjJQQYjUB1NJoaPkeXYgluzW3gN5rE3B61lc/CtixLl045r7/RaCnzT6/snXXjy4MtwPp6/K3yy747M0aEW8M8rP1tQn8Wy11Af4Pj8OSnQI569ADMISEc0Q1LY7kxE5Aodk/JiJuYY6dQltKAlOX/VysCdMUfR5LLIsoCbGVtWiiv5R8kVTHuJTvM8BOzB16nUPADXOC0MYfGdzk/Ee7nvcrkhh1o8HUgcwtFXt0opLam7urgl0i1C/ekAXXy3LiFLGRG7xSNjenuqd6PhHXYIOjzeGDrviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQdxZhabJoZgCKIGe4HmEAXpGHi3kqO5+oluDa0gwos=;
 b=aLqWX5YgpRcwrcYoqmRIvVYmXR3w+HiztYqgXQDJ2yxVbPzJP3Ro+UHNP5PPH96HMJv7xfyi9R1DAFv5yBIjZeq9gdS6Ol4sgLwXzR/jk/kCj0tk2WwRBEJHGRdsQ5rdV4EJHiIQw4iLhbOzlg+VPC2X4bxieIF8I8lzrF69Ys6uVUdq0fvHQbIKpIxrkp9A9PX/R3utRV1axl6koBIG1rc4VRj4NPGM1Q27b2vXmMeT6QhNa9H3Ws5YlLuSYonxWBgLk8xfQqZusyUc66CiBjXD7W8pmXNu5SPD2mxIhi0QTuLnrue3+ZcMJyeQAh/QVLv8RsQQHTit76RWXMepgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQdxZhabJoZgCKIGe4HmEAXpGHi3kqO5+oluDa0gwos=;
 b=5uDJP86W/ttDo/p1wEjbfOBMv6WqSgKDrc2W4QOyFu02xxkGS5lsOIlZ9cK3716n5NdeGqc2jKCgM2GO1VwVcmH0w4pWEBVDp2RWZpKKj4mkeKn5SAM6Z8ScXuu5HtkRYMqXTpYypGZ24l4ovSKpKf925maCwCelaCA6G0skt+s=
Received: from CH0PR13CA0059.namprd13.prod.outlook.com (2603:10b6:610:b2::34)
 by LV8PR12MB9667.namprd12.prod.outlook.com (2603:10b6:408:297::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 16:25:07 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::ea) by CH0PR13CA0059.outlook.office365.com
 (2603:10b6:610:b2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 16:25:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 16:25:06 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 11:25:05 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdkfd: Handle lack of READ permissions in SVM mapping
Date: Tue, 22 Jul 2025 12:24:50 -0400
Message-ID: <20250722162450.79502-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|LV8PR12MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: a88207bb-a004-431c-53db-08ddc93c51e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x4CTuLo402tgVe+z9lqyHLBEUOTSEM6WNgEtOUgsc+UbvUANisObHSHmJYzV?=
 =?us-ascii?Q?xOdMSIBa0mcF6VWR/Wmq3LC1QdYh1zokoqaQu6n/PTTFJEL1vqIFO/9mLtA3?=
 =?us-ascii?Q?oKlKX5HhOuRZXrm5llB6Sv9nJhD0//oG/avomWTN58qvMBFVk9MgY6KPZLuE?=
 =?us-ascii?Q?3c7lLhscdNFoBLcvXoMe2pZYb/3cMgnhwfzD23/Y5ILk75yvHQaHI/F0p948?=
 =?us-ascii?Q?8JBCkKhYz6DHHjYa6uXSDXICUs+rjzAsM82DZRvtO83QlLiF5+DRI/eXoJoP?=
 =?us-ascii?Q?kva5vcfDBn0jTFalWH5fhEyaFyy7A0rHLKxBAHwByXWFQo/gR+SFJREcXL3A?=
 =?us-ascii?Q?Nlp0MkqSvjk1M+zb4QbYMLYNfWOG+3d4tOSXp6rZ1/UfdUBYSrkp+BYbz0KP?=
 =?us-ascii?Q?gRDYh8xai8q8iDYgSdsnRm3TQpVh3o5L0UWWL3JFAMzPySk2ecdqbwv4vx0c?=
 =?us-ascii?Q?RxwceQdQStQyVF0j/7ZCDsIW2dAEwG91IufG3LgI5eAfsRdePNf0OkxiOMbV?=
 =?us-ascii?Q?tfNckmjqmreTMDZxbVCn/HlPstQiGQHUDEMxujlTsDt0tb7FAUhdXkxLe6wv?=
 =?us-ascii?Q?2KJ2PmwtlPEJfqT3/CdD8ZjoQpisMm37pPr0VWGvCWZNAlA8St5VGtwjnnHK?=
 =?us-ascii?Q?MqXkQYsXOKsIAZK6pWpLUJwDcISGG7NSkH1Q+YDy6zD1pOT6nEymtfheUeEa?=
 =?us-ascii?Q?YoOOUri8qcace8yN8MGHH8+cCrC9VaVf5A1meBv6GEgdyw4fyYO/Nikqu1Rk?=
 =?us-ascii?Q?Gi3ATBQEPO7hO5G9/+f/tYrFsd3TgndJVZS/Qgv3gGoSOVz8QA1/wp780xWm?=
 =?us-ascii?Q?Z8ha07dx+mnmzKnn/egqza0qBX/Qj8IVXfZVrqVTiWihN9W3RXFx4heQHxaI?=
 =?us-ascii?Q?dRnQBqUwVuMqN3ncKHhuJowBVFnHH9Lmgx/719Enna3W8ZP60uvruLpUGGkE?=
 =?us-ascii?Q?JkZsM3PdP85RHIMKjEUPDnOGRXWcd56nry3ulye6D1SXcCGqthvTAsCNrnbV?=
 =?us-ascii?Q?xxX4L5VwObYWKgPbh4dBJGUp6cRwV3UPedIbFd/hbecnnRvHrOxglzD+VdcV?=
 =?us-ascii?Q?M+FqH0tCoH7WHhyJKpVCydseWEnigfUtfNcxsKpq7zBOZ/ZjHWpUXqyfNL3o?=
 =?us-ascii?Q?wa7+qaZk2DW6ra7lLQXbLxXTUzy8fCow+3lqTYVfLynHmu1LlewdWf6JUxmN?=
 =?us-ascii?Q?OxRUI/GUmTe1X83t/k/vccJ/sOfGzBjvACUjuiKr7zRVuUwdm1ZJmsx3uKx8?=
 =?us-ascii?Q?tsCmAI9r/J8GsFh3+v1rUtyxXtpccuaTdtCQuOgSLC4EtgjEXv3vDi8pqHCC?=
 =?us-ascii?Q?6g0h1zQJUx1wF8tmze+mucBg1Q46YyLuD3HNR0ABt13SsVpeRMt+WenZwLGP?=
 =?us-ascii?Q?Um6+U04/Cp+G+C/zIFMdG4EYGicvvtZvY+f0unzYs0kW8m55Wtf/K8bLm2J+?=
 =?us-ascii?Q?RVXeyOxidwHxQUzyHwT9Uob28P4+GrYaMpwVIcvBJOk8yQmghrvPRXRtsD4Y?=
 =?us-ascii?Q?hPkwsQSoXo2r2SIzcBM8Kn+55LZCsLu5Hi51?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 16:25:06.5433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a88207bb-a004-431c-53db-08ddc93c51e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9667
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
svm_range_validate_and_map will continue to retry, silently, giving the
impression of a hang.

If pages don't have READ permissions, simply unmap them and continue. If
they weren't mapped in the first place, this would be a no-op. Since x86
doesn't support write-only, and PROT_NONE doesn't allow reads or writes
anyways, this will allow the svm range validation to continue without
getting stuck in a loop forever on mappings we can't use with HMM.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e23b5a0f31f2..10b70b941b11 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1713,6 +1713,24 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 			next = min(vma->vm_end, end);
 			npages = (next - addr) >> PAGE_SHIFT;
+			/* HMM requires at least READ permissions. If provided with PROT_NONE,
+			 * unmap the memory. If it's not already mapped, this is a no-op
+			 * If PROT_WRITE is provided without READ, warn first then unmap
+			 */
+			if (!(vma->vm_flags & VM_READ)) {
+				unsigned long e, s;
+
+				if (vma->vm_flags & VM_WRITE)
+					pr_warn("VM_WRITE without VM_READ is not supported");
+				s = max(start, prange->start);
+				e = min(end, prange->last);
+				if (e >= s)
+					svm_range_unmap_from_gpus(prange, s, e,
+						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
+				addr = next;
+				continue;
+			}
+
 			WRITE_ONCE(p->svms.faulting_task, current);
 			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
 						       readonly, owner, NULL,
-- 
2.43.0

