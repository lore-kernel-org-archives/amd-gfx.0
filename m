Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CA0C531D0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 16:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 600E310E690;
	Mon, 27 Jul 2026 16:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VnJTbcQE";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFB6710E4AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 16:46:42 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-381f03d7be0so194335a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 09:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785170802; cv=none;
 d=google.com; s=arc-20260327;
 b=T3JTIGzXuxiw6NXSnb9jMWdOgu5tMEURDiukT0yMMh4SgXaMdcgK9Nhz9+9aMlpA5S
 facAvb3emUYArcsdvSWRAhceWqzEXVZ3DJy9oYAaia/nqQAtzX0eukpMiKgnazxX8IV2
 RoRSIsbXk3djafparhpdGYlrRmAb1R033chSOpko4Q5brYRDsqmbHhxbMv0yk64cb495
 z4yEH3ac3m1P93b7Y8CyB5xn6FrlH9+1Q0baUZeKbPubRaPKO6oIqydiMxIwsVgjC716
 0creaTMwp0JgU1ZtV14wsfa3VNEezf1BRrXwQJOaMg+fLnaG7RZbfBdJEneTNwj6MpT0
 MEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZYf/rihhYlrBAKYiCrpMlaiVI/+cGiqgdriA9fSdZao=;
 fh=JbttwQGCaUU8Mv6Akh7HOm/ylmrkrZuzwp5T2PwY8Zw=;
 b=ej/LNi0pCD536aqpL9lHvDuBS1yMlGgMx+inp5EY8ESn+nBl7BtIJCYKJip117vZJy
 DvR0TSnI+Vkh5/WVTR8cCfzscIa/6waFdfbBe7tbd/yKDmF0VYuBejt/CVYMFkNSKYu3
 zRMSc6YMmdO6SGMudkh00azo2l7ZLnOGB+c3WNrTSBn8fZkUqZiqvYOruLoNq8dAWLDy
 H/iBdBa84hKSNSTUYifKjg39IN1fdcEo5tOSTHydjuQZJi/+WP52r45eAJu0l2ZXNMVc
 QHsnuE0jFmRcmhJMeYtKsu461YkFwK2cv4vL0COG9DyP7/vI4ouLyxYMxNstj8IVx3KG
 IOXQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785170802; x=1785775602; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZYf/rihhYlrBAKYiCrpMlaiVI/+cGiqgdriA9fSdZao=;
 b=VnJTbcQEf6X8UxXL0p8s85FpkEyHhVNH3YFAL5SQfJ+h63vSt/3drr0KzfVoUxW0Zz
 VSLzKreHH77L9bANr6/5VlUwKFA+cAi0238QI04MRSTBaVkeFa+mUaRv/yjgDP0w9Jcj
 PPZS9uyODYz2DLbBd2Pl8n7T8fCrNHnUT99pDjN/TX1s4jsjsIu5gdAZi33D7VJFMdQB
 7JbuWJJkInE5pLPhFvecoBEVh4gHNi2WEF+7rrt37FJwVTwU32szcDXb78O3IHli2NfA
 rLZGv4v+Wn5vs9nWDtGspFcccpj0k1E/343XLWVpEXQOf/jxyog73idRMRbkwjAyukMo
 5Prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785170802; x=1785775602;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZYf/rihhYlrBAKYiCrpMlaiVI/+cGiqgdriA9fSdZao=;
 b=abSk+SE8XV3kI9N6SQlJsT0RMzGoDjjdgzTmF0xUmkapuOLiF8ULi24iXhRlwKthof
 8aqyo6con1gQqul5suKEBzsEMvtVuWYmPw1UNodfi9UEKHlyJuQLXlzGQGXnF2BDl5q0
 jrQ9IQ2DMydEik/Sg9KjgYep2bDGOk86ZXil9BwC6tf9IiC0iPfVt3gV89f7oLLhju6F
 9A1X7rx7Ix0rBoL6LbICDAu0xEoKjzoY4FV6d8pZ2UDL6BtAbyDfvwBVd1lQYm2h/Ria
 y67bIJSQZFDl0VfkWMS6cgNM7opbNI4Nh6kufcN/Y6DBDTPfX7qKjnNJ/rdoYSrVrcBh
 Q67w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRHxtXnVIPcpt+y9vrd6PAvRK0XTYSJta4w5aHxK7fkC2AKkoKOi4o+gMW9dSC4Lb0e58/nXDM@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/LmrmNmNIjQDP1UewUDLxMFjFJuqyXP6xOAOJH3B3vx7srD6G
 Nno5JmJAGKRlvALh2koKfEkeMuq+8NAhJX2yHQQECG06Pn0bbS9boMGkifauQwzGXXicCjIAL9d
 qY2Q3VxsDe+/Vj+QDcDWVFrubJSbQe4k=
X-Gm-Gg: AR+sD135ST1MvmElM38Uq8ndobl1OtPCZ2UmAb5KOdYsA3IWgt3apkDBYIy8BMPyfnZ
 +BNtjyO6NDjHuvHWZ3RS180ZhBVqIAnbYFLLcS/eaw0+JAK1ja4uTpYsvPqh7sR4rncOSdoZbzD
 vGExuYKp8lf7fiMWoj7HgLQmY8FvdgcijHdhgX32MhDkS/MUP8Z5v0M8YkI9uHvB/NqoLGB+Hak
 LzQbq5cJNmv0SSYBwck5TQ1CPjvOwN1vUnF42mBe2zVV+TEwCVt2PTt3mqUvRmePXdWsLt8k2je
 k9eBKkThiQmMj4KokCvRd9hFOHqwaLcFqRnmCAWfBuIfJdNj386poaZBACwZ61cueFzV1BKVOAs
 vuiQTwMx6K/JSQrRI+tCME45G0y0X02A=
X-Received: by 2002:a17:90b:2c87:b0:380:9cd1:d985 with SMTP id
 98e67ed59e1d1-38f628a2013mr619020a91.6.1785170802281; Mon, 27 Jul 2026
 09:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260429171644.8406-2-u.kleine-koenig@baylibre.com>
 <aimWvtBTQvd7O2F0@monoceros> <al4HlJxVqCDae5yL@monoceros>
In-Reply-To: <al4HlJxVqCDae5yL@monoceros>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Jul 2026 12:46:30 -0400
X-Gm-Features: AUfX_mxH9LpbVN3XQked1-UcBEsMG3vSzn_JrwmOJW3uHzU_2audivCCcr6wjdA
Message-ID: <CADnq5_PtuGS_FXJJB6kh_xVUPFDXznLQbKuAGZN+choXhPTH9w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Consistently define pci_device_ids using
 named initializers
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks.

Alex

On Mon, Jul 20, 2026 at 7:44=E2=80=AFAM Uwe Kleine-K=C3=B6nig (The Capable =
Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Wed, Jun 10, 2026 at 06:55:09PM +0200, Uwe Kleine-K=C3=B6nig (The Capa=
ble Hub) wrote:
> > On Wed, Apr 29, 2026 at 07:16:44PM +0200, Uwe Kleine-K=C3=B6nig (The Ca=
pable Hub) wrote:
> > > ... and PCI device helpers.
> > >
> > > The struct pci_device_id array of supported device was initialized
> > > by list expressions. This isn't easily readable if you're not into PC=
I.
> > >
> > > Use PCI_DEVICE* helper macros and named initializers which is more
> > > explicit and thus easier to parse. Also skip explicit assignments of =
0
> > > (which the compiler then takes care of).
> > >
> > > The secret plan is to make struct pci_device_id::driver_data an
> > > anonymous union (similar to
> > > https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@bayl=
ibre.com/)
> > > and that requires named initializers. But it's also a nice cleanup on
> > > its own.
> > >
> > > This change doesn't introduce changes to the compiled pci_device_id
> > > array. Tested on x86 and arm64.
> > >
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koen=
ig@baylibre.com>
> >
> > Gentil ping! I'd like to work on changing pci_device_id, but that
> > requires that this patch hits mainline first ...
>
> Would it help to resend? Did I fail to Cc: someone to get this patch
> into some tracking?
>
> Best regards
> Uwe
