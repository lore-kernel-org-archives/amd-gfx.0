Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987CECD98E4
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 12:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B7CA10E713;
	Wed, 17 Jun 2026 12:51:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EuTsTb/a";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011051.outbound.protection.outlook.com
 [40.93.194.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C89710E713
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzjufMhi+XoFzN4l/etwf7DPgZB9ZGpbhcWbszi55tadkDonSB6FYqhUAVclEkgryqeYcMmL9pBBErkhpl5Q+YV/cgBQy1NiCz3KCtBU0057QtwTXCdZrb04EPhDI2kh10+qVhBbZ1obdMAdLXsOEU0Wr0eiCRYqxd4Ol76SCYa6c3JiDeBTZFB5i9PxLFsQJe+1qsSUi8y3b1tlPLTvpD1nAFSqeaz9sAI8qzxA90hrImOrGK4kIlRJC6Pn2EdxILsHBqYPFbzvK4Cn0cW4NrHtUH/k876/SZ3ajTD6bUmqKsJaSACGvbBA2+JFZJOZZdfAiew3dC8Jw1pItbp/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w560zQ1Xlv7wMoKJqmxuPVMwCAfHteyTgn2MLIvW08E=;
 b=IzGxzWTXSktpsEY7bSNQTDflb368bugnDD/9EF/KyQG3kEqMuuFjH6g0oxEm9gRmV8NeCHjVhtAdGRIKng7faQlaz/g7Z+j0RqdcIh8q+RkDEFKwOR/aLKCHsrR2R0v+tmaZD5PumaqgSLNh1/kaU63ovYDxT0zNFikPMzTlszurjQDYZNUs43iWs1cY06FiT+DCbPuvTSF6zirUgg5L+IKp0eSRaf7uFZchVbKDIcV30igMgJxvv5gJRfoqVGIOSd2OkaXZ6ViAEfMLUe9EBTl5NKseBrxBMrdgFEtez7yzcf/zmjnjrzlYwKzH0CfoGCJnpCU/5hoKx9vTSaJ7Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w560zQ1Xlv7wMoKJqmxuPVMwCAfHteyTgn2MLIvW08E=;
 b=EuTsTb/axSRDAKlGRjYJLT+waDu839Fv/jYsiHi4lvuYaXiBzBhZZR5Vc5Md6ZtpwsyOm1Xz8XRTOIRDyrWh9lVeAmcfdKXCJSREI/82zXwu0JBHgBTC632wOU7JQBOMaKfoTpjwhlTkRwOerNhm7GaFSR85iz9/2z9RHsgr17I=
Received: from BY3PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:39a::29)
 by PH7PR12MB7455.namprd12.prod.outlook.com (2603:10b6:510:20e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 12:51:44 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::8d) by BY3PR03CA0024.outlook.office365.com
 (2603:10b6:a03:39a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 12:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 12:51:44 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 07:51:42 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: drop executable permission from the CSA
 mapping
Date: Wed, 17 Jun 2026 20:51:18 +0800
Message-ID: <20260617125121.1838486-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: eb272d61-1523-4a48-0cc1-08decc6f2f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: g5vt6JMiPLk6vL5UWqALDq1Tg+eBiwbOWCOi7/uGGS6kwddY7l6qi0IrKYHe096kUQXQGJhFhbaEjEGiKbxpD7g39ZmEf9rloefWJZLlrFKYDpl9dwuZ+uK5IRej/PGiR5+uEuj8XzzNAV4aBNPONVl6yhHvIOxr/pGHShhj2NCuf0RQKT4dTdO8ngBJ4wlTyLAwgKQWiGg7ZoJnX+SAe7qJ5YewxMRNA31prfkCQXjavnPld8QZ01vdEdkSBuRMfAigU6NymxFJr5B+YEiQBJyN3wJRrBfceax9C/MIr1bcG+yxXb60zX9Cc3FeMJCcwiuy2ZNmd5dq1yaBbPdmVROfoh12Pc1r6VKqnbAwxYJUAV0MoRYRuSRH/tWwoQFFywWeIjRztljfhE7WpNY2ZTNMxdj3D8IzKf8TpUnXfNxPNeJIBqqBER1gssNM2DT7w46EYpHmS3feBB4/7w8F+7pU4WLrw02E7sUhu8fWSPAaT2yTG4xWyAMOgw+xD2p64bvN/aF34gcSAkhv9r9l3GqfQeoc5ey94/wos46vA5auyUUyg4LCyHTsImpDwYM+qRLYEaNwdC6Ow4J4l5Asqso6FWoPHXvC4pv3EHOh20HLccPMq9+sBzUwoCHJLObPw27nuM6alYV/yF6s49UZ2g8EFTjAHl8kqt6ArAdr6PV3CAVdvNeDHJQSs1yy/gzWVKPoHJ0uM1dj5OGGxEX13SAkYaT5lkAQGuzy6kmAaiM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ++Aj/ickK3qKpZhv9V02BJiZ2gDR+6oylT8+ml45L4HGcndYcLWV9oRrnJqh/PVq8TrpulzqExv7ciS86nT6TpGGPZhMczsE2TS2Eq5oXe759Zrl3C2NWkXXNmw9ghewg9W9DQCQW8551Uu4jcX7PsBhxVAzJnwqU2+gWdLlNky+ILN71EFM4RLdhxPtU0ER2aita8GwIhLpG66J/dr80cypfkjlNotzgKPXYCWY8FUBKmfDyj0v0ipmKJ679JKlfcRlTZJNdoOszPUUjNWh93bkvbJbTfvwQ9yrr8ao5CLQP6qa5Hfi0w4Z/wP3v/KwfFqumYm+ayjN7Sr3W+IhX6bzZ/WbHqq7hqRX6yoMT+YMk6VKyqUwptCmj1OCTj8ZoL7gTkPnK6I+qyShuPKCyqEhtw544RHiUkxoKrh2CrML3P5sMxotPlGpGl2Zz2WF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 12:51:44.0600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb272d61-1523-4a48-0cc1-08decc6f2f67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455
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

The Context Save Area only ever holds CP preemption/resume (CE/DE)
metadata; it never contains shader code that the GPU needs to fetch and
execute. Mapping it executable in the process GPUVM is therefore
unnecessary and needlessly widens the attack surface of a GPU-writeable
buffer.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index 7b46bffb10ccb..814cb9e903586 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -93,8 +93,7 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	r = amdgpu_vm_bo_map(adev, *bo_va, csa_addr, 0, size,
-			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
-			     AMDGPU_PTE_EXECUTABLE);
+			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE);
 
 	if (r) {
 		drm_err(adev_to_drm(adev),
-- 
2.34.1

