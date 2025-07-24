Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00FFC83F26
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jul 2025 14:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66FB410E389;
	Thu, 24 Jul 2025 14:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r4YqKs1x";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 047E810E389
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jul 2025 14:00:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7KtriFq8cjCiUYngutUT/FOP6EMga99Tv3ud/CzrqE3LtejmaXpSolfEAzhEIHGgAp1Ivt0ZqGHfsie1DQqxKj3Ub7fyJCjSS7ptxnJFSeyeL9fWK+DoUP8XsLBv9PhYmrB+SsPqwQeMb21kx5eojfOSQnKev1/Sc/U+I8YOUK7JWuIMw4VWLX5lgD3yRDAnzha2rgWoEsa6rHDz65V9XQFVlRfCMJYbcDVj3GQ5yTKYZl4IT+p81KtcdW62RL8p5MvfxCxLaTmU6qRE1XWrx0ht4UWR0stpfUhI78UBkWEeGwDZuKDh8exyE34UWK1C0YUYhQ56t3pEMcADcf5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vH8goHYgj1ZU6kQA83aQ4+aCkBDkyEFS/loTUQdmf8=;
 b=dhr27GoEFd40iPWXksLQpwDsSwC1cX0BjVNL7RV0kbS2Sc+aGAz03LbWUMadE468M5dncxN9OAA+ZUFvXkCj4iJ8ykymKfQ6sFoy/YUxekjcP7zwqnj45oAw60hxgrCMYvGrbFMYRCG4hXg8cHxqDbB+QQ5FG4N4xuC+W9nzuuKdrbD/momkqGz0+AiWBPwmtjDvE5ohedT9ElrkGiESJPUqFNfBYN9iBtNm+3HzhrsKhp7f25oOQTW1DlV3RlS0uNHrV4RqdYhgXSBhvw/BBiNsz4cmEs0yOLo0QVeX7l5rhGvXOt9GVOqp9yeYakyPTOFXZ15rZz8/DW/ip281ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vH8goHYgj1ZU6kQA83aQ4+aCkBDkyEFS/loTUQdmf8=;
 b=r4YqKs1xUWo+v3x6sc8Dhxm2xX0eDXOEwbfEDiehL7JRmJ/UdJ1tSMaVUOqE6Hkva3gKctw1+wH4sitYuYG3HBBgbFUhE9akFlV2ubWs7u7i8SukNzlWCJS65GNqmFG1xMPR3KBhgwbAqhLA9Ex41hTQ2n0TMWfRfriMENs5gCo=
Received: from MN2PR22CA0002.namprd22.prod.outlook.com (2603:10b6:208:238::7)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 14:00:14 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::98) by MN2PR22CA0002.outlook.office365.com
 (2603:10b6:208:238::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Thu,
 24 Jul 2025 14:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Thu, 24 Jul 2025 14:00:14 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Jul
 2025 09:00:03 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <xiaogang.chen@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH] drm/amdkfd: Handle lack of READ permissions in SVM mapping
Date: Thu, 24 Jul 2025 09:59:54 -0400
Message-ID: <20250724135954.91568-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: ecfd1f06-f369-41c9-5e53-08ddcaba69ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jAU23gtNwxaw984pN6rpXkvPbDaDKMbnyX23bJC7QXt2eLEFekC9ocjRZIJz?=
 =?us-ascii?Q?nTbLFCTLoypnmnyIx8U5TRBXv9PtQToQGkKHKnzVkGBMk9jo1AKW/w53Xgmy?=
 =?us-ascii?Q?KbfeCGxaMN8hH+JYaG/P14LcU9Lamv0Rez5pTw3kcaqNuyukA2P4Xmhc2F0R?=
 =?us-ascii?Q?+0/CEkPMy+BKx3kEUqrfSeLV+bIC2Lw4gmEOXM4RXbeNs2IOlLLwLSy2buYi?=
 =?us-ascii?Q?5yei9ydJ7eZ7cGYuJksyUSzxjwQpWsHsA6lyzMocdgfwZ9FQznC9sJiYvf48?=
 =?us-ascii?Q?FlqWiwQJhMSZejxog4vi6d/7yRI9gZh9adIBaA02b5vm4lkA2kiYEyBPzgRQ?=
 =?us-ascii?Q?19ZvOvu5ISABCqx9Yt3AR0pP16Nov35kItPNKCU7sTZ/znTM+57eHiajEx/N?=
 =?us-ascii?Q?t9+IXjm3prGQnLcpXgusmwbyeqOMkC2K2TMlQbhaMQSrfnYQvBluIpHV9SKE?=
 =?us-ascii?Q?vt+3ZjBMV9s51yCHUOyn6I96AXdH4s4EQ2XMkSOeMbSiUyfF1Zfkikj1aw0h?=
 =?us-ascii?Q?waoh73l7Rvo9XP9m/62vHSspxZb28G5rH7kkyJXQoXgmAqBlIwykWj93497i?=
 =?us-ascii?Q?5+YsbAmw4hUdjEvgDPFkEB6p4c2HKBeU/K2TQ0IUcHJNmfRCbtS4smwo/Can?=
 =?us-ascii?Q?WZ4QevFGuWf5s3u7AdiEto9uZLkgTQ5w7GeUHcMCjGdurbtZIv4uOq4DIp+o?=
 =?us-ascii?Q?mnxbuC6WpGHLVElDkS0l/YNw055+Dpg7Ww0kBsDuYcg6HFlAnKJBVZIau4AV?=
 =?us-ascii?Q?VkZBoTxD+O1i0PD5m1QE7aKzUPtEZemW1e/cVcGk8lgbXBJskiF6ZOLpp93v?=
 =?us-ascii?Q?G24MoBjQbszTvcO3w7EhdxYlIguV8X7ip7vpOCrhbwGcs9lZNbMWKEL1SVfp?=
 =?us-ascii?Q?DS7P08qkfjtOVqX81sgtLvaTQnXpLnIg/XS3PltLVF88fN0zgLLq/Zsd03HD?=
 =?us-ascii?Q?TVg9RlpQl/wcY0xOecPCbsZVxWwPXgU1yJFjEPYPq529a5a4HVR7oLBFQ87G?=
 =?us-ascii?Q?t8/nA/Gd8wfvBol94qPdYjzn+sMHRVHBi1l0TmdVLL+dFNRRWDJ9kZdoXjEd?=
 =?us-ascii?Q?SYsYEbqGlFCsl+D/5AomynRwpMYMaPUDktJxK3GRUb4y1KnRCi8ltKKbKaPS?=
 =?us-ascii?Q?2rCQIsGhItw4SlEptJ4l9eIRE6XMpJty3rmfOZbAQNFPEO2QnX7wKSzc10LY?=
 =?us-ascii?Q?ryqqj+Lnlk5Ekb5I4y5EW/f2k5BV3jYLwpQhONvseYIXW/p5wekEKV6i6C/G?=
 =?us-ascii?Q?ZEDgFzQ8b/uPTtIJ/7Qe1oMjrKRYRcV2WGexN/eechuT8Li2y+6cRoBoT8Sr?=
 =?us-ascii?Q?PP+52T0R2LKSxgum17iMJOfCjfu6qdKtem+6x92V+KTFDSbVEHbAs0uFdmmo?=
 =?us-ascii?Q?aExJAwA8urTFU0CuEd3k89D3OwIR2vqZuLHk5TGyyn6gFK1ery4k0rJfCSlN?=
 =?us-ascii?Q?MjDJrcYBrRYriGg+h/O2VLaBYs3bLVgQsTIT929O2aLzD160gMNNjqZk66A8?=
 =?us-ascii?Q?EaKd2GyarRevv1HK5yFnqYkZZampa2wmFw5Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 14:00:14.1735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfd1f06-f369-41c9-5e53-08ddcaba69ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
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
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e23b5a0f31f2..597b8ac92848 100644
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
+					pr_debug("VM_WRITE without VM_READ is not supported");
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

