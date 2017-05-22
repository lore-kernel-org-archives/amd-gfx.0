From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix ocl test performance drop
Date: Mon, 22 May 2017 08:47:33 +0200
Message-ID: <224eb1fa-6c8d-82a7-8b2a-dc65b2c66695@vodafone.de>
References: <1495093501-13313-1-git-send-email-Flora.Cui@amd.com>
 <4b2d410d-544f-4e72-11ae-8db4a1d797d3@vodafone.de>
 <20170519022518.GA24957@flora> <20170519033657.GB24957@flora>
 <591E7FA9.4070201@amd.com> <0246394a-ddbb-6478-b36f-8fb7e9213acb@vodafone.de>
 <20170522034224.GA27084@flora>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1271976067=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170522034224.GA27084@flora>
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
To: Flora Cui <flora.cui-5C7GfCeVMHo@public.gmane.org>
Cc: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============1271976067==
Content-Type: multipart/alternative;
 boundary="------------B68C359815AA6B3B6BF00A48"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------B68C359815AA6B3B6BF00A48
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

See my other comment about simplifying the patch in the other mail:
> [flora]: for compute ring & amdgpu_vm_ring_has_compute_vm_bug(), a 
> vm_flush is
> inserted. This might cause performance drop.
>
> Ah, I see. We only need the pipeline sync, but not the vm flush.
>
> In this case I suggest to just change the following line in 
> amdgpu_vm_flush():
>> -    bool vm_flush_needed = job->vm_needs_flush ||
>> -        amdgpu_vm_ring_has_compute_vm_bug(ring);
>
> We can keep it in amdgpu_vm_need_pipeline_sync().
With that done we can easily push it.

Christian.

Am 22.05.2017 um 05:42 schrieb Flora Cui:
> Could anyone give me a RB?
>
> On Fri, May 19, 2017 at 01:59:16PM +0200, Christian König wrote:
>> I'm pretty sure that bug is fixed in GFX9. So we don't need the check there
>> any more.
>>
>> Regards,
>> Christian.
>>
>> Am 19.05.2017 um 07:16 schrieb zhoucm1:
>>> I also realized this problem when I did fix for sched fence, I thought if
>>> no issue, just left it as current code, it's more safe.
>>> As Flora point it out, it results in performance drop, then we need to
>>> correct it back.
>>> pipeline_sync in vm flush should be inserted only when
>>> amdgpu_vm_ring_has_compute_vm_bug() is true, not all time for every vm
>>> flush for all engines. The bug has been fixed in mec firmware from version
>>> 673 in gfx8.
>>> About gfx9 for amdgpu_vm_ring_has_compute_vm_bug(), current implementation
>>> is thinking gfx9 doesn't have compute vm bug by default. Not sure it's in
>>> there. If no vm fault related to this bug, then we can think gfx9 has no
>>> compute vm bug, I believe firmware team does that based on previous
>>> generation, otherwise we need identify every generation, that's crazy.
>>>
>>> Regards,
>>> David Zhou
>>> On 2017年05月19日 11:36, Flora Cui wrote:
>>>> btw, what's about gfx9 for amdgpu_vm_ring_has_compute_vm_bug()? Is the
>>>> workaround still needed?
>>>>
>>>> On Fri, May 19, 2017 at 10:25:19AM +0800, Flora Cui wrote:
>>>>> On Thu, May 18, 2017 at 01:38:15PM +0200, Christian König wrote:
>>>>>> Am 18.05.2017 um 09:45 schrieb Flora Cui:
>>>>>>> partial revert commit <6971d3d> - drm/amdgpu: cleanup logic in
>>>>>>> amdgpu_vm_flush
>>>>>>>
>>>>>>> Change-Id: Iadce9d613dfe9a739643a74050cea55854832adb
>>>>>>> Signed-off-by: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
>>>>>> I don't see how the revert should be faster than the original.
>>>>>>
>>>>>> Especially that amdgpu_vm_had_gpu_reset() is now called twice sounds
>>>>>> like
>>>>>> more overhead than necessary.
>>>>>>
>>>>>> Please explain further.
>>>>>>
>>>>>> Christian.
>>>>>>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 14 +++++---------
>>>>>>>   1 file changed, 5 insertions(+), 9 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>>> index 88420dc..a96bad6 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>>> @@ -743,23 +743,19 @@ int amdgpu_vm_flush(struct amdgpu_ring
>>>>>>> *ring, struct amdgpu_job *job)
>>>>>>>           id->gws_size != job->gws_size ||
>>>>>>>           id->oa_base != job->oa_base ||
>>>>>>>           id->oa_size != job->oa_size);
>>>>>>> -    bool vm_flush_needed = job->vm_needs_flush ||
>>>>>>> -        amdgpu_vm_ring_has_compute_vm_bug(ring);
>>>>>>>       unsigned patch_offset = 0;
>>>>>>>       int r;
>>>>>>> -    if (amdgpu_vm_had_gpu_reset(adev, id)) {
>>>>>>> -        gds_switch_needed = true;
>>>>>>> -        vm_flush_needed = true;
>>>>>>> -    }
>>>>>>> -
>>>>>>> -    if (!vm_flush_needed && !gds_switch_needed)
>>>>>>> +    if (!job->vm_needs_flush && !gds_switch_needed &&
>>>>>>> +        !amdgpu_vm_had_gpu_reset(adev, id) &&
>>>>>>> +        !amdgpu_vm_ring_has_compute_vm_bug(ring))
>>>>>>>           return 0;
>>>>>>>       if (ring->funcs->init_cond_exec)
>>>>>>>           patch_offset = amdgpu_ring_init_cond_exec(ring);
>>>>>>> -    if (ring->funcs->emit_vm_flush && vm_flush_needed) {
>>>>> [flora]: for compute ring & amdgpu_vm_ring_has_compute_vm_bug(), a
>>>>> vm_flush is
>>>>> inserted. This might cause performance drop.
>>>>>>> +    if (ring->funcs->emit_vm_flush &&
>>>>>>> +        (job->vm_needs_flush || amdgpu_vm_had_gpu_reset(adev,
>>>>>>> id))) {
>>>>>>>           struct fence *fence;
>>>>>>>           trace_amdgpu_vm_flush(ring, job->vm_id, job->vm_pd_addr);
>>>>> _______________________________________________
>>>>> amd-gfx mailing list
>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>


--------------B68C359815AA6B3B6BF00A48
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">See my other comment about simplifying
      the patch in the other mail:<br>
      <blockquote type="cite">[flora]: for compute ring &amp;
        amdgpu_vm_ring_has_compute_vm_bug(), a vm_flush is
        <br>
        inserted. This might cause performance drop.
        <br>
        <br>
        Ah, I see. We only need the pipeline sync, but not the vm flush.
        <br>
        <br>
        In this case I suggest to just change the following line in
        amdgpu_vm_flush():
        <br>
        <blockquote type="cite" style="color: #000000;">-    bool
          vm_flush_needed = job-&gt;vm_needs_flush ||
          <br>
          -        amdgpu_vm_ring_has_compute_vm_bug(ring);
          <br>
        </blockquote>
        <br>
        We can keep it in amdgpu_vm_need_pipeline_sync().
        <br>
      </blockquote>
      With that done we can easily push it.<br>
      <br>
      Christian.<br>
      <br>
      Am 22.05.2017 um 05:42 schrieb Flora Cui:<br>
    </div>
    <blockquote type="cite" cite="mid:20170522034224.GA27084@flora">
      <pre wrap="">Could anyone give me a RB?

On Fri, May 19, 2017 at 01:59:16PM +0200, Christian König wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">I'm pretty sure that bug is fixed in GFX9. So we don't need the check there
any more.

Regards,
Christian.

Am 19.05.2017 um 07:16 schrieb zhoucm1:
</pre>
        <blockquote type="cite">
          <pre wrap="">I also realized this problem when I did fix for sched fence, I thought if
no issue, just left it as current code, it's more safe.
As Flora point it out, it results in performance drop, then we need to
correct it back.
pipeline_sync in vm flush should be inserted only when
amdgpu_vm_ring_has_compute_vm_bug() is true, not all time for every vm
flush for all engines. The bug has been fixed in mec firmware from version
673 in gfx8.
About gfx9 for amdgpu_vm_ring_has_compute_vm_bug(), current implementation
is thinking gfx9 doesn't have compute vm bug by default. Not sure it's in
there. If no vm fault related to this bug, then we can think gfx9 has no
compute vm bug, I believe firmware team does that based on previous
generation, otherwise we need identify every generation, that's crazy.

Regards,
David Zhou
On 2017年05月19日 11:36, Flora Cui wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="">btw, what's about gfx9 for amdgpu_vm_ring_has_compute_vm_bug()? Is the
workaround still needed?

On Fri, May 19, 2017 at 10:25:19AM +0800, Flora Cui wrote:
</pre>
            <blockquote type="cite">
              <pre wrap="">On Thu, May 18, 2017 at 01:38:15PM +0200, Christian König wrote:
</pre>
              <blockquote type="cite">
                <pre wrap="">Am 18.05.2017 um 09:45 schrieb Flora Cui:
</pre>
                <blockquote type="cite">
                  <pre wrap="">partial revert commit &lt;6971d3d&gt; - drm/amdgpu: cleanup logic in
amdgpu_vm_flush

Change-Id: Iadce9d613dfe9a739643a74050cea55854832adb
Signed-off-by: Flora Cui <a class="moz-txt-link-rfc2396E" href="mailto:Flora.Cui-5C7GfCeVMHo@public.gmane.org">&lt;Flora.Cui-5C7GfCeVMHo@public.gmane.org&gt;</a>
</pre>
                </blockquote>
                <pre wrap="">I don't see how the revert should be faster than the original.

Especially that amdgpu_vm_had_gpu_reset() is now called twice sounds
like
more overhead than necessary.

Please explain further.

Christian.

</pre>
                <blockquote type="cite">
                  <pre wrap="">---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 88420dc..a96bad6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -743,23 +743,19 @@ int amdgpu_vm_flush(struct amdgpu_ring
*ring, struct amdgpu_job *job)
         id-&gt;gws_size != job-&gt;gws_size ||
         id-&gt;oa_base != job-&gt;oa_base ||
         id-&gt;oa_size != job-&gt;oa_size);
-    bool vm_flush_needed = job-&gt;vm_needs_flush ||
-        amdgpu_vm_ring_has_compute_vm_bug(ring);
     unsigned patch_offset = 0;
     int r;
-    if (amdgpu_vm_had_gpu_reset(adev, id)) {
-        gds_switch_needed = true;
-        vm_flush_needed = true;
-    }
-
-    if (!vm_flush_needed &amp;&amp; !gds_switch_needed)
+    if (!job-&gt;vm_needs_flush &amp;&amp; !gds_switch_needed &amp;&amp;
+        !amdgpu_vm_had_gpu_reset(adev, id) &amp;&amp;
+        !amdgpu_vm_ring_has_compute_vm_bug(ring))
         return 0;
     if (ring-&gt;funcs-&gt;init_cond_exec)
         patch_offset = amdgpu_ring_init_cond_exec(ring);
-    if (ring-&gt;funcs-&gt;emit_vm_flush &amp;&amp; vm_flush_needed) {
</pre>
                </blockquote>
              </blockquote>
              <pre wrap="">[flora]: for compute ring &amp; amdgpu_vm_ring_has_compute_vm_bug(), a
vm_flush is
inserted. This might cause performance drop.
</pre>
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre wrap="">+    if (ring-&gt;funcs-&gt;emit_vm_flush &amp;&amp;
+        (job-&gt;vm_needs_flush || amdgpu_vm_had_gpu_reset(adev,
id))) {
         struct fence *fence;
         trace_amdgpu_vm_flush(ring, job-&gt;vm_id, job-&gt;vm_pd_addr);
</pre>
                </blockquote>
                <pre wrap="">
</pre>
              </blockquote>
              <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
            </blockquote>
            <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
          </blockquote>
          <pre wrap="">
_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
        </blockquote>
        <pre wrap="">

</pre>
      </blockquote>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------B68C359815AA6B3B6BF00A48--

--===============1271976067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1271976067==--
