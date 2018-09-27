From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: use HMM mirror callback to replace mmu
 notifier v4
Date: Thu, 27 Sep 2018 06:59:32 +0000
Message-ID: <a76b71ac-4b5b-45d7-b48b-6d0e4a7e7524@email.android.com>
References: <1536871954-8451-1-git-send-email-Philip.Yang@amd.com>
 <9d6717ac-23f0-7beb-6e41-58c6e32acdf8@amd.com>
 <58bc3bb9-b7b1-a32f-e355-c78a23d95215@gmail.com>
 <383388c8-1bff-48d9-1044-f16e66bcbfa5@amd.com>
 <3850fbeb-5d91-9c14-43c9-45d5d058e15b@amd.com>
 <de28cee0-3461-4f99-eeae-b793de00ca58@amd.com>
 <e4cf7212-4340-8639-c8c1-057e4d1083f0@amd.com>,
 <DM5PR12MB17078469EB6D3AF1D53B788992140@DM5PR12MB1707.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0932822097=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB17078469EB6D3AF1D53B788992140-2J9CzHegvk9TCtO+SvGBKwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
Cc: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0932822097==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_a76b71ac4b5b45d7b48b6d0e4a7e7524emailandroidcom_"

--_000_a76b71ac4b5b45d7b48b6d0e4a7e7524emailandroidcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

No, that won't work. We would still run into lock inversion problems.

What we could do with the scheduler is to turn submissions into dummies if =
we find that the page tables are now outdated.

But that would be really hacky and I'm not sure if that would really work i=
n all cases.

Christian.

Am 27.09.2018 08:53 schrieb "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>:
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
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Christia=
n K=F6nig
Sent: Saturday, September 15, 2018 3:47 AM
To: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>; Yang, Philip <Philip.Yang@amd=
.com>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_a76b71ac4b5b45d7b48b6d0e4a7e7524emailandroidcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto">No, that won't work. We would still run into lock inversi=
on problems.
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">What we could do with the scheduler is to turn submission=
s into dummies if we find that the page tables are now outdated.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">But that would be really hacky and I'm not sure if that w=
ould really work in all cases.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Christian.</div>
</div>
<div class=3D"x_gmail_extra"><br>
<div class=3D"x_gmail_quote">Am 27.09.2018 08:53 schrieb &quot;Kuehling, Fe=
lix&quot; &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;:<br type=3D"attribution">
</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">I had a chat with Jerome yesterday. He pointed out=
 that the new blockable parameter can be used to infer whether the MMU noti=
fier is being called&nbsp; in a reclaim operation. So if blockable=3D=3Dtru=
e, it should even be safe to take the BO reservation
 lock without problems. I think with that we should be able to remove the r=
ead-write locking completely and go back to locking (or try-locking for blo=
ckable=3D=3Dfalse) the reservation locks in the MMU notifier?<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf Of Ch=
ristian K=F6nig<br>
Sent: Saturday, September 15, 2018 3:47 AM<br>
To: Kuehling, Felix &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;; Yang, Philip &lt;Philip=
.Yang-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Jerome Glisse &lt;j.gliss=
e@gmail.com&gt;<br>
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
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font>
</body>
</html>

--_000_a76b71ac4b5b45d7b48b6d0e4a7e7524emailandroidcom_--

--===============0932822097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0932822097==--
