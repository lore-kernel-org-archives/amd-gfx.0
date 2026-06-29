Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD378C43327
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 13:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 343E210E8AD;
	Mon, 29 Jun 2026 13:29:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IB/nUbFD";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012039.outbound.protection.outlook.com
 [40.93.195.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A0F510E8AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 13:29:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oq2IDPYtDAhYOwBjSTH0Fbkdq6hknftG4CCQOiajQWol7wTXRiD3XC6dw7bKg3n4JAwBttj8D1xuIQihC+0+xtTKlVnT+LW/TUVmMf3qgo0n5FYEdwZ85UapbTdPoRdxyRHzfXOB7qf0fXPLrPvFRnTzKzBczKvgHi0ge07n+X2BqFWeTbZiVWakonMxtdlMJJN+O6q/vDJxbi2C4V31PYZcyPslV+iWjhzkRxryac7zyfLCppLdBac6ZaYqt+Z/7nmvwF9hf1h/N7xGoVUy8HIPMNTBuZQ0Snw0T5lWr56vx2jwBdf4qHjLUl9xPfEI/MGeQC+VhbJt0+1rJNblvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qk9AzrNr6YcXOlC7Of1jZ+VYK9aQA6Of2p4R5/axi6Q=;
 b=bVe8y5EvKKx1f1GG94Sb4D+GVwiMASKnZIXHHHgE0pt7pta39fxKod/7/FpROZO22wmShmk8imbY+eDfDck+IbEl8ZM/f0AVSniY/L2wKOyVdV4kOzbqUM+t3Gn3NE3HnNjC1f7UxiBgJV5nBle4p8+lR8rwKE6Pq7SW/eC73l3+Ls5gWaQfZsJn5/w9Iq9wF8y8zLrWl1dikB5gX6RVt8vvsfOdwmN2hwkiErVMzRmKJwHFt+RAcd5bGGq37RZrnmcMJ/Eyxbl/ERq9fV+4Q7i8/d2Hx6IroWQm3ESdrCwoDkzbZ+zJezO/QRtmqWePM2+ee7aQHfzrFQs8GZQQtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qk9AzrNr6YcXOlC7Of1jZ+VYK9aQA6Of2p4R5/axi6Q=;
 b=IB/nUbFDWvtFIi0LY29DYD2ggZZnvXeGIcoVZKrcid48kC7gEIhrTW/nGiSPZnzTJirkThaaT9LUERotfSFHj3Tbnk1LRxlLiZpkdcY6MwVx2pB1lNEfRPe4FVv4iE9pJnTxwLG1ygvGiiR2dXv3yteuVvxfsch9bjv5POygQfc=
Received: from SJ0PR03CA0289.namprd03.prod.outlook.com (2603:10b6:a03:39e::24)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 13:28:53 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::2d) by SJ0PR03CA0289.outlook.office365.com
 (2603:10b6:a03:39e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 13:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 13:28:52 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:28:51 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>
Subject: [PATCH] drm/amdkfd: Use kvcalloc to allocate arrays
Date: Mon, 29 Jun 2026 09:28:37 -0400
Message-ID: <20260629132837.2288044-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: c83382ef-47b6-48b6-aeaf-08ded5e25c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: DBjHn1O/JE3pwuL5L7gOZFNf5D7qSh1bDccKuPHc0/19MYFDPTRCK0ZYbaZWvP1jZgmBVOL++hDKO8ZnmZyudopL1prhVKhT8sTmkWsZswTq6ZvkSeJ5iZlCLyMLM3Yypfrs1UbCBkecdrYMNQQL+UpkFhG2W14XCYS5xqlar8LIWs7Tsvf23f4tdmM6vZ/7jt+Y9sxhH2o9IgjRYHs+fWDwokKpjQPUa4oYR8LOLfOgRP17Wo1wvggWyHQVjxaj/EkeQ4gb1bgw68DqgZnF/aNOGnqHd/9ad+uYURTMB5HIzp+biYAlWAlbpKFjtc9PNgysEPg2AL6BLsi9Y+tR2ZJnRGPkQqufG+IlD45xIYC0Om3kAf3LJ2eZzKLTKYons+Up8OFOECOAalM3rLAy5rgQI96LOZwrGXoytWKc8tPWfxQvnnmCM0kK0SzBiNuLI/yUxxhgQvLZtcmQxaW2A515ju6aIwp8xUN5kSxL72TxLyQJltWDlIxUk6z8ua+19LB+4lOnVngqupuKZE6YIXa/L1X88LTazmVKC53zSzL+cj5R1SFOme2wNeSh9TtAvzDZ2+AATt6f+mnD72qWK2H8+tOsqFAyMXOkR6B0fep+/Yc0djSwOVQI2RSZE7UXjoPfJ4hBmKiD0Vk0Tq6U++dNZJK+4fsP2H6wcWuyL7/5eShiUncjKrrviL8F0iz3hRkK9Z7An7EkCsMvMrn/LQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 226M8TTDYMK1Kwy+CVmFf2rjriMPHlKfY5mOZB88fp8si/uLEaXFWI5cv5/vVRzpgGH7Ft9DsVCwt8fUVq+vLBLFuJsef1m8ibeuJuSeHF5YezIatQkoLRyDe47ZmAgEstNU5uUnpFT/J5qPI7VntdhvAJ7edsA+WnDUiY1njE2aXW5wXIt0s/cjKo3SW2bRkOXZf3riWA73h+z1UrPIOZDy0NlqQGFpT++tWT/ppoh5wQjYKRphNZZ1X5kLOTxZqgpeoJK/L4lQi6xSa1PAN8reZ8IE6NkIgjYzOvBNiCuSKaiN7bMeay+T1P330eLrj9tFEDQj9KQ5Y9dROypAsyqa+YxcyPE+zJpgpZzdTE2H/eAMSoGtxW6A02A+D1LRqKO95v1uCiHUhDtOIoZ/h6E2bhD65mFiaaBDjxEm7rvTrGyJI33XSs4yBXgYoPGL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 13:28:52.1193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c83382ef-47b6-48b6-aeaf-08ded5e25c59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374
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

There were a few instances in kfd_chardev.c of kvzalloc being
used to allocate memory for an array.

Switch those to kvcalloc, which
- is the standard way of allocating a xero-initialized array
- does a check for the mul overflowing

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index ab9e53dc8deb..7d8215169c10 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1917,13 +1917,13 @@ static int criu_checkpoint_devices(struct kfd_process *p,
 	struct kfd_criu_device_bucket *device_buckets = NULL;
 	int ret = 0, i;
 
-	device_buckets = kvzalloc(num_devices * sizeof(*device_buckets), GFP_KERNEL);
+	device_buckets = kvcalloc(num_devices, sizeof(*device_buckets), GFP_KERNEL);
 	if (!device_buckets) {
 		ret = -ENOMEM;
 		goto exit;
 	}
 
-	device_priv = kvzalloc(num_devices * sizeof(*device_priv), GFP_KERNEL);
+	device_priv = kvcalloc(num_devices, sizeof(*device_priv), GFP_KERNEL);
 	if (!device_priv) {
 		ret = -ENOMEM;
 		goto exit;
@@ -2043,17 +2043,17 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 	int ret = 0, pdd_index, bo_index = 0, id;
 	void *mem;
 
-	bo_buckets = kvzalloc(num_bos * sizeof(*bo_buckets), GFP_KERNEL);
+	bo_buckets = kvcalloc(num_bos, sizeof(*bo_buckets), GFP_KERNEL);
 	if (!bo_buckets)
 		return -ENOMEM;
 
-	bo_privs = kvzalloc(num_bos * sizeof(*bo_privs), GFP_KERNEL);
+	bo_privs = kvcalloc(num_bos, sizeof(*bo_privs), GFP_KERNEL);
 	if (!bo_privs) {
 		ret = -ENOMEM;
 		goto exit;
 	}
 
-	files = kvzalloc(num_bos * sizeof(struct file *), GFP_KERNEL);
+	files = kvcalloc(num_bos, sizeof(struct file *), GFP_KERNEL);
 	if (!files) {
 		ret = -ENOMEM;
 		goto exit;
@@ -2584,7 +2584,7 @@ static int criu_restore_bos(struct kfd_process *p,
 	if (!bo_buckets)
 		return -ENOMEM;
 
-	files = kvzalloc(args->num_bos * sizeof(struct file *), GFP_KERNEL);
+	files = kvcalloc(args->num_bos, sizeof(struct file *), GFP_KERNEL);
 	if (!files) {
 		ret = -ENOMEM;
 		goto exit;
-- 
2.34.1

