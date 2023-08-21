Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97591EE4996
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 19:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 250AC10E175;
	Mon, 21 Aug 2023 19:30:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FEE910E175
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 19:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIDfwH0DxKuCNhXZYbYnZOywJ16gMGJHYIqkep8cSKYKkq0OPbVsiIVvYI3HAhZD9oebs8R4qOhaBK1zAenkh0Cqmx945V2qo7OQ0votFdgbRoRuIhCysWJwgTXh41adCm/r0eCgQBrOcVExVAL4P6P7gaSZ+hoGMIdc7pQJusuGlNc3XIKt/kxZAqm8Q0w8/v3JaAerFpzNpgYBgnC3PouSz/XXOAMBpXCgRb9clXHqCAONg6JWykIrg0TDNAZ3A7yBoTnG8+JeZh0KM4tNo5j19z+/x6KfTJKfuSXi0reRPyGPHrbAcKhD78PhUTp9w9AWR5w2f47SAOOq52N+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LH5QwiSbRPMgoEINQrawKBsh2IgQKWvIHXc8KMtxWTk=;
 b=WmCOyn2Wlv505pF4sshLYg6Cm1bATgupxpHRlYESmsdYjtvDCz3vf/wWTZR5dNAA/TnG5qBv3w7vY+eRuyQiCFGeOnR4VHfppuZ79+jRolRkj0dlF2SPNTAnPK0puTIqJGzYisSRnvJgZwlVbu3Iui9m95DolgcnXvgeev6DZQCwEntsLBHuiOdsGSnJJq5tZNf/+gt6zm3bWAuEf58ADOH8g5iHyEOG7vCYC4oH7JcEjT4H9cZPUvb0IYw2Q7WrTglSjk2MzggpZ2zZ81+2CVbSoeiOUaR/vhFg6nybWSptNZwlfEXMDsfBaQh6Zbahv2IY5DUaEzJT8R8B1LKkuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LH5QwiSbRPMgoEINQrawKBsh2IgQKWvIHXc8KMtxWTk=;
 b=QE1ibuVMhyGPFnTXFpwnqm9B1DF2hXzixWPbHWK66Rg60xXfnpYkcUBeC49fyzlPGdkeZHlhKlJK3zbNFOXN+g+vF78/+SeZLMg7lcCSLnyOQ0TXvqpHZ8TlaRYz+TFc1ZzV+sbCKYpjqgYaPHBUBPbYYen5mQnD/YcxnBrStSg=
Received: from CYXPR03CA0047.namprd03.prod.outlook.com (2603:10b6:930:d2::8)
 by SJ1PR12MB6148.namprd12.prod.outlook.com (2603:10b6:a03:459::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 19:30:29 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:d2:cafe::9e) by CYXPR03CA0047.outlook.office365.com
 (2603:10b6:930:d2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 19:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 19:30:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 14:30:28 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Share the original BO for GTT mapping
Date: Mon, 21 Aug 2023 15:29:12 -0400
Message-ID: <20230821192912.1618-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SJ1PR12MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: a24cf912-4dcc-4fac-5c68-08dba27d13df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9whj6NnYILNekNnBgM0GRnol4m9Mp/PC3uVsVotZtpguUrn/7FDBbd7WmU0JEVg/yNhjSBTjb5/CJgFzd/XNgUuNYFcYMfs8REsyjpFIGGDlYRNlH/OOQAYBmNYcRWvhCAq19Cp6De+abOZaFalStPWjvOkQVg5FrwME2vq6iXulzKHnFWb9F6RTtXf+xYeXybNafR5BRneLd1duzychP42c/7i0BjKNw2ItX9suukc//Nttu7ywZO6o2c7aZqQPEb0efzvVajdI5cu6UnhI49598sGkryq7rzaLguT2LG8zPTLrsj5SsymWkvRiOvW80Lz2d54aRgAFOUUqa/KXFBIsezs++FEph1mCjvcF3bgoxsa/XQx+8W5maMZ7UHMS9rdsvz+nneCGc7rsc5BQQLQXjwnb5kcHfNyI46bTe1tVwotbKEf8G/eTZCIOjy+uTbcJX3E9nTXpyR+LW3rEVG43wzXXW9hieHNpz5ka2CqEvt4WqeaA1mo5bqn3De1eYbKzo7bAF3zgd2caYRHTp+toKBstmIqSFJDFdurF5I6X+9c/wQdQF/whGDwf5RArGr4VJpvq/Y/m3o+MYqt3iKYQwoPA5TzzI2PhRwXPxFPEy5qpBYbRXDykQoUW6SmB3YarCjtJKOtfnyWz+cJs/QgIUPN8RfORSSE0LXPJKxnJqaSPDr7HWRGzkq3i2oWJ8NTGN9He/sKf4FvXKe/hkdyBDvfvDjPGdycyHE4X4DuJyfFSkEUwV0BG1nUpuxZ5paxb/swVmcuTKOV4NyDIpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(54906003)(6916009)(70586007)(70206006)(316002)(8676002)(8936002)(2616005)(4326008)(1076003)(36756003)(41300700001)(40460700003)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(2906002)(86362001)(7696005)(47076005)(36860700001)(336012)(426003)(5660300002)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 19:30:28.9980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a24cf912-4dcc-4fac-5c68-08dba27d13df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6148
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

If mGPUs is on same IOMMU group, or is ram direct mapped, then mGPUs
can share the original BO for GTT mapping dma address, without creating
new BO from export/import dmabuf.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 282879c3441a..b5b940485059 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -864,9 +864,10 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 
 		if ((adev == bo_adev && !(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) ||
 		    (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && reuse_dmamap(adev, bo_adev)) ||
-			same_hive) {
+		    (mem->domain == AMDGPU_GEM_DOMAIN_GTT && reuse_dmamap(adev, bo_adev)) ||
+		    same_hive) {
 			/* Mappings on the local GPU, or VRAM mappings in the
-			 * local hive, or userptr mapping can reuse dma map
+			 * local hive, or userptr, or GTT mapping can reuse dma map
 			 * address space share the original BO
 			 */
 			attachment[i]->type = KFD_MEM_ATT_SHARED;
-- 
2.35.1

