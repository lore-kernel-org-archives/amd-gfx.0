Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A3BC352BE
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 19:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDFC218AC
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 19:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v42Mv4el"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDFC218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B02CD6EB52;
	Thu, 16 Apr 2020 19:33:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDB46EB52
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 19:33:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNBnWMvBXMufLzUe+tuPatVLQnLRimwqCGbPeSi90sO13EYrGdzqOYArnFutzitax4+qDPn99FtlneyVlZRHF4ZMpQUVCs89EUHnLjUfSPpsQbCzW+hv0esI1BLdzAyYvMvCjyT2YiH6M2K3TyiUbHAmrFd/aXebj7p5NorGlW2cfS3tRlbDJzGW9XajigcP6vnRkU13TmvJGCqMGVOMjWrju55UvEdvfAe0BK0SOv7MiR1b8+glZ9Jyi9vPLBcCaX06DGQZISQNeTkH8bJHE3Rg/HVBkA/06i2TFJt84LE1ZCLpwjEEQQD4efZm/v1gBj6/2guC086d68qb/gAE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yn/nZBDtD4S5qQ98dkH597+VPcPeOhuqkObhaV6Vrw=;
 b=TvacXVDVSe0CkkQHPHNTrBXHk21Xl4WD9uuTd1iBn9yof8OuWZjqgdn6ByC9zxfyDpKQnBU9x3Vj+fnddBKyExr8dsG9QhwFreJoC2VdviyTmj4ZhM1XYbEtFHMDVRHKM/raeKALmwpg4M5KL2RbxSUfpKqhA/rXPtxHJLOB/Zm0oiKTw5y+XoBVDdta5371sZba7xWuurekW5TYY9LTMD1jAWrKyodC6rrBBX9NgiI/05OfCCmoGWcGbtaW5xqfk6L7OdvnpaG1LiJt7ZGxEZizkEkeu8xtN5n1W9y//xFFHaubENEt1wbVgiJEViPSpvtevu71o+AgAlhHv626cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yn/nZBDtD4S5qQ98dkH597+VPcPeOhuqkObhaV6Vrw=;
 b=v42Mv4el2ZQ10YtHdeCrVfrXVAC7cByXEwsOO1QofbE64nQpIus2Rh+AKpficbh8ehSZ3tRpEk4ZyRr2Q3ETh1cNwTnJsLudCL1w+c9Z3tdhWAUtI/1VKiYEBqfKhC0nLI1l1vrlZ7EEt+9Fgvp3piYNf146cggVBubPx6HizQs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Joseph.Greathouse@amd.com; 
Received: from DM6PR12MB4561.namprd12.prod.outlook.com (2603:10b6:5:2ac::8) by
 DM6PR12MB4011.namprd12.prod.outlook.com (2603:10b6:5:1c5::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.17; Thu, 16 Apr 2020 19:33:45 +0000
Received: from DM6PR12MB4561.namprd12.prod.outlook.com
 ([fe80::357d:e89a:42f1:f492]) by DM6PR12MB4561.namprd12.prod.outlook.com
 ([fe80::357d:e89a:42f1:f492%7]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 19:33:44 +0000
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdkfd: Put ASIC revision into HSA capability
Date: Thu, 16 Apr 2020 14:33:30 -0500
Message-Id: <20200416193330.417754-2-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200416193330.417754-1-Joseph.Greathouse@amd.com>
References: <20200416193330.417754-1-Joseph.Greathouse@amd.com>
X-ClientProxiedBy: DM5PR19CA0028.namprd19.prod.outlook.com
 (2603:10b6:3:9a::14) To DM6PR12MB4561.namprd12.prod.outlook.com
 (2603:10b6:5:2ac::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rocm-perf01.amd.com (165.204.78.2) by
 DM5PR19CA0028.namprd19.prod.outlook.com (2603:10b6:3:9a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27 via Frontend Transport; Thu, 16 Apr 2020 19:33:44 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a7606979-b958-43b4-5660-08d7e23d13a4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4011:|DM6PR12MB4011:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4011F12AE6C40208DFE85C15F9D80@DM6PR12MB4011.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4561.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(5660300002)(4326008)(66946007)(81156014)(316002)(66556008)(8676002)(26005)(86362001)(66476007)(6486002)(8936002)(16526019)(36756003)(186003)(2906002)(1076003)(6666004)(956004)(2616005)(7696005)(52116002)(6916009)(478600001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/vAkweqK7ojJC1xCRzaZFsdVso7lNBH2360GNEiM/nuj4X162Wby0uXJNnF7QiHYjKJIZbpLIWq5z29QckIOflmECN/jbN7gCuJQWlJBY1hSMJQWrIedKCSzMMwt87ANg8fkJyCgmQ2sgtBzrQo/vMGEAV5H7jTEl2tldME+3qpt4FiA46SAqtXgSkCMlTnSnKSemWt9y8aj/oCekxQvzSowa/2n+WGlnlA2f3NYw540bfiUMR3oXQOHtDbzwwKcfd1UBigja3Y4aVXWZs46cETIrPJAUHA/1z0XOq+J83t74RCQeUixa0UTnW0HLUV+rCeEJMe8/jsOomDB3HJUCNtQ0Xboqqd9HFj6EEz25EfgvgWHzl2MD54XqcPpUtTmqi+Tl15Oho1YNFKafDE7GwC8DYlH61w9W71d1CRxH/IDq0kx86ffnTrOswXy4tl
X-MS-Exchange-AntiSpam-MessageData: 65XFGd6cRDgapV1YAS+ZSiGe5Zd2iw8lHg/QC/CIFJ5V1+BWPa6DMua8Z0IAsfbpMrFZw8CDdCWAAEvbb80JuQh5vDzo5inMpro4/GJbqS1WU9A12drRSOD5T0WbA/gl525zAoY9jbvwNX1NwUFCyw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7606979-b958-43b4-5660-08d7e23d13a4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 19:33:44.8376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPlUixhPbbCzk/h4zWvb9rsm6ovD0tNeAd0d7L61C46ON56RtYhPsGzC3uY6bsVZbm+BG5Eha/0c09UQyJAo9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4011
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
Cc: Joseph Greathouse <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In order to surface the ASIC revision to user level, we want
to put it into the HSA topology. This can be because different
ASIC revisions may require user-level software to do different
things (e.g. patch code for things that are changed in later
hardware revisions).

The ASIC revision from the hardware is maximum of 4 bits at this
time, so put it into 4 of the open bits in the HSA capability.
Then user-level software can use this capability information to
know -- for each ASIC -- what revision-based things must be done.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
Change-Id: If46b3a1864d0a7a67b95fddfc1dcd93932ca81d6
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 5db42814dd51..6e52c95ce8b0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1303,6 +1303,10 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 
 	dev->node_props.vendor_id = gpu->pdev->vendor;
 	dev->node_props.device_id = gpu->pdev->device;
+	dev->node_props.capability |=
+		((amdgpu_amdkfd_get_asic_rev_id(dev->gpu->kgd) <<
+			HSA_CAP_ASIC_REVISION_SHIFT) &
+			HSA_CAP_ASIC_REVISION_MASK);
 	dev->node_props.location_id = pci_dev_id(gpu->pdev);
 	dev->node_props.max_engine_clk_fcompute =
 		amdgpu_amdkfd_get_max_engine_clock_in_mhz(dev->gpu->kgd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 46eeecaf1b68..0c51bd3dcd59 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -41,7 +41,6 @@
 #define HSA_CAP_WATCH_POINTS_TOTALBITS_SHIFT	8
 #define HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK	0x00003000
 #define HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT	12
-#define HSA_CAP_RESERVED			0xffffc000
 
 #define HSA_CAP_DOORBELL_TYPE_PRE_1_0		0x0
 #define HSA_CAP_DOORBELL_TYPE_1_0		0x1
@@ -51,6 +50,10 @@
 #define HSA_CAP_SRAM_EDCSUPPORTED		0x00080000
 #define HSA_CAP_MEM_EDCSUPPORTED		0x00100000
 #define HSA_CAP_RASEVENTNOTIFY			0x00200000
+#define HSA_CAP_ASIC_REVISION_MASK		0x03c00000
+#define HSA_CAP_ASIC_REVISION_SHIFT		22
+
+#define HSA_CAP_RESERVED			0xfc078000
 
 struct kfd_node_properties {
 	uint64_t hive_id;
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
