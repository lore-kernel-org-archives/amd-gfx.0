Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7FCC678DB
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 02:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 793CD10E0B1;
	Mon,  6 Mar 2023 02:33:27 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0AD310E0B1
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 02:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzBFOuoloa2KoXcYPEsbZzCwgmRdWdsY6UI7Sx1EC5gFNoUaUO9zg1xRlAT/Un1dxFYKttks/DW55shS5qyeoWUhXZigSkRALzp1Gvqo5Y4RmCgUQ5a0H+QY5zPhyMMB7KK4Ikr5Jdyv3fmfRQ4F8w2N1STREb3Z+wqGRNPvxGw2Tf9U/sfzE84rfMM1oimPW+KkNVTRiFiIHq2jb4XETAEC4hqhA13OvmEeiNfeMsH+giITOR5ZJfsqNLbFoFga9Ri2XBs0R/VLEpZ18px48Ylr/FssFaXZsHuBrn4U6SB6y7WREpAFknzxauD2GBhsZ/y18Nl7pV4uUpIjzC8ZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zjRNs9NO9Gh8OL3LneObAlfWE/89QYJz/VDELX5IDg=;
 b=NlmbPZf49Bj+i+igu1y9Sgt4CQYS1a+76Hz56BIskwQURribmE+RunvOji00XjmeKK2JHaezq6PLimde6h6wSz8+04t1IHW0iFDjv7taWpFu/P49SVwlKmIAADFq4pUuXsv6Lj68I2j/xKR94JwCGJhEvVfrxkmjUuiwXId1RBRPmCKdDQ4vF4dF8DQW8ebtmV7JwkRr5QaoouS8HjSP20p4v86MdYqMonyIWrLdJ6d23r3nG/B2329cS+PPMKkRt/uNaQyMaLl6IuJ77duTQ9apguA+wGzyxz11NLk5Qrqz8vv3e5bMr9Z8kkmpXCpF/gRXcRQHLDRcAjxZEPoQyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zjRNs9NO9Gh8OL3LneObAlfWE/89QYJz/VDELX5IDg=;
 b=b5zqLpf00ZRv073d7pv6/nFXSVqyJH0gWSsujbBrUCPCSEHCqAsTvL/8KNuHAUVz0QENe+SRDawakpIdEC7V24H/cjh82SbN/xLFtl5IsBfcEtUHa/fNJ1VZ89txdpYnyCKFbhj4LbZgXmdBe2D2QQVmj+FpZFSLuSfPDlCpDGo=
Received: from BN9PR03CA0505.namprd03.prod.outlook.com (2603:10b6:408:130::30)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 02:33:23 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::5c) by BN9PR03CA0505.outlook.office365.com
 (2603:10b6:408:130::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 02:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.19 via Frontend Transport; Mon, 6 Mar 2023 02:33:22 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 20:33:20 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 11/11] drm/amdgpu: drop ras check at asic level for new blocks
Date: Mon, 6 Mar 2023 10:32:00 +0800
Message-ID: <20230306023200.29158-12-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306023200.29158-1-Hawking.Zhang@amd.com>
References: <20230306023200.29158-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT020:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a10084-33ce-4484-2d59-08db1deb27ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: znCIR/eptf/D5HhnYoCW5jb+7FKytKEFcricUSTbVmZTClFYurFhBPGzjIOrDynuPME3OSA+TSnXl4vyyVHynskY6McoG6ujYPV25F8yBvWBqRYDfF4TF9wZNZIGjBB9hnXKLx5PwiuvARxehjxDdltuuBEvNs4l0i/7/5Glt+KUHVSAWFxXlwNS+PFvZIkAvmigNgUywZYALf5Ewk6ehUgShxMkvmVgRUtJjQfyphkNz1RLY3mW/jyz/wS8ntBJGQ8MMP5Rrs5PwKTv8SEFglmRVqvr5dywsCqmTwxer1PGKtLaIPp6kfAOpSq6uiml0965YxXu5ROw0TIXROB/lQ6Q7hEuZnycFvz+Pwmszs845RHKAmvpt2b44w4p2vsY4SYLhiLYigqaTTtjoyGDHXlfNwnY1WFi4FfopH8Ae+IttffV7tIwNOS22gktM/rNGxqs/60zMMUeeHWn3nHiauJBAmqOMnHosflhML26DJt4qAmr+8krJ0WvN5Tjb7sbahtu4D7r696k4/2N9bCGw17BNwP90o5ZcIEVFDnjLAXZagcBq4y2F7HjFCNlw8gJpdf+OMPVnb/DQVac1IXf3D0sw8luDvCl4GO+UosyIpuqcHEtPdHf6yOwW4CmoIFzaoVdy99xnsw6AuJivwL368v4RxvbrGL5vVcOcxiuYNmW8+9UGUg1t+6Bbu5EmAxah019d4KlcNziLAucfjCdLulvdDD+UgYamnzcwOksi70=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(36756003)(83380400001)(426003)(47076005)(82740400003)(36860700001)(6666004)(1076003)(16526019)(186003)(26005)(7696005)(336012)(40460700003)(2616005)(41300700001)(8936002)(70206006)(70586007)(86362001)(40480700001)(4326008)(2906002)(8676002)(5660300002)(4744005)(81166007)(356005)(316002)(6636002)(478600001)(110136005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 02:33:22.4931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a10084-33ce-4484-2d59-08db1deb27ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_ras_register_ras_block should always be invoked
by ras_sw_init, where driver needs to check ras caps
at ip level, instead of asic level.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f42480b8a8d3..e6b4b0bf622b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3081,9 +3081,6 @@ int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 	if (!adev || !ras_block_obj)
 		return -EINVAL;
 
-	if (!amdgpu_ras_asic_supported(adev))
-		return 0;
-
 	ras_node = kzalloc(sizeof(*ras_node), GFP_KERNEL);
 	if (!ras_node)
 		return -ENOMEM;
-- 
2.17.1

