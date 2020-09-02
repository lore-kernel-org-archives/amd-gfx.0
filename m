Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF3DC2BBD0
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 17:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC0C12067C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 17:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hzYCTq0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0C12067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A16BD6E93A;
	Wed,  2 Sep 2020 17:01:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A89A06E93A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 17:01:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLaW/2XSngG6ror+ADUjukSXFFlor42F9yRPesO4SVXwFxjst1OegqM7YgwB/SDr3aOw/jr0XprSlSrckkwdGf5CYyT/xgKcoLL05+eGw300ayOqiuNjuq8aheVmDhtEgO33UTek/Prgl8/PC+6fYgwRX0pMOGKaWfPImvbrX/x+X+3soqNrIuHacYt+D3AVyUEK2uMroO2hbpSFCUVKI1O6OaAOMsTqUjy3MuO91/7mcAZg07BkP5+f5hFtrzJSUUOVwQ7bgcaHHpnhMZIuL8UMYTka6JFZj7SwWWXOeoAGntI06mXZHF2ae+D5f9718trQPlKkCG0umdN8VAM0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcZUUjcW1ul//mEPdZs+qNAfWUMwPCiAQbEM+Ie9Mo0=;
 b=TyK2dM9iMQrKeYNKlruQRWMaxBz0hnnkDQjuWeggucVV1uhARc0KHIBzRcxHYfYebttIFpQ2l5ctEZ4WdXuoChf99++bH+056MFxLvzsiBwKdIRw9nFjG1pbV2joHSOwZdBVRLKKRSbFEUKrBh8kQjwrUA3y3DPwuDVgnZT6lYVDJAwYiH7sX8NXUUYgoqt2L/8soFU5a+YlxkoEE+rdPG5YdsNYbpMHzcoxF5a4BTSri4/B9cH9JIjbOSHPTSQS9mUOI0zZdJqlpGyJ649TiGKSqt8/Z2951S5P8lqAOqgaALOqQdHWyCqLSEymWYIDtLyVrzFixsUTtwb20KnwIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcZUUjcW1ul//mEPdZs+qNAfWUMwPCiAQbEM+Ie9Mo0=;
 b=hzYCTq0suSPqTFnIVxykx1qOVkGwu6AblbWSYhaTAUBUdeMkiz042QnL18n3IF/voNUnAM8dbzISnU8aCyxRSDh7JlBwKYl8Q7G1aQiv4swkZAeouOhTXWxPoFq0z8PIXCRx6X4msUhbGDblqufGu7V/feq/4ocG4MK6YaDT478=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN6PR12MB2766.namprd12.prod.outlook.com (2603:10b6:805:78::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.24; Wed, 2 Sep
 2020 17:01:36 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::9841:a796:7269:7bec]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::9841:a796:7269:7bec%4]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 17:01:36 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: enable ih1 ih2 for Arcturus only
Date: Wed,  2 Sep 2020 12:01:18 -0500
Message-Id: <20200902170118.30751-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: DM5PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:3:16::12) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 DM5PR07CA0026.namprd07.prod.outlook.com (2603:10b6:3:16::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Wed, 2 Sep 2020 17:01:36 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 689bb09b-f823-4c7a-37d7-08d84f61da1c
X-MS-TrafficTypeDiagnostic: SN6PR12MB2766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27665872E6869D28E5E8A791FD2F0@SN6PR12MB2766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DGZiAHeUc4SeHfdQJ+cq3EAadg/cqGSg9PruqsrZUyrY7CVYlXWspY2nXY1vrzV4Ez12pEfSZXO7vl6XwWNCEYzunYPiyrSxan4ntjBAJvopM3ABA2Z1XBex3l3AAZDNaoqSNl9sz4W3LO4pobyDmhiP/eqndbpXb4uCRF7CN5PPrGGWF6XicJcJa3hqB9NRx6HkvPK9KZr9VEIwDpFCStgDROM/MLot8A2ZBhumMRTTEZRZ/8+Q6CKwwx3eXdNA0bh/i+R6Os1HQpMfCz/VtRnqhUTHwAUfd6UQju48gsdp6MvhUEMf8/OpXD4h5Xp1JVCKnYqdvy5Qsj59Qb232pnr4xTtup/MTz7N+Tvz9QY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(52116002)(6486002)(26005)(66946007)(8676002)(66556008)(6666004)(66476007)(186003)(4326008)(966005)(2906002)(6916009)(478600001)(1076003)(316002)(5660300002)(16576012)(8936002)(956004)(44832011)(83380400001)(36756003)(86362001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: CrUswNbjNmEAKnGYAOMME4sTPC8oqVuHlLgA6JBci4gb8BABn2qbr1XLRhXZJgH9bM/nV3uraJPNJL51Qm3LPATtou64zMEEmOxFyH4PioIZkW+gvCsYDA5VwWiqmLa6bAUr6jeUHEwyibwCxBw3vqRwCVfhsSMf4joJS5WqZabRZtiFWy35PzeBddQvjYyiBPrkjZ/OFsSLu4s7lgaEDjjOnZxPhMQLnMN+fqSQRYO9S6e5JbVjFLza1yR4WWllaw3m26g0sR5KZr9bUj8W2igkIKsp4/PxN+t2NjcD9/Bbp9YTPBlk1Y59IpiJ2L5fDGJbQL+WLPwnnyVONO32eRg1H7YOnpjfzFDQ3R48OlDTSA/rERTbu58DD5fq0M2uOpjUCkgypfcBroJDbu4gbyFHQoPketnyrOJWxQ2KQvc8IZQOrsDw+6S3pLcYDSX56o6iPTT/nut9/ysdOjXAQ/jW10tIkyMCww+nA2t5Js7ojM1snNZjpoLX36Nms65j7KEhdWgooGCueTX438Pqo9cnPkmMsXeyIlgtGlvcJGiEbLuTG6YmSvHQ3E4iAGCyyeXcfU3+B47qE3SXxp+75iuVyoIzxyLomM6otpVxRX+h/eKN2KuqS3xXE3vr4mIGvMlNiIxRAsQlqe1UKYy/0w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 689bb09b-f823-4c7a-37d7-08d84f61da1c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 17:01:36.4013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eC0dbrR5R3sIhDcd3hpCiwGvB7kNrUfgpIfKACWKv+HIRXr/Zi5f3iFeH1SjOxWMjPywnBjC6EEBQ1rMB1CaOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable multi-ring ih1 and ih2 for Arcturus only.
For Navi10 family multi-ring has been disabled.
Apparently, having multi-ring enabled in Navi was causing
continus page fault interrupts.
Further investigation is needed to get to the root cause.
Related issue link:
https://gitlab.freedesktop.org/drm/amd/-/issues/1279

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 30 ++++++++++++++++----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 350f1bf063c6..4d73869870ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -306,7 +306,8 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 	} else {
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
 	}
-	navi10_ih_reroute_ih(adev);
+	if (adev->asic_type == CHIP_ARCTURUS)
+		navi10_ih_reroute_ih(adev);
 
 	if (unlikely(adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)) {
 		if (ih->use_bus_addr) {
@@ -668,19 +669,26 @@ static int navi10_ih_sw_init(void *handle)
 	adev->irq.ih.use_doorbell = true;
 	adev->irq.ih.doorbell_index = adev->doorbell_index.ih << 1;
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, PAGE_SIZE, true);
-	if (r)
-		return r;
+	adev->irq.ih1.ring_size = 0;
+	adev->irq.ih2.ring_size = 0;
 
-	adev->irq.ih1.use_doorbell = true;
-	adev->irq.ih1.doorbell_index = (adev->doorbell_index.ih + 1) << 1;
+	if (adev->asic_type == CHIP_ARCTURUS) {
+		r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, PAGE_SIZE, true);
+		if (r)
+			return r;
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
-	if (r)
-		return r;
+		adev->irq.ih1.use_doorbell = true;
+		adev->irq.ih1.doorbell_index =
+					(adev->doorbell_index.ih + 1) << 1;
+
+		r = amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
+		if (r)
+			return r;
 
-	adev->irq.ih2.use_doorbell = true;
-	adev->irq.ih2.doorbell_index = (adev->doorbell_index.ih + 2) << 1;
+		adev->irq.ih2.use_doorbell = true;
+		adev->irq.ih2.doorbell_index =
+					(adev->doorbell_index.ih + 2) << 1;
+	}
 
 	r = amdgpu_irq_init(adev);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
