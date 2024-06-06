Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB9CC27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C880F10EAA6;
	Thu,  6 Jun 2024 21:02:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GBLxNpIU";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15B8810EAA6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuA7XwLpngjuM81ualo7JJSyU4w2IbCJ54hEBGUiqy27Q0bG18ZLuvqo8PS8k4OzofWcfKYIXd+9piNyEMauJn4KVOMC5ypPwdfXdzOKa7Ga2gyz9LSCMCM9JJq8jyfJRAZWJec6XfUwYvYmqRVXeLTERn1+qKxBu0wAKvdXk4+yMnWxTDipG1fs5Lgg78tVZKfujLfgTdLZdFB0A3uPXJa1aKIuojhwIN2FIOvODskUInrpMcI75nRXIUSVUg2RjzVLom9eHL5uI6A3YrNdWzAIN83jUFvFYSpBQA4srCkWrIcBsIKhuu56qHbcdKlIPrOzKwrZViRrFBQtBPkASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfYfFvP4KYoQ3DbnvTxVzoaizYQkUYII7JOhubN/fj0=;
 b=JJDJg9qZn/xvHnpm+XE3MVhXro/B/b0p+lze0pQCDE4zOszyHjQMF+2NLGhhlch/nu36A8q7zkweKTl4QtDy7kDk9huf4jBvjZmfmfeD3nVyHpQSfVcXgv0Cg9An7SmTm7gFBaMt8zjv0LKUXG9dTpcQ+/HkpUKUWOMX5lzsq/wjXhrZENODuCDuKjbKSr2UUMcTJftTjqKOVrKRaiQrO6W3bpOQVrOb9dOO5XtORfIn5VkUSI97tylAHt7ZYjOlagUgLI1sB/UFq1EzyEpWWJJezy/EEkxJUetGxqGH/XHOTnhcF7mFpYzjb56jyfNd+VgwEHrLFPf/hLZv09APHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfYfFvP4KYoQ3DbnvTxVzoaizYQkUYII7JOhubN/fj0=;
 b=GBLxNpIUAWp2lariWYjiGoFzrKJw0NGtQTpwCE/JnV9GA0bKRBHVeqSR2mmc7DYQ1Hg/e/PfaKTTCiI4awwk16DaVxvo6yQgJdmcvKyk6DGr1M7I6Yqp00Nz639dNcDdNHcwCWSAh1zFqaIncW3FFCKQRmYVSwhHRXFW36ebKbw=
Received: from SN7PR04CA0044.namprd04.prod.outlook.com (2603:10b6:806:120::19)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 6 Jun
 2024 21:02:02 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::3c) by SN7PR04CA0044.outlook.office365.com
 (2603:10b6:806:120::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 21:02:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:02:02 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:01:58 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 06/67] drm/amd/display: use even ODM slice width for two
 pixels per container
Date: Thu, 6 Jun 2024 16:58:27 -0400
Message-ID: <20240606205928.4050859-7-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 36108de1-9c1c-468a-dc01-08dc866be9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0vsedgiQm+Q8xWZy9qmwC7r8sWjFnynjknc+mJF1k5plokUOCD5dOmdR+TAw?=
 =?us-ascii?Q?eAvaCwCPy2fiKQXZHawVTn9HaqljjmOgcuIyMXoSXJxDSC1v50TmWPiphgkb?=
 =?us-ascii?Q?3iEtg3lfYJB6EV0/M/7eUe9cZZqa7p7jP80zmLId9oX82JXK4GOoBAmOUZ+t?=
 =?us-ascii?Q?NWzbhQPbrs4R9BsWaZsiIEAFi4Vm0OJ3pD7YbbcsG50tZrba+Bf6zyS7v4Xy?=
 =?us-ascii?Q?4sJDjCWSfzj5tfS0zybr7YIZ8wows0r3+eWb9ur8qEQbKcmhH1lgdzqKkZ34?=
 =?us-ascii?Q?nyJ9bO/aW2rLy4Ps/HsaZoMn3RA83HoG0VJNmAUUSgRrH/eElHFO2kbOFSjg?=
 =?us-ascii?Q?EZAdUoIe2vfNPl8EU1qSS7iagM4arMkZ9x/grwUpgX8Hq8bz9R1QYaGx16dB?=
 =?us-ascii?Q?PWBdAw0pYzcYJR4+urbI45c81b+RLg5FilI09ARCuGotKr5o9YmnIA+IteqN?=
 =?us-ascii?Q?/C/9ywvTZuLBiGFGHo6XhuX3M1kgfHXc9UQ1YMVR5uCwwAaC3koINJ6aq5+3?=
 =?us-ascii?Q?2agV7Qupr8TPKgaU8KfVFgd/7Bc+jlYnhaIJNxpHT7RyrUKnPFzqoXg0XMYC?=
 =?us-ascii?Q?iOpckfvPqPBTen0dllNcq/Q03Ogp2qAnKq5kxkUOWdSTecMeLm8SYEsZFIi4?=
 =?us-ascii?Q?gK/wcpKspIKxq0HH9UM71n6/0I40xpV6WpzM6SM0+ODJ6azwVU8U6u2XnZl5?=
 =?us-ascii?Q?lrIvpCjPmLSDFiCTlYiepFJPZYfS1OwSznPqiAdSjgsOnG2ueSUrtjJguxhY?=
 =?us-ascii?Q?vuBqQI2D1CjPYxWfhTHHO5MZ9TMosGz7asGwVpS1C6twZQHP+pEB1/uW5bWl?=
 =?us-ascii?Q?5KQODLM6F4HXak17pJ3c93EVO8pMqz3EvJhcijdg2RWQbGKXuJqIZkee8IyF?=
 =?us-ascii?Q?aQ466BFGdxQWBXSWQuIDfGCVuVU34yUgVtBbOxPWGAhByDB0FBKJ8F7Ym/hQ?=
 =?us-ascii?Q?bxH9/Fy0nHXL10ur9O323jVdDLZfbiqBjIFaORyKmzhCV+AP8VFxTvokIZnh?=
 =?us-ascii?Q?LejhS/OhP+sOCNIuOq++VLok6UtQdlFMh3cJYavEOQVJFLqJNYufDJoy2/NQ?=
 =?us-ascii?Q?IXdnoRY+1Wfa7DpY2xZ2qx6iWVgFOG/dBWVQIhPjcbzSBnDsJaxB6uQz6Mfv?=
 =?us-ascii?Q?Uhr6Z2uX15AYMLXITGRH3PeAttOJCQrL3sfhpIc5DTZrmZ/46A4ZcE3WptU3?=
 =?us-ascii?Q?3/SdaClf0wO9j075eFcRxYCkhOJDAeQcKYoDgqM7EUo0801IvkeItEWNAV7A?=
 =?us-ascii?Q?2BEG+kRnFSEPFAmdqm3kssolsBoQiOZzp6cg1kzw9+dZrrPXiVj1eWYqKvN7?=
 =?us-ascii?Q?CF2uohWoE4B32VkLLSBbAjxszBR++BHqCxlmHeVJflzT/mrM5c29QNAYoxC3?=
 =?us-ascii?Q?7mZsAJdvyTmPj6gQ2ASz3MH178cRA5KKBwFCeKVhbL0yhiIB+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:02:02.3747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36108de1-9c1c-468a-dc01-08dc866be9f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
When optc uses two pixel per container, each ODM slice width must be an
even number.

[how]
If ODM slice width is odd number increase it by 1.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c       | 3 +++
 drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index 2836f28fa3af..9c6171e90163 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -173,6 +173,9 @@ static struct spl_rect calculate_odm_slice_in_timing_active(struct spl_in *spl_i
 	int odm_slice_width = h_active / odm_slice_count;
 	struct spl_rect odm_rec;
 
+	if (spl_in->basic_out.use_two_pixels_per_container && (odm_slice_width % 2))
+		odm_slice_width++;
+
 	odm_rec.x = odm_slice_width * odm_slice_idx;
 	odm_rec.width = is_last_odm_slice ?
 			/* last slice width is the reminder of h_active */
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
index a8f7fccfa16b..49c866a558f6 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
@@ -441,6 +441,7 @@ struct basic_out {
 	bool always_scale;	// Is always scale enabled? Required for getting SCL_MODE
 	int max_downscale_src_width; // Required to get optimal no of taps
 	bool alpha_en;
+	bool use_two_pixels_per_container;
 };
 enum explicit_sharpness	{
 	SHARPNESS_LOW = 0,
-- 
2.34.1

