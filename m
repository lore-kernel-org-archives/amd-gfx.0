Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CD7C33CB1
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 15:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20D9214AF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 15:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U0iO6MYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20D9214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A7F6F5E9;
	Fri, 17 Jan 2020 15:26:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACDBC6F5E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 15:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1OiLc6W8iv1MbPiGWSNNOjihIV6A24rF9L21Lw5h6HyM2d90aKg7azn3OZyF5pczJZRTIfVriM2jfl97c5BlM+mrXRCm5i4TdQYbqfv/iXOp+Ir5O7x+W3UFR4vDEa7tFxtFMPuEM4FrEKX5JVOMEvR9OF1VlPSbHvxRS+FWaYoEqhftw86R8l0A6GAbRg3qNYIHoaxaU1JtcT750MqiOdTbAvw0qpq+p3zxLKwlh4beIGFHj+rhKDS6iTgdkEmv+xIKhj7Xw9sIPFlhqnnzGTR8o5zabx0jcOP4VNkKEah0eFgx4ipUl9Dd/NQquQ9uqdW/oPJLpotLBiE2XPknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzxUoS/1IVPzI88ZLROf9EfFyJdbhdPVBuQRIH39+H0=;
 b=iGAvDu8KQJ7OG4tMoP42Dka9jHyBuE88WwOcPtRToyFwIdAqJxgbElXGrLwByJ6wFxJNpw+GxK5P/TqBXxPZhbA6CLnIyqSlqDv1Eg8JPWEPtCtHtZd5lZ8Dq0DIxa+gqCP1+PtjMy/A/9T3vyPHg3oDRbAa7JL6Hhr50FoPVjXHF5qhHuKJSkohIffi7UYWztBC+dKw7zBthaj2vnCdQ7RGjU0oLSgKQ8n913Q5gfwSeKJdvHm2oEfsfkpUIxBxQ4DvwBsE8qZ9JJRK9HY9U0YHt38CtdOH5a5q+PyIiauLSbJyYR1ZyC7HAjVGJurxqFlWl3QVpua6RyE9DC2Dow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzxUoS/1IVPzI88ZLROf9EfFyJdbhdPVBuQRIH39+H0=;
 b=U0iO6MYTYCOz3svaZM/4elFa916vbAhl5MbKgoKeplV0fJaY+tP1O9u6rSVU6mWokaw3Fs+1m0rNPS/mtZwWmiptgyOni7TE9navCLRPN5wfwL+MuiAnhqWDwLWAYwmdcxVQEXMAxJEQZ/d0Vi0Iej04WX77ZQSODNEgxeB4lkU=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1451.namprd12.prod.outlook.com (10.172.38.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 17 Jan 2020 15:26:40 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 15:26:40 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Cui, Flora" <Flora.Cui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: skip reservation of discovery tmr region
 in pre-Navi
Thread-Topic: [PATCH 2/2] drm/amdgpu: skip reservation of discovery tmr region
 in pre-Navi
Thread-Index: AQHVzJ7Kvzjh8SgCGUu+ByhWq4dIvKfuJlOAgADUwGA=
Date: Fri, 17 Jan 2020 15:26:39 +0000
Message-ID: <DM5PR12MB14183B2E45751F47411D0207FC310@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1579201021-7109-1-git-send-email-Hawking.Zhang@amd.com>
 <1579201021-7109-2-git-send-email-Hawking.Zhang@amd.com>
 <5686e8de-3e15-d399-6c5b-9213721417d1@amd.com>
In-Reply-To: <5686e8de-3e15-d399-6c5b-9213721417d1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-17T15:26:38Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=053404ec-48af-40d6-9673-0000b7af9626;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-17T15:26:38Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: aea8ac4e-8bc2-4f9d-ac08-0000454274fc
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4aaf9366-46b4-4ef3-3f9e-08d79b61a651
x-ms-traffictypediagnostic: DM5PR12MB1451:|DM5PR12MB1451:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB14516441AD15A110E89DE1DFFC310@DM5PR12MB1451.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(199004)(189003)(9686003)(55016002)(33656002)(8676002)(81156014)(81166006)(52536014)(66476007)(64756008)(110136005)(5660300002)(66946007)(76116006)(66556008)(316002)(66446008)(8936002)(26005)(7696005)(186003)(2906002)(53546011)(478600001)(71200400001)(6506007)(86362001)(45080400002)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1451;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oQK/QXrLb0vroTrHFUkyrR49Gggihn0G5fnJ3GX9+w3qB8GRJaPJc5UK6GlS0h034vhLpn1v5oRVztvp0ef3CRImyWmUFNLuaVvuDbVZ19ZgJLp/eJyj5eQLcYjPA6jVWyn3IVQXG1Jd7QPXIVOzcYBM2DDV9U3F+J52F9vLjZe1Q27jINh4KCNovxSxjcsLzmjKn8faqy0BOdv0azV9Zt/Nxlr0cnjgjavgJPyzD9xJmsJ2uyLVOUqahlZPLHMPAEapP7m3qvgEiTyeRnZ5d9t1EmZdKyIoxpanRgbE4VoSZxhEq79e2c7t3QOs1RbFNWZ0e9iMqdz3+S+KT1BhhmO7vE+o+rufuZxn/mJwQWfYlz3MqjEwI5SwH+bYkLFLR7InHGoUTPFFSYh4wzayj2zJ0NIPbCr/k760v38KsvS568Hh5pdyIBdUYriQ5Xxk0khBcIhKdEn8uMb92y7WDUrVD2F4B98RxNTIUR9lhMM=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aaf9366-46b4-4ef3-3f9e-08d79b61a651
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 15:26:39.9830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hlEVBSPVzScRoR817yleqCuWFObSVWSnQlByuNkQt10uQTSIlEnRmj/NGnLwV7CZY6ZsHVmWR5xmAhBeTjsu7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

That's a known separated issue. Eve it get fixed, we don’t need additional call in to any bo functions. So let's just create separated fix for that one. You want to send out the patch?

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Cui, Flora
Sent: Friday, January 17, 2020 10:43
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/amdgpu: skip reservation of discovery tmr region in pre-Navi

IMHO it's better to handle the size==0 case in amdgpu_bo_create_kernel_at().

在 1/17/2020 2:57 AM, Hawking Zhang 写道:
> IP discovery is only supported in Navi series and onwards.
> There is no need to reserve a portion of vram as discovery tmr region 
> for pre-Navi adapters.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 967f6d0..f21fd8fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1822,14 +1822,16 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	 * reserve TMR memory at the top of VRAM which holds
>   	 * IP Discovery data and is protected by PSP.
>   	 */
> -	r = amdgpu_bo_create_kernel_at(adev,
> +	if (adev->discovery_tmr_size > 0) {
> +		r = amdgpu_bo_create_kernel_at(adev,
>   			adev->gmc.real_vram_size - adev->discovery_tmr_size,
>   			adev->discovery_tmr_size,
>   			AMDGPU_GEM_DOMAIN_VRAM,
>   			&adev->discovery_memory,
>   			NULL);
> -	if (r)
> -		return r;
> +		if (r)
> +			return r;
> +	}
>   
>   	DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
>   		 (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C4d6cb0e6742e4a35941d08d79af6f6ad%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637148257906675785&amp;sdata=4H3PE0Nai51yAi7Hy6R9E8qNmuNhlDYJQOirLYzp1QI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
