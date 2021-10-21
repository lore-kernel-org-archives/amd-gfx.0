Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E246C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 14:18:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E980B61208
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 14:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E980B61208
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C3586EC7E;
	Thu, 21 Oct 2021 14:18:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8A686EC7E
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 14:18:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmX4EZGXMK8JRzQqyVqnRSUi4sYqthf4/egCGQ/HlOHv4bBju8wCpm2z1L2tx3BZKQwS7Qn0Kp9brVoePoRf4r+GReXpe0YxZYm91UHabrZjReEld1IEh+hxMVslTIFR0gaIvM3p2b3T8jmCMv+i6a3iB3CV2Eg5GrzxC1VJjt6RK/ox3Q2u9oGLL/4B2KDhZS8lXZqYDRcTXJJoo9X3NFNtseirLRciUI1cRHe0X7VY/gF//bVZVb+zlHHcYvPzggqreXW/m+/AeHCd/pkIMnswItNTogUvp5BvA/CvQZZ5AEXCyaBMERcfToBvfjFj5YlTKGa1E1te1qJkmqVcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lSDDzgilmM/m6INdslLx1UjkuEuLS/Wg9/F+axorqU=;
 b=T/hQ8gxXGNejv/dmEowP2VCcMIjCF4L9yqODxcseoabl/O8h4cF00mw2wbXxhCoGXEiUH5kQpS8D6ds0ENPWvsP9PjXrYN0LmURmpFOUxXpY2jcMBOK5Dlp2ItP3KTb1tejnkTXUAahWHQQgvJA6lwu0KXC+j4AudXUrfdqyKCJfxcJIm+9avgHcxTSWh1mlh2daBCXer+OBISl8Dgd8QQz0PdqrRe9mtmsrKxLHv6761+AeEw6m/QR2Q0ZiE8K3UQeK7BfFKo5hNmDp075JnhVIL+MJf5SOwKbVxHOJPRQEZq5upca+/mKGMkZv9UHQzX8Qa7xtuW26CjLtfm7mLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lSDDzgilmM/m6INdslLx1UjkuEuLS/Wg9/F+axorqU=;
 b=bvhxZr8LB1IaksMlE9pT4HhCDYoZukw4iFdEBJkA58wVomojT0alMbwyDz3ixbz3mgLaxTB7iJ4GbreRWobkXwABARS0HUsw1GR+rqnVgjG13gklbhsH/LqBpIP2XAXpFP9sGcCEzgsQo2aAkVTHjwdpxNrMFsl998JQZZ/79V0=
Received: from MW4PR03CA0047.namprd03.prod.outlook.com (2603:10b6:303:8e::22)
 by BYAPR12MB3430.namprd12.prod.outlook.com (2603:10b6:a03:ad::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 14:18:19 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::1d) by MW4PR03CA0047.outlook.office365.com
 (2603:10b6:303:8e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Thu, 21 Oct 2021 14:18:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 14:18:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 09:18:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/swsmu: handle VCN harvesting for VCN PG control
Date: Thu, 21 Oct 2021 10:17:56 -0400
Message-ID: <20211021141756.2048254-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021141756.2048254-1-alexander.deucher@amd.com>
References: <20211021141756.2048254-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea92d9fc-f04f-4f95-25c5-08d9949da18e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3430:
X-Microsoft-Antispam-PRVS: <BYAPR12MB343076AC856C64233F8B3C49F7BF9@BYAPR12MB3430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYpoL58K8d3O366hE5fS5sFoQ5cDRGsEcWecKGPFu7kalLg3ASRILCMlhlUeXs/KPVmZ5RgJ+mR+/u3NOzpewHW/N8XnDpNriGiyvajv/89VwI666OhwsF65qY4z1AqgYPGHtH25SgHWdaZQ8wQtB8qP9lq5ik7XSHhQdgpWx8NrcFBL4FIylBQS6heOJQNdN9FudIm+RR04x/ngyQCBPL9xpXi5LRC3zR2v874ZE6b1HMvDvOLcVL8rdw+eVnMs7wnXsZr/3p4fg1Lo+Ri67SMM8SaWWgLd08SmCivXAYhlo/1xqcgjvkM6q/3ja29TSfnj0zSSVRAgvRoJNgbty/QcF0QJLLfkaqnAm8nNGsCQum77TrwMy+DVoqZFhPbZCPc1j1oHbt8MyAps01IZZnDMdBMZrUOLOv6f9sdpZHwotobhzektM/os/W9VGG0t2q1ZQGqMoi5VTbxM8i7YmvYWESCFest64m13Flkw5Yzwq9PnIR1hMZRzpp3AQWehxpN5saPfk6WF1AskvsbA7Q3mGCXdX1Alcg80IyfjJmgqq1BwMlEK6jJBeoAV8d8UV/m1g/GInma0ootEsVYm2yG3UCpfSsYZxdiblHeOBNwpZC6m9eWnj+kbB/QIekY+ukfhBah2r4YRIhj/3n+SgvBlwM5BerfPYzPspSN2USk02qLROeQcFCw/WG2LU1JGsrdVYzSadyPN92Pa87Y6PZ+e8CopuSu/27k1rUTu+7k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8676002)(86362001)(2906002)(336012)(4326008)(6666004)(5660300002)(356005)(47076005)(186003)(26005)(508600001)(7696005)(36860700001)(70586007)(81166007)(966005)(82310400003)(316002)(2616005)(83380400001)(8936002)(6916009)(70206006)(426003)(1076003)(36756003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 14:18:18.9330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea92d9fc-f04f-4f95-25c5-08d9949da18e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3430
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

