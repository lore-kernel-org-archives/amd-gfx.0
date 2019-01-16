From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 1/2] drm/sched: Refactor ring mirror list handling.
Date: Wed, 16 Jan 2019 08:46:30 +0100
Message-ID: <cbacbef0-d82b-1f44-2fd4-87d81d7ce00b@gmail.com>
References: <1545333815-29870-1-git-send-email-andrey.grodzovsky@amd.com>
 <c62cf367-1485-b1f4-04c2-a11dd8f35416@gmail.com>
 <fc3e12f7-55e1-bf04-b190-7393e84d22a8@amd.com>
 <109f33b9-0a24-08e3-053d-57923b4d7e7f@amd.com>
 <642bdffd-afe9-1a58-4f32-9ef7a4cb22b7@amd.com>
 <c087d565-05d6-aa24-f3ac-9a6378d9ca1b@amd.com>
 <5e256bb1-d4aa-f965-2799-d68c9f925b66@gmail.com>
 <d5a3470a-21a1-adf7-6f85-4d22fae7bb81@amd.com>
 <6a2b45d7-0fa3-38fe-98b2-a538b663c6cc@gmail.com>
 <ea37c55f-ee56-cce7-a4e1-1a599642c54c@amd.com>
 <cbd07551-4f5e-fb80-a4ef-376b19bb3655@amd.com>
 <37ad8228-355e-1d53-593f-b0cb736eadff@amd.com>
 <5434e38b-c5c6-26e8-d632-bd1b1b52a44a@amd.com>
 <8a615696-a9ff-7670-5d25-6120282e818b@amd.com>
 <468f5a41-aa07-2cc2-d7dc-2f6e1d9af7e9@amd.com>
 <de7d180d-f959-d8a6-0f99-99906f07e76c@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0589185303=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <de7d180d-f959-d8a6-0f99-99906f07e76c-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org" <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "etnaviv-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <etnaviv-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0589185303==
Content-Type: multipart/alternative;
 boundary="------------4DFF6FD2A0C40E4C50DF2640"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------4DFF6FD2A0C40E4C50DF2640
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 15.01.19 um 23:01 schrieb Grodzovsky, Andrey:
>
> On 01/11/2019 05:03 PM, Andrey Grodzovsky wrote:
>>
>> On 01/11/2019 02:11 PM, Koenig, Christian wrote:
>>> Am 11.01.19 um 16:37 schrieb Grodzovsky, Andrey:
>>>> On 01/11/2019 04:42 AM, Koenig, Christian wrote:
>>>>> Am 10.01.19 um 16:56 schrieb Grodzovsky, Andrey:
>>>>>> [SNIP]
>>>>>>>>> But we will not be adding the cb back in drm_sched_stop
>>>>>>>>> anymore, now we
>>>>>>>>> are only going to add back the cb in drm_sched_startr after
>>>>>>>>> rerunning
>>>>>>>>> those jobs in drm_sched_resubmit_jobs and assign them a new parent
>>>>>>>>> there
>>>>>>>>> anyway.
>>>>>>>> Yeah, but when we find that we don't need to reset anything anymore
>>>>>>>> then adding the callbacks again won't be possible any more.
>>>>>>>>
>>>>>>>> Christian.
>>>>>>> I am not sure I understand it, can u point me to example of how this
>>>>>>> will happen ? I am attaching my latest patches with waiting only for
>>>>>>> the last job's fence here just so we are on same page regarding
>>>>>>> the code.
>>>>> Well the whole idea is to prepare all schedulers, then check once more
>>>>> if the offending job hasn't completed in the meantime.
>>>>>
>>>>> If the job completed we need to be able to rollback everything and
>>>>> continue as if nothing had happened.
>>>>>
>>>>> Christian.
>>>> Oh, but this piece of functionality - skipping HW ASIC reset in case
>>>> the
>>>> guilty job done is totally missing form this patch series and so needs
>>>> to be added. So what you say actually is that for the case were we skip
>>>> HW asic reset because the guilty job did complete we also need to skip
>>>> resubmitting the jobs in drm_sched_resubmit_jobs and hence preserve the
>>>> old parent fence pointer for reuse ? If so I would like to add all this
>>>> functionality as a third patch since the first 2 patches are more about
>>>> resolving race condition with jobs in flight while doing reset -
>>>> what do
>>>> you think ?
>>> Yeah, sounds perfectly fine to me.
>>>
>>> Christian.
>> I realized there is another complication now for XGMI hive use case,
>> we currently skip gpu recover for adev in case another gpu recover for
>> different adev in same hive is running, under the assumption that we
>> are going to reset all devices in hive anyway because that should
>> cover our own dev too. But if we chose to skip now HW asic reset if
>> our guilty job did finish we will aslo not HW reset any other devices
>> in the hive even if one of them might actually had a bad job, wanted
>> to do gpu recover but skipped it because our recover was in progress
>> in that time.
>> My general idea on that is to keep a list of guilty jobs per hive,
>> when you start gpu recover you first add you guilty job to the hive
>> and trylock hive->reset_lock. Any owner of hive->reset_lock (gpu
>> recovery in progress) once he finished his recovery and released
>> hive->reset_lock should go over hive->bad_jobs_list and if at least
>> one of them is still not signaled (not done) trigger another gpu
>> recovery and so on. If you do manage to trylock you also go over the
>> list, clean it and perform recovery. This list probably needs to be
>> protected with per hive lock.
>> I also think we can for now at least finish reviewing the first 2
>> patches and submit them since as I said before they are not dealing
>> with this topic and fixing existing race conditions. If you are OK
>> with that I can send for review the last iteration of the first 2
>> patches where I wait for the last fence in ring mirror list.
>>
>> Andrey
> I implemented HW reset avoidance including XGMI use case according to
> the plan i specified. Patch is attached but I can't test it yet due to
> XGMI regression in PSP which is supposed to be fixed soon. Please take a
> look.

Looks a bit too complicated on first glance. In general we should 
probably get away from handling a hive in any special way.

Multiple timeout jobs in a hive are identical to multiple timeout jobs 
on different engines on a single device.

How about the following handling:
1. Add the timeout job to a list.
2. Try to grab a lock to handle the reset, if that doesn't work because 
there is already a reset underway return immediately.
3. Stop all schedulers on all affected devices including stopping the 
timeouts and detaching all callbacks.
4. Double check the list of timed out jobs, if all hw fences of all jobs 
are completed now we actually don't need to do anything.
5. Do the reset on all affected devices.
6. Drop the lock.
7. Add callbacks again and restart the schedulers.

Regards,
Christian.

>
> Andrey
>
>>>> Andrey
>>>>>>> Andrey
>>>>>>>
>>>>> _______________________________________________
>>>>> amd-gfx mailing list
>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------4DFF6FD2A0C40E4C50DF2640
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 15.01.19 um 23:01 schrieb
      Grodzovsky, Andrey:<br>
    </div>
    <blockquote type="cite"
      cite="mid:de7d180d-f959-d8a6-0f99-99906f07e76c-5C7GfCeVMHo@public.gmane.org">
      <pre class="moz-quote-pre" wrap="">

On 01/11/2019 05:03 PM, Andrey Grodzovsky wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

On 01/11/2019 02:11 PM, Koenig, Christian wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Am 11.01.19 um 16:37 schrieb Grodzovsky, Andrey:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">On 01/11/2019 04:42 AM, Koenig, Christian wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Am 10.01.19 um 16:56 schrieb Grodzovsky, Andrey:
</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">[SNIP]
</pre>
                <blockquote type="cite">
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre class="moz-quote-pre" wrap="">But we will not be adding the cb back in drm_sched_stop 
anymore, now we
are only going to add back the cb in drm_sched_startr after 
rerunning
those jobs in drm_sched_resubmit_jobs and assign them a new parent
there
anyway.
</pre>
                    </blockquote>
                    <pre class="moz-quote-pre" wrap="">Yeah, but when we find that we don't need to reset anything anymore
then adding the callbacks again won't be possible any more.

Christian.
</pre>
                  </blockquote>
                  <pre class="moz-quote-pre" wrap="">I am not sure I understand it, can u point me to example of how this
will happen ? I am attaching my latest patches with waiting only for
the last job's fence here just so we are on same page regarding 
the code.
</pre>
                </blockquote>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">Well the whole idea is to prepare all schedulers, then check once more
if the offending job hasn't completed in the meantime.

If the job completed we need to be able to rollback everything and
continue as if nothing had happened.

Christian.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">Oh, but this piece of functionality - skipping HW ASIC reset in case 
the
guilty job done is totally missing form this patch series and so needs
to be added. So what you say actually is that for the case were we skip
HW asic reset because the guilty job did complete we also need to skip
resubmitting the jobs in drm_sched_resubmit_jobs and hence preserve the
old parent fence pointer for reuse ? If so I would like to add all this
functionality as a third patch since the first 2 patches are more about
resolving race condition with jobs in flight while doing reset - 
what do
you think ?
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Yeah, sounds perfectly fine to me.

Christian.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
I realized there is another complication now for XGMI hive use case, 
we currently skip gpu recover for adev in case another gpu recover for 
different adev in same hive is running, under the assumption that we 
are going to reset all devices in hive anyway because that should 
cover our own dev too. But if we chose to skip now HW asic reset if 
our guilty job did finish we will aslo not HW reset any other devices 
in the hive even if one of them might actually had a bad job, wanted 
to do gpu recover but skipped it because our recover was in progress 
in that time.
My general idea on that is to keep a list of guilty jobs per hive, 
when you start gpu recover you first add you guilty job to the hive 
and trylock hive-&gt;reset_lock. Any owner of hive-&gt;reset_lock (gpu 
recovery in progress) once he finished his recovery and released 
hive-&gt;reset_lock should go over hive-&gt;bad_jobs_list and if at least 
one of them is still not signaled (not done) trigger another gpu 
recovery and so on. If you do manage to trylock you also go over the 
list, clean it and perform recovery. This list probably needs to be 
protected with per hive lock.
I also think we can for now at least finish reviewing the first 2 
patches and submit them since as I said before they are not dealing 
with this topic and fixing existing race conditions. If you are OK 
with that I can send for review the last iteration of the first 2 
patches where I wait for the last fence in ring mirror list.

Andrey
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I implemented HW reset avoidance including XGMI use case according to 
the plan i specified. Patch is attached but I can't test it yet due to 
XGMI regression in PSP which is supposed to be fixed soon. Please take a 
look.</pre>
    </blockquote>
    <br>
    Looks a bit too complicated on first glance. In general we should
    probably get away from handling a hive in any special way.<br>
    <br>
    Multiple timeout jobs in a hive are identical to multiple timeout
    jobs on different engines on a single device.<br>
    <br>
    How about the following handling:<br>
    1. Add the timeout job to a list.<br>
    2. Try to grab a lock to handle the reset, if that doesn't work
    because there is already a reset underway return immediately.<br>
    3. Stop all schedulers on all affected devices including stopping
    the timeouts and detaching all callbacks.<br>
    4. Double check the list of timed out jobs, if all hw fences of all
    jobs are completed now we actually don't need to do anything.<br>
    5. Do the reset on all affected devices.<br>
    6. Drop the lock.<br>
    7. Add callbacks again and restart the schedulers.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:de7d180d-f959-d8a6-0f99-99906f07e76c-5C7GfCeVMHo@public.gmane.org">
      <pre class="moz-quote-pre" wrap="">

Andrey

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Andrey
</pre>
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre class="moz-quote-pre" wrap="">Andrey

</pre>
                </blockquote>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
            </blockquote>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------4DFF6FD2A0C40E4C50DF2640--

--===============0589185303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0589185303==--
