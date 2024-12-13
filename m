Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC420E7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 15:55:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587AB10F080;
	Fri, 13 Dec 2024 15:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u83ZmONt";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBA8410F080
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 15:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QX6t3OJLTIHUxlZ4b/mwRtBjdorh5wKLgHRTx20B5DhcxMfHEBx5HzCs7F4Afu01IACMxuZHwYSeDBPnlhxaZ3y+vbyJ02OtX6AgcADT0OKwQjSbhjmtBDkNYRQ2rHTKkudDsrgwuZ53kYtT195JI4QOvvYqB4xk5zKP87eAx0UTB4CFvWgMaos5eyB8BefpznGocDQsN9CrYVqMrohDHZ59EQ6/ITpFkRbtFU+13YiA35Zp/r4vd4iaocpY6RAogrvXui2koTWKEHxDUCqijAmStQ4DMW65Y6dL15bfQRKjjeViHx2vx+X1V5K8UGSe8p9MflsF4djDd4tlI9CPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8kbMXjacosZDuYUkoFNInLqBey+8jxPWGErxGTF1ZY=;
 b=Z7IR4svUqpO4f4iNnNTgkwhgLZ2NEVh/aAGdde18pGWrJMjXyrmncIqZnY1ieQcdT3iGT83KiKGcfjT8H6SOeWFjpENkb5Ze6rij5CZWEA5xiZovkVD7UEBajxnjTTplZpOegrYrUhAfbjrc++cxMWP3ibRvmELr+bwilQu9K/Dv2fm8ldZmRoWdwF8JJX8bw08w9OMQcfIO6vlAO9h2rgMfPevZdd4oUfJ6f10xJZWprGb/ROFc4iYm1j+7FYlEzjlyi6hPD0lhsa4fobgU/KW6wJWJ6NtrAqy7y8iEqvTdZ0sj3spZXskUh/NXBTSeNTrhvg4LaRa5UnhJhgmbWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8kbMXjacosZDuYUkoFNInLqBey+8jxPWGErxGTF1ZY=;
 b=u83ZmONtmB070+iHtwMXf7cRmydD9OiPSeyXTDbZRXWRuA2hSAZOtxAskjHTZ4/Bx0iouYP6/QsmJPjcrKyPAmustdZM4qL0TVkZatZV4DM9xAQ8dXE0XSQPMDqiRbVWjbIHYTFcGsk0ptMzscWyhdNkglfFoxvwBLs5NVvr9LA=
Received: from BL1PR13CA0375.namprd13.prod.outlook.com (2603:10b6:208:2c0::20)
 by PH7PR12MB5854.namprd12.prod.outlook.com (2603:10b6:510:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 13 Dec
 2024 15:55:11 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::31) by BL1PR13CA0375.outlook.office365.com
 (2603:10b6:208:2c0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.12 via Frontend Transport; Fri,
 13 Dec 2024 15:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 15:55:11 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 09:55:07 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 13/17] drm/amd/display: Re-validate streams on commit_streams
Date: Fri, 13 Dec 2024 08:52:45 -0700
Message-ID: <20241213155405.393252-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
References: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|PH7PR12MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf2a20f-0ee3-4739-8e58-08dd1b8e8683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CQ6HLQ7TsN6CcgPEEorHz9Ep1Q6fKTkDnDvBvpDFJS3YeCjoK5oq//h14NtO?=
 =?us-ascii?Q?G5ljMp2rsz9PYx6h5/D4+gI2h/LRAvq5TRO471NGtd7jzWvwcjbkVB5Dei/1?=
 =?us-ascii?Q?mtVd7GMLcaiFvLEflSfwRM/pDgto54uufWjFryxP6+QnlB2mZU9Ji6b6vwKe?=
 =?us-ascii?Q?7ItRSiWJD3VhM8nkmguHP7KJQoYFQB3GzyRz8jJOpsRuUQ2HF48yIhdG1VUG?=
 =?us-ascii?Q?wzCQvbhtiglPL1xjUsmQ0paOQmed6bfPMjXgDoHi/Jz2kSExCvFfIEpzWiya?=
 =?us-ascii?Q?zvBZ4YQzC5yWbAmO1QN1lEWko8G3ss12ujs2TzrDngRCPCRGLND3dEEKA0ss?=
 =?us-ascii?Q?U1oNFnhxWOLEH0IYkKUJpXUfvsyEiLSwQWUfNayBn/MBVBYEBnGHtvYGbsVc?=
 =?us-ascii?Q?YS6pazxFHbcXNnpIE2jmGr76df6a+HtK0seono8lgF15YFibkv7d31WibdBI?=
 =?us-ascii?Q?RCT/sVzPXC7lmupRUFO78pG4pUUwM65ov7wkGH6FeQaWGsObQMbmP4H0nliZ?=
 =?us-ascii?Q?EE2nzG1T+E3Jr8dA9RCPLanw3iQFTgCOskZPUq73ujZAAOWxZ8MSc+kh8NNX?=
 =?us-ascii?Q?vieIX0McAyv4Twg2hRxr0H52Q2PQ6Gg7hae3GZNzep/BPO7xBxq+zMgt5Gle?=
 =?us-ascii?Q?ljU60gBQeJ1nGUuBNx8xKvbDfb1hIH1eeICqLw4eJtp8E2NBxn5iphlSwky2?=
 =?us-ascii?Q?hmt+eC3G2wuXFN9MZU4c8ZbGmzeuCi3qFEqqq/zcn8BX5uOPqRFxB/nGxvHB?=
 =?us-ascii?Q?VCjenlIVvcOaIADff82oZzflMDe0Mn9nJdwZ7Lb0HGBBbJvWldRIL+Ieh9I3?=
 =?us-ascii?Q?i1hTChvA/v39aJrPi9AfUgSSZJ23+ZnCbBS/7lTiHnTbRk0uNn6Z13qL8jvF?=
 =?us-ascii?Q?erhH7R4IjYhJCni9tO9P8QOTIH1q+wAS6X84q48zWZs2Dzmg/KRxrs8sMF2T?=
 =?us-ascii?Q?/Kgenui5rS6DHG5YmjQWn6JT0AnDBNt0RhWGFCAzDbxgZ/zro+EPSpMgiZZC?=
 =?us-ascii?Q?4hjiq3C2Kwb+4BD/asHFrz5dWWNwRkKfYq9U/o47dSJtu9/ssR/62bE7Ul7Q?=
 =?us-ascii?Q?JA9lMFUv4vVOjuD6CBcKh/e0KPFP7Z/JTtn5zKIdHRcJzRmsL7D/ZPp/dYI+?=
 =?us-ascii?Q?xOfJO5BYwSDHF5rcNWwnO2+2BvcPaymoIPCJbDCknpxRFzuzVNJMTTjTn5Uk?=
 =?us-ascii?Q?KmUL7CTVYA5fPNmiWjMgtAeDKvnjmcVQEwZBHp/KgGXq7dBD/5ElrsNFxIIV?=
 =?us-ascii?Q?AiY9KtpuVfnu2l7HEGIpIzbRCNEzzMMK4Xgh4G97CZoUiictijSUItSYIfWo?=
 =?us-ascii?Q?bnn0s6OkmY5K7xZNuvfiasw8nTKIFi/tDYnEGyUnkYvX1QlUaAjH5D1saiFX?=
 =?us-ascii?Q?077Vhdjgtqrz+l68cuxJDjZ+ndJYRaGdQA2y9jIr729cYHpOGCyg3AliolQG?=
 =?us-ascii?Q?ctitXf8apTufShCCppmw54FoyQ9tC1jf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:55:11.1928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf2a20f-0ee3-4739-8e58-08dd1b8e8683
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5854
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

From: Dillon Varone <dillon.varone@amd.com>

To prevent invalid HW programming, streams should be revalidated first
before committing to HW.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 81f5996f2edb..dfa36368ae63 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2153,6 +2153,11 @@ enum dc_status dc_commit_streams(struct dc *dc, struct dc_commit_streams_params
 		struct dc_stream_state *stream = params->streams[i];
 		struct dc_stream_status *status = dc_stream_get_status(stream);
 
+		/* revalidate streams */
+		res = dc_validate_stream(dc, stream);
+		if (res != DC_OK)
+			return res;
+
 		dc_stream_log(dc, stream);
 
 		set[i].stream = stream;
-- 
2.45.2

