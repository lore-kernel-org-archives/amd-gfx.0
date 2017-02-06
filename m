From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 13/13] drm/amdgpu: new queue policy, take first 2 queues
 of each pipe
Date: Mon, 6 Feb 2017 09:35:24 +0100
Message-ID: <43d676af-fdb7-80ed-e5ef-c365d8938097@vodafone.de>
References: <20170204045142.5596-1-andresx7@gmail.com>
 <20170204045142.5596-14-andresx7@gmail.com>
 <86138a88-e90f-3234-7109-67ca0c427071@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0942345808=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <86138a88-e90f-3234-7109-67ca0c427071-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, jay-gJmSnxjMpeIFV7jr3Ov9Ew@public.gmane.org, Felix.Kuehling-5C7GfCeVMHo@public.gmane.org, John.Bridgman-5C7GfCeVMHo@public.gmane.org

This is a multi-part message in MIME format.
--===============0942345808==
Content-Type: multipart/alternative;
 boundary="------------C892667A6C955CDE5E93275E"

This is a multi-part message in MIME format.
--------------C892667A6C955CDE5E93275E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Indeed a very nice set, only briefly looked over it and only found a 
small issue on patch #2.

Apart from that the set is Acked-by: Christian König 
<christian.koenig-5C7GfCeVMHo@public.gmane.org>.

Regards,
Christian.

Am 04.02.2017 um 13:08 schrieb Edward O'Callaghan:
> This series is,
> Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
>
> On 02/04/2017 03:51 PM, Andres Rodriguez wrote:
>> Instead of taking the first pipe and givint the rest to kfd, take the
> s/givint/giving/
>
>> first 2 queues of each pipe.
>>
>> Effectively, amdgpu and amdkfd own the same number of queues. But
>> because the queues are spread over multiple pipes the hardware will be
>> able to better handle concurrent compute workloads.
>>
>> amdgpu goes from 1 pipe to 4 pipes, i.e. from 1 compute threads to 4
>> amdkfd goes from 3 pipe to 4 pipes, i.e. from 3 compute threads to 4
>>
>> Signed-off-by: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> index 2218b65..da28174 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> @@ -2810,7 +2810,7 @@ static void gfx_v7_0_compute_queue_acquire(struct amdgpu_device *adev)
>>   			break;
>>   
>>   		/* policy: amdgpu owns all queues in the first pipe */
>> -		if (mec == 0 && pipe == 0)
>> +		if (mec == 0 && queue < 2)
>>   			set_bit(i, adev->gfx.mec.queue_bitmap);
>>   	}
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> index 04b4448..0a16cab 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> @@ -1436,7 +1436,7 @@ static void gfx_v8_0_compute_queue_acquire(struct amdgpu_device *adev)
>>   			break;
>>   
>>   		/* policy: amdgpu owns all queues in the first pipe */
>> -		if (mec == 0 && pipe == 0)
>> +		if (mec == 0 && queue < 2)
>>   			set_bit(i, adev->gfx.mec.queue_bitmap);
>>   	}
>>   
>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------C892667A6C955CDE5E93275E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Indeed a very nice set, only briefly
      looked over it and only found a small issue on patch #2.<br>
      <br>
      Apart from that the set is Acked-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 04.02.2017 um 13:08 schrieb Edward O'Callaghan:<br>
    </div>
    <blockquote
      cite="mid:86138a88-e90f-3234-7109-67ca0c427071-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org"
      type="cite">
      <pre wrap="">This series is,
Reviewed-by: Edward O'Callaghan <a class="moz-txt-link-rfc2396E" href="mailto:funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org">&lt;funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org&gt;</a>

On 02/04/2017 03:51 PM, Andres Rodriguez wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Instead of taking the first pipe and givint the rest to kfd, take the
</pre>
      </blockquote>
      <pre wrap="">
s/givint/giving/

</pre>
      <blockquote type="cite">
        <pre wrap="">first 2 queues of each pipe.

Effectively, amdgpu and amdkfd own the same number of queues. But
because the queues are spread over multiple pipes the hardware will be
able to better handle concurrent compute workloads.

amdgpu goes from 1 pipe to 4 pipes, i.e. from 1 compute threads to 4
amdkfd goes from 3 pipe to 4 pipes, i.e. from 3 compute threads to 4

Signed-off-by: Andres Rodriguez <a class="moz-txt-link-rfc2396E" href="mailto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 2218b65..da28174 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2810,7 +2810,7 @@ static void gfx_v7_0_compute_queue_acquire(struct amdgpu_device *adev)
 			break;
 
 		/* policy: amdgpu owns all queues in the first pipe */
-		if (mec == 0 &amp;&amp; pipe == 0)
+		if (mec == 0 &amp;&amp; queue &lt; 2)
 			set_bit(i, adev-&gt;gfx.mec.queue_bitmap);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 04b4448..0a16cab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1436,7 +1436,7 @@ static void gfx_v8_0_compute_queue_acquire(struct amdgpu_device *adev)
 			break;
 
 		/* policy: amdgpu owns all queues in the first pipe */
-		if (mec == 0 &amp;&amp; pipe == 0)
+		if (mec == 0 &amp;&amp; queue &lt; 2)
 			set_bit(i, adev-&gt;gfx.mec.queue_bitmap);
 	}
 

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
    <p><br>
    </p>
  </body>
</html>

--------------C892667A6C955CDE5E93275E--

--===============0942345808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0942345808==--
