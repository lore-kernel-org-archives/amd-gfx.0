From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdkfd: Remove the control stack workaround for
 GFX10
Date: Thu, 26 Sep 2019 18:41:52 +0000
Message-ID: <DM6PR12MB2778D26FD0EC07F2DA570340F0860@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20190925181527.17091-1-Yong.Zhao@amd.com>
 <20190925181527.17091-3-Yong.Zhao@amd.com>
 <3d63ddfd-2773-b89d-c0dc-75ac1397b1fc@amd.com>,
 <09afdf34-0c72-5306-103a-1290734fa1a2@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0908116970=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <09afdf34-0c72-5306-103a-1290734fa1a2-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0908116970==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2778D26FD0EC07F2DA570340F0860DM6PR12MB2778namp_"

--_000_DM6PR12MB2778D26FD0EC07F2DA570340F0860DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Felix,

I reworded this patch in the next series. Please review the first two patch=
es in this series.

Regards,
Yong
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zhao, Yo=
ng <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, September 25, 2019 2:34 PM
To: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
 <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdkfd: Remove the control stack workaround fo=
r GFX10

Yes. I confirmed with CP guys and they said the behavior on GFX10 is the
same as GFX8 now. I remember that the workaround on GFX9 was to help
with a HW bug, but not too sure.

Regards,

Yong

On 2019-09-25 2:25 p.m., Kuehling, Felix wrote:
> On 2019-09-25 2:15 p.m., Zhao, Yong wrote:
>> The GFX10 does not have this hardware bug any more, so remove it.
> I wouldn't call this a bug and a workaround. More like a change in the
> HW or FW behaviour and a corresponding driver change. I.e. in GFXv8 the
> control stack was in the user mode CWSR allocation. In GFXv9 it moved
> into a kernel mode buffer next to the MQD. So in GFXv10 the control
> stack moved back into the user mode CWSR buffer?
>
> Regards,
>     Felix
>
>> Change-Id: I446c9685549a09ac8846a42ee22d86cfb93fd98c
>> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
>> ---
>>    .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  | 37 ++----------------=
-
>>    1 file changed, 4 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/=
gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
>> index 9cd3eb2d90bd..4a236b2c2354 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
>> @@ -69,35 +69,13 @@ static void update_cu_mask(struct mqd_manager *mm, v=
oid *mqd,
>>    static struct kfd_mem_obj *allocate_mqd(struct kfd_dev *kfd,
>>               struct queue_properties *q)
>>    {
>> -    int retval;
>> -    struct kfd_mem_obj *mqd_mem_obj =3D NULL;
>> +    struct kfd_mem_obj *mqd_mem_obj;
>>
>> -    /* From V9,  for CWSR, the control stack is located on the next pag=
e
>> -     * boundary after the mqd, we will use the gtt allocation function
>> -     * instead of sub-allocation function.
>> -     */
>> -    if (kfd->cwsr_enabled && (q->type =3D=3D KFD_QUEUE_TYPE_COMPUTE)) {
>> -            mqd_mem_obj =3D kzalloc(sizeof(struct kfd_mem_obj), GFP_NOI=
O);
>> -            if (!mqd_mem_obj)
>> -                    return NULL;
>> -            retval =3D amdgpu_amdkfd_alloc_gtt_mem(kfd->kgd,
>> -                    ALIGN(q->ctl_stack_size, PAGE_SIZE) +
>> -                            ALIGN(sizeof(struct v10_compute_mqd), PAGE_=
SIZE),
>> -                    &(mqd_mem_obj->gtt_mem),
>> -                    &(mqd_mem_obj->gpu_addr),
>> -                    (void *)&(mqd_mem_obj->cpu_ptr), true);
>> -    } else {
>> -            retval =3D kfd_gtt_sa_allocate(kfd, sizeof(struct v10_compu=
te_mqd),
>> -                            &mqd_mem_obj);
>> -    }
>> -
>> -    if (retval) {
>> -            kfree(mqd_mem_obj);
>> +    if (kfd_gtt_sa_allocate(kfd, sizeof(struct v10_compute_mqd),
>> +                    &mqd_mem_obj))
>>               return NULL;
>> -    }
>>
>>       return mqd_mem_obj;
>> -
>>    }
>>
>>    static void init_mqd(struct mqd_manager *mm, void **mqd,
>> @@ -250,14 +228,7 @@ static int destroy_mqd(struct mqd_manager *mm, void=
 *mqd,
>>    static void free_mqd(struct mqd_manager *mm, void *mqd,
>>                       struct kfd_mem_obj *mqd_mem_obj)
>>    {
>> -    struct kfd_dev *kfd =3D mm->dev;
>> -
>> -    if (mqd_mem_obj->gtt_mem) {
>> -            amdgpu_amdkfd_free_gtt_mem(kfd->kgd, mqd_mem_obj->gtt_mem);
>> -            kfree(mqd_mem_obj);
>> -    } else {
>> -            kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
>> -    }
>> +    kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
>>    }
>>
>>    static bool is_occupied(struct mqd_manager *mm, void *mqd,
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM6PR12MB2778D26FD0EC07F2DA570340F0860DM6PR12MB2778namp_
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
Hi Felix,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I reworded this patch in the next series. Please review the first two patch=
es in this series.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;">Yong&nbsp;</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Zhao, Yong &lt;Yong.Zhao@amd.=
com&gt;<br>
<b>Sent:</b> Wednesday, September 25, 2019 2:34 PM<br>
<b>To:</b> Kuehling, Felix &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32k@public.gmane.org=
eedesktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amdkfd: Remove the control stack workar=
ound for GFX10</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Yes. I confirmed with CP guys and they said the be=
havior on GFX10 is the
<br>
same as GFX8 now. I remember that the workaround on GFX9 was to help <br>
with a HW bug, but not too sure.<br>
<br>
Regards,<br>
<br>
Yong<br>
<br>
On 2019-09-25 2:25 p.m., Kuehling, Felix wrote:<br>
&gt; On 2019-09-25 2:15 p.m., Zhao, Yong wrote:<br>
&gt;&gt; The GFX10 does not have this hardware bug any more, so remove it.<=
br>
&gt; I wouldn't call this a bug and a workaround. More like a change in the=
<br>
&gt; HW or FW behaviour and a corresponding driver change. I.e. in GFXv8 th=
e<br>
&gt; control stack was in the user mode CWSR allocation. In GFXv9 it moved<=
br>
&gt; into a kernel mode buffer next to the MQD. So in GFXv10 the control<br=
>
&gt; stack moved back into the user mode CWSR buffer?<br>
&gt;<br>
&gt; Regards,<br>
&gt;&nbsp;&nbsp; &nbsp; Felix<br>
&gt;<br>
&gt;&gt; Change-Id: I446c9685549a09ac8846a42ee22d86cfb93fd98c<br>
&gt;&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c&nbs=
p; | 37 &#43;&#43;-----------------<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 4 insertions(&#43;), 33 deletion=
s(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/dr=
ivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c<br>
&gt;&gt; index 9cd3eb2d90bd..4a236b2c2354 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c=
<br>
&gt;&gt; @@ -69,35 &#43;69,13 @@ static void update_cu_mask(struct mqd_mana=
ger *mm, void *mqd,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; static struct kfd_mem_obj *allocate_mqd(struct k=
fd_dev *kfd,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; struct queue_properties *q)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; int retval;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; struct kfd_mem_obj *mqd_mem_obj =3D NULL;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct kfd_mem_obj *mqd_mem_obj;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; /* From V9,&nbsp; for CWSR, the control stack =
is located on the next page<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; * boundary after the mqd, we will use th=
e gtt allocation function<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; * instead of sub-allocation function.<br=
>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (kfd-&gt;cwsr_enabled &amp;&amp; (q-&gt;typ=
e =3D=3D KFD_QUEUE_TYPE_COMPUTE)) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; mqd_mem_obj =3D kzalloc(sizeof(struct kfd_mem_obj), GFP_NOIO);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (!mqd_mem_obj)<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; retval =3D amdgpu_amdkfd_alloc_gtt_mem(kfd-&gt;kgd,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(q-&gt;ctl_stack_siz=
e, PAGE_SIZE) &#43;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ALIGN(sizeof(struct v10_compute_mqd), PAGE_SIZE),<br=
>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;(mqd_mem_obj-&gt;gtt=
_mem),<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;(mqd_mem_obj-&gt;gpu=
_addr),<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)&amp;(mqd_mem_obj=
-&gt;cpu_ptr), true);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; retval =3D kfd_gtt_sa_allocate(kfd, sizeof(struct v10_compute_mqd),<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &amp;mqd_mem_obj);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (retval) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; kfree(mqd_mem_obj);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (kfd_gtt_sa_allocate(kfd, sizeof(struct=
 v10_compute_mqd),<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mqd_mem_obj))<br=
>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return NULL;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return mqd_mem_obj;<br>
&gt;&gt; -<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp; static void init_mqd(struct mqd_manager *mm, voi=
d **mqd,<br>
&gt;&gt; @@ -250,14 &#43;228,7 @@ static int destroy_mqd(struct mqd_manager=
 *mm, void *mqd,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; static void free_mqd(struct mqd_manager *mm, voi=
d *mqd,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kf=
d_mem_obj *mqd_mem_obj)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; struct kfd_dev *kfd =3D mm-&gt;dev;<br>
&gt;&gt; -<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (mqd_mem_obj-&gt;gtt_mem) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; amdgpu_amdkfd_free_gtt_mem(kfd-&gt;kgd, mqd_mem_obj-&gt;gtt_mem);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; kfree(mqd_mem_obj);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; kfd_gtt_sa_free(mm-&gt;dev, mqd_mem_obj);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; kfd_gtt_sa_free(mm-&gt;dev, mqd_mem_obj);<=
br>
&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp; static bool is_occupied(struct mqd_manager *mm, =
void *mqd,<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB2778D26FD0EC07F2DA570340F0860DM6PR12MB2778namp_--

--===============0908116970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0908116970==--
