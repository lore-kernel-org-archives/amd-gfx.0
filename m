Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A2BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 18:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D6C46FAAC;
	Fri, 26 Nov 2021 18:42:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF1B06FAAC
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 18:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfrVljeLloF2wzPE9EeNhhC+R3tE7F06IzSfi9Tm4zuJNWUNLKSQ7+IDd5KhYmuaIjguuMMiL8NhpUDws4COurWie1hKLeI4b32RQhwafjNPA0OrfPBWaeZMuZxvahIuDjLdpyZS4v4yDYie5XowUBYJz/2WR1j3lSNBurPRNdOvocXtWpAMt3CjFr104dSQTKEz59yqWpg0igRKnDAbWD8MfOPyF/k13gLqbGX1et11hI7Eh8LCMUybgIXAyyyZ+7mlofqj0ZoVbl7wKimNJ1IeGOnYRybzZBhxKV5Umx46FRwHDFeiEzNS6itwE+ONfZZfqX3OZkOulfDVW/EbIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWZMsGM7qR3m7n2bfksXCm++k1JqDULWm14IWoVFMwI=;
 b=JxNffvE3xlSpBF9fN7R7aSQNZVT5xtaGH7W+DbthD0sljPPheFZ05q7Ev/ih7G+vpAEQbxrxv7+DLw7xzcQ825f+ACFmvwdr6oX5xP0DSJilKhMw02IslbZKC/j1Jb2of9tU2YB1BpH6L0O416k1no5qx6QKtnjLN5Tu+ewPPOg6zRby6NX8pvGTAZA2RIRc4Mkz+mV9Ow6CUDiRo30UshBjKfGyJwOwx8RCF504HR+kkpbWO6d5RCekXdXBrxpPNrC1AKQ/9HPW7faFoIn9EExUjo0MRAA1E646bWKw0CJw00rykNXgu1pWFXYRYXo17v4B6+/kztJDNbmWA155wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWZMsGM7qR3m7n2bfksXCm++k1JqDULWm14IWoVFMwI=;
 b=Eawa2ZKE/VhIgIFPSTaxbbUFr/EOo7Dzzy4D9U0WJNuJw7MsUCKNdgkFaCTWpC/GDFPsNxDJA6X+GZ1vsqhXBEoz5FJDHKNRi4V9ed8t83ktzdCNXy7EDy4RzWJxbZ3SJvO6oZ0RahB3lpKGYwq0yiFX/GrKsvCmEsf5rSGtO5o=
Received: from BN9PR03CA0742.namprd03.prod.outlook.com (2603:10b6:408:110::27)
 by CH2PR12MB3958.namprd12.prod.outlook.com (2603:10b6:610:2e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21; Fri, 26 Nov
 2021 18:42:34 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::16) by BN9PR03CA0742.outlook.office365.com
 (2603:10b6:408:110::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Fri, 26 Nov 2021 18:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 18:42:34 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 12:42:33 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: set "r = 0" explicitly before goto
Date: Fri, 26 Nov 2021 13:42:21 -0500
Message-ID: <20211126184221.17598-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 360ceadd-448c-44a6-7de8-08d9b10c82e6
X-MS-TrafficTypeDiagnostic: CH2PR12MB3958:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3958F5F64BFB1309224FA92BE6639@CH2PR12MB3958.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SIXoT3pOvyomXW4gt0ICdcHK7JYUfgBkbTEp+ZpZAe90rx6PUL7L7VNxE40m6XLeB+6iZygCNrJjZXjKUM1Q6JsJ+AM2O3ywRscXe5/kEicyXDtKnH7jyXLHCf3VPORC8dsbjsfD+3g2EGVspEukuKb+aKsGwdndmdOSMmrDk+m6+VqiBA2yeAvJxl8UMC3D8YTqnDzV9yyX0U2QVLN6hQR76TrbxymCe0fUD8mw1L0TKpCGtv/frFY+wl6E297H8IXXNXeyZLnV8IJ1fEkzJM/mj1S9yttWRN/LoeCyP8+Xt4qEYZk4PyTqCfJHDp6LuN39AHRpUWdYln0zUMV/thjxCaAYgRQMt+GCKpUphXmhUoLUU2mAp7GyHs5TEK3dk36mKZvGUeRwQFwj2SVzUl+AvEpEqbQJr8YWTRIQJ2WWm9TKi0kzLPjnVJG0Wn37vtuinI3im8xZApUPR4UA1XSPbDPefSe3ZRotkfJXsqgc4pyD6o4/imsfL1rcggKfsMuxZm882mZzFU6mmaPWDvI8y/H8+eeLgNXem02jBucvTexMqJ/YA2lVe6miAWGlb4WkaNbM7TG2CthPR9aIdNRjd8QoQDreAQDY0SxIovft4PwVrZx+EG42dO7D9nUoL0W9pm+JUxCJ7vy9kW7olnylqGJ2odfvQrv8lOyNftwoJGXMPdhhRIRyu7sdL0aX/+RMqDBUFctYde2cxxXo8RldendRKoE6OgCmMRFjp94=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70206006)(508600001)(70586007)(81166007)(86362001)(316002)(5660300002)(47076005)(16526019)(8676002)(2906002)(186003)(356005)(82310400004)(36860700001)(7696005)(4326008)(8936002)(426003)(336012)(83380400001)(1076003)(6916009)(2616005)(26005)(6666004)(36756003)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 18:42:34.3073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360ceadd-448c-44a6-7de8-08d9b10c82e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3958
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
Cc: Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To silence the following Smatch static checker warning:

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:2615
svm_range_restore_pages()
	warn: missing error code here? 'get_task_mm()' failed. 'r' = '0'

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 663489ae56d7..a74154c5aa05 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2603,6 +2603,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	if (atomic_read(&svms->drain_pagefaults)) {
 		pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
+		r = 0;
 		goto out;
 	}
 
@@ -2612,6 +2613,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mm = get_task_mm(p->lead_thread);
 	if (!mm) {
 		pr_debug("svms 0x%p failed to get mm\n", svms);
+		r = 0;
 		goto out;
 	}
 
-- 
2.17.1

