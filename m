Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899CEC0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 10:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591C92051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 10:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rgZ4EWDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591C92051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08B2E6E3BB;
	Mon, 16 Mar 2020 10:00:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B436E3BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 10:00:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OY9vsPtOYblocZS0n2hDFbbiIZH/WCpk68nkLj81ypMT10MPGlVLkogb6H7rovz63ZIstz/Q5spN4n38UPmSTemdsehG4n6CMTzQYeAqmbQHAIkQXO0T/wtVTjsis8yuWt3xsym2PI3wvaiDQQ4MNDlv0mI2f4+DG8sZm8c3HrIe/RoP0bXO2R2YoZ4KXHfJZYN/hzZvdB8NdUAkH1EqQ5NDkuvQS2u5GJlN5AtuZzz55e7N4LhRiGVv8MGN9TCFNOPZ2i+g1jXoprPs2xHlC68mpQeMP1PmxNWtoDnpVxHZReuCnlHS24PfGngNMkYwiL+8Xd84NnBU0Cq5Ahdwcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QOB9KsAN5R8ODfPOs31q9oHi4EOxDN/gCxpPuM6YG8=;
 b=RNaSYlpL8cuvUse/5ekQJ1xJnJXLSew5e+DyBkskf6LslIr84IHryF8yc8Q4ixxvlLlRO3vI2NiLzpTSPxwQreFBxtSbqvw73VBYVvj8C2+8ee2fnT9T/6OvR4J2GbCUD4swRcoCJKFyHV+FAAtoQ9WdoOlwfODIhDF7oHsqdxn098QfAX8ldPq1npd1H3eSvn8lO1V1l4tPgsWhfaWZ/0zivyiQ6bqqvI6+rHn0nYZXd3UMLA5aCR9pgisl1/eXwwi0E7oTRNMfTo1KfbbZV5pbOd/yzLJkBsUP2N2vnjWfzGWWGBzU80ZU+yaTZRAIOywu6n4mmSFhlv/v8fxWMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QOB9KsAN5R8ODfPOs31q9oHi4EOxDN/gCxpPuM6YG8=;
 b=rgZ4EWDm7JIiIp27V6x4+j8Io+fMIEzwyRhAS8cjJPt8AUYIhVWW9CZ8eSrMBzagnBJxdnhAsV6TDk+Gh2kwQhBI+DTdMWDr439rCjV4zSmdEnCI8K4N5q/uKdEiWd0TW5QP9KMh1Plc0cPlFRBrXk0S0E7EBNncuxb9dJggJ8c=
Received: from MWHPR13CA0034.namprd13.prod.outlook.com (2603:10b6:300:95::20)
 by DM5PR12MB1900.namprd12.prod.outlook.com (2603:10b6:3:10f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 16 Mar
 2020 10:00:29 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::ea) by MWHPR13CA0034.outlook.office365.com
 (2603:10b6:300:95::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.12 via Frontend
 Transport; Mon, 16 Mar 2020 10:00:28 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Mon, 16 Mar 2020 10:00:28 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 16 Mar
 2020 05:00:26 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 16 Mar 2020 05:00:25 -0500
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: miss PRT case when bo update
Date: Mon, 16 Mar 2020 18:00:23 +0800
Message-ID: <20200316100023.453-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(136003)(346002)(428003)(199004)(46966005)(186003)(36756003)(356004)(478600001)(26005)(8936002)(5660300002)(81166006)(81156014)(15650500001)(2906002)(8676002)(2616005)(1076003)(4326008)(426003)(336012)(316002)(54906003)(110136005)(47076004)(70206006)(70586007)(7696005)(6636002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1900; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cb368d3-96d1-49e4-2ddf-08d7c990db29
X-MS-TrafficTypeDiagnostic: DM5PR12MB1900:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1900F14AB1B6FDEC93E21F98E5F90@DM5PR12MB1900.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 03449D5DD1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQjylrQ2duK0slr4m0ySBxBvKpCTR+VCRkrz8RxclKZzcidrBrO/XAT7L61tQuS/JWJoUR6wLvVXJNSEVIIszZ6C/th6xX3Zs/F5fMVlfOFt5CVoFDGQAxAPTa4B7TOrQRjn9HmO9LuGdsGr5i7afEG5O5QJuAxeZRgC9GS1+g4bVek2uquGdiyJlSVtk1bfQFViPSHYJKWczZLNJe8LtjIay+k4OrFtgllQRv6VqXxaRmzOY5e/VKjL6Jy4Yt/FAnzS/fSACj73ZFD/k2SwC1Mh4Y3nE765Yv1ENQFTGNVaxcGK66wNJYm+dxWFCSzS0fYSLNcKsTKe/l0+uZYBHSqlcVEafID/qt1iEZfD9bYv0aa2RCFj9eWhd+ALVIGotZ8TET9jGzIVvakdtpQ2mFqpGjmF2viA3+HJGM86N7ot10oLeF/UQcB5+WyhiRxktSTm+0dEBtdc/TnMzU4eNXziXHniPj5vUPs/wWwXRcg82+UURcaB6riRW064PPegF3ozmoXI0sdHnOFBeK5oCA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 10:00:28.3878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb368d3-96d1-49e4-2ddf-08d7c990db29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1900
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

v2: add PRT condition for amdgpu_vm_bo_update_mapping, too

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 73398831196f..87e6085542f9 100644
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
@@ -1603,7 +1603,7 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 		goto error_unlock;
 	}
 
-	if (flags & AMDGPU_PTE_VALID) {
+	if (flags & (AMDGPU_PTE_VALID | AMDGPU_PTE_PRT) {
 		struct amdgpu_bo *root = vm->root.base.bo;
 
 		if (!dma_fence_is_signaled(vm->last_direct))
@@ -1718,7 +1718,7 @@ static int amdgpu_vm_bo_split_mapping(struct amdgpu_device *adev,
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
