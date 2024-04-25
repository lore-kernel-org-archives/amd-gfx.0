Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F36C19F4F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 09:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68A2111A333;
	Thu, 25 Apr 2024 09:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kTSDQhok";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0391B11A33B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 09:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkIM2IlILJK33HqJjj7vZy8yllL8TZ4e/x5MCSz3T5a+irpqCAzUi+Twu+Ge8ipW8LYYSDnFwnOwFIgw/vLOvLMhQxAaxkgbwvHgDWkDzOBn3WQmPxZVgG3ZxoJoLESgHzpfGlWd8E1I/WjmH+jEU7aCcuK5WPsq/WaM3ouRWYa5nEURhoWCTGR7u8YBsG9O6saM/J2WGNqcb+aOewJAJMLX0jeixjJ03jtQwre9PJRwAqA/pWmJH6INu6BltExFOuNVN35iFS02XirU1T4oW0aVF/eS98naMgIfDoZoDgQXz5tV9t29U3kAY9tz9HfrHiEW65SgFRfDIAxxOs44VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1e6zojqFM91ucY4TfXJn1lHfD+zJjnhC3t6HBcVhWQ=;
 b=A7Ioa6F8sQOODjVu3itnjc7WW8XNbYokzSJtsf2O6JpFH+m8MFu1CdkqrRGKh8rxkyYDbnV4rESoG3H+0eR2n6VreK2fHNzCxBIRdcU9qxHRovgvuVExnKUuSw9oyPXhlZgHjYcILHy3g650mmIaf9rn1IBMjysgZBGVx0CE6d98J0B54A9ps89ARAcnhLhvy7TfwtgBqCN/xSzFlCmBuDOrllNhENE92U3O+gOs5XcPwbJIIRvFSidtjKrybBDxnNvCXQiTnk8qTFsxsSdPShU5FT2lrw1iGj8s2QbvNJ3HzHnLqmvwKecLI23WqJUuTvtsWzOiYskXIYOjeJO2LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1e6zojqFM91ucY4TfXJn1lHfD+zJjnhC3t6HBcVhWQ=;
 b=kTSDQhokLKSZ1KzjkPD/ZqsXiZoEqGqzpE8WgDslbOldNM89LRmWFeuDxH7pD//pk1v5UfQXw/0nH2B7zGdi+Q1Pn8hx2ItgPmMFE7oXAruCXMQeBdkjokjqrrHiXX/g4q7MSmucSTA67YZpiv3O9PZ5ud7oGUZdHDWXu5Q6uTA=
Received: from BN9P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::10)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Thu, 25 Apr
 2024 09:48:22 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::a7) by BN9P220CA0005.outlook.office365.com
 (2603:10b6:408:13e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.26 via Frontend
 Transport; Thu, 25 Apr 2024 09:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 09:48:21 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 04:48:19 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <Christian.Koenig@amd.com>, <Likun.Gao@amd.com>
CC: Jack Xiao <Jack.Xiao@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/mes11: adjust mes initialization sequence
Date: Thu, 25 Apr 2024 17:47:42 +0800
Message-ID: <20240425094743.134248-5-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425094743.134248-1-Jack.Xiao@amd.com>
References: <20240425094743.134248-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 6172b1fe-4080-4bac-2f71-08dc650cd7d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?btThcoXlYeHPW64Dg+iXchfyDG4wLaxj91R2ADZzHOTxglyEoDttuVwpuUz2?=
 =?us-ascii?Q?mAXB6dMyF2IbqbVNOn98Zec1bsSECus5frnBbEjyAgKj/QteTnQtYHdo/4i5?=
 =?us-ascii?Q?PzciIH1cpyHK1K3CTBz6HuLCEqBI5BgcaaMW4f/Fe4KqZbr9/2x9CfuyRYCw?=
 =?us-ascii?Q?LEroNCeWGvlAF6+C0BUD3KvNh/MvH3jfNrPuaw1I98kPXNXj4upGCL/eDuDf?=
 =?us-ascii?Q?dwaL4otJYMn+hUn3NLqjY5RFwZBykrADVfk8OhhpJc8TD5GU7vSLL0Ecz8X4?=
 =?us-ascii?Q?P9y5SUX0Pcr+W+yFrWR1CcWBYIamdz6HilhEKCMKmn8L+P+Ht4XrsjCXbBem?=
 =?us-ascii?Q?T0KI58T81rcwQYfvn5kA3srbWnUCvasTyk48M74HK38yDQOMq9wv++Wm2Mec?=
 =?us-ascii?Q?1VJSM0asvRo9Yst7Jt0jr4VxeH0suSpWbDKYJAxPKQiCYEnjOsWwnhafbaHf?=
 =?us-ascii?Q?IgiRgk8I80yt3TDJbXUT7nmuBoMC7EylCNZzYR749689N4UNgSzzcnLvp9Gq?=
 =?us-ascii?Q?KIJ1i1vX5+K/TyAMK7Woz984I6hV8mboogCg9Fl4ajHO2NgrqSaab5IFuq9a?=
 =?us-ascii?Q?Q1XdYPsMOJaiqSOHbSIGXdnE1+2KEzczaRya3CFFkun+CaJ3Et6tNy/Th4qz?=
 =?us-ascii?Q?zYH9592jsbLIxAUYjaFUuFFaiBn6UaYht7gdNLSznAj2aVKQus7CobogNYNG?=
 =?us-ascii?Q?zE8P3qLlEPBlfMaOOWaavcl57kt+cbS3Sg7UbaXL+CwQy57I/SMNwBJUsHim?=
 =?us-ascii?Q?yvRyNwFffPHqMYzcm79YkStmzT+GkoLa5lWtezXMxygfUHzODwwY6xIO9zXN?=
 =?us-ascii?Q?vs2zfb0AQp9wL2hh8cL41he9ZbvQH2RATNj0OZxGnECsv5ZQv1qi9jB0dODx?=
 =?us-ascii?Q?47At4cwih8FHXqCQThP+Ocjd063MO9Ixu/wRUeNab7U/wQqr6i6ru1Whe5QT?=
 =?us-ascii?Q?EYb/6IpUXNJYZ77JmDW+Wiia5OUDbFqCOVsD+rbr1q4tif4wiK55yzgg1rAW?=
 =?us-ascii?Q?k3+Qb+N15WR35IGZq42RwhcMIog1mxtAI5uUvkgRvPUgqx+J2ckqwWy7JVhT?=
 =?us-ascii?Q?DaNPk4vOLgHb3qfOOyflM0mu1NBNfbTPAz3FAOc0plSaE4PgovIs8ZXyYlYB?=
 =?us-ascii?Q?0nouRo/UCVg4V+8slA8bwMINRXDNLEH/2e1yD5llqVPFIRwu98YOkDmnxSwZ?=
 =?us-ascii?Q?zh2QITqUkGypSuZL7hujxLWiZDRi634oG9mlaZsYGaaD2tno4tOVE/r8YNZ3?=
 =?us-ascii?Q?8Guv4iExtUH9smvmFkh6Ld2xHQUAucuZLFIh2ZKWtPq1HEVkgAl/THflROLt?=
 =?us-ascii?Q?WT/NnBgXg8PFGB6HEA7e+m8hMkFPkFMRUdnWwljnvja3d+8a4Ka2/Y42SHpu?=
 =?us-ascii?Q?5chhgNBdAiE69G/EFCy2LThtpOcs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 09:48:21.4672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6172b1fe-4080-4bac-2f71-08dc650cd7d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181
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

Adjust mes queue initialization before kgq/kcq initialization
to enable mes mapping legacy queue.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 91e4e38b30c5..28a04f0f3541 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -52,7 +52,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_0_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_1_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_1_mes1.bin");
 
-
+static int mes_v11_0_hw_init(void *handle);
 static int mes_v11_0_hw_fini(void *handle);
 static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev);
 static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev);
@@ -1292,6 +1292,10 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev)
 	if (r)
 		goto failure;
 
+	r = mes_v11_0_hw_init(adev);
+	if (r)
+		goto failure;
+
 	return r;
 
 failure:
@@ -1321,6 +1325,9 @@ static int mes_v11_0_hw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (adev->mes.ring.sched.ready)
+		return 0;
+
 	if (!adev->enable_mes_kiq) {
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 			r = mes_v11_0_load_microcode(adev,
-- 
2.41.0

