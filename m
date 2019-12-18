Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB66C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 08:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F60E218AC
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 08:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Njc5vEyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F60E218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06DA56E260;
	Wed, 18 Dec 2019 08:52:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770070.outbound.protection.outlook.com [40.107.77.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E336E260
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 08:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSFESZKj2s0A+ahxzLqhDw9rYQ/eQaNgxBnSVaYiMCb8Mm9mMYEXopMiZJqZ3fF36cQMQQAbs70C/aCrhJlhLtn14IkyFCbKqe4I4+JXHU4YtxwanyQdWtZmgVIfmHHp7yQwto/zsOamjKNChBkBCB+PEgwf3I1FbIeLD1fvTTGNq/nC62TafncFit+9V9dLJIw3f51BUrFphdm/fl+wkB2Rh9Imsd9OOk8RHk8BOH2qU00CPApnRVLg4JytM3aHNnNu6X858gaUk7KJQZTEvCKae/6OLZl4K7UD52cX7ArLatr2qIJLgJnZ/dP3puhch8TVGh+BWdYxWkxvr0pbfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUrF2U4PfYtPLPk9cflrc463qhIfigh7VdwhxSPVBUY=;
 b=oK4Zu1rphNYkbM9ODCmsx2x4f2+kSbbA1s7YcNnuC5u8IVdnhLLZkxmiwdYvzeUDUenXSH4yFDfxvkPB4nBOBqBdVX64n8zUIIIu4aT5tcJUdymuP/DpaEwFZanRlJt6onnrBJ94dpw13aXBB1sXPiI5goM6Nsz08n4j3rFHzxWLIjy1M7gJU8Z+FnG4BQm5S0/URrHuyDzwEIva2NRwTeFrndiuyZ6MGeDfgVY10xZX7hbUVOHGX0206MVvng10b9yTc6nutmZ7TOa7hU0e7xboTYqjleSGSCseeb7DhNXqr4KKg3heX+wTNDXYhrI+K4Lot7OpfNBf/F/d6f0/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUrF2U4PfYtPLPk9cflrc463qhIfigh7VdwhxSPVBUY=;
 b=Njc5vEyN/QZJ3M5t/gRWhBRXkzAWNcR2S7w2dc9uq3rBYm2/mxT37wnbgF5NlccTZ+FwobbsTaMlVL+9UoE+8o+yqyD+3QpXf4EXV749hu3A03Uufwbpsdbai0rzXNogJnvI7GBwGNPCgScmJ0PtX7AkZLQ+TVe93/EquC4f5WA=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (20.179.82.14) by
 MN2PR12MB3615.namprd12.prod.outlook.com (20.178.242.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Wed, 18 Dec 2019 08:52:25 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756%6]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 08:52:25 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of memory
 training
Thread-Topic: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of
 memory training
Thread-Index: AQHVtUnfyG0OAB91MUu2WVr/BzF9sae/XomAgAA3bRo=
Date: Wed, 18 Dec 2019 08:52:25 +0000
Message-ID: <MN2PR12MB2957ACA6DE2339DA72A81EB395530@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20191218022126.25205-1-tianci.yin@amd.com>,
 <MN2PR12MB3296E3ACC90169776F9E090EA2530@MN2PR12MB3296.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3296E3ACC90169776F9E090EA2530@MN2PR12MB3296.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-18T08:52:24.771Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianci.Yin@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb238e64-03e7-4a57-23fe-08d783979ab7
x-ms-traffictypediagnostic: MN2PR12MB3615:|MN2PR12MB3615:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3615323D232073ABB98A4F4795530@MN2PR12MB3615.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(189003)(199004)(81156014)(81166006)(66946007)(8676002)(186003)(4326008)(110136005)(86362001)(15650500001)(91956017)(76116006)(71200400001)(8936002)(19627405001)(53546011)(52536014)(6506007)(64756008)(66556008)(66476007)(7696005)(33656002)(5660300002)(478600001)(55016002)(9686003)(316002)(26005)(66446008)(2906002)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3615;
 H:MN2PR12MB2957.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rlnhyLDDgi7C7I7+/HqmKtPgAskVoy8yxCEwO/qDxkDTbP8u4o4xzXV2DZYOOt967hwaN9+o79Boe+l3bXxqLb2vy4MQrL6dykr85E82C8bKDfdEgiZfoX/pVl3h7//Nmg8h1dkZB05MnVoxZrGJCFi3vmIucGweNWxghfUNn37UbhBeKd0j0CSL3pKd+ADt4LF/nJsGtnXwm5RkY8Q/KRSy4P+5trKbnLarTx/zF14YatF6+IxaZQ/HUgwDQQq3PjihZiDGnwV0YM3ltz30cnKzJrOWOqmz8Zq5Ilkh7tCSLKqDCfaJuib615W1HW4WEuWmlKhNeAa0YNI/x8Nlt9kx6oKrEG3+49rIvTl72Rv6XZurVT6nCXGJMVxXw1/HvAewvtP4U78NkjE4Qo8y6SoDfzJnLgEbgOqFhX4KZB74BGVZiNESWG1shx/Tn2Tq
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb238e64-03e7-4a57-23fe-08d783979ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 08:52:25.3699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZA3tSm8Eib8EWpfvKWD58wToA+LnJezxKRv3hYmjHt+6zp2ewYn2b+hDeE6H0iaitg0Dl9qK6uOkMdmw5Oaqpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3615
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
Content-Type: multipart/mixed; boundary="===============1598150966=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1598150966==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB2957ACA6DE2339DA72A81EB395530MN2PR12MB2957namp_"

--_000_MN2PR12MB2957ACA6DE2339DA72A81EB395530MN2PR12MB2957namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

Thanks very much!

I have rename the amdgpu_atomfirmware_get_mem_train_fb_loc function to amdg=
pu_atomfirmware_get_mem_train_info, please review again.

Rico
________________________________
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Wednesday, December 18, 2019 13:32
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking=
 <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Yuan, Xiaojie <Xi=
aojie.Yuan@amd.com>; Long, Gang <Gang.Long@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of mem=
ory training


[AMD Official Use Only - Internal Distribution Only]


________________________________
From: Tianci Yin <tianci.yin@amd.com>
Sent: Wednesday, December 18, 2019 10:21 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking=
 <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Yuan, Xiaojie <Xi=
aojie.Yuan@amd.com>; Long, Gang <Gang.Long@amd.com>; Wang, Kevin(Yang) <Kev=
in1.Wang@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of memory =
training

From: "Tianci.Yin" <tianci.yin@amd.com>

The method of getting fb_loc changed from parsing VBIOS to
taking certain offset from top of VRAM

Change-Id: I053b42fdb1d822722fa7980b2cd9f86b3fdce539
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 36 ++-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  6 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  7 ++++
 drivers/gpu/drm/amd/include/atomfirmware.h    | 14 --------
 5 files changed, 16 insertions(+), 50 deletions(-)

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

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atomfirmware.c
index ff4eb96bdfb5..009cb0b03d13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -528,13 +528,9 @@ static int gddr6_mem_train_support(struct amdgpu_devic=
e *adev)
 int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *adev)
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
[kevin]:
this function is not return any address after change,
i think we'd better to rename this function to another is well.
the code can be merge to function gddr6_mem_train_support().

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


--_000_MN2PR12MB2957ACA6DE2339DA72A81EB395530MN2PR12MB2957namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Kevin,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks very much!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I have rename the <font size=3D"2"><span style=3D"font-size:11pt">amdgpu_at=
omfirmware_get_mem_train_fb_loc</span></font> function to
<font size=3D"2"><span style=3D"font-size:11pt">amdgpu_atomfirmware_get_mem=
_train_info, please review again.</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt"><br>
</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt">Rico<br>
</span></font></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Kevin(Yang) &lt=
;Kevin1.Wang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 18, 2019 13:32<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@am=
d.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Fei=
fei.Xu@amd.com&gt;; Yuan, Xiaojie &lt;Xiaojie.Yuan@amd.com&gt;; Long,
 Gang &lt;Gang.Long@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc=
 of memory training</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0078D7=
; margin:15pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Tianci Yin &lt;tian=
ci.yin@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 18, 2019 10:21 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@am=
d.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Fei=
fei.Xu@amd.com&gt;; Yuan, Xiaojie &lt;Xiaojie.Yuan@amd.com&gt;; Long,
 Gang &lt;Gang.Long@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&=
gt;; Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of =
memory training</font>
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
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c&nbsp; | 36 &#43;&#43;---=
--------------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 6 &#43;&#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 7 &#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/include/atomfirmware.h&nbsp;&nbsp;&nbsp; | 14 ---=
-----<br>
&nbsp;5 files changed, 16 insertions(&#43;), 50 deletions(-)<br>
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
index ff4eb96bdfb5..009cb0b03d13 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
@@ -528,13 &#43;528,9 @@ static int gddr6_mem_train_support(struct amdgpu_d=
evice *adev)<br>
&nbsp;int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *ad=
ev)<br>
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
t amdgpu_device *adev)</div>
<div class=3D"x_PlainText">[kevin]:</div>
<div class=3D"x_PlainText">this function is not return any address after ch=
ange,</div>
<div class=3D"x_PlainText">i think we'd better to rename this function to a=
nother is well.</div>
<div class=3D"x_PlainText">the code can be merge to function&nbsp;gddr6_mem=
_train_support().</div>
<div class=3D"x_PlainText"><br>
</div>
<div class=3D"x_PlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
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
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset &am=
p;=3D ~(ONE_MiB - 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;p2c_train_data_off=
set =3D (adev-&gt;gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);<br>
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

--_000_MN2PR12MB2957ACA6DE2339DA72A81EB395530MN2PR12MB2957namp_--

--===============1598150966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1598150966==--
