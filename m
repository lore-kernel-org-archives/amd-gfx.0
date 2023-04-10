Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA68C77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 11:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF1E310E034;
	Mon, 10 Apr 2023 11:48:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D355110E303
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 11:48:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTUKVz/TBn1obRRG9u+ZgH+VgK9zsPb/wuIlG61fILtvBosE6B6Y1Ib9Mrjzxxa1zTwQCywpNbbG+D5POWeoFnvkCKx6l0/ClKiqpAsuieNgctvwdNHfabXY6ocb05BuuXKhWAhCKw7PTerkE6oODtTJlj5SoPJoqjtYSGwwm3/iva0sOQT1JNVVnn5Jp+WipP7zIjwFQszQKiC69QKB+Hi6KrLQu/qcFkJ5xK3xObuJtqp42zJZE6sg21GQlxErLnJRgWfbiKE8vpvpI+N8YImY65eDu86kSTktnlw/7GtFtFCU59Yn6XDfZjVVOnA0oHHNVVssBToSKI4ef84tag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLMKNPKBgliwqrUuDxn5fi09yVIiMeS9MZT4o/yyeo8=;
 b=b2G4wgfpzunw57cniTmlIdg+wKEAimkHlnpQFrk076W2FZZN9ECbAiO3S8SjdSb8Gh34rcMSJas2S4CAqnM0z3k4UqT81HmVfHhzzi5nAP4E5lLFHPdYDlHmCO00d1/G0eBydEK5paJviwzRkTGYG9s4FrKdigRZ4PLhvWj9RW6ihhENxWrZ3vCwG0NjIOXabya3vjADgR2kylvdXTIiKyBlG7BB3rfr1s1vpY1/8bAh/wqiRnd50QivLrGvnlXpCmxK7il0vab914cbs/L54tmMlXJKAMvPvX7AMUxhmpMAIER5hPpOAxebMc44XDUmyiejY/rz9dJE6GWQwALuUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLMKNPKBgliwqrUuDxn5fi09yVIiMeS9MZT4o/yyeo8=;
 b=4ORMiX6pyzbqbmAOqE4AlfjHW8l/Ged/yhMxD9ahOmaswNPL63UCSDPd3GQrudm3fZGzbd7dyqF0+DZDnCVS4UAHKpu4xeHLWWuYNH+B+csqeiR8aV2LVtwfRoIsAFUKkL1iD398U/7VV4LdunkFKoG1PsMPZ91HbD6f6Z69EaE=
Received: from BN0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:408:141::14)
 by CH2PR12MB4873.namprd12.prod.outlook.com (2603:10b6:610:63::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 10 Apr
 2023 11:48:27 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::b3) by BN0PR07CA0022.outlook.office365.com
 (2603:10b6:408:141::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Mon, 10 Apr 2023 11:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.25 via Frontend Transport; Mon, 10 Apr 2023 11:48:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 10 Apr
 2023 06:48:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 10 Apr
 2023 06:48:25 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 10 Apr 2023 06:48:24 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>
Subject: [PATCH Review 1/2] drm/admgpu: fix unexpected block id
Date: Mon, 10 Apr 2023 19:48:21 +0800
Message-ID: <20230410114822.750-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|CH2PR12MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: dd14c567-4566-4f6b-9451-08db39b97fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oADQiaegQlRO2TUodS+cA4NtaqTndan9g1LtSnkmm50hZEVgntxx2Asmn7HozN2RrF/wkzlBzBASlZkHGKfBSPXnZJTQp8WikwdK0lXGECe4OkOdOZGUiG3xpnEtwhmq8m44ukT2vQFkh2muLfoNhpDnjI0gNBgrZ9bKQy64WiGAI2MsBxOXg/4agPP1y/5stVmp0tf35HG+I1hiaIXFLlxuzBOJ0I8/Qy1iniGF605UYyKVbxZLnRAa+TJEvLqnyTGeL77k6jxg2ebii5w3XztBCLDQGBTpXeetJD9rc3RlYdYiE5RvWQzTHZMxDwLizoeVH4We2B2x+QvMfsurVb3PdEF2UrrPoVTyNvCkIG7mTPJdCrUADTHcdBbR511KCFqwhGxj7Eb7K+G3heMXI3Cw2rlhabi696lH05oPw9sm+dMsCXwNnCoridsTPs01CIuemVZSG9dmEoVYzAaSUk0iaRN+6qDB3FXny1TN1gmDDKHr+LLvJV9WsbBfFuLew3MEZYG4zd3RIVwnBk+vuh+Hd5/n6a9BMbNJYQSY6MNjI8Qjr5xz5oFe79HAj0uqaUwkU0DGt+6Z5eZyI6eGtVn7q326jnvqFdcP87BQcof6mXybi1c5KwLD/pq0TKDv4u+Ec7rMKZ19tAfwYF6aKzIuylTcF94oQm0DbmkLauTmgIXBqrfSkBlzyQD4NRujOGme0Um+bgFuHQMyA4wmY40kteuWckgWL5loA26Aays=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(8936002)(81166007)(2906002)(356005)(41300700001)(5660300002)(82310400005)(36756003)(40480700001)(4326008)(426003)(47076005)(478600001)(36860700001)(110136005)(336012)(1076003)(26005)(316002)(2616005)(6636002)(7696005)(83380400001)(70586007)(86362001)(8676002)(6666004)(70206006)(82740400003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 11:48:27.5617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd14c567-4566-4f6b-9451-08db39b97fa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4873
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change-Id: Icceb43556eec802f11c2077c1c58a1e92c9df599
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 4 ++++
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index ef38f4c93df0..17b3d1992e80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -583,6 +583,10 @@ amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
 		return TA_RAS_BLOCK__FUSE;
 	case AMDGPU_RAS_BLOCK__MCA:
 		return TA_RAS_BLOCK__MCA;
+	case AMDGPU_RAS_BLOCK__VCN:
+		return TA_RAS_BLOCK__VCN;
+	case AMDGPU_RAS_BLOCK__JPEG:
+		return TA_RAS_BLOCK__JPEG;
 	default:
 		WARN_ONCE(1, "RAS ERROR: unexpected block id %d\n", block);
 		return TA_RAS_BLOCK__UMC;
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
index 509d8a1945eb..30d0482ac466 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -84,6 +84,8 @@ enum ta_ras_block {
 	TA_RAS_BLOCK__MP1,
 	TA_RAS_BLOCK__FUSE,
 	TA_RAS_BLOCK__MCA,
+	TA_RAS_BLOCK__VCN,
+	TA_RAS_BLOCK__JPEG,
 	TA_NUM_BLOCK_MAX
 };
 
-- 
2.17.1

