Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7323AC43381
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2EA64E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2EA64E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D416EB3D;
	Wed, 24 Feb 2021 22:20:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A7FB6EB36
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5yM/QuP/2Y9Vh+E5N82prDs6x8M9RC6DEneCSqkiFyf9WCr6hl0Z3QWIrwO9Y63/TYgEjdBQAm/bqG6fpwdZ7Cu7rfTpQ73w6MLwDfXLGfOOIkyMVyyhX2mMbhDJkkWzWq4os+UJxrYc2ypPLfTWPyUqEu12/yZ4n16rIQW61kmsliJo/AK5pujRai+TdfMVU17DEVFQXF2xY1Rm81kWrl139MI73nh4JlzZfbn8mVwRLMgKXVquZdmPOmHtFe4rHk7Yo1NwYBZrOzr4iwdjrRaw8fX5BzIvhLSldiGhkDlWjPFhsWVVtYANyDZ6rP4r7iP9BaQ6f2G1NBSoPN4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byOcrMK92LEzBSVXZmST4gOCd1xf1qQx9e3SpZXX22U=;
 b=Wqg9U4oh+Dxz3KKUaxfoerKmxb1DbmkmG9QHLE1yo4vJA2EP1C1j0zEJngBArTkde9/SI9RsC1QWdPv3LnKlOxay+dNXR8ZC2FmZ4HCVUHOzPaqJ32gs+8iCJwjeRRBRJRBse7W/ShMsi7ugpGIKmAlXET5V9bwoZEupbX2St/aieZXHl2v8mbwfoX0Q79pgY6s7zZGLHb6G7IM0BTTFYcNZAlRUubWxqm9C2mF9xMOmkkGMOLF33kRl45DPZ+Ws0aKb4fWzqo/eqyuFIM+eni4tjQKAoBBya5zRdO21qpuhiCQweh0pkfuxbTyUCmiqKmLm+3eIDlbhp63QdoZEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byOcrMK92LEzBSVXZmST4gOCd1xf1qQx9e3SpZXX22U=;
 b=kYxitqeDc5N63+gHhUb4kc0/VEWPx4OlTy+G8OerWc7i/l4uksz6/K4w3Xh2i9WBx6zq5AnYpbESQKRxlso4qPsEKdbiDJgbxMN08BvjqV6z2IZ5roJdFm8xCzdOGEVFt5cX6X3od9BVOhjnWeAoN7s7yw9H6Tg9U5ng8g0ByJQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 22:20:17 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:17 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 042/159] drm/amdkfd: expose host gpu link via sysfs (v2)
Date: Wed, 24 Feb 2021 17:17:02 -0500
Message-Id: <20210224221859.3068810-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f8183cf-ed18-4012-51cb-08d8d9124c89
X-MS-TrafficTypeDiagnostic: BL0PR12MB4865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4865FBD7620CFFFF34586709F79F9@BL0PR12MB4865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2cefnD3Eb0VJbEgwRs2dsSs8Bxn1OuyVqZMIab/yS+97TDqoQSQJNCF+DuKdoItSxY/HabA5ooKiKJDT7CjQzfeyJD11kNQLq4KWLm3EcGVYLRmg5xHUNfe4y3QqGmQ6NwajN6iMhVVGo6qEVkN0f4GGvjqUY49pA7mYjzc8c1GHC+V6bPuJUow+K4jdyE1GNd0Pp/XZBuZaOScq1DPH6Yv+8PWZYddEz+6bTYJ/bfChryenzw9xGQhuZcOck0BWtndDjjveu3fQrthKBAl9XIefE8kNtFrxPuEZzoBwOEJTrE50G21IPVpB4DHjLDqtz0CdwqegWVwFxR26foHRe+NP0he5cwKwnsiPJPzuoMAorv+B7vOii7GKi/lsUXNNYRtsAD/0NjERRK6beQ6PB8z1rCMW7q7Y3w2j1+QVqnGDN2KycR7yDOzvaOHbmSwWDc7kS/33RTFX12zIhFweXHTgDQdoUwegEe+iMQydTnFvMthKp+JrGDoqjL4dt0d0IOMqrd3miWys3eUz7YVSO/JI1210xR2fERLXvtnX9N6c2/oBWSgc5SFNftj25PiurMOYUXTV4jgFB7gGNm7LNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(6506007)(478600001)(316002)(66476007)(66556008)(86362001)(2616005)(5660300002)(6916009)(8676002)(956004)(36756003)(1076003)(2906002)(6486002)(6512007)(26005)(4326008)(52116002)(186003)(66946007)(69590400012)(54906003)(8936002)(16526019)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SRqzbZTOTjvbmwb3lpjJA+QeDpLVhwxEBccPpWIMvvQzDQVmxZecDBd3+6F7?=
 =?us-ascii?Q?ffeglVQN87d4OsyAP62w7ill5/BhvvAiJ7b/3ryghcX1gE4BT+JDrM4MTzU9?=
 =?us-ascii?Q?UPtUnREOyanrdim1UgDvoPKbATu42MvisWMzIB+QRBkApk1d1Ta5UTOibc07?=
 =?us-ascii?Q?V8gstockuv+2petDseQkZf6VBpNgvkXyJsxNP/HsGDpFgifavzPVExqtKhnO?=
 =?us-ascii?Q?KZkV0Sw+5AXAjqG+CMcIOOG5obqtYIFUbMHMGqzCD3R8r74VpeHFGVknfX7B?=
 =?us-ascii?Q?CawYnzYYbQgq5o2SlcH1UUhafKsERQbvVL1eRR18qKDpgDnfixqKCwwTmfqE?=
 =?us-ascii?Q?sHOtsP4XuEypfI1dee5pGP2TG4KI8+ivedqrWtLTgPkS1VXPpVtOBd2evGvI?=
 =?us-ascii?Q?UrTI0/SSYcXXVrWBN3G6F42AlshUstDWPoyA+sJit6Hh5hF9Gjb36zdg3gpr?=
 =?us-ascii?Q?LB7XQHnMbU+w2huJFCWfAjGH5LLqA2hm5rsBrLaL3TQ/rl1epNf/z4YqTDwJ?=
 =?us-ascii?Q?2bNZbVazcJzSGPMxUbsEWOp/GO6iCVskme+Slpi+YQAVpw3BFboshoTV31+G?=
 =?us-ascii?Q?NXF8/iT9lJ4c13hLB9rGfUoARhIwoj1C1ZUpb3ZcoWmU0cqs7PjILCp/q5dK?=
 =?us-ascii?Q?90Ndy+fIAjELjrZg+Kv9Zv/SCPU+NIA/mMCibNdEJaeCXd2ElOs4Ilg12M5/?=
 =?us-ascii?Q?hRnA27He9Sh0d3GsAxUM4dZagjSVrfnh9v3OArVeUhnFo+BwBeTJeSrWeTM0?=
 =?us-ascii?Q?Q1BqXAjAcys7SPmo1Awy5uwnkXUK60b+mLJRGJBKq0hcmfZXTVeHEJn3oiFl?=
 =?us-ascii?Q?LSF+An9NfT5ajYPo+shg6w2QdCYpT6A+UYyUh0Ji/mmhnFyIXKfkUxBzwr36?=
 =?us-ascii?Q?lHd/j9RoeY5kYTyQwCwflbKMDYBr8pxahD4ZcaADes+vB1knrB+xv/DHTnbF?=
 =?us-ascii?Q?LEiZ4bRjTaknLGcrup5HoA1PJSxtemyIuRjy9BvmLqkzhIskpSDnbWh0enC6?=
 =?us-ascii?Q?Ib7Za5i04HaFZwULvNTcfrRTywUVCCnzs6ILnh4MXTzyXjS4JtVLd6Bm9I/7?=
 =?us-ascii?Q?qPLmpDABuivLo1QEZVgRnKVb18NEMqKOhUM2fsCMuaxQOE/hCnkbqbJ4k0B6?=
 =?us-ascii?Q?+fZkGbrp1CNpfbRU2aMrjN+WUlh3xlhC/C6C3ZVRXf+TTGogJDRkEEDt0Fkj?=
 =?us-ascii?Q?i/cJHj7UY60VQcYA1jbHSHreN7KPfnFqCmcs0lA0zg7jbC16xM3mXyuFhnie?=
 =?us-ascii?Q?R67HN61AoU/c8xjpqs0iwAmkD56BMa1jprOL3q8Gs9tW2GztpJdHTMW1fPD+?=
 =?us-ascii?Q?NgKsyisibtxmAyxeXOgwUlSr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8183cf-ed18-4012-51cb-08d8d9124c89
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:49.1652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nm4gJCq2UxPlB2kqYgjeXim/mo4Tk2gwhWEtd2HiJ7W0ETz3wkZaYDB61f7QoYd1KQ0kzaj1hcYds0SyUG0jTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Oak Zeng <oak.zeng@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Currently host-gpu io link is always reported as PCIe however, on some
A+A systems, there could be one xgmi link available. This change exposes
xgmi link via sysfs when it is present.

v2: fix includes (Alex)

Reviewed-by: Oak Zeng <oak.zeng@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 533df07964ec..c60e82697385 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -26,6 +26,7 @@
 #include "kfd_priv.h"
 #include "kfd_topology.h"
 #include "kfd_iommu.h"
+#include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 
 /* GPU Processor ID base for dGPUs for which VCRAT needs to be created.
@@ -1113,6 +1114,8 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 			struct crat_subtype_iolink *sub_type_hdr,
 			uint32_t proximity_domain)
 {
+	struct amdgpu_device *adev = (struct amdgpu_device *)kdev->kgd;
+
 	*avail_size -= sizeof(struct crat_subtype_iolink);
 	if (*avail_size < 0)
 		return -ENOMEM;
@@ -1129,7 +1132,18 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 	/* Fill in IOLINK subtype.
 	 * TODO: Fill-in other fields of iolink subtype
 	 */
-	sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_PCIEXPRESS;
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		/*
+		 * with host gpu xgmi link, host can access gpu memory whether
+		 * or not pcie bar type is large, so always create bidirectional
+		 * io link.
+		 */
+		sub_type_hdr->flags |= CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
+		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
+	} else {
+		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_PCIEXPRESS;
+	}
+
 	sub_type_hdr->proximity_domain_from = proximity_domain;
 #ifdef CONFIG_NUMA
 	if (kdev->pdev->dev.numa_node == NUMA_NO_NODE)
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
