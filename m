Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77042C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B9E89D4D;
	Fri, 31 May 2024 16:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JWmbXjE3";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2CB110E288
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQnRoHWCr4HXw3716/rWm48MHlaryhnU518eQFJDVda7U+AmdBrZDJ3SBNbJ2dt4fBnEvskSg7a3+pZaWQsiLCOv6ICGjRta3k2qTNdqWrhJERVqGic7k0HXuno+o+osTEzIaPQxHKl9rxbDJaLHnQSYpq1O8EkycM+CFuIYN6U+bWTzaGAffedztHX8rSGheuylP9NgFnWyBwfz8ofqsk3JA8qFK36AzthKkGTalBZRu7rSBHFSnOib7Dg0TYilVVGZR+BkMwSN9rjMvDmnzTxmgix//t2zFDb2N+M0dBTirOx6AJgRtu8KupF0Dvw8WYlN5A+B23b4BlUeHk+ssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h74/sWs8ivemkfSS14EaU9RZQI245ADvzcVxrXqNqPA=;
 b=fOsURrOdO0JnVLT9LnLRsgCoZDEdMBZ1eL5SSTy7lP3KYK9yJI6Qiy3+WFapC6J2KaWkOHpY0E5eJV91yykUnMlEVeNJf99bFOl3fnUw7T/18RxqOXhWjiBAYSuRSV5ksz2WseCvaKXV41tTlrLkb7wf8v2qfWQbVJftnmISQ1+sG+uQSyMjLXRMlaFz+emlNETQBiHsPT1lJf4uuJx9OyEAaIMwlTfSAVfTJCH1+J8RI8yyHqLlRnKQJmVGboAZzsIzTFmH44RLKlj9E6EjiMhyVBgzao6pZjnepcpvCUAwvYefZGhu5pBp95rUNCuybpsG2hBnhEaNox4uUL/M7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h74/sWs8ivemkfSS14EaU9RZQI245ADvzcVxrXqNqPA=;
 b=JWmbXjE3XvoJtAqoGzEDh/7MhuT0xY12CuLaWf5GecNDgmif4yjZX9Ud8UO8cW3JFo38b9P4kKjflBEUg+GUz/dFC/r45zHPyiWBgvhIyYKvAeUiJkWtXC5fonJR9dbVygTPElqyrQa8PplhFVWNsI1tbqMxfH2wpBmceIzl6Cs=
Received: from PH7PR10CA0020.namprd10.prod.outlook.com (2603:10b6:510:23d::18)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 16:52:35 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d::4) by PH7PR10CA0020.outlook.office365.com
 (2603:10b6:510:23d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Fri, 31 May 2024 16:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:34 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:30 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Joan Lee <joan.lee@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>
Subject: [PATCH 09/32] drm/amd/display: Add retires when read DPCD
Date: Fri, 31 May 2024 12:51:22 -0400
Message-ID: <20240531165145.1874966-10-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fda792e-695a-4b10-687d-08dc81921200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2wV85u7Z7nuSQPfVzpu0HlUvlI2WeSfhPl9Qy26If2uyTuxw/rS8Jg6swIGx?=
 =?us-ascii?Q?WzF2PdHFDCf5SUV8kQ4BOkZJBNKCshHOe37WaN77tiAPzlPgl4jMiuqkuH36?=
 =?us-ascii?Q?4UCKnPbvwcv5aZvVyMarGgFQX9vPH8S+vte8pL2UusSYya7i34yzx88+w9ub?=
 =?us-ascii?Q?ScySoM2mtxbv/LeCzk5LDRIm3CYTV71usKgzySQ/IMzH3RGBXRvbc+dQg9dY?=
 =?us-ascii?Q?NDZx5RQw04SNYAaByLtXTF0G6373N1QyT46mjQRaSzqMXd5jNkpziS1UJPau?=
 =?us-ascii?Q?0tgXL0cvxVbM7p8JWAWnjRDROseqaRdrw/XUgq3qSUSgCcfNOv4crfNdPhoW?=
 =?us-ascii?Q?XsEKb7G3l9AV9s0HlCsdbf9zSgyvcBHBmX3VUMp6BI6efu2ufoSe/msVTvTA?=
 =?us-ascii?Q?1anCdoZGMFin6Y/AnJBnOh50FSSDAc9exLeQxx++Pi8jPKvzTFNuhbOvABti?=
 =?us-ascii?Q?4FLUdKu0ksz/PpzKyxKiVZdTg8a5c+bInutfpYGkUAxzjY8gtY8ss2ehaJUn?=
 =?us-ascii?Q?4BsRUq76ErvPBWhYOREGRjQBPqFpz8lW2cl/eIkBoM6Ch0lsSi1HFePFc8D+?=
 =?us-ascii?Q?r08pxV3z7mpaNYaeZR2+e6CZbf9sBO7A6pX6w2gbZdMc1cLNkiAgicSjsg0Z?=
 =?us-ascii?Q?WYgASivZZIrUlVcbPOG2nreJ3iSWPtyfe0qwYZ/D+nlZug3Su6Kh2MqjPOub?=
 =?us-ascii?Q?Dn7qVWVTgbpkpUEAuuFikTMDAbJCL+RpII0J3DPCyoO0Uf2h5lsr+rA5hNIj?=
 =?us-ascii?Q?1lp/I0NB6+bmuab6eOZYL1Dq8KecjBh7ValdUmcwT5xxgHfJ3PWIvetH0gGo?=
 =?us-ascii?Q?+C4WatAMwq/NWaH/Eeg/cei+FB6d77SMnUiVDq0Qe/0k1DpA3gkpU1lFdYfi?=
 =?us-ascii?Q?64k4E9MlJXP1HLGOiXio4JqIMC64PdpEZmn0yw1kXIP/0PU9rNl9+99Jf6/Y?=
 =?us-ascii?Q?z91m2TNseOqda7Tel4LFm66E78VFMpZcwaMTIJSyKJnIZRsZUIOpLtapoJ4N?=
 =?us-ascii?Q?/3t0KJoe5JwIuWHdckcIUocHDsqAFTsR8GtHEjfYVtUak/lRGbh1upFvEfa8?=
 =?us-ascii?Q?lS8TTxNet5oRBLLHmLqI2uhcvWEumH+cNVAtFf1APXwlv9rVvzz9Nd/mSwu/?=
 =?us-ascii?Q?EkrX7n/OnHw0d+HvfaZ5FokZIW8jI2QiGogpxMGIdFZyugIXSoLk4cHW9NcD?=
 =?us-ascii?Q?gOQp/n5qJvZB5G5n2tuLPVTXeopxgodKmtI7Fw0RSmwCD1ePDED8b2RqxHSd?=
 =?us-ascii?Q?P0zGkzIf092Iq77JJQ/NwdZHhRrHr104BpeQiD9b44V8x/glTeRcdmv+HHzx?=
 =?us-ascii?Q?plty5jF5BcTbf6lBzgC/8B9dRWJsGAE8mVG7/QrH8oX/nhw0CrsGaeSAjevA?=
 =?us-ascii?Q?0t22hnX55fOZ/eEWKVWPKwbFWi2d?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:34.5899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fda792e-695a-4b10-687d-08dc81921200
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467
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

From: Joan Lee <joan.lee@amd.com>

[why & how]
Sometimes read DPCD return fail while result not retrieved yet. Add
retries mechanism in Replay handle hpd irq to get real result.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Joan Lee <joan.lee@amd.com>
---
 .../dc/link/protocols/link_dp_irq_handler.c   | 26 ++++++++++++++-----
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 659b8064d361..5f087e930cb6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -189,16 +189,30 @@ static void handle_hpd_irq_replay_sink(struct dc_link *link)
 	union dpcd_replay_configuration replay_configuration = {0};
 	/*AMD Replay version reuse DP_PSR_ERROR_STATUS for REPLAY_ERROR status.*/
 	union psr_error_status replay_error_status = {0};
+	bool ret = false;
+	int retries = 0;
 
 	if (!link->replay_settings.replay_feature_enabled)
 		return;
 
-	dm_helpers_dp_read_dpcd(
-		link->ctx,
-		link,
-		DP_SINK_PR_REPLAY_STATUS,
-		&replay_configuration.raw,
-		sizeof(replay_configuration.raw));
+	while (retries < 10) {
+		ret = dm_helpers_dp_read_dpcd(
+			link->ctx,
+			link,
+			DP_SINK_PR_REPLAY_STATUS,
+			&replay_configuration.raw,
+			sizeof(replay_configuration.raw));
+
+		if (ret)
+			break;
+
+		retries++;
+	}
+
+	if (!ret)
+		DC_LOG_WARNING("[%s][%d] DPCD read addr.0x%x failed with %d retries\n",
+					__func__, __LINE__,
+					DP_SINK_PR_REPLAY_STATUS, retries);
 
 	dm_helpers_dp_read_dpcd(
 		link->ctx,
-- 
2.34.1

