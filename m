From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: tidy'ing up cz_hwmgr.c
Date: Thu, 18 Aug 2016 14:26:37 +0000
Message-ID: <DM5PR12MB1132F1D9FF8F44E09BE37EF4F7150@DM5PR12MB1132.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0799995487=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0799995487==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1132F1D9FF8F44E09BE37EF4F7150DM5PR12MB1132namp_"

--_000_DM5PR12MB1132F1D9FF8F44E09BE37EF4F7150DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Tidying up cz_hwmgr.c I noted a couple of things but first is


static bool cz_dpm_check_smu_features(struct pp_hwmgr *hwmgr,
unsigned long check_feature);

Which will return "true" if the smu call fails or the feature is set.

The structure

struct phm_clock_voltage_dependency_table;

Has a [1] array at the tail which is then kzalloc'ed with N-1 entries.  Sho=
uldn't that just be a [0] with N entries allocated for clarity?

Tom


--_000_DM5PR12MB1132F1D9FF8F44E09BE37EF4F7150DM5PR12MB1132namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Tidying up cz_hwmgr.c I noted a couple of things but first is&nbsp;</p>
<p><br>
</p>
<p></p>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace;">stati=
c bool cz_dpm_check_smu_features(struct pp_hwmgr *hwmgr,</span></div>
<div><span class=3D"Apple-tab-span" style=3D"white-space: pre; font-family:=
 &quot;Courier New&quot;, monospace;"></span><span style=3D"font-family: &q=
uot;Courier New&quot;, monospace;">unsigned long check_feature);</span></di=
v>
<div><br>
</div>
<div>Which will return &quot;true&quot; if the smu call fails <b>or</b>&nbs=
p;the feature is set. &nbsp;</div>
<div><br>
</div>
<div>The structure&nbsp;</div>
<div><br>
</div>
<div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace;">struc=
t phm_clock_voltage_dependency_table;</span></div>
</div>
<div><br>
</div>
<div>Has a [1] array at the tail which is then kzalloc'ed with N-1 entries.=
 &nbsp;Shouldn't that just be a [0] with N entries allocated for clarity?</=
div>
<div><br>
</div>
<div>Tom</div>
<div><br>
</div>
<p></p>
</div>
</body>
</html>

--_000_DM5PR12MB1132F1D9FF8F44E09BE37EF4F7150DM5PR12MB1132namp_--

--===============0799995487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0799995487==--
