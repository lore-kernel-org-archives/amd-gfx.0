Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B948C04FFE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 16:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C05A111258F;
	Thu,  2 May 2024 16:32:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QafSfGMT";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69491112587
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 16:32:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVhYoBvekvS8O2hcVXWSmXyeQG5STZnxz/GZpRYpHDwrU/Kjfe1kCsE8zo+e8GtMQybcnS3SjKKQ5O9Ty+6W98PPT4++yQRmSuw5EvuyqmF9vL42tLIUcylDIFw8QnLtvMWyTaMi0dvCdnSOqU/kYmJmicI+EilDftd7LMYaWzPoPUOQAWZwhSIWBVyD4hy9ZgvDgpkBW1JMmoEoJ0hK635mDpU/D5jOirWaQo0TpHJpP7NcpfAYOA5GvlOdaw4mxrtT4grYknTYSATKcZoPl9pqSxnnlwTF2/VKt4J0PmWs3Vq+V9BZECeK8aJRQecSHQ8RHudkTsTMgniGye3LAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0a2Ejm+C6vGPa1zLZobOhZKRMBz6u5g4G+yZcSxjGs=;
 b=WGeN3w5LwdcFXMDiujDb5PpIyDU7RmQMBK6/uK+pMqBbhtsCWA5nf/mDUqKD6E8Q8zU7brDpUqxjA0mZ6LUu8cc87t8vKQ4FmTiC6SgbC4AZ2Hgup4/3L+S3YOpr/u+990caTpFCwC8LV6OZaxNYGIN7jM1MLnF9BtHe4oQZaj+JoNwBn4xInhTLVEOmWMUrN8/WoXdGvs8fgbtixn3m7RHlDe7Ld5/qCkQPvPvVWzxosHJTvw56qebOxkr+uKXY1cwPnzNEeOKR0OKKN4SgNghKGffPgw0FVqFLDEp20vc3i14zUeoFpb9s6hDYUvQKDIb7uiboBW4ZhgHGGK/Hwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0a2Ejm+C6vGPa1zLZobOhZKRMBz6u5g4G+yZcSxjGs=;
 b=QafSfGMT024u3NONPgtvVtaqSuoDgvNE63sWtIH0eRbicXNIcjJ6XHpIEod9HsGeuTptjAamzQIN4h78/NX2oLqAhZlXn3i1nY/ghVq2GIwjmDWZ5XR9F8AMy3hmInr45UG/Y5XCqkqQ1nDMhueAH1KZsTc5NRTdDEAcsFmC4FE=
Received: from BN8PR15CA0013.namprd15.prod.outlook.com (2603:10b6:408:c0::26)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 16:32:44 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com (2603:10b6:408:c0::4)
 by BN8PR15CA0013.outlook.office365.com (2603:10b6:408:c0::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.30 via Frontend Transport; Thu, 2 May 2024 16:32:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Thu, 2 May 2024 16:32:44 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 11:32:38 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <Christian.Koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH v10 12/14] drm/amdgpu: enable SDMA-V6 usermode queues
Date: Thu, 2 May 2024 18:31:49 +0200
Message-ID: <20240502163152.1382-13-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240502163152.1382-1-shashank.sharma@amd.com>
References: <20240502163152.1382-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 2512cb6a-7684-4429-8153-08dc6ac57e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDdQZVFVMndxTnNDUXYrUy9JOCtpRHdJekVHM3pZRWVXM2ZrL1c2MHdaMnJX?=
 =?utf-8?B?UStrVUJ0b0crdTc2OTdYNzlzTVFEVmtkeExOVTBPYkpmdWR1emtudW1LZnQx?=
 =?utf-8?B?WVpkcWtzTFVWN1dIUFY0ckdPL2lBWHVVd1JnTHNvODl5RHh5MkxJZktHVFB1?=
 =?utf-8?B?WE4rZTNMYXJweHVyNU5tTnpMY0tSa1EwcC90aHB6WmNyMzZvWTdlYkJLdWI4?=
 =?utf-8?B?MFhodWM2aXlhalhCbFVyeUo5a000bVdyUmVqOE9FbVNTcnM3dm9hbnNzQkZR?=
 =?utf-8?B?NnRHZTlFbjF6MmRYOXVRR2cvY2V0VUpWSVBVOVFObEdQVitmS0FabDNiTjFK?=
 =?utf-8?B?Y3h4L05Pa0pyUEcxcDJqTFZQN2RuV2hEMXhTSmVuY0hIRC9zWTdCR1lSVzBk?=
 =?utf-8?B?T3MzSThBWUh0U0NCWGplT2dmblJaaVNOeWZuRjZkSnd3MUZUenZrc1dOWkJ2?=
 =?utf-8?B?NmNQM1NuYnAwcUFwNk5pUjl1cllGZkhCbVcxZG5zVUxaWmd1aUZ6SVlhbStU?=
 =?utf-8?B?RUZjS1pkK2laVkd3L0RTL05WN1hmZDcwcU10N1JNM2FyY1hreExlakFQNXdt?=
 =?utf-8?B?ZmtkUE5OSStxa3o2dlNPMDI2RHNBaDdkTG5acSttOGdlYzJlSzZhTXlmcWdS?=
 =?utf-8?B?emNoS1dVajNmcVpLWGpmTWxPNHpjZFJCRndvN1pyWXNyVGZnK2VtKzJhWHhj?=
 =?utf-8?B?VWhtZHpwbmJNc3pGU1p5Z0JsbGVOcjhXeTdTL0czYlUvZ3BnQnVOb2NiaXdy?=
 =?utf-8?B?bmUvdFZKTzBHSlRRdVpsL083MHVwcWY4N3hIOEQzbDN2NDNMc00vUGpBbVEw?=
 =?utf-8?B?bTBJWWlPelVEVkwrWThpTERKUzNsZHR1NFBIYXZtN0FZWUR5VVh6YXFXa2FF?=
 =?utf-8?B?cVZtaTk2ZjR4c244TmFsYVp0TDNzamRSQkwwTk53UXdybG9EMzFwdVdEalow?=
 =?utf-8?B?bmxVU1Zjc1h0eVpvbndPZ20rU3hyY2s3RC9FMW0xY2luemtrY3B0UTdtRnFK?=
 =?utf-8?B?Nng5anVZZkJ1Yi9sWU8rd0p3cXlWZmRqL3NUQ2NXc2FIcmRBSnZ5MXJFekIy?=
 =?utf-8?B?M0Jpc09TQXJJZG53azd5RU8rNTFPWitOOWwzZ085cFZOT0d6TEhtbjFLaEZ1?=
 =?utf-8?B?MTlYTm00MHpVYlFCQzBVZ2puclNvUFptQ1VQbEJ3bG1ER1o3VG1hdzlsRGpr?=
 =?utf-8?B?NTV3eisxK1NaRG56WExPeWZVSk1Vdm1GZ3hQdGZJR2xkS05WenNXRUpzcDho?=
 =?utf-8?B?ZmIwT0xsYW14MFZWR09OYWtwaGJkL0hURXdvRGR0NGo0L0N5RUgrZkNjTm9U?=
 =?utf-8?B?aEtUK2t2SGl2cTA2T09TSDhhUm9MWkQwZmg0UXZxSUpVRHQ3MEhteVRibG1t?=
 =?utf-8?B?RkxOUElqa1dnZ1pVQmxkNnJxcUVTdWh0WTlZcnhLUmVCeTZxMVI5c2tGR3Js?=
 =?utf-8?B?QkhoUVpsN1Y5d05pMmVhMnhwSmxUV1VWMnV1T2dwdHF0cm1zRm1lcUpYTDdQ?=
 =?utf-8?B?UG5MUzJPd3dGa0dEaVd2YW5VeDFRUDNpOUlCTERhWk5SVjhrV3VpT2pDbjBM?=
 =?utf-8?B?TFIza3B3YUlDMGRxeGRBSXVjRHUxQkJoT0FuOW5VMjB6bVJIbG54Znk2bElT?=
 =?utf-8?B?NU5rZGc4dmdvR0EyUGNkVmxNbkxjOWxVL3dHMlBycDNIeFdEalFFeWxGNWtX?=
 =?utf-8?B?c1VIUmtQRC80amRTTnNwc3UzanhTUGxnNEJpU2xkcy9lRHNwTzE5OXNOTDUr?=
 =?utf-8?B?cE5NaUZ0bC9KNWswVWVKbHAyNzFYLzJuOGRJT0htdTJaczNERlFUWHFJWUI2?=
 =?utf-8?Q?iUDlzX8LJYixdsYFlPikzybJQxsXi5OAaeN60=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:32:44.0276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2512cb6a-7684-4429-8153-08dc6ac57e5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
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

This patch does necessary modifications to enable the SDMA-v6
usermode queues using the existing userqueue infrastructure.

V9:  introduced this patch in the series
V10: use header file instead of extern (Alex)

Cc: Christian König <Christian.Koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index df0e74a3ec8c..f7ece0b31ff9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -189,7 +189,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	int qid, r = 0;
 
 	/* Usermode queues are only supported for GFX/SDMA engines as of now */
-	if (args->in.ip_type != AMDGPU_HW_IP_GFX) {
+	if (args->in.ip_type != AMDGPU_HW_IP_GFX && args->in.ip_type != AMDGPU_HW_IP_DMA) {
 		DRM_ERROR("Usermode queue doesn't support IP type %u\n", args->in.ip_type);
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index c833b6b8373b..0989400d0afe 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -43,6 +43,7 @@
 #include "sdma_common.h"
 #include "sdma_v6_0.h"
 #include "v11_structs.h"
+#include "mes_v11_0_userqueue.h"
 
 MODULE_FIRMWARE("amdgpu/sdma_6_0_0.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_0_1.bin");
@@ -1273,6 +1274,7 @@ static int sdma_v6_0_sw_init(void *handle)
 		return -EINVAL;
 	}
 
+	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
 	return r;
 }
 
-- 
2.43.2

