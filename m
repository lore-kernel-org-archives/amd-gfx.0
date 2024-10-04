Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CCDCF8840
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 18:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DC3410EA7F;
	Fri,  4 Oct 2024 18:40:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SXTOlDR9";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8401F10EA7F
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 18:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQN0cCjXWRScybameGtrEv8nnNJ5iY+Fj/slzl5X0aGE4xbmMLwDvearJcYuYXujoxajnogKfhyohrLkBMGfxm80CFpi1pW1V5TyRb/yngOLLfkYLOAi8Du2VXJ9wTabLXoC3vnJ4z2axypOBdOEb3ceUBLEcmXAFGf+Djj5VDQJX9YL0Fcum4nwMSI7m2YbGigecTbJpA6pkZt/Y1CJ3sNdXiQmaUM47Dn463e8VjY5RtjUZBjZHaN/45hvP/gO4nAzwszlGu/eDDmkjxNIjAJd4EH9iVEBWpf+QtDXtkWhZU2I5+1DD0/EFNAAsLRmGxjt1PLnU91fX/RcweoY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYTXJQMbYqtdQ0fki7ZdRydKVzZNjECPwIlJp9fIzZ4=;
 b=m02dnssP5IJErACJCARKTIIYDdbc+iaxDsqMa7qh5zl1+VPjzo5s6IC75xgvvVxHZFabAWSA8c7UWH0ZCzLJAHTuYK/10Adw7ea8e2mJlUKXi5nhneQNod47wCpu19GQGvsxOWIEMtnrouT5P5UWuv7oEspH9R/+lHglC/fC6eBBLazR/Z1+RnumrU+Tg1utxHQ6xLYEeaQUyPLB9r4RMF1E16WOjmqLngq5RXB6nadbmSdLhloR0eIEjjx6cmgMdFGPA0P/T9Fvp2eaE0w1Nc3netic+N2lkfsYEPHSPIrUH62nLY/mdOF0jU2v53OhM2Vc3oFb5ASgKxw82xxZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYTXJQMbYqtdQ0fki7ZdRydKVzZNjECPwIlJp9fIzZ4=;
 b=SXTOlDR9OgkGYjdTxn1jU+99P4qmWlc/utIUYSbDlZde/L5cfAnIYyWMZspn+iFYOtIIEFQKV1puF+WaBLRtn+6iz5bvhGW+7N3yIjMML0XuTXjpejUeDd3lJpCl0Z3mL7lIdhikPnj4kDWrPBzwdp420mErd/euQCp/KB4L8g0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.18; Fri, 4 Oct 2024 18:40:07 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 18:40:07 +0000
Message-ID: <e37e8ff6-79f3-40fc-8756-dc7ba4f23040@amd.com>
Date: Fri, 4 Oct 2024 14:40:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] drm/amd/pm: set vcn enable by instance
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com,
 alexander.deucher@amd.com, sunil.khatri@amd.com
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
 <20241002043627.102414-6-boyuan.zhang@amd.com>
 <5adab3db-d24b-43b5-8436-5f871b085c02@gmail.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <5adab3db-d24b-43b5-8436-5f871b085c02@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0282.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::18) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: a25827f6-26d1-436b-6f27-08dce4a3f7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDB2QnJkU3ExTnZ0emVVMmhxeFVjQWVNeG85QnZJRjhmSCtHNTVtMng5aGRQ?=
 =?utf-8?B?WVRVMHFFRlIrUVVFY0FWUjd3UDBDc0hmeW8wUG1pYk02Q3N3RXJnWmNDSmdG?=
 =?utf-8?B?QkhWQmozUHROcTQvZFZZcVNuVVpjaDhaOTFoVlFZRE5WNm90SWJCNFFraUlm?=
 =?utf-8?B?eE8xY1FRRHpOTGwyR2pTczRFVy9aOHBVNXAxNThrbVp6N3NrSEQ3a1NUcnJP?=
 =?utf-8?B?SU8rZVR3eXF4OXRhZExUU0ppN1JieXN4RVBxbUdtSE1IVmZEOHlDaXc3M2tV?=
 =?utf-8?B?WFcyVjAwMmpNdTBWOGFyNG5yUUZSdUt5cVpHYi9ZakhVQ0R2TzExYjdHS1cx?=
 =?utf-8?B?T1RTVUM4R0wzRzNPOURVMXZyNnlVaHNVWUdlelJrM0QwSFZiazVXVTU1czBG?=
 =?utf-8?B?YXNHYUxJdWxISjNEb1UrN0NiRk9RMWh3OEx0YmpUOGp5S1N6YjB3TWNxdms4?=
 =?utf-8?B?QjRlRDhPYlJQQkJra1o3ZmVFS3BCK01DNFgxM01KVEpFY05pUVVjSVI2dHE3?=
 =?utf-8?B?WTZZaGphRjZMY25nc3B1RXNhMG1sdElhbnNmNnBHNlJJYk5kQ3czQWsyZlhO?=
 =?utf-8?B?NGpJV1ZNUFVrajdPOUxEcmdlUnVxL1Q1Mm9oNGV4dDEzUnNQRVJUUUtHZnI5?=
 =?utf-8?B?WGtKellWK0tUR0JLVG9hdDhoRVFoRjVacGt1K0NvWFlNalkxalN6TVlyOGw1?=
 =?utf-8?B?alJrYVNPZUNFbkQ5QlZycE5nRjNRQlliU0VOa3p2L0kxMjBtUCtRSzRhTk80?=
 =?utf-8?B?ekswWDRQMnBXdFFIaXZReVNrTUtnWktpejNZdkNmUWRGRC85NEZLY3FVWTVK?=
 =?utf-8?B?UnJQTTNET05iU3BpdkxKUEhXUkpwNmFzU2xzaXNHbDUva1ZyaGludGVTM0Yw?=
 =?utf-8?B?MkltL1lwbWRBWkFHMVFxZS9rc29wUUdxYWFOT3lyVXgzOWNkWFlvSTQ0bEE5?=
 =?utf-8?B?N2xjQ0JRcDVmMHcwdEV5ZFFvVmRHTmtrbjQ3anZ0VHNrU2E1bVRTTWxaSjNE?=
 =?utf-8?B?N1pEZ1FTclgvaHNMVVNDdUNkMmpzWEIrTEpkc01hV3BKTU9TQmxQZjQ5ZW41?=
 =?utf-8?B?cWhKVVl3aUxORXNmRWorZnpaWHc5bmJmREptanRzSHA2QlJjYkd1T0pnVWc1?=
 =?utf-8?B?OXduNzY5d0dsRmFnV3JoSE0xNFRmbzBHRGFOTy82anpmY0RoMXc3SGFGQ3pN?=
 =?utf-8?B?Y09FVWk5SXRrV2ZJSDhjbWVIRmdCb082Q0dUdkt2S0RjQ2RjbG5zT2h2Umhz?=
 =?utf-8?B?Z1F4ZFZJbnBLanhvL3AwVWg3NnlmYmI5ODN5QnB2TTNUZjVxK3I2M05hQnlp?=
 =?utf-8?B?RGxkRjQ0SjByektvUDBnTUMzYzA5c2hhSkZxS0NWbkpNNnBIcGlCUDR5cEZG?=
 =?utf-8?B?YXV4MnZ5eUNSM1B6azZMMjNvT00xNzExcFg3eUxkUHI1L1JDdzNoWE9aTGtl?=
 =?utf-8?B?K0ZOeEViOFVHRXNkY0k3MjBPOWNzUndqTUNJZWZBejRRbGEzdDJmNGtmUlYz?=
 =?utf-8?B?QngrcGQ2bVZzeVpsZHJITGxoQzZxK0tkYUIwRkovYlYza3pRUy9tVWNJV05v?=
 =?utf-8?B?TERiODNWaGhidm9EWHJxK2JRYlpsVXAzdit3MHdhU1Jrai9ETW5JVUJ5VHhJ?=
 =?utf-8?B?NDNxWjNFcDhUUlNiTWs2czNZc3BPQXVkL3lrV0doQVZBYkZQdWExdmxnUy9w?=
 =?utf-8?B?bE4xZ1RVMmNiUnkwdWlUaG5Oa0pRa0JCZk42eHg2eEg1cFVhcUdqNXZ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmRVUmFJelU5NDV1NG45OGJwYU9XVGpJOVhSSEN2NTYzYWg0a2RDSU9NcDZy?=
 =?utf-8?B?MnM1SHJBRGRlSDJxeFRLS29GT3k0cXRKVEw1YTFsamN1RVVibUc0dGwyZnZX?=
 =?utf-8?B?WnZrbE1PaTlvdlBFMWcrU2kvS0wwSDlzMTRyQ0xreUFQMTAramNNRkZhbm1z?=
 =?utf-8?B?OXJvczcvbHZHcVNmZUt5TEJnSGdIc2h0WVFHTGkvaDR1VmY5Zm5qbzA1YUk1?=
 =?utf-8?B?R1puU1JCb0VuMGhJc2YzblF1b2FNOUV5Q0UrdzllQ1RlSjU0Q1dUUGtQaFBX?=
 =?utf-8?B?T2tUdmNTL3h2TzA3YnlHRkQyS1M0TDFDU2NUMTgyTnVWazU0U25tNjVYU1Vh?=
 =?utf-8?B?VkdDeTRRNUtKMTQ3TzRXaTV1cjVhd2o2ek1zU3FSUXpBZWhKNXMwd3QvOTFQ?=
 =?utf-8?B?K3IyVmMzZFlqM0Z2dC94UkQvQkpsdTNXMVhpL1ByamkvU3RrR3ZUNFhKUUk2?=
 =?utf-8?B?RzA0aDVRZ2hxa04xdlFVQnRxWVNqbkIzMXBqd0NZaTdOL2E1K25kM2t6WFY1?=
 =?utf-8?B?YlIyRDQ4UjdZakhjb082REp3aUtLMi92QTczR2ppV1Z1WXU0R1k2dW0yckEr?=
 =?utf-8?B?bVh6VXRyclhhWHBWVktPSE12bTk1M3BueTYwMlpKNmVvaWdUUUhTN1EvK3JM?=
 =?utf-8?B?UXBEVmplc1UycTJsMTI2OVNaUEZxdS9ldFE3UFJVSm9vbzBuVCthKzAyQTVp?=
 =?utf-8?B?aWIvczJsaWVRR1NlUWhXUi9ybXFaTDNPdTZHc0grMVY0aXVrNXFQV3RzQnE4?=
 =?utf-8?B?bi83Q0VCdTROdnFsT2N0YVZKSXRvcGdsZGhkZ3R6ZkVqbjVUdUhHN2lQOWRr?=
 =?utf-8?B?MkMyTTRkZUJOZGswcmRsRzFVRjhISHhXK3F4MHdzZDFzRnl3UXhpL3lxZlVo?=
 =?utf-8?B?L2I5U3JXNnJKRTk4SWxGQTRhZmQyWDhYay8yUWdJS2NiSmRPZU1lUzh5c1dq?=
 =?utf-8?B?RVRQVmF5OFVpbEZmU1VPUVlrV1JTUEd2YUJoc2V1V2k0a1l3MTZpQWdHVkRJ?=
 =?utf-8?B?Tk9BbnMwSyt6ZEtUeHRKVFpodWkrWW5GTnN2WUhNVHJiYTFnMWZRcG9nQ1BE?=
 =?utf-8?B?ZS9uWU5nVlVxYkY3VlI2U29FWU5abHpnUkhLWFpMb1BuN25qS29wTmI2aE9w?=
 =?utf-8?B?VFptVm4xcElYcDZvdHJBdEFlS3p4cTJIYUZZYTVSUWtBa0ZYM3FJdE43OUhE?=
 =?utf-8?B?ajFuMUlGU3VXZjloLy9tOHdEU0RaM3lXYnZoYWt5VEtzWnNSandFR0tYSVdh?=
 =?utf-8?B?eWFHYjVZK1VvV01wQTBnNEM5L2JsTEswVnphVHFBWjhXMVpsUXNmQ09LRDRG?=
 =?utf-8?B?TWFKaTdObGxkUHRySXdDdXNLbExhOG01bTlod3ZyUk9mWnVBbFhOVzYySlA4?=
 =?utf-8?B?WmhFaThzUlh6eHNQSVBVWGhYTnhiamtlU05KeHRrR0czWFA1eVFsR3hRSm9B?=
 =?utf-8?B?Wm8wOUxPUUNNNmM5WHhLWTY5NFhsV210MHVudFBrMGl4eVFqK0pHOUlXQlRw?=
 =?utf-8?B?ak9vNFI2UXh6aVgrcWRmTWwzeFRIei9mLzhuSmYxRmlmajJNV1o2V3d6Nm9C?=
 =?utf-8?B?RS9vV29sYnJLNFdqbUhQRGdSaWxRTEpoc3c2dUdqV0VjcXA5UTBLaUpuWEFm?=
 =?utf-8?B?MGlKU0xzdmZnRFdGT0g3R3ZmMTR6VzVZMGhZQktZS0orYmFNUUdHUFlzT21V?=
 =?utf-8?B?UXhJUDZwRW9IM0dlV01NZEQwMjd6U3N5QnBKY3hWWFI0TGgxWENkUjczQmhl?=
 =?utf-8?B?RkxOUWdINUtUSGpFL0FUZXRNK1JTSUJ1aWFKTXhyNFVtdTlHMU42NEtEa3N6?=
 =?utf-8?B?ZUpWV3Q5Ymo1OWt6TFdrWVNzb09pNGU2bi8rdE9udk13Z3RmUmx3cmJJais5?=
 =?utf-8?B?TGR2Rlh4blhYR3BmVG5MeFVobktHWWgvellKNnNSM1hKM2ZGS0FRRVhEZ2RM?=
 =?utf-8?B?UklvcFY0Z2FEWXhCczdpV1YwcmZIY1gzNXlKWDRhV1BsWXRvSVpkWTNha2s0?=
 =?utf-8?B?dmpFcFZFRUdmcTZCUVJXTU1ha1ZEUGpSd3A0Y2xCcjZDZkZXdU9Tc20vME9O?=
 =?utf-8?B?dkJkems3a0ptbklScExuNXNhYWppZU4yR2N3NmNUa0k3dzA2VDFTUXpuUHZV?=
 =?utf-8?Q?GPchEjh2Toi6eGpbEbb1xBy0l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25827f6-26d1-436b-6f27-08dce4a3f7fe
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:40:07.2625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsDgDmDJNkWuMlBJwSPjYd3DIQKl9XLYpVECjvfUr9gIh73btFWOTpr8PaWvypO8fm4GK0MSZUlj8rgkWHWGEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
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


On 2024-10-02 07:19, Christian König wrote:
> Am 02.10.24 um 06:36 schrieb boyuan.zhang@amd.com:
>> From: Boyuan Zhang <boyuan.zhang@amd.com>
>>
>> The new function smu_dpm_set_vcn_enable_instance() will be used to 
>> enable
>> or disable vcn engine dynamic power for the given vcn instance only.
>>
>> The original function smu_dpm_set_vcn_enable() will still be used to 
>> enable
>> or disable vcn engine dynamic power for all VCN instances as before.
>>
>> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 132 +++++++++++++++---
>>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   2 +-
>>   2 files changed, 115 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 939e15b24f86..ddfed7189708 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -232,12 +232,15 @@ static bool is_vcn_enabled(struct amdgpu_device 
>> *adev)
>>       return true;
>>   }
>>   -static int smu_dpm_set_vcn_enable(struct smu_context *smu,
>> -                  bool enable)
>> +static int smu_dpm_set_vcn_enable_instance(struct smu_context *smu,
>> +                  bool enable,
>> +                  int inst)
>>   {
>>       struct smu_power_context *smu_power = &smu->smu_power;
>>       struct smu_power_gate *power_gate = &smu_power->power_gate;
>> +    struct amdgpu_device *adev = smu->adev;
>>       int ret = 0;
>> +    bool single_inst = (adev->vcn.num_vcn_inst == 1);
>
> Please keep the reverse xmas tree order, e.g. defines like ret last.
>
> Apart from that patches #1-'6 are Acked-by: Christian König 
> <christian.koenig@amd.com>, but Alex should probably take a look as 
> well since I'm not that deep into PM.
>
> Regards,
> Christian.


Fixed the format. Also re-worked all PM patches to remove all duplicated 
functions. Please check the new v2 patch set.

Regards,
Boyuan


>
>>         /*
>>        * don't poweron vcn/jpeg when they are skipped.
>> @@ -245,15 +248,33 @@ static int smu_dpm_set_vcn_enable(struct 
>> smu_context *smu,
>>       if (!is_vcn_enabled(smu->adev))
>>           return 0;
>>   -    if (!smu->ppt_funcs->dpm_set_vcn_enable)
>> +    if (!smu->ppt_funcs->dpm_set_vcn_enable_instance && !single_inst)
>>           return 0;
>>   -    if (atomic_read(&power_gate->vcn_gated) ^ enable)
>> +    if (!smu->ppt_funcs->dpm_set_vcn_enable && single_inst)
>>           return 0;
>>   -    ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable);
>> +    if (atomic_read(&power_gate->vcn_gated[inst]) ^ enable)
>> +        return 0;
>> +
>> +    if (single_inst)
>> +        ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable);
>> +    else
>> +        ret = smu->ppt_funcs->dpm_set_vcn_enable_instance(smu, 
>> enable, inst);
>>       if (!ret)
>> -        atomic_set(&power_gate->vcn_gated, !enable);
>> +        atomic_set(&power_gate->vcn_gated[inst], !enable);
>> +
>> +    return ret;
>> +}
>> +
>> +static int smu_dpm_set_vcn_enable(struct smu_context *smu,
>> +                  bool enable)
>> +{
>> +    struct amdgpu_device *adev = smu->adev;
>> +    int ret = 0;
>> +
>> +    for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
>> +        ret = smu_dpm_set_vcn_enable_instance(smu, enable, i);
>>         return ret;
>>   }
>> @@ -408,6 +429,81 @@ static int smu_dpm_set_power_gate(void *handle,
>>       return ret;
>>   }
>>   +/**
>> + * smu_dpm_set_power_gate_instance - power gate/ungate the specific 
>> IP block
>> + *                                   for the specific instance
>> + *
>> + * @handle:     smu_context pointer
>> + * @block_type: the IP block to power gate/ungate
>> + * @gate:       to power gate if true, ungate otherwise
>> + * @inst:       the instance to power gate/ungate
>> + *
>> + * This API uses no smu->mutex lock protection due to:
>> + * 1. It is either called by other IP block(gfx/sdma/vcn/uvd/vce).
>> + *    This is guarded to be race condition free by the caller.
>> + * 2. Or get called on user setting request of 
>> power_dpm_force_performance_level.
>> + *    Under this case, the smu->mutex lock protection is already 
>> enforced on
>> + *    the parent API smu_force_performance_level of the call path.
>> + */
>> +static int smu_dpm_set_power_gate_instance(void *handle,
>> +                  uint32_t block_type,
>> +                  bool gate,
>> +                  int inst)
>> +{
>> +    struct smu_context *smu = handle;
>> +    int ret = 0;
>> +
>> +    if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
>> +        dev_WARN(smu->adev->dev,
>> +             "SMU uninitialized but power %s requested for %u!\n",
>> +             gate ? "gate" : "ungate", block_type);
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>> +    switch (block_type) {
>> +    /*
>> +     * Some legacy code of amdgpu_vcn.c and vcn_v2*.c still uses
>> +     * AMD_IP_BLOCK_TYPE_UVD for VCN. So, here both of them are kept.
>> +     */
>> +    case AMD_IP_BLOCK_TYPE_UVD:
>> +    case AMD_IP_BLOCK_TYPE_VCN:
>> +        ret = smu_dpm_set_vcn_enable_instance(smu, !gate, inst);
>> +        if (ret)
>> +            dev_err(smu->adev->dev, "Failed to power %s VCN!\n",
>> +                gate ? "gate" : "ungate");
>> +        break;
>> +    case AMD_IP_BLOCK_TYPE_GFX:
>> +        ret = smu_gfx_off_control(smu, gate);
>> +        if (ret)
>> +            dev_err(smu->adev->dev, "Failed to %s gfxoff!\n",
>> +                gate ? "enable" : "disable");
>> +        break;
>> +    case AMD_IP_BLOCK_TYPE_SDMA:
>> +        ret = smu_powergate_sdma(smu, gate);
>> +        if (ret)
>> +            dev_err(smu->adev->dev, "Failed to power %s SDMA!\n",
>> +                gate ? "gate" : "ungate");
>> +        break;
>> +    case AMD_IP_BLOCK_TYPE_JPEG:
>> +        ret = smu_dpm_set_jpeg_enable(smu, !gate);
>> +        if (ret)
>> +            dev_err(smu->adev->dev, "Failed to power %s JPEG!\n",
>> +                gate ? "gate" : "ungate");
>> +        break;
>> +    case AMD_IP_BLOCK_TYPE_VPE:
>> +        ret = smu_dpm_set_vpe_enable(smu, !gate);
>> +        if (ret)
>> +            dev_err(smu->adev->dev, "Failed to power %s VPE!\n",
>> +                gate ? "gate" : "ungate");
>> +        break;
>> +    default:
>> +        dev_err(smu->adev->dev, "Unsupported block type!\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   /**
>>    * smu_set_user_clk_dependencies - set user profile clock dependencies
>>    *
>> @@ -774,19 +870,11 @@ static int smu_early_init(struct 
>> amdgpu_ip_block *ip_block)
>>   static int smu_set_default_dpm_table(struct smu_context *smu)
>>   {
>>       struct amdgpu_device *adev = smu->adev;
>> -    struct smu_power_context *smu_power = &smu->smu_power;
>> -    struct smu_power_gate *power_gate = &smu_power->power_gate;
>> -    int vcn_gate, jpeg_gate;
>>       int ret = 0;
>>         if (!smu->ppt_funcs->set_default_dpm_table)
>>           return 0;
>>   -    if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
>> -        vcn_gate = atomic_read(&power_gate->vcn_gated);
>> -    if (adev->pg_flags & AMD_PG_SUPPORT_JPEG)
>> -        jpeg_gate = atomic_read(&power_gate->jpeg_gated);
>> -
>>       if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
>>           ret = smu_dpm_set_vcn_enable(smu, true);
>>           if (ret)
>> @@ -805,10 +893,10 @@ static int smu_set_default_dpm_table(struct 
>> smu_context *smu)
>>               "Failed to setup default dpm clock tables!\n");
>>         if (adev->pg_flags & AMD_PG_SUPPORT_JPEG)
>> -        smu_dpm_set_jpeg_enable(smu, !jpeg_gate);
>> +        smu_dpm_set_jpeg_enable(smu, false);
>>   err_out:
>>       if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
>> -        smu_dpm_set_vcn_enable(smu, !vcn_gate);
>> +        smu_dpm_set_vcn_enable(smu, false);
>>         return ret;
>>   }
>> @@ -1253,7 +1341,8 @@ static int smu_sw_init(struct amdgpu_ip_block 
>> *ip_block)
>>       smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>       smu->default_power_profile_mode = 
>> PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>   -    atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
>> +    for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
>> + atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
>>       atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
>>       atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
>> atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
>> @@ -2932,6 +3021,7 @@ static int smu_read_sensor(void *handle,
>>                  int *size_arg)
>>   {
>>       struct smu_context *smu = handle;
>> +    struct amdgpu_device *adev = smu->adev;
>>       struct smu_umd_pstate_table *pstate_table =
>>                   &smu->pstate_table;
>>       int ret = 0;
>> @@ -2980,7 +3070,13 @@ static int smu_read_sensor(void *handle,
>>           *size = 4;
>>           break;
>>       case AMDGPU_PP_SENSOR_VCN_POWER_STATE:
>> -        *(uint32_t *)data = 
>> atomic_read(&smu->smu_power.power_gate.vcn_gated) ? 0 : 1;
>> +        *(uint32_t *)data = 0;
>> +        for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
>> +            if 
>> (!atomic_read(&smu->smu_power.power_gate.vcn_gated[i])) {
>> +                *(uint32_t *)data = 1;
>> +                break;
>> +            }
>> +        }
>>           *size = 4;
>>           break;
>>       case AMDGPU_PP_SENSOR_MIN_FAN_RPM:
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h 
>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> index f88241cdf9b9..b8b6050877c1 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> @@ -399,7 +399,7 @@ struct smu_dpm_context {
>>   struct smu_power_gate {
>>       bool uvd_gated;
>>       bool vce_gated;
>> -    atomic_t vcn_gated;
>> +    atomic_t vcn_gated[AMDGPU_MAX_VCN_INSTANCES];
>>       atomic_t jpeg_gated;
>>       atomic_t vpe_gated;
>>       atomic_t umsch_mm_gated;
>
