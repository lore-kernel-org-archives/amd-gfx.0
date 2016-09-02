From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: prevent command submission failures under
 memory pressure
Date: Fri, 2 Sep 2016 09:38:17 +0200
Message-ID: <201fce63-7708-ef92-5ec0-9dae006f2367@vodafone.de>
References: <1472739370-6579-1-git-send-email-deathsimple@vodafone.de>
 <1472739370-6579-2-git-send-email-deathsimple@vodafone.de>
 <MWHPR12MB16940502B576609723CEDD53F7E20@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1983323135=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB16940502B576609723CEDD53F7E20-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1983323135==
Content-Type: multipart/alternative;
 boundary="------------E65FD6C71082B18D511F22D5"

This is a multi-part message in MIME format.
--------------E65FD6C71082B18D511F22D5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 01.09.2016 um 16:33 schrieb Deucher, Alexander:
>> >return r; > + > + return -ENOMEM; > +} 
> Unreachable code. Other than that looks good.

Ups, indeed just a merge error.

> With that fixed: Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Thanks for the review, I've just pushed the resulting patches to 
amd-staging-4.6.

Marek you might want to try and raise the limits now how much VRAM can 
be used by a single command submission. If I remember correctly that was 
rather conservatively.

Regards,
Christian.

--------------E65FD6C71082B18D511F22D5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Am 01.09.2016 um 16:33 schrieb Deucher,
      Alexander:<br>
    </div>
    <blockquote
cite="mid:MWHPR12MB16940502B576609723CEDD53F7E20-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <blockquote type="cite" style="color: #000000;"><span
          class="moz-txt-citetags">&gt; </span> return r;
        <span class="moz-txt-citetags">&gt; </span>+
        <span class="moz-txt-citetags">&gt; </span>+ return -ENOMEM;
        <span class="moz-txt-citetags">&gt; </span>+}
      </blockquote>
      Unreachable code. Other than that looks good.</blockquote>
    <br>
    Ups, indeed just a merge error.<br>
    <br>
    <blockquote
cite="mid:MWHPR12MB16940502B576609723CEDD53F7E20-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite"> With that fixed:
      Reviewed-by: Alex Deucher <a moz-do-not-send="true"
        class="moz-txt-link-rfc2396E"
        href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a></blockquote>
    Thanks for the review, I've just pushed the resulting patches to
    amd-staging-4.6.<br>
    <br>
    Marek you might want to try and raise the limits now how much VRAM
    can be used by a single command submission. If I remember correctly
    that was rather conservatively.<br>
    <br>
    Regards,<br>
    Christian.<br>
  </body>
</html>

--------------E65FD6C71082B18D511F22D5--

--===============1983323135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1983323135==--
