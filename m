Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB3C606A319
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=E43I5nqA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF97210EAEF;
	Mon, 19 Oct 2026 20:08:06 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010008.outbound.protection.outlook.com
 [52.101.193.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C5AD10EAEA
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 20:08:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jm136b5lQEWhwZ5nO+IYL3Zta6YPM7ojs80TuW6fP1F0B8JCerPkMQNBOKFJs1HO2Ewt4XHLVmBJc+XRLkrXkOw+l2XlM6DZjRmz9aswn0S3ftR0op1LItYrUjNT7AElr9jfl/bwyOE2TskGzBYKcz7LhuerfjZOuwpmGMTJdWTbiD4tt14UsEPst8hU5rDPE3TS28xtcVE7fIMtmK275bNOnKjJltLZIIQ+Hx+7vgGBGEonPossLcs4x6142e5LqKc49BMLERYrT7getUX6SXttYaCHzydRSwoJxD8F48eLdtnHrGBYOLzhhZ6FJuPfdlBtP6YLW3ImzxapUOPQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhTdNINP+5ZVzOp3zwf4zI5074WfrSOkocNonVu1QnI=;
 b=YdajxKVnhA0wbBMa4dUzDJu5qjXwM1IMnNJGM69D9huG5YKjJ78TKzTMrTmInbvw4a7idDqCLMnnygTYrTL+cz18FlccgLYfa3ikBg7LpD+WxT1H9VuhS/Mvu7nyz9Qi/hGuwcGThZ/1DJtsqITcVd4M4s/EyVkOhm4z5gVrI8mpYF6eFgIzzz6okm9GEQPIZSDD++kFfG9h+WfRvLij1ZXoNh3xmx7lWn2LQgFQ0h61YFw0brKCAgN2uzclJPFWNQQlC6+5HcZ5YhRfKLGfB5T8PSpwdh+N6S2h94xoh3D62wl/mi/uW2kxoKVuTzOmleEJ9ZF4MDanG3KMJkaRRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhTdNINP+5ZVzOp3zwf4zI5074WfrSOkocNonVu1QnI=;
 b=E43I5nqAtT4rTOlhHji4yAyFDhAFCiJnSYaQfsJzCnaZwno8XOOSGG7QhCq5oSRrZfS+6JbhGt6dEJvsRK7UGmREg1AHrRLd42EytYTH2tX6R9x4pDQBaJkFZyjNbU4fkf89Fjv3//pkar0f++VzxApwbFzHYSWErFO0xABHmZQ=
Received: from CH0PR04CA0106.namprd04.prod.outlook.com (2603:10b6:610:75::21)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 20:07:54 +0000
Received: from CH01EPF000BE941.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::4c) by CH0PR04CA0106.outlook.office365.com
 (2603:10b6:610:75::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 20:07:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH01EPF000BE941.mail.protection.outlook.com (10.167.244.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 20:07:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 15:07:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 15:07:51 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 15:07:51 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "David
 Rosca" <david.rosca@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>, "Benjamin
 Cheng" <benjamin.cheng@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/jpeg_v4_0_3: set only IB_RD_VMID to 0
Date: Mon, 19 Oct 2026 16:07:25 -0400
Message-ID: <20261019200726.15262-3-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019200726.15262-1-benjamin.cheng@amd.com>
References: <20261019200726.15262-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE941:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 047baf4d-4bc4-4aa8-6477-08df2e1ca8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|6133799003|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: oXZZF+fAzONIlBwHCS8P1IRrK9/bTQk+TczV9c0ohP9C8KKQb05diZHw3476PDIN7CdwMgLFgA4BIjtHLrxG7nKTzIfF71mG9CdSVPHQCzPZGVIPhQDN804G8h3rkuSq3bkTKoQXLsL1fjvwT5RT/bi+Omqyy3WfXOUiCaCkQZFCCI39GsCJG2JbZmOReLSJMGF4pSD9b1mPUFHh72kGly4Q6O4h4+qZfreFfxpPP6f0LDbFwp/NQHKG5P/hJpFk1+1tru7ZVvL9IotQp4iw3s6Fd3Uash5MZYhI/T/e7nkcZX3ur2GzW0SV30MelgZmll6eIh5iGKoTb2cmsoPXYlpsUvXv8kJ5w68gZYzG8T6h21JqiEOlZyAjh2EOvU/oMQs9CEMA62cVXZJ+8uJWB0Vq3aUi+mwsCb2OWsH8+lryHzWn3A9RxKBgmmN0hToQGq6vg4aitG6GAhusbSD+/V+r4Ed/aPz5UTmeJmNuA9k5+CZYhHtlVS4WwFzjMvmU/Rk9IxB2W58yrnDIB6WLM4jKwOfpXYJ1MSftdkie6lGpOBuY1LL2Pp9KbXFQt4Q20jY+I4sMbagMUEnWT7BE7ArZdXxo3R2t8wK2kgz1W+szd/nQecd1mg/7+2XR6cDt7nbyH7H8Q3wno8MZhUsqaMT5h22veFOWvZzczVAZjdVZOnPXJwAfbDSaNY/X5o0I2NN7JG4lSTCzOI2ryilE4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /MGOP3/x7ebqMWJu9Sq/nkEsjQ9g467olWSN4RRw6w4SiJU6rKeRDcdMtaBmIfwrm0fBNA8QY7XAE4OIHG+bV9jv+2i5EL2yg6P9jQgnXSFN9PtGXaUA7rYHSLC5z04Wm3kirTt+ggNzzdy6KXUu+n1YTlqXhK3FTn/9acW1ww0zqjY5/OtksHbbiptfVrOVMFcwgjaYTj05mHZc9DKfIk3CJvi4/L7UUWi/w1BbPrefYuf7jOIqtubh3jMVMpIfwyMlZI36l928NQGXh6m6IQhDtMdAfkTVxruZEXh+gtaSa1eFOaCoFgXNqsWEABRAj4XCaTskRNr1VCqV7T1UeYwec0+Ed8szrRd6fgzE6mJkPhHB+X1IER2KghnJEnwKlhD+/f3Jx/Ptw7xATcVWA9UyIPn5XpLvsOQfnUymOqcCgskwv2I+tdmiXbJmaSU8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 20:07:53.2384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 047baf4d-4bc4-4aa8-6477-08df2e1ca8a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE941.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If IB parsing is done by kernel, the IB will need to be read from VMID 0.
However, memory read/write operations from within the IB should stay in
the job's VMID. This will allow us to enable packet type 4.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 0343a64595f2..0c25ee443fa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -892,18 +892,15 @@ void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
 				uint32_t flags)
 {
 	unsigned int vmid = AMDGPU_JOB_GET_VMID(job);
+	uint32_t reg;
 
+	reg = (vmid << UVD_JMI0_UVD_LMI_JRBC_IB_VMID__IB_WR_VMID_MASK) |
+	      (vmid << UVD_JMI0_UVD_LMI_JRBC_IB_VMID__MEM_RD_VMID__SHIFT);
+	if (!ring->funcs->parse_cs)
+		reg |= (vmid << UVD_JMI0_UVD_LMI_JRBC_IB_VMID__IB_RD_VMID__SHIFT);
 	amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-
-	if (ring->funcs->parse_cs)
-		amdgpu_ring_write(ring, 0);
-	else
-		amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
-
-	amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JPEG_VMID_INTERNAL_OFFSET,
-		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
+	amdgpu_ring_write(ring, reg);
 
 	amdgpu_ring_write(ring,	PACKETJ(regUVD_LMI_JRBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-- 
2.56.0

