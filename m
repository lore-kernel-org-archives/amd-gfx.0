Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6F1C33CB1
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 07:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B2F20748
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 07:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nWYvdOqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B2F20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 819D36F3FA;
	Fri, 17 Jan 2020 07:50:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 245286F3FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 07:50:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVqAhtOP1M2b2Skxltf6zMlgsFKrVmPdWPdh5kmyhqAUeJorPFJu7kqze/cihUwcpYtLKLFSD4i8FG11nHgU1YReN1t9Xgt2M9/Du1W1MDaYzdK0XKUwJ99Vf5pabJLEnDxd05KEycAKgjzHLA9T8zWrvPQKbJsXt4QClG0osg4UCY3f/4uxAAcT14hX+XSqmG4vmgJnSm1LZd3eRx7/wEiqzJMv5oBuhcJH0Mmz2P0pMZiQyjY63Mrjr+KL8TMqqWqezlKXDDz3v5r1YaAd+lPxbpG4hhq8g3sW3jtvyEfqSy6LZVkEU6lbhD7yLaLf5k6tfUGyyTK1XeLGkqUgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blJWneLNPaAKeiCZsLAN6G9srRdTX5X26/CQ/kVpvmU=;
 b=BYJShjM75GX5slnQlAOxl31QN+bErzVWpGoQghnI5yOjgsi7nJLc0OE05O4RUnnGNPMzkR8dpy2UAHM1GadkmiyYzqu/XpsamHejyMf0KQdPOLdGJ7WtaxDN9qddIXrmoU5yvrXGAsDUN2/Zam/Kc07vQ8bFn+s51+LrTZ2QzIovwS+/j6t0sbwlQdx0VpaAR6sI3SzFBrnHQiMwo/eR50gIcxYWzESukzdiFEuD152CExvaMggRcl2AlqGXz/o4e9yAPceurOx0lMfVtbtDvoHdErPZiv0KQDcE5E8CySYZACQ9bNCn1chWmgkQ5c5D4+AFYexzTeAXTClydTsFVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blJWneLNPaAKeiCZsLAN6G9srRdTX5X26/CQ/kVpvmU=;
 b=nWYvdOqO3C2AtZTbGTAlfGviVEfUuFu0WfaBmWBSsvLbtCh9gphZCobJRzX9uh28TY77e9+HP0rE/An5h1DEUC3CT6eDf145Dju5h37UUMJR1IAiMtQ/1kxPk422VwYI+0LCLj+V+oOiPwrkvUenmZFHsYjDCQWHvF2vRiHL+Rg=
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3662.namprd12.prod.outlook.com (10.255.236.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Fri, 17 Jan 2020 07:50:41 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c52d:5a67:be50:c4dc]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c52d:5a67:be50:c4dc%4]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 07:50:41 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove the alignment placeholder for secure
 buffer
Thread-Topic: [PATCH] drm/amdgpu: remove the alignment placeholder for secure
 buffer
Thread-Index: AQHVzQqFtekD9wUW4UWzLzZI6iVW4qfue3gg
Date: Fri, 17 Jan 2020 07:50:41 +0000
Message-ID: <MN2PR12MB38381A2F7F58930C77F3CCF6F0310@MN2PR12MB3838.namprd12.prod.outlook.com>
References: <1579247290-16320-1-git-send-email-ray.huang@amd.com>
In-Reply-To: <1579247290-16320-1-git-send-email-ray.huang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3c6581de-daf9-41d8-a71e-0000521119eb;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-17T07:50:25Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eddb423d-e49b-4e41-3c39-08d79b21f337
x-ms-traffictypediagnostic: MN2PR12MB3662:|MN2PR12MB3662:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB366206B5E22D6EE7AEE4D255F0310@MN2PR12MB3662.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(189003)(199004)(53546011)(54906003)(110136005)(86362001)(71200400001)(6506007)(316002)(478600001)(4326008)(8936002)(81156014)(966005)(33656002)(81166006)(7696005)(8676002)(45080400002)(5660300002)(2906002)(64756008)(66556008)(66446008)(66946007)(26005)(186003)(52536014)(76116006)(66476007)(9686003)(55016002)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3662;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: diDqHVrNR5XvSXu8Rn6M9cmKTk9tPRfyAqSIRAGqyh0TSga2pQA416ovyG1JQsImDwELc1vJs9UD2O46szsWhpK9NESHje5LyNvLSj8UXflk1Xg5k4KOq8MUT79LDiKfzHICy9z3W1qBnsj5rasbX/nqRTv3H6qSzunGiElO5t+AUAlrdT0OoijI/I8hj0cxfTsGq1bvXjdXGyLO0c9igkMAXx/6eLZ6cih4MXnqCg/397miDq3rKLx4xyeFZMfpSA7N3+C5HzW6tMtvIRINDS/54f4bw1xLJHHUplFQyXzA1kFnsHDSIAW/KBTo6Nl0GNq79E40A4hg04p1lTB+FILbC1UHKvFWmUrpK/a67j8KpKSjRE26E/vhyUxYrpRCOvYFMZENCGe0AEERtMpubW0GTTDF/1YZks2pSjQ6/8jLz56eqB85IEC5l58PXm5QfCjoF38XRlXZWt8aFfPzrpH9EXK17D/Spw+1L6qB8mLLN+24bK+dlEsrVQid1DpQ+DBwbusxVM3jhT7LEFFjjw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eddb423d-e49b-4e41-3c39-08d79b21f337
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 07:50:41.0405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fH6LljEI4vv9mglPXtNVirPeHGXiGwkxylYCkz8yH9I92SKw+P7DyVFBN5U4z+7l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3662
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

BR,
Aaron Liu

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Huang Rui
> Sent: Friday, January 17, 2020 3:48 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: [PATCH] drm/amdgpu: remove the alignment placeholder for secure
> buffer
> 
> The alignment should match the page size for secure buffer, so we didn't
> configure it anymore.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index f39012e..41d49a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -261,10 +261,6 @@ int amdgpu_gem_create_ioctl(struct drm_device
> *dev, void *data,
>  		resv = vm->root.base.bo->tbo.base.resv;
>  	}
> 
> -	if (flags & AMDGPU_GEM_CREATE_ENCRYPTED) {
> -		/* XXX: pad out alignment to meet TMZ requirements */
> -	}
> -
>  	r = amdgpu_gem_object_create(adev, size, args->in.alignment,
>  				     (u32)(0xffffffff & args->in.domains),
>  				     flags, ttm_bo_type_device, resv, &gobj);
> --
> 2.7.4
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
> reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Caaron.liu%40amd.com%7Cfe128e2299c943be48
> 9d08d79b21a418%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
> 37148441147752302&amp;sdata=HRtRCe7OUhBK4ScG%2BplLUJiK%2Bn8wU1
> BXxb28r5t2bWk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
