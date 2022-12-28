Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BFFC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Dec 2022 22:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A13C10E237;
	Wed, 28 Dec 2022 22:47:22 +0000 (UTC)
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch
 [185.70.41.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94EF610E383
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Dec 2022 08:28:01 +0000 (UTC)
Date: Wed, 28 Dec 2022 08:27:50 +0000
Authentication-Results: mail-41103.protonmail.ch;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.b="RL82hTzW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1672216073; x=1672475273;
 bh=+uicGGm0rVG9mzz/n12xPS2vmSjzqNkzmFdxb9rQ2LI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=RL82hTzWGuigd1S5CdU1vgaxGRQpSGB2L5NKWl4+YVucFrYYsHpePNBv/Iv/fLAz3
 sMBZ9APhZk/d+caMYHJWJP/x5uSQyoeHFEU/IJPZ/eVvZoelHRtq8qXheIjOY+Qrzg
 yfKErvo4FSpHSmNYvev7p0TZfH6vemnYx1zNTtXJ8ECH7QzXg51gIDIgogew1pnIxj
 Bs9BogVEuwJIWv7gjWTDr0GaGnghAQo22egSPFuPPrPgGWMyZTBEzPbZ193rcVr/Ru
 DTvbzMvXTbh5kQ4WIgY76GehyUulgEXN9K4XTxKLeTpjry7LKZTd3UVbl0ZQO1ASrh
 62Djuueaq7Smg==
To: Aditya Garg <gargaditya08@live.com>
From: Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [BUG] AMD Radeon Pro 5600M with 8GB of HBM2 memory shows blank
 screen on Linux
Message-ID: <20221228192740.1ec44a3d@localhost>
In-Reply-To: <3AFB9142-2BD0-46F9-AEA9-C9C5D13E68E6@live.com>
References: <3AFB9142-2BD0-46F9-AEA9-C9C5D13E68E6@live.com>
Feedback-ID: 28131841:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 28 Dec 2022 22:47:20 +0000
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
Cc: "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
 "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
 "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "harry.wentland@amd.com" <harry.wentland@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, 26 Dec 2022 21:44:06 +1100
"Aditya Garg" <gargaditya08@live.com> wrote:

> The AMD Radeon Pro 5600M with 8GB of HBM2 memory GPU is found in
> MacBook Pro 16 inch, 2019 (MacBookPro16,4).
>=20
> The GPU fails to work on Linux, thus a blank black screen gets
> displayed on boot.
>=20
> If nomodeset is added as a kernel parameter, we are able to access
> Linux easily.
>=20
> The link below contains the journalctl of the failed boot :-
> https://gist.github.com/AdityaGarg8/dfe1a1c23bf2b92b640dad89f55b73c7
>=20
> Thanks
> Aditya

I'm not sure if it was an unrelated issue, but on older versions
including 5.17.1, psp_v11_0_bootloader_load_sysdrv would timeout and
return -ETIME. I'm not sure when it started having Mode Validation
Warnings instead, but these errors are what it previously had:

[    5.136077] [drm:psp_hw_start [amdgpu]] *ERROR* PSP load sys drv failed!
[    5.136233] [drm:psp_hw_init [amdgpu]] *ERROR* PSP firmware loading fail=
ed
[    5.136351] [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR* hw_init of I=
P block <psp> failed -22
[    5.136458] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_init failed
[    5.136477] amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init
[    5.136540] amdgpu 0000:03:00.0: amdgpu: amdgpu: finishing device.
[    5.137815] amdgpu: probe of 0000:03:00.0 failed with error -22

The patch used to test this and the kernel log I received from someone
using that patch are on this page:
https://gist.github.com/Redecorating/645a62eec4fb06e03f384396f483fa37


