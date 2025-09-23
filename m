Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97B7CAC5B0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 07:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B34910E57F;
	Tue, 23 Sep 2025 07:26:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="an7ErAND";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20ED610E579
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 07:26:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMbqX6r1r0q1mxeRj6+P+GUE0bVmQLHgnE8XCCVIdQPmyMlvW4jfXJgmmG1QtZg1ILc7gvBc0I40vHgxNiAmGQgYgh2c08/Jj7PMYdPGkOP3RQREVmQN8T3xuopcK4dQp4ddA7zmfHbYX4Mdv3FpowDnSfXhMO1TLQXMXLlAA630sT5Rw+LVVTNVbjZo8DeCQBNAPct8y0vyS9lZtAW7jJ7WB6Sinm/HpI99ZQASuCVr8NhwGhMh39mu+Pm/LaorDXvEr8CMkFw5tuWdLHXuE2wsAK5xEQCfQp5aWOMJjqre6RoJlrnQ+HykAGjHF+dKdqn9mYV6oF9eLpBGSRtwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMQLwK7Fd3CF+aRXvrkHXnFlgKgWhha7oA+NTktEDws=;
 b=HaOebOGMoCNq/DLlITJaQsHUaPqypGwNe04+BbZjOjNdG1nvjgu6S4NBQjyDsUfEFEv4bTMc0VSxmtNysSBBYxUP4Zr+X7wcjVhdL/khyWLhwmtl9X4wuts4Y6MMpeZsent7ZKnodj6XsUmP91twRycFCd96Cl9yPcVfW6+Zv2E4NlSuyAOgJgNqW0Dqg4TDLJwm6iZdKTi7v2K8lCNeva9kQ5yrIq6r2DBMyixfcda7nj4d0XaCjiwVgfGEfhY81Jy+Gxu54H8N6PiF2d5tNvuZuCydhAaB60+BncdE5wQrJZP79UNnGHKbJUhgUMvArM7EuV3t4/OHE7HkBwzHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMQLwK7Fd3CF+aRXvrkHXnFlgKgWhha7oA+NTktEDws=;
 b=an7ErAND3eDSw7vk0z3INGL8LKJNNZk2BQk+9cqD6nSYDmRc2a6O6htDtn/oOsD169UPk4MTEVAUulIo1DE6VmD+FJBT1S+ZpJKkO4ELMd5r8l7VhYdf/6SOWJXUjHHZK4E+YWIPsxr1ikdID8CHbEa3Ykts9d5T4W6JMSfrh20=
Received: from SJ0PR05CA0050.namprd05.prod.outlook.com (2603:10b6:a03:33f::25)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 07:26:51 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::1d) by SJ0PR05CA0050.outlook.office365.com
 (2603:10b6:a03:33f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 07:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 07:26:51 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 00:26:45 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V4 09/18] amdkfd: find kfd_process by filep->private_data in
 kfd_mmap
Date: Tue, 23 Sep 2025 15:25:59 +0800
Message-ID: <20250923072608.252345-10-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923072608.252345-1-lingshan.zhu@amd.com>
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: fde780d2-e7bf-4a4d-d8d3-08ddfa72908c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NOyAJwE99rXF2cIbSplwuuk5pJhviJKAUUaGdI32MNIEUqxvH2pzyKn2s5Gc?=
 =?us-ascii?Q?Uk5AX6YCvMSFpJLbYj3bp271dbEpTjPy4YriWlxCu65hK2CSEUlCqNpQdGFl?=
 =?us-ascii?Q?VvONOa/M9zGvOpkWZOSPWa7PfFCfCvzRb3nBMyzWXb3oABPEUqzgZGscDQv+?=
 =?us-ascii?Q?Pj57JdeIJ9afJiQu/zZV85p97c1hpHopZ3wUx0Kpu91u2byKE2JoKdPHBDj+?=
 =?us-ascii?Q?gdCF/XZcgUpQPM9luIwy6eDPSR6SwjYaBBx23Nnkq4NruWDanzpTplhY16Qb?=
 =?us-ascii?Q?aCXVFKZDuCLY9i95JG6+o4/z5T0UMSIyZevJZ104v+z0qcaZghNFRC1TRo3M?=
 =?us-ascii?Q?J1YKz3QRy25UbvQ7mqsmhe0698XaglzdKNJCNWMKFcQdHlxSfn/cUSo/2TnZ?=
 =?us-ascii?Q?KAMezx24MqThr54s4CZH0JTrYXxZrixB3dEh7m8mq1pR4TqdrraceOd+6C4y?=
 =?us-ascii?Q?NbjSmNxusfh2XPJYGBF/Hh4NAkOGDCXTxjASVmayOQFDe3q7dqyW1HvxrkUk?=
 =?us-ascii?Q?6UlETp2eH2ZDbqfjGnHKWc8B8ZrWKT7szerS5BosU794XoEEiB1k7l9rlP8A?=
 =?us-ascii?Q?JSkZVFgZH5eL9dCL7sj2m1+bPc/s3F+/cBkA0l/Jsi6D/+e9PrZBGMqOzxch?=
 =?us-ascii?Q?w3iHT5MbxVXQiFKLOWIYAr6gkPz9nDSxZC3Eus+q+Kyh4+C0BXt95liO5Ekq?=
 =?us-ascii?Q?cSsTA7N3nimT3rLG3gg5DmlSrXJOtekedHE7381GDE7T795//ca7o2QKitnN?=
 =?us-ascii?Q?3c+1nGaDDak59Jekc+1f5Bfy5GmNP4FhXhAKhJJGCru2xuUGuIualdauNZu0?=
 =?us-ascii?Q?A1vZFFZIPt64UNNfwrOLRbBXLKC/VFkjOjKOPh+XVJ8vQyQdK2E2707JSehu?=
 =?us-ascii?Q?Isa+3bvosRz8wNDqcAO1HmwFuVQ6l3NmVS6Eq0bDqkiviRWu+BpT8PSiXGsJ?=
 =?us-ascii?Q?d8u2AgE5D0gy9ROHsxMpt/d0GSHJi9GSMHodEsOVaLDlVNCZbqeWCBHrZzgw?=
 =?us-ascii?Q?ZwksLL2/zDr+xSntf0rXFAAisgLGld5hUd9XzsbIPFRDijVS5sVfIZUtypJ/?=
 =?us-ascii?Q?swhGFJUCjVofraBzq+76HYJscd3zPQKd7v4rwtPrnzOrS4KZXx5BOlVO6Jmm?=
 =?us-ascii?Q?vWlWPzYGxW9h6byDYjX8SU/6KeS7LNy6QaN4Fw+pJy3/c+D8RIyXE+6HCmp2?=
 =?us-ascii?Q?mjSuk3IFgtNWx63+nAo9TDhGiJEFxXvhSvdldTWvFAossRjZ/4ApPOzFaWiD?=
 =?us-ascii?Q?XjBTaK0P28Fw4p9l9YiBdjlS08arbkNB8olQiD5tBq7aXd2NsPiAuAuaSM9P?=
 =?us-ascii?Q?t6AQzmFi9b6/MS0WWX9bLZUOjDV3B4ZMzEuiLXtdAhae9Q9JU01KAcSrk0SA?=
 =?us-ascii?Q?wJWJouBRt3EZR/Ssn6RCc0SF5Hoebw5TU9IawevSnFjq/Ha10lFoO9Tu/L9h?=
 =?us-ascii?Q?u4txrrkgdyxM2bI2KhQc7YOxbbNjbD3JIf3yXJHA5+tugJt+K0j7qjKjsyT9?=
 =?us-ascii?Q?oZ5P5THGMiKLhIffcPppyDzDsFv4l/jiDw3+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:26:51.3513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fde780d2-e7bf-4a4d-d8d3-08ddfa72908c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819
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
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
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
2.51.0

