Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C39CD98ED
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 20:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 113E210E282;
	Thu, 18 Jun 2026 20:46:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bn/PUEi3";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010066.outbound.protection.outlook.com
 [40.93.198.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D092710E282
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 20:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNJ7aFwstycBoe0p7xHZ3D1A9AcGRk6dEJZmr5LsOfEPSZpPObw+gu0q0Fsa6xeTWstPV3SXNHu9pex1Q4FtdU8n3WNzRuCEUDXTe2mSXVCyp7bDPi/ImzRtCD4Cbuksd3oqU1JtXNOBaJ9bbX3fYMichRNWCQE1S5Dfq34IcRlICbo79Nhdx9f0g8O1yHhXOz4XnVAvvdY2a22tdQGUVsaoXsFo+vMBHoATKFBIlNfycJA6UoYwiGDwOjy3KmF6ovLIxD6umb7xZEm3QYKCfil3gqikct4b9cE8Yw+ZFlkkCEmDRcvcOPAWID56HSf9EFcU5faMUnSxHWagMlyYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLrmi0wsDA+6PoBPck+rNLY8MC+gFjCAOUEkqAD35Bs=;
 b=qTBsGQ74Tx9HHigaUy6y4O/Rh7TkrCxKGmh3zxC2jfxa7Xb8Lsdnv3+qLWB/3QzzhzBKVLQr/251JN+g4Jhzm6pg261Bw01zqXRdr+XQpacWUSUkx0FZSfCZT9KJzbRXxZqzoCCj5fHJau6yo0/1oUs6DgwvJUik9Why+p4WyIlC9OHO/X6AphVTN1wcRZvG/iqYz5t3EbxznDxEtSVmkwGyq/enymYAo8LPR3hj7t1INPYz7UzWCuwp4Vvx24/8pO4RqZWMgwjSttdv7SmRkYkIkqp87O9Y267+NVfICm6FttxioBJSX6E2JVCa42S+GmXOEG4vp2LTG8UHfI8MCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLrmi0wsDA+6PoBPck+rNLY8MC+gFjCAOUEkqAD35Bs=;
 b=bn/PUEi3ous0kmTKL0/kO9ka0I03YOGboDVL2cBYklTjOiySVdfhmPrDsfFEhkNVisw8zUWG4zcGyOC21C0fbMgPhJyqdN+DpJ5dq2OEe+GvjAZvqvwB7r4vGz6Zmoi04cc+Zp75YoWwNKkWsv2+jBay/A8+2CdZRCXPfv5O4JY=
Received: from DS7P221CA0038.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25e::19) by
 CH1PPF12253E83C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::606)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 20:46:02 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:25e:cafe::98) by DS7P221CA0038.outlook.office365.com
 (2603:10b6:8:25e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Thu,
 18 Jun 2026 20:46:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 20:46:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 15:46:01 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 18 Jun 2026 15:46:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: update mmhub 4.2.0 client list
Date: Thu, 18 Jun 2026 16:45:50 -0400
Message-ID: <20260618204550.753250-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618204550.753250-1-alexander.deucher@amd.com>
References: <20260618204550.753250-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|CH1PPF12253E83C:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa91158-bd56-4b0a-7d35-08decd7a9c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 6k0AOQy13GepfqjZEO0LjxJQAFGppTrjXtCCj2JptVK68+8JbaO6QmWSyjeBTHVdNNvEaFO3rCfT2A5W+SPo8/DBsMWu69JF6BWuZU2FRQYYG2iQwDNpfWA1xTijlp6pZ/r0V1iLML+RvvDiWykxcEGwHdoPjZ5yco51Q2aYJmH92QUG01oacwjNYLzJpQ9N8JWc/KtBY+4LTmH5QU0mJ+H/Ci4DhfEpcN+6n5MKif0E89G1Yi3/dx4uTcA1SMWDz4BuHBkzZdY4oZ1rz15N9hScqyIjZRdBG/Jwg3O/140v7UBHrIxzR23UzTdIys3Byjo/GOKzRy28O7T7Plg9cqB4C3SO3NKZATDl2/KIDHKjaLV+9R8rqLt5V+wyTg94AlfYs4h13w6OKZbajzKeglWLVvG/fMivw8b4tFccFhwVkEbMN6+DsUYbcr+YSWgAoM3ZpRFlihm3je8QmqUCNgTPHeV3qP5tfSziik6XAj294m/Ynht0mlqmPiSFAkYdipUZdGb0w5j0kM32C/fibEH72N052qmyqmbavaAD+WtKwdFg8lZBaSypqhdymixhm2tcGy/XR0cYzYM46PgJZWBU4XnLi2NC6i+KTOyrLyMP8zsWypnvLDwrpK2sfmaZk9UHxKwjnQIFaKmuu6Q+qgizTYFMIgbscKrPRLz8ZDTmA2BHqHBKwo/UuCTa9ksXobFWvf+bEuak4uGYrf6JGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sA/9Do9AByopNIy+A2DzqhXo8EakqsaJog9u+wkX5bvFKmWnDvLjSRJ5k9tImUxaNO100dJ3cV50Sic0iGyJCLxFWNksG2tvQwwq7tChNIgA0EcDLnjXS6AFzrO/Q3PP6OIWK+AOFLmVtXY0+iAV5D3V+19+sEDRcz8DimHwHDg14nB/KW4IoXP3MsixSzbkX83oMb4Y4Eni6tfFaWEgJ2wMKwptZjOfOSO3DKKEPUZeZJBGglI+e08qHJ2fu/600YQc+V+23zYtKeY0f6Bd/TYDgTYVVEjs61fzTIOXrw9KhSf24snKixAYS9bURI81+GGrqWLY3G6d90fTao/4JOe+BC2AdANjjxSxoKHOD/EaIeehhRwo+RdU5j9NEBgIYDlzruL9G1QuWPDbvEQPixN0TaIUV2mzdTeHTf2dubsBIknqI3mcTFiYx5J+UUhr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 20:46:02.1033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa91158-bd56-4b0a-7d35-08decd7a9c1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF12253E83C
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

Update to the proper client list for mmhub 4.2.0.

v2: fix typo (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 65 ++++++++++++-----------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index 49b7f16a941f6..5827c758b373d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -36,40 +36,41 @@
 
 static const char *mmhub_client_ids_v4_2_0[][2] = {
 	[0][0] = "VMC",
-	[4][0] = "DCEDMC",
-	[5][0] = "DCEVGA",
-	[6][0] = "MP0",
-	[7][0] = "MP1",
+	[2][0] = "MPNHT",
+	[7][0] = "MPIFOE",
 	[8][0] = "MPIO",
-	[16][0] = "HDP",
-	[17][0] = "LSDMA",
-	[18][0] = "JPEG",
-	[19][0] = "VCNU0",
-	[21][0] = "VSCH",
-	[22][0] = "VCNU1",
-	[23][0] = "VCN1",
-	[32+20][0] = "VCN0",
-	[2][1] = "DBGUNBIO",
-	[3][1] = "DCEDWB",
-	[4][1] = "DCEDMC",
-	[5][1] = "DCEVGA",
-	[6][1] = "MP0",
-	[7][1] = "MP1",
+	[11][0] = "JPEG0",
+	[12][0] = "VCN0",
+	[13][0] = "VCNU0",
+	[14][0] = "VSCH0",
+	[15][0] = "LSDMA",
+	[32+5][0] = "MPRAS",
+	[32+6][0] = "MP1",
+	[32+7][0] = "MP0",
+	[32+11][0] = "JPEG1",
+	[32+12][0] = "VCN1",
+	[32+13][0] = "VCNU1",
+	[32+14][0] = "VSCH1",
+	[2][1] = "MPNHT",
+	[3][1] = "DBGU0",
+	[7][1] = "MPIFOE",
 	[8][1] = "MPIO",
-	[10][1] = "DBGU0",
-	[11][1] = "DBGU1",
-	[12][1] = "DBGU2",
-	[13][1] = "DBGU3",
-	[14][1] = "XDP",
-	[15][1] = "OSSSYS",
-	[16][1] = "HDP",
-	[17][1] = "LSDMA",
-	[18][1] = "JPEG",
-	[19][1] = "VCNU0",
-	[20][1] = "VCN0",
-	[21][1] = "VSCH",
-	[22][1] = "VCNU1",
-	[23][1] = "VCN1",
+	[10][1] = "UTCL2_NHT",
+	[11][1] = "JPEG0",
+	[12][1] = "VCN0",
+	[13][1] = "VCNU0",
+	[14][1] = "VSCH0",
+	[15][1] = "LSDMA",
+	[32+3][1] = "DBGU1",
+	[32+4][1] = "DBGU2",
+	[32+5][1] = "MPRAS",
+	[32+6][1] = "MP1",
+	[32+7][1] = "MP0",
+	[32+8][1] = "IH",
+	[32+11][1] = "JPEG1",
+	[32+12][1] = "VCN1",
+	[32+13][1] = "VCNU1",
+	[32+14][1] = "VSCH1",
 };
 
 static int mmhub_v4_2_0_get_xgmi_info(struct amdgpu_device *adev)
-- 
2.54.0

