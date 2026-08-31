Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4F8C61DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D357710E635;
	Mon, 31 Aug 2026 18:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AzfScDXE";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8338610EA45
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ycy9aT4Aig+wghee9EBzK6CWigqn0BgXt6/10afa5guKGlmSAT3hJghCHDPCSq8aw4vRiI9T338vVmHGashai8K45Lpdc+na5UAr+IdUa5C3XXw+KbxmG2D7a+oQwVplcx7gmMta+EbRbFmjiClVgHG7APrZBcQS7giiHjXB9j9ayQBNqh2PPTjAGmcNq9zJqSD1pH0nJ/7jywIALZ8qrhGCxv0YtSLwStLBOBljmD/G8GZwMfzDDMGvUhv59ods6Y+hUZoC76dRTiaXB0wFwqalmr/Zyh4qHCCD7rBpCEjE8GLLVOhYRG5GnlLMRlwLn6/TImPxHadqy5F6xKxvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IG09Kw5t3/MUFPpuZeQB2M6D+MKPLflGEzoo0D23Xc=;
 b=QqknVdtnx027SlzebHOBLcezkJx5l884sLXX3k7RV5tNDgbDkYyCkgk4cFcEsNBk4TS+M17UsU+t5616HLNlqiJFpKAXmeDZ0BirN7m4D1PHH0igkWANiMQhrXJfbXdrRVoBJMZHl/BfC4AWuvSJXSP1qf+wN7HDaMB5L+GWTEK6JCrahlvqWPIBtMyp8yFv3oBpzcBsBBD34+4+ccYtm5Y/xx+BOHRj3++TLTMLRBBV1H9cnoIDz5H47BYAYKh3F6/6HYfdHlVclBNpXQyUMkdduHB+8zuDNP+PQfxslfjSRUNOEdAxrqI5pN8c0RmGnp8yJr3n5dOdz9RslTf9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IG09Kw5t3/MUFPpuZeQB2M6D+MKPLflGEzoo0D23Xc=;
 b=AzfScDXEmeJ8q914Rs4PJDuQhzoT76Vn4Aou+O5gPIQWS2DZKYIlsDLtntWlBmJ6T6RkiTjshnKqx4pPrjQoCpg+iw2He0v/ZYF8I5IlQAf71YhRXLzDY1uepnEmnYZoAZRov07dqvOr5zcYJszvf/L/WLYvVwyAfWXJ9cDTmyA=
Received: from BN9PR03CA0127.namprd03.prod.outlook.com (2603:10b6:408:fe::12)
 by LV1PR12MB999329.namprd12.prod.outlook.com (2603:10b6:408:3f8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:41 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::47) by BN9PR03CA0127.outlook.office365.com
 (2603:10b6:408:fe::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:25 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 30/95] drm/amdgpu: Fix UALink vPod double-activation
Date: Mon, 31 Aug 2026 14:26:49 -0400
Message-ID: <20260831182754.1089811-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|LV1PR12MB999329:EE_
X-MS-Office365-Filtering-Correlation-Id: 786f8cac-9099-4e9e-37f6-08df078daefa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AWbzBKlKEMlAzk6hzgPejrUIlLPINEYyzKPgeFXZxYYhVPKZjdCHQOkI7zrZcgnIBmTqyf90GKsoLYEMqggXHGHeub1TfFv7N3NmNb9j2Zs6MlSPMscbqf2lyv0SWyuryjtMIlsaBTNqziye7hoHX7HS+Af34Ui+GKUC6Vz9pe2kfFfaA4r+Y40Ky+Y918G6o7lROvvFWahxfVO7/vQyNuKNUkmg/kjC4IzMQbMyL9tfewcKalhAAotZLRoW09vIW0uibBgkocQglMJZCYTTszvAzxGcPUIK6AAEJ69fHkxmmiGHDhhf5RmRLwMqzIDYqJNZqBtwCAuuzkwNHBqUH/sCk80G8plccN2LBcXzMH+c09rkoTIfVLXReW0ei9XSIYXYQYiqdBrPBCNYWCRGHq8Dcq+m0NRn1AT7VhdHUF570xal18StgGXAB1VABKewi9TrafcUC32M7EBhwfRpSkUrLCGNWeUQ0eOBmPvzd0sVn0f6X7SucNa3oeBN0PFkp3ptW3pCWgin22/9atYB0kOIWtGpDcpCO/o3WEGGQH1D2c+GQDtYUSOzbC8gvshoqggf7Stq4fSkb67HzvLCpdVjBdYDQ75n6lWBCd0HDWLlZy3R2d5KGA5N9hZf/GnXFh4JhEjRCDIHjyLinc/YvzGd2i5LudKpXyVDwh67Gq1QXt0xh9i9ePF8e3FtNCbcbH0bkD0FQ/YaJhKojSeEkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8D/pwaFqyV7FSWyigJnnp9zjtX2xr/oXJNVI9abrgFVkg0x2aYXZhJG1r3HmE7frKwrTxtF9OU/tF9brzPCFymYr/AMYK3Aw+tsyTG5IbzmLXyQRGdCgRfDht9vJP64OJi/+vkWKFAoyzXneMfamVFWMiIQMhYw96lEPWlruDj2UR9eem2DN8Z0TEqWTTWt7FGXKJSkQOhOBLpdqLnb0ys+pFVQmwX/6xY2+wdhI4symkuNM2NfLJOYfBoK54T1tWasC967l2irGia4rBLiMOR81zXDTo/xcxOsp0MYcFtSvxT1IuwCJ3JeYZCdraHPZZEZPIGqi42DPFN8xtUEaV2IEezVDUr1stxsvx7qfU+/wPJQgcl/fhhljdXp6eGuHOIvpghDGHTHzbI+gxo8NvhMnE1rZDM+bgk4Gd2gsS0xNOwkgzA4oe+U1t0qdSOHg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:41.6919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 786f8cac-9099-4e9e-37f6-08df078daefa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999329
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
index 6329fc8e217e7..c0478087b95d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -398,6 +398,8 @@ static const struct kobj_type ualink_info_ktype = {
 };
 
 #ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
+static void deactivate_accelerator(struct amdgpu_device *adev);
+
 UALINK_VALUE_SHOW(ppod_setup, accel_id,  ppod.accel_id,  "%u");
 UALINK_VALUE_SHOW(ppod_setup, bandwidth, ppod.bandwidth, "%u");
 UALINK_VALUE_SHOW(ppod_setup, latency,   ppod.latency,   "%u");
@@ -452,7 +454,18 @@ static ssize_t ualink_ppod_setup_commit_store(struct kobject *kobj,
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

