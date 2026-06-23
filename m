Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AA6CD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 05:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08F8D10E955;
	Tue, 23 Jun 2026 05:52:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OnGkxUa+";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2943B10E955
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 05:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0eYxfmyYb3rlbEhObA41tz7R3skYi/nUHISKhO/WVRq/TwKOrkPuorAy4H0ole0kryozSwekDEyfQQ2eTJM8iFc7T8A/ZJygCwa9jPrlVERwTuAPfI+NlsUcyCJNNdtaDzpNSLNH844z6Tj5QxrqEphhm9WZaAWYJ3qpoWxHseyoe/X7oqRpmXgzEI3HBEayOqjBJCUVLvPgO719Ry4YF6wvOL2OT/L+b9Ie5E8Zq8xFjhBK0K7dfkM+gFB7zvBeNOckJ0et0RErAb9+Vaeuo2RIweTgxwttLFjsjxW9IrBMTDzUGhEbhIXlQzFTed+uIMKEUDs7YUopKihTpfttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvRQ0jAEQ3fDVY6AFckjUG5LXZbRHLfXMGVrDHc12nw=;
 b=fgFM2VIAijfkKK4czaFs6qis7hpVAX+YCyKqvjKpR5spt4qGXrDw33DpaUDlN+A8kdH6DLO4wrf/iOwBdNMZJJ+73mN8/cTOlhCyQcVM5UanjwKJaTGMdEmqt7KA5zHYw8b38Y/I9d1a5AHt+Q9aJocH54mfPk2dggt/g5WcJEMiFwgPaGrQIeymnvuu8nzXd1xIrYruGNdsrTjqggdhnsz0+5kxS8xu1BClRvGdOuuUB+F7zGbMu6yKDOPpwBPcMl+zbwbkBKmXUqwRsPxEH+C0Wc8zz5ZEjX+Zk508r3p3OnFc/lOQu4C2mkwBc4qRmlLTKDBpKUfi7JQOsZ5JQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvRQ0jAEQ3fDVY6AFckjUG5LXZbRHLfXMGVrDHc12nw=;
 b=OnGkxUa+r/nqJ/aDdDFMZrp+EYpIUr8SPyxTl1oclP5wcPqRpJZRZas0Z8HA1UHDQIKSVceXjzifSud5nY0Dv2gg4MgaswjWUGhUHnWaY+98PKdsyq7WgbKGxGmUxeFawcZ7S/dMBUSsN3OaX658+oyQy7bQDqIUXZ0JsGMVF7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 05:52:38 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 05:52:38 +0000
Message-ID: <5c1d6a5b-e1e7-47f0-962f-55e390fe1da9@amd.com>
Date: Tue, 23 Jun 2026 11:22:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: protect XCP scheduler selection
To: Xiang Liu <xiang.liu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, Stanley.Yang@amd.com,
 YiPeng.Chai@amd.com
References: <20260623042319.561959-1-xiang.liu@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260623042319.561959-1-xiang.liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: ae619422-4cf6-47fc-b182-08ded0eba184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5MbSWwxxRfUswqHzVKG9X+vTTJDMrvdCM3f8ED5d9qzab+LN1Q1SCK6JlY7gGQQvISw4fyr065htFbbYEXDJE+SNam3crkGuD62k21GaG0MysI0iW/390s4mno+ThejuwaRZZKY9Scn16UYTMdGLqvWVbydmtEZV9t784ulpmzQ5vKRjEiclh2Z+O2QtSUWitxpqcvrsEmCYO8gKkTKGjz/ojt/bLlv3spB5gYlIORKG1d4P1WB6zZl3NSIYZTiESRasaETkbiyzc367Nrd5bm5/cKm19NdMpswP6gEEoosyT5/iMXoVLg4WK4ZT8IticzJq/hjhl69WiaBLCQ4uMArIyNksDW9PiQKxoZTUOUTj1LkBjAJQLhzbOMBxmT68QH/jpcUZthrdIPt931ukwvnv6cFqilivykEFtDpiB58omAt3Md1bgxjQuppcGybTq/xLKPNkTPTJuUqv9Z+Yf3kjgZOzmU0Xa44iWFrQ0pJYGTB7CQvBddYCokOOEgtYb4uznbQsOypV9cRKa5fiuQCLOgVc9xqP+JhJnn4+z0TpcGiiV/5Mm7KGm5HwzfvzDGlLMXRBfz1Po1TYmB2fKwwddOY5qPksZe8qIWgGoN1jAOJGE48cxQOOoS4GN5G7C7LDCPFQIQgBmyPQkn+DmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDduUGMydjYwT2o1TGVxWlJKOG5YdzdsTDNFYlptMCs1WldxWEM3WVBzNDdN?=
 =?utf-8?B?VVZVOXc5WmZsRVp2UHRURVVXb0JSWll6c05TUmlXb0NqQTRkeS9xNmZVMysw?=
 =?utf-8?B?YTB6czBUVFdTK0tyb3V4WGV5WjFGYlBmLzFaeFNRWmJFNVY2U3NHS0YwcU1X?=
 =?utf-8?B?MmxQRjQ4NXN2K2F3cExhOXh5L1JFQUtwNmE5MGVCTGRIeCtyazI5QytweFB3?=
 =?utf-8?B?VUdnUUhzcytONHZlcGRFNnRqRHpFUmdpVlROK05qcFdRYWNmM0FVODk4Y1Nu?=
 =?utf-8?B?aHVGaGcxRVF0TWhKSEFVS1dxbkdOWWN4MG0xYWgyMzdZeXlIR05oN1VtQlpa?=
 =?utf-8?B?SW1rbXJ4b01CdzJXZTZUQXlzT3pVRGQvYTJMNDcvR3lRQy9IWW9SYVpkNkpq?=
 =?utf-8?B?ZUxHZHlRTkhDRm0wOHVHRjJZSEdnZFA4UUd3cmFwQm5halR1b3lYakVrMTV0?=
 =?utf-8?B?QlhEekVNdCt4alRPVkZWMCtqTytSeTR2bFgvMXFYVzZJMVFwM1hiYWxwcVNy?=
 =?utf-8?B?VVh0YlFQUE9JU0haK1gwQ0VEcS9XVlJBM2xLemp1VVFDYTNPY2NEK0pMbUI2?=
 =?utf-8?B?SHIzT1ZHV2VFZ05KSzNndnk5aCtNdXJKUlhncDNBWjM2NGp3SjBWNTFuVm5H?=
 =?utf-8?B?OElVS1VLUUc2dlFFVkxFWEpMT09TbDRiM3ZRNzB0N0c5d1Q0dFRENjFLYzZY?=
 =?utf-8?B?VEZrK042OEVTNjlMd0pZNlVkRVJPaytsekZOY3VRc25KeisrendNTXg3a2JH?=
 =?utf-8?B?L0hWd0YvVjF5T3NvVk5aY2J4cXNibUh0azRwUmFEcnNvNmtsdTBDT0dEWHR4?=
 =?utf-8?B?OUJTSVJrWWVXaHhtVmRIbURiZmEraTBhUVErV3R2YTNHanhTQ0s1VjF1U0o5?=
 =?utf-8?B?NzU5czczRWVreE0xK29RS1R1N3d0QWh6dzdHdjRyY1hCcVZsZGx4K3h1a3Bs?=
 =?utf-8?B?YVdrTVc5d0dyQzRvSW8veHltK2piWUdBVFk5N25DMGNtN0JvRmRvSFhCME1Q?=
 =?utf-8?B?YXIrUWZRa053eWNUbURkS2VxVEl0b0ZBZTBCMVFBTFRXckZyZTNNTWRwUlgv?=
 =?utf-8?B?Z3FoQ1JKc0JpRTh5NlZmOU5DWnRMZ0dYbG9vMjh0OU5VenpiR3R1ak1lSitI?=
 =?utf-8?B?UVlVSXhIVEdieXhKb0NhN2RzK01ESHo4QjNxTHVWZU5RakxxOWNMV25oQ2dj?=
 =?utf-8?B?RU1vOXF2NnJWOGpmT2NOUllaY1VXTWN1eTErNmI1aVVmSWF0RnNpZktGZ3pl?=
 =?utf-8?B?ZUpBenhtSzlUTkt2cDF5U25jbk5kdDFpUVVxSHNYcDMwQ0JIQ250R2hlR1pH?=
 =?utf-8?B?ZGJvZkwzbWluL2lPQVUvNVI0dFNwUFN3N1JoWlpZZS9Zc3ZPUHlCUFhNTTNZ?=
 =?utf-8?B?TG8reDBiVFUvR3hjTEl3NmdzcHBzOXA1SDA2am5RUDU0WDJQQzF3Si9DZGJU?=
 =?utf-8?B?ZEF4cVJpRFBpK2hnZWZudDVlK0FRWGtEYzk2K21ISlFjTThoT1N6djZQZ1or?=
 =?utf-8?B?RjJ6dVR0SGZpeTJGOVU0K1RIMCtPTkIydS9TM1NncEx1NTllN2VsaElxNkpy?=
 =?utf-8?B?c3BGbHNITEhRSThuRFpkNS9WMFJuaUt3OVM1Vk0rc2prbWhiMUF2eFdDN1VO?=
 =?utf-8?B?empHMHlKY3RPdTJzRkRNZGx4TFJBUjNaeVNRVW5EUTJPanR4N3NZMkNTOGFM?=
 =?utf-8?B?Q0tOcU5VWUFaTExHZWV3TUNmazVaK1IyTVhsNkRNMDBueFMyU1FmSDFsQWVs?=
 =?utf-8?B?NFV3QjJ0N0RqTXNwaUVsaG4vdzI1b0cxR21aQkV3cWUwOVRLRUUzZ2w2MWJF?=
 =?utf-8?B?aW8rNCs3all6VVJySnVYQ2owdmlDWVpRWlcyT09NbXpHQlZjZlVUODd6MWxl?=
 =?utf-8?B?VnhVSCtzYktpeFFrMjBhVXRuOWFPNmpaOTdmdDdvd24wcFpwMnF3czBIUkdz?=
 =?utf-8?B?WWFPV3l5TkxLYmRDMC9wM1VQM2FjVGRDMGVIWU1MTk1CdlBzbjRadDlLRHhH?=
 =?utf-8?B?WXdIMFVka1VaaHJXdUpvcTRYOUFYaHJIOFVobU04OTc4WS9sL0oyMTRRdDRD?=
 =?utf-8?B?K0ZIKzNKSjBFRTF4MzlKVURncm1QaXBXMkxiaTZUUTRYVVZwRWs3OVBENDBX?=
 =?utf-8?B?Tno0UkZzTHJXdDJ1SmVYY051QnloVjhnTWt6ZytycHRmK2FPWnhIRGVuOEE0?=
 =?utf-8?B?aWI5VXdqOVdETnU3UTRiU1lQQlJxVlNBOEdFKzFUTjJ5SDgzbFhtUU5BZTh6?=
 =?utf-8?B?ZFBDSEZSNk42QVg5QVBZOWY0U2ZhMWhvTXVQY3RGd1dUVVBUMHBjelAyMHE4?=
 =?utf-8?B?c1VRUHhqWG5lWVJSSDRIb2o3WkJaaHBsVVFHakRRWGhCZVBjbncwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae619422-4cf6-47fc-b182-08ded0eba184
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 05:52:38.0447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/Am6CVx0EhJa1CX5z8WRQfttEGMmWWPc6/eWeCrfTneOpqd2u7mfehE4Km5SxTj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
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



On 23-Jun-26 9:53 AM, Xiang Liu wrote:
> amdgpu_xcp_select_scheds() reads the per-XCP scheduler list.
> Partition switching rebuilds the same table under xcp_lock.
> 
> Take xcp_lock around XCP scheduler selection and release.
> This prevents readers from observing partially rebuilt state.
> 
> Also revalidate the selected XCP id before indexing the table.
> An open file can outlive a switch to another partition mode.
> 
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 37 +++++++++++++++++--------
>   1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index 88e6eab91bc6..1db7d2ad01fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -469,16 +469,21 @@ void amdgpu_xcp_release_sched(struct amdgpu_device *adev,
>   {
>   	struct drm_gpu_scheduler *sched;
>   	struct amdgpu_ring *ring;
> +	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>   
> -	if (!adev->xcp_mgr)
> +	if (!xcp_mgr)
>   		return;
>   
>   	sched = entity->entity.rq->sched;
> -	if (drm_sched_wqueue_ready(sched)) {
> -		ring = to_amdgpu_ring(entity->entity.rq->sched);
> -		if (ring->xcp_id < MAX_XCP)
> -			atomic_dec(&adev->xcp_mgr->xcp[ring->xcp_id].ref_cnt);
> -	}
> +	if (!drm_sched_wqueue_ready(sched))
> +		return;
> +
> +	ring = to_amdgpu_ring(sched);
> +
> +	mutex_lock(&xcp_mgr->xcp_lock);
> +	if (ring->xcp_id < xcp_mgr->num_xcps && xcp_mgr->xcp[ring->xcp_id].valid)
> +		atomic_dec(&xcp_mgr->xcp[ring->xcp_id].ref_cnt);
> +	mutex_unlock(&xcp_mgr->xcp_lock);
>   }
>   
>   int amdgpu_xcp_select_scheds(struct amdgpu_device *adev,
> @@ -490,7 +495,9 @@ int amdgpu_xcp_select_scheds(struct amdgpu_device *adev,
>   	u32 sel_xcp_id;
>   	int i;
>   	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
> +	int r = 0;
>   
> +	mutex_lock(&xcp_mgr->xcp_lock);
>   	if (fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION) {
>   		u32 least_ref_cnt = ~0;
>   
> @@ -507,19 +514,27 @@ int amdgpu_xcp_select_scheds(struct amdgpu_device *adev,
>   	}
>   	sel_xcp_id = fpriv->xcp_id;
>   
> +	if (sel_xcp_id >= xcp_mgr->num_xcps || !xcp_mgr->xcp[sel_xcp_id].valid) {
> +		dev_err(adev->dev, "Selected partition #%d is not valid.", sel_xcp_id);
> +		r = -ENODEV;
> +		goto out;
> +	}
> +
>   	if (xcp_mgr->xcp[sel_xcp_id].gpu_sched[hw_ip][hw_prio].num_scheds) {
>   		*num_scheds =
> -			xcp_mgr->xcp[fpriv->xcp_id].gpu_sched[hw_ip][hw_prio].num_scheds;
> +			xcp_mgr->xcp[sel_xcp_id].gpu_sched[hw_ip][hw_prio].num_scheds;
>   		*scheds =
> -			xcp_mgr->xcp[fpriv->xcp_id].gpu_sched[hw_ip][hw_prio].sched;
> -		atomic_inc(&adev->xcp_mgr->xcp[sel_xcp_id].ref_cnt);
> +			xcp_mgr->xcp[sel_xcp_id].gpu_sched[hw_ip][hw_prio].sched;
> +		atomic_inc(&xcp_mgr->xcp[sel_xcp_id].ref_cnt);
>   		dev_dbg(adev->dev, "Selected partition #%d", sel_xcp_id);
>   	} else {
>   		dev_err(adev->dev, "Failed to schedule partition #%d.", sel_xcp_id);
> -		return -ENOENT;
> +		r = -ENOENT;

Doesn't this require goto out as well? Or, for simplicity you could use 
guard(mutex)

Thanks,
Lijo>   	}
>   
> -	return 0;
> +out:
> +	mutex_unlock(&xcp_mgr->xcp_lock);
> +	return r;
>   }
>   
>   static void amdgpu_set_xcp_id(struct amdgpu_device *adev,

