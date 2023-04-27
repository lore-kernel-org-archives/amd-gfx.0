Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7551C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 15:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37A4810EB75;
	Thu, 27 Apr 2023 15:27:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14E7B10EB5E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 15:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8RMzyqPyHzs4nlILW1EVhd7oq71rl/JxiAc7Y8u7TZMD4bY6JRxGe0CQv5DWOx32niuPth97SdYosz4D6+jB9wn8o/JLQT4XTA+ju0FcPyTQIi47l9J1BJ74peFp/WffjUyoiEUOH0V1d0Fe5WhDBpwnvlF96lkNP92vFFaLwmeKBvV6tYE76XJu3FC1kqPqnVGOKWy+JEsr9jUOR/E9iuY8d2rbnPuzMKwJf/t8d4URuLYoHZRLWldmi/OIk3DxpnvULR3L/eItoa+5/PDklLxUVSaeTwhzs+e78SOndK/wsssgTtBQedCVeujaZ5PdKa7+ayFbgXNe/jfmD2uCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utiDtObYXnMyxIQRzsrv8VXL8mgAddqZsf6VodnDueg=;
 b=lRY5BKYQVcDnJeBFFxgHMy51tghDKPrn65O3q3RP9E9YTP6ywD1pFjlA9tjHiafFdvws3YL+QJqy+yus5ZwBBn/BgrThSEhN2StcTmWi1CdH8wn/wrS9TxIe70q7JVrBJSafL4OQIYwSnb+7alf3xiyBs4jGnBAkm2G5EtykDylYCH/zqBveIDfYmf4TdQ2+p9RU72ihZ/e3xnZ5W9irfTTatiCW1ZYePxcXvWXMKdNhcT4J/DvXxQzc796T56MPAw4CcioEwQOe/YZnEb5WZ41oU5zRmlj+FrOx+HDsQo+4YPO4zJf5Cl8GQdhDIbRtLWH/510UFaglKJZv5I942A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utiDtObYXnMyxIQRzsrv8VXL8mgAddqZsf6VodnDueg=;
 b=NtJvflrWJy7ND2WmXn3SBoIbLMrCa/g+UhOzXCRMW6Ono+saxoAuWZ7Z3gmplGsq9uPckjmUWK4edmYDonWJA1JH7AJHHXWLIYh9ze0srmoxM3UAoBiVXFluSVox0L7XUAvpppV/hNGX4R2CfeAoz70AipMuEapPxdTGiZKPSuA=
Received: from BL1P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::22)
 by CY8PR12MB7587.namprd12.prod.outlook.com (2603:10b6:930:9a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 15:27:40 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::33) by BL1P221CA0006.outlook.office365.com
 (2603:10b6:208:2c5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 15:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.16 via Frontend Transport; Thu, 27 Apr 2023 15:27:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 10:27:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/12] drm/amdgpu/gfx10: always restore kcq/kgq MQDs
Date: Thu, 27 Apr 2023 11:27:07 -0400
Message-ID: <20230427152709.7612-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427152709.7612-1-alexander.deucher@amd.com>
References: <20230427152709.7612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|CY8PR12MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e408dd-82ef-4022-3e77-08db4733efea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nc7sjSmLyTv5qloavi2iiNnLWL4LCMOgahS92tkAyxGGAYVrqiPEoAN90Q2i3Ph+xauc34PxRl/lUryWv5o+ZScFiozqi1LL62JejM478i8gLpT5G99rVJS5UL64n1pQR5cCYhYag1humhqu0si4LzfCpAB3KhPcPqe1klE1mt3G0yEGLCi2RguRSAEJsmlaXqxUx+2l8v5Ylp38Cp7tU1QvNTjvz4TQ6+PGO8KsHhMD19UKPOnkht7M/vcayXSiOov7vW+A6jNZF+3LJ91rX7bSP8IEg5rDc0vYUbvTop5WY+nCEnHDfRyTH5lK0ZZ/7GlnChcUiz4HJUXx2kDoLl+OHHhzgUkdZ7v2V1g5g7xcxsZqfQfxTJ3Ul7D+5qZsOIqun59NAmyrpYgAtKeBjxy9dlrARgLHZ6GIfHzi6uCvSmFnGiB1At2PfmzMJlO9Nq2pLhU+Paxc+3kRDXZ6P6MiW+nw6qvJstekxSKcOkKfkcmSTlobz3lWWLUhC7sprDDcy+2XgmvjOXFHLpX4xFsoa745BlEGsaglIT2uJ8jDfuSZW3sFEVsxTTD6N+tPK/5aDU1fnY8Ns7LszXzKDIBPl6KR15ZHc2N0lOCivkS4NkQk+oab+E5sYEXVIVd8fjKO8i2n9rayvFeXlPwdGRajYcpPILtDYQwv68SXAhFLQ5WuIA066bt2t14DU96ZEhK/wjmutLFuUqhx6EUmWpL268yP5QkqZCq4uVHebN4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(26005)(1076003)(82740400003)(81166007)(356005)(7696005)(70586007)(41300700001)(6916009)(86362001)(4326008)(478600001)(6666004)(316002)(40460700003)(70206006)(36756003)(47076005)(2616005)(83380400001)(36860700001)(8676002)(16526019)(186003)(40480700001)(5660300002)(8936002)(2906002)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:27:39.6598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e408dd-82ef-4022-3e77-08db4733efea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7587
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

Always restore the MQD not just when we do a reset.
This allows us to move the MQD to VRAM if we want.

v2: always reset ring pointer as well (Christian)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5c67c91c4297..2e0234b43f43 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6447,16 +6447,14 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
 		mutex_unlock(&adev->srbm_mutex);
 		if (adev->gfx.me.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
-	} else if (amdgpu_in_reset(adev)) {
-		/* reset mqd with the backup copy */
+	} else {
+		/* restore mqd with the backup copy */
 		if (adev->gfx.me.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset the ring */
 		ring->wptr = 0;
 		*ring->wptr_cpu_addr = 0;
 		amdgpu_ring_clear_ring(ring);
-	} else {
-		amdgpu_ring_clear_ring(ring);
 	}
 
 	return 0;
@@ -6780,17 +6778,14 @@ static int gfx_v10_0_kcq_init_queue(struct amdgpu_ring *ring)
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
-	} else if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
-		/* reset MQD to a clean status */
+	} else {
+		/* restore MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
-
 		/* reset ring buffer */
 		ring->wptr = 0;
 		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
-	} else {
-		amdgpu_ring_clear_ring(ring);
 	}
 
 	return 0;
-- 
2.40.0

