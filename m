Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC1CD37485
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 12:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF3DA10E80D;
	Thu, 17 Oct 2024 12:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rkqnupuq";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E8010E80D
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 12:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7OwF1kfLObjurATY1zH9/0MSobsX7uPlKAC6E2vviDVMxOoUGXKjXaWzWhiQDgxQtKDKiSJTRtkoxUOBa4o0syAd+sULR3yt77gtP5/D4MldD6teCPTDeT3heKfYreLWX7JFZSGmDcyrG68v04q3ZMjf4GCqbGqtN9R9SR5r7lhkcNiqD7hz118umwrcUVriIQJLEmSOFY8QAheIhAg8FmREVKWecHMQ941zJnfdQNrP5sysB9d0RS9sHTa0SeqD6eM86jDh68OdE5+z9EzlIlo7/uR8QP3DEyF5Y7/22Wc2NbJfYoUyN+Ta/VQSoMXnhdCoSokGAaCYejbUfAZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoAYqPmgDEeSKtvd7WFvpNdHxaML9LkUkSRUN+7eXJw=;
 b=ecBaRAZsGwxRfsbJQFVVRzs+KwNd97BKjtWsRfuu1dt2kRaQ3ITr1SbTXpOjyG91hoq04zeDUilXVACvSPPvvC3TBtQycpzPms95Hw0RDE+NhXcPO7Voiw+Ba75cguf+LwPcHUbuc41e8nkELh2cnvcP1vAP3SaiVq6LRJjTuSXM3HUNeUk9biqsTZuHT14PnNqXMbv05Tzd0Pis7C0frnJdWqIyP/VhpCLR5iKUMt1Vp6awsf6r96ub+UZbVDzma8/xmD2ibqvm5MTAO0d2XdKLmOAuv3Xu0e1qyDw4PhinGknrVXRRnSdDQFmE0zVCHs4Fay9TC5x2sTm9pCW+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoAYqPmgDEeSKtvd7WFvpNdHxaML9LkUkSRUN+7eXJw=;
 b=RkqnupuqWiPFuEzqE7ndsfO5SOIFk2TAXfhYSy7AvHLYFYTtBl1JcV6wrg0JQbO3zwcBeEOMh3Ls4lsAtgvpd2LXlWGYQshguo7lCSjr1t1gQWdTqrPVlHHNukKeDknidhOr3Kx61f6Qy5jEEAv8HtqePm6WlnQBwhwvT9+MBpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 17 Oct
 2024 12:57:57 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 12:57:56 +0000
Subject: Re: [PATCH v4 00/15] validate/clean the functions of ip funcs
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241017100615.1492144-1-sunil.khatri@amd.com>
 <f4aa8b1e-7ba9-4e10-bb71-71871c2cb920@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <181c518d-a4a5-6d69-d153-8240c0de7930@amd.com>
Date: Thu, 17 Oct 2024 18:27:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <f4aa8b1e-7ba9-4e10-bb71-71871c2cb920@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN0PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::18) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 0102b4e7-89fe-4b35-bffe-08dceeab5229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHZHMW9ISlBtdWpnZkw0N1BQQnVLamNoYmFRYlRoOGlqVDNtVjVkbHN2QzMz?=
 =?utf-8?B?S2ZROXlrMnh1VkJhZDh0a01pc1JVWVUwZXFHckdzQk9hWWxLQnc3YnNpOFRt?=
 =?utf-8?B?bVN2eXBabGEwT2phQno4d09kTE82NzgvcWpVQy9vdThDbStTOUliN2ZPU2hu?=
 =?utf-8?B?NWxSQ1l4UUphNnhCK3BIVHQrZjc0cEZCTU1LOWEweVFWNG5QVTV4SGZJQmh1?=
 =?utf-8?B?VGJhWk4zdzU4NW93RHprd1g1cFhXMWJwSWhCU0ZpNGFmNFl3aEw3WnlTMDVu?=
 =?utf-8?B?TlN3VUdaOGFubWRuNWZrQmZsR0FXR1l2NUdUaXphdE0xWDR1OSt0cEhzVkl5?=
 =?utf-8?B?YkZtYU54allENzNLYjE1SE9tVW5mdWNtMkl0aTRFdWt3SU1sa2RVdHVxK2o0?=
 =?utf-8?B?R0JTK3Y4U1NEdnIwODFzWDRVZXAyZXh1ckZON2tnVmxwV3lBTis0WEJFSm5i?=
 =?utf-8?B?cmx6bjM5OFhVQ3EyRDQzMEdPK2dNS0FFc3BLV0syL1J0UmI4Vi9tMW90aTl1?=
 =?utf-8?B?VUhEWktoUWwrQnpwcWw0eGRnQ3hZTGhzQlMyUEtDVEIyRGJQZGJ2aHJORE5p?=
 =?utf-8?B?a1c1blhoK0E4UWNZS0xCTHpjenRSUko0bXpEODJUWUd3M0JmclNJVjlQZENq?=
 =?utf-8?B?WGJEazRpWEhYUmNibmZENlNBbHZtLzBsSEtwR1BoRDRRZFIyRzFxeWtnZmp2?=
 =?utf-8?B?dnk3WkdOQ1RDZmJWMWRUa0JHQnNHYUIrSWFkZW1DL1Aza21qdFpyQ2llbUp1?=
 =?utf-8?B?b2FwT1NVTCtWTmVZVTdFaFNOUUdqYVF1eGRxaGZYTlV4d0I2NUQ3b0RFd2dL?=
 =?utf-8?B?UWhZckxBYVdObklTUDdyWkcyNnpNUEFYc01FQVNaRjJ3cHVlcWVJMWVkVjJC?=
 =?utf-8?B?WXNVcmJNQVpSNHQxL1E3dkRpWkd6SE1odnE3S0psTzRxL3NXbHlJbGxqRVRa?=
 =?utf-8?B?Y04rRG55VW5HaVE5UXhpc1VWQldUV1NlS3hZSkhJd0xralZzZlQ5ZUdXdFNE?=
 =?utf-8?B?UGFpdVFTVjZFQkxicm1RWUM1K3FvOVM5UnZsN1RxWXgzMkF5ZWhySTNIcnJC?=
 =?utf-8?B?Q21LRllyUmdhUG9yVVBUaWVmZ2RTNGhocll1MTdYWWFDdVE0eUdxMmtqQTlT?=
 =?utf-8?B?cDFvOThFOGM0REJvWHNGZlZWTFhRUkttOXVqWno4aVhKWkdtRURtMGVqTXNv?=
 =?utf-8?B?eTF1TGI3Tkx3M2M5OUprVjlva2Zicm8rUkV1UlZCQ3EzUkxYYm15clV5d3Az?=
 =?utf-8?B?SG1JejFuLzFEQkF6TlJ2K0VxdXB3WjBJdGxBaHlWbXQ3THE4U0NkT2FYRFJO?=
 =?utf-8?B?VFFIb3JpU0RjVEJ3UnJNZFZvcmhhRFhncEF4TFBuWHVIbjNYNDAvK1M3RGRY?=
 =?utf-8?B?VHlCazNqL0J3bGJSczNLMjNja3NrVjBEVFlFOVBJeWgrd3RCOU9lOVMxVGZ4?=
 =?utf-8?B?ZUJSMlgrcm9hY2hWZ2wwcGl2czIydDdTYnBhK240aERuQ1hQajdlSnFRcVBi?=
 =?utf-8?B?VFNVdmIvWFRGL09jZTBXZ3o0VXJOc0p6cXA5VDdkRGtLS1BtNnpSUVhEaC9j?=
 =?utf-8?B?cm9XckQ1NmtkZGhjQTF3TmhqbW1xUHJrc1ViSGN2RU1qZUVSaEI4Umc5NFZ4?=
 =?utf-8?B?SW5ydlZiOEgzazNWQytrUVBuZFV1UU5DNnZYT2F1TlJqdjRWWEdXQyt5QytY?=
 =?utf-8?B?c1U0VGJMNUcyV0JmeHJac2ZrSjdOVHpvM2dYQ1NqQm50TmJGSlV2aG9VZm54?=
 =?utf-8?Q?Ibg+IiPcazG9BvkRfUC7vqqXyyeet4xOYEPwv8s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckQrYmtOUEpYME05Z1Q1N0ozRWVuSzhCRTU2N0ZIR0dtK0haN2hMR2RHUFRX?=
 =?utf-8?B?N29EbE1QaG1PTktoUnRUdVp5UE1sLzY5QW0xMzlVblhZcXFMT1lSZ0M4cFp3?=
 =?utf-8?B?SnUvajNlM3IrS0lJNjBQWEcrdTYxdU9CRmQvY3FZYlpYSlM3VDh2bjdaR0Z4?=
 =?utf-8?B?TlVUWVdISjVWL1lMdEhtOC9rK1lYamtFZzdPWlAzVjgybjZkeld2QUE3dUs5?=
 =?utf-8?B?djdqRzJsQU0yRmFReEVtMmhqbEVNYThFc01salY4UGlUdlJaVmFFWG5UWFVQ?=
 =?utf-8?B?UmFKNXFadC9IcWsxUVZvMlhGdVpSd1VYMkxyVzBncUJPRFJCNVpINVFVazU0?=
 =?utf-8?B?WVBTODZQQ1ZmLzZ3L0xBSS92ZnFQQ3VNQis0dGxCNUZ2c0J3dzJORHBxenJ5?=
 =?utf-8?B?WTQzYlBZNUI1M0RUNjc4aWdpYUJFYzZKdEtiRWJYek80ZnZ4SndobjFSdGhH?=
 =?utf-8?B?M2pKbEUwNHRqTjhGUkRPRzNmZ0sycDdVdk12b3l1OUFkQlAvbVdvT3NqTWp4?=
 =?utf-8?B?UkZQMW9IWVRreE1HMmFpb2pBamNmUnZLTVFmUUdMYkNCNlUvNVg2bFhtVEYy?=
 =?utf-8?B?eUx0VUlsVXE1TTZ3b1BMNHQyR004QXZadDQ0MmFTU1JOUUFHRTNDdTlVMXlF?=
 =?utf-8?B?SW1Ha3hpSjFwelVEKytMNTdjd2EyTGUramoyU3dqZUFOQSs4MVRIQzBxTGJI?=
 =?utf-8?B?WW9nMEdTWVRBUHlkeGdUNUwyRm1qYUhlM1M4bklqMGhBVGdFMmtBa1Vrc2Zt?=
 =?utf-8?B?MDU4dytRaUwrdlVpWCt6TjRHbUhIQUFZVlNZeGJDUFFQaHRsNW9tTFdBd0l2?=
 =?utf-8?B?TUM1QW9SUUNUWkJvNTFlVWV3SGNmRldjNzZHcHdFUG9DNFBSOXRpQWdNQ2ow?=
 =?utf-8?B?RFRyeWdmNzd6cTFHaWF3d2dQcFpWY09ONU8rZ201M2NwV0FxYlpVMkc1SkNR?=
 =?utf-8?B?MjhXRmoxeDRFTjZsYWFDSnZzblF5MkVFNTM0M21FdkU1VURXMVlCNlJWaGgz?=
 =?utf-8?B?MnhKUEd1L2tlK0Q5L204WnhEcjJ0UTByd1B3QndCUU1abmxkVEkyaW12Nnda?=
 =?utf-8?B?QVlHeFMwd3dqbTh6azZPVmxqamM5U28ybWM1L0pRMkdWYVpxWlNHVk9mdnZy?=
 =?utf-8?B?Z3JFeHhOTm5FQTdTTVBUcllVWFFKU1I3QllqMytQS2pHNzBjVDhWOXh4aWtV?=
 =?utf-8?B?QzhTVVFwejBRZnV0dzk5VDFra2N5Q1ZSZU0xQlRjc1phWnhoWmlIVDdzVUlr?=
 =?utf-8?B?WUdNb0NGVWhRVjR2ZmIvUzZtOVBJbUN0S1pwYlkvZDRlOTVtWG5NaTlNd2cv?=
 =?utf-8?B?VU0reE1xa3pXVFpaODBBQlhaeml4MWMzRlNMMlA5bStDbWQ0NXdnd0ova3VL?=
 =?utf-8?B?OG4zNzVlWkM3QUNKYnBVVVZsYnh4OEVwWUR6VzgyUU9CUzQxUzBPYytJOVla?=
 =?utf-8?B?c0JqOHRLYnErUFhuNXlUV1FWNjdyU2dwRnUyTFVBcCtKQ0lDMThlRTExOFNC?=
 =?utf-8?B?aElWcnJKY1ArL3N1U2RwRUF6TXBMTE5RUGQya1Z1YmdJdzZNa3N4MmdJVmZC?=
 =?utf-8?B?dGxCU2xQZ1YrcDYzN1RLVExZNGQrSHU5bVNOT3ZQTlh5U3JuSnd6VmdXMHhI?=
 =?utf-8?B?aERZdGtMSHlNck5Lc04xcmZQaTA0bUxYaFAwdmVhdUpuTWZoQ0lHRStCTEt3?=
 =?utf-8?B?bWw0TXJoTVNFZno1MHJCWnpWd1dSb0ZNQzV1L3N6dXZZWmpLamZXaUsrc0xF?=
 =?utf-8?B?cCtTajVoM2I4SmgwWW9yb1ZFMnJBT1ZqRWdlbnJCTVZHQTNSeEd1Si9mNWxF?=
 =?utf-8?B?WEYrUXhXODJ6djdnWG9Ld3VMVFR3ZXVlbVNxaVJyQXJ0Q1VGU09mOFFQVDdh?=
 =?utf-8?B?Zm1LK08vdkF3b09USmp6R2VVZ0dUSVY5ZHIva25aNUJadVNIZnFKekNQMWRN?=
 =?utf-8?B?ZXU4QzQyd1ZzRmhTaXROVFJKdFdOcjloa2lheStMWnEyeGhDOExKL0hMMkc0?=
 =?utf-8?B?dTQ3RjJlOVBDTTFmcVNpOENpYkpIdnovRUNROEVLZjBMWjRRa3RNb1dKOUlv?=
 =?utf-8?B?NlBTR2IxVWFsQzI1Rkt4MXlrSS8xWDVqSWpRR1FoVFdnaVc4REtHVjVxa2lO?=
 =?utf-8?Q?oticK1opLsvLB77x46S5P9VY6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0102b4e7-89fe-4b35-bffe-08dceeab5229
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 12:57:56.6024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twslP7QPKlo2nhBuJP07q6c31Cxsf/fC68VHh8iHmtf/w74X0qkZ/3jDj+ejV6+cCzso6eIwLYe/xqR0663jqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847
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


On 10/17/2024 5:53 PM, Christian König wrote:
> Patches #1-#4, #8-#10,#13 are Reviewed-by: Christian König 
> <christian.koenig@amd.com>
>
> Since those patches should be independent maybe push them to 
> amd-staging-drm-next before continuing working on the set.

Sure if the order isnt needed i will push those out of what you 
mentioned and share the rest for review after making changes.


Regards
Sunil Khatri
>
> Regards,
> Christian.
>
> Am 17.10.24 um 12:06 schrieb Sunil Khatri:
>> v4: hw_init/hw_fini functions are mandatory and raise error message if
>>      these functions are not defined.
>>
>> v3: Added 2 new patches to clean get_clocking_state and hw_init
>>      validation.
>>
>> Sunil Khatri (15):
>>    drm/amdgpu: validate sw_init before function call
>>    drm/amdgpu: clean the dummy sw_init functions
>>    drm/amdgpu: validate sw_fini before function call
>>    drm/amdgpu: clean the dummy sw_fini functions
>>    drm/amdgpu: validate hw_fini before function call
>>    drm/amdgpu: validate suspend before function call
>>    drm/amdgpu: validate resume before function call
>>    drm/amdgpu: validate wait_for_idle before function call
>>    drm/amdgpu: clean the dummy resume functions
>>    drm/amdgpu: clean the dummy suspend functions
>>    drm/amdgpu: clean the dummy hw_fini functions
>>    drm/amdgpu: clean the dummy wait_for_idle functions
>>    drm/amdgpu: clean the dummy soft_reset functions
>>    drm/amdgpu: clean unused functions of amd_ip_funcs
>>    drm/amdgpu: validate get_clockgating_state before use
>>
>>   drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  38 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |  16 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 138 +++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |  35 ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   5 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  12 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  |   2 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  25 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   2 -
>>   drivers/gpu/drm/amd/amdgpu/cik.c              |  33 +-
>>   drivers/gpu/drm/amd/amdgpu/cik_ih.c           |   3 -
>>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   3 -
>>   drivers/gpu/drm/amd/amdgpu/cz_ih.c            |   3 -
>>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |   9 -
>>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |   9 -
>>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |   9 -
>>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |   9 -
>>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   9 -
>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |   2 -
>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   2 -
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   6 -
>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   6 -
>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   6 -
>>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   2 -
>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   2 -
>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   2 -
>>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |   3 -
>>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |   3 -
>>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |   3 -
>>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |   3 -
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |   7 -
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |  14 -
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |   7 -
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |   7 -
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   7 -
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |   7 -
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |   7 -
>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   2 -
>>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  11 +-
>>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |   3 -
>>   drivers/gpu/drm/amd/amdgpu/nv.c               |  29 +-
>>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |   3 -
>>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   3 -
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |   1 -
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |   1 -
>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   1 -
>>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |   1 -
>>   drivers/gpu/drm/amd/amdgpu/si.c               |  40 ---
>>   drivers/gpu/drm/amd/amdgpu/si_dma.c           |   3 -
>>   drivers/gpu/drm/amd/amdgpu/si_ih.c            |   3 -
>>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |  43 +--
>>   drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c     |  29 +-
>>   drivers/gpu/drm/amd/amdgpu/soc15.c            |  14 -
>>   drivers/gpu/drm/amd/amdgpu/soc21.c            |  26 +-
>>   drivers/gpu/drm/amd/amdgpu/soc24.c            |  24 +-
>>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |   3 -
>>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |   3 -
>>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   3 -
>>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   3 -
>>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |   3 -
>>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         | 284 ------------------
>>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   3 -
>>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   3 -
>>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         | 275 -----------------
>>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |   1 -
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |   5 -
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |  10 -
>>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |   5 -
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |   5 -
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |   5 -
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |   5 -
>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |   5 -
>>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |   1 -
>>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |   1 -
>>   drivers/gpu/drm/amd/amdgpu/vi.c               |  20 --
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 -
>>   drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  15 -
>>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |   8 -
>>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  14 -
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   4 -
>>   80 files changed, 171 insertions(+), 1208 deletions(-)
>>
>
