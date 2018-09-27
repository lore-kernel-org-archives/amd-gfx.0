From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: use HMM mirror callback to replace mmu
 notifier v4
Date: Thu, 27 Sep 2018 08:47:19 +0000
Message-ID: <DM5PR12MB1707D5E46617B2936F800F1992140@DM5PR12MB1707.namprd12.prod.outlook.com>
References: <1536871954-8451-1-git-send-email-Philip.Yang@amd.com>
 <9d6717ac-23f0-7beb-6e41-58c6e32acdf8@amd.com>
 <58bc3bb9-b7b1-a32f-e355-c78a23d95215@gmail.com>
 <383388c8-1bff-48d9-1044-f16e66bcbfa5@amd.com>
 <3850fbeb-5d91-9c14-43c9-45d5d058e15b@amd.com>
 <de28cee0-3461-4f99-eeae-b793de00ca58@amd.com>
 <e4cf7212-4340-8639-c8c1-057e4d1083f0@amd.com>,
 <DM5PR12MB17078469EB6D3AF1D53B788992140@DM5PR12MB1707.namprd12.prod.outlook.com>
 <a76b71ac-4b5b-45d7-b48b-6d0e4a7e7524@email.android.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2035542074=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a76b71ac-4b5b-45d7-b48b-6d0e4a7e7524-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2035542074==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1707D5E46617B2936F800F1992140DM5PR12MB1707namp_"

--_000_DM5PR12MB1707D5E46617B2936F800F1992140DM5PR12MB1707namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

So back to my previous question:



>> But do we really need another lock for this? Wouldn't the

>> re-validation of userptr BOs (currently calling get_user_pages) force

>> synchronization with the ongoing page table invalidation through the

>> mmap_sem or other MM locks?

>

> No and yes. We don't hold any other locks while doing command submission,=
 but I expect that HMM has its own mechanism to prevent that.

>

> Since we don't modify amdgpu_mn_lock()/amdgpu_mn_unlock() we are certainl=
y not using this mechanism correctly.

The existing amdgpu_mn_lock/unlock should block the MMU notifier while a co=
mmand submission is in progress. It should also block command submission wh=
ile an MMU notifier is in progress.

What we lose with HMM is the ability to hold a read-lock for the entire dur=
ation of the invalidate_range_start until invalidate_range_end. As I unders=
tand it, that lock is meant to prevent new command submissions while the pa=
ge tables are being updated by the kernel. But my point is, that get_user_p=
ages or hmm_vma_fault should do the same kind of thing. Before the command =
submission can go ahead, it needs to update the userptr addresses. If the p=
age tables are still being updated, it will block there even without holdin=
g the amdgpu_mn_read_lock.

Regards,
  Felix

From: Koenig, Christian
Sent: Thursday, September 27, 2018 3:00 AM
To: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Jero=
me Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: use HMM mirror callback to replace mmu not=
ifier v4

No, that won't work. We would still run into lock inversion problems.

What we could do with the scheduler is to turn submissions into dummies if =
we find that the page tables are now outdated.

But that would be really hacky and I'm not sure if that would really work i=
n all cases.

Christian.

Am 27.09.2018 08:53 schrieb "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org<mailt=
o:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>:
I had a chat with Jerome yesterday. He pointed out that the new blockable p=
arameter can be used to infer whether the MMU notifier is being called  in =
a reclaim operation. So if blockable=3D=3Dtrue, it should even be safe to t=
ake the BO reservation lock without problems. I think with that we should b=
e able to remove the read-write locking completely and go back to locking (=
or try-locking for blockable=3D=3Dfalse) the reservation locks in the MMU n=
otifier?

Regards,
  Felix

-----Original Message-----
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Christian K=F6nig
Sent: Saturday, September 15, 2018 3:47 AM
To: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org<mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>=
; Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org<mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org>>; amd-gfx@l=
ists.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jerome Glisse <=
j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Subject: Re: [PATCH] drm/amdgpu: use HMM mirror callback to replace mmu not=
ifier v4

Am 14.09.2018 um 22:21 schrieb Felix Kuehling:
> On 2018-09-14 01:52 PM, Christian K=F6nig wrote:
>> Am 14.09.2018 um 19:47 schrieb Philip Yang:
>>> On 2018-09-14 03:51 AM, Christian K=F6nig wrote:
>>>> Am 13.09.2018 um 23:51 schrieb Felix Kuehling:
>>>>> On 2018-09-13 04:52 PM, Philip Yang wrote:
>>>>> [SNIP]
>>>>>>    +    amdgpu_mn_read_unlock(amn);
>>>>>> +
>>>>> amdgpu_mn_read_lock/unlock support recursive locking for multiple
>>>>> overlapping or nested invalidation ranges. But if you'r locking
>>>>> and unlocking in the same function. Is that still a concern?
>>> I don't understand the possible recursive case, but
>>> amdgpu_mn_read_lock() still support recursive locking.
>>>> Well the real problem is that unlocking them here won't work.
>>>>
>>>> We need to hold the lock until we are sure that the operation which
>>>> updates the page tables is completed.
>>>>
>>> The reason for this change is because hmm mirror has
>>> invalidate_start callback, no invalidate_end callback
>>>
>>> Check mmu_notifier.c and hmm.c again, below is entire logic to
>>> update CPU page tables and callback:
>>>
>>> mn lock amn->lock is used to protect interval tree access because
>>> user may submit/register new userptr anytime.
>>> This is same for old and new way.
>>>
>>> step 2 guarantee the GPU operation is done before updating CPU page
>>> table.
>>>
>>> So I think the change is safe. We don't need hold mn lock until the
>>> CPU page tables update is completed.
>> No, that isn't even remotely correct. The lock doesn't protects the
>> interval tree.
>>
>>> Old:
>>>     1. down_read_non_owner(&amn->lock)
>>>     2. loop to handle BOs from node->bos through interval tree
>>> amn->object nodes
>>>         gfx: wait for pending BOs fence operation done, mark user
>>> pages dirty
>>>         kfd: evict user queues of the process, wait for queue
>>> unmap/map operation done
>>>     3. update CPU page tables
>>>     4. up_read(&amn->lock)
>>>
>>> New, switch step 3 and 4
>>>     1. down_read_non_owner(&amn->lock)
>>>     2. loop to handle BOs from node->bos through interval tree
>>> amn->object nodes
>>>         gfx: wait for pending BOs fence operation done, mark user
>>> pages dirty
>>>         kfd: evict user queues of the process, wait for queue
>>> unmap/map operation done
>>>     3. up_read(&amn->lock)
>>>     4. update CPU page tables
>> The lock is there to make sure that we serialize page table updates
>> with command submission.
> As I understand it, the idea is to prevent command submission (adding
> new fences to BOs) while a page table invalidation is in progress.

Yes, exactly.

> But do we really need another lock for this? Wouldn't the
> re-validation of userptr BOs (currently calling get_user_pages) force
> synchronization with the ongoing page table invalidation through the
> mmap_sem or other MM locks?

No and yes. We don't hold any other locks while doing command submission, b=
ut I expect that HMM has its own mechanism to prevent that.

Since we don't modify amdgpu_mn_lock()/amdgpu_mn_unlock() we are certainly =
not using this mechanism correctly.

Regards,
Christian.
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB1707D5E46617B2936F800F1992140DM5PR12MB1707namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.emailquote, li.emailquote, div.emailquote
	{mso-style-name:emailquote;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:1.0pt;
	border:none;
	padding:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">So back to my previous question:<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt;&gt; But do we really need another lock for t=
his? Wouldn't the
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&gt; re-validation of userptr BOs (currently =
calling get_user_pages) force
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&gt; synchronization with the ongoing page ta=
ble invalidation through the
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&gt; mmap_sem or other MM locks?<o:p></o:p></=
p>
<p class=3D"MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt; No and yes. We don't hold any other locks wh=
ile doing command submission, but I expect that HMM has its own mechanism t=
o prevent that.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt; Since we don't modify amdgpu_mn_lock()/amdgp=
u_mn_unlock() we are certainly not using this mechanism correctly.<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The existing amdgpu_mn_lock/unlock should block the =
MMU notifier while a command submission is in progress. It should also bloc=
k command submission while an MMU notifier is in progress.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">What we lose with HMM is the ability to hold a read-=
lock for the entire duration of the invalidate_range_start until invalidate=
_range_end. As I understand it, that lock is meant to prevent new command s=
ubmissions while the page tables are
 being updated by the kernel. But my point is, that get_user_pages or hmm_v=
ma_fault should do the same kind of thing. Before the command submission ca=
n go ahead, it needs to update the userptr addresses. If the page tables ar=
e still being updated, it will block
 there even without holding the amdgpu_mn_read_lock.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; Felix<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Koenig, Christian <br>
<b>Sent:</b> Thursday, September 27, 2018 3:00 AM<br>
<b>To:</b> Kuehling, Felix &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> Yang, Philip &lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org; Jerome Glisse &lt;j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: use HMM mirror callback to replace =
mmu notifier v4<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">No, that won't work. We would still run into lock in=
version problems.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">What we could do with the scheduler is to turn submi=
ssions into dummies if we find that the page tables are now outdated.<o:p><=
/o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">But that would be really hacky and I'm not sure if t=
hat would really work in all cases.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Christian.<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Am 27.09.2018 08:53 schrieb &quot;Kuehling, Felix&qu=
ot; &lt;<a href=3D"mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a=
>&gt;:<o:p></o:p></p>
</div>
</div>
</div>
<div>
<p class=3D"MsoNormal">I had a chat with Jerome yesterday. He pointed out t=
hat the new blockable parameter can be used to infer whether the MMU notifi=
er is being called&nbsp; in a reclaim operation. So if blockable=3D=3Dtrue,=
 it should even be safe to take the BO reservation
 lock without problems. I think with that we should be able to remove the r=
ead-write locking completely and go back to locking (or try-locking for blo=
ckable=3D=3Dfalse) the reservation locks in the MMU notifier?<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">=
amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; On Behalf Of Christian K=F6ni=
g<br>
Sent: Saturday, September 15, 2018 3:47 AM<br>
To: Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">Felix.Kue=
hling-5C7GfCeVMHo@public.gmane.org</a>&gt;; Yang, Philip &lt;<a href=3D"mailto:Philip.Yang@amd.c=
om">Philip.Yang-5C7GfCeVMHo@public.gmane.org</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a>; Jerome Glisse &lt;<a href=3D"mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">j.glisse@g=
mail.com</a>&gt;<br>
Subject: Re: [PATCH] drm/amdgpu: use HMM mirror callback to replace mmu not=
ifier v4<br>
<br>
Am 14.09.2018 um 22:21 schrieb Felix Kuehling:<br>
&gt; On 2018-09-14 01:52 PM, Christian K=F6nig wrote:<br>
&gt;&gt; Am 14.09.2018 um 19:47 schrieb Philip Yang:<br>
&gt;&gt;&gt; On 2018-09-14 03:51 AM, Christian K=F6nig wrote:<br>
&gt;&gt;&gt;&gt; Am 13.09.2018 um 23:51 schrieb Felix Kuehling:<br>
&gt;&gt;&gt;&gt;&gt; On 2018-09-13 04:52 PM, Philip Yang wrote:<br>
&gt;&gt;&gt;&gt;&gt; [SNIP]<br>
&gt;&gt;&gt;&gt;&gt;&gt;&nbsp; &nbsp; &#43;&nbsp;&nbsp;&nbsp; amdgpu_mn_rea=
d_unlock(amn);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt;&gt; amdgpu_mn_read_lock/unlock support recursive locking f=
or multiple <br>
&gt;&gt;&gt;&gt;&gt; overlapping or nested invalidation ranges. But if you'=
r locking <br>
&gt;&gt;&gt;&gt;&gt; and unlocking in the same function. Is that still a co=
ncern?<br>
&gt;&gt;&gt; I don't understand the possible recursive case, but<br>
&gt;&gt;&gt; amdgpu_mn_read_lock() still support recursive locking.<br>
&gt;&gt;&gt;&gt; Well the real problem is that unlocking them here won't wo=
rk.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; We need to hold the lock until we are sure that the operat=
ion which <br>
&gt;&gt;&gt;&gt; updates the page tables is completed.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; The reason for this change is because hmm mirror has <br>
&gt;&gt;&gt; invalidate_start callback, no invalidate_end callback<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Check mmu_notifier.c and hmm.c again, below is entire logic to=
 <br>
&gt;&gt;&gt; update CPU page tables and callback:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; mn lock amn-&gt;lock is used to protect interval tree access b=
ecause <br>
&gt;&gt;&gt; user may submit/register new userptr anytime.<br>
&gt;&gt;&gt; This is same for old and new way.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; step 2 guarantee the GPU operation is done before updating CPU=
 page <br>
&gt;&gt;&gt; table.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; So I think the change is safe. We don't need hold mn lock unti=
l the <br>
&gt;&gt;&gt; CPU page tables update is completed.<br>
&gt;&gt; No, that isn't even remotely correct. The lock doesn't protects th=
e <br>
&gt;&gt; interval tree.<br>
&gt;&gt;<br>
&gt;&gt;&gt; Old:<br>
&gt;&gt;&gt;&nbsp; &nbsp;&nbsp; 1. down_read_non_owner(&amp;amn-&gt;lock)<b=
r>
&gt;&gt;&gt;&nbsp; &nbsp;&nbsp; 2. loop to handle BOs from node-&gt;bos thr=
ough interval tree<br>
&gt;&gt;&gt; amn-&gt;object nodes<br>
&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx: wait for pendi=
ng BOs fence operation done, mark user <br>
&gt;&gt;&gt; pages dirty<br>
&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd: evict user que=
ues of the process, wait for queue <br>
&gt;&gt;&gt; unmap/map operation done<br>
&gt;&gt;&gt;&nbsp; &nbsp;&nbsp; 3. update CPU page tables<br>
&gt;&gt;&gt;&nbsp; &nbsp;&nbsp; 4. up_read(&amp;amn-&gt;lock)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; New, switch step 3 and 4<br>
&gt;&gt;&gt;&nbsp; &nbsp;&nbsp; 1. down_read_non_owner(&amp;amn-&gt;lock)<b=
r>
&gt;&gt;&gt;&nbsp; &nbsp;&nbsp; 2. loop to handle BOs from node-&gt;bos thr=
ough interval tree<br>
&gt;&gt;&gt; amn-&gt;object nodes<br>
&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx: wait for pendi=
ng BOs fence operation done, mark user <br>
&gt;&gt;&gt; pages dirty<br>
&gt;&gt;&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd: evict user que=
ues of the process, wait for queue <br>
&gt;&gt;&gt; unmap/map operation done<br>
&gt;&gt;&gt;&nbsp; &nbsp;&nbsp; 3. up_read(&amp;amn-&gt;lock)<br>
&gt;&gt;&gt;&nbsp; &nbsp;&nbsp; 4. update CPU page tables<br>
&gt;&gt; The lock is there to make sure that we serialize page table update=
s <br>
&gt;&gt; with command submission.<br>
&gt; As I understand it, the idea is to prevent command submission (adding =
<br>
&gt; new fences to BOs) while a page table invalidation is in progress.<br>
<br>
Yes, exactly.<br>
<br>
&gt; But do we really need another lock for this? Wouldn't the <br>
&gt; re-validation of userptr BOs (currently calling get_user_pages) force =
<br>
&gt; synchronization with the ongoing page table invalidation through the <=
br>
&gt; mmap_sem or other MM locks?<br>
<br>
No and yes. We don't hold any other locks while doing command submission, b=
ut I expect that HMM has its own mechanism to prevent that.<br>
<br>
Since we don't modify amdgpu_mn_lock()/amdgpu_mn_unlock() we are certainly =
not using this mechanism correctly.<br>
<br>
Regards,<br>
Christian.<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB1707D5E46617B2936F800F1992140DM5PR12MB1707namp_--

--===============2035542074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2035542074==--
