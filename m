Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56910C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF5F6101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1FF5F6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF21C6E8DE;
	Tue, 28 Sep 2021 16:45:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C896E8DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5vf6T7J+PjMCmPil+7dZoVnS2P2Lr6dN9/wwnaAc8BX1H3iHlZ+MLiZRNVDw9juj12XXF9YudEgmF43iitQ+wwm1CL3jNY1c1iHFbZWkv13MAL5wnZ8zgQ0IlVDqW1cOw9sjv3QjC8sNBcDC2g375Q8jXFjCDT6x4UhGJRBI/E5rC9R6zuYLqWm/833PdD2UIe5eL08oJGy4PJKhckfPeVdjFe50mWqS5BDQEebFgXgv6w6fwIlNjmZBE3NaPaG6dduEErWMShVIA4XlV2948USdrLghNcbHROEq7mqUbVqmH/sqyofwn/tge0peAnaRBHlF+pAaaUsoy2D5FIJ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=FUDNBcN6vsdNtLCqmxR3Ynz736oD0HxBwTmC/8R6LCY=;
 b=RJPGOsq7zYz+MjOp9xqMm5WX/DcNTu333dJeiMBcpYMJXXfW+ic6OMxnVq5jZZpWD51PPyeyt8r/GZCoYX90cQ6RxUUbiCvYQnh8qACj444Mg/ShCAqa0pAh1ajtIU0tWn+WCNaiNYsu4Epxagts4rWm9vBW+BP7VCqmkHLTcrXxaR3k7xBBSlfcR5vGm6k+dvvLBMQdJKVRHdvbswJvWB/8MxsexG7nYYU1D7MRiA+JXkjtpaYKio9IW9AoCt/FZ7wEcDjNEn9qPESHX5yHFinnbpHPJYwT4UZqp/jBGUqk3m+0803OzBjeBS8853CaM/VQbrFvxF87OzwrF7bPew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUDNBcN6vsdNtLCqmxR3Ynz736oD0HxBwTmC/8R6LCY=;
 b=h8VTLRdAlQYkKKMzhCZMzgfy/OgZ/tX7ghwshMuWROXuB0da8akqLaOaI1TLsE614K5ftJszmazSMb9laMvLDzcDuJBMNEaNe6WL5de2wfvLXXov3Xqkz4ZcGDE/zxYqrGNs+t6pRMLVRdXbaitYND3cHDm7FQ4oMRxpPl6MOds=
Received: from DM5PR22CA0021.namprd22.prod.outlook.com (2603:10b6:3:101::31)
 by DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.18; Tue, 28 Sep 2021 16:45:43 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::7e) by DM5PR22CA0021.outlook.office365.com
 (2603:10b6:3:101::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:45:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:45:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 45/64] drm/amdgpu/pm/amdgpu_smu: convert more IP version
 checking
Date: Tue, 28 Sep 2021 12:42:18 -0400
Message-ID: <20210928164237.833132-46-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af9ef6cb-6c3c-488a-3f69-08d9829f6943
X-MS-TrafficTypeDiagnostic: DM5PR12MB1657:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1657566BACD4A14DF7565ECBF7A89@DM5PR12MB1657.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yIr1cCVUdFnnC4Iu5RF7tnCRBGiWTId8iXuQMOmi+PSozaASnjXYq5Qoyt+iq2ylf5GecXKxnzeegz7deTxX6ylervYbRy35kSVwL3bu//27crtfQjdBhoLAGJ1tPYYDDP9KHuvluF6pbHjaEb21ojbdggWEpj9/lnsvCx6xq88LZFvYeTXkgav0kXfwZ1omOuV9Zu96DZzDncviUGdxlt/UsWN4ZOd5dG5Klj8XCNySUr9TbnzOjZoq0W2Z+0E+a5ZlTOUPABzBikTkschh2byXgEqcMfATIeCbuh/oz8B0+SL76kj3Tb+URxV+9L8B4R1BAlJ1FKRU8q/t1WfswQkq+k5xsiye6vK6QjH2Tr6ZFDd8VV9XH1Nez7HF6Q/0IJUmEWhZX3f9KlLAeCC7pKI7O3roPTVCoPRUOCrqmyiGVzuxtfNX/XzI8C+nOwhtGM8JQ3oHFB0B3iN1vsMoWkNh366NlJcBEG0xODEqNS4ddIywKTg9Xo66fJFB43w/6fqeD8NyRixEu8VA+scRRaAAc7dfndlPTBY1Z82Z4FwfM+0DHF7K77+SNsA95gyhFKb57RgiYg8j9x5utv9/UacORtvF5V43Tq7/aiPslyFbq//5rcvZeCjm1i1SDdq4l9wSOSC7Nlc+EvSHY7LjyD080U1BE3aYThR4Excq0YC42tpnazP/nGePoXCyETu8ThjQcjQ1rz6F0nHXXXia9MR1q6a9SEuy0ulLNyme9h4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(186003)(70586007)(66574015)(1076003)(8936002)(508600001)(356005)(7696005)(86362001)(2616005)(16526019)(70206006)(54906003)(426003)(36756003)(26005)(4326008)(316002)(8676002)(6916009)(82310400003)(336012)(81166007)(2906002)(83380400001)(47076005)(6666004)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:45:42.6252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af9ef6cb-6c3c-488a-3f69-08d9829f6943
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1657
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

Use IP versions rather than asic_type to differentiate
IP version specific features.

v2: switch if statement to a switch statement

Acked-by: Christian König <christian.koenig@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 46 +++++++++++------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 68592b055a1e..40d6ae779ae4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -455,8 +455,7 @@ static int smu_get_power_num_states(void *handle,
 
 bool is_support_sw_smu(struct amdgpu_device *adev)
 {
-	if ((adev->asic_type >= CHIP_ARCTURUS) ||
-	    (adev->ip_versions[MP1_HWIP] >= IP_VERSION(11, 0, 0)))
+	if (adev->ip_versions[MP1_HWIP] >= IP_VERSION(11, 0, 0))
 		return true;
 
 	return false;
@@ -601,23 +600,19 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 8):
 		cyan_skillfish_set_ppt_funcs(smu);
 		break;
-	default:
-		switch (adev->asic_type) {
-		case CHIP_ARCTURUS:
-			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
-			arcturus_set_ppt_funcs(smu);
-			/* OD is not supported on Arcturus */
-			smu->od_enabled =false;
-			break;
-		case CHIP_ALDEBARAN:
-			aldebaran_set_ppt_funcs(smu);
-			/* Enable pp_od_clk_voltage node */
-			smu->od_enabled = true;
-			break;
-		default:
-			return -EINVAL;
-		}
+	case IP_VERSION(11, 0, 2):
+		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
+		arcturus_set_ppt_funcs(smu);
+		/* OD is not supported on Arcturus */
+		smu->od_enabled =false;
 		break;
+	case IP_VERSION(13, 0, 2):
+		aldebaran_set_ppt_funcs(smu);
+		/* Enable pp_od_clk_voltage node */
+		smu->od_enabled = true;
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	return 0;
@@ -2304,15 +2299,20 @@ int smu_get_power_limit(void *handle,
 	} else {
 		switch (limit_level) {
 		case SMU_PPT_LIMIT_CURRENT:
-			if ((smu->adev->asic_type == CHIP_ALDEBARAN) ||
-			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) ||
-			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 11)) ||
-			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 12)) ||
-			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 13)))
+			switch (adev->ip_versions[MP1_HWIP]) {
+			case IP_VERSION(13, 0, 2):
+			case IP_VERSION(11, 0, 7):
+			case IP_VERSION(11, 0, 11):
+			case IP_VERSION(11, 0, 12):
+			case IP_VERSION(11, 0, 13):
 				ret = smu_get_asic_power_limits(smu,
 								&smu->current_power_limit,
 								NULL,
 								NULL);
+				break;
+			default:
+				break;
+			}
 			*limit = smu->current_power_limit;
 			break;
 		case SMU_PPT_LIMIT_DEFAULT:
-- 
2.31.1

