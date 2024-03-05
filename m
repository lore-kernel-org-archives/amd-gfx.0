Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5903CC54E41
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 14:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0119112B4C;
	Tue,  5 Mar 2024 14:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZXV2wPEN";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BA30112B4C
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 14:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/KOb8GAf+IIARnunxTupa+fZgEHiJwEmb0AKBNd3u0Ftd3JSIW9n7WBj0/KO/X2tiuFkp4kVgqqZFNoCVvZ3YTxJ7MD83TPSFtEM29XlLyp61neF33zLUo2LFvnm025zcym5AeV09tYGVkumu6uCYnwERl7dXzjmERNdiXCguyFmHYoM2udiLxvWsBGKWmOEIoxSMHU/4mLjAz6I3+hQGroIAybUgMt5+4qk3yigIw1R+Twc6Ftb4wG5SL6Os5mShRgtw4Uq1bOfqAb34PmKXR87YTHibZfyHMgmZuRWzotoHASjs/GnB34fsjt3+5qXvfBLuzFrfN+i5bMAP8xFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dv7RPiaTwQReftGZHrMPAeDhMvbgG7kr409lccY3wz8=;
 b=E/qXGC9ACpUtRxnpLupQTVEARZRuR7FQk7fgabrEt2yZVb8+3YqwnaUrwz5rXwHHNgL2Uw0RN3RGpj/+1amuKbtgVw57JFe7r+TNWae6P/o/+GRuUHHGRkGk/X5P24UrJULE6kX85dV4vuc06kHYayp4LNcUBoYPbQc60B4lKzMFJX/7obWAUKfNHfyQH9KYh5kraIBTx1+0cKnC0acsHk7UPmYEy6n9i6NvBXYj8XnbGfCn6Sb+84cr0LhRMe8ELMIlQLfvIhTb8MwArdPyXpOIdIEbiWbubqYlpBxdQ1x5inAhx7JpXY2wHYO2VQqpkGdRXk8+4ovc/KiCLXfbWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dv7RPiaTwQReftGZHrMPAeDhMvbgG7kr409lccY3wz8=;
 b=ZXV2wPEN8LHgOCpQa0tKqj8lQGdxXwWCVTfZB3JFRoKPGlnvJof5sbA4yPic8hVsYMxgI8CkafrjBWE8AU7xjKerYkszYoHfcKh6lz/bc9ys6hlGsVbk5idDdk1NTydSLTgEpI4cNVJlk/E16eG/MyPIEyuaR8Yu5vrOpzsWjX8=
Received: from BYAPR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:74::20)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 14:31:18 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::e2) by BYAPR05CA0043.outlook.office365.com
 (2603:10b6:a03:74::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23 via Frontend
 Transport; Tue, 5 Mar 2024 14:31:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 14:31:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 08:31:14 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lang Yu <Lang.Yu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amdgpu/vpe: don't emit cond exec command under
 collaborate mode
Date: Tue, 5 Mar 2024 09:30:51 -0500
Message-ID: <20240305143053.1262593-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305143053.1262593-1-alexander.deucher@amd.com>
References: <20240305143053.1262593-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: 97178d4d-5300-4845-3f22-08dc3d20eb94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJ/C1H4c3UFKmdwPr2/OexAE1qhiGQyOfF2iv5TNIfqRC2nDk2SlpNqYZPmDuOPdjcfqcEqyFgYAdwY+vZp6jYkkRRkbA6PQBLaSXANcJos5Vo4UXX74QTJpaPbxVY6HHvFlY4N4ioTijcjOxQJYHOJcSK7CY9zKvtvebhjagRFBP5YJcal+nwhPL2VxxkXAM55ktgCVZ/bIyxleDcQddXnhVCzquSaiuqHmtHyWIr6I+DywPmuD60xszu3P32YxB4w/KR4noInSv0TVluQOnaCSesqWGNdUNZTlUMDQyPF0HrpAP7IXTuWU7+8ZE39z56O0+x3rm+C0mCjwjh/MmVRhNxIc3grSgEm20AalGKZ/sByXLWW06n55cmYxR1JGeZ4oifgAvycpbK2hc6rOmG1pfjZpX7kn70YTjn+FhuvMmlQZS+GGS1FTpzmd0gbA593wRpUZAlk/9rJ7kEtTK0B0zbQl4yOZe00a3dkScFfUYmGtyc2+lCnc2J/AhctXY+tF8nIAb6rGiINzzQxcUZ1Qoabp5mN/stpUHhUNERQlx4VGYdt/SQFK16nAI8HCbMtr5fnokElZ6ox/VhHiZG3TcT4e2ZK4FyqcwS+cHsyS/uOU1ewRoQJvFcm+mf5o0D+KI8JVQDGWH7QLbMZLrdTxPcgmwaVoznO1FZg6s1O3Q+oOcFxhyAjwAJybIKZTb0/p73fvOUD43x/hYS+REHvpViSRt2Z1wWg/GLrFeHmxNBf7NmgSEF39MsLnCGcK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:31:17.8814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97178d4d-5300-4845-3f22-08dc3d20eb94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Not ready now.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 9d2415f26b7c2..eea2487d2ea24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -571,6 +571,9 @@ static unsigned int vpe_ring_init_cond_exec(struct amdgpu_ring *ring,
 {
 	unsigned int ret;
 
+	if (ring->adev->vpe.collaborate_mode)
+		return ~0;
+
 	amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_COND_EXE, 0));
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
-- 
2.44.0

