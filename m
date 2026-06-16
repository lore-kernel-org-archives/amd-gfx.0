Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85317CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 14:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6F710EBBD;
	Tue, 16 Jun 2026 14:28:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GlSElKEo";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B62F810EBB4
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 14:28:48 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-304d3d3d8f8so563229eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 07:28:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781620128; cv=none;
 d=google.com; s=arc-20240605;
 b=ddoA9sX2tqkP6q4uWMG/UeSz9fsCHvjoDEMBTL7f7q6UK4qy7nV4QJOR0dRf0th51Y
 EnW8rrzWrah6Fjt+pq0Y8+xP/pGz0WbgrNly8zI3ojVY0vjIPadx4r94gs9AaeDwkYAU
 ECCURd/cpyURPHBfuZbJ26uLy/XyR9wKMYLTrlTQBTCS00iY093utCvpNKYl9N0mNaTG
 7eVMsiX6VjmQdBSUvlzVOYF0mPExggTHfKJzEgEX7SHqTpcy1zOH6xkoCc3/8/7uBx/3
 UeCv43a5WbeKjtji0qUrXbuyridXmJ/O6n5pz3J9aC1uEzZmXQ+1R6R5GB68Quu9bx3D
 y4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tNcpKjQIioKLG/9mijNmVIVi+z+GgihXbkrqtpce2Tg=;
 fh=aEvEHziuJC6FtiwCs/vqsQJsysQ/Awf1x88pXW6cTtI=;
 b=Mgt6BFcp9bk1ckpFosniIRHLqoO+Tm47g7Nyx2d2DgyzAOB1Ty8umGBae8Ebo6MP+W
 pS8mvhzUiQs+pHuKEo7BNJo6N0rc+62DPjK+OAg0dsIo4CiuIB1X8sKWuP21OrQBipD8
 00ga142pEa0qjk2adPVa01fhZnJlwcgxk+zvO11JdDY5FCYigrFguUa8A26U/KCNOpcd
 eRhnRMMA2WHXxDq7IuFOaTom/QEvzcsTZMAukeatCiqU/EDffhQSrvnwthOu+YchgFZz
 J4boZvK2JKGJREPJ2K9QJJ09Egu2u3uekfJeJ2BQE66PrxZdgwAJavGvGmjfegm0zkS8
 ctFQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781620128; x=1782224928; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tNcpKjQIioKLG/9mijNmVIVi+z+GgihXbkrqtpce2Tg=;
 b=GlSElKEoAa0EASq+4J3vQRSRSRX6THJNzHZy5v/veBVzDaZIWxJwSMN1YWDo78VkN3
 bBHyUAUZCiq9q/ftvRbY+DqQdPdOj6qZUZ5O7/JXhquQeCDJTttAtUAU0dD57KCQLex1
 rGr3CQK2BjvvSLbiEjgFiUlaBYtO6UWhzSYpy8ov6l7qrT3uj9F0CoaKuN4OFeinK6kH
 I/0UotPhqzozcA7RwiICYjQIGVAoW1IepIBiIwqwXsKANHClRwT8ptuI3mS+GqzHDBUg
 cKKtvG4YkEBUefVZNHNGx52TqMNlgdxcyzqr5cqXTD7jaUl3bwnSIE00JXDjepAZ4nay
 ielw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781620128; x=1782224928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tNcpKjQIioKLG/9mijNmVIVi+z+GgihXbkrqtpce2Tg=;
 b=OpsVPbvkl+HZTualbITT1Sdg1L4Mx3R9HZyIsfPFkvUPazh9OEdJxCNwpeR3AxzAsj
 rxfJsUeD2dUTE4nTpqaFVmXGu/YDdJKKSApJwxrbTPX5spfD9zWx7lKCNafN/dew8DiM
 Pu7t33YObF60MgWReE+wCz7M/CBj7pUVtPlwxt+BMnr1mLrqW3EOXDpffA1+avBwMNeq
 oF8/kyX/iv2kUelAHs+v1nqp/yl9YzNFdjDtEUF+XeTHgD24ULpR/xydlDaOoa/atiCS
 Erzg3DQ5paDJ01O6Chhb/3VyQemdnWK3RnMajo3kfjCQICjBjyEFSG7+cwiJnkuwAuIo
 l0aQ==
X-Gm-Message-State: AOJu0YzPrrVtAP1Okrnvnl6bmBz48JJ52PmLIKl6ONxSZk2WhRdmUDfD
 KAszx+rblMSvKotdhTKJkT6WuPqmKRpTfaemmOmmPdDKCDXr9l34drhEgAwD3uk+P2GcBMQf1v9
 aILj1AMLErsxok3sX9zuGYew9bGlneFw=
X-Gm-Gg: Acq92OHVh44T93ZCBiiz3iKzfMCLSkROCCl9lvtKHTYrGHmo5XkyAoq0ZfI/B41H8I6
 aCIZ+F29KA5lNWsOzMDkjJJnoTn4Eg7bYg8h1LS9CJY0POqKe/MWjsvrxqcPrMG2rrC9HZJVmKP
 Nkknauo/yQhEIAPYk143J6w3bbcDMSLeut2mymdVXGdVq6k5bX97aDgJeTlRu8R6paYNQZTMWJE
 aLnV+DFVw2/x6k92qW/xLb2sRX2aa+DmH06y7Cj0vursPawdNBFZfRMoQ20QQtkgFgjTSO9n7fh
 56+hWkQ4VD3ZgNBgcA5TEevnf7kvSuDiTiJgs/HOGJCYOw36fRoy/TvYXafU6r+Rj+/qpLZ5G8j
 g7K/o
X-Received: by 2002:a05:7301:9f11:b0:304:2af3:5fef with SMTP id
 5a478bee46e88-308200e33a4mr5050837eec.8.1781620127929; Tue, 16 Jun 2026
 07:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260513170849.27061-1-timur.kristof@gmail.com>
 <20260513170849.27061-2-timur.kristof@gmail.com>
In-Reply-To: <20260513170849.27061-2-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 10:28:35 -0400
X-Gm-Features: AVVi8Ccu1BGDX9Rp9rAqw3IvhIBY_E7j7XzWS0DxaysSjIAZhi-WRCLSYjV2U5E
Message-ID: <CADnq5_OhUE7=Egktmxj-4YxzaoYh3YRfZ23UytP5iDSw+zJ5pw@mail.gmail.com>
Subject: Re: [PATCH 1/3] amdgpu/ih6.1: Fix minor version
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 christian.koenig@amd.com,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>, 
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 amir.shetaia@amd.com
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

On Wed, May 13, 2026 at 1:08=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Report the correct version of IH v6.1 (previously it showed v6.0).
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/ih_v6_1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/a=
mdgpu/ih_v6_1.c
> index 95b3f4e55ec3..699c274d357e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> @@ -790,7 +790,7 @@ static void ih_v6_1_set_interrupt_funcs(struct amdgpu=
_device *adev)
>  const struct amdgpu_ip_block_version ih_v6_1_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_IH,
>         .major =3D 6,
> -       .minor =3D 0,
> +       .minor =3D 1,
>         .rev =3D 0,
>         .funcs =3D &ih_v6_1_ip_funcs,
>  };
> --
> 2.54.0
>
