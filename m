From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: deprecated register issues
Date: Wed, 7 Mar 2018 13:25:56 +0100
Message-ID: <0258a141-8849-623b-9949-de14026e76a8@amd.com>
References: <BLUPR12MB04496DB9A508E4AEE114AF2484D80@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1551492939=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB04496DB9A508E4AEE114AF2484D80-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1551492939==
Content-Type: multipart/alternative;
 boundary="------------C889808DBE0AF2A0E3EA1FAD"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------C889808DBE0AF2A0E3EA1FAD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Monk,

I honestly don't have the slightest idea why we are still accessing 
CC_RB_BACKEND_DISABLE. Maybe it still contains some useful values?

Key point was that we needed to stop accessing it all the time to avoid 
triggering problems.

Regards,
Christian.

Am 07.03.2018 um 13:11 schrieb Liu, Monk:
>
> Hi Christian
>
>
> I remember you and AlexD mentioned that a handful registers are 
> deprecated for greenland (gfx9)
>
> e.g. CC_RB_BACKEND_DISABLE
>
>
> do you know why we still have this routine ?
>
> static u32 gfx_v9_0_get_rb_active_bitmap(struct amdgpu_device *adev)
> {
>     u32 data, mask;
>     data = RREG32_SOC15(GC, 0, mmCC_RB_BACKEND_DISABLE);
>     data |= RREG32_SOC15(GC, 0, mmGC_USER_RB_BACKEND_DISABLE);
>     data &= CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;
>     data >>= GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;
>     mask = 
> amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_se /
>                      adev->gfx.config.max_sh_per_se);
> return (~data) & mask;
> }
>
> see that it still read CC_RB_BACKEND_DISABLE
>
>
> thanks
>
>
> /Monk
>
>


--------------C889808DBE0AF2A0E3EA1FAD
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Monk,<br>
      <br>
      I honestly don't have the slightest idea why we are still
      accessing CC_RB_BACKEND_DISABLE. Maybe it still contains some
      useful values?<br>
      <br>
      Key point was that we needed to stop accessing it all the time to
      avoid triggering problems.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 07.03.2018 um 13:11 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite"
cite="mid:BLUPR12MB04496DB9A508E4AEE114AF2484D80-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">Hi Christian</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">I remember you and AlexD
          mentioned that a handful registers are deprecated for
          greenland (gfx9)</p>
        <p style="margin-top:0;margin-bottom:0">e.g.
          CC_RB_BACKEND_DISABLE</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">do you know why we still
          have this routine ?</p>
        <div style="color: rgb(212, 212, 212); background-color: rgb(30, 30, 30); font-family: &quot;Droid Sans Mono&quot;, monospace, monospace, &quot;Droid Sans Fallback&quot;; font-size: 14px; line-height: 19px; white-space: pre;">
<div><span style="color: #569cd6;">static</span> u32 <span style="color: #dcdcaa;">
gfx_v9_0_get_rb_active_bitmap</span>(<span style="color: #569cd6;">struct</span> amdgpu_device *adev)</div>
<div>{</div>
<div>    u32 data, mask;</div>


<div>    data = <span style="color: #dcdcaa;">RREG32_SOC15</span>(GC, <span style="color: #b5cea8;">
0</span>, mmCC_RB_BACKEND_DISABLE);</div>
<div>    data |= <span style="color: #dcdcaa;">RREG32_SOC15</span>(GC, <span style="color: #b5cea8;">
0</span>, mmGC_USER_RB_BACKEND_DISABLE);</div>


<div>    data &amp;= CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;</div>
<div>    data &gt;&gt;= GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;</div>


<div>    mask = <span style="color: #dcdcaa;">amdgpu_gfx_create_bitmask</span>(adev-&gt;<span style="color: #9cdcfe;">gfx</span>.<span style="color: #9cdcfe;">config</span>.<span style="color: #9cdcfe;">max_backends_per_se</span> /</div>
<div>                     adev-&gt;<span style="color: #9cdcfe;">gfx</span>.<span style="color: #9cdcfe;">config</span>.<span style="color: #9cdcfe;">max_sh_per_se</span>);</div>


<div>    <span style="color: #c586c0;">return</span> (~data) &amp; mask;</div>
<div>}</div>
</div>
        <br>
        <p style="margin-top:0;margin-bottom:0">see that it still read <span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size: 16px;">CC_RB_BACKEND_DISABLE</span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size: 16px;"><br>
          </span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size: 16px;">thanks</span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size: 16px;"><br>
          </span></p>
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size: 16px;">/Monk</span></p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------C889808DBE0AF2A0E3EA1FAD--

--===============1551492939==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1551492939==--
