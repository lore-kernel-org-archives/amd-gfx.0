Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B133C47089
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 17:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D4A10E40F;
	Wed,  7 Dec 2022 17:50:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9733310E40F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 17:50:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRaxYud7nelF9zxuy2opb8TmifYFmClt7vE2L4jtd0eh66DcwIelnVvKWPZaQHArXwS9wviK7d8fMRIvweTHf4lSV4TOl9ILTGjsPFPagRJVk/6vuIgFMOu1C5Lu5+vI9ZU6HK2svGDLqXksdhT5BP8CajZOK3UuQPOnkZln8RqlDgoWEpH+gSOilu0PTLFv1Teb9g0kXwrvdnHr2Jp52riAsvxxy5PdnfFmyNeHt4sWCpDrrZjaUKTVpiaFfscoNgnzeng0iC5HDmGFMxC3UJMbVkPE5hqCgfo3QabTVXxgEaQlWtXUinRhcKOfGeRhhHfHSHJgLfu1Cl6geBjwkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pa7iDnMceqyqcAf3bMbzeD9lluchlAPaqUSy6FX4HJs=;
 b=XWeDn1O1k1tz9oNKIg/s2DKVEyw84Pbc3DZkdm8R2NvF/UMZ2e7gr/xqPDyLVhJiZQfulqINu6oZWDfAb/DZVCUala4V+oK315sbT/VAv4qJh0fuZsE1cdJjABUcFurqm6iwplDi025zGIoJVngHWVKuClrugPVrcia/YCJYKD0HKTp915tIm2fPVyWzdGH+I5bRlVYnzzQiV2AepjT3eb/yUXpQtP+ZXZIXAQb6pPuygD756OnWcs2p5UkYGrh5BI3ziJQCg/sODDWFTyOh1wg+ONyW7B6pR3oK6lCVnWK+Nul6FYUQhqyXaBBSRA+vcA8LX7ps3LzrJBUyDjHWkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pa7iDnMceqyqcAf3bMbzeD9lluchlAPaqUSy6FX4HJs=;
 b=EJIU9rcBwL/fBOEHzAL6vUgqMlHxQ/n3UopvxjQAhKZYN9nSsv5YIUL4Xse7mxmzeGMIHmXbgHb5ceZWxyzhnUejKV4wFRyUU3ZWggevhxV+NHCOQPiYhgnVthsW3r86ktdpSKALXmMo+iWWdu+23OA87PR3IH6I0KRlKvKZYbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Wed, 7 Dec 2022 17:50:08 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 17:50:08 +0000
Message-ID: <f35a3888-c898-7af7-83df-d576ad18ed9b@amd.com>
Date: Wed, 7 Dec 2022 12:50:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] drm/amdgpu: make display pinning more flexible (v2)
Content-Language: en-CA
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221207162135.3290795-1-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20221207162135.3290795-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::16) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|CO6PR12MB5394:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ce1f70-6727-4998-78a0-08dad87b7ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /v/4wH7POG+8dXitEGCSTguLH+BItSIhm5K4QQwBZDjCLQKzy4iJXRL+Vq7ax6U/LkES3VwVoXkIfr6sqoZCDdVjMz+39LQ06fFCkBXvmHxUTx3MgNGKN9frATtzuwTiLCAEhArVlHzXPIqBmQCp3VG1QHI3vvc5fobtvO+JdrpznEGVgFKalyNEGFBC/A1Hy3i0jP9clKheF5p0weePksVggeUXRrCDOxs2YIr0r1oJ3V1VO3hpK1rrvIdQ7q2xmgBXF/327FnkGe6Jv5vAPvFTUIoKxhCdmvtEqUkC0kLRbuXHHH+yJu980eACua0652sy+0NYCLFOBkRZXTDBkAqokKAfK5IiHp7xug9BSuFrKpjzaLNVNFa4YRO5ccc9s1PZqBGgMzNpn5HK/I/U1AcIYpIqj8JgzLqLopre+ofy8op568fHRSqGs3uQUzQ88/G59i9/kzgLmkzfV2gpQfcBg8HQD29wWcNfjIDCaNAQW/1GRT6JWhLT8HpArE4Cx1MfsTuyykSBj8L2G83LbVjl2DyiH4FiKt+fyQ+IPwmgrL5hkbu7eZMAtc/P5edYFfmfqwxTFlxqpo+LenpVeCGpren2RL+/n9qJH2hezkOaglDsCmOXsT7/74L1Bt6AqEq8+3YqBfAMqX8BsoL9FR8DRLdojoYRns8WuLuWVwsku8kzt/y+nQIPWfrY5MkC1I6J96SoxFjSotQXtqldRNd2iKq3/Q5SZu94oqVnB3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199015)(38100700002)(36756003)(31686004)(6486002)(31696002)(316002)(478600001)(41300700001)(66476007)(66556008)(66946007)(8676002)(44832011)(53546011)(6506007)(8936002)(5660300002)(26005)(6512007)(86362001)(2616005)(186003)(2906002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW42b2Z5d2pZY3JWczlpck9aVUVzRUFNWTQza0pIdlQva2NnbEZMVmZpNXA3?=
 =?utf-8?B?TTdhZXQwV2JhcjBieUZUM1ZnK3Z5YnZJWkZOWEF3cm9JMk9PQ1prcDlJaytD?=
 =?utf-8?B?WjFiMGw1WGZKNWNIMUdVWndWOHh1MmZ5YWR3d2dFaTZGSlh1TWlQSHBEUjFx?=
 =?utf-8?B?TnhLWURsb2o4WVdkS0s4TDlGNE5RS0pXYlNHU0VIcmErdDhtd1hTMldEMHJr?=
 =?utf-8?B?cXBOZ2pLVjArbS9oQzRDSzZTRmRTTlBnZHNyZ1pFWUJ0QWVKM3RBeEY4bXZN?=
 =?utf-8?B?RXBaeVh3MkxEZjdkeDFoSUI0NzRMRlpGZlloMlg0bzYvL0ZabzROOEpXMDdZ?=
 =?utf-8?B?TEZlRE1ITGUyT05CME1mU29UZ2QwTHo4RDJGTlp2cDRmUisxaVB6WnMxVktk?=
 =?utf-8?B?SkR0UzZhUDF1dE5ieXpNVElVTWo1WFY3QnJ3UUlBby9sZzlnVHhQdDlFMVRL?=
 =?utf-8?B?VFBzWDg1d0lLQ1FKcFl3eWRDL3VYdlNIbUdYbmQwUFZMRE81am9wQUtQbmlw?=
 =?utf-8?B?b3FCL0laOGg5NXFnVjMwU01DN0Y4RXR4enBubTY0K29ETkg2LzdsK0ZFczM4?=
 =?utf-8?B?QjlpUDQwdm1mUUdZeGFPdThJU0ZDdlo1dS9RbGNDSGpPZU84UUNsSStQSHdT?=
 =?utf-8?B?Y2N5S05QbzY2cVoydk80MHpiOFJlanlrMGxadTRnY1JjMXRlR3JwZzN1bDVz?=
 =?utf-8?B?NEJVT1hjU242RUdPNGZkOERKOXdGRk1DZ0RycTAwUzFvOU12MTFxZWlWSHhN?=
 =?utf-8?B?Q3pJUkNLcnR1KytVekh0NDNvRXkwbE9ybW84ODQwQklrVnV6Mm95QmxhbzF4?=
 =?utf-8?B?b0VTNzZRVktNQVFVYzlhT2xGaEVFS1dUYTZBWkpxdEtEWWtFVlhlOFhJdFZW?=
 =?utf-8?B?ZlQveDRYV2p2UkJQeHNFQUdTaFRsZEFYS1lDc2hXQlBUdEJQeFkrS0pXaTV3?=
 =?utf-8?B?MzFpWU5hQ05IR01oM1hLWjFza2hxcXRsSHZBZDd4dEg5dkE3WC91d2hPaGgv?=
 =?utf-8?B?d29pb0hGN1BTVWdsWjI2RThEczRBNk8xRFpLL3h4MHcyN1hicTdTbStGSzFZ?=
 =?utf-8?B?TElTTHJRM1hMN3M5L0twU1BPSXppTkxnczRwUktCMmJYUWRkaytTQ0EweHRh?=
 =?utf-8?B?c3c1L2IyS1R6Y3lJbEZhVmxjMXc0NGQ2dXIyYXB6czhvY3ZUYlAzZXcyRTRp?=
 =?utf-8?B?dDd5VGthOVpid1dud1YyQitvK1BtTTFxNDdkNFBpL1h5bjNPMUdadmxXRmxO?=
 =?utf-8?B?enJzcTNNRlpLQzh3U0N0SUZ0VVhWVXdTNENOV1htMTFLcmd4VVMzVFUxb3hx?=
 =?utf-8?B?bDFVcFl0UTZUMTR1OXk4OTVQcFJVNDlFZ091cXoyMVg2ZjV1NktNWm9EZ0Ev?=
 =?utf-8?B?TTZjQ3lneFhaUlVxUTU1RzJQUEllQVlmU1Uzeitkb3JKTy9mSmZNRE5mVi9V?=
 =?utf-8?B?NElwbE5TbVE5ZTdySVEybHVPaC9LWWsxaWdlb1J5UUNpc0oyOVRjSUhncnVv?=
 =?utf-8?B?ZHV1a2dUOGZ0UnVvamlxcGhvaXpBZ21rN3BXY0QvM0N5SlhmT1ZpdjdWNENu?=
 =?utf-8?B?clVQWkZyMWtvM2txUGpJY1Q3UllSRnpVc2JkRm9hZEV5NGE3aExlTVNXRG1a?=
 =?utf-8?B?TWt5LzdXOXZUTVY5SHkrTDBaZlM3S0o2eUdHdzNSVEZrU3FTMFdycVFmUVR2?=
 =?utf-8?B?ZlJ1NlJTN0pFcDJUWUtiOXVVYytYcVc4eWNJMEdtQ0ZkaWRiTGN6SjQ4OHIr?=
 =?utf-8?B?TSt0YVYxRlg0WmQwdThscTV5eGRlMjEzY1N5UnZBb0xpK2JBV3F1TGNBT1VO?=
 =?utf-8?B?ZnNRRXdJQUM1d1dNSDNRZkRweGlNaXRXY3prWkxWeHYyTDRHSExCOVdMTnda?=
 =?utf-8?B?WDlUT3dma21XMWZHN0YrZE5nZ2x0UnBkTDdZWWVBSXF2a2lXOTB2WkxSdzVW?=
 =?utf-8?B?cXlwUnptWm5PS0l4MzIwcllEdnJycWFzaUFmdDVEbjRHZWk3T2l6STl1VTdt?=
 =?utf-8?B?MXpZZU1ZK0R5ZXN0b2lpZ1l0OEdEN2pONm96OWswWlUxd3VhWkV0bTZEVTB3?=
 =?utf-8?B?K1JsclpKSWtOczZiUjRqZCsvVFR4R1pGdE1sVUVuNERhQ0JERElFazF1MzI3?=
 =?utf-8?Q?oOtsgqv8j6D68xzeNBosSBUJu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ce1f70-6727-4998-78a0-08dad87b7ae4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 17:50:08.1654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXeQa0WdcAan8LzPvL0uXxjgq+617t1Jl8c6NIXAqNggPzgQdiTbuolfEjS9/UUp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5394
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

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2022-12-07 11:21, Alex Deucher wrote:
> Only apply the static threshold for Stoney and Carrizo.
> This hardware has certain requirements that don't allow
> mixing of GTT and VRAM.  Newer asics do not have these
> requirements so we should be able to be more flexible
> with where buffers end up.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 919bbea2e3ac..2df55cc7e07f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1506,7 +1506,8 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
>  uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>  					    uint32_t domain)
>  {
> -	if (domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) {
> +	if ((domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) &&
> +	    ((adev->asic_type == CHIP_CARRIZO) || (adev->asic_type == CHIP_STONEY))) {
>  		domain = AMDGPU_GEM_DOMAIN_VRAM;
>  		if (adev->gmc.real_vram_size <= AMDGPU_SG_THRESHOLD)
>  			domain = AMDGPU_GEM_DOMAIN_GTT;

