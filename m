Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_LOW_CONTRAST,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F55C48BC2
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 02:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B26F61AC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 02:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B26F61AC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E28836E07F;
	Mon, 28 Jun 2021 02:44:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9C566E07F
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 02:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHbYPvhd6BLSkGhy9cKSfK8zwX9qWbKGW/cVs/q9/JsS6xhoKCxY+ks+XMiw2ZFj0yMK64V/EqHJWaaBqWgJFNp0NndLRXOQYsIqKrTzZieJmBXWVvs17en59o8TjY17uB2hDqEYqkOpEWF10zOPb634ObYXn3a2lkTg2htKauXrJ+APdj1Kr4MYIH9ClR5AtIc+dMKWaEGiMcyRffuhnq1etU62/UZlAwSO+BxwdS3zR7VGlhixl3XiGk9n5jPnK0LBgfedNtGNRheQK2QSD8OJ5mrEHzZD8zyAXECs8tyto91dVPl/FJQeRjDoqGual1HJAYzlFxVrJjSUO3ezUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QAQ6cICi4k8C3KaeE31txgEOqxDUnA6KXoSCnEukMQ=;
 b=C3tjhWKAN+CZ+maeWIEf+D4hCvaj7PaaOL0XgK08clZM7uTchCnadKMgP9orSDAId5uILPg09HKxA7AtXfCGGbNJ/4/wNQwhUgChNBfBSta8nW4MsqnaadTqGJRnRwzgqQi8xQkdwFq7xtZ54zQNW42/KW8OKH5q3bofQkKyUYlRq4EEORnd5esPiGDLXZmli0cnnbeJ2gfshtkRi1GIfGhxuVUa87Ra63CGuO1mfUYqelhYSNtENpnnMpsyr/CXeeQmL132JxjdVdWyKViGttA/3P9r66izN9B0pDcNEYWO8QHAYdwvMzixsmfpdicvvsBjclIBV+OvH6l6qnEwLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QAQ6cICi4k8C3KaeE31txgEOqxDUnA6KXoSCnEukMQ=;
 b=k7RtWN+xFPTyr6WpFENnDkK9hE7XYr51q3naOCdDlXY+yb1impN95e+hGTQXxlpmnAA4khlLlmzXj3ckO5D4//tICuxVbXLIIyN8Bg3IR9nIYze/eyDOREGGXBIAz4/L2zDCXsjZwE9wOhB8RnpWpC2TyfRPVJbFdj41tmNKVEc=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5459.namprd12.prod.outlook.com (2603:10b6:303:13b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Mon, 28 Jun
 2021 02:44:13 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c8f7:5e9d:ca99:1dbb]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c8f7:5e9d:ca99:1dbb%7]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 02:44:13 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: add non-aligned address supported in
 amdgpu_device_vram_access()
Thread-Topic: [PATCH] drm/amdgpu: add non-aligned address supported in
 amdgpu_device_vram_access()
Thread-Index: AQHXaXGaEI5Aoz2VL0q/jnCOT5QlsKskuTSAgAQBscM=
Date: Mon, 28 Jun 2021 02:44:13 +0000
Message-ID: <CO6PR12MB5473FAC04206361D8BC1C911A2039@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20210625032409.15715-1-kevin1.wang@amd.com>,
 <86c67f76-da5c-471e-16dd-03c434adac3a@amd.com>
In-Reply-To: <86c67f76-da5c-471e-16dd-03c434adac3a@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-28T02:44:12.438Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20b9ad1b-e6f2-49ff-e333-08d939de9d51
x-ms-traffictypediagnostic: CO6PR12MB5459:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB54593F5EC665AB4218F7ACF5A2039@CO6PR12MB5459.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: na8eoJKF1YzMxS3XR2+OeOFCWm16uNMgiCXXSYARCPk56OGds9rIziKhY4OW3IXytYeyDWiyddBm+9rPTDfmKInar5cbMP+5MCTbYru8HV99VjAEPhUcL4A7JGyaEwvOaGUO2bWFrDhZsTW0BcPZzyaj5VqwienNJ9uTIzY1C6aSP0dn09ab8FzxEI/mpUvrP4+VlnScOYfSFsy6nyKLqmpNj/lXt1Bsbf941JKSIl/94D1yy694bRdl4uwHQG97IKX+YJ2XMUXq4pWvfVyaCwcbD4XyboR9tq0WcdNqSR1uyfZ/RcebVlfpA7dVXmwe2xUQpdUhXv2IpAOrScj3UeM+hVyVYLX2AmEFTon9jVGYWl7KHNdt+MVj1jHU4yN9StNa/bUzhyBQAl3gW3AvgiA3pgje4kcskwASOP9x+IxLIGrikxL/hAxtO0/jFh/zQ6Trd/Uywh/L2pSWqKuPtkorjBE2+k4qtBDNxK9jmC7KKsyyfctq9IMAFmehJAbrq9I9S9yL5RDp3VYZn6h55NaTqMkCMfe/3kiKkiPKuJwqqfBc+04oGB2i24888jd+ghIY+LfeSYb/cIXhX6Ok8t6jLWJwAENjfxzWCoCnYvY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(8676002)(8936002)(83380400001)(33656002)(478600001)(186003)(122000001)(71200400001)(66946007)(38100700002)(7696005)(26005)(2906002)(53546011)(6506007)(9686003)(4326008)(5660300002)(54906003)(86362001)(110136005)(19627405001)(91956017)(55016002)(76116006)(66556008)(66446008)(66476007)(64756008)(316002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9u0STpiA9Te3oztFz1b99MgyaNRZA3apfLGrD3cngYq3wbI3vsdUeBRni/?=
 =?iso-8859-1?Q?OlyZeBT3QaxqO8ILpK8bSC6hIWLXKqms587OYWTrcnoBNJ0bGXw/8dLmEd?=
 =?iso-8859-1?Q?FnlmaqYU+rOBQDgLwK6H+QPx5MgGX6A4FLCa9YOfdymqfZjz/qgmkEThEL?=
 =?iso-8859-1?Q?NQHzzXSYT1c5PQhT4HvEf0tIq2snBT0L2JDIoaleCK+waFIdSqiUqI2pRJ?=
 =?iso-8859-1?Q?5W3M3rDCnkNhzGD1udzLSEU3fGrzPW8iisTx20f7IlH7yeZ9t1rFWKlrPj?=
 =?iso-8859-1?Q?Hm5ftec9Fr9u/J27NYUeYD1+YTyNDDLUOF6iAqIPX5ZQKtSbDSkg3LjNAi?=
 =?iso-8859-1?Q?mv6Qit3RdhRZ6gAy/n3QTXUjuqS8I8rgsgc/ehQVquZulQS0BlGzOsDhWc?=
 =?iso-8859-1?Q?A+tbLxeB5Tm/IOUMRDcb3SFZWwf/E7RN9BrJd0K4DhV6KrDJneeUPJaXeP?=
 =?iso-8859-1?Q?4kvxGOVgsxn1j+08CoWXpkfmfQGYb7tKnMAeJYuBLjiUbLH4mzt2Rc0r4v?=
 =?iso-8859-1?Q?wu8JtZXDetsbFq6gZ9D7JwbqvDmV8Njn0gdhdyMhnWPtCKOoy9YQqp6uMD?=
 =?iso-8859-1?Q?Oe8hqj3w291TvT7JpZnSnw4GyI+NY00bnhVosLa5J+wNxkz9u9lJnY3yHU?=
 =?iso-8859-1?Q?KXP2uP9ODWPHiDPDygtjvOUDT+8AfvCp7e1oeJI3vM4B0KaX8tci8JnziH?=
 =?iso-8859-1?Q?16b7mh31gfxzTrODO7kigAcfajxOKl/QK4mHme/mNKbMuCeKDDF9t5FmJZ?=
 =?iso-8859-1?Q?Ex9kTr/4xvZJkXAkGSQ7l57FAlBCL4fajofY6lvf+VutZTFngbx69AHSwL?=
 =?iso-8859-1?Q?Sjo09h6sdVXhuss09/dVSmgXb8y4uydkmk6tuYtzb+iPmew3Mch1C2jzOk?=
 =?iso-8859-1?Q?j8NQmSAOnnWuXWy2HxA2obStQW4bpv65tTu5MFsaRTUVxNOchH71THuKi6?=
 =?iso-8859-1?Q?L60pOaRKALpI5UMKOxJq+Oz0gNZeV85lamn6YI6xD3YXspGp3l83AJoQEn?=
 =?iso-8859-1?Q?hnhrh/Tiy1CVtnRVXKuyrFwm9mdc0OkYEtMLhf95/nojR1IAJFtN2lq1aO?=
 =?iso-8859-1?Q?yCawqjivp07ZWxi5dafaeHjR3BEue8EXKZZ1z/jDRx4W3bTvOeZbzjJ4Mn?=
 =?iso-8859-1?Q?+zmJtGeNVw5pYiyEi8EjA3h9mV3U3nJjrDnJrPjgJQaAzYsv/hWnWyUQ4A?=
 =?iso-8859-1?Q?6z63ulFqxNh9aYjJgHKVli2M4+j63wlH6LGKcejssDDVzwLGk2MTxJeO0n?=
 =?iso-8859-1?Q?+qo0V5ntgh7UlCj4mB7ma8t4Jno2N1Ye/SqoXR5ip1w9DH4nHtY2BwDkJM?=
 =?iso-8859-1?Q?bGn3wbNqbeWnDkv8lNoRwJFbsQ8951ivGWXT+s5q6A+641jcBzVtHfA4dO?=
 =?iso-8859-1?Q?qHm5EtvGJT?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b9ad1b-e6f2-49ff-e333-08d939de9d51
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 02:44:13.2586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0w/yHZ8gQsxLfeuL/30J9ZJhFr7U1ZSzRAsDNPBsHr2apI4BIS87TRxRXJpfuEtj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5459
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============0762284857=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0762284857==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CO6PR12MB5473FAC04206361D8BC1C911A2039CO6PR12MB5473namp_"

--_000_CO6PR12MB5473FAC04206361D8BC1C911A2039CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]



________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, June 25, 2021 9:28 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add non-aligned address supported in amdgp=
u_device_vram_access()



On 6/25/2021 8:54 AM, Kevin Wang wrote:
> 1. add non-aligned address support in amdgpu_device_vram_access()
> 2. reduce duplicate code in amdgpu_ttm_access_memory()
>
> because the MM_INDEX{HI}/DATA are protected register, it is not working
> in sriov environment when mmio protect feature is enabled (in some asics)=
,
> and the old function amdgpu_ttm_access_memory() will force using MM_INDEX=
/DATA
> to handle non-aligned address by default, it will cause the register(MM_D=
ATA)
> is always return 0.
>
> with the patch, the memory will be accessed in the aper way first.
> (in visible memory or enable pcie large-bar feature), then using
> MM_INDEX{HI}/MM_DATA to access rest vram memroy.
>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 69 ++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 42 ++-----------
>   3 files changed, 58 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index d14b4968a026..8095d9a9c857 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1103,7 +1103,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)=
;
>   int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
>
>   void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> -                            uint32_t *buf, size_t size, bool write);
> +                            void *buf, size_t size, bool write);
>   uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
>                            uint32_t reg, uint32_t acc_flags);
>   void amdgpu_device_wreg(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index e6702d136a6d..2047e3c2b365 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -280,6 +280,54 @@ bool amdgpu_device_supports_smart_shift(struct drm_d=
evice *dev)
>                amdgpu_acpi_is_power_shift_control_supported());
>   }
>
> +static inline void amdgpu_device_vram_mmio_align_access_locked(struct am=
dgpu_device *adev, loff_t pos,
> +                                                            uint32_t *va=
lue, bool write)
> +{
> +     BUG_ON(!IS_ALIGNED(pos, 4));
> +
> +     WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> +     WREG32_NO_KIQ(mmMM_INDEX_HI, pos >> 31);
> +     if (write)
> +             WREG32_NO_KIQ(mmMM_DATA, *value);
> +     else
> +             *value =3D RREG32_NO_KIQ(mmMM_DATA);
> +}
> +
> +static void amdgpu_device_vram_mmio_access_locked(struct amdgpu_device *=
adev, loff_t pos,
> +                                               void *buf, size_t size, b=
ool write)
> +{
> +     while (size) {
> +             uint64_t aligned_pos =3D ALIGN_DOWN(pos, 4);
> +             uint64_t bytes =3D 4 - (pos & 0x3);
> +             uint32_t shift =3D (pos & 0x3) * 8;
> +             uint32_t mask =3D 0xffffffff << shift;
> +             uint32_t value =3D 0;
> +
> +             if (size < bytes) {
> +                     mask &=3D 0xffffffff >> (bytes - size) * 8;
> +                     bytes =3D size;
> +             }
> +
> +             if (mask !=3D 0xffffffff) {
> +                     amdgpu_device_vram_mmio_align_access_locked(adev, a=
ligned_pos, &value, false);
> +                     if (write) {
> +                             value &=3D ~mask;
> +                             value |=3D (*(uint32_t *)buf << shift) & ma=
sk;
> +                             amdgpu_device_vram_mmio_align_access_locked=
(adev, aligned_pos, &value, true);
> +                     } else {
> +                             value =3D (value & mask) >> shift;
> +                             memcpy(buf, &value, bytes);
> +                     }
> +             } else {
> +                     amdgpu_device_vram_mmio_align_access_locked(adev, a=
ligned_pos, buf, write);
> +             }
> +
> +             pos +=3D bytes;
> +             buf +=3D bytes;
> +             size -=3D bytes;
> +     }
> +}
> +
>   /*
>    * VRAM access helper functions
>    */
> @@ -294,13 +342,11 @@ bool amdgpu_device_supports_smart_shift(struct drm_=
device *dev)
>    * @write: true - write to vram, otherwise - read from vram
>    */
>   void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> -                            uint32_t *buf, size_t size, bool write)
> +                            void *buf, size_t size, bool write)
>   {
>        unsigned long flags;
> -     uint32_t hi =3D ~0;
>        uint64_t last;
>
> -
>   #ifdef CONFIG_64BIT
>        last =3D min(pos + size, adev->gmc.visible_vram_size);
>        if (last > pos) {
> @@ -321,25 +367,12 @@ void amdgpu_device_vram_access(struct amdgpu_device=
 *adev, loff_t pos,
>                        return;
>
>                pos +=3D count;
> -             buf +=3D count / 4;
> +             buf +=3D count;
>                size -=3D count;
>        }
>   #endif
> -
>        spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> -     for (last =3D pos + size; pos < last; pos +=3D 4) {
> -             uint32_t tmp =3D pos >> 31;
> -
> -             WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> -             if (tmp !=3D hi) {
> -                     WREG32_NO_KIQ(mmMM_INDEX_HI, tmp);
> -                     hi =3D tmp;
> -             }
> -             if (write)
> -                     WREG32_NO_KIQ(mmMM_DATA, *buf++);
> -             else
> -                     *buf++ =3D RREG32_NO_KIQ(mmMM_DATA);
> -     }
> +     amdgpu_device_vram_mmio_access_locked(adev, pos, buf, size, write);
>        spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 6297363ab740..cf5b8bdc2dd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1430,8 +1430,6 @@ static int amdgpu_ttm_access_memory(struct ttm_buff=
er_object *bo,
>        struct amdgpu_bo *abo =3D ttm_to_amdgpu_bo(bo);
>        struct amdgpu_device *adev =3D amdgpu_ttm_adev(abo->tbo.bdev);
>        struct amdgpu_res_cursor cursor;
> -     unsigned long flags;
> -     uint32_t value =3D 0;
>        int ret =3D 0;
>
>        if (bo->mem.mem_type !=3D TTM_PL_VRAM)
> @@ -1439,41 +1437,13 @@ static int amdgpu_ttm_access_memory(struct ttm_bu=
ffer_object *bo,
>
>        amdgpu_res_first(&bo->mem, offset, len, &cursor);
>        while (cursor.remaining) {
> -             uint64_t aligned_pos =3D cursor.start & ~(uint64_t)3;
> -             uint64_t bytes =3D 4 - (cursor.start & 3);
> -             uint32_t shift =3D (cursor.start & 3) * 8;
> -             uint32_t mask =3D 0xffffffff << shift;
> -
> -             if (cursor.size < bytes) {
> -                     mask &=3D 0xffffffff >> (bytes - cursor.size) * 8;
> -                     bytes =3D cursor.size;
> -             }
> +             amdgpu_device_vram_access(adev, cursor.start,
> +                                       buf, cursor.size,
> +                                       write);
>
> -             if (mask !=3D 0xffffffff) {
> -                     spin_lock_irqsave(&adev->mmio_idx_lock, flags);

The new logic seems to skip this mmio_idx_lock for accessing index/data
pair ragisters. BTW, where is the visible memory aperture check?

Thanks
Lijo

[Keivn]:

Hi Lijo,
the mmio_idx_lock lock is in amdgpu_device_vram_access() function.
this patch is extending the amdgpu_device_vram_access() function to support=
 un-aligned address support.

Best Regards,
Kevin
> -                     WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)aligned_pos) |=
 0x80000000);
> -                     WREG32_NO_KIQ(mmMM_INDEX_HI, aligned_pos >> 31);
> -                     value =3D RREG32_NO_KIQ(mmMM_DATA);
> -                     if (write) {
> -                             value &=3D ~mask;
> -                             value |=3D (*(uint32_t *)buf << shift) & ma=
sk;
> -                             WREG32_NO_KIQ(mmMM_DATA, value);
> -                     }
> -                     spin_unlock_irqrestore(&adev->mmio_idx_lock, flags)=
;
> -                     if (!write) {
> -                             value =3D (value & mask) >> shift;
> -                             memcpy(buf, &value, bytes);
> -                     }
> -             } else {
> -                     bytes =3D cursor.size & ~0x3ULL;
> -                     amdgpu_device_vram_access(adev, cursor.start,
> -                                               (uint32_t *)buf, bytes,
> -                                               write);
> -             }
> -
> -             ret +=3D bytes;
> -             buf =3D (uint8_t *)buf + bytes;
> -             amdgpu_res_next(&cursor, bytes);
> +             ret +=3D cursor.size;
> +             buf +=3D cursor.size;
> +             amdgpu_res_next(&cursor, cursor.size);
>        }
>
>        return ret;
>

--_000_CO6PR12MB5473FAC04206361D8BC1C911A2039CO6PR12MB5473namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Friday, June 25, 2021 9:28 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: add non-aligned address supported i=
n amdgpu_device_vram_access()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
<br>
On 6/25/2021 8:54 AM, Kevin Wang wrote:<br>
&gt; 1. add non-aligned address support in amdgpu_device_vram_access()<br>
&gt; 2. reduce duplicate code in amdgpu_ttm_access_memory()<br>
&gt; <br>
&gt; because the MM_INDEX{HI}/DATA are protected register, it is not workin=
g<br>
&gt; in sriov environment when mmio protect feature is enabled (in some asi=
cs),<br>
&gt; and the old function amdgpu_ttm_access_memory() will force using MM_IN=
DEX/DATA<br>
&gt; to handle non-aligned address by default, it will cause the register(M=
M_DATA)<br>
&gt; is always return 0.<br>
&gt; <br>
&gt; with the patch, the memory will be accessed in the aper way first.<br>
&gt; (in visible memory or enable pcie large-bar feature), then using<br>
&gt; MM_INDEX{HI}/MM_DATA to access rest vram memroy.<br>
&gt; <br>
&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 69 ++++++++++=
++++++------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp; =
| 42 ++-----------<br>
&gt;&nbsp;&nbsp; 3 files changed, 58 insertions(+), 55 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index d14b4968a026..8095d9a9c857 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -1103,7 +1103,7 @@ void amdgpu_device_fini(struct amdgpu_device *ad=
ev);<br>
&gt;&nbsp;&nbsp; int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);<=
br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; void amdgpu_device_vram_access(struct amdgpu_device *adev,=
 loff_t pos,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; uint32_t *buf, size_t size, bool write);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; void *buf, size_t size, bool write);<br>
&gt;&nbsp;&nbsp; uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint32_t reg, uint32_t acc_flags);<br>
&gt;&nbsp;&nbsp; void amdgpu_device_wreg(struct amdgpu_device *adev,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index e6702d136a6d..2047e3c2b365 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -280,6 +280,54 @@ bool amdgpu_device_supports_smart_shift(struct dr=
m_device *dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_acpi_is_power_shift_control_supported());<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +static inline void amdgpu_device_vram_mmio_align_access_locked(struct=
 amdgpu_device *adev, loff_t pos,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *valu=
e, bool write)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(!IS_ALIGNED(pos, 4));<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | =
0x80000000);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_INDEX_HI, pos &gt;&gt; 31=
);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (write)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_NO_KIQ(mmMM_DATA, *value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *value =3D RREG32_NO_KIQ(mmMM_DATA);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void amdgpu_device_vram_mmio_access_locked(struct amdgpu_devic=
e *adev, loff_t pos,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *buf, size_t=
 size, bool write)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; while (size) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t aligned_pos =3D ALIGN_DOWN(pos, 4);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t bytes =3D 4 - (pos &amp; 0x3);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t shift =3D (pos &amp; 0x3) * 8;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t mask =3D 0xffffffff &lt;&lt; shift;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t value =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (size &lt; bytes) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mask &amp;=3D 0xfffffff=
f &gt;&gt; (bytes - size) * 8;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes =3D size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (mask !=3D 0xffffffff) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_vram_mmio=
_align_access_locked(adev, aligned_pos, &amp;value, false);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (write) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value &amp;=3D ~mask;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (*(uint32_t *)buf &lt;&lt; shift) &amp;=
 mask;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_vram_mmio_align_access_locked(adev, =
aligned_pos, &amp;value, true);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value =3D (value &amp; mask) &gt;&gt; shift;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; memcpy(buf, &amp;value, bytes);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_vram_mmio=
_align_access_locked(adev, aligned_pos, buf, write);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pos +=3D bytes;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; buf +=3D bytes;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; size -=3D bytes;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp; * VRAM access helper functions<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt; @@ -294,13 +342,11 @@ bool amdgpu_device_supports_smart_shift(struct d=
rm_device *dev)<br>
&gt;&nbsp;&nbsp;&nbsp; * @write: true - write to vram, otherwise - read fro=
m vram<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; void amdgpu_device_vram_access(struct amdgpu_device *adev,=
 loff_t pos,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; uint32_t *buf, size_t size, bool write)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; void *buf, size_t size, bool write)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi =3D ~0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -<br>
&gt;&nbsp;&nbsp; #ifdef CONFIG_64BIT<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last =3D min(pos + size, ade=
v-&gt;gmc.visible_vram_size);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (last &gt; pos) {<br>
&gt; @@ -321,25 +367,12 @@ void amdgpu_device_vram_access(struct amdgpu_dev=
ice *adev, loff_t pos,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;=
<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pos +=3D count;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; buf +=3D count / 4;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; buf +=3D count;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; size -=3D count;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;adev-=
&gt;mmio_idx_lock, flags);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; for (last =3D pos + size; pos &lt; last; pos=
 +=3D 4) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t tmp =3D pos &gt;&gt; 31;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (tmp !=3D hi) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_INDE=
X_HI, tmp);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hi =3D tmp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (write)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_DATA=
, *buf++);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *buf++ =3D RREG32_NO_KI=
Q(mmMM_DATA);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_vram_mmio_access_locked(adev, =
pos, buf, size, write);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock_irqrestore(&amp;=
adev-&gt;mmio_idx_lock, flags);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ttm.c<br>
&gt; index 6297363ab740..cf5b8bdc2dd3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; @@ -1430,8 +1430,6 @@ static int amdgpu_ttm_access_memory(struct ttm_b=
uffer_object *bo,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *abo =3D tt=
m_to_amdgpu_bo(bo);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D amdgpu_ttm_adev(abo-&gt;tbo.bdev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_res_cursor cur=
sor;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo-&gt;mem.mem_type !=3D=
 TTM_PL_VRAM)<br>
&gt; @@ -1439,41 +1437,13 @@ static int amdgpu_ttm_access_memory(struct ttm=
_buffer_object *bo,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_first(&amp;bo-&gt=
;mem, offset, len, &amp;cursor);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (cursor.remaining) {<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t aligned_pos =3D cursor.start &amp; ~(uint64_t)3;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint64_t bytes =3D 4 - (cursor.start &amp; 3);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t shift =3D (cursor.start &amp; 3) * 8;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t mask =3D 0xffffffff &lt;&lt; shift;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (cursor.size &lt; bytes) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mask &amp;=3D 0xfffffff=
f &gt;&gt; (bytes - cursor.size) * 8;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes =3D cursor.size;<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_device_vram_access(adev, cursor.start,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; buf, cursor.size,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; write);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (mask !=3D 0xffffffff) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;=
adev-&gt;mmio_idx_lock, flags);<br>
<br>
The new logic seems to skip this mmio_idx_lock for accessing index/data <br=
>
pair ragisters. BTW, where is the visible memory aperture check?<br>
<br>
Thanks<br>
Lijo</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText"><span style=3D"font-family: &quot;segoe ui&quot;, =
&quot;segoe ui web (west european)&quot;, &quot;segoe ui&quot;, -apple-syst=
em, blinkmacsystemfont, roboto, &quot;helvetica neue&quot;, sans-serif; fon=
t-size: 11pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">[Ke=
ivn]:</span></div>
<div class=3D"PlainText"><span style=3D"font-family: &quot;segoe ui&quot;, =
&quot;segoe ui web (west european)&quot;, &quot;segoe ui&quot;, -apple-syst=
em, blinkmacsystemfont, roboto, &quot;helvetica neue&quot;, sans-serif; fon=
t-size: 11pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);"><br=
>
</span></div>
<div class=3D"PlainText"><span style=3D"font-family: &quot;segoe ui&quot;, =
&quot;segoe ui web (west european)&quot;, &quot;segoe ui&quot;, -apple-syst=
em, blinkmacsystemfont, roboto, &quot;helvetica neue&quot;, sans-serif; fon=
t-size: 11pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">Hi =
Lijo,</span><br>
</div>
<div class=3D"PlainText"><span style=3D"font-family: &quot;segoe ui&quot;, =
&quot;segoe ui web (west european)&quot;, &quot;segoe ui&quot;, -apple-syst=
em, blinkmacsystemfont, roboto, &quot;helvetica neue&quot;, sans-serif; fon=
t-size: 11pt; color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">the
 mmio_idx_lock lock is in&nbsp;</span><span style=3D"color: rgb(0, 0, 0); b=
ackground-color: rgba(0, 0, 0, 0); display: inline !important; font-family:=
 &quot;segoe ui&quot;, &quot;segoe ui web (west european)&quot;, &quot;sego=
e ui&quot;, -apple-system, blinkmacsystemfont, roboto, &quot;helvetica neue=
&quot;, sans-serif; font-size: 11pt;">amdgpu_device_vram_access</span><span=
 style=3D"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); display:=
 inline !important; font-family: &quot;segoe ui&quot;, &quot;segoe ui web (=
west european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfo=
nt, roboto, &quot;helvetica neue&quot;, sans-serif; font-size: 11pt;">()
 function.</span></div>
<div class=3D"PlainText"><font color=3D"#000000"><span style=3D"font-family=
: &quot;segoe ui&quot;, &quot;segoe ui web (west european)&quot;, &quot;seg=
oe ui&quot;, -apple-system, blinkmacsystemfont, roboto, &quot;helvetica neu=
e&quot;, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); background-color=
: rgba(0, 0, 0, 0);">this
 patch is extending the&nbsp;</span><span style=3D"background-color: rgba(0=
, 0, 0, 0); font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west eur=
opean)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, robo=
to, &quot;helvetica neue&quot;, sans-serif; font-size: 11pt; color: rgb(0, =
0, 0); display: inline !important;">amdgpu_device_vram_access()
 function to support un-aligned address support.</span></font></div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Best Regards,</div>
<div class=3D"PlainText">Kevin</div>
<div class=3D"PlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)aligned_pos) | 0x80000000);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_INDE=
X_HI, aligned_pos &gt;&gt; 31);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D RREG32_NO_KIQ=
(mmMM_DATA);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (write) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value &amp;=3D ~mask;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (*(uint32_t *)buf &lt;&lt; shift) &amp;=
 mask;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_DATA, value);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock_irqrestore(=
&amp;adev-&gt;mmio_idx_lock, flags);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!write) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; value =3D (value &amp; mask) &gt;&gt; shift;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; memcpy(buf, &amp;value, bytes);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes =3D cursor.size &=
amp; ~0x3ULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_vram_acce=
ss(adev, cursor.start,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint32_t *)buf, =
bytes,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret +=3D bytes;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; buf =3D (uint8_t *)buf + bytes;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_res_next(&amp;cursor, bytes);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret +=3D cursor.size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; buf +=3D cursor.size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_res_next(&amp;cursor, cursor.size);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473FAC04206361D8BC1C911A2039CO6PR12MB5473namp_--

--===============0762284857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0762284857==--
