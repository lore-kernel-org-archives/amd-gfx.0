From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: kernel BUG at drivers/gpu/drm//ttm/ttm_bo.c:196!
Date: Tue, 5 Feb 2019 16:45:49 +0100
Message-ID: <95cef707-4d19-cbd4-c913-523f4b22c89a@gmail.com>
References: <b1448d56-5dc4-d3f4-db04-e7993533240b@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1592696698=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b1448d56-5dc4-d3f4-db04-e7993533240b-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============1592696698==
Content-Type: multipart/alternative;
 boundary="------------CE9755CFA944AA4149F0B57F"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------CE9755CFA944AA4149F0B57F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Possible, but unlikely.

That sounds more like a reference counting problem where something is 
killing the BO while it is still on the LRU.

Need to double check how that can happen,
Christian.

Am 05.02.19 um 16:02 schrieb Michel Dänzer:
> Hit this with an amdgpu piglit run today, see the attached dmesg
> excerpt. It's ttm_bo_ref_bug() being called from ttm_bo_del_from_lru().
> Maybe this is still fallout from the "cleanup setting bulk_movable" change?
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------CE9755CFA944AA4149F0B57F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Possible, but unlikely.<br>
      <br>
      That sounds more like a reference counting problem where something
      is killing the BO while it is still on the LRU.<br>
      <br>
      Need to double check how that can happen,<br>
      Christian.<br>
      <br>
      Am 05.02.19 um 16:02 schrieb Michel Dänzer:<br>
    </div>
    <blockquote type="cite"
      cite="mid:b1448d56-5dc4-d3f4-db04-e7993533240b-otUistvHUpPR7s880joybQ@public.gmane.org">
      <pre class="moz-quote-pre" wrap="">
Hit this with an amdgpu piglit run today, see the attached dmesg
excerpt. It's ttm_bo_ref_bug() being called from ttm_bo_del_from_lru().
Maybe this is still fallout from the "cleanup setting bulk_movable" change?


</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------CE9755CFA944AA4149F0B57F--

--===============1592696698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1592696698==--
