Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39166C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 15:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06EDF60EE5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 15:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 06EDF60EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF6446E523;
	Mon, 11 Oct 2021 15:02:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05D4C6E523
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 15:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKXGnt45GpxG5uM+jYSBvBASYCt3dGjIVegLVt7x4TWq6smzWZBvX5OwCT1sGujC13dcAwodOz8D8sB1zvZHbTtiOFYR2RACTNnbF8vx94t2XlPsMrd1AlMmmaOw1O5x0LeK3Ylm++ueew5l5BuT6MWOzawQgu5d56bexHdURxStpzxOyRUMebbyD0byVHMtl2NaMfB5B12vvC9jAArVS2raJObg9tG3qVtiB5MBXSVT71PCKYEBry+8fwg94vwjlGLpoLIJd1sWrsLAnYCJxM3IFzazxxBz4uap2EO2ChjSJhfj3KPLE1tbPcDlLpYv+qNar6QS11PIgjGYX3SyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Y+/vcAWLdplFpTZYDgMrnYX/70eBfn2MBGWYEdinbU=;
 b=AjYDPZ1UoNR6QXo14Wd0eIzhpAWbPqcfk2i7CcNTE/ri14W0C3QTEfDtGjRJNs9yIDcCozBfE8mrwWhl7uw93sQ/TxwGg8NJZUmfhH1N64bsgK/yXKhutahhqSdphNRPFp5vvZ0KLoAGOFyj+6AJxREbdP+8JThsI7w/JrrGSdRbq6LL9erlEhQkkCvyuGAYhimSB4i98he5f3roYxTjZNiEzvKuSN/Lt3l3JlqEI0vdDKRyR4k925QP2njCRJ8OEX0kle/5q3Q5mxLdAyBVJVcHV3yePPXeFUxb3MIPnSWDYUG2MpkGlHo5S0aRpCydC5rI1A2r71+tMkH7U++DBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Y+/vcAWLdplFpTZYDgMrnYX/70eBfn2MBGWYEdinbU=;
 b=1w63u8nkycmInDT2iFhcKDX0kVyZLSUqVMc5CqCTjO1qLHxjP7LuVt64XQLBwYx+3DWuH+NQiVgvIjabBp6RtfaCW2LHcUqxIxhJM4aZUtJfdZ49NDWBCTD4/xi4ifCTYvDG6Rnq6p6fE62IKhPjR7+rY/B4SAhaeTF9rF6W+JU=
Received: from CO2PR05CA0001.namprd05.prod.outlook.com (2603:10b6:102:2::11)
 by MN2PR12MB3342.namprd12.prod.outlook.com (2603:10b6:208:c3::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 11 Oct
 2021 15:02:35 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::95) by CO2PR05CA0001.outlook.office365.com
 (2603:10b6:102:2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend
 Transport; Mon, 11 Oct 2021 15:02:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 15:02:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 10:02:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/5] drm/amdkfd: protect raven_device_info with
 KFD_SUPPORT_IOMMU_V2
Date: Mon, 11 Oct 2021 11:02:14 -0400
Message-ID: <20211011150217.165699-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211011150217.165699-1-alexander.deucher@amd.com>
References: <20211011150217.165699-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1591b2e-b565-4ef9-b305-08d98cc8283e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3342:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3342AA2FB8323AA42CCD3039F7B59@MN2PR12MB3342.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAB0fVcdfK+htCdPEMjuxb2U7L4aGPkHFoOmzI3ssesQwm9TvUp4sUahCwN6hb5/IFg5a8KpIwUpVw71GrDW2R26PlxlzfuX0KsJIe8UkImIKbaX7yLaVdflewe9TSHVAEB0GAPn4JglkwMFIBkdWgzPHo6EyKY7Du05ZLuvcgARmSP6/srqbbvQpnkXZwQzf5NWSYl1e4vI8KhGeysesjBIUK4sX9OB/XgV7Y/UFPkCuu93D29cZ+LrwBTjP+vyEBWtbOPaUu+rFio/ZmKroVXpFdee6lfIYG6U03M6E2FtoPmo/QawKrWkkhQh6lZqQmRUXkqHzL9CTHuSlr6OuDLd6n1tCslWjey5na5YVJPgKkr8bODs5+IKNgdWTrWnIVcCbRhNQBdtu0dAEsBEAHTyQnCsArxf00JcSrkCn7VnTA5xPWR/RbW5s3hZ1klpUOCIemb1mNSLes5PzaVEOg9FZvnZY3C0qr6leJJak+YGd+G8j7BxX9NanUfjGw5AI+4tKzvZJo//ZLyW0O6CVwfHaWY0BBfiA/HbAf1xvtrCsF5PvDnAetM3UYqhArOBr86oxrQ4RndhosqRpR0ETUv6iM+Sp1wDgEntyOeFtmjEc4EVqvXQrUtWpq59mKJ+cqU/WQsF5pFuS5nTe9w9RORILBhj1CnPUFb7v3wk5S7cGxSLokAvup73NMUQ+ROrdr3dI2h5sf8C6mX8v+hz+q2okTbgcvTZUq4gi5XvUAc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(186003)(426003)(36756003)(1076003)(2906002)(6916009)(356005)(81166007)(86362001)(70586007)(82310400003)(7696005)(336012)(8936002)(70206006)(4744005)(508600001)(2616005)(6666004)(8676002)(316002)(4326008)(5660300002)(47076005)(16526019)(36860700001)(26005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 15:02:34.4742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1591b2e-b565-4ef9-b305-08d98cc8283e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3342
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

raven_device_info is not used when KFD_SUPPORT_IOMMU_V2 is not
set.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 31e255ba15ed..c5387036a9c2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -93,7 +93,6 @@ static const struct kfd_device_info carrizo_device_info = {
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
-#endif
 
 static const struct kfd_device_info raven_device_info = {
 	.asic_family = CHIP_RAVEN,
@@ -113,6 +112,7 @@ static const struct kfd_device_info raven_device_info = {
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
+#endif
 
 #ifdef CONFIG_DRM_AMDGPU_CIK
 static const struct kfd_device_info hawaii_device_info = {
-- 
2.31.1

