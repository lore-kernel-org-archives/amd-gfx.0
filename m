Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B29DD6DDED
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 11:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BC2710E85D;
	Fri, 15 Nov 2024 11:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pHznNeaw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E23E10E865
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 11:31:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/eXkfQuXTPGMfDBR0oVTxB/JGghoQZlgmEZsH4mQNUqiaLPs6k0NKmU1bAI9YG2sJS8BZJzJD45Iy8hWUD+Wg/QuVgnqbm8YBIkOJb2rKLhakCcsX6E4C7vZnLjYoJtroOL4Sp4s8a3uBEXbvbrMBZNPGjzAgPPLEJh4sGOaGbzwConxPmGcMXZlw+Uyt3xAh8YdA9xMYLXXwqnJQisxVVUw21JysCDYg9c4SnlJWFBjL92CFvUu7leLq7fNQdMz6MKKWUsuzzd7EQiT3HybMJvnfO6E89nQJGV3MIu7RlOzOgu3oNohyI7prgFSdg2zUrLi/Wc/0oh0LVD+AHtTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeHwkwpPSMdhGTwbVss1+fjUazrsBWA8RtKLFUy6tDw=;
 b=aFJGD9656gvxiKSYxJ5DA+Its1f4jVW80PRp3tkzHPKr+LSESrFxf9mEfNmtoHn9OX6RYZ+AKOrlR7PEzuU+AbslAZqDikVd19DtNV1r2Sw0JpC6prUmEYObPfg5aSDw7kd8U8Cwh3ZtreFPBpMw3Q7x+CQRh6Zhh9xm7GAr86QoRWEFZgtBnDAFS24NDzCFNnHpLl6Lb27C84h1iAwVlGBEjSINOqStAgxv29ZHx2JdStWViCdDMIwtPSXetTiicQkoY4Uu7yplHFEwk0MM6hXiHopE8rBFwEt8/iK4tn0OeeX0551WGviuKW5QBRHELYFhDauZ0f/q6DE2qY8FaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeHwkwpPSMdhGTwbVss1+fjUazrsBWA8RtKLFUy6tDw=;
 b=pHznNeawh5zsc8bvMPcxP5JisQ2gLM2z2qCWqpDQnfK8zN7VDrrPRRdOwXAwVM5lPwSM6fBr4pvEAFJsuTZZ7UF1p4pydc8jjxM9sLHIQmJhgXRljCLbu/kSXYZFWbmfp888OE9lcQm5mCOQ4ZM7vsSyWbSc2ZbBOzGbH80tv34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Fri, 15 Nov
 2024 11:31:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 11:31:51 +0000
Message-ID: <211e8305-8d5e-4b3b-9074-387a48f97cc8@amd.com>
Date: Fri, 15 Nov 2024 12:31:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: make sure ring buffer is flushed before
 update wptr
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
Cc: monk.liu@amd.com, philip.yang@amd.com, felix.kuehling@amd.com,
 alexdeucher@gmail.com, lijo.lazar@amd.com
References: <20241115095844.1487807-1-Victor.Zhao@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241115095844.1487807-1-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: 62601328-b8da-4878-6bde-08dd05691963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azEyOU1xb2x5L25Lc2NjVis0UVNub1dFSGpYUUlwVjFvTlZkTkdBbUFaL3N0?=
 =?utf-8?B?MlB6ZCszbDk3bGVRMEtFdlFDbGdxRVpPc1QxR0FETmFQeDZHSkt0ekxUMTFk?=
 =?utf-8?B?Qko2TS9VV0VaYjFmMWRqNzdQWllieUdEUFpKeEZya3hVVmZXVllZUEZ0VlhO?=
 =?utf-8?B?aW52RTFXSjdLK2hZdHdPbTJhZ0JQakFjVktPN00rakxNRmNWeDluYjNIZ2ZY?=
 =?utf-8?B?TW04VHduUVlzMHBOSHI1ZkEwNDFLcFdhZTlvd29Kc05wZm1peXNPa2JTM3ZZ?=
 =?utf-8?B?NEZBSFl6dmF0dUlrdHVmSFMwYzJZOU5XL2dEQ2c3M2Z4MHJjMmlEMDB3QXdR?=
 =?utf-8?B?c3JIRmpaVUJHUnpRYzJIeUE0RTQ5OG5yOWVjcDF2N1NkMnRJckFuYk00MHdu?=
 =?utf-8?B?R3NpWjl1NUFlTkE1dHNDNGN6M3htMVc0SXhyOGhlQzdiT1prMmFFdTUwOUlz?=
 =?utf-8?B?Ry85dEluRXZWSUw1WXhYZ3hQVGpURklOMXdjUElwUC9Ec2dBRlRhNUY2dU5m?=
 =?utf-8?B?L0tYNy96NEtoTEZha0p1VzFwamh5aktsZFU5aEViU2M0MG0rVC9XNzEwdmhP?=
 =?utf-8?B?WTAxUDJOY0dMTDNOUGdyK3QvZHJMS2ZMZGV5bEhLS0hRS2pKTklmTitLZ0FL?=
 =?utf-8?B?U3lxVEFBaUNWRHgvNG12cVoxZ1N0T3h3NTYwVWtvbTRJWFlXdXpONEx6VDhq?=
 =?utf-8?B?S1JDM3dlVkZBWFg4aXdGa2l0YW9aWWxiUGhJWFlobnEzWTVHWFJvQXRwZnFK?=
 =?utf-8?B?SE9USlViU1RvVGwwRkN1ay9TcE9XS3JYbDNwU0pJSW5aU21NTUF6Nmp5TlFs?=
 =?utf-8?B?YkJ1amd5UkRYVkRsRGxlQlBBYXIxMjltSHRKN1praDRhSWhxb1ZhZDVDMGtp?=
 =?utf-8?B?V2VMVm5rZk1IN2dZNkJzOWZEdVhPK0lWVTlrM3dpMTM1YTBrekRwOEZlbEN2?=
 =?utf-8?B?UnZBMWY1L3dCVDFtTXVrZ2Erb1ZqdUJnYWUwZVVnZEl2TWxnMjVBTVBoZDZ5?=
 =?utf-8?B?MVNwY1lLaEg2Sm0rTjhBSkt5czVvNUNjMVJ4Mk9SblordFRjOHdmUE9xdjRQ?=
 =?utf-8?B?TGVxdzlBUm1yWmZtQ0hTZFZWQ00xY0xwM3pvL0Vzb25ZeDdqd3ZzdHZDS21L?=
 =?utf-8?B?SFFicE5wMU5lQy9vRmpPV3NQenpRRDFieEdudm55UGhoS1BDOUtPTkZ6WUxW?=
 =?utf-8?B?UkhRYWFMMWtQM1NDeEZ5b2VEa1B5TlAzc0FYZWh0QTZneWdCNHJXcHZ0TGhr?=
 =?utf-8?B?K0dHMzY1UGREL29ic3BncXE2bVY5cHNPQXB3L1VkelF6UzRUTmF4alRYMUg5?=
 =?utf-8?B?cEdvSGtmR0FoYVJwWE1ZMjl5TU5PQXBSNFFvdnBlVmg4cm1yVElPekVPNkl4?=
 =?utf-8?B?dEoyUDBrek1JRng4MnBERmNvelFCb1ZDaWF4VXord1hVWFdmQzlRZ3E2bWZk?=
 =?utf-8?B?RU1IbWJKa3l2VVk4UktRcW1zSStWQWdDZDJKaXJSZVNJNmdjYVN6QmRDR01h?=
 =?utf-8?B?N1NTRVZMSHBYQlhKaUpQUlJrUlNSdlZZM1plcGlNa2dPTWJKY2lsTll6TWZ1?=
 =?utf-8?B?d0N1blRtYnNNTHNZSURJZzYzOEMyK0hHdkJUSTBrQytUdkRudDNxYUo2WkZY?=
 =?utf-8?B?ZlgyYmJaNnNwVHVuNzU1WFdOYU04RnlKUlVGLzdyTGF2N3JMOTM1SFNkanVy?=
 =?utf-8?B?VTI4bFVLdVJ0MWdDQkNTR0ZNVnZuaWxzVklYMHkzMmM4V3Q5eDBqek1qM3Zk?=
 =?utf-8?Q?0jgm0V0CVtYkf75/WkDmXe1PuPI38rOvPj4ATp1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjgwbUpXbFlENUpha1NacVVFVFJmSlN2UUJpNGs2QzdlM3JrWVYwYVdjWVpE?=
 =?utf-8?B?T3I5bWNtK1RIRCsySWRObDR4djA5Y1YwQlpIWSs4V0pTUGluRG0xazd2OXhk?=
 =?utf-8?B?WFA0YTZWZ3llNzFsc3BCSzc1dlV6UTQ3bzR4aTNQSHg1dGpudkpvTGUzc2kv?=
 =?utf-8?B?SEp2MmNIR0trbUNUNGkrbWNpaVFFdFF4UGxodExHSXJrOVFlWVlNSnd2NVBN?=
 =?utf-8?B?ZWU4VzNqZVh2ZkRHdFRDdUNKUmdzWGxrSlpZQ2RRdjFucWhsREt0Zml2cW9x?=
 =?utf-8?B?V3hITGlmQlFxUk55bENUYmtBaVdzZE1Vb2VOK3dYWFJ4Uy9TcFBNNlk3NHZi?=
 =?utf-8?B?NW5nN0l5WE9pZG8raDhqSmNEUksxMGZrbVUzcUlwVGsxQW84VVIxMXhOallr?=
 =?utf-8?B?UmtrODVacFFUK2x0WGJQSDhQVTJZMXdXZUx3dFdFdCtPMUFWSlhFUU1heDRF?=
 =?utf-8?B?alFUM3BqWEZaVlAzYzFUNjZTSnJHRVlMNlhhRWU5REh6cUN4aXQva1oyUXRB?=
 =?utf-8?B?aHZnZE41djRDRHIzTUhDSEtIOWNQVW9YbnNnbzVWZ0d4OTJoQnQveWdwdzY4?=
 =?utf-8?B?VXZ6ZElqMHFSVkdyU3FwTGZsWXFsQXNnZXlVLzhWVUxQVlJhOWN0RnEyTDJk?=
 =?utf-8?B?ZUZkQXI3aXJSbW5ZY3gyWWx0MkhOQWZmSGRTU1drNXp2VjdwWE1tWmxHNWla?=
 =?utf-8?B?QWEzY3RZeHZTWGxLY0ZoU1V0UEN2V0hGVmd3bXhPR2Z1ZHkzRjZyNDBpZ2Mr?=
 =?utf-8?B?bWkzQzJZbzVXWmw5ZlovclFPRGdSZXpoTXloSjVPTnhLdWlNMmJ2eTJmaWtY?=
 =?utf-8?B?TWZlTy93NHQzbFhIUVhXT2xNemd4ZHlCOW96ckJoODdiMmRKTTJiTGo2L29S?=
 =?utf-8?B?TFBLUXQzaDYzL28yQXlzazBZUG0wVnF5djJXemMxNjVYSWRLTEVLUEJWUnpj?=
 =?utf-8?B?RUVwTE1BTU5YM1BOaEFTR3ZmV1FFd3ZOOEdlanh6Z2JJNE0rYkJhMkRtQ0Jq?=
 =?utf-8?B?Y0kxSm5aeGFqRTYyYkdwellBRUtORWt4ellKSHFVWUc5bUFKSDNmZUVKdnA5?=
 =?utf-8?B?TVBBK1BLVnhwZUhqbXIrM1l4SzNXeVFMaUdHdVljaElaSTVYVk9ZRDZCQnRa?=
 =?utf-8?B?Wjk3ZjRsSHFlKzZOMFdaWTE3TDhkTFNieHlFbG9KSzJXQ2JjVURKNnpjK1lG?=
 =?utf-8?B?QlRnTWNLaVFrUzJyWWhJSUsrQzUvc3RVcVdoc3dWNWp3M016MkhKSkdyM3p5?=
 =?utf-8?B?eE0yQXhmNEpaM092QVgxNmdhL2RIUjVmakkxNXZEcWJpb051ekl3eU1YUEd1?=
 =?utf-8?B?OVpzZ0wzR1Z3SVlzL0xLdWRaN09vcDFqai9vVWJOZk1kaVIraVh0bWtlWTlm?=
 =?utf-8?B?OGJ1NmhUaTlZdytVdkF6UlhXR1l3cStXY2VjR1FnZGVmYjR0WVdlNHNKN25V?=
 =?utf-8?B?cnV0S1lGekc4a0ZYelVFb2h2TlhJVDVnN0IzQWVUVUxXNG5tMEZoR3lWd2w4?=
 =?utf-8?B?Nnc5UXZPRHR2TDN6TTIwcVY5bk9wVVh6bDBRM3Y0MXNTbFRaWmwvdXNBRlBQ?=
 =?utf-8?B?c2ozT2FoNTEzR01vVlAvMXFEYXlIOFZGbXA0ZXh2ZVE4TVNKY0pRZUprM1NT?=
 =?utf-8?B?SDRnM1VHNlhSMXNyNHlRSzZ0QU9YaGlrMlIreWxQN1cvTHkySFc2UkdZRVp3?=
 =?utf-8?B?WWhHQnZvREtIQ1NzT2ZwbGQrSGVoSWR1QnlkeFQxNitmMkZ2U2JKNmhMc2pF?=
 =?utf-8?B?ellJL1gwRkcvai9rSWdqelZUN25DM3J6UHlrTXdHeU5LVktDU3YwWncva0dR?=
 =?utf-8?B?SHFJL01vNG56RTJFUGZNVWx5RGhVYkVxeTBKYWJES3M5dXVGMkVlWU1rT1Ir?=
 =?utf-8?B?Uzh1WWRiZWpOR3J6Zmo4YmR2amlBQjRFZXM0YXMrUDl6bm9kUTlmdGE0empj?=
 =?utf-8?B?WjdTUjFVMUJ1NkJFamFPMURmV0hQVzUrQm5tVnEzbkNDUkpZaTlHaW1yWlg0?=
 =?utf-8?B?OXdvWnpOYzdTcUVVME12cHdhNkk3eCtUWTJOSDFNb0UyWWpibitreXBweEI5?=
 =?utf-8?B?WUtGL3lqVFBSYmpFUERmTVNjSjFFMGxNcTUrTUt2Ry9HcVV1ZTQ5eVhCWHYw?=
 =?utf-8?Q?MEVKL+Y+EsW3Pm/t1DWGeMRV1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62601328-b8da-4878-6bde-08dd05691963
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 11:31:51.4504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEuyZ7j7xL/OHeapa6J8MAp6NIcFCcyyCOtO+YsLy4j/Blym7H+xxnnVFxJxOGc9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5628
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

Am 15.11.24 um 10:58 schrieb Victor Zhao:
> In a consecutive packet submission, for example unmap and query status,
> when CP is reading wptr caused by unmap packet doorbell ring, if in some
> case CP operates slower (e.g. doorbell_mode=1) and wptr has been updated
> to next packet (query status), but the query status packet content has
> not been flushed to memory yet, it will cause CP fetched stalled data.
>
> Adding mb to ensure ring buffer has been updated before updating wptr.
> Also adding a mb to ensure wptr updated before doorbell ring.
>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> index 4843dcb9a5f7..55d18aed257b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -306,12 +306,17 @@ int kq_submit_packet(struct kernel_queue *kq)
>   	if (amdgpu_amdkfd_is_fed(kq->dev->adev))
>   		return -EIO;
>   
> +	/* Make sure ring buffer is updated before wptr updated */
> +	mb();
> +
>   	if (kq->dev->kfd->device_info.doorbell_size == 8) {
>   		*kq->wptr64_kernel = kq->pending_wptr64;
> +		mb(); /* Make sure wptr updated before ring doorbell */
>   		write_kernel_doorbell64(kq->queue->properties.doorbell_ptr,
>   					kq->pending_wptr64);
>   	} else {
>   		*kq->wptr_kernel = kq->pending_wptr;
> +		mb(); /* Make sure wptr updated before ring doorbell */
>   		write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
>   					kq->pending_wptr);
>   	}

