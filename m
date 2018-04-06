From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc: always steal the first 32MB of vram
 for fw hand-over
Date: Fri, 6 Apr 2018 07:23:20 -0400
Message-ID: <40be8e12-8f2e-449f-d09e-aa46aa396f4c@amd.com>
References: <1522952800-32300-1-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_MFUWDCDtcVXcnF27DAuE3L5kC9EqKFeCPs4V1AM5gL0A@mail.gmail.com>
 <87cc962a-8a35-36d6-6b48-85c156e68f04@daenzer.net>
 <1c6e6260-10cf-f189-45b3-74fd2d1c991c@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1070418183=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1c6e6260-10cf-f189-45b3-74fd2d1c991c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "Ranjbar,
 Ramin" <ramin.ranjbar-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1070418183==
Content-Type: multipart/alternative;
 boundary="------------1C71B3475E02992F5C717C35"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1C71B3475E02992F5C717C35
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Me and Alex talked to a BIOS guys yesterday exactly about that, a 
dynamic way to query this info from BIOS, he just told us to reserve 32M 
to cover 4K display.

Andrey


On 04/06/2018 04:30 AM, Christian König wrote:
>> I wonder if there's no way to determine which part of VRAM is being
>> scanned out. If there was, we could just create a normal BO covering
>> that, which would get destroyed once no CRTC references it anymore.
>
> Unfortunately it goes further than that. The stolen VRAM is needed for 
> VGA emulation, not only for scanout.
>
> But yes I agree that we somehow figure that value out from the BIOS. 
> If I'm not completely mistaken I've also seen some atombios table with 
> that info in some discussion.
>
> Christian. 


--------------1C71B3475E02992F5C717C35
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Me and Alex talked to a BIOS guys yesterday exactly about that, a
      dynamic way to query this info from BIOS, he just told us to
      reserve 32M to cover 4K display.</p>
    <p>Andrey<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 04/06/2018 04:30 AM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1c6e6260-10cf-f189-45b3-74fd2d1c991c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
      <blockquote type="cite" style="color: #000000;">I wonder if
        there's no way to determine which part of VRAM is being
        <br>
        scanned out. If there was, we could just create a normal BO
        covering
        <br>
        that, which would get destroyed once no CRTC references it
        anymore.
        <br>
      </blockquote>
      <br>
      Unfortunately it goes further than that. The stolen VRAM is needed
      for VGA emulation, not only for scanout.
      <br>
      <br>
      But yes I agree that we somehow figure that value out from the
      BIOS. If I'm not completely mistaken I've also seen some atombios
      table with that info in some discussion.
      <br>
      <br>
      Christian.
    </blockquote>
    <br>
  </body>
</html>

--------------1C71B3475E02992F5C717C35--

--===============1070418183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1070418183==--
