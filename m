From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdgpu: extend profiling mode.
Date: Tue, 7 Feb 2017 09:48:50 +0000
Message-ID: <CY4PR12MB168710F77DE9F3F5E54A102CFB430@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1483944700-3842-1-git-send-email-Rex.Zhu@amd.com>
 <1483944700-3842-4-git-send-email-Rex.Zhu@amd.com>
 <5876B5C8.1010401@gmail.com> <58911B91.50008@gmail.com>
 <CADnq5_N27CHyxLZQMypKUsBGO3tfGcbW3+aO-vQM+=7NShghCQ@mail.gmail.com>
 <5892008F.8030008@gmail.com>
 <CY4PR12MB1687B1342B6DE8004D0B08E7FB400@CY4PR12MB1687.namprd12.prod.outlook.com>
 <58986CC3.40307@gmail.com>,
 <CY4PR12MB1687CA7CF3127858CA7C2120FB400@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_CY4PR12MB168710F77DE9F3F5E54A102CFB430CY4PR12MB1687namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1687CA7CF3127858CA7C2120FB400-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: Andy Furniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--_004_CY4PR12MB168710F77DE9F3F5E54A102CFB430CY4PR12MB1687namp_
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB168710F77DE9F3F5E54A102CFB430CY4PR12MB1687namp_"

--_000_CY4PR12MB168710F77DE9F3F5E54A102CFB430CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Not set max fan speed in high performance level because of the fan noise.

Best Regards
Rex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zhu, Rex=
 <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, February 6, 2017 10:09 PM
To: Andy Furniss; Alex Deucher
Cc: amd-gfx list
Subject: RE: [PATCH 4/4] drm/amdgpu: extend profiling mode.

Please see in line.

Best Regards
Rex

-----Original Message-----
From: Andy Furniss [mailto:adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
Sent: Monday, February 06, 2017 8:32 PM
To: Zhu, Rex; Alex Deucher
Cc: amd-gfx list
Subject: Re: [PATCH 4/4] drm/amdgpu: extend profiling mode.

Zhu, Rex wrote:
> Sorry for the late response.
>
> Yes, I set the fan speed to max in this patch when user set high performa=
nce.
>
> Considering that: 1. set fan speed to max is helpful to let GPU run under=
 highest clock as long as possible.
>                   2. avoid GPU rapid temperature rise in some case.

>>OK, I guess you know if it's needed or not.
>>It is somewhat annoying noise wise, maybe one day there will be a way for=
 users to set fan back on auto?

Rex: sure, you can echo "2"> /sys/class/drm/card0/device/hwmon/hwmon3(maybe=
 not 3)/pwm1_enable

>>Accepting I don't know how the h/w works your point 2 would imply that wi=
th perf on auto doing something like running a benchmark that pegs all the =
clocks high should also

Rex: based on the thermal,  the fan speed.will be dynamically adjusted.

>>I don't think that would be popular WRT noise.

Rex: maybe I worried unnecessarily. I will change the code not to set fan s=
peed to max. thanks.



>
> Best Regards
> Rex
>
>
>
> -----Original Message-----
> From: Andy Furniss [mailto:adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: Wednesday, February 01, 2017 11:37 PM
> To: Alex Deucher
> Cc: Zhu, Rex; amd-gfx list
> Subject: Re: [PATCH 4/4] drm/amdgpu: extend profiling mode.
>
> Alex Deucher wrote:
>> On Tue, Jan 31, 2017 at 6:19 PM, Andy Furniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrot=
e:
>>> Andy Furniss wrote:
>>>>
>>>> Rex Zhu wrote:
>>>>>
>>>>> in profiling mode, powerplay will fix power state as stable as
>>>>> possible.and disable gfx cg and LBPW feature.
>>>>>
>>>>> profile_standard: as a prerequisite, ensure power and thermal
>>>>> sustainable, set clocks ratio as close to the highest clock ratio
>>>>> as possible.
>>>>> profile_min_sclk: fix mclk as profile_normal, set lowest sclk
>>>>> profile_min_mclk: fix sclk as profile_normal, set lowest mclk
>>>>> profile_peak: set highest sclk and mclk, power and thermal not
>>>>> sustainable
>>>>> profile_exit: exit profile mode. enable gfx cg/lbpw feature.
>>>>
>>>>
>>>> Testing R9 285 Tonga on drm-next-4.11-wip
>>>>
>>>> This commit has the effect that doing
>>>>
>>>> echo high >
>>>> /sys/class/drm/card0/device/power_dpm_force_performance_level
>>>>
>>>> instantly forces fan to (I guess) max, where normally it doesn't
>>>> need anything like as fast with the clocks high when doing nothing els=
e.
>>>
>>>
>>> Ping - just in case this got missed, still the same on current
>>> drm-next-4.11-wip
>>
>> Just a heads up, Rex was looking at this, but it's Chinese New Year this=
 week.
>
> OK, thanks & Happy new year.
>
>

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB168710F77DE9F3F5E54A102CFB430CY4PR12MB1687namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<br>
Not set max fan speed in high performance level because of the fan noise.<b=
r>
<br>
Best Regards<br>
Rex<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" colo=
r=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Zhu, Rex &lt;Rex.Zhu-urvtwAKJhsc@public.gmane.org=
m&gt;<br>
<b>Sent:</b> Monday, February 6, 2017 10:09 PM<br>
<b>To:</b> Andy Furniss; Alex Deucher<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> RE: [PATCH 4/4] drm/amdgpu: extend profiling mode.</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Please see in line.<br>
<br>
Best Regards<br>
Rex<br>
<br>
-----Original Message-----<br>
From: Andy Furniss [<a href=3D"mailto:adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mailto:adf.lists=
@gmail.com</a>]
<br>
Sent: Monday, February 06, 2017 8:32 PM<br>
To: Zhu, Rex; Alex Deucher<br>
Cc: amd-gfx list<br>
Subject: Re: [PATCH 4/4] drm/amdgpu: extend profiling mode.<br>
<br>
Zhu, Rex wrote:<br>
&gt; Sorry for the late response.<br>
&gt;<br>
&gt; Yes, I set the fan speed to max in this patch when user set high perfo=
rmance.<br>
&gt;<br>
&gt; Considering that: 1. set fan speed to max is helpful to let GPU run un=
der highest clock as long as possible.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. avoid GPU rapid temperature rise i=
n some case.<br>
<br>
&gt;&gt;OK, I guess you know if it's needed or not.<br>
&gt;&gt;It is somewhat annoying noise wise, maybe one day there will be a w=
ay for users to set fan back on auto?<br>
<br>
Rex: sure, you can echo &quot;2&quot;&gt; /sys/class/drm/card0/device/hwmon=
/hwmon3(maybe not 3)/pwm1_enable
<br>
<br>
&gt;&gt;Accepting I don't know how the h/w works your point 2 would imply t=
hat with perf on auto doing something like running a benchmark that pegs al=
l the clocks high should also
<br>
<br>
Rex: based on the thermal,&nbsp; the fan speed.will be dynamically adjusted=
.<br>
<br>
&gt;&gt;I don't think that would be popular WRT noise.<br>
<br>
Rex: maybe I worried unnecessarily. I will change the code not to set fan s=
peed to max. thanks.<br>
<br>
<br>
<br>
&gt;<br>
&gt; Best Regards<br>
&gt; Rex<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: Andy Furniss [<a href=3D"mailto:adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mailto:adf.=
lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]<br>
&gt; Sent: Wednesday, February 01, 2017 11:37 PM<br>
&gt; To: Alex Deucher<br>
&gt; Cc: Zhu, Rex; amd-gfx list<br>
&gt; Subject: Re: [PATCH 4/4] drm/amdgpu: extend profiling mode.<br>
&gt;<br>
&gt; Alex Deucher wrote:<br>
&gt;&gt; On Tue, Jan 31, 2017 at 6:19 PM, Andy Furniss &lt;adf.lists@gmail.=
com&gt; wrote:<br>
&gt;&gt;&gt; Andy Furniss wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Rex Zhu wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; in profiling mode, powerplay will fix power state as s=
table as <br>
&gt;&gt;&gt;&gt;&gt; possible.and disable gfx cg and LBPW feature.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; profile_standard: as a prerequisite, ensure power and =
thermal <br>
&gt;&gt;&gt;&gt;&gt; sustainable, set clocks ratio as close to the highest =
clock ratio <br>
&gt;&gt;&gt;&gt;&gt; as possible.<br>
&gt;&gt;&gt;&gt;&gt; profile_min_sclk: fix mclk as profile_normal, set lowe=
st sclk<br>
&gt;&gt;&gt;&gt;&gt; profile_min_mclk: fix sclk as profile_normal, set lowe=
st mclk<br>
&gt;&gt;&gt;&gt;&gt; profile_peak: set highest sclk and mclk, power and the=
rmal not <br>
&gt;&gt;&gt;&gt;&gt; sustainable<br>
&gt;&gt;&gt;&gt;&gt; profile_exit: exit profile mode. enable gfx cg/lbpw fe=
ature.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Testing R9 285 Tonga on drm-next-4.11-wip<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; This commit has the effect that doing<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; echo high &gt;<br>
&gt;&gt;&gt;&gt; /sys/class/drm/card0/device/power_dpm_force_performance_le=
vel<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; instantly forces fan to (I guess) max, where normally it d=
oesn't <br>
&gt;&gt;&gt;&gt; need anything like as fast with the clocks high when doing=
 nothing else.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Ping - just in case this got missed, still the same on current=
 <br>
&gt;&gt;&gt; drm-next-4.11-wip<br>
&gt;&gt;<br>
&gt;&gt; Just a heads up, Rex was looking at this, but it's Chinese New Yea=
r this week.<br>
&gt;<br>
&gt; OK, thanks &amp; Happy new year.<br>
&gt;<br>
&gt;<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB168710F77DE9F3F5E54A102CFB430CY4PR12MB1687namp_--

--_004_CY4PR12MB168710F77DE9F3F5E54A102CFB430CY4PR12MB1687namp_
Content-Type: text/x-patch;
	name="0001-drm-amd-powerplay-set-fan-speed-to-max-in-profile-pe.patch"
Content-Description: 0001-drm-amd-powerplay-set-fan-speed-to-max-in-profile-pe.patch
Content-Disposition: attachment;
	filename="0001-drm-amd-powerplay-set-fan-speed-to-max-in-profile-pe.patch";
	size=1553; creation-date="Tue, 07 Feb 2017 09:46:55 GMT";
	modification-date="Tue, 07 Feb 2017 09:46:55 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0ZTNmNDE1NWZhYzA2MGE0ZDg2ZDhiZmY2MWQ0NjEyNzhkZDdhYzAyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+CkRhdGU6IFR1ZSwg
NyBGZWIgMjAxNyAxNzozNDoxMSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvcG93ZXJw
bGF5OiBzZXQgZmFuIHNwZWVkIHRvIG1heCBpbiBwcm9maWxlIHBlYWsgbW9kZQogb25seS4KCkNo
YW5nZS1JZDogSWU5ZTc4OWU2YWFkMGYzMjg0MWUwZGQ0MjI5NjE5YmMxMDNmNzAyZjgKU2lnbmVk
LW9mZi1ieTogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYyB8IDUgKysrLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jCmluZGV4IGM3MmNlODUuLmIxZGU5ZTgg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdt
Z3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU3X2h3bWdy
LmMKQEAgLTI2MjQsNiArMjYyNCw3IEBAIHN0YXRpYyBpbnQgc211N19mb3JjZV9kcG1fbGV2ZWwo
c3RydWN0IHBwX2h3bWdyICpod21nciwKIAkJc211N19mb3JjZV9jbG9ja19sZXZlbChod21nciwg
UFBfU0NMSywgMTw8c2Nsa19tYXNrKTsKIAkJc211N19mb3JjZV9jbG9ja19sZXZlbChod21nciwg
UFBfTUNMSywgMTw8bWNsa19tYXNrKTsKIAkJc211N19mb3JjZV9jbG9ja19sZXZlbChod21nciwg
UFBfUENJRSwgMTw8cGNpZV9tYXNrKTsKKwogCQlicmVhazsKIAljYXNlIEFNRF9EUE1fRk9SQ0VE
X0xFVkVMX01BTlVBTDoKIAkJaHdtZ3ItPmRwbV9sZXZlbCA9IGxldmVsOwpAQCAtMjYzMyw5ICsy
NjM0LDkgQEAgc3RhdGljIGludCBzbXU3X2ZvcmNlX2RwbV9sZXZlbChzdHJ1Y3QgcHBfaHdtZ3Ig
Kmh3bWdyLAogCQlicmVhazsKIAl9CiAKLQlpZiAobGV2ZWwgJiAoQU1EX0RQTV9GT1JDRURfTEVW
RUxfUFJPRklMRV9QRUFLIHwgQU1EX0RQTV9GT1JDRURfTEVWRUxfSElHSCkpCisJaWYgKGxldmVs
ID09IEFNRF9EUE1fRk9SQ0VEX0xFVkVMX1BST0ZJTEVfUEVBSyAmJiBod21nci0+c2F2ZWRfZHBt
X2xldmVsICE9IEFNRF9EUE1fRk9SQ0VEX0xFVkVMX1BST0ZJTEVfUEVBSykKIAkJc211N19mYW5f
Y3RybF9zZXRfZmFuX3NwZWVkX3BlcmNlbnQoaHdtZ3IsIDEwMCk7Ci0JZWxzZQorCWVsc2UgaWYg
KGxldmVsICE9IEFNRF9EUE1fRk9SQ0VEX0xFVkVMX1BST0ZJTEVfUEVBSyAmJiBod21nci0+c2F2
ZWRfZHBtX2xldmVsID09IEFNRF9EUE1fRk9SQ0VEX0xFVkVMX1BST0ZJTEVfUEVBSykKIAkJc211
N19mYW5fY3RybF9yZXNldF9mYW5fc3BlZWRfdG9fZGVmYXVsdChod21ncik7CiAKIAlyZXR1cm4g
MDsKLS0gCjEuOS4xCgo=

--_004_CY4PR12MB168710F77DE9F3F5E54A102CFB430CY4PR12MB1687namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_CY4PR12MB168710F77DE9F3F5E54A102CFB430CY4PR12MB1687namp_--
