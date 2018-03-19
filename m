From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Mon, 19 Mar 2018 15:39:07 -0400
Message-ID: <CAAxE2A5kq2oZtJRm2df1fjtb_p1m2_nvCmzv9y8mbO-GS8cGrw@mail.gmail.com>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
 <3f0a85f6-ac67-cd8c-716e-1c1655d40226@gmail.com>
 <c23ddc4b-c785-be3b-8321-416bb8417b6d@amd.com>
 <CADnq5_OAnM2p2NHnOAduCd+yomFXKqKhrag+JaayZD1Ri9z_2Q@mail.gmail.com>
 <BY1PR12MB05044ACBE8424866B3CCA243F5D90@BY1PR12MB0504.namprd12.prod.outlook.com>
 <898d3377-ee2b-a33d-dbff-b4cb692d650d@amd.com>
 <BY1PR12MB050407EA9472CB2B6E101CE7F5D90@BY1PR12MB0504.namprd12.prod.outlook.com>
 <e416ff00-018b-f206-123e-90b09b4ccd9f@gmail.com>
 <ebe01500-9fa5-e541-86c3-30ff0168e792@daenzer.net>
 <cd4659cb-f030-4938-af44-2fa1389ccdfb@gmail.com>
 <6febc0d1-0171-3cc1-ff22-69aa4ef36036@daenzer.net>
 <12178e4c-6b48-2c3b-9970-2ca30624a5bb@gmail.com>
 <29dba5ab-f4f3-551b-ec94-2d6433e8aa21@daenzer.net>
 <1141c511-597e-c81b-6ffd-800ff846f2c1@gmail.com>
 <1b643a78-d86a-b3bf-5f92-089a43201dd5@daenzer.net>
 <06e9160c-b4d4-6c3a-ff9f-04b40b94c7a0@amd.com>
 <BY1PR12MB0504A300C476CC31C59BFE97F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <2c995c37-0d0b-8fde-0118-57d7a62630ef@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0976878024=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2c995c37-0d0b-8fde-0118-57d7a62630ef-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>

--===============0976878024==
Content-Type: multipart/alternative; boundary="001a113f139ceacf630567c91e85"

--001a113f139ceacf630567c91e85
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 19, 2018 at 3:27 PM, Christian K=C3=B6nig <christian.koenig@amd=
.com>
wrote:

> I think that the consensus with Alex and me is that we should avoid
> exactly that.
>
> Overriding the preferred domain in the kernel is a no-go for that patch
> set, so please implement the discussed changes in Mesa.
>

I don't see how Mesa can make a smarter decision than the kernel. If you
overwrite the preferred domain of the buffer in the kernel, there will be
no ping-ponging between domains. Mesa never changes the initial preferred
domain.

Marek



>
> Regards,
> Christian.
>
>
> Am 19.03.2018 um 20:22 schrieb Li, Samuel:
>
>> I agree with Marek/Michel: since kernel sets the domain before scanning
>> out, it shall update the preferred domain here too.
>>
>> Regards,
>> Samuel Li
>>
>>
>> -----Original Message-----
>>> From: Koenig, Christian
>>> Sent: Thursday, March 08, 2018 4:07 AM
>>> To: Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>; Li, Samuel
>>> <Samuel.Li-5C7GfCeVMHo@public.gmane.org>; Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>> Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display
>>> support
>>>
>>> Am 08.03.2018 um 09:35 schrieb Michel D=C3=A4nzer:
>>>
>>>> On 2018-03-07 10:47 AM, Christian K=C3=B6nig wrote:
>>>>
>>>>> Am 07.03.2018 um 09:42 schrieb Michel D=C3=A4nzer:
>>>>>
>>>>>> On 2018-03-06 07:23 PM, Christian K=C3=B6nig wrote:
>>>>>>
>>>>>> E.g. the last time I tested it placing things into GTT still
>>>>>>> resulted in quite a performance penalty for rendering.
>>>>>>>
>>>>>> FWIW, I think the penalty is most likely IOMMU related. Last time I
>>>>>> tested, I couldn't measure a big difference with IOMMU disabled.
>>>>>>
>>>>> No, the penalty I'm talking about came from the ping/pong we did with
>>>>> the scanout buffers.
>>>>>
>>>>> See when I tested this the DDX and Mesa where unmodified, so both
>>>>> still assumed VRAM as placement for scanout BOs, but the kernel
>>>>> forced scanout BOs into GTT for testing.
>>>>>
>>>>> So what happened was that on scanout we moved the VRAM BO to GTT
>>>>>
>>>> and
>>>
>>>> after unpinning it on the first command submission which used the BO
>>>>> we moved it back to VRAM again.
>>>>>
>>>> In the meantime, I've had the same idea as Marek: Can't the kernel
>>>> driver simply change the BO's preferred domain to GTT when scanning
>>>> out from it? Then it won't move back to VRAM.
>>>>
>>> Yes, I've considered this as well.
>>>
>>> But I think making the decision in Mesa is the cleaner approach.
>>>
>>> E.g. so far we only override the placement decision of userspace for tw=
o
>>> reasons:
>>> 1. We where running out of memory in VRAM.
>>> 2. We have a hardware restriction which makes VRAM usage mandatory.
>>>
>>> And even then we never adjust the placement permanently, we just
>>> temporary moved the buffer where it was needed and moved it back after
>>> the operation completed.
>>>
>>> Additional to that Mesa might want to set even more flags and/or change=
s
>>> it's behavior. E.g. use a tilling mode which both importer and export i=
n
>>> an
>>> A+A laptop understands etc...
>>>
>>> Regards,
>>> Christian.
>>>
>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--001a113f139ceacf630567c91e85
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On M=
on, Mar 19, 2018 at 3:27 PM, Christian K=C3=B6nig <span dir=3D"ltr">&lt;<a =
href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">christian.koenig=
@amd.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I think =
that the consensus with Alex and me is that we should avoid exactly that.<b=
r>
<br>
Overriding the preferred domain in the kernel is a no-go for that patch set=
, so please implement the discussed changes in Mesa.<br></blockquote><div><=
br></div><div>I don&#39;t see how Mesa can make a smarter decision than the=
 kernel. If you overwrite the preferred domain of the buffer in the kernel,=
 there will be no ping-ponging between domains. Mesa never changes the init=
ial preferred domain.</div><div><br></div><div></div><div>Marek<br></div><d=
iv><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Regards,<br>
Christian.<div class=3D"m_-5064514954187404218HOEnZb"><div class=3D"m_-5064=
514954187404218h5"><br>
<br>
Am 19.03.2018 um 20:22 schrieb Li, Samuel:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I agree with Marek/Michel: since kernel sets the domain before scanning out=
, it shall update the preferred domain here too.<br>
<br>
Regards,<br>
Samuel Li<br>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
-----Original Message-----<br>
From: Koenig, Christian<br>
Sent: Thursday, March 08, 2018 4:07 AM<br>
To: Michel D=C3=A4nzer &lt;<a href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=3D"=
_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;; Li, Samuel<br>
&lt;<a href=3D"mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Samuel.Li-urvtwAKJhsc@public.gmane.org=
m</a>&gt;; Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=
=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
Cc: amd-gfx list &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" targe=
t=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><wbr>&gt;<br>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support<=
br>
<br>
Am 08.03.2018 um 09:35 schrieb Michel D=C3=A4nzer:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 2018-03-07 10:47 AM, Christian K=C3=B6nig wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Am 07.03.2018 um 09:42 schrieb Michel D=C3=A4nzer:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 2018-03-06 07:23 PM, Christian K=C3=B6nig wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
E.g. the last time I tested it placing things into GTT still<br>
resulted in quite a performance penalty for rendering.<br>
</blockquote>
FWIW, I think the penalty is most likely IOMMU related. Last time I<br>
tested, I couldn&#39;t measure a big difference with IOMMU disabled.<br>
</blockquote>
No, the penalty I&#39;m talking about came from the ping/pong we did with<b=
r>
the scanout buffers.<br>
<br>
See when I tested this the DDX and Mesa where unmodified, so both<br>
still assumed VRAM as placement for scanout BOs, but the kernel<br>
forced scanout BOs into GTT for testing.<br>
<br>
So what happened was that on scanout we moved the VRAM BO to GTT<br>
</blockquote></blockquote>
and<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
after unpinning it on the first command submission which used the BO<br>
we moved it back to VRAM again.<br>
</blockquote>
In the meantime, I&#39;ve had the same idea as Marek: Can&#39;t the kernel<=
br>
driver simply change the BO&#39;s preferred domain to GTT when scanning<br>
out from it? Then it won&#39;t move back to VRAM.<br>
</blockquote>
Yes, I&#39;ve considered this as well.<br>
<br>
But I think making the decision in Mesa is the cleaner approach.<br>
<br>
E.g. so far we only override the placement decision of userspace for two<br=
>
reasons:<br>
1. We where running out of memory in VRAM.<br>
2. We have a hardware restriction which makes VRAM usage mandatory.<br>
<br>
And even then we never adjust the placement permanently, we just<br>
temporary moved the buffer where it was needed and moved it back after<br>
the operation completed.<br>
<br>
Additional to that Mesa might want to set even more flags and/or changes<br=
>
it&#39;s behavior. E.g. use a tilling mode which both importer and export i=
n an<br>
A+A laptop understands etc...<br>
<br>
Regards,<br>
Christian.<br>
</blockquote></blockquote>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</div></div></blockquote></div><br></div></div>

--001a113f139ceacf630567c91e85--

--===============0976878024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0976878024==--
