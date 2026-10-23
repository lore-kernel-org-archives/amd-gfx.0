Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B58606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zwmAzuaV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B1AB10E627;
	Fri, 23 Oct 2026 10:13:08 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3817112A7E
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 10:13:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QeEfrwu/bMgUMiVHX6D9/9hsVMHPa+Btoygr4z7Qcmpr2GZ9hsZUwh1PLlY6c4gP6XoDg7PM07m7wk44bV6qBwa2UvqDU9W5EZoJF1c+DI4dCiYKeZ90/GxG2CrV7dNeyIiypHnHl2Cy8qEs/0zr8bOkYXwLVzlzRV56anw9p1JuM8tjMh2hg1UlHhitj1s7xmj6PQj+lNg2g++tAq0Zx2YR3TfqwAXblqX8cyWmGdgz+htlUPHM7nNaFqabg10Mghkzso88ZTyHcSTxQVT/Sxzb9t68W4zTd8Sm6OHz7/1Chp/1x0wOyUh7D0KRxzpBXTjZZDo8GMqvXPr5k40jOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxAJi2FnTROqXUXHkr6qV72W/HINJfRpq+JrfoyoVXc=;
 b=tFi8sFH2vRkE8VgR76QyCspnPGSJG9BduxMBaltcl1mnAdO5ZJxjg946FUxrIUZi6ifJqqMIiRLi63MiGdDxtshNLniQ7sfcSu61pNlUlg5KgtlSxEgvCvjnSF2pO/Ssa+/3Tn8CLioxxawM39uCxhntitzgpPH3rTVQ5n3crwfxYLV+7G4MekSK2Cc1T7qO8kARFLYrn8+1OgMqVf8s6vIqv4toOg0fWykdk0c5dCOJ82XquEyRlXbpOHSlv5wD08ljAWJLZvOmNmAw0i08spdGvm+n+N/Ezce2KkY3TN3f8bilkcu2Xz43XWBFCaFtE6Dywg2J0tontItIEBmtTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxAJi2FnTROqXUXHkr6qV72W/HINJfRpq+JrfoyoVXc=;
 b=zwmAzuaVvfbdSb/M6iT1S99Tfvy475pxAvgVLhBx8T68l/cNbRsQGyLxBmbmLyMss48jitZJ7k0DGi5MrxNXUXP7NMeTaG21vCQLOoJ/0QmGL1sUnbv4UWB+Ymbm0s59bh0c4j/2K1SPwvVQPJLbXCD6Rzap+aOG6a5WLltwgL8=
Received: from BN9PR03CA0446.namprd03.prod.outlook.com (2603:10b6:408:113::31)
 by IA4PR12MB616689.namprd12.prod.outlook.com (2603:10b6:207:12a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 10:12:58 +0000
Received: from BN2PEPF0000A891.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::23) by BN9PR03CA0446.outlook.office365.com
 (2603:10b6:408:113::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 10:12:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A891.mail.protection.outlook.com (10.167.248.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 10:12:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 05:12:57 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 23 Oct 2026 05:12:56 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <David.Francis@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: wait for the GEM_VA input fences interruptibly
Date: Fri, 23 Oct 2026 18:12:34 +0800
Message-ID: <20261023101246.937830-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261023101246.937830-1-Jesse.Zhang@amd.com>
References: <20261023101246.937830-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A891:EE_|IA4PR12MB616689:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7f157f-7d04-476f-22b2-08df30ee3658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|22082099003|261022105027099003|3023799007|261022075727099003|5023799004|11063799006|261021121427099003|10067099003|261021123027099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 7/SCm+sISFyc7M3yZqIebpx7zuTEQb+OgjoJwgzCzRdM/9WRtQxFK+75parv0vNV60nPDPCcBKHqoTEdaxcoJ3rhVU2df3PQqO935K+cFRpcME2yyQ+Dw4UKEbfCJlxpT2cKQnaCnD6NdbqgnsNyZmA4yJcNpIs71mY4k3QhMjKly0qxkqGdiQ/pE6iCnS2fSGz74gHR8baw3+uw+hh6Dp8GEOjWhtYH1F1MeN7Y8Rtwdp+n1FsUcDsYryMKoBWH75s8xx13TJwqWQbW5x3HjfICmnFQ+HKaG3JKvCIjle7Al34SNRBkxExzSRCnQp9ZrOq0WYZLXXFNEGlbJxBOvZw3k8EurMv82n4DIKNh6UQyYFrW6olaptqFmhT4gPxrpHgPgyEWvihzfDw+CJigYliP1h260/iXmsLSxYpWcJRqS+6b26VrDuwcLLtXIAHN53ybrHMlEkE+oDxdNMPvjveSWeBshzqIvojFvutwCQMP15VYAW5sID//LkHUhEE44ZsBfypLG4IJe7CuY6WJnpSUwsUR8oW/PnvCEPWDeIa/llkF6ioEDC+kHhIsBHfaH38Sc+zlUN96Haj/Nc0T4xzh7sAYIdQ8mzwT+C+LRJ2IO/a0MtSe1auELBcCIxvDf9td0PA+nD1nU6dAvk4v/Qlv/ZlVrhxbG0XyUNfyHCK+6DLto40VUko4b2SULdb6Vx7+Gw0agDuySBDyKHhX8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(261022105027099003)(3023799007)(261022075727099003)(5023799004)(11063799006)(261021121427099003)(10067099003)(261021123027099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F79tf3Xu3RGD65YGiFPQA7eQN6MwC/PAJwI90JDoA3pAkLbll2CIV0dnARgOyQnwplIICvrPNRNROsFdJ8CTTcZipWsDgekhf88NaNf3QDPiyi9Vzfm1uyyjbYOuQKtg9PyhaL1HzV5bTzRDseFz+RjuhOOEfddbciY31BZ6mZA0xJFHQKiDv9+w0X1GZRcKiVy4CA1khCmQFibnPhOqRz8QXpitK1k9Ubil8r1kO9yvW8FuTCbGiLY0bUHOA0raixAA8R8vkAEUzVA2/mtIbogm1dyBfS/5gZC9FB5ZSKfNhnMf5mN3IhB6by/K6pmZzzTLz6x+KCIw1xUZP2CyGtBVGYoAMZLxh8OTWbHKyfysKYY12wFzm48pKmbGHv19sumaf3FZBNtQTVMZ+nupkheqUrPCJy/sEobqYKo1JXcQTJqLkPCeDg6F9b8WglSB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 10:12:58.1567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7f157f-7d04-476f-22b2-08df30ee3658
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A891.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB616689
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

GEM_VA waits for the fences of its input syncobjs uninterruptibly. Those
are provided by userspace and can take arbitrarily long to signal, and
while waiting the task can't even be killed.

On navi31, with a sw_sync fence as
input fence, the task stays in D state after SIGKILL until the fence is
signaled. Holding the fence for 260s on the latter, the hung task
detector complains:

  INFO: task va_infence_kill:17316 blocked for more than 120 seconds.
  task:va_infence_kill state:D stack:0     pid:17316 tgid:17316 ppid:17315
  Call Trace:
   __schedule+0x44f/0x1960
   schedule+0x2e/0x100
   schedule_timeout+0xee/0x100
   dma_fence_default_wait+0xe0/0x260
   dma_fence_wait_timeout+0xaf/0x1b0
   amdgpu_gem_va_ioctl+0x3aa/0x940 [amdgpu]
   drm_ioctl_kernel+0xac/0x110 [drm]
   drm_ioctl+0x2c6/0x5b0 [drm]
   __x64_sys_ioctl+0xa0/0xf0

Wait interruptibly and return the error, nothing has been changed yet at
that point, so the ioctl can simply be restarted.

Fixes: 38c67ec9aa4b ("drm/amdgpu: Add input fence to sync bo map/unmap")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index c982d102614e..29960d932e75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -77,10 +77,11 @@ amdgpu_gem_add_input_fence(struct drm_file *filp,
 		if (ret)
 			goto free_memdup;
 
-		dma_fence_wait(fence, false);
-
 		/* TODO: optimize async handling */
+		ret = dma_fence_wait(fence, true);
 		dma_fence_put(fence);
+		if (ret)
+			goto free_memdup;
 	}
 
 free_memdup:
-- 
2.50.1

