Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5E3C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 21:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608CD6128A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 21:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 608CD6128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D546E861;
	Wed, 17 Nov 2021 21:55:33 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3495B6E861
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 21:55:31 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 a23-20020a9d4717000000b0056c15d6d0caso7182631otf.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 13:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HbeSiWmKhXAEBcyBWJh4BTFGtWTJPA+y3tTxzDeHMJk=;
 b=c4cxRXbTEJtbMSIqargjQTBv9QpGJI89UC8iVuxC1gP0Djfaku4OI41jgFi8f572OI
 25j0gYDOFRxxaKB4Qf8BfNgjddSSHcQCTOWA6oT/INW6rnYxy+7uu8Vu002EapdCdJhc
 78dMX+adQsYQij7TtAbZ3+XO1kc0UoxXM0hDfo/8XED4IweTv+ZAoihj5lszrkqmG4Bh
 BZ0vLS49t9GxzS32yeF7yTYSix3U3mSvmRpDp1IcHMNvxxP3XBXn4+dQk5QE2ckH6ZmE
 fuPHuTWtCEjbjiRG7Yy/f47ya2DBhMNPEjOLk7bM2PstZbjOb1seDapBE2NhBHpAJSZP
 e1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HbeSiWmKhXAEBcyBWJh4BTFGtWTJPA+y3tTxzDeHMJk=;
 b=FciQZL4JlyPJLZer0QKhDYa0JdSrVp3lCdEHloMFIUWrtT9wJygn6W73OYnU3RpaYT
 TbFpZ+VPRnCt/MEn9+BVT6cefBWe/6Ii/sZpbzfIKDGfh4v3nSqBLVZj1f1oOUyhWBdx
 2pBRm20En0yjDizhYgVriLvU5JmAbNvF2weaHtMNSTxM1o4RKmZGVrKILz6BgkgLHig0
 Urtk1ZmKJfNMQDEQS9SEv8kjLVahd4UHHn/eb196nYjK6uRADG7iBGnbKE3vhlicsbGJ
 eueBuos3gX7RLssCg4E/v/nyUcgJ/5/VcyyTVPLRrJfq8Yf2I+FOH8NCR4lTNmZKWYpL
 IodQ==
X-Gm-Message-State: AOAM532QU2WxflPWt9VWsav0FRqxupf/qgErjYCjeGMaoaFy8K4qIEjJ
 PDDRCra6VEK9UOm1v4Jb7kouEQGd6qELEYOyqlE=
X-Google-Smtp-Source: ABdhPJwr957k1Vjrb1w5YBPuw3aJLbkuzj3er+KdGlAU3ZXciX9N8OREZVkmqreLnBuha5D6xnIesVqba+1Cok0cO+M=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr17053353oto.357.1637186130561; 
 Wed, 17 Nov 2021 13:55:30 -0800 (PST)
MIME-Version: 1.0
References: <20211117185512.102807-1-luben.tuikov@amd.com>
 <20211117185512.102807-2-luben.tuikov@amd.com>
In-Reply-To: <20211117185512.102807-2-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Nov 2021 16:55:19 -0500
Message-ID: <CADnq5_N5_GqQmoWUcUxmjqjnZw3oJR1vZ26wNCy083nmAGZNrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: Print the error on command submission
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Nov 17, 2021 at 1:56 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Print the error on command submission immediately after submitting to
> the SMU. This is rate-limited. It helps to immediately know there was an
> error on command submission, rather than leave it up to clients to report
> the error, as sometimes they do not.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index f9a42a07eeaebf..048ca16738638f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -352,7 +352,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>         __smu_cmn_send_msg(smu, (uint16_t) index, param);
>         reg = __smu_cmn_poll_stat(smu);
>         res = __smu_cmn_reg2errno(smu, reg);
> -       if (res == -EREMOTEIO)
> +       if (res != 0)
>                 __smu_cmn_reg_print_error(smu, reg, index, param, msg);
>         if (read_arg)
>                 smu_cmn_read_arg(smu, read_arg);
> --
> 2.34.0
>
