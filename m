Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC8BC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 07:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F08A6192C
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 07:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F08A6192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 461366E9E6;
	Tue, 11 May 2021 07:49:34 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC2546E98F
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 01:47:02 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id c3so17560756oic.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 18:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=jwDhYoSBtKp4zzG+RxmDoOAYQl0Y8NgN4OEFS4amTxo=;
 b=q2tYdzJKo6Kkjd3ut96D7c/Bsv1LeswgevmxSt1moWd30WU1iA9DELC+44mJUZ9ajn
 +WEk7xsWGnZUYBcQLPLjr9M9MZREI+ROmE+AsE3auNe1/wYSSQHMTGfO0ibLCIWVteeO
 pd3SZOChYpvTIqPo6VTPkNH4RgS8kPCpoj9qcvNeYll1O1iobUG804hJP4/C0npDkm0S
 ssH4hfnfldg3IMz/yKmSkW+37Z37tM0SElj3CK5WvrQ04+Q5FGRD7L4wrrTgXw7x9STH
 1Z1yyJ6fsMs3tm3TKeyTJAeR+xbMzKjj6d+gnmMLWiyNYbKXciOzSV3IBqmp/0HjQRN2
 +RSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=jwDhYoSBtKp4zzG+RxmDoOAYQl0Y8NgN4OEFS4amTxo=;
 b=bGDVruOlbLGV+1v9EtZvJG1WaW0qH3refhOaGUfh6iDdEZvuPsH26NWTfqu01aPXYO
 PQjChOkhDjhmTOCt3s47g1swxn6P8Ow+lwTAvZEoSZgkLID9mp3FZWE9EBmScxxdVvGF
 5LznjHBJpcPPzohMUMX4shqNVf3etiOKCOWVrI1qEPc9lroPoCaJ8ciirzwuCAQloIH7
 I58IgEkNXjSRuUWMOEaWHvJJTF+NWjmOS2vGdrmKIejRwcIozrJFtITH/aA8KN+xgeT4
 xYRQoWZDCi9gEdvSTjs1Ior8kHQhN5FFqtfCAizRSLujIeEGYlnWtQmySYjvtMfFkn1H
 UE3Q==
X-Gm-Message-State: AOAM5307Btwwx5ea6HTjMWnNYU9wDqgy5v3Q+PB1RUJvK81yLthyf1/W
 h6y3UtGTG3FeyslnVzjjOu4gsJnxn+g8v30RryRcbixauKXipwj/6wc=
X-Google-Smtp-Source: ABdhPJwsMnJCOzHf0Y+NM3p3yLxNBWpc1vI4p/EOqOeSGbAzrT4d65rzSXG/dtFbWsTuc/kGCN1bmTmiBpeBQZxaCSQ=
X-Received: by 2002:aca:f5d0:: with SMTP id t199mr1669805oih.50.1620697621834; 
 Mon, 10 May 2021 18:47:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:4118:0:0:0:0 with HTTP; Mon, 10 May 2021 18:47:01
 -0700 (PDT)
In-Reply-To: <20210511003701.eik36vjufjbfegcl@outlook.office365.com>
References: <20210414000604.3273048-1-Rodrigo.Siqueira@amd.com>
 <20210510022047.9323-1-youling257@gmail.com>
 <20210511003701.eik36vjufjbfegcl@outlook.office365.com>
From: youling 257 <youling257@gmail.com>
Date: Tue, 11 May 2021 09:47:01 +0800
Message-ID: <CAOzgRdYo8x980u=x6uN5tGqoRw_9gqb0Mk_TF+nSN=rjD8e_tA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix two cursor duplication when using
 overlay
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
X-Mailman-Approved-At: Tue, 11 May 2021 07:49:32 +0000
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
Cc: amd-gfx@lists.freedesktop.org, seanpaul@chromium.org, hersenxs.wu@amd.com,
 Harry.Wentland@amd.com, Nicholas.Kazlauskas@amd.com, Ching-shih.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I using linux kernel 5.13 rc1, has "drm/amd/display: Reject non-zero
src_y and src_x for video planes" patch, git bisect bad commit is
"drm/amd/display: Fix two cursor duplication when using overlay", i
build kernel 5.13 many times, reboot test many times.

2021-05-11 8:37 GMT+08:00, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>:
> On 05/10, youling257 wrote:
>> I using amd 3400g running with android-x86, this patch is a bad commit
>> when i use android-x86 on amdgpu.
>>
>> Revert "Revert "drm/amdgpu: Ensure that the modifier requested is
>> supported by plane."" is the first bad commit, cause a androidx86 run on
>> amdgpu problem, look the video,
>> https://drive.google.com/file/d/1QklH_H2AlOTu8W1D3yl6_3rtZ7IqbjR_/view?usp=sharing
>>
>> "drm/amd/display: Fix two cursor duplication when using overlay" is the
>> second bad commit, also cause this problem,
>> https://drive.google.com/file/d/1QklH_H2AlOTu8W1D3yl6_3rtZ7IqbjR_/view?usp=sharing
>
> Hmmm... I don't think that the two cursor patch would cause that
> flickering. Are you using the latest amd-staging-drm-next? Do you have
> this patch in your local branch:
>
>  drm/amd/display: Reject non-zero src_y and src_x for video planes
>
> Thanks
>
> --
> Rodrigo Siqueira
> https://siqueira.tech
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
