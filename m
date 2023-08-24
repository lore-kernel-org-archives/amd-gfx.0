Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6525BC7EE43
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B20510E5D0;
	Thu, 24 Aug 2023 21:32:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1443110E5BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9NbaRI4ugjkzSYVWljfjfgC27Q6+uVFp83Fzvh8R3OxaY8QJzPzXSbPiWieGd+/n5W8usWZ01bamszP8h/FKpUb0ympHssXeyvNMXZq5ezYbxiqManVArt9tmMFEYAwlQ1RW55iX4QbNXtaTTD6KEx+Od4E4A/80GGTp3BYJYF1O3VbT6r6MO+p38t6HvDEuzRsnCSqZIcJpmApGzHFFODA0cVQi8LJvFToM/4J6xpXTb3zyicuifUQMA1gBCC0EThfpEQdPsfMrJgBkFcSK/Gq+yINexPBqd//uqm8OexhsldnnN3bEP/nrNd54a30jaAzPEMjzlLzsZSCch713w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg9ygpPyj725nPQSWGLv4Q4EP9jT/g+i2JjC/S3afS8=;
 b=Pl4dKJNEKCbVXu6NClSCFTodTD9ASv5glk8rJrAd7Ip/FUVy7rKMurvJ7Ul6oxafe7TvT9YwrvxWJT3YZ3Gqw7HNvwceP6KLCzyvQ5+KIt8QDz34UeFxZItnDi3eVmZhCJpcMKL5FpxJlEqljkv4x8m9gESRBoXRdLbM/elGa7136YbVUNIRImm/g8cDSFjqd2vNqP92OCScKzaztEnSxTkWm0kk4uzpWOW7D/jzNensh3Y90EAXrL0of0j+DwQgXmuil00jdSq1pgYf91kxRFdvIY1h1/51fETLjk205hKhIBKSEWqvWUinxbzFFFqvymUdVtIfUWeFbAPsHabWIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg9ygpPyj725nPQSWGLv4Q4EP9jT/g+i2JjC/S3afS8=;
 b=w9itUb4KIFdlqkV35LZAUJPpR0Vot+ZaexXe9fbUxYPAQ8s6gSPFjC4DTcgvcGPE3+iw+70vWgGaDo5yhfdtiOCjXScOrrwQeo8pfCVECqwKtZs13JqJ2vlWu1Q6wT0ry1Q+LmZRl37puZwfTJXrVlI7VyWUQXdJP3gxAQuSIP0=
Received: from SJ0P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::26)
 by CH3PR12MB9169.namprd12.prod.outlook.com (2603:10b6:610:1a0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:31:52 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::b1) by SJ0P220CA0020.outlook.office365.com
 (2603:10b6:a03:41b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/21] drm/amdgpu: add doorbell index for VPE
Date: Thu, 24 Aug 2023 17:31:17 -0400
Message-ID: <20230824213127.2725850-11-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CH3PR12MB9169:EE_
X-MS-Office365-Filtering-Correlation-Id: 296bed98-ce4e-4e82-e9f6-08dba4e987ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPlXwn+A0itj4I1VXIsffSbtEVga6U2/hi47hOeh904IEjrv58m/NQ01WznKX7wHH0nAQOzcIcFhz7U02ntEJAVSvyhYIgM7gCPYH0DxJGmQTz7tEXkb26/0OiMBrmPYsM9RCX1+UUtqhqOqBxPZfDmrlBhOPmau5Ub/8B34/X5oGeRErZibjFYUS/vyLA18q1BlCLghFBJ2GkuFCk4nBW0vS8MMfp5CEeBqq8A97XkDpF+bEvukVRJYW69SBaUIoV7QCP0bw3eGDUKvxez293UfLaVcXjbd4l58NUcycZjIeamlJtI2zD4xTWbZvoqSC9qY3W35Y+QDSvBGlse7CedjmJBpkM2FklIc52RyCj7QdoAKImSCQtms9KkQs08AYYTod7iCPMQixSEcavP69V9COAGqbZRhnOoUzoOaMLF68WCK+r4en8mTYOiF9u/a5MueiOETJDOiTY7rkuYn9rDE0NZCZaoeCRPhDd1VMz0mVrW5NcQD8oV/LZAJWcoI8qSRpd4rufM07ggY9qrMyYTSVCiPYlK8eAV6BjxkCU7TqTE4YjEI6/epbiukdL75A+bQCcaZcjM5ill7tjVqURkZHBmfKO0zm1JRi7oT60Td9IlX14MPEm1f5TP28BzKep1Ol+MRjZt9Hhi9Dm8sD1Y29fsnkg7d1NnDCxiZ9MKoTrURJLsn2wUloLJlcK3e+Dcsbvdz6EIodvhQqovxfGhYj4GFwaK1QJutDeieerXyr9tvvVuhiPu24Z4ehYFGhnfG7fG6WxsxmRDBShrJDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(1076003)(40460700003)(2616005)(5660300002)(4326008)(8676002)(8936002)(336012)(47076005)(426003)(36756003)(83380400001)(7696005)(36860700001)(26005)(40480700001)(16526019)(82740400003)(356005)(6666004)(81166007)(70586007)(70206006)(54906003)(6916009)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:51.7525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 296bed98-ce4e-4e82-e9f6-08dba4e987ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9169
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add doorbell index for Video Processing Engine.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/soc21.c           | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 09f6727e7c73..b0edeedbc14f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -86,6 +86,7 @@ struct amdgpu_doorbell_index {
 			uint32_t vce_ring6_7;
 		} uvd_vce;
 	};
+	uint32_t vpe_ring;
 	uint32_t first_non_cp;
 	uint32_t last_non_cp;
 	uint32_t max_assignment;
@@ -226,10 +227,12 @@ enum AMDGPU_NAVI10_DOORBELL_ASSIGNMENT {
 	AMDGPU_NAVI10_DOORBELL64_VCNc_d			= 0x18E,
 	AMDGPU_NAVI10_DOORBELL64_VCNe_f			= 0x18F,
 
+	AMDGPU_NAVI10_DOORBELL64_VPE			= 0x190,
+
 	AMDGPU_NAVI10_DOORBELL64_FIRST_NON_CP		= AMDGPU_NAVI10_DOORBELL_sDMA_ENGINE0,
-	AMDGPU_NAVI10_DOORBELL64_LAST_NON_CP		= AMDGPU_NAVI10_DOORBELL64_VCNe_f,
+	AMDGPU_NAVI10_DOORBELL64_LAST_NON_CP		= AMDGPU_NAVI10_DOORBELL64_VPE,
 
-	AMDGPU_NAVI10_DOORBELL_MAX_ASSIGNMENT		= 0x18F,
+	AMDGPU_NAVI10_DOORBELL_MAX_ASSIGNMENT		= AMDGPU_NAVI10_DOORBELL64_VPE,
 	AMDGPU_NAVI10_DOORBELL_INVALID			= 0xFFFF
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index a920bcb9f5b3..cad57afa89e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -503,6 +503,7 @@ static void soc21_init_doorbell_index(struct amdgpu_device *adev)
 	adev->doorbell_index.vcn.vcn_ring2_3 = AMDGPU_NAVI10_DOORBELL64_VCN2_3;
 	adev->doorbell_index.vcn.vcn_ring4_5 = AMDGPU_NAVI10_DOORBELL64_VCN4_5;
 	adev->doorbell_index.vcn.vcn_ring6_7 = AMDGPU_NAVI10_DOORBELL64_VCN6_7;
+	adev->doorbell_index.vpe_ring = AMDGPU_NAVI10_DOORBELL64_VPE;
 	adev->doorbell_index.first_non_cp = AMDGPU_NAVI10_DOORBELL64_FIRST_NON_CP;
 	adev->doorbell_index.last_non_cp = AMDGPU_NAVI10_DOORBELL64_LAST_NON_CP;
 
-- 
2.41.0

