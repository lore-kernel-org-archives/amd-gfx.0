Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64244C27C55
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D94F10EAE1;
	Thu,  6 Jun 2024 21:57:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x0X+Ysfa";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C27210EAD5
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDWgNZVuHZvUEcPBpDgXFcmsJIKXIdyhDHZprEwWQbm03glnSHgM5sbOKfh6+auQIJu44gFIrVpZX5A8lmqQDpip71+O7osAtTk6f2aYGDnq3W0vIaWxlWU2RNkKwWRrbiNYK+gZOH+MqRaE3KsIyDHVAkmscYy6rjPxfdwUkTamM0xB5etDtMqRx53CJht1+aK172ihVPdBez0G0BLR3nI6sVFdSzBCRd85EjA6EYjRRjgsr10b+GNLO1wcBZVS0YgD5Xcn8yt1zH7c6CXMKOEk4lOCtDTOJuReEpW5T621ClDhMBuCXGg0gh19HSnQCqB6qe0s/6xvP8pKVTP9Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFFR11RP74c4PIzDRwB4oXZJ/w+tU9ARNcxwjeOf79k=;
 b=Pb0PbfvxE97+OUkltbwaCBYb4wATCpcpN0ppESl47212PoW0F68PFc83wPXjOQEkd9+RvTY1ZICXySOlKcPqjRIIUh57UyeOfiYEtBaWYSeJ+cJ8vkCFT3VkkSh1+AzR4bpw+F6ofWnxm46EVwIrjSgFdA3pk3+5vg7VI1mTm7jWpMFBWyS0DoVRBZSAl9vGlaKkGlDBmIhmXyROz9VlFHolRtrGKkvLPpLIZNdqvL+NjXAa2NjyTKCKqPqn7KYGWUKuodL2IO1oH60mUWYYqUGscfkKOdvwbTBVqpzKDyJIVB91C7x9ZJVGZW52aOfONOdiYIj4XR6OCrpZRP9ArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFFR11RP74c4PIzDRwB4oXZJ/w+tU9ARNcxwjeOf79k=;
 b=x0X+YsfaUUy6ceSA/Lqk7ptSk2Js2G0vi7FEecMHKeDffvkYefMDE5OgAR0CfJeIP4Hg0rYHhkvGlfAXUkbVFO4ZXtG4j4xo6basW3sOJK+Cnt1oF+FXl5K1fjMeB73TGpI6mlUQVDIZubURxJqGCJCfq53tvSvG5z2KEtesVZ8=
Received: from MN2PR20CA0033.namprd20.prod.outlook.com (2603:10b6:208:e8::46)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:57:35 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::3e) by MN2PR20CA0033.outlook.office365.com
 (2603:10b6:208:e8::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:35 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:33 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 23/67] drm/amd/display: Add config support entry to replay
 caps debugfs
Date: Thu, 6 Jun 2024 17:55:48 -0400
Message-ID: <20240606215632.4061204-24-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|CH3PR12MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 821e8ea0-1a07-482e-e691-08dc8673ac6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cyTtei5xrhogjE2bVa0KDxDzadcikTadjrgvZnGrOeWqKzcqosHr99b2qfaN?=
 =?us-ascii?Q?oa+x29j6imAWUvpbjpw+HiKipiDh8CbC76TWnyjsPHi8xyLxUetdq7+PwlC9?=
 =?us-ascii?Q?5V9RIjdqQDjbRzWVGxKeizBinpTJBAWjTNEeCP1Iezip4P7QdufCfyvAO7f8?=
 =?us-ascii?Q?DB9XK4GKLyovxs2KVYFkvgGOvgfv6gTVYCkeUE07hbtBbX2Omc5NR8TVM2oW?=
 =?us-ascii?Q?xpd8YgOvsZ9baFFpATv4fiOREbgsYm+eGi+4DwVXJAZydLZLxyipJ+C3sc48?=
 =?us-ascii?Q?r9z3FtRO75iLY2BE0/lOtY605YbH8ST3fcKXQt/KkHmym3aEn4xaYZvyr1Il?=
 =?us-ascii?Q?z/ZcCaXF+gkbO9oHYqSpE0vDjkKKhnZRo721OIwgkbCjSKJJ8aEzIyjoAQF3?=
 =?us-ascii?Q?26X8Dxfnb3yjigmzHdPm8iNvVwbQbw6+3j0L2f1E8XBi1hKIFyiSuYNrYvZq?=
 =?us-ascii?Q?skGSV9JvAqqWYg1DpqYuJUQ6FP2ywV4nep9cBQi4BHIt48cIh2bR08z1pRMl?=
 =?us-ascii?Q?L/hjR7IQubYfW8hpuczmnT1bFr09GoMEhcLfCkdsIOQY2MfClbpOYosZO0vA?=
 =?us-ascii?Q?PuhJeLUCo91/qcYKsZtJiDSfMPj45KOKRF1RgKrYxgFSJ3hQN19ixhhQ6kCV?=
 =?us-ascii?Q?AMF7s/XDpCt+mAAENEqXhLdrwNIvzP4xWyMGjjhhC7pRxhismE7NksQxsvCX?=
 =?us-ascii?Q?wqvp6TSODN74Xkek6T/rBLeYRC3nE+DslEPCvKMB344HbT0d2IH/GXzw5Xy6?=
 =?us-ascii?Q?cAyWn/ql3wW8d18VI4ZCW2x2Ka0eejglSSBRYiC5iLptkgmmQMPCpzTzt2J9?=
 =?us-ascii?Q?PEGkvQm36b6diC7vR/KnjqUYRqK65pqx+1Dpst7JcHAwKGCKS/RKr75WH+dt?=
 =?us-ascii?Q?J1fMb81OER10tedkxEy7hnCnvqSQDgJZ+K3xe2Tt+GPkPu/U7RUNWYuOLoYK?=
 =?us-ascii?Q?dmPaj994YnbJdsHT3s3ckFbCdLKKsuhpfKTsX/vUn3lxTcAo9fD8Yzt50HNg?=
 =?us-ascii?Q?DVJSpKHFGrZFxvF8kjZqek+Zljc6229j/A9ZQ/IZXKj0vyLqWZMCwgYYm9XR?=
 =?us-ascii?Q?QBd1BmRFju+dlCyjupTEyjlx4QcvCdJbVOuWIki1bew/R9lj/1DcDXtTgF/6?=
 =?us-ascii?Q?lIIxg7fiasDF1bac/9huTCVjH6HHR8644GDndnZ2zwQ0r5pDQq7czIfq9mnY?=
 =?us-ascii?Q?PL1+J5sPeB89aQ0UlJQ2VljYNL6A1wfTz7XeGIjpFZzm1HnZL8WfaBVsBOZQ?=
 =?us-ascii?Q?DDuDuOWOKFVYcuRNjzelxF3a5IofvCKHgo6NfUd1uWlG8S/jedP9PkAWRbfN?=
 =?us-ascii?Q?TF7jtyelgpT+xIJ2AbW8SrzWsUkj2JivdMkb228g/1IkvC/meMyHXmGcdo4R?=
 =?us-ascii?Q?MkMRsAMD/2HGY/+qOX+wKTXX9scBTAK5ek6IN/sKVpqpLZiM0A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:35.1387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 821e8ea0-1a07-482e-e691-08dc8673ac6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713
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

From: Roman Li <roman.li@amd.com>

[Why]
replay_capability debugfs tells whether sink and driver support
replay feature. However replay enablement also depends on
whether it is enabled/disabled via amdgpu module params.

[How]
Add 'Config support' entry to output current replay config.

Reviewed-by: ChiaHsuan Chung <user did not set an email>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 8db75afa9fc9..7cfa240a3cea 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1008,6 +1008,7 @@ static int replay_capability_show(struct seq_file *m, void *data)
 
 	seq_printf(m, "Sink support: %s\n", str_yes_no(sink_support_replay));
 	seq_printf(m, "Driver support: %s\n", str_yes_no(driver_support_replay));
+	seq_printf(m, "Config support: %s\n", str_yes_no(link->replay_settings.config.replay_supported));
 
 	return 0;
 }
-- 
2.34.1

