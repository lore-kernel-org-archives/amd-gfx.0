Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F55CD6E5D
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 02:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE5310F77D;
	Wed,  3 Jun 2026 02:06:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hqNiAtXQ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012033.outbound.protection.outlook.com
 [40.93.195.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 991D410F77D
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 02:06:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCMTIGmRlqAGWRHHiZYk6XXW+eYnfRtHKKs6x9N+B2/C1uXyctkvenmt5SAsZI4x51CbaOXIywaKyb0hFFnx6JXgaCiILTShtOwJMCLPTsTf1SZjv6KLyBXA3fB6aTir60/y9hCtDZPE2obNACAt+momdGHnA8xJ5T9UlHk+gFoKst4E9fLR2/hbeIjbNouXqbXUp6lKd50+N7PjxdiIbAPnnncr95Fvi3SnjTFfBrzBdAG+UEexgfgy4UVkO+KcDo3582m95sRptEkEQABKE/1NJFiigRFIgaUbZfjqV+0UkWc42TzUyLvXlZDJtLCdpjhJbef4gQEco14IShtLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teBaXvzZr/0e8aMdp62sowKCRTBVgqsu+PmgPR30oQE=;
 b=BZPVGm6ABWwBaLJebmkwt+ClUfoVg3eV5NWyEBmPjccP62DhYYBLfEfPmt8F5H3I5KTJsEtQWUlN/fkj6f71wxTz8WHI+aGLeV8D1vS2pH00ARhArqYMiSH2WU9GMqyD4g5X8LXf2X7/Xv4edNvBPoIREMq0AOkKELVmiaWK4p992fEa41IR+gZUhjtX+3gJNTBxhZD617Ht0CBSj6ZtnjAGxqoWWqk58ZuS6uT05GPzEUSZ31FEHAR1D07INRuNkbGL7+DQ1DtA1k5VOqzJerMX27iAS5KhmBxCO6vzaSAQ+4IHqg1Q7r2TkrHGppbf6fwAR/n1gJcx+LEy9zun4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teBaXvzZr/0e8aMdp62sowKCRTBVgqsu+PmgPR30oQE=;
 b=hqNiAtXQO1CbCi5s9Yy1xxmxHZH2fEivwaL1ubFJIHQPXBWfNq6wypSE3dur1u3EpTzW5T2IZ5Jt7NlHkseaJFnMvu9o1v/j2ZNwMs1OpmQ2pw7+Qy1v7yglOOOdMg8s3+Oen7LtmAX+K9Vu+y3SWl2mwar1X9PtQlzXJ1xAsPI=
Received: from CH0PR04CA0102.namprd04.prod.outlook.com (2603:10b6:610:75::17)
 by CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 02:06:28 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::af) by CH0PR04CA0102.outlook.office365.com
 (2603:10b6:610:75::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Wed, 3
 Jun 2026 02:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 02:06:27 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 21:06:25 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Patrick Xie <gangliang.xie@amd.com>, Candice Li <candice.li@amd.com>
Subject: [PATCH 1/2] drm/amd/ras: sleep on PMFW EEPROM busy in bad page count
 query
Date: Wed, 3 Jun 2026 10:05:58 +0800
Message-ID: <20260603020559.1273844-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|CH3PR12MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: 507dac35-a395-4ed7-cdf2-08dec114b8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: rWW5Ghrx4tBeWAuWReMJXlWMkWQplkCCO4Eh63plQCZNWT7aka1P5KTbEB6yBcMJP05kCHZBoSUnF8NNEOq0tl/uCLo+s1hgQM27hYyRB7vVa53qCfLriMQTNCKnvRNsDiSRMJyM0Bx+Vw7tgdPvOAGz9WGyixzOs1QoT34c3IY3kFgA2tYYGs8ksdWQ2hzDcJwLAjyy0rW0yIs5UAQP0RsHJJ7mCtxmSoSl6WIgMUYoa9d5Gu5MBkczOXc/iolGLLc44mso5Tv4K022xJaTsjJDflE6IKpUac41SwpOiHE40tSnZ4MJotVUH5mYqHJaQDGVakQY6e9kpvMOz/NVEwtOYZh394Zwv6wf2Xbq5CtDRwbeJWNoESAkUQaAZWt0BH8akxKyqa4V2v7EW+PkZLhIgLplDOzRhRtbdqwcSkiYnmqYllMVCpdxdKpO/XrHTKMHCA2yvfefQ9kVKPYosm7nIrQb9VmmjDTc3jdul5BWMv/g8FiB391vn8Yo8LHKwZJKotZCS9nduJtAXt/9h485BwAUlunyyf1rbKZr//7exTkXmJPtiO24maYVjqnzXduSTtelC16z9fy/sg4VA0ic3He5f1Tu95CYbjgJSgo0V/ZRPWoK7BEoedgIzL/BrbANcTLY5yiXzKzCQOLVF+L20wNL3C9G61LKoBK0vWUsXSYUyLC2K7o58eEUNIMJJgvawQBWu7JV522DSk8EtYjMgMiIWhjRtxBYHBF7pXo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N2tdpEuFMM+J75YpSFQnG7bhpzdn/fgeVcTb3W4DOxQd9z9lPPBsRAKrw2WP8tQ/NjBaEBuC22mk8HYpFv2AIlLI9m0Y1MZZmas5Daox9ETtYxdyOiYMhu6tIww5dkTnsCEUBDJ/rxFE7iZwoPLJfFXOuwvk9ude0aNJmeH2unBh8tgC+bw78EWV9AwykGdOkvTk/t/rdZDSPwaWH73yt/rGM/Zu47M4Z8yqqK78bq8Z4/N/sN8k/fzwOE0kNjhI/twRfkfy8nqPxyceLE9qjN6wuAgQ0ZOnkvT8/gyLDoVZJFP9Ap7hs6g5JBj/z5VpikD/h9/5Dvp3wuEifm+GYQlBv+4CNs8oZnvvJVSfbpysQ0/YMU89g5U1XBDqrWsYXc4shFzCPIX7Peh6l0vDlUcoPbQF/Ts6DIqr4eQjEiQMgiGYm5Z9mfKKoQYpUCsc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 02:06:27.5491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 507dac35-a395-4ed7-cdf2-08dec114b8b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710
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

Use usleep_range() instead of mdelay() when ras_fw_get_badpage_count()
retries on -EBUSY so the driver yields the CPU while waiting for PMFW
EEPROM to become ready.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index f5fa80db91fb1e..59e195652e427f 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -72,7 +72,7 @@ int ras_fw_get_badpage_count(struct ras_core_context *ras_core,
 		if (ret != -EBUSY)
 			return ret;
 
-		mdelay(10);
+		usleep_range(10000, 15000);
 		now = (uint64_t)ktime_to_ms(ktime_get());
 	} while (now < end);
 
-- 
2.25.1

