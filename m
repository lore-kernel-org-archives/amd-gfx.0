Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D50C433E3
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 09:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994CF20866
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 09:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TMOqlbl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994CF20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5104E6E0F4;
	Wed, 26 Aug 2020 09:28:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22D2B6E0F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 09:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUaPD09Jrily574cDpmB8C3ipo5GyhXmf018v1w+LOE65c7m/Tqf9jEhHSxJF1Oelhop8TEZoOwYRs0YeCtbToVX+yZygAQC4+MLawixsDJ0RPuhlsz2H/RZaBdFOmDvtktGLWAThJM6vW+YiS+T6Yb6PxhkcOMGXYSx0BaK30eruJtmnis0X2LDA7zMljFkYaihTMXtmaNPg+p03e4G+LB3adnTDp5mFJFsTDL9OBQTuz75PT67dppMzPotgT+B7ff0s5zOFqp1lZWAMHbKDIvlpDyjCbzH2YtiRuPTrUG0n61Xgngz7qcCmzFDQmasCrjRnPeTItpGJ+kYw3dJ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJyzFt9WYKoo14P+fSoYCsi9DoYiklCIE1IqMQdIa0I=;
 b=g8JJFtLgVtUGJkovjZhYOst5TLHR/4bqDBx7rMVMTQt8GwtkqZLqYMXpwExbmaMp9jybFXj8RKHctTZjfhBvAPijQMGUFfBE9G+wNpL9YPf0Y+I66Wf+w1Q4uSMm8pTUgf2b/dVCP8oHgofEygR4lKWQhDzAx7Uov2+nZuJlzN9hTB0EzclWdbJC/YEnk6idfB0Ugdp8BVXxNIeReA3u9778kwYMaR3D1Jvikt53sBIUPV3TdLZyhLLY83Lwp3mxGtkpL9r5b7fBnlxJmKG5EZ91TDVNA0A1RFa6KboRW0OB7A6dMjFlshanJb+cW3YfhWDBsdOKYv4vLBKMCG59DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJyzFt9WYKoo14P+fSoYCsi9DoYiklCIE1IqMQdIa0I=;
 b=TMOqlbl7sRirlYmq0vz5fFKZ5AHPIF7tZoVYid0GzZUq2OABqRSdxj0hsJb7Q01JvWeR+iXAxKH41HTt08OdBAJ1OcJ27vF6Q/vTDxLKKU7+O4mbTIBwTBtdGUvMhOMLDK21JpjFHHJRJm3PTRgIUvRI6JiAFZ5xwPRXdO7SNhc=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB2759.namprd12.prod.outlook.com (2603:10b6:a03:61::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Wed, 26 Aug
 2020 09:27:57 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf%4]) with mapi id 15.20.3305.031; Wed, 26 Aug 2020
 09:27:57 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: disable runtime pm for navy_flounder
Thread-Topic: [PATCH] drm/amdgpu: disable runtime pm for navy_flounder
Thread-Index: AQHWe37UVAm35dUsIUOJ10z0OZpKTalKHyuQ
Date: Wed, 26 Aug 2020 09:27:57 +0000
Message-ID: <BYAPR12MB28888FA02FBACB99BA0CCDB0B0540@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200826075917.2598-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200826075917.2598-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-26T09:27:46Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6b491dbc-ec1b-4e38-8b6c-0000214a6af7;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-26T09:27:35Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a3fd3495-2b3f-4ed2-82b8-000007c39146
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-26T09:27:48Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ca4ef294-370f-4681-9eb5-0000ef1c466f
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3f21042-fc2d-4701-45f2-08d849a251b1
x-ms-traffictypediagnostic: BYAPR12MB2759:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB275979B95F0C25EB3EAE6805B0540@BYAPR12MB2759.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M8tQBpQQ1/N4Z5xHpNOZQjDZ8zOkATOgAoWAuj7NKkDdC8K3GnWJELwAj5l25EqGJFzrrzyNZhtEtwdYB9JkrUCn5tNqIP0I8ootgdmrOztShaRz0xjv3qlrwL9D+cO43Kv+Z/42uSI00ZYh2+Xx2asNKXDbg3wlxAf3D7rTLwIzZo/6jXdquT3DytT2ASdpVFP+K8+OVnPp8M2pTdRNHmSVoidFxzn9IEo8GqyweKv8tfA2DOPridy7aMB3+03UBRGwAeDqYqjG6/VbNACUA2YoFI4THaaO253mxbKyhoyP93uRIUr/iFO4J7CKW4nEnaGnxARsWo6gtO6pk6oC9Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(110136005)(8676002)(4326008)(54906003)(6506007)(478600001)(55016002)(7696005)(86362001)(71200400001)(186003)(66446008)(26005)(2906002)(8936002)(83380400001)(76116006)(9686003)(316002)(33656002)(64756008)(66556008)(66476007)(52536014)(53546011)(5660300002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: curoRYnsmKC4Z20QucTlmqbPHSroMDqJThiG1eqLiispeuCKrS4ETcst793cbsfzJYCAlzqAMzWdHYgfC/8NdoVqLPtIhUMi5k0RI/MrHBnPwhJ29odP9NMCwFqsvhnXSeTDv36sfm20dCEV57y4Z3z7sHwMy62qqV97ezqzPtLif/5jfIMGXQ+FFagfUr2duH9Tbc3b0rRme9XDVgJZr3vyCUE6Tovxp4to8vhVu1Uh78fVtII/Osns1QPE3ocoUXxDGXex/bEJgnZruyciA/snWomrJdgH3YPCRjL3NtwG/pr1KDpZ5uuVvn/XZFl5rLPHO/GhueVYG7GWbOGjyvmvIDDeulctkvuNjXBxSFHXvKOOTbPfmN2nKpZnDwKN/TBXsLDyY/NxR4sSTFPZRNze8KO/ABpqPscjHJJf2urRB1Mcxg+akM8+h/oCI9yYxWuYVhDNCbUeo/LOLnjUB1ddhHiZ6ZXlFb5qxRzJOSGJ9EjfL0XW8flbv5nZsZ8Dld9v97R6U7x+xAlVvX248ActxgfjE5B9ux5i5+FbSLuzKGTXhVY/h8thHekRGfKnXPrSHEqpsXjuMWGMHmh/UN0s6sPkmZTaCttPMgaJn/Ke9HyaBlQb/gUYIKBDvmTvZ2ROwr9mj43f53P4COcU7Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f21042-fc2d-4701-45f2-08d849a251b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 09:27:57.5677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPjTUtLQEH2gieI6U8M9Li+YUA84nPyRSsyThUCFeJRjm/Bd3rcWmmwnBxwsc8KN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2759
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Jiansong Chen <Jiansong.Chen@amd.com>
> Sent: Wednesday, August 26, 2020 3:59 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Quan, Evan <Evan.Quan@amd.com>;
> Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: disable runtime pm for navy_flounder
> 
> Disable runtime pm for navy_flounder temporarily.
> 
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: Ie1b03f09ab70e79b6dd67ede5547afa23c063eee
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 9f80eaeaf0ae..caed73d72d3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -170,6 +170,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device
> *adev, unsigned long flags)
>  		case CHIP_VEGA20:
>  		case CHIP_ARCTURUS:
>  		case CHIP_SIENNA_CICHLID:
> +		case CHIP_NAVY_FLOUNDER:
>  			/* enable runpm if runpm=1 */
>  			if (amdgpu_runtime_pm > 0)
>  				adev->runpm = true;
> --
> 2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
