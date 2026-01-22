Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79B1D3EE92
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 16:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DBC210E9F8;
	Thu, 22 Jan 2026 16:55:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XuTpte2l";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C95B910E9F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 16:55:45 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1233bc11279so94453c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 08:55:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769100945; cv=none;
 d=google.com; s=arc-20240605;
 b=FYfXBo0ZhtPe9PO74054BNQSeiQ8VMItRSlsMaeTFhZgUcjO8C/iaP/MuEJelnjG8c
 I9De8lA4DRVil89vLvs5aJdapAQ3xukPccd6mOALFvq7ZgfSX/AZ+3t+n675DmKQ4AqY
 AmGtjzTN0F4tMCZjs2kyyzdp/h81CCn+QPDFcEgHA12zqXdmVwQDarpo1fpeZ9Mez89X
 Y3cGvCeLn7fbxtCh2lAvUmT/9zriZRRvY3yL+4cxpqxK6vgBLwWjPFB8yqxQfww18cCX
 GIP0tggk/RKPuvcom0iiSRfQuYu4ebuP8qsDzmrJpznSmzxtq2bO0+yQDyvE5UnexYoK
 v6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Lt3jf2Z3DBJKABdfKAxe9MNepgl0lM1XukuRc5rRc5w=;
 fh=tfjiyQiw2s6YcdxXwhHMkIDXKm8aun+ea11dOqVouwo=;
 b=S0UBYA9NtPum/r5D33Uh5oWr9+wuxtvf+ChPqLxHYuxjsHTpvAPFmThx+OaKOOat/M
 L8zK4CA9mWP2xAisVika8raA00NhfXB4LEhrLTAAuijasuuRhtpMO1oOl8NA4/1vhPx2
 72EioSj48ubjh+ZxemerUSlqzFvgsL7rxlUYZR53tdHzSZrF4WaBrVpaOo+IndJYxOEL
 oWPRfghFRTR1Hv5yo9QMIs6K5KrdH4isIc7//hS3fBb6JBB0/9YPdhsW/suEujMYhckd
 o4oTkZNnTSy6miIHKRWaGbejdo9YExoFg5gK1DjZJBZGTWFs5a/aNGbyKYxIaz3PhMWC
 ffZw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769100945; x=1769705745; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lt3jf2Z3DBJKABdfKAxe9MNepgl0lM1XukuRc5rRc5w=;
 b=XuTpte2l9k5eg9UgDreAGq0OOpr98SsTKVT2dDRSQJrxaW4CkEeVBbm4gGC0rga4g7
 fZavcxLNEVRYgw222dGdNvrFRQ0oXUsMKuGC6QFydRbtjV5P2cHX3JaAx+H6jWwYpckb
 L/h8JUnwlHTrzLSuUJbc5rrhFwFzTI/oOVHim5n9Yoscky1sYAVyfKw9jjib4Lr4En5F
 IdqUD0LTJOuZr+RxXIXT4ghIYpXkEXMsMR3dWJdoPu1D13ZSjO/YKngVukgZZECpveIX
 oi2cBgpxf/qn3A2FSDIJQ0ZKY+9ZQerNNUugW2OMMfsH+xbJslrXB+ZItX5SCQjo1G8i
 pI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769100945; x=1769705745;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lt3jf2Z3DBJKABdfKAxe9MNepgl0lM1XukuRc5rRc5w=;
 b=pDYYQ5G8MniRFbSqTVzE4m5Dns8/B5bqUA2ZpqAa6JZjo1Q6CF73vo1aaA684NfAD5
 AWEaZQpBKGXk7jN0d6hJQVhqiVG5N0icMvfo34s92lW4XI5at1Fq/wwGi4YpMa6YVYMQ
 z2FdVmgzr1WvgDF/TXOFEaMO9gNAsAfhpv1xbhfX6fE+FGGUK2lM5feO6bx58h9XSpHJ
 iyZ+vnvof8xIvXgToFlwik7Y/TFCnFA/1xazIPtRdihdqd7gPVOPllzVhzpz1fNsRe2X
 dFVdPTLPRpG/oQWxyzBP66UNXGqMdVUdweiVX4CwYcsqidQJRrNQt+YTTqm9PDi9Lln+
 9CIQ==
X-Gm-Message-State: AOJu0Yxgn4LyQhU/Vl8ViPH+bdSe9dXq0lxlqLqZGCvOJFJ/0XH6x8kz
 v5joouJAiCXmc4dJ+rKVbUeCvCFlMMZfvs00W7cp41VY1XphgUmeBMCaIBITmrPXu0pIVCS/0Mg
 Ip7uypOV34RrNRKOeFO5iiQ4OsBPygKs=
X-Gm-Gg: AZuq6aIOutZnal0DYx3J2ctao4rbRXAS1u5Whhz5ocS5fG3OQkPBJi89LrlIphHJpnf
 hHDzC++FkOfgt35kuIgNSZJs3iLFUoPT1tbLTnMZCB2dUl0Tveb082wf4JOmrH/OfvxcQ+8jRW7
 M1g/K1VrneNKyI6YAQH0x5NK3VvwJr+CKWXZhDJct1FK8XGHl5+0fIJCdqK1qjmOT8qkTLZ6HNm
 Xrnb3HgF0fGpozZbXo6DI5Ti/SI3ma+J+orVziDqdmw+ow2VLI3wfrkt997xt/HuRX2mQLjS6cD
 eTJKC9w=
X-Received: by 2002:a05:7022:3a82:b0:11e:332:1e01 with SMTP id
 a92af1059eb24-1244a7dd101mr7299571c88.3.1769100944955; Thu, 22 Jan 2026
 08:55:44 -0800 (PST)
MIME-Version: 1.0
References: <20260122155559.881810-1-shaoyun.liu@amd.com>
In-Reply-To: <20260122155559.881810-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Jan 2026 11:55:33 -0500
X-Gm-Features: AZwV_Qjx6BGZjpZjwRa0jXW29TUFGk3OxsQTiN-_FvEP8igeHttz5N0NQHLMLI8
Message-ID: <CADnq5_MgHf5qoTeZdHkNj=rACaytxibNyuWEkfVmbk10PbHG+g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/include : Update MES v12 API header - SUSPEND
To: Shaoyun Liu <shaoyun.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Jan 22, 2026 at 11:52=E2=80=AFAM Shaoyun Liu <shaoyun.liu@amd.com> =
wrote:
>
> Update SUSPEND API to support sdma queues

It would be good to note the minimum firmware version which supports
this.  With that fixed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/include/mes_v12_api_def.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v12_api_def.h
> index 83e4f0142324..e541a43714a1 100644
> --- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> @@ -492,8 +492,10 @@ union MESAPI__SUSPEND {
>                 union MES_API_HEADER    header;
>                 /* false - suspend all gangs; true - specific gang */
>                 struct {
> -                       uint32_t        suspend_all_gangs : 1;
> -                       uint32_t        reserved : 31;
> +                       uint32_t      suspend_all_gangs : 1; // suspend a=
ll compute gangs (can be set together with suspend_all_sdma_gangs)
> +                       uint32_t      query_status : 1;
> +                       uint32_t      suspend_all_sdma_gangs : 1; // susp=
end all sdma gangs (can be set together with suspend_all_gangs)
> +                       uint32_t      reserved : 29;
>                 };
>                 /* gang_context_addr is valid only if suspend_all =3D fal=
se */
>
> --
> 2.34.1
>
