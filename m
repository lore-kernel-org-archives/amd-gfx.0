Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6A3FEC0E6
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 17:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76A1510E611;
	Tue, 24 Mar 2026 17:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WA9cVMHJ";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010067.outbound.protection.outlook.com
 [52.101.193.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A4810E60A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 17:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGxNKv8Knh1GI0R6D8B+AKjiz4m8TEik/biYYOX/wbK0z2BiBR+99ODibyE4Imts/iCpIv96PaoRIlYzVXudG8bWZ/UCqCEwIwJq3ZgESw4XZMZ8iBn1z7GONlX5qnrQocGfrOsBj9AwssUGjmP7g+IwwBt1V2UQ322FOR2Dzx6FNyy2hY32+ruH7Td1mM8NQc0gB9YAswZsc8IXWg4IDfDTkG7nmR33T42WVoR/dSARJWeXuCZrW5LRlX5nT9MDaYl5ZfF6cPDgQ3JLzwX71Mb1lnStHwZ2cUz/5hACMjSA61YCqHWMqYvDyP/VPXgZYpAkzOFzVzWnhz9xqbrk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyRFvzGacQFTOH06zguH0pqF/xNCpJLY43jJwiT/uik=;
 b=VF9RAbxxh2M56dBjwbe2VHTjrIdz0n5jQdA+N78ADUbKq9RAIie8TGKROn2Ug9QwOkXWM2fW+knvC4YAeURhuHwiaFzeGg6jZqxLGL9WzgRflLF1tRb9qO7ySGTCfSfFHCM1EpHNqYi9ImWzN3qfADUUKuLkj5U1LdaM20sGBshrEgYg7BaVSvhz62vIviRGC6xWT0wJTuShAD6EmOoOt8ZGrfDtBsArwZuzGhiwTESpczO6U95TkcwkF+8n+IGOdUkNXpFV0KXdnz4/ZeJDoRefVpEqj8kdX0wbWax08Au7JFhec6aVtZFUMiY7XE9LQ8SDM68iq0o8RUWWu4uMeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyRFvzGacQFTOH06zguH0pqF/xNCpJLY43jJwiT/uik=;
 b=WA9cVMHJVq5RnqTqnIKZ41NpfX7XBzDUxU9Y0Op9CfMmg8324yvQ73jQJNSDpERWhZzYxNHT9Bu1HCZhb8VLyCugMa2pVyvyWojXo284WpS89CbdzA2CmgnVdMa3jdvDj0sf9AWdjrLXKikrKkIc1nTIqTOPTEadwwxpC3bCIZA=
Received: from BY3PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:39a::17)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 17:57:47 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::59) by BY3PR03CA0012.outlook.office365.com
 (2603:10b6:a03:39a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 17:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 17:57:46 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 12:57:41 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexdeucher@gmail.com>
CC: <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, <Jesse.Zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH v2 06/10] drm/amdgpu: Missing multi-XCC support in MES
Date: Tue, 24 Mar 2026 13:56:48 -0400
Message-ID: <20260324175653.1325754-7-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324175653.1325754-1-Amber.Lin@amd.com>
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: e6fae566-61da-498c-973c-08de89cedb39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: IRanMWIUrDNvFcqvHr07BdK/MdB8TqZWEcyEvedwMGE7E24XnkU/uUd91TxHCkl68tXvhrVS8mM1zp5HhoB59/JVhwEx2xX1xbyBbL0a2eKbp1b/xJdNSIpLudbaOq/GSO/ezcYZX+0cJ8JuKHQL+WVmvG4FB4myhyN491+edtADwyBiVJ3L8UObbsukY9x28BnNn+YSPmzIXE7LVxs7jiXMyLVtwC595PYiOyrN23S7FfJlI/IdlpH6vSDzP95g/WXFS0g+tHyLjln63TbwtsjwF+Rv6KPdFyJh6nxx2P6UkvdfautNL6cFG1JHXdexXEXlGqWnkpkN09Ijlxar6YLg5wUreogzTLipw0cX/Q3ygktcwF7/YI5Wsu52/rGtYhCW0eRggd6HAnBwZhT75xErZbEMg4BEzNjyMCPUrW6CM+G7J35s/SeLCF+jqTPohu/qK7OPNfgzgnGz+dv0Ben32ES58VeMani/fNCR7GM1GD0Gih0g8+ugpcJEb2okmpk0rvCsI6i2qSYyUHHwiEh53fShW2gPvUMwar2a/1zs62XxRnUlMPjLRb9Z3XfMoO856byXoixiPRACG8X1NSn0IuFGBsrnSVIo1VZ8Tj4q5/7n1yGR1+d6HsZcZr5qFHPMvjcuIEhsGVpGZN5lWpWnTdxoAmQF69JQaOemItmpsnCroPth/6TO13TNPbw6fBELi0ftfl9vjCrqhImoIRHEVsl+O2FwzcnIKyXFQgwvvrU2UHKNjvIUosDjy3s4kf0RoUYO9ora9X5Nv8NcdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qzqRn+IRNwuRQiLk5FWkr+rxr70PxL22gsmK/KROcJsADdWx9gOqs+NsB73bmj7nApDE2dULIXtpylP3L55Q9+zX9GlTfW90dU8fyufr2m2IZBITvZNTbtLFj2Kj1sookFwgv1PdV1wXd61R5sJYSAWlfoOqaLYTGpLP5GbpVWEVOF7pTRhz5AyPlDA9bLbcyYHthGOkuX+zMEhAbfgtP3mRfCb0hE3kX7sAlkKUXKIu+Bzo6/bAJs7BlWODXvcGQsM39fO0NyvZ4K0LW3fsWnESbqVo0UZc8hUg1OSB6/at470pxISNVBCAq2fh3ot3LJOJV5GpXYrQrX52JVxPb/heF73hq5WC9nlJE7JXi7br8YOn/64oRZp8SQYDKp1TiVioJ2hfiPSHVDNLRabcBPyGpGJv0afCulUEum7injHPZ86viQEntPwldpD/k+zb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:57:46.6109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fae566-61da-498c-973c-08de89cedb39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590
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

In a multi-XCC GPU, pass the master XCC's ID to amdgpu_mes_suspend,
amdgpu_mes_resume, and detect_and_reset_hung_queues so the command will be
sent to the matching master MES when the compute partition mode is not
SPX.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c               | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h               | 9 +++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                | 2 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c            | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 4 ++--
 5 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index d778c3da8203..f3a4ae1fd521 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -300,7 +300,7 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 	mutex_destroy(&adev->mes.mutex_hidden);
 }
 
-int amdgpu_mes_suspend(struct amdgpu_device *adev)
+int amdgpu_mes_suspend(struct amdgpu_device *adev, uint32_t xcc_id)
 {
 	struct mes_suspend_gang_input input;
 	int r;
@@ -310,6 +310,7 @@ int amdgpu_mes_suspend(struct amdgpu_device *adev)
 
 	memset(&input, 0x0, sizeof(struct mes_suspend_gang_input));
 	input.suspend_all_gangs = 1;
+	input.xcc_id = xcc_id;
 
 	/*
 	 * Avoid taking any other locks under MES lock to avoid circular
@@ -324,7 +325,7 @@ int amdgpu_mes_suspend(struct amdgpu_device *adev)
 	return r;
 }
 
-int amdgpu_mes_resume(struct amdgpu_device *adev)
+int amdgpu_mes_resume(struct amdgpu_device *adev, uint32_t xcc_id)
 {
 	struct mes_resume_gang_input input;
 	int r;
@@ -334,6 +335,7 @@ int amdgpu_mes_resume(struct amdgpu_device *adev)
 
 	memset(&input, 0x0, sizeof(struct mes_resume_gang_input));
 	input.resume_all_gangs = 1;
+	input.xcc_id = xcc_id;
 
 	/*
 	 * Avoid taking any other locks under MES lock to avoid circular
@@ -462,6 +464,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 		adev->mes.hung_queue_db_array_size * sizeof(u32));
 	input.queue_type = queue_type;
 	input.detect_only = detect_only;
+	input.xcc_id = xcc_id;
 
 	r = adev->mes.funcs->detect_and_reset_hung_queues(&adev->mes,
 							  &input);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 2e6ae9f84db0..643b4f8d757a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -325,8 +325,9 @@ struct mes_reset_queue_input {
 };
 
 struct mes_detect_and_reset_queue_input {
-	uint32_t                           queue_type;
-	bool                               detect_only;
+	uint32_t	queue_type;
+	bool		detect_only;
+	uint32_t	xcc_id;
 };
 
 struct mes_inv_tlbs_pasid_input {
@@ -442,8 +443,8 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);
 int amdgpu_mes_init(struct amdgpu_device *adev);
 void amdgpu_mes_fini(struct amdgpu_device *adev);
 
-int amdgpu_mes_suspend(struct amdgpu_device *adev);
-int amdgpu_mes_resume(struct amdgpu_device *adev);
+int amdgpu_mes_suspend(struct amdgpu_device *adev, uint32_t xcc_id);
+int amdgpu_mes_resume(struct amdgpu_device *adev, uint32_t xcc_id);
 
 int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring, uint32_t xcc_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 78d1f3eb522e..35734d34763a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5200,7 +5200,7 @@ static int gfx_v11_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
 	/**
 	 * GFX soft reset will impact MES, need resume MES when do GFX soft reset
 	 */
-	return amdgpu_mes_resume(adev);
+	return amdgpu_mes_resume(adev, 0);
 }
 
 static uint64_t gfx_v11_0_get_gpu_clock_counter(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 9508709abd49..d02a84711394 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -266,7 +266,7 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 
 	if (found_hung_queue) {
 		/* Resume scheduling after hang recovery */
-		r = amdgpu_mes_resume(adev);
+		r = amdgpu_mes_resume(adev, input.xcc_id);
 	}
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 18bc5ba25f8f..ec8d7f4be840 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -367,7 +367,7 @@ static int suspend_all_queues_mes(struct device_queue_manager *dqm)
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
 
-	r = amdgpu_mes_suspend(adev);
+	r = amdgpu_mes_suspend(adev, ffs(dqm->dev->xcc_mask) - 1);
 	up_read(&adev->reset_domain->sem);
 
 	if (r) {
@@ -387,7 +387,7 @@ static int resume_all_queues_mes(struct device_queue_manager *dqm)
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
 
-	r = amdgpu_mes_resume(adev);
+	r = amdgpu_mes_resume(adev, ffs(dqm->dev->xcc_mask) - 1);
 	up_read(&adev->reset_domain->sem);
 
 	if (r) {
-- 
2.43.0

