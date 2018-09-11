From: James Zhu <jamesz-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu:No action needs when VCN PG state is unchanged
Date: Tue, 11 Sep 2018 11:06:35 -0400
Message-ID: <d358b2be-26d1-627a-7105-5d90685d0f3b@amd.com>
References: <1536598142-19689-1-git-send-email-James.Zhu@amd.com>
 <CADnq5_P5Oj_Fdxhv2n8ZxDTm1mV_NQo6M1kmgGzLV0fHhhR8sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0926310954=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_P5Oj_Fdxhv2n8ZxDTm1mV_NQo6M1kmgGzLV0fHhhR8sA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, James Zhu <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: James Zhu <james.zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0926310954==
Content-Type: multipart/alternative;
 boundary="------------6646AB5940399D6E6C7CF43F"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------6646AB5940399D6E6C7CF43F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2018-09-11 10:44 AM, Alex Deucher wrote:
> On Mon, Sep 10, 2018 at 4:34 PM James Zhu <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Signed-off-by: James Zhu <James.Zhu-5C7GfCeVMHo@public.gmane.org>
>>
>> When VCN PG state is unchanged, it is unnecessary to reset
>> power gate state again.
> Don't you need to initialize and store the PG state somewhere?  You
> are just using a local variable here.
>
> Alex
>
Hi Alex,

I used */static/* for this local state variable(*cur_state*) with 
initialization state AMD_PG_STATE_GATE.
this variable's scope is only inside this function, but it's 
initialization is done
once at compile time and it's lifetime will last until the driver exit.

Since it is only used inside this function, I didn't put it into struct 
amdgpu_vcn.

Best Regards!
James Zhu
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> index 2664bb2..86d98d2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> @@ -1633,12 +1633,21 @@ static int vcn_v1_0_set_powergating_state(void *handle,
>>           * revisit this when there is a cleaner line between
>>           * the smc and the hw blocks
>>           */
>> +       int ret;
>> +       static enum amd_powergating_state cur_state = AMD_PG_STATE_GATE;
>>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>
>> +       if (state == cur_state)
>> +               return 0;
>> +
>>          if (state == AMD_PG_STATE_GATE)
>> -               return vcn_v1_0_stop(adev);
>> +               ret = vcn_v1_0_stop(adev);
>>          else
>> -               return vcn_v1_0_start(adev);
>> +               ret = vcn_v1_0_start(adev);
>> +
>> +       if (!ret)
>> +               cur_state = state;
>> +       return ret;
>>   }
>>
>>   static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------6646AB5940399D6E6C7CF43F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2018-09-11 10:44 AM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CADnq5_P5Oj_Fdxhv2n8ZxDTm1mV_NQo6M1kmgGzLV0fHhhR8sA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <pre wrap="">On Mon, Sep 10, 2018 at 4:34 PM James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">
Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;James.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a>

When VCN PG state is unchanged, it is unnecessary to reset
power gate state again.
</pre>
      </blockquote>
      <pre wrap="">
Don't you need to initialize and store the PG state somewhere?  You
are just using a local variable here.

Alex

</pre>
    </blockquote>
    Hi Alex,<br>
    <br>
    I used <b><i>static</i></b> for this local state variable(<b>cur_state</b>)
    with initialization state AMD_PG_STATE_GATE.<br>
    this variable's scope is only inside this function, but it's
    initialization is done <br>
    once at compile time and it's lifetime will last until the driver
    exit.<br>
    <br>
    Since it is only used inside this function, I didn't put it into
    struct amdgpu_vcn.<br>
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
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------6646AB5940399D6E6C7CF43F--

--===============0926310954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0926310954==--
