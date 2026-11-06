Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB34606A326
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=10238E37
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B96B89304;
	Fri,  6 Nov 2026 06:26:41 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D78D10E19F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 06:26:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzVEaBYW2k09ukmBtXmY7Tnqmbzl6y1Kq4eHHZR8Z7oiwykkUb6JZG05QXIzHqR2zz1sLpONgbC0SvdV2sWBr0YRojXo1E/tcDAdxxjQ7njJ3h7b3HeeqDq/87ZeXaGuP/m5lHrutrx9KLX+yQ7Xcwgv+RrLpEqd6hOGBHbjf8CTdW3WoUshQNy8tfoqte0u+zlItd/NZagFS2vgY9upO09xZx6/il89+ZqxFSLW8e691RGyaXzjwbxhRChzjOmrHi6KbZk1jjJjz6vp7W/u1Ow6L4Nyukakl2nhSnzAhhs6jY0XN/B08ueqfg71R0X5vSocT3JFPjHU6nlnMfBvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBroUzz/h8KDycQ7E9KMadhTy+8UJmO1Y8Hv10aA5v0=;
 b=cVnEQ8+g2WCzBT6MoeCEW6Hhkkd5TmqYvazJX/HkoiQDKHsFZrLLaLhBuE5HFyaE2nM3KruV+lmXnjryfgppUKes9T7SBQffnZ3iu9YxHUnvyREGAWMm5+4cMuu0Ij0ybTkJcwNFDdj+IOnN8muEOeFl/upcA8J5FgiW1xDqsyUmTnSyorwB8s7R+x6BjLnDS8M/1yMMCm33ddc6T+VOzPlJzdblnhsbYmUkVz127MjZDAJB9GN+MHu6bILMr1ASWs7K6YLiIWoieUsNz5AX+mQkyBUH+AmKIYYQ1tX8CnVIvQ6dzl/6BNyE4wWHSJzfbAxhxZXVB80a39a2QuaRiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBroUzz/h8KDycQ7E9KMadhTy+8UJmO1Y8Hv10aA5v0=;
 b=10238E37lyYEhSFE8pzHM8Uqd01Ed6tZLFi8vGpM1jYga2P8+4VZrlDnQAMS9ECC097UCf1nWdXcpTjdwT02P9vsBu6Wt9VCP4p/3qB9XBKyulBhTTl+q4E5upnjRXIwh7WX3eENFhpEKVzQn3PVu2pMAd8JqMzXmy2AeNx4zo8=
Received: from PH8P220CA0031.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::14)
 by SA1PR12MB8119.namprd12.prod.outlook.com (2603:10b6:806:337::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.14; Fri, 6 Nov
 2026 06:26:32 +0000
Received: from PH2PEPF00048913.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::21) by PH8P220CA0031.outlook.office365.com
 (2603:10b6:510:348::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 06:26:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH2PEPF00048913.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 06:26:29 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Fri, 6 Nov 2026 00:26:28 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Yifan1.Zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH v2 1/2] drm/amdkfd: check CRIU SVM priv data bounds before
 allocating
Date: Fri, 6 Nov 2026 14:26:15 +0800
Message-ID: <20261106062616.851993-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH2PEPF00048913:EE_|SA1PR12MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: bff3a0a6-69ef-4acc-8d4a-08df3bcee4fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|18002099003|10067099003|11063799006|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: MHUG/IJQ4dXeE/2Tsun9hIz9XYXvOCkTyyVGwUygQYBpFOurp8xsw0YrIo/eiDUcG8sbYC/mV0/TbVCQnMkh9kma7Pcng3VstptIJOj8TOCySNXFtPQo3lYe2nSDPwxAtC4KpdNkKGRipskzCs6qaQjQLzzhQWEA5ZYbaMRzpQwAovTJRx6rzj2mPxJxkXvMVeDTgHsYM0aJHhx90nu0szpzpWkO0Xw7axu31YimhEs6NbyZHX9e+MYhAy/lLSD2cEsG6CDWenBWIJ6IvR/X0b6OeQW2193C1WUnr5xi2P0fL1ln6HlmLkrHuMtgKi5pUG29veiZ3FUtILNYj6Kh0HnniO9CnJW6YHwsNjeTgYPhCsSaOO2wpvsD4s0l7OKi+UTHqfpQzQDuy7bKUJj2cYulE5jwsXBM66K66fTeysV58FKUdnUFuZygWjdTK9COb8xjQsPgaUGW5uIiVD1ApBJB1DjMmGtQfhghLWUWkjEbO7wNyGBgVs5DE3wB9gcMwW3u3aAhFTUctxiOGgtv8RB1eG95KpDaGQL1x8CFbwBCCUOx9cIlxiiqZWj/Xc/CzBlO8MUMnhXRDZS8Z6SAhnIhUmcIf73DB3s/dKhRwDLAmsvbnsui9bFmDONsydbSvkkWiang3GW8X0IgoS9VGaWepQqTIWAuSf8LWg8YWGSc9Di5D01e8J/19yBinUxC9WnMg7NDcD8NYRiFzGczCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(18002099003)(10067099003)(11063799006)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: osZ8kE78dhIhY2UegvXG1yOVj8xgROZP+D1wN0AORCoYAueXLVknmpMEnj4qGWqb7TmEyw6UKsGokKA6YOJVsT7DimlhsyiVaWUZf8+oaADcdu3njLJAp5Rbf6HPGwrhVmJg6BmBAmS8Jj/KnoIEtcdt4bY5Dp8v/A1iLZOxvhExh62WwlTI0Fqyc6bmLKXlZzUyRLhjiExKKNu1MMglE4sesjXvlS3wnZl2YrYjXaVEhWjn9I+LFN1/OMBkwTtgQioKb8QY2WRNHO337cCLR8M1oLOkhrhx0KQExa3d9gpmmK2G0v3zMD5rDQJGCPFe38iTQe769AiYG1tXd3DFwK9oq33oTvM0lpjP80aKVdWiXig/K+SN6HG1Q2vlsCnvRRWpcv4kM2rBAkp/1N/zIkWXvBsOe2mx7uyg74MgktYC8uxne/LgI0LsnqnlN4Im
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 06:26:29.9896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bff3a0a6-69ef-4acc-8d4a-08df3bcee4fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH2PEPF00048913.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8119
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kfd_criu_restore_svm() allocated the per-range metadata before checking
that the range fits in the user supplied private data buffer, so an out
of range offset cost a pointless kzalloc()/kfree() round trip. Do the
bounds check first and return -EINVAL directly.

v2:
- split the original patch into two, one change per patch (Yifan)

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 876476046926..a571fda5c713 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -4248,15 +4248,14 @@ int kfd_criu_restore_svm(struct kfd_process *p,
 	svm_priv_data_size = sizeof(struct kfd_criu_svm_range_priv_data) +
 								svm_attrs_size;
 
+	if (*priv_data_offset + svm_priv_data_size > max_priv_data_size)
+		return -EINVAL;
+
 	criu_svm_md = kzalloc(svm_object_md_size, GFP_KERNEL);
 	if (!criu_svm_md) {
 		pr_err("failed to allocate memory to store svm metadata\n");
 		return -ENOMEM;
 	}
-	if (*priv_data_offset + svm_priv_data_size > max_priv_data_size) {
-		ret = -EINVAL;
-		goto exit;
-	}
 
 	ret = copy_from_user(&criu_svm_md->data, user_priv_ptr + *priv_data_offset,
 			     svm_priv_data_size);
-- 
2.34.1

