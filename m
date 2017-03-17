From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] drm: add check for plane functions
Date: Fri, 17 Mar 2017 12:29:59 -0700
Message-ID: <87k27nsnuw.fsf@eliezer.anholt.net>
References: <1489737308-30713-1-git-send-email-shirish.s@amd.com>
 <20170317095647.GN31595@intel.com>
 <CAE=Z4VBsuzAPWSiy9NSXXFZfWEuSEi0miANhNmq5u0xR6M0BWw@mail.gmail.com>
 <20170317110843.GQ31595@intel.com>
 <20170317165752.hm6htsx3jlhusx4s@phenom.ffwll.local>
 <20170317171933.GU31595@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1557753079=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170317171933.GU31595@intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, shirish.s@amd.com
List-Id: amd-gfx.lists.freedesktop.org

--===============1557753079==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com> writes:

> On Fri, Mar 17, 2017 at 05:57:52PM +0100, Daniel Vetter wrote:
>> On Fri, Mar 17, 2017 at 01:08:43PM +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
>> > On Fri, Mar 17, 2017 at 03:46:34PM +0530, Shirish S wrote:
>> > > On Fri, Mar 17, 2017 at 3:26 PM, Ville Syrj=C3=A4l=C3=A4
>> > > <ville.syrjala@linux.intel.com> wrote:
>> > > > On Fri, Mar 17, 2017 at 01:25:08PM +0530, Shirish S wrote:
>> > > >> update_plane() and disable_plane() functions
>> > > >> assoiciated with setting plane are called
>> > > >> without any check, causing kernel panic.
>> > > >
>> > > > Why are you registering a plane without the funcs?
>> > > >
>> > > Basically, enabling planes and making them fully functional is
>> > > generally a 2 -step process,
>> > > so i suggest for new drivers wanting to implement/re-design  planes,
>> > > would like to tap
>> > > the flow at enabling(listing caps) and later at ensuring it works.
>> >=20
>> > I don't think there's much point in exposing something that
>> > doesn't work. And even if you do, you could always just use
>> > stub functions.
>>=20
>> Yes, just wire up stub functions if you want to enable planes with
>> multi-step patch series.
>>=20
>> > > I noticed that there is a underlying assumption only for
>> > > plane->(funcs) are implemented, whereas for
>> > > other function for crtc/connector/encoder function calls there is a
>> > > sanity check(or WARN_ON) through out the framework.
>> > >=20
>> > > I believe this check wont cause any performance/functional impact.
>> > > Please let me know if am missing anything.
>> > > And further more help developers to focus on enabling planes via
>> > > various tests without causing reboots/system hangs.
>> >=20
>> > I don't particularly like adding more unconditional runtime checks
>> > that just to protect developers from themselves. If you really
>> > think there's value in these, then at least add the checks into
>> > the plane init codepath so that it's a one time cost.
>> >=20
>> > The same approach could be used for all the other non-optional
>> > hooks. Otherwise the same WARN_ON()s would have to be sprinkled
>> > all over the place, and there's always the risk of missing a few
>> > codepaths that call a specific hook.
>>=20
>> I think for these here there's negative value - it allows developers to
>> create completely broken planes. Stub functions really seem like a much
>> better idea.
>
> I was thinking=20
>
> drm_whatever_init()
> {
> 	if (WARN_ON(!funcs->mandatory_thing))
> 		return -EINVAL;
> }
>
> rather than putting the WARN_ON()s around each call of
> funcs->mandatory_thing().
>
> That will fail gracefully (which I guess is what people are after here),
> and gives the developer a clear message what's missing.

Having this in our init functions for funcs and helpers would have saved
me tons of time in vc4 and clcd.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAljMOTcACgkQtdYpNtH8
nuiFlRAAnQh/BEY1HGa2/lT31wtXotkVZKJFspZ+sTtDQuJ0/SJuVWwyiYuZSsA2
Yss9KqIvGmBRb47X8+fg4xCffgYPc67JY/2ri+imD1X7fNTsmal+WZ3paLXzTIyM
twdqW0vADJKklo1ywIZfl1SHMdrCoMRfIJ0NXTqXYNdap0sSVlX/7xo3Z7hd437A
SFNgO8jSPfIu0XxmeZtLEMZX/KhsbRquSzRcbcg410vTHWL+p4M7TsfdBsgdk2Yi
EcsvgNI21GsYiDmXOxcVd+FGEpCYvEjkOY51xvdWoqTL2g6zVmWQGIbbgMqm5rEh
q9hWfuzBxIYOV0Xl6MYbVdt94g7WKIrHCRsghxwHLC/IWnAerbDTY7MN1k9+PrSG
qADBmcNcEOILm1Ro93lXtUILklfodjJZX0OYUEws5kHoG92hVbUyJgVVku7VjShH
waXrjJBv8GpGouet6qiKJRfedrr7pqnY0Zoq3bZKe5f/DgVS6fAAU7zKrEA/6+qJ
5bTyaqngPEyPDgAK5QsgeI+WlBw4etvmFQAYd2oCIb6NMlI2TWOylA/viL0iFCve
9w4XZpOHIJ9pMQlL4DC7n18hOoa0ZvPUxEPuI+J2lAFgjK0dGtBiyqg8vTlj0V/4
hDUJw04flvZEtEySVoxTfnhbOktMK+SMNLHz8eT5nInlflyX48E=
=8F+1
-----END PGP SIGNATURE-----
--=-=-=--

--===============1557753079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1557753079==--
