Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73906C67861
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Apr 2024 18:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ACA610E54D;
	Mon,  8 Apr 2024 18:25:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KL1/Cv9F";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C5CC10E54D
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Apr 2024 18:25:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyR4GrvqRkEPREI/bHtcmtFRo87R0Ix/GYUwDmepXWpp11v3JOwbOAbDk6rlOPSIbnvy7aSzCBwnX47uNfvc4yr5+IGVJz5pASHEsywTEH3Dm41JBpNRR41+gY1++4rrDCjOibhtxmqag2u2+9qwVmqlYJM95+TjV42DeGPypY0+coXbqiN4zcvyDj0i02kkWlOwhFNggzvSkFIHCZUYc5WqcAujGuig74dH8Kvd/2WZQp02RBhExyQsa3pYunV7gYukAt/4j9Tmm0rzfi2QWA0brbq19gi9VsWpHzO3Jrsf9typCl5OZ7z7Hn5rb3phZ0stKjCw1UnDazXmz+pP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUtmjV332cp4BKbXV0CL3utJ7a3bzMrpG9GUkVqa744=;
 b=ntlRlfmf0FaIFZtX9PzHPLoIPTKhzm+VX2ZBX79uxwE+y1Iw9zr5Cm/Xy6gwKbT5hMx2NcuG94DTyaiP5gpQvziF3sLq+oEYEPLzNZH8jjE2vWMnMlu92YwlRw1Mke0H0PCWe//Cr8Q/xV/a3d62FcwfSX2qvtEEyuDyU2w/ritcWYabkzSU//gMEgymUdEMwY9uH5hN1i80kDmzdIi8ef7kUMno2llS1dV3MKwEb92QDAMrR9cDcYcDdNS635OwN0eZ+CCIG63N6oIuDsc5J3z9L4RDQ2XhVhlZGPP32LsaXCxRzIV2yXLM6VmZZ9FSVibGDyupZev1KSdlfe7ZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUtmjV332cp4BKbXV0CL3utJ7a3bzMrpG9GUkVqa744=;
 b=KL1/Cv9F91b9R/NrR8h0RB7hs32yqZU4wmnGiRR5Bq84GF20wsYEsSHamk3cBLAAd7KkqHNwb23HEGxicbKDhwaArxIWHHRPpMiiAfH8jOvC8y5hdLAx8aK0WD5nKVFqQF6iL0S94X1Nr5dfmczywsKnvXyIZ5S/4adgz7bs/Vg=
Received: from CH2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:610:20::20)
 by CH3PR12MB8534.namprd12.prod.outlook.com (2603:10b6:610:15a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 18:25:18 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:20:cafe::b7) by CH2PR07CA0007.outlook.office365.com
 (2603:10b6:610:20::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 8 Apr 2024 18:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 18:25:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Apr
 2024 13:25:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/mes11: print MES opcodes rather than numbers
Date: Mon, 8 Apr 2024 14:25:03 -0400
Message-ID: <20240408182503.364555-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CH3PR12MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: d1fd373c-aafa-498b-6061-08dc57f93e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MtAz/PF4TwIftj+uxK+pUtvSKQlqR+sME2UFXMxKqAvxhb+rVy5lI7h4KCFFKVIHbUl+8243lldxqFXV8XnkK6RTh59WMjJ3vEzk3GoYzyXJa0h5UhuO9xzF8cWa1nb/Hbo5XPc8eATNlO/L4qyClf3bU/ugUDvl0ybgZuallCLORkWh/0m2aC27b0dMH2gmIXCKKb7HCCodQfF7enL7gcmyZehAhkJI0QtK6j88PPBNVLbchvEBudjVsEPc6QEECZF4cmw1kgu65mQfiruCBsGQjTqMUks0AQ+r6BT5pA+tufM8tilcAvtixfIcRPajfF662MX7/i7CCcbDsdDcT/UnmY4UHBInlAUYJOwPsX56Yv0uc36re/feyw8muP+FuzkE/tF6sOFsL7KeUsq2CIJUpyU/VXIyM2nr38fEUAmzizSJYQ5X2OS/Osw/+ViY4tEGfmnQEdQR6bTGCcaqMvARVWi4DLBDP1oxTVeTgFmoSTW/y+woY6L3981sxIx27GretOAGpXB0cCkMXr/eLPoSXEBAeaavf2KvlHgqeEK/xY8BYzGAHrj6oj0Dx9TTtZ0IE5ScQYRJ12V+6HzzxL9obbSc+VrdcPMi8BYQA9jEOofSXy5hsJc/77tG+K03dURZq73s/+/jUrEkbaMYSyw38aIawaV7RbvBo8aPjLZTgemOQYMfUuEaT27vsqf4+Nal8lULaSzNj0+7cB/1NEvbHMVbpmmMcrBk1oj06Yt49Rp7dW2i/9eFNELH1kw7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 18:25:17.8468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fd373c-aafa-498b-6061-08dc57f93e24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8534
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

v2: use dbg for emitted, add helpers for fetching strings

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 78 ++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 072c478665ade..69d39ba726e12 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -100,18 +100,72 @@ static const struct amdgpu_ring_funcs mes_v11_0_ring_funcs = {
 	.insert_nop = amdgpu_ring_insert_nop,
 };
 
+static const char *mes_v11_0_opcodes[] = {
+	"MES_SCH_API_SET_HW_RSRC",
+	"MES_SCH_API_SET_SCHEDULING_CONFIG",
+	"MES_SCH_API_ADD_QUEUE"
+	"MES_SCH_API_REMOVE_QUEUE"
+	"MES_SCH_API_PERFORM_YIELD"
+	"MES_SCH_API_SET_GANG_PRIORITY_LEVEL"
+	"MES_SCH_API_SUSPEND"
+	"MES_SCH_API_RESUME"
+	"MES_SCH_API_RESET"
+	"MES_SCH_API_SET_LOG_BUFFER"
+	"MES_SCH_API_CHANGE_GANG_PRORITY"
+	"MES_SCH_API_QUERY_SCHEDULER_STATUS"
+	"MES_SCH_API_PROGRAM_GDS"
+	"MES_SCH_API_SET_DEBUG_VMID"
+	"MES_SCH_API_MISC"
+	"MES_SCH_API_UPDATE_ROOT_PAGE_TABLE"
+	"MES_SCH_API_AMD_LOG"
+};
+
+static const char *mes_v11_0_misc_opcodes[] = {
+	"MESAPI_MISC__WRITE_REG",
+	"MESAPI_MISC__INV_GART",
+	"MESAPI_MISC__QUERY_STATUS",
+	"MESAPI_MISC__READ_REG",
+	"MESAPI_MISC__WAIT_REG_MEM",
+	"MESAPI_MISC__SET_SHADER_DEBUGGER",
+};
+
+static const char *mes_v11_0_get_op_string(union MESAPI__MISC *x_pkt)
+{
+	const char *op_str = NULL;
+
+	if (x_pkt->header.opcode < ARRAY_SIZE(mes_v11_0_opcodes))
+		op_str = mes_v11_0_opcodes[x_pkt->header.opcode];
+
+	return op_str;
+}
+
+static const char *mes_v11_0_get_misc_op_string(union MESAPI__MISC *x_pkt)
+{
+	const char *op_str = NULL;
+
+	if ((x_pkt->header.opcode == MES_SCH_API_MISC) &&
+	    (x_pkt->opcode <= ARRAY_SIZE(mes_v11_0_misc_opcodes)))
+		op_str = mes_v11_0_misc_opcodes[x_pkt->opcode];
+
+	return op_str;
+}
+
 static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
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
@@ -135,13 +189,29 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	amdgpu_ring_commit(ring);
 	spin_unlock_irqrestore(&mes->ring_lock, flags);
 
-	DRM_DEBUG("MES msg=%d was emitted\n", x_pkt->header.opcode);
+	op_str = mes_v11_0_get_op_string(x_pkt);
+	misc_op_str = mes_v11_0_get_misc_op_string(x_pkt);
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
+
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

