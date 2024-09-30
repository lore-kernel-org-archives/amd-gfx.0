Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7792CF649C
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 12:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A40610E3FF;
	Mon, 30 Sep 2024 12:00:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qY7GxSAw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B7210E403
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 12:00:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=domu2XDidSA7I44fL2xrFC3Xiz5TGhW8pKZfprnWCqb+CmnwdnHn6ihELk314q0n9ANRQbHRpQHd5QzsJ9+Lm6VlPDBZKSWVoM+8Lr8Q8aaR3nty1MtWRgXdwfZRykKv2UP6wNBh3AH5kEHmWzFPhM405r7waC/7TDwIEtELyMH/eQMVLFyYKhb01ZhSOY/zKqp6ZtS4QHkwooH0omQW8Psr59CW8NC3Dx7dJNKt3DEK+ZNzh0A3i7H7I26ZwCZxybyqvQctcE9wws0gO+AUIzDJs9VZ6GsItRPB2WK3ZUJLD6nUpu989zTIdXH2nkyRIycrDjuwBEyuvKnFjTDVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CI0CW+sc6lxlJCrqq6ZtT9pNeMqCvl0sJokKE/hfC54=;
 b=Gc5AFe0PvUv6XmhB9EQ7Hpo309C/pxRtN/0nEvjjclxFC0d18sxFhRTYlc9p4aA85OMj+Rs7zZ8t0jHLX8hQ0JwkNVdeGMIjLHZGyU2Khzo5ZB4oIgtBhdvjlCYa5NsytmF62a9I2SqTUx1RIcsZ1BrG1Z3fkmihHrMHe1XEoNTWTfJkmDA8kGxAY9H8oLtCuw8Mfr08pwJgeiWWPXhdZki5Xbx5rnN8DoiUEngRFd/QIHrJIRN+vpCpLETOwWaQYieffkepLanXfQUnXx3TiA/fqj4QWEMT9drP+W4+ZQfzbvX+KLFGtUbArlgwS29ACt/DbCffL4gUaRBxoOTQyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CI0CW+sc6lxlJCrqq6ZtT9pNeMqCvl0sJokKE/hfC54=;
 b=qY7GxSAw86onTgC9PpBW9DyScP7SmurgvufQ2X1zXAA02nZxGEbX8fmaorgTWABJmuuo0+49FnJZXafTNXR5S4EELf+nPPAms3G32PCX2rikP9BxaBTeVGkvMvwwy3hq9s32Sw696j0OO1MgBAarkesIbZUqNBjQjHAAxpaFWpQ=
Received: from SN1PR12CA0073.namprd12.prod.outlook.com (2603:10b6:802:20::44)
 by BL3PR12MB6474.namprd12.prod.outlook.com (2603:10b6:208:3ba::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 12:00:28 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:802:20:cafe::f8) by SN1PR12CA0073.outlook.office365.com
 (2603:10b6:802:20::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Mon, 30 Sep 2024 12:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 12:00:28 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 07:00:26 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v3 07/09] drm/amdgpu: Add the missing error handling for
 xa_store() call
Date: Mon, 30 Sep 2024 17:29:04 +0530
Message-ID: <20240930115906.191060-7-Arunpravin.PaneerSelvam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|BL3PR12MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: 199651cf-0b87-4a40-577a-08dce14779f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFppKy9JekZpY2ExSzNXL2IybEdIVk1SMkRoZXYxVVFpK1lqSG5kT3Vqdngr?=
 =?utf-8?B?eGpZR3JURklUbFFPbHhsVkxkcUtBQXFxdHJtMnQ4UFdIQXFsRFBiMmpMZlVn?=
 =?utf-8?B?cU5sRklYb3lEY0xuTGtkVXZHblIyTlBBampEUk55TW1QVTQ2RnhVOGtJSDNY?=
 =?utf-8?B?VDdVUzlJU2x2MGJ4SkY0UHU5SUdFazdBTFBjczZIdCtWejRjc25nSCsrUGVT?=
 =?utf-8?B?dG5kN3daS0VnMUNZMVdkTEJDeTRjckczS0kreG5RYWpyQzlybzlyemZRS2kx?=
 =?utf-8?B?YnRaTE1PUHJ6V0piRlhpYmxsT01jZWVXS1BnSTlEb3Z0dFU2UjNQSkh6T1Fr?=
 =?utf-8?B?Wlh1dHkwZGRwRGErYlR2RkRZb2wwYTZ3UjNIektzQjlpMTVlZ1JMWEM4VXQ3?=
 =?utf-8?B?MjZKTkNCOFBxNlZIclBKNmZQRWJ5MXRqR3ppYklKSnlxWndwdmZuYWtrcm1M?=
 =?utf-8?B?Unh1TGZYNjNReW1Hb0F5V1pDamFXZ2Q3cmlJaStKVXBkNmpmdVpyblR2dUpB?=
 =?utf-8?B?T1F3blVyM0pYQ2pleDZBblQrb3hFZmJVSGVrYSs3UTNlRmNtZDlNSG5pclVB?=
 =?utf-8?B?T1JEQnFsZjdlbkN0a1dDd3kyV09QSndsZmcrbzcwVVhUMWovZ1F0Y0Y5d1lK?=
 =?utf-8?B?SWFDMVkzejlWNnJGdkFpQUwveEJHRld2NVpuNWdEQmVwQktsYXFXSmI4LytH?=
 =?utf-8?B?d1hGekJ4UHYzNTU5eGRGckdWSmYzbmtuTmVGV0E4WldrMWE5RTBEdVc1L3dM?=
 =?utf-8?B?TllYNXBnUEVyYVRPeGwza203N2FocHlydURZaXk0OU1QRHhTRDU4cTIzajNx?=
 =?utf-8?B?ZVptRGdCelBPM0pkcmtiblM1dDcycUJyMytuQ3lHanZXL1MyVysrRWprT0d1?=
 =?utf-8?B?dEFMbFVMKzdibUZDbUI2ZnNzSmc2R2ZZemxDYWs0T1lhOWxKekE1QzgrREc0?=
 =?utf-8?B?aTVmZXJqZGRDUkhRbVlVckZBNG9INzc0Mlc0OHhwN3VuaE5YYTJkeHA0SGVu?=
 =?utf-8?B?UmlWbUh1TGREdWlXWkw0em0vWW1STnNzSEZRM1B6N2d4K25MK3UwZkdsYzJo?=
 =?utf-8?B?dDFZTWZrcUhMZEFTL3BXbkw3SDNnbEJvUzd4UzZGaDJPUVZGSHBEbnRZYlFO?=
 =?utf-8?B?LzY3bXJwZ1hOQkpFRmpOWlgyeXlmeHZ6ZXhCREFZb29rVkE0NDVHVEI0YUIr?=
 =?utf-8?B?MlBxcENObXRwY3d0UkhMSDMya3U5Y3RCMlVGM09iUC92U3VsWjg5ODFiZDkx?=
 =?utf-8?B?UzkrS0t3cHBrSUdPSzFGdThUbCtiUFFUSTNoZnkvdFdqRzJNSGw3aXNIczN4?=
 =?utf-8?B?Mnkxdmhzck1MR0ZiZ09IL0V2UjlKZm1Na3JmcUZWeEsrZ1YzN3h1ei9hZy92?=
 =?utf-8?B?UEtiVDRzNHJMK013bmIxTXhDMnZoVVhVQXBET0lqc2dmdWRUNmJUR1luWU55?=
 =?utf-8?B?c0xoOFA1OGUrbitKL280Sm95RGk4dnZjOStXMFB5N3NkaDFVTjdmWVFqTnhG?=
 =?utf-8?B?ZzgzZk1oTytXMjkrNUsya2Z2RVFKN3hNbE8xcDhzekJJNDZ5c1ZhNUl1dXlJ?=
 =?utf-8?B?dmVNS081Y2IxTlRsWEJubHoyNVFtOEY4RTNjaFM0ZmVua1Q1WkxhQ3dEdHJk?=
 =?utf-8?B?aVZGU2NsVTEvaHB4QnZFVzcyNzIxSXQrSUR6OTFwK2k1MkFTN1IvNzZCOEd3?=
 =?utf-8?B?ZnVnVHNPaGdxK0pIdk9rV0NDU3F3dVlrZkFTeG5sMzVZNlNOVm5XenQyd0Jn?=
 =?utf-8?B?RXVxQnpoMmpFMVV3WStwT04vQ3BnM2dBdWp5WlZLbEJ2ay9ndGVvejRyTEVh?=
 =?utf-8?B?YnlyV1h2V2x0ZWxoRURzUTBsbTczcFU1NEMxbTFEcHVLV2taSitvQ25OdEZK?=
 =?utf-8?Q?p56l9LjZBhx52?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:00:28.3617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 199651cf-0b87-4a40-577a-08dce14779f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6474
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

Add the missing error handling for xa_store() call in the function
amdgpu_userq_fence_driver_alloc().

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 56bd870ff15d..9ca1910d7a62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -102,9 +102,11 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	get_task_comm(fence_drv->timeline_name, current);
 
 	xa_lock_irqsave(&adev->userq_xa, flags);
-	__xa_store(&adev->userq_xa, userq->doorbell_index,
-		   fence_drv, GFP_KERNEL);
+	r = xa_err(__xa_store(&adev->userq_xa, userq->doorbell_index,
+			      fence_drv, GFP_KERNEL));
 	xa_unlock_irqrestore(&adev->userq_xa, flags);
+	if (r)
+		goto free_seq64;
 
 	userq->fence_drv = fence_drv;
 
-- 
2.34.1

