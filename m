Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4DAC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56BBD10F4A1;
	Fri, 21 Aug 2026 19:53:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bjiaLzRQ";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B16310F4A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaRdnR0gRP8s11N10X6UCGn22H+9/d4+aVEltWpf7MVjgymeiuuv9PovEs88C3k7PrPi/KmMWuS0U6PSSxEsEftltLWTQiuirYMzA43Ui/VfLYvH23gzxmlUigpQW2qrosA4ePazvs6H8058IKsW+S09Og/xyozoQurZKo0AaMvPs+ev0zMYgV9SNIkatHbVV7zD4oy9blIHvt1ZK9HjyTXQPpviGslQjAkM1u6ChUoIb10fWD9dng9nJ0+G1OkEktoRyJ1SIYNUZ2AgtT3arp4r/6GMxipTU9wZO7fTKBOqCaBERr2AtIPFFEYgXt5vRXtct/cRjartog8rGhFa4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72LfVBX+8/tpVXHDtrLpJI5oV1HKvz9NufjGFgvVLi4=;
 b=ITS/0H17bj3XZTrkXHKDyjHBN/mocc/1cX3HmbHR5ADalS2BObxRjh6rL0NdG+l/SPHvjWTsfTJI51i42URpBbUNCwBhL6IbxPF2giyqXDqBaV2MroelAc+A5vBCa+MSovqu9KM9dJrHnT/LnUSrQDKu5ZrZ62YkolhZDQ0RK2VOzaLh1hH/L+ch++KuVtDXyuSjm5U84G7UQuzQ65Lfx5Ej5jXw4cXTDWR0yW3ZhK3kHXOn56ymHk1HWWtil14+O0xcVkGcvoSh3wmya7VbzpIq3JATwZEEjOJsaolnuy2rIjZL90NfdDgVp5keREOkfwoDZ2Y3NMdW185hhxjqTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72LfVBX+8/tpVXHDtrLpJI5oV1HKvz9NufjGFgvVLi4=;
 b=bjiaLzRQ+jUAyUOkt3DzxODwvgCyZz4XMtFHKTj7GUWolex24yjL1VsfwD56M5Az7P2l5ClfDxUZg4D1RwI5uB/l41awSYtvi5wTxS5JnmvyO0s1kxwHNXIQhdrlW7Ugmcrx37BJg1hoig+X0BADYlm6yquvYYoh4b8I9pdUYh4=
Received: from SJ0PR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:33f::18)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 19:35:41 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::aa) by SJ0PR05CA0043.outlook.office365.com
 (2603:10b6:a03:33f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3 via Frontend Transport; Fri, 21
 Aug 2026 19:35:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:30 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:29 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 30/95] drm/amdgpu: Fix UALink vPod double-activation
Date: Fri, 21 Aug 2026 15:33:53 -0400
Message-ID: <20260821193458.808626-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d9800c4-763c-4634-abfe-08deffbb617a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: UaCoijBONqaXQp0GJkUFVbi48PkfHY+3If96pO/0Q1PXH4qeciOa1sQTxYgGbuopNwvKp1IEQxXNHfps0XQBsWR8qxTdB5X7a9vsC9+dzl3ffJ/meuj8hALwpIrvBIFWcvGAnW0XwL1Os33aSTaEQ+ZikecOk0oGESQrDcTg3W/gUB+HuIJT0C6qKKKxCT6Q4Ar6ZrVcDgX7rw/OU9FCHolNFkxa67DM6EFCI+Zm+6TRnFCbSY8avOvhP+PUqzaXJDMtWKBcVOCKOaf/xO97DirLB2wUdr/j2Z++rgoH5Zp1v6FOuJeDW/2289bEY3XWWSC/pgUIDHFuzn4F7cKKsUP6Zrj0o4dIEG/OjTMvHfmXPv8irND+bKhflZabdJFITBK0C7JX/KSy8/iPh6CkMcplN3t0ekI5144ypp7g823/XGKF0yFNNlVj7Wwlcy9KUV8EiuxmeuroiyUvVSUcmf3p+IVEGkqoKs71lYUL/6tInqAIyz41yrIS29q3LFJnbUwSnd5MJsCpDW6YanpV8H0XuDutnQjxrqXsduYq9HOeqGKjuo6w0oGgBQgIGJae2AIMd9Ly7CdVAg3BAN3NHmJr+ZSf6bwK2FAbW8EV2Un6fF+COvV6GWM1w6z2r8ok16iKb0hkOHkqdmsPYfHKt4XcnVXA7F1fVP3fWrahG/9TLjkvRqyMSa4mpmZxKzSHJsCiJxOjBEpjayBHXDxOgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WXfEYy5ooC4/h+F8PwcQLlTPerdaKrWTwmnzH//+oc0sfhzVRQODYgT/ouyXzT/73kx43+OXjfd7jGfUkEX1+L1xmlit0jyQvXfwSM8/ZsWB1o63VisE3URe218gA4P8EcjAGKoEXCKTVflTXlWFkrcY59COnRRRDHR2OA2CqT9jY3DV0t2ld3csBtTU106kRrrJzBukThXH5jMrdhDdFFEE9x8QPmXDJGZCaGMzBlni3trVB04+Sl6YQRWA6cJmp255wuQ3Tslx2j9YWw88d2rPq5YM4ic1KPScYeJUb92qKB+IOm5OHjYZGkTAPEC8OS1F4ygn/NEiHN4/WUSDwqF5XPQLzHctTsm04kLT/cFI8hnjsHjUYGEbrKCIGhzk1pZtSJfBDPyEMYkCGxCmf0dJaCV6sq4GRIEOvNeLevTwW4mv0QlCPF/E5bVoMKo9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:39.1827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9800c4-763c-4634-abfe-08deffbb617a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625
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

From: Philip Yang <Philip.Yang@amd.com>

ualink_ppod_setup_commit_store() updated accel_state via
check_ppod_state() but never called deactivate_local_vpod() when the
accelerator was already in READY state. A subsequent vpod config commit
would then call activate_local_vpod() again, resulting in
activate_accelerator() calling amdgpu_ualink_manager_start() a second
time on top of already-initialized NPA VM, causing a NULL pointer
dereference in rb_insert_color when drm_sched_entity nodes already in
the SDMA scheduler FIFO rb-tree were double-initialized.

Fix: call deactivate_accelerator() in ualink_ppod_setup_commit_store()
guarded by accel_state >= READY, under mgpu_info.mutex to serialize with
activate_local_vpod() in ualink_vpod_config_commit_store().

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index e00686a902ef9..9bcf7957d56d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -30,6 +30,8 @@
 #include <linux/sysfs.h>
 #include <linux/string.h>
 
+static void deactivate_accelerator(struct amdgpu_device *adev);
+
 int amdgpu_ualink_init(struct amdgpu_device *adev)
 {
 	int r;
@@ -430,7 +432,18 @@ static ssize_t ualink_ppod_setup_commit_store(struct kobject *kobj,
 	if (r)
 		return r;
 
+	/*
+	 * Hold mgpu_info.mutex to serialize with activate_local_vpod() in
+	 * vpod_config_commit_store which also holds this lock. Without it,
+	 * deactivate_accelerator() can race with activate_accelerator(),
+	 * causing concurrent vm_fini / vm_init on the same NPA VM.
+	 */
+	mutex_lock(&mgpu_info.mutex);
+	if (info->accel_state >= AMDGPU_UALINK_ACCEL_STATE_READY)
+		deactivate_accelerator(adev);
+
 	info->accel_state = check_ppod_state(adev, setup);
+	mutex_unlock(&mgpu_info.mutex);
 
 	/* TODO: If accel_state was ACTIVE, reset all connections */
 
-- 
2.55.0

