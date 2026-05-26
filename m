Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E967CD5BB4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10E8010E513;
	Tue, 26 May 2026 07:20:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Axn4yfxX";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A75B10E513
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:20:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8zXNqCYn+fGudSjE8HiQNN/TgxKtqSjHlpD40gJAFcu/7EpYc5hTtp2tfEsO4K0i0fvEcKHB6QlLE7QSERPHA0TNse23MdizbmeOcIBoLB0VpF5JZLUAO1dyvpdGE0qSLThuH328GVL9s/4bFCMv4HEr2XqsDJHsGAI27CYDQCZwPTAE24LORQb2J7jzECgUsM4VnrJysS7n6/2RyX8VZUt7b9iNjUEaye5HySainw9W09XljrjiLWjzIzVp2MQZhzmlfenOEnqQVdPdIYoHiXZjYFzdSJTHQqWLXHLZMvrZxvjIjqczjODwf5kTUsbiZojA2Pa5Se+TtfSElEDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4uuMqM5lPhDfVI/byNI/yVmXoDNulbgNxU325V1z5U=;
 b=DAlHfidcn3WAdi2sFe3MYTjt2VwLj+aGgfwPftJJ4fgWHZZltjUeqY3j5BiIbfy2jW6D7y/Knyl91yuld5lFCkjlEkX/niMczyH7p0xYivMtKnrzyyMLDWRaZwWnVha1ojgbIZYRR1KWW4GtY1mPfdm+R6RQ2mbnRDtKcEhI0S3RExtmvlk5cpM5cBq68HGQRO7hd3JX4+CDYtyMkWwhtE+Fg55GMEK18HSEaFdUfFv6T60w34V3zqbWN4QdKjt/O48X2FpoKrE48JUDMA4kgsX1GtkIb5OP6QVu1I8jA2ECFVhkUw5ZQjRUA1QDQc1C+Dse3DigdOqfNHL9rb2poQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4uuMqM5lPhDfVI/byNI/yVmXoDNulbgNxU325V1z5U=;
 b=Axn4yfxXXuGcnNLFrY0RHHb1VhU16OnKlGlyPel9qq6VEOJd1PCmIhNgj1CRHsh8lWpTGIxI4EBYmLwQ1bwgj8rpCV5RPjXXQslL+S8mMkSekBs5pE0NcELsX69nxRSiTpTsCZVZtBdIMQHJMMKmiK69h7vZifm1LG/+KVqfYdk=
Received: from MN0PR04CA0020.namprd04.prod.outlook.com (2603:10b6:208:52d::19)
 by IA0PPFB67404FBA.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:20:39 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::45) by MN0PR04CA0020.outlook.office365.com
 (2603:10b6:208:52d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:20:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:20:38 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:20:30 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 39/41] drm/amd/display: Enable DM for DCN 4.2.1
Date: Tue, 26 May 2026 15:02:02 +0800
Message-ID: <20260526071413.2181251-40-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|IA0PPFB67404FBA:EE_
X-MS-Office365-Filtering-Correlation-Id: 2217dfff-cc4e-4663-3e08-08debaf74a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: XnEJ6MspMJwHzPEiK63aBEr9Jq5sJVjJvHyZnEg1LtNDDEHIBD54SDZC7w4TK8M0u2Zn4pxagln0D2GNH58h7+rCkKEv26eLDqDgj1+UYggLflCh73nCaAm4njlNvvX5d8ObJgLTrmQBvct39f7vnePclz+V8zHbC9VOWvzzHF5B5D3QkpVE1Rpo0kLGERgy4XCR3YVVT2ysITJD0sVYW8Vb80q4fr9SbjZgAUz2rMO93AdjE43ErGlEu9dYzliid6i+GcEbex4XD+Doot7QrYU1RLvrDBiAZa7sqk2IL3KY6mAW/lp87VKTPsPThAhAoI8NYnMvHCwXQULbHaSy1i12M37D9G3mSsIfTgpL6v2KtVNSyqr+QYIcR8Odiar9PrfkPElHZSNBab8+mB0AdXHLjVwhQmK/9btFTs2VcSloxrSlJblJrEomgfB9IzGmGza/Qv8alg+s84yuS4vw2UfkjKqEU0m/3+721oJ0FQjICtcEFHuusMRfxF4lGOcvn751MnPkLybnoA98ysN9uN/VXHz1rmN4QEgBBqVzoRT77f9NEx0TtjXnHh5G7JVOsslzeGMOfxE5xSPZD26Bs5b6SI9pJ/pl3er6awSaOc8F/hx6xBOpOlXzpIdor5UdG9zDeloArGwTl166ZjNwdh024sAvs+TIK2mHxBW2RZsgrf+RC3sz3X45jUTzeJH7FyRwv/vsS5HcVbGAKu5E+zCfgcOZdjlfK8yxemQsAig=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(11063799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z7KxVIUNVfkFyqS8+T9wzaKWWgXfm15ZskyUu3neSOahZ/c8rc12+hRR0Pb3+jHNF4hPPDjZA85cMNtA6q+Dyw3j+/O8b1u52uPO0gEyHib03rOKg2lOLHep9wWezjYsnCPmqydb/lY6zxCcRLiGXQb4mz79EvH70RsuhmcHRqb70TmI2iQirYOR3RuFi1/ODwfiUM8p4iOGr1GhG7EsGdt28a2arWj9TrrCF5zA1LoppNbGgaGM2Oe8SI9Lc4uh1kl+KlGWVet3+Io6SaSjesOoVNDDbzJ9SV2POSUgTVZpJS/7mWzIE3MN6WSQKiOF9qb0wY/wCIPw0/jySr2sWHBjMW2LwPT9EarnZrKMLGwK8Jqw3PqGl2oXsiPgvtXYUmTkLFqDwdVX5dpmMGJnsFrz0LIlrwA3ut6JaUSXzlvQi9USlVSuBqAmeBDGr8rL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:20:39.8101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2217dfff-cc4e-4663-3e08-08debaf74a3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFB67404FBA
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

From: Matthew Stewart <Matthew.Stewart2@amd.com>

[Why & How]
Add DM IP block to amdgpu_discovery

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 8e3b6a4050e9..7c2212985273 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2400,6 +2400,7 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 1, 0):
 		case IP_VERSION(4, 2, 0):
+		case IP_VERSION(4, 2, 1):
 			/* TODO: Fix IP version. DC code expects version 4.0.1 */
 			if (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(4, 1, 0))
 				adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 0, 1);
-- 
2.43.0

