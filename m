Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A1ACD98DE
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 05:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 844A210EC88;
	Thu, 18 Jun 2026 05:37:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z/SM+lvs";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013018.outbound.protection.outlook.com
 [40.93.196.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0C010EC88
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 05:37:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UasEcrDOiNQhdccjn0teDdOZu/qIyYRdxNbMPGhLDUCyvIGOqX4Z5IZdsHvO0Xc9tVoviQYIiBBTWxu3E9dX8k3IV4LNwqicwrWabc7fQ/FHpsf0xqZeCVWQ9op3iTQKH7tBHfYG6PjHxTGrGx3bOkLHfcmQQhyoAlNmpKpJuKT4HtShK/7i0r5FL5bqG1TVYiXeYy85EmvqV0EpD1XnOffqIzG4hUgY8ucIDznUOnXHsbcf+FWn67JPmL9cOPOWyZQDjmqsOnRjTHX4Mtq7W3XjjWZx+h9+IXc10vAWJ5+m3ueaKeNU9Spuqjn8omXhz5CSUvZd3UwwnjpVaQJuOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BH4KKiazisXJ19NTGEVTlQShOE9pGMzk+3pyPjMqwI=;
 b=V91O+dDNaeBY1O/37+hYP54/NA+lXfgvlfSKLK2NoKC6JXyovOkgWodMgy6Dko8h7CigKWxoPtN5iCQlKS31R72Izxlvw+oNyBf9ofOyj0NbvJRZTT4oaZ61XBuiD/ZsK1W3m72pfYix7AuDIwWHUCwMrwcU2UgqeOr/md4yuv4svbvGDTHk7jDf+WVNh3QWAquTK7RJWxbbeWPFLpIF+FxkESLLjKqdUMSLV05070SaWZqAtq316gCxa79G2hXilSCenH3BtmbBCOEszc+6TmgmzTejhWNwN66g0HGjQdMh2wH7aC8ymIIBk3Ag9YfOhDqw3PLTA1fv3u7ndHo4qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BH4KKiazisXJ19NTGEVTlQShOE9pGMzk+3pyPjMqwI=;
 b=z/SM+lvsLR+1/VV0iUNq81ycrYy++LS+Ijp4vq8dARSXyorbBeo2wZzrH35P1phZUtveCwa54haneTDNaqY5x/hRoJzCuLox7zRmhEivvGupYCx+v6RKkTqGjUw+MPe7YBMm2SU9oDdYme+Kj3dBePRy/t3Bpt2R0ZVA2HCkVR8=
Received: from MW4PR04CA0112.namprd04.prod.outlook.com (2603:10b6:303:83::27)
 by DS5PPF5C0B6C3B6.namprd12.prod.outlook.com (2603:10b6:f:fc00::64e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 05:37:16 +0000
Received: from CO1PEPF00012E7D.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::9f) by MW4PR04CA0112.outlook.office365.com
 (2603:10b6:303:83::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 05:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7D.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 05:37:16 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 00:37:06 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <candice.li@amd.com>
Subject: [PATCH] drm/amd/pm: validate vega10 profile mode inputs
Date: Thu, 18 Jun 2026 11:06:50 +0530
Message-ID: <20260618053650.937168-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7D:EE_|DS5PPF5C0B6C3B6:EE_
X-MS-Office365-Filtering-Correlation-Id: 5afee608-66c5-4c2a-9e69-08deccfba81a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 8lHnf/t28QYCEsEz0U7JmufmbVkxzVpo9zE8Cnk8DOpiDShBBo2rqtezJjInGwtj1SUZk8V+4y8jabTRygp5azTDnxJ+dpsVyGVaDVzpAS/w4YTvKvSI1rc9hh3AepBmuZNr6efT48101oxktg6yrsg5XAYlIn86V1aYb1Wkhh08HmagblFzhi9kQmT9cjRHF+7zmHki+4PR/uBAfDqAWITRdkdfzSHLSK3nTNi6OpIhXLcfjQfmyo8KHzZ7dHVsiC/zuY/eTqwl0u+8bCPMWkV44LA+nmnnh+5bAAugvfkgb/QfjNB6EQGkiwuJ7KMavEZPLrm7viiBR0QNARV55weX2qBWZPkETDEkLvVSLTHOV/tQ/fuMFDDAqu2ItJtBGGO3QbyW5zTLlvh3esSjVPztJIdriiQ6RSqDlHg9ekSqRVKmTik1mQ3O34z5zJJfMJZDgNbuXf3CUFM7ME2d3WlT5HAe6jGCiTsM68NygnEZmJbrjUZHUERsrkDsJepR3Fmaj2kBRgAGbKNICbtGeGRf3SfbrWJY2SWhu6DZ4hPYJ1QSIEUn3XAJmOzhx1WckIvNmoVwEwRwbRHjTho+pMz1q3xucPj9rHcToW43TOXLIrpiVEoKxQMHz8JFz/tKMKd2ScEF3eknwls+oRS3mEWROpdZvRkHtPoKGKVWByppZzHMP7EWltDuJ4tW2ldNMxLDfTnErhZUJc3ZDA+iJAHa/IRIUX9rQJtU2vS/YQ0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SpwnBOZDtA3Zr32FqbVeGfKEEFP3k+7kLCplcyrYzDRIpsDfguWIYQRwHaYEm/pyzjSVNE1EljA7gVITwUgKmYwwkFF7W7aXfiQq47NnxlUVCPPcXSG9MVnCb5p4lahqwRG7dbSd77/l3K8TGpk/SfpdGgT2bmmoomEne+gU+7oL+neFtE1yNQaiNPiCSbIS2OZ8mwGvcKkZlOFKWDEvp9Og/xRy98IVeV28YulmyQqjzRyStAF98uMBRzTO8WZ2SHb96PYEo8vCkNMBka+IEY9Rl4QAdO2wN4576BKU/vWhvX0zYyjpCYwt/51BFO7JE7iRU+pGEOC9lvLttglJ4DLZFXvwSFEHZAR5HuLkv9hLTBwem4Il5nQMZuzmncuiVbK+tlLnooKozlc5qPA0Ebc9IEHGLgiT9ooQ/lWor/f805PPyL8vEdDWtmK88oaJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 05:37:16.1543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afee608-66c5-4c2a-9e69-08deccfba81a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C0B6C3B6
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

Check for out of range profile modes and custom params that exceed 8 bits.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 076e10f26546..649cfad7d36c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -5216,6 +5216,11 @@ static int vega10_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, ui
 	uint8_t min_active_level;
 	uint32_t power_profile_mode = input[size];
 
+	if (power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
+		pr_err("Invalid power profile mode %u\n", power_profile_mode);
+		return -EINVAL;
+	}
+
 	if (power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
 		if (size != 0 && size != 4)
 			return -EINVAL;
@@ -5231,6 +5236,10 @@ static int vega10_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, ui
 				return -EINVAL;
 		}
 
+		if ((input[0] & ~0xFF) || (input[1] & ~0xFF) ||
+		    (input[2] & ~0xFF) || (input[3] & ~0xFF))
+			return -EINVAL;
+
 		data->custom_profile_mode[0] = busy_set_point = input[0];
 		data->custom_profile_mode[1] = FPS = input[1];
 		data->custom_profile_mode[2] = use_rlc_busy = input[2];
-- 
2.49.0

