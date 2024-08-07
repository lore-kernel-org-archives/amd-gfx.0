Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14D2C3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 09:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 157A310E4AD;
	Wed,  7 Aug 2024 09:39:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y0ZfVQkG";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7661610E4AD
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 09:39:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AioSKH4HZ4Zt6Eu7kBOViIPKuaJDm+3r4JS61agDOG64HZsMft4DFcgLdBrKAb529VmW8nIs/M37fbxVLGe5tmjxWmidDfl6OzC51uIR5A7R7gboM3oZD2q/hr7Jg4bbJj+9rMj/8vbPkUON/C0TTtKbGuTP9IlHNE4diC6TUIOtsqDf+R/bfPkOEDTtdvdVbFwUOYvBXnAWkcvMu+IN53ojj9dfavW6ouWnX8KsdUxovc1sDXriY0/875KC8ZPkOpz8CY3M/RQ89O8lh70Mw6n5tG3YDcjjvIXIGJWybv7rozupOm+8en6JR2ZkCeYQKVYDmenfq7S8bjn7kmPijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bVjZtLMcfiKZYsQkVzVw5zP3okHAOWC+mKnppXvL8A=;
 b=isc6uNIL1U2sfH5m0jn5TRtgm2wbRH7PDRIXZ/bUEHYrvSr6TDPJT1DFjoIIuMGkHFNBTmzF4wbVRs9TDr925wVmLm8y6KlhpbEMHB2fO+Yd0GUcntfYevnxvxNROxQCiU7sYjO6oDdOMLTPwOS9haWPKFEgYlqQXfK4QNJ5NFnqecdcJLUrzDaxahm/0vVHbvQ6vfyx2cu9Z2Hb5uTETJPxiLm3Q6Mh3zbW9gXtz+n2DCyEsl98bAo3suoiUrUViMJh1y+4UGjIaXhZbbW/YKT1y6bdUy1WZjikFwwWihnlsiVuCWtP/dW0y9+lpZntd8ZKD4x+rOgl+HAJJW/btQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bVjZtLMcfiKZYsQkVzVw5zP3okHAOWC+mKnppXvL8A=;
 b=Y0ZfVQkGmx9NjSHVRF4h+hXsRhxSDhfD6pUJEd7tio1lvt3Zi6svo8p0N82gB/2SX56ZSUY1rCZzj+DZ7EOJkroSsLsHMFqv/HCLqBg63xsbM3MnySre+4e1+S9WuNkQJ3dYNF8B4TcyHm8cshPBfXrVwckei3CFmi63/9ty0Rk=
Received: from DM6PR21CA0014.namprd21.prod.outlook.com (2603:10b6:5:174::24)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 09:39:15 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:174:cafe::fe) by DM6PR21CA0014.outlook.office365.com
 (2603:10b6:5:174::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.8 via Frontend
 Transport; Wed, 7 Aug 2024 09:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 09:39:15 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 04:39:13 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH 4/8] drm/amdgpu/mes12: add mes pipe switch support
Date: Wed, 7 Aug 2024 17:38:43 +0800
Message-ID: <20240807093847.2084710-5-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240807093847.2084710-1-Jack.Xiao@amd.com>
References: <20240807093847.2084710-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 006182b6-21a6-417a-dc81-08dcb6c4cd55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OEgHgw04MZmeSpMygFdW5mQrN+6JZjf+nXG1eHQKzYK6HwWUkIVxHdFzCDGK?=
 =?us-ascii?Q?9uTG4jjZM+dflH13MrkkDtLkJvQgfIfOKxXjELADnhLCZgrEi4vb27ObypzM?=
 =?us-ascii?Q?cwrZdg3DpIMSWtet9CXIlo9k95uwHW3O8LR6j37y4Krar6+f2BvrHlsojowq?=
 =?us-ascii?Q?6icLUOez94AilKwPbC+UGABRgXVJj2aIlNlHOPqgLFn4i4/oWUlfGWTlWFei?=
 =?us-ascii?Q?jRoJEd1iuFIt96ebZrXmyfdn22YYncnAvifUQ/O1CF4uvVWT25pD61Y4GAaq?=
 =?us-ascii?Q?EVTYMhfm2GtbdxsCBqmwn0OIVurgtsf/muuZX1L+fyR8ixJdWMoYRgkv/vtR?=
 =?us-ascii?Q?ElfBwV4p+Th7EdgPFXBd2pvnQjmStfswF6h7wOezlDH1JAzzSt8Wk8DraqCF?=
 =?us-ascii?Q?+D9Vwq+4qaY9/0MIhPztYvilkeZEsSYrNRi1a0A5GdKdaL1whQzZYHw6FQcU?=
 =?us-ascii?Q?+p0gUynMAdh4HSdo1c+Hm+8BzLieL9s56sWttstpr0UibtSp9nN4I9DZeC3u?=
 =?us-ascii?Q?ve12Wp9SzKsMC+WmutF30TIao2Q9wXWcYU9JxkEIRz2CkhXnfW8ZV4RU5nbH?=
 =?us-ascii?Q?rd3UB94gjYRuHTeicDP3lZsp4ZaykC6HxCbBhtM+lZJNPCXdiYXNL3uS4ZLK?=
 =?us-ascii?Q?VcEIPX9KOEVFlfELjl+LQi4T4FwNRly/ENBewnwkNObpJ8iadrAKrmwieVoD?=
 =?us-ascii?Q?8FQxo96agg56de+N9qnV3XcgNtO5BEZ/nQQ7TD/0s18ZrnB9k7wkNDpHCWZ7?=
 =?us-ascii?Q?XYxPGs7yAAbrGZalCnRmb6t+wahYaG13HhpTdPB83aBhEiMxejTsuExsDzdf?=
 =?us-ascii?Q?oxBI7LDjYcJCgD+8y01Utdjx8hVWdkzDfeae/rq+xQeyU5PC+74pad9IYIsU?=
 =?us-ascii?Q?nv+MsLU3zydMwul0nA7X1gTadkxK9mEEHwKvH2xyDAwFJnTEXNMYVMnczOhB?=
 =?us-ascii?Q?FNM/+G1NtMv4VCW8Q1cFe8zsxAG0EyFX2W0Eg+O7teusCR5fHMQ30F8O6g6u?=
 =?us-ascii?Q?V2oZ89f3IjI3oFeKjS2ct/5Cixp1+cO77et0COHHq4s5mX1vNDGuUr7/JpX+?=
 =?us-ascii?Q?LxLsbsxP5D+oQx6rvzAhDsmgD8RaZGoywSVdhTOWmS+jBGeoyleBPltIweOK?=
 =?us-ascii?Q?q+R1spygxWL0fbcjyowd+kptACy22rTe+NfVZ5jSPAXWn07RMAiSSFMCZ+Wj?=
 =?us-ascii?Q?kMdG7a/bbSzd861Vs4APY1YV0lVrMB9redues90OtVk9696uCyU8VxFDLPAk?=
 =?us-ascii?Q?zeY8nBStvPpsh5769IBVaNedKruzwQvigokrjVnnSZOpc7+Bc4U4a8KI5u1Y?=
 =?us-ascii?Q?3CCQNHza+SECy31ihdaaJuPqTv74BQyfHegivJEMk+OR0Xz2ZphgnXUYGRQI?=
 =?us-ascii?Q?JOQ+iJdXn1OjAuk/oTCHPA2cLnktvRMMjpZqjhWb7fKwTS0OfMJUFglCU/vo?=
 =?us-ascii?Q?+K/WnPRnpmw9U1BGebkN4ZA7avkBFtuR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 09:39:15.3631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 006182b6-21a6-417a-dc81-08dcb6c4cd55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901
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

Add mes pipe switch to let caller choose pipe
to submit packet.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 59 ++++++++++++++------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 932629e47c9a..88b0997fa377 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -142,13 +142,14 @@ static const char *mes_v12_0_get_misc_op_string(union MESAPI__MISC *x_pkt)
 }
 
 static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
-						    void *pkt, int size,
-						    int api_status_off)
+					    int pipe, void *pkt, int size,
+					    int api_status_off)
 {
 	union MESAPI__QUERY_MES_STATUS mes_status_pkt;
 	signed long timeout = 3000000; /* 3000 ms */
 	struct amdgpu_device *adev = mes->adev;
-	struct amdgpu_ring *ring = &mes->ring[0];
+	struct amdgpu_ring *ring = &mes->ring[pipe];
+	spinlock_t *ring_lock = &mes->ring_lock[pipe];
 	struct MES_API_STATUS *api_status;
 	union MESAPI__MISC *x_pkt = pkt;
 	const char *op_str, *misc_op_str;
@@ -177,7 +178,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	status_ptr = (u64 *)&adev->wb.wb[status_offset];
 	*status_ptr = 0;
 
-	spin_lock_irqsave(&mes->ring_lock[0], flags);
+	spin_lock_irqsave(ring_lock, flags);
 	r = amdgpu_ring_alloc(ring, (size + sizeof(mes_status_pkt)) / 4);
 	if (r)
 		goto error_unlock_free;
@@ -207,32 +208,33 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 				   sizeof(mes_status_pkt) / 4);
 
 	amdgpu_ring_commit(ring);
-	spin_unlock_irqrestore(&mes->ring_lock[0], flags);
+	spin_unlock_irqrestore(ring_lock, flags);
 
 	op_str = mes_v12_0_get_op_string(x_pkt);
 	misc_op_str = mes_v12_0_get_misc_op_string(x_pkt);
 
 	if (misc_op_str)
-		dev_dbg(adev->dev, "MES msg=%s (%s) was emitted\n", op_str,
-			misc_op_str);
+		dev_dbg(adev->dev, "MES(%d) msg=%s (%s) was emitted\n",
+			pipe, op_str, misc_op_str);
 	else if (op_str)
-		dev_dbg(adev->dev, "MES msg=%s was emitted\n", op_str);
+		dev_dbg(adev->dev, "MES(%d) msg=%s was emitted\n",
+			pipe, op_str);
 	else
-		dev_dbg(adev->dev, "MES msg=%d was emitted\n",
-			x_pkt->header.opcode);
+		dev_dbg(adev->dev, "MES(%d) msg=%d was emitted\n",
+			pipe, x_pkt->header.opcode);
 
 	r = amdgpu_fence_wait_polling(ring, seq, timeout);
 	if (r < 1 || !*status_ptr) {
 
 		if (misc_op_str)
-			dev_err(adev->dev, "MES failed to respond to msg=%s (%s)\n",
-				op_str, misc_op_str);
+			dev_err(adev->dev, "MES(%d) failed to respond to msg=%s (%s)\n",
+				pipe, op_str, misc_op_str);
 		else if (op_str)
-			dev_err(adev->dev, "MES failed to respond to msg=%s\n",
-				op_str);
+			dev_err(adev->dev, "MES(%d) failed to respond to msg=%s\n",
+				pipe, op_str);
 		else
-			dev_err(adev->dev, "MES failed to respond to msg=%d\n",
-				x_pkt->header.opcode);
+			dev_err(adev->dev, "MES(%d) failed to respond to msg=%d\n",
+				pipe, x_pkt->header.opcode);
 
 		while (halt_if_hws_hang)
 			schedule();
@@ -249,7 +251,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	amdgpu_ring_undo(ring);
 
 error_unlock_free:
-	spin_unlock_irqrestore(&mes->ring_lock[0], flags);
+	spin_unlock_irqrestore(ring_lock, flags);
 
 error_wb_free:
 	amdgpu_device_wb_free(adev, status_offset);
@@ -321,6 +323,7 @@ static int mes_v12_0_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.gds_size = input->queue_size;
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes,
+			AMDGPU_MES_SCHED_PIPE,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
 			offsetof(union MESAPI__ADD_QUEUE, api_status));
 }
@@ -340,6 +343,7 @@ static int mes_v12_0_remove_hw_queue(struct amdgpu_mes *mes,
 	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes,
+			AMDGPU_MES_SCHED_PIPE,
 			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
@@ -365,6 +369,7 @@ static int mes_v12_0_map_legacy_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.map_legacy_kq = 1;
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes,
+			AMDGPU_MES_SCHED_PIPE,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
 			offsetof(union MESAPI__ADD_QUEUE, api_status));
 }
@@ -398,6 +403,7 @@ static int mes_v12_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 	}
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes,
+			AMDGPU_MES_SCHED_PIPE,
 			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
 			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
 }
@@ -414,7 +420,7 @@ static int mes_v12_0_resume_gang(struct amdgpu_mes *mes,
 	return 0;
 }
 
-static int mes_v12_0_query_sched_status(struct amdgpu_mes *mes)
+static int mes_v12_0_query_sched_status(struct amdgpu_mes *mes, int pipe)
 {
 	union MESAPI__QUERY_MES_STATUS mes_status_pkt;
 
@@ -424,7 +430,7 @@ static int mes_v12_0_query_sched_status(struct amdgpu_mes *mes)
 	mes_status_pkt.header.opcode = MES_SCH_API_QUERY_SCHEDULER_STATUS;
 	mes_status_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 
-	return mes_v12_0_submit_pkt_and_poll_completion(mes,
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_status_pkt, sizeof(mes_status_pkt),
 			offsetof(union MESAPI__QUERY_MES_STATUS, api_status));
 }
@@ -486,11 +492,12 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 	}
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes,
+			AMDGPU_MES_SCHED_PIPE,
 			&misc_pkt, sizeof(misc_pkt),
 			offsetof(union MESAPI__MISC, api_status));
 }
 
-static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes)
+static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)
 {
 	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_1_pkt;
 
@@ -501,12 +508,12 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes)
 	mes_set_hw_res_1_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 	mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout = 100;
 
-	return mes_v12_0_submit_pkt_and_poll_completion(mes,
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_set_hw_res_1_pkt, sizeof(mes_set_hw_res_1_pkt),
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
 }
 
-static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes)
+static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 {
 	int i;
 	struct amdgpu_device *adev = mes->adev;
@@ -564,7 +571,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.enable_mes_event_int_logging = 0;
 	mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr = mes->event_log_gpu_addr;
 
-	return mes_v12_0_submit_pkt_and_poll_completion(mes,
+	return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
 			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
 			offsetof(union MESAPI_SET_HW_RESOURCES, api_status));
 }
@@ -1442,19 +1449,19 @@ static int mes_v12_0_hw_init(void *handle)
 	if (r)
 		goto failure;
 
-	r = mes_v12_0_set_hw_resources(&adev->mes);
+	r = mes_v12_0_set_hw_resources(&adev->mes, AMDGPU_MES_SCHED_PIPE);
 	if (r)
 		goto failure;
 
 	if (adev->enable_uni_mes)
-		mes_v12_0_set_hw_resources_1(&adev->mes);
+		mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE);
 
 	mes_v12_0_init_aggregated_doorbell(&adev->mes);
 
 	/* Enable the MES to handle doorbell ring on unmapped queue */
 	mes_v12_0_enable_unmapped_doorbell_handling(&adev->mes, true);
 
-	r = mes_v12_0_query_sched_status(&adev->mes);
+	r = mes_v12_0_query_sched_status(&adev->mes, AMDGPU_MES_SCHED_PIPE);
 	if (r) {
 		DRM_ERROR("MES is busy\n");
 		goto failure;
-- 
2.41.0

