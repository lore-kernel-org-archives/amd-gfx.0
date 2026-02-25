Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DC6FD3773
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 16:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFEF510E1E6;
	Wed, 25 Feb 2026 16:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GwRAGwHu";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF0710E1E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 16:51:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tv87TMpJatWRS3Au/qa1cUq6IBeYSdMAOYWCGYpc9fw5lSDTI+3kDWPZtjKcsCfoKLtR9DSlBIOY/92povo5V0W943QC/6/XLVCxvYvsJSMzSeIHIN7YuPJ9Ag9avqKWX1P8nYhvm9axckp5W0xmdN2qCFnTkqCZ8zZ0MevG0gps42bfVca8zmzaIrYkJlnBShltXMTbKORwWn4IjHTiYk5QdthI8pSRAVlQ0xOM224m7HLRJTyEnT/WaJmiL4RUgJutChH3y2cVf/eCDpSKQjX9RHQ2eZ838lbtOAkjfS1Y7tQ2i4d6RRkewpQRpnOJAwt82gNP17ftI5YHZ1YT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ya1FhNkjlBTuhE4TmdaBdMrazAnbleBsPTEFc6aj+0=;
 b=lf8y7770rJRhNB9RFm3Eqn1wezx7evof5Az80/x9h5tYWWyU1qMU1A4BUfMNRFGNCgfefWj5BJ+0VBnvmI+/bXC2EvY3R0zWpYINw7ZnpgvkNy7sJpMgy4TX8mxpjXlQvUbjdRkeAKiQOVabezGBpTIDT+Js7KqM4ILN5IFiRE2uRdD4iNGDGb0Z1kooYcEDVXJEcJoynCZ1eNjHFaJHdtVWwgjszAc2iU/dqSuniXL/czZFdht+p5PQyauNpAgVG0DUiiFOf9d70xX05Zet6qeBfrqfjj3w3J66JenZjamGIpVmsoj8i89gkr/aPxWOYnnlw9KlJ4n1rL9UAlZiqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ya1FhNkjlBTuhE4TmdaBdMrazAnbleBsPTEFc6aj+0=;
 b=GwRAGwHulyGbyEzYwq3/KTzGNrf8A7WjbIVkh1rVHOyUpLiMl9/Bk0p7FxgGVBHfkHDKQWO25oLl45+aIjvHWFdNoVO9B4ccIc6oFroLGo6W3604RPm1lxKcx1O4cLNZJwefzwutG8E02HQFDfpP/fH+Ow+WrBfFV1fj3CUQAYI=
Received: from PH0PR07CA0091.namprd07.prod.outlook.com (2603:10b6:510:4::6) by
 SA1PR12MB9490.namprd12.prod.outlook.com (2603:10b6:806:45b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 16:51:29 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::e8) by PH0PR07CA0091.outlook.office365.com
 (2603:10b6:510:4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 16:50:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 16:51:28 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 25 Feb 2026 10:51:27 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Disable MES LR compute W/A
Date: Wed, 25 Feb 2026 10:51:16 -0600
Message-ID: <20260225165116.46224-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|SA1PR12MB9490:EE_
X-MS-Office365-Filtering-Correlation-Id: 137d95f5-a13a-4316-62d0-08de748e1ebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: kPOLV8hwdNYyvAQXgEkaeUSma+ACf+btYF7IU3m6VVIUoxO2EigwFz+d6YuEAbixkm43s9D6blJBlCggdZyqJaPu9EgzStr1zb1+QQn/BbC9QvY33hqDFpdbkX4owdF+1Rcz4Ei1MEY0xCofnx369LY8NJ6N7Uctk8sOH8kPGjmlw0H9zPEWGJCaV+aZppSw0HGq4OB2bvaFXKgJr9mpNagIuM7+Jioeb95Q1Qur1HCZykn47au6sNtVPpXnGQkWCAzt3XRegyvqeqm/H0RT7GWdpEpcaf6moeHIW/czaxHeiKutQUaK14AxXLShtfQiEOgpMtFgbb9Q0eKn2flvERxUgM7T775S+lfC828ulJ5EYeeO9vjZe7CL/i5tCTUlaHfvGV2wUKJtua4Jej03wwa50OCszrbjvirTzcjhs759envzRVHSQg8PUWYoQbo9zUKNtxz1vkHbYd+6KYEC/2cOokPX3bXMoc/r2KugpGMuZMeU82agreDvAboEV8dfv35RtwtOpZlwzynjeMDQuC7T2ODAfkxIPOQmvtMOWxQPVAaqrEhkPTAs2eerdoKTwamHUzDsDwm1wykmqX8Ip5hvmz6CXJ7uP0RQ7c+m1WQcXGHZHADBIfamy6zMRj2CxZOa/A6VHujjOd6u1Uy6FjQdBJOVRUmRvZm3Ewy98Kr3mU7nj8KPbYhgimxyGHe8YmKTV0XvdRa9jb24uX/O75mL1CrBYVnbDGuVOL6+Q5wfNL0RCXcgIKCCIr1XUO6s2FNHeCqYoVAKkn4opcGHxnxEqead1XKTB44lJgbu15+d9fdxWbHxKk4p5U1DMnTW70+mCJkResX5cOPhFm51Zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CAnoytMBd3U/bmkTN7DkRtPbTT92YGAlUGIH6eu/3xY/UC9zSt7XCAsSaShGtdc0A6ApIsQ2vz29imzXjdeiFzcV+R2XtHk7f7eeqAkYzdARvGB7PRKXCiyy0RZ5Yr6MXuGGOfpbHwV89RYOXZuLzNsMtE8mw8g4QyHvmFnuvVCgyfV72Qb5/3uE3ZUIZVlBGkv9k7E9J7wPFy8sQcQfgJiipMHybQaLf/Y/V1FQqfl1Aj3C4c10ECkNa68RZ51ybMIVNDm2OYfbeP7R+7qVywcgZBXjgONqu3Kf97w+cKgLrfX8dORXTHKRooJXz/zepjnr0/kY/b9j5TMrJIHeG3jvMUE++bmkIQ0eIeViHOaLn77obh1NC9luKBEgoFxOq9B1ts7A4OvxZ8Mje1kg9i7ZlMV5NpLxanWq4OPivoKL6bqVZCnTHMigq0fj15NO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:51:28.2526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 137d95f5-a13a-4316-62d0-08de748e1ebe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9490
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

A workaround was introduced in commit 1fb710793ce2 ("drm/amdgpu: Enable
MES lr_compute_wa by default") to help with some hangs observed in gfx1151.

This WA didn't fully fix the issue.  It was actually fixed by adjusting
the VGPR size to the correct value that matched the hardware in commit
cf326449637a5 ("drm/amdkfd: bump minimum vgpr size for gfx1151").

There are reports of instability on other products with newer GC microcode
versions, and I believe they're caused by this workaround. As we don't
need the workaround any more, remove it.

Fixes: cf326449637a5 ("drm/amdkfd: bump minimum vgpr size for gfx1151")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 5 -----
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 09ebb13ca5e81..a926a330700e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -720,11 +720,6 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
 	mes_set_hw_res_pkt.oversubscription_timer = 50;
-	if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x7f)
-		mes_set_hw_res_pkt.enable_lr_compute_wa = 1;
-	else
-		dev_info_once(mes->adev->dev,
-			      "MES FW version must be >= 0x7f to enable LR compute workaround.\n");
 
 	if (amdgpu_mes_log_enable) {
 		mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index b1c864dc79a86..5bfa5d1d0b369 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -779,11 +779,6 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
-	if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x82)
-		mes_set_hw_res_pkt.enable_lr_compute_wa = 1;
-	else
-		dev_info_once(adev->dev,
-			      "MES FW version must be >= 0x82 to enable LR compute workaround.\n");
 
 	/*
 	 * Keep oversubscribe timer for sdma . When we have unmapped doorbell
-- 
2.53.0

