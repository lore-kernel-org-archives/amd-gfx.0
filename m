From: zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Changes to let KFD use render node VMs
Date: Fri, 2 Mar 2018 11:18:15 +0800
Message-ID: <55806a4d-c80f-6b1b-a90b-c8fe6bbfdfaa@amd.com>
References: <22204b36-3974-2853-f3f8-2fbd30b05418@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1085547160=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <22204b36-3974-2853-f3f8-2fbd30b05418-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

--===============1085547160==
Content-Type: multipart/alternative;
	boundary="------------6ED85072580874A2A93FCDEB"
Content-Language: en-US

--------------6ED85072580874A2A93FCDEB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Felix,

Out of patches, Could I ask what the difference of 
AMDGPU_VM_CONTEXT_COMPUTE/GFX is?

After you merge kfd_vm to amdgpu_vm, does the difference still exist?


Thanks,

David Zhou


On 2018年03月02日 06:58, Felix Kuehling wrote:
> Hi Christian,
>
> I have a working patch series against amd-kfg-staging that lets KFD use
> VMs from render node FDs, as we discussed. There are two patches in that
> series that touch amdgpu_vm.[ch] that I'd like your feedback on before I
> commit the changes to amd-kfd-staging and include them in my upstream
> patch series for KFD GPUVM support. See attached.
>
> Thanks,
>    Felix
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------6ED85072580874A2A93FCDEB
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Felix,</p>
    <p>Out of patches, Could I ask what the difference of 
      AMDGPU_VM_CONTEXT_COMPUTE/GFX is?</p>
    <p>After you merge kfd_vm to amdgpu_vm, does the difference still
      exist?</p>
    <p><br>
    </p>
    <p>Thanks,</p>
    <p>David Zhou<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2018年03月02日 06:58, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:22204b36-3974-2853-f3f8-2fbd30b05418-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">Hi Christian,

I have a working patch series against amd-kfg-staging that lets KFD use
VMs from render node FDs, as we discussed. There are two patches in that
series that touch amdgpu_vm.[ch] that I'd like your feedback on before I
commit the changes to amd-kfd-staging and include them in my upstream
patch series for KFD GPUVM support. See attached.

Thanks,
  Felix

</pre>
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

--------------6ED85072580874A2A93FCDEB--

--===============1085547160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1085547160==--
