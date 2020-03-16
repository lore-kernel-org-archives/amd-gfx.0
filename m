Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BEDC0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 07:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03D420658
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 07:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RHyVk0/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03D420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 723DC6E34B;
	Mon, 16 Mar 2020 07:53:01 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680081.outbound.protection.outlook.com [40.107.68.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEADC6E34B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 07:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+KDgkH29sIHFJuUpWqP4uaxWRpUphfirZGdJISatfYYseGGcsNVUhH3i4oDkv+F+WdsDskJlzLqrmslYPmz6mNn78s0Uvhmg3eBkZX5gW+OPIYN2bx44gpmsBtNIG9od0dn5dwl06itYrStdGj2KtdeEhSmCZBjHu9+vqcM9w1Jua8TUAcWLTpHsU471fabHis+qIVkRE/Duu4jug3eNEhmS8895w1h8jNVzMSKNEi1IEzTBoLXA2pQjs9W8vbuNk8+mQ618MGNgl/6C6qw/Nqf57CVFXyKG5hzq8GgDIoRsIIZzJbP8qIeSXH5+trC60VZ3662LVW6qx3RvNbhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Dl++8sj/djnddH4zV6Jxuz1rFaD6WHOHiptMQBvJpE=;
 b=RZ8oLyWpy/e8P14h8RDHN/X30VaEcvG/dEvpJnLKd5DTexm5XanEWaK5Xlk2lmkBtL8UlPgb+Z3EhdiXtZa//4xvcT5spDPOgR6LnU0n9gGlDB5+IPnokrB1w1eQ760doBdWmjmxclg1X5r0cnHFWPxW7zuTzgKw0dvAEKCvRZCcfNB7wf/u1e+GRKmkmnAYTdgQ5PqAv8+QXMMTOaj654Dy3nC4YExFCnh0j4duYLsR+oB2xvquBvdVhTP+CIyfFq/FDo1rnXS/uU9fXqrx23Qjz8QmFyBj9OETiacNkhOlVVV+nl+ch9+0ivzl/a+IwaB1PrD8SIaLzbD2MgEJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Dl++8sj/djnddH4zV6Jxuz1rFaD6WHOHiptMQBvJpE=;
 b=RHyVk0/VfU2ijTEYaGM90Td0En9/vIy0ia3YVOK8xh30IYGdKneBUasRpSdKv2NAxM0xy4ZJkcsPA8IT4x0HVzXfvhJpRPGbn9sBsgCdv5cXl3VmRe4lzKNUcCYMGagmu2adk67ALIKqWz/BMEeAXxBDL3WCDyHjtQ0+JRSZ5uI=
Received: from DM5PR16CA0001.namprd16.prod.outlook.com (2603:10b6:3:c0::11) by
 DM6PR12MB3513.namprd12.prod.outlook.com (2603:10b6:5:18a::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Mon, 16 Mar 2020 07:52:58 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::ae) by DM5PR16CA0001.outlook.office365.com
 (2603:10b6:3:c0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend
 Transport; Mon, 16 Mar 2020 07:52:58 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Mon, 16 Mar 2020 07:52:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 16 Mar
 2020 02:52:56 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 16 Mar
 2020 02:52:56 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 16 Mar 2020 02:52:55 -0500
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: miss PRT case when bo update
Date: Mon, 16 Mar 2020 15:52:52 +0800
Message-ID: <20200316075252.29897-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(346002)(39860400002)(428003)(199004)(46966005)(81156014)(81166006)(8936002)(8676002)(316002)(15650500001)(110136005)(54906003)(36756003)(70206006)(4326008)(7696005)(70586007)(356004)(6666004)(5660300002)(1076003)(26005)(47076004)(478600001)(186003)(426003)(336012)(2906002)(6636002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3513; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b69d32a-6e55-4085-35bb-08d7c97f0ac1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3513:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3513643E64D1EDD4C0947AF3E5F90@DM6PR12MB3513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 03449D5DD1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v5oNRzZLCiN5bUSWpV8877IUVzMiLWDelKddWDtcu+Z3E4RiU3SlFx+MnN+rcnaSon6X7Qal+h93F7oKObiELoOLbnDmVLCqawcAXF16nF18HaexX+xciBVeExZVLpbJuYf0ddjmKWJi24q/5bGpu4lY6/eHq8Tt4azLm/EqbYX2Nz0V5487IA3rpnDtPDqrxSI2pPs/oIvYrqTO8G/tdyICqLBQKoWQq2i9IZtyqlsqyk5ZeBAANeXN4Q9H36hOanOqcQ3bqWvloMzsLcWp9c/QRDhmQFI7cit7yY9vdI0wE7rv1DCI0cOlg+1LZyUL7TNRHOCmmRXyuvT5TNKXj/ejht5IBiknFxhkg78EPoPcF0zPE9t8OzYy1Cnq56LDbfxzHkTaVsnyGpDuGI5m4Ff79qjXZK5pe8dWFwsUpZXgZNpbTT7ckv/Z3iM3DUgkRde0qblwnXsKwkKdTEIUOyhIeuQnwfMN2q5YLkdNvrhMgvps0SY1SvjyEw0kdETIMhwfpSM21LiJIOQxGat/2g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 07:52:57.3848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b69d32a-6e55-4085-35bb-08d7c97f0ac1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3513
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
Cc: amd-gfx@lists.freedesktop.org, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Originally, only the PTE valid is taken in consider.
The PRT case is missied when bo update which raise problem.
We need add condition for PRT case.

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 73398831196f..7a3e4514a00c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1446,7 +1446,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 		uint64_t incr, entry_end, pe_start;
 		struct amdgpu_bo *pt;
 
-		if (flags & AMDGPU_PTE_VALID) {
+		if (flags & (AMDGPU_PTE_VALID | AMDGPU_PTE_PRT)) {
 			/* make sure that the page tables covering the
 			 * address range are actually allocated
 			 */
@@ -1605,7 +1605,6 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 
 	if (flags & AMDGPU_PTE_VALID) {
 		struct amdgpu_bo *root = vm->root.base.bo;
-
 		if (!dma_fence_is_signaled(vm->last_direct))
 			amdgpu_bo_fence(root, vm->last_direct, true);
 
@@ -1718,7 +1717,7 @@ static int amdgpu_vm_bo_split_mapping(struct amdgpu_device *adev,
 					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 			}
 
-		} else if (flags & AMDGPU_PTE_VALID) {
+		} else if (flags & (AMDGPU_PTE_VALID | AMDGPU_PTE_PRT)) {
 			addr += bo_adev->vm_manager.vram_base_offset;
 			addr += pfn << PAGE_SHIFT;
 		}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
