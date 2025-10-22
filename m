Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375C4CCF9E0
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8C010E6DF;
	Wed, 22 Oct 2025 07:31:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IIcbR30Q";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F71210E6DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:31:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUWMs53bWBhRWbazm+laaMCnqpKNlecHxoS+Pn+wk8noD0YRiQy9HaLTjJZ4LsxOAnL8N+Pvury7PUkZeKOUMzrZ9ChRljhitvwysXd4QV7r6zUKFXrISqgy3fBOhqvgZy4F5MnwmNkd7HtlMYID4LfiaQnym1p/YNzl/OOLJ28+yIwdEKruBXfq4kZQSijyMSJoXdZlt2Pzb/qzn+ipmT6sn35/MXKhJBodhEotfdbw1pnnw3L79MatvNceNELGrtjm6i06VfjmUG1Sq79WPoG37o2q4vvzYMgIIy4l1ysmLAZ2vxCmxdr8++XgXFpi5dBRp+IunogQH5J/sxZxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhN4DqsGLEyRv9ISom/EZiKpZD+Owr+c5+JUrGPB/EQ=;
 b=CMGhvZdzOYJ3StGYmF6jZullTbyUfGR6nDRwN9wPyyFryT90/KnICtK7xesDSig9+LwFGk5ijC7HVkw/iU918OMttp73ONBHd3Wgn5Q8JWkNxseEm2PrCmOVqAhIMt9uismFnkoFDR2OEGWbeXLfCoFWxgKxBuW59I5yNKnIpSA6c5qGOyzXqgpVaEWhN44y6nz+LdZTLDc9fYAtyHjGyQF+BKDScFAPz6GF0QoXPRkmG2YJQG9In97DFffyU7R6cgaIA59ziLdmxCQVJey95YpoywQYah405ugYWRc+f93CdMDjzCKql083MS+gGV67E4zSDq6RFJzgmaTjGbM7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhN4DqsGLEyRv9ISom/EZiKpZD+Owr+c5+JUrGPB/EQ=;
 b=IIcbR30QaX98L7v8HOCKPrI+E47hFPyMBWCL/j9/Rop3iKEncbsDjYRQfFZXxDQhiDd/A4gw35jcnYkXh8yRldrHL9lkkxpnruAoM1dcldAlV/eGbNdnDMc/IRZn8cUhnWq7eu2zIigUVzqjru2wm3ydakVFdDzxuJifNitLnZc=
Received: from MW4P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::13)
 by SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:31:30 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::3d) by MW4P221CA0008.outlook.office365.com
 (2603:10b6:303:8b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Wed,
 22 Oct 2025 07:31:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:31:30 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:31:28 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V6 12/18] amdkfd: remove test_kq
Date: Wed, 22 Oct 2025 15:30:37 +0800
Message-ID: <20251022073043.13009-13-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022073043.13009-1-lingshan.zhu@amd.com>
References: <20251022073043.13009-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d06e204-cd8f-4677-3bad-08de113d04cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6PcfK5n4y1RIQHZm+XklZR/mAnT67cMWTNmRtOMIUBS/e6jl0n5Kr9G9Kjwe?=
 =?us-ascii?Q?Kt9f0oQX1uu3bSbooebVbHxYnPp4xKGIPB9Rq02N9m4eOLPwmeX1jVdCsYX4?=
 =?us-ascii?Q?/1fZUpdSMDpgrAJplOXyOkeU4MPMvnTnKmESLMEZXkgPEL8vi4gApFPo6Tn7?=
 =?us-ascii?Q?CjBkStcDFD6Bu7HIWd5oQwUIhSw8jPDrOZ5MqIxEcLUemZgNKkhnNZk/LfNp?=
 =?us-ascii?Q?Ea+NBJH6QJyGz2m621zpN/7iRhfZVXmXWZix17kU9KMH/l/CPryttM1lO8Ro?=
 =?us-ascii?Q?JGzD73evoxY5i1QizxZBVtR/e7J4fKIbrwDNJgI8Qrb3AUrxO2HgJencv/tM?=
 =?us-ascii?Q?OEZGB9IjN6jY6Jeh0vwFlTvazo3Ki44AZ9APIKU6XxbFb2s2m5VfxkC1Edyb?=
 =?us-ascii?Q?QAHnJxZMEF+jWlPotxxtYATFW9i2vQt6lXYt+zKtSDtPpdof5fTOig1UQZO1?=
 =?us-ascii?Q?q1HeCylogSc/Mx/PLQco7WdHKceRNzI9b/C3umplPaV2EGHbKOmDFwyOtBlP?=
 =?us-ascii?Q?0ZTA8gflCvJ4gEnZ4hLY9HWqixyUQIVtdBOHpYi4i1Hp1lFBMjiMlUkO7Fsv?=
 =?us-ascii?Q?sQfjZ9vcs7Vf+HXZm8BqoTWF50G/+vhcd1Y66zfwkNGO/0PKsuuDp9H0zVAK?=
 =?us-ascii?Q?HjU+MEwtIqJcdBxgwGVSSpu61LHoiqaxuiMTgcHRcNUog/I1jD8u5XM5XJyQ?=
 =?us-ascii?Q?Re5Vf2CDDrnT3ctnlcdsUYnXxvxhqsCD+AyD54ZCVSr2GXTUv8klNpld9tZs?=
 =?us-ascii?Q?0NITwNuueoJzcdQtseuTjHDk3dDcwuhbB8M9LJkAjQbOuAo4ASyd5GZuCYoX?=
 =?us-ascii?Q?gezEajTlGKNmjWbmvJ61TSMf8m4EknRh6ojT35lcjMEQZS/OfxY0XZLB44MU?=
 =?us-ascii?Q?iK/cbuG2s2jFbEgVPECu1srpDstJ+MrzsH8pQmoHFhYTLJYUiC5pZB4Qc49J?=
 =?us-ascii?Q?JTmB0kmVXVMAp6PUSGnDzO0WJuosTuh3mpil6vZF6aZX9l9khKQ0y19SVXpi?=
 =?us-ascii?Q?DL7BmKoU4z0zDyMxykhMGmQH8tDsD2juIbx5a97ggDIuQ3IlkCaXsA+e072Q?=
 =?us-ascii?Q?oOmkXLfAmUUiOlr0XQXR0O44BcdfWWDW4CsEGsOIUI1IDWZUBfQjSQPoOTAw?=
 =?us-ascii?Q?9xkVI4MaVFxZXugrXr1gkO8DeEHQ0op1wedy3kPu7A1c2LtYn57Mm1Mdjd3V?=
 =?us-ascii?Q?5SxfpyxnC7oD1/UCbKOJW9N42Fbmw9Pd4stroRbvNp+qEsZXLnBkE4qufw8C?=
 =?us-ascii?Q?0GFOte5SCvqs+w46bPe99SRNb3AhZsw6Ls5bysD6jdzDXUKanGuASnmaom7Y?=
 =?us-ascii?Q?DHxt8tsGgi4STCX/kZ2IhOg0K6KoVgTB3oBIXwXztNWbkvEc5HAV8SYzgrFC?=
 =?us-ascii?Q?LI9cCHhjDF0YIrj3k8nso11gKKX/dIuXJrBmCTrDJ/fB2bsfsVQC906iJ4X/?=
 =?us-ascii?Q?jWcwj3QCtO60VTABTGK+ca9EHB5ubnjGqn4zERka+k1JHRuFc8H7Hvv+meTs?=
 =?us-ascii?Q?ekLMWhjOnGxKHm764CcPJQSzjH9OPOeXrZ/SAoXCcHQYjWfGf/cd3dwTSPeg?=
 =?us-ascii?Q?I4N7FXxImrINP1SkAFE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:31:30.2964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d06e204-cd8f-4677-3bad-08de113d04cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106
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

This commit removes test_kq() function becuse it has been
marked as unused since 2014 and no other functions calls it.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 31 -------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 19ea759568a6..baeabe3feef8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -327,34 +327,3 @@ void kernel_queue_uninit(struct kernel_queue *kq)
 	kq_uninitialize(kq);
 	kfree(kq);
 }
-
-/* FIXME: Can this test be removed? */
-static __attribute__((unused)) void test_kq(struct kfd_node *dev)
-{
-	struct kernel_queue *kq;
-	uint32_t *buffer, i;
-	int retval;
-
-	dev_err(dev->adev->dev, "Starting kernel queue test\n");
-
-	kq = kernel_queue_init(dev, KFD_QUEUE_TYPE_HIQ);
-	if (unlikely(!kq)) {
-		dev_err(dev->adev->dev, "  Failed to initialize HIQ\n");
-		dev_err(dev->adev->dev, "Kernel queue test failed\n");
-		return;
-	}
-
-	retval = kq_acquire_packet_buffer(kq, 5, &buffer);
-	if (unlikely(retval != 0)) {
-		dev_err(dev->adev->dev, "  Failed to acquire packet buffer\n");
-		dev_err(dev->adev->dev, "Kernel queue test failed\n");
-		return;
-	}
-	for (i = 0; i < 5; i++)
-		buffer[i] = kq->nop_packet;
-	kq_submit_packet(kq);
-
-	dev_err(dev->adev->dev, "Ending kernel queue test\n");
-}
-
-
-- 
2.51.0

