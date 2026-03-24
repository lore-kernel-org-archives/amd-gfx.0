Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C96F532E9
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 07:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF63310E5F7;
	Tue, 24 Mar 2026 07:38:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DJy0pfTP";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33B9810E5F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 07:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmCB9vaJW6s42eREomMgurI2EoQSIgON6UDElTtt2KxbS/2fBfmhflZxxk6trzzaXlj6i6Ew4+rzJPuIrIqERzn7O/rTybeiBGbUToYbcV/w21Euph6Tf0C2FeCELntu96D0EBX68yuQYiDR5FZs3pZdGiRERxeB7QP1lAbzxsZWusQZ+FhaK9XU155BJeVuydN2FJROSqIbGBNZXws4Ym5Kjd/k9pJtCoEsZ26v0goWEmBI81JoPsDIh3jpD7OsDmy7ZxRIJao5q7pG+rXSBWYXiQLeQucB46xCQvhPx2+zRYVF5xn3tQ89DzACHQPTrMX/6z/TsD5tjsldRvDoYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoO0GSE8GZzSJZN/yv7KIAMJvwidKW1Sd8UpP5VZMt0=;
 b=B3TvqVAog2g9yhpHzxFvuG7M500MKQlJpxVKdWjd6FKTtLIw0DUlE5azNk1PnGQgSpaoLu3ochPCi1cia/z2H8Q+JmNhUo5sNPAw/UnADdRmwSe6d2Oo01nHbhrwTEBYUysPF8XvVKWdwoPy9Z6bOVGC2byTnIBtWqV0zhx4mGKoq9ek+ZzBUyfOOxi4SWh37MAz2Or6Gfnl2FdiInd55o8xdPgbH/5um8y8+A246tZEaAeB66J75hxyRZNAV2tH78R59WwRWpcOJHdn0gTx2QSVk6yx9fJSAxDfWMOSXNE4lk8JGOPSZiFiyFhT21NfvX+u4zmSUNcMRYv44hJedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoO0GSE8GZzSJZN/yv7KIAMJvwidKW1Sd8UpP5VZMt0=;
 b=DJy0pfTPD48qsQ+yCbTEqKGIo/TZMgmwJwpWwmSUqpEZM1foeie7IvZJh+/cXSf+R+br6mTvofoYJyHRbHjRNEsyh665GBlniq14A4fCSkqNj3ce7gDBEIaQjFqMGwX0IocDsTL9X36sTSirmyu5X7PIKo5gs2Zb54cUfjcRYUE=
Received: from BYAPR07CA0061.namprd07.prod.outlook.com (2603:10b6:a03:60::38)
 by DSVPR12MB999192.namprd12.prod.outlook.com (2603:10b6:8:496::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 07:38:34 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::eb) by BYAPR07CA0061.outlook.office365.com
 (2603:10b6:a03:60::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 07:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 07:38:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 24 Mar
 2026 02:38:31 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Mar
 2026 02:38:31 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 24 Mar 2026 02:38:24 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: flush coredump work before HW teardown
Date: Tue, 24 Mar 2026 15:37:37 +0800
Message-ID: <20260324073817.662295-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260324073817.662295-1-Jesse.Zhang@amd.com>
References: <20260324073817.662295-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DSVPR12MB999192:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2cd2a1-0b89-4f63-49ff-08de89785a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: mNlRe8C0d1zStsAybeCbZAwjXJsa2YLFV9mk1GhosOaIDQJgeV3ACfrRYLEOhfbPhdBB3+7SCWGA+Ams66o1azhJNS3MFeLeP3m+/X47Hmxwjj3o9i0StbPCBl5CmuC8equ2lM2ZU2s86wVgq/yuvC4Pw+VJ/ec9g2tlmoUj3fTLcW0SyFO93CEb/L7zU6RE6pg5DgHJbkFc4sjiBF6v2uKwsDUA7H6SSWcbgeuiikYEmNLSEZpLL6q/5Rr+FiJQcPlMzLJLFk6SXxR39hwcIuK5f8THHBEreoHpVHtvIEc1SX2R3LyRyjNEm7qKkiDbinD2QqR2/WH51ICH/XUP3QKztTLP+tEYv8uQiERglUb/gWzhXvQy8na5KKx18KSBJCRoDD41pXMbLQ8p0W1nyOtokB5tyN3d13kdlXsuusMuzExxpEiktqBI1VE0xwCOUaAo2j8ORDuUS1FzpEpkjQF+VDYSrGZXRrZpitIi8KGu5EkzCL2KO/s+M5qHQRVBii3ykf7WDDkRd0qAZMIa+oqK270rDGNXwlysnILPD9hL/9dWB3ZgiIFUdNfzBFJ7OUHb2XPtScAs6cYC2QpTOltzN6qrV41WddyVV+GQkUpskjQN4gQd7n2Z+lsuOIqtQc4uD2SLo3DP4S1bOcPFrs4RU1bW8NuYbNTOwKa+3vso+4tdQ6iQoYUxhfq2CRKLHuX+NEy60wMxUcaXzXbxA6AFtLzTIAv+YUauvE8Zbn1W6ysXOB574Z4Iygob1PojelJCIDZP3PM7WUSUFi9AQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kiE2Pq1DIdCrhF6oFfz4gYjo2pwvofWJf31owrILUK4/Kry5piXmKLcIdhVyEWYSgOT+PGNC/B/PDtYpddS1U9kijY6/weAO07U63lseg5wsyrHk28AB+2dGGYDxccREnGhEuDPc24BsgDyKdHB2QlpSkg4oKYAu/9mzvUnFnHuWhd/H75PlrhO+fmbPqS+5Npcy1txFL/x4vB9/h9ZjmHDp6WaCG/K23a88ul4xgagN9Xm1P1Bib6rbcJFSNM7rxvPzUzncY7ZrhBWO1Tz6mroXGQYAHWaGie04rG9qi9X7Q9EuVBJzC7Q+F1BTwk19dd8EnRTeCfmAzCZgU5p4ZvwtgCkU39italWI0WKLJvsv9PYBPLmHjwhuP6mVcno+1tGWEw/oq+2UPU9GbnbJXuelLQSASpdU9K5ArKujGNEhgvY1MrXzvfQarZKeQUea
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 07:38:33.1424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2cd2a1-0b89-4f63-49ff-08de89785a08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999192
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

In amdgpu_device_fini_hw(), deferred coredump formatting work may still
be pending when hardware and IP components are being torn down. Since
the work may access device registers and memory that will be freed or
powered off, it must be completed before proceeding.

Add a flush_work() call for adev->coredump_work, guarded by
CONFIG_DEV_COREDUMP, to ensure any pending coredump work finishes
before the device enters the early IP fini stage.

This avoids potential use-after-free or accessing hardware resources
that are no longer available.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fbe553c38583..2a7c5a233673 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4225,6 +4225,11 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	if (pci_dev_is_disconnected(adev->pdev))
 		amdgpu_amdkfd_device_fini_sw(adev);
 
+#ifdef CONFIG_DEV_COREDUMP
+	/* Finish deferred coredump formatting before HW/IP teardown. */
+	flush_work(&adev->coredump_work);
+#endif
+
 	amdgpu_device_ip_fini_early(adev);
 
 	amdgpu_irq_fini_hw(adev);
-- 
2.49.0

