Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EF5C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 06:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 280722311D
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 06:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280722311D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D5536E823;
	Tue, 19 Jan 2021 06:25:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63AAF6E823
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 06:25:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ir1UxxDi9v7cMEzk0st2A/4L85sIeN+8HBjFJ0Qj3m2T+fzy+4WPQ/V/hoeSKkJx5O7AT2K+KDOr+Yo9Icf7q9Z1paIwBBiJ+Lnl0L1jCnGcOf0isuAkhoUsinccIIqJ82/EkJ0dHV6Sgk/gbZW9BiyshwRjjhAvHwh+n1cvaXo9UtHW4xOdqcWiw3MQsjYnzjC/EfOQEIXAywnVdANzeTXxI0lD/C/gm4lkBwk3fS8p1EUJ53Yt1L9hJjZa3AG/WjAKdT63QN1Uh2iT40X9byosJBK5gMVqBS4RAh6F3ttVXQ5YrHNurGFngaFNhtBi4q2z947GIPcb5JIuQ1O22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73FmU80o9OYjpE4LKp5Hd9WpNqGLPh1imzw4CpXOplE=;
 b=WaSQXNSUm8c8GxROjyO32KY5FA/hM957cC3d4ScmNtZWQyVFxuHn+6FhgW2PxcAcIVnZYoIhT2Q+YibabqBZiC+DaFZxNjKySYSk9fzIguz4wBZI1WPxoqmufRnUDbWks7G3g7wkKBj42OL6rEZukcaJn9gK6YNRYgSGY5sKGj13vS3DXs0kJWToNHwmn74PEvC9TVaoK3Sb/iC8zwJ3XWDRVzDQx7mUnu1rgjHoVvGFLS4q6c7HPpYeE3ednLEgnAIN85U0stjUZ4BX6rUjnkQcjm6gffwv8sJkd8VECov0fjHGe+UTP5sKwloN6SE3r8Ghd+tM9mnpfTxYIPNEqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73FmU80o9OYjpE4LKp5Hd9WpNqGLPh1imzw4CpXOplE=;
 b=bOr6YsblCk1TJqgJfQw87NBlmiu2rPR7GdJSvEw8c7tROh9k+TYhl5s0dfTbd1517B/XoVW17DAXa6fBpI7axCHQssOJW0ByhS6r9fSpScWXPW205INyQy0YII3O0AVtAiybt/s1xDG4cWTt7yhd5On0HdhjZCAgR9WSN+zoafI=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 06:25:37 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6daf:7d00:b03b:8a16]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6daf:7d00:b03b:8a16%4]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 06:25:37 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove gpu info firmware of green sardine
Thread-Topic: [PATCH] drm/amdgpu: remove gpu info firmware of green sardine
Thread-Index: AQHW7icytGfBHKG4PU6f7OSt1G9H86oueYVg
Date: Tue, 19 Jan 2021 06:25:36 +0000
Message-ID: <BYAPR12MB3238BA59B2D36A50A2E93B46FBA30@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <20210119055135.70134-1-ray.huang@amd.com>
In-Reply-To: <20210119055135.70134-1-ray.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0144b08e-42da-4e2f-b1d1-42b6a3c0231a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-19T06:18:33Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [139.227.235.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56bce0ba-3f88-43c0-4f4b-08d8bc4308d9
x-ms-traffictypediagnostic: BY5PR12MB4132:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB41323A08CCDEF94C5B774F2DFBA30@BY5PR12MB4132.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CsbenVTtAgHjypcfCfAOpbvyRzW79iN0T9LFCIg+dTgGiibNq8WetfQ+gCTW9Kf0iOxhPIpKe9LJlIC1qWsDuuAiII8iZd/SHz9FGZNJ+X/FztIFOpxM86vhSow3OgCmA650RBLInRC19yJluo+yLYG8Wat+qWus8J5On9f872KF3iPiV0hsJ2JY28OzorBUmGrIuDQjzGE6GvAir7jHB/UdBtNFC9sAoVFxvTXwccwXurMvTt4xmxyMtyKAPU46hfDmgg7dQX44BgaXpZPWYZ/6t4d0vhT786olYR6dk6XO+UjEk4M78v9pOUsnOed8XjQqB8cMl1CdwPAQfdm46784v6TQzMugZoDHj+SVx038JEbvQ4TcYFdbkL151Txj/ukeHYAdDUDB1e43Q0CAkQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(316002)(55016002)(6506007)(52536014)(8676002)(53546011)(9686003)(110136005)(71200400001)(83380400001)(7696005)(8936002)(86362001)(5660300002)(26005)(66556008)(66946007)(33656002)(2906002)(4326008)(76116006)(66476007)(66446008)(64756008)(478600001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?B6bjRxCjT3R7cALXlQ9NuB4Npt+L0ErORxo90d8HdhQiMxbtVHo8wB0Y8i0p?=
 =?us-ascii?Q?3t5U4LYz442F1zgop5yla3AyFnxg0j2L7+GOFELkzT+GTaEbNzZYPBC7ZejG?=
 =?us-ascii?Q?yBvPVpCwOdeZn00UR4Ff/VJNKmA5JjUHoX2kqM5t7isQ6PKgDqZ7q6/f94/o?=
 =?us-ascii?Q?MMaif8I4ED8VePKT5r2LMr6tPB7NJ9KSTRXFb3uKEjPPcK2TyP+IXPvmsEw/?=
 =?us-ascii?Q?7IyenxbB/GbrrcVl2sYt1/MJaYB7h1fIQSajThcHI1aesGXSEIZ86+1pAYqB?=
 =?us-ascii?Q?Tq2Gw0rSeGwzHini7+y0Y/NFKjykr5izytebG8LixwW3yYVayeb3l9jv0iej?=
 =?us-ascii?Q?EZKrIB3QRNKdl9UXhW1xCWCYRn2ywTGnbqgYYTgqLbtKimQ828RF4witGpZk?=
 =?us-ascii?Q?EMYJeTyavSQwkLP0UTjokNVuIeM9iQni75TDsyEcFsOo1BNIx7qgT/nBrexd?=
 =?us-ascii?Q?+iewbLqm2hGbyU/tBOWEak+FD2jeWv8TG8lLKoGJaU5qmOV+nN7wERKzdE8f?=
 =?us-ascii?Q?j4DAxR3JwmebP61Dk2TVfMvIquKotl2R6ILnDaslnhTbmKsVoxxLEp/vKSIz?=
 =?us-ascii?Q?Is+vo1HY7XuwaXn+xLwMBagwSMTTDhVwCjR7hQaccMCo/0Qh69RV7KdbCcec?=
 =?us-ascii?Q?ecUrNqPh4bbqrccwUhHyGY4kfh6YGxRvs5C3jWXBn/f4bvLoawyc4r2qvpX9?=
 =?us-ascii?Q?65LhncXmu8JAY2cWrXF4tVYIMJ/2kxLPhVkgLUnoeU0Z2azPlvBEmZBcDCSe?=
 =?us-ascii?Q?+KEkSgeniPLA6noCTVUVjxThIVvDuqMAxBdfaw0zAQOxSoMDOAoWZrrr3ByI?=
 =?us-ascii?Q?BmUFom5OdFlX4QFVS0R+c8yWtL536TzLzr5kgC6C+o0AnilI7weO2aWWgrax?=
 =?us-ascii?Q?+xWiq6nf7okIc/GibMUvnEznogDYO2GVF4QBIxmYeGSJWcIlUuPNdLdPD2sd?=
 =?us-ascii?Q?VvlcQQgzLvfbziORmGIse/gWXSAsCUXAKTpAPnOJfaA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bce0ba-3f88-43c0-4f4b-08d8bc4308d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 06:25:36.9485 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4nk5h/DiixH7pY13J3P1NKrmLNLjfstW3tp4b/XNH4mhRCmIqdj31zNvPa7Ja4W3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
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

[AMD Official Use Only - Internal Distribution Only]

Thanks help clean up. Generally that seems fine but could we keep the green sardine chip name to retrieve the GPU info FW when the IP discovery fail back to legacy mode?

Anyway this patch is Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Thanks,
Prike
> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Tuesday, January 19, 2021 1:52 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> Subject: [PATCH] drm/amdgpu: remove gpu info firmware of green sardine
>
> The ip discovery is supported on green sardine, it doesn't need gpu info
> firmware anymore.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4d434803fb49..f1a426d8861d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -81,7 +81,6 @@ MODULE_FIRMWARE("amdgpu/navi10_gpu_info.bin");
>  MODULE_FIRMWARE("amdgpu/navi14_gpu_info.bin");
>  MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
>  MODULE_FIRMWARE("amdgpu/vangogh_gpu_info.bin");
> -MODULE_FIRMWARE("amdgpu/green_sardine_gpu_info.bin");
>
>  #define AMDGPU_RESUME_MS2000
>
> @@ -1825,7 +1824,7 @@ static int
> amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>  if (adev->apu_flags & AMD_APU_IS_RENOIR)
>  chip_name = "renoir";
>  else
> -chip_name = "green_sardine";
> +return 0;
>  break;
>  case CHIP_NAVI10:
>  chip_name = "navi10";
> --
> 2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
