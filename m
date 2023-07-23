Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BC1C001B0
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jul 2023 09:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A75D110E189;
	Sun, 23 Jul 2023 09:49:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40FE410E189
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jul 2023 09:49:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1y/sj3s2JM6fzynvSgzEx9ax69p/dFxPHyR5MNrb/kpMYW5ZX5eQ1U+0u+i24y3OR17sYmGCa2a0fOVKRgbYT77Wn+erObbimC3lk96r5A+WUWmXN1/wZmwdPUzpd8I7x6bCJTpD2eIBE59WAWqDGs2m+md0Qoz694QtZUIa0dK98RHGxb3FeBzzL3EtRDUV2pqLbJt6vnuS9G8hrzFZjc5d6G53W8djlPgXpyClwMzpaz/5hQm5AulPsg6Zm3LshoweiVxYAhHyx36M1mRSC2Yo9Q9EhezcwLsx5Ae8MZe/i9m5SbYr+hk/f7SQxK4wknec/B4RzN1FEi24/1C9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48UJgiEAnkPLHlCEh/m1nVsjJOXYVnMl2Nm+ou4mZVs=;
 b=GLQUGHh8vBsIUzntBE3jhwhhhVnPp6cbDiYxuYtkdI/GJEawSESGi3hq37Nfs+XLjcjqU/5fexGIWarGDZGR3vCilKb6Z32+EtV6JAzlhgXqJOQzN/BTMHQiAF19R13EyZMQKHcyPuKkKRJmwBe7EH6HhcwOsUaamUUw8FHthyzUhPyPSPru2CGvwmBE1r78j4N45+B5Z43SaRX3W88tfk+xkLg3Ib/ljPeKKh9thjxhEpFaNJowXaV02+LRi5vk4jCPQIsywqd58p8OcfNMHKQtykovGTQyjD9HgK2OxAmnI86EtiYK3Oz04AEaUMw23G2wRp+QD6lLzzEzJ5PIZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48UJgiEAnkPLHlCEh/m1nVsjJOXYVnMl2Nm+ou4mZVs=;
 b=t8/LXPwMWPNcW/iG9yM2ZWr+oaU5YIBjsuSVXIkdpZ2EtmtCf1a06fmzvfNGmAoAuPsdHSXmdQ2w6aWFg143EpuaPDh+UMYLm0QL58zVg3g1/IugbwbR2kYqSx7b+i5q5Z59tPqUA4yMaslGp2wDRX0Q2lPGJvwamauC5lNFt2k=
Received: from SJ0PR03CA0131.namprd03.prod.outlook.com (2603:10b6:a03:33c::16)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 09:49:47 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33c:cafe::13) by SJ0PR03CA0131.outlook.office365.com
 (2603:10b6:a03:33c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.26 via Frontend
 Transport; Sun, 23 Jul 2023 09:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Sun, 23 Jul 2023 09:49:45 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 23 Jul
 2023 04:49:43 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add -ENOMEM error handling when there is no memory
Date: Sun, 23 Jul 2023 15:19:21 +0530
Message-ID: <20230723094921.2054552-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bbb3de3-262a-4515-ca35-08db8b62259e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qWtveaHZWByX94pBUsiLkspXpSDMaWsQ3B5mFXR2uLsgCxzOHlqahFTu3diWPSx9F8Nmj8IIWBEIfWbl6jDXGBza5+ItcazMgIP4Q7fdyCG6Pfbx0rSM90J2U0KrIYm7Q5wuIQGzsi0oVOGDclOgeRLwDUWUDkOZZXwZ6CIGDEu6Db8NRNpuHVhb3vB3EP3OfMmxFSLHBoufJHGpkzDuJVcwGV2sHn+TY1rvc+oMARZLEElCmmIEKmVfy+UaB0EACAuouqyXIb1ZHa3OsifDj1vY3qZK+Uj/yli/H/Pm/6sTz5WiCYk3GPyYynQuweVYyJQZTTe2lmYNh75eJUv24W79lvfGpTn5hsYDjKIAYwn4FySpzryhEgILNENjpcCxHcIlHLE/zgTjbOcCjT4kunvlRifvY1pFxw/qAQ681ZfNcxF9M7x3ON2PepEDhMiFWTdAmRCRHKq5E+qypkXQ4yv7ieLk7fICOGjZvOwUTFbK6zoy7Zy+Yo1NeKVfHbcjxVHvWb022jVxi8nSpmnTVa6E24dQeEz7Yruw2a1F6zh4J3RDCQPPVKIaa54m8imY+WLYIPJR2oA9lAcbZJNgCuX230noKm5buAZi9xpVp74E83CeFNEf5l/UI2RhT2syCjhbRJB9Hiz+dt5WWgqs4wniwo6I4U9nAyuRL5yf2aZG8qjstek1lxAWA0uw9V48ffhsdhHJzUlotDdpLrQaF8WiHui17aKc1ogDy4AYGeEpFsoQTgUBUIj1uRPQ+dCkxiv+nKQxAM0WTpRdFeNlxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(82740400003)(47076005)(336012)(186003)(86362001)(16526019)(1076003)(26005)(83380400001)(2616005)(426003)(81166007)(356005)(36860700001)(7696005)(6666004)(70586007)(70206006)(4326008)(6636002)(316002)(40460700003)(54906003)(41300700001)(5660300002)(110136005)(478600001)(44832011)(8676002)(8936002)(40480700001)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 09:49:45.6491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbb3de3-262a-4515-ca35-08db8b62259e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Return -ENOMEM, when there is no sufficient dynamically allocated memory

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   | 4 +++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 03dc59cbe8aa..7e91b24784e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -500,6 +500,7 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 	hive = kzalloc(sizeof(*hive), GFP_KERNEL);
 	if (!hive) {
 		dev_err(adev->dev, "XGMI: allocation failed\n");
+		ret = -ENOMEM;
 		hive = NULL;
 		goto pro_end;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 36a123e6c8ee..eb06d749876f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -909,10 +909,12 @@ static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev,
 
 	/* prepare MQD backup */
 	adev->mes.mqd_backup[pipe] = kmalloc(mqd_size, GFP_KERNEL);
-	if (!adev->mes.mqd_backup[pipe])
+	if (!adev->mes.mqd_backup[pipe]) {
 		dev_warn(adev->dev,
 			 "no memory to create MQD backup for ring %s\n",
 			 ring->name);
+		return -ENOMEM;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 8e67e965f7ea..c8be534cc60d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1021,10 +1021,12 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
 
 	/* prepare MQD backup */
 	adev->mes.mqd_backup[pipe] = kmalloc(mqd_size, GFP_KERNEL);
-	if (!adev->mes.mqd_backup[pipe])
+	if (!adev->mes.mqd_backup[pipe]) {
 		dev_warn(adev->dev,
 			 "no memory to create MQD backup for ring %s\n",
 			 ring->name);
+		return -ENOMEM;
+	}
 
 	return 0;
 }
-- 
2.25.1

