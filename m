Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DF3C36005
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 21:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65F0210E1CD;
	Mon, 24 Mar 2025 21:21:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SPEIZ9ad";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD7210E1CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 21:21:45 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-301a6347494so1239738a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 14:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742851304; x=1743456104; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2C20Cvo4ztfO7JGeQOaf+Jo0vtqeG0wtCaDHVkqbzo8=;
 b=SPEIZ9adtMTwMCc9PTq7sQz6ykVhCN1Yp1Hfw2VT/8vqOUaRHBbE5Tf9X6UzLwkKXu
 FZWT5jFingXCqLVyJqIcaHK1/q4hvNs1yaLXvwNWQsK9mXLW/LNl63m4MRpB9Gok627N
 b+96lgHXp72wG5ZuM1AnbKWITBHh/T7xqO9d5OYeSwC0xz/cjg2DLul7OK6S86S9ifoY
 v5SVFhp+XOPyP5gABBByyhJ82a+ng8+4WAyRcG6GfIT7Hj7/JixRIxBBKbO6bTKfy2z4
 WsMjczjw7uHErXyUJ8Qxd0N0jN6EObSWeyDihdFxD/Bqq61i6P563IRFXSFCwXbG1Hpb
 JLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742851304; x=1743456104;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2C20Cvo4ztfO7JGeQOaf+Jo0vtqeG0wtCaDHVkqbzo8=;
 b=V5u/U8G0WbUsOPXMOSIWniH0mtnz0U0P7r8PXBn42htlr8fIKtcMp4rSgY8pa3MSl/
 WvlxjT2hdkIiULZHv1UkBm5CGsCEKdzGb95Aorym92LzCozwzOzCV8HRM2uqMFRFIgpS
 lguy5Z/WhgQeinjWJeWVzbcSfa4oZcM1HzE006Rr1SH5nPgIkRrfP6R8DyxbVsVJ6axw
 5w8PV8/vFlvLqKTIoNOzNzUMa6WcvLkHoJ7iBcTMoU3V44ouc7QigZQ2x/mGyhh231ci
 P4otp3/FpeBwrA2ZG8/vAolCARO3zyJB0l2MbEG5wK3eW/2IQZZLx29d/o3EyjZSBCf1
 sIAA==
X-Gm-Message-State: AOJu0YzG7yxIpEvepfYJs+sIBpVIgwuR1YNXWHauoNXi/8tfGFcD1q5V
 W42lWBo+o7JGkUE1pa/eWH7RkMdp9VuK3Hz2vhXaGH6Vzz6ZlnltsZGd7pGeluxdltYVVfx8CpO
 qKufOP8aRgujV2xuiDThn+y9oiP2jXw==
X-Gm-Gg: ASbGncuJxiBPxG1vDL3eUNGhmd74g1q2S4O8iTdKQoeMiBta4rf1bH2c8d2f9SRU/Ms
 c/RQuDmvLs3c7fwG/QyWxMqF7ryNhPUu5sawrpFTWhsjlE65i7hGupTuFbh49i39pYPl8E4epaX
 Ud6Vhjq31Gb0w9ZJreZrixrQ/91g==
X-Google-Smtp-Source: AGHT+IF/MFQeCSmLbVmIK4MFMpYF/eh2nhdk0XjOEBc0bqX8+2wKjvQjlPlo0dGN+xEFIYnmWMspT2CLrXr+NzUnJdg=
X-Received: by 2002:a17:90b:1b09:b0:2ff:4e90:3c47 with SMTP id
 98e67ed59e1d1-3030fee39d8mr8432397a91.4.1742851304388; Mon, 24 Mar 2025
 14:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250324172540.128507-1-jinhuieric.huang@amd.com>
 <CADnq5_OKVowRi_ivnE4O0NDPLCW3RTq4LKM-1M86hUnDcbB8fQ@mail.gmail.com>
 <e38a6e0a-34f1-45db-bebb-f260eba421ec@amd.com>
In-Reply-To: <e38a6e0a-34f1-45db-bebb-f260eba421ec@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Mar 2025 17:21:32 -0400
X-Gm-Features: AQ5f1JrZFBfjEcpQGu_-G7OrFpMaEVQszmRXK0nsvNbTudHlnyEwnIyMhdBqcZA
Message-ID: <CADnq5_OHXK6DZO+nNDuaZQW61U5Hghie2qNHB9pfUe4T0gxE_g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: increase max number of queues per process
To: Eric Huang <jinhuieric.huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, xiaogang.chen@amd.com
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

On Mon, Mar 24, 2025 at 5:07=E2=80=AFPM Eric Huang <jinhuieric.huang@amd.co=
m> wrote:
>
>
> On 2025-03-24 15:32, Alex Deucher wrote:
> > On Mon, Mar 24, 2025 at 1:26=E2=80=AFPM Eric Huang <jinhuieric.huang@am=
d.com> wrote:
> >> kfdtest KFDQMTest.OverSubscribeCpQueues with multiple
> >> gpu mode fails on gfx v9.4.3+NPS4+CPX which has 64 gpu
> >> nodes, the queues created are 65x64=3D4160, but the number
> >> 1024 0f KFD_MAX_NUM_OF_QUEUES_PER_PROCESS is not enough
> >> and test fails at function find_available_queue_slot().
> >> So increasing the nubmer will make the test passed.
> >>
> >> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/a=
md/amdkfd/kfd_priv.h
> >> index f6aedf69c644..054a78207ffe 100644
> >> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> >> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> >> @@ -94,7 +94,7 @@
> >>          ((typeof(ptr_to_struct)) kzalloc(sizeof(*ptr_to_struct), GFP_=
KERNEL))
> >>
> >>   #define KFD_MAX_NUM_OF_PROCESSES 512
> >> -#define KFD_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
> >> +#define KFD_MAX_NUM_OF_QUEUES_PER_PROCESS 4160
> > Doesn't this limit have more to do with the number of doorbells you
> > can fit into a 4K page?  If you only allocate 4K for doorbells how can
> > you increase this?
>
> The doorbells size is allocated dynamically as multiple pages based on
> KFD_MAX_NUM_OF_QUEUES_PER_PROCESS in KFD. Currently with 1024 of this
> macro 2 pages are allocated, and after changing to 4160, 9 pages will be
> allocated. Please refer in function kfd_allocate_process_doorbells().

Thanks for the details.  Since most apps don't use that many, it seems
like a waste of doorbells.  Should this be limited to certain
partition modes?

Alex

>
> Thanks,
> Eric
>
> >
> > Alex
> >
> >>   /*
> >>    * Size of the per-process TBA+TMA buffer: 2 pages
> >> --
> >> 2.34.1
> >>
>
