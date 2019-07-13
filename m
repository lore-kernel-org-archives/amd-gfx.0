From: Felix Kuehling <felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 27/27] drm/amdgpu: Fix GTT size calculation
Date: Sat, 13 Jul 2019 16:24:57 -0400
Message-ID: <44747586-8c98-6c85-dc5c-7464f59b205e@gmail.com>
References: <20190428074331.30107-1-Felix.Kuehling@amd.com>
 <20190428074331.30107-28-Felix.Kuehling@amd.com>
 <86fa9fc3-7a8f-9855-ae1d-5c7ccf2b5260@gmail.com>
 <1b1ec993-1c4b-8661-9b3f-ac0ad8ae64c7@amd.com>
 <134a4999-776f-44c6-99a2-42e8b9366a73@gmail.com>
 <9f882acd-c48f-3bbd-2d90-659c2edead39@amd.com>
 <f5c698ad-2aff-b3c5-2041-05a10983438a@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0945771492=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f5c698ad-2aff-b3c5-2041-05a10983438a-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0945771492==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OZ9Yrfzx3FfSeD2Y0kYYt4HEB2RKs6mRl"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OZ9Yrfzx3FfSeD2Y0kYYt4HEB2RKs6mRl
Content-Type: multipart/mixed; boundary="WXqmnOtHoAaoNmIhUbxG39IEM5rwr92cm";
 protected-headers="v1"
From: Felix Kuehling <felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>,
 "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Message-ID: <44747586-8c98-6c85-dc5c-7464f59b205e-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 27/27] drm/amdgpu: Fix GTT size calculation
References: <20190428074331.30107-1-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
 <20190428074331.30107-28-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
 <86fa9fc3-7a8f-9855-ae1d-5c7ccf2b5260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 <1b1ec993-1c4b-8661-9b3f-ac0ad8ae64c7-5C7GfCeVMHo@public.gmane.org>
 <134a4999-776f-44c6-99a2-42e8b9366a73-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 <9f882acd-c48f-3bbd-2d90-659c2edead39-5C7GfCeVMHo@public.gmane.org>
 <f5c698ad-2aff-b3c5-2041-05a10983438a-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <f5c698ad-2aff-b3c5-2041-05a10983438a-5C7GfCeVMHo@public.gmane.org>

--WXqmnOtHoAaoNmIhUbxG39IEM5rwr92cm
Content-Type: multipart/alternative;
 boundary="------------59A3B4AD88DB4C7638B1B15B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------59A3B4AD88DB4C7638B1B15B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 2019-04-30 um 1:03 p.m. schrieb Koenig, Christian:
>>> The only real solution I can see is to be able to reliable kill shade=
rs
>>> in an OOM situation.
>> Well, we can in fact preempt our compute shaders with low latency.
>> Killing a KFD process will do exactly that.
> I've taken a look at that thing as well and to be honest it is not even=
=20
> remotely sufficient.
>
> We need something which stops the hardware *immediately* from accessing=
=20
> system memory, and not wait for the SQ to kill all waves, flush caches =

> etc...
>
> One possibility I'm playing around with for a while is to replace the=20
> root PD for the VMIDs in question on the fly. E.g. we just let it point=
=20
> to some dummy which redirects everything into nirvana.
>
> But implementing this is easier said than done...

Warming up this thread, since I just fixed another bug that was enabled
by artificial memory pressure due to the GTT limit.

I think disabling the PD for the VMIDs is a good idea. A problem is that
HWS firmware updates PD pointers in the background for its VMIDs. So
this would require a reliable and fast way to kill the HWS first.

An alternative I thought about is, disabling bus access at the BIF level
if that's possible somehow. Basically we would instantaneously kill all
GPU system memory access, signal all fences or just remove all fences
from all BO reservations (reservation_object_add_excl_fence(resv, NULL))
to allow memory to be freed, let the OOM killer do its thing, and when
the dust settles, reset the GPU.

Regards,
=C2=A0 Felix

>
> Regards,
> Christian.

--------------59A3B4AD88DB4C7638B1B15B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"moz-cite-prefix">Am 2019-04-30 um 1:03 p.m. schrieb
      Koenig, Christian:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:f5c698ad-2aff-b3c5-2041-05a10983438a-5C7GfCeVMHo@public.gmane.org">
      <blockquote type=3D"cite" style=3D"color: #000000;">
        <blockquote type=3D"cite" style=3D"color: #000000;">
          <pre class=3D"moz-quote-pre" wrap=3D"">The only real solution I=
 can see is to be able to reliable kill shaders
in an OOM situation.
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">Well, we can in fact preem=
pt our compute shaders with low latency.
Killing a KFD process will do exactly that.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">I've taken a look at that th=
ing as well and to be honest it is not even=20
remotely sufficient.

We need something which stops the hardware <b class=3D"moz-txt-star"><spa=
n class=3D"moz-txt-tag">*</span>immediately<span class=3D"moz-txt-tag">*<=
/span></b> from accessing=20
system memory, and not wait for the SQ to kill all waves, flush caches=20
etc...

One possibility I'm playing around with for a while is to replace the=20
root PD for the VMIDs in question on the fly. E.g. we just let it point=20
to some dummy which redirects everything into nirvana.

But implementing this is easier said than done...</pre>
    </blockquote>
    <p>Warming up this thread, since I just fixed another bug that was
      enabled by artificial memory pressure due to the GTT limit.</p>
    <p>I think disabling the PD for the VMIDs is a good idea. A problem
      is that HWS firmware updates PD pointers in the background for its
      VMIDs. So this would require a reliable and fast way to kill the
      HWS first.</p>
    <p>An alternative I thought about is, disabling bus access at the
      BIF level if that's possible somehow. Basically we would
      instantaneously kill all GPU system memory access, signal all
      fences or just remove all fences from all BO reservations
      (reservation_object_add_excl_fence(resv, NULL)) to allow memory to
      be freed, let the OOM killer do its thing, and when the dust
      settles, reset the GPU.<br>
    </p>
    <p>Regards,<br>
      =C2=A0 Felix<br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:f5c698ad-2aff-b3c5-2041-05a10983438a-5C7GfCeVMHo@public.gmane.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">

Regards,
Christian.
</pre>
    </blockquote>
  </body>
</html>

--------------59A3B4AD88DB4C7638B1B15B--

--WXqmnOtHoAaoNmIhUbxG39IEM5rwr92cm--

--OZ9Yrfzx3FfSeD2Y0kYYt4HEB2RKs6mRl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQSF9iw3xYpcigJ58/LWGSsMBQyTdgUCXSo+HAAKCRDWGSsMBQyT
dtkeAP96AVm1joiyGB4yLHGKFoXaiu5qJ9k2Vx2N1govvh78JwD/QZ3qFT7aCXMS
bJ8y1z89fKLJj+imoEpoMAeciayEReA=
=MlDq
-----END PGP SIGNATURE-----

--OZ9Yrfzx3FfSeD2Y0kYYt4HEB2RKs6mRl--

--===============0945771492==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0945771492==--
