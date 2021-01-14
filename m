Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C28EC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 06:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAFCD238E7
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 06:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFCD238E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE548898CA;
	Thu, 14 Jan 2021 06:14:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD25898A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 06:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e342PFY5k2CTAImq7FpJoyd60EUqwKuHZeqOEC5zQxSgFZm+jwevk4IBPO7M7SEgFO2/1KX4cdzkhHeZtrl8G7EI7x/CXmJFnz1UAWlqSuyltDDvg1QqZ0E++eFtH9+xVJxbkKAcadcmj5uy8r/wscvJH6iuSOKXUUgRPiPinktPaHEbLEXBMmO2LWKEJyr68uZ6zSbXz3ACqH/KRZ104LLnCJ9ZILSEaWGCRzedFilBK8phBORXotXPgWQmBOayiSEWtzxe72dUV08KHuy2tZkM4SvTe/6S0TvPT0D6w6V0dL/E8mmjxcZs1w3Ca6S9dHUWEquL9KFTSEHF+uk3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWhNYU19awBuwRsY5YwD5RVSfQP18IgA8e14j9nSX3o=;
 b=iNr9avbYjwdvlIEulK6aKptP/PHYs0HZ+Q81rwCeh4jJiUH0qVAxveXHeuQKRCcWCBIfi1+cwbpf+hQD9x0/jWuO74Ej/Atwq/SP7UGqNpadCdJf4bg6CK2SdkccxKpZ+Sy0bvHuR4bqK9mT4G1dyHm3025nBRCgpw8/JeTH9yszGEkxPgliZqAhiNK1MtGPd7xkDlcCCzhNUKWN1bS2zlRdgTa4FQjHp9SSqRdx9CGqrDNPKJAj4oXDISCeDx5imDq1XYOvFC3+XycM8MTVLf6cIcXIUU/qQBbZRUEi/Mk0vc56Wg3a/1pnVoo29H6WrdNUsrgdRvOiQIsLpyAu+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWhNYU19awBuwRsY5YwD5RVSfQP18IgA8e14j9nSX3o=;
 b=0tj2BoWRzCE+xkrSPXPNBcklbqFKTx+gExrpqvFht3/5Psk/kbKd+MWdU5pEy4TfkeHg9tFKkFYBPkKPb7T0ZRgljM7lmlubooXrqWo2uMu/yYfxQosZzK7VUqugx0gUTo6PuApcqgtg7RbADOiitQSGWJIs3S3TaqgXjeUA3no=
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9; Thu, 14 Jan 2021 06:14:22 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118%3]) with mapi id 15.20.3763.009; Thu, 14 Jan 2021
 06:14:22 +0000
From: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: check the result of copy_from_user in secure
 display debugfs (v2)
Thread-Topic: [PATCH] drm/amdgpu: check the result of copy_from_user in secure
 display debugfs (v2)
Thread-Index: AQHW6iTMxI9z0y7XmUSbubWWJKp/9qomdfZQgAAN+YCAACCc8A==
Date: Thu, 14 Jan 2021 06:14:22 +0000
Message-ID: <DM6PR12MB2812C0D48A96FEDFFB374CB690A80@DM6PR12MB2812.namprd12.prod.outlook.com>
References: <20210104175337.636270-1-alexander.deucher@amd.com>
 <CADnq5_NM4tVs+Mv6RmToa-BNNxnT_io0U145ZfwQK0e4a-y4_g@mail.gmail.com>
 <DM6PR12MB2812C14FDA19467A549E59DE90A80@DM6PR12MB2812.namprd12.prod.outlook.com>
 <MN2PR12MB448833D45364D89B8F7516D8F7A80@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB448833D45364D89B8F7516D8F7A80@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-14T04:16:56Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c361f152-c449-4e44-99cc-0000a654ddb6;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2021-01-14T06:14:19Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 6a46de5d-6669-4d32-a22f-0000352c839c
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65679433-4a6e-4e5c-86a4-08d8b853a291
x-ms-traffictypediagnostic: DM6PR12MB2939:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB29392DCB7A4F52499DAC705790A80@DM6PR12MB2939.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: st5Thn4ExZQpjeSQxe3mu1MmrHjLCZScOPYP8C0HlIgazywm9aESIAHMFbd3wF4HDjshMUjNljkFgwRvZGJ4YdI1dgIK5+1N4bbqSANqNg3ZE2+iNAbTMwYR1G/oXuAKAFstCVd3uiwUAYJZK6L5AHqukgwbZS/Bx+V69EpUFtUU/BN0sobqjXvYCjAQX6QY/uiNlYdy5wVd09tvo0hWHPWuuKyVvpQP6XM+PFm4O8EpCVNczgrC4KKOC1wTsqqXOzavtNt6veBXLeai08eovzZqgJdoxWhB0P2bG7iCpMjhs0eGjaaBQfxrDi8zRAxqdltqOAHSx9gnyq2FrDlCNl+AqMiQWudYhxS3PGvjRE+i66uudcl9DBcn7RCHTWR1LR4300k+KB9fHXorCMDojQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(53546011)(52536014)(6506007)(5660300002)(316002)(55016002)(8676002)(71200400001)(26005)(66446008)(186003)(66946007)(64756008)(66476007)(66556008)(76116006)(33656002)(9686003)(110136005)(7696005)(86362001)(2906002)(8936002)(478600001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?MzNtS2FUUjBXTWp0ZGFaUTlMOTRRVTVlOGpwWEs3b21Va1dHQVArZVJndmdS?=
 =?utf-8?B?QnVKaXlZdnFNdmIvZTMyVzcvVGZQSjgyYUdPTjZRU2VKUi9VZ09uK0xlU1li?=
 =?utf-8?B?V0FVWlFFTmJoMkg4SUE0Qml1d2RkTnJOU01jdUVqeFVVNFRTbi9YWitpK291?=
 =?utf-8?B?VjZ2Y3R4Y0kwMTlJRXc5RFlLczN2VzhBTlRQN3NhN1drU2xGejdGVU5RYkht?=
 =?utf-8?B?VlhmSkplY1RNaHorTFZ1enlWY2YzMDFyTmRKZk5iZTV5ZVhXVUhadXJKdE1Q?=
 =?utf-8?B?WGZzU3FhV1pLRHpBazVzVGVZSklSZHZnUzk1RVYyaEJpN3JIU1lRQ1BKV09Z?=
 =?utf-8?B?OUZiME16ZEMveUIycEt3UkE3MDNjOWJyNlkvYlF0Nk1kTVNjQlpXR00vdTAz?=
 =?utf-8?B?TGdzV2xSWUJPeWg1ZDU5RW9VV0ZpdXc4WW9TZGlNNzBUazFOcnhiNU5KWkx0?=
 =?utf-8?B?N0NxMVVTK3l5M1ZBVEErdHFmSG42amR3MWRMSHJwckwyaXE2WTFYTTUyMmVz?=
 =?utf-8?B?K0QxZTJERUlnRERwbW9PcmJRM3VWQjZrTmpKaGxQY0g4OTRDVFdZYjBJYmNh?=
 =?utf-8?B?UVBRZXZCYWNpakVsQ0JBM3NkOFZpRk8weDdwRU4rcmpCSWlQSDJXZ2V0cW9F?=
 =?utf-8?B?QU96RHFXN0Z1dzJsZHVTY2dFbDkxWU1vM3V4VzM2UVRVMDZ6MmdpS3U0dW1x?=
 =?utf-8?B?a3J5ZjlrZC9oK1VaVFU1ZVRZZWtFc3JqR2V0RGprQTBtbXRMczFZT0FXbS9X?=
 =?utf-8?B?ek5OaFlCSWsyaWpaMEUvUFhoc2p0Q2p3YldTMVlHbGxyNmR0ejhveVhIZlV2?=
 =?utf-8?B?QnhOaGNtRER1U21KcVhESG01UEFycnowLzVoWDRUcXZqUEQxeC9kZFBzdjNH?=
 =?utf-8?B?NTJ0NTFUZEl1SUVaL3BTRmFNcnd4eDNaRU9CeC8vU0RwaEowcDdCM1NjMmtH?=
 =?utf-8?B?U0ZnOEFHaWd5NUsrdjNyRDQ4ZmpzSFJMbktERUx4V1lDYnBzREFST3RkMllj?=
 =?utf-8?B?dWdPUW5LSVA3cWpEemVvMmFaUWVkaURkZk5uS0tVc1ZoVXh5SVJzbHI4Uk45?=
 =?utf-8?B?Mnd3bFZqcnk4bkVBOE5jZ0NsU0wxUEFXeXhic0NidVprSkN0MExGczdweWdi?=
 =?utf-8?B?MlBVcXBhTVhNVlQvWGV6WGdTMHFNanlNc1ZEUzFyWms1b2tLREN3ajlNa25G?=
 =?utf-8?B?eHBYMXdaNmpzbXBFYmNGRmIvYVlZY09OelhBS2t5cXl2cG5ZRzJtN2JSYVJD?=
 =?utf-8?B?alYyQlVrSmJaOHpDeXROWVhvTTRYbHFlODRLZ3BkUS9tS2FQcU43NjVLbytq?=
 =?utf-8?Q?oOl4pfbf94bSg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65679433-4a6e-4e5c-86a4-08d8b853a291
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 06:14:22.0910 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iCqW18y7wXC1gWMOn+6LuCevONFVDoEHZDbuomx5L5DjMdKkuyFsqldUcaoVADj+VKDJXtdrnBj1LV4GPe01jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2939
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

[AMD Public Use]

 Reviewed-by : Jinzhou Su <Jinzhou.Su@amd.com>

Regards,
Joe

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com> 
Sent: Thursday, January 14, 2021 12:17 PM
To: Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>; Alex Deucher <alexdeucher@gmail.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: check the result of copy_from_user in secure display debugfs (v2)

[AMD Public Use]

> -----Original Message-----
> From: Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>
> Sent: Wednesday, January 13, 2021 10:27 PM
> To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx list <amd- 
> gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: check the result of copy_from_user in 
> secure display debugfs (v2)
> 
> [AMD Official Use Only - Internal Distribution Only]
> 
> Thanks, Alex!

Can I get a Reviewed-by or Acked-by?

Thanks!

Alex

> 
> Regards,
> Joe
> 
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, January 14, 2021 11:24 AM
> To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Su, Jinzhou (Joe) 
> <Jinzhou.Su@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: check the result of copy_from_user in 
> secure display debugfs (v2)
> 
> + Joe
> 
> On Mon, Jan 4, 2021 at 12:53 PM Alex Deucher <alexdeucher@gmail.com>
> wrote:
> >
> > Make sure the copy succeeded.  Also fixes a warning.
> >
> > v2: fix the error check
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> > index 455978781380..b033344c5ce2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> > @@ -101,7 +101,9 @@ static ssize_t
> amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
> >                 return -EINVAL;
> >
> >         memset(str,  0, sizeof(str));
> > -       copy_from_user(str, buf, size);
> > +       ret = copy_from_user(str, buf, size);
> > +       if (ret)
> > +               return -EFAULT;
> >
> >         ret = pm_runtime_get_sync(dev->dev);
> >         if (ret < 0) {
> > --
> > 2.29.2
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
