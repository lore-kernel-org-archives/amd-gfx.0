Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D68C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 06:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB0B10E25F;
	Wed, 26 Aug 2026 06:17:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k+Yg6MA3";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011049.outbound.protection.outlook.com
 [40.93.194.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58FD910E25F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 06:17:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuTPEQEtdpJ2UgPooq4kFlq+WDq4PI3/Xict+5ShRFin8QycsHA0ftY/35UcLs+LEbe3S/5Wnu+WQy5RyVWvLf5ee8Koj2a/7ZzG5EIeby4r+4XxNlu+gUa8XH0BEvi9lhHNEOf5zu8zTFAAcZ/J9XhYumpd5JEac8mL+YrOLDsxcx5NwIAt1GNfhsi9MeqnQgkbE2vATh1+J6zfz4TGzyn/wNabPGxz5dhxVJ3gnumtA2FqgDwuvWaMxlzrdVDvdcJltWmCDpOjdyYDZZlf1cL1j9KE4y0fAMamzQUf3XgB/HQzCpNhVvLAUhN2WEpAn3pv9psqEgAdNrjbGdhtkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDYjbZ/q8q8azCGJ4ZeUm9ddFsq35hBHa6xdAdNvGjo=;
 b=wWNAh/+0WWfhZcFfyUTW/bruQJmVpGgs1/ELl20jZGESnmvVAzTOzZjzo8BTvewgUWwra0hHZ7Q97Uy7T/TjZ8NY5ttDcc9Q/HCEyHExTWA0my8nh+iuFJ1ngqbFuaT9p5c+Z/mv2/SvRImLBjSapSBI25pn40S4scabiRVc2vg5iuy2VzWM+yuh3Srekdnn3mA+TGX78t/FZoUTXwFs5xbBc36JUCd5jcVaP7lQrlJHAQTsjw4mturqNpIlimyLeSCCoT/3RjdoRl2BtyuxLXkXt5Xtf2GS7OkNnVp1O8AlTjzf5LJOHkSVHhZ77sn4M4Xh44QV6GLmIosKLBojiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDYjbZ/q8q8azCGJ4ZeUm9ddFsq35hBHa6xdAdNvGjo=;
 b=k+Yg6MA3irbmDS3CP20Qobd7Lo+fZcv3pvc2qI9q62DhXm2VFh869XOP02mb/ZilVh8mBYIi0Bz8gOf9MpMt13qtl829CTWZoxJd7KTt8v5AkgLQjifuNdksDl+a/VMRZAka7GEWWSTg/qfjrETkQVjtVMenYBt0TSZFFLSdEFg=
Received: from BN9PR03CA0293.namprd03.prod.outlook.com (2603:10b6:408:f5::28)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Wed, 26 Aug
 2026 06:17:22 +0000
Received: from BN3PEPF00022BC1.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::12) by BN9PR03CA0293.outlook.office365.com
 (2603:10b6:408:f5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Wed, 26
 Aug 2026 06:17:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN3PEPF00022BC1.mail.protection.outlook.com (10.167.248.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 06:17:22 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 01:17:17 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: Print caller in amdgpu_userq_state_changed
 tracepoint
Date: Wed, 26 Aug 2026 14:17:08 +0800
Message-ID: <20260826061708.500576-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC1:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc8d74a-c46c-40d9-8cb8-08df0339b0bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|10067099003|56012099006|3023799007|6133799003|18002099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: QJdjtdoPtgh12ccHVd1qn5dtykOurbpUSL3VNO0H9tHLfJQWBgZj6PwtvSPUBqWufgIFtIycepDTsdv842xH1DVAb7Wqga4n74L39faXZTJoc0XgJkDdlezIFBKqwz63vG8mUFvMCMs8dfBVu1HBSQg8uxrRKQ0xcBlYjn5rTi3fEt57zJnPniYItd3mXQ9cCv6Klwhd5FHAtBIuvr5Tjrfnv23HNozCV4vxNIJ8+6CuqMtbisWcm0bQSMg8o36jAdh/L9FlQ3wFymfrgGfmimGtVDU9w1dS9MJCX4i5TK9N344RoJrSJvB3Gma0i0xs5waze5ftYsLMsNvgx76Hom2I9Dllvo75ceYizhlfmh8gmMgcgCaercAsrg1fyVblGaY7TeMtTvmDF3dvv3KDY/GchvzjCIgG82NH/6ipaQBziMq2RSN0JgaFlLNbSTTfZfDCUhU7e3CVcwyIvAmk/zDg19NRwILNqObyEKUC0Si7TyQou8o+Ba28t8fpGh9hCQLHc4ZlgqYI1xmUlQx9qplm9Bl1qfsJBvtnAKXzLFdG6yZWR/0NX/cdFHSBs8xb/gjOvKpIxFvq+VQXoE+bBWb7chMFwwuc3mjS5+wK/jsfJNZWX37NmvNdgajAtfHEWtiWQjgHyO6KoXD0c68oyFnfXdyv91AAa9LiTv+Yx5LvoB4O+LZkeS1r0Pjg+A1q737FAlT1EWPLJVipVeRhRA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LRpaHu50m/XsDY4diEFyYHdfDBbKvJoDsCJplGMOykdn5XSuwLyOqL61rXT2RN+XIqrF1XJFLbyooN6vi2yUOcztbMtlIEqy0Nakn7f3KA7mB9tRLDwcDs04Ji1OzdL4QNxoBYHdf5eKBKgXe17L/AIIiGDqVY5E8L8Z87NpiAFhVbF/BoobtOrAxxvioPt6bJY15iF1HhzKWXqardtK84KOw8CrKKW9hULjDKuLUq87pbd/VI7FkpGDzsAGTu8TfuAQO35i/jiRBG14fWjm4BdJKO76wQ0eaTP/dLxTtwBAJ6dZwRnlTGJBJ6oO5l43lyl8BE9cJi+xPJsaYz5vk2tms3jI5JiJfjtbeC6MELcs8NyfQLFpu7XFQ/o1ups/w9SwlIQ5N6otrJiFVyMxFS7hQ0R0QKra7U6oU9vLRxsvv7BHpnb8uaxgxr+CY0kQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 06:17:22.1266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc8d74a-c46c-40d9-8cb8-08df0339b0bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
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

Since `amdgpu_userq_state_changed()` is invoked across multiple state
transition paths in the userq lifecycle (e.g., creation, eviction, restore,
and destroy), logging the caller makes it significantly easier to trace
the exact call sequence when debugging ftrace outputs.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 5324030a13f5..569e1e38704c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -721,15 +721,18 @@ TRACE_EVENT(amdgpu_userq_state_changed,
 			     __field(u64, client_id)
 			     __field(u32, queue_type)
 			     __field(u32, to)
+			     __field(void *, caller)
 			     ),
 	    TP_fast_assign(
 			   __entry->doorbell_index = queue->doorbell_index;
 			   __entry->queue_type = queue->queue_type;
 			   __entry->client_id = queue->userq_mgr->file->client_id;
 			   __entry->to = new_state;
+			   __entry->caller = (void *)_RET_IP_;
 			   ),
-	    TP_printk("client_id=%llu, type=%u, doorbell=%llu, to=%d",
-		      __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->to)
+	    TP_printk("client_id=%llu, type=%u, doorbell=%llu, to=%d caller:%pS",
+		      __entry->client_id, __entry->queue_type, __entry->doorbell_index,
+		      __entry->to, __entry->caller)
 );
 
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
-- 
2.34.1

