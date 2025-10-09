Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA80DCCD183
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 15:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D7FD10EA8D;
	Thu,  9 Oct 2025 15:24:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X+wmhrJ0";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013067.outbound.protection.outlook.com
 [40.107.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F1F10EA8D
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 15:24:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgKCN5b++A3JrtIouMwKVwl0pXY2AvewkjKeMqi+mFZquE3o56Q2TZ2MjEzpr6zuj3+U+HxgNVZ8a0+8/s3DvgOT8iIAMeTYkwHXtSND2g1hKOHvMEL9W+ItpOshnyk+G4tMDOUrTNVxJYiF56Qbnon/eGs93B4m6ynB4XdLRcwJYJje0vmlbKCB2r2X62Ff+nkCAaP904W9ZGNMWyx25lH0+hkmpUNwl2yexnsQr+RCo9qK4KjwMjneFPPP8ZWywk7sHOTZk3+DDiPtzGwuakeia8r+Z3MjZt+/H7LaCZnM8TDyUmphgbmGY3QkJC5+lOuNabZ/PvSajHSEpQw+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsSm9cKGYJyqnTP91l4YtVU1OaCxfKGuPy2BtSR9a1k=;
 b=Cx/m25VjoMHZT2M1Ff8YSgpDO/SzUCnNvTgMJGvL2YgsAxFbvmS50QQWK+3+Db+VMf74k+gRWQruDqx+2UhlUZbjdQVAvl/T0+4Yq9Xi27DTbkVnMo9NctaKOKfkXyJYLiheN6KRlsEZXwZCbYsmETO7TZhJQ5xssF96WEfOHBFNc+PJN0+SygqqSdq6w7aWXqQqtl5++vKIWZ9SRqsshuNqZWyBrELKp00hFSbMKTiSCUkZiussUXVgDcqKhqCsoAXo9ZTcjMj5jAxB30auOSB/nynLPzPvd+bSMkdaLIP4qvhDacEyaKPGd/4seZ9xZYORF8RbO9is2pM+o8GrUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsSm9cKGYJyqnTP91l4YtVU1OaCxfKGuPy2BtSR9a1k=;
 b=X+wmhrJ0ILztlYV9A7Bu7+in5EPCskoOMRnv5bkNochXg/RoPT8iPCgDouCwYLEbdW6YZ9P1OxdxNJlrc8dUPN133w+xGmF1CVN5bQFR1cGxqlOpWcvyFj8Mkn0yJvTrLmphHIUYLGtfqc5iTljlq0B9cw2qwkUUIW9VyanNXt4=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS4PR12MB9563.namprd12.prod.outlook.com (2603:10b6:8:282::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Thu, 9 Oct 2025 15:24:37 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9182.017; Thu, 9 Oct 2025
 15:24:37 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Pan, Ellen" <Yunru.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Gande, Shravan kumar"
 <Shravankumar.Gande@amd.com>, "Pan, Ellen" <Yunru.Pan@amd.com>
Subject: RE: [PATCH 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to init
 from dynamic crit_region offsets
Thread-Topic: [PATCH 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to init
 from dynamic crit_region offsets
Thread-Index: AQHcOM02v8L5A18RO0mrTV/eAS4/XbS52SPA
Date: Thu, 9 Oct 2025 15:24:36 +0000
Message-ID: <DS0PR12MB78042B01E20280672286EBEE97EEA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20251009033106.25022-1-yunru.pan@amd.com>
In-Reply-To: <20251009033106.25022-1-yunru.pan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-09T15:24:19.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|DS4PR12MB9563:EE_
x-ms-office365-filtering-correlation-id: 13b041cd-9fb2-4ca3-71d2-08de0747f521
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?MNJb7qjuk7zhfWkqIPFuM1E3iTogrMOOyQqHSv+qJdlFpIvM2j80gxKEwS4K?=
 =?us-ascii?Q?0CWQpGfZK4PQmnmo7rFu/MgR8hw8tSqbyk15SQl+UIUrU0PIhLRSX0ZhmARf?=
 =?us-ascii?Q?qiihIJefdCiY6kyrwzYXd9ClgQo169MIkpNtBtJxUwoBvlR05fn3OiDONWoF?=
 =?us-ascii?Q?sg7CHsB8aTJuT1JtsLNspKrNWcTEEwBkR33MHCRMj4WOHCe2RDgO7yLCv9qA?=
 =?us-ascii?Q?VwQgRitxJPd3G12iHWzgaVxq+IB3gNqKdWffI2u8wnSNmUAggZwD7k1udNl6?=
 =?us-ascii?Q?zBfqRjCQXbv6CHnu2CXXzSpEqAuqH+J40zq7Q9hucut+eV6KhQvRL4cIo0Wc?=
 =?us-ascii?Q?VJpfDxHScgra5DLG9Fgb8894bxun+TvfLC/Lg6KGE2fsWoDBo6uTit8HEpAk?=
 =?us-ascii?Q?rINdVtPsYzr1/48kyMLPGbcafBdVgkOooVkHC29H4fZ1IyZtwz0Bk3Xjzd90?=
 =?us-ascii?Q?QXGupVQV5vKLMedVPXpZ0G/hDwdkx7nTLXIMRC0HnQ+R72cEL/hkT2A8iDWW?=
 =?us-ascii?Q?O8Jtxbq1YOIujuM4fpMub+/Cm2fvvYqvf+M+y8/qt86vDG9MUQGVLk/fAB5U?=
 =?us-ascii?Q?UgzIkcRHUu8j0ZYTDiKGBbbPjYmV8hzSrjcuIeFrrk7/nAAlwhh1W7hFXKJr?=
 =?us-ascii?Q?iiIYD8BKrkACDWToePEUl4FdXuFizMoubjZc7AYnSICyRD7jdWxTQyPNT1Fr?=
 =?us-ascii?Q?Ao7boNxHzac6001KE0ul9YI73qgKV2TLB8dSyY5360UkBn9toBOsS1ZfgSfd?=
 =?us-ascii?Q?g5yhp8hDDIHfnuikF0tPlmbkNQejTl45FogMf85G7roZ4G/+eGcQtlIettAa?=
 =?us-ascii?Q?0MoJJP2vnqcMbEicxDQa/xC4o6UNvP1HhB4O2aG+hDCNjH1jAncmZm1ebBOL?=
 =?us-ascii?Q?n0CJyS5kZhHx6pAaHOOWDVjNCsTRM7DMRV1ooNQ5ng0q6HtMOalGN87uF8St?=
 =?us-ascii?Q?5S4oGW3kgoRxdlF7laGmHfnIH5TdKa3PHeBX132QzBQSKyYG64zqfmskA3Pm?=
 =?us-ascii?Q?uJ9SmFxdT2ga7G58Akoq8kqtBpN7IWfxKfwurQrD4QzY7YPcZKPUKf842hzF?=
 =?us-ascii?Q?bgF4XTem/X2Oq4dVgvkjpvwDy3rLnEUhMORum4zVEWX4Ig25fJo2RPISd0bK?=
 =?us-ascii?Q?R9xSwYVQZhx60Qft6L3CxbSxAZ0kMHbzgWTQ966kOLw/kVDUXPjjWH4r8+vz?=
 =?us-ascii?Q?h6bIPdQJ33xSfqvszSWa/jLgm035zYy7LyAX7rtQ1jMkW7K13HRJ3twaVY2b?=
 =?us-ascii?Q?uSanHG43At99cfH+zLYzTTqkMbilD00rYfB8cjVIxFdq6HPbSIKTTmG6BhGv?=
 =?us-ascii?Q?LIEldiRBhep7PGc/EfT+k4vYl/h+X6u2a8dqtbFcn+VWzTuR63ioKT93e5if?=
 =?us-ascii?Q?hGLNtSKJQKkUYhtdNmZOvoIwh9J2NfzN0SDqFO23Qyuk74tDXAEVrCXrj68Q?=
 =?us-ascii?Q?ZpSWHyrrYWp15QZh8XmATjTDXvTjrJ1VhO0jnYuPCaeMaf2SFlag0C12euVD?=
 =?us-ascii?Q?VUFQurFBLqdX4F9dq3Qq+gc/jvT8GOFPP53d?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NLVmi31lU/GpIy96D0y165Bra4XKMU67yhoC0ljAXntk9SY2cYLEee3OszaN?=
 =?us-ascii?Q?bWFcm6pipO0ICXpx7fPOcX5xcPB1JkdCqCWd0F/TS3Z7yhDUBXvEQYYaJXbq?=
 =?us-ascii?Q?oAGFMorwlh743+Tz4ZnfE/eNuyq1BgdKRXsnYvzsf67xhEenZlrL6kvCN1k0?=
 =?us-ascii?Q?sIoNu0nugUdKCrdrHahhMsyjtC/cAqe74BdN9UWIzMjxdE6CreBD3MS/Hp/t?=
 =?us-ascii?Q?wS2xcfccvKeXUzJJFnvYYyOAHWHQLd8kzu+seIhr4Sr+jv4W6mJE4fclAnhM?=
 =?us-ascii?Q?Q85+p0d3VLe++73iDQ57VbettnZbibGh84VbECUE9LP+uadPKExIg2OCvwUj?=
 =?us-ascii?Q?lJ/kuDxWbxiNOpG5hH5/89IWqy2NbcFYagq68oq8pak5VTyhzeVl8HUN21E6?=
 =?us-ascii?Q?EBlVAqh3Yq5Pmu0aTrQK3b2HgmmDRS5yT8poop/5SIJ6TIS0PZ+WYGOKcVmc?=
 =?us-ascii?Q?ubec5X7Zj162UHuqk6XVmJA3TBIOLAX7dkQ38gSMfuHy8yq8YjEqHenO0ALA?=
 =?us-ascii?Q?vi78pIVeFDfSlT8cRj3eY/OMRzQY9Uey3VnfNtntDBTMBDbrK53AfcBqFf5C?=
 =?us-ascii?Q?cTgMBwg6NRqiyCUWwDirBVeNxwqDKpgRLsc5BWBq6TB+Cp5EhoDknVM7YM9a?=
 =?us-ascii?Q?VtJ9iYDieBsJiPT0BEq1CpdaM38bfAcm6Q7n8PVM0XMpLI3k6e1lSwNNJFet?=
 =?us-ascii?Q?NiH6pSBZvS6og0/hDqpq4T46tHgspNx6jHJhr/W0HM//v5BBRPK/vEfQspgg?=
 =?us-ascii?Q?hiCRxJHPZh0Hi/MtSLESQjWIHZ9yuaZD1jlZadGxxkPWfX019TAhf7rx/GF5?=
 =?us-ascii?Q?cyzdUUdXyUbOOOpqd3vSCwTXq1OA5ntTsDnyhk64Ho0huuw8sbdLydJ7xNYN?=
 =?us-ascii?Q?IqyA37BUkxFPWGBi9FqDYRcNIZHmfFlE4xjI1j+UBJSU7ABttEihWPWnLL2j?=
 =?us-ascii?Q?zq4Smld/O2VdTZSXKXKGIgaWQkRRmKer5srqa1xiqZPV3p+xH90/Ia0GFRBD?=
 =?us-ascii?Q?thU+X7FUIgiN8O0s0gc7MvX6zqdQyRL9t+6fWMwoWOJAdEBRi8+hl80vgj0o?=
 =?us-ascii?Q?mkI5/4AwjeWOkR9rntDJ7Dn8aed/LLkAUA0dychwkxCeeviICillvJEc0Pkm?=
 =?us-ascii?Q?3PQ/SS8ua1f0e7SuJo5ex74rTwR9lm/WHD0hqK3EyrufLqssenF1VYneeH7n?=
 =?us-ascii?Q?FSEyXDGmEER8iTnIGgj94Nhi4p/QDV2IcTKAtSRETvuimsy5STn6CD/3aQ4S?=
 =?us-ascii?Q?UYpSnyWQkHyfAoDkQBfn1i2LfmOiQNI5MkammfyppUhUe50Q8ilWjQ5X4opZ?=
 =?us-ascii?Q?/KAYmrFzzsMRirt1C+ZsFQHVV6q0M0UEK7DRCBKnNi3T0MI41q8y5nhlh+Xp?=
 =?us-ascii?Q?LteP9N5c3RJlRSWZDbmoAvtrTAprZJ//LSKpFhgabCD9m/xaMpwNpaXXQ/nY?=
 =?us-ascii?Q?dsW0Sx0I0mW4PGN/WKPgFbd1JBdt+m8A06XFQ6AQf81BUEvXDYqb4kAtuc+1?=
 =?us-ascii?Q?HcvxRg6TzcC0BQii99w6PE3rZU5pCYn4Z0tUFohhURxCDi5Mozn0UGaW8Zzn?=
 =?us-ascii?Q?JnSnyb+hgMrI+l28fdw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b041cd-9fb2-4ca3-71d2-08de0747f521
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 15:24:36.9814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sd+xDnOenQ55ZPDcbtTj/dke0BiUM4gw1M6a2GjnRJr1DX23Y+VZeqBGQXCuZtAL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9563
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

[Public]

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ellen
>Pan
>Sent: Thursday, October 9, 2025 9:01 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Gande, Shravan kumar
><Shravankumar.Gande@amd.com>; Pan, Ellen <Yunru.Pan@amd.com>
>Subject: [PATCH 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to init
>from dynamic crit_region offsets
>
>1. Added VF logic to init IP discovery using the offsets from dynamic(v2) =
critical
>regions; 2. Added VF logic to init bios image using the offsets from dynam=
ic(v2)
>critical regions;
>
>Signed-off-by: Ellen Pan <yunru.pan@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      | 12 ++++-
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  5 ++
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 47
>+++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  3 ++
> 4 files changed, 66 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>index 00e96419fcda..2cbb24ede86e 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>@@ -114,7 +114,17 @@ static bool amdgpu_read_bios_from_vram(struct
>amdgpu_device *adev)
>
>       adev->bios =3D NULL;
>       vram_base =3D pci_resource_start(adev->pdev, 0);
>-      bios =3D ioremap_wc(vram_base, size);
>+
>+      if (amdgpu_sriov_vf(adev) && adev->virt.init_data_done) {
>+              resource_size_t bios_offset;
>+
>+              if (amdgpu_virt_get_bios_info(adev, &bios_offset, &size))
>+                      return false;
>+
>+              bios =3D ioremap_wc(vram_base + bios_offset, size);
>+      } else
>+              bios =3D ioremap_wc(vram_base, size);
>+
>       if (!bios)
>               return false;
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>index 73401f0aeb34..0dd9ff576cdc 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>@@ -292,6 +292,11 @@ static int
>amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
>               }
>       }
>
>+      if ((adev->virt.req_init_data_ver =3D=3D GPU_CRIT_REGION_V2) && ade=
v-
>>virt.init_data_done) {
>+              ret =3D amdgpu_virt_init_ip_discovery(adev, binary);
>+              return ret;
>+      }
[lijo]

For bios and discovery, could you keep it uniform - either virt_functions r=
eads/returns the binary/size on its own way or returns the size/offset for =
both?

Thanks,
Lijo

>+
>       vram_size =3D RREG32(mmRCC_CONFIG_MEMSIZE);
>       if (!vram_size || vram_size =3D=3D U32_MAX)
>               sz_valid =3D false;
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>index e9dbab53cb06..9181acef4e9b 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>@@ -954,6 +954,53 @@ int amdgpu_virt_init_critical_region(struct
>amdgpu_device *adev)
>       return r;
> }
>
>+int amdgpu_virt_init_ip_discovery(struct amdgpu_device *adev, uint8_t
>+*binary) {
>+      uint32_t ip_discovery_offset =3D
>+              adev-
>>virt.crit_region_offsets[AMD_SRIOV_MSG_IPD_TABLE_ID];
>+      uint32_t ip_discovery_size =3D
>+              adev-
>>virt.crit_region_sizes_kb[AMD_SRIOV_MSG_IPD_TABLE_ID] << 10;
>+      uint64_t pos =3D 0;
>+
>+      dev_info(adev->dev, "use ip discovery information copied from
>dynamic
>+crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
>+ip_discovery_offset, ip_discovery_size);
>+
>+      if (!IS_ALIGNED(ip_discovery_offset, 4) ||
>!IS_ALIGNED(ip_discovery_size, 4)) {
>+              DRM_ERROR("IP discovery data not aligned to 4 bytes\n");
>+              return -EINVAL;
>+      }
>+
>+      if (ip_discovery_size > DISCOVERY_TMR_SIZE) {
>+              DRM_ERROR("Invalid IP discovery size: 0x%x\n",
>ip_discovery_size);
>+              return -EINVAL;
>+      }
>+
>+      pos =3D (uint64_t)ip_discovery_offset;
>+      amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
>+                                        ip_discovery_size, false);
>+
>+      return 0;
>+}
>+
>+int amdgpu_virt_get_bios_info(struct amdgpu_device *adev,
>+              resource_size_t *bios_offset, resource_size_t *bios_size) {
>+      uint32_t vbios_offset =3D adev-
>>virt.crit_region_offsets[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID];
>+      uint32_t vbios_size =3D
>+              adev-
>>virt.crit_region_sizes_kb[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID] <<
>+10;
>+
>+      dev_info(adev->dev, "use bios information copied from dynamic
>+crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
>+vbios_offset, vbios_size);
>+
>+      if (vbios_size > *bios_size) {
>+              DRM_ERROR("Invalid vbios size: 0x%x\n", vbios_size);
>+              return -EINVAL;
>+      }
>+
>+      *bios_offset =3D vbios_offset;
>+      *bios_size =3D vbios_size;
>+
>+      return 0;
>+}
>+
> void amdgpu_virt_init(struct amdgpu_device *adev)  {
>       bool is_sriov =3D false;
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>index 5f6014b2f349..d122347ff666 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>@@ -434,6 +434,9 @@ void amdgpu_virt_fini_data_exchange(struct
>amdgpu_device *adev);  void amdgpu_virt_init(struct amdgpu_device *adev);
>
> int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
>+int amdgpu_virt_init_ip_discovery(struct amdgpu_device *adev, uint8_t
>+*binary); int amdgpu_virt_get_bios_info(struct amdgpu_device *adev,
>+                                        resource_size_t *bios_offset,
>resource_size_t *bios_size);
>
> bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);  int
>amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
>--
>2.34.1

