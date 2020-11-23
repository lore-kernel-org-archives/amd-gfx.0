Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B62C2D0E4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 17:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85EA020724
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 17:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N257hOL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EA020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D68A16E054;
	Mon, 23 Nov 2020 17:26:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C2CF6E054
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 17:26:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pyjy6NVf22TFa9DujmnfKlGTUdi8dAuGs2ghMKtppyyMFkCDSTPfCEELz+2DGpL/ljWW4PxpY7rWnjztCB/xhT1W+acL7QHLAO5CjJq8Mwl0EnXy/wfinlah6ByLd4QDoZ3qAx8g26QQ0HNqdNSFoeNHdJiQxYYVTbmSCAwyDhHleTRJK3j6qq/z3qIAI9yq6A3WgeqYgDUHrhCvsGISDKSTJSho6wjzYNa4RnPNfQguKUOHTs1FWcvqVWikseZ9s2kiinTufnqgDZtgstOnM4ONjhEkQtbmDeOvphsaNhKuautnbrmcw0r2tWX1oKB4IKG1+Wfoqzc6lcmW8YWqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS96P+sx5ZlVbFezGO3URBrIceEwxtfvXyMJ0DDW9Nw=;
 b=VJitscYeP9HKx2g6wyjwDv4EcnOz2ohAcv1O0Xe/Cug4IVGdhdyvoJyE5WEBf62ckAWXWTle1jRfpctBa4fTTMX19+3vszG2cYx6vWwmeNn0H8LYL7cLBSeH66P65iFzeDnIT+NdusQgeZ/nlhdEPst5O/KENkSJXuMaCO6VlTjyeAeszSiMxKoRt9xqkSEPtjf0zz8G6Zfff8fybB2ptg0pGZl+7r6lbFvM9hkNmxLpJ/KzR5oJwl1EqxF0Ue3wuVV49FLSzx2QLu+UUAn1GfpskQerSCD0XjXuUjgMxOKnVhyEnoChsKJ1Ojv1imQG+geqS1ueKIFgNWCQUVb/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS96P+sx5ZlVbFezGO3URBrIceEwxtfvXyMJ0DDW9Nw=;
 b=N257hOL+SLTDXORQzojlkPgbrVpiPQHdNttHGYor2Hks5P8GZ3uncZGHUE6+yqu/Wadq3aJyOdDAhnc6+zDwpPUXmYJSlhLn5zX5JI7hBVqDuOy5Da2bRQ6IzFL5ftRXD/eQzzWorFQ5k1dkm8EhzbKfTW9zJN8VQVFnVgQ+Z2o=
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM5PR12MB1514.namprd12.prod.outlook.com (2603:10b6:4:f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.22; Mon, 23 Nov 2020 17:26:11 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::a468:7e14:5f23:d814]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::a468:7e14:5f23:d814%6]) with mapi id 15.20.3589.022; Mon, 23 Nov 2020
 17:26:11 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/dce_virtual: Enable DPM for vf
Thread-Topic: [PATCH] drm/amdgpu/dce_virtual: Enable DPM for vf
Thread-Index: AQHWwb18NEBMn7SrxEyZFCuEFJDPDKnV97Hw
Date: Mon, 23 Nov 2020 17:26:11 +0000
Message-ID: <DM6PR12MB383505B27F9BE77502DEE3A6F4FC0@DM6PR12MB3835.namprd12.prod.outlook.com>
References: <20201123172410.19735-1-shaoyun.liu@amd.com>
In-Reply-To: <20201123172410.19735-1-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-23T17:26:01Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a06afcb6-b864-4071-aacb-0000dbfba0eb;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-23T17:26:01Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 07f32c33-e205-4bfc-aef8-0000dec0a734
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3bc0:316:79ed:a3bf:618b:1760]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1e058a4-022e-4369-11f0-08d88fd4df28
x-ms-traffictypediagnostic: DM5PR12MB1514:
x-microsoft-antispam-prvs: <DM5PR12MB15141CA25580862FAFD2CFDAF4FC0@DM5PR12MB1514.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: egFK846LyeUoHObRtSsWy3XkiAPAGmbyTeJ6R80JQTMY+sn8NfOiyRMd4c4C9JHVZLZUsWQUsMZBy6RpElXFkoiLRusavLo9nGK6ZoyzuM12d7epDNsjMvN6I9a/q6PCurm75263aL6FlLqZvSXaNkZzcPLtRXRx+XsQbehHiQOMsAaIGYrFJViAGzhERQ8ENyrvir+OF3SSl+CbWdv6cEskrSb/2U9gVB6VbLcU2tq1nbdRtVFctzccqpMScdHEYNqh9atUSPtHXfwl84FwRDHO71Ls/kFPMjJlrWwUBozvhzHprte4R/kc7ZIrkR6I
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(71200400001)(76116006)(9686003)(55016002)(66946007)(33656002)(478600001)(66556008)(64756008)(66446008)(316002)(52536014)(8936002)(2906002)(86362001)(186003)(7696005)(8676002)(53546011)(5660300002)(6916009)(6506007)(83380400001)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZZ4x3H6Bw0yja4rGav9QLuuHi2ujOUejJoBUK6IiTbE00N848x5HHol3Lxrz?=
 =?us-ascii?Q?fLaANohiBDf+AM1bY+JgOD0MVh0AGswK7z7b9mNsJ8jo8+CMq3smNOk0ocxt?=
 =?us-ascii?Q?gh7acn4O8T1U6S6x04EvKscaUPxCT2Mwm0RCn6CJrtH+tIZiGpReaAlLg9aV?=
 =?us-ascii?Q?cs9tlyi1so3fTLvC4xcs7mDRwahN4yQX1tH2kOh7w2lgJBmccu/0R9Lo6C2m?=
 =?us-ascii?Q?88drwUrZVlgGLCLvBwuEF3kgfyOLryX1nNKSHla/DR0xEyTYKBMyXakWEgm1?=
 =?us-ascii?Q?Zrrv2UncKzFWbpp1f03JGB/40IdXPtcWZC6MBDXu4ue8HhzDEmPhsXLKqnRE?=
 =?us-ascii?Q?l1xQaEmXOw716A2GEKIKI5eBRE9sbMJxK/I9/T5WeWvYd+Dem5E4AeNuQ5sR?=
 =?us-ascii?Q?qGSzf3EbFTGlM26zYu+nhPjSE9syb8yht0zZqCqc5Wp93ZP5of07qwOr9eQ+?=
 =?us-ascii?Q?F/rJ2wyJFPrSysP4H3Q61E7VbRWBGkILStxd3MCD5m8RLsAtioPHritA9Pl9?=
 =?us-ascii?Q?xo/IpWBV4iVbmQOMBPVFSR9UsvNIQ67gbzpaup+8D4W4tXgt5OxH7hYqSOHF?=
 =?us-ascii?Q?q4eITat8wAyB7GV3Puzp4dmhZzvlpKPNvKIXlgvqxLIh8jhNjOrt6MuYLE8T?=
 =?us-ascii?Q?4R3huDGmFpgEV0TQGzQnq8j/dyqv4/Mfw2DwVRmN0yukLdDzBsKa/ck3bvrH?=
 =?us-ascii?Q?Ju64IcpQ8tbDYTiHMJ8puXO61hIZNMkkr5TpgJy6l0ujMT2/8v4/9b59+G2F?=
 =?us-ascii?Q?IAtQkKKNS/C9mbTM97gg8518R0xh0B36R2Pqsipch8ONlNX7+2kqE0AWKuG8?=
 =?us-ascii?Q?a1I0LL0JIJ4xjNcVdmlFFWh3M+6lul/AIMcs8ZAKOeMAmMuEPcy5yq5mi3P2?=
 =?us-ascii?Q?Y8l6CtuR4rE3jmjfsRKPSpLSDeHj2pSwL63atATofEjdxNqGhYFZ2zPcXF7j?=
 =?us-ascii?Q?J7C57NIW4ZpALB5/+0auSg=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e058a4-022e-4369-11f0-08d88fd4df28
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 17:26:11.1269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6/T1lXZdP2cVidt9uo+hy03Ghmxge57GCwgB+L4FnluMxVwq6er4kCV5UsTr533Fgm4x4iq3Y2bGiL8tkFj7w==
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Sorry , please ignore this one , I change the subject as suggested and resent the  patch

Shaoyun.liu

-----Original Message----- 
From: Liu, Shaoyun <Shaoyun.Liu@amd.com> 
Sent: Monday, November 23, 2020 12:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu/dce_virtual: Enable DPM for vf

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
