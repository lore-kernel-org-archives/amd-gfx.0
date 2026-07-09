Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D5FC44501
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 06:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7E5910E58B;
	Thu,  9 Jul 2026 06:24:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fcljtq6u";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010058.outbound.protection.outlook.com
 [52.101.193.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E95710E58B
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 06:24:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1orKG7TxhyYKwz2jbrqzettFRvkrU3sjXmxnHcaVK18MpMfZUDDlAX0q/Ylkd8ZUXf54F29mGW21cptOtRyMfOk92Nnj6H2Ur6JTMtHhOOVPFKL4h6Ko2NonPPEsz72lu2rt7jG/iRgyMgO26eNe1rxG72d2iftI7oaAeXXKHMrWzXOtHhvIvQn+HiTGoibcSWKKxsE2NwhIVzD3z7W+p3KpnegplZbmp9d5zPsCSurhzpC4ueCGeoA67GLpUf4/yp1IVI8t4zbrBtnpRqJzhu+zPVGt/v3zh9XQPVUahgYv3revyr97aHqR9Tw0ETIigyJRHBDwvuKD+v5AapKFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKNcr4prjhOU/knQ9pt19qpmD/4v9WDetVHj691ERPw=;
 b=O4+3LSAyvI7CqwxawpO2QCzF1z5y1XAb2P5CvaIJHDMhG0gxg3VlU/654ZTgp/8DewT3rVDuA4h3mEZ4n8t1KOMTPV+EGF7EJPqjpbColUApwzy987ZcsAR9MzY3D9Ts+hvThuQBveG/e1zKprk+LRsWx4kdQh6N9xBw6t8usk2yxpxvvpMC/LW1DNiIgdEVc+PmSOJVaFFXQeLy4N6e6NGVMvDiFIwexHi6U0Y6WJhp3MubnnfGgZJl6fvV/mcNKDc15d9GXB1yfSwWoTvO0YeQgNsw1Kb1dL41hORGYUh4K86oowMqFvvYDjHAW6bKDoQYABfO3weGSZlBWtjKdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKNcr4prjhOU/knQ9pt19qpmD/4v9WDetVHj691ERPw=;
 b=fcljtq6uvXb8HAIVyeaOZsAwWURSCMyr1CEApnnIvKGVRKlMqqqcsdM4UZtouHwkR9sj7RR2l2+tqBvPbR3cbctiKsg2EdSEa2M11FND9F2+WZ+j8013maYW4Mvpc8F9OCuGNt8r0Ek2Ny3pzwu74wtgG74uu6GWx2QAQSYy4bg=
Received: from PH1PEPF00013306.namprd07.prod.outlook.com (2603:10b6:518:1::13)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 06:24:41 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2a01:111:f403:f912::4) by PH1PEPF00013306.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 06:24:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 06:24:40 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 01:24:38 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: use IP version check in sysfs creation
 conditional logic
Date: Thu, 9 Jul 2026 14:24:29 +0800
Message-ID: <20260709062429.1036266-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d49032a-f484-4d66-4995-08dedd82c26f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: xN9Hne5dO26LRPq5TM4fpF6G1KpeAGFbgk28Ic6DGGgYKKCr7e0n+pMdUApx1DdL/TI5jN/ehvs1b4yCRaJJEG1yqGMIjGvIThFPWPNbrDh61Inp2l4lC7z+hOR1jUx2AJaaG+6cq++mYCWSrRb5zX3Hk66PYPUHB0PyMFg7EEGTy8M+xKoaFb5uPZtGmMAYlUHALG94hT3kXTEoh4sJm54n+90FOZnb1F7iWVYxF1bYgfvAINA8AXer5uBc5a8ljEnxeYpNLwkeuRgBWC6UhCuL1Qh6JQPAE0UruIpXlAjL0IEd6RQ3zDMzJDLd8C9Vvbv2Ys2y/kYn0buABcVesP8m1aqG1WVOpCFthE1EKQ7wghhFSGvPupmaP0EnGQIAUPrIsfAiY08gPI5sAsyQci5MQjFO9aP832KKaKEER5LYNXKLPLoog6JaXRMza4U9gQgpH5kNzRiVhAvCMcqpGMfhRJ5VV6p+qUcZKbVbD7HrJJxuAblDRsrHLOhr2vS1ZExgNy1U23JLPVOgDjva4ZZ53dAeH8qic44LEuo9v2UXk0wjm46W1K67OIMzz159TN0z1Eu8JZIiQUvHavxKEWfyPKRGqFs7EjACIr38eBY3f64QtguSTCA9vsZN1m1MFFLhz9aIA8ackDDt3NHTm0jLdBty4MCPMDE+V90KE8OiflB0FWDVb+9IIPAGTTFn2Txwqn4iELXfQd5kImOEEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1cbGJriFrSAItDYTF53q19EKS3hl/jHPKD9y8iYT1Qvlr72XF2I+ORnWtjMS90TzDLLROyF+3UP83EOhuOt1oaoXTMEMg8sTmMzLzEThY8bekIeYNfEH6jyzAj3xNhn3xF2uNcGKxMFh5Ba+heepS8fLvUHl7qXtPMelXUtY7Zdrw+KzsuIIDawGof7up37+iv4Vw8exFzDFgfPvd1l6DKHS7ietDOdbXX8Q2UDVHbLGHZsAgufZtZBlnPiVD+Tcc2AJWkngLuYx8M10j9W3rYlOyNJOQHNOwOUDCBfUt8O+mbseO8Q0Uz984jUXlzpgcdLgnQHVJuH9fmcJHlYptGqAApNkEf9kW3V64naiutX5oZztvyF4htwTE5BQ28J9bM5oE9oK2zatrmliO8Wc7sFLXpUgJ/DICRqVh/T8C20wSOWda+wnc+fXceiSr5Ov
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:24:40.9882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d49032a-f484-4d66-4995-08dedd82c26f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967
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

avoid sysfs node creation faults when performing NPS mode switching

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0183b2622d50..631afb5c10b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3788,9 +3788,11 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 			goto cleanup;
 	}
 
-	if (amdgpu_uniras_enabled(adev) || (ras_obj->hw_ops &&
-	    (ras_obj->hw_ops->query_ras_error_count ||
-	     ras_obj->hw_ops->query_ras_error_status))) {
+	if ((ras_obj->hw_ops && (ras_obj->hw_ops->query_ras_error_count ||
+	     ras_obj->hw_ops->query_ras_error_status)) ||
+	     amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14) ||
+	     amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
+	     amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) {
 		r = amdgpu_ras_sysfs_create(adev, ras_block);
 		if (r)
 			goto interrupt;
-- 
2.34.1

