Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7506C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 04:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D57610E0A7;
	Mon, 13 May 2024 04:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LgZvFV1l";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C401210E0A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 04:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDt6zfLC47cyvuiuvYTWL6MuwLHZNhQsoWsanfIt5zKSltxHnrQD2Hir2LJlKiWuqMmE6xKcwei7XS/JfGzHy7Zsjv1sxrrRjYncl776WTj/q1c9pEj53sgpkp/5p6Pd9qqGDfkLIIqsfUxNJDvHefOD3jCpBYQ2JVb7M2z/ulaC5qbluo30jYQ0wGDj97rtGrcYo1iOVBWmLHJCj+qf62fWKwFcJ9dXk/rItOzgOeYoVNNGtT377+Oz27Rf3EqNvkeoKpzRd4SmxUP/KsBSIWPrADJVzKac9w1qzSnsZt6+svTuW2DYX/b3HT8FGMLL7Exxw1uAPi5HVF4jeX04iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3YRIXJ18eGLbHks16bHPnKF8g7eYZK3pk8SNP8CS68=;
 b=QTA7Yx5Kg0BH7vF9nYRO6YLtRw680H10/ZDPMs5cgrZDGC56wmvtB1v5g5AEgHotgmTmDIuTYDJQ8Yy9nCWuA61JZmi42SPF7+P2vbuqBVYdpifBkyvWg6kSLxHjoq1cd8AWap+g6BHN4VI6XS0w03VYScCzHQV8uSEVR5XheTljyx6yvySpjgTrGC7gws0zXBkGWUF8d/TtNlGvVeWPd+7NDl/+JIJ05Y6XdcZy239c5TJwBPy0mTxxSS/bi4acnX9CSBRkYKS7NnnOhGZw53sHjv6+JL53zpnwQrZEkjJte2WwxjOwaHVMc+CO+BRR8gZzobdXjnnf6la3wrZfXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3YRIXJ18eGLbHks16bHPnKF8g7eYZK3pk8SNP8CS68=;
 b=LgZvFV1lbDxpj0YwlB2IsUiIJNmH6rImprPU7KWbF56kgxoQog8MVkx8UbsJtB1N7mhNNG8ofK+jIqVs7pFf0ecyPj1QysRwlMRS/LGFjAJ+Am+dlCbFcVUd1jKE/W+r0FUfg6vqrodSjETC/BVfu0S0Y0RRI8sGrE09XVTTSvs=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 04:22:57 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 04:22:57 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 02/22] drm/amdgpu: the warning dereferencing obj for
 nbio_v7_4
Thread-Topic: [PATCH 02/22] drm/amdgpu: the warning dereferencing obj for
 nbio_v7_4
Thread-Index: AQHaooTphtcv6r/5kEyqnazHcUSyP7GUcpCAgAAU8+A=
Date: Mon, 13 May 2024 04:22:56 +0000
Message-ID: <CH3PR12MB8074AB04B60B2F902E41EF64F6E22@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-2-jesse.zhang@amd.com>
 <DM4PR12MB515226FC7F4075DAEBF4197AE3E22@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB515226FC7F4075DAEBF4197AE3E22@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=00c36985-9675-48a3-952d-01f98ca7c697;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-13T02:17:58Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|DS0PR12MB9276:EE_
x-ms-office365-filtering-correlation-id: 1bdc8e47-d30e-4c2b-1702-08dc73045dc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?XwgS/ISaw+vgO39QyrqzovGlAMzkdRCiZQhYDPBNCqvfzOnNz4vjQPFdm/AC?=
 =?us-ascii?Q?Kk1RgX6GtjOGeCUrFlhsRfKQN8GScxyNHt47bBKroloa1R8AwwluXv9qkeEV?=
 =?us-ascii?Q?c/X6lvoOPRAF75FUC4G1UJ7KO8nTEVBUU96nbJvBaW7iBRpWAe3x1s37fZ8n?=
 =?us-ascii?Q?AHfP3GmF68HzBAhvK7e40/bZC6q3GM/uls+JhAhTKrXw5wK1owMBN53MdZv2?=
 =?us-ascii?Q?PIusXbegwEvjv6dsUALN/4m0hGVqmrwSjXgEGQG4y3GOlycIog4dBqeSll8m?=
 =?us-ascii?Q?ZJdQWcbmnN5TNVdnaBhdaflwwXpHIE5YIWT9TmgTzPZWUrncjDvZvsGDqvG6?=
 =?us-ascii?Q?EBWgTetaulpmBFvQ3x8cNo+DFDWo1IlimEYc0v9JzJjYJu+n1ey5g+M3758Z?=
 =?us-ascii?Q?tnBdTguh0ZF9TxS/txJvRfkg6fc48+0zeMOWmcQahLSgF5c07F85c66kw1KG?=
 =?us-ascii?Q?EtORjtOz+3geTXGJfJPT4c8tKdWq9CJZT2N2xLq3cn935j0JsGzpar/Tza1a?=
 =?us-ascii?Q?ImWUF8OqiuxRdGEOg7olTaxAtOr3gVOlWRmpDkUWDYBW6Q/57e4U0UEkvYci?=
 =?us-ascii?Q?d5y4PqUdSjytQwmjNLkRlBH24eN5K9RdvVSdRSdHYhnhbH3vutsKhi28HwVv?=
 =?us-ascii?Q?8u+w6BiEpYxnb5VsLSINBzFE9oX404RBgjEozeSZtMQABEJXxGZpm1IUCEky?=
 =?us-ascii?Q?Rm36Frq5JJVWCswr3UAk/wVkMCGksvoZJNzDlmGpvXcd18lfAakzqQCjVUxq?=
 =?us-ascii?Q?nxd2S3vKMxoDgK68RcBmYPXHMJX6EKbahzzLGwawitXuJucPVaKPTq68VVIg?=
 =?us-ascii?Q?5atLfRtyVBugweM8K/Br9gc4r7I4Pa37vgNgPIUk9pkMNp87XapMMxIGEJwm?=
 =?us-ascii?Q?Qrwcqn4AkU0FcB3TSsuUQfSAmLzvOkM1rrFg3KxrJYuT13Zsly3aax0nmFw/?=
 =?us-ascii?Q?PeMQP5KQdTbqSW3JtDH+1iWCUN6+Kh3BePtq2+1PKILUIBGxiPO2uaAKJHdd?=
 =?us-ascii?Q?U4IV3Vm9NveH0PPvjgUDVDeDuHjs6hd12ngG6aPFOe8vyEoSoT3Vnc56xwHy?=
 =?us-ascii?Q?fF4odO7Yk3XkeZVoV0HSUgNCW3IcoHXbVAm5EMkK2N5KXZeRf+PeEddr5BsZ?=
 =?us-ascii?Q?cXHVy1kUyHBzV1QWh9RFcZDh8x9LAzsJZLljFCyMV9ZKFj4jd1GxPfdbsaFB?=
 =?us-ascii?Q?7UBanAVi9oYeF9Dz1SrFq7+60GZafU3jsN17HWNdno1UACH0eKiUyMmSU/vN?=
 =?us-ascii?Q?6nmmOcXFcGvTFeO/iyFE7GtRAvqR/PW9sMQkJQlA3Oaf9x0moku2YifhIXjJ?=
 =?us-ascii?Q?QIA0ztsKZ6x7pBoe0sBD8Z8nI/pBZzapp11D3IHXH7Cm4w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xpZymH9Mer4s8y1nvmi2QrJwurfeY3Rev05Rz4a8p5ZtIhiZ2xzirQhRHKXC?=
 =?us-ascii?Q?38oD4Vhq8PbQ1vIkEhUrhXjc0/yknrxBpnlFwnRoAS5KSbfkIOHiWWyDks9V?=
 =?us-ascii?Q?wV5o0ksKFaN1PoNw8CBzsoSgFEla80lZZoJFJyYlUzA1FeUq8cBnoY2p06x6?=
 =?us-ascii?Q?DmVZhbZAVsb09/nMnVwwoggoWkxClzFzpKKDgGYCUOSotZMBRT/9efE19Sfa?=
 =?us-ascii?Q?cRGhRMkuVC3nuOey1peij0GQ5tJf3iyQkfkmRCl4As0ivzsofXC8M7igKhll?=
 =?us-ascii?Q?+GOqUZw61UG+G4wrlfewaB9do6Vi6ZQbug3Uxo/xcbi1/e+T2Wuz6r3flxDc?=
 =?us-ascii?Q?kLtMUL1TqCpWNRFucUUxaOkFyXKKMp6LSaQ79Yzr2ydgQ60OCyn2AoEj/Ld0?=
 =?us-ascii?Q?QAX7RgI3LRb+b9p6ZyY2HBsCZMZbGPS2ZE+7RHFHe3cICR8qkP0Q1rt2j4an?=
 =?us-ascii?Q?6yBD5Mkl2lkiSM0HieeoDLVUIZnRN/dh1GRS0UJcbRV7poZwn6PvucFVtdah?=
 =?us-ascii?Q?bjyADZis+fqKacKp4OKBVpVn5uujZARyNt7e7MI4yOGZjQTA0h2f4k6XujPM?=
 =?us-ascii?Q?7MMl2+qWcapZcmDY6rfkpSLDHKhwn06HQheQz2w/WjZraHv5RQKim8qoySzU?=
 =?us-ascii?Q?Sh3UuvcEKsQkIKO3RhDT3QJOjW+NOS90vStkpUgUM4FOyxGP9RSnOi/AKnaW?=
 =?us-ascii?Q?57dSdVGGcwpFl/zkuudBhFaWanqPmpzIbwRQATfv3qyAzi6COkc+Gxff8yAp?=
 =?us-ascii?Q?VWrksg6thq//6hF7CtUsNvRSpgKY0/s3eGKyJ24yAgwJNWqPhMbPWY3I6e9p?=
 =?us-ascii?Q?9w0/5pQgGnMLKHfBeqfy9+XfeCAE5bicgn0VRa/4jzYI1krWlsudBVLCXiXo?=
 =?us-ascii?Q?HlbVrG65PoVlMfXjRfRxjRBF9yCTB0Y0smjuXSifymiVgNYSPXzgFu5qAI6w?=
 =?us-ascii?Q?/y5p1T79D7hIOg8kO8+iSSuSVGwrEkmJaoxb5GShERb3u6POlec1pHXYWlDf?=
 =?us-ascii?Q?muQAoWfSszifzMqfLjrcu2J6Q7eAoMDmapjLWus0hAnRnnQKzpaT6MEGgYXy?=
 =?us-ascii?Q?68qVCPwy1Sxfe/nh2z5JZK1jBtRFVBGz52craAlTwnhVMiOJvSecUWmQ42hC?=
 =?us-ascii?Q?UAxOHKNQBqyk+IIV8jKbAt+lZwuX9sfvqC9MS1QZS0BhktEmfWD5Tt6gHVhI?=
 =?us-ascii?Q?bvwvteindxVy1fhf/iwdkvN2TLeraonLdjHJSJP0dXLmd+CIUcpToiDiOwDX?=
 =?us-ascii?Q?M3u5DUiD/ekX1nHyChL8MuANNgpTmhjshI8Q7+vV+anVpAbramqxaURWttuk?=
 =?us-ascii?Q?19fOUwWO3TVf/P++Dc9F40i99/9oIN66OArrNjwMaexpgQl8O9pf3yaU7/aY?=
 =?us-ascii?Q?B+nP29fy5to8mZlUgo7wD49Q+HTny9xUNi9/pWmHpGSBZ3iJ8lhA2b+h6FTp?=
 =?us-ascii?Q?bBhSqAct8/xUgZlnQTbbyc7zn/T6B9X5xj2kw4RCJLjKu8+UYIcF/wb7YOQi?=
 =?us-ascii?Q?MVqI8EmQWmFGE2o8smk3/D2vyYnYR5MpG9ilWByc6N/mimifYa53j/YSBk7Q?=
 =?us-ascii?Q?NkjBlq1nPtGePqcARwE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdc8e47-d30e-4c2b-1702-08dc73045dc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 04:22:56.9774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SCbMQoFarILsby3Cdy/L3qlP/NW0mwULe4+Qsvnhz2IyZXh35iio8DmhDuCtyh1OAQHMk1rbhKAwdKjEXm3JEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Jesse,

> -----Original Message-----
> From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Sent: Monday, May 13, 2024 10:18 AM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
> amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: RE: [PATCH 02/22] drm/amdgpu: the warning dereferencing obj for
> nbio_v7_4
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Ping ...
>
> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Friday, May 10, 2024 10:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 02/22] drm/amdgpu: the warning dereferencing obj for
> nbio_v7_4
>
> if ras_manager obj null, don't print NBIO err data
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index fe18df10daaa..26e5885db9b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -383,7 +383,7 @@ static void
> nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
>                 else
>                         WREG32_SOC15(NBIO, 0,
> mmBIF_DOORBELL_INT_CNTL, bif_doorbell_intr_cntl);
>
> -               if (!ras->disable_ras_err_cnt_harvest) {
> +               if (!ras->disable_ras_err_cnt_harvest && obj) {
We may need to check the ras pointer as well?  Such as change to " if (ras =
&& !ras->disable_ras_err_cnt_harvest && obj) {"


Tim Huang

>                         /*
>                          * clear error status after ras_controller_intr
>                          * according to hw team and count ue number
> --
> 2.25.1
>

