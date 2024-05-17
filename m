Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3582C04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 08:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B43310EE29;
	Fri, 17 May 2024 08:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m3pC8G9R";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3905010EE29
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 08:07:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGWD5Rk799sIW2213a3sMO5Z4rdR4d8ivmfSoAWiA0aiqP0TycTdawaD7CT+259G4UzkOMHX826HFjQFYQYhro3hW/q5JOmOUXtYZa9C8LKmPyOCzUYarWqltUlLdeiXtezEf62JJYqYqRTNDFPmEIctLv8l2U9XmvioeQBfmVLX4BkQ1SJTBw5vIzuT01hp2wfRCjHTOIZpBoP5GvFNbPB4XCpk/0gJoWqTwyFBZahHeVxhIqmEXuXqrQsJrirktIHbvKrmRqaEayDpez1xngCWSbTjEiuZ038RiFY9/hUP32TTJNIXet8zK0tgRWk+JNEg/LIdGJKhaurNupOwcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGSOLYB+cC1MVEi6dlqhEBTl147rxTq/VPINTJQFiLg=;
 b=K1YDgX42ZNCohwiabwMeBZkGnmZRmQD3GRYySmmPKHL+pxcPfQ8lHcDIe3+3fYwmZ8/K0O5RouiU/euOpyNrURTV9uQTWp7Xjr4xethPqTisUzqfoi/6bKDQntxek7X4fgoxZPxVpVOypquykL6JnFQFUYtHj7jf0B0D5Fg2LODC/NsvWH5H2L3X+LnORdgv79eJRYgn4FS9LnL29qw3J3j8exYrG9Q/VaQKb9RXofbV8Gv2r85U3vQvEMvvjdGGoFQNXDFkGeGDeTtv1z0/8FbKX9tu0qgL4sv4UwQAm/+ww9GRKy8S0lWjd7AZSwXtkcOX08ejfzsuGxx0c5nuHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGSOLYB+cC1MVEi6dlqhEBTl147rxTq/VPINTJQFiLg=;
 b=m3pC8G9RjL+yjI0w0tay3arOgNkq9J25NkRQGbSGfeyi5daGJsDcUpfDXHzEeP0Pxzxxggb4DdYMB4D0db2ow2gjEeDLo0H127kybeiJBuLMw87fszW3fgsZjdtfvSHjFgiabBserLbmE3RCT72w79yXr7VjEQNLWWUV9ukMfi0=
Received: from DS7PR03CA0172.namprd03.prod.outlook.com (2603:10b6:5:3b2::27)
 by LV2PR12MB5894.namprd12.prod.outlook.com (2603:10b6:408:174::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 08:07:21 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::f3) by DS7PR03CA0172.outlook.office365.com
 (2603:10b6:5:3b2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Fri, 17 May 2024 08:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Fri, 17 May 2024 08:07:21 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 17 May
 2024 03:07:19 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <yifan1.zhang@amd.com>, Li Ma <li.ma@amd.com>
Subject: [PATCH] drm/amd/swsmu: update Dpmclocks_t for smu v14.0.1
Date: Fri, 17 May 2024 16:06:54 +0800
Message-ID: <20240517080653.589948-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|LV2PR12MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b24aac2-9283-4140-b9f7-08dc764860c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ceyi20bQnLYgiWhO9xWMOc5QgjWzfq8iNgHWB0uuNJtSWJvJqi88nzQAiz9+?=
 =?us-ascii?Q?/h2q9orhYlP/eu6z5tQRGjqiBLc4MRzRZnDgm2h/EgDIz3FUR5Hs2tbyIoGZ?=
 =?us-ascii?Q?MIb5MM6UQUjqmr0d1lL7+OCE3IMQzKrtlXWvYJjEu+T4SP85O5Wx2YROQO5y?=
 =?us-ascii?Q?asgKgO+BJMOOuUniKoJE+8qgaigSA0LgkiaOO0FCLUzwdO5DSHSy04JD5cNY?=
 =?us-ascii?Q?4Wj6j+6rmrtlxXMEpEq/iTGmiC9I24YcArBfcdNOPdPaXafLdc4p/C9oe4Tm?=
 =?us-ascii?Q?n1uuTJAiZ00NXBtUub704YIZd1/0/CImySBrLXakKDPx+nduxEkRoGwzrvy/?=
 =?us-ascii?Q?SKYhhZzyu/RJWE1rQOhMH7LIxctG2zQ52Yk0u7FpFb0C3wTW5vmHwj1x/HHu?=
 =?us-ascii?Q?3bTNy6jQMyIy5gl72OBiNSdzkV1a4mqEiw3vJ45dtOB8n7X+5Kc3eJ9j3DBg?=
 =?us-ascii?Q?b/QayzClYcxhBhrY28YcQdfqoEKMlLas5kkGwyEP1tfPp0l6y8ffP2oUxlRD?=
 =?us-ascii?Q?foWmIgiw4q+c7cJAOnGO6eVA2hOLLYgxiHeFTWE78Y3wEqfBfq3DTbU16p2/?=
 =?us-ascii?Q?bIN/JuCAoi5VKsH/N+xvSk1x5MhAnogAuQf6doPdaElzeIeZOzfkaSlMnEF1?=
 =?us-ascii?Q?yR7aHN8crLwQWtrc2s6FP6I3u/jYxltcGGQ+PBO6cs5KZ3lCYEF6SBjaOET0?=
 =?us-ascii?Q?vDuNlwwvrrWMGDrfY2GuFDpeHFqFM7HVVknPcAvbzv/y6p4Nhrs95UVp35+B?=
 =?us-ascii?Q?jCCiQzfJhcJVvW2ZlW14ArMRiXR0H1ZfYcQbhRqYRuW+7hwT+bt6SiLH/dFP?=
 =?us-ascii?Q?irDOV86Yy3hhf4WTcwIxNtLit3/uutQCVHP6XEOAj/IWNzrE8FZNJOfiZ64y?=
 =?us-ascii?Q?9b4ipWQzv2o6DEm9/8X2xRUSw1IcFqVyqjMN1YBI8lkf3uWjYoDsOU8E7eto?=
 =?us-ascii?Q?AIY3WarpBuefgsbQOvJKRvkkwEaR6ronS5hrEasPN/xOhgBNcrAzjuUaoyp2?=
 =?us-ascii?Q?qwb/sWnYo4gHgapJn89A1vBq6lbWLV5a2KeXIs1Miq+vTfGjQdTpSPLEKbVU?=
 =?us-ascii?Q?cShNZtkmN/agAaE/NIaWiHWU+nfZOpSk4AdtlKWdIVilivMLbOOuSui/ldZ0?=
 =?us-ascii?Q?ASRLF7uYC6x+iscTwJVTaJZkaONWx/GY+j4nEiU9iNDC5FrOoXasUDRfF4dx?=
 =?us-ascii?Q?p4ScnJEVYTUnRxmRK/G51IT/T/RPTs0Rla4mMe2SkrFGrf0tTJdxRACnrujC?=
 =?us-ascii?Q?ZbG2r5ihOl81URNFV/n18wDZ+qy5Gp2PBJycW8v5QLZDuG8Dkg4V1LAK+yoT?=
 =?us-ascii?Q?2zV3xeoIfbDJ/4MucFpcZUDlPJcB+skqDkpAk2wyOPMScdADMEa0HlOccTMI?=
 =?us-ascii?Q?soBYQY5mKo7roeNJXwQwEsaUVPfc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 08:07:21.2083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b24aac2-9283-4140-b9f7-08dc764860c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5894
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

MinGfxClk in Dpmclocks_t is wrong. According to pmfw,
dropping an uint8_t spare in Dpmclocks_t.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h   | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
index 97522c085258..1bc30db22f9c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
@@ -169,7 +169,6 @@ typedef struct {
   uint8_t  VpeClkLevelsEnabled;
   uint8_t  NumMemPstatesEnabled;
   uint8_t  NumFclkLevelsEnabled;
-  uint8_t  spare;
 
   uint32_t MinGfxClk;
   uint32_t MaxGfxClk;
-- 
2.25.1

