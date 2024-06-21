Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CEFC27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 05:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9276D10E120;
	Fri, 21 Jun 2024 05:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qhNo/3PM";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9156110E120
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 05:57:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWz4neUC/H9jnAZU2bv0MdzzIqDyT0CkVvo2fgghHmlSZBdClGPB4Ox3hJ1qlMnAGjr7QuwfoAi1ZVkfNu80OlIV1xPl4mdlky5Rb+r4wM79cDr9KiA9n9gyTOPKc1AVTivyQVdL7Gbw6LhaTnU6fs9Q6EkwPbanlbNeo7TlOc40e5q2dzl55TpbNlGHocoZIrkVq8Z7cnYdkWdNWe5bohF7nDo/LK5oKOwvJPQESMij6ktWjt1WtVqnIhylIGO43ggfVHR7+3qwvXUVBDFGP7XoELYL9pgrolMfwbP+43OHWw5MDqwQ0YDiqrs2AfVincXs3jd9fANmCCD0uUqo+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkQnmuBEGlCYnSJEzrALMdShly4LdAFB/QJHq4A5v6A=;
 b=Ypr98jSKoB/n/ov3rnji+Or8QaoG/GNdAuEYpa1eFrVRO8jDxaEpbSWZHA/KN4Ajo4RcobLKdRG5iS/YXKTsl2ph01TVtOkIM1CXHL69AJ9BskuYq/K/pwfoI4GmJ7SVYe3xDaLL6Usq/Bm4ykWtld0NIT+mp2F5fLr7Kt1+9YWrKgDOKhBA0MohHxNFM8UIs2iB0Ux1EIhdSceluhj1sm2KEYDufgGy1YpdXec5696fLV67HKlG3s0qzTfRS0cJXqI0fs0Z3unzEqw6qtc/+YUnQqRxzoKJepHZfhzp3gMggrRtKdo8LutqaQQD75QzA0OtLkX9wSIL0xd6B4zSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkQnmuBEGlCYnSJEzrALMdShly4LdAFB/QJHq4A5v6A=;
 b=qhNo/3PMcXCEU3K4NT0HqYIl85zik4oyDOF3wGMs6aspgBUtHYiSwL7LBe4xWJ/s3n/RFOeZlaCSxFzEXQNQxnupmdpliNbn8li520zGB6g67d/T39xjSCcwVl9S63WS9danBQG2GWMb8j/sqP2g/vL9OLg2MHIjH/dZN8oq4SE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 05:57:53 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 05:57:53 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Min, Frank" <Frank.Min@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>
Subject: RE: [PATCH] drm/amdgpu: access ltr through pci cfg space
Thread-Topic: [PATCH] drm/amdgpu: access ltr through pci cfg space
Thread-Index: AQHawtUswDGG8EbwkUCB1oGxLTFsF7HQNsoggAGDUyA=
Date: Fri, 21 Jun 2024 05:57:53 +0000
Message-ID: <BN9PR12MB5257ABA1684CBB09239236FDFCC92@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240620054406.2662-1-Frank.Min@amd.com>
 <SA1PR12MB5659299BF8D06931F83065E1E9C82@SA1PR12MB5659.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB5659299BF8D06931F83065E1E9C82@SA1PR12MB5659.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=28e05613-fb91-46a3-8559-6dc3bffd5400;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-20T06:51:08Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS7PR12MB6008:EE_
x-ms-office365-filtering-correlation-id: 996483f8-c418-497c-30bf-08dc91b7176b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?gJGcXOqJXIVeWSQ4S6dYcQfBfH86Fx+otkeVslHTRlpQSAXDa56Hs/KDTdUO?=
 =?us-ascii?Q?bzz9KHU20jyUWIdvm+ZhhP/y3rptr7iJj3zOASaq/uR+UwzrJWj9yjEHueIK?=
 =?us-ascii?Q?PXxTUdQ+tZNWLSIfKa3EzYKxyWkt2DRChf1A0KqdjZkSWAD2KzdqPiCFmr0+?=
 =?us-ascii?Q?IxoL1Vtrf46rXQVPxhY0XApP07ji1XUETP+wUsUCuLKPwTwdGuqHMF6U0o35?=
 =?us-ascii?Q?HlloHXcpvyrOdM6ILjvJPkvIDrdcfm3KdAen9+cd8FJ/bGLxGAugJ/r0s1X8?=
 =?us-ascii?Q?jZRHpSWxXThwO0c+uUGt22Ln5ak11vbRQnYJHHttdL5/YTo6/888eCUyupC6?=
 =?us-ascii?Q?YO/SwP2ssf/z8K2pRF1+S5BUbQnl71imhQNQ7z4GhpawJDyagY3VgxjQHNuM?=
 =?us-ascii?Q?PJEPjOPdzaZYl6eqQbB5yF95ioKIVMtmuJdHNPdD4P97fzWM1IKLTVlrkVHl?=
 =?us-ascii?Q?Om1HeVkODJrFfZgmGNNpq9deveF7YYoEC+czP2InznE3bOcvHIfzkJ141EtH?=
 =?us-ascii?Q?qVlbLqqqjNqrZXasC9TmcbB1sutRTX/ztDta2g2PEGJir3PhwSFrp+N6oK0P?=
 =?us-ascii?Q?wLQaYcRfEi8h05W+yyt7el8GDLBS9JtT+i1jCKFOu/es4pKpg7qInvI5o19L?=
 =?us-ascii?Q?Gcuf4L2dVIrz0s1Kb7qrWN+8WofKu7U8PqgqJKJrr/OQ7U2RXfqXAWeQjMUr?=
 =?us-ascii?Q?13qczLYtgt2WeIVV9ZXqHzpq2u96noxxO4x6IXFZcbuFMN3lLY3UU4qQMDnY?=
 =?us-ascii?Q?IWSL7yJIyX6DFOOjORqhDezbxDIRKkDe17UOfjZxjnXUH6sokdDe+kZnIjD8?=
 =?us-ascii?Q?S96YLPFL1jKuD/RhdQJ2h0+lO2UYak2QGZanmwblwa2KSi1he+gm1lh9HgFj?=
 =?us-ascii?Q?v14Zi12gxWBGKX/Fjb/s89QtrnUiVq1sNMcP/8ileigsnqJ5IMsXOfBHU5QN?=
 =?us-ascii?Q?pE25NhWFWY23RIj0wVws0tg8Ta4Zxap6+bo7GQs2H5RLzdYl/J3KVt/GJOEH?=
 =?us-ascii?Q?BihBwq9PTDMbL/oubhcOrAPZ3C05qUPfekXwGW6o3VH1hzmlLYc/WhBeq9rK?=
 =?us-ascii?Q?3ViVtYdDSHhjhJaPyGOb7geWgUB76pws3D77RKlelvpZytDIifkijeIqkOv5?=
 =?us-ascii?Q?cxfXs9/6Xe2LS0Xdyai8IsIYT0A3zJdCFuL/0beuXLRkVGg3ZdsZNq5+mA70?=
 =?us-ascii?Q?gRvFEqzL/5VE1dbuzPSDVBYAt1DOCyQ/Hqy84NgKczOoEYg4Er9t/4QNnIf6?=
 =?us-ascii?Q?ebA08Nl1w19Gb0uzxPeAKE53qBZCVgm2hWXSKWK+gjgQxf855cdKgprBQy0h?=
 =?us-ascii?Q?SdEPRCzGon+KfCYelTttru5cvXR1xulnBfExl475um75ZocbciEmvcfmKKU+?=
 =?us-ascii?Q?46eg7Fk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1YKlagWyHC32z7qRTcc8Glqjn5f6ISfLwRn4nL1Rvgaz6MEeHNUk1lh7vIDu?=
 =?us-ascii?Q?0eGhOZBpxNrsGM7dth+CMEBjyzEoWXTV7qIY60pjMqR5U0O9FqVvvTIeZeh3?=
 =?us-ascii?Q?u2Zx2K0tJmnugt+2Vmml6lviwYeaS6+0U9w4H9yLhp0HvlTZxcoXuuj0Hd/n?=
 =?us-ascii?Q?X3WkiShPRKAB4E1Ay37EXcLlugh+ReDDCfcHNfXYtm5nj5nbcrKRy0JCaubG?=
 =?us-ascii?Q?HFAIhUZn1hVnsoPYfHDnQi8ID4jxGuTNOjdjbLp55L1AvXcms4NAo9e+bmjT?=
 =?us-ascii?Q?d9AkBAcKyKCwCN875YSB2sfkcUrpclLXurkV0NxE0QahrzFGLJnTDAbK0I4m?=
 =?us-ascii?Q?+xxdmIIwRID6v+3NgjBFJUdLEHBUJ2uVcHqclfkT4IzqYr8nvfNHBoLeCfbE?=
 =?us-ascii?Q?Ow1I1K8CmtBomO0TAPrgEonj7vsxKyk4Wib7JxW0uam8Sb2QvRHvRLI8U8UW?=
 =?us-ascii?Q?76s3HPYp4tqUexjzNgjD3KU8nAAB4VuvjoYZQ+61v8BMvxRnQ7HRAHRGjUm4?=
 =?us-ascii?Q?TTcuiCJ0q5buePbfJ6mWUBBiErLOIa5x9vzCE436I3f4aXCbkvNg4ZF+wz5B?=
 =?us-ascii?Q?/hUmHuB4b8qHKCptp2yiQOon5fy19O89LrGmfABAn343cKCIYCEastHlOBUd?=
 =?us-ascii?Q?i+nFm5QnpuVkVwx1ulDwLOAib1GYd4GGwWAL8Uw2iHRyAlGHlPpeYE8drmQe?=
 =?us-ascii?Q?s0DPKrhpELYAUxPIyIOt4jwQHZIcctfZPq7juVVxR/PRpCHAMIyBfW5OIGb3?=
 =?us-ascii?Q?q80Ij5ThpHo733mJU55TovvcZnh0I/5gcBUy6ekCYh4UIT/oD91nqXxIyET0?=
 =?us-ascii?Q?0DtmR6HA54mQk24KVHDvDG7ZIwC3Cx2ptAcbX1GiRNumjBIQxvxa+bJyf5Wo?=
 =?us-ascii?Q?+H+a+RVcwwDahQJewXugzwxZBz3fhTuRiNQ3QvyBqpKSU5I5cxp6BgIacyEr?=
 =?us-ascii?Q?Mu78rrld2rvVdMxqwHOLufHM46ZOkaDiqJKZpOat8P7gKg/fViGifqV/UkY8?=
 =?us-ascii?Q?gOEplDLiCbUd4Uldz/MZGvKL7Yxd+WuiB1BQHbPlO7MSP6gh/fYhgDGPCWO+?=
 =?us-ascii?Q?yi4pcB+I5Qc1/jITBO6xuYLR8OatnUU7GDL22wc/z9mKGQeTCdeHQtbQ7dhp?=
 =?us-ascii?Q?JeFf1YLfeb1B+0zdYTrfOUiMU6xBGjq3O46xjRx4KuIje40xULqTll6aDdpF?=
 =?us-ascii?Q?0tMfLM4nIERAw8y1/yBFjZWb955q7kL+uqVuEvRc0F6Xl3wI4NtBTd22CKO6?=
 =?us-ascii?Q?vI5dfu+JcMg2P4kCaoCMAWM3G5CoDLpNAv1b5s54A/novtAiLhUslt9u91qx?=
 =?us-ascii?Q?hNMj6ihzFHoOHnbVpsUej5PXZUvcyMBubne+dT0hKkOqTlneFQcIPuE14g/S?=
 =?us-ascii?Q?iMNiLeT2BzyRwqUOZW7ImH/wRxwHsqpKNKJG2kWIigEJO1RbOckqJavYpoh+?=
 =?us-ascii?Q?U82mrAPs+JWR3Pj4SEz+OgNd9zW9ByUlBIMvQM1Fdek/kvOq55EA7Q7izeNv?=
 =?us-ascii?Q?Cp3sc6Nj4SHJ8I0eblNeIcm9qgmC2w94VKHJxAtcoaFbX2MqSEsFkevhEwcE?=
 =?us-ascii?Q?fDFNTZKaI2VBxz/YEewJBBeU6x6P6FerYmyuO1Li?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996483f8-c418-497c-30bf-08dc91b7176b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 05:57:53.7249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xaw1cWy/m1bKYQYK9VzIB1IuZI22T+p9JUcCyhgQxh4z42FaE8ngQiWgNGl8H6OezygH3zCr4QzHAR1IuCv4AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Min, Frank <Frank.Min@amd.com>
Sent: Thursday, June 20, 2024 14:52
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Gao, Likun <=
Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: access ltr through pci cfg space

[AMD Official Use Only - AMD Internal Distribution Only]

From: Frank Min <Frank.Min@amd.com>

Access ltr through pci cfg space instead of mmio while programing aspm on g=
fx12

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd=
/amdgpu/nbif_v6_3_1.c
index 5a20bb229788..39919e0892c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -345,6 +345,7 @@ static void nbif_v6_3_1_program_aspm(struct amdgpu_devi=
ce *adev)  {  #ifdef CONFIG_PCIEASPM
        uint32_t def, data;
+       u16 devctl2, ltr;

        def =3D data =3D RREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL);
        data &=3D ~PCIE_LC_CNTL__LC_L1_INACTIVITY_MASK;
@@ -374,12 +375,17 @@ static void nbif_v6_3_1_program_aspm(struct amdgpu_de=
vice *adev)
        if (def !=3D data)
                WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP5, data);

-       def =3D data =3D RREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_=
CNTL2);
-       data &=3D ~BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
+       pcie_capability_read_word(adev->pdev, PCI_EXP_DEVCTL2, &devctl2);
+       data =3D def =3D devctl2;
+       data &=3D ~PCI_EXP_DEVCTL2_LTR_EN;
        if (def !=3D data)
-               WREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, da=
ta);
+               pcie_capability_set_word(adev->pdev, PCI_EXP_DEVCTL2, (u16)=
data);
+
+       ltr =3D pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_LTR);

-       WREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_PCIE_LTR_CAP, 0x10011001=
);
+       if (ltr) {
+               pci_write_config_dword(adev->pdev, ltr + PCI_LTR_MAX_SNOOP_=
LAT, 0x10011001);
+       }

 #if 0
        /* regPSWUSP0_PCIE_LC_CNTL2 should be replace by PCIE_LC_CNTL2 or s=
omeone else ? */
--
2.34.1


