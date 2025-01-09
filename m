Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7C3E77199
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 01:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FEC110E976;
	Thu,  9 Jan 2025 01:46:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vs2vvhJY";
	dkim-atps=neutral
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5566D10E220
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 01:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736387168; h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To;
 bh=RD5xONIfEUQtwCbtBNikiwp7wPlz8XU6JRGfvz4q2OU=;
 b=vs2vvhJY0ellx1gScX4PKjT+bjuonkipi8E+XvbbbpmWdfbAA1VU9RCqdX9TW7Dt4Zc0PCG/MzmUzPDnfZyIg6MlHJLPbh17S8arCnOgG/m5gqxg3QWckqb61d15cS4YsfcRWcg5zLLmGNCsbuzWxGYKWWQe862Pz4eh1zt+JuE=
Received: from smtpclient.apple(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNFVjmO_1736387165 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 09 Jan 2025 09:46:06 +0800
From: Gerry Liu <gerry@linux.alibaba.com>
Message-Id: <9AE6DCA7-1911-46D2-B486-9F332B88CFE2@linux.alibaba.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_0A65D644-082D-4836-A756-7CCCCB8F9756"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [v3 2/6] drm/amdxcp: introduce new API amdgpu_xcp_drm_dev_free()
Date: Thu, 9 Jan 2025 09:46:05 +0800
In-Reply-To: <720f5edc-db64-411f-9d22-b0c718b69f7e@amd.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 Hawking.Zhang@amd.com, mario.limonciello@amd.com, Jun.Ma2@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
To: "Lazar, Lijo" <lijo.lazar@amd.com>
References: <cover.1736325561.git.gerry@linux.alibaba.com>
 <c46d4c3bead7f62439eca5110de8afe4783a7418.1736325561.git.gerry@linux.alibaba.com>
 <720f5edc-db64-411f-9d22-b0c718b69f7e@amd.com>
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


--Apple-Mail=_0A65D644-082D-4836-A756-7CCCCB8F9756
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2025=E5=B9=B41=E6=9C=888=E6=97=A5 17:31=EF=BC=8CLazar, Lijo =
<lijo.lazar@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> On 1/8/2025 2:26 PM, Jiang Liu wrote:
>> Introduce new interface amdgpu_xcp_drm_dev_free() to free a specific
>> drm_device crreated by amdgpu_xcp_drm_dev_alloc(), which will be used
>> to do error recovery.
>>=20
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>> ---
>> drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 76 =
+++++++++++++++++----
>> drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
>> 2 files changed, 63 insertions(+), 14 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c =
b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
>> index faed84172dd4..fc92b5fe1040 100644
>> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
>> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
>> @@ -45,21 +45,32 @@ static const struct drm_driver amdgpu_xcp_driver =
=3D {
>>=20
>> static int8_t pdev_num;
>> static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
>> +static DEFINE_MUTEX(xcp_mutex);
>>=20
>> int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>> {
>> 	struct platform_device *pdev;
>> 	struct xcp_device *pxcp_dev;
>> 	char dev_name[20];
>> -	int ret;
>> +	int ret, index;
>>=20
>> -	if (pdev_num >=3D MAX_XCP_PLATFORM_DEVICE)
>> -		return -ENODEV;
>> +	mutex_lock(&xcp_mutex);
>> +	if (pdev_num >=3D MAX_XCP_PLATFORM_DEVICE) {
>> +		ret =3D -ENODEV;
>> +		goto out_unlock;
>> +	}
>> +
>> +	for (index =3D 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
>> +		if (!xcp_dev[index])
>> +			break;
>> +	}
>>=20
>> -	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
>> +	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", index);
>> 	pdev =3D platform_device_register_simple(dev_name, -1, NULL, 0);
>> -	if (IS_ERR(pdev))
>> -		return PTR_ERR(pdev);
>> +	if (IS_ERR(pdev)) {
>> +		ret =3D PTR_ERR(pdev);
>> +		goto out_unregister;
>> +	}
>>=20
>> 	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
>> 		ret =3D -ENOMEM;
>> @@ -72,10 +83,11 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device =
**ddev)
>> 		goto out_devres;
>> 	}
>>=20
>> -	xcp_dev[pdev_num] =3D pxcp_dev;
>> -	xcp_dev[pdev_num]->pdev =3D pdev;
>> +	xcp_dev[index] =3D pxcp_dev;
>> +	xcp_dev[index]->pdev =3D pdev;
>> 	*ddev =3D &pxcp_dev->drm;
>> 	pdev_num++;
>> +	mutex_unlock(&xcp_mutex);
>>=20
>> 	return 0;
>>=20
>> @@ -83,21 +95,57 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device =
**ddev)
>> 	devres_release_group(&pdev->dev, NULL);
>> out_unregister:
>> 	platform_device_unregister(pdev);
>> +out_unlock:
>> +	mutex_unlock(&xcp_mutex);
>>=20
>> 	return ret;
>> }
>> EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
>>=20
>> +static void amdgpu_xcp_drm_dev_destroy(int index)
>=20
> <Nit> Use something like __amdgpu_xcp_drm_dev_free(int index) to keep
> the 'free' suffix.
>=20
>> +{
>> +	struct platform_device *pdev;
>> +
>> +	pdev =3D xcp_dev[index]->pdev;
>> +	devres_release_group(&pdev->dev, NULL);
>> +	platform_device_unregister(pdev);
>> +	xcp_dev[index] =3D NULL;
>> +	pdev_num--;
>> +}
>> +
>> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev)
>> +{
>> +	int index;
>> +	struct xcp_device *pxcp_dev;
>> +
>> +	if (ddev =3D=3D NULL)
>=20
> Does it make sense to add !pdev_num check or a WARN_ON(!pdev_num) =
below?
>=20
>> +		return;
>> +
>> +	pxcp_dev =3D container_of(ddev, struct xcp_device, drm);
>> +
>> +	mutex_lock(&xcp_mutex);
>> +	for (index =3D 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
>> +		if (xcp_dev[index] =3D=3D pxcp_dev) {
>> +			amdgpu_xcp_drm_dev_destroy(index);
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&xcp_mutex);
>> +}
>> +EXPORT_SYMBOL(amdgpu_xcp_drm_dev_free);
>> +
>> void amdgpu_xcp_drv_release(void)
>> {
>> -	for (--pdev_num; pdev_num >=3D 0; --pdev_num) {
>> -		struct platform_device *pdev =3D =
xcp_dev[pdev_num]->pdev;
>> +	int index;
>>=20
>> -		devres_release_group(&pdev->dev, NULL);
>> -		platform_device_unregister(pdev);
>> -		xcp_dev[pdev_num] =3D NULL;
>=20
> To better optimize, add one check like below.
> 	if (!pdev_num)
> 		return;
Thanks for review and suggestions, all comments will be addressed in =
next version.

>=20
> Thanks,
> Lijo
>=20
>> +	mutex_lock(&xcp_mutex);
>> +	for (index =3D 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
>> +		if (xcp_dev[index]) {
>> +			amdgpu_xcp_drm_dev_destroy(index);
>> +		}
>> 	}
>> -	pdev_num =3D 0;
>> +	WARN_ON(pdev_num !=3D 0);
>> +	mutex_unlock(&xcp_mutex);
>> }
>> EXPORT_SYMBOL(amdgpu_xcp_drv_release);
>>=20
>> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h =
b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
>> index c1c4b679bf95..580a1602c8e3 100644
>> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
>> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
>> @@ -25,5 +25,6 @@
>> #define _AMDGPU_XCP_DRV_H_
>>=20
>> int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev);
>> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev);
>> void amdgpu_xcp_drv_release(void);
>> #endif /* _AMDGPU_XCP_DRV_H_ */


--Apple-Mail=_0A65D644-082D-4836-A756-7CCCCB8F9756
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">2025=E5=B9=B41=E6=9C=888=E6=97=A5 17:31=EF=BC=8CLazar, Lijo =
&lt;<a href=3D"mailto:lijo.lazar@amd.com" =
class=3D"">lijo.lazar@amd.com</a>&gt; =E5=86=99=E9=81=93=EF=BC=9A</div><br=
 class=3D"Apple-interchange-newline"><div class=3D""><meta =
charset=3D"UTF-8" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); =
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
class=3D"">On 1/8/2025 2:26 PM, Jiang Liu wrote:</span><br =
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
class=3D"">Introduce new interface amdgpu_xcp_drm_dev_free() to free a =
specific<br class=3D"">drm_device crreated by =
amdgpu_xcp_drm_dev_alloc(), which will be used<br class=3D"">to do error =
recovery.<br class=3D""><br class=3D"">Signed-off-by: Jiang Liu &lt;<a =
href=3D"mailto:gerry@linux.alibaba.com" =
class=3D"">gerry@linux.alibaba.com</a>&gt;<br class=3D"">---<br =
class=3D"">drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 76 =
+++++++++++++++++----<br =
class=3D"">drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h | &nbsp;1 +<br =
class=3D"">2 files changed, 63 insertions(+), 14 deletions(-)<br =
class=3D""><br class=3D"">diff --git =
a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c =
b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c<br class=3D"">index =
faed84172dd4..fc92b5fe1040 100644<br class=3D"">--- =
a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c<br class=3D"">+++ =
b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c<br class=3D"">@@ -45,21 =
+45,32 @@ static const struct drm_driver amdgpu_xcp_driver =3D {<br =
class=3D""><br class=3D"">static int8_t pdev_num;<br class=3D"">static =
struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];<br class=3D"">+static=
 DEFINE_MUTEX(xcp_mutex);<br class=3D""><br class=3D"">int =
amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)<br class=3D"">{<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>struct platform_device *pdev;<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
xcp_device *pxcp_dev;<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>char dev_name[20];<br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>int ret;<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>int ret, index;<br class=3D""><br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (pdev_num &gt;=3D MAX_XCP_PLATFORM_DEVICE)<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
-ENODEV;<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>mutex_lock(&amp;xcp_mutex);<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (pdev_num &gt;=3D MAX_XCP_PLATFORM_DEVICE) {<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ret =3D -ENODEV;<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>goto out_unlock;<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br class=3D"">+<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>for (index =3D 0; index &lt; =
MAX_XCP_PLATFORM_DEVICE; index++) {<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(!xcp_dev[index])<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>break;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>}<br =
class=3D""><br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>snprintf(dev_name, =
sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", index);<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>pdev =3D platform_device_register_simple(dev_name, -1, NULL, =
0);<br class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (IS_ERR(pdev))<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
PTR_ERR(pdev);<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (IS_ERR(pdev)) {<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ret =3D PTR_ERR(pdev);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>goto =
out_unregister;<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br class=3D""><br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (!devres_open_group(&amp;pdev-&gt;dev, NULL, GFP_KERNEL)) {<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ret =3D -ENOMEM;<br class=3D"">@@ -72,10 +83,11 @@ int =
amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>goto =
out_devres;<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br class=3D""><br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>xcp_dev[pdev_num] =3D pxcp_dev;<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>xcp_dev[pdev_num]-&gt;pdev =3D pdev;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>xcp_dev[index] =3D pxcp_dev;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>xcp_dev[index]-&gt;pdev =3D pdev;<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>*ddev =3D =
&amp;pxcp_dev-&gt;drm;<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>pdev_num++;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>mutex_unlock(&amp;xcp_mutex);<br class=3D""><br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
0;<br class=3D""><br class=3D"">@@ -83,21 +95,57 @@ int =
amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>devres_release_group(&amp;pdev-&gt;dev, NULL);<br =
class=3D"">out_unregister:<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>platform_device_unregister(pdev);<br class=3D"">+out_unlock:<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>mutex_unlock(&amp;xcp_mutex);<br class=3D""><br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
ret;<br class=3D"">}<br =
class=3D"">EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);<br class=3D""><br =
class=3D"">+static void amdgpu_xcp_drm_dev_destroy(int index)<br =
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
class=3D"">&lt;Nit&gt; Use something like __amdgpu_xcp_drm_dev_free(int =
index) to keep</span><br style=3D"caret-color: rgb(0, 0, 0); =
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
class=3D"">the 'free' suffix.</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; =
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
text-decoration: none;" class=3D"">+{<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
platform_device *pdev;<br class=3D"">+<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>pdev =3D =
xcp_dev[index]-&gt;pdev;<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>devres_release_group(&amp;pdev-&gt;dev, NULL);<br class=3D"">+<span=
 class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>platform_device_unregister(pdev);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>xcp_dev[index] =3D NULL;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>pdev_num--;<br class=3D"">+}<br class=3D"">+<br class=3D"">+void =
amdgpu_xcp_drm_dev_free(struct drm_device *ddev)<br class=3D"">+{<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>int index;<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct xcp_device *pxcp_dev;<br =
class=3D"">+<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (ddev =3D=3D NULL)<br =
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
class=3D"">Does it make sense to add !pdev_num check or a =
WARN_ON(!pdev_num) below?</span><br style=3D"caret-color: rgb(0, 0, 0); =
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
text-decoration: none;" class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return;<br class=3D"">+<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>pxcp_dev =3D container_of(ddev, struct xcp_device, drm);<br =
class=3D"">+<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>mutex_lock(&amp;xcp_mutex);<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>for (index =3D 0; index &lt; MAX_XCP_PLATFORM_DEVICE; index++) =
{<br class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (xcp_dev[index] =3D=3D pxcp_dev) {<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_xcp_drm_dev_destroy(index);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>break;<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>mutex_unlock(&amp;xcp_mutex);<br class=3D"">+}<br =
class=3D"">+EXPORT_SYMBOL(amdgpu_xcp_drm_dev_free);<br class=3D"">+<br =
class=3D"">void amdgpu_xcp_drv_release(void)<br class=3D"">{<br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>for (--pdev_num; pdev_num &gt;=3D 0; --pdev_num) {<br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>struct platform_device *pdev =3D xcp_dev[pdev_num]-&gt;pdev;<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>int index;<br class=3D""><br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>devres_release_group(&amp;pdev-&gt;dev, NULL);<br class=3D"">-<span=
 class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>platform_device_unregister(pdev);<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>xcp_dev[pdev_num] =3D NULL;<br class=3D""></blockquote><br =
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
display: inline !important;" class=3D"">To better optimize, add one =
check like below.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""><span class=3D"Apple-tab-span" =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: pre; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;">	=
</span><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 18px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">if =
(!pdev_num)</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span class=3D"Apple-tab-span" style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: pre; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;">	</span><span class=3D"Apple-tab-span" =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: pre; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;">	=
</span><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 18px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" =
class=3D"">return;</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;" class=3D""></div></blockquote><div>Thanks for =
review and suggestions, all comments will be addressed in next =
version.</div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
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
class=3D"">Thanks,</span><br style=3D"caret-color: rgb(0, 0, 0); =
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
class=3D"">Lijo</span><br style=3D"caret-color: rgb(0, 0, 0); =
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
text-decoration: none;" class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>mutex_lock(&amp;xcp_mutex);<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>for (index =3D 0; index &lt; MAX_XCP_PLATFORM_DEVICE; index++) =
{<br class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (xcp_dev[index]) {<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_xcp_drm_dev_destroy(index);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>}<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>pdev_num =3D 0;<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>WARN_ON(pdev_num !=3D 0);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>mutex_unlock(&amp;xcp_mutex);<br class=3D"">}<br =
class=3D"">EXPORT_SYMBOL(amdgpu_xcp_drv_release);<br class=3D""><br =
class=3D"">diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h =
b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h<br class=3D"">index =
c1c4b679bf95..580a1602c8e3 100644<br class=3D"">--- =
a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h<br class=3D"">+++ =
b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h<br class=3D"">@@ -25,5 =
+25,6 @@<br class=3D"">#define _AMDGPU_XCP_DRV_H_<br class=3D""><br =
class=3D"">int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev);<br =
class=3D"">+void amdgpu_xcp_drm_dev_free(struct drm_device *ddev);<br =
class=3D"">void amdgpu_xcp_drv_release(void);<br class=3D"">#endif /* =
_AMDGPU_XCP_DRV_H_ */</blockquote></div></blockquote></div><br =
class=3D""></body></html>=

--Apple-Mail=_0A65D644-082D-4836-A756-7CCCCB8F9756--
