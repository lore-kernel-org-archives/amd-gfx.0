Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B87C04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 05:40:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 068E311AD61;
	Thu, 28 Jul 2022 05:40:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92D6A11AD36
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 05:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hk66lF5f5PU/YjW2OkVJCtCJiGhKC6UHhk/7eqN7q6gny1NSjcjHbIjEzucbRK2yr6UQPWmUTL/MLhfGDrnU2lF7e4gk9hu5MxMIMT/JDLbcnPRORA+ZYw+bChu981NXwrEUkzvYg6GY3bVjbrboCWVcPey55KWlPf/7hA4h9e2Fn3ZI5JDGbFSpad28GOrtZN3B+hbur/vNj+9ZLNg6l1KBPsaqpYVJ0ZBFzCAHGJcF8qwS7t/ehnJyeTHzueXrxbGA49zgA9oTUOGBU63zMe5xJnTXTBoA5uXhGNzT3Sd/v6SUs6fVAGI/nRwCuh0BMpHIcJduW2FhPisMwl/QNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0+a0kBvSQLuuENwFftJrkvqkeZaq3VNgk2RQgKRlF8=;
 b=Z7ME6Gwtea8KUiX7QcE4C0MdVTwkYL87kQROM6RXbB3ijYQ3/aRFyF6APANzvJiTTlSFqF/3UFC2ygn63H50uJSjgRbkLNBQ9mFjjnEf5c4zdk4izf2FCKly5akeNpzNlecRDMG5zaKa+kxgXbsySqULRQuCXrZHgwzY2tEJmw29sjFifzZvWpnwDKuqWg1pnzp4ZfExoIoYigLdJXLFGKNqvNimqHhs9eQUuKoDqXjbL/SR+BurXQUH30OMMxugW4p0ToeFEHGeuSEm7nqT8aJ2fk5gFIspnB36wHoirme+KqEgSWAgjejpCVWq1ooUWIRfz954OgguhAZV010FTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0+a0kBvSQLuuENwFftJrkvqkeZaq3VNgk2RQgKRlF8=;
 b=teb+O8/bPDK1BLtTK7+Rsm7JoQzK7ajfZs/M990vRMo37XcjwoyBkM9OObM3AmjU2cP2RhAJCNZuwX9LwpzhGfjtecSd4xANbwSZQXxvydY+asd9x8RiFoIi8V41r11nxm0sSEQk4fnTvPE+Yoa1NsibWgcspf0RgV4MJum4KBM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BY5PR12MB3972.namprd12.prod.outlook.com (2603:10b6:a03:1a8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 05:40:05 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c822:1616:3d10:71fe%9]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 05:40:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amd/amdgpu: add memory training support for PSP_V13
Thread-Topic: [PATCH v2] drm/amd/amdgpu: add memory training support for
 PSP_V13
Thread-Index: AQHYokMUl8KKIGuLk0CgCGvtP7uh262TRF8w
Date: Thu, 28 Jul 2022 05:40:05 +0000
Message-ID: <BN9PR12MB52571872484E651FD00E8497FC969@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220728052928.5834-1-Jack.Gui@amd.com>
In-Reply-To: <20220728052928.5834-1-Jack.Gui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-28T05:40:02Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=312be21d-3b2a-45b8-a440-df026e7c26cf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29a4a490-c797-4a40-6a57-08da705b9fc0
x-ms-traffictypediagnostic: BY5PR12MB3972:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KoGZcDnmX1VvFOyq0ibu5z7xpJjHeK99U6SsZm7dy4hECR4xUpO26d/rkFDeDnvxawsniERMczsUHVgOH+FJO6wNFo7NDUCsLzimuQEQVKoisYrOuVDcUjMpysEbzXswj2Ferx/G+M4iSnm2MNuaMAfcqlxNQNFXAVY98TzWU6w1vXFMwBmMkNT/LWDhBDJBSUQOPyBjAFqVR93tXOUQ//rLSredMZYijSlThfRrDmADEruJomMIqPJNbl6eRmfSgGQhrLnx25t94E+Smf4X9T+cPFVctKgpyT6rm0XFxFVwD7TdbLlOUt4bIR6NMTHT71Df//WOA1ZTfI08HUHQBd1q2diEJPA3U+pGvKYK/0maAxpjdlwpMytZ0y3mVYPPEEhUQ3tv5WpauudaaYh6sIN5rcJLpyd0BhKB911kDHztR+RcQAjslgc29tPttJYdsNfSyORVSv0nTomDgkASiddkfSnDA+oWVqlUUA9sEzg7SoyKzK4WFhClvTVPLJ9mSJWIeauMQ9ksyxCtnQM/PLIgz5742GBNw9o7PHFBLLyPAeQfOGY4RLtzvIBjcVeMMiKDXMBs1RB5lu7EjuVACRUgbGcaIhtdU0SMdmzS1HChx3dzMNm7/TNo+xeHATB9/ssmQSI27IDRg6TrfqPHujC+NSlhH9HDONPmueiRONwsITc7ve+hIuSAW4XVUyR6sK9L402sBbMaPdSPL7bKiRtRha0ST/eFCpWuVJeK5lL1ZcNkaUaxAyqZEEbwe6pKIQ7CGIDF28sGrE+7xO6xBs2wf8ZKeKnMthHen1hY9xa3aYcpi13CyaMGz2mGbgYN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(6636002)(7696005)(86362001)(2906002)(110136005)(66446008)(316002)(6506007)(66476007)(71200400001)(8676002)(64756008)(66556008)(33656002)(76116006)(41300700001)(4326008)(53546011)(122000001)(38100700002)(26005)(83380400001)(9686003)(66946007)(186003)(52536014)(478600001)(8936002)(5660300002)(55016003)(45080400002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OODlDmNwQjU1vZP5MrOo1OuTK+OGCrbyO8/T+swPL9x5A81v7L/Gb0voNP1y?=
 =?us-ascii?Q?1RvJXd5gI3EB7yYE8vutklLN8Ha9oa5YfSVK/RsBQlQICdP1vVlXuGZxy6mZ?=
 =?us-ascii?Q?x+EgPYNa9ncKRyezconqqz1gfqduCvyPgvSbrccoa34by09HkhuFrMB7OTpY?=
 =?us-ascii?Q?KAS73zIC/qRifZDgvN75aAcND2jJqFFuHl9nUbqJx/HACHYmzC3j6pLjkktm?=
 =?us-ascii?Q?6+xB4Oe4VkH5aEgod+CSu9ImUwsNrO+x85CKsptS7rL5WXDlUjr6MKQ+cvMi?=
 =?us-ascii?Q?/u9+u36MLbtHNShK/AxCgSugSOO7KA5fG8pHmEtrpdZ7M4yB0dryxHw9XizC?=
 =?us-ascii?Q?MrG6FKdRCXjftL+WUpV2nqk2f95DuQkjKS2unF1JpUCc6UnU5TNmWIv7DIR1?=
 =?us-ascii?Q?CGkb5n5ytDsd26E6y78UdWfykzEtwuzy9Laj/OLwFbJxS8DiZLgW/cL3xv/M?=
 =?us-ascii?Q?g71zlmk4kp5MKhj5f7oC9pEWRF4Kd2h2AZFnUwqJT9rSKs2HY2KcKd9nR6fL?=
 =?us-ascii?Q?yzWDXieb8i5vqYPi34zC4gP8CJS8UKKSvhbIdGy1qRhT8HxUBTv3uAAMhyP9?=
 =?us-ascii?Q?1gDJtgvpzdFZzKPgVqo3dKxAcOgGsF4ZJf0tYLNRGM8H7PDSIi5SRlSGomNf?=
 =?us-ascii?Q?+2v3ZLKU3cVzsOWed9eQ28wSR34V1p7eOQ1x7lvLlGuI8xEqffo8UlgR7K+j?=
 =?us-ascii?Q?3xunuMBpLSSI/jOi7mzV2IycbxWCsHzaGUTHUuywq+Me912REeJDveENcO8F?=
 =?us-ascii?Q?JSQjQsopJuRW1CbzLNW7R7GE5g6om6x9Dcq2LaRPEEUHKn0Dz0Qtp+Cx5qKG?=
 =?us-ascii?Q?EcFaB+CL235b8sXaHvTuBpE4hTu//1a+vgdsvZbizSs9IRpkRDi8Nq6W5QpE?=
 =?us-ascii?Q?+/+eNSKpQoYMX/EmVVgd2JDk1NHmWUldeSRv19g6z4uoC3wNlKsbfTHYJ062?=
 =?us-ascii?Q?ppPU7PpOiDINjEnZ2DZ0A8qY1jJ+Ir6iVetx7ECr1FEF2pAdQR9hhOvgkrF+?=
 =?us-ascii?Q?CRMGSirKPZwOODSjvxUOyLb8CSn0RvV07/wdMBQaRDGCeqKIbQ13KAZpxjAt?=
 =?us-ascii?Q?FriKG0giiGDf26yXa9TaMZyi5JVj4bel0NIdQAhWyx5LSVpyfVYDsUQSVGwB?=
 =?us-ascii?Q?+TxhN+FH5mRr9f1tVmYRqzBMCs7UPB0FXofuDZWT4XxGKg0fF5LrES+2jTFP?=
 =?us-ascii?Q?XwjX0HYkt16+2Ph0NoZt/pJkT1EPNYPqw18M5kKZMnyDCKR4JaSnTP9GzoM3?=
 =?us-ascii?Q?a0k+6ZPcdsYFKsI4soSKynbt6gU9cZoDnrdFfNlR1BPLj1wrT/SkoNKGu3ul?=
 =?us-ascii?Q?Dgz7g4YtOCzcqiUJR3l+V62FwaauckXkSOd/nvZW2mfgdoBQMVCfA5zvRaWu?=
 =?us-ascii?Q?SHWDKCbdJ2H49/w4uyLzWvWz3HRG9Z7r8n3y7+0FqYSIJsmyqRoQNDmOTWTh?=
 =?us-ascii?Q?sAjcfKk6Lt8Cm9rLu94T+Jy1bLgqsOTj5bFgIc2KmM8hjestgSt2idwUSOjg?=
 =?us-ascii?Q?q1FKzoxb325GXSESBSlo3eQD+fYU6aBcKGply9IXBdsdOvQdqH+0ueMAZ3kn?=
 =?us-ascii?Q?BBR4oNriCHVVKhAnfwVOMmonAo26xfJqnKKifK5U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a4a490-c797-4a40-6a57-08da705b9fc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 05:40:05.0712 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xeavmIUy3MtmswQuhcn494ba0FUGEBrwZku/ptSwyVT5nmyIXNOtLPLSuNZqWJHskGtyx7pN9ckecGa9Oaz24A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3972
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
Cc: "Gui, Jack" <Jack.Gui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chengming Gui <Jack.Gui@amd.com>=20
Sent: Thursday, July 28, 2022 13:29
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Gui, Jack <Jack.Gui@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: add memory training support for PSP_V13

Add PSP_V13 memory training support funcs.

v2: replace DRM_{DEBUG/ERROR} with dev_{dbg/err}. (Hawking)

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: Ic59f31c95897cc983e1d73335d4b44e159373369
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 159 +++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index 30386d34d0d6..c9821f89eeed 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -20,6 +20,8 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
+#include <linux/dev_printk.h>
+#include <drm/drm_drv.h>
 #include "amdgpu.h"
 #include "amdgpu_psp.h"
 #include "amdgpu_ucode.h"
@@ -58,6 +60,9 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_7_ta.bin");
 #define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3  #define C2PMSG_CMD_SP=
I_UPDATE_FLASH_IMAGE 0x4
=20
+/* memory training timeout define */
+#define MEM_TRAIN_SEND_MSG_TIMEOUT_US	3000000
+
 static int psp_v13_0_init_microcode(struct psp_context *psp)  {
 	struct amdgpu_device *adev =3D psp->adev; @@ -419,6 +424,159 @@ static vo=
id psp_v13_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
 		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_67, value);  }
=20
+static int psp_v13_0_memory_training_send_msg(struct psp_context *psp,=20
+int msg) {
+	int ret;
+	int i;
+	uint32_t data_32;
+	int max_wait;
+	struct amdgpu_device *adev =3D psp->adev;
+
+	data_32 =3D (psp->mem_train_ctx.c2p_train_data_offset >> 20);
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36, data_32);
+	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_35, msg);
+
+	max_wait =3D MEM_TRAIN_SEND_MSG_TIMEOUT_US / adev->usec_timeout;
+	for (i =3D 0; i < max_wait; i++) {
+		ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35)=
,
+				   0x80000000, 0x80000000, false);
+		if (ret =3D=3D 0)
+			break;
+	}
+	if (i < max_wait)
+		ret =3D 0;
+	else
+		ret =3D -ETIME;
+
+	dev_dbg(adev->dev, "training %s %s, cost %d @ %d ms\n",
+		  (msg =3D=3D PSP_BL__DRAM_SHORT_TRAIN) ? "short" : "long",
+		  (ret =3D=3D 0) ? "succeed" : "failed",
+		  i, adev->usec_timeout/1000);
+	return ret;
+}
+
+
+static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t=20
+ops) {
+	struct psp_memory_training_context *ctx =3D &psp->mem_train_ctx;
+	uint32_t *pcache =3D (uint32_t *)ctx->sys_cache;
+	struct amdgpu_device *adev =3D psp->adev;
+	uint32_t p2c_header[4];
+	uint32_t sz;
+	void *buf;
+	int ret, idx;
+
+	if (ctx->init =3D=3D PSP_MEM_TRAIN_NOT_SUPPORT) {
+		dev_dbg(adev->dev, "Memory training is not supported.\n");
+		return 0;
+	} else if (ctx->init !=3D PSP_MEM_TRAIN_INIT_SUCCESS) {
+		dev_err(adev->dev, "Memory training initialization failure.\n");
+		return -EINVAL;
+	}
+
+	if (psp_v13_0_is_sos_alive(psp)) {
+		dev_dbg(adev->dev, "SOS is alive, skip memory training.\n");
+		return 0;
+	}
+
+	amdgpu_device_vram_access(adev, ctx->p2c_train_data_offset, p2c_header, s=
izeof(p2c_header), false);
+	dev_dbg(adev->dev,"sys_cache[%08x,%08x,%08x,%08x] p2c_header[%08x,%08x,%0=
8x,%08x]\n",
+		  pcache[0], pcache[1], pcache[2], pcache[3],
+		  p2c_header[0], p2c_header[1], p2c_header[2], p2c_header[3]);
+
+	if (ops & PSP_MEM_TRAIN_SEND_SHORT_MSG) {
+		dev_dbg(adev->dev, "Short training depends on restore.\n");
+		ops |=3D PSP_MEM_TRAIN_RESTORE;
+	}
+
+	if ((ops & PSP_MEM_TRAIN_RESTORE) &&
+	    pcache[0] !=3D MEM_TRAIN_SYSTEM_SIGNATURE) {
+		dev_dbg(adev->dev, "sys_cache[0] is invalid, restore depends on save.\n"=
);
+		ops |=3D PSP_MEM_TRAIN_SAVE;
+	}
+
+	if (p2c_header[0] =3D=3D MEM_TRAIN_SYSTEM_SIGNATURE &&
+	    !(pcache[0] =3D=3D MEM_TRAIN_SYSTEM_SIGNATURE &&
+	      pcache[3] =3D=3D p2c_header[3])) {
+		dev_dbg(adev->dev, "sys_cache is invalid or out-of-date, need save train=
ing data to sys_cache.\n");
+		ops |=3D PSP_MEM_TRAIN_SAVE;
+	}
+
+	if ((ops & PSP_MEM_TRAIN_SAVE) &&
+	    p2c_header[0] !=3D MEM_TRAIN_SYSTEM_SIGNATURE) {
+		dev_dbg(adev->dev, "p2c_header[0] is invalid, save depends on long train=
ing.\n");
+		ops |=3D PSP_MEM_TRAIN_SEND_LONG_MSG;
+	}
+
+	if (ops & PSP_MEM_TRAIN_SEND_LONG_MSG) {
+		ops &=3D ~PSP_MEM_TRAIN_SEND_SHORT_MSG;
+		ops |=3D PSP_MEM_TRAIN_SAVE;
+	}
+
+	dev_dbg(adev->dev, "Memory training ops:%x.\n", ops);
+
+	if (ops & PSP_MEM_TRAIN_SEND_LONG_MSG) {
+		/*
+		 * Long training will encroach a certain amount on the bottom of VRAM;
+		 * save the content from the bottom of VRAM to system memory
+		 * before training, and restore it after training to avoid
+		 * VRAM corruption.
+		 */
+		sz =3D GDDR6_MEM_TRAINING_ENCROACHED_SIZE;
+
+		if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_base_kaddr) {
+			dev_err(adev->dev, "visible_vram_size %llx or aper_base_kaddr %p is not=
 initialized.\n",
+				  adev->gmc.visible_vram_size,
+				  adev->mman.aper_base_kaddr);
+			return -EINVAL;
+		}
+
+		buf =3D vmalloc(sz);
+		if (!buf) {
+			dev_err(adev->dev, "failed to allocate system memory.\n");
+			return -ENOMEM;
+		}
+
+		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
+			ret =3D psp_v13_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN=
);
+			if (ret) {
+				DRM_ERROR("Send long training msg failed.\n");
+				vfree(buf);
+				drm_dev_exit(idx);
+				return ret;
+			}
+
+			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
+			adev->hdp.funcs->flush_hdp(adev, NULL);
+			vfree(buf);
+			drm_dev_exit(idx);
+		} else {
+			vfree(buf);
+			return -ENODEV;
+		}
+	}
+
+	if (ops & PSP_MEM_TRAIN_SAVE) {
+		amdgpu_device_vram_access(psp->adev, ctx->p2c_train_data_offset, ctx->sy=
s_cache, ctx->train_data_size, false);
+	}
+
+	if (ops & PSP_MEM_TRAIN_RESTORE) {
+		amdgpu_device_vram_access(psp->adev, ctx->c2p_train_data_offset, ctx->sy=
s_cache, ctx->train_data_size, true);
+	}
+
+	if (ops & PSP_MEM_TRAIN_SEND_SHORT_MSG) {
+		ret =3D psp_v13_0_memory_training_send_msg(psp, (amdgpu_force_long_train=
ing > 0) ?
+							 PSP_BL__DRAM_LONG_TRAIN : PSP_BL__DRAM_SHORT_TRAIN);
+		if (ret) {
+			dev_err(adev->dev, "send training msg failed.\n");
+			return ret;
+		}
+	}
+	ctx->training_cnt++;
+	return 0;
+}
+
 static int psp_v13_0_load_usbc_pd_fw(struct psp_context *psp, uint64_t fw_=
pri_mc_addr)  {
 	struct amdgpu_device *adev =3D psp->adev; @@ -567,6 +725,7 @@ static cons=
t struct psp_funcs psp_v13_0_funcs =3D {
 	.ring_destroy =3D psp_v13_0_ring_destroy,
 	.ring_get_wptr =3D psp_v13_0_ring_get_wptr,
 	.ring_set_wptr =3D psp_v13_0_ring_set_wptr,
+	.mem_training =3D psp_v13_0_memory_training,
 	.load_usbc_pd_fw =3D psp_v13_0_load_usbc_pd_fw,
 	.read_usbc_pd_fw =3D psp_v13_0_read_usbc_pd_fw,
 	.update_spirom =3D psp_v13_0_update_spirom,
--
2.37.0
