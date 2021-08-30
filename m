Return-Path: <SRS0=q6mt=NV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3652C432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 02:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 686EF60249
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 02:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 686EF60249
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C63D89D63;
	Mon, 30 Aug 2021 02:54:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E50589D60
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Aug 2021 02:54:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbZ/6hl25Euyg8W6GoEs0XEiKTEjypDqoxYBm8b7BFtg8NLlPGbAE0SVleV40ZAFqCl44x1S8ZPWtEuIJ4avUJa13HWWyXlwgY52idHlJ0l6CAbfBDwy2+QOkHdqvrSK0FpJPhTkjDdsouUISarVImuKQQOOAL+iVZktvDTkfrCixA47NVCslsBwfgAVfU5/caGDEzbRMj5avnlw++iQQdZKj5OUGt9zx6COnqLkrRaZhd8n+UkVijwqaQiLVWo5OsVa+KsEB/u2Q76wMmG7BFyhmCKh7eHCi/ifRvVvZ38Hy4Pz+jiWH3bcMiyBUq6ffMNOyOGLhAIh1KN52oSMBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OV7yfSpOgNtoseCvmzBWF5PfBnvRTcNaj4simCnaHJE=;
 b=L6qbwuGaokS+xGb6g/BztvjAvtmJlHO9w4Y8ek5sE2OLzwvqQrGVnI0uBiO9jpBkq7C8eKZRkUIsg2nUzBDSfHIorne2ldtb3lATEyqZg8Z0dxben2iNhxvsRGr4p7aF9ydJHDvZeUbbqTsevCnzzs2a/mLKKxQa1t21FrKzJr84ig9smJtkK+G2qrsfAPcrIp9Mlasd20EnWSBTsEyvmIk+Xouv3w0kNbPP0Ijwl6R+epLBzqFWYqOTp5JzKJF0cIj23rX8MAyjR6U6fXCUbnLjDIzEfcyKCt8EkG46S0LPcJrGKVeJjW+oLCYnoiixjVglz3YRlN/WaBcwrfTECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OV7yfSpOgNtoseCvmzBWF5PfBnvRTcNaj4simCnaHJE=;
 b=R7ZWUCrVIz+bdSdNgY1qVyizGVsMoymAWCCp2S2+Zp5jSVZ4LHYXh8KlGz7TJJlCaQni5IoTfrXMQUhza2lT5E7zjcivLKdjiUm2oZwZiwS50UCSj9DV6EoBVLO9cBV1omK2iUhZkCqAcK5ABKs/JceZBIkLd4cwoh03Za9E7Ng=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19; Mon, 30 Aug
 2021 02:54:25 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e%3]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 02:54:26 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: consolidate PSP TA unload function
Thread-Topic: [PATCH] drm/amd/amdgpu: consolidate PSP TA unload function
Thread-Index: AQHXmyge8Afac9hvbUCpW9PcCj8JkauLXk3w
Date: Mon, 30 Aug 2021 02:54:26 +0000
Message-ID: <BN9PR12MB52269E27275DB46CA255C8C1FBCB9@BN9PR12MB5226.namprd12.prod.outlook.com>
References: <20210827094343.889-1-candice.li@amd.com>
In-Reply-To: <20210827094343.889-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-30T02:54:24Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a8c5ee8e-7b7e-46b6-8d45-d4f6705ad774;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c28ebc52-6d5e-496e-45a0-08d96b617a99
x-ms-traffictypediagnostic: BN9PR12MB5161:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB51618247F872F73E5C60C853FBCB9@BN9PR12MB5161.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oLo52d8KUNvjgMENmumzzQ7NIUcLmpcxtaZUs2jKyPUZsb6TtJFsyMzLC8OtxqEYafw6I374zfDXnRQk6swAH1+M/m2L+3y/6KYK7nzdS8R4ACjt3GtqD0u4tQggoL/B6LPKVWvNAS/OqbDNFbEHTKSmaLlAI0v+/W+iACCe9o58mstDyXCvuhDEe/UgQwlGHTJEVJWnDIwe5CLabTVKc9RMVTmtto283+65V2MeKqoZt0V8iTGzrzdwQDhd/A/wX17jy8e4QIYMhT4mk4JDdyqmJnYyDDOukT3pL7eDRNaaR1HoodUJHxgXPSIUGFsyUFSXkAE3fQUT2Od85MBV+WXPEEzcMBu7MlfOxqakWjmb1hEZcRuceKiwvYX59ljwfUsc26VqAz+hHnZARqq+2FgAglM559ZnXL9G9Q9x6wR15SeliU3cEtIXVdJ8dD64c5J5c7C+41Ougi8e/cXln9aCX2zTu60NNfegmYzSm7K9tMeUJ9lB0hglI1RZWsuiOTx+iPi9eAehpUvPpDSuwIHgF3fqystMmCMob68x4vPJIu4bFUF/J1cXa9vJGlNbz2DBYKXRQPergNEfZBMt2iG2VS2BCFsKR+cVaITX9X0nH4K5Tw20mg5OVCLQioIyrmYOvXMXxRDDgjrGNfRditWpZE5VR5zZvT/7Ow2xFjxxFAAEAzS6+mHUqxHF+bd49zleTZLwTIm1fXHCNTRrvQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(186003)(76116006)(8936002)(9686003)(2906002)(64756008)(66946007)(66556008)(66476007)(66446008)(26005)(55016002)(8676002)(71200400001)(33656002)(83380400001)(52536014)(86362001)(478600001)(38100700002)(38070700005)(6506007)(122000001)(316002)(53546011)(110136005)(5660300002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eOvUhACsAHb3XjQ6XFWK5Ngj1SR/o8H0DLyTyTFpYghvwiHHG47F/8nSclLo?=
 =?us-ascii?Q?PvdDxpbZz8e04+BCo2Rc/83uyK44S1PJXOSEnTJmwQ6F0wow85IMN7oVYFjK?=
 =?us-ascii?Q?WUE54i+q1bX2xJ+M/QkpOSAoUsdFrZ3zVhDo8eNRQRpcx8jvfaYZhUICRbcA?=
 =?us-ascii?Q?e59DIbbLIPdSnonNkcX++Tx31x9pJwl72uOKDhc/koBLaORSXf0iozCy7g7h?=
 =?us-ascii?Q?uoNDHTh6DxzQSiyQQQstCNXH4HL0lBQRQJZjbUVA1QbgRfgnyoqdCHnf+NWC?=
 =?us-ascii?Q?Tz1qbbZe6oKR02l9gFHqQgQSeVRdPX/enlb60Lv3CVmNxbDJwkIfWQvxKjzn?=
 =?us-ascii?Q?Mhk/cj/QmJGrJqnOc27TFeQNz3Dzcn/nZUFMvuUgE9Ur1IfQV3EWUb6FMEbK?=
 =?us-ascii?Q?QWXkBQSizv0AKQGorIQ8OJQhus/CHE0xeE4LGz4n1253pxuNhuB4ys0cxhYy?=
 =?us-ascii?Q?oTSUVGPs+qgApPC2SwPXwyhRz89KlYzPEprji/gJ/mu2DlfQizSClOWToZSX?=
 =?us-ascii?Q?HmfIglOc6lkuI2FgkWxAO9D0JHFZs4+Tr+iYQiUlugP7eTwpA0llz47zc+/e?=
 =?us-ascii?Q?ufKHxFsDAgCPA1tKUjDRk91RNF5HBydYHMnJoKX1STJYrAweNB7EFjj1AMZp?=
 =?us-ascii?Q?vwftCogQ9ovNfoysmYW7hZb1qE81sRKwua6shvIbuqETY7h31QRej/aC4k6j?=
 =?us-ascii?Q?DJItQWXwLqNRRHZjhTIYWKCAyxg+ovQe7sKwUBttLMiv+iDqS2p5xNno4A/p?=
 =?us-ascii?Q?L3uET30jSJfAZKKtP73tmNXgb3fEW2UlYWp8xXVojl16TZXlc9v4wwuFAMuI?=
 =?us-ascii?Q?kNolIkC1w5u6HT1otLXEiwxOul+52OzGmavRr9TgtXeW957KSKKQeFXunM5a?=
 =?us-ascii?Q?klSJXkxLHLT95Ugtg0he5+Gb1uGpLwzykpbXQGPIzo4O0lb7tbMOUWpAlCHr?=
 =?us-ascii?Q?QfHuRb5gWvOINFL3Dn5d1LgP7Aul8cil15NTac3mUqxq2Jr9361PU5lkQlO5?=
 =?us-ascii?Q?0EvcxMoSkutHoKoNIwZfgm2pFVhqtaUTvSAQbG+BZSafrY8B/f3mp3hr4IFe?=
 =?us-ascii?Q?kMCyRZQ/cuDw/VVnlSIGfkOOQ+guoghkVxCmaTdmCvSQ56mZbrQnsVKoGjXM?=
 =?us-ascii?Q?YDN1CGCGE3Vt0GqfDVdwg6L3Zl2kGgEK0yt5YJM+UoesuyPjTg3V+0M56tIQ?=
 =?us-ascii?Q?X7xWuI8mdhveiI/bmSnvEOnmhmbuGeeWKf/IuT53E3RhjMkEvLikj/ZMlRf2?=
 =?us-ascii?Q?e66fyFi4fa+HwOPCAsCWXI1VkovMOhXmwNPiCQWmWa9RZ4ImOF9qr0iSeaL8?=
 =?us-ascii?Q?yuhVyI3fO8/hfvatiQgqTEdn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28ebc52-6d5e-496e-45a0-08d96b617a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 02:54:26.0997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LI6hGp3w0wil4GjuzaM7w8/bc+SjSzBuldi1fiV99N5TVk1pcCfWZTcb4jAMrkYPoi9HNCOHUhsAt0v9hS2QHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5161
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

[AMD Official Use Only]

Reviewed-by: John Clements <john.clements@amd.com>

-----Original Message-----
From: Li, Candice <Candice.Li@amd.com>=20
Sent: Friday, August 27, 2021 5:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Clements, John <John.Clements@amd.com>; Li, Candice <Candice.Li@amd.com=
>
Subject: [PATCH] drm/amd/amdgpu: consolidate PSP TA unload function

Create common PSP TA unload function and replace all common TA unloading se=
quences.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 160 ++++++------------------
 1 file changed, 40 insertions(+), 120 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 23efdc67250272..243adce6de3654 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -46,6 +46,9 @@ static int psp_sysfs_init(struct amdgpu_device *adev);  s=
tatic void psp_sysfs_fini(struct amdgpu_device *adev);
=20
 static int psp_load_smu_fw(struct psp_context *psp);
+static int psp_ta_unload(struct psp_context *psp, uint32_t session_id);=20
+static int psp_rap_terminate(struct psp_context *psp); static int=20
+psp_securedisplay_terminate(struct psp_context *psp);
=20
 /*
  * Due to DF Cstate management centralized to PMFW, the firmware @@ -829,1=
0 +832,28 @@ static void psp_prep_ta_unload_cmd_buf(struct psp_gfx_cmd_resp=
 *cmd,
 	cmd->cmd.cmd_unload_ta.session_id =3D session_id;  }
=20
+static int psp_ta_unload(struct psp_context *psp, uint32_t session_id)=20
+{
+	int ret;
+	struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);
+
+	psp_prep_ta_unload_cmd_buf(cmd, session_id);
+
+	ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+
+	release_psp_cmd_buf(psp);
+
+	return ret;
+}
+
 static int psp_asd_unload(struct psp_context *psp)
+{
+	return psp_ta_unload(psp, psp->asd_context.session_id); }
+
+static int psp_asd_terminate(struct psp_context *psp)
 {
 	int ret;
-	struct psp_gfx_cmd_resp *cmd;
=20
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
@@ -840,17 +861,11 @@ static int psp_asd_unload(struct psp_context *psp)
 	if (!psp->asd_context.asd_initialized)
 		return 0;
=20
-	cmd =3D acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_unload_cmd_buf(cmd, psp->asd_context.session_id);
+	ret =3D psp_asd_unload(psp);
=20
-	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
-				 psp->fence_buf_mc_addr);
 	if (!ret)
 		psp->asd_context.asd_initialized =3D false;
=20
-	release_psp_cmd_buf(psp);
-
 	return ret;
 }
=20
@@ -990,29 +1005,7 @@ static int psp_xgmi_load(struct psp_context *psp)
=20
 static int psp_xgmi_unload(struct psp_context *psp)  {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd;
-	struct amdgpu_device *adev =3D psp->adev;
-
-	/* XGMI TA unload currently is not supported on Arcturus/Aldebaran A+A */
-	if (adev->asic_type =3D=3D CHIP_ARCTURUS ||
-		(adev->asic_type =3D=3D CHIP_ALDEBARAN && adev->gmc.xgmi.connected_to_cp=
u))
-		return 0;
-
-	/*
-	 * TODO: bypass the unloading in sriov for now
-	 */
-
-	cmd =3D acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_unload_cmd_buf(cmd, psp->xgmi_context.context.session_id);
-
-	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
-				 psp->fence_buf_mc_addr);
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_unload(psp, psp->xgmi_context.context.session_id);
 }
=20
 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id) @@ -1023,=
6 +1016,12 @@ int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_=
id)  int psp_xgmi_terminate(struct psp_context *psp)  {
 	int ret;
+	struct amdgpu_device *adev =3D psp->adev;
+
+	/* XGMI TA unload currently is not supported on Arcturus/Aldebaran A+A */
+	if (adev->asic_type =3D=3D CHIP_ARCTURUS ||
+		(adev->asic_type =3D=3D CHIP_ALDEBARAN && adev->gmc.xgmi.connected_to_cp=
u))
+		return 0;
=20
 	if (!psp->xgmi_context.context.initialized)
 		return 0;
@@ -1337,25 +1336,7 @@ static int psp_ras_load(struct psp_context *psp)
=20
 static int psp_ras_unload(struct psp_context *psp)  {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd;
-
-	/*
-	 * TODO: bypass the unloading in sriov for now
-	 */
-	if (amdgpu_sriov_vf(psp->adev))
-		return 0;
-
-	cmd =3D acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_unload_cmd_buf(cmd, psp->ras_context.context.session_id);
-
-	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
-			psp->fence_buf_mc_addr);
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_unload(psp, psp->ras_context.context.session_id);
 }
=20
 int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id) @@ -1644,2=
4 +1625,7 @@ static int psp_hdcp_initialize(struct psp_context *psp)
=20
 static int psp_hdcp_unload(struct psp_context *psp)  {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd;
-
-	/*
-	 * TODO: bypass the unloading in sriov for now
-	 */
-	if (amdgpu_sriov_vf(psp->adev))
-		return 0;
-
-	cmd =3D acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_unload_cmd_buf(cmd, psp->hdcp_context.context.session_id);
-
-	ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_unload(psp, psp->hdcp_context.context.session_id);
 }
=20
 int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id) @@ -1778,=
24 +1742,7 @@ static int psp_dtm_initialize(struct psp_context *psp)
=20
 static int psp_dtm_unload(struct psp_context *psp)  {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd;
-
-	/*
-	 * TODO: bypass the unloading in sriov for now
-	 */
-	if (amdgpu_sriov_vf(psp->adev))
-		return 0;
-
-	cmd =3D acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_unload_cmd_buf(cmd, psp->dtm_context.context.session_id);
-
-	ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_unload(psp, psp->dtm_context.context.session_id);
 }
=20
 int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id) @@ -1877,1=
6 +1824,7 @@ static int psp_rap_load(struct psp_context *psp)
=20
 static int psp_rap_unload(struct psp_context *psp)  {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_unload_cmd_buf(cmd, psp->rap_context.context.session_id);
-
-	ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_unload(psp, psp->rap_context.context.session_id);
 }
=20
 static int psp_rap_initialize(struct psp_context *psp) @@ -1918,11 +1856,7=
 @@ static int psp_rap_initialize(struct psp_context *psp)
=20
 	ret =3D psp_rap_invoke(psp, TA_CMD_RAP__INITIALIZE, &status);
 	if (ret || status !=3D TA_RAP_STATUS__SUCCESS) {
-		psp_rap_unload(psp);
-
-		psp_ta_free_shared_buf(&psp->rap_context.context.mem_context);
-
-		psp->rap_context.context.initialized =3D false;
+		psp_rap_terminate(psp);
=20
 		dev_warn(psp->adev->dev, "RAP TA initialize fail (%d) status %d.\n",
 			 ret, status);
@@ -2022,16 +1956,7 @@ static int psp_securedisplay_load(struct psp_context=
 *psp)
=20
 static int psp_securedisplay_unload(struct psp_context *psp)  {
-	int ret;
-	struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);
-
-	psp_prep_ta_unload_cmd_buf(cmd, psp->securedisplay_context.context.sessio=
n_id);
-
-	ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
-
-	release_psp_cmd_buf(psp);
-
-	return ret;
+	return psp_ta_unload(psp,=20
+psp->securedisplay_context.context.session_id);
 }
=20
 static int psp_securedisplay_initialize(struct psp_context *psp) @@ -2066,=
12 +1991,7 @@ static int psp_securedisplay_initialize(struct psp_context *p=
sp)
=20
 	ret =3D psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__QUERY_TA)=
;
 	if (ret) {
-		psp_securedisplay_unload(psp);
-
-		psp_ta_free_shared_buf(&psp->securedisplay_context.context.mem_context);
-
-		psp->securedisplay_context.context.initialized =3D false;
-
+		psp_securedisplay_terminate(psp);
 		dev_err(psp->adev->dev, "SECUREDISPLAY TA initialize fail.\n");
 		return -EINVAL;
 	}
@@ -2721,7 +2641,7 @@ static int psp_hw_fini(void *handle)
 		psp_hdcp_terminate(psp);
 	}
=20
-	psp_asd_unload(psp);
+	psp_asd_terminate(psp);
=20
 	psp_tmr_terminate(psp);
 	psp_ring_destroy(psp, PSP_RING_TYPE__KM); @@ -2779,9 +2699,9 @@ static in=
t psp_suspend(void *handle)
 		}
 	}
=20
-	ret =3D psp_asd_unload(psp);
+	ret =3D psp_asd_terminate(psp);
 	if (ret) {
-		DRM_ERROR("Failed to unload asd\n");
+		DRM_ERROR("Failed to terminate asd\n");
 		return ret;
 	}
=20
--
2.17.1
