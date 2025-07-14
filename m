Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA9DC83F17
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 03:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73E3D10E1E7;
	Mon, 14 Jul 2025 03:28:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vN/Ac3Bw";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2E8410E1E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 03:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLTnJt5v6kfpcSaAsRkJAbzmrjixd8VXVIX46AN1Eo3FvCszFChhP1CVxuZ1ipJYyGVAK3Qc0ChpyFEh60nxbgh0R8CdLo1dD3FJwlGXt6g8hYkz4H5WUEGmd28UHbpfxzT0Bu8vJjtmGpWmjxXeaCR7rS3OawuCEFtn8WP3rlJq654Knl8CIkdsPd9r8cdn5r4IvxpJ7sxeKDxiyhlMc/D/pwDaXQG7kvEGA5H7AMmEnih/0w8op+v/clcPEIBPQADXRY51Zf4AmmVAN7CYHVm3hNXT40KHHC5A/n2F7blM+51fGhCeXqBw2TLNyqNPdqDN1fdd+owGfgYVFd6ZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i77HjUv4iS64tlW6GMoVdBXSL5NSsaFQS1x6lfYvvRI=;
 b=xfc27JxDOhNW42ohhj9vvf1kGZQI7bJ+GcmIbp7OHQLshr938F8pmrnehPw6G7LkvMiEdwvD0Y/2By8HiKe/X1t04rSK+FYK8vrCEU6JmcmCwzss2fF2sjHruJhWD2jTe/fDcjRlhP5DdGX9/RyE4HI6zDpz5nQVPL8J4lENXRDNDYPoV1fkXneZ8SIaaKHtBaHhr6s7jti+2VU1zlI6Jk0YzJFQlcK/BZ5fHHJWqyLTApDUUzfK8I1xhmIoohcW+Uge0ow6pNszjNJd01mtppBJbrAeTwKmwEwpBXfTNdNVXGHRh3gj8nZ8kZ+JKoSTqRxbj61kQzVW3Fhe+xOcGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i77HjUv4iS64tlW6GMoVdBXSL5NSsaFQS1x6lfYvvRI=;
 b=vN/Ac3BwUTsAj+s8/4eYu6FQoh6mDvtGeNjE1hMhS2S4x6qiALD/7fsc1BY+oDC/YFQ7dxwAvMRc8Ge2I1Wa9SibI6NDvQ0FADEI2xUs2JPK/VdmqCaHvY5A9U7Rs0IK/6U4LWeHzmuiBVl1vrGgJHRNmEZHPe8lRwQtZ98dCoc=
Received: from SJ0PR13CA0104.namprd13.prod.outlook.com (2603:10b6:a03:2c5::19)
 by CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 14 Jul
 2025 03:28:44 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::11) by SJ0PR13CA0104.outlook.office365.com
 (2603:10b6:a03:2c5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.14 via Frontend Transport; Mon,
 14 Jul 2025 03:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 03:28:43 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 13 Jul
 2025 22:28:41 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v2] drm/amd/pm: Use cached data for min/max clocks
Date: Mon, 14 Jul 2025 08:56:25 +0530
Message-ID: <20250714032825.1512229-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: aadd78bb-b376-47c0-7f23-08ddc286893f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iejDQTwLd60j92PCmrc4/nVHXZHdaVpwuMqxDBEUlk+4ec7oeAuAxLBeq4G4?=
 =?us-ascii?Q?6Bb1D0KdWGXDvOEK1CJAjK689Wy81pQJwxz9jAE3PmW5TzKEalGfjXh7Fx9b?=
 =?us-ascii?Q?dFtTGdafI6oypcNrSiUGXj1qlu4utilRpix7x9VrfeMpCB4BAlqMmOwJqmOh?=
 =?us-ascii?Q?61NH7/Qi3z2Nxjg8B9LfHgZh/cJYje65Pr7ARzMIGGzg8kL2jXI9MMXfG2XF?=
 =?us-ascii?Q?fgWOF1+OOAZdoAmXVNKLMytfskKCsb17YmR6quYgTwa0ga5lLHo0FaDBTLPU?=
 =?us-ascii?Q?o2XEU54z/z8hUbsiFNeQpji+k/7rhYHGNHO1zEc+ZFUUpJ/0fxacteJrTC2l?=
 =?us-ascii?Q?NoMS76zOgw9C7+bdHUoRJ3gdF/wcDlAWVsQ5rK/cbWRwr97uAFzmYbz+mioB?=
 =?us-ascii?Q?N4sktsORGC8ofikdiiUMhnFwpxopypIa7bhiSEDd3Rjo4omiYuvaJLKNjwf/?=
 =?us-ascii?Q?4XCfSZRCSxb3+YGy9QfQxH/9PWBZ/xxXxpE9OlcMkUHVbMIDmpXLXvYF51/1?=
 =?us-ascii?Q?rKJxbuH0srKiDgPdulAcKCTDMy8J0X+gR5GIoW+sVGaOvRVNtVMqrnUAzz9X?=
 =?us-ascii?Q?j10L1JALtqR3Oe13GIbDvouD+pJC7B1ImZLlk2N2QdpB5G1c150AwN0xOWgw?=
 =?us-ascii?Q?j44oyi2AmJVn5Fu1rYUqc3EZKImjH3ynpkndGOKpHnO9eUqO9jFb5m2xpqqn?=
 =?us-ascii?Q?Tw4KSaB3alDeD1ZuaYnyTFC3tGildvqTfgIBXk4K/gYBwk8wd5W0+HnEkgyc?=
 =?us-ascii?Q?SzxC7YjOgxsx1iR3i1pB0uEfX5Xnufb2lT2u1np+kWLmXcOqSs5hT7zZhFuh?=
 =?us-ascii?Q?CbPrl+LXpkzNbOhiUokWdr8CCtbHdT9GmAECDkdXs5FnBkAxFghIjouV75eh?=
 =?us-ascii?Q?24tSYJaRL989eMc2h6kkLujqZpOX0Vy8jrdm49XK3b9Dj4a9PrfpH9oqoo6O?=
 =?us-ascii?Q?9A92IfD5hUJPClEjVvolf7Mr9oLMDliglr9yLeYXo8lLx1nM5muo6qZgOe8P?=
 =?us-ascii?Q?16F47K7gcvpYVpBeFhBIZ3geeJ6Z5gq5AkmUuakSyIXpbHoVtKLDrCSXUL63?=
 =?us-ascii?Q?YJiEPF28Zs9fAIqFGMNSDCQk9TMKl7okTcUknsLgZ5/jZiv4lhViL+ep+Fvs?=
 =?us-ascii?Q?zYqS5IpkrbGqYGNo66wrpkkbBbhWM2P8rf8iUAFaST0D9wazou9XnDz2bbfZ?=
 =?us-ascii?Q?mazzdqRqKgNYPlFuCaz+BZKog9kaW+vTW3FLyLaobN77crm/L8m3JHP9Tth/?=
 =?us-ascii?Q?0TDVtbrbRmjA8cBGo0nIXqHFB1w6e0QzoBXVll5C/Xq4N3JCXHDlcjePFjKA?=
 =?us-ascii?Q?U7zS4cdK271hQuPBblEchsCD1XuRq8qdzFGS2Jn5oFUqYuoMEaucDTmuv5uf?=
 =?us-ascii?Q?I+ac8hRlDhX6RHFdePX2TDoBVa/dmDifXwbSY7dCYi339DE6/L+RgDIdhBIa?=
 =?us-ascii?Q?uwHaUyZdvCozXZZaYF0ou/kC2H+SubEnUGzzEpq9KyoO+zapGpAkgNwDIQD0?=
 =?us-ascii?Q?MWs/Iozqg0WRaWD0WbGWGJFk2isQHXWTM8c5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 03:28:43.9629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aadd78bb-b376-47c0-7f23-08ddc286893f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241
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

If dpm tables are already populated on SMU v13.0.6 SOCs, use the cached
data. Otherwise, fetch values from firmware.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Coding style - reorder declarations and remove unwanted initializations

 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 68624afe7d83..f2cf333b2e40 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -881,51 +881,51 @@ static int smu_v13_0_6_get_dpm_ultimate_freq(struct smu_context *smu,
 					     enum smu_clk_type clk_type,
 					     uint32_t *min, uint32_t *max)
 {
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct PPTable_t *pptable =
 		(struct PPTable_t *)smu_table->driver_pptable;
-	uint32_t clock_limit = 0, param;
+	struct smu_13_0_dpm_table *dpm_table;
+	uint32_t min_clk, max_clk, param;
 	int ret = 0, clk_id = 0;
 
-	if (!smu_cmn_clk_dpm_is_enabled(smu, clk_type)) {
+	/* Use dpm tables, if data is already fetched */
+	if (pptable->Init) {
 		switch (clk_type) {
 		case SMU_MCLK:
 		case SMU_UCLK:
-			if (pptable->Init)
-				clock_limit = pptable->UclkFrequencyTable[0];
+			dpm_table = &dpm_context->dpm_tables.uclk_table;
 			break;
 		case SMU_GFXCLK:
 		case SMU_SCLK:
-			if (pptable->Init)
-				clock_limit = pptable->MinGfxclkFrequency;
+			dpm_table = &dpm_context->dpm_tables.gfx_table;
 			break;
 		case SMU_SOCCLK:
-			if (pptable->Init)
-				clock_limit = pptable->SocclkFrequencyTable[0];
+			dpm_table = &dpm_context->dpm_tables.soc_table;
 			break;
 		case SMU_FCLK:
-			if (pptable->Init)
-				clock_limit = pptable->FclkFrequencyTable[0];
+			dpm_table = &dpm_context->dpm_tables.fclk_table;
 			break;
 		case SMU_VCLK:
-			if (pptable->Init)
-				clock_limit = pptable->VclkFrequencyTable[0];
+			dpm_table = &dpm_context->dpm_tables.vclk_table;
 			break;
 		case SMU_DCLK:
-			if (pptable->Init)
-				clock_limit = pptable->DclkFrequencyTable[0];
+			dpm_table = &dpm_context->dpm_tables.dclk_table;
 			break;
 		default:
-			break;
+			return -EINVAL;
 		}
 
-		if (min)
-			*min = clock_limit;
+		min_clk = dpm_table->min;
+		max_clk = dpm_table->max;
 
+		if (min)
+			*min = min_clk;
 		if (max)
-			*max = clock_limit;
+			*max = max_clk;
 
-		return 0;
+		if (min_clk && max_clk)
+			return 0;
 	}
 
 	if (!(clk_type == SMU_GFXCLK || clk_type == SMU_SCLK)) {
-- 
2.49.0

