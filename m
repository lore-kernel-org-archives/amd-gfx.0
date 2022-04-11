Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B8CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 12:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B936010E4A6;
	Mon, 11 Apr 2022 12:42:34 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 072B510E52B
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 12:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYAQsWltcHda3jj2Zf+er/8UyZjhPmURTEfZ1h7Y+SmMzUgm3WP3Y51qAvBDYsXlybxnbJt+TKuhyqmTWI/CASDrExolUwT19l70hXHNfFtTsBauzw+ZTULITajhjw2nM8YvyMPvsgPzRzveHwGOm2M17BEIKqzFrJN3Tsrhv1qBv79MIfP0P+afFOMa+C2oeEsN2lbmNAMOy/YC8dI/xMBHN6+hDEY3Ul+pzUDoAdPB760gkDRkuythqk7pMfBT1UI39GuiHScEyDN/YBopukmR7+Pl7APxH3fMwz0pU9/QexQM0y4SYN8zwW5uBaRvfMh7eBMIQOvqNLdNIFusaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukPqwMYf7Vfw/vNKm6zIBJD7QZXlvi6AY+It9vNIgO4=;
 b=J5a4geMsTAQrDpVY8OyIIJ91jOp1FM0JqDQkiom6YYLxcPLLzyTQEIJEV+P6TmVXCobYYnMSTp2+020y5/LjzcE+aPQCPrOQVjYlxtzgPxnZzLRGpu3LOMIYLY1X8XZXWwJfzVvzsWNPkQosjUviXCxFNLE5m79CvRIyLmEopN4TR29e4QrJJedCz+iBVe2hdWzAnEk09u3KSoNdx26pJXz21y9JLTZ5chXb1FXFFkIncmqiKlsHCtlQxHmNOZGf9wyTdxZVejbKzKbVrpY8TLJ1EqexVEOV8SNVppflpx9S1Ny/vNRyIt83dCZ0t5be5AzLpf7Qod2NU4pROZu2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukPqwMYf7Vfw/vNKm6zIBJD7QZXlvi6AY+It9vNIgO4=;
 b=FihdSBY8L9nDAiM+hT9Jl7AOzm81EyggfX1sAnWXqnptC9HUUuHc6ZbV06vsZiepKMKsr1mfsc+a6dSQiWCBe6aMxAYkBDV83n+LshI+8Hp2aJIfbLX0tRd+ZM4gPz+Ai4b53dW0MPKICAYnLaqtnny9r3Ni9HJoN2vkYvcoXlY=
Received: from DS7PR03CA0268.namprd03.prod.outlook.com (2603:10b6:5:3b3::33)
 by DM6PR12MB3786.namprd12.prod.outlook.com (2603:10b6:5:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 12:42:32 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::58) by DS7PR03CA0268.outlook.office365.com
 (2603:10b6:5:3b3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 12:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 12:42:31 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 07:42:29 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Release memory when psp sw_init is failed
Date: Mon, 11 Apr 2022 20:42:06 +0800
Message-ID: <20220411124206.1348117-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc910bde-c866-4822-3651-08da1bb8bef3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3786:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB37868043FD64F27F4E938A92BCEA9@DM6PR12MB3786.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VtQywQkQrFf8jlnw1+gepLVan08BH0dd2r27cNvcDzY2OwQSmUpZxaOmvXLJ4cf3DpIHwDNCW6Yz5hvT6IIbY+pTBHDB/N31YbyIu/D9g/KJeudpctpkBrp8A+MPteIiLbfI6bXXMuuQxPqs7wxNGfohu+l7iIaJmwENaZLiY9tIFQtrPlB9A9bKQvbNT7zvSVdjIjTsJuukq1mxnD3/96EMGzsLr7WaKcAlU6vKC1d9NM4lbdSEtLcBfIQ4cNUPvRD8GUWDtquHUlPN1Uk78aynRjUehYWHu28a4jtPpBSE+QrUAK458eAmUB2ECu56ir6TmHUanoWclWCUm+08TcRArKsEa1GsOBo7Y4k5TxWdzmwaq3FdgPrzxdw1FCpkly26FY3iIF5hO01LIZqC4eMbOjIp6JD9Hepk/Np/UlLgh4AxNabfowP982PF1DhGNW2wyAr1OQjwKvM1chGg5/sy5K21iz5QKJSf70Tbqs8Jdb5D420rInNf6RE0vCxBFAMG/FwWpL2rbyHyL52+KJkbq+AI7FRVDYKHjtZQ8WoKyCAcI7IA0vy6KZAGeJpqqFh1xHhBDWXpG1lD/ZyyxEFMiqJkUnqTNIOfKJSGL55RijFMO9mtE/TroaweydbHBv4mB1XLc5SXHYyc5rhBWc29++OeKzmxDFKPhesQw0SrSVwDroin8wHGPnMGP58gHxqSdmt069AxllECOv0UtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70586007)(8936002)(5660300002)(36860700001)(70206006)(47076005)(82310400005)(1076003)(2616005)(16526019)(186003)(26005)(7696005)(336012)(6666004)(426003)(508600001)(36756003)(2906002)(40460700003)(54906003)(86362001)(83380400001)(356005)(4326008)(8676002)(81166007)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 12:42:31.6951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc910bde-c866-4822-3651-08da1bb8bef3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3786
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Release the memory (psp->cmd) when psp initialization is
failed in psp_sw_init

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Change-Id: I2f88b5919142d55dd7d3820a7da94823286db235
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a6acec1a6155..1227dc014c80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -305,9 +305,10 @@ static int psp_sw_init(void *handle)
 		ret = psp_init_sriov_microcode(psp);
 	else
 		ret = psp_init_microcode(psp);
+
 	if (ret) {
 		DRM_ERROR("Failed to load psp firmware!\n");
-		return ret;
+		goto failure;
 	}
 
 	adev->psp.xgmi_context.supports_extended_data =
@@ -339,25 +340,27 @@ static int psp_sw_init(void *handle)
 		ret = psp_memory_training_init(psp);
 		if (ret) {
 			DRM_ERROR("Failed to initialize memory training!\n");
-			return ret;
+			goto failure;
 		}
 
 		ret = psp_mem_training(psp, PSP_MEM_TRAIN_COLD_BOOT);
 		if (ret) {
 			DRM_ERROR("Failed to process memory training!\n");
-			return ret;
+			goto failure;
 		}
 	}
 
 	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 0) ||
 	    adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 7)) {
 		ret= psp_sysfs_init(adev);
-		if (ret) {
-			return ret;
-		}
+		if (ret)
+			goto failure;
 	}
 
 	return 0;
+failure:
+	kfree(psp->cmd);
+	return ret;
 }
 
 static int psp_sw_fini(void *handle)
-- 
2.25.1

