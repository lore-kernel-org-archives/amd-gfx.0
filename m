Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F1AC2BA1A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 11:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E1E20728
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 11:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Jnf/zfGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E1E20728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95BD36E45D;
	Fri, 24 Apr 2020 11:09:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAC406E45D
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 11:09:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5v7RuRvkms1e/kpHZn4pX0+LryzEufLkF+bcoQRuRLU43N1t2HAuCowaW6X7tjrhCjZKoUjOyhT6TxMB85e+H3YLFfieDTxso8AyH1T4ZgAYcVkepF1+lsTPKNFZsEJ8YamnLr4BhobwkBtDPJGT+lQpkSuFg1vqGqCJLjT0sEPJPMjnvMfmjJ/VHf7cbmLp4klE1K35Kai/lnzh1YAcVqeeRJbmtuah4SpkHOk9TNio/wBCiIPQmpImz62hQaj1oOu3xB0o51gHa2BLKrEu2rUClVVQzDEMdjn6h/9tbN2n+GpVPo8KuzuexvTW032AtnILsy0e5E3TT0OvO8jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOfN9Vc3uTUmouMPfoyiWhNQcgIqjKGPTIjbsYbBy+s=;
 b=lLNslqZW4gJAZCks1rS1S6z3O+P5Ql2VLO30eKVYopKAyYl03Hg6aMHL9YCqeKM5JYu+j3oF2u82sbMqbXUa68XWl38cJAKd2eNQm62sSI1VmDDOeVMJ8HBqOt3kUpFVVZIc7WE2jYsX/QMR6BulXVBPcyJfWgzdc5q76CGQ2M9NTXRtKs2OBQTL4pqCn/jCquIctL/K5+cAT8nfH0m43O91T5kJR9mbCfHRiyo5dW8rpy4XtLXYVfkbL0qHxVg4PNqUwZa2ZgKV7fiHJYFdJhECGCoPsurlkf1CeHlR8W2cLPVViqaZ7zLAOV1z6np4ipSm/QCSn81np6aUHTAuHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOfN9Vc3uTUmouMPfoyiWhNQcgIqjKGPTIjbsYbBy+s=;
 b=Jnf/zfGL0P7sc7g1XJUaIbZ8r8Y5PZqze0H/0iAJPYQmDIhsdj3X0Cm0WSaKGQHNxDIfaKL1lOyoh/R82W7qzcMybbjaXessb2scc4U01vs06U9Iua1u7Gygyfc7zXaatmJAW1HCAE6y8zOYSDrHRp8X/CQYGuYX2EsC7Z8HdCs=
Received: from MWHPR19CA0022.namprd19.prod.outlook.com (2603:10b6:300:d4::32)
 by MN2PR12MB3598.namprd12.prod.outlook.com (2603:10b6:208:d1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Fri, 24 Apr
 2020 11:09:36 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::64) by MWHPR19CA0022.outlook.office365.com
 (2603:10b6:300:d4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 11:09:36 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Fri, 24 Apr 2020 11:09:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Apr
 2020 06:09:35 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Apr
 2020 06:09:34 -0500
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 24 Apr 2020 06:09:33 -0500
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Need to power up SDMA for #34 sdma firmware after
 do mode2 reset on Renoir
Date: Fri, 24 Apr 2020 19:09:31 +0800
Message-ID: <1587726571-31294-1-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(428003)(46966005)(81166007)(81156014)(4326008)(8936002)(316002)(6916009)(186003)(426003)(82740400003)(86362001)(8676002)(5660300002)(7696005)(2616005)(47076004)(356005)(82310400002)(36756003)(2906002)(336012)(70206006)(26005)(70586007)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7de15171-3100-4c7f-9efc-08d7e83ff93a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3598:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3598C6148A6F393CC76C849A9DD00@MN2PR12MB3598.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03838E948C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArNcOCX38cmWhKXgiR9NQ3x2dVYsI3RqE2p8FTB/82x3guhu7gmLyscXtSjH56zPGP71yZy6U36azY60VM74XuV4jV+SMcSzoiUsQ+08FLeqAXbkdwEsRWPjwz4O6HHgMM4fynHotIbV5yTka4H7bZY0v+VxmeMeu0zvGFF4a/c/3Mk4Vz2bc/vwkpKbzBqtU6hMfJlE7NlfEc/B3uVjdrnhWO14pvEl6hTOUcZMCjPSK3La6q3gkmtabuzxSE92vMKlqBqokbEncebnBHXeCGHN//DPBxiPfap2RBe69anvNQqEisQwv+it18QPWVecxrcF6SVx4cb/LCvI81NjeZg2cjVOBKdgUgnQNEVQIEKJvtRjlHyow27XtuovISJE7GI8NLI0ZUiqHC964tuEEy53v5maL1/XMNs7VSrqn39MImPBvxxGlHofnPKjN55vchHR/kwSNU6gMrWM2GAWTJyM89QxdwYJlfF/id0hPJv+2ihOZ8kJd/Z+3OhoOEXmDCaPq70oWqqknJqhFuI+gQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 11:09:35.6577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de15171-3100-4c7f-9efc-08d7e83ff93a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3598
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
Cc: chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
Previously I found that powering up SDMA after mode2 reset can cause
ring-sdma0 test failed.
Perhaps the mode2 reset does not reset the SDMA PG state, so SDMA is
already powered up so there is no need to ask the SMU to power it up
again and doing so causes some other problem.
So I skipped function 'amdgpu_dpm_set_powergating_by_smu(adev,
AMD_IP_BLOCK_TYPE_SDMA, false)' with '!adev->in_gpu_reset'.

But now, for #34 sdma firmware, dmesg log show "ring-sdma0 test failed "
after the mode2 reset, and scan data show SDMA does not have power.
Then I re-enable function "amdgpu_dpm_set_powergating_by_smu(adev,
AMD_IP_BLOCK_TYPE_SDMA, false)" during mode2 reset, The result is issue
disappear.

Besides, I did more experiments base on previous sdma firmware for this
patch. Situation Normal.

[how]
Remove "!adev->in_gpu_reset"

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index c0ca9a82..0ecab41 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1914,7 +1914,7 @@ static int sdma_v4_0_hw_init(void *handle)
 
 	if ((adev->asic_type == CHIP_RAVEN && adev->powerplay.pp_funcs &&
 			adev->powerplay.pp_funcs->set_powergating_by_smu) ||
-			(adev->asic_type == CHIP_RENOIR && !adev->in_gpu_reset))
+			adev->asic_type == CHIP_RENOIR)
 		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, false);
 
 	if (!amdgpu_sriov_vf(adev))
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
