Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF92DC2D0E4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 17:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7BD20724
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 17:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aFBS7lEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7BD20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9185892E6;
	Mon, 23 Nov 2020 17:24:27 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A1F89173
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 17:24:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAwViYI0nRskV7mEWeOtBiG0gGNDY4lrcquBx5MoXqCa0ui5GX7X9J9wDFnGssWnPTjSavLYiBwRqcbcO/9VTDgxp5E0T+yRIukkvqkCuY745To74EpHz1U0yL2IWhJFj9oS+pZAAkjMGyH38KSYe4UxepIOsepnsOkwb9dLKADo13Mb10GbiFFg38diXcu2cFc1hdxziKNH09j+OxY8j5RR1PoU1ImIkEbFtAllSDB67n4ZNqVLAkBjkHHBDWevGi1T2KGddZEeZATL2fYPnQ6HdcapeSwWyKQU/9C6HMojiJpOfPRzhrKiN/p8CdseMurlTBIaT0T2Uj9qLHibGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LprIlm7q2jpNxMqGkiuwCBzL6OcOl2ltyrqUofU07wY=;
 b=kca8O1tNkvssZJil0gHcoMBr3lhffBfn3mxEn1WXBfPvxYNqrg4rakdB9OEoIS/hnIjcci6R4DgFkodzQymvqizSZlTO9jzmfNj94K4Qt/ap5nFpkdLyomHSb/OVduOBvXFR0woo5yyN0DMFF0gpThI5KryMYGUZYtAE1Okl49bWEBg6gnDxDDkuvwncZVSnrSK+1OqjMjnbHlmKpdgpQRyuVhXMcS6wwnKwDAwDe8SmjIJBerkP8iOORirbKePJXGsK+9Mew/JD5xkLuUbhZce8hgS6xf8SEgahMgNscqhy1DHF3IhLkREvOgI+wwqR9YNLmTWqinjWZpoo0OUZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LprIlm7q2jpNxMqGkiuwCBzL6OcOl2ltyrqUofU07wY=;
 b=aFBS7lEckI7ydH5DOARFKJBtBql3nXzpO+Da0O0upZWnj9JKDOX4/sU72g+I45M/OliIrSL0w5kfuhrkqdEzTZKN7626pK4l/vyoRdVir+07i/pgJBEF/UPkoGTmCht/BBmTc6hAKDivRuscjVvcNmWMK84r+NRSIPejIaBvELo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM5PR12MB1514.namprd12.prod.outlook.com (2603:10b6:4:f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.22; Mon, 23 Nov 2020 17:24:24 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::a468:7e14:5f23:d814]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::a468:7e14:5f23:d814%6]) with mapi id 15.20.3589.022; Mon, 23 Nov 2020
 17:24:23 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/dce_virtual: Enable DPM for vf
Date: Mon, 23 Nov 2020 12:24:10 -0500
Message-Id: <20201123172410.19735-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: CH2PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:610:4f::40) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 CH2PR18CA0030.namprd18.prod.outlook.com (2603:10b6:610:4f::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 17:24:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f096a9e2-fa0a-422e-70f3-08d88fd49eaf
X-MS-TrafficTypeDiagnostic: DM5PR12MB1514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15140243B786EAB3A0711B12F4FC0@DM5PR12MB1514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8IvRYvseiH2vALRdXNPyiis00EvnGtlxSBIcpuqzxAXHuP5UGUD4rfLtppeP63OO/GuHjU6z8iNHK+KauvLDudyLTNv0FfzzcONQ8HdnEAKK849QZbTNihy92/i3GcB4ve3mcpeoDDnoLYFnD60COcgU4r0zgcTg1O8vl+UmIOi/FPegvaTzXMt+VNlcq41XSm3ilCZJChE4lK0m4Oyz6jj/oun2ZEE7nP74r0gDBs3y7GOT660uKq8/M7pyml+IA2ZigCv/C3e6HK1QLVd1mgWs+degcLJMuDrZCAO14zN7q5vjUDmwEzWz9JIO7bLGqp8XfagEKXNvOCbYEspAibQ+X7kweRPyiETiGdDXamhS/EwO2glYu1i0sW1DCya6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(6666004)(4744005)(1076003)(2616005)(956004)(6486002)(4326008)(36756003)(26005)(66946007)(478600001)(66556008)(316002)(8936002)(2906002)(86362001)(186003)(52116002)(16526019)(7696005)(8676002)(5660300002)(6916009)(83380400001)(66476007)(43062003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: dCCglDC4e/eYhgiiz6ETuo0mm2sqW7VFqQ0noyr5XzVgFqCuAtyVEveZkOAj3aSBlbgVHvlFEfKtFOn0xjN2jKkSuHA/BWs/MecYIsARMaK7oHpXKvf45KlLgqtJRcT4YGBmb+EJNEVgsxze7bWZPeqjGxjfFy/QBKGG3mod7KzReSkhjmC/UyTFW4uaysO5m+sqXiWzCTclK9dh+vVdtEOYtSEnqGU/elzwrOrvDuFPJa8upfYXGY477+qtdmBplYle/eJPfKJ0RFOF1sB9CKd3+JM8Q00QP7nK9zkuOU8JROggEukGWnDUHZID+oEgnceQ/CL8Zzi9cD4uHbmENYfwGNdkmx9FbBrYFAvtO8Uo7Em2tA5mgpwdfRwfpUxX0+pNmv3jvroDUPGuIflgGtP2zw1br3KTlxDpGW3pWlj/isDPAyk7pS3pbB1WIx9+xSkooeOT/+0onxSsWDr1o4OZULoUE07sVWDVV+sUdCncjK61LP99ylxCLuDmSF+nlNsyBHcrKqyK/20DLRz8fz2b1fmP89EhL66MAPFgYLEhgXvwSLVWJfJb0ZZuU/hWKnz1nL6BPhEBjInizibRVrC3j8LfNfzZEU34xRZkgynFIaJg8qjFveaMLji5/K4Vijte2xUVE71tA1L6qHhI3oXX+kSLDuFm3vLfML+IdCPs/7MHvH7KvOBnZTC9Gt8IhbXrX0+tua57mi8LEcus8S/lnsYrQY3byFbHtciUNboT1FTNdAaukgHL35bqd0FvkLN7JJFwIrrgQ/uRJTChZjYoCWlpYNN3nghWe7r88ceO2pMjlEnLPuOMv4MlAYegXh5ea57I+PVveCZsOS9n/LHuNYB6K2OHlRioJsInFE9SpvH/+7U4w6w3V05E0QuIPUqUBq+D5ihxIToGIFFICw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f096a9e2-fa0a-422e-70f3-08d88fd49eaf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 17:24:23.4369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cz5FyqTT907Sh3lItbg+gz8m5ZndGIpnZzZxj1qQ75jXuOl+UMkM4483gwT5rCXi9vap9ZwrQSyCBxzGelFA4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

    This function actually control the vblank on/off. It shouldn't be bypassed for VF. Otherwise all the vblank based feature on VF will not work.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I77c6f57bb0af390b61f0049c12bf425b10d70d91
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index b4d4b76538d2..ffcc64ec6473 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -139,9 +139,6 @@ static void dce_virtual_crtc_dpms(struct drm_crtc *crtc, int mode)
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	unsigned type;
 
-	if (amdgpu_sriov_vf(adev))
-		return;
-
 	switch (mode) {
 	case DRM_MODE_DPMS_ON:
 		amdgpu_crtc->enabled = true;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
