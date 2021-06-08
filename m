Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B35CC47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 10:38:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5568561278
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 10:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5568561278
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A31836EB9C;
	Tue,  8 Jun 2021 10:38:49 +0000 (UTC)
Received: from fanzine.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1512989FC3;
 Tue,  8 Jun 2021 10:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID;
 bh=sTScXVap1smEciCCWRVPGYalA2ax7y/w+lgkVVTYKF4=; 
 b=lW6hHNIF3DHzaUnMn8hTq2HDxjatBeIdd0x/4sYl5uEy9+mISLr+lqd8SdndtP3QLE/wS7807N+wg5Kq4o3+0XiS/pY7rmFNzlieuR48N5/W39rZYzcAcYCLjrYNfoLoVGX0rMyWRhXHZYTeFbJ6wfe2MMic20kGyweYLL7c4eDuP5+anewvTkpDkSFj+qMTOZASMA6fbRMH3+TQ9Eqt/YGWf3awlqfNPLVThy96DsMTmwkuhRBQJshlyl6GP1rX6YhGnPwYHLJNv4ymNJ3MAoAugVBCuCeDRyA+4AE7pP+qFy/gIZs50puOpUacLXAmQ7R/sWqRZiKZlb/XZb5vRw==;
Received: from 106.red-79-157-245.dynamicip.rima-tde.net ([79.157.245.106]
 helo=[192.168.2.252]) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1lqZ88-0002m9-TN; Tue, 08 Jun 2021 12:38:44 +0200
Message-ID: <380e8cb0f18c6f4b21c20b382668316b8962159a.camel@igalia.com>
Subject: Re: [Mesa-dev] XDC 2021: Registration & Call for Proposals now open!
From: Samuel Iglesias =?ISO-8859-1?Q?Gons=E1lvez?= <siglesias@igalia.com>
To: "Szwichtenberg, Radoslaw" <radoslaw.szwichtenberg@intel.com>, 
 "events@lists.x.org"
 <events@lists.x.org>, "xorg-devel@lists.freedesktop.org"
 <xorg-devel@lists.freedesktop.org>, "wayland-devel@lists.freedesktop.org"
 <wayland-devel@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "mesa-dev@lists.freedesktop.org"
 <mesa-dev@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "etnaviv@lists.freedesktop.org"
 <etnaviv@lists.freedesktop.org>, "freedreno@lists.freedesktop.org"
 <freedreno@lists.freedesktop.org>, "nouveau@lists.freedesktop.org"
 <nouveau@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
Date: Tue, 08 Jun 2021 12:38:34 +0200
In-Reply-To: <790BA4EE-E3F0-40B9-BE18-3646492F1CAE@intel.com>
References: <790BA4EE-E3F0-40B9-BE18-3646492F1CAE@intel.com>
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
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
Cc: "board@foundation.x.org" <board@foundation.x.org>
Content-Type: multipart/mixed; boundary="===============0038999226=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--===============0038999226==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-0Q47J+K4gENg3/THmwP5"


--=-0Q47J+K4gENg3/THmwP5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kind reminder. Deadline is Sunday, 4 July 2021 :-)

Sam

On Thu, 2021-05-20 at 10:01 +0000, Szwichtenberg, Radoslaw wrote:
> Hello!
> =C2=A0
> Registration & Call for Proposals are now open for XDC 2021, which
> will
> take place on September 15-17, 2021. This year we will repeat as
> virtual event.
> =C2=A0
> https://indico.freedesktop.org/event/1/
> =C2=A0
> As usual, the conference is free of charge and open to the general
> public. If you plan on attending, please make sure to register as
> early
> as possible!
> =C2=A0
> In order to register as attendee, you will therefore need to register
> via the XDC website. As XDC moved to a new Indico infrastructure, if
> you previously registered on the XDC website, you need to create a
> new
> account again.
> =C2=A0
> https://indico.freedesktop.org/event/1/registrations/1/
> =C2=A0
> In addition to registration, the CfP is now open for talks, workshops
> and demos at XDC 2021. While any serious proposal will be gratefully
> considered, topics of interest to X.Org and freedesktop.org
> developers
> are encouraged. The program focus is on new development, ongoing
> challenges and anything else that will spark discussions among
> attendees in the hallway track.
> =C2=A0
> We are open to talks across all layers of the graphics stack, from
> the
> kernel to desktop environments / graphical applications and about how
> to make things better for the developers who build them. Head to the
> CfP page to learn more:=C2=A0
> =C2=A0
> https://indico.freedesktop.org/event/1/abstracts/
> =C2=A0
> The deadline for submissions is Sunday, 4 July 2021.
> =C2=A0
> Last year we modified our Reimbursement Policy to accept speaker
> expenses for X.Org virtual events like XDC 2021. Check it out here:
> =C2=A0
> https://www.x.org/wiki/XorgFoundation/Policies/Reimbursement/
> =C2=A0
> If you have any questions, please send me an email to
> radoslaw.szwichtenberg@intel.com,=C2=A0=C2=A0adding on CC the X.org board
> (board
> at foundation.x.org).
> =C2=A0
> And don't forget, you can follow us on Twitter for all the latest
> updates and to stay connected:
> =C2=A0
> =C2=A0
> https://twitter.com/XOrgDevConf
> =C2=A0
> Best,
> =C2=A0
> Radek
> =C2=A0
> P.S: a DNS redirection (xdc2021.x.org) is work in progress. Please
> use
> the mentioned links for the moment.
> =C2=A0
> =C2=A0
> Rados=C5=82aw Szwichtenberg
> -------------------------------------------------
> Intel Technology Poland sp. z o.o.
> ul. Slowackiego 173, 80-298 Gdansk
> KRS 101882 - NIP 957-07-52-316
> =C2=A0
> _______________________________________________
> mesa-dev mailing list
> mesa-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/mesa-dev


--=-0Q47J+K4gENg3/THmwP5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEQP+ZAvaXWkfuKXiEf/S6MvF9w0MFAmC/SKoACgkQf/S6MvF9
w0P3tRAAjmk0pVTC5YtEm9h3e3HeepckAKQV5XGEPqqtHtxmHZWzgqX/UoewWeOJ
TgERDD6aPxl3mmzk0/ZO/+7H2VFE73UVNJm6+zo5iaE43rwbhpGi6lX6wFNDUygL
/J9/AR/XeShuIc110rzAfubCIGFxIhY+WlybNEKGYxbf3uqodK51Zi6P2mg8dhFm
Vi4ttVAwLV222pmUipnv8jRSuBYSG6tcML5xZwLsa4qxVbtz8x3sLCKqm+pIpwTi
VcdCP5faZYqImM1g916D+4cOe3kmUqmJwRv5pQEqDMxZ/A0zwCls7NtpBEaAn+fT
pH6RHvovP1pnOLPB7Z3mZIoHJPB+SgGDDmlSop3dhUbJ0eb+Vlu/Gg1VCOkOEPUt
KyvFlcTfG8L8fzaDlS0Si0i4sQ5aY6jdlhI5TsESd9yslSDf/WNtZmld/mTZtkpq
DHS2KfzXoL7pKb6WIQPxeNKy9tmbSnghjUQEaWClOy/n9roI54y7SpGtPiifClWe
7/GvC09oqG2JpQBREncN7cnJ25pU4Fwx3TwbozsZVPWDIcMVqbOBADdFdmzo4Zbs
x2VpffVEH+cDlCWmqbbW5ut/NGYwCPf+e9Maiu/5KLgjjBJDpA1qT3J/4ss50Lds
JXamMrMdZGAT4wats6V1uC+bBPcnMoU17jqHo3Mf9HROHfFjQ0Y=
=grJo
-----END PGP SIGNATURE-----

--=-0Q47J+K4gENg3/THmwP5--


--===============0038999226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0038999226==--

