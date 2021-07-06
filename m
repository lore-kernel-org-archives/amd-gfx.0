Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B23BC07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 13:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73EDD61A19
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 13:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73EDD61A19
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30C046E483;
	Tue,  6 Jul 2021 13:22:40 +0000 (UTC)
Received: from fanzine.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36652899C4;
 Tue,  6 Jul 2021 07:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID;
 bh=yAYLUOcMAjwWlnolJzwB+DdPAkDh6C8nqbU1+Pn7l5g=; 
 b=Kc8ACXNVyfADgALk6R5BDxfPPV62L47V08/3rtScPLoYc4B13+GDXUv5Bh1/4ZONIZqTP4u6tk3jBdncJbekb1ORWmOcHfxTMyE6VUWCI1Cv/GofN+wHkHAzhSRM7GKrIl+ROyuBJgaxYXl2ImzHzv87FwVMA1neIFFXEZ9tRmZ9PgD1Lmv5MKutjNyYihLRhdCKaUGbengm1xaZrQOb5XIgMaCRrjPe+8axRgXBizkukh23yyMTpA+TToKMrXt14HWL1WH55PayuYU9kwI6Dj+Csmp+/+h58LFpav3FLaF/rG+pc7EFcAcnvsYNJnc2w40KS4l4Bdkr3m8+J9e3gQ==;
Received: from 152.red-88-9-105.dynamicip.rima-tde.net ([88.9.105.152]
 helo=[192.168.2.220]) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1m0fer-0006eX-By; Tue, 06 Jul 2021 09:38:17 +0200
Message-ID: <c40f6f761610aa2c8076cac1dda87844af96c7ad.camel@igalia.com>
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
Date: Tue, 06 Jul 2021 09:38:07 +0200
In-Reply-To: <0032ceefa7c39bdd03907565ab9762ad6007eb80.camel@igalia.com>
References: <790BA4EE-E3F0-40B9-BE18-3646492F1CAE@intel.com>
 <380e8cb0f18c6f4b21c20b382668316b8962159a.camel@igalia.com>
 <0032ceefa7c39bdd03907565ab9762ad6007eb80.camel@igalia.com>
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 06 Jul 2021 13:22:39 +0000
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
Content-Type: multipart/mixed; boundary="===============2055100735=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--===============2055100735==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-JSpHCLgKrKlySHImBZYz"


--=-JSpHCLgKrKlySHImBZYz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

We have decided to extend the Call for Proposals until September 1st or
until we will all the available talk slots, whichever occurs first.

Remember that talks will get accepted by order of submission. If you
are thinking on proposing a talk for XDC, do it as soon as possible.

Thanks,

Sam

On Sat, 2021-06-26 at 08:35 +0200, Samuel Iglesias Gons=C3=A1lvez wrote:
> One week!
>=20
> Don't forget to submit your proposals!
>=20
> Sam
>=20
> On Tue, 2021-06-08 at 12:38 +0200, Samuel Iglesias Gons=C3=A1lvez wrote:
> > Kind reminder. Deadline is Sunday, 4 July 2021 :-)
> >=20
> > Sam
> >=20
> > On Thu, 2021-05-20 at 10:01 +0000, Szwichtenberg, Radoslaw wrote:
> > > Hello!
> > > =C2=A0
> > > Registration & Call for Proposals are now open for XDC 2021,
> > > which
> > > will
> > > take place on September 15-17, 2021. This year we will repeat as
> > > virtual event.
> > > =C2=A0
> > > https://indico.freedesktop.org/event/1/
> > > =C2=A0
> > > As usual, the conference is free of charge and open to the
> > > general
> > > public. If you plan on attending, please make sure to register as
> > > early
> > > as possible!
> > > =C2=A0
> > > In order to register as attendee, you will therefore need to
> > > register
> > > via the XDC website. As XDC moved to a new Indico infrastructure,
> > > if
> > > you previously registered on the XDC website, you need to create
> > > a
> > > new
> > > account again.
> > > =C2=A0
> > > https://indico.freedesktop.org/event/1/registrations/1/
> > > =C2=A0
> > > In addition to registration, the CfP is now open for talks,
> > > workshops
> > > and demos at XDC 2021. While any serious proposal will be
> > > gratefully
> > > considered, topics of interest to X.Org and freedesktop.org
> > > developers
> > > are encouraged. The program focus is on new development, ongoing
> > > challenges and anything else that will spark discussions among
> > > attendees in the hallway track.
> > > =C2=A0
> > > We are open to talks across all layers of the graphics stack,
> > > from
> > > the
> > > kernel to desktop environments / graphical applications and about
> > > how
> > > to make things better for the developers who build them. Head to
> > > the
> > > CfP page to learn more:=C2=A0
> > > =C2=A0
> > > https://indico.freedesktop.org/event/1/abstracts/
> > > =C2=A0
> > > The deadline for submissions is Sunday, 4 July 2021.
> > > =C2=A0
> > > Last year we modified our Reimbursement Policy to accept speaker
> > > expenses for X.Org virtual events like XDC 2021. Check it out
> > > here:
> > > =C2=A0
> > > https://www.x.org/wiki/XorgFoundation/Policies/Reimbursement/
> > > =C2=A0
> > > If you have any questions, please send me an email to
> > > radoslaw.szwichtenberg@intel.com,=C2=A0=C2=A0adding on CC the X.org b=
oard
> > > (board
> > > at foundation.x.org).
> > > =C2=A0
> > > And don't forget, you can follow us on Twitter for all the latest
> > > updates and to stay connected:
> > > =C2=A0
> > > =C2=A0
> > > https://twitter.com/XOrgDevConf
> > > =C2=A0
> > > Best,
> > > =C2=A0
> > > Radek
> > > =C2=A0
> > > P.S: a DNS redirection (xdc2021.x.org) is work in progress.
> > > Please
> > > use
> > > the mentioned links for the moment.
> > > =C2=A0
> > > =C2=A0
> > > Rados=C5=82aw Szwichtenberg
> > > -------------------------------------------------
> > > Intel Technology Poland sp. z o.o.
> > > ul. Slowackiego 173, 80-298 Gdansk
> > > KRS 101882 - NIP 957-07-52-316
> > > =C2=A0
> > > _______________________________________________
> > > mesa-dev mailing list
> > > mesa-dev@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/mesa-dev
> >=20
> > _______________________________________________
> > mesa-dev mailing list
> > mesa-dev@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/mesa-dev
>=20
> _______________________________________________
> mesa-dev mailing list
> mesa-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/mesa-dev


--=-JSpHCLgKrKlySHImBZYz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEQP+ZAvaXWkfuKXiEf/S6MvF9w0MFAmDkCF8ACgkQf/S6MvF9
w0MgvxAAlEPkYv+zzi6cQAVrRhBdZUpeDJQN+F/f7r+GCGiRDElf/9ZG5BB35H0n
2LlA6nUsCsu7QJu4AC9N3y8zTAgHfiO+LxsUuFH/XOTf4C9YIbak5XJVkURR4TRA
+6dfGkKGJSTTpBTWoqK0nxwVOMtvL6m/eQmyAMzMhhxw2/dztLlY94lm9vQQ8KJD
Y4rXppj1kT70NjQU0rRcbj2XcvyLSiAAzZqQrZeyqfuTXhhfU8DlhpyWTHONwSr3
i5IFr7ws1AKFWajm2X3vt6OF/3mz7GBPLckHPozASXUIbttoFLRDmvM+pD+IrlIE
VekLDnvABmTcYX+Wf6Fm9mtJPnjZAJaMi26QMh5Bq2Iz3xIumYPdg/R+3TshABkD
LmSSlEwy1gOqIvgJzfVCtTASWNWRROGO5nUr1yO+o26p1UJ4cR71MXuIuj5SIs9H
mCIFrQhj/lFUuORqPY6WRlFDnigmxBswKowhVv6GO+pKhxaLclK9ps4EC1EKvwLY
/R8fE0CEZpIH5aC6NG5dC5T8pRzmatwC40P2IBZEMbYH1IGCS7muG4ZAthdCcJNt
A/MpfDYfCJFkrpBQ2teeKKwYdd/Rq+q3l41/In97mf2wyTZkhCXgdIdLJtSQooxB
DRV1Huf5e2JeTLvZ5Vnpmpt6SbUP2kWPA/lT55h1m3VOTf1ZZDk=
=2V8p
-----END PGP SIGNATURE-----

--=-JSpHCLgKrKlySHImBZYz--


--===============2055100735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2055100735==--

