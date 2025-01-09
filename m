Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDBEE77199
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 03:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0C2F10E0B5;
	Thu,  9 Jan 2025 03:00:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QaO86siS";
	dkim-atps=neutral
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E375C10E0B5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 03:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736391626; h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To;
 bh=a639xYk6Q5sQE2rBgwR4WJbfZLnqQuqqNtSllcFs/FY=;
 b=QaO86siSBhEUkqYLxzHTYseTIJj9AclrQsk3peOyCIjtKAWXmAvYhfkaAIEKXpN6ibLv+j3NR4cU6pl9a5oCJ5cRsnqpV0W/WsswvU9e3vDIqEI6VKPJJSshjeX72amV0gaY2nY7bDL2jr8S7uLysx4OblYh+j88IaqjWycTNBw=
Received: from smtpclient.apple(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNFnDte_1736391623 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 09 Jan 2025 11:00:25 +0800
From: Gerry Liu <gerry@linux.alibaba.com>
Message-Id: <F8DB9377-1714-4A9A-BA10-932EE238A8CE@linux.alibaba.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_2CAB3493-9B0D-44F5-9052-52A0C731BE92"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [v3 3/6] drm/amdgpu: fix use after free bug related to
 amdgpu_driver_release_kms()
Date: Thu, 9 Jan 2025 11:00:23 +0800
In-Reply-To: <51b9f2ea-40ee-40f4-b3a8-33c06e0e866e@amd.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 Hawking.Zhang@amd.com, mario.limonciello@amd.com, Jun.Ma2@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
To: "Lazar, Lijo" <lijo.lazar@amd.com>
References: <cover.1736325561.git.gerry@linux.alibaba.com>
 <5c662d197e0d483b551365fcb98f55c33c66d281.1736325561.git.gerry@linux.alibaba.com>
 <51b9f2ea-40ee-40f4-b3a8-33c06e0e866e@amd.com>
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


--Apple-Mail=_2CAB3493-9B0D-44F5-9052-52A0C731BE92
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2025=E5=B9=B41=E6=9C=888=E6=97=A5 17:54=EF=BC=8CLazar, Lijo =
<lijo.lazar@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> On 1/8/2025 2:26 PM, Jiang Liu wrote:
>> If some GPU device failed to probe, `rmmod amdgpu` will trigger a use
>> after free bug related to amdgpu_driver_release_kms() as:
>> 2024-12-26 16:17:45 [16002.085540] BUG: kernel NULL pointer =
dereference, address: 0000000000000000
>> 2024-12-26 16:17:45 [16002.093792] #PF: supervisor read access in =
kernel mode
>> 2024-12-26 16:17:45 [16002.099993] #PF: error_code(0x0000) - =
not-present page
>> 2024-12-26 16:17:45 [16002.106188] PGD 0 P4D 0
>> 2024-12-26 16:17:45 [16002.109464] Oops: Oops: 0000 [#1] PREEMPT SMP =
NOPTI
>> 2024-12-26 16:17:45 [16002.115372] CPU: 2 PID: 14375 Comm: rmmod =
Kdump: loaded Tainted: G        W   E      6.10.0+ #2
>> 2024-12-26 16:17:45 [16002.125577] Hardware name: Alibaba Alibaba =
Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
>> 2024-12-26 16:17:45 [16002.136858] RIP: 0010:drm_sched_fini+0x3f/0xe0 =
[gpu_sched]
>> 2024-12-26 16:17:45 [16002.143463] Code: 60 c6 87 be 00 00 00 01 e8 =
ce e0 90 d8 48 8d bb 80 00 00 00 e8 c2 e0 90 d8 8b 43 20 85 c0 74 51 45 =
31 e4 48 8b
>> 43 28 4d 63 ec <4a> 8b 2c e8 48 89 ef e8 f5 0e 59 d9 48 8b 45 10 48 =
8d 55 10 48 39
>> 2024-12-26 16:17:45 [16002.164992] RSP: 0018:ffffb570dbbb7da8 EFLAGS: =
00010246
>> 2024-12-26 16:17:45 [16002.171316] RAX: 0000000000000000 RBX: =
ffff96b0fdadc878 RCX: 0000000000000000
>> 2024-12-26 16:17:46 [16002.179784] RDX: 000fffffffe00000 RSI: =
0000000000000000 RDI: ffff96b0fdadc8f8
>> 2024-12-26 16:17:46 [16002.188252] RBP: ffff96b0fdadc800 R08: =
ffff97abbd035040 R09: ffffffff9ac52540
>> 2024-12-26 16:17:46 [16002.196722] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
>> 2024-12-26 16:17:46 [16002.205179] R13: 0000000000000000 R14: =
ffff96b0fdadfc00 R15: 0000000000000000
>> 2024-12-26 16:17:46 [16002.213648] FS:  00007f2737000740(0000) =
GS:ffff97abbd100000(0000) knlGS:0000000000000000
>> 2024-12-26 16:17:46 [16002.223189] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
>> 2024-12-26 16:17:46 [16002.230103] CR2: 0000000000000000 CR3: =
000000011be3a005 CR4: 0000000000f70ef0
>> 2024-12-26 16:17:46 [16002.238581] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
>> 2024-12-26 16:17:46 [16002.247053] DR3: 0000000000000000 DR6: =
00000000fffe07f0 DR7: 0000000000000400
>> e024se+0x3c/0x90 [amdxcp]
>> 2024-12-26 16:17:46 [16002.337645]  =
__do_sys_delete_module.constprop.0+0x176/0x310
>> 2024-12-26 16:17:46 [16002.344324]  do_syscall_64+0x5d/0x170
>> 2024-12-26 16:17:46 [16002.348858]  =
entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> 2024-12-26 16:17:46 [16002.354956] RIP: 0033:0x7f2736a620cb-12-26
>>=20
>> Fix it by removing xcp drm devices when failed to probe GPU devices.
>>=20
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>> Tested-by: Shuo Liu <shuox.liu@linux.alibaba.com>
>> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>> drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
>> drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  1 +
>> drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 47 =
+++++++++++++++++++---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  4 +-
>> 5 files changed, 47 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 5ff53a3b9851..510074a9074e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -6682,7 +6682,7 @@ void amdgpu_device_halt(struct amdgpu_device =
*adev)
>> 	struct pci_dev *pdev =3D adev->pdev;
>> 	struct drm_device *ddev =3D adev_to_drm(adev);
>>=20
>> -	amdgpu_xcp_dev_unplug(adev);
>> +	amdgpu_xcp_dev_deregister(adev);
>> 	drm_dev_unplug(ddev);
>>=20
>> 	amdgpu_irq_disable_all(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 62de668e9ff8..41d1b06be600 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2435,7 +2435,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>> 	struct drm_device *dev =3D pci_get_drvdata(pdev);
>> 	struct amdgpu_device *adev =3D drm_to_adev(dev);
>>=20
>> -	amdgpu_xcp_dev_unplug(adev);
>> +	amdgpu_xcp_dev_deregister(adev);
>> 	amdgpu_gmc_prepare_nps_mode_change(adev);
>> 	drm_dev_unplug(dev);
>>=20
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index d2a046736edd..be9147eb8308 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1508,6 +1508,7 @@ void amdgpu_driver_release_kms(struct =
drm_device *dev)
>> 	struct amdgpu_device *adev =3D drm_to_adev(dev);
>>=20
>> 	amdgpu_device_fini_sw(adev);
>> +	amdgpu_xcp_mgr_fini(adev);
>=20
> Suggest to move this inside fini_sw()
>=20
>> 	pci_set_drvdata(adev->pdev, NULL);
>> }
>>=20
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> index e209b5e101df..62dd5287808b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> @@ -283,6 +283,33 @@ static int amdgpu_xcp_dev_alloc(struct =
amdgpu_device *adev)
>> 	return 0;
>> }
>>=20
>> +static void amdgpu_xcp_dev_free(struct amdgpu_device *adev)
>> +{
>> +	struct drm_device *p_ddev;
>> +	int i;
>> +
>> +	if (!adev->xcp_mgr)
>> +		return;
>> +
>> +	for (i =3D 1; i < MAX_XCP; i++) {
>> +		if (!adev->xcp_mgr->xcp[i].ddev)
>> +			break;
>> +
>> +		// Restore and free the original drm_device.
>> +		p_ddev =3D adev->xcp_mgr->xcp[i].ddev;
>> +		p_ddev->render->dev =3D adev->xcp_mgr->xcp[i].rdev;
>> +		p_ddev->primary->dev =3D adev->xcp_mgr->xcp[i].pdev;
>> +		p_ddev->driver =3D  adev->xcp_mgr->xcp[i].driver;
>> +		p_ddev->vma_offset_manager =3D =
adev->xcp_mgr->xcp[i].vma_offset_manager;
>=20
> Now that there are more calls, this doesn't make sense here. What =
about
> moving the redirection along with register() (I guess it matters from
> that point onwards) and undoing it (restore back saved values) along
> with deregister()? With that, there won't be a need to have registered
> flag. You may only need to check if xcp rdev/pdev is not NULL.
Good point, this makes code more clear.


>=20
>> +		amdgpu_xcp_drm_dev_free(p_ddev);
>> +
>> +		adev->xcp_mgr->xcp[i].ddev =3D NULL;
>> +	}
>> +
>> +	adev->xcp_mgr->xcp->ddev =3D NULL;
>> +}
>> +
>> +
>> int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
>> 			int init_num_xcps,
>> 			struct amdgpu_xcp_mgr_funcs *xcp_funcs)
>> @@ -310,6 +337,13 @@ int amdgpu_xcp_mgr_init(struct amdgpu_device =
*adev, int init_mode,
>> 	return amdgpu_xcp_dev_alloc(adev);
>> }
>>=20
>> +void amdgpu_xcp_mgr_fini(struct amdgpu_device *adev)
>> +{
>> +	amdgpu_xcp_dev_free(adev);
>> +	kfree(adev->xcp_mgr);
>> +	adev->xcp_mgr =3D NULL;
>=20
> Thanks for adding this.
>=20
> Thanks,
> Lijo
>=20
>> +}
>> +
>> int amdgpu_xcp_get_partition(struct amdgpu_xcp_mgr *xcp_mgr,
>> 			     enum AMDGPU_XCP_IP_BLOCK ip, int instance)
>> {
>> @@ -359,12 +393,14 @@ int amdgpu_xcp_dev_register(struct =
amdgpu_device *adev,
>> 		ret =3D drm_dev_register(adev->xcp_mgr->xcp[i].ddev, =
ent->driver_data);
>> 		if (ret)
>> 			return ret;
>> +
>> +		adev->xcp_mgr->xcp[i].registered =3D true;
>> 	}
>>=20
>> 	return 0;
>> }
>>=20
>> -void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
>> +void amdgpu_xcp_dev_deregister(struct amdgpu_device *adev)
>> {
>> 	struct drm_device *p_ddev;
>> 	int i;
>> @@ -377,11 +413,10 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device =
*adev)
>> 			break;
>>=20
>> 		p_ddev =3D adev->xcp_mgr->xcp[i].ddev;
>> -		drm_dev_unplug(p_ddev);
>> -		p_ddev->render->dev =3D adev->xcp_mgr->xcp[i].rdev;
>> -		p_ddev->primary->dev =3D adev->xcp_mgr->xcp[i].pdev;
>> -		p_ddev->driver =3D  adev->xcp_mgr->xcp[i].driver;
>> -		p_ddev->vma_offset_manager =3D =
adev->xcp_mgr->xcp[i].vma_offset_manager;
>> +		if (adev->xcp_mgr->xcp[i].registered) {
>> +			drm_dev_unplug(p_ddev);
>> +			adev->xcp_mgr->xcp[i].registered =3D false;
>> +		}
>> 	}
>> }
>>=20
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
>> index b63f53242c57..be22d4398463 100644
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
>> @@ -155,6 +156,7 @@ int amdgpu_xcp_resume(struct amdgpu_xcp_mgr =
*xcp_mgr, int xcp_id);
>>=20
>> int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
>> 			int init_xcps, struct amdgpu_xcp_mgr_funcs =
*xcp_funcs);
>> +void amdgpu_xcp_mgr_fini(struct amdgpu_device *adev);
>> int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int =
mode);
>> int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, =
u32 flags);
>> int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, =
int mode);
>> @@ -168,7 +170,7 @@ int amdgpu_xcp_get_inst_details(struct amdgpu_xcp =
*xcp,
>>=20
>> int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>> 				const struct pci_device_id *ent);
>> -void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev);
>> +void amdgpu_xcp_dev_deregister(struct amdgpu_device *adev);
>> int amdgpu_xcp_open_device(struct amdgpu_device *adev,
>> 			   struct amdgpu_fpriv *fpriv,
>> 			   struct drm_file *file_priv);


--Apple-Mail=_2CAB3493-9B0D-44F5-9052-52A0C731BE92
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">2025=E5=B9=B41=E6=9C=888=E6=97=A5 17:54=EF=BC=8CLazar, Lijo =
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
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">If =
some GPU device failed to probe, `rmmod amdgpu` will trigger a use<br =
class=3D"">after free bug related to amdgpu_driver_release_kms() as:<br =
class=3D"">2024-12-26 16:17:45 [16002.085540] BUG: kernel NULL pointer =
dereference, address: 0000000000000000<br class=3D"">2024-12-26 16:17:45 =
[16002.093792] #PF: supervisor read access in kernel mode<br =
class=3D"">2024-12-26 16:17:45 [16002.099993] #PF: error_code(0x0000) - =
not-present page<br class=3D"">2024-12-26 16:17:45 [16002.106188] PGD 0 =
P4D 0<br class=3D"">2024-12-26 16:17:45 [16002.109464] Oops: Oops: 0000 =
[#1] PREEMPT SMP NOPTI<br class=3D"">2024-12-26 16:17:45 [16002.115372] =
CPU: 2 PID: 14375 Comm: rmmod Kdump: loaded Tainted: G =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;W &nbsp;&nbsp;E =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.10.0+ #2<br class=3D"">2024-12-26 =
16:17:45 [16002.125577] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba =
Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024<br class=3D"">2024-12-26 =
16:17:45 [16002.136858] RIP: 0010:drm_sched_fini+0x3f/0xe0 =
[gpu_sched]<br class=3D"">2024-12-26 16:17:45 [16002.143463] Code: 60 c6 =
87 be 00 00 00 01 e8 ce e0 90 d8 48 8d bb 80 00 00 00 e8 c2 e0 90 d8 8b =
43 20 85 c0 74 51 45 31 e4 48 8b<br class=3D"">43 28 4d 63 ec &lt;4a&gt; =
8b 2c e8 48 89 ef e8 f5 0e 59 d9 48 8b 45 10 48 8d 55 10 48 39<br =
class=3D"">2024-12-26 16:17:45 [16002.164992] RSP: 0018:ffffb570dbbb7da8 =
EFLAGS: 00010246<br class=3D"">2024-12-26 16:17:45 [16002.171316] RAX: =
0000000000000000 RBX: ffff96b0fdadc878 RCX: 0000000000000000<br =
class=3D"">2024-12-26 16:17:46 [16002.179784] RDX: 000fffffffe00000 RSI: =
0000000000000000 RDI: ffff96b0fdadc8f8<br class=3D"">2024-12-26 16:17:46 =
[16002.188252] RBP: ffff96b0fdadc800 R08: ffff97abbd035040 R09: =
ffffffff9ac52540<br class=3D"">2024-12-26 16:17:46 [16002.196722] R10: =
0000000000000000 R11: 0000000000000000 R12: 0000000000000000<br =
class=3D"">2024-12-26 16:17:46 [16002.205179] R13: 0000000000000000 R14: =
ffff96b0fdadfc00 R15: 0000000000000000<br class=3D"">2024-12-26 16:17:46 =
[16002.213648] FS: &nbsp;00007f2737000740(0000) =
GS:ffff97abbd100000(0000) knlGS:0000000000000000<br class=3D"">2024-12-26 =
16:17:46 [16002.223189] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0: =
0000000080050033<br class=3D"">2024-12-26 16:17:46 [16002.230103] CR2: =
0000000000000000 CR3: 000000011be3a005 CR4: 0000000000f70ef0<br =
class=3D"">2024-12-26 16:17:46 [16002.238581] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000<br class=3D"">2024-12-26 16:17:46 =
[16002.247053] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: =
0000000000000400<br class=3D"">e024se+0x3c/0x90 [amdxcp]<br =
class=3D"">2024-12-26 16:17:46 [16002.337645] =
&nbsp;__do_sys_delete_module.constprop.0+0x176/0x310<br =
class=3D"">2024-12-26 16:17:46 [16002.344324] =
&nbsp;do_syscall_64+0x5d/0x170<br class=3D"">2024-12-26 16:17:46 =
[16002.348858] &nbsp;entry_SYSCALL_64_after_hwframe+0x76/0x7e<br =
class=3D"">2024-12-26 16:17:46 [16002.354956] RIP: =
0033:0x7f2736a620cb-12-26<br class=3D""><br class=3D"">Fix it by =
removing xcp drm devices when failed to probe GPU devices.<br =
class=3D""><br class=3D"">Signed-off-by: Jiang Liu &lt;<a =
href=3D"mailto:gerry@linux.alibaba.com" =
class=3D"">gerry@linux.alibaba.com</a>&gt;<br class=3D"">Tested-by: Shuo =
Liu &lt;<a href=3D"mailto:shuox.liu@linux.alibaba.com" =
class=3D"">shuox.liu@linux.alibaba.com</a>&gt;<br class=3D"">Reviewed-by: =
Lijo Lazar &lt;<a href=3D"mailto:lijo.lazar@amd.com" =
class=3D"">lijo.lazar@amd.com</a>&gt;<br class=3D"">---<br =
class=3D"">drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | &nbsp;2 +-<br =
class=3D"">drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c &nbsp;&nbsp;&nbsp;| =
&nbsp;2 +-<br class=3D"">drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c =
&nbsp;&nbsp;&nbsp;| &nbsp;1 +<br =
class=3D"">drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c &nbsp;&nbsp;&nbsp;| =
47 +++++++++++++++++++---<br =
class=3D"">drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h &nbsp;&nbsp;&nbsp;| =
&nbsp;4 +-<br class=3D"">5 files changed, 47 insertions(+), 9 =
deletions(-)<br class=3D""><br class=3D"">diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class=3D"">index =
5ff53a3b9851..510074a9074e 100644<br class=3D"">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class=3D"">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class=3D"">@@ -6682,7 =
+6682,7 @@ void amdgpu_device_halt(struct amdgpu_device *adev)<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>struct pci_dev *pdev =3D adev-&gt;pdev;<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
drm_device *ddev =3D adev_to_drm(adev);<br class=3D""><br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_xcp_dev_unplug(adev);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_xcp_dev_deregister(adev);<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>drm_dev_unplug(ddev);<br class=3D""><br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_irq_disable_all(adev);<br class=3D"">diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br class=3D"">index =
62de668e9ff8..41d1b06be600 100644<br class=3D"">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br class=3D"">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br class=3D"">@@ -2435,7 =
+2435,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
drm_device *dev =3D pci_get_drvdata(pdev);<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
amdgpu_device *adev =3D drm_to_adev(dev);<br class=3D""><br =
class=3D"">-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_xcp_dev_unplug(adev);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_xcp_dev_deregister(adev);<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_gmc_prepare_nps_mode_change(adev);<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>drm_dev_unplug(dev);<br class=3D""><br class=3D"">diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br class=3D"">index =
d2a046736edd..be9147eb8308 100644<br class=3D"">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br class=3D"">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br class=3D"">@@ -1508,6 =
+1508,7 @@ void amdgpu_driver_release_kms(struct drm_device *dev)<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>struct amdgpu_device *adev =3D drm_to_adev(dev);<br class=3D""><br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_device_fini_sw(adev);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>amdgpu_xcp_mgr_fini(adev);<br class=3D""></blockquote><br =
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
display: inline !important;" class=3D"">Suggest to move this inside =
fini_sw()</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>pci_set_drvdata(adev-&gt;pdev, NULL);<br class=3D"">}<br =
class=3D""><br class=3D"">diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c<br class=3D"">index =
e209b5e101df..62dd5287808b 100644<br class=3D"">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c<br class=3D"">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c<br class=3D"">@@ -283,6 =
+283,33 @@ static int amdgpu_xcp_dev_alloc(struct amdgpu_device =
*adev)<br class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return 0;<br class=3D"">}<br class=3D""><br =
class=3D"">+static void amdgpu_xcp_dev_free(struct amdgpu_device =
*adev)<br class=3D"">+{<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct drm_device *p_ddev;<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>int i;<br class=3D"">+<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(!adev-&gt;xcp_mgr)<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return;<br class=3D"">+<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>for (i =3D 1; i &lt; MAX_XCP; i++) {<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(!adev-&gt;xcp_mgr-&gt;xcp[i].ddev)<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>break;<br =
class=3D"">+<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>// Restore and free the original =
drm_device.<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>p_ddev =3D =
adev-&gt;xcp_mgr-&gt;xcp[i].ddev;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>p_ddev-&gt;render-&gt;dev =3D =
adev-&gt;xcp_mgr-&gt;xcp[i].rdev;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>p_ddev-&gt;primary-&gt;dev =3D =
adev-&gt;xcp_mgr-&gt;xcp[i].pdev;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>p_ddev-&gt;driver =3D =
&nbsp;adev-&gt;xcp_mgr-&gt;xcp[i].driver;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>p_ddev-&gt;vma_offset_manager =3D =
adev-&gt;xcp_mgr-&gt;xcp[i].vma_offset_manager;<br =
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
class=3D"">Now that there are more calls, this doesn't make sense here. =
What about</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">moving the =
redirection along with register() (I guess it matters from</span><br =
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
display: inline !important;" class=3D"">that point onwards) and undoing =
it (restore back saved values) along</span><br style=3D"caret-color: =
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
class=3D"">with deregister()? With that, there won't be a need to have =
registered</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">flag. You may =
only need to check if xcp rdev/pdev is not NULL.</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D""></div></blockquote><div>Good point, this makes code more =
clear.</div><div><br class=3D""></div><br class=3D""><blockquote =
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
text-decoration: none;" class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>amdgpu_xcp_drm_dev_free(p_ddev);<br class=3D"">+<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>adev-&gt;xcp_mgr-&gt;xcp[i].ddev =3D NULL;<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>}<br =
class=3D"">+<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>adev-&gt;xcp_mgr-&gt;xcp-&gt;ddev =
=3D NULL;<br class=3D"">+}<br class=3D"">+<br class=3D"">+<br =
class=3D"">int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int =
init_mode,<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>int init_num_xcps,<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>struct amdgpu_xcp_mgr_funcs *xcp_funcs)<br class=3D"">@@ -310,6 =
+337,13 @@ int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int =
init_mode,<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return =
amdgpu_xcp_dev_alloc(adev);<br class=3D"">}<br class=3D""><br =
class=3D"">+void amdgpu_xcp_mgr_fini(struct amdgpu_device *adev)<br =
class=3D"">+{<br class=3D"">+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>amdgpu_xcp_dev_free(adev);<br =
class=3D"">+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>kfree(adev-&gt;xcp_mgr);<br class=3D"">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>adev-&gt;xcp_mgr =3D NULL;<br class=3D""></blockquote><br =
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
display: inline !important;" class=3D"">Thanks for adding =
this.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
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
text-decoration: none;" class=3D"">+}<br class=3D"">+<br class=3D"">int =
amdgpu_xcp_get_partition(struct amdgpu_xcp_mgr *xcp_mgr,<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;enum =
AMDGPU_XCP_IP_BLOCK ip, int instance)<br class=3D"">{<br class=3D"">@@ =
-359,12 +393,14 @@ int amdgpu_xcp_dev_register(struct amdgpu_device =
*adev,<br class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ret =3D =
drm_dev_register(adev-&gt;xcp_mgr-&gt;xcp[i].ddev, =
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
style=3D"white-space: pre;">	</span>return 0;<br class=3D"">}<br =
class=3D""><br class=3D"">-void amdgpu_xcp_dev_unplug(struct =
amdgpu_device *adev)<br class=3D"">+void =
amdgpu_xcp_dev_deregister(struct amdgpu_device *adev)<br class=3D"">{<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>struct drm_device *p_ddev;<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>int i;<br =
class=3D"">@@ -377,11 +413,10 @@ void amdgpu_xcp_dev_unplug(struct =
amdgpu_device *adev)<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>break;<br class=3D""><br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>p_ddev =3D adev-&gt;xcp_mgr-&gt;xcp[i].ddev;<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>drm_dev_unplug(p_ddev);<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>p_ddev-&gt;render-&gt;dev =3D =
adev-&gt;xcp_mgr-&gt;xcp[i].rdev;<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>p_ddev-&gt;primary-&gt;dev =3D =
adev-&gt;xcp_mgr-&gt;xcp[i].pdev;<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>p_ddev-&gt;driver =3D =
&nbsp;adev-&gt;xcp_mgr-&gt;xcp[i].driver;<br class=3D"">-<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>p_ddev-&gt;vma_offset_manager =3D =
adev-&gt;xcp_mgr-&gt;xcp[i].vma_offset_manager;<br class=3D"">+<span =
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
style=3D"white-space: pre;">	</span>}<br class=3D"">}<br class=3D""><br=
 class=3D"">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h<br class=3D"">index =
b63f53242c57..be22d4398463 100644<br class=3D"">--- =
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
</span>struct drm_device *rdev;<br class=3D"">@@ -155,6 +156,7 @@ int =
amdgpu_xcp_resume(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);<br =
class=3D""><br class=3D"">int amdgpu_xcp_mgr_init(struct amdgpu_device =
*adev, int init_mode,<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>int init_xcps, struct =
amdgpu_xcp_mgr_funcs *xcp_funcs);<br class=3D"">+void =
amdgpu_xcp_mgr_fini(struct amdgpu_device *adev);<br class=3D"">int =
amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int =
mode);<br class=3D"">int amdgpu_xcp_query_partition_mode(struct =
amdgpu_xcp_mgr *xcp_mgr, u32 flags);<br class=3D"">int =
amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int =
mode);<br class=3D"">@@ -168,7 +170,7 @@ int =
amdgpu_xcp_get_inst_details(struct amdgpu_xcp *xcp,<br class=3D""><br =
class=3D"">int amdgpu_xcp_dev_register(struct amdgpu_device *adev,<br =
class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>const struct pci_device_id *ent);<br class=3D"">-void =
amdgpu_xcp_dev_unplug(struct amdgpu_device *adev);<br class=3D"">+void =
amdgpu_xcp_dev_deregister(struct amdgpu_device *adev);<br class=3D"">int =
amdgpu_xcp_open_device(struct amdgpu_device *adev,<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;struct =
amdgpu_fpriv *fpriv,<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>&nbsp;&nbsp;struct drm_file =
*file_priv);</blockquote></div></blockquote></div><br =
class=3D""></body></html>=

--Apple-Mail=_2CAB3493-9B0D-44F5-9052-52A0C731BE92--
