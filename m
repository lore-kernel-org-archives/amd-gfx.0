Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59830CE7AF9
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 03:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C569410E455;
	Thu, 28 Sep 2023 03:57:35 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D28510E455
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 03:57:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpDzr9f/IpE7QQv3yNVGKlT1Rtu+txee/843WF1FwZ641gW4Oi6mF4P2cevlXzqFJbE42wJDHPlIikEjJBjVBz0OTKHqt4ueTohipNaWpcju2SP4zvy9JYWA5fz2gRdkoNzVPQbAWqUzT8Z23rwfbKjmML9uUFmyYP9VZiEU+z7QVoKjBN3tZSLX+jDGi6HKnTZoXLerte+Wgceo82GuDbIaeHu9a/7hoZZ21pZojtbY2tU3nmQ8Jve4Pj436QyHUoPzlSyE7eyfLlSVMCo5u6vggL93YkNAYCE0l9pE4fAIydc79D+Sd0ymyH7IdEYxqjXCMG86VnF9Rf9B5YG+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2e+l/oSMPfhDmIa88PRJ0EKgz2T2tCJeS+xHbyJva2I=;
 b=MPORewwEshqUxiQqm+MPxShQPZfOnTtQbQA/wHapH5GxYNB7AciIKoovYCiK55vH4hZK2ygMNpmxZa5YHIPFwtZzhPyzBkgT5j3K1ImdWiZcwUpzvzzRlj6K5GItoa9Bo5B5i0Dd8UVq3yLZ/f71HpIsJ33pyffTc7X2x5uRMckWXP0pKeG6IpHmba8HMejPQZuSj08YnZOd0SC948abCVHvB0x10rkDfibEFHVyvwpFgKZySQ9O+SK0XPRR3fED8/NYSlYy9z2dlK5xIQrhmZvPsG7pe1h40ZYsN+RXQl2ZUDhyE+onWg7g/k15tSICXOI28xJ0EJ1lIPeSydEATA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2e+l/oSMPfhDmIa88PRJ0EKgz2T2tCJeS+xHbyJva2I=;
 b=yDkjpu4/ubIkivA/jw9jXy4zXCfP2QjmifburL8gHqSZPlaWgn1GCHilT1aE/tlXGJaNyCouF24S2CMbowf0sqU3myg5dU4QObUp9qproKmGnjlEhlJjxHm6sVn/CyJY4ky/ZfAhVeZOqrPx3Vl6wXcgTIkLpFjDgU7RE1Rvedg=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Thu, 28 Sep
 2023 03:57:31 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::4d4a:1407:b587:59e8]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::4d4a:1407:b587:59e8%3]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 03:57:31 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Fix potential null pointer
 derefernce
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Fix potential null pointer
 derefernce
Thread-Index: AQHZ8b5hhfjYCLqASkmwCzUrNYRgobAvnEuQ
Date: Thu, 28 Sep 2023 03:57:30 +0000
Message-ID: <PH7PR12MB8796AAA787ABBF368C700A06B0C1A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20230928034553.2172440-1-Stanley.Yang@amd.com>
In-Reply-To: <20230928034553.2172440-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c224979d-f438-414b-b18b-1ef01ea33a12;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-28T03:57:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA1PR12MB8842:EE_
x-ms-office365-filtering-correlation-id: 6a13c5b7-a3de-4eee-377d-08dbbfd70a00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eKQQv9PzaGCwVDwTkteajMJzC55scCs1En2mSGpOzwcZgy73Jv6u6VxkDEO4x9ix4qUBcj+7areiz+6d5Splmzm3D/Arbj78LPK91Zs7WPailbZgeNMDlOjPvlTmhSYUoCQy2R2X47ipBvFjeefkNFugazOzlP+9y6Vg/EgDIidd5nDkvZB9GFtnAUUFLLDMIvs12LQhedLiwK3dZC4laj5kVMrlys0Q0uPu94u2EhiF6KTEq29QA3zjfRN64ywi69X3d0Icm+OsrvYf/yQyBvD9wULrgOuOaIjjeETAlid7+iYVhD2uHxrrjRagv2838f8+WEaSZjaYgGCPiaobqAO9ZdyFkU+Q2kB3TsdY3bLph0QzR+3DOj0OTgh+Ryh5gX4RdApI4apJ5fVokiPWeYsZuntcZUhv2lVYoR1z+X4Efa3zTpPeWu0eDpdvRlfrMaqX2iUpkwKzEbVaVwddTm4ML2GfPCnoE4DFsH4vsPdQU1ettNm5Og3aj9fBIDGt3WPQnTEQ2EPHBPgv0mDHwMT8SaTgktjLXLYBFbDCmDMiIaGsFU0vGWiu5HWFCRgWnxXPngWIZbSG7jpaM3g2zsmBD7WO4oI6NxamNLINe2YH01VcmpkZ6n0qHv5ARv3g
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(52536014)(5660300002)(8936002)(8676002)(4326008)(41300700001)(66446008)(64756008)(66556008)(316002)(26005)(110136005)(7696005)(66946007)(76116006)(66476007)(478600001)(71200400001)(122000001)(53546011)(9686003)(83380400001)(55016003)(38100700002)(6506007)(38070700005)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3Y313yQDTRbgBUuxyiA+5gz7t8JLRZBwUjGMJcIDGz1SJasJ4kH/d0UxlThK?=
 =?us-ascii?Q?iYVE5cWxrAVj/xn+mJWrSZE4/B0Wt4uoxyUby4xgzw6k8YGOffjCYxjUIDT9?=
 =?us-ascii?Q?P0F26ULGijTszLoOwRb6IE5iNEc8kKQstRwvsdduEsEFITZRK+BqE8fZ+IGN?=
 =?us-ascii?Q?JZ8LOoAfmmpG49lb8HSEmvJOnCwNFjexTI/OkQQVuscJ2WdPfH6lVKp4IYGX?=
 =?us-ascii?Q?nB9IIBWXQe2IumFybKRcD9HnM1izXZmWnu/YKkmlDgSCp2vs4aZc13O38w2h?=
 =?us-ascii?Q?oH4NR2X9F6VO0ZeTgiFCMyJ4iSO0ddS9Ft/5nl1jcXw9qqfXXzANeCMF4w+7?=
 =?us-ascii?Q?yb40LR3JYJrwdBRqH8ZmaIrzMeIldi8Fmrq9bLU7TCWkDMOODYHJD5HaJrze?=
 =?us-ascii?Q?AD1OVx5sPV4UprPzfwCQHILgyWtNIFyhz/67WfGHrnu/UK5WxCSvV3UuVFWz?=
 =?us-ascii?Q?3laIpi72c7n2N7tsvu8pnDbIBQgzXViFr2C9ILS5zKUbbAqCqQKoruoVJkAL?=
 =?us-ascii?Q?hz1xR0ufDPDbdpY2jKcASU6ya3NEiIl66HMR7xeLZCHKnjF1A6Qud7+smJQH?=
 =?us-ascii?Q?hm9AqwT7Tu79g5V+TfEhuK6jj669IWIVHOFffFXgkmo3Y44fhAzVAZYtGC8r?=
 =?us-ascii?Q?L2WMVct3BZLRXz71chVkZqEPr7QI4n5SIGAtg4SR3S8I6r0ydW3W7CptXipz?=
 =?us-ascii?Q?i472s5gxzNJ6V1kVVNl2hKdewXuWVq7CCMxfzAB1a5A9CUmxKZynt9eFoQCd?=
 =?us-ascii?Q?ejaLae6RPQC9/x/9wY0OjsD++YYjNpZPqmXMXk8DgIkK2/DMeR4tTXGPzFfs?=
 =?us-ascii?Q?lBxtm1svtXWk/Z1BiJyfYNmDVtZ7m6o+R6KOhdCD2iHaTKd6iv4h63N//8ix?=
 =?us-ascii?Q?yNwUTUTka9Ea+1oeL4IMLd/IWGAujUwK/olq9DsRzvJ/bb/UQnS3N24h6tgM?=
 =?us-ascii?Q?2+npjAvITrdxMkq16SFq1uVAb9qUE5OtuDM/RzZoiItEIf5z4yYYaMQjM6wN?=
 =?us-ascii?Q?csJPZqDpLViZrg3zpQH8Pt5XW5W9q6yO0HaVNNTPWHwXQWzEU6PC7RdbLtFV?=
 =?us-ascii?Q?ATPET6GY5RE1eSsE/gKYMhqqRI17pCYbCPDlCkKyX7iHKiRRQYFg8jFG2bjj?=
 =?us-ascii?Q?MEHPqsf4couOg6G6trpLxQ1/nvh64BBUtFN6zwbdKPboZNEeEQgZnKzKGDxp?=
 =?us-ascii?Q?eVxesZKpyZ2kQ8+EKLL7lZg8GGiVArZbTstwrvD2Wx0pkJjqX32Vy3EJXaAQ?=
 =?us-ascii?Q?a8SbWT5Ty+MfBVIH2lNIzOPUTGSTagm3wcORUfZDfALCYm83JJISBqzvSoaS?=
 =?us-ascii?Q?xC7oX6yncDm4GPltjSz/5Zf3vGN/5mzhIYDV9uuCzHjvAh1sJ9AqDJcwc0mQ?=
 =?us-ascii?Q?NyV5TlYUp9cNP+BQk5Y0tvFKnZs/2qM2P6uobYREDVHWcettdGkIyLC62lif?=
 =?us-ascii?Q?do3fnsZnz2RaO/K0fdwYFM4GxEY6aExgKmlkMcxsjFidVexPHjDI/kouEyPD?=
 =?us-ascii?Q?o3O2z5n74ydTbTpPR2znAlcCUL+QtVDEmZ+xmzF2Psbh5+thLrMgQthx0HHf?=
 =?us-ascii?Q?p5QcYLvhVtvWfKvBpeI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a13c5b7-a3de-4eee-377d-08dbbfd70a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 03:57:30.9576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guzyeQ8hK2hTXUINnR3XC+vWZdai0Es2NBvyNOKx9KG+yfB2m2w1/J8USfOyYp/N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Thursday, September 28, 2023 11:46 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: Fix potential null pointer derefe=
rnce
>
> The amdgpu_ras_get_context may return NULL if device not support ras feat=
ure,
> so add check before using.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index cca3faf4dc23..60f8a18592b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5391,7 +5391,8 @@ int amdgpu_device_gpu_recover(struct
> amdgpu_device *adev,
>        * Flush RAM to disk so that after reboot
>        * the user can read log and see why the system rebooted.
>        */
> -     if (need_emergency_restart && amdgpu_ras_get_context(adev)-
> >reboot) {
> +     if (need_emergency_restart && amdgpu_ras_get_context(adev) &&
> +             amdgpu_ras_get_context(adev)->reboot) {
>               DRM_WARN("Emergency reboot.");
>
>               ksys_sync_helper();
> --
> 2.25.1

