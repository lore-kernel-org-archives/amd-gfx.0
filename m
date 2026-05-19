Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B648CD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 03:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1927E10EA33;
	Tue, 19 May 2026 03:13:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vx9unsqh";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012044.outbound.protection.outlook.com
 [40.93.195.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C35110EA33
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:13:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/6+/C8sIw4wmSkEmwFz90qFkp+Rsg7bp7tOVARft1QqWWVJECHKN+4hlETeA4DFItYaIz5Z2lSOatjSMyN7D7kgRQd/EqtjPLe2lrb/xlgviilsqR3fJR6sMpnb22lE2UyNC5MkVfQaARU3kH8IINrfkcndCCdLpXJ9suEYwR6PMhhv96fuXZ6MX2i7HV3EqjQ3atOYCxrGGYNXl4/WFex39jHgpTS00vIkqz4hWUtWJuAEDKlqEbVf7FTBJUWfqq8nNfYpw2XRU261CZQfubtbRD05Xt8e91olzjeAYLzvgYdJs4Eg2WfTqtnC8bw8p2WqhTobqhWTdkCK+faRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rowk5EsaFwydIdSeJzzyaMYiQIaA6tRnJTVD0cFb0gM=;
 b=KJrf2h69/WMGTgnhxfTOz9UWCfAzn6vfm+VyNeR5uNyTN0V6rZ2Nnd3E6m+TvX949tZmbcv2Xs5L1bqfnCGWyDLXWWOQEHK+JKRDFoNJ6eFO0it/0mAJ1BegV+O+bCtoeknBQIYN5i6azfgoJOdayH33PPHStZXZxE5sdm/9DhEv4GWJDC9VRwcYSsLKKfO/kLErnH7E1v7d/FEYpK1rgJdtD54nvo72Gncv/3nQSkfgSzAzRjReRk79qTaoTaoGuICCI343cVwU8xXo9ZL9uzBoKgkBF0rXztHBqPfwOxvq6ORKdHBd6FlLYb/xo0pHw+FoAm6UUtUU+P1pYJ/NAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rowk5EsaFwydIdSeJzzyaMYiQIaA6tRnJTVD0cFb0gM=;
 b=vx9unsqhr0sTCYn5OndNTurFHTL26TBaNP6j8i7llz0fxw6AdbmpUnhgIO1ntYViMHp3v2SQhZfOcbokHmiFB2M7OoNRjKD1GMx+n5Qq02Ei/TWBPKNg0Ea6RZiFNpyQfRbMVKl6l5ThDzIhr7TaG56LO2CKJbaZ8zI8SxAClTI=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH7PR12MB8154.namprd12.prod.outlook.com (2603:10b6:510:2b9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 03:13:07 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 03:13:06 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH 7/7] drm/amdgpu: check and drop invalid bad page records
Thread-Topic: [PATCH 7/7] drm/amdgpu: check and drop invalid bad page records
Thread-Index: AQHc5pc6Qxihorl370+nyFlqyIwOLrYUrQLQ
Date: Tue, 19 May 2026 03:13:06 +0000
Message-ID: <PH7PR12MB8796B898AEBCBBA5568F7A80B0002@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260518072215.3647120-1-YiPeng.Chai@amd.com>
 <20260518072215.3647120-7-YiPeng.Chai@amd.com>
In-Reply-To: <20260518072215.3647120-7-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-19T03:10:50.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH7PR12MB8154:EE_
x-ms-office365-filtering-correlation-id: f60e4ed2-4ae9-4509-fabb-08deb5548c47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|11063799003|4143699003|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: u6IbveqSs77f8SFeqUVWwZ/p808/WX+HZGGoy203hXUplY5FRDNzi+oHe9WoaFCQseX8CwMBDI7l+gEXrE+N1impUPEFA/+CItBrV2Hk1uBHx3uBJP9iqpbZHBrX3Y4tH3exDYKjsSXAAKJQO8/exZk0jlhFtkuT0P7fiM4a6znKCKUDO6PJN64cDP0V4RtRPPqkGEuTUIedJY0ZAimbIjI/iN3K0pxq0x2wFpZXUSFtxXYabiNQizAE+INr+75Oow0eZ0JJwF1tYESTAhy1EprDfFg6Ar6XFoTNJ8ne455NKyJWtoPTNPBCqIlNb/IjOrlTqWD2/ZoHAGp2/9/QSLrNdATnqqqFkr7ha9UAcI8dzzYJnxvDMTJQQKAwDTSagiTVEk003+hFObJqb8lga47WgCmGi/nV/PF7Dzk5CJfJg2643JeS/EuunZXN7WkHltQsu1CyEwGaCps82/kCO+k6Qv4X3+E6fH6B2rgpuwSm4FKitswlQyvc46+/ag3vNxRyZhrPmiYh85z2twkzASJ5He4Ee2iZS55Q4B7RTm8oHXPSxWwUS4vds04/BwkoD9C8Okf6Q0tkuRyjG7rYiYG6i7GT/rq8ushpm2tMwDqJ05FmwIaraanZ6zMx7BMASKBCzUqAUn3x3qh3eDb7ZnqpGrPTiZBMFkvsjjflm/MyZgRH+ef3t2OJPgggqvMfDN34Sg7YkjEFsVQSVaelJZXCgeDdIkisE4A/KhBs3xRdKn1z9SGM79gvGxU2jS+2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(11063799003)(4143699003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SrYIPXU6OaSQIMUJN6WphWwgfln50h+c1/yqDOTDByrhCiVj5VNdMPsV93Vb?=
 =?us-ascii?Q?JYDLKIjEegBScyS7VQxYfPqtOj/eh1izwot/yJzDwKq3LtnpzBBWOM5auw/0?=
 =?us-ascii?Q?CHOsFleROmS7vWopRiqzcklAnYUMsfTzDpWqJ45yoa6ip4jsG2Q4336iM+Dl?=
 =?us-ascii?Q?5UvAR08rUjDR+4gzPYn8IvOaByCtlBvL/VCy+rEK3+n8Z4OV13Mt+XmViaNi?=
 =?us-ascii?Q?FyQuY2UrUFPDysDz+7S5m4QWuPdXxN9eqOZg6xxJjMwWd1vstR8hBCFzTZto?=
 =?us-ascii?Q?QoAbZwrXN6gF3lLskX3vm/Mus1GckwKpb9RorBuN5SkDRf6pBYnovF7UlgzZ?=
 =?us-ascii?Q?qxy/yJLLr7bZupFqQBgx/d6akddiB84IbwDJI0Byo5FOTXuFu2refSi83I9i?=
 =?us-ascii?Q?Qf+RrHpgFYll4MWCqvYfuADwwiFUjK/q1zD68SiG59EEUA9D9kL+0xJQJANc?=
 =?us-ascii?Q?H8cM9EL5XoNHTX7qdk8rWJBnWzF03LT24wDVQPKLUKONVNs0ofgr9UfjTbAx?=
 =?us-ascii?Q?FwaUMuZetsOpWEGofeAo990q5vmWhHvATIT54/p2R8Rpp1iXVx2XwPWOma9+?=
 =?us-ascii?Q?1moE3kznYfBtRnrKLrzuccMIBz2aeDlayC/mArR/2Dyc/+D5Pxjk7lansC9j?=
 =?us-ascii?Q?kSokY6ElkUCSNwtbG+9OUF1FQuLE4H1xUlfmboEqwn6wpkPova8TL4xaHYhW?=
 =?us-ascii?Q?5O01QXSP7MrEpFJ8XpHel6xm72amOayf1vFAMpG5t01Bx6ECK6B2OYA7OAQ3?=
 =?us-ascii?Q?oHGfP2PjNr/pErF9wqjqV7oCg8tDrcj7vlWBDM3IZU7WgyMkzQmWTa5y1iMJ?=
 =?us-ascii?Q?yoE3J0mBtM2sRI3XFrgzPMI11g3SOEbY5GPLCbc1qQ7HHWg9lplYcrhTYQql?=
 =?us-ascii?Q?wv03IWkHGkmijqskULVCQCLBDYtY1UhAzty5S4V6Vinr1nbQ9DITZyj8B7T4?=
 =?us-ascii?Q?mvTAemxRJy2dVC+36KaDYSpsgK0tYXqTvZSwnMd9HSgd8a0Sd7w0L501rmrY?=
 =?us-ascii?Q?NIljmZUCIKEbR013/xDxYuWCXfvZq3ZtlopHGd6oIoOQ848Y/m4ghTU8W5qG?=
 =?us-ascii?Q?O7MrnsNkqCH9NacvRJLD8IjOu3RWu5D9xu9oqU5FCbECY6DW1K6XRZGG4soh?=
 =?us-ascii?Q?bcmAr2JyjhxK03/3Qft0gFdRsbaw+e2hp0+egtpsbomIpHI7ILfjGHKlVw25?=
 =?us-ascii?Q?iFt/d4UfZuZYluJuc9hzZHGkT+5uVPaAKlKzCZO9abNbugMaXL+gFzOV3rj7?=
 =?us-ascii?Q?RPqjv1JJSUqmL8NV4yR+6XtcojSVaT1dozXx3aS/tuBEpd3aOV+I3X0RPAWP?=
 =?us-ascii?Q?Cp8ZPT02BSQ8oXE5UvVqlt4aP1kzJlvrBEniTwRRkoPV6s/4FEfMuyg++in+?=
 =?us-ascii?Q?CbEHrhMm6BQCQ2PWQEdI4I0w8KWoHtxIXp9lR1MZ+ZeJZIR3qiRWIfRlasyy?=
 =?us-ascii?Q?/pS2IKtU5grsIuXJnD84HzhcLuDoofCIUjwzzldDZBVwtBq3s7S7YxowUarC?=
 =?us-ascii?Q?wxAvnK9IMAbV6B7DGqduzOGitd9yJozBq+4Z3eIXM3TERRm9o7Aiq3bJSBzG?=
 =?us-ascii?Q?kkY228bQxULdHaikjf3P0EMzXz1hH0005oe1hT6yh26JLjzIftjmU5tEBeKn?=
 =?us-ascii?Q?5W3LC0L0lGaKWhSetfBPNo654je6Lt28kY0uj+QC9kHClIp6XfLVpiR5aew8?=
 =?us-ascii?Q?dDICxVqxcUjDsmbTZ5M3XH8Tgtz+nOvpjLeVtpzvjhOXWBMr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60e4ed2-4ae9-4509-fabb-08deb5548c47
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 03:13:06.8521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ya9865xoAWniSIl2fRZQ6t7AvPr1r67NQ4FPa+KhJNUj7NqfF8brI24yaU1njBLc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8154
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

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, May 18, 2026 3:22 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 7/7] drm/amdgpu: check and drop invalid bad page records
>
> Check and drop invalid bad page records.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 27
> +++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 57f13ad5605a..b0ef0800b380 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3094,6 +3094,20 @@ static int amdgpu_ras_mca2pa(struct
> amdgpu_device *adev,
>               return  -EINVAL;
>  }
>
> +static bool __check_record_in_range(struct amdgpu_device *adev,
> +                     struct eeprom_table_record *bps, int count) {
> +     int i;
> +
> +     for (i =3D 0; i < count; i++) {
> +             if (bps[i].retired_page >=3D
> +                 (adev->gmc.real_vram_size >>
> AMDGPU_GPU_PAGE_SHIFT))
> +                     return false;
> +     }
> +
> +     return true;
> +}
> +
>  static int __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
>                                       struct eeprom_table_record *bps, in=
t
> count)  { @@ -3101,6 +3115,14 @@ static int
> __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>       struct ras_err_handler_data *data =3D con->eh_data;
>
> +     if (!__check_record_in_range(adev, bps, count)) {
> +             dev_warn(adev->dev,
> +                     "Recorded address out of range: 0x%llx, 0x%llx, 0x%=
x,
> 0x%x\n",
> +                     bps[0].address, bps[0].retired_page,
> +                     bps[0].mem_channel, bps[0].mcumc_id);

[Tao] can we move the log into __check_record_in_range(adev, bps, count), a=
nd we could print out the info of bps[i] instead of bps[0].

> +             return 0;
> +     }
> +
>       for (j =3D 0; j < count; j++) {
>               if (!data->space_left &&
>                   amdgpu_ras_realloc_eh_data_space(adev, data, 256))
> { @@ -5642,6 +5664,11 @@ int amdgpu_ras_reserve_page(struct
> amdgpu_device *adev, uint64_t pfn)
>       uint64_t start =3D pfn << AMDGPU_GPU_PAGE_SHIFT;
>       int ret =3D 0;
>
> +     if (pfn >=3D (adev->gmc.real_vram_size >>
> AMDGPU_GPU_PAGE_SHIFT)) {
> +             dev_warn(adev->dev, "Ignoring out-of-range bad page
> 0x%llx", start);
> +             return 0;
> +     }
> +
>       if (amdgpu_ras_check_critical_address(adev, start))
>               return 0;
>
> --
> 2.43.0

