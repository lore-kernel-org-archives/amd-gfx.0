Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17458E7717F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2024 09:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4E510E550;
	Mon, 16 Dec 2024 09:25:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zcHrQ1ZU";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4FC510E550
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 09:25:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3hqzwC6XWmBmQVf0ohm7ZG4db+JRl/pOBJ5F9rXhtvBjYqKwM4zFGyJN5O0WgO2TM54qpQNGZc/3TaumOSOM9fs8rtp04fPb+GfoYmY1FNr2qJspdms2ihpXJl9fl98knGAFi1qotUTyCFeRIzel+E3EnL9YvJ7yBnxOduI+fmYYChvxpib6PHedIDBf08X004Fghg1LaIvYQTFRo5cdQUqCqtwsOqU6e+timsnHV7Iwu91kS8SARnzFwIarAj+G/iGIceIVSMKSsuBIb86qkLF0/mXCN8HB7jmQya7w8ze/fu2UQcfVZwDi9ypD4sOK6bAzsvsdgU+QvXa8KvpHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XV1TutQJfXvZuPavPN8cGE3SwIz9uAkZHeC+jizJWqM=;
 b=XeL6U37IL9LzEoDTyXHbQLHmGmtZiV2fue3mcfFzHV9soy2bTAA2/PMdlyTYiJyw0HC6mqYpEu+Fba96A4Ld6/tvkxo/Oie9T0Y/yjvF8DRHM3CnAxhpaoc5mS0Tbuhn0+TgdEXuMEJmGD/lSphBq1eEERhxvQoKzxxSezYIf+iEaCZvfv+IX3hgsvjjGm68kPDwjnxbE2brb9W4cwz5ZKwwGeG3iVtmxJs6Ki3c0ck+lzowcBWycomaI0UVpgiN+bcu15snu01yNmiTSPxzsbsg+IZrG61v/i9QUJdcOuR7oYbpNqaIQBwtlXr+GOQoN5tuXMpDS3yk7U5QRNUcxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XV1TutQJfXvZuPavPN8cGE3SwIz9uAkZHeC+jizJWqM=;
 b=zcHrQ1ZU69GxAHTk4USsMrJgLzTmL42P3IewWYDrhGdiTnriv77nwJ7WdGq5OxFUjCxu0ha72ygTMJgrQWY2XmrLAgAuJNGgpwmN8l0LixYQhkqiIH4RZzoYZe+5QF6LsoroFCp1Xy/IMTQAAjp/I942RoamuHuyqIVfyR+aIjs=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SN7PR12MB8060.namprd12.prod.outlook.com (2603:10b6:806:343::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 09:25:34 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 09:25:33 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu/pm: Implement SDMA queue for different asic
Thread-Topic: [PATCH 3/3] drm/amdgpu/pm: Implement SDMA queue for different
 asic
Thread-Index: AQHbTVPzdgnAH+tI20GCJGHLwnFP3bLojlUAgAAOuQA=
Date: Mon, 16 Dec 2024 09:25:33 +0000
Message-ID: <DM4PR12MB5152F237B1061CC53DB972B5E33B2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20241213114059.3170033-1-jesse.zhang@amd.com>
 <20241213114059.3170033-3-jesse.zhang@amd.com>
 <CH3PR12MB807402223D2E84970D6D33B0F63B2@CH3PR12MB8074.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB807402223D2E84970D6D33B0F63B2@CH3PR12MB8074.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4b98fd41-79d4-4dfb-88c4-d8e4d6701b06;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-16T08:17:43Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SN7PR12MB8060:EE_
x-ms-office365-filtering-correlation-id: a9f1adf6-bcad-4eba-8ebb-08dd1db397b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9ik7oGsha5cnLdRDRU5V7YMkqdux+ISAbgUZ7g6tLL/qV3MCv9xpO5L2AQLf?=
 =?us-ascii?Q?aAfmB6FHQPXenMBAwl/XNSWXThTl4Wq1lIn5Xd3ZGBlgYmIcAXB1x/2b02jZ?=
 =?us-ascii?Q?TufC37UJdH4fbMLm3OOjm143EFSdl3CGtwO6wcIxK29Z445dh7ozjfLLrANj?=
 =?us-ascii?Q?NofWlKMfS7jiCvmVTASrrXlGwloFECl4wnGkQ4+EYjlyPe2qvB/KDuGEdFJ1?=
 =?us-ascii?Q?kmm2vqLFF6RzJ9Ptd6CIkIgSUu6/mQL0fEeXcuFmA+oUKRkm7eQiktFB0SiF?=
 =?us-ascii?Q?SWaeZIbZSpjddy8xt4YUGTfKgBo6yFNxXufwttEH6o/Dtf5vSffJNhorlce7?=
 =?us-ascii?Q?1M98NJ0U+x0HdouUUP5chNWUh4Q5bthTzbKcr3tdn2OiD5Q29Tenwn6Tu6Fd?=
 =?us-ascii?Q?Tnb4uwehxWNh7xKBGU5WSmSRVSFruhMvHbIV/QnQlm1tK84/DBLcWwpxpWYO?=
 =?us-ascii?Q?Y6d8op4SSpFMLe5ghq5i66wMxLulmdPpEJtrSt3yqjbsCJXCKpETCdOw21aI?=
 =?us-ascii?Q?zKEUzwwDoA4Z5qUIP8zTtOYXMF3HtNZwGE9DHKDPfiGxk+iV6J7X/N5cgGtq?=
 =?us-ascii?Q?VmiN5tRVZ+o7H9wfe/KmKT+HHA3BbAkgXDxnenApS4v8c/YL4Z0QR6mNBDjS?=
 =?us-ascii?Q?/Ax9aC8gep2MZQk9KOpRG+MQUK4E9T2KAL7XGblsWK2JfD2vnnoYDTWzd4VK?=
 =?us-ascii?Q?N9WmvUH5kX0SW4P38i/v1sAnjWUIo/aLv4ngapjARSVbNBSBPGsWZ5ja35uB?=
 =?us-ascii?Q?24wchAza8d9+bhvB5N8T6To16m3mpXS6eMPueK8kmuYLfVAO9QiQZmKX68oC?=
 =?us-ascii?Q?65EOIL6gf4VnR/S/nupOXtzNd4ektYZgyQrZIQrAMiiZ4qNxK4syRRX/sAZI?=
 =?us-ascii?Q?kdyXF1WLK1RMbPQQ/ZCpLChuDV9+QywHSiV3Z3MaJkRUe3AkDbReqQInEfE6?=
 =?us-ascii?Q?sWawZOxL+X7gAOBD/vWdqQYi+OPUUysME/WgH51laimxJKvxjDLHhtuK2DX3?=
 =?us-ascii?Q?vuOPvmvjCQOyhaKeA/tJm04w/LVdfaAErFUVpCJ9jR1KO95btuIeIR6oSa1i?=
 =?us-ascii?Q?yLTHRYyl7rMrajdfh4rw7gm+ghHGCFCSQy96AuDA2S+FrKMALmb+Z6yp6E0o?=
 =?us-ascii?Q?UfXA2mg9pP/0Ts6AnoftbWmkL9yphkoZBbl6kS9HXwVPlE9vifGoWLl51v1a?=
 =?us-ascii?Q?7bhbJ71vCJjIZ/9utsXQ2yhjlBrsD6KkpmiBd4eCMbSKtF2qjdx5c3mfRq35?=
 =?us-ascii?Q?z7mU8fiLc2Zy+SQglbciV48LVAjsPK2XnSeXzS80vPE8duWXYGfRSyj4jXzg?=
 =?us-ascii?Q?hm/kXL2BqkjjOx1P5/JxdmHSn88J47F+OwtzHJv4nFIGN5ipjdJiiNSWXZ3o?=
 =?us-ascii?Q?P2zp0DcmbchE7OLqCu15UL2IfINrkSLepsz7W3J+bXinapiD1ibT49EsD/M+?=
 =?us-ascii?Q?tdx9grxeG7oZO4fdUgt7a3JMO1yTT8dz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hiv6lVY/EsbgI/VwsTtvx0vnfmVMUF8oCoFE6u1d8LLb/GIOznnud+lJSR++?=
 =?us-ascii?Q?Z5lNtOFZ9YCjx+uTwvHlSbICmdHdJXMD034jjAHXq0PJ4BZDdIxcUgcphsdT?=
 =?us-ascii?Q?r9MWz16NsOGiRHgWBJZcEZQ/1sTn9kIJA88wwsNoUu49Jsr44XqhqiIns4Ui?=
 =?us-ascii?Q?Tu3BvsEfa7g4YThuUgi5nT2pD4OMYaFwUsjqOdtUqa2/ouaPuDsCGVvhE1xu?=
 =?us-ascii?Q?V2yJCzQXvBQy5Nmcso8lRk2cZA+KbzoS8QDZjfnD/z47DzsmAosgQ/bIA1b8?=
 =?us-ascii?Q?ugTs6DSIGvqBslHpEjbczj7i/MjZxpzeGZCcRaHYmVOma5IRJfN3ay8l+t8Z?=
 =?us-ascii?Q?DFrGW+BIhuf6JgzT/BIhorIx+k05fCUtaBDl6RIamRpOSdovPtj0gpuDM58X?=
 =?us-ascii?Q?Y+2/o+qXsi4/qu+EwzYMKWUghdqv1Yr4aS2IXGyOcdmlrn9T0vebzbbYhHZO?=
 =?us-ascii?Q?3+fxLrGqFOt5q1AnSanBMIOllSYsSQ3EXIIaFczQ7XsjzX788h5dbkghp+i6?=
 =?us-ascii?Q?vJt+qbBmy1VH/MtmQ9g1p5YWCq79wj1tH9D7DKKx02P0dY3QPbsxyy1NqPRM?=
 =?us-ascii?Q?ihE/nbslhdnS9RQmqSr7sB2PK6vFNVs06FNBAKklqw62rWQrjBLkRR/mpTZh?=
 =?us-ascii?Q?SmTq7Zco+5mwfpkUU4iDONIluDS7xqx9RdAl48kJLl9dEVvio2HvWN5w7EvF?=
 =?us-ascii?Q?6DjQJ+yeNfHEgiyaH8cRDVh54MmbRG9ZD96GnaRx37FgFKKWNvzxFwgn646J?=
 =?us-ascii?Q?7UJGu6zelT2uBq8JdkFm0PtdjBwVXAXqIEb08XWekzFVuOJcu5ckble4s+Hi?=
 =?us-ascii?Q?eu6LaRIsecwRc3uPF7v7/UKh5r1x8EgED0Hj+jx7Lm6roUcozRVcQdTIuuUW?=
 =?us-ascii?Q?BVzwFsxNiSXkYmgP9OvPBCvnMTcuKmw3azcT1++bhq+sppObZm7jPa+mpoPo?=
 =?us-ascii?Q?64qUPpap9kED4Mu0Qtg85TV4w1gTNNnJDGHdkcLW6/n7AeM3P33lsa0v42Gm?=
 =?us-ascii?Q?bT/781hiVGJ/f+A3r9pQ12WkWlFI0oj1chaCyiZLLKZRiUUZ5EClHOXGwI4b?=
 =?us-ascii?Q?10XTncy7dy1lFARClvmPfjIlQh19uDwE9/S6dVltsZyG5lz8YOX79tl3we1j?=
 =?us-ascii?Q?sp+jVWM843qoM/zzXyntffskl9lD8+7km47rB7BRYV9VwreEEuwt3l3nU4dH?=
 =?us-ascii?Q?f+d+BfWGRLjuj4ngp0/VFAZ+D97T2lIGVswB0k7s0VpBB0KZG9ZN0X61vQdK?=
 =?us-ascii?Q?FDV7VYCpGAmU/xnutOJjfW8DCK3J/lTJIUoGe3wsnNW+03Y/snqM5/XNNBW9?=
 =?us-ascii?Q?2AxayMyo6PjCu+oWMb9cGULzH0Sbp06/e2TbYBhlQwFjumSB+nzzwJLugV5O?=
 =?us-ascii?Q?lVE8l9z94d640NTPlmWSarMJNIMLizGwC74w74vim4IVdsPtepcnXyRmP5dL?=
 =?us-ascii?Q?JW7DLDDPaMQsXqg0uBKpAQRxfb7xsWll4NoRwipj27WCqFIaH+Yf9HjRiAnQ?=
 =?us-ascii?Q?24AjK46lJcGLwJ596ehT+DNa+3drePCPnQ1aZR6IBQwbhUr/NPAyQ7h8dAZN?=
 =?us-ascii?Q?kKrh6gq1aZpbESbDSlk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f1adf6-bcad-4eba-8ebb-08dd1db397b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 09:25:33.7930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQVSoU3Vfs7Sjte6gyzdA1lZ7bG/kaE9hTcZFza7jRM/WbD8y76usCkBYIhvK94hKg2BNWOCsnHLviBgmBg54A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8060
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Tim

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Monday, December 16, 2024 4:29 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>; Zhang, Jesse(Jie=
) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu/pm: Implement SDMA queue for different =
asic

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Jesse,

> -----Original Message-----
> From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Friday, December 13, 2024 7:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>; Huang,
> Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu/pm: Implement SDMA queue for different
> asic

Here missed a "reset" for the subject?
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> Implement sdma queue reset by SMU_MSG_ResetSDMA2.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 28
> ++++++++++++++-----
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 9222e7a777a6..e57d83099f4c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2724,14 +2724,28 @@ static int smu_v13_0_6_reset_sdma(struct
> smu_context *smu, uint32_t inst_mask)
>       struct amdgpu_device *adev =3D smu->adev;
>       int ret =3D 0;
>
> -     /* the message is only valid on SMU 13.0.6 with pmfw 85.121.00 and
> above */
> -     if ((adev->flags & AMD_IS_APU) ||
> -         amdgpu_ip_version(adev, MP1_HWIP, 0) !=3D IP_VERSION(13, 0, 6) =
||
> -         smu->smc_fw_version < 0x00557900)
> -             return 0;
> +     switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
> +     case IP_VERSION(13, 0, 6):
> +             if (((smu->smc_fw_version > 0x07550763) &&
> +                 (smu->smc_fw_version < 0x080000000)) ||
> +                 ((smu->smc_fw_version > 0x00557700) &&
> +                 (smu->smc_fw_version < 0x01000000)))

Just curious why there're two ranges, Are they intended for two different A=
SICs?
  Yes, I will update the patch according to our offline discussion.

Tim
> +                     ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +                             SMU_MSG_ResetSDMA, inst_mask, NULL);
> +             else if ((adev->flags & AMD_IS_APU) &&
> +                     (smu->smc_fw_version > 0x4556e6c))
> +                     ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +                                   SMU_MSG_ResetSDMA2, inst_mask, NULL);
> +             break;
> +     case IP_VERSION(13, 0, 14):
> +             if (smu->smc_fw_version > 0x05550f00)
> +                     ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +                                   SMU_MSG_ResetSDMA2, inst_mask, NULL);
> +             break;
> +     default:
> +             break;
> +     }
>
> -     ret =3D smu_cmn_send_smc_msg_with_param(smu,
> -                                           SMU_MSG_ResetSDMA, inst_mask,=
 NULL);
>       if (ret)
>               dev_err(smu->adev->dev,
>                       "failed to send ResetSDMA event with mask
> 0x%x\n",
> --
> 2.25.1


