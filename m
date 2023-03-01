Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25D5C7EE30
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Mar 2023 21:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2C410E344;
	Wed,  1 Mar 2023 21:23:19 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4556210E344
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Mar 2023 21:23:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6sCqWReU3BlOfiZT41vA/4Me582b04y2/+yettMJgkc3h368i/EhR03kfoH5Mhw+G+6qIsuNruovonPru5bzh7dp4nc0rEYj1ZagzTvOFe2WEC5YHB6T9AsxX1I/g7VivrqCI8XS3l6O9nbUepsyBMFP+g/+X/TakeljO9hPu+eLY0emRXS5MLDHr5rMTo7VZZWIguZd1nq4ohh2fkbSdC+6cILazZhz9nE1hHZPu2/qHe0mvkx0CKE3FPLgWrEhEgzPL3HGMP5YG0VOn7+Vc0LQ+dzUZHSSDCT4rwGElBYFe3U66IrYMH+bwzeX/2sZabJRRvz5v4Q45NUz8Y8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ/f4b3NNg10XVo0OaOb6S2j6JDjSg94Hbrxy3uzvuY=;
 b=JbG+no3lkoH4EEu7aHZRp/kPm2lzZVegYCtaA+k1yimWNK8aO42YvigeBEJ4b+qynPJT7v+mHw73C0IwohxiSQkvpzAVnHKJEjz/+chEHKrDjGQ86a/3rkrP5hghhGxZRAY5t02gmhZtGPetckqd9dTlPzjLk3f3XS55xGdaW6hGZU14ADhvCBfLrz3PmeudjxLnCi3gBHYl6FTN8u1aFIb0czOuZ37HeB4HG80WxZsLipXox/2p5bjP01B3hWO3pzT2V3cvoTepjIyvYjQdJpp2jGOBt2JKyknwEriJpD/XVa2j1k8HMFrvXaIstHwHBcwuWL+2In3tdfyN5hkVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ/f4b3NNg10XVo0OaOb6S2j6JDjSg94Hbrxy3uzvuY=;
 b=ygqL6qjThsKq73ASFVHHfhDwPSItDrD04be0MnfRbbT44bm5sahRk9WIURNJVE3N7Z0Z8adzofgsa0N70AtfUmtTy0ihusxA7ttoIORd49ze456bIzKuHUDpZKQFE+gcziL8B/NSDIQZ7U/inKxHef8AkUl2bD1MhpIZnh2iFrA=
Received: from MN2PR08CA0011.namprd08.prod.outlook.com (2603:10b6:208:239::16)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 21:23:14 +0000
Received: from BL02EPF0000EE3C.namprd05.prod.outlook.com
 (2603:10b6:208:239:cafe::7e) by MN2PR08CA0011.outlook.office365.com
 (2603:10b6:208:239::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 21:23:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3C.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.16 via Frontend Transport; Wed, 1 Mar 2023 21:23:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 15:23:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: set sdma v4_4_2 ip block
Date: Wed, 1 Mar 2023 16:22:39 -0500
Message-ID: <20230301212239.2098980-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301212239.2098980-1-alexander.deucher@amd.com>
References: <20230301212239.2098980-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3C:EE_|DM6PR12MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a275547-3cf9-4f14-b726-08db1a9b2ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djreA6yyZYX+l0O6avfYQ82kkpcJBBK4gB/e5v5HFbT0MImbuOFPMJIlPInOFCqAQvxZEEZkyxoKj3TcSZpW3k2+IihzY65Nr9x7e34WEt1jbwdau7f0opYRS7Rg3lNfNA84f5jGD9PBsZd5plHm7l8Eo8R6c7SBDB3vQD5Up26Q2ZniMt4AJRyz9ojK3R739sDjk7HSGY18wU3Y5AFDgFUUs2GwcYJm7+kKEUGM2gAg6P4ct/MGAky5+nSCQKHWL3LTlYifgkicrsPT+6sDisva2oH7s9TgMB5AffDNdfuJv8aVK+J9rV2sH0cI/yIAFQyhXWvZsHQmaF+UoHwjXJRPIs5sD9fKpFXG4R2pPg7E88TRXwQg/Wfv4kwrb4P2UbusG6M0oIYkQdme9wDPkfZOtAuMEC6Nqy7sekNIZoDLfYz9T0VyM4ak0l9kQjD46TSk8dEf9AzcYNzw1orhbuYRwtC/qyY41q0/EfIOL52J0pzOWczMrOB65Eg2nsItsdv61gKAuJSDU0hNxP8q7D1KztycFVHr2fqdlqdiBq/j3APbWG98wINaAdG+8VceF1GjX9AkqPbqF7Zd3cW+eP2kplVRxCL1NUUkOzUCo9CTU5ln5bq3U9ngyf/LTg6a/IGaDh+CGrW9ZGR+CHXM2QTaz56Qo1lSz0SOJa2+0rOcndHY0kNZ7Rh9+UHJewu3jHdrxHLfdt0Tko58d0MtexZUqcKRVJISnyDQ0XkutCQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199018)(36840700001)(46966006)(40470700004)(36860700001)(82740400003)(81166007)(356005)(86362001)(36756003)(2906002)(70206006)(6916009)(8676002)(5660300002)(40480700001)(41300700001)(8936002)(4326008)(82310400005)(70586007)(40460700003)(1076003)(2616005)(336012)(83380400001)(16526019)(26005)(186003)(47076005)(426003)(478600001)(316002)(54906003)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 21:23:14.4080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a275547-3cf9-4f14-b726-08db1a9b2ade
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Use sdma 4.4.2 IP block for chips with sdma 4.4.2 hardware.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 8b3ebb7d482b..c8507731ce7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -41,6 +41,7 @@
 #include "vega10_ih.h"
 #include "vega20_ih.h"
 #include "sdma_v4_0.h"
+#include "sdma_v4_4_2.h"
 #include "uvd_v7_0.h"
 #include "vce_v4_0.h"
 #include "vcn_v1_0.h"
@@ -1835,6 +1836,9 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(4, 4, 0):
 		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
 		break;
+	case IP_VERSION(4, 4, 2):
+		amdgpu_device_ip_block_add(adev, &sdma_v4_4_2_ip_block);
+		break;
 	case IP_VERSION(5, 0, 0):
 	case IP_VERSION(5, 0, 1):
 	case IP_VERSION(5, 0, 2):
-- 
2.39.2

