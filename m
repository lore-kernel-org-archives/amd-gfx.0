From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 1/3] dma-buf: add dma_fence_get_stub
Date: Mon, 03 Dec 2018 09:01:19 -0800
Message-ID: <87bm62h7ds.fsf@anholt.net>
References: <20181203130759.10226-1-christian.koenig@amd.com>
 <878t16fv93.fsf@anholt.net> <bd9e0b64-4fb0-400b-ce27-439bc54bf315@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0582831906=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <bd9e0b64-4fb0-400b-ce27-439bc54bf315-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0582831906==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christian K=C3=B6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> Am 03.12.18 um 17:08 schrieb Eric Anholt:
>> Christian K=C3=B6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>>
>>> Extract of useful code from the timeline work. This provides a function
>>> to return a stub or dummy fence which is always signaled.
>>>
>>> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>   drivers/dma-buf/dma-fence.c | 36 +++++++++++++++++++++++++++++++++++-
>>>   include/linux/dma-fence.h   |  1 +
>>>   2 files changed, 36 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
>>> index 1551ca7df394..136ec04d683f 100644
>>> --- a/drivers/dma-buf/dma-fence.c
>>> +++ b/drivers/dma-buf/dma-fence.c
>>>   /*
>>>    * fence context counter: each execution context should have its own
>>>    * fence context, this allows checking if fences belong to the same
>>>    * context or not. One device can have multiple separate contexts,
>>>    * and they're used if some engine can run independently of another.
>>>    */
>>> -static atomic64_t dma_fence_context_counter =3D ATOMIC64_INIT(0);
>>> +static atomic64_t dma_fence_context_counter =3D ATOMIC64_INIT(1);
>> What's this change for?  I don't see a context allocation in patch #2
>> where the stub fence is being moved from, so this seems out of place.
>
> The stub fence is using context 0 and seqno 0, but since it is always=20
> signaled this actually shouldn't matter.
>
> So this is just to be on the extra clean side I made sure that nobody=20
> else is using context 0.
>
> Alternatively we could also just allocate one when we initialize it for=20
> the first time.

I like the allocate at init idea.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlwFYV8ACgkQtdYpNtH8
nuhJhA/9GgL6mZU4ypFOxFZBTnF1wx+/B7Ir2JiiFjOlu76FiSgRb26gkrdzJwy3
Esuo1ohwDxaZUlGSlQTRA5+jXev51vrl8xRXwEvHefmkZxrgk6BcX8cv0RgtB25H
zkmaQW5CXJRkd2nlKBWQJLWC6/FbEIxRDOX91CiKqG7ksE0otJl9l8ELtyifuCxz
0jc/fIfi2/DyFdDQwQrj7FFTqd+yfroEtvaoUGRCUeNoOSZf82ohy2/MN6pyTF98
3Ri47CD75Y0cZ6aJBeNeFWLXk64Be3S3oVsCZSY005b2UgLnsCI6Dv2hqiJx49Al
VmhVecUxvkibS5acv7eC42+tHaygHnrWjmIFiGICEeqFHUULT8dqfuhtrH+bBGPE
17bJrni2X5rbDM/gJe1OE8HzyXsu9eHG2ARy7Cyv0+gl2iVBq+rPjO4IzD1GG30F
RR3EwYnRIuvlfBOI/f6/0WNsBTvLrWlXiuyak8jsktGn41HIj+wbkp8pKiqXWDOE
7n2WFJEdO0pkk7qM+yCYxxJhZ6qE+IySHSMnMlzmxrJpR3GNucMdfiaPsVlqTzuB
/uW7bGzvZVWNXp9/w8AhyiB12XRzm0sMTinK52eEWJiyPN+Ml6qImS0aPlO+hObQ
epDsbqi6Sxh57Qkb3OL8J/lxiFmLFF2f+/+KisKbDoLCK/MKj2U=
=ypZ3
-----END PGP SIGNATURE-----
--=-=-=--

--===============0582831906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0582831906==--
