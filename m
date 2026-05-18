Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D765ACD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 06:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7117010E690;
	Mon, 18 May 2026 06:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1qiQUQtj";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99DB510E690
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 06:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLIr0ZRLjc0EQ62dLPc1xnykPCDX8vSIuQu3Pjo/kusMF7TvtposOdmEYrjPYe5z4taWze2zTjx7lvR+fuyXTAs6T9B3FcDPJOLs58Tjoj8xUd0heeejchSMgYLdPzaKONnL4/oef644m2+lcxucGOMutWN57jg7ndcTDFoJGKOXwgNvUfF3kj9p6yQ/yN8JDvpC/6Y97B4KY0VZEVgt/WDV+DGsO9ZGFd8TV+HcbbWzgeDPkPQ4U+/lcqrdnl90i9MQOxAM0KUs43WVdv1yQnj8a7o1zV69Qqy3AdMma9Eh44FKisetM6cK5W7vFfgEwPOeLEeXg0MdGjBcXQ7wfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woc/Hq9wimUjF51q37uqGIGNhiQ7hN63vw8F/PSy7lE=;
 b=BQDvbNlMGBwwqF+2zDSYvFsrZXq3w+fupVek/v2Lo8dazDAZygedVH+Su2GTesZu4zF0JJ8cWoxOlkMQX/cl6XKiaFa2AfVfIGSFMO9PZUZjrt1vEGEaVj10+Q3yqrfeAlw6FQG5K3yzFXxY4zJeW23/Hk0JHl9/Wn+Zr7lsY/2i1sGkoay1MJDqBHFupUvhEr+muQIK/dV4X4hRt5EBqqIQaHym3xbr8PAp3ud/HLDZhllQI0gGJPimvIeS9DhnmY4hoJ1srKdots3kVjVXFsyk4kobSAToRFKnqQI33AVTAe0b24U9S89/5Uxw+n15DtNqRyggrHiScYlx055b5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woc/Hq9wimUjF51q37uqGIGNhiQ7hN63vw8F/PSy7lE=;
 b=1qiQUQtjvWPmH+HDqmXBOEaSS3DORyE84qFFrcL1DbmGy0RmyvLrHRUVC3xfyzFnMa/phWCQkF3KnrSQ1SmpujRDIUUS8jDhi8qX49qgvWP5wP16OrH37F5JkZhTtPHVyrAqOotPNWEIaYu/eUllTMDnlOTjJSfSnLftynSmmKM=
Received: from SJ0PR13CA0008.namprd13.prod.outlook.com (2603:10b6:a03:2c0::13)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Mon, 18 May
 2026 06:51:03 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::6) by SJ0PR13CA0008.outlook.office365.com
 (2603:10b6:a03:2c0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Mon, 18
 May 2026 06:51:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 06:51:03 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 01:50:58 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 3/3] drm/amd/ras: Fix UMC error address allocation leak
Date: Mon, 18 May 2026 14:50:30 +0800
Message-ID: <20260518065030.2311-3-xiang.liu@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518065030.2311-1-xiang.liu@amd.com>
References: <20260518065030.2311-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: bed9964b-f5c4-48ab-d471-08deb4a9d3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: ArXGM1hyxnlr/jYIDJmHuZ/B1rMEVR49DFoeHampDgcwCQj45emrxEGXx9Y2EHYuwcO9wj7XXF8mYVt1S2ETLAVeKEF69vSV+BoWiaaUM1kTkNcd7nM/fP0Otru1lPRygL+6tKedPXGen51UMTg9FCmgvZ+VUcdS3zb69GLoHCgUjAFOgAPfOoQ1x2KZdF93UlpGCPoUzQtIYbkC/ogTCSWRWD/SYROvj2clYIAytDi+5wAIwiuDTwZHaouosn49VgZxW/kVSjWKhAem6nSZMBkmbtcgPlUTemXGDI/L/mTjuJBAd+Lob+9sqFRwtH84pyjkNpv/sOIQ/dCS3Oo8LzsTuJ531sfWO4SmJkLjrwCW8xEctqLb4eShy57rlhtAttHxcR9KxAd8rJ6sf1JIyplVtZ2Mz9ADmTStQHHgpi545p96bW8eIZV3r+fjkH9uM4vmtxATFIoaS72Vuvpfql0sizB3nYXBMRcCacmT4JZ78tDoUJzylQ7hsMoeyRLGhOX8r8d+A0TlawCIvK0owGO2m9M2lsaRIuTJ41BtLWI7krj2s9jkNWN8LYufU5l/ORGChlF833RKQbM2kYNYp+zOQXxhp2SMn7drEm6KpUrQBNTTUuTC+hAfEJYE9gWzON3GkonWsyFmUSFtEBEGDiArFvRheqiqYxrmgWjSfgjovL9NbecixJ6Tzx8mPd5FfSY+uxQHbXZsVc1ie5oiXNdhez9smWGaT9LReGxiwY4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hbw+1427utdYZ5hbfa0UTYKJtEX+ZgBMnVyXl7Opq/37alARppLPnwRiBv6suUxy6X1CCvf1Rs693uG/KC/NiOyPG1Q6YG3SbwNQu3pxo05RRatmxxgCbKoYSyeU1e0N3tOPgadvvEt9V2dn4723l18BibbRbFUXQYAk9Tqfa26yaoeWQw/vDupew4FpMRsZgqAGguKC3ALpI5pAzih3uZ5txK00LFGPfIFnmUXlZmJThHpCIqM04ImMsYKAyvUkVpSyE1rqch1N9/Fs1yta0hNHInioVDGF0TS9UJvWDVnCIq7E3wE0uQrmSdtzcwsWirHkyz1zIuoufWTBDuQFWOjW5l7CXce2ZjKJuNXAtbCdRhp5hpcnmEeGl8Z5MhwuepdPyVjNMElVYqdlnRUDZ0lR90cSTagsM2zPH0xv83AVeOvd0kcTnR1G6S6v4OwU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 06:51:03.0596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bed9964b-f5c4-48ab-d471-08deb4a9d3f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
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

amdgpu_umc_handle_bad_pages() allocates err_data->err_addr before
querying UMC error information. In the direct and firmware query paths,
the pointer is reassigned to a fresh allocation before the original
buffer is released, so the initial allocation is leaked on each handled
event.

Free the existing buffer before replacing it in those query paths so the
function exit cleanup only owns the active allocation.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 1be722ba6c9e..a250109edb63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -130,6 +130,7 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 			if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops &&
 			    adev->umc.ras->ras_block.hw_ops->query_ras_error_address &&
 			    adev->umc.max_ras_err_cnt_per_query) {
+				kfree(err_data->err_addr);
 				err_data->err_addr =
 					kcalloc(adev->umc.max_ras_err_cnt_per_query,
 						sizeof(struct eeprom_table_record), GFP_KERNEL);
@@ -160,6 +161,7 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 			if (adev->umc.ras &&
 			    adev->umc.ras->ecc_info_query_ras_error_address &&
 			    adev->umc.max_ras_err_cnt_per_query) {
+				kfree(err_data->err_addr);
 				err_data->err_addr =
 					kcalloc(adev->umc.max_ras_err_cnt_per_query,
 						sizeof(struct eeprom_table_record), GFP_KERNEL);
-- 
2.54.0

