Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F2AC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Jan 2022 15:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73CFE10E52A;
	Sat, 15 Jan 2022 15:00:23 +0000 (UTC)
X-Greylist: delayed 460 seconds by postgrey-1.36 at gabe;
 Sat, 15 Jan 2022 01:23:32 UTC
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE1E10E374
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Jan 2022 01:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1642209810;
 bh=cn54tKiMviARuDA/iEwqQwoysukPyU+CXBA2eg3HqnU=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=M/LXS51MhIxDG5OnMXZ+2Nro2UgY/iuqQZkX+R3qotwPdo7HhWukVzgpplCXgntjq
 tyA/BC/onJ7LKY90OWAX1xPlrvNV/lTW6TdkA9LLqm+0yUOcxYhQA41cu9sc6CKR80
 qRHWpVLCJ4iQ63B352E7K84pYRZlJ9NKFkTgudXY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.0.101] ([88.152.98.65]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTvw0-1mhh552CgM-00R4P5; Sat, 15
 Jan 2022 02:10:37 +0100
Message-ID: <bab0216094b710159132b4b1b72887cceaf2fbd3.camel@web.de>
Subject: Re: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
 DCN20/DCN21
From: Bert Karwatzki <spasswolf@web.de>
To: amd-gfx@lists.freedesktop.org
Date: Sat, 15 Jan 2022 02:10:36 +0100
In-Reply-To: <BL1PR12MB51570343D08806D7EC08D6FDE2529@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <c0ac94855d1119e398c5607263d06c750249300f.camel@web.de>
 <BL1PR12MB51570343D08806D7EC08D6FDE2529@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F1b829zFNGdIMl3kWg8mHw7OCQAfNtvnu9ScgG/c9E0EU4fSTT1
 bAtPaL8kD6YErkxP3LOxJtaR5jCZ1918jAZ3vt9mwcxPzfgUcy+tNJIypiN0dwBdvNGviDl
 CoOWfjIUYGwuK0m/V3mEtIQ8z85rITthw0baO28HKK6+zCzpiNKoUb8J2lW6JFq07Xlx7IJ
 eLc3YhWvOSupzVJ3HuPCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8tHlz45gMl4=:ndbcVvUMGK2RWha9HQK2BL
 xsuKBDbuCjKKH3Unfbhi161ZmVE4KzeSAPPXCnts9ETUevcWaSJT+u416kmvuEAx7AeEZkVMQ
 35SfLv85UPevJx+myEGeTudIkDUCddtGaIEI30LaajOTsv3TH19cHbTpLxdRU/o6xrq1Mo4Nj
 nrnU2Z0Dl2vsZ6R2sQF/gx+T009J0/JA2V7a4gcYzaKuLmGetKzOZ1R7O1Ln3CXRw25hzCmL1
 ly00urxAYLeEaM19/p1HqwYAak5NKlTmm3DOOSPewzUM0zVQQKNWq2xItsT6jzBg9mqFDb4YP
 06Jjjd2Sig2XTJ2KC/ipLgianNwgnEgDkDl9Koh3yBFI0YX+kuQ1GScnLz3iwdmQLYJOK5Rxt
 IONoA6fgTJg+repBrxofxtWi6iY9Pln3vgJFOsGnzjXPEl/ogXWMjIlDlSMEPASWXdoOYVrhX
 MK/UFWNeB+MCsstynPa0IEJ4LLjabS3UmZ9tqMIuTcrKHUbL02NQpxC6fnuXk7gKMssm2MX+N
 bIDziDrOueZhP9FepkmRFaX2rdSBrtZROFouXh6a7VEYx+slUV2FrggK4OAFwDVRXMT+75Mmo
 GpTwkiAFApHyfAJOEbyghyJtEClNQPhRzoQIiQn1l/Fy4DYLRjrHI1cHch0kkxoWGAz9BSfjD
 tApCzGAohQroNfh/fYDalfbSyNssrcAdBFcwytYS8JY7EhfU2bcCZPO7GjE8TNwrGxJT2dVT6
 7mcmRRwk/xU5Rj4YaINhXXrhfyO9UlMv91nIoqZtCCE8S/cov7SDj1brqZoNpsaQ5kiNh6VH7
 PlKXfo7qU9njxlUVl2oZYFkGlj67VgwK88la8lwRXrPUCMxLLfZfSir0Yc0xsfeOTq3zkb06c
 UYgNDZpoYB8zH66IhI4RUEhHHPh9jkKjiWe+R50249Q/H8rlTq6X9QJPykEWTBCLkP6IdghgN
 L6f5fn8ypK706lo2YETwqRhvjQhvwouwZqFYfj3F8nUUCtzSAPJeV1CLonJiVT9rqR6VbyaOP
 r8BkkH97dYrdF+EXdnis5uckso1VMX7YJZV8b+zmbDK6DX5/LV6U7OtjzvV2B1cEcbiiDMnLi
 y0zAFB4PPS+1oU=
X-Mailman-Approved-At: Sat, 15 Jan 2022 15:00:22 +0000
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
Cc: "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>, ScottBruce <smbruce@gmail.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Chris Hixon <linux-kernel-bugs@hixontech.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am Mittwoch, dem 12.01.2022 um 02:08 +0000 schrieb Limonciello, Mario:
> [AMD Official Use Only]
>
> > -----Original Message-----
> > From: Bert Karwatzki <spasswolf@web.de>
> > Sent: Tuesday, January 11, 2022 19:12
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Kazlauskas,
> > Nicholas
> > <Nicholas.Kazlauskas@amd.com>; Zhuo, Qingqing (Lillian)
> > <Qingqing.Zhuo@amd.com>; Scott Bruce <smbruce@gmail.com>; Chris
> > Hixon
> > <linux-kernel-bugs@hixontech.com>
> > Subject: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
> > DCN20/DCN21
> >
> > I just tested patch v5 applied to amd-staging-drm-next (with HEAD
> > 26c981e27e698c251ef3241f73ac846e66ad7fc3) and suspend and resume
> > work
> > fine. But as amd-staging-drm-next is still based on linux-5.13 I
> > had to
> > replace the mediatek wlan driver by the version from linux-5.16.
>
> FYI it should likely cherry pick to 5.16 too if it's easier to test
> there.
> I was able to cherry-pick to rc8 no problem.
>
> If you can please try any display hotplugging to make sure hotplugs
> don=E2=80=99t
> cause problems for you as well feel comfortable to add a Tested-by
> tag.
>
> Thanks,

Now I was able to get external HDMI displays to work (with gnome and
wayland) and display hotplugging did not cause problems.

Tested-by: Bert Karwatzki <spasswolf@web.de>

