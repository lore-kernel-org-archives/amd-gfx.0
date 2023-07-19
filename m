Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D68C0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 05:20:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9967A10E3F8;
	Wed, 19 Jul 2023 05:20:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 886F810E3F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 05:20:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnxdkMepAhmQa0ZiD6x09q2qYmzmaljM3f75Dcljrm1KZfQcXENi5JKkS0SgSPXT/VnGZ0V9X0WSZ0MDYnqg4ECzHKcYh/p5w4ndxhZhJOkTmZ46Ica1b3IlidKnEisg9NaEKaX0WLtyO06bz3HJq3lxPlLXZ08DZkMexZVGcjYU9NSCeX/o4jmzPRHNpASziYhdUHVy66e/s631RuZ6SkXgkr4v8wv/37agd3b1YCZpD7orhs6ld3SYcD3V7TgRv4v5KDHPcZ1c59aVhmN3qyhFU8Myda2C+hNsByaZ75bOZExMuZpIG2Ud3U34AZOJ1DqD9E2hRLiiMmVJNzD5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=co9IG51IfWYQQDF55Z7W8UtX8r3NV113t390eUkMUEU=;
 b=mhm6wf1G2BDdsqYFQ9h7z2DC2eOjkUO65qIRRtCslODrzBWWs+JsSAwpLujtSaKL0FQp4sCaQ8AiwrMysH9prg2aXc+uZcQTZTGkFgy3CnLlu5au91jwMIkLlU6ecZ3GcV0o7L9lXSo6gkHminQAqampAfq8tMJX9Q5Q7Ru31ZjPw887oUWbs/V6hwskqI7su9W7PXTm+irv02ocyO4G/sTtCAUYOL+M2gyU8CUqtMzwau/XHfa32+/E76BpU776X1Lnghoz0vuNlDJS5Oj/XBwcRz59lvDeUSTyeYA1iS39GTXIjMLQlJTjSvTUybJPNIlt0G6xIR6bPpvYVtSqNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co9IG51IfWYQQDF55Z7W8UtX8r3NV113t390eUkMUEU=;
 b=q7W7lBhChrqOJsZWEU+BG/jz6BlcvGO7PV8zdAaOjikeHnEu53h9k33Ke8ka+TuLIIJUUBMLG3G7RI7hTXxWx2w+e2hMT9uE1we7jnb0l/yZ1qcjn7Lzj7Hdy8Nrr3Ck9CrngDExRuQdDt6TxdwRwCZIaZD1guNMpHlssfIwkZs=
Received: from BN8PR15CA0021.namprd15.prod.outlook.com (2603:10b6:408:c0::34)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 19 Jul
 2023 05:19:58 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::64) by BN8PR15CA0021.outlook.office365.com
 (2603:10b6:408:c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Wed, 19 Jul 2023 05:19:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 05:19:58 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 00:19:56 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/radeon: Prefer dev_warn over printk
Date: Wed, 19 Jul 2023 10:49:38 +0530
Message-ID: <20230719051939.811520-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230719051939.811520-1-srinivasan.shanmugam@amd.com>
References: <20230719051939.811520-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: e95fd642-b75f-41be-e21f-08db8817cb9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAE4Zogq80gz6WJaNq4kgvqOOq5EhIkEpjXw/DCUPUdQO4ANLe1QiPmHuAlLjwhT1QzWfAyZarHjVVyfbX3RmUPmb4kLLicSCxbXOMOls7eazOI02PrKNpV/3JhCF8vWYR0nkMHhIrww7Ou3VwJzkZ72deXA5iclSTPGfUrh3V3YjCr7CljQvim7ZdOPo8g1o32VWxmd+9wkTMJBR2cxBaLt+6irbiXcVDyjgsM3K3ftHBaAw/cG7mOoUDKFtnRDwTuT+XRd/lszvmBA1tveGjY7V9uxZ8PHptPOiqhXmvgTc+O27UCTWBr3FueuM7ARbsmcuHdtH0rFzcfZlAd7c2pv0t2Q5rjOt2e+9kgC4FjcVNSDPcVAaeKDy/4uXidZExK+0pMf77h05oYDlJQEMqrpzbPZLPDU20Ovab4755jkOTxF7GTNvErol9qI5q1dFLD0UDoP9ibaf2Bz//MvxyXZXEKCHzSDGbWhAfT0o0z1ugZqsBJW0gXF682IAr3bciPsKBdiQ8OQm4iOUm/J5zLXacjsgRmwSxFarteiVdHYXAZs/60T9STgYrk4cVbhi4lwiTa5BtNpiiozSvVXgeUYnaruW5FH9xJc9fwDBaxl6NOtmXFwIyzVW4jU7yPJjALHOqkn7aXF9dBbUNpd32hxvgoPPlliqcz6/uIFwA3UoObOaIuDKAXctohFpn8Vik9ipVGllr929ZQJYPHXbLv6RErkyuRKMuzHEk/UpwThvKOVy/xnjGnM1fcC4pPoQXLNVO+ZnP43DU60a25M5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(7696005)(4326008)(70586007)(6636002)(110136005)(70206006)(478600001)(1076003)(81166007)(82740400003)(54906003)(26005)(356005)(6666004)(41300700001)(316002)(40480700001)(8936002)(8676002)(40460700003)(86362001)(83380400001)(5660300002)(44832011)(2906002)(36756003)(66574015)(186003)(336012)(2616005)(16526019)(47076005)(426003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 05:19:58.4360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e95fd642-b75f-41be-e21f-08db8817cb9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.corp-partner.google.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.corp-partner.google.com>

Fixes the following checkpatch.pl:

WARNING: printk() should include KERN_<LEVEL> facility level

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/radeon/radeon_atpx_handler.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
index d0b450a06506..875a995fff66 100644
--- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
+++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
@@ -115,7 +115,7 @@ static union acpi_object *radeon_atpx_call(acpi_handle handle, int function,
 
 	/* Fail only if calling the method fails and ATPX is supported */
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		printk("failed to evaluate ATPX got %s\n",
+		pr_err("failed to evaluate ATPX got %s\n",
 		       acpi_format_exception(status));
 		kfree(buffer.pointer);
 		return NULL;
@@ -171,7 +171,7 @@ static int radeon_atpx_validate(struct radeon_atpx *atpx)
 
 		size = *(u16 *) info->buffer.pointer;
 		if (size < 10) {
-			printk("ATPX buffer is too small: %zu\n", size);
+			pr_err("ATPX buffer is too small: %zu\n", size);
 			kfree(info);
 			return -EINVAL;
 		}
@@ -202,7 +202,7 @@ static int radeon_atpx_validate(struct radeon_atpx *atpx)
 
 	atpx->is_hybrid = false;
 	if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
-		printk("ATPX Hybrid Graphics\n");
+		pr_info("ATPX Hybrid Graphics\n");
 		/*
 		 * Disable legacy PM methods only when pcie port PM is usable,
 		 * otherwise the device might fail to power off or power on.
@@ -239,7 +239,7 @@ static int radeon_atpx_verify_interface(struct radeon_atpx *atpx)
 
 	size = *(u16 *) info->buffer.pointer;
 	if (size < 8) {
-		printk("ATPX buffer is too small: %zu\n", size);
+		pr_err("ATPX buffer is too small: %zu\n", size);
 		err = -EINVAL;
 		goto out;
 	}
@@ -248,7 +248,7 @@ static int radeon_atpx_verify_interface(struct radeon_atpx *atpx)
 	memcpy(&output, info->buffer.pointer, size);
 
 	/* TODO: check version? */
-	printk("ATPX version %u, functions 0x%08x\n",
+	pr_info("ATPX version %u, functions 0x%08x\n",
 	       output.version, output.function_bits);
 
 	radeon_atpx_parse_functions(&atpx->functions, output.function_bits);
-- 
2.25.1

