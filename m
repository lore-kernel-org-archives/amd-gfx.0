Return-Path: <SRS0=q6mt=NV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C70AC432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 16:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB4460F4B
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 16:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BAB4460F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=samip.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E64A89B42;
	Mon, 30 Aug 2021 16:25:54 +0000 (UTC)
X-Greylist: delayed 590 seconds by postgrey-1.36 at gabe;
 Mon, 30 Aug 2021 16:25:53 UTC
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83ACC89B42
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Aug 2021 16:25:53 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id AC1A532009A8;
 Mon, 30 Aug 2021 12:16:00 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Mon, 30 Aug 2021 12:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samip.fi; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm1; bh=+8dPI
 MUavF3K1I+eZMILdJSDf0qvSIVs1NRCxmWwQIk=; b=OI1N3FXdCGulBCnzfCJFq
 vF+Gh1ihrT/q6HexhcyuR6c+RC4vge2ceIpDEvY8hUxliHa+moVnfOQxG8TKiCNP
 8jq5fs67kBGtae8NfXSS8OosOxKcVv+yU6RN2fwJrS8P2gbppkqu+jRa+MR8OTSi
 twH2dWiFOz98Ik5kNzUdUepRYa04/VoJi/8PGYkG38/aucnBpbzgf2B9rs2LWLJm
 qelcE3mte/8aw21qAifYFJLQavtHfKlu9eLNvyxHfEHyAcbdJGWtnL31TlIOALXc
 g4eZtPzMjzRXxL+MwEJR/KfO8lFnsPWkqBFEn2HMa0qPvcOzMbUNeEijmMfu1zVP
 Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=+8dPIMUavF3K1I+eZMILdJSDf0qvSIVs1NRCxmWwQ
 Ik=; b=dH0hjmzdm04M7mh045qfMkLmr6dFUqQ+xHgVY58xe/UfSsBqlEbbw5B52
 oMECJpmqZyipErD9qudTWutRM0jQqrWwT5ahnyJ+9zpEVFkZ//1PDywRubXUsOIV
 f+9iYT3oT3FZdkjKKC2pRTNij+c0ssl84onzPPWMoNs2XBWxWS4NTjrmQFPDk3kj
 vCez5MZSZNAorviUsvuR82pLNro9Te//W3/QtnI6m++wPNeGyVyhThjouQuyu6dP
 SE+uo9MMWAHAEc3MKrwKFmASXSUU/lf18Fk4e53MRPs0/yfCR5hghNzqPPK2qWQf
 cttqb8urPnVo+LvXXIXjk0aM2tYeA==
X-ME-Sender: <xms:PwQtYXQx7abLcElndo9hZpdc_Z74KD_GjnjxwJOQJXNdv6GY72I3Qw>
 <xme:PwQtYYxiUqQ7vjUSCpfCU0gLClRV6HcDzIT-sO1sHQMQzyLbIazN7aWm4S8eothXP
 xIWbjjVkYjV9HMv3g4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduledgleelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpefukhih
 lhgvrhgpofomnhhthihsrggrrhhiuceolhhishhtshesshgrmhhiphdrfhhiqeenucggtf
 frrghtthgvrhhnpeefveekheevueelvddutddvgedvleejvdeigeekueehgeelgfeiffet
 ueejudffkeenucffohhmrghinhepfhhrvggvuggvshhkthhophdrohhrghenucevlhhush
 htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhsthhssehsrghm
 ihhprdhfih
X-ME-Proxy: <xmx:PwQtYc0VDjRqsYHUIQEkRp-g9tqothJ4eO-y69Tf1HfJRQ5pmoHCKQ>
 <xmx:PwQtYXDidPUdMG32KJ08ydQ5ycarb_e9sxbMUCefbQ1oUoM4O-e3Nw>
 <xmx:PwQtYQjOuKE1TaWXVSEP-yUO7Q8KfabKcQwKhmLVizMp4RP09gsrcw>
 <xmx:QAQtYTuUvBwzFVv7rI9w61J9nweBX1rPU1acllHDABz033RpEkSyGw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 71161FA0AA4; Mon, 30 Aug 2021 12:15:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1125-g685cec594c-fm-20210825.001-g685cec59
Mime-Version: 1.0
Message-Id: <4d3fd1cb-9b33-4598-b351-54ea455c2a6e@www.fastmail.com>
In-Reply-To: <20210829173448.3cwk4rz6wfxfxdpj@kari-VirtualBox>
References: <4ada1100-fbce-44e4-b69d-0f5196f86bcb@www.fastmail.com>
 <20210829173448.3cwk4rz6wfxfxdpj@kari-VirtualBox>
Date: Mon, 30 Aug 2021 19:15:29 +0300
From: =?UTF-8?Q?Skyler_M=C3=A4ntysaari?= <lists@samip.fi>
To: "Kari Argillander" <kari.argillander@gmail.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: [drm/amdgpu] Driver crashes on 5.13.9 kernel
Content-Type: text/plain;charset=utf-8
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

I have tried kernel 5.13.13, without any difference and I haven't tried =
with an older kernel, as this hardware is that new that I have very litt=
le faith in less than 5.x kernel would even have support for the needed =
GPU.

What do you mean with git bisect? I have checked that the crash happens =
somewhere in the monitor connection code:

[ 9605.269927] Call Trace:
[ 9605.269931]  core_link_enable_stream+0x746/0x870 [amdgpu]
[ 9605.270038]  dce110_apply_ctx_to_hw+0x519/0x560 [amdgpu]
[ 9605.270146]  dc_commit_state+0x2f6/0xa50 [amdgpu]
[ 9605.270249]  amdgpu_dm_atomic_commit_tail+0x569/0x26a0 [amdgpu]
[ 9605.270326]  ? kfree+0xc3/0x460
[ 9605.270329]  ? dcn30_validate_bandwidth+0x11f/0x270 [amdgpu]
[ 9605.270402]  ? dcn30_validate_bandwidth+0x11f/0x270 [amdgpu]
[ 9605.270469]  ? dm_plane_helper_prepare_fb+0x19c/0x250 [amdgpu]
[ 9605.270542]  ? __cond_resched+0x16/0x40
[ 9605.270544]  ? __wait_for_common+0x3b/0x160
[ 9605.270545]  ? __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
[ 9605.270548]  commit_tail+0x94/0x130 [drm_kms_helper]
[ 9605.270557]  drm_atomic_helper_commit+0x113/0x140 [drm_kms_helper]
[ 9605.270562]  drm_atomic_helper_set_config+0x70/0xb0 [drm_kms_helper]
[ 9605.270568]  drm_mode_setcrtc+0x1d3/0x6d0 [drm]
[ 9605.270582]  ? drm_mode_getcrtc+0x180/0x180 [drm]
[ 9605.270590]  drm_ioctl_kernel+0xaa/0xf0 [drm]
[ 9605.270600]  drm_ioctl+0x220/0x3c0 [drm]
[ 9605.270609]  ? drm_mode_getcrtc+0x180/0x180 [drm]
[ 9605.270618]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
[ 9605.270673]  __x64_sys_ioctl+0x83/0xb0
[ 9605.270675]  do_syscall_64+0x40/0xb0
[ 9605.270677]  entry_SYSCALL_64_after_hwframe+0x44/0xae


On Sun, Aug 29, 2021, at 20:34, Kari Argillander wrote:
> On Sun, Aug 29, 2021 at 06:38:39PM +0300, Skyler M=C3=A4ntysaari wrote:
> > Hello everyone on the list,
>=20
> This is universal kernel list and it is not read by many. I have added
> hopefully right list (amd-gfx@lists.freedesktop.org).
>=20
> > Subject: Re: [drm/amdgpu] Driver crashes on 5.13.9 kernel
>=20
> I have no influence or knowledge about this driver, but I still try to
> help because it seems good bug report. Have you test with 5.13.13 or
> 5.14-rc7. Does this work with some other kernel? If needed can you git
> bisect if needed? You will probably get some support for it if needed.
>=20
> Argillander
>=20
> > I thought that this should probably be discussed here,  so I came
> > across weird issue to me which is driver crashing while trying to get
> > one of my monitors working on Gentoo.  I would like to ask here how
> > that would happen that the Display appears to jump from DisplayPort-6
> > (physical port) to DisplayPort-7 (which doesn't exist physically)? H=
as
> > anyone else experienced this?
> >=20
> > It seems that the driver sees a rather large amount of inputs for the
> > GPU, even though I only have 4, 3 of which are DisplayPort, and the
> > issue monitor is also on DisplayPort.=20
> >=20
> > Hardware:
> > CPU: AMD Ryzen 5800X
> > GPU: AMD Radeon RX 6800
> > System Memory: 32GB of DDR4 3200Mhz
> > Display(s): BenQ Zowie XL2430 (1080p), DELL U2414H (1080p), DELL U24=
15 (1920x1200)
> > Type of Diplay Connection: All are connected via Display-Port
> >=20
> > Related DRM issue:
> > https://gitlab.freedesktop.org/drm/amd/-/issues/1621 which includes
> > logs too.
> >=20
> >=20
> > Best regards,
> > Skyler M=C3=A4ntysaari
