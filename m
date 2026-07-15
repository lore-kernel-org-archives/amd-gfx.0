Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62F6C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 07:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58ADD10EF03;
	Wed, 15 Jul 2026 07:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vLKp0xNa";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011002.outbound.protection.outlook.com
 [40.93.194.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2FE310EF03
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 07:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCn5GVcF2fCDFIFp6pRzTkB2p+w6rrSBfHG/uqHZC6KncE7886lTV+z+m9IqIwwbz+EB9oL/bdJ6Nc4XEEixrX4cd5Bxk984/Y8Klujl5bmR3TiHJEwL4sGEec57mwNMdEhCKghJlSyjOCju9Rq13hh6BpVBdO1StzKPyk8a1wJvxnB+VLCIgvQ66J56tuHeXCez7uRVXvFQb4K14lH2Cf8Q+e27S8ERKSkPDsO7QRZms7k+Gfbw35gyeqyvTTo7tZ1YE0puy8o4ZL26/i0D8bKvs64wMdzLycnYt5curfuEK7dQihAaVTvE7LA5zATi7j7fMnQwbRHZqTD6iscdqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVtxKApaimtjZe8pZzCvzNJJj4pNYlEhZdp4QhUJQME=;
 b=vDtE0m/PI1cU32Q0yQ/41gc45k4DNqVTFCQLqnpZJgRTaNrKr9L78C/7lYPlmaSbXPkoTiykSuKMT3TRZOHLQTPmHxn10PNvPkxDR+17/BuOaV+uhl1LyuoBVIsjfbujMdFkBSw/XrJpsEIboLlj7tik0aSqwHjFZ9QQztZqlbm1A6A/6GkNMmxZR22JMndIU1uiAD6CsrsZ8hzElzuv3sXQySj1DLSsz8QyhB6mL3vh0zsuxPaeDWrgM/dSED3dxEyfXIz1s+/MgNxiSGUiQs9tZG9qp8HjRFqShPoNvBb99rafvHRYUc+NsXDvwMmoLgXJKp1kbe6gU0hIdCPCUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVtxKApaimtjZe8pZzCvzNJJj4pNYlEhZdp4QhUJQME=;
 b=vLKp0xNaURcsF2vE8qjshud2Xy/pkUZydCOC7lWlS0OFUg4UOveuye3h/mIh79RgRfDZadfqEwUoKde7Es4KwPZuksYoHCXPCPwZ3OCquSflLOHIuq/EVB+kmupwinX3UC7ZO8zcw+wPap2HyLnPvzLjUwKUA8QuecruhM+ecQM=
Received: from MN0P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::7)
 by DM4PR12MB9734.namprd12.prod.outlook.com (2603:10b6:8:225::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 07:47:47 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:531:cafe::18) by MN0P222CA0002.outlook.office365.com
 (2603:10b6:208:531::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 07:47:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 07:47:46 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 02:47:45 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/5] drm/amd/ras: send RMA envent in RAS init stage
Date: Wed, 15 Jul 2026 15:47:30 +0800
Message-ID: <20260715074734.2668631-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DM4PR12MB9734:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a931810-8ff2-45ec-aebb-08dee2455c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Z+mS3uj0gMo8laWKTeZE5lexm7nC0nFYjGp8mYrFGLRtxyUAppiH2JG0+DrX+5IJznrTJK0HxwWWCNKS3IhaSNGYWbzdKXPk9ph89vaajjO4rwteIVqcUItDvh+yKtRNjobXsEjraOaGx0kcc3zvkMDbXB2dgBPMMIXbuhyqdGV4/yRFA61xBogwYCFXySwYOQTqzbZt23lJITtBEG8mSP9yBlxLYFpEKpeqxG1yRtGMYl8m3VHsfu1ni3wcqCqpRwzDVsmynCMrLqMZ2KVldeO7cpRIhIL+IpHld4rJnul8tSIfCmVh7OVBJdPXDIraihGV+WmoXConUruqR7YUFezWwC1Htg3h9TSdExgaWz/trzMfwJq/LVYhMpI9eIoM/P2MI0TnUnB+fuN4q1CG5jIyF55DBLJnkjRkPhIidABL7tJHpO3Upv8b3yeeE9VE6RWeB1WUGBXwmvnv5cUJsN76tdx7QsXibxIr7YA0Cf7Cb1XrDwMqDBJGJzqXeoE86/O5njCcngSVx8Ryj4PDnowrOxOJzgvEiw6z2kqlbfyndRpWRGaBQeUklvuDkKY18Z0wfed6Ld1khMXYBSb7evioolPwBj49V/2KCzU/94a2NpIiKxSdCCS3wok+4kBLFeHpNMPXukpgv5cJJF4vPOqhbiu/z5dhPwhrc0DeF+kFdqfnxz2s9ydwT5yQ2+AUIH/4HwkfXpQPCr8mS5/snw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 72s9WPvBb82dGYhOP9Hrwim8sarP1YhWlzy/fOaqJE8RFtwCgPRUupdNIZqjAP9mmSi4l3mYZ3L1dp/zxMTFzOdGcU5nVpkUVyzOMvrMG3Y0G4HYvx8Z3mzRs1GFtRfgl5lADMrqqsWhZJ5DZDSWZSF7c3LGYLkFDFyCk7XNYVRvDMl0hOVfvrm3DTvN0J5rDelNCuMqiD9pqYmeNb4qHZsx1SSQdtFPs4haTRevvs3RG6J9LjRzg6HYglia4xqAaHy83bzHOtyS1/eZcvu8PVAPTaQ2QUxqvX/yVb/ycxsaAV3pnm7vaib+jRSaEoAzHkVWpmlfn5nAlh4jzX33fu3V4dYe58XAsltsO9iA71Bx2hFEJQ7yK8RmJp/BNFrwWsZhqw/Yb1U8x30KsjgB/StRg2wZ9hORaM1yWxTGS/kZj9X0iPNx4MGTOA0nHDxz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:47:46.3545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a931810-8ff2-45ec-aebb-08dee2455c65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9734
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

Not only raise the event in runtime.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
index 62d1a319c08c..b9a60ad2890c 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
@@ -1258,6 +1258,7 @@ int ras_eeprom_check_storage_status(struct ras_core_context *ras_core)
 				bad_page_count,
 				control->record_threshold_count);
 			res = ras_eeprom_correct_header_tag(control, RAS_TABLE_HDR_VAL);
+			ras_core_event_notify(ras_core, RAS_EVENT_ID__DEVICE_RMA, NULL);
 		} else {
 			RAS_DEV_ERR(ras_core->dev, "RAS records:%d exceed threshold:%d",
 				bad_page_count, control->record_threshold_count);
-- 
2.34.1

