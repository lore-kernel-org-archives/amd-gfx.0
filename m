Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94408C388F9
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 06:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F1D20857
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 06:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BoK4knFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F1D20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF4056E3EE;
	Fri, 13 Nov 2020 06:53:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD49B6E3EE
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 06:53:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KG0RtCVNwH5LjxxaLM74IC4iXhVbAl18gajlsE6gVPVlN9oOmwEkWAKxyNDJol0P0vvCPEfwDnNZTuKlDVhd8SIk5PsbT+VsFwKmNoRXBla1xzYpAsqUvjKM0olXSuf+wLqMoFEb9rGxWJKdBDe6AISTzGMLFCcz+RQsjfKrPpcVVtelBu5g9EX4UyTopdbd4FAClaqSlmrbaBk8Q1oVtLL3CV0TPRvRM9d0l4/XvnS5hZglS14Yfk3HhaWuZuBWGfAmLg7WKAv9DBzQl921iYKpRl5b7sCUL6neC4SxN+0phYLh3rCDQ1WlSJoGl/55ldNKtPPZVGTfiyoiGqgc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cR1N3018iHj78Ytr82IWQNU/L67O1SQoleYCb7G2Hgo=;
 b=TIJZuTnlSlgIznO+p4/IAM/IQWpKT8FAOq5RIOW6b+bdsc3rB5z3Ew0muS5zxEc2jIR0z9alxnSzGBiyFE6WD91rhzmOjainWzEL3B2MHSTzUtUSPN9TsuEP1/2HzwjDPQIzcgFyo90OhWQmIHkglgVOBboK8qM4lJcs6O//qnYnCpNkOZeYe8wfGS3uvA7WqT7qGq4AHJhjODcumYKb0phdG5VGvv5qcr8vxzQg21qGYUcE+Av6gr8o7mCPClWb9rSUZMUexwVvj16FnV0IltGQTbtRsbNdtYGQgRIzNaR1GowXwktvJ1ZT0IPFWMxxSexqdopHDkxj+HQ+d6Y+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cR1N3018iHj78Ytr82IWQNU/L67O1SQoleYCb7G2Hgo=;
 b=BoK4knFNhDh6NpLDAtBV7gtib04TOsoZznTyPMMi2oiClGuGPM58eX4s0CN94/EeKVGIZMnoOjBAgc2IGkf8LT+sFuBxj8/khJi7O4Mna7dI1Dp1xVRT6DfxWq7M6OJ+SPGqwXWevEtEQ8+yQl1gXp2Rg+Xwmq3A/UkiVJ2ahcw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB3333.namprd12.prod.outlook.com (2603:10b6:a03:a9::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 06:53:33 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695%7]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 06:53:33 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: update amdgpu device suspend/resume sequence
 for s0i3 support
Date: Fri, 13 Nov 2020 14:53:16 +0800
Message-Id: <1605250397-15043-3-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605250397-15043-1-git-send-email-Prike.Liang@amd.com>
References: <1605250397-15043-1-git-send-email-Prike.Liang@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK0PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::24) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (58.247.170.242) by
 HK0PR01CA0060.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3564.25 via Frontend
 Transport; Fri, 13 Nov 2020 06:53:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 79aebcef-5e1e-4ec6-ca2d-08d887a0d617
X-MS-TrafficTypeDiagnostic: BYAPR12MB3333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3333755C34CDDE1622F82C12FBE60@BYAPR12MB3333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sga6TQEVicQBOX6+/53xoE551xGprUAKz47Inur05sVbgNoqi6MJqq/DZ5y8nMtyx/6tI9JIpRMA8GHFZlVzWWPFpBtOSZhdZD5RjVvwzUntPuTYnA7r51R6fvBBQnOzAGYWXArTz64dzjNP6FEV+CFkD4P85ocwnj8dFnLjR5qcD/JNCQB8tHzU2Br7+Kor/xpoFnqOToUn/FypeuY7SXQdQI2jdA2ugeX8R1eLKaZnUg1pp8UCqYYIwgVXPKTHuQB6rWnN4z63fbT6SH8NLxgq6FgsK+48GmCFNv6pd1pleIcOGZrjUV8yVBKo+OWXQRsInZhav8yGDrz0wr67GA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(2906002)(8936002)(66476007)(956004)(36756003)(186003)(478600001)(2616005)(86362001)(83380400001)(5660300002)(6916009)(66556008)(6666004)(4326008)(66946007)(8676002)(26005)(15650500001)(16526019)(7696005)(52116002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: x44yXOEGJrIjLqvbPrWl8eynqcKMctVUYo9vvHOwOL+Fc1S3YorgaPyH3CmLUsPtvlGAtyNNLFW6rf1h0mvD/kufnKHTxB6/js/+rpC1qTilOvruzVjJOoXGhh4DaV3kd5TYPOgML/WeYtX7JxJgcYFYHF5EJoFCWt4qIGu0caT0yr2FSRbpyWbBsSO4Squ4nQTHt10CKb7BAcSv5gvOQKY2LJTFtv860myNxZSIRkvzPIlJA8f7V2Y2bfHISrYH6LYkvNZuaiR4M0pi2MaUA8jJdMzCtGRQsdSXeXE1hMSOhb57dEvArv31cORJfyzAeZ7E1IU8OYIAMFNj745d/jGcsUTgxn1DtZ2gThlNCDWviPjb5+tomWhOJZ+Wufr/8NIrpLEaC956LJQyuYyWIRxiLBbTtNFY/bxjc7z4bOxbGgAi8GoFECtT1fkc3OUoNb8XXCk57LwvenFZlZc+EU8PRPS2s4/GAMQlSeBC+5oDxmMjvbqMt6JA45YFBLq3zXvgn/o6ghDhy3iTqskzHOwiddk450/dWFHj+ig7u5ZkQtyUR1jY9U+koxaR0mXkoHMBORzdolzi0YCGeLeDkXjnfPF/EYHe2jrZhsfPkDR6sT8iriCzKAwGgPI6ud9KL8eOC0jJApDAhKZ6S4H5lzab7z+DKT/TxB8CK+5dUDu6x5IlsZ6Uwmg6LhSKQqgkNWTxaXfc00WKgKDmN7HExuSD58wyV+Vlcv4T8JMLyCKDah6iJN6dXU6DNl78ZKLOstkdfSDbOOhnXPSnX1VW8nVWXX/fRrCyeF5c37yP7n4hfAGHk4av+ndBE8TUvP66k4pCZIII0ldhUlDPlJCk5D38e5qbL/AU0Mc0d8uX/kWL99gMOT0IPgQrMSPiwoEJ+TScL03qYMQJqUByMokIRw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79aebcef-5e1e-4ec6-ca2d-08d887a0d617
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 06:53:33.1264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qApbLzine7GaZO9ek1fErmR6/CKGDRDjeEbpjiWM35HaMmFCFYn5yNZ6fMQvmx5Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3333
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Need skip the RLC/CP/GFX disable for let GFXOFF enter during suspend period.
- For s0i3 suspend only need suspend DCE and each IP interrupt.
- Before VBIOS POSTed check and atom HW INT need set the GPU power status change
  to D0 in the resume period, otherwise the HW will be mess up and see the SDMA hang.
- Need handle the GPU reset path during amdgpu device suspend.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f78aace..2f60b70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2650,8 +2650,10 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
-	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
+	if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev)) {
+		amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
+		amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
+	}
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.valid)
@@ -3706,8 +3708,10 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_fence_driver_suspend(adev);
 
-	r = amdgpu_device_ip_suspend_phase2(adev);
-
+	if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev))
+		r = amdgpu_device_ip_suspend_phase2(adev);
+	else
+		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry);
 	/* evict remaining vram memory
 	 * This second call to evict vram is to evict the gart page table
 	 * using the CPU.
@@ -3738,6 +3742,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
+	if (amdgpu_acpi_is_s0ix_supported())
+		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry);
+
 	/* post card */
 	if (amdgpu_device_need_post(adev)) {
 		r = amdgpu_device_asic_init(adev);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
