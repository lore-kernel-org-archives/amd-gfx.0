Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E61C54E68
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 04:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FE8C10F027;
	Thu, 21 Mar 2024 04:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P78ZbYMz";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C962F10F027
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 04:59:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Urt7Px5I0eQg2Mw1gswSNPFeYcyWyvklH2TJCTQ3Lp/DgQfSy/LukzVIvQoa4BLaOw4H5TXF7IFK4ZDRbbvFmMapP4WeSwUk3SSfZ0R6TJiJqjv7/igVuLQKr0zHAxw0SgXvJkO76DSdRA5zGvhXls3vJ9yj0Z0rlmEGkCTg8GbM0CHsiItjrITnUh7Z/WvOo5WdaYEOd5GishDYNC4/9hOzg5VgubrzWkoprKgNgr04HUMI7Qi9yfBc4VQM+6abga/goNSh5Zhp9wsiX8bWnZ0WyuKTq6mYGf4NrCjapQBODJWp2Iq0Zm9w1KAi1ckIxx5fQfVxVSoXOQd/yUtl5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/NZ879rDFXS9q17vyXyHkVrRoTC6UragfFLDjzi7t8=;
 b=LGvT+pBuG8Ch0Hht+X0jShVxeTrW5GkCJDg1XK/RPtXghtvXi5tDegH87C33xbZYjqGCGdzWii6x9S354YJ1K6RP+6aA7wDwzQdJbg0Mh96cfxrX7Ns6Dkq5AwHwpSMhuK9G24FUxS4t6pJv3V6mOwc1WVNGSnNc4UJPTOnCA8SbWzi0pXNpLQ94GsDE89Yfevw1nGBWdfc73Hfj1LmKQD77HJYWAyBeT+ax+cxMdkCUESJAqvOlY8jyF9dEbgLpFiVLnLX9IwHtxw5+I5aM+x7PUShlpVF9QaYnALU5fRQfYJFxnq8e1A2eIueRIEhVl4aTNr5vV51HoiaeAE7G5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/NZ879rDFXS9q17vyXyHkVrRoTC6UragfFLDjzi7t8=;
 b=P78ZbYMzlgt6GaIfdC5xL/yPcMVn/su2lIc/psluX5k3o+IQFeTmwcSc4UBsDTmAkUW2kVCtZdI0JIOtNoTmiDOnjHYvQ80U8b5VAWyjfLwVYRrSbunYbRzP5wCiCXrT2h7GhcedseQ7Ikvk+t359zQJ7QKjfSdPs8vqXWRAIkM=
Received: from BN8PR16CA0006.namprd16.prod.outlook.com (2603:10b6:408:4c::19)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 04:59:47 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:4c:cafe::9) by BN8PR16CA0006.outlook.office365.com
 (2603:10b6:408:4c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Thu, 21 Mar 2024 04:59:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 04:59:47 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 23:59:45 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix format character cut-off issues in
 amdgpu_vcn_early_init()
Date: Thu, 21 Mar 2024 10:29:32 +0530
Message-ID: <20240321045932.3444080-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320084513.3026222-1-srinivasan.shanmugam@amd.com>
References: <20240320084513.3026222-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d8a168-da7d-409d-75d1-08dc4963bb38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ezSwIM75sb2HlY22zkK9Bb1EJ42t/+3BsHhI1snDXPkMSOzAHflT57Ddm5nsW1xKen6XNx4D1YNUfy1WTzO0Iog4iLW3GqbAMpWj6nczQZ7+Bftg3vKspDjaOIzHFgWhay3oavnKWRIc5QEiaC0wjPwwlSF8TevORjpmRN0JZqhIEwOrzAIpEhZHJhKIA0ZwmV3XnObY1yrjqjPtDI7w75F+anHmuGzqo6XRKsAkMh5RGj+1ajleoei3W5Yz5VHkTMmOul4VDI/ld1JSFmQaLi3AGUR2THc0zY3fqlu04sf6fiN8kTxZfDpONioU6IoT3sDYXBaf0LLGfnVHeK3CKx9PQn0/hDmhI5V1l5Qyqn6NpEbX1qLHDS+c89ygc5ZgoVmXyXJZGUwIszQttiOqYmm3dJTc7BGgzFlvqOAqXH5g1INbjXlf3zh1oF+Tat/Ow+kPerh9AZR52Xc2EuMVCM/xJM5qgh57BKTZE5X0gzEIOjQT8Lcn3+aof+h9qElXJAM7FlBWxSK9qJEJ/uWnvYCHqZqoo/LVxI+wbHC3qyF8goX4YTH2xg61P0e7DfNeaa+ZQimJmuzz5lLheC5xn9SLPqIN9mKRZ8HeD+Q7qCq8S5f9AeeAwyH4VA//A0yIAaUAKxtIfyX79oSoGjLE08IhFuhPcJsdBDhmZgoQZaoJoZKmjlIr6tvGSHvqpH9ruRIiqAZ+MBcXh8VQN7bN1Uc1FcI7llTp7FdQQj6EukynAvqjnga3JskgonGrmPHz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 04:59:47.0928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d8a168-da7d-409d-75d1-08dc4963bb38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508
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

Reducing the size of ucode_prefix to 25 in the amdgpu_vcn_early_init
function. This would ensure that the total number of characters being
written into fw_name does not exceed its size of 40.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c: In function ‘amdgpu_vcn_early_init’:
drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:66: warning: ‘snprintf’ output may be truncated before the last format character [-Wformat-truncation=]
  102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |                                                                  ^
drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:17: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 40
  102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:66: warning: ‘snprintf’ output may be truncated before the last format character [-Wformat-truncation=]
  102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |                                                                  ^
drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:17: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 40
  102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:105:73: warning: ‘.bin’ directive output may be truncated writing 4 bytes into a region of size between 2 and 31 [-Wformat-truncation=]
  105 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_%d.bin", ucode_prefix, i);
      |                                                                         ^~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:105:25: note: ‘snprintf’ output between 14 and 43 bytes into a destination of size 40
  105 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_%d.bin", ucode_prefix, i);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
   - Reduced ucode_prefix instead of changing fw_name (Lijo)
   - updated commit message

 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 9c514a606a2f..bb85772b1374 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -93,7 +93,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 
 int amdgpu_vcn_early_init(struct amdgpu_device *adev)
 {
-	char ucode_prefix[30];
+	char ucode_prefix[25];
 	char fw_name[40];
 	int r, i;
 
-- 
2.34.1

