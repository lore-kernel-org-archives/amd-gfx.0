Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1079BEA3F2A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 09:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABA8E10E528;
	Tue, 10 Feb 2026 09:52:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JYEZK5Ee";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A0D10E528
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 09:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPLAObkwvYQZ5YwZ6GPCkefBdfeCJdSullZQvoXpWzjtSpWdYVOP/6yYcdkjTbYJ2T+Ezjnj4f9XYRZyGtSYbIvhoxC2uqUKDxb50sNNyHd1ofTPZYvyt/tMR+w1xQ4hh5EywwNbxeEU1/+Sgq+AdHzE4BRs7NKm+6ctnRW7APoBznJXxrfaqP3WF/hQT7xm8le29RjIojL5MkFSkJLXo6yEnCmNkq3h7QUbnu9Wmz5hWYGNfPmkfZ+9hNrF+hBjBsjdKxcOfAMQACEMi25Mzr/6/bcF8WbCsD+Ex0AFBFgwo2IYoNM0qBBAfy8T/VadfGAUPwo4xs7qNxYqAG5+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nrUSBckgmK+uUs5Cxn1fzllY5vIk/oGMqJWjJ2Qv3s=;
 b=nd40jK6a/J2W8qF1bzuK5Phxd1zPnW4cxEyR0L8uuxJbUdg2dTRBXiivPueSyLuAWFeSRkfDyMX1XYqeyWlJMXOzq5QDRXGRZFkiyZ4V4loHFGWF7QDZd4i8IajyvPI3pmKt6gAmEHFu4pOy0IfRDd6tt6DL/gqT3QQrla7Dh3ZuXo52hbGM+svVFJKy5KwZcNDXg4IiUGH+6oV457h8doYVeBvwrlO7BBPzoutxivTWE7+SHHHviaBkoZmQ1DmVJgSgQGq1mG6aQuGXDs7EMOJOD88S3gsFK1kgjI73Vk4XYbFgkQ2mErlbADYiFu8zgQM/zlITcTexxXOlPOAH9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nrUSBckgmK+uUs5Cxn1fzllY5vIk/oGMqJWjJ2Qv3s=;
 b=JYEZK5EeFLdCFDOKZOO7G/Jb7KNxnMRArfbE2hiSwsnuR4ksAHnWoDjkweoU+iQxPmcs0Qq4yRtWtmRL4TAwT2Co+k7UTAVs9q6xzb7RvXrePGa1i/RjbTLU8YDncDafII0jcm6OgjK1NxCGoJrbEgHBSASof9URkkHoBZ6YziU=
Received: from BN0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:408:e6::14)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8; Tue, 10 Feb 2026 09:52:50 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:e6:cafe::cd) by BN0PR03CA0009.outlook.office365.com
 (2603:10b6:408:e6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Tue,
 10 Feb 2026 09:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 09:52:50 +0000
Received: from jenkins-joe.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 03:52:48 -0600
From: Jinzhou Su <jinzhou.su@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <stanley.yang@amd.com>, <yipeng.chai@amd.com>,
 <tao.zhou1@amd.com>, Jinzhou Su <jinzhou.su@amd.com>
Subject: [PATCH 1/5] drm/amd/ras: Add address check structure
Date: Tue, 10 Feb 2026 17:52:29 +0800
Message-ID: <20260210095233.3078476-1-jinzhou.su@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: f451fae1-0170-4acf-3947-08de688a26ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FxbpdQF2MdlyvcyDosVcppR9lJaP1PF+m8j2p60GlskYgcI2i7ydzmdKCNKD?=
 =?us-ascii?Q?V5wYZ5oiqHka1WlDOsshufi/arn4xM6t+7FjFz0N6rWXXq1hPbJAnaq6tig/?=
 =?us-ascii?Q?Ttiex0dTYKuQXEAhvBkKtMiHT2qAzPDCAv7V+h5/cuZiG5QVkdnGoc3ohTmG?=
 =?us-ascii?Q?ODMOq8t2G8NKL0bkLdIWyq1/bCV03MtmaiaUn0GMSaZixDZ0jn2kGcWy0AJq?=
 =?us-ascii?Q?J8BWkzpunS+rGLFx1Suv63Ai8OLTwf88xyRWmy5PcMrMdrsDDn8M6F1pCDkn?=
 =?us-ascii?Q?2EijvVelMWcBNaW/xOquhLMdEWe3wcuRHUiy0BC4leyVYkB0OSe6G3hRQeLm?=
 =?us-ascii?Q?h5yKhAg9JWTEgx1GFvuu/bBZxpKkN1etpIBeGg7f1Qq5AD2gqWoheXG/04Rx?=
 =?us-ascii?Q?8A9JqmN5RVgXt/mIUDtJbvrZc40FFIMKplmBy4gGJBrm80SBelhpKmEq4hr2?=
 =?us-ascii?Q?0weTATLHDFYPjD4xhxn/CcX2CBeVRljA6tZ38Hx0S+ZjqdgPBX5+PQgwyOTH?=
 =?us-ascii?Q?srZ/lwBLGjtcflWO6l2KRIPcvFmBJhgnkjzs7BlIYZIRTHgk4plYFGKdYJp8?=
 =?us-ascii?Q?qQrU8kJvAoJk1hj02er+qgnRGAsY7TX7Nys1gM6+yYVKDtKqb9BTS9MotXjB?=
 =?us-ascii?Q?U4FDKqKGHUTJrZygiruVtnQFWAa8IEGIUO6YcGpcVEBWTgSHgux7WKxQQpYj?=
 =?us-ascii?Q?M5k1+mA9vO3nCaFjeGU3Q6cjpBGbQ4To3wgNS+hPAkiHcBvBlGnikjlgXKcr?=
 =?us-ascii?Q?PjEBuDNE9IOyJp+6ePL5gYmX/PwlN9RqukHFnYmoB2u5ni4zrdyjVn643WDX?=
 =?us-ascii?Q?qup/EtmMYIthdYVYVJbkqBqklbTBxUWQAMctA31BZ/n0iAx+MSKyuUGmvSEw?=
 =?us-ascii?Q?P9rba83IbCxikTjLafH9t17HcKzlU52q9pYj+ErQFhvN2CpTbg+qcwi3524M?=
 =?us-ascii?Q?eSCpPMpwW26Xec4sba6W/4wO4JUZW/LqI6a5qjl0pwae3sYork3+3qhFffsJ?=
 =?us-ascii?Q?T2VjQjTW/SxJJnPq5tzquawyUV66ire3YK7rgNAK2lLXA8aHMtXDqTWq7qSp?=
 =?us-ascii?Q?Li3j1BXUyubCuQJH6rNtvMXx9ZxC9qyqmwwhBmgPPou/6nMV9SD2Qhv+ytQK?=
 =?us-ascii?Q?SyH1C9N9DudNa6sbYq6SW9bfrdBE2b64nVJ4yFaGlhHVBXBIZxjPbDhuKajh?=
 =?us-ascii?Q?SgAN2fLAl8LceYofkw+F2iBLq3lGrJuBxwGj8PIdiQmENboxc3PdFiJIRW70?=
 =?us-ascii?Q?dRR5ASAzC1SRjjslolWxuYQ7qPb8XMky3kkAAZMDCsy4JlRIi7TdbLfkNqFs?=
 =?us-ascii?Q?uqkSgnApwkZ6MeW1Z9I9NtFG9BN5iDXBTzzPaYO9qxKbjtSw/hJOVc0M93PN?=
 =?us-ascii?Q?+WgkFmBqpj4VvJtb+1m/+QeOAuEToFcTw26Z/AKQ9G7wClUtCvuzbVVmynHO?=
 =?us-ascii?Q?CFFEtafljMu4BU4OBZz70raIgdhw6ffWW4QumsWckKuJy14jsTl2INJ/PHJm?=
 =?us-ascii?Q?qdOum6f+90POsThYwDdst+xgqCCtnPa7ICSZBFReGvCp9NVlVFsF0dppKY8q?=
 =?us-ascii?Q?02qAAFQy2CaefK7YI3g06U7HD9Q/nqtoj+U66lQ0rYkrazRo2v5sZK9HuO46?=
 =?us-ascii?Q?tkhWZ3XW/N2M7JACIRzoCr0ruiZejH68//pLyoCrGxS6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EBrVv6Rw3Iw5IhDGiNi9nqOq58tHRQttAEWsZGOKsx7Tk/dIwJBqIa/WAiI2YvSsLYnE1dzisLYnBelfuUQd8g4hO49/l70P9J8I5+lZ1NKuPo30w7qpy1uj4SRnNSf1eqUtUPpluSCIEy1jhm3KsXoWV90g24NUo/zcCgVjscy0zK09T0r/HdQGwmh3OllEjeSuVItpUz7pVXnv+b9jKkk4JvGJ6bzeeayBMXiUuMAsONcvpZF1sdhTvcjbdMzTKsuArbyyd88TziXr8OLynSqf+Xiei6RX0q0HjmFsIeLCCqzfQ8hw3D/AnZtEPwKaomjK0+Z380t33uZIvomquZkSmssb24TuftUwwnYx4vQzaaX585qvUbbY7972DHlylWUQPL9koVeR384wBNdZk5bJBT0++DAjhLmvVoSQSTxcHo+pq6qv9jNpqIU27NrN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 09:52:50.0527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f451fae1-0170-4acf-3947-08de688a26ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327
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

Add address check command and data structure
for uniras.

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
index b9833812c31f..32b48023fdbc 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
@@ -77,6 +77,7 @@ enum ras_cmd_id {
 	RAS_CMD__GET_BATCH_TRACE_RECORD,
 	RAS_CMD__GET_ALL_BLOCK_ECC_STATUS,
 	RAS_CMD__SET_CMD_AUTO_UPDATE,
+	RAS_CMD__CHECK_ADDRESS_VALIDITY,
 	RAS_CMD__SUPPORTED_MAX = RAS_CMD_ID_COMMON_END,
 };
 
@@ -427,6 +428,20 @@ struct ras_cmd_auto_update_rsp {
 	uint32_t reserved[4];
 };
 
+struct ras_cmd_address_check_req {
+	struct ras_cmd_dev_handle dev;
+	uint64_t address;
+	uint32_t flags;
+	uint32_t vf_idx;
+	uint32_t reserved[4];
+};
+
+struct ras_cmd_address_check_rsp {
+	uint32_t version;
+	uint32_t result;
+	uint32_t reserved[6];
+};
+
 struct ras_cmd_blocks_ecc_req {
 	struct ras_cmd_dev_handle dev;
 };
-- 
2.43.0

