Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BB0D185F9
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A079210E744;
	Thu,  8 Jan 2026 14:18:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2AC4KONr";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BC0910E744
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:18:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSI/j///5xVx9o612gQnll8KLnCwskaNaU1StLVjBCwgodFnTy5XVlZNCzjuRY8/8Y22vd6AFrIP2Ixgpd4Qv4/wdtPYLDScbt04cQSd1b5en/ckGU0c+8bQq+RaxCZVZoUyM4zg3yDrnmNLr+Ji5br82aqdUZVd6pClp1pTlYbVx/NFmUUzKMo3nQvD3C8Tpy99hgr+XaBHnam2ozex/cAc2dqKzOmhb072JGkKvk2L5vIW00DZaIGbsSWHDz2cZyBkwo1QLWcLRPo8B3lfX4gMcHPKiryRC7hxpGU91Yxg/J2yTMxJ9rtcwj4aSJkf/ES0cSR3EksSMJe/+KKvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCFP+uKbBb4RV+eZRg84LFzWzTftb92qulLz9WZ/aFA=;
 b=yJ3iTjXrMTQUGPZYsNgS4BWpLYUU4bWW3s+uRJGaKazHDyI2yC+KB6vvpbiJLyGQPUCOzhCelOqGtSNnF1MqP2THzWndax742n6K5Bi+NnCMuzjpyFcuBd6lOQSEClkh7OsJ+d4JK58yhCd3u5ThqeEJ5cTtYVWPsB6eaIsFPmiK8WJRsQS+t21uRjFxz3fYd91EOtzF7ShwXlZl9o/4I0ds+F17WqQIyzpm9u8H5rWufFzV9j95lCZ1cpfBg+Vc4+kJeMPl0rOzzu+esnZayGVjcUIJIC0VfnhxQElD1WncR4b2Ew1yqXWhunhmFVCg+3pxb4yFG79O9a92nWaF4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCFP+uKbBb4RV+eZRg84LFzWzTftb92qulLz9WZ/aFA=;
 b=2AC4KONrdW7eTTHFr01qSFSDHMfTCOgIvB+4/OkFgX6xL4z4h1vkA6DP9cKMosQDK6P9RQEJiEEWiSC64J/kr7OzkEFlLwu1dOVFZM8NrR/BqnrvDFxaogn6OrHON+vY3cv/4BBoJSxvulnKqYqH1gKAKj1NRuDJLvYbK5E5ws8=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by SA5PPF6CDAEAF48.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8cf) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 14:17:59 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 14:17:59 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: Clean up kfd node on surprise disconnect
Thread-Topic: [PATCH] drm/amd: Clean up kfd node on surprise disconnect
Thread-Index: AQHcgB3YzP0KrbwVEU6CdnlK3cPH37VIUrKA
Date: Thu, 8 Jan 2026 14:17:59 +0000
Message-ID: <BL1PR12MB58987BD7E7F0605CFDEC2FB78585A@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260107213728.370011-1-superm1@kernel.org>
In-Reply-To: <20260107213728.370011-1-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-08T14:17:32.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|SA5PPF6CDAEAF48:EE_
x-ms-office365-filtering-correlation-id: 48329a27-07c7-48a9-0342-08de4ec0ba1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?TL1mgDxELZ3FCCAVj5cNHIzVeTjuw/K/Wivj43CvnYdB8/w9eH1dXetNm2o9?=
 =?us-ascii?Q?C/yEGCHRElJCEZ0Qksskxr7K2wkJ+xsighYTRRxPmeqlWGSug+dnSny1k5gH?=
 =?us-ascii?Q?EiQGF97D9M+k10YMQZROUq/bwgDF5tBzGB8JVMzmQT10e8G+tHMzX6dPQBNY?=
 =?us-ascii?Q?Z3lrXkoIRkroRIN0ijud2d6/si6KHsLpPu3UNYa9rFXA4CkOF6+8hZqZ4PDH?=
 =?us-ascii?Q?agn3zCvBjfE/J01AgEv4yncWpjPZPu8S4CHRe26zeerEajV9WfyLOIyvZnjV?=
 =?us-ascii?Q?sJPAtXBjwrM1lCo0GsepinZpFjj/xPoN2/0XOXnX6kwVjHPjjUTkvD1b3RQI?=
 =?us-ascii?Q?1di9bzNMLVb4zml2dwthHMYekSGNy1CI5hKy2jGnZb80GtEJn1M673oMyitM?=
 =?us-ascii?Q?Zra7pop0KfSwBGBs9Y89OTB84oWRp/imEDMUklnZgUpILYlEC3UwAevRVedd?=
 =?us-ascii?Q?lkoF4dJn12HcIzGu4ZscYoiGyIqPd8QJqjN2pRQ5DHVkYjJRPXqV0O3+kX7s?=
 =?us-ascii?Q?m4/qXcuq3QLUMH0NPru5BXNMK8nyQu750LeS+gETwj68bp6rvhPQpF65osSS?=
 =?us-ascii?Q?K6cgl46vpPESaABxkPGMiLS/0Pd+FY2ZToFO4mWnnn5Bn1UMrvs3jnceXwe1?=
 =?us-ascii?Q?YftDDCSM7qe/ha/gDmO168edVDFNsvV5xkc5hfboQ3fCFT+2xtKOdgRc50h6?=
 =?us-ascii?Q?xE2YZXQHDPlowtqagqMtjxPyp2fB0hoN8irYH1ZkxX0448RigOazHaEjUysW?=
 =?us-ascii?Q?LVUnJREwxsbfgrK5kiSE2dVhS6G6ecePw/ruqhyuTr+yiAViKA66ZBAszL5u?=
 =?us-ascii?Q?OEsH2zkfKLzOi8MZgZUS/r6E1GC8QrR4lNGjX91AZs+tszbFMphRXdo1wSG+?=
 =?us-ascii?Q?WgX5WqqXmhpaeBM/wUvgNbN62/6HaQlBPUlicJH6NdETzlSmbDc/h0XRBCnJ?=
 =?us-ascii?Q?xl2LOjd65FvoHuFxadGNKDD8iBc0aXIqEyxlVV0+zGPg6i6pgpybe1UkqG84?=
 =?us-ascii?Q?iE5LWGNwSnfg5go1vrU2ViLNf1kVNATM33aFxM4HXaHv3gWoHVoRZjyPoWC1?=
 =?us-ascii?Q?AU53Es1LCS6jwP/o9P99jwZIL+iWHtLOv8KQWtEIfmv1nA7VZ0MGj1kk9sNd?=
 =?us-ascii?Q?Ab/clztrhMux89YUVlehlauSDrrDTO2U1MLVyp7w8pQXvHhx75WuXNtZpZfp?=
 =?us-ascii?Q?VmHS0AaoXyX7Lxyk1v3z8SMR1ga6dnqEx7Y1j/6k07sc+GPTl8QuZrhTMhEs?=
 =?us-ascii?Q?iahWdsN8otRseyEgb6fukCnxrR4sOve5gOYtkJwRBRHwnFb5cdMJiOXlZ2Ye?=
 =?us-ascii?Q?LU5oiFGXmOwhT4CRaO8YdJNmxDWqqI1ruyjXtMkqeZieEdSH0kXorNkwTLiL?=
 =?us-ascii?Q?7HLQKcre5V1fGGN7YlwY36dazJ3hXVC5Ul/WVO9ytbrI5Gu0xc5c99dwfRzr?=
 =?us-ascii?Q?XFOBh53pLr90a0GqmV1Z+khKLdavbfYNL9b3D456aAwSmAdXlJ5+n4DiKCTg?=
 =?us-ascii?Q?7RVCgU8+ndifG0+T1WkeyImba7UxXL1gVfUZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NauV9tvuNkdg4fLcFflnpnfVusxqxOMqLIxgH1aCfx/zN48DwjJAgpOIyDrj?=
 =?us-ascii?Q?ZxWjsRnjvhM4HQGgpc0uSKhNgBs5IbZZNh6OToajHRI4j1/MNv8VFaEWUrSx?=
 =?us-ascii?Q?DdUyoYrCZnvj1JBPvn8DBLncs2+LO6afssQT3TLqnKeqKjODCoMEe7W1ZRdA?=
 =?us-ascii?Q?GFBCx0UZqorNC/kRY1uj42hc9KhGeViQDvFt6zKd1RkXiDFkhodaPFLPq6+T?=
 =?us-ascii?Q?co6rsjfvCwvZD5sTTwCmI0eGWnkbVq9a6gNTV3IUxG2yp01bgN0UFh55pb/z?=
 =?us-ascii?Q?KtMUqeaFvfamFZrgVaIJUG/RYeg7B0iLXF6ZcBoln9ipGg6nT1ExAq+W01G4?=
 =?us-ascii?Q?TYLvxCgGKrPyEcredAaE5PDFpnGVhDZWqapgHKD8tIHVRGCtJOHEjEpKkoDd?=
 =?us-ascii?Q?qoAG7uaBFqPCvcNHaYEAcHYiJVxZzLgO+jU11rpdSi8WX3+NI9VEUk5ipB4F?=
 =?us-ascii?Q?AGIDzIPLTt+vH3HdS8YfrkRDKwmtlUw/ft3403hHG0ktu6hutldbPEZ553yN?=
 =?us-ascii?Q?XImkqO6XBfuCmiSRQJ2b095meRsdE3o7jI/xSdHc5HsHc86P79x6VcBc0W+f?=
 =?us-ascii?Q?qb9NPTrgtJGggHyvpUcE6aOyBrk0rIbxgnS2ywSykoQx8ys814FEAIT7lfTb?=
 =?us-ascii?Q?V9YBg1vCJRqwp0e3vkScx6eGmTH/Juj+XS+SyfZkSdYrhtW8XV8iKTBXfItZ?=
 =?us-ascii?Q?BzBnuv41I7ynxXbsMm87mXXfpQuBnqa4pkk6R26OuLRGTBcmaXjcYqL07uuF?=
 =?us-ascii?Q?DzM6R8Xc5vuXjvm9EnJaKd4US0lJaHPdMrQbC9pJSMWYue8NsCHYOeTFli7d?=
 =?us-ascii?Q?PgLZ05eddVq6DcFEFJfl5Mfg1Lsz0hrGW615EvLd28SmDMU1CcPeA9TYc6fa?=
 =?us-ascii?Q?RiGvcnv3piUZzUBnLXPhmKW+R4owXbCFtuaNkrPKAVucnRI70AuKxRAkWyFt?=
 =?us-ascii?Q?Exg3yHKPSfB3K6CUQ/2wwU+iUUmvQnfksXu5bJ+sKibo4yCzgzAJfY9kwImk?=
 =?us-ascii?Q?P92pH4iaaJkCnDDFPigQd1P70vzaL+XTmMh69pgB8/CVtidXsaM2HAWrXL1C?=
 =?us-ascii?Q?6UEnT8Sr9qab/oAF8jy0gsfGJiH1ItrdXUaQYl9nsJpUWED5Lp/1bmBdskBa?=
 =?us-ascii?Q?gO0Q3McVBYeC2wjHxZk3ERn5FDOTV2vkjU8wtgRu0Y1V+q/zIAxdrWraCXvH?=
 =?us-ascii?Q?1xi7lyUJJ60VmP1z/fI7vKixY9YXudgwtAa6Psmc1CeAy6UTYI8V83oEkBWX?=
 =?us-ascii?Q?K5jE7RVqg9pwxhfHfPX1UWRfgLhvrQIhjmAoEf72K8L/XJxFEW/To7iXnktH?=
 =?us-ascii?Q?tyhh1+o/PIQUKi4EotlZFmzh0VxtAW/Drg/JkbJtXx4e44POk711jY6wo8xc?=
 =?us-ascii?Q?KJGODRtA6kxK0KAaCNSaOoua3+JFoz9IYG8aywPg1vZGFF7TuAEe8OMLDnja?=
 =?us-ascii?Q?Q97f78eb9R++kh71b1+/rMYUGg9Gyb6wnWSi0PkVvgHNfYQGnvOs/haiXeEP?=
 =?us-ascii?Q?h0MnQBOL7GjSixGYH/PonSEqABd8ICwobGm3LBuAgvvpByXGUQi/DF1t7YSc?=
 =?us-ascii?Q?BAvRokc0131lEE3UO2zf/Whpg1I37NGU2bobDl/ata26jdygTNa404ybEEj3?=
 =?us-ascii?Q?ICWG9rCX3bif6dhCNEacCBqRsn/tMv9pacpPSIqdg7xW3SsJA6pBpTueJKpe?=
 =?us-ascii?Q?J0r9l12LP0SwkdtIJvwcGOd2eKZz67XOaYCYXZ0GPPl2onGK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48329a27-07c7-48a9-0342-08de4ec0ba1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 14:17:59.6108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qN49iWJ5KerVq6gMOmCW6C4awvGdfvQfrS9FYqsSvaAik+1xFbWhizi8pLxKNkDGyWOgH/Wph7qC98GYJ9cQXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6CDAEAF48
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

[Public]

Looks good to me.

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: Mario Limonciello (AMD) <superm1@kernel.org>
> Sent: Wednesday, January 7, 2026 4:37 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Mario Limonciello (AMD) <superm1@kernel.org>; Russell, Kent
> <Kent.Russell@amd.com>
> Subject: [PATCH] drm/amd: Clean up kfd node on surprise disconnect
>
> When an eGPU is unplugged the KFD topology should also be destroyed
> for that GPU. This never happens because the fini_sw callbacks never
> get to run. Run them manually before calling amdgpu_device_ip_fini_early(=
)
> when a device has already been disconnected.
>
> This location is intentionally chosen to make sure that the kfd locking
> refcount doesn't get incremented unintentionally.
>
> Cc: kent.russell@amd.com
> Closes: https://community.frame.work/t/amd-egpu-on-linux/8691/33
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v2:
>  * Move the call earlier in amdgpu_device_fini_hw() to fix locking
>    refcount issues
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 021ecc988ff79..f167ba1b6ffcb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5251,6 +5251,14 @@ void amdgpu_device_fini_hw(struct amdgpu_device
> *adev)
>
>       amdgpu_ttm_set_buffer_funcs_status(adev, false);
>
> +     /*
> +      * device went through surprise hotplug; we need to destroy topolog=
y
> +      * before ip_fini_early to prevent kfd locking refcount issues by c=
alling
> +      * amdgpu_amdkfd_suspend()
> +      */
> +     if (drm_dev_is_unplugged(adev_to_drm(adev)))
> +             amdgpu_amdkfd_device_fini_sw(adev);
> +
>       amdgpu_device_ip_fini_early(adev);
>
>       amdgpu_irq_fini_hw(adev);
> --
> 2.43.0

