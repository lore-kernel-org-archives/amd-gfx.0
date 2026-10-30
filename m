Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC95606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 03:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nvGapIqy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C07E211262C;
	Fri, 30 Oct 2026 03:17:34 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4129611262C
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 03:17:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m68u10rJW9w5T7igk6wqK3o3X9rdW0e5S3u6tyW3tS3/Ek29i8/b177u8ybQHCXofM9tLcFTn4RXHlZcGwy29HU7c0Z2U2N5gBWbIJfzQsyj1vG3Vnc7AUjAKKs97qxWfaa4mIAUxViSerhtg2ySWsA8A3IdcqNGZptLeOk/4C10lSgwj6wltPzY/JiaYEc7l8/zezxu+iRC48dVlS9CFyK+DszmxH/beBXdOssOeiaMeFuXq4mCi6EQj/sK351aBVctb8KCUTTl/ffA1Us2wVmGYlEpnL28bfFlSqI+/3IYj93pxJaIV2SrHaaZaVOQG9uYh17vZ8+BDCC4bXzsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GtZMv7b5VI3+cIBMTsr74JHlgkBgA2ZguP8OWBmvlM=;
 b=tEl1jeeAdGQ+RWKJ1EVOSZqaZEskTORmb4DGd6U9LiyBS3pU6TUXuDVMQxR0RraDBfdBTi9DHl/xUtOBGKE1yejw7vDczK5BrpbJrTjtGhCGoNk1hUQx3JWHfVWVF91yx8y32A635+BwHJtjGg5DI3hp8RotvPga9Ew7GRKMuDl2l7rucSbVNxNwLSlvrT+sMNOhwaTJcCZYZVF5I5iu927bjmSy4v1NtkFdAqcUYv+4TvB8XkA6CZOnDvDioKtjt4JFx+tfDspVmye0fYi2vJNP6E52Xz/EIjowPRDV0jdsusmZucnAmpXdoYah+/6Lq1Jmjz3opv3A//To4eCxvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GtZMv7b5VI3+cIBMTsr74JHlgkBgA2ZguP8OWBmvlM=;
 b=nvGapIqyRjhXSrK+osyH/C8ZSEb4EKOWBFVazylUeh69h8e+rqWim9XGFJEHogU8h2WF2Nsj+KcAAFLrvhD/VguGFvEs3I7UzOcr1sObC3phOkzn4XUybUR1F21totLRrC+A8oO0I0SMplvvbJ9RCQA1x+/qtcv/R1hwECEzPVY=
Received: from MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 03:16:59 +0000
Received: from MN0PR12MB6004.namprd12.prod.outlook.com
 ([fe80::4579:c97:2cfc:1338]) by MN0PR12MB6004.namprd12.prod.outlook.com
 ([fe80::4579:c97:2cfc:1338%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 03:16:58 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: save VKMS modeset state from the system
 PM path only
Thread-Topic: [PATCH 1/3] drm/amdgpu: save VKMS modeset state from the system
 PM path only
Thread-Index: AQHdaBkb3dhkbV1XkkqVFGhc4m3VLLcVZxSA
Date: Fri, 30 Oct 2026 03:16:58 +0000
Message-ID: <MN0PR12MB6004D22657DB8E0116501056FB6D2@MN0PR12MB6004.namprd12.prod.outlook.com>
References: <20261030024747.3083509-1-Prike.Liang@amd.com>
In-Reply-To: <20261030024747.3083509-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-30T03:06:20.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6004:EE_|DS0PR12MB7630:EE_
x-ms-office365-filtering-correlation-id: d044c56d-6408-4ebd-3876-08df3634424e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006|10067099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261009223027099003|261022075727099003|261026121527099003|38070700021;
x-microsoft-antispam-message-info: PyxjMQzwAqaEWdh3k6P4Qc/6utNbkfOAsKsybFlrUkmFO0GUO5g0SlhmeMQhmBjzTov7l/RnVqiYre58ltPtWFZBmfgLBLgJoDdRl3qK+i5lrOKZdSuCBoAxUekxW7KauoOeGDJ6CxoxnC9DSsEOzkSGmTP/D4LzN6SW/OY9MDZz8PRdy3OVSjIIhgdMIC/n6+fQUGLuch4VIEJlhlvg289ct0caZOEwPrg8+GhbTa2iAiqRXi7KtKTJPyaSlFIclBKo8bkkxUKaof4jjPTORpgWQnP24Jx++k8Jsj/EfcrO1d48Y4rnTb1XXYbSl5qjyv2Sog91/nBr9CDjCKhYPLGXJEkZialeIVFD5zHL0pqfd6COmAz+aLdO5Mm5QX1iSG1T3eX+6wVVAN/mAZXVO4kiFpg8ENmiRTT8Fzu5auh/eMK3nbISYawap3lZQDynzLunMXL6PeSuDW0VGf3yCWifCoBOShvkAYhhQwbUY/FE8qXgU3UjgkpgQWj9I+yznwYwUmLrS4RSgzzVg6qkFmpy5L6LC5QhzmEzFpfwRdurwnlXJ2JCggsJdqFhJlkpAEUQyWikEDc46s3WUKruK63D7qqH1DXWgPq6NcIilgkRAXwJ366C8PuJzZma6oM5l4C8WAdrkYuCZk8RSibve0oWgefpZ1+0hHzpONUbLbNkBfDAl5oEXzGwbgp0ZCqGLssmaA/li9DMyRKrmb+Lg237GxjAvYtIJqtGipRFCQ0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6004.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003)(261022075727099003)(261026121527099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?maQdgc6JiasjAVf6uhsDCwbJn1eKULLsB/FejT89rNXbTX/QTZcp64db1Tkq?=
 =?us-ascii?Q?XfapUo6bLT96eC/Bn+Jm1BgheLl2ProcQvj+m76hwGuhMB3yyKDC4kqUuybp?=
 =?us-ascii?Q?DlIXw5kqiMaU+BCN3Sxq5rrY2GTzq42SY+FjRKdJWOelR9NxJ4MhoZLyfMOX?=
 =?us-ascii?Q?nGdGcarJ5KE2C9fR1Q8IkTO7U9yqpzzI2t8fQJnWRryDuwI8eYiRiLz4L0YI?=
 =?us-ascii?Q?Mt3JW4NILWcYeeKEicP0kBDg5WkdnGOZ1QKveqCrTSD7HWXFGX2K375D+046?=
 =?us-ascii?Q?2WAf5CidKdQY062G4Bgp7MgSk/W/6Sr6oHMEDEv1D43lYZqSz65/Ti2mfOMu?=
 =?us-ascii?Q?1sQ8KtoIFSmzUEA4lamiYP5X7BzDOwrf8c4uBUeVbT8bIAmt1QZaH5vpB4SA?=
 =?us-ascii?Q?XJei9SyGV66XWSzpQsO4hLq4uaCJnG9IvivQsVfFbIIRALkZGEk9fJtBqDBF?=
 =?us-ascii?Q?xb6n79gYcdk0OTrJuLUFqWcyt6AFC/6/cRRS8DrfiSNol7WsOg0cNCK+YII1?=
 =?us-ascii?Q?8HVKgq76BF8myfV8Iam17G2hidQeIIV+jFzMySJgcfRMr/RfMmaoca2Y3cjb?=
 =?us-ascii?Q?Wy/CRLvp8ONLW6SYboUyl/RGKubxSatai3efGEbGAzS14AMreRGyeZkb3PrD?=
 =?us-ascii?Q?/HcEzOJlWZMfCcRkC9E3FsD2p8lfSuwrBHrBBpWG6ipYIRjHlUKIC5quJjj2?=
 =?us-ascii?Q?9K7cf/zK0PqHe3B8kdqRWG5h3HhqkBFDWSu2hDh35I48sy02ccTRg+0FAJ1b?=
 =?us-ascii?Q?JnTEYCBhnX34EGirnFzQ/HtCfOkAAsgCdMd9gFspMIpt5MfcSs4CQTA6RqLh?=
 =?us-ascii?Q?jiTJ56gsCePIU95c26LnrOFKzo36lKuCzXy7F7cy3B4g4Zd6Vg7bfZ8MLW5X?=
 =?us-ascii?Q?F5ykkdC7Zh/n6ZRt4KxmxCFRp+epSQhn3iVpO4AMBgYNLwGQ4qtknmeRd+Jf?=
 =?us-ascii?Q?Xnv/3eN0cb6aRW8DJCpZgL9MpRMWgSXdYEw5Xr5aVNt5NpWxnpCal7Ltpekh?=
 =?us-ascii?Q?fjXhePPyO4E8bOypJJF4FNkVOXV0tarFI0P6627TRNnjmyypWbjAIvtR/frh?=
 =?us-ascii?Q?X4lHThvdAwTVWXz9zS4IXprIDnBebLkMjowYLAkPWxR8zeYIMkkINYSMupxo?=
 =?us-ascii?Q?wPnxMfIUf1oT1X4qhCejMhksfUPAAWe8mZkw6g+F/lgqmek2/QcYmLJfp5g8?=
 =?us-ascii?Q?CG6gSbmeSYRbA8Er42WbhdJaGktWqdPqVn3r1XPTd6wGefuiRdfFtNV549kn?=
 =?us-ascii?Q?Dm9unUHqSgWwGZx+RekFmVKkjp0CLJJKmO7e48/mrqcNww+pYVs/aEsV2oxb?=
 =?us-ascii?Q?7ER2hyKaPFCvdQTL8x0yE8uLeKWf7TIYQNUYA73oq21uVUkRPre6OqaE5MZM?=
 =?us-ascii?Q?VjlJglQln0wAuXA4cMLNctRzD/o4VOtk/xvLiGz1NSEoLYQgzkp8WEdsF95y?=
 =?us-ascii?Q?BVU7KKBUa3LZo2FEypXMzSEa7MkvM89ql9HpzP2+CgJOw4Dz3ztQMmaeN4BO?=
 =?us-ascii?Q?jnxi6/Ztc4YhCpfzMPIPidAHQNNRy7BS5m7nYfsNDr+kjBd7E71PEmBZkLf9?=
 =?us-ascii?Q?e5TW0iAa21ukXTpIAwIzSV3nieAwH8jZ0/2ysBKs3u72dCljosSCtVdugkPE?=
 =?us-ascii?Q?Ftre9qi5K+Ags2AmbRCL8blCA6a/ShPzMRwCFb3lCSBQmBiLAytCA2VoBXBl?=
 =?us-ascii?Q?hswYiPfFd839VFqDvjiSiHGc/kUKlUGVPGkoGEW4fa2HhLJ7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6004.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d044c56d-6408-4ebd-3876-08df3634424e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 03:16:58.8473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YaaCorLpFrneXJbiM8cGrz1qrHrmwla1zMEaOveRSmaFV6OLMX2SiIjivnXfV9PZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

I somehow missed Mario's comment in the previous email thread. I'll update =
the patch based on his feedback and then commit It accordingly.

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Friday, October 30, 2026 10:48 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Prosyak, Vi=
taly
> <Vitaly.Prosyak@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Li, Sun pen=
g
> (Leo) <Sunpeng.Li@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com=
>
> Subject: [PATCH 1/3] drm/amdgpu: save VKMS modeset state from the system =
PM
> path only
>
> amdgpu_vkms_suspend()/resume() are IP block callbacks shared by system
> suspend/resume and GPU recovery. Calling drm_mode_config_helper_suspend()
> and drm_mode_config_helper_resume() from them makes GPU recovery take
> clientlist_mutex and the modeset locks and duplicate the atomic state whi=
le holding
> reset_domain->sem. Lockdep reports:
>
>   Chain exists of:
>     &dev->clientlist_mutex --> &userq_mgr->userq_mutex --> &reset_domain-=
>sem
>
> VKMS has no hardware state that a reset can lose, so the reset path never=
 needs
> these helpers. Call them from amdgpu_device_suspend()/resume() instead an=
d
> leave the IP callbacks with only the hardware init.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Cc: Sun peng Li (Leo) <Sunpeng.Li@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c   | 14 +-------------
>  2 files changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3ced5c18daaa..65c60b47189f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4570,9 +4570,16 @@ int amdgpu_device_suspend(struct drm_device *dev,
> bool notify_clients)
>
>       amdgpu_ras_suspend(adev);
>
> +     /* VKMS modeset state is saved here, never from the reset path */
> +     if (adev->enable_virtual_display) {
> +             r =3D drm_mode_config_helper_suspend(dev);
> +             if (r)
> +                     goto unwind_smartshift;
> +     }
> +
>       r =3D amdgpu_device_ip_suspend_phase1(adev);
>       if (r)
> -             goto unwind_smartshift;
> +             goto unwind_vkms;
>
>       amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev-
> >in_runpm);
>       r =3D amdgpu_userq_suspend(adev);
> @@ -4620,6 +4627,10 @@ int amdgpu_device_suspend(struct drm_device *dev,
> bool notify_clients)
>               return r;
>       }
>
> +unwind_vkms:
> +     if (adev->enable_virtual_display)
> +             drm_mode_config_helper_resume(dev);
> +
>  unwind_smartshift:
>       rec =3D amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D0);
>       if (rec) {
> @@ -4719,6 +4730,12 @@ int amdgpu_device_resume(struct drm_device *dev,
> bool notify_clients)
>               goto exit;
>       }
>
> +     if (adev->enable_virtual_display) {
> +             r =3D drm_mode_config_helper_resume(dev);
> +             if (r)
> +                     goto exit;
> +     }
> +
>       r =3D amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev-
> >in_runpm);
>       if (r)
>               goto exit;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> index d6b51b3f216b..6de33f14d909 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -488,24 +488,12 @@ static int amdgpu_vkms_hw_fini(struct amdgpu_ip_blo=
ck
> *ip_block)
>
>  static int amdgpu_vkms_suspend(struct amdgpu_ip_block *ip_block)  {
> -     struct amdgpu_device *adev =3D ip_block->adev;
> -     int r;
> -
> -     r =3D drm_mode_config_helper_suspend(adev_to_drm(adev));
> -     if (r)
> -             return r;
> -
>       return 0;
>  }
>
>  static int amdgpu_vkms_resume(struct amdgpu_ip_block *ip_block)  {
> -     int r;
> -
> -     r =3D amdgpu_vkms_hw_init(ip_block);
> -     if (r)
> -             return r;
> -     return drm_mode_config_helper_resume(adev_to_drm(ip_block->adev));
> +     return amdgpu_vkms_hw_init(ip_block);
>  }
>
>  static int amdgpu_vkms_set_clockgating_state(struct amdgpu_ip_block *ip_=
block,
> --
> 2.34.1

