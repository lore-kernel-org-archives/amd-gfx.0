Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDEBC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 16:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60E3F10F038;
	Fri, 18 Feb 2022 16:59:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA5B10EE63
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 16:59:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGxOP/iryT1EJlSJKDdgz1wBu7aglt5lEXcstv1XPZ8XKJM/FJ31o93icmN7EqfjptGqUBb+/OFKiBQuW6n4g0sszgPEKxwkWnbMqwWe7qWHl11vKNqnMTOxB0XuRCLd8EEOEgYx+gHOUxkTQzWDpZ9REH6N26koa8ifnnbFKMsWDMbdfOcLlZqjE/Dvtde4dB6/z+dRYq1mnwMOjbdmIJN1XEP8xfmpdztf9cdmpEy0D5gd78BmcYoYW1nZvrFAP7sEgpB8RfjH7r3RpETKAv60glCzmDrSp+utkeWTIFrBv0oV9rdYRatXPu345WMLxkjZ3FJVFUB0MVJMNjf/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/A0kkkUhlh+BFOwKyjlbNJVRxJrD5oK0qW3Q3OMm/Jw=;
 b=fyW8IOKAfUv9vNjnSR+LcCkZDP/6YexdlMcL106FF7EkMWtyVq/A7xcWUbKatw1dQYNI4arKsa/j63ue7vEY9jYY8fZAldPWhKf83rFf70QrLLwfDUBgqYUrM5SWTPDu0yYUvUfHVNq5NVslv5iMF3MT3t56eCTUUGTsObX4z310S4XtoNyNzcDiPQSHj8FAnd0KSlmw8I4y65ER0LIUhzkFXi7WymtC3FAIOb+FfHgfR/iu6pKTt13fu+5YBt1RwKwovT3n4Rtn4OHbvGsiAtI0QVFP8s3BXtiKrrwMyMCZfiRFchh0kofXVeeeLO3dvThxNN4Zel8X1DF/qYnRUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/A0kkkUhlh+BFOwKyjlbNJVRxJrD5oK0qW3Q3OMm/Jw=;
 b=MrWjZ7l7cPFsgi+GQ/38IgowHjzzV3Ao7UIRWtYpt9aPl1rvBpyV3jpUQzDB+th9kALop75LpiL/FeHHoT+rEQAsTXkrH5gguFusvh/wqgjybZs7kw/+WKgsJpW1tN+4URR2bOLKwTrDpB36vPwobjisrPU35DQBlwMk4dOdmAs=
Received: from MW4PR04CA0344.namprd04.prod.outlook.com (2603:10b6:303:8a::19)
 by MWHPR12MB1422.namprd12.prod.outlook.com (2603:10b6:300:10::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Fri, 18 Feb
 2022 16:59:15 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::2f) by MW4PR04CA0344.outlook.office365.com
 (2603:10b6:303:8a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Fri, 18 Feb 2022 16:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 16:59:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 10:59:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/13] drm/amd/display: Add DCN315 blocks to Makefile
Date: Fri, 18 Feb 2022 11:58:51 -0500
Message-ID: <20220218165854.1417733-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218165854.1417733-1-alexander.deucher@amd.com>
References: <20220218165854.1417733-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b40224e1-72d0-44a3-9673-08d9f2fffeb2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1422:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1422C123D11162B165557B4BF7379@MWHPR12MB1422.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j0R4VZj8eOMW2dU3BYP3n3bHVQfnud2X7gcniXxPKo7dynBohpJA3Qu+aGcySaxhXE6OhvkFVW0H1K4tWBntu0zENGsfb5KAT9y5CHNo0KJlVeWFNRgcG3A2QhXigtGOAjUKkbG39oid/TIS5ayV99Cs0Wk1O5jarz+3KPTF2VpTDpHCs4lrl1GSrbsFwr5StU/31/r6jENjP7JGNGK3Irx5ybC1FE1jsVzxijqOvqwNz1C/EV3p2W0ZMIdcRNg7jyrwnBPh0cTY90RNicN6aqsbL99NaPK2yPZO92Bf2WdWYFqIOXttBKepfTvjoBOsMKmWMRpKm/fVoEi1WIsxDW4aXgLiHdn1/R0kl9XHKn0M+NyU8fIwVjix3ufueitWvJkOX61bcLIiR2iNS9tHYwkGFN2UNnJau6fyul7AQSwZKV+8tDBH32S1gtjW1qkkVyKJb4hYOODV+Z3xSE93ft4A8Ms93b/8eJDR2FjADWq/15NHCItGSt451QAzF2KLhZgV5RzfLRCArj4sab4rPhpJtASOezE91UcSisUjUhpP75LFgVdNrhLIhesIpWiIG0x5mjYbimuvMb8mQcNl23dKt1FUvGEKdv55i0I0hCgq40lwLIdFF5UaLgZIvIetOElCneQqYYp7fFX/6otyESOKwcp9aVOmSgwjtgUffjePgosk03Gq2ZtrLz7H1KK+RA2yQOM/AOBM92UJw7oYpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(7696005)(54906003)(6916009)(6666004)(508600001)(1076003)(426003)(16526019)(26005)(186003)(70586007)(70206006)(36756003)(8676002)(47076005)(86362001)(4326008)(2906002)(36860700001)(81166007)(356005)(82310400004)(336012)(4744005)(5660300002)(8936002)(40460700003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 16:59:15.1460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b40224e1-72d0-44a3-9673-08d9f2fffeb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1422
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 30d0286b2291..f05ab2bf20c5 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -36,6 +36,7 @@ DC_LIBS += dcn301
 DC_LIBS += dcn302
 DC_LIBS += dcn303
 DC_LIBS += dcn31
+DC_LIBS += dcn315
 DC_LIBS += dcn316
 endif
 
-- 
2.35.1

