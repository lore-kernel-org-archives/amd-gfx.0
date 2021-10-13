Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68756C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 20:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A71610EA
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 20:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 16A71610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC1016E0E3;
	Wed, 13 Oct 2021 20:41:12 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D377E6E0E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 20:41:11 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 k2-20020a056830168200b0054e523d242aso5370727otr.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qf8XTa4WK7zPCw3sxoR5xvVbK3VPY76ppVIcd2Z+1E0=;
 b=izhA/Rj/XIQcBQam/M5byn+jtdxH9FxZohweU8UN7zxL+PwBaA6V/Q/bwCME3gkbMo
 wzkYaR0eKIJH0qCpUt8MK9Y5YQbaQzMWRsIndB7OkqSg3128qQV/Jww9T1dcpIBAi7bo
 eIqTq+lYF9Et14tOaObXN7zjYbPhaB8L+yXWmhP6VBlmbU5hf21D41lYMm2neRsiy2iD
 H67uBwY7QiVgu01ho5jmrmLkSbAOqWWAAaNl3IC7KfjVcVn1FYCiHo+jX+ahxS6barlf
 Bqya367M90fBLScsqgEB1/FksfCkZx63dVyAszKmvY8Il5iQZLRziZVnO/bj0RA8uXEx
 5wUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qf8XTa4WK7zPCw3sxoR5xvVbK3VPY76ppVIcd2Z+1E0=;
 b=5bYzT/hkh+E5GL6XtDV7nb3v9QTcvij39+cHYwYY9cV/ERwPyAks0EYYEQsKstkkjx
 YlG8KGiF5G5N4sVWbfKI21yiNt/sFdb/Zn7oI4cWJisGNAuTLgZsC5FOlDU91Pu8eiY4
 HKNIW8tQHDv9u9+DSIMTuIYaZ8TeKDD4CYraTS6XxrjnOH4BWyn2xMJchJFG34F5vrUR
 ThklX6IBBYS4JN0NzC71mRCE4iSZehKukxyL7Bm+QPo0bq+kEwxfYApMVH4yc5xwwn4H
 Gz/egpr2pMDC3AVBvW/oXYnbMFfWygRy4fr7UyuaiXNk5HjBrX16r3+7yQRI8YZoxvu9
 ONsg==
X-Gm-Message-State: AOAM532csUajlcEe9aL1G8GA4fV6NWd9YLbLU4QmhF6Lo5levQh3FQWH
 74omweJQkK7QUb2kYFOwCZPFdkUqfJZLuBQNoHtnpNvwD8k=
X-Google-Smtp-Source: ABdhPJzvtCZFM8LfeoA2MyNyWDce0lYj4qnZNt/J3mMRYIiq3gmnijaLVL7uoJd0VuRne2F3s4VC3lJpeyZbI4fB2Mw=
X-Received: by 2002:a9d:718e:: with SMTP id o14mr1217039otj.299.1634157671070; 
 Wed, 13 Oct 2021 13:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <CADN=F_ngDhs10tBOtQy4kz0T6ZEjLJ_q0P+7bpen=JU04cpUXg@mail.gmail.com>
In-Reply-To: <CADN=F_ngDhs10tBOtQy4kz0T6ZEjLJ_q0P+7bpen=JU04cpUXg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Oct 2021 16:40:59 -0400
Message-ID: <CADnq5_NctQdhD4UqnK9DLuLZx8F048i24hOBNQwC+EMpZOsxoA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix out of bounds write
To: "T. Williams" <tdwilliamsiv@gmail.com>
Cc: "Wentland, Harry" <harry.wentland@amd.com>,
 "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, 
 Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Wayne Lin <Wayne.Lin@amd.com>, "Lipski, Mikita" <mikita.lipski@amd.com>, 
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 Stylon Wang <stylon.wang@amd.com>, 
 Eryk Brol <eryk.brol@amd.com>, Jerry Zuo <Jerry.Zuo@amd.com>, 
 Victor Lu <victorchengchi.lu@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, 
 Nirmoy Das <nirmoy.das@amd.com>, Anson Jacob <Anson.Jacob@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 13, 2021 at 4:04 PM T. Williams <tdwilliamsiv@gmail.com> wrote:
>

The description and s-o-b should go here and the patch seems to be
mangled.  I've manually applied this.  Please fix up your mailer in
the future.

Thanks for the fix.

Alex


> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 87daa78a32b8..17f2756a64dc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -263,7 +263,7 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
>         if (!wr_buf)
>                 return -ENOSPC;
>
> -       if (parse_write_buffer_into_params(wr_buf, size,
> +       if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>                                            (long *)param, buf,
>                                            max_param_num,
>                                            &param_nums)) {
> --
>
> Size can be any value and is user controlled resulting in overwriting the 40 byte array wr_buf with an arbitrary length of data from buf.
>
> Signed-off-by: Thelford Williams <tdwilliamsiv@gmail.com>
