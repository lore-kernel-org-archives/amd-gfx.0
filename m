Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A73C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 06:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E72E60F91
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 06:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E72E60F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 971636E20A;
	Thu, 12 Aug 2021 06:28:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 005A96E20A
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 06:28:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqxPnDN84W4yd8dmspEuPlPAvhafCDnVUQ1GNfznYY6UCCH/cHxCN599hk13Ljgk995S8xAI17t3aMbCMOrUjOcrjQpehjO3h30LCgDADCMms5cw4GjL4RxYWv1+dIU2MfxH7Csa3MBS+0lyCJFFXLPxKfRFK2fh7C9vYKl2UlsH7xlwSWqT2oWvCWFI/3AqRNPoZiI5J1pMX7AymIW+9LrHW+ZCeu1RUK/+P6p7HlGJFIk/1/A5WjLBXezyLBLFD1t43MOPZOsZRfZSN71aq7bvBGNPrrWB/UVfBCWX81EssVY79rNjzG4/GT/ZXli2qOr0MoQQoJYwj2Sac7jMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JB40gKcJSdcJekKHZpTVL6xE9QSv2uCs0dzrSa/U4Q4=;
 b=lRu9gnfRrzDO3Oiiz8fiS4R4vn3qtTNWNIFehyylEYltfOwXbYK2m3RgCUD3RhrRZL81JggMFWxSZcbV8WDqaZPAXVQWICGRfCExxkTv5c4jguZv9ExjBym9L16c2yktG1apc1/qgJC0gTFpj17lcOXsh//c8iiVXtpGOGiFM/OWwc9T0S3Op+Zfh388y4H0qll4eiaGlxQ5cjwugDyYieeGiB7fVczwDhbU4tHlFookEhII8SOKCAfDSGLLSrJbi8lgN0wj+xVyrOLnCkw1C6DU4IuII8Rpa3Oh8kMmzfJV8v9PwWJbhGtjLhYz5QlluPTLEYf9OvAldegcWOCJtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JB40gKcJSdcJekKHZpTVL6xE9QSv2uCs0dzrSa/U4Q4=;
 b=BMx3xDPKG/2ZOM7oDiOG0zdXXhOFQtaJBTI0wY/OTSKZInyrfir3Y/jOghGfKh9k1/kqnHP69ZW6nHu/qLDgX3XCPXE8JbsliMSexVozF1mmY1SiouQ5V1vZA5APmLTFuqnaH/wG+KP3sO62SBxsfAGaeEQBml7Znki0wfE+ZW4=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5490.namprd12.prod.outlook.com (2603:10b6:303:13d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Thu, 12 Aug
 2021 06:28:32 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::ac0d:a66f:c4e0:aabb]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::ac0d:a66f:c4e0:aabb%3]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 06:28:32 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Min, Frank" <Frank.Min@amd.com>, 
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH v2 1/2] drm/amd/pm: skip to load smu microcode on sriov
 for aldebaran
Thread-Topic: [PATCH v2 1/2] drm/amd/pm: skip to load smu microcode on sriov
 for aldebaran
Thread-Index: AQHXj0GrP8oCO8ICVUqH33+crJRWeatvZ6AAgAAAPR0=
Date: Thu, 12 Aug 2021 06:28:32 +0000
Message-ID: <CO6PR12MB547361222A17D1300A6A4A84A2F99@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20210812061653.1286150-1-kevin1.wang@amd.com>
 <b3cb8f22-d89e-3dc3-83c7-94bb5890caaa@amd.com>
In-Reply-To: <b3cb8f22-d89e-3dc3-83c7-94bb5890caaa@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-12T06:28:31.841Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 961d14c2-0138-4833-9566-08d95d5a685b
x-ms-traffictypediagnostic: CO6PR12MB5490:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB54900AEA9EA83780656D2CC1A2F99@CO6PR12MB5490.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mlBwB+xc794QWX6nHoxCnIKukCjPOOzw/x+pt9GKpNTpBWfTF+suNNoY2yuhoRNcRSj8AH6MpXUNWOo/ooUf/VTthBx2x+xdFbHvNtt16amhYn7UVZ6XqMQcy1L14RaEgjcDB6baan8b0dplJ9BudrGFkqG+15fHHrp5UOtb1RWXU10LSlMbrXO6SE7v4zoiCL+rehw3fuvy3cdP+ncrIdRQgUx/EeWO+e8tqZ1rWf96sy9FxLuqTBAhPV2noRep0fvWbEuuIXQAY9cbhKWUskSyF9XykLyOHZaZvI9MfTfVZPmKuqSW8bRfDmYTsjIiu/gtL8VxI/roMB2U2kTAFhoaQnmRAp44p+oTQh8zcBkFUJkzpZQRAdruSFLYa1sKzp8JxZzpYZU917zmmA97Fo4+/xWAjEFoR7zF/3XcnRRiEo07Lsw0ZfAK0cPn+AnDUa9+S1MjLNiOZMbNd+CvhO74UooAvAA5U/iP3qPugygTMK9tlHoJ84EjwMWp/d1EJgqbVkFKroZm8FiTRLEvAtznnvVi4iLEbKpwIbHqTJDS89uDnWQ8cIW/4R+vwt0bE2qI/hOYlqChPH/Pk8wyW/0UqR9tZYo7DxEF2B2gXBwfTBwUBpvoKi3wZkjW0FRjTB2cLt9S0tkU/rUh+CbT7cWqC5FJVtY0SgAw1oU/+CRclkQ3zxYiZcjh9I8tjqtATtE1ORvXi+cx1G1IMcqBFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(54906003)(53546011)(6506007)(2906002)(508600001)(86362001)(316002)(186003)(38070700005)(122000001)(5660300002)(110136005)(4326008)(91956017)(9686003)(38100700002)(52536014)(8676002)(66446008)(55016002)(66946007)(76116006)(7696005)(64756008)(8936002)(19627405001)(83380400001)(71200400001)(66556008)(33656002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+ZBjfqQkREVjjKX5QwIf30qLz7+HHhSN26z5RX1sgPknR57SdFdWPn5k+6?=
 =?iso-8859-1?Q?lGyOnmZ0orBVeWqYbosearCH9dRgyRHPf270IfGOLTKj8SL6qbDP6xdsdJ?=
 =?iso-8859-1?Q?WIgnpwo7qiAKScdRAE9IMPzQ3eNu3Og/9VkFgfZ4DzZ4OhBWWVcGsQrUPC?=
 =?iso-8859-1?Q?5C2wEhHJA/Ph34CYczVtRQGnZDMkPwF3F3cESNrVoUWGXdFyVUtACB4SH5?=
 =?iso-8859-1?Q?Gh+yunIqjAse7OptO4K0xVFiRg6053TG0B+FS+NFvdALeLXDJNhr2qOIXB?=
 =?iso-8859-1?Q?Y4FSmd7nq3m2/fK/8IncnKtYmkQw+Gow2lp1zIlq9JZ6vCnTMFg2Hwx1vo?=
 =?iso-8859-1?Q?P6flY+3EwPW5pPMjzAq59YyXBA/EVp53InD+txwsGloGg9SyRNGDtQQnUI?=
 =?iso-8859-1?Q?eXM4BM0kfYYTVp5CEuHXhojp7Z06qwNJkJ1aga1tKP6PHkTZxDNU/NFJZX?=
 =?iso-8859-1?Q?+8ZqVt2HQrbhGLALR7sgv/2KzCrCxDhY3ubLFBWK50x0pK69BQ06VEBSZE?=
 =?iso-8859-1?Q?X+SxHWEuZOgwb4aJtl1yxnmL2mjqiDp17OmluhL1lQARqHzSlzjEvr8wau?=
 =?iso-8859-1?Q?YhXfxgAuyfwLxm2gjq0l0Z6e8m/vR8rDBNRxFqmqVEkdEkPC3VGxcr2F3M?=
 =?iso-8859-1?Q?pnhyq7qfY2G0xViY6G2kFtTAVq/wVsKzzc/EoCTyMSu6JmxSM0RaJjVBpG?=
 =?iso-8859-1?Q?B8ukb7xm6V6x1uGkzcM2ZUuTtKKhvk+/fIBonjENdZQ5bZepD7xI7Hh9IT?=
 =?iso-8859-1?Q?llIx6uekyHnCo1l4Jrp/rh9wPpWhziSZ5Rj1Eqemk+auQq7u6XepONI7pV?=
 =?iso-8859-1?Q?XIpx0phswnGneva9G4A2we2X8qp6n1gy0WzH2pE+KhKerh/vJEtdkHfVG0?=
 =?iso-8859-1?Q?FSoFhLKKefUVzP7NBL0H364fA+jJetI9HAiWQNbStlr7N/m8tuoPN7dA9L?=
 =?iso-8859-1?Q?0iZByUqrXOXVNUw/W2LHRChxbGgVzbbxB1EA3BXdE37S9lNSBjyJXfqmEI?=
 =?iso-8859-1?Q?ZCo5B1ZgmcwdF2GpX+roaBZhOUx26i3eNSzLJwoN1bv6W/+UNrf3tMtWWY?=
 =?iso-8859-1?Q?eQpl9so5mF7tsQ5cxhAo8xtWYaBtoiiAdlohzxUEIpYXIaMUbqgLlNPL2k?=
 =?iso-8859-1?Q?C3u8mfLDqWBHCeDsepJlOJT+0Ws4t8nEsVbTkJqwyb9BX3Ig+RJF+F6Wlt?=
 =?iso-8859-1?Q?W5mQ2HfhALHiJhvZ9mWKZTVQ/AGh8vG7dpvDXHtlCgLSIqx4aq0O5J7W1O?=
 =?iso-8859-1?Q?KYoNY3gy8ECNBzg7JlqKvfsarv0u9alNdwrOvkPMgM7ey3mfzNZ4E5oMoX?=
 =?iso-8859-1?Q?gz27Vf90mc0AB/H/3c9blUJgBWY9cnECu0WjKSHjZ8EaFioez2waunuRjU?=
 =?iso-8859-1?Q?0eoRGqvXN1?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB547361222A17D1300A6A4A84A2F99CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961d14c2-0138-4833-9566-08d95d5a685b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 06:28:32.7275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LxYN0IlFzKyEE0y1HYafnyhf/fSNnH2k4I6X2HSscfjwWxcOgM7VDiXlkN0nwdXq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5490
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

--_000_CO6PR12MB547361222A17D1300A6A4A84A2F99CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]



________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, August 12, 2021 2:27 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Min, Frank <Frank.Min@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH v2 1/2] drm/amd/pm: skip to load smu microcode on sriov=
 for aldebaran



On 8/12/2021 11:46 AM, Kevin Wang wrote:
> v1:
> 1. skip to load smu firmware in sriov mode for aldebaran chip
> 2. using vbios pptable if in sriov mode.
>
> v2:
> clean up smu driver code in sriov code path
>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 102 ++++++++++++------
>   1 file changed, 70 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index a421ba85bd6d..3765624d8fd6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -85,6 +85,10 @@ int smu_v13_0_init_microcode(struct smu_context *smu)
>        const struct common_firmware_header *header;
>        struct amdgpu_firmware_info *ucode =3D NULL;
>
> +     /* doesn't need to load smu firmware in IOV mode */
> +     if (amdgpu_sriov_vf(adev))
> +             return 0;
> +
>        switch (adev->asic_type) {
>        case CHIP_ALDEBARAN:
>                chip_name =3D "aldebaran";
> @@ -268,52 +272,86 @@ static int smu_v13_0_set_pptable_v2_1(struct smu_co=
ntext *smu, void **table,
>        return 0;
>   }
>
> -int smu_v13_0_setup_pptable(struct smu_context *smu)
> +static int smu_v13_0_get_pptable_from_vbios(struct smu_context *smu, voi=
d **table, uint32_t *size)
>   {
>        struct amdgpu_device *adev =3D smu->adev;
> -     const struct smc_firmware_header_v1_0 *hdr;
> -     int ret, index;
> -     uint32_t size =3D 0;
>        uint16_t atom_table_size;
>        uint8_t frev, crev;
> -     void *table;
> -     uint16_t version_major, version_minor;
> +     int ret, index;
>
> +     dev_info(adev->dev, "use vbios provided pptable\n");
> +     index =3D get_index_into_master_table(atom_master_list_of_data_tabl=
es_v2_1,
> +                                         powerplayinfo);
>
> -     if (amdgpu_smu_pptable_id >=3D 0) {
> -             smu->smu_table.boot_values.pp_table_id =3D amdgpu_smu_pptab=
le_id;
> -             dev_info(adev->dev, "override pptable id %d\n", amdgpu_smu_=
pptable_id);
> -     }
> +     ret =3D amdgpu_atombios_get_data_table(adev, index, &atom_table_siz=
e, &frev, &crev,
> +                                          (uint8_t **)&table);
> +     if (ret)
> +             return ret;
> +
> +     if (size)
> +             *size =3D atom_table_size;
> +
> +     return 0;
> +}
> +
> +static int smu_v13_0_get_pptable_from_firmware(struct smu_context *smu, =
void **table, uint32_t *size,
> +                                            uint32_t pptable_id)
> +{
> +     const struct smc_firmware_header_v1_0 *hdr;
> +     struct amdgpu_device *adev =3D smu->adev;
> +     uint16_t version_major, version_minor;
> +     int ret;
>
>        hdr =3D (const struct smc_firmware_header_v1_0 *) adev->pm.fw->dat=
a;
> +     if (!hdr)
> +             return -EINVAL;
> +
> +     dev_info(adev->dev, "use driver provided pptable %d\n", pptable_id)=
;
> +
>        version_major =3D le16_to_cpu(hdr->header.header_version_major);
>        version_minor =3D le16_to_cpu(hdr->header.header_version_minor);
> -     if (version_major =3D=3D 2 && smu->smu_table.boot_values.pp_table_i=
d > 0) {
> -             dev_info(adev->dev, "use driver provided pptable %d\n", smu=
->smu_table.boot_values.pp_table_id);
> -             switch (version_minor) {
> -             case 1:
> -                     ret =3D smu_v13_0_set_pptable_v2_1(smu, &table, &si=
ze,
> -                                                      smu->smu_table.boo=
t_values.pp_table_id);
> -                     break;
> -             default:
> -                     ret =3D -EINVAL;
> -                     break;
> -             }
> -             if (ret)
> -                     return ret;
> +     if (version_major !=3D 2) {
> +             dev_err(adev->dev, "Unsupported smu firwmare version %d.%d\=
n",
> +                     version_major, version_minor);
> +             return -EINVAL;
> +     }
>
> -     } else {
> -             dev_info(adev->dev, "use vbios provided pptable\n");
> -             index =3D get_index_into_master_table(atom_master_list_of_d=
ata_tables_v2_1,
> -                                                 powerplayinfo);
> +     switch (version_minor) {
> +     case 1:
> +             ret =3D smu_v13_0_set_pptable_v2_1(smu, table, size, pptabl=
e_id);
> +             break;
> +     default:
> +             ret =3D -EINVAL;
> +             break;
> +     }
>
> -             ret =3D amdgpu_atombios_get_data_table(adev, index, &atom_t=
able_size, &frev, &crev,
> -                                                  (uint8_t **)&table);
> -             if (ret)
> -                     return ret;
> -             size =3D atom_table_size;
> +     return 0;

Probably, this should be
        return ret;

Fix it before submit. Apart from that series is
        Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

[kevin]:

good catch, thanks lijo.

Best Regards,
Kevin

> +}
> +
> +int smu_v13_0_setup_pptable(struct smu_context *smu)
> +{
> +     struct amdgpu_device *adev =3D smu->adev;
> +     uint32_t size =3D 0, pptable_id =3D 0;
> +     void *table;
> +     int ret =3D 0;
> +
> +     /* override pptable_id from driver parameter */
> +     if (amdgpu_smu_pptable_id >=3D 0) {
> +             pptable_id =3D amdgpu_smu_pptable_id;
> +             dev_info(adev->dev, "override pptable id %d\n", pptable_id)=
;
> +     } else {
> +             pptable_id =3D smu->smu_table.boot_values.pp_table_id;
>        }
>
> +     /* force using vbios pptable in sriov mode */
> +     if (amdgpu_sriov_vf(adev) || !pptable_id)
> +             ret =3D smu_v13_0_get_pptable_from_vbios(smu, &table, &size=
);
> +     else
> +             ret =3D smu_v13_0_get_pptable_from_firmware(smu, &table, &s=
ize, pptable_id);
> +
> +     if (ret)
> +             return ret;
> +
>        if (!smu->smu_table.power_play_table)
>                smu->smu_table.power_play_table =3D table;
>        if (!smu->smu_table.power_play_table_size)
>

--_000_CO6PR12MB547361222A17D1300A6A4A84A2F99CO6PR12MB5473namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
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
<b>Sent:</b> Thursday, August 12, 2021 2:27 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Min, Frank &lt;Frank=
.Min@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2 1/2] drm/amd/pm: skip to load smu microcode o=
n sriov for aldebaran</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
<br>
On 8/12/2021 11:46 AM, Kevin Wang wrote:<br>
&gt; v1:<br>
&gt; 1. skip to load smu firmware in sriov mode for aldebaran chip<br>
&gt; 2. using vbios pptable if in sriov mode.<br>
&gt; <br>
&gt; v2:<br>
&gt; clean up smu driver code in sriov code path<br>
&gt; <br>
&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbsp;&nbs=
p; | 102 ++++++++++++------<br>
&gt;&nbsp;&nbsp; 1 file changed, 70 insertions(+), 32 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
&gt; index a421ba85bd6d..3765624d8fd6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
&gt; @@ -85,6 +85,10 @@ int smu_v13_0_init_microcode(struct smu_context *sm=
u)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct common_firmware=
_header *header;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_firmware_info =
*ucode =3D NULL;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* doesn't need to load smu firmware in IOV =
mode */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ALDEBARAN:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; chip_name =3D &quot;aldebaran&quot;;<br>
&gt; @@ -268,52 +272,86 @@ static int smu_v13_0_set_pptable_v2_1(struct smu=
_context *smu, void **table,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -int smu_v13_0_setup_pptable(struct smu_context *smu)<br>
&gt; +static int smu_v13_0_get_pptable_from_vbios(struct smu_context *smu, =
void **table, uint32_t *size)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D smu-&gt;adev;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; const struct smc_firmware_header_v1_0 *hdr;<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int ret, index;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t atom_table_size;<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t frev, crev;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; void *table;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint16_t version_major, version_minor;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int ret, index;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;use vbios provi=
ded pptable\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; index =3D get_index_into_master_table(atom_m=
aster_list_of_data_tables_v2_1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; powerplayinfo);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_smu_pptable_id &gt;=3D 0) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; smu-&gt;smu_table.boot_values.pp_table_id =3D amdgpu_smu_pptable_id;<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_info(adev-&gt;dev, &quot;override pptable id %d\n&quot;, amdgpu_smu=
_pptable_id);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_atombios_get_data_table(adev,=
 index, &amp;atom_table_size, &amp;frev, &amp;crev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t **)&amp;table);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (size)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *size =3D atom_table_size;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int smu_v13_0_get_pptable_from_firmware(struct smu_context *sm=
u, void **table, uint32_t *size,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pptable_id)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const struct smc_firmware_header_v1_0 *hdr;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint16_t version_major, version_minor;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdr =3D (const struct smc_fi=
rmware_header_v1_0 *) adev-&gt;pm.fw-&gt;data;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!hdr)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;use driver prov=
ided pptable %d\n&quot;, pptable_id);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; version_major =3D le16_to_cp=
u(hdr-&gt;header.header_version_major);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; version_minor =3D le16_to_cp=
u(hdr-&gt;header.header_version_minor);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (version_major =3D=3D 2 &amp;&amp; smu-&g=
t;smu_table.boot_values.pp_table_id &gt; 0) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_info(adev-&gt;dev, &quot;use driver provided pptable %d\n&quot;, sm=
u-&gt;smu_table.boot_values.pp_table_id);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; switch (version_minor) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case 1:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_set_p=
ptable_v2_1(smu, &amp;table, &amp;size,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_table.boot_values.pp_table_id);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; default:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D -EINVAL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (version_major !=3D 2) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err(adev-&gt;dev, &quot;Unsupported smu firwmare version %d.%d\n&qu=
ot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; version_major, version_=
minor);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_info(adev-&gt;dev, &quot;use vbios provided pptable\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; index =3D get_index_into_master_table(atom_master_list_of_data_tables_v=
2_1,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; power=
playinfo);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; switch (version_minor) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case 1:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_v13_0_set_pptable_v2_1(smu, table, size, pptable_id);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D -EINVAL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D amdgpu_atombios_get_data_table(adev, index, &amp;atom_table_siz=
e, &amp;frev, &amp;crev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 (uint8_t **)&amp;table);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; size =3D atom_table_size;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
<br>
Probably, this should be<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
<br>
Fix it before submit. Apart from that series is<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Reviewed-by: Lijo Lazar &lt;lijo=
.lazar@amd.com&gt;</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">good catch, thanks lijo.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Best Regards,</div>
<div class=3D"PlainText">Kevin</div>
<div class=3D"PlainText"><br>
&gt; +}<br>
&gt; +<br>
&gt; +int smu_v13_0_setup_pptable(struct smu_context *smu)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size =3D 0, pptable_id =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; void *table;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* override pptable_id from driver parameter=
 */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_smu_pptable_id &gt;=3D 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pptable_id =3D amdgpu_smu_pptable_id;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_info(adev-&gt;dev, &quot;override pptable id %d\n&quot;, pptable_id=
);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pptable_id =3D smu-&gt;smu_table.boot_values.pp_table_id;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* force using vbios pptable in sriov mode *=
/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) || !pptable_id)<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_v13_0_get_pptable_from_vbios(smu, &amp;table, &amp;size);<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_v13_0_get_pptable_from_firmware(smu, &amp;table, &amp;size,=
 pptable_id);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;smu_table.power=
_play_table)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; smu-&gt;smu_table.power_play_table =3D table;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;smu_table.power=
_play_table_size)<br>
&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB547361222A17D1300A6A4A84A2F99CO6PR12MB5473namp_--
