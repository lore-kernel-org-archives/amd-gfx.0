Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50D2C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 21:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A1410E105;
	Thu, 17 Mar 2022 21:05:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0958010E105
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 21:05:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PY9uyBcV2iapqURM8liURGMvm3jYiWggWP0OKG0F6f49PxP+u320HcQyJ3uj1qdMEIuPoGVnIC6r/kq30NTXZyVPQt4JyqAgPU/cl6SoVh8eQFPc96UbX1hpr7eo+QE1lf2UdVoWujoiD83HR9q7OnIhMacRg+lysXFReERDa9RTGFok6MdWpn56aIiGZT5PsQgK5Oa8xOLJcnupShsB0R36fxkJRz1AZYZ47Xyx1kgNYt/255Y6ehSkFiM7DnMhipcaw6GXB/sgaP4QtQixvvOjVD7RHW0cpsP4s8C8k+dYOx8toUl+LQxSvOQicnlslWGExNP2/vyTmri99igTfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufnSbrHRYpSt+oPvMSmeEbNxhatvFYQ7M6fB6nyeKAU=;
 b=AUcNdXL+ZHLo9bOlx9C/OUTBGTpcVSHVeBW637mqe7AKqEp87FsKVZEdndIn1QiLKq9pjQIZHcrRjt2S5E1r2/kr21V72Di9LW/Q/tYEbUnLEwIwrcFZiOQWs+pHkMOmiMXazV8gg1UO4Owj3jaZCf+SN+ulF587IbS/LmuCtuXt+/n4K5WjvSiECKEQJTUOoO7v6X1hXu6nALxF1lmkHnZT+kboSV23TqfvaK+O3rbb54lmX2IFZE2ET2SoOffm6Y2QoQjyzPVASBl0XoJuhF82Ept4bQmzGOl5tZCcYf8sR/bX3Uefz2Uk6Jx6xP/PX8NEOWJCGQNVvKXRRzDGBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufnSbrHRYpSt+oPvMSmeEbNxhatvFYQ7M6fB6nyeKAU=;
 b=FqCPjHCSBtn7WeRaJz7P6oqeJMNtiR8AzoNpPEx6WkbXeW6UnHJFHJCusmQ7PZVMK/GPbK7vUfD+wAWhMIE9pJ+WLHccSsNGyakTUhv+G95qWC/E1mMh9WXGN/VBufggLaetja8ECXxGWwj/RdRivATkWDEPI/Pl3kCXFKf8nHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 21:05:48 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%4]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 21:05:48 +0000
Message-ID: <147eaa45-9c5d-aa6b-570c-11d3b40d76ea@amd.com>
Date: Thu, 17 Mar 2022 17:05:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Fix Incorrect VMIDs passed to HWS
Content-Language: en-US
To: Tushar Patel <tushar.patel@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220317205703.130737-1-tushar.patel@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220317205703.130737-1-tushar.patel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a65aa84d-aa2a-42e3-4a3a-08da0859e8f5
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5968611F85D3818575C39C1092129@LV2PR12MB5968.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 08W2Ur+yV/2b4LzRCV7n9qFprCuiWRM62K2w5aQh+QADsHPypXK6NUGUX4/LI4f/pKS7TU3STMVPNBtKJ+M4fU8L/PFj6zgcLwXLFvG3iV39mdnbOiW2IAfl+OP+IZ7uDM5UdOO48eydwQKVXisisC2NrnJ1AwKoxlDAEwcXzdSRfflAZoke+vzkv9pihawNDpy5UsV/diG/qFM6xRA0EpwQgbk8MkKhTVWZBC/0iIw7ya4G9cL0NV+Wr9PnTmRzmR8ox1debGiRcktj1uSGgum+993x4XG8SzFHWhceYQtaYzQ23XlcA0z/wV1fQU0lOmeKw1Ic9Kxx7S9Uf9Z7HN881TGX8DnAroQJ0fAf8FoQXlEdcYgcrFQVBVC/821Fhtard2CwCHnkB3oA9DaF5LiedE1/9mbek3QOGnWdb7FuK2hbk8t/Znl0fU3nhExclln1KmmFZ/OVaYWt//GASK5+DJRHVe/q5+EV+zX7iqHO8Ix9XStVHJtT61FcsbU+x8qgzUE2GsERxOpBIhnStDJ1www89TbYmZjQIL5hSY9s9/5a1Apz3Bf0hu4PqArERW3RmCzm3pqg630gn/MyKvJNKuKGbZSjPErqCvkJVtSbQxP/qxKPdnjTxm5UrCcRvOIPnW7RvcO7jpc6zZKl+eqrypNbbz/njS+INtSsb+LPwTqpSNlqI+TbIhtJRmQvduRs10b4orlrIEcN6oghsAA0+knBbk2vmuwVhdkK4brDs5BdyN50zEBHLuzULdggj0rtlhMmMdA3Eq8hf9utoYt4NZf9r3ljC/LsxenlZC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(83380400001)(316002)(508600001)(36756003)(31686004)(5660300002)(8676002)(38100700002)(186003)(26005)(2616005)(66946007)(66556008)(66476007)(31696002)(44832011)(86362001)(6666004)(6486002)(2906002)(6512007)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2JTbCtZL2s0TjBsUjNyL2VsWlVidlBTS2tNQjJ1VEZ2a0s0Z2hGbXd6R3R0?=
 =?utf-8?B?L3V2TWMrOVhMMGNXRzg1dmJNMTBUWUhnZ0I4ZTlGTnU4c2ZxTmdlUzFlT21j?=
 =?utf-8?B?anR6VGVyaHVHODluYUZIWVdMSURDY1RRSFZZcUpkTlJNWTlHaVUxMk1oSFY0?=
 =?utf-8?B?V1liTTIwZ3ltcVZwcFNGcmpEM1hTbXp1OEw0VmFmVkZsVzZvaFJVODYyMzZC?=
 =?utf-8?B?YTBGU205bkdtaHNiZWZZWUFUZVRBWFhWOVZyeldORDFSQWlGU05ibGxvK215?=
 =?utf-8?B?SWkzTEdwWVBEWFo3Ty90UDJFWTViOW02RjRnNkFCZUc5WmVRRS9JR1hqUnFq?=
 =?utf-8?B?RGVrZ25DWUFuMWNCSEN2dVIvZjdvUVBUNHcxQW9xNE1UelVodk95YkhGVTdJ?=
 =?utf-8?B?TmQ1TC9SVzIxTndCclJmS1ZrQ3NhWFoxYTBEems0ZTJQbzN3WmFuSUJ2ZHFz?=
 =?utf-8?B?NkFwR1pJQi9wQUM3QTJ4VDZhbVU0aTNZbXE4ZXJHOFhoU05nMndZclgzN0Iw?=
 =?utf-8?B?MmowS0FDRDl3SXcwNjZBRmR3Z250cGJqTUIraXB0dXc4WENzcjVHMGhldFpC?=
 =?utf-8?B?RWRqbGEvdDdwV2pidTlxUmFjMko3ci9YUWNyUTVxWXp4MDR5YXJnZnNUTGNR?=
 =?utf-8?B?aVVPc2VWbWtEUmh1OFdhL0hCdjVIUHdocjNrWm1ZYUVKZlp6dXQ3WTE2dUhW?=
 =?utf-8?B?ZHpiYzJpcHl2ZU5JL2VYVnkzMUM2b3BqYnFwNDJ1MVFXMUVMNy81Z2F5dS94?=
 =?utf-8?B?VUFaOTBaZTNVREd0OG94cXBtVVZWaDJITVNVL1l0VjJPRmp4UXpTWVNpdHFk?=
 =?utf-8?B?azBXVkQyQm9kYzUxUjI5eHh0OXh3QlM5N3k0MmpnWncwajQ0OGRnVVFRQ3NF?=
 =?utf-8?B?ck0zNWMzdEZVMDVvUkYvdWp5RE1vdXpoSmlURk44VGNEd1dwTWxFUE9VVFpl?=
 =?utf-8?B?eDY2TmUxUHVFWit4R2p6eDZrM0IxZVg1MVpWczc0bENFS1Bua2swNjhnVzkw?=
 =?utf-8?B?c0lDaFhGeXkwMHRFZWdVVUQvZnhYREdCTTdYZGZabzZtMlZFQjZaNk5JN3Jz?=
 =?utf-8?B?bkhlSnRDWDdWa2VHcXZPd3JjQmJ2Q2RkWG1Dam1UUkI5bG5HbDVpd20vdWVO?=
 =?utf-8?B?SnZ2ODd6Q0RIM0dGVWo2QTluR1c4SWg4VERFekp3b09iMTJlTGx4TE16K1N1?=
 =?utf-8?B?STV6UDNMaFJaRlB2S0JDRUR1UTdGMDFialFibThObkFoeUR2Qnd1SC9CY1dZ?=
 =?utf-8?B?V2ZRRTUvVmhEeTZyUTVUUWc1TzNtZDhKanhaQXhpMllzQnlYVGdtRDd1N1Ux?=
 =?utf-8?B?QWZldWVtdUdidklYYkhHU2g5bFp4QlAxM0VlRGwvSEV3NnIwa29mUjMySzJp?=
 =?utf-8?B?eFg3RlJZbFVjcFl5Q2VRQXNaUHplYUVuV3poV1k5MDQvbmJJYWlUZWs1Mktj?=
 =?utf-8?B?Wk1vZjR6ZHJnU3M0K2JrWHc0UVdya2kxQjFtdHRGN1ExY3kvdmZOeFphU0VC?=
 =?utf-8?B?b0ZRcnhJR1hvOExJZFdtMTl4R2hjNzhkV0VXeHRNd3I0ODArT0FMck1mQUZr?=
 =?utf-8?B?VkhRdnlRaXB2TkY0VllDMC9jRmdHb1VsY1ZXcHVtZk80ZktLQmVDdktGdDBY?=
 =?utf-8?B?RUh5L0VueEFXN1daZmlTT1NGV2pGL3lDZU1rVXM5ZGdLUHpwdWd5eVArdUVW?=
 =?utf-8?B?UVpta0JzejRzR2dCcWQ0THorVzRQTDV0N21PdFB6ZmxlakZDOURFWXJLQTdm?=
 =?utf-8?B?WnVwWG8xUU9ienZ0OHoyakozNExPNGw2cVdQL0craFQ4QnhLejhBcHd2bFNL?=
 =?utf-8?B?Y1RYYjFOdjZaT0h4eFdreFZ3Yk40dkV2d0NpcWZvVHJOd0JwYXcxamVXQUNC?=
 =?utf-8?B?TmR2TnFvYTYydTAzZDNEZWdIc09HcXQzLy9BUE8wRGdVbjVxc0JhQjRQTHor?=
 =?utf-8?Q?t55fybkC6bg0KJLaviNn/p/gYIRx/ft9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65aa84d-aa2a-42e3-4a3a-08da0859e8f5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 21:05:48.1096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9b/VercNBprZzoNL/o+fvcK2gIDl5gQf9NzlcFMr+swKSjF4arYvdGZAzGrj2tVQGtm/byk581AtLICT6wVKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
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

Am 2022-03-17 um 16:57 schrieb Tushar Patel:
> Removed dev_error message for incorrect VMIDs
>
> Fix Incorrect VMIDs passed to HWS

This could use more of an explanation. The problem here was, that the 
previous default was based on an outdated number of VMIDs. On Arcturus 
and Aldebaran we reserve more VMIDs for KFD. That was never reflected in 
the maximum concurrency setting for HWS. This patch fixes that by making 
the default dependent on the number of VMIDs per GPU.


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 12 +++---------
>   2 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4c20c23d6ba0..bda1b5132ee8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -680,7 +680,7 @@ MODULE_PARM_DESC(sched_policy,
>    * Maximum number of processes that HWS can schedule concurrently. The maximum is the
>    * number of VMIDs assigned to the HWS, which is also the default.
>    */
> -int hws_max_conc_proc = 8;
> +int hws_max_conc_proc = -1;
>   module_param(hws_max_conc_proc, int, 0444);
>   MODULE_PARM_DESC(hws_max_conc_proc,
>   	"Max # processes HWS can execute concurrently when sched_policy=0 (0 = no concurrency, #VMIDs for KFD = Maximum(default))");
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 339e12c94cff..66074e1abc79 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -483,15 +483,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   	}
>   
>   	/* Verify module parameters regarding mapped process number*/
> -	if ((hws_max_conc_proc < 0)
> -			|| (hws_max_conc_proc > kfd->vm_info.vmid_num_kfd)) {
> -		dev_err(kfd_device,
> -			"hws_max_conc_proc %d must be between 0 and %d, use %d instead\n",
> -			hws_max_conc_proc, kfd->vm_info.vmid_num_kfd,
> -			kfd->vm_info.vmid_num_kfd);
> -		kfd->max_proc_per_quantum = kfd->vm_info.vmid_num_kfd;
> -	} else
> -		kfd->max_proc_per_quantum = hws_max_conc_proc;
> +	kfd->max_proc_per_quantum = kfd->vm_info.vmid_num_kfd;

I'd move that into an else-branch of the if-statement. That would make 
the logic clearer.


> +	if (hws_max_conc_proc != -1)

Change this condition to "hws_max_conc_proc >= 0". We never want to set 
kfd->max_proc_per_quantum to something negative.

With those issues fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +		kfd->max_proc_per_quantum = min(hws_max_conc_proc, kfd->vm_info.vmid_num_kfd)
>   
>   	/* calculate max size of mqds needed for queues */
>   	size = max_num_of_queues_per_device *
