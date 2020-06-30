Return-Path: <SRS0=hrZh=AL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41B8C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B4F2068F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X3fHlPvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B4F2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 842958908D;
	Tue, 30 Jun 2020 13:34:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AB5D8908D
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2020 13:34:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuiQzBlW+GDYTvm13DhFbuL47bn0lSB2Kn1nbB5M20NuqFzecYjVfj8W0my9SD18OXVtf/D9fX6wC36a95Z0eTXNmeECOwXZtfBnN7udlo3piuN1ElUhJFVSmYc364Vx6EYIRe3Yj3smwyOaqcyV4CRw2pHHa2fBJMc5VXzIinKhKqaYs1+BstS8aLgbOaeTHAyeoCGgWzk5iwkm5xvbxwL4vU5cXeRXryoDO3pUFLo77tsJYdbAkw0vuZC2rvYEM2iVOlXLFEUjOZwN/RzR/cO+Vo4RIcZmJ/jWJ3se9cbohYPbTjp1/fS6JHtOlgVxeCcispefzrzQCLKGmNmaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2ju6xAu6MiOPBe5RNmUdD0R4VT1O3tPkSn8FWyhFII=;
 b=hI8MVMv5/PKOOuewQjMvvw1VnTZ27jqVXop8fY1Ncxxeba5ITGzVE/dVJvJbdlk2jBk8EpTJ+RxWYGY8ION7uhB5aFxjLeLosqA/EVX4zVDHOCqez0m8H9m6tWM2oM85DDM58/7tdHHGugXD9jorySbkxB9yr/exsa7gcaEY980eZgwVjjeySMi11HLrNEsHIO8hPXtfGp9TtkMxHzq0D7VGgyAA2MjW5lUsNEnuEvOSBpdB078qrn1dZZBgY70lOK7GnpjMcLCAfRxSvF71CAVPd2kdZ/1F4ctiz2r14BW1XdkDJO6ict4xlaXhOay/U6yQKs3Ply7f5j/qJCTeWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2ju6xAu6MiOPBe5RNmUdD0R4VT1O3tPkSn8FWyhFII=;
 b=X3fHlPvkQ7NN/0QGqq3gvy2GcmmwQpuzo2YGpLNE6pJlzrIDbaSDaKohPL9mJWjPQWvdMR8Cu3RjYB9f7jtDJJJyHAtlBV7bGLYYWuZZQPbN/jKcfJsSnGMJWWStvShMU1zfbdDbmcafdxLo8Z7vz5AL+kOe9VeJcg7Le2fAAiY=
Received: from SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30)
 by SA0PR12MB4558.namprd12.prod.outlook.com (2603:10b6:806:72::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 13:34:55 +0000
Received: from SN1PR12MB2382.namprd12.prod.outlook.com
 ([fe80::8cbd:c948:840b:3a69]) by SN1PR12MB2382.namprd12.prod.outlook.com
 ([fe80::8cbd:c948:840b:3a69%3]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 13:34:55 +0000
From: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Add Arcturus GWS support and fix VG10
Thread-Topic: [PATCH] drm/amdkfd: Add Arcturus GWS support and fix VG10
Thread-Index: AQHWToGMpsOb/ZKyaEOP2BDApQu59qjxDukAgAAZ+AA=
Date: Tue, 30 Jun 2020 13:34:55 +0000
Message-ID: <SN1PR12MB2382D7EE01F1F0B9418D2433F96F0@SN1PR12MB2382.namprd12.prod.outlook.com>
References: <20200630015526.197720-1-Joseph.Greathouse@amd.com>
 <DM6PR12MB3721BBE5C48881F357B90E8B856F0@DM6PR12MB3721.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3721BBE5C48881F357B90E8B856F0@DM6PR12MB3721.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-30T11:59:46Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=70894e1c-be0b-469e-9577-00003d1bc2c4;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [206.125.156.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb72090c-ef20-4845-eb60-08d81cfa6053
x-ms-traffictypediagnostic: SA0PR12MB4558:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR12MB45580EB70D027167F93F2A1FF96F0@SA0PR12MB4558.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ipdi71iT5g7ClcGhKdaaF9u8gaqLC4CG4Ckc+aSCQS0ljCbPIsR9pjp85y95Br7SGh6AQtv+j0rS6tjsmN2lkRjjIi1auCsOfRZZ+IiUxHSruZ3mvUsJmU3jFbN3LxOEozAfjNDtF198UypKfo9rOgBeA5BPZ5Z73eZuN9LNi3HIDaMvbq0VGpOA0OtfHh0GYOFeuHQQEHBV7C7RsRHVCNoXN2y+j6A7pZ7VAZepMyLZkrJgNFq6AV1l0TmFxljeHB2fP5KoU6ozsZh2HHVKkxktR/xC4L+n66+p6Bmqi1yqxgPywC/qP9TdW0LlW7d17ixkUT+EJviWKWRadR05Xg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2382.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(55016002)(5660300002)(2906002)(478600001)(71200400001)(7696005)(9686003)(8676002)(66946007)(64756008)(76116006)(66446008)(110136005)(316002)(53546011)(6506007)(66556008)(66476007)(186003)(83380400001)(8936002)(52536014)(26005)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Wrim4Vs6+eaorcc9FCm3Fn89yDIqwvZJO3PAhZ6EPxadfAf0ZSq051dj8k9gu72kXJIaw+sruwh03HEtKTK4o2SzyyhMj9UWHJSINzcvXeeOO5xV/Ysiv0hmt809NmwN3pw975cw5LfCq+GeNs71FZrZuWrJ35cXBnh1GHYLAwySZP7PiIj7/Zl975C6RDrC9+KwUD9k8ATzflfUcnhqC9VDllIVr2g5EcYjlVmrgOqDHYdAbXlbH4341irG4KSzlPn5mBK5w5m7KwE6wlUhJWehfhOsgD1UZMcwOeQkFW3NfJNqISm5guC2uPwGrHg34k4Cr1jk/0w1127TS+PEVResNOSc4z9rjUBBD5ElN7ZuA7UK3koq5GW04lb5apdkxhFb8Z3wWkTUKh1EAIVhykmOgZR/AVuuEm5IGNNl42wN4l2rfeW1Z3LM5cW/18kkS8PxC3Y+89cMYXPppChhSvxsrwQEsIMe71+5NN6y4QiESoARhZ8skHdTYz0nRAkD
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2382.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb72090c-ef20-4845-eb60-08d81cfa6053
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 13:34:55.5529 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxJZslFA6djT/gF91vSkOlbQHR46pWkgwovyBj1nzhQVdBwvk59fukbYUmKnb3+ocHj/aVQ7V4JtSh0/ttm8bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4558
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

Response inline.

Thanks,
-Joe

-----Original Message-----
From: Russell, Kent <Kent.Russell@amd.com> 
Sent: Tuesday, June 30, 2020 7:00 AM
To: Greathouse, Joseph <Joseph.Greathouse@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Greathouse, Joseph <Joseph.Greathouse@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Add Arcturus GWS support and fix VG10

[AMD Public Use]

One inquiry inline

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Joseph
> Greathouse
> Sent: Monday, June 29, 2020 9:55 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Greathouse, Joseph <Joseph.Greathouse@amd.com>
> Subject: [PATCH] drm/amdkfd: Add Arcturus GWS support and fix VG10
> 
> Add support for GWS in Arcturus, which needs MEC2 firmware #48 or above.
> Fix the MEC2 version check for Vega 10 GWS support, since Vega 10 firmware
> adds 0x8000 to the actual firmware revision. We were previously declaring
> support where it did not exist.
> 
> Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
> Change-Id: I9b44dfe59bdd8a38a0342e5155cdb071cf646cc5
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 80393e0583bb..50886de3ba0a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -602,9 +602,13 @@ static int kfd_gws_init(struct kfd_dev *kfd)
>  		return 0;
> 
>  	if (hws_gws_support
> -		|| (kfd->device_info->asic_family >= CHIP_VEGA10
> +		|| (kfd->device_info->asic_family == CHIP_VEGA10
> +			&& kfd->mec2_fw_version >= 0x81b3)
> +		|| (kfd->device_info->asic_family >= CHIP_VEGA12
>  			&& kfd->device_info->asic_family <= CHIP_RAVEN
> -			&& kfd->mec2_fw_version >= 0x1b3))
> +			&& kfd->mec2_fw_version >= 0x1b3)
[KR] Is it 0x1b3 for both VG12 and RV? I wasn't sure if it was 0x1b4 for VG12, or did they just update the FW again and I missed the original?
[JLG] Yes, the base firmware version for all of these chips added support in 0x1b3. I don't believe AMD released 0x1b3 for some of these chips (e.g. Raven) due to some performance regressions on those chips that were then fixed in 0x1b4. However, if someone happens to have 0x1b3 on their system, GWS will work according to my tests.
> +		|| (kfd->device_info->asic_family == CHIP_ARCTURUS
> +			&& kfd->mec2_fw_version >= 0x30))
>  		ret = amdgpu_amdkfd_alloc_gws(kfd->kgd,
>  				amdgpu_amdkfd_get_num_gws(kfd->kgd),
> &kfd->gws);
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
