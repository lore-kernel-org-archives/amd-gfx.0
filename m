Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9784FCD5BAC
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 16:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 187B510E4BE;
	Thu, 21 May 2026 16:09:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CHlcault";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A8B310E1A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 16:09:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5ovIdK6UG1i1SRabi0KoAzFDlB+P3jJkzErwJr05TcOzTSzB6webVgAtvlJyynxUN5ctrjTuukdNLkEU01H2rAUvjGgpjjST1wkqCuAR9HIhR1rfXEMaCs4bGI0sf/gx968OvGwSj0AWiQJmNmt5csbYhjjgQtbYq1c3mdmT8Bkt8e34SyWMH/SMYueyA3WpBjkf2qQ+qjHN+23Lv5iPob47HvMxpCs41QpUbBNsHDI/LOgHXK2Zs8yCT9rVJvm0lk7JHJlH4KA40+b/vXWlEDGQ96dsU1Jrl3t+iUpNgGPSP5r6Hzn4q5570rNSH0V9QHS3e8jIar5P+nXCZn3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=id07hwOf6pE6SdphMJduFjkOGp3unXc4gUNKTToLhpw=;
 b=HP/b/Q0FW2QovdaynDqxx3TpBhTfoD1/bvoHfeJZak5nuHfjaEZqfYbQ0rzPJw1dCm3IX2CmXuApdvhcyxKjnENlS6Jev5rRmGuioqFtTXE56ewLYwjE4SwDZKeeP5ISKei8H6VkpPj87ZkjJOzTA7eg1WPFnuSRNMP/SwOxAJrpIn83D7GDpmY33HwPggfyMHAXjjwIYX4oXEV3V2tsr0Lk4uxpArrgVUYRhrzViBnsc35PlH0bmjmWSqeVdMYAIe0GYfQhzClhOwTFeRs7im4vvKODfCD10F3KAk/jLMVAB1k6qWt2Dma8YwTiBeLbYZ31e3yHZKskozIjwVrnJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=id07hwOf6pE6SdphMJduFjkOGp3unXc4gUNKTToLhpw=;
 b=CHlcaultDEpUcTOnprN9DKhZ1bLSaK8cUpdhqqsK4pzrRdBaZhULfV+GxIQ+0Kg4iTcI3Hnj37ZxgLp8xmLa7yMgzK9sH5VE+x60gFdr39W/ZfvScDDHq6N00qZqjZdgMSckdn53W8rRS6e+uj2xpzhs0VfR68D9fJrY4QYUSuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by SA1PR12MB7102.namprd12.prod.outlook.com (2603:10b6:806:29f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 16:09:19 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 16:09:18 +0000
Message-ID: <b2b18367-c385-4fc2-a7b9-00743af12ec7@amd.com>
Date: Thu, 21 May 2026 12:09:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/15] drm/amd/display: Initialize dsc_caps to 0
To: amd-gfx@lists.freedesktop.org
Cc: Jerry.Zuo@amd.com, Ivan Lipski <ivan.lipski@amd.com>
References: <20260520202929.555119-1-harry.wentland@amd.com>
 <20260520202929.555119-2-harry.wentland@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260520202929.555119-2-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0298.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::25) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bdbab86-611c-4f82-511b-08deb7534ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|18002099003|56012099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: EO+gB6Im/oTzQv3tfHG7IELMCFA6VLQRGilXKVV4qeib+tvYlJE3Mb6W2n9xObvdqM8IfIv3fL2TWKr8Gu9QuaOsNu6K51SXI0SyvA/tSd/ni8cjsv2lGdZUTyKaGvjFRXy3zFZbRnS1ZdRxFBjRush6A6tSzNzf8Ep2ihSi4zaQDeGLAyjWkQIB8pJa+ODQuceUWf+jlPjuJVTgds9eQ9BznJ/aEkgDXnbmZ9W6GnEsUra+tmJoRP322eoinGooFb+KbYqhNrraLCACb2LneI5vvh04MJt92dZF6Xo0ZLTD5FmNyB0LmviK1TN+De5K3sdDXE6SxMgfgqLGRvSSEEiZ0TWK5xezo8UlcxWhKkGEPdqE5+TAMLdNB/xMsIpOQIq8jLuxamcYosKLzCEfMWPdzniunvP3+7mk8nuKEmL8/gDHW3jS1aiZj1x34MUfGW2QQn/ipW+pACVot6D8nQB8Bgmkdu6ARpg8PZ4KUMCKjigdVfzHfOC4Uo91PzhVMUq73IaouHhkoLiDq6hBM4Wil1CvmGdvgtMSlipoivHgtb9lv8zioV0Aw76Amya+MrTSbV5CQnYwJZKZfEMdiBbmATTJzG2sNpzt3QTiI4ljyKZ7ALHeeMYbd9yW+Cu02eQSh6dKdwGlHIEV08RoyoOW2Ytrlgf62JYSXxvnKbsoyIxs1IW0DUSRvnk4jmT9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(18002099003)(56012099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUVUWG1OZXZtZ1JVSUJOWElEVDBpbUM3Mmt3YmJTZDJQYVNTc2RtNHl2UWw1?=
 =?utf-8?B?UDdhV2JrN1MxRVluM2pvV2lmcVEwTXUvK1Z1QjBSRUlTeHFpbU1NSTBEdGVh?=
 =?utf-8?B?T0lESzNYNVZoVlNtSFVVdHRvUm52eU1Xd2M3cERZZDVkTS82bXEwY1Q1dVRB?=
 =?utf-8?B?TGtCQS93YVlOUjErNEtuYXJDVGZVQkl6MEpPM2p6VHQ4V3N3WlN3eUZqNHZz?=
 =?utf-8?B?UG53U1g0T2U3NHhyQjRvaXBsbDJIclYybUxXSXpnWEw4RytGV2M4NU1TL0h3?=
 =?utf-8?B?bjhGdm9XbFZqYUxVNlUydDU4a1o0NFZZYlZGU012bkFLVU0wSlBqODdGZ3h4?=
 =?utf-8?B?OEh1NGVZYXc0VGVNSHBHbkxUZiszRDZZLzNHSkFxMUIyZUhTaHg3NUtQYlp2?=
 =?utf-8?B?Q0d6SjRXVWFocWxCRHE4UkZhaU93eVJsSmluUjlkdExxVXNxUVUyRHVuRUV3?=
 =?utf-8?B?N1o0alVzblN1RVFKdStVckg0anduM0dSWkR4SzR0N2FMQTFzOTBMNDlybUhO?=
 =?utf-8?B?eThRSnU5ZFkrVFk0TmJLU0F5YUpCSFFjTUNQZ2pRVjhzWXo0cXFvejlCK1NW?=
 =?utf-8?B?MFVHRWJBV3dLcklYemhJLy9VQyt0WFVxYTNBQWUyU2p3eDJHYnI3alNjTjZL?=
 =?utf-8?B?b2N5dkZHQVpTNlpKRC9mT2dMYjNlZ2s3cFlrRjdWSkNJNnZjazlSbmEzellZ?=
 =?utf-8?B?NVFHbDBIa3dyYnJ0SjBpQ2IwRmFFd3h2WTlXSHdUTXhtTHpEZno4VGVoV2VW?=
 =?utf-8?B?VnRZN1FmanlWd1BRK2V3Znc0dDRHR2JmMnpLNW5OK3BVNk1sUW80RitHVmxl?=
 =?utf-8?B?aGorNUMxZDQveGkrSTVQOTc3N3pOQ2hZem1yLyt1N3dhcXNMaFl1cFRFOXcv?=
 =?utf-8?B?WkFjdlRKVWJxNHNoY1BTMkpiL1FaTHh6SmZnajd0QnhTZUMvSHp1TnJ4b09Q?=
 =?utf-8?B?VmJwZVJTcSs0bFBLdlRKZ2VrTjFVUVZrdVRjdmkydjRYczNBcFNlS0t4Qm92?=
 =?utf-8?B?TlEwRE9kUWxsSkZOcUFCMEl6c1RrTHA3eEpYcFV6ZXVGU09nTGhSMkZxeUZk?=
 =?utf-8?B?Qmo1TjhnZGp5VHAyRnc4K2RjSTgwcGFvU0dpN3hSaDgweUF5dGdWS2Q3QlM5?=
 =?utf-8?B?NkdNVm5aNGJqejloYUtiUndjTzlQMFE0ek5naFZORWV1UGUxbDI5ZExHNFoz?=
 =?utf-8?B?MnR5V2R0ZmR2SGc0NFVyWFlrWmJtTFRVYm1NcnE3M3FMckZxZlVHTHF4WUh1?=
 =?utf-8?B?WGl2Q1lCNEZWR1dOeXU5YTUxZ2xBSjJUMVczZ2UweDNwKzN1WUY5UDNxS0lx?=
 =?utf-8?B?VGxGTkRES3drejl6Wml4Mm5IQkU1TU9DMWxIK1N4K2NPaXZpVzFXVWZGUGNH?=
 =?utf-8?B?VHNFbE8xYVNQNU5HcmdFRjBPVDA1cnI0eVNVVzZuOUEva1lzdWtWZ0pPbjAw?=
 =?utf-8?B?Q3FlZ3ovRzhUdksxZUpQbGV3VkMwczh5UDEycEtRY3BTUURhMmUxUzlGWm53?=
 =?utf-8?B?UEN6dUtSWG43R0F1cVB6ckxqK3JoZ0VIU2diTzhMYTB0Z3NKR1lxN2Nnb1Fm?=
 =?utf-8?B?REszVlJSelN6WUtuY1Z1aVE5ZjVBbW5veVRJalg4enQ1UVYxZlNxZVdyeWJ3?=
 =?utf-8?B?Zjl1S2sxY1l0RTlOSkxEazZjaHhTNFNjcmM1T0NQSEIwUnhiR3ExU1NBNjBV?=
 =?utf-8?B?OEZwVEVxcG1pd1RJcWxKTUVmVER4MVVsNWsxK0l6STB0T2crMHZUVDgrYmVw?=
 =?utf-8?B?Vlk5d0ROVVV0MmJ1UFl4cmUxam1NWjlMUUp1R1AwVWVrTEUzWnpvY2c2eUJP?=
 =?utf-8?B?VEdwNThmRlRCdzNJbEYyQnAyMDEvUUNFdndMOFc4dXJUSDJVdWppa3IyekVS?=
 =?utf-8?B?Y2dNWGd2L21ERUtzZU91YmIraWg5QU1ZODJPaDU1b0xqeEVuanNBWFh1WjB2?=
 =?utf-8?B?OU1oNXpDc1U2VFBxQ0dNdm5TUG9mNUhIcHB5bG5qcUlYRG1tbXlqMFJIRTBL?=
 =?utf-8?B?ckZFVk1lNkRudlhmc28yZlNKMkRmcjFwQ29BVFNmVjhzVmFOSitReUlra2JC?=
 =?utf-8?B?UElTQXBYbVMvVkRXdmNVSWpsRjN2S2JKdjloYVRJUXlxRTVTd0RsdjNhSnd5?=
 =?utf-8?B?cmVZNlpXOXQwRTBsandPR3JTVG5QM1p4dnBEeTBxL3FQOTRYYTJMZElSdUJq?=
 =?utf-8?B?eTVub253RURZMTR1M3RBcFBwbVF0bmVsSWV4UmF6aVFkcWJSU2RZN3JSQkJJ?=
 =?utf-8?B?U2lqNXBHZHgyNCtBZHlqcXQ2QUJvMnQ5MmVTRjBPem04SnZZcmNXUU9mZXVL?=
 =?utf-8?B?ZWhKd2dxaklScUdFbGN5WkpoN0hkQnRuc1VLSWRSM244UjAzdGMydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdbab86-611c-4f82-511b-08deb7534ff4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:09:18.6030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06aSP1wO/YPc3SlTJzBoF0RLtYhQarG3Ut5WaIrEy0G63O26Zg3Lu9DiyE4actb0aPVqLY8xa7xfi4UpIeELJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102
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

On 2026-05-20 16:29, Harry Wentland wrote:
> From: Ivan Lipski <ivan.lipski@amd.com>
> 
> [Why&How]
> If we don't do that we make DSC decisions based on random
> inputs, which might result in disallowing DSC when the
> monitor and HW support it.
> 
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index af0af7519517..d6eba4c37647 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7469,7 +7469,7 @@ create_stream_for_sink(struct drm_connector *connector,
>  	int preferred_refresh = 0;
>  	enum color_transfer_func tf = TRANSFER_FUNC_UNKNOWN;
>  #if defined(CONFIG_DRM_AMD_DC_FP)
> -	struct dsc_dec_dpcd_caps dsc_caps;
> +	struct dsc_dec_dpcd_caps dsc_caps = {0};
>  #endif
>  	struct dc_link *link = NULL;
>  	struct dc_sink *sink = NULL;

