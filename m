Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A67CE77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 03:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 506E310ECCD;
	Thu,  9 Jan 2025 03:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x9pblx0h";
	dkim-atps=neutral
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C6810ECCD
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 03:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736393680; h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To;
 bh=4HGCxtevL4CCBILn8ALxrFTKp+5Vez8f1ONiVvikXA4=;
 b=x9pblx0hNJN2uujazBpvP7keCfnK76TnHbRWBOn1sMBKaqZ9qT5Cc4TSiIoMTk0AzvvZcPp2M5Rvqi7M6dI2jZFSubT5H03Wuv5oo5GZMIn4Fhbgfg0dJiGn08NuNhvWAAESM1GyG0IWof9zoAuENLv+Y84izMaatMqBzdaBSCQ=
Received: from smtpclient.apple(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNFvi5C_1736393677 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 09 Jan 2025 11:34:39 +0800
From: Gerry Liu <gerry@linux.alibaba.com>
Message-Id: <C6F771B0-966D-40CC-8D3D-DEB920CD3171@linux.alibaba.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_334FD5CD-22B5-44F4-8680-5711A7B145D9"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [v3 4/6] drm/amdgpu: enhance error handling in function
 amdgpu_pci_probe()
Date: Thu, 9 Jan 2025 11:34:37 +0800
In-Reply-To: <7a28a207-b732-4640-b0c4-c19916637b8f@amd.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, Jun.Ma2@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
To: Mario Limonciello <mario.limonciello@amd.com>
References: <cover.1736325561.git.gerry@linux.alibaba.com>
 <5ba140aee2b20fc7cf724293d96260bd10d3dbdc.1736325561.git.gerry@linux.alibaba.com>
 <7a28a207-b732-4640-b0c4-c19916637b8f@amd.com>
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


--Apple-Mail=_334FD5CD-22B5-44F4-8680-5711A7B145D9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2025=E5=B9=B41=E6=9C=889=E6=97=A5 00:08=EF=BC=8CMario Limonciello =
<mario.limonciello@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 1/8/2025 02:56, Jiang Liu wrote:
>> Enhance error handling in function amdgpu_pci_probe() to avoid
>> possible resource leakage.
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 41d1b06be600..f8deca2f2696 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2346,16 +2346,16 @@ static int amdgpu_pci_probe(struct pci_dev =
*pdev,
>>  		msleep(5000);
>>  		goto retry_init;
>>  	} else if (ret) {
>> -		goto err_pci;
>> +		goto unload_kms;
>=20
> This label change looks wrong to me.  If you fail to =
amdgpu_driver_load_kms(), why would you amdgpu_driver_unload_kms()?
>=20
> amdgpu_driver_load_kms() has cleanup handling already to call =
amdgpu_driver_unload_kms()
This goto is to handle failure of drm_dev_register() instead of failure =
of amdgpu_driver_load_kms().
Thanks,
Gerry

>=20
>>  	}
>>    	ret =3D amdgpu_xcp_dev_register(adev, ent);
>>  	if (ret)
>> -		goto err_pci;
>> +		goto unplug_drm;
>>    	ret =3D amdgpu_amdkfd_drm_client_create(adev);
>>  	if (ret)
>> -		goto err_pci;
>> +		goto deregister_xcp;
>>    	/*
>>  	 * 1. don't init fbdev on hw without DCE
>> @@ -2424,6 +2424,12 @@ static int amdgpu_pci_probe(struct pci_dev =
*pdev,
>>    	return 0;
>>  +deregister_xcp:
>> +	amdgpu_xcp_dev_deregister(adev);
>> +unplug_drm:
>> +	drm_dev_unplug(ddev);
>> +unload_kms:
>> +	amdgpu_driver_unload_kms(ddev);
>>  err_pci:
>>  	pci_disable_device(pdev);
>>  	return ret;


--Apple-Mail=_334FD5CD-22B5-44F4-8680-5711A7B145D9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">2025=E5=B9=B41=E6=9C=889=E6=97=A5 00:08=EF=BC=8CMario =
Limonciello &lt;<a href=3D"mailto:mario.limonciello@amd.com" =
class=3D"">mario.limonciello@amd.com</a>&gt; =E5=86=99=E9=81=93=EF=BC=9A</=
div><br class=3D"Apple-interchange-newline"><div class=3D""><meta =
charset=3D"UTF-8" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" =
class=3D"">On 1/8/2025 02:56, Jiang Liu wrote:</span><br =
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
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">Enhance=
 error handling in function amdgpu_pci_probe() to avoid<br =
class=3D"">possible resource leakage.<br class=3D"">Signed-off-by: Jiang =
Liu &lt;<a href=3D"mailto:gerry@linux.alibaba.com" =
class=3D"">gerry@linux.alibaba.com</a>&gt;<br class=3D"">---<br =
class=3D"">&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 =
+++++++++---<br class=3D"">&nbsp;1 file changed, 9 insertions(+), 3 =
deletions(-)<br class=3D"">diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br class=3D"">index =
41d1b06be600..f8deca2f2696 100644<br class=3D"">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br class=3D"">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br class=3D"">@@ -2346,16 =
+2346,16 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,<br =
class=3D"">&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>msleep(5000);<br class=3D"">&nbsp;<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>goto =
retry_init;<br class=3D"">&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>} else if (ret) {<br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>goto err_pci;<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>goto unload_kms;<br =
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
class=3D"">This label change looks wrong to me. &nbsp;If you fail to =
amdgpu_driver_load_kms(), why would you =
amdgpu_driver_unload_kms()?</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; =
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
class=3D"">amdgpu_driver_load_kms() has cleanup handling already to call =
amdgpu_driver_unload_kms()</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""></div></blockquote><div>This goto is =
to handle failure of drm_dev_register() instead of failure of =
amdgpu_driver_load_kms().</div><div>Thanks,</div><div>Gerry</div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><br =
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
class=3D"">&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>}<br class=3D"">&nbsp;&nbsp;&nbsp;<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
amdgpu_xcp_dev_register(adev, ent);<br class=3D"">&nbsp;<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(ret)<br class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>goto err_pci;<br class=3D"">+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>goto unplug_drm;<br =
class=3D"">&nbsp;&nbsp;&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ret =3D =
amdgpu_amdkfd_drm_client_create(adev);<br class=3D"">&nbsp;<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(ret)<br class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>goto err_pci;<br class=3D"">+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>goto deregister_xcp;<br =
class=3D"">&nbsp;&nbsp;&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>/*<br class=3D"">&nbsp;<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>* 1. don't init fbdev on hw =
without DCE<br class=3D"">@@ -2424,6 +2424,12 @@ static int =
amdgpu_pci_probe(struct pci_dev *pdev,<br =
class=3D"">&nbsp;&nbsp;&nbsp;<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return 0;<br =
class=3D"">&nbsp;+deregister_xcp:<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_xcp_dev_deregister(adev);<br class=3D"">+unplug_drm:<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>drm_dev_unplug(ddev);<br class=3D"">+unload_kms:<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_driver_unload_kms(ddev);<br class=3D"">&nbsp;err_pci:<br =
class=3D"">&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>pci_disable_device(pdev);<br class=3D"">&nbsp;<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
ret;</blockquote></div></blockquote></div><br class=3D""></body></html>=

--Apple-Mail=_334FD5CD-22B5-44F4-8680-5711A7B145D9--
