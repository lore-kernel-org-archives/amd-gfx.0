Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FD4C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 10:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2522223E4
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 10:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2522223E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B67389C61;
	Mon, 11 Jan 2021 10:15:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D0DD89C61
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 10:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzU8xfZYVxAbInzk6kMYnCLXFamh/82L/08ydM78VQqHPGBv15SuQ18P9nOM+l/Q4h4N8UF8PvHknJ2RD64/VauL3+ipcl8CaIvq0pd3jWJ2k9Jod3m65vT40Flw1m+mAMJ64kPy0hfqisVKsVjzGHgcNp+3FMUSiAi8jB2V0kPl/Tr25GZJwKDu527YfvBLRjwpVidBV36OiXgLz8wIhZgaGpPHQHQctzbFq7QKoKHfh6pbzMLtYw/dVI+eYzrJgD1JBBi28DyPSYBgZk7P9FsytHmDrlpJ+i5WTxJmOroTsSoJ+y89MAJhyqyGDfjj7M+RvX7C73Vkio1vEP2iHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKyCfGm6/2ORM1HytiEWCufcfMoLpG3sIjQPmlxhDF4=;
 b=XYHhf9NEvzPQxmPeVZq4LDIuOS57qnszTd34at3eqxEvHFaSkUPTZ8eopO5t4RDQ90uiQDVF8wJLFOcf4HXBLqQcO6kTZC2S6O7JoFNxnTkk0n9rdDBlf1kLOmb+FGsT315+ssQ/hOiryeYVpv2lNS3cR1SvNi45ZaWbJhHaoUcGdmQLsDprDsNnDkkIxjqafxj+7wI8HBw0TOxEKF5zTP/eYFWZpxCI3byAM+pUPw50uqNfWvCNyJphoJYKeTIjGrGqpe8XLJE2ONoMB7zrzRdqd1dKGFztQ5v5kmVCHLa2XDZoZin4jsd6caLqACSjzsAut8L+EKM6sE567ja5dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKyCfGm6/2ORM1HytiEWCufcfMoLpG3sIjQPmlxhDF4=;
 b=yQ8+w5/Rr5bSVSl362cjxlrXeb1CGLPPqAdtUQmW8aul8y+Mrlc5s0xlSGXburvEegOHFv0v/NIgLPY/0ccJ9+wn/DJ0kBqJqFvtB6a6ZXZ46VniQVMzFFD00bJbV2uN/aAYaRDwWfh8yxzBmCOHDgyWAFv56EWDJUlgl8TFT60=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM6PR12MB2873.namprd12.prod.outlook.com (2603:10b6:5:18a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Mon, 11 Jan
 2021 10:15:30 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::4584:6ff5:8f00:aa72]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::4584:6ff5:8f00:aa72%7]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 10:15:30 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable gpu recovery for navy_flounder
Thread-Topic: [PATCH] drm/amdgpu: enable gpu recovery for navy_flounder
Thread-Index: AQHW5/8dehwEaQbeLE6ibN1h9jt0BaoiNMXw
Date: Mon, 11 Jan 2021 10:15:30 +0000
Message-ID: <DM6PR12MB4650F93533A4D958E845A3E2B0AB0@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20210111094938.2764-1-Jiansong.Chen@amd.com>
In-Reply-To: <20210111094938.2764-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-11T10:15:28Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fa93655e-954d-4f54-8960-00000569ddd4;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2021-01-11T10:15:23Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 70e92d6d-039c-48fc-ace4-00003000083a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2021-01-11T10:15:29Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 2434599c-1e80-4ca8-9c02-0000b0278561
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.169.125.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e09ab4c3-fe8f-4923-1c4e-08d8b619d346
x-ms-traffictypediagnostic: DM6PR12MB2873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB28734C12A7205079B3F5471EB0AB0@DM6PR12MB2873.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QqyRIc3ebMjFsSrm3kXapWAvCaaaz/sLtvFM4ktsefHTbfGUawDdxesWk83P8cbMcnVnm4xlBToDj4UDikU2t09NA1PxwrXSCT94DXBTehibL3wzd9ABTwF+Vg83hMCSZ4fh0HJ85kkF79jeBoV4fuio7dHkNnca8hWIqZz05WoJ6OSKgQiVZrtbGdGD4Cs0Sx/D7fFE7hKEaa7+Bf80vKPBO6g5l0U0RtV2vvxZrSbKsrvxfjUrHeAE2xLEgJfmSwzD3cU2TvuW9bSVsBXWevIcXYpCJ6Oqtem/Ze5uLBOpKQFgFApN9UC9fcgApOfSgO6nV/m3/tu+9+5K6lBkhE/6d3v9mK5ueT9d4Y3YJry9OWbFJf2tGq+UtvYBabXTzvBss16noR3QJmNPN/+dOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(76116006)(71200400001)(33656002)(478600001)(53546011)(186003)(55016002)(9686003)(66946007)(66476007)(26005)(64756008)(66446008)(83380400001)(7696005)(66556008)(316002)(2906002)(86362001)(5660300002)(6506007)(110136005)(52536014)(4326008)(8936002)(8676002)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mJlpSMuirZJtx6KqCsIPUZsKruTY5GRIW3MCUs/LhvEc5DBlq2HwmihBEUlh?=
 =?us-ascii?Q?MVvXvMPryPJiXaVkE7ahrPc2QBbfmc4upj+exjr5k5XPU6eV1GR1wmCJwo+b?=
 =?us-ascii?Q?hYyYZ86I8u+1SBvG4G8VlhxmGCMuUbzRRZZxBemtN1BLleT34S2MpYw7BrMJ?=
 =?us-ascii?Q?c/XKhL1xbTLt04hefcv7fvXQkshp9hD2AdNWfzCpEp0Sa3eOr3TUROsJgono?=
 =?us-ascii?Q?GWpwHpStQK+GZqIfeFPu76ygeFtIUQJ3sI/IjTb5cV4CDlXhsthwGRQLzWmi?=
 =?us-ascii?Q?fX+dpQpn132K7yz4ReqlXTnRopC30m1r5fzAtLfCwcNL/JmzldgnkTqvcwF6?=
 =?us-ascii?Q?0ntweLzdWUjLMDh8suG7urK+CZl7erYtv01OV1ysT9NADj9ImTrPfFlal99m?=
 =?us-ascii?Q?sLVICWrKDjIaI1uONek7R6ZV0tiwwAWHf7KMZZ/PyQbSg9DfIV/73YRqvPGY?=
 =?us-ascii?Q?oj1SyJEXK4so9iCGgP2M5w+XsrQfbKCqRtnNgGrEh5fT1Gamxft2D4EK6EYM?=
 =?us-ascii?Q?KGim6nplAZTX7KJxsy9efHz6xVaagYIK+l4/wES6Gr3ha3D+9eKJTAda7fGz?=
 =?us-ascii?Q?UC0klqgHU9FBnVqeTypGKLun+h4Vs7FsB/LfNoq6lRiJT//4IpyGvBUl7oTa?=
 =?us-ascii?Q?iPx+ZKE+XEw+zZxeWocEMeUbBnsIRQuQOuZsQLMea0qZOw9uwjFKp6p9bHoW?=
 =?us-ascii?Q?nUplqueVlj4d9CmncbRAdG6Vd2ev07mLI+psYyHBstC9Ealo9Scltp9Jp/8v?=
 =?us-ascii?Q?qwjkVObWxwaLNyAbyCbJBtf5gkhRWW9Ra/e/M3ajhZfn0JYvQAyR/BBLHKox?=
 =?us-ascii?Q?gdUaLkVPexr45SPRgVlMwwxii01lRmu8jQxjMbsu3m6bdsUPQYuqnSsNFxpw?=
 =?us-ascii?Q?vX5IuSUJPeiF5OCtAqPL/xAMMIOpQ9JOKnn+kpn43Rr1VDQ2Gjyhlt2YRu+z?=
 =?us-ascii?Q?YGniPpxygxofSRopYIZQeZ1onn3UhgRjYfEGTPbN/38=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09ab4c3-fe8f-4923-1c4e-08d8b619d346
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 10:15:30.6900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8BKP/AMACLv2wDClk90tCfFniC6+kalErSbS4Duz4OaFqWodbnMvoR98uaiXXoRP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2873
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
Cc: "Chen, Jiansong \(Simon\)" <Jiansong.Chen@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Jiansong Chen <Jiansong.Chen@amd.com>
> Sent: Monday, January 11, 2021 5:50 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Chen, Jiansong (Simon)
> <Jiansong.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: enable gpu recovery for navy_flounder
> 
> Enable gpu recovery for navy_flounder by default to trigger reset once needed.
> 
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: If213b4c7a5444872ec51869da53a374bf40db7fe
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 087afab67e22..dd67b589b4ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4206,6 +4206,7 @@ bool amdgpu_device_should_recover_gpu(struct
> amdgpu_device *adev)
>  		case CHIP_NAVI14:
>  		case CHIP_NAVI12:
>  		case CHIP_SIENNA_CICHLID:
> +		case CHIP_NAVY_FLOUNDER:
>  			break;
>  		default:
>  			goto disabled;
> --
> 2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
