Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FE0CCD18A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 20:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9F2D10EB18;
	Thu,  9 Oct 2025 20:59:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uymy26c7";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E59510EB1A
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 20:59:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCA3SkqZ1hSUxSHTkSDX+cwvaSWR20nwneR1kslIqoKvYWe4TxSpKd/Hen7MfPO97/MClMQ1/NL0GCK3m5zsd3rHn2wXt1Y6bEF0qlRPAmoj5HgAf6GDxA3ePW2GCM5nLLqjculdJ4DqwkjO6ewgMWSBsDDzAithleSpoQgVOlaeY/tlvW1oLTWzk8kuTQAgfTUrC6nUXFtZ87sH0HCLVyVHMmKJvPmOYd8anqrzs0AW/7Xwu1heTx1xnL+c7A5L6PesACxZWZaL7nTmYWOCPV7x6wV6gWUq0vR8M5Cf3egK+tXIuXuRJRDSJxDjwnk8V+h4nKf4JwrJbwG3dyaNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tW7sq5wnk5gvW0LJw90sMS37Xhnqt930gM3HHyC/+g=;
 b=ywRwmcvWDyg6tBheKu4DjitjHIO/csoOkEu5BZkiboMQ19LGJFR1LJFykYxW25ELK3Ve1ZlaoGJS7AGRV3dpYoHtyNdjk+yYPRjWehnqzD98r/6stBA0zVbWB8dpDfsYuP4gjvP/Kh99tdqnZyDG3p4ewVkpIY00WEXuQihvst5mdKWqdqER6UxNnKGKGkmi35RtRIATtXNpO/knbzhl6HWF5+2aGpeNZq7y1gZ5v832jY/VE2FA9+MskBoQB8xGjX5/yqLqZYiRcB3LXSoi8KMdSqBEPkv/BNWXlVchSt80KK7KL9GvuDeqwgAt4DwLJs/rAh03Fp2ZWHR1OtCRsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tW7sq5wnk5gvW0LJw90sMS37Xhnqt930gM3HHyC/+g=;
 b=Uymy26c7Q2/8H6eIFzphkPsc1jwc8ULUhfIzzNeaX+X4AYSgfoblyoSEJaPQk5Kma4SygaHJNabepr5SSIprCpQisVspYwcAcKl7RO//6iG92oMin0rq7GFG5Am3V0g1YJodF0AxeQrW7Jwt5JI9gWt3TRZofMn1ERXkWT7u9jA=
Received: from SJ0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:a03:2c0::20)
 by DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 20:59:25 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::e2) by SJ0PR13CA0015.outlook.office365.com
 (2603:10b6:a03:2c0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Thu, 9
 Oct 2025 20:59:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 20:59:25 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Oct 2025 13:59:21 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Robert Beckett <bob.beckett@collabora.com>
Subject: [PATCH v5 2/4] drm/amd: Remove second call to set_power_limit()
Date: Thu, 9 Oct 2025 15:59:05 -0500
Message-ID: <20251009205907.177404-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009205907.177404-1-mario.limonciello@amd.com>
References: <20251009205907.177404-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DM4PR12MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 39014779-59a0-44a8-ce78-08de0776bab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3QMnWLjjZ06y87UhkHmkmlVdGOPfIBV4aF0Z7CDUw2AO8JDFaE/zD/c7Wcz1?=
 =?us-ascii?Q?dsHz9XufprGFl7IWB7EKm+FOspUToUZi0UMmiaHXDLKrBHLqwVa7/G3v+wij?=
 =?us-ascii?Q?+kd0mHFjwMzN6iAo9x7HdPSaQqWsNo/0M+RcZfVTs4uouJSsaFaIb09PYOUD?=
 =?us-ascii?Q?MFzBsRPq3RqIHHXwnw6QWXzoWRbEotZB7R6371WQNQv5Zjqp2lXGABKxI2Q6?=
 =?us-ascii?Q?BJgW00ADR0+R4IZmPtpVSrwncJZVevDJD5553HTgK1xQMmmJPyKqboiCEoEA?=
 =?us-ascii?Q?/VcWTCv3nWfWGmQuniud1xBWTh8cXNTqmaQB9azkd5VgbHd8HiHa5W1OiTlK?=
 =?us-ascii?Q?tUHa8zqGsPsBW2I7qkt+KT8VgtYm37VU36TUdLBSVx4R3bRv9KK7A485xE2T?=
 =?us-ascii?Q?2WTSPDQaTy9N5sdPWuLm8L63N0Qu8tG1e9oE6lgCanKhXt3JDwR3EX5Y9l72?=
 =?us-ascii?Q?teit0i6yDzDCp/7vUXUZ/b/TB/dGPt47I2oA+yAYfGpbfFQhylabXGq6mfUq?=
 =?us-ascii?Q?kouhXbSz2naOvKEbXxKRuqHIURmKV5PTFDUJmLkIiqzAmobdLBO7hgB1nFlO?=
 =?us-ascii?Q?RKn03zZz21tQgy29XMiRm4OetJ61PfwFK7RFT6yqA29XC5R8bX0qdfToZJJT?=
 =?us-ascii?Q?KnXGXVzv9H/0bO/5QbMouMCIslR3KMJeeiMPBQw8QRWylajwSKIE29cZX1EK?=
 =?us-ascii?Q?Dec2UZxOWaZ4NwBWfV2BhMgexBiwwvZGiJ4ncuAY+l2AdzsFJgyeM45UKnoU?=
 =?us-ascii?Q?E4a4lXhkxl62RhfTNWWeopS7TT43BR957Sw2/xn+/qxZ/3mnQD0Pq7cwpcOU?=
 =?us-ascii?Q?Y5x/ThafG42nTef6bDnThO6L8YK0t9H4FdtRWhDwFdnVLumsEV7+XyzuSlIr?=
 =?us-ascii?Q?dB5WOC+akK5MUKnviX12DFZAiMtd05iyf9PTOtnNf/comahZzoPEsy2HC6t+?=
 =?us-ascii?Q?BEnvaacFdwDDTFlkt60jHZ+qUNj5nI2/02sasdjBm8weLlAC248WLxa9y6z1?=
 =?us-ascii?Q?OAPTrx51B5UX6KGLfuUHSm/FkFjtydI+ob6HwHaCwnv0ugS2Jac9kKKmwXR5?=
 =?us-ascii?Q?4ApdtgFMiHXVS61YDMySmHcUXGdxpSc6KH3kh0IRaHm4o0JxruArxOL45yse?=
 =?us-ascii?Q?mGodFLbqZ1Atr+SclV9xrls5MZn0h5PetXotCZ0z1jFYWPIE8vn3j3OeNXBU?=
 =?us-ascii?Q?RTsZ2T/mZfVfspHDBu3qJRjciDBykkSf05FPaudFKaI/zwm0u0Ua68JYwKjF?=
 =?us-ascii?Q?I3PVWcMzde2tp0mjpceiejxTxWbCM1w0dCv7qR1CsvtsPLM3D3LxRMdgmjRg?=
 =?us-ascii?Q?okUius+UPNaQcVtq260fFjSoTn+MLdBM2hFB4lExK7EAosBOm0kR61+sM9Dz?=
 =?us-ascii?Q?4eTy2QaUAHxhE35Eq+pZ2R6Lm3s6nAHfZ7MHcLxES6zLocfUULJ3NxbIg224?=
 =?us-ascii?Q?3kJEsyJLy9GjRCy0AoNY0PK03lt3qOAj3P6zA+ECFzs6HXw5/wGbRZL9QR5R?=
 =?us-ascii?Q?0IHy42s7fX+KR+JiI4wA3EkAhLCa9ZIj2DYTlTKgDVPaBCdOzYn0anT780EJ?=
 =?us-ascii?Q?SmSmd83yzpSo87TwiVY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 20:59:25.1987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39014779-59a0-44a8-ce78-08de0776bab7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747
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

The min/max limits only make sense for default PPT. Restructure
smu_set_power_limit() to only use them in that case.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Re-order calls so that limit of "0" always resets to default limit
   for all parts
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1c5f37cd5b75..a55f94b91bc9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2966,20 +2966,17 @@ static int smu_set_power_limit(void *handle, uint32_t limit_type, uint32_t limit
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
-		if (smu->ppt_funcs->set_power_limit)
-			return smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
-
-	if ((limit > smu->max_power_limit) || (limit < smu->min_power_limit)) {
-		dev_err(smu->adev->dev,
-			"New power limit (%d) is out of range [%d,%d]\n",
-			limit, smu->min_power_limit, smu->max_power_limit);
-		return -EINVAL;
+	if (limit_type == SMU_DEFAULT_PPT_LIMIT) {
+		if (!limit)
+			limit = smu->current_power_limit;
+		if ((limit > smu->max_power_limit) || (limit < smu->min_power_limit)) {
+			dev_err(smu->adev->dev,
+				"New power limit (%d) is out of range [%d,%d]\n",
+				limit, smu->min_power_limit, smu->max_power_limit);
+			return -EINVAL;
+		}
 	}
 
-	if (!limit)
-		limit = smu->current_power_limit;
-
 	if (smu->ppt_funcs->set_power_limit) {
 		ret = smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
 		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
-- 
2.51.0

