Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C384CD68EC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 05:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A7010E165;
	Tue, 10 Oct 2023 05:30:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6297710E165
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 05:30:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYYovyS/X+zu5gegaM0WB9xbS1a3w+lL/rcAOVTFjGSHhqyvY7hEaoqSwpiMptQP+6xTxOlAUFrS3Lc3cTVApOYxc9nbveE2FToM9sSX6cSOp96+EPCL+EzMddH/kgVwJY2HkqbL+Bf28elbdXhfzLNzWCFdHGFNyptTe8JFwocl64uCDG/g/osEAN+V61gXlj0ajXEy/00pvfh/+MKJTfD+bovmzlo5PX66meBsrsh1hU+UkA2a4TkhwCkz3UqSnlPMyYaziQvqWLCtmCKcMgMXRHBG9+VOIAaNJ3KKL6YIlAOaVAg/0eQkJvhiBe7d+hRZYCFHRJQbxu89gx4w2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRctiVGhCQXwbVjfrkCNBE7UjZZQOZ8fnFljGd+8A/M=;
 b=Jnd+9on1Jh6D1Jg603+ihClENyV+17GD9wK3dqp1tUKHwy3GmdiQPvAnrW1RmokZ0CUiJAhqO/HwnsEwQHxZLVJdJGOe7j6UsoB/95nQLmmNdane+IDZVvJ4jvnjCt6oEhHyVQGyg3V0YLYH+srnB9wJeBy5VWPCCnZ/cOhWwHkST/ppMFHgoVKLygOopnilktzs8W8SYTHml3cjbr0fsE9MYmDPIEEWxR3XXGEWwWCs2qNFqu6No1nu/IiPUDx4njFEwitIqSoEaOedTmqG+6fmI5NBCuliwDWYaWn4mV3qjbOoMQhjDM4rT6Qj7agVwNmLW/XpbjX3JByLYlIFUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRctiVGhCQXwbVjfrkCNBE7UjZZQOZ8fnFljGd+8A/M=;
 b=VR5wBsojAn+Qrx0rg/TuB+0U8WzFgiXO5Ixf+4iQjbMdn/iT3VBIO3Udu84och1ZAL+yBrZNFRa7gNuZvZnuYMMfRYxJMc+3cz6NJwpkBU9mf7UyzswJBgcAB51uiVy20yjv9b42zjARq5qWZqJHzvor/b/YJPfMdN7gO+AMPBM=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DM6PR12MB4331.namprd12.prod.outlook.com (2603:10b6:5:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 05:30:49 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd%5]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 05:30:49 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: wait for completion of the EnableGfxImu
 command
Thread-Topic: [PATCH] drm/amd/pm: wait for completion of the EnableGfxImu
 command
Thread-Index: AQHZ+zUQMe7CTb/kAEuDw6eCVSAk+7BCe3fQ
Date: Tue, 10 Oct 2023 05:30:49 +0000
Message-ID: <CY5PR12MB6369E34EA2E32E802309309DC1CDA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231010044637.3211216-1-Tim.Huang@amd.com>
In-Reply-To: <20231010044637.3211216-1-Tim.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8874864c-7f89-4b5b-968b-2c50900cb0b0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-10T05:16:36Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|DM6PR12MB4331:EE_
x-ms-office365-filtering-correlation-id: efdba9f3-d1a4-4398-5342-08dbc9520fbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rozoh5ATV/b/1IZpQDjaPpmcxFyhbij0IyUtSeOOY0cyw3fztbfSnSJCPuLz550wJ26qVjocdsPCj0YwQo0KPeAd3r9tetUlD0KggGtlq8SxF/C2w4YtE9weU/U24C50AvyBnHLJHnNwlHwSkmtEbFaWtBviDIRqkfgSospRmuzWSYQdLY/YFD0ikKbVD7dNkozmIK38wPFXNa0D2AvLtY1HGkny6J0KzI0250U5LJ627z0bUBeFXodbV/xi1cLYjcWM3kXkR7yAbC6hLD8pNVXC6zoCNFLKywY5qKKfLJ6+Zif4tSA626jvx5e4ztmIsQtKY1nRdD/QrOdwOIcCdLhs4NhRy2vhbQKoLTbBjz6qAvE6gq4xDyaXyewneBb6CeEKbzcqaK60M+h4xvqOoDQ/rnWf447bOVXtpC8LuhUl1DKml2mxv3JA8AAluY2QvJjnH0orop1POyQupU1tAlaJsGBETcLDWcRUIXUVs4gDYfLR1xegdwhXpAM9cAIplc6rbhms+M8YqLc6RqfAeTipHTRMc5j5uIA/MHWFf1Xfwx4pJul6Er8vTGX1Wrci/VEGnUurS4xVMfrASXXQ+idFBfjOUNUljUzI/XjE20Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(26005)(53546011)(71200400001)(9686003)(38070700005)(55016003)(86362001)(33656002)(122000001)(38100700002)(8936002)(8676002)(4326008)(2906002)(478600001)(6506007)(7696005)(83380400001)(52536014)(41300700001)(316002)(66476007)(5660300002)(110136005)(66556008)(76116006)(64756008)(66946007)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X/2S7KaGRSx6zykooXFMjSbo+E5K2CbrNWOwCqXroZpFzxKDhne220srXB+Y?=
 =?us-ascii?Q?uUF9TpGBDRo0N3d+cttP9sCGN5KRlQ6C2CSXR37ZsKOcL4fRJ/JKNoxr+20h?=
 =?us-ascii?Q?CxoEdeKXDrE7BdPC1P5/y7XmIUz8PX0RHvSoet2X2zojbti2vTbHChAgcbjY?=
 =?us-ascii?Q?5paPamMquPmGd3mKu64AYRdP78KQ1pBptq1gZzgKvYHPi2owH+g0upEwqoKC?=
 =?us-ascii?Q?M9ZmhnRMfwzHxuULliCdKMdM0xnNL1pqlh2Dul+RfS4sikH5FWwLCEtcIXGK?=
 =?us-ascii?Q?28R2zW1rKB9WM+TcrVxmpnaMMqncMzpkcvMBikbZaWM7t7cdEOelFNBqX9VQ?=
 =?us-ascii?Q?8ZcFZtgjU36pQL14rGs87Pj4hJ4IqTeL7HM8vpGDGle8qUvFTRl5HUcjkwAT?=
 =?us-ascii?Q?fSlP+G9/MWHeUjF3E6XjTIV96fgwo00iKxXigd2PFDQS/G5vfyOnDDB0FqSY?=
 =?us-ascii?Q?os8OWFFuyNdrCME6J2y5mXjmUFS6L34hkvImqDyQz1Rx3NXhgcWCaYhPQXB4?=
 =?us-ascii?Q?HLja9hgw2wwTNrm/KhyD1ZMFdGLY43GJ+c9OmYuuXECINfxcmVc6cTX+WBED?=
 =?us-ascii?Q?J/3mSADxHuNRwTINyuHwz7bhDXWvH3uy7/5nY/3ZHdT285pOt7DyKrLVbvWc?=
 =?us-ascii?Q?O6kn9fIKN5vg9/U/S/kTGE6JUCPLrAfk2ldspZO3poyH25tz7K+jgHeZyZKa?=
 =?us-ascii?Q?7A0IAnP2nlNISndR2fTXMEoafGWw0Xj8woZQeox7UES42ANpeed6V9STGmSj?=
 =?us-ascii?Q?7bIL0LGNIbRxux9hTIXgIZkUqvadb2dtEqoq4w1Ums1sB5CyHIYMtRoZM+hI?=
 =?us-ascii?Q?VO4s69KUeyo5RIfyiXGvJyR3RVva7A+zgytlX8E9mUp6n7v4csNLaQ1Q5/pP?=
 =?us-ascii?Q?8OdxAtDJ/y8VTnovJ6R9FPb/Ei1dgOJ71BOmNgknXx7kDYN+yUocDLw8axg9?=
 =?us-ascii?Q?A4/0/fqccXxwNSNfz9UGI7DkOFR9JfRoWzEQCqP20+5HN8RnYIi741paxNX6?=
 =?us-ascii?Q?C+SAfOWdnlKJl8LAANQ6pUiMRUg2kJyZWvZ8rQ4wXNQ4qP///+oCD1xE7ZTH?=
 =?us-ascii?Q?tw1gj9SNOI7jS/tUolk9DC9lttPc10Eb+OrDZZHWpi97lo07cRw9ivTT1ob1?=
 =?us-ascii?Q?Ee7l5vmaR8NIIl6MzaZvyuGY70bfJ2bRvfSdlJzrn3+unF0sqtcMw8LqXnBj?=
 =?us-ascii?Q?CwmlDprOt4+mB4OOCv+qMzZnnWfE0HYu/WRNFrGZbxKIQzqAYGcZ71ps206S?=
 =?us-ascii?Q?OLpZKr29rdQ6GDpnq7FQfJgkxnovdXIoJzW4IzboIwrplkxbxDpsl6YrkFbJ?=
 =?us-ascii?Q?31Sjj6Dzcakz+osa1lweXNz8jhDtdnGXDotmbmj3MbhNUOaXdLt2okyC7D6D?=
 =?us-ascii?Q?wXRVvCY7xihhHpdLm9zXFEDDXPUMcSNlpEOyBT4mDJd2XRQRKxNF2jy+Ou8q?=
 =?us-ascii?Q?1DB9SMJARC/p4HycpqUFvW3iN6XxeZARuTGTiptYUmPDEAtc2KRdFbNDydt0?=
 =?us-ascii?Q?ygrQh0cdalaRbCvdZhatuhKhIhbhfZWvP79xzguoMytZZZbkfLYex2+Myvbb?=
 =?us-ascii?Q?dy6XC6vyonRW4+uktUg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdba9f3-d1a4-4398-5342-08dbc9520fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 05:30:49.1615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssXBsJPwXafgYMZjWJJu7nI+Hv2E1jkeWjB+kSL2n74b2DO2lGHgdSSNwSm7vQu2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4331
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

I'm wondering why it is "without waiting" in the first place ? It doesn't m=
ake sense to continue driver loading if power up GFX fails. Can we apply th=
e change regardless of load types ?

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Tuesday, October 10, 2023 12:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>
Subject: [PATCH] drm/amd/pm: wait for completion of the EnableGfxImu comman=
d

Wait for completion of sending the EnableGfxImu message when using the PSP =
FW loading.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 8dc683c02a7d..bcb7ab9d2221 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -82,6 +82,8 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_10.bin");
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xC000  #define PCIE=
_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0xE

+#define ENABLE_IMU_ARG_GFXOFF_ENABLE           1
+
 static const int link_width[] =3D {0, 1, 2, 4, 8, 12, 16};

 const int pmfw_decoded_link_speed[5] =3D {1, 2, 3, 4, 5}; @@ -2301,11 +230=
3,17 @@ int smu_v13_0_baco_exit(struct smu_context *smu)  int smu_v13_0_set=
_gfx_power_up_by_imu(struct smu_context *smu)  {
        uint16_t index;
+       struct amdgpu_device *adev =3D smu->adev;
+
+       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
+               return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableG=
fxImu,
+                                                      ENABLE_IMU_ARG_GFXOF=
F_ENABLE, NULL);
+       }

        index =3D smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
                                               SMU_MSG_EnableGfxImu);
-       /* Param 1 to tell PMFW to enable GFXOFF feature */
-       return smu_cmn_send_msg_without_waiting(smu, index, 1);
+       return smu_cmn_send_msg_without_waiting(smu, index,
+                                               ENABLE_IMU_ARG_GFXOFF_ENABL=
E);
 }

 int smu_v13_0_od_edit_dpm_table(struct smu_context *smu,
--
2.39.2

