Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7822CCD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 06:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D963B10E470;
	Tue, 26 May 2026 06:06:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PoUyloXJ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4763610E470
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 06:06:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwcDaI7LHy1TfIlAWyd6D07bFWyWKo3Xak+to0zHDRfJ50XmD6fS+c1syX8RJkclkFuqZwa6WfqtYLB2mjzQqrpjHN59c8FiReaI2uuy3e94akvu8m8Gr0qbxrn4SgQ3UmwxGPXANs5d6QuKazt9kDaO2PDWXu8sXE/ZS0T60qoZRTPhfg1GaqpmKrTiSHZ1os587hMyi5fXjog7n+62i/Gus/eaf585umjqG3QKO13L6z5qHmeGxlFwVGicPl+85/k0OCvPBfKFwBUeuygqk+Tsw1MqW9fuCSp8OmZyog31IEK1kUz/hxjFJ6Q0dBcdCMofOn9t2+xZ4io1lwqIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSVnJT2U75yjFQMRiVNQyJWgTz5pvt2L1709MWh/I9g=;
 b=immnFNfyi8+xALgb8JNv4csXLCvEfk1/GNz25SAG8oga918/nmRrwf879CuSOjns8JKr4VyJV0F8Y+ImhdH0rZphd47hq4FoVp6bcxPchGO9QD2A3EX9k4yLvVHRRGc+4LmNXtJfLUyrUG01kTKhixfcuaZZqdcV7W7QUyxlMCtmytG0VgoW+Tt4V+eQgvi3EYAeN1IbTQjrdi5ZNniK5elnBj0WUe1XTnsBluF7f2dwGOd5XciNI6Z0AFaWl4lW612+GSP9BLVEy/hhb9IqrSV1BUuOpbb6XITZlihWlqRgntvG+1Wm2nLAjMR8mHZivL0EllHYfXY/MxBc+nDyuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSVnJT2U75yjFQMRiVNQyJWgTz5pvt2L1709MWh/I9g=;
 b=PoUyloXJNv/nodRrjFjXkUzEtQrtwlqwZXywIZnlx1AU3NSAg6ZxU/jYkZ9lGxgakuyB9n7LLqhGisM6VPwq5XanpDuQeUa9T3Fgcw/EMNY/Qd5+vJbRE7o5UwXsJ30Vy19pdA1QTQXXYxmHzQP1vC2smW5aWSfSPvSigAkyaK0=
Received: from SJ0PR13CA0036.namprd13.prod.outlook.com (2603:10b6:a03:2c2::11)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 06:06:20 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::75) by SJ0PR13CA0036.outlook.office365.com
 (2603:10b6:a03:2c2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 06:06:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 06:06:20 +0000
Received: from stanley-test.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 01:06:17 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>,
 <Candice.Li@amd.com>, Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH 2/2] drm/amd/ras: Remove redundant error log
Date: Tue, 26 May 2026 14:06:02 +0800
Message-ID: <20260526060602.69082-2-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526060602.69082-1-Stanley.Yang@amd.com>
References: <20260526060602.69082-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 4240c2a7-5950-4884-1ce4-08debaece836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: VE1Ytal0Us+XNjA/ysAhbqNa7RKrGDRlJGltrWCqlc5Qtt2XkTQbj0LpRoKoxCkx6EhZs/GDmF5N04mubLAcSVuFNnRjFOlnXMqOAO4SL3FKcjlMUGdoGYDB70L9e+7iQDTMdWd9aS/Q95rFo9T3H8OFNws2gzPJQnqhku1URme7a26f4heRqcgDO67V/Os8VLhYkz72N0cYWsMttJXopOuo5tshgScAA0rHGU8nzdvw5/05P62RZPZW2X03PVA4WE/prrke4tHrw6qUQNCpq6re8nRR+43VUZ6puFRydkS/76BQ+DjaNnxayZ2VKcoAyfY8whIkFzfWU6/sL3ZM0528ZR7mnl7M38ba+dnRcksYcGF93MdKvCiukoCa79t5HFjMq99TW4pErT1nDTDarXyQSzWKljn61z5zACfQKE6N6hY/x5+Prg2OP3GK4TVYA02B41RXGoeritzqovs0bc7PKBL7B0xzw7IgxtxRZAyN6zwfkpcA3nt3XO73IK+r/M/6jLzjBeX3fp7nSnjiXZPzBYV1FLG3j41eJWTM7P+lHeXS2zB12tCaG0YvFzmA/CtoWi+RfXPUL1fh2TyMsuJUajK5L9gAsf7PlEi7HCgyg+tsdrXEMlYZgVonbZkmz4Te6T5RyhLc99ngQmoFnQESo/BEhxeAe39Ur8jyg8KS+CpVELT1hKkl0uA+W5hUmDwArAw4oeNfJx8J9hQFVunRcPXWr/R8FAoYzZEz44M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003)(22082099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EfGr4/oqGJQcRCJryv2v4oZ4PCqDzco2g7WmqBfol+SMWuaYDGK4p4ZEUpXzi/966PZoWALSR6+xTbvPScv9NZysoXenkuaqHJStwoKDko6bA9C93HtXf/QSqGBlLlY4HwZxYLKvTK5yAlKHMCxEKzcChHiFHCS1ILcL4xKfq9Yy9rhpgeTBVQBiGe70sR6+4wc9AhmuyZjc7u9WUGOIBX9LHiaXMq0xfcuTqm+k6Bl+Ic9kUx4expNac+vPxgP13WxjmoB6R/0AL2qq3lTSfIbwl0kO3JQToJSO+2qxmWjLsERnp5nexLOPQuTvmK9GHgaQkQIbPuFT1Q/fvvxv0YmwO6ZEx3RwI56VpmxUJG3tjQgmOiMO1p2ZwZCfuQr6f513y4Dbryru00H8oiEbd1oapmXEyT1Wwx6coPTqbxDapaAdRSYD9TQmSw8RxGJL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:06:20.3415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4240c2a7-5950-4884-1ce4-08debaece836
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
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

amdgpu_ras_inject_error() currently prints an extra "ras inject block %u
failed" message, remove the redundant log.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
index ff7f9af980d5..658bf3fdb66b 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
@@ -119,11 +119,6 @@ static int amdgpu_ras_inject_error(struct ras_core_context *ras_core,
 	amdgpu_ras_trigger_error_prepare(ras_core, req);
 	ret = rascore_handle_cmd(ras_core, cmd, data);
 	amdgpu_ras_trigger_error_end(ras_core, req);
-	if (ret) {
-		RAS_DEV_ERR(adev, "ras inject block %u failed %d\n", req->block_id, ret);
-		ret = RAS_CMD__ERROR_ACCESS_DENIED;
-	}
-
 
 	return ret;
 }
-- 
2.43.0

