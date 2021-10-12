Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDFDC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 07:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2275760EE5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 07:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2275760EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA76289F89;
	Tue, 12 Oct 2021 07:18:29 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE2789F89
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 07:18:28 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id m22so63936140wrb.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 00:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language;
 bh=Z4AZ8sVEIdMS2pqASqZylzlPbybmJYpnArQn8oq+Lbc=;
 b=m1r/yZt7U/UdYSUmVMJTMBq4+OK7cE8dCUN29OO8OZRzmenNDK7eDF1Z3TEiySNn/1
 3d88djOxCsoUueVJbMlEFu6cMoCUqJnwPEhSmwMO9harx4NZzhY8zQA9HkbS27eoLxdC
 hpbnq25tDHlCg0DFpiAUmKrr9I+x6EfWBGDCwHdcBi9z/c3J86ms5Xbp6qwacfg+AwJi
 jT5C896dWGnyDak3cWgPGdTzhdV04QXBDZjPffSNxTumyGNUrBQCJialbQvIFGZuWXiP
 k/ycOsWzPzprySgBC6W1WugUPPFSFIqHlArK0J5lBY40Md3fLVbTiZNIjC5UTIc28ZeY
 2hYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=Z4AZ8sVEIdMS2pqASqZylzlPbybmJYpnArQn8oq+Lbc=;
 b=D8Pa5T3mw98Yelrmr2uWvBijgA2JMEGhcbO7XHNeRLUd10jxoDTij6cTv1jHdCwcfK
 GTYqmP97DhXvu0JvNyj3FD69quEUCa2PVQMhVwZ/mbEsIcsBKRIVcWkb8LdXpoFMkAPJ
 TTA+ZwGQjqUnjNCaR+Uz6tilrfO2jE9//thD28M5388bsHLIYXJxsRVHbkXOqTgupZ7T
 hc/erG063owMrLyj2WPobXh7ZtlUq+7ypGvf4O3EuZXL1tQQ7ULoVYFdRa6m7K3+xfwi
 SsddW23HC6ZPNNymXJ6a5IVXv6pcbuRsc89HyNioyTa4GsEohmDl1eSuM7N7lUUbieuC
 XgeQ==
X-Gm-Message-State: AOAM530g7SyBmMIO9/YMjo+7Ej5hM78Sg8LrlhHryJZcZZ0LrcoKr5my
 DnklOiPrYQkY1vXbccqINB9q49UC2zM=
X-Google-Smtp-Source: ABdhPJyq8NNYnq5hSN0bFbJ+m9H7L8Y+AG+6v01fD+RNTcBcDGDdWF+DRE54VI9UOpykAMxwVrlUtw==
X-Received: by 2002:adf:a154:: with SMTP id r20mr30704416wrr.326.1634023107429; 
 Tue, 12 Oct 2021 00:18:27 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:87c8:f860:ca5d:9823?
 ([2a02:908:1252:fb60:87c8:f860:ca5d:9823])
 by smtp.gmail.com with ESMTPSA id n15sm10003716wrg.58.2021.10.12.00.18.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Oct 2021 00:18:26 -0700 (PDT)
Subject: Re: Fwd: [PATCH] Size can be any value and is user controlled
 resulting in overwriting the 40 byte array wr_buf with an arbitrary length of
 data from buf.
To: "T. Williams" <tdwilliamsiv@gmail.com>, airlied@linux.ie,
 daniel@ffwll.ch, Wayne.Lin@amd.com, mikita.lipski@amd.com,
 Nicholas.Kazlauskas@amd.com, stylon.wang@amd.com, eryk.brol@amd.com,
 Jerry.Zuo@amd.com, victorchengchi.lu@amd.com, aurabindo.pillai@amd.com,
 nirmoy.das@amd.com, Anson.Jacob@amd.com, amd-gfx@lists.freedesktop.org
References: <20211011202158.GA19208@t>
 <CADN=F_muAvmp6NcDnMgPGpTtz75KH2hhv3jbiWuW+Zz35Hc-Kw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <76a1cb8c-c1a9-b052-9e41-1738aaf94bfa@gmail.com>
Date: Tue, 12 Oct 2021 09:18:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CADN=F_muAvmp6NcDnMgPGpTtz75KH2hhv3jbiWuW+Zz35Hc-Kw@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------FE4A381890E874BC37901A32"
Content-Language: en-US
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

This is a multi-part message in MIME format.
--------------FE4A381890E874BC37901A32
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 11.10.21 um 22:24 schrieb T. Williams:
>
>
> ---------- Forwarded message ---------
> From: *docfate111* <tdwilliamsiv@gmail.com 
> <mailto:tdwilliamsiv@gmail.com>>
> Date: Mon, Oct 11, 2021 at 4:22 PM
> Subject: [PATCH] Size can be any value and is user controlled 
> resulting in overwriting the 40 byte array wr_buf with an arbitrary 
> length of data from buf.
> To: <dri-devel@lists.freedesktop.org 
> <mailto:dri-devel@lists.freedesktop.org>>
> Cc: <harry.wentland@amd.com <mailto:harry.wentland@amd.com>>, 
> <sunpeng.li@amd.com <mailto:sunpeng.li@amd.com>>
>
>
> Signed-off-by: docfate111 <tdwilliamsiv@gmail.com 
> <mailto:tdwilliamsiv@gmail.com>>

While the find might be correct there are a couple of style problems 
with the patch.

First of all the subject line must be shorter and should be something 
like "drm/amdgpu: fix out of bounds write".

The detailed description of the bug then comes into the commit message.

And finally please use your real name for the Signed-off-by line.

Apart from that good catch,
Christian.

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c 
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 87daa78a32b8..17f2756a64dc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -263,7 +263,7 @@ static ssize_t dp_link_settings_write(struct file 
> *f, const char __user *buf,
>         if (!wr_buf)
>                 return -ENOSPC;
>
> -       if (parse_write_buffer_into_params(wr_buf, size,
> +       if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>                                            (long *)param, buf,
>                                            max_param_num,
>                                            &param_nums)) {
> -- 
> 2.25.1
>
>
>
> -- 
> Thank you for your time,
> Thelford Williams


--------------FE4A381890E874BC37901A32
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 11.10.21 um 22:24 schrieb T. Williams:<br>
    <blockquote type="cite"
cite="mid:CADN=F_muAvmp6NcDnMgPGpTtz75KH2hhv3jbiWuW+Zz35Hc-Kw@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr"><br>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">---------- Forwarded message
            ---------<br>
            From: <b class="gmail_sendername" dir="auto">docfate111</b>
            <span dir="auto">&lt;<a href="mailto:tdwilliamsiv@gmail.com"
                moz-do-not-send="true">tdwilliamsiv@gmail.com</a>&gt;</span><br>
            Date: Mon, Oct 11, 2021 at 4:22 PM<br>
            Subject: [PATCH] Size can be any value and is user
            controlled resulting in overwriting the 40 byte array wr_buf
            with an arbitrary length of data from buf.<br>
            To: &lt;<a href="mailto:dri-devel@lists.freedesktop.org"
              moz-do-not-send="true">dri-devel@lists.freedesktop.org</a>&gt;<br>
            Cc: &lt;<a href="mailto:harry.wentland@amd.com"
              moz-do-not-send="true">harry.wentland@amd.com</a>&gt;,
            &lt;<a href="mailto:sunpeng.li@amd.com"
              moz-do-not-send="true">sunpeng.li@amd.com</a>&gt;<br>
          </div>
          <br>
          <br>
          Signed-off-by: docfate111 &lt;<a
            href="mailto:tdwilliamsiv@gmail.com" target="_blank"
            moz-do-not-send="true">tdwilliamsiv@gmail.com</a>&gt;<br>
        </div>
      </div>
    </blockquote>
    <br>
    While the find might be correct there are a couple of style problems
    with the patch.<br>
    <br>
    First of all the subject line must be shorter and should be
    something like "drm/amdgpu: fix out of bounds write".<br>
    <br>
    The detailed description of the bug then comes into the commit
    message.<br>
    <br>
    And finally please use your real name for the Signed-off-by line.<br>
    <br>
    Apart from that good catch,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CADN=F_muAvmp6NcDnMgPGpTtz75KH2hhv3jbiWuW+Zz35Hc-Kw@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          ---<br>
           drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2
          +-<br>
           1 file changed, 1 insertion(+), 1 deletion(-)<br>
          <br>
          diff --git
          a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
          b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c<br>
          index 87daa78a32b8..17f2756a64dc 100644<br>
          ---
          a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c<br>
          +++
          b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c<br>
          @@ -263,7 +263,7 @@ static ssize_t
          dp_link_settings_write(struct file *f, const char __user *buf,<br>
                  if (!wr_buf)<br>
                          return -ENOSPC;<br>
          <br>
          -       if (parse_write_buffer_into_params(wr_buf, size,<br>
          +       if (parse_write_buffer_into_params(wr_buf,
          wr_buf_size,<br>
                                                     (long *)param, buf,<br>
                                                     max_param_num,<br>
                                                     &amp;param_nums)) {<br>
          -- <br>
          2.25.1<br>
          <br>
        </div>
        <br clear="all">
        <br>
        -- <br>
        <div dir="ltr" class="gmail_signature"
          data-smartmail="gmail_signature">
          <div dir="ltr">
            <div>Thank you for your time,<br>
            </div>
            Thelford Williams<br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------FE4A381890E874BC37901A32--
