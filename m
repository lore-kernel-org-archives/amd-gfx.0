Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A18C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 21:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A549910E34F;
	Wed,  3 Jan 2024 21:55:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D75E10E34C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 21:55:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6V69JYOV/HfT7vsydYzVLvfZd73J4mc5rdqBoip8MIAxNn/JT1H96m6dCHfS0atCqScKsN9uA5wVDUvi8R9g0aZCIUxlSvhKtwXYhoFpikFB+fzw7p863FThYOOpFyqvk9MrbUw4tsHeHuKTlo7Ndv9MLOGRXY0qZAMWqYVBRIGRBPb2PgfTTkQDfTJyCL94F+m3xRjEZenkhNNmgztE5C1zeMQ/z6J/8byx2g8hWv35GcW+rhCytzSKOV9e8SngCO30pGBi2jJoT4k6VOiAy5CAQTpR0CBFFg2LA+T/FNwItY7o9w+IemFX7BwwfjcWp0mocpBMR4zNecw2f37XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AygIX+oKMIkIvZlQ35bUUKnfFIage2N9cU3UnfHFafI=;
 b=BZnNViywKAqgBxXBfB3jtFMUuIQcXUVPovrXbfQNzgaQWyLarUX/72pbRtAjlBVDNg/5/JPgbUDeLKOvW0/cvS7+9V0GV5czv1WootnFrZ8tZZwRW1CoSUNFFgZy/HWeVhlRkaiUUD3FNSLc3EnWuACI00PwJOwd363+BfNYOwQ0AZ1Q57cUGTKimKaPoxrKpFa9qfgIosuRupoGl22nQupDe9fwbB++X51dfo7VXtRJ85YmCJWj55ikTTI9RKxEgxrqJp+i8xJv0XpHDh1S5O4tcnoWDlPl1Fng+FEkg+NHzEZJmMw2XQYda/egDXk0Butaxob4QhsXTRmv9yLrcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AygIX+oKMIkIvZlQ35bUUKnfFIage2N9cU3UnfHFafI=;
 b=l/NTu8xiKuhM07dnWAm4JiugQosBCFI31uHoWK7442iqD35Cem+P0fz9eJJ5rSHuE3SXBfJaGYXiDuc9NSDiuigrxkB9fTwCHx7EaI/Y6fcFzhHmNo/WQ4mzF4VD7XHzL3Dz9/ErlvRmIfojGLpZSOq7giAWxDGN/CvGMQGro3E=
Received: from MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::6)
 by DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 21:55:55 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::29) by MW4P222CA0001.outlook.office365.com
 (2603:10b6:303:114::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Wed, 3 Jan 2024 21:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.13 via Frontend Transport; Wed, 3 Jan 2024 21:55:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 15:55:53 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/gmc11: re-enable AGP
Date: Wed, 3 Jan 2024 16:55:36 -0500
Message-ID: <20240103215536.1780386-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240103215536.1780386-1-alexander.deucher@amd.com>
References: <20240103215536.1780386-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|DM4PR12MB5328:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a0f855-df90-4dbe-738e-08dc0ca6c2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bOWh/VMkDBUzUj+qkua330XJ+6Yi9NNL6rLwpmy8qAXkU6kRA/kFGDCtQKTDCZNRBDrDA1SyguyHAj4CB5G96Ky6GurA241OX0Qlz0ZZ0KLpHLq10DJRkI9hvwjEeIszFrE6lasv2JfJXMsja2ho2yATo0LJYGelUzEelhKQTp3/8kFiCiGzPDBx0382kxCVjfLfS2bw3SbEmo5728Apls1hlZDszAtArRjtT5A/4hvCqC5MR8iL24bX7/rUfAt2G5ZJR68uzye81upmqg6fkt9cHACa0GvaKCvE7bwnEcLGdZz9bEBEYBzldtenf9ZFxl64FSGSQQWGqu07GamkyqeQ2HPqQYzrOZh+6KgNAdMhXzWVmRnd11CV8Hw7weLnXRLeoiT//4WAUNLH/znlz6tDLymkto0xOy8zmnYl8/kVQkYToSvwCk0swxmrLc7iK8ynBOoNqHcnqQARb9NiWgDwbcSu7Ab0+WBmpcDtJUT5+OpPIkysxxOtkGT5Feky8+w513DXyH8jB0Z7xHYT1jDE06LMHa5Wz4ZYpdZMuBuV2zk01Q5wFjluY5EwcKZJfPHdYxjMJn270ZjMvKgIez5yTCo0NFnUJNjqLyciKu21XxRSxWsYnc1sGXK+MfGih4WLDunD44EHVKmzB0rlhuM6Oj8+nLMSszkpGQKlG7iF/5F5tpAwWH945Rkm2OZONR1RyEYDlvfXJOjtIBTS7YaDTWyzQ7j9b0X2y3+r9Mgr1o2kgyLLaUv4MR2Cnh2f0gX6xIMtl2ZEEbl8vtQlcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(426003)(26005)(336012)(16526019)(1076003)(2616005)(83380400001)(7696005)(47076005)(8676002)(6916009)(4744005)(41300700001)(36860700001)(70586007)(2906002)(8936002)(316002)(478600001)(70206006)(4326008)(86362001)(356005)(82740400003)(36756003)(81166007)(6666004)(5660300002)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 21:55:55.2722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a0f855-df90-4dbe-738e-08dc0ca6c2fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5328
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

It should be fixed with
commit ca0b006939f9 ("drm/amdgpu: fix AGP addressing when GART is not at 0")
so re-enable it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 6c68135cac9f..906f23d13975 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -643,7 +643,7 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_HIGH);
 	if (!amdgpu_sriov_vf(adev) &&
 	    (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 5, 0)) &&
-	    (amdgpu_agp == 1))
+	    (amdgpu_agp != 0))
 		amdgpu_gmc_agp_location(adev, mc);
 
 	/* base offset of vram pages */
-- 
2.42.0

