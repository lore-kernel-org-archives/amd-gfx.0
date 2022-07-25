Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE45C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 21:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 400E48FD16;
	Mon, 25 Jul 2022 21:18:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E41C98FF4A
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 21:18:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0oQVOkhRenl2hWETqiC6T1EFtDm2fZ4XuOD2GlZ1MlFL0bhjYgSDhaJXo2OFh0Y6kv+qwgXiscv+xhqOgXUF3Bu2N2Bd4fTwFwBAf9fMRcg+fXYJaA1xZ5ugoOt4fMuADPPYYBD8CCjxEBbaIzYtfophhswQ420Uwx8ifeZ/x1f5CqIf9d4a0dmS6c6acnVv8bxE6QYuqChL+nq8vd9u997r1ASgO6ySdYekUz4E9Ukff7yiVIQSerlIOWEZh/vn2A2N/qoLcFlLVyMF2d7WnjjJxb9ncgUStSrZ0aXTrpjlZN1ExugKzjFlLVJgQZDirR750ywRE5sTYIve3BGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Nrma8guU98wcrmc+mh6nLnV1zWJzu7dEGjndK0hzB0=;
 b=hllDY80dOoIthB4AnjIR4igFsLp97YYnOG13BKyN+XwGpLDzG1WW49hgCCPs3RW76IcNlai5ksnwQewqPT7EYBS7oNzy7d+qoLlcD9lrbnn0JPfWhdkRq6r4Lh2Gvh+Vmxt663a4kaoPh7kkeX0yaQHQAZzudDw/8C0Er3qZrCqCbpxyjmSK/x0Oe7z4zWzEbx6jeCZtstlhNZcx+k8dyO93fNqhihjKodSCYZ/7z/g78PdMWhJbxPvfj9yEW1Gv4NpHjP1pbQD1Tw6vmi2UrqhR+ZKjAJsewexYvCxKnp3EJLysOCa/lQcsUuXl8yu0eeU2yOb5jsUM+uRu5ge+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Nrma8guU98wcrmc+mh6nLnV1zWJzu7dEGjndK0hzB0=;
 b=YJ4l7NuMpmrrg0gSJeJethqVZXTAo/CkJiP/DRZ7eFflfCToQwBDvor5rXm8kC4t8+Gwa0rek08Sohlr4pc1MTKr/wV10t6M+LUCFMhKt7dqqGSe/W1J9umXGI42P1PhwnOWGESnncy3hYidSLZj/MF64k9orbJjtm2yfC9R55Y=
Received: from BN9PR03CA0330.namprd03.prod.outlook.com (2603:10b6:408:112::35)
 by MWHPR12MB1760.namprd12.prod.outlook.com (2603:10b6:300:112::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 21:18:32 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::be) by BN9PR03CA0330.outlook.office365.com
 (2603:10b6:408:112::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22 via Frontend
 Transport; Mon, 25 Jul 2022 21:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 21:18:32 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 25 Jul
 2022 16:18:31 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/3] drm/amdkfd: Split giant svm range
Date: Mon, 25 Jul 2022 17:17:43 -0400
Message-ID: <20220725211743.5937-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725211743.5937-2-Philip.Yang@amd.com>
References: <20220725211743.5937-2-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa521a4c-20b3-430c-fd2b-08da6e833a20
X-MS-TrafficTypeDiagnostic: MWHPR12MB1760:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: In2UbQadrBOSgUjLQ5ZcerwKKNjr2c2n4y79Ou5HQy/e8PwKMWkNAFhrzLU85Z50UH9K9Or16E6VXpBxeAxdCc9HVYy9q5Gys23Q99ONt72F/zC8Lx3XzU+c9xJma9w8uEHGvBEXmvymVsJjCRy0O6RCNqf/b8feGLxYIuS7Wq62txyrA9FnKCt48QhdVOxNSrw8dMB5sZVQFOoX8O9cEyIUxg4dPkV622PJXYKGL9DLArOCFjaoZsB+o3SUd7+5J3sixdeqmQbzRvuQ96l535+BoKNnzAWWkYJekAfJ5SgE89QejKn8SVAKYdsmnO1MBDy4m/EQf+4wf8vB1gkYGvUjIjNhBw21Od/Sv3Mr4ByUSLQtqcOq/xnCv2Kvc+t2bHUgD7sc3md1rYLtGdGMylFAFwF+0l8RhpO5rcZXjXRYBHDYZnGR9yHAfWpWANZ5fZiAfTIEkFMu/JO4IJuOpaIEhqClyr4Tg7lEYot3nk3gTuNtoHKNzZxlIOJXX3gfwzC4+lAYD4ETSsx1bMnWIGPAqP5psegMKoguuKH+1OUtVfl7QtqD8v+3C5dK0o+sU/FzGNluDZmzOE1WDarL7Pg0gbZ0zTj4WJsqG+S5yTvR9bMO34dmGRZZF4iXxpJkCt7jBTt1W3ctd26vQ+5VkWypcabE+mukXBHUhLI5bJRZz3+rXhztj9IeykpVpyxIjBbq9417VSwtltb5NWcB0jkvLrXdLDlxnAvunkK59O5/FF6IAwRGuOQz9nROV8p08QsW7YnDPmvjs8Q7sQvVoqesRBptM3UzqfkwmEFWeXm0fbjDFTfT6qS17GLxIXabvqIM/OgYB190GFENjvccKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(36840700001)(46966006)(40470700004)(82740400003)(86362001)(81166007)(36860700001)(356005)(1076003)(426003)(8936002)(40460700003)(47076005)(2616005)(16526019)(83380400001)(186003)(5660300002)(70206006)(336012)(7696005)(478600001)(82310400005)(40480700001)(41300700001)(26005)(2906002)(70586007)(8676002)(4326008)(54906003)(316002)(6666004)(36756003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 21:18:32.0733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa521a4c-20b3-430c-fd2b-08da6e833a20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1760
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Giant svm range split to smaller ranges, align the range start address
to max svm range pages to improve MMU TLB usage.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 49 +++++++++++++++++++---------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 9d855890658e..ef2fda5a644a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1891,6 +1891,31 @@ void svm_range_set_max_pages(struct amdgpu_device *adev)
 	} while (cmpxchg(&max_svm_range_pages, max_pages, _pages) != max_pages);
 }
 
+static int
+svm_range_split_new(struct svm_range_list *svms, uint64_t start, uint64_t last,
+		    uint64_t max_pages, struct list_head *insert_list,
+		    struct list_head *update_list)
+{
+	struct svm_range *prange;
+	uint64_t l;
+
+	pr_debug("max_svm_range_pages 0x%llx adding [0x%llx 0x%llx]\n",
+		 max_pages, start, last);
+
+	while (last >= start) {
+		l = min(last, ALIGN_DOWN(start + max_pages, max_pages) - 1);
+
+		prange = svm_range_new(svms, start, l);
+		if (!prange)
+			return -ENOMEM;
+		list_add(&prange->list, insert_list);
+		list_add(&prange->update_list, update_list);
+
+		start = l + 1;
+	}
+	return 0;
+}
+
 /**
  * svm_range_add - add svm range and handle overlap
  * @p: the range add to this process svms
@@ -1993,14 +2018,11 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 		/* insert a new node if needed */
 		if (node->start > start) {
-			prange = svm_range_new(svms, start, node->start - 1);
-			if (!prange) {
-				r = -ENOMEM;
+			r = svm_range_split_new(svms, start, node->start - 1,
+						READ_ONCE(max_svm_range_pages),
+						insert_list, update_list);
+			if (r)
 				goto out;
-			}
-
-			list_add(&prange->list, insert_list);
-			list_add(&prange->update_list, update_list);
 		}
 
 		node = next;
@@ -2008,15 +2030,10 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	}
 
 	/* add a final range at the end if needed */
-	if (start <= last) {
-		prange = svm_range_new(svms, start, last);
-		if (!prange) {
-			r = -ENOMEM;
-			goto out;
-		}
-		list_add(&prange->list, insert_list);
-		list_add(&prange->update_list, update_list);
-	}
+	if (start <= last)
+		r = svm_range_split_new(svms, start, last,
+					READ_ONCE(max_svm_range_pages),
+					insert_list, update_list);
 
 out:
 	if (r)
-- 
2.35.1

