Return-Path: <SRS0=0XED=GC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF00EC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 12:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B2622209
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 12:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B2622209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1A5F89624;
	Wed, 30 Dec 2020 12:32:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA0B889624
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Dec 2020 12:32:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0lr9CDUGEbcl39bU+hXoab0CCqnDrMZRzfu3ZsXuFaB8z16JIu4RZJd5qhj09iwVSRC0up8VLfdCiaUJyGcAU5ca8hmfiy4y9P9WOO1dEtSVpM3OY/QT0vELhryT+MLRr4l6CVBAXmOaI2Xure03fUA1/9dB2fxRPGBYqpMVsH9jf5u8rAYjAKyPfRqOzXgKaFcqB45siJklCJ2EcNKTHXGe5IdJCxeduZchqADdMK/l+xONUnMnfWvsIfq/wliLOj/sp2UN4Nqes7RxrunSwimqGIRFQvpt3EDKtuP2QtG0op00UWfjunaYkivBH2aaYpGu+3hHygO+m8dlPQvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Npl0KzMC0tGesFw+B3PyfktJH9Hc/xGLvz3DQHyWefI=;
 b=Eu2q1rJtwCnh61c9SEZN+6UG34jCjDT0GXng5gWNdAHkDC4HoyOYixR9pUxLQSnEDfyQQGYLnaSrLCb8prKfoVBWCcg/lCEh0yLSfTP5Sk8XmxTlB1K+9PD8l+QoWKERPHi7ckyGJVX6ASvfGj6FsNPjdSLGUkTFcWZ3G1nWoeFiZGSygT+ZBrrQEnIG9ksaN3QgnIhQHprkULHyrALDnJnXTy1Lsn5LyUTze8p5P4uObGX3U2yQuhrLocl2t63+wu168fjskOX5CaTS7XtPWkbAWTU8Cg8CsnWFbjtE/Mw6581MDlRyLhkEh7rWtaZKYZKN4feHVrVXKvu0XzkzCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Npl0KzMC0tGesFw+B3PyfktJH9Hc/xGLvz3DQHyWefI=;
 b=FVsGEYaMOdnFlDirA9lZlrJotEVZVEByxJzU6PzE+sGm9h8J29cybW6eRa2YxYtHXY28Q9gLKk/qhm417/cU8YtRztfcIQ2nQ4tWIOfPTVbu+xUIBXlRlsNHMjQ3uVQHphrRJ3bEdntUv6sczB5ptRaNCzNz6iitmHYNTU/DKT4=
Received: from MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 by BL0PR12MB4609.namprd12.prod.outlook.com (2603:10b6:208:8d::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Wed, 30 Dec
 2020 12:32:35 +0000
Received: from MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::f822:c87:931c:7297]) by MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::f822:c87:931c:7297%6]) with mapi id 15.20.3721.019; Wed, 30 Dec 2020
 12:32:35 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove unnecessary asic check for sdma5.2
Thread-Topic: [PATCH] drm/amdgpu: remove unnecessary asic check for sdma5.2
Thread-Index: AQHW3qH0UpMMscCD4UOMLSrVgDdOpKoPkkew
Date: Wed, 30 Dec 2020 12:32:35 +0000
Message-ID: <MN2PR12MB4078FF13FC082F3ABDCE906FFCD70@MN2PR12MB4078.namprd12.prod.outlook.com>
References: <20201230114953.2803-1-Jiansong.Chen@amd.com>
In-Reply-To: <20201230114953.2803-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-30T12:32:33Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=66b62d3b-e8dc-4fd6-a40e-f75cd685d671;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6f450d1-e681-4c0d-da69-08d8acbefc7b
x-ms-traffictypediagnostic: BL0PR12MB4609:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4609FB06336739F50E9D8856FCD70@BL0PR12MB4609.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:147;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qjD5n57T53UYTloF6L2Tu67W43duIBfJtIr2y8o93db4mmn84PLCIcNsuMoYQlcblksLBdb5OF06uuCpIzW7DYCbI77nGc5q+i8EO9WYX+oCWGvdxCNyBwfE2pdRIRYPvsYpaYt1egVvg06GemwvOuFgCNyrOsFQ9ImtUCdh/dyMHDWZIi4e0iOgFgbD9CzDIEDB0SBJVln9TcttogNdmV4mTKNokhDjJXnBFPp/pmh48kF4TXxoDRL1VLeBDklcU2IC0ytOC1em9oO8vDG6iMXREZR8sgT1QlrAwNo8FXk+8p5Us5GY/j0qFx+sVeDCGeZi5uFB9d1SpDT8ykmnfnbipPVtJccJ3ooRDUMUjFvnyCukY/vQze7F43cMprC7E6shZWQxM1y/bixxh0nc4P2LILrG/Yo6zj2g5Ms3idg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4078.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(8936002)(26005)(53546011)(6506007)(55016002)(186003)(83380400001)(9686003)(86362001)(5660300002)(54906003)(7696005)(966005)(478600001)(2906002)(71200400001)(45080400002)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(8676002)(4326008)(110136005)(33656002)(316002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GPV8qKPk5jTkf8OLWOzoP1BCbbBAGRzldLYQFJnBbNhi79Cii99/lJ06XeiZ?=
 =?us-ascii?Q?teQXQjssN8yZ+NGa6t/8Rbe3CVrto+XjeFKkJmSNbxlVPiqpodX72CZgnDvV?=
 =?us-ascii?Q?sRU41pLmZJeuczWmkcUSbSBqewQQF3PLbfCOK7G2PaOuYChS3L4GHD6v7XNJ?=
 =?us-ascii?Q?PPsDzIMhIe4Qs/iK4mWFdjoXt3haXOOMXUABnBMEkQuNvfNy9kqNWdvHuAJ9?=
 =?us-ascii?Q?bJnn7GCLMXPv8oZgggAlNB7CPqF381Ji2brUEAxWKDqmX/sKtOj+tS1vqBe+?=
 =?us-ascii?Q?xPUuyaVlxOZrIgqZ4A7eOD9SePQqPdtZbzhnZaO+0nlvZdKzLAYJs9LFsqJU?=
 =?us-ascii?Q?oxtef9HysPJQuMdgWKxHVnYq4WUMwzqK2jPAT2hZZUF+eHZYjCCT8iX2YsDb?=
 =?us-ascii?Q?QkJdf+YRe08ugDS4ycDjd9B4cOKu+c5pOhBCVp4s1WbcNHoBtzi96tMRfULG?=
 =?us-ascii?Q?UarKj/E5m4mDuGw62fFgqlxRMckEJb+H3wxe76DyAwtN6uoZp5IOrC0sBk94?=
 =?us-ascii?Q?KIKA+dbLSafAq8j3nL7hkEgS81cdJlIYA2erXyVP955WKrHyq5twswfTZoTW?=
 =?us-ascii?Q?/h88v0gdC9ZzI8l8BLoEnCye3luxBPqZnwqqovMtw3FzfrIW1XlrjwTxLwaO?=
 =?us-ascii?Q?ZSFgxiSDbSXgJx+1z2Dss8mJ8YoNl/no5bbTjx3VDZn7uWXe+WD09aVywAMr?=
 =?us-ascii?Q?k7ClACPhNuxTLBx9fkepgfe1HrMH0e7yRSDq0D1FQ7+LR3+MI6DYk/fBXggr?=
 =?us-ascii?Q?sexWisM1zxxxKQsrMYDG4vvQ2L3sWV77Q/8uH6UnpPcJyhp66YB0pZotkhDf?=
 =?us-ascii?Q?vVB1+z8sGY33urrtILVi9Zj8ojp/QZOESmVQGv7CZSBaV2m0dA65in98XWsw?=
 =?us-ascii?Q?ymBoy/GlG48wZNvG9ANbcTtM9pYXIOapHRJB7bXbJAD+V0VLtpFInNCSji6H?=
 =?us-ascii?Q?FqtQ2//9PF8LwCj41AIpimxwdpahGfO6JS8NzzixiV4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4078.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f450d1-e681-4c0d-da69-08d8acbefc7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2020 12:32:35.1788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MllTXpzQwC9eDfWhVjeYFTSXFFN9kn1kmUSwO+fEvjsHpA7veV2dAHI/RzcQAavLfTg27XNs7QlsW49KQk/6Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4609
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Good catch.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jiansong Chen
Sent: Wednesday, December 30, 2020 19:50
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: remove unnecessary asic check for sdma5.2

For sdma5.2, all sdma instances will share the same fw, remove unnecessary asic check to be more generic.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I8b67dd588de9e7d54618404092a77b768bf0ddbd
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 31 +++++---------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index f1ba36a094da..690a5090475a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -119,15 +119,7 @@ static int sdma_v5_2_init_inst_ctx(struct amdgpu_sdma_instance *sdma_inst)
 
 static void sdma_v5_2_destroy_inst_ctx(struct amdgpu_device *adev)  {
-	int i;
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		release_firmware(adev->sdma.instance[i].fw);
-		adev->sdma.instance[i].fw = NULL;
-
-		if (adev->asic_type == CHIP_SIENNA_CICHLID)
-			break;
-	}
+	release_firmware(adev->sdma.instance[0].fw);
 
 	memset((void *)adev->sdma.instance, 0,
 	       sizeof(struct amdgpu_sdma_instance) * AMDGPU_MAX_SDMA_INSTANCES); @@ -185,23 +177,10 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	if (err)
 		goto out;
 
-	for (i = 1; i < adev->sdma.num_instances; i++) {
-		if (adev->asic_type >= CHIP_SIENNA_CICHLID &&
-		    adev->asic_type <= CHIP_DIMGREY_CAVEFISH) {
-			memcpy((void *)&adev->sdma.instance[i],
-			       (void *)&adev->sdma.instance[0],
-			       sizeof(struct amdgpu_sdma_instance));
-		} else {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma%d.bin", chip_name, i);
-			err = request_firmware(&adev->sdma.instance[i].fw, fw_name, adev->dev);
-			if (err)
-				goto out;
-
-			err = sdma_v5_2_init_inst_ctx(&adev->sdma.instance[i]);
-			if (err)
-				goto out;
-		}
-	}
+	for (i = 1; i < adev->sdma.num_instances; i++)
+		memcpy((void *)&adev->sdma.instance[i],
+		       (void *)&adev->sdma.instance[0],
+		       sizeof(struct amdgpu_sdma_instance));
 
 	DRM_DEBUG("psp_load == '%s'\n",
 		  adev->firmware.load_type == AMDGPU_FW_LOAD_PSP ? "true" : "false");
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7Cfa8f0b431d804e0f321208d8acb915bf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637449258234210202%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=f57UsHkP1YnzX%2Bs%2BdNqROdyAm0LRNmyYfAFSONLr8Bs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
