From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH v5 1/2] drm/sched: Refactor ring mirror list handling.
Date: Thu, 17 Jan 2019 08:45:50 +0100
Message-ID: <99f813cf-ae28-58c7-8b98-1ff69cecbed6@gmail.com>
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
 <cbacbef0-d82b-1f44-2fd4-87d81d7ce00b@gmail.com>
 <0622c5b7-b54a-c414-c8db-26e1ec3c5ab8@amd.com>
 <4c43b728-628d-6880-edad-0e5fdb084f06@amd.com>
 <6d8adac2-b5ab-991f-571d-771b973362a3@amd.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0972608185=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <6d8adac2-b5ab-991f-571d-771b973362a3@amd.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "eric@anholt.net" <eric@anholt.net>, "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>
Cc: "Liu, Monk" <Monk.Liu@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--===============0972608185==
Content-Type: multipart/alternative;
 boundary="------------D1C811DEE6BD2CF613269AA2"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------D1C811DEE6BD2CF613269AA2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.01.19 um 18:17 schrieb Grodzovsky, Andrey:
>
>
>
> On 01/16/2019 11:02 AM, Koenig, Christian wrote:
>> Am 16.01.19 um 16:45 schrieb Grodzovsky, Andrey:
>>>
>>>
>>>
>>> On 01/16/2019 02:46 AM, Christian König wrote:
>>>> Am 15.01.19 um 23:01 schrieb Grodzovsky, Andrey:
>>>>> On 01/11/2019 05:03 PM, Andrey Grodzovsky wrote:
>>>>>> On 01/11/2019 02:11 PM, Koenig, Christian wrote:
>>>>>>> Am 11.01.19 um 16:37 schrieb Grodzovsky, Andrey:
>>>>>>>> On 01/11/2019 04:42 AM, Koenig, Christian wrote:
>>>>>>>>> Am 10.01.19 um 16:56 schrieb Grodzovsky, Andrey:
>>>>>>>>>> [SNIP]
>>>>>>>>>>>>> But we will not be adding the cb back in drm_sched_stop
>>>>>>>>>>>>> anymore, now we
>>>>>>>>>>>>> are only going to add back the cb in drm_sched_startr after
>>>>>>>>>>>>> rerunning
>>>>>>>>>>>>> those jobs in drm_sched_resubmit_jobs and assign them a new parent
>>>>>>>>>>>>> there
>>>>>>>>>>>>> anyway.
>>>>>>>>>>>> Yeah, but when we find that we don't need to reset anything anymore
>>>>>>>>>>>> then adding the callbacks again won't be possible any more.
>>>>>>>>>>>>
>>>>>>>>>>>> Christian.
>>>>>>>>>>> I am not sure I understand it, can u point me to example of how this
>>>>>>>>>>> will happen ? I am attaching my latest patches with waiting only for
>>>>>>>>>>> the last job's fence here just so we are on same page regarding
>>>>>>>>>>> the code.
>>>>>>>>> Well the whole idea is to prepare all schedulers, then check once more
>>>>>>>>> if the offending job hasn't completed in the meantime.
>>>>>>>>>
>>>>>>>>> If the job completed we need to be able to rollback everything and
>>>>>>>>> continue as if nothing had happened.
>>>>>>>>>
>>>>>>>>> Christian.
>>>>>>>> Oh, but this piece of functionality - skipping HW ASIC reset in case
>>>>>>>> the
>>>>>>>> guilty job done is totally missing form this patch series and so needs
>>>>>>>> to be added. So what you say actually is that for the case were we skip
>>>>>>>> HW asic reset because the guilty job did complete we also need to skip
>>>>>>>> resubmitting the jobs in drm_sched_resubmit_jobs and hence preserve the
>>>>>>>> old parent fence pointer for reuse ? If so I would like to add all this
>>>>>>>> functionality as a third patch since the first 2 patches are more about
>>>>>>>> resolving race condition with jobs in flight while doing reset -
>>>>>>>> what do
>>>>>>>> you think ?
>>>>>>> Yeah, sounds perfectly fine to me.
>>>>>>>
>>>>>>> Christian.
>>>>>> I realized there is another complication now for XGMI hive use case,
>>>>>> we currently skip gpu recover for adev in case another gpu recover for
>>>>>> different adev in same hive is running, under the assumption that we
>>>>>> are going to reset all devices in hive anyway because that should
>>>>>> cover our own dev too. But if we chose to skip now HW asic reset if
>>>>>> our guilty job did finish we will aslo not HW reset any other devices
>>>>>> in the hive even if one of them might actually had a bad job, wanted
>>>>>> to do gpu recover but skipped it because our recover was in progress
>>>>>> in that time.
>>>>>> My general idea on that is to keep a list of guilty jobs per hive,
>>>>>> when you start gpu recover you first add you guilty job to the hive
>>>>>> and trylock hive->reset_lock. Any owner of hive->reset_lock (gpu
>>>>>> recovery in progress) once he finished his recovery and released
>>>>>> hive->reset_lock should go over hive->bad_jobs_list and if at least
>>>>>> one of them is still not signaled (not done) trigger another gpu
>>>>>> recovery and so on. If you do manage to trylock you also go over the
>>>>>> list, clean it and perform recovery. This list probably needs to be
>>>>>> protected with per hive lock.
>>>>>> I also think we can for now at least finish reviewing the first 2
>>>>>> patches and submit them since as I said before they are not dealing
>>>>>> with this topic and fixing existing race conditions. If you are OK
>>>>>> with that I can send for review the last iteration of the first 2
>>>>>> patches where I wait for the last fence in ring mirror list.
>>>>>>
>>>>>> Andrey
>>>>> I implemented HW reset avoidance including XGMI use case according to
>>>>> the plan i specified. Patch is attached but I can't test it yet due to
>>>>> XGMI regression in PSP which is supposed to be fixed soon. Please take a
>>>>> look.
>>>>
>>>> Looks a bit too complicated on first glance. In general we should 
>>>> probably get away from handling a hive in any special way.
>>>
>>> Yes, I guess i can do it the same way as the generic handling in 
>>> amdgpu_device_gpu_recover - there is a list of devices to process 
>>> which is of size 1 for non xgmi use case or more then 1 for XGMI.
>>>
>>>>
>>>> Multiple timeout jobs in a hive are identical to multiple timeout 
>>>> jobs on different engines on a single device.
>>>>
>>>> How about the following handling:
>>>> 1. Add the timeout job to a list.
>>>> 2. Try to grab a lock to handle the reset, if that doesn't work 
>>>> because there is already a reset underway return immediately.
>>>> 3. Stop all schedulers on all affected devices including stopping 
>>>> the timeouts and detaching all callbacks.
>>>> 4. Double check the list of timed out jobs, if all hw fences of all 
>>>> jobs are completed now we actually don't need to do anything.
>>>
>>> What if all the jobs on the timed out list did complete but other 
>>> job (or jobs) for which we removed the time out timer became hanged 
>>> ? Wouldn't we  miss a required reset in this case and wouldn't even 
>>> have any indication of their hang ?
>>
>> If the timeout triggers before we disable it we will have the job on 
>> the list of jobs which are hanging.
>>
>> If we found that we don't reset and re-enable the timeout it will 
>> trigger a bit later and we can do the check again.
>>
>> Thinking about this a bit more we actually don't need to change the 
>> handling in any way. The idea with the list is just overkill.
>>
>> See when the we re-start the scheduler we will also re-arm the 
>> timeout, so it will trigger again. It is just a matter of clever 
>> timeout re-arming.
>>
>> Christian.
>
> This implies that hanged job might take in worst case twice (or more 
> if there are recurrent resets) then the TO parameter value to trigger 
> - is this OK ?

Re-arming the timeout should probably have a much reduced value when the 
job hasn't changed. E.g. something like a few ms.

> About flushing tdr jobs in progress from .free_job cb - looks like 
> drm_sched_job_finish->cancel_delayed_work_sync is not enough, we still 
> need to take care of flushing all sced->work_tdr for a device and for 
> all devices in hive for XGMI.
> What do you think ?

Why should that be necessary? We only wait for the delayed work to make 
sure that the job is not destroyed while dealing with it.

Christian.

>
> Andrey
>
>>
>>>
>>>> 5. Do the reset on all affected devices.
>>>> 6. Drop the lock.
>>>> 7. Add callbacks again and restart the schedulers.
>>>
>>> I see your steps don't include flushing any tdr in progress from 
>>> drm_sched_job_finish (or as I did it from amdgpu_job_free_cb) does 
>>> it mean you don't think we need to flush in order to avoid freeing 
>>> job while it still might be accessed from time out  list ?
>>>
>>> Andrey
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Andrey
>>>>>
>>>>>>>> Andrey
>>>>>>>>>>> Andrey
>>>>>>>>>>>
>>>>>>>>> _______________________________________________
>>>>>>>>> amd-gfx mailing list
>>>>>>>>> amd-gfx@lists.freedesktop.org
>>>>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>>>> _______________________________________________
>>>>>>> amd-gfx mailing list
>>>>>>> amd-gfx@lists.freedesktop.org
>>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>>
>>>>> _______________________________________________
>>>>> amd-gfx mailing list
>>>>> amd-gfx@lists.freedesktop.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>
>>>
>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------D1C811DEE6BD2CF613269AA2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 16.01.19 um 18:17 schrieb
      Grodzovsky, Andrey:<br>
    </div>
    <blockquote type="cite"
      cite="mid:6d8adac2-b5ab-991f-571d-771b973362a3@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p><br>
      </p>
      <br>
      <div class="moz-cite-prefix">On 01/16/2019 11:02 AM, Koenig,
        Christian wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:4c43b728-628d-6880-edad-0e5fdb084f06@amd.com">
        <div class="moz-cite-prefix">Am 16.01.19 um 16:45 schrieb
          Grodzovsky, Andrey:<br>
        </div>
        <blockquote type="cite"
          cite="mid:0622c5b7-b54a-c414-c8db-26e1ec3c5ab8@amd.com">
          <p><br>
          </p>
          <br>
          <div class="moz-cite-prefix">On 01/16/2019 02:46 AM, Christian
            König wrote:<br>
          </div>
          <blockquote type="cite"
            cite="mid:cbacbef0-d82b-1f44-2fd4-87d81d7ce00b@gmail.com">
            <div class="moz-cite-prefix">Am 15.01.19 um 23:01 schrieb
              Grodzovsky, Andrey:<br>
            </div>
            <blockquote type="cite"
              cite="mid:de7d180d-f959-d8a6-0f99-99906f07e76c@amd.com">
              <pre class="moz-quote-pre" wrap="">On 01/11/2019 05:03 PM, Andrey Grodzovsky wrote:
</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">On 01/11/2019 02:11 PM, Koenig, Christian wrote:
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
                <pre class="moz-quote-pre" wrap="">I realized there is another complication now for XGMI hive use case, 
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
              <pre class="moz-quote-pre" wrap="">I implemented HW reset avoidance including XGMI use case according to 
the plan i specified. Patch is attached but I can't test it yet due to 
XGMI regression in PSP which is supposed to be fixed soon. Please take a 
look.</pre>
            </blockquote>
            <br>
            Looks a bit too complicated on first glance. In general we
            should probably get away from handling a hive in any special
            way.<br>
          </blockquote>
          <br>
          Yes, I guess i can do it the same way as the generic handling
          in amdgpu_device_gpu_recover - there is a list of devices to
          process which is of size 1 for non xgmi use case or more then
          1 for XGMI.<br>
          <br>
          <blockquote type="cite"
            cite="mid:cbacbef0-d82b-1f44-2fd4-87d81d7ce00b@gmail.com">
            <br>
            Multiple timeout jobs in a hive are identical to multiple
            timeout jobs on different engines on a single device.<br>
            <br>
            How about the following handling:<br>
            1. Add the timeout job to a list.<br>
            2. Try to grab a lock to handle the reset, if that doesn't
            work because there is already a reset underway return
            immediately.<br>
            3. Stop all schedulers on all affected devices including
            stopping the timeouts and detaching all callbacks.<br>
            4. Double check the list of timed out jobs, if all hw fences
            of all jobs are completed now we actually don't need to do
            anything.<br>
          </blockquote>
          <br>
          What if all the jobs on the timed out list did complete but
          other job (or jobs) for which we removed the time out timer
          became hanged ? Wouldn't we  miss a required reset in this
          case and wouldn't even have any indication of their hang ?<br>
        </blockquote>
        <br>
        If the timeout triggers before we disable it we will have the
        job on the list of jobs which are hanging.<br>
        <br>
        If we found that we don't reset and re-enable the timeout it
        will trigger a bit later and we can do the check again.<br>
        <br>
        Thinking about this a bit more we actually don't need to change
        the handling in any way. The idea with the list is just
        overkill.<br>
        <br>
        See when the we re-start the scheduler we will also re-arm the
        timeout, so it will trigger again. It is just a matter of clever
        timeout re-arming.<br>
        <br>
        Christian.<br>
      </blockquote>
      <br>
      This implies that hanged job might take in worst case twice (or
      more if there are recurrent resets) then the TO parameter value to
      trigger - is this OK ?<br>
    </blockquote>
    <br>
    Re-arming the timeout should probably have a much reduced value when
    the job hasn't changed. E.g. something like a few ms.<br>
    <br>
    <blockquote type="cite"
      cite="mid:6d8adac2-b5ab-991f-571d-771b973362a3@amd.com">
      About flushing tdr jobs in progress from .free_job cb - looks like
      drm_sched_job_finish-&gt;cancel_delayed_work_sync is not enough,
      we still need to take care of flushing all sced-&gt;work_tdr for a
      device and for all devices in hive for XGMI.<br>
      What do you think ?<br>
    </blockquote>
    <br>
    Why should that be necessary? We only wait for the delayed work to
    make sure that the job is not destroyed while dealing with it.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:6d8adac2-b5ab-991f-571d-771b973362a3@amd.com">
      <br>
      Andrey<br>
      <br>
      <blockquote type="cite"
        cite="mid:4c43b728-628d-6880-edad-0e5fdb084f06@amd.com"><br>
        <blockquote type="cite"
          cite="mid:0622c5b7-b54a-c414-c8db-26e1ec3c5ab8@amd.com"> <br>
          <blockquote type="cite"
            cite="mid:cbacbef0-d82b-1f44-2fd4-87d81d7ce00b@gmail.com">
            5. Do the reset on all affected devices.<br>
            6. Drop the lock.<br>
            7. Add callbacks again and restart the schedulers.<br>
          </blockquote>
          <br>
          I see your steps don't include flushing any tdr in progress
          from drm_sched_job_finish (or as I did it from
          amdgpu_job_free_cb) does it mean you don't think we need to
          flush in order to avoid freeing job while it still might be
          accessed from time out  list ?<br>
          <br>
          Andrey<br>
          <br>
          <blockquote type="cite"
            cite="mid:cbacbef0-d82b-1f44-2fd4-87d81d7ce00b@gmail.com">
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            <blockquote type="cite"
              cite="mid:de7d180d-f959-d8a6-0f99-99906f07e76c@amd.com">
              <pre class="moz-quote-pre" wrap="">Andrey

</pre>
              <blockquote type="cite">
                <blockquote type="cite">
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
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                    </blockquote>
                  </blockquote>
                  <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                </blockquote>
              </blockquote>
              <br>
              <fieldset class="mimeAttachmentHeader"></fieldset>
              <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
            </blockquote>
            <br>
          </blockquote>
          <br>
        </blockquote>
        <br>
      </blockquote>
      <br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------D1C811DEE6BD2CF613269AA2--

--===============0972608185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0972608185==--
