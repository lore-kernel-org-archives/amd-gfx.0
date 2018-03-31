From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: Clean register first to avoid read original
 value
Date: Sat, 31 Mar 2018 00:28:58 +0000
Message-ID: <CY4PR12MB16872AF3D8207BF4ACBC023FFBA00@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1522395206-5860-1-git-send-email-Rex.Zhu@amd.com>
 <c42b3004-8b75-60d2-0f2b-45e1e9a2f1f6@amd.com>,
 <9bac98b9-4add-6214-f461-bfd91d5636ad@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1362754067=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9bac98b9-4add-6214-f461-bfd91d5636ad-5C7GfCeVMHo@public.gmane.org>
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
To: "Huang, JinHuiEric" <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1362754067==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16872AF3D8207BF4ACBC023FFBA00CY4PR12MB1687namp_"

--_000_CY4PR12MB16872AF3D8207BF4ACBC023FFBA00CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

when PPSMC_MSG_PmStatusLogSample sent, firmware will clean the temp samplin=
g date, and add the sample task to dpm loop.

but firmware not  clean the registers.  if firmware not update the register=
s, we will read out the original value.


Best Regards

Rex



________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Eric Hua=
ng <jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, March 30, 2018 11:22 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amd/pp: Clean register first to avoid read origina=
l value


On 03/30/2018 10:36 AM, Eric Huang wrote:
> It is not necessary to do that. The register will reset to 0 after
> reading.
The register is not reset after reading. Actually after
PPSMC_MSG_PmStatusLogSample sent, the register will be updated. So it is
still not necessary to do that.

Eric
>
> Eric
>
>
> On 03/30/2018 03:33 AM, Rex Zhu wrote:
>> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> index aaa9f5b..38cf3a1 100644
>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> @@ -3368,6 +3368,19 @@ static int smu7_get_gpu_power(struct pp_hwmgr
>> *hwmgr,
>>               "Failed to start pm status log!",
>>               return -1);
>>   +    cgs_write_ind_register(hwmgr->device,
>> +            CGS_IND_REG__SMC,
>> +            ixSMU_PM_STATUS_40, 0);
>> +    cgs_write_ind_register(hwmgr->device,
>> +            CGS_IND_REG__SMC,
>> +            ixSMU_PM_STATUS_49, 0);
>> +    cgs_write_ind_register(hwmgr->device,
>> +            CGS_IND_REG__SMC,
>> +            ixSMU_PM_STATUS_94, 0);
>> +    cgs_write_ind_register(hwmgr->device,
>> +            CGS_IND_REG__SMC,
>> +            ixSMU_PM_STATUS_95, 0);
>> +
>>       /* Sampling period from 50ms to 4sec */
>>       msleep_interruptible(200);
>

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.




--_000_CY4PR12MB16872AF3D8207BF4ACBC023FFBA00CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0">when&nbsp;<span style=3D"font-fam=
ily: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quo=
t;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;=
, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">PPSMC_MSG=
_PmStatusLogSample
 sent, firmware will clean the temp sampling date, and add the sample task =
to dpm loop.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 14.6667=
px;">but firmware not &nbsp;clean the registers. &nbsp;if firmware not upda=
te the registers, we will read out the original value.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 14.6667=
px;"><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 14.6667=
px;">Best Regards</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 14.6667=
px;">Rex</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Eric Huang &lt;jinhuieric.hua=
ng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, March 30, 2018 11:22 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/pp: Clean register first to avoid read =
original value</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
On 03/30/2018 10:36 AM, Eric Huang wrote:<br>
&gt; It is not necessary to do that. The register will reset to 0 after <br=
>
&gt; reading.<br>
The register is not reset after reading. Actually after <br>
PPSMC_MSG_PmStatusLogSample sent, the register will be updated. So it is <b=
r>
still not necessary to do that.<br>
<br>
Eric<br>
&gt;<br>
&gt; Eric<br>
&gt;<br>
&gt;<br>
&gt; On 03/30/2018 03:33 AM, Rex Zhu wrote:<br>
&gt;&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 13 &#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&gt; &nbsp; 1 file changed, 13 insertions(&#43;)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt;&gt; index aaa9f5b..38cf3a1 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c=
<br>
&gt;&gt; @@ -3368,6 &#43;3368,19 @@ static int smu7_get_gpu_power(struct pp=
_hwmgr <br>
&gt;&gt; *hwmgr,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &quot;Failed to start pm status log!&quot;,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; return -1);<br>
&gt;&gt; &nbsp; &#43;&nbsp;&nbsp;&nbsp; cgs_write_ind_register(hwmgr-&gt;de=
vice,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; CGS_IND_REG__SMC,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ixSMU_PM_STATUS_40, 0);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; cgs_write_ind_register(hwmgr-&gt;device,<b=
r>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; CGS_IND_REG__SMC,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ixSMU_PM_STATUS_49, 0);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; cgs_write_ind_register(hwmgr-&gt;device,<b=
r>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; CGS_IND_REG__SMC,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ixSMU_PM_STATUS_94, 0);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; cgs_write_ind_register(hwmgr-&gt;device,<b=
r>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; CGS_IND_REG__SMC,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ixSMU_PM_STATUS_95, 0);<br>
&gt;&gt; &#43;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Sampling period from 50ms to 4se=
c */<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep_interruptible(200);<br>
&gt;<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk194206" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15224555838300.6305618541058784" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15224555838230.7487087610706571" role=3D"presentat=
ion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255,=
 255); position: relative; overflow: auto; padding-top: 20px; padding-botto=
m: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); borde=
r-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15224555838250.5092558814385109" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_15224555838250.8684840095335804"></div>
<div id=3D"LPTitle_15224555838260.8317841949999445" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_15224555838270.3536369120415084" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15224555838270.8339160024590055" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15224555838290.8158871495654998" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.</d=
iv>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB16872AF3D8207BF4ACBC023FFBA00CY4PR12MB1687namp_--

--===============1362754067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1362754067==--
