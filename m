Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A91C46CD2
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 18:11:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A265710E6E7;
	Thu, 21 Dec 2023 18:11:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F46410E348
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 18:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nm6l3XWODn6ma3hnlIR86kfv4deyzA2Xh/1jcjjlH3SmwQT30pyAa5w1wLxA6DH1VZNmklZiOnoFhlgnmlcTssAfCGSrj55AiyEaaMaKKcglhmbSth5I/TJM/YCev4/A4pfLPRqAxeQXELWyVmMwD/g1NKt7OuuAHD/xEa3DPTfFgZ6PEAF2cVJvRdMHKmMTYwGfqj9ICTCqAUh0OWKIEFAfQoBbACt5iNpri71sx8gsQUIfGUgKUnPE8nJqMDn0IFL1RYqbPkhQbks5vWuUOtCecAXq2l+AOfwfOX/gpAs0E+BTHR5mZAetlKdzkx2+yotrUslUDocbXet1esQcyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROFoFFazbs8WyV/aGxk15ueAOKCBvl9UQncq1A/2L44=;
 b=cWbv7YBqlX6eTPQd2HyeflyUvJiRHYCsvYZPbhHrR29yT5YOBV4U9qY/KpeB0/wPHAcaxCxHUI2rLSU6Qo1OojS8fpJT8pcwCR9cKju05RJm6H7Ne7KgT439kqFjqBo5S2ZtyuMIWM1HzJMk2MsVCxJvqmo8y+bNV0/k0E9kP1iNW2w0xrxQVFnx3AWy43+QHriC/WxTCeGgEONimpdZ3kJA13AjxobbSMXdBQIvkJrQm9hb/n8l76t1dyiXvlJo0m5ewxya0O4Wr2e35WgExWirVTPlHAMr69cnXh2uFODFiQw+EMsgrVj8rK0uhn0vyN9hhJ4Q+RfJJm7Q3K48mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROFoFFazbs8WyV/aGxk15ueAOKCBvl9UQncq1A/2L44=;
 b=bw8kFW216ml+9+nul/j4xNdD6yaBZ54lPz9RXTtAuGFn3gLo4FCqhoeZQmVd8/hD71beyxuphD8t3zE5fB1Wp7Nv+h2EXzF6PPk03XEBavuKzLz9eCTrLIow+jzD7RW9BR9jCS46oFORRs1Aqz0Srqyd1CsqeNcVwBHI4OYTJN8=
Received: from CH5P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::26)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 18:11:23 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::c7) by CH5P221CA0019.outlook.office365.com
 (2603:10b6:610:1f2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Thu, 21 Dec 2023 18:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 18:11:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 12:11:21 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: skip gpu_info fw loading on navi12
Date: Thu, 21 Dec 2023 13:11:06 -0500
Message-ID: <20231221181106.17924-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221181106.17924-1-alexander.deucher@amd.com>
References: <20231221181106.17924-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b69960-c6af-42e8-76e4-08dc02503d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dVNh3r0Y13UiJoplgFoaHh2+WG2G3G5W4TRWVkBQli6KB9aIe/xl5FpRlrfwwVGj5wwJwhdr9BxlIY5is0/Lzo1XcuensQBc42CquUd8PjAwVSPo9G9cM1wli/qZClSf7EJfX147gt4TFQG3ivhb7ZqLQ4EFBkY+Vv9zKHI7m4Ws9y9C4yJcRxyaAJz0m7HRK+sshlkRO4UGd7O/tVTtM67gzzqYT6vzB2E795aZoTCSaKByE2VZ8VvmB5B7bvGxFPhIa69htyaHTksT9jlGhxyKPZexGd10cmO8yYSY1gWLpx+goZFaU+OlpGpN8DsLkhoarRR3lYHejhZpNCue+rNdK6frBER0ewCpTtTlBe7x0QZXRE/eyWS9fcC5QDg1pzFilnO/2Xk1heaa1GMX0pqay44S7/aUikuV+cxRu2EM9h5j8gkvDbeDlHRTw8rH4qxMa2WXgPh9EHVOwbYWCs2DnqbTvtezh7t7dO4OhM73GMXL7AVyWSd2XkzhyLDqp6QVH+Qj/5K4rwKsz2pnUvvfKwSM7e6kUJNuZ2URyq8VW+8px9WpIlZiJ55iUQwNwzXUhmuXad8uZlNbgR3F7JIkmYCzeKknvfo1IL72xI5pSLdt7nbLkSz3vdsqRc/pYc6oK1Rs1bMM7b1Zhaparp7hz8kDUcAcne4xpaaSwoeUbcBvmZYGBtYM4RH1m/LAUqMYCYVkV6w5/grmU7RuBuEhr99mPyayfeZcNtDJoV1L5Mt5lotsqfvV9AZaPNO+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(36756003)(47076005)(4326008)(478600001)(70206006)(36860700001)(8936002)(40480700001)(81166007)(2906002)(4744005)(5660300002)(8676002)(1076003)(966005)(2616005)(70586007)(16526019)(316002)(83380400001)(26005)(336012)(6666004)(41300700001)(6916009)(40460700003)(426003)(86362001)(356005)(82740400003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 18:11:22.8440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b69960-c6af-42e8-76e4-08dc02503d52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259
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

It's no longer required.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2318
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9c1ff893c03c..71e8fe2144b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2251,15 +2251,8 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 
 	adev->firmware.gpu_info_fw = NULL;
 
-	if (adev->mman.discovery_bin) {
-		/*
-		 * FIXME: The bounding box is still needed by Navi12, so
-		 * temporarily read it from gpu_info firmware. Should be dropped
-		 * when DAL no longer needs it.
-		 */
-		if (adev->asic_type != CHIP_NAVI12)
-			return 0;
-	}
+	if (adev->mman.discovery_bin)
+		return 0;
 
 	switch (adev->asic_type) {
 	default:
-- 
2.42.0

