From: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm 2/2] libdrm: clean up non list code path for vamgr
Date: Mon, 26 Feb 2018 11:21:21 +0800
Message-ID: <0067f2cf-8202-4d5a-0237-4f3062611cf5@amd.com>
References: <20180112054554.19585-1-david1.zhou@amd.com>
 <20180112054554.19585-2-david1.zhou@amd.com>
 <e3722edc-8ca4-4730-d649-2b5a959b92c1@daenzer.net>
 <4a2036e5-820f-d62a-a773-2da1f575e1bc@amd.com>
 <c6b30b81-8b6f-3b5a-5654-e8075939143e@amd.com>
 <c7eaf026-f0f5-fab3-4bab-c11b39701e6a@daenzer.net>
 <881720e0-3225-dd36-23f7-146b9bfb919d@amd.com>
 <dcb5a4b1-f959-107b-d4af-18758fbf74cd@amd.com>
 <032f5418-4b01-f269-7e0a-5e1dcad65e10@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0773425592=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <032f5418-4b01-f269-7e0a-5e1dcad65e10-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Hui.Deng-5C7GfCeVMHo@public.gmane.org

--===============0773425592==
Content-Type: multipart/alternative;
	boundary="------------728BB9C244775424C09F4CBA"
Content-Language: en-US

--------------728BB9C244775424C09F4CBA
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for fix.


Regards,

David Zhou


On 2018年02月19日 15:50, Christian König wrote:
> Patch is Acked-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>
> Regards,
> Christian.
>
> Am 19.02.2018 um 08:25 schrieb Andrey Grodzovsky:
>> Found time to do some debugging and found error in assigning   of 
>> initial VA hole size, attached patch makes this issue go away, 
>> otherwise amdgpu_vamgr_find_va would always fail.
>>
>> Thanks,
>>
>> Andrey
>>
>>
>> On 02/18/2018 03:41 AM, Andrey Grodzovsky wrote:
>>> Hi David, I have an issue on Vega 10 where sudo xinit fails with
>>>
>>> [  5801.227] Failed to allocate front buffer memory
>>> [  5801.227] (EE) AMDGPU(0): amdgpu_setup_kernel_mem failed
>>> [  5801.227] (EE)
>>> Fatal server error:
>>> [  5801.227] (EE) AddScreen/ScreenInit failed for driver 0
>>> [  5801.227] (EE)
>>> [  5801.227] (EE)
>>>
>>> Also  in MESA code 
>>> si_create_context->si_common_context_init->pipe_buffer_create 
>>> returns NULL.
>>>
>>> Ellsmire works fine, on Vega 10 reverting this patch makes it work.
>>>
>>> I am during my test system upgrade right now with some more issues 
>>> after this one, so I can spend time on debugging this once my system 
>>> is in good shape, unless you have an answer to this problem right away.
>>>
>>> Thanks,
>>>
>>> Andrey
>>>
>>>
>>> On 02/09/2018 03:58 AM, Michel Dänzer wrote:
>>>> On 2018-02-09 07:01 AM, Chunming Zhou wrote:
>>>>> On 2018年02月08日 17:13, Chunming Zhou wrote:
>>>>>> On 2018年02月08日 17:01, Michel Dänzer wrote:
>>>>>>> this change completely broke radeonsi due to memory management 
>>>>>>> errors
>>>>>>> (see valgrind output for glxgears below), so I had to revert it.
>>>>>> ok, I will look into what happens. Sorry for broken.
>>>>> The patch lost a "goto out" in free_va when applying patch from 
>>>>> hybrid
>>>>> to opensource.
>>>>> The attached fixes that, I tested successfully in my local side.
>>>>>   please review or test, if no problem, I will submit it again.
>>>> Please add:
>>>>
>>>> v2: Add missing "goto out"
>>>> Tested-by: Michel Dänzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
>>>>
>>>> to the commit log before pushing.
>>>>
>>>>
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------728BB9C244775424C09F4CBA
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Thanks for fix.</p>
    <p><br>
    </p>
    <p>Regards,</p>
    <p>David Zhou<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2018年02月19日 15:50, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:032f5418-4b01-f269-7e0a-5e1dcad65e10-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div class="moz-cite-prefix">Patch is Acked-by: Christian König <a
          class="moz-txt-link-rfc2396E"
          href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
        <br>
        Regards,<br>
        Christian.<br>
        <br>
        Am 19.02.2018 um 08:25 schrieb Andrey Grodzovsky:<br>
      </div>
      <blockquote type="cite"
        cite="mid:dcb5a4b1-f959-107b-d4af-18758fbf74cd-5C7GfCeVMHo@public.gmane.org">Found
        time to do some debugging and found error in assigning   of
        initial VA hole size, attached patch makes this issue go away,
        otherwise amdgpu_vamgr_find_va would always fail. <br>
        <br>
        Thanks, <br>
        <br>
        Andrey <br>
        <br>
        <br>
        On 02/18/2018 03:41 AM, Andrey Grodzovsky wrote: <br>
        <blockquote type="cite">Hi David, I have an issue on Vega 10
          where sudo xinit fails with <br>
          <br>
          [  5801.227] Failed to allocate front buffer memory <br>
          [  5801.227] (EE) AMDGPU(0): amdgpu_setup_kernel_mem failed <br>
          [  5801.227] (EE) <br>
          Fatal server error: <br>
          [  5801.227] (EE) AddScreen/ScreenInit failed for driver 0 <br>
          [  5801.227] (EE) <br>
          [  5801.227] (EE) <br>
          <br>
          Also  in MESA code
          si_create_context-&gt;si_common_context_init-&gt;pipe_buffer_create
          returns NULL. <br>
          <br>
          Ellsmire works fine, on Vega 10 reverting this patch makes it
          work. <br>
          <br>
          I am during my test system upgrade right now with some more
          issues after this one, so I can spend time on debugging this
          once my system is in good shape, unless you have an answer to
          this problem right away. <br>
          <br>
          Thanks, <br>
          <br>
          Andrey <br>
          <br>
          <br>
          On 02/09/2018 03:58 AM, Michel Dänzer wrote: <br>
          <blockquote type="cite">On 2018-02-09 07:01 AM, Chunming Zhou
            wrote: <br>
            <blockquote type="cite">On 2018年02月08日 17:13, Chunming Zhou
              wrote: <br>
              <blockquote type="cite">On 2018年02月08日 17:01, Michel
                Dänzer wrote: <br>
                <blockquote type="cite">this change completely broke
                  radeonsi due to memory management errors <br>
                  (see valgrind output for glxgears below), so I had to
                  revert it. <br>
                </blockquote>
                ok, I will look into what happens. Sorry for broken. <br>
              </blockquote>
              The patch lost a "goto out" in free_va when applying patch
              from hybrid <br>
              to opensource. <br>
              The attached fixes that, I tested successfully in my local
              side. <br>
                please review or test, if no problem, I will submit it
              again. <br>
            </blockquote>
            Please add: <br>
            <br>
            v2: Add missing "goto out" <br>
            Tested-by: Michel Dänzer <a class="moz-txt-link-rfc2396E"
              href="mailto:michel.daenzer-5C7GfCeVMHo@public.gmane.org"
              moz-do-not-send="true">&lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;</a>
            <br>
            <br>
            to the commit log before pushing. <br>
            <br>
            <br>
          </blockquote>
          <br>
          _______________________________________________ <br>
          amd-gfx mailing list <br>
          <a class="moz-txt-link-abbreviated"
            href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
            moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a> <br>
          <a class="moz-txt-link-freetext"
            href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
            moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
          <br>
        </blockquote>
        <br>
        <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <br>
        <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------728BB9C244775424C09F4CBA--

--===============0773425592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0773425592==--
