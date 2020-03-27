Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02FFC43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 07:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845A120705
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 07:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QXU1T8Pp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845A120705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D6A56E9C2;
	Fri, 27 Mar 2020 07:57:22 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690042.outbound.protection.outlook.com [40.107.69.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A15296E9C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 07:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBh54dGWKqilDO2BouXDrAcNceIVow95ofxH8rvD1oqGLFMdUD9I9MuyXZ5pP9mpuZinw775LkrVnQHJgu2032pqrOuFPvIwi2qLTe5yvWRnJbUbd9opcGKACaHrjlfpR2G5up/jWdI6RsTCyF+68HRHANQoeVi7tTWtOUBXkveezQdO1rtYCokC1pZCPmhRCuqSeI3nxh1Rxt1x7B3QzGR8rKOnpQXCp8knjSMLX1j8a3BnsSasKzwtxdSmNJmUcNpWj+GU6bQ439lYrGd4lyxTRqauthqCOyC6rGdGXsmc+3gyNtWYEHho6Y6R2cHp6X2Dw/L53+MzUjZOVHRCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnmLkZFBfeETQKl6FWfA9x27hC1oSHus3lxyYfGP2LA=;
 b=bXQou3z1fVK5fLFSS3FKS3FqBBIdgtkUqi6R60spyXn6SqYhLaxtmZPMtixNo6hhnUoJrJOghsoRl67TmhAedP5FmsHHCBmgR/po+C3bdSk2Y/FiJD2cgcWW8GoRwKMvgWo0ua9q1dW7T56JUkbB3bgi0LPD70TICYyZJmD0YFwySGKzJfz8A7+fXSKZwjZyPg/Aif4XJsucJUjZNOUgODvTDwtT1VdzeynQ78l9YNDZBGs7TZnTTQfMkCNH8ujcmV69vIFqcHq913R8Cwpvz0Tvg8tCJcszw3IyUF7ENHTT8EMSp7aaMZ2XrgugDRkWFmu0SprEJxDu9RO+foy11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnmLkZFBfeETQKl6FWfA9x27hC1oSHus3lxyYfGP2LA=;
 b=QXU1T8PpFbfKD7agcSwei9sYCFl18+rhyQk1JPXA38j9pp44G/6rAYCvFG8ac8ZDZyq2vwLQXaXMxFUsng65fhkM3oBpdQRhxxMshuLsqEkjnlIrlE4vP5DXTdW2X9uQF2n27hQW7PmhMjF4imY3Wsuia9Odrl3NhG3p/+H7Jb4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 07:57:19 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 07:57:19 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/powerplay: drop redundant BIF doorbell interrupt
 operations
Date: Fri, 27 Mar 2020 15:57:00 +0800
Message-Id: <20200327075701.17821-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.0
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19 via Frontend Transport; Fri, 27 Mar 2020 07:57:17 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: afbf9549-ffec-4d4d-f1fd-08d7d224791c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4270:|MN2PR12MB4270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4270F99ED5812D708BBEF09FE4CC0@MN2PR12MB4270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(316002)(66946007)(2906002)(66476007)(5660300002)(44832011)(478600001)(2616005)(956004)(52116002)(6486002)(7696005)(186003)(86362001)(1076003)(36756003)(8676002)(66556008)(81166006)(81156014)(8936002)(6916009)(4326008)(26005)(16526019)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4270;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PUPIO/uVyjF7917LqPbs9Cz7Ixp9TJMi6zZQVXpXsfbEh9fQyxub6LZ9UjBuC/UjhRg9h3fq9c3ZHGLdMGWeaFol8JsmTvIKAWaUmsFGk8bhOtFYOg/2SS9jHHmXjQ1iBmA2+O/mMb/uBZPwpoQ6NOj59DuOI6TfLcoLrTwt2ZV65MNct4Cp0GFBb5p6+Eb3J1cPw/xJaRMSvAGVQ2F6/CSBKx1dbJNETWIICTQ6hlXZYBQ6QQMzF1Ha85xUDjFnuN54rncVLQqk3HCjqX/4TNj9mXqriNTmIh4Vzf2CQITYv/1UutFs5b7HzR9MvGu1l9R+cqrpwOEQ17QbD0jB4eUqYyDav8bW7sjfVKMHcgUm5mZs75A/VNaPFpejb7SJTrklfEjKo+YFREJxHU5V4XOA1qEJUBvxnbajQvQ1tXOvK2S3Oqe8PO+vgb+M1hcc
X-MS-Exchange-AntiSpam-MessageData: Boz4/szsO0dF+JeT0EakrQESzhbuhu14kI3qoktgm3U+G53CiA2zqMvLAOMG6SkdlhzlzmyO025NqKT9iIhI4irxr6ByxkTJhWni+U8pcG+iT2bbRG5i1qMrNHjiejGtZajfCfPO4pge0pjY/fUg1w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afbf9549-ffec-4d4d-f1fd-08d7d224791c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 07:57:19.0509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PX7qasjowhP20QnjGFofm6ufqCluy7kwZ7OvicSOF1fG6NbwBEBS/Pw5IIWOpi5p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is already done in soc15.c. And this is really ASIC specific
and should not be placed here.

Change-Id: I7c9ee3cce07463849a29c7bcbcb493f817626274
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 160ed40bbc86..31b93cff19d5 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1700,11 +1700,9 @@ enum smu_baco_state smu_v11_0_baco_get_state(struct smu_context *smu)
 
 int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 {
-
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
 	struct amdgpu_device *adev = smu->adev;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-	uint32_t bif_doorbell_intr_cntl;
 	uint32_t data;
 	int ret = 0;
 
@@ -1713,14 +1711,7 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 
 	mutex_lock(&smu_baco->mutex);
 
-	bif_doorbell_intr_cntl = RREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL);
-
 	if (state == SMU_BACO_STATE_ENTER) {
-		bif_doorbell_intr_cntl = REG_SET_FIELD(bif_doorbell_intr_cntl,
-						BIF_DOORBELL_INT_CNTL,
-						DOORBELL_INTERRUPT_DISABLE, 1);
-		WREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL, bif_doorbell_intr_cntl);
-
 		if (!ras || !ras->supported) {
 			data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
 			data |= 0x80000000;
@@ -1741,11 +1732,6 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 				goto out;
 		}
 
-		bif_doorbell_intr_cntl = REG_SET_FIELD(bif_doorbell_intr_cntl,
-						BIF_DOORBELL_INT_CNTL,
-						DOORBELL_INTERRUPT_DISABLE, 0);
-		WREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL, bif_doorbell_intr_cntl);
-
 		/* clear vbios scratch 6 and 7 for coming asic reinit */
 		WREG32(adev->bios_scratch_reg_offset + 6, 0);
 		WREG32(adev->bios_scratch_reg_offset + 7, 0);
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
