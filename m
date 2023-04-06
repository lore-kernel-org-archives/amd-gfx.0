Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D393C7618D
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 10:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A80E710E096;
	Thu,  6 Apr 2023 10:13:43 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D489C10EB52
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 10:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/ZOQcjeC/+35jjsNnZJaFpQOJsEZZ8rNdx9o9VS/dZfH6JyDggSxjbO0xItf7UFZXVI7Xd11R8TZkKpYFYGMEj1RGTixsJky/fKU+ikqV6f8Onq0cCYwvMZ8n2uz21c+esL3khmrrtig8BsQRWvzMXf8UhzyDDWdmaiF5YjYktijFsesnjHMGjKL1jDrME1eVl4GUPkyZYtSg40Y+fKInpCS+2Q+hmP4cKEI1B38XIiNToD3inxS4oPlE/TgpWjJS62x1HPmjfXSGIU9leO3NALc7fllo2bjY7ijCoKtE5e5UPhpQsLfxmtQiO2Ltx7nAn/fqWCXMtwrZO3gx4oYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/k6WwVSMGYO3XINmgJoKO9B2rZy0/CXauhPCQORmDA=;
 b=fvkMdAcEl/puitU7BalErrn+IkMjtA6GefA1qG3GaFqx4NBoQ8x0V7zQ2LP6jOCXizfORQEcl3ZTVR3h3GRfamtYLipQRWIqLgrLc6k3BxeDkipJyagN6ulREVWZ9CEzecQTFO0x3FkgdC54rsY+rmxYxmheyae5QpJgtXgahkFiCrqjGq2lUOqvcoCzjgkATeosSPdcBcRX9yHRsndkDmvlfP/toV8jIicsP0BOpw8m2CgloQp2Vj7kjjNrWuDmn0YzMClAdM8r2PSf2d+Gd9+h89UqaC3DnYp6AcE1trqaILE6/gC7qAPcjBOVxKiOPIyCi7oGBDVUReDVCYhDbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/k6WwVSMGYO3XINmgJoKO9B2rZy0/CXauhPCQORmDA=;
 b=nY+1kQq5wsXbRaHIFP0mlw31zWkiRmVNzLZS8PUsgzlintkaupXKumf6fytnpUyZXgvQQVTRy7rzniyLMJ9PJxnt22kGwRRiel6jCbvzr2hrUnufLd7mSDAoDTt8UKoq1PBcnhI31zqSxNHmOPLsmai47hiYA+2qZquQDxFwt7I=
Received: from DM6PR02CA0099.namprd02.prod.outlook.com (2603:10b6:5:1f4::40)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 10:13:39 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::22) by DM6PR02CA0099.outlook.office365.com
 (2603:10b6:5:1f4::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31 via Frontend
 Transport; Thu, 6 Apr 2023 10:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.26 via Frontend Transport; Thu, 6 Apr 2023 10:13:38 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 6 Apr
 2023 05:13:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 6 Apr
 2023 03:13:37 -0700
Received: from amd-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Thu, 6 Apr 2023 05:13:34 -0500
From: Tong Liu01 <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: refine get gpu clock counter method
Date: Thu, 6 Apr 2023 18:13:27 +0800
Message-ID: <20230406101327.28310-1-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: a7211dbc-afbd-42c5-e892-08db36879736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iX0NbJvDiTar9eG4ILyW3SNq/ZJQ57dPYE4OfRzl512sP+JzScKgxxh9X7BU0HbfDREoEIvtYgMhgHgyUzMBRrX+8OYC5ySdJEd2nst7Ttohp4erGmx5APZO2DNcT/mLak0kFn2WMYXc43PUk72Sv5gnJZoluf6TwGAhLwFRGx9qGCiflM+ZRzF0Q4fGe4JMxLAEj4iYwnhcEB4eyzgy8SIux4MzgBlL363w18D22bDtdbmj4fopM/1pp+S399gjKwDSuJTnfwwN/5QAhtSkHehCKC10FuwXczQ8anDyOk4o75XROlJtDLTU0qFvgvSjzjDoE/OCZs7HMDrAN9PCnL3JLK8EJc4cGapoCMooIIV75r+gbcjW0EkbapoRN3YaLvJXpeFhAO7yTkUjr+Egl+PHD8YKi2pixyON6eZdpXUH4xMntvGCiY4GMB+78Ndj3Boy3aRTucGiV51eViEVgHz6M+Lc2cxrHJ9BeBXelLYsSkbOw9uDp/c2xa0T4K5HsmN1Lmu7oMK2zGod8unM32CyD2iFEWf0+IseJVkfMGriM24dxf5n79zOgMgq7RnwonNPmJ1WTkr/p2icNCUJBSqi6EPlHvaALulXldxutIbXULtAWiTFkRlmhBFW5Em/nrd6ZLUNKaU/jJvUmAmvnrXQuIsJBJMOpmm4PWMVh5+GV6pBTVqPiyM+O+jROnUfOKF2tdrNNXpqVbf/OGMdgBTk35/wEau0QJnGjmxMCME=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(70586007)(36860700001)(426003)(1076003)(356005)(2616005)(336012)(82740400003)(83380400001)(81166007)(186003)(8936002)(47076005)(40480700001)(5660300002)(2906002)(26005)(6666004)(7696005)(478600001)(36756003)(54906003)(70206006)(41300700001)(6916009)(8676002)(40460700003)(4326008)(86362001)(316002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 10:13:38.7718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7211dbc-afbd-42c5-e892-08db36879736
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tong Liu01 <Tong.Liu01@amd.com>, haijun.chang@amd.com,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
regGOLDEN_TSC_COUNT_LOWER/regGOLDEN_TSC_COUNT_UPPER are protected and
unaccessible under sriov.
The clock counter high bit may update during reading process.

[How]
Replace regGOLDEN_TSC_COUNT_LOWER/regGOLDEN_TSC_COUNT_UPPER with
regCP_MES_MTIME_LO/regCP_MES_MTIME_HI to get gpu clock under sriov.
Refine get gpu clock counter method to make the result more precise.

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ecf8ceb53311..107c487c0c37 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4671,11 +4671,24 @@ static int gfx_v11_0_post_soft_reset(void *handle)
 static uint64_t gfx_v11_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock;
+	uint64_t clock_counter_lo, clock_counter_hi_pre, clock_counter_hi_after;
 
 	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
-	clock = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER) |
-		((uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER) << 32ULL);
+	if (amdgpu_sriov_vf(adev)) {
+		clock_counter_hi_pre = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_HI);
+		clock_counter_lo = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_LO);
+		clock_counter_hi_after = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_HI);
+		if (clock_counter_hi_pre != clock_counter_hi_after)
+			clock_counter_lo = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_LO);
+	} else {
+		clock_counter_hi_pre = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
+		clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+		clock_counter_hi_after = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
+		if (clock_counter_hi_pre != clock_counter_hi_after)
+			clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+	}
+	clock = clock_counter_lo | (clock_counter_hi_after << 32ULL);
 	mutex_unlock(&adev->gfx.gpu_clock_mutex);
 	amdgpu_gfx_off_ctrl(adev, true);
 	return clock;
-- 
2.34.1

