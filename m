Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76260C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1C4310F69E;
	Mon, 22 Apr 2024 15:28:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CPcSXJLf";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D7B10F69E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:28:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mG2F1GUhM93CWLNALLWr9LHNAaWBTRYVKBCe2MGMWTp0yRXH65G1CQWn2ztJ5chsDBJMz6cpjr0QrDlWChjDZag3vYzBv+07MbYgdRWszfo5u4UncWsv/rGpo7AV7pjHyPHFkBJLd0+ssWnm/9fK5ZMWxtjcNkEy21y8yI2MO3HhUBE3z9CfIoAV1zgAopik6zAYhs5f+HVlS681W2imC6yhDSWdmMSRKDNsydY8gMEviN/Xgtuc/iCy/h9/5EfedgqUK+sZUwmnEP7esVVIlqPvbQ7LLdYliLkBr/hbyZIsBgQ5eJrzd6IsRBBfzC2kTaVC5WQWbTqtAYJXBsIUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IS6yu2wwma/3Zyao0/xvcuXAru4Bg0aNvuJfCDRpXtc=;
 b=bZkVGFJQ3kHgF9fy8r2u+lOusVFrs3IqCzNHADY5A8LLrF5GoRBOSBWT6YOcaAXQEaP9MRCE0DVnIt6qqWEzzHHzUtT47f56kbGMH9SEASop5Vqv3MNvBfozZSFwO9GSnAwV90HSylaZRwHIL53/HBGLYn6qf1hycEivnpljtr0Aek+3m5m44KYEA9Ud1kc8oZHmZFGAncsTH1OP9c4RhgRMHL+IzVJjEgkJ/vZsUZc7lXW95RNAIMs00z4WFHUZvMLUjt/lPt4KQ6jmuQS5OoUPGI/+bzRNzRbCUTmoVU/CSJ0jFlgJ/ucdcuCLfHsnr80u6tk+8/wBHH3lxJsWjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IS6yu2wwma/3Zyao0/xvcuXAru4Bg0aNvuJfCDRpXtc=;
 b=CPcSXJLflDAjzakbvW6a7/nNmRFYhdcg7TaXYVpE+fItOeD7HegeWhSMys03LkayH3DwaxkVMaY3y7+Aitleh9MSrN4LROCx1ss7tyX+Zmf2fCal404ZxSuCBAca1DsH1FT79dm7BA6/FkyUfHTJfHCg7SPNDaJqlXwAU3WDug4=
Received: from DM6PR06CA0096.namprd06.prod.outlook.com (2603:10b6:5:336::29)
 by DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:28:48 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::8d) by DM6PR06CA0096.outlook.office365.com
 (2603:10b6:5:336::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:28:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:28:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:28:46 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:28:46 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Dmytro Laktyushkin
 <Dmytro.Laktyushkin@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 05/37] drm/amd/display: Increase SAT_UPDATE_PENDING timeout
Date: Mon, 22 Apr 2024 11:27:14 -0400
Message-ID: <20240422152817.2765349-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|DS7PR12MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: a03b953a-616f-4a2d-caee-08dc62e0e7c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oAm6J4zuKpr/znXYPy/S1+Z7+2No2MfIKkllEfS4Ntge1DcXC+FhkIpcVom5?=
 =?us-ascii?Q?srGkzeVXNW+RNMZgb338ExAxwfjWRwHXLlge9wG7zvPX0eOUvlX2Fp4wgRQf?=
 =?us-ascii?Q?fxfI0CE4cH0gTSIrebqn3zKeG3LJ437p3eAnN/cyj/st0cj0pHrZsv+2eZlR?=
 =?us-ascii?Q?Pu7IbOaZMQq8NU8sVCRd0f6OH2ZO9n9SwxwUkdjwWi/Mw08yb8troo6EZMwT?=
 =?us-ascii?Q?gyHDBtwuPpDnk/RorlqHHD/LI9KRqC/Qn/jHoioo2KGq2tyNjpjQ5Try/3rK?=
 =?us-ascii?Q?vcQdGsdnONdu6T+Ce9ZS/8SIFUFzZNJ3UUDyMrGWN4Z4YXhzD4mnfWIvDKXv?=
 =?us-ascii?Q?FLspisYxjrzgPX8jXyh6XAL/zSL7ROugp/FGZpqVvSnBweJVNy6jJhWnWCqf?=
 =?us-ascii?Q?NbrXDJRjJ2c6DKJ61904dejsb+muEzgiY5rSmqvPUqgrQEgxvgjMLW+i0+P9?=
 =?us-ascii?Q?dI85NsVo32S+6c1uOWq/W0PPm1VjRzaaIh/AdTbcHzBLhgAU7R2QTi9ks5Ub?=
 =?us-ascii?Q?hprUKf2XZHRaUFxdEBkUhnVH6ZVJVXRJKek2iq0Z4ei5/lfR2yJS5i1ltJag?=
 =?us-ascii?Q?XPO+2825NUqC5AC6kx37ux72qLzaItHhnPY+IaR5DIqc7ozBAxS8G+XN1h8k?=
 =?us-ascii?Q?d83OUpixPG8zrxxzEQHT/pu047HDvragowcLn3DuUyeSNzUyTUOEwym3/jru?=
 =?us-ascii?Q?tOHkdFM56E0yInOR8Tav3h7D2lnAwLsrIjg5MDX7qPKzm0rKIDwSAvEnwWWP?=
 =?us-ascii?Q?1bqLXjQQo4yGuoaXJn8/OStdMjQmu1qylSdnH+ANcCeolircS1zRGuf+2V6U?=
 =?us-ascii?Q?SvG326dd1xzGHz4R9F/lvAUuPG2WrLbdW2bs/zzu/Yremub5rCxdPSxYJxZa?=
 =?us-ascii?Q?1Relr3jNVTfm4vy4i7IUXMiV6pTvhBPlEGImdHCmEEuX6NQJBZM8ZWPq9g+q?=
 =?us-ascii?Q?4jFg0yx2K+3Zh4bFO1KX5L5xH8rHwZghxjYvusYXp+9TK/nVzfOg9f5n73jx?=
 =?us-ascii?Q?F0J6xwxSS674aOhHQm51tJ6p6ZR/bFFSRM2SOHtunb1Tdke74t5SSZW4fw4B?=
 =?us-ascii?Q?e5hsrVtqoAWoahKVCiGKfLWYVcx+/J1+hlu4nU8r7eJGQT2nVP23Gv0Z3h4d?=
 =?us-ascii?Q?qhnDvL9/yFcM57jvRLEAsFrorPPPc6sj3woTT+2c6l/1uKK51A9WadQQqSmE?=
 =?us-ascii?Q?zmj/u/ZfXbWexxXaJMPj2p99rY8Y3/kuwP4T9SfqzFPeHZf3F/0csudWyAWp?=
 =?us-ascii?Q?EYWpB6NPI06wo7bqtHEtS9PBmvq32QPE9SNFO4LugagH9Ly/MSnOctpDQlsz?=
 =?us-ascii?Q?+dfL3VrzmCZ4TV2Kn7mN71sPZF6uj3cJDlvl+pBxLA4JVQ5Co0UFwb82cRGG?=
 =?us-ascii?Q?vIj855EwHjR3O5zYCyzBhCno9ukD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:28:47.9551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a03b953a-616f-4a2d-caee-08dc62e0e7c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8420
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

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Headless dp 2.0 will take longer to update.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
index 5b7ad38f85e0..48e63550f696 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_link_encoder.c
@@ -377,7 +377,7 @@ void dcn31_hpo_dp_link_enc_update_stream_allocation_table(
 	 */
 	REG_WAIT(DP_DPHY_SYM32_STATUS,
 			SAT_UPDATE_PENDING, 0,
-			10, DP_SAT_UPDATE_MAX_RETRY);
+			100, DP_SAT_UPDATE_MAX_RETRY);
 }
 
 void dcn31_hpo_dp_link_enc_set_throttled_vcp_size(
-- 
2.44.0

