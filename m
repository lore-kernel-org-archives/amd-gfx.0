Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18E4C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 17:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C34564E83
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 17:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C34564E83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4EA56E850;
	Tue, 23 Feb 2021 17:44:32 +0000 (UTC)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch
 [185.70.40.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 840B06E850
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 17:44:31 +0000 (UTC)
Date: Tue, 23 Feb 2021 17:44:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1614102268;
 bh=BfG9OrbmBqNgKkcmelq97SJlZ+CtFojaf6Sw7blBg4M=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=k+vipebctkBPk5Y5rqzJxjWp6xU5O2k6NKU+w2LmQM8zg+dCS2eHV0eb0kv2yQY0+
 HVX44ICA2J1K8E87n/HqLAI2RvAHxRc5wwSM1P8+RYFoszkZWR3Qob4vnzuwrpO6Wm
 Fe1Ws0w6+6ivYkrlcZyMFI7KOh4LGpjgKCVIEDHiLgPt8swSv8KkMhtzKmq0Smm1mW
 sxZKpdM75tqH2ldtaWqHnZdK0yuqolDlj2z/4hA9gYnpNmyAf9B0o8uIkT15MoUhFA
 cmvCcgqfiSL1DtdrxMGzLcjK3S/KkFHOui/sj7dI37j4dp1h16btFxHq2aL1tqcsKi
 q5kuW9jem5ZFw==
To: Alex Deucher <alexdeucher@gmail.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amdgpu/display: initialize the variable 'i'
Message-ID: <SPaFghh3lWax7Iwge3u3t7hAegI3wGyl7euN4azxZEVvTky4UCXmPq7QQSFFd38dgg3kgkhuJpjB_D3ob7Tqf5Oc2DGKCwHZIWzfit15Uyg=@emersion.fr>
In-Reply-To: <CADnq5_MXK_H-g4GReU1dGca2PAXsGjbzg47kcWjXFQ4DrYG8tg@mail.gmail.com>
References: <1614021931-4386-1-git-send-email-jrdr.linux@gmail.com>
 <32vjVDssCxltB75h5jHin2U3-cvNjmd_HFnRLiKohhbXkTfZea3hw2Knd80SgcHoyIFldMNwqh49t28hMBvta0HeWed1L0q_efLJ8QCgNw8=@emersion.fr>
 <20210222234457.GA36153@24bbad8f3778>
 <yHvp7KbQD2pF5dR6krMc_Zuq9a8GxkYSSiIpjBenuiCjwpFmFxpAOpfzhp0DfHQhH2Z3P81-CGpwmmXp0zjifT93vBXXYd5kJsSucQgXFZI=@emersion.fr>
 <CAP+8YyGdr0jkf5_K8ofKMzZn5Koy_vkxyKKHkyVDqDz2sWvL_g@mail.gmail.com>
 <CADnq5_MXK_H-g4GReU1dGca2PAXsGjbzg47kcWjXFQ4DrYG8tg@mail.gmail.com>
MIME-Version: 1.0
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Stylon Wang <stylon.wang@amd.com>,
 "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Christian Koenig <christian.koenig@amd.com>,
 Nathan Chancellor <nathan@kernel.org>, Dave Airlie <airlied@linux.ie>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 Souptick Joarder <jrdr.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tuesday, February 23rd, 2021 at 6:42 PM, Alex Deucher <alexdeucher@gmail.com> wrote:

> yeah, fdo ran out of disk space so I moved to gitlab:
>
> https://gitlab.freedesktop.org/agd5f/linux/-/commits/drm-next

Ah, thanks for the info, my bad!
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
