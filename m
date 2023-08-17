Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B5BC05052
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 03:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94EEF10E3E3;
	Thu, 17 Aug 2023 03:33:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A16A10E3E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 03:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4nvLFKJgXDVY/8OKAL7g428dmgCBN3ZLBRAis8N1Xmyv2bBcQs4FjbXDFnGhipoSaMFHbuH0DDXZgMQcr26/A/DvxzguyCEvVfnFjAQEkhw/cj7GgBeM1ll2EdD7WDu3Ou8Z0mvezClBMgKqD8R3igdwggdt9bTDjBCe/HRliCEluFdv2zhwR0WJhMnGSJhCO63T1nLLMCwd8tkVoqNgEViVK7XlOuS+x5kNSpNry+3N/vwWBY3kTT+NgjlkIBd3atQfHFEeYx/xec32RVv12u7ui+PBvkIv3C33sCG1f7n9TBW/cq4ap1r0OrZG10ioWmF9I+piT74HLUuLng/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/M2IdOycobpwfe9pRBAolwuhwCvGD2DBTqTt/Ii3eg=;
 b=fv50XIeDe1y2ECfaOwLHyrWqGxd9gNbMmLysud7YcBY0D8rRl/aRRibBqXi24mNrb37L5DNU8Rf4wxRgHM5OBkVX+mNXiAG5mohVQFy/5I8Zr+/upSg31QzRRJEse0D183LXY5oC4jnZgn/udh5M6EoMUQbgzbsiWqitQLL9TFx6UsHxX0UzwIH19e480dEqepSZ5yqr2Uzf7e82hC+a0QdWVpHQR/sO1JXub3WKBY7kM1iT0y+PN3E2ZDDOBUUFWGdW6qhOBrkej2q8XG/bK9+t1iAyka9h2o9EwKcm0ZmvPXf0K37YD6zqPsbib5GuwDo2gyh3eR8/jJ94UF2ccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/M2IdOycobpwfe9pRBAolwuhwCvGD2DBTqTt/Ii3eg=;
 b=LzdZYv73F88zsNbYv2282ZfqdVDpfkLKTfN2CNDyMR0PTdziNGCQkQaKcL8uK5NmcFPG7De+bEcH1B3xIh4MrD4NVUumc8FeI8DkAKPhNjB72IxCDUoP803CLURN6NaIjHsdZ6F1eKTJwDijTPWLOso4kpcB7cZoli5/OAzNHZU=
Received: from SA0PR11CA0068.namprd11.prod.outlook.com (2603:10b6:806:d2::13)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 03:33:18 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::71) by SA0PR11CA0068.outlook.office365.com
 (2603:10b6:806:d2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Thu, 17 Aug 2023 03:33:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 03:33:17 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 22:33:16 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: update mall info v2 from discovery
Date: Thu, 17 Aug 2023 11:32:53 +0800
Message-ID: <20230817033254.26780-1-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae46ea4-c822-4073-caf2-08db9ed2b26b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dGEWUqlYbFmwQh09VZ8la7i/ouEvIvcjCwOUVgn4fJJsX0fkQoeNT4X37ve6Ju3KGRpkvghJFuGRyb8lvItV8T7AcLKU04MW4n8nMlSmgElGlk9mdgtJJwP7VOPBdYWNallj0E4cnIBuYeMTR/Yf5uZA5Uzp2yge0G78k144GpJBEAedEULGUQD+yAjAI0FchERI0Uk85v7wvt5tGwuOp6QuDp3+oRveYVqq0RtM6N7pGw55iwPUlEX8TuvBEakk6Ke4cXbVxPN0PNwadBNV2n7J5mxlE4NxjJQTjEreMSTPy7sXn52H1TdZU+RgTkwBH7R0UdftMUn9lQQvj/BNPxy6xAy5N3enDYguRIpZu8T6Xhb0cQ3xndTZY6JmtWne2cYVUI/QOB4MAGZOy0BpXp8kebpwSc1kzJPVHS9WkShO9YOxQX4r8N3N1Gla+VlKSATBueuXM5rNj+p1/xMRn8BnrWqV2xw2rSuya6jsWWaTM9axNJKcLZZ4sjcJgFVZGNCXfRT1d9BbKtG/xVur3dmASA32VvDd8vqbeCUf8eAx75/9D7riw+gs+41xbaOSlVXaDPfWYizxX7wpYYq8NrlSBpCTFq43YRMLzsNcpxZoN2H+dG4ZCb/9pnpppnylTLH4iZOO9PJxAOXYtsvERdufiQ4X3fRP74h4EvgdJ8r92+P5TwinlPEtlp4vfHRjUoS0tdL/8WtB5JFOYBGS1dIMqwo0PLKGfWlwB++qOG+7WojhuVUtrLPVAo/2hkIRW4O5sLTr4rxFHTOy+uZrUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(316002)(356005)(82740400003)(6916009)(81166007)(70586007)(70206006)(5660300002)(41300700001)(36860700001)(44832011)(47076005)(4326008)(8936002)(8676002)(26005)(2906002)(40460700003)(83380400001)(16526019)(40480700001)(426003)(336012)(478600001)(86362001)(7696005)(36756003)(6666004)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 03:33:17.6317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae46ea4-c822-4073-caf2-08db9ed2b26b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
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
Cc: Shiwu Zhang <shiwu.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mall info v2 is introduced in ip discovery

Change-Id: Ia2e49e7679c578065f85059a077fc08c9f84615c
Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++++
 drivers/gpu/drm/amd/include/discovery.h       | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9d8d08daca57..f4cd43ce251b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1478,6 +1478,7 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 
 union mall_info {
 	struct mall_info_v1_0 v1;
+	struct mall_info_v2_0 v2;
 };
 
 static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
@@ -1518,6 +1519,10 @@ static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
 		adev->gmc.mall_size = mall_size;
 		adev->gmc.m_half_use = half_use;
 		break;
+	case 2:
+		mall_size_per_umc = le32_to_cpu(mall_info->v2.mall_size_per_umc);
+		adev->gmc.mall_size = mall_size_per_umc * adev->gmc.num_umc;
+		break;
 	default:
 		dev_err(adev->dev,
 			"Unhandled MALL info table %d.%d\n",
diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
index f43e29722ef7..b9884e576f98 100644
--- a/drivers/gpu/drm/amd/include/discovery.h
+++ b/drivers/gpu/drm/amd/include/discovery.h
@@ -30,7 +30,7 @@
 #define GC_TABLE_ID                     0x4347
 #define HARVEST_TABLE_SIGNATURE         0x56524148
 #define VCN_INFO_TABLE_ID               0x004E4356
-#define MALL_INFO_TABLE_ID              0x4D414C4C
+#define MALL_INFO_TABLE_ID              0x4C4C414D
 
 typedef enum
 {
@@ -312,6 +312,12 @@ struct mall_info_v1_0 {
 	uint32_t reserved[5];
 };
 
+struct mall_info_v2_0 {
+	struct mall_info_header header;
+	uint32_t mall_size_per_umc;
+	uint32_t reserved[8];
+};
+
 #define VCN_INFO_TABLE_MAX_NUM_INSTANCES 4
 
 struct vcn_info_header {
-- 
2.38.1

