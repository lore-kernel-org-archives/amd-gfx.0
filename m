Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57A2C982D3
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2242C10ECD5;
	Wed, 16 Sep 2026 17:53:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GBD6y1v+";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012062.outbound.protection.outlook.com
 [40.107.200.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67DC210ECC3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMF5GC5Vzz/QVM71WW04RFPPZX1Hlqc10neVuMsytk+KXIQiMtwe8Js89sx0rQsW49NwhKl0NTV2o3O/6s66GH8ZJ/0sPebdIi2bITtykgwo+FuI5tIoR4n/3rZ3jWL39uH02mBUyMK6zXSaEQXQ40kO9YM+pOmlqgvTOKP6h1wTivJCU9b+b1HzciSiPTEkVzBvqrgoj1WBp4i13BISFleY4n3E9jwQnOUXehT+E/UKEYt1ZnPSFnmzpXy5R8OPQlpq7Rjb+ivSk+tvcurugjZ4SqdATwttmKzchXaNvex8FsFioR/E3EHgZRGJrFsWOT/BuuVcmN7TBWeFe+FZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLhVz+pWtIdNLtRrkByJ2dMXCiFnOHuPgiATzi1Efa0=;
 b=t9HsCGneO+hHb87q3EM6yeqg1E2yL4lHT5tbKMzTbLp2TfQoAGYIAEz1s5ah7AjFt74I2I7qyt5sLWOcOyEo7Z74U9WZdJD8YOnbKdeUByG87P8KCVLg4lMvyZJGuaGRMr9RaBvWDrtLIkEgHbZ9upIvl11THQNG90STxo8ZP+SC4fxuV9L3BfCbB41gPFwSMKpv0y3Rtzw4JX49NYqPOiM2/BHKlm5uPkeHM2QiGqnrMc/lLtlMp6qEpt2IMQ9FD8PeyvYVfBlz0Kaw/IyjW1Wf6JfYyQps58nOJ7bAWBkroXONa1UPQQEyG/ShxfEK4y3/c03g376cFQtct4uBvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLhVz+pWtIdNLtRrkByJ2dMXCiFnOHuPgiATzi1Efa0=;
 b=GBD6y1v+JzDthRZSAu0kIGydASqBmT5oqa+I23pMmacaOYpKGoj2lmexSUmClB7MJA2dvroFlDRgF7+QDXC+bdvzN/m4LMD8+gq9PfGeSUfas8yJUZNyqwm72NMTgu2qJxc4+y+yAMOPzYfEMwsdQ6d/n0+u/f02/FzBEUSTfrs=
Received: from CH0PR03CA0183.namprd03.prod.outlook.com (2603:10b6:610:e4::8)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:52:59 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::70) by CH0PR03CA0183.outlook.office365.com
 (2603:10b6:610:e4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:59 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:46 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>, "Gabe
 Teeger" <gabe.teeger@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 42/64] drm/amd/display: Fix DCN42B plane alpha
Date: Wed, 16 Sep 2026 13:51:57 -0400
Message-ID: <20260916175301.368306-43-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c0286a-2ec7-4c5f-d999-08df141b5890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 64nxdEMscSefqwpOJnsFVqkwW1w+EY5GxBYYQsGhjQpg5b6uSk2/lyFrdAHd1ZGyoTm76RvijRp8Mci1UzXzdW3K9OIJLg4NTvT6HIWwjOdNajmBcQX/ga3TQBdY1nj+o1sAvkfM9NfYaZTxIzX1GtPx3qKIQoiHVm/3bt8OD06csNw9pX2neVgbpgJeiV8mNF5j/ufvUWarjuxOt+GOcVrDcAtwlrS000N935t0EIsh9AF9rRqF2oeFXh9niiDXtqKauhS3PbCnC9+NyL5csaOzwkrmySQ5tt95COtn3OPj+iDuUMlil918kh1c5eqz6AtPICi0vTZQiyYqyQkOn2l1NvASlYWDNfRlC5cH8/jKg7dT8XIDzmoGCEwDDy0YykiDgUQSMQqqnGup73lQukMPPmHcrtIDRdYcqW6qhRR8PUyjwGRALo3pjhaIuC9zOMd3Z+S+N0vXM2u6A67vn2C+SsVwtCIiE6II142MMYYBvBSoQicK7FkN+yPAuDq3CwwHIXz8WEQHcAUuVZir4NrimyH8qxJVcs0BUSgCpqnL6ix7K4tm52YUR2OSi2k2t5KvApRF7A5PdxLeiUYSKMyGASK7eKvT9v+waBf+vsdcZl5K3Q7disRUC9abcA6YXXo/EZgLgCYfFRPZxZZTbheD7pl1g9uC5mwQQoZW+FaYVGpWdcLVexgGQrXKBkRbyHeYvmt0HyUkTDjrHHCk3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rUFUreFEAxM//JGsNxrX6HNsAHq0wmvnWtMOLhZX7d5X2n7Le4IuYuoiRdqhmYaOojif7Ajn+vDU/VnvtacQnEWWUSsW09BTD90Ao4Wp3XqZVlXDu/UvQzX8YS7IUFHgDBPo2zm92RA7IwHNMqYigyNVWfLoj7SUCl6g4DgEnqlP3gprsND7pCMjyGp3IMoNjaGnLXaImkDrgM+ZV9AS6QXN/XMsX4GgPOhs0kcKK+Nkb6R6uHgzdaG+GcjTNyU6clUm48KWWETDJCqdeAZK6OJ5jQXtmTucRe+IT2CSrgYAdg3SaEx1D6tqstcd2oUMppdS6Z/YSyVOfkCRB0x1N9t5taY6I6HnV4aPzOiZtDdPMv9CxUKx2IVSvIPu9q7m/igoz+AXP3IFFFsQ8Zf6fDzJ2Gpptzb0l3juEy31+BaE1H3Altk0E/ssPOaG6VVY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:59.1911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c0286a-2ec7-4c5f-d999-08df141b5890
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
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

From: Matthew Stewart <Matthew.Stewart2@amd.com>

Like DCN42, the alpha field is 12 bits compared to the 16 bit value in
plane_state; must convert it.

Reviewed-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 7f85ef395013..6c1b2407f2da 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -146,6 +146,7 @@ void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state
 		 * 16-bit, so scale it down to the width the hardware expects.
 		 */
 		if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0)
+		    || amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1)
 		    || amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(6, 0, 0))
 			*global_alpha_value = plane_state->alpha >> 4;
 		else
-- 
2.55.0

