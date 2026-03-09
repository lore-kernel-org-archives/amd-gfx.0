Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31FCF417EE
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB6E10E526;
	Mon,  9 Mar 2026 14:57:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="me73qdUh";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8266110E526
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:57:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIkVOwjSLDiofgtCVwEkGM7AV1+OaSn6X2b2AXXkGrRh5J/nnpdsreDTTFglcX1F7tqTOJbzd3TqeZUmjR8CNxKVNKVBcw9mYvwabD+0pAe6387XGCYtIPvoR8VKE7mzTpNuREI10m20kTYQK7yY5ynlP7tOlmGMX5b4hdoxkYki0ZTXok7y7XVXWakn9iiGjORKUZOpIcX6r+KeTPx+83S7OyJ1BGpmuJ9OPd0KDG/KUtxQMJxEqGhaa9GYJHFBuxXWTuAb9eMVRjnDHxgQTegDY0BLSdoTjTPV8qKOugJZiyl4cI/U0r8Rz52BrlLR7NZ8VM1eVzVI/bQlZhOVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2xIbA94zI7HSgpzrFrBO/EBY/qi8/yOmFUVN2b+i60=;
 b=u6f1VIedb9m0lPvcj47tG1sc62lWa/RBNYfE3AVhmFT7YaJWNiAFz6jQxP7YjA0hBinlE5D3tvGwHoRgNZvaD67wOQGLMyGRWdLyKqaMiZfYqLqK3ybk6wTGQ5w9TMRQULaN5AFJuaHif9RXYDw2lmVbDmSxPYi15oNzMGsY6skLFj3kId3Nfo2CJQxenTwRLCWdO+GYJ1Ucj7wHCj7CP6W9m7oP9eNGYplNSeD38FUDHqGzVVnmwtqzgt3rpmbdbDec5jMCXHSAlwRXjt2ldywj4f5yP1C0vo9xfVBs+eFX+JHXt7V/6MofyDLE0Z1BV+UgGJ/aHM/ouu7vO+sJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2xIbA94zI7HSgpzrFrBO/EBY/qi8/yOmFUVN2b+i60=;
 b=me73qdUhGP9VVjZa6kyVKkzusrR8WqIXzMi6n3oauvZXFRTBVtO0Ffdpp00HL1Xutu0OtsgiTxl5nqAz2IR2+6SrSxTCXfx0ESFY8/HPBPAaACVfoPPkbW1yq2g7aDX5LN5qmKKothpf2mKXliCCuvi9uc379muexk1CLycWUGk=
Received: from BY3PR10CA0004.namprd10.prod.outlook.com (2603:10b6:a03:255::9)
 by LV3PR12MB9268.namprd12.prod.outlook.com (2603:10b6:408:216::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 14:57:12 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::ab) by BY3PR10CA0004.outlook.office365.com
 (2603:10b6:a03:255::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 14:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:57:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:56:48 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:56:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gmc12: Query host-gpu interface
Date: Mon, 9 Mar 2026 10:56:24 -0400
Message-ID: <20260309145629.2844495-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145629.2844495-1-alexander.deucher@amd.com>
References: <20260309145629.2844495-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|LV3PR12MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: f38ba177-6358-4193-01ed-08de7dec2323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016; 
X-Microsoft-Antispam-Message-Info: C3MU/MThC1LzSfKQRcda8IW8hHeFtVqB3b/6OmCKX93XPJAgo6Qb5RqShL7PVS/jZcfx5a0ylH655cQGhm9RDiW30AQAgT0Xba95izAoweMwB9CrAr24qUI4DPJFtLb6hkTUJ0/cNdc1WyrTEBVbPikxBl13WwIyrmDzrmWwzQc2Liy5d141k05A971w8ciA/G4MKFRHOSIGFe4J4F8+/UGFSm0TxdghIy8zu8l9NpR1gUuOFM9j1E4kJjeU3l+K18R3jQSpdAy3Ba2K+mWFvnEiUWj9iRXv/7+Meoun9Q47A/Ve7Tb4stUBEiKxSFp6MiNDf48ykPcpyDc0VWZ5LgIusi1O1VZtmV8Mnjfr58geXynjaQmF4i6eRzETs1Mz/f5KL4jG1MaFkzgZmtBBQsQADkJW4zowFWGzDCo0WAXW9RkNILC/9+u53Il1yFb0jNnYcJKf7mN4JxkDK00H+TdOGqpX6c0EgZo+SrLHmy+Uc+9AJYjbqNN/o83DFXRSPFhBeJEBALi8JxUBe5eoO1gjIhE69dHZokG6Kz0RQ2561RuYhXnRZ0QPSE/CdB9huqsyc4DdMCzTwxq9RJpx4OXT3jKJw3tJxK6GF8pTD75jX7RmsBrRSH6HblGY2PNU3conkL4h/u6HhqJ6wPQhtCrm4JOiUU3NUc2v3CxWVuUvt92/DAvET9g6INhY6KPkmjnDkJ2h3jRqpQ/0dGDz+e6rizu6sb/YXeP7IHcVemWnWocaARS51LH+RPjUo+4kUM1r9fM2AlX7AHhUZgFP0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZQpNuJKeaYNkEdTNMe8XQoJnHY6n/GzJmQ7XIHWQN9tmYwk6B79MC2ZxdmNQ7KNiOWbBu0JPF9NaGXNJRd70XglDBB14xIeKeBCPhvSMK8r0tYVbx5xkYbobgp09pqa7M0f0SdfTkCeK7wVVEnXW0O+ZWjIv1GkRU6YrDANIs8NIiAM3v6UO5tKvWNG1B4A59B078OyE7YWPgxRUVgdKp2f9BG0muY2Y+EBVzKK9aYjx+koM1czo5eMcL8KmYCta31JK8Wc1hW1/IumnfUcieVOk2J+nvKtIKqJzVFa5VN9Dql44aeVuWlyQAdjz0TduRmVg7gfz+jG2uOPTXaSRuvI5Kw8NsAeJINMCNT9rL6K590cieEs8H9hYhJi/fAVGeDeZcVdUCrlCofA2V/LdbNeZlaUVApmKhVoVdQRKS5dh3ItHGldg2qpqPQ63hLLF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:57:08.5549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f38ba177-6358-4193-01ed-08de7dec2323
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9268
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Query host-gpu interconnect type for gmc v12 devices

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index ac0536be0f90c..0e47268100ff9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -636,6 +636,10 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	if (adev->smuio.funcs &&
+	    adev->smuio.funcs->is_host_gpu_xgmi_supported)
+		adev->smuio.funcs->is_host_gpu_xgmi_supported(adev);
+
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 1, 0):
 		gmc_v12_1_set_gmc_funcs(adev);
-- 
2.53.0

