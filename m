From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd: Delete unnecessary pr_fmt switch
Date: Mon, 28 Oct 2019 15:34:05 +0000
Message-ID: <DM6PR12MB27789F7136560521E8B2DB88F0660@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20191025212059.10355-1-Yong.Zhao@amd.com>,
 <CADnq5_Pj_g++EPmmDfgNs0c6CWVfPyL4egfD-ps607bLPQ9fGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0382418189=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_Pj_g++EPmmDfgNs0c6CWVfPyL4egfD-ps607bLPQ9fGA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0382418189==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB27789F7136560521E8B2DB88F0660DM6PR12MB2778namp_"

--_000_DM6PR12MB27789F7136560521E8B2DB88F0660DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Modified according to the comment and pushed. Thanks!

Regards,
Yong
________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Monday, October 28, 2019 8:39 AM
To: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd: Delete unnecessary pr_fmt switch

On Fri, Oct 25, 2019 at 5:21 PM Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org> wrote:
>
> Given amdkfd.ko has been merged into amdgpu.ko, this switch is no
> longer useful.
>
> Change-Id: If56b80e086f4ea26f347c70b620b3892afc24ddf
> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c          | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c | 4 ----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c  | 3 ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c   | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c   | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c   | 3 ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    | 3 ---
>  7 files changed, 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index d3da9dde4ee1..fa5471c12c34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -19,7 +19,6 @@
>   * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
> -

Unrelated whitespace change.

>  #include "amdgpu_amdkfd.h"
>  #include "amd_shared.h"
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index e1fbbebce4fd..b6713e0ed1b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -19,10 +19,6 @@
>   * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
> -
> -#undef pr_fmt
> -#define pr_fmt(fmt) "kfd2kgd: " fmt
> -
>  #include <linux/module.h>
>  #include <linux/fdtable.h>
>  #include <linux/uaccess.h>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 0878f59ec340..61cd707158e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -19,9 +19,6 @@
>   * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
> -#undef pr_fmt
> -#define pr_fmt(fmt) "kfd2kgd: " fmt
> -
>  #include <linux/mmu_context.h>
>  #include "amdgpu.h"
>  #include "amdgpu_amdkfd.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> index 6e6f0a99ec06..30897b2d9175 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> @@ -19,7 +19,6 @@
>   * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
> -

Unrelated whitespace change.

>  #include <linux/mmu_context.h>
>
>  #include "amdgpu.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> index bfbddedb2380..ede6ab0cbe4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> @@ -19,7 +19,6 @@
>   * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
> -

Same here.

With those dropped, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

>  #include <linux/mmu_context.h>
>
>  #include "amdgpu.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index c72246f2c08a..47c853ef1051 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -19,9 +19,6 @@
>   * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
> -
> -#define pr_fmt(fmt) "kfd2kgd: " fmt
> -
>  #include <linux/mmu_context.h>
>
>  #include "amdgpu.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 1fbe81094b5f..97114e18c022 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -19,9 +19,6 @@
>   * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
> -
> -#define pr_fmt(fmt) "kfd2kgd: " fmt
> -
>  #include <linux/dma-buf.h>
>  #include <linux/list.h>
>  #include <linux/pagemap.h>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM6PR12MB27789F7136560521E8B2DB88F0660DM6PR12MB2778namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Modified according to the comment and pushed. Thanks!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yong</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, October 28, 2019 8:39 AM<br>
<b>To:</b> Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: Delete unnecessary pr_fmt switch</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Fri, Oct 25, 2019 at 5:21 PM Zhao, Yong &lt;Yon=
g.Zhao-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt;<br>
&gt; Given amdkfd.ko has been merged into amdgpu.ko, this switch is no<br>
&gt; longer useful.<br>
&gt;<br>
&gt; Change-Id: If56b80e086f4ea26f347c70b620b3892afc24ddf<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 -<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c | 4 ----<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c&nbsp; | 3 ---=
<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c&nbsp;&nbsp; | =
1 -<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c&nbsp;&nbsp; | =
1 -<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c&nbsp;&nbsp; | =
3 ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c&nbsp;&nbsp;&nbs=
p; | 3 ---<br>
&gt;&nbsp; 7 files changed, 16 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; index d3da9dde4ee1..fa5471c12c34 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; @@ -19,7 &#43;19,6 @@<br>
&gt;&nbsp;&nbsp; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE =
OR THE USE OR<br>
&gt;&nbsp;&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; -<br>
<br>
Unrelated whitespace change.<br>
<br>
&gt;&nbsp; #include &quot;amdgpu_amdkfd.h&quot;<br>
&gt;&nbsp; #include &quot;amd_shared.h&quot;<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
&gt; index e1fbbebce4fd..b6713e0ed1b2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<=
br>
&gt; @@ -19,10 &#43;19,6 @@<br>
&gt;&nbsp;&nbsp; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE =
OR THE USE OR<br>
&gt;&nbsp;&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; -<br>
&gt; -#undef pr_fmt<br>
&gt; -#define pr_fmt(fmt) &quot;kfd2kgd: &quot; fmt<br>
&gt; -<br>
&gt;&nbsp; #include &lt;linux/module.h&gt;<br>
&gt;&nbsp; #include &lt;linux/fdtable.h&gt;<br>
&gt;&nbsp; #include &lt;linux/uaccess.h&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
&gt; index 0878f59ec340..61cd707158e4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<b=
r>
&gt; @@ -19,9 &#43;19,6 @@<br>
&gt;&nbsp;&nbsp; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE =
OR THE USE OR<br>
&gt;&nbsp;&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; -#undef pr_fmt<br>
&gt; -#define pr_fmt(fmt) &quot;kfd2kgd: &quot; fmt<br>
&gt; -<br>
&gt;&nbsp; #include &lt;linux/mmu_context.h&gt;<br>
&gt;&nbsp; #include &quot;amdgpu.h&quot;<br>
&gt;&nbsp; #include &quot;amdgpu_amdkfd.h&quot;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br>
&gt; index 6e6f0a99ec06..30897b2d9175 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br=
>
&gt; @@ -19,7 &#43;19,6 @@<br>
&gt;&nbsp;&nbsp; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE =
OR THE USE OR<br>
&gt;&nbsp;&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; -<br>
<br>
Unrelated whitespace change.<br>
<br>
&gt;&nbsp; #include &lt;linux/mmu_context.h&gt;<br>
&gt;<br>
&gt;&nbsp; #include &quot;amdgpu.h&quot;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br>
&gt; index bfbddedb2380..ede6ab0cbe4b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br=
>
&gt; @@ -19,7 &#43;19,6 @@<br>
&gt;&nbsp;&nbsp; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE =
OR THE USE OR<br>
&gt;&nbsp;&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; -<br>
<br>
Same here.<br>
<br>
With those dropped, the patch is:<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
&gt;&nbsp; #include &lt;linux/mmu_context.h&gt;<br>
&gt;<br>
&gt;&nbsp; #include &quot;amdgpu.h&quot;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&gt; index c72246f2c08a..47c853ef1051 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br=
>
&gt; @@ -19,9 &#43;19,6 @@<br>
&gt;&nbsp;&nbsp; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE =
OR THE USE OR<br>
&gt;&nbsp;&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; -<br>
&gt; -#define pr_fmt(fmt) &quot;kfd2kgd: &quot; fmt<br>
&gt; -<br>
&gt;&nbsp; #include &lt;linux/mmu_context.h&gt;<br>
&gt;<br>
&gt;&nbsp; #include &quot;amdgpu.h&quot;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt; index 1fbe81094b5f..97114e18c022 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt; @@ -19,9 &#43;19,6 @@<br>
&gt;&nbsp;&nbsp; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE =
OR THE USE OR<br>
&gt;&nbsp;&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; -<br>
&gt; -#define pr_fmt(fmt) &quot;kfd2kgd: &quot; fmt<br>
&gt; -<br>
&gt;&nbsp; #include &lt;linux/dma-buf.h&gt;<br>
&gt;&nbsp; #include &lt;linux/list.h&gt;<br>
&gt;&nbsp; #include &lt;linux/pagemap.h&gt;<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB27789F7136560521E8B2DB88F0660DM6PR12MB2778namp_--

--===============0382418189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0382418189==--
