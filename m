Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A664C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 13:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 190E910FF4F;
	Thu, 13 Jan 2022 13:06:18 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D111510E58C
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 09:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1642065380;
 bh=qxv6PXK0/o4os2OiMTsmtVr+oIPDQxT29QvfSDIowy4=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=VNdcDDtqBK2wUdypDZ6WmRliTYTmxfLtZkDMMGmB8Zj471R5W075fkirg7t5zie4W
 9Zc63MMDgDuS8dhaImsX9B0sLFO9u3UdM0jF7lOuPRJGrbk1nkBKW5BFzEQq5bQyy9
 S1JYVre7mNXPpCbZZhVbXeU9CjkwTc4SvDbMhMo4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.0.101] ([88.152.98.65]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrfou-1mbseG0Bts-00o2S9; Thu, 13
 Jan 2022 10:16:20 +0100
Message-ID: <6352af5fcb1aed2ace25c724ef0fe2b650ebf4ab.camel@web.de>
Subject: Re: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
 DCN20/DCN21
From: Bert Karwatzki <spasswolf@web.de>
To: amd-gfx@lists.freedesktop.org
Date: Thu, 13 Jan 2022 10:16:18 +0100
In-Reply-To: <BL1PR12MB51570343D08806D7EC08D6FDE2529@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <c0ac94855d1119e398c5607263d06c750249300f.camel@web.de>
 <BL1PR12MB51570343D08806D7EC08D6FDE2529@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AlSTviosxMVUnWNMfxr8PrcJapO1vpCbz8fPGIe5IxqhDMXFbEb
 q1XT1zbLv7gwb7Nso1Y2CaNUwQn0CJ91kRvULm5QmevvRDjFCpLdjkJf1ZU1SvfJzdD6YkJ
 8s6/DlC7S8MrTsTi/9v1IWfF4idMl2GYO3K141EuG/Wl+qK2Ru5WFWNKD2isMywDAGqUyNd
 T8giCDu3c9HkBBkYYRsaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B4CKgM0qBro=:kAaSe/cPoTf5UmH8etTt9O
 HMjFMR6uSfjpoKLhmSEh0X+5MSeWVKwx8Pm24afv9U2PPOVgWoqQtT97/qbN2WbuEGKCARrh0
 go+quvZHBODUWtOnigH3U8A5JuSpZyqMN/+JQKLn9Vcu4KS9v2gvFmQzk6rnrkJyUOF8ZsB+9
 Dgdi2H2oKZTKyTyEId+WEhQMAl4f4yXwb+N5K7f18AvLl8hv5vIZOI2LFquqe0yfwejlAKBoF
 wpMjRBNe2AXEXXMb99DtcZa6r6tTYyqJEnsOwwbggPFg8xPKJQcpnpQhU75uxWDzFhteE3M2A
 Vo9Mxjy9+kTJ5qEzZAA1iUfCutDx6LYx9Nm89q1TDr1WcSiCYmwhoWbg1h+RRXcInSVgn+iSb
 D1auYlqK0O0BSWSVW2CGBcImqmchCX0dFmgS3alJ71cc8UdfiNLrUBjXrqytWdGFAKus2GCvZ
 LIoCl4Dr5zCa1CebIOR33n0+HD9pB/7kQ475ENoy1byVVwKAMY+RPFzboh14j8ufVGKX74lji
 XifoJEmtAm+pruE36H3XfZ1uq/ucorK7kayFGO1u5t66N2oCnADhad/kPBtj+sbdod9uRbvpb
 tADy35ZXVOpQK4vtiL9p6XcLB6+ad+bYslMZidyqBTqjxS+HDfbqhp4WrWNqEkpn51QEMwoOi
 iS/ZhOEWDI7G2jHdsAcvYVwQrNF3z/fe7/Xd+KTwGtzRld3YB/EMRdZEQ25itf3+C045KXkmF
 RsS0y5x4nJAvoAtVydxzTXSbYMj9SyJzB5h6KR0jX3LlvFiIzvRsXj2avkL3pJ6OYensMz922
 rhYHfF2k82luoyJrvMG1oOvfUid22+N+DiMw2vJDGyB95RWPTTZ34xC9omSq9Os+KEN+G71nw
 B+p43uup+zPSFp9BG716xp5aH7bYwBKNPwbey6hiGhLuGjXMjReZHS53OiQ0Ffp46UYpQ8Syd
 IBFasmbYyHkH7Z98YjipKfcJWnEnBkcNzcXwdXnkFtb1kjYLNfiOK2YIe4s4OkgOSJOH6/N87
 M8VZ1XppJVX3tEYpM/4iFfgAaQvDz14wJRItA7xE+dNYqO9Ro3+gUq9oHV2U1Gk+B+E7+aRdX
 Z80miqgQImX+jA=
X-Mailman-Approved-At: Thu, 13 Jan 2022 13:06:16 +0000
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

Unfortunately the external HDMI port on my Notebook (Alpha 15 B5EEK/MS-
158L) does not seem to work out-of-the-box. This is a two GPU machine
03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi
23 [Radeon RX 6600/6600 XT/6600M] (rev c3)
08:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Cezanne (rev c5)
 The Desktop Environment (gnome with Xorg) is running on the integrated
Cezanne, but when I connect the external HDMI cable I get a dmesg
resume message from the Navi GPU. So this either requires some
additional configuration effort on my part or this is a story for
another bug report.

