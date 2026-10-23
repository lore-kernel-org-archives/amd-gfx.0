Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ED3606A322
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vB/xlFl1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ADF5112C4E;
	Fri, 23 Oct 2026 17:13:08 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D1810E614
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 12:59:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vssoqFYpYm6C1I231Rzq7gnx+wJqyIqYslAZISxICIodCmzl2DHAowIA8LFVE0XsWaP9ICOzjOMv/F3oQBY3nh60OrLOXMYquV82Wysn53+Fc3nriYCdcD5bXGwo+u7F7mb00tsJyE99h+ItxHs3FVcMaZ8m/Q3DJ4Z9+BUcq7lrJGTmngufyhvXD/hjEnCBJcv8mMVtRyeN3qr+sPwLaHf86Rlh/LQfjB+7kcCbGvAPYVDeXZD8bl0atW09aMgjJ758H/FEs49CxjMVOJ7Y0eProufHHGg2Cr3ZG9Rr1hzfiJYRShYIJPSssP8ORrdyKlrLTy2bRZx31JF1yDE3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uIdjrhpi3iP/5N0XvO7Zo+YXxXKyoTnmi3pQcyFx7M=;
 b=k9HfckeaKMRNlXaZp6TaHNt78LqN5vEE7amEeetVoUoUyt9ZVQKa39IbpvjDW4OJgxh7PERE0n4Ucu2xqcw621ZN8hTfop8XhyymvtwO0r0AL6vNXI39bwRWK2Tx+09Sa2PjZiXVNpA2mjSl/VIS3Sl/eIE7NrZjLW6FPu9Y/EBS3nX5KIA8Gyl8faItu5ZfVC8tLJqOqJ5tRByGBHbGc/Y7xzsqYWfdGDjJfuuTFJNpwUUMKPQEsjMGBXOLpugEngZKOLwWSdZwGVmhC22LESiaLC9aTDtAIx452IAlH2+c9tVnxAf7qkJnO8sdMgYpWKN67gffNVaaLKXQVFSqBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uIdjrhpi3iP/5N0XvO7Zo+YXxXKyoTnmi3pQcyFx7M=;
 b=vB/xlFl1rX2yLiH2n0iHjq5lfft5W+ukED2Y6IByqXapGKTjIvtPfhjstn/n/8kz+Cfzy9YGQSbG9IMmcFD2aDf07CmbEO5sCKRExCxc79vOZM+xWFEekbz0rJGbss346LRhnb93Oga3Cm0bJfWiFBvSE3xqGyWmx1W5B44Et2I=
Received: from DM6PR02CA0128.namprd02.prod.outlook.com (2603:10b6:5:1b4::30)
 by BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 12:58:56 +0000
Received: from CH7PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:5:1b4:cafe::59) by DM6PR02CA0128.outlook.office365.com
 (2603:10b6:5:1b4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 12:58:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF00000015.mail.protection.outlook.com (10.167.244.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Fri, 23 Oct 2026 12:58:55 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 07:58:52 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <Kevin.Wang@amd.com>,
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Update doc section for board nodes
Date: Fri, 23 Oct 2026 20:58:39 +0800
Message-ID: <20261023125839.3229155-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000015:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5198e4-0bd2-4086-7e1c-08df31056553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|261009223027099003|261021123027099003|261022075727099003|261021121427099003|10067099003|56012099006|6133799003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: E2TYDuPagrLmAmVp74kujQvshaZPszNmj2FAJHxTlajbLGdskLDsXs/m+HO0qxE4HKLs4KaSSzGo1h8zMf/ovA5KWOlTDbFADHrBD8y1QrDDMwLig99qiPg4cwFirPja3FTHhLZqXRQE78jkt9+mQ/WCGeptZQX5wd1leG39W5KKeqEfon2G5VsijBMxuXGFSK1/uszLMGAJMKRO7gYe90WJanNJJco4HYHg+aPFkssdLKWDdADBUAZ8SCHaXGEaQoUEyRdt0IBchZpZKV8iboN33Z8VFctl02Jyj5saSm2y37qZIHbcev3TBEnHJpBodBhndFFmH82ESiF3nPDR0A+98HnP1RvjpBBFFnkEXU80Jv29RAzdz0xZmaG7/lJvkhSh++aiPlKOncu4hETs+UQcPsOCfEHl1uN/ChkYd4G4HGVdsqIEfZXCEiPSr7Dv1vSQ7qV1zhpSg+ykqSHsnoohnanJFaiVTiWe0j8ype39rqqytA3mOtTXo2fO6zHu0Y8qMpd15XJZ/fDeXj+7p9WSmoXd6DfiGjWmVn2nHyc5ucpkwVUpieNr5eCVWWUIIn2L6IOtIt50Yhh2LoNPPbi6D0LMLotavc69xuOIU8uBq3//I0aZyDprSwwGmijHQGZ04z2BxDIWu1XwC5Q9X9O2Di9zb8R0rs4U9W5Elprw2sWsW9Mg2sslJAr8gEYvzvPxjG97sB2e/P31oERHWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(261009223027099003)(261021123027099003)(261022075727099003)(261021121427099003)(10067099003)(56012099006)(6133799003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kUGtmmbcHeAvMrnYKdgtVRoUuUCNaIWwfB7QKNT/x7WgQKKj3clZ/ZZbfHFolIoyLdfLLh+urfhhVRUeX7eaFvbq2docpV9L1rSXR9I2WlYFYKmFEoe6DkLGCORo5+174TFHfPFwJ9yMWvfcFEIdU4xCSgDyCZzFLWiwVkKT9k9gFyr1q72ToobBfaD2ncNQoacPG6LTBZX8liLHR05UtqejHbiezyc5QGJH3SniuvGeuRT7vXlrydhUdZHJvVjpl/iNKVy4dgsnufBXjG72umgAOwn2PPGKmVnVHXrK7wOPehae8Bk+1aYBdjUvuYj0hNE6aDWDTUjPwBAS0WfanvAKucJxF7H8gRggtFk2vZU3JM4FpGiBH+j5cT+d/ZHgbyg5CtVUCV7u1uS2a8raiNkuWoHTNupg/R+GHb7LylV9hsl9x8fsgxhaUz8UECiQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 12:58:55.3752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5198e4-0bd2-4086-7e1c-08df31056553
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445
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

Update doc section for board attributes to use cat in place of hexdump
for ascii files

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 48c52ac0fc77..af144b92365c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2117,19 +2117,19 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
  *
  *      hexdump /sys/bus/pci/devices/.../board/gpuboard_temp
  *
- *      hexdump /sys/bus/pci/devices/.../board/npm_status
+ *      cat /sys/bus/pci/devices/.../board/npm_status
  *
- *      hexdump /sys/bus/pci/devices/.../board/cur_node_power_limit
+ *      cat /sys/bus/pci/devices/.../board/cur_node_power_limit
  *
- *      hexdump /sys/bus/pci/devices/.../board/max_node_power_limit
+ *      cat /sys/bus/pci/devices/.../board/max_node_power_limit
  *
- *      hexdump /sys/bus/pci/devices/.../board/node_power
+ *      cat /sys/bus/pci/devices/.../board/node_power
  *
- *      hexdump /sys/bus/pci/devices/.../board/global_ppt_resid
+ *      cat /sys/bus/pci/devices/.../board/global_ppt_resid
  *
- *      hexdump /sys/bus/pci/devices/.../board/baseboard_power
+ *      cat /sys/bus/pci/devices/.../board/baseboard_power
  *
- *      hexdump /sys/bus/pci/devices/.../board/baseboard_power_limit
+ *      cat /sys/bus/pci/devices/.../board/baseboard_power_limit
  */
 
 /**
-- 
2.46.0

