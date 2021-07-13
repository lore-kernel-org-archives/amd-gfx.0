Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B348C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 10:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6581611CB
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 10:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6581611CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CD986E069;
	Tue, 13 Jul 2021 10:31:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B53CF6E069
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 10:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xsk5U7Q4LGFsTNae8nfWYpES2ixGTDIlpIBnhOi5RysJq/4hnf2CWsDYbuP2iO0f1/2eUFW9j1CMEhom1HQYHgHlKxAHcA/b+C2edMCXF79fsXkt8Xh2aHcCfQ2L0k2FLuODxcL6nCcHI8ubMlFscLC337WucQPZ+26xdqOIy0rNvdAgArrC7LOKyXRNYGeguRfOlQRKFS4Ca5+p1JQ2cj8oAz5nCTEXyu3R/3WPwWhZa8U/wBh688y+jvBWmreP0UO5YLjrMjXfIkx+E4nZ9GTY4icvjd3rx0tztLquSiwe3K59DpbnwJi+ZzIygRVMRBGEyTQByD+h4CN+1w8ofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbDaE9pWNiNq43EfVqbk1SsDc8AWOCGuVkCDWYkIPRI=;
 b=gq2HYnkZRkcZf92hD6TwwNq0O3/sJG7zrrkD65SP+um474L7jFdggFIEFtarNV0kq/fdDSFuiZnx8jGenuP32HfNrqq+JUgWSYsm14Bz9fv1d2UI21Atw40eSAEkJfp963K4wm991eqPMxQpBkP/9LTPAVJsneIQ3pj6wPv/yPJPKOgNTI1yeB+nyh03Hewz1yNOPAIqmQOODF3sZCHL8rD3d6bsLbhOLE/TXCCWnt4DJfjBXjdu0Aq04AYRVBLYvyOdO168lC32D/iFZ8i9mfwNijvn3DwvTxZqA0y6QSAEl/UARWP/IQVi89+etJ2xRC25M47Mc0SUsdSAjKMaxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbDaE9pWNiNq43EfVqbk1SsDc8AWOCGuVkCDWYkIPRI=;
 b=YIHTFlDN5X5yjFa9Gzy7VKmwpBYcmrVlQ8+HNroZRHAS/ab7eALj3MCcDw3xVGtyA1mWsRU61IX9qVfDvkV7mtdRW4yQ2rLCJMpuEdgvKqK0zNkLlGLnMEFsf4eE+FJLE21kTb1/y4glox1vIyKpHUQnnt/yLbh0hAqdEOiXz58=
Received: from DM5PR2001CA0018.namprd20.prod.outlook.com (2603:10b6:4:16::28)
 by BY5PR12MB3747.namprd12.prod.outlook.com (2603:10b6:a03:1ac::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Tue, 13 Jul
 2021 10:31:05 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::82) by DM5PR2001CA0018.outlook.office365.com
 (2603:10b6:4:16::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Tue, 13 Jul 2021 10:31:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 10:31:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 13 Jul
 2021 05:31:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 13 Jul
 2021 05:31:04 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Tue, 13 Jul 2021 05:31:03 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/amdgpu: Recovery vcn instance iterate.
Date: Tue, 13 Jul 2021 18:30:54 +0800
Message-ID: <20210713103054.4161-1-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a64aab0f-ef3e-450f-66c8-08d945e951f2
X-MS-TrafficTypeDiagnostic: BY5PR12MB3747:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3747098547EBC114E8E2B897F8149@BY5PR12MB3747.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qjEdsIc3etlxXBUBSTlaxo82xuATYEhtSH38sv2kEh25wjcgl6wBcRZg6WbwinN/pjSAsJYR1LEURXxBdxtqXFakq4yU7+2rvONOCczaRORYizbFb5wX1w+3I8PRT0LIz4+M4tAWYfEOoFn1ZsNCtD856sum2O8XhpGdwkWLKa+n4M+zBkUC3yzxNjED74neYq9JJRCcBkQaaKOnjuboMj2xLYLOEU9SphNrqGPZYZE4XLaSyl6t+d9xKzBM6c4DfPgh8qgsUcxuTO9hbiBoWX53ksXzHERUgkTr+jiOxothDpmAsrdOmhSYi6gor/E3Pyjg8R1bMnCHGaPCtTXUiaeeW0HG4BnYTGbUkJw7KZvqwR6cEkTaB8DPp4h2CmRs7zadtadGZ8iDk/iR4IjbtpcAGzeuj/mLX1r6S4QadU2bcCK8DO5Hp/A+aHo1vCH3+tDrDVMtxBr9Zjp6uDvo3104OhtzzsE/Bvt20OzWu5l2eArrCtO8OlqRwepnUse6vxTPkUWTeQc4f1uwppwS1REObCH+N9dl5e1ZTyEKefSl0TSGo8zAc4nPHqUKn5PAs9PAaC9OwwF7xvnv8HEkFd/a0lgGId9pZIvKJ33iGACjaRMYlQgEZjn+4G6SZ5xM57zft9APZMMRXAY7oNMWDuR+5qH7X/AYLgw073pfOAB5vdOtVoTwE+buCnOXvSEQqsOvHy2tmP8eaTY6JHcj+Xh/jSFBlqlYUIyAHNTqxRw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966006)(36840700001)(5660300002)(83380400001)(8676002)(316002)(8936002)(4326008)(6666004)(36860700001)(478600001)(82310400003)(7696005)(2906002)(336012)(47076005)(26005)(82740400003)(70586007)(70206006)(186003)(356005)(6916009)(426003)(86362001)(36756003)(81166007)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 10:31:05.3123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a64aab0f-ef3e-450f-66c8-08d945e951f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3747
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The previous logic is recording the amount of valid vcn instances
to use them on SRIOV, it is a hard task due to the vcn accessment is
based on the index of the vcn instance.

Check if the vcn instance enabled before do instance init.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 33 ++++++++++++++++-----------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c3580de3ea9c..d11fea2c9d90 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -88,9 +88,7 @@ static int vcn_v3_0_early_init(void *handle)
 	int i;
 
 	if (amdgpu_sriov_vf(adev)) {
-		for (i = 0; i < VCN_INSTANCES_SIENNA_CICHLID; i++)
-			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i))
-				adev->vcn.num_vcn_inst++;
+		adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
 		adev->vcn.harvest_config = 0;
 		adev->vcn.num_enc_rings = 1;
 
@@ -151,8 +149,7 @@ static int vcn_v3_0_sw_init(void *handle)
 		adev->firmware.fw_size +=
 			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
 
-		if ((adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID) ||
-		    (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)) {
+		if (adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID) {
 			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id = AMDGPU_UCODE_ID_VCN1;
 			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev->vcn.fw;
 			adev->firmware.fw_size +=
@@ -322,18 +319,28 @@ static int vcn_v3_0_hw_init(void *handle)
 				continue;
 
 			ring = &adev->vcn.inst[i].ring_dec;
-			ring->wptr = 0;
-			ring->wptr_old = 0;
-			vcn_v3_0_dec_ring_set_wptr(ring);
-			ring->sched.ready = true;
-
-			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
-				ring = &adev->vcn.inst[i].ring_enc[j];
+			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i)) {
+				ring->sched.ready = false;
+				dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
+			} else {
 				ring->wptr = 0;
 				ring->wptr_old = 0;
-				vcn_v3_0_enc_ring_set_wptr(ring);
+				vcn_v3_0_dec_ring_set_wptr(ring);
 				ring->sched.ready = true;
 			}
+
+			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+				ring = &adev->vcn.inst[i].ring_enc[j];
+				if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
+					ring->sched.ready = false;
+					dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
+				} else {
+					ring->wptr = 0;
+					ring->wptr_old = 0;
+					vcn_v3_0_enc_ring_set_wptr(ring);
+					ring->sched.ready = true;
+				}
+			}
 		}
 	} else {
 		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
