Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984DFCF8875
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 15:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A9D710E074;
	Thu, 20 Nov 2025 15:49:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g7plPxuH";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C62310E074
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 15:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PK95Vm4X9tyRkcNA1WOpSFckU5jGV9YznHkOLwrasK4GU5nnhQ/jm7h/0xJ2JKLLDxAXPnO2gJtZT8Kju0putLdLR8VUpKHqLlB3tICNJmCYkME5z0eb85qwV48iUSCPbWJtDqoSm9AaIp/ezF9difnUKsQofPn6sZoeU+++0UTdukfL0XTa7/3jOZWT8gRPM96WMCEjDWCDQIv9PITzejU61UuSu2q6pqFZTH1QFamagqHCeyVBrMm8pO+ZXLJTXeX7GG9YSWNBgxaScfE+waBRmPjwXMory9Ve0Y6TxFkcOm9CyQ8wUhtJf2sLbzr9Ak6sz2dUH5+w2AvBCd0WWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjGMxRDDWcrTkVfWICBacJfn3T/g/QCQSBkYJUy44v0=;
 b=XuqQVLeCCpYAKonaukNkizJ4wDcOph2j4w60OywQfJ8tXAwksTVKe3+degxfCHApKqBSc3RERk8R9zlxktvf6vGpwxn9kCZrRCaQ+uOLoRqQNOo401W3bFbnVw7HKg4Ux2z8nz0UmBXpvALqGgajzqSBCRlHbJjqGPUtTzl0tUIJrQbmZwdFu+9t7v4EhC3/EErEQG8KP4Aewtzkt6y7+iAVo+9C8er2kZn6cUlqF44/prNCVuRvzP+WXz8k03dx7rpMMJpqHVvbpodCyCq8BRTO3K+8XOZiEWbPF1Att85kk9Ay72gmTPXOwmWkV3Gffupx2b0OoKUKLPNBj41oqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjGMxRDDWcrTkVfWICBacJfn3T/g/QCQSBkYJUy44v0=;
 b=g7plPxuHbn4nCfmbf9dd+a9mseI+6OX+jebu2OuEZ4AOdamVDTXurBcT98aM/hAN6W5IVGzaOX73eulpIezonIPV91LMdEDYGhTwtuy/3SLF9hZ5w0BoUf4TFuHH0ua/c88w2RCN/yD1NpiRdBYexeWctJ+0ZiTlBmLCgO48lmk=
Received: from BL1PR13CA0323.namprd13.prod.outlook.com (2603:10b6:208:2c1::28)
 by SJ5PPF0AEDE5C3D.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::989) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 15:49:18 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::60) by BL1PR13CA0323.outlook.office365.com
 (2603:10b6:208:2c1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 15:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 15:49:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 07:49:16 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 07:49:16 -0800
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 20 Nov 2025 07:49:16 -0800
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v4] drm/amdkfd: Use huge page size to check split svm range
 alignment
Date: Thu, 20 Nov 2025 09:50:43 -0600
Message-ID: <20251120155043.2770609-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|SJ5PPF0AEDE5C3D:EE_
X-MS-Office365-Filtering-Correlation-Id: f44d6bed-91d1-465b-b48a-08de284c5cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c38PVZP0bZwB/keGaMtMkvsOn1ZMlgSnZyR/M+XDiBNoULt04A2zfp9IqxZD?=
 =?us-ascii?Q?aPZi0T4NVkrWeZkb5gx5MWYT/8UdZnorNI9jpiNIh7UvLIQtjefVhfZptK5d?=
 =?us-ascii?Q?/FhhnvnI96LXGVrTSpZMfYbsiFcGpbv+x5a4wgCy2AKjM//SQ+5+edCYmYz0?=
 =?us-ascii?Q?bAzSpzgJdpifhnGkJWquz/tbJcMYLuK4CTD+BDNbMbx/HZPpf1TS9LtvME/c?=
 =?us-ascii?Q?RuEuTlMmmruU/mWZNs5G/U88Ev6iulwErek4sZdRV70eT2PeUClqo3TbMC/h?=
 =?us-ascii?Q?o63rcQlD9KvXPNeHYXFqSbkeG5wE8yyDo6IPRItiLeVC1dzKP7sQtsKMEAke?=
 =?us-ascii?Q?CmfJ3opFT0S5o8CjztZTDuI5F4p0EJuwItxSUj0K10i7C+Wh6OPhs5ilzDfy?=
 =?us-ascii?Q?mglh/UhCq/1OwF4uAlNel90xf9AIUpMVfWrVP8YOcRRX+tWWRjzq3DPWIqOf?=
 =?us-ascii?Q?jnWfmA4DUpoXmACD2mbQ+RmKjYsjM7Fbc7fFj1j+ew5dn20Q/o5ZqLvs6np0?=
 =?us-ascii?Q?nsFG3enIwro4abuAjKqpT2gH/igWd0oUIYUUXG12iVlEWWu5dcwigYc9qKmn?=
 =?us-ascii?Q?GegT1POsW8LA3crWGG1zbVHLlIRI7Q/jJGPYh3RlzjxCTVM1j6/dbV351qQc?=
 =?us-ascii?Q?iNWD6145CnbOmX3BP9m67PH5nEv9JcF2zRLUc/WWbEd7KTxZXXo1dKiXCHA6?=
 =?us-ascii?Q?4RRgydnOtWWoG8Pn0tynDIPoyGvRw9owbX9jRG+jH+fB93bXyI75+Zlg3+E4?=
 =?us-ascii?Q?5ReEIW8Ub8D1wqOUmgoGnwZwblqZqsl7D7xVDfcQwg+Qp+uNqLXrh2szp0a4?=
 =?us-ascii?Q?/zMyBYHdsNHmybW1ZyDKhPfd/2bqVxsgHfaVlnIvufXteoRgh9AmrKMyw43H?=
 =?us-ascii?Q?aVWW1CvrLo+qgNFqLmHuMkm8mP1RPg3QYYv9i81wtOZlEAE9IpuTP5euloid?=
 =?us-ascii?Q?jT5jeomxYOYXu1JLhB/JolzOjLQVok0JTRat0E3RMC21/xui0Lmd1C6Wa2o2?=
 =?us-ascii?Q?RGjuRTPGKlcroEOV1yqX4H4I8nh+/SL+C5CK6LlbDfmUDFoBJlVqKQiC2pZ+?=
 =?us-ascii?Q?m9if2LcvChzfCrNqoz59yzs/sE66ffY1AtcT4DPO1dWlw0jfSYj+rywtnlhp?=
 =?us-ascii?Q?ddBXapVXw4Q+5XM3oz9IINgGYKZzN9M9lME8EpcBbQFcvsvoRMSpLwawoRXm?=
 =?us-ascii?Q?t1Miupobe8217uE2Y2EieJoUE0HYeYV+EEaHehQQiAOqNAxjwKMB7KB3vILg?=
 =?us-ascii?Q?oG0ixbDE2s68K8+1jGykG0A+TlmboC2R6eiRNEoigXagiLfjNA0EMAHfjMvE?=
 =?us-ascii?Q?q/51kBjRKWxthve8RlNHRoJpOL3HfuJMernt49MNw3ollw2xUZCWrSIHhACw?=
 =?us-ascii?Q?id7LEuvKqZWQfij4a9OLlNoP4z+kavbbN43w58qvZdE9K0e5LP4yM7KFIVK8?=
 =?us-ascii?Q?xSTHFwVvdEgxKDU22M48IXABEfHxaQxJbsmc0NVHW9mGz7pzepbwmmciocnn?=
 =?us-ascii?Q?+YSUzcOplVMrirFEkJYIwhieDGthmB7oB5C2MkECl3nZ91cGm5lIvbZ7qAQp?=
 =?us-ascii?Q?+gONktWq1z8J00lpha8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 15:49:17.0606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f44d6bed-91d1-465b-b48a-08de284c5cb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0AEDE5C3D
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

Fixes: 7ef6b2d4b7e5 (drm/amdkfd: remap unaligned svm ranges that have split)

When split svm ranges that have been mapped using huge page should use huge
page size(2MB) to check split range alignment, not prange->granularity that
means migration granularity.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 46 +++++++++++++++++++---------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 521c14c7a789..7fe9d569d416 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1144,30 +1144,48 @@ static int
 svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
 		     struct list_head *insert_list, struct list_head *remap_list)
 {
+	unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
+	unsigned long start_align = ALIGN(prange->start, 512);
+	bool huge_page_mapping = last_align_down > start_align;
 	struct svm_range *tail = NULL;
-	int r = svm_range_split(prange, prange->start, new_last, &tail);
+	int r;
 
-	if (!r) {
-		list_add(&tail->list, insert_list);
-		if (!IS_ALIGNED(new_last + 1, 1UL << prange->granularity))
-			list_add(&tail->update_list, remap_list);
-	}
-	return r;
+	r = svm_range_split(prange, prange->start, new_last, &tail);
+
+	if (r)
+		return r;
+
+	list_add(&tail->list, insert_list);
+
+	if (huge_page_mapping && tail->start > start_align &&
+	    tail->start < last_align_down && (!IS_ALIGNED(tail->start, 512)))
+		list_add(&tail->update_list, remap_list);
+
+	return 0;
 }
 
 static int
 svm_range_split_head(struct svm_range *prange, uint64_t new_start,
 		     struct list_head *insert_list, struct list_head *remap_list)
 {
+	unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
+	unsigned long start_align = ALIGN(prange->start, 512);
+	bool huge_page_mapping = last_align_down > start_align;
 	struct svm_range *head = NULL;
-	int r = svm_range_split(prange, new_start, prange->last, &head);
+	int r;
 
-	if (!r) {
-		list_add(&head->list, insert_list);
-		if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
-			list_add(&head->update_list, remap_list);
-	}
-	return r;
+	r = svm_range_split(prange, new_start, prange->last, &head);
+
+	if (r)
+		return r;
+
+	list_add(&head->list, insert_list);
+
+	if (huge_page_mapping && head->last > start_align &&
+	    head->last < last_align_down && (!IS_ALIGNED(head->last, 512)))
+		list_add(&head->update_list, remap_list);
+
+	return 0;
 }
 
 static void
-- 
2.34.1

