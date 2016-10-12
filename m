From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 5/6] drm/amdgpu/powerplay: add an implementation for
 get_vce_clock_table
Date: Wed, 12 Oct 2016 11:56:43 +0200
Message-ID: <4117134e-ff2f-808d-4354-3e51c2410724@vodafone.de>
References: <1475864905-21269-1-git-send-email-alexander.deucher@amd.com>
 <1475864905-21269-5-git-send-email-alexander.deucher@amd.com>
 <CADnq5_MFT8M8VRu17gOcZjjRCK9Z-c3mG7=V46BQhYZXMKMetA@mail.gmail.com>
 <CY4PR12MB16871A098341B047DBA0DEADFBDD0@CY4PR12MB1687.namprd12.prod.outlook.com>
 <e8cdcd80-3df3-940f-32b5-9116e5d15fa6@vodafone.de>
 <CY4PR12MB168795F3CD0C3B58ED38828DFBDD0@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1437739563=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB168795F3CD0C3B58ED38828DFBDD0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
--===============1437739563==
Content-Type: multipart/alternative;
 boundary="------------4A82D826F458CE41BD422B31"

This is a multi-part message in MIME format.
--------------4A82D826F458CE41BD422B31
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rex,

So amd_vce_state is our hardware representation and 
drm_amdgpu_info_vce_clock_table is the IOCTL interface structure? Is 
there a reason for not using drm_amdgpu_info_vce_clock_table directly in 
the hw manager, except that we don't want to include the IOCTL interface 
here?

Cause that would at least be a bit awkward, this is an extra abstraction 
layer we usually try to avoid upstream.

I'm fine with this approach for this use case, but when we get more and 
more power management exposed to userspace this could raise objections 
cause this essentially means we need to duplicate all internal power 
management structures for the public interface again.

Regards,
Christian.

Am 12.10.2016 um 11:40 schrieb Zhu, Rex:
>
> Hi Christian,
>
> I mean patch 5 can be changed as
>
> static struct amd_vce_state*  pp_dpm_get_vce_clock_table(void *handle, 
> int num)
>
> {
>
>     PP_CHECK((struct pp_instance *)handle);
>
>     hwmgr = ((struct pp_instance *)handle)->hwmgr;
>
> if (hwmgr && num < hwmgr->num_vce_state_tables)
>      return &hwmgr->vce_states[i];
>
>     Return NULL;
>
> }
>
> And in Patch6.
>
> +       case AMDGPU_INFO_VCE_CLOCK_TABLE: {
>
> + struct drm_amdgpu_info_vce_clock_table vce_clk_table = {};
>
>  struct amd_vce_state*  vce_state;
>
> +      for (i = 0; i < AMDGPU_VCE_CLOCK_TABLE_ENTRIES; i++) {
>
> vce_state = amdgpu_dpm_get_vce_clock_table(adev, i);
>
> If (vce_state) {
>
>                                     vce_clk_table.entries[i].sclk = 
> vce_state->sclk;
> vce_clk_table.entries[i].mclk = vce_state->mclk;
> vce_clk_table.entries[i].eclk = vce_state->evclk;
>
>      } else {
>
>                vce_clk_table.num_of_entries = i; //if UMD driver need 
> to check number of vce state.
>
> break;
>
>              }
>
>               }
>
> + return copy_to_user(out, &vce_clk_table,
>
> +     min((size_t)size, sizeof(vce_clk_table))) ? -EFAULT : 0;
>
> +       }
>
> Best Regards
>
> Rex
>
> *From:*amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] *On 
> Behalf Of *Christian König
> *Sent:* Wednesday, October 12, 2016 4:53 PM
> *To:* Zhu, Rex; Alex Deucher; amd-gfx list; Fang, Peter; Zhang, Boyuan
> *Cc:* Deucher, Alexander
> *Subject:* Re: [PATCH 5/6] drm/amdgpu/powerplay: add an implementation 
> for get_vce_clock_table
>
> Hi Rex,
>
> the problem with this approach is that you need to copy the entries 
> from one structure to another, like we have below:
>
> > + vce_clk_table.entries[i].sclk = hwmgr->vce_states[i].sclk;
> > + vce_clk_table.entries[i].mclk = hwmgr->vce_states[i].mclk;
> > + vce_clk_table.entries[i].eclk = hwmgr->vce_states[i].evclk;
>
> This is not seen as good coding practice and usually isn't allowed 
> upstream because it creates two representations in the kernel for the 
> same thing.
>
> Regards,
> Christian.
>
> Am 12.10.2016 um 10:34 schrieb Zhu, Rex:
>
>     Hi Alex,
>
>     In Patch1, I moved struct amdgpu_vce_states to amd_shared.h from
>     amdgpu.h. So in powerplay, we used same vce state definition.
>
>     So the define of static struct drm_amdgpu_info_vce_clock_table 
>     pp_dpm_get_vce_clock_table(void *handle)
>
>     Can change to
>
>     static struct amd_vce_state  pp_dpm_get_vce_clock_table(void
>     *handle,  int num);
>
>     and can move those codes to Patch6.
>
>         +                               vce_clk_table.entries[i].sclk
>         = hwmgr->vce_states[i].sclk;
>
>         +                               vce_clk_table.entries[i].mclk
>         = hwmgr->vce_states[i].mclk;
>
>         +                               vce_clk_table.entries[i].eclk
>         = hwmgr->vce_states[i].evclk;
>
>     So in powerplay and dpm, we don't need to visit struct
>     drm_amdgpu_info_vce_clock_table.
>
>     In Patch2, add numer of vce_states in struct dpm. If it is useful
>     to UMD driver. We can notify UMD by add a member in struct
>     drm_amdgpu_info_vce_clock_table.
>
>     Best Regards
>
>     Rex
>
>     -----Original Message-----
>
>     From: Alex Deucher [mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
>
>     Sent: Wednesday, October 12, 2016 4:07 AM
>
>     To: amd-gfx list; Fang, Peter; Zhang, Boyuan; Zhu, Rex
>
>     Cc: Deucher, Alexander
>
>     Subject: Re: [PATCH 5/6] drm/amdgpu/powerplay: add an
>     implementation for get_vce_clock_table
>
>     Rex what is your opinion on exposing the amdgpu drm structure
>     through to powerplay?  We could do an intermediate interface, but
>     that just seems like extra hoops to jump through for pretty
>     questionable gain.
>
>     Alex
>
>     On Fri, Oct 7, 2016 at 2:28 PM, Alex Deucher
>     <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> <mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>         Used by the powerplay dpm code.
>
>         Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>         <mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
>         ---
>
>         drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 24
>
>         ++++++++++++++++++++++++
>
>         1 file changed, 24 insertions(+)
>
>         diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>
>         b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>
>         index bb8a345..8eee390 100644
>
>         --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>
>         +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>
>         @@ -30,6 +30,7 @@
>
>         #include "power_state.h"
>
>         #include "eventmanager.h"
>
>         #include "pp_debug.h"
>
>         +#include "drm/amdgpu_drm.h"
>
>         #define
>         PP_CHECK(handle)                                               \
>
>         @@ -821,6 +822,28 @@ static int pp_dpm_read_sensor(void
>         *handle, int idx, int32_t *value)
>
>                 return hwmgr->hwmgr_func->read_sensor(hwmgr, idx,
>         value);  }
>
>         +static struct drm_amdgpu_info_vce_clock_table
>
>         +pp_dpm_get_vce_clock_table(void *handle) {
>
>         +       struct drm_amdgpu_info_vce_clock_table vce_clk_table = {};
>
>         +       struct pp_hwmgr *hwmgr;
>
>         +       unsigned i;
>
>         +
>
>         +       if (handle) {
>
>         +               hwmgr = ((struct pp_instance *)handle)->hwmgr;
>
>         +
>
>         +               if (hwmgr) {
>
>         +                       for (i = 0; i <
>         AMDGPU_VCE_CLOCK_TABLE_ENTRIES; i++) {
>
>         +                               vce_clk_table.entries[i].sclk
>         = hwmgr->vce_states[i].sclk;
>
>         +                               vce_clk_table.entries[i].mclk
>         = hwmgr->vce_states[i].mclk;
>
>         +                               vce_clk_table.entries[i].eclk
>         = hwmgr->vce_states[i].evclk;
>
>         +                       }
>
>         +               }
>
>         +       }
>
>         +
>
>         +       return vce_clk_table;
>
>         +}
>
>         +
>
>         const struct amd_powerplay_funcs pp_dpm_funcs = {
>
>                 .get_temperature = pp_dpm_get_temperature,
>
>                 .load_firmware = pp_dpm_load_fw, @@ -847,6 +870,7 @@
>         const
>
>         struct amd_powerplay_funcs pp_dpm_funcs = {
>
>                 .get_mclk_od = pp_dpm_get_mclk_od,
>
>                 .set_mclk_od = pp_dpm_set_mclk_od,
>
>                 .read_sensor = pp_dpm_read_sensor,
>
>         +       .get_vce_clock_table = pp_dpm_get_vce_clock_table,
>
>         };
>
>         static int amd_pp_instance_init(struct amd_pp_init *pp_init,
>
>         --
>
>         2.5.5
>
>
>
>
>         _______________________________________________
>
>         amd-gfx mailing list
>
>         amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>
>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------4A82D826F458CE41BD422B31
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi Rex,<br>
      <br>
      So amd_vce_state is our hardware representation and <span
        lang="EN-US">drm_amdgpu_info_vce_clock_table is the IOCTL
        interface structure? Is there a reason for not using
        drm_amdgpu_info_vce_clock_table directly in the hw manager,
        except that we don't want to include the IOCTL interface here?<br>
        <br>
        Cause that would at least be a bit awkward, this is an extra
        abstraction layer we usually try to avoid upstream.<br>
        <br>
        I'm fine with this approach for this use case, but when we get
        more and more power management exposed to userspace this could
        raise objections cause this essentially means we need to
        duplicate all internal power management structures for the
        public interface again.<br>
        <br>
        Regards,<br>
        Christian. <br>
      </span><br>
      Am 12.10.2016 um 11:40 schrieb Zhu, Rex:<br>
    </div>
    <blockquote
cite="mid:CY4PR12MB168795F3CD0C3B58ED38828DFBDD0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Word 14 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:SimSun;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.5pt;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:SimSun;
	color:black;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:SimSun;
	color:black;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:SimSun;
	color:black;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";
	color:black;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:SimSun;
	color:black;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US">Hi Christian,<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US">I mean patch 5 can be changed as
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">static struct
            amd_vce_state*  pp_dpm_get_vce_clock_table(void *handle, 
            int num)<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">{<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">    PP_CHECK((struct
            pp_instance *)handle);<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">    hwmgr = ((struct
            pp_instance *)handle)-&gt;hwmgr;<o:p></o:p></span></p>
        <pre style="text-indent:18.0pt"><span lang="EN-US">if (hwmgr &amp;&amp; num &lt; hwmgr-&gt;num_vce_state_tables)<o:p></o:p></span></pre>
        <pre style="text-indent:18.0pt"><span lang="EN-US">     return &amp;hwmgr-&gt;vce_states[i];<o:p></o:p></span></pre>
        <p class="MsoNormal"><span lang="EN-US">             <o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">    Return NULL;<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">}</span><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US">And in Patch6.
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoPlainText"><span lang="EN-US">+       case
            AMDGPU_INFO_VCE_CLOCK_TABLE: {<o:p></o:p></span></p>
        <p class="MsoPlainText"><span lang="EN-US">+               
            struct drm_amdgpu_info_vce_clock_table vce_clk_table = {};<o:p></o:p></span></p>
        <p class="MsoPlainText"><span lang="EN-US">                <span
              style="color:#C00000">
               struct amd_vce_state*  vce_state;</span><o:p></o:p></span></p>
        <p class="MsoPlainText"><span lang="EN-US"><o:p> </o:p></span></p>
        <pre><span lang="EN-US">+      for (i = 0; i &lt; AMDGPU_VCE_CLOCK_TABLE_ENTRIES; i++) {<o:p></o:p></span></pre>
        <p class="MsoPlainText"><span lang="EN-US"><o:p></o:p></span></p>
        <p class="MsoPlainText"><span lang="EN-US">                 <span
              style="color:#C00000">vce_state</span> =
            amdgpu_dpm_get_vce_clock_table(adev,
            <span style="color:#C00000">i</span>);<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#C00000" lang="EN-US">                        
            If (vce_state) {<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="font-family:&quot;Courier
            New&quot;;color:#C00000" lang="EN-US"> </span><span
            style="color:#C00000" lang="EN-US">
                                                vce_clk_table.entries[i].sclk
            = vce_state-&gt;sclk;<br>
          </span><span style="font-family:&quot;Courier
            New&quot;;color:#C00000" lang="EN-US">            </span><span
            style="color:#C00000" lang="EN-US">
            vce_clk_table.entries[i].mclk = vce_state-&gt;mclk;<br>
          </span><span style="font-family:&quot;Courier
            New&quot;;color:#C00000" lang="EN-US">           </span><span
            style="color:#C00000" lang="EN-US">
            vce_clk_table.entries[i].eclk = vce_state-&gt;evclk;<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#C00000" lang="EN-US">                  
                 } else {<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#C00000" lang="EN-US">               
                           vce_clk_table.num_of_entries = i;        
            //if UMD driver need to check number of vce state.<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#C00000" lang="EN-US">                              
            break;<o:p></o:p></span></p>
        <p class="MsoPlainText"><span style="color:#C00000" lang="EN-US">        
                         }<o:p></o:p></span></p>
        <p class="MsoPlainText"><span lang="EN-US">              }<o:p></o:p></span></p>
        <p class="MsoPlainText"><span lang="EN-US">+               
            return copy_to_user(out, &amp;vce_clk_table,<o:p></o:p></span></p>
        <p class="MsoPlainText"><span lang="EN-US">+                                  
                min((size_t)size, sizeof(vce_clk_table))) ? -EFAULT : 0;<o:p></o:p></span></p>
        <p class="MsoPlainText"><span lang="EN-US">+       }<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US">Best Regards<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"
            lang="EN-US">Rex<o:p></o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #B5C4DF
            1.0pt;padding:3.0pt 0cm 0cm 0cm">
            <p class="MsoNormal"><b><span
style="font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;;color:windowtext"
                  lang="EN-US">From:</span></b><span
style="font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;;color:windowtext"
                lang="EN-US"> amd-gfx
                [<a class="moz-txt-link-freetext" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
                <b>On Behalf Of </b>Christian König<br>
                <b>Sent:</b> Wednesday, October 12, 2016 4:53 PM<br>
                <b>To:</b> Zhu, Rex; Alex Deucher; amd-gfx list; Fang,
                Peter; Zhang, Boyuan<br>
                <b>Cc:</b> Deucher, Alexander<br>
                <b>Subject:</b> Re: [PATCH 5/6] drm/amdgpu/powerplay:
                add an implementation for get_vce_clock_table<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <div>
          <p class="MsoNormal"><span lang="EN-US">Hi Rex,<br>
              <br>
              the problem with this approach is that you need to copy
              the entries from one structure to another, like we have
              below:<br>
              <br>
              &gt; +                              
              vce_clk_table.entries[i].sclk =
              hwmgr-&gt;vce_states[i].sclk;<br>
              &gt; +                              
              vce_clk_table.entries[i].mclk =
              hwmgr-&gt;vce_states[i].mclk;<br>
              &gt; +                              
              vce_clk_table.entries[i].eclk =
              hwmgr-&gt;vce_states[i].evclk;<br>
              <br>
              This is not seen as good coding practice and usually isn't
              allowed upstream because it creates two representations in
              the kernel for the same thing.<br>
              <br>
              Regards,<br>
              Christian.<br>
              <br>
              Am 12.10.2016 um 10:34 schrieb Zhu, Rex:<o:p></o:p></span></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <pre><span lang="EN-US">Hi Alex,<o:p></o:p></span></pre>
          <pre><span lang="EN-US"><o:p> </o:p></span></pre>
          <pre><span lang="EN-US">In Patch1, I moved struct amdgpu_vce_states to amd_shared.h from amdgpu.h. So in powerplay, we used same vce state definition.<o:p></o:p></span></pre>
          <pre><span lang="EN-US"><o:p> </o:p></span></pre>
          <pre><span lang="EN-US">So the define of static struct drm_amdgpu_info_vce_clock_table  pp_dpm_get_vce_clock_table(void *handle)<o:p></o:p></span></pre>
          <pre><span lang="EN-US">Can change to <o:p></o:p></span></pre>
          <pre><span lang="EN-US">static struct amd_vce_state  pp_dpm_get_vce_clock_table(void *handle,  int num);<o:p></o:p></span></pre>
          <pre><span lang="EN-US"><o:p> </o:p></span></pre>
          <pre><span lang="EN-US">and can move those codes to Patch6.<o:p></o:p></span></pre>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre><span lang="EN-US">+                               vce_clk_table.entries[i].sclk = hwmgr-&gt;vce_states[i].sclk;<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+                               vce_clk_table.entries[i].mclk = hwmgr-&gt;vce_states[i].mclk;<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+                               vce_clk_table.entries[i].eclk = hwmgr-&gt;vce_states[i].evclk;<o:p></o:p></span></pre>
          </blockquote>
          <pre><span lang="EN-US"><o:p> </o:p></span></pre>
          <pre><span lang="EN-US"><o:p> </o:p></span></pre>
          <pre><span lang="EN-US">So in powerplay and dpm, we don't need to visit struct drm_amdgpu_info_vce_clock_table.<o:p></o:p></span></pre>
          <pre><span lang="EN-US"> <o:p></o:p></span></pre>
          <pre><span lang="EN-US">In Patch2, add numer of vce_states in struct dpm. If it is useful to UMD driver. We can notify UMD by add a member in struct drm_amdgpu_info_vce_clock_table.<o:p></o:p></span></pre>
          <pre><span lang="EN-US"><o:p> </o:p></span></pre>
          <pre><span lang="EN-US">Best Regards<o:p></o:p></span></pre>
          <pre><span lang="EN-US">Rex<o:p></o:p></span></pre>
          <pre><span lang="EN-US"><o:p> </o:p></span></pre>
          <pre><span lang="EN-US">-----Original Message-----<o:p></o:p></span></pre>
          <pre><span lang="EN-US">From: Alex Deucher [<a moz-do-not-send="true" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>] <o:p></o:p></span></pre>
          <pre><span lang="EN-US">Sent: Wednesday, October 12, 2016 4:07 AM<o:p></o:p></span></pre>
          <pre><span lang="EN-US">To: amd-gfx list; Fang, Peter; Zhang, Boyuan; Zhu, Rex<o:p></o:p></span></pre>
          <pre><span lang="EN-US">Cc: Deucher, Alexander<o:p></o:p></span></pre>
          <pre><span lang="EN-US">Subject: Re: [PATCH 5/6] drm/amdgpu/powerplay: add an implementation for get_vce_clock_table<o:p></o:p></span></pre>
          <pre><span lang="EN-US"><o:p> </o:p></span></pre>
          <pre><span lang="EN-US">Rex what is your opinion on exposing the amdgpu drm structure through to powerplay?  We could do an intermediate interface, but that just seems like extra hoops to jump through for pretty questionable gain.<o:p></o:p></span></pre>
          <pre><span lang="EN-US"><o:p> </o:p></span></pre>
          <pre><span lang="EN-US">Alex<o:p></o:p></span></pre>
          <pre><span lang="EN-US"><o:p> </o:p></span></pre>
          <pre><span lang="EN-US">On Fri, Oct 7, 2016 at 2:28 PM, Alex Deucher <a moz-do-not-send="true" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a> wrote:<o:p></o:p></span></pre>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre><span lang="EN-US">Used by the powerplay dpm code.<o:p></o:p></span></pre>
            <pre><span lang="EN-US"><o:p> </o:p></span></pre>
            <pre><span lang="EN-US">Signed-off-by: Alex Deucher <a moz-do-not-send="true" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><o:p></o:p></span></pre>
            <pre><span lang="EN-US">---<o:p></o:p></span></pre>
            <pre><span lang="EN-US"> drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 24 <o:p></o:p></span></pre>
            <pre><span lang="EN-US">++++++++++++++++++++++++<o:p></o:p></span></pre>
            <pre><span lang="EN-US"> 1 file changed, 24 insertions(+)<o:p></o:p></span></pre>
            <pre><span lang="EN-US"><o:p> </o:p></span></pre>
            <pre><span lang="EN-US">diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c <o:p></o:p></span></pre>
            <pre><span lang="EN-US">b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<o:p></o:p></span></pre>
            <pre><span lang="EN-US">index bb8a345..8eee390 100644<o:p></o:p></span></pre>
            <pre><span lang="EN-US">--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<o:p></o:p></span></pre>
            <pre><span lang="EN-US">@@ -30,6 +30,7 @@<o:p></o:p></span></pre>
            <pre><span lang="EN-US"> #include "power_state.h"<o:p></o:p></span></pre>
            <pre><span lang="EN-US"> #include "eventmanager.h"<o:p></o:p></span></pre>
            <pre><span lang="EN-US"> #include "pp_debug.h"<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+#include "drm/amdgpu_drm.h"<o:p></o:p></span></pre>
            <pre><span lang="EN-US"><o:p> </o:p></span></pre>
            <pre><span lang="EN-US"><o:p> </o:p></span></pre>
            <pre><span lang="EN-US"> #define PP_CHECK(handle)                                               \<o:p></o:p></span></pre>
            <pre><span lang="EN-US">@@ -821,6 +822,28 @@ static int pp_dpm_read_sensor(void *handle, int idx, int32_t *value)<o:p></o:p></span></pre>
            <pre><span lang="EN-US">        return hwmgr-&gt;hwmgr_func-&gt;read_sensor(hwmgr, idx, value);  }<o:p></o:p></span></pre>
            <pre><span lang="EN-US"><o:p> </o:p></span></pre>
            <pre><span lang="EN-US">+static struct drm_amdgpu_info_vce_clock_table <o:p></o:p></span></pre>
            <pre><span lang="EN-US">+pp_dpm_get_vce_clock_table(void *handle) {<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+       struct drm_amdgpu_info_vce_clock_table vce_clk_table = {};<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+       struct pp_hwmgr *hwmgr;<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+       unsigned i;<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+       if (handle) {<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+               hwmgr = ((struct pp_instance *)handle)-&gt;hwmgr;<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+               if (hwmgr) {<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+                       for (i = 0; i &lt; AMDGPU_VCE_CLOCK_TABLE_ENTRIES; i++) {<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+                               vce_clk_table.entries[i].sclk = hwmgr-&gt;vce_states[i].sclk;<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+                               vce_clk_table.entries[i].mclk = hwmgr-&gt;vce_states[i].mclk;<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+                               vce_clk_table.entries[i].eclk = hwmgr-&gt;vce_states[i].evclk;<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+                       }<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+               }<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+       }<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+       return vce_clk_table;<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+}<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+<o:p></o:p></span></pre>
            <pre><span lang="EN-US"> const struct amd_powerplay_funcs pp_dpm_funcs = {<o:p></o:p></span></pre>
            <pre><span lang="EN-US">        .get_temperature = pp_dpm_get_temperature,<o:p></o:p></span></pre>
            <pre><span lang="EN-US">        .load_firmware = pp_dpm_load_fw, @@ -847,6 +870,7 @@ const <o:p></o:p></span></pre>
            <pre><span lang="EN-US">struct amd_powerplay_funcs pp_dpm_funcs = {<o:p></o:p></span></pre>
            <pre><span lang="EN-US">        .get_mclk_od = pp_dpm_get_mclk_od,<o:p></o:p></span></pre>
            <pre><span lang="EN-US">        .set_mclk_od = pp_dpm_set_mclk_od,<o:p></o:p></span></pre>
            <pre><span lang="EN-US">        .read_sensor = pp_dpm_read_sensor,<o:p></o:p></span></pre>
            <pre><span lang="EN-US">+       .get_vce_clock_table = pp_dpm_get_vce_clock_table,<o:p></o:p></span></pre>
            <pre><span lang="EN-US"> };<o:p></o:p></span></pre>
            <pre><span lang="EN-US"><o:p> </o:p></span></pre>
            <pre><span lang="EN-US"> static int amd_pp_instance_init(struct amd_pp_init *pp_init,<o:p></o:p></span></pre>
            <pre><span lang="EN-US">--<o:p></o:p></span></pre>
            <pre><span lang="EN-US">2.5.5<o:p></o:p></span></pre>
            <pre><span lang="EN-US"><o:p> </o:p></span></pre>
            <p class="MsoNormal"><span lang="EN-US"><br>
                <br>
                <br>
                <o:p></o:p></span></p>
            <pre><span lang="EN-US">_______________________________________________<o:p></o:p></span></pre>
            <pre><span lang="EN-US">amd-gfx mailing list<o:p></o:p></span></pre>
            <pre><span lang="EN-US"><a moz-do-not-send="true" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><o:p></o:p></span></pre>
            <pre><span lang="EN-US"><a moz-do-not-send="true" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></pre>
          </blockquote>
        </blockquote>
        <p><span lang="EN-US"><o:p> </o:p></span></p>
      </div>
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

--------------4A82D826F458CE41BD422B31--

--===============1437739563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1437739563==--
