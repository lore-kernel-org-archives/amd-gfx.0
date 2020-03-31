Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49A9C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 14:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2862078B
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 14:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1G7c6dI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2862078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FE746E842;
	Tue, 31 Mar 2020 14:54:17 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 953E16E840;
 Tue, 31 Mar 2020 14:54:15 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id h15so26333637wrx.9;
 Tue, 31 Mar 2020 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HO6TrY5vHW3xCtXAgehmLHCRS7dfehnjLhFx26xMDoQ=;
 b=U1G7c6dIUiJdJNDBHMSSRHwSZ62lP7+ual3LVgEwKhursW1dC+ZfNBC4rLJVBTgXzp
 gGb+09depK86K4VS+NBP5cVoROKTuIr6D0JxZQjPKT0meNE/Gv/M7W9BhTjpZJvxqqGk
 DVJz/ZducLCzcG7pk/vZI1twZC/jkuVPFy8oMKFocfrF/rCp446+WKSK0EGa/NNaR8Yu
 /jGCXzmhszph91/K3p39NswbYsyy4SN8Wumcmbo09q0jdZUPVjHKn9dZDDKt0CIlqXPt
 3O79or2gzduI/i6BKYXP75mWMd3TvIgfLVY2aSkLTCMjm9puCJRj/ZHaBjbI3ezsi9m9
 NHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HO6TrY5vHW3xCtXAgehmLHCRS7dfehnjLhFx26xMDoQ=;
 b=jNKNokf600XbCAkqrxo5Gve/jnJ2ODlEDqbTsj6ed5KYlPFtEzrwxZzEkdbI+bJQif
 Xyn9is/Afwa8Aw+bkP/goFOyf4QQRh77nQfQKFZmypf0qP5xo7kdIR21n7vGiYe77yYq
 b4q1y+2NhTIY/V8nHlg0gkkt6CjsPz2vxPkvik/1bFZEKDNt1HZxNPwyfnAghRZFnHJX
 fajbZzzAy+2i8xmY3YLT4pWB5i8PLYjl5i0FFe+kF/FPdyQ7ToJ1Oce3jSS4MktCFBng
 JZKlUXbe0w+1q8hlVH0FC2ImlIp4solQ+j64cGpzJtQAO2YhjvnNWlzqJYWTxVZX22W/
 244w==
X-Gm-Message-State: ANhLgQ2r6QGRHndjOS9ghl9GVweScMfpQYYxOffxQRTK4QbY2sQQFXmY
 UYVdqoXPIFwzL2hzUQwBReCbtWj0rNR0xA6MYho=
X-Google-Smtp-Source: ADFU+vvPHEvkU5ZhiAKv+8P2j3np9aLNguMy5XOtTBfPRjaV1VagZhSS1Sw2OCRqF/o9dlJ3e5prEKanaJn5pIAVwEc=
X-Received: by 2002:adf:b35e:: with SMTP id k30mr20406573wrd.362.1585666454267; 
 Tue, 31 Mar 2020 07:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585651869.git.melissa.srw@gmail.com>
In-Reply-To: <cover.1585651869.git.melissa.srw@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Mar 2020 10:54:03 -0400
Message-ID: <CADnq5_MBKBKFLFQBXHzLYGdY_d8rbiEcWQaEQi70tJHTGTcXqA@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/amd/display: more code cleanup in the dc_link file
To: Melissa Wen <melissa.srw@gmail.com>
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
Cc: David Zhou <David1.Zhou@amd.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, Leo Li <sunpeng.li@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Christian Konig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 31, 2020 at 6:55 AM Melissa Wen <melissa.srw@gmail.com> wrote:
>
> These patches address many code style issues on dc_link for readability
> and cleaning up warnings. Change suggested by checkpatch.pl.
> Some issues remain and need some minor code refactoring for proper handling.
>
> Melissa Wen (4):
>   drm/amd/display: cleanup codestyle type BLOCK_COMMENT_STYLE on dc_link
>   drm/amd/display: codestyle cleanup on dc_link file until detect_dp
>     func
>   drm/amd/display: code cleanup on dc_link from is_same_edid to
>     get_ddc_line
>   drm/amd/display: code cleanup of dc_link file on func
>     dc_link_construct
>

Applied.  Thanks!

Alex

>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 358 +++++++++---------
>  1 file changed, 176 insertions(+), 182 deletions(-)
>
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
