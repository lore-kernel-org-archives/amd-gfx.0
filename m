From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 00/11] add recovery entity and run queue
Date: Thu, 4 Aug 2016 10:44:51 +0800
Message-ID: <57A2AC23.7090709@amd.com>
References: <1470124302-23615-1-git-send-email-David1.Zhou@amd.com>
 <88bda920-4da2-7115-a82c-c0b1f581603e@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1934219539=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <88bda920-4da2-7115-a82c-c0b1f581603e-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1934219539==
Content-Type: multipart/alternative;
	boundary="------------000807090301010804040308"

--------------000807090301010804040308
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 2016年08月03日 20:16, Edward O'Callaghan wrote:
> Hi,
>
> I didn't see any of my previous review remarks on your previous
> submission addresses in this submission of this series?
Hi Edward,

Sorry for that. Since these patch sets are big feature change and we 
need to pin down the approach of the solution first. As you see, 
Christian has argued this solution and suggested another direction.
When we change the direction, the patches could be different totally. So 
I didn't address patch itself flaw. But indeed many thanks for your review.

Thanks,
David Zhou

>
> Kind Regards,
> Edward.
>
> On 08/02/2016 05:51 PM, Chunming Zhou wrote:
>> every vm has itself recovery entity, which is used to reovery page table from their shadow.
>> They don't need to wait front vm completed.
>> And also using all pte rings can speed reovery.
>>
>> every scheduler has its own recovery entity, which is used to save hw jobs, and resubmit from it, which solves the conflicts between reset thread and scheduler thread when run job.
>>
>> And some fixes when doing this improment.
>>
>> Chunming Zhou (11):
>>    drm/amdgpu: hw ring should be empty when gpu reset
>>    drm/amdgpu: specify entity to amdgpu_copy_buffer
>>    drm/amd: add recover run queue for scheduler
>>    drm/amdgpu: fix vm init error path
>>    drm/amdgpu: add vm recover entity
>>    drm/amdgpu: use all pte rings to recover page table
>>    drm/amd: add recover entity for every scheduler
>>    drm/amd: use scheduler to recover hw jobs
>>    drm/amd: hw job list should be exact
>>    drm/amd: reset jobs to recover entity
>>    drm/amdgpu: no need fence wait every time
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  35 +++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |  11 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_test.c      |   8 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   5 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  27 ++++--
>>   drivers/gpu/drm/amd/scheduler/gpu_scheduler.c | 129 +++++++++++++-------------
>>   drivers/gpu/drm/amd/scheduler/gpu_scheduler.h |   4 +-
>>   9 files changed, 135 insertions(+), 92 deletions(-)
>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------000807090301010804040308
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <div class="moz-cite-prefix">On 2016年08月03日 20:16, Edward
      O'Callaghan wrote:<br>
    </div>
    <blockquote
      cite="mid:88bda920-4da2-7115-a82c-c0b1f581603e-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org"
      type="cite">
      <pre wrap="">Hi,

I didn't see any of my previous review remarks on your previous
submission addresses in this submission of this series?</pre>
    </blockquote>
    Hi Edward,<br>
    <br>
    Sorry for that. Since these patch sets are big feature change and we
    need to pin down the approach of the solution first. As you see,
    Christian has argued this solution and suggested another direction.<br>
    When we change the direction, the patches could be different
    totally. So I didn't address patch itself flaw. But indeed many
    thanks for your review.<br>
    <br>
    Thanks,<br>
    David Zhou<br>
    <br>
    <blockquote
      cite="mid:88bda920-4da2-7115-a82c-c0b1f581603e-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org"
      type="cite">
      <pre wrap="">

Kind Regards,
Edward.

On 08/02/2016 05:51 PM, Chunming Zhou wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">every vm has itself recovery entity, which is used to reovery page table from their shadow.
They don't need to wait front vm completed.
And also using all pte rings can speed reovery.

every scheduler has its own recovery entity, which is used to save hw jobs, and resubmit from it, which solves the conflicts between reset thread and scheduler thread when run job.

And some fixes when doing this improment. 

Chunming Zhou (11):
  drm/amdgpu: hw ring should be empty when gpu reset
  drm/amdgpu: specify entity to amdgpu_copy_buffer
  drm/amd: add recover run queue for scheduler
  drm/amdgpu: fix vm init error path
  drm/amdgpu: add vm recover entity
  drm/amdgpu: use all pte rings to recover page table
  drm/amd: add recover entity for every scheduler
  drm/amd: use scheduler to recover hw jobs
  drm/amd: hw job list should be exact
  drm/amd: reset jobs to recover entity
  drm/amdgpu: no need fence wait every time

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  35 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |  11 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c      |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  27 ++++--
 drivers/gpu/drm/amd/scheduler/gpu_scheduler.c | 129 +++++++++++++-------------
 drivers/gpu/drm/amd/scheduler/gpu_scheduler.h |   4 +-
 9 files changed, 135 insertions(+), 92 deletions(-)

</pre>
      </blockquote>
      <pre wrap="">
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------000807090301010804040308--

--===============1934219539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1934219539==--
