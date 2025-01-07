Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E28AE77199
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 08:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08CF610E3B3;
	Tue,  7 Jan 2025 08:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VpTRsIfD";
	dkim-atps=neutral
Received: from out30-113.freemail.mail.aliyun.com
 (out30-113.freemail.mail.aliyun.com [115.124.30.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A08BC10E13D
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 02:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736215245; h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To;
 bh=N1hC9xOhOMmy0x8ebzG7mXDpNvJQ/WeMPt6T96HIfN0=;
 b=VpTRsIfDpHTZ+m8JinOUVM6Gks9KFTTj7rTCPyGqkW1UHKmGoR2lKL2KxUZtHZvUDJhPMhJsUapxWpBu5aPt5fvFNEm4EEfdc4TNpHu/8th8SVwtT7/5EgbnoVEmczVTjQkGYUAA28w8hZkpxWq1AQCAEZr8BfL4AXluMC4oU2c=
Received: from smtpclient.apple(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WN8vsYy_1736215242 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 07 Jan 2025 10:00:44 +0800
From: Gerry Liu <gerry@linux.alibaba.com>
Message-Id: <B9AF6BB8-FC61-486C-A55E-7B1E39EBDB3A@linux.alibaba.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_A7DA9CBB-2E51-479F-8450-DD2353326B4C"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 3/6] drm/amdxcp: introduce new API
 amdgpu_xcp_drm_dev_free()
Date: Tue, 7 Jan 2025 10:00:41 +0800
In-Reply-To: <cefb9a61-c6d6-4867-a9b7-4fb9f3659651@amd.com>
Cc: amd-gfx@lists.freedesktop.org, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com
To: "Lazar, Lijo" <lijo.lazar@amd.com>
References: <cover.1736044362.git.gerry@linux.alibaba.com>
 <0380e1585e7b29426e0c9ff49b84ea071d9c4610.1736044362.git.gerry@linux.alibaba.com>
 <cefb9a61-c6d6-4867-a9b7-4fb9f3659651@amd.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Mailman-Approved-At: Tue, 07 Jan 2025 08:42:00 +0000
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


--Apple-Mail=_A7DA9CBB-2E51-479F-8450-DD2353326B4C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2025=E5=B9=B41=E6=9C=886=E6=97=A5 14:51=EF=BC=8CLazar, Lijo =
<lijo.lazar@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> On 1/5/2025 8:15 AM, Jiang Liu wrote:
>> Introduce new interface amdgpu_xcp_drm_dev_free() to free a specific
>> drm_device crreated by amdgpu_xcp_drm_dev_alloc(), which will be used
>> to do error recovery.
>>=20
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>> ---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     | 11 +++-
>> drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h     |  1 +
>> drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 70 =
+++++++++++++++++----
>> drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
>> 4 files changed, 70 insertions(+), 13 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> index e209b5e101df..401fbaa0b6b8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> @@ -359,6 +359,8 @@ int amdgpu_xcp_dev_register(struct amdgpu_device =
*adev,
>> 		ret =3D drm_dev_register(adev->xcp_mgr->xcp[i].ddev, =
ent->driver_data);
>> 		if (ret)
>> 			return ret;
>> +
>> +		adev->xcp_mgr->xcp[i].registered =3D true;
>> 	}
>>=20
>> 	return 0;
>> @@ -376,12 +378,19 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device =
*adev)
>> 		if (!adev->xcp_mgr->xcp[i].ddev)
>> 			break;
>>=20
>> +		// Restore and free the original drm_device.
>> 		p_ddev =3D adev->xcp_mgr->xcp[i].ddev;
>> -		drm_dev_unplug(p_ddev);
>> +		if (adev->xcp_mgr->xcp[i].registered) {
>> +			drm_dev_unplug(p_ddev);
>> +			adev->xcp_mgr->xcp[i].registered =3D false;
>> +		}
>> 		p_ddev->render->dev =3D adev->xcp_mgr->xcp[i].rdev;
>> 		p_ddev->primary->dev =3D adev->xcp_mgr->xcp[i].pdev;
>> 		p_ddev->driver =3D  adev->xcp_mgr->xcp[i].driver;
>> 		p_ddev->vma_offset_manager =3D =
adev->xcp_mgr->xcp[i].vma_offset_manager;
>> +		amdgpu_xcp_drm_dev_free(p_ddev);
>> +
>> +		adev->xcp_mgr->xcp[i].ddev =3D NULL;
>> 	}
>> }
>>=20
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>> index b63f53242c57..cd06a4a232be 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>> @@ -101,6 +101,7 @@ struct amdgpu_xcp {
>> 	uint8_t id;
>> 	uint8_t mem_id;
>> 	bool valid;
>> +	bool registered;
>> 	atomic_t	ref_cnt;
>> 	struct drm_device *ddev;
>> 	struct drm_device *rdev;
>> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c =
b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
>> index faed84172dd4..9058d71b4756 100644
>> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
>> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
>> @@ -45,18 +45,26 @@ static const struct drm_driver amdgpu_xcp_driver =
=3D {
>>=20
>> static int8_t pdev_num;
>> static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
>> +static struct mutex xcp_mutex;
>=20
> I think this needs to be static DEFINE_MUTEX(xcp_mutex).
>=20
>>=20
>> int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>> {
>> 	struct platform_device *pdev;
>> 	struct xcp_device *pxcp_dev;
>> 	char dev_name[20];
>> -	int ret;
>> +	int ret, index;
>>=20
>> +	mutex_lock(&xcp_mutex);
>> +	ret =3D -ENODEV;
>=20
> Preference would be do this inside the below if() to associate the =
error
> with the condition.
>=20
>> 	if (pdev_num >=3D MAX_XCP_PLATFORM_DEVICE)
>> -		return -ENODEV;
>> +		goto out_unlock;
>>=20
>> -	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
>> +	for (index =3D 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
>> +		if (!xcp_dev[index])
>> +			break;
>> +	}
>> +
>> +	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", index);
>> 	pdev =3D platform_device_register_simple(dev_name, -1, NULL, 0);
>> 	if (IS_ERR(pdev))
>> 		return PTR_ERR(pdev);
>=20
> Seems mutex is left locked here.
Will fixed in next version:)

>=20
>> @@ -72,10 +80,11 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device =
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
>> @@ -83,21 +92,58 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device =
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
>> -void amdgpu_xcp_drv_release(void)
>> +static void amdgpu_xcp_drm_dev_destroy(int index)
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
>> {
>> -	for (--pdev_num; pdev_num >=3D 0; --pdev_num) {
>> -		struct platform_device *pdev =3D =
xcp_dev[pdev_num]->pdev;
>> +	int index;
>> +	struct xcp_device *pxcp_dev;
>> +
>> +	if (ddev =3D=3D NULL)
>> +		return;
>>=20
>> -		devres_release_group(&pdev->dev, NULL);
>> -		platform_device_unregister(pdev);
>> -		xcp_dev[pdev_num] =3D NULL;
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
>> +void amdgpu_xcp_drv_release(void)
>> +{
>> +	int index;
>> +
>> +	mutex_lock(&xcp_mutex);
>> +	for (index =3D 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
>> +		if (xcp_dev[index]) {
>> +			WARN_ON(xcp_dev[index]);
>=20
> Why is this WARN check needed? There is already a if() check for valid
> index.
>=20
> Also, would suggest to separate out amdgpu_xcp.c from xcp_drv.c. =
xcp_drv
> introducing a new interface may be kept in a separate patch.
With new implementation, all xcp devices should have already be removed =
when amdgpu_xcp_drv_release() gets called,
So hope to verify whether it works as expected.

Thanks!
>=20
> Thanks,
> Lijo
>=20
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


--Apple-Mail=_A7DA9CBB-2E51-479F-8450-DD2353326B4C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">2025=E5=B9=B41=E6=9C=886=E6=97=A5 14:51=EF=BC=8CLazar, Lijo =
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
class=3D"">On 1/5/2025 8:15 AM, Jiang Liu wrote:</span><br =
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
class=3D"">drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c =
&nbsp;&nbsp;&nbsp;&nbsp;| 11 +++-<br =
class=3D"">drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h =
&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;1 +<br =
class=3D"">drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 70 =
+++++++++++++++++----<br =
class=3D"">drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h | &nbsp;1 +<br =
class=3D"">4 files changed, 70 insertions(+), 13 deletions(-)<br =
class=3D""><br class=3D"">diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c<br class=3D"">index =
e209b5e101df..401fbaa0b6b8 100644<br class=3D"">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c<br class=3D"">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c<br class=3D"">@@ -359,6 +359,8 =
@@ int amdgpu_xcp_dev_register(struct amdgpu_device *adev,<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ret =3D drm_dev_register(adev-&gt;xcp_mgr-&gt;xcp[i].ddev, =
ent-&gt;driver_data);<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (ret)<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
ret;<br class=3D"">+<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>adev-&gt;xcp_mgr-&gt;xcp[i].registered =3D true;<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br class=3D""><br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return 0;<br class=3D"">@@ =
-376,12 +378,19 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device =
*adev)<br class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (!adev-&gt;xcp_mgr-&gt;xcp[i].ddev)<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>break;<br =
class=3D""><br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>// Restore and free the original =
drm_device.<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>p_ddev =3D =
adev-&gt;xcp_mgr-&gt;xcp[i].ddev;<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>drm_dev_unplug(p_ddev);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(adev-&gt;xcp_mgr-&gt;xcp[i].registered) {<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>drm_dev_unplug(p_ddev);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>adev-&gt;xcp_mgr-&gt;xcp[i].registered =3D false;<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>p_ddev-&gt;render-&gt;dev =3D =
adev-&gt;xcp_mgr-&gt;xcp[i].rdev;<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>p_ddev-&gt;primary-&gt;dev =3D =
adev-&gt;xcp_mgr-&gt;xcp[i].pdev;<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>p_ddev-&gt;driver =3D =
&nbsp;adev-&gt;xcp_mgr-&gt;xcp[i].driver;<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>p_ddev-&gt;vma_offset_manager =3D =
adev-&gt;xcp_mgr-&gt;xcp[i].vma_offset_manager;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_xcp_drm_dev_free(p_ddev);<br class=3D"">+<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>adev-&gt;xcp_mgr-&gt;xcp[i].ddev =3D NULL;<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>}<br =
class=3D"">}<br class=3D""><br class=3D"">diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h<br class=3D"">index =
b63f53242c57..cd06a4a232be 100644<br class=3D"">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h<br class=3D"">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h<br class=3D"">@@ -101,6 +101,7 =
@@ struct amdgpu_xcp {<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>uint8_t id;<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>uint8_t =
mem_id;<br class=3D""><span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>bool valid;<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>bool registered;<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>atomic_t<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ref_cnt;<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct drm_device *ddev;<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>struct drm_device *rdev;<br class=3D"">diff --git =
a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c =
b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c<br class=3D"">index =
faed84172dd4..9058d71b4756 100644<br class=3D"">--- =
a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c<br class=3D"">+++ =
b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c<br class=3D"">@@ -45,18 =
+45,26 @@ static const struct drm_driver amdgpu_xcp_driver =3D {<br =
class=3D""><br class=3D"">static int8_t pdev_num;<br class=3D"">static =
struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];<br class=3D"">+static=
 struct mutex xcp_mutex;<br class=3D""></blockquote><br =
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
display: inline !important;" class=3D"">I think this needs to be static =
DEFINE_MUTEX(xcp_mutex).</span><br style=3D"caret-color: rgb(0, 0, 0); =
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
text-decoration: none;" class=3D""><br class=3D"">int =
amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)<br class=3D"">{<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>struct platform_device *pdev;<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
xcp_device *pxcp_dev;<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>char dev_name[20];<br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>int ret;<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>int ret, index;<br class=3D""><br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>mutex_lock(&amp;xcp_mutex);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
-ENODEV;<br class=3D""></blockquote><br style=3D"caret-color: rgb(0, 0, =
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
class=3D"">Preference would be do this inside the below if() to =
associate the error</span><br style=3D"caret-color: rgb(0, 0, 0); =
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
class=3D"">with the condition.</span><br style=3D"caret-color: rgb(0, 0, =
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
text-decoration: none;" class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (pdev_num &gt;=3D =
MAX_XCP_PLATFORM_DEVICE)<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return -ENODEV;<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>goto out_unlock;<br class=3D""><br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", =
pdev_num);<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>for (index =3D 0; index &lt; =
MAX_XCP_PLATFORM_DEVICE; index++) {<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(!xcp_dev[index])<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>break;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>}<br =
class=3D"">+<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>snprintf(dev_name, =
sizeof(dev_name), "amdgpu_xcp_%d", index);<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>pdev =3D =
platform_device_register_simple(dev_name, -1, NULL, 0);<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (IS_ERR(pdev))<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return PTR_ERR(pdev);<br =
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
class=3D"">Seems mutex is left locked here.</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D""></div></blockquote><div>Will fixed in next version:)</div><br =
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
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">@@ =
-72,10 +80,11 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device =
**ddev)<br class=3D""><span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>goto out_devres;<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>}<br =
class=3D""><br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>xcp_dev[pdev_num] =3D =
pxcp_dev;<br class=3D"">-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>xcp_dev[pdev_num]-&gt;pdev =3D =
pdev;<br class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>xcp_dev[index] =3D pxcp_dev;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>xcp_dev[index]-&gt;pdev =3D pdev;<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>*ddev =3D =
&amp;pxcp_dev-&gt;drm;<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>pdev_num++;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>mutex_unlock(&amp;xcp_mutex);<br class=3D""><br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
0;<br class=3D""><br class=3D"">@@ -83,21 +92,58 @@ int =
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
class=3D"">-void amdgpu_xcp_drv_release(void)<br class=3D"">+static void =
amdgpu_xcp_drm_dev_destroy(int index)<br class=3D"">+{<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>struct platform_device *pdev;<br class=3D"">+<br class=3D"">+<span =
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
amdgpu_xcp_drm_dev_free(struct drm_device *ddev)<br class=3D"">{<br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>for (--pdev_num; pdev_num &gt;=3D 0; --pdev_num) {<br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>struct platform_device *pdev =3D xcp_dev[pdev_num]-&gt;pdev;<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>int index;<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct xcp_device *pxcp_dev;<br =
class=3D"">+<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (ddev =3D=3D NULL)<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>return;<br class=3D""><br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>devres_release_group(&amp;pdev-&gt;dev, NULL);<br class=3D"">-<span=
 class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>platform_device_unregister(pdev);<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>xcp_dev[pdev_num] =3D NULL;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>pxcp_dev =
=3D container_of(ddev, struct xcp_device, drm);<br class=3D"">+<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>mutex_lock(&amp;xcp_mutex);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>for =
(index =3D 0; index &lt; MAX_XCP_PLATFORM_DEVICE; index++) {<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (xcp_dev[index] =3D=3D pxcp_dev) {<br class=3D"">+<span =
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
class=3D"">+void amdgpu_xcp_drv_release(void)<br class=3D"">+{<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>int index;<br class=3D"">+<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>mutex_lock(&amp;xcp_mutex);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>for =
(index =3D 0; index &lt; MAX_XCP_PLATFORM_DEVICE; index++) {<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (xcp_dev[index]) {<br class=3D"">+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>WARN_ON(xcp_dev[index]);<br =
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
class=3D"">Why is this WARN check needed? There is already a if() check =
for valid</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
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
class=3D"">index.</span><br style=3D"caret-color: rgb(0, 0, 0); =
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
class=3D"">Also, would suggest to separate out amdgpu_xcp.c from =
xcp_drv.c. xcp_drv</span><br style=3D"caret-color: rgb(0, 0, 0); =
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
class=3D"">introducing a new interface may be kept in a separate =
patch.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""></div></blockquote><div>With new implementation, all =
xcp devices should have already be removed when amdgpu_xcp_drv_release() =
gets called,</div>So hope to verify whether it works as =
expected.</div><div><br class=3D""></div><div>Thanks!<br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><br =
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
display: inline !important;" class=3D"">Thanks,</span><br =
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
display: inline !important;" class=3D"">Lijo</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><br =
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
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">+<span =
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

--Apple-Mail=_A7DA9CBB-2E51-479F-8450-DD2353326B4C--
