Return-Path: <SRS0=Rejl=EY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72130C63777
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 12:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA57C2463B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 12:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZpGM8CaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA57C2463B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E546E408;
	Wed, 18 Nov 2020 12:09:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A2A56E408
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2020 12:09:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOus+1SXlEyV01a78IrufPatpObxHw+i2gv89ZfxqrhkkIT2ybas7ydHpA3Vo8FnKz6h6ihg5rVllCwTcsAuVmC/lc3T9xK/6Lx5kVME49mYn8DPkGk7Ej6RG2x9cuz1yp8+27t36nKdyYxxQ8PYSnSyIfbhs3DOnaC2kzfI17/Ypba6JJhyKFHt7hTOzU6qrwzHtPU2ix0tMUsYYs3ua+lM+KgDDJu7iZe7zchkHq2i2aOGDesrId8USqIwTnMitZib64b1BfhwGC4mCp1nGN+2ZyGFLe4EXJauMtB+vwA2+SyFvAHWHXS4zhgPpdBc5G1JI8UVp1YzMIIpd1xZqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AM6KhL+8rER4DN0s8vDDw6XG6Iql1coQpocpbvfuIr8=;
 b=UMzg6iNogAXM+D14H92IrOLV3519c++2kE2X3fmwbzQtmWyvGrDj+oUo/4Pc2yt+z60zJv1FCGqIGghIBlMKmMFQlVCRJGxuz8Uz9jvIIEguL6fALhiYAUgMBZjD01IZ33BH2AE4QdVRUCHmUzcPFgscF+dFg4Bl8Un0qJPvmTTgtkxfcY0XEgAUboZNEVKUQRxEnpUG28uGYV5uxrQZsrAm5TozDyZ52AIn01MFLZYFFlJfiRB0cbHJgIJUoX90hzs3xFRHKN3Ar2k9c50KO89wvGLBqxhOii4uWKu0crm5x7ZHEZy55EeeoUDCI+JNaKZfO85vM1rqBXU/tRpGnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AM6KhL+8rER4DN0s8vDDw6XG6Iql1coQpocpbvfuIr8=;
 b=ZpGM8CaX/GwFW3j5DmHdsf3Q7FjvlCeKmn4/KcqwIvjZZOOLgdYNqKG2CQ44RMG0xR8u+uHB+RdTcJL6J8yZqa3jr0k+WfrZnCIHBc/KkBq49p2J6/DIAXU85oWwir55aXlCQEq08+638dsCNU9F1ZEQIWO3oWCitxq7ix4QcZY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3467.namprd12.prod.outlook.com (2603:10b6:5:3c::10) by
 DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.28; Wed, 18 Nov 2020 12:09:26 +0000
Received: from DM6PR12MB3467.namprd12.prod.outlook.com
 ([fe80::1948:87e9:bae7:bdf3]) by DM6PR12MB3467.namprd12.prod.outlook.com
 ([fe80::1948:87e9:bae7:bdf3%7]) with mapi id 15.20.3589.020; Wed, 18 Nov 2020
 12:09:26 +0000
From: Jinzhou Su <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add gfx doorbell setting for Vangogh
Date: Wed, 18 Nov 2020 20:09:05 +0800
Message-Id: <20201118120905.1473-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:202:2e::31) To DM6PR12MB3467.namprd12.prod.outlook.com
 (2603:10b6:5:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR06CA0019.apcprd06.prod.outlook.com (2603:1096:202:2e::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Wed, 18 Nov 2020 12:09:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9b54db3-3fb6-4fed-6b3b-08d88bbacb1d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4043:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB40430E3274F85BA54EBEA58790E10@DM6PR12MB4043.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FXyEWlw6S0Wa+qifCim0mc2qrvbn6cmS6SjD9EVlWB6ES/rObW7mD1FPDKbii2ZXP4AeBAnv0w+xSR/acyf978q+2ZgVv1VUyG4Gv6y6XK2qQgtiYvknsBmCcWkOw2zZCJURo0H+zUP9D1aADOw+qYsg+qAHrwJZBJkZmA63spuh8guVlygwh7/b2wXrKbbgKfWE4v8/aSSoXekD89AfKOjc55WSyO39gNGF0/vdyKveT/YybcGZecuiTafZs00zgnDsmq7U0Xf6/jRQkGEroLnxEPdDsIOmDSU3kU80qWB90a/GeaJh8r9CX4pRwVl3fhKU+wL8N7mCktz0R/uWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3467.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(186003)(26005)(1076003)(6666004)(66476007)(2616005)(5660300002)(66556008)(956004)(478600001)(66946007)(6916009)(6486002)(16526019)(86362001)(8936002)(8676002)(2906002)(36756003)(52116002)(4326008)(83380400001)(316002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xjThk+g6DN49b5uHwvXqKPMxjTb+8m6gnwPAgQZnA2WB0ifATvlkSgrmUYSrHTwroJSYV6ZGOe3PefOEgzCoSLSLGlyd4XDtG8ekm0bmPHvliyopEB3AObkRJ1sBENV/+JA4dXuUflSBsqXkUlc7+Btb1AL7phxYQvp18UOvrRqHR5tUw8I2g7UWXA0fv/o/8MTG7IkRK13HiJ+JdYZqzvGYxSGxVnrVx8WHwbWAsGdfQ0QpdubcvcW0rhNhuSDWNNsHAazObxG2IX+PJNWeGeBIHYUjcSVwUs57hn0N+428GL9qP8uXHlpFYmgVvNoJfPn0gZTo0aB6DQmAbIIrEYav+gNVV6gY8gKdl3buLwd80PHBeXHNt3YLBKG1mDOl+llx0qtb5w313KRfY6w0Q4V4rvuFJMjk767oA0nlu4njPT2kLy14SFu875fFqyBoSRqrS3lTODWOYeFQ+2hAuytPy8cE3JZL+GNCllHrtEx7LJQdDdZk6tIfXQrDriTV8UceMNCSMQS6ZmORS86yei0HE/dplbAf86PcexiI+NsCZYzZKZaQFmctARebWdnz5JW4d5V3eMn05IFeEXazZqXJuEQQHkMAgcDJWNp22wfsZ6dYeVgUyUhT7fuaNu2RTXGQzD1j0/hBlBQubnzBfA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b54db3-3fb6-4fed-6b3b-08d88bbacb1d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3467.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 12:09:26.2934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atPgYhTGxnbemIoSWP7FgSrekbqGsa2EpAmtv7wDn7w7pOR6F2weDSquKo+9xLI1PW5zLgmlJkPqVhBF++BWZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, prakash.kamliya@amd.com, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Using KIQ to map GFX queues instead of MMIO for gfx async ring,
add missing doorbell range setting.

Signed-off-by: Jinzhou.Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index a6d03931f7fa..9b4e5d53432f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5995,17 +5995,19 @@ static void gfx_v10_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
 {
 	u32 tmp;
 
-	tmp = RREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL);
-	if (ring->use_doorbell) {
-		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
-				    DOORBELL_OFFSET, ring->doorbell_index);
-		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
-				    DOORBELL_EN, 1);
-	} else {
-		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
-				    DOORBELL_EN, 0);
+	if (!amdgpu_async_gfx_ring) {
+	    tmp = RREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL);
+	    if (ring->use_doorbell) {
+		    tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
+				        DOORBELL_OFFSET, ring->doorbell_index);
+		    tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
+				        DOORBELL_EN, 1);
+	    } else {
+		    tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
+				        DOORBELL_EN, 0);
+	    }
+	    WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL, tmp);
 	}
-	WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL, tmp);
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
@@ -6349,6 +6351,8 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_ring *ring)
 				    DOORBELL_EN, 0);
 	mqd->cp_rb_doorbell_control = tmp;
 
+	/* set doorbell range */
+	gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
 	ring->wptr = 0;
 	mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_RPTR);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
