Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9BBECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 05:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFF2D10E29D;
	Wed,  7 Sep 2022 05:42:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2926F10E29D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 05:42:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGyvHc3KlPPusoT9IV4/ouMozaedZH7A6RpQcI2L75S6tz1jykvdf9QkJoiUvm8pZrXy6TOh4jbGFBW0NHQ4ICVU8SOhxe7DGx8pF4giRKdDtrD7+56qPto2zV5HztRPCWPld0GZs+Mg7MEcFSfkDTOuXKXd9GmqxCkN8U3pDiyU1SUPmvv5/cUjvjdum7V58jSuFYR0ribf88cmlm0RGdHqiqa0S3+75fU8G89RZDpXXE8DwzjMkZO/rg7RSjsRdezsahiMDkqV0xxK1gQuxGoJHslpKTg5MR5YHov/LW3giqvkKOy1T1kXRtyWH9y2HIOSrw4RunEYKy/sfyDgPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fkp8pRQL8S+Ynl4EpK9uzu3/3GusPxM6XorfMgPcuy0=;
 b=Nlpc+/NmGmF7K1alCqtPwjJwT25gJ2Vr9dAq51lTVKH+RIR6G9hZugUekdhh+HtqkO9FvD4PcIygEXouDFw50BpmjhDbzHT+m5JqYzPjBxoNGx0BYvVks9KEdM7PtYg45e3J0yWvJ5p6jx3WCAO9podu6+aAclMCNYZ+U/L2azPHspdfvMDXABI7CuroiRtDE4wbruMAuuiOWCjvtKqACn8PXEwuD/gx3TN8IqXYhbnu4BqysoXH0xK/nCLl3LcsJ2T1zm1H2Txyn8gpI8wlDtdKdOMwvMw/CSvupH03mUCwIKQK6wFi24sM21koYXXD0G8w3Q6sOx5z3X7DhTytsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fkp8pRQL8S+Ynl4EpK9uzu3/3GusPxM6XorfMgPcuy0=;
 b=H+9ArTKczMgvBqRtYtdloauacuC8ek88R1ODeP89UQk5Xxecz9fbiqqCQijkAPhT0XNr89yrEZJAimx+e3UrrBvgul1sYstDHAPXg0viOST7iS5DTDlgmzz9YWIAdhoue5zNGnhLrt8sVvMA5BSo6bVtBk2ZjstSge39+7wWwt8=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 05:42:48 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::6cff:7529:4f8e:b8d8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::6cff:7529:4f8e:b8d8%4]) with mapi id 15.20.5588.014; Wed, 7 Sep 2022
 05:42:48 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] Revert "drm/amdgpu: drop runtime pm disablement quirk on
 several sienna cichlid cards"
Thread-Topic: [PATCH] Revert "drm/amdgpu: drop runtime pm disablement quirk on
 several sienna cichlid cards"
Thread-Index: AQHYwnXPkBZSQPJIS0ylB1DqmGz4kq3TdFkw
Date: Wed, 7 Sep 2022 05:42:48 +0000
Message-ID: <DM6PR12MB2619F668DF2987D17939FE10E4419@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220907045326.2881218-1-guchun.chen@amd.com>
In-Reply-To: <20220907045326.2881218-1-guchun.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-07T05:42:46Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8d2a4470-4ffd-4a95-9c9f-f889bca9c53c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c1668d6-9057-4ba0-489f-08da9093cc0d
x-ms-traffictypediagnostic: BL0PR12MB4915:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U5kZxjvckmv5cDDU1H9PEu7HFdOh/6uF9xXmHj9tdgbUMVyjnyaTFW9KsqqMrXUMuV8J4KGvUcJ4h8I2HXKGwZ7MBgULBEqXNdtFToLMtOn7u38jtb5QmjYTBaSinvVwT3artNqUhQWrA1u6FFONGQmJftP7YE1lJKHVj87I7oZD2ZC10uYHxWB6CtnqMzfVsVjzaDByNiHVCoxdQFuYLTot35RjXPyYMCmrvOBDn4JBy4pLXkC4zATaJza3gRdsAu8ZB95OjAkkdXxmkAGf/bmoDFYcb1Gd4BPX8YcEp57J/bJlTCkxdBQA9ba0fSpelfGg8kkcaK3NVU8LgmcYiSxlhvG2WP0l3BjBLSbvkEZVP/qrUrT+h+/n589bs3ERVdYNQyclH+LEa6sg3Y/8okmbGQ/WXn+1BBzsau7GD3a6qi1+/3+lie0iE1X637a+nxdDV7oqATNi9/m6G1HHLl88ox21rk0Vz4mInGaE3cdS8CMZwLoVOufL9bTTiCCoKAWE9MN5m5ZoNJhl64T8OH5KCbcbcDEBwR1VjTUeRjAi0BmxNpPRhSvydbbX7+wt/eg717OisgF5UCAa1glw3AUTLMOu4bHhUNN+ZuKuL7+A8T/wOlPraPT93nInrBtQUTVWM/PT0aSGo+7SKXZ2/lP7qN42Mh1KgmiReS1UN/COioPXdvLYDwOpszhy0xaLHlnozcS+k/NR8wYt+OwBlaMko9mKdc082qcEKyU+5MwwxFghpoDtqZvW6UafQ8z1A6BUp9d/PMHfgSWjsKA/E98hE38zOBXYcwW5+N41B1Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(41300700001)(110136005)(33656002)(83380400001)(2906002)(8676002)(38070700005)(64756008)(66476007)(66446008)(76116006)(66946007)(316002)(52536014)(66556008)(8936002)(5660300002)(6636002)(6506007)(71200400001)(26005)(478600001)(53546011)(7696005)(86362001)(55016003)(9686003)(921005)(122000001)(38100700002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j6oHfYE/GU7IdXC8FPZ+sQb3shOMN/EVKRPMIhgwBvVioCLEHi4IK6NbBbKx?=
 =?us-ascii?Q?7NSvePL5dqJfMB2Yw5L1JythibSS1Po5vc8f4IQdO6XEpXRJspIFBSJnh7gj?=
 =?us-ascii?Q?6yAh1BUIieQQ84kRYWIp1sywsshciwig/HufDdpdpmY166LsBbznWS95xrCr?=
 =?us-ascii?Q?OZJ8cvytskVW4UGuatBLEM69VbCMm5b4xCN2fZGgqGZq6wfvWr+j1zt/zgoR?=
 =?us-ascii?Q?GEJOxYUeLfw1XwBP8Gd5PuphzEIwl299UX853UOCT9QMKSru0lR9annoR8eF?=
 =?us-ascii?Q?iMQdh3aKwSKAg7Ny1mzocCBqH4L99kAHVWg2NO+NGhRvlsStquzvFFZNh3yO?=
 =?us-ascii?Q?6NaOsOZrT3axwvDBq7MEk1CylBKiWbfCvDFgsqW/Od/Uq/xOFldKcMOab7Fx?=
 =?us-ascii?Q?I4/m5dTyN9V76tS6NQ1zMls77oULRGGohYyc9jYqkDrlyzuD2ELVZpOm0Izs?=
 =?us-ascii?Q?ZZsRRss8DvqSziEsAMALu5sKNhBla4JS9hR9DbGNbFxnSq19p8neK7h/mTNL?=
 =?us-ascii?Q?vF0gdfGaCCNcRqPhl0eLHe2r6GZ10yJjRFAKP0FYcTaR8TjUWqJ8SbT/tuPi?=
 =?us-ascii?Q?U2eU8kRQVBVAn9TNwslCK0IM9K3HWYU3c/dDknTpv7AJlZoFCdwNZUuqPQjq?=
 =?us-ascii?Q?ueAR56eLIjsupa6xo1DYEkgvrnIavWRq1ahg1bsmdLvta2ODj066uCsznDeG?=
 =?us-ascii?Q?yf7vxRr3S93W0sWHn1FMGpjkO1P55Y7jHG2NCGGYi5/ilryrK3jVqang32i5?=
 =?us-ascii?Q?bh0tw5OJfwTlXvpbyiB1tSvGvyVzL7qtbIuPTcWYeKLfSN7XfwVrckoeG+v9?=
 =?us-ascii?Q?X0cW+1Di++qlOeG5MCe4Aq1sbUSxTYItHjBJVlhyHtaGC1po2qei31zxW+Gw?=
 =?us-ascii?Q?h0Gws9wPvACQmXXAtseZq87sWeTZR6lojSCmVr30m2mWWO0P8bu0b13nRL5y?=
 =?us-ascii?Q?udvIvTZ18uHbRgYHq9FxszTmFD43ThLyXag3reZH0BquUGzbbKEPcXkK8DOs?=
 =?us-ascii?Q?uc/1/CCbeyzr0kZkdQM9aPy0VHu0PHczR4/b4ejwPwXxS+2HKz8d26vFPiV5?=
 =?us-ascii?Q?BReTR+hFQuEqbfz6LIv1NIUw/eB+UUS8vPwpW81khHG6ZGiTJZ4MHOCVk0p5?=
 =?us-ascii?Q?fyiGCDxxWsPDEeRDexQQsUq6QX8hKJCHL+zeLJNniPdqF54uaCbSh3224Q7Z?=
 =?us-ascii?Q?qSlrG2phXE1FF1oliWJxcUJT3QNxrLiyo6hFic6MZOruvBNxlPppWTgoIxNh?=
 =?us-ascii?Q?SuuCTI7Xd2A9LKX26PizQfGeaTkcYmTYA7PcmwmFUDOP5e646mnc1hj6KyIr?=
 =?us-ascii?Q?Hw+aOGD4OE5JEw+wKC/yvFeZQ6msacywDEhri6kFQI3v4i2SbaUlWBW7XB0Q?=
 =?us-ascii?Q?9J8mPxdKgJDn7VPDlEMh5Xw6fZ7xMf9Q1HbaPe5i6ETu7Zf5+sHg3t0aOfoE?=
 =?us-ascii?Q?5Oafyts++/ItPf1Pu9KwycmelGXepRUnDxj6QdMe0QFEkBlD0Iax+xuFkoCQ?=
 =?us-ascii?Q?tEYzLdRcgj657a6xl5oWRmfI9lHDn5Q3lNOBlmcRHTHwA7nA/oNmWOIGnbZe?=
 =?us-ascii?Q?9vvcKXVdwgxwy9RqDSE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1668d6-9057-4ba0-489f-08da9093cc0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 05:42:48.4205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l0+WIXoci3xFw88RS5tplpSYANfqEzawPwiTWwtSGpNAsWDB6lXgiHKsNA3lQWm1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
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

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Wednesday, September 7, 2022 12:53 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] Revert "drm/amdgpu: drop runtime pm disablement quirk
> on several sienna cichlid cards"
>=20
> This reverts commit e2994d23d8afa2fb465fdb8cf544b736f67ab8ba.
>=20
> Frequent BACO enter/exit will cause EMI failure, so disable runtime PM
> on these server SKUs.
>=20
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 1369c25448dc..4f6473faaf24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -43,6 +43,17 @@
>  #include "amdgpu_display.h"
>  #include "amdgpu_ras.h"
>=20
> +static void amdgpu_runtime_pm_quirk(struct amdgpu_device *adev)
> +{
> +	/*
> +	 * Add below quirk on several sienna_cichlid cards to disable
> +	 * runtime pm to fix EMI failures.
> +	 */
> +	if (((adev->pdev->device =3D=3D 0x73A1) && (adev->pdev->revision =3D=3D
> 0x00)) ||
> +	    ((adev->pdev->device =3D=3D 0x73BF) && (adev->pdev->revision =3D=3D
> 0xCF)))
> +		adev->pm.rpm_mode =3D AMDGPU_RUNPM_NONE;
> +}
> +
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_gpu_instance *gpu_instance;
> @@ -176,6 +187,8 @@ int amdgpu_driver_load_kms(struct amdgpu_device
> *adev, unsigned long flags)
>  			break;
>  		}
>=20
> +		amdgpu_runtime_pm_quirk(adev);
> +
>  		if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO)
>  			dev_info(adev->dev, "Using BACO for runtime
> pm\n");
>  	}
> --
> 2.25.1
