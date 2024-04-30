Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B358AC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 20:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA0C112F33;
	Tue, 30 Apr 2024 20:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KZRnZRx+";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 117F0112F33
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 20:36:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcx5PlaQUr6WSr7VrN9A2rZa3NtoL6kx671Pkn0cpzeLjmvO+kRtvLJ3zuJydor4Ynfv4ufLuGL9v97o/8NO3MaOLGBCgaSZriP3K4Cp8nGh2sax4t+8u/rMM298yMdYbHKRSm3ESGSkHWzxJurKvW4ENVM+TDkBWoAIA4hhXJQJqCK7oFg/jQnsXS8CpDtZmq361XwhBBT52tQ5qSO8JfQ7YiUxTagQq8t75e3eOE6chUM4PSnQR+qwfVN1Y8BATviM2F4+cSLtt8rmBEhpujJytmDX0+tL2ArCgtrHXnGVaMf05X1hPKAinMdvxAavS+FP4kFg2fBehTX8wZOXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usDKx8xMVuKXwTAFA3mUqBxvPlBnOFwFyWXFD8XrIys=;
 b=MGNKpZvq9PZ5zgrAMBTTFVZY66DyCzhOv7sbWug7jltnRg30653eb0zcaUNsYiSiEP5m7t+upMDPbiY9FAhHHJ6g2eZb8C3/mzaxxWXnUz9allZp9u6xjjPh4b1A5BTxoHBtmn6H8A3tiiacbc8DlJpkYI3Kc13bmq5EclJ70CpUN/xwYh2k/KdKTttE8PEZTtEcuwmZmP/d/sF85694mgOt2fENvGeCyAB8cBZ58ImrOae96fflkEPHZulRwTQI0nGvsroEIZa/vowmxp+2mDNdRH8Wt7oPyFQR36/EskcbC876+BLneP37GxjnLnPKsvByFvfRZK/YRoKLcI4Q1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usDKx8xMVuKXwTAFA3mUqBxvPlBnOFwFyWXFD8XrIys=;
 b=KZRnZRx+Y/GgPXqlvcgnxdtbgwvYD9Pp4l2J4jc2+6avwZlwSa2SxjCgHnHji7cQjSd/DIbWXEtchqJJEilKuWHDpnKH7l13wieQXljP3zoTj+zQR3LePEDqr5qeqjgDohBPoFovMNmxVuV8KFaPkMekdX8vkutDVzxSAswH0FE=
Received: from SJ0PR03CA0238.namprd03.prod.outlook.com (2603:10b6:a03:39f::33)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 20:36:23 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::89) by SJ0PR03CA0238.outlook.office365.com
 (2603:10b6:a03:39f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Tue, 30 Apr 2024 20:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 20:36:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 15:36:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/mes12: print MES opcodes rather than numbers
Date: Tue, 30 Apr 2024 16:36:07 -0400
Message-ID: <20240430203609.799792-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 823d1169-0103-4fee-b8d7-08dc6955333b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qx0HmANr0cyUQUfOYeZZrRLW8igKFaQjjbHzZ9P10dZf0+GUOFd6lud3yMB5?=
 =?us-ascii?Q?VXYeXDWXVbCKihH7jLAtMpeZZxm+4KPWVHLOH/9IhSlk/xtgdi3fu0Y1ybS2?=
 =?us-ascii?Q?P8TcdSk+Mbtc9ksnJV5kp1aMuvV5JwcvGGme21uOVQz2WX3epOp6clno+9TB?=
 =?us-ascii?Q?i6UqeJWtveri5Xf9RVA51e0OuPa4DOSRRICHWsw5I89+emJSDQ2NV5d2iwLD?=
 =?us-ascii?Q?18r/1L38OAcn195OrWyS1iPEWna3Z45ubuIVeyq9m6o4Tu41tHydATiQLGvk?=
 =?us-ascii?Q?MoG8da7v8tmWJqpCVQtFp95J0TlHgRskn8mXAuYJzyAEB8kx14bdUA1Z9jyL?=
 =?us-ascii?Q?zLnTsrft0fUWP85vrNvsNM0AfXhsDVgZ6Fgu27uu8aEoCsGOQOMgRUp9INX+?=
 =?us-ascii?Q?lI/hXGzHKHUQP5K5GIuWWyvB6KAUcXcrqBTiK9UrFw2rGx4LGr7gB7p9LDhp?=
 =?us-ascii?Q?O3q3aPr6Qiwlp5r1flCOShHpbuW3KO6oYiR5oI708/Jmby8UuNZyG6MoewNE?=
 =?us-ascii?Q?kFvTM82Pz9x4Wjf/od3fgto4ME7JN+ZpntJ/q7hRog6/MzEM97GsMBMBDnRg?=
 =?us-ascii?Q?qNemrEVmH/U0EdTbOUHFfL/6l1lTpUMePrvT2N04Yh0Efz9vLGzw7WBw/JVz?=
 =?us-ascii?Q?BBQyx4szNIUe1jj/xJ8DZK3qxmzFqIqsE8qVLfP0llqnaVHlLGYT7rM5ykf0?=
 =?us-ascii?Q?o4GdXIiE7gJ9Ftr7N86Tjn4VgyBARq5K+gHj6NjmHwmaDBOW2Ul4XMWUuN03?=
 =?us-ascii?Q?0PkY7f5s+meHeh/TJ8zR7yvPalhSF+MEvmnmhz4E8Wv5ksrgjwZceo7JAMmM?=
 =?us-ascii?Q?zSLDV7eHnE1nGS3yiGk/vMgCSwgVXWgnl4zEiRsRBz73fbB8IbPw9xNNXyIP?=
 =?us-ascii?Q?jGx6PyU1lKBaowT+0kaScr24HWgxPvp8LrvE/bWP2yMcQ6Tt4x4da/Y14rwW?=
 =?us-ascii?Q?7mjWw1W6dAFn9WibzyvatZ1u86h5aljhyTaY9ZralVO5dDDaChH4E3gMMiAA?=
 =?us-ascii?Q?odnc4XfFR1gzUxE4woIkvdu3RjDbKK74fgYO5lCoAqfzn9EODbuWT4NtEU5o?=
 =?us-ascii?Q?2/fFm7rlWRfr8uRDulZiWskZV2U988gz/PBn+75YiZA7B0Rm+X+wpyH57qi4?=
 =?us-ascii?Q?5te4hKZYcnpW/luw1nS5MXh5pb77SiDjauMsUELz+iJ7qZ6SYzVB4mwEU3U7?=
 =?us-ascii?Q?px+4eSi6cHqcnHdQvfP12uftEy9xtoUKXir+w44BvNvr4eRJmQeihl9OCoiV?=
 =?us-ascii?Q?+qrW+cXdhT6MBWB48OhaN7oHBALDeZ4cCmOGNnGOvuTHnnMJjXBnQh20SswH?=
 =?us-ascii?Q?Oc2LO4MGHYKNODutsi97vaBXTMy+59hmIePp4Bw4/JSb8TG0uQA3wMjiRPSh?=
 =?us-ascii?Q?evZQghvr6va6sbNk5l39yElY1O/B?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 20:36:23.0737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 823d1169-0103-4fee-b8d7-08dc6955333b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
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

Makes it easier to review the logs when there are MES
errors.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 81 ++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index cbd5b312a075b..9385ee76f3e6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -86,18 +86,76 @@ static const struct amdgpu_ring_funcs mes_v12_0_ring_funcs = {
 	.insert_nop = amdgpu_ring_insert_nop,
 };
 
+static const char *mes_v12_0_opcodes[] = {
+	"SET_HW_RSRC",
+	"SET_SCHEDULING_CONFIG",
+	"ADD_QUEUE",
+	"REMOVE_QUEUE",
+	"PERFORM_YIELD",
+	"SET_GANG_PRIORITY_LEVEL",
+	"SUSPEND",
+	"RESUME",
+	"RESET",
+	"SET_LOG_BUFFER",
+	"CHANGE_GANG_PRORITY",
+	"QUERY_SCHEDULER_STATUS",
+	"SET_DEBUG_VMID",
+	"MISC",
+	"UPDATE_ROOT_PAGE_TABLE",
+	"AMD_LOG",
+	"SET_SE_MODE",
+	"SET_GANG_SUBMIT",
+	"SET_HW_RSRC_1",
+};
+
+static const char *mes_v12_0_misc_opcodes[] = {
+	"WRITE_REG",
+	"INV_GART",
+	"QUERY_STATUS",
+	"READ_REG",
+	"WAIT_REG_MEM",
+	"SET_SHADER_DEBUGGER",
+	"NOTIFY_WORK_ON_UNMAPPED_QUEUE",
+	"NOTIFY_TO_UNMAP_PROCESSES",
+};
+
+static const char *mes_v12_0_get_op_string(union MESAPI__MISC *x_pkt)
+{
+	const char *op_str = NULL;
+
+	if (x_pkt->header.opcode < ARRAY_SIZE(mes_v12_0_opcodes))
+		op_str = mes_v12_0_opcodes[x_pkt->header.opcode];
+
+	return op_str;
+}
+
+static const char *mes_v12_0_get_misc_op_string(union MESAPI__MISC *x_pkt)
+{
+	const char *op_str = NULL;
+
+	if ((x_pkt->header.opcode == MES_SCH_API_MISC) &&
+	    (x_pkt->opcode < ARRAY_SIZE(mes_v12_0_misc_opcodes)))
+		op_str = mes_v12_0_misc_opcodes[x_pkt->opcode];
+
+	return op_str;
+}
+
 static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 						    void *pkt, int size,
 						    int api_status_off)
 {
 	int ndw = size / 4;
 	signed long r;
-	union MESAPI__ADD_QUEUE *x_pkt = pkt;
+	union MESAPI__MISC *x_pkt = pkt;
 	struct MES_API_STATUS *api_status;
 	struct amdgpu_device *adev = mes->adev;
 	struct amdgpu_ring *ring = &mes->ring;
 	unsigned long flags;
 	signed long timeout = adev->usec_timeout;
+	const char *op_str, *misc_op_str;
+
+	if (x_pkt->header.opcode >= MES_SCH_API_MAX)
+		return -EINVAL;
 
 	if (amdgpu_emu_mode) {
 		timeout *= 100;
@@ -121,13 +179,28 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	amdgpu_ring_commit(ring);
 	spin_unlock_irqrestore(&mes->ring_lock, flags);
 
-	DRM_DEBUG("MES msg=%d was emitted\n", x_pkt->header.opcode);
+	op_str = mes_v12_0_get_op_string(x_pkt);
+	misc_op_str = mes_v12_0_get_misc_op_string(x_pkt);
+
+	if (misc_op_str)
+		dev_dbg(adev->dev, "MES msg=%s (%s) was emitted\n", op_str, misc_op_str);
+	else if (op_str)
+		dev_dbg(adev->dev, "MES msg=%s was emitted\n", op_str);
+	else
+		dev_dbg(adev->dev, "MES msg=%d was emitted\n", x_pkt->header.opcode);
 
 	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
 		      timeout);
 	if (r < 1) {
-		DRM_ERROR("MES failed to response msg=%d\n",
-			  x_pkt->header.opcode);
+		if (misc_op_str)
+			dev_err(adev->dev, "MES failed to respond to msg=%s (%s)\n",
+				op_str, misc_op_str);
+		else if (op_str)
+			dev_err(adev->dev, "MES failed to respond to msg=%s\n",
+				op_str);
+		else
+			dev_err(adev->dev, "MES failed to respond to msg=%d\n",
+				x_pkt->header.opcode);
 
 		while (halt_if_hws_hang)
 			schedule();
-- 
2.44.0

