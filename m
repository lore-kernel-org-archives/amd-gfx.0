Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E97C87FCD
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 02:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B63710E40C;
	Fri, 25 Jul 2025 02:43:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rvh6wRsI";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A632E10E40B
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 02:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIQ8sBvX/u5srgIioRatNYBfP7WBujsbnq8QRmA7mOSEcZtxrs++/vbGmhiXDCwul6NFS5HY52Murswd+PrkPmL+v/FS8HJ5rUPrDym3JyfTBXMsaIZ/wrTdJfP0r0pU/M2sg761MxfN3l3v0qc5Y4vgO/94VrnAB51kB+ut5UDFLg5KA3OdXcBYuSU30dWTUAul3lmcon5CXYS+4JP9LfrZmxxBruw9aV7wOPCW8j3jJuQPQ+Pyp5NenTgMH0iuNL7rFYX0UF2VAE4ok13OkOd3wYGkEPMWhGyJeDA8tVjFTQ43VB80Hk/rD2XsCnaS9Cyno9FbjeWs4+bw+Tb0FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHJWzDwdTtCrxwcb3EV4koID6Tw0MSXuh2EHyxyt/Vc=;
 b=NknlQ0Fhisn4IvqJeaD3J/e6UoXTjidgzslxqa6r5iEgNW9z7lcYePdaIgkJE8B1ohkVbggJLgwZtj3/QOqBwe2TdtXYiuvmHmmrZxjLnEmhBr6bYuIuT25gzl24cK2hO/S1Mca69ggrMoxTbUEloStR428yMUXbrCxT+6a9xVF9Sts9Sx/z/qCE3EIJx1IFn5xurkIUbNrOgXpEjojXxcnuGyFZJrh9pRyJl+Y6zUKaaKadutbt1sp85u6y0z2Is0TpO/MV4w4hFnVMcblVfIkLkLqObpEdd3Enq6z9hRTvWVsnZCjlex2V1X7qBt/O+q/B++0QFJVs8rVv23LYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHJWzDwdTtCrxwcb3EV4koID6Tw0MSXuh2EHyxyt/Vc=;
 b=rvh6wRsILQEd8AEB6y8vMpGWregOH2hd7sxu4yhu1eFqPnpU8SiROj96gBcbCYAJvRuN/pbYDIgEDPBCIrj14ZTLO1SAV3IGWuqPaypXY65gF4AIBxglXkmk+TFWkzdfVLzR5QABF2kh6RnXk8Wio67h2UaPxXddevpKOSeBQPo=
Received: from CH0PR03CA0097.namprd03.prod.outlook.com (2603:10b6:610:cd::12)
 by PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Fri, 25 Jul
 2025 02:43:42 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::1c) by CH0PR03CA0097.outlook.office365.com
 (2603:10b6:610:cd::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Fri,
 25 Jul 2025 02:43:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 02:43:41 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Jul 2025 21:43:39 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 6/9] amdkfd: process svm ioctl only on the primary kfd process
Date: Fri, 25 Jul 2025 10:43:13 +0800
Message-ID: <20250725024316.9273-7-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250725024316.9273-1-lingshan.zhu@amd.com>
References: <20250725024316.9273-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd8ca9d-241e-46eb-07ff-08ddcb25111b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zr2PwunY/xZlLL+ldeY2Lkbe1qhojXxL2QDoNbuTgqGQhWDls2KJPrvCQU0C?=
 =?us-ascii?Q?wyj0Qdu4WgzolX6ZEKqAsFuNukYR0cgPARnTHxO4zPm2tSXwWn8gVmBIGt3c?=
 =?us-ascii?Q?Hdy4KDCmm7MLmXmHQODSnmml+IzrxpR7O2VwlfHG3yfH60VNOPXBB0lLof6X?=
 =?us-ascii?Q?pQvf21UVZzXOYLPGgW+6Uwdtlzs7IPmqzy0/6y/m4NKf/n//npHgwA8/Ef3b?=
 =?us-ascii?Q?CBKTLGzSev96Fg7dxkxqfmSKPu19gsw2zVMxkc5hJ6vhVZ7qsGkHvutuD3jb?=
 =?us-ascii?Q?3uv1f0/3QVqPs0cUME3bOnXIssuTcqdqP9SZFEa+Gxgq8YB6j8ryCuQ1OmYZ?=
 =?us-ascii?Q?rEzO6WhVFxWgtDBc8czK47xCw4DxLcCpJohOdK++9y2Zj77/f1NsfHuLrEmC?=
 =?us-ascii?Q?7YPNKGq4w6pFP3gkB5AzSxhfk7Hhg2XZrEU40KMIFlcbZUmp5DpsJsFxHi9G?=
 =?us-ascii?Q?zeFkKZRzXo3LZUC6ev5Pogh/hgKQDwGLYeudfn0SGOwOHDSrNCzo01fjKqCI?=
 =?us-ascii?Q?SVlsB863NUURYYAWwr5ElTdJCavjLpUqRCOxzcSZNaHacGLXI8t/2JuogsuB?=
 =?us-ascii?Q?ISc7BXE5E0IIounjrTvWsmE0JLZwX4sxsfLoWCP9Ppq6B7XLK2T7/znuTMSB?=
 =?us-ascii?Q?JO2e5Io9+wR8WaggLb3L5QUKo4paY0ouvBS2r1ltcd+E+qhWZcrYlXgcDDoY?=
 =?us-ascii?Q?ys9IN3rf7qy436VpOlsII2upqyMGjzEsKyMdTFJMzO1nsFIem8LFhHavGfvf?=
 =?us-ascii?Q?zTAUXUWjfIWbThEPkspXDWYDLyDv+schNhWPtbk32onLSOaVg/kk55sPLrf8?=
 =?us-ascii?Q?0MvpFV3HSVa2psr46y+t766JeQky+shNv2CeqGf5m3AWFembSW09GfjAFaGA?=
 =?us-ascii?Q?7rxtFHV1g00mxX1Gc21t6+44bQkUorusD42Hwb42jOiNEmYRMxflCaq+IB0Q?=
 =?us-ascii?Q?+NfrN18Pe9pjMKqkRkZ8waBaQJEGxsrf48WGjikpCVPNAgSkXkl0wXNxQFFV?=
 =?us-ascii?Q?jmmh4qVB97WWi8G0Hcr22WZJ006PYGGVjLxtyQLLmWi4yTwt5TFjUg6F+baS?=
 =?us-ascii?Q?b8v/OmHsW11Jz21LhGuGbFkh0YEcwea48GpH+ujfu3VRcPuB4oHFy6t6SmfA?=
 =?us-ascii?Q?6qcuTp2KlLXS1XFNHX6ZsoNa/QtrBHsz6G3BVdA3MfE6UFFf2RMIki3CdLKA?=
 =?us-ascii?Q?VSoXWJ8njH+cASfABOG83o1p75+T3c5RpOE+VjfRu3ULFi2/QEzFGjb0IgMJ?=
 =?us-ascii?Q?ciu7K1vbRx4XqxKVfi45y1guy9ipOoto4QnUM1Oq/7TaoavkV1rJiwO9IpBG?=
 =?us-ascii?Q?7VBiecJJiTEJgsflz7PAatZSw8TFZVsMGYjeBiPq/OeUins171qBqeqnpIE7?=
 =?us-ascii?Q?XpnIjfi7fbhfItNUcy8W0XgDjjxGORutYvww+RbR06KiK+n4OBgDpJS1OMen?=
 =?us-ascii?Q?9SHZGlx24J/Uk8FXi2AnHTNAn4AT8lowSoJQhPe9D2/4SVdfid7BJx/+QYvA?=
 =?us-ascii?Q?jmaaQCLYgQlmoEUocIoevds8FwRmHo7vkpnc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 02:43:41.7128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd8ca9d-241e-46eb-07ff-08ddcb25111b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814
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
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index ec9bc359d5be..b1ab1565a4cd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1720,6 +1720,12 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 	struct kfd_ioctl_svm_args *args = data;
 	int r = 0;
 
+	if (!p->primary) {
+		pr_debug("SVM ioctl not supported on non-primary kfd process\n");
+
+		return -EOPNOTSUPP;
+	}
+
 	pr_debug("start 0x%llx size 0x%llx op 0x%x nattr 0x%x\n",
 		 args->start_addr, args->size, args->op, args->nattr);
 
-- 
2.47.1

