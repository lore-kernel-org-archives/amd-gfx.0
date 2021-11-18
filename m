Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2904C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 19:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8E8361A0C
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 19:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A8E8361A0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 155E46E15A;
	Thu, 18 Nov 2021 19:55:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91FB86E15A
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 19:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlUNl5DPMTixCtKHKePqsy0WeaE8KOcsfIEBkniCnMZF5KucXynf5TjxWlBmlqgKFCgpDPEHAUgxcmkpn7zsZA6BA5ECzUGlUfJB7U8po+ikIUNSB3gz7qoB+ilrBnI+t2O7nkhU8LeHm9ChvBeDukIsKxX75A3ygBtIMIl3TZ+KO7LsHaJDaLsDcg/5v7ARJg0WJyAufWSKnLpgbTj18J8VFuUGVkSBCQ+UGPZfw9RW+hA1oqHnEzhX4rdsIEtJlKAVbRrM6gO1nHTFEdVyWNtyr7RggOMKynao4vEmxNQ1Hu5brWZKO4GMZ1VGL8tsSAKYZFkZCO4WzWab8SI6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8h2uAR6ur040Ed/NHWGXWqJfQeWcphFIYg1kNumZeno=;
 b=k28hC3/ksSHk9mY2aLspVN/6bmu2J4WMagbI63b/uHS+zkHWGv7R+6ZRxpIVCykAXoR5+6hrlRL5c56bCnV9x6D7InBMP+gytI/AQ8Hbxab/MPcrUKNrKGM1KKZJ1cF6HeSb13qsC15AXM2ncL7QONy65HjlKzmtorDhleFHvt+vk0W6hHZkAjcDqmK3LriPCTr5kzhbNb7l/vRX7I/Db5kzhb/ieMiSYOwGBV59VW0LjETJcR7qnYWQwkqOKQvCWEfqt8m9ikrYmHElKlNB5vQI/24utR4ITvMylYYEk+a+RqlmqPTCbiHa3AJljuL2iLhs/JXAns0ORMlaTOb/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8h2uAR6ur040Ed/NHWGXWqJfQeWcphFIYg1kNumZeno=;
 b=kjEiFkV5YoO8OkOlIUniT31MC9e/ZrXo4+YS1qeoTmU7xwOLqWvKm2Je0xnNVyuEgborUMoGfRFAfZCkA9L5GH/gCEcV1MfX7ARWkenF418B0VLKLM81Nq5HKJcnAF+74R1cIDtM++HQ3X2/YgNGn3+NLG4ytkK3Rb4Lt3e+WyA=
Received: from BN0PR04CA0179.namprd04.prod.outlook.com (2603:10b6:408:eb::34)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Thu, 18 Nov
 2021 19:55:09 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::cc) by BN0PR04CA0179.outlook.office365.com
 (2603:10b6:408:eb::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Thu, 18 Nov 2021 19:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 19:55:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 18 Nov
 2021 13:55:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/gfx9: switch to golden tsc registers for
 renoir+
Date: Thu, 18 Nov 2021 14:54:53 -0500
Message-ID: <20211118195453.485901-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118195453.485901-1-alexander.deucher@amd.com>
References: <20211118195453.485901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42ce7dc5-2113-4f1b-32df-08d9aacd5307
X-MS-TrafficTypeDiagnostic: CH2PR12MB4200:
X-Microsoft-Antispam-PRVS: <CH2PR12MB420083840A8A02679BA66B06F79B9@CH2PR12MB4200.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2j3KGE9zlCnI5SJA/cXR/j5nWgYMJLlhESIilLBGsPZrr45OEd3MmtsMnKPNQhyQDSs3S9bWqmSQrBb0UtACwbuKP52w7SmUnczxcSEjvrvNbKZjKptXx1Uf8nsbCYkQG5DIU8XAMCy8kQyz/qfG7owW44ADyEI7ymag4hpArEEmDtSefubpe6f1aWVQyQelEPN2YERvKAx8QkTvRDve6/jGap2mEzsvYfcZtIqANWqtiZtCYpSgE0bW1gMaBsLT2OOAxhIUm281sSrBDho3jlruWF61H4ybtz8yPTYWL2FaR/3ut8aDrjxuX6yqdA1+qzR5tS05bGdcJhZ1MiQU9lpCQZbYrB11rpBTwJPbiQFo63sueAZGLrhVz5MIiCCIEH+h6OaRqOMyI6CilTrGZb4r3N62076eRaFRT1l2djlYbsn0DkpIErL/VrNklUaYw7NMQvO+RJLvmFYv/iXDcUHITkvzEbIEA60Vg8kanulmVn24KJPWJwebBOl7tXk/m8VqBLrK57YWSGWBhvfnswyRA2dLkr/shvfN6Jjfz9YCK26JXL6BGLzU+sybVlLB8Xa06WRz+Y8Xcdf/KvUUEWDx3UWDH4inE+5Fed7CAa4FKtBAzXQt7GCEY9hYgEEUyiSZigCsN5ZTXCAaPJQsuhzsiFlIB5DlJzljrHcp5+M1CQvxtbROm9/MJQGO+w7xapwYmL5lt2xt5MCJDRGmrZc+Cwm/OcigimZBTDqjPns=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(83380400001)(2616005)(356005)(6666004)(426003)(70586007)(81166007)(5660300002)(70206006)(1076003)(47076005)(336012)(26005)(186003)(16526019)(7696005)(4326008)(8676002)(36756003)(508600001)(8936002)(86362001)(316002)(36860700001)(2906002)(82310400003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 19:55:08.7194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ce7dc5-2113-4f1b-32df-08d9aacd5307
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Renoir and newer gfx9 APUs have new TSC register that is
not part of the gfxoff tile, so it can be read without
needing to disable gfx off.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 46 ++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2d0bc1c91426..154fa6facf19 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -140,6 +140,11 @@ MODULE_FIRMWARE("amdgpu/aldebaran_rlc.bin");
 #define mmTCP_CHAN_STEER_5_ARCT								0x0b0c
 #define mmTCP_CHAN_STEER_5_ARCT_BASE_IDX							0
 
+#define mmGOLDEN_TSC_COUNT_UPPER_Renoir                0x0025
+#define mmGOLDEN_TSC_COUNT_UPPER_Renoir_BASE_IDX       1
+#define mmGOLDEN_TSC_COUNT_LOWER_Renoir                0x0026
+#define mmGOLDEN_TSC_COUNT_LOWER_Renoir_BASE_IDX       1
+
 enum ta_ras_gfx_subblock {
 	/*CPC*/
 	TA_RAS_BLOCK__GFX_CPC_INDEX_START = 0,
@@ -4240,19 +4245,38 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
 
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
-	uint64_t clock;
+	uint64_t clock, clock_lo, clock_hi, hi_check;
 
-	amdgpu_gfx_off_ctrl(adev, false);
-	mutex_lock(&adev->gfx.gpu_clock_mutex);
-	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 0, 1) && amdgpu_sriov_runtime(adev)) {
-		clock = gfx_v9_0_kiq_read_clock(adev);
-	} else {
-		WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
-		clock = (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_LSB) |
-			((uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_MSB) << 32ULL);
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(9, 3, 0):
+		preempt_disable();
+		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Renoir);
+		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_Renoir);
+		hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Renoir);
+		/* The SMUIO TSC clock frequency is 100MHz, which sets 32-bit carry over
+		 * roughly every 42 seconds.
+		 */
+		if (hi_check != clock_hi) {
+			clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_Renoir);
+			clock_hi = hi_check;
+		}
+		preempt_enable();
+		clock = clock_lo | (clock_hi << 32ULL);
+		break;
+	default:
+		amdgpu_gfx_off_ctrl(adev, false);
+		mutex_lock(&adev->gfx.gpu_clock_mutex);
+		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 0, 1) && amdgpu_sriov_runtime(adev)) {
+			clock = gfx_v9_0_kiq_read_clock(adev);
+		} else {
+			WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);
+			clock = (uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_LSB) |
+				((uint64_t)RREG32_SOC15(GC, 0, mmRLC_GPU_CLOCK_COUNT_MSB) << 32ULL);
+		}
+		mutex_unlock(&adev->gfx.gpu_clock_mutex);
+		amdgpu_gfx_off_ctrl(adev, true);
+		break;
 	}
-	mutex_unlock(&adev->gfx.gpu_clock_mutex);
-	amdgpu_gfx_off_ctrl(adev, true);
 	return clock;
 }
 
-- 
2.31.1

