Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C542C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 10:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA9810E50D;
	Thu, 18 May 2023 10:53:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E404410E4ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 10:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAmAIpufVssupu4oVuTRY2YXRDdCLTb2tbHdBZhw23tXieVGZdckgL+oDCUuWMTVzDsWIld5jR9I8UchXS+Z82eVOgXhShXcevAd4/Mcr63SAv8ptwxo6Oiy3qHt5/YHGDO+EIdvlIezILPa5+KjheR75xTF5+b13/7zcQlBb8LoUW+stjDG8crI5ekG7GYMVLafSi+q/FT3x4ROMUTt294lR4bszSc1hxS9QMZy0RbyOguKiTyBUVWitSaGr7NxT4DgGaY7+ll65POETkpYMBb7CGTIOrvqVHrJh7fnhyaQc2AiZ3JgH4jQZrzKEUUKhq3VZ3OhLM52Q8ClwXkl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIggiX2/sxkqK5YyMzWk/Dmfm1ouT8Pebb/LKU5mt+w=;
 b=bci2yYso2QW+QWOa3vMdUqJv+b0rlIecL9U3VoumYbqli6Co4ir9BBaV/Z4iHRUMyeWdxHAzGh3T7O9VbJXb//NhRvphHmbIrJ+RBSrSUPryKH+kHLA94Cdqgqs/hjT84+jdJMbRGeWo6qgK4gXgcBaX3TMf9K8YJGlp+lvNa4l2aI4ds4UXm83I+C/CL0QegM3trfhIStxgW+uPe3aqDkQKZKJTdHvT4l7ZHdBUBQdQS4HXSUZzyvnn0mN1UHvs4KRsVPnX2bgGAbx7HCNdakchwG+Dy9lk4VPMN7vFpQaxwgD/mUPQbxvUu+4RkTFtjnZXz9XCjvJ0fljMAxPwKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIggiX2/sxkqK5YyMzWk/Dmfm1ouT8Pebb/LKU5mt+w=;
 b=yUTGoD+gjFI2ovT3UaB8NsofXAjnSfB8Uvwd3hC1vpq45axI1ceWuzKNUkbl4osKSYfrVsVFZdkKnqiYUsBEc6YodcjhbrhvMRpvhacIfGoQ0mekU+h+YftgsH6H7BjPHFiQ671XZ7WKRjwDHQHivqlo77uzbGSaGPu6Rs/UIAE=
Received: from MW4PR04CA0142.namprd04.prod.outlook.com (2603:10b6:303:84::27)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 10:53:47 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::8) by MW4PR04CA0142.outlook.office365.com
 (2603:10b6:303:84::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Thu, 18 May 2023 10:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 10:53:46 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 05:53:45 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] drm/amdgpu: add the smu and gfx ip block for aqua_vanjaram
Date: Thu, 18 May 2023 18:53:20 +0800
Message-ID: <20230518105325.15609-4-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518105325.15609-1-shiwu.zhang@amd.com>
References: <20230518105325.15609-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|MW6PR12MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae6a783-4414-4bed-880a-08db578e27da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PsoIdI5dQDb66lg8eSQ0RuBu/7HcLsfoOf0RRUtE8bjQrZP1Ur4Y5XBDRSdQd4Zh7de9dbW9wt9UdJYU4pjXhkyutBnNTlIl3Exq4DiCD/JEGPkFkKmtXd2BjD0SL+G+7K6kMvNjQp0f2P6XuRQwL+tZUsfcQXh20UUg+6KpT/5xIZgNM1fkRkwSFGF9Ti6tejGvEN8vQL54nog3+Sp7tDAr9YGACawORe+jYo8jIEa9FllGDX3m0sAsqSjx18cXjfter6uQ04QmkYhrN5oaIGNL5Cx7zRgGV2TIbZJAkuZUxneyTWPboH9pN9MlYdVXsA6Wk+qhPbWUIGSVsWdDu7XGyRrH20vG+ylZvHokBxdlb5QV9VwYCf649qMiZkko6gj6eIAhZ2MNb342wj77J71L+YTbm6xiT8dU6U2ck0l0WL1m18rQ5kKA3Inymmsemn6BeeSHdWdJSUERWL+f8cGQ+kKUAZMIRH6DU0OzAoOnyUDuNTfJLXesLswELHINppoN1WQBYoML66Zrz1Vr+UTX7prCRHonljYCdZj0ucm/qURhTtjK5ncBztoFaHeK7fsbhVyysuporWytAF9FMRCUhwSTiFBvANs5UHc3zd/t1tFYqPurBSzm3di+llzq+G8r/CNY7Xg0kcRz1O53DdM5c7eW8yYnjW++ttpw8zKsUwYwzhmsUqi4pOZFYTk1wDvj5eaA+JmKl6Ty2mCSiJytyLZA0l5562Ea0sje7YTnVeEPR6mdm3VD2d0XJ5dAGFl+vuQ2eDrBHfVEf7/uPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(26005)(1076003)(40460700003)(7696005)(36756003)(36860700001)(2616005)(40480700001)(47076005)(83380400001)(336012)(426003)(86362001)(82310400005)(81166007)(356005)(82740400003)(16526019)(186003)(44832011)(478600001)(2906002)(316002)(6916009)(8936002)(8676002)(41300700001)(5660300002)(70586007)(70206006)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 10:53:46.7256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae6a783-4414-4bed-880a-08db578e27da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736
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

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index caae6bf2fd30..a0685a5ebda6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -30,6 +30,7 @@
 
 #include "soc15.h"
 #include "gfx_v9_0.h"
+#include "gfx_v9_4_3.h"
 #include "gmc_v9_0.h"
 #include "df_v1_7.h"
 #include "df_v3_6.h"
@@ -1795,6 +1796,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 3):
 	case IP_VERSION(13, 0, 4):
 	case IP_VERSION(13, 0, 5):
+	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 8):
 	case IP_VERSION(13, 0, 10):
@@ -1893,6 +1895,9 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(9, 4, 2):
 		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
 		break;
+	case IP_VERSION(9, 4, 3):
+		amdgpu_device_ip_block_add(adev, &gfx_v9_4_3_ip_block);
+		break;
 	case IP_VERSION(10, 1, 10):
 	case IP_VERSION(10, 1, 2):
 	case IP_VERSION(10, 1, 1):
-- 
2.17.1

