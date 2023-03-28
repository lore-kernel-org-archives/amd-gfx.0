Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51BDC6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5165510E92A;
	Tue, 28 Mar 2023 15:15:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD6D110E910
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqaw0PAqAAcMDiwVkbpxlQwOMavaBN4j4fl5aLDW6B4QPN4wwhgBGXajsYR5St2EUQUHPDYXBrWViWnb7y3ZO2aPWn1h2Q3w30+GRYRCJwOM4cxf14QxB8mMySm2MHx1FWmsiVZLYgJTOR4XDwdVZeXqgeqUI5pwx5YJRaJ1YuRd1730IyKwhAxl02WU65JvnowPRmh/eF5M6PrmNvsqew2BrLJcK+Agx6Elg43lewd5eZFnRl7+Vf0xwcvGFAvD2dhbcYMXLwzecmwvnoJpvZXwWlVwKGO2aAhLHzPHOGDvMiyP2b69aL1wptrEXoT9pALFkl7GbX3kDO/DZBbiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oikK3t1cqymA2LEDzXhg5cxG6o0qvrLUt7uGOEu5kz4=;
 b=oDgIt12VsSzJphejs63LrN29xYCL1Pgfx2GMi992wJuupqfiYhiQ/4VmstI7ehLDAhVa8d6kRQs5WnFZ2PAKRFmUF4cTfsmxu+Kdb09in/Hazi2IX9fB51cNvu6cp9Kp9cpzqkpKqi5vVHpKiD7VsLl2BYQphVPWvQ2JDGJVxUMD+pSOptNR4GOcTQLquXw45RenT7DJcmTNYiKiPhWaGkLM1RKcCvbaBOfd25rNe/l0SKNUoBFnTjSWGS0iSDehHxgeJPVyjAUystdSuehShQHGSfiMIpodZe3C0lSSqSNFY8b/bgH0QdtFeNMtdHIRxszt7meDwC0d2SbuRF6+uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oikK3t1cqymA2LEDzXhg5cxG6o0qvrLUt7uGOEu5kz4=;
 b=0iTUGp873YAWS4VhhcjGhQdxeXjReAWItMkce4UFhcNCYyDxJzqCKkb4CsjXNn4EbDxIEweP/Q+ONGdX1J9h9Rhh6Ca1siRVO1rD40vsPn3GxutCke1ZU4n0ji+mLa0PspNLvlzPvfjPSU2+Mol5p2eibaryP3wUyNutGidS70Y=
Received: from BL1PR13CA0074.namprd13.prod.outlook.com (2603:10b6:208:2b8::19)
 by SN7PR12MB7299.namprd12.prod.outlook.com (2603:10b6:806:2af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Tue, 28 Mar
 2023 15:14:44 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::a) by BL1PR13CA0074.outlook.office365.com
 (2603:10b6:208:2b8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/32] drm/amdgpu: Set XNACK per process on GC 9.4.3
Date: Tue, 28 Mar 2023 11:13:32 -0400
Message-ID: <20230328151344.1934291-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|SN7PR12MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ee7620-a8bc-4a73-4540-08db2f9f2957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hf8oA5HbiBAro5xJQ8v31rhAYvO6kE/WWkMulcoJNJi5TnUnXcr2Wxk3ck5RJe3Ly+iMoISsWE5wjLf7a+Us5CktasJgloyZ3/JwJPYdq7Y9XGzEEmDHjb9YtvflYQtkBpuHAFoTnRfCr3oYUXs9oMQ5JyiinccPynzCBDRELZgTK4QfOreGZT0HoJzGdMlLfKo9lgNcNIeh7LqHsb2D8aGVBok4EMDL7dmzW4CP4h2v6tCooMKImiwczFk/C/JGmEI5yl567N0FcooB76Vd3G5wblZuPbYzryuxvS3FtddzVFpgHLn/hmxV9vBV7wubnabNLovzbOmYMh6dfkU2iQSnKKQp3d2cHLTdIlXyQ8L5FGBWw32fKxSOuUbUgfj60c9oK4VrmCmvLzXeAwCnKNRLrc8jtkz82QmNGTVXVFxkF1eC90ScbJdBwleZYZQCd9mEL32ZK0kIVTTDueOF07CFPyOi5cqbsGBQVZWVpQdbWeQPu/eYTlEJ22uvBVhqhfmvcuS32y5geianhKlka4ZS78eNfWv3JyaLPaWnEYg0OZaLsrA83ry7/ecX+zvfRuaWE3kQO00fqTGNaa2nYhEiuVhKjzhLN4kDTrWeaJPhP4n2hbEnSoC0/XIs2yQGalrbybuLFNW0m/lanmnmI376mvpzQfsW6owijj1XGZEYV9BpGpR64h7jSWtzsY8zVTmts/e9e7Sj3VQ6hDMGweeK+0k338gjYHsM3cPtf/M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(54906003)(8676002)(70206006)(6916009)(4326008)(2906002)(16526019)(356005)(36756003)(41300700001)(8936002)(7696005)(186003)(316002)(82740400003)(336012)(82310400005)(26005)(86362001)(478600001)(6666004)(5660300002)(2616005)(1076003)(40460700003)(70586007)(81166007)(40480700001)(83380400001)(36860700001)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:44.2479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ee7620-a8bc-4a73-4540-08db2f9f2957
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299
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
Cc: Amber Lin <Amber.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Amber Lin <Amber.Lin@amd.com>

Set RETRY_PERMISSION_OR_INVALID_PAGE_FAULT bit in VM_CONTEXT1_CNTL
as well so XNACK can be enabled in the SQ per process.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index e5016fea1f28..d74621662311 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -328,13 +328,15 @@ static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
 					    PAGE_TABLE_BLOCK_SIZE,
 					    block_size);
 			/* Send no-retry XNACK on fault to suppress VM fault storm.
-			 * On Aldebaran, XNACK can be enabled in the SQ per-process.
+			 * On 9.4.2 and 9.4.3, XNACK can be enabled in
+			 * the SQ per-process.
 			 * Retry faults need to be enabled for that to work.
 			 */
 			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
 					    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
 					    !adev->gmc.noretry ||
-					    adev->asic_type == CHIP_ALDEBARAN);
+					    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2) ||
+					    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3));
 			WREG32_SOC15_OFFSET(GC, j, regVM_CONTEXT1_CNTL,
 					    i * hub->ctx_distance, tmp);
 			WREG32_SOC15_OFFSET(GC, j,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 9ec06f9db761..3883758b7993 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -288,7 +288,7 @@ static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
 				    PAGE_TABLE_BLOCK_SIZE,
 				    block_size);
-		/* On Aldebaran, XNACK can be enabled in the SQ per-process.
+		/* On 9.4.3, XNACK can be enabled in the SQ per-process.
 		 * Retry faults need to be enabled for that to work.
 		 */
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
-- 
2.39.2

