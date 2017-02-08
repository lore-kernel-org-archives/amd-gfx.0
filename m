From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_[PATCH]_drm/amdgpu:fix_amdgpu=5fs?=
 =?UTF-8?Q?a=5fbo=5fnew_error?=
Date: Wed, 8 Feb 2017 16:30:58 +0100
Message-ID: <c4776332-809a-da57-88a9-172b72743ede@vodafone.de>
References: <1486546917-1464-1-git-send-email-Monk.Liu@amd.com>
 <4ac7f30d-fde6-b1e3-e5de-fc518b180548@vodafone.de>
 <a2254528-29ca-44bb-8cb9-09fd428af241@daenzer.net>
 <DM5PR12MB161067C1383FC5829F4FCD8984420@DM5PR12MB1610.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1268114418=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB161067C1383FC5829F4FCD8984420-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
--===============1268114418==
Content-Type: multipart/alternative;
 boundary="------------BE4262EC5DBA35350F6EAD28"

This is a multi-part message in MIME format.
--------------BE4262EC5DBA35350F6EAD28
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

The IB test make the decision if the hardware is working or not.

So they should be the first commands (except for the ring tests) we send 
to the hardware.

When we allocate the fb before the test we send the clear command to the 
hardware without knowing if the hardware really works or not.

Not a big issue, but I think the order makes more sense that way.

Regards,
Christian.

Am 08.02.2017 um 16:21 schrieb Liu, Monk:
>
> yeah, make sense
>
> @Christian, why move fbdev_init() further down after ib test ? any 
> consideration ?
>
> ------------------------------------------------------------------------
> *发件人:* Michel Dänzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
> *发送时间:* 2017年2月8日 23:19:23
> *收件人:* Christian König; Liu, Monk
> *抄送:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *主题:* Re: [PATCH] drm/amdgpu:fix amdgpu_sa_bo_new error
> On 08/02/17 07:52 PM, Christian König wrote:
> > Am 08.02.2017 um 10:41 schrieb Monk Liu:
> >> ib_pool init should prior to fbdev_init, otherwise
> >> there will be error from amdgpu_sa_bo_new
> >> (amdgpu_sa.c:323)
> >>
> >> fbdev_init will call ttm_validate which further call
> >> amdgpu_sa_bo_new.
> >>
> >> Change-Id: I3a969570d443f61a44f67b0d76b3871ca5c3ea81
> >> Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> index afcae15..4169bb1 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -1918,14 +1918,14 @@ int amdgpu_device_init(struct amdgpu_device
> >> *adev,
> >>       /* Get a log2 for easy divisions. */
> >>       adev->mm_stats.log2_max_MBps = ilog2(max(1u, max_MBps));
> >>   -    amdgpu_fbdev_init(adev);
> >> -
> >>       r = amdgpu_ib_pool_init(adev);
> >>       if (r) {
> >>           dev_err(adev->dev, "IB initialization failed (%d).\n", r);
> >>           goto failed;
> >>       }
> >>   +    amdgpu_fbdev_init(adev);
> >> +
> >
> > As noted internally as well, please more that one more further down
> > behind the call to amdgpu_ib_ring_tests().
>
> If I understand correctly, that could result in no console output in the
> worst case if there's trouble with the ring & IB tests? That doesn't
> seem very good.
>
>
> -- 
> Earthling Michel Dänzer               | http://www.amd.com 
> <http://www.amd.com>
> Libre software enthusiast             |             Mesa and X developer
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------BE4262EC5DBA35350F6EAD28
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">The IB test make the decision if the
      hardware is working or not.<br>
      <br>
      So they should be the first commands (except for the ring tests)
      we send to the hardware.<br>
      <br>
      When we allocate the fb before the test we send the clear command
      to the hardware without knowing if the hardware really works or
      not.<br>
      <br>
      Not a big issue, but I think the order makes more sense that way.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 08.02.2017 um 16:21 schrieb Liu, Monk:<br>
    </div>
    <blockquote
cite="mid:DM5PR12MB161067C1383FC5829F4FCD8984420-2J9CzHegvk++jCVTvoAFKAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
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
          <p>yeah, make sense</p>
          <p>@Christian, why move fbdev_init() further down after ib
            test ? any consideration ?<br>
          </p>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            color="#000000" face="Calibri, sans-serif"><b>发件人:</b>
            Michel Dänzer <a class="moz-txt-link-rfc2396E" href="mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">&lt;michel-otUistvHUpPR7s880joybQ@public.gmane.org&gt;</a><br>
            <b>发送时间:</b> 2017年2月8日 23:19:23<br>
            <b>收件人:</b> Christian König; Liu, Monk<br>
            <b>抄送:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <b>主题:</b> Re: [PATCH] drm/amdgpu:fix amdgpu_sa_bo_new error</font>
          <div> </div>
        </div>
      </div>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">On 08/02/17 07:52 PM, Christian König
            wrote:<br>
            &gt; Am 08.02.2017 um 10:41 schrieb Monk Liu:<br>
            &gt;&gt; ib_pool init should prior to fbdev_init, otherwise<br>
            &gt;&gt; there will be error from amdgpu_sa_bo_new<br>
            &gt;&gt; (amdgpu_sa.c:323)<br>
            &gt;&gt;<br>
            &gt;&gt; fbdev_init will call ttm_validate which further
            call<br>
            &gt;&gt; amdgpu_sa_bo_new.<br>
            &gt;&gt;<br>
            &gt;&gt; Change-Id:
            I3a969570d443f61a44f67b0d76b3871ca5c3ea81<br>
            &gt;&gt; Signed-off-by: Monk Liu <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            &gt;&gt; ---<br>
            &gt;&gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4
            ++--<br>
            &gt;&gt;   1 file changed, 2 insertions(+), 2 deletions(-)<br>
            &gt;&gt;<br>
            &gt;&gt; diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            &gt;&gt; index afcae15..4169bb1 100644<br>
            &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            &gt;&gt; @@ -1918,14 +1918,14 @@ int
            amdgpu_device_init(struct amdgpu_device<br>
            &gt;&gt; *adev,<br>
            &gt;&gt;       /* Get a log2 for easy divisions. */<br>
            &gt;&gt;       adev-&gt;mm_stats.log2_max_MBps =
            ilog2(max(1u, max_MBps));<br>
            &gt;&gt;   -    amdgpu_fbdev_init(adev);<br>
            &gt;&gt; -<br>
            &gt;&gt;       r = amdgpu_ib_pool_init(adev);<br>
            &gt;&gt;       if (r) {<br>
            &gt;&gt;           dev_err(adev-&gt;dev, "IB initialization
            failed (%d).\n", r);<br>
            &gt;&gt;           goto failed;<br>
            &gt;&gt;       }<br>
            &gt;&gt;   +    amdgpu_fbdev_init(adev);<br>
            &gt;&gt; +<br>
            &gt; <br>
            &gt; As noted internally as well, please more that one more
            further down<br>
            &gt; behind the call to amdgpu_ib_ring_tests().<br>
            <br>
            If I understand correctly, that could result in no console
            output in the<br>
            worst case if there's trouble with the ring &amp; IB tests?
            That doesn't<br>
            seem very good.<br>
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

--------------BE4262EC5DBA35350F6EAD28--

--===============1268114418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1268114418==--
