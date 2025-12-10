Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB6AD3C526
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70D0A10E684;
	Wed, 10 Dec 2025 07:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eDuGO5xH";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010019.outbound.protection.outlook.com
 [40.93.198.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 432A010E683
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAcox6OKzq/sAzJLM16WfMeCez2Vpz9Z13FGFn7ZmOsvnGztt1N83i+nzRVrNrI8zNF9JKhLUY+uGThoVAmAgCZhnC6JiIEkCLIj5sMahFd/VB5Gbu6o+jiuGeJPEaCvQoLy6R7kyueuayGUTxcwlpC1+kqqAS298kLIvMiDIH4IrF0RrwkDEJV5uExrNHyUp1fY7gRYy/fmR78bGxaU4u3puHMEIpTzcPWZrXmcEm/BnQ+zOQDf+e+frXcoCYQQnn1UO8c90GJgCaaX+QdK7VNR5KbwR2ZAs19AUa/rhK1JCThA0sJyAXvXcFnIy7NmXBnXR+E+LfKzgSpj9rRXrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0z1UuYoD8FJR8dJrwyvPVI6HKmSkZJ16qJ0NWMIiz10=;
 b=R6vfHuWiCgdbGHGxDwj+a7mzagg4rRMR9beXc06c1m/weJGojixWLKuJOUead+pz+sxCbNElnE7otGX+f5oiHZ7xguhatLabbRw8zL9IRW4yc4eh4eTXAEKELlEdDdSssR4T8cB8bWn5N2h7rN6ZVw6Ki7PDKIDckabJaF2GHIOWpa4xOWNgF8TJ6RhrU5nZEWXV05nbFkAXri/iIDL4KLjRp4+gBqH7aXXMR3ezmGYNJwYCOp1wNCqcz4snn498UljouB0wSfD9HBLfZUT746T2RSCTD9+nfHTqxX+6DsMGmbXY+HsnP9OWzpYUWFT2eCR2prbi6zImto700SQWEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0z1UuYoD8FJR8dJrwyvPVI6HKmSkZJ16qJ0NWMIiz10=;
 b=eDuGO5xHGKyiC13zSAHLdyygTJD4XYatuOvAr8Wxlfx2jec1TjYrDJRNrbwGNe9qU0gIPoF4DT259JP3xBTOpO3yTx6eOlAg9armeOuHmS/raMRYi4MTv9RsOUR0/2Uc2UpqTQZXgVy517BVw3wZeUicqrVGg4lIP9EWllRGz2g=
Received: from SA9PR13CA0055.namprd13.prod.outlook.com (2603:10b6:806:22::30)
 by CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 07:14:31 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::77) by SA9PR13CA0055.outlook.office365.com
 (2603:10b6:806:22::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.5 via Frontend Transport; Wed,
 10 Dec 2025 07:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:31 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: init RS64_MEC_P2/P3_STACK for gfx12.1
Date: Wed, 10 Dec 2025 02:13:59 -0500
Message-ID: <20251210071415.19983-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210071415.19983-1-alexander.deucher@amd.com>
References: <20251210071415.19983-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CH1PR12MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: 4154482a-093b-47d2-e89a-08de37bbc381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9nKZoJJ0SWNosJKRhIBmwGboglJZMQQJy2fHnoI4WfMGrzMDr8IqX4Z26Dk7?=
 =?us-ascii?Q?rR1NA65tlfsrm9YflmRcBYIGk7ZaVmg8rsBWF2hyM3QzmJ03FGd0TkGzixxE?=
 =?us-ascii?Q?A0g2E/C4/4zPHZbvG/Ug+v2UwLDNjJ8XVk1qJ+++Mjzh7boziQ8sxBKRx9KX?=
 =?us-ascii?Q?xN4sAropRZOBCvjx9y2CvpGpECgBO0tYb3Y1o+umfRQwXmFf0mfFWDURuRku?=
 =?us-ascii?Q?gkMd3GJ3HwHKa1Xv9epB01V9Nd7gkqqsMLc7jB0Z29fG/KH96WceGkLEeGix?=
 =?us-ascii?Q?XGyxVvqJ82SiOt19guH/94CSnYtl6zLofuZbNNErNxGAepQPndztx7uVuzvi?=
 =?us-ascii?Q?O25QWiAHBoEO3QgYFJ0RwODS8p0wVgZO0s8EWsNWlTAtpO0twc+aa+ekjB2l?=
 =?us-ascii?Q?LhcpbAl5hTX1UQ6SKtUaLJeMeRLTY91ZvH6YuiM79QgnjrzH86qRNMxN50GZ?=
 =?us-ascii?Q?kpi4BpXHeubVMY6O0uSCQdjnDClh3sfYMBdmf6avJ8XzuUIqEQWhEA+aZ9KY?=
 =?us-ascii?Q?Z6g/Qa5bZrxvh/Iwabzd2FKOZDbQs8RKxvrLVwq/z0pXhAO6Tnt+pR1QGLhs?=
 =?us-ascii?Q?i2Ly/kJakYWfYz1L+4/Elc8glbvhO+X7qrZBtE+JRoLBNDBuD+LEQxk+cYke?=
 =?us-ascii?Q?Y8ZeOuGAfvbKCd4L98NN1Yxi3y7VmdhbKj4eJPpA1ggVWj5AEWnUKnOn6rkr?=
 =?us-ascii?Q?PHajCSvvvuQTkCwbJQrEf/DfhToBs+ENYdhrYR46NqMiS8leac9aU+I+bt6+?=
 =?us-ascii?Q?Z6ZSsdAzkl86PPdl8P/mdK0AMfyzWd9cFQurj2du1l+j2SqB+/Fdhit7cGTI?=
 =?us-ascii?Q?FfxEl2mIKYWF7qMnIzNItTY1emldwTJMxy7/R4X/uGZosDCGskqViXDcoh7W?=
 =?us-ascii?Q?L6bAhJn60kpbpn6YAZspWBJPjCS9a4Ub0p+syIcmM4Lnu7ys+nt/ao+WAHvj?=
 =?us-ascii?Q?e84Orxtf0L0FRZwwTQfuIFkdFkUERdmFZk30aKtZWJkLwtXrwi8ztTIFKV+w?=
 =?us-ascii?Q?vDnqXomDdRxIdQR4IsKQaXto5O7KZeZ9iDzm5uok58Ge9N6PZynEtsRdaKrM?=
 =?us-ascii?Q?Lc3fOqMJms6etMEzMAorSylCdha257jKWD0d9KaGI/Qf8bYZhOi0jpfT8B0X?=
 =?us-ascii?Q?WHoILKMbfNSqbtWJgBstxgAF21evXMAcmaDsP+OAx7m3oGFGvaDei/H1auH2?=
 =?us-ascii?Q?xEDnAZtfWt1neHXbOQOfB+Jf+2gYVMHOghyj/eDtaBTOsNASWtG0vo6MZneK?=
 =?us-ascii?Q?BYpzmZX6U3Y6NcHCX7noTiALggBKtcuKA7cBp3BJAktMFrs6Ec1MnK37nspc?=
 =?us-ascii?Q?MNejd4+1a+GcTAnYmT38a7p3ihDJfF7McL/EZ1rpVQ0OGKBfSteHMFeblbpD?=
 =?us-ascii?Q?vUM6ccDTjQcuH6n1tyPKg3IOoiWthEOKMs0fECTciKHg+mk30anc4oVJGaLj?=
 =?us-ascii?Q?vhooX1cywQ3lAQMveKgvoDW8G9qAtpcbzTfxNLlSAouiOPyK1vklcwxTMVgT?=
 =?us-ascii?Q?egnpHaoTesfi/cQqlrMKlw2hTjC40DPGuVX5qKvk0lXLzTQG8eXE5qRlvLPI?=
 =?us-ascii?Q?seWv2SM7O6QqelvJpmo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:31.1370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4154482a-093b-47d2-e89a-08de37bbc381
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623
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

From: Feifei Xu <Feifei.Xu@amd.com>

Add GFX12.1 MEC P2/P3 STACK firmware init.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index f5a7ccf9e02d5..c7f331f74b9b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -416,6 +416,8 @@ static int gfx_v12_1_init_microcode(struct amdgpu_device *adev)
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_MEC);
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_MEC_P0_STACK);
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_MEC_P1_STACK);
+	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_MEC_P2_STACK);
+	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO)
 		err = gfx_v12_1_init_toc_microcode(adev, ucode_prefix);
-- 
2.52.0

