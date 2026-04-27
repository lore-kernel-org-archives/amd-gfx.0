Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBE3FF8861
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 738BA10E610;
	Mon, 27 Apr 2026 08:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VNybeZ94";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010050.outbound.protection.outlook.com
 [52.101.193.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65DDC10E618
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 08:36:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUTUICb5BFKlTEgTr4cnPtPy8PdTLK7EzJEyQhWmk9UWI/dg6Edr0hmDrBmgwOYVr9/x9S64vYEVi40R4mpbJyOU1wgZF9LUrC7/IQpaRkH2YyzaClcQqYkFnEQv42gYsj2IHwtRTt77z5DGDxO8ADyTM7ywgbXFKr9jXYD4p0dwXtmV+M+rAj0QT3jvHNV++17ZWmHC2uNQ5Vu0/W/pdm1IT0ADaN1ZUbqHVXwiqIYofZ5clOGluyopuzSPoXhTNGIYSXgugx4zAVzQBegWxVM0JSeAFfZP4XTOBAi9uulvzL9H3v6eD4sXHs+eJWf6M/zJf+VyIevZDju5AaBVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3+i3KHnWMrmCSY9S0iysGvnpNAYoto8+YOJlmzCD6s=;
 b=wdFYTsmFTNvT183ZpgX4A4l1e7+DWehbEx9NHDSJOc5NVqRITuZB5lnH94Ls0arZ9r6ujUoTCzte2KZOyx6yyWIRWjXLfXbGwihma1kjuO8eFMry4oYop0lQGlOnueK4rSbxk8L1LHBdP10b2y163Xn4RJMLwEpyOtDXzpXCVv/FDf32rwMb/Z4b4pUmutHM9sjvTCn5aMWH1dFxzANY4JJZTPd3iiC0ztkVRLyl8dmpf6TcjMylu1bHE7bFtxKazZppFR1M6QVfDes47krRxDpiSw7ae54A7drcgQNyLveWvUzZM0EhgY+IydMZ/kYCJh28W3Z4mFaGhFuGSKZHDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3+i3KHnWMrmCSY9S0iysGvnpNAYoto8+YOJlmzCD6s=;
 b=VNybeZ94pLIAS102lh5y00iVGH+5qg2rbZfcrF/rkK/4KESZtHY/QnU+r9PrJhDWIbvIsvDI70RsbzWXtLzIq+EQqa2rFeVHqTXcxMOYa3wcZmFLPbJsLyQA4RcmpxRGtveNXvD3SzRW/Gn3ZzT2WxYBgLUKU/76FFD3/BgqObc=
Received: from MW4P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::9)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 08:36:34 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::e0) by MW4P222CA0004.outlook.office365.com
 (2603:10b6:303:114::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 08:36:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 08:36:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 03:36:33 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Apr 2026 03:36:26 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 08/11] drm/amdgpu/mes11: plumb unmap_flag_addr +
 NOTIFY_WORK_ON_UNMAPPED_QUEUE
Date: Mon, 27 Apr 2026 16:34:34 +0800
Message-ID: <20260427083543.1328533-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
References: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b2910a-9b26-418d-5634-08dea43816d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +ZqM09enLs/yJFbcDycqxmWIKlZDd2/Ujnri3GBPHptlwyaSEU7eFJjlX0jUA+COVMAMDVIXKP4cgW9nsFBxWcQPIVRnIhIjrpCvrPG/Nlx6MEXhD3HRETagyOE3iAQBz3wPeCXa6OfQC024t0TreNx3X4VkgwxhMmr/RdveJunL4+6X03lZWzNGOpa5jxh9nkPfR2xcDrzCqtv2rD0xToOBYbqCbzK30ObxyKcd+w5u02UCPBUF7t7ve+MQGid5GvZwRUITw8j0vo6UuPgNHRcobBsdjiLgAZQ45K6fojygBhfT8ByqvfcPoa6v5QngMGpbRtO2yuszFV6sp47Q0AIW5gvKhjq8tNsGNAIqogo1TNkVGWKyp+WIgCSgjEFR0r6Vm0qtgwQiNyMDX/Pd84Cj9+yMyiUZmFpdh9wnAePmLu1opXaR70wifDxNEVLIRke30zkDpSaiXQiJPOQg6EW+QuopdAt48Hm2akBCtKoDyFV1W+zuf/ErcxJQfkbdbXT+xaORqxVBSCFhjpKlK0IrNv4PFBgI/uBmDRcSxVbzoouuvTrz3CaVMj5JBUWoBM6j5OP0mPsY/EcIgL204o23/3+X83WYEmDDHB2LIlb2ETFjmGW5tlnnC+Ryic9jQh9NPToQ17prm4eQ4/Bysf2Xg5ucZf3ix5mN5znnks4gsuoWTALELwjor0VduEWsPzfZ9p0mhzHstseQallApeKB4axxg4FJ4OkZwF6DmrSgWGfsNnVQ/meUhQ+BlZdNAcZSa+mkCZVpMI7Xl0ol7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8bv3opMI5L5KIeL+bQ9331qbVpTWbC72eBIW4juVzYuURNxrTGISci/gyjD41AFLYlIBXTHasRhUeXJJy7OHxBCYDpzFsSCMDE3GoGKqAyofvWT63p8MBmsicnJLVVak1n/vEZCS1aE6NFlpfNYWLMcDtc5mKx8V29pBNubUsP2IONK3znXoaGsWnPAI6iBtdaol1Tymf+NL6GR5Sn6RXXrlAJRuhnewh6+ab1l93SY1tuNpWZrrX9Qh/byvjdYaNaqLHemNY2+RPeUVVj7BrCtCQq88q8G5oNOtW0B9davSIyHXW9Ft8a/DwiejQf/L+vPlz95TZkLHXWE0QPAOhmXTEMKbHkxKMH1I4ST0tC/yAfSqr76MAoVP40kr9oZuXkw3ydvVyisXIOVKB3gJn0ABFfOv7xvcPHXacSgWnwHGyoneQog38eHMuf5667eS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 08:36:34.0113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b2910a-9b26-418d-5634-08dea43816d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

Pass the new mes_add_queue_input.unmap_flag_addr through to the
MESAPI__ADD_QUEUE packet, and route MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE
to the matching MESAPI_MISC opcode.

Note: the MES v11 firmware spec does not (yet) carry a per-queue
is_user_mode_submission bit, so SDMA UMQs on chips with MES v11 may
still see PROTECTED_FENCE-as-queue-done behaviour after the first IB
until firmware adds the bit.  The wakeup mechanism (NOTIFY) is wired
up so that path is ready when firmware lands.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a926a330700e..575cc4a684b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -362,6 +362,16 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 
 	mes_add_queue_pkt.exclusively_scheduled = input->exclusively_scheduled;
 
+	/*
+	 * unmap_flag_addr is plumbed through but only honoured by MES when
+	 * the global use_add_queue_unmap_flag_addr flag is set in
+	 * SET_HW_RESOURCES.  MES v11 firmware spec does not carry a
+	 * per-queue is_user_mode_submission bit, so SDMA UMQs on chips with
+	 * MES v11 may still see PROTECTED_FENCE-as-queue-done behaviour
+	 * until firmware adds the bit.
+	 */
+	mes_add_queue_pkt.unmap_flag_addr = input->unmap_flag_addr;
+
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
 			offsetof(union MESAPI__ADD_QUEUE, api_status));
@@ -660,6 +670,10 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.change_config.option.bits.limit_single_process =
 				input->change_config.option.limit_single_process;
 		break;
+	case MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE:
+		misc_pkt.opcode = MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE;
+		misc_pkt.queue_sch_level = input->notify_work.priority_level;
+		break;
 
 	default:
 		drm_err(adev_to_drm(mes->adev), "unsupported misc op (%d)\n", input->op);
-- 
2.49.0

