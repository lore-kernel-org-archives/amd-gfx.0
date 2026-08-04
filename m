Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02456C55172
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 07:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 887BB10E8AE;
	Tue,  4 Aug 2026 07:50:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J0QjilNo";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAE6910E8AE
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 07:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wc7m7F7TaM816zjNDqmJpLgWElCsTQBEcdpW6/N9KdPt5SK3EWot/nYPqwgEuU1qMQtuiR+QdYXmB2sRiY/00oFjMhLhPIrFsM1suPSS8Gb7as/Aftf7L9CeWbtBA9MfXwrFHf7iT7xmAUtzduKHLMA0lKl5RUPKNzWFKI89DNWacA8LXivnXj3Y/42bdSQoSQRvBgTMeHBu9DokhUTaoZm9absTbwQpMQrNO24On0Q2fL7MFj9ARjViAe579F9lHsT/sRPwYyrdxmKYM0DUo1SQDBitJg0LZGXinuGLvgdsnIn365OnTZQ0wGSAKqzmtGb4wVdcbwNPvyQ0JfzHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frgl1HAwqQkAksBeBi/EAyU84wZ8vJphxeFSEd2465M=;
 b=e5Vk+rKQsBIbJZEmY/x2iJ8tZ+CYdAEv/2/95ijUSqmivq+MflMPXabPXXZbJJipHcKFfNpjx0XKYw0+WDluW9GmSlxCXB6DXxtrvsm41NFei/Qu7tWmcQlMKBe7Alu3l/2YBXKBeYS27gkbuF6m+Y0xQYmEh/LmEgZT6wmiFLkcSp3yS+absw2ZnFaeDf45yNUY9UocE6MjVWIKHj7fWxOSxGHJkSqKQvoqY6WD413K7ICL67M1ul9tEJFeluSf55+Pngl4UxcU4sF2YA9hxZJWgwzYJ0GI4ybWAN72x1fmHwqOz1bkjtghXQX8VjqJPM5TZ2qa1hKh0BhJswjaGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frgl1HAwqQkAksBeBi/EAyU84wZ8vJphxeFSEd2465M=;
 b=J0QjilNoLEMTeE+ycLT4R48MtPlor6v5/d1XrFPRq1mY8PS1qZGNDePOD0dg7JK5qz9jb5d7JB2ZednVxVy3uaILi11MU3iVxyn3xvuHhiSJmZOXKd8XJUGSjeZVtiD5YzAhCd1ttMaXrgdz8HfTNJO22lqMgRGJdS9qS1D7WcU=
Received: from BL1PR13CA0158.namprd13.prod.outlook.com (2603:10b6:208:2bd::13)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 07:50:05 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:2bd:cafe::66) by BL1PR13CA0158.outlook.office365.com
 (2603:10b6:208:2bd::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 07:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Tue, 4 Aug 2026 07:50:05 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 02:50:01 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Michael.Chen@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu/mes: tear down the rs64mem bitmap in sw_fini
Date: Tue, 4 Aug 2026 15:49:52 +0800
Message-ID: <20260804074952.309764-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DM6PR12MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: c994c650-c723-4e74-5799-08def1fcff62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|10067099003|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: Hk0vVoz4M6f0A0OZcmU/xnMuMO85TLNUHC8NVId5RU7P0iE5Qn/VVQx4KNraEIOBmmDn5wVbQSSTJPYX6TDrkXECmgt7yli/OcELAHWFBGgsnTJE+FiMPeERfonfZ1mM7deiaMbXj+I4oRzzMEEXiaVQCVxS4jlQcFPA8CA0hZFZ5tVsER8yiyklJ9eQ2S1mV0nw1sw2qV8Z3UyM7n36gedeWdDr9SWN8a4zMuoaJHezz1A1pmtWqtU0rcSS+pNGLiDh3WNPEzvZF2StF7cZBlUT/er0ZZrYFv6/mKO8FK93XuxJ/n81cRjhFItSLmDhDoQJfa3BeZmpRSBIfUDELZ1GfikEM4L74aBcRiw/Em1vAWEXjkjxsplDUWj2JEubH/RjrW6kIfon8+yK7G3m19JdfJNDtOMSMFKsqQEZoNwqrDOdc3tNcyglCFSkmVq3Y4CuJhIfYlH0AlmdYL8XuWAeF9AoqLq8Ftf6CbIfluYcosrUiQFu2LhA4zhT+2oSyDUSqgliNqaec2nP7O3C9rWHQZbzxOnV/qZlovyMCyVkMu4dRQ/vzOi4EOtuU6U1CCUjmV8NhZjx5mjcGdoaomMqCkNDqS8QDLGE1rpPu0xLHD0CeZx3vtyM5Kp5RO0BpfH3q6QAgHhnrUfa+kzzIHiankLHmWKCL1hZ6gQF3xlZtwLiK+UbaydwODd+/rEs/MLB6sIeddjlA4vLSMG3KA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IhFBqw0Dii9r4ArUNEMN7oaFSFYh5aQauqppvd0yJbznAUa0jIehR7Kwy+7rqa9cT4mpO76s1JyjAq6tQTdWyiEFhyBJ6FoCarWwduDgLdZTVpfbLYZBDXMnm9OiXVzKqFYFCCO7v5lOpZLc6K1o1T6y4KsCCbSb63NN3hMJGQCDzCvv+ji83ixC6Qg4TbCqcG9hiBtYEVDMEeo06MtX/yQrKQl8f6J3QXZHQdE87eYfg9Unfy076D/9jrQLw78rPNN966JKgz/Fulkizl0ZStQTzfhU43heFto3kwCtbsDgEoHeEnLAXNInBnWZfnCi/3E/H6AuZUegfueQ6dqcuHht/UUoeLtlBaLitE+WFimkzKH1leJiINlOLFO8WEBfH9ci2cd6Hl0w2hsvXEBMlDCgAhFJprtfEQNUNaiQ1dwCTgGhZpG9m8zg3Z+FUZKV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 07:50:05.1527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c994c650-c723-4e74-5799-08def1fcff62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
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

It's more reasonable to tear down the rs64mem bitmap software
context at MES sw_fini phase. This also can avoid the following
lock order issue.

[ 2529.150983] kworker/u64:1/3134 is trying to acquire lock:
[ 2529.151206] ffff8aebd9a3fa10 (reservation_ww_class_mutex){+.+.}-{4:4}, at: amdgpu_bo_free_kernel+0x4e/0x130 [amdgpu]
[ 2529.151989]
               but task is already holding lock:
[ 2529.152227] ffff8aebd2411648 (&reset_domain->sem){++++}-{4:4}, at: amdgpu_device_lock_reset_domain+0x20/0x30 [amdgpu]
[ 2529.153008]
               which lock already depends on the new lock.

[ 2529.153342]
               the existing dependency chain (in reverse order) is:
[ 2529.153645]
               -> #2 (&reset_domain->sem){++++}-{4:4}:
[ 2529.153913]        down_read+0x4a/0x240
[ 2529.154081]        amdgpu_userq_destroy+0xd8/0x3a0 [amdgpu]
[ 2529.154635]        amdgpu_userq_ioctl+0x3e2/0xe30 [amdgpu]
[ 2529.155157]        drm_ioctl_kernel+0xaf/0x110 [drm]
[ 2529.155401]        drm_ioctl+0x290/0x510 [drm]
[ 2529.155612]        amdgpu_drm_ioctl+0x52/0x90 [amdgpu]
[ 2529.156068]        __x64_sys_ioctl+0xa0/0xf0
[ 2529.156249]        x64_sys_call+0x1278/0x21c0
[ 2529.156434]        do_syscall_64+0xbe/0x5f0
[ 2529.156611]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 2529.156842]
               -> #1 (&userq_mgr->userq_mutex){+.+.}-{4:4}:
[ 2529.157127]        __mutex_lock+0xb2/0x11a0
[ 2529.157304]        mutex_lock_nested+0x1f/0x30
[ 2529.157492]        amdgpu_userq_vm_validate_and_restore_queue+0x710/0x9b0 [amdgpu]
[ 2529.158098]        amdgpu_userq_restore_worker+0x39/0x290 [amdgpu]
[ 2529.158646]        process_one_work+0x23e/0x6f
               -> #0 (reservation_ww_class_mutex){+.+.}-{4:4}:
[ 2529.159832]        __lock_acquire+0x14c4/0x2210
[ 2529.160021]        lock_acquire+0xc6/0x310
[ 2529.160193]        __ww_mutex_lock.constprop.0+0xd9/0x1a30
[ 2529.160419]        ww_mutex_lock+0x40/0xb0
[ 2529.160590]        amdgpu_bo_free_kernel+0x4e/0x130 [amdgpu]
[ 2529.161077]        amdgpu_mes_rs64mem_fini+0x35/0x60 [amdgpu]
[ 2529.161601]        mes_v11_0_suspend+0x2d/0x40 [amdgpu]
[ 2529.162102]        amdgpu_ip_block_suspend+0x2b/0x70 [amdgpu]
[ 2529.162609]        amdgpu_device_ip_suspend_phase2+0xa4/0x270 [amdgpu]
[ 2529.163116]        amdgpu_device_pre_asic_reset+0x130/0x1f0 [amdgpu]
[ 2529.163617]        amdgpu_device_asic_reset+0x55/0x530 [amdgpu]
[ 2529.164101]        amdgpu_device_gpu_recover+0x1e5/0x410 [amdgpu]
[ 2529.164592]        amdgpu_userq_mgr_reset_work+0x80/0xa0 [amdgpu]
[ 2529.165140]        amdgpu_userq_hang_detect_work+0xbb/0x1c0 [amdgpu]
[ 2529.165693]        process_one_work+0x23e/0x6f0
[ 2529.165884]        worker_thread+0x1c4/0x380
[ 2529.166065]        kthread+0x10c/0x150
[ 2529.166226]        ret_from_fork+0x314/0x390
[ 2529.166408]        ret_from_fork_asm+0x1a/0x30
[ 2529.166595]
               other info that might help us debug this:

[ 2529.166917] Chain exists of:
                 reservation_ww_class_mutex --> &userq_mgr->userq_mutex --> &reset_domain->sem

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 5998e05ecd79..b96f94e5169f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -308,8 +308,12 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 
 	amdgpu_mes_doorbell_free(adev);
 
+	if (adev->mes.use_rs64mem)
+		amdgpu_mes_rs64mem_fini(&adev->mes);
+
 	ida_destroy(&adev->mes.doorbell_ida);
 	mutex_destroy(&adev->mes.mutex_hidden);
+
 }
 
 int amdgpu_mes_suspend(struct amdgpu_device *adev, u32 xcc_id)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 37985c37be18..31722bb10038 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -2038,10 +2038,6 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (adev->mes.use_rs64mem)
-		amdgpu_mes_rs64mem_fini(&adev->mes);
 	return 0;
 }
 
-- 
2.34.1

