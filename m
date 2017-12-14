From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: FW: [PATCH v2 2/2] drm/amdgpu: Move to gtt before cpu accesses
 dma buf.
Date: Thu, 14 Dec 2017 09:07:25 +0100
Message-ID: <3c4474d9-bdc4-25ab-9fe8-9732ee95a391@gmail.com>
References: <1512771734-13581-1-git-send-email-Samuel.Li@amd.com>
 <BLUPR12MB0628724406FBB250987B1B41F5340@BLUPR12MB0628.namprd12.prod.outlook.com>
 <212eeef1-2c32-bef9-82a6-a1884ef002da@amd.com>
 <82599e20-60fa-fe6f-2c91-4882ffcff4ce@amd.com>
 <154804e5-cdbb-a5f8-2ad8-506b0752943b@amd.com>
 <53b66de8-3fe3-c139-9887-7358bf1d95b5@amd.com>
 <141a2180-104a-4a75-7757-6de3b522c578@amd.com>
 <e92edd07-27fb-4717-bddd-e97ce5fbc266@amd.com>
 <BN6PR12MB1652331B4826780B9442CA67F7350@BN6PR12MB1652.namprd12.prod.outlook.com>
 <BLUPR12MB06283F027DB3101FEDFF46A0F5350@BLUPR12MB0628.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0241121226=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB06283F027DB3101FEDFF46A0F5350-7LeqcoF/hwrL9O90+oShTwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0241121226==
Content-Type: multipart/alternative;
 boundary="------------A335ED0766DE6266E4190F81"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A335ED0766DE6266E4190F81
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Please CC Michel as well, he originally commented that we should try to 
solve this in the DDX instead.

And BTW: Why don't we just do the migration during the mmap call?

Christian.

Am 13.12.2017 um 22:28 schrieb Li, Samuel:
>
> Will do after some basic testing.
>
> Sam
>
> *From:*Deucher, Alexander
> *Sent:* Wednesday, December 13, 2017 2:49 PM
> *To:* Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian 
> <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: FW: [PATCH v2 2/2] drm/amdgpu: Move to gtt before cpu 
> accesses dma buf.
>
> Please send the drm prime patch to dri-devel if you didn't already.
>
> Alex
>
> ------------------------------------------------------------------------
>
> *From:*amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org 
> <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>> on behalf of Samuel Li 
> <samuel.li-5C7GfCeVMHo@public.gmane.org <mailto:samuel.li-5C7GfCeVMHo@public.gmane.org>>
> *Sent:* Wednesday, December 13, 2017 2:17:49 PM
> *To:* Koenig, Christian; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org 
> <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Subject:* Re: FW: [PATCH v2 2/2] drm/amdgpu: Move to gtt before cpu 
> accesses dma buf.
>
> For the record.
>
>
> On 2017-12-13 01:26 PM, Christian König wrote:
> > Actually we try to avoid that drivers define their own dma_buf_ops 
> in DRM.
> >
> > That's why you have all those callbacks in drm_driver which just 
> mirror the dma_buf interface but unpack the GEM object from the 
> dma-buf object.
> >
> > There are quite a number of exceptions, but those drivers then 
> implement everything on their own because the DRM marshaling doesn't 
> make sense for them.
> >
> > Christian.
> >
> > Am 13.12.2017 um 19:01 schrieb Samuel Li:
> >> That is an approach. The cost is to add a new call back, which is 
> not necessary though, since driver can always actually define their 
> own dma_buf_ops.
> >> The intention here is to allow a driver reuse 
> drm_gem_prime_dmabuf_ops{}. If you would like to go this far, maybe a 
> more straight forward way is to export those ops, e.g. 
> drm_gem_map_attach, so that a driver can use them in its own definitions.
> >>
> >> Sam
> >>
> >>
> >>
> >> On 2017-12-13 05:23 AM, Christian König wrote:
> >>> Something like the attached patch. Not even compile tested.
> >>>
> >>> Christian.
> >>>
> >>> Am 12.12.2017 um 20:13 schrieb Samuel Li:
> >>>> Not sure if I understand your comments correctly. Currently 
> amdgpu prime reuses drm_gem_prime_dmabuf_ops{}, and it is defined as 
> static which is reasonable. I do not see an easier way to introduce 
> amdgpu_gem_begin_cpu_access().
> >>>>
> >>>> Sam
> >>>>
> >>>> On 2017-12-12 01:30 PM, Christian König wrote:
> >>>>>> +    while (amdgpu_dmabuf_ops.begin_cpu_access != 
> amdgpu_gem_begin_cpu_access)
> >>>>> I would rather just add the four liner code to drm to forward 
> the begin_cpu_access callback into a drm_driver callback instead of 
> all this.
> >>>>>
> >>>>> But apart from that it looks good to me.
> >>>>>
> >>>>> Christian.
> >>>>>
> >>>>> Am 12.12.2017 um 19:14 schrieb Li, Samuel:
> >>>>>> A gentle ping on this one, Christian, can you take a look at this?
> >>>>>>
> >>>>>> Sam
> >>>>>>
> >>>>>> -----Original Message-----
> >>>>>> From: Li, Samuel
> >>>>>> Sent: Friday, December 08, 2017 5:22 PM
> >>>>>> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org 
> <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> >>>>>> Cc: Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org <mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org>>
> >>>>>> Subject: [PATCH v2 2/2] drm/amdgpu: Move to gtt before cpu 
> accesses dma buf.
> >>>>>>
> >>>>>> To improve cpu read performance. This is implemented for APUs 
> currently.
> >>>>>>
> >>>>>> v2: Adapt to change 
> https://lists.freedesktop.org/archives/amd-gfx/2017-October/015174.html
> >>>>>>
> >>>>>> Change-Id: I7a583e23a9ee706e0edd2a46f4e4186a609368e3
> >>>>>> ---
> >>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  2 ++
> >>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  2 +-
> >>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c | 58 
> +++++++++++++++++++++++++++++++
> >>>>>>     3 files changed, 61 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>>>>> index f8657c3..193db70 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>>>>> @@ -417,6 +417,8 @@ amdgpu_gem_prime_import_sg_table(struct 
> drm_device *dev,  struct dma_buf *amdgpu_gem_prime_export(struct 
> drm_device *dev,
> >>>>>> struct drm_gem_object *gobj,
> >>>>>>                         int flags);
> >>>>>> +struct drm_gem_object *amdgpu_gem_prime_import(struct 
> drm_device *dev,
> >>>>>> + struct dma_buf *dma_buf);
> >>>>>>     int amdgpu_gem_prime_pin(struct drm_gem_object *obj); void 
> amdgpu_gem_prime_unpin(struct drm_gem_object *obj);  struct 
> reservation_object *amdgpu_gem_prime_res_obj(struct drm_gem_object *); 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>>> index 31383e0..df30b08 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>>> @@ -868,7 +868,7 @@ static struct drm_driver kms_driver = {
> >>>>>>         .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> >>>>>>         .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> >>>>>>         .gem_prime_export = amdgpu_gem_prime_export,
> >>>>>> -    .gem_prime_import = drm_gem_prime_import,
> >>>>>> +    .gem_prime_import = amdgpu_gem_prime_import,
> >>>>>>         .gem_prime_pin = amdgpu_gem_prime_pin,
> >>>>>>         .gem_prime_unpin = amdgpu_gem_prime_unpin,
> >>>>>>         .gem_prime_res_obj = amdgpu_gem_prime_res_obj, diff 
> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> >>>>>> index ae9c106..de6f599 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> >>>>>> @@ -26,6 +26,7 @@
> >>>>>>     #include <drm/drmP.h>
> >>>>>>       #include "amdgpu.h"
> >>>>>> +#include "amdgpu_display.h"
> >>>>>>     #include <drm/amdgpu_drm.h>
> >>>>>>     #include <linux/dma-buf.h>
> >>>>>>     @@ -164,6 +165,33 @@ struct reservation_object 
> *amdgpu_gem_prime_res_obj(struct drm_gem_object *obj)
> >>>>>>         return bo->tbo.resv;
> >>>>>>     }
> >>>>>>     +static int amdgpu_gem_begin_cpu_access(struct dma_buf 
> *dma_buf, enum
> >>>>>> +dma_data_direction direction) {
> >>>>>> +    struct amdgpu_bo *bo = gem_to_amdgpu_bo(dma_buf->priv);
> >>>>>> +    struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> >>>>>> +    struct ttm_operation_ctx ctx = { true, false };
> >>>>>> +    u32 domain = amdgpu_framebuffer_domains(adev);
> >>>>>> +    long ret = 0;
> >>>>>> +    bool reads = (direction == DMA_BIDIRECTIONAL || direction ==
> >>>>>> +DMA_FROM_DEVICE);
> >>>>>> +
> >>>>>> +    if (!reads || !(domain | AMDGPU_GEM_DOMAIN_GTT) || 
> bo->pin_count)
> >>>>>> +        return 0;
> >>>>>> +
> >>>>>> +    /* move to gtt */
> >>>>>> +    ret = amdgpu_bo_reserve(bo, false);
> >>>>>> +    if (unlikely(ret != 0))
> >>>>>> +        return ret;
> >>>>>> +
> >>>>>> + amdgpu_ttm_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
> >>>>>> +    ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> >>>>>> +
> >>>>>> +    amdgpu_bo_unreserve(bo);
> >>>>>> +    return ret;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static struct dma_buf_ops amdgpu_dmabuf_ops; static atomic_t 
> aops_lock;
> >>>>>> +
> >>>>>>     struct dma_buf *amdgpu_gem_prime_export(struct drm_device *dev,
> >>>>>> struct drm_gem_object *gobj,
> >>>>>>                         int flags)
> >>>>>> @@ -178,5 +206,35 @@ struct dma_buf 
> *amdgpu_gem_prime_export(struct drm_device *dev,
> >>>>>>         buf = drm_gem_prime_export(dev, gobj, flags);
> >>>>>>         if (!IS_ERR(buf))
> >>>>>> buf->file->f_mapping = dev->anon_inode->i_mapping;
> >>>>>> +
> >>>>>> +    while (amdgpu_dmabuf_ops.begin_cpu_access != 
> amdgpu_gem_begin_cpu_access)
> >>>>>> +    {
> >>>>>> +        if (!atomic_cmpxchg(&aops_lock, 0, 1)) {
> >>>>>> + amdgpu_dmabuf_ops = *(buf->ops);
> >>>>>> + amdgpu_dmabuf_ops.begin_cpu_access = amdgpu_gem_begin_cpu_access;
> >>>>>> +        }
> >>>>>> +    }
> >>>>>> +    buf->ops = &amdgpu_dmabuf_ops;
> >>>>>> +
> >>>>>>         return buf;
> >>>>>>     }
> >>>>>> +
> >>>>>> +struct drm_gem_object *amdgpu_gem_prime_import(struct 
> drm_device *dev,
> >>>>>> + struct dma_buf *dma_buf)
> >>>>>> +{
> >>>>>> +    struct drm_gem_object *obj;
> >>>>>> +
> >>>>>> +    if (dma_buf->ops == &amdgpu_dmabuf_ops) {
> >>>>>> +        obj = dma_buf->priv;
> >>>>>> +        if (obj->dev == dev) {
> >>>>>> +            /*
> >>>>>> +             * Importing dmabuf exported from out own gem 
> increases
> >>>>>> +             * refcount on gem itself instead of f_count of 
> dmabuf.
> >>>>>> +             */
> >>>>>> + drm_gem_object_get(obj);
> >>>>>> +            return obj;
> >>>>>> +        }
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    return drm_gem_prime_import(dev, dma_buf); }
> >>>>>> --
> >>>>>> 2.7.4
> >>>>>>
> >
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------A335ED0766DE6266E4190F81
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Please CC Michel as well, he originally
      commented that we should try to solve this in the DDX instead.<br>
      <br>
      And BTW: Why don't we just do the migration during the mmap call?<br>
      <br>
      Christian.<br>
      <br>
      Am 13.12.2017 um 22:28 schrieb Li, Samuel:<br>
    </div>
    <blockquote type="cite"
cite="mid:BLUPR12MB06283F027DB3101FEDFF46A0F5350-7LeqcoF/hwrL9O90+oShTwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#2F5496;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">Will
            do after some basic testing.<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">Sam<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496"><o:p> </o:p></span></p>
        <div style="border:none;border-left:solid blue 1.5pt;padding:0in
          0in 0in 4.0pt">
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span
                    style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                  Deucher, Alexander
                  <br>
                  <b>Sent:</b> Wednesday, December 13, 2017 2:49 PM<br>
                  <b>To:</b> Li, Samuel <a class="moz-txt-link-rfc2396E" href="mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org">&lt;Samuel.Li-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                  Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <b>Subject:</b> Re: FW: [PATCH v2 2/2] drm/amdgpu:
                  Move to gtt before cpu accesses dma buf.<o:p></o:p></span></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p> </o:p></p>
          <div id="divtagdefaultwrapper">
            <p><span
                style="font-family:&quot;Calibri&quot;,sans-serif;color:black">Please
                send the drm prime patch to dri-devel if you didn't
                already.<o:p></o:p></span></p>
            <p><span
                style="font-family:&quot;Calibri&quot;,sans-serif;color:black"><o:p> </o:p></span></p>
            <p><span
                style="font-family:&quot;Calibri&quot;,sans-serif;color:black">Alex<o:p></o:p></span></p>
          </div>
          <div class="MsoNormal" style="text-align:center"
            align="center">
            <hr align="center" size="2" width="98%">
          </div>
          <div id="divRplyFwdMsg">
            <p class="MsoNormal"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">
                amd-gfx &lt;<a
                  href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                  moz-do-not-send="true">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
                on behalf of Samuel Li &lt;<a
                  href="mailto:samuel.li-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">samuel.li-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                <b>Sent:</b> Wednesday, December 13, 2017 2:17:49 PM<br>
                <b>To:</b> Koenig, Christian; <a
                  href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                  moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Subject:</b> Re: FW: [PATCH v2 2/2] drm/amdgpu: Move
                to gtt before cpu accesses dma buf.</span>
              <o:p></o:p></p>
            <div>
              <p class="MsoNormal"> <o:p></o:p></p>
            </div>
          </div>
          <div>
            <div>
              <p class="MsoNormal"><span style="font-size:10.0pt">For
                  the record.<br>
                  <br>
                  <br>
                  On 2017-12-13 01:26 PM, Christian König wrote:<br>
                  &gt; Actually we try to avoid that drivers define
                  their own dma_buf_ops in DRM.<br>
                  &gt; <br>
                  &gt; That's why you have all those callbacks in
                  drm_driver which just mirror the dma_buf interface but
                  unpack the GEM object from the dma-buf object.<br>
                  &gt; <br>
                  &gt; There are quite a number of exceptions, but those
                  drivers then implement everything on their own because
                  the DRM marshaling doesn't make sense for them.<br>
                  &gt; <br>
                  &gt; Christian.<br>
                  &gt; <br>
                  &gt; Am 13.12.2017 um 19:01 schrieb Samuel Li:<br>
                  &gt;&gt; That is an approach. The cost is to add a new
                  call back, which is not necessary though, since driver
                  can always actually define their own dma_buf_ops.<br>
                  &gt;&gt; The intention here is to allow a driver reuse
                  drm_gem_prime_dmabuf_ops{}. If you would like to go
                  this far, maybe a more straight forward way is to
                  export those ops, e.g. drm_gem_map_attach, so that a
                  driver can use them in its own definitions.<br>
                  &gt;&gt;<br>
                  &gt;&gt; Sam<br>
                  &gt;&gt;<br>
                  &gt;&gt;<br>
                  &gt;&gt;<br>
                  &gt;&gt; On 2017-12-13 05:23 AM, Christian König
                  wrote:<br>
                  &gt;&gt;&gt; Something like the attached patch. Not
                  even compile tested.<br>
                  &gt;&gt;&gt;<br>
                  &gt;&gt;&gt; Christian.<br>
                  &gt;&gt;&gt;<br>
                  &gt;&gt;&gt; Am 12.12.2017 um 20:13 schrieb Samuel Li:<br>
                  &gt;&gt;&gt;&gt; Not sure if I understand your
                  comments correctly. Currently amdgpu prime reuses
                  drm_gem_prime_dmabuf_ops{}, and it is defined as
                  static which is reasonable. I do not see an easier way
                  to introduce amdgpu_gem_begin_cpu_access().<br>
                  &gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt; Sam<br>
                  &gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt; On 2017-12-12 01:30 PM, Christian
                  König wrote:<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    while
                  (amdgpu_dmabuf_ops.begin_cpu_access !=
                  amdgpu_gem_begin_cpu_access)<br>
                  &gt;&gt;&gt;&gt;&gt; I would rather just add the four
                  liner code to drm to forward the begin_cpu_access
                  callback into a drm_driver callback instead of all
                  this.<br>
                  &gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt; But apart from that it looks good
                  to me.<br>
                  &gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt; Christian.<br>
                  &gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt; Am 12.12.2017 um 19:14 schrieb
                  Li, Samuel:<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; A gentle ping on this one,
                  Christian, can you take a look at this?<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; Sam<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; -----Original Message-----<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; From: Li, Samuel<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; Sent: Friday, December 08,
                  2017 5:22 PM<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; To: <a
                    href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                    moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  &gt;&gt;&gt;&gt;&gt;&gt; Cc: Li, Samuel &lt;<a
                    href="mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">Samuel.Li-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; Subject: [PATCH v2 2/2]
                  drm/amdgpu: Move to gtt before cpu accesses dma buf.<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; To improve cpu read
                  performance. This is implemented for APUs currently.<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; v2: Adapt to change <a
href="https://lists.freedesktop.org/archives/amd-gfx/2017-October/015174.html"
                    moz-do-not-send="true">
https://lists.freedesktop.org/archives/amd-gfx/2017-October/015174.html</a><br>
                  &gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; Change-Id:
                  I7a583e23a9ee706e0edd2a46f4e4186a609368e3<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; ---<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;    
                  drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  2 ++<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;    
                  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  2 +-<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;    
                  drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c | 58
                  +++++++++++++++++++++++++++++++<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;     3 files changed, 61
                  insertions(+), 1 deletion(-)<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; index f8657c3..193db70 100644<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; ---
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +++
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; @@ -417,6 +417,8 @@
                  amdgpu_gem_prime_import_sg_table(struct drm_device
                  *dev,  struct dma_buf *amdgpu_gem_prime_export(struct
                  drm_device *dev,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;                        
                  struct drm_gem_object *gobj,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;                         int
                  flags);<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +struct drm_gem_object
                  *amdgpu_gem_prime_import(struct drm_device *dev,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +                       
                  struct dma_buf *dma_buf);<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;     int
                  amdgpu_gem_prime_pin(struct drm_gem_object *obj); 
                  void amdgpu_gem_prime_unpin(struct drm_gem_object
                  *obj);  struct reservation_object
                  *amdgpu_gem_prime_res_obj(struct drm_gem_object *);
                  diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; index 31383e0..df30b08 100644<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; ---
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +++
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; @@ -868,7 +868,7 @@ static
                  struct drm_driver kms_driver = {<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;         .prime_handle_to_fd =
                  drm_gem_prime_handle_to_fd,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;         .prime_fd_to_handle =
                  drm_gem_prime_fd_to_handle,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;         .gem_prime_export =
                  amdgpu_gem_prime_export,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; -    .gem_prime_import =
                  drm_gem_prime_import,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    .gem_prime_import =
                  amdgpu_gem_prime_import,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;         .gem_prime_pin =
                  amdgpu_gem_prime_pin,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;         .gem_prime_unpin =
                  amdgpu_gem_prime_unpin,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;         .gem_prime_res_obj =
                  amdgpu_gem_prime_res_obj, diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; index ae9c106..de6f599 100644<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; ---
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +++
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; @@ -26,6 +26,7 @@<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;     #include
                  &lt;drm/drmP.h&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;       #include "amdgpu.h"<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +#include "amdgpu_display.h"<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;     #include
                  &lt;drm/amdgpu_drm.h&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;     #include
                  &lt;linux/dma-buf.h&gt;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;     @@ -164,6 +165,33 @@
                  struct reservation_object
                  *amdgpu_gem_prime_res_obj(struct drm_gem_object *obj)<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;         return
                  bo-&gt;tbo.resv;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;     }<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;     +static int
                  amdgpu_gem_begin_cpu_access(struct dma_buf *dma_buf,
                  enum<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +dma_data_direction
                  direction) {<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    struct amdgpu_bo *bo =
                  gem_to_amdgpu_bo(dma_buf-&gt;priv);<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    struct amdgpu_device
                  *adev = amdgpu_ttm_adev(bo-&gt;tbo.bdev);<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    struct ttm_operation_ctx
                  ctx = { true, false };<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    u32 domain =
                  amdgpu_framebuffer_domains(adev);<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    long ret = 0;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    bool reads = (direction
                  == DMA_BIDIRECTIONAL || direction ==<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +DMA_FROM_DEVICE);<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    if (!reads || !(domain |
                  AMDGPU_GEM_DOMAIN_GTT) || bo-&gt;pin_count)<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +        return 0;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    /* move to gtt */<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    ret =
                  amdgpu_bo_reserve(bo, false);<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    if (unlikely(ret != 0))<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +        return ret;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +   
                  amdgpu_ttm_placement_from_domain(bo,
                  AMDGPU_GEM_DOMAIN_GTT);<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    ret =
                  ttm_bo_validate(&amp;bo-&gt;tbo,
                  &amp;bo-&gt;placement, &amp;ctx);<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    amdgpu_bo_unreserve(bo);<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    return ret;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +}<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +static struct dma_buf_ops
                  amdgpu_dmabuf_ops; static atomic_t aops_lock;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;     struct dma_buf
                  *amdgpu_gem_prime_export(struct drm_device *dev,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;                        
                  struct drm_gem_object *gobj,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;                         int
                  flags)<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; @@ -178,5 +206,35 @@ struct
                  dma_buf *amdgpu_gem_prime_export(struct drm_device
                  *dev,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;         buf =
                  drm_gem_prime_export(dev, gobj, flags);<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;         if (!IS_ERR(buf))<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;            
                  buf-&gt;file-&gt;f_mapping =
                  dev-&gt;anon_inode-&gt;i_mapping;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    while
                  (amdgpu_dmabuf_ops.begin_cpu_access !=
                  amdgpu_gem_begin_cpu_access)<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    {<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +        if
                  (!atomic_cmpxchg(&amp;aops_lock, 0, 1)) {<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +           
                  amdgpu_dmabuf_ops = *(buf-&gt;ops);<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +           
                  amdgpu_dmabuf_ops.begin_cpu_access =
                  amdgpu_gem_begin_cpu_access;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +        }<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    }<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    buf-&gt;ops =
                  &amp;amdgpu_dmabuf_ops;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;         return buf;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;     }<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +struct drm_gem_object
                  *amdgpu_gem_prime_import(struct drm_device *dev,<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +                       
                  struct dma_buf *dma_buf)<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +{<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    struct drm_gem_object
                  *obj;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    if (dma_buf-&gt;ops ==
                  &amp;amdgpu_dmabuf_ops) {<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +        obj =
                  dma_buf-&gt;priv;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +        if (obj-&gt;dev ==
                  dev) {<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +            /*<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +             * Importing
                  dmabuf exported from out own gem increases<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +             * refcount on
                  gem itself instead of f_count of dmabuf.<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +             */<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +           
                  drm_gem_object_get(obj);<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +            return obj;<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +        }<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    }<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; +    return
                  drm_gem_prime_import(dev, dma_buf); }<br>
                  &gt;&gt;&gt;&gt;&gt;&gt; -- <br>
                  &gt;&gt;&gt;&gt;&gt;&gt; 2.7.4<br>
                  &gt;&gt;&gt;&gt;&gt;&gt;<br>
                  &gt; <o:p></o:p></span></p>
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

--------------A335ED0766DE6266E4190F81--

--===============0241121226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0241121226==--
