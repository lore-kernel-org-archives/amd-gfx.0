Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6AF60A5BC9
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YTjyc+JU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1AF81120A4;
	Wed, 18 Nov 2026 22:37:43 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013029.outbound.protection.outlook.com
 [40.93.196.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 429A51120A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 22:37:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGVk05wXY+wevl9PtHjuDSkzr2uA3yqw320Hto41nFulK8CbvXfoeWf6funzVxK1kk8evNgi2T9P6GPqhZgyeVsgB4yNZP81uAXPzdogiJX4cUF4Bpu+erCsuVXgMFiVxio6AuMETDTa6n1Mf/EbTdzJIWsDD3mEuqjN0t47iYFFxjvvRydyo+fZ1uu2bCOeu/TblUH3yNa9rqRGyi+5jAxmxfge/umgCfu2QKHcFhLhnPzxkJCGwC3kaQzHh1RXACMFzqCLCRoaZdkDA6P4x5M4SWblmT1vdHDC4rL+aSdflc+WxQSENGPvReNp239IOVLUt9pqxHB6gLf4D7v0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZqoGeex5eQq1gwll8jEI2qqSjfRuvuj2timKnHCcIs=;
 b=jNe6f557BCG+xL96Fd+oENc6Nd4lIxrCzfee9HgvNg+gIi8NiUkr7Bxz1huNY1NxPPXrsZ2V3/lcvKqxaRqeEjob/9LN76YdxpWO2p0IBxHFL6kjXpTGka8FwNtLoxoHxJjGGrz2jr7hhW7lcOzvBDzA0RW7Dn7kZ/RG0ETak6yz0DMTnyiv2pUvcGr7Cjt6kW3bvRCcLPEDnbptNSPIo+qT2UGYvF0ywLFYrtB4HHCKQYEHR2xgdY2ydanE8QXkNM3i+gtXidd0XR9YX7lxFasXjCgx24CBQIvqIf+OamSqjcuaUlwmtzL/SfmVzloG9eMEy5LNDRAKUacSByu2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZqoGeex5eQq1gwll8jEI2qqSjfRuvuj2timKnHCcIs=;
 b=YTjyc+JUIINLtTv4HTiY82AO2PIpBbfjlnF3ZO9XZvD3bc4KF2aZNd2Yew6DioJv++9PS/Gu4VrCySDlDJ5XpFV8W4d5a1LerrMSYOVrG9A0cl6PqKrNi+2KCBhmKCfIcw1n9AXG3krZLLZ25XVSZX2vtaJ22pFftOvBaCI9I2w=
Received: from SJ0PR13CA0066.namprd13.prod.outlook.com (2603:10b6:a03:2c4::11)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 22:37:30 +0000
Received: from MWH0EPF000D8953.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::44) by SJ0PR13CA0066.outlook.office365.com
 (2603:10b6:a03:2c4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.7 via Frontend Transport; Wed, 18
 Nov 2026 22:37:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000D8953.mail.protection.outlook.com (10.167.249.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 22:37:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 16:37:26 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 16:37:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yogesh Mohan Marimuthu
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 05/11] drm/amdgpu/mes12: add support for setting gang submit
Date: Wed, 18 Nov 2026 17:37:06 -0500
Message-ID: <20261118223712.2518580-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118223712.2518580-1-alexander.deucher@amd.com>
References: <20261118223712.2518580-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D8953:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd6d401-f7e1-4884-611a-08df45c4871e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|261102123227099003|18002099003|22082099003|261009223027099003|11063799006|56012099006|261028144727099003|261026140227099003|261022105027099003|261021121427099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: r9O+SMIz4XKPFXIT5R0N/85vA0LMQT7Q9dzAgsnmhePmheRMr5mB4i2kZEnkCF97svv1MyULT/Q/oaIUVabqfFMN3ko7RNhBvrAZYESWZYPGbGHXYygxunq/5XGx4O+AYBU4Q2g2jMofJ5E2SFSJy5MThxCFPPzVrYxRYdLfp3qbOvSHNZhZFajb77k1XFSEX2udjPDEWTmPYviZI82ouXoURPskRec1VQLeWr9khWLHdIzzR6vPbA32ARqDw4EmeEhj6hW8Bi7IDlaEPMX5aq27aK/H5kdPKTkazC4uvEmWFo/aRHJTuQ6VPujlDQUvG/emkYnYRFHwAXU885IHd2rhbLDDEyfTPHWvjmHCwZS532jOxTjbe7rZceABe1CqtAMOlFUt/WbfZeBmeQTHg4dm8AWs4hGshoykjnLI4KeWeIP/HFhnCcT2NvUCq4LWyB1tfn6CODVZl2EF240/3ZxN3h83mEh2yxbIua2QYeQtheX1TUBvgrzpsCkGB4bvWNuotRMC01qXUi/2RSkR5jXs26kNyNI7Yjyp3BkveVXtt00nNjSi4uvwFaseUUpn5vRT/ekjDP5YgqrNFG5vmOG+mxm1BUfJ8pfsarv4hHzWAXGyMD0zKLgyQWvIHDx3YzZnp65aZHweEE0GK487l4j4SyTTGNKy7dIj5yhiSLpFKGuXX76bWmbfkCrNRN8fvIJeNZE/fRkNzO67yqb1Og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(261102123227099003)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261028144727099003)(261026140227099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mn3boN4PGImCSFPQRVzK7Vv/h+6BpSivIGsealCqb11eASBW3/VwY+c1F6K1YbQ5OQ4IdnKAZENp8GMFNnin2lQsAGE/uBDQaknlqvBXnlBBfDzimte2w65NbD0HpDd8E14BFA9bPSe9pGNFs/wspRuPP/ffj3Ob2YQd/5CP69Xi8CzoS5OglTY6ke5RrGNSNLXzKpEBdzOtKNTUxaHU1hkM2rewgNo0sDr8s7YOy0LmfUqN2T27nDfmAFB6mdo8AvmfApNU8hYtWmY63e8XrrclooXEdF4I0ynrl070gGjif+nJ+WJFvIw137TqiPy39NfbQpAtASOih38vlsAXAtaJglV7pygAcrVhEXZq/Mb2lnIqODjM9PMeDnR0ncl4iv/QLBGWRj0FWUt64rAO04SI0BlRgMxHNDwVIgYUqB1GgQcW3wHtUb7pT3YcQqwF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 22:37:29.1371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd6d401-f7e1-4884-611a-08df45c4871e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D8953.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable a primary and secondary queue that schedule together.

v2: fix offset of api_status (Prike)
v3: use AMDGPU_MES_SCHED_PIPE (Michael)
v4: handle array indices

Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 988e05823d2d7..f6c359e7d4861 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1313,7 +1313,31 @@ static int mes_v12_0_inv_tlbs_pasid(struct amdgpu_mes *mes,
 	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_KIQ_PIPE,
 			&mes_inv_tlbs, sizeof(mes_inv_tlbs),
 			offsetof(union MESAPI__INV_TLBS, api_status));
+}
+
+static int mes_v12_0_set_gang_submit(struct amdgpu_mes *mes,
+				     struct mes_set_gang_submit_input *input)
+{
+	union MESAPI__SET_GANG_SUBMIT mes_gang_submit_pkt;
+
+	memset(&mes_gang_submit_pkt, 0, sizeof(mes_gang_submit_pkt));
 
+	mes_gang_submit_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_gang_submit_pkt.header.opcode = MES_SCH_API_SET_GANG_SUBMIT;
+	mes_gang_submit_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_gang_submit_pkt.set_gang_submit.gang_context_addr =
+		input->primary_gang_context_addr;
+	mes_gang_submit_pkt.set_gang_submit.slave_gang_context_addr =
+		input->secondary_gang_context_addr;
+	mes_gang_submit_pkt.set_gang_submit.gang_context_array_index =
+		input->primary_gang_context_array_idx;
+	mes_gang_submit_pkt.set_gang_submit.slave_gang_context_array_index =
+		input->secondary_gang_context_array_idx;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
+			&mes_gang_submit_pkt, sizeof(mes_gang_submit_pkt),
+			offsetof(union MESAPI__SET_GANG_SUBMIT, api_status));
 }
 
 /*
@@ -1367,6 +1391,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.invalidate_tlbs_pasid = mes_v12_0_inv_tlbs_pasid,
 	.detect_and_reset_hung_queues = mes_v12_0_detect_and_reset_hung_queues,
 	.enable_dbgext_irq = mes_v12_0_enable_dbgext_irq,
+	.set_gang_submit = mes_v12_0_set_gang_submit,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.56.1

