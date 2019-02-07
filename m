From: Przemek Socha <soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: BUG - unable to handle null pointer,
 bisected - drm/amd/display: add gpio lock/unlock
Date: Thu, 07 Feb 2019 23:15:53 +0100
Message-ID: <1970276.ZfjSEdBXdN@eclipse>
References: <10341067.RRd0raRtKH@eclipse>
 <f06d3abf-7aab-f77a-9bf9-cb7c01376467@amd.com>
 <4eee91c0-17bd-150c-dd94-0d4521b26e4c@amd.com>
Reply-To: soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1836904203=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4eee91c0-17bd-150c-dd94-0d4521b26e4c-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Chiawen Huang <chiawen.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1836904203==
Content-Type: multipart/signed; boundary="nextPart1987767.9aE9yCvMWu"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart1987767.9aE9yCvMWu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Dnia czwartek, 7 lutego 2019 22:59:59 CET piszesz:

> > I'll post a fix shortly.
> 
> Fix merged to amd-staging-drm-next.
> 
> Harry
> 


I apologize for the late response, 
and thank you very much.

I had a problem with applying the patch on top of clean amd-staging-drm-next 
because it is in one chunk,  I suppose ( but my patch-fu could be weak also) I 
had t o modify it like this:
"
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1127,10 +1127,11 @@
 		link->dc->res_pool->funcs->link_init(link);
 
 	link->hpd_gpio = get_hpd_gpio(link->ctx->dc_bios, link->link_id, 
link->ctx->gpio_service);
-	dal_gpio_open(link->hpd_gpio, GPIO_MODE_INTERRUPT);
-	dal_gpio_unlock_pin(link->hpd_gpio);
-	if (link->hpd_gpio != NULL)
-		link->irq_source_hpd = dal_irq_get_source(link-
>hpd_gpio);
+if (link->hpd_gpio != NULL) {
+               dal_gpio_open(link->hpd_gpio, GPIO_MODE_INTERRUPT);
+               dal_gpio_unlock_pin(link->hpd_gpio);
+                link->irq_source_hpd = dal_irq_get_source(link->hpd_gpio);
+       }
 
 	switch (link->link_id.id) {
 	case CONNECTOR_ID_HDMI_TYPE_A:
"

After that, machine works as it should.

So this patch also works on Mullins apu.

Once again, thank you all very much.

Przemek.



--nextPart1987767.9aE9yCvMWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2zcce+zboy/je1pmPMstj1lsVJMFAlxcrhkACgkQPMstj1ls
VJOZWg/8Ckl4to94wRyIkx6dyK4nZck/G5jqVfN7tos4chmI6NMx9SO0N0AOi+/3
lFKP2nh4g+tbqU0P48zfuzzL539Poz1Q45qKIX8K41Adk4//gGTUqOAmnGNuHYqm
ooN2hame5lYfiRG4FBcXI4LlTlbdyx0lbjC4lGcH8nGBvwWEfqbqIY+PXGEVVFPB
3hTpCZ79plpigH0qDyYjCA5C8bdmratyPaTQ7S2YifwoZtgmY8tcD/vvY+ld5CRB
offGBQh5Z0NBWeicPFtNabfB2GJHWy53rQlMOMjEMEtKHV/WGI7oRd946eQxx0+k
NsRg4QOkai8GW1yqbegA9US/FNfK8MTgMSqp+/KOm0us36HxvMn1S7dfM35JMNOs
lg4UNRZ1W+upR/xGNdpfa/jOd+XAVTVfGeg4kaAcLV4F1mGXKAWV+MkaFqigelR4
0GKqWPNB2vGWtxy+kDNYOSOv9rvJR3EihZPr0KwBvXW6YtvpnMkyPwbk7DZOOwOL
NV8rwW+CuV6zhuszMFKVGu64r0qpMOCPwjgjvmYfd7e/jPLzl2BozPX8oSJFKKOL
aF7Pn2M4so4ZCQ4mxd/pJG21FBUZmqbrmIuB8hBjinCaXQ+6JpnavXpwewGTTe2q
sjF7hHFE5gz5ZitaNmBUSh8Iin1p0+s/cCHhiRsgUw5qI4Ephpk=
=HO2p
-----END PGP SIGNATURE-----

--nextPart1987767.9aE9yCvMWu--




--===============1836904203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1836904203==--
