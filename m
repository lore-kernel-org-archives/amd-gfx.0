Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7491077617
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 20:38:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D58D10E443;
	Wed, 18 Mar 2026 20:38:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V8Hw41I6";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 133C110E443
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 20:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqUtNNyjTlPq1P/FwF73vxpjYq9+Zj/CUNsN6igJ4+6eqY9d2lsas7WrzglFFISFJtDfW98QzxE6y97e2P0t4mJnLt9vB9i55JYqiDJI/rn66kIqWgejAz+RqwNMIzPDcsDk4MB4pv12HHOMddDAlhYeQ3wu1xiRRUHfZhTDELCtDHohFVTG6olHkXKmYco03XgKKY9mi1cvHdagYzXZI/IgKwgkshwNroMliOEALtkv2mItNsDUp6eL3J6ne0eqIshyFotKI7c52eqpIChavQMXEb86BFhJ8UVrXW9LpQf2XT7UWa0QSUVf62DT6KVMWI/unLm9oIfW2aJQ+4V7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLfsOfjbnhR29pu4n6b0qW9/TOdQl3AdoQ9Vr6rhPhU=;
 b=sa7mphEfk7KpJFyP5tGfsrgXUCHBRAf1Zx80a0Yrlpq31Ft68zjZzRruJLdDhlS/pQAkWu0bmRXjwBPPcvpOd2lRFjpTr/Dd1XG5/IBFCJ4jFJ/VwqahnXxOjtxXBX1NKIZIUVALaKwvyOg/sZCqkgfkDQYT8tBJMKwZtQEBoYvrJejP0PR76HsOsl16bc0IgC8/dqb7lKVb0eepu1sf6re+825Alicc4XKZQWc8MZmUhfAcfydAVV3JMsD+zwcplfx38GREJPO+8J9CSzRL/+RITdO32XZmzcYYCW7zJljmMt16Es3OeEtzLBx+t3EC+1RU7x8wWIHwvARMrIyUDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLfsOfjbnhR29pu4n6b0qW9/TOdQl3AdoQ9Vr6rhPhU=;
 b=V8Hw41I6IajhwM29sSyqawPmDFjJJunDGfW1KAdgAyJIcYjHXnM4KEj101rNZI82FoUoJA+F++tqDa3Iq+Vn83LOppb49CJcu/Ei7zOzCHu530bHDQGZjDzGs0WUIt/eQ3RKIzfx4na3qug/wKBJIgkNdCwD2jm+yZnKz3c361c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 20:38:50 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516%4]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 20:38:50 +0000
Content-Type: multipart/alternative;
 boundary="------------3VWJ63oDhAimrsEmn9WLYj6K"
Message-ID: <f6d4c356-b353-437d-b28c-b1d043677507@amd.com>
Date: Wed, 18 Mar 2026 16:38:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/17] drm/amdgpu: add profiler/spm support for gfx9_4_3
To: "Francis, David" <David.Francis@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Ma, Bing" <Bing.Ma@amd.com>
References: <20260220192236.3121556-1-James.Zhu@amd.com>
 <20260220192236.3121556-17-James.Zhu@amd.com>
 <SA1PR12MB8144E2E698FE2A2D21A99179EF41A@SA1PR12MB8144.namprd12.prod.outlook.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <SA1PR12MB8144E2E698FE2A2D21A99179EF41A@SA1PR12MB8144.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQ1P288CA0019.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::24) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b02de37-3b0e-4215-1c82-08de852e5c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: bn3AckIHTxL1UY6Lvdw/o23Vp86mFFJ2Nll+Nf+IrPmBAXQGbseTgwKsgg5fwg8cqL4bEMaQJ37x62p0cYMPLpEXU3yZMgEEe+FPaY+GPni/Kb0i5/qDILnX6kI399awOn7+7OBaEX13X5quPmSiHRZ7or4AOTPWHYjDpEzyPe2mc+mvpC9Q9RzbO7W8yn2uotS215aib9TV9UjIrf67ICamG2Ckrow9pNiOJ59DnVy97GQSHIoDgkX27A/mpWXn9uSuRat66aHkN3W6+KFvX388y+EOBHbvln8RIXUul4Tt7cKRHOnvaDMVgahP9Rj1qfuiDcaZS9wXG9I32PjZlo3C5p6QOmcl+QICv9SN6rGYMrvlG2700FefQHj9SVf62hh6fElty39je2OTvH3XAvjwBFyrcaNclrsYjE83zDFD2FgOOVWtPdGeAvFdhQ4B4ApDyCD18VlxD+ExeEQ2bc70CHhvDzT8AE7DiAsKUXIPioDU4TLe1XXkH+qwhluGw+dIJjPvtEHaHXRqKIHD0H9fwTEvSWa5hXnS27k+fZg6CJ7CoONrsdW/fq+/2c+y1tskAzNxnWv0rezzGWoMBXN0Rwa0DFg0KAwik8VRSUq1p0motlYu5inI5VOUQzAy/0dTnu1iHdBrKsfvR6M0k9RcM9JabH8aiFCM45MQZXqxfiRK35SEdMz4WPt63bOY4QU6uWFo670Qh4ugSwMz+pvmB/VrhrJSg4FXmLMizg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(18002099003)(56012099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2diUUxvRFYwUXkyQTZjT2c0V0NQSFdSU0ZVUHZVOVpvWnBsaXdpclpTTGwv?=
 =?utf-8?B?eGhSTm5jd3BRTHlmc2I5R2plMWgxOURqNlRGdDd2Qkp2c2RveHdXcGw4ZldG?=
 =?utf-8?B?L1ZxSW5iUktzZzFnUjgzT1dYT3NOdDZwM3FPSGdUdUVodDF3SjgzMzFTUTdu?=
 =?utf-8?B?NHd1bnRKRklaTVhjd251a3pZQ3ozSjN0WTQ2UlZDTitaTXpDU3pJWWN0L2VE?=
 =?utf-8?B?YlUyQ0ZQcW1QNXVwU3lpUG1wYnFMNXJmOE5mQjVyNXBrT2phclRSWmd3VmFM?=
 =?utf-8?B?N0hJb0RycDVveEZZSnhsb1lzK0NCaXhRU1BJQ2k0ZDRyMmZjb0NMay9iYXNT?=
 =?utf-8?B?WWRuamMwWEI1aUFZczlxNk9BTVcxWmdQbCtpZ2dacUxNTExna2NUSU8vRWFs?=
 =?utf-8?B?QVpPcG43Rk9qTDdMZFF0d1M1bFZSKyt5Unh2dlBaNUN2alAzWUlVUW1abmJH?=
 =?utf-8?B?UzdVWERFMEYzUTM5UXNYVytoSHNBWXdFVUM0cGh3QjF5aXQ1Z3U3dHBWTm5M?=
 =?utf-8?B?VmltL2tNVHhVclNtTkE1MzZjRDQ0ckloeWt0R0FLT2FwUS9hTkhNVlVKTlYw?=
 =?utf-8?B?Wkp5dWR6VlBwVG5lWCtCYldmdVFSZEpNbGlqZ0V4dlF1eDZSa0dqd3N0alh1?=
 =?utf-8?B?cWNud1JSQVd1RTBxUFdaUlE2clM0Z0J3WFN5YnBZMG10dm5zd1NjSXdUTEZ0?=
 =?utf-8?B?WVA0cXNsUmJsemR6emhYTWdNSTY4TytSSkR4c2xSYkRkMHJVZ3k3c0lnaFU2?=
 =?utf-8?B?aVJIbzNZRGZDNloyTUQyVVREV2trKzVpNzhES1Y3WHNJakxrNEFIajZOakRQ?=
 =?utf-8?B?cU0yd29lMHpQQU9yM1dBeGxmT2w3dEdWVlUwV3E1WmxXUC9HRTlKanMwS0Ez?=
 =?utf-8?B?ekIwbXZUd2lsekwxS25Xa0lUUlZYMUNOWnFaaERqajFVS1JnY3poZWdVQVRX?=
 =?utf-8?B?WXhiL1BzMXZvallvNU1uNGFZeSs1cHhKWW45MzJ0Z2RVUmpYWVZVa1pWQmVz?=
 =?utf-8?B?R0lzVlBwcURtM2hvS0JQdUxJYjNOZzRKc0tyUk1lMXc3dHU5WFVMOXEyemdt?=
 =?utf-8?B?Z0RqcUtmVXlFT1lXU1MvOHVLc3VYSHNBZU0yYjg2WkMwR3RhNFd5N1h2Z3dO?=
 =?utf-8?B?TisxOWY0WHVuS1JOM1BvY1k4OStBdkRIOEVaTmZkb3N2U2EzYldwaThRN3BD?=
 =?utf-8?B?anliOUlpbzdWL3R0d2Z1ZnJ6VE5oRDdoaDNHb0NMbkNHeDZIRlFtZHl5R2w0?=
 =?utf-8?B?bml2UXJrc01sTHhEQVM3MEVZYXF6K3YzdkM4TmJEWXBRaHdudTdEc2x2MFJh?=
 =?utf-8?B?UXRmMlRGWHZnWU9uUmQ5T1ViSEIrYzF0V3RjSlhPU085cFdaM1dZcWloT3JB?=
 =?utf-8?B?UG5QcTFOeFJXVUU5Z0ptc1RDREhsVDNKWGh4T2llWlF1TzBFWSt4TGp0N2p0?=
 =?utf-8?B?MHdBQnVaSm9LN3pER013RHFQNUVQSERxTG1BcmEvSGVKWmV6S3lZTllYQW9C?=
 =?utf-8?B?Qit2Z2J3UnR3Q1hzeHVsWEd5cHhiakxEajlQdElJRGdzL29QTjBqMUltaVFD?=
 =?utf-8?B?NnQ1Wm9zdGw5UGkzSHdVdjZXczd6ckJXSkFIWHFVUUJZUEtOb25lS1dVZVVM?=
 =?utf-8?B?L29RSzc1eDQ2YTM1cWszSG9XQ09rYjVIdldSU1hkdTNpS3RLQVJrVmFTaTFG?=
 =?utf-8?B?MmpNVnN6M20xUTdMT3hFTXE3NmVta0VCTlQxamN1WEdHM1B1S0ZOQjY4QU5n?=
 =?utf-8?B?Z3ZFcUtYMmJUT21iRWs4Y01abitBWkpxNDRGZXlNQU81WFpEOGdPM3A3bXhB?=
 =?utf-8?B?ZDhhZVpsYnJjMXhFMzMwbkNnR1Z5WDBBS2xZMVozdFd0T0VjblVMTk05UU1M?=
 =?utf-8?B?RHMzc2pJeFJmR0FBZ1RrS0czeFpzM0thQ3NiVUw5RllFbngreFo1UWZ0SG1h?=
 =?utf-8?B?c3UrdjBEUEE0RjdrbWVWUWM4c2lBNDlxMzVkSE9iVXU2R2xMTVF4bWsveEh3?=
 =?utf-8?B?eUFjSmZ0SXVxZXJzaFE3OTB4K09XZ0VFbTMxRUhSZXg3bnNTSktrQVN5bGg0?=
 =?utf-8?B?aTFZL20xWXord0M4RlVmenhES1NhbTVqY1hJL3lYM0pKNzEzMzBScnRvM2Uw?=
 =?utf-8?B?dDhjdUJ0d2FyZ1h0blhmMWVsY01nTmZGV0pIQUt5dWdsY25DTUhQMi9TOWZY?=
 =?utf-8?B?eDVZT1pVNW1NQ0lPVGRhSDZUY3pxRGpIVXc4bFhIN1B0NVlEdmhHT29RRkMr?=
 =?utf-8?B?Q1ZpdjZpZnpnMWI2RDFLL0FJc05lK0l1aGtGcFFQWVQrVVlSUGFmeUJQNzdW?=
 =?utf-8?Q?PGH5CbDfhUcFdMfvSp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b02de37-3b0e-4215-1c82-08de852e5c56
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 20:38:50.0614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWwmCNl6ht68uXCNVi3Ox9mETCoXo8wSiBTltXLkwLTpsiXa/Sk3M6HHgmwlravd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337
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

--------------3VWJ63oDhAimrsEmn9WLYj6K
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

Thanks for review!  My answer is in-line.

Best Regards!

James zhu

On 2026-03-17 15:19, Francis, David wrote:
> Have skimmed this patch set. Generally looks normal; another hardware block with the usual functionality.
> If these pass basic tests, they're probably fine or at least not harmful.
> Some general comments:
> - The commit descriptions aren't very descriptive. I'd at least like to see documentation of the ioctl interface and a brief notice of what SPM is somewhere, and some more words on what each patch is doing
[JZ] Sure I will add more descriptions.
> - Patch 5/17 adds a way to allocate GTT-type memory through amdgpu_vm. This seems sort of out of place with the rest of the patch set. Why is it here? And why can't we just use the existing amdgpu_gtt_mgr?
[JZ] I don't think we have existing API to invoke. Originally is it from 
amdgpu_amdkfd_alloc_kernel_mem
> - Patch 14/17 reserves extra space and puts magic numbers in it to avoid a page fault. This seems like a workaround for something; at very least I'd like the commit description to describe the problem this is solving in detail. I'd also prefer if there was a solution that didn't involve poisoning entries with magic numbers and checking possibly invalid memory.\

[JZ] Yes, it is HW bug. So basically the solution is WA. I will add more 
description. This solution worked out with other teams' engineer 
together. the memory space was  allocated properly. But HW's wrong 
logical for ring buffer wrapping around caused overflow, and overwrote 
this allocated adjacent space with unexpected data randomly.

> Thanks,
> David
>
> ________________________________________
> From: amd-gfx<amd-gfx-bounces@lists.freedesktop.org> on behalf of James Zhu<James.Zhu@amd.com>
> Sent: Friday, February 20, 2026 2:22 PM
> To:amd-gfx@lists.freedesktop.org; Deucher, Alexander
> Cc: Ma, Bing; Zhu, James
> Subject: [PATCH 17/17] drm/amdgpu: add profiler/spm support for gfx9_4_3
>
> with spm function interface and spm irq.
>
> Signed-off-by: James Zhu<James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 194 ++++++++++++++++++++++--
>   1 file changed, 183 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 44b07785bf9c..29fd5e2413da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -169,6 +169,8 @@ static void gfx_v9_4_3_set_gds_init(struct amdgpu_device *adev);
>   static void gfx_v9_4_3_set_rlc_funcs(struct amdgpu_device *adev);
>   static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
>                                  struct amdgpu_cu_info *cu_info);
> +static void gfx_v9_4_3_update_spm_vmid_internal(struct amdgpu_device *adev,
> +                                             int xcc_id, unsigned int vmid);
>   static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
>   static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
>
> @@ -1065,6 +1067,13 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
>
>          num_xcc = NUM_XCC(adev->gfx.xcc_mask);
>
> +       /* SPM */
> +       r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_RLC,
> +                             GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT,
> +                             &adev->gfx.spm_irq);
> +       if (r)
> +               return r;
> +
>          /* EOP Event */
>          r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__SRCID__CP_EOP_INTERRUPT, &adev->gfx.eop_irq);
>          if (r)
> @@ -1453,10 +1462,14 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
>
>   static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
>   {
> -       /* init spm vmid with 0xf */
> -       if (adev->gfx.rlc.funcs->update_spm_vmid)
> -               adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
> +       int i, num_xcc;
> +
> +       if (amdgpu_sriov_vf(adev))
> +               return 0;
>
> +       num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> +       for (i = 0; i < num_xcc; i++)
> +               adev->gfx.rlc.funcs->update_spm_vmid(adev, i, NULL, 0xf);
>          return 0;
>   }
>
> @@ -1631,14 +1644,15 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdgpu_device *adev, int xcc_id)
>   {
>          int r;
>
> +       gfx_v9_4_3_xcc_rlc_stop(adev, xcc_id);
>          if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
> -               gfx_v9_4_3_xcc_rlc_stop(adev, xcc_id);
>                  /* legacy rlc firmware loading */
>                  r = gfx_v9_4_3_xcc_rlc_load_microcode(adev, xcc_id);
>                  if (r)
>                          return r;
> -               gfx_v9_4_3_xcc_rlc_start(adev, xcc_id);
>          }
> +       gfx_v9_4_3_update_spm_vmid_internal(adev, xcc_id, 0xf);
> +       gfx_v9_4_3_xcc_rlc_start(adev, xcc_id);
>
>          amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
>          /* disable CG */
> @@ -1666,28 +1680,38 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_device *adev)
>          return 0;
>   }
>
> -static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
> -                                             int inst, struct amdgpu_ring *ring, unsigned int vmid)
> +static void gfx_v9_4_3_update_spm_vmid_internal(struct amdgpu_device *adev,
> +                                             int xcc_id, unsigned int vmid)
>   {
>          u32 reg, pre_data, data;
>
> -       reg = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL);
> +       reg = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL);
>          if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtime(adev))
>                  pre_data = RREG32_NO_KIQ(reg);
>          else
> -               pre_data = RREG32(reg);
> +               pre_data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL);
>
>          data =  pre_data & (~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK);
>          data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
>
>          if (pre_data != data) {
>                  if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtime(adev)) {
> -                       WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL, data);
> +                       WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL, data);
>                  } else
> -                       WREG32_SOC15(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL, data);
> +                       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL, data);
>          }
>   }
>
> +static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> +               struct amdgpu_ring *ring, unsigned int vmid)
> +{
> +       amdgpu_gfx_off_ctrl(adev, false);
> +
> +       gfx_v9_4_3_update_spm_vmid_internal(adev, xcc_id, vmid);
> +
> +       amdgpu_gfx_off_ctrl(adev, true);
> +}
> +
>   static const struct soc15_reg_rlcg rlcg_access_gc_9_4_3[] = {
>          {SOC15_REG_ENTRY(GC, 0, regGRBM_GFX_INDEX)},
>          {SOC15_REG_ENTRY(GC, 0, regSQ_IND_INDEX)},
> @@ -2373,6 +2397,7 @@ static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_block *ip_block)
>          int i, num_xcc;
>
>          amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> +       amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
>          amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>          amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
>
> @@ -2507,12 +2532,112 @@ static void gfx_v9_4_3_ring_emit_gds_switch(struct amdgpu_ring *ring,
>                                     (1 << (oa_size + oa_base)) - (1 << oa_base));
>   }
>
> +static void gfx_v9_4_3_spm_start(struct amdgpu_device *adev, int xcc_id)
> +{
> +       struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
> +       uint32_t data = 0;
> +
> +       data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SPM_PERFMON_CNTL);
> +       data |= RLC_SPM_PERFMON_CNTL__PERFMON_RING_MODE_MASK;
> +       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
> +                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_PERFMON_CNTL), data);
> +
> +       data = REG_SET_FIELD(0, CP_PERFMON_CNTL, SPM_PERFMON_STATE,
> +                       CP_PERFMON_STATE_DISABLE_AND_RESET);
> +       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
> +                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_PERFMON_CNTL), data);
> +
> +       /* When SPM is reset, RLC automatically resets wptr to 0.
> +        * Manually reset rptr to match this.
> +        */
> +       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
> +                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_RING_RDPTR), 0);
> +
> +       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
> +                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_INT_CNTL), 1);
> +
> +       data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL);
> +       data |= RLC_CLK_CNTL__RLC_SPM_CLK_CNTL_MASK;
> +       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL, data);
> +}
> +
> +static void gfx_v9_4_3_spm_stop(struct amdgpu_device *adev, int xcc_id)
> +{
> +       struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
> +       uint32_t data = 0;
> +
> +       data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL);
> +       data &= (~RLC_CLK_CNTL__RLC_SPM_CLK_CNTL_MASK);
> +       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL, data);
> +
> +       data = REG_SET_FIELD(0, CP_PERFMON_CNTL, SPM_PERFMON_STATE,
> +                       CP_PERFMON_STATE_STOP_COUNTING);
> +       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
> +                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_PERFMON_CNTL), data);
> +
> +       data = REG_SET_FIELD(0, CP_PERFMON_CNTL, PERFMON_STATE,
> +                       CP_PERFMON_STATE_DISABLE_AND_RESET);
> +       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
> +                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_PERFMON_CNTL), data);
> +
> +       /* When SPM is reset, RLC automatically resets wptr to 0.
> +        * Manually reset rptr to match this.
> +        */
> +       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
> +                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_RING_RDPTR), 0);
> +}
> +
> +static void gfx_v9_4_3_spm_set_rdptr(struct amdgpu_device *adev, int xcc_id,  u32 rptr)
> +{
> +       struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
> +
> +       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
> +                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_RING_RDPTR), rptr);
> +}
> +
> +static void gfx_v9_4_3_set_spm_perfmon_ring_buf(struct amdgpu_device *adev,
> +                                           int xcc_id, u64 gpu_addr, u32 size)
> +{
> +       struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
> +
> +       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0,
> +                       regRLC_SPM_PERFMON_RING_BASE_LO), lower_32_bits(gpu_addr));
> +
> +       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
> +                       SOC15_REG_OFFSET(GC, 0,
> +                               regRLC_SPM_PERFMON_RING_BASE_HI), upper_32_bits(gpu_addr));
> +
> +       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
> +                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id),
> +                               regRLC_SPM_PERFMON_RING_SIZE), size);
> +       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
> +                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id),
> +                               regRLC_SPM_SEGMENT_THRESHOLD), 0x1);
> +
> +       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
> +                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_PERFMON_CNTL), 0);
> +}
> +
> +static const struct spm_funcs gfx_v9_4_3_spm_funcs = {
> +       .start = &gfx_v9_4_3_spm_start,
> +       .stop = &gfx_v9_4_3_spm_stop,
> +       .set_rdptr = &gfx_v9_4_3_spm_set_rdptr,
> +       .set_spm_perfmon_ring_buf = &gfx_v9_4_3_set_spm_perfmon_ring_buf,
> +       .set_spm_config_size = 30,
> +};
> +
> +static void gfx_v9_4_3_set_spm_funcs(struct amdgpu_device *adev)
> +{
> +       adev->gfx.spmfuncs = &gfx_v9_4_3_spm_funcs;
> +}
> +
>   static int gfx_v9_4_3_early_init(struct amdgpu_ip_block *ip_block)
>   {
>          struct amdgpu_device *adev = ip_block->adev;
>
>          adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
>                                            AMDGPU_MAX_COMPUTE_RINGS);
> +       gfx_v9_4_3_set_spm_funcs(adev);
>          gfx_v9_4_3_set_kiq_pm4_funcs(adev);
>          gfx_v9_4_3_set_ring_funcs(adev);
>          gfx_v9_4_3_set_irq_funcs(adev);
> @@ -2534,6 +2659,10 @@ static int gfx_v9_4_3_late_init(struct amdgpu_ip_block *ip_block)
>          if (r)
>                  return r;
>
> +       r = amdgpu_irq_get(adev, &adev->gfx.spm_irq, 0);
> +       if (r)
> +               return r;
> +
>          r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
>          if (r)
>                  return r;
> @@ -3404,6 +3533,41 @@ static void gfx_v9_4_3_emit_mem_sync(struct amdgpu_ring *ring)
>          amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
>   }
>
> +static int gfx_v9_4_3_spm_set_interrupt_state(struct amdgpu_device *adev,
> +                                            struct amdgpu_irq_src *src,
> +                                            unsigned int type,
> +                                            enum amdgpu_interrupt_state state)
> +{
> +       int i, num_xcc;
> +
> +       num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> +       for (i = 0; i < num_xcc; i++) {
> +               switch (state) {
> +               case AMDGPU_IRQ_STATE_DISABLE:
> +                       WREG32_SOC15(GC, GET_INST(GC, i), regRLC_SPM_INT_CNTL, 0);
> +                       break;
> +               case AMDGPU_IRQ_STATE_ENABLE:
> +                       WREG32_SOC15(GC, GET_INST(GC, i), regRLC_SPM_INT_CNTL, 1);
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
> +       return 0;
> +}
> +
> +static int gfx_v9_4_3_spm_irq(struct amdgpu_device *adev,
> +                            struct amdgpu_irq_src *source,
> +                            struct amdgpu_iv_entry *entry)
> +{
> +       int xcc_id;
> +
> +       xcc_id = gfx_v9_4_3_ih_to_xcc_inst(adev, entry->node_id);
> +
> +       amdgpu_rlc_spm_interrupt(adev, xcc_id);
> +       return 0;
> +}
> +
>   static void gfx_v9_4_3_emit_wave_limit_cs(struct amdgpu_ring *ring,
>                                          uint32_t pipe, bool enable)
>   {
> @@ -4831,11 +4995,19 @@ static const struct amdgpu_irq_src_funcs gfx_v9_4_3_priv_inst_irq_funcs = {
>          .process = gfx_v9_4_3_priv_inst_irq,
>   };
>
> +static const struct amdgpu_irq_src_funcs gfx_v9_4_3_spm_irq_funcs = {
> +       .set = gfx_v9_4_3_spm_set_interrupt_state,
> +       .process = gfx_v9_4_3_spm_irq,
> +};
> +
>   static void gfx_v9_4_3_set_irq_funcs(struct amdgpu_device *adev)
>   {
>          adev->gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
>          adev->gfx.eop_irq.funcs = &gfx_v9_4_3_eop_irq_funcs;
>
> +       adev->gfx.spm_irq.num_types = 1;
> +       adev->gfx.spm_irq.funcs = &gfx_v9_4_3_spm_irq_funcs;
> +
>          adev->gfx.priv_reg_irq.num_types = 1;
>          adev->gfx.priv_reg_irq.funcs = &gfx_v9_4_3_priv_reg_irq_funcs;
>
> --
> 2.34.1
>
--------------3VWJ63oDhAimrsEmn9WLYj6K
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi David,</p>
    <p>Thanks for review!&nbsp; My answer is in-line.</p>
    <p>Best Regards!</p>
    <p>James zhu</p>
    <div class="moz-cite-prefix">On 2026-03-17 15:19, Francis, David
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:SA1PR12MB8144E2E698FE2A2D21A99179EF41A@SA1PR12MB8144.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">
Have skimmed this patch set. Generally looks normal; another hardware block with the usual functionality.
If these pass basic tests, they're probably fine or at least not harmful.
Some general comments:
- The commit descriptions aren't very descriptive. I'd at least like to see documentation of the ioctl interface and a brief notice of what SPM is somewhere, and some more words on what each patch is doing</pre>
    </blockquote>
    [JZ] Sure I will add more&nbsp;<span style="white-space: pre-wrap">descriptions</span>.
    <blockquote type="cite" cite="mid:SA1PR12MB8144E2E698FE2A2D21A99179EF41A@SA1PR12MB8144.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">
- Patch 5/17 adds a way to allocate GTT-type memory through amdgpu_vm. This seems sort of out of place with the rest of the patch set. Why is it here? And why can't we just use the existing amdgpu_gtt_mgr?</pre>
    </blockquote>
    [JZ] I don't think we have existing API to invoke. Originally is it
    from amdgpu_amdkfd_alloc_kernel_mem
    <blockquote type="cite" cite="mid:SA1PR12MB8144E2E698FE2A2D21A99179EF41A@SA1PR12MB8144.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">
- Patch 14/17 reserves extra space and puts magic numbers in it to avoid a page fault. This seems like a workaround for something; at very least I'd like the commit description to describe the problem this is solving in detail. I'd also prefer if there was a solution that didn't involve poisoning entries with magic numbers and checking possibly invalid memory.\</pre>
    </blockquote>
    <p>[JZ] Yes, it is HW bug. So basically the solution is WA. I will
      add more&nbsp;<span style="white-space: pre-wrap">description</span>.
      This solution worked out with other teams' engineer together. the
      memory space was&nbsp; allocated properly. But HW's wrong logical for
      ring buffer wrapping around caused overflow, and overwrote this
      allocated adjacent space with unexpected data randomly.&nbsp;</p>
    <blockquote type="cite" cite="mid:SA1PR12MB8144E2E698FE2A2D21A99179EF41A@SA1PR12MB8144.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">
Thanks,
David

________________________________________
From: amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on behalf of James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Sent: Friday, February 20, 2026 2:22 PM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander
Cc: Ma, Bing; Zhu, James
Subject: [PATCH 17/17] drm/amdgpu: add profiler/spm support for gfx9_4_3

with spm function interface and spm irq.

Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 194 ++++++++++++++++++++++--
 1 file changed, 183 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 44b07785bf9c..29fd5e2413da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -169,6 +169,8 @@ static void gfx_v9_4_3_set_gds_init(struct amdgpu_device *adev);
 static void gfx_v9_4_3_set_rlc_funcs(struct amdgpu_device *adev);
 static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
                                struct amdgpu_cu_info *cu_info);
+static void gfx_v9_4_3_update_spm_vmid_internal(struct amdgpu_device *adev,
+                                             int xcc_id, unsigned int vmid);
 static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);

@@ -1065,6 +1067,13 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)

        num_xcc = NUM_XCC(adev-&gt;gfx.xcc_mask);

+       /* SPM */
+       r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_RLC,
+                             GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT,
+                             &amp;adev-&gt;gfx.spm_irq);
+       if (r)
+               return r;
+
        /* EOP Event */
        r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__SRCID__CP_EOP_INTERRUPT, &amp;adev-&gt;gfx.eop_irq);
        if (r)
@@ -1453,10 +1462,14 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)

 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
 {
-       /* init spm vmid with 0xf */
-       if (adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid)
-               adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0, NULL, 0xf);
+       int i, num_xcc;
+
+       if (amdgpu_sriov_vf(adev))
+               return 0;

+       num_xcc = NUM_XCC(adev-&gt;gfx.xcc_mask);
+       for (i = 0; i &lt; num_xcc; i++)
+               adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, i, NULL, 0xf);
        return 0;
 }

@@ -1631,14 +1644,15 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdgpu_device *adev, int xcc_id)
 {
        int r;

+       gfx_v9_4_3_xcc_rlc_stop(adev, xcc_id);
        if (adev-&gt;firmware.load_type != AMDGPU_FW_LOAD_PSP) {
-               gfx_v9_4_3_xcc_rlc_stop(adev, xcc_id);
                /* legacy rlc firmware loading */
                r = gfx_v9_4_3_xcc_rlc_load_microcode(adev, xcc_id);
                if (r)
                        return r;
-               gfx_v9_4_3_xcc_rlc_start(adev, xcc_id);
        }
+       gfx_v9_4_3_update_spm_vmid_internal(adev, xcc_id, 0xf);
+       gfx_v9_4_3_xcc_rlc_start(adev, xcc_id);

        amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
        /* disable CG */
@@ -1666,28 +1680,38 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_device *adev)
        return 0;
 }

-static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
-                                             int inst, struct amdgpu_ring *ring, unsigned int vmid)
+static void gfx_v9_4_3_update_spm_vmid_internal(struct amdgpu_device *adev,
+                                             int xcc_id, unsigned int vmid)
 {
        u32 reg, pre_data, data;

-       reg = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL);
+       reg = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL);
        if (amdgpu_sriov_is_pp_one_vf(adev) &amp;&amp; !amdgpu_sriov_runtime(adev))
                pre_data = RREG32_NO_KIQ(reg);
        else
-               pre_data = RREG32(reg);
+               pre_data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL);

        data =  pre_data &amp; (~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK);
        data |= (vmid &amp; RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) &lt;&lt; RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;

        if (pre_data != data) {
                if (amdgpu_sriov_is_pp_one_vf(adev) &amp;&amp; !amdgpu_sriov_runtime(adev)) {
-                       WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL, data);
+                       WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL, data);
                } else
-                       WREG32_SOC15(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL, data);
+                       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CNTL, data);
        }
 }

+static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
+               struct amdgpu_ring *ring, unsigned int vmid)
+{
+       amdgpu_gfx_off_ctrl(adev, false);
+
+       gfx_v9_4_3_update_spm_vmid_internal(adev, xcc_id, vmid);
+
+       amdgpu_gfx_off_ctrl(adev, true);
+}
+
 static const struct soc15_reg_rlcg rlcg_access_gc_9_4_3[] = {
        {SOC15_REG_ENTRY(GC, 0, regGRBM_GFX_INDEX)},
        {SOC15_REG_ENTRY(GC, 0, regSQ_IND_INDEX)},
@@ -2373,6 +2397,7 @@ static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_block *ip_block)
        int i, num_xcc;

        amdgpu_irq_put(adev, &amp;adev-&gt;gfx.priv_reg_irq, 0);
+       amdgpu_irq_put(adev, &amp;adev-&gt;gfx.spm_irq, 0);
        amdgpu_irq_put(adev, &amp;adev-&gt;gfx.priv_inst_irq, 0);
        amdgpu_irq_put(adev, &amp;adev-&gt;gfx.bad_op_irq, 0);

@@ -2507,12 +2532,112 @@ static void gfx_v9_4_3_ring_emit_gds_switch(struct amdgpu_ring *ring,
                                   (1 &lt;&lt; (oa_size + oa_base)) - (1 &lt;&lt; oa_base));
 }

+static void gfx_v9_4_3_spm_start(struct amdgpu_device *adev, int xcc_id)
+{
+       struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq[xcc_id].ring;
+       uint32_t data = 0;
+
+       data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SPM_PERFMON_CNTL);
+       data |= RLC_SPM_PERFMON_CNTL__PERFMON_RING_MODE_MASK;
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_PERFMON_CNTL), data);
+
+       data = REG_SET_FIELD(0, CP_PERFMON_CNTL, SPM_PERFMON_STATE,
+                       CP_PERFMON_STATE_DISABLE_AND_RESET);
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_PERFMON_CNTL), data);
+
+       /* When SPM is reset, RLC automatically resets wptr to 0.
+        * Manually reset rptr to match this.
+        */
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_RING_RDPTR), 0);
+
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_INT_CNTL), 1);
+
+       data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL);
+       data |= RLC_CLK_CNTL__RLC_SPM_CLK_CNTL_MASK;
+       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL, data);
+}
+
+static void gfx_v9_4_3_spm_stop(struct amdgpu_device *adev, int xcc_id)
+{
+       struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq[xcc_id].ring;
+       uint32_t data = 0;
+
+       data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL);
+       data &amp;= (~RLC_CLK_CNTL__RLC_SPM_CLK_CNTL_MASK);
+       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL, data);
+
+       data = REG_SET_FIELD(0, CP_PERFMON_CNTL, SPM_PERFMON_STATE,
+                       CP_PERFMON_STATE_STOP_COUNTING);
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_PERFMON_CNTL), data);
+
+       data = REG_SET_FIELD(0, CP_PERFMON_CNTL, PERFMON_STATE,
+                       CP_PERFMON_STATE_DISABLE_AND_RESET);
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_PERFMON_CNTL), data);
+
+       /* When SPM is reset, RLC automatically resets wptr to 0.
+        * Manually reset rptr to match this.
+        */
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_RING_RDPTR), 0);
+}
+
+static void gfx_v9_4_3_spm_set_rdptr(struct amdgpu_device *adev, int xcc_id,  u32 rptr)
+{
+       struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq[xcc_id].ring;
+
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_RING_RDPTR), rptr);
+}
+
+static void gfx_v9_4_3_set_spm_perfmon_ring_buf(struct amdgpu_device *adev,
+                                           int xcc_id, u64 gpu_addr, u32 size)
+{
+       struct amdgpu_ring *kiq_ring = &amp;adev-&gt;gfx.kiq[xcc_id].ring;
+
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC, 0,
+                       regRLC_SPM_PERFMON_RING_BASE_LO), lower_32_bits(gpu_addr));
+
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, 0,
+                               regRLC_SPM_PERFMON_RING_BASE_HI), upper_32_bits(gpu_addr));
+
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id),
+                               regRLC_SPM_PERFMON_RING_SIZE), size);
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id),
+                               regRLC_SPM_SEGMENT_THRESHOLD), 0x1);
+
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_PERFMON_CNTL), 0);
+}
+
+static const struct spm_funcs gfx_v9_4_3_spm_funcs = {
+       .start = &amp;gfx_v9_4_3_spm_start,
+       .stop = &amp;gfx_v9_4_3_spm_stop,
+       .set_rdptr = &amp;gfx_v9_4_3_spm_set_rdptr,
+       .set_spm_perfmon_ring_buf = &amp;gfx_v9_4_3_set_spm_perfmon_ring_buf,
+       .set_spm_config_size = 30,
+};
+
+static void gfx_v9_4_3_set_spm_funcs(struct amdgpu_device *adev)
+{
+       adev-&gt;gfx.spmfuncs = &amp;gfx_v9_4_3_spm_funcs;
+}
+
 static int gfx_v9_4_3_early_init(struct amdgpu_ip_block *ip_block)
 {
        struct amdgpu_device *adev = ip_block-&gt;adev;

        adev-&gt;gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
                                          AMDGPU_MAX_COMPUTE_RINGS);
+       gfx_v9_4_3_set_spm_funcs(adev);
        gfx_v9_4_3_set_kiq_pm4_funcs(adev);
        gfx_v9_4_3_set_ring_funcs(adev);
        gfx_v9_4_3_set_irq_funcs(adev);
@@ -2534,6 +2659,10 @@ static int gfx_v9_4_3_late_init(struct amdgpu_ip_block *ip_block)
        if (r)
                return r;

+       r = amdgpu_irq_get(adev, &amp;adev-&gt;gfx.spm_irq, 0);
+       if (r)
+               return r;
+
        r = amdgpu_irq_get(adev, &amp;adev-&gt;gfx.priv_inst_irq, 0);
        if (r)
                return r;
@@ -3404,6 +3533,41 @@ static void gfx_v9_4_3_emit_mem_sync(struct amdgpu_ring *ring)
        amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
 }

+static int gfx_v9_4_3_spm_set_interrupt_state(struct amdgpu_device *adev,
+                                            struct amdgpu_irq_src *src,
+                                            unsigned int type,
+                                            enum amdgpu_interrupt_state state)
+{
+       int i, num_xcc;
+
+       num_xcc = NUM_XCC(adev-&gt;gfx.xcc_mask);
+       for (i = 0; i &lt; num_xcc; i++) {
+               switch (state) {
+               case AMDGPU_IRQ_STATE_DISABLE:
+                       WREG32_SOC15(GC, GET_INST(GC, i), regRLC_SPM_INT_CNTL, 0);
+                       break;
+               case AMDGPU_IRQ_STATE_ENABLE:
+                       WREG32_SOC15(GC, GET_INST(GC, i), regRLC_SPM_INT_CNTL, 1);
+                       break;
+               default:
+                       break;
+               }
+       }
+       return 0;
+}
+
+static int gfx_v9_4_3_spm_irq(struct amdgpu_device *adev,
+                            struct amdgpu_irq_src *source,
+                            struct amdgpu_iv_entry *entry)
+{
+       int xcc_id;
+
+       xcc_id = gfx_v9_4_3_ih_to_xcc_inst(adev, entry-&gt;node_id);
+
+       amdgpu_rlc_spm_interrupt(adev, xcc_id);
+       return 0;
+}
+
 static void gfx_v9_4_3_emit_wave_limit_cs(struct amdgpu_ring *ring,
                                        uint32_t pipe, bool enable)
 {
@@ -4831,11 +4995,19 @@ static const struct amdgpu_irq_src_funcs gfx_v9_4_3_priv_inst_irq_funcs = {
        .process = gfx_v9_4_3_priv_inst_irq,
 };

+static const struct amdgpu_irq_src_funcs gfx_v9_4_3_spm_irq_funcs = {
+       .set = gfx_v9_4_3_spm_set_interrupt_state,
+       .process = gfx_v9_4_3_spm_irq,
+};
+
 static void gfx_v9_4_3_set_irq_funcs(struct amdgpu_device *adev)
 {
        adev-&gt;gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
        adev-&gt;gfx.eop_irq.funcs = &amp;gfx_v9_4_3_eop_irq_funcs;

+       adev-&gt;gfx.spm_irq.num_types = 1;
+       adev-&gt;gfx.spm_irq.funcs = &amp;gfx_v9_4_3_spm_irq_funcs;
+
        adev-&gt;gfx.priv_reg_irq.num_types = 1;
        adev-&gt;gfx.priv_reg_irq.funcs = &amp;gfx_v9_4_3_priv_reg_irq_funcs;

--
2.34.1

</pre>
    </blockquote>
  </body>
</html>

--------------3VWJ63oDhAimrsEmn9WLYj6K--
