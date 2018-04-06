From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc: steal the appropriate amount of vram
 for fw hand-over (v2)
Date: Fri, 6 Apr 2018 16:24:49 -0400
Message-ID: <0ec1550a-0445-c2e9-d649-7760906d2a38@amd.com>
References: <20180406195410.5622-1-alexander.deucher@amd.com>
 <d10bbcec-f423-c6b4-f345-eb415e0d4078@amd.com>
 <CADnq5_OetksWNrkwqLP4gLanrBExF2X8Stt0XdrXNUrnGPWmTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1715406329=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_OetksWNrkwqLP4gLanrBExF2X8Stt0XdrXNUrnGPWmTQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1715406329==
Content-Type: multipart/alternative;
 boundary="------------2308AE6FF229A701ECCDAF3C"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------2308AE6FF229A701ECCDAF3C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

OK, sorry for the noise.

Andrey


On 04/06/2018 04:17 PM, Alex Deucher wrote:
>> This will not work unless gmc_v6_0_mc_init in gmc_v6_0_sw_init will be moved
>> before gmc_v6_0_get_vbios_fb_size, real_vram_size
>> is not initialized in this point. Same for other ASICs.
> Yeah, I moved it down.  See below.
>
> Alex
>


--------------2308AE6FF229A701ECCDAF3C
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>OK, sorry for the noise.</p>
    <p>Andrey<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 04/06/2018 04:17 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CADnq5_OetksWNrkwqLP4gLanrBExF2X8Stt0XdrXNUrnGPWmTQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <blockquote type="cite" style="color: #000000;">
        <pre wrap="">This will not work unless gmc_v6_0_mc_init in gmc_v6_0_sw_init will be moved
before gmc_v6_0_get_vbios_fb_size, real_vram_size
is not initialized in this point. Same for other ASICs.
</pre>
      </blockquote>
      <pre wrap="">Yeah, I moved it down.  See below.

Alex

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------2308AE6FF229A701ECCDAF3C--

--===============1715406329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1715406329==--
