Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD821103E2EB
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 13:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F3810EA05;
	Thu, 12 Mar 2026 13:44:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NT+FyAMI";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013064.outbound.protection.outlook.com
 [40.93.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C502F10EA05
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 13:44:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/QNTI6YS92RxCaScTwXACsjRFYxm9uvVgLP8eeDrin6I9kHLIKn7S3SczIwhGNA5RCm3tOpoMj4gcGOfZiNn4Cm1Ln0IzME3udH3iVoCOU6HqGF4ZAb9+SCqMHCSpa79i8qRPoLEj0t6Fn1R7RuMtea8eIpYc2oeO9B7eUZhbkynwM/q9dxzxJ7DcRLxoGpcbDVlKodCv1CyLTTe1Puyjs7j7MyLvVxjlbKYxiPaZGgqCDrN5+Gp5U2qW/E6jl/wagqscT8TRicK/lcWm17f6bS2OKdrmfo4f1mqV01mEmMIAwyTnHbFgy9JuYcqiChv3vqOpwGumwb7Yi97uX9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkfnUOyTUfPGNTgIdoch/oYkf87hrSR2NwFJM1B6KI4=;
 b=GRkJyZw1C+KFbfrVfP6p0uXkTSIwn2S59Bn+QfVRP5th+XNk+Km9pMbUmvAcYlsJl3TIFgqICb3fikeaWUsyOJLOJkhcNFYFLcljqPWFtYRLjL9pht/oOdwZgjwUHUhy7TcVr/3YwtbnaYGf0IFMFcoMURl2ku7M9/QOLo75If4ugVMZhMmzT5T0z4V5DA1NGTbSMZVNT/6T6BVm/MKdtX7LCeEwqBtbqIrHT5Wi0G/vKz0gk/A1QctfTs2C11xc4AVf42Lkpg8Uk7Tk8jHcGAEbaQvCVDBx8nKVpEsbKJ3sMS/2G4YGDSXOsIWYYOj/7QH6HVmtZY27E4PhFtjVgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkfnUOyTUfPGNTgIdoch/oYkf87hrSR2NwFJM1B6KI4=;
 b=NT+FyAMIbFi3IDaH7wnIuB3ur/Z9dOvdicMIHY1KgUd2UqhUHNNCqZEobomg9YpjByVI7rM+UAfoyC30ONFPAMLmw6De7012rNKtmXrqGwdCoskfmuTkJiuSr969ndeR+X1w/oElkOv0A5gfHLgiWmCMuZjOxviyfgv3rqeLvxU=
Received: from PH5P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::7)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 13:44:50 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:510:34a:cafe::25) by PH5P220CA0006.outlook.office365.com
 (2603:10b6:510:34a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend Transport; Thu,
 12 Mar 2026 13:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Thu, 12 Mar 2026 13:44:49 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 12 Mar 2026 08:44:47 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amdgpu: Make amdgpu_dma_buf_attach() return paths
 consistent
Date: Thu, 12 Mar 2026 19:14:15 +0530
Message-ID: <20260312134415.1839742-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: abc1025d-634c-499a-92b7-08de803d8832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Vu4IxT4BcYABup2PCkBqb1COcxuZIywcLfG/JVfqObm/lqmkw7r86gAoMCtNXWpM6oB5Q5tsm422uH8S6TW7nkKyctT3ixGolv426WEC+PW8rE4L4CwuvnDyWEql93C1HwX5LN4pGhXqbABIlPgaw2cHAdfad8viTiXgKjof5/hWWIo190fyrVwW8LVtOrQTO9HayIRDVS6myYBhGdICMD8op5mYBpV149FBCfU2GeZXijrST5bGtYCP9Fa39D4VueQbl1T+js2smnTTA1JVzdfavPtervXteILN26dtA+zMOdMOXT8kBQeBMd6FaUgsQ5oLzbLgz5iUWUC7m2hE3ja5j9OKRUOrVK0rL216SGnkUdWPhaAjKtH3f5DcdY2qwLN4j/crJHE1IS3qmF+MwZ6Pr5jO+1w26/h0DbuUYJb5GG7N6tVbRcev1XKOxA+JFYDLyNQvLLGaX7OMkXza1Kyx6eZNQx6mV/eQ2lNwmBgqfK4FO3FbBemILUEKlehsrToOOIjMvquUZZq67vcLYXitmXMzF/NuZeQkpdGNoGClcNKZYpqxjStCWPCc87XKyNsHmk4CsfUgPp52C2eKVNe0Rz3ZfCSVGpf+QeUTnmiyCP1/DkxOExtQXHeRRwCdgnIUKDvmS3Cvr+X/cf0RNT/KTEyvUnoFE0kOK5WNq/SxKUTVUnA3BMzpjE9G0Il8NlgOKJ/ArpT7lnrYHOmjjGDIhHnNcqqBK3qlmfQ2hGdmT1dS0l/nrUMsjhuphl2tS3Eir48bteSosHDoNVDIkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LrTrk+7sXvUMOdwT2gH2OmbMEVwyUbL1vj/58wwS3nwcBWLhImHXKoQir8G3NINbAuouGI8Ba8CKFbRb8hDnYNLQeftQpBGo8rFh+x9dVZaRsJ0ZIjeAujjBAN/bRKf5+vdfbzYBOo2cVwoTanO7a0Y+O0gn63hqGPy9r3WjE3HRldtteqqJG+YfRViJuFR27NKMzuqdZQW2sqfavj1QajT6Wwqu6JmtkPpfWzMawqiRJJc/Jacb6J0zrIOQBQcz7CUbFcS1vbuX458CIHx0p9RbYiF/vQY1+0HI2ay3YPMkfZxlSkKAF43gdDPmNqSlpmfLLDT+8dgNczvln3e95EFZl+7ysQzGAKRfhMeqdQnXYq6KTcPhEpqHV0XdVjlgErONNwKWzuXgBnXGJiJhDSQa84jHmgE7w2Orb0zoN7Qz/UDNAeRZ2Uw+p0hwCsEc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 13:44:49.8196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc1025d-634c-499a-92b7-08de803d8832
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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

amdgpu_dma_buf_attach() locks bo->tbo.base.resv before updating the BO
sharing state and unlocks it before returning.

Return the local status variable after the unlock so the function has a
single consistent success return path, which avoids the Smatch warning
about inconsistent reservation lock handling.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:111 amdgpu_dma_buf_attach() warn: inconsistent returns 'bo->tbo.base.resv'.

Fixes: 6e6db2722c28 ("drm/amdgpu: add independent DMA-buf export v8")
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 656c267dbe58..9cf240ad5471 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -108,7 +108,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 
 	dma_resv_unlock(bo->tbo.base.resv);
 
-	return 0;
+	return r;
 }
 
 /**
-- 
2.34.1

