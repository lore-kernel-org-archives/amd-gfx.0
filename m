Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBA6606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ppbIq4bj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26A3510F8D6;
	Wed, 11 Nov 2026 01:43:13 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013044.outbound.protection.outlook.com
 [40.93.196.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E4BA10F8D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjwTA30+ezEEp1oBEuFPP1q236FjrVPB9Gz3JxnCnhCT7otIHlPlW4ifZWnp4TCX5IreAocW7vyGEXvKkq/MJFsQKsu9uh86lxLgcEBNIkiI7NMEIL5DVgQPSDQNt9QITNviqtNXiz+1L2dpRG1nurVNhUXD0UQ3ShFltg0vE1xqapEZB3Z9PMyWjR0ielo9ey8Qk2CMPIv8oN9GaYDAOozJQP5jG1sRsNPUQ2SkFjipBMAxUwfRzfT5DQ1OYg3n4Wwu0uDUdI6ECe6ZO8b2zHPvhELE4T5LsmNzIXAkes9cgTN7X8xQ9tEnZE+cmkSsJ3k3Er7VOi6LA9G1wN/xiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=226mV1qh/TRqzAg6SGyO5or7L1t2wyN7g6UmyNJqbdU=;
 b=QIHecFj7jYctjoW1kDJ2ma+EdV0NmTAMFDm+IjpzEOZ0BDjo5uAp8HcLFcEgRdCr7A6l+X8SQh61l5AEVEzZPbp328Txfe1cPzMgPnP6C1vQQVMGWKMSrXagCVH2xT5aEpxfnefNPczzz62AOdJo6gxdVg20WGS6Aze10NnxEgdwiBzUxtODmC91AaRhQe/9nHBg8/DPWp3vf+7+Ah6fmOfZ4HNs8UIUNrI905SKf+sI3FVhXuUuDiojx6Emo7CL+Uf5disw3Ustda9IwsT+I7f1AMPHNhBHxkFz23jD05NZxhTnpg3Hmw+yjFyhVqeaY+yuFA7AIspPOa4w3R+UOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=226mV1qh/TRqzAg6SGyO5or7L1t2wyN7g6UmyNJqbdU=;
 b=ppbIq4bjMcE/NeQ8AR5GfMWacggNtwPesHOfh45249b9nm5Nq5ywfD2gfl4gUPGPQRz0BWZL8bXEEuL39ptVzjvRSh7g5jnIKdFZTTe0XVDybGa3/R3nzg8TgpyG6uzDEjirlStJfGMGKD9a/PwMQIqsX/boK6FqpoYCxmWOibc=
Received: from BN0PR04CA0129.namprd04.prod.outlook.com (2603:10b6:408:ed::14)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:41:02 +0000
Received: from BN2PEPF0000A802.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::10) by BN0PR04CA0129.outlook.office365.com
 (2603:10b6:408:ed::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:41:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A802.mail.protection.outlook.com (10.167.245.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:41:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:01 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:01 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:40:58 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 10/74] drm/amd/display: Stop HDMI FRL status polling on fini
Date: Wed, 11 Nov 2026 09:28:16 +0800
Message-ID: <20261111014100.3596072-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A802:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 38111676-2772-4152-f9d9-08df3f94d7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|18002099003|22082099003|261009221227099003|261009221727099003|261009220027099003|11063799006|56012099006|261009223327099003|261102123227099003|261009223027099003|261026121527099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|10067099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: nVZ/a0hVoTLG7NXVJdCC6Vab9S/NTvYsLBp43YN4/slHP+w/+XDRjFbfSf6Mo2qMfx4uklQy7g/S3ynjX5/B8tWD39wEh30UqnO0Fl0syuuF3cFkyaBqfVVsb4enb355dRrLTWFBwj57J9gqYKqkComlczpgStkZ54NCgricNsDrrdSbFAiaVXxpmVbi6X3UY7CCoC4HpKrwN2Wg0t5Bpln/3zD0RWo6hamXI5CgRyjVL4ocLyEo06bG4tyT5vO9db+ye9j4mMF8KMTnegKTSd9/WqRZH4BfPjyhvi3PMKtwp5KI58yPur4aMlPS37iriJV/Hypx/ZJDFKAHBZb1i8HKyokbRH3sEBAFn1ImNbYiXw1M730oNbrlk6zWbrdg1FTKYf+WPEIhHa1dAvZPT4//z0JmjG+kObJQn30ug6b+7FQFFkg5HIbwSA6p1IzggP4S2UNO8fP8DDLQKdNduURmPJ27j4IkXrpAT2h8tSvEWLOyT1mX1MrXPuPz0C7O3u4y8frDyXEUrkl0LItMF0f61lQkB+WnfVutfOBaJIz0ir2fN+6W05e/91boVb6hU8M0u6kpG8+9EIXKvCNg7BOF1+fgufVy+6Khm5t3DRsGGzfcbOGO1iANC5XZlKh59cn8oKiHjMSA6Wpmb3blmWYOk9wmXjx9WGUxRMmYz0bNLpxI4VlKvi7goJHHTMIfDkvC2YCzWaCtc84cSYDw/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(261009221227099003)(261009221727099003)(261009220027099003)(11063799006)(56012099006)(261009223327099003)(261102123227099003)(261009223027099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(10067099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OEEQG9hrmMcEtYhTyvoeHds3qoGPXyrOE9hhTKX+Sp2SAUVDhZgRyDHiUbOxZXSEkSTCXhzb3Kw5JDErk1n+xylSTDE75/VNPOtxsObm0iUlKhaua7gzOi9OonLBCFJNZ294VO1pKrh5sg5QgNILFvesLfVojO4SjwlePkEe4qnHSFjU1VNCo20VL5kfI2V4NvPTk0Lj66sB8a9ahh3rKel6wrYXkWB7Eekh8KnZWNdAjV6lghvK8CO6krZVO8vQptmJl+O0kfWLbrULsgDpMohh33b0Y3I/QP/4VBnQa/GAVCOk0ogMRBGCHwFtxZ0vtzP6ukZrBrgo7Fd2X8w2Gf8oXwMtBjl6DfcoKz8gPNxq7CJd1RiDJmy2clJY+a/nHucdeOY4KSQAGr7+eo8pchsevDKGEnjdz55A0naon2/gR1zvCTxrCHPCeO2ohXn2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:41:01.9924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38111676-2772-4152-f9d9-08df3f94d7ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A802.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fangzhi Zuo <jerry.zuo@amd.com>

[Why]
The HDMI FRL status polling work re-queues itself and its workqueue was not
stopped during amdgpu_dm_fini(). During unbind or unload, the worker could
access freed DC state, and the workqueue was leaked. This fixes the FRL
polling teardown introduced by the HDMI FRL support change.

[How]
Cancel the delayed polling work synchronously and destroy the workqueue in
amdgpu_dm_fini() before the remaining display state is torn down.

Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7fffbb609225..a7c2b0094944 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -885,6 +885,13 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		adev->dm.vblank_control_workqueue = NULL;
 	}
 
+	/* The poll re-queues itself, so stop it before the wq and dc go away. */
+	if (adev->dm.hdmi_frl_status_polling_wq) {
+		cancel_delayed_work_sync(&adev->dm.hdmi_frl_status_polling_work);
+		destroy_workqueue(adev->dm.hdmi_frl_status_polling_wq);
+		adev->dm.hdmi_frl_status_polling_wq = NULL;
+	}
+
 	if (adev->dm.idle_workqueue) {
 		if (adev->dm.idle_workqueue->running) {
 			adev->dm.idle_workqueue->enable = false;
-- 
2.43.0

