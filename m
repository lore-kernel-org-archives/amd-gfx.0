From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/psp: Fix can't detect psp INVOKE command
 failed
Date: Thu, 3 Jan 2019 16:01:00 +0000
Message-ID: <DM5PR12MB1820100136529619A61F85A4F78D0@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <1544686892-32619-1-git-send-email-Xiangliang.Yu@amd.com>
 <BYAPR12MB3048316A14F811CAE4675B30FEBD0@BYAPR12MB3048.namprd12.prod.outlook.com>
 <71d6a5f3-51dd-9e02-a99f-a4acb3c2ce35@gmail.com>
 <MN2PR12MB30388EC1BF1282140F3AC7BAEB8D0@MN2PR12MB3038.namprd12.prod.outlook.com>,
 <28b7eafd-3473-1480-e1b4-cfbd995f5fe3@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2080719760=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <28b7eafd-3473-1480-e1b4-cfbd995f5fe3-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>, "Xu, Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2080719760==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1820100136529619A61F85A4F78D0DM5PR12MB1820namp_"

--_000_DM5PR12MB1820100136529619A61F85A4F78D0DM5PR12MB1820namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This bug may also be related:

https://bugs.freedesktop.org/show_bug.cgi?id=3D109206


Alex

________________________________
From: Koenig, Christian
Sent: Thursday, January 3, 2019 10:57:50 AM
To: Yu, Xiangliang; Xu, Feifei; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Ale=
xander
Subject: Re: [PATCH 2/2] drm/amdgpu/psp: Fix can't detect psp INVOKE comman=
d failed

> For Vega10, could you explain why it block older version fw?
I'm not very familiar with the PSP, so I don't know what exactly is
going wrong here.

Symptoms are that we get the following in dmesg:
> Jan 03 15:55:17 abel kernel: [drm] PSP loading VCE firmware
> Jan 03 15:55:17 abel kernel: [drm] reserve 0x400000 from 0xf400c00000
> for PSP TMR SIZE
> Jan 03 15:55:17 abel kernel: [drm:psp_cmd_submit_buf [amdgpu]] *ERROR*
> psp command failed and response status is (1)
> Jan 03 15:55:17 abel kernel: [drm:psp_hw_init [amdgpu]] *ERROR* PSP
> firmware loading failed
> Jan 03 15:55:17 abel kernel: [drm:amdgpu_device_fw_loading [amdgpu]]
> *ERROR* hw_init of IP block <psp> failed -22
> Jan 03 15:55:17 abel kernel: amdgpu 0000:43:00.0:
> amdgpu_device_ip_init failed
> Jan 03 15:55:17 abel kernel: amdgpu 0000:43:00.0: Fatal error during
> GPU init

I think the code was purposely ignoring some return status because the
command wasn't available on older fw generations.

Now that we bail out on every non zero return code that fails when you
try to use the older PSP firmware on Vega10.

Anyway breaking older fw versions is not something we can do, so we need
to either fix or revert that ASAP or end users will start to complain.

Any idea how to investigate further?

Christian.

Am 03.01.19 um 16:21 schrieb Yu, Xiangliang:
> XGMI command will not load ucode, so it can't find the command failed if =
check ucode at first.
> For code logic, should check response status to see if command complete s=
uccessfully at first.
> For Vega10, could you explain why it block older version fw?
>
>
> -----Original Message-----
> From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Sent: Thursday, January 03, 2019 11:00 PM
> To: Xu, Feifei <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>; Yu, Xiangliang <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org=
>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander <Alexander.Deucher@amd=
.com>
> Subject: Re: [PATCH 2/2] drm/amdgpu/psp: Fix can't detect psp INVOKE comm=
and failed
>
> Hi guys,
>
> this patch broke loading older versions of PSP firmware on Vega10.
>
> What exactly is the background here? E.g. why do we need it? And can we r=
evert it ASAP?
>
> Thanks,
> Christian.
>
> Am 18.12.18 um 03:45 schrieb Xu, Feifei:
>> Reviewed-by: Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of
>> Xiangliang Yu
>> Sent: Thursday, December 13, 2018 3:42 PM
>> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> Cc: Yu, Xiangliang <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
>> Subject: [PATCH 2/2] drm/amdgpu/psp: Fix can't detect psp INVOKE
>> command failed
>>
>> There isn't ucode when executing INVOKE command, so current code can't c=
heck the failure of INVOKE command.
>>
>> Remove the ucode check.
>>
>> Signed-off-by: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 11 +++++++----
>>    1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index 2f126ea7..7f5ce37 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -140,10 +140,13 @@ psp_cmd_submit_buf(struct psp_context *psp,
>>       while (*((unsigned int *)psp->fence_buf) !=3D index)
>>               msleep(1);
>>
>> -    /* the status field must be 0 after FW is loaded */
>> -    if (ucode && psp->cmd_buf_mem->resp.status) {
>> -            DRM_ERROR("failed loading with status (%d) and ucode id (%d=
)\n",
>> -                      psp->cmd_buf_mem->resp.status, ucode->ucode_id);
>> +    /* the status field must be 0 after psp command completion */
>> +    if (psp->cmd_buf_mem->resp.status) {
>> +            if (ucode)
>> +                    DRM_ERROR("failed to load ucode id (%d) ",
>> +                              ucode->ucode_id);
>> +            DRM_ERROR("psp command failed and response status is (%d)\n=
",
>> +                      psp->cmd_buf_mem->resp.status);
>>               return -EINVAL;
>>       }
>>
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--_000_DM5PR12MB1820100136529619A61F85A4F78D0DM5PR12MB1820namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">This bug may also be related:</p>
<p style=3D"margin-top:0;margin-bottom:0"><a href=3D"https://bugs.freedeskt=
op.org/show_bug.cgi?id=3D109206" class=3D"OWAAutoLink" id=3D"LPlnk457827" p=
reviewremoved=3D"true">https://bugs.freedesktop.org/show_bug.cgi?id=3D10920=
6</a></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian<br>
<b>Sent:</b> Thursday, January 3, 2019 10:57:50 AM<br>
<b>To:</b> Yu, Xiangliang; Xu, Feifei; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deuch=
er, Alexander<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu/psp: Fix can't detect psp INVOKE=
 command failed</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">&gt; For Vega10, could you explain why it block ol=
der version fw?<br>
I'm not very familiar with the PSP, so I don't know what exactly is <br>
going wrong here.<br>
<br>
Symptoms are that we get the following in dmesg:<br>
&gt; Jan 03 15:55:17 abel kernel: [drm] PSP loading VCE firmware<br>
&gt; Jan 03 15:55:17 abel kernel: [drm] reserve 0x400000 from 0xf400c00000 =
<br>
&gt; for PSP TMR SIZE<br>
&gt; Jan 03 15:55:17 abel kernel: [drm:psp_cmd_submit_buf [amdgpu]] *ERROR*=
 <br>
&gt; psp command failed and response status is (1)<br>
&gt; Jan 03 15:55:17 abel kernel: [drm:psp_hw_init [amdgpu]] *ERROR* PSP <b=
r>
&gt; firmware loading failed<br>
&gt; Jan 03 15:55:17 abel kernel: [drm:amdgpu_device_fw_loading [amdgpu]] <=
br>
&gt; *ERROR* hw_init of IP block &lt;psp&gt; failed -22<br>
&gt; Jan 03 15:55:17 abel kernel: amdgpu 0000:43:00.0: <br>
&gt; amdgpu_device_ip_init failed<br>
&gt; Jan 03 15:55:17 abel kernel: amdgpu 0000:43:00.0: Fatal error during <=
br>
&gt; GPU init<br>
<br>
I think the code was purposely ignoring some return status because the <br>
command wasn't available on older fw generations.<br>
<br>
Now that we bail out on every non zero return code that fails when you <br>
try to use the older PSP firmware on Vega10.<br>
<br>
Anyway breaking older fw versions is not something we can do, so we need <b=
r>
to either fix or revert that ASAP or end users will start to complain.<br>
<br>
Any idea how to investigate further?<br>
<br>
Christian.<br>
<br>
Am 03.01.19 um 16:21 schrieb Yu, Xiangliang:<br>
&gt; XGMI command will not load ucode, so it can't find the command failed =
if check ucode at first.<br>
&gt; For code logic, should check response status to see if command complet=
e successfully at first.<br>
&gt; For Vega10, could you explain why it block older version fw?<br>
&gt;<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: Christian K=F6nig &lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
&gt; Sent: Thursday, January 03, 2019 11:00 PM<br>
&gt; To: Xu, Feifei &lt;Feifei.Xu-5C7GfCeVMHo@public.gmane.org&gt;; Yu, Xiangliang &lt;Xianglian=
g.Yu-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander &lt;Ale=
xander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: Re: [PATCH 2/2] drm/amdgpu/psp: Fix can't detect psp INVOKE c=
ommand failed<br>
&gt;<br>
&gt; Hi guys,<br>
&gt;<br>
&gt; this patch broke loading older versions of PSP firmware on Vega10.<br>
&gt;<br>
&gt; What exactly is the background here? E.g. why do we need it? And can w=
e revert it ASAP?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Christian.<br>
&gt;<br>
&gt; Am 18.12.18 um 03:45 schrieb Xu, Feifei:<br>
&gt;&gt; Reviewed-by: Feifei Xu &lt;Feifei.Xu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Beh=
alf Of<br>
&gt;&gt; Xiangliang Yu<br>
&gt;&gt; Sent: Thursday, December 13, 2018 3:42 PM<br>
&gt;&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt; Cc: Yu, Xiangliang &lt;Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt; Subject: [PATCH 2/2] drm/amdgpu/psp: Fix can't detect psp INVOKE<b=
r>
&gt;&gt; command failed<br>
&gt;&gt;<br>
&gt;&gt; There isn't ucode when executing INVOKE command, so current code c=
an't check the failure of INVOKE command.<br>
&gt;&gt;<br>
&gt;&gt; Remove the ucode check.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Xiangliang Yu &lt;Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 11 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;----<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; 1 file changed, 7 insertions(&#43;), 4 deletions=
(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt;&gt; index 2f126ea7..7f5ce37 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt;&gt; @@ -140,10 &#43;140,13 @@ psp_cmd_submit_buf(struct psp_context *p=
sp,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (*((unsigned int *)psp-&=
gt;fence_buf) !=3D index)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; msleep(1);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; /* the status field must be 0 after FW is load=
ed */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (ucode &amp;&amp; psp-&gt;cmd_buf_mem-&gt;r=
esp.status) {<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; DRM_ERROR(&quot;failed loading with status (%d) and ucode id (%d)\n&quot;=
,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;cmd_b=
uf_mem-&gt;resp.status, ucode-&gt;ucode_id);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; /* the status field must be 0 after psp co=
mmand completion */<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (psp-&gt;cmd_buf_mem-&gt;resp.status) {=
<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (ucode)<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;faile=
d to load ucode id (%d) &quot;,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ucode-&gt;ucode_id);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; DRM_ERROR(&quot;psp command failed and response status is (%d)\n&quot=
;,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;c=
md_buf_mem-&gt;resp.status);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&gt; --<br>
&gt;&gt; 2.7.4<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
>https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
>https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB1820100136529619A61F85A4F78D0DM5PR12MB1820namp_--

--===============2080719760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2080719760==--
