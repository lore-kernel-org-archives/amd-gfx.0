Return-Path: <SRS0=tImT=KE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2775AC433ED
	for <amd-gfx@archiver.kernel.org>; Sun,  9 May 2021 15:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFBF360FE9
	for <amd-gfx@archiver.kernel.org>; Sun,  9 May 2021 15:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBF360FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A886E20B;
	Sun,  9 May 2021 15:42:12 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B956E877
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 May 2021 09:51:32 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id j12so3086132pgh.7
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 May 2021 02:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=GFwGuOaySNCKOb5aolQrcMuXg5+nQanjXXgSykQio2M=;
 b=M4pJeFQAlIldUETVkcdClbGw6UnZnwDR77kI9X21y8AMLszLsMhQPYigxJSjqr1Lco
 CMDNIFuR4J8rCkFDfxb76NnJF3t3PGCoRiLzgqtnq4iY+nE6IZbIti2by53KfjO36o4+
 gRuqxs6AqTI5pV4FoCpSHnoakHMrKLRMbgOCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=GFwGuOaySNCKOb5aolQrcMuXg5+nQanjXXgSykQio2M=;
 b=WmgjwdCLF31tyKcSnCvqfZAosyj5QutEilOa/pqueM/PvWls7T6k95l6EjIKgTw39c
 M8tbuC/TgYnyIOfeoVQs0WA3IqC8FgFmaES7O4aVSBSRCfY2oKwR0Q6bR+ifn5MQN5wy
 4QcCcf1bY1yDYftiY4rpwm2JmFPaVqZr9dyZiSN9HSK2zda6nWnH+Dx1ZAWQZLpwIVUu
 VF9NLQ91nPg+NYpHMN6ZKDJOehkYYBdZjeG3qKTUkpX6DiudB0RlHgbTP0JFclyyApjC
 0/3tTKgFtXmDM/co8sT61/Hu+Mg2cQZOVPlKBgQpo7YSNx+IREU1lt/1Y5hdEKBDemPO
 q/qw==
X-Gm-Message-State: AOAM530Eyyh5wqiKfRhjyfm6XNr9BCbWZNkTEeqMvffAPThEcsJnI+v4
 OZfQ21ZlPMAXtD3zF5lR5u4t5A==
X-Google-Smtp-Source: ABdhPJyB806feKtO6oygcd6agrBe0ep3z7tJZr2CYBpILWFsWqZJxWPGPuyoArkxat5PdkB6zXpcxA==
X-Received: by 2002:a65:5088:: with SMTP id r8mr14243199pgp.12.1620467492290; 
 Sat, 08 May 2021 02:51:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id d16sm6778057pgk.34.2021.05.08.02.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 May 2021 02:51:31 -0700 (PDT)
Date: Sat, 8 May 2021 02:51:30 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Message-ID: <202105080251.65694F9F@keescook>
References: <20210422023448.24689-1-Jiawei.Gu@amd.com>
 <202105072117.1480D10A@keescook>
 <BN9PR12MB51616B5E43086FC4CE2B58FFF8569@BN9PR12MB5161.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN9PR12MB51616B5E43086FC4CE2B58FFF8569@BN9PR12MB5161.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Sun, 09 May 2021 15:42:11 +0000
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Nieto, David M" <David.Nieto@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, May 08, 2021 at 06:01:23AM +0000, Gu, JiaWei (Will) wrote:
> [AMD Official Use Only - Internal Distribution Only]
> =

> Thanks for this catching Kees.
> =

> Yes it should be 20, not 16. I was not aware that serial size had been ch=
anged from 16 to 20 in struct amdgpu_device.
> Will submit a fix soon.

You might want to add a BUILD_BUG_ON() to keep those in sync, especially
since it's about to be UAPI.

-Kees

> =

> Best regards,
> Jiawei
> =

> =

> -----Original Message-----
> From: Kees Cook <keescook@chromium.org> =

> Sent: Saturday, May 8, 2021 12:28 PM
> To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; Deucher, Alexander <Alexander.=
Deucher@amd.com>
> Cc: StDenis, Tom <Tom.StDenis@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; Gu, Ji=
aWei (Will) <JiaWei.Gu@amd.com>; amd-gfx@lists.freedesktop.org; Nieto, Davi=
d M <David.Nieto@amd.com>; linux-next@vger.kernel.org
> Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface
> =

> Hi!
> =

> This patch needs some fixing.
> =

> On Thu, Apr 22, 2021 at 10:34:48AM +0800, Jiawei Gu wrote:
> > +		case AMDGPU_INFO_VBIOS_INFO: {
> > +			struct drm_amdgpu_info_vbios vbios_info =3D {};
> > +			struct atom_context *atom_context;
> > +
> > +			atom_context =3D adev->mode_info.atom_context;
> > +			memcpy(vbios_info.name, atom_context->name, sizeof(atom_context->na=
me));
> > +			vbios_info.dbdf =3D PCI_DEVID(adev->pdev->bus->number, adev->pdev->=
devfn);
> > +			memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, sizeof(atom_con=
text->vbios_pn));
> > +			vbios_info.version =3D atom_context->version;
> > +			memcpy(vbios_info.date, atom_context->date, sizeof(atom_context->da=
te));
> > +			memcpy(vbios_info.serial, adev->serial, sizeof(adev->serial));
> =

> This writes beyond the end of vbios_info.serial.
> =

> > +			vbios_info.dev_id =3D adev->pdev->device;
> > +			vbios_info.rev_id =3D adev->pdev->revision;
> > +			vbios_info.sub_dev_id =3D atom_context->sub_dev_id;
> > +			vbios_info.sub_ved_id =3D atom_context->sub_ved_id;
> =

> Though it gets "repaired" by these writes.
> =

> > +
> > +			return copy_to_user(out, &vbios_info,
> > +						min((size_t)size, sizeof(vbios_info))) ? -EFAULT : 0;
> > +		}
> =

> sizeof(adev->serial) !=3D sizeof(vbios_info.serial)
> =

> adev is struct amdgpu_device:
> =

> struct amdgpu_device {
> ...
>         char                            serial[20];
> =

> =

> > +struct drm_amdgpu_info_vbios {
> > [...]
> > +	__u8 serial[16];
> > +	__u32 dev_id;
> > +	__u32 rev_id;
> > +	__u32 sub_dev_id;
> > +	__u32 sub_ved_id;
> > +};
> =

> Is there a truncation issue (20 vs 16) and is this intended to be a NUL-t=
erminated string?
> =

> --
> Kees Cook

-- =

Kees Cook
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
