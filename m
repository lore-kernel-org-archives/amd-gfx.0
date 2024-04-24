Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B4DC10F15
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46C19113954;
	Wed, 24 Apr 2024 08:50:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MmWOo0JA";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95161113953
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIkZU6fgXVrhr7ZSkHF2WK4qk2MchXOxwzZmwYqBYidfDh+5eMoP+tcDD0tFpecGOT7Cp9sqLGYMx3pUem9wRbqXmFm2HGNxpHmDbS6kE5tLWdBtkKPXAkYxoeC6E3/IMw8PVrqo54Uc4pz9LEN/Irf3WAyBIm+1n1/WBPDe+PfT0DAcptei8W+tI1RrEs4B6XaxyMkjOKJcoV7ytVmiV84RMytnGZE021DTn4UQTkatMFuRApv7KdLthlXfDNuVneMRS0n2Wkxpz46XL54cFVFd6wvSpAZXFPcOroE9t6w2DDjd9iTFJ6aoXfKRraMvikvydzLhHnzZ03GPXXNGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaVdEJms8i+Q/VypVJfQ2ViJSvKbKSmdPV8HYJqtvFk=;
 b=Iggi/teeLvCKGu7L/tpErLjJp75DCJr2AQdMRLXYWkDiCeyu35UPBro+bnYgia/FZZDV7eeXMlSalDS8LbPEjY3BdNRH1OZB0TXIWpoIescGxhI9CjE23bhYu4LpECiOQr4Rom3ERjIfwUJf2AZ82/OKxEH50EMxNL22t1yf0IBvoDNTkBQ7QcULg1cBGTyveYNeO1NaV+IPudI0ubAECRXXd9QIns8ZClrD60lHMthAnSZC6sSvbW6XwFqzOKQ9zBoh/vbsvsY4nV3y2S9e/3ep5IV59K6WESrj2wV3CJcxFhhmuuvz9WaW3xrapbeQPykuZakeDvB6bKQDugTkHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaVdEJms8i+Q/VypVJfQ2ViJSvKbKSmdPV8HYJqtvFk=;
 b=MmWOo0JAnWezlkkwlPhLeRV8HDK6iyHGkaseVO4dnYpSSdy554qT2HlH8KmzwOsNts9Jwdy0F2CP9wpsT/gB0Dq+piXbCzhP4e00eE9zLHKw5+v3hTQ5JYMNrlZagKrEQCVU2zV6Xp50wvCdrusBAOkdDHiI4PPeSQ6/WEqlBQo=
Received: from BN0PR02CA0055.namprd02.prod.outlook.com (2603:10b6:408:e5::30)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 08:50:47 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::24) by BN0PR02CA0055.outlook.office365.com
 (2603:10b6:408:e5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Wed, 24 Apr 2024 08:50:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:50:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:50:46 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:50:37 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 06/46] drm/amd/display: Skip finding free audio for unknown
 engine_id
Date: Wed, 24 Apr 2024 16:48:51 +0800
Message-ID: <20240424084931.2656128-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SA0PR12MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: 4afd863f-1e4e-460f-2e25-08dc643ba2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VlB5dzS2njORqovcb5oHj8XJQmF2iN19mLegvn1glVAh2O8n9H7zUOmlZVY1?=
 =?us-ascii?Q?QDvovaFtSLOt82wI+nBXv0q/HlCDWe0nHLbdOg6/KG5qqRtTw0ak7SP9JQlf?=
 =?us-ascii?Q?FCkttR6ufbyInYj6Pe1DrBmYL6nBDzrWiUcgDRlFVxyot01hUrZiKNwpo6iv?=
 =?us-ascii?Q?XIv7YO0MrBpe56/1ZC9f/2CObd2OaJkeomVWplD0EKxkd2sLE2k5PvjvMxf0?=
 =?us-ascii?Q?0XU/BZu/N6bKL/tdQBWmPTY4GurTtJcgW+gfpLLgAa+nGPz7d/pje4Gg9BTv?=
 =?us-ascii?Q?BmcZbV0mntQfnxkaMQ/GD7udsY6d8yDOdGrLMsnRZNVBNAPGhHjycsz1KRar?=
 =?us-ascii?Q?7SYUXD/NYkkTt37ys+WFGnGkuRXWWREhLgrgS8fHf45l6NxXh13GAwoVbSd1?=
 =?us-ascii?Q?ZMBmM0a2SrtYuUAnx9w1fl9vSL2lnNB7ww0c1cD/L/CrSlnoVoqLWSNj2FSO?=
 =?us-ascii?Q?oroyd6gaCGqE7hXP+xzq3Czo2bQbcHptygeqy+6XBkHtAa+qsrI774P3H2Un?=
 =?us-ascii?Q?MVaNzGokGPKFI6Yujw8dFQHu8K1uFnzykpMT+CurxiCnncOL4hs4Fd6Pqqrv?=
 =?us-ascii?Q?YfsjcdTn1doLo3rVLrfoTJKtTgvjtdl60rWMTC2Nigghcu7rx85brEgQFYL6?=
 =?us-ascii?Q?Z2Y2wtA+YNq6xMN6f+UynSEbPZ6+mM/UmGjRgmneKjoGiMylOcPeS59M8nQr?=
 =?us-ascii?Q?105hSff53aMzGAfn5gjXMgxigt6gT2g+f/DGiNzgRAtkzO6LdtVx0WbQQFdG?=
 =?us-ascii?Q?dynGljWM4sBY8rcO7QyOd1iB1DdI//n+VqW/+fonRIHGxtF5mHVK3Al0as/q?=
 =?us-ascii?Q?pWtWxv4VKlardVEfkBc9gNZ4fAEcKPFdBFd8J4OaETe1BCgYClFghkwY/9rq?=
 =?us-ascii?Q?jKQeMnfeHcrrAEymOqO0cj2tqM91dSvo9FSXX5gN4IDmIKWCDI1p1MrFXEZD?=
 =?us-ascii?Q?O2RAjmA9xQu+TYZZCz/uMM50802tLc1aNjd0Zin0o/6xx49iBNgT1qvPFMDc?=
 =?us-ascii?Q?3Fl2Ew6iS8sSccdPgX6wo85w7UM+a6orSW/6OGAdCj2fEx/MT92iwoce+m6F?=
 =?us-ascii?Q?0uxpG6SrE0qao031stQ1Oox1Y4vhb8M6PvScHrx9J5+sm7shwgzbuT7M0/us?=
 =?us-ascii?Q?zwfl4XLMxlGST5Qs1UnfFTuianMgSK1ldwDpZFvBxIPqbApo4IbDh4Z4gHUi?=
 =?us-ascii?Q?RM7C5GHRKLWVh+ni2pqf0m998dLh5a/AUo2poZgk1nucydJwxGMVwSbMnLtF?=
 =?us-ascii?Q?t+f7OJwPlAEluKldCvZf+ErhRoCr1v74qBpuRT7NlgDC/Hu2DONXJ9CP5LF2?=
 =?us-ascii?Q?ORLsRYNKQHJ1cTFP6JotO+gTe5yNxeGE3bVyFvnBXUJXadT26OfWnw0MuRzs?=
 =?us-ascii?Q?w7g+GSX9ncfIxf7UKRb3xhmlg+ec?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:50:47.4692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afd863f-1e4e-460f-2e25-08dc643ba2af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
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

From: Alex Hung <alex.hung@amd.com>

[WHY]
ENGINE_ID_UNKNOWN = -1 and can not be used as an array index. Plus, it
also means it is uninitialized and does not need free audio.

[HOW]
Skip and return NULL.

This fixes 2 OVERRUN issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index fa93d6d6563d..93f05e2080f4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3230,6 +3230,9 @@ static struct audio *find_first_free_audio(
 {
 	int i, available_audio_count;
 
+	if (id == ENGINE_ID_UNKNOWN)
+		return NULL;
+
 	available_audio_count = pool->audio_count;
 
 	for (i = 0; i < available_audio_count; i++) {
-- 
2.37.3

