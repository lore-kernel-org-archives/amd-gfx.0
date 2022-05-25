Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41696C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 02:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E93710E1E3;
	Wed, 25 May 2022 02:09:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1949510E072
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 02:09:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DP/5e0k+C+9B0qGxfDJczMplUnqC1ljzCeX2ZT00mbx6tK0KWjS83rVkYqygqwTpE/lEmxFMeiWTRHO/t1JqoHHtWE0DyMY/ui+WmWOG9DY1ykzbqiI5ka6kX/CM8kd+gKd5ZikCR5w6q2TYFWsQRfNmiASl6gr3edbBdn6fe4zEmc8+3VYK4Vj931JHOwASwHZ0Kz3sFATrjH7kyaFVQqKXdeHjl0my1JP7s6wt/RgwfDHV8jyD3ydT1NO8o3yQTt3wFx9rp444myO5wPgWxjWqVO8yI2V//no5q1fwU+NcdGmagBwXBXPQaFNgJRfokJ9yOeBcW1bw23/c/pYGBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5y5S1Y58vPwSWULRxQcq5P+tOoj7vyrxGtMW9hxWLW4=;
 b=iOMV1Q3qt9oreP4hE7mJJOzp62+iZMP6ZC7kcKvUxkjpaCBJ+fM7AfofDrVlBOxSHKGRcTAqIR2MjIIdnoKbRZQo8P3QORhTIIM3t0DZZzGz0fObHkS0u183u6HFAJlydT8u+8bcp98wYZ1cB/VHR9k96zKQMdcUYxP6TNzfrj32GHSW5fuSwjnZ0HPCfi7K36jzc3DJ2RkCXBIFX6ZvY3vZtsBGKHbQJu2Lby19hYwUt3dUUC6Y3tiLJOSQxePAZHogXfVRSo5yTZEvp/5k7FoH5NBngRiTd+f3drGY21Np8tMcmUDSj1loRnROFKAxKdIZfRHtWtGwQMMQa307uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5y5S1Y58vPwSWULRxQcq5P+tOoj7vyrxGtMW9hxWLW4=;
 b=tU0DyxCX4aTnMiw1oNOEFW77z4VcHcXunAZusN4/exWXZid2+yQERHBcxHxhbgOsK/LhHi0B9VNfHQcZcI6xAcax67u8Xm7tfP8kzOYLFGzdf08zXZcoUG+QcZUqEqsMA2L90W5BKHCTODFFkWkfIOBxZZQlIP18jX611mnHne0=
Received: from DM6PR17CA0010.namprd17.prod.outlook.com (2603:10b6:5:1b3::23)
 by BN6PR12MB1588.namprd12.prod.outlook.com (2603:10b6:405:7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 25 May
 2022 02:09:42 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::7e) by DM6PR17CA0010.outlook.office365.com
 (2603:10b6:5:1b3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23 via Frontend
 Transport; Wed, 25 May 2022 02:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 02:09:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 24 May
 2022 21:09:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: simplify amdgpu_ucode_get_load_type()
Date: Tue, 24 May 2022 22:09:22 -0400
Message-ID: <20220525020926.1951685-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525020926.1951685-1-alexander.deucher@amd.com>
References: <20220525020926.1951685-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8287e125-9a9f-4474-a15a-08da3df3a18f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1588:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1588EAFC3078003F11FED81CF7D69@BN6PR12MB1588.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDNPHfFp8WN6tIzBYqVZ7rHJiEWb5jouFWqsAmlfWWKoIbsiQlYfOM0VThT9YU7Vm2iFPThbS3jS6Am2Tj0mszzgFBez9XY6g89GFBxNhrm7QHTNTeV12Xy8ZuxGZrG8eB093h6G/kaiqGUlpn+a3AS0hs9evlbYs2d5vkfxaf1xZ0Lu2ynM7Kb/jvDRnCBear2kyOmuMOjQBEd1IeUUyXul+NFsq1qqeq78FUQkyrwdKbozCHWbkPBP8lJx/ME6jEHzKvazOQqzGgJECfUrYcjlFjmWBIsoQHOEuNPoBH8ny3yG3EdRkk0zE+iO5A22iwlZzVNP03Gxn5yrr2qQcxnl9bUHm5IuwQKkktBixuC331p8nyal+xW0hZ23mpVloQbncZ+3XruGWbSUkv/dULcMtr2Tp/BGZj1Gr0KCSIHeoKI44+3FDAStpEpJahNLTwTYN4tFv22G487ErEGw2HhCinfkxggGf6L0K7O78tHf6hx/4OoyLaxkf41CA1Zwk8KmpXr6l783jQ1CwriJYIJ9Z6txW5kQTuVNXhIOgM1PdCLsjQteh7+57a+p0G+S3eyrWjNRO348mF2ft1lluKfBIqUo81EbG+A1vImMunOxJVXkgKG27JDdlAH21/NUi56xgjE6Y5UEyeqRqB32PjNKUiHtuXWqgwicjGHuXKZB0lu0eM6pZQRi+MIh2RDGPHAoI6NiLa1MtU9GGFGtEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(508600001)(6666004)(356005)(26005)(7696005)(36756003)(2906002)(83380400001)(2616005)(336012)(186003)(8936002)(16526019)(36860700001)(40460700003)(5660300002)(426003)(47076005)(316002)(86362001)(70586007)(6916009)(82310400005)(70206006)(4326008)(1076003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 02:09:42.2301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8287e125-9a9f-4474-a15a-08da3df3a18f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1588
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

This is the same as the default case, so drop the extra
logic.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index ffa4c0d207db..c312577df596 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -486,26 +486,6 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
 	case CHIP_POLARIS12:
 	case CHIP_VEGAM:
 		return AMDGPU_FW_LOAD_SMU;
-	case CHIP_VEGA10:
-	case CHIP_RAVEN:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-	case CHIP_ARCTURUS:
-	case CHIP_RENOIR:
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_NAVI12:
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_VANGOGH:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_ALDEBARAN:
-	case CHIP_BEIGE_GOBY:
-	case CHIP_YELLOW_CARP:
-		if (!load_type)
-			return AMDGPU_FW_LOAD_DIRECT;
-		else
-			return AMDGPU_FW_LOAD_PSP;
 	case CHIP_CYAN_SKILLFISH:
 		if (!(load_type &&
 		      adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2))
-- 
2.35.3

