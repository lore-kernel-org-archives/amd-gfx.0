Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9FECDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 07:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E6A810E389;
	Wed, 18 Oct 2023 07:49:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E55C10E389
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 07:49:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=errYIvODnDwpov+StQmPip6qQYUt+yrk8Kpc9G7ohAgXr43z/NDWm8XYDqRro83Ybmr9tmfmu05ql7VB4K6Y6VyDIXtxcGrl0WCB/qZPi0ntMqLn/noN1u/YAicUmk6U7cx33yw2wSQOqn8qhVn9CK1qNlz2GLxMco+UmMfAU53nm4B2FNWfuj7j07SUCnnd3iK245paoOSLuV13DkdTkvBYINq69km9qozTL1I5sQqYWlAa6WCDCkKngsL9KLR76u0txiFTU0Ozy8yp7bRR/Omthph9jWYDOWM9LIGQ5ZUzOikR+2b81Rmm5pc3n0dQzBT3dER2DKyb9kzxh0Rj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXonLPvQFZq57abzNCsio5OlaZZt5W/hygXiP4Ylt0Q=;
 b=V7JmLYVVlurNjZyHnraWWCQI5rl+hfCnBmlRiGRjLsmDkGnM1kOLi9TlN2dDTHowtLhHVA1X70aZRrAjoAdArfoyEIBeLCobCIhEpPCEU0aKFvC0WvlXB5I4cjvRBPkc6N3AB70lF0YIYt2QfJ434C9tjnhxwgBw4cCsPaOQnbr7cAPszFS7+zfvRuL4ISI8SdMX2O0rKfdCMi25PtUxAZPhkNVeXvupWvJ8xp0XFXYEQPhg24lEi4zOMNFI4aaqMJugyCWkMf0VBRKniI9NDhuEqVwTnzmwjd7x7kIINGZh69FjASe8xlZ0uBGzfYgmUNz36oXB3Jw6+xIJY26QlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXonLPvQFZq57abzNCsio5OlaZZt5W/hygXiP4Ylt0Q=;
 b=D7BTnO4KIy3V7GMkvY19tlMpCk9ZqR2vJftE/9jceYDV2hjLUAD5/OOHaoBmGsChB7rMWhtj0m03li2CAbCx7ijhALO0NxcyMCrWca6nRHoztu35eSE7lGPOHaY9oTCeJPSrvOagMMzJUKs7biq66gaFB964v1pQy5WPNmaGY7s=
Received: from CYXPR03CA0026.namprd03.prod.outlook.com (2603:10b6:930:d2::11)
 by IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 07:49:40 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:d2:cafe::dc) by CYXPR03CA0026.outlook.office365.com
 (2603:10b6:930:d2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 07:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Wed, 18 Oct 2023 07:49:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 02:49:39 -0500
Received: from dev-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 02:49:32 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix shift out-of-bounds issue
Date: Wed, 18 Oct 2023 15:49:31 +0800
Message-ID: <20231018074931.139904-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 3493edcd-4690-4d6f-7f7f-08dbcfaec8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/X6ThY5dpwkb1hs3uLqMmucOcgWk5cqAMi1ZVkTNv+1s9sFw0EUZwoiT06FaTxOyIPv6AJt9ctXjs7wsYzSBYDF6KrJF2F0QTWQLITRQ/2DE9RFIY2RXtI9ZJKzR892gIAcnvdP6KVCTnQBuJSioNpwOaKhRFa0auEjaAwMqD33Q9EXp9vABG0hZnO5AqxtIZQFqBpBi++/PvS8xYbSvejCZJJsbTtxEczKHkIbz3XyrU3tOGqVbrKYIDRATuvLKnBxJzvOHNztTZaqxMHSiELgDMkQyL0nomVvbrobKhSKhL5flPo3xhE+irdV/ZAHSX5BpPxlcy3ZuAmGRhG893/xbWfPrfbKO/GA0NfWRvC5ioKKRzI9SUB9aV6eCZWYDNHURsC5u8LdO/NIuFRvRpENEI1lmqrE/HZvKX469I229oy1n8F/ZVv+2sq6r9Crv4qJcfKLPuU7ya5Ff6gdWQvKx5bGfvRgEwOjWFAiOvfHyqGAfqeQHZbjDMWrwny4UMDHHeGNmeB+8xTIwEJSSMcua11zyq7sQ2u7nxZAv8FolRQDwDvRVOuQMsSOufR32vlJQVxXwEN/sJIfsawrWiyJ573ahJ8QRI08YvC70drRyxsnB1j2DLD7LmmJ0Yy8o0NZkxZbY7N4CL7qCGbzj9tnSL5OXmd0ci6u3nMu3LadSV4PWcXrXSZKotJV4sUzSRlbClAKO/sSJbIIfeyw6ly9yfpxClDv/GvWDOgKSdjroW0y4iWa8tjZf2BPveORe2+NgwhMYxV7zjOWdZ61Fg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799009)(451199024)(82310400011)(64100799003)(186009)(36840700001)(40470700004)(46966006)(7696005)(40480700001)(5660300002)(44832011)(40460700003)(2906002)(36756003)(336012)(36860700001)(83380400001)(26005)(426003)(2616005)(81166007)(86362001)(47076005)(356005)(82740400003)(478600001)(1076003)(41300700001)(6916009)(316002)(70586007)(70206006)(54906003)(8936002)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 07:49:39.9471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3493edcd-4690-4d6f-7f7f-08dbcfaec8a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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
Cc: Alexander.Deucher@amd.com, Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 Jesse Zhang <Jesse.Zhang@amd.com>, Yifan1.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[  567.613292] shift exponent 255 is too large for 64-bit type 'long unsigned int'
[  567.614498] CPU: 5 PID: 238 Comm: kworker/5:1 Tainted: G           OE      6.2.0-34-generic #34~22.04.1-Ubuntu
[  567.614502] Hardware name: AMD Splinter/Splinter-RPL, BIOS WS43927N_871 09/25/2023
[  567.614504] Workqueue: events send_exception_work_handler [amdgpu]
[  567.614748] Call Trace:
[  567.614750]  <TASK>
[  567.614753]  dump_stack_lvl+0x48/0x70
[  567.614761]  dump_stack+0x10/0x20
[  567.614763]  __ubsan_handle_shift_out_of_bounds+0x156/0x310
[  567.614769]  ? srso_alias_return_thunk+0x5/0x7f
[  567.614773]  ? update_sd_lb_stats.constprop.0+0xf2/0x3c0
[  567.614780]  svm_range_split_by_granularity.cold+0x2b/0x34 [amdgpu]
[  567.615047]  ? srso_alias_return_thunk+0x5/0x7f
[  567.615052]  svm_migrate_to_ram+0x185/0x4d0 [amdgpu]
[  567.615286]  do_swap_page+0x7b6/0xa30
[  567.615291]  ? srso_alias_return_thunk+0x5/0x7f
[  567.615294]  ? __free_pages+0x119/0x130
[  567.615299]  handle_pte_fault+0x227/0x280
[  567.615303]  __handle_mm_fault+0x3c0/0x720
[  567.615311]  handle_mm_fault+0x119/0x330
[  567.615314]  ? lock_mm_and_find_vma+0x44/0x250
[  567.615318]  do_user_addr_fault+0x1a9/0x640
[  567.615323]  exc_page_fault+0x81/0x1b0
[  567.615328]  asm_exc_page_fault+0x27/0x30
[  567.615332] RIP: 0010:__get_user_8+0x1c/0x30

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7b81233bc9ae..f5e0bccc6d71 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1169,7 +1169,7 @@ svm_range_split_by_granularity(struct kfd_process *p, struct mm_struct *mm,
 	 * PTE will be used for whole range, this reduces the number of PTE
 	 * updated and the L1 TLB space used for translation.
 	 */
-	size = 1UL << prange->granularity;
+	size = 1UL << (prange->granularity & 0x3f);
 	start = ALIGN_DOWN(addr, size);
 	last = ALIGN(addr + 1, size) - 1;
 
-- 
2.25.1

