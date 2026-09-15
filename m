Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6D6C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 07:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D85E10E91E;
	Tue, 15 Sep 2026 07:14:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZevA1Igi";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2474910E25C
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 07:14:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOyrHrLB38Oyzr5eqtOQp0jaSMndhlkcFPKZmpSJ+EbUj+NCCr1NtOSw1LZeyUK3T7aJEPUqjQcarHqA7RkDWvS6YoHMJFyoYczgvjKRy70Ro/yx1Z7MFHObOnXh15f2MpvDdJ4w+bpWhq56k6Q+OUp7eSl5GQEL3HpHao8FIMggu9Wh7+jBi9dTkkuSfhqRy5Wqs8zoEJobI2Jn7u8JcEbjeAJ0LrMnYvVgfDx4eYG1NbqwHsKoEdac/v8HTKFqjgAB+rDZ2GQbpO0MgK5Lvi4PMfNdZMoioZSBcS24RLWC9PgDA6kovKNJ3E4Oy2+SjyNuEjGtwBUYuW0xBAno9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ceEt0XzyMJhvQerGgnY8ZGgURHguDnOksOh1ybUxoM=;
 b=P90CDmLLTN7Qf1yyyV37gIps4IZwCH9flXVX4mGNzzm8BQ0jxFh10zhje9+yU+r/p709BfqHfrtQzvUpcpXMYPfopBfOBurcUmqE3AXh+uAgxgAqIc180jVK7blajkwVyjPWIUnp7sMSneTmTGFJQoWDjNTja76chCHFB2pbkZLpi9/zpgvW/s9cvk6VbdJMOHoCctTCPpOBbGd9Hwc9xH5zDyAoddnmzeYev7SfDuGRK4/HPSThJADwYnwoXOT1H6yAGA1u7Yf4FyKl7fFOophGkO5147OnghAyX3iV+tco5fb61TeMCYhslpggQr9fncwWYx7lOpJ8xu+Oe+RWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=atlmail.amd.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ceEt0XzyMJhvQerGgnY8ZGgURHguDnOksOh1ybUxoM=;
 b=ZevA1Igi+QSfxUKGzpEXXbbTAI1b+zmj3c+HxYYjWRhvIIA5KD+2I4yGx6HVgWbiljeWE90lEz9st+ZeF3jtaSPwHp8oFQw8OTOgcqV0ROC0azCijlSpvckopKvSjotFCFgm9T9g9V+2miXOuf/zNKN7P+Jc+1W/3mbS9y0wvps=
Received: from PH8PR15CA0014.namprd15.prod.outlook.com (2603:10b6:510:2d2::17)
 by LV0PR12MB259608.namprd12.prod.outlook.com (2603:10b6:408:3ef::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Tue, 15 Sep
 2026 07:14:12 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:510:2d2:cafe::41) by PH8PR15CA0014.outlook.office365.com
 (2603:10b6:510:2d2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 07:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=atlmail.amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: None (protection.outlook.com: atlmail.amd.com does not designate
 permitted sender hosts)
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 07:14:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 02:14:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 02:14:11 -0500
Received: from atlvmail01.amd.com (10.180.10.61) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 15 Sep 2026 02:14:11 -0500
Received: from sacetx8-emu001.amd.com (sacetx8-emu001.amd.com [10.162.76.76])
 by atlvmail01.amd.com (8.14.4/8.14.4) with ESMTP id 68F7EA55020931; 
 Tue, 15 Sep 2026 03:14:11 -0400
Received: (from jie1zhan@localhost)
 by sacetx8-emu001.amd.com (8.15.2/8.15.2/Submit) id 68F7EALe3906941;
 Tue, 15 Sep 2026 00:14:10 -0700
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <James.Zhu@amd.com>, <Shaoyun.Liu@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/mes12: clear event log on resume to avoid MES page
 fault
Date: Tue, 15 Sep 2026 00:13:10 -0700
Message-ID: <20260915071404.3906274-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|LV0PR12MB259608:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e9f896-f3f2-4850-68b1-08df12f8f132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|35950700016|82310400026|6133799003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: q18egNwBoPpCgdN3lreB1W3nXRaKs7pihbppN0RmdGN+B4KW9t6bdxQRPHwRLQSL7iapb6Ua2rLgywm2QXHPeLXMpPa2VOJvdS7RnxaRHmhfZbln2s3XJbYUEsVfpgC68xzcCT+ImjF2mvpryQWFzoCsA/YrmgVBIbElJptt9uDnSXFDXlPFGKXD7p7UPd53jPNf367UDA/7p1zPlvqOdz1ibcp9namyxLgPdvNbHXw98KtluvvKwGgj1QKtlFFQDVeyRlvJ73pi4ctuUjo0lC9oTZTH44GrJT0DZzTrswlP39F29E+QJL5ylfnwBEiQkUC3kUJcWRmdR+SfCcO+G9TBNdvpu4Vk4EWVWGKW359BLpR6yXDAyDLo6PCgM6FFUeX+KYEFupAko/gRb2OCHeACu6LO+yqXZge/rxUgSNrEbqeJeHeYS3X2V03fzG1/elZCpbc0UwocKJE7e3cuYB+CNshG6a/N3b3n29Iwzc90HXQtGpDwAWY9Ztb5wo9a8l7JqBPYA39PfzIo+avZWAecQ0lkZnwAUYZ8gyY+DBkm8Li5/zbCRbdEn6AWQgP8k/a6LNu0HAoXVdIPcZUow7Agl+xC5XjmunrH/Ar/2g+oquz4WObKUYsOECZ4s6rUE/H+/dh7oyHj+P+e8sOJt4RWFloXfyX0fJe9ualQ9cTkBuekDqMwTa/qkMJge0Wl1COBmTBMXwK5y9DCXCFrew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(35950700016)(82310400026)(6133799003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G0wrHB+9ZjAMYiCkjnEgPTKhkNZrk2XXdl7hrYbSBtCVbtvYE3b3SmuAkktWzBbqd8BRFMqF6fdSKmzmeNkTGQjFn/0RGbCaxSrCEmYXYJRSRM0npz87VTbOa4ParCCkdGUzl05Yuf4ovp4k72iXGCVobaKO1Nxm/xHpeDKO6/xtAHyNiq3mWF79QoVlSz1opbNNE59KE6O870RTbDOh8/AIqbaKFuffvrWrcvio/1v518RKLhCMICkTlligQl0PtcqUfcMHOUoUbGjA2eqc8D985c/lb7bESCN0BlYBvP5jjL4P9051BQ4ytZpXJwMweaAc8fOT+Pzf20FxQ9zQuh3u/cpEFgP2vGip4ondiShZmWf/64aXO7JVDwaoeyGrfcXfmsqNUMp9ReTAIr9tbmBjcVAL6L2i17CHOLMLgWbRFbBNIM8BHz+4aKjzWtGH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:14:11.7063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e9f896-f3f2-4850-68b1-08df12f8f132
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB259608
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

The MES event-log/MSCRATCH region is only zeroed once at sw_init. On the
resume path (hw_init without sw_init) it retains stale data, so with
mes_log_enable=1 the MES firmware walks stale pointers on activation and
triggers a recoverable CPC page fault:

  [gfxhub] page fault (src_id:0 ring:153 vmid:0 pasid:0)
    in page starting at address 0x000000855c237000 from client 10
    GCVM_L2_PROTECTION_FAULT_STATUS:0x00000B33
    Faulty UTCL2 client ID: CPC (0x5)
    MORE_FAULTS: 0x1  WALKER_ERROR: 0x1  PERMISSION_FAULTS: 0x3
    MAPPING_ERROR: 0x1  RW: 0x0

Re-clear it before unhalting MES.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index ee72afdb0a1d..9e149cf98889 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1306,6 +1306,17 @@ static void mes_v12_0_enable(struct amdgpu_device *adev, bool enable)
 	uint32_t pipe, data = 0;
 
 	if (enable) {
+		/*
+		 * The event-log/MSCRATCH region is only zeroed once at sw_init.
+		 * On the resume path (hw_init without sw_init) it still holds the
+		 * previous session's data, so the MES firmware walks stale
+		 * pointers on activation and triggers a CPC page fault. Re-clear
+		 * it before unhalting MES.
+		 */
+		if (amdgpu_mes_log_enable && adev->mes.event_log_cpu_addr)
+			memset(adev->mes.event_log_cpu_addr, 0,
+			       adev->mes.event_log_size);
+
 		mutex_lock(&adev->srbm_mutex);
 		for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 			soc24_grbm_select(adev, 3, pipe, 0, 0);
-- 
2.45.1

