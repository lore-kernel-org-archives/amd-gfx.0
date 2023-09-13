Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD88EE01F1
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 17:15:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE10810E0F6;
	Wed, 13 Sep 2023 17:15:31 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE2AA10E4C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 17:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TW+xPzxlWzCRpsCm6KHV8aYFoU6A+4zxrHF4dT1QqgWNXAYut3zw0AqjbLEBNDsQbKhihS8jsEqKJy9hCS7dBucgWKpBSCmCs/zA4T+SAx+TxBlbzqPAO1yV3LtlpmWkqcwqNT7xH2ScV7Y3MvnGiEikfg9Y84za/uw84mm7daqqT65K4wCrz9EowOfZajXTnYpnd5dan4zoJ+kIqvFjNHCOt7gIMG+i5hOKUI4NgUQJVR8ksLvkiWcladK28/nvyisKGJm70/zfk6WRsJ/6ITFN2cw/6LVjCRPbp5wpCS+JgrXLRip2mzH0Kf3j7H5sh8Il9Y6mEdXYF63O57cAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UluWBkVRV6fbSZ2QA04m+x9Jr9jvo3PEoEKFbT3t2NA=;
 b=O4ujk61J1SgBTomtNQ6EJiQFDKCvNPhx5ZqHJLqEr+rgPxcqa+JmhhEx/MSm4UlT0MbRabGWPxB7jyc0CI1a0BBEEX340N1SPQ6dZC8Z1u+1cdMxneUHubzluMgisW8AYtMfVtxxv/VQp0z4LyoV/F3oqYveqontddMLlC9+1mfZQJTlHyd+JInUiHt0nHLIb4Sk4jDVo3flv7SJNrC9cj0hvliop3k/qTxiPuauFb1bh6q65FFKW/LibiC56IssTwQXXpHXcvysJnlLRxOoF/KSvXE2ZXAa4CcttPplJk8fz4OJExM9e6PFaCtzCMsIEkBHajxsn52Dy+3Fi9aDlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UluWBkVRV6fbSZ2QA04m+x9Jr9jvo3PEoEKFbT3t2NA=;
 b=mjpluG1qs5k2MK3H38LIf/zTsaNBMetm5qvksrbcqvomrAhseEhl8WvmdB87s/3zC7+j4Lg+f1GNj+Wh9K6i3HKtLSh1Fa/60dHxkZA1P1eIx2O/l29bXYf77pP8lCJSZvFwvVrt6avurCIe87aceIgY7woi30P5cERhZNg+1O8=
Received: from DM6PR13CA0043.namprd13.prod.outlook.com (2603:10b6:5:134::20)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:8f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Wed, 13 Sep
 2023 17:15:26 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:134:cafe::27) by DM6PR13CA0043.outlook.office365.com
 (2603:10b6:5:134::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Wed, 13 Sep 2023 17:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 13 Sep 2023 17:15:25 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 12:15:13 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/4] drm/amd: Drop special case for yellow carp without
 discovery
Date: Wed, 13 Sep 2023 12:14:52 -0500
Message-ID: <20230913171455.153412-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913171455.153412-1-mario.limonciello@amd.com>
References: <20230913171455.153412-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DM4PR12MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e5419d-e83e-4344-eeaa-08dbb47d0589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjtL3OzBgtmiNR2utGpHBR/su4zVv1URHh2MCh+YVmoEAJaX7b5GYRlTBJY5ZTImB6Aj86A+WlboN/8crIrfKp25/7ZOXZSWuEkZNvReZeEa3/8cGULs5EZti4gLfgjk33v9V8Kh9F3Xc8NHIqcIWn9U42mfADvicKbCVTb/yJrthkXE5bfqSxp8C/WVwt8hNPMS3m6Z2myehT/xRKmocpzTar8+grD+4C9WUsgFpPStfQ/Kd47DgHtIpGQ8niIHFqSkiK8tskuTg56IZuWjItEVHw7npBb3mh/W2atKN84DiTO9tlM1d5kgKUjY0A8LN/j/BmDszUaWObCN8U33XXE66welCajV3nlDa0ZvjjprDQFOUVdGdczoUPbgDBjyerECMwI56pgNHazan9Rj+fmnXQnR/vBdIDSRkkW50wFsNztlOCgsAz5zDrjWGG2w6qkvxuqn4nT8IapPGMmJL3muMQLJ/Z1dypAqEmQyaI8skapIqC2bLmaFxffKeLJv8SDMAqmdYNS1UcvBZggNtW+plZ9JX2JUUlm8zfNU6yhoJ708RNpRWgxJZMfuPkOhwuDHF6n2F9ne4M9l+oRG4//hrsgEe/r/miyB0o88iDa1HhfFUfgriXpJqFoNbvk2dBn57uYwNx6l8m66yWnx4KH70Uv+H6Pfr0iLT8/R63iFo/PnrNQ8MJCnNPHlENb373BSDjp19Ov9wM0xEe+VdLLkx+NOHfTw3WFKQaZezAwl6QHo2OS06bB2SDVWv83nrGIPNe81EodG1936G66YKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(82310400011)(451199024)(186009)(1800799009)(46966006)(36840700001)(40470700004)(70586007)(47076005)(83380400001)(41300700001)(40480700001)(6916009)(336012)(316002)(2906002)(54906003)(36860700001)(16526019)(6666004)(7696005)(478600001)(26005)(1076003)(70206006)(426003)(2616005)(5660300002)(86362001)(40460700003)(4326008)(44832011)(8936002)(356005)(81166007)(8676002)(82740400003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 17:15:25.9113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e5419d-e83e-4344-eeaa-08dbb47d0589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

`amdgpu_gmc_get_vbios_allocations` has a special case for how to
bring up yellow carp when amdgpu discovery is turned off. As this ASIC
ships with discovery turned on, it's generally dead code and worse it
causes `adev->mman.keep_stolen_vga_memory` to not be initialized for
yellow carp.

Remove it.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index de7b379a9cc8..c7793db6d098 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -725,12 +725,6 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 	case CHIP_RENOIR:
 		adev->mman.keep_stolen_vga_memory = true;
 		break;
-	case CHIP_YELLOW_CARP:
-		if (amdgpu_discovery == 0) {
-			adev->mman.stolen_reserved_offset = 0x1ffb0000;
-			adev->mman.stolen_reserved_size = 64 * PAGE_SIZE;
-		}
-		break;
 	default:
 		adev->mman.keep_stolen_vga_memory = false;
 		break;
-- 
2.34.1

