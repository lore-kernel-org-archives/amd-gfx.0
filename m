Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09128C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 16:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DD2510E386;
	Tue, 17 May 2022 16:29:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B3A910E386
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 16:29:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fu2qyMjwQdqjouy52PG7k79iH+KGZtgfFAVdAGGc8W6kMw8TPu1o1AU+eiMcZ0sCztD1t6MfGlpjnRSBg5Bl/kHgAK0ujC92vsGqjHarzzYTctTHNAiYL45bGxCi81UPKOWJLFXgiPYM6REOOkXyVTZQ5XCRyqUn1uSb6og7yn6CI+JCtHUn8pon+8YGiG9c0n1rkFmT/unEjO0Q5OoAs1CMml+zOW8kk155o5kG/NuwknK+x32uTMaklE4ZqsqFNymUveUobs5+AGGJ0MfZ79aG8gUdCxqJOIWwGa+kddnMRlTcuYHLxIDESmh+As0AzKiiWofBx4hcT1bIMa6Iuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNHrPfP38HRN7EeCXywooEMbmFGaFJ1aFnc8oZGHQEo=;
 b=EEP9rYZaqnJSxa9b/Cba1vAr+KExXYttT4W7z6THMuhDyqaQWj2rRGhWt0Jr7II4TiHcyzCGQ/timWzWzhfl0HcOSgc5SZJHAvWuxuZ6H/0F56hFeZBVlI4aQdUClhgFBg+V7j+zPndPFtFoCOz/zZ9wOf07gkjPz8BSfAYAyTpuMbz2Uz1UoKAwyYz0qXOpWSojsq/pw0Wail0iirEZLeDiLHwbatrTbZRs15to2vKPLOtHhnmPn/+Zg11DZDeI7QxCBFys0x+5oldDFJx2QCXRhjYHsMTdmNpKvuGhRypHwr6URt8lWcfFhYY1jJPE1gGHPx/guPq46uISy8ULYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNHrPfP38HRN7EeCXywooEMbmFGaFJ1aFnc8oZGHQEo=;
 b=PA9JZuydM+DFCuPzC4zBHvQcA8RxrYlFD/7iB+0pO8nCAuYEqQyRd/PrxQvyqGD8MYgKpmv8m4VLlxh4ET4Azwv0Vbjgj1uxp9ZjunvWt1CteM6SW+tt6L2rqH/7upLksOXVTkXLf4TmmSA2AnRfxNHz0Cuab+KX1CrFummTMH4=
Received: from DM6PR07CA0076.namprd07.prod.outlook.com (2603:10b6:5:337::9) by
 BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 16:29:25 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::16) by DM6PR07CA0076.outlook.office365.com
 (2603:10b6:5:337::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15 via Frontend
 Transport; Tue, 17 May 2022 16:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 16:29:24 +0000
Received: from ETHANOL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 11:29:22 -0500
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: change code name to ip version for tmz set
Date: Tue, 17 May 2022 21:58:53 +0530
Message-ID: <20220517162854.1017207-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517162854.1017207-1-sunil.khatri@amd.com>
References: <20220517162854.1017207-1-sunil.khatri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ec94f04-75d3-43e9-d910-08da382267c8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5825:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB58250C77433855B413C2267393CE9@BL1PR12MB5825.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/FlZeruRcL5Fg+P8XKKr2URCYFmdrDg3mPrTdSSIncsJPJuwfFmgyPdGzgUIzboxjM/GNpIrPKXCDu1jEFUIfGYo5J64YecTvaE2AnIBGIccLOZTfyQ36tLQZicIr0qOo2hlnoYxRyYh8GoKr+Bazs/Na033RcKGFtmJv4S+PSnEwvFtH6eOPh45128AiYv20NV8Ryk3Ul49v1nOpkNZV/gpinjxnqYvSIW6EWIn3XPhfXaTrxS5Hr+CJW2HR6be4xOZ0v2NEaYMreB6xlnBFQWVwPZx2K6OMrxkQ5sRrzLiBXNM7Tph00WIrIPHs1IY6JEY8zCExe6DQa/ELDP6MAOaRWvCtm/5oCAnlzcJikK9M2n/5oNBls1LzG1D+UOv2XWmIezKKHf8YVHwl3BfpSJxAXJH+7eVm2d+Tl5pveHiP4za5q3WsKWpM5ZJbdGtWDrJHLbgXCzWmUXYH9OKv+pdLzrJ1PepTvLGgtIVvYKWpmpuNw/L0GQisVCEaqOneaEobgObEo6n5ghevi75biBBD0YtRz3wwDxa9O/VDUJxBfIuvLA2h83xC34ANT5WYc5w/G5QHcf42oNRi462AD+JlQUL3xPcagI/ibOqoZBwV2mzortGl+LHEsrbwL4hM8qhVGl8+rGHaQrKtx2ZMqeij9DrG1CTwAmuH+9s+BCvIb6Btw5feyNPvgfx+06arrHsbhW+LSImWmbrgnEGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(5660300002)(6636002)(70586007)(40460700003)(26005)(54906003)(82310400005)(110136005)(8936002)(70206006)(47076005)(44832011)(356005)(1076003)(16526019)(186003)(81166007)(86362001)(83380400001)(336012)(2616005)(4326008)(316002)(8676002)(2906002)(7696005)(6666004)(36860700001)(426003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 16:29:24.6512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec94f04-75d3-43e9-d910-08da382267c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825
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
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use IP version rather then code name of IPs for
tmz set.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 27 ++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 88b852b3a2cb..7e55ee61f84c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -512,9 +512,12 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
  */
 void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_RAVEN:
-	case CHIP_RENOIR:
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	/* RAVEN */
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 1, 0):
+	/* RENOIR looks like RAVEN */
+	case IP_VERSION(9, 3, 0):
 		if (amdgpu_tmz == 0) {
 			adev->gmc.tmz_enabled = false;
 			dev_info(adev->dev,
@@ -525,12 +528,18 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 				 "Trusted Memory Zone (TMZ) feature enabled\n");
 		}
 		break;
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_NAVI12:
-	case CHIP_VANGOGH:
-	case CHIP_YELLOW_CARP:
-	case CHIP_IP_DISCOVERY:
+	case IP_VERSION(10, 1, 10):
+	case IP_VERSION(10, 1, 1):
+	case IP_VERSION(10, 1, 2):
+	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 3, 0):
+	case IP_VERSION(10, 3, 2):
+	case IP_VERSION(10, 3, 4):
+	case IP_VERSION(10, 3, 5):
+	/* VANGOGH */
+	case IP_VERSION(10, 3, 1):
+	/* YELLOW_CARP*/
+	case IP_VERSION(10, 3, 3):
 		/* Don't enable it by default yet.
 		 */
 		if (amdgpu_tmz < 1) {
-- 
2.25.1

