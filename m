Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BB3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 14:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3D7410E45C;
	Tue, 26 Apr 2022 14:52:04 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EB5710E45C
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 14:52:03 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id r8so20933048oib.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 07:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HWK8Tqovx5psIdPel+SMe3uq6RQ6mNq2Px0+PxtqEhg=;
 b=TZrQnriNmdMuKNlPb4kHYpG+irLTYkQY4X+uIcrxKCzNxevKAEuHR+98MZKZ1iwuV0
 Nygx3/vq0cEyhHY6+3DY0uRINZlL9lsPy5/lCoTupSLDADaYEKKPwj8cgCzknAM8heLs
 s6rMNU4YoW6aIUdv6WzswoBG3uujyoaEK6YFTgm7VFXFgDI9VwvbL1j9n4Jvx2x+63sW
 ENthm83c/3EQnA/dmnUFXkOi/GnPcsSkgN9fucDYbSM5qUVNvZTK+OM8OysoOWh31f/7
 c0bcvpgeO/+IYqsR/6XEM5ckP2Zfn4mBz5HZgZsEIrbwXQxIiE8hhjQHClGgOfFsazCf
 0neQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HWK8Tqovx5psIdPel+SMe3uq6RQ6mNq2Px0+PxtqEhg=;
 b=cGJpApfmZXzSSy1q6C9gmm+O5L1n33tSYKx8qldiBie+rZixLuTAlShAGHv3usI6ez
 lTcxtnbErE8QTFTZyCO25nzKjH+ADB+Te3Dq1+X20h4n4nqDkIVzPKXuCVqh2ZRVCXet
 p54bezL9rAbQjhI14eXPE+9aqfzgGYgaPp0R111CyTVQTyhZxRqeziL6i/6s1alv7etu
 L9Vu7HtoTbXeep5p+LiKJoelDRnNE2G8BEdJpag7LpEGXj88bl0WEC57P91OX0KEpcmy
 oVpNckc4GBOBxvuZbz0aTAgoBI142wQ2D2d8IVf7A3ethYwQ1KSg5OUxsPWe4kJXPEx5
 Aidg==
X-Gm-Message-State: AOAM531J0vb/nhbYurzSUZIAp9jO6mD+eTYNFY9PWcensq3Wfv2LMwlt
 I1MBrTzu41s5m9NSYM1OnFSuseVZ9RhnhytEdi4=
X-Google-Smtp-Source: ABdhPJzBmEMHvVQC450lNGzGc9YNnkYjXmEtWN11vrzgbJZmvG9+uBtFE+QJ2I8TB8slZbTYLvzI+bxvXDjT6+LlCJ0=
X-Received: by 2002:a05:6808:f8d:b0:325:1e81:ffe5 with SMTP id
 o13-20020a0568080f8d00b003251e81ffe5mr6415852oiw.253.1650984722316; Tue, 26
 Apr 2022 07:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220426081529.870302-1-clementwei90@163.com>
In-Reply-To: <20220426081529.870302-1-clementwei90@163.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Apr 2022 10:51:51 -0400
Message-ID: <CADnq5_MkPbgtq6KaNh8oCx-S4o7AwHJFAfJWjReC-8RJj7JbPw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix typo
To: clement wei <clementwei90@163.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 xiaolinkui <xiaolinkui@kylinos.cn>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Rongguang Wei <weirongguang@kylinos.cn>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Tue, Apr 26, 2022 at 8:56 AM clement wei <clementwei90@163.com> wrote:
>
> From: Rongguang Wei <weirongguang@kylinos.cn>
>
> Fix spelling mistake:
>         "differnt" -> "different"
>         "commond"  -> "common"
>
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/include/atombios.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
> index da895d1f3b4f..1f9df4e7509b 100644
> --- a/drivers/gpu/drm/amd/include/atombios.h
> +++ b/drivers/gpu/drm/amd/include/atombios.h
> @@ -4665,7 +4665,7 @@ typedef  struct _ATOM_EXTERNAL_DISPLAY_CONNECTION_INFO
>    UCHAR                    Reserved[3];                           // for potential expansion
>  }ATOM_EXTERNAL_DISPLAY_CONNECTION_INFO;
>
> -//Related definitions, all records are differnt but they have a commond header
> +//Related definitions, all records are different but they have a common header
>  typedef struct _ATOM_COMMON_RECORD_HEADER
>  {
>    UCHAR               ucRecordType;                      //An emun to indicate the record type
> --
> 2.25.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
>
