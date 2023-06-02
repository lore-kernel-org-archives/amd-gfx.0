Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4621BC77B7A
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 18:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D93010E60B;
	Fri,  2 Jun 2023 18:43:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 553B910E607
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 18:43:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nf0gRaP13F37eAX9om5xnuDQfx95T3/R1KLDqfRs9zr3hdeqilYdBzOgW9rHWkH45zZUMmb726GOfZBe/j7sL0YXL8R7i9EaWJ2UPSB4i78F3TwANaRBZHqFIu0pe5/+O+8RFKl4exKanh2QIBKjxAWrUjRLxgJwyh+8nUT61So23aiQYKROl294ssKp40kmwIkQw+FD6uFa+h3sWksA5UKYiFEy6TwBpjVOgIwrEL7MX6WoC5RUjZYWowJF/DDPCoCSCPk4MpGqg1taZ4gTeWQIvUqjS0gD9HgmGzj3rLMCczguSPNuvj4caJgV2J1hvGN2dDMG61RBfsKCMdnh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8x8q7QuYVZxw/m8rxX2a30G9xfWySIPh1uZ6OlBwQQ=;
 b=YoVPKLCj8KQ2LrvLUmp73YwY4dcyAlZs/Q023++fslyTg2U3n+sB6z1JnLw//nF5ElfukxHBN6MaI0XRJIJvd3+eCh+0iGjrXgwc2brRMqNmCuxmwUvXYw5Y0NSpt2iJ8EkrtTJG5l3zOAJMcNHfQgX+8mDvHpJL+XEKIlesnTjAtM3FF62IecTwVrLwKnyV2NuBwkm4ddRZtQsp+yLaM9rRFV+0gaostTJzmHhbfxphPRC17kWsVfKvFuLhaaaxafUEyDZnZY31+uMUq8DEQb2puGzuKlRCBBzwrngIOzIXqz4NkH9XOXxI4CxPbkP2vQ4ceibYN8cqLYWnEwF4EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8x8q7QuYVZxw/m8rxX2a30G9xfWySIPh1uZ6OlBwQQ=;
 b=rYbTrsvdw+kGsikdF9PTcsN5jFtwFovK1hkfVDq4dM/1mtPLfnQ2QtRebZ7DlF8Op7WVE4+lRV6hE1u+3Uxea2ru3bJ/QnzY7kvXdmfLwvQrC5V3dgpAI0KaC0av+12zi6WCQDCe1jg9qqVgcuYSGu9ZcTmbxV65xSjcopm0c+Q=
Received: from MW4PR04CA0133.namprd04.prod.outlook.com (2603:10b6:303:84::18)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Fri, 2 Jun
 2023 18:43:28 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::1d) by MW4PR04CA0133.outlook.office365.com
 (2603:10b6:303:84::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 18:43:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.28 via Frontend Transport; Fri, 2 Jun 2023 18:43:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 13:43:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] Revert "drm/amdgpu: switch to golden tsc registers for
 raven/raven2"
Date: Fri, 2 Jun 2023 14:43:12 -0400
Message-ID: <20230602184312.752618-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602184312.752618-1-alexander.deucher@amd.com>
References: <20230602184312.752618-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1bb470-575e-4a4a-1592-08db639941c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0EfsfOznP51vx6+rLmHyD4dq89Z7xtdlzIJqTF5UI8sWnStKmo/FMDXSGqP2tf7eL9i/odARPn9Pqmd1QzKkqBV0XhAJl3JBngNHEV+0VLqtrO0VMxhkxfIBIsCzPAfKIrWvVeEKmJnXKxssHyupKVZVeyOn9cNmPc1BfAOZsMqGQN4Vz3/qpR4n8tvv2rKXgDuQWXdxhN1oQ3vR+dtEDugHqGY2wDJKrUHkDL/ga6/wuVUveSEgZv22UplRoMw8iovyUoyFqzECRijbfaWTu0nsTc9yBKT+t3bIy1GqfCWQPJ5o9ZS+mQ8Rnz4tuAl8Uj4v6zaO5QbIZ36fkyHV7yjept1Vb7Lx0OZS8prbmlRo8yKLngGdb1AMUcKFv0YCki+mhM+C8to8Ho9wTY26pTK6tmeel5f69bq8bKY11NDZ86GzVSv6YiYtshtGQhcPwmpqcEfi9LTNXqaSL0sw70KzY4DGD3Y6NSz8nY6WxugLXvOLcN9//r+6+PCV57gdoJYJKasIO7TDSpogh2xDKya3krWtRKlKaTmMcynrlIIGS+yJMV8xssjtTzK79AS4OIcPG+o5L89/R0HsxRgqJIKV9iuduoPoBRuy8+PPm3rPdY/pn/81ChsdnnpO7S78ovTSK/EoNjT1NlEJJAY1g42X7h8FB3BsgIRF+o3rXeZc3c6deFeadB19fsV0oa3tEJtu3kQUpGHP4PsePMtP4aNckCSqw40K47Qw8eJdroc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(4326008)(16526019)(1076003)(186003)(26005)(6666004)(966005)(7696005)(47076005)(36860700001)(5660300002)(41300700001)(426003)(83380400001)(336012)(2616005)(2906002)(316002)(8936002)(8676002)(478600001)(6916009)(70586007)(70206006)(19627235002)(54906003)(86362001)(40480700001)(36756003)(356005)(82740400003)(81166007)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 18:43:28.6494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1bb470-575e-4a4a-1592-08db639941c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jesse.Zhang@amd.com,
 michel@daenzer.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit f03eb1d26c2739b75580f58bbab4ab2d5d3eba46.

This results in inconsistent timing reported via asynchronous
GPU queries.

Link: https://lists.freedesktop.org/archives/amd-gfx/2023-May/093731.html
Cc: Jesse.Zhang@amd.com
Cc: michel@daenzer.net
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 40 ---------------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3bc0b100936b..4073e2ee7e6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -149,16 +149,6 @@ MODULE_FIRMWARE("amdgpu/aldebaran_sjt_mec2.bin");
 #define mmGOLDEN_TSC_COUNT_LOWER_Renoir                0x0026
 #define mmGOLDEN_TSC_COUNT_LOWER_Renoir_BASE_IDX       1
 
-#define mmGOLDEN_TSC_COUNT_UPPER_Raven   0x007a
-#define mmGOLDEN_TSC_COUNT_UPPER_Raven_BASE_IDX 0
-#define mmGOLDEN_TSC_COUNT_LOWER_Raven   0x007b
-#define mmGOLDEN_TSC_COUNT_LOWER_Raven_BASE_IDX 0
-
-#define mmGOLDEN_TSC_COUNT_UPPER_Raven2   0x0068
-#define mmGOLDEN_TSC_COUNT_UPPER_Raven2_BASE_IDX 0
-#define mmGOLDEN_TSC_COUNT_LOWER_Raven2   0x0069
-#define mmGOLDEN_TSC_COUNT_LOWER_Raven2_BASE_IDX 0
-
 enum ta_ras_gfx_subblock {
 	/*CPC*/
 	TA_RAS_BLOCK__GFX_CPC_INDEX_START = 0,
@@ -4022,36 +4012,6 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 		preempt_enable();
 		clock = clock_lo | (clock_hi << 32ULL);
 		break;
-	case IP_VERSION(9, 1, 0):
-		preempt_disable();
-		clock_hi = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_UPPER_Raven);
-		clock_lo = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_LOWER_Raven);
-		hi_check = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_UPPER_Raven);
-		/* The PWR TSC clock frequency is 100MHz, which sets 32-bit carry over
-		 * roughly every 42 seconds.
-		 */
-		if (hi_check != clock_hi) {
-			clock_lo = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_LOWER_Raven);
-			clock_hi = hi_check;
-		}
-		preempt_enable();
-		clock = clock_lo | (clock_hi << 32ULL);
-		break;
-	case IP_VERSION(9, 2, 2):
-		preempt_disable();
-		clock_hi = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_UPPER_Raven2);
-		clock_lo = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_LOWER_Raven2);
-		hi_check = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_UPPER_Raven2);
-		/* The PWR TSC clock frequency is 100MHz, which sets 32-bit carry over
-		 * roughly every 42 seconds.
-		 */
-		if (hi_check != clock_hi) {
-			clock_lo = RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COUNT_LOWER_Raven2);
-			clock_hi = hi_check;
-		}
-		preempt_enable();
-		clock = clock_lo | (clock_hi << 32ULL);
-		break;
 	default:
 		amdgpu_gfx_off_ctrl(adev, false);
 		mutex_lock(&adev->gfx.gpu_clock_mutex);
-- 
2.40.1

