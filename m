Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E419C531C9
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 13:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D60510E04D;
	Fri, 24 Jul 2026 13:21:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GBjitVV5";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5900C10E04D
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 13:21:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0CrNHndVmt1Dm71UR16D8F/zUvnoRuL56J1aNdDnMAXb9/64it7sdJG/TVbJukXAlW6H2RiLNiD3A/3LzC0RJbAYR3S0w6Ec2SROKf0gdAg8c21F2H6ILjdozpG7IFTpp8pH1CJw799MwsESM/YqdpfM9FQnCG8QfvX8bmM+X0dVbDjPM1rzbSr+yD/fD155tWJ0ncwDxRvcKy9nh/M5gSzw8jvahFvaGJcsndYFKZx1q1iGJlN3OfRANgnBhOKAdQCq9lFjRA4HUtaw8283sm15MPba5qaDUL44M0b201VDBu4JyA21iw02UzxDqIE6Vl44AGGJOIkdSLza84ksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqWUo2FAcEa8U7x6fqnulwtVPlJrmhdgPal5qi2/tfg=;
 b=dweAOK2nIXOZ8BNFn16BXHy3YEVXlyZBpL2vqVSAGZWt68pXCYTPeur5Pc1z9jzFuK15EOEPJfy7dVFhzaT/DufDIKgcDj55RIa8Y3NBwoozwM9uYod62NVO1RNUQ7jIqOfC4KPaSyRLEGBGvuI7PIMhC2Cv2HjX/9JR8hmBjJ5F+Dqks66tTtxaEcZXc6bb9T4jg+Oz/j14v5JFD20DNzCVaGzZHaMJ4SDWfmkS0SIDvINQhJBIaR+bbpn910uEgm51upLGBpd4VgkATPbXef9jw3HaheTtI6dOOv3I03YMtCyKPHtynR7LUL4tdIQDoxd07WLsIok2QLvUoBbK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqWUo2FAcEa8U7x6fqnulwtVPlJrmhdgPal5qi2/tfg=;
 b=GBjitVV5/Jl1eQN9GAivORyTU1maLFBnoASiRzFB8B0zd5nxLgUgM64Iz5o8R6WtSZgXpcKn9n4fDZSFPf/txezGe3LbDvIKVGF0jmSk5Eqhg+zhCHz7ayNMCCYaduv1SrYIHwxbcj8cTbdKbYMxZO4PUR01oQXmSS0ygi+PCWE=
Received: from PH8PR02CA0046.namprd02.prod.outlook.com (2603:10b6:510:2da::20)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 13:21:16 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::4a) by PH8PR02CA0046.outlook.office365.com
 (2603:10b6:510:2da::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 13:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 13:21:15 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 08:21:14 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shuzhou.Liu@amd.com>, <Sunil.Khatri@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH] drm/amdgpu: Add trace events for pid register/deregister
Date: Fri, 24 Jul 2026 09:21:00 -0400
Message-ID: <20260724132100.1337346-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 056c6ba8-8611-4919-f52e-08dee986708c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 5COXtMpXAoPNTwqaDRrZGrfzj0PK181r0erKgEmiYrSx7Rtg3TxPwhp2Zb/Tnr3/EKyLiR5MGlmx5BpjQIJfjl/uh40ULzU8TKCFuqhdJORZ37JoAGpLyWUwFhQ6Br0fj3VqkSkDnRpfhwvFYiEohZcNX2UGzJrvcWm00AzBvMF+sR/ItZAe23p1QiUIRzVhkcZvT8r3n2F77aIJIyTbXdW54y6UqP2rllL7UBFYW7i+zf2uDnX/zJWhwtrfzZnRwjqTX5kScIyRxIZF+dMPnNO/OgXf8Z3Vl4AOy022Px8sk7t/VNJ4EZ1lwW7Ku18Jw+/4fSxo51Bw3ZZ/38cFcRJsx0xnXuaJg0dJe2aLd8GMgPTwHEGHV4EsL0OThbFPDGfC+1GsNRm11UsZAWBNwi9q5nqNg3HY77QXtl+AcygCpIAIkZhqO7QUloabjlWxyBPhTikT8+GGLm7KkpGMkxoI7Api6xSU1OPPOZUB/iyKYJnBdyG+6P95CmjkI4u4CUsy+lxV3/7xsij1pgsvytscI651t3ZyLkWepqz5fhqvlN9qB/xx3olWiDjHMchUNDNsr8G0hQj5IG7xFnIz0GAy3x3oarcNOACnThHbmad+3IhtWzNNQ07oIQvoK5hRpsmeeyP2OQMww4aUo7at6W/7NwI1OdvXIvCu+sD4Tx5Hb0a2XeHw1og8RP1RKGq4nW5y3EwEMXrCa5hGcWJjFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6SWbmZ5f/WFoPEQuBk91tdFFEklHsSD7sA4m+SyWBI4qlXYnq8A27pPvp3rnlgUDYuMw4xhuDsTBhOSj/PPJtnwP1BH5IQIp85AbAoP1+HANoyBR/X0sxCp4dBw7CriwJug1MfllUMjVAYA+DcSphTbmxAsfz9QJK7NGp+Uwfv9UVMFmYwztUSadQv4IdNNqlk3sIskf9TKT7QhLn5yDWudmz/rZVcJzCUT9ICtnw4VV2JbmFOxFkTvfi1EwvBZC+IghJ+t6EVkNbZc44O2RE46WbGJKN25AST2govlCK9o4MrCKEBd9Gyb5XC+ss2R1QoxmvoKjIA1c7oHM92UEmje+diBtkbJgXSwPtxBUf4GrdlfbODI+RaJ8/Hh0HmaQUWtuRBLx077XQcWc3UDhx7MXxVq2hiYFVNrUSKHg3XdP6J210gSKs3SWPJ6fi419
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 13:21:15.5728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 056c6ba8-8611-4919-f52e-08dee986708c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783
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

Some debugging applications need to track when a process starts
or stops using the amdgpu driver. For those processes, add ftrace
events that track when a amdgpu_vm task info is changed or destroyed.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  7 +++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 5324030a13f5..c79604b9dda1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -732,6 +732,23 @@ TRACE_EVENT(amdgpu_userq_state_changed,
 		      __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->to)
 );
 
+TRACE_EVENT(amdgpu_register_pid,
+	TP_PROTO(uint32_t pid),
+	TP_ARGS(pid),
+	TP_STRUCT__entry(__field(uint32_t, pid)),
+	TP_fast_assign(__entry->pid = pid;),
+	TP_printk("amdgpu register pid %d",
+		  __entry->pid)
+);
+TRACE_EVENT(amdgpu_deregister_pid,
+	TP_PROTO(uint32_t pid),
+	TP_ARGS(pid),
+	TP_STRUCT__entry(__field(uint32_t, pid)),
+	TP_fast_assign(__entry->pid = pid;),
+	TP_printk("amdgpu deregister pid %d",
+		  __entry->pid)
+);
+
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index aac8ace9d7a6..8d31a61e8c26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2457,6 +2457,9 @@ static void amdgpu_vm_destroy_task_info(struct kref *kref)
 {
 	struct amdgpu_task_info *ti = container_of(kref, struct amdgpu_task_info, refcount);
 
+	if (ti->task.pid)
+		trace_amdgpu_deregister_pid(ti->task.pid);
+
 	kfree(ti);
 }
 
@@ -2543,6 +2546,10 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
 	if (vm->task_info->task.pid == current->pid)
 		return;
 
+	if (vm->task_info->task.pid)
+		trace_amdgpu_deregister_pid(vm->task_info->task.pid);
+	trace_amdgpu_register_pid(current->pid);
+
 	vm->task_info->task.pid = current->pid;
 	get_task_comm(vm->task_info->task.comm, current);
 
-- 
2.34.1

