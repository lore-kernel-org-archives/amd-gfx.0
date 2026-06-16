Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15185CD98E6
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 09:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F1A310E739;
	Tue, 16 Jun 2026 09:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZIlxz3Tq";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012012.outbound.protection.outlook.com
 [40.107.200.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 629D510E739
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:39:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZpqAgOq09N2aNCj5thJEpj0ViZA2fnm9aoc01+awLgBkKPd4aTz9ZWC5eFzYUKEiHqo3pRhEBdudagZ1Hluc51XlOLi8gjWGKfkTXQ0+P89tuKjeW5j55pighzei4Pqns0tm1RamNodOnwqv/NNSoAwr3h9VKdA2Qshfbr1b7rpS+3gZmOFs5OuUzmWeCXoMsa+ovuFTbSMx2OaF0CfniumNu7eksdcF3aBWGMWsZFAMm/8NB5BNl5JwgqoBgg9Yv7VMAB2Vr4x5YGDQ6k1cPDj0G7+WKUENDP3pAH1kkWpk3sdVrkB/RrEdjzxBlL7SROeQdx72EWxmhJ6AA6q6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5aQls3sbla6EQdkXrBZeGbkUx97DJLyUTvGLkbZIKY=;
 b=kBGZBhmllGgLZzykbbuBLVWE/3ZXrJXfqUZAljn0B4W+edzhMT+GBZiFKUJ4/Hb+p8lYAq7n0DP6rpbOXjvSO8mSOt8dyvoMGKWVOs0Y2j3WuB+SmzEtW9LiHUCbZ+73Lwxn6pMSFw7e8CW8dVvgeixPm5w12GOwgderMRTppJ/8UkEuF6Nsp/IotY99Jnzo1jGbUHN9MBNa5oNBhpdVk8HZsKZ1j6QRHZAHsB39sfYLLrXorILqNW4VGaA/ojnbdY+yFAnHzuauMsgphWKwX9NIPD7d4FQOkaLaaLO//pJ/utG5czWZttodvCy2c4nmOYsIaYy8fXt59Q7gc7kDzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5aQls3sbla6EQdkXrBZeGbkUx97DJLyUTvGLkbZIKY=;
 b=ZIlxz3Tq8Ljh8xWG7ytu3qSEgWMfbEiJHyyTw/bacZy0o26CYrpBrd1D+NBs7zhvlBIMiEA4Q53EAxbI33Sl4GPBxNf9o3Dz41LaRQkTuMLqjTtmZi6yUq5n9bDnMvLiLDA2uIJpcd4Krjuu4ToVn+HXPlteXg/I8uU0GGcftTY=
Received: from DM6PR07CA0076.namprd07.prod.outlook.com (2603:10b6:5:337::9) by
 PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 09:39:15 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::42) by DM6PR07CA0076.outlook.office365.com
 (2603:10b6:5:337::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 09:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 09:39:14 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 04:39:12 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH V2 2/2] drm/amd/ras: use IS_ERR() to check thread creation
 result
Date: Tue, 16 Jun 2026 17:37:53 +0800
Message-ID: <20260616093753.4142104-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616093753.4142104-1-YiPeng.Chai@amd.com>
References: <20260616093753.4142104-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: e651a30e-4ae9-4548-27ea-08decb8b211d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: SXTFVKYMtp/UBST9if3H3qbf1VhbtKrHigwWQCwvtGaqwmw10LE7aFrFQfTve1nmE5tCKn1XFJLbcAhApQRqHqqV3a6T6q7JDKeqyEcB+rP2LeKK++6SJ2MNRLHKZdKlt4Ad6lMcwZgrf3R6FY0/k/+Zs2hBlZ5QawE8rVHb9LSveETyr3egQOYit61i7kUPezimAerRPhjAzJrSDpe4S5knH6/XqiXoQAWAwaBHZeF3PsyUCwcC4/rtJx5AR9G8DUZm9qCBazQOptZuW9OP0y5TLj0egHfsTXEOE6084LBmwLJFjwS7NTYARkW3G2ce+fbl7tfSpYWcHE388XJhtS/SN2GUH6BIV1cwx9OnfwCoZwncyHj3AVtPhJvNqIz2HPWTcKJZ5kQqKVuVIwA6uAj7OMAT5w9B/VuYCiA/84vrjJmQMqY8HYYJZ6rd5OmV8TdJrf1MmwPSHK7towckTLENBPjWa9Dy4b9ec+nwfaaCfjQgQmqxtmK6zk8XEzIbGrIL7GH+Ih92YpTnIZm2ROpwCmi5tBUHjyNhKAAB0vBtGCDhWaiihUwv1esiOJzM19RwWYlZoPBMiEbbJ8XVCOoReCI42MqqExm0NtxrJMDF2dNTV4aaWujRZ0BDLbTE2jyTuYj49SsujK9IbGXX+L9TCCD67CcJkZCp1mQEM/V+O4OfvXNBJG71EPzyOak7C3AQoaUw2Q7PEXZaXpL2+GAjWCm9vq5wQ4wD+nQe3s8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d7jw5VDzwb/eC8HiOXKHIuxG7Mm5bkc909yld1Ms2yuF4QkOOXSqvmkGNMtCiAIisI9mAHOfdSbBKsB9NgolwfNqYa6qlNEyCG/NQVFro3PmecKZSYLZH430DuK9hxJvrAS1UhmA71kFsB8vbPsFisjunyx7b2HnMv8TZuM998a0rebmrLxFEL4gCjcn90KjXc5YZH90hT1syCA/NrGb6CiNkmz4WS8CapjMmIbW1jCbc/8dNLZI4S/qbG9WmUDEl65cO8oaPBqmUYZe5CfhQuqpWDHJ5lewaPBQLWhkJFCBa41MMslyXwW2OeB3kD1qZE+nSD7XfYgziUQdkRRHUO61FdQiASzlwSYsdwK2uwfFgLcfiz9E7i2VbnQvmmYRShRZvrbGRPlH5T+VLBaHYCCnNA+9jorg7Fb2oBTjcbFBoBHltTdpy/+50JCpKTrn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:39:14.9178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e651a30e-4ae9-4548-27ea-08decb8b211d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808
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

Use IS_ERR() to check thread creation result.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_process.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_process.c b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
index 3267dcdb169c..c001074c8c56 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_process.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
@@ -248,9 +248,10 @@ int ras_process_init(struct ras_core_context *ras_core)
 
 	ras_proc->ras_process_thread = kthread_run(ras_process_thread,
 							(void *)ras_core, "ras_process_thread");
-	if (!ras_proc->ras_process_thread) {
+	if (IS_ERR(ras_proc->ras_process_thread)) {
 		RAS_DEV_ERR(ras_core->dev, "Failed to create ras_process_thread.\n");
-		ret =  -ENOMEM;
+		ret = PTR_ERR(ras_proc->ras_process_thread);
+		ras_proc->ras_process_thread = NULL;
 		goto err;
 	}
 
-- 
2.43.0

