Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C30C61D85
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Nov 2023 15:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C71A410E4D4;
	Tue, 21 Nov 2023 15:06:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 953F410E4D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 15:06:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5cVOEt9UE5rMhymxQo0Lcu503OAj03n8SvBvAdHWJf0oC3QCZFqA1hGbcTnQf5v8DNjlK/ds0ympqTv8jYxPaOmumu5W4JDKsutMKRWcferYqFDvQuu9EoR2BqNfulOsY7KII9Cviva77wDe34JR3rubR22LestcV5EdVgNUo9fJvqpEq3masc0H7sagPm/NWIkYMejfwS2X8FNYWMnVR0Qwm2nPah6s4xh8AMBMUaziUypQw0VzpYP4tog1UmOcEaMTb0zIcHv07KnylGW8CxPGwvoBOLNtPFspu1Hvo+LluqH4Qaxy5pu+xsS+Q56AXASojSBaf2dGB3E4VwlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLEHUkpzdxtKDjLBNPGGRoxFMr//N21of0Z98V+FWxE=;
 b=eQBYSX9ksBjQ/jyEx8N08Fp5ky/u7rbD4ayEHkXrIux7y4F2ONjsUuMsZfDwm5XwakMQoXbPvQ99YxbIUMT0nAcOc31VP53Zn5kv7gskULLXsaCs9/wI4P4L8i2XDI/JHqXGki8k+zsY2YTXcjveRe8n2k+C7HM4Rfv/C9p5/8vqn+LJIOAu99yFTTmNbDJ9NFY3dGcn0rY/guNn/jhtVh9W3p4pymRBhY9xhL3g0dTfGOVKc5BNdDn6QVYjfSuazbPTcxNuLp0gl1SO9fVHh9YMnjCGJTzTWX1/6KP9LyB8stteA5L1QjQ+Z/M6C3wPl1uDlptOhvbm/j1481DIIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLEHUkpzdxtKDjLBNPGGRoxFMr//N21of0Z98V+FWxE=;
 b=UfmHDrxD7VeY2cwb/Uws6Athynh69EAbv1Vy16euvYOgNx8qNmCcsmhQ1kxXUn/m1Z9FNwYXt4w3aDAGB0AVetgpDXaqqJHZ184l0anj1fGS0kMwAsyJ67TnebaB/IJT+rlHTid4o8M5IpYmRR19SHyyYXV0yZEVaAhqEf3tLf8=
Received: from PA7P264CA0147.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:377::7)
 by PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 15:06:14 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10a6:102:377:cafe::88) by PA7P264CA0147.outlook.office365.com
 (2603:10a6:102:377::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Tue, 21 Nov 2023 15:06:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 15:06:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 09:06:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/gmc: check if AGP is disabled in
 amdgpu_gmc_agp_addr()
Date: Tue, 21 Nov 2023 10:05:55 -0500
Message-ID: <20231121150556.84900-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|PH7PR12MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee67d18-dcad-44d7-caa8-08dbeaa36757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9AxsONyI88u/6J1Kndk0PzY76kkHsKR8a9n6abgyyuPRTZM59W7wlb4IF0Vu7qsLDvNU5qnFOh8PiATckF7SutIuBTUqJcHPHTotP9Hg4zwuRuMhs5jMothtkPhGy0WHEak7puf5bGuZ62CLxLMZtINOvh2p2xKN9G5lPeXFovnF9fw7ouKZ8hpESQCibbpF9KeWN7iYU4K4Pc3VqY/pTmMo6uVzPGnZMgNv9B01mVbpecFEqUe2XFx0YHEf8geTo1FQzUich0GytDhE9Ch6ziPzD/ndUYUiiZ7QOFz+vzsLisrxFHKKW4casv7ZTFPPu6f1kXBgZFWLnVV4pjKXua9/gkQ6TRXr0eftvy1xSa4p5zbAn6csAy+2niwUYkk7HrY1ijZvZ+tLjZFmVGXd+hoN3TuzdtQoUu+kqbgWw+CVToZH/gql676Z6Z40NiKQhkOZ/sCBc0ONbLPRDDiCF0GLluciGRr4cQaNDpnDHl+tK9LRbZSf7rwaAqQapYq6TdAXBDu9QTywXAwxRAgxYbSROZbJi3WKoAGsJecS9cfN/3bKu0cg3YY+XzE5DN8mcxz7LtqeprWjQdYmxXMjBNF4M1FYW+DSYNqUUNeZNtGEipmqtNZGstr+1WcGiKtpEDn+Ihc3uzAI0fviX0xFdR+sPlVR5pS4qHMjDIB/AyudZ104Y/x0TmsHbEUb+rQdOa1cMnQYbEtMKFJLyRq3PtPSMMR6dthfgn+F5+CQGbB5l21fM8KW+bv9ka/6/MkHzEMQMMLa0v90OYzTSzIB/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(36840700001)(46966006)(40470700004)(86362001)(5660300002)(4744005)(2906002)(316002)(6916009)(70586007)(70206006)(8676002)(8936002)(4326008)(40460700003)(36756003)(41300700001)(83380400001)(356005)(81166007)(478600001)(47076005)(7696005)(82740400003)(336012)(426003)(2616005)(6666004)(26005)(16526019)(1076003)(40480700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 15:06:13.6807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee67d18-dcad-44d7-caa8-08dbeaa36757
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8593
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

Return AMDGPU_BO_INVALID_OFFSET if the AGP aperture is disabled.
There is no reason to check further if the aperture is disabled.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 5f71414190e9..0f85f906791b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -181,6 +181,9 @@ uint64_t amdgpu_gmc_agp_addr(struct ttm_buffer_object *bo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 
+	if (!adev->gmc.agp_size)
+		return AMDGPU_BO_INVALID_OFFSET;
+
 	if (bo->ttm->num_pages != 1 || bo->ttm->caching == ttm_cached)
 		return AMDGPU_BO_INVALID_OFFSET;
 
-- 
2.42.0

