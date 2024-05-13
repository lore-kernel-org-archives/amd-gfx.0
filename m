Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926A3C25B78
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 23:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31CAE10E351;
	Mon, 13 May 2024 23:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uL4/bBAN";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7819C10E351
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 23:17:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8dv92NTe81kvJRH2cztkNl90PAtSMjpAsKGXDZ5BLn0BlGb8qMbzZdqvNRzHKVa5uKccOC52g0u3Pv4kbxNsePcSvk1VtZKsi3QHbaw6w5YBTlw+FpOM45/8vVf2iU1wfM70XQwC/vVJmh8IMpJzkhI3vOPyTwFDl57YPNp5zHwi/Idgl7T14fPe+28igjBcIuqndCUkAqpchtnCx831Ko7ddQWkRxcDk+vDiJmV1mFE89Q3OZnIO6a5OQmx14Jy1OBk9XTRWrZjDJmuJEVOJqihLQmiou4x65w53HV4To3zhlBuv5JQqULIkfzq+5ogJ1ghKFOdetZ2zxcHz8pBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VV52J1TmM3s8E+4g1xWTOJx4/Cl7EPxpLokd9B0Q0s=;
 b=FCE3it22JF24kv2WWZ1gL0WepabJJmRZ2PZxFA5DYeWcEotIpO00obbh45vG4SK3dgm3pX+SkSUE7jtFO+U6AlfnDlopVCKxSWHcC/RLPvvDfCR6E5VYmOWU0gKfncpduvRd7yly8Tx/tUkhRbD5ZLZ+w2dXsyRmgFqlryfb4UMhxoka6aA7ezjdzeXEMdyXSfHmy90NjbhsZbKEoTFtpBM+1yr/Fx4zYVjaMpg9r/moPG5FwkvgLPNmvb3PrJZ86gPGk5MCs1kk6xIqxLt9ilP70gp6iUwPV16RFjz/XnTWS20ry7puisfymykmITa99/F8DiScAAcYKPOcri+rfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VV52J1TmM3s8E+4g1xWTOJx4/Cl7EPxpLokd9B0Q0s=;
 b=uL4/bBANMouOPeKTH/ELMgZLbGIThTrJOQVXFmeDKHXSIjNUi3Q/Y3evKjGiDgOTuff2VBD++fE1ME5ZEA+zPvBXXBLzK8Y53GxvcvXeSOX0vti4fSSPjlnOr3DDBtSjSTXbgKk3/yTuvklIBP26sBt78LpcWLF/wEvj2+n3fM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 23:17:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 23:17:41 +0000
Message-ID: <d04abc35-4bd0-4971-aed6-e4f09e1c84ae@amd.com>
Date: Mon, 13 May 2024 19:17:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/kfd: Correct pined buffer handling at kfd restore and
 validate process
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240513151842.125976-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240513151842.125976-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: ea31e282-0165-43d7-b5c5-08dc73a2e31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHlveTh6R29GTFpKUDVoY0VXa0lNVzB5VnFBWGk5T3lTNElqaWNJcERJNU9o?=
 =?utf-8?B?ajZub0piVFBtN25abzhvMHFZMjJyaDNpcUNySDdGcjJWaXVKZTdXeHRjVnd3?=
 =?utf-8?B?ZEJ2ODRRcTUvTzI3R3NiWkdRaTZqeGZIZnQ1YWV3dGIrYy94RE1CUWRDdXJF?=
 =?utf-8?B?R3FpUkFqVlFoUWIyRVVhVjc1endOMnQ3blRkQlVOYURueGhTTGZpaUVTVW9F?=
 =?utf-8?B?OENHUVFCcld3MTFNT1I3VWJjeGVucVdxOHd1SUdkNUpRYlIrYXBZcGsyNkxm?=
 =?utf-8?B?UVhNTUJZZlA1akNQWVZab3VZWTZtamVjcXh6WVd5QVM5Tml5dGNQblJtQW9P?=
 =?utf-8?B?RnJDaU5YdHpCVlRGSGhRYkpKVE1FdC9aaWZYdk52Qm5ydFRZQ2FDVS9FWGxL?=
 =?utf-8?B?TzBoT0lyTmN3OURRL0c1dXhidk9udzM2TS81RTVoYWRFNGlHcUc0RnlJZ2th?=
 =?utf-8?B?aEh3K1Q4Mmg4dW05dG1XUkM1YU1EK0pVYVl0SGtseUc1MWhBUk9xcFc5NXdm?=
 =?utf-8?B?NTRuWm9SOUJ1Vjh4Q05tZm4zYXdnQ094em81Wkk1NncxUWRlam8wM2lLTFJk?=
 =?utf-8?B?d3c2cENLUUx0c1lhWHZVQndUNDVhSi9nOGU3UTJQK0syaUg3cjFzMjBPRnBa?=
 =?utf-8?B?SFpIeE4zVTYxNnhId1ZDT0dYcklOK0RaVXN5WERWenB0SVZhYmN1WjZVNGV3?=
 =?utf-8?B?dUo5bjVYYUQ4NDNMamE3cFdNRldnblpHZHRoTWluK0RxRmV5ZlZkVlk2TmNj?=
 =?utf-8?B?SkZWSW0zam9lUGkrNFdmN0pYRjJzMUljQlc3OXBmUG1PWEd6MmRCRzlJRms3?=
 =?utf-8?B?ODdkS0tzaEF1ZGU2ZVJhMDd5cTRmSHpZN1U2TXZsQ216Qk1SN2RIZU1yMEdJ?=
 =?utf-8?B?MkJHMGQ5M1NpM2E3bUVBSit2YmthTWNUVllYWUtNamhNcWFmUlRtTGxvdWRT?=
 =?utf-8?B?UTE0YnQyWDI1VmdRUEYvdHY2WE5zQWpPMWk4UkhUTEdaazIxNlRRTGdDUjdo?=
 =?utf-8?B?NUlPV1JtK3d3aGh6UTRQd0RBSDdUYkJvOFhEdW16cGFPekhOYUt4RHlWQk41?=
 =?utf-8?B?aUx3cDBwK0QvTlF4TDZaNzhHQk5XZFltbjZQRjN3T0IzSlErSWFUWURXckpM?=
 =?utf-8?B?OGtqODhkQkZUK1RzVjBPWlF5WlFadVM2R3BSOEg5clBVZE1STkxHMmJlMlpQ?=
 =?utf-8?B?MHUxQkRycjFXRFdMekJncU5QZ0FXZWJOUUFncmMwV1V2VGpRc0JOSGNPY3Fm?=
 =?utf-8?B?NzQvK09ocG10Zjc4a3Y5U2Q2L0ZLMURad3o4d2VDRjBSb1lONDJMdkZhYjFR?=
 =?utf-8?B?SHFhbEcrOWYyNVlQRzMwdlhIRGQ2ZGNLaUV5VE5QcktnVFZKWHF4Ulh3Qy8y?=
 =?utf-8?B?cUlscVM1MEthcktDZDNwRWdQLzJlQlhtSjJSZ0xiUWNlRmJoaytZSE9aT3hN?=
 =?utf-8?B?cDV4bHVHVUxveFdma3RjUXc3ZGhDbVJ3VlZRUjlGOGk3YzZoR21XeXl1S0lI?=
 =?utf-8?B?WjFhVTM5aG0wVGtQS2FMaW9lYlRJaGxxTEVKOFY4blRiRUtIbHNodC90N3BD?=
 =?utf-8?B?MEtidkxsOTl0OU9XVEZSRDgzZDE5cjFGa21pSkwvMExvU25Zb1lZTEkxWEhW?=
 =?utf-8?B?UHZNZnprQUJuSWRuZDM5Yy9aSEtBMWlVT2NEb1VuV2wySUwrSTFJR05ydURp?=
 =?utf-8?B?a0RYYWpmL28vM1hTNVVmdTEwTGR4ZG9HMVFCYWhQYk9UVVBpY0pjUFZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVJhUGRPNE5hZXdCK0s3dzRPVG85RmVKWkJSZUJVdU5wTGtOQmFQVVVLNjN0?=
 =?utf-8?B?Z0g1aXhvbG5pMHo1Ym9WdmxXcDNabGUzR3lWZ0gwT0lYc0NqMkh6TmFpLzVD?=
 =?utf-8?B?cXV1c0ovZjBUSmZ1Y2JaUFpvZVV3NEw5Y2xYTjdXdWZ2bE1tNUdRUDMzNHBG?=
 =?utf-8?B?MEpwQzYyZGxKaDJybEN0WUNVZDZiQXpiS3ppWWc1SHRjR1JDK2JMNmhDSDBi?=
 =?utf-8?B?dHBXL1VkM3JOZCtmc29VeTBBN3NiRUJFay9uN25rd1N3S2NJbk9zMW5RU21F?=
 =?utf-8?B?SDdLalVQeEx4Q1NBckZIY2g2QXpBVUo5MWl3QW1nR3VkOEZ4UUc5cmM3OHZo?=
 =?utf-8?B?b2RRK3lMenFVOW4vUE5rOUZWRENaa1dmNTBFbVRDVEcvamxkcnZrUjduWHkx?=
 =?utf-8?B?QUczVE9jOGRIbGd0YTZvS1dSbG5UaXhvdVRoQWNNWjB1ZkNvU29ZVlVuWEVH?=
 =?utf-8?B?MHVqNjlYdEd0OGQ5MXV5c2ZlY2tVcitVQjF1SVc4L2dHL2FPd2ovVU9DTnRB?=
 =?utf-8?B?ZWZyRVpCWEFBK0xydURyQWIvdzdmYlhSUzFOdE9Td2F4U0FWMk1mRFg1c3pQ?=
 =?utf-8?B?RXNOMnRuV2xLUDB1OFVFWGU4aS9hZ2YzYVdDc0txK1lYalRac0FoMmlnaVdY?=
 =?utf-8?B?UzhkQUVESEQrSzJpQTFSNytoV29Ubmt5aGFCU1hIL3VVTVBQejdLN0ZienlK?=
 =?utf-8?B?MkgxTnhrWEY5T3VQUWxlN3ZYZFlFMjh0VjJBSHhpVGJCMWhYeWRQSDNQam13?=
 =?utf-8?B?M2NzTW5vSVA0VzJoaGJHL3lxVVdkSlBNbFFHMDlvMWEwVlZnazIvTXY0ZFJx?=
 =?utf-8?B?SWxiaUtxemZqT2JKNVdKUlhhNDh2UUVRbm1qTWpNOHE2QVFMN3J3SThLRitM?=
 =?utf-8?B?SEd1a044bUUvSTJqRFNMVnZocUJ6S2dhcGptRWplYnFKUmt2U25ZbmxrMkN3?=
 =?utf-8?B?bUFmT1NlWU8wQko0T0R2OGwrNzh0MWZSMXVUTFhZK3Y5OGlKU1RKa0J5MnZn?=
 =?utf-8?B?bGszS0R4Wm1YaHgyMGR4S2NvekwzeXFveEJvZ0RBclR6T3gzdXZPTkpHM3M5?=
 =?utf-8?B?TjIra3dWVEdtbjFia05xWHE0bUZPVFBPS052ZmdNcURwa3I3blFkRDkzWHB2?=
 =?utf-8?B?N1NIMFQ3SnNLQXJCb1R6SFlwWmE1ZU4wajBEMEFiMUJFN0J5ZllKby9rMGxU?=
 =?utf-8?B?aUt4bGhib1NxMHFiajJGNUU2WHV4U3hFS2lWYThDY3hyeEVRWFRTVlp2WWpM?=
 =?utf-8?B?c1lud2t5dURPV0VhcGFPRVBkZGlmSTNnZlZobE5CR1B2M3VaNC96dnF4VWFJ?=
 =?utf-8?B?M2hzTGRua0VBMGlPYS8wd09pVHcwWTI5cjRGTEdsTmVYcVNPSENRTXJYVnVS?=
 =?utf-8?B?cnkyS0RTK3hTajlXRnQ5OFJzSTBUVmY0TjhLSTFrczRlUS9mNXp5Ym5RaUF3?=
 =?utf-8?B?T0Q4cjExc0hNYUhzayt3T0JQWEdwT0MwdnM3TE10MXJOendWVkVQbHd6SC9p?=
 =?utf-8?B?eWxKUHhia3hnbmxocm5sSGFpS0dmbGJMQnJ6QktsNXl6aHByUzc0UlhiTVdz?=
 =?utf-8?B?ZFhOdGhjN01GMW1ncmFsenNZTmRGSXZsMU4yeCtHWjljdTIwN3BhbU15Y3ZB?=
 =?utf-8?B?QmVBM2h0Q3cvc0VndFp4UldGYjR4eTFDcTltNGo1cXFvbER5WmVwSGRrbHM2?=
 =?utf-8?B?Ync2aGk0NEs0TjA1Q1RJeWswYW9TR0s4azVOVEVBbzNoM0F0dnBxRHhxNUNk?=
 =?utf-8?B?eEkzclNiUlkvclp0aXBrbU0xK3R4bTUyRmJ5alBDWHFlanNIVE13QWlHcTRZ?=
 =?utf-8?B?ZHhOWExJdy9MNFVpdU5HQkhScnRJOEhzblRhM0FiUW94cVZwTHBoQ0dZZlBL?=
 =?utf-8?B?cnU4SmpDMTI5RHB4eFcrQ3Y0Sm5hU25RYUUrWG1qM0hGK0F2MjVvQkwzVEtO?=
 =?utf-8?B?OHRzMEdvZ3hvK2FBOVY0T3kzNHdRbGw2ZlVKaVppU3hXY2xjd3dnM3FmNEJV?=
 =?utf-8?B?UHEyQmpEVjdSaG94WDQ5UExoVDJmSzVJclRsczdQSXErdXVkeWd0L0t2U0tl?=
 =?utf-8?B?WWoweGZnK1RtSGZqUWNkUGxKOWVRdDlobXNKUFRHQ2JkK0twMWpzZ3N4dTh6?=
 =?utf-8?Q?Xs9D/GKxxPpJsrbyfQR5h//fX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea31e282-0165-43d7-b5c5-08dc73a2e31a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 23:17:41.5248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBMZvUaxW2ogEvBDunDKXSZ6n3TfbW3ev7cwWnlVB+dWwR8zxu+wpzkFMpG4TN7OVs06VYBXSgqJOE3bEi8Wzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824
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



On 2024-05-13 11:18, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
> 
> This reverts 8a774fe912ff09e39c2d3a3589c729330113f388 "drm/amdgpu: avoid restore
> process run into dead loop" since buffer got pined is not related whether it

Spelling: pined -> pinned

Same in the commit headline.


> needs mapping. And skip buffer validation at kfd driver if the buffer has been
> pinned.
> 
> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 3314821e4cf3..80018738bd1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -415,6 +415,10 @@ static int amdgpu_amdkfd_bo_validate(struct amdgpu_bo *bo, uint32_t domain,
>  		 "Called with userptr BO"))
>  		return -EINVAL;
>  
> +	/* bo has been pined, not need validate it */

pined -> pinned

With those typos fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> +	if (bo->tbo.pin_count)
> +		return 0;
> +
>  	amdgpu_bo_placement_from_domain(bo, domain);
>  
>  	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> @@ -2736,7 +2740,7 @@ static int confirm_valid_user_pages_locked(struct amdkfd_process_info *process_i
>  
>  		/* keep mem without hmm range at userptr_inval_list */
>  		if (!mem->range)
> -			 continue;
> +			continue;
>  
>  		/* Only check mem with hmm range associated */
>  		valid = amdgpu_ttm_tt_get_user_pages_done(
> @@ -2981,9 +2985,6 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>  			if (!attachment->is_mapped)
>  				continue;
>  
> -			if (attachment->bo_va->base.bo->tbo.pin_count)
> -				continue;
> -
>  			kfd_mem_dmaunmap_attachment(mem, attachment);
>  			ret = update_gpuvm_pte(mem, attachment, &sync_obj);
>  			if (ret) {
