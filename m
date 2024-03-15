Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE15AC54E67
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 18:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F45310F395;
	Fri, 15 Mar 2024 18:18:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WlbPgjfZ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FFC310F395
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 18:18:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOi0WrfaIv2hWzIUfz9ncE/x8UZJl31gSOQ7t9fMjEroFAwgU0aXn3kwVYFFPp9hzf7iCi15OJ2oAnI/oxIBI12l6Q4inpvQ9ReLj/7fhzvB3coqz6Z9POv12TEWsJeMex0pwRW9Q1TS1RzULrIr/EMg+bGANVuzJdo+m6oTEWLBBxebRQPsZuBYuyWZyKqTff4VGOQb2d0LK4cx4tw6HlvfMdqvE2uiO9oal6wU6RWTMN2yEKazaW7FhlKb0Ra7yLIRe4uKPfx3OFvJk83NUls+8bqqSJuDX6T0zFtFwF+Aoj/kO3Pvv5020MbVbG26AETmFBNekhBlw/KZImiKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDKeZdB/+vZgCZXLUo47QgUeEYPGc4nnPBfnHw/iGSo=;
 b=jLNu7c3kuZLYbGTRjDZuxV+7vlSBsejISAIaTiCHJRIsTAQK5wu+7JMB1BnLjnbwAol/H3d+SFc0QkLEg4kfIt+fPN6o6M/7i90f7HNoxeXtYh6EfmV9rgpq04xJjgqfeu5VbYT4a0YPJI4Hj6CYAF+q1hEkde0Tb2luShtQnhy1HDxO40INSLHe2lMuIUQdFmmEIOqdJ2b5U4Y6qu/tyw6TIExfEnnLfg/27j3kkVGTH26kpt1TFOvQ0zZx79/8A8haCKwzv+6B9ae6Z8+MyE334fVJo1rhsLZoPLTw33wBewYRIfEteusOKWt4Lm9XlxZIZzCJ/sDlo+tyCRb+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDKeZdB/+vZgCZXLUo47QgUeEYPGc4nnPBfnHw/iGSo=;
 b=WlbPgjfZCAFLI849tB/0sjnPICZVoO8jbEm4GNt6YLwRF+hwtGcF7bQd5+x2MDyz5GUNQ2hypLns0IGL/Lay+mIYCyFGkbV+DulxLelr8Jh/rKcbGjvrgWMqSFMEozt079K3b54cMrpBW16X+WTB15dfUto8M4i6yfH48i4F40g=
Received: from SA9PR13CA0080.namprd13.prod.outlook.com (2603:10b6:806:23::25)
 by SJ2PR12MB9237.namprd12.prod.outlook.com (2603:10b6:a03:554::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 18:18:09 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::a) by SA9PR13CA0080.outlook.office365.com
 (2603:10b6:806:23::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.8 via Frontend
 Transport; Fri, 15 Mar 2024 18:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 18:18:09 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 13:18:08 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH] drm/amdkfd: Check cgroup when returning DMABuf info
Date: Fri, 15 Mar 2024 14:17:56 -0400
Message-ID: <20240315181756.685335-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SJ2PR12MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: 82243794-df93-46d7-3178-08dc451c44d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9a39v8d1OiQW82BtXYdemSk63ORkYxzfHj0tXyi5Re99/TPhYhw0yHOXwIhBhAyIkYUp+KmmAuJlDbhN/TbubcXW52irjd7veg9sOPxT+B8Np7tVKDrtngAJodvfpaM9nvMR6wH+tmTO31LUJ2MDuYlBu7gbRVR4dOFEo4be7FNGRl6/vxT2zG4bBrxYdHzFhnTxicdNiZIUEsUAO3br0O6vks3EU1YaOoIPO6jg1TqJznV9vG7GAELWBPSXzs0paArrpRm2ffsOsm/HLq0fs1LyydFGBb2gKKpalsjTzsvMYFoMS6gpaYpzwls+SRNJdA+QphR/wdEZw5BfeY85CQOorVmnO7uxd0LgHln1BV1Y9WyBGWP7MI6SdvvMluVUD4K5BFGN7dEUqUW34f23a6PP1ZWOZ8w3TdsLwxPZ2CGycroE/JHs6gi3rtz7Qjk09jatNMTvb+KtagVECWyHqJJqyRGmwPRyrOhIdbujB4ZQdc13QGCyzwPrRYw3nYWZQbQvbVcjKapRrtrHiwOpIzO1DhqKRXRj0Rm5CK1M5MnogUc7acrQSx8X+/iklG6ilsegpD1bsiW/Od3SmJpjms/HX1f3Ya+qcPwu/4XkUa/huJWRiDu+RA4U709cIaPiMjS8CzFvIYnbiLbMmaoB33JpzPFzeJgPqgSKDBnaVr/RMj+Nz8+QLsKCmSbvFJsljRa3PlnHITHUOs/JhVMT/XuiNDlFrbXvY55r7noZcvMslJnjanqcbWdn6c64v5+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 18:18:09.5013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82243794-df93-46d7-3178-08dc451c44d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9237
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

Check cgroup permissions when returning DMA-buf info and
based on cgroup check return the id of the GPU that has
access to the BO.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index dfa8c69532d4..f9631f4b1a02 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1523,7 +1523,7 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
 
 	/* Find a KFD GPU device that supports the get_dmabuf_info query */
 	for (i = 0; kfd_topology_enum_kfd_devices(i, &dev) == 0; i++)
-		if (dev)
+		if (dev && !kfd_devcgroup_check_permission(dev))
 			break;
 	if (!dev)
 		return -EINVAL;
@@ -1545,7 +1545,7 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
 	if (xcp_id >= 0)
 		args->gpu_id = dmabuf_adev->kfd.dev->nodes[xcp_id]->id;
 	else
-		args->gpu_id = dmabuf_adev->kfd.dev->nodes[0]->id;
+		args->gpu_id = dev->id;
 	args->flags = flags;
 
 	/* Copy metadata buffer to user mode */
-- 
2.35.1

