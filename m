Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D17BCA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 08:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A529B10EAA8;
	Fri, 22 Aug 2025 08:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pj4IvGRo";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F86710EA9E
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 08:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWfS74ElavRfIFhndREL1dWEEGpR70hejawL53ZUdicnYOz5TcdRIY7XG5F3pEUwRse9XRV8ykOjOeXBH0labGkh7e1MJxhHLXzEvKvv2/7bC40U4zOddEOxW1CowSLTfHcXGMXGcLiaFnalY/iQS84repzJQosRNh1sy16Tf6U9KdmgX5x8Silk0u1Y5YYDW82ESakZk6q3CEt8e2PDYf4w26ODCGZUy7ovoe915DUQ+RJBcepvigkddjbhJSuDd4jP7QT9SKboXVbrCzFZZjl34UwKJxbAjE2O0TAELY0GY1N2QORBLDgowJ2mvHeaaqGRJ+3T773pn1G81yVxvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=MC3RcdgAtceIWiTLgPTuTPEqx0JsouH1HkxZ1tLedZR4/No0HH/YKPMxjKBkYp/sptmGu/2DACRe8GY76IgCXDrReLoQBwuv1AfPzuf8/KWxEO7hhY0owxOTisDXF5SHENsaO8eZYIn6l1ZSHY0f6ncFSFcuJ2Q67WLGYs7hqrjgPq61Np/Em0fJXJfK+MaDMJ3QQsbB1dyoyFp8FNyvFBCB9zKRpGvFHf8U3jBOg3F9NgL9xVurd2Cj05FI2VBAURNUBWrc+VSx8BEtiZww7E9741GeGPH0y3qUas0mqCYLabXndbJW38o/Ep1pOAVvWO68zASlwfRIVpDxK/gJpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qyVCWlftDAdPIDu1Gk1I0z7PgskphbcEYfA6lIxgG0=;
 b=pj4IvGRotPDUBRmqdmc5AnG/AsO6DV8NGGjepsavd3i6n7mYxDFMYTwrXWXeVtAkCWG4LsiL7aVXeDSNiC/ARKxn0gtOZ43vafSHj/4W1l1Z1ShKCumGiJp+sEty+qw73vpnNQgdH8vjLiAqk16R+Xt+P38qq1QnZ0k6eOeQmmo=
Received: from MW4PR03CA0145.namprd03.prod.outlook.com (2603:10b6:303:8c::30)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Fri, 22 Aug
 2025 08:55:10 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:303:8c:cafe::9f) by MW4PR03CA0145.outlook.office365.com
 (2603:10b6:303:8c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 08:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 08:55:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 03:55:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 01:55:08 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 03:55:02 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v10 05/11] drm/amdgpu/mes11: implement detect and reset callback
Date: Fri, 22 Aug 2025 16:51:08 +0800
Message-ID: <20250822085434.970798-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250822085434.970798-1-Jesse.Zhang@amd.com>
References: <20250822085434.970798-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: d877d49e-353a-4df7-990a-08dde1599980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nG5TTdR1PmEcOx/izTvNivSlbd7jMpKUuW2ipJ91NrrIIXSBkrGYFk0Rp8mF?=
 =?us-ascii?Q?OtB5sDF4yJmxkftoyLm2NcQtG00Jqp9WnKISAx3iGtNAglfBmvuZ0PDXQFkF?=
 =?us-ascii?Q?EErMIDtAQehjrmSkcKtkrBBABb0JjmkybS2KeiytqOM0J3x5wlWtLmgtufld?=
 =?us-ascii?Q?EM8wGzUond99O/K06ryyNESH7zCCLkQaOscD1GbhNGE5EYeGX138aTEBqoDp?=
 =?us-ascii?Q?FCIlWjfVfbvXwZWpk/hZMluR+pbEwcHM3dVJGw1dcuHS2pqO6r/pR1s78uyM?=
 =?us-ascii?Q?PeLYe0ssOvcX1iKE1HDY4MpNoWknNqjDOIHM0EV8EHqHX2Jcrfk3hVs3nVc6?=
 =?us-ascii?Q?ym/6lh3B3r07YK7XDO+9OdPJC/UcVnb+mVdwKFf6StVnhzd5LiXWXuLxfjLQ?=
 =?us-ascii?Q?1U7m7v6FRxE2DtkpQmAZlhVYjU7pM1NBGq3xCCVemzTwJzwgBJNR8p/0DkBy?=
 =?us-ascii?Q?RMZi/hfznryZQh1KQXdNotbPru/pwjR1LYK6xNRm74S69rc6jzG89+woLLva?=
 =?us-ascii?Q?jxJKSo4gqjdK1QP43bX0jWbbbWfHuzpOIJpeLSJ1WeF5O1RZKxDC7Dr2d213?=
 =?us-ascii?Q?sZSBRbpSxXUrBvlCnvkZMdW4Bx1qDovkRL+lYazMuOOdU7TdM/8yGHotioGh?=
 =?us-ascii?Q?KM+hm9bipaqn09AtdlqJlcIADf3Uhgkp64Ny8YH0hu+ouFgBEvsgMWKTF0GA?=
 =?us-ascii?Q?mElqi45po/gTa6XHMwMjkL7fRukuO9hKIsBGDgg7cVks587cpJ/xHWHDSVei?=
 =?us-ascii?Q?orgsmbmMjDu7xOJnyV6g1u1leqN8oKECHtjDBQR8rZCyf93T70ySqhvQYRs5?=
 =?us-ascii?Q?MPXS+RDiC98VzFBvdEmUKgE2nvXvwtkEd68Ufnyh8bweVPYDmnfT86idMVP/?=
 =?us-ascii?Q?uY0pZyy/4rtImFBlJl8hugLUzgd2O1VyZdmyY+qIGdvEjL05gjPq6ofhQPWf?=
 =?us-ascii?Q?XxSG5JWlBKs3MFQK6Y4kE8eUUyDwQJJ0qOb6mEpDxrOJNS4rJon97EiCWX0k?=
 =?us-ascii?Q?bLlrWNCsPDRtk+e6X6gJIQsR5HNwEZgcw1l9+nNyBRLNYnZb0TEZvKjGW+Vl?=
 =?us-ascii?Q?jURP0BYjiFqVRzHLPvqD/+m9lAl/YyWGg2FDSHRWpP15U19X/5aC50WHJrQo?=
 =?us-ascii?Q?w3PG7DEMMVUxkPwt2blePP7yo3ce8xE2lgc54ZGu/JUJlEdFUrEzCXMMhhMW?=
 =?us-ascii?Q?fWdX0YTB4Gb0hFzb4HiKH5du4wu7cYO+FOslHxpMrG58fCz/VeBk+16VQ7gS?=
 =?us-ascii?Q?+AjCEs0VQQLX3UOe2h21SeRVw1wh6kDzuYrZZ3+sU8oAE29qWDAlCtEC34e+?=
 =?us-ascii?Q?LzjwYL6z0b1WCzlDXZfs9IKWC7breBuVe9WAadz6Cg/GN5mhGVLrhPxn/ELp?=
 =?us-ascii?Q?isSgzO9V0jQ1uKpjYQYjT+sdVp5oP3e4/3T6AQCUpFNuu57EljgfzX/jj3Mz?=
 =?us-ascii?Q?H5I9TK89G4lQm3ny3yCfXbmhSRYrNpOYxeQ+N8SMLyRZT0o0WNtr7w9nBx20?=
 =?us-ascii?Q?c42c7XRS6vfl1XGU6xT9aY04KfdGLnbmKIbT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 08:55:09.9162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d877d49e-353a-4df7-990a-08dde1599980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428
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

From: Alex Deucher <alexander.deucher@amd.com>

Implement support for the hung queue detect and reset
functionality.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 28eb846280dd..ed6a7f8af544 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -66,6 +66,8 @@ static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev);
 #define GFX_MES_DRAM_SIZE	0x80000
 #define MES11_HW_RESOURCE_1_SIZE (128 * AMDGPU_GPU_PAGE_SIZE)
 
+#define MES11_HUNG_DB_OFFSET_ARRAY_SIZE 4
+
 static void mes_v11_0_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -783,6 +785,32 @@ static int mes_v11_0_reset_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__RESET, api_status));
 }
 
+static int mes_v11_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
+						  struct mes_detect_and_reset_queue_input *input)
+{
+	union MESAPI__RESET mes_reset_queue_pkt;
+
+	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
+
+	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
+	mes_reset_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_reset_queue_pkt.queue_type =
+		convert_to_mes_queue_type(input->queue_type);
+	mes_reset_queue_pkt.doorbell_offset_addr =
+		mes->hung_queue_db_array_gpu_addr;
+
+	if (input->detect_only)
+		mes_reset_queue_pkt.hang_detect_only = 1;
+	else
+		mes_reset_queue_pkt.hang_detect_then_reset = 1;
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.add_hw_queue = mes_v11_0_add_hw_queue,
 	.remove_hw_queue = mes_v11_0_remove_hw_queue,
@@ -792,6 +820,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.resume_gang = mes_v11_0_resume_gang,
 	.misc_op = mes_v11_0_misc_op,
 	.reset_hw_queue = mes_v11_0_reset_hw_queue,
+	.detect_and_reset_hung_queues = mes_v11_0_detect_and_reset_hung_queues,
 };
 
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
@@ -1684,6 +1713,8 @@ static int mes_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r;
 
+	adev->mes.hung_queue_db_array_size =
+		MES11_HUNG_DB_OFFSET_ARRAY_SIZE;
 	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
 		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
 			continue;
-- 
2.49.0

