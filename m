From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/amdgpu/gfx8: Fix compute ring failure after
 resetting"
Date: Wed, 31 Jan 2018 11:59:17 -0500
Message-ID: <bb6b8b74-4587-8e56-9617-b03fe572eec7@amd.com>
References: <1516921601-15815-1-git-send-email-andrey.grodzovsky@amd.com>
 <BN3PR1201MB09307139AD6C494B5F502DC3EBE00@BN3PR1201MB0930.namprd12.prod.outlook.com>
 <BN6PR1201MB0115889698061BCBB4545A79EAE00@BN6PR1201MB0115.namprd12.prod.outlook.com>
 <BY2PR1201MB09351A0D0D0D09849008B3B9EBE00@BY2PR1201MB0935.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0701305660=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY2PR1201MB09351A0D0D0D09849008B3B9EBE00-O28G1zQ8oGkaqtME6NEo1mrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
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
To: "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wu,
 Haisheng" <Haisheng.Wu-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0701305660==
Content-Type: multipart/alternative;
 boundary="------------603C4905D2764AEA48C9BAF0"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------603C4905D2764AEA48C9BAF0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 01/25/2018 11:33 PM, Yu, Xiangliang wrote:
> You can add amdgpu_sriov_vf() check to avoid breaking sriov.

+ Haisheng

As found out after more debugging  and discussion with Haisheng from HW 
team, the sequence introduced by this change is is wrong, it causes 
compute rings test failure because "the ring buffer has to be filled 
with valid packets (such as NOPs) first before submitting MAP_QUEUEs 
packet into KIQ. Once a compute engine is mapped, it will immediately 
execute the ring buffer if the RTPR is not equal to the WTPR from the 
MQD. It could lead to engine hang if the ring buffer filled with random 
data."

Hence we would like to revert this change in amd-staging-drm-next and 
continue investigation on the SR-IOV side why the correct programming 
sequence doesn't work there. I myself currently working on setting up 
SR-IOV setup to take a look at that.

Thanks,
Andrey
>
>> -----Original Message-----
>> From: Grodzovsky, Andrey
>> Sent: Friday, January 26, 2018 11:29 AM
>> To: Yu, Xiangliang <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>; amd-
>> gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian
>> <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>> Subject: Re: [PATCH] Revert "drm/amdgpu/gfx8: Fix compute ring failure
>> after resetting"
>>
>> No, just bare metal, I assumed your problem was with compute ring test
>> failure which I didn't see. Can you please recheck if reverting this still failing
>> on SRIOV ?
>> If so we obviously need to keep looking how to fix it.
>>
>> Thanks,
>> Andrey
>>
>> ________________________________________
>> From: Yu, Xiangliang
>> Sent: 25 January 2018 20:59:45
>> To: Grodzovsky, Andrey; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> Cc: Deucher, Alexander; Grodzovsky, Andrey; Koenig, Christian
>> Subject: RE: [PATCH] Revert "drm/amdgpu/gfx8: Fix compute ring failure
>> after resetting"
>>
>> Did you test reset case in sriov?
>>
>>> -----Original Message-----
>>> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
>>> Of Andrey Grodzovsky
>>> Sent: Friday, January 26, 2018 7:07 AM
>>> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Grodzovsky,
>> Andrey
>>> <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>; Yu, Xiangliang
>> <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>;
>>> Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>>> Subject: [PATCH] Revert "drm/amdgpu/gfx8: Fix compute ring failure
>>> after resetting"
>>>
>>> This reverts commit 75737cb4eb78c7f185e4700b4aa20cf7a3381aca.
>>>
>>> Fixes GFX ring test failure after HW reset.
>>> No compute ring test failures were observed with the change reverted.
>>> So seems like whatever problem that change was addressing is not
>>> present anymore.
>>>
>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 10 +++-------
>>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> index 1207f36..8a65b53 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>> @@ -4847,6 +4847,9 @@ static int gfx_v8_0_kcq_init_queue(struct
>>> amdgpu_ring *ring)
>>>                /* reset MQD to a clean status */
>>>                if (adev->gfx.mec.mqd_backup[mqd_idx])
>>>                        memcpy(mqd, adev-
>>>> gfx.mec.mqd_backup[mqd_idx], sizeof(struct vi_mqd_allocation));
>>> +             /* reset ring buffer */
>>> +             ring->wptr = 0;
>>> +             amdgpu_ring_clear_ring(ring);
>>>        } else {
>>>                amdgpu_ring_clear_ring(ring);
>>>        }
>>> @@ -4921,13 +4924,6 @@ static int gfx_v8_0_kiq_resume(struct
>>> amdgpu_device *adev)
>>>        /* Test KCQs */
>>>        for (i = 0; i < adev->gfx.num_compute_rings; i++) {
>>>                ring = &adev->gfx.compute_ring[i];
>>> -             if (adev->in_gpu_reset) {
>>> -                     /* move reset ring buffer to here to workaround
>>> -                      * compute ring test failed
>>> -                      */
>>> -                     ring->wptr = 0;
>>> -                     amdgpu_ring_clear_ring(ring);
>>> -             }
>>>                ring->ready = true;
>>>                r = amdgpu_ring_test_ring(ring);
>>>                if (r)
>>> --
>>> 2.7.4
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------603C4905D2764AEA48C9BAF0
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 01/25/2018 11:33 PM, Yu, Xiangliang
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:BY2PR1201MB09351A0D0D0D09849008B3B9EBE00-O28G1zQ8oGkaqtME6NEo1mrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org">
      <pre wrap="">You can add amdgpu_sriov_vf() check to avoid breaking sriov.</pre>
    </blockquote>
    <br>
    + Haisheng<br>
    <br>
    As found out after more debugging  and discussion with Haisheng from
    HW team, the sequence introduced by this change is is wrong, it
    causes compute rings test failure because "t<span
      style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">he
      ring buffer has to be filled with valid packets (such as NOPs)
      first before submitting MAP_QUEUEs packet into KIQ. Once a compute
      engine is mapped, it will immediately execute the ring buffer if
      the RTPR is not equal to the WTPR from the MQD. It could lead to
      engine hang if the ring buffer filled with random data."<br>
      <br>
    </span>Hence we would like to revert this change in
    amd-staging-drm-next and continue investigation on the SR-IOV side
    why the correct programming sequence doesn't work there. I myself
    currently working on setting up SR-IOV setup to take a look at that.<br>
    <br>
    Thanks,<br>
    Andrey<br>
      
    <blockquote type="cite"
cite="mid:BY2PR1201MB09351A0D0D0D09849008B3B9EBE00-O28G1zQ8oGkaqtME6NEo1mrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org">
      <pre wrap="">

</pre>
      <blockquote type="cite">
        <pre wrap="">-----Original Message-----
From: Grodzovsky, Andrey
Sent: Friday, January 26, 2018 11:29 AM
To: Yu, Xiangliang <a class="moz-txt-link-rfc2396E" href="mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org">&lt;Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;</a>; amd-
<a class="moz-txt-link-abbreviated" href="mailto:gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
Cc: Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>; Koenig, Christian
<a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>
Subject: Re: [PATCH] Revert "drm/amdgpu/gfx8: Fix compute ring failure
after resetting"

No, just bare metal, I assumed your problem was with compute ring test
failure which I didn't see. Can you please recheck if reverting this still failing
on SRIOV ?
If so we obviously need to keep looking how to fix it.

Thanks,
Andrey

________________________________________
From: Yu, Xiangliang
Sent: 25 January 2018 20:59:45
To: Grodzovsky, Andrey; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
Cc: Deucher, Alexander; Grodzovsky, Andrey; Koenig, Christian
Subject: RE: [PATCH] Revert "drm/amdgpu/gfx8: Fix compute ring failure
after resetting"

Did you test reset case in sriov?

</pre>
        <blockquote type="cite">
          <pre wrap="">-----Original Message-----
From: amd-gfx [<a class="moz-txt-link-freetext" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf
Of Andrey Grodzovsky
Sent: Friday, January 26, 2018 7:07 AM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
Cc: Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>; Grodzovsky,
</pre>
        </blockquote>
        <pre wrap="">Andrey
</pre>
        <blockquote type="cite">
          <pre wrap=""><a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org">&lt;Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a>; Yu, Xiangliang
</pre>
        </blockquote>
        <pre wrap=""><a class="moz-txt-link-rfc2396E" href="mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org">&lt;Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
</pre>
        <blockquote type="cite">
          <pre wrap="">Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>
Subject: [PATCH] Revert "drm/amdgpu/gfx8: Fix compute ring failure
after resetting"

This reverts commit 75737cb4eb78c7f185e4700b4aa20cf7a3381aca.

Fixes GFX ring test failure after HW reset.
No compute ring test failures were observed with the change reverted.
So seems like whatever problem that change was addressing is not
present anymore.

Signed-off-by: Andrey Grodzovsky <a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 1207f36..8a65b53 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4847,6 +4847,9 @@ static int gfx_v8_0_kcq_init_queue(struct
amdgpu_ring *ring)
              /* reset MQD to a clean status */
              if (adev-&gt;gfx.mec.mqd_backup[mqd_idx])
                      memcpy(mqd, adev-
</pre>
          <blockquote type="cite">
            <pre wrap="">gfx.mec.mqd_backup[mqd_idx], sizeof(struct vi_mqd_allocation));
</pre>
          </blockquote>
          <pre wrap="">+             /* reset ring buffer */
+             ring-&gt;wptr = 0;
+             amdgpu_ring_clear_ring(ring);
      } else {
              amdgpu_ring_clear_ring(ring);
      }
@@ -4921,13 +4924,6 @@ static int gfx_v8_0_kiq_resume(struct
amdgpu_device *adev)
      /* Test KCQs */
      for (i = 0; i &lt; adev-&gt;gfx.num_compute_rings; i++) {
              ring = &amp;adev-&gt;gfx.compute_ring[i];
-             if (adev-&gt;in_gpu_reset) {
-                     /* move reset ring buffer to here to workaround
-                      * compute ring test failed
-                      */
-                     ring-&gt;wptr = 0;
-                     amdgpu_ring_clear_ring(ring);
-             }
              ring-&gt;ready = true;
              r = amdgpu_ring_test_ring(ring);
              if (r)
--
2.7.4

_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
        </blockquote>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------603C4905D2764AEA48C9BAF0--

--===============0701305660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0701305660==--
