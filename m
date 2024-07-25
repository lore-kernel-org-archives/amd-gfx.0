Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B59C52CD9
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4320110E850;
	Thu, 25 Jul 2024 15:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ULuGCPVH";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD80510E843
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGcjf5Skjbt9tW46a7JoJ3kGDfLH3Ss8nJeIGCw2z7T4yIPC+tCCb2WLMbeVRl3ZO+tfF456RChF+IuxKGLKNpn9JL14tq0uqT4ZVqViP6YjsFaUeyUE5BLm78tYiglL80iIUt30eFAuNfXh5fGesUQFFm1ilZTjfnVOdqAen9x2UBmdCFegGpj2rt8Z9MDuCNDTF1/UQJdrBEk0Iu0xVttWBfdbdK7/LTBNvEAj4MxByZ5SuhQ7l0RijbhCI+uufQdpsE6xDtQo6cq0rlbP/BFmGCh8NAXzZrQIp5Mhxq9jpGtlTOoisOlgjVMloEH+FkanKIsOn6XAJXs0wZdjJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9sXsxKibqnyCRN3g3C3HCQZig7Sx9FWrGzRNzwGHlQ=;
 b=tPxYGD3V6A35rCEHVaO5+FKoEj3CrCBpEnc1J9FGPWWwhYRsSuBmaPtSrmt21x+BzJilT3HPTLNLrWXeeBAhtWO3OVp8gr6spKU8dG9htcb9QkBMTPY229G8goWRDR1pnIE1GAuP0cdM7OE/8NmiOWNoEW+uCFRRvOmdxNvutOQ5JRvfkfnseLontM6HnIoDXIGR9Y4ztQKexhVHoJ5R5VLXmzCRoNPhMfURtFAgyep55esRZax0lvwQQ5rkSTobVLQdcKgQykMlD8/WNj6i1fCr0sM22r/x3l9ELaPfH8khmIpt+tIJURUw/BKtsHNApPBm6mGSO8fxzlfuF9JOng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9sXsxKibqnyCRN3g3C3HCQZig7Sx9FWrGzRNzwGHlQ=;
 b=ULuGCPVHA0E2c+j1GjxK/uJmdLu6V8G0JKAGJaT22ILaw8mqxU1QB9H3ymzCfRB6MM+ohCal91ers2CTes6xXFinkHIejElSRGQOG5vtKd2gBsH0bdHdY+9dsYl3iGMocvkXGydJ+cy8/jmJgqY8wX3Az/CvuAnj7s5aCQzy+M8=
Received: from PH7P220CA0110.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::21)
 by CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Thu, 25 Jul
 2024 15:01:18 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::29) by PH7P220CA0110.outlook.office365.com
 (2603:10b6:510:32d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/53] drm/amdgpu/mes12: add API for user queue reset
Date: Thu, 25 Jul 2024 11:00:10 -0400
Message-ID: <20240725150055.1991893-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|CY8PR12MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad699c3-f1ce-4935-2861-08dcacbaa2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jUUqlHuFIllxAgHmF1zGA3tCq/xOJMOZjJeU7WfAK5Lz8I1EUB9xImBfQ3SB?=
 =?us-ascii?Q?v9yUd00dyORZwBVAlJsdSSDShimIYQPpgOojEIbAgeSCUZvZPrQNx+0GC4Ug?=
 =?us-ascii?Q?uiZEP1LRwLW+HI05tEKX+amG9UryDlt7ItkDWDA+L/IhHggnsHsStr318nid?=
 =?us-ascii?Q?NAZZVLQZuFnjn7MV4J7xodM+NnsaV3yjBCXDd7vuHVAiYJy6RQH+TJZEa1Bg?=
 =?us-ascii?Q?vX/DLznjCBTe1wZHr9CDiwgXllXgyU0GEJduLGpzBBJoysYlLiXlQ7qrhIUV?=
 =?us-ascii?Q?uMz7hcc5Jb70W9GhKZZjiZxoIj+H84hM1lIRclJXjM4Ga24M8siL8dc5bTaE?=
 =?us-ascii?Q?jaMlcwRp5VRxSGjTkQT13rJ3t886SQOaylQcwKamNE5TG9QtpSxH1YUU+fav?=
 =?us-ascii?Q?MZsRkYfCBvrJlUoR6VMY9btpigHsBvtTfAtnInOYJ29ssOYoU64ljeTHUVNO?=
 =?us-ascii?Q?BhRlfp+LZ/IDs6VA4dUEwLWwx2NXer4LQy2Z7+MHUBzyyGriktiKWTW0q/N0?=
 =?us-ascii?Q?DIi2mMkIvoAiTn20Xwb2bZk646cjtxp6emRhRmW2VXWrqc/zRezdV4Tsm4Lb?=
 =?us-ascii?Q?XvZS1BUZAmtv3nrNNoruNL5NmHEkZpl+70dHSmzYrSYgL586J0VxdA3JIsX7?=
 =?us-ascii?Q?u2p7Kea7f34qjErP/5EjopDovFwMOL9q3+eOqe3YhpxwOWn3/C44E5jKLtQV?=
 =?us-ascii?Q?kACOzVHcZVj16K8rAyILL7dW4ITJW5MmrGe0EWix8kwz0JDmSlR+ag5LFh9L?=
 =?us-ascii?Q?LDYH76S/XYJMrzmWJ6RJBUKqExW21gSNThHV7McH3RJfiVIw6plR9DnTETea?=
 =?us-ascii?Q?qPVF2fOzqe/OZJOa+myv0g7yCCqERcQF6YL+i0yWvhEkH/xHWOocpo9or7cR?=
 =?us-ascii?Q?FbJ+2fO8dLFruOIzn2MO+AQYTjlNB5km8nS8nx0Q+i6XfViX7VS87gQKwlPJ?=
 =?us-ascii?Q?W+/vEDbnUpe7bGYTkIGAdlgcgh5Qhvrfgnx0o0Jt22EYC1s73bbeO2+Kg9Co?=
 =?us-ascii?Q?x99/eAnLSfNGzMXU2RYOwePUM2Apao12UdXCr9Dap+RjwtIL4f+LvLPFMf+j?=
 =?us-ascii?Q?C4646dKyrIQ4LusxfYvyBPVzurSq+a86UYyVIM15AAC6sJfqfVNS7aG8RPox?=
 =?us-ascii?Q?AfvUcSNoWK6ynRU6/fWIkdXWsr0CG9FiEvUkn67QZSQSSM2Hiw3CIp8CwMLC?=
 =?us-ascii?Q?9UST+rMongTXIx3O6nLsxOZycPoZkBGt8W5e4WuDqIy/bw69cJoJapFko8O6?=
 =?us-ascii?Q?/fxWuY8Kvuqh6icJUNNvYBHDmqXr3TkAbW2dEyk4/dlCQ4/Bn+q61Kx5Hwmx?=
 =?us-ascii?Q?31d/z8cAfGGhBAlGsnnuzBw69EltjlsN2SERX34Www/9QyBQfnScmhehKV+i?=
 =?us-ascii?Q?WvrsJHSB0gsXZeG49qvK2vHox7ohZUPwIPwpc+pRZQj9ZJ68yjRgqCc8EFBO?=
 =?us-ascii?Q?FeGPf41KeKIiZegO8BoLjHoSyEz/VULR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:17.6715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad699c3-f1ce-4935-2861-08dcacbaa2fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7313
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

Add API for resetting user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 37539092f59a..4c3487f257dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -344,6 +344,26 @@ static int mes_v12_0_remove_hw_queue(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
 
+static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
+				    struct mes_reset_queue_input *input)
+{
+	union MESAPI__RESET mes_reset_queue_pkt;
+
+	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
+
+	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
+	mes_reset_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
+	mes_reset_queue_pkt.gang_context_addr = input->gang_context_addr;
+	/*mes_reset_queue_pkt.reset_queue_only = 1;*/
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
+}
+
 static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
 				      struct mes_map_legacy_queue_input *input)
 {
@@ -685,6 +705,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.resume_gang = mes_v12_0_resume_gang,
 	.misc_op = mes_v12_0_misc_op,
 	.reset_legacy_queue = mes_v12_0_reset_legacy_queue,
+	.reset_hw_queue = mes_v12_0_reset_hw_queue,
 };
 
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.45.2

