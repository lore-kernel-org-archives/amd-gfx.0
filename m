Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94935CD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 03:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31EBD10E0FA;
	Tue, 19 May 2026 03:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L3FqcmJn";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012004.outbound.protection.outlook.com
 [40.93.195.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB65710E0FA
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9qknSVwneJGGjeSg5Ay6i0111N6hYElr34Yq/LVR1kA1gcjMYrdGatxiLSM9ban5BD9lf/ppqIGHMNTwtp28P3s/5zv7OVb+SpSLbJhuxxWGxDvVZ9yEcyM57EBQEIUFMYlr9AKJteIpUjSYROEmSH4RJRdl+haQzg9QtWlGK+Lwppsmrm9FdpOtSvklXhujlgVWZArz9iSDZYoCrCM0awdCX3EmOzQBxGSX5Evs5WRm+/dIe3gBta6gqKmDLRuQqz5t6oQyHvFNhLmH0YdBOiDWsZ58rl1zbzckwhndXv8AmKwAmaCQpClYFwq/l4hVWgc/Eoe6f/QVo7A2cDDzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjrISgMStw4SJEhHEsi7jkdrFuN2Y0b29r3Weh4BvCs=;
 b=W1GF1NHOm1HPs3avcOmeXg8i96kqcrmGH7U6U1yjdKtlCGBtocffr84RVPWuQSRMMDDOPCzs2ZlHp3w2pU+uKVpeSUQWMWEVqcTqQ0WRCjqo+HPxgwUh/i7X/R67ak8Sfun4PZmJ1YqdVajz5PRwTqC/tBrs5xOQdu9iBt582TuQhhXCsmMPQDQqSd39PccMT0QWzEFwfczOzXjKsgryOr+Tg1/yxzTenxPQ36fHOt2U+0b3YJr3aQak0nYGY3xhe+DJJrlAvI8HACbmfLPGm+ZNr+V4BBw2mTVVKjaQrT296AaVV6P5rUkArBzX/OyX6AgQK5QcenI48iohjZyBUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjrISgMStw4SJEhHEsi7jkdrFuN2Y0b29r3Weh4BvCs=;
 b=L3FqcmJntY2yb6FQ43Mqwh/IjjmkdRl2E9EbbrmwswVsVC8s7/DYIm30oWQiV6GgxWTQ87/ovIdyMspon8XwmiMRUx0rIWqYtjZ+CnrB0KF+V4Y5uaclcxd+U0OeSr+/fDMoAC4Bcbvcmlc22eeqD6JXdal+HD1JSxKMVI4gJv4=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 03:23:18 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 03:23:18 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH 7/7] drm/amdgpu: check and drop invalid bad page records
Thread-Topic: [PATCH 7/7] drm/amdgpu: check and drop invalid bad page records
Thread-Index: AQHc5pc70RLRJ7DmdUGktkU9/69SC7YUraQAgAACtwA=
Date: Tue, 19 May 2026 03:23:17 +0000
Message-ID: <BN9PR12MB53066B04717345977C9187EFFC002@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260518072215.3647120-1-YiPeng.Chai@amd.com>
 <20260518072215.3647120-7-YiPeng.Chai@amd.com>
 <PH7PR12MB8796B898AEBCBBA5568F7A80B0002@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796B898AEBCBBA5568F7A80B0002@PH7PR12MB8796.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|SJ0PR12MB8167:EE_
x-ms-office365-filtering-correlation-id: ffed1620-df33-4548-1b95-08deb555f894
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|11063799003|4143699003|38070700021;
x-microsoft-antispam-message-info: U7wm9Mlu5FT6XoX+soUNp/NPRURiuWhGZCvqmjO6ibmsb/+6Du/t8X0eW2COl9mBfFir/eCOX2gLwIIYMfa9mqjnZM5i8aWkP48MIleqncjPPipLYF/QTVqC+sMxOJ1+rOWZo7fWF4yoSv8nR94fyHdzkpeOmkcDBHXOEFYT3AcltuVCxvk7N0tpLgBl7Oo7V6cpuKEpibfSyBTZ/NHPhQGmST5jsWrMBFMHZnyiXkCG97F+D/8zQD4Vd8+qB5hv2vEvE/Sy4FjkmAvHl1fk5iZCMjSDawU4ZUXDcF/LAToKPYh8XFPDqKII1bbfpK+BEc/jEhPafehJqUx+aAowO4nNBadaRIyql3I0LX7V0JGyKSNtWbOGd6p05pKG43Vy/RFfxArSwdTjGvS5nOAy8UZDcVMKsw67RxIEMWf7ok4fO9c68pVhFyFtjK9MoSQRWilaRHCCwRYA1CU66rSD7DDfJhRwVHfBRb1TGbDxKHfq3SLEaZR6coEIX32eCTl2Y0s3JBO/pRLkTGZ6YzflmuXkezAZG1OFLy40o3+le5vzAppd93JCS6F4F+Mu56VgN1xw5g0IkV5NCK+4X15/T809GkrQkPLDZqX6/XUTJOnWYTiEoJ02tKwDbYOEkLjAnN0LOA82rXLmFUaL4Dvffx5ZxlkCV3FU8KVW61l1ahdy3fwNsIvV1mKa/YWeqVXRW0BBkKGuUOHPzv6QLhygumeZQVP8aDdVOAlca5Ws3bgScoVlSoha5/wpp9DzrmQ8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(11063799003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BQZ5KXLpsLTgivreNbODjpz+RMAMo7d9r+pFlRDYsiHy4RaR/vly4ipPjIdg?=
 =?us-ascii?Q?zIbghyTVM73WPMUOPMfdyEFzyP9yOBiWU8Mt8L6b1DNhcQ53F4ujOKfL9l00?=
 =?us-ascii?Q?X2CXwJr9PQQ55zOQN4Rrz1DgO/qcddh5Js6kkOOet6zcqhDP4+TqWIumM4Vx?=
 =?us-ascii?Q?Jf0ZQH+hE5gxjCC3my2qGQiueTN1JmRuJSnEt0uie/sLWa9yWPI0cOI6Kmpp?=
 =?us-ascii?Q?U2StKqdWk2Rt2bBxSN63pph840clVmhuM/2qxuMQSHfKrxzz8t3e44DPdW8K?=
 =?us-ascii?Q?09Ku3A0NK4nv0aV/t5Xtkwu8wPbvJ3FXKgj/BVFUCT5uAPPD7EoIA7MO4fhR?=
 =?us-ascii?Q?6LRd2L9bcxXLOw7mUZj2rWB7TFgbWdu0FcDUq0OEwSggFk+D/QQIOYjy84/l?=
 =?us-ascii?Q?2q8Yl6kNDiaXWbRIcjGyaAlZB8CQ2kdtVbSfSDRgfJKFoJFckt7RhtIoSGfZ?=
 =?us-ascii?Q?l9eiPVQ1chY1OAb8YTuliyqiZp/3e+Xn/hlZDX6xGBw/O+EZjzWA96m7XhZ8?=
 =?us-ascii?Q?MTRhvOBUxGtlQ7ttXXENq2Csq6IWDCAoNyqc3EYkUY6O13AYTcPYwXJeofTE?=
 =?us-ascii?Q?DwbG9ZGZIyLjGzJdKTGqLpJoJa7FjE1sCjK8YJUklqyw3MfFk2wWLzYXLfue?=
 =?us-ascii?Q?CtmWbE3rDN10KpdOMWH1snE3QmZ5PS6xRMPrCJluRxfvaIys5CKEqlZpoe5c?=
 =?us-ascii?Q?iz/YZ2tzTRsgaNBjt9q2XYBYLlK+s3h6W6WV8LWCpv2swkcP0AKMAx5LPTiK?=
 =?us-ascii?Q?lY/2FNTxRYaeyTsg4NrFvdksBPaLGfUUiLQt5XUlEQ2vlkMkHi74aps6R0Kv?=
 =?us-ascii?Q?R8zwawO7i7vzvYOdY45I0fcg1HN/il30uiGPZV0roxqKUglkTMAEs8SPzf1v?=
 =?us-ascii?Q?0iQaFUVYXJg9IQGw04B2eU4NCu6DxZ488PF/N9yjiGjzumzPWjRnqjIFzNZa?=
 =?us-ascii?Q?FuLDxsX4i/EBLVVj4swoU6wijA5NtOXBqrBtTtRLjHr0lnGJqARrpPOmuZrT?=
 =?us-ascii?Q?O6Bfva0znbLuazuEwnAPQ6AmkcKnQvSncfu0uTWE7kDNYuy4R9Qe7rTpF6Pr?=
 =?us-ascii?Q?uSXfV0ewlCcBI1f0Fbj2Qz5Cg0ynfzJZHceGNPYsDTbtEKsqsV9Tq/JWSb/4?=
 =?us-ascii?Q?zAp3O49+u7/GAkNfVwRDHIUyJhURSAqEmVFVaJc/DoQF2tzyNoAay/gnB7wq?=
 =?us-ascii?Q?6AdK53KGEPiXgdJ2FYVaIxNJuh5chq9gg6l427I5T/k7mQedHw6MUA55HhJu?=
 =?us-ascii?Q?bCi/A0rcJGTj1rghIMY5hvztODPaHHGM5RDMbJEJr6MSFmmWw12XIibeLQxb?=
 =?us-ascii?Q?uUdFANJ+yxBzc4VTOLiSGpDFqgebmV0lS5zzbJLe3hk+WnqASoF/mQkmfsjI?=
 =?us-ascii?Q?5JqRunN7eAfbWJQc245ssV2OAWdLzGXlc1fjxC0R4ATpRpHAQpLktONPJztJ?=
 =?us-ascii?Q?hRvO+sA1gRSOWliuCRXCJc1SlPMDY+MX63NbS/t9zYSNC0SaUmBuz7rfN5wP?=
 =?us-ascii?Q?2LWB5BvXirrWgCC7kj5xcB3XdOLuD1c8RQWs28ZxkC18bv3fZGuOGk4cI7zE?=
 =?us-ascii?Q?XnNko7tlbAJwTiROcYrmmIsXrCc5m5fvXhbUQVh0LqxeWqkOcw9bpqZm34qW?=
 =?us-ascii?Q?BjqnO8H01aTwMeH99V0W7HUrjNLzWHAeJRi+UKUAInGQqj4qrDfacFuH7/87?=
 =?us-ascii?Q?wzBjN4ObpF95qNpUkWMYyVeqyzlN5skjjtVk71PGz0PYgCEg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffed1620-df33-4548-1b95-08deb555f894
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 03:23:17.9958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhrNpkEXlWikMBOAKZZFNlTvgccDYxJKgXCsabAwTjImLmsRtqraAcfJwJhgaEuhrQ2pAYOExyY+Vr4tLoSKFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167
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

Sure, Will update

Best Regards,
Thomas
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, May 19, 2026 11:13 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd=
.com>
Subject: RE: [PATCH 7/7] drm/amdgpu: check and drop invalid bad page record=
s

AMD General

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, May 18, 2026 3:22 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 7/7] drm/amdgpu: check and drop invalid bad page
> records
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
>                                       struct eeprom_table_record *bps,
> int
> count)  { @@ -3101,6 +3115,14 @@ static int
> __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>       struct ras_err_handler_data *data =3D con->eh_data;
>
> +     if (!__check_record_in_range(adev, bps, count)) {
> +             dev_warn(adev->dev,
> +                     "Recorded address out of range: 0x%llx, 0x%llx,
> + 0x%x,
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
>                   amdgpu_ras_realloc_eh_data_space(adev, data, 256)) {
> @@ -5642,6 +5664,11 @@ int amdgpu_ras_reserve_page(struct
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


