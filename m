Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9924D59F41
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 15:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57DCD10E2E9;
	Wed,  6 Nov 2024 15:45:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IkpQwTjf";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3049210E2E9
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 15:45:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vy6n8VSSYtIrUKLm3lhAgzh0AbxYX9pP+6MJjXRe0Tj3X75pd02SM0DAzkOPbw7ZzNhQP9xYaZSY9vKdv4Vz4o/YC5C38r8nleSSWAzsvAxbebPcyRhcR+gArwrDL+j0wz7vWjELPmxGjD455ijdkmGOANCXjtZP/qFHqaxgEVIJzGmsoF3CjjrfZodRLYm7ZubBI8ABU87oB1xLG+f5HZzu4jO+zbWS5tKn6Z11sY5F9lFei4Qr4XsisbsFsgiHT4wLhSwH8OebKT0S0fuY47khD2+cPfMXSdDvpOWgM+zE8onoJjvIfsuZgRfc2XRVfLQcKufrpZp6yd4NKPfcXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JldqVN9ykvfyFCtatJI/UW0L98AFujci7LTB8wOz/QQ=;
 b=vl74hIHvYcOZLRk3tdCUufDqZV4AAj10344BpwKzauNc4qmXNma35EUlFyAaJ4oe4wRRc0VVLa+/BeibJsvxKARnnT956ibbL2YHR4EEQCf9d966Pn6g7Myud7WE88cpDOfgSDmTqLl5tWLNJ6BnvV/1ja5441YwqNyM6Tfv8dL8odN6t8DOdUFWjdVx007DEhGKXSC/XpmowxwTdXA8i/vk0+IoDON5imeXHxUwuQHm9X1Q+1RniVVQnfikkhUtRlWuya+cSlmuWMzEIPBJHHRyY9HQtCdKcc6M5nsAS58J7B/2JKJVqCF8pP+AAfuuxbOo2hoWks1zmKPDl7WhNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JldqVN9ykvfyFCtatJI/UW0L98AFujci7LTB8wOz/QQ=;
 b=IkpQwTjfVb9/fA4aramfPKBcRrkN21ICZD+Qolrht164Nfg1VJOktvSiFZTfq77gnm/l07Py2CGS65N1wVhNmamyvwjf7EL0gCXWZ/vRw4thL8r89oPM4YdN/PalEV5cqXREHPGzj0XQ7x97m+0H8kfgmoED4xZJVIlpquNih44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 15:45:24 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 15:45:24 +0000
Content-Type: multipart/alternative;
 boundary="------------JzZDrvO4hdHYmVDuIMBfzHaW"
Message-ID: <e37bbf94-6aed-45c6-8a6f-d0e2f1fca68e@amd.com>
Date: Wed, 6 Nov 2024 10:45:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Add missing kdoc 'inst' parameter in
 'smu_dpm_set_power_gate' function
To: amd-gfx@lists.freedesktop.org
References: <20241106021646.4089039-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20241106021646.4089039-1-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: YQBPR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::39) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 899aa06e-63fc-4b87-ee59-08dcfe7a0749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGREUFNpNVZBb1c2VVE3dTJhWU84S2x2RGN3WmE3cGt4UFpPL1JlZk1xQklr?=
 =?utf-8?B?Mnp4MjdyZEEzMWJUbE1EZzlxQlBvbVU3WGszSStJL0JUaTNtSGJUU1MzRHFP?=
 =?utf-8?B?cWxYSFVqeUhDMjRUaXBRK1hLdjh5UVdHdElEYXZxUGxOanVwRmVwQ1dBaVQz?=
 =?utf-8?B?ais2TDh0TFA4ZWI4M2xINTd2eThLdmI2dXRQYi9HbW5LTUVMeUthUUhJZDAv?=
 =?utf-8?B?ZXU2QVVkT1Y2TGVkZWV3UG15bFc4eE9rRGJQMkh3SFpmc21uWVlDQm9OTmo5?=
 =?utf-8?B?OWl3VUhOSmhyT0RTM1JaWVFPSWhlYklORUlGTkxyUys3MjhJb0tTQU56aVZM?=
 =?utf-8?B?ODV1VHZPYm40UHRvMzdWcjErMHM0cmZiaXc0UnJuVkRHbUloL2hKQVk4MjA1?=
 =?utf-8?B?TUIzdDJ5NWhVUUJjajhsRVhKMXArd1hMK2FxYmRkbzNVT1ZMNEdhVURseHpT?=
 =?utf-8?B?dmo5eEVBWE1qZDBtRXBZeHZYWktSbVZXajM2V0gyekZSbHlEaXFZVXdoV1Nn?=
 =?utf-8?B?eUp3RmsremU1Q1FZbUdwcVBsMW4yWWNTRzJ4YnVSRmdyaHdpNXZOVVdqSk5R?=
 =?utf-8?B?Qnl0K1QxZWhMMFN0VkRBRWRWUGllVzltbjI2V0VFNzBCRGw2Nkt2clNqTlNG?=
 =?utf-8?B?UGlQQlNpaExrSGZJMHlIUjB4S296L2QvK3lGTnpWU3RsYWlCV2svNEFOVFFR?=
 =?utf-8?B?NGpxaDcwMTh6QWMzRCtTUkRSZEU3UHhRVGxHY09sd1dSWm40WkRLbXNIQ0NZ?=
 =?utf-8?B?OFgxODBCZUZ3bWRtTitXK1ladUhrY3lQN0QyYklDWGIxRXJEVERiaHJCOU42?=
 =?utf-8?B?UHRjM08zWW9oU0hHeDFseGZ3d3NFL1hrbml5L1dvVlBwcXRqRUFLRWZqUzZG?=
 =?utf-8?B?NHpoa1J3d3RTVDA0NXRLNy82bjRjbDVCZDM4QjdWZ0lqYnplZlhIU2NLNmcy?=
 =?utf-8?B?cEU3V2JrLzRMYkhJMzcwS0V4TSt2OTlDY3hjNm11YTZMd0Uxd2g3YVM4UjBy?=
 =?utf-8?B?L0t5T0V2ck11R3gzcWF1cVBEakhUemxCS1daUjZVcW53ZFdJNmR3dE9rVlJu?=
 =?utf-8?B?eUlLeW15bWxzK3ZMRWM0anBLT05qcElDd2dXdmV1UnpNVklJK3krd2kzS0lo?=
 =?utf-8?B?bzBjM3dLVmJOdFJZTmdQNU4wM1N0a25oczdoRzlRWFpzQmF1akh5T2xzUm5r?=
 =?utf-8?B?ZnFWNUNlVSsweERSNGNhcWhrS2gvcG9mNkxMVzkwRVNjOXlDUXhjdE8reStL?=
 =?utf-8?B?YS84aVE3M1VzbUlyd04yck91WVBpRW8ycjZvb3hpWnRWSXFzV3kxd3hBdk1i?=
 =?utf-8?B?czlBT01adFdVaUFiNTVxam5MdEZ6OWRlc3BQeDFxWE5XRFJZdGVtS3haTFpD?=
 =?utf-8?B?SmlVekhrU0c4bTJtZTNPUnBLdEZFSnJiQ2o2ZHZ6K1RjaHE3MDNLNXBhMm9H?=
 =?utf-8?B?eHEvaVdmYkVwbTdPVUFvbTNUanROOGxQWUdhbmRmWlRESGdRNEZCN1ZZMmxs?=
 =?utf-8?B?VUlYMVNFZU80SnIvZWVrbEhDWnZ0MjRTaHpqUDBRL01kcjhhNC95bnE2Tlg3?=
 =?utf-8?B?MHV6YlhzU1E3QVV1L1cwMWt6SmxQMkpqOXBzOVhNL25BWnRrc1VQUTdLdU95?=
 =?utf-8?B?eGlBQnVRekRpT0xKbWFSU2NqeVNneSsvQ3ZKc0pBb0xadHpIbCsyRlNGaE5w?=
 =?utf-8?B?em4rVUF0ek1yalBLa2Q2N1JxQjJsSUF3Mk02TWs0NEUzT3h5Q2IzWk93Tnhp?=
 =?utf-8?Q?7taAyxKmE8kBD6EEqGaKYhW0CGndyUY6nGIrKzD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2plakxLRkFRbXJTUENieThnMlRJT0ZPK3FjVjlHdmpZaGpRbUxROVJtK0Z4?=
 =?utf-8?B?Q3NhbFUxeWsvZzA3NGJ0M256ZzRleUxJS2dGRVJGbUVXWEhMcmthZWxHY2RQ?=
 =?utf-8?B?SE5VT1RNQk10YUpab1JkMHFZWkZnWmVFMUNpR3NFbWVLK2l5U3ltaitrMURW?=
 =?utf-8?B?TVBVd2ppckNHY2Z0RHhyeXRSWm9CbDVsZGRSeTBacElqTk5TSkdLemgzOVFS?=
 =?utf-8?B?Q1g2NXl3aFhOL0RxYmt4UXRjUEE2ZVdBWVZJNDd3RStRRGxFVXNjcUJQaGNX?=
 =?utf-8?B?SXoyWWVZRExKdjRKTFZtWXZoYU9SK3ZBZEFTd1BJUGx2ZytQc1h1MUtNTEth?=
 =?utf-8?B?bXZpd2t3d0VidzVPQ3N6MnJuWmM3M3VJbFRGdHVKdWtMRVUvTXk2QmR0aTNH?=
 =?utf-8?B?d2JMb0NVa1pkY1NOQ01raVRVbVZFZEtmWXNpN1pLRmZaNVlxSERvQ2QzVXdv?=
 =?utf-8?B?WDFlRHBhYU05UllIN2dZMDdqVTRhVmNHVk93VGY2andncXhJTnRwWGxUYkpt?=
 =?utf-8?B?UUExOTUwalFLUS9EVmNXR21KRnJ4MExFVy85ZnpRc3NSQ0FBZTBSYmpRd3Rl?=
 =?utf-8?B?My85SEFoSSs4ZGdpUCtlODNXVk93TEJkcDEycko4UmdvS20vemdxeXhINlpN?=
 =?utf-8?B?WGFPcFRpby9KRG9qaERqMHdJc0phT1VuMkhVMFF2MVlPVzArZStPWnR3c25j?=
 =?utf-8?B?cE1MNVcyYzFmWGVDUVhjVWI3bzJXWDB1RElML2ovaStsTWFzREJRRnMrbnRj?=
 =?utf-8?B?WDJYS1VTd3hwbWRHUDEyVHBQVHNqL1BZdWpkRmw3QmJNQTRLUExlZDJyajJI?=
 =?utf-8?B?eUJFSXUwMUpPbHF1OWdMWUpzbEV6T0N3ZklQbmh5MitqK3lZdSttNGRHWkVx?=
 =?utf-8?B?dDFHWGNPNnRNeW9xb08zUTc5UmxwcVROd1ZXYkdvR0VaUEpVZ1I2cEVYdG5k?=
 =?utf-8?B?TlcvTThtNzNGMzRuUU9iMXpWOVAvRmdDalo4ZlhxcTR0WGFwcG5wU3JQOXRR?=
 =?utf-8?B?TVkybkcxZGtVV1JOSFNhV3haUXFJb0pNbCtQQ1AwV1R2MWZQUFhDYTNnTjBI?=
 =?utf-8?B?OTBzWUxRa3JLbmREWlpJOTFUUEFJQ0Y3WlFSQzVadFFxbW1NSHNydTJjQjNW?=
 =?utf-8?B?Q2Z4a1l6VjJRdjZSc1hDa3g5ZHd4VXNKY2dkTVczSjJ0d216SXJtMmN0bENq?=
 =?utf-8?B?UG1hbnU0cHcyZjhvWEM2cEsva2s3d3NGTXlGYmlRclg0UVlHY2psS3ZZZGtV?=
 =?utf-8?B?dnBWdnRUdW5pblVyNDlVODB4aCtoL3Q5V2tLc1hXVWovY2pRK1hJYUlMQW9n?=
 =?utf-8?B?ZjFXTW16aXlGTUo2V0txOHVjNkt1bEEyOFZlazYzUUVNenZkRHlWS2lyZ3Ju?=
 =?utf-8?B?STRMbGpLc01lNHl6SThVYi9lWGF4aWIwTkFLeDlvbFExbWdRejJ6Qk5tbUc0?=
 =?utf-8?B?V0FUVjZnNTI4TjRac3V6dXlLTVRLeHUycTkzRTA0RGVlaUMyUUxoR1h2cTBC?=
 =?utf-8?B?SHBXdkNPRFpDbkxJUmloVlg2SllPTGM4TDNHQjZnR1UzM0syMUlTM1dheFJT?=
 =?utf-8?B?N2pvM3prcEFjTUI4L3JNWmpsaXdZejFzcHNwTzFWY1hDcUVyU2Jxcnd0dkt3?=
 =?utf-8?B?aGkwV0lzWWZVTFpFS0l0aFdZYkNERjJHYzhPNkJOZ0NTVkNWbmp1RjZSckdH?=
 =?utf-8?B?SERReGwxRVB3RWR4bGxVV2RPeGI5TDZJK244bjRXNkZQM2EvejhLM2dsRGpq?=
 =?utf-8?B?dEtUUTUycTVraUFkSVdVbTFUVEVZS3Iyby83aVhFTTZTbUpaZDNrd2F0Q3pJ?=
 =?utf-8?B?MTlKMnRQSWJZZE1HTkdqWGxsSUxmN3Z3WmtjVGZ2ZGk3Q012aHVTb3MySkY3?=
 =?utf-8?B?R2o0Y1NnZmZvZkRqa1hGUGFOMmtBMzBJdXYvTXI4VjRWb1YxS3grNFlYS1JR?=
 =?utf-8?B?eWtpVmVVaUNpaGwyOUlycmlNTFRDczZrOTN6NzR5eFJKZWhQeDJQaUNublM4?=
 =?utf-8?B?Qmh0NThtdHpRdHA4Y29PU3E1UXlWSnJjdEtCZVE4VW5VK3prWG1hOE50RXdU?=
 =?utf-8?B?eUVXVGU0VEZaUEtjd1pxbGhHbUJPb2ZNQlNiMEgxcm5oYTF3Y3J2Y0k0c3pn?=
 =?utf-8?Q?ndaNob9G69UyP6SZmx1M2HO+t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899aa06e-63fc-4b87-ee59-08dcfe7a0749
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 15:45:24.3751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HouGqSdDsfN0YF9TSncExARn/hUBPvELyYLMQRD447ooKnfq6GzMN0uSFhTN1OCUagkjJz0oyqkzSvcHhnHdvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282
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

--------------JzZDrvO4hdHYmVDuIMBfzHaW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com>

On 2024-11-05 21:16, Srinivasan Shanmugam wrote:
> This commit adds the missing kdoc parameter descriptor for 'inst' in the
> smu_dpm_set_power_gate function.
>
> The 'inst' parameter, which specifies the instance of the IP block to
> power gate/ungate.
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:359: warning: Function parameter or struct member 'inst' not described in 'smu_dpm_set_power_gate'
>
> Cc: Christian König<christian.koenig@amd.com>
> Cc: Alex Deucher<alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index d08c61cddede..0a82fd5a8cbb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -342,8 +342,9 @@ static int smu_set_mall_enable(struct smu_context *smu)
>    * smu_dpm_set_power_gate - power gate/ungate the specific IP block
>    *
>    * @handle:        smu_context pointer
> - * @block_type: the IP block to power gate/ungate
> - * @gate:       to power gate if true, ungate otherwise
> + * @block_type:    the IP block to power gate/ungate
> + * @gate:          to power gate if true, ungate otherwise
> + * @inst:          the instance of the IP block to power gate/ungate
>    *
>    * This API uses no smu->mutex lock protection due to:
>    * 1. It is either called by other IP block(gfx/sdma/vcn/uvd/vce).
--------------JzZDrvO4hdHYmVDuIMBfzHaW
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="3" face="Times New Roman"><span style="font-size:12pt;"><font size="2"><span style="font-size:11pt;"><span data-markjs="true" class="markwv0w52iao" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span>:
              Boyuan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Boyuan.Zhang@amd.com">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></span></font></p>
    <div class="moz-cite-prefix">On 2024-11-05 21:16, Srinivasan
      Shanmugam wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241106021646.4089039-1-srinivasan.shanmugam@amd.com">
      <pre class="moz-quote-pre" wrap="">This commit adds the missing kdoc parameter descriptor for 'inst' in the
smu_dpm_set_power_gate function.

The 'inst' parameter, which specifies the instance of the IP block to
power gate/ungate.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:359: warning: Function parameter or struct member 'inst' not described in 'smu_dpm_set_power_gate'

Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d08c61cddede..0a82fd5a8cbb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -342,8 +342,9 @@ static int smu_set_mall_enable(struct smu_context *smu)
  * smu_dpm_set_power_gate - power gate/ungate the specific IP block
  *
  * @handle:        smu_context pointer
- * @block_type: the IP block to power gate/ungate
- * @gate:       to power gate if true, ungate otherwise
+ * @block_type:    the IP block to power gate/ungate
+ * @gate:          to power gate if true, ungate otherwise
+ * @inst:          the instance of the IP block to power gate/ungate
  *
  * This API uses no smu-&gt;mutex lock protection due to:
  * 1. It is either called by other IP block(gfx/sdma/vcn/uvd/vce).
</pre>
    </blockquote>
  </body>
</html>

--------------JzZDrvO4hdHYmVDuIMBfzHaW--
