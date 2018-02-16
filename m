From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: amdgpu with 8+ cards for GPU mining?
Date: Fri, 16 Feb 2018 19:42:31 +0100
Message-ID: <5bad2ebd-2de3-028e-e8e5-918d04e3dfb5@gmail.com>
References: <CAPoeEY80EyzCrRfTFp7E9VreZAzEUC4SQ6Kuqynn2Q3oL9CB5A@mail.gmail.com>
 <2c8f8862-9884-fd90-b8bb-0949ecd18185@gmail.com>
 <CAPoeEY8F_uHAZbh2o12X7JME8oG_y18CxoJhs3_Q4mxku-_F2Q@mail.gmail.com>
 <98480e52-41aa-1aa5-deee-e72ac3338310@amd.com>
 <CAPoeEY9w63K4JsgcGH7b7X7VCjDZwTKFUPxbjrSH=_62kJP7Yg@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0311779954=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPoeEY9w63K4JsgcGH7b7X7VCjDZwTKFUPxbjrSH=_62kJP7Yg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Joseph Wang <joequant-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: dev-Kfi0mlvI6tSGglJvpFV4uA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0311779954==
Content-Type: multipart/alternative;
 boundary="------------29C7BEC34FF4F110454725EE"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------29C7BEC34FF4F110454725EE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 16.02.2018 um 19:17 schrieb Joseph Wang:
> Here are the logs for the eight card case.
>
> cc'ing the Mageia linux group since I'm using that distribution for 
> development.
>
> Three questions:
>
> 1) (this might be for the mageia people) What's the easiest way of 
> booting up the system without loading in the amdgpu module?

Usually modprobe.blacklist=amdgpu should work independent of the 
distribution.

Christian.

>
> 2) What's the easiest way of generating a patch from the amd-gfx 
> repository against the mainline kernel.  The reason for this is that 
> it's easier
> for me to do local configuration management if I generate rpms locally.
>
> 3) Also right now I'm running a mix of software.  I take the opencl 
> legacy drivers from the rpm package and they work against amdgpu.  The 
> trouble
> is that they replace them mesa drivers and so I can't get opencl.  I'd 
> like to move onto ROCm but that involves a lot of configuration 
> management.
>
> The good news is that I have a system with 8 gpu cards that works as a 
> mining system.
>
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------29C7BEC34FF4F110454725EE
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 16.02.2018 um 19:17 schrieb Joseph
      Wang:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAPoeEY9w63K4JsgcGH7b7X7VCjDZwTKFUPxbjrSH=_62kJP7Yg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_extra">Here are the logs for the eight card
          case.  <br>
        </div>
        <div class="gmail_extra"><br>
        </div>
        <div class="gmail_extra">cc'ing the Mageia linux group since I'm
          using that distribution for development.</div>
        <div class="gmail_extra"><br>
        </div>
        <div class="gmail_extra">Three questions:</div>
        <div class="gmail_extra"><br>
        </div>
        <div class="gmail_extra">1) (this might be for the mageia
          people) What's the easiest way of booting up the system
          without loading in the amdgpu module?</div>
      </div>
    </blockquote>
    <br>
    Usually modprobe.blacklist=amdgpu should work independent of the
    distribution.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAPoeEY9w63K4JsgcGH7b7X7VCjDZwTKFUPxbjrSH=_62kJP7Yg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_extra"><br>
        </div>
        <div class="gmail_extra">2) What's the easiest way of generating
          a patch from the amd-gfx repository against the mainline
          kernel.  The reason for this is that it's easier</div>
        <div class="gmail_extra">for me to do local configuration
          management if I generate rpms locally.<br>
        </div>
        <div class="gmail_extra"><br>
        </div>
        <div class="gmail_extra">3) Also right now I'm running a mix of
          software.  I take the opencl legacy drivers from the rpm
          package and they work against amdgpu.  The trouble</div>
        <div class="gmail_extra">is that they replace them mesa drivers
          and so I can't get opencl.  I'd like to move onto ROCm but
          that involves a lot of configuration management.</div>
        <div class="gmail_extra"><br>
        </div>
        <div class="gmail_extra">The good news is that I have a system
          with 8 gpu cards that works as a mining system.</div>
        <div class="gmail_extra"><br>
        </div>
        <div class="gmail_extra"><br>
        </div>
        <div class="gmail_extra"><br>
        </div>
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
    <br>
  </body>
</html>

--------------29C7BEC34FF4F110454725EE--

--===============0311779954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0311779954==--
