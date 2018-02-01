From: "Lipski, Mikita" <Mikita.Lipski-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Maintain suspend-resume call consistency in
 gpu recovery
Date: Thu, 1 Feb 2018 20:46:26 +0000
Message-ID: <BN6PR1201MB01008309528663504BB0A722E4FA0@BN6PR1201MB0100.namprd12.prod.outlook.com>
References: <1517514258-30312-1-git-send-email-mikita.lipski@amd.com>
 <CADnq5_P4qBT=jouUaNPA5C66iKoTHPhEt31vFBDtpO1WNz7S5A@mail.gmail.com>,
 <0b3fc698-954b-e5bc-d3e4-0f6ccfd2d777@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0138402277=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0b3fc698-954b-e5bc-d3e4-0f6ccfd2d777-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0138402277==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR1201MB01008309528663504BB0A722E4FA0BN6PR1201MB0100_"

--_000_BN6PR1201MB01008309528663504BB0A722E4FA0BN6PR1201MB0100_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


On 2018-02-01 03:02 PM, Alex Deucher wrote:
> On Thu, Feb 1, 2018 at 2:44 PM,  <mikita.lipski-5C7GfCeVMHo@public.gmane.org> wrote:
>> From: Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>
>>
>> Call dm_suspend function instead of drm_kms suspend function in
>> order to cache current state
>>
>> Call DM_resume first to restore dc hardware, then amdgpu_dm_display_resu=
me
>> to restore dal's cached state.
>
>> We already call the IP block suspend and resume functions in
> amdgpu_device_ip_suspend() which is called by amdgpu_device_reset(),
>> at least when we do a hard reset.  They will end up getting called

>I missed that. I think we just need to drop the existing DC and drm_atomic=
_helper_* calls in amdgpu_device_gpu_recover and call amdgpu_dm_display_res=
ume after amdgpu_device_ip_resume_phase2 in amdgpu_device_reset.

>I really don't like the way we call amdgpu_dm_display_resume separately fr=
om the .resume hook now. We initially implemented it because in amdgpu_devi=
ce_resume we need cursor pinning to happen before really resuming DC. Not s=
ure if we can move the cursor pinning to before amdgpu_device_ip_resume in =
that function. If we can we can just move amdgpu_dm_display_resume into the=
 proper .resume hook, and clean up both resume and gpu_recover code.

>> twice in that case with this change.  Perhaps a better solution would
>> be to only call the drm_atomic_helper_* functions when we have a hard
>> reset rather than a soft one.

>amdgpu_dm_display_resume will already call the drm_atomic_helper_ function=
s. We should really call them in gpu_recover, unless we need to re-apply th=
e state on a soft reset, but then we probably want to block this call from =
a hard reset.

>Harry

If cursor pinning doesn't need powering DC beforehand - we can introduce ph=
ase 3 ip resume, as you suggested earlier, and call it after pinning the cu=
rsor instead of phase2.

Nick

>>
>> Alex
>>
>>
>>
>> Signed-off-by: Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_device.c
>> index 850453e..b55c929 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2616,7 +2616,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu=
_device *adev,
>>  int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>                               struct amdgpu_job *job, bool force)
>>  {
>> -       struct drm_atomic_state *state =3D NULL;
>>         uint64_t reset_flags =3D 0;
>>         int i, r, resched;
>>
>> @@ -2640,9 +2639,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device=
 *adev,
>>         /* block TTM */
>>         resched =3D ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
>>         /* store modesetting */
>> -       if (amdgpu_device_has_dc_support(adev))
>> -               state =3D drm_atomic_helper_suspend(adev->ddev);
>> -
>> +       if (amdgpu_device_has_dc_support(adev)){
>> +               adev->ip_blocks[5].version->funcs->suspend(adev);
>> +       }
>>         /* block scheduler */
>>         for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>>                 struct amdgpu_ring *ring =3D adev->rings[i];
>> @@ -2727,8 +2726,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device=
 *adev,
>>         }
>>
>>         if (amdgpu_device_has_dc_support(adev)) {
>> -               if (drm_atomic_helper_resume(adev->ddev, state))
>> -                       dev_info(adev->dev, "drm resume failed:%d\n", r)=
;
>> +               adev->ip_blocks[5].version->funcs->resume(adev);
>>                 amdgpu_dm_display_resume(adev);
>>         } else {
>>                 drm_helper_resume_force_mode(adev->ddev);
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--_000_BN6PR1201MB01008309528663504BB0A722E4FA0BN6PR1201MB0100_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<font size=3D"2"><span style=3D"font-size:11pt;"></span></font>On 2018-02-0=
1 03:02 PM, Alex Deucher wrote:<br>
<div style=3D"color: rgb(0, 0, 0);">
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">&gt; On Thu, Feb 1, 2018 at 2:44 PM,&nbsp; &lt;mik=
ita.lipski-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt;&gt; From: Mikita Lipski &lt;mikita.lipski-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;<br>
&gt;&gt; Call dm_suspend function instead of drm_kms suspend function in<br=
>
&gt;&gt; order to cache current state<br>
&gt;&gt;<br>
&gt;&gt; Call DM_resume first to restore dc hardware, then amdgpu_dm_displa=
y_resume<br>
&gt;&gt; to restore dal's cached state.<br>
&gt; <br>
&gt;&gt; We already call the IP block suspend and resume functions in<br>
&gt; amdgpu_device_ip_suspend() which is called by amdgpu_device_reset(),<b=
r>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; at =
least when we do a hard reset.&nbsp; They will end up getting called<br>
<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>I missed=
 that. I think we just need to drop the existing DC and drm_atomic_helper_*=
 calls in amdgpu_device_gpu_recover and call amdgpu_dm_display_resume after=
 amdgpu_device_ip_resume_phase2 in amdgpu_device_reset.<br>
<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>I really=
 don't like the way we call amdgpu_dm_display_resume separately from the .r=
esume hook now. We initially implemented it because in amdgpu_device_resume=
 we need cursor pinning to happen before
 really resuming DC. Not sure if we can move the cursor pinning to before a=
mdgpu_device_ip_resume in that function. If we can we can just move amdgpu_=
dm_display_resume into the proper .resume hook, and clean up both resume an=
d gpu_recover code.<br>
<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; twi=
ce in that case with this change.&nbsp; Perhaps a better solution would<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; be =
to only call the drm_atomic_helper_* functions when we have a hard<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; res=
et rather than a soft one.<br>
<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>amdgpu_d=
m_display_resume will already call the drm_atomic_helper_ functions. We sho=
uld really call them in gpu_recover, unless we need to re-apply the state o=
n a soft reset, but then we probably want
 to block this call from a hard reset.<br>
<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>Harry<br=
>
<br>
If cursor pinning doesn't need powering DC beforehand - we can introduce ph=
ase 3 ip resume, as you suggested earlier, and call it after pinning the cu=
rsor instead of phase2.<br>
<br>
Nick<br>
<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; <br=
>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; Ale=
x<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; <br=
>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; <br=
>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Mikita Lipski &lt;mikita.lipski-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 &#43;&#43;&#=
43;&#43;------<br>
&gt;&gt;&nbsp; 1 file changed, 4 insertions(&#43;), 6 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; index 850453e..b55c929 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt;&gt; @@ -2616,7 &#43;2616,6 @@ static int amdgpu_device_reset_sriov(str=
uct amdgpu_device *adev,<br>
&gt;&gt;&nbsp; int amdgpu_device_gpu_recover(struct amdgpu_device *adev,<br=
>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job, bool force)<=
br>
&gt;&gt;&nbsp; {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_atomic_state *sta=
te =3D NULL;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t reset_fla=
gs =3D 0;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r, resched;=
<br>
&gt;&gt;<br>
&gt;&gt; @@ -2640,9 &#43;2639,9 @@ int amdgpu_device_gpu_recover(struct amd=
gpu_device *adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* block TTM */<br=
>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resched =3D ttm_bo=
_lock_delayed_workqueue(&amp;adev-&gt;mman.bdev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* store modesetti=
ng */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_has_dc_sup=
port(adev))<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; state =3D drm_atomic_helper_suspend(adev-&gt;ddev);<br>
&gt;&gt; -<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_has_dc=
_support(adev)){<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[5].version-&gt;funcs-&gt;suspend=
(adev);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* block scheduler=
 */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &l=
t; AMDGPU_MAX_RINGS; &#43;&#43;i) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D adev-&gt;rings[i=
];<br>
&gt;&gt; @@ -2727,8 &#43;2726,7 @@ int amdgpu_device_gpu_recover(struct amd=
gpu_device *adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_=
has_dc_support(adev)) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (drm_atomic_helper_resume(adev-&gt;ddev, state))<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_inf=
o(adev-&gt;dev, &quot;drm resume failed:%d\n&quot;, r);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[5].version-&gt;funcs-&gt;resume(=
adev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_display_resume(adev);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_helper_resume_force_mode(adev-&gt;ddev);<=
br>
&gt;&gt; --<br>
&gt;&gt; 2.7.4<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 id=3D"LPlnk308191" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"LPlnk248224" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt; <br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR1201MB01008309528663504BB0A722E4FA0BN6PR1201MB0100_--

--===============0138402277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0138402277==--
