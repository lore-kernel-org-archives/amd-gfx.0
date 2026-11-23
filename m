Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79618606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bx0G5/d2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC625893ED;
	Mon, 23 Nov 2026 09:41:58 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76CB110EB64
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 09:41:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgEuWUVj6ptOZDiH7ztSpEExOfpMmovBKIQgfLw00VANJEDsKPV6TK04sodnH0hvubtk32phJzbryG1Q3PHTwwPPRS90V/xjG37CmfROnBCt6Ju81x83G/LggC1hpEJyDd5y5d4h2p9rLT4uhvRD4uvXexbf6JkU6Fo/aREuaJhdjtJ52QMgVuiKFhPxQifIdjzwupNZX+2H7NlLNVGPjv1y4DrxOCyPLrsrjRZYsCsZEZp5NZ2fmGOI/wdI4HkhNu6NJoE+z5+HQK64kv5XHSphjPyP61X4L8nkki8KU9M+q+iqrbGU15SpbbCj5ZN6GgUJLEfnFWLxQADql5oeFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82a+jdKhcv5uAJC4rEMxmasDrZuvmAhZVW4YzyUAcD4=;
 b=DqHJw8EmkFeB+cx58mQv2QOX8yzEaqSg0oRzFPyBQvaTLIaZIsRA6CGBMeF/+P14gUFBTs2Tao8+gw7EV36UYPkEHXPuFvPcZ/sGDmgeoxmxqfLe1RxHd2LEyAqaGBJN1urMd5o5vqyeSlwXyLydUEMRzlBQ9nL1nU5RYRAEdJPkT/NSVSQUXqCHIb20Y/rZ8kUVTYjjaDX+mCyS+pqoTgoYPnA4EThDJ6PS/EiePAweAQ4uh0R2gGEMdsECHXEY553SnxODVkkRvcguETvGtbUfVP39woTPZhz5fleroQGvrVyA/0bvedS+mJsYfU4zjq8gnhUGMpqswMeC7tSYFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82a+jdKhcv5uAJC4rEMxmasDrZuvmAhZVW4YzyUAcD4=;
 b=bx0G5/d2EXuF1nHXrifTvhbbJMLeZcjjAsOe+vCfX6A8ztX+d/KjiUu2XSKWQARoXChCRP2XU4H6OCT7iQrgraJgKYJiURWq47zLn7ogzYPtineG9mK2q6Lli3Eq66pvZcrg0HPV/218+mc+MVcKKU8HKG1Pex5Au2AJW7FhbDY=
Received: from BL1PR13CA0276.namprd13.prod.outlook.com (2603:10b6:208:2bc::11)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 09:41:47 +0000
Received: from IA0PEPF0000003F.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::1a) by BL1PR13CA0276.outlook.office365.com
 (2603:10b6:208:2bc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Mon, 23
 Nov 2026 09:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003F.mail.protection.outlook.com (10.167.249.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 09:41:46 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 03:41:45 -0600
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Zhu Lingshan <lingshan.zhu@amd.com>
Subject: [PATCH] amdkfd: don't give a GPU access to SVM ranges when no VM
Date: Mon, 23 Nov 2026 17:42:29 +0800
Message-ID: <20261123094229.12597-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003F:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7ea036-0188-461a-7b63-08df4945fda5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|261102123227099003|11063799006|56012099006|10067099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: NscZ/g1pl+8/jCVBo41cR99Kh/1UCkpX5oXMp8BPhziwWJ1DAGPHizRfSQxXh48nGW/Ceaipx3nA0zoTqcMQlIIADuDkxfi/U2FOl3Np/oUuvboFb/g5/TFCWVkZdV3jljwBtVawvgEA1IFlIgN7MtBptxUkRhOiDRB0wJ+TSNNweWpNfwuV40pApoDc3yWqmTRjhJJGbG3SwQMwq70SbBBOroU/uF3x35URmopgzDu7moQ6nBf72YpiaaSjG17tojcLH9tAhta7wqRm9w0yIMnNn4BgGp8cP2R6dFcLlgeG0G7qJq3jYyvAT2Qk5aBPlx2IsGjzuLhHeVl//3RbncZ6A2AJVEvyTMRfFF65aQFYpl33icTt4u3rczRtoif9WO+nwCsSmAlaU3Ag67YMmXMx6tGBf2pEjuHTSCvh2WSlnl7q7Mbe/zmCtSUsCSwK1TQL8ha1yjFeh1REf47LR/UskoKYc8vkLPVHz0Veo69bfFVLpC9GONB128vUJYfsdYAIuPqTfDF4XpmteuklhEs3ymlzeHZ9OwALjHouXg/pgioON3Nl/jOIYeFERb0byIrq/8C53y4pyKzt/Aul7PFBhjiyRC/L4HYinnhRKpf/msz+LOQLSo5J2VDsC0D1lanJgwNxF+Znq95qUsO5TVF00zRmIVRK1T7fvlODl05GwsM9kHdl8TanNM/N4k3NwuuzXfV1owjYasoVc3wldw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xamb8Y9xluq+/oqIwVBEPe+mFIvU+QapPj7P6cQDuUvt5XXUFKfhL7wX0pmaksPBDWM+m9LQIH0kQBdGEEwacRoi3EA1ogyp+zmBodeR30BUiJ9uAZ/Y8SztDWEQxlbeYUEvEi7b09DJjNZzyexX9zNqTy7N/L1CkK6u7ejqrT/ThPAOKjMC+O3JaSxskDAPSBVi/KZu3N3BT5J1OEMf6ru9jijcI9V+qMiakFY/qUmjf05oiC+SwTHr4DF/OwtQeYntzW3qMDcKnE66bQ8LapK5leFkFslch3v52Oya/3jwxjjmJPPqB7WkLYJGg9xSKv1nRusWrxRaoFQxz0iVUwrbITIBkpsYHikSAhxsFBf1Bn7Rlm4o/Du5OnwljbuQJwcoNYhyQdG2s1YJN/L+aQZLoappLHfyfIymHZ48cMM4JpwLwSut9KI0tm/jPJ/W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:41:46.6522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7ea036-0188-461a-7b63-08df4945fda5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If a kfd process does not perform ACQUIRE VM for its
kfd_process_device, the VM of the pdd is NULL.

This commit fails svm_range_check_attr() with -EINVAL,
before it changes anything when VM is null of a pdd.

When XNACK is enabled, this commit does not give GPUs that
have not acquired a VM default access to new svm ranges.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7401b7fdcb57..6e42b358ad59 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -339,6 +339,7 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	uint64_t size = last - start + 1;
 	struct svm_range *prange;
 	struct kfd_process *p;
+	int i;
 
 	prange = kzalloc_obj(*prange);
 	if (!prange)
@@ -367,9 +368,17 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	mutex_init(&prange->migrate_mutex);
 	mutex_init(&prange->lock);
 
-	if (p->xnack_enabled)
+	if (p->xnack_enabled) {
 		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
 			    MAX_GPU_INSTANCE);
+		for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
+			if (!p->pdds[i]->drm_priv) {
+				pr_debug("GPU %d has no VM acquired, skip mapping SVM range [0x%llx 0x%llx] to it\n",
+					 p->pdds[i]->user_gpu_id, start, last);
+				clear_bit(i, prange->bitmap_access);
+			}
+		}
+	}
 
 	svm_range_set_default_attributes(svms, &prange->preferred_loc,
 					 &prange->prefetch_loc,
@@ -722,6 +731,13 @@ svm_range_check_attr(struct kfd_process *p,
 			break;
 		case KFD_IOCTL_SVM_ATTR_ACCESS:
 		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
+			gpuidx = kfd_process_gpuidx_from_gpuid(p, val);
+			if (gpuidx >= 0 && !p->pdds[gpuidx]->drm_priv) {
+				pr_debug("GPU %d has no VM acquired, so SVM does not work on it, please acquire VM for it first\n",
+					 val);
+				return -EINVAL;
+			}
+			break;
 		case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
 			gpuidx = kfd_process_gpuidx_from_gpuid(p, val);
 			break;
-- 
2.53.0

