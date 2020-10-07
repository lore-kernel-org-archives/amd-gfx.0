Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7AFC4727F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 15:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 847C121548
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 15:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LN5Hd1gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847C121548
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 065736E8FC;
	Wed,  7 Oct 2020 15:12:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 640076E8FC
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 15:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOGbiQ5khy1gLNriTCAUlqRHB9TJvcs/DXU11Refd35ESqgFBAzMXMozVBlNPAdUZ17SOTtp0pwcy19DT0lFVnRNM9OeLWhEWHR98NeEISCTykLzgs+2ElNMnKODx4+jI9spyzQIW2XbF9fT3dzCNTGGEmjsblaMnIVzvsTw8D4Gw+pAQIM0XeiN63S/JBS4gFg0gCi74qiEfluVrAHxVB5x6uCrSAMs+I9QvFxsVhFleE/Rf1+n8dlgkmPgcqyhUbkHaTZM1Kapnqha3PZVyS+jx+mbMJbV2AOibutLEXwDv74bYOZKzICdEHe5GruSoJ3yXjejxMwyVFkwgu9daQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fxg8GfDHcUKs1N5njqDgGn3lIV0Jybr4dsnV5KW0MDE=;
 b=f5NJ3f+ULovri6s+NwnEh1Ga5tQ5SXCWi/rB88uCdrzi7kJbhsqWKo/xE0BAIc50vsaGfzACEZ9ihxRWNc4rjXhbjsk5MADq9MsD4CvGKl3Oo0vImyZhx94GipZTgLG1D499lMXRS/vRz2SP4AUTjlo//i1Rg/QICfSTXC7IMq5+PcUDqypN2WQjT1ngQDbRe/Qf2onvt2WL67xP3B1+QVIL2H0QZq/YRbyt8CKAUJzHMEuxi1XOdcXl0H5nrQA9gek0ky/96fF+UNLb8odvcnp2kNkzv6BLaZVY3ezAPQLgX6LHFcLCJhuPsjAowOz4/ei1ljJAVyxssBQiSyu8uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fxg8GfDHcUKs1N5njqDgGn3lIV0Jybr4dsnV5KW0MDE=;
 b=LN5Hd1gv/W8XEFmJBHzI7m72ALNjJHp/OX6/JC2YCmdh19IPl1vg7RV067HCtoqYd16R/HWK2Ys+ievNjjwuHptnhSIvxEyr0q+BhZUIjdV4W3UsczJ6gir7oZR8Z7whbzHt8UZG8DCOjGDkSV6T66J00Xh8KkbLBItGxsBTfpY=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3452.namprd12.prod.outlook.com (2603:10b6:5:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 7 Oct
 2020 15:12:00 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3455.023; Wed, 7 Oct 2020
 15:12:00 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: prevent spurious warning
Thread-Topic: [PATCH] drm/amdgpu: prevent spurious warning
Thread-Index: AQHWm+Ruvv3KUwju70yjNroW2aHIEqmMQIbA
Date: Wed, 7 Oct 2020 15:12:00 +0000
Message-ID: <DM6PR12MB3721CEFD788562FCCAA9D57F850A0@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20201006132659.1486610-1-alexander.deucher@amd.com>
In-Reply-To: <20201006132659.1486610-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-07T15:11:57Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=134770c1-d82e-4762-97ae-0000e849ba6d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-07T15:11:50Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 073cd06d-dfa5-49f7-a5a0-0000c65f353c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-07T15:11:58Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 603afbe8-84be-4523-b6f6-000025ba1263
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1c80:6680:815e:94b0:bed3:a68d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 43397730-3a4b-4a27-1860-08d86ad35729
x-ms-traffictypediagnostic: DM6PR12MB3452:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB34527544D43B7B94FEC5C0AC850A0@DM6PR12MB3452.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 94Y9BFAR+2yAbqFEfucnPFzEGMg4iMw6FqMXez3csfepYPUysDuFRUqHp4cumKiK7jQQ3DmXOfAMLliXFUt4n4OJctRItDuScr8t+yBOkv9mB8CKn3cq1tjfwYtS48FoHKbSPk/gi4oxeHNj5nNJ8SqU09nsBuEuhn7u7pA1cs2Cy387SBpGtOynZrsY4UOR38zhEpdNgc70fZZx9XN0FT7BDspS1PSLGf2nD+t0rg9pmoUZs69Sdvy2WG57gk0y8qOV6NFTvhB6f8bIQenefCAoDNowJk0fgCZ/JmbPCcdaIaNQr+saFI8b8GQndqjPXNmIfsKjTEpp8RxDGFcYUwU3grnJ9aCZAt/GigneaDVbFbquBADiFj2WbzVHy5yfuqb8JHrgCLl6+dwkq389tQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(396003)(366004)(376002)(136003)(110136005)(316002)(52536014)(66556008)(5660300002)(66946007)(76116006)(2906002)(64756008)(66476007)(66446008)(966005)(186003)(55016002)(53546011)(6506007)(7696005)(45080400002)(86362001)(9686003)(8936002)(4326008)(71200400001)(8676002)(33656002)(83380400001)(83080400001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: +IMovJShy6zlgUEvpAEEilZm5ksqPkyFxyfRt6bCfSiOmd+KV0Y1UTSvogajWjrGBMF+MXhammIAqGweWmQN9en8Wk3Cp0OolDwluHc4dGvHfzRA8A4gqf68BjD+8PR3Tu54hmSQTGXj2la5DmuBpJVoFUQVmTAt/fBb4I9XiGCSPOsDrlWwK3JbgG/MYJK491iZbVlRBxCnc46o6seqFu+t7cHYNu3aBTU3spdfvGQevQQFt/BMWX3yAElaewJAoUIWNy874vP/IS/b5ifxXAq6N7mj5thni/b+2vLZ4CLR4+c+F6tNXb5hoFo4EJ+947Bldc1wQuQI0bEmhPEg4D7tgEN4sakzOQtJBbosQZbLAPfvTunOv/ohnz2d1UmV2KsFIL2ZrtNOvmtPK9DMH6ykTsALVCHFAtpzbdqhPY2/afCl7yThCpu0xJ2HHCVGBWQ+dxuMkfD9kdtrqRhOIpPn0suClo4NxOl07C2rULUmghXx5m9uexEbwpkWC0imkAkoMm7YJsMBfMRukdub7EgxVJeW2YCsRRHpHt1aXPjRZIUNkqBYhz5eJXTgwgJvNC0rn2ekjMe0dkMpYGC+XL7uuXfWim0JFaZbD/OfvcaUtrCzxYqFROSi3wcc8R9PkaQLsyDNwHjQ52riNsrXWX5ZC/BWRPummvXgLnfi9x7gRQVcbY7k39u9uJfMbD1qaofVMDJdRJPRwnZqfavu6w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43397730-3a4b-4a27-1860-08d86ad35729
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 15:12:00.4760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXjFH9GtWn7Nwshw8mKvgaOKo6fDuyS4diRAsgtw16CTpjcByAsGFlO9yFijttqqMY6xrGgvjwjqCiM2nI4Jjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3452
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Kent Russell <kent.russell@amd.com>

 Kent

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
> Sent: Tuesday, October 6, 2020 9:27 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: prevent spurious warning
> 
> The default auto setting for kcq should not generate
> a warning.
> 
> Fixes: a300de40f66b ("drm/amdgpu: introduce a new parameter to configure how many
> KCQ we want(v5)")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5a26894dc635..7f26408c0d76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1372,7 +1372,9 @@ static int amdgpu_device_check_arguments(struct
> amdgpu_device *adev)
> 
>  	amdgpu_gmc_tmz_set(adev);
> 
> -	if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
> +	if (amdgpu_num_kcq == -1) {
> +		amdgpu_num_kcq = 8;
> +	} else if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
>  		amdgpu_num_kcq = 8;
>  		dev_warn(adev->dev, "set kernel compute queue number to 8 due to
> invalid parameter provided by user\n");
>  	}
> --
> 2.25.4
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.or
> g%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Ckent.russell%40amd.com%7C4a54f0460acd4e92a43e08d869fb
> 8d14%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637375876466082586&amp;
> sdata=rRpRoxlz6PIjDnhRPFPCom4Nn599DoVRG4Dl5iOlZRE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
