From: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] fix double ;;s in code
Date: Mon, 19 Feb 2018 21:33:49 -0800
Message-ID: <f81083a2-4c64-b694-2059-16894e19a79e__49313.3922377185$1519122602$gmane$org@synopsys.com>
References: <20180217211955.GE9640@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2113243061=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180217211955.GE9640@amd>
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
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kernel list <linux-kernel-u79uwXL29TZUIDd8j+nm9g@public.gmane.org>, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, paulus-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, scott.bauer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, David1.Zhou-5C7GfCeVMHo@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, shli-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, mhocko-IBi9RG/b67k@public.gmane.org, vbabka-AlSwsSmVLrQ@public.gmane.org, Vladislav.Zakharov@s
Cc: Luis de Bethencourt <luisbg-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

--===============2113243061==
Content-Type: multipart/alternative;
	boundary="------------5F0C80F3EF0A744020863B16"
Content-Language: en-US

--------------5F0C80F3EF0A744020863B16
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 02/17/2018 01:19 PM, Pavel Machek wrote:
> Fix double ;;'s in code.
>
> Signed-off-by: Pavel Machek<pavel-+ZI9xUNit7I@public.gmane.org>
>
> diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
> index 9d27331..ec12fe1 100644
> --- a/arch/arc/kernel/setup.c
> +++ b/arch/arc/kernel/setup.c
> @@ -373,7 +373,7 @@ static void arc_chk_core_config(void)
>   {
>   	struct cpuinfo_arc *cpu = &cpuinfo_arc700[smp_processor_id()];
>   	int saved = 0, present = 0;
> -	char *opt_nm = NULL;;
> +	char *opt_nm = NULL;
>   
>   	if (!cpu->extn.timer0)
>   		panic("Timer0 is not present!\n");
> diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
> index 333daab..183391d 100644
> --- a/arch/arc/kernel/unwind.c
> +++ b/arch/arc/kernel/unwind.c
> @@ -366,7 +366,7 @@ static void init_unwind_hdr(struct unwind_table *table,
>   	return;
>   
>   ret_err:
> -	panic("Attention !!! Dwarf FDE parsing errors\n");;
> +	panic("Attention !!! Dwarf FDE parsing errors\n");
>   }
>   

I have a fix from Luis to same effect from Jan sitting in my for-curr

Thx for it anyways.

-Vineet

--------------5F0C80F3EF0A744020863B16
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 02/17/2018 01:19 PM, Pavel Machek
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20180217211955.GE9640@amd">
      <pre wrap="">Fix double ;;'s in code.

Signed-off-by: Pavel Machek <a class="moz-txt-link-rfc2396E" href="mailto:pavel-+ZI9xUNit7I@public.gmane.org" moz-do-not-send="true">&lt;pavel-+ZI9xUNit7I@public.gmane.org&gt;</a>

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 9d27331..ec12fe1 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -373,7 +373,7 @@ static void arc_chk_core_config(void)
 {
 	struct cpuinfo_arc *cpu = &amp;cpuinfo_arc700[smp_processor_id()];
 	int saved = 0, present = 0;
-	char *opt_nm = NULL;;
+	char *opt_nm = NULL;
 
 	if (!cpu-&gt;extn.timer0)
 		panic("Timer0 is not present!\n");
diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
index 333daab..183391d 100644
--- a/arch/arc/kernel/unwind.c
+++ b/arch/arc/kernel/unwind.c
@@ -366,7 +366,7 @@ static void init_unwind_hdr(struct unwind_table *table,
 	return;
 
 ret_err:
-	panic("Attention !!! Dwarf FDE parsing errors\n");;
+	panic("Attention !!! Dwarf FDE parsing errors\n");
 }
 </pre>
    </blockquote>
    <br>
    <font face="DejaVu Sans">I have a fix from Luis to same effect from
      Jan sitting in my for-curr<br>
      <br>
      Thx for it anyways.<br>
      <br>
      -Vineet<br>
    </font>
  </body>
</html>

--------------5F0C80F3EF0A744020863B16--

--===============2113243061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2113243061==--
