Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348A3D49798
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 03:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C146010E210;
	Mon,  2 Dec 2024 03:31:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RyiDJ89s";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D327810E210
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 03:31:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9bPXVpgDHaFtDdvaum4YcIsHIkOvP3WNW4SQoaXwL5lVM34ln7uj9d6yBnf3w9fe8zcLF51kvPyyL6nij0b3DqgPDD7Lcpkd9yXFeaiDbkuomSdbLFvEzxAH7np/3DNo2QwOTBGN/e6DH0bEyEx3ETMIz/JAoqSlgMynu8Joy9kbymJOWKFzEhtP6Iu5Uw3fMtQUY99/H3pYeg/Z+ZpYpmO56TGR8DfmGQ+TqAycrkPmYzqDZLw/wwzsc2z4faCtAtOnjc9AjnVRXA5RW13mwdLEwlg4jri2w8INAiM0q9WkCbr1oXF6Qj6rIPY2XrkVxlW3TonfciSOtTb+6VCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jhf5S1mokHrPPH+LF8kkWsdwIivOS60OlDUPeHHwsD0=;
 b=NlbRoB9nFZqFT57uEcxRZrWneS2oUTu1lT/4RBluKcU5RLz7Zx9y5nHjRO4YOGZYwzszHdnyG1wGq7dcwd50n+0QgPeDlKR3GGA75nzNaxnzZutapAfcZfUnnRc9Uaz2jA43dq+DV15VP93ymdBPBQwNLbxiY+xFQChQhKJv/yDBYzuqfqMeQRhFAevA/p9VmpkgAm0rDz/m72PmZPSz4lt/vamXFaaj9tdF9AcstXSIWIIuuVXV5NMdl1nSqtv+TBULNiKzF1VFT18jE2XC1nzalLNiEMxME4kSCE+wIvNjIBGG6ghILIzlFQ/c1VZFXP/k/5/EKeuXgmfkwOl7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jhf5S1mokHrPPH+LF8kkWsdwIivOS60OlDUPeHHwsD0=;
 b=RyiDJ89sZKTVOk5HE7knEjSHbx31swSRxDcjqiXs5yTWTEji0rS/YsSlHWP7gAQp/QkJ7isoEXm4IvmAeEcd7OvZcZkb87/KNbmEmkdaK/rQdjLkSjRvh4PmssJ6Y//DR9Ea2ZthXijAf513un2588U1aNTRxCR/4FmymHL6ptk=
Received: from MN0PR05CA0028.namprd05.prod.outlook.com (2603:10b6:208:52c::12)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 03:31:08 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:208:52c:cafe::6e) by MN0PR05CA0028.outlook.office365.com
 (2603:10b6:208:52c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Mon, 2
 Dec 2024 03:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 03:30:39 +0000
Received: from jenkins-joe.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 21:30:19 -0600
From: Jinzhou Su <jinzhou.su@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <stanley.yang@amd.com>, Jinzhou Su
 <jinzhou.su@amd.com>
Subject: [PATCH] drm/amdgpu: return error when eeprom checksum failed
Date: Mon, 2 Dec 2024 11:30:01 +0800
Message-ID: <20241202033001.5585-1-jinzhou.su@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: bc057039-96d0-402a-d282-08dd1281c276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QM5eHzKFDUpCnVVHJ53iHEaeIhJOf0lLqe0NMDJtKaoBahBYJfWxXfxl93ud?=
 =?us-ascii?Q?/8CUwNkfhQzrZW+PJnLU4qB8jpaI322ATYn057qIgnwSpKgDn9ZGDS2xUp9e?=
 =?us-ascii?Q?ujHyKNfzS1c7AW4RVQk4gf5Pr+cjkS/FBvi/tjMefuvheSNHwgadYYQX1Kcq?=
 =?us-ascii?Q?gFP4Lvo0JJ1r7v6PoYCdw9L7oYPAu92rIxZgEHLM4R/KAOMWo8jG1z5hFaHx?=
 =?us-ascii?Q?TEfyhXnYVFF2IKVKACq+MXUSjcT1+PuQjNgTBtNuxh20YF9onEZGcbBM1LC4?=
 =?us-ascii?Q?LqwslDWGFIw9hfWCIqxDToa73HIEHupY/X8Q2dnv5PAy8F9/96hQf6nD6ejD?=
 =?us-ascii?Q?HmZm8+bKlDurb4Shaui1WaDnksNwO+J+nP/g1SG0F/SLI9DHiaaJqhcLHxFn?=
 =?us-ascii?Q?AVk3bEcjHISdKqfmcUvG2aSZXMkN5rO1ZLaaZYBaZJW+wPCF+N0EJUpseAyt?=
 =?us-ascii?Q?dJyW2tmFoTo0t5djLcF/1WLQpwDctsAxqqwh+ec8W0JsB8D/C4YPtkzEaECn?=
 =?us-ascii?Q?GfEW2ZdUdETeLwX1IgwTd/hOI71ut6m54t5qawM+q/dJ3p6j00jtrNoYgq1K?=
 =?us-ascii?Q?OTyT04q3S0V4U3ET9PPeIlwKKblVAtpy8ei4kt3/eEMGqmxtdq7xX9CN8LDz?=
 =?us-ascii?Q?91u8trGQdDnignLMT2DOp662upwDeJ6aUfg6yFy0zbiHEOgRXVk1B/4iNOtd?=
 =?us-ascii?Q?w7V1LjKC4PaDeYPt8aiRIRyuWf3Fw+2CHRUf0J9zqKyun0Zn8mrmqLtNm7NE?=
 =?us-ascii?Q?bFjhwiYSU9eO5mFY09Rrghl1VjselkLR7OB1O3TvTyZEDAGjYlM8bWfto/D/?=
 =?us-ascii?Q?6nyV2sK69Y4+DkDMCzu9NIMVBV1H94FdiW33nGFWLydD18IvjOPgTRUX/5YG?=
 =?us-ascii?Q?it7aWx6mEyBqSZj7cDh5P2mXpmeVspIx7abVtrKC8x8do2ZcpZx6a/xWgz/K?=
 =?us-ascii?Q?AGMMMgiw9Sub1W7iVXT+Ki3GnpiOhIHvNHNiZxwS0A25vpTCcAdro5I8YT+P?=
 =?us-ascii?Q?cyTchImiJ/uEfipduIPIcrYjv600y7V9D2mwF2R5Dv/UgqbWOgbdnsDI31SC?=
 =?us-ascii?Q?ZsVb2eL2+udUHNtRB7FJJhqfvQKaHdSoQmy57v9+tceP/VA+dS/LbOjRvp8I?=
 =?us-ascii?Q?HR26fOZ5ks6BnahxOQW3xYitRdGFBYdIioZMRgwCs9mgAv3V0bSvCJbQcysp?=
 =?us-ascii?Q?V1TEM++VaVfmthh/tiXqlq6MZgl5JJMoGkbpFJdoToHjJa+7R9oLmS27QW+H?=
 =?us-ascii?Q?pHZLkvIiHeLL9b8qGM/HoZOJbkvV8B5pLH61/FP/qU2bfiuF//KmUxhAo8t2?=
 =?us-ascii?Q?vdNq1kSt3IpkleO4zrH5ORVTifgmW3jxwilsaf7PUYrxsgk03GPtNML4yexa?=
 =?us-ascii?Q?4rxObcmqrbNDvYWjSFpss/EQmdF8lpniP7e3sVDkWQ+eSXio6Iwejf+SfW+f?=
 =?us-ascii?Q?hTUejBaAkEl6UoGfBbmhUr+C82p+z1qK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 03:30:39.7874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc057039-96d0-402a-d282-08dd1281c276
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193
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

Return eeprom table checksum error result, otherwise
it might be overwritten by next call.

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index f4a9e15389ae..19fe2a4cba46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1412,9 +1412,11 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 		}
 
 		res = __verify_ras_table_checksum(control);
-		if (res)
+		if (res) {
 			DRM_ERROR("RAS Table incorrect checksum or error:%d\n",
 				  res);
+			return -EINVAL;
+		}
 		if (ras->bad_page_cnt_threshold > control->ras_num_recs) {
 			/* This means that, the threshold was increased since
 			 * the last time the system was booted, and now,
-- 
2.43.0

