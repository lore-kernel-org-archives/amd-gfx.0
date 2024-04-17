Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EBEC001CC
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 04:13:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9EDC1130DB;
	Wed, 17 Apr 2024 04:13:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AxJNSZCs";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2181130DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 04:13:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvszlIu6TwQmDSOe+36Zoz6dER61JBxWOnzp226YQseNmcmaY0wjDkGhZWbtAAdut2znAqJR3yEed1jWSmpnq4bj10rWdCMryCLZ+aBIhE1uJmkQikpklet42o/ykdD8Mg1rM0o5TAEME483OqzrQ81Cv9cvpKr/l+aNsMye5kWzEQu4Q3FmbdXfuaslTSPV+gbnOBmHYIds3k6bntXsnUXABF0YASnnGAuB+wjjSTS90dsksjAPgJNJwxAcOX+EQsQdiM2DuCTlEg1jJJzoOdPcQFDPgDG1UeTUc8GkuTK4e6FBmY3FCxX0jYnkLD2piUfO3My/Z9XBmud7cOv7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6YhvXDSodcRwsbsATMeO1uJfbtzOI5Y2v0GmMtphhk=;
 b=K2dLINe0xSlh9tPaoTIZfsfEPyieHLxFBqdREykt+TVC55X+sH59P90PsWWvZtJrLV+V/7hMBjwhX05RyUCa9ZJki97mOPKrT/ijuHKg05EYsfFyXMu7M6eOXV8A7QQqdWgwpqngznetxW4ROzILLeiIHR4H9rpkMECRCBch5XtjGMIo8ZdqPXdgkGQ1WkuCJf0obNZp4UG5PyBBH5HY4ujYzwwUYheJIaola7z7HyuSxB9+8S2CxmwH0d5J+BcAF18Lc6LdiW6Kb0DBhKSk7zW3QobACU0S9F45LC89p8su/8eiFicQJr4y8xwHrDd4iQX98k4nTG9WfohLN5uGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6YhvXDSodcRwsbsATMeO1uJfbtzOI5Y2v0GmMtphhk=;
 b=AxJNSZCslV7inuswElf6f89WV+AkmkNpmV+kBKdK/yzBfHQzboQoHIeDPbbxVqeAwa2kdiTqFLrMAFvOA+OdU0NareW1wa606wUHYJ++FaPuDMVaCrQa3scsAeESjtRamIBFMTOQ+f9TyLaBbQUzDEnTOnKXBr+iNCPvXieu55c=
Received: from DS7PR03CA0084.namprd03.prod.outlook.com (2603:10b6:5:3bb::29)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 04:13:52 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::f3) by DS7PR03CA0084.outlook.office365.com
 (2603:10b6:5:3bb::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Wed, 17 Apr 2024 04:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 04:13:51 +0000
Received: from banff-1e707-e02-2.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 23:13:51 -0500
From: Ahmad Rehman <Ahmad.Rehman@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, Ahmad Rehman <Ahmad.Rehman@amd.com>
Subject: [PATCH v2] drm/amdgpu: Skip the coredump collection on reset during
 driver reload
Date: Tue, 16 Apr 2024 23:13:36 -0500
Message-ID: <20240417041336.65366-1-Ahmad.Rehman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c884ba-37c6-4f67-8897-08dc5e94ca0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8s/stwhaqkO63sl8INMLPPz1h3+tvy0raHVsvkxGNlJn5plr7fzxtNYWVFWNXti1leP/aQ+z+aUNVOCcBAHYj9bEBLmMrhZAZkm7eJjOx+gy1ziaCINEHnaLE/eWfvALoOFXXSjejUTCDg8s6Ak+f/jyilz76N0wXhMDj52N40FUhw1bydsg7vdRAVFA0jWTLX5bIuqXeeKEk5FzaldYIbbI6EOvI4518+ODIvoBllm95n45xWB1h/wzJ17qWX2WSsD3GU8yy6TlCWoxnPmVqFUc+7moIzOMFr3exbkBwbzr1r0gppuwo7dtY/uQNzHqZ6X+x4SmEZj1X8ma6UuoeCyaFRt4xD5qLQceXBX3abDhjCblR7GrJGhuvPhRupc9Xz4XZyUX5/LNhDUvdDh9y1vhfaXxNwjTwEgwPRaJfz4M4UCQZI6yakyvEEEMawXhdGxzShZO3MHsdZ1ta9pHwERi0qVwLZABQI4ikQcqJbqAmLFAoAnOSp8BVJzA72QdQDOcOUqc5kIjHOtCNR8XtG5vHotuLYXd9d8NJE1D1JZ3Io0AUUbkmq5fzUA5NUs+rJeRpWbVcI6H2QcKLZtTwCYTZ0q+DnSLB3XhXxAzWqtbW8gY31KqVdvxPf7k7v8u4Dkmbs13WbA6HmWfKFHumNJoH0ThIoqgAaZPOawWYjc8IMvaKjH6yunwVV+CiFv+MgqD9gG0rGqV96dOO6lTuBEq8uhg2rdyQE5C5ZsTHYmzh6Gb8mfAuKJWTtCwtMc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 04:13:51.6689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c884ba-37c6-4f67-8897-08dc5e94ca0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
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

In passthrough environment, the driver triggers the mode-1 reset on
reload. The reset causes the core dump collection which is delayed task
and prevents driver from unloading until it is completed. Since we do
not need to collect data on "reset on reload" case, we can skip core
dump collection.

v2: Use the same flag to avoid calling amdgpu_reset_reg_dumps as well.

Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1b2e177bc2d6..c718982cffa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5357,7 +5357,9 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 	/* Try reset handler method first */
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
 				    reset_list);
-	amdgpu_reset_reg_dumps(tmp_adev);
+	
+	if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags))
+		amdgpu_reset_reg_dumps(tmp_adev);
 
 	reset_context->reset_device_list = device_list_handle;
 	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
@@ -5430,7 +5432,8 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 
 				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
 
-				amdgpu_coredump(tmp_adev, vram_lost, reset_context);
+				if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags))
+					amdgpu_coredump(tmp_adev, vram_lost, reset_context);
 
 				if (vram_lost) {
 					DRM_INFO("VRAM is lost due to GPU reset!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6ea893ad9a36..c512f70b8272 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2481,6 +2481,7 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
 
 	/* Use a common context, just need to make sure full reset is done */
 	set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
+	set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
 	r = amdgpu_do_asic_reset(&device_list, &reset_context);
 
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 66125d43cf21..b11d190ece53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -32,6 +32,7 @@ enum AMDGPU_RESET_FLAGS {
 
 	AMDGPU_NEED_FULL_RESET = 0,
 	AMDGPU_SKIP_HW_RESET = 1,
+	AMDGPU_SKIP_COREDUMP = 2,
 };
 
 struct amdgpu_reset_context {
-- 
2.34.1

