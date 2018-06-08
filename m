From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/v3d: Add a note about locking of
 v3d_fence_create().
Date: Fri, 08 Jun 2018 10:08:02 -0700
Message-ID: <87vaatxl3h.fsf@anholt.net>
References: <20180605190302.18279-1-eric@anholt.net>
 <20180605190302.18279-3-eric@anholt.net>
 <1528453446.26356.12.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0874374484=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1528453446.26356.12.camel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0874374484==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> writes:

> Am Dienstag, den 05.06.2018, 12:03 -0700 schrieb Eric Anholt:
>> This isn't the first time I've had to argue to myself why the '++' was
>> safe.
>
> And now you need to do the same thing with me...
>
>> Signed-off-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
>> ---
>> =C2=A0drivers/gpu/drm/v3d/v3d_fence.c | 3 +++
>> =C2=A01 file changed, 3 insertions(+)
>>=20
>> diff --git a/drivers/gpu/drm/v3d/v3d_fence.c b/drivers/gpu/drm/v3d/v3d_f=
ence.c
>> index bfe31a89668b..6265e9ab4a13 100644
>> --- a/drivers/gpu/drm/v3d/v3d_fence.c
>> +++ b/drivers/gpu/drm/v3d/v3d_fence.c
>> @@ -3,6 +3,9 @@
>> =C2=A0
>> =C2=A0#include "v3d_drv.h"
>> =C2=A0
>> +/* Note that V3D fences are created during v3d_job_run(), so we're
>> + * already implictly locked.
>> + */
> I don't see where you would be locked in the job_run path. I think what
> you mean is that this path needs no locks, as it is driven by a single
> scheduler thread, right?

Yeah, it's only called from run_job, and run_job can't reenter.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlsat/IACgkQtdYpNtH8
nug0mQ/+IMSetfCyvK+L46SrA8It0CnDp54NK9KeuBk/mjj6CbZG0Ej/Savq5mJN
xJZSDNx6uMYSe4gpOwlfD8qzAWtXtFf3H8RJMx1ijqRet42e6v6oDHY3y3C/2LtN
A4sopkjFut7hGdVvahwvR/HiVFO8SSpVPS+HPWlgRECoYAYCc1/9hnYxq+XELCK6
1ux3ekduqDcDZ/WOTNa3VY0Hr2aDFkKyTYeULkGtamh57IXso3RN7rYnuXuE29Yd
T3NehonlofNVjhcHau6VEknCaki+lsQjJ5owXgL/Q61HBFMIzdXA3cK5Q2G84Rew
6Gmo9//vBUfvhg/Dt2rO8ul+N1VvLz77UTUHMdEo3FdfaKGSsIRY2xosBQ268RCk
g48sKpw90rH3G0Wa0Dc2ycp20c9m0EJXq7rTUD7uSCDzfB3NicVONKATBRTVRw6T
FtNH4FYi8HzeQS9ydK7tXVlDc4y5YUHCTIo6kbqVlwZLUXSDgZOljzBlQZWwjdc/
9Elgs3noZeZMytbR9Kv8FYCvjgqFH6lT8MfR3XL3H3RBJxp0+ufHw7TjOy5TgCLC
TGwr/aKWiQRmgBl1AtYx4Q7c+KhHWyEQ20TmCmQmlF6BMNLnQHbeRa+XaXHvzD5N
W7l4ltptfQzvMFto2KMPJja8gGB94oJHsnhp9Bv+BVYWVz2wD38=
=5GKX
-----END PGP SIGNATURE-----
--=-=-=--

--===============0874374484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0874374484==--
