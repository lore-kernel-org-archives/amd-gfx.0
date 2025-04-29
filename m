Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586C1C369DC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 07:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7537410E6ED;
	Wed, 30 Apr 2025 07:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.b="dsdCvVA2";
	dkim-atps=neutral
X-Greylist: delayed 481 seconds by postgrey-1.36 at gabe;
 Tue, 29 Apr 2025 13:16:09 UTC
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2128B10E0A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 13:16:09 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E1BA340E021A; 
 Tue, 29 Apr 2025 13:08:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
 reason="fail (body has been altered)"
 header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id wrGf7WWtCOB6; Tue, 29 Apr 2025 13:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1745932079; bh=UFz6C4O5CnyTyz6Ioj0i9bidH2Ii+o7JdCGRWIRCBcg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dsdCvVA2QiRbyK7Tgf0rPbpAdHNCJi7GVPYiOQzy8uD699rZfmUjFypwrSjfA1cC8
 uzAjyFNSv1JtUUqpr5wG2zzdX9MowPEr7GZ5kY4rTrN634GGtS3kfyCYOYW7S0pm+d
 HtO5S7s92ji7gXqonzzwj93pVCgm3gRo/klC7V+g2iHkGEjNTaiXSzQblRhX1P0gK+
 cmY3ceMPwt+vPfq9pO9+wAmjApqiNEJ+wjWGwZE8vu0htffqvIY/slrRM4F8qtkRVv
 2cIrPTsogY4h/ONhc8VBi6Ho2errJeRtH93j6UHtqGnANtz0iTGpIhknzoNphNfCyE
 vxYtM82/S5cy0LqYzgtrUV9hFEhD5sbWs8gsBuQ0iwAO0hgGk6apAbVQf74AFMeOaK
 RaTFlQYFJuncwkKolWDTqD9go/zMhEUunypuwcvusa0F4d0MyQDXp6c21jlJW94DU8
 iQ05nf2RyzG1wnBclGR4Vf1GUv/91mbtMFI3zZh9LfE6IZYBsDS6Fu6+YaeP70czM8
 IB5eezC6cAjJmqhl4bRhBZAi8OEGfZQwqRH4tTvaDDmtT4QKZrQ2GAUHADjtJH7toG
 ehRplvTGDKxuCYx0ybMdNnTlSsmDI7FghCUD+Khqp+M9FZIQt0chRIt+a4CVsc5A4H
 jbLyzgPZjEguc8x1aHKYy5m8=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF86E40E0173;
 Tue, 29 Apr 2025 13:07:56 +0000 (UTC)
Date: Tue, 29 Apr 2025 15:07:49 +0200
From: Borislav Petkov <bp@alien8.de>
To: amd-gfx@lists.freedesktop.org
Cc: Marcus =?utf-8?Q?R=C3=BCckert?= <amd@nordisch.org>
Subject: Re: Display Port handling errors out when monitor is slow to wake up
Message-ID: <20250429130749.GBaBDPJSol4WXi-G-r@fat_crate.local>
References: <15eca28818c4fad674bb2f33df7b3277563ba56d.camel@nordisch.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15eca28818c4fad674bb2f33df7b3277563ba56d.camel@nordisch.org>
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 30 Apr 2025 07:55:07 +0000
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

+ amdgpu folks.

On Tue, Apr 29, 2025 at 02:51:21PM +0200, Marcus R=C3=BCckert wrote:
> Hardware:=20
> - ASUS ROG Swift OLED PG27AQDP =20
> - XFX Mercury Radeon RX 9070 XT OC Gaming Edition with RGB, 16GB GDDR6,=
 HDMI, 3x DP RX-97TRGBBB9
>=20
> Kernel:
> - kernel-default-6.15~rc4-1.1.g62ec7c7.x86_64 from https://build.opensu=
se.org/project/show/Kernel:HEAD
>=20
> The monitor is really slow on waking up - or even switching mode e.g. w=
hen going from console to wayland with 480Hz.
> When I turn on the monitor before I wake up wayland via keyboard/mouse,=
 no error comes. If I wake up wayland first and then start the monitor:
>=20
> ```
> [Tue Apr 29 13:49:54 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1118: core_link_write_dpcd (DP_DOWNSPREAD_CTRL) =
failed
> [Tue Apr 29 13:49:54 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1123: core_link_write_dpcd (DP_LANE_COUNT_SET) f=
ailed
> [Tue Apr 29 13:49:54 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1151: core_link_write_dpcd (DP_LINK_BW_SET) fail=
ed
> [Tue Apr 29 13:49:55 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1118: core_link_write_dpcd (DP_DOWNSPREAD_CTRL) =
failed
> [Tue Apr 29 13:49:55 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1123: core_link_write_dpcd (DP_LANE_COUNT_SET) f=
ailed
> [Tue Apr 29 13:49:55 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1151: core_link_write_dpcd (DP_LINK_BW_SET) fail=
ed
> [Tue Apr 29 13:49:56 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1118: core_link_write_dpcd (DP_DOWNSPREAD_CTRL) =
failed
> [Tue Apr 29 13:49:56 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1123: core_link_write_dpcd (DP_LANE_COUNT_SET) f=
ailed
> [Tue Apr 29 13:49:56 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1151: core_link_write_dpcd (DP_LINK_BW_SET) fail=
ed
> [Tue Apr 29 13:49:57 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1118: core_link_write_dpcd (DP_DOWNSPREAD_CTRL) =
failed
> [Tue Apr 29 13:49:57 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1123: core_link_write_dpcd (DP_LANE_COUNT_SET) f=
ailed
> [Tue Apr 29 13:49:57 2025] [  T70365] amdgpu 0000:03:00.0: [drm] *ERROR=
* dpcd_set_link_settings:1151: core_link_write_dpcd (DP_LINK_BW_SET) fail=
ed
> [Tue Apr 29 13:49:58 2025] [  T70365] amdgpu 0000:03:00.0: [drm] enabli=
ng link 1 failed: 15
> ```
>=20
> Feel free to ping me if you need more information.
>=20
>    darix
>=20
> ```
> --=20
> Always remember:
>   Never accept the world as it appears to be.
>     Dare to see it for what it could be.
>       The world can always use more heroes.
>=20
>=20
>=20
>=20
> ```
>=20

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
