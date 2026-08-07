Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC8AC5AC80
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 11:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6EC310F46D;
	Fri,  7 Aug 2026 11:04:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZFviG0BV";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D00210F467
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 11:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsZnVnxy8WJGHn6wxGz6PQGwVeBoXr5oqbNZWj6S2C8HbZvI/PKb9jhuY/kiKs2JyvNhuGBLFaPJmkjBSf4xPhlRoCf/95KgxQxR7i7qsCxWl/9THnIvE5vIqAYm3DDa+EnfMnTOxfBRCN5BVlVAvjvH97vu2dRLcpynMNkflUBArKapQiBsqvj+RMpMl3nyXc3s4CRU1CwRbH7aGcrfYItzAQb+sKH51gD7LY9/8x/A8cLNj4gvyi6QoUedIIctb9tBEsO58SykI6gwbEL6g0jz2un5arXPaU0w7E1OiVlcmIcWRW/kiX6OGwyKJZFoJkCFJc+c8bfZdcQez1Rsbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oww5DD6Bp5+bjP/oJBIdqZOj6rRWZMkbKvO81GRlEVE=;
 b=Z8l7IyNu6leeVr86OjTKsUptjp54nDAVRtF824+JQ7iXCjCNDcp6hEprUlP0+q89U2+3oQjBgZa5pTaYKh59Sg5Gq75UbQDABzpo77+yj81b30MYkZ5dSI25b2gHC+/8BL9xInFJBG7mHQ9CN1eWA1HVIBCNM1Of+efA6QePbdkTHmRTJFspObLSlnddEY0jeQpxsDyEnUvboTWRI77pogTa8+IQgWmRQsOSWVkVgRK6vyTI1ZyICJXuVoUD/NowdCzskl2+knUOVpqvTEmtOQmeajxPQaj6ziejQsiPH+MgMjy59NBg3wmDaC/ZscWdFvK8TbIyFVKz7ie66bTWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oww5DD6Bp5+bjP/oJBIdqZOj6rRWZMkbKvO81GRlEVE=;
 b=ZFviG0BVPE/g7OXLeXvFPUsbUZMPUFCPFIXmalukB5KrnHGWU2DYTK93cR3o1CB4vFL1XN/rqR6eWqK3PToguBHyWj9WCp11YKFhSRuXix26ZlWvRz2kaSCUbjjLiLbYrEy7DI1T3SWfP1qens6LODmuq6OJe4kNkU5kRLV7ysU=
Received: from BL1PR12MB5127.namprd12.prod.outlook.com (2603:10b6:208:31b::14)
 by CY3PR12MB9701.namprd12.prod.outlook.com (2603:10b6:930:103::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:03:58 +0000
Received: from BL1PR12MB5127.namprd12.prod.outlook.com
 ([fe80::2760:8b04:f874:e077]) by BL1PR12MB5127.namprd12.prod.outlook.com
 ([fe80::2760:8b04:f874:e077%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 11:03:58 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Prevent RAS injection with lost bus caused by
 DPC
Thread-Topic: [PATCH] drm/amdgpu: Prevent RAS injection with lost bus caused
 by DPC
Thread-Index: AQHdJjrGOPu4IGQB0Uu/e1xrPhHAOLaSbGaw
Date: Fri, 7 Aug 2026 11:03:58 +0000
Message-ID: <BL1PR12MB51275948754A7CEF1138DFE1B0D12@BL1PR12MB5127.namprd12.prod.outlook.com>
References: <20260807070237.1169684-1-cesun102@amd.com>
In-Reply-To: <20260807070237.1169684-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-07T11:03:51.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5127:EE_|CY3PR12MB9701:EE_
x-ms-office365-filtering-correlation-id: c895b611-b9de-4488-7dc7-08def4739472
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|18002099003|22082099003|3023799007|38070700021|10067099003|11063799006;
x-microsoft-antispam-message-info: jIoeDONjr6fj9am2Z9EpsTR2eyLjeVLCz/uMDz4emKOK3MgZ9uaCnShFSpnkJHDlLMPjZ5SYdihHSX6XDbWveUxnZkzyac083bAk1a7awRlcB6xjNw37J/aCyhjZ3BJFz+NhQn4l6TpfOn/DMGY01RbkdaQLL4WzWUVpl04Wimsa9YMIRR2PtH+DHWeDugiF9Dgyvog19uA+rjejAGSI58E3zz3buMr7ptU8B6j7y+FDc6Tv+Ip+5ZK/RkaxJl3r8UXRT+hk+HNHJHKe/7YIWsO3uleK6ol79VTsrF0wVm+tnR9Hhto/ORqJK1rBqTeGv4QMtAlR2Ne0CJA/sVHx8FlLC2HOauxhIvIYz5hqh5S1IYuKuFYrpdwTjYF2qB85qy+f82mZmvHSXI9m7BmmDiaRZvQ0cYr/Vk+zc1GonTKnJA9KtJSsbVaR2WPYviAPCWeLsc8DSuWWomOGcgRoOv4yIwluCMCy/mhspX2SSjvM/FJ4ADHyptJincaQocAtqmC8/1WmI3zDr/HY4Yc218DaW/lEp0pkaBGQZz3iF9RXqTwMcpO/7/0USHXswNJCZ4askttfamz3sCALAOIP8mZH7PJ09gBrpeBzuWsKcclBr4b1QeVnRAi5CdAJbntvDmKFZ8ztUi2zVVsVTVLz6SkF8FjtXiyLBgF6BBezM7JxH2XJBW1gps9zOY6Vy5HJbJSsAbpJ0WVq/D4GghwNOyHkLbxgVEw8B7nWRZvA2Xs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5127.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(18002099003)(22082099003)(3023799007)(38070700021)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5cSQLYEE0tojQMQTFNTM0lKnyo5UsyK/NYUhhBMKcKvdf4w+/phWd1mfZLqK?=
 =?us-ascii?Q?/UZvXrnvGxqwZhI94UQ+BetsIBwvhfTOCUxWZ5Ba1iShIyikmkfn2BfWU8+1?=
 =?us-ascii?Q?9YTPJH4vTXjdz9gDg92XmLhxGTEuQvsV5ay5KdXu1i7N6HSV+VphOd5pQZ4V?=
 =?us-ascii?Q?asP6ZedEs815LQ04dO81ZdCv6So34vHvRHEmhhVZqdkaKvJUYlndETFxEKUC?=
 =?us-ascii?Q?8OI2R0ff7jRYBOXuTwSTXe86ZTFBwhHBOSp40ptx/f7vGD018jK9ZS4pTyTh?=
 =?us-ascii?Q?XiCMBGozEOMGB5hnYRwX21DsuIHIboa3HePGLQujZt6MlBUUhecBFIbiOJI4?=
 =?us-ascii?Q?XfC6Qd42Z51MMBfK1A47wokmDzIJuqp3Ra/m2ptufgjVT/nxHwt/XSzHzRVI?=
 =?us-ascii?Q?Zytv2xQoSQbNwjqOJQVcWKW+Khkgggm1ewGx1j19pWip1AK811RoCCN6B1iO?=
 =?us-ascii?Q?6X1ICvPjwQHV5Oi4Tvb9cpavJqwA5OwC6M9SPxJHxaG+O+ek/nDi7yXY7wL9?=
 =?us-ascii?Q?Sl1umzzi7dAF1mosm6Wbyu6tRXWqHTPPtzZPnSRZ2/eI5f17nWLNEKdvW78b?=
 =?us-ascii?Q?8VoMYFbGnEhUbdhOt+bMZRRUnPp4nRZphactNtEyjJBJpj+Lzf85ocLmilgO?=
 =?us-ascii?Q?/edwPmr+i2QLNsGowgVaDXqNnHgi7gfG4ZBbY6kOsX/dky7L2MfXSBuOD2b8?=
 =?us-ascii?Q?fgTl3B4tLRn2Y7QxNADO2lVLnHipjnT0X2hmR4st3BwWXCui51azhxAowLbX?=
 =?us-ascii?Q?pZP6bV0jsu0/7Yy+CeDTmvYUAb01U7pFxhdIrgl5LAmFEYuPRW6QSkzyWupH?=
 =?us-ascii?Q?RLDqFZvzIlygNryGd73SURjggnqC8moVsUOFxUBUckhkJnVzmTQxIFGoCrRU?=
 =?us-ascii?Q?RnPYEmOQ6kIDMDOuoV06rPwZYTu+gqysVZadcd3bplKvilph1laZCrQjPPdv?=
 =?us-ascii?Q?sK3ZJ+pJmMOs5RGOMcTg6Im45xcABZ1ANV0V5n76ywDy4SvHtLE6pCIwsj5M?=
 =?us-ascii?Q?YxSO/x9/FbA3CPET0ipoEEhpGDMrFIhRXRF0IQVMh7G3/c/52HWWyzdQ2wsy?=
 =?us-ascii?Q?w9YIq3VWxKsA7rpxc7sElcjBUQYajPFpxFAdqPDUJ4EpqW2yEXin8ZgJqxvc?=
 =?us-ascii?Q?T5+YRZdFKo2BRKXnc0Kw+i9/td70huVaMtqEQDO9yHEfbyGJzDJwm/892PTJ?=
 =?us-ascii?Q?F9ib9QOLxY025j0cfxAsi5U3XUni4wydLZYCFiWLf+7YQnNVkjW32nncTY4u?=
 =?us-ascii?Q?rac9pKaCZrhQP5nqZ9t+LDZGNUapl6G8QDNSfUrsTH/k62k5I3h1fQyi5ehe?=
 =?us-ascii?Q?kGtxkI7ScL3sbM6CcCGAmmGfmgo3pV5u3W2ZVNHx9X6+ggkObdRY4axUn4U7?=
 =?us-ascii?Q?vxeQHFlDFY7xTIu4Shst77tq1DcLY+nO8pNPfLgdiC4GsnAVXQJ7pXTlOyqc?=
 =?us-ascii?Q?nbyz1f/kJ5oa4kmoY4LoTLiYKNv8yIIGZqSzTN4V+EE94YqEUxoo+S/gsUzE?=
 =?us-ascii?Q?F/YixmT900qsPczhsm7x676QGuDrIxjoCHR98S6zesjobGlcnDekQefI7kyq?=
 =?us-ascii?Q?DBfTlqCZzoeStt3l2E4nrqPErrgu8+7DieP5MsQgykoTRHhnrsUfFEDcWTL7?=
 =?us-ascii?Q?CwetkYrrcEJ5yPTZrHfLabYNM8iiqCftjdTxN1RYGnWJDBRnEmzxUvr7OAj2?=
 =?us-ascii?Q?WsYf+/Vfqg/t9KpK1fqkpvPt+bxV0gTpF83sVDb6nWaVNWA9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5127.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c895b611-b9de-4488-7dc7-08def4739472
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 11:03:58.1861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2i+1pTTdiaDCc0XbfLj1g+InsPER+Al/Xn754KNKDhpN5kZqxxNrdY00Shi0P7L0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9701
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

AMD General

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Friday, August 7, 2026 3:03 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Sun, Ce(Overlor=
d)
> <Ce.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu: Prevent RAS injection with lost bus caused b=
y DPC
>
> When DPC events occur, the GPU bus becomes unavailable and all user-space
> operations should be blocked. There is a timing race where rastool may st=
ill send
> RAS error injection commands to the driver after bus loss, which leads un=
expected
> failures.
>
> Extend the readiness check in ras debugfs write handler by adding
> amdgpu_device_bus_status_check() to detect bus lost state. Print warning =
and reject
> injection requests to notify user-space the function is inaccessible.
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 35eb87591740..4943be034c80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -564,7 +564,7 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct f=
ile *f,
>       struct ras_debug_if data;
>       int ret =3D 0;
>
> -     if (!amdgpu_ras_get_error_query_ready(adev)) {
> +     if (!amdgpu_ras_get_error_query_ready(adev) ||
> +amdgpu_device_bus_status_check(adev)) {
>               dev_warn(adev->dev, "RAS WARN: error injection "
>                               "currently inaccessible\n");
>               return size;
> --
> 2.34.1

