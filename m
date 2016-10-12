From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 5/6] drm/amdgpu/powerplay: add an implementation for
 get_vce_clock_table
Date: Wed, 12 Oct 2016 10:53:16 +0200
Message-ID: <e8cdcd80-3df3-940f-32b5-9116e5d15fa6@vodafone.de>
References: <1475864905-21269-1-git-send-email-alexander.deucher@amd.com>
 <1475864905-21269-5-git-send-email-alexander.deucher@amd.com>
 <CADnq5_MFT8M8VRu17gOcZjjRCK9Z-c3mG7=V46BQhYZXMKMetA@mail.gmail.com>
 <CY4PR12MB16871A098341B047DBA0DEADFBDD0@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1550540634=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB16871A098341B047DBA0DEADFBDD0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Fang, Peter" <Peter.Fang-5C7GfCeVMHo@public.gmane.org>, "Zhang, Boyuan" <Boyuan.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1550540634==
Content-Type: multipart/alternative;
 boundary="------------579E25247FF04ECE7404068F"

This is a multi-part message in MIME format.
--------------579E25247FF04ECE7404068F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rex,

the problem with this approach is that you need to copy the entries from 
one structure to another, like we have below:

 > +                               vce_clk_table.entries[i].sclk = 
hwmgr->vce_states[i].sclk;
 > +                               vce_clk_table.entries[i].mclk = 
hwmgr->vce_states[i].mclk;
 > +                               vce_clk_table.entries[i].eclk = 
hwmgr->vce_states[i].evclk;

This is not seen as good coding practice and usually isn't allowed 
upstream because it creates two representations in the kernel for the 
same thing.

Regards,
Christian.

Am 12.10.2016 um 10:34 schrieb Zhu, Rex:
> Hi Alex,
>
> In Patch1, I moved struct amdgpu_vce_states to amd_shared.h from amdgpu.h. So in powerplay, we used same vce state definition.
>
> So the define of static struct drm_amdgpu_info_vce_clock_table  pp_dpm_get_vce_clock_table(void *handle)
> Can change to
> static struct amd_vce_state  pp_dpm_get_vce_clock_table(void *handle,  int num);
>
> and can move those codes to Patch6.
>> +                               vce_clk_table.entries[i].sclk = hwmgr->vce_states[i].sclk;
>> +                               vce_clk_table.entries[i].mclk = hwmgr->vce_states[i].mclk;
>> +                               vce_clk_table.entries[i].eclk = hwmgr->vce_states[i].evclk;
>
> So in powerplay and dpm, we don't need to visit struct drm_amdgpu_info_vce_clock_table.
>   
> In Patch2, add numer of vce_states in struct dpm. If it is useful to UMD driver. We can notify UMD by add a member in struct drm_amdgpu_info_vce_clock_table.
>
> Best Regards
> Rex
>
> -----Original Message-----
> From: Alex Deucher [mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: Wednesday, October 12, 2016 4:07 AM
> To: amd-gfx list; Fang, Peter; Zhang, Boyuan; Zhu, Rex
> Cc: Deucher, Alexander
> Subject: Re: [PATCH 5/6] drm/amdgpu/powerplay: add an implementation for get_vce_clock_table
>
> Rex what is your opinion on exposing the amdgpu drm structure through to powerplay?  We could do an intermediate interface, but that just seems like extra hoops to jump through for pretty questionable gain.
>
> Alex
>
> On Fri, Oct 7, 2016 at 2:28 PM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Used by the powerplay dpm code.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 24
>> ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>> b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>> index bb8a345..8eee390 100644
>> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>> @@ -30,6 +30,7 @@
>>   #include "power_state.h"
>>   #include "eventmanager.h"
>>   #include "pp_debug.h"
>> +#include "drm/amdgpu_drm.h"
>>
>>
>>   #define PP_CHECK(handle)                                               \
>> @@ -821,6 +822,28 @@ static int pp_dpm_read_sensor(void *handle, int idx, int32_t *value)
>>          return hwmgr->hwmgr_func->read_sensor(hwmgr, idx, value);  }
>>
>> +static struct drm_amdgpu_info_vce_clock_table
>> +pp_dpm_get_vce_clock_table(void *handle) {
>> +       struct drm_amdgpu_info_vce_clock_table vce_clk_table = {};
>> +       struct pp_hwmgr *hwmgr;
>> +       unsigned i;
>> +
>> +       if (handle) {
>> +               hwmgr = ((struct pp_instance *)handle)->hwmgr;
>> +
>> +               if (hwmgr) {
>> +                       for (i = 0; i < AMDGPU_VCE_CLOCK_TABLE_ENTRIES; i++) {
>> +                               vce_clk_table.entries[i].sclk = hwmgr->vce_states[i].sclk;
>> +                               vce_clk_table.entries[i].mclk = hwmgr->vce_states[i].mclk;
>> +                               vce_clk_table.entries[i].eclk = hwmgr->vce_states[i].evclk;
>> +                       }
>> +               }
>> +       }
>> +
>> +       return vce_clk_table;
>> +}
>> +
>>   const struct amd_powerplay_funcs pp_dpm_funcs = {
>>          .get_temperature = pp_dpm_get_temperature,
>>          .load_firmware = pp_dpm_load_fw, @@ -847,6 +870,7 @@ const
>> struct amd_powerplay_funcs pp_dpm_funcs = {
>>          .get_mclk_od = pp_dpm_get_mclk_od,
>>          .set_mclk_od = pp_dpm_set_mclk_od,
>>          .read_sensor = pp_dpm_read_sensor,
>> +       .get_vce_clock_table = pp_dpm_get_vce_clock_table,
>>   };
>>
>>   static int amd_pp_instance_init(struct amd_pp_init *pp_init,
>> --
>> 2.5.5
>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------579E25247FF04ECE7404068F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi Rex,<br>
      <br>
      the problem with this approach is that you need to copy the
      entries from one structure to another, like we have below:<br>
      <br>
      &gt; +                               vce_clk_table.entries[i].sclk
      = hwmgr-&gt;vce_states[i].sclk;<br>
      &gt; +                               vce_clk_table.entries[i].mclk
      = hwmgr-&gt;vce_states[i].mclk;<br>
      &gt; +                               vce_clk_table.entries[i].eclk
      = hwmgr-&gt;vce_states[i].evclk;<br>
      <br>
      This is not seen as good coding practice and usually isn't allowed
      upstream because it creates two representations in the kernel for
      the same thing.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 12.10.2016 um 10:34 schrieb Zhu, Rex:<br>
    </div>
    <blockquote
cite="mid:CY4PR12MB16871A098341B047DBA0DEADFBDD0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <pre wrap="">Hi Alex,

In Patch1, I moved struct amdgpu_vce_states to amd_shared.h from amdgpu.h. So in powerplay, we used same vce state definition.

So the define of static struct drm_amdgpu_info_vce_clock_table  pp_dpm_get_vce_clock_table(void *handle)
Can change to 
static struct amd_vce_state  pp_dpm_get_vce_clock_table(void *handle,  int num);

and can move those codes to Patch6.
</pre>
      <blockquote type="cite">
        <pre wrap="">+                               vce_clk_table.entries[i].sclk = hwmgr-&gt;vce_states[i].sclk;
+                               vce_clk_table.entries[i].mclk = hwmgr-&gt;vce_states[i].mclk;
+                               vce_clk_table.entries[i].eclk = hwmgr-&gt;vce_states[i].evclk;
</pre>
      </blockquote>
      <pre wrap="">

So in powerplay and dpm, we don't need to visit struct drm_amdgpu_info_vce_clock_table.
 
In Patch2, add numer of vce_states in struct dpm. If it is useful to UMD driver. We can notify UMD by add a member in struct drm_amdgpu_info_vce_clock_table.

Best Regards
Rex

-----Original Message-----
From: Alex Deucher [<a class="moz-txt-link-freetext" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>] 
Sent: Wednesday, October 12, 2016 4:07 AM
To: amd-gfx list; Fang, Peter; Zhang, Boyuan; Zhu, Rex
Cc: Deucher, Alexander
Subject: Re: [PATCH 5/6] drm/amdgpu/powerplay: add an implementation for get_vce_clock_table

Rex what is your opinion on exposing the amdgpu drm structure through to powerplay?  We could do an intermediate interface, but that just seems like extra hoops to jump through for pretty questionable gain.

Alex

On Fri, Oct 7, 2016 at 2:28 PM, Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Used by the powerplay dpm code.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 24 
++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c 
b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index bb8a345..8eee390 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -30,6 +30,7 @@
 #include "power_state.h"
 #include "eventmanager.h"
 #include "pp_debug.h"
+#include "drm/amdgpu_drm.h"


 #define PP_CHECK(handle)                                               \
@@ -821,6 +822,28 @@ static int pp_dpm_read_sensor(void *handle, int idx, int32_t *value)
        return hwmgr-&gt;hwmgr_func-&gt;read_sensor(hwmgr, idx, value);  }

+static struct drm_amdgpu_info_vce_clock_table 
+pp_dpm_get_vce_clock_table(void *handle) {
+       struct drm_amdgpu_info_vce_clock_table vce_clk_table = {};
+       struct pp_hwmgr *hwmgr;
+       unsigned i;
+
+       if (handle) {
+               hwmgr = ((struct pp_instance *)handle)-&gt;hwmgr;
+
+               if (hwmgr) {
+                       for (i = 0; i &lt; AMDGPU_VCE_CLOCK_TABLE_ENTRIES; i++) {
+                               vce_clk_table.entries[i].sclk = hwmgr-&gt;vce_states[i].sclk;
+                               vce_clk_table.entries[i].mclk = hwmgr-&gt;vce_states[i].mclk;
+                               vce_clk_table.entries[i].eclk = hwmgr-&gt;vce_states[i].evclk;
+                       }
+               }
+       }
+
+       return vce_clk_table;
+}
+
 const struct amd_powerplay_funcs pp_dpm_funcs = {
        .get_temperature = pp_dpm_get_temperature,
        .load_firmware = pp_dpm_load_fw, @@ -847,6 +870,7 @@ const 
struct amd_powerplay_funcs pp_dpm_funcs = {
        .get_mclk_od = pp_dpm_get_mclk_od,
        .set_mclk_od = pp_dpm_set_mclk_od,
        .read_sensor = pp_dpm_read_sensor,
+       .get_vce_clock_table = pp_dpm_get_vce_clock_table,
 };

 static int amd_pp_instance_init(struct amd_pp_init *pp_init,
--
2.5.5

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
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------579E25247FF04ECE7404068F--

--===============1550540634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1550540634==--
