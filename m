Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21A6C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 04:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EFC56EAB2;
	Thu,  2 Dec 2021 04:55:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C7F56EAB2
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 04:55:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPdeQYi6zFW4MBX959I5X27pxhxm9A4K1aXWOIlCsXtAtwcoj1J9crwPTpv8dQGjFQSc3rRKZDoxzlFmjCGig4y1YdWQb8X6ptUg60MmqI96sL35/ZfaPD0SE/VulCEbcBFDSetRWnux9Z4jXJN8e7dm+OCXhN45WkhTSPEZMvh4T7UhiWyYH7CNe3rAHGRbTn0naQ3HaCMCbzmMOrTBepVEfzkKuz7Pp8fvS7PuIoXaKEQGQc/e6bPWn9KEDU9QYWv0hq5xj1G7coS+YXaDcaL+Inum0GLMhdwjslXbmhx3fjiEReSuphK8mNR3Xzdm3A3HfSzdzct2QUZmjVb00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XPxGNxMBg2HStaD9ZoO0/xZ68L55IX/Ofdx7Y+hLIk=;
 b=hbH312ehMHo6x0BlAdi8Us0LJ3pgzJbVjumDsTLROwD+guO131kwrniBxoqepvSKS0K9YTMgE2z0/HQlHQSa5RLibMg0nGyQWFLqMjzapQO4KWX/Rb7oFSZwpdryr0o/lDCT1eas6NZYwo8l5NvTFH+v7ncztzLlJyy+HS49vAjaiUKYRYGMJkBVN6svosG6pJ8CCykkl1lXlw7Ga6m3bMdwOSfOvwQuS2EJt6CzNgVgNx71nLyWxpd3vef0i9S4Q2LlHwzTwqe733eCGGHHxDKwPMYxOH3LsiMCNkl2XaBONMALxfJR0OlUYrVoVNAQrg+39X8+08bR+qVHY7fKtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XPxGNxMBg2HStaD9ZoO0/xZ68L55IX/Ofdx7Y+hLIk=;
 b=SzXvWHXd/yMWsanHno1PKA/e/dpwsNdhlpOCn9hmMetZpQ2P/hb6aqBMlYaUU8yEExKTq6gXM/WMFmoGyvVbzxjoj8OUDmbTBEiE6WhaYfgH7+bNVey6zpy2ygO9TXMIIdjx/HvrMTTIGVXyQwtrYSvofpqJk992oXP4lM4exjM=
Received: from DM6PR04CA0026.namprd04.prod.outlook.com (2603:10b6:5:334::31)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 2 Dec
 2021 04:55:29 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::a2) by DM6PR04CA0026.outlook.office365.com
 (2603:10b6:5:334::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Thu, 2 Dec 2021 04:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 04:55:27 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 22:55:25 -0600
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix null pointer access of BO
Date: Thu, 2 Dec 2021 12:55:12 +0800
Message-ID: <20211202045512.5066-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de1d6d05-e90a-44e5-1b90-08d9b54ff5ce
X-MS-TrafficTypeDiagnostic: MW3PR12MB4442:
X-Microsoft-Antispam-PRVS: <MW3PR12MB44426BD286FE8DF585A11A2387699@MW3PR12MB4442.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pLKh7PTTseJBLRso9LLsq4hw2+LjFig7iBi+LhIfGsuvy74fg6HJKgO6bmeKuqXxYP9VkB0ISGncjTE3iWFWqDjN2/DwPT/AzeOcSwIi/jyiyS06Ns75gXch93ORe+VBNOHMnuy7Din0LsfSm0IWLMDXTzPjXV3EfksUXfPzmoJ49Ghrr2rhZOz4By+6owPAzY9TP/mWaZ5fLvLqVT3wNZjVGgNF+V/wHBG/dQa2bcphe9jNpaIp2n54ol02CXos1/JA6ecjf9BhlTTHFHuHvw62YHqN3stwPYHisq+D12ILhPCU062U8aQnbJrNg1CEIrlcnEPI6CO3wC2KGdZ/gSegBalp5DWqIE95NF7osOZyEPSbZhtP0dzruI4abxJriMmssryk2Dh3+rvYBoCOM7GeWnHeWMflfoIxEF+X04Gz1uX3cFGJhntZZk4y2H7es1eeiKfdvy98sj85irAlfJENu8bpKGx21ERdm5V/2pUXKFKgD7rF/36QAhLsRIk99ko8UnbUK39xCFadZhjVP7WhClsWBh2Le87SBWFRsvwVJ1xDtx4mVcfPEBhmcFOSd2c0ZXjun68KJN5Fy3VNaow8xf404sZSiUqqtrsUfBkzp08+CbY6XQ/ESsXzbhJEsj7EB+h7/zh8Qn3zsBOe/LY9GJocr1sjNI8fbGK+rSunH4CN1nwXQGtGJszJy8EYiW8GlImKo/5/dODxBBajXBBB0h+/maDMsSdyt1JdY9Is4rqev6jny4tfHthf5IydPkUgwPQvhecqFZ8Is/FMh7wXtpZiluHw91va0f9yKAc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(7696005)(4326008)(36756003)(86362001)(508600001)(6916009)(8936002)(82310400004)(26005)(1076003)(5660300002)(40460700001)(36860700001)(16526019)(186003)(47076005)(70206006)(356005)(2616005)(2906002)(336012)(316002)(70586007)(6666004)(8676002)(83380400001)(54906003)(81166007)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 04:55:27.9821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de1d6d05-e90a-44e5-1b90-08d9b54ff5ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442
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
Cc: alexander.deucher@amd.com, xinhui pan <xinhui.pan@amd.com>,
 tao.zhou1@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TTM want bo->resource to be valid during BO's life.
But ttm_bo_mem_space might fail and bo->resource point to NULL. Many code
touch bo->resource and hit panic then.

As old and new mem might overlap, move ttm_resource_free after
ttm_bo_mem_space is not an option.
We could assign one sysmem node to BO to make bo->resource valid.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index c4317343967f..697fac0b82a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -359,6 +359,7 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
 			       struct amdgpu_bo **bo_ptr, void **cpu_addr)
 {
 	struct ttm_operation_ctx ctx = { false, false };
+	struct ttm_resource *tmp_res;
 	unsigned int i;
 	int r;
 
@@ -380,17 +381,26 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
 	if (cpu_addr)
 		amdgpu_bo_kunmap(*bo_ptr);
 
-	ttm_resource_free(&(*bo_ptr)->tbo, &(*bo_ptr)->tbo.resource);
+	/* Assign one sysmem node to BO as we want bo->resource to be valid. */
+	amdgpu_bo_placement_from_domain(*bo_ptr, AMDGPU_GEM_DOMAIN_CPU);
+	r = ttm_bo_mem_space(&(*bo_ptr)->tbo, &(*bo_ptr)->placement,
+			     &tmp_res, &ctx);
+	if (r)
+		goto error;
+
+	ttm_bo_move_null(&(*bo_ptr)->tbo, tmp_res);
 
 	for (i = 0; i < (*bo_ptr)->placement.num_placement; ++i) {
 		(*bo_ptr)->placements[i].fpfn = offset >> PAGE_SHIFT;
 		(*bo_ptr)->placements[i].lpfn = (offset + size) >> PAGE_SHIFT;
 	}
 	r = ttm_bo_mem_space(&(*bo_ptr)->tbo, &(*bo_ptr)->placement,
-			     &(*bo_ptr)->tbo.resource, &ctx);
+			     &tmp_res, &ctx);
 	if (r)
 		goto error;
 
+	ttm_bo_move_null(&(*bo_ptr)->tbo, tmp_res);
+
 	if (cpu_addr) {
 		r = amdgpu_bo_kmap(*bo_ptr, cpu_addr);
 		if (r)
-- 
2.25.1

