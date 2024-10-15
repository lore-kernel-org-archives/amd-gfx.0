Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE23ACFC274
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 08:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 820C310E547;
	Tue, 15 Oct 2024 08:18:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AYzncc27";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46D3610E547
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 08:18:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lu8L32Sp3mxa+LeUV7NnGjRWQMXcbvpW608lCp/xkE9M+o2n2j4p46P3YYkehemdGQljBL8pqu1AS8UtN4SSaEfRhl2q7vjREgw4vWHXLXfI4fte5uRgy7/3pZGOx/HhelPg6aNkDhmTuY8ZeN4ZzgdJh8mOuWKHyZzMMZ9XOuE6oNeSHYM24iuXyCpkPid1ORbDTVywTDHyDF3fHP5kjjxcdDjDm2BRPU3jnokN4bw+uZDtAo4lSILOZ0hCX7t5e/Vv2cYkfrm5bOol21eto0ZS8TCjDdtcjcmf4m0MnQ7WBtF1MX9afx7FlNDBEjYoalvy8FiJ+nk+ZHQLDsCl0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBi1sTQA7UHmDyMdyq2fKQ6yLwoMLkhDPCIEbXCWqmo=;
 b=PZdHPwpEAKx+uNC4yRPpR5BfbG7IXN5OW91Gj6+I8XD5MRBlkYFquaeszHbxhBExJYkpnG4Bos6eMWWawiwH9rBVoe/cx756QC//7lgkIu3DbVtpUpzhok7KkjCfZI9BbibWXEDhSrIAKxN6X6LDrInYFjIGWr+lwaU0lSw1pDkhUQyyNTDiozSX1tyZ1c2g+Nme0BRSklpG82RFOMjtRLsjlix3xVtbsl9E/RUCLK6ReNR3YzIpWZAgu2yc6LEwcwcijBQ2jv32Wji2DkYAnW472BzGhIHbI96QUND9xHdIwHo41oTUiAh9TbhDlwCezk12ccUDTJeLGDGl2sg4IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBi1sTQA7UHmDyMdyq2fKQ6yLwoMLkhDPCIEbXCWqmo=;
 b=AYzncc27n9oNLrBr9J6cRM/d2ufhoaHNUN+4KijGZtFqYOQSRHJcqV6kQe1zjqO1Retvz2z324tbYwcAhIZCjCVqW31tz+m3X8jKGqOxqyNvEyJRa9KLRwABgEgY+EPEbW1w9ICOY1/lvySdXQHsF+MiS6LhkEtyjcqG/4Vwh+c=
Received: from CH2PR14CA0014.namprd14.prod.outlook.com (2603:10b6:610:60::24)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 08:18:40 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::89) by CH2PR14CA0014.outlook.office365.com
 (2603:10b6:610:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 08:18:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 08:18:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 03:18:38 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Oct 2024 03:18:33 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 10/10] drm/amd/display: 3.2.306
Date: Tue, 15 Oct 2024 16:17:13 +0800
Message-ID: <20241015081713.3042665-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20241015081713.3042665-1-Wayne.Lin@amd.com>
References: <20241015081713.3042665-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: e20d0ad7-d354-4619-2ae4-08dcecf1f97b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?twoZfHfIF31xbxb+qo8NV740jQCRw8aFZoJ49UaYaAsYBAU370qT0JhrYHLo?=
 =?us-ascii?Q?Ek0QhitVxxyszf1Ym3EkJlopZF4vm4ew9pGKyaOaRRMTqdqrKDYgmwPBG95J?=
 =?us-ascii?Q?uClkaO27jY4JrzclmbvKE19nWxugMAQ34d+xIcYNLmgyCqd5SZYTOHozdG8p?=
 =?us-ascii?Q?R5ZzCgxeiz3yNWTPVBGYxuHIhdWmGtyyZY22tXuAuMGMXoBQLMz4Hl8LzK19?=
 =?us-ascii?Q?4bRvQSUomKwdQMlcK1vZcIlqwYC71rG4t2u8hZwxWA03ErvZ+8TYY9G2XoUK?=
 =?us-ascii?Q?4IMoZzo4WAc+LWRfDJPToa1Q+GLvq5H7ASUXnOtkPH/EO5XJF2OEOfW+mRIu?=
 =?us-ascii?Q?yu2EuslA+wMmdSlrhMQWSw374/kCj6v6pgnvdfDCxRtxrALTxAwGQIvrFNsH?=
 =?us-ascii?Q?v5UbB79+zqmOy80kVHDUEdnKb2DjXCgJgr/P0TODKxoZN+YFk2Jka5QXhOCS?=
 =?us-ascii?Q?dVjjNxYC4WFb8cQ2Q8bxYz9P5AN22o9lC1lvxFCL52Z4Stgegj+zglPHzx1X?=
 =?us-ascii?Q?cKLVP/vas4vvBKQRk+wgxUmvKHzilEbZrvcLaXTwXhOD/8bJlS0O1cuJILN7?=
 =?us-ascii?Q?WTUdhewlwAM5cacd4YwhYnHPHDPvfN7KzkScDw1/4uBKLMBjwzCla2cG5+rN?=
 =?us-ascii?Q?1sG5avMkrrkLBWITWRu9H8a/uFTsDyVrw5jqOm155JVo0uaYFQbjX9HQDEyo?=
 =?us-ascii?Q?0Pom+Q5oztx+mRB5FMCb9+FGSZwg/hRu9n6jLpU7Z0gErUEe0uBMTYR0gJlJ?=
 =?us-ascii?Q?PbagRqC8or3t3GRdFeF7dN+bDglZ33NO8mV/R0zTMh9n91zIElmyNkoy56xI?=
 =?us-ascii?Q?e+j9sBljsZUkGvlnhhbOXFQf1SyLX2eqoZ73lzazZOjyM/kf+5TUrFg5VAvm?=
 =?us-ascii?Q?BJcAFDLyFC0Qq3qbYH+JjQkbmzOwhR+JnieJjChrqbtAwi3A02chCy3txzoe?=
 =?us-ascii?Q?ASc9GUYlS1joyeG4Qwg32QcGC82a9jE6tJEXxoUYcD+OvXOLpsiWWIYp6cDo?=
 =?us-ascii?Q?FAWYEF/QTWJ0ZTzwk6Sk0/tVYCmD+bfjmQYQoLSz2oDuHgennxXvQTYmIgGV?=
 =?us-ascii?Q?on8WBN3SEe3uYFP1Ao9zFZoyc2cmTvzwVcH7HBeySEGplcUYwhQWlFSk89R3?=
 =?us-ascii?Q?Ue6L0nF2JTgwXXkfeiR93BoBWQqvacP2UtavFsKMyjHL8dcoFn3aDXescfqP?=
 =?us-ascii?Q?wzTbH94bViBwZttOG8t6kYyLhIxQNlAJRS0d5mR93qDwjpiWPdLxt6svs4uf?=
 =?us-ascii?Q?ureo6+SYVs4fpuOYw6AKY/Jq0WHi0qJMXQ2VtXbE15d/mlr/iE9jnNffUX/4?=
 =?us-ascii?Q?g9eCBTPJsSooEeHOhAR1H23BOax+mJhaGK8HkWJVgdnh+i/Y4Jb6YFRBm2lM?=
 =?us-ascii?Q?fRoMS6miPc5NPKWb2uH36zXIZcyD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 08:18:39.5546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e20d0ad7-d354-4619-2ae4-08dcecf1f97b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464
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

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Fix dcn401 idle optimization problem
- Fix cursor corruption on dcn35
- Fix DP LL compliance failures
- Fix SubVP Phantom VBlank End calculation

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6ba167d4c785..6d76dc110d38 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.305"
+#define DC_VER "3.2.306"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.37.3

