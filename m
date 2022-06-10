Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6494C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 17:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CE5410E10F;
	Fri, 10 Jun 2022 17:13:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BA9D10E1AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 17:13:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clMgvw3NpVYjSYaYkyBuAMqOvU6cYRC4dbpNteRHPGpPWgU0Fih5nUC2j7oLdiQglDheZO1gWvcVawUiOmJUGppjBr8O1H1vvRTlCghiuneQT0kqiMO6YLV77zd7ZXiowVmdmpU+uVHd/0ciJpHnpCpo8HP2W5XfxEb6LmizHf7IxfUhQlb1vp7oUTRkAZNcEklkU+ezQR4zoJ9PMwH0k1rxrMV8131QUHtiG3w42U/yDnegbrjLt1iQv1ipkcDL9Hx9us3y/2QItq0cvYl7fdcLT42SpDKJaL0fTJf3wAvsMzwnh2fsll72qbS2/DtTw+SQ8ml2av//B7jDwpjA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJKNySNLgMnn+A3SGDFSBBDiiaviYoGud4I1D8OMLzk=;
 b=hKaEdu6bgS0VPTReH3TgO3E9ad2ULbFqOH3HATN1HSFvhmTXfTGziMpXdlCTGIwPEXHjKFELCzag2YzuaOwSrnG9FHaMP0CUaxIZt2LF9eb/uciA+EX8xsHAgqpYbH1ZVtiZVmrhQrJDcjP9yt7JmcitQSIATgPds7S0YUmLfbInU5QZOAwgcJKHFs80vqk38/QLysIjYaVx7rswPI3pPET9CeDvyxYUGhB+kLH04t2jxq6e8xb4dTJHXBWm1c3nokMmEzsNvw8yWzXgQhiWCsl751WeZiZZ+1Q1v5xEuPS/sDJGg2lP12yK5duoDXxwHfQFYoQQko3gA882fdfH/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJKNySNLgMnn+A3SGDFSBBDiiaviYoGud4I1D8OMLzk=;
 b=k928yTz8ss2qosH1EGfRYFjyepuDY78mZ6atpMPPZPbPe5sws/MzFDOVxnJpkL99RNTxCTbQBW8KEzxJrVZIIefqdrI0M+EbdszCaGjxJ2yKJzOZ9MOd8wZFJYCuk6bz0RtYOVoN2ikTPcgig1KFOsir+cUALY8kx6wZPs2K9ZE=
Received: from MW4P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::26)
 by CH0PR12MB5299.namprd12.prod.outlook.com (2603:10b6:610:d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 17:13:31 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::82) by MW4P222CA0021.outlook.office365.com
 (2603:10b6:303:114::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Fri, 10 Jun 2022 17:13:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 17:13:30 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 12:13:29 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amdgpu: Fetch MES scheduler/KIQ versions
Date: Fri, 10 Jun 2022 13:13:14 -0400
Message-ID: <20220610171316.2668611-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3093bb7d-31dc-4b57-5731-08da4b048ae4
X-MS-TrafficTypeDiagnostic: CH0PR12MB5299:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5299A56E4C7B238C0CA296A28AA69@CH0PR12MB5299.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMhZrEUe9YZS5VhgKJAQPJLa2/YnWKyuKJH3K+FFzMCPSBtf8RuirirkcZDn/88MdkvwxtWdCZWJvVqUC48BKfYLj0Uz0gR+sh5AfaYOWgMyyjslOi6wUqoJGwuKWNSLmMmIwnhGPIlgslQ8+xVmI3Peh3FNUtv2gbqv1KYToOaR7B5EmBRYsFzsRiMISjb1C2Dn+PZpqQmBL0IFUM8FMUR0PMV6cMyWSu4Oh0AXVfEZ2xvyVXJTePftMSOwIuMoWVP3qicZ0MJSkBKk6u9TnIzpGKJwjRtsgFh7/EuV6TRsAsJmu2l9F/RmsTahWnDoV4tlJtl5dgaZH0Dsp5dWh+Yiv01sCIRNyDsYceNjLptGx08qWOlNR15O175pTqfKTPtp4RsqNwRB1rLFXi5TM29ATWigpKD6OnDEDSsPTGQfiPcRnG2/Po632HeFKehAWgHwccri6OxQiUDDQt2SAFbOqQtlwK4u/5oWvheOhs1oPLkyGFHMGEkGAtOWp8VafS2ayO3Fjl2WcdqF2IgkCGCBO2pcf/ffXbrWXabt6HKjO5j+7UZs2yntgAp0Km9hCIV08yKYVhq3qXyCRTvhtM2bgnIRm7CbchjqnDIRqe6vOrVpRPFGZMhn8lcfTCkSExYnN6LEqpQlcLzVir4d8IDVRBx7aLc13vORDctmhY5OoMi8pkabw2NirV+3CYUj1A7Nn6d0t+AU6WxsphCQPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(83380400001)(2616005)(16526019)(186003)(1076003)(6666004)(316002)(356005)(70206006)(40460700003)(26005)(47076005)(508600001)(81166007)(82310400005)(2906002)(36756003)(70586007)(5660300002)(8936002)(36860700001)(4326008)(6916009)(8676002)(86362001)(54906003)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 17:13:30.6644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3093bb7d-31dc-4b57-5731-08da4b048ae4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5299
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
Cc: Mukul.Joshi@amd.com, Felix.Kuehling@amd.com,
 Graham Sider <Graham.Sider@amd.com>, Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Store MES scheduler and MES KIQ version numbers in amdgpu_mes for GFX11.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 92ddee5e33db..aa06c8396ee0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -64,6 +64,9 @@ struct amdgpu_mes {
 
 	spinlock_t                      queue_id_lock;
 
+	uint32_t			sched_version;
+	uint32_t			kiq_version;
+
 	uint32_t                        total_max_queue;
 	uint32_t                        doorbell_id_offset;
 	uint32_t                        max_doorbell_slices;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e4eb87689f7f..2a9ef308e71c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -890,6 +890,18 @@ static int mes_v11_0_queue_init(struct amdgpu_device *adev,
 		mes_v11_0_queue_init_register(ring);
 	}
 
+	/* get MES scheduler/KIQ versions */
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, 3, pipe, 0, 0);
+
+	if (pipe == AMDGPU_MES_SCHED_PIPE)
+		adev->mes.sched_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
+	else if (pipe == AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
+		adev->mes.kiq_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
+
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
 	return 0;
 }
 
-- 
2.25.1

