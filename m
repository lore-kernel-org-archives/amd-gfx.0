Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B9BC5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 19:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D29AB1122BC;
	Fri,  8 Mar 2024 19:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mwESakNg";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 519B71122BC
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 19:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWLekGg5j/CKnXAhTFCfA+w2+zoGdqTGLvvAvhX5aIVf2y3ZF12UuuAPrF7p3+O84xgDQoBZ8rxCv0swgRVL5enIfT537Si456sDFD1k2MjFxrJHTWni3SEyrN34ha8JHfqHj6D7y20KXYh2Wdt1JJnuf9IpzWHpBNGq6xAiBfoHvAmcnB9MaquQ8wp4smOz8wVtZsV8s9LulCvJJx9CIdLwYcYi6t5+UFhO5/hRKht7V7pIDt082S0cJCYAfm5N9FjeFHEWW6bW4vBQl5NUbU48uo9yyKdOpINe5G0eDoHtyMRVYmSBRDr3xuvN0+xPxXhhXQhzwJSqLG8FMllveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7DXHfkde2txu7gtEAObV4mUP+u49srpiphumOlZqLM=;
 b=ZX/qtY60DN6aY3+aPGCboN+/UXJ3THLgciGwa57YfFM+bC0KOOYcFcKBxjODq4+zBdgNX1TzzEa4gfGFnOCWio26foirW0la5RUVTNiW2kcpLx2oBgDIL5Cb5QUYlkNV+6evPFJ3WZjCPsG3aFOptsIKuhPcubt7aRPSuDxCubDm91foJD8xX4XvqVvQGwXUFyFkV7oV7b0G3RDv3f9ZuwemwplG5X+843nVfeD0n+Bo+yLhxVGpVaormzlfrs9q32oLsI0BvTc0R5UZYE8AXdfb6Q5Rf5FKoR10JH8bBBo+TpmQzAtW20rv8ai82SEX3oe7liKN7vIFpnRk9zdTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7DXHfkde2txu7gtEAObV4mUP+u49srpiphumOlZqLM=;
 b=mwESakNgqigPMk0x1prtMlRwjvxOV8VkORsax9HCXiCiQ59e4M4Zn+B04ZFIeXLzwFQRg/cWzT6/lU0ysmPAzGkU4wVbdJEeq613NB46d4PdPDPM2vZBBXp28CLM2NnWEhbNoXYgSSxB66wULg8bRUQtzDjlUTWYbkI3YqAGd3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 19:12:03 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6c3b:75a3:6af2:8bf4]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6c3b:75a3:6af2:8bf4%6]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 19:12:03 +0000
Message-ID: <1748138e-9551-4eb3-9ec3-dc577e34e624@amd.com>
Date: Fri, 8 Mar 2024 14:12:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Use freesync when
 `DRM_EDID_FEATURE_CONTINUOUS_FREQ` found
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240305205723.43651-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240305205723.43651-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0386.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::7) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|BY5PR12MB4084:EE_
X-MS-Office365-Filtering-Correlation-Id: 35aa08d4-f0f3-439d-16a1-08dc3fa3a343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwjXg562SEgswdrFoQ3irm+tOA4jg0rq9eEEJcCXu9DZDqDxp7bnKhKnWHNE9vm5XJBucDW24nofRoh8Lprh4u52KJpplQVoWTiczJRRwLIWamEG1RABKGN7NxiZbcuPd+DULhrFqZqAd3DXwXUvlQIcH/oT4IjB0tBv1UPTp9HOziFmpWJx8RetfkyszJnN9obRncNrAZZIctlFmolg6jiZ9IzSEzEtlbq2GU4gGzBAdIDNfvX+5kp9It3FxLS/wEqeLatrrZIrXX2njF82GCntgvPqkA2QCaOrdtHS3Y1IzjqTGYQiVSweD6TzXCXX21b3DLew3N0S7W6y3RMHnQZHHldwMY8OmCsqJFp+oBzj946UpwXPgP3O9RsNmitffgfNQH4ZziG7z6jLfC3PilLT8hokyYsq81vKw0FC7uy9nE5WRroASdJADS4ZgX+3/LMiCYYQQHrMfy83xB1lylFCVf0S40gX/YxcOntCxieVXq83jK5i3qtwi7g4irZg5sUZQ3qTnfmoo2ONzM2YTcKIEl3twefQBeYLt3+wJflVkS+y2L2gRA9o7B3/lR5Nn80OQMnZIc8cXUqQJmck/0Zb0/gmvucGXRhcBcnhb7ZbXTonsAidpmxNj8I1BvkA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXQ2dHQwdThEcUc0L21HbVd0R3NOTzhCSWJyeXRsaGdGZ0tkdXFxZjRGb0ly?=
 =?utf-8?B?S1N6YzFvK1dWZ3Y1WjlFcmFoTksxY0JGTi9CVXluQkdrTVNiZzhFY1lrMlpE?=
 =?utf-8?B?MXg5djFIZklGWllBVmVJb3ViWG5jVVI5anBWM1B2QnBWbVE2SWtIRjVzU0Fs?=
 =?utf-8?B?RlBSVVYwUS9JbEJEUkpqVHcwWUt2S2ZHR0ZBZCtRMUgwU28xMEtKb0F6TFdp?=
 =?utf-8?B?R3NBYlc0UlRVTUhWV2FmeUw0a0ljdTNMWVhrNkVLUmhlcDd4NmdqQ240M0g0?=
 =?utf-8?B?ZGUxZk00ZDVQWnk1QlFxbkpFSEZ3d2VKUXZhT1pGSERZdEVuUVYybFEwNE5y?=
 =?utf-8?B?MWdlOEpEMGtUckFrVDdnU3BVOCtsb29qempINzVwYWhaYnhsN2Y4VkZHelFY?=
 =?utf-8?B?V2xwUmNHRmhkdFF5M0pWa3liaU9TUGdYQkM1Nk9mcnM2TEtCZVNSN25iNUNN?=
 =?utf-8?B?V1FzQW9WRTc1bFNsVjhqVThaa2F4SDJEMDVUNmlDWVI0Vkw1UnF3MzdkZ25P?=
 =?utf-8?B?RkJmOFBNQW9XSU01UzZVSGxwcG5LaGFMbWxZZG1BK1FPSS90Y0JVZ3dIQlVp?=
 =?utf-8?B?bllRR1R2WER5dDdKaUl3bGpyMGF6bWxXUXFGTlR4UURjc3VwQjUyc1VQV1M5?=
 =?utf-8?B?QmlYSUUxYXN4VjArQUtaNmNBVWRaT2J2b21GcVVoaVphVEhGRS9LZ3MzQ0Uw?=
 =?utf-8?B?VFNlVDlwOFNwM1RPSmQwUFhkU3o1bk5pWkp6d0hoUDBWZzQ3aC8xSGc1djFk?=
 =?utf-8?B?Sm1zeHZOVnBUcGxEOTdRZHFHZlhuTzlxOTdKMW10UEFxZXNEUUhaNVdaK1I5?=
 =?utf-8?B?bEl3S05YOWZpY05iSVBMc0VYRTA2MVE0Y1RiSVRQbGZ6cjc0UWFDdEs5L1My?=
 =?utf-8?B?aE9XZW5kRExCWnpVMXdoUzJzVXlFeXJ2ZDZ1NFBKSFJMK3lnME45YUcvTS95?=
 =?utf-8?B?M0lmaDhheVFrbEx6NHhZZ05mRkE3a2h2WnJSVXdRM1doaDh2STVLeUxoNFIw?=
 =?utf-8?B?RWtJU243Q0szWmdhdzNZdTJ3Qkh0M0FJbjV0dE9lejVleHRZazlUVERUU1Nv?=
 =?utf-8?B?K1VIZnBRcE9TcHBwOThDWjEzZWFReG14VlRtWkgrTU1ZaVVzUytySWhRTkMy?=
 =?utf-8?B?RTNTN0NpcHE1RjVYVkNFSVBjUndWL2wvdmdHamNlM3RNRVZEWHFhWUVva25p?=
 =?utf-8?B?TnJKNENOb3o1MGU4RDJnNmZXWUdPRVVReVFQR2lOKzdramZzdmtxWWJwWm1p?=
 =?utf-8?B?VGZhYkdwQWtaUUpiakZDektkZW9LWXFaQ0VVSmVCamwvdjNlOGxNUjBBRmUr?=
 =?utf-8?B?cUZIZFNXaG5oT0tra3RWaDFib0pKM3cxN0JGblE1NjhTVDJrcTc0VUZUdGNO?=
 =?utf-8?B?b3VWUUovSGxpTitxNGJPV0YvUis3YmpRZzBwLzFvWkFWWWJzazJlcndMTmVm?=
 =?utf-8?B?OGFRcTVQRDJJKzJXelViWXVkVlJOanJSU1RxSlQzdnZ1Z3hsSGl3K2VyWldi?=
 =?utf-8?B?Smp5QnVxZE9neFFNZDJqUE03V08xSXVPNUdUdTk0cFZ6VmZCMFhjUGZCTnM0?=
 =?utf-8?B?N2p4K2t2bzRzN2hhdThKMjhTN3dNMUZvZEt0dUxyQlZXb3BSbVJvR00zSDl5?=
 =?utf-8?B?OVE0MnZZQmw4REFJenJNSFo5NEptLzJZaElVSWtONWJUUXhybjF1dFhpdmpO?=
 =?utf-8?B?OFdPUWxLMWVySFFFc0IvdGxEZHNaWWtMczF2ZWR4UEZma3R6RXVRMjhDSEIr?=
 =?utf-8?B?amtsT1E0OVZ5bXd0TktVbWNYNmFtdUJMR09JV1FPM21jZ1Fyd3VtQUFyeXhO?=
 =?utf-8?B?aVJkRk1Ha1RzaVk4OUYwdFNGRE5tem1NWWd2Y1BLREVFeEN2NUZYUHpKeVpu?=
 =?utf-8?B?T2dOMXNsckwrR0trZDIzQm9OeUs5amNWTVdyUVZ5WW1EdVVRZGVDUlBJL2xq?=
 =?utf-8?B?bktNWHRhVmRRZ2RCRWpMclN4WVU4MHZ3QWgvZmhBY014UHh6aDlDTUtBaDdt?=
 =?utf-8?B?MUpTcU5rbTF4TEJYTmVuRWY4UUU3ajkxQ0ZzM0hic3ZDMHNZLzVtNmM3bmZX?=
 =?utf-8?B?Rlhsak5TazRHMGpaTGpLN3BOYTltN2k3U2sxdmFoNTZUbTFkaW5OLzI1Y3Bx?=
 =?utf-8?Q?uu7hIfhR+z6HeOqf81OGSwksh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35aa08d4-f0f3-439d-16a1-08dc3fa3a343
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 19:12:03.2723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 100/dcl/hfuIP+1ZsAFesAepmFss7ZvPuXYaimogauBrnYGA+8hC7RuT7aVYk8hI/+96cIJRkzf36V+v1ftXvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
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



On 2024-03-05 15:57, Mario Limonciello wrote:
> The monitor shipped with the Framework 16 supports VRR [1], but it's not
> being advertised.
> 
> This is because the detailed timing block doesn't contain
> `EDID_DETAIL_MONITOR_RANGE` which amdgpu looks for to find min and max
> frequencies.  This check however is superfluous for this case because
> update_display_info() calls drm_get_monitor_range() to get these ranges
> already.
> 
> So if the `DRM_EDID_FEATURE_CONTINUOUS_FREQ` EDID feature is found then
> turn on freesync without extra checks.
> 
> Closes: https://www.reddit.com/r/framework/comments/1b4y2i5/no_variable_refresh_rate_on_the_framework_16_on/
> Closes: https://www.reddit.com/r/framework/comments/1b6vzcy/framework_16_variable_refresh_rate/
> Closes: https://community.frame.work/t/resolved-no-vrr-freesync-with-amd-version/42338
> Link: https://gist.github.com/superm1/e8fbacfa4d0f53150231d3a3e0a13faf [1]
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5b7293da5453..38186d669a85 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -11238,9 +11238,12 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>   		bool edid_check_required = false;
>   
>   		if (edid) {
> -			edid_check_required = is_dp_capable_without_timing_msa(
> -						adev->dm.dc,
> -						amdgpu_dm_connector);
> +			if (edid->features & DRM_EDID_FEATURE_CONTINUOUS_FREQ)
> +				freesync_capable = true;

We still need to check that the DP RX is capable of being
driven without MSA, i.e., we should do

freesync_capable = is_dp_capable_without_timing_msa(...)

Harry

> +			else
> +				edid_check_required = is_dp_capable_without_timing_msa(
> +							adev->dm.dc,
> +							amdgpu_dm_connector);
>   		}
>   
>   		if (edid_check_required == true && (edid->version > 1 ||
