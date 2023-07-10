Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7808CEB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 14:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95D2510E249;
	Mon, 10 Jul 2023 14:11:07 +0000 (UTC)
X-Greylist: delayed 366 seconds by postgrey-1.36 at gabe;
 Mon, 10 Jul 2023 13:49:04 UTC
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de
 [130.133.4.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F042A10E0EF;
 Mon, 10 Jul 2023 13:49:04 +0000 (UTC)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
 by outpost.zedat.fu-berlin.de (Exim 4.95) with esmtps (TLS1.3)
 tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1qIrA9-000zai-Vg; Mon, 10 Jul 2023 15:42:50 +0200
Received: from p57bd95f7.dip0.t-ipconnect.de ([87.189.149.247]
 helo=[192.168.178.81]) by inpost2.zedat.fu-berlin.de (Exim 4.95)
 with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@physik.fu-berlin.de>)
 id 1qIrA9-001iVF-NK; Mon, 10 Jul 2023 15:42:49 +0200
Message-ID: <0a47ed93fe90a77180533f8c2e42e402827e8f1c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 08/17] arch/sh: Do not assign FBINFO_FLAG_DEFAULT to
 fb_videomode.flag
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de, javierm@redhat.com
Date: Mon, 10 Jul 2023 15:42:48 +0200
In-Reply-To: <20230710130113.14563-9-tzimmermann@suse.de>
References: <20230710130113.14563-1-tzimmermann@suse.de>
 <20230710130113.14563-9-tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.149.247
X-ZEDAT-Hint: PO
X-Mailman-Approved-At: Mon, 10 Jul 2023 14:11:03 +0000
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
Cc: linux-fbdev@vger.kernel.org, Rich Felker <dalias@libc.org>,
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-geode@lists.infradead.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-nvidia@lists.surfsouth.com,
 linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Thomas!

On Mon, 2023-07-10 at 14:50 +0200, Thomas Zimmermann wrote:
> FBINFO_FLAG_DEFAULT is a flag for a framebuffer in struct fb_info.
> Flags for videomodes are prefixed with FB_MODE_. FBINFO_FLAG_DEFAULT
> is 0 and the static declaration already clears the memory area of
> sh7763fb_videomode. So remove the assignment.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> ---
>  arch/sh/boards/mach-sh7763rdp/setup.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/sh/boards/mach-sh7763rdp/setup.c b/arch/sh/boards/mach-=
sh7763rdp/setup.c
> index 97e715e4e9b3..345f2b76c85a 100644
> --- a/arch/sh/boards/mach-sh7763rdp/setup.c
> +++ b/arch/sh/boards/mach-sh7763rdp/setup.c
> @@ -119,7 +119,6 @@ static struct fb_videomode sh7763fb_videomode =3D {
>  	.vsync_len =3D 1,
>  	.sync =3D 0,
>  	.vmode =3D FB_VMODE_NONINTERLACED,
> -	.flag =3D FBINFO_FLAG_DEFAULT,
>  };
> =20
>  static struct sh7760fb_platdata sh7763fb_def_pdata =3D {

I would argue that the current code is more readable that your proposed cha=
nge.

I agree that it's a no-op, but code is not just about functionality but als=
o
readability, isn't it?

Also, I prefer "sh:" as the architecture prefix, not "arch/sh:".

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
