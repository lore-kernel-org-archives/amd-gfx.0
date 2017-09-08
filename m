From: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/6] Ground foundation for VCE 1 implementation
Date: Fri, 8 Sep 2017 08:06:47 -0400
Message-ID: <e2b23388-30a3-e927-d51a-569c762c8c99@gmail.com>
References: <20170908024835.13638-1-alexandre.f.demers@gmail.com>
 <f43717f2-fdbf-91be-1371-38f2102bc202@amd.com>
 <c24c47ce-6f83-18f2-6064-b07987501afb@gmail.com>
Reply-To: alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1512023717=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c24c47ce-6f83-18f2-6064-b07987501afb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-GB-large
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============1512023717==
Content-Type: multipart/alternative;
 boundary="------------B75FC48DED8BFAE79D9976B5"
Content-Language: en-GB-large

This is a multi-part message in MIME format.
--------------B75FC48DED8BFAE79D9976B5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Oh and patch 3 "Small precision when failing to load legacy firmware"
should have been a standalone patch, it is related to the radeon driver.
I'll send it as so with drm/radeon in the title.

Alexandre Demers

On 2017-09-08 07:55, Alexandre Demers wrote:
> Hi Christian!
>
> On 2017-09-08 04:24, Christian König wrote:
>> First of all please prefix all subject lines for amdgpu kernel patches
>> with drm/amdgpu.
> You're right, I forgot.
>> Additional to that I think we won't accept loading firmware files in
>> the old format. Instead please just add the header to the files. If
>> that turns out to be problematic I can start looking into providing
>> those.
> Noted, I'll drop the code and I'll create a temporary firmware with the
> needed header. However, it would be convenient to see newer firmwares
> for both VCE and UVD (cheers Trevor) coming from an official source
> (AMD). Let's remove the old firmware loading patch and propose a glued
> firmware.
>> Apart from that thanks a lot for this work, this is really welcome.
>> But does it actually work? Have you tested it with mesa?
> This work doesn't activate any VCE functionality. On the other hand, it
> shouldn't break anything either. It needs the next series of patches.
> While the firmware loading and initialization seem to go through
> correctly, I'm encountering hangs at boot. That's where I'll need some help.
>
> I'll post the next series in the next few days as a RFC so others can
> help me go through. I just need to split the code in a few patches.
>
> Cheers,
> Alex
>> Thanks,
>> Christian.
>>
>> Am 08.09.2017 um 04:48 schrieb Alexandre Demers:
>>> This is the foundation for VCE 1 implementation, mostly ported from
>>> radeon to
>>> amdgpu. This should have no impact for now on the usability of the
>>> driver. This
>>> is the pretty straight-forward part. The heavier part is coming as a
>>> RFC.
>>>
>>> I'd like to have this first part available to all, since I don't have
>>> as much
>>> time as I'd like to work on VCE 1 for now, but this could help others
>>> to help me
>>> on the task.
>>>
>>> If you are not satisfied with this first series, this can also be
>>> considered as
>>> a RFC. Please, comment as needed.
>>>
>>> Alexandre Demers (6):
>>>    Add initial VCE_V1_0 files.
>>>    Reorganize, rename, move and split some VCE 1 defines.
>>>    Small precision when failing to load legacy firmware.
>>>    Moving read and write pointer functions from radeon to amdgpu
>>>    Add support for SI's VCE firmwares (with and without header)
>>>    Fix indentation.
>>>
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            | 100 ++++--
>>>   drivers/gpu/drm/amd/amdgpu/si.c                    |  17 +-
>>>   drivers/gpu/drm/amd/amdgpu/si_dma.c                |   5 +-
>>>   drivers/gpu/drm/amd/amdgpu/si_ih.c                 |  21 +-
>>>   drivers/gpu/drm/amd/amdgpu/sid.h                   |  70 ----
>>>   drivers/gpu/drm/amd/amdgpu/vce_v1_0.c              | 394
>>> +++++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/vce_v1_0.h              |  29 ++
>>>   .../gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h   |  80 +++--
>>>   .../drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h |  13 +-
>>>   drivers/gpu/drm/radeon/radeon_uvd.c                |   2 +-
>>>   10 files changed, 589 insertions(+), 142 deletions(-)
>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.h
>>>
>


--------------B75FC48DED8BFAE79D9976B5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Oh and patch 3 "Small precision when failing to load legacy firmware" should have been a standalone patch, it is related to the radeon driver. I'll send it as so with drm/radeon in the title.
<style type="text/css">
p, li { white-space: pre-wrap; }
</style></p>
    <pre class="moz-signature" cols="72">Alexandre Demers</pre>
    <div class="moz-cite-prefix">On 2017-09-08 07:55, Alexandre Demers
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:c24c47ce-6f83-18f2-6064-b07987501afb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
      <pre wrap="">Hi Christian!

On 2017-09-08 04:24, Christian König wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">First of all please prefix all subject lines for amdgpu kernel patches
with drm/amdgpu.
</pre>
      </blockquote>
      <pre wrap="">You're right, I forgot.
</pre>
      <blockquote type="cite">
        <pre wrap="">
Additional to that I think we won't accept loading firmware files in
the old format. Instead please just add the header to the files. If
that turns out to be problematic I can start looking into providing
those.
</pre>
      </blockquote>
      <pre wrap="">Noted, I'll drop the code and I'll create a temporary firmware with the
needed header. However, it would be convenient to see newer firmwares
for both VCE and UVD (cheers Trevor) coming from an official source
(AMD). Let's remove the old firmware loading patch and propose a glued
firmware.
</pre>
      <blockquote type="cite">
        <pre wrap="">
Apart from that thanks a lot for this work, this is really welcome.
But does it actually work? Have you tested it with mesa?
</pre>
      </blockquote>
      <pre wrap="">This work doesn't activate any VCE functionality. On the other hand, it
shouldn't break anything either. It needs the next series of patches.
While the firmware loading and initialization seem to go through
correctly, I'm encountering hangs at boot. That's where I'll need some help.

I'll post the next series in the next few days as a RFC so others can
help me go through. I just need to split the code in a few patches.

Cheers,
Alex
</pre>
      <blockquote type="cite">
        <pre wrap="">
Thanks,
Christian.

Am 08.09.2017 um 04:48 schrieb Alexandre Demers:
</pre>
        <blockquote type="cite">
          <pre wrap="">This is the foundation for VCE 1 implementation, mostly ported from
radeon to
amdgpu. This should have no impact for now on the usability of the
driver. This
is the pretty straight-forward part. The heavier part is coming as a
RFC.

I'd like to have this first part available to all, since I don't have
as much
time as I'd like to work on VCE 1 for now, but this could help others
to help me
on the task.

If you are not satisfied with this first series, this can also be
considered as
a RFC. Please, comment as needed.

Alexandre Demers (6):
   Add initial VCE_V1_0 files.
   Reorganize, rename, move and split some VCE 1 defines.
   Small precision when failing to load legacy firmware.
   Moving read and write pointer functions from radeon to amdgpu
   Add support for SI's VCE firmwares (with and without header)
   Fix indentation.

  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            | 100 ++++--
  drivers/gpu/drm/amd/amdgpu/si.c                    |  17 +-
  drivers/gpu/drm/amd/amdgpu/si_dma.c                |   5 +-
  drivers/gpu/drm/amd/amdgpu/si_ih.c                 |  21 +-
  drivers/gpu/drm/amd/amdgpu/sid.h                   |  70 ----
  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c              | 394
+++++++++++++++++++++
  drivers/gpu/drm/amd/amdgpu/vce_v1_0.h              |  29 ++
  .../gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h   |  80 +++--
  .../drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h |  13 +-
  drivers/gpu/drm/radeon/radeon_uvd.c                |   2 +-
  10 files changed, 589 insertions(+), 142 deletions(-)
  create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
  create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.h

</pre>
        </blockquote>
        <pre wrap="">
</pre>
      </blockquote>
      <pre wrap="">

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------B75FC48DED8BFAE79D9976B5--

--===============1512023717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1512023717==--
