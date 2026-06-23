Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2379FCD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 06:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 953A910E975;
	Tue, 23 Jun 2026 06:32:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YUp1JjUE";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B2610E957
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 06:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvKbxJNhb6w+gJqCNrbHEnhQ11thcG/mPdBwxl/LUXqNDB4tZGYp7Io86o+MJtCnGD3I0yJBXMmnGRzkdQsYrPI61TYmc2pI+jND3oCyjQliJrBmzEqW3G/6GZZOPmQmQ2NesEhbbol8ksN9EF4Lpz3Io3HzA0StQ/kGV63D7I25CBtxiGIouEFFq/oQtQIk2F63JCia8CqbnI4lZ9QFBt6WVcxH2hXzKNI1itLVGf3ngt732F+3T1HoP9LMq5diOJbI+xu4aOywpwOhK28hlq0rNtugCnBFeNrFSRAqR0A0gQzJeUwTzAuOa1lcfdclGIwM+6fg4n2XKgbgGmQZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmywznQotrv0cEQvd2J9llvxKWvfGmbT5UnAw4988OU=;
 b=zLSAL1gtFHW1l+smrfLzEf1EqIQ6KK1lNcxhwwOfx7z5eVm4cdVUDVG8ScwUEkKLXfQQjtAiRp9A5d185u/lpP7RXwkupyD3GuXr3kY0AKXpBRASdDHp70g2mgwHbg5dHuLlLEY4RAAdVm8fSPCt+/ETFi683l0mG0rJn534rm29cqxOolUnlQKS66byCf/8TGOaYNSnSDnqGK3Z9yc2xiE5LO+inCdxCFsFAwQvvqnJa/NMRXgan7ZRdYHuE6usDSHmFdG9BKQi6UQWioqWxG8zuJvpqxMfIcxY59d/OUcNDecCvJGTMlUQrEsht3LW2sK6IdpKIO2/difZmbj5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmywznQotrv0cEQvd2J9llvxKWvfGmbT5UnAw4988OU=;
 b=YUp1JjUEjxQyhvAxXolVu0jt3Z2bMZ9aSYCPwenfBZnYTCo1/IHWZWr9RVB+PDPBU38ZFc1uywlQqthceetNGzCHnCbxfe5MeGPgxFJZkYs0ltDX7WBdDnZrTtF87FsDUKBeyeoppE5i3/qgzMBL20+CqhpJVVMXEHsVJQonAfM=
Received: from SJ2P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::16)
 by CHAPR12MB999250.namprd12.prod.outlook.com (2603:10b6:610:300::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 06:32:21 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:5da:cafe::98) by SJ2P220CA0013.outlook.office365.com
 (2603:10b6:a03:5da::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 06:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 06:32:21 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 01:32:20 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 01:32:19 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Shaoyun Liu <shaoyun.liu@amd.com>, Amber Lin <Amber.Lin@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/mes11: set remove_queue_after_reset for reset
 unmap path
Date: Tue, 23 Jun 2026 14:31:21 +0800
Message-ID: <20260623063218.188781-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|CHAPR12MB999250:EE_
X-MS-Office365-Filtering-Correlation-Id: 06040cd3-688b-43e9-bbdf-08ded0f12e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: J8DO5K7SDaux8hef3lM+aW9QA6IqKDKsPsR8y/+SDxR3JXC/63jjm6Kl3rRVCtkwrIoLOr+SSJJd9AZ8E1+v8UDuamdfid8y5YRdl9PX9GUjMa+6DJ2dF2BGUijOzBHJhWKoBxd72i70CINm+p44nzZyw0Z+3i4fon2u8Cvb5AYCmofzV5dW5ijPZhzW0yMDYIZSd2zL4oNta4kpqXQ8fGPSk/VgP0Nw9wxhosYPpINnqp8+umw2IsRegGrzqgIewbC0qK5vBVLwqFcLwZoUQa1GdrHCSdZwFxKlM3qQxG/3GLFn12zNZO/I9USh9TjNw/dGYmssfUbl3yQwPHxDAeVENp7roz6l2joHZpizfFxRPoODcE+QrZrKQxuC4EKcZLkBUrB0l1t1P086oHPsGGRK0m2CG1FlLjd6WtFgxhJgHlnBJ3JuRVhXtQLdZXaH4JMR11sPWEeiEHpn6vUoxFKo+eiau0OOFmlkocLiLPCErOliQL2HYCM5Do5bshYb1ep/Hr7IMrCynzCJNBpvxB/K+xm9tP8UayuTECxeNGWDv1si7bld4Y3Yv4L0gGavHWmNkM96VFbUxaTtzH/+YruvJWE2z0TiIVhlaINjzfXGL1kkSp1SvZflYmsmR1UIdPr5rueS78S6qy3vvMwpxt0ElCfeYAf489vY+3MDFRZS3B4hp09iBHs2kTl20MW2TzMVmZPy95amxH/uR+CwgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /yKkBheF/H2uTWqWFiZpxBV5EEFvfNipwLs2mCTmJPJ8LS424kq3VSkvOd/0mLGh3EcgirglRdQKj6hcp3YwchHUCZbmmRe7CQTiag6Sz2OCX1X9sJMRQmO/wLMbXA3AB1u/Qn884jptj/AHzYKQMTpb4LPzMQu87C6cUT9or9G9TnS0EWSj0yNLe5ixFCYxuUsqhr8Esk5K/+MQSsAUNe46Hfny8iDxp6C9T2IXUnaT5+OAiQ7AFHSzDMDILshtzsowZGWqBLZhVwXKtBiMmUJ0vOYSWzJzDhE11n68zVowP+D4sleHKc79+8zGF9xJMG3hQe71FnkjXU3RyBmQ6hsVb3OYMMtMX4N0BZk+YUYoMLwS9t7WW/HYwgomit22P/Sl6hCby5pmiOfhZ3gHCKaFoHnBzzJNOne8oLJ7/5ck46LKc0nvR9vhUCLmckig
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 06:32:21.5258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06040cd3-688b-43e9-bbdf-08ded0f12e59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999250
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

In mes_v11_0_unmap_legacy_queue(), set
remove_queue_after_reset=1 for RESET_QUEUES.
The queue may already be MMIO-reset. This
flag tells MES to drop internal queue state directly instead of issuing
another CP unmap flow, reducing timeout risk during recovery.

Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 9e27d01cbfa3..7bc756ce7aba 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -761,6 +761,11 @@ static int mes_v11_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 		mes_remove_queue_pkt.unmap_legacy_queue = 1;
 		mes_remove_queue_pkt.queue_type =
 			convert_to_mes_queue_type(input->queue_type);
+
+		if (input->action == RESET_QUEUES &&
+		    (mes->sched_version & AMDGPU_MES_VERSION_MASK) >= 0x60)
+			mes_remove_queue_pkt.remove_queue_after_reset = 1;
+
 	}
 
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-- 
2.49.0

