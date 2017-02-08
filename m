From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBbUEFUQ0hdIGRybS9hbWRncHU6Zml4?=
 =?UTF-8?Q?_amdgpu=5fsa=5fbo=5fnew_error?=
Date: Wed, 8 Feb 2017 16:59:10 +0100
Message-ID: <c275b812-8c58-0410-16ad-b038e9213fa1@vodafone.de>
References: <1486546917-1464-1-git-send-email-Monk.Liu@amd.com>
 <4ac7f30d-fde6-b1e3-e5de-fc518b180548@vodafone.de>
 <a2254528-29ca-44bb-8cb9-09fd428af241@daenzer.net>
 <DM5PR12MB161067C1383FC5829F4FCD8984420@DM5PR12MB1610.namprd12.prod.outlook.com>
 <c4776332-809a-da57-88a9-172b72743ede@vodafone.de>
 <99ba2b49-6409-0a47-1bc1-f873d69a58d8@daenzer.net>
 <DM5PR12MB1610D9A7A6D35390193ED57D84420@DM5PR12MB1610.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0414083546=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1610D9A7A6D35390193ED57D84420-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0414083546==
Content-Type: multipart/alternative;
 boundary="------------FDB12EC997DDF0FFB0175A41"

This is a multi-part message in MIME format.
--------------FDB12EC997DDF0FFB0175A41
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.02.2017 um 16:53 schrieb Liu, Monk:
>
> agreed, why not just use cpu to clear it ? is it because performance ?
>

Pixel Ding removed the CPU clear because "There's a failure caused by 
this is that handshaking gets timeout of SRIOV virtual function."

I can only assume that this is really adding to much delay at bootup.

> ------------------------------------------------------------------------
> *发件人:* Michel Dänzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
> *发送时间:* 2017年2月8日 23:52:02
> *收件人:* Christian König; Liu, Monk
> *抄送:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *主题:* Re: 答复: [PATCH] drm/amdgpu:fix amdgpu_sa_bo_new error
> On 09/02/17 12:30 AM, Christian König wrote:
> > The IB test make the decision if the hardware is working or not.
> >
> > So they should be the first commands (except for the ring tests) we send
> > to the hardware.
> >
> > When we allocate the fb before the test we send the clear command to the
> > hardware without knowing if the hardware really works or not.
> >
> > Not a big issue, but I think the order makes more sense that way.
>
> I just wonder if it's worth all the trouble, just to clear the fbcon
> buffer[0], if the result is that the console output is delayed, possibly
> indefinitely.

Actually that change is quite beneficial because the IB tests where 
usually revealing any problem.

Not 100% sure, but when we initialize the fb later that might actually 
allow us to better track such problems down.

Going to check that,
Christian.

>
> [0] We don't have any other hardware acceleration for fbcon, so its BO
> is only accessed by the CPU and display hardware after this, and has to
> be pinned in the CPU visible area of VRAM at all times anyway.
>
>
> -- 
> Earthling Michel Dänzer               | http://www.amd.com 
> <http://www.amd.com>
> Libre software enthusiast             |             Mesa and X developer



--------------FDB12EC997DDF0FFB0175A41
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 08.02.2017 um 16:53 schrieb Liu,
      Monk:<br>
    </div>
    <blockquote
cite="mid:DM5PR12MB1610D9A7A6D35390193ED57D84420-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <meta content="text/html; charset=UTF-8">
      <style type="text/css" style="">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
      <div dir="ltr">
        <div id="x_divtagdefaultwrapper" dir="ltr"
          style="font-size:12pt; color:#000000;
          font-family:Calibri,Arial,Helvetica,sans-serif">
          <p>agreed, why not just use cpu to clear it ? is it because
            performance ?<br>
          </p>
        </div>
      </div>
    </blockquote>
    <br>
    Pixel Ding removed the CPU clear because "There's a failure caused
    by this is that handshaking gets timeout of SRIOV virtual function."<br>
    <br>
    I can only assume that this is really adding to much delay at
    bootup.<br>
    <br>
    <blockquote
cite="mid:DM5PR12MB1610D9A7A6D35390193ED57D84420-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <div dir="ltr">
        <div id="x_divtagdefaultwrapper" dir="ltr"
          style="font-size:12pt; color:#000000;
          font-family:Calibri,Arial,Helvetica,sans-serif">
          <p>
          </p>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            color="#000000" face="Calibri, sans-serif"><b>发件人:</b>
            Michel Dänzer <a class="moz-txt-link-rfc2396E" href="mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">&lt;michel-otUistvHUpPR7s880joybQ@public.gmane.org&gt;</a><br>
            <b>发送时间:</b> 2017年2月8日 23:52:02<br>
            <b>收件人:</b> Christian König; Liu, Monk<br>
            <b>抄送:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <b>主题:</b> Re: 答复: [PATCH] drm/amdgpu:fix amdgpu_sa_bo_new
            error</font>
          <div> </div>
        </div>
      </div>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">On 09/02/17 12:30 AM, Christian König
            wrote:<br>
            &gt; The IB test make the decision if the hardware is
            working or not.<br>
            &gt; <br>
            &gt; So they should be the first commands (except for the
            ring tests) we send<br>
            &gt; to the hardware.<br>
            &gt; <br>
            &gt; When we allocate the fb before the test we send the
            clear command to the<br>
            &gt; hardware without knowing if the hardware really works
            or not.<br>
            &gt; <br>
            &gt; Not a big issue, but I think the order makes more sense
            that way.<br>
            <br>
            I just wonder if it's worth all the trouble, just to clear
            the fbcon<br>
            buffer[0], if the result is that the console output is
            delayed, possibly<br>
            indefinitely.<br>
          </div>
        </span></font></blockquote>
    <br>
    Actually that change is quite beneficial because the IB tests where
    usually revealing any problem.<br>
    <br>
    Not 100% sure, but when we initialize the fb later that might
    actually allow us to better track such problems down.<br>
    <br>
    Going to check that,<br>
    Christian.<br>
    <br>
    <blockquote
cite="mid:DM5PR12MB1610D9A7A6D35390193ED57D84420-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite"><font size="2"><span style="font-size:10pt;">
          <div class="PlainText">
            <br>
            [0] We don't have any other hardware acceleration for fbcon,
            so its BO<br>
            is only accessed by the CPU and display hardware after this,
            and has to<br>
            be pinned in the CPU visible area of VRAM at all times
            anyway.<br>
            <br>
            <br>
            -- <br>
            Earthling Michel Dänzer               |               <a
              moz-do-not-send="true" href="http://www.amd.com">
              http://www.amd.com</a><br>
            Libre software enthusiast             |             Mesa and
            X developer<br>
          </div>
        </span></font>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------FDB12EC997DDF0FFB0175A41--

--===============0414083546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0414083546==--
