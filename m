Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3E5C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 14:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA5F6EE5D;
	Mon, 29 Nov 2021 14:05:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48D316EE5D
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 14:05:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYARf/ay9oLEL5rVOjkgJ3UVij80fjlGVY34c4m8vRQxTw4PQp0094mwLRLFEUBefjKq+niESpACs8V5LtkVnTqtYreDWHiVkO3pkDEeSkqdXCOv3j6UZVDFu6B4nJxEWTn6dFsFpaRbSePHyCtN7u/UkV9ojNNpvHgU9d4BMj3sLQaVZDML6WVSAiy8Yc4UzKigz2a1Dn3NCkugfXSewidFSff+I4P5/tE46yrJSjqlV5DgZ4g140VMUIxpbNtsCPRviIJf/vq1YjwcuNZ2uPD4SIbLF1+ecYqFUqOtPavyB9c7a1ye4/CVA/VdRqtTaj6MItTbfES4IZLwvZOndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAisqI5IUwTp7kjz/tSfKINC5pXnSW10KQ1vjBxCURI=;
 b=ZqdRpwHpL9ar0et6EyWNsCu0n3IISZ0usvbkSR1CP0zIUgVokBVsIFzWFlaCjHd4ewhRnZoPFufkMpG25vgwDDDqBd08naVI/uL+uNNyTS6nIylAoGmWcCvc1CKoorbwSD2g+X86w432RGK7NOwuMvr407PYTbKqELRiWxjbj96eWc8QutTez2IZZPDKTDDrqCBTCT6MH5DtnG4zCDlWN1gKy+M3nba3/ZB7O61QhGm5eN3kpTOwtAnoSlVJvqamACrXUqW19605iIiiPmweqjYUhR9+Z9mNqrDUHZebSMz0kEtwimN/Xq+F1ZYqS6O2z3QgUVS9C/v0lY6+kRsvsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAisqI5IUwTp7kjz/tSfKINC5pXnSW10KQ1vjBxCURI=;
 b=0xsVpSYj36NyLYmNrMmkACy47yPIoAJ1eD3d+gMDpwVnF62CcetwDW/IiyOCPRrOos5IzzjetZUK5RzG36mdpLjOxYIEb0kxgRpiJMfeiCJaUjfIgaDITRTzwv4etibKNFIsqKMOAE7wbxOvqdVj+f5Uu+cyF1Zpn+LwItugz2c=
Received: from DS7PR03CA0154.namprd03.prod.outlook.com (2603:10b6:5:3b2::9) by
 MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Mon, 29 Nov 2021 14:05:34 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::dd) by DS7PR03CA0154.outlook.office365.com
 (2603:10b6:5:3b2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Mon, 29 Nov 2021 14:05:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 14:05:34 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 29 Nov
 2021 08:05:32 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: set "r = 0" explicitly before goto
Date: Mon, 29 Nov 2021 09:05:19 -0500
Message-ID: <20211129140519.18202-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211126184221.17598-1-Philip.Yang@amd.com>
References: <20211126184221.17598-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cd12a69-2252-4f44-f81b-08d9b3414fc5
X-MS-TrafficTypeDiagnostic: MW3PR12MB4411:
X-Microsoft-Antispam-PRVS: <MW3PR12MB441166A59BC2D25BCF052F79E6669@MW3PR12MB4411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2l5o4IEObgYsPHCkYp42Jk7BiLPDl//3mdH5uLnurjkVimpYgE9AFGxwigz/FU28FOtLp7vDNAat2NRpswLo5LCx75UjQamYkwV0Hne2WicsqcDrcX4pX3QFPHSbGKXN5vqxgzYuIyCCEWmKIP2u1Fj9Etiz1iPNd3QFjOs+eCJ2i15oZAJRR9+IjG20p3uC5JJwfe8ZrpEUFpp/YbGHaTMVfZEX0khbVFD6hqCnOKN3cjhpnESZ4hXozNRViHKmVGsTXenloMemrUODoLYsFM359L7dXCUgI94NMvbyOELy5f7IHI1tKXyyU/4OVXXdcPQx0L/WvjJvSvbrEPZHDneGwsbjcDdXL32sgVDZEe4JddY5wDOUiwLXrJKmB+iz8VbbYwPAy7kYnHyB+IvH0ikYNxssiOGCmleXgG7tkk8DUqLA5yTOFJm8erCtAc0iHXnsuZ+PfcDJZLfp9Wdb7RVmSPi5WTHIINCoIcUWVpbs614Sj8hcvcW7gx9qqHT18O+3tX7iED5PiNX7bTJ+fR5kXJv8uuLxqh7TBq08ArAMYcGjVnu9BmyFmzxS/ygrVpsVlYX1kKCPqXYDU68xEq9gfybfMvbyBpIVqkgTlPXzxKGOF9GFbK/eGkarg5Oc9Mptq5w0xP4UxsQIeKZR0R51vpbWA8gKobJtbxyQkS/5wLDyWhiTlglvIE5/p0v8PbFXFd3B+Q+2m9f/45EtpuktncIsNCZaNJYHQwm/ns=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(82310400004)(1076003)(83380400001)(86362001)(6916009)(36756003)(7696005)(26005)(426003)(54906003)(508600001)(4326008)(47076005)(2616005)(70586007)(36860700001)(356005)(316002)(6666004)(2906002)(81166007)(70206006)(186003)(8936002)(336012)(16526019)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 14:05:34.1296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd12a69-2252-4f44-f81b-08d9b3414fc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To silence the following Smatch static checker warning:

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:2615
svm_range_restore_pages()
	warn: missing error code here? 'get_task_mm()' failed. 'r' = '0'

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 663489ae56d7..187e8ab66baa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2603,6 +2603,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	if (atomic_read(&svms->drain_pagefaults)) {
 		pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
+		r = 0;
 		goto out;
 	}
 
@@ -2612,6 +2613,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mm = get_task_mm(p->lead_thread);
 	if (!mm) {
 		pr_debug("svms 0x%p failed to get mm\n", svms);
+		r = 0;
 		goto out;
 	}
 
@@ -2649,6 +2651,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	if (svm_range_skip_recover(prange)) {
 		amdgpu_gmc_filter_faults_remove(adev, addr, pasid);
+		r = 0;
 		goto out_unlock_range;
 	}
 
@@ -2657,6 +2660,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	if (timestamp < AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING) {
 		pr_debug("svms 0x%p [0x%lx %lx] already restored\n",
 			 svms, prange->start, prange->last);
+		r = 0;
 		goto out_unlock_range;
 	}
 
-- 
2.17.1

