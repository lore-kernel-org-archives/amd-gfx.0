Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F17C25B45
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 19:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 405C610E232;
	Mon, 23 Oct 2023 19:33:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9000910E232
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 19:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/1xLveHEfBhv2KLzMA5wwb/wN6yX7MSJDbEV91C6CaptLLlVEISds07l8OkNcNh2qqJ0g5ZS/Bvohg1yrvacna7AHXygvQzr/d3ja+l3S4mTTBEKjZVsdCWAXEhias1kxLwWFc5t5XZi39l7D3X5Ou6g+9dqNvKHqjjISgnFxqTTkhx/ALaaCaZ/5+TJGcgXGcfC3PlEO9xc2UHZHp6uFy8PzH/nghALCiWVrm2DMwIZBeivp95pJHARQrzyjvW3xSQtPAx6wxQTHFXiVIaIEFiJuwAPfGHpAnQthQxvbLVr6ePYTSz0dhpw/WzAIR4sXJ0uZVUoEOn62y8CI6WDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmqYOm0uNcSoQl3cfSgC0PnS8ak99uBOpCHtcq4AxlY=;
 b=NMeOkzTczcSxDRjMiIA0czRxyV0X890JAL10/lArrV+/gvJDZihxOUefuOfAGqNRKLERTx4CMnRoaNIBfAR+oX1bmqv5I+menigM1DER3xc/ZTqUKPIAE6wNNwM0mpuy9GSPpN++Cwoa0zZ4pqPrprAOU+pE/ZjpGkx6BqWZy3b8ah9Z2nn9aCk7vPzp1KRmwL8plmhW4vlz6NkXeTJxDcrtdELInx2hfIk4XFjr8WmiT6+zj+2Qmr39hdEBOwVx+fKRjL4gIFNHzGLPU2LYVXX3qlDe+r5NRbLHgZ4oXPCxBvSkGoHx2w+IC0UqUv1ATTUD09d/Qz5m8iUZ2JKxmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmqYOm0uNcSoQl3cfSgC0PnS8ak99uBOpCHtcq4AxlY=;
 b=y7qWY63C5kXWt9XYh257H4javPSClwfhEfYihVw1FCvssJMRSO02Xu+mA2jgwdRXj3GR9OVdJngp0PwElBPl6BN7Xx2e2Ki6hQ/xIA85gNipmf/juPGMnVqBmykcKRP3wf0+yqvn5jY1zDES0ggmwaGIFNZrcQqF8HOEVfkgOeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Mon, 23 Oct
 2023 19:33:36 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31%4]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 19:33:36 +0000
Message-ID: <e449e1a4-7984-4cb3-ab9f-344a3234ea21@amd.com>
Date: Mon, 23 Oct 2023 15:33:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Address 'remap_list' not described in
 'svm_range_add'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20231023161231.2874227-1-srinivasan.shanmugam@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20231023161231.2874227-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::36) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 2afd6ef9-f677-4c89-f3a1-08dbd3fef37a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAI9PY3L6XPOpKViUVriGlwmw2U6wNhdRbf2JkWg0wwweuNGrSjuYFdlfzvByP7PJ0BYUoFwfIJF7RPua9tLuIaTCj2JfR+dK7WFNfLKQtOskaKSeZ34tGqnP5IPiSKpaJN+ZSjG5VWWu0yKkX1Q2WTe3fDgtPie5pStMFuzgy7B3zboYvQMtiYmxK7vxBulz5aGnMbeXOeeQzYB+OmR2yi42YePLFmgyEQQ29N9tFChh/neQXrAtJ99VbTxeTKTqYEx95r5TzrA69izkCO1zgvV6rwqX2LkaDJ4HYonpoY1NaipFwa4tQac6RNpqmtl1r6ly+MDM0ZDFWpH0NsANdHa23gbt3z17VvJLxEfYAEaVa5i4VC/Lkav4hJrjfgOuWQ/Mt9MnU/9NcnDhQ42mcAv9IjpaMOpScsoCLe+q4/9botYRkQ897HIu/wA6s9bDr9OqlwDF04VqCX9O8NxAWmNZxETUVsrEgtxviznBX64tuhNt1EoMzKmvqw0zkV+JfKywsIsrkHkyVSwhuisW94cC9LuY6v7cJDygIEMfQseh1Kuxz0QPoNb7VFipgJ0/g3S0Vtcp3SgdyO8az+OhDTPjDSqqHx2DQX/U68nYR/S/yKsVuzv68gs0ZBTjdeiyS5uvnNwi68OCHpCxJDlkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(53546011)(86362001)(4001150100001)(41300700001)(316002)(8676002)(38100700002)(4326008)(83380400001)(8936002)(66556008)(66476007)(110136005)(2906002)(66946007)(31696002)(26005)(36756003)(478600001)(2616005)(5660300002)(6486002)(44832011)(6506007)(66574015)(6512007)(6636002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHNnS0xPMStROWRkaUlTQUFUUmNHY1RUdTFnY2JtSFJhb3FyYmVlaW0xMnVQ?=
 =?utf-8?B?Nm9GaFNteTBrMkgrc3FiQmVna05sRGJTbXRabFozc2tBRS9WSUxUR3lSNmxl?=
 =?utf-8?B?RjlJajA0bmhmUVZiWGIvQnZUQmEyQ3JROWRnWVc3dERzNEhTRnRqc0llZFFq?=
 =?utf-8?B?NXpSTnNtVjdpM0ZmRHZOQythaERBK1lBLzUwSjVXbnBpZUNxVWVvbUpFdFd6?=
 =?utf-8?B?S3Zod1d1Q1gwZnpRYWpSTk9WWGFIZXNHWW5JTzVEbVAzZEpMNTRxODZ6M2ps?=
 =?utf-8?B?ajhIdmFBVmJZUFF1YzVxN2R3SCtNZ1l0aWRxbm42NEt6NzBKZnFaSHl0Qzlz?=
 =?utf-8?B?cTF1R0VhVUtlMHJXZFhUUkVLcmlVbCsxZnFlaXAwUk5KRlpxc0RRTTkwYzls?=
 =?utf-8?B?MjZYMy9sbzZON0NtTkdvcmZ4dWEzTnpNZEtWRXRTTlBWbUpwS0crU2FSZzRN?=
 =?utf-8?B?b00xNnRudzE0QjBxWHNZcHJHZ05nOHRTVU5sSDBQekhxdjYxSVh4SmIra004?=
 =?utf-8?B?RGRaaWtycmh0RXdwc3ZMcGs2QktEdEhSRUg1Y1JCK1JMK2NYazZCb1ZQOTJi?=
 =?utf-8?B?TGhvdzdGYVFYa2NRUm00VTFSTlNIemtlTzFwbzBkOCt4YllnRjRvc3dtamRH?=
 =?utf-8?B?RDE4a2xpNVBqSnIrb2tqMjQycC9IelowcThKek1OSkhKSnFoV1N2RHBVNDR0?=
 =?utf-8?B?REZHWWsydldIcEYydjloVkJ0K2JhYVJUd1lxNjNhMHZMSHFaQTRHa2dqVVRG?=
 =?utf-8?B?K0FiZC9ZaWVXR0UvYXhHaitjM0VDaEJIMUROeVNPWEFseURPSFJKVGNzMEZI?=
 =?utf-8?B?SDNFN1diMjZhd2FjUVBpZFNWSFlmaU1WVlhxWlJoRk5hckJVOTJleGdFNEl6?=
 =?utf-8?B?dnNTZFBoU08rRVdLYWJpdU9MSzk0OU5BM05oN29nRlR6UWQrVmZUaGp1ZlFC?=
 =?utf-8?B?Tm1qZURqNE9VenRpOWIwb3dnWDNiTzVBWitqTlNzeXNqNWM3NUhPeFhUZjQ0?=
 =?utf-8?B?WEhmTnhpN3kveFpnREtVeGJ5azBpQU1iOTJZeG9iK1lkT1Z1eTFXb2NIaE5x?=
 =?utf-8?B?TjdrN1FoTEd4YUlWeGVXYVVyclRwa3hpRGpVNDBoSXhDWnpldGgwU1F5QmtG?=
 =?utf-8?B?dUppUmZ1cElXTXU1UnoySHdpWVU3Y0dLeWl0QlZwWXZJL0VEaU5iOTdRSkVS?=
 =?utf-8?B?WXdzL1FCZTdjZytQSzFjbmtRUFpGOE9oMDdJNkQ2VFFFZEFXNWFjcWFUQVpK?=
 =?utf-8?B?TENQVzM0cm1HVmlNeUpsaE9hKytFN3FtY1UvenRUaEFYV1dzQ1gyNkJiTmwy?=
 =?utf-8?B?ZUdsbU5pekRpSEJkVE1EOVJOVmZHeWQ1LzVob2FseDN3bWp1ZUdTd0lQWEZT?=
 =?utf-8?B?T1JtR1JMVzlMM0FHeFc0VTdpbFU5R3dJaUNrL1pBUjIrRzBKSi8xRDdudzJO?=
 =?utf-8?B?dWtIYkNoWVV0S3BHMjh4dERmOG83cGJiZHN0TWlBK1RibHJCdlhyam45eDhB?=
 =?utf-8?B?cG9IN1c0ZWxFck1sOG95Y1luSDdzTkpXSDBjdGpwWUtRQmFEN01XaFVKWnYv?=
 =?utf-8?B?V2hqcXJ2bHZjb3IxWXFiVFczWnJ6MktreUpTK0FEOSthMlhBcmJrUXhkNnFB?=
 =?utf-8?B?MzcxbTRnOXZjTjVYV1pWdm1WMkRqdit6NW1lYjFoQWVpcFZhUEZCd2Njeng5?=
 =?utf-8?B?KzRqWVRpQitESlFSMC9FU3ZmN1Z1OUFDZHprRC8vVmVPY3dVUVA1UGZpcXFT?=
 =?utf-8?B?N1BRMk5rOWw2UkNmV1kwemRocHZIU1d2N25TSUNxNENGMCtBNkpKc3dHNXNX?=
 =?utf-8?B?b3JpVk1lLzB0bmthcWYwZ1l6c3Y4dy9BYTRQYW5yQ3dhMm9UR0lQTFhEOUdJ?=
 =?utf-8?B?VnFRUlNIYW9WRklBWjl3TEhrZ2o0YUxzOGtVWlFWaFNMZ0lndGRaMWx3Vllz?=
 =?utf-8?B?VUlDYnNCQTIvTW9Ed3VDU24zRGpKeXllUXoxcnc2SE40cU5uSWpZQjY2bUxZ?=
 =?utf-8?B?YU9kcjZIOTZJdWhMVDlaSlhERUROZEtEdGVVN3NHSzAycTdpWFpDVHFZTWVL?=
 =?utf-8?B?U0pqUHprMlBPdEtwR0FnbEFWOXlXMTFXdG4vdVVaNVNGVWtCclFxYkdoUm96?=
 =?utf-8?Q?b/eD6baH+DWOJuQ80XvedFT+x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afd6ef9-f677-4c89-f3a1-08dbd3fef37a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 19:33:36.4422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCo3j99o65TGU4AH33hDfq3/d7t8HaTWXvu2lV8HQEm+mQxZpLXyBzin32IdJT/TYPdHm8MFvwLmvvpyI1//1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-10-23 12:12, Srinivasan Shanmugam wrote:
> Fixes the below:
>
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:2073: warning: Function parameter or member 'remap_list' not described in 'svm_range_add'
>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index f2b33fb2afcf..f43dedf3e240 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2046,6 +2046,7 @@ svm_range_split_new(struct svm_range_list *svms, uint64_t start, uint64_t last,
>    * @update_list: output, the ranges need validate and update GPU mapping
>    * @insert_list: output, the ranges need insert to svms
>    * @remove_list: output, the ranges are replaced and need remove from svms
> + * @remap_list: output, remap unaligned svm ranges
>    *
>    * Check if the virtual address range has overlap with any existing ranges,
>    * split partly overlapping ranges and add new ranges in the gaps. All changes
