Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD0EC6FD1C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 12:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C2B510E089;
	Thu, 23 Mar 2023 12:05:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38E8F10E089
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 12:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjgxgFFFj5k2a8hDumQAcAq3mr2vRN79IIXOrxVwmCp+AV57yg6hoWnQsCqNE9bDSW6CQagurIXAKyLDeUjx9HfDlPBb68BWI5aSqHDNErKNznUFQzxZpmx/590AyhFZR0n/CcvJQ5cp6yOtqSxXEqEwtwkkkP7J8Upfxkk+GNhrCPj2LT5nGRgd/TL+xQ8G+Jy5FzbPMTIJx47Ee2loBxS09S5XeV0aQzQnK9hHwrkfL/DeeVapz3A6cFUBWZjw0/okOIgQ7qNW8o65FU0wEEsSEWVRSSwpq7S+uSRyWOUJGPZH1gqNaZGCYV8q3Bt1IjV93HUvCZQZHuxqGwMN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9TxcJGOd8GKDjbaglkaoMJEnLUqasbBNfPWNFnkirI=;
 b=IFZy/lA35xZyWHhP/pgo6nBhtypqujVtab96j/p/u2Nb5/BBQWddDC4kOXn68gWk3ADA5OrYj5SBpJY4QaOvyBakd0887pWFdcC0sVxv6vAUXEKy3E2AaTDzJ+aSWs4oyxN03U5RNv25UNNKeK52Xpe/emc6OrYeFaDcHIEhtCOLild7bJ7ZEw2AHtxPB+70bIocC5Tc5vIGenY5cAiXYqedhGYlpxE9EooNTAnOJLfL/QaQnIybNUYOKvG1d839QsnxKANI70PR1u+dxf7X6aEnYgMQGBHdTMkxTVky2U+Q28AtgVORmRScqeEDi9urGrPieVfnmW16L8QiPBXIYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9TxcJGOd8GKDjbaglkaoMJEnLUqasbBNfPWNFnkirI=;
 b=BAHUA0mXufgvHEpoJ5AlWWrLPvch6CC0ufit8e7KyrqiX4Kr8craitR2RGHodl967S6qcxDyqdcyJ1kFKJCgGeRTo70q2ew9l1Te4aKyJ1NuF6rrIkNZWxH593Fl1dXD+eZlKtHJvVQUVj2qqGOm5kzF714ta0RSNR3B/kP23uY=
Received: from BN8PR07CA0008.namprd07.prod.outlook.com (2603:10b6:408:ac::21)
 by CY8PR12MB7169.namprd12.prod.outlook.com (2603:10b6:930:5e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 12:04:57 +0000
Received: from BL02EPF000108E9.namprd05.prod.outlook.com
 (2603:10b6:408:ac:cafe::c2) by BN8PR07CA0008.outlook.office365.com
 (2603:10b6:408:ac::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 12:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000108E9.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 12:04:56 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 07:04:54 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
Date: Thu, 23 Mar 2023 17:34:26 +0530
Message-ID: <20230323120426.3960144-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E9:EE_|CY8PR12MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: f30b4620-c1c2-4fcd-eb53-08db2b96d19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEHUSUlJmboI+lT6rOBAz8zcUvyB7D9iandeVzrEjBXp2yYRWICgSbMfqVs8NcPNyvmvIC+1tV/0X3vIY/61pzCJp+PU36jJbX4aIZ4aSt8NthSTd2/mNm2Z3mC8YyRU1m6s23dqq6M+cfB/BAsoPikMeeqb2O/b25lpw2Qgwj8xu1I0EHDqmt18deoFNPv4eY2qV9+O4pNiqJqxgoCYSjLPb2wLzDqvbioFtTg6CRUfR9kJy06xg8BR6iEbZKBlK8MdZgQswhf+CbCCokGerC8f98q4x0KDAQP0fRqcI0BIHng6iaqYx6LxWSruHa90j8pSqlp5SdFuQWxtdlpS51QaihQsWeMjnKsaeGe5ZfT6dZEhVEtfGKZuPFw/0/5zn8ooqknwIwLrh5GhY1/5xnR46wnT8Erc4gVGDCeKOBrk52kiHAPlIpepeO2GvrQ5Uo/NycxTMKqEqS+hoVvoTwQbKO85OSwucdSjU4v52U7mVY2m6NMLLXano/jswC+rfZ0/deCJcXH2U/SduDdU6P46qzbJI9t/yq8UgdSWM5FSWLLCdvDpQlP9IgvMHGSCz7/UDKWX5r2jWuqwMkqEoUuaAM99NtafaBXAG2vI06e8T0lJN5ozuVXEnCVojZlW0cy0UCAA2h/1EWLc8MBUjx2baVYaineaWVDAbYvM0UQxJoXiGgmOyUDXzvRTznDdaL7PFGWd1yh+X2UjaFEzNwaczSb09SBgTrJlFomDvpQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199018)(36840700001)(40470700004)(46966006)(36756003)(36860700001)(82740400003)(81166007)(86362001)(356005)(2906002)(44832011)(40460700003)(41300700001)(8676002)(4326008)(5660300002)(8936002)(40480700001)(82310400005)(2616005)(336012)(186003)(16526019)(83380400001)(426003)(66574015)(47076005)(1076003)(54906003)(70586007)(110136005)(70206006)(6636002)(478600001)(316002)(26005)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 12:04:56.4374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f30b4620-c1c2-4fcd-eb53-08db2b96d19e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7169
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

CC      drivers/gpu/drm/amd/amdgpu/amdgpu_ras.o
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2567:28: error: bitwise or with non-zero value always evaluates to true [-Werror,-Wtautological-bitwise-compare]
              if (adev->ras_hw_enabled | AMDGPU_RAS_BLOCK__DF)
                  ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~

Presumably the author intended to test if AMDGPU_RAS_BLOCK__DF
bit was set if ras is enabled, so that's what I'm changing the
code to. Hopefully to do the right thing.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5b17790218811..fac45f98145d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2564,7 +2564,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			adev->nbio.ras = &nbio_v7_4_ras;
 		break;
 	case IP_VERSION(4, 3, 0):
-		if (adev->ras_hw_enabled | AMDGPU_RAS_BLOCK__DF)
+		if (adev->ras_hw_enabled & AMDGPU_RAS_BLOCK__DF)
 			/* unlike other generation of nbio ras,
 			 * nbio v4_3 only support fatal error interrupt
 			 * to inform software that DF is freezed due to
-- 
2.25.1

