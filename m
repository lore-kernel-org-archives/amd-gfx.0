From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu:No action needs when VCN PG state is unchanged
Date: Tue, 11 Sep 2018 17:36:33 +0200
Message-ID: <cbd39fc8-bd5e-cd11-b9f2-4b91185429f7@gmail.com>
References: <1536598142-19689-1-git-send-email-James.Zhu@amd.com>
 <CADnq5_P5Oj_Fdxhv2n8ZxDTm1mV_NQo6M1kmgGzLV0fHhhR8sA@mail.gmail.com>
 <d358b2be-26d1-627a-7105-5d90685d0f3b@amd.com>
 <68b30f71-86eb-89a0-0f8d-fcfb18e89cc2@gmail.com>
 <62baa235-e113-3635-6060-f5ffcc14e967@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2003749079=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <62baa235-e113-3635-6060-f5ffcc14e967-5C7GfCeVMHo@public.gmane.org>
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
To: James Zhu <jamesz-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, James Zhu <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: James Zhu <james.zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============2003749079==
Content-Type: multipart/alternative;
 boundary="------------F642F48C1F4E1BBD5FB73D7E"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------F642F48C1F4E1BBD5FB73D7E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 11.09.2018 um 17:29 schrieb James Zhu:
>
>
>
> On 2018-09-11 11:17 AM, Christian König wrote:
>> Am 11.09.2018 um 17:06 schrieb James Zhu:
>>>
>>>
>>>
>>> On 2018-09-11 10:44 AM, Alex Deucher wrote:
>>>> On Mon, Sep 10, 2018 at 4:34 PM James Zhu<jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>  wrote:
>>>>> Signed-off-by: James Zhu<James.Zhu-5C7GfCeVMHo@public.gmane.org>
>>>>>
>>>>> When VCN PG state is unchanged, it is unnecessary to reset
>>>>> power gate state again.
>>>> Don't you need to initialize and store the PG state somewhere?  You
>>>> are just using a local variable here.
>>>>
>>>> Alex
>>>>
>>> Hi Alex,
>>>
>>> I used */static/* for this local state variable(*cur_state*) with 
>>> initialization state AMD_PG_STATE_GATE.
>>
>> That won't work correctly. A "static" variable is global, but the 
>> power state is per device.
>>
>> Regards,
>> Christian.
>>
> This "static" variable under local scope is mainly for VCN used only. 
> It only tracks VCN's PG state.
> (currently VCN only have one hardware instance)

Still an absolute no-go for kernel coding. VCN will soon be used for 
dGPUs as well.

Please fix and reiterate,
Christian.

>
> Best Regards!
> James Zhu
>>> this variable's scope is only inside this function, but it's 
>>> initialization is done
>>> once at compile time and it's lifetime will last until the driver exit.
>>>
>>> Since it is only used inside this function, I didn't put it into 
>>> struct amdgpu_vcn.
>>>
>>> Best Regards!
>>> James Zhu
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 13 +++++++++++--
>>>>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>> index 2664bb2..86d98d2 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>> @@ -1633,12 +1633,21 @@ static int vcn_v1_0_set_powergating_state(void *handle,
>>>>>           * revisit this when there is a cleaner line between
>>>>>           * the smc and the hw blocks
>>>>>           */
>>>>> +       int ret;
>>>>> +       static enum amd_powergating_state cur_state = AMD_PG_STATE_GATE;
>>>>>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>
>>>>> +       if (state == cur_state)
>>>>> +               return 0;
>>>>> +
>>>>>          if (state == AMD_PG_STATE_GATE)
>>>>> -               return vcn_v1_0_stop(adev);
>>>>> +               ret = vcn_v1_0_stop(adev);
>>>>>          else
>>>>> -               return vcn_v1_0_start(adev);
>>>>> +               ret = vcn_v1_0_start(adev);
>>>>> +
>>>>> +       if (!ret)
>>>>> +               cur_state = state;
>>>>> +       return ret;
>>>>>   }
>>>>>
>>>>>   static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
>>>>> --
>>>>> 2.7.4
>>>>>
>>>>> _______________________________________________
>>>>> amd-gfx mailing list
>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>
>>>
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------F642F48C1F4E1BBD5FB73D7E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 11.09.2018 um 17:29 schrieb James
      Zhu:<br>
    </div>
    <blockquote type="cite"
      cite="mid:62baa235-e113-3635-6060-f5ffcc14e967-5C7GfCeVMHo@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <p><br>
      </p>
      <br>
      <div class="moz-cite-prefix">On 2018-09-11 11:17 AM, Christian
        König wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:68b30f71-86eb-89a0-0f8d-fcfb18e89cc2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
        <meta http-equiv="Content-Type" content="text/html;
          charset=utf-8">
        <div class="moz-cite-prefix">Am 11.09.2018 um 17:06 schrieb
          James Zhu:<br>
        </div>
        <blockquote type="cite"
          cite="mid:d358b2be-26d1-627a-7105-5d90685d0f3b-5C7GfCeVMHo@public.gmane.org">
          <p><br>
          </p>
          <br>
          <div class="moz-cite-prefix">On 2018-09-11 10:44 AM, Alex
            Deucher wrote:<br>
          </div>
          <blockquote type="cite"
cite="mid:CADnq5_P5Oj_Fdxhv2n8ZxDTm1mV_NQo6M1kmgGzLV0fHhhR8sA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
            <pre wrap="">On Mon, Sep 10, 2018 at 4:34 PM James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" moz-do-not-send="true">&lt;jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a> wrote:
</pre>
            <blockquote type="cite">
              <pre wrap="">Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;James.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a>

When VCN PG state is unchanged, it is unnecessary to reset
power gate state again.
</pre>
            </blockquote>
            <pre wrap="">Don't you need to initialize and store the PG state somewhere?  You
are just using a local variable here.

Alex

</pre>
          </blockquote>
          Hi Alex,<br>
          <br>
          I used <b><i>static</i></b> for this local state variable(<b>cur_state</b>)
          with initialization state AMD_PG_STATE_GATE.<br>
        </blockquote>
        <br>
        That won't work correctly. A "static" variable is global, but
        the power state is per device.<br>
        <br>
        Regards,<br>
        Christian.<br>
        <br>
      </blockquote>
      This "static" variable under local scope is mainly for VCN used
      only. It only tracks VCN's PG state.<br>
      (currently VCN only have one hardware instance)<br>
    </blockquote>
    <br>
    Still an absolute no-go for kernel coding. VCN will soon be used for
    dGPUs as well.<br>
    <br>
    Please fix and reiterate,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:62baa235-e113-3635-6060-f5ffcc14e967-5C7GfCeVMHo@public.gmane.org"> <br>
      Best Regards!<br>
      James Zhu<br>
      <blockquote type="cite"
        cite="mid:68b30f71-86eb-89a0-0f8d-fcfb18e89cc2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
        <blockquote type="cite"
          cite="mid:d358b2be-26d1-627a-7105-5d90685d0f3b-5C7GfCeVMHo@public.gmane.org"> this
          variable's scope is only inside this function, but it's
          initialization is done <br>
          once at compile time and it's lifetime will last until the
          driver exit.<br>
          <br>
          Since it is only used inside this function, I didn't put it
          into struct amdgpu_vcn.<br>
          <br>
          Best Regards!<br>
          James Zhu<br>
          <blockquote type="cite"
cite="mid:CADnq5_P5Oj_Fdxhv2n8ZxDTm1mV_NQo6M1kmgGzLV0fHhhR8sA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
            <blockquote type="cite">
              <pre wrap="">---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 2664bb2..86d98d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1633,12 +1633,21 @@ static int vcn_v1_0_set_powergating_state(void *handle,
         * revisit this when there is a cleaner line between
         * the smc and the hw blocks
         */
+       int ret;
+       static enum amd_powergating_state cur_state = AMD_PG_STATE_GATE;
        struct amdgpu_device *adev = (struct amdgpu_device *)handle;

+       if (state == cur_state)
+               return 0;
+
        if (state == AMD_PG_STATE_GATE)
-               return vcn_v1_0_stop(adev);
+               ret = vcn_v1_0_stop(adev);
        else
-               return vcn_v1_0_start(adev);
+               ret = vcn_v1_0_start(adev);
+
+       if (!ret)
+               cur_state = state;
+       return ret;
 }

 static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
--
2.7.4

_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
            </blockquote>
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

--------------F642F48C1F4E1BBD5FB73D7E--

--===============2003749079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2003749079==--
