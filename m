Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1CDC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 09:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 630C06112D
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 09:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 630C06112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 015BA6EE07;
	Thu,  4 Nov 2021 09:01:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97D796EDFA
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 09:01:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JF5dfadKf1f32htahR7vkshqL0MpJO4OCz+UEWTC4Qh0vE52i2xWXCvMCVbymzTOXYzA4ry3RdEhIg47s2YYdjzWGka/+KQLdOkXjtx9Upe8s/qHrdCZLzX3xy4HYkoSjtbZAufQz7v59LtsKs5x6pfWR0LC9B+KoSAdc1y9V6jBt42vx37lwJA8lim7DmQ1wXsLH62PhE4jDvuW+5gpnGligzKtutBQ6RmlSZWQdGIIwU4aLgYNtCUJoflxbGz9vbM6rcrAdAmsoqeMSRhEXsxHf2PKSS9QC8Ebm8ybeYd0EjTjDIFZ4MsnBkp7TEYCeZTpWOTmGpL1KCLawA1ZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+74+s9zKJK2ijJDTObFhF0AJJEQmFmuLKuI0a0+wI88=;
 b=SNonSH1/tL/2MvihXW/Sgzd73ms/86PdWlCDwYt/ENgOqk6+FJHVzVeHhNMFQols/X2/56cpJkTnKl1DVPELwmcDlkPOh6jwcOKYSYWQrAfKGBxpDrGJ/IbWRZ5Q3G81r7ZUEBdt8k+XA80/oY7yjtlKKGV+XPD3kaNCQsmibHWMcwOrSgwR8jy1QFkQPpPLnnwW4Ms80Nufu4IZtT5KG4vPT6zeDB0xo34kSq6BGrEJ7jevhZ+niflUll24N/sKypW+3mexLdL2smNxHXscTSx8U3RWkoeRYc04+KzpciAcbMcx726VZ6cyR1Ls8fh4uBsZzWprqcDjGD8Mpb6x4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+74+s9zKJK2ijJDTObFhF0AJJEQmFmuLKuI0a0+wI88=;
 b=g2Okhg34LJLi9N1WI+gPkqzbu4QIt8oxQWv5gkev5NHauTq8YIJU9esiLwezz2BBSfxxWJIIv8XWvIvFEXYUhZf+53/hKwsc0zwWoNAbYnpo9ZyfAUEdZeS9yXl4rBblNciyHZyA/UJdJy7VatVOreMGZs/xuqWfzLHcG+HUZcQ=
Received: from BN8PR04CA0015.namprd04.prod.outlook.com (2603:10b6:408:70::28)
 by BN6PR1201MB2497.namprd12.prod.outlook.com (2603:10b6:404:b3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 09:01:00 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::f3) by BN8PR04CA0015.outlook.office365.com
 (2603:10b6:408:70::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 09:01:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 09:01:00 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 04:00:58 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <john.clements@amd.com>, <stanley.yang@amd.com>
Subject: [PATCH] drm/amdgpu: correct xgmi ras error count reset
Date: Thu, 4 Nov 2021 17:00:49 +0800
Message-ID: <20211104090049.27118-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fea4b77d-d47d-4835-13a4-08d99f719f70
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2497:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2497ED211B4ABAF5DE985F34B08D9@BN6PR1201MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E7btM0wFPe4/I5VKAUBuFQyYtOqgEITt+SiwlZGrFPp4jMVxmMLoCnUN1ufwI3qmax+S1ZpibLgBuTLRhK+8Ag3xgYFCZyjrQ5UjY251PxWDgWc8RE5vedlQEhseiNyBGsr+qlq+6+z/k4J46ko3Tfyrh+cg+bIRxOEwxUbCDRG4btDNuktxHOQEn0CyxSPUk5sv/k4PA3AopLEx4rcidq19c8OSgBqSh7TOOHKBXGDf7Er/FAM/XLFNHjHmKp/QZHhxhlV/vXeaCmQTrix/GMcJWsj4YKWC/fLfagvS9gDxW/BZZ8e5TvGv7fXf+5u/iccMUfsKiNi+M4e+LYyLq74vnd1hb6tLCFHz7J4m1j90y2P33UoljyG2gGPbxGxrIjc1Lr15mf2dQjqa2TU7jXAGQejKtXwpdH6Y0epBbwwWApPNNA6BXD1XNcdfoF1PcG0je7du2girTOkD3CygzUQIOYgkpJtt7LHXPklDWaezft+kxZ8CD0Eh8esIVMCTjvG0bSVOlbkIRCO9E+diyJFWiNdmPf0Ag7zehBsUGbCMP7GywsR40pIQOfJgdF0UdoXY46qLRMVNvllbD/zTBXyFVHjn9GHEiitDw+gUNTK1gENQzQtkKONTvYRn332w24hMY8LS1zoYt+Tl0JK92UeOcaFK7c4IbO7jmhFJmFDl4o9s28R/Xho5igfO634iSHfKNDsTokwPaI8PdZ552AnU8gHSbOBHvTxry0G4byc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(186003)(356005)(336012)(16526019)(82310400003)(7696005)(8676002)(2906002)(6636002)(5660300002)(81166007)(70586007)(2616005)(47076005)(110136005)(8936002)(426003)(316002)(508600001)(4326008)(36860700001)(70206006)(26005)(36756003)(86362001)(1076003)(6666004)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 09:01:00.4219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fea4b77d-d47d-4835-13a4-08d99f719f70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2497
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The error count reset for xgmi3x16 pcs is missed.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 978ac927ac11..0fad2bf854ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -806,9 +806,9 @@ static void amdgpu_xgmi_reset_ras_error_count(struct amdgpu_device *adev)
 		for (i = 0; i < ARRAY_SIZE(xgmi23_pcs_err_status_reg_aldebaran); i++)
 			pcs_clear_status(adev,
 					 xgmi23_pcs_err_status_reg_aldebaran[i]);
-		for (i = 0; i < ARRAY_SIZE(xgmi23_pcs_err_status_reg_aldebaran); i++)
+		for (i = 0; i < ARRAY_SIZE(xgmi3x16_pcs_err_status_reg_aldebaran); i++)
 			pcs_clear_status(adev,
-					 xgmi23_pcs_err_status_reg_aldebaran[i]);
+					 xgmi3x16_pcs_err_status_reg_aldebaran[i]);
 		for (i = 0; i < ARRAY_SIZE(walf_pcs_err_status_reg_aldebaran); i++)
 			pcs_clear_status(adev,
 					 walf_pcs_err_status_reg_aldebaran[i]);
-- 
2.17.1

