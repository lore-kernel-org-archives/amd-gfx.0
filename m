Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9DDC3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44EA310E8AF;
	Wed, 10 Jul 2024 19:38:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C2d4S79p";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DC4610E8AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsI2IBTvboWJNMmsZvv72lOZ//Zbiky4+aDf7a5u70zePXvKeXG7FTC6wCw3XuD+TPQSWiDCc+pUeR2UuvTc9W878KZ1mgoryrWqEKjd37RPG6OL/ojD+rZckEjxOFuLlssJW6ltxoCaDnsNFDBqOJN4XC4O6/7QG1L8P1hN3HV1sHTxNng4fTPH2zLugXzcTFuxUiG64bTyVbqjEv1eYkj32/epBxAaBoKk/ugl5Vb8E1t/NGx/v/X1DKTpJlCYTTEIqCSmv1AcCrVjps0ZXDa1xBI42wEiZms8SyiTPJ4kHhn078xWPSN14VxXfpsq/z+Q26L9M7m6vlCqE0BGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYsUP3s4vWdv9JVOuuRCP8l+2OTwVLOxuXA+Zoiysws=;
 b=og2w5YFpwZSONAH8Sl0tYDfZwgA2XNoH8GCJBBJnSkFmZ0ZOBQAxpBAPIx8T6EOBtexJjuc+gvU4KfTCRzXEym3iHEMiqzFzgVTgXRaYnqK7YSnwWqWSFvycFw6D+Sm7zDgekhDsNBoavROpZt2Djs1Lf6Z/qUKt8rhs23dWNi6yQUdBwVnYdQAqqocEJmtAg74HfwieRBys/H+F6IxIpHp0I32M6nDY58W6hj8fTF+NlV6rVEFbW7rgGFeNKbPaRCgk1os7pMy4HDuZnreBK6LgDB6eb4evHq00rxzn6Jda/igNnED2COQ69F868gCb9L1CcjCz16w+cuan4zuc9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYsUP3s4vWdv9JVOuuRCP8l+2OTwVLOxuXA+Zoiysws=;
 b=C2d4S79pqkr2pjWmrqk6mKXBSOyQswW1MO9DOZrTZ5MNtC3YkQDbz45W2DNX4nezYlssH8dO5j9azrWaMwdP7P45OwqKzs4H6H0d95nZ39WAXsd1UGQn5ru0LYha5Z4U1XoN0PxxjTFh1ycoq0CVPNH2kd8hjqgIXo8T3hrEPEI=
Received: from BLAPR03CA0156.namprd03.prod.outlook.com (2603:10b6:208:32f::29)
 by BY5PR12MB4323.namprd12.prod.outlook.com (2603:10b6:a03:211::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:38:42 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::a6) by BLAPR03CA0156.outlook.office365.com
 (2603:10b6:208:32f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 19:38:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:38:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:38:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:38:40 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:38:35 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 19/50] drm/amd/display: Check phantom_stream before it is used
Date: Wed, 10 Jul 2024 15:36:36 -0400
Message-ID: <20240710193707.43754-20-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|BY5PR12MB4323:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a539de-d34c-417f-25f5-08dca117e797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WW7m68v4GgaCoVa/E7AXoS/YPqAFkk9N8k6vVlaJ8yzkTQzwU0ZarzT3S9e0?=
 =?us-ascii?Q?vvFb6NJuBCGonhOQYOD5+NsuwgHJY0lGJPK0BhHlVOHzX2MPb4Lc2dXvBpnP?=
 =?us-ascii?Q?m3h5w9x/zMBzNaH3SWHyjHlevIuKAzKeV0/zXBAqrE4cE5vvk12jvJxhotu5?=
 =?us-ascii?Q?YexL3acNB5+ReTAm8Sf4C7j0XcP0sKf7D3OzPQs5JFd+zL1u0p3/YD+413Yv?=
 =?us-ascii?Q?kM0D+Av0oAXL3UIK9aUR0Rd5LARfrwKTGZmESjAFYwYCE/XjokJuCUt3HMfX?=
 =?us-ascii?Q?7HksM/uXGrtk64Km5k1UtmjK/fnE7ftZeXsXxMy216OwGywRYRluuQJn234U?=
 =?us-ascii?Q?6IzkRcGDCrwXGsL5Qr3p/dKzKYAOLK2vYeROzeyQpLqhsQLRhCn0ZNkm+TlJ?=
 =?us-ascii?Q?3m5XXQh10fagblH3BwG4DILaQKt99ViVZFq6BgyzQSbrquha0YA8nk9GgSZX?=
 =?us-ascii?Q?T1rRkEi5tGxljd+LTHE5p3DMPEuE9elUzmWb2zAfwoQhKV8iriOBSgUEOAx/?=
 =?us-ascii?Q?MVJ5tHgxhaVDWn0scuC70X7wOSzl08YDRWXyDTh//B0HJSDnmvHTsvhVNwMv?=
 =?us-ascii?Q?m1ijbuDqpFEhAjg5ORFpjlGJn0xxQq0Iq7wRvwVSXAc+fx8hsjmmmKmQ7ts+?=
 =?us-ascii?Q?gGVltXRTBbPSJeZEyfdqZgGzohBBNYHMtvbYo3ohPwGKg/Ihb19BCHUKYvul?=
 =?us-ascii?Q?ObvZFz+qc3Iyvyr2FzGh1ATVXWRWLgKLjrRrR+ltzr+sQWhs6WFvVVyQggtT?=
 =?us-ascii?Q?Ai+UCW9yntLwK3IvGMhPtDmWkueBLvPBXBBVbvebPrA0+Ea1vE0fHTj1tbGg?=
 =?us-ascii?Q?vQ3KPE87bUkkeMzFefN9qAF/6AKLzeIujb+WnyFWP1ewkN912gtejn0O1wqY?=
 =?us-ascii?Q?Vlk0lfyJvQUeivzMJ0uGiKkSPwGBQpKzBQO1zyawbrMSTedhMdOqrtbQddQ9?=
 =?us-ascii?Q?YoCF62H30074BDsm3+HbEWh/NtEH+/M4r9OZw+IEQKXhrq2n8XZnS0T4L3q7?=
 =?us-ascii?Q?YgE0Geg4NDYIo2tTAaYqa7OG22r+uKRNvO/6i5+6aA8m6/OJy25auTHL550r?=
 =?us-ascii?Q?iuXZQSe3WWfVCm3G8m2s3AUDAsJpG8MsLhFho9kChMMJ5aVraooaszht8slz?=
 =?us-ascii?Q?Y4F1p0WqsXHLFWzPACa5BrtE/qIEgwbUsqZwHIvoCqNfeAL/hwxZsKuEKYCE?=
 =?us-ascii?Q?0/+6dher1cy1DgwrjbwOgnX+GH3vWRbTmdTaDh2TqQfmtBW6M1o4H/rsg3Y8?=
 =?us-ascii?Q?uIkopkZtOJxF7kSPgMuGLVdYFfD48mNC4U0JwXHEgS5UdSaUKh1C3YSl+mYC?=
 =?us-ascii?Q?v03RA0G0SBTdMVjDzvUmSFzpd5qGShEqUuav4ZtapHi11pRVPW5KcpjIgPAp?=
 =?us-ascii?Q?6fZ66lOA3TW/AEzrHn+ceIqViP0TAPnusOlCO1SxoKPnIW8JPZpUCj9aTiEw?=
 =?us-ascii?Q?KoroIl+mf0/rBAI1PbwsaUxUk8XQERaq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:38:41.9498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a539de-d34c-417f-25f5-08dca117e797
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4323
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

dcn32_enable_phantom_stream can return null, so returned value
must be checked before used.

This fixes 1 NULL_RETURNS issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 3ed6d1fa0c44..ee009716d39b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1717,6 +1717,9 @@ void dcn32_add_phantom_pipes(struct dc *dc, struct dc_state *context,
 	// be a valid candidate for SubVP (i.e. has a plane, stream, doesn't
 	// already have phantom pipe assigned, etc.) by previous checks.
 	phantom_stream = dcn32_enable_phantom_stream(dc, context, pipes, pipe_cnt, index);
+	if (!phantom_stream)
+		return;
+
 	dcn32_enable_phantom_plane(dc, context, phantom_stream, index);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-- 
2.34.1

