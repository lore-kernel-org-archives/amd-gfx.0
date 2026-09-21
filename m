Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3F1C982E1
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B0FD10E56F;
	Mon, 21 Sep 2026 07:54:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W/piXzoP";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE21E10E552
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:54:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryDTe7Ubd9F5ToOfj2uz0DraH/CbUNwugjKmRb4nBzeik9AZwfUoYN1WbJXHUHmXek7/LwY3sUHWtQAGmSA9mNIBJQO2VZyuWpzO3Fhxqbjvy8VzIwJiZ5ssTxgjg0Id6zAMTkmp/j5sMjXE8Up6egVPyi8lajiujLU97zlY1esleIKeM3qeWvFdhk/m/YRSHhcrXbT7s7jGrCr3lWQhGp25s/AJPPWQquO0ZLkb1xJ/IwKj1aQmAxUCH9d/12E41ENdX71VV0shv1vdm7WE03t4faUTWFD1Eeubfor903j/ipj9T3jesHt8F3gXlp10qcDRwMJQlJkRHQaDK9sklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLOYrm18oYRo++VpMym6SDzBEyksn39B0ndLdqJJnJo=;
 b=KdNSzL8pQN3ISVB4/D3UhBHwRmuxkzUiNYdI/ABWZyUvm3fFKbApaqrCrzQafPe1VwvkVK4z8Y+J5qYOc4aagnFw03c1s20voz797gtlS5AH9WyEeckuz9lT0k5d8RqWvN5+oUXB/GPO0VJW79D5w5BAZhjE4XNEAKXj5KLqr4qkc1bpqelQqZ++rQLwp4aRYMQVYpoD/DzJCasV9laC3Lp5SvNg1Xm5Lv7ctJLQF7rzRQaO4C99LLAFyu1fD/hdz69OhNrZTwH6Fn+k35zomSro1fLSojxbf4H0e6Bl4OUcYcSQshjlaCUyngOALSQXpqP2gk9hZwBzUCNLAmg1Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLOYrm18oYRo++VpMym6SDzBEyksn39B0ndLdqJJnJo=;
 b=W/piXzoPRP7BX+PiyrTmsK8QgMKK2KLB/OnTmGLGLPTKOLhqf8vBs9xj9OKZtwy3NRl+diEY88mM7An6dKuOKjkwgjhwS0SWvV+LQ1FVi/sn6zdgxYqhkt2PV+fzx/qSljzsb36RxGW6npxclhr+nuTdw9GMpr+2XwCW8aDl/XQ=
Received: from BLAP220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::16)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:54:10 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::2a) by BLAP220CA0011.outlook.office365.com
 (2603:10b6:208:32c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 07:54:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:54:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:54:08 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:54:06 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 18/21] drm/amdgpu/mes11: gate gfx pipe reset on PER_PIPE
Date: Mon, 21 Sep 2026 15:51:25 +0800
Message-ID: <20260921075326.2409021-18-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8ac120-23d2-4682-0cdc-08df17b58507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: u/P9/ZBP7hvq+SNFy+T1dw1LidZLwIddUszmRqJm/v5gqojo97462BiTZa8g79OLFEImQJzyEQsq+oo0CKWC6wIqHcmbTEwuAhAWTYhCa9mHtPLpKHp3WV5/fLs3ZgP6cCU3DNKfshpJWVwZJ+pJqk6vvLphS60LxMtwlwKUKT6dzh4cS22TC/lPwvDGd7fC33IVlQc6O5l9zQbnCxjoVbK/e77I0PiACsL+hxFMIzIsKC9dDuUaGMGW6mZ+6B3e11zRPlynyDmKLdnEsjlJHhQEpYDSQFr9N+3Pwm/Uatug5LWknUIRNBFwqYINUHFhagl6C7EIToB9+4OBXJb1521pfLx1ZnKYmHI3IkaKprzvaKFEQbcE8YPAa9Y+I0TAMzVOx/wpWlouLgAdWPwNejIMrHg3X1Od/vFVAmVwhFcZXHDRXhI7MABi/ThdUP+DAinKDq1ODuLjJwtIIGYPg3qIJiPlTr+8Duhm8DoIJaPFzaiV69LbNunHAXLqxGXqp5bLnkQTfwaw45h5jy5IlrJ2asKtkdd7fwZ30fAWm/OIZ7H38UU5SWWY9HZPFKu/OCU4jB7anzo1ydrVSQuvJAjhX2Tu6KvCuMtJ1ULFOlr/Jk6hI52fp0qKC48/IyDrFFX1S7fvhbNpYb0y5PmMkj8dQ2UJJDk2zE5HH3L0dEGLK1xirWgC3Lj/a8rPLRLO7MaNSCMIJrXdNKgE1XnSzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GrF84Gc83pAh9RuqlGbtaFNopr26bE/OTqW8JfWABcvYu52rk5/Aee1B5jmQt32hNVLaqyABHwoX/bXoDd/BYR7nykQyYpxQiKAzJ7lRurDGgkTuSlV6xFQ5wS8JZ4fonbQPaP453ALe7XEgSwZMZ/KFWKGR8Xr79qy1alf8GAiR1E6SyS1oUAt7KxL8frQLAjApHNO7RTUevUfDZfkU0jCqJ4OJ6LcuRt7zegM1rtFiylhtoizVROw9L3K2lHR+LGi0ig1RallFxyF3udOKrQmIwYOXnHJom9Jc3qZPHR0rRNoP4OiiGgkuChimA/k7D54tvXNXj8PlrHYY7dCtpD42AtDOyAbLYFPpEoh43qsJdUiThaHaM3h7257umbeHYn9s7qGYHbLy2M70zCi1VSi+J9tkgflVxw5sYiNMNjj4sD2FZF7mJDDql5grKGv7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:54:09.7816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8ac120-23d2-4682-0cdc-08df17b58507
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453
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

Replace the disabled pipe-reset stub with the shared PER_PIPE capability
check, so GFX MMIO pipe reset follows gfx_supported_reset.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a019b1926305..c98e2fcf8b70 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -404,13 +404,6 @@ static int mes_v11_0_remove_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
-static bool mes_v11_0_pipe_reset_support(struct amdgpu_device *adev)
-{
-	/* Disable the pipe reset until the CPFW fully support it.*/
-	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
-	return false;
-}
-
 /* Use MES callbacks directly while holding the MES lock. */
 static int mes_v11_0_restore_gfx_kernel_queue(struct amdgpu_device *adev,
 					      u32 me, u32 pipe, u32 guilty_queue,
@@ -480,7 +473,7 @@ static int mes_v11_0_reset_gfx_pipe_mmio(struct amdgpu_device *adev,
 	uint32_t reset_pipe, clean_pipe;
 	int i;
 
-	if (!mes_v11_0_pipe_reset_support(adev))
+	if (!amdgpu_gfx_me_pipe_reset_supported(adev))
 		return -EOPNOTSUPP;
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
-- 
2.49.0

