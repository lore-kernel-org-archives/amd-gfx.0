Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D519C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 10:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E484010EC99;
	Wed, 26 Aug 2026 10:28:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vYpYZTE/";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011028.outbound.protection.outlook.com
 [40.93.194.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48B9B10EC99
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 10:28:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvuvBwsFwq+f/nTFxxCYg5G7Ml7iETUEQMOSPbvHEHeA3eSooDvqm9zCvbPPHyv344fAwYCvoY/YcTJD/tygVxliS8weowuNWGO8m9DMipS9IQHMVoaVl1lHVXwHxV9dzUM0qwQWOxrDHRt+nEsDsZqpVAOpc7zx0Ihwc/BE9DoaU3stXwm8xKL+HzhziZY40kbfv64ORZHrVgaI6OophN+RXZB2YwKGrBbQ6w/hq6E675OGeOrGIouB9T1HIFiz9aJYdO3MONzOqmGeXDH8Pyxoqz4Q6NBDqDQnu0tkvPJFvCMs9K7gKJT3Az8Ncxd/oGhVAMPmi2tq3XJm5D5B0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x99hBsCYYFcTgBWLmQDZ3XvgSfO1r9uyNHLz+/HE1GY=;
 b=vU3LpaYnnqLyTzM8oA1WQDwNlo88RQkxOaqP8j37I17Gc6PEQCfF2Kw7RKuNmmxITg66ib6Lxqa71nM+egIaz8HE1mP9CZ5qcZexkJZE0yyomN2xn2ssgAK6t8CNb/A6pwAowIXy6DsyPl6xnQ9hrUOj9dvcmAozFIcfMTsryNxKFyvvy0dZWyCZgtwHgxxCfc72DKGVKEv0rCHUE/evd5kZVULEMOmv7PoxdogjTWxQO2QcNzPmh9MSMb4eoJTIt/0z4eVketoBLGlKZ2HqioHNHYuZK73Vu8zktjvLoBk/AsRaTmBQm5f6Ij63TBiNqlL2HlwlQTlVmEXQ6X/VhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x99hBsCYYFcTgBWLmQDZ3XvgSfO1r9uyNHLz+/HE1GY=;
 b=vYpYZTE/iLtO1g83c+RbM6JK9aQ6XVDHgixVnW4zNt97u4Ov+2LzgHjGCghL4elqzhM9PIHZm3yIMUIzsJTGjVr4Gdg4wzGu4qFgrrkKaTfVf5TR/7486YUpnBFDzRdCfvfW3vnyXN4TNAlyoFz6bTqwOMjWXeNZBsqXezBIvgY=
Received: from BN9P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::9)
 by LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 10:28:03 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:10a:cafe::14) by BN9P221CA0002.outlook.office365.com
 (2603:10b6:408:10a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Wed, 26
 Aug 2026 10:28:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 10:28:02 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 05:28:00 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 2/2] drm/amd/ras: take a log batch id only once there is
 something to log
Date: Wed, 26 Aug 2026 18:27:37 +0800
Message-ID: <20260826102737.575490-2-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826102737.575490-1-xiang.liu@amd.com>
References: <20260826102737.575490-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|LV8PR12MB9620:EE_
X-MS-Office365-Filtering-Correlation-Id: 5310fb7e-26ce-461e-63e9-08df035cb5b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|10067099003|56012099006|5023799004|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zg3DCOG0L7PbarmM6GaGslzRGfQBZeNeF0LXeyH65JBK33mrjh2yJTPjr6YrIG/Hl2qyUZOrdjgLfyqFIcjQQhEzusz8PA2ezzHpOCVNxvM0jRRJezRwIPECjHHnlMD4JfL9EbTgNssk+gCY/P+I35mqs2e47B6cmRx/IZ1XMvvjRfiRaSt092Zyc5n083R/uCz8SqgyXLPQl+t7dw373kLzqew/2F9jGp6AH8qq2pr5gqEYKMA2M2vZvwVFLMz/V/j2qLDHm71Wjmy7xMf1ffiq10yEhsXeaqCuxMTig2H50bONcf1XqUCxuW5J5Q90j0vLkFxfwgBWKsID4VNt53glFqtivXBjGku1uFO9JM739od5T4HfBIEI/LS7CIzDl0lFiV9Ir/mfkhoqBMAKSbP9HFwSrFHbhcJKXHnAT9vZFNml8ycn8oMOEQFxF25Ud1AAmwswZoDsaG1H43GFzShhWQ85B305f7Oa8pEgq0WzOKcgU7u9VyZDUJmFAr11xZV1OFjVerldXdc9bgXA7xIRVQ2bYrbN577kGGwt4QUiUbadRPOlIBZLENpPCOTvDmwswqPeQn4HQ7tbv+i5gWepaGPerj8hdWtkaJTZ6zgPuHpL7z1i/rHOhaH44P3rhRt5In83/CSAhfeTsDY1q2O2n9SenD9O7shlsc4Wpw6MBGeAgIVVh4r3urXmeQ1haRTiatZlzU3eyYO0jSzviA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4WAjT5X0Ylf76BMck/DubxvnZ9GUNmWzB4DCtxqQ2RA8PL7yv1v2lyL5rA6iacC4sG+sAyLStTzNLPkfNsCb97ffoFhH/3WhgeNyc0rEd54UCAb48GgMhaWfZbyXV3pII+j3+hZ21iA44KU/3RUfUyK+19Jq6o0JGHaYhQhR3Awj+MbCUqk4jbPClvBpN/oASQiCDlHUHnKsT0P7zV5Pwni/sze/E0FrzIb3lvyQqcw6o5FrfYw18sZycRiaA2dcYgQ9yWD8b35nD+otfjpyS9RaT60N0Qeevpw4T617UsNBD6dxWY+OsqBAQrVQRjBrvKXRII3mSCVIwJpHVYXnFEmtzPQiLq7pnfwp06EsUUwuKOUb1RM6T9LQ/5zmwrgR4IaeBumExOGdhi7N+rB2+8tvB6+BxQY/qS/zZ+1h8Q3zgmikNfGU5P6b1pba3mbQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 10:28:02.8596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5310fb7e-26ce-461e-63e9-08df035cb5b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9620
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

The id is claimed before the banks are read, so a poll that ends up
logging nothing still burns one and leaves a gap that every reader of
the log then has to walk over. Claim it when the first record of the
batch is about to go in.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index 881681ea9f3f..4289e968d331 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -394,10 +394,6 @@ static int aca_banks_update(struct ras_core_context *ras_core,
 	if (!count)
 		goto out;
 
-	/* Only one MCE error is logged for each batch */
-	if (ecc_type != RAS_ERR_TYPE__MCE)
-		batch_tag = ras_log_ring_create_batch_tag(ras_core);
-
 	for (i = 0; i < count; i++) {
 		memset(&bank, 0, sizeof(bank));
 		ret = aca_dump_bank(ras_core, ecc_type, i, &bank);
@@ -420,6 +416,10 @@ static int aca_banks_update(struct ras_core_context *ras_core,
 
 		bank.seq_no = aca_get_bank_seqno(ras_core, ecc_type, aca_blk, &bank_ecc);
 
+		/* Only one MCE error is logged for each batch */
+		if (ecc_type != RAS_ERR_TYPE__MCE && !batch_tag)
+			batch_tag = ras_log_ring_create_batch_tag(ras_core);
+
 		aca_log_bank_data(ras_core, &bank, &bank_ecc, batch_tag);
 		aca_bank_log(ras_core, i, count, &bank, &bank_ecc);
 
-- 
2.34.1

