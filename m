Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C3AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5837410E1B4;
	Tue,  3 May 2022 20:38:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F0610E1B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:38:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgTPmPZTqlsJYe0iXIok59dWcXnrFLFBMbr//6i4JLwvyCutE/ifVxN8UI314BcKlrkgraSUstQfsHxlazs1rxnI2Z9AF5xKIo9gi16frsdoDDesSA56w26BuSAvpMqzzyLksFsRdB5lqS7O8xHByXgZsiTdg4L0T3nvV9UjXB3LzGz+s12G71tf0L5pAowmPPUMPuEmhRrrFZnzj3Hym7bAMyG+1XJ1RtX1MtQmBtYF/mSHA6EXpRfCy0uESVrZcZZH5rvoLFWlp4QFBmwkMKuZIcsi9j96lKcVFOYhADaH8aNKLXECjVp9YacWZJhLhT4nP/WIA6fvD+pqulgMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LDGYxlxvnGJsAR/bziPAc/NhjFckcdSwbYSlNoNElc=;
 b=dG4NqoQVOb4iHLOw4ACF0rzeFlkHw2FGrq+T1l/QPQwCbnsphsVGeSHSfldQ/dSw2+uOLzFthD8xZ2DxYOGcN/uqK+57DODs+yIYPjF2tNdul2KyaPaS3oyAUrQaD0ZFghSijgN9mcX9ynhePUHF/Ua4GXV8j9nCgNIoqwcagsrY2Utw7xU7kzuqC8R+QcGnZnkzmuLgB8rAY8jDbTtP/fwM9mpsIEjuDGZmH4MSsbPN2ktf5y/CyCmoIePsrjC1p4oCKFyqdwIw+j74Dj/Nhqt7/tJeq9Nd6GDV+rl1rpZlQ2VjMhsGWJeis+bweZmpDez9Am8782OCanyleWQbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LDGYxlxvnGJsAR/bziPAc/NhjFckcdSwbYSlNoNElc=;
 b=vGJ2tqa/RXsYbduiV5PhRoL12l49b5PQu8yvWfIprRs5WgLTI+yPV6nqQche8adw1uhdDvgBXSQ6Ngl+zDvEVIOhNL7ziGipGAdNZXhhLPOplCEo6zbtx9fbjn7zLL54avwGKCkeVawH/2RpFkumBRj+Ep08MYODWApv2VH0kcg=
Received: from MW4PR04CA0191.namprd04.prod.outlook.com (2603:10b6:303:86::16)
 by BN7PR12MB2642.namprd12.prod.outlook.com (2603:10b6:408:26::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:38:48 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::8e) by MW4PR04CA0191.outlook.office365.com
 (2603:10b6:303:86::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 3 May 2022 20:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:38:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:38:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: skip the new gc doorbell function for some
 asics
Date: Tue, 3 May 2022 16:38:34 -0400
Message-ID: <20220503203834.1230487-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203834.1230487-1-alexander.deucher@amd.com>
References: <20220503203834.1230487-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c17d1655-0dfc-4a73-9f5d-08da2d44ecb4
X-MS-TrafficTypeDiagnostic: BN7PR12MB2642:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB26420F9DD6E52FDF24B054B3F7C09@BN7PR12MB2642.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tw3zHoIp6mWTg1eoo9mlhDHTbNjIz7xKQ0pDpN60cW80H7AxDsqHwvj6UemUBoH2eONnKimjBGkN5HYcfCkbDFf5vwMijdBUyNoBGlfr1SlFAQfMlarBfsmJkrcGDlEVfi7FbRSUTWFTDgPWC0NYXUovvIubSdw39xQLYesDgcuTrMgowZKxCoE4ok9KyfP/1ROJ0RfaQwlPEGiQusnva7McA2EgM+FURem9njiH0MCYpyjy+ywi9hJ37RhItlmzEHYzzRMMxHfA6j2vqM4HSkOJ0M/M1jd+SI19dEcfBnA+VhfpxctVsfsNikRxt3dDsx4TJYwhTOm6UDNVj5S2LDsveSGF/1U/boMyJmW0kh5eZKYPrla0ysVdutXv4p7foDItoqzNgQaOgQS9mjHKX/39kR4i+AvkGeSFWxb377dA/7iRyBpWMvoaj278NVsVAoOn597vHMVbUWYaI5hPUatiVW7ej+2gdDcCR9W6whISy6rjBjQN+OvecrkbcVISJnnKj4mI/tpXntt3r2ZZ8KD/PsPNwWcHjkqfAD+eDujXSNyREATX6UgoYXFmGMudNT7PONg7X4xeWMoRQjyQq5A8sETtt9TvabDAGcQqpm43AlJfbN+oI/+kRCSk+iQGjPtAKP00W+cbNG2T2iUHDay/N88wfRZzXFGeGhI6sUV1Xf1Xdfk1+Yi0TlTT5qkSlygC9MPV7hboK0PFb4HvtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(2616005)(16526019)(1076003)(426003)(47076005)(40460700003)(186003)(2906002)(83380400001)(336012)(26005)(8936002)(5660300002)(7696005)(81166007)(6666004)(356005)(70206006)(508600001)(36860700001)(86362001)(4326008)(8676002)(70586007)(6916009)(54906003)(316002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:38:47.6757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c17d1655-0dfc-4a73-9f5d-08da2d44ecb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2642
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <Xiaojian.Du@amd.com>

This patch will skip the new gc doorbell function for some asics,
only enable new doorbell model on aisc where it is supported.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 97d37b2e58f2..85fddec0d4ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4592,7 +4592,8 @@ static int gfx_v11_0_hw_init(void *handle)
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
 		gfx_v11_0_select_cp_fw_arch(adev);
 
-	adev->nbio.funcs->gc_doorbell_init(adev);
+	if (adev->nbio.funcs->gc_doorbell_init)
+		adev->nbio.funcs->gc_doorbell_init(adev);
 
 	r = gfx_v11_0_rlc_resume(adev);
 	if (r)
-- 
2.35.1

