Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A95CF6499
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 12:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA0A10E093;
	Mon, 30 Sep 2024 12:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5SatAO4c";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5E8F10E093
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 12:00:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOoQ0AntaQ+2oOlYKlgIacxacL0cRhHPJqjUGVYbfaZ//gPvqTPvwj05D3WIDynZejwSsKRDbragcUXs+WMAufziOeDK3jeHVxF9JCbBfzjJop5wKj7Vh8YTb2M902CQgapdqwg+vpnNs1AMlUyv+QcNbgLNh5Q2iC5lFLRCDMVkFDwBLh/IAlS3mRbvlGUPbAch9c5zrgX7p1avuyM6teT3ytdjxkrcYnCWfg8LfOdTc8Uu/6UAumtTeCb/iA+jfkl1pr8uxulW6OKfGfz0bq0VU9ywEg9iBC9x9Go5mLYx9NsgJ/f/bSeTTYRl5p++PNSOLF/nfWUASLrtdn7fzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4z5yyNRRujdA655UH3V9xgsy+ne7Uww/6Q540H9x3kI=;
 b=daO81KiZPFziyFC/JczUOytwHeIqH5EvtCt/EUjjTjz5WYGC2BUqWt0DFOQJsUPFipMzfkabBC27p4sYFYX07FmGMunwkCwUUC260KL6QcE93iPwhH859p/370Lscx9QU0u0ffNYekuVlznfYHkyZs6/IaEOVz8Xi6X1YPBc2LDJz71AAZrtdYNwPtlNDzs+Nt8r73j2NU7wlxWexTjzVTCt4LXXE0Ag//CKNruSYbPSHdsTARPHYJg5VGap8GvO/ahjImtjTBEv/uETqwFhe21hHL4djiwelkWzk2sYXZn73b3NpZEdM1mzHp/FByiRUb8yFrlgHunEZvY4VZa3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4z5yyNRRujdA655UH3V9xgsy+ne7Uww/6Q540H9x3kI=;
 b=5SatAO4cd0glag4kmiSXhcTi7+2BLtN3G5oVo7Sc9rtVEBHAUKR9TZ6XWmymhc8QIQ5TZrFkmyA4tqeknKJnBdpbxMu6s9xixYFXrKA1WodqsNQHkDH0SJhrJ1diYGMXmVOg246id41vrmeq7G5USdDW3qJHITGWJ2C/qQeYvYw=
Received: from SN1PR12CA0052.namprd12.prod.outlook.com (2603:10b6:802:20::23)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 12:00:19 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:802:20:cafe::ce) by SN1PR12CA0052.outlook.office365.com
 (2603:10b6:802:20::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Mon, 30 Sep 2024 12:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 12:00:19 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 07:00:17 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v3 02/09] drm/amdgpu: screen freeze and userq driver crash
Date: Mon, 30 Sep 2024 17:28:59 +0530
Message-ID: <20240930115906.191060-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|BL3PR12MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7637cd-4543-45cf-6b1f-08dce14774b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUtEUThSK0N3Qy85MFZxT2krZUlscEMzMytQcUQvTEQ4a2RDcDFzMDY1blc4?=
 =?utf-8?B?M3JoN3U4SVlIRFNOdUhWTS8zSlJEWkVsQXo2RFE0eWtxemREamRkT2RRR0dp?=
 =?utf-8?B?blJkYlRvbW4vc0tCZ1dnZTViWEZzYVpEVE5SNlpGMmFvV3Vvc3NkOHU3N09D?=
 =?utf-8?B?R1FjVXN1ck5ybzhRbE9WYy9NblRweXkwaDBuTnQzVHBET0c4dFg0eVU3bzdZ?=
 =?utf-8?B?MGt1dnVvT1ozZEdPSGZ2M2hFbk9tbEozM1JXT2JIUUIwcUNsWm40YjhDQ3FW?=
 =?utf-8?B?bjVFUHhWakxlcmpKZ3NvdldhVVJHWHg3aGhtdjc0dnhWS1dtN2dMandmSFRY?=
 =?utf-8?B?QndycWRPKzZxaWtYZ3JIN2FPbFI2UWo4N1IyOWtkb3VqNzBHVyt2Mk91OE1L?=
 =?utf-8?B?RStMR1Z1cmJNSTFUaXdBd1Y3RitkZUdaYmp3TXliYVR3Um9yR2Vtcytsd1hq?=
 =?utf-8?B?bEtMNUJPT0t3Z0xuMitUbzdGbkpOWVl3SlBkai8yZldzNFBjY0JsbHFhZEVr?=
 =?utf-8?B?ek9pV0U1d2s3bmxteFQzRXdzSmRZN2t2Q3FGSWZ5eWNGK2R6NE5ORzF4WmFr?=
 =?utf-8?B?TkVoeThrRnNXWmFndlVPSnBDMWlMM1dmZGZ4dmtaUW95dVFmVTFYRlhOL1Np?=
 =?utf-8?B?RFlTaVlFYWRZekV1MGU3QkJiNlBRWXRkUjN0M1lxcFE1cVVJSGVZTDdQOXhN?=
 =?utf-8?B?Y2hWUUxnVVFySnd3dGlxako4V2d4OUo3TzlIc2hHSUpLblduSVRhMENuZExp?=
 =?utf-8?B?T1IxRCtVQlhWdDRJQVRWQjhlRzlxRnZ4UEYwbDdlekVxZVNWT25JWmx1Zk1C?=
 =?utf-8?B?M2JxNHFsL0tYUFg5K3VuUEU0enllemJOMktiMUllVThIN1htczFBNnVHYmhq?=
 =?utf-8?B?NmVSb2xTV2Z0UTN6YUUvMXlWdEM0SzN6T05NTEtIRmtDNkFwQndvc0JWdUJV?=
 =?utf-8?B?ZFpydCt6Ny9KaDh3V21aYXo3MEFiRk10OVhkVzBLQXNXVmVzMkxxU25XTzlo?=
 =?utf-8?B?emVvWWlsVnJNWW9HWnBmOVBzc0NUOXFXaFAybXFDNUNDb3RYV3g4dzRNYjJ3?=
 =?utf-8?B?QVQxTUNKRHI3RWtIQWpuN21maG5VQjdwanFuQStQK0pYbGRBMGJyYnZPNnhP?=
 =?utf-8?B?WFgrckZ4eEozY1FSME43eXlYeUVVMk51MEZKODQ4dlg4VjNtbVo1QWtpNWZ0?=
 =?utf-8?B?SFIvd0Z3MXhUeVU2WkN6bEN1UU1OMVhGMkNkN0R2WEQ3enNINjhjMTAyMjZ5?=
 =?utf-8?B?UlNIV0c4WFdLRlM2cFRuajFnSTE0Z3dldklXZEF4SGo4MUppb1NFMHZiZHZ3?=
 =?utf-8?B?RUhzMjRsdStYNFJUMWhnQXAxMVprZHBkaEc4ZWhES2lob0ptOHdBMGNJVkVn?=
 =?utf-8?B?RnllNFFTTG1EZlpxNnZyRkRKS1M0cm40cG9nL0VXNks3TDBaZ1NPQklleVZO?=
 =?utf-8?B?cHRLbWdpODRQeHkrb0lGdFVjd0hTdDZsNXZIZmdUd0g2TFFVT3JKUW9nbDlm?=
 =?utf-8?B?UUpwTEtUSXBrTTY4Y05aRlk4NW01K3FSaWhENnpwVnhZNlZmc2VTemdhazlV?=
 =?utf-8?B?K1RVaHpiRmoxMWlXR0xuSEZxcEMzbkFOMGNlR1YyaTNBMHhPdkRQaUFsYkJQ?=
 =?utf-8?B?OEVxQWJnV2x5WkNJZ3djOUx2MCtIaVdPcVRDK0xJQXZlRWlIOVF3anVrNU1n?=
 =?utf-8?B?cHczb1gxNUFtVHJLenlES0hvV2NLdVZJa0djRVhmeFNILzE2Uk9wR1UranhP?=
 =?utf-8?B?aW5WSUNUeUQ2UTB1Z0hnVC8yQmVyWFh5ZDVUV2RITDBleTMzTlpQVmlERXI0?=
 =?utf-8?B?cTY3eXlsNWEvMXJGQnBkb0JYMUlod0duTUErdjdzU2U5NUpBRDAwc3dKWDl1?=
 =?utf-8?B?M1hCSm9FODl0dzlDNDBvQlJDajZ6ZXFCRGVnRFJydjlvcmdiVDAzWkw2OEEr?=
 =?utf-8?Q?bHx74fn2OoWH4KGRKuMGXVmLH1MEk9K8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:00:19.5960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7637cd-4543-45cf-6b1f-08dce14774b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377
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

Screen freeze and userq fence driver crash while playing Xonotic

v2: (Christian)
    - There is change that fence might signal in between testing
      and grabbing the lock. Hence we can move the lock above the
      if..else check and use the dma_fence_is_signaled_locked().

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 95f232ad4a3d..8f9d2427d380 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -185,6 +185,7 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 	struct amdgpu_userq_fence_driver *fence_drv;
 	struct amdgpu_userq_fence *userq_fence;
 	struct dma_fence *fence;
+	unsigned long flags;
 
 	fence_drv = userq->fence_drv;
 	if (!fence_drv)
@@ -232,14 +233,14 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 		userq_fence->fence_drv_array_count = 0;
 	}
 
-	spin_lock(&fence_drv->fence_list_lock);
 	/* Check if hardware has already processed the job */
-	if (!dma_fence_is_signaled(fence))
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+	if (!dma_fence_is_signaled_locked(fence))
 		list_add_tail(&userq_fence->link, &fence_drv->fences);
 	else
 		dma_fence_put(fence);
 
-	spin_unlock(&fence_drv->fence_list_lock);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 
 	*f = fence;
 
-- 
2.34.1

