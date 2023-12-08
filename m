Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862BDC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 22:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 380CE10EB48;
	Fri,  8 Dec 2023 22:19:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA61210EB45
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 22:19:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4Ma0ADJkqwyk02Z0Z4QKtUpTcGhxuzdteyvxbi94vIE7roFWiSgrba1GN14uZK9qj24wkW/f3b2HXPdCyzx0H4Iqgd8luAvWevmxJbNzM2HpGi/I/+9Gv0Ds0GPO7FN7GCko09TRWsvW/MMgkmikQN7EHgtUYcQViRzaQg+EwnUED/Wet/G1MQrLYc6H+oqSyfUAwXRh4KizqgdnABrv7cul+ejTNZ11vxDN8q7ZSEqIZ/D0VvUT2ww2YaWaLcINAY4CzPlA81nyn+3rqIE7OQzkB1maPGyQBUuYRR7NB13BG9Wo7hePlJ58bMSSmGLNFmNpqB3AQEMa+uO+P06hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvVa3iKBsyJGT/RUfGYUI4oidlEiiPOAio+Kp4Sotnk=;
 b=fiujiCtgk6rPhPpBoaooAkgoedKUwAjEEhx88zMhCCzkyhUa0Va+mNZ00pLQecfX378U/nhJIRxFbyebUzUWzrDC9y0e4pYMbwu76hW8IZ6MmjrslVY71xCrL8R981fy6Hph6UGh1FQhk7AtgPRHzjqHeeE9oNFhGQfJgiIy7BOn6W5tuyilxux37ZCw3N1+1iajK9v5dCXoQQmoQjwRQ/4G8brQpBjDqVVlIA20/07AGU70pZ0vWq6REWOaBDFvDxWhmvgEmHIaVLMlLoB/NzRmQTByvpb+zgZ+vXnhc2J2u1tsy7M0nq+pMEJuhHMfiaXAlDYVEbYJ3l4FNGfDnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvVa3iKBsyJGT/RUfGYUI4oidlEiiPOAio+Kp4Sotnk=;
 b=eF8FHXqIfWNPDJsfYSGUhT7hDk0dr7zpTP2PlWSUjKQZHVzy8wmhd42yARIieKa1bRphFUBtFbAR31y5qVwOcEDPazymJ2hf6Uc67zZjs7ru06fX1V/lUFtg9eKjhp36KkPMvRsN2lrIrmDrXkjEFi3yOhywQY7h/C/zRs3fORI=
Received: from CH0P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::11)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 22:19:43 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::90) by CH0P220CA0021.outlook.office365.com
 (2603:10b6:610:ef::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.26 via Frontend
 Transport; Fri, 8 Dec 2023 22:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Fri, 8 Dec 2023 22:19:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 8 Dec
 2023 16:19:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu/sdma: add begin_use/end_use helpers
Date: Fri, 8 Dec 2023 17:19:26 -0500
Message-ID: <20231208221928.5679-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ff6f44-d274-4b44-9f89-08dbf83bc716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8MEUfrFnumtdA5vyIU/t8RF+Jj8WdFfoN8CcIuQDUIw7mo+kyV2Z3tDsGOp7XgzWZbTy2HIOIMkF7qn+IyjfGee1mg9Pe7xC02Su/M1ZIPA9uv4JWc2Dk9O1Bp+dPC2AVKi3HCVGPXzZHPBRcRS1Sd72mf0B3nnsmmQexDjNNJmSezs0qgK3dipk+GgZ70/cQps+eryV1BExafg6nMKa2WeuGeojM6nxs5ZOOSfqEiYm78Ak0hMSM8jI6Pt053B6a4ntzejwRzYuyYbn3BKEB++IdFrPOGeMLeZ+pErhS/9w32jzAUW9cGH0zO8R/T9eg3a8H1Kxp+FPp9pKHO3EhGGqdaUrJN9vWnod0Kcy6S7Y2mSQrNsoD3cIGvHn4XuYIno0R3zgXajZC9VDgPNz0DhgTWkmIMZBFbVPi3yh1cQebEqIEjhSvMwHGuxWCsF7zWFaDbpbtv/BgV5RX3R3Jl+IF1XluSPcYwaO8f19GX9R7KoKn/HPOlXUUcMO0anXp/reBsAC4DFLOVo1rkpS/SaJERMKVQDYs1plxGFg+8/NO6/xLtPM1dBCCIPJbKLlX3QC3WVeS8m7BNc6PAPHvtWggCdmXU0DXPVKCpcRPJ4itn6Wfle5E2CKoUMbHtT0ZmsQD1wdRJmjiLa6rsokAkSoQw03APHe/ICgWd7F0K72Or1pHv0jE/l4ScEigQDTOheukvNW3r9pTnBK7pnqaNO67f+dygu98Sgyi0XKY+3SO6lLlC6bB0KcVXCDY8sclEQ48QD7UyvMSIuyUnuvKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(1800799012)(82310400011)(64100799003)(451199024)(186009)(40470700004)(46966006)(36840700001)(82740400003)(40480700001)(26005)(16526019)(336012)(426003)(478600001)(7696005)(6666004)(1076003)(2616005)(4326008)(8676002)(6916009)(70586007)(70206006)(316002)(86362001)(8936002)(36860700001)(356005)(47076005)(81166007)(5660300002)(40460700003)(41300700001)(36756003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 22:19:42.9183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ff6f44-d274-4b44-9f89-08dbf83bc716
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
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

Add helper functions to disallow GFXOFF while SDMA has work.
This should avoid corner cases where GFXOFF is erroneously
entered when SDMA is still active.  For now just allow/disallow
GFXOFF in the begin and end helpers until we root cause the
issue.  This should not impact power as SDMA usage is pretty
minimal and GFXOSS should not be active when SDMA is active
anyway, this just makes it explicit.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 1d9d187de6ee..d4b08d03970c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -326,3 +326,17 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+void amdgpu_sdma_ring_begin_use(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+}
+
+void amdgpu_sdma_ring_end_use(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	amdgpu_gfx_off_ctrl(adev, true);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 173a2a308078..b52d16829204 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -171,4 +171,7 @@ void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
         bool duplicate);
 int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
 
+void amdgpu_sdma_ring_begin_use(struct amdgpu_ring *ring);
+void amdgpu_sdma_ring_end_use(struct amdgpu_ring *ring);
+
 #endif
-- 
2.42.0

