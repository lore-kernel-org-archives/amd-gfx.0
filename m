Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAC5D2CE17
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:14:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 082FE10E68C;
	Wed, 10 Dec 2025 07:14:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XFoN19gx";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D78A10E68B
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWP/LvOe56VnGLR0FnWsrRYbKm0rH38rKyLqGYNavPfyR5nNO70mA7E0rhuKLptqdsqrjgoObVe+g6bcNuh0HAodXAe4DYGY3sNLA8NMs9JcRtJbb5TstydzyV5SM26SRhqh3ufvTbIQ6IucFXQTD1z+4l/Ktwy3E4hdXCsdxkPM9RN6qktTl63fVsUl9Gyp2CjivzQ+Bw8+Bqq6gfSxDA0JVb3ogTqDOt/wWKLMNrdsxDT043sYwsDC2+6XEJXeUqZByu0tUbHXl13ZmvkWFl8LaM7luv5uoe8Yt2qTvCYvJtNGipfKsN/d7iX+tITiy35jWLO1yjjC1f6u24i6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dVvQbAsjOpiPuFyc6no/EWuap6vzkRXMl5XxtwLpVQ=;
 b=mo9spQRpEOgdkAYd3LMD0cTy6wROBgcdM563hMvDkuCWI0Sl5quW8SxvIFt5u4oA7OnJ7HJtX/ejHD3A3snx4M6flY0hIEWiJ4sxC6aFXcmopd0swHbrB8AVIp3/GUUYiQ5ZpD9fOUc9XKLTIF4yThiM6O2bmqZ74jeuNXvEv2w2T9+LzFDOZgyhSOZwntMadhaXul9hF6tLBG6d3246sXnb/3K3bsyrFxmfGTESuQJsgCvP6pMeRR2Ied0ArquN+VPi8rtmyufXk/9lhVA1onEFYIBeOJ6PmHJHjeRyFs/lXMjEBp5i6NsHh5rIcZ3ukFUrf4mM6EF6c//PHnIPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dVvQbAsjOpiPuFyc6no/EWuap6vzkRXMl5XxtwLpVQ=;
 b=XFoN19gxbmkxZmoYv+5IJJk3SdvJ5OQq7frSvY3yq2Z8AF8XI2lsvR6cpG9U2nYN0Jkukt9MDOmWpi5c+9gsEqwb/8/MB+3e9HmuXIwLm1dfoFSfLcoTaQR1V7Ar+Qvw+I7q2CQIEQmCJBisn7b3l8fXQ5N/K2QG8T9Bw180P9U=
Received: from SA9PR13CA0049.namprd13.prod.outlook.com (2603:10b6:806:22::24)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 07:14:39 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::48) by SA9PR13CA0049.outlook.office365.com
 (2603:10b6:806:22::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Wed,
 10 Dec 2025 07:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:39 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Likun Gao <Likun.Gao@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/mes_v12_1: fix mes access xcd register
Date: Wed, 10 Dec 2025 02:14:10 -0500
Message-ID: <20251210071415.19983-16-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d044ebf-bae8-465f-db1e-08de37bbc87c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JY46Vfw9NyNVAvKeu0WSzHCKqqrLW4g600VYczdhUSX2dbABiE5WpR6NiYfl?=
 =?us-ascii?Q?y2tJeSE43mTPEM3VicFZfpnoG6bZ5NXD/tRV+usyvF+sumMUkMq1lzE5Jqjj?=
 =?us-ascii?Q?EOoPpEJxtHDqzicWWl+hXRABJIj3SFeQuUarXzk1QXYfhHxCiEQTNJnhwyRT?=
 =?us-ascii?Q?lR+/GJoqCyju/LJSzSIxwiiO5jqxc7/8QS8chDqLBvScojp6Z2sbx6vovOYh?=
 =?us-ascii?Q?GFBBztI3KsBdyyXzA4TVSUNiyouQ734JFQZ7S0FCcdmg9XyHpa0tvWvBEgd1?=
 =?us-ascii?Q?ovwx38LVfSZdT11u1wqzFvvXSGQLAa9tpA11zf4fbsovDYP7wT5PTlqRCBBm?=
 =?us-ascii?Q?8VCuTR8NUIGuEa9QIk2ZTJdhF6Dpedt8FZ0I4Crpwyigf8BXmklG9KcGPXbT?=
 =?us-ascii?Q?4ejZALb5uWJ5kQ4j7reaio+CAuh9KCX17MuX6FuLjLdczOz+nXmUB7OGCGMM?=
 =?us-ascii?Q?SWX1Oe4LCoQZfydWgyxifAWU7/JsarXEnLarCVNVoeLLiwm1cKT+A+ldOwSD?=
 =?us-ascii?Q?jkAtpPVGbwSAGMX8DymCV0NQdDRXs52I4XZkExYErzVPhm0T7SIEKMDdb2pX?=
 =?us-ascii?Q?ueHc0tyXYEee4NlvsBPqzS3j1axtPMmvQqPxGnq4oEZYXyhBbE4KTcdMfljp?=
 =?us-ascii?Q?pL4mqtqiYYWomeDe9zaQNJqd3e9sGJ2xJME3vi4SX5zqjmc7TuoGFSq4ZQcP?=
 =?us-ascii?Q?zofIdP8B4NpwOr+YTrxCzeoMSE8B1v1yt/sBH7wMGgY3bKL02NVziU8gpiAU?=
 =?us-ascii?Q?ISsnm51T5IP6d+TcSvbMy4yhxif3uFU3flxo1hpVO0pQmrML0ePmsie2tTLb?=
 =?us-ascii?Q?OS20Igp/rjCGFlkpu/JaL2zyoBDF2uITtlENO2MdzNsAEyLfAHhsnZAqQ0s1?=
 =?us-ascii?Q?wsxymvR70q8Ki1+FpJ4N2ben6zj8rsX5br2WaV1mQNZiLKcNDVNfX7Qbud9p?=
 =?us-ascii?Q?KyCCs1j3Nffd8YAyixQUoghjfNyHpSUOR2gyd5WIlSXOazrbxwMayFn9L0gO?=
 =?us-ascii?Q?/K07AS6+FBzg/WCQ02EQHKE2doitUgcibi23TTzEdXWbEITm9q9ZqnuBsCst?=
 =?us-ascii?Q?8+DY4Zk27GKqjSKZ5nFXacoXnn8/8rNuMM/8ECGhuYha7OvqTiWyZULjYeWF?=
 =?us-ascii?Q?u5lVkVB+0DTvOiiEl/zvIVik7/8JqN+GYaFFFkLZIrd+b93RyHj1RpCwpZcc?=
 =?us-ascii?Q?bpy4NtBAmoYMbNkqhJtHnoz2d1WDLhwG86g5ByX+sraDpd+O0ZjCNILzyKZn?=
 =?us-ascii?Q?XwaSGL4paB+zD3mr8YialX7lMy38h+2CZwqdv4uEsq7ZUalgsrGeQlutU7aC?=
 =?us-ascii?Q?hYP8T2+r2i2gdvyMTxUoztID4KV9CjqSGweVLmqWBQo30RdCpjRNK+XwVGpG?=
 =?us-ascii?Q?ffvFT6iOrfc9wICNPZS2tWuEUpUhnuICDdW8/QoKzNynAAtQJ6GMcj/k7SY4?=
 =?us-ascii?Q?9/YJ+AIBplyU0JO2ynSyu/wuYvcCgu9dXFIxApiQvPOGy56y1Lv8XhX8m2iX?=
 =?us-ascii?Q?ZRgiPWhq7mmzzt59LuxESklSFrRJIcYZw5bwDQcq2fr35YfHK2o452xqiJkU?=
 =?us-ascii?Q?KvfdKqAgizx6mkp/WMA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:39.4589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d044ebf-bae8-465f-db1e-08de37bbc87c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039
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

From: Jack Xiao <Jack.Xiao@amd.com>

Fix to use local register offset inside die for mes fw accessing
local/remote xcd register.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 6a454d5eb1a3b..b0b1df5f1d4b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -546,6 +546,10 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 		mes_v12_1_get_rrmt(input->read_reg.reg_offset,
 				   GET_INST(GC, input->xcc_id),
 				   &misc_pkt.read_reg.rrmt_opt);
+		if (misc_pkt.read_reg.rrmt_opt.mode != MES_RRMT_MODE_REMOTE_MID) {
+			misc_pkt.read_reg.reg_offset =
+				NORMALIZE_XCC_REG_OFFSET(misc_pkt.read_reg.reg_offset);
+		}
 		break;
 	case MES_MISC_OP_WRITE_REG:
 		misc_pkt.opcode = MESAPI_MISC__WRITE_REG;
@@ -554,6 +558,10 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 		mes_v12_1_get_rrmt(input->write_reg.reg_offset,
 				   GET_INST(GC, input->xcc_id),
 				   &misc_pkt.write_reg.rrmt_opt);
+		if (misc_pkt.write_reg.rrmt_opt.mode != MES_RRMT_MODE_REMOTE_MID) {
+			misc_pkt.write_reg.reg_offset =
+				NORMALIZE_XCC_REG_OFFSET(misc_pkt.write_reg.reg_offset);
+		}
 		break;
 	case MES_MISC_OP_WRM_REG_WAIT:
 		misc_pkt.opcode = MESAPI_MISC__WAIT_REG_MEM;
@@ -565,6 +573,10 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 		mes_v12_1_get_rrmt(input->wrm_reg.reg0,
 				   GET_INST(GC, input->xcc_id),
 				   &misc_pkt.wait_reg_mem.rrmt_opt1);
+		if (misc_pkt.wait_reg_mem.rrmt_opt1.mode != MES_RRMT_MODE_REMOTE_MID) {
+			misc_pkt.wait_reg_mem.reg_offset1 =
+				NORMALIZE_XCC_REG_OFFSET(misc_pkt.wait_reg_mem.reg_offset1);
+		}
 		break;
 	case MES_MISC_OP_WRM_REG_WR_WAIT:
 		misc_pkt.opcode = MESAPI_MISC__WAIT_REG_MEM;
@@ -579,6 +591,14 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 		mes_v12_1_get_rrmt(input->wrm_reg.reg1,
 				   GET_INST(GC, input->xcc_id),
 				   &misc_pkt.wait_reg_mem.rrmt_opt2);
+		if (misc_pkt.wait_reg_mem.rrmt_opt1.mode != MES_RRMT_MODE_REMOTE_MID) {
+			misc_pkt.wait_reg_mem.reg_offset1 =
+				NORMALIZE_XCC_REG_OFFSET(misc_pkt.wait_reg_mem.reg_offset1);
+		}
+		if (misc_pkt.wait_reg_mem.rrmt_opt2.mode != MES_RRMT_MODE_REMOTE_MID) {
+			misc_pkt.wait_reg_mem.reg_offset2 =
+				NORMALIZE_XCC_REG_OFFSET(misc_pkt.wait_reg_mem.reg_offset2);
+		}
 		break;
 	case MES_MISC_OP_SET_SHADER_DEBUGGER:
 		pipe = AMDGPU_MES_SCHED_PIPE;
-- 
2.52.0

