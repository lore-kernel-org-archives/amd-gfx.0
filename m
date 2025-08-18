Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49343CA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 14:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C527D10E460;
	Mon, 18 Aug 2025 14:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v4N+xoN1";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C580410E460
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 14:57:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H34WVy7rVxyn2Nrea7syu8UGuxgxlRzegAR3Ll2aPABmwzyjLRSoERZ8a2UBp9Ppe0ZffOmaQDWn9OkhQFTOKl9J7ym5Ln4CCxkwoIGNtKT5F4cTNHS2VlZEjPp2dM7CGVvTUDk1izBaBV+EFXWO4j0hjQ25xfJRW2zO9k0Y/1rXRLRhsqBnb40a9mZ2/msAcqfdbDhidUOtNCPakMHIAHW4uDGWQ95DiJYI1fajC+TVITaZpbmLTOX3s5lfaiCvDS3QDRoMsid7NwXzljjGGfKY9cZRSoAA680dPDK7dIof3d+wb2TEEPJlcdbBIuGJwzc/b0Bk9/RiRPCG1+oM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tthJZLGYhpVXcbBdS2sWXci48UM0kFNfGX3keprdQJQ=;
 b=d+a99YGUqzN05H33SY8IZQMgS7ThkSDuwOtB8/fgbFvMN/7ELfKiruIef4LFmSoxOKleLJJ7eHykIbRePw5aLu/wODJkKNzdFIu4luw6N7CRcwb5G7oz163AGC+sfQRzfDMtYu7F6A9wIzu0onqcpGw78+59RLvZwStE+EK/JgBEQ7sLfgPGfNluHDwJ43bsuWpcZGVvDrteD7oxXKuEVhMCU1CuUXH72ZGv0i3tUXB/bI/stEuT7awLGIOhkhv/jWWyYpj/rhFtHKNMG/4HCx7WOC1g0afABvbzMCBeX8xlQh1UPnYn1UV2TRhHK+OXsPfzidZCsFW2j5Cx0kxsLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tthJZLGYhpVXcbBdS2sWXci48UM0kFNfGX3keprdQJQ=;
 b=v4N+xoN1bZW0U4+cghzIo7hZtWsF+rp+NYcmA5anp54Slgdvvv5aNEKdar4fAjUDPt/Q5Mn8NUtqVThF/300sPoqkfZKOcCSi3DVc/PERUJ75f2i1nDa1vm1bOqSyy1tDd44a4cF020KLskRoLwuiYgTI6Br5J6HmMbJDx7TOtE=
Received: from BL0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:91::33)
 by IA1PR12MB6065.namprd12.prod.outlook.com (2603:10b6:208:3ef::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 14:57:13 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::97) by BL0PR05CA0023.outlook.office365.com
 (2603:10b6:208:91::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.12 via Frontend Transport; Mon,
 18 Aug 2025 14:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 14:57:12 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 09:57:10 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <Stanley.Yang@amd.com>, <Hawking.Zhang@amd.com>,
 <kevinyang.wang@amd.com>, <YiPeng.Chai@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 1/4 v5] drm/amdgpu: Correct the counts of nr_banks and
 nr_errors
Date: Mon, 18 Aug 2025 22:56:44 +0800
Message-ID: <20250818145644.318590-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|IA1PR12MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b02281-a55a-41d2-8b90-08ddde67839b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GZBSxHLqviXBLn6cRmsbaiY6p0yI+y/zta3gFDl+kA3sXgKaEtY5OeqhhGQ1?=
 =?us-ascii?Q?QJMC6GlH+AebzCoC7fxKLFz8cCoOTMysmtqxgpkTA4e+9zhuX9OhY5kUGhkR?=
 =?us-ascii?Q?m1TuoktCv+JDfVCVbGxumtm4MUabpKgInhLJbIC+5VglT/yPzXZ92UFmVajm?=
 =?us-ascii?Q?n/1xnTWwdeCleaza7SMe6Rbvcax0yNvk33uu+W0l6nVHlvJOxgz9V+3LcFK1?=
 =?us-ascii?Q?MxTB7b2Tpg1WtorWBEuEtITAQNiXJOFzdilF0iwKyfEtK3zidLlnWzHZmViq?=
 =?us-ascii?Q?PFkU0P+7tAvNjLXqSv3f0TZ0/9OPMp+BTbSjEKxWPMG/dASK3DY+WFTFecWk?=
 =?us-ascii?Q?kuZKAZpDs5W3SO48npTzG3PTIRx9EsMvCNExpLVA+FZIDdo7ms0W2Ak5gg5J?=
 =?us-ascii?Q?k6VBNLjPFocnKGyq/EJxIVxiyQiTtZQxHIC12g63hHTDkX9V1LyUJGGfU1yL?=
 =?us-ascii?Q?yjJu07qz+rjNFIQ2UQIyQeRof5132R4jmD2/9lW2gKPJDQcKoHwf3G+iPwxo?=
 =?us-ascii?Q?IPitCMlFlRMFJbUAzTSM+tLrJN3ZRCNkT6Kjxj9ocXUPKgjkobsNlfutF8KU?=
 =?us-ascii?Q?dV4vErRXrevvq8hbw+YrSXSbES7wMxjbrFVbYqWU4Pyoz3OfYXjtkfn3paih?=
 =?us-ascii?Q?yg8IEb6goJOp7BTK8V8S0f7Loem4J3A1RyAplfdfoH3QxRHl2YAIQQVOATVR?=
 =?us-ascii?Q?fCesW66tAYHincFQpz30oI+Gi/QMY0VK5JkvNb+Fnkxxok8panRc+ilM3BpB?=
 =?us-ascii?Q?JEBsEu1UTE/LbGDlmrgKx55UPbcUTgqzogs1h2CUGPpMMKw9dAzcf7Fd4CbA?=
 =?us-ascii?Q?ci8EnBPKbqp7iYfPWEyUmzhajrgH9D2W0B/Hscrk2lmToW3sUnVrk+LIDoag?=
 =?us-ascii?Q?4Jtg3qYC1lxntExEv9nMqK7oWL1xJWff9ED4jdwPMPVlBEswHFabd1K0S2Fc?=
 =?us-ascii?Q?Q9wdM95zGcmkgP2VxtItvSQGneoB/vN44VgATJhVlS/GXKrL3Wvv6qgetce7?=
 =?us-ascii?Q?2HMxERTN4h1jZAR9vybEzEAuX6t+CCBwq6iI6zb8EjjKYzzn4WoFScMiE0Hb?=
 =?us-ascii?Q?LT6Y3YVvZWsI/5azcwQzYC1v3NTpV20NsUx38XiXLDuKmECMPSlF+vhJUh+D?=
 =?us-ascii?Q?Y8GHYBHVF5eJzSNkksGEAT0zqcCpkaJkC8fvR8Su+v3FMWMW008k/hIRYyGn?=
 =?us-ascii?Q?DcdN4QaHOARnwowT0XMO43/2ce9B4X5C7PJ63j6Ot7qwWJ3y3k3PEIY2WM4o?=
 =?us-ascii?Q?9LS0nK2GtuaukLHdcYo3EA6IjWMttmSwEkEgEQFxVh8L66BNcaEFRPk5+CRl?=
 =?us-ascii?Q?rgE/s0VPUjyjVYI8SyzsbvPYv16Av9MAn9EJZmBvgKwWILVbimfvIvXDWqUS?=
 =?us-ascii?Q?5yrWDf2iNjjDwZzq/Qot1YZ+yjwdwOobL6EhREh9w5OZgNsFdMsdUNDVMthg?=
 =?us-ascii?Q?06dz9EMP2LSycSXQGJvQz890GnLzOqul+rVwlmBImDM0yYmZ6slQ4Cc8kxpf?=
 =?us-ascii?Q?kXE4rbmd76Odd9oAHwGFk6LjLZdiRNDQuQbG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:57:12.7036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b02281-a55a-41d2-8b90-08ddde67839b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6065
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

Correct the counts of nr_banks and nr_errors

Signed-off-by: Ce Sun <cesun102@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index cbc40cad581b..090bf6cf1b91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -76,6 +76,7 @@ static void aca_banks_release(struct aca_banks *banks)
 	list_for_each_entry_safe(node, tmp, &banks->list, node) {
 		list_del(&node->node);
 		kvfree(node);
+		banks->nr_banks--;
 	}
 }
 
@@ -229,6 +230,7 @@ static struct aca_bank_error *new_bank_error(struct aca_error *aerr, struct aca_
 
 	mutex_lock(&aerr->lock);
 	list_add_tail(&bank_error->node, &aerr->list);
+	aerr->nr_errors++;
 	mutex_unlock(&aerr->lock);
 
 	return bank_error;
-- 
2.34.1

