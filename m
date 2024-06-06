Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D30C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EBA410EAFA;
	Thu,  6 Jun 2024 21:58:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GCiVJ4Fb";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE47810EAF8
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsF80apo1KP8B3zInx1Kuo+WTxcY+vrabRDOkienHF238UQkH9DDeoxnmQ6HlhbD35qJNyebMMvC3KS70IJlhtnkLj8afEf+UCRtVPaAS71vjD8T4KnUiVY4jsHDa9g5pOhrJAGUbgCoODc3wjqu6O0Xi57mlTWnQJGZhrbNz/uW1YCJcNiTt48C73TOh7E2h9puGNF0IL6GNZgoTYmp1qVSAOmMTTpIYlk6Bz/fqEflyau5OlWK1+blvgKcBLap46rB5aAuvhg5eftJjr7fOSOrGnjjMVOs9Dvu4DIBOqlIo8k83uyiwwGEdbbKU54X7+diVmRi6ID/pFn92MZKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1rfwTNwGnyp7iXXGFdjBpzpjAFvpQ7eQQslut9QBCM=;
 b=TQSpF+cm5U/ogeQQAJBZJqb5xwvDz6N+NOeP/0bOPSGbE0M4tYUudWERM/dz5MV1gmLFQKZ8S7f1mUugInaM75XZ1n5Spu7IJ/3/5eXjM4WJkqJPh/GzrGP09L3CQem/OVkvRH1AstF3ueH7qdYt+wuIjZ/j6mZuMtrOGoIOmAoSBdqfZLrNa5g266aoixVJhrYYHfBqai9vKVlf1YP0lBfZ1jQfjLSyLOIKAIUqKiZhuS0q9eKPMKpBgk6JUKg2WJyZSxUCrx/QyYc7toTM3mYeLjTsMj1mVrs01sTV4TVuChT/M4ByHMUgLXb0BJsW6QBCTC1/knKLz8Flw5SWWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1rfwTNwGnyp7iXXGFdjBpzpjAFvpQ7eQQslut9QBCM=;
 b=GCiVJ4Fbg3hHNG8Reo9f/MYy5c9fMZU4mUtLLHlsVcDfpvYGdnaUlJphtoUaCKCYtqoOy188555ys++om3EIMtSBt1f6lOw05tuClsW3EyEdOqDzWYHZlAiaIu7fRkk5z9AP+4yWCH5SHSEDX1UTb0tz570dPQvxKCZBnF0qb0A=
Received: from MN2PR20CA0060.namprd20.prod.outlook.com (2603:10b6:208:235::29)
 by SN7PR12MB7251.namprd12.prod.outlook.com (2603:10b6:806:2ab::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 6 Jun
 2024 21:58:00 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::a8) by MN2PR20CA0060.outlook.office365.com
 (2603:10b6:208:235::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Thu, 6 Jun 2024 21:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:58:00 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:59 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 45/67] drm/amd/display: use preferred link settings for dp
 signal only
Date: Thu, 6 Jun 2024 17:56:10 -0400
Message-ID: <20240606215632.4061204-46-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SN7PR12MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c456a34-2506-4009-90f6-08dc8673bb82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lxRATzpbW/ydrtgiFhlxyHKixuxrepEZmP0IWU3Zt8aDVFDlZr6S7Gaa3Qtc?=
 =?us-ascii?Q?iyKxbauJ8GYd7UzvW2/TDlmQUjCCs59yUIxdT9+sSPm/1k/ZwL6hNLnQvc9F?=
 =?us-ascii?Q?3+jP2xb7Swo+A5zYxAOU1wFkoZqLqzQS23BY8jeG+qwdrrPRw59OY7b/36FF?=
 =?us-ascii?Q?ZO7DMkny4S6A6YRgiBWIo+36IwkLjmcazcRIYDrHJNBSmv1x2V54rJzr34UQ?=
 =?us-ascii?Q?URvTgrWH6cV/PSng8ZFyQBWmFBnLun29lOJmZvrpsJrpUJBxrWe+For+3Nru?=
 =?us-ascii?Q?Nksly2Lal/M9fGvzfXdnPr/UuzONAeIP+YbPaQ+XTwzQt63zLrIPGf0FYkw+?=
 =?us-ascii?Q?O73rpQryJAzuHdP17O0V12vMQBbfmQbxuLNt+nocFl6e27q49Hl6Ole9oulD?=
 =?us-ascii?Q?Hijenjd4RcwthHmcmRq8k4w6MmKvH31JyJaiXIbNCo/2ADb/jEOASX/Ed2dK?=
 =?us-ascii?Q?HM1bXBHAh3jIPruyHvXdjc1NT1tkuhYLPcTdEMwpqGhCyOTObh7lJktzLlCz?=
 =?us-ascii?Q?s02/B4R+ydMvQqNytUQ9W6qUE9w0NxfZjI3VAvAux/s2NKH6TbecoE2TAICU?=
 =?us-ascii?Q?CZzRrcR70NYtaVFlh/9stmATOMNvve8kBBBZpx8A01yag++cWsVthgPDFypO?=
 =?us-ascii?Q?NkI9OubpFILMr77lIMIooly8QkCF+JdM09ClpiJ3kXu7aVtjwe7wSF6q+gNP?=
 =?us-ascii?Q?eH8qzUwtcQMuqhi33QY/SIkM37VQ1sBoZm0mATvGWRIg6ElfJUL7sq2qMOi4?=
 =?us-ascii?Q?klfrRduSg7LZACROdg6+xBnUueZVbI33RYNoSA6xS6KYiskv4OPofJ/7ZJvx?=
 =?us-ascii?Q?Va/klDYwvoqNxL8TzMOkLpc/93YEWhXMd25UB6xEfwDqQ+6MzcFcf0eTzaCV?=
 =?us-ascii?Q?/2UDvMMwzsGoFh9IbJlpV4B3v76l1FXXpAQSUo1nO4S1DeRdhzEqgbpkRO8Z?=
 =?us-ascii?Q?vnwOPdTJ45nzzDSAub9XHFz1v+brcR495h9BSiYwetqg7BKND2li5CvVcPtY?=
 =?us-ascii?Q?PIpNs7Dx3yV0LxuQnCk9H2v87YVvSK28Tlbz30cOVlbHqDrpDP4rTQMYGo1t?=
 =?us-ascii?Q?5i6ZvmoQLcHu5Cs3LposQUjD4TEVdYfddDTtd8NhbeWb/l0wWoKiQRPvnEHp?=
 =?us-ascii?Q?q45YiSX3azDlW90RqcXyHOtBgIAvBBObpua46oj0a3qfh6NTOZ5EvRd4NYg+?=
 =?us-ascii?Q?U/xiXhJxXJJ93f8mSc3YERXfw4r4McaF3koayJb9pzTw/B13my6kIAKwFtbf?=
 =?us-ascii?Q?VCV+/aEpok1WkoFt66qeLD9xnMtWTRnVw/uZAzNB3BR053yQBAM5QCyjR9lV?=
 =?us-ascii?Q?/8dv0oU6l2Hbu1QyevzMKLfFpRnQM3GTf1OWlrfX2psvTJo+HDhuOn85Iv0F?=
 =?us-ascii?Q?sj3lIOETVHB6VVjntEDXjLG//BUfuEEkdg3G1g6ewf8g8dqzJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:58:00.4243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c456a34-2506-4009-90f6-08dc8673bb82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7251
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
We set preferred link settings for virtual signal. However we don't support
virtual signal for UHBR link rate. If preferred is set to UHBR link rate, we
will allow virtual signal with UHBR link rate which causes system crashes.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../dc/link/protocols/link_dp_capability.c    | 24 ++++++++-----------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 41bdadc585b3..00974c50e11f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -930,21 +930,17 @@ bool link_decide_link_settings(struct dc_stream_state *stream,
 
 	memset(link_setting, 0, sizeof(*link_setting));
 
-	/* if preferred is specified through AMDDP, use it, if it's enough
-	 * to drive the mode
-	 */
-	if (link->preferred_link_setting.lane_count !=
-			LANE_COUNT_UNKNOWN &&
-			link->preferred_link_setting.link_rate !=
-					LINK_RATE_UNKNOWN) {
+	if (dc_is_dp_signal(stream->signal)  &&
+			link->preferred_link_setting.lane_count != LANE_COUNT_UNKNOWN &&
+			link->preferred_link_setting.link_rate != LINK_RATE_UNKNOWN) {
+		/* if preferred is specified through AMDDP, use it, if it's enough
+		 * to drive the mode
+		 */
 		*link_setting = link->preferred_link_setting;
-		return true;
-	}
-
-	/* MST doesn't perform link training for now
-	 * TODO: add MST specific link training routine
-	 */
-	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+	} else if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+		/* MST doesn't perform link training for now
+		 * TODO: add MST specific link training routine
+		 */
 		decide_mst_link_settings(link, link_setting);
 	} else if (link->connector_signal == SIGNAL_TYPE_EDP) {
 		/* enable edp link optimization for DSC eDP case */
-- 
2.34.1

