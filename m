Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70578C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 06:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E24A10E129;
	Thu,  6 Mar 2025 06:03:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4BYvOHR0";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C486E10E129
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 06:03:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCNEuAJgJZJGJcLMLcnkxL2uwch2vteOw+Q2UlqM/J7AITzpdQX6a0s+z61UcMqVO0f+lkaj305JvNaNGRv7ayR3Q5pJ8uLwKOZgQ6IGUPi95GG71FXe/nrtG4w2J61HFcu4d0hKkdbyg53Dx5A9Zq7CVBCKNJCcoKMrZ/Zs5tz1bEilmulFcD9E4yyZyvJjEA6GySI9dqnNkTG9XBVIRITnromLPQaghaS3n/H7OCxQ0woBI/uo9GIm9Nb8bUdits9czEPZY6KcXWU08AMiz9SAqzYsuy8n7+edeTmQr+FoXk/7l8p2vWa/1XqKpcUaftMwLSuM6VO8II7ZQBydGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ny4wGhaUMbzGFGyzaZalUOj41RmM0faGsxnDQ0upFfI=;
 b=rZ0k0h6s+rDIRHU/BwoisR9qbr3fQXQKQMlR1doJLb1HIBGPapv9uvRFpcm2VDvwz0rmu51L0xUyiHZOIGt5qBZu5qCS3X8SISarG/PBzDjZLYgwtlphw2ShpacHAGXYJ5O+Nw4QpCWkK1Pqu614/mYrloZGCm5bOfqGY9nIdYWd+qO2kDNzksl2LwkgPu0MEyTU2gwFXynw11TAjIy0W77A+uYkr5SuF76EixYZ5xLX+u6SgJpWiepXNyvzE/hDQ2AUPAHwKLfQ4fsMgGkGyxrBYI5jGApxp/tJT7d22uuo/mtIvyz96yhtcp+XS2ePDh6v/6/PcH2Ur8jAmejcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny4wGhaUMbzGFGyzaZalUOj41RmM0faGsxnDQ0upFfI=;
 b=4BYvOHR0jNSs7JtB61a49bywEwP/gFCmYDJkEbo/8KqA0RNEPPcXHZc8Fbxt0SbGp9k+5X3XCKJn68PMns9QACqRYZeft48HBsJShq0KOoYlYv/SnAI82X3HuP1z8LAN6p3vQfTKflHlgGKjRzmJ724S//IQlJoSHsgl12Ovyf8=
Received: from CH0PR03CA0101.namprd03.prod.outlook.com (2603:10b6:610:cd::16)
 by DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 06:03:37 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::d3) by CH0PR03CA0101.outlook.office365.com
 (2603:10b6:610:cd::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 06:03:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 06:03:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 00:03:34 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 00:03:12 -0600
Received: from SYS-7048GR-TR.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 6 Mar 2025 00:03:11 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v4] drm/amdgpu: Fix the race condition for draining retry fault
Date: Thu, 6 Mar 2025 14:03:09 +0800
Message-ID: <20250306060309.3222693-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DS0PR12MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 21837d54-95ed-4a38-4a71-08dd5c74a2ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5fkvhBJgwtJhuv7AvPMx30eJtpCicY6HJG+zVYdZMsJ5xGD6XUyLOpppnfC4?=
 =?us-ascii?Q?FTyiibjz8RyeoW9yQmpKlxsFoaOdaqnCJpaNhMPROQWk0c1b6q8QrJ1qV0oy?=
 =?us-ascii?Q?tXUneX1deLfrlByljB0uLEInqzGXrSxg9/eKdVXPPZp4Y9WdjrzwS2zA0zu3?=
 =?us-ascii?Q?pZUespk0l4A39mVA4F1mKtifY4rmmmEr4lVsuZkXSV6ISiOW8IiQYnHDw1mK?=
 =?us-ascii?Q?D9MQaLmXOuG2rYEW1wUKXjjz9MKiY2npTTY9zj7/I6qpiSyzbZ0KOTkxTcHp?=
 =?us-ascii?Q?XGF40Cao+gSc60tRJMCBzWyep3MXH+HBsrtYJhzJ+9oRoqABO3RKg3FJxmr6?=
 =?us-ascii?Q?nTqCJOHkWgzSE7VGp1Xuemau/m5bF6uIsWZd+jU//gXNBFAKPi9fvKhWp1IY?=
 =?us-ascii?Q?BdgFA729tyy2stllmJ0nDBVq+z95zlkVagMaqz8SN+lsgzopfiJywb+mDw6m?=
 =?us-ascii?Q?UMfkA4LgSGGVg2qd0s0TU/VxSt+sumCLQHvCPMEdrViw792duktRYVhvpf8t?=
 =?us-ascii?Q?VrJnJeHuepAS6DXdRExjN9+LHx6xZeIrqVj3LguaseqNzg/fwivViaM+V0Is?=
 =?us-ascii?Q?VxYmW2FrzifQ/beKUeKLJV6QKYOfZS4z0aSH8pkdJasko202aaKLlnYJRsdg?=
 =?us-ascii?Q?0vTCdbJzBqw2RHnwiZCYGVB9tFFOKlxbbIgRJoMJuaNz9qGSMPaFtGr42U5j?=
 =?us-ascii?Q?+V3M6qsfQ1Kg6K3sxSwbAvG/1MLMembugUyZJpTEGwfC7Ic6VS8l40KBqL0x?=
 =?us-ascii?Q?ErA4J3BY5vsxL7dye5GzKfxwioMksv8ycWfFHpnhH50SF6HX6DuPiaN+hU7Q?=
 =?us-ascii?Q?iSfACvMfulZPr+60NGnh8wxhCuwtYMFxHeYRF8t7l8+bEnrCIQCsqD8WHfpb?=
 =?us-ascii?Q?xp8FyZM8X3b5q4JT9+to8j12OTF9p0zukTIZdl7AeZbJ8pzD3z24iqmIJtGi?=
 =?us-ascii?Q?Fp54Rj5mo47gMNlX6VnpdC/qGVjH4rpZeasCm8UirUvhnm2L8Raxx7fG1x+W?=
 =?us-ascii?Q?CXXrDlZueFuo5O/N9Yk7NYRQ2bBW2wRxLimB1ap4plaEVOU8FDVR7Avnh1uY?=
 =?us-ascii?Q?wl0n+Mkq59AJ6H79Pj4cJX3RmLKPl046SbtcCiEFEUJS2RpaboFfrw9IRDak?=
 =?us-ascii?Q?xSTqlIn+6vNGG7X8AlPqHQ/d9bar3T98T4YVWugFVgQTK3k1YmH/EUnSeOqO?=
 =?us-ascii?Q?pRZySmd8ikVymA2RY7eCAn1G6Tq3DZ7DhYNWxNzVNX83KHPwZucNy6hpP0nl?=
 =?us-ascii?Q?TZCIoie89PgFUWp+SIHvEM+139UL5jGv95eHNxa66f/a/f5HYGVCX9tMFjsG?=
 =?us-ascii?Q?tTM+6E87gBA39Wz83D+Y6UPGk18J20IAE0FApl0ts1AKM0uUtoq/HbC0ve2S?=
 =?us-ascii?Q?VB7AP4zt44MNArIh+POOprmbCJYmTQg5Kgqo/VLJysQQfyHiEqDWVbxy72E8?=
 =?us-ascii?Q?0H7pbN8r8dP0L19nSkqJVB+FAwAJQ+UebsuJjTAxz/IpSImtFNOoo3NB8zy2?=
 =?us-ascii?Q?+jZyZLEftdgiCxA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 06:03:37.3243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21837d54-95ed-4a38-4a71-08dd5c74a2ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392
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

Issue:
In the scenario where svm_range_restore_pages is called, but svm->checkpoint_ts
 has not been set and the retry fault has not been drained, svm_range_unmap_from_cpu
is triggered and calls svm_range_free. Meanwhile, svm_range_restore_pages
continues execution and reaches svm_range_from_addr. This results in
a "failed to find prange..." error, causing the page recovery to fail.

How to fix:
Move the timestamp check code under the protection of svm->lock.

v2:
Make sure all right locks are released before go out.

v3:
Directly goto out_unlock_svms, and return -EAGAIN.

v4:
Refine code.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 30 +++++++++++++++-------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d04725583f19..83ac14bf7a7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3008,19 +3008,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out;
 	}
 
-	/* check if this page fault time stamp is before svms->checkpoint_ts */
-	if (svms->checkpoint_ts[gpuidx] != 0) {
-		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
-			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
-			r = 0;
-			goto out;
-		} else
-			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
-			 * to zero to avoid following ts wrap around give wrong comparing
-			 */
-			svms->checkpoint_ts[gpuidx] = 0;
-	}
-
 	if (!p->xnack_enabled) {
 		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
 		r = -EFAULT;
@@ -3040,6 +3027,20 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mmap_read_lock(mm);
 retry_write_locked:
 	mutex_lock(&svms->lock);
+
+	/* check if this page fault time stamp is before svms->checkpoint_ts */
+	if (svms->checkpoint_ts[gpuidx] != 0) {
+		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
+			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
+			r = -EAGAIN;
+			goto out_unlock_svms;
+		} else
+			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
+			 * to zero to avoid following ts wrap around give wrong comparing
+			 */
+			svms->checkpoint_ts[gpuidx] = 0;
+	}
+
 	prange = svm_range_from_addr(svms, addr, NULL);
 	if (!prange) {
 		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
@@ -3165,7 +3166,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mutex_unlock(&svms->lock);
 	mmap_read_unlock(mm);
 
-	svm_range_count_fault(node, p, gpuidx);
+	if (r != -EAGAIN)
+		svm_range_count_fault(node, p, gpuidx);
 
 	mmput(mm);
 out:
-- 
2.34.1

