Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A3DCCF9E4
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 16:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E7A910E843;
	Wed, 25 Sep 2024 16:11:16 +0000 (UTC)
Received: from mail.bix.bg (mail.bix.bg [193.105.196.21])
 by gabe.freedesktop.org (Postfix) with SMTP id 42ABA10E843
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 16:11:14 +0000 (UTC)
Received: (qmail 20389 invoked from network); 25 Sep 2024 16:11:13 -0000
Received: from d2.declera.com (212.116.131.122)
 by indigo.declera.com with SMTP; 25 Sep 2024 16:11:13 -0000
Message-ID: <bf7ba9cccd695c66cc2b2b4ac8728c7f8ad0a24b.camel@declera.com>
Subject: Re: 6.12-rc0/regression/bisected - 9c081c11c621 drm/amdgpu: Reorder
 to read EFI exported ROM first - breaks connector enumeration and discovery
From: Yanko Kaneti <yaneti@declera.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Date: Wed, 25 Sep 2024 19:11:13 +0300
In-Reply-To: <CADnq5_NxDVkLN3ywXNUCdpOX4EZ23Vc=YHMP=uXaJmXkFjjLFA@mail.gmail.com>
References: <20240812044942.1670218-1-lijo.lazar@amd.com>
 <9c91d15357e30fb41af9f54fe85da5bb7d0d79a3.camel@declera.com>
 <CADnq5_NxDVkLN3ywXNUCdpOX4EZ23Vc=YHMP=uXaJmXkFjjLFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 (3.54.0-1.fc42) 
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 2024-09-25 at 11:53 -0400, Alex Deucher wrote:
> On Wed, Sep 25, 2024 at 11:46=E2=80=AFAM Yanko Kaneti <yaneti@declera.com=
> wrote:
> >=20
> > Hello,
> >=20
> > This commit in mainline (9c081c11c621) breaks connector enumeration and
> > discovery for me here so my  PC->HDMI-to-DP->monitor stops showing
> > anything after amdgpu starts.   Fedora rawhide 6.12 pre rc0 kernels.
>=20
> Fixed in this commit:
> https://gitlab.freedesktop.org/agd5f/linux/-/commit/375b035f689735fd7a87f=
f31ccac3a42717252bf
> Which is already in my pending PR from last week.

Ahh, sorry, should have dug deeper.

Tested the whole drm-fixes-6.12 PR on top of linus tip and it works fine
here.

Thanks
- Yanko
