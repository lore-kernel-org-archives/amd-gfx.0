Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248DDCCD1A2
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 08:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AEF110EB65;
	Fri, 17 Oct 2025 08:43:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="25bYH8tL";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBBD310EB64
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 08:43:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrkueGhCaWV8p2+NVdNy5Ues+9b1mfJx04atXyGQ0oMwWpj+iQ5+vmkSCmJZ8+V86gd6Y+HqvAJmGBSvFJYoqpLwo2adjN/FKoj3FZbTgxb809pO4++myf+olAx8QGrIAL8dLqSaP7baY2otfBdM9QnliBpBBiAt4swJSgcGCRNkXe9ttKhdCnjiHp4nR1VkAf29XbkgphTtNtv64/Rc+dlGFnwpFSJe7IY6Vci5GixrOm/X593ULQKhdPE+MqhO1XVex3X/fsA6+slhv2dr9MmeVOiUj+MLx4YJIm+LKCB+OV/zCsQijCJ1WFO6tHDK1ki7qmB2J5gphMaO5Jp5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLlxDOzW0n2ILlEfk0OnJ/IyWcl4iqMUYM97Mm97xfQ=;
 b=zMWrbbH1WqzW2F2k2qwc9I1t5yMqjAJmp70ubuaAz1VF6BKoQ3BbnMEqUh7MI67rWI2/EjhXix1BcyDaw4qZMWDoXXr0Pau+8JjAS3WPxSJgrhf2uedW/7OR8bn+Ip190PWLML2i83RqhvVDF/WCEIB6XDT/LU2OsYWMaETvgCtMwKuGf74XZU0iz8GvoU2MDhIZPb5TsHQSjgd5Iu5tN4EjsNEPiV4xxoN0G3kJNrcVTrFkYCRZV0gY+eszSgkn/iZWvDv0OHuvsu8ZvfGlQdBKm8dprmID29cj8mvPkJfTIjDnaomzuoIfdtwWACBemOYZp/roHp8n8PJBMxfFXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLlxDOzW0n2ILlEfk0OnJ/IyWcl4iqMUYM97Mm97xfQ=;
 b=25bYH8tLdxl8ymNbuyhbAMDHXvDsQPdGKe7fvUtz5/pq2Ncj3zh9Zbmdr4u75A0pFlVZhxYbZ28n4M6IfTS3O1N8RPtfEoOMSzE6TLZsRftwGO2iCrVfW4NyO/UoWO1PhQhpodJ2tddwdqv0Ikdn9NSL40pdpWaplXh4F+x8EhM=
Received: from DM6PR01CA0020.prod.exchangelabs.com (2603:10b6:5:296::25) by
 IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 08:43:22 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::85) by DM6PR01CA0020.outlook.office365.com
 (2603:10b6:5:296::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 08:43:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 08:43:21 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 01:43:16 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V5 06/18] amdkfd: process svm ioctl only on the primary kfd
 process
Date: Fri, 17 Oct 2025 16:42:10 +0800
Message-ID: <20251017084222.54721-7-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|IA0PR12MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: 652ecd1e-88b6-4e80-c2d4-08de0d593a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EXoDIqslBrpFFYGfJ40Qv5C1jidn12AsSFPxG+p8aWRjmJem55FQT+rKzy5C?=
 =?us-ascii?Q?fz2IUaCztCzzYKeEMjTBInQocfkcXyS3JQb0c6Q6MtYU1EeD3HvPo6274yk9?=
 =?us-ascii?Q?PxwqhZP7XCZu+z1UpRkcYuqjWNSHhESyzNOluLvP1S4hA7tZT7gnDB/q66Vq?=
 =?us-ascii?Q?kIhawqwNid2nZI75lT/+G/pwzDaA+HH1VjXhcf+qD0XXfPqBpc3aiSSaNN+M?=
 =?us-ascii?Q?W1ZW/rZuJuvj+YmkCjWJAku2pXUWkrg+Pi/mpJoQfMEHCKmDTuRehMEH9b2U?=
 =?us-ascii?Q?UzkdAUtIgsj4GGL4IxRIqqtrfRkZ8XdS1/shQ2GWTGSkHB8rNZPmtSGfsw4i?=
 =?us-ascii?Q?B8MYoUmwiMf/6LKeErUemVumYj/Rj39MhK5bXscs7yNgeMK6KFfeVqlF5wZF?=
 =?us-ascii?Q?tRAViaULaw049ssPMvprzjXBLy42Ftr35nNXs8FuoDjktTlgyTDMETFB25EW?=
 =?us-ascii?Q?l2PcZT+mgaAIYbeZ9PxX6McZcjtB311OhPFsBSFRWVm1UrdUyEYx5cyxEi2q?=
 =?us-ascii?Q?klheoA6spEFfpRqkd/iFzbxHU786i7vcDNG2eTBqGq69+u3ecuGVZnRaCjdA?=
 =?us-ascii?Q?NXjT6Q7O39xeTX75Z6bwSNvuvF6JVjc70akdR5yVrdOIxS7BoAcQX7u0x4dj?=
 =?us-ascii?Q?V4GtaYGPx6GwwmvcICwtVyU9T9wc6FhgXbJZ+GbJ8oJK4bUhlqv6uUjAelGS?=
 =?us-ascii?Q?NTjdeMvZmLwaaOkuIwSjaDOXi8iCNYETIkPkEpXEAsCAAd9nqHZABFe8IO3E?=
 =?us-ascii?Q?k3tX7oWRLW30+kTQLQGttWSBsDtjO9NZDr0izYmKGLzfGC18Lt7V19wc6a6o?=
 =?us-ascii?Q?Q0AiNx2FQrjcdHPC6adQ+u441PKyB9kP7xJnwaFxo0oS+y9O9o8YTZuYMrwt?=
 =?us-ascii?Q?k4KK0ByjHQQRLMbvzV8Zqi3HzkSHpoqB0JoIc16T2t/g4G7SKwubGJCIAHNj?=
 =?us-ascii?Q?6NbZqRQM4lY6tkUP2lxpRbXsxRhMFWX+eADWDvR2nexZVyAf/RHQHS9GLHG4?=
 =?us-ascii?Q?1ROgPMMk9D+7I2nebJ3dsiTuXvaEQHSHKbW0bTi7qpE0aG6vLavYefyngZEU?=
 =?us-ascii?Q?bSO9R0UvHUr9phyC32W6HKTFUU971ZCiWrruVVJ98WZGZycFHu3Nhl9hctjE?=
 =?us-ascii?Q?4iJ5JuskrnwwaoZnHxktnijjL8VzWNy3ijyWCO5As+eK7tEs2dNkSj6Hb0eU?=
 =?us-ascii?Q?P+7JjEoBrBzErA7RY7EFyoQN94wNccCoExfALltDML5kgoWFG7rGC1gGRD2L?=
 =?us-ascii?Q?wHuTYyhk5bI5bKRjXaigAbPDPS1qBsW1QRnTkbDwN9M7Bt6EZnR9OFVwTUkB?=
 =?us-ascii?Q?ev9F8JSwO2N5mqeaApsFaRyDMMKka7oOZmIDpdwagin/c+5Xboj+iPUioMuA?=
 =?us-ascii?Q?crtMep5ly6VCn/+6eJ/Ncaj6q/kVzSnl9NAEx/tD57n+kDcY2uAB5hQIfdPI?=
 =?us-ascii?Q?SyrEGgXWz4gcaRLe8QVUGMDPFklhyIugsC2FJj2gTrfwTu1R0vv6P5oH9OD5?=
 =?us-ascii?Q?ETWWpdRDMk7p9VEzzAmiS0xcl2zopTmLnTAE+aClQnmc/K0yRqA/YoLuVsz2?=
 =?us-ascii?Q?qUKl/hzgQ+VsUxDhYyY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:43:21.8915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 652ecd1e-88b6-4e80-c2d4-08de0d593a99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973
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

