Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B09CD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 06:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E682710F94A;
	Fri, 29 May 2026 06:20:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZN5EBNmd";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5DFD10F94A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 06:20:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGRbRbetKk0ZNzjSduPzUxqn9aGruvT0RCKYl6N+SpP8k3dP2KyyvShNQM/mXnzJtRuYRrorHTdsJhlr5SU9ePQd+cbaDP/eyfJCEgnf/rg0FBME9n62iPzPmnjfi3KJkQtxmxql0K38ccxX2ryDtygxxWBEN8SRFyHGPOaCVS3sLkHm487NSE2lAX87MX+pBuc2H4qSKtPr0UKU8nsntVJYkreGhTEBHVv3S694CxfjsIP905A+/WvCzvp6sdmBsmZToYgBIOGPTM9a73O/xdNHnaB2eiUvVGOgEi5eqkfoYAC/N+k+D+Xh2zXiivLoL4vvIPai39h+IjNYmE2SqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1/iiWbJO07oqm0/fflj4KkTnCancrVhE7l+nfi2gUM=;
 b=aa8wvwTkzO5rOxI9oEj3tave0g1yaZ/iy2X6/ONntv7L+Ca1PxvqXGEae4vymymlRPm3XKHKFvhxYeFu6YEVcG7jR1t4XuXG7frWyKFgYBvxmI25FzI13mGApkhVnCC2LgtEmuxicjZkik7d2yVMOayqA9TGexBkz8xt2f6x/igsvJwKpoqSEFIJJHocHzLEIVguu3AT4dT1c4HHfTybwN7LyREc9QfdLAWI7jqlv+eyiGOi7Ya9kB0SvMhzLtMktzy6wVU+euQ8zK/WzGscjUmqpJjj3W/aGTK4eMv1VynKUxFkUGysCnj9BU5sztcdZ/Z5XPNvBh7i2VDqGzvGJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1/iiWbJO07oqm0/fflj4KkTnCancrVhE7l+nfi2gUM=;
 b=ZN5EBNmdJ9kltS/5vgmU9Af6xwyDwRJSf+adcVnRnTLOLneHBsZnaXPZoPukdP6Snq3FaViPptwIvbntyG1+NTprZHsVVgTHAbkeuyp4kmRdsNBUz7/SJsptW7ySma63YaV4y80WZ0l/saQJK/YnVDd5AEcKORd3RqMNraCttig=
Received: from BL1PR13CA0335.namprd13.prod.outlook.com (2603:10b6:208:2c6::10)
 by SJ5PPFD525C5379.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 06:20:23 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::27) by BL1PR13CA0335.outlook.office365.com
 (2603:10b6:208:2c6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.4 via Frontend Transport; Fri, 29
 May 2026 06:20:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 06:20:22 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 01:20:20 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: bound pp_dpm_set_pp_table() memcpy
Date: Fri, 29 May 2026 14:20:08 +0800
Message-ID: <20260529062008.357699-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|SJ5PPFD525C5379:EE_
X-MS-Office365-Filtering-Correlation-Id: 4098a404-ce9d-4f7c-9f02-08debd4a5d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: Gw05ZSWCr/7mneF4ml0EJs7vojxDaCcguuOgYuGfYj0EhTNyaYQLpX2jFW+ZaNSAsHuwaiDvHBFsV+juiWByHU3B4CgB/w4SvOucvvLdzlJfj2sVTbxsqXTgdyd/ViSkrEjRAA05Y7+nqBfvhQCBQeZEkSpgWko/aGm0IPoYQs5m/riokmAw7UgK5vWVYs8ljUp9Qas405XsJ+aVXtVPBpRW88w8/T+j2s5r494Td7jo+m7GFF4x/C6YyXedHPWkshCfP8sjnI8n0oFHHaev2FgWoiMFmE0FPAukhy4gSRttbjeudBEiYXVLvqf4kNjbBFCq5ziXhJ3F3/2a2Oc0PGeUjULctvMuJ8lQdVnbFS0yySSkdm0peH9Wq4NS7f5F7uM2VpQz01iOvpfpPhyIoobw2sgcyn1MJ34m26AdBvkNFvLMJtgldg+B9kJ+0UPGr2va9bjWYGanf8FMD/dC33yPS8hSIVpmCAObH+CQ2ibRiqmIDsZ8fjQRfdHujnWOB5BSiQ+CHmotdKUeB/Yrh9odX32/K25oVKbODawg70+HuM5s53IYcVTteITlJIVlCSMwwzHrj2DCWY1lr95m8turKSZGs3v8tAOP105RtGA+uER/i9EcM3oaFLaktBdq2ZIGU43+KORQRB9gf3VNdA8eAwqqk21RwMk5zuoCttzmBh3Vcy+iFa+sFBaQz4rdpxHTM9yxvEaZa7jzD1XxizFGdB9JTnuk/cBAoJYf3h4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lLTQTAeVCwfMw6blNWRYi3FV5II83uHPEYwt7I2apan3RUnciOOFk+0kVsWgTePakZ9HPkvClVwp1JaAqzAiHwd4x5CJK12xr57EuefUK+E/yLmVj69ENym0sHr5Y4Gz1G3/Dud08gikKQV3dSuOkSYGDausvWQwSBOenhLiS8uVciG9/ozoWu/S+wKXWQ1QcwM7ZCIVpZV9dvqaBEf5oxfA8KvVoJyNxVOY/yI0BPDbhKvQMED4MKL+53tn/GHZyFUW1BsO370PexPhMpulmQugpsspHssBOvuN5sei8t4imLcZI+XRejAhOhOVn3LFaB4cQ5fQRGu3b1cbOc0scCNCUojsP8KlyMXD73xOitXmyeIVedWsg0Up4AwcZm6VJxvbE1N0CI0bHQu2XB59Qi5/yMbtzF/Sol1x4Ow1wGT8T+wRgXTpFg4JJxT5jU5j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 06:20:22.8079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4098a404-ce9d-4f7c-9f02-08debd4a5d95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD525C5379
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

The powerplay path allocates hardcode_pp_table once with kmemdup(...,
soft_pp_table_size). memcpy(..., size) used the sysfs store count (up to
PAGE_SIZE) with no upper bound, causing heap overflow. Reject
writes where size exceeds soft_pp_table_size.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 3ee910503775..35974fd02b27 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -665,6 +665,9 @@ static int pp_dpm_set_pp_table(void *handle, const char *buf, size_t size)
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
 
+	if (size > hwmgr->soft_pp_table_size)
+		return -EINVAL;
+
 	if (!hwmgr->hardcode_pp_table) {
 		hwmgr->hardcode_pp_table = kmemdup(hwmgr->soft_pp_table,
 						   hwmgr->soft_pp_table_size,
-- 
2.46.0

