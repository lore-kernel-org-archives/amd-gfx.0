Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87087C6FA8F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2244F10E142;
	Thu, 24 Aug 2023 21:31:50 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F3F510E140
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jD7k0YO/pYmyTI96GnAuTBs7TwwVCno63RwF09TBtkZw7R4DYoAr0yJTkKFktTI+n/YRQGGzk969DZtYh9xGfDWDJl1mX8ArFoi68/k+apO+AWHWRfaJM1qydTPz4ziw1wwihaWUepHH5bHITM9FqBuv+4PBNsmjIPFvVX64rS0bOgKueZOSynu80vPM4970Ggm1k8LS4rlYA0e5BOewLIFe5IE29bLZfA2PHBace3xURb/FkTbDZftRNWOrp+bvWHH9fpUg7wKKZNRmswX7WeqlMp6oUcGC4pkMUfwVO8zEOJmFhBwZ7sZZ4oWADSAYQCWBda8osEK6cBtM+UlK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OaSNZi4gv73QREyNXfEz/tToI2V0qGjx/RlBt0vgxA=;
 b=K/RTHoAIotQYvZpVRrUipE7zkA8jDMwEzB1uT5CqHPhhqRxH2XCJ5KU9sQswX7AfUZa0CZkbDXCMN2qBkl3btaX/LyPkNsSY59Qwol5iwTqCpdTcf5R21ClAn9gkYnFCsxURj+ZI2P41Y7xzgvozs1XNzpOm/1R+wF2Vq7MjL3JNpd5h/0UJ9QpqyBQseNBkltnVU9NVm3rUKomOqD7i8Cg8T0GfFSDdXhqugPT/wsEHdit38OCo7rHj0fGFkoxiT42yHh3udjJH5jyWZd8wpehKShBF594ZZng8ZMezQfLOi6906Wgfu6ofOgjuxdagR/ePz4qVZ6ZCrXx1yuqDWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OaSNZi4gv73QREyNXfEz/tToI2V0qGjx/RlBt0vgxA=;
 b=MJsxfZzDWvhBk9ahBT14bJA2ZqAwS7yOeMglqCxumdj7Fvo6/jeJeoJNdq3CDItO850lLg6j/8sQHiLfRGX1dySOLj/Itqak5sN1F5LTCrYSVyvFvPjP9pxY3/s77CB5a/2SZiJ/M3IvEBNkDSVq8kmb7q7Xkf+aD+pkKgfYEEs=
Received: from SJ0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::23)
 by IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:31:44 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::cd) by SJ0P220CA0016.outlook.office365.com
 (2603:10b6:a03:41b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/21] drm/amdgpu: add VPE HW IP definition
Date: Thu, 24 Aug 2023 17:31:08 -0400
Message-ID: <20230824213127.2725850-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824213127.2725850-1-alexander.deucher@amd.com>
References: <20230824213127.2725850-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|IA0PR12MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: a933add0-f8a0-41cd-306c-08dba4e98398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gu8WyR3CVrEIS7Yp4qvpsbyIq++58bGeCkMKvZONrn++wovvMtkc8in+Pk143lfXKZSwis963VKmeOPtLe4b8hB/saSolP2TC/tnob/3UeU/wDL9cCt0KWIR9rkBxzUbJxy+i/qooZb5Znb7Sym4Ef6XY4WNO7EvrEZs4VVgndb0s8vT+eDTa/LObUUESWW+Zaz8Nz3jCec+EHEtFaTHogaxr+O7S0BvX1alVvRRID42T4tOnzPuZv5l7XmZvAYB/EMfPqFWbT2s3pDSPCUzt/2H+z22C7v3WXvIHctayHooNAQwQfnhmALymdGMtiNVvhy5xasFuhaVmSsgqJsfb/qBnKZ8ncf4Xrhj2Cw1OT9nK/7iUtAM3Sa4xXpYf6AB4mY8txMzVRms9ZJQF8G7Xl1/QAHIcBl68KLKQoG8hsH11ZaxZSfnjrr+NjBIaIBA8E5qRxWH5ZiEeTXfzkoXOhnFpYMHyuKOZqao98zSznbO/+UF6CmRmvXUC+HglJVIowAZlhf5tsntSF68lF1bSTSzelfVyHpQYiSuLp8fgCiYJVgBcSd62vQVRA3Wp6oTMvsBcZoxIaH2DumJoMH0QqMISs5LKMw3uY9qUtEegBii+q9PxBq1aIBdiVKHLb/z7XwPjm3hGSnXUYdKATN5P2oSYZ/hV+NmtMRmqV6QeluuoBf9RvPJrkICvY6f6DGUawJzvhvPzKRY9Feqc2o2s+HtuXTovI2WQJLYeSwLQ814781sAQjuvSSD3IKr1bxdes/FVlW7cIzFvzbLzcy8IA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(54906003)(70206006)(70586007)(316002)(6916009)(81166007)(478600001)(40480700001)(16526019)(26005)(6666004)(82740400003)(41300700001)(7696005)(86362001)(2906002)(356005)(4744005)(4326008)(8676002)(8936002)(83380400001)(2616005)(40460700003)(5660300002)(47076005)(1076003)(426003)(336012)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:44.3619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a933add0-f8a0-41cd-306c-08dba4e98398
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Add HW IP for Video Processing Engine
to support user space CS.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 5f5ffdac1556..6289b2575464 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -586,7 +586,8 @@ struct drm_amdgpu_gem_va {
  */
 #define AMDGPU_HW_IP_VCN_ENC      7
 #define AMDGPU_HW_IP_VCN_JPEG     8
-#define AMDGPU_HW_IP_NUM          9
+#define AMDGPU_HW_IP_VPE          9
+#define AMDGPU_HW_IP_NUM          10
 
 #define AMDGPU_HW_IP_INSTANCE_MAX_COUNT 1
 
-- 
2.41.0

