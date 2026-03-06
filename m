Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B5DFCC050
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 17:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B482610EDD3;
	Fri,  6 Mar 2026 17:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B26GKTOG";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82D8210E0E0
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 17:24:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQ6pY7KDyF4IubtQvQSeZzyMHJGL+8U4t0L6UPFKJyfBWOYHLvwl0Y/bkWiEzGVxn91SxQqHMVAX2rQbt765e41J0VjqU9awfWegDGMxQUWIANcoBiUCxLCmYJh30QaJ29tk4aeMYIolD/z1b+03MHZUQONcQG5xeg3Mh0jSGXlumj9Zt7Lv++QeNvJaRVO0dNjgOZjY57pnxeygmZZt4U8DjGLsGANe3ndnX+NKau5GM/aJS6maci9L3Fec8AWAe4xHyvVGb2RgyQYkO48XjgZyrqV470kO5z6QADOxnk/6oqzcWVWcNLLVJqC4kVoirkzv2tQHzaUIywO2cS2hTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsoPCyCTs2EeZBOURDz98bnd5Xe1BYKNo/ZiRi8K+lc=;
 b=etRPyHfGf62HqkNMmvf6LRSd77qkgfJKNpv+Qde71f3wPcjhlBSOGd6ZzrDiXanjNE1bzf3SSScExAUUPsUHth+Q4kxpDNf5lVmsAT1z72K+OEbshTzrhNT9KRqFtQ89GwY0OnRhLNNFlW4dW11mQ5qxerrq+gWn6ARjJBvrjWzoawtraKoyrZzW0vcjPETOlis2AlUXIx3BQfo07hZicen/fIymGiVtq7LnpncW0op6ASbRexTevXH5rDN95VCRO1CaOU/wteJWNI8AK7XKql5bejtFdytyCWgFz6pe6AeJzWlLUzlhDWku/FU8EqwQurZ+lfHsTHNKIsZRAhLutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsoPCyCTs2EeZBOURDz98bnd5Xe1BYKNo/ZiRi8K+lc=;
 b=B26GKTOG18RicPynNpy2GGZ2x6nZazpIb9B3S5JuWrUR2Nr1c6Q6a1ZBqz+zMELJ2ykhuKmONAq5A6WVM/lSTEm0JF6G3tiTSoDkwqaVItrqZidK8Prf6IO75P741+rxX7VrY7wHZwa0a2WaJ1bMSgzyEIcrWrdAoKYTbltn6MY=
Received: from BL1P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::14)
 by CY1PR12MB9558.namprd12.prod.outlook.com (2603:10b6:930:fe::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 17:24:27 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:2c4:cafe::d4) by BL1P223CA0009.outlook.office365.com
 (2603:10b6:208:2c4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 17:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 17:24:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 11:24:26 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 11:24:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/9] drm/amdgpu/sdma_4.0: set SEM_WAIT_FAIL_TIMER_CNTL to a
 non-0 value
Date: Fri, 6 Mar 2026 12:24:13 -0500
Message-ID: <20260306172417.325169-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306172417.325169-1-alexander.deucher@amd.com>
References: <20260306172417.325169-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|CY1PR12MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4f02df-0e74-4b51-78ae-08de7ba53834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: VCCCRjWuNnNvwaNTHtPUZ9VqLC73pRe7qPhiyEdtuvY7vTDDGo7idQa66GE36sGKwEJtiSZiayLT+Dc61nsg4Q2wxQtE9ligK4cTGml2X59Tc/6RpsaE3+ubfNtM402Tjfo8fwZMjX/t+RiIyZSeEPMa/VF1sFa8YmiZtC6R9d0lPsirv8JBYijs6Y10giURQLkG/czN4hp8Ho0ioV5NTPOFhcVWMttWtYDhEMotJggNB+XRpRpzrwaBTulrzU23Y+vDwe21xzsl08bEUxsDVndr9oP9aTrtK2yC3vcYCt6OIT7zhK6i7l7TW971+AxPi2LFFc8upQV4X3S0llojaK6Wq8531fIj6PYBOnesamq6VrLE/kgGePwXi/v7VCKiIJZow84PJW4MfJGd+yOIVLEE9LGYygWidsAyvLVhhkN/LfqeNNT9ndUCSNXOycLGPISkj4U9BVswNNR2i4+odMlpI2ZX/vaplBnS7icm7Pr/Dlfuqrtl9r4Lw0k13uOFDwVurPAu2PM7jpah0XK4WtRSbr6vr3LpRStJaacvX2pu/vLsT+dUS8iWBqHVyHI73PQfx18+PzsP4H7Uhm6DHp4yfYv+idpdRtzzKqo4mmxvrP2P5giLZ6iGzyCJi+k1XwdYwYOETICBheL3WFxhuAtG5OS2b5X4HxePVNp1wyUWTx2ZmKyrNLMKCqSkC67bjX/VETJ/zP3c2xlVM7tG4ogH3/ucBRjA6DvcCF4Ph8o49zS+qjngW+MErjnlCNV5CoOLGmny09HAx4mA02bPRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8p8o9uy/2wY8RXn/vtm2NaT3Oz3tD270+cLVOHl2U7nTjNwH7K+HCQ7UE6ITQJtOFcilRFDp80wsOriOLW5yue+XRPhxl54WjU7JTsE5xiGEUTAGErP6JbECnUwwOI9kJpADTPkBcmrZ/uFWP8suUxVS1Fdien82w/2r+GMWqPFWWthiqrGt7I/vRLPyOTKibmuZZBFvYqlH7yg6w3e5y2l5ma3IDjATVPuv3HL+Ef4pkQ1ka8lPLfoQ5liQVovSqAqkJaKGzFErNEkvWfP4nbKKpMDwnWGwEcpU5tzoaGqnKhEERXIueRBiq83xItZE7Y08xqj2SKQGKjpQveN5w0uPDOmoe9uamZK0nW76gFDokK4uHI0pEibwAQLnrA9Or8ATyI4uRphlUHQqi56r3JGiN50gYGG4r9Rvneh2I4qJeKH3fkwVZikePngdYPgP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 17:24:27.5536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4f02df-0e74-4b51-78ae-08de7ba53834
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9558
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

0 waits forever.  We don't actually use the HW semaphore anymore,
but if someone uses the packet, set a time out value so we
eventually time out and avoid a potential queue or GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 44f0f23e11484..f3aad579085ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1404,7 +1404,7 @@ static int sdma_v4_0_start(struct amdgpu_device *adev)
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		uint32_t temp;
 
-		WREG32_SDMA(i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL, 0);
+		WREG32_SDMA(i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL, 10);
 		sdma_v4_0_gfx_resume(adev, i);
 		if (adev->sdma.has_page_queue)
 			sdma_v4_0_page_resume(adev, i);
-- 
2.53.0

