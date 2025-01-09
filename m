Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06F7E77188
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 02:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 593D710E97A;
	Thu,  9 Jan 2025 02:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Y9Z1ENBs";
	dkim-atps=neutral
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CB0410E97F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 02:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736390379; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 bh=sBOimxO7omT6iGg6/IU5/ZjjsKM7ALwlQLzAjYg/Fcs=;
 b=Y9Z1ENBs2VKJAft45VdrObd/dlILKy8XzZ25SCUUtEH0is9Zdz220BcH3K+Cl6gEyAg5mN1Os+xx3xN1EOd20ie6dlsTj0HJyWypa/Lfuoy456vPDZchzMCvCFRqKEipReu721y7sNVA9qUBR6ESfkQH6QWQfMFRyRx6I+5KuEs=
Received: from smtpclient.apple(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNFbfc5_1736390377 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 09 Jan 2025 10:39:38 +0800
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [v3 2/6] drm/amdxcp: introduce new API amdgpu_xcp_drm_dev_free()
From: Gerry Liu <gerry@linux.alibaba.com>
In-Reply-To: <1acf7529-0b54-4e34-bf6c-6c1005a39540@amd.com>
Date: Thu, 9 Jan 2025 10:39:36 +0800
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, Jun.Ma2@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <42C59365-9C9A-40AF-99A1-A8A1DEAC0DDB@linux.alibaba.com>
References: <cover.1736325561.git.gerry@linux.alibaba.com>
 <c46d4c3bead7f62439eca5110de8afe4783a7418.1736325561.git.gerry@linux.alibaba.com>
 <1acf7529-0b54-4e34-bf6c-6c1005a39540@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
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



> 2025=E5=B9=B41=E6=9C=889=E6=97=A5 00:04=EF=BC=8CMario Limonciello =
<mario.limonciello@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 1/8/2025 02:56, Jiang Liu wrote:
>> Introduce new interface amdgpu_xcp_drm_dev_free() to free a specific
>> drm_device crreated by amdgpu_xcp_drm_dev_alloc(), which will be used
>> to do error recovery.
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>> ---
>>  drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 76 =
+++++++++++++++++----
>>  drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
>>  2 files changed, 63 insertions(+), 14 deletions(-)
>> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c =
b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
>> index faed84172dd4..fc92b5fe1040 100644
>> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
>> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
>> @@ -45,21 +45,32 @@ static const struct drm_driver amdgpu_xcp_driver =
=3D {
>>    static int8_t pdev_num;
>>  static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
>> +static DEFINE_MUTEX(xcp_mutex);
>>    int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>>  {
>>  	struct platform_device *pdev;
>>  	struct xcp_device *pxcp_dev;
>>  	char dev_name[20];
>> -	int ret;
>> +	int ret, index;
>>  -	if (pdev_num >=3D MAX_XCP_PLATFORM_DEVICE)
>> -		return -ENODEV;
>> +	mutex_lock(&xcp_mutex);
>=20
> For "new" code what do you think about about using scoped guards like =
guard(mutex) instead of lock; goto label; unlock pattern?
>=20
> I think it can generally keep the code cleaner, but you need to be =
careful because if you still need "other" goto cleanup patterns you can =
unintentionally break the compiled output.
Thanks for introducing this new utility, which makes me feel like =
writing rust code:)

>=20
>> +	if (pdev_num >=3D MAX_XCP_PLATFORM_DEVICE) {
>> +		ret =3D -ENODEV;
>> +		goto out_unlock;
>> +	}
>> +
>> +	for (index =3D 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
>> +		if (!xcp_dev[index])
>> +			break;
>> +	}
>>  -	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
>> +	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", index);
>>  	pdev =3D platform_device_register_simple(dev_name, -1, NULL, 0);
>> -	if (IS_ERR(pdev))
>> -		return PTR_ERR(pdev);
>> +	if (IS_ERR(pdev)) {
>> +		ret =3D PTR_ERR(pdev);
>> +		goto out_unregister;
>=20
> Er, if you fail to register why would you unregister?  I think in this =
case with the current code you would 'goto out_unlock' instead.
>=20
> The design pattern you might have been following was from platform =
drivers that do this, which is different:
>=20
> platform_driver_register()
> foo =3D platform_device_register_simple()
> if (IS_ERR(foo))
> 	platform_driver_unregister()
> return 0;
Will fix it in next version.

>=20
>> +	}
>>    	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
>>  		ret =3D -ENOMEM;
>> @@ -72,10 +83,11 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device =
**ddev)
>>  		goto out_devres;
>>  	}
>>  -	xcp_dev[pdev_num] =3D pxcp_dev;
>> -	xcp_dev[pdev_num]->pdev =3D pdev;
>> +	xcp_dev[index] =3D pxcp_dev;
>> +	xcp_dev[index]->pdev =3D pdev;
>>  	*ddev =3D &pxcp_dev->drm;
>>  	pdev_num++;
>> +	mutex_unlock(&xcp_mutex);
>>    	return 0;
>>  @@ -83,21 +95,57 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device =
**ddev)
>>  	devres_release_group(&pdev->dev, NULL);
>>  out_unregister:
>>  	platform_device_unregister(pdev);
>> +out_unlock:
>> +	mutex_unlock(&xcp_mutex);
>>    	return ret;
>>  }
>>  EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
>>  +static void amdgpu_xcp_drm_dev_destroy(int index)
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
>> +		return;
>> +
>> +	pxcp_dev =3D container_of(ddev, struct xcp_device, drm);
>> +
>> +	mutex_lock(&xcp_mutex);
>=20
> I think this is a good case for a guard(mutex) instead.
>=20
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
>>  void amdgpu_xcp_drv_release(void)
>>  {
>> -	for (--pdev_num; pdev_num >=3D 0; --pdev_num) {
>> -		struct platform_device *pdev =3D =
xcp_dev[pdev_num]->pdev;
>> +	int index;
>>  -		devres_release_group(&pdev->dev, NULL);
>> -		platform_device_unregister(pdev);
>> -		xcp_dev[pdev_num] =3D NULL;
>> +	mutex_lock(&xcp_mutex);
>=20
> Another good case for guard(mutex)
>=20
>> +	for (index =3D 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
>> +		if (xcp_dev[index]) {
>> +			amdgpu_xcp_drm_dev_destroy(index);
>> +		}
>>  	}
>> -	pdev_num =3D 0;
>> +	WARN_ON(pdev_num !=3D 0);
>> +	mutex_unlock(&xcp_mutex);
>>  }
>>  EXPORT_SYMBOL(amdgpu_xcp_drv_release);
>>  diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h =
b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
>> index c1c4b679bf95..580a1602c8e3 100644
>> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
>> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
>> @@ -25,5 +25,6 @@
>>  #define _AMDGPU_XCP_DRV_H_
>>    int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev);
>> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev);
>>  void amdgpu_xcp_drv_release(void);
>>  #endif /* _AMDGPU_XCP_DRV_H_ */

