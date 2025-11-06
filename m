Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71969CCFA1A
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1045710E33D;
	Thu,  6 Nov 2025 06:08:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wL/7pJZR";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011054.outbound.protection.outlook.com
 [40.93.194.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F00110E80C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:08:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPEO3fvn7/zdEu7oZwvM5e/vZXOqD2+JBmQWPoz+mYqp8wUUcw/STMMpXSBGb+8S8lqzJVUNyQ1Ni6syG/hRIP2K4zkAQg7NSvQWjIRJRWpKtMwTh6V5mnOQ5HeyKubsd2kR0GZsUC6DziZ0MVonrZe5UWnvoPQH1cKEg2WLXIyjXQI88G/c2PwIJ5iUZNjkVr1bdxWhqvL9kvhSu5GGj4Pc4lIRIPRpUY40MoHjurncqBRUnWLIRkVgDldcQ8zsBbbv8bj8Gj5pWFOehFs9n9uuocEr+pTYmf8Ei7R6EcRc75EpCvPOgDm86lFUlMJwxsuijnd36z0QrNprxyJCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugjr48C4lYdK5G2xnVTp4IKnjB+cjpY7U3Pd6nLUX0w=;
 b=fNETw+DJ6YWel8fJqQPcu4NLWEhvkOToYpawVsysaJApptlm51wp30Hx9bu7wZp7GvgoCjby0Y3sm470UIr7QH5A96JzeV0oe2KzX6ZKESeVOhiYXLehnCNrSt8kKSVXDztWHzHW46XqYpK3G4HjKzSK4NMcwdc9RE26XeB0YHgHzdMF0ktJGUtKNFkLhbNsim1VOBaBTNnoZfG9D52ly4PUJTXgaC9yHt0y/sYhoWf9Paz6vMEH+ssEO5xePKZnUrFvUmNZDc/Mkpo4/3Cu1ViFdw1z+9LmD/vstdK06T8eDq/0D+cEZub71qetbGb0G4AvFiW7Szxw/yEnz5EtdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugjr48C4lYdK5G2xnVTp4IKnjB+cjpY7U3Pd6nLUX0w=;
 b=wL/7pJZRRnXFO9AKMDhoyLQ+AdOMDavCKqVnxpKXV/p43VHJjRlCb7YQsm3Ovqk5G4QP8ilGfdBQ8HGLeN54YUs7qR/dQYkExGn6VO41D6i5kbR4RDbLC+MeBYXqLusIyYbGdS+ws7fXx5S+LdWRj6b0Y9dPaBNdca929htyZOE=
Received: from SJ0PR13CA0127.namprd13.prod.outlook.com (2603:10b6:a03:2c6::12)
 by SA1PR12MB9546.namprd12.prod.outlook.com (2603:10b6:806:459::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 06:08:21 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::39) by SJ0PR13CA0127.outlook.office365.com
 (2603:10b6:a03:2c6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Thu, 6
 Nov 2025 06:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:08:21 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:08:18 -0800
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V7 09/18] amdkfd: find kfd_process by filep->private_data in
 kfd_mmap
Date: Thu, 6 Nov 2025 14:07:30 +0800
Message-ID: <20251106060739.2281-10-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|SA1PR12MB9546:EE_
X-MS-Office365-Filtering-Correlation-Id: 421f5a56-4668-4a8e-82a3-08de1cfae332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lYGVz8a+Rl4kxhrPRPTXpl2PvYyCtXn9tYyf34o6AY3eHp5QxBfqFPVhD1F+?=
 =?us-ascii?Q?cDmtd7Tg6eYAt5JJ/8ZATpl8utliRu5WjikEmgKUYPgl4GWbLkKVpBMZc3dz?=
 =?us-ascii?Q?au4vqLG5ELWx6afTkhS7O1iuIN6jFJyVLZdN1TgifEi6h7FLyN5cVWP5OMEw?=
 =?us-ascii?Q?bPBTPaatS2zX7O7ZNLdzoM88j/D1/16L6xOtFQ6iYkk+leMnFASf8HJKtk2r?=
 =?us-ascii?Q?Uu3MTRBf5TTxGFlDJWeRvHCsdH5yxmir5I5sYf/bOwvwMIA7hJnGhzGPdPIq?=
 =?us-ascii?Q?DmJ1MoMGabkB++SEbzSkIErnmyTFjI0+ydcz1XHYpCI7Cm9xmIys2imVMX6x?=
 =?us-ascii?Q?7IB7hcCiZ31bsSVbM7xvYZUgrgv+P7iAZwJtg9Xny2Er6HA7LcSUZvTsF/US?=
 =?us-ascii?Q?rzSCnu+UAyVf/Hq9eAH42zxIMF7XDMtC9F/6BDu/X5xKsQaK6B/55E2YgC2H?=
 =?us-ascii?Q?0bKu+omYxjOdDMPQkzjs6rBxrBCKywPdNsHHrxWdb4qD80FMZWdrnuQxWdpQ?=
 =?us-ascii?Q?lkzDjyNLM0qCPnoY0NRviwhWX/KnLgeoZML5t9MczM4AxoS6r8jacoRPhxrh?=
 =?us-ascii?Q?b9AVbSE37iXZNjIMCDlqH6i9gYwbpK9a3ta2ZKMztxZ4lQFWr6tzLi8efuHR?=
 =?us-ascii?Q?eIyEZZ+/Zs/8sYz9zOxWqKjNE3DrovLgcM8mp7q800y9hCLvjlVGElRjS0bo?=
 =?us-ascii?Q?EK+R9RNNGhYGXPZrxOJiKdMcccRknNXG4KabnGb6doHxoeTRDiD8Ke52QnGn?=
 =?us-ascii?Q?v+4XvKIaCI3Yitc62LG+pYbkFm/Z4wtEp60llDu09VYex8vTdlvV6zbj/51J?=
 =?us-ascii?Q?uhi5UegLnH3I8bq1Pq1YnWYNN0p3FtPlgm5+UrRs+q6YpAk5uszQvfAEDwwZ?=
 =?us-ascii?Q?CSMBQd9utPk9TilUy/KQhiyEBV4mdZkxrimFDu0HkF3VFBhJueYe+DCZsDg3?=
 =?us-ascii?Q?Puv7sLIWE1Ek15aGEKmK9yxK0P+mMT5/2xYikHoBZJCWzOuenVx3oSPZ0M7U?=
 =?us-ascii?Q?nXZOZI2eZYlScp/nO3tgjPHTb2zVYLzj5WS8ytuxbftKXOMCC6Gh4iMYfkBw?=
 =?us-ascii?Q?LLmB72D8pIcR/HgVEsKg0Otr+XKbqANY0iO1dlDfelIjh+Ll+wC48iHcDxRo?=
 =?us-ascii?Q?4Ki9xtx/jEyzbVEBwkAcM21lzFJX0g13r9J2zhRI+Y8ODyaBaSyD97HN8fpH?=
 =?us-ascii?Q?a4+7eimL+uWE3K9kJBcwIy5iZgZWF26ghOBATvwLOE7fQlGBESC+isndsWdG?=
 =?us-ascii?Q?Ljig6EibYdeClW6I0h83lvwdaa/7fMuIJVDiHdMt0Olek2KjgG6I73kgG/X2?=
 =?us-ascii?Q?ZjAvSKeaFzONgLwr/cPEjVGEDAItH6qFezeq6W+4Vhrh9jYeXiZQ39k8cZdS?=
 =?us-ascii?Q?x+IeSgXVYzWRrUZC8uCA2cjs7Vk9VCVHkeqwlODq3UE2p4QL4SrYbZTwXvQm?=
 =?us-ascii?Q?7VjX/uBd3KfC8U4713QCsXY9bXOxuvF/3eJ84WJOUexhE0TWbIKDhfRCHdjW?=
 =?us-ascii?Q?Eo91HJEtMmaRnXK8LCQZ/JNoVQPrtk7UDAJKCmvTw6cQQ3LvVpa13cpDE0mm?=
 =?us-ascii?Q?+JKRJR5AHAo6hZOpulY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:08:21.0989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 421f5a56-4668-4a8e-82a3-08de1cfae332
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9546
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
index d1cb22f48b00..73de2de8be0f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3410,16 +3410,19 @@ static int kfd_mmio_mmap(struct kfd_node *dev, struct kfd_process *process,
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

