Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0640FCAC592
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 13:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 559B710E4B9;
	Mon, 15 Sep 2025 13:32:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dmy4MsB2";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C90410E4BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 13:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfHWZYC6QFAHBov7SSafypaLCLIKpYFlj/ZTpQKy9N0YkBD8tBwQ0HeDt9okI4umKl3d67o2DDbbt9Whw5YgBRYgm1gmMzVJ9ggLa40KSK/Ct7rcSMNAItG7n2uu683jNJrdJTXwvtJE0w3TDSJkfFV8cXXr9QcgHz/kIkSE/Z1Zi4xK1f880Th2HbTR18/FN339GjpcTeMilVd3soi5vPJ8JfvLamx+AgwVr/0jQMdb0g4lvB3zgrVBcbHOA9x64+AyBff/yWn/g8aeEzMHNqSR/SrPPDAGdt8ozo2C4BzZw9CUzmHQbNQ/Q7v4JhwShka9q0jr3R84LUZCHWAnpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH+VIr1H4i6mII66Uw8w9bAhtaqsNl9ywj9Ebd+VSPY=;
 b=I2Oz1yv3YjzSZFpMqoIHR4lRxazEpekJtlNSn3bw8m5lmTtkQTQDY6+rVHfo7T4extJ/xOTGsXML7N3c3HRCFXAE2Wtp8sASW0aAhkzBpka1SvrsKeq35ITsxtF8DadH6M1VONVYRe2TLOquaPDBwxNLEBAJWofX8mXXTDTVE+t304JZa/AAueVOIXMNhFqmT2znEtteRfDLObYF9+4JuxGuXmHc4A80nWkuioGTHSOar/Nrv8jaRDuPMsOa8NmiZMyK4xiQfB+cnHa0zt7SOd5fgGZkWtjX75MtwgnVCqL4ie3Dfq+q56xMEK1Lk1dcsfpKAZkEY0Y+iZy3iqx4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH+VIr1H4i6mII66Uw8w9bAhtaqsNl9ywj9Ebd+VSPY=;
 b=Dmy4MsB26S+cIirwVJdN26bQRdkUgz1eZLZeUROg6CYXCRH3FjoUNT2O9R+TLnDiMDHFU+CqxqxFAh2xfuHhs3UpCyMf2ncFsaii8+JC+CvJ8RiLmCc2/J99D/Ee+b7Pdp/9PZ5zrh2lBJDX0FPNrCvhflXs/zCjAZDCaVz7fPA=
Received: from MW4PR04CA0085.namprd04.prod.outlook.com (2603:10b6:303:6b::30)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 13:32:16 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::e3) by MW4PR04CA0085.outlook.office365.com
 (2603:10b6:303:6b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Mon,
 15 Sep 2025 13:32:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 13:32:15 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 06:32:14 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/sdma6.0: adjust SDMA limits
Date: Mon, 15 Sep 2025 09:32:00 -0400
Message-ID: <20250915133201.3547033-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915133201.3547033-1-alexander.deucher@amd.com>
References: <20250915133201.3547033-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5d196c-34be-4adb-be08-08ddf45c48d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CvYjmZWM9b2EPY4GLNWoqUarULeG9pt43FM/NEYOkonubh8kma8tKe6ylVKw?=
 =?us-ascii?Q?HmVHjEIItchy9V8Tp9t40CHosNEgGs7TXrqCAggGW5aQf3waiZtZmRpGy282?=
 =?us-ascii?Q?nep0rmb1Bv6wagLk9icBsERVCWsIDYxGK/3sVmTFTv0yts1Pr3fsZVTThqiF?=
 =?us-ascii?Q?nT6oP5J86lAxQRIPDRsa7V9rPLM8iopjl7SV8MXmeRfct2vUkrB8VTYSCkos?=
 =?us-ascii?Q?zv99n7tgAz7luEbBPreR414LcSmBgacSN/rEtT20d/J5vRISQocRyFEXyJ6K?=
 =?us-ascii?Q?t7bUd2l4bx1lb1WcBX/ax/yB8OKAOuWZZbVBm7kLerNHh5BTzX3N61t/yzKt?=
 =?us-ascii?Q?MCHPHWu5dNw1ynxj5t2MRCDg748tgX1MCxS31LiDxzMdBbxyrMMF5TE1uUZz?=
 =?us-ascii?Q?t9nJPbN23krFUWRHW/r6qzpS+lI2SUUpFpkhlp/vL2gyiUFLQFXzdBxbhFPa?=
 =?us-ascii?Q?OwPkLRlEOQw/MDtWOzQpDVyMcnnKF51AYjD5PgT7XbYnPBTfpTiSzy+8+lwo?=
 =?us-ascii?Q?z4SuBQHOxm64FhnzWv0zAR8KSr5LCBT/JylmqguTm7UXP3nHpE9+cpVfk7tk?=
 =?us-ascii?Q?RYrMR65Rh7AWxeqc3KV8JnvkMgeTgg1uDD4nC8ta9QDXkOBpnz2FWSF5pEFA?=
 =?us-ascii?Q?QZn0uNbBGgygWZtMAvnwuPsaCiPwL00+A4yBtlw2mYFFbVen+MhxbS46ZtFT?=
 =?us-ascii?Q?Le37W9a+GKQ4P74GhF9j4zmoRn2VMQzhU5uqBQnRac8EzGoGuT6s5wHfnT0a?=
 =?us-ascii?Q?P+kjnyOpR3RUx4DH98cqZWviXtWGZ9AJVqdauQvIc7ean70ZatsBzoJXyazO?=
 =?us-ascii?Q?zwwA38kNDrXnzfdFRkDym3Jvi1L+Bdc0jm6D23cewrojAxO4dZMeTVCvoehZ?=
 =?us-ascii?Q?XkPlPmjC6K+u4hrPNSKzfIor0jvg9eSHOW2pm0pgNiSkXGOk/q2o8uaz2SJl?=
 =?us-ascii?Q?lm9EEjIknX9Tl1S5MJAK/Dmuyg2mIHQcBEGkOH8bmJmydJ+9YFlhcmpAhd6V?=
 =?us-ascii?Q?JwR5vOx78qBwz8dM098e88JASEdcsSTPN5oQY+Rp63v4rn+OKe+EJf3JPBN0?=
 =?us-ascii?Q?bCNihBj9seqwZSESvmELc7vTpZ0IoI91YdRbx6Z0aDY6jSZJAO+XGBimWlhL?=
 =?us-ascii?Q?zDNQxk9svwdxP0uhqruVCDv/yM7yN0HlOJNAI80jVhRnN/iUhp/Gjrv1uapK?=
 =?us-ascii?Q?KlS+x4Y431DNCmUcV+Vz2vREwxc03VhIabirfliS8Zg2NJaBtMLjY2uii/YE?=
 =?us-ascii?Q?fO3mWCdPntrCsSeQ+umH25Jjd1vlIkV1ZQ0bAb56crpsFNo69tMB/krdNQpj?=
 =?us-ascii?Q?D8kxeO/gEyPBi6roAuis9OXyy6lZ4ptM3fSl61PYeNNaSikhkAy1D+/eZpaW?=
 =?us-ascii?Q?klpqo8iDs4WfNfb1H/vWFUO6/RPShW4lKKj6y7HxAuis4Kze/uBvQoqev1F7?=
 =?us-ascii?Q?/+ua7odGKBpVRmpjgohESMzYWwzcMnX3rAZnme/6glv5suTumFE4iEm6XyIg?=
 =?us-ascii?Q?SKmSjGVCiOQ3q8BwlXaHyrV5hydVGrF6mchq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:32:15.1541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5d196c-34be-4adb-be08-08ddf45c48d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727
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

SDMA 6.x has increased transfer limits.

v2: fix harder, use shifts to make it more obvious

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index db6e41967f126..032cabd8fa8d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1873,11 +1873,11 @@ static void sdma_v6_0_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v6_0_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v6_0_emit_copy_buffer,
 
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v6_0_emit_fill_buffer,
 };
-- 
2.51.0

