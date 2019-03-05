From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix kernel Oops caused by change_bit in ARM64
Date: Tue, 5 Mar 2019 09:23:20 +0100
Message-ID: <31761c72-a033-16e7-7440-d695dabd8fe7@gmail.com>
References: <CALKDN1PRNNDMhNKYaNsFdkYCKM4R4tUtQ9svXdmPwBQL6=AzFA@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0169504593=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CALKDN1PRNNDMhNKYaNsFdkYCKM4R4tUtQ9svXdmPwBQL6=AzFA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?5ZGo56OK?= <mfk530-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0169504593==
Content-Type: multipart/alternative;
 boundary="------------BD94C495CAF19AC829945E0F"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------BD94C495CAF19AC829945E0F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.03.19 um 03:37 schrieb 周磊:
> I got this kernel Oops when running ROCm kernel in a ARM64 machine 
> with Vega64 card.
>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 20d7e4775d49..b6945af39b95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -726,8 +726,8 @@ static bool gmc_v9_0_keep_stolen_memory(struct amdgpu_device *adev)
>   static int gmc_v9_0_allocate_vm_inv_eng(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ring *ring;
> -	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS] =
> -		{GFXHUB_FREE_VM_INV_ENGS_BITMAP, MMHUB_FREE_VM_INV_ENGS_BITMAP};
> +	unsigned long vm_inv_engs[AMDGPU_MAX_VMHUBS] =
> +		      {GFXHUB_FREE_VM_INV_ENGS_BITMAP, MMHUB_FREE_VM_INV_ENGS_BITMAP};
>   	unsigned i;
>   	unsigned vmhub, inv_eng;
>   
> @@ -743,7 +743,7 @@ static int gmc_v9_0_allocate_vm_inv_eng(struct amdgpu_device *adev)
>   		}
>   
>   		ring->vm_inv_eng = inv_eng - 1;
> -		change_bit(inv_eng - 1, (unsigned long *)(&vm_inv_engs[vmhub]));
> +		change_bit(inv_eng - 1, &vm_inv_engs[vmhub]);

Good catch, but wrong solution. We should just stop using change_bit to 
change the bitmask.

E.g. use something like "vm_inv_engs[vmhub] &= ~(1 << (inv_eng - 1));" here.

Christian.

>   
>   		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
>   			 ring->name, ring->vm_inv_eng, ring->funcs->vmhub);
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------BD94C495CAF19AC829945E0F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 05.03.19 um 03:37 schrieb 周磊:<br>
    </div>
    <blockquote type="cite"
cite="mid:CALKDN1PRNNDMhNKYaNsFdkYCKM4R4tUtQ9svXdmPwBQL6=AzFA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">I got this kernel Oops when running ROCm kernel in
        a ARM64 machine with Vega64 card.
        <div><br>
          <div>
            <pre style="color:rgb(0,0,0);white-space:pre-wrap">---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 20d7e4775d49..b6945af39b95 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -726,8 +726,8 @@ static bool gmc_v9_0_keep_stolen_memory(struct amdgpu_device *adev)
 static int gmc_v9_0_allocate_vm_inv_eng(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
-	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS] =
-		{GFXHUB_FREE_VM_INV_ENGS_BITMAP, MMHUB_FREE_VM_INV_ENGS_BITMAP};
+	unsigned long vm_inv_engs[AMDGPU_MAX_VMHUBS] =
+		      {GFXHUB_FREE_VM_INV_ENGS_BITMAP, MMHUB_FREE_VM_INV_ENGS_BITMAP};
 	unsigned i;
 	unsigned vmhub, inv_eng;
 
@@ -743,7 +743,7 @@ static int gmc_v9_0_allocate_vm_inv_eng(struct amdgpu_device *adev)
 		}
 
 		ring-&gt;vm_inv_eng = inv_eng - 1;
-		change_bit(inv_eng - 1, (unsigned long *)(&amp;vm_inv_engs[vmhub]));
+		change_bit(inv_eng - 1, &amp;vm_inv_engs[vmhub]);</pre>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    Good catch, but wrong solution. We should just stop using change_bit
    to change the bitmask.<br>
    <br>
    E.g. use something like "vm_inv_engs[vmhub] &amp;= ~(1 &lt;&lt;
    (inv_eng - 1));" here.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CALKDN1PRNNDMhNKYaNsFdkYCKM4R4tUtQ9svXdmPwBQL6=AzFA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div>
          <div>
            <pre style="color:rgb(0,0,0);white-space:pre-wrap">
 
 		dev_info(adev-&gt;dev, "ring %s uses VM inv eng %u on hub %u\n",
 			 ring-&gt;name, ring-&gt;vm_inv_eng, ring-&gt;funcs-&gt;vmhub);</pre>
          </div>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------BD94C495CAF19AC829945E0F--

--===============0169504593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0169504593==--
