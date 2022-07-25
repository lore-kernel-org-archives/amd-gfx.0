Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB33FC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 12:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44394A69DF;
	Mon, 25 Jul 2022 12:24:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5140BA69D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 12:24:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEYn3LTEer9GoUB15+M1/bDY73CvsuxDUFpQBwJbGZIC7zBj+ka6j4J4A0ThwKTbXLsEqr6jERCCtjaABNP9XOuQmpF3TeDsJwVJGYwsi2cB+LZVs9C+EsZwJb6qfpFipsn7sj1ir144VPQTqecgvUVkyr5WW93S5SDV+L/XZyznH5Gex/CcwSBsuANfb8erfQKZCDQ0Z5TMvZ4gba+61nKNxLX9f+GEPlSqty9IRiWpSV+o6DabX08nnUQKraHLVxwIpwZgi1UjfNdl1xm6Kaz5bfq60b8WF3tIXJeQ6Zkhkm1c1/Ymr1Ejve+dBrZGBPEsANUrhKRYDUYUqibhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wv4UG8QyuhPI9cZSKXNKCsS5SrIokjz9Nop6y+WDDw0=;
 b=CffDzyO6FugGQ7IRQVN9etAgM6kyK2mhw7/nFdYH1I+FneqDv1L4Y7/LnOtt4ZuSVXhDj77lqUZ4pnBx/Zqf6KVGLv1AjRQNWWQPpTgu8mOX5mAqxVKT7bkDToNAI4sYVhIgCBaRJZWUTyHTVYBcomvPyzUgpSFZxaOLsOYwHhRhxGA1uVNLE6UcjegDX/Gwu4/TEzpNtn6A//BQZXVeeojVX7sxMOstOiL1rWT9TYrGVaSWmYf53zoWJK5ko2BqDaVcNR9cWkKKdlbLpjCLw9fF8M0YBpKwS98gtK76KnjoymufWUioBoFm7Q5Uv+SVy5yD4PpGy0pNZdqjLvk2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wv4UG8QyuhPI9cZSKXNKCsS5SrIokjz9Nop6y+WDDw0=;
 b=ERQByhOtKmqlHBREzkyr23d2ZeErLcB0JqClZ85NkVv4qdTWP3dUsjyOJ2/igFzrAVJ5R+99tg2WYAXp1014J/wSm8jCYNSl/qiHcMtHlMYQpeODqeJrt/x+4VzyqCMODS6DTLZbqQCKK6JLWLs8IaZzTdPSOLWO8ecHWnbPVWc=
Received: from MW4PR03CA0204.namprd03.prod.outlook.com (2603:10b6:303:b8::29)
 by SN6PR12MB2670.namprd12.prod.outlook.com (2603:10b6:805:6b::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Mon, 25 Jul
 2022 12:24:20 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::c4) by MW4PR03CA0204.outlook.office365.com
 (2603:10b6:303:b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Mon, 25 Jul 2022 12:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 12:24:19 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 25 Jul
 2022 07:24:18 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdkfd: Split giant svm range
Date: Mon, 25 Jul 2022 08:23:17 -0400
Message-ID: <20220725122317.24606-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725122317.24606-1-Philip.Yang@amd.com>
References: <20220725122317.24606-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20cc196a-59cb-476c-0713-08da6e389993
X-MS-TrafficTypeDiagnostic: SN6PR12MB2670:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dGH817V1mmaTXl9XDmEq5oi5e252X8A6eAFU/jN5+lSnsmjrtHHlScBRuoN6N+Kd5kSAp2Ztaz7RNm1m0XBeyabFEulmZSZTNi+LaMcS6egbA4ysCCQX+QZvyC7DCz8ct3xFTs45wxsji0dgXvQEelmlW0S6vULGdAoAHJEnznES1u97xkOM3RW3fvPyoxeAlr9LENN0wdHJacgws+v2TVRWRXkr1FfDfMqVWcpdeZKWtVtts0hMGH4/SOkly52/i+ciydrOnx17akGxsj5krKYblwUoxDT4Gz+25bLXOlvsG8pOZrmlIitDfKWiwze/P1+ubz/fhHZ3aTPGaOtFbjvF1V4QsqAbZ9ggcijsLR1/sU9xlBrv2T48gVrJL1tW6+pmx3dsfvGH+KwoGQd7tYQCH/9U+orNve2yN8tmGc6KKlyUlXUmv47mgPKcC8JdG5OlFzPrsijYvxxHIhos0JJTNKT+gYhryBgG675WMWuga0lGuQU6nglGBFB6Kpud2+B6xJRtXRw5LIhNLhIkwbTJMXZpM5eJm7KHwh2dCpgzPVaqwp/vV/PvvxNZfrR5wf9N34Bfr+jfyuh6PiFfdmpu+LT2z1qPOQoRk76QSr1sAbwnqFiAuZx8+ObOvd4VfH/q0/KKzz54IQs90alyChHsFGeRFpSYPVAe7o/Nabj1/2PK7w6DyK0qGgABZ57pOI+SQp2KYeAVJZ6aP32kNo06uzOqOIdJ4+N20jEidjlJHwP+ldYY4HLs+zZU8M3vRlR9Z8PFpMMZI1h3u68GQSLDdNa6B2l1U/JFk2OT9+FVvBf0zsrGE/zekebwgS2XVxLY/yt4hbuvKhPvLQqx2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(39860400002)(36840700001)(40470700004)(46966006)(426003)(336012)(2616005)(1076003)(41300700001)(26005)(478600001)(47076005)(16526019)(8936002)(36756003)(82310400005)(186003)(86362001)(40480700001)(7696005)(2906002)(81166007)(82740400003)(356005)(83380400001)(70586007)(6916009)(40460700003)(5660300002)(54906003)(4326008)(316002)(8676002)(36860700001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 12:24:19.8088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cc196a-59cb-476c-0713-08da6e389993
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2670
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Giant svm range split to smaller ranges, align the range start address
to max svm range pages to improve MMU TLB usage.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 52 +++++++++++++++++++---------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cf9565ddddf8..044bb99f88ea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1885,6 +1885,37 @@ __init void svm_range_set_max_pages(struct amdgpu_device *adev)
 	max_svm_range_pages = ALIGN(max_svm_range_pages, 1ULL << 9);
 }
 
+static int
+__svm_range_add(struct svm_range_list *svms, uint64_t start, uint64_t last,
+	       struct list_head *insert_list, struct list_head *update_list)
+{
+	struct svm_range *prange;
+	uint64_t l;
+
+	pr_debug("max_svm_range_pages 0x%llx adding [0x%llx 0x%llx]\n",
+		 max_svm_range_pages, start, last);
+
+	while (last >= start) {
+		if (last - start + 1 > max_svm_range_pages) {
+			if (start % max_svm_range_pages)
+				l = ALIGN(start, max_svm_range_pages) - 1;
+			else
+				l = start + max_svm_range_pages - 1;
+		} else {
+			l = last;
+		}
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
@@ -1987,14 +2018,10 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 		/* insert a new node if needed */
 		if (node->start > start) {
-			prange = svm_range_new(svms, start, node->start - 1);
-			if (!prange) {
-				r = -ENOMEM;
+			r = __svm_range_add(svms, start, node->start - 1,
+					    insert_list, update_list);
+			if (r)
 				goto out;
-			}
-
-			list_add(&prange->list, insert_list);
-			list_add(&prange->update_list, update_list);
 		}
 
 		node = next;
@@ -2002,15 +2029,8 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
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
+		r = __svm_range_add(svms, start, last, insert_list, update_list);
 
 out:
 	if (r)
-- 
2.35.1

