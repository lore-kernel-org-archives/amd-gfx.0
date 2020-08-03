Return-Path: <SRS0=0vKA=BN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7223C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 01:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88799206F6
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 01:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Rd8u983J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88799206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A3DB6E0B9;
	Mon,  3 Aug 2020 01:54:55 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690066.outbound.protection.outlook.com [40.107.69.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71B1B6E0B9
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2020 01:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPfq3aaY1FS+XXIe/DFNVUW2KMc42D3TgGtc3uzI+LfEtlDjKpljfLKkAr9u+NdytAeBKMA89F3OJeZEA6iDb1//U+zl/zeFjGDG0iCZqLmri74hkDY72j3sz3gzAKoJjg3lInqKUFz6F1KAxjkNinTklZij4szgd33IgaXBW8DcTF2VDA3mly/tMvou8wvn2hGm32BQJebxdn65Rv1gdI1a6+aOn3Qqrwlj9RqnGyjEz6sJPunD2FresSqCFWRC1HfWGSsBKSlyrvI7EZyz/dCr+CjIDjeBw34uZedSXfkHFIEIFlKrSJ64JZzYNOpu8z/htyeVYD6wWT6OteMR7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f19SUQtjXh56Bg8oiq0zvGYVhGz3X6Jk0Zm56KL1nB8=;
 b=gS1x/FQ7RiWTtmI3IfN4iLmT2MO/7i7RvuiAkNB8I3tfMhsnDW0B75r+7fv05H52PfPYUsor9YC3+LklD3st9dFYoywmRi3w1/UdHI4LGrppOwqblY0egBWEr/fVWGp3oNahL8pM5EaFwrPOJPsUHuHz/LZgQ/DZTxxIvWLihtPglIwu3fknhqZ287FO0SvqTLN8rbqFig7FepUWx/jqIv26fTL9z/DF3SZCU7Sg0v5wH7T4JZIA0+h19zdz2MSfZAw33btPOM1F0HD+owtKLPkk4VQftuIhAyK/lKTHHwyTcFZWr1Rpi+zccpsACwJfsCL0kjeTyU0sJQyLMJgpow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f19SUQtjXh56Bg8oiq0zvGYVhGz3X6Jk0Zm56KL1nB8=;
 b=Rd8u983Ji3GyFfZJqT6uMM1rCqcBWwnQ0gyVWx09TIhMHXEYW4qvF5fwQGNEMbS/DjHWBxSkwFZvlhGGDKygGmT8uEENu8HKlJBjjGOU2IlQpk8/MSm5hTzMZ3xW+rd6dXbLC79lHFTolQVYjrYUjbrxXxhpEFNkyQdy8LZtS9Y=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM6PR12MB3081.namprd12.prod.outlook.com (2603:10b6:5:38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Mon, 3 Aug
 2020 01:54:44 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5%10]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 01:54:44 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix reload KMD hang on KIQ
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix reload KMD hang on KIQ
Thread-Index: AQHWZw9dPDGwF8EN3EaS3izz4/lEOakhttqAgAPsMpA=
Date: Mon, 3 Aug 2020 01:54:44 +0000
Message-ID: <DM5PR12MB170890EFFDD63DA297CDB254844D0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1596181868-28879-1-git-send-email-Monk.Liu@amd.com>
 <a1c5e0a7-d392-8774-d6a1-decb4f9c3235@amd.com>
In-Reply-To: <a1c5e0a7-d392-8774-d6a1-decb4f9c3235@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=926aec95-41fa-483e-8e1a-0000aaad0075;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-03T01:51:20Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f85a342e-327f-47c9-0787-08d8375031b1
x-ms-traffictypediagnostic: DM6PR12MB3081:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3081B0F692595D04D5D6514B844D0@DM6PR12MB3081.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZsgmKF8JTftE4SeuHlclzUnz8gzIPPNO/r1gY4hptvC/2W19SH3qx5B2JLmv5/YNvD+6Gs9dBkxKPlyUCfk8sBmeTWE6htPFyNnDAaQAEPmVMr/ya0RGApQPajAWaldU3xWvvUxssQLgTQFdGOC+g+S7urrhN9Kj1uIpEYhy6ET2FDoXzqBUFjkNN5VhUYyn87FcVNSkjEceyjqZTxQFTGX8wrhPzgLNsOqOWdMvFvtuhcX+RrGT6KF86J7hsvJECdwdGoMp3a37YLWN20br4Ws7itdwIEr8BDDsNrJQdN/MwXLI5IVJdBdGVIVzFsji
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(33656002)(86362001)(316002)(7696005)(8676002)(9686003)(55016002)(2906002)(110136005)(478600001)(8936002)(76116006)(66946007)(186003)(26005)(6506007)(53546011)(66476007)(52536014)(5660300002)(64756008)(71200400001)(83380400001)(66446008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: A4/B5wRy9Uk2cvHx48FyQD+0uHD9Vgj8YyyvfO84yN7lOn0DSEmlHIvO/MU4gcHEjzAWrasI4dN7seax1e0cms4CojzeJp5RjGc18wXjCNKneyEtOX9qLTCfmWlzwNNdV6PuyxOenGmTEA6nOvElmUuFXfVnHfnaj5OoiN7Eo3OLdt1wITu8Wq8c4MX1JsZvMtPG7Y8g6tqvjDg5LF8HdEdeBEtK+znq8AMq5uYtydfzNoSz04cBbUS1o39bj363lfPBVLSr6lTDBR8qPZSAW3ZADaci1xSIFZfWo+DxOx3IUASJCT9Y09B1633KO/C9ZQcIRzwyp/CuROU20Tq3sH1kDHLxdpQTETcjcOhmpdzCkpwDVt0d3jhn03j5W6u1tV7jAuRHOfQU3M6ohRSCseq3XqtWXl+W7RFEskRhgPNsRTTVGyCQ2SkJrVzEptb+aAVEevnykiqJ/mGCdmyLBdN11W7R5rLPVwJUs96WEFFv3JyvI6EGSDYt3GY57uZZrN2jVXEsC/2mHtYJUhS+BI5KUki7Sjwmb21I75ThB8m/XDxngbmUMw4Z17eGBf47P/9Xb4/d9f3zVC8ojuuq7IVkxr/YDqjG58o4vKlZUEuSNdD0AEeC6TH+okJNYUmkMM/NyWYbfTtvupeZPdW6gQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85a342e-327f-47c9-0787-08d8375031b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 01:54:44.2152 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJzr6jEYcmql6xgTKXVsK5ksKI+39tRQeziFkuirwTsvgf3+rcU/6tKU7VpuiUL8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
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

>>In gfx_v10_0_sw_fini the KIQ ring gets freed. Wouldn't that be the right place to stop the KIQ

KIQ (CPC) will never being stopped (the DISABLE on CPC is skipped for SRIOV ) for SRIOV in SW_FINI because SRIOV relies on KIQ to do world switch

But this is really a weird bug because even with the same approach it doesn't make KIQ (CP) hang on GFX9, only GFX10 need this patch ....

By now I do not have other good explanation or better fix than this one

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Friday, July 31, 2020 9:57 PM
To: Liu, Monk <Monk.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/amdgpu: fix reload KMD hang on KIQ

In gfx_v10_0_sw_fini the KIQ ring gets freed. Wouldn't that be the right place to stop the KIQ? Otherwise KIQ will hang as soon as someone allocates the memory that was previously used for the KIQ ring buffer and overwrites it with something that's not a valid PM4 packet.

Regards,
  Felix

Am 2020-07-31 um 3:51 a.m. schrieb Monk Liu:
> KIQ will hang if we try below steps:
> modprobe amdgpu
> rmmod amdgpu
> modprobe amdgpu sched_hw_submission=4
>
> the cause is that due to KIQ is always living there even after we
> unload KMD thus when doing the realod of KMD KIQ will crash upon its
> register programed with different values with the previous
> configuration (the config like HQD addr, ring size, is easily changed
> if we alter the sched_hw_submission)
>
> the fix is we must inactive KIQ first before touching any of its
> registgers
>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index db9f1e8..f571e25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6433,6 +6433,9 @@ static int gfx_v10_0_kiq_init_register(struct amdgpu_ring *ring)
>  struct v10_compute_mqd *mqd = ring->mqd_ptr;
>  int j;
>
> +/* activate the queue */
> +WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
> +
>  /* disable wptr polling */
>  WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
