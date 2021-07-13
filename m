Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA1CC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 08:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB7C6127C
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 08:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB7C6127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52DEB6E053;
	Tue, 13 Jul 2021 08:32:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F3946E053
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 08:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmb6ci/F6CRc2bK/O47c5ofoqBefQS80GU6wfL4shwCbybEjmYOiVDRjtA5bfnufKx4mpnPZPG9wbLXXTqXYSUTGiud2/c/cXq0m2ulgDnW6H7VQd8YDixauf1tczu4vP1UsGEry5amA8xOoK24QIH02WtSsg9sVqRg4u59xoOVAIoVQIhese/HIrfJGBErchl+1JW95/ySVcTimvGZTD26+e2JI+hpiHZT5SyytZbPbYX5k78D7JE1vveiO61Q5CoKHY2SuFAC79RlSLXGkzEzE+Qmchh5nD5aoxXyQYOOs6TTchi3UAeCD/eLhO0RYM3i5uU9Lix/uJnXiCSGxFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg0Mcs6G3XhN4MZm1cIQkfXod2tcDsHzElSDK/Ynkqs=;
 b=YuQUus9cjYCR+S4bsbLgF4sTWOn/oKheeTtZ7ctJqwtb+Yc/AOoNKe3uyTVRIbKje4hl7Pn7iNz5f0PY9EPCY3cGNyaZQFGImI7v75d8gtmzzyvYhW1p8IkowT0wnRDlpiVvYv/i+YfX4O9ArzwWtK4cvahJ5Hh6wv59le3wd52nclBsNY0+rdVO4nDU+y9hTItWBApxnxsOh9co3cHFszAA1q+N49WSa3E/2bmE05d9ZhN2pXfgM9SnNPiLBjlGj5zUWh27ZWchNBgy2C28m785HpjSpBEzKFmNsPSCDqqJ02qkZ49sg/UIl6om4ykb8N0K5JIHeqUpVYrH+IyCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg0Mcs6G3XhN4MZm1cIQkfXod2tcDsHzElSDK/Ynkqs=;
 b=mnI5ekVF/i+Hd99skcBV4RLjI/KfRN2Ug0Qep1GWGtbEQNWnQDe8N+GGMb/3PrMcpWwG6n80gRKC8WsRAVbnH1xeVMi6Qwm51JOcidkaighR3k06+0VundZeDXOor6RbON2AEY+iCzlVbL6w5N1H9mXu3C3LAI55iy96+F/9Ng4=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Tue, 13 Jul
 2021 08:32:06 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::4117:5516:ddb7:1514]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::4117:5516:ddb7:1514%9]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 08:32:06 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [RFC PATCH v2] drm/amdgpu/ttm: optimize vram access in
 amdgpu_ttm_access_memory()
Thread-Topic: [RFC PATCH v2] drm/amdgpu/ttm: optimize vram access in
 amdgpu_ttm_access_memory()
Thread-Index: AQHXd5Z/R1cp4Ml1hEOmfv7CYfhoSqtAfW4AgAAS2Jo=
Date: Tue, 13 Jul 2021 08:32:06 +0000
Message-ID: <CO6PR12MB54734AF103090E1C567E4EF7A2149@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20210713032329.7393-1-kevin1.wang@amd.com>,
 <8536eff2-c869-9b06-2586-0f3cef928a96@gmail.com>
In-Reply-To: <8536eff2-c869-9b06-2586-0f3cef928a96@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-13T08:32:05.959Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24092b6d-037e-42b5-ec94-08d945d8b310
x-ms-traffictypediagnostic: CO6PR12MB5411:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB54119526B35D421B9D0ECD87A2149@CO6PR12MB5411.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QPYPpGjzcq1QqIuQXKUw3eOCr8JDchwe9i8CJtDrv4fyLX2ZpQgPl6sgzerLt/1SEmBkjWyeSTyc0YL5zIM8L8efc9X4oxK4jcvhxG/+v1nM21soNX0vHpOoXqUmua1RYdQ80NFbjf3k2lsVC+RnuUHJRD+gRdOTKg1vJbINlO1nDnGFjxiO6oUKJAejBGuV0DLffCAvaj8z4y9KNfVlLD7ON5yRzKnMfOxQcB5FXJIGo+4zJQjsxSkCCQdelPd8r9ti0gHr8m+rFXvjjzuOJd75Oa0fEUlEHZsTfl/xPOKYwCdk2rFexTnPOOuIjx1d2N5FAAgb29ZC2UtXSO6SqgMLnD5V2yUYlGArYX+Rj8dHvRGPD5C/bVTaxL2EmLwdUP1OVVCDGOqz9EcHMcT/B8YlSygEuUA2K4W1efwmFfmWBQuaFZAa1v9loVVHW4IDJZT9vdGAhVbWuZERoO3GGr+Qs2GqZECDxeRB0pxeWx17a6dz22sviiDlKeOkKgqyYwU9i05M7N4BatS2yO9RQcmVHJq5m/sXhovZ+SL/EE1VqGgHgo6YbP4iLkjhbNLrMaZjjVz05uxHaiFXoZm5/088dOJA6dkgUhUxQviOu1JtRijXEN0hXWUF+hQ3uAtviFS0mMiyIN8P5GfopmTITQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(64756008)(86362001)(110136005)(4326008)(66446008)(66556008)(122000001)(19627405001)(9686003)(8676002)(38100700002)(316002)(66946007)(52536014)(26005)(6506007)(66476007)(76116006)(91956017)(33656002)(8936002)(7696005)(186003)(53546011)(71200400001)(55016002)(478600001)(83380400001)(66574015)(54906003)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NljMyJ84uECBp7zLs71ccFXRJqoVR0ogrm0y1AnLAwohXAH79qYTISEJT1?=
 =?iso-8859-1?Q?evbjs/V56PVzADn+DuzSL+BI9ZNtNHkG2vwZOBS1sZXmy7K5WxAL1F6xYl?=
 =?iso-8859-1?Q?UmJ3nr0OQMeBuIv+TaMb113tGzeyYANHFsPLsgrUXSITUhOEkwl8ZFAdTh?=
 =?iso-8859-1?Q?/RygdI1Shokqtey2y1SPADuM+MH2ogVZ15UXDlSMjA+iZi6v7U8dyzdXTh?=
 =?iso-8859-1?Q?CEO6ULWiqHGJs41Ys3KLhBgjz8RfpdnHHcv7MMUliQ9hvD1FwSm+ZNTi+O?=
 =?iso-8859-1?Q?D+t1yodU+iXf19Eq04Ms7whN6jaKZR5XBq3FcznBtdmNVs1KgCpT8idMkw?=
 =?iso-8859-1?Q?G/TM5V4C6TO1eT/IYP1PieumBCEz/Lq7aljJcCmn80PNJWbTolrBQ7wLnq?=
 =?iso-8859-1?Q?ie56N8PtBvoTKyNDWt363dH74AFDvH+XuGR7xNdgKcjghtG4digmR69gLI?=
 =?iso-8859-1?Q?ErwJTMNZv9snfRl8d2ySLL3wDcFpa29dZhRse4vsfA3zXhfvexYEoGvGNl?=
 =?iso-8859-1?Q?yXtI6U/K4+aMWnsLzFRHuorBPJQr8Ff+uvTyknzFsIC2OoYeqCHx9R7dEZ?=
 =?iso-8859-1?Q?iFTAKrGMFnpESdkiZemzJxN7/QImrr/waibyVriZWmQxMRRVyBg8QkQP4n?=
 =?iso-8859-1?Q?EFYPF4BOXSygL0EPmbhpMQlpMYfkovDt9o8but9SpeXrK1sTU56MO7N6f7?=
 =?iso-8859-1?Q?xlqOZxc5K621H7CW61h0/YAZ7OqG4X4e+fJczD5XlhmRlJvdrvEgzAE5Xf?=
 =?iso-8859-1?Q?NOO9iIvdRWTnPXiCQwwFtIJZ4pHNPx0zkE27+s+E/d9HMkV9HxANZ3Av+l?=
 =?iso-8859-1?Q?nrCkxA26dzdQLa0CpzQsWPgVirtCIYfV+m6Vc4bjy/7SznHlRaJ0ryU6rT?=
 =?iso-8859-1?Q?b1rRMnPmdb4LI1ItMDuBr1E5K1SCZbXY9neaBG2XTjj8jny2SJfAsnqqnH?=
 =?iso-8859-1?Q?DAdWKSemO9b4HqqXUeapX79/MJNsZKW3mVdeyJCgNBlEC7N+1KciCV0CwF?=
 =?iso-8859-1?Q?XDQCJY+3RMfNwaT8WYNOlnJX8urrVjW03yUdR/0rJ3zSx9ZDd2d5ttFEH5?=
 =?iso-8859-1?Q?B9b85Qy/MzxMyYuWp1ipi7p0oh9PNKofv3nJW9CiX6j0HPQH2HQm0RtyJC?=
 =?iso-8859-1?Q?gpraQwH556NJguBTnOQd0HNYApGofMlAvKIrYm50LjsqSSwdrXBnEwUauB?=
 =?iso-8859-1?Q?YlLARYDNXtI2wyfc9603x5CPRWtVct8/CwXWMNzbYEYAQVp2cu/XeEDjGm?=
 =?iso-8859-1?Q?7lgDkNo9R4lrDgKnnuGBatL1t+cd8CjYSM0PqbWnD0u0d8G6PIuLoXO/hI?=
 =?iso-8859-1?Q?zB0hdUtFY8TZvpAshhIT9TOcASkpQgTRzliWBwuqRnwVU0S55fwIV7vl/R?=
 =?iso-8859-1?Q?JLNMJwf8XG?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24092b6d-037e-42b5-ec94-08d945d8b310
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 08:32:06.7914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ofDeg+DMxqAh6BQm8Zj0FjdgBNcCelR0eh5Z6OIeCINcrQmSSEXMYt8+OjHI0NH6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5411
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Min, Frank" <Frank.Min@amd.com>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1381395208=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1381395208==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CO6PR12MB54734AF103090E1C567E4EF7A2149CO6PR12MB5473namp_"

--_000_CO6PR12MB54734AF103090E1C567E4EF7A2149CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

<comments inline>

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Tuesday, July 13, 2021 3:11 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Deucher, Alexander <Alexander.Deucher=
@amd.com>; Min, Frank <Frank.Min@amd.com>; Koenig, Christian <Christian.Koe=
nig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [RFC PATCH v2] drm/amdgpu/ttm: optimize vram access in amdgpu_=
ttm_access_memory()

Am 13.07.21 um 05:23 schrieb Kevin Wang:
> 1. using vram aper to access vram if possible
> 2. avoid MM_INDEX/MM_DATA is not working when mmio protect feature is
> enabled.
>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 126 +++++++++++++++++-------
>   1 file changed, 89 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 2aa2eb5de37a..8f6f605bc459 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1407,6 +1407,91 @@ static bool amdgpu_ttm_bo_eviction_valuable(struct=
 ttm_buffer_object *bo,
>        return ttm_bo_eviction_valuable(bo, place);
>   }
>
> +static void amdgpu_ttm_vram_mm_align_access(struct amdgpu_device *adev, =
loff_t pos,
> +                                         uint32_t *value, bool write)

Please drop the _vram_ and _align_ part from the name. Just
amdgpu_device_mm_access.

[kevin]: I will correct it in next patch.

> +{
> +     unsigned long flags;
> +
> +     BUG_ON(!IS_ALIGNED(pos, 4));
> +
> +     spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> +     WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> +     WREG32_NO_KIQ(mmMM_INDEX_HI, pos >> 31);
> +     if (write)
> +             WREG32_NO_KIQ(mmMM_DATA, *value);
> +     else
> +             *value =3D RREG32_NO_KIQ(mmMM_DATA);
> +     spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
> +}

That should still be in amdgpu_device.c and you completely messed up the
drm_dev_enter()/drm_dev_exit() annotation.

Looks like you are working on an old branch where that is not yet merged?

[kevin]: yes, I'm working on amd-staging-drm-next branch, the following pat=
ch (from drm-next-misc) is not merged into this branch.

drm/amdgpu: Guard against write accesses after device removal

This should prevent writing to memory or IO ranges possibly
already allocated for other uses after our device is removed.

v5:
Protect more places wher memcopy_to/form_io takes place
Protect IB submissions

v6: Switch to !drm_dev_enter instead of scoping entire code
with brackets.

v7:
Drop guard of HW ring commands emission protection since they
are in GART and not in MMIO.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> +
> +static void amdgpu_ttm_vram_mm_access(struct amdgpu_device *adev, loff_t=
 pos,
> +                                   void *buf, size_t size, bool write)
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
> +                     amdgpu_ttm_vram_mm_align_access(adev, aligned_pos, =
&value, false);
> +                     if (write) {
> +                             value &=3D ~mask;
> +                             value |=3D (*(uint32_t *)buf << shift) & ma=
sk;
> +                             amdgpu_ttm_vram_mm_align_access(adev, align=
ed_pos, &value, true);
> +                     } else {
> +                             value =3D (value & mask) >> shift;
> +                             memcpy(buf, &value, bytes);
> +                     }
> +             } else {
> +                     amdgpu_ttm_vram_mm_align_access(adev, aligned_pos, =
buf, write);
> +             }
> +
> +             pos +=3D bytes;
> +             buf +=3D bytes;
> +             size -=3D bytes;
> +     }
> +}
> +
> +static void amdgpu_ttm_vram_access(struct amdgpu_device *adev, loff_t po=
s,
> +                                void *buf, size_t size, bool write)
> +{
> +     uint64_t last;
> +
> +#ifdef CONFIG_64BIT
> +     last =3D min(pos + size, adev->gmc.visible_vram_size);
> +     if (last > pos) {
> +             void __iomem *addr =3D adev->mman.aper_base_kaddr + pos;
> +             size_t count =3D last - pos;
> +
> +             if (write) {
> +                     memcpy_toio(addr, buf, count);
> +                     mb();
> +                     amdgpu_device_flush_hdp(adev, NULL);
> +             } else {
> +                     amdgpu_device_invalidate_hdp(adev, NULL);
> +                     mb();
> +                     memcpy_fromio(buf, addr, count);
> +             }
> +
> +             if (count =3D=3D size)
> +                     return;
> +
> +             pos +=3D count;
> +             buf +=3D count;
> +             size -=3D count;
> +     }
> +#endif

I would put this as a separate function into amdgpu_device.c.

But all of this should only be the second step since we need a much
smaller patch for backporting first.

> +
> +     amdgpu_ttm_vram_mm_access(adev, pos, buf, size, write);
> +}
> +
>   /**
>    * amdgpu_ttm_access_memory - Read or Write memory that backs a buffer =
object.
>    *
> @@ -1426,8 +1511,6 @@ static int amdgpu_ttm_access_memory(struct ttm_buff=
er_object *bo,
>        struct amdgpu_bo *abo =3D ttm_to_amdgpu_bo(bo);
>        struct amdgpu_device *adev =3D amdgpu_ttm_adev(abo->tbo.bdev);
>        struct amdgpu_res_cursor cursor;
> -     unsigned long flags;
> -     uint32_t value =3D 0;
>        int ret =3D 0;
>
>        if (bo->mem.mem_type !=3D TTM_PL_VRAM)
> @@ -1435,41 +1518,10 @@ static int amdgpu_ttm_access_memory(struct ttm_bu=
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
> -
> -             if (mask !=3D 0xffffffff) {
> -                     spin_lock_irqsave(&adev->mmio_idx_lock, flags);
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

This here is the problematic part and should use
amdgpu_ttm_vram_access() instead.

That should be implemented first since we might need to backport that.

Regards,
Christian.

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
> +             amdgpu_ttm_vram_access(adev, cursor.start, buf, cursor.size=
, write);
> +             ret +=3D cursor.size;
> +             buf +=3D cursor.size;
> +             amdgpu_res_next(&cursor, cursor.size);
>        }
>
>        return ret;


--_000_CO6PR12MB54734AF103090E1C567E4EF7A2149CO6PR12MB5473namp_
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
&lt;comments inline&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, July 13, 2021 3:11 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Deucher, Alexander &lt;A=
lexander.Deucher@amd.com&gt;; Min, Frank &lt;Frank.Min@amd.com&gt;; Koenig,=
 Christian &lt;Christian.Koenig@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zha=
ng@amd.com&gt;<br>
<b>Subject:</b> Re: [RFC PATCH v2] drm/amdgpu/ttm: optimize vram access in =
amdgpu_ttm_access_memory()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Am 13.07.21 um 05:23 schrieb Kevin Wang:<br>
&gt; 1. using vram aper to access vram if possible<br>
&gt; 2. avoid MM_INDEX/MM_DATA is not working when mmio protect feature is<=
br>
&gt; enabled.<br>
&gt;<br>
&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 126 ++++++++++++=
+++++-------<br>
&gt;&nbsp;&nbsp; 1 file changed, 89 insertions(+), 37 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ttm.c<br>
&gt; index 2aa2eb5de37a..8f6f605bc459 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; @@ -1407,6 +1407,91 @@ static bool amdgpu_ttm_bo_eviction_valuable(str=
uct ttm_buffer_object *bo,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ttm_bo_eviction_valua=
ble(bo, place);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +static void amdgpu_ttm_vram_mm_align_access(struct amdgpu_device *ade=
v, loff_t pos,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t *value, bool write)<br>
<br>
Please drop the _vram_ and _align_ part from the name. Just <br>
amdgpu_device_mm_access.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[kevin]: I will correct it in next patch.</div>
<div class=3D"PlainText"><br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(!IS_ALIGNED(pos, 4));<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;adev-&gt;mmio_idx_loc=
k, flags);<br>
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
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock_irqrestore(&amp;adev-&gt;mmio_id=
x_lock, flags);<br>
&gt; +}<br>
<br>
That should still be in amdgpu_device.c and you completely messed up the <b=
r>
drm_dev_enter()/drm_dev_exit() annotation.<br>
<br>
Looks like you are working on an old branch where that is not yet merged?</=
div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[kevin]: yes, I'm working on amd-staging-drm-next =
branch, the following patch (from drm-next-misc) is not merged into this br=
anch.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText"></div>
drm/amdgpu: Guard against write accesses after device removal
<div><br>
</div>
<div>This should prevent writing to memory or IO ranges possibly</div>
<div>already allocated for other uses after our device is removed.</div>
<div><br>
</div>
<div>v5:</div>
<div>Protect more places wher memcopy_to/form_io takes place</div>
<div>Protect IB submissions</div>
<div><br>
</div>
<div>v6: Switch to !drm_dev_enter instead of scoping entire code</div>
<div>with brackets.</div>
<div><br>
</div>
<div>v7:</div>
<div>Drop guard of HW ring commands emission protection since they</div>
<div>are in GART and not in MMIO.</div>
<div><br>
</div>
<div>Signed-off-by: Andrey Grodzovsky &lt;andrey.grodzovsky@amd.com&gt;</di=
v>
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;
<div class=3D"PlainText"><span style=3D"box-sizing:border-box;font-family:&=
quot;Segoe UI&quot;, system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe =
UI Emoji&quot;, sans-serif;font-size:14px"></span><br>
<br>
&gt; +<br>
&gt; +static void amdgpu_ttm_vram_mm_access(struct amdgpu_device *adev, lof=
f_t pos,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *buf, siz=
e_t size, bool write)<br>
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
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_vram_mm_alig=
n_access(adev, aligned_pos, &amp;value, false);<br>
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
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_vram_mm_align_access(adev, aligned_pos,=
 &amp;value, true);<br>
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
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_vram_mm_alig=
n_access(adev, aligned_pos, buf, write);<br>
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
&gt; +static void amdgpu_ttm_vram_access(struct amdgpu_device *adev, loff_t=
 pos,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *buf, size_t size, bool wri=
te)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last;<br>
&gt; +<br>
&gt; +#ifdef CONFIG_64BIT<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; last =3D min(pos + size, adev-&gt;gmc.visibl=
e_vram_size);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (last &gt; pos) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; void __iomem *addr =3D adev-&gt;mman.aper_base_kaddr + pos;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; size_t count =3D last - pos;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (write) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_toio(addr, buf, =
count);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_flush_hdp=
(adev, NULL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_invalidat=
e_hdp(adev, NULL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_fromio(buf, addr=
, count);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (count =3D=3D size)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pos +=3D count;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; buf +=3D count;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; size -=3D count;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +#endif<br>
<br>
I would put this as a separate function into amdgpu_device.c.<br>
<br>
But all of this should only be the second step since we need a much <br>
smaller patch for backporting first.<br>
<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_vram_mm_access(adev, pos, buf, si=
ze, write);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * amdgpu_ttm_access_memory - Read or Write memory th=
at backs a buffer object.<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt; @@ -1426,8 +1511,6 @@ static int amdgpu_ttm_access_memory(struct ttm_b=
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
&gt; @@ -1435,41 +1518,10 @@ static int amdgpu_ttm_access_memory(struct ttm=
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
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (mask !=3D 0xffffffff) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;=
adev-&gt;mmio_idx_lock, flags);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(mmMM_INDE=
X, ((uint32_t)aligned_pos) | 0x80000000);<br>
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
<br>
This here is the problematic part and should use <br>
amdgpu_ttm_vram_access() instead.<br>
<br>
That should be implemented first since we might need to backport that.<br>
<br>
Regards,<br>
Christian.<br>
<br>
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
sp; amdgpu_ttm_vram_access(adev, cursor.start, buf, cursor.size, write);<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret +=3D cursor.size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; buf +=3D cursor.size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_res_next(&amp;cursor, cursor.size);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB54734AF103090E1C567E4EF7A2149CO6PR12MB5473namp_--

--===============1381395208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1381395208==--
