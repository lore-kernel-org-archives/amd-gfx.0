Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CFBC02183
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 01:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AF9C10E4A1;
	Wed, 15 Jan 2025 01:41:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZV6Yu4c9";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52BDA10E4A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 01:41:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtecKpRAyxRkeJsvGK4b8dhfBNEAQlW+oEptVs/XewmxJPn0lvXLWHKSfBv5aAjKHMXItd8w6kma/uO40Fw8tHGcGZ9YhKR9y11ma1xHSRwthdesBJKEh95VIrGBMDAQf/9ZePJjatMNbVl3YYMrCk6hHrOr1+kv3K3UqPC1HElpzSWgLTF9C+TlsY6wnqWXZKHSTZI61RKftbPuOkLZj/xd1iyT68woEmUJ+EOBfkJL6HpuUQMzDD7Si8YOfpHkDrevdLl0KVe11d3bnfgnfX6aLtKLcUJDmOHTvvmvByQidDHduJXvDgxjlYHcs4PfHHEXqXwNd6SE2c/c3q+GWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TGrbWjNd14bOXk3oqdErr5qOXfuJW1diJgrZ/QR3Gc=;
 b=pdYHVsTulKvWwJekc5bTh3ydjRwsWpS/BsSdFI/uUuYj+voMQ9GF9cjIjG1hH0f81fnQDcZYye3ipbfjFGxjNohYgc0a/zWLpNpbO6KH3tSXU+p3CuwYm0CerOxYZl86WFGSNiOXeC4mLF9Fv2mEK7y7KQMpx/pgfDDPRYp+atj4xweUt5stEzlEH730Hsg4q4bLOQv6inVMPdt9qxaaGznozDNrY9Cst0pUmUXXsDJ5bTfaJNOjHYOeG/5n8NAYIMK8rpFeLJF3iyfp/ccztdroAXjuH8G3owIH5lZvoX3PAlgu/7UNZjkldQCecy8cjjsI1ATarcunaL/EbwZ1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TGrbWjNd14bOXk3oqdErr5qOXfuJW1diJgrZ/QR3Gc=;
 b=ZV6Yu4c9U/sLqbeZ41PpafnfJT0yTRIqOd1urp5R4hKA0CW/0AMad8OiDuJpmLrGP0GGsOUBHuB/87viL6lLY1xQtkVpImaGhETAF+z06f0K77unNb3/2KS8Sf4kvBKZNSzAtqL+HgHNzJ4pavA6DN4WEy4qk8pUZ2K4RNx5QkE=
Received: from BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::6)
 by PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 01:41:18 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:59d:cafe::b6) by BY1P220CA0002.outlook.office365.com
 (2603:10b6:a03:59d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Wed,
 15 Jan 2025 01:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 01:41:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 19:41:13 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 19:41:02 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 14 Jan 2025 19:40:55 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: Refactor SMU 13.0.6 SDMA reset firmware
 version checks
Date: Wed, 15 Jan 2025 09:40:35 +0800
Message-ID: <20250115014035.3681642-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250115014035.3681642-1-jesse.zhang@amd.com>
References: <20250115014035.3681642-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|PH0PR12MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7a6b55-f6f9-4524-a38a-08dd3505b422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jgg2Mco5zHgKHpAqsnD+dVjkb3n+5TiUa4dF98Os+kmzGJKk3B6ys6WtxUU4?=
 =?us-ascii?Q?ICp3obnCGiNVKI8mJTcEcKv429E9aFJyGMH9vCbYo6JYuGIJnDym0O1mPcJ/?=
 =?us-ascii?Q?8bo6Ax2Ku2qV7v7HC2vdZWaAYHpVnWV5grjhZeLnnHRCyPrRAJYQHqHQojkr?=
 =?us-ascii?Q?KzfaacQaeRx3orp9JFwTAzYmyzdiq3TMaqk8fkF9UAN9BSGdlccaW4F4detH?=
 =?us-ascii?Q?VwVuTWU2T+leMQotKu7xy+1rQ5wezL7EIjOFha3hhvyA8PuQ7gx+Yme2WLfH?=
 =?us-ascii?Q?svu1O3ZHUF5/5RgCF0nBNEEe79Avcqi2i2fYdYvitxV4aiXzUT/XLWnO/fhL?=
 =?us-ascii?Q?asL2vDKdITmTw/QUlMFZJz0+tRr7uY1rp2bcbll9kiwHgE/xrJ4xqOGQml8x?=
 =?us-ascii?Q?fYcBKogbqI55bO6BuVnKxyXzwUF0QJqzS8ayCPnJQWjOqxBOOLyjIJgHGA7A?=
 =?us-ascii?Q?tzLJ8roGBQ+7eyGAStniXNQOl4aGDM6CGH/kMWM5YEwM441bv7+tOSlTolIS?=
 =?us-ascii?Q?uLJK2eBPJuqv731GtbtketSsnnfV5EANYOLpy1liO9QcBppCEOy00WLD6FNl?=
 =?us-ascii?Q?WgJhP1OPmyy0huR+1f9tl9kVKcvPQGzL4RXDTG85iPRgnFHmPG6avsNfTe76?=
 =?us-ascii?Q?2sUFKRcOFLcDGDXDw6IHlASNJ2TeRX1pG19dz4rJDxylwYU817LRf1agMKEM?=
 =?us-ascii?Q?5bEIdWsjOJKYYoCC0s9BVPAjLnfHpA+JDcvO81nPZ9q9DzAkj6SkZyMLK7Um?=
 =?us-ascii?Q?QrdYluD9Pxc5shmoZAnZ/9btjYWtsOmTImVV0CubZY9yoeEdHaOPzmBEcYd6?=
 =?us-ascii?Q?e2X8/COVYHUndohCsE9gXHXaa1RTS23oQb+BLV1wgakxkVySlHpcbYu6meRs?=
 =?us-ascii?Q?qBI5tp0zEMRMgSDAWnFoFHySKVGjCaEzw/JesUjLG3NznYBtaYKtSQT9Au1s?=
 =?us-ascii?Q?dhwcWCH5bNtiQqLPhMonGaJBnxmUDjqoNvezgqdTuWuNCBeWeWOYDT+XrNAP?=
 =?us-ascii?Q?hKJXAlc/jcrDfgDo5zHkZ3s+k2G+ybi7OLtkD+wAQNzOXGslaDME7KKKdefn?=
 =?us-ascii?Q?EwYvdZbky7lIvtNaBeqlD9lxkk91XLWnzh04PwGLPUEsnoDSdw18IABqAYpR?=
 =?us-ascii?Q?yDkE6tTNeOiaQtfYckyhObyzHV5De/uAeIoKVDQSMEaw69FpJJWS3SZYCDA8?=
 =?us-ascii?Q?LUhRasb9XXWhQZh1kc3UuvY4RHWDmWYI9v1rMhn/V/oQIWlwyrv9octp7Kk2?=
 =?us-ascii?Q?2P64to03kPnIxeK7SiaOTl11ehX0QVkG0Z3jDMva/xjBVh3EeZ6TamaKG0Jk?=
 =?us-ascii?Q?UneLBwzBhMhBbdYgfnv6l1GFKvpqohl+ABpwsp9C6ABEGFDwlCXVC6Kz6TR/?=
 =?us-ascii?Q?WEAgC/bQBmrKayxoBmaK/4epyvNgqYCNUb7wNZpcrtBQBz+ujfiihzp4mb4A?=
 =?us-ascii?Q?xw4g5ALfMaSTt86B40IpCvon+XN7h7vkn/ocb0GgiRTvEoSTnR5Vyslm+pEI?=
 =?us-ascii?Q?RTVrjLkNnF2OLRw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 01:41:16.8349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7a6b55-f6f9-4524-a38a-08dd3505b422
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch refactors the firmware version checks in `smu_v13_0_6_reset_sdma`
to support multiple SMU programs with different firmware version thresholds.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 650aa9d0548a..5a5742571d29 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2745,11 +2745,15 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
-
-	/* the message is only valid on SMU 13.0.6 with pmfw 85.121.00 and above */
-	if ((adev->flags & AMD_IS_APU) ||
-	    amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6) ||
-	    smu->smc_fw_version < 0x00557900)
+	uint32_t smu_program;
+
+	smu_program = (smu->smc_fw_version >> 24) & 0xff;
+	/* the message is only valid on SMU 13.0.6 with these pmfw and above */
+	if (amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6) ||
+		((smu_program == 0) && (smu->smc_fw_version < 0x00557900)) ||
+		((smu_program == 4) && (smu->smc_fw_version < 0x4556e00)) ||
+		((smu_program == 5) && (smu->smc_fw_version < 0x5551200)) ||
+		((smu_program == 7) && (smu->smc_fw_version < 0x7550700)))
 		return 0;
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
-- 
2.25.1

