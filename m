Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A35BC61D97
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 22:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A94D10E6AA;
	Wed, 22 Nov 2023 22:31:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A0E10E6A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 22:31:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3yZu7UJoWJ591WrBNHYSKJE4ImXcXDtOcSRoa+4NbnT6FDDJwPrScwJ6kQjQDLK3TABSDxWAZbujgQUAsvxaS3dCc5dx77Jpi9vOoiZUalnBCawRNK6oc/oWUC/3CVRPnvELNP0hArGBWVinji5FdLSarCqBiBXS5I3v1xQ+1LSu35Mohu5ho+UPIUNLJ37LJHKsog/mGSqh4p6cwufiYFKm1o+g5eFP9988wXehCgDCBCGVjOWGbpwo0a67QHitj/MamCXOZSEBcQrb/Azj5uZpLsDsPCv8YGga9SqYpimVpjBnmlAF3U9jQoxAdnhyHcxOynnM6lkF08TZ0wTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YirDegh4Dy6+0hdttyvn/E9YRf+gDn91j40ns3fT1w=;
 b=UnTL3pI6vSzZS7X4Smmv+9BTfEMiabnwN8Zz1mRhvY3HAvjBzYXTJ3cWLqZl3+LE8Ha895KxpVFMFSV0w6ctfy3l6+vmbwgM5O0BUDq16W2DWTEN5qsXrd+CpOvwpWoWD9blKpw3BnSGuEeNWqCY+wd4Cbq6goAeSKXZfjluTO3rLom4GyWUoWjU2vtJgOUGZweAKl6I6rpmxp8J1tyWQWfmJKd+i6iQ8JXaP8F8nOM3ArUzdRY/wvVtrvxwzuAsQIezv1BVWjmkwd/ADohikrHbR+5lNqyeo3eIFkFfehAF/2dgOF3E2pzxv4afVJAhiToHWmCxY67sS0rG1H3JDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YirDegh4Dy6+0hdttyvn/E9YRf+gDn91j40ns3fT1w=;
 b=AwihqzzbvrqLWmhnEgtDrX3+bP/pCF47Kv/ymSHM1KuUUGhVPggAA+gU+l4ezWWf/cQ8TvkBE7e/kNsSwLrBmCLoaNqNh3CrvJN5y3o/Pfddih9EwiYt6+pStXL30e86pQq/WZAn4rLSvNMZRjcSeJcMOr+5ZUhvgN1K3bhyPp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 22:31:48 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 22:31:47 +0000
Message-ID: <6738fe40-7051-4b5c-9151-3eb7428c9d00@amd.com>
Date: Wed, 22 Nov 2023 17:31:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/24] drm/amdkfd: enable pc sampling work to trigger trap
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-21-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231103131139.766920-21-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0297.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f213e8-4dab-41c1-99e0-08dbebaad054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T3SwjjWq3FNxDrygBMWJtYLw5oc95EHk7eUpRuQwkD0OVCAvkZrqA7YyhRKQoxqHfzNkp4iSacRe4SKONRVtJKP4x5gV4CDowsWKjXOBkwDClT5LNhYL2MeGY+ABWHyhcklVy5FmWt0iJvnSCLkvH9/aKaO9yUARbzBiqFPdr/O0DmXAlQhRf3PB0e7ig/RmH5w7vokm9zeZ4wGp3ZFjyg5brPqR2DqHlnGztfl+nzytjU94wZ+ipMQm/xPo+/3kajzHpvjvV9cpbPASCnaeV9AE4BCVozkCwLGMf2HJhbIAunBzYjemIqifqklJYbJ/Fez/vz7s/ljQyxty+wMRML4Ei0r1KjrQKn1ohs7WyFsSz3mL79PJEVhy3LcIKxGA7VW/4lfUwvnB/koyAcqUGJ51IizbEItpvqBZ2SlvXYrTIECK1HqhBccru8tx63m3UsaVPmJ8yjBpRGPMSRiVqdk7Irifu0xr9aR4iCyjXQU9hWc6cuY/Jl8JFQ2ttwnPUr+A4oN+Y0IR39I0JE0OkaQ9MzS3ENbBjhGQP/N0YNowJhfszXzbBAQ51odpRaG+vwG7sy5eEUoFd0Blgf8S7GeJ8cFk/dZ4b7ea7aViQwhXcrJjBnS41gT5TxIEmoL54paJE45uPXtJgnUK8pzdRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(26005)(83380400001)(478600001)(6512007)(53546011)(6506007)(36916002)(6486002)(86362001)(44832011)(31696002)(5660300002)(8676002)(4326008)(8936002)(31686004)(38100700002)(41300700001)(2906002)(66946007)(66476007)(66556008)(36756003)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnkvbmwwaEp4by9OTld0WkRaVm5TcnRydVJtVmlWelA3bVN1QjlaOWFkaDhO?=
 =?utf-8?B?YzlQdGpYbm5tdEF5emVqd0p1TmxqYWhPWUMvd2xVUTYra0tTZjg4dElJWGhQ?=
 =?utf-8?B?QTdVa0xKVnFlNGxYS29YR0JVKzFkZVVacU15Z3VWZE0yNEdzMm1lZjNGOFZ0?=
 =?utf-8?B?UHhPWVV0YTRpTkhHSlM2cmI3R2Qrc0haeVJZMmEyNTkvckdwcmhRM0J2S1pJ?=
 =?utf-8?B?TjVGOUtnOWMxS0g4STNVbStCLy92TjhJS284Wnd3bzVtckE0TExWakVrQVlZ?=
 =?utf-8?B?SDk1ak5zcmx2YitmVGJPck1aWnFGUnFpRFFDQ0xBK1JiZGl5aklpVjJoeFBs?=
 =?utf-8?B?ZkR1VTlVZ25wNFZEdFNMeDlkZC9CcE5XS2Q4L3F3czF2U1A5dFZMT28rdlBt?=
 =?utf-8?B?aFg0dFUrb0xheGZkZnFta2llczIwNTBYcEdKaWJkNGJjZEwwa2t0aXRjdis2?=
 =?utf-8?B?aEFveGVxNXJmbGdoODdWSGk0aDV1SE1MSFIzbjJkZ3diM2d1Z2lCUmxBMlJh?=
 =?utf-8?B?NkhRYTljdzh3UDlYYjR5YU5mUFBmTldOQ3dJL1NBZno0dEJnVTYwL1dMdjBS?=
 =?utf-8?B?UG53R3VwYlN5MFgydUlaMFlQaWlJUVlERklGbE5lNUlxTXY0bnErZ3ZwK1Vy?=
 =?utf-8?B?VFBua2IycW9HTW9jaDJRZFl5NmhibHQwU3p0T1Ixb0VEdG44TG9WOFhLSWZx?=
 =?utf-8?B?Tmlzb0hOM3c4RHU0THVXbWNMMmNxL1NGNExpTi96MElPYWVQOWVvcktqSHpW?=
 =?utf-8?B?WmtBY1BpU0YzWHZQVzBLN2lFZ3YwMzc5WS9YOWhqQ0UvZGg4aTYvb2o1WCt4?=
 =?utf-8?B?dGFuZmp2TTFVZENaenVjSTdHYXQ3MXhxTHRnTDk1SjEydXZKb0h0TlVnUmd2?=
 =?utf-8?B?MVNhRllxVjdIeEszV2lvNnZMUCtyNDVEaXpWRmoxU2djTVVtLzMxMDMvUGJP?=
 =?utf-8?B?cDZ2VHNkSDBUM0VQK2xqL1U1dDJpeStQcGpGc3NyOHVIbzFBTVNLSHdvQW9x?=
 =?utf-8?B?TDZhVHpuRGJ6Rk51SWVkYjhTV0FCNXVmMDZFQytGb3B4aWdsYUFvWkJZMU1N?=
 =?utf-8?B?b0lPTnp4S1pOc2p6M0lCUnA1d2hyUXRDTm9VK0tHdklvMk56bGxOaldJQTRE?=
 =?utf-8?B?NjNPYVEyT0xXcE1Sekx1dEVHWWNmMm45c3ZTakZFOFUvSU85T0RGN1dEZVZX?=
 =?utf-8?B?VkYvMHdSODlkZlhxME0velpybzgvWkJnNGRpOE00UXpWOUFQOXU0a1c0ZTJx?=
 =?utf-8?B?WTZUUjBCWGFoekJNV3REaUZBVHZDV2NtdmRKbW5jQStWSHVudFdoaTZBdTE3?=
 =?utf-8?B?c0sveTJPcnpwdGVscW5JUmE1RzJ5YlFIOUduL2N5NEJuM3FWR1p3M3RkMHN4?=
 =?utf-8?B?bkVCalA5M013V0J1S1p3b2ZvWU03V1YxT3VaMitaMXhtai9Xb2hMbVQ0UmR5?=
 =?utf-8?B?cVBnMXhaanJBYVlLWEdlZTAvN25uZ0t4TGprNDJpVFdYNFNpSHh3TXhOMjdF?=
 =?utf-8?B?UjEvandjSTk0SVNFMVNmL21ESE9HbWdpZmhkL3FKZXcxcnJKM1VPQitLRGN3?=
 =?utf-8?B?TllTY2p4bjBGbzRFSWZpZnBCZlpQRWlrdno4UlJjeEl4V0c0NXhEMDdjUTRh?=
 =?utf-8?B?aTVNQ2NJL1hkZDZ6L0h2Sjc1My9rbHRGL3E3NmVzY1YvK1d2VjI5MU4yZTlK?=
 =?utf-8?B?aDJmbDc1cVhzYlBjZTBrMEZKdGNDVnh4cUFkR2dSaWhjRThmdDJDTldIQ1JG?=
 =?utf-8?B?bE0yTS9jRjFDRFpZeXpKek1MNGVqTFFnMm1FWXpLRk9HV2VFc2tEQmpiSzVu?=
 =?utf-8?B?Y1dNK29jdElxNlhOWVRKdFdBQmErbmhiSkQ2T0hPSUtzdmM0Ky9CRjBObVA1?=
 =?utf-8?B?RmlyZU0rMU0wZW14UVVZd2YzVktkZEttdnRJRHgwblk2RWZ2QnRDV2VuaExD?=
 =?utf-8?B?WHhyZDQ0M3pWZVJsazk3eDRSQkM1YXhTQ3hPN3Y3cDFlRlR5d2ViS0Rrc2lx?=
 =?utf-8?B?NE91d3dGR3JFemJFb2ZJQVdYNFJLWjd3MlJ2aG5kUDFWMW9XbU9UTlpmZTdU?=
 =?utf-8?B?a2FubEFxNzJrc0svUEpsclR0WGZoL0htWVorYkJjbHNEczIyWE9qMTJvcXlS?=
 =?utf-8?Q?zoMvbK1E5kN6vzTu89zkpNUtu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f213e8-4dab-41c1-99e0-08dbebaad054
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 22:31:47.6823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbHgxZfQ/szJ5KNsXgDuXh2woDX/a+9kQ7t+z526cg8QGJRkuqVIgCy3yRQya3iONSCw0yzmV4fPh7b7c6PooA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
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
Cc: joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-03 09:11, James Zhu wrote:
> Enable a delay work to trigger pc sampling trap.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c      |  3 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 39 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  1 +
>   4 files changed, 44 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index bcaeedac8fe0..fb21902e433a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -35,6 +35,7 @@
>   #include "kfd_migrate.h"
>   #include "amdgpu.h"
>   #include "amdgpu_xcp.h"
> +#include "kfd_pc_sampling.h"
>   
>   #define MQD_SIZE_ALIGNED 768
>   
> @@ -537,6 +538,8 @@ static void kfd_pc_sampling_init(struct kfd_node *dev)
>   {
>   	mutex_init(&dev->pcs_data.mutex);
>   	idr_init_base(&dev->pcs_data.hosttrap_entry.base.pc_sampling_idr, 1);
> +	INIT_WORK(&dev->pcs_data.hosttrap_entry.base.pc_sampling_work,
> +		kfd_pc_sample_handler);
>   }
>   
>   static void kfd_pc_sampling_exit(struct kfd_node *dev)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> index 2c4ac5b4cc4b..e8f0559b618e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> @@ -38,6 +38,43 @@ struct supported_pc_sample_info supported_formats[] = {
>   	{ IP_VERSION(9, 4, 2), &sample_info_hosttrap_9_0_0 },
>   };
>   
> +void kfd_pc_sample_handler(struct work_struct *work)
> +{
> +	struct amdgpu_device *adev;
> +	struct kfd_node *node;
> +	uint32_t timeout = 0;
> +
> +	node = container_of(work, struct kfd_node,
> +					pcs_data.hosttrap_entry.base.pc_sampling_work);
> +
> +	mutex_lock(&node->pcs_data.mutex);
> +	if (node->pcs_data.hosttrap_entry.base.active_count &&
> +		node->pcs_data.hosttrap_entry.base.pc_sample_info.value &&
> +		node->kfd2kgd->trigger_pc_sample_trap) {
> +		switch (node->pcs_data.hosttrap_entry.base.pc_sample_info.type) {
> +		case KFD_IOCTL_PCS_TYPE_TIME_US:
> +			timeout = (uint32_t)node->pcs_data.hosttrap_entry.base.pc_sample_info.value;
> +			break;
> +		default:
> +			pr_debug("PC Sampling type %d not supported.",
> +					node->pcs_data.hosttrap_entry.base.pc_sample_info.type);
> +		}
> +	}
> +	mutex_unlock(&node->pcs_data.mutex);
> +	if (!timeout)
> +		return;
> +
> +	adev = node->adev;
> +	while (!READ_ONCE(node->pcs_data.hosttrap_entry.base.stop_enable)) {

This worker basically runs indefinitely (controlled by user mode).


> +		node->kfd2kgd->trigger_pc_sample_trap(adev, node->vm_info.last_vmid_kfd,
> +				&node->pcs_data.hosttrap_entry.base.target_simd,
> +				&node->pcs_data.hosttrap_entry.base.target_wave_slot,
> +				node->pcs_data.hosttrap_entry.base.pc_sample_info.method);
> +		pr_debug_ratelimited("triggered a host trap.");
> +		usleep_range(timeout, timeout + 10);

This will cause drift of the interval. Instead what you should do, is 
calculate the wait time at the end of every iteration based on the 
current time and the interval.


> +	}
> +}
> +
>   static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
>   					struct kfd_ioctl_pc_sample_args __user *user_args)
>   {
> @@ -101,6 +138,7 @@ static int kfd_pc_sample_start(struct kfd_process_device *pdd,
>   		} else {
>   			kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
>   				pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, true);
> +			schedule_work(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_work);

Scheduling a worker that runs indefinitely on the system workqueue is 
probably a bad idea. It could block other work items indefinitely. I 
think you are misusing the work queue API here. What you really want is 
probably, to crease a kernel thread.

Regards,
   Felix


>   			break;
>   		}
>   	}
> @@ -123,6 +161,7 @@ static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
>   	mutex_unlock(&pdd->dev->pcs_data.mutex);
>   
>   	if (pc_sampling_stop) {
> +		cancel_work_sync(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_work);
>   		kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
>   			pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, false);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
> index 4eeded4ea5b6..cb93909e6bd3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
> @@ -30,5 +30,6 @@
>   
>   int kfd_pc_sample(struct kfd_process_device *pdd,
>   					struct kfd_ioctl_pc_sample_args __user *args);
> +void kfd_pc_sample_handler(struct work_struct *work);
>   
>   #endif /* KFD_PC_SAMPLING_H_ */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index badaa4d68cc4..b7062033fda4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -263,6 +263,7 @@ struct kfd_dev_pc_sampling_data {
>   	uint32_t target_wave_slot;  /* target wave slot for trap */
>   	bool stop_enable;           /* pc sampling stop in process */
>   	struct idr pc_sampling_idr;
> +	struct work_struct pc_sampling_work;
>   	struct kfd_pc_sample_info pc_sample_info;
>   };
>   
