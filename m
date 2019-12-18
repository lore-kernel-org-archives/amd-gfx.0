Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B3FC43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 09:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B28820717
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 09:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tk1w97jF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B28820717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1B2189A74;
	Wed, 18 Dec 2019 09:14:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4004489A74
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 09:14:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ckewfrh5vyG5+HizQa4hWcodnThnALgh9vJz9mQojhhdqy9zGZ+DNLJ9UtEB/O7jS49Xys72ekOdzhoddv0hdh0ArSHh+kJv/RGOryxQydiG+H5J6H1FtbAmfjgvcQhy7YwOh3myzFNGlq3K1+7aXNceGXCnwmEROvqpk9itAQZ3TlEnwkDcHaw+vBHDQsW9Vt1OVpSlB7zC6LaJ1NKKZDutNkRHKymHeqR6yOhvwl3FN9y+L/WQ9pupe2ZWLbIgte+FAvmFFfQm2kLKBzEKgg9o3X3mRY6eLw9glqrpvHrpAgZvI6QgHFevUVWLouUGsstSgnj2m1rc4SomtUnfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knEOHrSA6DTtLS5NfcmaXk5G2FwFX8DzGsioK/l6B+w=;
 b=kXc9oyzb1In2uDlabWZf+ergJJJGONSVFyxMIh+w9A8gULK3iNAdEe2bhkXNUTPuOTRAr6fd+mHe4h4AcVJey17NkEbF+4VWSQdLZLmKk2yfrTMR+6+fBJGfLe59t/M0LrMWz+Kw5qhh1JjpTI4JGIdhyXIrsri/Hj29KNkKxr33KakO6LbaFEhzGuICBLqNJ9INnLOzJFJdzepBz2y3nsyxvniy3EEWK/FWMmIeh9T5XyAPoNZAe05VW1i5vRo7pgcazXzdDlp/JNp6jq/BmXTv6Jy9q54AEM6wANKYjBbGq9YPttOHHk652Xhc+IPqf9BGF74s/+7EIiulVqLi8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knEOHrSA6DTtLS5NfcmaXk5G2FwFX8DzGsioK/l6B+w=;
 b=tk1w97jFCXVC/uYxzN+L0gcW4yx2ftEvCt+SSRURjLuHTlS8mBBk3PWkYLUi/ge/QGP5OKyW3tvqdS8UQl9JgE8PXcrR/itDNoNi838fi5aLHQ+1VKrScNo4splatxxlT0EdriOAGhkCwDfUpVfjEjaOTxg1oCSXxTsk41meiJ8=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (20.179.82.14) by
 MN2PR12MB2909.namprd12.prod.outlook.com (20.179.82.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Wed, 18 Dec 2019 09:14:12 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756%6]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 09:14:12 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of memory
 training(V2)
Thread-Topic: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of
 memory training(V2)
Thread-Index: AQHVtYBENFQSO958p0uozCUflj9QRqe/lvIAgAABbrE=
Date: Wed, 18 Dec 2019 09:14:12 +0000
Message-ID: <MN2PR12MB2957F19B488696AF8A61D46A95530@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20191218085050.28635-1-tianci.yin@amd.com>,
 <MN2PR12MB329636BD472939B12B08EFA6A2530@MN2PR12MB3296.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB329636BD472939B12B08EFA6A2530@MN2PR12MB3296.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-18T09:14:11.484Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianci.Yin@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f558f797-6da8-4998-7306-08d7839aa5f7
x-ms-traffictypediagnostic: MN2PR12MB2909:|MN2PR12MB2909:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB290964612A10ED032746765D95530@MN2PR12MB2909.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(52314003)(199004)(189003)(8936002)(4326008)(5660300002)(26005)(316002)(54906003)(91956017)(76116006)(478600001)(86362001)(19627405001)(81156014)(81166006)(6506007)(53546011)(71200400001)(52536014)(7696005)(15650500001)(9686003)(33656002)(66446008)(2906002)(186003)(66476007)(66556008)(66946007)(55016002)(110136005)(64756008)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2909;
 H:MN2PR12MB2957.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0NjadU6lR8zvE/8Q1MC1tYtOqajZ82HfRwXDxMqvShXfwysvOW8P39XCLwe3Qs4uj5HJByQF0/Z1AP+EuuMNKAMROFPZ0XoWV7ZrZxabfhb0WVa0q5KgNSncidA7hwSryF//tNII+pUfrBfzjYnaexxCnVdRazKTUreASzE5O1IE90bJdM449mPWG6dfrhQ07HIM7EPul4UYtwMzjlOW99NkKeGjsx7ID1x18QNT79COp0y2oJEPZyWXnr9k9LochuloI9U/QceSUp7L3t8Qj+skEio9Sznx+gY8BsND8vsPOPE+XqEbZRYOv7+nypTMEHRHZxlgNQ1H616PKoSLAf5E+NodWpix6YFuDKBBaFYqqR+6TQgrU8oixdfsOh9ZY82MT9fYy2oxwm1x+rfy2fclZaGYiY6iVeukUAWTXZ1k5hXe/mE5WiS32OVJjMz7SrBD/5SUVTYzppJ22e/SQfumNjhKS4Hsop2KE0y+afA+aM/BYfbEsW7MkdIiRP5z
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f558f797-6da8-4998-7306-08d7839aa5f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 09:14:12.1218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zRW8qgwvaSZDe//28MtkzbU2Z0wYBjPwcZR3pi1EW+PduwxsXOMPfRbOy3JXHGOUOugmETb+S6Beq8lAxbxrUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2909
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: multipart/mixed; boundary="===============1221354921=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1221354921==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB2957F19B488696AF8A61D46A95530MN2PR12MB2957namp_"

--_000_MN2PR12MB2957F19B488696AF8A61D46A95530MN2PR12MB2957namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

You mean like this? It's a bit lengthy.
- ctx->c2p_train_data_offset &=3D ~(ONE_MiB - 1);
+ ctx->c2p_train_data_offset =3D ALIGN(ctx->c2p_train_data_offset, ONE_MiB)=
;

Rico

________________________________
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Wednesday, December 18, 2019 16:56
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking=
 <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Yuan, Xiaojie <Xi=
aojie.Yuan@amd.com>; Long, Gang <Gang.Long@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of mem=
ory training(V2)


[AMD Official Use Only - Internal Distribution Only]

comment inline.
________________________________
From: Tianci Yin <tianci.yin@amd.com>
Sent: Wednesday, December 18, 2019 4:50 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking=
 <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Yuan, Xiaojie <Xi=
aojie.Yuan@amd.com>; Long, Gang <Gang.Long@amd.com>; Wang, Kevin(Yang) <Kev=
in1.Wang@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of memory =
training(V2)

From: "Tianci.Yin" <tianci.yin@amd.com>

The method of getting fb_loc changed from parsing VBIOS to
taking certain offset from top of VRAM

Change-Id: I053b42fdb1d822722fa7980b2cd9f86b3fdce539
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 38 ++-----------------
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  6 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  7 ++++
 drivers/gpu/drm/amd/include/atomfirmware.h    | 14 -------
 7 files changed, 19 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index a78a363b1d71..fa2cf8e7bc07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -642,9 +642,8 @@ struct amdgpu_fw_vram_usage {
         struct amdgpu_bo *reserved_bo;
         void *va;

-       /* Offset on the top of VRAM, used as c2p write buffer.
+       /* GDDR6 training support flag.
         */
-       u64 mem_train_fb_loc;
         bool mem_train_support;
 };

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_atombios.c
index 9ba80d828876..fdd52d86a4d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -2022,7 +2022,7 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
         if (adev->is_atom_fw) {
                 amdgpu_atomfirmware_scratch_regs_init(adev);
                 amdgpu_atomfirmware_allocate_fb_scratch(adev);
-               ret =3D amdgpu_atomfirmware_get_mem_train_fb_loc(adev);
+               ret =3D amdgpu_atomfirmware_get_mem_train_info(adev);
                 if (ret) {
                         DRM_ERROR("Failed to get mem train fb location.\n"=
);
                         return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atomfirmware.c
index ff4eb96bdfb5..58f9d8c3a17a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -525,16 +525,12 @@ static int gddr6_mem_train_support(struct amdgpu_devi=
ce *adev)
         return ret;
 }

-int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev)
+int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev)
 {
         struct atom_context *ctx =3D adev->mode_info.atom_context;
-       unsigned char *bios =3D ctx->bios;
-       struct vram_reserve_block *reserved_block;
-       int index, block_number;
+       int index;
         uint8_t frev, crev;
         uint16_t data_offset, size;
-       uint32_t start_address_in_kb;
-       uint64_t offset;
         int ret;

         adev->fw_vram_usage.mem_train_support =3D false;
@@ -569,32 +565,6 @@ int amdgpu_atomfirmware_get_mem_train_fb_loc(struct am=
dgpu_device *adev)
                 return -EINVAL;
         }

-       reserved_block =3D (struct vram_reserve_block *)
-               (bios + data_offset + sizeof(struct atom_common_table_heade=
r));
-       block_number =3D ((unsigned int)size - sizeof(struct atom_common_ta=
ble_header))
-               / sizeof(struct vram_reserve_block);
-       reserved_block +=3D (block_number > 0) ? block_number-1 : 0;
-       DRM_DEBUG("block_number:0x%04x, last block: 0x%08xkb sz, %dkb fw, %=
dkb drv.\n",
-                 block_number,
-                 le32_to_cpu(reserved_block->start_address_in_kb),
-                 le16_to_cpu(reserved_block->used_by_firmware_in_kb),
-                 le16_to_cpu(reserved_block->used_by_driver_in_kb));
-       if (reserved_block->used_by_firmware_in_kb > 0) {
-               start_address_in_kb =3D le32_to_cpu(reserved_block->start_a=
ddress_in_kb);
-               offset =3D (uint64_t)start_address_in_kb * ONE_KiB;
-               if ((offset & (ONE_MiB - 1)) < (4 * ONE_KiB + 1) ) {
-                       offset -=3D ONE_MiB;
-               }
-
-               offset &=3D ~(ONE_MiB - 1);
-               adev->fw_vram_usage.mem_train_fb_loc =3D offset;
-               adev->fw_vram_usage.mem_train_support =3D true;
-               DRM_DEBUG("mem_train_fb_loc:0x%09llx.\n", offset);
-               ret =3D 0;
-       } else {
-               DRM_ERROR("used_by_firmware_in_kb is 0!\n");
-               ret =3D -EINVAL;
-       }
-
-       return ret;
+       adev->fw_vram_usage.mem_train_support =3D true;
+       return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atomfirmware.h
index f871af5ea6f3..434fe2fa0089 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
@@ -31,7 +31,7 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_=
device *adev);
 int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
         int *vram_width, int *vram_type, int *vram_vendor);
-int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev);
+int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev);
 bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 2ff63d0414c9..ce5cb854bdb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1705,7 +1705,11 @@ static int amdgpu_ttm_training_reserve_vram_init(str=
uct amdgpu_device *adev)
                 return 0;
         }

-       ctx->c2p_train_data_offset =3D adev->fw_vram_usage.mem_train_fb_loc=
;
+       ctx->c2p_train_data_offset =3D adev->gmc.mc_vram_size;
+       if ((ctx->c2p_train_data_offset & (ONE_MiB - 1)) < (4 * ONE_KiB + 1=
) ) {
+               ctx->c2p_train_data_offset -=3D ONE_MiB;
+       }
+       ctx->c2p_train_data_offset &=3D ~(ONE_MiB - 1);

[kevin]:
i'd like to use the marco ALIGN() to simple above code.
anyway, the patch Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

         ctx->p2c_train_data_offset =3D (adev->gmc.mc_vram_size - GDDR6_MEM=
_TRAINING_OFFSET);
         ctx->train_data_size =3D GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.h
index f1ebd424510c..19eb3e8456c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -66,6 +66,13 @@ struct amdgpu_copy_mem {
         unsigned long                   offset;
 };

+/* Definitions for constance */
+enum amdgpu_internal_constants
+{
+       ONE_KiB =3D 0x400,
+       ONE_MiB =3D 0x100000,
+};
+
 extern const struct ttm_mem_type_manager_func amdgpu_gtt_mgr_func;
 extern const struct ttm_mem_type_manager_func amdgpu_vram_mgr_func;

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/a=
md/include/atomfirmware.h
index dd7cbc00a0aa..70146518174c 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -672,20 +672,6 @@ struct vram_usagebyfirmware_v2_1
   uint16_t  used_by_driver_in_kb;
 };

-/* This is part of vram_usagebyfirmware_v2_1 */
-struct vram_reserve_block
-{
-       uint32_t start_address_in_kb;
-       uint16_t used_by_firmware_in_kb;
-       uint16_t used_by_driver_in_kb;
-};
-
-/* Definitions for constance */
-enum atomfirmware_internal_constants
-{
-       ONE_KiB =3D 0x400,
-       ONE_MiB =3D 0x100000,
-};

 /*
   ************************************************************************=
***
--
2.17.1


--_000_MN2PR12MB2957F19B488696AF8A61D46A95530MN2PR12MB2957namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Kevin,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
You mean like this? It's a bit lengthy.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span></span><span>- ctx-&gt;c2p_train_data_offset &amp;=3D ~(ONE_MiB - 1);=
<br>
</span><span>&#43; ctx-&gt;c2p_train_data_offset =3D ALIGN(ctx-&gt;c2p_trai=
n_data_offset, ONE_MiB);</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span></span>Rico<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Wang, Kevin(Yang) &=
lt;Kevin1.Wang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 18, 2019 16:56<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@am=
d.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Fei=
fei.Xu@amd.com&gt;; Yuan, Xiaojie &lt;Xiaojie.Yuan@amd.com&gt;; Long,
 Gang &lt;Gang.Long@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc=
 of memory training(V2)</font>
<div>&nbsp;</div>
</div>
<div dir=3D"ltr">
<p style=3D"margin-top: 0px; margin-bottom: 0px;font-family:Arial; font-siz=
e:10pt; color:#0078D7; margin:15pt" align=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
comment inline.</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Tianci Yin &lt;tian=
ci.yin@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 18, 2019 4:50 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@am=
d.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Fei=
fei.Xu@amd.com&gt;; Yuan, Xiaojie &lt;Xiaojie.Yuan@amd.com&gt;; Long,
 Gang &lt;Gang.Long@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&=
gt;; Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of =
memory training(V2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.=
com&gt;<br>
<br>
The method of getting fb_loc changed from parsing VBIOS to<br>
taking certain offset from top of VRAM<br>
<br>
Change-Id: I053b42fdb1d822722fa7980b2cd9f86b3fdce539<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c&nbsp; |&nbsp; 2 &#43;-<b=
r>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c&nbsp; | 38 &#43;&#43;---=
--------------<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h&nbsp; |&nbsp; 2 &#43;-<b=
r>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 6 &#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 7 &#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/include/atomfirmware.h&nbsp;&nbsp;&nbsp; | 14 ---=
----<br>
&nbsp;7 files changed, 19 insertions(&#43;), 53 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index a78a363b1d71..fa2cf8e7bc07 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -642,9 &#43;642,8 @@ struct amdgpu_fw_vram_usage {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *reserved=
_bo;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *va;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Offset on the top of VRAM, used as=
 c2p write buffer.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GDDR6 training support flag.<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 mem_train_fb_loc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool mem_train_support;<br=
>
&nbsp;};<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_atombios.c<br>
index 9ba80d828876..fdd52d86a4d7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c<br>
@@ -2022,7 &#43;2022,7 @@ int amdgpu_atombios_init(struct amdgpu_device *ad=
ev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;is_atom_fw) {=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_atomfirmware_scratch_regs_init(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_atomfirmware_allocate_fb_scratch(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D amdgpu_atomfirmware_get_mem_train_fb_loc(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D amdgpu_atomfirmware_get_mem_train_info(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_E=
RROR(&quot;Failed to get mem train fb location.\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
index ff4eb96bdfb5..58f9d8c3a17a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
@@ -525,16 &#43;525,12 @@ static int gddr6_mem_train_support(struct amdgpu_=
device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev)<b=
r>
&#43;int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev)=
<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_context *ctx =
=3D adev-&gt;mode_info.atom_context;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned char *bios =3D ctx-&gt;bios;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vram_reserve_block *reserved_b=
lock;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int index, block_number;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int index;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t frev, crev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t data_offset, size=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t start_address_in_kb;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;fw_vram_usage.mem=
_train_support =3D false;<br>
@@ -569,32 &#43;565,6 @@ int amdgpu_atomfirmware_get_mem_train_fb_loc(struc=
t amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reserved_block =3D (struct vram_reser=
ve_block *)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (bios &#43; data_offset &#43; sizeof(struct atom_common_table_he=
ader));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_number =3D ((unsigned int)size =
- sizeof(struct atom_common_table_header))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; / sizeof(struct vram_reserve_block);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reserved_block &#43;=3D (block_number=
 &gt; 0) ? block_number-1 : 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;block_number:0x%04x, =
last block: 0x%08xkb sz, %dkb fw, %dkb drv.\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; block_number,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(reserved_block-&gt;start_address_in_kb),=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; le16_to_cpu(reserved_block-&gt;used_by_firmware_in_k=
b),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; le16_to_cpu(reserved_block-&gt;used_by_driver_in_kb)=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reserved_block-&gt;used_by_firmwa=
re_in_kb &gt; 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; start_address_in_kb =3D le32_to_cpu(reserved_block-&gt;start_add=
ress_in_kb);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; offset =3D (uint64_t)start_address_in_kb * ONE_KiB;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((offset &amp; (ONE_MiB - 1)) &lt; (4 * ONE_KiB &#43; 1) ) {<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset -=3D ONE_=
MiB;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; offset &amp;=3D ~(ONE_MiB - 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;fw_vram_usage.mem_train_fb_loc =3D offset;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;fw_vram_usage.mem_train_support =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_DEBUG(&quot;mem_train_fb_loc:0x%09llx.\n&quot;, offset);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;used_by_firmware_in_kb is 0!\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D -EINVAL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;fw_vram_usage.mem_train_=
support =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atomfirmware.h<br>
index f871af5ea6f3..434fe2fa0089 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h<br>
@@ -31,7 &#43;31,7 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amd=
gpu_device *adev);<br>
&nbsp;int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *ade=
v);<br>
&nbsp;int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int *vram_width, int *vram=
_type, int *vram_vendor);<br>
-int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev);<=
br>
&#43;int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev)=
;<br>
&nbsp;int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev);<b=
r>
&nbsp;int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev);<br>
&nbsp;bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev=
);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index 2ff63d0414c9..ce5cb854bdb9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -1705,7 &#43;1705,11 @@ static int amdgpu_ttm_training_reserve_vram_init=
(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset =3D ade=
v-&gt;fw_vram_usage.mem_train_fb_loc;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset =3D=
 adev-&gt;gmc.mc_vram_size;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((ctx-&gt;c2p_train_data_offse=
t &amp; (ONE_MiB - 1)) &lt; (4 * ONE_KiB &#43; 1) ) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset -=3D ONE_MiB;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</div>
<div class=3D"x_PlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&g=
t;c2p_train_data_offset &amp;=3D ~(ONE_MiB - 1);</div>
<div class=3D"x_PlainText"><br>
</div>
<div class=3D"x_PlainText"><b>[kevin]:</b></div>
<div class=3D"x_PlainText"><b>i'd like to use the marco ALIGN() to simple a=
bove code.</b></div>
<div class=3D"x_PlainText"><b>anyway, the patch Reviewed-by: Kevin Wang &lt=
;kevin1.wang@amd.com&gt;</b></div>
<div class=3D"x_PlainText"><br>
</div>
<div class=3D"x_PlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ctx-&gt;p2c_train_data_offset =3D (adev-&gt;gmc.mc_vram_size - GDDR6_MEM_T=
RAINING_OFFSET);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;train_data_size =
=3D GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.h<br>
index f1ebd424510c..19eb3e8456c7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
@@ -66,6 &#43;66,13 @@ struct amdgpu_copy_mem {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; offset;<br>
&nbsp;};<br>
&nbsp;<br>
&#43;/* Definitions for constance */<br>
&#43;enum amdgpu_internal_constants<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ONE_KiB =3D 0x400,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ONE_MiB =3D 0x100000,<br>
&#43;};<br>
&#43;<br>
&nbsp;extern const struct ttm_mem_type_manager_func amdgpu_gtt_mgr_func;<br=
>
&nbsp;extern const struct ttm_mem_type_manager_func amdgpu_vram_mgr_func;<b=
r>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/a=
md/include/atomfirmware.h<br>
index dd7cbc00a0aa..70146518174c 100644<br>
--- a/drivers/gpu/drm/amd/include/atomfirmware.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/atomfirmware.h<br>
@@ -672,20 &#43;672,6 @@ struct vram_usagebyfirmware_v2_1<br>
&nbsp;&nbsp; uint16_t&nbsp; used_by_driver_in_kb; <br>
&nbsp;};<br>
&nbsp;<br>
-/* This is part of vram_usagebyfirmware_v2_1 */<br>
-struct vram_reserve_block<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t start_address_in_kb;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t used_by_firmware_in_kb;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t used_by_driver_in_kb;<br>
-};<br>
-<br>
-/* Definitions for constance */<br>
-enum atomfirmware_internal_constants<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ONE_KiB =3D 0x400,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ONE_MiB =3D 0x100000,<br>
-};<br>
&nbsp;<br>
&nbsp;/* <br>
&nbsp;&nbsp; **************************************************************=
*************<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB2957F19B488696AF8A61D46A95530MN2PR12MB2957namp_--

--===============1221354921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1221354921==--
