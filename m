From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: use HMM mirror callback to replace mmu
 notifier v4
Date: Thu, 27 Sep 2018 14:29:30 +0000
Message-ID: <1068c389-56fc-4125-ac40-b1ef2d60eabd@email.android.com>
References: <1536871954-8451-1-git-send-email-Philip.Yang@amd.com>
 <9d6717ac-23f0-7beb-6e41-58c6e32acdf8@amd.com>
 <58bc3bb9-b7b1-a32f-e355-c78a23d95215@gmail.com>
 <383388c8-1bff-48d9-1044-f16e66bcbfa5@amd.com>
 <3850fbeb-5d91-9c14-43c9-45d5d058e15b@amd.com>
 <de28cee0-3461-4f99-eeae-b793de00ca58@amd.com>
 <e4cf7212-4340-8639-c8c1-057e4d1083f0@amd.com>
 <DM5PR12MB17078469EB6D3AF1D53B788992140@DM5PR12MB1707.namprd12.prod.outlook.com>
 <a76b71ac-4b5b-45d7-b48b-6d0e4a7e7524@email.android.com>
 <DM5PR12MB1707D5E46617B2936F800F1992140@DM5PR12MB1707.namprd12.prod.outlook.com>
 <d752c19b-6d2e-c7c1-1cd7-651e25b8f708@amd.com>
 <DM5PR12MB17077A78E0F95BFBA57F2E1A92140@DM5PR12MB1707.namprd12.prod.outlook.com>
 <425fe859-c780-48a5-a2c6-c3bf2b9abb38@amd.com>
 <DM5PR12MB17072AE77EB0DE3AD22B8D7892140@DM5PR12MB1707.namprd12.prod.outlook.com>
 <9b427976-f2ff-8ba1-6ebf-588ca95aef80@amd.com>,
 <DM5PR12MB17072879EC907150027D6F7892140@DM5PR12MB1707.namprd12.prod.outlook.com>
 <58199419-e20f-4ab0-ac1d-a7eb79f5c6f7@email.android.com>,
 <DM5PR12MB1707273AC4B0C03A3BEDF73092140@DM5PR12MB1707.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0674006268=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1707273AC4B0C03A3BEDF73092140-2J9CzHegvk9TCtO+SvGBKwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: de-DE
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: "j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Yang,
 Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0674006268==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_1068c38956fc4125ac40b1ef2d60eabdemailandroidcom_"

--_000_1068c38956fc4125ac40b1ef2d60eabdemailandroidcom_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

At least with get_user_pages() that is perfectly possible.

For HMM it could be that this is prevented somehow.

Christian.

Am 27.09.2018 16:27 schrieb "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>:
> In this case you can end up accessing pages which are invalidated while g=
et_user_pages is in process.

What=92s the sequence of events you have in mind? Something like this?


  *   Page table is updated and triggers MMU notifier
  *   amdgpu MMU notifier runs and waits for pending CS to finish while hol=
ding the read lock
  *   New CS starts just after invalidate_range_start MMU notifier finishes=
 but before the page table update is done
  *   get_user_pages returns outdated physical addresses

I hope that=92s not actually possible and that get_user_pages or hmm_vma_fa=
ult would block until the page table update is done. That is, invalidate_ra=
nge_start marks the start of a page table update, and while that update is =
in progress, get_user_pages or hmm_vma_fault block. Jerome, can you comment=
 on that?

Thanks,
  Felix

From: Koenig, Christian
Sent: Thursday, September 27, 2018 9:59 AM
To: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Jero=
me Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: use HMM mirror callback to replace mmu not=
ifier v4

Yeah I understand that, but again that won't work.

In this case you can end up accessing pages which are invalidated while get=
_user_pages is in process.

Christian.

Am 27.09.2018 15:41 schrieb "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org<mailt=
o:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>:
> I=92m not planning to change that. I don=92t think there is any need to c=
hange it.
>
> Yeah, but when HMM doesn't provide both the start and the end hock of the=
 invalidation this way won't work any more.
>
> So we need to find a solution for this,
> Christian.

My whole argument is that you don=92t need to hold the read lock until the =
invalidate_range_end. Just read_lock and read_unlock in the invalidate_rang=
e_start function.

Regards,
  Felix

From: Koenig, Christian
Sent: Thursday, September 27, 2018 9:22 AM
To: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org<mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>
Cc: Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org<mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jerome Glisse=
 <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Subject: Re: [PATCH] drm/amdgpu: use HMM mirror callback to replace mmu not=
ifier v4

Am 27.09.2018 um 15:18 schrieb Kuehling, Felix:
> The problem is here:
>
> ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
> amdgpu_mn_unlock(p->mn);
>
> We need to hold the lock until the fence is added to the reservation obje=
ct.
>
> Otherwise somebody could have changed the page tables just in the moment =
between the check of amdgpu_ttm_tt_userptr_needs_pages() and adding the fen=
ce to the reservation object.

I=92m not planning to change that. I don=92t think there is any need to cha=
nge it.

Yeah, but when HMM doesn't provide both the start and the end hock of the i=
nvalidation this way won't work any more.

So we need to find a solution for this,
Christian.


Regards,
  Felix

From: Koenig, Christian
Sent: Thursday, September 27, 2018 7:24 AM
To: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org><mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org><mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jerome Glisse=
 <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org><mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use HMM mirror callback to replace mmu not=
ifier v4

Am 27.09.2018 um 13:08 schrieb Kuehling, Felix:
> We double check that there wasn't any page table modification while we pr=
epared the submission and restart the whole process when there actually was=
 some update.
>
> The reason why we need to do this is here:
>
>        ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
>        amdgpu_mn_unlock(p->mn);
>
> Only after the new fence is added to the buffer object we can release the=
 lock so that any invalidation will now block on our command submission to =
finish before it modifies the page table.


I don=92t see why this requires holding the read-lock until invalidate_rang=
e_end. amdgpu_ttm_tt_affect_userptr gets called while the mn read-lock is h=
eld in invalidate_range_start notifier.

That's not related to amdgpu_ttm_tt_affect_userptr(), this function could a=
ctually be called outside the lock.

The problem is here:

ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
amdgpu_mn_unlock(p->mn);

We need to hold the lock until the fence is added to the reservation object=
.

Otherwise somebody could have changed the page tables just in the moment be=
tween the check of amdgpu_ttm_tt_userptr_needs_pages() and adding the fence=
 to the reservation object.

Regards,
Christian.




Regards,
  Felix

From: Koenig, Christian
Sent: Thursday, September 27, 2018 5:27 AM
To: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org><mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org><mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jerome Glisse=
 <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org><mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use HMM mirror callback to replace mmu not=
ifier v4

That is correct, but take a look what we do when after calling the amdgpu_m=
n_read_lock():



        /* No memory allocation is allowed while holding the mn lock */
        amdgpu_mn_lock(p->mn);
        amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
                struct amdgpu_bo *bo =3D ttm_to_amdgpu_bo(e->tv.bo);

                if (amdgpu_ttm_tt_userptr_needs_pages(bo->tbo.ttm)) {
                        r =3D -ERESTARTSYS;
                        goto error_abort;
                }
        }

We double check that there wasn't any page table modification while we prep=
ared the submission and restart the whole process when there actually was s=
ome update.

The reason why we need to do this is here:


        ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
        amdgpu_mn_unlock(p->mn);

Only after the new fence is added to the buffer object we can release the l=
ock so that any invalidation will now block on our command submission to fi=
nish before it modifies the page table.

The only other option would be to add the fence first and then check if the=
re was any update to the page tables.

The issue with that approach is that adding a fence can't be made undone, s=
o if we find that there actually was an update to the page tables we would =
need to somehow turn the CS into a dummy (e.g. overwrite all IBs with NOPs =
or something like that) and still submit it.

Not sure if that is actually possible.

Regards,
Christian.

Am 27.09.2018 um 10:47 schrieb Kuehling, Felix:
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
To: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org><mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org><mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jerome Glisse=
 <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org><mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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




--_000_1068c38956fc4125ac40b1ef2d60eabdemailandroidcom_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta content=3D"text/html; charset=3Diso-8859-1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style>
<!--
@font-face
	{font-family:Wingdings}
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:Consolas}
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black}
p.msonormal0, li.msonormal0, div.msonormal0
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.PlainTextChar
	{font-family:Consolas;
	color:black}
p.msonormal00, li.msonormal00, div.msonormal00
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black}
p.emailquote, li.emailquote, div.emailquote
	{margin-right:0in;
	margin-left:1.0pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black}
p.msochpdefault, li.msochpdefault, div.msochpdefault
	{margin-right:0in;
	margin-left:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif}
span.plaintextchar0
	{font-family:"Calibri",sans-serif}
span.emailstyle22
	{font-family:"Calibri",sans-serif;
	color:windowtext}
span.emailstyle23
	{font-family:"Calibri",sans-serif;
	color:windowtext}
span.emailstyle24
	{font-family:"Calibri",sans-serif;
	color:windowtext}
span.emailstyle25
	{font-family:"Calibri",sans-serif;
	color:windowtext}
span.EmailStyle30
	{font-family:"Calibri",sans-serif;
	color:windowtext}
.MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.WordSection1
	{}
ol
	{margin-bottom:0in}
ul
	{margin-bottom:0in}
-->
</style>
</head>
<body bgcolor=3D"white" lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div dir=3D"auto">At least with get_user_pages() that is perfectly possible=
.
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">For HMM it could be that this is prevented somehow.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Christian.</div>
</div>
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">Am 27.09.2018 16:27 schrieb &quot;Kuehling, Feli=
x&quot; &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;:<br type=3D"attribution">
</div>
</div>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&gt; In this case y=
ou can end up accessing pages which are invalidated while get_user_pages is=
 in process.</span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">What=92s the sequen=
ce of events you have in mind? Something like this?</span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
<ul type=3D"disc" style=3D"margin-top:0in">
<li class=3D"MsoListParagraph" style=3D"color:windowtext; margin-left:0in">=
Page table is updated and triggers MMU notifier</li><li class=3D"MsoListPar=
agraph" style=3D"color:windowtext; margin-left:0in">amdgpu MMU notifier run=
s and waits for pending CS to finish while holding the read lock</li><li cl=
ass=3D"MsoListParagraph" style=3D"color:windowtext; margin-left:0in">New CS=
 starts just after invalidate_range_start MMU notifier finishes but before =
the page table update is done</li><li class=3D"MsoListParagraph" style=3D"c=
olor:windowtext; margin-left:0in">get_user_pages returns outdated physical =
addresses</li></ul>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">I hope that=92s not=
 actually possible and that get_user_pages or hmm_vma_fault would block unt=
il the page table update is done. That is, invalidate_range_start marks the=
 start of a page table update, and while
 that update is in progress, get_user_pages or hmm_vma_fault block. Jerome,=
 can you comment on that?</span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">Thanks,<br>
&nbsp; Felix</span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"color:windowtext">From:</span></b>=
<span style=3D"color:windowtext"> Koenig, Christian
<br>
<b>Sent:</b> Thursday, September 27, 2018 9:59 AM<br>
<b>To:</b> Kuehling, Felix &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> Yang, Philip &lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org; Jerome Glisse &lt;j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: use HMM mirror callback to replace =
mmu notifier v4</span></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;</p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">Yeah I understand t=
hat, but again that won't work.
</span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">In this case you ca=
n end up accessing pages which are invalidated while get_user_pages is in p=
rocess.</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">Christian.</span></=
p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">Am 27.09.2018 15:41=
 schrieb &quot;Kuehling, Felix&quot; &lt;<a href=3D"mailto:Felix.Kuehling@a=
md.com">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;:</span></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&gt; I=92m not plan=
ning to change that. I don=92t think there is any need to change it.</span>=
</p>
<p class=3D"MsoNormal">&gt;<br>
&gt; Yeah, but when HMM doesn't provide both the start and the end hock of =
the invalidation this way won't work any more.<br>
&gt;<br>
&gt; So we need to find a solution for this,<br>
&gt; Christian.</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">My whole argument is that you don=92t need to hold t=
he read lock until the invalidate_range_end. Just read_lock and read_unlock=
 in the invalidate_range_start function.</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">Regards,</p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">&nbsp; Felix</p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"color:windowtext">From:</span></b>=
<span style=3D"color:windowtext"> Koenig, Christian
<br>
<b>Sent:</b> Thursday, September 27, 2018 9:22 AM<br>
<b>To:</b> Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">Fe=
lix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Cc:</b> Yang, Philip &lt;<a href=3D"mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org">Philip.Y=
ang-5C7GfCeVMHo@public.gmane.org</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a>; Jerome Glisse &lt;<a href=3D"mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">j.glisse@g=
mail.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: use HMM mirror callback to replace =
mmu notifier v4</span></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;</p>
<div>
<p class=3D"MsoNormal">Am 27.09.2018 um 15:18 schrieb Kuehling, Felix:</p>
</div>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<p class=3D"MsoNormal">&gt; The problem is here:<br>
&gt;</p>
<p class=3D"MsoNormal">&gt; ttm_eu_fence_buffer_objects(&amp;p-&gt;ticket, =
&amp;p-&gt;validated, p-&gt;fence);</p>
<p class=3D"MsoNormal">&gt; amdgpu_mn_unlock(p-&gt;mn); </p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">&gt;<br>
&gt; We need to hold the lock until the fence is added to the reservation o=
bject.<br>
&gt;<br>
&gt; Otherwise somebody could have changed the page tables just in the mome=
nt between the check of amdgpu_ttm_tt_userptr_needs_pages() and adding the =
fence to the reservation object.<br>
<br>
</p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">I=92m not planning =
to change that. I don=92t think there is any need to change it.</span></p>
</blockquote>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
Yeah, but when HMM doesn't provide both the start and the end hock of the i=
nvalidation this way won't work any more.<br>
<br>
So we need to find a solution for this,<br>
Christian.<br>
<br>
</p>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">Regards,</span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&nbsp; Felix</span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"color:windowtext">From:</span></b>=
<span style=3D"color:windowtext"> Koenig, Christian
<br>
<b>Sent:</b> Thursday, September 27, 2018 7:24 AM<br>
<b>To:</b> Kuehling, Felix <a href=3D"mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">&lt;Fe=
lix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Cc:</b> Yang, Philip <a href=3D"mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org">&lt;Philip.Y=
ang-5C7GfCeVMHo@public.gmane.org&gt;</a>;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a>; Jerome Glisse
<a href=3D"mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: use HMM mirror callback to replace =
mmu notifier v4</span></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;</p>
<div>
<p class=3D"MsoNormal">Am 27.09.2018 um 13:08 schrieb Kuehling, Felix:</p>
</div>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<p class=3D"MsoNormal">&gt; We double check that there wasn't any page tabl=
e modification while we prepared the submission and restart the whole proce=
ss when there actually was some update.<br>
&gt;<br>
&gt; The reason why we need to do this is here:<br>
&gt;</p>
<p class=3D"MsoNormal">&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_eu_fen=
ce_buffer_objects(&amp;p-&gt;ticket, &amp;p-&gt;validated, p-&gt;fence);<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mn_unlock(p-&gt;mn);<=
/p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">&gt;<br>
&gt; Only after the new fence is added to the buffer object we can release =
the lock so that any invalidation will now block on our command submission =
to finish before it modifies the page table.<br>
<br>
<br>
</p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">I don=92t see why t=
his requires holding the read-lock until invalidate_range_end. amdgpu_ttm_t=
t_affect_userptr gets called while the mn read-lock is held in invalidate_r=
ange_start notifier.</span></p>
</blockquote>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
That's not related to amdgpu_ttm_tt_affect_userptr(), this function could a=
ctually be called outside the lock.<br>
<br>
The problem is here:<br>
<br>
</p>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<p class=3D"MsoNormal">ttm_eu_fence_buffer_objects(&amp;p-&gt;ticket, &amp;=
p-&gt;validated, p-&gt;fence);</p>
</blockquote>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<p class=3D"MsoNormal">amdgpu_mn_unlock(p-&gt;mn); </p>
</blockquote>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
We need to hold the lock until the fence is added to the reservation object=
.<br>
<br>
Otherwise somebody could have changed the page tables just in the moment be=
tween the check of amdgpu_ttm_tt_userptr_needs_pages() and adding the fence=
 to the reservation object.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<br>
<br>
</p>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">Regards,</span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&nbsp; Felix</span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"color:windowtext">From:</span></b>=
<span style=3D"color:windowtext"> Koenig, Christian
<br>
<b>Sent:</b> Thursday, September 27, 2018 5:27 AM<br>
<b>To:</b> Kuehling, Felix <a href=3D"mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">&lt;Fe=
lix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Cc:</b> Yang, Philip <a href=3D"mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org">&lt;Philip.Y=
ang-5C7GfCeVMHo@public.gmane.org&gt;</a>;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a>; Jerome Glisse
<a href=3D"mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: use HMM mirror callback to replace =
mmu notifier v4</span></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;</p>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">That is correct, but =
take a look what we do when after calling the amdgpu_mn_read_lock():<br>
<br>
<br>
<br>
</p>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* No mem=
ory allocation is allowed while holding the mn lock */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mn_lock(p-&gt;mn);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_list_for_each_userptr_=
entry(e, p-&gt;bo_list) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_bo *bo =3D ttm_to_amdgpu_bo(e-&gt;tv.bo);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (amdgpu_ttm_tt_userptr_needs_pages(bo-&gt;tbo.ttm)) {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D -ERES=
TARTSYS;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_=
abort;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
</blockquote>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
We double check that there wasn't any page table modification while we prep=
ared the submission and restart the whole process when there actually was s=
ome update.<br>
<br>
The reason why we need to do this is here:<br>
<br>
<br>
</p>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_eu_fe=
nce_buffer_objects(&amp;p-&gt;ticket, &amp;p-&gt;validated, p-&gt;fence);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mn_unlock(p-&gt;mn);</p>
</blockquote>
<p class=3D"MsoNormal"><br>
Only after the new fence is added to the buffer object we can release the l=
ock so that any invalidation will now block on our command submission to fi=
nish before it modifies the page table.<br>
<br>
The only other option would be to add the fence first and then check if the=
re was any update to the page tables.<br>
<br>
The issue with that approach is that adding a fence can't be made undone, s=
o if we find that there actually was an update to the page tables we would =
need to somehow turn the CS into a dummy (e.g. overwrite all IBs with NOPs =
or something like that) and still
 submit it.<br>
<br>
Not sure if that is actually possible.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 27.09.2018 um 10:47 schrieb Kuehling, Felix:</p>
</div>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<p class=3D"MsoNormal">So back to my previous question:</p>
<p class=3D"MsoPlainText">&nbsp;</p>
<p class=3D"MsoPlainText">&gt;&gt; But do we really need another lock for t=
his? Wouldn't the
</p>
<p class=3D"MsoPlainText">&gt;&gt; re-validation of userptr BOs (currently =
calling get_user_pages) force
</p>
<p class=3D"MsoPlainText">&gt;&gt; synchronization with the ongoing page ta=
ble invalidation through the
</p>
<p class=3D"MsoPlainText">&gt;&gt; mmap_sem or other MM locks?</p>
<p class=3D"MsoPlainText">&gt;&nbsp;</p>
<p class=3D"MsoPlainText">&gt; No and yes. We don't hold any other locks wh=
ile doing command submission, but I expect that HMM has its own mechanism t=
o prevent that.</p>
<p class=3D"MsoPlainText">&gt;&nbsp;</p>
<p class=3D"MsoPlainText">&gt; Since we don't modify amdgpu_mn_lock()/amdgp=
u_mn_unlock() we are certainly not using this mechanism correctly.</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">The existing amdgpu_mn_lock/unlock should block the =
MMU notifier while a command submission is in progress. It should also bloc=
k command submission while an MMU notifier is in progress.</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">What we lose with HMM is the ability to hold a read-=
lock for the entire duration of the invalidate_range_start until invalidate=
_range_end. As I understand it, that lock is meant to prevent new command s=
ubmissions while the page tables are
 being updated by the kernel. But my point is, that get_user_pages or hmm_v=
ma_fault should do the same kind of thing. Before the command submission ca=
n go ahead, it needs to update the userptr addresses. If the page tables ar=
e still being updated, it will block
 there even without holding the amdgpu_mn_read_lock.</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">Regards,</p>
<p class=3D"MsoNormal">&nbsp; Felix</p>
<p class=3D"MsoNormal">&nbsp;</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Koenig, Christian <br>
<b>Sent:</b> Thursday, September 27, 2018 3:00 AM<br>
<b>To:</b> Kuehling, Felix <a href=3D"mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">&lt;Fe=
lix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Cc:</b> Yang, Philip <a href=3D"mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org">&lt;Philip.Y=
ang-5C7GfCeVMHo@public.gmane.org&gt;</a>;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a>; Jerome Glisse
<a href=3D"mailto:j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: use HMM mirror callback to replace =
mmu notifier v4</p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"MsoNormal">No, that won't work. We would still run into lock in=
version problems.</p>
<div>
<p class=3D"MsoNormal">&nbsp;</p>
</div>
<div>
<p class=3D"MsoNormal">What we could do with the scheduler is to turn submi=
ssions into dummies if we find that the page tables are now outdated.</p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;</p>
</div>
<div>
<p class=3D"MsoNormal">But that would be really hacky and I'm not sure if t=
hat would really work in all cases.</p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;</p>
</div>
<div>
<p class=3D"MsoNormal">Christian.</p>
</div>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;</p>
<div>
<p class=3D"MsoNormal">Am 27.09.2018 08:53 schrieb &quot;Kuehling, Felix&qu=
ot; &lt;<a href=3D"mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a=
>&gt;:</p>
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
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></p>
</div>
</blockquote>
<p class=3D"MsoNormal">&nbsp;</p>
</blockquote>
<p class=3D"MsoNormal">&nbsp;</p>
</blockquote>
<p class=3D"MsoNormal">&nbsp;</p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_1068c38956fc4125ac40b1ef2d60eabdemailandroidcom_--

--===============0674006268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0674006268==--
