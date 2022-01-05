Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5826C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jan 2022 20:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5218110E11B;
	Wed,  5 Jan 2022 20:39:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A8EE10E11B
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jan 2022 20:39:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAXAZvvUl/A1Kh2jwnlrI3RsEOcX9xEKlNeprZ33zw6fcV9Q/E9f59VxMtn0XygErvkEox6DU1HZQWdkK0XJ5FL78DBRlo6J1WFGDNUQ+xZWDdMV30TjbOduvcNNdziDDIi6ALNJM8lW2UcERxTb2rR6/qWMIO++hfOrZjwB9nVA6mWakBKN/TET+mXTANTABqihkTEwqvNgkPQ1ODlLxeNxQO7kQaGNINz9QhdZef6x5YZ9gP2ptiGSjAVaDFRr/gVGito9CR+y0JMCKUrAMvyZM/+6/7m9P/bXEvxBxgGZ0sJ3mfb0SL0edDzEAPfrdZnAtqjDg+IO2ZBbkpkw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gM4ll6H8GT/WWzwFf2B+zlGQihvRczTix7CWc402ol0=;
 b=DeZm5gSLC0Ecjg1JfehC9CcSSgkXF/p0GyGblaYmWbXrqL568DAfg4b5ChmXBDB/rS2A+ZDlmaRXuYwrPOUC4Ng/Hm1Y7YwGczD3Mv5Z6ecQcAYfPiPFCqB8R14mU1/UShOAQFD/nS03iKQ/NRyM/R0luiTVzU/wuFn0pjL/Aq5mY8FsFO49URxS6nY8R9jwnxXekZy50FyCHHtRjUepwVq/Uj+CG4ISopQ6nPA0JjgwKer4G5jwGpuxCvrf44yZJQKPKgWmn6l5WYdgbAZ3PLYw5VXu2dqainBDWfSpFZs1Ksk1uZd0Fo7T4FJq23/jhU8KpSSMwkml/DXG5L9ZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gM4ll6H8GT/WWzwFf2B+zlGQihvRczTix7CWc402ol0=;
 b=e6gFrYN0RmvHn0im+bgiwrBxeK4BRhY8CPurr1rkhYKmUypZYt8+mbVo5Hi7WZAtISaG6IsYA+jyiab1jS8VEqbK1yaJ3WByh+VqsUtJ4vCNn7jUjjZc88cOsnDUOjTtnehRMzVCoYv26hjX2yplIjvZ4nFVJ5pPUSqzqyxi2aI=
Received: from BN0PR04CA0029.namprd04.prod.outlook.com (2603:10b6:408:ee::34)
 by CH2PR12MB3799.namprd12.prod.outlook.com (2603:10b6:610:21::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 20:39:05 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::c6) by BN0PR04CA0029.outlook.office365.com
 (2603:10b6:408:ee::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Wed, 5 Jan 2022 20:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Wed, 5 Jan 2022 20:39:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 14:39:05 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 14:39:04 -0600
Received: from hwentlanryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 5 Jan 2022 14:39:03 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Becle.Lee@amd.com>, <Rex.Huang@amd.com>, <Ray.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: Use correct VIEWPORT_DIMENSION for DCN2
Date: Wed, 5 Jan 2022 15:39:01 -0500
Message-ID: <20220105203901.52175-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19165d00-63b7-45c2-4e7d-08d9d08b6a74
X-MS-TrafficTypeDiagnostic: CH2PR12MB3799:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB37997D2247B595B642E4FE488C4B9@CH2PR12MB3799.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /e1uBg7w0ug5twq3o0s3uBqjRG+xXOo4y2DzZrX0TD6F1wLbER7Epw2Ozf/x9qmI09RUX64IpMxCp6AFz4qCOti3IgQ+bT5zCyu6jBoxmpdlw5fhO7KmDK519kafKNi510yYxvQQsxk5FGwfR/o/TXj+IKuYmP0DW5vYKeIlUyrOWhmiSprcFhTe96u6fLV4sugAkf7wke56/EkcoampJwR1Rn/s7tRKv/TA1ZKobJrbzfqXb2TpLJ9j+pqrnMv7WT4U/n4KXseplFgKEe2ZHCL7fdTVuSVbtuYzfiLaKKD2bJTM/1nQGUnD/hvEM8Oho99UP5FNtLwU6Ocz7zrKq2NjPIK/AX1NAGZ6TRljjMK6SjcXol7FkkF7HNt8oYynnk3rNbmMz2+7BzGPc+mfkFhKwCmRKS9RP/Orjp/g0Sftwg7CJjJWhr03m9Og94oXiyv2dsC1RqmjWGNb5oYTDbYGip1z9m9Y6yba5zyNcpSBrTUmNgIESw51d2P5LgIs8ytQPM5r5PyqqH/0EV4dvi6OCoOUk9LhRtCKPJbQC7KzAmKlqu5Y89PGEPbgo0mCA1rujWA6pjHtd77PwYDo5l5nA6/qWYUhtpY56EUVz1ZJ824Brxr7FY9L8rTF3BlynAaAJsgrN7sNhYNQ3J/UbkN+ilFj1lUu6j+BOP0LrhNAfuwR/itcw1gTdhreRjXE8jGlZchi70peX60hp09FRv3rrpriwQ798duxipIr9vcx3cUEFwR+ngp+dX/DaxUNhGqo3ec07rH56ViHNXWRODGStBbNEh6oB+GY/9u90W0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(8936002)(8676002)(47076005)(36756003)(6636002)(110136005)(1076003)(508600001)(36860700001)(2906002)(7696005)(5660300002)(4326008)(81166007)(40460700001)(70206006)(70586007)(83380400001)(26005)(186003)(82310400004)(336012)(426003)(356005)(2616005)(86362001)(44832011)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 20:39:05.4205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19165d00-63b7-45c2-4e7d-08d9d08b6a74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3799
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
Cc: Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For some reason this file isn't using the appropriate register
headers for DCN headers, which means that on DCN2 we're getting
the VIEWPORT_DIMENSION offset wrong.

This means that we're not correctly carving out the framebuffer
memory correctly for a framebuffer allocated by EFI and
therefore see corruption when loading amdgpu before the display
driver takes over control of the framebuffer scanout.

Fix this by checking the DCE_HWIP and picking the correct offset
accordingly.

Long-term we should expose this info from DC as GMC shouldn't
need to know about DCN registers.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 57f2729a7bd0..8367ecf61af1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -72,6 +72,9 @@
 #define mmDCHUBBUB_SDPIF_MMIO_CNTRL_0                                                                  0x049d
 #define mmDCHUBBUB_SDPIF_MMIO_CNTRL_0_BASE_IDX                                                         2
 
+#define DCN2_mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION                                                          0x05ea
+#define DCN2_mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION_BASE_IDX                                                 2
+
 
 static const char *gfxhub_client_ids[] = {
 	"CB",
@@ -1142,7 +1145,6 @@ static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
 		switch (adev->ip_versions[DCE_HWIP][0]) {
 		case IP_VERSION(1, 0, 0):
 		case IP_VERSION(1, 0, 1):
-		case IP_VERSION(2, 1, 0):
 			viewport = RREG32_SOC15(DCE, 0, mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
 			size = (REG_GET_FIELD(viewport,
 					      HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
@@ -1150,6 +1152,14 @@ static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
 					      HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_WIDTH) *
 				4);
 			break;
+		case IP_VERSION(2, 1, 0):
+			viewport = RREG32_SOC15(DCE, 0, DCN2_mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
+			size = (REG_GET_FIELD(viewport,
+					      HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
+				REG_GET_FIELD(viewport,
+					      HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_WIDTH) *
+				4);
+			break;
 		default:
 			viewport = RREG32_SOC15(DCE, 0, mmSCL0_VIEWPORT_SIZE);
 			size = (REG_GET_FIELD(viewport, SCL0_VIEWPORT_SIZE, VIEWPORT_HEIGHT) *
-- 
2.34.1

