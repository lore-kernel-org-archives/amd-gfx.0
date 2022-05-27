Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A1FC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 May 2022 12:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7E5710FA6D;
	Fri, 27 May 2022 12:58:07 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A986F10F4D7
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 May 2022 12:45:00 +0000 (UTC)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 49B8B1F8B5;
 Fri, 27 May 2022 12:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653655499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QMQDKMfjpYWyX/3tRv8LDken8BHXTV2zfOpRzWIV52Y=;
 b=IXRZ6IGoJf33MOln5QqVx5cN8lQJT/0fWn4MZxPy+t2c/VShnug1m/OUh4AJNVoZis5aJ3
 49nxlDp0Zb4ZWpuYrS2qa7kkv2Qly8tXb2kmGEYOO62+3wn8Q1psZCjqvotK3vbCLwoK+g
 42+UjLaHQ94Lw7nUDzU6nnJ25LGfQMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653655499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QMQDKMfjpYWyX/3tRv8LDken8BHXTV2zfOpRzWIV52Y=;
 b=AO4L36mbm6K7KBiFaSrzGtuGLvBcPwFdcIByA1J+zw7aYS0ZysjwyAqUvBIox7kYqh50XH
 /+sId8s6V0/tkMCw==
Received: from lion.mk-sys.cz (unknown [10.100.200.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3F99B2C142;
 Fri, 27 May 2022 12:44:59 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
 id 13615608E0; Fri, 27 May 2022 14:44:59 +0200 (CEST)
Date: Fri, 27 May 2022 14:44:59 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: amd-gfx@lists.freedesktop.org
Subject: (REGRESSION bisected) Re: amdgpu errors (VM fault / GPU fault
 detected) with 5.19 merge window snapshots
Message-ID: <20220527124459.mfo4tjdsjohamsvy@lion.mk-sys.cz>
References: <20220527090039.pdrazo5e6mwgo3d3@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="avjog5ybobv7z5zu"
Content-Disposition: inline
In-Reply-To: <20220527090039.pdrazo5e6mwgo3d3@lion.mk-sys.cz>
X-Mailman-Approved-At: Fri, 27 May 2022 12:58:06 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--avjog5ybobv7z5zu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 27, 2022 at 11:00:39AM +0200, Michal Kubecek wrote:
> Hello,
>=20
> while testing 5.19 merge window snapshots (commits babf0bb978e3 and
> 7e284070abe5), I keep getting errors like below. I have not seen them
> with 5.18 final or older.
>=20
> ------------------------------------------------------------------------
> [  247.150333] gmc_v8_0_process_interrupt: 46 callbacks suppressed
> [  247.150336] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x000=
20802 for process firefox pid 6101 thread firefox:cs0 pid 6116
> [  247.150339] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAUL=
T_ADDR   0x00107800
> [  247.150340] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAUL=
T_STATUS 0x0D008002
> [  247.150341] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 6, pasid=
 32780) at page 1079296, write from 'TC2' (0x54433200) (8)
[...]
> [  249.925909] amdgpu 0000:0c:00.0: amdgpu: IH ring buffer overflow (0x00=
0844C0, 0x00004A00, 0x000044D0)
> [  250.434986] [drm] Fence fallback timer expired on ring sdma0
> [  466.621568] gmc_v8_0_process_interrupt: 122 callbacks suppressed
[...]
> ------------------------------------------------------------------------
>=20
> There does not seem to be any apparent immediate problem with graphics
> but when running commit babf0bb978e3, there seemed to be a noticeable
> lag in some operations, e.g. when moving a window or repainting large
> part of the terminal window in konsole (no idea if it's related).
>=20
> My GPU is Radeon Pro WX 2100 (1002:6995). What other information should
> I collect to help debugging the issue?

Bisected to commit 5255e146c99a ("drm/amdgpu: rework TLB flushing").
There seem to be later commits depending on it so I did not test
a revert on top of current mainline.

I should also mention that most commits tested as "bad" during the
bisect did behave much worse than current mainline (errors starting as
early as with sddm, visibly damaged screen content, sometimes even
crashes). But all of them issued messages similar to those above into
kernel log.

Michal Kubecek

--avjog5ybobv7z5zu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmKQx8UACgkQ538sG/LR
dpXbnQf9EBOUK6JjIxFbeBAUHln7TMl1+8wR5V/hqAlspjjaTXfZjPm86Q2tMHqB
Isx5zZ8ax5B5pB+4jqQwSZmqkPBd6n8uXPxkjJ56/WnFKTs1Eh+oeFAwyxrJPb0I
z+6M5JPCOG5kaaewzkjYom66vJcDTq2PCghR13GwAwd8xTUAXFfx3EODbUP8YZvS
AmGSKIUsh7r2A+DFvQ790SjWfHsjX2f4I7YWhx1V6uzj00wHhAp7rxEOJVeKD56r
3ToX438mMPD3GH25wVUijnVazjqG3IQcao1TJ8/Ll9i8r4HBgMaS227YDnpSHoqW
M2ClzFJBd95wkrazHyuwXAkjzQIrCA==
=kLOY
-----END PGP SIGNATURE-----

--avjog5ybobv7z5zu--
