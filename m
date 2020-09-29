Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE79C4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 06:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AC82083B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 06:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lStcyYEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AC82083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCF9289D2F;
	Tue, 29 Sep 2020 06:38:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B05CF89D2F
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 06:38:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT4/dnvHg2mwRUB/uPVaETCIKK96Cpi8LrKn4rgOrIaUdOQtL2Fz0J+OvEfmrIZmgin+zw5dIbjVDwRHMnTfWSnJqgV0hZxzecr1qEqnCIUchKYfF7BXwASu1SBmZblC2DqHFFrRxmnhwsb2S1WtJKwZKk5WdrsJW26PWpXlMe4Q7EeSPJEDxi+CES4RlntYvgrwNFCWPpQaattbQPv2Y0l6tjeczewiPGcFIRKLxzPj0HvJ65Lu1t203M5RoCej/q2CLt/cD3ZBKxs+b1/QBaRjhZf3z7HOAVkw0uaQdgv+5SDbrGZ4t/aKevju/eowVKxDVIfRDUBE1hVGsaS2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9KR/xvy9DlhiuEAtr2QqLyQBAGfstD0ZP38ddPe8uM=;
 b=oO9shjLEYxgnVwtlMGItf50yIyCO8GzED1nmigvoVMc1H5BmyohrPk3i253bKQYu1WiBDGKRmuT5F3kQhguST6eEdNeiqUXJPIcztehW43eXu/zEy3TLjM7wFe3FPvr1a8rZW/wps2N7PzIWk0zg+GBL1oXcZ3YYFl1JOPz6nSxB9YC5S/2jBBJ4vJg6HCbijU/HMoB1jaUB93sL5AbA8Y24vgdXon6A1nNfvZ8xVbvtuDNeXQc2K3bk2lF5nImnY3tFQh7n5LM5DtPfDhJKoJF2MyChd0HshYYY8DyXQX31V3KmI2MXy2pwt7q1DtjJ/7lvz6KveXlfi5Op7Rg4dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9KR/xvy9DlhiuEAtr2QqLyQBAGfstD0ZP38ddPe8uM=;
 b=lStcyYEwFA9QCXmyqiX3v2LSJmVfPcLeyb2HV1IKc4LyDWlloWlM6pSmWNSImAiBNuBL/yrHgsErFXxsxwzhcVwUv5E53BgCsyi2lXmsukv1WMmBIIzKjNMYxj/Bsk1tDGOdjZNJ1bTsI+VHqGuVXLzsTYHpqFz0LhKhb6bhxBw=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB3543.namprd12.prod.outlook.com (2603:10b6:a03:130::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 06:38:56 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf%4]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 06:38:56 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix incorrect comment
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix incorrect comment
Thread-Index: AQHWlhy9gZ9ZAafnyUqnR4HYeShTT6l/JtEw
Date: Tue, 29 Sep 2020 06:38:56 +0000
Message-ID: <BYAPR12MB28885F66905FE6FEAB03D121B0320@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200929045501.5810-1-guchun.chen@amd.com>
In-Reply-To: <20200929045501.5810-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-29T06:38:40Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=dfbd5551-3aad-407e-a8af-0000d0495852;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-29T06:38:33Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 1d4e3aa6-9be9-47ba-9383-0000d255f487
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-29T06:38:42Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: f3cea247-af3d-4a7f-b66f-0000c1a9215c
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.169.125.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3bfe40f-1ea2-4942-77f2-08d864425730
x-ms-traffictypediagnostic: BYAPR12MB3543:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB35430DEB2FDF6499BB08CF68B0320@BYAPR12MB3543.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5fBgKQcAKS5ZVsUbKDGRq00dgl17hNnb60tdBYoKWYL0agnW1o7JHYBLqiO93yc1ElEqqdphxHaf39KADsFntzr0nGoPz5TLs5HR2M0afsHNpF69OzH6sI0Yv3JwgB2f8QuyKEhPM4+znIGaXXRjzZg5u7+RFqapImx4smvCT4QdFKowkz3WFzY7bnLKVd+1uj9m5bhjfavdTe2FuLvejRgHgSb0GUH1Pr65j6h6YdfcD+q33yW7PUsb0/DZ/BZGw26DT/4SjAnUXYImQ2hLp23YSHMOIYRJmn7+VxwbsnDq6BVFTphYA2kFFpvvLqyPpMX2724Zg005IBM676iBs2cSiDb9jVrwo4dch7bV4oshLp33I3kcoQj9wvmF8k0jWOzdAOaI3JnHO9v8epIKLcglcPFMwmtE88REGXulsQ4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(8936002)(7696005)(66556008)(66446008)(64756008)(66476007)(316002)(76116006)(26005)(186003)(5660300002)(110136005)(83380400001)(66946007)(86362001)(2906002)(8676002)(71200400001)(52536014)(53546011)(6506007)(478600001)(4744005)(55016002)(9686003)(6636002)(33656002)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: zA3KhkLOdY0g16XHbNZMwd4luHwieYE9XEfjLX0McRTT+fh1ih7DAIjuX40X8myQXUAWXiygiAbF+xb1RBOt2jm+nHocZoVeSEOGbJG7IO/XNmVfzaSA2D2J4RKhdNqC3XJeb6jFjQJNMFYrNgiqA1cq7flKCm9ITRxrP4m4T/QHU6YR9xxw93zttB1ctcvK/oNnVO3UxssBPRTUgg0wuvnctqz9Dwe37vHrpWqwOuHFwhe7m8SjnYZEwfihkb0H5FnbLovM6BccDG38q64KBgXXclgWFmfGmIkGBIu1EBWK1hL/btMigNT3qMVYrqRppfpRRXdRHfBO2XhvB2oBVqiBXgdr76K4tbSETMnw88twZsBX3brwY11X6xafUMAONfOF7x8xuyQm7IBm7BoYAfllNhyg9NuBmuR/rs8vGilnQl1uVOvm3lERWZeH105hBlmniGwXeqRDSc3mH/qFwtnmL4lSpH4AsWsxG+1Db3L6znBzOj8GBxIxQC3yd+EI3ZPV/o3krj1MoMwvFLPwFeyYEX/2fUxdbdRZzPvHRSa8iELuLfC9kAhQOzC+GISqbESP9MjxhFVReFnGhQZnvZJIrD/D8zQGEtyTu2p2y6oA7GuJuv6Z35EU5Ta4C++pTyepjSF7ShA038FBT1nlzw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bfe40f-1ea2-4942-77f2-08d864425730
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 06:38:56.3729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zu/omWHGKPaEkLoZI9dPTtQ1tw7g1N2XFeDEYP1KrY6d7wAbkM57qOCQWwX5ErK2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3543
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

[AMD Public Use]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Tuesday, September 29, 2020 12:55 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
> Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;
> Clements, John <John.Clements@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: fix incorrect comment
> 
> It should be one copy-paste typo.
> 
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
> index f29a8611d69b..1308d976d60e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
> @@ -26,4 +26,4 @@
> 
>  int amdgpu_fru_get_product_info(struct amdgpu_device *adev);
> 
> -#endif  // __AMDGPU_PRODINFO_H__
> +#endif  // __AMDGPU_FRU_EEPROM_H__
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
