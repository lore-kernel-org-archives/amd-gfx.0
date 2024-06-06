Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFF2C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 16:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7068410EA20;
	Thu,  6 Jun 2024 16:51:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DtQlvEUj";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A55B410EA20
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 16:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zq+ozYN6dT1YMVFcFy7/QgxPrS6fXsOIr6AU5+oQI8Alst7PuAMiyLG6RhQSgR8rI6TjvLKKcqjSF9aKKvA/6zWhByCWi5S8WMbt9ZSXGO58TlSxfUhCiWA29O1lg2jOmr22Dn0ZSt+BbEXrhZ77vtW4ni8O/nyhCZIxBjI9EdZq8Pzdnwl5KQy2dzD4YMYJp+6TogXMaZGNZO9bE6KbFy+UIZ+MXM//JO8TniyCo0n4jxx+bJeM8K6NWXxpdIBL+b14jMJg3WXoAsJ0a4Ed5n+kJ8Kzc07AtYYLmCjBKUYCSq+brVxw8oQOLiRMEehNhLITNdr+CKimpvCnOVcrCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzTWWkQhJCMyWmoaKJ74Il/ZibpDOxqs7XNgeteglWA=;
 b=GHWyGib6aaqwHHRTS0c3zi1GFenMzvh4WjrmgIC/6HFZ9F4gSPYSTu+KB4QzWN9/xbJN5lWPFKPUxMWOBroMVVoUnmfPlJaATDiwprMYIzhjc4QAMbVg6UvBtm9IFgrwiy8qgCRuIEw5PHTXRaPfs8aoqCX9HznYMdKn5Q5iSZu4dGQoBj7+tVe+QD8Erk+sbfWwSlGshl7qfK1IeUAcTdniQCTG8bY8QlM2esM3/WFBhqGqmY9vzzQscwONnaAlFGQQGugyU27jhQ7GjLvtNg0GHn3RIlp8LKJV/oLUvwY9JIwqLIqTBG2nk3XSux7Y3Qiu/qUN9xeZea0tuU2EdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzTWWkQhJCMyWmoaKJ74Il/ZibpDOxqs7XNgeteglWA=;
 b=DtQlvEUjBQzbYfOlQTmeLGubRMaO3R9oHHnEcJ4KKLe61ci7qQ8dQHBlP39fEW/ElYwAtrf6CE1xVztI1sG/SDAI4BOaTBjmqk1f72Z03cXolEu1qRF0AxjnIpCR3tet90puc1X6jZXqy4rh7i06BlJ8jOZEj3u19iJzoIjtoE8=
Received: from MW4P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::26)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 16:51:40 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::4e) by MW4P221CA0021.outlook.office365.com
 (2603:10b6:303:8b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Thu, 6 Jun 2024 16:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 16:51:39 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 11:51:38 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>
Subject: [PATCH] drm/amdgpu: Add missing locking for MES API calls
Date: Thu, 6 Jun 2024 12:51:00 -0400
Message-ID: <20240606165100.2821320-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: ac703098-4387-4995-0133-08dc8648efc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U03JgvPXdZE0N4vvILL4vahU2i0YRI/q1xgiVon5MXQtfG7nXlJu2UpGquUG?=
 =?us-ascii?Q?l5ZO4NLS4IR1mIlSjQFXrwFBJOqyF5iQoeghu1mH9Aak3O+ZA+XurKZhK1K2?=
 =?us-ascii?Q?868FGfRdovrSrxpqj5shmXrwi9jTJIEO3dY8wureUGisjIHiMqxXgDgV0gJC?=
 =?us-ascii?Q?/NTWls5bVFChXYV7iWFsg5jc1qEwT2RhsisCYbzTxPv/NUrwMS/KfTTd7Kvq?=
 =?us-ascii?Q?74cUY+5zYOw6taGpMp1eYX7RBS5BMegYF5Mr9zmp8cqRJ49epubE+gJJOrgv?=
 =?us-ascii?Q?f775uV/foYDg60b4WwfzUDbkpkpVu6EJgWFJ3niKeYjTzym0Vsr8XLlh6TnY?=
 =?us-ascii?Q?NHSz2OsYVqflwkEKdhAVVjDT9Q9edWheBL99+k7bbQWbt91rdty8dzREAZRz?=
 =?us-ascii?Q?XnT+ODhP/exwPp1Bb8bp9Wd5nQia43aYUb6S3E0BCmpk/XNB5hrUsn7JlbmI?=
 =?us-ascii?Q?gj637OZHAbeuxqkIWigJPlMY065uH8675g4nGgBR1JvbRajxY4/3KgwA0l4y?=
 =?us-ascii?Q?TTREh/lHzd9YMnFAVojZAgZcwB6/rlQIfGBHa2THzkCrRP524EF+K1neaccM?=
 =?us-ascii?Q?GBCfd3hhz7qGO9LZLDBKj328qyQN9iaiwP9tworoa97ea31jrV1IglCDuliP?=
 =?us-ascii?Q?0Z+twOIgYlqGwo2B8N8xF2bE4LN+rZOg44MRQQsVAbLuaVv/UD1Wiu+gpe+V?=
 =?us-ascii?Q?xE4WUhiDw1ATTbkxxkru0W1fIKVa/nYAQAKDpeWG0IoA4wBQDfvQTbax3/7a?=
 =?us-ascii?Q?p+9wRYLI9iS+5gVclbehl68ZYKOhDZNJUsp8sXiysCo8xcD6cZlGrmjE9Fm5?=
 =?us-ascii?Q?INOu+0Wq03vPvLwwFN1g4GFMwJEiXGW74l+23xF6/Vj8ATaVopa9wLvoVQGd?=
 =?us-ascii?Q?mSOeD2pk+cXHFj8V7Ntjw5ssg3uPbQcQCvA7ollNn0/tHJxZel91HiD1xIDg?=
 =?us-ascii?Q?bDmZEqWnlGmPFi56O0RyTtw6fit2DsSho7MRyJbblaYHI4desg4A8Txl/UGo?=
 =?us-ascii?Q?WaPZhFI8raXd4CmrS4Co7M7EUSZQNX7FMg6R4NPFk/gfxLJy5DqxStvz7ZL1?=
 =?us-ascii?Q?3ZU8fxGBCXJT+ZrFUC+2CiQ14MIzAHPkPLzVTxWiCdqcjGI+obwbSKu4Cokn?=
 =?us-ascii?Q?qHasXW2VWxi3kn5tnjNM8pdFkmUaT/G67Nt9Fij+zV1SCluwOtHNvqmxLjSj?=
 =?us-ascii?Q?fQZd5vvctZRshBZqqI27lRrPdYKqK5+UO7TxBA+xDkZBq8ZxPVLwXOvstnga?=
 =?us-ascii?Q?/bVVRY6FZMKCsoFYZQZXXCtOdmrjZFhMCDMoJeny5kR6ENAOB4Aw77we99MG?=
 =?us-ascii?Q?LmqkYNTm90UoCzJqFfcFtanWFIDhEfjdtjKrfxFdGITyWmEyzcdmOYiZgdp8?=
 =?us-ascii?Q?+i9MF6rYhscmDxKzMWEew6nUfgbqK9jQtPcWHIwmE87HUjO0WQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 16:51:39.6663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac703098-4387-4995-0133-08dc8648efc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409
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

Add missing locking at a few places when calling MES APIs to ensure
exclusive access to MES queue.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 62edf6328566..df6c067b1dc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -801,7 +801,9 @@ int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
 	queue_input.mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
 	queue_input.wptr_addr = ring->wptr_gpu_addr;
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->map_legacy_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to map legacy queue\n");
 
@@ -824,7 +826,9 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 	queue_input.trail_fence_addr = gpu_addr;
 	queue_input.trail_fence_data = seq;
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->unmap_legacy_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to unmap legacy queue\n");
 
@@ -845,11 +849,13 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 		goto error;
 	}
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
 	if (r)
 		DRM_ERROR("failed to read reg (0x%x)\n", reg);
 	else
 		val = *(adev->mes.read_val_ptr);
+	amdgpu_mes_unlock(&adev->mes);
 
 error:
 	return val;
@@ -871,7 +877,9 @@ int amdgpu_mes_wreg(struct amdgpu_device *adev,
 		goto error;
 	}
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to write reg (0x%x)\n", reg);
 
@@ -898,7 +906,9 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 		goto error;
 	}
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to reg_write_reg_wait\n");
 
@@ -923,7 +933,9 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
 		goto error;
 	}
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to reg_write_reg_wait\n");
 
-- 
2.35.1

