Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C07E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 03:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA04410E4C2;
	Fri, 10 Jan 2025 03:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K/7nD+DQ";
	dkim-atps=neutral
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9846B10E4C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 03:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736479154; h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To;
 bh=EQ69PJuOnoyHEfiBkeHnGqUeP3rBNqaBjILLveu1qS0=;
 b=K/7nD+DQT17vxWCQ8fIK5r+Iw1TZVmprzZ4S6Auw6PDNz1bHccTuE2wfUDyECfpGmt2C15cgdAWKd/LAzSM1AeSrtx400L6YesRg/2YIk8OGBaG7Wjcs11chdkeBFFbjJcvhl7XcVxKpIi++W1MJwctlXO9InbchiN7/pze57Ps=
Received: from smtpclient.apple(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNJL9C5_1736479152 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 10 Jan 2025 11:19:13 +0800
From: Gerry Liu <gerry@linux.alibaba.com>
Message-Id: <C869BCDD-27CD-4A46-8DD3-E364C15F9FF6@linux.alibaba.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_AEEF2DEB-E3EA-4677-8CAF-FB61689C6A05"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [RFC PATCH 03/13] drm/amdgpu: add a flag to track ras debugfs
 creation status
Date: Fri, 10 Jan 2025 11:19:11 +0800
In-Reply-To: <9c6f3c11-0782-47f3-ba7e-eb6d8ba66d31@amd.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, Jun.Ma2@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
To: Mario Limonciello <mario.limonciello@amd.com>
References: <cover.1736344725.git.gerry@linux.alibaba.com>
 <014a704e91787b123203d568256861000a7fe558.1736344725.git.gerry@linux.alibaba.com>
 <9c6f3c11-0782-47f3-ba7e-eb6d8ba66d31@amd.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--Apple-Mail=_AEEF2DEB-E3EA-4677-8CAF-FB61689C6A05
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2025=E5=B9=B41=E6=9C=889=E6=97=A5 01:19=EF=BC=8CMario Limonciello =
<mario.limonciello@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 1/8/2025 07:59, Jiang Liu wrote:
>> Add a flag to track ras debugfs creation status, to avoid possible
>> incorrect reference count management for ras block object  in =
function
>> amdgpu_ras_aca_is_supported().
>=20
> Rather than taking a marker position, why not just check for
> obj->fs_data.debugfs_name to be non NULL in amdgpu_ras_fs_fini()?
I plan to use marker as a common status track mechanism, so used marker =
here:)

>=20
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++++++--
>>  2 files changed, 8 insertions(+), 3 deletions(-)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h =
b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 32941f29507c..2ef7d3102be3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -378,7 +378,7 @@ enum amdgpu_marker {
>>  	AMDGPU_MARKER_IRQ6		=3D 6,
>>  	AMDGPU_MARKER_IRQ7		=3D 7,
>>  	AMDGPU_MARKER_IRQ_MAX		=3D 47,
>> -	AMDGPU_MARKER_DEBUGFS		=3D 63,
>> +	AMDGPU_MARKER_RAS_DEBUGFS	=3D 63,
>=20
> Any particular reason you jumped to 63 in this patch and then counted =
down in the next one?  IE why not throw it at 48 (and then 49 for next =
one)?
I=E2=80=99m not sure how much markers are needed for IRQ, so I split the =
space into two parts: one for irq and one for others.

>=20
>>  };
>>    #define AMDGPU_MARKER_INDEX_IRQ(idx)		=
(AMDGPU_MARKER_INDEX_IRQ0 + (idx))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> index 6d52e22691f7..efd72b07a185 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> @@ -1996,7 +1996,8 @@ static void amdgpu_ras_debugfs_create(struct =
amdgpu_device *adev,
>>  {
>>  	struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, =
&head->head);
>>  -	if (!obj || !dir)
>> +	if (!obj || !dir ||
>> +	    amdgpu_ras_test_marker(adev, &head->head, =
AMDGPU_MARKER_RAS_DEBUGFS))
>>  		return;
>>    	get_obj(obj);
>> @@ -2007,6 +2008,8 @@ static void amdgpu_ras_debugfs_create(struct =
amdgpu_device *adev,
>>    	debugfs_create_file(obj->fs_data.debugfs_name, S_IWUGO | =
S_IRUGO, dir,
>>  			    obj, &amdgpu_ras_debugfs_ops);
>> +
>> +	amdgpu_ras_set_marker(adev, &head->head, =
AMDGPU_MARKER_RAS_DEBUGFS);
>>  }
>>    static bool amdgpu_ras_aca_is_supported(struct amdgpu_device =
*adev)
>> @@ -2134,7 +2137,9 @@ static int amdgpu_ras_fs_fini(struct =
amdgpu_device *adev)
>>  	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
>>  		list_for_each_entry_safe(con_obj, tmp, &con->head, node) =
{
>>  			ip_obj =3D amdgpu_ras_find_obj(adev, =
&con_obj->head);
>> -			if (ip_obj)
>> +			if (ip_obj &&
>> +			    amdgpu_ras_test_and_clear_marker(adev, =
&ip_obj->head,
>> +			    				     =
AMDGPU_MARKER_RAS_DEBUGFS))
>>  				put_obj(ip_obj);
>>  		}
>>  	}


--Apple-Mail=_AEEF2DEB-E3EA-4677-8CAF-FB61689C6A05
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">2025=E5=B9=B41=E6=9C=889=E6=97=A5 01:19=EF=BC=8CMario =
Limonciello &lt;<a href=3D"mailto:mario.limonciello@amd.com" =
class=3D"">mario.limonciello@amd.com</a>&gt; =E5=86=99=E9=81=93=EF=BC=9A</=
div><br class=3D"Apple-interchange-newline"><div class=3D""><meta =
charset=3D"UTF-8" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">On 1/8/2025 07:59, Jiang Liu wrote:</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 18px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">Add a =
flag to track ras debugfs creation status, to avoid possible<br =
class=3D"">incorrect reference count management for ras block object =
&nbsp;in function<br class=3D"">amdgpu_ras_aca_is_supported().<br =
class=3D""></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">Rather than taking a marker position, why not just check =
for</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" =
class=3D"">obj-&gt;fs_data.debugfs_name to be non NULL in =
amdgpu_ras_fs_fini()?</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""></div></blockquote><div>I plan to use =
marker as a common status track mechanism, so used marker =
here:)</div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D"">Signed-off-by: Jiang Liu &lt;<a =
href=3D"mailto:gerry@linux.alibaba.com" =
class=3D"">gerry@linux.alibaba.com</a>&gt;<br class=3D"">---<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h =
&nbsp;&nbsp;&nbsp;&nbsp;| 2 +-<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 =
+++++++--<br class=3D"">&nbsp;2 files changed, 8 insertions(+), 3 =
deletions(-)<br class=3D"">diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu.h =
b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br class=3D"">index =
32941f29507c..2ef7d3102be3 100644<br class=3D"">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br class=3D"">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br class=3D"">@@ -378,7 +378,7 @@ =
enum amdgpu_marker {<br class=3D"">&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>AMDGPU_MARKER_IRQ6<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>=3D 6,<br =
class=3D"">&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>AMDGPU_MARKER_IRQ7<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>=3D 7,<br class=3D"">&nbsp;<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>AMDGPU_MARKER_IRQ_MAX<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>=3D 47,<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>AMDGPU_MARKER_DEBUGFS<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>=3D 63,<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>AMDGPU_MARKER_RAS_DEBUGFS<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>=3D 63,<br =
class=3D""></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">Any particular reason you jumped to 63 in this patch and then =
counted down in the next one? &nbsp;IE why not throw it at 48 (and then =
49 for next one)?</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""></div></blockquote><div>I=E2=80=99m =
not sure how much markers are needed for IRQ, so I split the space into =
two parts: one for irq and one for others.</div><br class=3D""><blockquote=
 type=3D"cite" class=3D""><div class=3D""><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D"">&nbsp;};<br =
class=3D"">&nbsp;&nbsp;&nbsp;#define AMDGPU_MARKER_INDEX_IRQ(idx)<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>(AMDGPU_MARKER_INDEX_IRQ0 + (idx))<br class=3D"">diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br class=3D"">index =
6d52e22691f7..efd72b07a185 100644<br class=3D"">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br class=3D"">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br class=3D"">@@ -1996,7 =
+1996,8 @@ static void amdgpu_ras_debugfs_create(struct amdgpu_device =
*adev,<br class=3D"">&nbsp;{<br class=3D"">&nbsp;<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
ras_manager *obj =3D amdgpu_ras_find_obj(adev, &amp;head-&gt;head);<br =
class=3D"">&nbsp;-<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (!obj || !dir)<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (!obj =
|| !dir ||<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;amdgpu_ras_=
test_marker(adev, &amp;head-&gt;head, AMDGPU_MARKER_RAS_DEBUGFS))<br =
class=3D"">&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return;<br class=3D"">&nbsp;&nbsp;&nbsp;<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>get_obj(obj);<br class=3D"">@@ -2007,6 +2008,8 @@ static void =
amdgpu_ras_debugfs_create(struct amdgpu_device *adev,<br =
class=3D"">&nbsp;&nbsp;&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>debugfs_create_file(obj-&gt;fs_data.debugfs_name, S_IWUGO | =
S_IRUGO, dir,<br class=3D"">&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;obj, =
&amp;amdgpu_ras_debugfs_ops);<br class=3D"">+<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_ras_set_marker(adev, &amp;head-&gt;head, =
AMDGPU_MARKER_RAS_DEBUGFS);<br class=3D"">&nbsp;}<br =
class=3D"">&nbsp;&nbsp;&nbsp;static bool =
amdgpu_ras_aca_is_supported(struct amdgpu_device *adev)<br class=3D"">@@ =
-2134,7 +2137,9 @@ static int amdgpu_ras_fs_fini(struct amdgpu_device =
*adev)<br class=3D"">&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (IS_ENABLED(CONFIG_DEBUG_FS)) =
{<br class=3D"">&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>list_for_each_entry_safe(con_obj, tmp, &amp;con-&gt;head, =
node) {<br class=3D"">&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ip_obj =3D =
amdgpu_ras_find_obj(adev, &amp;con_obj-&gt;head);<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(ip_obj)<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (ip_obj &amp;&amp;<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;amdgpu_ras_=
test_and_clear_marker(adev, &amp;ip_obj-&gt;head,<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;AMDGP=
U_MARKER_RAS_DEBUGFS))<br class=3D"">&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>put_obj(ip_obj);<br =
class=3D"">&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>}<br class=3D"">&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>}</blockquote></div></blockquote></div><br =
class=3D""></body></html>=

--Apple-Mail=_AEEF2DEB-E3EA-4677-8CAF-FB61689C6A05--
