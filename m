Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7587D3B9A9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5614D10E683;
	Wed, 10 Dec 2025 07:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KL3hcmyk";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013065.outbound.protection.outlook.com
 [40.93.196.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F05510E684
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NasUSRiCRx3E4ISucs2zHIMmvY98FI7VMYWAYF8uPI1QurF/w+gPhxwCRvIJ8dJecAgxSrsx9OxGvyj4JFY/RgTGYuYx1q4uOW0ECZwNZAXX82yj8jO6LtKjCHKnp5pmhLaf/Qkkc6T4J6IFTeYr0W3I2C0DgDx1nE8n2dwJJNC6dyhYXUKO9dzQAd7D/ucJl5v3v++wsOP3hG1kLI+K/z7V6IX4JvPtfAir94lPFwjc1izQsNvAAi0g+2Wy6oMoYuRsEjZ2awcH3A7LyIGLNAhPlX31DTdh2UqN13TBYOkYROBtNUNEq2vswMN1oeoUmt91EPKwdP9Cidpc046KUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7M6O6aQ14N8pxm5N21XOnTY2Fo6y3VkoSutABE9Ym4=;
 b=EdX799LhRK4AKLbqh749ezkflC3E3bMUpJUMLKEI+scF8eac3b3F1Lfbo17NFJBqzYrAR03yzZPFfObkX5lzc/Bz8uf5oA1KFQvKGiac/KPxuReJEbPR2FOLiSUaDEDNEfjhsIE6UXcmMRfkLts9pzK6ajZhEOGJg4PfGW2sfe/l5dATDmgo9JBQuwzVAdjAMiQ8WGdTCS6MWo+zSn0LDT1kNejF242k3+C4IGyMRczCg0m/FPspqE1E2UupJyvJ+brjzhn6NtFkD4/yXJbvE3F5+/9mqVF9yM9ILEq2UoV+iuFyOvAyNqcppCqNO7mYRE3Wfk2hSXzKMSXBdUSawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7M6O6aQ14N8pxm5N21XOnTY2Fo6y3VkoSutABE9Ym4=;
 b=KL3hcmykwf4Rn8sNP46MbG6xthG0+Mhld8kE7BTAgBVJ6dKXNIXFCvd3XuDjd7R0EE8/MbRNCS3tWfBD+QhBwptORFNQ7YWTqB9mBanzaePT9cttXda9FlaaqJ+Mrvbrz+8OqZ1CtnDEMUcz5ZN3o8Za1pCGWhNijLoYXH0gADY=
Received: from SA9PR13CA0056.namprd13.prod.outlook.com (2603:10b6:806:22::31)
 by LV8PR12MB9618.namprd12.prod.outlook.com (2603:10b6:408:2a0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 07:14:36 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::d0) by SA9PR13CA0056.outlook.office365.com
 (2603:10b6:806:22::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.3 via Frontend Transport; Wed,
 10 Dec 2025 07:13:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:36 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:33 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: use physical xcc id to get rrmt
Date: Wed, 10 Dec 2025 02:14:06 -0500
Message-ID: <20251210071415.19983-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210071415.19983-1-alexander.deucher@amd.com>
References: <20251210071415.19983-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|LV8PR12MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a23e24-1a98-4f28-1002-08de37bbc683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ed5Rx8Epj9qK5NXeCCaTR2oUxH3EKNduasj9w+YfMd/H+fCW7wmewbboxhSH?=
 =?us-ascii?Q?yMfK86MFJrZ3Ki3n/LMqkoexHrmUb7R+db1naz0jJ6oYuD667+6nXdCKfodt?=
 =?us-ascii?Q?oLuPOG65eWz5lpR+j1qe0U+ZjHMl0X7HzCwtKgUN5C5AHWK2OjqBoTbAGGKs?=
 =?us-ascii?Q?QxvsTMzTf9ihhWunjqEOAp5M2NFJNpeb2J5/XJbi+J2kLTZMUL/fMOztP9rI?=
 =?us-ascii?Q?XXk+5IARoqMYSsAQIbAx/6alcrHFGprnswMkD4NzI8B5fDEY3othMhaD/dJS?=
 =?us-ascii?Q?DfEmYXd0nZpM8Zqzg8KAlIJ2FjQXZMX31EtzDSOffeuBwZArOGyVmq0P142I?=
 =?us-ascii?Q?rYFS6qpvhvf5WnPDczRs6oFhIwbY7ZzPd9QWx4uyu8Aa/fFXFMB+pfRyoC3C?=
 =?us-ascii?Q?JbtW+zojEPbfZwcifzJVmlfDE3fgoS4NyWLC1mUGd3o+HBilmUjS2xB55aZL?=
 =?us-ascii?Q?xyHLBHZLKTkfYq/ZbDbT0msJeT0HdjOfVlHhXUtZMmc4y/Y8P5EfyWbyD0fM?=
 =?us-ascii?Q?GbVZvX1XgIACuoKmxuHv35SmgPDeLDVBwFUtmKAvhC+xrmwhonmUGOk0fzxS?=
 =?us-ascii?Q?4hAh7ICW6jBET4C537Riw7QE64q0Z9zQ56UL5Kv2DpreszQeQaoxtDjRWtVG?=
 =?us-ascii?Q?By8EwyT7/kTK7Cz3jON+M89f6shaico4+NJFWMODrsSm7Km1HlGsod5j2uLc?=
 =?us-ascii?Q?xWiu4BYjIls+wtF2qlVnEhwa2XdSG153eM7TgsKsoaEqcMS7C22a8nmg5wMX?=
 =?us-ascii?Q?xobvhAVYMb30F5nPb/hEr1wRqUE2dYkLJO/hjL1KqsXSPrR71YatdLu7pEna?=
 =?us-ascii?Q?dSOtBPtwaA1r8n5Istj/a+bk+UUrU/6sSIlFd067nnVRO0hjF/6F/kJtfRdo?=
 =?us-ascii?Q?JR+8/KrBTQ1YnP3yXb7ym/ZyUjLKlSRLP/yg295X1YzSPzMFaf5rsHL+63F8?=
 =?us-ascii?Q?vTQEPh9BqhyEr5tlfWCTs84rduKKDUYUv7Tsl8PVJid+AtKQiT2dWqhU1gaU?=
 =?us-ascii?Q?LTF8Zb82NUBNpT3sb8x8TzDNfMufJD0PpdFFJxvuqFxO2RTEWDaWSzqoxt2K?=
 =?us-ascii?Q?54zSKvyKzXubcoX3GW5W4GWk4i8Q2du3l6qHRX0PM4hQsnfdMc1lEbPJjqBB?=
 =?us-ascii?Q?u5yNnpwmQbn1qL8U4i9Rc5KoFkCZ1kim2zULmRYHCTC4UKE00tUEVyirF1tR?=
 =?us-ascii?Q?dq0W6zvNro77MTla/pXDdBNeWXf7dlflTgndCIaC6sNW2CxZrfg7qlURDqDP?=
 =?us-ascii?Q?CWTfvqUP8BwUVxFO2s3AcYCrKZtf3Bg5jcADISqOG5dvYClrNdZkuJjzr1KR?=
 =?us-ascii?Q?lK73yJnZjH4CuUMvKt6MSlNUshwfT3MgBcLLF0AxSdE8md+IRb7qiTjR2tmc?=
 =?us-ascii?Q?gZ3QQBD7x3wPCUzgqY6vc5fvu8UaBtc80JCpXepgNid1mrhAXUhE/AnrY7mm?=
 =?us-ascii?Q?vlhnh3+SrbIZDZd66XIaJ7xvmAqfGKSWO4Xtn0IeSSveHTA0D8p0DT+cIDLR?=
 =?us-ascii?Q?wj82PRQ4cCWTK1X9D4vcoGCrYS1alUEJpA0Op7b0oq2d0RxNUPtuZVxhuNfN?=
 =?us-ascii?Q?HRCPViwAzJyiSBWRNEk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:36.1438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a23e24-1a98-4f28-1002-08de37bbc683
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9618
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

From: Likun Gao <Likun.Gao@amd.com>

Use physical xcc_id to get rrmt on misc_op for mes v12_1.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 913ce414ca9bc..6a454d5eb1a3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -523,6 +523,7 @@ static void mes_v12_1_get_rrmt(uint32_t reg, uint32_t xcc_id,
 static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 			     struct mes_misc_op_input *input)
 {
+	struct amdgpu_device *adev = mes->adev;
 	union MESAPI__MISC misc_pkt;
 	int pipe;
 
@@ -542,15 +543,17 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.opcode = MESAPI_MISC__READ_REG;
 		misc_pkt.read_reg.reg_offset = input->read_reg.reg_offset;
 		misc_pkt.read_reg.buffer_addr = input->read_reg.buffer_addr;
-		mes_v12_1_get_rrmt(input->read_reg.reg_offset, input->xcc_id,
-				     &misc_pkt.read_reg.rrmt_opt);
+		mes_v12_1_get_rrmt(input->read_reg.reg_offset,
+				   GET_INST(GC, input->xcc_id),
+				   &misc_pkt.read_reg.rrmt_opt);
 		break;
 	case MES_MISC_OP_WRITE_REG:
 		misc_pkt.opcode = MESAPI_MISC__WRITE_REG;
 		misc_pkt.write_reg.reg_offset = input->write_reg.reg_offset;
 		misc_pkt.write_reg.reg_value = input->write_reg.reg_value;
-		mes_v12_1_get_rrmt(input->write_reg.reg_offset, input->xcc_id,
-				     &misc_pkt.write_reg.rrmt_opt);
+		mes_v12_1_get_rrmt(input->write_reg.reg_offset,
+				   GET_INST(GC, input->xcc_id),
+				   &misc_pkt.write_reg.rrmt_opt);
 		break;
 	case MES_MISC_OP_WRM_REG_WAIT:
 		misc_pkt.opcode = MESAPI_MISC__WAIT_REG_MEM;
@@ -559,8 +562,9 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.wait_reg_mem.mask = input->wrm_reg.mask;
 		misc_pkt.wait_reg_mem.reg_offset1 = input->wrm_reg.reg0;
 		misc_pkt.wait_reg_mem.reg_offset2 = 0;
-		mes_v12_1_get_rrmt(input->wrm_reg.reg0, input->xcc_id,
-				     &misc_pkt.wait_reg_mem.rrmt_opt1);
+		mes_v12_1_get_rrmt(input->wrm_reg.reg0,
+				   GET_INST(GC, input->xcc_id),
+				   &misc_pkt.wait_reg_mem.rrmt_opt1);
 		break;
 	case MES_MISC_OP_WRM_REG_WR_WAIT:
 		misc_pkt.opcode = MESAPI_MISC__WAIT_REG_MEM;
@@ -569,10 +573,12 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.wait_reg_mem.mask = input->wrm_reg.mask;
 		misc_pkt.wait_reg_mem.reg_offset1 = input->wrm_reg.reg0;
 		misc_pkt.wait_reg_mem.reg_offset2 = input->wrm_reg.reg1;
-		mes_v12_1_get_rrmt(input->wrm_reg.reg0, input->xcc_id,
-				     &misc_pkt.wait_reg_mem.rrmt_opt1);
-		mes_v12_1_get_rrmt(input->wrm_reg.reg1, input->xcc_id,
-				     &misc_pkt.wait_reg_mem.rrmt_opt2);
+		mes_v12_1_get_rrmt(input->wrm_reg.reg0,
+				   GET_INST(GC, input->xcc_id),
+				   &misc_pkt.wait_reg_mem.rrmt_opt1);
+		mes_v12_1_get_rrmt(input->wrm_reg.reg1,
+				   GET_INST(GC, input->xcc_id),
+				   &misc_pkt.wait_reg_mem.rrmt_opt2);
 		break;
 	case MES_MISC_OP_SET_SHADER_DEBUGGER:
 		pipe = AMDGPU_MES_SCHED_PIPE;
-- 
2.52.0

