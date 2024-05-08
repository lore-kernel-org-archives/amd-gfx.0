Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDA4C19F4F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13305113119;
	Wed,  8 May 2024 17:16:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ot2X8Hce";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31525113117
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:16:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyXpHGbDfg/8ZsfP49zNiStOmnA7jrOPNH2vh7NFZIMypC4nMrFw0b+0W85o5cLf0oYBkwVbaaKFXP9J+pgCrbYSC2CPq0Hh8mGlQwJIfEgoyVy95EAowVdUNwfMdXEg/UJOw/qP9XfU0pFRakISqhlNANxSgtPQPnpfW0RSD9P1JWB1X6dM0qnL6Uo/XJJ/ZK7XV6dxShXwAtfIOsIW4kEn+wp++tGH0AScYlEVMV3HWrxZL9fUTxjLOez72wm+SDKOvWmcOdttrJIF12Ycde81Moy26XqJIhtDQuoi6vHcgkz1BAj6ZN9ClZyzsQMRSLjHv29RrKwUAMl//vX/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5INFqJF4ykRALXDQgXqqwC9+8XtIjxPovdkfemUZJk=;
 b=icqZ7EN7dVSNoPCaGlm239VVpYbfYQ+UdAOfidOPtV5YWCEEI1p58qMWvhs/zXGIbTEoIp2kbf8Ts1eBBufMJw8EsJ60vyW0o9oEsOfBqsea9N430KNmmJDiH0ljXE4sDTMmjmrGDMIIeVGoaKgBHeAbuqVz26Sw5WN5pKuff9ad1/oLO2yfkkJ9Iha963zHtvmMzxcy4SraQP7fO+bJwaXWYiy7XO9YO766UjOBEQGHaIaLZG8aZRdIoYgEEnIcfpTCXggHVLMDemI1TeLhiwh6DJlG52luBiqNjivalqAir/so7xJfHIviv2eC/UZuQv14IslA6xF4O4Gk8kx+6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5INFqJF4ykRALXDQgXqqwC9+8XtIjxPovdkfemUZJk=;
 b=Ot2X8HceR+1xolgoiYZcOLfsCgZRGaNONVlJLYFex8NGrMMyURNw4aKe1dy2iQK5mrjXlgxHj7ITB2H0iHvsW96DDm/6t6f4Pzn/Q4X3J87+2Pnvl46JFkUX2UdOR8uSbqmaTD6q80Nl4W2p0aED7uwS8Br2/kwQ7IB9I0evaxs=
Received: from MN2PR02CA0006.namprd02.prod.outlook.com (2603:10b6:208:fc::19)
 by BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 8 May
 2024 17:15:54 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::d) by MN2PR02CA0006.outlook.office365.com
 (2603:10b6:208:fc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 17:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 17:15:54 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:15:52 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 04/20] drm/amd/display: Remove USBC check for DCN32
Date: Wed, 8 May 2024 11:13:04 -0600
Message-ID: <20240508171320.3292065-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508171320.3292065-1-alex.hung@amd.com>
References: <20240508171320.3292065-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: dc851d16-f60c-476c-3054-08dc6f8284bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jwZlhxLQGntKvzgdC0qjcgybM5BHwUxTDM7IDo/dCspxMq4/SPk5Jqvfqs23?=
 =?us-ascii?Q?/qU9wJZc9mOVIKc4wK1tTdJ7W6lsBVZLGzqn8BkHtFFLqcagZtVa/MViCzLP?=
 =?us-ascii?Q?1QI/q0yP1D20oF6qjfostuLB/FuMWOSmeC8ErxJqAUtJv9Kch42ZOIQaWOn2?=
 =?us-ascii?Q?/w7gzyUAWb0PXlNlNJoj8qRrBtbourmqk1euR6G+oi25vAeYhK2bqMsM1BaN?=
 =?us-ascii?Q?0luacO/W+Ws7TCcV595BuJLcUSKJGegLc4Y1Cp8IH0IvewVpyW2Sv/2RBObS?=
 =?us-ascii?Q?J0aPZpLBZR5zIwwWqcDmlMJuAG8LjMJMJZiXsZDfHOaRKbb4XVxg5j7Lu+ab?=
 =?us-ascii?Q?arMdHgTlkkGfcIITUOiUgc4wKI07cFp+oncDzv0t7n3NFSj1IdWGBqE2tv5K?=
 =?us-ascii?Q?02hMWiq5YWohQJ0FDaH8j3PN6l+nM/1S919cQpDRJG+V+yzmhrC1SEb2E09t?=
 =?us-ascii?Q?WbJMKKkRyNarKCxHLzCBpgwMUkD6th/l1AdO9P0v8kszZzCkr9YIYjOOhT+A?=
 =?us-ascii?Q?+RauA3P848k7uQYt6FPjkf37nXcvujhWqqcKU3di5UF0nmgALcH49p0V7j3o?=
 =?us-ascii?Q?j2p+pcE5/TckGhyyrt9vTPR38mgDRAmhghDWhQbe8kVHAQh6YRrHlCYMuV/k?=
 =?us-ascii?Q?HjrdYY3jLVKRsZYhVxEfmC2z3BcRcr1SFxC9cRYPdqtbPva7dmkE4N76LZLN?=
 =?us-ascii?Q?3mjEJYlsIgGy1KKfj38R5ZYP5vEcAc8T8syBYiAfMTBX17qyBrXroRZH0bkW?=
 =?us-ascii?Q?lbmOYQ/yIwDnBYCGMjn+dpXX3wtSVKW6cIzpaMyxySbXmRyrBXy0l9hb0lpU?=
 =?us-ascii?Q?V1hWm8S+LxbpqUMs6IVCxaGQRxGDVu8RX6wkVYb2L+220qCjIf4RT7EGgMs7?=
 =?us-ascii?Q?MQrBRqXANo2zHBHM/U0JcIeeT2GD1AlE+Knb+ddmxv25AIFgUoz8Gh0RstP4?=
 =?us-ascii?Q?Q9S2xholsGjIN8CJnyuwBlaJMAp+56lmEGdx8vqUqsbw0qFLuQEcx7iYGwcu?=
 =?us-ascii?Q?5FGWpgWYpzbIMpsJMTn8eNJx69pcZ1sMjQFZoSapb42Kr98v+G0dMs3+9dgX?=
 =?us-ascii?Q?7bqaxhwmuEVRnBYpoHEjOSWKnkzolR/APV5aoeUgUHCk2jfQuHuq1ymOVpi5?=
 =?us-ascii?Q?A4j/7FYa9phGWmrAIQn12KFyZZ3oOh67XwUyV0jdNVK1nYAsQNlQ+a7uaGk9?=
 =?us-ascii?Q?IH63u+fqs5d6CXOzoZ7stjriO/m5MT2WlwO0dzdhV+AWOefzmZWP79Xr/8l2?=
 =?us-ascii?Q?8GDeLkV161RDMUuwpR71pTwFghTidYozRp7BSC8/Z9354DRsaMLDhFYEDaT9?=
 =?us-ascii?Q?xBDsc+WQQ8SbTn7YPGqAE+W7uQhmUzWfaU+lIBvpS0JGhSZoZLgQZ+jJmxnU?=
 =?us-ascii?Q?o19fcEGgE7yrnquV2z5T9Fd1tlxf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:15:54.2590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc851d16-f60c-476c-3054-08dc6f8284bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

The CONNECTOR_ID_USBC check was removed to fix a regression, but it was
re-introduced by accident. This commit drops the USBC that causes the
regressions.

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
index d9ff95cd2dbd..06907e8a4eda 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
@@ -252,9 +252,6 @@ void dcn32_link_encoder_construct(
 
 	enc10->base.features = *enc_features;
 
-	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
-		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
-
 	enc10->base.transmitter = init_data->transmitter;
 
 	/* set the flag to indicate whether driver poll the I2C data pin
-- 
2.34.1

