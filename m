Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F1ECD4F54
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 18:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E68410F56B;
	Thu, 28 May 2026 18:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O9x/YVJ7";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010050.outbound.protection.outlook.com
 [52.101.193.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD2C510F56A
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 18:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOtV3QAuwbrsfUW0OHaWsRZA4K+4d+aOos4opSKhqgnJWmCswBzyw91druUTizxGc32clb6+6I6t/MP5NjiySz35C7Wrb4o0Qn0Vm5Nl7hKNHUyD7GrPGSKH6H1Om21oM7O3TEEPGiCCZgdaS0GAwnZYTpZBh7oR49d9EhM3JLeFMG9tHP6gE9qgSvtzFeV24tDZNouCqSIgh5LOPJ1aEeb6Kg6eoSYn20EQAjmGTAQqfP/NvJb3WbifvwIyLLCn3SxAcBTcc+ATkvm2o3DGkEi+SxOU92toRek5/loMPj7lxX5ddXvBFbwmbyaMatl0em8JqCKC8TKYvIdr9t6YdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSjEELAvt3ZOaYUzjhKP3/K7pxamizn8t3pg14TEZb8=;
 b=ZMdEwgDbfrPp2QWhuhbstYsCP18oFPSoYSGcBzEZ7tfzw3UASXUBIpMid1re2tWt5PDEyrRopDmXyiS/eG0CWf9xr/dEEF4V/qgcfqm1jO5pU7octpesqS+KSNJxCYeSnms3aq+21QDjaS4GDxB41BLTnQx9PEVHgxrB9uc4Ji2wkfyOJZs+iP2TqHhiQ3U9wTmjNapFZ0gHbvPc6gD8dB18xK361Y2KuXIjNMFtX+4DtB/cQ8vxRzGxKqdCiFInALMZIeEBHMgtUWdqHTr/lYVwMBkkdxpzpP8Wai58vo8YX3Rr35xoVT+5VrWUmRdwsnOaIhtAmBcXGlNRBi0QPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSjEELAvt3ZOaYUzjhKP3/K7pxamizn8t3pg14TEZb8=;
 b=O9x/YVJ75MmJDHW4lyuzzMNquSjlOxJyNXuRlIDqMWuJVxn9skTy2EZFBmvXcdZV2COxtLZQP/4fSP5J9gEpeyAmdpM98/XSAxBXIDtk7paRlhVa6/Clt+p5KAH2q+ilh8cwtWrz6w++RQGLg2+c3K+VFSU9TtaBxASMjPZNeyE=
Received: from SJ0PR03CA0155.namprd03.prod.outlook.com (2603:10b6:a03:338::10)
 by CH8PR12MB9813.namprd12.prod.outlook.com (2603:10b6:610:260::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 18:47:20 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::3d) by SJ0PR03CA0155.outlook.office365.com
 (2603:10b6:a03:338::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 18:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 18:47:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 13:47:17 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 28 May 2026 13:47:17 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH 2/3] drm/amdkfd: check find_first_zero_bit before __set_bit on
 kfd->doorbell_bitmap
Date: Thu, 28 May 2026 13:46:55 -0500
Message-ID: <20260528184656.123149-2-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528184656.123149-1-xiaogang.chen@amd.com>
References: <20260528184656.123149-1-xiaogang.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|CH8PR12MB9813:EE_
X-MS-Office365-Filtering-Correlation-Id: eb505c1b-b354-4fdc-a854-08debce98c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: BA0JWa2AKIR+4zwHWUhHV+YTjPRz1A/1g2aIiMBjUvQsS2oy9TLQXE6IWci06XtwmhCOW63iiA62/VWEpf7f2suzXQP5OzzirAPGoUdF/wDGiQ+p7RySJicSAFzslMKyuRlIpBEAeh4TRPV/nkx43RiT+L8RzxKhuQK+vqL7TyXEzaPP/67JxylkcO+r/LaUUKRUwNLubzvmGJGaWCNILzIAH3/4twrH3ynDlKrqBhfsOpTlWeM/O8zNUPWLIFW3625AjFMZ0iDRMV98iqcZxoh+cc+Jm1GsGGftCr3DxF6b/6PBDTyJDvKwK1yH0HwG0VYmYP0N/41CRswQXLxEO8to8z2PYsbQGGbzqeVD791xJ1uayElgTdhBlJGpLMwEFFrubuxMi+OxPRq9mo37jDyOPMsqWfcd1z58CsXxzTygnNc1B1QUZQmIOH0EjbeVC8Aufr3xbcdjzeSVOSn2yN0LJLcCNL79wkspKIIcxLHU//fAoeQtFtOtGZJGhiU0Xz9DclKUUPD2b1jzq3aW0crquEZ2CusT6EMBxlkKg5dMH0WJIg67ALZqqrRKMAq1F2jekYIKQh0gNvHKSh0rnwmAAQ0SK4MnUJ8KOpa99nEhQae6rkNCZ7ilx/y/YkE4YIcyJ7w66JSDheLbtIW9y/F08hKETeFL771UAR04snWW20R+NotuT4beotJp3MbT9u9O0htvI+4RL7RUje4RcNj1jKl4jOhhiYpI/4LfBMs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I0VGqwhBdSt3ui0IJ2mJEZ4ITjY7ON6beDskwsOeqpI3ugk5m6gRMHmm/Zhl48zBXpvilyLkWAdKNc95an2rMZ4LHbaHF9NUSukXOkJYPDnUDXQtVFffdA5OEG8l9WzquHX6V2rBoal3z4fKIpSGDos2zhiovn8N/MVrc3JdV+AnVDvDAzZ5F4lQRza80vNeqWmfNgsLO3R3CRufybhf7tTSfxi+bvtZF8x3ST96TW2HD5hNiywMsXkhWBySYyWrac7QOywOgRVfvSb1ShG5COtEjANdwViFgYJE9ktCBgraSOV6pVNRk0v2klUxM+AVupVla1+kRROMZvGXTUZb+7ET84wX6Xp0hW8MhfUunPMpUkLnlASF8u3dlJZ6dUte0tjKydtDmUvUXYY7/4gkwAjZHSh1PVdiX6WyUbotYqeJO5DxI2UWGIzwcyVQLkgD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:47:19.8998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb505c1b-b354-4fdc-a854-08debce98c47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9813
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

If inx from find_first_zero_bit is beyond range not need set doorbell_bitmap.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index 05c74887fd6f..18785d3bec4b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -153,14 +153,16 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
 	u32 inx;
 
 	mutex_lock(&kfd->doorbell_mutex);
+
 	inx = find_first_zero_bit(kfd->doorbell_bitmap, PAGE_SIZE / sizeof(u32));
+	if (inx >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS){
+		mutex_unlock(&kfd->doorbell_mutex);
+		return NULL;
+	}
 
 	__set_bit(inx, kfd->doorbell_bitmap);
 	mutex_unlock(&kfd->doorbell_mutex);
 
-	if (inx >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
-		return NULL;
-
 	*doorbell_off = amdgpu_doorbell_index_on_bar(kfd->adev,
 						     kfd->doorbells,
 						     inx,
-- 
2.34.1

