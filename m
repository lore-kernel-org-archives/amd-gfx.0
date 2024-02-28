Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389D6C5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB3A410E5B4;
	Wed, 28 Feb 2024 18:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JSLNax0/";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8856910E5B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TycmK222O3cHxO2ql+kdpAhwxOMHR4Gm3bRQXbql6FDaogwCY0bI53oYmw6wBe1m92VnSDSLU6XuisNLdMoP+yDSWLLhMrd3HnqZHyppeXc6Gt0AWEYunQGcm5I6MbqiELICGxS6CLSmrKqq8Rq5P25czeARGWd8nZEucNw0BruMyVcp2NWTs4fcLKYI/g7TL6MUgYWkVbN4Ix3XLcbY2gz8V0Tcg3udtZgaOeFbIDOYacNmBrJoT9Fo24NHkrkzXpduJhcqEvq+3Z7MxVd8h1PkVve9lndsGxR8g4swyX0OlvUHLPwgm2dbLVQlh5XTJnwt8SZUWXUXomi2TO69tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OcQGSMgEAIupB/6NxojJJaRHkVwIWQ65U+xxI60uUU=;
 b=TH2ZbOZ6hZ+amapYCuCbuVnmKuNGxYL77hJ9kbYqw8yTCyTSJOj3REO7KJVRxK/5yU2lpbl193LSHosZkxnpUAlKJGMND3fURmzdKoEDYqCdn9Q5RtooFbuNoImoWxpcH8U2x8aTNr0Vl5Zm6hvzImqSQzBex5oyzJX7nn5C+WLT7QYdU6TCnW6U39m48kmHGjYK9Ot7b/KbfWl0wkoTyLPux5ssF4IqaBn3ovBSl0szoeebByzqAoG15OBNWkJlQ1zVHUMkefbnfznxHgH998qFCKMTldg0+6iJMMXv56NqjoIQoYIKNdNRRAAdK1pfrMOhnrFEN62Db4S9dBcXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OcQGSMgEAIupB/6NxojJJaRHkVwIWQ65U+xxI60uUU=;
 b=JSLNax0/SVrkfEWu3p6SJGMbw0HmdYR1fMnBlDKozR/KzZ4UZflbSWz2kII7uviGbdx8oHq+l6hsGRNWZcWBiq3LFIFJ/8do+UD9m3asOb/abn6CYlWQ7aMAa5CS8JBCi8iE6R3I6bfVIo6hBScLnXenltrL7J0i6vn5GMD0Al4=
Received: from DS7PR07CA0009.namprd07.prod.outlook.com (2603:10b6:5:3af::9) by
 SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.41; Wed, 28 Feb 2024 18:45:17 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::71) by DS7PR07CA0009.outlook.office365.com
 (2603:10b6:5:3af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Wed, 28 Feb 2024 18:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:45:17 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:45:15 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Duncan Ma <duncan.ma@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 20/34] drm/amd/display: Guard cursor idle reallow by DC debug
 option
Date: Wed, 28 Feb 2024 11:39:26 -0700
Message-ID: <20240228183940.1883742-21-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0808aa-3310-4056-b759-08dc388d6885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfD59DwiSWMGwNsgfr9WnhBYU3yces51TJ7B7tC9mpEt5lzYC3HdtbgQHeHAgpe3h+DFcKRF9v/DCxmN8th1tXu8vgK6VC+LUFo5wjqWqEP/IHBw7MPiCvR1mkFMSWH/hu3LIf0J8/9TcrjCVJq/JkFvhaa6QzuxXp8F812/DxhD50uKrnYrLH4/sgfBxZgnE4JYfnaIR0kAauPSXICsqh3Ood+Dllfu5mv7zA6ywd8TDwxauDENws7WeKlR1uKrwU81MxDCx43PcHJOeYGwObmI0NOVGv1Oz3tBjCkSqYK6TKEEsfN7auS5+EHhE+aA3Ra6JFtlxe+QmD9SLcF5IG57gJ2TtE7PhuXFJ4p89ITmSW6XqRb0IHpQZUkA+Dl2zjJyBlcSdA123mgwqH44iTX0mCI2iIdJ1lRz5J1leX1sKRA+kNaHQotgIfHrCk5yPxRquLIkiPgrNeWmR7jwozLpuHtvPb0G+QMVpBbN+8V7G5L9xC2L2T6HgWfRxUGEHjXePMHN1BvTUt+3f1hZ6AS82bD7j2fPrFzQbKYsnFQk6nHfVmuzeNscPdGYYM2JS5DWVe8CT6iMSIRQGHBxTWfvnirQUiEq27QkxXjjogq2z2QHU5Pj1k/KJ7wR3o7xBZ0N8SaMw9WNWwjGdQQYQM1JuFve003o0yibSXSDwEM3reYd72lWN4JB6ePbc7/+E4hRX2P+bFsEfom1fbDpHo1QMMMCIViJMIGEBkqpgoxgekja7lYsc+pnwS7in01v
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:45:17.3811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0808aa-3310-4056-b759-08dc388d6885
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[WHY]
To control whether idle optimizations reallowed after the first cursor
update.

[HOW]
Add checks to the conditions.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 51a970fcb5d0..212e057ed9b0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -319,7 +319,7 @@ bool dc_stream_set_cursor_attributes(
 	program_cursor_attributes(dc, stream, attributes);
 
 	/* re-enable idle optimizations if necessary */
-	if (reset_idle_optimizations)
+	if (reset_idle_optimizations && !dc->debug.disable_dmub_reallow_idle)
 		dc_allow_idle_optimizations(dc, true);
 
 	return true;
@@ -394,7 +394,7 @@ bool dc_stream_set_cursor_position(
 
 	program_cursor_position(dc, stream, position);
 	/* re-enable idle optimizations if necessary */
-	if (reset_idle_optimizations)
+	if (reset_idle_optimizations && !dc->debug.disable_dmub_reallow_idle)
 		dc_allow_idle_optimizations(dc, true);
 
 	return true;
-- 
2.34.1

