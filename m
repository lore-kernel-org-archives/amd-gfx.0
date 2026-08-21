Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA28C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984A110F35D;
	Fri, 21 Aug 2026 16:08:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k/bi8yeX";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010030.outbound.protection.outlook.com
 [52.101.193.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AFAB10F35D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKW1sqaiJ+KSP66Y9v2vGSImJkGlJQrUc5IEbZ7iJFnSJH3xSlx1qtVPPka6BucU7mEF4agJbQ9+PW+N3AjDDQfXe7qXq7mrc3xyRNc3MEwVvTABaBYZxhb5JZiqHf9RvqRSG+7/ES6xonQGD+u50JcGG2fC2ShXy3LvnJQvUHpvVa8EGY2tMWAIy2YtsW4UVNHPFyXgwRJmv+drPGE2HOYh1u6npGS+qnqg0i7899HfffrUyKjCl+yOTsz1YrHcg3OHuI6EJkc1AoFeQSU7QtzUeUFvvMjZ8t1psuY44rdY/gJ3W5LRbfbD6FmyMfU5HoVcCOWpXrCsdrqowRytBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvbymxaYZ+BwLZT/Or2g6qUeNVUMEjI1W7U0p/+kVvA=;
 b=XJXRaEfT3VZS5euj5BT1XiGRU6ndOx+PHQM7VJWpCqQmWfPrHbY7A5S5qDCPTEtyCaaoG3+Ga7Fo7FrvoTWv6kzYcogcc8tefhU3fpirnkj1bThp0tdl4SJeZfu/M2E+u4K3qvRLDoC4erDkdfGVyDbluKdKDJrHu/bqrTrazDOPzX0f/W3PVbpym7EAHDjJfZ+xhBE2vAs6evqV5N+MqcPe/po02s+DawRtElJqWirITgY2OJBJ5O8vPoSAgxvK6bHX36/PzUVNyYrmX/8nSgFb1r/k2FwVTA7LsFYkzcfSCMmPZ92CAKIpijfCqLZl7LY79ZGKsV6BMkSj5ZmHeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvbymxaYZ+BwLZT/Or2g6qUeNVUMEjI1W7U0p/+kVvA=;
 b=k/bi8yeXOD8n4Kw5dtVMdgl1Wjpb5fhm4yFrjsqSYli7eANvVq1nMIKoct0/Y6W4XK8L7vAMTLSiCHWsmeAeuw7iAL0vjbmE61yZU5lhbTs2S3L0h4pCeLcFo040Um79BN/408Y4lEl+P1XWF9HXtfqMv8UP3/WzDQsntUUHzS8=
Received: from SN7PR18CA0015.namprd18.prod.outlook.com (2603:10b6:806:f3::6)
 by CY8PR12MB7314.namprd12.prod.outlook.com (2603:10b6:930:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:08:37 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::73) by SN7PR18CA0015.outlook.office365.com
 (2603:10b6:806:f3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:08:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:08:33 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:08:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Fix MES wb status pointer overwriting
 adjacent wb slot
Date: Fri, 21 Aug 2026 12:08:20 -0400
Message-ID: <20260821160821.752678-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160821.752678-1-alexander.deucher@amd.com>
References: <20260821160821.752678-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|CY8PR12MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd890c2-8bbe-4e87-2fcb-08deff9e73ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MaWtolzuA7/hGhfAScuaJz6XLLA/jOde9Gz/N3CAfj61Bg4dpbNY7Pw/oDzQeSlXzQUCx94dSKv94nWCi/nsfJLwBr1ultnKG1/3uNGXbQHtke3OI9Xd6qx5MBVI8I9nS8SarOSB6rBt/Y9Jc0cujAdQxFP8IL2lyADnd4Zw2M/oEOoNmY+pg7d6qXxgulN3h9jq4Az9yS09P16auOmkh92UdgeDcfNEgddR20cQKnR3qfeBH1XhK24tt2GC4ipr67ibkKUnLudxnNXcvsyMdGTTdXz5OjBc9JwcJOa/FtgtEU7C0Kz1S8XhWOGBlNfEkhi3cumLyxYWN6Crk3sy+cLzTtTckCJJXwBt3fRWgMIq7UNt//jIrEkyu0yzEcUL5J7vYk09wzJdJrUjMRAiUQCjvyjdHpGreBObefyyg0BJrQsydDR5T77+Kov0/CyMDKwNAipts0H3ZPEUbDXr4c8/lP+Y6/xRftR+hLJAjP7JMBByFBEdjN0R6+RAKA8hQ2y+Hk5k3dR4hTN0w0JeB5aPgWYPbkaeUjpRbhCLgfC3huG8g3o+ZaHTPPyIqezGnno5nHQ/U+WD+u0oj9fh8CbEIUi99kjVFqH29pxFC/6CtR2optDG+tdCTy3EG0o9h6KL9fpWUfJGCp+buk++MFgy+A93wefKz7dggDYPM2shYYHGErr85c+LKxkT/TQloa1j3tUkVYpSa592mfAk9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YeaWr3ehDMCh5Sn7Aac9g+zseaBTLdltrncsJcfDMOuQCJNlQhMxZSw+k+F3458aX5iOg8W2KHEQkMJtyvr7Xk0Ox8d6pvPHXvRcWD+DGbJFcoW2ZvQzgk4PsjDR+uMyaN2PnoLYtgxVl3RYsKbxCRmT6BoD7wIJHXYyPV6jU98bPOaD77TBIvihmSpsEvM3bHBBcXcxSMxOw1IhKesRSmCDnsZEpCidICnGRHzZEFfPRAg1sWldUQ9fR9zufABrmw47P5EKG3MGJ8L6nN46q+W3HLaYFQMZvhV6F5TIZpuOE8zL7ATROGzMTjhPq1jrakpQc9S9jamlpSeeRc6/FH3ExvxYIjCPTEbFQ/U0dWLGOhQuYRQWI6ZpCF8pFAsmJ+xPnLYp3irblYanlFdQTudfgzojGPvuht3DmkXZaOcjceGijXlhBmckMDwANXxB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:08:34.5371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd890c2-8bbe-4e87-2fcb-08deff9e73ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7314
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

From: Philip Yang <Philip.Yang@amd.com>

status_ptr was declared as u64 * but the WB allocation is only one u32.
Writing through a u64 * pointer zeroed 8 bytes, corrupting the adjacent
WB slot. Fix by using u32 * to match the actual allocation size.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index ba3dd72c56fa7..8ff31c924bef2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -167,7 +167,7 @@ static int mes_v12_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	unsigned long flags;
 	u64 status_gpu_addr;
 	u32 seq, status_offset;
-	u64 *status_ptr;
+	u32 *status_ptr;
 	signed long r;
 	int ret;
 
@@ -186,7 +186,7 @@ static int mes_v12_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 		return ret;
 
 	status_gpu_addr = adev->wb.gpu_addr + (status_offset * 4);
-	status_ptr = (u64 *)&adev->wb.wb[status_offset];
+	status_ptr = &adev->wb.wb[status_offset];
 	*status_ptr = 0;
 
 	spin_lock_irqsave(ring_lock, flags);
@@ -235,7 +235,7 @@ static int mes_v12_1_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 			xcc_id, pipe, x_pkt->header.opcode);
 
 	r = amdgpu_fence_wait_polling(ring, seq, timeout);
-	if (r < 1 || !lower_32_bits(*status_ptr)) {
+	if (r < 1 || !*status_ptr) {
 		if (misc_op_str)
 			dev_err(adev->dev,
 				"MES(%d, %d) failed to respond to msg=%s (%s)\n",
-- 
2.55.0

