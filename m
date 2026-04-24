Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C7AFB44C4
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 08:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D8CE10F429;
	Fri, 24 Apr 2026 08:21:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="384SqGi3";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D64810F429
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 08:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJyulbAPmplUVUNlPlllyd9DuBw8nyDDkFce9NXy+aHPuoyTqIAw6UZT0EzcXXVw/qzeONFVljGM/k8D1J2Sz9FRi57iWM2lcL+GUSO9JQ1Cd7/6Jw+/WZotvEl7jxd5NAGzPeIw+fPEab/OYwmvWcUsTsQgg+ndcDI0hHZXyEl6TDB8sEAIkymCKwQKT9d16yvZUfIZ58gcIvIBKhLx0AIrIAKcsUdDyBwPvBu+XUzRFbN6E1Tbo3iel1WBT0W3+nFzTrEvnKY0ogY5TQr4TE4QITOaJB/HyB1BljOyAMHkhT+qFaLmZh3mpC2pLpR6QLSXmA+fv/nJsyfkuaUEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3+i3KHnWMrmCSY9S0iysGvnpNAYoto8+YOJlmzCD6s=;
 b=LjMNkirqaI1P/qbGup0dLePkj1dkxK0A7drN2okrp6b6xSXebm2CJV4lx+udWDsKzqfIiijDy8VfJVDagc9adC2MLNbq//vbkKta+DZ+HHjLOqkwomZMYechPsjGR7hQSkhwdsSmsvX1/qD1JfcN0JX3j/Nd6MflYVjJSopEJJr3RS7j7jMpKuVWPhfyl/WetprB3gp+/DNwPQDfF5t75BQauSsSDJzTJspRhHeu9wk6SeD+9aYvWBeJ34PeVDnTKwB25DOSFmVy1ErvXHP+0nYEH/E/K1fzA8C4t1uYj58S9Cad+9b+/dcEcrPXA8JIEx1aFN6OJP6qe93UhxYeEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3+i3KHnWMrmCSY9S0iysGvnpNAYoto8+YOJlmzCD6s=;
 b=384SqGi3fwX6C2cBltKhYSTpYPNf35vbRpaPvZJLaFlZvLqKq1LnJn6jAjL4Z6Pt/2DiPgCYna2Wswu/7r0KAXbuffCGxxvK1WXqjyXV1P0jMM1rRqyMZh2GcAWP1DbyMeyxwL+S8RvEjfrHa/f8OjOXulcxNAnILhR6l02Z1jU=
Received: from MN2PR22CA0014.namprd22.prod.outlook.com (2603:10b6:208:238::19)
 by CH8PR12MB9840.namprd12.prod.outlook.com (2603:10b6:610:271::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 08:20:55 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::e5) by MN2PR22CA0014.outlook.office365.com
 (2603:10b6:208:238::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 08:20:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 08:20:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 03:20:43 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 24 Apr 2026 03:20:37 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 07/10] drm/amdgpu/mes11: plumb unmap_flag_addr +
 NOTIFY_WORK_ON_UNMAPPED_QUEUE
Date: Fri, 24 Apr 2026 16:18:52 +0800
Message-ID: <20260424081955.873090-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260424081955.873090-1-Jesse.Zhang@amd.com>
References: <20260424081955.873090-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CH8PR12MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d70c0a2-49b6-429b-1d5c-08dea1da67ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: XPcaJZFb3YYuL80sWgLhFCbF9xtK5tg5TAIk11iwHqrocMKmw0PphRxzbJj0CgGmFJKosloEclNraB9olhcNP121or2fqUXTLdfyRBl501qIBmTIB+rqJ6Lklu3v8Vjn6ddyuYz/Kfz7WNniRVzsU7Hfl6CqdlMwbnf3/sir/UTWZa4ayRarQc+Roc/dyimqerlNxMxMeLD5sahChkJB+euCTrdtfkguicN0GLbqSurLTMW2q2az8qSxDO8f3zXQGtqOAkmSXitr9h0XE0R8hX++oz3m3RVRqMXxaPputtbcIMjF63NkR3T3hYD1hptdc6SxyG3eQInoufz8Sy5r5HtXv6Hw9Y2kyx2zinwXhF5jJqmt7wqyMx/0aYz+30m6k5Xn5aOUPIQKJ8TRscyyS750NpwnaLn/P16Q+w8YtP/rxkNh8frl5fFbgW82wRX/xYCIa3yhn0wvWb+oTOtNLFTspE1IYUDESbB3eeiLSNJEu6PDgW+zRJCrq8Ppj3P+1flvRO0arDXBMkROEGD2pIW0qeVbye2Bo4bao/UbyvArGY6dWU99nUWGSG43QrvS8ewc/SPMcig63M2w6bD6IA77wFBYQj8gYMGdCcFBpcLtijBHrxQ8XnI1HOV5foGTK6KAS8vnnfykyzu8HI/TFTLP1nQePs6GVGNv9mQRTrMtqNW4NqUhhV+hXuxULUt470AS+n5CApxamMQ+zjhh1HhdgxCZ0xOhmmNjiS61qup9KFXsOTNrSynyU0POYATdkPGt5GABlvgqmfYr9PSucA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jNU/xtjLlmp5fyWIIMnV3bi5zsLzJYgDs6L2zJVnviXJIyVdK3eohR868HHmbk6p/nj+v0/gdi/BH15RkMZQnncAuQxG7dF0TRtjJJD1/krD6bqhD7L7W7VddNpdDXarMEgMY8AuSgWmz7Z+/vQXEvEZ95TqQeg8teBGVwgKFWBjrUutMWF9jxLan8QsmDcJtZbOSvcjbwavLE0FJ0ZkhhytHmZDzVAA42pogH8JXUdpo1GSKf1kFK9XCDs71ZwCqMIO7rgse8jQFMMEorTssdulfoiiRJLtSQxPh8ep1BIhCU8Vd2g7e4i01QJu9t0hJpxGXnPxMl5VKVCDdC5fP7N9EH7heqIMXGNSTKJfxvfN0PY6PymzEZLR9k3zf/ONxH7cIS+vZbymBDfD/58qrQrxXb586HRExoXRZ3EKJNII4OnGBKpL0CXH3cXZ4r4P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 08:20:55.1223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d70c0a2-49b6-429b-1d5c-08dea1da67ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9840
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

