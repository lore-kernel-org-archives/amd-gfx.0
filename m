Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3164EB64D8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 17:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB86010E165;
	Tue, 20 Jun 2023 17:16:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D1A310E0A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 17:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZAOWUe6gh8PABxY3EmRfpqFT7nlBc+/Witc2Kvrnlg5OqTJzyCNBhXo08T48/sRt+8bN5fJPYBT15EnRxGNGXTiWnIweRon6ZM2mEb9jb9k09MYctZPwiOolPzI8RICNJM3tSvGlj3KhM0ENll6wCm0KayCGNFl5iHuIvf8Y4OjmwQY0fVvveUvg60Ka4EBmdTyqoQUz20ulJlrOG+de54AdcDg/NB7L4vZ9xgT4gDSyqLMYKPDKTG+tzGjVIgLaActso+zW2lT+2KN6tDDkkIK+f1bL9TQimx/c4LVCxTq3hHmPIdDdRu/XX2ly9uKoAxRE2NfBXLoFt/WivgcPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YdCvxkbRd00sumUkv9aWQ0NdqB+hsAfGKbPlGj0bEE=;
 b=ByKDXjvgasE+JR/pNQqt4EFA3w7DHJoQKmKgy6zKGD37Y4Y1W6553EeugKjj9cFjtMVZ9YpPfWlT3h20L0Taz+c3Bx5yQ3h7PS0/fQu/ech10l/+4rioqx3QrSfUkmeEpoPYBkttXzymLkuyVk6DsZaVMgYhmvf1J7yLJHIyzq+Ct7feQM6dGN/5r8XEF2HznYTN2a/b3eHRgpGt4a7kXSWI6687a7ltW+1n1m1gVMBjsLb0QivgDW4q80xk4A0p6ZciK1EZuymaybG29MRYzScRiRnedXFXwA52fQ56dnr68LVo0C1iGhAdDsuEbj8qUWdZK2fN2S5tAEaz6L2J6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YdCvxkbRd00sumUkv9aWQ0NdqB+hsAfGKbPlGj0bEE=;
 b=GlwYdkjs/zOPKy/BKKsQ0YK6J7UzrR/TgPeKVnx8soPibuI7sCpFPiNYPEFJ7X+CUEVxxokj6293S2PRaVq8XqJWQ1APALmR2vg2tNEV+sSDE+iDCVLB8/BqL88AMJkbWhBOxQ82GPRa1B5w5x0AjpLH3l7vBtseTMI8xCVpesM=
Received: from BYAPR07CA0072.namprd07.prod.outlook.com (2603:10b6:a03:60::49)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 17:16:29 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:60:cafe::73) by BYAPR07CA0072.outlook.office365.com
 (2603:10b6:a03:60::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 17:16:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 17:16:28 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 12:16:25 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 02/12] drm/amdgpu: don't modify num_doorbells for mes
Date: Tue, 20 Jun 2023 19:15:58 +0200
Message-ID: <20230620171608.2131-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230620171608.2131-1-shashank.sharma@amd.com>
References: <20230620171608.2131-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 20facc10-fae0-4406-892d-08db71b215e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mm8yThRKDTxwUoEuWFb1dLJAEtW6jFnBYjskgoQhoUI6JfOx7KUFADqdiG87QblusNGQdcBEuriHXo0JRax8dFN4i4BWLErIn9FPO0V4Pdy4nBw8gkay6c33CY6lTQqqT19OgTUys/WbEZKY7Yvsk51C75j7MCyFHG3nrpkqOzNUlN9H4RQ0Oj32sBdzCM44XANqKGeEqMakVGnxYIJ2Dn2PcUr5uSQstOE0zwqHg4Of5WzRJitXIGdSoIQiC/h0ZMz07becIPOgJS4ngakyaG2MTWN4V8hxe/2h8a/4PM376B484vHkDUg74sC4TTy45mKkfpsPhcElD4yqEjLu9YBt3b2+9WZ9JYBfxQB+jPXg2vSKU4ECy2oEfPiPziFUIRb5m1jpgJJLS6Dzs6/ygtzLD5YbMSMrgjgATXu7OWcCrDRA7Crr8tThuapkaIcwIgqMUjw/5Hr1QEfJ3xTGH6Hx53FtG5go5KELxdCMGpxR58fgwIDKKHTJUTUErrAL8xkR3bp90vbL+hbZWF/odK1HUPSVDAGkgcpRPLImkU+DkvGYv5+5F1fNmXaXZ8StHMbxqEUagwe6sLELSCiFax/hfDMTM6IXkie6wB1aN0y2l+magRxgbZGVDQHSlR5TiwZQCm/myOALvvrWoWJpw8AWjgyYYQUUkRJEbALDqssbamIihYtqjhdXsuACclKMOZSkygu7dl6DqcO95NDK7TT1Rod2XHMk/z8MS6qgqgFgs1CcKqmNDojCj36E8cg7CLnF1eE0xA8CoG026BzuUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(7696005)(6666004)(478600001)(47076005)(16526019)(186003)(1076003)(83380400001)(26005)(336012)(426003)(2616005)(36756003)(82310400005)(86362001)(82740400003)(356005)(81166007)(40480700001)(36860700001)(8676002)(8936002)(41300700001)(5660300002)(316002)(4326008)(2906002)(70586007)(6916009)(44832011)(70206006)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:16:28.7586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20facc10-fae0-4406-892d-08db71b215e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch removes the check and change in num_kernel_doorbells
for MES, which is not being used anywhere by MES code.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian Koenig <christian.koenig@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 34 ++++++++-----------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index 31db526d4921..eb113e38f5e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -140,25 +140,21 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
 	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
 	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
 
-	if (adev->enable_mes) {
-		adev->doorbell.num_kernel_doorbells =
-			adev->doorbell.size / sizeof(u32);
-	} else {
-		adev->doorbell.num_kernel_doorbells =
-			min_t(u32, adev->doorbell.size / sizeof(u32),
-			      adev->doorbell_index.max_assignment+1);
-		if (adev->doorbell.num_kernel_doorbells == 0)
-			return -EINVAL;
-
-		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
-		 * paging queue doorbell use the second page. The
-		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
-		 * doorbells are in the first page. So with paging queue enabled,
-		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
-		 */
-		if (adev->asic_type >= CHIP_VEGA10)
-			adev->doorbell.num_kernel_doorbells += 0x400;
-	}
+	adev->doorbell.num_kernel_doorbells =
+		min_t(u32, adev->doorbell.size / sizeof(u32),
+				adev->doorbell_index.max_assignment+1);
+	if (adev->doorbell.num_kernel_doorbells == 0)
+		return -EINVAL;
+
+	/*
+	 * For Vega, reserve and map two pages on doorbell BAR since SDMA
+	 * paging queue doorbell use the second page. The
+	 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
+	 * doorbells are in the first page. So with paging queue enabled,
+	 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
+	 */
+	if (adev->asic_type >= CHIP_VEGA10)
+		adev->doorbell.num_kernel_doorbells += 0x400;
 
 	adev->doorbell.ptr = ioremap(adev->doorbell.base,
 				     adev->doorbell.num_kernel_doorbells *
-- 
2.40.1

