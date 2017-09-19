From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: add support for iova_to_phys to replace
 TTM trace (v4)
Date: Tue, 19 Sep 2017 13:40:42 +0200
Message-ID: <c188d18a-ee3e-9069-c50c-c3c867b52101@gmail.com>
References: <20170919112057.24377-1-tom.stdenis@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0556977889=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170919112057.24377-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0556977889==
Content-Type: multipart/alternative;
 boundary="------------A465AE2877E8DB87E6123E16"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A465AE2877E8DB87E6123E16
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 19.09.2017 um 13:20 schrieb Tom St Denis:
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
>
> (v2): Add domain to iova debugfs
> (v3): Add true read/write methods to access system memory of pages
>        mapped to the device
> (v4): Move get_domain call out of loop and return on error
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 114 ++++++++++++++++++++++++++++++++
>   1 file changed, 114 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 50d20903de4f..71a2fdc91a85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -43,6 +43,7 @@
>   #include <linux/swap.h>
>   #include <linux/pagemap.h>
>   #include <linux/debugfs.h>
> +#include <linux/iommu.h>
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
>   #include "bif/bif_4_1_d.h"
> @@ -1810,6 +1811,118 @@ static const struct file_operations amdgpu_ttm_gtt_fops = {
>   #endif
>   
>   
> +static void *transform_page(uint64_t phys)
> +{
> +	if (PageHighMem(pfn_to_page(PFN_DOWN(phys))))
> +		return kmap(pfn_to_page(PFN_DOWN(phys)));
> +	else
> +		return __va(phys);
> +}
> +
> +static void untransform_page(uint64_t phys)
> +{
> +	if (PageHighMem(pfn_to_page(PFN_DOWN(phys))))
> +		return kunmap(pfn_to_page(PFN_DOWN(phys)));
> +}

I mentioned that in the previous patch as well, why not using 
kmap()/kunmap() here directly?

See kmap() for x86 for example:
> void  *kmap <http://elixir.free-electrons.com/linux/v4.2/ident/kmap>(struct  page  *page)
> {
> 	might_sleep 
> <http://elixir.free-electrons.com/linux/v4.2/ident/might_sleep>();
> 	if  (!PageHighMem 
> <http://elixir.free-electrons.com/linux/v4.2/ident/PageHighMem>(page))
> 		return  page_address 
> <http://elixir.free-electrons.com/linux/v4.2/ident/page_address>(page);
> 	return  kmap_high 
> <http://elixir.free-electrons.com/linux/v4.2/ident/kmap_high>(page);
> }

Both normal as well as highmem are correctly handled here.

Regards,
Christian.

> +
> +static ssize_t amdgpu_iova_to_phys_read(struct file *f, char __user *buf,
> +				   size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = file_inode(f)->i_private;
> +	ssize_t result, n;
> +	int r;
> +	uint64_t phys;
> +	void *ptr;
> +	struct iommu_domain *dom;
> +
> +	dom = iommu_get_domain_for_dev(adev->dev);
> +	if (!dom)
> +		return -EFAULT;
> +
> +	result = 0;
> +	while (size) {
> +		// get physical address and map
> +		phys = iommu_iova_to_phys(dom, *pos);
> +
> +		// copy upto one page
> +		if (size > PAGE_SIZE)
> +			n = PAGE_SIZE;
> +		else
> +			n = size;
> +
> +		// to end of the page
> +		if (((*pos & (PAGE_SIZE - 1)) + n) >= PAGE_SIZE)
> +			n = PAGE_SIZE - (*pos & (PAGE_SIZE - 1));
> +
> +		ptr = transform_page(phys);
> +		if (!ptr)
> +			return -EFAULT;
> +
> +		r = copy_to_user(buf, ptr, n);
> +		untransform_page(phys);
> +		if (r)
> +			return -EFAULT;
> +
> +		*pos += n;
> +		size -= n;
> +		result += n;
> +	}
> +
> +	return result;
> +}
> +
> +static ssize_t amdgpu_iova_to_phys_write(struct file *f, const char __user *buf,
> +				   size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = file_inode(f)->i_private;
> +	ssize_t result, n;
> +	int r;
> +	uint64_t phys;
> +	void *ptr;
> +	struct iommu_domain *dom;
> +
> +	dom = iommu_get_domain_for_dev(adev->dev);
> +	if (!dom)
> +		return -EFAULT;
> +
> +	result = 0;
> +	while (size) {
> +		// get physical address and map
> +		phys = iommu_iova_to_phys(dom, *pos);
> +
> +		// copy upto one page
> +		if (size > PAGE_SIZE)
> +			n = PAGE_SIZE;
> +		else
> +			n = size;
> +
> +		// to end of the page
> +		if (((*pos & (PAGE_SIZE - 1)) + n) >= PAGE_SIZE)
> +			n = PAGE_SIZE - (*pos & (PAGE_SIZE - 1));
> +
> +		ptr = transform_page(phys);
> +		if (!ptr)
> +			return -EFAULT;
> +
> +		r = copy_from_user(ptr, buf, n);
> +		untransform_page(phys);
> +		if (r)
> +			return -EFAULT;
> +
> +		*pos += n;
> +		size -= n;
> +		result += n;
> +	}
> +
> +	return result;
> +}
> +
> +static const struct file_operations amdgpu_ttm_iova_fops = {
> +	.owner = THIS_MODULE,
> +	.read = amdgpu_iova_to_phys_read,
> +	.write = amdgpu_iova_to_phys_write,
> +	.llseek = default_llseek
> +};
>   
>   static const struct {
>   	char *name;
> @@ -1820,6 +1933,7 @@ static const struct {
>   #ifdef CONFIG_DRM_AMDGPU_GART_DEBUGFS
>   	{ "amdgpu_gtt", &amdgpu_ttm_gtt_fops, TTM_PL_TT },
>   #endif
> +	{ "amdgpu_iova", &amdgpu_ttm_iova_fops, TTM_PL_SYSTEM },
>   };
>   
>   #endif



--------------A465AE2877E8DB87E6123E16
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 19.09.2017 um 13:20 schrieb Tom St
      Denis:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20170919112057.24377-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">Signed-off-by: Tom St Denis <a class="moz-txt-link-rfc2396E" href="mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org">&lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;</a>

(v2): Add domain to iova debugfs
(v3): Add true read/write methods to access system memory of pages
      mapped to the device
(v4): Move get_domain call out of loop and return on error
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 114 ++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 50d20903de4f..71a2fdc91a85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -43,6 +43,7 @@
 #include &lt;linux/swap.h&gt;
 #include &lt;linux/pagemap.h&gt;
 #include &lt;linux/debugfs.h&gt;
+#include &lt;linux/iommu.h&gt;
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
 #include "bif/bif_4_1_d.h"
@@ -1810,6 +1811,118 @@ static const struct file_operations amdgpu_ttm_gtt_fops = {
 #endif
 
 
+static void *transform_page(uint64_t phys)
+{
+	if (PageHighMem(pfn_to_page(PFN_DOWN(phys))))
+		return kmap(pfn_to_page(PFN_DOWN(phys)));
+	else
+		return __va(phys);
+}
+
+static void untransform_page(uint64_t phys)
+{
+	if (PageHighMem(pfn_to_page(PFN_DOWN(phys))))
+		return kunmap(pfn_to_page(PFN_DOWN(phys)));
+}</pre>
    </blockquote>
    <br>
    I mentioned that in the previous patch as well, why not using
    kmap()/kunmap() here directly?<br>
    <br>
    See kmap() for x86 for example:<br>
    <blockquote type="cite">
      <pre><span class="kt">void</span> <span class="o">*</span><span class="nf"><a href="http://elixir.free-electrons.com/linux/v4.2/ident/kmap">kmap</a></span><span class="p">(</span><span class="k">struct</span> <span class="n">page</span> <span class="o">*</span><span class="n">page</span><span class="p">)</span>
<span class="p">{</span>
	<span class="n"><a href="http://elixir.free-electrons.com/linux/v4.2/ident/might_sleep">might_sleep</a></span><span class="p">();</span>
	<span class="k">if</span> <span class="p">(</span><span class="o">!</span><span class="n"><a href="http://elixir.free-electrons.com/linux/v4.2/ident/PageHighMem">PageHighMem</a></span><span class="p">(</span><span class="n">page</span><span class="p">))</span>
		<span class="k">return</span> <span class="n"><a href="http://elixir.free-electrons.com/linux/v4.2/ident/page_address">page_address</a></span><span class="p">(</span><span class="n">page</span><span class="p">);</span>
	<span class="k">return</span> <span class="n"><a href="http://elixir.free-electrons.com/linux/v4.2/ident/kmap_high">kmap_high</a></span><span class="p">(</span><span class="n">page</span><span class="p">);</span>
<span class="p">}</span></pre>
    </blockquote>
    <br>
    Both normal as well as highmem are correctly handled here.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:20170919112057.24377-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">
+
+static ssize_t amdgpu_iova_to_phys_read(struct file *f, char __user *buf,
+				   size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = file_inode(f)-&gt;i_private;
+	ssize_t result, n;
+	int r;
+	uint64_t phys;
+	void *ptr;
+	struct iommu_domain *dom;
+
+	dom = iommu_get_domain_for_dev(adev-&gt;dev);
+	if (!dom)
+		return -EFAULT;
+
+	result = 0;
+	while (size) {
+		// get physical address and map
+		phys = iommu_iova_to_phys(dom, *pos);
+
+		// copy upto one page
+		if (size &gt; PAGE_SIZE)
+			n = PAGE_SIZE;
+		else
+			n = size;
+
+		// to end of the page
+		if (((*pos &amp; (PAGE_SIZE - 1)) + n) &gt;= PAGE_SIZE)
+			n = PAGE_SIZE - (*pos &amp; (PAGE_SIZE - 1));
+
+		ptr = transform_page(phys);
+		if (!ptr)
+			return -EFAULT;
+
+		r = copy_to_user(buf, ptr, n);
+		untransform_page(phys);
+		if (r)
+			return -EFAULT;
+
+		*pos += n;
+		size -= n;
+		result += n;
+	}
+
+	return result;
+}
+
+static ssize_t amdgpu_iova_to_phys_write(struct file *f, const char __user *buf,
+				   size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = file_inode(f)-&gt;i_private;
+	ssize_t result, n;
+	int r;
+	uint64_t phys;
+	void *ptr;
+	struct iommu_domain *dom;
+
+	dom = iommu_get_domain_for_dev(adev-&gt;dev);
+	if (!dom)
+		return -EFAULT;
+
+	result = 0;
+	while (size) {
+		// get physical address and map
+		phys = iommu_iova_to_phys(dom, *pos);
+
+		// copy upto one page
+		if (size &gt; PAGE_SIZE)
+			n = PAGE_SIZE;
+		else
+			n = size;
+
+		// to end of the page
+		if (((*pos &amp; (PAGE_SIZE - 1)) + n) &gt;= PAGE_SIZE)
+			n = PAGE_SIZE - (*pos &amp; (PAGE_SIZE - 1));
+
+		ptr = transform_page(phys);
+		if (!ptr)
+			return -EFAULT;
+
+		r = copy_from_user(ptr, buf, n);
+		untransform_page(phys);
+		if (r)
+			return -EFAULT;
+
+		*pos += n;
+		size -= n;
+		result += n;
+	}
+
+	return result;
+}
+
+static const struct file_operations amdgpu_ttm_iova_fops = {
+	.owner = THIS_MODULE,
+	.read = amdgpu_iova_to_phys_read,
+	.write = amdgpu_iova_to_phys_write,
+	.llseek = default_llseek
+};
 
 static const struct {
 	char *name;
@@ -1820,6 +1933,7 @@ static const struct {
 #ifdef CONFIG_DRM_AMDGPU_GART_DEBUGFS
 	{ "amdgpu_gtt", &amp;amdgpu_ttm_gtt_fops, TTM_PL_TT },
 #endif
+	{ "amdgpu_iova", &amp;amdgpu_ttm_iova_fops, TTM_PL_SYSTEM },
 };
 
 #endif
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------A465AE2877E8DB87E6123E16--

--===============0556977889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0556977889==--
