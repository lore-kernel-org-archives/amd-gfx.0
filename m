Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CFBC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 18:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D0560725
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 18:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D0560725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ACE36F42D;
	Thu, 29 Apr 2021 18:47:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 048916F42D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 18:47:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYo6h22jHXK2WInrAJbLvrwQNEcSe8hVAjEMUIyMbfavunSTqwQ6V8kzyIb2qD+m73DMMYfVuUY0dJJ5HMwPf4XN3lV4ZxNmx0Wqh062PC9+r4n6a4UtZYpYkbiwU+aqcb0YAZAyQhN2zDjdzUVVuIUIR/LqZaOEOHtHj1+FwIWFm2wwC2URVnSyNmOklZy6kGcYZ3SvxMDkWxBFoVqpJsrkeKSX42vKDfmXgg/6hg7K4vZMxt+1r8hmqfjwnY7/Sf6IiZHe8vFqMRBOaODfi0FPDvyeWk+NSJ3PBFTzMyyymN5qPkq1L5wnKF7EXgAUSYl2wJ6dU+ktvHQlCJzStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRt2PGnIbgNJoJZ4vcTtrLgpB5sS+A0ZIrADhTALy8M=;
 b=E6TGWnaNcsyEhGGx7HEKlXlUhvQ/UO2msJeNzdYpJBJAjj6Ft9umrHDRQSC188HhraQUgty+/sd5Axjo8QR4AI2duH89pNJpcVRinQlW8t8eSolOOfCNGuTrw6zsBiGFHqt05BE8XI8SVclk5WfGxtZQZWNyk1fUA06uhByD04F3Qon+UZ7o6H1Z+MTk3uNEWwN5akNweVHGOf0gnFKwsuqeoGgMdcwhd3f7np/XPsvhGRGHZqAGVgY8urBJWPfq1YxhC+x+EsRLTbECVNEg/tVCT1wa7hXxE3RwN15e5Lk7Gjqnr/nN2PV9j9ohGHb7wAkobWHYa4v7UzCjWbHN3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRt2PGnIbgNJoJZ4vcTtrLgpB5sS+A0ZIrADhTALy8M=;
 b=NO9IYl+kGdKpD+BZE3Twjn0GjkEpFrptnscZw5dnYN3TcCk0YAWlpO0D/+FvavNN86gh+ZSKgLSmXLFdeFhEaCjS3ALQybBmZ1KYGe5IdQVaoYcgOXc3rNaB6hdq4O8u/p/t1KJnYKApukeBhTA07IDMwj5DfZPIlrB1QDAIaHc=
Received: from DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 18:46:59 +0000
Received: from DM6PR12MB3308.namprd12.prod.outlook.com
 ([fe80::e944:a64c:ce89:112e]) by DM6PR12MB3308.namprd12.prod.outlook.com
 ([fe80::e944:a64c:ce89:112e%7]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 18:46:59 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: Add a new device ID for Aldebaran
Thread-Topic: [PATCH 1/1] drm/amdgpu: Add a new device ID for Aldebaran
Thread-Index: AQHXPSZIgnt/JT29HU2lYdUZj9VrMarL0+OAgAAANyA=
Date: Thu, 29 Apr 2021 18:46:59 +0000
Message-ID: <DM6PR12MB330837936F1191BCE7FD835BF15F9@DM6PR12MB3308.namprd12.prod.outlook.com>
References: <20210429183351.17914-1-zhigang.luo@amd.com>
 <a8683018-e0db-579a-943d-d4e08b053654@amd.com>
In-Reply-To: <a8683018-e0db-579a-943d-d4e08b053654@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e073ca9c-ec97-456e-82b8-d3f9e2ce5993;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-29T18:41:00Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.136.8.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 565f1d23-37e8-488f-f8d4-08d90b3f2bda
x-ms-traffictypediagnostic: DM6PR12MB4041:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB404131E8E5A56127E2ACBA73F15F9@DM6PR12MB4041.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yIi5iETHy/Bd+niYH8LChU+HVO09ZlnpMVVvfKLvwrzdb3fejNM5ZJ90LWTf1F/Jp+vyKgmS3yg2fioWygBbg3Xq/IPzM1c9b0C1pZiPgVw95r0VzfMi7FzwdBmo5p+Ohy3IKtKJ5j29f3ri+PZLnm2jiI1+oSm460qShMn93vMjK5CivanAp2uWFhcLwX0DoVbMqlqOhtHZ4Mb5aR5KUd+SHe3DdQnp5GPJzO1tx+5kcoOBi3DitA8pwQl0N7v4/ErMj4lxUZBmiaY6LWKHH2AG2qmT5TpRJWdTF9Btccz4sLmoI+Z3rK2hnyhqDX/HNDt44kSY6JtmNQwIYEhwb2XCNMQJ+60hrSsGXNPhG/gHIRDNFunWbHOXqt44Lez0mDJBsNLU5+EYBOwMvFDFtQ9iEfkaohdkCMd4fIaIWB2wnnDgs1UlL60F6mqYs5opfU9gXqeLFmc/IIbKTuy3bvCM2Q8mcZJeZ0KsvCkSMl1XwS6HcUQYxdtNyNh27LsQX0c+ovaWM5dIi9MMvg/8jp3jyu0yGQ7hqThq1xQE9GL4e8iGq2NGcAutX5tjwraC5usBGXcm5imIM6JW5xDN/ducSkqiz9WJWprtAJL23To=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(366004)(396003)(346002)(136003)(376002)(52536014)(8936002)(5660300002)(186003)(86362001)(110136005)(26005)(83380400001)(33656002)(53546011)(38100700002)(71200400001)(76116006)(2906002)(8676002)(478600001)(64756008)(66946007)(66556008)(66476007)(66446008)(55016002)(316002)(122000001)(6506007)(7696005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?UUxNbWJucVk0VU5RcDloRXBkcmNPS2psa3Y5cGFGK0tuQkhvQjRUUjBibHVI?=
 =?utf-8?B?Vy9kLzF1NC9GckdTYmp0eHZsd2FZUU90dXZPcC9RWVIrdzQ0R1NIK04zcTl5?=
 =?utf-8?B?WkJKeDBlS2QvV0VkSmhwTnFtNXpjUzJLdld1YW1YOE92OFdkZHpUcTIzL0Ux?=
 =?utf-8?B?T2pWZE8vamRXOGhQQlZ1YmJWZXhLNEJuS3NkdzlVV0VwM2pHUXVDenJZZEkx?=
 =?utf-8?B?YnpLWmRjUXhuNWIzMXN1eTZzS0svRlBGZks3Q2U5RjdQcVpjWkwvTy8wZ2lH?=
 =?utf-8?B?WW9kZ3BsUVR0UE9HUkRKUWIyYjR4bkkrTzNmUWdvcTNMYlJiYmNIL3JqTkE3?=
 =?utf-8?B?d1hEMHBURG9CbmNRbk83c3VkTnJvMmdZU3FUajdGNHhrNlBwN2RHMHQvYmd4?=
 =?utf-8?B?WlcxcGJsdXA2SGVWRno3M3FNWkVPclBpbVlibWhqTFlRaVNCZ2ZqNTRjc2F5?=
 =?utf-8?B?VUwxRnBFa3V2aWtwSHNPTTBWM1ByZjdoTUNzZDdDS213bTF2S0NORU83K1Rt?=
 =?utf-8?B?eGtEdkVkbUlvS3JHWVA1T3JDNkNwM0FCMldhYjZvVk1jY25SY1F0VldnMWxt?=
 =?utf-8?B?dmQ0aWNOL0loWXFZdGh4Y0VHSFZFeURHV3JNTFhneU1nNkUvOEJGdjdCTVJJ?=
 =?utf-8?B?L1psUEdJYlp4R1J1eDJDMkU3T1BRSy9IL2IvUnpMRC9VWHptbGw2ZVNpdHNE?=
 =?utf-8?B?UlVpaTBHRVFXTXZNN2lUWDNYaDRoVVd5c1crZWVqWGk3TkVhRnF3dDlGVk02?=
 =?utf-8?B?c3Y5RFljWEtHSHJOa1daRU5JaUhTYVVlWkJPanZkdU5abkl4WHVNTnJSNFAw?=
 =?utf-8?B?cm9ENS9XWUo0WjlHS1EzYkVHbmZYUTF3VGkzMFZ1a0liQXdiMkhGRFFWNGtM?=
 =?utf-8?B?MUxtUHNCLzZta2ZJbkUvenZRNjFUSzA4Qi9saGFNNFJ0QkQzenlqOWJsZTRR?=
 =?utf-8?B?TE55YjBYQ3RWK1hpTXpxc1hqTkF1ZXlVWGtsN1FqUHNKeFVSai92cGR1N1ZC?=
 =?utf-8?B?ODgwQkwxWFRNbEdUMWNVYUgvN0VIRGR4KzhmRHBMMEJMcTJUYW0vOWhnc0w3?=
 =?utf-8?B?QjZqakNNNGRqZE5vRjFQa1dYaE1XaEZZVUZ5UFdZUHZTcjlvKy9ZQWpRNFg1?=
 =?utf-8?B?VEJ1czcydUMwMmFGRk8xSmVPV1d4K05QSkxxZTF0Q0V2SXRPUEhoMytuVS9N?=
 =?utf-8?B?Z3Q5cFZXUUs1SGJLVUhnRE9UVUFMb2hKQkdaUnp5VHRKUWR5OERacnVnUUVs?=
 =?utf-8?B?LzF6ODViZlVTVEtkOTJ1U1l0anFsNkVoeEZpQjYvZ0ZIWTcyZnk2cmFGY2Nz?=
 =?utf-8?B?eXVxNXlKZlRUek03K0Foei9WQk9xRE9hRHRrVHNHVFRCdzkxK2lWc256QWx1?=
 =?utf-8?B?QWNRSVpCbHVoZ3cxK2RPTGRaSVFvN2NiQ090S2JKMk9DVVFlU0NoZndtbnNW?=
 =?utf-8?B?aTNvWHovcVpWbWliYzdoRHRLRGZadVVyV05FY3JZUGZ5WTVpYlA1dXdtcTdX?=
 =?utf-8?B?UjRYUE1jS1dYQk5YZ2dMV09sOW9ncm5JUU1iNkkwRHkwOU5jM3FtU09iNHJQ?=
 =?utf-8?B?VmVaT29BUWJPdE9qaEIvMjdqRTh5ZDhEM243MFl0TnFmN3gvd3ZYdHpMNkNJ?=
 =?utf-8?B?dUtWZUEzazhZY0FiZkd6V1VURzVlaUovYzZBdUQrdnorVGVKOVNKcXN2UU5Q?=
 =?utf-8?B?MmVqZ1dzY1VkTVppM2t3QXYxYXRkcG1PY05WVFE1ak1hRDM4Y1dGVVNSRFpF?=
 =?utf-8?Q?hX6Z2W1byofXcu89ls=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565f1d23-37e8-488f-f8d4-08d90b3f2bda
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 18:46:59.5322 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AX83TxoSd0ycQ4KkksBK/uKsj4wWoFhPP6CCiE+05sccTGUwKcBiYnIngWr59Gqs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Thanks, Felix.
Yes, I will sent out several patches for Aldebaran virtualization support soon.

Thanks,
Zhigang

-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: April 29, 2021 2:40 PM
To: Luo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/1] drm/amdgpu: Add a new device ID for Aldebaran

Am 2021-04-29 um 2:33 p.m. schrieb Zhigang Luo:
> It is Aldebaran VF device ID, for virtualization support.
>
> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>

This patch looks good to me.

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>

I believe you'll also need to add an entry for the VF in kfd_supported_devices in kfd_device.c.

Regards,
  Felix


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 0369d3532bf0..310e1249e64e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1186,6 +1186,7 @@ static const struct pci_device_id pciidlist[] = {
>  {0x1002, 0x7408, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
>  {0x1002, 0x740C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
>  {0x1002, 0x740F, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
> +{0x1002, 0x7410, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +CHIP_ALDEBARAN|AMD_EXP_HW_SUPPORT},
>
>  {0, 0, 0}
>  };
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
