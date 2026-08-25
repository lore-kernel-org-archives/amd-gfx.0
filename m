Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A912C5DF94
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 06:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A896510E909;
	Tue, 25 Aug 2026 06:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eU05YbWn";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2471A10E909
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 06:27:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTdCivsX9T2obWLN1Ie6FGLpzVyvfV5rxiXivfEC7xY8orejZI+jHRYF5ScPJSZ6OAiOpeUtsobL9fKH1e/4rGcpM3HD28xSbVX1WSBxsme0hldFIfHybZtks6ELIvjDM49YQseS0lrUNnfoshlQlgWUgrGufU/6vSqiXbrfzltWGj5M685BGptGYbr9+8BAdQ87TRADU+JmAnTx+UscuclhM/gvDEArSDYcZy3N99o20g4HGTuK3qbYrYvDpZPz1ZmefljWSkoeThHsmQ5R+TAnwqhLWrpC95ibp59484+wqj2rBoKPBTh+n8lYIk9C7MZTN+X+mWqk5Xcs1NNOkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKPOv0R1hnMIs5qls7u2h7LT+gy+jvaV7nlqhzzbeaQ=;
 b=t8KuymcE73klJNn9sehoEVmC6/Dt0HlU6+kYl0qlkY1ru1jm9pKdERXKKYaDchh+2HLgzEeIaY8AzG6lgjx/NQAT12kzZYnq3SnTzrD8ftu3ZfLbeRJCdF8rkeSQ+Rrj/w4yfwmfgJl6FGCRRu72eoJsKaCOgEM58NpOe5dBWS/F4tyV2NKUnH4mGGMDma13UNGSAGEefJxknu3Eksxt1rbMPY99MkO1Z8urJ+jnqGuHKX+xSYPRyO7KWIAhdRoe5OoPRQhTwht8MW7DPB+NOb/CORtluW6oW+3gXbGK62Uu5S8UAgw8Xxl1jPQASpKnoBPDyIrb0d+3MVxip3Lepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKPOv0R1hnMIs5qls7u2h7LT+gy+jvaV7nlqhzzbeaQ=;
 b=eU05YbWnRjEVq1T4lF9knQa+MncObMRqI+gBPLhHN02IqWA3Rk7CSWqMkppQrxdeSrkZIkOQXJ/zcRXDUht5XAyxNnhf4zlCaLOJGXnrx85LB85SnVY5kyqGqmp7sQPcfPd+48GnegGrZ9xEVee5j/3rGxCweOmV4y2a4m1E21I=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Tue, 25 Aug 2026 06:27:15 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 06:27:15 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH 5/5] drm/amdgpu: move drm_client_dev_resume outside
 reset_domain->sem
Thread-Topic: [PATCH 5/5] drm/amdgpu: move drm_client_dev_resume outside
 reset_domain->sem
Thread-Index: AQHdNEnasgAlfmqTFkSUdAooFVnjWLauSlxA
Date: Tue, 25 Aug 2026 06:27:15 +0000
Message-ID: <DS7PR12MB600564F306A18118AAE04AE0FBAF2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260824233040.125300-1-vitaly.prosyak@amd.com>
 <20260824233040.125300-6-vitaly.prosyak@amd.com>
In-Reply-To: <20260824233040.125300-6-vitaly.prosyak@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-25T06:17:55.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM6PR12MB4202:EE_
x-ms-office365-filtering-correlation-id: 9007d2ee-edec-47e6-1bad-08df0271e7c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006|38070700021|4143699003|10067099003;
x-microsoft-antispam-message-info: a40UsEvijfkTbYbspTBw1+oHadcgGdmHGjQ12gapNCs1FAWnRxYs74NXcASMrYi4RXosjwd/74VsKWNWroKv8ZVWVOEVPic+cibA4v867LtXZI6WDjwx3DJRyfO59PghQ5tlkNaL2WZ5/usi5CpgDa8tJS8E0CF7NLx/e4J6HC92Z7+GxqeV2UzwaJXLMAKI9B6BcUUIO9lhO0efsvYZ/QAv0yswYx60OFpCm7eiGY222mCRlG75BvZlp7IFrm/D9Rz79XUk45ql3UetOid+vG9CRwCpM4LYIwc4tev0JAmO6y0ywmkDgaG6oNOCjrNdxrtWLs2FYP0wUYuknrj4O+ulIh1fUkAQevhYLCWISEXWbY2qKqUCb7FbuQktwgbSwRUcckHqr6Frh3Hfw3/q+/Wkso8KTC2/RuyV/dkTv6Kwh+G9BhkbyccQu212oPxNxWUSDlvuseRSYixR1vvLQyq3GVXvluwdRkSlHQGNJwTHHIpg8hXoR4h06XmrtCoVwDFdz9Fw5dXtu+G+LnqZDotYFKKY+79VjZ2oU9cVm38ZwWD91u/CB0hIr1LsCXU2hcUXlxQ9LxEHKyfhBDZC0sdBiU/ehsnmR+2FQQ9ooAYvoMw+zyX0ibEsJ88+FgimI7eG0YK6CeCuWr1b8Vd2WYPXuV0bAjqL3DQURw3SIbEjP8dPnH1CZTU4zoFvxf8/LYmyqNxqlxPkHm5J8BFTa18lcp8FAAs7sd3AfnNU4SA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AiNVqZF86vJG4Rhmbn/m5X6rcfBYdlD6ksopj///HGavBSfKjjXcGJaKtXGm?=
 =?us-ascii?Q?9s5TWh5aWUlAXNBd49eqG9o0fzWGjocqfGdOo+omyppdFSr13ozu/UhTFTpH?=
 =?us-ascii?Q?Xr+cjHaNiD0iFbiRhUDILEJ7Uvt/XoveaagW756DvC+8fQFDDAbEiCEREZT1?=
 =?us-ascii?Q?pALyJ2hBFMmM7YXQ1vqFdYBVAhJZ0mKvJCKA6LOLZSCkZhzivJbuI5gLvUon?=
 =?us-ascii?Q?3r5ufImL6sMN/NflgMnwB8Ytdr0aGVkTk1yIFqVpQKJOYeOxf973yoey1rH4?=
 =?us-ascii?Q?JvRa7YTsW5SP72ZWqQ/leuYx9peYZd3JX1owCbsjLCyQOqcB6kzCtBUIh7/m?=
 =?us-ascii?Q?gqQK9YxWVelW5hstx9SFLh81wRfUG2oxQGXN75AhH19BD+wUOQNdSlr2KB1X?=
 =?us-ascii?Q?YVnKtHQSRXbgh/HHvT5Xx9luLKLWmBLMqzj/DfIXnOFwBo8Aq2yp2kBk+JgW?=
 =?us-ascii?Q?bxkaU3OwnKG9Zl0Wz1CMccJEv1ciQOthHnWqs2gxoa+08ShIke9ZW02TJ0Nx?=
 =?us-ascii?Q?3qAA2AZWB2qBYAnb2qh5R8cPy9Kuq9G4bJKiJREMupbJdmnpSv60B9+lv3VM?=
 =?us-ascii?Q?lNNuE4WlTkp0/8vxTr1iJhhL7pUxL17RA83wDqLdqxWiPHJNk54tHMLtsHjm?=
 =?us-ascii?Q?oLo9SPZwDo+IXCaV0dXExH8L7dIcsag4joATcHs2to/ZKnGDlqAln+IY/pXP?=
 =?us-ascii?Q?32Ohdk3PSZZMf5JaUS5aNDHDMYnPHr6xIc+AqxPtSgnH7s0jwJV5yRGJ4J5Z?=
 =?us-ascii?Q?t5542A2Srso1K7TuSheonOX8+Ad9WiQxKRnltwQFHPQLjAiqtoD8Q6i9wu7V?=
 =?us-ascii?Q?1v+1pMXP60LisHrDxKYRByT3csDlwtYU9VIjMwDcIX3Xnld9im/9fsfZA569?=
 =?us-ascii?Q?QZom0Kay5aAX4GHJbobNJR9VvAQwnmU5cFsONkZHDSqjFeQbfoNuYGreDFtR?=
 =?us-ascii?Q?5dxYGHKmPq33+RBUeb/wPa18gvYKrxEKRU4oScwDA7Fu6zcxixdbXIpEzIZp?=
 =?us-ascii?Q?bbBbNSr3ktOzqzKC6ddzVk9zjQB+t6xy2ziJeeiQ4ip4mJ2XT7+afjWjaQfR?=
 =?us-ascii?Q?RQu+gwTr3wlkJw5YfS9mvYEG8DBV9G1hRhB17a1yEuNV9/2DYBg7s+ECaLKN?=
 =?us-ascii?Q?aaJ+vcf09ijGFXtx8xTrGrd0b7ohBZTRssTbD9UPfTmB2bTGqytFw3NgwaIG?=
 =?us-ascii?Q?5o1PN/RAUHQMLcDN6BpMneMNy48w8HN/B7w3JpDSaySE+gPYqkKJbD8gpGnA?=
 =?us-ascii?Q?2SDc0FRfctDFWxPIp7FysrK+vncAO2lwotKSP4cfC25cSB1OmCvAif0b0/JP?=
 =?us-ascii?Q?62TQSvFF7N9ol9lJ0heajfjBD8B6cl8UunZhnam+vYobBsEFvvMPlVE1njqD?=
 =?us-ascii?Q?3PnA8bHnAo9xmo7qV7obt3r4N/ZwiZ2mpnVp7WLVKpsdBEblv+Lq0T7ztBG/?=
 =?us-ascii?Q?deMa7CS5dHgd+r0ErnrU9mnxVQllCxNQDwTnj7+mou7+nCMVKNDp427a8YdU?=
 =?us-ascii?Q?5d36t/p+5hn4zX2sGP8+Dlh8eUwrIvxEX6u8wNEEkdhmenhwZNrFM/XO2qwo?=
 =?us-ascii?Q?y+uL7jkow5rCmAm3wgXaHwynXx1GVy/2FljY6QUHPgkRT32DgDG5ZDLa1Fp6?=
 =?us-ascii?Q?Dxb9LMdd5VKrEoZ1s9RUQHYxauXcWks+bGue0bFVVLpTir3b7h6LA72Hr5q2?=
 =?us-ascii?Q?WuKVw1UviMNiF8nH60GSkuZ8LvOLpwEbtpe1nDMnfsMhxPtF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9007d2ee-edec-47e6-1bad-08df0271e7c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 06:27:15.2775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqvkpBT99Fi9cGEjoQmsnUWN0lidyz/Rv8C4VA3pfC9VKEIZZJPlmAunGtuIgxjV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
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

AMD General

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> vitaly.prosyak@amd.com
> Sent: Tuesday, August 25, 2026 7:30 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>;
> Khatri, Sunil <Sunil.Khatri@amd.com>
> Subject: [PATCH 5/5] drm/amdgpu: move drm_client_dev_resume outside
> reset_domain->sem
>
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> drm_client_dev_resume() acquires clientlist_mutex. Calling it inside
> amdgpu_device_reinit_after_reset() while reset_domain->sem is held violat=
es the
> same ordering fixed on the suspend side:
>
>   clientlist_mutex -> userq_mutex -> reset_domain->sem
>
>   WARNING: possible circular locking dependency detected
>   kworker/u128:0 is trying to acquire lock:
>     (&dev->clientlist_mutex), at: drm_client_dev_resume+0x2d/0x120
>   but task is already holding lock:
>     (&reset_domain->sem), at: amdgpu_device_lock_reset_domain+0x1c/0x30
> [amdgpu]
>   Chain exists of:
>     &dev->clientlist_mutex --> &userq_mgr->userq_mutex --> &reset_domain-=
>sem
>
> Move drm_client_dev_resume() to after
> amdgpu_device_recovery_put_reset_lock() in amdgpu_device_gpu_recover().
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c248d589f755..30e8b1963204 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5210,8 +5210,6 @@ int amdgpu_device_reinit_after_reset(struct
> amdgpu_reset_context *reset_context)
>                               if (r)
>                                       goto out;
>
> -                             drm_client_dev_resume(adev_to_drm(tmp_adev)=
);
> -
>                               /*
>                                * The GPU enters bad state once faulty pag=
es
>                                * by ECC has reached the threshold, and ra=
s @@ -
> 5826,6 +5824,15 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
> *adev,
>       amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart=
);
>  reset_unlock:
>       amdgpu_device_recovery_put_reset_lock(adev, &device_list);
> +     /* Resume DRM clients after releasing reset lock: clientlist_mutex
> +      * must be taken before reset_domain->sem in lock ordering.
> +      */
> +     if (!need_emergency_restart && !r) {
> +             struct amdgpu_device *tmp_adev;
> +
> +             list_for_each_entry(tmp_adev, &device_list, reset_list)
> +                     drm_client_dev_resume(adev_to_drm(tmp_adev));
> +     }

I am also working on the same userq lockdep issue, and as to this issue we =
may need to remove the DRM client suspend/resume thoroughly.

To avoid duplicated efforts on those series topic, how about align our patc=
h sets and consolidate them into a single upstream thread?

Thanks,
Prike

>       amdgpu_ras_post_reset(adev, &device_list);
>  end_reset:
>       if (hive) {
> --
> 2.54.0

