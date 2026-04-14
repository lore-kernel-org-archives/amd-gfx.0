Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EA6F9D0CA
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 13:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B51B310E602;
	Tue, 14 Apr 2026 13:38:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qHfQmuE3";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5D6C10E602
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 13:38:27 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2daaab98000so32645eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 06:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776173907; cv=none;
 d=google.com; s=arc-20240605;
 b=Z7oF5GnVY7YoPm+RPFO31U/qKdA0YPFiYhQX54/jikHHSKRI0u1uZq2cyrOKZ31U+F
 5K2M7aAzgwwUHvl4E9YlSXQnzYj8ThOe45YfrvkBkOxXlfRSYzILijAwxZEilrTnGv9l
 Fs+NER4nnctR0+WpLMw1B4zZIDj51KByHUV4Br4fXdce8vGJ+bCgy1jSmfKbLvqkgiq4
 pYRZ+7SqPcXTNlCRZrfpNRyuvEsv5E4BMFAQIukFK1Bej72Ju/8SpfgEJGK1/+XxNdp0
 1Bx8cbBeFgMxD9Xstj5IgY/5Dr/eGEWZocohpCHUYtHxqEt68MBe2n4jwyiYvWwQcccN
 xvdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dIoiF5V2YbGoZ4kfaN4IqagNytkJk7Qy3rMBDOcnJOo=;
 fh=BP8poZy5msJ32Ba8KXI+C6RuRe+6f2SeMceXOj9xYlA=;
 b=FHuPm+FURWM+GrVrcRwyX7/OWVxbHKbu4gbkf/J63Z+/IWTwY15NNYqYbqxwvjylEf
 x5L04/MEGto2+ATkYLSI8stjI9a/SD/xaG4QFroVAa7QLVMppgwgdQWgryweftSSVyqi
 VeXJzUp3fDLZX6ybKzpL4LKD5DG4i8/gA5JAlD+mpN+oEZ8d0eMEo6cv9WBKL603jXa1
 TCxLZhG4HXa5Cmigg5PBiH93kMnDgxPqo2nE/Y6oq7oWfSP98yMecROt2o2LQpLkYPwV
 OnqQOdadTY9GI6/yrAkw5997l1lHbkQyfy2/QxAVIOsiLRU9/jB2E4EvgCuxaqhU4Hxm
 hgPg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776173907; x=1776778707; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIoiF5V2YbGoZ4kfaN4IqagNytkJk7Qy3rMBDOcnJOo=;
 b=qHfQmuE3K39MlamrwO2CTB0X8aSFxvy/kyTf7qYAQX5MUxngnbH0Jepu016olwjLYc
 2EkeZt+LeDpTEUP9MeFLdeNAeyHaNHnpZogiNzrY9t2wVJaCjO1ZJqubXl9zWINdLKlp
 3vPThkiKyOsKwmy7iBLINsGhOlaV7pH+TztHK2Mg5WAO4Qx96iUsSV2ZalU7i5BmMQDm
 l3csMc9gwuBLIhjhfbMnZNoYj9oysI7PiZRSijfZ6VvtINumjbKZAQOI7hzrZnzyYSrC
 xscBgR+oALbSg/CZge0PN/K5oO/pzvP8BFHVN7Vyiag4GyTrErPoSSOiJ7nGGlKPVoQH
 cYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776173907; x=1776778707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dIoiF5V2YbGoZ4kfaN4IqagNytkJk7Qy3rMBDOcnJOo=;
 b=O1+9C+KoYSj15WOH5ESimNOGMUMavkTygQCwMpnQ9c+vZWpxp9TvDp11P0aF6D2hHc
 YYXyLcgYzslao4xxA2ODPWJC17eEb0Dme2D28OCYYKd5ZDcZ4OqizWcB1kiospGFdd6T
 FsxGClJznIU93ip5Nl1xVIBpuMOLjJsQreifRHdSUC3DR/QzAcK/bkTMGaftkARQkr8Q
 rwiEErgkUKspAl+PZCzTNjAICXK8wIZD8c4cz/RCCCxlQsjmRgbWb3CRLEkEvVJSCOAJ
 NMy7DS6R5Rx45nDBFJNZSpU3AJvJNpKRSKAe0Z+fFgloFDpR+x+sKhRzD1ORo7WsNtU4
 8cPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OpM/92x+fsK7ycVQstn+FhrKr2IIzQAkA+nkj350EjLW4W9229TSul4BWJkruEnNNsgpdeITL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGd7mxi5jP0HYoJSj10zLs8TxUP+JjgjcmUdpfFpPNIwGZ6Gti
 OcXEfN31m6s4TO5DrOtQaN0vk1IAIr5Mt5sU5F+II6do6Il+DS/g+ReVLo/OUjz/HzMM98brhXZ
 ARu57NmrFA/8PFhFCfNF/M+VilwYGOCo=
X-Gm-Gg: AeBDiev52KhmRcC6PcZnr+fx1qhUojFPbBc69Pxa07m9Qo5RbEN4QK4/KJrCYpUpas6
 7J9DUUFmL19GzY+bST4BbYuFs6WqoEbSv2XOzRyCRGdmVTk8atxMUQ7OUyLSf5Z/sq6jx42th3x
 qb6Bo5GMOURxMpsWC7dWBCBCeNZquj9nk6LyrV+WYVf1ov+kILi9Dd0h4K1vFGjFfj4HhKbDinh
 iUlMSWrpPAWTe0AaDM8q2uJuRGPHqw6dq/QmnHK4ChZyHJt5aHYZDcM7DCMtID+w+CB709YyQuh
 PuF+nk+8H2mEFNlubmN+em1fDP/BxDjSn8uHvm4gDcw3hFIufEmOXQO00bjAMcP7i2QmWQ==
X-Received: by 2002:a05:7022:2209:b0:124:af80:9d0c with SMTP id
 a92af1059eb24-12c3599013emr4006614c88.0.1776173906885; Tue, 14 Apr 2026
 06:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <1be91839e8b3e41003147a8cdc99e6efd1a87442.1776146550.git.michal.simek@amd.com>
 <e097b12e-6800-40a3-a015-c1b9a52871d8@amd.com>
In-Reply-To: <e097b12e-6800-40a3-a015-c1b9a52871d8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Apr 2026 09:38:14 -0400
X-Gm-Features: AQROBzBacNxmabWprMR1XN8TMc8po3nTXuHOwTNUm7Nu3wu6BSQS5zQ1T4svqvs
Message-ID: <CADnq5_PY75d2377cA=t4N1qhSP7=X4dzA-n+Qg+tE8WVv0t8hQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/jpeg: Fix sprintf buffer overflow warning in
 jpeg_v2_5
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 monstr@monstr.eu, git@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Tue, Apr 14, 2026 at 5:39=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/14/26 08:02, Michal Simek wrote:
> > Replace sprintf() with snprintf() to fix the -Werror=3Dformat-overflow
> > warning when building with allmodconfig:
> >
> >   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c:152:47: error: '%d' directive
> >   writing between 1 and 11 bytes into a region of size 7
> >   [-Werror=3Dformat-overflow=3D]
> >     152 |                 sprintf(ring->name, "jpeg_dec_%d", i);
> >
> > The ring->name buffer is 16 bytes. Using snprintf() with sizeof()
> > ensures the buffer cannot overflow regardless of the integer value.
> >
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v2_5.c
> > index 20983f126b49..fe2b049afac3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> > @@ -149,7 +149,7 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block=
 *ip_block)
> >               else
> >                       ring->vm_hub =3D AMDGPU_MMHUB0(0);
> >               ring->doorbell_index =3D (adev->doorbell_index.vcn.vcn_ri=
ng0_1 << 1) + 1 + 8 * i;
> > -             sprintf(ring->name, "jpeg_dec_%d", i);
> > +             snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%d", i=
);
> >               r =3D amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst[=
i].irq,
> >                                    0, AMDGPU_RING_PRIO_DEFAULT, NULL);
> >               if (r)
>
