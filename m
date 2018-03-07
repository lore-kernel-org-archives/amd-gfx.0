From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: deprecated register issues
Date: Wed, 7 Mar 2018 15:31:13 +0100
Message-ID: <8ccdd2af-4520-866b-9b55-fa41b05c1fa1@amd.com>
References: <BLUPR12MB04496DB9A508E4AEE114AF2484D80@BLUPR12MB0449.namprd12.prod.outlook.com>
 <0258a141-8849-623b-9949-de14026e76a8@amd.com>
 <BLUPR12MB044941D93445D001B482655984D80@BLUPR12MB0449.namprd12.prod.outlook.com>
 <58B0701E-D93F-417B-816C-0616F364789A@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0305943769=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <58B0701E-D93F-417B-816C-0616F364789A-5C7GfCeVMHo@public.gmane.org>
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
To: "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Jin,
 Jian-Rong" <Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0305943769==
Content-Type: multipart/alternative;
 boundary="------------7ED1774B814202B536754711"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------7ED1774B814202B536754711
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

well I just figured that this is a misunderstanding.

Accessing this register and some other deprecated registers can cause 
problem when invalidating VMHUBs.

This register itself isn't deprecated, the wording in a patch fixing 
things is just a bit unclear.

Question is is that register still accessed regularly or is it value 
cached after startup?

Regards,
Christian.

Am 07.03.2018 um 15:25 schrieb Mao, David:
> We requires base driver to provide the mask of disabled RB.
> This is why kernel read the CC_RB_BACKEND_DISABLE to collect the 
> harvest configuration.
> Where did you get to know that the register is deprecated?
> I think it should still be there.
>
> Best Regards,
> David
>
>> On Mar 7, 2018, at 9:49 PM, Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org 
>> <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>> wrote:
>>
>> + UMD guys
>> Hi David
>> Do you know if*GC_USER_RB_BACKEND_DISABLE is still exist for 
>> gfx9/vega10 ?*
>> **
>> *We found*CC_RB_BACKEND_DISABLE was deprecated but looks it is still 
>> in use in kmd, so
>> I want to check with you both of above registers
>> Thanks
>> /Monk
>> *From:*amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org]*On 
>> Behalf Of*Christian K?nig
>> *Sent:*2018年3月7日20:26
>> *To:*Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>>; Deucher, 
>> Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org <mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>>
>> *Cc:*amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>> *Subject:*Re: deprecated register issues
>> Hi Monk,
>>
>> I honestly don't have the slightest idea why we are still accessing 
>> CC_RB_BACKEND_DISABLE. Maybe it still contains some useful values?
>>
>> Key point was that we needed to stop accessing it all the time to 
>> avoid triggering problems.
>>
>> Regards,
>> Christian.
>>
>> Am 07.03.2018 um 13:11 schrieb Liu, Monk:
>>
>>     Hi Christian
>>
>>     I remember you and AlexD mentioned that a handful registers are
>>     deprecated for greenland (gfx9)
>>
>>     e.g. CC_RB_BACKEND_DISABLE
>>
>>     do you know why we still have this routine ?
>>
>>     staticu32
>>     gfx_v9_0_get_rb_active_bitmap(structamdgpu_device *adev)
>>     {
>>         u32 data, mask;
>>         data =RREG32_SOC15(GC,
>>     0, mmCC_RB_BACKEND_DISABLE);
>>         data |=RREG32_SOC15(GC,
>>     0, mmGC_USER_RB_BACKEND_DISABLE);
>>         data &= CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;
>>         data >>= GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;
>>         mask
>>     =amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_se/
>>     adev->gfx.config.max_sh_per_se);
>>     return(~data) & mask;
>>     }
>>
>>     see that it still read CC_RB_BACKEND_DISABLE
>>
>>     thanks
>>
>>     /Monk
>>
>


--------------7ED1774B814202B536754711
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi David,<br>
      <br>
      well I just figured that this is a misunderstanding.<br>
      <br>
      Accessing this register and some other deprecated registers can
      cause problem when invalidating VMHUBs.<br>
      <br>
      This register itself isn't deprecated, the wording in a patch
      fixing things is just a bit unclear.<br>
      <br>
      Question is is that register still accessed regularly or is it
      value cached after startup? <br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 07.03.2018 um 15:25 schrieb Mao, David:<br>
    </div>
    <blockquote type="cite"
      cite="mid:58B0701E-D93F-417B-816C-0616F364789A-5C7GfCeVMHo@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      We requires base driver to provide the mask of disabled RB.
      <div class="">This is why kernel read the CC_RB_BACKEND_DISABLE to
        collect the harvest configuration.</div>
      <div class="">Where did you get to know that the register is
        deprecated?</div>
      <div class="">I think it should still be there.</div>
      <div class=""><br class="">
      </div>
      <div class="">Best Regards,</div>
      <div class="">David<br class="">
        <div><br class="">
          <blockquote type="cite" class="">
            <div class="">On Mar 7, 2018, at 9:49 PM, Liu, Monk &lt;<a
                href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org" class=""
                moz-do-not-send="true">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:</div>
            <br class="Apple-interchange-newline">
            <div class="">
              <div class="WordSection1" style="page: WordSection1;
                caret-color: rgb(0, 0, 0); font-family: Helvetica;
                font-size: 12px; font-style: normal; font-variant-caps:
                normal; font-weight: normal; letter-spacing: normal;
                text-align: start; text-indent: 0px; text-transform:
                none; white-space: normal; word-spacing: 0px;
                -webkit-text-stroke-width: 0px; background-color:
                rgb(255, 255, 255); text-decoration: none;">
                <div style="margin: 0cm 0cm 0.0001pt; font-size: 12pt;
                  font-family: 宋体;" class="">
                  <span style="font-size: 10.5pt; font-family: 等线;
                    color: windowtext;" class="" lang="EN-US">+ UMD guys<o:p
                      class=""></o:p></span></div>
                <div style="margin: 0cm 0cm 0.0001pt; font-size: 12pt;
                  font-family: 宋体;" class="">
                  <span style="font-size: 10.5pt; font-family: 等线;
                    color: windowtext;" class="" lang="EN-US"><o:p
                      class=""> </o:p></span></div>
                <div style="margin: 0cm 0cm 0.0001pt; font-size: 12pt;
                  font-family: 宋体;" class="">
                  <span style="font-size: 10.5pt; font-family: 等线;
                    color: windowtext;" class="" lang="EN-US">Hi David<o:p
                      class=""></o:p></span></div>
                <div style="margin: 0cm 0cm 0.0001pt; font-size: 12pt;
                  font-family: 宋体;" class="">
                  <span style="font-size: 10.5pt; font-family: 等线;
                    color: windowtext;" class="" lang="EN-US"><o:p
                      class=""> </o:p></span></div>
                <div style="margin: 0cm 0cm 0.0001pt; font-size: 12pt;
                  font-family: 宋体;" class="">
                  <span style="font-size: 10.5pt; font-family: 等线;
                    color: windowtext;" class="" lang="EN-US">Do you
                    know if<span class="Apple-converted-space"> </span></span><b
                    class=""><span style="font-size: 10.5pt;
                      font-family: &quot;Courier New&quot;; color:
                      windowtext;" class="" lang="EN-US">GC_USER_RB_BACKEND_DISABLE
                      is still exist for gfx9/vega10 ?<o:p class=""></o:p></span></b></div>
                <div style="margin: 0cm 0cm 0.0001pt; font-size: 12pt;
                  font-family: 宋体;" class="">
                  <b class=""><span style="font-size: 10.5pt;
                      font-family: &quot;Courier New&quot;; color:
                      windowtext;" class="" lang="EN-US"><o:p class=""> </o:p></span></b></div>
                <div style="margin: 0cm 0cm 0.0001pt; font-size: 12pt;
                  font-family: 宋体;" class="">
                  <b class=""><span style="font-size: 10.5pt;
                      font-family: &quot;Courier New&quot;; color:
                      windowtext;" class="" lang="EN-US">We found<span
                        class="Apple-converted-space"> </span></span></b><span
                    style="color: windowtext;" class="" lang="EN-US">CC_RB_BACKEND_DISABLE
                    was deprecated but looks it is still in use in kmd,
                    so<o:p class=""></o:p></span></div>
                <div style="margin: 0cm 0cm 0.0001pt; font-size: 12pt;
                  font-family: 宋体;" class="">
                  <span class="" lang="EN-US">I want to check with you
                    both of above registers<o:p class=""></o:p></span></div>
                <div style="margin: 0cm 0cm 0.0001pt; font-size: 12pt;
                  font-family: 宋体;" class="">
                  <span class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                <div style="margin: 0cm 0cm 0.0001pt; font-size: 12pt;
                  font-family: 宋体;" class="">
                  <span class="" lang="EN-US">Thanks<span
                      class="Apple-converted-space"> </span><o:p
                      class=""></o:p></span></div>
                <div style="margin: 0cm 0cm 0.0001pt; font-size: 12pt;
                  font-family: 宋体;" class="">
                  <span class="" lang="EN-US">/Monk</span><span
                    style="font-size: 10.5pt; font-family: 等线; color:
                    windowtext;" class="" lang="EN-US"><o:p class=""></o:p></span></div>
                <div style="margin: 0cm 0cm 0.0001pt; font-size: 12pt;
                  font-family: 宋体;" class="">
                  <span style="font-size: 10.5pt; font-family: 等线;
                    color: windowtext;" class="" lang="EN-US"><o:p
                      class=""> </o:p></span></div>
                <div class="">
                  <div style="border-style: solid none none;
                    border-top-width: 1pt; border-top-color: rgb(225,
                    225, 225); padding: 3pt 0cm 0cm;" class="">
                    <div style="margin: 0cm 0cm 0.0001pt; font-size:
                      12pt; font-family: 宋体;" class="">
                      <b class=""><span style="font-size: 11pt;
                          font-family: Calibri, sans-serif; color:
                          windowtext;" class="" lang="EN-US">From:</span></b><span
                        style="font-size: 11pt; font-family: Calibri,
                        sans-serif; color: windowtext;" class=""
                        lang="EN-US"><span class="Apple-converted-space"> </span>amd-gfx
                        [<a
                          href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                          class="" moz-do-not-send="true">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]<span
                          class="Apple-converted-space"> </span><b
                          class="">On Behalf Of<span
                            class="Apple-converted-space"> </span></b>Christian
                        K?nig<br class="">
                        <b class="">Sent:</b><span
                          class="Apple-converted-space"> </span>2018</span><span
                        style="font-size: 11pt; color: windowtext;"
                        class="">年</span><span style="font-size: 11pt;
                        font-family: Calibri, sans-serif; color:
                        windowtext;" class="" lang="EN-US">3</span><span
                        style="font-size: 11pt; color: windowtext;"
                        class="">月</span><span style="font-size: 11pt;
                        font-family: Calibri, sans-serif; color:
                        windowtext;" class="" lang="EN-US">7</span><span
                        style="font-size: 11pt; color: windowtext;"
                        class="">日</span><span style="font-size: 11pt;
                        font-family: Calibri, sans-serif; color:
                        windowtext;" class="" lang="EN-US"><span
                          class="Apple-converted-space"> </span>20:26<br
                          class="">
                        <b class="">To:</b><span
                          class="Apple-converted-space"> </span>Liu,
                        Monk &lt;<a href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org"
                          class="" moz-do-not-send="true">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                        Deucher, Alexander &lt;<a
                          href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org"
                          class="" moz-do-not-send="true">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br
                          class="">
                        <b class="">Cc:</b><span
                          class="Apple-converted-space"> </span><a
                          href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                          class="" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br
                          class="">
                        <b class="">Subject:</b><span
                          class="Apple-converted-space"> </span>Re:
                        deprecated register issues<o:p class=""></o:p></span></div>
                  </div>
                </div>
                <div style="margin: 0cm 0cm 0.0001pt; font-size: 12pt;
                  font-family: 宋体;" class="">
                  <span class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                <div class="">
                  <div style="margin: 0cm 0cm 0.0001pt; font-size: 12pt;
                    font-family: 宋体;" class="">
                    <span class="" lang="EN-US">Hi Monk,<br class="">
                      <br class="">
                      I honestly don't have the slightest idea why we
                      are still accessing CC_RB_BACKEND_DISABLE. Maybe
                      it still contains some useful values?<br class="">
                      <br class="">
                      Key point was that we needed to stop accessing it
                      all the time to avoid triggering problems.<br
                        class="">
                      <br class="">
                      Regards,<br class="">
                      Christian.<br class="">
                      <br class="">
                      Am 07.03.2018 um 13:11 schrieb Liu, Monk:<o:p
                        class=""></o:p></span></div>
                </div>
                <blockquote style="margin-top: 5pt; margin-bottom: 5pt;"
                  class="">
                  <div id="divtagdefaultwrapper" class="">
                    <p class=""><span style="font-family: Calibri,
                        sans-serif;" class="" lang="EN-US">Hi Christian<o:p
                          class=""></o:p></span></p>
                    <p class=""><span style="font-family: Calibri,
                        sans-serif;" class="" lang="EN-US"><o:p class=""> </o:p></span></p>
                    <p class=""><span style="font-family: Calibri,
                        sans-serif;" class="" lang="EN-US">I remember
                        you and AlexD mentioned that a handful registers
                        are deprecated for greenland (gfx9)<o:p class=""></o:p></span></p>
                    <p class=""><span style="font-family: Calibri,
                        sans-serif;" class="" lang="EN-US">e.g.
                        CC_RB_BACKEND_DISABLE<o:p class=""></o:p></span></p>
                    <p class=""><span style="font-family: Calibri,
                        sans-serif;" class="" lang="EN-US"><o:p class=""> </o:p></span></p>
                    <p class=""><span style="font-family: Calibri,
                        sans-serif;" class="" lang="EN-US">do you know
                        why we still have this routine ?<o:p class=""></o:p></span></p>
                    <div class="">
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                      <div class="">
                        <div style="margin: 0cm 0cm 0.0001pt; font-size:
                          12pt; font-family: 宋体; line-height: 14.25pt;
                          background-color: rgb(30, 30, 30);" class="">
                          <span style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(86, 156,
                            214);" class="" lang="EN-US">static</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US"><span
                              class="Apple-converted-space"> </span>u32</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(220,
                            220, 170);" class="" lang="EN-US"><o:p
                              class=""></o:p></span></div>
                        <div style="margin: 0cm 0cm 0.0001pt; font-size:
                          12pt; font-family: 宋体; line-height: 14.25pt;
                          background-color: rgb(30, 30, 30);" class="">
                          <span style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(220,
                            220, 170);" class="" lang="EN-US">gfx_v9_0_get_rb_active_bitmap</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">(</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(86, 156,
                            214);" class="" lang="EN-US">struct</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US"><span
                              class="Apple-converted-space"> </span>amdgpu_device
                            *adev)<o:p class=""></o:p></span></div>
                      </div>
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                      <div class="">
                        <div style="margin: 0cm 0cm 0.0001pt; font-size:
                          12pt; font-family: 宋体; line-height: 14.25pt;
                          background-color: rgb(30, 30, 30);" class="">
                          <span style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">{<o:p
                              class=""></o:p></span></div>
                      </div>
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                      <div class="">
                        <div style="margin: 0cm 0cm 0.0001pt; font-size:
                          12pt; font-family: 宋体; line-height: 14.25pt;
                          background-color: rgb(30, 30, 30);" class="">
                          <span style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">    u32
                            data, mask;<o:p class=""></o:p></span></div>
                      </div>
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                      <div class="">
                        <div style="margin: 0cm 0cm 0.0001pt; font-size:
                          12pt; font-family: 宋体; line-height: 14.25pt;
                          background-color: rgb(30, 30, 30);" class="">
                          <span style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">    data =<span
                              class="Apple-converted-space"> </span></span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(220,
                            220, 170);" class="" lang="EN-US">RREG32_SOC15</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">(GC,</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(181,
                            206, 168);" class="" lang="EN-US"><o:p
                              class=""></o:p></span></div>
                        <div style="margin: 0cm 0cm 0.0001pt; font-size:
                          12pt; font-family: 宋体; line-height: 14.25pt;
                          background-color: rgb(30, 30, 30);" class="">
                          <span style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(181,
                            206, 168);" class="" lang="EN-US">0</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">,
                            mmCC_RB_BACKEND_DISABLE);<o:p class=""></o:p></span></div>
                      </div>
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                      <div class="">
                        <div style="margin: 0cm 0cm 0.0001pt; font-size:
                          12pt; font-family: 宋体; line-height: 14.25pt;
                          background-color: rgb(30, 30, 30);" class="">
                          <span style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">    data
                            |=<span class="Apple-converted-space"> </span></span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(220,
                            220, 170);" class="" lang="EN-US">RREG32_SOC15</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">(GC,</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(181,
                            206, 168);" class="" lang="EN-US"><o:p
                              class=""></o:p></span></div>
                        <div style="margin: 0cm 0cm 0.0001pt; font-size:
                          12pt; font-family: 宋体; line-height: 14.25pt;
                          background-color: rgb(30, 30, 30);" class="">
                          <span style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(181,
                            206, 168);" class="" lang="EN-US">0</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">,
                            mmGC_USER_RB_BACKEND_DISABLE);<o:p class=""></o:p></span></div>
                      </div>
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                      <div class="">
                        <div style="margin: 0cm 0cm 0.0001pt; font-size:
                          12pt; font-family: 宋体; line-height: 14.25pt;
                          background-color: rgb(30, 30, 30);" class="">
                          <span style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">    data
                            &amp;=
                            CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;<o:p
                              class=""></o:p></span></div>
                      </div>
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                      <div class="">
                        <div style="margin: 0cm 0cm 0.0001pt; font-size:
                          12pt; font-family: 宋体; line-height: 14.25pt;
                          background-color: rgb(30, 30, 30);" class="">
                          <span style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">    data
                            &gt;&gt;=
                            GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;<o:p
                              class=""></o:p></span></div>
                      </div>
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                      <div class="">
                        <div style="margin: 0cm 0cm 0.0001pt; font-size:
                          12pt; font-family: 宋体; line-height: 14.25pt;
                          background-color: rgb(30, 30, 30);" class="">
                          <span style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">    mask =<span
                              class="Apple-converted-space"> </span></span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(220,
                            220, 170);" class="" lang="EN-US">amdgpu_gfx_create_bitmask</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">(adev-&gt;</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(156,
                            220, 254);" class="" lang="EN-US">gfx</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">.</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(156,
                            220, 254);" class="" lang="EN-US">config</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">.</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(156,
                            220, 254);" class="" lang="EN-US">max_backends_per_se</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US"><span
                              class="Apple-converted-space"> </span>/<o:p
                              class=""></o:p></span></div>
                      </div>
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                      <div class="">
                        <div style="margin: 0cm 0cm 0.0001pt; font-size:
                          12pt; font-family: 宋体; line-height: 14.25pt;
                          background-color: rgb(30, 30, 30);" class="">
                          <span style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">                    
                            adev-&gt;</span><span style="font-size:
                            10.5pt; font-family: &quot;Courier
                            New&quot;; color: rgb(156, 220, 254);"
                            class="" lang="EN-US">gfx</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">.</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(156,
                            220, 254);" class="" lang="EN-US">config</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">.</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(156,
                            220, 254);" class="" lang="EN-US">max_sh_per_se</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">);<o:p
                              class=""></o:p></span></div>
                      </div>
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                      <div class="">
                        <div style="margin: 0cm 0cm 0.0001pt; font-size:
                          12pt; font-family: 宋体; line-height: 14.25pt;
                          background-color: rgb(30, 30, 30);" class="">
                          <span style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">    </span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(197,
                            134, 192);" class="" lang="EN-US">return</span><span
                            style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US"><span
                              class="Apple-converted-space"> </span>(~data)
                            &amp; mask;<o:p class=""></o:p></span></div>
                      </div>
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                      <div class="">
                        <div style="margin: 0cm 0cm 0.0001pt; font-size:
                          12pt; font-family: 宋体; line-height: 14.25pt;
                          background-color: rgb(30, 30, 30);" class="">
                          <span style="font-size: 10.5pt; font-family:
                            &quot;Courier New&quot;; color: rgb(212,
                            212, 212);" class="" lang="EN-US">}<o:p
                              class=""></o:p></span></div>
                      </div>
                      <div style="margin: 0cm 0cm 0.0001pt; font-size:
                        12pt; font-family: 宋体; line-height: 14.25pt;
                        background-color: rgb(30, 30, 30);" class="">
                        <span style="font-size: 10.5pt; font-family:
                          &quot;Courier New&quot;; color: rgb(212, 212,
                          212);" class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                    </div>
                    <div style="margin: 0cm 0cm 0.0001pt; font-size:
                      12pt; font-family: 宋体;" class="">
                      <span style="font-family: Calibri, sans-serif;"
                        class="" lang="EN-US"><o:p class=""> </o:p></span></div>
                    <p class=""><span style="font-family: Calibri,
                        sans-serif;" class="" lang="EN-US">see that it
                        still read CC_RB_BACKEND_DISABLE<o:p class=""></o:p></span></p>
                    <p class=""><span style="font-family: Calibri,
                        sans-serif;" class="" lang="EN-US"><o:p class=""> </o:p></span></p>
                    <p class=""><span style="font-family: Calibri,
                        sans-serif;" class="" lang="EN-US">thanks<o:p
                          class=""></o:p></span></p>
                    <p class=""><span style="font-family: Calibri,
                        sans-serif;" class="" lang="EN-US"><o:p class=""> </o:p></span></p>
                    <p class=""><span style="font-family: Calibri,
                        sans-serif;" class="" lang="EN-US">/Monk<o:p
                          class=""></o:p></span></p>
                    <p class=""><span style="font-family: Calibri,
                        sans-serif;" class="" lang="EN-US"><o:p class=""> </o:p></span></p>
                  </div>
                </blockquote>
                <div style="margin: 0cm 0cm 0.0001pt; font-size: 12pt;
                  font-family: 宋体;" class="">
                  <span class="" lang="EN-US"><o:p class=""> </o:p></span></div>
              </div>
            </div>
          </blockquote>
        </div>
        <br class="">
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------7ED1774B814202B536754711--

--===============0305943769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0305943769==--
