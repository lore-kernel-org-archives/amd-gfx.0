Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D68C4BA09
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 02:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF9720675
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 02:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NPjKHk8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF9720675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3CCA88071;
	Wed, 26 Feb 2020 02:45:56 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760044.outbound.protection.outlook.com [40.107.76.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB2426E0E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 02:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxEPepy3qwYhI6QWrDJIfQYF64Nv0bsHGHh1NBl46oYcgsapAI7LM8r8u8CjIToC9Xmx9nSow8Ic9dneDUMBj8syi/FZF6xWsyrZbx7snJONuyG4u0pVy3UzU/c88bwsaZ122TWDwT9YatcO1cXJDB3BFXvOrN4J2LGCjxfARDkQgtRNz8bEbwC3dcRWhFDirTZUx8afM+DY/haVgouPnzFNRSuWiskbrOsP0ZxQBNbRpvTGL6zLqQWM62mPCOXH1GQnGSPMGYgJEImm6hNjo3FekzQ7gEytrjHvMV5gx7UshCkHY+AuBaQmNI2X7XbwZPQP+3A52fSSKVlMAXCUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkjgWF218eGi0R1NH/DKreA+xYyIdkjnibgLd47Z0dw=;
 b=gk0pC1TB0powO7GhBIzgcozrxqZhotV5UjPkAvE0GsIDTkyeIcgtgj7cgchMr6pfWqTykVq/urylfKSUAHrStC08Oeu3p6JPdpb4qcALvw3ezqK+hETkLQ/ukKF28o+eSR54RAGXaBZsnK5GkdT/Np3vmgYQGGa325BS0fEwD54BZGsYvLBwE+TTHbIzRXiNkHS1Zvpx7jDXkZNRdMi7ZfIhxUHn1RzwFB1Ke+s4DWDepCrBt+R5+5tmeU1CnzwES3UrMKdXlyZ/iSoNSuawPPB6lRFzt/bCIPONObbm86yIZq+CWBBtksXBxGnnBmwnzjZmSPOGoS8GzKMhl5SXDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkjgWF218eGi0R1NH/DKreA+xYyIdkjnibgLd47Z0dw=;
 b=NPjKHk8ae5HTGINLdZTt5iqFJ5FPCkhV1DrByi/q46lRog2NlZFPbOK+uDwxrpaX42psjjhs067SAIgucx2/53Z3Im4NjOtoeffO4p/SfKxwpUuuMgth+t1smqOZ9BLh8iHo3KPlmrPlsXAfRTNoxo1ez8z87v22NJ2m5tnojso=
Received: from CO2PR05CA0082.namprd05.prod.outlook.com (2603:10b6:102:2::50)
 by MWHPR12MB1839.namprd12.prod.outlook.com (2603:10b6:300:10b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Wed, 26 Feb
 2020 02:45:51 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::75) by CO2PR05CA0082.outlook.office365.com
 (2603:10b6:102:2::50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.9 via Frontend
 Transport; Wed, 26 Feb 2020 02:45:51 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Wed, 26 Feb 2020 02:45:51 +0000
Received: from Rohit-Dev.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 25 Feb
 2020 20:45:50 -0600
From: Rohit Khaire <Rohit.Khaire@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Write blocked CP registers using RLC on VF
Date: Tue, 25 Feb 2020 21:45:26 -0500
Message-ID: <20200226024526.16710-1-Rohit.Khaire@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB02.amd.com (10.181.40.143) To SATLEXMB01.amd.com
 (10.181.40.142)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(428003)(199004)(189003)(316002)(6916009)(81156014)(8936002)(81166006)(336012)(2616005)(36756003)(8676002)(2906002)(426003)(1076003)(6666004)(26005)(356004)(16526019)(5660300002)(86362001)(70586007)(7696005)(70206006)(478600001)(186003)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1839; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82c69210-fa64-4add-e9b5-08d7ba65fe19
X-MS-TrafficTypeDiagnostic: MWHPR12MB1839:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1839C9393EA7587064F3B8C687EA0@MWHPR12MB1839.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-Forefront-PRVS: 0325F6C77B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: znkn4aZJQSDvmy5bzRmWajrVBt+Wib82pYMrdoMi1o7HM/31b2qoM7njScG36h5CVHZUHR8rvUp9NE/wVsnQPUxoD1FOI7MbzWCNiApaOPWjLgAZf5R0Vp/QkZ9Qi+QIDyYvX/B/a7IRaF9SukazbhEDTqUYTloQ+najGnW0tqj+jmx7SLun7R2if989iHsC2s5hWV//kvXZDfshGdWiHuXWC/bl2kENORChqW5k/GZuDVpCZJm2MxcMzKne7J/z7tfCXaskEib33BBgzQNQGtoTZMJsphZc4NNoDxmeMuy31W+YMIqmF7sR0JYmLRVmn4rudpY7WxSX2jskG14REFUhEUPaog78wyVFV+3VYL+5luWWQyPGhZoTh/GWQQbbwR+B7psy+DnSAA8f91Oj90d027Iq25H3apDOhSHE/Xs8ImH24yFyTFR/jjLzrsWD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 02:45:51.2179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c69210-fa64-4add-e9b5-08d7ba65fe19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1839
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
Cc: Rohit Khaire <Rohit.Khaire@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This change programs CP_ME_CNTL and RLC_CSIB_* through RLC

Signed-off-by: Rohit Khaire <Rohit.Khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 44f00ecea322..8f99bc6163b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1783,11 +1783,11 @@ static int gfx_v10_0_init_csb(struct amdgpu_device *adev)
 	adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
 
 	/* csib */
-	WREG32_SOC15(GC, 0, mmRLC_CSIB_ADDR_HI,
+	WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_HI,
 		     adev->gfx.rlc.clear_state_gpu_addr >> 32);
-	WREG32_SOC15(GC, 0, mmRLC_CSIB_ADDR_LO,
+	WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_LO,
 		     adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
-	WREG32_SOC15(GC, 0, mmRLC_CSIB_LENGTH, adev->gfx.rlc.clear_state_size);
+	WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_LENGTH, adev->gfx.rlc.clear_state_size);
 
 	return 0;
 }
@@ -2395,7 +2395,7 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 			adev->gfx.gfx_ring[i].sched.ready = false;
 	}
-	WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
+	WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
