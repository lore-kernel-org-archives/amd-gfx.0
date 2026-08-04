Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FEFC55822
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 15:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C089110E17F;
	Tue,  4 Aug 2026 15:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dQk9h+dQ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E90410E17F
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 15:03:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GR8UMcB5Pzy7Mwu31xse+0TGavvKva3GJntmvUFq4FlTFab7eyHdwkyF9fAtVOjjHoHYFAG5v+lqKTCcVeIfqFyOeHBcAQjyOqshERfJNb28lysR3fZJje2GblUickTORdTYPcWpeujQFRVqRfT9XT0fbcOpHWiLdTHYuW9FbljiXchHwhewfYTg/YHoFvXBlrMACyy7UjgTxxwYcKsyB+tgerH+ZLP5ZgvPOSifn5exX1kqeg4eFodwVIYvvYOzZl4u+K2sA7XXm1tklzxgaECYoTDW93Bd3ca3xAku15MBSgfw4Xnw0lu5TRLQrTBhsuVS03h5T1coF5KGPndnnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRsCtw8UKJGF7eHJ/doc0LA/kZMYHdzxky3fSDCayhY=;
 b=JB8jjf1MdPilK4hiGHl3F0WBaXvXtfPgXFP25FTEiVQzS6uQCFhzdszEpK3zuVj9Ocw14pzIV2IduMXZsgYb6HxaZBKY05W3aCcuHVntXQJenjmgkLxxeu0Nlh3xiVAxCYVbI3NUk1eKT8b1KV60XeJAK+4OSHBiKsaWJ5SDqbcRPC4g3dmoeCPqYwnEPJXmLYrt2u1yiitq8Bie1YuwfIO4chxHtukuCDjM+3fYE3MPmPu8V2pQLWvGBjRuO1++2sQW8fIX8ICZqgfewzsoB3fhfS8CX5H59aMXf5yRRn+i2J+QfhLtT0S5ZKhmvwmNEGOQEu+2Ff6UzVc34A4M2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRsCtw8UKJGF7eHJ/doc0LA/kZMYHdzxky3fSDCayhY=;
 b=dQk9h+dQ00G1/ARQ4/e5wJ7leM+KLY5SiE0JxDeIfZE9raY2K1+QkPcpCjJU1GSA283+0GMcWySVDsP9AvSO1SMf55tV+muL8SRxYQaa4sur9VWIQzgttVkQD96qPyLD27Vu/tlRLFDt2jxNkWeqU9raG01L+wg3rFAP3H5hh0E=
Received: from BN9PR03CA0562.namprd03.prod.outlook.com (2603:10b6:408:138::27)
 by IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 15:03:40 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::45) by BN9PR03CA0562.outlook.office365.com
 (2603:10b6:408:138::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 15:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 15:03:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 10:03:40 -0500
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 08:02:51 -0700
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH v2] drm/amd/ras: track debug mode for query mode
Date: Tue, 4 Aug 2026 23:02:02 +0800
Message-ID: <20260804150202.1132488-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|IA1PR12MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: 63018b07-fd2b-49d1-b881-08def23991b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|18092099006|18002099003|10086099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: jEZUM7xqX68rk2vPPGNA+7sf5z4842EfpfXn8v6NURTnwgcMOHUXYdOe3lZ8Vol2noyCXANFI81wCqFwpGdIMLR1++sv/YbBVzV49WtKUqYigDzdkDxmlSBN+FEQsmea04ucKrzRQMp2IXg8I8LEETAAQUKsN295gTzTg1vcgqb7UoMmijL3jRZj51aQw8pH9fhTL243lqzL5cyNYc/wHFaHFXgdcgwz0tLaDCuHbcXIun7KVou4gb+GWOa0VSRE+jr69r/gskXn1J3XTPf4l9OEM37h/PI+YK8RadAKuACVjB5MFiA6Aj7AF2mZ0WrfZoErHFUvTMicMLqJLi0h8rthxMR1AxtFxhftFtVSzBarnJjkWjN6KoljeeXtWNI0YqgN3dAikULV7Fh9d7H/J9/+dmfnqWjUUOoB2FV2uNZGSsk9RaMh2/YvX0qOpNVcwcQomffDy5vgTGiCXIYtwHh9n8Xf3lraZmhyNiWjbf4V2JcYu7H5q7bS+q54oEOGrBJU8QaTilaCBK+8Bpx0w+U6jpPesVc3HkuU/EslDObgf+eP+II+iyJgBVmVjxV34QokXfFLbpbIa0cY552pOE8hl3mQaE32Gvp3Uolej9Kx58Dnqup/NR1lkncImymqJMbIilOrvmg5RUVoc35lR1ngQqEwRnIf1yUcvmzdg3qZZ0CIm+tvlAy0+EV4iL85D31CYnfCn+3g9nkugZbM0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(18092099006)(18002099003)(10086099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E0QRRnT5ee0ajxPLSMwZumdtoEk/Q1JHUttr6ye7RmXWh9wvZtndYf4627BRp5o4UmbkbIHktOWSt/jsmTdtBNU1DXFj+RiP3QnZj/PNnpDoH1jBozzrB1IQmPLPhpKvE9vjPaF8Ri3aEjjACKyiO6wKpi0MkHX0/xmLQ+rPsfA7Ug3/BBbgeZ7HSn6ksjnWPJPqsuEoospcI0gYyW1/8+wfqGImEhAKoJaARDpLP28RZdwX+MS1mBZPSdyDFzhOTh7afpNdiVyNeXV27LRcCmOq2yputzPTUTIH4dnUCyG9/RVAeFI5C9YRo6drtpbdza2S8Pa5Eun4+M9xfXMxWsQNRb8XBe83ycj6OCTJQSYwspXuzTvi2q/cRzgfajZtQ5w+M3FpG2t3Ck6VbkKQTcl65hHQt0htj7cusGUaNO0yQ8BZ51lfwrVfWleCZldC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:03:40.4418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63018b07-fd2b-49d1-b881-08def23991b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8311
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

The RAS manager uses the rascore debug mode setting to control whether MCA data is read directly or collected through PMFW MCA polling and ClearMcaOnRead. Track that debug mode state in ras_mgr so amdgpu_ras_get_error_query_mode() can classify queries as direct or firmware-backed.

Limit the PMFW polling wait in recovery to firmware-backed MODE1 fatal recovery so other reset paths, such as MODE2, do not pay the delay unnecessarily.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c         |  7 ++++++-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c    | 17 ++++++++++++++++-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h    |  2 ++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index d247d0ad063f..8ef427b91b72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2756,7 +2756,8 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		}
 
 		if (amdgpu_ras_get_error_query_mode(adev, &error_query_mode)) {
-			if (error_query_mode == AMDGPU_RAS_FIRMWARE_ERROR_QUERY) {
+			if (error_query_mode == AMDGPU_RAS_FIRMWARE_ERROR_QUERY &&
+			    (ras->gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MODE1_RESET)) {
 				/* wait 500ms to ensure pmfw polling mca bank info done */
 				msleep(500);
 			}
@@ -4430,6 +4431,10 @@ bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
 
 	if (amdgpu_sriov_vf(adev)) {
 		*error_query_mode = AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY;
+	} else if (amdgpu_uniras_enabled(adev)) {
+		*error_query_mode = amdgpu_ras_mgr_get_debug_mode(adev) ?
+			AMDGPU_RAS_DIRECT_ERROR_QUERY :
+			AMDGPU_RAS_FIRMWARE_ERROR_QUERY;
 	} else {
 		*error_query_mode = AMDGPU_RAS_DIRECT_ERROR_QUERY;
 	}
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index ea95e0f93d1c..61faa1b2d4f0 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -798,9 +798,24 @@ int amdgpu_ras_mgr_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 int amdgpu_ras_mgr_set_debug_mode(struct amdgpu_device *adev, bool enable)
 {
 	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+	int ret;
 
 	if (!ras_mgr || !ras_mgr->ras_core || !ras_mgr->ras_is_ready)
 		return false;
 
-	return ras_core_set_debug_mode(ras_mgr->ras_core, enable);
+	ret = ras_core_set_debug_mode(ras_mgr->ras_core, enable);
+	if (!ret)
+		ras_mgr->is_debug_mode = enable;
+
+	return ret;
+}
+
+bool amdgpu_ras_mgr_get_debug_mode(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
+
+	if (!ras_mgr || !ras_mgr->ras_core || !ras_mgr->ras_is_ready)
+		return true;
+
+	return ras_mgr->is_debug_mode;
 }
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
index a20bb8fdce87..b81fd88fca71 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
@@ -53,6 +53,7 @@ struct amdgpu_ras_mgr {
 	void *virt_ras_cmd;
 	uint64_t last_poison_consumption_seqno;
 	bool ras_is_ready;
+	bool is_debug_mode;
 
 	bool is_paused;
 	struct completion ras_event_done;
@@ -86,4 +87,5 @@ int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device *adev);
 int amdgpu_ras_mgr_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 		uint64_t addr, uint64_t *nps_page_addr, uint32_t max_page_count);
 int amdgpu_ras_mgr_set_debug_mode(struct amdgpu_device *adev, bool enable);
+bool amdgpu_ras_mgr_get_debug_mode(struct amdgpu_device *adev);
 #endif
-- 
2.34.1

