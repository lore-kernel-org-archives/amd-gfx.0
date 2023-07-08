Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C2BEB64DA
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Jul 2023 16:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E13B10E06A;
	Sat,  8 Jul 2023 16:58:11 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B43110E06A
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Jul 2023 16:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcnJ+3x4mNsuKyACTnFJo7nJ1Wt3eZpP6vyBllfh0/0RFBDpE6pZ3r0KOdjwufDBIbSsXGnMz0v6EEGIEiGkt2+02wNqCV38hCKNST3suQXNuYh/X28hrbNxi3Z8efAgwudRLfrSomOFbYYu6xtEBLhS7bcFcUtqjnsPHjfsYs49zY0vUimwjXJ8Fm2vW1tMTfuxtF5DS82o1Ed5AqTiKmGB6Jhx8CsOEkAEEDZcCfAXvJqedqTBGkYgNwZSTwqM7L5NwfXnqfwXEkZ2sdM2eHCUIOvs4Vq/yomjBiBpooI+F9aAaMtJksibvqTi4oI/7C5eBvSNghn2Tb0TriFVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7gzp9MVKToBXbLu4CE21AI32GsEt4zYhsGhTdFv/s4=;
 b=Q6MQWkAX2XR/zjwTOIbGC8BYvvOyB9+ONvLBkOalbnB8DzSxlqP3UJRYb4NxrnbziFn2x5MtzKjU6B/ebZametz7MoO8ZCaQaAfrdtkqDnMYnB1nT4yCgXIw/hyMooPBGZfG2eNR3OU8U5sJlyVwmL7M5OfkrZ2Z+7cjGDbuIb9tZMYEadSQ959shsvzrbddpfMJDqntM7cMnwjG52XZU0jQ8NgKYQlOW1JqRZxTn/3nXPcxCImlkg4qBqF1rZgGyEdsTQG7KaP72jPQ2HtmsmXRwtpg1FOP1+uNEoIi4Gj8C4SB39hNXs5LmwWDoqWdXKW5eUd71nbid613Mir/Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7gzp9MVKToBXbLu4CE21AI32GsEt4zYhsGhTdFv/s4=;
 b=dIVgosDF+Z7PhOduIkyE8uz++RmwOQYY4XO6Jl2k057zTFAJpoWs30/8sCwTNWeVqMAAKf1V84aXMje1fFZLIBU5pXclgMNRhR+hau5L9/OYLnUoSNclc6Ja8VrtjEiHnaGIQac67q2HWPFKwfpOHa1cJAATNyZ5lUsHYR04pP0=
Received: from BN9PR03CA0226.namprd03.prod.outlook.com (2603:10b6:408:f8::21)
 by PH0PR12MB8823.namprd12.prod.outlook.com (2603:10b6:510:28e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 16:58:02 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::1e) by BN9PR03CA0226.outlook.office365.com
 (2603:10b6:408:f8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26 via Frontend
 Transport; Sat, 8 Jul 2023 16:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Sat, 8 Jul 2023 16:58:02 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 8 Jul
 2023 11:58:01 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: avoid svm dump when dynamic debug disabled
Date: Sat, 8 Jul 2023 11:57:48 -0500
Message-ID: <20230708165748.31355-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|PH0PR12MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: ba28c2c6-c20b-416b-0cfe-08db7fd47df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UGMR64KXbBT6w8V8tsrFRhpSHgmqzxhb238HAmWQVHvlbIyOm4sP4ZbfXnfJ8Pn7xboXrcKcpzkCWGnRhsd933LM+ga29FF0DWOQDbv9w3XvU0VNQy69TIWjCNxXgXAnIoCN3hg2bFY2CYJwRaQl2M1N7pf0th+qHRXD9QI9CZkQ476Qv86ngZV+HxNtnBAIhfpjSAeFgAUMeAb7ZRUQ+zxfiLkzulVvePf3k7rdzzGpVNh/tjtivlpYiB95LOn1Aw+PHomx6N0aYC1mmBF0OX+AneRxuXFijY8LaERMoHnGSKWYScDO/GYu6Q2tq8Awy1GB89YjWqThFEhPaP2IURTnxtREaEdzLFJNHeeFd1ASmDscsPOD74lPuZiHBHFMSOZLPIWF5U8Z/FrKVsTrZ02BC5+K4xBtHyxn2Mvjnlxup4uGgT3hheXWnwtdTY0X5wpSMA0Ich6UqA6SXBrKv4CwwKzVh8Y+iyYRZoH2dpAIiEuNfTfie4mpBJaTT2kMn5yKz3aXzSey7c2bCrz8rwDsjGDgKSXBh9gtm5pi+hCKW5xX0rNHcScaSdCvWRNOC4nNkJn3SmIk+RfBMVH7Kwo6hwuIvglzbmKxUo714kbUZ5VNhwSy059dRohIumBWfiDsQO/UqSbwVyPpo1OQXmtSu0Go0U1+f5U4JWL/pL7Y6ZAVFNgTD4xqCnkuU3pzrKXS4rHP1Q9d9WDFdj4hD4dIHXa7nrb4Ub5/ubezeijvM3+W0GS6Vqd8NsOQlFNoBJUaNRLaV1AzxdUiP++L3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(86362001)(82310400005)(40460700003)(40480700001)(36756003)(6666004)(7696005)(478600001)(54906003)(70206006)(70586007)(110136005)(356005)(81166007)(82740400003)(36860700001)(26005)(1076003)(336012)(186003)(16526019)(44832011)(5660300002)(316002)(2906002)(6636002)(8676002)(8936002)(83380400001)(426003)(2616005)(47076005)(4326008)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 16:58:02.6012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba28c2c6-c20b-416b-0cfe-08db7fd47df9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823
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
Cc: Alex Sierra <alex.sierra@amd.com>, Philip.Yang@amd.com,
 jakub.kurzak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

svm_range_debug_dump should not be called at all when dynamic debug
is disabled to avoid iterating over SVM lists. This could drop
performance, specially with big number of SVM ranges.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 479c4f66afa7..4fb427fc5942 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -821,7 +821,7 @@ svm_range_is_same_attrs(struct kfd_process *p, struct svm_range *prange,
  *
  * Context: The caller must hold svms->lock
  */
-static void svm_range_debug_dump(struct svm_range_list *svms)
+static int svm_range_debug_dump(struct svm_range_list *svms)
 {
 	struct interval_tree_node *node;
 	struct svm_range *prange;
@@ -847,6 +847,8 @@ static void svm_range_debug_dump(struct svm_range_list *svms)
 			 prange->actual_loc);
 		node = interval_tree_iter_next(node, 0, ~0ULL);
 	}
+
+	return 0;
 }
 
 static int
@@ -3563,7 +3565,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			break;
 	}
 
-	svm_range_debug_dump(svms);
+	pr_debug("%d", svm_range_debug_dump(svms));
 
 	mutex_unlock(&svms->lock);
 	mmap_read_unlock(mm);
-- 
2.32.0

