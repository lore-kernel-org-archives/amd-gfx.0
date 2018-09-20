From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: amdgpu fails compilation with CONFIG_FORTIFY_SOURCE
Date: Thu, 20 Sep 2018 10:59:01 -0400
Message-ID: <a2dd9da6-3f34-8e44-944e-3ccb2797b3dd@amd.com>
References: <CANFv0+2=yn983rcLizDEiuDSND9rE4BZuGBeHwZ6J39CC_kgkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1513756164=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CANFv0+2=yn983rcLizDEiuDSND9rE4BZuGBeHwZ6J39CC_kgkw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?Q?J=c3=a1n_Kosterec?= <johnypean-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============1513756164==
Content-Type: multipart/alternative;
 boundary="------------0366D9536A6ECBC04C1051A5"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0366D9536A6ECBC04C1051A5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Thanks for the fix.

We've moved to logging functionality more closely aligned with the rest of DRM and dropped logger.c a while back.

Harry

On 2018-09-05 02:43 PM, Ján Kosterec wrote:
> amdgpu driver fails compilation when compiling with CONFIG_FORTIFY_SOURCE kernel option:
>
> In function ‘memmove’,
>     inlined from ‘append_entry’ at drivers/gpu/drm/amd/amdgpu/../display/dc/basics/logger.c:258:2,
>     inlined from ‘dm_logger_append_va.part.5’ at drivers/gpu/drm/amd/amdgpu/../display/dc/basics/logger.c:349:4:
> ./include/linux/string.h:356:4: error: call to ‘__read_overflow2’ declared with attribute error: detected read beyond size of object passed as 2nd parameter
>     __read_overflow2();
>     ^~~~~~~~~~~~~~~~~~
>
> I have attached a patch which resolves this problem.
> Regards,
> Jan
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------0366D9536A6ECBC04C1051A5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Thanks for the fix.<br>
    <br>
    We've moved to logging functionality more closely aligned with the
    rest of DRM and dropped logger.c a while back.<br>
    <br>
    Harry<br>
    <br>
    <div class="moz-cite-prefix">On 2018-09-05 02:43 PM, Ján Kosterec
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CANFv0+2=yn983rcLizDEiuDSND9rE4BZuGBeHwZ6J39CC_kgkw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div dir="ltr">
        <pre class="gmail-bz_comment_text">amdgpu driver fails compilation when compiling with CONFIG_FORTIFY_SOURCE kernel option:

In function ‘memmove’,
    inlined from ‘append_entry’ at drivers/gpu/drm/amd/amdgpu/../display/dc/basics/logger.c:258:2,
    inlined from ‘dm_logger_append_va.part.5’ at drivers/gpu/drm/amd/amdgpu/../display/dc/basics/logger.c:349:4:
./include/linux/string.h:356:4: error: call to ‘__read_overflow2’ declared with attribute error: detected read beyond size of object passed as 2nd parameter
    __read_overflow2();
    ^~~~~~~~~~~~~~~~~~

I have attached a patch which resolves this problem.</pre>
        <div>
          <div dir="ltr" class="gmail_signature"
            data-smartmail="gmail_signature">
            <div>
              <div>Regards,</div>
              <div>Jan</div>
            </div>
          </div>
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

--------------0366D9536A6ECBC04C1051A5--

--===============1513756164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1513756164==--
