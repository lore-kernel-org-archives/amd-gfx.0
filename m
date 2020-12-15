Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4EEC4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 10:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F6822209
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 10:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F6822209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0759C6E1A3;
	Tue, 15 Dec 2020 10:33:17 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750040.outbound.protection.outlook.com [40.107.75.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BAC76E19B
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 10:33:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNNabVjA4iKiBp8Q7IsvQogLZTCaQmqYY4jolBhKSVoAMTNiVH5dttBv/fPXL9U09WEAHLyno0LSmRo9xNEg+bBKSpQOIlePTQFPWODi42SCfB+WTCOBOYolxe9nKQRxhXRpxj3J88IgBUrd/MCdCc96wmqL29CKOYWMiFVu1CJdzzxlcxvYqVDI4DdGW66iegx4QuItHY9ZvyNEKaE/GStra4ulBnf/a70JCLaFvozNsNljsXwKenyexI+pOhc6JPjxErtzM4cdYCykCfACMl2rSEpzPAEUxG4Z3l3S3vR/d0fzNEQDEy96L8JjDTs+1OTrAxTC1ettstkS7Dg9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB9tcpQmY2lh4sPOGGKgQLIo86mbcTL//BICDqOlI0w=;
 b=BEUiWnnOtVBat1U0sNCX119Ve22C6X+M40E/oKtbRYVqvpoapfxbymn60sGLBwFid3647m2c81+WCoObkCnIApfGIL21e6UbVfUlHAt3ERMnA70xOGdxK5eqdxLxBFOetJxyuhFlO3fSOs6hbpyMfaMjLe4U3mD1DnqL6bCsDmg5Xg05zzq/OSDAXxO84K0F0iSExgjCh8ZQtxXFMzyvWVdbPidMgYUAhfcVn57nGpUbWXUvmRkzgpORwmFSlgIxi/4HbKAZI35CFmpDgIYmquFvGpVoDy1Sc4KbcFxu0xlzeWLIB0/Ok+INpVb7mGS4YYoH9J97ALF8PKEab7zemw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB9tcpQmY2lh4sPOGGKgQLIo86mbcTL//BICDqOlI0w=;
 b=ixuF/ixIWAElA0cY8jbXJKYf+Cmzb9vSCETzygSMmGBR2Yvg5y8h9/TKve2P4BcP/v/ZmVB/3LJso9wuLs02UXpNfnFn0iuA9PavSti7QAi8Wh+GCNRgTaLGvWEprZ5qQcxSttCGQ5TP8PaHwUy+Fes1ILf3MatAuj3BjjvwEUI=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BY5PR12MB3649.namprd12.prod.outlook.com (2603:10b6:a03:1ad::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Tue, 15 Dec
 2020 10:33:08 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::f40a:39e1:ad71:3e6a]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::f40a:39e1:ad71:3e6a%7]) with mapi id 15.20.3632.032; Tue, 15 Dec 2020
 10:33:07 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: set mode1 reset as default for
 dimgrey_cavefish
Thread-Topic: [PATCH] drm/amdgpu: set mode1 reset as default for
 dimgrey_cavefish
Thread-Index: AQHW0sxbmtSg3qIBVkubOTv23U10tqn39bTA
Date: Tue, 15 Dec 2020 10:33:07 +0000
Message-ID: <BY5PR12MB488509A067242B247E2C1906EAC60@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20201215102321.20233-1-tao.zhou1@amd.com>
In-Reply-To: <20201215102321.20233-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4b5a504e-2710-4360-9a7c-e0fd677a34f6;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-15T10:32:56Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b94bc90f-0609-49a9-fbf8-08d8a0e4d03c
x-ms-traffictypediagnostic: BY5PR12MB3649:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3649AEA93E7F00B1FAA2CD11EAC60@BY5PR12MB3649.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MhZ4jFvhFBmI4WUKeVDJPDbg4Un4hmSLvXY6Y3UKwDsGT/DuljqSEKCM6as1qcrWUeYC+CKyl8VBoc47mpUzXw/TEuAg4gZa3XS0oK9lVdfO0RlMm82QUbLBeyIOz+B3qepksxNnG/8CSXQbd15y9bu73e0BRBC+t7HhPZEabLnBq/V3F6xz6Xc6B4mjxty9V31o64MqNB+WdKC9vDxNcrbYn+QhuaTbcYG/hasMP8sIJRQHogdolGnjvqIox2B7dv2c1aul6cdhB+lndF2lLElnYq2aRAnQKOnZ5yMSJKFHEt30UnNZIJ++YxpCyisN+LCqm2dtrdQV1ReotIzvLg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(4744005)(66556008)(83380400001)(64756008)(26005)(508600001)(55016002)(76116006)(6506007)(66446008)(66946007)(8936002)(33656002)(7696005)(71200400001)(8676002)(110136005)(66476007)(52536014)(186003)(5660300002)(9686003)(86362001)(2906002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jrYzQIeBRwUYt4alpt/nVTeznHKDg47DrK5fcrArge2lq9i/YcPCrphZixAJ?=
 =?us-ascii?Q?4+L6cxPqDX+B5gzk1pz/hrZfwYy19yfsCQGFbo+KbdXcUckjVZyqQEa3MhWT?=
 =?us-ascii?Q?0P+VJz4DooxW2/pGA5cdQlA7Hd2hJDoonDC9PjoJp6IGkx7bfW5epzM3epfl?=
 =?us-ascii?Q?zDYn/hGNgaOYVYf7UtJPtgWKf2IU+up4w5FTrNZXuaLjD0Oqqyl4GJAJ0K2J?=
 =?us-ascii?Q?+VER15Dn8XyCCMaC58+qRD1aEORUPuiHi6Blq3UtEWnWecgKwLNVpgqNMXrM?=
 =?us-ascii?Q?EJfL7nI0cpyqA539SBxcarmGHpfp/DaSNPnkrbzaVOvaFkjitX1f5sTINGFY?=
 =?us-ascii?Q?F2b0zHOzAYyhe93qplPrsgi/5ASI5FHGQcuQKtNXKGSrjB5gj8igZlD0ucdD?=
 =?us-ascii?Q?i6P89V3yLzoo7gE485Xo8pjcpH+EouSVGvG1EjGNxqK5i3wH58P+hYO3U0qa?=
 =?us-ascii?Q?muy4bf+MXpiKMVgHUPAeXAIPOkxv4hON1rQHFATdJzOkX8wn73zcs4NhgBmG?=
 =?us-ascii?Q?03reVcT8G7RtsUgD8qvu5h6bK3o2Uh3XcOc4DKoQ3XsvcjGAkI9cfrctXag4?=
 =?us-ascii?Q?F1eKUMTLmefB6XmWxq7gKGNBsvsyx3Nx3HQh9SvUz10nNwyoIfzxfJP2TVTl?=
 =?us-ascii?Q?GSgYWMYxswug7mVKAs1qQJ9+WgWWCz3Uzmy5FIMkjh03M4XhY3CveKZ8rcR9?=
 =?us-ascii?Q?cc4JI1jmmHn5y4CJidklQejWcpj1IY+v6mKTSmsPeCO4pkq4EEEi1pw6VpfW?=
 =?us-ascii?Q?9OfYZKZXQpFWWgtS2HzUvjgHdGyOG6E1hMnPFYe9R59nv+ogwNdgalKF8z6L?=
 =?us-ascii?Q?iGpD0olzQgHuff9K+NJhUVLiESD8qjwuCluqMrPc45epv4W2uYf0cXuogANk?=
 =?us-ascii?Q?Mt0JEO/9FMEgnaAkWv74rSjy6g2Fb7xIAZ+VAjc5sd9OlKWi3g9ri+mYo4wF?=
 =?us-ascii?Q?ienq/Zrj+Z2GkIJ4iGPn0rTs5bujJipI52lc9a7oBLw=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94bc90f-0609-49a9-fbf8-08d8a0e4d03c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 10:33:07.7250 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /tFlaqMmw/JJLBcoQCPxqamIaWnsI7Hvid1V/oRJFjSJWhuMiZI0CmDY5X7h6hXGOyihigNeIrR3jey1f8ThGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3649
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, December 15, 2020 6:23 PM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: set mode1 reset as default for dimgrey_cavefish

Use mode1 reset for dimgrey_cavefish by default.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index ac02dd707c44..6bee3677394a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -362,6 +362,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 switch (adev->asic_type) {
 case CHIP_SIENNA_CICHLID:
 case CHIP_NAVY_FLOUNDER:
+case CHIP_DIMGREY_CAVEFISH:
 return AMD_RESET_METHOD_MODE1;
 default:
 if (smu_baco_is_support(smu))
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
