Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16490C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 10:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E6710E9D4;
	Fri, 28 Mar 2025 10:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nAUotBPY";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4635B10E9D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 10:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqGyBqrQvxkCoC/CThVh41RyEogtMYq43BB33lEmagD5jpW0tN7CJXFZlr1V5Cwp81FGTCOVN5NZLjsW7Zq/vOL7tghs/vHX0Tadfsh+OXM3eb8g2tVikfRK4J/aGcEMVvgAVxFX8dyspnZ6lQMy1kvdah/jVI2mXbEk/jwP3FuhC5n/g+f9jlR0nYGi6L8UQrMnbvJyu/cssfxgM0O6Q3QJCezeNhkDeSF7eGKmpL8lpD2/LSh/sg2w9iR4ilt65Hk85Neh4DkCF+d755ucsNluXHEH5uyqqLp3TngiTWW+fGvAhgUxgzDjJH9i6U1gBbTafkywcDUDozA7TMvfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bikyA6hS/rHOze3kSUD2LaUkevy3RoMiMweC3L1cM0=;
 b=fYTeCFwx3rRjb6mjaJRtLz+2avs4h9gILy4GaFFNT5Lkd9DCm8rp2Vv6wxpPcmUfvrAYr4XQhHoFeeactBRoowYnjjo9w7UO8Ox80YZwDKCbm7xrrL347xS3o9Ot9XnnNif6LGQMBtz0FBEOc0I/hwGo6zcgKYe6Xy+oac2GdKCFeGfMitEP/vBq2upD98AIjeOxBRXQlaxAdKIWVPd+xjryDhxJGKyZOtS1/jNvLeh9r1wLUNnw5T/dCwlBj42M7bIjMZ3tC/8mojHR7DCVDQMno0G3ynBSpsdPnH81CPqeie/juF/f2XuV5oVLlFUWJsXQtzvhlCb8ofYZ80oacQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bikyA6hS/rHOze3kSUD2LaUkevy3RoMiMweC3L1cM0=;
 b=nAUotBPYN9rq90uADoIG6BfjuWqVELdFRRyC3/pl+K/zTbvj4g5GYwsWfu25sFFR5p71kskn7ecx3vPqjbdy6Ppsm4B6tHVXSNgZslU9v9F2CKv7IVZXwZ2TBV0XCkdoEqWEPTOmZEcJReWnejfSV05K2GcSZIUFmjXQWAbhL40=
Received: from BYAPR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:40::38)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 10:46:24 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::fc) by BYAPR04CA0025.outlook.office365.com
 (2603:10b6:a03:40::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Fri,
 28 Mar 2025 10:46:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 28 Mar 2025 10:46:23 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 05:46:21 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: remove the duplicated mes queue deactivation
 setting
Date: Fri, 28 Mar 2025 18:46:11 +0800
Message-ID: <20250328104611.1763032-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f38ddc7-0755-4070-cc49-08dd6de5c890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|34020700016|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ajocMuL1cZ3MGKzzfMwgDEf5thL7MEvMg+pXv3cz4lV9nGzVKuzhdYryQBK4?=
 =?us-ascii?Q?4fUllpEkDLTAJdtSlPTMwsuXjWZXpv4y42er5IhUGs5FuwGyNgcUbM9lIRKk?=
 =?us-ascii?Q?DnWYGhFR+zYIIAKe6CiAkZfkYciRDeJ+gN+AuUeHVKkxvZb96CXbqtgCCm4T?=
 =?us-ascii?Q?DfTwv5xsuogxHdYFNZXuRpyX6JauK6bWtt0KIwO0lORRfXSaHhaomFrVhfmA?=
 =?us-ascii?Q?VZIRcUJ+ksta5pif/DU4ycFUt1ts5fU7jk7w+nsPadLLCp1xreHUrXXWfGht?=
 =?us-ascii?Q?qRNs1Vs/XD716ICJ8LZXmYb7xojV3kIHMrkPtzQ8UCo8iyziHcbJ39D0D/ez?=
 =?us-ascii?Q?who9MOkOWp8BSd0Rdyg96TRYqUbZWLMIjgSVk8PCHgbgG9y5i85LS1BcO3IV?=
 =?us-ascii?Q?6370yrVTAANquBKQr2Ecre/1Hijrmh3anLVsUxHiCCfFs+fka4oNblrZdLY1?=
 =?us-ascii?Q?T/D8LV8Q9bCbqZz+cYm5U1UJZcAgjSyZOleY17Iym5GH12x3KICMDFnWv8qy?=
 =?us-ascii?Q?r6BTH/FLEcK/GR8pCf9qedki+LKEAkzYkeNY5RLk4LQyXQtoJQF2ZF4EAdav?=
 =?us-ascii?Q?7Oi7dJGQ2yNZfqbISf3xKKtKmj9V4gzjnonEi1Jp9zOXzCYGLQq4y1mLPKFl?=
 =?us-ascii?Q?tnRrYDixn/OQ6UBrViaP7GIA/WWgIPzJ/jFgbrgUtgAAr8SVU2aM3pFTklgL?=
 =?us-ascii?Q?wjf7Z6EO0pKdYgUfyjdctneJrACCAcq+5UWctD2psE0TCvwXgoiqqQhhacX3?=
 =?us-ascii?Q?XJHdE55V28T+NK+xzMG2hQ8EurH/L76hmY39rYptyvfwakkN+1aMIGXjMRd3?=
 =?us-ascii?Q?X9DgwP3K9hiX9WO3xEDhPWWgUvou/cvY9B5xhMEVnIY6/mBQd9PW8ceNFUfc?=
 =?us-ascii?Q?RhAwnILxsLdc9IB0OSycOWMQSKdHUgNtKZgjLfrvTHKgfhWOURg0cB/fZSWR?=
 =?us-ascii?Q?o4Rl8DZOyDzhxqv2U9/2vF0czUHDNCNzqL8HP4VB7sg4GubAFVU06QMpHZcy?=
 =?us-ascii?Q?BfXTyJBB1LQpCdlQ/ECFkOONm/Oo/gylsaA6oRMpKilYkE3yEHgMwZzQCLal?=
 =?us-ascii?Q?0vz+2F0CtH0MApSi4J3rN+p6O0DNpyfwzqiWH6wCjlhhkppWoHFFUGMTPu8u?=
 =?us-ascii?Q?qrx75ygSfqfZhU2doUf9svxCm+wv8OBZmHeM3cO5Rn5gk74VRk9YB7EAAhy/?=
 =?us-ascii?Q?fiXiWhHsPW+5oXb0n4IWwFsFZ0zDoBh5G+SQaPinjE2PNOakC9GpGJzS7fMY?=
 =?us-ascii?Q?ASeT1VkVEUvqJZLpmwR3cG47sj+qmPDL/mAQZ4HvX+q9Tjc7GTv0dah1yKj/?=
 =?us-ascii?Q?wUmRnEpgKaDDjlBvRO84IkZ9X6CiAla/1wi0+5nsbJswBcV0njTvLcFyjFz9?=
 =?us-ascii?Q?uXWOMkN1ChwgYgGfiJ9cmGgfKl31Hs5foJml9w69nac1raS+YD7o14Mh5TMF?=
 =?us-ascii?Q?xqDdEZFjx+JkAi8ehJgrN/jfJQvjWpWjLPKM4vsloPH0wiHbQ+CRc1eI4WGm?=
 =?us-ascii?Q?eKmAOSpgkg3VuoI9vgzBdJufMd5o+QSVQUlf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(34020700016)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 10:46:23.4787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f38ddc7-0755-4070-cc49-08dd6de5c890
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
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

The MES queue deactivation status is already set in mes_userq_unmap(),
so the caller needn't set the queue_active bit again.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index b469b800119f..3669934e6e17 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -358,10 +358,8 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 static int mes_userq_suspend(struct amdgpu_userq_mgr *uq_mgr,
 				   struct amdgpu_usermode_queue *queue)
 {
-	if (queue->queue_active) {
+	if (queue->queue_active)
 		mes_userq_unmap(uq_mgr, queue);
-		queue->queue_active = false;
-	}
 
 	return 0;
 }
-- 
2.34.1

