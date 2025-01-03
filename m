Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D51BE77199
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 10:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FAEA10E85E;
	Fri,  3 Jan 2025 10:12:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ae9IcC2Z";
	dkim-atps=neutral
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D483A10E0FA
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 02:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1735871714; h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To;
 bh=K34W0AdvWfpm7u7kS4CIExDOYhk4ariM6zlSSvL/lPw=;
 b=Ae9IcC2ZGilsISivkD48Abex/zvDe9gS7d7aVTgYY6tXdmLVOWXCT1YY2iFcxipETuv+ewd2jv2Tr16Gv6OvrmNKPx5dlB/MtlcjnBvHoqUV5pdiiE5qpZpZvQC/N8g+67CtsIS0IWJWTCavtaoseizKCnluRYlxz4ezC0+blGs=
Received: from smtpclient.apple(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WMrYB1g_1735871712 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 03 Jan 2025 10:35:13 +0800
From: Gerry Liu <gerry@linux.alibaba.com>
Message-Id: <A08D30FD-217C-4314-B21E-C21B70E84B6A@linux.alibaba.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_26E6DE6C-2144-43AC-A0E2-9A2D2CCAA0A8"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 5/6] amdgpu: fix invalid memory access in
 amdgpu_fence_driver_sw_fini()
Date: Fri, 3 Jan 2025 10:35:12 +0800
In-Reply-To: <0624a755-8e5e-42ca-a694-9be40bdfdcd6@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kent.russell@amd.com,
 shuox.liu@linux.alibaba.com
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>
References: <cover.1735795671.git.gerry@linux.alibaba.com>
 <4cffa8720810823b92f1a3bb484da499bc0410f8.1735795671.git.gerry@linux.alibaba.com>
 <0624a755-8e5e-42ca-a694-9be40bdfdcd6@amd.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Mailman-Approved-At: Fri, 03 Jan 2025 10:12:56 +0000
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


--Apple-Mail=_26E6DE6C-2144-43AC-A0E2-9A2D2CCAA0A8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2025=E5=B9=B41=E6=9C=883=E6=97=A5 07:09=EF=BC=8CChen, Xiaogang =
<xiaogang.chen@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
> On 1/1/2025 11:36 PM, Jiang Liu wrote:
>> Function detects initialization status by checking sched->ops, so set
>> sched->ops to non-NULL just before return in function =
drm_sched_init()
>> to avoid possible invalid memory access on error recover path.
>>=20
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>> ---
>>  drivers/gpu/drm/scheduler/sched_main.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>=20
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c =
b/drivers/gpu/drm/scheduler/sched_main.c
>> index 5adab4b3386c..ce2afdfc0158 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -1331,6 +1331,8 @@ int drm_sched_init(struct drm_gpu_scheduler =
*sched,
>>  	if (sched->own_submit_wq)
>>  		destroy_workqueue(sched->submit_wq);
>>  	drm_err(sched, "%s: Failed to setup GPU scheduler--out of =
memory\n", __func__);
>> +	// amdgpu_fence_driver_sw_fini() checks sched->ops for status.
>> +	sched->ops =3D NULL;
>=20
> Instead change drm/scheduler how about change amdgpu driver? At =
amdgpu_device_init_schedulers if drm_sched_init fail for a ring =
scheduler set
>=20
> ring->sched->op =3D NULL;
>=20
> It is not drm issue. If drm's scheduler init fail its operation has no =
meaning, we can set it to null at amdgpu driver.
Good suggestion, I will fix it in this way.

>=20
> Regards
>=20
> Xiaogang
>=20
>>  	return -ENOMEM;
>>  }
>>  EXPORT_SYMBOL(drm_sched_init);
>> @@ -1375,6 +1377,7 @@ void drm_sched_fini(struct drm_gpu_scheduler =
*sched)
>>  	sched->ready =3D false;
>>  	kfree(sched->sched_rq);
>>  	sched->sched_rq =3D NULL;
>> +	sched->ops =3D NULL;
>>  }
>>  EXPORT_SYMBOL(drm_sched_fini);


--Apple-Mail=_26E6DE6C-2144-43AC-A0E2-9A2D2CCAA0A8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">2025=E5=B9=B41=E6=9C=883=E6=97=A5 07:09=EF=BC=8CChen, =
Xiaogang &lt;<a href=3D"mailto:xiaogang.chen@amd.com" =
class=3D"">xiaogang.chen@amd.com</a>&gt; =E5=86=99=E9=81=93=EF=BC=9A</div>=
<br class=3D"Apple-interchange-newline"><div class=3D""><meta =
charset=3D"UTF-8" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); =
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
class=3D"">On 1/1/2025 11:36 PM, Jiang Liu wrote:</span><br =
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
-webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D"">Function detects initialization status by checking =
sched-&gt;ops, so set<br class=3D"">sched-&gt;ops to non-NULL just =
before return in function drm_sched_init()<br class=3D"">to avoid =
possible invalid memory access on error recover path.<br class=3D""><br =
class=3D"">Signed-off-by: Jiang Liu &lt;<a =
href=3D"mailto:gerry@linux.alibaba.com" =
class=3D"">gerry@linux.alibaba.com</a>&gt;<br class=3D"">---<br =
class=3D"">&nbsp;drivers/gpu/drm/scheduler/sched_main.c | 3 +++<br =
class=3D"">&nbsp;1 file changed, 3 insertions(+)<br class=3D""><br =
class=3D"">diff --git a/drivers/gpu/drm/scheduler/sched_main.c =
b/drivers/gpu/drm/scheduler/sched_main.c<br class=3D"">index =
5adab4b3386c..ce2afdfc0158 100644<br class=3D"">--- =
a/drivers/gpu/drm/scheduler/sched_main.c<br class=3D"">+++ =
b/drivers/gpu/drm/scheduler/sched_main.c<br class=3D"">@@ -1331,6 =
+1331,8 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,<br =
class=3D"">&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (sched-&gt;own_submit_wq)<br class=3D"">&nbsp;<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>destroy_workqueue(sched-&gt;submit_wq);<br class=3D"">&nbsp;<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>drm_err(sched, "%s: Failed to setup GPU scheduler--out of =
memory\n", __func__);<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>// amdgpu_fence_driver_sw_fini() =
checks sched-&gt;ops for status.<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>sched-&gt;ops =3D NULL;<br class=3D""></blockquote><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">Instead change drm/scheduler how =
about change amdgpu driver? At amdgpu_device_init_schedulers if =
drm_sched_init fail for a ring scheduler set</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">ring-&gt;sched-&gt;op =3D =
NULL;</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">It is not drm =
issue. If drm's scheduler init fail its operation has no meaning, we can =
set it to null at amdgpu driver.</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""></div></blockquote><div>Good =
suggestion, I will fix it in this way.</div><br class=3D""><blockquote =
type=3D"cite" class=3D""><div class=3D""><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">Regards</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">Xiaogang</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D"">&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return -ENOMEM;<br =
class=3D"">&nbsp;}<br class=3D"">&nbsp;EXPORT_SYMBOL(drm_sched_init);<br =
class=3D"">@@ -1375,6 +1377,7 @@ void drm_sched_fini(struct =
drm_gpu_scheduler *sched)<br class=3D"">&nbsp;<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>sched-&gt;ready =3D false;<br class=3D"">&nbsp;<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>kfree(sched-&gt;sched_rq);<br class=3D"">&nbsp;<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>sched-&gt;sched_rq =3D NULL;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>sched-&gt;ops =3D NULL;<br class=3D"">&nbsp;}<br =
class=3D"">&nbsp;EXPORT_SYMBOL(drm_sched_fini);</blockquote></div></blockq=
uote></div><br class=3D""></body></html>=

--Apple-Mail=_26E6DE6C-2144-43AC-A0E2-9A2D2CCAA0A8--
