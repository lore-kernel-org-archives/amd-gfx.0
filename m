Return-Path: <SRS0=tImT=KE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A963C433ED
	for <amd-gfx@archiver.kernel.org>; Sun,  9 May 2021 20:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C756135A
	for <amd-gfx@archiver.kernel.org>; Sun,  9 May 2021 20:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C756135A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78B3D89D87;
	Sun,  9 May 2021 20:57:12 +0000 (UTC)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D724389D87
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 May 2021 20:57:11 +0000 (UTC)
Received: by mail-il1-x130.google.com with SMTP id e2so12363846ilr.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 May 2021 13:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7g3medDBvbFx7n0dUXTZJsJZvbWoM3FAHAFFWR6RvNM=;
 b=TJy7/Tz9vjA1OuVtdFeXvSJERrbqVSS2qsFvGDlZW1thpl1xFDH0WoSXm0grUSxXyw
 rUPkGEpIXB00fF7R3nWcMQ6KyxkBh7ZvY+CRtdM76GRC08EBrbv6lpniIFoWCUuDImIW
 PJ4xtUVvDMqxWxqcN+A6LV1KXAIT8OUQyC5lopdWpB7mXzGf3GGRgrMWzRDpYKRhk3Vv
 gkcGMDb0GD1RqhM9V0mAZziBQkkxWnH9cmIQmFUwARYD3tsu0K3j7dh65ubTyH9QS5Z7
 I5NI6E8INLTN0bDWoHf3WnsVF2gsWMws2qEexXlOk72uY+TmCeA17pyUCIGdkQok7chO
 nmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7g3medDBvbFx7n0dUXTZJsJZvbWoM3FAHAFFWR6RvNM=;
 b=JPJVr8D1R+7TPjN6PbBburHsv1JtMZqNyfLtoT1pS6fmooll0jWG5QnciLhOlMKbKm
 FGCjI/ESexqvsZlaMk1X6Dh4PEkTmGWQqctXFB9CPkfYqG07S5BaxwoFED1lwBi9XBPk
 v+KFNBDrLflkSPOwgPBHg8d+9DvN6HnviXZMrMppDXwzdHPIp0VcqR52atk+M9Ljxx0E
 HVDGgiu88H0JCdfEw0TTkibhkLRTLW17DEioMbKxP/GI0jGroRpyBF0Z8pMcyt0bktAZ
 Z/T0yheccuZ0ZhggGFBa8pkO0G1qxWZBqxedA383cr8N4ViJhmKRyrqfXanArN4us7gH
 oOOQ==
X-Gm-Message-State: AOAM533+Xq0Rd4SueF8tQwOTgJ/U58cvtmjqDHJ5oXr6LHAHlR9YG9/w
 eCQVyPESSHIpD6EYkowoZrc6sx0GqHY0u3C4oMbgOw==
X-Google-Smtp-Source: ABdhPJxsndRZvi4luekEBYiXM3SJlq/vDP7SbbVNKBuxH/ND9vvubzCrQY2gowAcJrY06Dv8ESB9EL0evwvQnMGU6uw=
X-Received: by 2002:a92:6b05:: with SMTP id g5mr18671199ilc.40.1620593831225; 
 Sun, 09 May 2021 13:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210414233533.24012-2-qingqing.zhuo@amd.com>
 <20210509121055.24728-1-youling257@gmail.com>
 <CADnq5_MF0y0sHH6Vz8KZH5j=iXToq3WPw7+kW=BqMk=oNZ=Ppw@mail.gmail.com>
 <CAOzgRdZf0R7mVY+spDZz_CG1Kpf7qmP6oGaOJ_XKauZA3ZhZeg@mail.gmail.com>
In-Reply-To: <CAOzgRdZf0R7mVY+spDZz_CG1Kpf7qmP6oGaOJ_XKauZA3ZhZeg@mail.gmail.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Sun, 9 May 2021 22:57:10 +0200
Message-ID: <CAP+8YyEv3NPqeEVmFvQDoq_+=h8Q_goHUbgt7fNPUXJbR5AcKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "Revert "drm/amdgpu: Ensure that the modifier
 requested is supported by plane.""
To: youling 257 <youling257@gmail.com>
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
Cc: Mark Yacoub <markyacoub@chromium.org>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wheeler,
 Daniel" <daniel.wheeler@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It would be very helpful if you could enable drm.debug=0x4 and then
take the dmesg to figure out what modifier was rejected

On Sun, May 9, 2021 at 10:51 PM youling 257 <youling257@gmail.com> wrote:
>
> look this video,
> https://drive.google.com/file/d/1QklH_H2AlOTu8W1D3yl6_3rtZ7IqbjR_/view?usp=sharing
>
> 2021-05-09 23:52 GMT+08:00, Alex Deucher <alexdeucher@gmail.com>:
> > On Sun, May 9, 2021 at 11:42 AM youling257 <youling257@gmail.com> wrote:
> >>
> >> I using amd 3400g running with android-x86, this patch is a bad commit
> >> when i use android-x86 on amdgpu.
> >
> > Can you provide more details?  What sort of problem are you seeing?
> > Please provide your dmesg output.
> >
> > Alex
> >
> >
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
