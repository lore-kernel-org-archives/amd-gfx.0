Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211FCCA0EF8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 14:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD2A510E9BD;
	Thu, 21 Aug 2025 14:56:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e+PUT3W6";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8239310E9BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 14:56:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uh2i99TCjOB7RU83o4ZrsDuJPcvBnbxmYYQWrAo2KhJV6d9jhrFdu4rK/FytP9pNPvIMR3aeZ3ZxHgxehK/WwdfORyXA4Yq9xoeY/V8uon3AHSaeOOlQNlP5HhK6PqcpWYIEcB2SxS2fxsKpMTDI/wvQN3g9ySibBk5sNUwkclC4adgnY3ImeRIJlWIG+7hv22h60Tf9MW5B+662VEG36MjzKDAbD6KUnwvKo1N9/0f2nE/mMDuKwt/FgaOh0ERvx0MYzUHEP8W+GCtWkwLWAEcDGk4bfUCCkf3sblBUdQ47jCuDctO7kvzJDtGHBJFMXKDZTWd20FHrSrIUihfGHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fesfBlM89FSbQMAztNInqrZ2EZBQ2dz7IOMt3X7s+bI=;
 b=snO4muFdsS9SImyg2npMhhYSlbBfz9sidmsOumYknjQMV4FksJTlRFmTh+denpkDh37ueWvGz3VEq4xsHYI7pH+yafMcaKl/0RsLBY1Yn33h8RXMfRa5jgXQvsrkHx+MRrLa6BoATib/5n6iH+dZT4iDH+Fe6vSGP2/BYK2EPSuqzMYXvvyWcy96d0HN/NAQi91/1KL18M9Rb3qcaUdiShvO+kThB5ERuKsYa1oADpJNvp319jrJAvmUMy4BHKMg73aopYUtNv1t8vb9u6fIQFiAwM/Xx0oHDnAxqV+rwyx7k3NCX1998kVjz8uDfZ+O2e3997zKsXPWCj38niIo8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fesfBlM89FSbQMAztNInqrZ2EZBQ2dz7IOMt3X7s+bI=;
 b=e+PUT3W6Vk1fMAhxWASiWOG2fnI8b3gRNn4wRrjxX4SvZCYQUqmnSxsYJko3DUJLTPxJP0ObE2J3xNWzCO0TfG3Bkd7ZE4TDtgKnw48A6ntHwQjnNl4LYduYtdgIuJaD/jaYE4+Y41GnSwwKuAecIusbzE5QLPMisPhDnecKDxU=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 SJ2PR12MB8183.namprd12.prod.outlook.com (2603:10b6:a03:4f4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 14:56:23 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%5]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 14:56:22 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vcn: drop extra cancel_delayed_work_sync()
Thread-Topic: [PATCH] drm/amdgpu/vcn: drop extra cancel_delayed_work_sync()
Thread-Index: AQHcDIm0MizQmGchKkKyGD5o6LQv8rRtPhmA
Date: Thu, 21 Aug 2025 14:56:22 +0000
Message-ID: <DM8PR12MB53992BC686754762375A0499E532A@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20250813193658.2444953-1-alexander.deucher@amd.com>
In-Reply-To: <20250813193658.2444953-1-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-21T14:55:08.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|SJ2PR12MB8183:EE_
x-ms-office365-filtering-correlation-id: 2c0ca87b-a2cb-4f4c-d2e4-08dde0c2e512
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lrjozaCH5X6EQ/r1rTH8rxuRxQEciDTTCoVRabLnfUYyl7UtBn7Q1m+MBJZj?=
 =?us-ascii?Q?qaYR914uvtzeovaJ6ND0hqkTphS/w4KDyddyFIquFqX0T78hty3YZ08UnQTS?=
 =?us-ascii?Q?HbmHbdj/OJTD6gK+QhzX5ZKvhv4QCsuzRlUBUMbjxuupcCxbIJG0/MfWnVcS?=
 =?us-ascii?Q?fVA24D33WcDSHF6kQ8KHUIKDuYn2nDITIgB8/rfX8JbMlTjEjuQNtJ629Bj8?=
 =?us-ascii?Q?ZqpoKI1KvefaP9W54FdnkVW/dFSS77BRmg0W+6Bz4lBlvqWqsgk96udGVCz7?=
 =?us-ascii?Q?itHTjBxUR8+fdUWr9Fz+QEFSG50FoGmW/XEJo3BgVDboEBeB2uI2GzcWsebn?=
 =?us-ascii?Q?2hh50kN8RFCSN+HXnn9GMv7ci9ZmLEvoWctVQQbWRbQuhR2M1JgdbdCFAafr?=
 =?us-ascii?Q?Fn06VYb1n/SWdKlYYu8mruxVyOxEQKb39wQuxW5rmhdJJAZPEiobR+Q1bd2j?=
 =?us-ascii?Q?lR4Y7+Z573+JA47hBwpwD/Ln0bb2DxzMVAggj/mbkGSTpq1CRsNq7TJRfsw4?=
 =?us-ascii?Q?3US74UEvEnbf/PPYQKl9Wcia9Tdmsu7LFYKZX8c/rXDFMvYUXrYHa/4DNKjA?=
 =?us-ascii?Q?2PWqFck6PakhetavJhKzUOSHICeIW6FQTYuFTTju2Iz/tuQ1Oooxl0pVyqSh?=
 =?us-ascii?Q?WxQSDAX3JoJ0Ut4UknqMsSkYKGlYZVbPJSDKcdL2b44G8F2imcphVk66V6pp?=
 =?us-ascii?Q?mLJ9ovYruReWOvbrGsUyiC9fwgc3yeg7cWByAWscSe2KhnSlb28/yuv40jWE?=
 =?us-ascii?Q?EXrXRtv3QHsQbrEcWZ78gN9CduKzaivpl4BSWZTEa1jxoRVa6xBVmsWtwFrt?=
 =?us-ascii?Q?3lT7wEg7gIZ0ipMA7PHEHL7GymLgFyB6SMZMTiKVImUlOfP/DHNYmxnIrlmx?=
 =?us-ascii?Q?0smpNlk6M9EcbIXhLusLoU6zvDyE0722+JDk7OvzT+flTrqBdRCVphGB9pSu?=
 =?us-ascii?Q?oIye77i6gi2m9oBeUdUq4oT3uVgIBZEaDnRY5BWBNo3wdHSrPLfrsgF9nMUV?=
 =?us-ascii?Q?q11Z3D+YJgW51AI3Fg/rBecTo2VYjvN/MwGxE9g1E5g8pZxgnjLfLwdh7Bc6?=
 =?us-ascii?Q?NMsst+mYeRoVhnBNZntnJjyQyOV7KM5zawp//KakZyqQAWZT3GqRIEMA0ZNu?=
 =?us-ascii?Q?U21WfE6NWo+uY/6/3OBfPMHP9G2HJgqk9IL3HdnJ5kCvTyCQNfqgfs9ucjPL?=
 =?us-ascii?Q?GzE4x61ICfCxG7ybAFyTdp5baWm02N8arlbcUlcbDmneuvVi0kFPE3QMBsQF?=
 =?us-ascii?Q?k3/30nQiTKJi1ZxduB21P9tw/CBSilxJFySTOdR2GtrxuFgeCED7zkIFQ0LV?=
 =?us-ascii?Q?14AvEh0T/QiiquR+9Hp8c2l2cpGvmwUv3FXreQFjIYtTp7E+faZtNQ6vaaUS?=
 =?us-ascii?Q?iWmFlxkKLRbdx/PwmREwwccj34MQF1w/M2h1+olit0ShEExN/3KWikmzVt7m?=
 =?us-ascii?Q?+d9Z64eKiUL75enaVXizPjjE0d7JQvp9kWK+0pEZlZPHebsg7L+0Lw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(1800799024)(366016)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4HgPoWIUabXXx5/srbevtDe0cznNse6QP2ql7MuMzVLSODjoITbiZ1N37nX2?=
 =?us-ascii?Q?7jTMm+y5ZW1Kk43o8E/lXMU+gWrWMMQmedKY40iGxaGdhDwlHA6v5zSjkaXZ?=
 =?us-ascii?Q?mwgfhQLq6dFQBJJMWBie+54UqD52VJ+dusIFzjovQnqfK6yArx45M9TJYavE?=
 =?us-ascii?Q?KlJKpGeiwHb1Z485Ov5mxEMbpvKfxmuyHWoSxQzdPwrFVOSD8Ijk6THwayQv?=
 =?us-ascii?Q?PgK0wuABXuVoNuw0ExKm34tP8lolhhHRLf7BKqXo6N7wiqhweokPjLk8zZTk?=
 =?us-ascii?Q?Q/mkW7ybtqGEO7/jlZ1WZriMR6NwbtYFbsQnkS1LgXkFYGDoevp4opDgPtT/?=
 =?us-ascii?Q?zLkNdWppP3t/ypjIBXQvbltuSms6PaUZLEiJIkDY43CgCPURhlp2J26W4hpy?=
 =?us-ascii?Q?SOwRct4IoHK2m1Rx25Rz5pGVOaCyYXW/Zoi+1OmGfz/7bb64vkwcCWNxMIYs?=
 =?us-ascii?Q?necTwt1zJqCybi+Y6G/c+n8ObQasXQXTUVq8SCeac6stwooWrtu5SmTcSePN?=
 =?us-ascii?Q?TJfWMumzCxtKpJ76NbQnlBLlu2UvJBaiFKZINIAJsZD6bem6QRSppBUSW5Ez?=
 =?us-ascii?Q?blRuoxHvXjbpTLImAeq4FbGCkjrqKuv0dmO9UXw8NW+lgpd+CgWlmsy6o/rD?=
 =?us-ascii?Q?eLZmIqhqvp0GNZyDNxCJ53D6EePXWY9AddXIgjS4FD//vDZLBlP3wrAkFMbY?=
 =?us-ascii?Q?h7ShIXp8hNyFnczMFEzbB2Zc4yIx+ZRpAiout2aRp/W5J3ySlN3AHKCHJfV/?=
 =?us-ascii?Q?fvrpWHXk984D6rMXpPOUlPiutNvVW4xUo9p74keWa/JB0YMGgTds67apwNJf?=
 =?us-ascii?Q?one2dGcMliyrnC0tpOcUdEDTzlXl73GwJQSFr7oJnhU+g/HkflGi8axKgpqd?=
 =?us-ascii?Q?jHS3djD0Sq9j+6OBjd+JvlIayP7OqccAxfCs1ZSUPVD3IqcHPVTFt/CaOYUx?=
 =?us-ascii?Q?p5GemwxNKeVIrfnHfmWg84uhplwgxXcqlMUXNrKdA1lOuH+OgCpjuWawisJD?=
 =?us-ascii?Q?2ssky6trwSxV9GlXtLFMAx0aXCESU2vyariSAwwcDzNCzClU6jSOmi24nwTI?=
 =?us-ascii?Q?j+qJy21EPkN6pR/N1QlGc7bVIkLl29f4VJCxYPzvQ4XrcgvNYwjVB0l+Bw7c?=
 =?us-ascii?Q?BNEYKh0DJAOeGd2A6l35Ja2dKsdrxU/G1BA6b+Qrr1F/bw8MZWv7DY/V5kbT?=
 =?us-ascii?Q?vKt17JeT8njPffKFNY5pqWXwRvG2KRbwrjoitzSu4+NgXxXdgqq41ZsMBhlY?=
 =?us-ascii?Q?4VQvBbCpWuSZQhgzgy/cDzpHknTdfX1KAnExNa3swE6k/2depExBV50AvfSd?=
 =?us-ascii?Q?kLnqZcEIwLWqdCHKq2Mex/8JW8QEeksptRNzejEyM9eHS/aR/gBPuweI6oNC?=
 =?us-ascii?Q?MDwiIKYV+P4U8KJ4hJhL4Iw9OawpGsoL1KkrOOXcRGrxYvuQX5b2R4ogh+Ls?=
 =?us-ascii?Q?8Sx64z1wQLzK04QG5YXG1AGH6XB3w8N0/cTJ/P7nQ3lsLVCrf0VWFFNvVkC3?=
 =?us-ascii?Q?i0/1b3bo+acGVRI4TLWyFMN1Mbypnxn2k+qHflICNydLj5RDIDay8O96YlpR?=
 =?us-ascii?Q?u+WMdixhdJRvIKiRcsE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0ca87b-a2cb-4f4c-d2e4-08dde0c2e512
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 14:56:22.7900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RlpOVWZWURwXS/NsBBXQgsD9uyY7eo0Qu0evGAbTnrU/hKai/W4C6qc18S8V6eZR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8183
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

Looks reasonable to me, the patch is:
Reviewed-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: August 13, 2025 3:37 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/vcn: drop extra cancel_delayed_work_sync()
>
> We already call this in the hw_fini() methods for all VCN instances, so n=
o need
> to call it again in amdgpu_vcn_suspend().
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 9a76e11d1c184..fd8ebf4b5a824 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -357,8 +357,6 @@ int amdgpu_vcn_suspend(struct amdgpu_device
> *adev, int i)
>       if (adev->vcn.harvest_config & (1 << i))
>               return 0;
>
> -     cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> -
>       /* err_event_athub and dpc recovery will corrupt VCPU buffer, so we
> need to
>        * restore fw data and clear buffer in amdgpu_vcn_resume() */
>       if (in_ras_intr || adev->pcie_reset_ctx.in_link_reset)
> --
> 2.50.1

