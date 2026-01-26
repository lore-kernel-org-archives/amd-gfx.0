Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB794D1950F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 20:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C53710E258;
	Mon, 26 Jan 2026 20:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x1DKjBY5";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C41910E258
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 20:08:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsUMlHj9T1qnEiplJVbUIod1PaJA1BIr3CH2S/VcvjS+/XXOE9XIddr3DkufklWVN1ZGi8CZaB5MtaXqSEZYJ0s00gqyLTu7EByyJXUtHDBHvupHPUKTsJDUio818T88FFYHRuZ5if/kfc3U9zhfYLwWw/OI+XxEqxSQUsSHYeRhFxBWUoz6cIwr/0btzw9pCvn7hPX4HOIPREwzBi8PlDHcbs8KIl9QSqUw2xAHCyi9u3Pxr76fd947e+bk4kloWSKnMUBXikl/sAUsrsQyCbEC68AucJ1qpTQZbuZ+3JxIklyPq7mNffxNjEbzc8hNOHX2n7BJBfTRUXbY+HNkjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FHMxlaT1TsINIQxIjcFeknQPAvTuW9u9QOz0zztc64=;
 b=yyZUDGB7Gx1ZJQL/JT1Nli44O8VoatqBUsE5yJMghpOkZNZ9GfUo+itR5IrOAfLOoY670ian0xnZOF/atVuq1f+phAPRyy9JO7lFE1/ViUaP5svJSdihF70r0ICgeDjE4tewbgF02cgIUFJ36sg9+77Fsae1a43+zDRivME+cdIg1EgHYXe7H2zzgLSvVmzluQyat1u6rIdVwTAkPs26q08nQ8EvKj4WA81v5yCFJ13aCu+92nDhhjsAxgyEctYn0rlzE84JJ2ewXJh5Qm4kf0f0DSl3Nz/gIzDZ5jA2BveUbkk9nybSneGAb9b+bXIba4g0TErcNsY+j2cnMVZFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FHMxlaT1TsINIQxIjcFeknQPAvTuW9u9QOz0zztc64=;
 b=x1DKjBY5WKbvcg91MffI+wArJMY9g4d/BOixYP1dVW3AKpYrmTFunYMfH80sipQMqNhm/Tvewa1oRriTGnhRGzyrBM55GnXX6xKNJNcGoZwJX/sOUUidzaa7uhqKGNhx9HwcEPdWtueHlSFmlOorBitd99C35HxmV5ZLDXem1O0=
Received: from BYAPR01CA0047.prod.exchangelabs.com (2603:10b6:a03:94::24) by
 MW6PR12MB8662.namprd12.prod.outlook.com (2603:10b6:303:243::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.15; Mon, 26 Jan 2026 20:08:00 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::82) by BYAPR01CA0047.outlook.office365.com
 (2603:10b6:a03:94::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 20:07:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 20:07:59 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 14:07:58 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 26 Jan 2026 14:07:58 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 05/12] drm/amdgpu/sdma5: handle gfxoff in interrupt set
 functions
Date: Mon, 26 Jan 2026 15:07:40 -0500
Message-ID: <20260126200747.13527-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126200747.13527-1-alexander.deucher@amd.com>
References: <20260126200747.13527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|MW6PR12MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9d0557-bdf0-4235-4645-08de5d169a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PhH2igW/GZA8auMTmX3WRVPqHd5PXfhD3H/fW9KG93RQ8+qfKlMdQZmQ/tow?=
 =?us-ascii?Q?Z47xT+u2vhUtpZ59yfAGjQJdcn01TNXcW3X0i+OmWneoV1PNyzr7ond89dRV?=
 =?us-ascii?Q?dMj1XmCCm7EYofD6M1gfy+t6h1m2YhTPpZMVKR0XwJtTfS5rt9W6nkM0bkxd?=
 =?us-ascii?Q?xpuzN+MKHvvKa6+ccZQaXyEs12gpjFcHWKY6AQbzeTVSAr5qld9n9I0ifz0S?=
 =?us-ascii?Q?zINzcbJiSATgkFqUpeFgZXKDyuGl5LRn8cwe5rrEx4aE76AjpaRFElGt7M3a?=
 =?us-ascii?Q?GJE+f+K24K8fJ62LoK+int/y6G40t1ODqpVetoN5Q9C/O/OQ7eTNpVa9q4A+?=
 =?us-ascii?Q?FLzOnEW1+UvLj1hylZKLD2FqsTD1KZlsfqV9WR6cxnrTgiGZja9YrW/dGniV?=
 =?us-ascii?Q?5nt80OpHLTMzYnjgSMj1bucBGTq7hqwcvAjwR+RZvBuzfVQlqyVooiFTidzJ?=
 =?us-ascii?Q?OW81bZUaNBf8uHM1GkhUxZL/xSC42lZn9OrqcU6T9VVpoQnqHmi1+1AAwNcg?=
 =?us-ascii?Q?Um12t1dhkfzTeWUFpCLdTcPTA49hvGF5DKcWKj0z9h0U/fgOUloDi/jcHPME?=
 =?us-ascii?Q?VcWDsyPT7kTHmAaKGTWaaVr1fd+JImpCs9QcuzZSr6mDGwnpXhxpLwIYOTOR?=
 =?us-ascii?Q?hdHY9piv4hGqhoybX3lEAyX1Rg9R6dhVTBnb/lJAE01e5x4q0paMsWoNTcyd?=
 =?us-ascii?Q?46z2V1becJnVORq/O2bpQvXbf3gNgtvAetbJpDQTfHzEGOHSUaVQ8yKdYmdp?=
 =?us-ascii?Q?QovDlm/0aeHQzAigtTo9O8cNm1Wv0IP2V4pa6UMcO8tpZOj6+Ur7vj1betJC?=
 =?us-ascii?Q?yPuqW0LoinY/liVgpurrOlPnOSyYVsoOul9qSNtOD5NN5Ca8qtFPxJqvkhYD?=
 =?us-ascii?Q?XzlBOLMFx6vye+xpc1mKdFn08FOyAY1/gB7PtTXzDglGhJe9juGxK9ZWppmU?=
 =?us-ascii?Q?OmTDMN2IETDAFmF31YbygQrH3U9Cg+L9sdWWygDUDI+pNxnxvJja+4L7WYQL?=
 =?us-ascii?Q?KrSxeY5KCmsxTnqjSJcCtESXUSi4vLuRd/Qfcs2x0+zsjTGIbl7ogGiFr8eQ?=
 =?us-ascii?Q?QsiV65OMNuCa3dPA9cEy7iyauZXUEYtnsQNmsPS88IVjnuspw9+mtkngmWWw?=
 =?us-ascii?Q?qn2Wzbrgb3Iz0/gcAEl1XsiRNMWZCNsCVxYRjIXK62OKIYQ8oeErQqmRUjI3?=
 =?us-ascii?Q?j7wXHpGtwRD43eeUpgDJ+8CdQzr3BdZcmaeorjijXWlrupUlt+BR8HaOHcDx?=
 =?us-ascii?Q?lV1tCc0ajFF423Zb3fNIPFbd8OjWcZtt6ZdyoEa3M4Na8kO4dGKbaP945Y0c?=
 =?us-ascii?Q?Py9jddf8kv57tHfnIFUNhQWi6DYlqU2FXV8oqmKXyJ6CdNTxkFEjR+dIaRWl?=
 =?us-ascii?Q?7TKEdvFEvVlluMZ2aO5efvxqCjjlie+7NTQ/TdtYfrCydYca1TPPk/a6EjOe?=
 =?us-ascii?Q?WDCkPPLwMtQoccVQqAbdfeQbId6EOi+v4WMlpEdYUzY3TZiEJMdMH5E0S1jr?=
 =?us-ascii?Q?dH3jto0oAJt1XXEwCL/HibE3ebN4IcUJTOqa8MB9uWJgn9CYhy00hQitpQRk?=
 =?us-ascii?Q?zaJyiYyeDTk7zjaZDdcmtXEd+MxRTVjqLM5y5hAvHEVIPYcpEIM3ejSQCLCW?=
 =?us-ascii?Q?Qzzz4LR43I7NnWO7xnzwus4SSiKVol2ivFXLWZw/1qynA9ed4wMgPFoNjdEC?=
 =?us-ascii?Q?0gioyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 20:07:59.2403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9d0557-bdf0-4235-4645-08de5d169a57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8662
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

Need to make sure gfxoff is disallowed when we touch GC
registers over MMIO.

Cc: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index edb1e4d3f9292..c767429504e41 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1689,6 +1689,7 @@ static int sdma_v5_0_set_trap_irq_state(struct amdgpu_device *adev,
 {
 	u32 sdma_cntl;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	if (!amdgpu_sriov_vf(adev)) {
 		u32 reg_offset = (type == AMDGPU_SDMA_IRQ_INSTANCE0) ?
 			sdma_v5_0_get_reg_offset(adev, 0, mmSDMA0_CNTL) :
@@ -1699,6 +1700,7 @@ static int sdma_v5_0_set_trap_irq_state(struct amdgpu_device *adev,
 					  state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
 		WREG32(reg_offset, sdma_cntl);
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
-- 
2.52.0

