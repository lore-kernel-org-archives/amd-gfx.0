Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACE2C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 22:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7587710EB4C;
	Fri,  8 Dec 2023 22:19:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4336D10EB46
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 22:19:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+NUGoSEYMFOtLgwKexqkOjjaAomOtC7T9KAGEiqH9dOfNGhXTG0xWc8RMCYF3kKUXG5P+Swx+A+pBDqtqJrOdcDBXWchoA1nxKzYxN4VI98ZPHSkTlLMFLSFb7PG6CGs1q4ySUeJOq4sdfxBxZboG2Qlq2hywMuOX1x2L8My9MVCOZDvI+3v+Z7SaSvDBSyta9GFJTy6mperzB1QITb3FZsU6awG14yx1l4p3dSM4ka1f19RwsfLgwrGqu9+Ga8ZthPrd5VeAzzcwIZzxOjaQrTkFOc4cycrK8t9JJH5heonlsyJhHvpiMmevKDbKv88Q/73IPEDyQMTDc4eFRUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BW81BSMcfkn8duOKoOdsV5+YFC5Nr8H7ZdlhnR3VlIw=;
 b=fGVlmZeo7+ozO5YlIz+LWoDpheYfWRgaORiFiG3J418rzL+rLyGrk5zQq0beGfCeQF7bwlyeViUfMOrJYsoPQBrXfwunKEB6wpgBNLB7Bsge90mUtD5XVnnYAAv/BKgseBLfHEhysFbVrONc8Yx3rXiTwaTyiK0G9vG8h7xrVxgVC2fCAjQpFmCJNwSqc5D/Xl+EB9VbuK6cI2qeeAwbfc7PED2t9iRAdA3f/hJ4fM19+oVOGIwpPQM9QdE7dcrg3xyhjN8Rhk2PUpoi35d/eLX8GNZxbtIS1Q805klHZ+bfueoipePvFAMZg2ek5m5sG0KKADeo7e90YzKXB2DKBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BW81BSMcfkn8duOKoOdsV5+YFC5Nr8H7ZdlhnR3VlIw=;
 b=st1daq59u/Y+BRrmTXEdD5jxD+71loZyIHJxyYYeI9rpFI0O1/fV3DArFbfqLOHCzSha2dyyL2+ePHmnE3eKwQNDnfPoZabFxnhvxaG6xin4KJlN1OG44NMq2idaZvvALJ/zDHEep+raCYqIgTqU8G6RczF12v1zc9uRze9pSms=
Received: from CH0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::26)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 22:19:45 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::61) by CH0P220CA0019.outlook.office365.com
 (2603:10b6:610:ef::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28 via Frontend
 Transport; Fri, 8 Dec 2023 22:19:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Fri, 8 Dec 2023 22:19:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 8 Dec
 2023 16:19:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/sdma5.2: add begin/end_use ring callbacks
Date: Fri, 8 Dec 2023 17:19:28 -0500
Message-ID: <20231208221928.5679-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208221928.5679-1-alexander.deucher@amd.com>
References: <20231208221928.5679-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e797c5d-2109-48c4-1aa6-08dbf83bc856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: olgLeP5Fr5XInMrhfUA0US/LbAoa0hqRwBBQsIkUKSQEhKYNFdP3GYFiaUFCuzEi0py7vfQLz7r8UqMhxt8eOFoX05JNkOKv/v51gMAcwuW2czWgfGKvjKR8HvG+XX8xJUdW+eT+jBZAp1TjkF/qSxoVSJjfFvk1YHlEFem8csv3SHCot+AS439LG4hx1fPgtbiC77W29pEcG/H4dm66GWz29PGnqhnljVF+WWWHWkQNwQSPpZfaqDsRchlA0oCMkp5suK/qMD9Jco8pNmVqT/pC3ET0CyI9iXG3r+aA+pxkPc89UUhjdjUDbL0hG4m6wBZQ/MobKGcpJPGsrvyb4UZnqNytt9z0HxTVX86Sv7Kiob8DlMigQbYEGzJvD2wLe7X1EYBJ1revHJUxPE0cRDfVXuFqJ98zfiI6lQf3FS80CNugbZB3M+uwF4yyg+kaVaZmnMZzMctReCWw3HE62/yL/ClNDJ39tcfOF6sFVSbF+64RSPV59IspsLvaLH+YX0Fzz7ibWMXxGYBE3KdkMZaniHa1H/RbXhRHjIfY88uLiypxlquwocQAIvLHTdaTM2HGDD3/f9ceghwApS4bfDirNlmYx0JnrjZhffDieH19wrDFp6XnFT6a0tA+1GF8rMWVyTL07FEDk1DSgYLSdJyGqlwtqNrs+4AgVBdijdQt7UWok++KFmm+G2lsPpobyJVPWhg5oA0Uu1uRDOn3Tf9DW+CUU7eHsH2zCd1lM2ddJ9Fcw5bkUrsYHDYJkiFWANB2MzRXWyPKi6NXA1ws9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(36756003)(40460700003)(40480700001)(16526019)(26005)(47076005)(478600001)(2616005)(1076003)(7696005)(6666004)(356005)(82740400003)(81166007)(86362001)(5660300002)(70206006)(70586007)(336012)(36860700001)(4744005)(2906002)(426003)(41300700001)(4326008)(8676002)(8936002)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 22:19:44.9964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e797c5d-2109-48c4-1aa6-08dbf83bc856
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
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

Add begin/end_use ring callbacks to disallow GFXOFF when
SDMA work is submitted and allow it again afterward.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 2e35f3571774..988238f20315 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1690,6 +1690,8 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
 	.test_ib = sdma_v5_2_ring_test_ib,
 	.insert_nop = sdma_v5_2_ring_insert_nop,
 	.pad_ib = sdma_v5_2_ring_pad_ib,
+	.begin_use = amdgpu_sdma_ring_begin_use,
+	.end_use = amdgpu_sdma_ring_end_use,
 	.emit_wreg = sdma_v5_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v5_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = sdma_v5_2_ring_emit_reg_write_reg_wait,
-- 
2.42.0

