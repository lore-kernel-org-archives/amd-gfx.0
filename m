Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E83C7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E761E10E40E;
	Tue,  9 May 2023 22:11:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAB2710E411
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jt9L7DtNnighAGkjT67QtxN7un/TycS0bpuuRQlpn+uDuJfxGzboW5Esz1LwJ86hJTCyTumBUjwyDciv7nKShvmJdD19IOTmD43ZizH51xZ9/wp1f1dwNstmB34mdOAa+SZYfBhEnM/mJZUAZIiSVP6iLtyXIvJKqN7vUYXlHir6mWbiaSjcOn2ffj/7T0HSctLkCmWwQp02zcxT0IqAY1+G/cpwd3sNPLZeKu9THhUbFsyrbnHusl/7sOWpa1h2dkPvVvgQEyGy1miwI9Zc/pmoJRrRQCND4FuwynCCA3RuRP8mlM2rB/YQ+hpSAqVvqvTpK5Ih3DnzdS1o800rfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfc+AFKmqDxoztfzBfkHemIMChOa7r2r+BYJ876qcL4=;
 b=nluU1pv7a0R6S/UwDcmHA/vBethumoP/jCQaETz1eLASSlcHkbw9AscDRFwhR+wdGWyM6L3kIpzFVxEb3IBr5KxJX9ce85UOXdBuvWC/NKpF8D+qgDeDrnAuvtOj+7kHORSRcsxgh+V9rH3svmm8JBW0gvYbVKKoyp1ypvBB+gQF75Nxd16JQL5Iyim4MeiVMYKmXMFCjW035iPzFu+eZoJDwwS9GQ8t79RhvmFM5Cdrog68NhQYmWO33Df7lxYPxkyPE9wqrUqQ4DvyDSkIWgzFgBdWUuJfqtAxEHZceVVyKPqI3yZ49yTGQpwK0L7/NWXIoWfdohf1PzviHcz5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfc+AFKmqDxoztfzBfkHemIMChOa7r2r+BYJ876qcL4=;
 b=wUPBiaQocxAyAQh9eBCD0hs7SsdLVvVCbi+GmQu0J96fmF7I6NImme9z/NahGT1GDb+YusDKqI+oJuLZIUWq3XsZmvB08BmqxhvpqOvptRSXyvB9ZDtcgyWovhtahNy3XcS1K7SDp/41fA9AOasDW9DfX93eL9iDl+jtNr9XADQ=
Received: from BN1PR13CA0024.namprd13.prod.outlook.com (2603:10b6:408:e2::29)
 by IA0PR12MB7628.namprd12.prod.outlook.com (2603:10b6:208:436::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:11:48 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::6e) by BN1PR13CA0024.outlook.office365.com
 (2603:10b6:408:e2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:11:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:11:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/12] drm/amdgpu: fixes a JPEG get write/read pointer bug
Date: Tue, 9 May 2023 18:11:25 -0400
Message-ID: <20230509221128.476220-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221128.476220-1-alexander.deucher@amd.com>
References: <20230509221128.476220-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|IA0PR12MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e0022f-114f-4c21-d478-08db50da627d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDPZ1GSBrghE/263sxvQgGB+zFcxHVCSm6CEg8lHfO/GuapWVT2UhlZzE9zIrL/tUgJH+ThyLfYeKmDkJvyi40sl4oSP9m5V6oQHi2SJpJvI7eavWcN1YvvMZ/cG5vis4BA7eRHDLN189ul8Nu+eKnlhTFLXjLRH4AAfbG47U/jU5MgWQ6PjJ6gevBjcSFQsMaIIOtfbTEBUJjWZK5V30igIfs+hWmd5iSzAz1w6ztXgiwUKaxH7RTeWVLm2x8dNqFeP1UYxpvEL3cM5Qfj0cH7P9I6WsPHC2aKctHHRWxPDWVayj+ywrrC4i4qaZNyoSkvVPOMYNdOVFJNpOPBfNYovARlHM2QWxgcYF0DDc9mquTA3Z0svIHyZSBVfT6Uz18IIZ8eJoGbIYC143Qj5zhu08swtF+TkRUsEIV37DRxS/Y2NIAk1+xlvn1NgtTwxUknQDR2P41QZdrY4yyOXIwhqB9NZEcNWigUVS5P5+abhth0hH5b3Ztm647WTt++cJdeeQtDEmfQDhiCGX5NaFqgAKqvhu0zGcg7YEa787nfmDm4WQJsEP1oy9Jk7Nv0Dc9Agxo9cTUBTtPGo3GFYF6FALC14vFO4GxmnQai5sRijg63ZRaVhbaOR4Jf6Sg8BtsM9rbhJLTE+qZsRJqjo0aVFGcBtGVy8WW/IbGtmtaY6m4zEEmfXQLKCemk0dJl1pymkIwloyCzBiWEiVY3DsSAA6PyjQ1ItA6z+Rg8UF4M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(426003)(336012)(16526019)(2616005)(186003)(2906002)(83380400001)(36860700001)(36756003)(82310400005)(86362001)(82740400003)(356005)(81166007)(40480700001)(47076005)(7696005)(5660300002)(8936002)(8676002)(6666004)(41300700001)(316002)(54906003)(70586007)(4326008)(70206006)(6916009)(478600001)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:11:48.8094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e0022f-114f-4c21-d478-08db50da627d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7628
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
Cc: Alex Deucher <alexander.deucher@amd.com>, David Wu <David.Wu3@amd.com>,
 Sonny Jiang <sonjiang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sonny Jiang <sonjiang@amd.com>

Need parentheses for the micro parameters.

Signed-off-by: Sonny Jiang <sonjiang@amd.com>
Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15_common.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 1c9e924b5f8c..3730c5ec202f 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -71,7 +71,8 @@
 			 AMDGPU_REGS_NO_KIQ, ip##_HWIP)
 
 #define RREG32_SOC15_OFFSET(ip, inst, reg, offset) \
-	 __RREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, 0, ip##_HWIP)
+	 __RREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + (reg)) + \
+			 (offset), 0, ip##_HWIP)
 
 #define WREG32_SOC15(ip, inst, reg, value) \
 	 __WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), \
-- 
2.40.1

