Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0B4C27C44
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 13:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 216BB11BEB8;
	Thu, 30 May 2024 13:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="JWOEY5Fe";
	dkim-atps=neutral
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B62B1135DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 14:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 sang-engineering.com; h=date:from:to:cc:subject:message-id
 :references:mime-version:content-type:in-reply-to; s=k1; bh=wlla
 ugfLH4XOoxwomJKK6MPaqTtVsABW1UD4EEKk+4c=; b=JWOEY5FeWD44RFriaKFC
 Y/mqXRSe3P2VUVAqOZnYS6e541cu40MbqDwXjAH10ViFZ8+8N2fkUDvp2u5R8fTH
 mOHeklMKaUvylxN5MBwvmw58lfi5+uyB96Ob8MwCNTxDYlihvcc2ZMSj0UO2sV2/
 TY6QcNeRPZm8YsA/wMK6SNgTfxN3OpxLRbvUIWpKr/fCb3M2ErnWvMcEba0V5KXv
 6jKZN09LMxmpWrwBVpwfBukjQ491dnuJJobNdngrsKdzLMAsAmxr21QXL86oVXCI
 eILZfrm3aqIBneI1K7VlfYdlZwSU3OfsuCnteWLXxqcjACdSWEdeFrmV2zMESLsa
 8Q==
Received: (qmail 601684 invoked from network); 29 May 2024 16:27:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 29 May 2024 16:27:46 +0200
X-UD-Smtp-Session: l3s3148p1@+AbhjZgZFLNehhYM
Date: Wed, 29 May 2024 16:27:45 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>,
 Evan Quan <quanliangl@hotmail.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] MAINTAINERS: update email for Evan Quan
Message-ID: <fhhtkw24ntbf7ahdtmt67stvuevi2sa7gg6sxyxezrrn3p3nn7@2ryodpxsm5ed>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>,
 Evan Quan <quanliangl@hotmail.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240529114621.11795-2-wsa+renesas@sang-engineering.com>
 <BL1PR12MB51449A1977FA06BACE4FF306F7F22@BL1PR12MB5144.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j2otqm2jcsamjrln"
Content-Disposition: inline
In-Reply-To: <BL1PR12MB51449A1977FA06BACE4FF306F7F22@BL1PR12MB5144.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Thu, 30 May 2024 13:02:22 +0000
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


--j2otqm2jcsamjrln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Evan no longer maintains the SWSMU code, it should be changed to Kenneth and Jun (CCed).

Thanks for the heads up! Kenneth, Jun, will you send a patch or shall I?
If you send one, please add:

Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--j2otqm2jcsamjrln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZXO10ACgkQFA3kzBSg
KbZHlg/9F+2c1F9o7iMtBCsbFoqlmiMCPU1elLljAwccCfdgR+XSvuE7E7E/yRy9
EZhJ8IeaE8WmHWLNKoQkjwpLoCV6RtFeIaL+sHL3sDOwGPrN78zVTDAdbPC/09v3
KsYmxGdftAPxiebSQ30Fqysp9lPt3P8f5BRAP1CFKj4j39p1mK/XiXliErVDgfw1
hTOm/hA1xRa1w/7bxFiHz+kXXxW8K7sznyZUQvJKIisLbfYB4cgIc+VuWtlTlL9F
/cvmmn03BpBHhd5Y5RzhjYBmmjurpxEFMnAUqadpLOSoQdhL4XnCs9d7LwYYNQJV
MG+ccCYUNPZoYPUZ0whEx0booaXdK+o3eMmUvA1AAVnRSMWValopfRfFnnNSpO58
vcrXUVe2yac/pphd86CAfgnL9iFkTsGCfoDfbPTOjBYYS/xXujbWzCLrpJlnSFwY
sxJ7ZSf4iHewBB4ZafRQFQrplZL93l0fdMYou/wCtQU6QGDk2gKAurtuFLzTkJZ7
salS1TNdA1vA9CJi69qQe4nOyR97FVcw10yn+ylBBtlZkYgE3m/fERMhM2Eht9z1
1KGNUP7+heXTY9zd3db9jnhZaoXg+1Xv2H49PIKO2NT3i8yEq96QhkKUgnU72+ub
m+QuzLTAaaQD93S4jwB4iWuBS5cNlXsggG1XMTQ0y4ZTz9mvd20=
=VtWZ
-----END PGP SIGNATURE-----

--j2otqm2jcsamjrln--
