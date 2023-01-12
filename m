Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA070C54EBE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 16:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6884210E300;
	Thu, 12 Jan 2023 16:59:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4438610E300
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 16:59:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itR0E+z40MxdBA2XWM94fn3kpET0W+gxDwMzJAhkXe9zAjDN9Jwa4/cVCkzqPQNZwMHFDw1z32Nq0k5A1ZXUiM6R5qsSHyl8SpP836GxLD8d9XgJQLPd1gWHSjUhxdcLY6aXI8HRhxToi+J3aVWb9gKHWEp+v1eEYQ1pKle7Bsy5zabUMAGoJsDUFdwlqs49GzAKo6AIB7HPxy40qzv2YDlI5ug/sXfiDjL8WQ1FdlaiWFknLYTDSsijAJ/obuZq45X3CcKf1YGNVamog8Yc1sBVfpIP27aCdTy+RNrEByZcrvb9JMRjNDjVYWnksW0FfLtM8X7+cHsvbn1bZuTuKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPZjOMgVu69bXNYLFDul6enB5lbKcr5DdeXVGWKxF1I=;
 b=BNC2n33v7Bv/LVViMeiCE7NNCLDyBEjGYEi1y3MXEYQCaavvZwZYw+j+6BtNDJwXOwt9e5g7xY9CVlhUp0ilqJuHdaAfAf39ff9Ib/YMPCKHfUxq5d3W9LZhAI9wC4np2RK3fD694b3gJgcUa9KeX+lsW4kb8/FlA/UTGHqZJsGvsA1iHkekwFyjNFwcIfjkEUaokSn6rvw+5uDq0EA3jYFfQGssZgB10pbZlVcY6ieLHiwwbnXiEm46TewOCrpa5htzqATqtQIOEkD0ZDPnp13almE9KO0M+zE8wrQXmt/diAx8aRX3cxtbDOaxr/0Fa4ie6bECmbsfXCLUGLLH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPZjOMgVu69bXNYLFDul6enB5lbKcr5DdeXVGWKxF1I=;
 b=e/aWFNJjDpgla8XglyBpIivwx0vbxHJOKny8dUtz+HLsIWAQUQwuTdeC4hwJaUj1uvQpY1hgqCg+TJJqh/qNM/arSw3N0eYfDkGRWwjhS/QRmp2WwssnyjD2ptB+OXFl813U+2x1i32kWSYPDSgOZtUsDZqmiN1PQwSlUyVTQC4=
Received: from BN9PR03CA0395.namprd03.prod.outlook.com (2603:10b6:408:111::10)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 16:59:51 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::59) by BN9PR03CA0395.outlook.office365.com
 (2603:10b6:408:111::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Thu, 12 Jan 2023 16:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 12 Jan 2023 16:59:50 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 10:59:49 -0600
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: print bo inode number instead of ptr
Date: Thu, 12 Jan 2023 17:59:38 +0100
Message-ID: <20230112165938.55022-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 728c6832-ee08-4267-07cd-08daf4be6b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDaVn8Xi6YVjXf1QT7YQXnHRKJ6OTQGceCSQ40qTNNeTI9p8y1DyRjP8YNBd9YJs93f85O0Su2j1Sr6VfCxsa7WcMPNC//DFqiKx/WypgU+II39QPap8wYD+WZFThqTGw9uNCui2AlM2YbGn6lepzvK1ZPCNBXU7jOj48/NtrCuWxdv57wb3ikIgOPLRYHpojaq5AljGUmbfPjzU2XIYkmv6dABMge/mvnvbrz0zquQxD+iKdzgKx6qAdBMxyMolDHeHB5nRaBUwxvYgmlqBlvQtGmisn+SZvloZw1IDTNeSXfCsAzr+5bGfL1b4cdwBRxHzfOo9OuG/2iXWNjUPGJuux4AABTCRabyNMmauhFHE+TNuFFRMVRUkX6yFE9PRwi2ohQmYeO6EyGKtjMahbYLdmXo0jje1tQ6sNGeUEA9+tojTFwZzJrg/dJJwz5EmA699YKxKVdQGkW6lqsj691pBPVdkXglzL1Ai0xj//6mTqGjTjSruVzns03KjstkRANPa8X7s6f4R1B9CB5tmAl5hGX3HbtmLFtL2gfMZOOJ0dcgN2wE4td22E93atNHQns/VYLXtc8PgHCwZ8cgwhXmnQZdyDmNrX5WO7nmP+bsNbjYxBGpLVLo9y/iQPws7ok/w2EBB4i9EfhqA0Wd3dGeIowwnvRs7Qgh8OX/4OMWNiJTwC7aH62uCcVGiHG8OBLZ86Ye2aJaXsU4YuWfVoAQ6s9WAul5ykqzzdEZqcXE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(40460700003)(47076005)(36860700001)(41300700001)(4326008)(336012)(2616005)(40480700001)(70586007)(426003)(316002)(36756003)(1076003)(8676002)(6916009)(86362001)(81166007)(356005)(82740400003)(82310400005)(5660300002)(8936002)(83380400001)(70206006)(2906002)(16526019)(7696005)(6666004)(26005)(478600001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 16:59:50.9829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 728c6832-ee08-4267-07cd-08daf4be6b75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This allows to correlate the infos printed by
/sys/kernel/debug/dri/n/amdgpu_gem_info to the ones found
in /proc/.../fdinfo and /sys/kernel/debug/dma_buf/bufinfo.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 90eb07106609..2b076ed46e78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1572,9 +1572,9 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	attachment = READ_ONCE(bo->tbo.base.import_attach);
 
 	if (attachment)
-		seq_printf(m, " imported from %p", dma_buf);
+		seq_printf(m, " imported from ino:%lu", file_inode(dma_buf->file)->i_ino);
 	else if (dma_buf)
-		seq_printf(m, " exported as %p", dma_buf);
+		seq_printf(m, " exported as ino:%lu", file_inode(dma_buf->file)->i_ino);
 
 	amdgpu_bo_print_flag(m, bo, CPU_ACCESS_REQUIRED);
 	amdgpu_bo_print_flag(m, bo, NO_CPU_ACCESS);
-- 
2.39.0

