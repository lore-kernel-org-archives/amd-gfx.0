Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8894C6FA8F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC60A10E5CE;
	Thu, 24 Aug 2023 21:53:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26CEB10E5C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9vw/zsjliILeq84yWkjjfG845Iy0cWNYkWYVpqMAk60DQvfHKt0o65ZqkuxkHr9jFubl29L21mWl8Zl+qQ5AXyDReD+BiJkyB1iyrRqJTMrRuhnBW9fSBdKeCfzD//YPdizMRCeT2UIWfetB3WlK33w78AL9BYBJvk97yu8iFPVKDFh0JRNRpr1z/uCU0UvNHy6NjyGBbHZOiPccQEPeTwplaLU8/BT+PIwQF+QiBkNqAwC+IRhBw4AG0Y4hI6KxtlTK8PrQGzYffDXP9DX2HqCJHQ+zNT0R/AJXiwBdqfAyFdzDiBqbYWDIFG5sJ7ykbalWi00blbnWmtO429DiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGw0CXJ9BDGQ7syo4Dm885h4p4PA/iXL9wBBQv96UI4=;
 b=k9zJNV/ZptYlgTuYPExoi2+cX3FqXLL/0FBGWFxAzgWVy/WbXLLed4DhwqynCD9Ijf3XBsoHAPw30X3m3+Ma+Bi8Ub1r3DCao+2Qx7avNnGwi2vv+J3vfNivDMt3K7EvSYYRUuZFSKDQj5DQ1JZ9fOpl4quBitrBYe5FoH2JOULcjxh2FGvvk3gW5Uh2zBNXHYGrqfiT6CNxcjregCuTWuPn0xj1pXrfQsfZJ7iRNXorpvyUZ7Yf0n8FBuMYa3FXOO9++9B2X6u3Du8rxOyKR23WlkWEpHn+b42hIGrDlYvRRxPB+8DIM7IWAQ1VefyDs295z1pVZPClep6d4pl/mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGw0CXJ9BDGQ7syo4Dm885h4p4PA/iXL9wBBQv96UI4=;
 b=1FCUkhkS02lS9KkiHklbWVTnwXnUC/fs2/Ebs+0XEYs502nuxCj+7WvXizUk9xC2xj6Yi+yi0p7HqhQdwQAsIyn0alYDCLbK43DATK15R9oT3V2Q9x+pmbVpazlN2EVmuqZ1q1f692c4UFXeKKDaffctSzw9O8z+kRN732EpSGA=
Received: from CYXPR02CA0044.namprd02.prod.outlook.com (2603:10b6:930:cc::12)
 by IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:53:18 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::d0) by CYXPR02CA0044.outlook.office365.com
 (2603:10b6:930:cc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:53:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:53:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/9] drm/amdgpu/discovery: add VCN 4.0.5 Support
Date: Thu, 24 Aug 2023 17:52:59 -0400
Message-ID: <20230824215301.2739707-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215301.2739707-1-alexander.deucher@amd.com>
References: <20230824215301.2739707-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b5679c-44c9-4773-d3e7-08dba4ec8698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B61jg+ISI/vQfgypvz0JlRtfNyGBqUHZBSf+tYiB3sEAZyPBY4gkfLQP6kVJ0pb31PmTJzGpy+B1y0yH3P0qYWos3KNRkTOL21Ho3GcdirzCBtaQC76HEReE+kVcm/CItXK1F59v3YcgP02wS7gD9TPhmElyxs4IT8cf0ZmRjXrkG8Zzo7fOiYHkSZW+2y73I4N+fMLbw330mw5HpIdNNZYSHHTnc60lrVIxYakXCEefKf/PXZOzfcN+yNRfhlBKdyNksk2D2ce5kqYLVfmybu4HAvRgQWD1P4FKLBM8PYUtMBjoY0tpCFkqwkusQS06nTw6v0iiwzikS/ID5jBXx7enae8Ar1uu4Nz5j+hPh3Cy7XRULfWLk5XSaFvcjLjLBWryx3V5HLfVg+ww127ZGcJkWB24AM5zIFGhs7645+cJdTX6vmOPq+pjOvfFNt+8r2szZ57zRosuVicoNLoej3FOjGjxLk0L7lHXmZwYB+ok6iZ6hvVmYxYZYkHsuXAa3g5RClDL49t/yiHIlUF1VJN5q9xFy+ZLLjE0mZDtLQRm6bf4Mm9B10+9ekJuzCB4wZjCuzPrFNYWQhCcGEXgr8i8HFb7KStqi88t4u7BnHya2SaYKMmkyKzrz6h+1fto6z3BJbgfZWQ6HIyjMy3fP5Q+owW8xk1nSk3VsObluGIuRdhYX7gbg+kddwsv5rPp8fqOExlbEhpUoWpz3jzX6HRX1e4jky4fdapsToQXPKHvq1Om6yh3LHeSa8ET7ikZopj3rWc8zXOVQWDkACPBew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(186009)(451199024)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(40460700003)(336012)(426003)(26005)(16526019)(83380400001)(2616005)(1076003)(47076005)(36860700001)(41300700001)(70586007)(54906003)(2906002)(6916009)(316002)(5660300002)(4326008)(70206006)(8936002)(8676002)(478600001)(6666004)(7696005)(40480700001)(86362001)(81166007)(356005)(82740400003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:53:17.9363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b5679c-44c9-4773-d3e7-08dba4ec8698
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

Enable VCN 4.0.5 on gc 11_5_0.

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ed68ed9b9e72..0bf3bf94955c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -81,6 +81,8 @@
 #include "jpeg_v4_0.h"
 #include "vcn_v4_0_3.h"
 #include "jpeg_v4_0_3.h"
+#include "vcn_v4_0_5.h"
+#include "jpeg_v4_0_5.h"
 #include "amdgpu_vkms.h"
 #include "mes_v10_1.h"
 #include "mes_v11_0.h"
@@ -2081,6 +2083,10 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &vcn_v4_0_3_ip_block);
 			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_3_ip_block);
 			break;
+		case IP_VERSION(4, 0, 5):
+			amdgpu_device_ip_block_add(adev, &vcn_v4_0_5_ip_block);
+			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_5_ip_block);
+			break;
 		default:
 			dev_err(adev->dev,
 				"Failed to add vcn/jpeg ip block(UVD_HWIP:0x%x)\n",
-- 
2.41.0

