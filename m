Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58448C001DB
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Aug 2023 19:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D529610E053;
	Mon, 14 Aug 2023 19:33:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C809D10E053
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Aug 2023 19:33:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAtH5KgC01LFPjerZKDXyd6bK0jx0RdGdby4LlsgjIikp4pkoiQIggJb3JMAIQggg7rjThgU96bcOe70Dp7t8vIqbYA8s6rX6lmCzZPTq4oYS53mkeToK5qRXKskySeEzU63Pt9h6VSemEm/km24z4YfSilyrIjIVGL+NfLDTTcflw9GHd4acK36bkuR8R4beh38YDlbYFLZsQ5l57xfqFkxxVeam6A523BuODKArnHTPfnxDIoy4NmLOHysfNL15xFC1wFSpW9/6deLdu6Pt1VzyJQZq/vfKIaIDqX4Jat1V3A5/AtyFVgtXhfoiUomQyzBQ/Cj8SLU+7a5UJk6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9ofwskyFvkNmwOg4HMyu786veKMxqdq3+O3gGCoMgk=;
 b=WJV7fOqB3NyzxiXjokfw5lZiBx9p3SpmDeUD525fl5I+1FRiF99jKEnX7NsmBWoCMA7CeEc2k0BZTeTyL2rRdmeupiBJYf3vD7Mwc90dDeqAWZD9o4V/NrzRR9WtqcfqUXKnJ674WFztvoPDmiQHaOfE49uhi3j/rp4/sdOQz7RPfIw8N4wAAdQyyEK7x8/9zDxywvs+AkeoKTucswAaNoODxHQK5OhbiljF4E4KMFZqw6s2HA9VFDjhdhsYruA8hKi863OOOlZKD7Ju4PQfR6V7sBkIGk+erafl8edXgNl6qkAKfBO/MW63tlIj+HpH/iYYLW5yEfJTEfdBbShj/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9ofwskyFvkNmwOg4HMyu786veKMxqdq3+O3gGCoMgk=;
 b=c6tE0wHoT4gVUf+HeXnAZBz26gZ5F+uohlzx6Gohgkl2IzL4ZhalyOhZrWkjzMkdZkb1QtOY0FqBErQvZLsAvjO1Bov888DwpiRmHydi2actCfvFurHDMZjr2E7ThSO6xFqS32yzZ53H2YBmc47E9+z4NBZyRUPiexhA1hTHzlQ=
Received: from DM6PR18CA0030.namprd18.prod.outlook.com (2603:10b6:5:15b::43)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Mon, 14 Aug 2023 19:33:18 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:15b:cafe::d4) by DM6PR18CA0030.outlook.office365.com
 (2603:10b6:5:15b::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 19:33:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 19:33:18 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 14:33:12 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: If HPD fails probe EDID to decide if monitor
 is present
Date: Mon, 14 Aug 2023 14:32:32 -0500
Message-ID: <20230814193232.12702-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 045fca96-4128-49ef-18e6-08db9cfd4ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JPK9qOFsme6hkqTpK8CngreE36sQTxGrslUqG3slLWptF5OL+7a7t7AOh3mJZLXYwV4Rhfz6bwukg7JejsJRvMeaaEltn53BgjHAHe/SoOtotNEDaH8pGP/tIl4FuqtzY/q3E/JMgXqV7TPQlx+ssRGzMLzE4DKP6YRlVK+dAlCPf5rPU+Z7tICM4F9GGyiFK/RQ7XEZUB2x/r7U34X+icWIxgFQgRcfTvMfC0po0DvAPsJMRmEeWtlzCDqAY1NGudjQbLvLMtkSkCpQb0A2miMiy3ikzUU/LDGu992V7l8FwJRUpMDWqUo7YwXzzeUJSj+Zoya2kVaUZFyIAG5kebnod25Ph//V8JCU0MHBQ70NjgnHckaeSGBeuqNepl1ugs5sm1pr5GPuXeqDSEze3br0FEyOHPOkHluYRYIwq9Bb74sPjjNTwbFzeREp1J9LpwrduLHRFOKcjDKnX0pgMwDwQMeFKjHK/9dKvjQrIN8VjYt7632YKcbyHj5uihpd9eLre5keQiGT4CvQl+uNJwYpnjdmBiRmUTyTPM5tYJN4YBqQFQfgKua0nYQ8Dqj5+fteuM32RLNgIR0ld2d0J8t16fCDdn6ItxknTnCxuGu6utwpDtKQ05uw6y60remX91cD1f/6AxRCc1oUCYIFh2fOVA5qt4/KcyvL+NJT3NapBcwAaM6UK1cN2nxg9PTU0Derny5vNEAXfAog9yIVyRBf8knF0pD+CU5Nc0U1Ryp3+sjJhxEUwb7k22dsGIIyo+EDQ3PEFWILo04C92iXSnlp3M9q1sb1Yo2AFG1xj1Rh3UV0fSu+cjUdL+KTG8o
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(1800799006)(186006)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(7696005)(6666004)(966005)(478600001)(2616005)(1076003)(83380400001)(336012)(426003)(2906002)(16526019)(26005)(54906003)(41300700001)(6916009)(316002)(70206006)(70586007)(44832011)(5660300002)(8936002)(8676002)(4326008)(36756003)(40460700003)(47076005)(36860700001)(40480700001)(81166007)(82740400003)(356005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 19:33:18.4831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 045fca96-4128-49ef-18e6-08db9cfd4ffe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866
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
Cc: Harry Wentland <Harry.Wentland@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, dark_sylinc@yahoo.com.ar
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some monitors return that they're disconnected while powered off
but the EDID can still be accessed.  Before determining that a
link is not available, try to access the EDID.

Reported-and-suggested-by: dark_sylinc@yahoo.com.ar
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/461
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Harry Wentland <Harry.Wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index c9b6676eaf53..26a739128dd3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1233,6 +1233,8 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
 	if (is_hpd_high) {
 		*type = dc_connection_single;
 		/* TODO: need to do the actual detection */
+	} else if (dm_helpers_read_local_edid(link->ctx, link, link->local_sink) == EDID_OK) {
+		*type = dc_connection_single;
 	} else {
 		*type = dc_connection_none;
 		if (link->connector_signal == SIGNAL_TYPE_EDP) {
-- 
2.34.1

