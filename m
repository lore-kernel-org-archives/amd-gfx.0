Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D7CC27C53
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jun 2024 02:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2380D10E95D;
	Thu, 13 Jun 2024 02:27:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vb6MOmeU";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D5ED10E95B
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jun 2024 02:27:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbZlVYr31UNDvrbjcaRsoLanjWoq+lGV9gVuqLMzeGPLzTfuBM0CnQIInrpEuSPDbO6CdXxOAHfj/ok2o18S8Ifzzjgblmq7AkYcai2onwUc2Rm/5scZK8bBkwasieBTvTWnsPno4XVPJu0ACwiQpyzf2TdhggXZDknz6wW0oTVd2H0BGGnpRz5SSWHs1yXAijjXRCOGVxvz3Q810vZRNAEluvcKy/SzbK/x3CqsDp/osAPMlRMGq+eeS+E+X5wfoLNomrQawtESbH4cUp1K+EDt0a9+YbcuQI8a5ECCmYXGnJAtPlX2+os6e6EqrcLmR96kg+WPXdOfcK6PJDmCXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkij7qa28qNfEiLd/gQnwkjCBROOAhCe1JCNYHLk/j4=;
 b=jtnqvWWWQoP/xhgv/byGwR3K28WOAH5pKWD1DoXGc435EM2MFhuudMgvbzKLbPZuMrpebxLOZ8gXvLvzwxJX/pMORwD8lV11fkXDaPv21qpzquiuqq6dTSm3NnmspjbsbiWNshI+uAJz9OoL1RlS8KyPKcpvdrLLOA4OTczCLVf4nkExbxTbECptzn00DbXWOWSUWmibapuQ/Bffdl5yL7alG8rJrtIa+plzU6aCV/vA82C2GpPwTJXGDeLedtyLR44mujAEWNDLlsCOEE879aeue0t9bCceQMu+IQI2y0YydfabmWcij6vnJ0eMvjN5H6UPu930PNekDZo/igGe8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkij7qa28qNfEiLd/gQnwkjCBROOAhCe1JCNYHLk/j4=;
 b=vb6MOmeU95/60Y0fMelRzm0QZw/um4H9EltVFcCdFObbenPekerjjsSFmx1w5iBWHYEFZvmVlLksI+z+mGzhFnhkJz2CTQVOoVOM+1KJZOQCQWLdtQKNYEXWYlyUNI5nYMlWUNf730EyQFZbYC0JBqMI+Z3KwngtbMhaLEb6IV4=
Received: from CYZPR05CA0025.namprd05.prod.outlook.com (2603:10b6:930:a3::26)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 02:27:06 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::9f) by CYZPR05CA0025.outlook.office365.com
 (2603:10b6:930:a3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Thu, 13 Jun 2024 02:27:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 02:27:05 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 21:27:02 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: wait for gpu to complete reset
Date: Thu, 13 Jun 2024 10:25:03 +0800
Message-ID: <20240613022504.81787-4-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613022504.81787-1-YiPeng.Chai@amd.com>
References: <20240613022504.81787-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|MN0PR12MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: 0550d8c1-d163-443b-e74e-08dc8b50516e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230034|36860700007|376008|1800799018|82310400020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cEgaf4dRe/9Ope9L9TKAijn2pD98dxdZbNPmcVEZ4tfgdkMGAE1Orj9P3K3+?=
 =?us-ascii?Q?qUToVxk5HU6rXigl8TPrAIJrSHuhu7uBO6XLFWY4qt7XaR2qY8Y6V9FpB7Xw?=
 =?us-ascii?Q?tRskV5LX+D6TKY6SKmLbDUvgl4bwFiIV0cIDJhWavLQu7b3Arz6/U3F0Ia7o?=
 =?us-ascii?Q?z/IQ2cD+2labLIrG8Ozq/Ki9KENvQ63vM5LD1qju4DXiytisknQywC3uKEv/?=
 =?us-ascii?Q?I0RdyXaVHED5pPqAMUERVg3sE6ZFo1IbAVZsZs8iYifx/qrCpZmsEjErPSeb?=
 =?us-ascii?Q?zQcSlCsMUVBRmKcRNxXVuQ/OQwdAvyBa9WG6+cZvN/wUmH1ArcoWVMYBhbr/?=
 =?us-ascii?Q?OWffdpgvqFVxmkUwrtIyIDMTD9BO9UYzsiAPW69rB5LkD8yLswlDd/g2PN5d?=
 =?us-ascii?Q?eF0OSX5vvVfVnmjNL9LS0nHo5IwFLPH4U4kiMxt9q7X056zHvyqCQv3UeKTJ?=
 =?us-ascii?Q?9QrlQcH88ADj73cgqMCjHmixTfKbBkyHtJBKKZsv779wBbFEX6yy5/GNB/uj?=
 =?us-ascii?Q?1njnWdad4dP+zKvZLW90485N+d2M21ONyOxcJ3KD+RlVWgCHj/Zs0kQMHziK?=
 =?us-ascii?Q?u0OdPGxJK+L2w4N4NYBdaxEjxF4w6rk7y4UFXAQD6dLIoMZJzh4nM1Kv91AI?=
 =?us-ascii?Q?UBMt0GtJL1as8ijTwzBOVGvqmJiyVakrmwR60aaxQPR/DR2rKnAKaI2a049G?=
 =?us-ascii?Q?/HcleJu0+4+joykZ5YdwnCgVZwKZ68LGjfYzPaQ17gXu8I9ltPAdTYQBZwf4?=
 =?us-ascii?Q?DChdeeznGf0gmvY7I3CDIpfJ8ocY+ME3VWnlJw9xSWqJsVYvUDXpwiixXVI+?=
 =?us-ascii?Q?W0w4LsfIOPKNE+iaLuiDYB0kAnNpggkNhEcEEK3BmP6knUlM7eU38babdIEZ?=
 =?us-ascii?Q?P1GI55xH0GHP2BWjqCNhhYnx6NrPLrYA2Lej3ujYTuCNUSdhTFRDXpBc6Bu0?=
 =?us-ascii?Q?TJ9J935gam4WWxukqgwe+Ka7owT3AnyW6GZ5o+8l2TeoCPDsKwt4EvuKEPCV?=
 =?us-ascii?Q?apVD2gO88OaEuXXsjPU4EAQoUEdiBNxKtt4+CWplWcns46oBp8U5gL/XXtic?=
 =?us-ascii?Q?mRMDWNRfEmVo0FGNN8EmJFROAWNvwN7xqD5VMkAOn8UNDqoBmJn/a+3ZUezm?=
 =?us-ascii?Q?I4knQeTJaXn+jhUtAfe9rZbq/NrTstBU4oHC7szdSeJPzg35vgBn6AHTvR+A?=
 =?us-ascii?Q?+lmPMDb5t0GzSKg2I+GnBOdQhlCIebSPbNrGBjuySjCfvVqrb4rUgNLSYa3N?=
 =?us-ascii?Q?VYc9TG2Jd7UpIa7zgeYaZmXBJ1dFWqwJ40lJm1/uN3anaU7HAR4u4GvD1uUX?=
 =?us-ascii?Q?Ep6RwnDMupz8kKLL4Fob4+4UC6yppr3qprlnaqpmvggLHHPB7fk5a2YZRpCk?=
 =?us-ascii?Q?qYFBPn+yo/Tx0ES/SvZSErzWJnoGDN/jSBBalvr+NNWzf0qs7A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230034)(36860700007)(376008)(1800799018)(82310400020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 02:27:05.6666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0550d8c1-d163-443b-e74e-08dc8b50516e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223
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

Add completion to wait for gpu to complete reset.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7dfb2e548d70..341c9bd0d1a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -124,6 +124,8 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 
 #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms
 
+#define MAX_GPU_RESET_COMPLETION_TIME  120000 //ms
+
 #define RAS_POISON_FIFO_MSG_PENDING_THRESHOLD  (AMDGPU_RAS_POISON_FIFO_SIZE/4)
 
 enum amdgpu_ras_retire_page_reservation {
@@ -2526,6 +2528,8 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		atomic_set(&hive->ras_recovery, 0);
 		amdgpu_put_xgmi_hive(hive);
 	}
+
+	complete(&ras->gpu_reset_completion);
 }
 
 /* alloc/realloc bps array */
@@ -2946,7 +2950,14 @@ static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
 			con->gpu_reset_flags |= reset;
 		}
 
+		reinit_completion(&con->gpu_reset_completion);
+
 		amdgpu_ras_reset_gpu(adev);
+
+		if (!wait_for_completion_timeout(&con->gpu_reset_completion,
+				msecs_to_jiffies(MAX_GPU_RESET_COMPLETION_TIME)))
+			dev_err(adev->dev, "Waiting for GPU to complete reset timeout! reset:0x%x\n",
+				reset);
 	}
 
 	return 0;
@@ -3072,6 +3083,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 		}
 	}
 
+	init_completion(&con->gpu_reset_completion);
 	mutex_init(&con->page_rsv_lock);
 	INIT_KFIFO(con->poison_fifo);
 	mutex_init(&con->page_retirement_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 103436bb650e..d5ddd0ca5de1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -537,6 +537,7 @@ struct amdgpu_ras {
 	DECLARE_KFIFO(poison_fifo, struct ras_poison_msg, AMDGPU_RAS_POISON_FIFO_SIZE);
 	struct ras_ecc_log_info  umc_ecc_log;
 	struct delayed_work page_retirement_dwork;
+	struct completion gpu_reset_completion;
 
 	/* Fatal error detected flag */
 	atomic_t fed;
-- 
2.34.1

