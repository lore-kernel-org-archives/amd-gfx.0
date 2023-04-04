Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A51C761A6
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 21:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61EB510E7C6;
	Tue,  4 Apr 2023 21:59:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43BD810E7C6
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 21:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/p4GBywGn7kxiM3+FEZ/IlRtFLdkLGNqBh+o/Z7Dg0wXn3TuM+oANVbprQnaYpT5YXitc0a7OlRqDmRsK+8TIx1QDVgGxw2MsRLeUI3JT7whARHNIoPExr3HokhSr4ZeEZyejhaa95eUjUUmYilzuNlIFJ7D/OmoSHgRT76p/Q7849FCx1YZkg7HCzA9Z61AlrZPtNawqXXdm+iJd5KqIj+Z8y82bIZQAajPpARh8AmG5C0VTxugnfeixqoHIoWeC4BxtIvHg5gHzs5+/n3jRX17Ajp918/Kcg2soCNoPbAp/s4SwpVPg53KnxcpakennhnznV3ykZUjCSykvm99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MH7Lt5rvXKpg+Bh8Gqk3n5V8OA+TokGLR5dL6dGF/4M=;
 b=bgIGGizH/m8NuEzeDI2CsmxdyzDUyIQ2Zz+KL64k8SeLKRNSfLa5Rw0F3J2VBFr29f+UwHoj5SyZX/fZTRhwgfLtWdfo5FRnszHc/W213NYqxHIChUzs8reM4/ho6So4YdR5elpIFO+wyaVtjV0cn1b9AR0yqZtyXD8tRsT/DC++BgFo70zi4btly+RBVUCAlAxcPiFZ4i/u5KgvWh4BPe5Gq6OLge2K6iGzZBLasPaZ2C2XwRHXF8zUGdL6jguWllR3XKY20R3JhLdWmti5wrs41Gyjk5aSog5/wEnmfRL0/C04camQMcy+X7SP0lZtr1W+wfykJjzQrX0sRuQ4QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MH7Lt5rvXKpg+Bh8Gqk3n5V8OA+TokGLR5dL6dGF/4M=;
 b=A7FsYaedPAc3J8L/u2JmwU+62OYBHcbQO9IxVGalbxhxdscBKOqhzs0JwZuwcNl4VZBBfss/PdLkuhmZUimwGqRPXsokF3lPPxgxz3Czni9ignRqLrVKVgC/VJNK0bE1Gzbw03T+U3TB8PKuKnRKPpI4WlhxcNSAO3hkvxDCvO8=
Received: from BN9PR03CA0042.namprd03.prod.outlook.com (2603:10b6:408:fb::17)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 21:59:35 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::5f) by BN9PR03CA0042.outlook.office365.com
 (2603:10b6:408:fb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35 via Frontend
 Transport; Tue, 4 Apr 2023 21:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.16 via Frontend Transport; Tue, 4 Apr 2023 21:59:35 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 4 Apr
 2023 16:59:34 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Update invalid PTE flag setting
Date: Tue, 4 Apr 2023 17:59:23 -0400
Message-ID: <20230404215923.3739152-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9e59f2-ebac-4189-201e-08db3557e0d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwqIdT0UkjfgtzNnAOQYQFCw6KrCMBDmtTftyUIVihGzX7YhHVV9NAg3mRqO7kdP/gXH19i9FyCIcpGhv9dWFq2J19P53mlwq4kp7eTfxvjbnhUDcothcaZPSXxr51V1y3gV9/jX2b8/QwflDyKX62Oka07bEXE9SGF59ifHPHunhZbF4feKt8DnBx16PKJ7AEDai4svd2EQq/Pg73rjuwSZb3MM2kmNF4pJELo97UAUqJPZFQiqg5Siqky0b9ZUN/YPKPJzaXvWq6lDEEssRNfLh49FXBwUnFuZlxLrYvMug60qyKsXJ07YdvsvXNFwqVB22527C6PCyzAbNZ/HXdiu3mTdI3GdCD0nFijNnlfv2YRN0dSIxbyNQMiFYZdo+7Ds48R4fpW2+tF/mBExXenLX1gn+vMc0dcij3uCLXKlzYQe7ZOSRpz5KHGdzoEme390wdMCVPiABKlj1HqF4H8NUkhHJiFeCt4JGwZNKmDbrSnvH9C4TaER2ab2TAe4L/aKDI4zYMkNpStB6iwrCAoj49zPyOorCzgQVdau/SNyufRBB5OfYG3XJRpmzZKf03/g93N7J9pyof7AwFW5OnmroQp7hsMMMdRIfMzjWC4I1ewfcgoHdgQuIyC+irhw8Ino1TUI/HVPOb9yFp7lPBP3P9G4KQvQQJobLzn/0ioEvZyVDLthAo7ZyKWix/GJCPwDbUhJ1zXz7Sg2Qt7VCYF0iEB6indN8XS/z1D5+24=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(2906002)(15650500001)(44832011)(356005)(81166007)(5660300002)(8936002)(70586007)(36756003)(82740400003)(70206006)(41300700001)(6916009)(36860700001)(8676002)(4326008)(40460700003)(54906003)(2616005)(316002)(336012)(47076005)(83380400001)(82310400005)(86362001)(426003)(16526019)(186003)(478600001)(6666004)(1076003)(26005)(40480700001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 21:59:35.3038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9e59f2-ebac-4189-201e-08db3557e0d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com,
 jay.cornwall@amd.com, laurent.morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the invalid PTE flag setting to ensure, in addition
to transitioning the retry fault to a no-retry fault, it
also causes the wavefront to enter the trap handler. With the
current setting, it only transitions to a no-retry fault.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index af6f26a97fc5..5df4f7bb241f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2488,7 +2488,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		/* Intentionally setting invalid PTE flag
 		 * combination to force a no-retry-fault
 		 */
-		flags = AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT;
+		flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SYSTEM | AMDGPU_PTE_PRT;
 		value = 0;
 	} else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
 		/* Redirect the access to the dummy page */
-- 
2.35.1

