From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Add support for high priority scheduling in amdgpu v4
Date: Fri, 3 Mar 2017 09:52:42 -0500
Message-ID: <CAFQ_0eFqcesdwyVxRjxnZ2L+-9L5Qmh5Spj=tbkkYm5HdC5N1A@mail.gmail.com>
References: <20170302214448.4146-1-andresx7@gmail.com>
 <f946ac29-6501-d550-2df0-515e0439bc8c@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0765904883=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f946ac29-6501-d550-2df0-515e0439bc8c-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0765904883==
Content-Type: multipart/alternative; boundary=001a1142e732ac08720549d4b23e

--001a1142e732ac08720549d4b23e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Sorry about that, makes sense!

On Mar 3, 2017 8:51 AM, "Christian K=C3=B6nig" <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org> wr=
ote:

> Please add Acks and Reviews to your patches when sending them out again.
>
> I'm totally loosing track what I've looked at and what not.
>
> But in general the whole set starts to look rather good to me.
>
> Regards,
> Christian.
>
> Am 02.03.2017 um 22:44 schrieb Andres Rodriguez:
>
>> This revision implements Christian's latest feedback:
>>
>> 1) Avoid indirection in amdgpu_queue_manager, call the map functions
>> directly
>> 2) Drop refcounting patch for amdgpu_job
>> 3) Restore ring priority from amdgpu_job_free_cb()
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>
>
>

--001a1142e732ac08720549d4b23e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Sorry about that, makes sense!</div><div class=3D"gmail_e=
xtra"><br><div class=3D"gmail_quote">On Mar 3, 2017 8:51 AM, &quot;Christia=
n K=C3=B6nig&quot; &lt;<a href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">deathsimp=
le-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">Please add Acks and Reviews to your patches when sending them out=
 again.<br>
<br>
I&#39;m totally loosing track what I&#39;ve looked at and what not.<br>
<br>
But in general the whole set starts to look rather good to me.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 02.03.2017 um 22:44 schrieb Andres Rodriguez:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
This revision implements Christian&#39;s latest feedback:<br>
<br>
1) Avoid indirection in amdgpu_queue_manager, call the map functions direct=
ly<br>
2) Drop refcounting patch for amdgpu_job<br>
3) Restore ring priority from amdgpu_job_free_cb()<br>
<br>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote>
<br>
<br>
</blockquote></div></div>

--001a1142e732ac08720549d4b23e--

--===============0765904883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0765904883==--
