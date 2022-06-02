Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272C1C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 14:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEF92112E5C;
	Thu,  2 Jun 2022 14:25:11 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4BEB112E50
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 14:25:09 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id y144so1606051oia.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jun 2022 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XY4Ex8tPNSZJtfNWP8w9y7RN15sCbOEiAJmWuQuEHOI=;
 b=ESskSfAcQdzR8x8+xWNoii8k4hBBU28GAsMLaQ7dDxitmVaVuZyx28sZeOxcT1O1cA
 inVTNTA0GYmbqR4FAEZNX9k9ceVEnH2KuLYqdccBzf5LGkw5XeHKotzyo3fW8gP+7Vsz
 NmJPTjhjkzjOEFtm8ApYIppujhvFoJ/ZPMNbUpZ08xmQ+ncdH+Ie51qNa48kexQ99vmn
 2r4HK6YMep/YzZUsDnzjO8q92Q67URxkT83SNZVFZfvrEr0NhX+JmUKqYQzRZZD5jGPl
 bFXbTZ/q0GPbuwvjVAMlzk/eOl0haO7BUJf/bj3vAWB1/c/a77eCe2oSz2PKQudbCln3
 cDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XY4Ex8tPNSZJtfNWP8w9y7RN15sCbOEiAJmWuQuEHOI=;
 b=ABoYrul8cjtJcrCOOuRdPufLWRpU3lo43aD5ewlAxxRaPuX3x/j7ox68pP0gnI52IF
 qv20gmbriSNM9w3z57REjeOYuSQG8vFqbARYCvX/dwA9iIQfymY7tphbtleE43H+Ie1r
 Gqjw6UBPNVtdTCSV3nXrZdSRMiE2crwOSQlOIcO/OeB/IRiu+oV3+/Q85t/xq49mN59H
 O+ySesigw2WDqELlT9/TcWB5aJT/5q3P1ZT+941RFg1nvh2e3bwFI/pvNx/nPZ9naOYi
 vQVSGU9zgXn2SxcaZovEuLWHME9xjlScL28TnqbG2eaa2iMx9rcZvcmCVixPW/0OpYdR
 1w6w==
X-Gm-Message-State: AOAM533VZRdV3TEhbPx4BwLZt5pvk/gF5GYmvOxFpt5FuORk3PTuAy8q
 h+vW6eVxw2Qxo8f2TFFw6sC7njhmgtU7uVzYY4s=
X-Google-Smtp-Source: ABdhPJy6qp7ipfBqm83jbBCNmetqux7FBYGMzFOvbQArmVHPU6fwOQfBNyCShnMgPWh1DzfM+QrjU1xDg97j/VKTa8Q=
X-Received: by 2002:a05:6808:114f:b0:32b:1be0:2316 with SMTP id
 u15-20020a056808114f00b0032b1be02316mr17523141oiu.200.1654179909035; Thu, 02
 Jun 2022 07:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <202205271546.oV14N2r8-lkp@intel.com>
 <CADnq5_NOkqRsoqELkLayNU+xArXd-4RO=_banvJpXHtSW4-YdA@mail.gmail.com>
 <CAD=4a=WRbp8w4DA2c6hE7W5A2-woRyHLvtC-GPitFwQireCeNw@mail.gmail.com>
 <20220602115046.GH2168@kadam>
In-Reply-To: <20220602115046.GH2168@kadam>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 Jun 2022 10:24:58 -0400
Message-ID: <CADnq5_PZBV0wAnNSLSdTc_8acaK3F6ZKDpcgwktmNaR9DKxG9Q@mail.gmail.com>
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

On Thu, Jun 2, 2022 at 7:51 AM Dan Carpenter <dan.carpenter@oracle.com> wro=
te:
>
> On Thu, Jun 02, 2022 at 08:26:03AM +0200, Ernst Sj=C3=B6strand wrote:
> > Dan: I also ran Smatch which resulted in the following discussion:
> >
> > https://lists.freedesktop.org/archives/amd-gfx/2022-May/079228.html
>
> Since the bounds check is dead code which does not make sense and is not
> required, another idea would be to just delete it.

It wouldn't be dead code if AMDGPU_MAX_VCN_INSTANCES ever increased.

Alex

>
> regards,
> dan carpenter
>
