Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50092C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 16:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40BB2173E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 16:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZAK/n+JD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40BB2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE7F76EE19;
	Wed, 21 Oct 2020 16:55:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E54146EE19
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 16:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7W7kwMNFlVpFs9NrjflOpwd1utCFtBa3AvRv4xk7KGG6qCOh+nSKlqA6QS081L+/X6+O1ShDKIgAwS9iq1xqC6w8XrozU66Jb/wYBK10+74ryw94ZiX1Rk/ixXTCAQPM9794Yc/uQVtiHok2JC27HV7jTKu7NTyEbsdm1GtP3/4mQddx1dnws6RIY3fBWj+qt6n6TjsVV4owBP4vvAGLSL4oDeUrKXZLcIjCey3H61P2LhdF26m6hajeBDaEdgJLWyYotUovnby4nij5EU9FtapM0m9qkmfgZLVqnpNQEzII25aZa9XbiKAFV1hAsDUftv1tMYlPA7Rxy5bGyCq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOcepnGiwTGs0MUVJkA+0IagxJvRNNjy878p1kERE9w=;
 b=Ruo+DJVrM5wDj/WmVHbNOiZ3QGYBfXAhpo4UDaxL1OKB2z7f/Lnh/C8fu09cvEbu0ItnuGPdwcDsYoUb7C4QI/kX2zr81Y0ZBXM29LrXEJVb7Z8Z2uZsA4XqE4URZ8c74izSzaJSEXnaXh5Nfx/amjtDGSUE+ZOIxXyEdedtbsfqoqB+Qn1QKZx9fL5haXx/mRzWNvGn1Dazlq6M8nG3qIW4MPRE1RLT4fW9lsoxvid/wQ6o9H1db6Bl0TgAT8jK6Vn8j6kaU6duDP24aDlrWx/mVJuyNYYB5TkHjLvUWFcIV6hWDyScj3/Pho1lduV/llYYlEuIDt5q4pU4B23EUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOcepnGiwTGs0MUVJkA+0IagxJvRNNjy878p1kERE9w=;
 b=ZAK/n+JDmnO5rFxL1Xy5y6OhHk1ouaxoiGJCypiCzJ4zmD1/et/Fwni96ztnyjFbSZpPPF2/miafDgfh9HQ0RJwwDAJnmeniVo2Vyp6VhDM6xyNVmARznqdsl44G/rnXPb5VvlhOzVrPMc7Z2CICs3Pc+olJVRKYBxBSSTpPXDI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR12MB1840.namprd12.prod.outlook.com (2603:10b6:300:114::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Wed, 21 Oct
 2020 16:55:43 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826%3]) with mapi id 15.20.3477.029; Wed, 21 Oct 2020
 16:55:42 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: correct the cu and rb info for sienna cichlid
Date: Thu, 22 Oct 2020 00:55:24 +0800
Message-Id: <20201021165524.888802-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HKAPR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:203:d0::12) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HKAPR04CA0002.apcprd04.prod.outlook.com (2603:1096:203:d0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 16:55:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5594075b-7140-4631-9db9-08d875e22564
X-MS-TrafficTypeDiagnostic: MWHPR12MB1840:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1840F7233CC26CFAADF7F6B3EF1C0@MWHPR12MB1840.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxmBAlQaTRree0XltJ1JycuR61LukQTCqsLct3Dkubfw4fNB5+VkJ8GXG41F0E45fUZZIOgHYoH/E5ZtYEL4o3viYAq3VQ3Budt4tKgXFJzBf/M+jPmE+VrzJy0OyFZZnQxwrFv45n5gCvTAb+h4BHNtgqLjtUGR+Dlb9RTAmwT+FjNGmojj3nHKqW7KWySnSMBaG4aL4m4jyhOMOD536ONzVEy7TuT/tUVom06D2r7QizGYi4BPoyj22RRauV6xyNFqtO07JSg1tii9Q5K25oMsv9j2ybu/PD4omMOUu3ordO5GKcEJMVgkCYbpsR424RvwmDNB3I0byevLIgVDLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(26005)(54906003)(1076003)(44832011)(4326008)(6486002)(6666004)(478600001)(66556008)(2906002)(2616005)(16526019)(956004)(83380400001)(6916009)(5660300002)(186003)(8676002)(36756003)(316002)(52116002)(8936002)(7696005)(86362001)(66946007)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TzqF5fSJpHZzWzFKOGt1qlppjoP1KRH81FfbBjiBWT8wmVA3e/xr8kdzUpcaWWysh7T/lbDr5xVgDTaddqqtO1BNgR3G7Fbk6bhzdmgc4VY1/5nn5yypCx0ga/+C7dqffn4zEJanrfDY7+TMO8YmF9iupILZDBda8jq9NlcL+BgRnbl3AMiR0SEt6SGSmkAz7rEXLY/9eEFo4Ps9OU+yGCgaKIzfq3w9aFdQPuz+wzr1kiLKyEt/KAR5oNOs2aOFN5gkSdHy92bMEVlcBYSmZlQrWsEyBmaEBJljRXyqoej6ekCOUkyKTkkOR1LcIX3ko1Q6C23G4p8vHoPWcjpJZ4maUXEe1gRCJZ1l80V0LK3YvhnvLhtiSPuap6VVYRwERXapiZ7AWm/ZFjQNlzgIK64/k8NmedpcZ+DD/FHm6ASTKPV9oVMheCzYY5tvjbBotVhEYMaanYzMchE52APJGbdzvM7YZvQWndp++qhZ0fiHnLr1C/mUFPq3l/Kd1CH1xzRlklRISkqMdFVDeTCTUwjbwhCL127RVyNjxb2SwsIjMEDcYV6Qc4WaTpBBgWlmhUkaW1PdJq7wn05Gej4Xs7epe+0Rt2ZNKBaTgvVC2Qeo+mQTXqdBVv9E4hswFiM05i71Nwul/1m9jK6UGeXHLg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5594075b-7140-4631-9db9-08d875e22564
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 16:55:42.8072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoBBDv2knNp8KReVxLuEn8NUHQMxpTtMVQy+dp6A5kRoRnPhkl3sf7MkQQHZeA1L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1840
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Skip disabled sa to correct the cu_info and active_rbs for sienna cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I271682e11f3472cb5ba882e04329976059e06a13
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 402fe623c5d8..49ce4aaa2bac 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4579,12 +4579,17 @@ static void gfx_v10_0_setup_rb(struct amdgpu_device *adev)
 	int i, j;
 	u32 data;
 	u32 active_rbs = 0;
+	u32 bitmap;
 	u32 rb_bitmap_width_per_sh = adev->gfx.config.max_backends_per_se /
 					adev->gfx.config.max_sh_per_se;
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
+			bitmap = i * adev->gfx.config.max_sh_per_se + j;
+			if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
+			    ((gfx_v10_3_get_disabled_sa(adev) >> bitmap) & 1))
+				continue;
 			gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff);
 			data = gfx_v10_0_get_rb_active_bitmap(adev);
 			active_rbs |= data << ((i * adev->gfx.config.max_sh_per_se + j) *
@@ -8829,6 +8834,10 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
+			bitmap = i * adev->gfx.config.max_sh_per_se + j;
+			if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
+			    ((gfx_v10_3_get_disabled_sa(adev) >> bitmap) & 1))
+				continue;
 			mask = 1;
 			ao_bitmap = 0;
 			counter = 0;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
