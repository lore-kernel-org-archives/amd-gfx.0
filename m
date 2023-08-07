Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95207EB64DD
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 07:25:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05D8B89C29;
	Mon,  7 Aug 2023 07:25:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90B0889C29
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 07:25:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwH/B8LSniKXkQGh3smtaA+KpR19wRRKbQvk2NiR4TRflELtTmNdgbN6R2gO3+8IsNs8BXlV2WF7Ij2OjVYFq9tgcQCEbfSLdTTIZjnRiUT5VXHoX3+Oal4NDY8eiLtNi8cA+t28N0EBgVyUDOzet4UbRFfHYjG3HDBxWrghzMY+jt+Y/NKoLZWTKlHtn8pnOd1xXJcSyZCyxIKB725g9UZLjDitLgjqIiuUwISTCtqxJjlsEokVKtxE4u7XvDqktortMQMrMUCh4Cu3jkb3IJx5UpI000/sCsL+Pcto+o+x8o2p9uhe2gTwAnconFC9koIOm50S4QrSkYuHgbITDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bx6kVUfTDheiTm7J+uPBHs1h3T/oSTmJ699hpnslqcU=;
 b=RmUwYU0iBex+u7r4agcjWsZxzdzK7CGsEqYnKa8yFxTjZpKf1g+oI1TBTKNIDJQqy0h/twacjWgnQKFj0UP356IJSDB24r+qoztwDgSIoFRv9nntD8RP7Qok6pEwzbtJQlfP/5qxoNFhJjc7wR7h/OeDjRaAL5l7nQFGomL18Q+p30wSz05W5U3OqqUHj3sUKChGuj8didb56/+HYKzwZfwssWGRryPBi48whUtrOlsN/AM6usAttjcBgRwlrqhRwG6KzsRb7xCU00G/xPDrLrVjqYWFHEnBWwMweK6+zDwv31p0JBOV5ApS6duZkl5VCBMfG9SzYsyv84cQ7tHeoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bx6kVUfTDheiTm7J+uPBHs1h3T/oSTmJ699hpnslqcU=;
 b=v4NZ2pLNaVauB/m6tbas3pl0bzxEOG20SKm6OwEGKoDMom5jobOcIXzaG5EOhKkyGcgSLXDK/KuN6SnmcG5T2LJZ2Db82xzy7gLSxT6R3SbWth3w+buC2omidYW0S+ey0g502uNRPiIevXQ9V2TIjYfugE66BqHB2MjFjo8gQ8M=
Received: from SN7PR04CA0066.namprd04.prod.outlook.com (2603:10b6:806:121::11)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 07:25:15 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::29) by SN7PR04CA0066.outlook.office365.com
 (2603:10b6:806:121::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26 via Frontend
 Transport; Mon, 7 Aug 2023 07:25:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 07:25:15 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 02:24:33 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>, "Pan
 Xinhui" <Xinhui.Pan@amd.com>
Subject: [PATCH] drm/amdgpu: Fix identation issues in
 'kgd_gfx_v9_program_trap_handler_settings'
Date: Mon, 7 Aug 2023 12:53:52 +0530
Message-ID: <20230807072352.117420-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5077fd-6d74-4fb4-3f8e-08db971771ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oo4P43iKNLuX//eTa2uMs3NxllFOS00tHBxVJXLgnxCFFyyAb6Xf3cpJrKkI4KrVPS58dvhSdiG6MsDy3Hki+BpGvQcqqsNhCvtfNbA2aFApJgwKanrVRFllYIMfSjO9OfGza/gHqA1Vf+Zz66JjcaDykgF1GnUvWSBTg9PrS8nNrEWoyYnB2Qvjf2OkiHNbUpiaPlmZArXywDIdEVtpHs62svqCIaMsNe8kz1zbKE+d/pAZgQFVgYt8yuS96/M0bIANajimUJUqrJC7tppHnX72qVbcD8KtGVsrJRtyAw4UVr+04dc47QfMYf3y//62OR4FuGkVt9FBz3zSCgwAxZGPAI7LIgPV5LqVmCNbOAkoG6lCGJboZLqejdIK+aFsp+iHxSy/QX1rydcZCBNjGkGzwAB/7MxPonvPvmS3DsbaQsxTTo0T9OKjHoCrgpYxzhwDOS3xPJRf9+wUSpCovslL+3r2TEY33oJ57U7nQY1MEZbK/kVkqoXmjz1ciSrAh1wE+Ffu1WfWILNB4ymy0cTahPv/RlK8F7sIUD1Mf9GjwBCbp5r+LVo3StI4Y4+t1HgsCVJDoGbgKgqz4YOZY7JVbV/SU9pGQ8lpi7EZiy29IBYUb/qsLC+9XWEJMXIZPfzxvZBHzavs9pssVjwR7RAb+pSfHTASY6D3rrds16rGp5uIG68Qs1Qc2fJHZb8s9MvM2XC/jvEic4PzxZRgL1sAIiUANsxDm/HrY3ZDBUg2OufSMYnkDUErt8uoJ8QJejDkpukvwKb/B2xgSXh4ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(1800799003)(82310400008)(186006)(40470700004)(36840700001)(46966006)(81166007)(40480700001)(40460700003)(2616005)(110136005)(7696005)(6666004)(86362001)(478600001)(82740400003)(1076003)(356005)(26005)(36756003)(54906003)(41300700001)(316002)(5660300002)(8936002)(8676002)(44832011)(4326008)(6636002)(2906002)(70206006)(16526019)(70586007)(336012)(47076005)(83380400001)(36860700001)(66574015)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 07:25:15.0505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5077fd-6d74-4fb4-3f8e-08db971771ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following:

ERROR: code indent should use tabs where possible
WARNING: please, no spaces at the start of a line

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 28963726bc97..fa5ee96f8845 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1133,9 +1133,9 @@ void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
 	 * Program TBA registers
 	 */
 	WREG32_SOC15(GC, GET_INST(GC, inst), mmSQ_SHADER_TBA_LO,
-                        lower_32_bits(tba_addr >> 8));
+			lower_32_bits(tba_addr >> 8));
 	WREG32_SOC15(GC, GET_INST(GC, inst), mmSQ_SHADER_TBA_HI,
-                        upper_32_bits(tba_addr >> 8));
+			upper_32_bits(tba_addr >> 8));
 
 	/*
 	 * Program TMA registers
-- 
2.25.1

