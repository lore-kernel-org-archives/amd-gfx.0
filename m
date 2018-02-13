From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: cleanup VCN IB generation
Date: Tue, 13 Feb 2018 14:57:40 +0100
Message-ID: <64b53d0a-62d6-cfe5-341d-2aa5548c4f8d@gmail.com>
References: <20180207194822.7878-1-christian.koenig@amd.com>
 <20180207194822.7878-2-christian.koenig@amd.com>
 <839e2b57-edf4-d389-56ab-1a97dd84c832@amd.com>
 <6262040a-ef05-bda4-904e-d8a5954239bc@gmail.com>
 <eca08a4f-cc5c-ab86-acf0-f04444f733f4@amd.com>
 <2992ee3b-c077-9222-b1e1-79ea9cb3c143@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2025797140=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2992ee3b-c077-9222-b1e1-79ea9cb3c143-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============2025797140==
Content-Type: multipart/alternative;
 boundary="------------D714ABE9B950A43BECBB5038"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------D714ABE9B950A43BECBB5038
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

It's always the obvious. Leo any more comments on this?

If not can we get your rb on this patch as well?

Andrey if Leo gives his ok can you commit both? I'm on vacation and 
don't want to mess with this at the moment.

Thanks,
Christian.

Am 13.02.2018 um 14:50 schrieb Andrey Grodzovsky:
>
> Found the issue, amdgpu_vcn_dec_get_destroy_msg was missing struct 
> amdgpu_bo *bo *= NULL*; and so amdgpu_bo_create_reserved would not 
> call amdgpu_bo_create.
>
> Attached updated patch.
>
> Thanks,
>
> Andrey
>
>
> On 02/12/2018 02:46 PM, Andrey Grodzovsky wrote:
>> Tested with latest amd-staging-drm-next + VCN patch on top. VCN dec 
>> tests pass but when modprobing amdgpu I get a few warnings and 
>> BUG_ONs - log attached. UVD is not enabled so can't test the UVD patch.
>>
>>
>> Thanks,
>>
>> Andrey
>>
>>
>> On 02/09/2018 07:31 AM, Christian König wrote:
>>> Question is rather can somebody please test this on Raven?
>>>
>>> Thanks,
>>> Christian. 
>>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------D714ABE9B950A43BECBB5038
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">It's always the obvious. Leo any more
      comments on this?<br>
      <br>
      If not can we get your rb on this patch as well?<br>
      <br>
      Andrey if Leo gives his ok can you commit both? I'm on vacation
      and don't want to mess with this at the moment.<br>
      <br>
      Thanks,<br>
      Christian.<br>
      <br>
      Am 13.02.2018 um 14:50 schrieb Andrey Grodzovsky:<br>
    </div>
    <blockquote type="cite"
      cite="mid:2992ee3b-c077-9222-b1e1-79ea9cb3c143-5C7GfCeVMHo@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <p>Found the issue, amdgpu_vcn_dec_get_destroy_msg was missing
        struct amdgpu_bo *bo <b>= NULL</b>; and so
        amdgpu_bo_create_reserved would not call amdgpu_bo_create.</p>
      <p>Attached updated patch.</p>
      <p>Thanks,</p>
      <p>Andrey<br>
      </p>
      <br>
      <div class="moz-cite-prefix">On 02/12/2018 02:46 PM, Andrey
        Grodzovsky wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:eca08a4f-cc5c-ab86-acf0-f04444f733f4-5C7GfCeVMHo@public.gmane.org">Tested
        with latest amd-staging-drm-next + VCN patch on top. VCN dec
        tests pass but when modprobing amdgpu I get a few warnings and
        BUG_ONs - log attached. UVD is not enabled so can't test the UVD
        patch. <br>
        <br>
        <br>
        Thanks, <br>
        <br>
        Andrey <br>
        <br>
        <br>
        On 02/09/2018 07:31 AM, Christian König wrote: <br>
        <blockquote type="cite">Question is rather can somebody please
          test this on Raven? <br>
          <br>
          Thanks, <br>
          Christian. </blockquote>
        <br>
      </blockquote>
      <br>
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

--------------D714ABE9B950A43BECBB5038--

--===============2025797140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2025797140==--
