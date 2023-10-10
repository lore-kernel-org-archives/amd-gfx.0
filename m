Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1714CD8C9B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 14:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17D2510E38D;
	Tue, 10 Oct 2023 14:41:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990AA10E38C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 14:41:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUyfThBF5mc+mMkwk4FeeL9PEH0WQkVbP18B0C/SnaB3CjloBenjyNm8jVbKgi45NC/J2Ncssk9AZa3evGnV7qbV2wfGvEjv1uZoqfElc9CmCyBT1n9I7D/usfoUrXlrPdYaFaqhlQsDpJ3ebWT2DM5wNEroLb9ekUflp59m3P8UXbUMLbhEyMLNbHRY/AdN/nBCRdJ3ajtCjxqmMRZN4uvD4AoIqY2Jy1wu7NKVcRSOO4UiqE2wtE5wLWMwDw/c5GiK5M7va3v7El/SPIYvL6ELz+RKql4TYlSTwoxOdrmYB+8QoIe37Ndx/BM1SmqwLhOBvuz8JL+972qzz6drQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyBWEp3qUxjNY6dsCHw71j668a7zCnlkpUzOTXxneyA=;
 b=GzuCuE2WmwyM9JvHLunfvW5n5i1nKTyEChMqEKLPU1JJY2GHLKKZykC99rnxvjSYj/npW00hNDlASgGcjx3ff8Ump9yXMCNRnE+IAnpmdQNcs2P03WXLHHci7Jk3HSTM5neUCTgsdnzkdLJVxJmIVfqVW/sGyfKlLYAJv7xf7D3aVhRhyxz0RYNoaKQ6g0UyJ3UOsTgUnmR0dSBggvot0zBOnI0VkbuZIqQu8cEnR2X3wN/wy8RP4GjHR92+AaXBuW+nFBUooaBKxEea2M0Btpf2+MQBXyzmdYyuJfWAS0KxY3NPdkvC2v717OlSO/5XhdsG0AbBwtdB08awPoA76w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyBWEp3qUxjNY6dsCHw71j668a7zCnlkpUzOTXxneyA=;
 b=oz1PkMG759ke4JCZRwvuxC9einHV0BB51GQroHgXdYJvGXsS0vLFywe4KPy+tv+sOApXrDVjVZwyUqoC1Pc9x3kHinPpH/fHLiyrkEbLF9pUy4YKr1Cdf6WTvFFnlOovz1UMTr14qGiujXK8v4b3Lm/8zv79dsOa8IDMFUKIKTc=
Received: from MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::11)
 by MW4PR12MB6952.namprd12.prod.outlook.com (2603:10b6:303:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 14:41:51 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::4c) by MW4P222CA0006.outlook.office365.com
 (2603:10b6:303:114::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Tue, 10 Oct 2023 14:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 14:41:50 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 09:41:48 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 6/7] drm/amdkfd: Unmap from cpu split the range and
 bitmap_mapped
Date: Tue, 10 Oct 2023 10:40:23 -0400
Message-ID: <20231010144024.3016-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231010144024.3016-1-Philip.Yang@amd.com>
References: <20231010144024.3016-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|MW4PR12MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 9882fd06-54be-4f92-819d-08dbc99f0a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ngItYL+hu/EOZuXH7yTW3rhYImgjx12M7MCaT4Y0QQbxY8hsyG3jeFl6ZfgtN9QTc7LIid/W3/UAjT9R5n5wuRkHbkTaAv4irbo4327p3SA4MysHmZZt4CbeWkUY6nynGxhw0jBx2xo9CMEHFdzjrrB5Yk9/jYsQ88XUHTvPvgdTFe6g0Dfjtjr+BrILZD2hStl7ft7WjFXq0gm/A6DKDkKxftdIIlQnsLuxNGl0iq261rnJptUF8pCrEiEygOAH5JzkdKHPN6Bg146dZzKCr8GhTAMvnoNSXDHwH3fbVa1o5JbSufUlkFRAM7sjKMQgNxoRbTLkk2RfNQaDbFG3hPbFo1cvRNNJt366rv1a9jbbJPRAQEBUIlxT85lLrAfl6KsKjmLdqBgLVHVq3fUPkS6tYst7Iv8riDXVNWKXAu1aNBYMbq3mgaXDK54SOp+1ZJw2Y8z3P+lDXNW/2CwlBDmKYEKEWXySWu+rfNxUQBEhy3VRA7daVpJmiLeYeUG1qmOXsidNpLFNjjzjaVdEH58tYmsK/IzqZn4slTAdNBiexz+1oAukAUgQZQxhrMi7TfOGnjZ/s1OffzeYIfsEuSwphw93977CfEu+p1mXn/qcJLKtggqHM2HxAwXZOKFdA9MyR4DL+K14GPb4YIKeHW/KwSBhqGuObiQdADpsv6FVUCxur9wMtYmoWhd7H3gybntWtK4FCGOs62bjSTgyVZgOgk4/ceu7j+4/hxXam93fzFiFNwoJXWrQk1nxB16+TmZks6PqYYbreJuwBui84w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(1076003)(2616005)(336012)(6666004)(478600001)(7696005)(47076005)(426003)(16526019)(83380400001)(26005)(2906002)(70206006)(316002)(8676002)(6916009)(54906003)(70586007)(4326008)(41300700001)(8936002)(5660300002)(81166007)(356005)(36860700001)(36756003)(86362001)(82740400003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:41:50.9322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9882fd06-54be-4f92-819d-08dbc99f0a2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6952
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Unmap the svm range from cpu will unmap and remove ranges, this cannot
align the start and last address to range granularity. If we unmap
from GPUs first, the bitmap_mapped flag is updated, split may get
incorrect bitmap_mapped for the remaining ranges.

We should split the range and bitmap_mapped first, then unmap the range
from GPUs.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 0ee5633c8972..e1392b277399 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2672,24 +2672,32 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 
 	list_for_each_entry(pchild, &prange->child_list, child_list) {
 		mutex_lock_nested(&pchild->lock, 1);
-		s = max(start, pchild->start);
-		l = min(last, pchild->last);
-		if (l >= s)
-			svm_range_unmap_from_gpus(pchild, s, l, trigger);
 		svm_range_unmap_split(mm, prange, pchild, start, last);
 		mutex_unlock(&pchild->lock);
 	}
-	s = max(start, prange->start);
-	l = min(last, prange->last);
-	if (l >= s)
-		svm_range_unmap_from_gpus(prange, s, l, trigger);
 	svm_range_unmap_split(mm, prange, prange, start, last);
-
 	if (unmap_parent)
 		svm_range_add_list_work(svms, prange, mm, SVM_OP_UNMAP_RANGE);
 	else
 		svm_range_add_list_work(svms, prange, mm,
 					SVM_OP_UPDATE_RANGE_NOTIFIER);
+
+	list_for_each_entry(pchild, &prange->child_list, child_list) {
+		if (pchild->work_item.op != SVM_OP_UNMAP_RANGE)
+			continue;
+
+		s = max(start, pchild->start);
+		l = min(last, pchild->last);
+		if (l >= s)
+			svm_range_unmap_from_gpus(pchild, s, l, trigger);
+	}
+	if (prange->work_item.op == SVM_OP_UNMAP_RANGE) {
+		s = max(start, prange->start);
+		l = min(last, prange->last);
+		if (l >= s)
+			svm_range_unmap_from_gpus(prange, s, l, trigger);
+	}
+
 	schedule_deferred_list_work(svms);
 
 	kfd_unref_process(p);
-- 
2.35.1

