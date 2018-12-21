From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH] drm: return false in drm_arch_can_wc_memory() for ARM
Date: Fri, 21 Dec 2018 08:39:52 -0800
Message-ID: <87pntu3kbr.fsf@anholt.net>
References: <20181220145657.304-1-alexander.deucher@amd.com>
 <20181220153619.GP21184@phenom.ffwll.local>
 <20181221141644.GB22341@e110455-lin.cambridge.arm.com>
 <CADnq5_P9VZMhC_4j3F4hqHdD6Ey0=totPuNhF3hYBzkbgHsPpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0318870048=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_P9VZMhC_4j3F4hqHdD6Ey0=totPuNhF3hYBzkbgHsPpg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0318870048==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> On Fri, Dec 21, 2018 at 9:16 AM Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org> wrote:
>>
>> On Thu, Dec 20, 2018 at 04:36:19PM +0100, Daniel Vetter wrote:
>> > On Thu, Dec 20, 2018 at 09:56:57AM -0500, Alex Deucher wrote:
>> > > I'm not familiar enough with ARM to know if write combining
>> > > is actually an architectural limitation or if it's an issue
>> > > with the PCIe IPs used on various platforms, but so far
>> > > everyone that has tried to run radeon hardware on
>> > > ARM has had to disable it.  So let's just make it official.
>> >
>> > wc on arm is Really Complicated (tm) afaiui. There's issues with aliasing
>> > mappings and stuff, so you need to allocate your wc memory from special
>> > pools. So probably best to just disable it until we figure this out.
>>
>> I believe both of you are conflating different issues under the wrong
>> name. Write combining happens all the time with Arm, the ARMv8
>> architecture is a weakly-ordered model of memory so hardware is allowed
>> to re-order or combine memory access as they seem fit.
>>
>> A while ago I did run an AMD GPU card on my Juno dev board and it worked
>> (for a very limited definition of worked, I've only validated the fact
>> that I could get an fbcon and could run un-accelerated X11). So I would
>> be interested if Alex could share some of the scenarios where people are
>> seeing failures.
>
> Here's an example:
> https://bugs.freedesktop.org/show_bug.cgi?id=108625
> But there are probably 5 or 6 other cases where people have emailed me
> or our team directly with issues on ARM resolved by disabling WC.
> Generally the driver seems to load ok, but then hangs as soon as you
> try and use acceleration from userspace or we end up with page
> flipping timeouts.  Not really sure what the issue is.  Michel
> suggested maybe ARM has a cacheable kernel mapping of all "normal"
> system memory, and having
> both that mapping and another non-cacheable mapping of the same page
> can result in bad behaviour.
>
>>
>> As for aliasing, yeah, having multiple aliases to the same piece of
>> memory is a bad thing. The problem arises when devices on the PCI bus
>> have memory allocated as device memory (which on Arm is non-cacheable
>> and non-reorderable), but the PCI bus effectively acts as a write-combiner
>> which changes the order of transactions. Therefore, for devices that
>> have local memory associated with them (i.e. more than just register
>> accesses) one should allocate memory in the first place that is
>> Device-GRE (gathering, reordering and early-access). Otherwise, problems
>> will surface that are not visible on x86 as that is a strongly ordered
>> architecture.
>
> PCI framebuffer BARs are mapped on the CPU with WC.  We also use
> uncached WC mappings for system memory in cases where it's not likely
> we will be doing any CPU reads.  When accessing system memory, the GPU
> can either do a CPU cache snooped transaction or a non-snooped
> transaction.  The non-snooped transaction has lower latency and better
> throughput since it doesn't have to snoop the CPU cache.
>
>>
>> >
>> > > Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>> >
>> > Reviewed-by: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
>>
>> Given that this API is only used by AMD I'm OK for now with the change,
>> but I think in general it is misleading and we should work towards
>> fixing radeon and amd drivers.
>
> Alternatively, we could just disable WC in the amdgpu driver on ARM.
> I'm not sure to what extent other drivers are using WC in general or
> have been tested on ARM.

FWIW, I use WC mappings of BOs on V3D (shmem) and VC4 (cma).  V3D is
totally stable.  VC4 I've heard reports of stability issues long-term
but I don't think it's related.  I don't do any cached mappings of my
BOs, though.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlwdF1kACgkQtdYpNtH8
nuj6ARAAgZYWun3voqzneaiEkwM3Py4FPVfLsHfLeO2ExMG/u5GdCpSJmph+QSNm
8YD6xjmVKEh+kZ+bt3R//DProk7+l2qxWt2ILysz6eBGsQ5mntYDwmhYXQQTCoaY
+XKkxRMKnYVXLuwvNXMBIboDRf0NYHFwsizOG2TLcu/x+PPqOzqgbKPs8sl6uM9K
DCxqfahpC6cc5sLtY8e7DRI6QWRulSqy2Qx8wonJooUsC9deRw3n5IH9+qy1T4XR
ONWHCzG94iTV/SzhgXiXU7k1PkIhJbha++NTc5AKAByg+g8aV1RI0sF7o2DVDFue
Otf/Z71uMlw6DWd2IwZofGrSksz0TYzHm6REp6qMCTjvpUowkVCx6jIQ3EtVjA1S
DiFLoqOZRn8+NY6g94IzRk1+dzSO1pfUWTjP/7in+Zp6DFmQCbeS+gMItWVpfC0j
LU8zGvOYNRwXQsuqYqzLEtqf2r8rCv+hPcH9ZL8C37xPZqBcHNP6Ps7epsW5GFTQ
lmEdD5La1dKQTlpVWBvoVgFrwxrpHRVImbhP1fThSJiikjuk8FrK5MGYAAXTvBkZ
83vq53S6UXEQUArqmESitwCkB1AHfH6Db335v7EQFwRLWbJE22eJDrospr3vd3EP
+64I3FdePQfE4WTv7ED8nz4prON+k+uOWv2BwCSXyyla9f829Tw=
=hDeK
-----END PGP SIGNATURE-----
--=-=-=--

--===============0318870048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0318870048==--
