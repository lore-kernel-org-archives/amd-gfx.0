Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC48C25B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2DF210E3C9;
	Wed, 16 Aug 2023 21:31:08 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0926A10E3C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:31:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8rjaCTrLcYhIiTq/FICRrFL2g81VMZNqin4G/NESGqBMI7mCbdnsFGqJb0KDl61DtZVDUmdSJlsCZjjIV4KU8qZ+UuHtsK2a/dcKs7pMPBNzsH3QG+2YX8cmeKtJahAoodDqaT66wYt7PuSK7JkufZKNaC8FX5cevYyGhOg1yhfNL9qEJJhaRMYVf/94dE2Beo0uQ8uPY1nlxZVSoP0EpakFyqnNIerTEOMYFsiZ68ldDYkJf1Ui0wRdq9fo86iwR3snvXzsTuvxcp/IM2QecEs1kROQmSpgrynRoiU5bTq7XGQaPAL0RXK1xthzLeZPZYnSn7hkMEp7aD9FV5I6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lf6AiJ9aqlfDPmtNgZWW3jF9cV3Twhrbj9uT7v4EFs8=;
 b=DCiTncbPhttwHrjJ4HJQefAsCJ7YxTqOyg/UDsrDVb1vqQqkboBh4gnXvTbLBKl/dqTF8FbG7LLtcY839yRxNiY/M+/Rwz0hiUVZRRFlzuVHqFv1PWwK2xWJBs7ys0jVLpfXIRznGJHte0V9FE82FsneT3jxZbSyC/pJncz04185+LhfVeRjZGs/rAB7ugBXnIOwiJjJqe/gMIVxoKnKBdixyYiYCwmIcr4J+qOvbz8ljFvlYeHjx0dA0ot6UrLsKaNHXjTtaf71QPz6EbJgreb4GQjAIxFRukxZYwxxtN+wedkbe6iaU3djd/87Cro2nGBXmGpKShHuJVQllwzPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lf6AiJ9aqlfDPmtNgZWW3jF9cV3Twhrbj9uT7v4EFs8=;
 b=Ki3ICBJckKoDjY6C/7YaxX4gAuVxbtD12pa32cDT60YGfv2N6cn/bGdh+KJkdzRqKeogkoQOYjRacI5xK6gWmKjpqshL9mUfFKj4HzDEhKjnPNKfaisDk99ssCyWHppr3eVwraycuFVMpqi4z/3AUpDnpRdOZVHvjZJKeIYSq3s=
Received: from DS7P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::34) by
 CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.30; Wed, 16 Aug 2023 21:31:04 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::48) by DS7P222CA0014.outlook.office365.com
 (2603:10b6:8:2e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 21:31:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 21:31:04 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:31:03 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/18] drm/amd/display: Fix writeback_info never got updated
Date: Wed, 16 Aug 2023 15:26:20 -0600
Message-ID: <20230816212626.987519-13-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816212626.987519-1-alex.hung@amd.com>
References: <20230816212626.987519-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CY5PR12MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a59795-bf75-4616-40d2-08db9ea01894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcrD8/o2TgNYzcFhXvhK+NKtMQr324nuoUYYv+r7rfGh7OL5MQxTLInYFCcwcUxHDGXgeJUx1Nb/xuQbiJmXjxSOO5yXRNcdX9RiGImyqIC0tOd1wYAAfo82a7tH854w4PhApCRFyw/ry1OCaU5jPytoj/5PDWmvDorOaVgxYhstVrJtGucwPmpDkR3qRAiC0yvXQrKHzgfNyhLrx/z0VoRuqqXmlccl6PG7lLmoCNEgfykOZJCbxZJ7DhnG7Ar1sVAsbqHFYNOp+poBWiyoMzxurqtsdcGS278m8KaxKF6+d/eFM+f1IuRQ2jIagUNr4ZLrKuKLEe5zeY+5A/GBxt8QmBv0+61PCy0O6cDFqEftV7e2B56pp98lSvAmCr/a55WZfxBsChsh6riLsaV1CYn4KONpqC6VG8wXvZh3eX1y+xSoP5cgFTH7l208xJINZfRVSTQPQWMLD1TthqpzVL1V7mF5O/PA7hc2t/xv9e3gXr5o4EAP5sqS1SeCoZqlVC14/sswQXnyVp76cEvRw/E33OTwqTy2dBqi8myQT6h7xbtDt1jZXMwxQs6OhDfTNVmELIhrVuU4/QbKMXb5DT4TZI50m7CWPx74quVUEgFsYdL+MO0JuKK0oAJ8dM36+w0unRGilPzsNCfsrByMJ6zkwbjJHYwwRKlz02r0fdEiEez9XyKd2ScH+hXdu2Dd6nWZIZya2lsA7IIfNbLbdZid4F0Gw67gfwHFxye14/u0qCkuxjQ9vzc4bVzqk5Vqga6NVfsEKMsacv4DBJC+Ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(82310400011)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(70586007)(54906003)(6916009)(70206006)(316002)(478600001)(82740400003)(81166007)(356005)(15650500001)(2906002)(41300700001)(8936002)(4326008)(8676002)(83380400001)(5660300002)(36860700001)(336012)(47076005)(6666004)(7696005)(1076003)(26005)(44832011)(16526019)(426003)(2616005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:31:04.6288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a59795-bf75-4616-40d2-08db9ea01894
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645
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
Cc: alexander.deucher@amd.com, Alex Hung <alex.hung@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHY]
wb_enabled field is set to false before it is used, and the following
code will never be executed.

[HOW]
Setting wb_enable to false after all removal work is completed.

Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 0157d9e55ca0..5b89df8fccca 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -558,18 +558,13 @@ bool dc_stream_remove_writeback(struct dc *dc,
 		return false;
 	}
 
-//	stream->writeback_info[dwb_pipe_inst].wb_enabled = false;
-	for (i = 0; i < stream->num_wb_info; i++) {
-		/*dynamic update*/
-		if (stream->writeback_info[i].wb_enabled &&
-			stream->writeback_info[i].dwb_pipe_inst == dwb_pipe_inst) {
-			stream->writeback_info[i].wb_enabled = false;
-		}
-	}
-
 	/* remove writeback info for disabled writeback pipes from stream */
 	for (i = 0, j = 0; i < stream->num_wb_info; i++) {
 		if (stream->writeback_info[i].wb_enabled) {
+
+			if (stream->writeback_info[i].dwb_pipe_inst == dwb_pipe_inst)
+				stream->writeback_info[i].wb_enabled = false;
+
 			if (j < i)
 				/* trim the array */
 				memcpy(&stream->writeback_info[j], &stream->writeback_info[i],
-- 
2.41.0

