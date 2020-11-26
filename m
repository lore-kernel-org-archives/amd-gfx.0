Return-Path: <SRS0=2cAG=FA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361ABC56202
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 04:49:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9033D2145D
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 04:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="G0O2PmTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9033D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A62D289736;
	Thu, 26 Nov 2020 04:49:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A008A6E55C
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 04:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCQWBTJ5m6gldk5Trqdb/e6eOsHWp0mx3voi6zYBWI+VoG603DW2N3jdW5/FINCTxJloOMEQjwUv5zwRxJG8voDvq5CSrF3r3LPFkDf8Dx7UA0u9wCJw/UoHyDfnU8NmvaPR+JI2O+BbaP87wC81BqQ00nqYb1Avl8BAzAxtgTChOGU30gQgcXzFSv1xRPOFCe+3lPCw8UB4wuiej2LZzIo/n8SEuIXJ8pkw2Hom2JOJLwBUcYusty+AQDXG1X5ukh42tXeP0t5sqqyJr1OYslx/fhL6dbyE4OLjJiRAZ4vNVR3YSCmDAOB9H4PdinQrrNTQHBvD8hL03hTNJf6YwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWUfnWbkf5l4IkWlXBt0rhq8ofFc1Af8Up0ikzMReBs=;
 b=PfWRdCZxpEkEVfeL4UOBZfuwyAmLyWHwagC1bwx2zop31hlk/SMqaKo6Yo1xCYiDrKHuIlDdINF2gB1smLhO28iTw9jaGdniLKB0dpchIoIkm3TPUTpGorfFBUzF/+8M36cMtJwNN6uG0Nqp2I24mEKspg0gRN4rfk63aAhyM3WX+QB810hsO44fCY5YIYMUTvSQiNqqvWt24sWbKL+WB3UaHrjgzBjNVidyEFXff1qCWFMJqFA66PySZK4zTIMOAmI0GieTC9Nx249UYnatxUGhUKNtaztBcP5blijyJNXMZX/WzpxhgCUpGHmheceYeHL3vULh0xc1rwwL1cLMjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWUfnWbkf5l4IkWlXBt0rhq8ofFc1Af8Up0ikzMReBs=;
 b=G0O2PmTuAlbR4rKCWTQLg6GgZMRLswtAUsZjWQlwyyCvG0bC/AINm+D4bnZOlzelARHvgbe+aNBV3HzJKSquqjOytkV8yWWF18uLCX2iXS/YrePr5aGSoROGl9tD1mTFbbNiHONKtYvd7VGcI8cUjYWq6MgQRqyrNAySgSrh/eY=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB3000.namprd12.prod.outlook.com (2603:10b6:a03:d7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.29; Thu, 26 Nov
 2020 04:49:24 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236%7]) with mapi id 15.20.3611.024; Thu, 26 Nov 2020
 04:49:24 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: update driver if version for navy_flounder
Thread-Topic: [PATCH] drm/amd/pm: update driver if version for navy_flounder
Thread-Index: AQHWw6u2MeibL6WClESlyraFRAnEfqnZ14Kw
Date: Thu, 26 Nov 2020 04:49:23 +0000
Message-ID: <BYAPR12MB28880ABDF5FD563F651FEAF1B0F90@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20201126042156.10883-1-Jiansong.Chen@amd.com>
In-Reply-To: <20201126042156.10883-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-26T04:49:18Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a24aa194-3a1b-48b9-966b-0000fde96fd7;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-26T04:49:03Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a5403778-e721-4052-838b-0000911f13cd
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-26T04:49:21Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 641ad4db-a494-4874-ab42-0000a893fcc8
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.169.125.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d62b218-30b1-4306-e136-08d891c6a597
x-ms-traffictypediagnostic: BYAPR12MB3000:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB30002126A6AF37A287CEDF15B0F90@BYAPR12MB3000.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8w+U895e22P0ree55gEVHn/4yMnRBiFl24qwo1O53VSs22vsTko+p1Kw9S/t9/J3gelbOhnXt5mcDLTZJTsgLnXjXx71St8SwITUE4SlYrKkugroLvtkb0AHjwnbKzo9m9LEBjfgenB4CXEP9pHqka9tOxp97cJ8eD09vVdn04K2q+DcOTrpy0B8WzESgNbCJm6LbaPhT21wv41iH+/QJ20PB4Z5kSsRhwRh0yRbnHhNuzXwC5RHJg6e6opE6IZR9VFOUAZYwNtrULiA6BS28GVX1fjPVR6Bb5oeqIj5kPYDqXwzhpBkPM/tlk6zxdRxanzOZ4u4Ta3NFR421pJI2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(53546011)(15650500001)(55016002)(6506007)(9686003)(33656002)(4326008)(2906002)(316002)(110136005)(26005)(478600001)(83380400001)(186003)(66446008)(64756008)(66556008)(66946007)(5660300002)(66476007)(76116006)(52536014)(71200400001)(8676002)(86362001)(7696005)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EMoxMud6MpoPQ/nOWTgqxojUNsMLf/X96OcrHTs1ZUIZzC5Z7TB5sT3V3b8r?=
 =?us-ascii?Q?rhxDW54y8Ffp7mtxTCXUzFKWraS0eI6SyltkrZdG6kYg0If++NU50LSzmN19?=
 =?us-ascii?Q?xXAPqUCgamO4ddqfONjSuawJDpVI6rt1Lj28Jr6B8tcgy77Iw6BJkA5cz3Pw?=
 =?us-ascii?Q?8jmjkpPNawyNQBIfFbaM7oCSMWPawSWCX6lQ7BJXIGyg1ZtON+HUGddOD/A0?=
 =?us-ascii?Q?NJXuYJErKB/2g/aV6aNynfepv6YruZlTLrvGohoWskteSM1yh1coHVK/MnHC?=
 =?us-ascii?Q?kkskweKN/iZ/NwroaozLFg/GI0G/UtM0Towhg8Ddd8CQ6XSfb9Ac1xfVoq88?=
 =?us-ascii?Q?PdBteZXL5/tCA7YzdYI86DgSPSFRcYwnkDsXz9gPPpWsi8ojVsVGlgUPEAzM?=
 =?us-ascii?Q?s5X4VjxRbyzwGNwfR7SMQrJOZbH7tm5hGsvls6dmdUZump+5bbcc/lhvZLD8?=
 =?us-ascii?Q?q8OrtByyWqlRs7JJ7/DoWrvelVQpu93XcezhYLMSnyLeQ6M3Lvuv2Xesqnif?=
 =?us-ascii?Q?Mmbp6zzfl11is2pShWpcvRON8tlTtLQDbM/0SJ+4HHX8MPPTeGoWYJlsKdNp?=
 =?us-ascii?Q?Boo4tynw+PmPA7x6zmhvgcMVHFH3vFcuyM6IXZ/LxEv4HjoIXasEvYo+FDom?=
 =?us-ascii?Q?fI2PXnUiPOAm2nsiXgl/mU+CF73UAiyOGmDD3jdC8nJ1lyXVZTqhm+owFCbo?=
 =?us-ascii?Q?Mctg98X2LkutvaIokvMVrqaHqbL3AX8bsW8k2nD0S+MVU3qLDk9nl9YzP4Fe?=
 =?us-ascii?Q?45b9w7TWI/T+O/YxT/ShyMs+EMQwfpw3lCOh0RhUbQbehsGqqdwQK6rF0Hl/?=
 =?us-ascii?Q?pTRq7tfBSjuOCWCbNVJW9bEK8f916WLCV46yJFgk0X+SnLGn1tjl8nNSBwMB?=
 =?us-ascii?Q?sof6UxnyIbCrc5m31mD7A2gSOBZ6Luv/W/zX3gSdCCWUOHp/d2VQ4BVZ/HMv?=
 =?us-ascii?Q?fnuuBtlC9DSJsB92PGMaIB7ej+AxzeQOawPt+Qk2B4+bpIeK/DAXUWwcSlxM?=
 =?us-ascii?Q?kTL+?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d62b218-30b1-4306-e136-08d891c6a597
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 04:49:23.9682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8uN5Bx4aqk81Qez6Gyc5eHBbLWdYTv1EcqqiIuKLD6fNbX0n94Hzk1fG+Wp9qvMe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3000
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
Cc: "Chen, Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Jiansong Chen <Jiansong.Chen@amd.com>
> Sent: Thursday, November 26, 2020 12:22 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Jiansong (Simon)
> <Jiansong.Chen@amd.com>
> Subject: [PATCH] drm/amd/pm: update driver if version for navy_flounder
> 
> It's in accordance with pmfw 65.18.0 for navy_flounder.
> 
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: Ia96b6bf276f4a99a931a1203e3314a2ff407e924
> ---
>  drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index eff396c7a281..78eb99962bab 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -31,7 +31,7 @@
>  #define SMU11_DRIVER_IF_VERSION_NV12 0x36  #define
> SMU11_DRIVER_IF_VERSION_NV14 0x36  #define
> SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3B -#define
> SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x5
> +#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xC
>  #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x02  #define
> SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xD
> 
> --
> 2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
