Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BEEC04A95
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 21:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 111B610E9AD;
	Fri, 23 Sep 2022 21:36:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DC0A10E9AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 21:36:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqPOjCobvS4kgnzPV0h3MXPDs43M1w7LffZNUcCtYpEGtRCfFU2VGUbQek5nPvDg9RbRtVGSPNhpem3OQ90p2O3qRx01AZ1wmwSi+FcCjbrCxbnNYcjQhNxO6GzjWLugPxqJbFeuCAhjcZGccTbndeeP9Q9fcG+XxVHqE3UQK5eC4QW8R9BxXORnQy0H+yJIjfr7zb8QQuWxHGZCSoo1dSBWugYZf3YLlP+rsVeG1OBrNwxKqLEP2jD9xr8+78LTmKQ6xk0PTqERxbeMorymIAOimCBK/1WIjhi0IxxxrmUiB5j5rf4ynX4WZqcslk4HAIs2OEHP0OhcYvy2pcF9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbEH808oO+drtLxJ8X2/5Kz3387icW04YcdYGE8EfaY=;
 b=ANg/ZCChiQ1CUch5j98dktAx6m/ka5bUgJaHr4/8GBLxvjXPdruSvWxriytC1JGI7eusEmovuDWPqM8DGHZMkDrXeX7qYaes0XKD9OOLKgfjQda2nW8lBJbsXEZ6G3EQIOoWIqP9+Mlbxv6jwJkgeBpN2dBzC01jPPORS/m++EVpzYdeM2Kv/wX7CGIAKYodYTks9tcajEORpjsMvx4auhUZg6h1kgQiQLBAswc9fOV7HGV/MmsS1Dh6ccjgkMCU2YqbLg/fVZNB9Myd4sA+KLIavEzz5lmBu/SGeY9x5meA938owXupQVqfDaMK2K4sRDJdrJcL+Yv9yAkDpI1WSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbEH808oO+drtLxJ8X2/5Kz3387icW04YcdYGE8EfaY=;
 b=QbLNC+OrPvTPfFWckTzokTHzUhDWn+tsCh/CvlUV2E0pH/Qkw73FO3QKrb5D67zUYA5JvIu1W6EePtwWeer0kEdcTl18oQzMMUoAIwYq0FK86rGBrWKAUpGGkYtJ/AOteWho782h4UbDY2RWYucEcnxWMxli+Y4IEKgD2JBSJQk=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB7355.namprd12.prod.outlook.com (2603:10b6:510:20e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Fri, 23 Sep
 2022 21:36:27 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f5f8:4688:2e04:4769]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f5f8:4688:2e04:4769%3]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 21:36:27 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Gao, Likun" <Likun.Gao@amd.com>
Subject: Re: [PATCH 09/10] drm/amdgpu/gfx10: switch to
 amdgpu_gfx_rlc_init_microcode
Thread-Topic: [PATCH 09/10] drm/amdgpu/gfx10: switch to
 amdgpu_gfx_rlc_init_microcode
Thread-Index: AQHYySTmzdfGVhRC30Ol5CiEa32oJq3tlpLy
Date: Fri, 23 Sep 2022 21:36:27 +0000
Message-ID: <BL1PR12MB514443C746109B972824368BF7519@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220915170135.23060-1-Hawking.Zhang@amd.com>
 <20220915170135.23060-10-Hawking.Zhang@amd.com>
In-Reply-To: <20220915170135.23060-10-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-23T21:36:26.543Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB7355:EE_
x-ms-office365-filtering-correlation-id: c028b1df-763e-4b10-4098-08da9dababb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GKY6VJoL/c1TZAYq+6xwukJ0iCARQBgFQzj61ArXnnDtU6Ddo/6LpdmUsxLgaMhbedvKbhBgTI+BWbe14iQraIXIL6VWZo4H4NIxs6iCIGwSkeNBJvyCV4fTmZ0wjEmqf5bBKDliImhXmWdsHG5o3mG25ctCfmgeZr532jBdOFv2U7geOF4/XW5tFIyQE4O1QW6g9JMPz8SkbWQzQwvBcOwnWNLqDB3ML15sPGu3d9+6ffTxybcALmsys8D4wfE3VY4ODRlMQ/Fc9FVt/xMwLHYbVH47dMmPlkv/HDOBZscZII7cHnnDz2PVsZPPnO3V71JF56Pg6p29/TwVSJFbykf36JJyJUSBE2l8sIvSPLAJXVDvbiKI4PwTZodL3P9O8CR+XBBlZfQVlsICdAS79ZXCTEVV1+QWLOQOov3A7Q19S1zdYo2pYhVXO1fRKLUvtuFAeY+N4ariYREonacpDz1dPUSeB0lkEPXsRPUlvR39GsK/JG4B6oPWJ3oEToII4E+BYl2lEvUAb/d0AQAbd2v2GSQ6pJOQtGPAKMqgaDTPeoOZsSfOuoeBKU3aqfGHOJjqc0Ss4RFA829WXGTQPMJbo1m4lhPRE5hwAAfTInJj/2otQ+cyzQ+bVfJWzeK4YXp+bU4jL3kyoVvfaQ2A6hWpaCWzzrbVFJmVpssCwAp366ZlIgxhOynLGYLRq1Ogb/sSdoYLZ9d3XaZWLcdC0wZaxBozc2cUA5eIhOITzDU3IO3q5deYZlWwrmKZFw9C57hIGzZiEmBEHKrqVVMVmg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(186003)(30864003)(19627405001)(122000001)(66556008)(38100700002)(9686003)(38070700005)(8936002)(41300700001)(26005)(76116006)(6506007)(66476007)(64756008)(66446008)(7696005)(66946007)(8676002)(55016003)(53546011)(86362001)(33656002)(110136005)(83380400001)(2906002)(52536014)(6636002)(5660300002)(316002)(71200400001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3M1cwRlijQo8FYWQjz8vps3vw8meWZd5o0cPu592hwzE8IVPYLNP2QvI/4eK?=
 =?us-ascii?Q?W6HE8tfOAfenRo6bZJkJ38kZZ6SuYm4XmvX0GEc1QDXTR5AIK1p/ErzezXzH?=
 =?us-ascii?Q?p+afnxqr91ZtRSYe7Md+1/fVQcW67gQ2i8X4thgVybmOqZSh5Kl02iFZXfhm?=
 =?us-ascii?Q?w8yIIBZCs66FGtat/zSQe77NyVqRAX/3l4XeGbUC+t2EEGxejY46uFnI2tGC?=
 =?us-ascii?Q?9W4XOD1SepEGcOs4x+Fwbe9DyvaH/Oagj1DL6+qS7sl4+eY3XZxTGie1b854?=
 =?us-ascii?Q?Wk9QcWKsdbuZ3AkhMA8p3faXT8PxLEfkNBGAwEJej1hWGhbqoJ+MjvhzPVw+?=
 =?us-ascii?Q?SIjDjNgxMyzeDrEWC8WBnBoOoVqVyYCxDrfu8889PPy72Bnjy3r9cKudoXFi?=
 =?us-ascii?Q?tY2uzkvxM/pJ6IFj7ESi5yfGYPEXa2azs/H2ww4nLNIjfFsZ1IgBeD3ogzJf?=
 =?us-ascii?Q?amOCuRmZX/hnJd8zH5oiF3ricdpg6MNQZrPiW1PAhV6CsiPsqdsSCi9w5eiv?=
 =?us-ascii?Q?GNLXJqBQaz8TRlIAL1PZMsRFUBVxcLfdlucuyupC8fiaWoZMUeUqbwIUVDg7?=
 =?us-ascii?Q?saXJPUDwO+k5KJcSThw9bmsd2EQiqdFvg9N8G/BlOGLkW69DkXMuuHVIQuee?=
 =?us-ascii?Q?yegx0PCBlNtEUd3OZ9/vrnlELsL5qTIHR5Wj6WDiRRRb+8xBFEkqNMuH3UWN?=
 =?us-ascii?Q?xUAgc4CTYOpH2IaRubi42BIUH1/CmNgU00L/b0/e4R8oBrnOi2jV71OL1XDR?=
 =?us-ascii?Q?wmGWwVlHh8PtJ2gpxHWFm6Yu4sYbBMFeVO0Tdgbhp2BrijTrOX2YTA/ItBZn?=
 =?us-ascii?Q?dad86jCjFU4OBvM9z5ZPZUSWALrcjeS0tW8t9C5WrILnhKYBQCoaSe0dXGaw?=
 =?us-ascii?Q?7gWn8zwJ8Q1QbOW8juUWqYsSuGMeDtANhsnnjg3HundSviIYxIJ1aMvwE99t?=
 =?us-ascii?Q?fr6l8ObzZNYOqSrvFZ+ukhvNnDbpsqXNVtDl35XQnFxFE2S7Sej34YBjpsxD?=
 =?us-ascii?Q?d2nuvaPHfmiM1Wv/t/umxRAwS8f/3Y+n9xFEGCc85l9rjO3KeHE1aIU2Ufpy?=
 =?us-ascii?Q?voDinHG/u3XwtKzvuwh7zW+NAxQb6pKlxZRUcgppVne5rcpginlQ2Edhw7OV?=
 =?us-ascii?Q?5jn6jaTraH1siINlBC3+Ur3Zwprea+emxfDa4xx6QszI1RenaDAoV3SDUP7S?=
 =?us-ascii?Q?AK4YdSvNnk0LvgT0BciQfKhFDj3ZlHo9oezVHXoHYfclFis09dpJWMfFytfp?=
 =?us-ascii?Q?lr9W3YMSgPByUp94j446TEcSMQvLjDCyJssW8jLYRmJ/xsHm00woi4tY+rLb?=
 =?us-ascii?Q?a0VjXcIxQT2PClkrlpqqxHM0O1hd9p+5ibBhdApVA0puo2oZ23lIKrYn2pj5?=
 =?us-ascii?Q?TlE0xfjq0x15X/bL905caPnyTbqO0YhJlC5QRmbMRYv71rct12IDAZEOPQte?=
 =?us-ascii?Q?5tFPutRR5fhOYY4fZbBzNTbWhWKglzFx3NnvTWCP/290mnVAnmsDVpdvyQaA?=
 =?us-ascii?Q?807ddAskALsYl3M7Qs4a/pv4hJhQ+JPpKQvBq5Nw2NpzWcA/fF2iv8bFkYRa?=
 =?us-ascii?Q?cbzHCySOKkOygr4ONPg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514443C746109B972824368BF7519BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c028b1df-763e-4b10-4098-08da9dababb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 21:36:27.1210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+Tb7QiN5BCMa/9tSz/VatoVkqAmJBm8BuUWbGYTgoN2IqdWWqclORSxFXrOvl96jmoMkV+DcAusT29g72yaLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7355
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

--_000_BL1PR12MB514443C746109B972824368BF7519BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

This set seems to break RLC firmware loading on sienna cichlid.

Alex
________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Thursday, September 15, 2022 1:01 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Gao, Lik=
un <Likun.Gao@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 09/10] drm/amdgpu/gfx10: switch to amdgpu_gfx_rlc_init_micr=
ocode

switch to common helper to initialize rlc firmware
for gfx10

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 191 +------------------------
 1 file changed, 4 insertions(+), 187 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 26ec04fd313b..423b1b6d31b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3943,56 +3943,6 @@ static void gfx_v10_0_check_fw_write_wait(struct amd=
gpu_device *adev)
                 DRM_WARN_ONCE("CP firmware version too old, please update!=
");
 }

-
-static void gfx_v10_0_init_rlc_ext_microcode(struct amdgpu_device *adev)
-{
-       const struct rlc_firmware_header_v2_1 *rlc_hdr;
-
-       rlc_hdr =3D (const struct rlc_firmware_header_v2_1 *)adev->gfx.rlc_=
fw->data;
-       adev->gfx.rlc_srlc_fw_version =3D le32_to_cpu(rlc_hdr->save_restore=
_list_cntl_ucode_ver);
-       adev->gfx.rlc_srlc_feature_version =3D le32_to_cpu(rlc_hdr->save_re=
store_list_cntl_feature_ver);
-       adev->gfx.rlc.save_restore_list_cntl_size_bytes =3D le32_to_cpu(rlc=
_hdr->save_restore_list_cntl_size_bytes);
-       adev->gfx.rlc.save_restore_list_cntl =3D (u8 *)rlc_hdr + le32_to_cp=
u(rlc_hdr->save_restore_list_cntl_offset_bytes);
-       adev->gfx.rlc_srlg_fw_version =3D le32_to_cpu(rlc_hdr->save_restore=
_list_gpm_ucode_ver);
-       adev->gfx.rlc_srlg_feature_version =3D le32_to_cpu(rlc_hdr->save_re=
store_list_gpm_feature_ver);
-       adev->gfx.rlc.save_restore_list_gpm_size_bytes =3D le32_to_cpu(rlc_=
hdr->save_restore_list_gpm_size_bytes);
-       adev->gfx.rlc.save_restore_list_gpm =3D (u8 *)rlc_hdr + le32_to_cpu=
(rlc_hdr->save_restore_list_gpm_offset_bytes);
-       adev->gfx.rlc_srls_fw_version =3D le32_to_cpu(rlc_hdr->save_restore=
_list_srm_ucode_ver);
-       adev->gfx.rlc_srls_feature_version =3D le32_to_cpu(rlc_hdr->save_re=
store_list_srm_feature_ver);
-       adev->gfx.rlc.save_restore_list_srm_size_bytes =3D le32_to_cpu(rlc_=
hdr->save_restore_list_srm_size_bytes);
-       adev->gfx.rlc.save_restore_list_srm =3D (u8 *)rlc_hdr + le32_to_cpu=
(rlc_hdr->save_restore_list_srm_offset_bytes);
-       adev->gfx.rlc.reg_list_format_direct_reg_list_length =3D
-                       le32_to_cpu(rlc_hdr->reg_list_format_direct_reg_lis=
t_length);
-}
-
-static void gfx_v10_0_init_rlc_iram_dram_microcode(struct amdgpu_device *a=
dev)
-{
-       const struct rlc_firmware_header_v2_2 *rlc_hdr;
-
-       rlc_hdr =3D (const struct rlc_firmware_header_v2_2 *)adev->gfx.rlc_=
fw->data;
-       adev->gfx.rlc.rlc_iram_ucode_size_bytes =3D le32_to_cpu(rlc_hdr->rl=
c_iram_ucode_size_bytes);
-       adev->gfx.rlc.rlc_iram_ucode =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hd=
r->rlc_iram_ucode_offset_bytes);
-       adev->gfx.rlc.rlc_dram_ucode_size_bytes =3D le32_to_cpu(rlc_hdr->rl=
c_dram_ucode_size_bytes);
-       adev->gfx.rlc.rlc_dram_ucode =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hd=
r->rlc_dram_ucode_offset_bytes);
-}
-
-static void gfx_v10_0_init_tap_delays_microcode(struct amdgpu_device *adev=
)
-{
-       const struct rlc_firmware_header_v2_4 *rlc_hdr;
-
-       rlc_hdr =3D (const struct rlc_firmware_header_v2_4 *)adev->gfx.rlc_=
fw->data;
-       adev->gfx.rlc.global_tap_delays_ucode_size_bytes =3D le32_to_cpu(rl=
c_hdr->global_tap_delays_ucode_size_bytes);
-       adev->gfx.rlc.global_tap_delays_ucode =3D (u8 *)rlc_hdr + le32_to_c=
pu(rlc_hdr->global_tap_delays_ucode_offset_bytes);
-       adev->gfx.rlc.se0_tap_delays_ucode_size_bytes =3D le32_to_cpu(rlc_h=
dr->se0_tap_delays_ucode_size_bytes);
-       adev->gfx.rlc.se0_tap_delays_ucode =3D (u8 *)rlc_hdr + le32_to_cpu(=
rlc_hdr->se0_tap_delays_ucode_offset_bytes);
-       adev->gfx.rlc.se1_tap_delays_ucode_size_bytes =3D le32_to_cpu(rlc_h=
dr->se1_tap_delays_ucode_size_bytes);
-       adev->gfx.rlc.se1_tap_delays_ucode =3D (u8 *)rlc_hdr + le32_to_cpu(=
rlc_hdr->se1_tap_delays_ucode_offset_bytes);
-       adev->gfx.rlc.se2_tap_delays_ucode_size_bytes =3D le32_to_cpu(rlc_h=
dr->se2_tap_delays_ucode_size_bytes);
-       adev->gfx.rlc.se2_tap_delays_ucode =3D (u8 *)rlc_hdr + le32_to_cpu(=
rlc_hdr->se2_tap_delays_ucode_offset_bytes);
-       adev->gfx.rlc.se3_tap_delays_ucode_size_bytes =3D le32_to_cpu(rlc_h=
dr->se3_tap_delays_ucode_size_bytes);
-       adev->gfx.rlc.se3_tap_delays_ucode =3D (u8 *)rlc_hdr + le32_to_cpu(=
rlc_hdr->se3_tap_delays_ucode_offset_bytes);
-}
-
 static bool gfx_v10_0_navi10_gfxoff_should_enable(struct amdgpu_device *ad=
ev)
 {
         bool ret =3D false;
@@ -4032,8 +3982,6 @@ static int gfx_v10_0_init_microcode(struct amdgpu_dev=
ice *adev)
         const struct common_firmware_header *header =3D NULL;
         const struct gfx_firmware_header_v1_0 *cp_hdr;
         const struct rlc_firmware_header_v2_0 *rlc_hdr;
-       unsigned int *tmp =3D NULL;
-       unsigned int i =3D 0;
         uint16_t version_major;
         uint16_t version_minor;

@@ -4123,59 +4071,14 @@ static int gfx_v10_0_init_microcode(struct amdgpu_d=
evice *adev)
                 if (err)
                         goto out;
                 err =3D amdgpu_ucode_validate(adev->gfx.rlc_fw);
+               if (err)
+                       goto out;
                 rlc_hdr =3D (const struct rlc_firmware_header_v2_0 *)adev-=
>gfx.rlc_fw->data;
                 version_major =3D le16_to_cpu(rlc_hdr->header.header_versi=
on_major);
                 version_minor =3D le16_to_cpu(rlc_hdr->header.header_versi=
on_minor);
-
-               adev->gfx.rlc_fw_version =3D le32_to_cpu(rlc_hdr->header.uc=
ode_version);
-               adev->gfx.rlc_feature_version =3D le32_to_cpu(rlc_hdr->ucod=
e_feature_version);
-               adev->gfx.rlc.save_and_restore_offset =3D
-                       le32_to_cpu(rlc_hdr->save_and_restore_offset);
-               adev->gfx.rlc.clear_state_descriptor_offset =3D
-                       le32_to_cpu(rlc_hdr->clear_state_descriptor_offset)=
;
-               adev->gfx.rlc.avail_scratch_ram_locations =3D
-                       le32_to_cpu(rlc_hdr->avail_scratch_ram_locations);
-               adev->gfx.rlc.reg_restore_list_size =3D
-                       le32_to_cpu(rlc_hdr->reg_restore_list_size);
-               adev->gfx.rlc.reg_list_format_start =3D
-                       le32_to_cpu(rlc_hdr->reg_list_format_start);
-               adev->gfx.rlc.reg_list_format_separate_start =3D
-                       le32_to_cpu(rlc_hdr->reg_list_format_separate_start=
);
-               adev->gfx.rlc.starting_offsets_start =3D
-                       le32_to_cpu(rlc_hdr->starting_offsets_start);
-               adev->gfx.rlc.reg_list_format_size_bytes =3D
-                       le32_to_cpu(rlc_hdr->reg_list_format_size_bytes);
-               adev->gfx.rlc.reg_list_size_bytes =3D
-                       le32_to_cpu(rlc_hdr->reg_list_size_bytes);
-               adev->gfx.rlc.register_list_format =3D
-                       kmalloc(adev->gfx.rlc.reg_list_format_size_bytes +
-                                       adev->gfx.rlc.reg_list_size_bytes, =
GFP_KERNEL);
-               if (!adev->gfx.rlc.register_list_format) {
-                       err =3D -ENOMEM;
+               err =3D amdgpu_gfx_rlc_init_microcode(adev, version_major, =
version_minor);
+               if (err)
                         goto out;
-               }
-
-               tmp =3D (unsigned int *)((uintptr_t)rlc_hdr +
-                                                          le32_to_cpu(rlc_=
hdr->reg_list_format_array_offset_bytes));
-               for (i =3D 0 ; i < (rlc_hdr->reg_list_format_size_bytes >> =
2); i++)
-                       adev->gfx.rlc.register_list_format[i] =3D le32_to_c=
pu(tmp[i]);
-
-               adev->gfx.rlc.register_restore =3D adev->gfx.rlc.register_l=
ist_format + i;
-
-               tmp =3D (unsigned int *)((uintptr_t)rlc_hdr +
-                                                          le32_to_cpu(rlc_=
hdr->reg_list_array_offset_bytes));
-               for (i =3D 0 ; i < (rlc_hdr->reg_list_size_bytes >> 2); i++=
)
-                       adev->gfx.rlc.register_restore[i] =3D le32_to_cpu(t=
mp[i]);
-
-               if (version_major =3D=3D 2) {
-                       if (version_minor >=3D 1)
-                               gfx_v10_0_init_rlc_ext_microcode(adev);
-                       if (version_minor >=3D 2)
-                               gfx_v10_0_init_rlc_iram_dram_microcode(adev=
);
-                       if (version_minor =3D=3D 4) {
-                               gfx_v10_0_init_tap_delays_microcode(adev);
-                       }
-               }
         }

         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec%s.bin", chip_nam=
e, wks);
@@ -4228,92 +4131,6 @@ static int gfx_v10_0_init_microcode(struct amdgpu_de=
vice *adev)
                 adev->firmware.fw_size +=3D
                         ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_=
SIZE);

-               info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_G];
-               info->ucode_id =3D AMDGPU_UCODE_ID_RLC_G;
-               info->fw =3D adev->gfx.rlc_fw;
-               if (info->fw) {
-                       header =3D (const struct common_firmware_header *)i=
nfo->fw->data;
-                       adev->firmware.fw_size +=3D
-                               ALIGN(le32_to_cpu(header->ucode_size_bytes)=
, PAGE_SIZE);
-               }
-               if (adev->gfx.rlc.save_restore_list_cntl_size_bytes &&
-                   adev->gfx.rlc.save_restore_list_gpm_size_bytes &&
-                   adev->gfx.rlc.save_restore_list_srm_size_bytes) {
-                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_=
RESTORE_LIST_CNTL];
-                       info->ucode_id =3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST=
_CNTL;
-                       info->fw =3D adev->gfx.rlc_fw;
-                       adev->firmware.fw_size +=3D
-                               ALIGN(adev->gfx.rlc.save_restore_list_cntl_=
size_bytes, PAGE_SIZE);
-
-                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_=
RESTORE_LIST_GPM_MEM];
-                       info->ucode_id =3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST=
_GPM_MEM;
-                       info->fw =3D adev->gfx.rlc_fw;
-                       adev->firmware.fw_size +=3D
-                               ALIGN(adev->gfx.rlc.save_restore_list_gpm_s=
ize_bytes, PAGE_SIZE);
-
-                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_=
RESTORE_LIST_SRM_MEM];
-                       info->ucode_id =3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST=
_SRM_MEM;
-                       info->fw =3D adev->gfx.rlc_fw;
-                       adev->firmware.fw_size +=3D
-                               ALIGN(adev->gfx.rlc.save_restore_list_srm_s=
ize_bytes, PAGE_SIZE);
-
-                       if (adev->gfx.rlc.rlc_iram_ucode_size_bytes &&
-                           adev->gfx.rlc.rlc_dram_ucode_size_bytes) {
-                               info =3D &adev->firmware.ucode[AMDGPU_UCODE=
_ID_RLC_IRAM];
-                               info->ucode_id =3D AMDGPU_UCODE_ID_RLC_IRAM=
;
-                               info->fw =3D adev->gfx.rlc_fw;
-                               adev->firmware.fw_size +=3D
-                                       ALIGN(adev->gfx.rlc.rlc_iram_ucode_=
size_bytes, PAGE_SIZE);
-
-                               info =3D &adev->firmware.ucode[AMDGPU_UCODE=
_ID_RLC_DRAM];
-                               info->ucode_id =3D AMDGPU_UCODE_ID_RLC_DRAM=
;
-                               info->fw =3D adev->gfx.rlc_fw;
-                               adev->firmware.fw_size +=3D
-                                       ALIGN(adev->gfx.rlc.rlc_dram_ucode_=
size_bytes, PAGE_SIZE);
-                       }
-
-               }
-
-               if (adev->gfx.rlc.global_tap_delays_ucode_size_bytes) {
-                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_GLOB=
AL_TAP_DELAYS];
-                       info->ucode_id =3D AMDGPU_UCODE_ID_GLOBAL_TAP_DELAY=
S;
-                       info->fw =3D adev->gfx.rlc_fw;
-                       adev->firmware.fw_size +=3D
-                               ALIGN(adev->gfx.rlc.global_tap_delays_ucode=
_size_bytes, PAGE_SIZE);
-               }
-
-               if (adev->gfx.rlc.se0_tap_delays_ucode_size_bytes) {
-                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_SE0_=
TAP_DELAYS];
-                       info->ucode_id =3D AMDGPU_UCODE_ID_SE0_TAP_DELAYS;
-                       info->fw =3D adev->gfx.rlc_fw;
-                       adev->firmware.fw_size +=3D
-                               ALIGN(adev->gfx.rlc.se0_tap_delays_ucode_si=
ze_bytes, PAGE_SIZE);
-               }
-
-               if (adev->gfx.rlc.se1_tap_delays_ucode_size_bytes) {
-                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_SE1_=
TAP_DELAYS];
-                       info->ucode_id =3D AMDGPU_UCODE_ID_SE1_TAP_DELAYS;
-                       info->fw =3D adev->gfx.rlc_fw;
-                       adev->firmware.fw_size +=3D
-                               ALIGN(adev->gfx.rlc.se1_tap_delays_ucode_si=
ze_bytes, PAGE_SIZE);
-               }
-
-               if (adev->gfx.rlc.se2_tap_delays_ucode_size_bytes) {
-                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_SE2_=
TAP_DELAYS];
-                       info->ucode_id =3D AMDGPU_UCODE_ID_SE2_TAP_DELAYS;
-                       info->fw =3D adev->gfx.rlc_fw;
-                       adev->firmware.fw_size +=3D
-                               ALIGN(adev->gfx.rlc.se2_tap_delays_ucode_si=
ze_bytes, PAGE_SIZE);
-               }
-
-               if (adev->gfx.rlc.se3_tap_delays_ucode_size_bytes) {
-                       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_SE3_=
TAP_DELAYS];
-                       info->ucode_id =3D AMDGPU_UCODE_ID_SE3_TAP_DELAYS;
-                       info->fw =3D adev->gfx.rlc_fw;
-                       adev->firmware.fw_size +=3D
-                               ALIGN(adev->gfx.rlc.se3_tap_delays_ucode_si=
ze_bytes, PAGE_SIZE);
-               }
-
                 info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_CP_MEC1];
                 info->ucode_id =3D AMDGPU_UCODE_ID_CP_MEC1;
                 info->fw =3D adev->gfx.mec_fw;
--
2.17.1


--_000_BL1PR12MB514443C746109B972824368BF7519BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
This set seems to break RLC firmware loading on sienna cichlid.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Thursday, September 15, 2022 1:01 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Gao, Likun &lt;Likun.Gao@amd.com&gt;; Deucher, Alexander &lt;Alexander=
.Deucher@amd.com&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 09/10] drm/amdgpu/gfx10: switch to amdgpu_gfx_rlc_in=
it_microcode</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">switch to common helper to initialize rlc firmware=
<br>
for gfx10<br>
<br>
Signed-off-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 191 +-----------------------=
-<br>
&nbsp;1 file changed, 4 insertions(+), 187 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 26ec04fd313b..423b1b6d31b6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -3943,56 +3943,6 @@ static void gfx_v10_0_check_fw_write_wait(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_WARN_ONCE(&quot;CP firmware version too old, plea=
se update!&quot;);<br>
&nbsp;}<br>
&nbsp;<br>
-<br>
-static void gfx_v10_0_init_rlc_ext_microcode(struct amdgpu_device *adev)<b=
r>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct rlc_firmware_header_v2_1=
 *rlc_hdr;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rlc_hdr =3D (const struct rlc_firmwar=
e_header_v2_1 *)adev-&gt;gfx.rlc_fw-&gt;data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc_srlc_fw_version =3D =
le32_to_cpu(rlc_hdr-&gt;save_restore_list_cntl_ucode_ver);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc_srlc_feature_version=
 =3D le32_to_cpu(rlc_hdr-&gt;save_restore_list_cntl_feature_ver);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.save_restore_list_cn=
tl_size_bytes =3D le32_to_cpu(rlc_hdr-&gt;save_restore_list_cntl_size_bytes=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.save_restore_list_cn=
tl =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;save_restore_list_cntl_offse=
t_bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc_srlg_fw_version =3D =
le32_to_cpu(rlc_hdr-&gt;save_restore_list_gpm_ucode_ver);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc_srlg_feature_version=
 =3D le32_to_cpu(rlc_hdr-&gt;save_restore_list_gpm_feature_ver);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.save_restore_list_gp=
m_size_bytes =3D le32_to_cpu(rlc_hdr-&gt;save_restore_list_gpm_size_bytes);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.save_restore_list_gp=
m =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;save_restore_list_gpm_offset_=
bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc_srls_fw_version =3D =
le32_to_cpu(rlc_hdr-&gt;save_restore_list_srm_ucode_ver);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc_srls_feature_version=
 =3D le32_to_cpu(rlc_hdr-&gt;save_restore_list_srm_feature_ver);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.save_restore_list_sr=
m_size_bytes =3D le32_to_cpu(rlc_hdr-&gt;save_restore_list_srm_size_bytes);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.save_restore_list_sr=
m =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;save_restore_list_srm_offset_=
bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.reg_list_format_dire=
ct_reg_list_length =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;reg_list_format_direct_reg_list_length);<br>
-}<br>
-<br>
-static void gfx_v10_0_init_rlc_iram_dram_microcode(struct amdgpu_device *a=
dev)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct rlc_firmware_header_v2_2=
 *rlc_hdr;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rlc_hdr =3D (const struct rlc_firmwar=
e_header_v2_2 *)adev-&gt;gfx.rlc_fw-&gt;data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.rlc_iram_ucode_size_=
bytes =3D le32_to_cpu(rlc_hdr-&gt;rlc_iram_ucode_size_bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.rlc_iram_ucode =3D (=
u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;rlc_iram_ucode_offset_bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.rlc_dram_ucode_size_=
bytes =3D le32_to_cpu(rlc_hdr-&gt;rlc_dram_ucode_size_bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.rlc_dram_ucode =3D (=
u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;rlc_dram_ucode_offset_bytes);<br>
-}<br>
-<br>
-static void gfx_v10_0_init_tap_delays_microcode(struct amdgpu_device *adev=
)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct rlc_firmware_header_v2_4=
 *rlc_hdr;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rlc_hdr =3D (const struct rlc_firmwar=
e_header_v2_4 *)adev-&gt;gfx.rlc_fw-&gt;data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.global_tap_delays_uc=
ode_size_bytes =3D le32_to_cpu(rlc_hdr-&gt;global_tap_delays_ucode_size_byt=
es);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.global_tap_delays_uc=
ode =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;global_tap_delays_ucode_off=
set_bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.se0_tap_delays_ucode=
_size_bytes =3D le32_to_cpu(rlc_hdr-&gt;se0_tap_delays_ucode_size_bytes);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.se0_tap_delays_ucode=
 =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;se0_tap_delays_ucode_offset_by=
tes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.se1_tap_delays_ucode=
_size_bytes =3D le32_to_cpu(rlc_hdr-&gt;se1_tap_delays_ucode_size_bytes);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.se1_tap_delays_ucode=
 =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;se1_tap_delays_ucode_offset_by=
tes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.se2_tap_delays_ucode=
_size_bytes =3D le32_to_cpu(rlc_hdr-&gt;se2_tap_delays_ucode_size_bytes);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.se2_tap_delays_ucode=
 =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;se2_tap_delays_ucode_offset_by=
tes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.se3_tap_delays_ucode=
_size_bytes =3D le32_to_cpu(rlc_hdr-&gt;se3_tap_delays_ucode_size_bytes);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.se3_tap_delays_ucode=
 =3D (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr-&gt;se3_tap_delays_ucode_offset_by=
tes);<br>
-}<br>
-<br>
&nbsp;static bool gfx_v10_0_navi10_gfxoff_should_enable(struct amdgpu_devic=
e *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret =3D false;<br>
@@ -4032,8 +3982,6 @@ static int gfx_v10_0_init_microcode(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct common_firmwa=
re_header *header =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct gfx_firmware_=
header_v1_0 *cp_hdr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct rlc_firmware_=
header_v2_0 *rlc_hdr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *tmp =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t version_major;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t version_minor;<br=
>
&nbsp;<br>
@@ -4123,59 +4071,14 @@ static int gfx_v10_0_init_microcode(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (err)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
out;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D amdgpu_ucode_validate(adev-&gt;gfx.rlc_fw);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (err)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rlc_hdr =3D (const struct rlc_firmware_header_v2_0 *)=
adev-&gt;gfx.rlc_fw-&gt;data;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; version_major =3D le16_to_cpu(rlc_hdr-&gt;header.head=
er_version_major);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; version_minor =3D le16_to_cpu(rlc_hdr-&gt;header.head=
er_version_minor);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc_fw_version =3D le32_to_cpu(rlc_hdr-&gt;header.u=
code_version);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc_feature_version =3D le32_to_cpu(rlc_hdr-&gt;uco=
de_feature_version);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.save_and_restore_offset =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;save_and_restore_offset);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.clear_state_descriptor_offset =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;clear_state_descriptor_offset);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.avail_scratch_ram_locations =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;avail_scratch_ram_locations);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.reg_restore_list_size =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;reg_restore_list_size);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.reg_list_format_start =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;reg_list_format_start);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.reg_list_format_separate_start =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;reg_list_format_separate_start);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.starting_offsets_start =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;starting_offsets_start);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.reg_list_format_size_bytes =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;reg_list_format_size_bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.reg_list_size_bytes =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_=
hdr-&gt;reg_list_size_bytes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.register_list_format =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kmalloc(adev-&gt=
;gfx.rlc.reg_list_format_size_bytes +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; adev-&gt;gfx.rlc.reg_list_size_bytes, GFP_KERNEL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;gfx.rlc.register_list_format) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D -ENOMEM;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D amdgpu_gfx_rlc_init_microcode(adev, version_major, versi=
on_minor);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (err)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
out;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D (unsigned int *)((uintptr_t)rlc_hdr +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_hdr-&gt;reg_lis=
t_format_array_offset_bytes));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0 ; i &lt; (rlc_hdr-&gt;reg_list_format_size_bytes &g=
t;&gt; 2); i++)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc=
.register_list_format[i] =3D le32_to_cpu(tmp[i]);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.register_restore =3D adev-&gt;gfx.rlc.register_=
list_format + i;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D (unsigned int *)((uintptr_t)rlc_hdr +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(rlc_hdr-&gt;reg_lis=
t_array_offset_bytes));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0 ; i &lt; (rlc_hdr-&gt;reg_list_size_bytes &gt;&gt; =
2); i++)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc=
.register_restore[i] =3D le32_to_cpu(tmp[i]);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (version_major =3D=3D 2) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (version_mino=
r &gt;=3D 1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_init_rlc_ext_microcode(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (version_mino=
r &gt;=3D 2)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_init_rlc_iram_dram_microcode(adev=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (version_mino=
r =3D=3D 4) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_init_tap_delays_microcode(adev);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(f=
w_name), &quot;amdgpu/%s_mec%s.bin&quot;, chip_name, wks);<br>
@@ -4228,92 +4131,6 @@ static int gfx_v10_0_init_microcode(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.fw_size +=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN=
(le32_to_cpu(header-&gt;ucode_size_bytes), PAGE_SIZE);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; info =3D &amp;adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_RLC_G];<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; info-&gt;ucode_id =3D AMDGPU_UCODE_ID_RLC_G;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; info-&gt;fw =3D adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (info-&gt;fw) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; header =3D (cons=
t struct common_firmware_header *)info-&gt;fw-&gt;data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(le32_to_cpu(header-&gt;ucode_size_byt=
es), PAGE_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gfx.rlc.save_restore_list_cntl_size_bytes &amp;&amp=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.save_restore_list_gpm_s=
ize_bytes &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.save_restore_list_srm_s=
ize_bytes) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;ad=
ev-&gt;firmware.ucode[AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_i=
d =3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D =
adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(adev-&gt;gfx.rlc.save_restore_list_cn=
tl_size_bytes, PAGE_SIZE);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;ad=
ev-&gt;firmware.ucode[AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_i=
d =3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D =
adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(adev-&gt;gfx.rlc.save_restore_list_gp=
m_size_bytes, PAGE_SIZE);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;ad=
ev-&gt;firmware.ucode[AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_i=
d =3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D =
adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(adev-&gt;gfx.rlc.save_restore_list_sr=
m_size_bytes, PAGE_SIZE);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx=
.rlc.rlc_iram_ucode_size_bytes &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;gfx.rlc.rlc_dram_ucode_size_bytes) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;adev-&gt;firmware.ucode[AMDGP=
U_UCODE_ID_RLC_IRAM];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_id =3D AMDGPU_UCODE_ID_RLC_I=
RAM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ALIGN(adev-&gt;gfx.rlc.rlc_iram_ucode_size_bytes, PAGE_SIZE);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;adev-&gt;firmware.ucode[AMDGP=
U_UCODE_ID_RLC_DRAM];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_id =3D AMDGPU_UCODE_ID_RLC_D=
RAM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ALIGN(adev-&gt;gfx.rlc.rlc_dram_ucode_size_bytes, PAGE_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gfx.rlc.global_tap_delays_ucode_size_bytes) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;ad=
ev-&gt;firmware.ucode[AMDGPU_UCODE_ID_GLOBAL_TAP_DELAYS];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_i=
d =3D AMDGPU_UCODE_ID_GLOBAL_TAP_DELAYS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D =
adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(adev-&gt;gfx.rlc.global_tap_delays_uc=
ode_size_bytes, PAGE_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gfx.rlc.se0_tap_delays_ucode_size_bytes) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;ad=
ev-&gt;firmware.ucode[AMDGPU_UCODE_ID_SE0_TAP_DELAYS];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_i=
d =3D AMDGPU_UCODE_ID_SE0_TAP_DELAYS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D =
adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(adev-&gt;gfx.rlc.se0_tap_delays_ucode=
_size_bytes, PAGE_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gfx.rlc.se1_tap_delays_ucode_size_bytes) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;ad=
ev-&gt;firmware.ucode[AMDGPU_UCODE_ID_SE1_TAP_DELAYS];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_i=
d =3D AMDGPU_UCODE_ID_SE1_TAP_DELAYS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D =
adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(adev-&gt;gfx.rlc.se1_tap_delays_ucode=
_size_bytes, PAGE_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gfx.rlc.se2_tap_delays_ucode_size_bytes) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;ad=
ev-&gt;firmware.ucode[AMDGPU_UCODE_ID_SE2_TAP_DELAYS];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_i=
d =3D AMDGPU_UCODE_ID_SE2_TAP_DELAYS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D =
adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(adev-&gt;gfx.rlc.se2_tap_delays_ucode=
_size_bytes, PAGE_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gfx.rlc.se3_tap_delays_ucode_size_bytes) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info =3D &amp;ad=
ev-&gt;firmware.ucode[AMDGPU_UCODE_ID_SE3_TAP_DELAYS];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_i=
d =3D AMDGPU_UCODE_ID_SE3_TAP_DELAYS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D =
adev-&gt;gfx.rlc_fw;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmwar=
e.fw_size +=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(adev-&gt;gfx.rlc.se3_tap_delays_ucode=
_size_bytes, PAGE_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; info =3D &amp;adev-&gt;firmware.ucode[AMDGPU_UCODE_ID=
_CP_MEC1];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; info-&gt;ucode_id =3D AMDGPU_UCODE_ID_CP_MEC1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; info-&gt;fw =3D adev-&gt;gfx.mec_fw;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514443C746109B972824368BF7519BL1PR12MB5144namp_--
