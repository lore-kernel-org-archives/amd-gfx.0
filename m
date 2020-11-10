Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B181EC2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 03:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368052067B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 03:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yBk5+tK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368052067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A896589668;
	Tue, 10 Nov 2020 03:22:52 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750085.outbound.protection.outlook.com [40.107.75.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3C0889622
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 03:22:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbORrQFW/1wfh79jhmNBp0K6194WGMd38iuVJDj3kzW4ExzXbuOAL+6cW3RciTRdiWFDjtjFLKDCKtSV5p+4LXxa86g0GYo4M7LuVcQeUNPdXa+7IhjwxnzyDUcdE3Pmc6hZL1SO0+mpn9k7yFvL/X9aZj9ZGFi1oyondFtoKr1hOrx8ADYUHRMPbJm9szNISuj4qNFKiBv+TWLLOfQP31UMFgo5uGDPFIkjh9zb2a5gH4omMSy7mdVund2WmiCRh4OMPeO5xcVz2B8lgUuF/YEhW3xCwhdpx3H4ozyK6Zkmktnil6PqpXghgqupp8gdoKcCfTdpXaw6ncn0TjpkQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGgYDN32PG/vrIDNuDlvQpLhLG9zCgQQC0W/aNIOK7k=;
 b=G8ZBgvtwnHd1lhpCj1BEEOt/qVa7y8VUpSH7s0bJPwJiUGlFEVAeEmpFG1BZIhiyps3dQchLNN4DMxKlxQlOxAlNCcJAVdlYbiidMCFBCIXLB2K7+nVDFZtubp/Hp57Ys9U6gVPdRbxGn16HfomFIown5cIkHD2J46ftiJgNN8i/nplkvtSyRBFPlW7WRlj9mfxj3vcb6YQafem6T+U58BHYm5xCKMvNNp9NYS+RIEwYRRLY2kLbnfD8zerO5KTiFNY9slrjkEokSJtXJ9sFhQu6MQxng+On4Si1TajcXVAt3qbDDJ8ZG83UFbar3jUOBJHiQV9aZN/bYED7l8p6WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGgYDN32PG/vrIDNuDlvQpLhLG9zCgQQC0W/aNIOK7k=;
 b=yBk5+tK3SAjJo8E9zWgNim32UHW4HFRJsSN4l27rZmNq+/ImEIef+5YCCFZEZgeH8rnw2lrpjnBBQN7K/FqrREct+/7f1iM950cbx8bwDoiBye+CMaE81/2m2J9G+htWWb0GaNkYCS4mVYCsgqXSZBP2qiRScLkXTkWn+Lu2oZc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Tue, 10 Nov
 2020 03:22:48 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d436:e21c:e4e8:7deb]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d436:e21c:e4e8:7deb%5]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 03:22:48 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: enable 48-bit IH timestamp counter
Date: Mon,  9 Nov 2020 21:20:33 -0600
Message-Id: <20201110032033.26249-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR07CA0155.namprd07.prod.outlook.com
 (2603:10b6:3:ee::21) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM5PR07CA0155.namprd07.prod.outlook.com (2603:10b6:3:ee::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 10 Nov 2020 03:22:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a73e035-83fd-4ee0-d6c4-08d88527e649
X-MS-TrafficTypeDiagnostic: SA0PR12MB4431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4431DD093BE8004B6E020E74FDE90@SA0PR12MB4431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NS7MXvQZUopHoi1EGg4MYQ9gbZSXBF7kK81dRxfDaf0RCnmunBFXOIhYqxbvxfcvsvLJcfv+SWwXKBjD28QDIrCiFtoKv4HfJ5toz9umEy+0m/WNtk1fcYFQ6moo0lu9X+65kL/Wu8PfOF4d7YP/vh2DScbb2UyJ2HKUhTbdP6opFpCaLOLBeEwSdeAxlFANmumO91SP9IKVn/uXkSAhD0DOjysD0ZmyQAYAyuM62Ix+aO1a5/uQhuraPyxlgggFDwlM3e9CkK+Ldk67rLm/wrBlGJHHrxDzUkw30/madi3OnmwA8WpvtBviegsHZhPb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(16526019)(186003)(4326008)(316002)(66946007)(44832011)(66476007)(66556008)(26005)(6486002)(8936002)(956004)(6916009)(5660300002)(2616005)(478600001)(86362001)(1076003)(8676002)(52116002)(36756003)(2906002)(6666004)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: LU6lxhd8G8abNxvTbEBd1kPOqM7a3t0kBd8xh7AkQZgaFloHKUV6NzcDGP9OrFt3nIGzJdHLSbcNQeIGcnK7PEflsL96k+BaG6ms/6H43xK2/X+MKlKncgOIFPPB49IG01TZ3qLJuWW2gTvtAaefVBIT5tW4llwQ4kR1AaCefiahs263F36OA1APPMWJJRX7IZq/zY55wpdWhXaPra3Og73bySOQZmOopHmDb626r4p5qfsrCoMJ82nBCW7wUUW2HNi8/cPFlY8rTWFmZ24eni0FIofL7H2Rx79k2TtjfqEhsoXo3Chd8wH1hkrCJctjEWYPXOfysoEz0OghhmZJ6PFdyHefwG5cgZSg63JoE4TXTyjRUC8sjZl+OldZuV2y3OZDSLngOAOKZdMuIZKIehf/Rmd+ySstyDgnfzJAb/2zPSFRWaOxwj7iutq890BeegDpJd9F/4n4Cb05ei/iilHfBmyTm5/ZZX9HnvaOwe5lsSM6t7cSHawpVPdoQ1cGgYr4oYCdydislrWqX8S5Vz5TKKCGQfVhIH0VYC7nAumHY6qDFRo7pfWyXPFUt1ne3qZQLZYMVGoIAPRgZiHtJbsMk1aj+A+uvb/7H+A68+vUZrprCHAxjxleH50JNqHRHJQ87B7/wrrq8/z4wtVFkEyK4168Ys8E/8EwWUfVwoCFHUk0AZP9Qhk30h8r+FKVtHRvbJLhhmN9hxBvs5JvXQq8jexDcICOa++UH3FkHswW5af5okoCUZUB2PVvS49HnkSr92tyPPV0E0kPjLjDNbCkpLPrCImDm43u9ak/JdRMJoBDmwIYKaowjfiQHaIrWl6qDSmeLA6ZTCZr1Bfa64x/ONSE2QgA0oi3Gqlgg5qWVrKOQxO5IraSc9Sq8fdDSqUhUwmWz9Rcaxq9PKIcHw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a73e035-83fd-4ee0-d6c4-08d88527e649
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 03:22:48.8634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4a0hihRADGiaIiUeqiUqRJ1bUfORLV/gVbZCqY4T3whUm8CwmEIp53ERX1QCY2zYDfHBXIENg5eCHcM0y9Jfjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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
Cc: Alex Sierra <alex.sierra@amd.com>, Felix.Kuehling@amd.com,
 christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

By default this timestamp is based on a 32 bit counter.
This is used by the amdgpu_gmc_filter_faults, to
avoid process the same interrupt in retry configuration.
Apparently there's a problem when the timestamp coming from
IH overflows and compares against timestamp coming from the
the hash table.
This patch only extends the time overflow from 10 minutes to
aprx 455 days.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 837769fcb35b..bda916f33805 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -94,6 +94,8 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 1);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 1);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
+				   RB_GPU_TS_ENABLE, 1);
 	if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
 		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
 			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
@@ -109,6 +111,8 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
 					   RB_ENABLE, 1);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
+					   RB_GPU_TS_ENABLE, 1);
 		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
 			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
 						ih_rb_cntl)) {
@@ -125,6 +129,8 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
 					   RB_ENABLE, 1);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
+					   RB_GPU_TS_ENABLE, 1);
 		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
 			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
 						ih_rb_cntl)) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
