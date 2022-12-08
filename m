Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64619C6370A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 07:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D4D10E463;
	Thu,  8 Dec 2022 07:04:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E42910E463
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 07:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bf6M+vfvf0qucoxRHpkHwWze7arBF+kERCXIiu2SdwaJ4A7h5LI2WIjBWLnFmSPpwWp4pWjHnUH+ssg/Z5eDPaLa/G0/eNTLDLzxYUGbqMdSI1JvszDFObyrT4L+RRMUoNd9FhCySZhBOOt28xs66OUfM0KZaeWb+JIfwSDDDpgj9pH6oKCSb3BQ1kA0W6Ju+8ta/tIdG042RyZmlkYiqTtuycBrppac1m05jcZrfIM+beLn8rLPXk4dTqXxL3mlx8KQ+8sEQOc8r707qHPqQ4z7gxvbbv1FKIMxS2+WXeF+FvlPcMRNff+3OtVjU/VYhyeBfYxQerQ7PHdKSjUgBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pdKalG8OXxBlMAnSVKNXN+p06slF6/wzuncBNsdsp8=;
 b=ccOn8dUo0t9S+KwHgZGdpD+25e08Tm4Ylu+qqqtdQ5AwYLLXrSBSgTCGasFAebuxCndgLx3E570DPkYn9BRoavD18kiH9WwY/ag1f6Y+OX/+0Gd1ziyY2Ie2C8l80ZK91faiYQAbfxFE5bqDgbtgQfywLmy2s58Cg0S96VvLmYvcJQG2ce2vvL3ln67RX6zh1kW2uFWy/9gOH5uw2HGl6aoipVBd1RWxuI1eOB2AdUAumx5+RuL+PxRrCGT9v3AL6fa4i5TBzkLRlZmIbLsXbik/gOPIXqun4XmDiFQF85XeF6EWhaGiCXmMgUpbHw8X94N0lqTsrfeaVY1lil6aug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pdKalG8OXxBlMAnSVKNXN+p06slF6/wzuncBNsdsp8=;
 b=A0Qn142d8uieRl9oFNxDKfvnUklcc0L8+LyKCdDugau4oS8Fpdr9t2yc4Z96DROc/Cjmz0N0c6jX1Hf16EfG0/maXZoAQ0rRA9bAXx5gX6w6HvEBJs+DWHeJB3GLRwyQcAWBIJqPyPBNmhxi/LFmJGEix6zs7BrXaeMkQwpEMg4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 07:03:54 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9440:1b9b:2878:832a]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9440:1b9b:2878:832a%3]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 07:03:54 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: handle polaris10/11 overlap asics (v2)
Thread-Topic: [PATCH] drm/amdgpu: handle polaris10/11 overlap asics (v2)
Thread-Index: AQHZCl5QN6wOS2KsWkOhc4aN8VM8Z65jkQFQ
Date: Thu, 8 Dec 2022 07:03:54 +0000
Message-ID: <DM6PR12MB2619A052415BBCEC810525ABE41D9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20221207170629.3291883-1-alexander.deucher@amd.com>
In-Reply-To: <20221207170629.3291883-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-08T07:03:52Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3317e348-4edd-454d-90fa-b6a139854b4c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|MW4PR12MB7000:EE_
x-ms-office365-filtering-correlation-id: 4a6d8d8a-c68b-418d-4e0f-08dad8ea5e70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ICZcQWeO708ydvRdJBZT0Zi3OnGGUWtAIvX1zNBYnaaO+C4vuKpjxXkQL/mXwbiQlxFyc+SNeSh3BtjGrD1S61nkg82r6whJWKWY5vjmXZIyBRhXVHl6IgO0KSlF27icibRT2f4ZZyGmMoPmKV1nnbIw01WYHedv0P6HFXiDCip7ssjgAX2NH97WfLcjbylptv11DoomF1kiB7WKAUGZSu5Ld8FiKQlba//aPSdwLhfUgYFzG4pqVsAwZy4w7/rkmqL+quIx/KHkQvfI/B8qojNjyPqz9Bz6zPc6iQ5tvnIvmW4n5Z1uxlvoKJ3ylpzPS7Qf2VuWA/SPVUXT2NHiVPbD70g4aQyCvrQ7JqKks3g1fNtOA1FNtrkpY754Jon6nFP6xTO+UP5Hzaa448UekLM//4PIPiZLC7zN1Wmitp+CTExNZUV5M5qliYDP5kMfbCpi6WAxN2s/piJQNg0PTRoYxMpZqm9XMz0pq2SfpUjYU8jNDFh7+OIlDXxKNcNHDWL4p9Ynw7ImzRBMa1VJ4eVnjoipaHovZl/h55qDdZ6yGYDXKfQzx69fZk+KP3z3wTx2HkiEkvF4882bNMyOylsVRB4XsAsvY6GJX+OnQAJ8eo80HHix/ZiHs+RLIyPebRN6McNFZRiIyca08rH9AdLHwDSIhHhIZUl4K90DKSAxd0fp/kUBbqGK00SPl/v7XHDNXwUxukoVQEJJmCFTmA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199015)(122000001)(41300700001)(186003)(83380400001)(38070700005)(5660300002)(52536014)(8936002)(2906002)(7696005)(6506007)(53546011)(71200400001)(38100700002)(478600001)(76116006)(86362001)(8676002)(64756008)(66476007)(4326008)(66556008)(66946007)(66446008)(9686003)(26005)(33656002)(316002)(55016003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YS//+SLDlMjvIN0TOHckdSH+zVh+ZqVuLUTXQ+VGSGk3yeSwPPjpRYyiReV3?=
 =?us-ascii?Q?7y2cXSPDDcANAMHaClIkytjdezmMXor9kVmn4hU3X18ruBuBprkeukQNCHHq?=
 =?us-ascii?Q?v1X08iLvzStw3vb7+k8qch3psAA+5BEdv+svatxEgO9KTRZ4CSn+fbaoNfYB?=
 =?us-ascii?Q?sPx0LstQtwSUuxovzcrcpGc15G261rtrdomuGDNxNSHf7Q57uCS4BUd88n5a?=
 =?us-ascii?Q?4hk7Cew0VOBHi+ODeGw2CgF15qx8ksyZRK7rgteydqpxMs4B3YDsuEgjKLcz?=
 =?us-ascii?Q?N0RrVcYUN778+fhtgvfn1lQp1sTBRMfrjDlspAjpFECgD5u9Ga8OELKvNY7o?=
 =?us-ascii?Q?EHlvRAIoIGPZ8Ob1e0kq78OfOQQJ/eDfSwE8xatvSC9fLYWPt9VZ1+3A5fto?=
 =?us-ascii?Q?nhsXWL6fr25J0LD3g5p03jwjZuNrifPtRHQejFeAPbOif8o3yjN5XY96Bml2?=
 =?us-ascii?Q?LIZr8OBLIuQ/DKWZ+nCW+TQv3jDa9S9CdbOcxu/DgVyjL/D0ab2L8WhPbgKj?=
 =?us-ascii?Q?SoN2YFs6QtXp4JqHvqKWCjHrEi8818C/UTMEC705M0Rsdy+tqSdIfhXtQufK?=
 =?us-ascii?Q?lGcoVOAe5tMaAoxFh8Efkohsj7EMknnRmkW6DtEKPmLcyAU3KrExsKqtkjoL?=
 =?us-ascii?Q?O7Ecj155fWHbX/rKs5d8Vsi0gOD5Ms/dkgUAlBcEc7c6wT1zKeyhF6ahaSzF?=
 =?us-ascii?Q?AVDY4z8HbVTP48nBUW/PLiVWcMdviyrNGGnWH1sHnlYSO4MdubII8EvHCYCt?=
 =?us-ascii?Q?RuOgsBVTPxi9i+Ce/ZTbSZG0DCMfqnWPYDcUxhF1HkC0s8db+YySmFWJ3JAz?=
 =?us-ascii?Q?EcVZD8IylovwX+HvdhJ6dFViJZKcmRNpaciZ2UCkd7UaERKwjRDc3pffz692?=
 =?us-ascii?Q?2XQHQeqCsKXH5qCJLzCjIfzVQ/rgzGtfEh5+PkIB2gjJJFxqwjAvmcl63/65?=
 =?us-ascii?Q?mW3ZAYffb8wny5l2Xh3dQtIUG0X4PmIg8LVJc79GW5lsXx9hvlZXA4gelQa5?=
 =?us-ascii?Q?fE0OWDmhkhUvtlujQk3/aerGDTscLj9jltzbq3bppSsXBREvntfNTICvKVHT?=
 =?us-ascii?Q?PgjqWhb9rWsPPYBm/zQN7E63Sdo/ZKp9zHEk9YSwMMg+lvYHjkZWo3QwKN/k?=
 =?us-ascii?Q?UPdtTBlrWkRnIiTza36tMlfTezHw3UA4UN3Zh1XJlJVYO8G46oW3OJ00P2Fx?=
 =?us-ascii?Q?11Ts0dXQ4OWP460aBc8MrTcn9X8QiwPjWETypTfXHuMB/vXy8SaJffxCLPEo?=
 =?us-ascii?Q?e/zvI02hdMIhd0QTTSgyw9Qyma4HPQZevBEt+KCeptpT3UbdCB2y7x8uClkW?=
 =?us-ascii?Q?3//wEf1sa2WxPjkMSbtBMuBUf9QDzA18BSuYLNJHaVXgnqkVa7k2BOCxQ0I2?=
 =?us-ascii?Q?sidvzt8ESZGYaA30kC1IOTv6BKqDsFKpI+JaLDscXwcIYwy6ApEuZbQTOZYv?=
 =?us-ascii?Q?GUUa13j1AcS6jAA0mwwQ95aQCtpo5P5HuERh6uFT+lWJz6zitJFqvVbdxPcg?=
 =?us-ascii?Q?uTiV+aIDfQrCTCuL2HdGdgwdoJfuZDS7h5YtFU7psPHtnM52qB1e0TaXN7TL?=
 =?us-ascii?Q?HEDJrKR9pA+k+7ju2PM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6d8d8a-c68b-418d-4e0f-08dad8ea5e70
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 07:03:54.4243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gP9KqGIPCorYjzZH6E7p1+Bt1Ol9yk/4V6cuRxAKKcfAb+PamhpOSY0qPtaSmF0P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

I wonder how this is observed. Any bug report related with this?

Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, December 8, 2022 1:06 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: handle polaris10/11 overlap asics (v2)
>=20
> Some special polaris 10 chips overlap with the polaris11
> DID range.  Handle this properly in the driver.
>=20
> v2: use local flags for other function calls.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 7383272c6a3a..b4f2d61ea0d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2039,6 +2039,15 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  			 "See modparam exp_hw_support\n");
>  		return -ENODEV;
>  	}
> +	/* differentiate between P10 and P11 asics with the same DID */
> +	if (pdev->device =3D=3D 0x67FF &&
> +	    (pdev->revision =3D=3D 0xE3 ||
> +	     pdev->revision =3D=3D 0xE7 ||
> +	     pdev->revision =3D=3D 0xF3 ||
> +	     pdev->revision =3D=3D 0xF7)) {
> +		flags &=3D ~AMD_ASIC_MASK;
> +		flags |=3D CHIP_POLARIS10;
> +	}
>=20
>  	/* Due to hardware bugs, S/G Display on raven requires a 1:1
> IOMMU mapping,
>  	 * however, SME requires an indirect IOMMU mapping because the
> encryption
> @@ -2108,12 +2117,12 @@ static int amdgpu_pci_probe(struct pci_dev
> *pdev,
>=20
>  	pci_set_drvdata(pdev, ddev);
>=20
> -	ret =3D amdgpu_driver_load_kms(adev, ent->driver_data);
> +	ret =3D amdgpu_driver_load_kms(adev, flags);
>  	if (ret)
>  		goto err_pci;
>=20
>  retry_init:
> -	ret =3D drm_dev_register(ddev, ent->driver_data);
> +	ret =3D drm_dev_register(ddev, flags);
>  	if (ret =3D=3D -EAGAIN && ++retry <=3D 3) {
>  		DRM_INFO("retry init %d\n", retry);
>  		/* Don't request EX mode too frequently which is attacking
> */
> --
> 2.38.1
