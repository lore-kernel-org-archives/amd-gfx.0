Return-Path: <SRS0=7Ry8=JY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F69C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 10:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E6760C3D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 10:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E6760C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B02A6E03F;
	Tue, 27 Apr 2021 10:11:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B26A66E03F
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 10:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuKMnhPY+Sux8MFnNun2Ib88BheGGwb1gxCwg1rAmqpTXpINvI3sGe4eDqPKqP+rPcmlB6LCSbnd0R5P6RgM6nZZwYp9YOoiJ684dvPQLy5AjhQLFjMtmn8W3R3/ISw2UTLMVNOtTt60CCU78kgQJ7+8l76AhXhM8s1wQNewleUDfZ3HWSwpaTIyhJizEW7jcV8WsUz0Rd7yChJ+AS4i+pcuA8s6RbD6fdbjU8ce/qlJU2OtokTRWL7R4WWuZUA/Uru+SeEV1UldUA6NYtaL7cxhFwuEMSdsAG/sJGY4LI/HASz/CO6sCfYf9M+NPLnBc5Oxks3DD63jS7mHEa1Axg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQyD0V6ngzdRqS6P1m63RaV4cNlbOdxKFXGGaYMdj1U=;
 b=f3aEH41GtZIKV61MjcwsbSAORh1AWkHsOQc8S2UNdtt1qn1RdcJvK4KXkn1r2q6iZlWRORk29UcvWWtehKaWohkM5U4DxVchteUYwpQOq08VOSM49g7DE+hz6bOLmIGlGamUZYGxAQTTc865K+KBNWPienm0w9H3Dx8Z9Z1BNDEGj2LtLmWsPUmQ+XuAohji193W45IOS+c8/D5TC+wlaR37GN6jbah/QOLMBLCKo0dJoqgSsZ6GiBXAMSCz7U7CneEfJu6novLMY1c1xbGok60w8SXHQdP9Bv7GsFvXnuji5+LzLdjTva6LuIYe/0tcHvVKsWnI34md6UUv8rBEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQyD0V6ngzdRqS6P1m63RaV4cNlbOdxKFXGGaYMdj1U=;
 b=I3rdoYPK6MvcTxCrxZMY85wPHjFCil42JpXznXCpExOlhXz9agu81nDqwiBcY/f/5cLJJRjqXYKXMV67omO0jHBqF3NlaDUd2+WBA7f38WkEPg4FR4EZ/caHHwh0AyrTObVsQhxgO3fOk4Erz3c+djSSfgxF7Hd9Kq6ILopqhQU=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB3192.namprd12.prod.outlook.com (2603:10b6:a03:139::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Tue, 27 Apr
 2021 10:11:06 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1c65:648b:7597:388e]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1c65:648b:7597:388e%2]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 10:11:06 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu, Monk"
 <Monk.Liu@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu/sriov disable all ip hw status by default
Thread-Topic: [PATCH] drm/amd/amdgpu/sriov disable all ip hw status by default
Thread-Index: AQHXO0yHHmtlwwcNI0iesizmoalzUqrIJHIA
Date: Tue, 27 Apr 2021 10:11:06 +0000
Message-ID: <BY5PR12MB411588DE87AD1F231E2821A78F419@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210427100303.532655-1-Jack.Zhang1@amd.com>
In-Reply-To: <20210427100303.532655-1-Jack.Zhang1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c7d59557-0f51-4caa-b221-73127fc4d732;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-27T10:10:17Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b492ec0e-0a65-4d78-8742-08d90964c5ac
x-ms-traffictypediagnostic: BYAPR12MB3192:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB31922655609B202F6229BC618F419@BYAPR12MB3192.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EeKEPTTmkazwhK4mpcCvACKgo2NQUgT1wF94ePDcziydSpHa89y1SpF7Dd3bSYZqxP43U5DBzuY/zyJKy9AeUoBbA3fO7pIR6yxBUUdnW+CqqKj+CD1/SZuNqOCCVh9NRA6RpPbwzYH7g62v4pG3Aq/x7pnUC6STs6GJSRtzU8NjIs2Xg8/UZUMXE2DY+rNNvNUyBcOkl9dRhqN5cwUup04BmUqLasQtAaoaKqo0iWd1Zs0xNTW7H/4KuCXxlWyLnkUZSel+U3XDjSkJH8v+bvI8OUVM7kwGskDMc2CWfAp8NuWOiWgqXOtTklSB9Tanvw/n/J7MgeHYrO36xyXf5BOmAV9j8/aQCm0EY93Agq8ev4DiZyZ01CYM3djmqoas5eUc9cr2KBBZ4kxAQZ6Zr28iF/LvPV7fxVXbWLRuVi7WUqRYXkoh5/dpg+HNuNTTU5hNzaUtUdKqtrpr5I8ngOhdeCtUzURfFWXucP+lZmR41v58JTV2apYsNsH6JAqE5FSbr5S3LmVvv+A3Ph8KsmqvKK4Ka990iKftVnaS5qWCuNWkPJa9XLWz8zTQ/ZA2yHJkM4hPAZLgZu8c3GQyVCdtLYTiAk9gJa3faAwcmhk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(9686003)(8676002)(5660300002)(52536014)(8936002)(66476007)(71200400001)(66556008)(64756008)(6636002)(66446008)(66946007)(33656002)(55016002)(316002)(6506007)(76116006)(110136005)(2906002)(86362001)(4326008)(478600001)(83380400001)(7696005)(26005)(186003)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QaMS9ges8e0LecnRSvWUvTtS1paB3iU9dp/XXVH/zKJI6601qBihk0KGkZml?=
 =?us-ascii?Q?sOxccU36lYEJdHZ2lyu9kk4M2NXkD043lPRPbAh4+3/4Ai9iaQHdKYJUBAYJ?=
 =?us-ascii?Q?aIXZie4Agc2kNdyZYlO/r4vEEZNO0O7Nm9NeB25rni/rM9Tgb3ve8F4FuGEd?=
 =?us-ascii?Q?QMUx4KDo2OCbhCJ9PYFo7jZIxkFnnb+FmSzgdaBI/GbapdjTvRJIOcSZFmGa?=
 =?us-ascii?Q?rB/01FjGZ7UICYFDdbs2icykZda+NUmpQG1CmzkX7fz2CeY+Gog2FN0720bP?=
 =?us-ascii?Q?J9ypcYHJv9U190y71jDVU42jnw1m5dwpnJpSI0UXCzhxVmlc7nZqjMKtpa2d?=
 =?us-ascii?Q?xOOI5wP+0Qq5YZqsDDQrmdOYit0+cGL1eCifB15NGmBL5LDBWKgm/Dn3U02p?=
 =?us-ascii?Q?N5607PE/kmIwpFh5f+VIMCmrgDfng3Xom+M12n3lzpIrn+EZRgkmzyTaKgmU?=
 =?us-ascii?Q?KJ5AEvUTsb2vzQQdpQXfFI9lluRGS2iHligZ7YcYsvnNtcn3QKsmveXoLL4L?=
 =?us-ascii?Q?6ZUNjdBVvP0GsQ2LzRFf7+TjiZe8SaFFPBR0zd09OT3h/3sZTcEZuIknPH55?=
 =?us-ascii?Q?p6p1LNLlxBF5z/pYbpwQ4Bc7ZwOEn5DyXhrVJRnzeN83tHmkwTr/ZwICAlwy?=
 =?us-ascii?Q?YJOeBBDgxt7bB8USRJcvR4Es1I0DP1N1a2S6c5otWYVo5WSmuuFlDSe25Wcb?=
 =?us-ascii?Q?Ao81GMAgmp/ivSGfufhK50z6WAlmAH4oaINAhzxcODFjN95dBNTkZHdM8N16?=
 =?us-ascii?Q?Wa/g7Gii+GBMgmqPP7XexXmquwF5DfRwQNBnHZ7r+WzW9sHbM0mBiP3H6wIR?=
 =?us-ascii?Q?rBkzjWnkkjkFxTjhDrGuML0Uhm2aBQcjz13JFLg+QiRtBjZRmr3bcltAZ0cT?=
 =?us-ascii?Q?dOzBp7kIje5wwQKfwOpu16oybbV6MN1ziLxrnuNTcIipoygl6cIR00tLL1Fp?=
 =?us-ascii?Q?/L0zsyrr40JwoWnoor+ptz/LjsaRsVkek7czWynWgMzUgIW+WB0NjK/hw2KW?=
 =?us-ascii?Q?y+2fSMNqRTLRFIp6/Ba5CpBC8iGKlz6j08K+FYNmS8qLmvoHO6twKoI2iwlz?=
 =?us-ascii?Q?cRQbVsOYO3Wc7Q4dpDCzlHFkif4MI2E98jlO04AjyA34GXyveHhpsRcxIGtj?=
 =?us-ascii?Q?4JUfoN62xU3fpfEAVc/ob0lxwyiAhgg/jiqm+Vl9YrbjFoW4bAj1562sPHVc?=
 =?us-ascii?Q?CmTrV6Va36swwLNCfRErmOnQWBTSrQH63wS0B9BmTCq2nVortXb0P/yClI92?=
 =?us-ascii?Q?S+m85fYV6/ejbiwITJYlalbtEVmfzNBIqSNae6JHVNY9AXcT3dq0jKYn/JlH?=
 =?us-ascii?Q?vCNl4KQlaPcWS1R+MSsmJU8A?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b492ec0e-0a65-4d78-8742-08d90964c5ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2021 10:11:06.5014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBwOcgLTL/9j2No6y0f8e1qBENTs6Bg4gIkkvYhFaz95FS/RYb3zV51nS5qK9AUa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3192
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
Cc: "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Review-by: Emily Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: Jack Zhang <Jack.Zhang1@amd.com>
>Sent: Tuesday, April 27, 2021 6:03 PM
>To: amd-gfx@lists.freedesktop.org; Liu, Monk <Monk.Liu@amd.com>; Deng,
>Emily <Emily.Deng@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>
>Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
>Subject: [PATCH] drm/amd/amdgpu/sriov disable all ip hw status by default
>
>Disable all ip's hw status to false before any hw_init.
>Only set it to true until its hw_init is executed.
>
>The old 5.9 branch has this change but somehow the 5.11 kernrel does not
>have this fix.
>
>Without this change, sriov tdr have gfx IB test fail.
>
>Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index eef54b265ffd..5cb171c2273c 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -2843,7 +2843,7 @@ static int
>amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
> AMD_IP_BLOCK_TYPE_IH,
> };
>
>-for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
>+for (i = 0; i < adev->num_ip_blocks; i++) {
> int j;
> struct amdgpu_ip_block *block;
>
>--
>2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
