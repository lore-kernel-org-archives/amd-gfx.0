Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9146BCD11C2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DB7110FAAC;
	Wed, 10 Apr 2024 21:28:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RBArxJnL";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A649B10EA5C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+3bOHuBQZeULqlZxgOd1bFCeatV+b0y3mNyjRe3AzS68RqlYCazGsQ83gxMNHt/m5gWOtqISGWCa+cVgR3zSxN6psSR0YtQ80sV9YzyFtamLlMXQoXRcQQzop2GiB57WI0pcbbpU5AAOaREgVrAqglDik3LO6wBQBMlf/Wehem8ZeZIl+waA6CNWOcKrsvQWmXq8+JDPQhYbf9iDnT4BmLqxRDTYV08msYjnWMGOziiW80D+8bDR024lDoSA9yrLGdPxxRBxnM0YazcjH+kGOLgPztCSdznXkupR8HO4zQQ2xxhwnyOgr16HSdt0wcGs6F7aY2T+R+1EiFAmk3tcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UI8tMsRWt7rkB31VHAcjRGoTp2ZMeERkjq1SGowvudA=;
 b=lNtzi3kczsbbIYnSrspeSxlJPySg9bK35iGybPyQa/o3HK9vwHnmavvqie3Oxm/ApN7/623jQ5HxXXxhfXaOfNULXs/jwzIaTUhmHj1DiIhGM+Mic7aSex2mvrDf4yIAJxVqz/702uJxljVYO103G3NtW0/d7Thejxgg+l1nISkDp6yQPBwtAbKiKaunWPpCS+9rXDoO5q1V67YkVY0fHw1AoXjgOT9JUXymXTstQSbVKnMY3RXmTE9QqxI3kKghbnmSrMXaGbHFSF1jlQpcBGM8TOdi10CqmxvMJe1j/GrKQ9r0WqBtjRYDVhln1e0qCiJbnnE464NuO1tSgUEU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI8tMsRWt7rkB31VHAcjRGoTp2ZMeERkjq1SGowvudA=;
 b=RBArxJnL4AVJs8PJ85W5W1boUZrhcLnbh+XseU03/7FbGkg7YII7f9Gw6M9G4PBDBvXhzR12WQUOHfYgZd0c/ahcEbrPZzOKCzK1hlZLWNFEJRr4CmvzcrqRWvaYQzAOgcab//usmAvoEL+0HfC+8BCFWy6RPbny2dxCcCeWV88=
Received: from BN9PR03CA0037.namprd03.prod.outlook.com (2603:10b6:408:fb::12)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 21:28:18 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::af) by BN9PR03CA0037.outlook.office365.com
 (2603:10b6:408:fb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:18 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:28:15 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 16/25] drm/amd/display: Replace int with unsigned int
Date: Wed, 10 Apr 2024 15:26:05 -0600
Message-ID: <20240410212726.1312989-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 9637b44e-6f36-49d4-e9d1-08dc59a523b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZLXg52Y7mm+mrjDiqu+u9oA29JdSwy7bJu1odJFaDD90uoVwTdas71BVqkYxijL4BL/JAFn9MBiTtonzATNBqtdTzc4zeSrJqhFqrfnPDDN3OEyXDb/+3PxdxG13sxX9emNgqArqrpaNzRv0zsxXzKZQNEBuqz0rU8FeRmK5yJgnDsVmcFy4THVpC/Y+uSVugjtOG32KYEDqP5IuwM5tTpOk844tN3CxddhWK/lxKLgHdXyETmVX9R2MY/ZIKAtSH7eI3BspxK0SdaKOLjrLLkAFWNfmm7j2TgxoDcmcRc/EnlBdB4hqHHfCMETo6t4R18Buf3ODPHDiCNFQkBDcP5+ol3QAPMHQ8z/0+Bpo+Cgb8rM/7R2U9cC/As7iVI7L0eV+XCOkf6nm92ejWyy3IaoOYgsXcaPUkMqFoZp3n7FAZ9HVYTNFF0FoxO88lnfJIZw5hXPV3/YdXBxk1Gmc3ss8amKEGb2zZz6seYZeOrwe7aNqIU1xpmspQLhXpym0dtlmoKuG8YVlN1DqNO4e/L888JY+Ng9Ldi2YUVz6UskUGaCWueGcEDqdBpf2Xfx3WTSRE2aR9gOxy42qEBjnIx94et+mPLK5TmMrPzeO8NxAyW2W2QqCp+3bYCm3qE+Su5YHyV/+ut0aZSkJUNg5gaKbCxztUUqLb1WY0rP55BvXxWuyGhHLvtLuamuznkb96RfvTW7B/s7YgmEACxxQfSpZSIwaLrKd7DvCsiZWKxdrUtCGTcEBeB4BBWC1NmR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:18.2874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9637b44e-6f36-49d4-e9d1-08dc59a523b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742
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

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index ee6493a9a79c..5c7e4884cac2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -495,7 +495,7 @@ bool dc_stream_remove_writeback(struct dc *dc,
 		struct dc_stream_state *stream,
 		uint32_t dwb_pipe_inst)
 {
-	int i = 0, j = 0;
+	unsigned int i, j;
 	if (stream == NULL) {
 		dm_error("DC: dc_stream is NULL!\n");
 		return false;
-- 
2.43.0

