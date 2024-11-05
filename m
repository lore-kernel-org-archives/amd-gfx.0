Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AEFD40D08
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 23:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60DF410E04B;
	Tue,  5 Nov 2024 23:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xxWJOnz0";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B8CE10E04B
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 23:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsrfkuooX64Jg1C5jh0jQJpoDoh8y2EECTHDn70bcuu0RTzIJVUhIzklMgL9lm3dde+qaEc5aHpPUgxPJqCa5NgizWvsK2JuNZvpsnE6M9Q4YTW0VhNkkO/qY332WJSRJKWcGW0EzWwOlDfRBikIbI5Odrvq5XNteuz/fqPTMcDPjmauyTkdTk/gc0PwIqyeEMTBXrierLgUzOyvVRrrlRmJaMCqzlcK0Emk59J2Tcf+nYFACl6ul0NP3pCOym+2UICTGrf1KB2g9k1fel3shPz9r0X2H3SOygLq/ZK2eW12SH9/H5vlHJrHRJvY/AFkqHrAr6i16ZnHuQmsKRBXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3YtZf8FP4g4xUyS5LLCNwBvWBBfMdlKjtUdXgegdQs=;
 b=jvzRbR+a6aSIDC681nv940c8rppuS4yyoNJrfm7vkwz7jOKsrVoSeOOVCXDqC0mvri3MHaWKTBI3jQYxs80zFlF3Z8YMAgqLxDQyFBPhTV+QYRQMxoQ9oU6/qiA8HNwjf3fCe9cCHXtxyrV9T46x0hrtVDziVVniLXOTTu2ZowL9lwuM8xc2vu+VjH8SHNNrnpYP9EL6wvHoMltEqTNjYKHSOAAu4A2rqcVZNo7Y63NU/TDHOi6koT4sCsgVB3rM8Xu0YFk0SPdtJ4JFL2XjOUBo22qSLku+0haf1EYQQrDbOc3eHpRzG/goWsVOUgmtGR0AjWaexPh8CBk5e/m4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3YtZf8FP4g4xUyS5LLCNwBvWBBfMdlKjtUdXgegdQs=;
 b=xxWJOnz0r2+jUyg9Yror2w/LpAVt0bxMuIZuxD4i++iTDSXwwmsQgQew2OB9tRq0kXqMmhhBHFDJn4VjvddiBCVUNLGoMsRMDnsIW+OgnNQR9xUNqUFpLRHr6+yo3FRZdovfgjFIfib6WfgOYHAUONsUJswfHtbB1XX7IZYuPYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 23:58:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 23:58:05 +0000
Message-ID: <c4ac5362-8656-47d6-8a0d-3ffd88314bcf@amd.com>
Date: Tue, 5 Nov 2024 18:58:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: change kfd process kref count at creation
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20241028204301.46168-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241028204301.46168-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0226.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b7fa5b-6a0a-4866-2a7c-08dcfdf5b07d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azFncGkveGY0QU1BYzZsT2UveWZIcGtXczFUcFBDeWN0RHhmM3BxaDdQRjBQ?=
 =?utf-8?B?NzZCSnFWQmZMOHJ5NE1tNWU5QVNPcXBqMjBQNjcwNlZhajlUU3gvbU5PTHFp?=
 =?utf-8?B?dUd3TDh1YllOcEZRT2FQcGtyWHQ1aE1OcDlvcnZvMEpnWmNtODdaeTBMdXht?=
 =?utf-8?B?WnpSczkwRkJmUlFsSFYxZGswdWhob0I1bkJERS9xa1pKcDd4YmNVTGExeXgr?=
 =?utf-8?B?SUF4ZGREM2xwbnVpWTJ4Ymk3eUUwUGhXL0dtMVUzZmx0ckh4aW9LUkdIeGEr?=
 =?utf-8?B?Y2daTzNGK2dHTmZWNVFwWWhIaG85SFZRZEViVnB1a00wUWtyNG0yc2NtOE42?=
 =?utf-8?B?OEgxeEhla2FWT0g1S1RwUjdoektTUWp1YkU0ZGNHeWVUTTduQ0hhak9wSm91?=
 =?utf-8?B?NnJxNmZIMjFkbkRpRUQxZWQzd0JoY2lnZFBic1dmN1diK2NzUFRsWnNreElO?=
 =?utf-8?B?ZHM0YTU3UFFTRk5nOVRDaTE4Wnl3dmZOd0wwUHc4c3VtaVVKMmo5YWNkb2lo?=
 =?utf-8?B?K3ZTV2o3VVpRWlRZWDMxQktRS3o2Z0YwSVBoY3NZV25YUzAvSmQyaUk1SzlO?=
 =?utf-8?B?dDUvMGcxUWZaaUwyUGwyemNrYlFkODRyQU1wZjRPRmhMaGtIZDBRSWNMUnN6?=
 =?utf-8?B?cWYzTTR4amo1alprUkM4RThzRmdTMlhkU2NaUEVJd3dzUTBlQzUyZ1dhQVdS?=
 =?utf-8?B?VXlld296VWN4enlZTm1lSGE2THROQjRMWk5jbi9MUXZnQmhHUzhycGd2MGdu?=
 =?utf-8?B?dkxQSUVhZkcvZHFRV3Jab3R3VE1WdHRlSS9WaXJ1L3Fkell2YUEvUHo5VGNq?=
 =?utf-8?B?WXFjZ1hCT0dNcEJWbk93T3ZPNnRyQ0xYbnFxWkxidWZCdmhEeUVKczZIQ05L?=
 =?utf-8?B?ZjhHRk5oVmdrVlFNUit5YWpxbDRXWGkvaDFvL2pUWnl5S2FmZ0JxN0JwMTB2?=
 =?utf-8?B?cUJscGlmZ3liNFZpa3RhRTdhR3lrZ2pNNmJnZE1NSU5IVnJZNExQNWFIK2NY?=
 =?utf-8?B?NW5zamQ2MWY4ZVF3ZWZyb3huSHRmVmJHZUdHcmtTOWIvaVR5bTdWdk9jRmJn?=
 =?utf-8?B?NlFxanI5ZURsVXJPemJieXdZcjR6eW8wbDRMZjUyemQrRW1yZkRwdFlSa1ky?=
 =?utf-8?B?aVBJUko3QTVTclFFTjVBYk0rZFlMMDRPNVJoZC9nOHNOVlVmc0ZnZU9jMGVp?=
 =?utf-8?B?UW1vejhobkZPTTRRbTJMQXF0RVhwOXBuczZ1L0pPRkZaSlVrQkNPbUpleVFU?=
 =?utf-8?B?bXhpVERhaU02cmpFOFF4OVNXQkdpSnV3ajBVSm8vSGlnMlRDS095Z1p5MGZ5?=
 =?utf-8?B?ZGZpQWl6UVBzVVdRMXN4M0RDVDgvcVNqcitRUDhQSDh0Tk5RQUFYWFJ0cmxQ?=
 =?utf-8?B?TmNnOWp2K0FNaWNvNlVtUTJxeU96R1FzRzF2VzhSN3RiaGY3KzRIQ1NqUHl1?=
 =?utf-8?B?QVFwaVRpYWxQZEJGMDYwT2o4ZGtodU9nbWFaY1BzcGNBVDZGZ0tkd2VML3JL?=
 =?utf-8?B?MmdWOStMNlFGcTFwdUZrakNCYkwxY0xaNHg1UHBPMlljdENRZ3dYRldSWG5C?=
 =?utf-8?B?cEdoOEVCSUZUb2t4RVJoQnV3VkV3cXd6c2N4R0xTU1JRbWVrWmtqTjNvbWVT?=
 =?utf-8?B?UDNsUkNjcGxETndTcHZleFdscnBDL1BiUjlZVis1OTVRTkF2SGRJNWhvUUhT?=
 =?utf-8?B?NmQ4eEJTcnRDRWVpRlJpd0RkVW41SUVxM1R6M3M0U3BOUWpMSzE3b2U4OFBv?=
 =?utf-8?Q?TNHXBhaqri3yydLxdnPcq1OwiocGb7iErStJMCz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmNtUS8yTWRYdGlhaWlQWmozSk9KSlhUZTNSTUVDbnR1eUpNOVAxbWNuVkdM?=
 =?utf-8?B?cGhTZ1dVOThYOVNERlBubWlBWDl3U0Q3b0VCQnJzQVAzOEV0VWI2M2dxL1N5?=
 =?utf-8?B?R1lDdEJJUmtsVnhpMWtUcHRWaThoT1lmblErNFVYUHd3YVZJRFVyNWw4YkNN?=
 =?utf-8?B?VUJ1bUNEdHkxcTFBU3QrZGFZc0tBeksxSGdOeHk0Mi84Z2ZTQjI2ZlFDcld1?=
 =?utf-8?B?bDV0VHpITkJ1SUxCZDFNUmpLWkRsR25TS3lyb0xsK3VTWDlJL2lDSlJtTGVa?=
 =?utf-8?B?bkV5Qkx2RFhJVXVsampkQ2NYbzFRTmZZZ0VSK3dzMDdHYkNqd2xDaVZEcElP?=
 =?utf-8?B?TVR2c3U0NUFEc3ErcXhJc1JvREN2UWQvcDFaUjYvQlN1SmJoczBXUk1sb01Z?=
 =?utf-8?B?QmNuWHB1S2xxaTZoTi8vS2NUUXlSL1NmUUpUVVpUVmw0b3FlTnhxclQ2RldD?=
 =?utf-8?B?cXpKU2tOSzludXlZQVpLRnlmNndVdHdzYXhXZHQxNHpRa0FidVVvS0xydGtF?=
 =?utf-8?B?VzNrYXo0ZUhEMkJZaDNvckFENnVJMERhclVTd213dHJRS3IyQ0NielEwcDhS?=
 =?utf-8?B?QWEwamh3WnZtdGxFV3RHbW9wbElSZzdzdk5XdFN1S3A2Qmt2bnUwZFpJeGhO?=
 =?utf-8?B?ckNwNi9Xa3BTSjRBQzBPdkQwQjNObklJWkM3c0Myc0xXaldmNVV0TkdTWGxH?=
 =?utf-8?B?eCtXaXowd2JLMThYQ2xDNTFDSkVzaFFDMVNyUVptdWZGL2VoR29rZGRkWWhG?=
 =?utf-8?B?QWFWdEJnQ2VLM29KTmp3Yk0xOUJWQml2SmV5MDU4d0lRbHFtVXBOTlhGKzJt?=
 =?utf-8?B?WitIeG56K3NaNzNjRDNHZ3dhSk14Yk51enE0MVVYZkVQaTkvbTlHNkNOVGk1?=
 =?utf-8?B?OXFFVHpsSTZaWmsrR0ZQdzNNRWNzelR4YU5vNWdzUFNkS1V5cGVrMHE2Z2oy?=
 =?utf-8?B?M2ovT0lUVnlZWEt5ZzZidW9mdkdLTnNWc0FEVmVUYW9ZODFwVkRhVCtEeFdn?=
 =?utf-8?B?UmI3aFEvOHVpaGp0bmZxUFltWVgvbzZLNm1LOGMyRG9HajlVLzBXK1I3aVRi?=
 =?utf-8?B?QkltakxyZWdSK24xQ3dKTXU4WmoxM3VscXhMMDB1UDhSSnhST2xqRDBkaHhK?=
 =?utf-8?B?QjBWK1JHRjVzdzlYL3hpUU1zdkVXQjJROHVDaGZrMDNUVm1pYldrMG1BWjRK?=
 =?utf-8?B?NVRVczcwYXBwTWh1Yms2UkhxM2JmWStxQlBoWXVyUjRsWUZOKzE3cWU2bVJ2?=
 =?utf-8?B?RktTYmdQRW5SaEQ1enlkbGJDZ1l6akhEazc3TTFJWU9XdzRvSFZjN0NaejBI?=
 =?utf-8?B?R1AzNkF6a1AySXcrNGs3K2UzWWhXT0pTSzdaYk95TkE4Yk5xd2tFbGVMVzAx?=
 =?utf-8?B?a1pPRktJZnlBcThFOTZEN1FscTNZd3BaeUsvUW9mQklYdnRWam1lZFBTcE1x?=
 =?utf-8?B?cjBDckhtNmxBaTRMeFhWTWthRnk5bXJ2Mk9WSFhOVjJuNDdiMnhXZENqWkVX?=
 =?utf-8?B?NnB5ZkRWZEJFRmVMS2lpcDZoODBPRFRoZTlrRzdmRCtkUjl6ZnM1dVZheTdL?=
 =?utf-8?B?U0FwTzB3OFY3aFp4dXRoRExoaVZ5RVplYllsdjRIY3dxZ1BHMzYzNVlUc25X?=
 =?utf-8?B?Yk9VY21kMG1NdnFLRldIZGFLTzIzeGkyZ09oVGtXeS9CelFCcG5oUExVR2Vn?=
 =?utf-8?B?NDRIQndWNm9VVlVkcm5tV25PWHpORnFya3ZEelpFajNJaXZzS2J6dkZGNm15?=
 =?utf-8?B?c2VvL2FodWpaTWNyTGZYSVVYbE1OVmFrMkFaR0p4T3ovK0dJQ2FNSGZQckE0?=
 =?utf-8?B?SnNKSjRkNTU0eDBvcHRPdDlWbFM1bFVnRHNuYVpWL01MbEtzbWpPclJMcWto?=
 =?utf-8?B?dEVJMjdRem51ZndsVk1INU9tVGlralVkeVJnT2V5d1V4NW1zK1Jad1RXSjhu?=
 =?utf-8?B?VzlqUWk0SE5zcTZyM2huNk41dzRxSTdxTTRPbTNtY0JTV1p6N0c4K3Z5U2ZC?=
 =?utf-8?B?YW9pK0R0SVo5MCs3TURTbFQ4WFprWUtMSnhXcXJvWm16bEV4L2xiVThTSkdw?=
 =?utf-8?B?V0U4SWFyQnNEdVJCcURBOUs1blcwUEVQNkErMGxMY29OMURDT3RWbjdiZmJa?=
 =?utf-8?Q?VkRo6y3FfHVhdAsfVnDGjXV9C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b7fa5b-6a0a-4866-2a7c-08dcfdf5b07d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 23:58:05.0702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zg3dyMgtyPuxS6wnW4mSKX/jDu939S5i3S14Ocn4LWvA4T2JjMLxou9opKo1xOb7+AHGCSBEHEJ4/MTGyiME6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
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


On 2024-10-28 16:43, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> kfd process kref count(process->ref) is initialized to 1 by kref_init. After
> it is created not need to increase its kref. Instad add kfd process kref at kfd
> process mmu notifier allocation since we already decrease the kref at
> free_notifier of mmu_notifier_ops, so pair them.
>
> When user process opens kfd node multiple times the kfd process kref is
> increased each time to balance with kfd node close operation.
>
> Signed-off-by: Xiaogang Chen Xiaogang.Chen@amd.com

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d07acf1b2f93..d871d5320297 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -850,8 +850,10 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   		goto out;
>   	}
>   
> -	/* A prior open of /dev/kfd could have already created the process. */
> -	process = find_process(thread, false);
> +	/* A prior open of /dev/kfd could have already created the process.
> +	 * find_process will increase process kref in this case
> +	 */
> +	process = find_process(thread, true);
>   	if (process) {
>   		pr_debug("Process already found\n");
>   	} else {
> @@ -899,8 +901,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   		init_waitqueue_head(&process->wait_irq_drain);
>   	}
>   out:
> -	if (!IS_ERR(process))
> -		kref_get(&process->ref);
>   	mutex_unlock(&kfd_processes_mutex);
>   	mmput(thread->mm);
>   
> @@ -1186,10 +1186,8 @@ static void kfd_process_ref_release(struct kref *ref)
>   
>   static struct mmu_notifier *kfd_process_alloc_notifier(struct mm_struct *mm)
>   {
> -	int idx = srcu_read_lock(&kfd_processes_srcu);
> -	struct kfd_process *p = find_process_by_mm(mm);
> -
> -	srcu_read_unlock(&kfd_processes_srcu, idx);
> +	/* This increments p->ref counter if kfd process p exists */
> +	struct kfd_process *p = kfd_lookup_process_by_mm(mm);
>   
>   	return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
>   }
