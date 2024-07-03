Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F036C2BD09
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 08:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F093510E76A;
	Wed,  3 Jul 2024 08:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WdWVS82P";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0A0310E76C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 08:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxiE/SHfjS5FAMtceqf8i1R2jEjJZtZLKp8vBDwvWLopqMhbo6qFUFbPOvUfJVW9WAV+UWCpJ3KiZijKeBMewYEXIjUsbOSxEYAKHuZjU2FG0Rt2BiSB4od2hpYKvOoQEdEMEcLN5DgvND1sFysJAg2NSvLF+SSOV6BLujg33rlnesORQp15ZxHNjkomfLxbJ/gizuAAa4AT3G0w79Sl/gwVc9kG4CMHE7bl9OurYeWiG+JwH4nWX5EdXt/kxdH4WHEJf4onKeUabYajIHOp0KqnNf8GbfSCmDwEIAYLh75dqMtijG9ZB+sBang4ts0xXaNUrKFe6hpaO4mKZY5LRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DmfkijcgpbFQ177HkKnEwdxXzfZNgZT5bwy9mGNwdI=;
 b=fUNBNlThyRiF1iD/PcIB4KP7AvwknkShLsS+KaMauSko/4oRDgwI+iUBvVHGcua8xs/BSgpcF76H0FDZIbKQbGUiN0hzUTancS6Qb8azQ5SNPmPPPz3G2T6gtkjifcqqbrAHdGjwbmWunuQdJqcU7H9AfwcQq1L1673o+8ycIxnqzu+x/tP8IlNDoQsKMid9M/yyJHDydf0CwgUa17jx8QMK+s05uF/P60zE5jbL+8vjLVjMoBZZ3mIDFkz4D9DdlRE8t+sHw0F4bk/Ck9SPjnJhQ9kB6LI1xK+nquNxhJa/zG1D6wzMoSk5RKz+hmJdlGQ+3bGj+8NUILNBa0tmTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DmfkijcgpbFQ177HkKnEwdxXzfZNgZT5bwy9mGNwdI=;
 b=WdWVS82PfUn0XHagsS8ogdwpVYzKtpxE9nGQ9gekBoPmEwB5aXlJHmp+Tpqtm5S7hjkG3otYAjWsL63xCTfRZ9wyrs6LbUveeqKqgxfNTWm3EKGVf5O2Qfe6M6dtVuWzYRtIp6L/DJDG0YDCMvuEpV5xCXs1OQHnAEaS4bSs2Qs=
Received: from MN0PR02CA0021.namprd02.prod.outlook.com (2603:10b6:208:530::23)
 by CYXPR12MB9387.namprd12.prod.outlook.com (2603:10b6:930:e6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 08:42:36 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:530:cafe::57) by MN0PR02CA0021.outlook.office365.com
 (2603:10b6:208:530::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 08:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.1 via Frontend Transport; Wed, 3 Jul 2024 08:42:35 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 03:42:30 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: timely save bad pages to eeprom after gpu ras
 reset is complete
Date: Wed, 3 Jul 2024 16:41:27 +0800
Message-ID: <20240703084127.478058-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703084127.478058-1-YiPeng.Chai@amd.com>
References: <20240703084127.478058-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|CYXPR12MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b96a7c-fe84-4234-d79c-08dc9b3c16ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fLqqfseL8G2PoSgBCHTqDjsY6C/7Q/Ilc7xA/PUChgvb/DsANtwBhXuBbLFg?=
 =?us-ascii?Q?VEIDMNt7vBt3GkugC76L2gcwIJIAu5YDVIEuZLmOIYR2JKuCZL/3L5AlhWM/?=
 =?us-ascii?Q?A6I2+Cl1jTD8mmgCRYs0fsPPSaqKn4HDbWxiY1wnZ45/pjjps/6pge4r914s?=
 =?us-ascii?Q?ehUHZMGgvWuGBaBNLMZgx1dYRAlVVK8nlYDH/TAkOjS84moz8ZtcNN0aTzLe?=
 =?us-ascii?Q?L07VOloW6lC0lJ6avgUSz6xXnbiUk0UJl5jXVN9w0BhhIVqsoQriST/Efn65?=
 =?us-ascii?Q?B5B48L7pBYv5jj0wVFkXqNNWeQUQHkv//j9/9tMmg6ku5TTj+IpuzHziZNKT?=
 =?us-ascii?Q?T7ftn+WbL+ICT6q26HIO9PG3rqOWtQ41A7NEwSA5SEdq8JtmqTt0TqX27KM6?=
 =?us-ascii?Q?Uprp9BOgIzFPsAYqgk5FptB/+RRXu8TKGQ8iKvO2PE3EEhimHcICJviT5Lqd?=
 =?us-ascii?Q?3/VLvgSaxuE1nrjXeb0tVKXJ26Dj8NIJVu1hHmoCn0Qf28cghFvoKCPmJbSS?=
 =?us-ascii?Q?5vVjbayo0Kz3ZvwuxD9BBXHQEGjK/qSjm7s7dd055bA2con70SMWlTTxjAy1?=
 =?us-ascii?Q?uDbCRqzKvva8+p0HkyfPgbD9l9Kty/s4/Jo11QHjQFsV5bTHRbZkhTQk6pc2?=
 =?us-ascii?Q?koneMW1eAWtcnLL+zCIjt5hsKKJxDGXKBpKLaeJZJ5eYp3cDOoBVbTt6bv+9?=
 =?us-ascii?Q?/aAFASGLUvN3I87JEq6+YrrhCAiPy/ci4GtgZujCeCiucezeI5k3cknkKuVi?=
 =?us-ascii?Q?U4zgtIaN1ARyFHyKMZ7PXyJtpZVAaz4uNPqisy4njuv8mDECPB/2lxQhawLk?=
 =?us-ascii?Q?f8NiYR6SEWUkayz1WvDUwemIGDoBFPYr/U/fiWcjAq8xwGg8cDLANDFoR85n?=
 =?us-ascii?Q?kUdv57iUYKT/G1UFHk/BudPCXKRi2omdgz4VeTSOriPRmZfFdOipXBaEP8u1?=
 =?us-ascii?Q?tkdkQGF9y33bm8PHwvM/sSp64S2aB9uEsu7QkkhuOtcbr8Li3VaKoC+v3glp?=
 =?us-ascii?Q?fbA+wEVv4bjq7VwFESSrLxytehPBBc9gpYvmgql//NXPoArOa5Ar/hj6P5lx?=
 =?us-ascii?Q?hZqn7UId+HTQpoixdT1PQj/fnv/uH6Z9izY2CqxdLBikyzqMpzeKWbg7PYwR?=
 =?us-ascii?Q?HsS6LXsEacWSfncu4laNA+4eTUQuvq3BcbQSUJ0XmfU/CBCOjUnQ4XXaJHP1?=
 =?us-ascii?Q?VYcEOBlT6eiJXmVPyxHk4JMd6RYk0P5p8lo2wsdvw2kn6QVI9fw3XgPVIwli?=
 =?us-ascii?Q?ZBxStNrrv38Cg0WQRDNtLd90dR+BEY20CYEhxAgmGHlDzgJo3sGg/4DyXb5K?=
 =?us-ascii?Q?DYr4gxLPbpboFeb/fUIdJeAZTr+LpJ6u9OfaoI6p5olpArIRUUSsVCRHWU43?=
 =?us-ascii?Q?ZtCZrK8goC0JGrYdzlreVhxpQdxWGHl51dqxKBBn3Co7z78/ahl8QgB6bS9p?=
 =?us-ascii?Q?4IdrXF691T2ijD5je/v6L9T5sZ/k9r7/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 08:42:35.8954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b96a7c-fe84-4234-d79c-08dc9b3c16ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9387
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

The problem case is as follows:
1. GPU A triggers a gpu ras reset, and GPU A drives
   GPU B to also perform a gpu ras reset.
2. After gpu B ras reset started, gpu B queried a DE
   data. Since the DE data was queried in the ras reset
   thread instead of the page retirement thread, bad
   page retirement work would not be triggered. Then
   even if all gpu resets are completed, the bad pages
   will be cached in RAM until GPU B's bad page retirement
   work is triggered again and then saved to eeprom.

This patch can save the bad pages to eeprom in time after gpu
ras reset is complete.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  |  6 ++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1b6f5b26957b..b6e047a354a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2844,8 +2844,20 @@ static void amdgpu_ras_do_page_retirement(struct work_struct *work)
 	struct ras_err_data err_data;
 	unsigned long err_cnt;
 
-	if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev))
+	if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) {
+		int ret;
+
+		mutex_lock(&con->umc_ecc_log.lock);
+		ret = radix_tree_tagged(&con->umc_ecc_log.de_page_tree,
+					UMC_ECC_NEW_DETECTED_TAG);
+		mutex_unlock(&con->umc_ecc_log.lock);
+
+		/* If gpu reset is not completed, schedule delayed work again */
+		if (ret)
+			schedule_delayed_work(&con->page_retirement_dwork,
+				msecs_to_jiffies(AMDGPU_RAS_RETIRE_PAGE_INTERVAL * 3));
 		return;
+	}
 
 	amdgpu_ras_error_data_init(&err_data);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 0faa21d8a7b4..7bdba5532adb 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -29,6 +29,7 @@
 #include "mp/mp_13_0_6_sh_mask.h"
 
 #define MAX_ECC_NUM_PER_RETIREMENT  32
+#define DELAYED_TIME_FOR_GPU_RESET  1000  //ms
 
 static inline uint64_t get_umc_v12_0_reg_offset(struct amdgpu_device *adev,
 					    uint32_t node_inst,
@@ -568,6 +569,11 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 
 	con->umc_ecc_log.de_queried_count++;
 
+	/* Try to retire the bad pages detected after gpu ras reset started */
+	if (amdgpu_ras_in_recovery(adev))
+		schedule_delayed_work(&con->page_retirement_dwork,
+			msecs_to_jiffies(DELAYED_TIME_FOR_GPU_RESET));
+
 	return 0;
 }
 
-- 
2.34.1

