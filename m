Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B72C43470
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA5C61184
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA5C61184
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A67C26F465;
	Thu, 20 May 2021 12:49:16 +0000 (UTC)
Received: from fanzine.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB3336F3D0;
 Thu, 20 May 2021 10:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=MIME-Version:Content-Type:Date:Cc:To:From:Subject:Message-ID;
 bh=O0iHU1/VHHkhwP5qU6e9vxiPh+rZbb09bmx0z3cBJBM=; 
 b=MZHsc4N7/ulLQv+eCIGld70Dcd+eH43dyLA3991v9K8vS2m7FU8eTIYL+pVcAfYxEITRbN7NURNhh16NVzhur8aiauQt36RlismSe0GPrOVtdeIKT2RSkCT8W6aU/Immau56snwHmTLVXIsnWOtNw6U1XwE7uztIWk+Us2XROTFYPYrgc9fNj356yJq/X4W/KxFwYRAzVd2yMc/7uWJSSFdSFMdlvyu4LzeDHD1FknUleiHsRJWxTUvzDdc1ALDULB+dZ6ou4cq8tkVLU9mHhKG9xyvsfjr3Xu76y6D1p/Pfc9/nXR6niH6PtW7+whzutlgUBPEpDJIG/cEyaLnuMg==;
Received: from 216.pool85-49-174.dynamic.orange.es ([85.49.174.216]
 helo=[192.168.1.117]) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1ljfiI-0004cl-RM; Thu, 20 May 2021 12:15:34 +0200
Message-ID: <95ec2c414f7dd1ea5685184435b95430e1709047.camel@igalia.com>
Subject: Requests For Proposals for hosting XDC 2022 are now open
From: Samuel Iglesias =?ISO-8859-1?Q?Gons=E1lvez?= <siglesias@igalia.com>
To: "events@lists.x.org" <events@lists.x.org>, 
 "xorg-devel@lists.freedesktop.org"
 <xorg-devel@lists.freedesktop.org>, wayland-devel@lists.freedesktop.org, 
 wayland-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, mesa-dev@lists.freedesktop.org, 
 mesa-dev@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, etnaviv@lists.freedesktop.org, 
 etnaviv@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org
Date: Thu, 20 May 2021 12:15:23 +0200
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 20 May 2021 12:49:10 +0000
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
Cc: "board@foundation.x.org" <board@foundation.x.org>
Content-Type: multipart/mixed; boundary="===============0809746576=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--===============0809746576==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-PlIrzc/n3c7pGzJvSGeE"


--=-PlIrzc/n3c7pGzJvSGeE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone!

The X.org board is soliciting proposals to host XDC in 2022. Since
XDC 2021 is being held in Europe this year (although virtually), we've
decided to host in North America. However, the board is open to other
locations, especially if there's an interesting co-location with
another conference.

Of course though, due to the ongoing COVID-19 pandemic it's not yet
clear whether or not it will be possible to host XDC 2022 in person,
although is seems very likely. Because of this, we would like to
make it clear that sponsors should prepare for both the possibility
of an in person conference, and the possibility of a virtual
conference. We will work with organizers on coming up with a
deadline for deciding whether or not we'll be going virtual, likely
sometime around July 2022.

If you're considering hosting XDC, we've assembled a wiki page with
what's generally expected and needed:

https://www.x.org/wiki/Events/RFP/

When submitting your proposal, please make sure to include at least the
key information about the potential location in question, possible
dates along with estimated costs. Proposals can be submitted to board
at foundation.x.org until the deadline of *September 1st, 2021*.=C2=A0

Additionally, an quirk early heads-up to the board if you're
considering hosting would be appreciated, in case we need to adjust the
schedule a bit. Also, earlier is better since there generally will be a
bit of Q&A with organizers.

And if you just have some questions about what organizing XDC entails,
please feel free to chat with previous organizers, or someone from the
board.

Thanks,

Sam


--=-PlIrzc/n3c7pGzJvSGeE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEQP+ZAvaXWkfuKXiEf/S6MvF9w0MFAmCmNrsACgkQf/S6MvF9
w0NsSxAA1ui8Yz9mLl9sknE/Lu1eOzz/P0B7tgPy4hLe4cj6SbCCU37S9d+RJ0/h
iAoZDzP5yxEneqT0nIA5LYzvUjOxcl6POaC5nxqYagrtOOKi4H0Gd4U03LjIqtpy
Fuc6J4z1eePoXORAPP/vlQbUojPG085P/NW77biDPBYL+3pTpWdIxdQV9zFv+CzY
HDJwupFJJHtwVaGiArV1sJn6Ls/hzgD/JhAGpGF12k6/31IjlS+k8BOAFod4sIeq
F3KqIYWa6LQtgrhvcSpLXLMf27v5A/gPCtpw5ikga3NKIo2lZY5wwNCGTAH6DJ4q
ILf/OFYDt7RmgQ9o3y/bMHiFtQdmoC5RzpGTSsVTezeAAyIPskc00wgfyvmItJYK
v5eziT91D5uLqDeglhwC39HU+v2ABa11TeADqifsu4WPTPTPKVe66shB2uP/cx5s
o2LIVt8JflpyB++CQ6DBxcz+7yVqC8OLVfNK4MbMkGtbTgzuNtcisf0zP/dVZEh8
4Sj//vhVfDId92Sp0yyhiOEwWmAO+HAwh2/qsd+7/JbHU0HGrHwqarUM5LNhyDqJ
ZXd0FnEpXQvNK3AYOGBJcU9gPjuXmjGlDS3k4pHhvrsb198xIp1t/lBBsV0vyEaz
gNSmH8Dx+VbGstCm3/VE6uZhHFYXn6FMvT5qIr8BN3LGQuGz5Yc=
=JocE
-----END PGP SIGNATURE-----

--=-PlIrzc/n3c7pGzJvSGeE--


--===============0809746576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0809746576==--

