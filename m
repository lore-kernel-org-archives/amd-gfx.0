Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73847CE79A2
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 19:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9DE510E320;
	Mon, 25 Sep 2023 19:52:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B43E10E321
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 19:52:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIngWIHPvQW49q5H1d2clYAYI/wy2ViVpRAeUvBMXn/ABI3WX9RiY6hRoL2TMFNo0A8ydO10yH1wP5cMWEDGGMpgaoRgdGLXf+aUtQINPK493EJbmpkpJSAFBJkoOWBF9LEq6NA1pjiSHaxystmGoNKHxNLVdx7hFoVM8r5bgSJLPD0Z8/EzY/AszbpLO/bwgdft7OiEXGRGERt3WT8mgCietoDY07AeqMlJZG87+9R4PnxXsJQzLX1gcJzsmxmwE+Dj8Vm77BdiokkKeStZiFlKFT7CT+Kqzz7wAE3QzAx+p6xmMZcU8TtoEcgbLj0feljFdcky4+27oc83LKxviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpoP/cTdwMs4v6DurPENMbyOxSLhp0oVmEslBGy4CUQ=;
 b=d4PL0z4fwvINCPzDC0h8CyJi0myT41YY2wa8itAIYApSwQnZDlFiYjVI9O0Qlf5GZwj+2TjUVYR1jBCl72qX83L5PZ4seXjGroVlceafQolMoKAE7qgTo62D2KP3R9VUCYKZj3vYHHtQmb1FOvSWL5crPTPryiOkeu3JX4who0DhP8822OETUdy7V6EpMB3kP/Co3iw6LAjQWSxQ/DnoTa9NqWHXajIJTvXZfSEKPuzbGCsn+2VnBBNN+FxZJ47rK4wzkX1zZsQbJWoRuzGnw2dz+Avl1PD1rrRFKLwIWjdHLUa1Auo+vETof17LkewpKJffjZ9WcYTPkYrqfEQaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpoP/cTdwMs4v6DurPENMbyOxSLhp0oVmEslBGy4CUQ=;
 b=CEV+qCJVPm9iRgimV4nSmzAI6N1oQcnaxG4NeW8sRyrVYYNbxtXkY2zfMOrd3SbFEppK9NRMEwxguJkclhU6oRBXijzOqMmFNA/GJI2DBklABzGwlHzVhfeRLbcEyl70GDJyI4jPfgdiySumgg7haW33vUI/N2MeUyVBSrR7F/A=
Received: from BY5PR17CA0059.namprd17.prod.outlook.com (2603:10b6:a03:167::36)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 19:52:51 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::1a) by BY5PR17CA0059.outlook.office365.com
 (2603:10b6:a03:167::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 19:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 19:52:50 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 14:52:42 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] drm/amd: Move microcode init from sw_init to early_init
 for SDMA v3.0
Date: Mon, 25 Sep 2023 14:52:05 -0500
Message-ID: <20230925195207.124850-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925195207.124850-1-mario.limonciello@amd.com>
References: <20230925195207.124850-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8f9849-a2b2-410f-9685-08dbbe010013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /yRTS2mryT/1sQaU5kDftUmmyNUrC5ullQ7wGrtnAkQwWnFu2L729zHSyWoHCpPiLeTlo5pfAxLOYKjtnJ0v9EYX9qbTYDvWKdrQYY3UnuEzxibbYw8UDqNRftHzRCTR4Nvs1gBGBeZ4ZcdJtj88X1R9Rp7/tALDNSuBCP8zimBSY2u6UYn6UJnxoDFg9IRZOT20AIcJ9dN2yZVxlFVIISD/McvCsD5JLJP/kdS+98qYHshwkuUv9ZGdikP3eg4q6WGCPK+0ZIDrT1/bnaeXMDttV/Upd7jWJrW5NRboNeD7xr1M5TrqMxrDmtvhu2CAXBv+Zu/Ql3iylRGfK2L9BEyXcjGKyV5STSmW60GzC9mK/iGwt41c6dVT2lJ5DMF1FQBNYGwAe/t/6CSMfoDw78KP57OKAcJ2bTmOw2T0Zq5KwAtHkSx49cZo8h12icPxg7iZ3QeXS7tGmIlG9PO2R/+17WFGb5nCP/3Iu3sEorNCSkOBl4whe9zxSXrV7rNzo8bcrp72pvk4CBa+TfxbnSIBBL88oAS2F432j9jSD5d3CGpRAFdtdfwyN2wReMcm0/Xlcpg41So3fmAlBM+1en1cvxhN/a4wPL1POJx3q9LmkjFeUBhjtnTA8uoTMXRQ36YFvdUYC/JIYeqK8E8LspxK0JqoaI3ivFi+Cuv+1aUqFz/dhosgDFzKh6yD/Dk0Q1NQhRlFiqoquSpaAKfqQSGAbIvSHyPzFe3CCCCbimnEEoTIsk4YD4RBuspvtUpdQsQlCxBrzXrhcV4bvsGZgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(40470700004)(7696005)(70206006)(26005)(16526019)(70586007)(40460700003)(6916009)(316002)(36756003)(1076003)(81166007)(478600001)(41300700001)(40480700001)(2616005)(6666004)(2906002)(356005)(82740400003)(83380400001)(47076005)(36860700001)(4326008)(44832011)(8676002)(426003)(336012)(8936002)(86362001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 19:52:50.6241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8f9849-a2b2-410f-9685-08dbbe010013
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As part of IP discovery early_init is run for all HW IP blocks.
During this phase all firmware is supposed to be identified that may
be missing so that the driver can avoid releasing resources used by
the EFI framebuffer or simpledrm until the last possible moment.

Move microcode loading from sw_init to early_init.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index dc7aab68ed66..c5ea32687eb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1087,6 +1087,7 @@ static void sdma_v3_0_ring_emit_wreg(struct amdgpu_ring *ring,
 static int sdma_v3_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
 
 	switch (adev->asic_type) {
 	case CHIP_STONEY:
@@ -1097,6 +1098,10 @@ static int sdma_v3_0_early_init(void *handle)
 		break;
 	}
 
+	r = sdma_v3_0_init_microcode(adev);
+	if (r)
+		return r;
+
 	sdma_v3_0_set_ring_funcs(adev);
 	sdma_v3_0_set_buffer_funcs(adev);
 	sdma_v3_0_set_vm_pte_funcs(adev);
@@ -1129,10 +1134,6 @@ static int sdma_v3_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	r = sdma_v3_0_init_microcode(adev);
-	if (r)
-		return r;
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
-- 
2.34.1

