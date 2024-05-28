Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5735C25B78
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 06:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 675AB10E5B8;
	Tue, 28 May 2024 06:18:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YUP8wltf";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF3210E5B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 06:18:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoejlQomIAVibg65DG3OYwa1T3yln4UTamCLeVBLDQy04ih0pA5HZMisPGr8rJ7/9pUoltZWpoPkH0ci4QIQcQO54Hjaf5gmYC/w3aCpN7V0UkOUE11agALoq4uBsBR/d+uxPz7BlQ6jt87KoWnh84j9U5lorqgemWsI9P43K5nq0nhXFkLAuC5mxJDSmf6zRUYpKOBvdqZL3bMIaCMuTanHNvECGe2Ce5KAp81sr440+/VsO8RttcOj//uRmwzYWTZDi+JJ6qwqi82Malev8vBRi9xbf+2T0sf6/2pd6eZUdOgDfmLai2XY09Km/yfZl6dYFFiIdGKLVZSGrt7Xig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bXr35Y6GDiJYTypISE/oU71l+NbRJm5g6/cOYuMZMs=;
 b=BZQbfVMyq7IaIPGOth8JNz9LIK69nqVT4U/IC0Cf+49jvoZDW4/gj017D3W7zI8NYoYV8DMJbj6R1E05do+jFz9O5L9ZT7CbvdrksBzMqR6VNSuYortEOKGj59v7wObt4ANbgii5u0B60PxPg2u4duXp5BiovPJ0AUZLJaWyTi+jKX2yLdUyewZ5Zdl6BYUeKE2R25pXh4cUnwCWcdIZuEUxaZ12uOLK6pYdOR+UEIkOhh+Q6CmpeXTbj8VhjpYmQ3CdEH2Zw1pOc4VUFdYiNMkCAgwma7TVBAvfzOaciUtgUlHuQmDdqdi2nvG2Tn9A2bQu2m3wsSwH7Py5Mu8HnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bXr35Y6GDiJYTypISE/oU71l+NbRJm5g6/cOYuMZMs=;
 b=YUP8wltfnqLBhW21vXS4pr8+xMAClqL9nnwtImyKQHNrcSFKCYYQzdKe6r4mdUPOmB7x9OpvQeVwixQQshhegMNaHxJDg4OtT2rWqMYQx/V+fzDeKK/7GJneeuwVV74n1gGNQ2xvB/J5jRVGY3bLdjtUH+9CCkYxX+eH4Mlshb4=
Received: from BY5PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:1e0::25)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 06:18:35 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::97) by BY5PR03CA0015.outlook.office365.com
 (2603:10b6:a03:1e0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 06:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 06:18:35 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 May 2024 01:18:31 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 "Nicholas Kazlauskas" <nicholas.kazlauskas@amd.com>, Bhawanpreet Lakha
 <Bhawanpreet.Lakha@amd.com>, Roman Li <roman.li@amd.com>, Hersen Wu
 <hersenxs.wu@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Add null checks for 'stream' and 'plane'
 before dereferencing
Date: Tue, 28 May 2024 11:48:15 +0530
Message-ID: <20240528061815.1854133-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|MW5PR12MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b65320-fffe-40f8-6c73-08dc7ede0188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XbUlsWuEqswTlb57iur4fYcxzmRIpYisK2Yngqyu/h1ibQiZFG79Xnz/pkjH?=
 =?us-ascii?Q?qa4F6y0xolrRcBIDxmRC+aFpkzxFShfJ8xYqM+sKIx6TLSnxiJkJ2ST/l74g?=
 =?us-ascii?Q?xEPCE16Cg41fTpy5okZYiJpXzEAzxe/ttjy8XOp+ePVZBEY4cIea2aPaPvvP?=
 =?us-ascii?Q?hhTvfX4KGcBS79fUf3L8shRf+dOxUOKV3kbK05EtIpp5lFwuAWZFSgmFhgbB?=
 =?us-ascii?Q?dfB0VJXYVFEH1kIsi1JCvBpS/7LNIPLyr+vDWGplIty3bImyjaPWuL8lFFTp?=
 =?us-ascii?Q?29fuF6X8fuWYKh2ZCKhNGOm74zNlgT+dYN25Rn4TyThUKpPtu2zc8G/+4zRC?=
 =?us-ascii?Q?hufb90k9N7nZPfWPi6xHvCarmwwg3s6cprbjjAe+PZ742FqatIJ26yC0YPaU?=
 =?us-ascii?Q?sRMP+JgjneieZCqtLwsYd5QD6E7q/DelJF4uVwT1s/jOMX5hBlu+QRX5Xz5k?=
 =?us-ascii?Q?J3h4uOGumO/7Yh6yKVeJeE9AtPFrdT1CMJapsrw427N0f03NikzBpdzjWDsy?=
 =?us-ascii?Q?sNf9kOXT7vzBLbDhQ8hLI57m4rTVC0RRWYmvkltbuT6xbq3WRMg4e5YISI7r?=
 =?us-ascii?Q?7cGwf4xupB0r1t59lcQ2FMlMly+X67a6XWWAgCp7A4dLUfqCYBUuH0HgQ51I?=
 =?us-ascii?Q?H0qX6Jf9K1dIvTUr9p92IalzFOupAUuMIHNGmGb8eX/IIp3utJer/EqYHNk3?=
 =?us-ascii?Q?ee4B3toAtD2NbtK+pForXuoQq453X7OiRh8+0GzLTkST1ERZ7xjf3JK0yGxK?=
 =?us-ascii?Q?nXMOIs5m9Q8TEvOsZYxeB1QEWYUeT3qmpRFU5bfNkgmsu35eSa8pGXTHemlT?=
 =?us-ascii?Q?wQmnoP6or26WrgkfyOCFV/56QiMcY+mAdwLs6fD1c35PxEKGZZLpAkG4RHO7?=
 =?us-ascii?Q?6npi9JPmzU7XZDH760lWyOuSP0XmyJGezxhgvtVGirXTjGd3Wr/g3VaCiOlE?=
 =?us-ascii?Q?Je0ARl9m1P0MG0HhRR7n4x9JVsJpYVfO6CvYh0dYtTNO7esy36XXqM0Q7Gbe?=
 =?us-ascii?Q?y103UP5rc5NBZ3H8zP0GIUQcEZT7zZ5NjKHrpdrYAESqFK8/XNOZ4YJidn7M?=
 =?us-ascii?Q?+SSrxibZ78aX2S3O3bI5c0nwzeRov0hnBzDNQh49bBxWGRF5sGV2pMTzObsI?=
 =?us-ascii?Q?Y9fOoCZe9IeBkZqGPqAi/iCt76tJuomsussiPUNQx4myjMZ599MpShkTMDE2?=
 =?us-ascii?Q?B0dFJrPgzl82xK+toPMj0E9ZQJqbq6p8myvuSgOBscUqRwaGsmPRUJyRupOt?=
 =?us-ascii?Q?95LK0KlyY/+iKfZt1iabcUWp34n3JGN7nPPOb7gXVt0F3/FzvDvZKHOTxANz?=
 =?us-ascii?Q?ph9ODWdoKqFrsZP6Q8TLo20AW8osYmHawQ1WghcQs95yeAawtdALumllFPI5?=
 =?us-ascii?Q?8wcjQXxS07FKe7329IuxzVeZvdwZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 06:18:35.2075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b65320-fffe-40f8-6c73-08dc7ede0188
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
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

This commit adds null checks for the 'stream' and 'plane' variables in
the dcn30_apply_idle_power_optimizations function. These variables were
previously assumed to be null at line 922, but they were used later in
the code without checking if they were null. This could potentially lead
to a null pointer dereference, which would cause a crash.

The null checks ensure that 'stream' and 'plane' are not null before
they are used, preventing potential crashes.

Fixes the below static smatch checker:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:938 dcn30_apply_idle_power_optimizations() error: we previously assumed 'stream' could be null (see line 922)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:940 dcn30_apply_idle_power_optimizations() error: we previously assumed 'plane' could be null (see line 922)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 29d1f150846a..4c4706153305 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -919,6 +919,9 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 			stream = dc->current_state->streams[0];
 			plane = (stream ? dc->current_state->stream_status[0].plane_states[0] : NULL);
 
+			if (!stream || !plane)
+				return false;
+
 			if (stream && plane) {
 				cursor_cache_enable = stream->cursor_position.enable &&
 						plane->address.grph.cursor_cache_addr.quad_part;
-- 
2.34.1

