Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F6DEA4FBF
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 13:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BF6510E2E9;
	Mon, 23 Feb 2026 13:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rMRMZR5V";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010022.outbound.protection.outlook.com
 [52.101.193.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E67310E2E9
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 13:49:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhNU7jdac9xqqz87g8nmZx3WjM14xkoeqQwImK53Nd/owsZ3vkwmpOo+M3dMUhd7sthg1VFTfGvG0tntplyv2yQ8NJEGHJeQXiEKW0r4u/A/nVEe4nv3KBFwIci/hWtH+851WzbW8WdZw3P6XJYoeYXGhM2VilIGkiZXBf3GUAERXv8aUlaHhJoJ9iFhMmcZmxjA8j4Omd6NB6lqpba2no2pzefbzeAsUxYZD3bG7uog1UU17yE/AB76FEnFDmdBlxCNwqULFphHivpSw5UUKIIJlzT3pPM/g81eY8CjrXU2ZBOtnzaRGUBA3oqpBaoOJISNI07edJ/i3JW/288gFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8bGLxYsYIwmW71nHWH5TCT374oKbm+OKvd1DhTh32A=;
 b=Cn/2Qw0gPH8ClLNG06deAaiWkiPst3bdeKOaz7I9SA2t1bzAGoSjNrEnYeThkz/BtNJx1jS/bKPqh0hDFCn9uOag+pJFCcFdCEZaHb0A8ELL8Uv6y+Io4pJJvLKZNWNMPfiYZD+smbTRVwOYphnQbkBcF9sm1Tgmnfno6VVjidieR2A5Gwj/e0sHntlXvR3v46pQcX2cZkTu3cCC/AycNJ70BWZiWHLG9ldpgxF6zCN8dsbCqig6DLE7po3S1XVDwDBK7kTr6RoT5FYXwgwbzOI921zr9A5mcW0f7LQ3zNnVpIPucy9P3YNwXCqQYOwwRwvOnl6LYfRY3skGBBDbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8bGLxYsYIwmW71nHWH5TCT374oKbm+OKvd1DhTh32A=;
 b=rMRMZR5V2XL1lpYjD2yOFUSUZhIRCX5wk8rnO5T+M98QOaODAk5YHo8oF67Ym1cCokrGJ7kfF3qShVUZUa1S6tovd9GmhaO/w9MnVDKTZU4Ro2EocMW+5zeAmg7tKy5gVvOQX6nju76JLGNBEEq8S6Z1zopYR4Fl47QVsRfjFhs=
Received: from DS7PR03CA0267.namprd03.prod.outlook.com (2603:10b6:5:3b3::32)
 by SA1PR12MB8698.namprd12.prod.outlook.com (2603:10b6:806:38b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 13:49:29 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::37) by DS7PR03CA0267.outlook.office365.com
 (2603:10b6:5:3b3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 13:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 13:49:29 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Feb 2026 07:49:26 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Mario Limonciello <superm1@kernel.org>, ChiaHsuan Chung
 <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>
Subject: [PATCH] drm/amd/display: Fix kdoc formatting in dcn42_hwseq.c
Date: Mon, 23 Feb 2026 19:19:14 +0530
Message-ID: <20260223134914.1625954-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|SA1PR12MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf333b8-c22d-42d9-e269-08de72e25d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GKParIeq1ppWf96fTun9xs2t+khr/OKP3Wx3qmGnRHn3cZACFdJ/jP5TwNDR?=
 =?us-ascii?Q?M48KgK18bgcqUcigY0jb+lQzrlb74E1IkSddFdUZIRguOVPI8ZuvrDK1fqLc?=
 =?us-ascii?Q?2Jz2bNJOqKjnt9zn/nkvwdUW5lZcw+rIr5By0oLaR3t0U+Ey+Q614OM0hkMl?=
 =?us-ascii?Q?SknULi6P9PiDZa0BdpmfKvKsIos42WttzRpX7P/wkhkEkX8F5qHz29ePE1vF?=
 =?us-ascii?Q?pgB+XehJvbYT46KpYOdOjO7vnrwFpzPgWOs7LlXP6YbKz58P4C7StjyroVY7?=
 =?us-ascii?Q?hG+oG/6HJtnXEp6DFZvK5I4XonZ9XHYkn2MG7AcZM0HQT61hfkwpeikBZBvr?=
 =?us-ascii?Q?AxgJXXJYx+YkhpS39ddFJqyqai9QBx/qcVpbeHWPX4jf5jw+jc6w1ABxoK2F?=
 =?us-ascii?Q?abJ8FwrAnzc14U4qkfwUZx0fJnWOlvkl8gvjZjYlrruL3wGEUW5Dw8t6FlgK?=
 =?us-ascii?Q?m49dfkZWiGGQ9t0rkZlCYCXCIzeT/RZCOrv5TrQeQpCqhGuttKqVwXpMr6ic?=
 =?us-ascii?Q?0cwgVV+oUXieheZz2rlF1Zs9oS3F6GSUMylb0DDyt6RaGKv5lKREJYj9hPvp?=
 =?us-ascii?Q?jdhIS2JJRE26SQr8T+xKpUe6DAciZWwGma4LQ1I+TtvNSgmw04nbVeSY+eaa?=
 =?us-ascii?Q?1DxTbIyLuv7gwAMZvRlHvVzBkMHixM4cqjL+p68jgIqj4Tt+mnnm5wwx/Al4?=
 =?us-ascii?Q?Jb3H1hb6SQQl4+jLmy7faMYQ5P7wwyw6uphnjtEJnMb1j4CwQJirWtZSrK3C?=
 =?us-ascii?Q?xpvCpqwzmZZF2rf8PQAUeZpiBQd8vL1KvlY2593obUZ4MAG99oeFhDooakBe?=
 =?us-ascii?Q?31PzlbaLexV3iwNXGj3w8zqjK7Q6v8hovoQYT+2jdzoxGDTIFmYR9gyV6W74?=
 =?us-ascii?Q?UjHWcl4rCCuQ3Bi+/jYVuI75HcW2HMP2wB6lfiaV0192veW5OCOqwYOV07SH?=
 =?us-ascii?Q?EbG7YPop4/2hljRIsPMJehGhaCavrC2hXUAyv8AqTI3fx30kQ+P3VEZdHnnm?=
 =?us-ascii?Q?XebiT1b8BgxxyhRWvsTjm6YvCMvCkGP9XWscxU18BFeNOwqARX1DTqZ1txIg?=
 =?us-ascii?Q?6dxK8rrg6W3We0KyG5iGiZ8PDG2BTrJnVigZkM7eQNcDWHDrGp1sbjgoziHg?=
 =?us-ascii?Q?UT0wk9oRAFYuyuHczEw+rNsTS1XY/FGZp7KujZMB7XPVaSWPT6tTLTwulUOj?=
 =?us-ascii?Q?JTHYQjsTsW0UKlnmcnbhn7CHCXCClpuaAQ4lYpfJtr4Fk8KsV8BUvnoXvavy?=
 =?us-ascii?Q?UrPNH9kPHksjcBDIkz7lOjalZt94eTY1KPQ4CdayGZYSqWkfbgBfnfvjn2ss?=
 =?us-ascii?Q?YK7nFxIVTOXAj2NT8ql9iiJERrJA2ePWrygd4yAKM+t5B52ILm4MTBqcnMwR?=
 =?us-ascii?Q?a368y5cMCrLF+FrUM1LTolV6JRPJYfsLIT6PXueghShijBoBgn7fvIpgRQe1?=
 =?us-ascii?Q?058FRc7npO+a+RegZlTMQY9Q6DMaokg6TVQvsv/O/pZlIUBizG8kBV04sQI4?=
 =?us-ascii?Q?eyrYYd+9CsPvpxxj0UoYIuHveckyXDHS1Urd273tUF72Jm7wzVKAK2XKiOWL?=
 =?us-ascii?Q?5LjPdMdeDCZ+vM32ELdhJ6b+RtjC4Jk1kFR34C9n+jeUG6oV5oHZMe9NCbg5?=
 =?us-ascii?Q?J+Uj8z93dwdeZdhYDnliCYpQWx2Ey2oj9Ln+yNprc4LnqOHRSFZofw/iyNTz?=
 =?us-ascii?Q?Ea9bEg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IP0FNUT9TO2lWimQ4pwR4dq4TbEtGxSKN59xe/bmKMIBQiLXmgAIQ1F3jsKHROP5eC5TXt9T0qWRPse2ANLCiNUYiKE2GqjuNgWypMvII5Au5Qtf2WwCXM0PESawrhkJdoewliGE0czCrIbZJPb2bJuwUxAdO65AmZbKn572oufRJxAbEhP77JcHkbbtzwWjH3hTteyYj367mvCP/6XW0f/FBZvgGOhc5yQQfeBa4TynBj7hRBVx1n0hn1xnucJzPGYhPSlg2JCb9QSVpCczVN3Miviz2/soWR3aspmUZIFDfCcW4aef8qtAk9CA4+PowmEkr3fwpj8YvravYjxayH+yurtijqmwdu7N5m0IR5V24oYViYZCF70Drvt7Rcgtv4qb3dBi/Sb/1kH/iYa0Fiu1hp0pw0mZ9UQaEc6T6ofWI71srCrZnpjcKrowaPpl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 13:49:29.0393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf333b8-c22d-42d9-e269-08de72e25d90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8698
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

Kernel-doc requires all lines within a documentation
comment to start with " *". The previous empty line
caused a "bad line" warning during build.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Cc: Roman Li <roman.li@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index c9c6ef8236ed..0d9871f9864b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -1294,7 +1294,7 @@ void dcn42_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
  *	ONO Region 9, DCPG 2: dchubp2, dpp2
  *	ONO Region 11, DCPG 3: dchubp3, dpp3
  *	ONO Region 4, DCPG 25: hpo
-
+ *
  *  No sequential power up/down ordering for DCN42
  *
  * @dc: Current DC state
-- 
2.34.1

