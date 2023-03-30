Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B651C7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 397D610EFCF;
	Thu, 30 Mar 2023 19:32:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6413310EFD9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:32:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBClENxu22PbhsszQoPccrkO0rusgbvJytSbBdxBPrt5L40PwtBTZ02BscbapuQE/U5xijJ+oLAtub3pcObMVbkqpnPnj8crJ+2w1DhJVVzdWU6YNPBFxz9A29BYQX0EJNsvpzrYSWI+jKRAFxG+qHWKXkeSz4C690q7K3e0H6qHaAgyOYT3+izBlA6DjINucZTTZsuFgYWP8LiPRD1pv8Jz87oQaFUnh/r3ao1yoYQ8Daj80HqxFFCjRTvgvatPatxN+6l4thNrnzD7TMPVNSpThAfWeUtz17FdeT2UVKa8+CkUDdjS63G/3nie2Fj8aNzMUkqVC3cgfIgI1WOT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnodg9T1qJ79Z5ZX6crx9d3Yh+gqSGnebRlIeAU6/tw=;
 b=jZ8k069LvUdPRTQMC49miuXXKb5cK5NG3X0Eyi5qENrwrhPI/Vm143tttHaE8SovrP2z4qbFfujScPRtFb2gIwm0V2NStKzJTsa5vNdN2zQxDXxbzN8pI7yDtc0ongDXyo3gJHMwzPy971KxprJxKoDUnd2gj7C0MYELAWt05fT5X+ZORep0/Q5dYBi3o9SkboD1Euxjr3Wx1+lEkVDAAAlNIxmL9auIO99+glbVqPb1piQzXvfX0P1tZ3EozoAPUuaC5r1qDqow2HdsZWzlqwTBoeoaJz341sIsWgbFXGCQsC72+/XT1WTw6sBdY+ugqS3JkXmN6oN6hWrrmMsQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnodg9T1qJ79Z5ZX6crx9d3Yh+gqSGnebRlIeAU6/tw=;
 b=dZXOMknhvfBBIMzcPBWVOMWp1F6cqGfESk1rxKyciRd+4we1yppxI08bTPjDjOsBXdGuP1pqDXG9DKmrWTd0dRtiyKHQcqI/YFulfP//SIc3ebvW48PgMmTOFpTgjLQ78oBvKWoNRBYAfMoAdcT6olyZVozIee4jOQoNQRDZ5fk=
Received: from BN9PR03CA0080.namprd03.prod.outlook.com (2603:10b6:408:fc::25)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 19:32:23 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::e1) by BN9PR03CA0080.outlook.office365.com
 (2603:10b6:408:fc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:32:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:32:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/10] drm/amdgpu: Add soc config init for GC9.4.3 ASICs
Date: Thu, 30 Mar 2023 15:31:53 -0400
Message-ID: <20230330193158.1134802-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330193158.1134802-1-alexander.deucher@amd.com>
References: <20230330193158.1134802-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c58abf-a62f-4cd7-7981-08db31557c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: auyh+JRmcKNwwSj51SdN/oh46rBfCqtYujNDbAC+P8IbGcOsLdfHk9DRQQKEIB2vFqQQbyKHTlxY+g6l/LNzzIh4dTF6NpflaPCg0RymUfkUpz8Mtn1dM//Mb8gujSVg3EW46dSSpZZNOuidORbU0/spFljYrJj9ws+3FHcS/uZeHa89DOeq8QJs9xyTZwiNRuJ+DTzT0SZcis8WPMJxbKWlnudorvwQVSglVALO6VFoJr2tffIzlJPK2BkSDsgktNVudNzPZhgfBBxPqZmq27QCG14SsjmmF0dUOWyYeJc7o1L9tnhGJx8NBrPqSRu4ARfVFDOA+2sMyEuVhfqDSt80bdzbYC/nHeGrQCJLbMSiAy6k4GycFX+qeLAWykcgKaiuID/JeoqSPgcGuGLW+Ad1c84IouTGc41qeCCocNlU5CJoduGLOf1ypEXSYqMCLWWYjvVvs63c4BWBnI7K3moUd2TgKCZUZAVApJ3bWC+PmNGArEcYLSEzgJzwTIMa+n28qoWvYsMfkcbCLLMWkzsEmZ6ii+E0K72D/+fksz/JiOQTqtu0tPPYGhhgPhRlBqBNfaAfqWZ3K/bTJNsfXtM+qRE+etS/gOzt1GZ2CBrB7h9dXpsBKoSml8+MKSYy3T0CLPjDwWtsUZyYGpZSyqplKDFXOsIRRcy1gKNXpgZKs5JfrvXZNM68tYwKCPU+q2e5bXIRMYL/hL92ReNB2FzzfM/yVPX5l0C597uvtB4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(2616005)(478600001)(2906002)(83380400001)(36860700001)(1076003)(7696005)(426003)(336012)(356005)(54906003)(8936002)(5660300002)(81166007)(316002)(86362001)(82740400003)(6666004)(40460700003)(16526019)(82310400005)(186003)(26005)(40480700001)(47076005)(41300700001)(6916009)(4326008)(70586007)(8676002)(70206006)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:32:23.2905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c58abf-a62f-4cd7-7981-08db31557c79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Add function to initialize soc configuration information for GC 9.4.3
ASICs. Use it to map IPs and other SOC related information once IP
configuration information is available through discovery.

For GC9.4.3 compute partition related callbacks are initialized as part
of configuration init.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c       |  6 +++---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15.h                  |  1 +
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index eea6083d5108..2d31e6592587 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2035,11 +2035,11 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void amdgpu_discovery_ip_map_init(struct amdgpu_device *adev)
+static void amdgpu_discovery_init_soc_config(struct amdgpu_device *adev)
 {
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 4, 3):
-		aqua_vanjaram_ip_map_init(adev);
+		aqua_vanjaram_init_soc_config(adev);
 		break;
 	default:
 		break;
@@ -2223,7 +2223,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	}
 
-	amdgpu_discovery_ip_map_init(adev);
+	amdgpu_discovery_init_soc_config(adev);
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 0, 1):
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 4264fbd267ae..a9de229a2828 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -351,3 +351,16 @@ static int aqua_vanjaram_xcp_mgr_init(struct amdgpu_device *adev)
 
 	return ret;
 }
+
+int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev)
+{
+	int ret;
+
+	ret = aqua_vanjaram_xcp_mgr_init(adev);
+	if (ret)
+		return ret;
+
+	aqua_vanjaram_ip_map_init(adev);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index dd48db09aa51..eac54042c6c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -113,6 +113,7 @@ int arct_reg_base_init(struct amdgpu_device *adev);
 int aldebaran_reg_base_init(struct amdgpu_device *adev);
 void aqua_vanjaram_ip_map_init(struct amdgpu_device *adev);
 u64 aqua_vanjaram_encode_ext_smn_addressing(int ext_id);
+int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev);
 
 void vega10_doorbell_index_init(struct amdgpu_device *adev);
 void vega20_doorbell_index_init(struct amdgpu_device *adev);
-- 
2.39.2

