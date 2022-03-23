Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC6AC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 14:00:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54C410E6E7;
	Wed, 23 Mar 2022 14:00:33 +0000 (UTC)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F7E310E6E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 14:00:32 +0000 (UTC)
Received: by mail-yb1-xb2b.google.com with SMTP id j2so2912992ybu.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 07:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WXmsudQE/TvO9iiY9zNu+1IylJ/3Toy3swSwCKBPOo8=;
 b=pLPt4Nny0j0BQLv4HIqLC3M+OAARYiL7j99SY2OpCpU5uMTMP73/MrCrJe1qGuG6z3
 LbV9s/x/7bxnISY8mUpG0XzF0ugw7k3K5bL0znrMDaptTcAwr3wXVL/rAU3TUvGERTD0
 eyT4equSyxkz8pweRVpOnMFupFINS4YY5vYVvclUw7yLdVECrnJSCQmBZf4YZ5ueD/wB
 Xfl5u508JiydNzfJJdCPoUIPVOX3K3/9Wrg5Cir5Q8sIc89cdmO1mP0CYlkCldvzXm7M
 dP3/kJWAlV9wrMuz86UIBwBIBlyFGomcM0amaSo6CvWxcGg7aUeB3LtGuTwO1GdAQfnH
 hE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WXmsudQE/TvO9iiY9zNu+1IylJ/3Toy3swSwCKBPOo8=;
 b=o70QNXSOkEEL1V/j6J3Vv6vrNhYSBRkMp7IhfQgXm9l/NOMO5ze1zQlr2ByCsq3YIC
 dusIZO0e9QuudlYGN3Q78U6GdJRNF+MGQLi6EiNCPKF+8IS0BWe01Us+unTcelvKIzf5
 RTV6ZolK65goQ6boqWL9iAcWTgsABtsM6zwinhJ21SobuBKOJzLxmb206+TgtFzyyRnv
 FMmJPGj5pYj6qms2bpy9t7Wta3GWbijmT4aELFIbf9rR0baOa4WGX31guuRds1x4pB2e
 wuI4c6JO82sIZVWJP1lzxOVL+2mdFbDOWPXbXCRPbVj2F7P8++XfW3F9lFDbA+VDZALj
 nD0A==
X-Gm-Message-State: AOAM530UMMT5EdYNK0G18mbQIcVM8KGGP7M1kzKlFO4FiFuOY+T4yhR+
 w/e1yYEPwpwK73gsWUfiILlY+1pan45gGU/VviThWQ==
X-Google-Smtp-Source: ABdhPJyHa7eOvNnyaHxUf07xuixSXY4plTAI+F72p+vYBKR20PiTxHWvuY2S3ZZhmuCa01nJPpnMNsM9vx/1eBu5XnY=
X-Received: by 2002:a25:ccd2:0:b0:633:786a:b105 with SMTP id
 l201-20020a25ccd2000000b00633786ab105mr87355ybf.28.1648044031330; Wed, 23 Mar
 2022 07:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220323062552.228429-1-Arunpravin.PaneerSelvam@amd.com>
 <7addb3e7-d265-c1a7-d449-7d0056f06d63@molgen.mpg.de>
 <fc60c561-c12a-c031-9558-abae3e3474ec@amd.com>
 <6f0888a2-f74d-f41f-d593-a8362e7dc673@molgen.mpg.de>
 <398f8851-d37b-4020-24ce-8f2ab9723e40@amd.com>
In-Reply-To: <398f8851-d37b-4020-24ce-8f2ab9723e40@amd.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 23 Mar 2022 14:00:20 +0000
Message-ID: <CAPj87rMETV9UkpbGRYAT3mjVhRtW75m0e9OLON6_+gdcD0Fo2Q@mail.gmail.com>
Subject: Re: Commit messages (was: [PATCH v11] drm/amdgpu: add drm buddy
 support to amdgpu)
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 matthew.auld@intel.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 23 Mar 2022 at 08:19, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
> Am 23.03.22 um 09:10 schrieb Paul Menzel:
> > Sorry, I disagree. The motivation needs to be part of the commit
> > message. For example see recent discussion on the LWN article
> > *Donenfeld: Random number generator enhancements for Linux 5.17 and
> > 5.18* [1].
> >
> > How much the commit message should be extended, I do not know, but the
> > current state is insufficient (too terse).
>
> Well the key point is it's not about you to judge that.
>
> If you want to complain about the commit message then come to me with
> that and don't request information which isn't supposed to be publicly
> available.
>
> So to make it clear: The information is intentionally hold back and not
> made public.

In that case, the code isn't suitable to be merged into upstream
trees; it can be resubmitted when it can be explained.

Cheers,
Daniel
