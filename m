Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD651094486
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2026 16:26:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 895EF10E246;
	Sat, 21 Mar 2026 16:26:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zyd2P2kV";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B37010E246
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Mar 2026 16:26:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzu3iUtF8F8WgYfWjmqHDbvDzA6kTq1wHkep2eaTvXYx/q4mc4XOfOTzsOnHfwlKUNPcrNdgOudBOY8HX73c7PfEjhLsnHgcllbKFWzHR4iTdJpNQxz+XuWBu3UlxClYtARU2h03eV42dlyU83Dm2S5MSkHonJObZN+N7A5GN1m05ZG4GseWB4JbuvhZWOlP9X5UQ6h0NjkvtdKD6DkfFCDKbRrmGvAhIOeTcc9HYaI4DCta/eVXb38PwEHA9cPE8iCDMujb+CctqxFCfIPP6WXt1RAG1TiHt+gm6xBIrLtImDACBiznTkMpWpk5MwprJdc7Yc0OBBhNP9OA37JT2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJ+AvpscFbduijCo4He7QsimCs/++fkHSjKw9nwcbGU=;
 b=MIaQT7ERmCUcesbg/jXPuTRTkoIbzOvw/0DB+0OWrHkqaEcLxhjlBUsoLLQkkz4kJUS5+v1gxIK8ogfdXA7XiSGvJTcAy6o0Mzti760cZiT10rKG6DrV9tGyQOQ52t+mSAT4q1KP1s2g2Wh7NMHt561y1SFwgw/7/c+TEbLAHGrdVSODViiyOdnmUEk9yXKP4fZOrdo9m985Wh1fLq/AOBhiW5iEMED5k3leCScfeBJ2w+Xow8os3yzwJ4xZCMUZBcLPUNPpqA04VSYuxLU/EdBtFt+ONookQteKfLzlao5ILYgyf9h5Kxs4NnzzReUpkH5UWC41EDcTPSLvYDM+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJ+AvpscFbduijCo4He7QsimCs/++fkHSjKw9nwcbGU=;
 b=zyd2P2kVVWs2pz2x5g4kuIRj/5tXnMhVuFo7y4++jP+hUlCeGu7Xvt5Jbu8SmoynP1mDc1iOve07S2zF8X/wegLiJYxczzHCCe+PgGxX9jKMOtbRNos2U6LPLalAcUcsrMqYRCzNe3yGyVs8NdsX62cBKZt7QN+ITlW9feC0NJc=
Received: from PH8P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::11)
 by CH3PR12MB9124.namprd12.prod.outlook.com (2603:10b6:610:1a7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Sat, 21 Mar
 2026 16:25:55 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::9a) by PH8P223CA0023.outlook.office365.com
 (2603:10b6:510:2db::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Sat,
 21 Mar 2026 16:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Sat, 21 Mar 2026 16:25:54 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 21 Mar 2026 11:25:51 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Dillon Varone <Dillon.Varone@amd.com>,
 "Chuanyu Tseng" <chuanyu.tseng@amd.com>, Roman Li <roman.li@amd.com>, Tom
 Chung <chiahsuan.chung@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amd/display: Add update_descriptor param info in
 'update_planes_and_stream_state'
Date: Sat, 21 Mar 2026 21:55:30 +0530
Message-ID: <20260321162530.2025141-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|CH3PR12MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: 59cca6e1-5d20-4259-abe2-08de87668689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: N9NRGtnZrB/fQ9i5TWwNjv3BfLKLX0mZ7MD2iqvws/zuiDSqCZT5KrCxn9qZXRReo+nqVgredWr7QI/uP498QQG91t4Zztuzksz53bPiAvl+1mvlQpCXRRJnqUR4ZBNLlsBPpFIH2WcGb3z7lT3Hpjazr7FEbkfhfOGpKT2qNbzmbDv0EacWEz39zzPmHhiuSD7QiZEbMsYbd5iU9koQEFb8+oLRSX+0t3xnHiB9fwECWubpNLDW41HbaWFmkV4GrADBmrjsPFnSqqSxLES1M0/wfPfhk7so17Fa28Of996t0L+iqoKrdKYgyHmndqqNK9n+1g5GjVybfhD9SJaEJmSaOUvi11hButJ20pDBeqG57pklMVkRNk6kVYWWFH7F7y4m/96hMIRPXuaw4khQq65xN4nnzVaUuv14Cntg33A/YnnmmVYhVj6t9CHGHr2kelHwZWyD07y9fYP6pQfH0UPzg2sHoI90oGtFKVj24avrUrBaIq881DqpOLIqLZ1W1gLt82s6QMEoTM1jontB+JXTpzVe+lIhY4wC935iSfhKgPddmymYBwVrpnOwATAAgTAcmFw9NyvEQBiXNTM2QmKlmktnFbgIY8YyDPP2rblVzevx3Z/6bqhmohHYWHkH4Rt36PS+BopQ+sNBaVf018qJF+AbPdFw7hs1zlMfpYW6/tPkTjmuTR7oOx805985fycWnjlRuLG57PDQGK22w90B69koYCu/fqk9O7TIkbuh275WY7WcA6pDYUu+eYkFhfBUm6c3qSWgMMxXSQsx8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IoUT8EP169twZTyt55i52QDDoxx85DWmmJeLufgAHTjrwqTTv2U1ntXeGkn1Ur1RDFoA2hWyl2Xg1kxidHt6HB21U2LbqLhD4yuZn2V0TodvpLlAMJ+Ld6ZvRA7wbb10PV0eQ/SEYS0ZY5DLFeDp5HukizOo27CD8D07HtjKRUjDb4aiH9l0hw5ZN88U7RF+cOLySt37xpswp+vYo8uNDrAcgSlmcflWYhzt4x8rWZ5vL8NiiaAWaUDbwM57f2iN/6A9y5GGWbe3ndioCSc5/cecLkCaHueuWx9qZZzlSEgtot/zvdZ6W2rC6+h3d+hanB6mL09LBnK/Gi7AyARN98W7oO5JHNZ9qiPuSi2pZ/45Ij78+797I/lttsIaZ4HYDHKZmsN7AsdUS8F8hSGYvhtM7N9VLKGl4SZSQo2HZ7Q2hAD/kZo32PfPrT3tV/Bs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 16:25:54.6162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cca6e1-5d20-4259-abe2-08de87668689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9124
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

Add missing info for the update_descriptor parameter in
update_planes_and_stream_state().

Fixes the below with gcc W=1:
../display/dc/core/dc.c:3630 function parameter 'update_descriptor' not described in 'update_planes_and_stream_state'

Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Dillon Varone <Dillon.Varone@amd.com>
Cc: Chuanyu Tseng <chuanyu.tseng@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8b21816cf7c8..e3992ca43c8d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3615,6 +3615,7 @@ static void restore_minimal_pipe_split_policy(struct dc *dc,
  * @surface_count: surface update count
  * @stream: Corresponding stream to be updated
  * @stream_update: stream update
+ * @update_descriptor: describes what plane and stream changes to apply
  * @new_update_type: [out] determined update type by the function
  * @new_context: [out] new context allocated and validated if update type is
  * FULL, reference to current context if update type is less than FULL.
-- 
2.34.1

