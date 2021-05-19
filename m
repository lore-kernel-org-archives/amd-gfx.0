Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1942C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 16:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86AA9611BF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 16:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86AA9611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 120EB6EE0E;
	Wed, 19 May 2021 16:10:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54CD26EE0E
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 16:10:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiZC7HT1miqohSICK+i9cmcPPknASk9h291kAQuPqs/d/UgpWTxh4NpEZA+kAO02b0uv/EtHAbC5c2jq/VJh917Rs5xHLZhdI/7vC3PGjl8yRbprdiA/PSlUdnafqQptws2MMMwCefdS4BlAddy+Oe6nX7UkW4BXaeb5UbyuwXsGMBwiJpsO8Nm61IrArkYG3Ze3ijqRbDI9jUrV+jEl13dl4i90QGfx16eQzyO4W3rToVYkVqQG5CG2gFWFjQcCvAbgNnZ6yFDK4IQq28bNTEiv1C4GPOOeuykr1VbMjEMXirxtS/zzswifBh7au18F3VVWz7xoC8TXdnFclVh4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlSWXSEBHE1LmaPg/CR917kbjZgbAx7e7yZc4NfwUnA=;
 b=C5MQzr2t8KC8pdQ1GqkGUCLy9/U9Vx7JUrnXvbdho5DUoBQSjlXXOTBkA4NN3tdwRf9eeV5RzaMtWoKZkYkRnW2jSXiuiXcwC8Pp5jaESwmWz7p3VUuUVFpP6Vq32hjfU9U2JixaewVteTgcCjt29SJQlZ0Dzh7tTCPq+88cPMVO3XWOxtfGbR3tR91WTl7KDXAS0kTXeKGXD4LPayk4mznoVA1gYXfI79/m6+znVlG2+UBVIdLZz1ou0dz/rPlgRrqfw2FCf4G5qWQ07QOi+2hhmYtp9djH4WEwetGfZAPfXysJempBeU38tNLBt9UAmBKuI0ffAEMCYxoiaEBzWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlSWXSEBHE1LmaPg/CR917kbjZgbAx7e7yZc4NfwUnA=;
 b=j/3KfrA2x+w15DAQJ36c0LgZWWlBzfyAhHnF4/wx1GsRJa0uiDyXtedxJsTNujACvCj39mtXE3ungtaciNsKA05vQgMY/acrJVJmfOiR1Ma/F9zOXM3cNKGtFUEPxmyUFunSP2g8plXZykV/2PiKeK+h+YejLtMCN36cJZUObSg=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 16:10:39 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4129.031; Wed, 19 May 2021
 16:10:39 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>, "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Expose rfc4122 compliant UUID
Thread-Topic: [PATCH] drm/amdgpu: Expose rfc4122 compliant UUID
Thread-Index: AQHXSuEcuETPwjKslkm6HnhXoDebuarpSgcAgABpw8iAAPJHgIAAVltn
Date: Wed, 19 May 2021 16:10:39 +0000
Message-ID: <BYAPR12MB2840896BAF9A9C1E3AEE0B88F42B9@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20210517055413.28417-1-Jiawei.Gu@amd.com>
 <CADnq5_MLzM8+f3LU5QbDsn0haUNvKECQe3rR9HdoYpcooUpN6w@mail.gmail.com>
 <BYAPR12MB2840D36066EF94573527A8F4F42C9@BYAPR12MB2840.namprd12.prod.outlook.com>,
 <fb600c5f-7b0d-8a1d-1bb2-0d01b92439bd@gmail.com>
In-Reply-To: <fb600c5f-7b0d-8a1d-1bb2-0d01b92439bd@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-19T16:07:39.5188183Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fb90:3021:582b:f456:88fd:d521:b375]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0560a8a-6d42-4838-7306-08d91ae0a549
x-ms-traffictypediagnostic: BY5PR12MB3876:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB38763E06DC99768A1F12CD4BF42B9@BY5PR12MB3876.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V+i0izbKg699GqRi+U4/oERbWEn7L1hBvuih6TUJ56uujPQcZJMsrfnDBe31TI8Vi+tJHiplCm6sf6CX0k/RfVZQ5odF5RXe6vtI00yOC0SITtwIhSvy/mSBZiqyc+5ZbX7K96D9ptL14Xd9SLjsEk547zina/s1I4W6nJwpwWoiJOOP1tgkuP6P2XzBgfTlC0L4be9Y0ShxevkrEMLTzCudwwgKBrnjb0qqj21f9JnVBR6CizLPjdcYtoiK5RP3vZBn792y+5wHgkPEc5c6HaHAolP5PZUgbwCx5D64+4+g1LZvZAfL7bF4OtOUg5OG/q39i0qZ1qP96GuktZmKiB16ZUMFy4ZORykNNtTEqm1LHdmwzJvDxGNoG2fZKfatlcLDCziYJB1UInwhKAhX+Xj1s6epZNBNXgaD2HjAYZc18d8+l0VbSq6i753e3YfE4bSZbcq5HAcwXqmm57CHjSpiKyi77/uhw9QOQkWp0flr58/sLKD3WpZb5wQFLRpcRaBkc83w3goZZdpLyyrSkT2RP7l06geHcy9HnJWzVTa6fWR0XgN8Z1POm+UaMsGy9gjs2iRPTqluYytZM2Pg6AcJJty1YnTy+kCg5HHLydAGxKE0KReQTKe0IQtjGVvKbUuYsjnbfUGd6Jg1xywj4Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(5660300002)(86362001)(83380400001)(38100700002)(122000001)(2906002)(6636002)(19627405001)(52536014)(478600001)(45080400002)(4326008)(966005)(166002)(186003)(66476007)(66446008)(8676002)(66556008)(33656002)(64756008)(7696005)(71200400001)(55016002)(316002)(30864003)(6506007)(53546011)(9686003)(54906003)(8936002)(66946007)(110136005)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?zWZD+c5tpRG75KXIWbp2PCljoPjbt7Buz9GH2W005JGUG9LeBhW/DwdjP8?=
 =?iso-8859-1?Q?h8mexewihWU5H5E5lsvOwdavLPglIEXUCUSdiZXy75A5kqNy+gDGGlyTQn?=
 =?iso-8859-1?Q?VfMYT1bJhh1/YiMHxag+vc7hhNrMzs3snx7lOrqq/RSjeA6C7XBWQUSBWU?=
 =?iso-8859-1?Q?TwmFU+8+he/5QWsmB5jWK3ZJ4UkyvP2+QbtRAE+6VVebzA7LUx+vgk8vCI?=
 =?iso-8859-1?Q?xlT+k0Qqs8FXpe/C/KrN8N/rLa74vZ/rDHSb8KzUTP+FnC037VUYuso94B?=
 =?iso-8859-1?Q?QVijLpY9yqIl+7Y8Hl5OaHkCX48xXITl9o5iJ6ANX9J8FtUZaAdLYc0fx6?=
 =?iso-8859-1?Q?CT3zU7AUEkAouL+TjVBGip0JYVxyBkYOUSfFGLLHt0PMAwL/ICzW+TcnKU?=
 =?iso-8859-1?Q?hiOoC6NPA6Gh47TAETOTNAUjZ0HKlOFG1P4zkUf2m9y9MFBJbPp8vBvKTy?=
 =?iso-8859-1?Q?5MuXd9e8NcNHaDawlhCwbxwEFJivW/68Y0HEwsC/W2Wqm5ObwaRPm5Q/zi?=
 =?iso-8859-1?Q?H2+acLg/qK0G0dh+I6pxeUzbYvFd1GjA4ma37bjq4cvQ3pkjGQBGfOUyyI?=
 =?iso-8859-1?Q?VDALRoW9Coejmbr0ZTjp+7wDAKbX86wiQodm2tEVbzv5gILsGqpPZJrXJv?=
 =?iso-8859-1?Q?w3rw8f1B4OWx20R5i7ZcszqxLX3slelSIPAf4jZXqN94UofaV56WJU+9eR?=
 =?iso-8859-1?Q?edFkrnO4KzIVH1ZrTljJl7lMianAIuBk25Lu4XhVtf7B2ewLGW2KHWzZ8B?=
 =?iso-8859-1?Q?bs0cXtLChCZX04jSVgzfKQqJDjgoAQxAoMe9xjzw1PO0h22KpH+g0Ys6vf?=
 =?iso-8859-1?Q?L+EivUBzj6qFahKqEV0qGdFxUn9AZUKYC49abmqubotd3D0c1iNbm1WMJL?=
 =?iso-8859-1?Q?PAODaC220Us+PbNMv0nEUcFNyAuPOPKI0FlXV32aUH9XL2K+8XxiwkT0UB?=
 =?iso-8859-1?Q?06RfZmmFqWrFoOjjMw0RAg6248RlYwPxMx8LojkBN/teJ5hb3y/Co/5N5N?=
 =?iso-8859-1?Q?YiSSmA4/7ZBajmugwR2gxR+diO4VAr9oCajAEiYyWf1jaZck3wnP/4YFNr?=
 =?iso-8859-1?Q?TGOf2376wGSNbwW8BXErjMJrEHg0Lx8ARV96NCSr+7EmJDh0AzsPrGxCV2?=
 =?iso-8859-1?Q?vrSpemwrhdsIx4Al+UtJS0shkd8UFxzDIaxXKQuOW92/MhglRxIpUfdSqD?=
 =?iso-8859-1?Q?rqzq8Xtd+2ttY1LAmjkmgxIuX9jq5rPQC5D7RssDUqtKnv9gVhWXyeo6GX?=
 =?iso-8859-1?Q?1TO8w9oZcp8vs+3avD5z9gpUnYck9HxSIWygSemR603naZ4ua6wltvGy+4?=
 =?iso-8859-1?Q?m2orLezNEUYkMYGf3IJciT0Xc+RqjnTF6utnGgaVi8H08+SextiP7Zp5P1?=
 =?iso-8859-1?Q?LhSFxoSNc+FP0NrGzauYjnAawbf7HClblVk7DoY7dAeURiB3vnzJMtm633?=
 =?iso-8859-1?Q?tGTO0WuE0tTy9wXcQ1uWblxjYcG1dqDAwxWy+w=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0560a8a-6d42-4838-7306-08d91ae0a549
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 16:10:39.6637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gFMMwJQ0g9w0eO6mnVZXIWYMu/LDvp2yypXYoh5Bksld6sSGDIPnI9HLdGYoUtjB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3876
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0274452409=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0274452409==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2840896BAF9A9C1E3AEE0B88F42B9BYAPR12MB2840namp_"

--_000_BYAPR12MB2840896BAF9A9C1E3AEE0B88F42B9BYAPR12MB2840namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

For the case of virtualization, for example, the serial number has no relat=
ion to the uuid. Which means that at least for virtualization the node need=
s to be created. This may also be the case on other gpus.

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Wednesday, May 19, 2021 3:58:35 AM
To: Nieto, David M <David.Nieto@amd.com>; Alex Deucher <alexdeucher@gmail.c=
om>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Cc: Deng, Emily <Emily.Deng@amd.com>; amd-gfx list <amd-gfx@lists.freedeskt=
op.org>
Subject: Re: [PATCH] drm/amdgpu: Expose rfc4122 compliant UUID

Well I don't think generating an UUID in the kernel makes sense in general.

What we can do is to expose the serial number of the device, so that usersp=
ace can create an UUID if necessary.

Christian.

Am 18.05.21 um 22:37 schrieb Nieto, David M:

[AMD Official Use Only]

I think the sysfs node should be moved into amdgpu_pm instead of the amdgpu=
_device.c and generation of the unique_id should be moved to navi10_ppt.c, =
similarly to other chips.

Thinking it better, generating a random UUID makes no sense in the driver l=
evel, any application can do the same thing on userspace if the UUID sysfs =
node is empty.

So, I think we should do the same as with the unique_id node, if the unique=
_id is not present, just return.

David
________________________________
From: Alex Deucher <alexdeucher@gmail.com><mailto:alexdeucher@gmail.com>
Sent: Tuesday, May 18, 2021 7:12 AM
To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com><mailto:JiaWei.Gu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freed=
esktop.org>; Deng, Emily <Emily.Deng@amd.com><mailto:Emily.Deng@amd.com>; N=
ieto, David M <David.Nieto@amd.com><mailto:David.Nieto@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Expose rfc4122 compliant UUID

On Mon, May 17, 2021 at 1:54 AM Jiawei Gu <Jiawei.Gu@amd.com><mailto:Jiawei=
.Gu@amd.com> wrote:
>
> Introduce an RFC 4122 compliant UUID for the GPUs derived
> from the unique GPU serial number (from Vega10) on gpus.
> Where this serial number is not available, use a compliant
> random UUID.
>
> For virtualization, the unique ID is passed by the host driver
> in the PF2VF structure.
>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com><mailto:Jiawei.Gu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 36 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 96 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  4 +
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  4 +-
>  drivers/gpu/drm/amd/amdgpu/nv.c             |  5 ++
>  drivers/gpu/drm/amd/amdgpu/nv.h             |  3 +
>  6 files changed, 146 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 3147c1c935c8..ad6d4b55be6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -802,6 +802,40 @@ struct amd_powerplay {
>                                           (rid =3D=3D 0x01) || \
>                                           (rid =3D=3D 0x10))))
>
> +union amdgpu_uuid_info {
> +       struct {
> +               union {
> +                       struct {
> +                               uint32_t did    : 16;
> +                               uint32_t fcn    : 8;
> +                               uint32_t asic_7 : 8;
> +                       };
> +                       uint32_t time_low;
> +               };
> +
> +               struct {
> +                       uint32_t time_mid  : 16;
> +                       uint32_t time_high : 12;
> +                       uint32_t version   : 4;
> +               };
> +
> +               struct {
> +                       struct {
> +                               uint8_t clk_seq_hi : 6;
> +                               uint8_t variant    : 2;
> +                       };
> +                       union {
> +                               uint8_t clk_seq_low;
> +                               uint8_t asic_6;
> +                       };
> +                       uint16_t asic_4;
> +               };
> +
> +               uint32_t asic_0;
> +       };
> +       char as_char[16];
> +};
> +
>  #define AMDGPU_RESET_MAGIC_NUM 64
>  #define AMDGPU_MAX_DF_PERFMONS 4
>  struct amdgpu_device {
> @@ -1074,6 +1108,8 @@ struct amdgpu_device {
>         char                            product_name[32];
>         char                            serial[20];
>
> +       union amdgpu_uuid_info uuid_info;
> +
>         struct amdgpu_autodump          autodump;
>
>         atomic_t                        throttling_logging_enabled;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 7c6c435e5d02..079841e1cb52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -37,6 +37,7 @@
>  #include <linux/vgaarb.h>
>  #include <linux/vga_switcheroo.h>
>  #include <linux/efi.h>
> +#include <linux/uuid.h>
>  #include "amdgpu.h"
>  #include "amdgpu_trace.h"
>  #include "amdgpu_i2c.h"
> @@ -3239,11 +3240,104 @@ static int amdgpu_device_get_job_timeout_setting=
s(struct amdgpu_device *adev)
>         return ret;
>  }
>
> +static bool amdgpu_is_uuid_info_empty(union amdgpu_uuid_info *uuid_info)
> +{
> +       return (uuid_info->time_low    =3D=3D 0 &&
> +                       uuid_info->time_mid    =3D=3D 0 &&
> +                       uuid_info->time_high   =3D=3D 0 &&
> +                       uuid_info->version     =3D=3D 0 &&
> +                       uuid_info->clk_seq_hi  =3D=3D 0 &&
> +                       uuid_info->variant     =3D=3D 0 &&
> +                       uuid_info->clk_seq_low =3D=3D 0 &&
> +                       uuid_info->asic_4      =3D=3D 0 &&
> +                       uuid_info->asic_0      =3D=3D 0);
> +}
> +
> +static void amdgpu_gen_uuid_info(union amdgpu_uuid_info *uuid_info,
> +                               uint64_t serial, uint16_t did, uint8_t id=
x)
> +{
> +       uint16_t clk_seq =3D 0;
> +
> +       /* Step1: insert clk_seq */
> +       uuid_info->clk_seq_low =3D (uint8_t)clk_seq;
> +       uuid_info->clk_seq_hi  =3D (uint8_t)(clk_seq >> 8) & 0x3F;
> +
> +       /* Step2: insert did */
> +       uuid_info->did =3D did;
> +
> +       /* Step3: insert vf idx */
> +       uuid_info->fcn =3D idx;
> +
> +       /* Step4: insert serial */
> +       uuid_info->asic_0 =3D (uint32_t)serial;
> +       uuid_info->asic_4 =3D (uint16_t)(serial >> 4 * 8) & 0xFFFF;
> +       uuid_info->asic_6 =3D (uint8_t)(serial >> 6 * 8) & 0xFF;
> +       uuid_info->asic_7 =3D (uint8_t)(serial >> 7 * 8) & 0xFF;
> +
> +       /* Step5: insert version */
> +       uuid_info->version =3D 1;
> +       /* Step6: insert variant */
> +       uuid_info->variant =3D 2;
> +}
> +
> +/* byte reverse random uuid */
> +static void amdgpu_gen_uuid_random(union amdgpu_uuid_info *uuid_info)
> +{
> +       char b0, b1;
> +       int i;
> +
> +       generate_random_uuid(uuid_info->as_char);
> +       for (i =3D 0; i < 8; i++) {
> +               b0 =3D uuid_info->as_char[i];
> +               b1 =3D uuid_info->as_char[16-i];
> +               uuid_info->as_char[16-i] =3D b0;
> +               uuid_info->as_char[i] =3D b1;
> +       }
> +}
> +
> +/**
> + *
> + * The amdgpu driver provides a sysfs API for providing uuid data.
> + * The file uuid_info is used for this, and returns string of amdgpu uui=
d.
> + */
> +static ssize_t amdgpu_get_uuid_info(struct device *dev,
> +                                     struct device_attribute *attr,
> +                                     char *buf)
> +{
> +       struct drm_device *ddev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(ddev);//ddev->dev_priv=
ate;
> +       union amdgpu_uuid_info *uuid =3D &adev->uuid_info;
> +
> +       return sysfs_emit(buf,
> +                                       "%08x-%04x-%x%03x-%02x%02x-%04x%0=
8x\n",
> +                                       uuid->time_low,
> +                                       uuid->time_mid,
> +                                       uuid->version,
> +                                       uuid->time_high,
> +                                       uuid->clk_seq_hi |
> +                                       uuid->variant << 6,
> +                                       uuid->clk_seq_low,
> +                                       uuid->asic_4,
> +                                       uuid->asic_0);
> +}
> +static DEVICE_ATTR(uuid_info, S_IRUGO, amdgpu_get_uuid_info, NULL);
> +
> +static void amdgpu_uuid_init(struct amdgpu_device *adev)
> +{
> +       if (amdgpu_is_uuid_info_empty(&adev->uuid_info)) {
> +               if (adev->unique_id)
> +                       amdgpu_gen_uuid_info(&adev->uuid_info, adev->uniq=
ue_id, adev->pdev->device, 31);
> +               else
> +                       amdgpu_gen_uuid_random(&adev->uuid_info);
> +       }
> +}
> +
>  static const struct attribute *amdgpu_dev_attributes[] =3D {
>         &dev_attr_product_name.attr,
>         &dev_attr_product_number.attr,
>         &dev_attr_serial_number.attr,
>         &dev_attr_pcie_replay_count.attr,
> +       &dev_attr_uuid_info.attr,
>         NULL
>  };
>
> @@ -3551,6 +3645,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>
>         amdgpu_fbdev_init(adev);
>
> +       amdgpu_uuid_init(adev);
> +
>         r =3D amdgpu_pm_sysfs_init(adev);
>         if (r) {
>                 adev->pm_sysfs_en =3D false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index b71dd1deeb2d..2dfebfe38079 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -429,6 +429,7 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_de=
vice *adev,
>  static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
>  {
>         struct amd_sriov_msg_pf2vf_info_header *pf2vf_info =3D adev->virt=
.fw_reserve.p_pf2vf;
> +       union amdgpu_uuid_info *uuid =3D &adev->uuid_info;
>         uint32_t checksum;
>         uint32_t checkval;
>
> @@ -498,6 +499,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_=
device *adev)
>
>                 adev->unique_id =3D
>                         ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->=
uuid;
> +
> +               memcpy(uuid, &((struct amd_sriov_msg_pf2vf_info *)pf2vf_i=
nfo)->uuid_info_reserved,
> +                       sizeof(union amdgpu_uuid_info));
>                 break;
>         default:
>                 DRM_ERROR("invalid pf2vf version\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgv_sriovmsg.h
> index a434c71fde8e..0d1d36e82aeb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -203,9 +203,9 @@ struct amd_sriov_msg_pf2vf_info {
>                 uint32_t encode_max_frame_pixels;
>         } mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
>         /* UUID info */
> -       struct amd_sriov_msg_uuid_info uuid_info;
> +       uint32_t uuid_info_reserved[4];
>         /* reserved */
> -       uint32_t reserved[256 - 47];
> +       uint32_t reserved[256-47];
>  };
>
>  struct amd_sriov_msg_vf2pf_info_header {
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu=
/nv.c
> index 32c34470404c..16d4a480f4c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1167,6 +1167,11 @@ static int nv_common_early_init(void *handle)
>                 if (amdgpu_sriov_vf(adev))
>                         adev->rev_id =3D 0;
>                 adev->external_rev_id =3D adev->rev_id + 0xa;
> +               if (!amdgpu_sriov_vf(adev)) {
> +                       adev->unique_id =3D RREG32(mmFUSE_DATA_730);
> +                       adev->unique_id <<=3D 32;
> +                       adev->unique_id |=3D RREG32(mmFUSE_DATA_729);
> +               }

I would suggest putting this in navi10_get_unique_id() in navi10_ppt.c
for consistency since we query this from the SMU on most other asics.

Alex



>                 break;
>         case CHIP_SIENNA_CICHLID:
>                 adev->cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu=
/nv.h
> index 515d67bf249f..520ac2b98744 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.h
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.h
> @@ -26,6 +26,9 @@
>
>  #include "nbio_v2_3.h"
>
> +#define mmFUSE_DATA_729 (0x176D9)
> +#define mmFUSE_DATA_730 (0x176DA)
> +
>  void nv_grbm_select(struct amdgpu_device *adev,
>                     u32 me, u32 pipe, u32 queue, u32 vmid);
>  void nv_set_virt_ops(struct amdgpu_device *adev);
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdavid.=
nieto%40amd.com%7Cb6a43b8c156c4a6964e208d91a070e84%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637569439877514988%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D=
7lpRnRgRwKASGUmfr3RChO0P6QfRbcpMFggQl6HO%2Bss%3D&amp;reserved=3D0<https://n=
am11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedeskto=
p.org%2Fmailman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7CDavid.Nieto%40amd.com=
%7C43a11e657f9b44afb21608d91ab50e02%7C3dd8961fe4884e608e11a82d994e183d%7C0%=
7C0%7C637570187200925847%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj=
oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3Dn1gNKk7klknJ8RNwi8B=
V%2FiriWegB8RPGa2iBjcnU%2BVM%3D&reserved=3D0>



_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam11.safeli=
nks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmai=
lman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7CDavid.Nieto%40amd.com%7C43a11e65=
7f9b44afb21608d91ab50e02%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63757=
0187200935841%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL=
CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DYT88Ow13cLBgyzhbzCHgYhnLE5mWaK=
5GkN60o%2Fpm69o%3D&reserved=3D0>



--_000_BYAPR12MB2840896BAF9A9C1E3AEE0B88F42B9BYAPR12MB2840namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div>
<div>
<div dir=3D"ltr" style=3D"color: rgb(0, 0, 0); background-color: rgb(255, 2=
55, 255);">
For the case of virtualization, for example, the serial number has no relat=
ion to the uuid. Which means that at least for virtualization the node need=
s to be created. This may also be the case on other gpus.</div>
</div>
<div><br>
</div>
<div class=3D"ms-outlook-ios-signature"></div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Wednesday, May 19, 2021 3:58:35 AM<br>
<b>To:</b> Nieto, David M &lt;David.Nieto@amd.com&gt;; Alex Deucher &lt;ale=
xdeucher@gmail.com&gt;; Gu, JiaWei (Will) &lt;JiaWei.Gu@amd.com&gt;<br>
<b>Cc:</b> Deng, Emily &lt;Emily.Deng@amd.com&gt;; amd-gfx list &lt;amd-gfx=
@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Expose rfc4122 compliant UUID</font=
>
<div>&nbsp;</div>
</div>
<div>Well I don't think generating an UUID in the kernel makes sense in gen=
eral.<br>
<br>
What we can do is to expose the serial number of the device, so that usersp=
ace can create an UUID if necessary.<br>
<br>
Christian.<br>
<br>
<div class=3D"x_moz-cite-prefix">Am 18.05.21 um 22:37 schrieb Nieto, David =
M:<br>
</div>
<blockquote type=3D"cite"><style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0000FF=
; margin:15pt">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
I think the sysfs node should be moved into amdgpu_pm instead of the amdgpu=
_device.c and generation of the unique_id should be moved to navi10_ppt.c, =
similarly to other chips.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
Thinking it better, generating a random UUID makes no sense in the driver l=
evel, any application can do the same thing on userspace if the UUID sysfs =
node is empty.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
So, I think we should do the same as with the unique_id node, if the unique=
_id is not present, just return.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
David</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Alex Deucher
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:alexdeucher@gmail.com">=
&lt;alexdeucher@gmail.com&gt;</a><br>
<b>Sent:</b> Tuesday, May 18, 2021 7:12 AM<br>
<b>To:</b> Gu, JiaWei (Will) <a class=3D"x_moz-txt-link-rfc2396E" href=3D"m=
ailto:JiaWei.Gu@amd.com">
&lt;JiaWei.Gu@amd.com&gt;</a><br>
<b>Cc:</b> amd-gfx list <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto=
:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Deng, Emily <a class=3D"x_moz-tx=
t-link-rfc2396E" href=3D"mailto:Emily.Deng@amd.com">
&lt;Emily.Deng@amd.com&gt;</a>; Nieto, David M <a class=3D"x_moz-txt-link-r=
fc2396E" href=3D"mailto:David.Nieto@amd.com">
&lt;David.Nieto@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Expose rfc4122 compliant UUID</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">On Mon, May 17, 2021 at 1:54 AM Jiawei Gu <a cla=
ss=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:Jiawei.Gu@amd.com">
&lt;Jiawei.Gu@amd.com&gt;</a> wrote:<br>
&gt;<br>
&gt; Introduce an RFC 4122 compliant UUID for the GPUs derived<br>
&gt; from the unique GPU serial number (from Vega10) on gpus.<br>
&gt; Where this serial number is not available, use a compliant<br>
&gt; random UUID.<br>
&gt;<br>
&gt; For virtualization, the unique ID is passed by the host driver<br>
&gt; in the PF2VF structure.<br>
&gt;<br>
&gt; Signed-off-by: Jiawei Gu <a class=3D"x_moz-txt-link-rfc2396E" href=3D"=
mailto:Jiawei.Gu@amd.com">
&lt;Jiawei.Gu@amd.com&gt;</a><br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; | 36 ++++++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp; | 96 ++++++++++=
+++++++++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c&nbsp;&nbsp;&nbsp; |&nbs=
p; 4 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |&nbsp; 4 +-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 ++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/nv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +<br>
&gt;&nbsp; 6 files changed, 146 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index 3147c1c935c8..ad6d4b55be6c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -802,6 +802,40 @@ struct amd_powerplay {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (rid =3D=3D 0x01) || \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (rid =3D=3D 0x10))))<br>
&gt;<br>
&gt; +union amdgpu_uuid_info {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; union {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t did&nbsp;&nbsp;&nbsp; : 16;<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fcn&nbsp;&nbsp;&nbsp; : 8;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t asic_7 : 8;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ti=
me_low;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; };<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ti=
me_mid&nbsp; : 16;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ti=
me_high : 12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ve=
rsion&nbsp;&nbsp; : 4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; };<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t clk_seq_hi : 6;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t variant&nbsp;&nbsp;&nbsp; : 2;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t clk_seq_low;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t asic_6;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t as=
ic_4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; };<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t asic_0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char as_char[16];<br>
&gt; +};<br>
&gt; +<br>
&gt;&nbsp; #define AMDGPU_RESET_MAGIC_NUM 64<br>
&gt;&nbsp; #define AMDGPU_MAX_DF_PERFMONS 4<br>
&gt;&nbsp; struct amdgpu_device {<br>
&gt; @@ -1074,6 +1108,8 @@ struct amdgpu_device {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; produ=
ct_name[32];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seria=
l[20];<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union amdgpu_uuid_info uuid_info=
;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_autodump=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; autodump;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; throttling_logging_enable=
d;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 7c6c435e5d02..079841e1cb52 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -37,6 +37,7 @@<br>
&gt;&nbsp; #include &lt;linux/vgaarb.h&gt;<br>
&gt;&nbsp; #include &lt;linux/vga_switcheroo.h&gt;<br>
&gt;&nbsp; #include &lt;linux/efi.h&gt;<br>
&gt; +#include &lt;linux/uuid.h&gt;<br>
&gt;&nbsp; #include &quot;amdgpu.h&quot;<br>
&gt;&nbsp; #include &quot;amdgpu_trace.h&quot;<br>
&gt;&nbsp; #include &quot;amdgpu_i2c.h&quot;<br>
&gt; @@ -3239,11 +3240,104 @@ static int amdgpu_device_get_job_timeout_sett=
ings(struct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; +static bool amdgpu_is_uuid_info_empty(union amdgpu_uuid_info *uuid_in=
fo)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (uuid_info-&gt;time_low&n=
bsp;&nbsp;&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&=
gt;time_mid&nbsp;&nbsp;&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&=
gt;time_high&nbsp;&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&=
gt;version&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&=
gt;clk_seq_hi&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&=
gt;variant&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&=
gt;clk_seq_low =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&=
gt;asic_4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D 0 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&=
gt;asic_0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D 0);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void amdgpu_gen_uuid_info(union amdgpu_uuid_info *uuid_info,<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t serial, uint16_t did, uint8_t=
 idx)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t clk_seq =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Step1: insert clk_seq */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;clk_seq_low =3D (u=
int8_t)clk_seq;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;clk_seq_hi&nbsp; =
=3D (uint8_t)(clk_seq &gt;&gt; 8) &amp; 0x3F;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Step2: insert did */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;did =3D did;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Step3: insert vf idx */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;fcn =3D idx;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Step4: insert serial */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;asic_0 =3D (uint32=
_t)serial;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;asic_4 =3D (uint16=
_t)(serial &gt;&gt; 4 * 8) &amp; 0xFFFF;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;asic_6 =3D (uint8_=
t)(serial &gt;&gt; 6 * 8) &amp; 0xFF;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;asic_7 =3D (uint8_=
t)(serial &gt;&gt; 7 * 8) &amp; 0xFF;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Step5: insert version */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;version =3D 1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Step6: insert variant */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid_info-&gt;variant =3D 2;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* byte reverse random uuid */<br>
&gt; +static void amdgpu_gen_uuid_random(union amdgpu_uuid_info *uuid_info)=
<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char b0, b1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; generate_random_uuid(uuid_info-&=
gt;as_char);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 8; i++) {<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; b0 =3D uuid_info-&gt;as_char[i];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; b1 =3D uuid_info-&gt;as_char[16-i];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uuid_info-&gt;as_char[16-i] =3D b0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uuid_info-&gt;as_char[i] =3D b1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt; +/**<br>
&gt; + *<br>
&gt; + * The amdgpu driver provides a sysfs API for providing uuid data.<br=
>
&gt; + * The file uuid_info is used for this, and returns string of amdgpu =
uuid.<br>
&gt; + */<br>
&gt; +static ssize_t amdgpu_get_uuid_info(struct device *dev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; st=
ruct device_attribute *attr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ch=
ar *buf)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D dev_=
get_drvdata(dev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D d=
rm_to_adev(ddev);//ddev-&gt;dev_private;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union amdgpu_uuid_info *uuid =3D=
 &amp;adev-&gt;uuid_info;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sysfs_emit(buf,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &quot;%08x-%04x-%x%03x-%02x%02x-%04x%08x\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uuid-&gt;time_low,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uuid-&gt;time_mid,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uuid-&gt;version,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uuid-&gt;time_high,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uuid-&gt;clk_seq_hi |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uuid-&gt;variant &lt;&lt; 6,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uuid-&gt;clk_seq_low,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uuid-&gt;asic_4,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uuid-&gt;asic_0);<br>
&gt; +}<br>
&gt; +static DEVICE_ATTR(uuid_info, S_IRUGO, amdgpu_get_uuid_info, NULL);<b=
r>
&gt; +<br>
&gt; +static void amdgpu_uuid_init(struct amdgpu_device *adev)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_is_uuid_info_empty(&a=
mp;adev-&gt;uuid_info)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (adev-&gt;unique_id)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gen_=
uuid_info(&amp;adev-&gt;uuid_info, adev-&gt;unique_id, adev-&gt;pdev-&gt;de=
vice, 31);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gen_=
uuid_random(&amp;adev-&gt;uuid_info);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; static const struct attribute *amdgpu_dev_attributes[] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_product_=
name.attr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_product_=
number.attr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_serial_n=
umber.attr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_pcie_rep=
lay_count.attr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_uuid_info.attr,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt; @@ -3551,6 +3645,8 @@ int amdgpu_device_init(struct amdgpu_device *ade=
v,<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fbdev_init(adev=
);<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_uuid_init(adev);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_pm_sysfs_=
init(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm_sysfs_en =3D false;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_virt.c<br>
&gt; index b71dd1deeb2d..2dfebfe38079 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt; @@ -429,6 +429,7 @@ static void amdgpu_virt_add_bad_page(struct amdgpu=
_device *adev,<br>
&gt;&nbsp; static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *ade=
v)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_sriov_msg_p=
f2vf_info_header *pf2vf_info =3D adev-&gt;virt.fw_reserve.p_pf2vf;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union amdgpu_uuid_info *uuid =3D=
 &amp;adev-&gt;uuid_info;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t checksum;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t checkval;<br>
&gt;<br>
&gt; @@ -498,6 +499,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdg=
pu_device *adev)<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;unique_id =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=
(struct amd_sriov_msg_pf2vf_info *)pf2vf_info)-&gt;uuid;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; memcpy(uuid, &amp;((struct amd_sriov_msg_pf2vf_info *)pf2vf=
_info)-&gt;uuid_info_reserved,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(unio=
n amdgpu_uuid_info));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;invalid pf2vf version\n&quot;);<b=
r>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu=
/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
&gt; index a434c71fde8e..0d1d36e82aeb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h<br>
&gt; @@ -203,9 +203,9 @@ struct amd_sriov_msg_pf2vf_info {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t encode_max_frame_pixels;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } mm_bw_management[AMD=
_SRIOV_MSG_RESERVE_VCN_INST];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* UUID info */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_sriov_msg_uuid_info u=
uid_info;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t uuid_info_reserved[4];<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* reserved */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved[256 - 47];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reserved[256-47];<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; struct amd_sriov_msg_vf2pf_info_header {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amd=
gpu/nv.c<br>
&gt; index 32c34470404c..16d4a480f4c0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; @@ -1167,6 +1167,11 @@ static int nv_common_early_init(void *handle)<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
dev-&gt;rev_id =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;external_rev_id =3D adev-&gt;rev_id + 0x=
a;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;un=
ique_id =3D RREG32(mmFUSE_DATA_730);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;un=
ique_id &lt;&lt;=3D 32;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;un=
ique_id |=3D RREG32(mmFUSE_DATA_729);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
<br>
I would suggest putting this in navi10_get_unique_id() in navi10_ppt.c<br>
for consistency since we query this from the SMU on most other asics.<br>
<br>
Alex<br>
<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHL=
ID:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |<b=
r>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amd=
gpu/nv.h<br>
&gt; index 515d67bf249f..520ac2b98744 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/nv.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/nv.h<br>
&gt; @@ -26,6 +26,9 @@<br>
&gt;<br>
&gt;&nbsp; #include &quot;nbio_v2_3.h&quot;<br>
&gt;<br>
&gt; +#define mmFUSE_DATA_729 (0x176D9)<br>
&gt; +#define mmFUSE_DATA_730 (0x176DA)<br>
&gt; +<br>
&gt;&nbsp; void nv_grbm_select(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 me, u32 pipe, u32 que=
ue, u32 vmid);<br>
&gt;&nbsp; void nv_set_virt_ops(struct amdgpu_device *adev);<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lists.f=
reedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04=
%7C01%7CDavid.Nieto%40amd.com%7C43a11e657f9b44afb21608d91ab50e02%7C3dd8961f=
e4884e608e11a82d994e183d%7C0%7C0%7C637570187200925847%7CUnknown%7CTWFpbGZsb=
3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100=
0&amp;sdata=3Dn1gNKk7klknJ8RNwi8BV%2FiriWegB8RPGa2iBjcnU%2BVM%3D&amp;reserv=
ed=3D0" originalsrc=3D"https://lists.freedesktop.org/mailman/listinfo/amd-g=
fx" shash=3D"gbqVJbCKA1Yrlpy/gCD/QsPxfj/22YhBG2qeDsEaezQQ1tR5uMmHEOvmjehzNK=
x+2wFgFJbbzK4mL1SUCtUXZoF5yCklRTbDMk7nRxOtPXCqGzqdrvJYdmjl5KHX1eAcqTyt5zsgD=
fRzBiSXfY2hbWWLDkVyhyehSi7NkvWCb7Y=3D">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7Cdavi=
d.nieto%40amd.com%7Cb6a43b8c156c4a6964e208d91a070e84%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637569439877514988%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM=
C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sd=
ata=3D7lpRnRgRwKASGUmfr3RChO0P6QfRbcpMFggQl6HO%2Bss%3D&amp;amp;reserved=3D0=
</a><br>
</div>
</span></font></div>
</div>
<br>
<fieldset class=3D"x_mimeAttachmentHeader"></fieldset>
<pre class=3D"x_moz-quote-pre">____________________________________________=
___
amd-gfx mailing list
<a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lists.freede=
sktop.org">amd-gfx@lists.freedesktop.org</a>
<a class=3D"x_moz-txt-link-freetext" href=3D"https://nam11.safelinks.protec=
tion.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flis=
tinfo%2Famd-gfx&amp;data=3D04%7C01%7CDavid.Nieto%40amd.com%7C43a11e657f9b44=
afb21608d91ab50e02%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63757018720=
0935841%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI=
6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DYT88Ow13cLBgyzhbzCHgYhnLE5mWaK5G=
kN60o%2Fpm69o%3D&amp;reserved=3D0" originalsrc=3D"https://lists.freedesktop=
.org/mailman/listinfo/amd-gfx" shash=3D"OA0T5Uc6jja90jvpeWevvvbK2SCx2suLYVM=
OUta14hD+pY04t1f0hpznZ6YGb8MLPSoUkOLb7wRHeHMCBeB0UziR+Mwu1Bs6bf2Mgd8OYv/vzX=
yabe1Vb4rbpPahlezswi6sNh4bW1ZXnMr5vSLkNKrQ3gE0SdMt6oT3WAWmVFo=3D">https://l=
ists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
</blockquote>
<br>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB2840896BAF9A9C1E3AEE0B88F42B9BYAPR12MB2840namp_--

--===============0274452409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0274452409==--
