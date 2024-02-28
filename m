Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690F3C5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 16:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3A6B10E28B;
	Wed, 28 Feb 2024 16:05:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NcIAlLSw";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CB4710E28B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 16:05:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8rKKtoK8X9O3Y074U0YuaCC9FKwfaSIjSs2rycJAFhwVyTBqgwHzToP4V2rac1hvOLMspOf/icoVH5dIbqtvoWjAF1U0mipzxlkwZjmpJp6P0W+sKQA90sPLtVRQkNjFjimnObOgQSyCd9qtGtqOf4ruiAFe662iEHTn8UD5Ig6KisDwVhar9d49/vzR6UVvepzm+i3EZzJK6md8vMdd2lJQmHt+aVJTQ9/XMpk8eEw2CXv0mprtiln0Ls5cp9AHsn61OBQu2V4VViFTVlkuVnWhWoLD5a1fklgIKK4dilazYo2zo7zMNVUvMTIY8cMHb8lKpF6UJRErEfTudmKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6zoxULmvoRGti3/XCuytcGM2DkuoStLXjxgqWITWXw=;
 b=lOVIorbqbPbheQ8tpRV8j8rXWCWg6/2y7JkXjEK/OS0TeP/s2TKvNMWALR4lLctKdkuzPovvRYlzRCLXFnqdehia1rcKm6qO0D1NLn5tAaVhckhOF0Eb1cFzcF2VSD8NjD2pwJIwkluBGnlGiTdMpk+zjt5+Il6Js46umgAWlJS184IxrN7YsAP9+dLYyq2arUxmLaJ+cx97Qzfe4qjDWOiewGVRwTj6v/ZGl+xFXF7IoQs0FjFh7wSwq9WiqTxaESBwP1mm518/wgGUDivi5k5JIsNUd3p5Q+per3DyQUkgUDbH/1V4JRiN87CnQNnCL6jUSCKUEk6JbzVlc3AqtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6zoxULmvoRGti3/XCuytcGM2DkuoStLXjxgqWITWXw=;
 b=NcIAlLSwPCv5dG9WPnWS/KraLbQ4n0tqld+NXGRog+okPbWSFKXa2MfWdlyW1LNJCZYcYdWFGK8k3t5wmL54UC0f3MOW01SdOms+bp7n38h8fjq11oENTzWApa0Jey6It7CNvNHsYzw1Bq+pPUqJ5x8CYTj9zGdXsUB5T4lXFrY=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 16:05:35 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::1d05:912f:c481:44b]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::1d05:912f:c481:44b%7]) with mapi id 15.20.7316.012; Wed, 28 Feb 2024
 16:05:34 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
Subject: RE: [PATCH] amd/amdkfd: remove unused parameter
Thread-Topic: [PATCH] amd/amdkfd: remove unused parameter
Thread-Index: AQHaallQCrnR9CA4NE+Tmni5KXgevbEf6yEw
Date: Wed, 28 Feb 2024 16:05:34 +0000
Message-ID: <CY8PR12MB7099C06E1D34C7FB353FF3608C582@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240228151727.102002-1-jinhuieric.huang@amd.com>
In-Reply-To: <20240228151727.102002-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4e93ead2-9749-441b-8319-2fec7749764c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-28T16:05:14Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|BL1PR12MB5046:EE_
x-ms-office365-filtering-correlation-id: f259a9db-78c9-4653-cdc7-08dc38771892
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1EL57G24Z83Xq/Q06QheUB4Rr1hKTwcciDaXQQNIcRG9g9bwy1awqxGozTF4oacxcHldls8briwnbO3GaGzcvvwU226I1BDAeYJSfZEvgZOCFPilaWB2W7CdY+WXJxztRGeI/6l/GSJQ43Gi0riBiXAHNIvspyRHNm59vQMhRzNkD6kzQ4wQdfvUWAW42RGVIMO6whdNiF7Utdm36YKXgeZNUFsqwkh8Z1rM9XlqOrgq+AI7eSENfncGoSBBulyWxtdL4YCpgO1Cpy4BxgW13HiNLcZBYUjcs6tH4KlrnIKZEn5uu4HZgavGd4AREAooRDn0O3pNdaK8vBWa2hyna/lE8iU44j/pAjYDHpYWtk0ncHPb/Cy798v3rR1DQcTauS/9qK/R2J0tRl/WP+/JkmWbTimrCpTA1ucjkIYxzMFzf9AmOoWotYDJ0glC1yzSsbhB3lcmvcTnNRlKQ1gLtLQd6GoExCnij9aKzTn7OMwEJOX8U7RyTBNuI0njmTC5ZWBE7Y0VFs5ZdQbiv6hxJajLCHBEDgEmQt+ES94lxiTfAKfNUO2dJEjzBMPf/S2DM0kaOnfDsrMRnBHox9lLSXctjXxiA78jEqawcVyHYGi6i471cP8w9FzKtLlnuQ7KkPTVEhmxQZbU+3t43pk7E5YJ2dZEQPj2LjGEl20ObAiXm0o880GEN10ooiQ4wgyh80AhngUFMxD71fyM12aHAVouCcpN9lRPJ3ZSIIprxaQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?adlzjYkGVit+aUSVTpZ4as9E6AdcLXTqG1jDqJjU8w+I0KO9vwFhfmiiooOk?=
 =?us-ascii?Q?JaWmkYA7+GrwGwFz6bNOr0EC+oxm4XPN2LWVRzVl1AgAdieXcQNPvfQAwyMF?=
 =?us-ascii?Q?B+P5/QMuCi4U9aoK22cqXRrmMnx+yTlni2LkECmkiWndAizfX/g85p/IKuLR?=
 =?us-ascii?Q?eLxD/7juxLavzI2+mAFE0RxxxCtETw4QrKc6dNaANpxyD36ZNxJv7Tzk8r51?=
 =?us-ascii?Q?hI1i1aB5WxWmqJDJkpB5IuOYnG+1xW5eLLXsrJ+lalWlTGTjSZZo3sMI3jm2?=
 =?us-ascii?Q?+j1I8/UnViwyQz59QoUBtOI2Rrx942OxxuN0ngoX5YxR04efvK1JCjutkmMz?=
 =?us-ascii?Q?gjrDr90eNVutlPFpqpcljdWmllpiLlMIFDy4pngOQcTtSMIHGBUlX5h2aVwg?=
 =?us-ascii?Q?k0+tkZboS+kW5RKsrg7bbUFfEHqWr/IujCVXrrBeiThqAqXaVLWyPCpEixJm?=
 =?us-ascii?Q?U5djrKzpX14u+sw57zvrr9EkhkHhNTS++GvYjoWBq6brCbflhro/6sPUQeHE?=
 =?us-ascii?Q?Aa/jQ9qNqcfWaRn72Fu6mt9C+Mocdf8a/zfQZOPHNcvGL5tp1wHavsLrc9ma?=
 =?us-ascii?Q?JNiVhAB9HX4os/vUJ+cHD2YqD4t228bwxtIxLtyY0afoOAgMwr1KascedI+7?=
 =?us-ascii?Q?JjeA5sS3F4xj7I5Zl3Mu7RFNCexdc7fBfOcztnrnJqyheD46x3Mka44/W+KH?=
 =?us-ascii?Q?HDu71hODUL8ZmOJqzELWTKKSwIFP9O2pt5IWMkGDu/DXqeqEgYli5LPWSJ3h?=
 =?us-ascii?Q?zrEcpBCk0IHt36k92y9NNnffRmz7skhtPURVwl0hVsHsjzmmk05cAUa/3kde?=
 =?us-ascii?Q?vgHX6PC/Pcr1krtgKSWE5j+SMVtI1Vp/QoYqeIrh14MP71Yqx96NdRACfOva?=
 =?us-ascii?Q?Mxot/T54wB3nicyrNUZOMZLIL+ojtqkUo3o898SQCHeOZzLrJXEpOGaTuxQR?=
 =?us-ascii?Q?+Q2qDQyHkpmygPAma76xm4X9ZunC0uxUKR+Ud0lmGYQzcg6moR0RiT8PDY8W?=
 =?us-ascii?Q?4nzdNpy2JS2aEAP6xGNTxM2GJQZsJiyoqfQwrgGO+qVR5dJwG4DxVGD9KcwT?=
 =?us-ascii?Q?rTOJmU4ELvtw0Xo1FXB4QIa/tHU8eUhC3MHiF1awvk18XpItbsEjVBD09FEw?=
 =?us-ascii?Q?lmqbeDNSrqplJyeShLxV+NYDrK3TjVx36eyHYrHOy3jrAE3ag4I4hcA1SE94?=
 =?us-ascii?Q?RPC6TRIXKZA09HVTtHp785sp5HJLWLv46+6PI6jg2oLOwtoBETfzzS/OaTid?=
 =?us-ascii?Q?FSYjHNrYA9OM1VvTiayG6bExZXvjpnXO3rTZNegHc7TB300e0S8oyqUu1hpM?=
 =?us-ascii?Q?nS1qcmDJ60qYNkb87M4cQ3+Yao4MHA0uGh0X0g3tL8Bk81fbEC9aD3ws+579?=
 =?us-ascii?Q?3Vxlk7CW+WzXW9HS4l/GTLd9jWsCEyoPaSfFtJfH75aq1gZkdYAhpKYm2ecu?=
 =?us-ascii?Q?5uQErlN96Q2wPapFwfM5fFuvc4Wr+POlIZKJqHTWoEwdU3SdG1hIDAiujSRK?=
 =?us-ascii?Q?/PHiNNOg/38AarmUzGawJx7eGQD8agAOPBVsYM/N3n1hxoyOzAq7R2phImmj?=
 =?us-ascii?Q?Zh67DRQy4704QgUeMpw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f259a9db-78c9-4653-cdc7-08dc38771892
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 16:05:34.3990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERUeBpd5D85WGKTM+3LiKDvLSq54OYNSr1EFz/B3vGdOJMknnf2nLKWW7LhRHNQDLDNjXMjYlMVKm9Oxw5HmhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
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

[AMD Official Use Only - General]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric Hua=
ng
Sent: Wednesday, February 28, 2024 10:17 AM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
Subject: [PATCH] amd/amdkfd: remove unused parameter

The adev can be found from bo by amdgpu_ttm_adev(bo->tbo.bdev),
and adev is also not used in the function
amdgpu_amdkfd_map_gtt_bo_to_gart().

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index 4fb32d86cd0e..0ef223c2affb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -320,7 +320,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd=
_mem *mem,
                                             void **kptr, uint64_t *size);
 void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);

-int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct am=
dgpu_bo *bo);
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo);

 int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
                                            struct dma_fence __rcu **ef);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index ef71b12062a1..bf8e6653341f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2189,13 +2189,12 @@ int amdgpu_amdkfd_gpuvm_sync_memory(

 /**
  * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and increment referen=
ce count
- * @adev: Device to which allocated BO belongs
  * @bo: Buffer object to be mapped
  *
  * Before return, bo reference count is incremented. To release the refere=
nce and unpin/
  * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
  */
-int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct am=
dgpu_bo *bo)
+int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
 {
        int ret;

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 824e660283b2..f030cafc5a0a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -371,7 +371,7 @@ static int kfd_ioctl_create_queue(struct file *filep, s=
truct kfd_process *p,
                        goto err_wptr_map_gart;
                }

-               err =3D amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev, wptr_bo=
);
+               err =3D amdgpu_amdkfd_map_gtt_bo_to_gart(wptr_bo);
                if (err) {
                        pr_err("Failed to map wptr bo to GART\n");
                        goto err_wptr_map_gart;
--
2.34.1

