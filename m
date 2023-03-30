Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AEFC761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 15:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B67310E1E5;
	Thu, 30 Mar 2023 15:08:22 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E6E10E1E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 15:08:19 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id b19so14381984oib.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 08:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680188899;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nlt164Lr7FdrPCEsYnfpNo0ipqf0wfrHjcGU6P6G7a8=;
 b=L1f0jGGATJ/TqWHtN0u5+WWl1X1MTBfzDToeQWJ4BTDuI+tBPSk0FeIFCd24mP2Oyo
 FP4hTAZQ2gwIOnf6xknKCoFWypv066Btdow4QQ7nqUi74NMWaBaA6Ea4tKAZiKtHuk3d
 0hMhOPDn6Ao8fsb9jJtWYlQUP2YhK49/4jzUOdTAwbaDQVSE/AF71BoHlFJMi5tQzj1L
 9tU1nFjSkzg0ruGqe3nP20bHRZt33M9hC3xajn2aYOALDbKDMi6jKqpuZSmo4F4JX8e+
 +8tCmAuG1qq1oT9jm6nsJmqzE1wDvIxKStwk51emyvC7rDZeGOBzjbuQfNoLGRX9dhzo
 AjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680188899;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nlt164Lr7FdrPCEsYnfpNo0ipqf0wfrHjcGU6P6G7a8=;
 b=mEmBDTXGjOO6/iN8lck3w1LJ79uQcfKPIsaZTq0zpzfzYam4FjW9srCQhKNHoKQvb7
 PYKrmsgLqlAPcJWNotX+oRuB8y5HcMHY7CejKufl5gtQZ03l2TzSMRW+hclNQ0kCIDIC
 UW8rx8o8Xm7BVVsmN2A5Hwzxssc4F0sww9yV6cCFbYPbULC1N9vOQ3DpVAB3jINsHfhh
 KPABmTVH8NmAIFhNaW17N7x1MvcpV89Dy+fZZvGstna2SbRckNet5vgXHiF/cjjWeMyc
 MiVTaENoxCFZG9+DHaIqt8niNAFiKJMODijgkZttChQvQl5Jzgt1U9vU0gex88ShrdOB
 S3Ww==
X-Gm-Message-State: AAQBX9e8HpsOTk1JhfB2vdgsUqgp+iLR9dr2Jq46SLO4gp7i9bZNeTnK
 eixcLJZDhtq8NQt/1sUgJEDiubjjGATf6GApuhE=
X-Google-Smtp-Source: AKy350YLNTouWjKuL2sfgAi0hXPMiC56QN3UZUO9Ot8IOU6kPWovtYzttRqiheDpqx1hh5c3k12T5P0mrhRA2NSMFSI=
X-Received: by 2002:a05:6808:608:b0:389:52c4:6b8d with SMTP id
 y8-20020a056808060800b0038952c46b8dmr2923270oih.3.1680188898904; Thu, 30 Mar
 2023 08:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-2-shashank.sharma@amd.com>
 <71fc098c-c0cb-3097-4e11-c2d9bd9b4783@damsy.net>
 <48c60002-7f75-b0d0-fb7d-44b87d9cdedd@amd.com>
 <3c76552d-e6cf-cc89-1e57-e5ee789e79a6@gmail.com>
In-Reply-To: <3c76552d-e6cf-cc89-1e57-e5ee789e79a6@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 11:08:07 -0400
Message-ID: <CADnq5_Ob3vy=4GZZ=AijfWP85DBOxemmo3DaLT6HKNk8VgKLUQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] drm/amdgpu: UAPI for user queue management
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 Shashank Sharma <shashank.sharma@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 30, 2023 at 6:40=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 30.03.23 um 10:15 schrieb Shashank Sharma:
> > Hello Pierre-Eric,
> > [SNIP]
> >> I'm also wondering why the doorbell needs a handle+offset but
> >> other buffers are passed in as virtual addresses?
> >>
> > As you know, doorbell offset here will be an relative offset in this
> > doorbell page, but the MQD needs the absolute offset on the doorbell
> > PCI BAR.
> >
> > So kernel needs both the object as well as relative offset to
> > calculate absolute offset.
> >
> > something like: absolute offset =3D base offset of this doorbell page +
> > relative offset of this doorbell.
>
> Another much more obvious reason is that the doorbell doesn't have a
> virtual address.
>
> At least for GFX the doorbell is used to signal to the hw that new
> commands are available. So as long as we don't want a shader to kick of
> other work we don't need to map the doorbell into the GPUVM address space=
.

This certainly could be done if the app wanted to, but to set up the
queue in the firmware API we need the index within the doorbell BAR.

Alex
