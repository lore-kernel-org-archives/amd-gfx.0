Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5FFCD4F24
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 19:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD6A10EC06;
	Tue, 12 May 2026 19:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xRhDZcOk";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE7B610EC06
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 19:28:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQKOwx/ygzBIyg5fHgDvgYdTwz/dyu4vBz20WZJtXB/45/QZ5g7FEFatK4efQeiPt5j8EVxjizpAZgFB9Wlt4vbe8xKqHTw52hYBnSD1OSpyDbhuZXV0iMCdB3RYf/iK84IYvkCMrUtizef2HKzwpb3AXgztYjBxl8w0yDdW3LccJ3zOZzTywDmtzCKn/4krBB3K269rt0gGMyKUx6FWTyGJPkNHwiuORLGfBaDYPu62I+Hx1DdK9TxoflSsvkjylNqVITOW1ScWd01/biSqG23XS5SWfJwTuW5Xe0eHGc1vfo8EBlIclJsgWe7Sa4GLfBt5hBXftsrPuQ0N1VyJEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoMRwmrhDKjFDZsTqgvXzXsNUD61+82I+WsyeXg6hHU=;
 b=awdT9qGhnQYVgZHg5vs09rTIkG66cVS13lRHFMY1ZAReSFxqZTvsB8rTkgjPsreSPW3osUysjnDZWUt7lkoOvCkhxCGMZSPkHnqd44ld5jHNMM/zn8UPQf+OJdqajixUQRLMoGUdN6GBfGkg8UtGHTtJbvrFC/qhAQMZdPiXaD0/nbNZEgPVw1QmSgFywJ7b/DFCGy/IUNFGzGH7CncMFOqF3MvGGMWz8DXc7/QQjMu2IJRdR8yyOVJhgqnjcf9ncx39uOdaJlKMMlCwEn9kQY5QcsQPvStzuuxaWWH/d3ysdDHZcfFy0ZOcmyfVfNAS8VkGpfL+S37xDsfr5GkXag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoMRwmrhDKjFDZsTqgvXzXsNUD61+82I+WsyeXg6hHU=;
 b=xRhDZcOk6K1x20IVHez0WmxO0UJDYlJ76t9zMxrLkHVFw+PRtmVDjemAX4/ZFX42bmCgSgk+XWtTanOJDuJhGOybizifsL4umlzQOPFTZuvq1jh69+l2YkoWME/0V1n+yfsHwiXhmo7Vo8wkY0qd4Zbq+aDqVSC9rGqU8cBij10=
Received: from BYAPR06CA0014.namprd06.prod.outlook.com (2603:10b6:a03:d4::27)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 19:28:48 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::cf) by BYAPR06CA0014.outlook.office365.com
 (2603:10b6:a03:d4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 19:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 19:28:46 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 14:28:45 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Check bounds for allocate_sdma_queue
 restore_sdma_id
Date: Tue, 12 May 2026 15:28:24 -0400
Message-ID: <20260512192824.3682569-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512192824.3682569-1-David.Francis@amd.com>
References: <20260512192824.3682569-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: af24a4c7-7cbe-4593-1b3b-08deb05cafaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: bM7Juczab8mIzZ2tIE+8tSxG5bFJ5L0UzeuNWhMZjXitoPCk2IsztHs2baId6zrf0ytJUlIogX6kBzSB/u9MCXAVAZLqdYt+/zMhbwloDuXm5QnRMtcks9MyE1zadZxWgNX91F7a2z6P0UcDcxTqu4x+JUKpDPrQj0sfAw3MA0e6nLSqBQwclv9mb3aPzRobUzsuCUjAenaQiz4ThfRXtRwgN3gDnECFUP5IHOnnDOBLd7RYJ/jL2dn9bSKF0202//M9QC5gkKfkSfGSXOla+h2LW5FSPTTReZoSPF60zwIyk0rP9JtOgIkzb2xqfAWlMKO4IuftH8wp67vqK3orwKHDejyKnMm1lINVroeqwhRscVuJBYhmne/Ttv9uPG7dsHeH+selYaXaH3NOo2z+QBxz9sDZ3F2cumcY4pfsGJs0K3AeqSIwQsMuQqlVq5sq5JRxD9xsNZgvb9kkeH0AV2JTbonf2juZYeypOhN4TiqTJqZMpsdV4X81a8d7OjMKNZXVdPOGlk4X4wum3Ux/YZY0t34IJM0CRcN5/VUIra+/ZRQy1Qxk1Rxh+89onoCfchRSq9sSCR3h9sCzibVXFclsgU2Ips/r4mLIDG+76qlnrqsOvbJQy5gxN7QM2hAoIb35C0n3VyVJGD/tUFxxU6irmucz+B+ahHHNaYRiCJGY9U5xzpiYu2ZnMfuW+OT7NQDQN7AmHp5Z997q+2c1PvwDRO6FofISJ8rIWdrL3mY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vuv1WO2MRrYsbMCppuQtcizBGpkEufOMEX3Hd/XPxw4u72FVEaQGKpxJLdstuFxW0oOH5vOsVpblzGdl0FqjdJ5hJlWgB5CujpQZUvGJdGMKv464L2HzwajATQm61YyseeYjeDUmIS5IhNWfNXOBhLJDyOjG2T1jn3Kletgtw222/+iGB8mzEXEY0Glv7lios7viH1e4+LK/+yh40sEHHMcywzsetSSGYAK+4TDuBckbAfmkhT4HD2VUwQckPj2eIpwV+BP0I9mBTitGXOJTurIio2OQFXgx8pmSUnSF7h7HIM9neBUSn/EVKTJzdB7ojNcUUGK4TBSglAVB1Z0IHYr6+tw/SfmAi7bV2pk6VsmqwR09uCVEz0QT0RhIdN5C4e4HU8KVA5Du3VdDLJ7OLoOaeLoGRAWfepxOZJkPhkV7UP90XWmRn4IQTsEYX2wL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 19:28:46.2951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af24a4c7-7cbe-4593-1b3b-08deb05cafaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
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

allocate_sdma_queue has an option where the sdma queue id can be
specified (used by CRIU). We weren't bounds-checking that
value.

Confirm it's less than the maximum number of queues.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b4cc74138f1e..ddbc4bd8ab10 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1727,6 +1727,9 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 		}
 
 		if (restore_sdma_id) {
+			if (restore_sdma_id >= get_num_sdma_queues(dqm))
+				return -EINVAL;
+
 			/* Re-use existing sdma_id */
 			if (!test_bit(*restore_sdma_id, dqm->sdma_bitmap)) {
 				dev_err(dev, "SDMA queue already in use\n");
@@ -1753,6 +1756,9 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 			return -ENOMEM;
 		}
 		if (restore_sdma_id) {
+			if (restore_sdma_id >= get_num_xgmi_sdma_queues(dqm))
+				return -EINVAL;
+
 			/* Re-use existing sdma_id */
 			if (!test_bit(*restore_sdma_id, dqm->xgmi_sdma_bitmap)) {
 				dev_err(dev, "SDMA queue already in use\n");
-- 
2.34.1

