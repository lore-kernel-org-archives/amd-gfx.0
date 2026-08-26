Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BFAC61DBD
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 03:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A73910E244;
	Wed, 26 Aug 2026 03:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MePD8VRk";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E225110E244
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 03:27:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nf5QqtTjAt78/WqpwwcdVZKKrWgb9kTjOGFrOPpPRoI5rK4p3IJxRz2xeGcfSqhjGKy7Ty0vcl0VmciflYmYNyhVxh5e4Sqc3BxtKDM5xvb11eVaIvrXK9eA0vGStA87q+4GGc/Qgnp0839/SOHSTX9tP26H5GCxwVewPaYfIAs1Ci54uuZPh5Z4xPwJ7bMFQF8wF716fGjXXoFi9ntpparnYkY7blRqQFcyoG70fnQaDqeojV6GYjiqjr2iDpH+gRIWIjnwp9jKjPT2hLTzSyJyFVjNSQW7UNUrRofjr213367yoDk3E8omm4xyQZOFuUtg9sm4VGtzhsqgShrX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/3JTlfkKZr9+bDKOHmsfnn0exYvfYUybLkCDh0vsuM=;
 b=jAn/aAujN9I2q6KZ4nsQ4k+NAk4Uc8TXcBRGlCLLtZUjcxsJtJJS2G+cV9xn7DqWhe/dAGm8plq8aw4wf80TvIxhxnYERpU11Me3E/vQvJFIIPu7uyHNMN7qgh2ygU+/r6JrGpk6GhHmCsAQWsIjWNyhwRTxfFXoWTQbyn+rW+k/XcPwo2V1lBYs0SxOFAGMuNWaLd4X7oxORc8BHaqU20DV6JSpg52AoH1muoftzXQbhNIg8fkx7riOVeP/ODL/lMdiM1IJHhXZm3gJwFKYf+Aie8uD/O8q/L39vzaOHe7w00AQSNPwr4CPvJRFzN1Qr27X4ZZ2TsH7Ok2ugJ4X0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/3JTlfkKZr9+bDKOHmsfnn0exYvfYUybLkCDh0vsuM=;
 b=MePD8VRk3ayuObP9gO/gDgKAlN8TfcPrI5P0fdljw6heupQYv8AbTBcA8xxW+yvzZD/Rm/YfiwE/R/0qxhjpMM70aV13cYQG4KlYto8LbRaaJXRLlB7EGmwVG5fLCwbhoGkl4iXxcngM0/Ir/wUWESDRQBS38QkHcgQj3+XblO0=
Received: from MN2PR16CA0046.namprd16.prod.outlook.com (2603:10b6:208:234::15)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 03:27:25 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:234:cafe::3c) by MN2PR16CA0046.outlook.office365.com
 (2603:10b6:208:234::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Wed,
 26 Aug 2026 03:27:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 03:27:24 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 22:27:12 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 1/3] drm/amd/ras: skip poison banks read through the UE channel
Date: Wed, 26 Aug 2026 11:26:04 +0800
Message-ID: <20260826032606.470702-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d864467-db75-48b2-e3fc-08df0321f2a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: f1JbxTebEbiWbQjM82CJHLhzAxFRff4CFw+tALKpt3rpaXt8RQ0ei9H4G0ckCs4UYd5FGzzFO3tVmj8GGiLh4p7V3G5fw+XEPifae9PkeX74iLmOZk/4tU1ZdQUbAWBW3bH+rerKYQAwS/8NtX8WB7Gmpvl6tGU85oKkIrZkJKObnCq0lhuTpzGMRAakGBeAhO7YeRnXMVuhZWO2lZ5aSmJiueRh4JSn0Xuu8IUa/DFtTaU1h0ivzaUGPIxnl1pA9xxrkAgrCB2wSEKpk2yaShM5W9BEud/jbFA4sdlBWGnd+eXA8S4J+CZ4diW9qq8B4sK72mJaJ3Q0Rx7f+dkWkhacDoNLfft1QTHTiOdrmBbbT1vFGQ8LBJat8kC/dXHVCuDO/sSzNC+b0A1Un+QvGwrswLtjhJxduTL43w5zW+cJyhnrxqQ1B5/xY8eYpbgVkDB8arHdyC4EqWbWbzKKovUBA8IiQ226JUy1G98w73+DEYdjGaEuzArp65qb5Y7bL87IUBensCu/HQAEjEaW0YLZLhlYuvOGyep9ub8bGcFmdNgzcYKzoTeW6Hb6zvoTsJnNgd9t8DcaJ4naIXbFTbkQ72d0tumESDmaUJ8Yxi1DsBSqIz4NbTO9zShhqiTcgq86ya0yWalfReLVz/OVJu8QsjvGihzdHhTsdM89nBuJba23f0yo7XtTx+5HhkTwmDMLQN3gSL44RsSnfnb9DA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fiyzDXVfNHJacNsYTi6UZXyVEy3tvwA42Mw1F3DijWkt4IttTGR6AXl2NP7Y4XHqiZLcVoU6WZBmDiRHP2fArAuHUXnS739qu7yFWwrah5wJ1JIhMnb/ztiGaumOb9a1uR4OQOMr6mn6jJ3Yj/40otjYVmgqE7H9Ci83YifxqEQiJDL0vuY9Psb8vXnmyG1OO3mVcg3o6538gJLQ4NhilLRYFqCJbcE/FFaPmxe+fI5iB9c+16Sur5vYRrxpGg3YkA+ccu1GuwuG+G7pa2luTOds0sVzPTHwNRnufb5jZLqIsL3c+NWoaKnocCzMxfx3/29hTtP9aPX3SLxLAjVkgT46bYbtcCovPM+VqC8Oj+/EaDqdote+/SH6qGFLNazlKz+VvqV+crcsk9Mga8YBjUIR9Lx0nAb0GTKqpkSqbjsPP6MPmCHScJwMiesgsww5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 03:27:24.7857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d864467-db75-48b2-e3fc-08df0321f2a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
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

Outside of UMC a bank with the poison bit set describes the consumption
of an error that was already reported, not a new uncorrectable one.
Injecting an uncorrectable error while a workload is running therefore
buries the real bank under a dump of GFX poison banks collected from
every other device of the hive.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index 0f5e57965ac8..f316f49c24bd 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -403,6 +403,13 @@ static int aca_banks_update(struct ras_core_context *ras_core,
 
 		memset(&bank_ecc, 0, sizeof(bank_ecc));
 		aca_blk = aca_get_bank_aca_block(ras_core, &bank);
+
+		/* Outside of UMC a poison bank is a consumption, not a new error. */
+		if (ecc_type == RAS_ERR_TYPE__UE &&
+		    ACA_REG_STATUS_POISON(bank.regs[ACA_REG_IDX__STATUS]) &&
+		    (!aca_blk || aca_blk->blk_info->ras_block_id != RAS_BLOCK_ID__UMC))
+			continue;
+
 		if (aca_blk)
 			ret = aca_parse_bank(ras_core, aca_blk, &bank, &bank_ecc);
 
-- 
2.34.1

