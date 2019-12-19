Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17E9C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 09:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A3D222C2
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 09:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tbStD5uZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A3D222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CD566EAE5;
	Thu, 19 Dec 2019 09:21:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 288E46EAE5
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 09:21:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NW5lAOJI6vhBU/lcBofEf7N/dmlCT8fuqZR2visL8ftZAXl4pWawVcSoUCTgMWt1yxyd6waS7srah5SNCx3fW+El6BhxxB1s68AuDZ6+tmaOkGiI64r8kXsa3v3ifV8XVTlvoLPTNpin9AWCdoW9JgVj82SANOuox2mu5RFZE9ucUCtjNJt5ZNZbozuiwjpGmvaaTAJc6sX+ZYqaZ7Moxgu8Jfo76LNoMlbcceCn3/90p4llSHuN/1xz4pw9ZfUo5JYKuVRVjMnDRaSWW8T1lnSUD+a9BVh8iaVPqlmYh1/J9hPLvujilnfuExvEZReDu4LWL7KbRWBVF3bRp0Sxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66JEhRaZlYTAA4KqU9+dfpR4kk4M6EROFqX+9PGij/k=;
 b=MH7bDwlYcwSAU9mj2Vg9QuunTE9T8CeRbExOgMtDM3BM5E3u7TqpdxGCUWgr63qJxVOnjDgJmFbPe6k5fHlV0+F/nB7JGJ3S+8F0wcYz7O7ijr7zYFwbo5PR3Fv4Vt230jFvSHBgN4VDzmhIgpR5xXYr+/GxzgcmIkxKnyCWongzYo7iqzAnnynKgVc6hcmkUeQ0DlSU/IzWO/hGvcY2eLkjdRgUymrX97zvTtFhM3xxIJHKKaUQ/Yvruqka0cBcZhqBHqangekJYJgMRDCISgvp7X5pOQribK5dXurT3mrD0dl9VdX2RJZNdJFstWmSrHD4zt+feOuYxYthUcxviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66JEhRaZlYTAA4KqU9+dfpR4kk4M6EROFqX+9PGij/k=;
 b=tbStD5uZAK6fz5zTGK19aElKEhOw6giNF94xQtmd+8vrJazX06uIKrV6wSqhcIhhnGKPqRmTXMQhASt2fv2GMhsvdDra8N74AxX0v+EWhviNWh8C34pwGDnIn0Ilqjjq0YuNoLQF6NsL+itnL64Wcf8DV04cUdxawhw1P/B7mdk=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (20.179.82.14) by
 MN2PR12MB3359.namprd12.prod.outlook.com (20.178.243.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Thu, 19 Dec 2019 09:21:08 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756%6]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 09:21:08 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of memory
 training(V3)
Thread-Topic: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of
 memory training(V3)
Thread-Index: AQHVthY9NIP25OwkB0q795sMqN8ic6fAx5uAgABmOrE=
Date: Thu, 19 Dec 2019 09:21:08 +0000
Message-ID: <MN2PR12MB295762CABC895D97501F9C0295520@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20191219024416.32321-1-tianci.yin@amd.com>,
 <1ffb57bb-589c-21ee-fe61-8cb5459cbd1a@amd.com>
In-Reply-To: <1ffb57bb-589c-21ee-fe61-8cb5459cbd1a@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-19T09:21:07.578Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianci.Yin@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3ec5b74-9c11-4ae4-4885-08d78464c83d
x-ms-traffictypediagnostic: MN2PR12MB3359:|MN2PR12MB3359:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB33599DB6EDBBBB945E9BEDE595520@MN2PR12MB3359.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(129404003)(189003)(199004)(4001150100001)(66556008)(5660300002)(86362001)(19627405001)(26005)(30864003)(64756008)(33656002)(4326008)(81156014)(15650500001)(66476007)(66446008)(316002)(81166006)(110136005)(54906003)(8676002)(9686003)(7696005)(55016002)(478600001)(2906002)(71200400001)(6506007)(53546011)(66946007)(76116006)(8936002)(52536014)(186003)(91956017);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3359;
 H:MN2PR12MB2957.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p5WYfE/ldm3Mf094k9wxaGj5QcIS6B/uzJj9hVadrDbJDDlWRJZsWQY08GWevzb+lngNQ+0dRDH/v9vaWmMpeg5qy/W8JMcg+1NfYFjQwJxnQIXVCjFmNUF6D/ZMPdWMW+kB4alPlAs4n1hbfp4z7X0VRF5nFrAZ603CS/y6ez+ocYPVVy1vHzxId1LjD33vL7vShYcVS3pr+ImrK7IV58fCm91sGb8zjUXpxQqabsTvWZ0+DpXxvbQoCXEDVcn20hx45XK0TDWlXeIcqLkO4c+hzAKq9Nmee0YJwf9ZYPQQYGzVTi6ebJ82pHQvUwi/LYtBwJqdvKuTuktIM0G2jb2jmB2EPCPcZ/0FGVdsectaKcmRIhDNE7KTvteJS9HYqW42Iw0aqJNKuxAvIToezSibZuL63LC1L9i84xkYxQp1A7t8xbbWRcX7/BDmzA2Isfi++2bgT9zzIXKCdw+zXkGBZAgDZ6MY4nW/hhTm6RXpKJyLBwQBKoXsb6/YrP/f
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ec5b74-9c11-4ae4-4885-08d78464c83d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 09:21:08.3082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hCKMjFTBBA6svUj2nX25B21gzM/mhiCoViq012H+SbDub8CpKllcTgsxZfX7iNW8oidD314dqaQjJtgTMgzyRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3359
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: multipart/mixed; boundary="===============1343463126=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1343463126==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB295762CABC895D97501F9C0295520MN2PR12MB2957namp_"

--_000_MN2PR12MB295762CABC895D97501F9C0295520MN2PR12MB2957namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Luben,

What a brilliant thought! Concise and easy for eyes!
Thanks so much!

Rico

________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Thursday, December 19, 2019 11:10
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <=
Feifei.Xu@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>; Long, Gang <Gang.=
Long@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of mem=
ory training(V3)

On 2019-12-18 9:44 p.m., Tianci Yin wrote:
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> The method of getting fb_loc changed from parsing VBIOS to
> taking certain offset from top of VRAM
>
> Change-Id: I053b42fdb1d822722fa7980b2cd9f86b3fdce539
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 38 ++-----------------
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 13 ++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  7 ++++
>  drivers/gpu/drm/amd/include/atomfirmware.h    | 14 -------
>  7 files changed, 26 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index a78a363b1d71..fa2cf8e7bc07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -642,9 +642,8 @@ struct amdgpu_fw_vram_usage {
>        struct amdgpu_bo *reserved_bo;
>        void *va;
>
> -     /* Offset on the top of VRAM, used as c2p write buffer.
> +     /* GDDR6 training support flag.
>        */
> -     u64 mem_train_fb_loc;
>        bool mem_train_support;
>  };
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_atombios.c
> index 9ba80d828876..fdd52d86a4d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -2022,7 +2022,7 @@ int amdgpu_atombios_init(struct amdgpu_device *adev=
)
>        if (adev->is_atom_fw) {
>                amdgpu_atomfirmware_scratch_regs_init(adev);
>                amdgpu_atomfirmware_allocate_fb_scratch(adev);
> -             ret =3D amdgpu_atomfirmware_get_mem_train_fb_loc(adev);
> +             ret =3D amdgpu_atomfirmware_get_mem_train_info(adev);
>                if (ret) {
>                        DRM_ERROR("Failed to get mem train fb location.\n"=
);
>                        return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index ff4eb96bdfb5..58f9d8c3a17a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -525,16 +525,12 @@ static int gddr6_mem_train_support(struct amdgpu_de=
vice *adev)
>        return ret;
>  }
>
> -int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev)
> +int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev)
>  {
>        struct atom_context *ctx =3D adev->mode_info.atom_context;
> -     unsigned char *bios =3D ctx->bios;
> -     struct vram_reserve_block *reserved_block;
> -     int index, block_number;
> +     int index;
>        uint8_t frev, crev;
>        uint16_t data_offset, size;
> -     uint32_t start_address_in_kb;
> -     uint64_t offset;
>        int ret;
>
>        adev->fw_vram_usage.mem_train_support =3D false;
> @@ -569,32 +565,6 @@ int amdgpu_atomfirmware_get_mem_train_fb_loc(struct =
amdgpu_device *adev)
>                return -EINVAL;
>        }
>
> -     reserved_block =3D (struct vram_reserve_block *)
> -             (bios + data_offset + sizeof(struct atom_common_table_heade=
r));
> -     block_number =3D ((unsigned int)size - sizeof(struct atom_common_ta=
ble_header))
> -             / sizeof(struct vram_reserve_block);
> -     reserved_block +=3D (block_number > 0) ? block_number-1 : 0;
> -     DRM_DEBUG("block_number:0x%04x, last block: 0x%08xkb sz, %dkb fw, %=
dkb drv.\n",
> -               block_number,
> -               le32_to_cpu(reserved_block->start_address_in_kb),
> -               le16_to_cpu(reserved_block->used_by_firmware_in_kb),
> -               le16_to_cpu(reserved_block->used_by_driver_in_kb));
> -     if (reserved_block->used_by_firmware_in_kb > 0) {
> -             start_address_in_kb =3D le32_to_cpu(reserved_block->start_a=
ddress_in_kb);
> -             offset =3D (uint64_t)start_address_in_kb * ONE_KiB;
> -             if ((offset & (ONE_MiB - 1)) < (4 * ONE_KiB + 1) ) {
> -                     offset -=3D ONE_MiB;
> -             }
> -
> -             offset &=3D ~(ONE_MiB - 1);
> -             adev->fw_vram_usage.mem_train_fb_loc =3D offset;
> -             adev->fw_vram_usage.mem_train_support =3D true;
> -             DRM_DEBUG("mem_train_fb_loc:0x%09llx.\n", offset);
> -             ret =3D 0;
> -     } else {
> -             DRM_ERROR("used_by_firmware_in_kb is 0!\n");
> -             ret =3D -EINVAL;
> -     }
> -
> -     return ret;
> +     adev->fw_vram_usage.mem_train_support =3D true;
> +     return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> index f871af5ea6f3..434fe2fa0089 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
> @@ -31,7 +31,7 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgp=
u_device *adev);
>  int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev);
>  int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>        int *vram_width, int *vram_type, int *vram_vendor);
> -int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev)=
;
> +int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev);
>  int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev);
>  int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev);
>  bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 2ff63d0414c9..ec84acdd43a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1687,6 +1687,17 @@ static int amdgpu_ttm_training_reserve_vram_fini(s=
truct amdgpu_device *adev)
>        return 0;
>  }
>
> +static void amdgpu_ttm_training_get_c2p_offset(struct amdgpu_device *ade=
v)
> +{
> +     u64 offset =3D adev->gmc.mc_vram_size;
> +     struct psp_memory_training_context *ctx =3D &adev->psp.mem_train_ct=
x;
> +
> +     if ((offset & (ONE_MiB - 1)) < (4 * ONE_KiB + 1) )
> +             offset -=3D ONE_MiB;
> +
> +     ctx->c2p_train_data_offset =3D ALIGN(offset,ONE_MiB);
> +}
> +
>  /**
>   * amdgpu_ttm_training_reserve_vram_init - create bo vram reservation fr=
om memory training
>   *
> @@ -1705,7 +1716,7 @@ static int amdgpu_ttm_training_reserve_vram_init(st=
ruct amdgpu_device *adev)
>                return 0;
>        }
>
> -     ctx->c2p_train_data_offset =3D adev->fw_vram_usage.mem_train_fb_loc=
;
> +     amdgpu_ttm_training_get_c2p_offset();
>        ctx->p2c_train_data_offset =3D (adev->gmc.mc_vram_size - GDDR6_MEM=
_TRAINING_OFFSET);
>        ctx->train_data_size =3D GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;

Well, let's take a look... what have we here? Something like this:

ctx->a =3D something;
ctx->b =3D something;
function();
ctx->c =3D something;

Now, the problem is that that function sets a member of ctx, in a *hidden* =
way.
We dont'want to hide this. That is, we want to be explicit inline. So, we w=
ant to
do it like this:

ctx->a =3D something;
ctx->b =3D something;
ctx->c =3D f(x);
ctx->d =3D something;

To become something like this:

+static u64 amdgpu_ttm_training_get_c2p_offset(u64 vram_size)
+{
+       if ((vram_size & (ONE_MiB - 1)) < (4 * ONE_KiB + 1) )
+               vram_size -=3D ONE_MiB;
+
+       return ALIGN(vram_size, ONE_MiB);
+}

...

-       ctx->c2p_train_data_offset =3D adev->fw_vram_usage.mem_train_fb_loc=
;
+       ctx->c2p_train_data_offset =3D amdgpu_ttm_training_get_c2p_offset(a=
dev->gmc.mc_vram_size);
         ctx->p2c_train_data_offset =3D (adev->gmc.mc_vram_size - GDDR6_MEM=
_TRAINING_OFFSET);
         ctx->train_data_size =3D GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;

And when someone looks at this, they can read down, the assignments, explic=
tly inline assignment
operators. It's open to see. (And maybe the '=3D' equal chars would be colu=
mn aligned. :-)

Note, that the function above doesn't need to know about dev structs and an=
ything
like that. It only needs to know about numbers, since this is what it opera=
tes on.
Input is a number. Output is a number. y =3D f(x). Minimal.

If you compare to my previous email, we just took/lifted the statements whi=
ch operate
on 'a' and put them into a function. Literally:

On 2019-12-18 3:14 p.m., Luben Tuikov wrote:
> a =3D adev->gmc.mc_vram_size;
> if ((a & (ONE_MiB - 1)) < (4 * ONE_KiB + 1))
>        a -=3D ONE_MiB;
> ctx->c2p_train_data_offset =3D ALIGN(a, ONE_MiB);

Hope this helps.

Regards,
Luben
P.S. The compiler we optimize away this function and the code flow and orde=
r, but it
would be very readable to a human.

>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.h
> index f1ebd424510c..19eb3e8456c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -66,6 +66,13 @@ struct amdgpu_copy_mem {
>        unsigned long                   offset;
>  };
>
> +/* Definitions for constance */
> +enum amdgpu_internal_constants
> +{
> +     ONE_KiB =3D 0x400,
> +     ONE_MiB =3D 0x100000,
> +};
> +
>  extern const struct ttm_mem_type_manager_func amdgpu_gtt_mgr_func;
>  extern const struct ttm_mem_type_manager_func amdgpu_vram_mgr_func;
>
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm=
/amd/include/atomfirmware.h
> index dd7cbc00a0aa..70146518174c 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -672,20 +672,6 @@ struct vram_usagebyfirmware_v2_1
>    uint16_t  used_by_driver_in_kb;
>  };
>
> -/* This is part of vram_usagebyfirmware_v2_1 */
> -struct vram_reserve_block
> -{
> -     uint32_t start_address_in_kb;
> -     uint16_t used_by_firmware_in_kb;
> -     uint16_t used_by_driver_in_kb;
> -};
> -
> -/* Definitions for constance */
> -enum atomfirmware_internal_constants
> -{
> -     ONE_KiB =3D 0x400,
> -     ONE_MiB =3D 0x100000,
> -};
>
>  /*
>    **********************************************************************=
*****
>


--_000_MN2PR12MB295762CABC895D97501F9C0295520MN2PR12MB2957namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Luben,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
What a brilliant thought! Concise and easy for eyes!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks so much!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Thursday, December 19, 2019 11:10<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@=
amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Yuan, Xiaojie &lt;Xiaoji=
e.Yuan@amd.com&gt;; Long, Gang &lt;Gang.Long@amd.com&gt;; Wang, Kevin(Yang)
 &lt;Kevin1.Wang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc=
 of memory training(V3)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2019-12-18 9:44 p.m., Tianci Yin wrote:<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt; <br>
&gt; The method of getting fb_loc changed from parsing VBIOS to<br>
&gt; taking certain offset from top of VRAM<br>
&gt; <br>
&gt; Change-Id: I053b42fdb1d822722fa7980b2cd9f86b3fdce539<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 &#43;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c&nbsp; |&nbsp; 2 &#4=
3;-<br>
&gt;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c&nbsp; | 38 &#43;&#4=
3;-----------------<br>
&gt;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h&nbsp; |&nbsp; 2 &#4=
3;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 13 &#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 7 &#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/include/atomfirmware.h&nbsp;&nbsp;&nbsp; | 1=
4 -------<br>
&gt;&nbsp; 7 files changed, 26 insertions(&#43;), 53 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index a78a363b1d71..fa2cf8e7bc07 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -642,9 &#43;642,8 @@ struct amdgpu_fw_vram_usage {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *reserved_b=
o;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *va;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Offset on the top of VRAM, used as c2p wr=
ite buffer.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* GDDR6 training support flag.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u64 mem_train_fb_loc;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool mem_train_support;<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_atombios.c<br>
&gt; index 9ba80d828876..fdd52d86a4d7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c<br>
&gt; @@ -2022,7 &#43;2022,7 @@ int amdgpu_atombios_init(struct amdgpu_devic=
e *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;is_atom_fw) {<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_atomfirmware_scratch_regs_init(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_atomfirmware_allocate_fb_scratch(adev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D amdgpu_atomfirmware_get_mem_train_fb_loc(adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D amdgpu_atomfirmware_get_mem_train_info(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERR=
OR(&quot;Failed to get mem train fb location.\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
&gt; index ff4eb96bdfb5..58f9d8c3a17a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
&gt; @@ -525,16 &#43;525,12 @@ static int gddr6_mem_train_support(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *ad=
ev)<br>
&gt; &#43;int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *=
adev)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_context *ctx =3D=
 adev-&gt;mode_info.atom_context;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned char *bios =3D ctx-&gt;bios;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct vram_reserve_block *reserved_block;<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int index, block_number;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int index;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t frev, crev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t data_offset, size;<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t start_address_in_kb;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint64_t offset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;fw_vram_usage.mem_t=
rain_support =3D false;<br>
&gt; @@ -569,32 &#43;565,6 @@ int amdgpu_atomfirmware_get_mem_train_fb_loc(=
struct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; reserved_block =3D (struct vram_reserve_bloc=
k *)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; (bios &#43; data_offset &#43; sizeof(struct atom_common_table_header));=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; block_number =3D ((unsigned int)size - sizeo=
f(struct atom_common_table_header))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; / sizeof(struct vram_reserve_block);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; reserved_block &#43;=3D (block_number &gt; 0=
) ? block_number-1 : 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;block_number:0x%04x, last bl=
ock: 0x%08xkb sz, %dkb fw, %dkb drv.\n&quot;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; block_number,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; le32_to_cpu(reserved_block-&gt;start_address_in_kb),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; le16_to_cpu(reserved_block-&gt;used_by_firmware_in_kb),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; le16_to_cpu(reserved_block-&gt;used_by_driver_in_kb));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (reserved_block-&gt;used_by_firmware_in_k=
b &gt; 0) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; start_address_in_kb =3D le32_to_cpu(reserved_block-&gt;start_address_in=
_kb);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; offset =3D (uint64_t)start_address_in_kb * ONE_KiB;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if ((offset &amp; (ONE_MiB - 1)) &lt; (4 * ONE_KiB &#43; 1) ) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset -=3D ONE_MiB;<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; offset &amp;=3D ~(ONE_MiB - 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;fw_vram_usage.mem_train_fb_loc =3D offset;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;fw_vram_usage.mem_train_support =3D true;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DRM_DEBUG(&quot;mem_train_fb_loc:0x%09llx.\n&quot;, offset);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DRM_ERROR(&quot;used_by_firmware_in_kb is 0!\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D -EINVAL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;fw_vram_usage.mem_train_support=
 =3D true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h<br>
&gt; index f871af5ea6f3..434fe2fa0089 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h<br>
&gt; @@ -31,7 &#43;31,7 @@ void amdgpu_atomfirmware_scratch_regs_init(struc=
t amdgpu_device *adev);<br>
&gt;&nbsp; int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device=
 *adev);<br>
&gt;&nbsp; int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int *vram_width, int *vram_t=
ype, int *vram_vendor);<br>
&gt; -int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *ad=
ev);<br>
&gt; &#43;int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *=
adev);<br>
&gt;&nbsp; int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *ade=
v);<br>
&gt;&nbsp; int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev)=
;<br>
&gt;&nbsp; bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device =
*adev);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ttm.c<br>
&gt; index 2ff63d0414c9..ec84acdd43a2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; @@ -1687,6 &#43;1687,17 @@ static int amdgpu_ttm_training_reserve_vram=
_fini(struct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; &#43;static void amdgpu_ttm_training_get_c2p_offset(struct amdgpu_devi=
ce *adev)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u64 offset =3D adev-&gt;gmc.mc_vram_size=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_memory_training_context *ctx =
=3D &amp;adev-&gt;psp.mem_train_ctx;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if ((offset &amp; (ONE_MiB - 1)) &lt; (4=
 * ONE_KiB &#43; 1) )<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; offset -=3D ONE_MiB;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset =3D ALIGN(=
offset,ONE_MiB);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; /**<br>
&gt;&nbsp;&nbsp; * amdgpu_ttm_training_reserve_vram_init - create bo vram r=
eservation from memory training<br>
&gt;&nbsp;&nbsp; *<br>
&gt; @@ -1705,7 &#43;1716,7 @@ static int amdgpu_ttm_training_reserve_vram_=
init(struct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset =3D adev-&gt;f=
w_vram_usage.mem_train_fb_loc;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_training_get_c2p_offset();<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;p2c_train_data_offse=
t =3D (adev-&gt;gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;train_data_size =3D =
GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;<br>
<br>
Well, let's take a look... what have we here? Something like this:<br>
<br>
ctx-&gt;a =3D something;<br>
ctx-&gt;b =3D something;<br>
function();<br>
ctx-&gt;c =3D something;<br>
<br>
Now, the problem is that that function sets a member of ctx, in a *hidden* =
way.<br>
We dont'want to hide this. That is, we want to be explicit inline. So, we w=
ant to<br>
do it like this:<br>
<br>
ctx-&gt;a =3D something;<br>
ctx-&gt;b =3D something;<br>
ctx-&gt;c =3D f(x);<br>
ctx-&gt;d =3D something;<br>
<br>
To become something like this:<br>
<br>
&#43;static u64 amdgpu_ttm_training_get_c2p_offset(u64 vram_size)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((vram_size &amp; (ONE_MiB - 1=
)) &lt; (4 * ONE_KiB &#43; 1) )<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vram_size -=3D ONE_MiB;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ALIGN(vram_size, ONE_MiB);=
<br>
&#43;}<br>
<br>
...<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset =3D ade=
v-&gt;fw_vram_usage.mem_train_fb_loc;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset =3D=
 amdgpu_ttm_training_get_c2p_offset(adev-&gt;gmc.mc_vram_size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;p2c_train_data_off=
set =3D (adev-&gt;gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;train_data_size =
=3D GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;<br>
<br>
And when someone looks at this, they can read down, the assignments, explic=
tly inline assignment<br>
operators. It's open to see. (And maybe the '=3D' equal chars would be colu=
mn aligned. :-)<br>
<br>
Note, that the function above doesn't need to know about dev structs and an=
ything<br>
like that. It only needs to know about numbers, since this is what it opera=
tes on.<br>
Input is a number. Output is a number. y =3D f(x). Minimal.<br>
<br>
If you compare to my previous email, we just took/lifted the statements whi=
ch operate<br>
on 'a' and put them into a function. Literally:<br>
<br>
On 2019-12-18 3:14 p.m., Luben Tuikov wrote:<br>
&gt; a =3D adev-&gt;gmc.mc_vram_size;<br>
&gt; if ((a &amp; (ONE_MiB - 1)) &lt; (4 * ONE_KiB &#43; 1))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a -=3D ONE_MiB;<br>
&gt; ctx-&gt;c2p_train_data_offset =3D ALIGN(a, ONE_MiB);<br>
<br>
Hope this helps.<br>
<br>
Regards,<br>
Luben<br>
P.S. The compiler we optimize away this function and the code flow and orde=
r, but it<br>
would be very readable to a human.<br>
<br>
&gt;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ttm.h<br>
&gt; index f1ebd424510c..19eb3e8456c7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
&gt; @@ -66,6 &#43;66,13 @@ struct amdgpu_copy_mem {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; offset;<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt; &#43;/* Definitions for constance */<br>
&gt; &#43;enum amdgpu_internal_constants<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ONE_KiB =3D 0x400,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ONE_MiB =3D 0x100000,<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt;&nbsp; extern const struct ttm_mem_type_manager_func amdgpu_gtt_mgr_fun=
c;<br>
&gt;&nbsp; extern const struct ttm_mem_type_manager_func amdgpu_vram_mgr_fu=
nc;<br>
&gt;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/=
drm/amd/include/atomfirmware.h<br>
&gt; index dd7cbc00a0aa..70146518174c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/include/atomfirmware.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/include/atomfirmware.h<br>
&gt; @@ -672,20 &#43;672,6 @@ struct vram_usagebyfirmware_v2_1<br>
&gt;&nbsp;&nbsp;&nbsp; uint16_t&nbsp; used_by_driver_in_kb; <br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt; -/* This is part of vram_usagebyfirmware_v2_1 */<br>
&gt; -struct vram_reserve_block<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t start_address_in_kb;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint16_t used_by_firmware_in_kb;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint16_t used_by_driver_in_kb;<br>
&gt; -};<br>
&gt; -<br>
&gt; -/* Definitions for constance */<br>
&gt; -enum atomfirmware_internal_constants<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ONE_KiB =3D 0x400,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ONE_MiB =3D 0x100000,<br>
&gt; -};<br>
&gt;&nbsp; <br>
&gt;&nbsp; /* <br>
&gt;&nbsp;&nbsp;&nbsp; ****************************************************=
***********************<br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB295762CABC895D97501F9C0295520MN2PR12MB2957namp_--

--===============1343463126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1343463126==--
