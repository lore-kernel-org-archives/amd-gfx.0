Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC90DCCFA19
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 06:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E81E10E30A;
	Thu,  6 Nov 2025 06:08:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KY+Fmt6t";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFADD10E339
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 06:08:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inP3CE+P1JVypVo0LZ4NNv59bqJmZwtgGdATXof/dcCnwFCAqCw6vwp5ctcrNI/GeX16U1gcTSFTxHCh8s/L1FtXoeQXZ5n/5MNzIiKX9CwHTyDxNwqyXDKLK+TGMHR9hf3DYV7J96QUeLaGeGD+ZTJEiVvXECXMQg5Xud6Y3NoAY7V6qip6GEKACYMDuCtETjF8hk7pt2AX4FfHcY5aS6o5u0XokjIrrV3MqJ2veiQCf/Oj1bJoXekH7CCgnnXRTMeR0oxfTudRh50Sley8nqBHwNKmeQY/FvRo1JTIYVxeF3Tlc0HiQC5Me/jGwIkNgx4GAc3pekudRBHmuhYHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsiIS5E+7WsEvir8Vqr5V8zZ2qv59nnMARz+0TWdhP0=;
 b=pWbkMGAHeSk8UTb4i2JyG+ge/QKoDAIw7BwtMbYtMzh4lGgq+Caw4LTXxOi0eqesM2R/xKeQM+yPIANn7cJqwrHUf+Qf4BzT30UA8Qa9GxztwN5Ftvu5YHY3kjdmVb6rzRg+9VWpBbS+38bZMuAONLit26gJhjbHeFjRwqEWxB4V28RqhuuAnrCagqHO3MRjVh9bjipYVzQrJBicYPY7n94DUWqvGNNSHqofJ/QckFdtpOgljDzf3fZVdcEA2ksFjwnnN1IzYkjxdMAzEp3fbnVgcmveOEG5GtaKYvdivlv2yHOUjPMm127gbYgZenfCH36oLyiivvlIMbYOy4R+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsiIS5E+7WsEvir8Vqr5V8zZ2qv59nnMARz+0TWdhP0=;
 b=KY+Fmt6tGZ+86YjPI9IEZ+DMg0Hb1e9QVGRIc9Nu7L7MnLhsJnkTnlIHim0MaGh4FTHe/4E2XoLY0HYh3ZZuCBycV7YM05hbjmknKnCoRLs4X5ZWOifdbcY231z/kUFoduRjqWwIt5UohFrlNuox7jHIODY3gwqpqZFGaEhmOrM=
Received: from SJ0PR05CA0035.namprd05.prod.outlook.com (2603:10b6:a03:33f::10)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 06:08:15 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::e0) by SJ0PR05CA0035.outlook.office365.com
 (2603:10b6:a03:33f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Thu, 6
 Nov 2025 06:08:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 06:08:15 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 22:08:13 -0800
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V7 06/18] amdkfd: process svm ioctl only on the primary kfd
 process
Date: Thu, 6 Nov 2025 14:07:27 +0800
Message-ID: <20251106060739.2281-7-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c31ecd-f407-44c3-6e06-08de1cfadfb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EiA32pUQGvrTLIXWzrBDNDrwnhruaM05+Bg1Wo8UHgDG5Sr85XJ4V6D8lWv2?=
 =?us-ascii?Q?CjIvxweLrZ/uqeVfYePw8g6iTIij4pOSFSNZBtAm1Y7FwRSXtJAksM7LZdql?=
 =?us-ascii?Q?TrKcZq2RSbPArmKFOggUewunZ6mOFK1YDhng0SRbEg0wExHvi6Uu6xzN+aOD?=
 =?us-ascii?Q?Hl/6U9GRMltYn+KIE3BoqLaioBXeckJo/33x2tUw8SSdPQHIDWPCLc+rOs/L?=
 =?us-ascii?Q?uDmlXMGPkFTxKKuXt3vGPKlXlAp7i+fxNG64XsSt1kHGBRA1VMt8VL5cX+4E?=
 =?us-ascii?Q?XU8RFEOm24Gx0ebbg+Mit4YmkUOkRGfY54drB9Yiyj21DGSI0UZVEkMRdFq5?=
 =?us-ascii?Q?wIhGzwTcY1UHKP/TrlfaY+mJT9+XjYnwBH9UL4DZ9PGtkvB1CYDj/JOy4h9q?=
 =?us-ascii?Q?/Dz8IStvKzpD9QuYvFy1TOap3Botl3tmUtQphsjd5RG81/hcZ9PVvvELKcbf?=
 =?us-ascii?Q?+X8EVIN+D70dKkA5CN3vHPghFWxBjLHwNvtLkCud0I0b/FSsyGPd1WGPFY92?=
 =?us-ascii?Q?/yO0XZQMs+YGrZDqMdtM/piItHSYa362ZCe8LjB0hkorWUlD32U6cEPIkS27?=
 =?us-ascii?Q?UVByc6Et9CAoPq/Dk3kd4w2Zl3okydO9jqHTdGa0S/60akGq7Tl+eRouQMz/?=
 =?us-ascii?Q?MV3w2Yve4jSOnR6kzoRd+TZmSFELJROXvieK8QP10LRuUq1j5sBU9O3iGzTu?=
 =?us-ascii?Q?+Y6mLy3f2QbsoZzEaT6e83EaaFXvSUpPvc2WOjXCP3fEyXwLhLnCMMWrF+8a?=
 =?us-ascii?Q?s8cxv7FJqbiGMEsd9W5t3Ir+ZxAy22l1NntTaxD5gBfMuz3WVpH1qBdDtf4I?=
 =?us-ascii?Q?tRO17pusCpMJ0jX8T5ojvKbdO8vP8hNsdKEm4lX0jdgd3lLpNEQx6OS7I8/b?=
 =?us-ascii?Q?6ByRPho9nYQ5VmG/bytNl0mpiQNg2OQWmcIepSmpord56ZryvxCqThH/mi2s?=
 =?us-ascii?Q?eCF51TpSQCwQEM0zwjCllU930MRahwFG2lGQJPrCQ26K8cK6B6N8UukDv11j?=
 =?us-ascii?Q?IL8ReLrgDNavpTcgUgOO4af6uASRmSiqkE95Q7KoQVbo7Aj73tTOiTWDrc40?=
 =?us-ascii?Q?5NHI67zYqW4yB7j7U9UZSLOy4adspprdUL4ELGqyjBm2HDyBPUI7CFAT5pSj?=
 =?us-ascii?Q?Sd0yEftQBrnx+5awrnuX4nbiPm8bWZp2rzdoCJaUsR7knWCbdj0XQqshd+dp?=
 =?us-ascii?Q?x0QpLIkvUKPG5ktg7oJWKbZHzhbcAXanyzjnQUpVXRidRxao2ppn5iKcdjDd?=
 =?us-ascii?Q?uGH1LQSYsu964BtA8CXnaZDkRV2KwGmF01T8uPCo0gXzqfVOYJbn+E6eFZ0V?=
 =?us-ascii?Q?pTRiu31JAl+zDQDGDNL4tBjY9phoMX7/4iYBXcUUw89Hh3fY3MA9rb2sJwBq?=
 =?us-ascii?Q?IDv7RrBW0mXKcWx4JQm9Am/WJw2PxQ0DAtxtQCKuRaUmGhHO0XfytAANTEqP?=
 =?us-ascii?Q?xw0orzg85A4IqGcpi5BLfrnnjOSgD7akCxydZUGofzXQDnqpPrgmh8G+RZ63?=
 =?us-ascii?Q?1dIBn6uE4zkTDKNWtGEVg7BdYC/PvAeNdm/VCkQ8dE2kIKhZN2bXUAsYb3Mr?=
 =?us-ascii?Q?mEDbk7cGpJeD8mLd42o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:08:15.2594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c31ecd-f407-44c3-6e06-08de1cfadfb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
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

svm ioctl should only be processed on the primary
kfd process because only the lifecycle of the
primary kfd process is tied to the  user space
applicaiton.

Another reason is in virtualization the hypervisor owns
the primary kfd process as a privileged one.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 158e75975557..58d90bebdff7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1718,6 +1718,12 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 	struct kfd_ioctl_svm_args *args = data;
 	int r = 0;
 
+	if (p->context_id != KFD_CONTEXT_ID_PRIMARY) {
+		pr_debug("SVM ioctl not supported on non-primary kfd process\n");
+
+		return -EOPNOTSUPP;
+	}
+
 	pr_debug("start 0x%llx size 0x%llx op 0x%x nattr 0x%x\n",
 		 args->start_addr, args->size, args->op, args->nattr);
 
-- 
2.51.0

