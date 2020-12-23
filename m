Return-Path: <SRS0=7Usp=F3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF569C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 02:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D802333E
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 02:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D802333E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 599F06E8BF;
	Wed, 23 Dec 2020 02:25:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DF7F6E8BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Dec 2020 02:25:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOIb5lkyeUldJz8j4bNgBVvsdua4+TLlSkRJj1RRclCq30laj+Dm8ntUkxCil2C/UWPgpireuAT2hSVKrpbTmcG7apU/tv2zEiObzuHtV8cX23/Ek06wFyIwjRCcpwPM7W/AvtS+y7ml0lNWg0IRe3tylI6KjK7oZT02VecbyA2w0Ls4Opqcz+UlnxkJnDCjIQ6bCw4Qyw7oZdi5aGR8fmx6H4X0n9iJJcyZQRY7lzn5WsPoLuM3wRr/VdVJDWCTEBRDHCXMr17hDJyqriwy6lNwExhumGc8LaR14la46jcSacuhrQB4wAbbtM/DgeCWisJ1/ogJUFlrtwheMSPoMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btyjJCAl0GyQyie+AUkbpj6RIo9BruhRTocIvx0Riiw=;
 b=LCbNuuGTlfjZwo9jBZfR+8wPgFkOK8jCMhd5Qn3dvIEdNBflQSYkc0PNEhcK94VUvsAQ208w0sNVMvrG+eZ7F20QjpO0+eagiBHr1HaEaAbeHv2Ty6KCN7qYU6I97KesbFp4+IQ+XWynTsHvPdS3NHPJlWnt3dUn+cQUaL5GwAUZqgzzxUDmhBi/wfQrj0l3dc1c83zbKxAVCVMCzL340SZ+B2Y6WHN4NsRfnwY3XyNo6nwrdTK6JyzoU91hHxQHC6/SOU2dknDp8+pSHWMBc1LuTR50+Qgnb4aPgzhcahuXEoEUPAbWX4klcGK6dsLq1uCa6tDLqbmeZqIimr5Brw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btyjJCAl0GyQyie+AUkbpj6RIo9BruhRTocIvx0Riiw=;
 b=kWZg5HubQrV3PBX4nfV4or+vcLC92eKnYcWK2ZqZIsXtdi/1HPszhVk7x7zexeI/aDYM0a+z1sZey/o6ZPsVgUwMhbPj+jkrTeZSZ9iWF952vlYBH3PPWbISpE5GkIAHHj9788m3rVvCepYaJW8xxe/BZHOGCmtKxvkxB0JA8ms=
Received: from MN2PR12MB3549.namprd12.prod.outlook.com (2603:10b6:208:107::17)
 by MN2PR12MB3616.namprd12.prod.outlook.com (2603:10b6:208:cc::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.33; Wed, 23 Dec
 2020 02:25:05 +0000
Received: from MN2PR12MB3549.namprd12.prod.outlook.com
 ([fe80::f1ce:cb7c:334c:97e6]) by MN2PR12MB3549.namprd12.prod.outlook.com
 ([fe80::f1ce:cb7c:334c:97e6%3]) with mapi id 15.20.3676.033; Wed, 23 Dec 2020
 02:25:05 +0000
From: "Jian, Jane" <Jane.Jian@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Sierra Guiza, Alejandro (Alex)"
 <Alex.Sierra@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop psp ih programming for sriov guest on
 navi
Thread-Topic: [PATCH] drm/amdgpu: drop psp ih programming for sriov guest on
 navi
Thread-Index: AQHW2FMYawdR0yq7BUaRzW4jyLWdoaoD9Klg
Date: Wed, 23 Dec 2020 02:25:05 +0000
Message-ID: <MN2PR12MB3549F3ACB6E369404420C884FFDE0@MN2PR12MB3549.namprd12.prod.outlook.com>
References: <20201222111037.31281-1-Hawking.Zhang@amd.com>
In-Reply-To: <20201222111037.31281-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2ff0658b-377b-4bb3-8280-00005370ff28;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-23T02:23:53Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 047f3832-5b02-4d78-b303-08d8a6e9f5d1
x-ms-traffictypediagnostic: MN2PR12MB3616:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3616B91375E4BA081A4C5950FFDE0@MN2PR12MB3616.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5YfVgmNV+nFcOiIiBjdUC/ftkvzyTi+9v8muCXCAWxFfQx+P9XwD7l/e4Lm+gHJG/Z9CDTF6njHrHPb/WaKJDLbO0tCv2U8yEbGmkI6abNBOx3GD2d94Dc0NyjPLLOCCklgTZPGOiy4mGlkf1vk4fAsqwYiBnaWFzB5tSBbToS6oz+tX7kHhIOX/thWe+InAO9LMv54ZD5cJOvauPNm0FfETFFCSC37N8cu90AoYU4Y0nYHqh0hm1d1ljgae6iK8zf+yyoiDNbETmYBA2GBbpbuV+NaV6NTuxAW7TH0oTOLPrVDiLFO+DC78IZSCT6SrCeBTgoml6iEO57jEIB+cuqG91B5lFr8un4sIsJLMlF+DeAQezg4GicMmyZOq8aCgyluEabbbwxK8YFXE6zoRgA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(136003)(396003)(376002)(346002)(366004)(66446008)(186003)(33656002)(8936002)(26005)(52536014)(7696005)(55016002)(53546011)(2906002)(316002)(66556008)(66476007)(110136005)(6636002)(83380400001)(86362001)(64756008)(5660300002)(76116006)(66946007)(8676002)(6506007)(4326008)(9686003)(478600001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9vYbyXNrZ6X3h3RHCZoXNlla/+l+I+su+jabNi/8Xspjoic2gpQvH1cENujP?=
 =?us-ascii?Q?xBTXuZmHtSAQNlCGe7nBfgPQEnvaN/BcwDyd/oPlYBP/E5lrr28P6Z88mFe5?=
 =?us-ascii?Q?qvyBvdtfe3yXKlWgt+FP1VWCPANq1F/AwHMQTvkmPq3CW189e94Q+fV9fA5H?=
 =?us-ascii?Q?2RRLsSANmtACCXVg717O3l9/6sdHMvNUW0EuBptNBW26MT95BJk7zhU4bs3P?=
 =?us-ascii?Q?ne0OCMeyezaEEPt2rfbhiGeDqtKYhOgnTsF/TIwA65kyLdKSANJs31MSnK6V?=
 =?us-ascii?Q?2oLYkXXPwCH4Tx9GAdMrSKybiyLSU6S51pJXfu6hoTgbFDEz0VxLdcj1A19F?=
 =?us-ascii?Q?OMFuKMc7g1lXz+ic76QW+TKh2WfNegssaNy2Et1+ZzW50al/W1VSv+1c91j6?=
 =?us-ascii?Q?mGW4jjDetomuqla68jl8EIEMGUL+QJhEBmk094yINM5H3DCw7FtkQjBYv4qp?=
 =?us-ascii?Q?A/4fPgg7Qdm6TLVBRW1AHrw18ssf/xoEeRGz8ehsyyQnYaxDMy0mqVURcQya?=
 =?us-ascii?Q?iBquisNuf89QRztnWtnsh/yqbYdh9UZ0QjC61B7usb+HZP2wj+Re07jcJOas?=
 =?us-ascii?Q?FDpNCuK79gaoA2xqcGyhYiPLty9P2mKZomsuT20G37aKAxW+t1hXU3UZgEMv?=
 =?us-ascii?Q?9nKiqTQzRyypkSy7ixfbr8F98IlQ9W6q1YTmbphgqCKP0JIgEPBmgPUDP3sT?=
 =?us-ascii?Q?WHeMOF1mLQJjGw/ldZ7T4xvhwZYz+Ma5hnQBvHHJkWKCzCFCHboLbHi4qhqG?=
 =?us-ascii?Q?ghLj0LUEKmLJ+eq6AQQPiwfV4Pp6peY8q+bTUOR0bhCa7qDgpVZDoRtWOv/f?=
 =?us-ascii?Q?3bB692j9hVImY2//ciY8jQRsdlhNPieTX4XckhTkijnL9aRMo7Ch584gShjo?=
 =?us-ascii?Q?4zN+pPxmo2VqIkwKwbmbIXLDgaGdVtEXu+Cd5D2OnSeqJbdin4sngoOxaVqq?=
 =?us-ascii?Q?JmgUNEeiNXy5PwEn4VVja+qGKf/5UHbr2Ox6sBxYLEE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 047f3832-5b02-4d78-b303-08d8a6e9f5d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2020 02:25:05.3677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tA82/Po7D6tm+xsxRdIIf5mpomUbNuPRnjBnCrhDrg5gWh/upx6gZmvAYOh7T2+bYPYuLwG8++kUNiJgdpjgKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3616
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed by Jane Jian <Jane.Jian@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Tuesday, December 22, 2020 7:11 PM
To: amd-gfx@lists.freedesktop.org; Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>; Jian, Jane <Jane.Jian@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: drop psp ih programming for sriov guest on navi

the psp access ih path is not needed in navi

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: Ib68bfb1b13e1cec03ec27bc9a867e2b37fc2fc8a
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 060357625504..f4e4040bbd25 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -151,14 +151,7 @@ static int navi10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 /* enable_intr field is only valid in ring0 */
 if (ih == &adev->irq.ih)
 tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
-if (amdgpu_sriov_vf(adev)) {
-if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
-dev_err(adev->dev, "PSP program IH_RB_CNTL failed!\n");
-return -ETIMEDOUT;
-}
-} else {
-WREG32(ih_regs->ih_rb_cntl, tmp);
-}
+WREG32(ih_regs->ih_rb_cntl, tmp);

 if (enable) {
 ih->enabled = true;
@@ -268,14 +261,7 @@ static int navi10_ih_enable_ring(struct amdgpu_device *adev,
 tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_ENABLE, 0);
 tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE, 1);
 }
-if (amdgpu_sriov_vf(adev)) {
-if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
-dev_err(adev->dev, "PSP program IH_RB_CNTL failed!\n");
-return -ETIMEDOUT;
-}
-} else {
-WREG32(ih_regs->ih_rb_cntl, tmp);
-}
+WREG32(ih_regs->ih_rb_cntl, tmp);

 if (ih == &adev->irq.ih) {
 /* set the ih ring 0 writeback address whether it's enabled or not */
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
