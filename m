Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2E4C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 03:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE5A206DA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 03:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zmmizWpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE5A206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6B6B89D53;
	Tue, 18 Aug 2020 03:14:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 091FD89D53
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 03:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMoohXxmvAw0811g1L3L2ycQXl8Jrf0Y7WQBAz2MvJffBHHPo5OtYOWTme74u7Pl7DC93lKSdpjCL9Urvhcal0B7eK7uN2NLwPD3YSoTqdYgKmGf1kwAXzJl31kVDBKUuVs3dHG1Dt3qTZ+WG3rYMrYbWvaVf4EEflWAvLQTPLs1GSHvWMfZ1GlOoPWBK78KWVmpbG6vUI11bL8N8yJl3fpV+9Uy1TMg9DEae55XRweD6WIVdYlgqUCkWZRM2PXExI2NQtSu7BcU130vrkHTkDgR7jTQchxy33Oyyz5JL+bPbJ0hzu+5P4Uc3FIHvn0MkRUGDLGTb7Y3MY9SY2MUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeGRy14r4kwRE8utFbI2GPgd2Q9k9r3FbD2uj1vzl0k=;
 b=n6dDsPjwjpziioLqqFieyOjqHEDlT6HMj2CRIPf16k/flXKkX/nw9ZhhGokpJOShl9m1Xx8CzJEtFLsIhf2d62zdCNkLUty2qkS0B1zoOXqr1xOS/HlbCkw80OLorU992LTvjlrrDxK8pi2m9FIlwiwpgx53arkWfQcHBEptkh0A6G64GXMCiI82MV+T+ZCIqgesZoycLK43mDAeVBWQEQTO6RX0riAq5aXnEmm7WdtXSksTRREYvpiPp/AZk5MzdYHBCraGRKyNdtmYD4E6csKiOyGjUpSOiX5N7xL5yXmo3qvNMKdyQA1kElYVaa4Kl0BnHO0JppFM2MqmXMmjfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeGRy14r4kwRE8utFbI2GPgd2Q9k9r3FbD2uj1vzl0k=;
 b=zmmizWppUKSSuBE0lWnRf9sVfT1fAy7qm4hAwlPFhqMU1lUg4t1a/SxUCmVn1RseQVveFn/0+IuRewD3aa6di8hS7leMsY/ihXeKR/IIrrFMwiZ/EaAhB5X3nxind89rLgdHDkE9i8YfJF/vcLiBpLQiHPWsmPSHu6lflhsRGKM=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB3622.namprd12.prod.outlook.com (2603:10b6:a03:d9::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 18 Aug
 2020 03:14:21 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf%4]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 03:14:21 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: update driver if version for navy_flounder
Thread-Topic: [PATCH] drm/amd/pm: update driver if version for navy_flounder
Thread-Index: AQHWdQvTYVH+7IQGhk2S6wfQxJQFNqk9MP3g
Date: Tue, 18 Aug 2020 03:14:21 +0000
Message-ID: <BYAPR12MB28883967B24BA407E776F6EAB05C0@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200818030041.3790-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200818030041.3790-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-18T03:14:09Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8425a771-fe79-4276-8ee4-00004bd1f880;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-18T03:13:39Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 788e5a0a-8e2f-49ed-8c1f-0000fa4a011c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-18T03:14:15Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: cb4aec4d-b71c-40cc-8933-00008159bcd9
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 724abc2f-3de7-4083-1a1a-08d84324cd55
x-ms-traffictypediagnostic: BYAPR12MB3622:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB362296FDD3F40AFE8F37BAB6B05C0@BYAPR12MB3622.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gcxqnWM9IKaS/JM0M1MX6YDioTtOmYkv246EHHb1kXy2c/2DWud2gMQk5wBT6A8d04/r7PY5wN413JZwzXv0imY0Jx2uAUVyF/70i+tp05wFyyr4rlig5LO3H1la816pBohCpBwIlzEK61Cm2//Tm5WydARyGM3xnKtc6IV7C6uHmn74SA+RkMeEukozyAERKiUBxdpljwx7An83hWGfN+yHUvnxTFTH6JH96N+n58Y44ldoQ0zOKiL8Q9HgrGnEA4MWaGC/4Pk+5/HR90nlKNEFnj3u1YYRdMlNLtJu2YV7L+QP3ukbYCyu//YE/vOK3AEytoVXu6KkEM/7GYhnRw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(316002)(15650500001)(110136005)(53546011)(83380400001)(6506007)(54906003)(5660300002)(26005)(7696005)(186003)(86362001)(66476007)(66556008)(478600001)(76116006)(66946007)(66446008)(71200400001)(9686003)(8936002)(33656002)(52536014)(2906002)(55016002)(64756008)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: GZlNS6GHQKpGLtkw//ka9oJHylpeocnFPEGufHSxw7v6mSw639B0iSK6TSZsjDtjxn5r5+IrygsyHStrFQ7g8ktssyZGDQH3PwcDFYjDX54/K02QohT3B+6sYhbpGGM3yPz8iNfeN955vBSbpQTr1LIumUZB0yGKuTr0YxxCPd0bYNQf7WXTPLHDCe4OImQprgJPjhoLWRalEBv3rMGUDSKDcmhWQUOz5kr/3XwukhNeOPXpsQvqcJTrZ9g8/ZzYH9g12cPIPVsYbgRhBoyTfeVw1ICxEvs3jtIJF8KNK7BNbrn9EewFQ9Kjxeldxk5Mhp25NGzLly+PFoV08ktWIDjJbtvq7XDutDZq3Sdbt4OadUFLMwExJzSStzsgfxyB5N1UkqQy6b88BtFnCEXnAmG7fX6wQ0iopasOy9NwaQ30Bcjri4bIOauec/eroocDd4JZthv/TZyrfZC3gIWiYpZsSJ534Wq0aOX+G3OWm79Jk6ISjGNAmWsTrjLDrmBjGCnPgb+ZlWvdkOtr266xdA12rWQA5BR/Gts0PogwWpfy9BPvARz8iTSoE2DaxOo7t9wHqMoM2c8KDCGS2E6fYgLAvTJQ+3f2xpaJ9kCt+Q2o44j+4Z0PMKg8O3RTZSA+VPRHZbmcI12q2/omRraDHA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724abc2f-3de7-4083-1a1a-08d84324cd55
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 03:14:21.3256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eYTHscvELs7QQSWlvO+tcJVbRzjacnEadU3zKHHcOu+oBBD2oal7Ts/0BKPlzqEf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3622
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Jiansong Chen <Jiansong.Chen@amd.com>
> Sent: Tuesday, August 18, 2020 11:01 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
> Subject: [PATCH] drm/amd/pm: update driver if version for navy_flounder
> 
> It's in accordance with pmfw 65.7.0 for navy_flounder.
> 
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: Iaac4c591f92c9a00891a29757d142c0109dcd676
> ---
>  drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index 65363d56e3cc..77d0996f4ec2 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -31,7 +31,7 @@
>  #define SMU11_DRIVER_IF_VERSION_NV12 0x36  #define
> SMU11_DRIVER_IF_VERSION_NV14 0x36  #define
> SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x35 -#define
> SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x3
> +#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x4
> 
>  /* MP Apertures */
>  #define MP0_Public			0x03800000
> --
> 2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
