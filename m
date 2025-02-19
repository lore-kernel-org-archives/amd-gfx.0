Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B20C021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 16:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA3A010E860;
	Wed, 19 Feb 2025 16:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RXcarrs4";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A6F510E498
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 16:46:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGea4vRWnnMDqBQSRORBnvg+bX3oTZTp3yGPhNhfA6HccUFHDLIQlaHGaaYv0+AV7ljKSWPShHdC4uP30YeH9WvaKDDwE7oPcbqVofyaMW37eTIhHav5SedZlcbVQejUo2Idm8DUdxx6XhP3ruWG44HwVgpERHLcB9uUVSkfpB6MtCFqhfB5ALvz5CewiNJIwZqN+qMA7A8nLLNiQgQiBjd4OrxFkI1s5q9R3DRt6NlQXgQSEnGBT22l+HJDAl69VgJIwJH58sLq1zGmIT4u6pxPPvGevUe00zPUUXjuLUF07Aukk++r9P91Q+60tPvdXT9ChkKkaqtJkq6TLG/gsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+IL2JizZzOmCBo1uUlg3/D91cz0aztugUTDzy559yU=;
 b=d5ZVSfwApNaca4c7ze08ra3eQLhqGHC+tgky75BqpGahmbXhzfe/rFvoqNy7innjHKEzDdMKie3u0mzvTwZvt7aYBm5inOfj9ZDqtEq9nQMIp5flbGYJnnZlNWeiLYxBPoJ/qctfuLV/jQjfQcmbv92wyO/k0s8MfiF4JlnlzxFdPg+jZli7ZhyiGM3a0s0++s6IL43lhDe+YbXX7BsPsdzL10uilo+IKtOs81n5GBTxfIc0DahKfV92nM9LvqsG454/fZwIV3+mh03TpDF270zUVa4YQpaFnMBy5HkTpvH94QwXjCiGKG3NGKSEpR1AFmcbdVzO/jT8tayZb1XZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+IL2JizZzOmCBo1uUlg3/D91cz0aztugUTDzy559yU=;
 b=RXcarrs4jXlK37Hqh7trQnvF96ZxbHYykkPPJhJG9RDsrvl7lWRKk20IMFUNYHpznA7xeOASWGDUb/6YW1jlOElwciI0HTZQsPcdxOaFUQmNSngPOYhvqYupGTDgM3GtBkyG0Q34Otc1RrlK+brXe6oWYrXERhbct2t36bIhTGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) by
 SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.15; Wed, 19 Feb 2025 16:46:49 +0000
Received: from DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7]) by DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7%6]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 16:46:49 +0000
Message-ID: <3cbe0cd2-2550-437b-ac1b-ef3dfd12740e@amd.com>
Date: Wed, 19 Feb 2025 10:46:47 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Preserve cp_hqd_pq_control on update_mqd
To: David Yat Sin <David.YatSin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: harish.kasiviswanathan@amd.com, philip.yang@amd.com
References: <20250218231322.420275-1-David.YatSin@amd.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <20250218231322.420275-1-David.YatSin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0061.namprd11.prod.outlook.com
 (2603:10b6:806:d2::6) To DS0PR12MB8413.namprd12.prod.outlook.com
 (2603:10b6:8:f9::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8413:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ddf2ee-e05c-4140-c286-08dd5105010b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M09DU0JTR0cyb1BLdno1SjBjVnd3d2x5dnNDdCtxdlVYSzJzdFRFaDBzZFlF?=
 =?utf-8?B?cUJzOVlTZmlIdGx6cHhuSnFWZmlZZy95b0tDdlpPbFdkalJUa3krTkVkUXl2?=
 =?utf-8?B?V0JBWUFqWSttNExRdHF0ZWdYZkxHRjBycDVneFRqRHVZcUVWMCtBaXNDNnE0?=
 =?utf-8?B?d3N1NGMwUW94R2Vwb1o2TmpWblF4eEpkUXVOWE10dm12amZXME1JWHQ4eVA4?=
 =?utf-8?B?Q0xheHBDVEJOYkVheWxiT0orTXp0U2RNRVNFdlBFOUJqdjdZMUdhdCtQWEth?=
 =?utf-8?B?ZC9wT1hGbHJ5NkpwMjdFbW03a3huek8vUkVtZW9zdzByaDJCTEs2NzZZeUVI?=
 =?utf-8?B?Ni9nRXlJekxRRGswOW9sMWo5elBPYmFYRFpSZjhYd3JJdkVzaHRNZENxeVkx?=
 =?utf-8?B?TVB1YW9wQTBZUThoQVljYm9EMjN0TkRVRnJzU3ZRUmtBOFA3ZG5zUUllN1hi?=
 =?utf-8?B?RDhpRjdTOXFCMFhhWllRVzFjL0pybFBUZ2ZnYlBzaTg4OHY5NkV1Y0VBWU1N?=
 =?utf-8?B?UDAvNHBwSUcxeldxZEF1M1hDdThzQVBmdi82WmxNREhhQXJLZnlOQXMraW5J?=
 =?utf-8?B?TmlGQ3NLTUlTeFhOVkY0Q0ZkVWxURVFWeGs2dXozVk9VUkZPVGJ4eDFVL2hL?=
 =?utf-8?B?Rlk4cGQwdjBvZFlycTNHQUlDRDY5NEJ2Zm5uVk0yNkt5OEV0VEZTVTIvenZ5?=
 =?utf-8?B?aFFBaVlVSmRHdFhYcU0xV2NRVGFsbHJ3cDF2bHBicWpDY2VVQmpPMHhmUGpC?=
 =?utf-8?B?ZVpKYTM2YmlsMHhsSW01bysyN1dzME9QaGRNSFpoMzB6WjhNTXZhdjNKakNS?=
 =?utf-8?B?b2s1emlvbnkyMHQwRTQ0M241aDJuMFM2NEM5K2NnOHpWWE5JWkNrRUJRejd3?=
 =?utf-8?B?ZDBxU0FoSEZSWmtkY3crL0d4dityUE1YQ1RPb2lIc1JuVEhleVg0eURkTFBT?=
 =?utf-8?B?ejVsUnAvbWtLOXZ4RjBxTUlpTVM3N0NIRmFPbjcxQTRjYU1FNmcycUVvN3hN?=
 =?utf-8?B?RTRNem05c3N2RXhLb3ZqZFV3R25GdDI1NnNNeUU3S1g2N25rUWsrV296U2cz?=
 =?utf-8?B?SEM5ZDdZK3JSTDd4aGxwWDIwR2lXeG91UFJCUzM4SGNZZWljYzdVUUV0dUJW?=
 =?utf-8?B?NE8zaFRnenFVWkpUdmpkOGNxaithS1dJaUZob0hSV0VLSnkvMTJkYUJPbm5l?=
 =?utf-8?B?aW9jU0o0V0R4UzczZWlvTFlOcUllVXl6cGVMWWV0TWVBaVRBZFVnSG9mZWRv?=
 =?utf-8?B?cS9hV0d4enZnM3dES1dTdUZZVk1yQVlJNC9vckRCZHdZa0xkRnRPUDhKbkdv?=
 =?utf-8?B?SjRUcjBNKyt0WEl0VVY3S1AxNisva0pqaTdRZ1FIWk12bklVdytSNk5paXFp?=
 =?utf-8?B?VFZYeFJYOXhYbExnOGJuWFVPeWxwZFRHZUFUTGt1THFnZGRVQmR4VUxTZ3FV?=
 =?utf-8?B?bi9vU0tnS2xZSGlrTzlReXErQmxFUC9IK2xCVVpIVS9oajRaeWVXbVVJTjlS?=
 =?utf-8?B?emNmbWh2cXdDQU85cGNGbjFLNmJVMUswNGp1WGN0aXFDZWc2aGI3VVk4L2NK?=
 =?utf-8?B?SzVVQ0VIUGhpL0J4L0ovOEx3ajJ4MkJaNmNWQVI4Smd0M3d0Sk90cEF1NEVS?=
 =?utf-8?B?MjVhTVBlTUxncVJQUzhpTkwwUlZacGdwUERtWmVXRzJQcWNWeXFROE15Z2hi?=
 =?utf-8?B?TTFlTkVCZndIZE9XdWJZcEJlSklkU1paZHV2VFc4SFIycmQ3Vk5peE5ldlZt?=
 =?utf-8?B?NWl6VlVjaHhybjY5Zzh2cnJZa3RaSVphaGpsRTRoSC95dzkxaWNMUWRXM05V?=
 =?utf-8?B?cFA5Mnc1KzBjL2lIcXBOMVVNMnY5N01tUW85MXd3TDZIMnBHUjVsV3NKZ21C?=
 =?utf-8?Q?nNCGTRYV4lBbL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTdiWkZqU0JGbEkrOU1CeFJDOStnazB0cm1mSUNuL0hBdXZLQi9qN2NkK2Y1?=
 =?utf-8?B?WjhtMzZpM0FhOXhYRFhvM0RWM1ZVTUdqekhXOVlxdW5iaGMwbzJnSHZ1RHky?=
 =?utf-8?B?T1d5bWJhS09tUlNTUkN6eXY5ajFBaWJyQ0FLL05aKzYza1pIRndiWVFqS2Nh?=
 =?utf-8?B?SEk0NHV3Nkc3Z2pUTzI3T2g0U1htMFlwbVRRRGJwdFYzb3phMjNvY1BOVG1m?=
 =?utf-8?B?N3FDRjBxdmxaZGZoNnhHLzR1aSt2ZmRIQlFGMUpNNSs1WmplTm40OCt4Q0h6?=
 =?utf-8?B?SEw2ZzZvOGJYRk1obWxVZGY4ZnNsazBKYWRyb1B6dmI0OEJlS1Via0xOZTJx?=
 =?utf-8?B?WUZhN0dZOWp2RkZGeGgwbDg5L3JudlFQb3JyQlJNWngyOVo5M2x5RGhBWjZt?=
 =?utf-8?B?blVCWER1QjFDaUNwbUFmUVhVeXY3WkJadnh6WnZnNE11Z3MxWTVGS1dMdTFI?=
 =?utf-8?B?RzVsUSt6ejI2WGNwODl2cW5LRFVxQmRzV1hobUxKTURNZnI5MnRselpQN2VN?=
 =?utf-8?B?OEwvTkhhd0l5TDg5OTd6UTc4Sk92R0p4U3FJRlBFbmJrTzcwTU5JdnZGMjVD?=
 =?utf-8?B?alBseWJyOHpDd216bUxUYnJDTWFvRVNENCt3NEgxbldDVnlTbnc1WDZyeUxY?=
 =?utf-8?B?Y1UyMmJPUWRUayt3YzN3UC92dFR6aXBJS2NhZU5CcytvcDY2MXdRSWhZTzJ0?=
 =?utf-8?B?ZGVEM0ZmcGhOem9wZGJYL3BPSVZ5dGJZVFYyV0tHSXVEamVqZndjd04yTW40?=
 =?utf-8?B?M0krei9oVzNVU29hc2ZGM29VbExuU1ZoR21FNTlCNmMzZUVkZkNFeGRGRWl5?=
 =?utf-8?B?MFVNaHp1SkZtL3c1S2lOTnFJY0lqZzJPRVR2eWVzbkZiQWozV2EwMGRBR1NF?=
 =?utf-8?B?cHpoYUg1VUpIbmVlejFuR1lJeWZjTlhhWVN3dXd2SzNMT281UWRGbDI2NnBZ?=
 =?utf-8?B?WEFrWnY0NGRvZFJyQVZwclJwcGpGeVVid0RWWEJ2b2lFbk9oS0JpQjBvVjlF?=
 =?utf-8?B?UkFuN2pvTHBGYXgzYmFURWVEMXFVSlN1VE9xSnBNSldlUHdmVTZITk0zelF4?=
 =?utf-8?B?dmd3VHUyV2xLbGFiWmRpZGthdjl1S1M3SGtEdkdUdkpndWtkWGpjVzZCVTJU?=
 =?utf-8?B?YmxNc2FjNlpxRGxxbHhSdDEydm8yY1dSVkozOGFvVmlOb0ZIV3lPM2V4SDJU?=
 =?utf-8?B?NHFiVnk5VndWVVNscDFSU3Q1ZFlTaHc1RzhmNXhmMHJ2VnhQbU84Vjc2bWZN?=
 =?utf-8?B?cHlab2VSVFd6QmFmRzhjTWZmb3MrbzJBdGkvMitOTnFxV0hwdW8vQWFUUE80?=
 =?utf-8?B?NjcwZHlLM0hXS0JoSEZoS3BXbzliTzQyOG9keCtPS1NNbWRGQmgzUGhtSDQz?=
 =?utf-8?B?V0tsRzZDTU1KUExoM3d0RHhtWUM0NmJhYnNxb2VmOTA4aUcwVVcrVENkYnJq?=
 =?utf-8?B?bzBBOWNGS2Exa3lOb3orNDdQRW11dXZjS05qNXB3aURQbmVkQXNSVldTVGFo?=
 =?utf-8?B?cUx0S3JkeWVUMkdwRFdUa2RVN1dWS1ROMDZJcEZ3dUtlclhXR0hETUhuN1Zp?=
 =?utf-8?B?Y09YNHFJa042NGdKVTk0ZzF0SXNITXZYbVJYbkJaNjFMN2hxakpuVVVPUm0v?=
 =?utf-8?B?TkVZNjhaSjJaKzZ3OGN4amdiWWdpV1hlcXZScFJDdTlNTXZRQUJuV0ZXZHZT?=
 =?utf-8?B?UFFuUzArQVJvTGRnTXBwU21kbGRKakY1NlF2YWRDbXk4RExFUVVqWmg5TkZi?=
 =?utf-8?B?ekxmZHlNcDY3eEhVUVNYS0dOVUdoT1pSRTBtdG5hVXl3UFc0TWZrWEZaK0FG?=
 =?utf-8?B?bzZuOGN1dGJraEoxUVVmRFRXY3NDS2dYRVVheXFJMUVUZFREN0kyOXpnV1Ni?=
 =?utf-8?B?UlR0UG03TUdnQkNrN1R0aGRlaFlzVXFPY0hKUmxLblJwUkJUT05SK0QzSFBn?=
 =?utf-8?B?Q3grV0g3WU1ZZW00VzR5eVY3WGU1VkczU2liRkRUbU10aGNqLzl3VXdHbHZr?=
 =?utf-8?B?a3JJL0lVNU1ZUE9RRWNmZ21RK1ZqcUZvamxpMTlrYkN0QjdHSFVObFB1THF0?=
 =?utf-8?B?VVovL2h1SVRFeHREaThSNlV4L0UyamdLWDhzQW8yUU9ERXFsaEMveFM5c0tz?=
 =?utf-8?Q?Y3ndovI9ES8m5cDlpEhxa1bWC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ddf2ee-e05c-4140-c286-08dd5105010b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 16:46:49.2969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRXjGX6oBNwPivE8T8H6xR7jCGgy8QMZTLTvM3LLp2iKnaJ9zndtYy/xuEM/2DXNkkIR1QnqgcoknZ6STqJN5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895
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

On 2/18/2025 17:13, David Yat Sin wrote:

> @@ -107,6 +107,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>   	m->cp_hqd_persistent_state = CP_HQD_PERSISTENT_STATE__PRELOAD_REQ_MASK |
>   			0x53 << CP_HQD_PERSISTENT_STATE__PRELOAD_SIZE__SHIFT;
>   
> +	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
>   	m->cp_mqd_control = 1 << CP_MQD_CONTROL__PRIV_STATE__SHIFT;
>   
>   	m->cp_mqd_base_addr_lo        = lower_32_bits(addr);
> @@ -167,7 +168,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>   
>   	m = get_mqd(mqd);
>   
> -	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
> +	m->cp_hqd_pq_control &= ~CP_HQD_PQ_CONTROL__QUEUE_SIZE_MASK;
>   	m->cp_hqd_pq_control |=
>   			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
>   	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;

Looks functionally OK but I'd also move the line above into init_mqd for 
consistency. I think the intent of update_mqd is to change fields which 
depend on the queue_properties input, with constant fields set in init_mqd.

> @@ -121,8 +121,10 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>   	m->cp_hqd_persistent_state = CP_HQD_PERSISTENT_STATE__PRELOAD_REQ_MASK |
>   			0x55 << CP_HQD_PERSISTENT_STATE__PRELOAD_SIZE__SHIFT;
>   
> +	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
>   	m->cp_mqd_control = 1 << CP_MQD_CONTROL__PRIV_STATE__SHIFT;
>   
> +

Remove whitespace change above.

With those fixed:

Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
