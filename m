From: "Haehnle, Nicolai" <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org>
Subject: Re: TDR and VRAM lost handling in KMD:
Date: Wed, 11 Oct 2017 08:40:53 +0000
Message-ID: <DM5PR12MB1292D21FC5438AEA8FCF9F64FF4A0@DM5PR12MB1292.namprd12.prod.outlook.com>
References: <BLUPR12MB0449785160E34EA9369C5E23844A0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <b5c5f6c9-07e2-4688-8ffc-3929bfc59366@amd.com>,
 <BLUPR12MB044911DFCB510022605DD38A844A0@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0805935854=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB044911DFCB510022605DD38A844A0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Ramirez, Alejandro" <Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Filipas,
 Mario" <Mario.Filipas-5C7GfCeVMHo@public.gmane.org>, "Ding, Pixel" <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>, "Li,
 Bingley" <Bingley.Li-5C7GfCeVMHo@public.gmane.org>, "Jiang, Jerry (SW)" <Jerry.Jiang-5C7GfCeVMHo@public.gmane.org>

--===============0805935854==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1292D21FC5438AEA8FCF9F64FF4A0DM5PR12MB1292namp_"

--_000_DM5PR12MB1292D21FC5438AEA8FCF9F64FF4A0DM5PR12MB1292namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

>From a Mesa perspective, this almost all sounds reasonable to me.


On "guilty": "guilty" is a term that's used by APIs (e.g. OpenGL), so it's =
reasonable to use it. However, it does not make sense to mark idle contexts=
 as "guilty" just because VRAM is lost. VRAM lost is a perfect example wher=
e the driver should report context lost to applications with the "innocent"=
 flag for contexts that were idle at the time of reset. The only context(s)=
 that should be reported as "guilty" (or perhaps "unknown" in some cases) a=
re the ones that were executing at the time of reset.


On whether the whole context is marked as guilty from a user space perspect=
ive, it would simply be nice for user space to get consistent answers. It w=
ould be a bit odd if we could e.g. succeed in submitting an SDMA job after =
a GFX job was rejected. This would point in favor of marking the entire con=
text as guilty (although that could happen lazily instead of at reset time)=
. On the other hand, if that's too big a burden for the kernel implementati=
on I'm sure we can live without it.


Cheers,

Nicolai

________________________________
From: Liu, Monk
Sent: Wednesday, October 11, 2017 10:15:40 AM
To: Koenig, Christian; Haehnle, Nicolai; Olsak, Marek; Deucher, Alexander
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Ding, Pixel; Jiang, Jerry (SW); Li, Bing=
ley; Ramirez, Alejandro; Filipas, Mario
Subject: RE: TDR and VRAM lost handling in KMD:


1.        Set its fence error status to =93ETIME=94,
No, as I already explained ETIME is for synchronous operation.

In other words when we return ETIME from the wait IOCTL it would mean that =
the waiting has somehow timed out, but not the job we waited for.

Please use ECANCELED as well or some other error code when we find that we =
need to distinct the timedout job from the canceled ones (probably a good i=
dea, but I'm not sure).

[ML] I=92m okay if you insist not to use ETIME


1.        Find the entity/ctx behind this job, and set this ctx as =93guilt=
y=94
Not sure. Do we want to set the whole context as guilty or just the entity?

Setting the whole contexts as guilty sounds racy to me.

BTW: We should use a different name than "guilty", maybe just "bool cancele=
d;" ?

[ML] I think context is better than entity, because for example if you only=
 block entity_0 of context and allow entity_N run, that means the dependenc=
y between entities are broken (e.g. page table updates in
Sdma entity pass but gfx submit in GFX entity blocked, not make sense to me=
)
We=92d better either block the whole context or let not=85



1.        Kick out all jobs in this =93guilty=94 ctx=92s KFIFO queue, and s=
et all their fence status to =93ECANCELED=94
Setting ECANCELED should be ok. But I think we should do this when we try t=
o run the jobs and not during GPU reset.

[ML] without deep thought and expritment, I=92m not sure the difference bet=
ween them, but kick it out in gpu_reset routine is more efficient,
Otherwise you need to check context/entity guilty flag in run_job routine =
=85 and you need to it for every context/entity, I don=92t see why
We don=92t just kickout all of them in gpu_reset stage =85.



a)       Iterate over all living ctx, and set all ctx as =93guilty=94 since=
 VRAM lost actually ruins all VRAM contents
No, that shouldn't be done by comparing the counters. Iterating over all co=
ntexts is way to much overhead.

[ML] because I want to make KMS IOCTL rules clean, like they don=92t need t=
o differentiate VRAM lost or not, they only interested in if the context is=
 guilty or not, and block
Submit for guilty ones.

Can you give more details of your idea? And better the detail implement in =
cs_submit, I want to see how you want to block submit without checking cont=
ext guilty flag



a)       Kick out all jobs in all ctx=92s KFIFO queue, and set all their fe=
nce status to =93ECANCELDED=94
Yes and no, that should be done when we try to run the jobs and not during =
GPU reset.

[ML] again, kicking out them in gpu reset routine is high efficient, otherw=
ise you need check on every job in run_job()
Besides, can you illustrate the detail implementation ?



Yes and no, dma_fence_get_status() is some specific handling for sync_file =
debugging (no idea why that made it into the common fence code).

It was replaced by putting the error code directly into the fence, so just =
reading that one after waiting should be ok.

Maybe we should fix dma_fence_get_status() to do the right thing for this?

[ML] yeah, that=92s too confusing, the name sound really the one I want to =
use, we should change it=85
But look into the implement, I don=92t see why we cannot use it ? it also f=
inally return the fence->error




From: Koenig, Christian
Sent: Wednesday, October 11, 2017 3:21 PM
To: Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; Haehnle, Nicolai <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org=
>; Olsak, Marek <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>; Deucher, Alexander <Alexander.Deuche=
r@amd.com>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Ding, Pixel <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>; Jiang,=
 Jerry (SW) <Jerry.Jiang-5C7GfCeVMHo@public.gmane.org>; Li, Bingley <Bingley.Li-5C7GfCeVMHo@public.gmane.org>; Ramire=
z, Alejandro <Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org>; Filipas, Mario <Mario.Filipas@amd=
.com>
Subject: Re: TDR and VRAM lost handling in KMD:

See inline:

Am 11.10.2017 um 07:33 schrieb Liu, Monk:
Hi Christian & Nicolai,

We need to achieve some agreements on what should MESA/UMD do and what shou=
ld KMD do, please give your comments with =93okay=94 or =93No=94 and your i=
dea on below items,


l  When a job timed out (set from lockup_timeout kernel parameter), What KM=
D should do in TDR routine :


1.        Update adev->gpu_reset_counter, and stop scheduler first, (gpu_re=
set_counter is used to force vm flush after GPU reset, out of this thread=
=92s scope so no more discussion on it)
Okay.



2.        Set its fence error status to =93ETIME=94,
No, as I already explained ETIME is for synchronous operation.

In other words when we return ETIME from the wait IOCTL it would mean that =
the waiting has somehow timed out, but not the job we waited for.

Please use ECANCELED as well or some other error code when we find that we =
need to distinct the timedout job from the canceled ones (probably a good i=
dea, but I'm not sure).



3.        Find the entity/ctx behind this job, and set this ctx as =93guilt=
y=94
Not sure. Do we want to set the whole context as guilty or just the entity?

Setting the whole contexts as guilty sounds racy to me.

BTW: We should use a different name than "guilty", maybe just "bool cancele=
d;" ?



4.        Kick out this job from scheduler=92s mirror list, so this job won=
=92t get re-scheduled to ring anymore.
Okay.



5.        Kick out all jobs in this =93guilty=94 ctx=92s KFIFO queue, and s=
et all their fence status to =93ECANCELED=94
Setting ECANCELED should be ok. But I think we should do this when we try t=
o run the jobs and not during GPU reset.



6.        Force signal all fences that get kicked out by above two steps, o=
therwise UMD will block forever if waiting on those fences
Okay.



7.        Do gpu reset, which is can be some callbacks to let bare-metal an=
d SR-IOV implement with their favor style
Okay.



8.        After reset, KMD need to aware if the VRAM lost happens or not, b=
are-metal can implement some function to judge, while for SR-IOV I prefer t=
o read it from GIM side (for initial version we consider it=92s always VRAM=
 lost, till GIM side change aligned)
Okay.



9.        If VRAM lost not hit, continue, otherwise:

a)       Update adev->vram_lost_counter,
Okay.



b)       Iterate over all living ctx, and set all ctx as =93guilty=94 since=
 VRAM lost actually ruins all VRAM contents
No, that shouldn't be done by comparing the counters. Iterating over all co=
ntexts is way to much overhead.



c)        Kick out all jobs in all ctx=92s KFIFO queue, and set all their f=
ence status to =93ECANCELDED=94
Yes and no, that should be done when we try to run the jobs and not during =
GPU reset.



10.     Do GTT recovery and VRAM page tables/entries recovery (optional, do=
 we need it ???)
Yes, that is still needed. As Nicolai explained we can't be sure that VRAM =
is still 100% correct even when it isn't cleared.



11.     Re-schedule all JOBs remains in mirror list to ring again and resta=
rt scheduler (for VRAM lost case, no JOB will re-scheduled)
Okay.




l  For cs_wait() IOCTL:
After it found fence signaled, it should check with =93dma_fence_get_status=
=94 to see if there is error there,
And return the error status of fence
Yes and no, dma_fence_get_status() is some specific handling for sync_file =
debugging (no idea why that made it into the common fence code).

It was replaced by putting the error code directly into the fence, so just =
reading that one after waiting should be ok.

Maybe we should fix dma_fence_get_status() to do the right thing for this?




l  For cs_wait_fences() IOCTL:
Similar with above approach


l  For cs_submit() IOCTL:
It need to check if current ctx been marked as =93guilty=94 and return =93E=
CANCELED=94 if so


l  Introduce a new IOCTL to let UMD query vram_lost_counter:
This way, UMD can also block app from submitting, like @Nicolai mentioned, =
we can cache one copy of vram_lost_counter when enumerate physical device, =
and deny all
gl-context from submitting if the counter queried bigger than that one cach=
ed in physical device. (looks a little overkill to me, but easy to implemen=
t )
UMD can also return error to APP when creating gl-context if found current =
queried vram_lost_counter bigger than that one cached in physical device.
Okay. Already have a patch for this, please review that one if you haven't =
already done so.

Regards,
Christian.



BTW: I realized that gl-context is a little different with kernel=92s conte=
xt. Because for kernel. BO is not related with context but only with FD, wh=
ile in UMD, BO have a backend
gl-context, so block submitting in UMD layer is also needed although KMD wi=
ll do its job as bottom line


l  Basically =93vram_lost_counter=94 is exposure by kernel to let UMD take =
the control of robust extension feature, it will be UMD=92s call to move, K=
MD only deny =93guilty=94 context from submitting


Need your feedback, thx

We=92d better make TDR feature landed ASAP

BR Monk







--_000_DM5PR12MB1292D21FC5438AEA8FCF9F64FF4A0DM5PR12MB1292namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:??;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:??;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@??";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@??";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:??;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-indent:21.0pt;
	font-size:10.5pt;
	font-family:??;
	color:black;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:??;
	color:black;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:??;
	color:windowtext;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:??;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:65107788;
	mso-list-type:hybrid;
	mso-list-template-ids:1024615094 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
@list l1
	{mso-list-id:387386877;
	mso-list-type:hybrid;
	mso-list-template-ids:1024615094 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
@list l2
	{mso-list-id:697632068;
	mso-list-type:hybrid;
	mso-list-template-ids:448443560 67698689 67698691 67698693 67698689 676986=
91 67698693 67698689 67698691 67698693;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:?;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:?;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:?;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:63.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:?;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:?;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:?;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:126.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:?;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:?;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:?;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:189.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l3
	{mso-list-id:1298757877;
	mso-list-type:hybrid;
	mso-list-template-ids:1024615094 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l3:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;}
@list l3:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l3:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l3:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l3:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l3:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l3:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l3:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l3:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
@list l4
	{mso-list-id:1671643712;
	mso-list-type:hybrid;
	mso-list-template-ids:1024615094 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l4:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;}
@list l4:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l4:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l4:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l4:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l4:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l4:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l4:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l4:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
@list l5
	{mso-list-id:1679431240;
	mso-list-type:hybrid;
	mso-list-template-ids:1024615094 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l5:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;}
@list l5:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l5:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l5:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l5:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l5:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l5:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l5:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l5:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
@list l6
	{mso-list-id:1765762926;
	mso-list-type:hybrid;
	mso-list-template-ids:1024615094 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l6:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;}
@list l6:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l6:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l6:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l6:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l6:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l6:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l6:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l6:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body bgcolor=3D"white" lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p>From a Mesa perspective, this almost all sounds reasonable to me.</p>
<p></p>
<p><br>
</p>
<p>On &quot;guilty&quot;: &quot;guilty&quot; is a term that's used by APIs =
(e.g. OpenGL), so it's reasonable to use it. However, it
<i>does not</i> make sense to mark idle contexts as &quot;guilty&quot; just=
 because VRAM is lost.&nbsp;VRAM lost is a perfect example where the driver=
 should report context lost to applications with the &quot;innocent&quot; f=
lag for contexts that were idle at the time of reset. The
 only context(s) that should be reported as &quot;guilty&quot; (or perhaps =
&quot;unknown&quot; in some cases) are the ones that were executing at the =
time of reset.<br>
</p>
<br>
<p></p>
<p>On whether the whole context is marked as guilty from a user space persp=
ective, it would simply be nice for user space to get consistent answers. I=
t would be a bit odd if we could e.g. succeed in submitting an SDMA job aft=
er a GFX job was rejected. This
 would point in favor of marking the entire context as guilty (although tha=
t could happen lazily instead of at reset time). On the other hand, if that=
's too big a burden for the kernel implementation I'm sure we can live with=
out it.</p>
<p><br>
</p>
<p>Cheers,</p>
<p>Nicolai<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Monk<br>
<b>Sent:</b> Wednesday, October 11, 2017 10:15:40 AM<br>
<b>To:</b> Koenig, Christian; Haehnle, Nicolai; Olsak, Marek; Deucher, Alex=
ander<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Ding, Pixel; Jiang, Jerry (SW); L=
i, Bingley; Ramirez, Alejandro; Filipas, Mario<br>
<b>Subject:</b> RE: TDR and VRAM lost handling in KMD:</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l0 level1 lfo4">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">1=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Set its fence error sta=
tus to </span>
=93<b><span lang=3D"EN-US">ETIME</span></b>=94<span lang=3D"EN-US">,<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;">No, as I already explained ETIME is for synchronou=
s operation.<br>
<br>
In other words when we return ETIME from the wait IOCTL it would mean that =
the waiting has somehow timed out, but not the job we waited for.<br>
<br>
Please use ECANCELED as well or some other error code when we find that we =
need to distinct the timedout job from the canceled ones (probably a good i=
dea, but I'm not sure).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;">[ML] I=92m okay if you insist not to use ETIME<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l4 level1 lfo5">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">1=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Find the entity/ctx beh=
ind this job, and set this ctx as
</span>=93<b><span lang=3D"EN-US">guilty</span></b>=94<span lang=3D"EN-US">=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;">Not sure. Do we want to set the whole context as g=
uilty or just the entity?<br>
<br>
Setting the whole contexts as guilty sounds racy to me.<br>
<br>
BTW: We should use a different name than &quot;guilty&quot;, maybe just &qu=
ot;bool canceled;&quot; ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;">[ML] I think context is better than entity, becaus=
e for example if you only block entity_0 of context and allow entity_N run,=
 that means the dependency between entities are broken
 (e.g. page table updates in <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;">Sdma entity pass but gfx submit in GFX entity bloc=
ked, not make sense to me)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;">We=92d better either block the whole context or le=
t not=85
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l1 level1 lfo6">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">1=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Kick out all jobs in th=
is </span>
=93<span lang=3D"EN-US">guilty</span>=94<span lang=3D"EN-US"> ctx</span>=92=
<span lang=3D"EN-US">s KFIFO queue, and set all their fence status to
</span>=93<b><span lang=3D"EN-US">ECANCELED</span></b>=94<span lang=3D"EN-U=
S"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;">Setting ECANCELED should be ok. But I think we sho=
uld do this when we try to run the jobs and not during GPU reset.<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;">[ML] without deep thought and expritment, I=92m no=
t sure the difference between them, but kick it out in gpu_reset routine is=
 more efficient,
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;">Otherwise you need to check context/entity guilty =
flag in run_job routine =85 and you need to it for every context/entity, I =
don=92t see why
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;">We don=92t just kickout all of them in gpu_reset s=
tage =85.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:42.0pt;text-indent:-21.0=
pt;mso-list:l3 level2 lfo7">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">a=
)<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Iterate over all living=
 ctx, and set all ctx as
</span>=93<b><span lang=3D"EN-US">guilty</span></b>=94<span lang=3D"EN-US">=
 since VRAM lost actually ruins all VRAM contents<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;">No, that shouldn't be done by comparing the counte=
rs. Iterating over all contexts is way to much overhead.<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;">[ML] because I want to make KMS IOCTL rules clean,=
 like they don=92t need to differentiate VRAM lost or not, they only intere=
sted in if the context is guilty or not, and block<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;">Submit for guilty ones.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:12.0pt;fo=
nt-family:&#23435;&#20307;">Can you give more details of your idea? And bet=
ter the detail implement in cs_submit, I want to see how you want to block =
submit without checking context guilty flag<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:42.0pt;text-indent:-21.0=
pt;mso-list:l5 level2 lfo8">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">a=
)<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Kick out all jobs in al=
l ctx</span>=92<span lang=3D"EN-US">s KFIFO queue, and set all their fence =
status to
</span>=93<b><span lang=3D"EN-US">ECANCELDED</span></b>=94<span lang=3D"EN-=
US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;">Yes and no, that should be done when we try to run=
 the jobs and not during GPU reset.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;">[ML] again, kicking out them in gpu reset routine =
is high efficient, otherwise you need check on every job in run_job()<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;">Besides, can you illustrate the detail implementat=
ion ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;">Yes and no, dma_fence_get_status() is some specifi=
c handling for sync_file debugging (no idea why that made it into the commo=
n fence code).<br>
<br>
It was replaced by putting the error code directly into the fence, so just =
reading that one after waiting should be ok.<br>
<br>
Maybe we should fix dma_fence_get_status() to do the right thing for this?<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;">[ML] yeah, that=92s too confusing, the name sound =
really the one I want to use, we should change it=85<o:p></o:p></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:12.0pt;fo=
nt-family:&#23435;&#20307;">But look into the implement, I don=92t see why =
we cannot use it ? it also finally return the fence-&gt;error
<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:12.0pt;font-=
family:&#23435;&#20307;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:windowtext"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:windowtext"><o:p=
>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><b><span la=
ng=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans=
-serif;color:windowtext">From:</span></b><span lang=3D"EN-US" style=3D"font=
-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext">
 Koenig, Christian <br>
<b>Sent:</b> Wednesday, October 11, 2017 3:21 PM<br>
<b>To:</b> Liu, Monk &lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;; Haehnle, Nicolai &lt;Nicolai=
.Haehnle-5C7GfCeVMHo@public.gmane.org&gt;; Olsak, Marek &lt;Marek.Olsak-5C7GfCeVMHo@public.gmane.org&gt;; Deucher, Al=
exander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Ding, Pixel &lt;Pixel.Ding-urvtwAKJhsc@public.gmane.org=
m&gt;; Jiang, Jerry (SW) &lt;Jerry.Jiang-5C7GfCeVMHo@public.gmane.org&gt;; Li, Bingley &lt;Bingl=
ey.Li-5C7GfCeVMHo@public.gmane.org&gt;; Ramirez, Alejandro &lt;Alejandro.Ramirez-5C7GfCeVMHo@public.gmane.org&gt;; Fi=
lipas, Mario &lt;Mario.Filipas-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: TDR and VRAM lost handling in KMD:<o:p></o:p></span></p=
>
</div>
</div>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><span lang=
=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><span lang=
=3D"EN-US">See inline:<br>
<br>
Am 11.10.2017 um 07:33 schrieb Liu, Monk:</span><span lang=3D"EN-US" style=
=3D"font-size:12.0pt"><o:p></o:p></span></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Christian &amp; Nicolai,<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">We need to achieve some agreeme=
nts on what should MESA/UMD do and what should KMD do,
<b>please give your comments with </b></span><b>=93<span lang=3D"EN-US">oka=
y</span>=94<span lang=3D"EN-US"> or
</span>=93<span lang=3D"EN-US">No</span>=94<span lang=3D"EN-US"> and your i=
dea on below items,</span></b><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l2 level1 lfo2">
<![if !supportLists]><span lang=3D"EN-US" style=3D"font-family:Wingdings"><=
span style=3D"mso-list:Ignore">l<span style=3D"font:7.0pt &quot;Times New R=
oman&quot;">&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">When a job timed out (s=
et from lockup_timeout kernel parameter), What KMD should do in TDR routine=
 :<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l6 level1 lfo9">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">1=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Update adev-&gt;<b>gpu_=
reset_counter</b>, and stop scheduler first, (<b>gpu_reset_counter</b> is u=
sed to force vm flush after GPU reset, out of this thread</span>=92<span la=
ng=3D"EN-US">s scope so no more discussion
 on it)<o:p></o:p></span></p>
</blockquote>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><span lang=
=3D"EN-US" style=3D"font-size:12.0pt;font-family:&#23435;&#20307;">Okay.<br=
>
<br>
<br>
<o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l6 level1 lfo9">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">2=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Set its fence error sta=
tus to </span>
=93<b><span lang=3D"EN-US">ETIME</span></b>=94<span lang=3D"EN-US">,<o:p></=
o:p></span></p>
</blockquote>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><span lang=
=3D"EN-US" style=3D"font-size:12.0pt;font-family:&#23435;&#20307;">No, as I=
 already explained ETIME is for synchronous operation.<br>
<br>
In other words when we return ETIME from the wait IOCTL it would mean that =
the waiting has somehow timed out, but not the job we waited for.<br>
<br>
Please use ECANCELED as well or some other error code when we find that we =
need to distinct the timedout job from the canceled ones (probably a good i=
dea, but I'm not sure).<br>
<br>
<br>
<o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l6 level1 lfo9">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">3=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Find the entity/ctx beh=
ind this job, and set this ctx as
</span>=93<b><span lang=3D"EN-US">guilty</span></b>=94<span lang=3D"EN-US">=
<o:p></o:p></span></p>
</blockquote>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><span lang=
=3D"EN-US" style=3D"font-size:12.0pt;font-family:&#23435;&#20307;">Not sure=
. Do we want to set the whole context as guilty or just the entity?<br>
<br>
Setting the whole contexts as guilty sounds racy to me.<br>
<br>
BTW: We should use a different name than &quot;guilty&quot;, maybe just &qu=
ot;bool canceled;&quot; ?<br>
<br>
<br>
<o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l6 level1 lfo9">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">4=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Kick out this job from =
scheduler</span>=92<span lang=3D"EN-US">s mirror list, so this job won</spa=
n>=92<span lang=3D"EN-US">t get re-scheduled to ring anymore.<o:p></o:p></s=
pan></p>
</blockquote>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><span lang=
=3D"EN-US" style=3D"font-size:12.0pt;font-family:&#23435;&#20307;">Okay.<br=
>
<br>
<br>
<o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l6 level1 lfo9">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">5=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Kick out all jobs in th=
is </span>
=93<span lang=3D"EN-US">guilty</span>=94<span lang=3D"EN-US"> ctx</span>=92=
<span lang=3D"EN-US">s KFIFO queue, and set all their fence status to
</span>=93<b><span lang=3D"EN-US">ECANCELED</span></b>=94<span lang=3D"EN-U=
S"><o:p></o:p></span></p>
</blockquote>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><span lang=
=3D"EN-US" style=3D"font-size:12.0pt;font-family:&#23435;&#20307;">Setting =
ECANCELED should be ok. But I think we should do this when we try to run th=
e jobs and not during GPU reset.<br>
<br>
<br>
<o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l6 level1 lfo9">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">6=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Force signal all fences=
 that get kicked out by above two steps,<b> otherwise UMD will block foreve=
r if waiting on those fences</b><o:p></o:p></span></p>
</blockquote>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><span lang=
=3D"EN-US" style=3D"font-size:12.0pt;font-family:&#23435;&#20307;">Okay.<br=
>
<br>
<br>
<o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l6 level1 lfo9">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">7=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Do gpu reset, which is =
can be some callbacks to let bare-metal and SR-IOV implement with their fav=
or style
<o:p></o:p></span></p>
</blockquote>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><span lang=
=3D"EN-US" style=3D"font-size:12.0pt;font-family:&#23435;&#20307;">Okay.<br=
>
<br>
<br>
<o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l6 level1 lfo9">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">8=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">After reset, KMD need t=
o aware if the VRAM lost happens or not, bare-metal can implement some func=
tion to judge, while for SR-IOV I prefer to read it from GIM side (for init=
ial version we consider it</span>=92<span lang=3D"EN-US">s
 always VRAM lost, till GIM side change aligned)<o:p></o:p></span></p>
</blockquote>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><span lang=
=3D"EN-US" style=3D"font-size:12.0pt;font-family:&#23435;&#20307;">Okay.<br=
>
<br>
<br>
<o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l6 level1 lfo9">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">9=
.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">If VRAM lost not hit, c=
ontinue, otherwise:<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:42.0pt;text-indent:-21.0=
pt;mso-list:l6 level2 lfo9">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">a=
)<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Update adev-&gt;<b>vram=
_lost_counter</b>,<o:p></o:p></span></p>
</blockquote>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><span lang=
=3D"EN-US" style=3D"font-size:12.0pt;font-family:&#23435;&#20307;">Okay.<br=
>
<br>
<br>
<o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoListParagraph" style=3D"margin-left:42.0pt;text-indent:-21.0=
pt;mso-list:l6 level2 lfo9">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">b=
)<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Iterate over all living=
 ctx, and set all ctx as
</span>=93<b><span lang=3D"EN-US">guilty</span></b>=94<span lang=3D"EN-US">=
 since VRAM lost actually ruins all VRAM contents<o:p></o:p></span></p>
</blockquote>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><span lang=
=3D"EN-US" style=3D"font-size:12.0pt;font-family:&#23435;&#20307;">No, that=
 shouldn't be done by comparing the counters. Iterating over all contexts i=
s way to much overhead.<br>
<br>
<br>
<o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoListParagraph" style=3D"margin-left:42.0pt;text-indent:-21.0=
pt;mso-list:l6 level2 lfo9">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">c=
)<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Kick out all jobs in al=
l ctx</span>=92<span lang=3D"EN-US">s KFIFO queue, and set all their fence =
status to
</span>=93<b><span lang=3D"EN-US">ECANCELDED</span></b>=94<span lang=3D"EN-=
US"><o:p></o:p></span></p>
</blockquote>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><span lang=
=3D"EN-US" style=3D"font-size:12.0pt;font-family:&#23435;&#20307;">Yes and =
no, that should be done when we try to run the jobs and not during GPU rese=
t.<br>
<br>
<br>
<o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l6 level1 lfo9">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">1=
0.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;=
&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Do GTT recovery and VRA=
M page tables/entries recovery (optional, do we need it ???)<o:p></o:p></sp=
an></p>
</blockquote>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><span lang=
=3D"EN-US" style=3D"font-size:12.0pt;font-family:&#23435;&#20307;">Yes, tha=
t is still needed. As Nicolai explained we can't be sure that VRAM is still=
 100% correct even when it isn't cleared.<br>
<br>
<br>
<o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l6 level1 lfo9">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">1=
1.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;=
&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Re-schedule all JOBs re=
mains in mirror list to ring again and restart scheduler (for VRAM lost cas=
e, no JOB will re-scheduled)<o:p></o:p></span></p>
</blockquote>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><span lang=
=3D"EN-US" style=3D"font-size:12.0pt;font-family:&#23435;&#20307;">Okay.<br=
>
<br>
<br>
<o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l2 level1 lfo2">
<![if !supportLists]><span lang=3D"EN-US" style=3D"font-family:Wingdings"><=
span style=3D"mso-list:Ignore">l<span style=3D"font:7.0pt &quot;Times New R=
oman&quot;">&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">For cs_wait() IOCTL:<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">After it found fence signaled, =
it should check with
</span><b>=93<span lang=3D"EN-US">dma_fence_get_status</span>=94 </b><span =
lang=3D"EN-US">to see if there is error there,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">And return the error status of =
fence<o:p></o:p></span></p>
</blockquote>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><span lang=
=3D"EN-US" style=3D"font-size:12.0pt;font-family:&#23435;&#20307;">Yes and =
no, dma_fence_get_status() is some specific handling for sync_file debuggin=
g (no idea why that made it into the common fence code).<br>
<br>
It was replaced by putting the error code directly into the fence, so just =
reading that one after waiting should be ok.<br>
<br>
Maybe we should fix dma_fence_get_status() to do the right thing for this?<=
br>
<br>
<br>
<o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l2 level1 lfo2">
<![if !supportLists]><span lang=3D"EN-US" style=3D"font-family:Wingdings"><=
span style=3D"mso-list:Ignore">l<span style=3D"font:7.0pt &quot;Times New R=
oman&quot;">&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">For cs_wait_fences() IO=
CTL:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Similar with above approach<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l2 level1 lfo2">
<![if !supportLists]><span lang=3D"EN-US" style=3D"font-family:Wingdings"><=
span style=3D"mso-list:Ignore">l<span style=3D"font:7.0pt &quot;Times New R=
oman&quot;">&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">For cs_submit() IOCTL:<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">It need to check if current ctx=
 been marked as
</span>=93<b><span lang=3D"EN-US">guilty</span></b>=94<span lang=3D"EN-US">=
 and return </span>
=93<b><span lang=3D"EN-US">ECANCELED</span></b>=94<span lang=3D"EN-US"> if =
so<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l2 level1 lfo2">
<![if !supportLists]><span lang=3D"EN-US" style=3D"font-family:Wingdings"><=
span style=3D"mso-list:Ignore">l<span style=3D"font:7.0pt &quot;Times New R=
oman&quot;">&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Introduce a new IOCTL t=
o let UMD query
<b>vram_lost_counter</b>:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">This way, UMD can also block ap=
p from submitting, like @Nicolai mentioned, we can cache one copy of
<b>vram_lost_counter</b> when enumerate physical device, and deny all <o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">gl-context from submitting if t=
he counter queried bigger than that one cached in physical device. (looks a=
 little overkill to me, but easy to implement )
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">UMD can also return error to AP=
P when creating gl-context if found current queried<b> vram_lost_counter
</b>bigger than that one cached in physical device.<o:p></o:p></span></p>
</blockquote>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><span lang=
=3D"EN-US" style=3D"font-size:12.0pt;font-family:&#23435;&#20307;">Okay. Al=
ready have a patch for this, please review that one if you haven't already =
done so.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<br>
<o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">BTW: I realized that gl-context=
 is a little different with kernel</span>=92<span lang=3D"EN-US">s context.=
 Because for kernel. BO is not related with context but only with FD, while=
 in UMD, BO have a backend<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">gl-context, so block submitting=
 in UMD layer is also needed although KMD will do its job as bottom line
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:21.0pt;text-indent:-21.0=
pt;mso-list:l2 level1 lfo2">
<![if !supportLists]><span lang=3D"EN-US" style=3D"font-family:Wingdings"><=
span style=3D"mso-list:Ignore">l<span style=3D"font:7.0pt &quot;Times New R=
oman&quot;">&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Basically </span>=93<sp=
an lang=3D"EN-US">vram_lost_counter</span>=94
<span lang=3D"EN-US">is exposure by kernel to let UMD take the control of r=
obust extension feature, it will be UMD</span>=92<span lang=3D"EN-US">s cal=
l to move, KMD only deny
</span>=93<span lang=3D"EN-US">guilty</span>=94<span lang=3D"EN-US"> contex=
t from submitting<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Need your feedback, thx<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">We</span>=92<span lang=3D"EN-US=
">d better make TDR feature landed ASAP<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">BR Monk<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;<o:p></o:p></span></p>
</blockquote>
<p><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB1292D21FC5438AEA8FCF9F64FF4A0DM5PR12MB1292namp_--

--===============0805935854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0805935854==--
