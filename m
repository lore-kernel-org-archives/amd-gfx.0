Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE61C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 02:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD1A023433
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 02:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1A023433
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F05F96E93E;
	Tue,  8 Dec 2020 02:42:59 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760087.outbound.protection.outlook.com [40.107.76.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6547D6E93E
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 02:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcnVxy/oFb4vZpqBL/UJCmnE4Fb6874Mplr/zCer666aoJoChOucq/942IeAHTTTPAg+05IfLEPB6egshhU6l0Is5jN8pc2lMoz/lvR6nPAlEy1CrKdiPpW022N7ay7Pstzd+LuKpnHKWrK/gjAZNj48Km4ParAV8vIpXHkxxQnvaZQvzZ3xaclgH960xPLDwbgPPeHBL2mCXjwE/4zfebhJGQ4REdeWNi6W8cdBN+IvE536gRJwq3XF77tccw0gIgezh1rCLiFEC35lmNrDUAiVurbMG0U/plAQHZCHwWVJDx7ODXaRT0f3vmiEvVVyG+7Ou0O0f5Ck0zdpASUzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7Rbp8Ujq8z9Xs4ULC9EIWGEadGa+RGs1EvN9dDfquw=;
 b=fJ81r8ylvUWypFAomk/t7VnYbk0ZuX2kTfryaaMOZGtubgf2trrfoneRYoyoNI5b7cfr6wruda0Kihzt0PfwgmmCPvhDjZ1K/w/Yzc4b/hdSFLLPTt8I0kG1SNDJ+eQXRGwTutsGfYzLCvVDzLVjg/Ora1QRLRnOKT1yUsWqJ/TiUgYShhlGAzz8MlwTnC6vo2noH96EI2amACytG1s9Kzd3nQVlxqzUNQ6G5n0WxYjVPKK/ORnQ0gLivm8jU3qkPMaP48uaS2RtEfryw+k+MblypfZ550Ln+6t5diyB4/PX2u+Ei0ws8/0xlcqHgv5TsOGXG0SDdz4d4BDAWwKcxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7Rbp8Ujq8z9Xs4ULC9EIWGEadGa+RGs1EvN9dDfquw=;
 b=GB8SAWEn4Bjl+ItpHc8ROIlVBAOtNtpKCDkDpGsA9vUT3KFMCAHJ2THRBj52Rynj5oV7MVn1YQkGq0bGkgC8ECjJ/QUyqoCNdyM0aIIJmrpsQHbZmEmj+iWdm6uOGsJ7pXuiW5SfI//ykZ51XSsBcMk2DUoBaqoAbrVzKfrOEn4=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Tue, 8 Dec
 2020 02:42:57 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 02:42:57 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: fix sdma instance fw version and feature
 version init
Thread-Topic: [PATCH 1/1] drm/amdgpu: fix sdma instance fw version and feature
 version init
Thread-Index: AQHWzGTRmIcaB0S6XEW+Wx9gGTgeHKnsfoSw
Date: Tue, 8 Dec 2020 02:42:57 +0000
Message-ID: <BYAPR12MB288896325BC8D128D18F85BEB0CD0@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20201207064709.31404-1-Stanley.Yang@amd.com>
In-Reply-To: <20201207064709.31404-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-08T02:41:41Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c8f5fb02-45e0-45d4-8941-000004e23fd2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-08T02:42:55Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 9e42208b-9d5a-4c00-9f59-0000915bae47
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.169.125.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba5d657e-03fc-4238-e8de-08d89b22f87e
x-ms-traffictypediagnostic: BY5PR12MB4068:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4068B02EA9F08ECD38686F40B0CD0@BY5PR12MB4068.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:335;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TjMmnlA8y51+AtChCrKlKMbsU7qow4o+gxKPj/3YhhzyqnyvntDZ4V8zaZMCLeQSqZnRD13+oDi/fkUs3HNlhdW5prUqg0aGN42z1sjjYhlcW+jRtnachNRHu3tncA48DbFFVgHE/JXV+GErpl003H9n7ruIjx0xfyhPD6IyHoR7ERi+Ye3Iy9OgmTmqwTLjvi+JOy0ho+Vpbw4VUgkgkTerfce2MlhQIkwBYVWePVZmdztpAMHbZUpdnQidwCD4EL0zk4CWOIJ3OPWhQN6axR9bSud3IYifCbWduhglpo7yz2/wDkRKxwptRUc06q0rbZEeZM5dzmAR2VTOUlO7PClBANfQn2eUoffvKlBSBmA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(55016002)(76116006)(8676002)(33656002)(52536014)(66946007)(66556008)(7696005)(83380400001)(2906002)(110136005)(5660300002)(86362001)(71200400001)(64756008)(45080400002)(478600001)(6506007)(4326008)(8936002)(66446008)(316002)(186003)(966005)(53546011)(66476007)(26005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kqPyvvS3KKE8DZrd2SB7BnCGFnPH++cFMovKLLJZpt/riaOl3h6UvO8Wo4Yn?=
 =?us-ascii?Q?nEPeqKPZpvPVu6L7zLTFMXwnOUCOtnZ9j2qfiHAmcW835Jj4MuwCNRa6Ay09?=
 =?us-ascii?Q?yWUQi9bSr4aRDuKueNb2Dvmr1Ff9JpVR+Xs+ZczkkLu5p8JYHQ++m+W2DO+X?=
 =?us-ascii?Q?pv2TsqQ1d4GJBlKPBSeoTYpv21FJVO9samvIUD+5+Adqt18Nkxjp5IzdxV4P?=
 =?us-ascii?Q?t+Fdi9e4YhTMiYkRHGuzakVqPbLUOBXI/pNc6HoSm4IY6nT8HCErpd/F6wjd?=
 =?us-ascii?Q?aYT4TRxV9H5e9qdRMge+VVNNk/ryQoA1y4hzjLPXftqo+kKgQKgGea0Yig0N?=
 =?us-ascii?Q?0TTy8woUv8fjwcNMxGJwLQSsW1J+4RAfJ6Kjk61o6/7T4/7hREUPu62NGPrw?=
 =?us-ascii?Q?QCxPT9h3+Ygo3Wmh8Lqhe16c5ORJzWZSzf9eDP5/QvRMDtTuxHg78umxQay5?=
 =?us-ascii?Q?CxdZeCQ3bPWIxgVefYlsYWd8zuZVYCyjs4COQu3T+DUGawt9QteGx+TD/i5D?=
 =?us-ascii?Q?ksUmPkXDMLsZx1uIQJgwc8AiWGSyiF639i3NaoFj/EL2TdOD2ixI0PImK1kY?=
 =?us-ascii?Q?ZcktW0MVbs8sB6St+b95XKffRDseMalYx+6QuOzQrcGLulBQE24HC1ffLrXV?=
 =?us-ascii?Q?Vs643f/va79bmDKYe44SUpJ/O3eqNfE2HDylYuX/XWEDOQ9HhF8tGetWsVQK?=
 =?us-ascii?Q?TqDPGQkce3RTAxdXs/vu/2NNNSWScCgg8aFQSfiHzoh1FswpUTbuTfxwI4ih?=
 =?us-ascii?Q?u5YKxaSlDCgQo448JwY/rLUpl6HemCyDRXKPZMqYHicHVkbTPT0277wANIC6?=
 =?us-ascii?Q?FI/LwzQ3ILq5FzZm4U1XH8snJDQgI2G3DOWBUCb5PHuqPbWNonesa7R3/xdU?=
 =?us-ascii?Q?oC3ASJSI1lUNDf5N+YKs79KK9ZG4bI6Y7ro4ux9vNNXwfWc5gmvj5Cen+Rt8?=
 =?us-ascii?Q?L91tZnYUFv6/KirQLOtGCmpIqVIJMT8W2IE3560ZZl8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5d657e-03fc-4238-e8de-08d89b22f87e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 02:42:57.1346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZTZ2kUdQ1gAS781mCE3VA6L/x8aA03mpQrw2BrVEuKC+NIvm+ah/bjLPANlY0Xn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Monday, December 7, 2020 2:47 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH 1/1] drm/amdgpu: fix sdma instance fw version and feature
> version init
> 
> each sdma instance fw_version and feature_version should be set right value
> when asic type isn't between SIENNA_CICHILD and CHIP_DIMGREY_CAVEFISH
> 
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> Change-Id: I1edbf3e0557d771eb4c0b686fa5299a3b5f26e35
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index cb5a6f1437f8..3fca9fc20dc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -197,7 +197,7 @@ static int sdma_v5_2_init_microcode(struct
> amdgpu_device *adev)
>  			if (err)
>  				goto out;
> 
> -			err = sdma_v5_2_init_inst_ctx(&adev-
> >sdma.instance[0]);
> +			err = sdma_v5_2_init_inst_ctx(&adev-
> >sdma.instance[i]);
>  			if (err)
>  				goto out;
>  		}
> --
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fre
> edesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Ctao.zhou1%40amd.com%7Cdfd4ec3683174b0e511
> f08d89a7bf287%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63742
> 9204427689208%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ
> IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=bYQ1Gqd
> lrYjqRwHNnfbMxUbaOt37VIKsbdeGDWcn494%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
