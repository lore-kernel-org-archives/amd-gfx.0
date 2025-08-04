Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40286C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D57E510E438;
	Mon,  4 Aug 2025 11:06:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EiqF1zSv";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59CCF10E438
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxIhAO3wwEO5GUZGl8RpHIEd/frdomPFhnIid4k3le/d9foLohWZDNx8TXjwGRA+t3boWEes6A0LfzIXS9WXtp5VLx9FHO9TSeVZX5cATLtlBQVl0s1j+ieR2FSC18RwXJG3m7hscfAKFCSyKjop/P/Hj2JAXToWCrH/uNMVtsHV4ivGXIFFNjbyz0j78nUlAjCcBd+OW8gYnwWkTG581Evg54pL2PSqlMK9t5xHo0RjqfuyFhzC0a14I8KynEKNatopkmHntwCualsDxrNPHYCn8H36IX8oWGQi8NC7QfArH9PCb3v+OtaRRGg+ITyeFlAvNMkba8ylNP1aJENHYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qY7G/8Uy41lanF2rXu+QgUhsJFG9zJkbMkVcocXcYQ=;
 b=GbCBzdOTbikcEp+u8he3nMuYpv/KJTPFZ7QL1WNdptCmxtUteP0sqY6CwxqH9qlF0jdn53cu5NlF4hwFm0uyE0OuPKpvdlJS0KH0bhFosTDH+RVC8ajLUn0lBwoS9qFFXA+0W0vv+RgQDluUYcXGizv04bcjwXREEFGGice0GR2xhZjpeQ55w4y2kECDv+F3Y/X0bYamqR0oE+lC9mizcG15MNBnVkLPkWQC7qqPfSEmOTqJK3Q6dcemLqn1/lFc7So8hG0NxyBpNaVvx3jy8ATLAGV96Y/0YygSDI/wRg0dC6vu6M2TAH3Z3I5UL9piJlKVAMdcqUsNtckqst13bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qY7G/8Uy41lanF2rXu+QgUhsJFG9zJkbMkVcocXcYQ=;
 b=EiqF1zSv1rp8nMb9crLZ+ciuXV08tv9T1RHrgzd//99xPD1mpCy6b41NLxJnNYih+58G1TpKwhNU1qLEJW86y6GxR+7rNKqtMlESBcfVZGXj37KC5FbIMly29io2vZlpQuqOQS7qJqgNguMBKmjmhUPx9czMAxtmZjrM7OOFHYg=
Received: from SJ0PR05CA0085.namprd05.prod.outlook.com (2603:10b6:a03:332::30)
 by SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 11:06:44 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::ed) by SJ0PR05CA0085.outlook.office365.com
 (2603:10b6:a03:332::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8 via Frontend Transport; Mon, 4
 Aug 2025 11:06:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:06:44 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Aug 2025 06:06:42 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V3 09/13] amdkfd: find kfd_process by filep->private_data in
 kfd_mmap
Date: Mon, 4 Aug 2025 19:05:46 +0800
Message-ID: <20250804110550.261311-10-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250804110550.261311-1-lingshan.zhu@amd.com>
References: <20250804110550.261311-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f3ed5c-9616-4dde-8f6d-08ddd346ff72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fkOoFc5t6qn0sWKgEpyarPZHmuUqi7UsdxH9ajwww6aNYYxvAXshPNrdGBE3?=
 =?us-ascii?Q?1Mhf/AnkvX9cybz/5Mdmj0g1GcS7pv2KiNi0d8QeiWm5Dd/aWY+oWzdmuimv?=
 =?us-ascii?Q?4veXt9dT/Rv+zNQz/YI3JpNfmz1AxVLdlNmgHY2Msy4TDo73fGHo/S2pvpl3?=
 =?us-ascii?Q?ATZWLOCkt0az/S+eJwnApc3Kz0murEjyI1jLxjlY/Nf/KOA81VPRC2L1WUi/?=
 =?us-ascii?Q?oHvfDYjERVMOqCoGFWkXb7E/aCK1Ji4FaTj5wtnN2qLBKrT4dun0UEv28ySN?=
 =?us-ascii?Q?PPqVXEwRqtUfz9aUvOaL2LJ1DQEPHnODxlIr9lp3318W6Cth2sPcTbc8M9Z8?=
 =?us-ascii?Q?6Hh5JUaluflV0f5YLJDW9Xxq6QztK/DTYuvNkSTPijfMBJpf1gnDObFeAVO6?=
 =?us-ascii?Q?UbkHV44l0JrasIQg36RNZ9MAeHNAocfI9dbs5+GPy4zvys7aZBtFADAHgSMb?=
 =?us-ascii?Q?obbB665yWHxft/i7sKBHJiEqoEbTsC0HZioPm322WyJgeKHj+B8Zl/fFJM5B?=
 =?us-ascii?Q?WQAcZFLWDJrSrFWKnWlqzkqFDsP4x05zQ6AnEmHJgm4W05sGmoMQSm1PP5u8?=
 =?us-ascii?Q?AhYRWJ/A7aCV5zTL/iSPFuddCPMYmhbF1uI2F7NzQ5BleEhrLVD/fADB41Of?=
 =?us-ascii?Q?bb7mVeNfRqtLI70QcLE1CItxLjAy5T2k5LHWAOlXNqcCR5HhQsxV5sTKXg4m?=
 =?us-ascii?Q?NPpl8dK//EOxsAKFJaJrVa4A9A+/jMANgd1FX0cOwkEIXxaW3OX45Liu/4FU?=
 =?us-ascii?Q?DGEBAKJ7WvTdo81+MCGG56St48kA/vK4Y1ZZZCoV/iWSDsCHa9xOS5C9sV4x?=
 =?us-ascii?Q?ljHoIT2fQN0MwLnWisKalz1UtOjDI7Z8HUBDY54n8cYyXeM6EdPCNW0n4Za2?=
 =?us-ascii?Q?s0e0WQ3M0xCja+sGUjaVcbvwxoWpi636uoIU73fw7xDqlnuyJq1dOL8qX/0E?=
 =?us-ascii?Q?43htsy0sQf57Nmn81CQ6W7MH/n50YQ/87V8Y8P0U63TPPWGT/tIFWxJ0tQfm?=
 =?us-ascii?Q?dpCk3/IN85UAcEKLbXgWhlhNjxEeW8hn0Hpoqkd51tOVvJXQGYesm+AYrAFn?=
 =?us-ascii?Q?bbyd/b5oTDvBDG7uhIwEAPSpoSs34PRQZ5wgHYspCqKXHreGOSUfGho9zEdd?=
 =?us-ascii?Q?jc5RxPv8NtqlAIKpx2+DHOsepwXiX+5qyAgM/ZNIjXdVovz7xFxFiF5wDFGp?=
 =?us-ascii?Q?xJWdl57qmpAAKTFg3YRoHMjOl1RS5uHXEsXAYJ787HHmbOMD1FEsBn1N5W5j?=
 =?us-ascii?Q?AwZo7mTutw38odWA39tEwyJqD4jNT0i9Cnix75MtdrxwlK/M3N240MDs2gId?=
 =?us-ascii?Q?w3j6X4X5f6mYbmP1Am6/FjacJgVS787QktYrUM3fnDmuSiZ+3+l09dIn6+Xz?=
 =?us-ascii?Q?dOT3PrMLDB7R9/ZdFH/PCtO79KoDYsj8cDPIIZsn8ONw4QmoDzS8hY5szVbj?=
 =?us-ascii?Q?1mpUR2E8rsWPdZB3mBcppPD9xgPgXWrCzXbulMRiuw9YlnVNhIsUh7P/d/Ic?=
 =?us-ascii?Q?Wh77uCmMKVizwRmEnb8lXsX5H323h8sEY2VM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:06:44.2004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f3ed5c-9616-4dde-8f6d-08ddd346ff72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088
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

This commit finds the proper kfd_process by
filep->private_data in kfd_mmap,
because the function kfd_get_process()
can not locate a specific kfd process among
multiple contexts.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 28df35a63c29..662b181f1fd2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3407,16 +3407,19 @@ static int kfd_mmio_mmap(struct kfd_node *dev, struct kfd_process *process,
 }
 
 
-static int kfd_mmap(struct file *filp, struct vm_area_struct *vma)
+static int kfd_mmap(struct file *filep, struct vm_area_struct *vma)
 {
 	struct kfd_process *process;
 	struct kfd_node *dev = NULL;
 	unsigned long mmap_offset;
 	unsigned int gpu_id;
 
-	process = kfd_get_process(current);
-	if (IS_ERR(process))
-		return PTR_ERR(process);
+	process = filep->private_data;
+	if (!process)
+		return -ESRCH;
+
+	if (process->lead_thread != current->group_leader)
+		return -EBADF;
 
 	mmap_offset = vma->vm_pgoff << PAGE_SHIFT;
 	gpu_id = KFD_MMAP_GET_GPU_ID(mmap_offset);
-- 
2.47.1

