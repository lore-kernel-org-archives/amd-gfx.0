Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F84C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 13:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6326112D
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 13:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E6326112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 113D76EC7A;
	Thu, 21 Oct 2021 13:57:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EA116EC76
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 13:57:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGDV/JLdjWCoAizMCUh3kd5RbXU0VldjKq700x+Zp2dWI8DhfoHo9P3YgnVSNF0ztrar9Dz9VXwtqllXqzPgcqrW64RA7NvKP3YT/gMhRoVR+xBmXYbQR4Xi68cPHJ7aMXY8l3D7iEn2OYxU2qMSwhSCOJSHFdJqtGD/LWC04RK/18Z7rFXDDYuj759KzHGlrcBa+BK/YbLRGcJw6HjkbeANbnA6bHj75cadg04LnSCnCxP7X44N6j1pdpNQa/487KLF3JaL5SP894Q9cfAbiCKjkV42vmjbFVkn5bpZ2i1k/nw2XARLU4fl1MFg3KkFdQ004YxQML2RJ4ZhsgVGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lSDDzgilmM/m6INdslLx1UjkuEuLS/Wg9/F+axorqU=;
 b=OIHjU/3aJmuESwfoYTwj2je3xr9QIszb4srL1ddhy+dxGn0cJteXP2GV3E+/w/N90ysZYtVZVQzsTo5m1RcwAv5aBamXcjzUIir3u5VvaFBHP3UtlgxaLVsgvpUgQB+iEtX68HTLv24b/a0BZHwTtbNP7ntRaDq6lDnefgrvFSMCocVyHJfNWNul5vB1REQyWqXSUT3v9csfZVWbRKofYD7u7YXCCeMeSj/ZRT0QWemDW/ELqpRAhndwvpXQ0aPvHDhFYQtprS7gziEab/krD1HT+hU1wreb/N255u2nkPHTibiS2Ysg8LURtUzjZZHm9xMQ2YmrkazmbwllD5xVGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lSDDzgilmM/m6INdslLx1UjkuEuLS/Wg9/F+axorqU=;
 b=BGTBRRBu5KIlbcVMrzkvAarhv7GAQ40Yu5u82cf5OP7Oia6rEgRHQnseAM6BfD3flV3zzmftZwT2kst2/x1NwTYkZ5FJ/mKM56y0cxv+tLVx3vgTu3V+P+wnx1Mv5dRplj/w42VFzvoh9Jlcqs/H0FiC6QEIJpNZagvbpaWwdKs=
Received: from MW4PR03CA0153.namprd03.prod.outlook.com (2603:10b6:303:8d::8)
 by CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Thu, 21 Oct
 2021 13:57:46 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::ec) by MW4PR03CA0153.outlook.office365.com
 (2603:10b6:303:8d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 13:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 13:57:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 08:57:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/swsmu: handle VCN harvesting for VCN PG control
Date: Thu, 21 Oct 2021 09:57:32 -0400
Message-ID: <20211021135732.2033128-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021135732.2033128-1-alexander.deucher@amd.com>
References: <20211021135732.2033128-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43af869e-04bf-488c-3d9c-08d9949ac2a4
X-MS-TrafficTypeDiagnostic: CO6PR12MB5489:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5489875BACE6BFF6872AA66EF7BF9@CO6PR12MB5489.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MYpyW9cesdoHs2cTLPlT2UiapsRImKlquC6lbQeSLS5R4wISNojVLqQVF2yiWSuoHZo09yzD79wdrSls/DFfsJ6+B/NKyS8P85ptM7v6ws2arZojCSPmG4Zw/gHjgHI1DopZvmj6H79YFMBuQL45uIR/+B8brOyQgz87FwXs+67bbmpYfbfmPXUAdsE+My81wlVHDqRp1DRQwfUVy343VJr1kd8yW4C65T40jxEGGxIb4YSmmA9KW5eWwNy+IAM3TBx5GxwpajVDARiiGzgBnGMss0W5jPfhpCRaiPyaLUx3M6fX2QIRMM8QC6inCNAxtlfGA8PmQ9DA+rM8MmFzn7M3AM5kNI8gDCXSAd/ygAhrB8FlGXpDRnBVr5M6KOof8doHbLCLamIT9bjhnfwF4IdAXMlXjN8q0iN5CCLKr91O4SnYkSQrV3neF28LJLKhTVnGK5RzxWmpzvAU6XFBbOZLTaaR59fJCLjvDXE+XvLLYbZH6gP/4ZMv0+wR3pxgNWBn3mJulCEQKMqolj7sgOn+KeABihWADEwaJwBgqVaEYy/LhZFEJXR4bQIqLLrTIMMj3rtdaBWGTD4drCI4qeHxH+yccs3ctFo7NihfQ9ZlnwiWm0tBWTbbr4oWpxkrKTB0ZZHBnZKL4qf3/uQ7ZJZ0lacUhr2/c9a8v+uTFtymMVqikNnaRKRvvRHqDvVG7Dkd54VZJ23bwxtecizYJMynfzhm9EgyUXcXxfN+kYE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(7696005)(2616005)(36860700001)(47076005)(70206006)(356005)(83380400001)(70586007)(6666004)(316002)(81166007)(6916009)(86362001)(2906002)(186003)(16526019)(82310400003)(4326008)(8936002)(508600001)(1076003)(336012)(8676002)(966005)(26005)(36756003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 13:57:45.9424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43af869e-04bf-488c-3d9c-08d9949ac2a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5489
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

Check if VCN instances are harvested when controlling
VCN power gating.

Fixes: 1b592d00b4ac83 ("drm/amdgpu/vcn: remove manual instance setting")
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1743
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 28 +++++--------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 15e66e1912de..9326547fe5fb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -902,32 +902,18 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int ret = 0;
+	int i, ret = 0;
 
-	if (enable) {
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
 		/* vcn dpm on is a prerequisite for vcn power gate messages */
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0, NULL);
+			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+							      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+							      0x10000 * i, NULL);
 			if (ret)
 				return ret;
-			if (adev->vcn.num_vcn_inst > 1) {
-				ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn,
-								  0x10000, NULL);
-				if (ret)
-					return ret;
-			}
-		}
-	} else {
-		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn, 0, NULL);
-			if (ret)
-				return ret;
-			if (adev->vcn.num_vcn_inst > 1) {
-				ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn,
-								  0x10000, NULL);
-				if (ret)
-					return ret;
-			}
 		}
 	}
 
-- 
2.31.1

