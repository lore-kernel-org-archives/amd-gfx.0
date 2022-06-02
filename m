Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D967CC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 15:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7119810EF65;
	Thu,  2 Jun 2022 15:44:22 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 521EF10EF65
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 15:44:21 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-edeb6c3642so7225976fac.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jun 2022 08:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=P4l1FsyAk1RlV/u3mgwVdI7BUjKPUw4KOmo6ae9MZqQ=;
 b=XTpUyxy/cMnRWRwyHzKa/U5L3VPm0PxvRYr4BcEHyeTboJSw7UN1o5oG2iLyqZ5aaB
 fllfXZmsdhCcWZzORSfvbkRJiwK+MyaIBAh5SALO/97D/JjRNi/es1Yki0bLH9oarz0M
 stouJMkGwu8gnNWF14qvmSi3JJbUgd51iTK4V5XifHkCx26douZN4TLtfzHkK3Oe8n57
 JoYntRGky4DYl/KBqf1qltGD4YyrOfx8AhXYgVNn9KiIzc6K12WpXySu9ffml6JFX1pC
 e3Es2rfPW1CtqDexu3BamFq9JzF9MQsZHyEwRi4vXtmbKsiED3hNGu7NUMVFOyQIfMh4
 NyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=P4l1FsyAk1RlV/u3mgwVdI7BUjKPUw4KOmo6ae9MZqQ=;
 b=hl3mkJXLXwBQqlb5UVq50ryVRXQ6orJ8dfI/TSApvkEXgslNk6drLLvxvg66MxZeZK
 Q5pTFRC8VC8haC5rHq9RsYFKk8t9+s7wo3L4sahLYc1l+7jIdMfhxX2N/1fR6Iz25IdC
 /HEeuX4SdBKaKdEPCOzhxQ12n7+4N3SQeP+dknaP/shJl13dGT2L+gGg2w9JdcYTxn+A
 Aq+FftUu/6NbsgTlOF8h3in1gnzKCZH4rVTpmzY9fEPz3dKGp2kZfardo1skDz51KoE4
 xCqrSFZZOfa+Lycgv1aO47kbwiPZGY1/WD6bZ3f85Z6WNHaCZnU2oW4gf5XxVqOhA59W
 X2Hg==
X-Gm-Message-State: AOAM533QDhUu8tFkxNDua98pbhsPb8a6je4KQq+lGfywEbG1JJt5pFSu
 pPl9unhDYyHM4UrBy+eVzuC67TQ0/OU8ZQuVZNA=
X-Google-Smtp-Source: ABdhPJwBWNuwkjfuM/Dk3xLMjuvRlvgqBJO3Cukj3tw+uC8b87N4KCE8kjFaJ2nPf9/5YrzxedQa0BEj3mzUoq9NucE=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr3136696oap.253.1654184660350; Thu, 02
 Jun 2022 08:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <202205271546.oV14N2r8-lkp@intel.com>
 <CADnq5_NOkqRsoqELkLayNU+xArXd-4RO=_banvJpXHtSW4-YdA@mail.gmail.com>
 <CAD=4a=WRbp8w4DA2c6hE7W5A2-woRyHLvtC-GPitFwQireCeNw@mail.gmail.com>
 <20220602115046.GH2168@kadam>
 <CADnq5_PZBV0wAnNSLSdTc_8acaK3F6ZKDpcgwktmNaR9DKxG9Q@mail.gmail.com>
 <20220602153326.GI2168@kadam>
In-Reply-To: <20220602153326.GI2168@kadam>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 Jun 2022 11:44:09 -0400
Message-ID: <CADnq5_PucdB0D0o0oGUbh+CziYgNqRX+mReTpNDO-ZbsLUEFGg@mail.gmail.com>
Subject: Re: [kbuild] drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1433
 amdgpu_discovery_get_vcn_info() error: buffer overflow
 'adev->vcn.vcn_codec_disable_mask' 2 <= 3
To: Dan Carpenter <dan.carpenter@oracle.com>
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
Cc: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>,
 kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
 kbuild@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 2, 2022 at 11:33 AM Dan Carpenter <dan.carpenter@oracle.com> wr=
ote:
>
> On Thu, Jun 02, 2022 at 10:24:58AM -0400, Alex Deucher wrote:
> > On Thu, Jun 2, 2022 at 7:51 AM Dan Carpenter <dan.carpenter@oracle.com>=
 wrote:
> > >
> > > On Thu, Jun 02, 2022 at 08:26:03AM +0200, Ernst Sj=C3=B6strand wrote:
> > > > Dan: I also ran Smatch which resulted in the following discussion:
> > > >
> > > > https://lists.freedesktop.org/archives/amd-gfx/2022-May/079228.html
> > >
> > > Since the bounds check is dead code which does not make sense and is =
not
> > > required, another idea would be to just delete it.
> >
> > It wouldn't be dead code if AMDGPU_MAX_VCN_INSTANCES ever increased.
>
> Or we could add a comment to the code I suppose.
>
>         /* Impossible in 2022 but this check might sense in the future */

Good idea.  I'll send out a patch.

Thanks,

Alex

>
> regards,
> dan carpenter
>
