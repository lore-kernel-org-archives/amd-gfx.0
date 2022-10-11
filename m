Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24310C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 20:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 416EE10E4E4;
	Tue, 11 Oct 2022 20:56:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E12810E4E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 20:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lF//H6BPiueFxTK3/6hTpH3e/QZ0wYFDwlCrG6jIKka9/ZIS26y5iCahfRET0qbSEC4ebu5zfG3xeJS/EPDLI3cf6PHzXuaNC+WBQVpj0VPLYnsEJhQ/nOQtCkbpCl8btgN1ZxlojXickdtShq61cB84nyopbHBVIFMdAWU+hRAw41yBF94RJE3rVU0EbGwJ9qFfn8lz0lsbAYweqYtr5N90U2jSjj4dyC0oldlxua5akPZMCWPQjHOKxbbSQ1bCieFiPkzSkT0H0m9x6TX1Hbot9h7qSbJeooh4RiVHTDwgNrUyI9czYaTzSzqfF5qhveOPjvnkbE2rn0JjKrxzow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcXSfhW2JKxD9P0CWd+evs7hl5N3ivvhREx6ciSthHg=;
 b=N22/ytIrdt/saDCoGlgiSMqyhHrblGALE0eHPYadZFD8LN81YsuFvtjzDslaQuMQAbxPx5pZI6aqKZQamB1pMKPBNU/UZFIPON3XZyyv9538YhGHQGM5mIeGY1PJFk10RpR98FyzMzECZ0SL/ZgazET0E65Zeesii4F1TiBNGUHr1tFpsb/ZIHXcKc+4M7GFlX/zV0BA4nrJMX3kyIXErlFcPueTDd0F1aiTaE/DU3L0AV7B9xZelcclkyY2hgi1ZdLtUoN8efad+id2kObsz8XAT1yMEltme6e9avLxUADFK6CYI5pToZVyHp0uB1KOR0ISq37+0Ft6m4XiOOyAFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcXSfhW2JKxD9P0CWd+evs7hl5N3ivvhREx6ciSthHg=;
 b=3nkFQKQOOhDb4hs6u4aLRcOh/Q2yDvnVQ4H1y/FAr2ln04FOP4MTGzHhjQp25Ya/6bOmFGMdZOjs/OsijGb3Yh5a8Pg+hf8R9OzeDLTgkc59slF3LiC/aLOT61MoKkQDNu1u4sQTN8u5XaIMWHvUI7SPQ0LLLVMhsp0BuBvoHUU=
Received: from BN9P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::10)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Tue, 11 Oct
 2022 20:56:25 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::a5) by BN9P223CA0005.outlook.office365.com
 (2603:10b6:408:10b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.20 via Frontend
 Transport; Tue, 11 Oct 2022 20:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 11 Oct 2022 20:56:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 15:56:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: extend HWIP_MAX_INSTANCE to 28
Date: Tue, 11 Oct 2022 16:56:03 -0400
Message-ID: <20221011205606.2540082-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 1837f5bf-3e72-4a47-e374-08daabcb0f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uT7HVQ83t8V5NHVGlOfB2lOi8NPdUnWnjPljj5xeOv3eP4Igo+NaIinvDSFBawJQiD6vy3Bq2MnS3R7VKxli9nIaAAqE8ep+YaX1L7RoKyeiE+QZ7OLd+JRN/RXPyV9fOGi4L8c3bxikjPiPG2ClYbEpSbf9r0nIwJZyCvg5GqUiz4aun3loq96VZH9EqwpSIDZpgQGVAGjPExXghi8jQ/o7A+TfDpxJoPeDQXIpP+ToelERqPb2ZfBWptKYTIZOLpoc2bM+ZxIBx7W1u3UJHFeJFSuZkb4A9gYnxB09rXgO1cDLJfRw2hAXKcQ32xnlnr4lXh9NNx9hCOwQvoCFzn5sh5RYGM+cteVZZKuyRIlE7xShh2N1KuDjfuHNSy3Ibkcw7rWd6ibmAyprjUbIT1TkxjZduEBlGx1WiPoZUmgIKMBEETFx/8e1MjJKucaoKRkczE+kf+UvZGPtkOQNWOjSnChfnwqypBgs/wNKnXzLsOAdwESRkaBm/6aOgRKCvUmVroZI1718TjLwiCbAu/ZyUUJN5XYLfjdum7Zx8LnbAQjjddcgFyPqTHZFpnaJfiwXvxPDnUEsQaQ5sWoPsAZGwKPbybsE6QBpadziyUgdvM278m4hQ0Rw9GUjaJSKUeHStUGmMMJX59k/lUr5jRSvqYFk+yb1usFyhReZeIqsEuCx1dGfC6PtlxomeHRvwScA3fGd3cKjH0NI9prIGnn1bdRms5wxaEXy7zI6nNCXBMfF9IwtQVqqM1jjwfSkb3ua5xOL/pLZ+UXdpBW9zLDvm+MT+DQqdp3ebvkLJapEr8m1KswFLpApYpL1cX8s
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(47076005)(186003)(8676002)(356005)(336012)(16526019)(70586007)(36756003)(2616005)(426003)(1076003)(5660300002)(7696005)(40480700001)(40460700003)(316002)(26005)(54906003)(6916009)(478600001)(36860700001)(82740400003)(6666004)(82310400005)(2906002)(8936002)(41300700001)(81166007)(4326008)(70206006)(4744005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 20:56:25.0203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1837f5bf-3e72-4a47-e374-08daabcb0f5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

more ip instances are available

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ae9371b172e3..3ce91f660c3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -678,7 +678,7 @@ enum amd_hw_ip_block_type {
 	MAX_HWIP
 };
 
-#define HWIP_MAX_INSTANCE	11
+#define HWIP_MAX_INSTANCE	28
 
 #define HW_ID_MAX		300
 #define IP_VERSION(mj, mn, rv) (((mj) << 16) | ((mn) << 8) | (rv))
-- 
2.37.3

