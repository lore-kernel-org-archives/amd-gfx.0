Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F328E7716C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 04:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1A5710E37F;
	Thu,  5 Dec 2024 04:10:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ab5nyxpM";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ED3010E37F
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 04:10:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yngnKGGNwBi6tMqwk2S5s7+fPk1Y6z2umgmcTAbUQ/MEBOtPjnVEos/CnF9O+JpcjefBu5kJDhX/N0ge0LGwF0V8Ct8H0cc39ISk+cmkAKPk9VYr4sFL0wclGHlvxdhbuqagjBmuWBfFvF7vF+OlDl/0FSh96tgT0oqRqhMEWct4U+HRzOhK3QRqgbQpJNTSxDbDT42j5CqdCBLqdapiJkoe6JWM6+v8DMLcAbLtOd17nh6ZMiiFmngtgbAZR3SbdQWxBOd3eYMUOSy37vqhf5692vK4gFReucyQUMuAN2rggml0CC6hZzv11EPLXHCHYFcUGHV8Np6owxA0Rc7Yug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6OwAA7rz+dnje5wqdOcSinCfXtrHYqISCsscaKxl2I=;
 b=Dzv/UMGYpUVdazGaBd0uf85KUNM1bhpVVQeX1ypvp7MlwWLiv7ZeazdnzTpzhfM7yfyCMDONdfi81W6NRf66w7v32/4m7OatNhF8MIl7umsrBLRnySapF3HeAbMiIaL+a+7Vshy8/CXK0cGt7OPTyXpUrEeoqOIHKnkpaZNAiVIcoPeBMpsFQ/PksfzRDE6s0aaRbYxjNZGGPNKJBsU5o45gTpiQ7tzgBw+F2zrBLePrPGlPOYiAFACHOWxDXk4ApYSP9LDt8kpAR+xDInlYqAjYa6EgU/VSLosVmN/Ov1H3qHJXp5X40aalOuaN0KsAKAF5kNuUO2I1MnnMC0kHoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6OwAA7rz+dnje5wqdOcSinCfXtrHYqISCsscaKxl2I=;
 b=ab5nyxpML7VLdxQ7u3NdhvruwFEl6vYKmbq5YSLktvNcyytrHxHbOm/SQhB95dLGGJY8h8ikw8DJiFYhxra7zOjth7Ulyv1DEMP1RG1Av21nhWuyATFUmVN/6s0lCiCQKSR+4cXt6Pr5BUjQ0D4wkemY2ROWtbn4mmUXtCWO2ZU=
Received: from DS7PR07CA0021.namprd07.prod.outlook.com (2603:10b6:5:3af::23)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 04:10:42 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::94) by DS7PR07CA0021.outlook.office365.com
 (2603:10b6:5:3af::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Thu,
 5 Dec 2024 04:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 04:10:42 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 22:10:39 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add psp v14_0_3 ras support
Date: Thu, 5 Dec 2024 12:10:10 +0800
Message-ID: <20241205041011.3972062-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c6058f-b250-472a-0193-08dd14e2c8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?37hTdks3HYjdmY8clAq80hZP5hIRSK26e6itIUsFkZcUxv14ZwUw6MErjzsY?=
 =?us-ascii?Q?vdTPul7zpqAIcg2nsNXHMmkhfTfDWRmzoqZgoKSmo95FPVdPPBdkaXSfiVrY?=
 =?us-ascii?Q?wjy2mXHfUZtMwZ9f9GSHanwFZL07hh4vmyB3QhKK2EbdhPqySk9cRpn2R4ZU?=
 =?us-ascii?Q?eYDlu1d2P/o3SPfJwvRcPgmsCNTLdUtP6PWtznBUE7JGfMS/Mrou6tOZoRGK?=
 =?us-ascii?Q?jyM3wK+T/bgdJlgroTI4mFNg6rb8XVewN+rz3bTOvLAmMrZgnWPjMk6QMMKr?=
 =?us-ascii?Q?wEzSalqHZNu+n9AsnNScIz9wattF6UE8r4DaetoxKOPUHyX2mwB3OlunbW7u?=
 =?us-ascii?Q?ZKoctsYe3cS0hMkyu+TUzG/VXIOQieC1GUquAXz92pdDL9iIFIjwi0SfwM6E?=
 =?us-ascii?Q?FhBbvKY1+q5gqsmexNMl8m2q73vKvb/KeN1mek4ivyoIpg99qTEAj1jg9qTr?=
 =?us-ascii?Q?NK1CsTjoPMA64qOzn72tXobmLDS4N1ZaWRosZqDenFczEXNKxuUJjt8rtSo9?=
 =?us-ascii?Q?kWEuV04bO8cX171+lHLaHUb2g9By0I0OTObZG6/EW76BSNCzaVlJellgHwx6?=
 =?us-ascii?Q?HGfv200M+lYkfzL7PEgd8hfWtMlvWS3pftXFDcE+4CVtZIq6xfSpgx0iqWDy?=
 =?us-ascii?Q?VCh/9UyfCltROKRTRcQPQUOUYP9q1MaEkzbgpRAVy8ND9ClaeB+Wk418c+2T?=
 =?us-ascii?Q?yMclYKZzJaj5VeZFDWNa5hgpcD9dCxU2iWF7tFxJoTBNvn29FSOmSUPwxjKk?=
 =?us-ascii?Q?InCUxIcSzwGwoYhpO0yQTDhYdS0XN/lYJwePA/XVrJicColUrV4q7Bh4hIFu?=
 =?us-ascii?Q?eMWJ5H/7Nptjm5HlZzdKcjxE4bC6tTwXe69sM9MFA2yzSP6hRQ4RIYzlJw7a?=
 =?us-ascii?Q?aCQmvNql4BKfOzaQ4xLGuZtabOhzz+xHNNsyu3DppCsmyHFpSt3Q0E1qufIH?=
 =?us-ascii?Q?scwqsCTLVKmAlPF8w+ESX3GXh4Hgr2fodCi9soURKblreTUM3JbtpYTDh9ns?=
 =?us-ascii?Q?uF9a3w205P2bhEDQHEcd/SUPaRXpaA+zWUkB8o8PU98PB6Xo0rcy+ICQ26CI?=
 =?us-ascii?Q?JfwL4DgFLaxYlHVl4wdal7df0NLm+jjfhpnPJXXHJUbYhSdjA0G0h3mGqkT0?=
 =?us-ascii?Q?C5JWbKyDLblJUr3LrLTkg84+eAkkpbdOODmQqSWvgB1BOrsFMk9iSjAoDhGs?=
 =?us-ascii?Q?1UsXVSIRCz41Ns7wospDp3Su5Oh4j61mF9vMCc33zxS47eSRfjif0dHZT+zQ?=
 =?us-ascii?Q?KTYB/kUuWqcviR+pXZdtF/SBsin+TUlUn2R/lrZxxvKMyuIGH3VCyts/HCUz?=
 =?us-ascii?Q?rVXe1dvPdq4AzniZLy87VZSY9+qbOReY1pyfhIgu8lZn51Is/QEOaV725p1a?=
 =?us-ascii?Q?pC9eK7Y/Ou/GjMIVWACOqm594L8LDQKYD+rQKntWbEU+Bl9A4HFPxK644ETw?=
 =?us-ascii?Q?hNgKJ1GP9+xCU+hXNWXK/NAwEp0Yjiqr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 04:10:42.0108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c6058f-b250-472a-0193-08dd14e2c8d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054
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

Add psp v14_0_3 ras support.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1de934cd5764fa..02662eec6776f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3581,6 +3581,7 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 		case IP_VERSION(13, 0, 6):
 		case IP_VERSION(13, 0, 10):
 		case IP_VERSION(13, 0, 14):
+		case IP_VERSION(14, 0, 3):
 			return true;
 		default:
 			return false;
-- 
2.25.1

