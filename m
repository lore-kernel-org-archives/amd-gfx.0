Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA69C5CFC1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 08:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F09CF895C1;
	Mon, 17 Aug 2026 08:07:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QlChY2K4";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012068.outbound.protection.outlook.com
 [40.93.195.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FF23895C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 08:07:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Duzjrsh6UJvWE36p0Hudfi936EhQPCJq16sKqV6wmbjsgAhGJxRwBqKgvM+uGMgOUnNOR12rw+BR35GKHN/2W6TtfUhfwKK+zL87IjZtY/y38RsLXb41epx3BCAYGti+2GnQMTFqFmkUeIfz9WhQ2Iz8uq3eU62+aO5SOkD5zbRh1b2k0pYqnho0glWdg20OlEtNbkoh2KPxkGVhs+2JA37FwjPt8uHGF1y1Yspx9Q9A32OLB/mTmt6CNwMFImP7uqB96bRcIae/YpZ9/8jYA0jKJZ/Gl5g3HEIzD3dT2w6iLKgyX6UHgAYprzmMqoayj5oo5L+9koAxJJTnhwjQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWxxwpkxo36VLskhPbk4uhAmsLTTHu7FBvrgz0mLuSw=;
 b=X5DoahDGfHt/p6drOjZw+DF/Geu8rinIgqqfJ4UehubsWYgdeaPBc97RtBgxmoeRGVKDQUbrRZjaA34tkG3nJagr8GirC7Pv/nTG1dPMnpESUU7RorwGlaB44ffHKpKvnrVjzSUeXENK4t8bN+bG3Gk5NJlKuneZMlViOGrxg7WUWkkkmy9vBbcQ7yCI2/yWaPyzKFwv9l3tnzxqsFnVOk1QSecOXd+wNJ5ef2pJLnR0tPd8A/8udRi5BSTFIir+TRpvqHWpHh/9DeGeUO86htBpwTeA1ZAgKvRfHb5L7DcT34Pd+7Z0sO/5wK8M0WSgrGP2N0zUbdh+WWozQhIV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWxxwpkxo36VLskhPbk4uhAmsLTTHu7FBvrgz0mLuSw=;
 b=QlChY2K4k7nteZ8gB2BtEhdzZWdeec3oPpFMY5w5E1k/UOayjatgo7JPI2/YuLf3fGu2IU/XzihJ6HrKbUO+AKFZ4s14grznXvuJBTJGT9HIn9TAtMLJcR27AL/+D6Jxw8naN7BJw1jTTq30EeLauMU+fTPoW0eP9Cncb86wNJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 08:07:44 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 08:07:44 +0000
Message-ID: <59918fde-87c3-434a-a606-abb11ab3d899@amd.com>
Date: Mon, 17 Aug 2026 13:37:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/1] drm/amdkfd: Add TLB flush after MES queue
 eviction/suspension
To: Priya Hosur <Priya.Hosur@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Sunil.Khatri@amd.com, Felix.Kuehling@amd.com,
 Shaoyun.Liu@amd.com, Mario.Limonciello@amd.com, Christian.Koenig@amd.com
Cc: Pratik.Vishwakarma@amd.com, Veerabadhran.Gopalakrishnan@amd.com
References: <20260816172608.14470-1-Priya.Hosur@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260816172608.14470-1-Priya.Hosur@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0337.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21f::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 288888ca-c8d0-4b5a-1f73-08defc369e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: vdLVkU/Hxi0xHSgJcDH7/pZ/hg/9iZLrGwl99ADcrynKe7gs3AHDcOm1fe3jtqq9KBPAGSdHR43YoLxZ3WvvpxQkQ7yizNAEE0LCnE3cQq6ABDxb6lJ3rhWPYNJLZF5VS70Erq7BPF0mEUzkO+R+nxt7hT2/9jGi4nlXs4MMosBXJ2acNRIQJFDxHg4O8FqHlw3crG+mO/2uUHTUAQqpT9YM2UOXUylWaMF6gbecZi2pT1NxxKvG3m4UVc8wCCI1of4BQ/iWuLjPPrFO0sKtoLe/7gh6qWEYF5Gz4xzzLVTwNjBwCKBU2eHuHfCLIzqQ8WEcCuOHB7n2Nh6Z4rPx8COmgU5ms9R5M8eYzCx2HouA76Ihiks3s6wzLWAZTb4iUYlRYR62fLlNwmGWkoj7EpGKbMUhiAZTogPl1kDrje0dkSEQ/E6BjGVR39L6lvpcvTrg4rnlJZ+52HMi6vJDqNWGTKprfc5UF/iQfXyqVeXopqRyOn9D+y8L/KWmATiaovFPPzWTp4myEyy9hsSiao1Weh/XAf6Hv+nw1l0KGA4z/tFzpgjC50ZIbLrhoeaefgB2RskiRz4vX7lDb50ep+XOD6NNkJrD9yREQOU87qAhUbBSoQiw+tMNLTA8harczLjYzxYnbJzQSSr7fNWgb0XG1dluoTD5+D+1rToG0uc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmJ1R3Y2c0lwNHduNXROM3JKVkxyT0kwc0x6eDFRWVdMQXREOEFBVkN5Njhp?=
 =?utf-8?B?N2twV3lpVTh1dlA0TUttaGJvdTZrYy8zdHRCNUtZYTREQTM3VlpKTmV5L2RV?=
 =?utf-8?B?MEVQY09VL1Y5ZzV4TU5ab215TmVVOWFFOXVmYy95dHhKekwwK2NWYUpNVlJQ?=
 =?utf-8?B?c2w5VktCbFBrMTNMVzFEZW55dHlEL2d6QThqWGRSQ1AvWWxYejJ4VTl3d3ZR?=
 =?utf-8?B?S1FiUVRvNUlVTExNQXBWMUNTRVprVGdDMFRkQnJTRE10RnE1SjdVS24wTVFs?=
 =?utf-8?B?UGhxODRrOXd5akZGSkE1RzVCM0VXSCt6c1BTZk9yL0RYQ3ByamV3emVSdzBT?=
 =?utf-8?B?Q3lmak1aUDJEVXE3cnFPZ1V5YVVVUlczTVdPT2pyVS9YaE56MDdIb00xL0tB?=
 =?utf-8?B?RHAzN1dzNWpMMW1uNzRtT04zbm5EL3JrenZ6SDlpQWlFemtLTk52Z1o3Zmcv?=
 =?utf-8?B?b1c4cDRRVjl1aDNKTk56d2M2ZGI1TExkSDlHQzg3Z05XSXRLOWZHdFN0OFdI?=
 =?utf-8?B?MmFXSjBMdGpjZnN2WFpuSW82RGZQZjdEc0dmYVdZc1NGQlpaY25hQ2dlb2l4?=
 =?utf-8?B?R3BXNURRTDZaVmVhUlFkalZrL0p3ZHNDd3FUNXdQY0s4bnBIUXB2SDdPS3l0?=
 =?utf-8?B?eG8zUTRuTG9nRlYyUDdrVlh6UGEyd1JpS0pvdzI3eXVHTjVpRkdIeGVCVWtz?=
 =?utf-8?B?dEEyVWNZU1NQRG9kMkhDa080SVF1a2ZCZkZWQ00wVkFoQWFKSU9IU0NUN25k?=
 =?utf-8?B?QWNNamJER01sNUMvTktpcElkc1BGQ3FrM0VzLzhsb0J5aVFoOEJ5SGJXc2l4?=
 =?utf-8?B?NGtpcXA4cEV6WnhRbitvcGN1MWJIMWVJaWVqYUt4OVN5ai9YYnJnK1ZNVHFL?=
 =?utf-8?B?NlRwRGlUVHdmdGVGU0VzV0ptakd0NEQ1U014NGVXZW1IVU5ZN0tMekZYZFhz?=
 =?utf-8?B?T1lVdGtZUzVDdVVBbFppaUcyWWY5bXQyRUNSWjRIcjVnWGdxc0xMSlhqaUFx?=
 =?utf-8?B?UkVQbnBDUDh0b1dtbzNzSStlTnhQbGorSHQ4Tnh0RTBveE8zVm9SZS9TaXVD?=
 =?utf-8?B?S0ZEREVyd0VvT1pTT3JHTzYxbnJLemJ6NUhnRmV1VjVyRjRSS2hodUFmNUhh?=
 =?utf-8?B?MEVDU09iYXBxZzVFOWNxWkR1RjNJekd4QVB6VzR2UzM1azNjazQ5L1JCakJC?=
 =?utf-8?B?Z09maDhPY0tJcXlIaEpBUWwxRUEwc0ZybnVJSkRYMldqWUxFZ1RCTnZzVUZD?=
 =?utf-8?B?eTZNbXNjb3Nob04vUldxV1hlUTZ6bXlxekZUL3pKd1ZBUmVGZHlkUUttNVVD?=
 =?utf-8?B?OFAwRlJMd1BURS9UYVJoZW1rVG15NEVuaTJwZ1RBalBFWlJxZWJRSzRRbUFt?=
 =?utf-8?B?dnc2VjJhOEZKZnl0Ykh5QTN0NWVlM0V2SUR1MldvTWNwRGp1NllFS1JxcWxw?=
 =?utf-8?B?WVdGbWphMjVvME9SNkZzNUJLS0RJREoybUJET01CNlRQeGtCVmQzQldPcUtp?=
 =?utf-8?B?SUp5Rk5oNFA3dnJBaUJVeGJWV1JKVnZvTWp5UDlXTWhiTXloellZWElJVjlt?=
 =?utf-8?B?YnY0MUFSYWZVZnR5eHRIUGR2dDNjQlI5YTFkVzFpbmc3UWJ0ZWYwVU9GUkNF?=
 =?utf-8?B?K0Faa0dHdkJlY2ZNbzJhdUJpMUwrWjJkNXJWbVRSM28xY3dEZ0twelp4NjY4?=
 =?utf-8?B?aWZTM1EyZnJacE16WHBseW55VGh2cGxXQ2l5eVVLa2M5aDNzdjJuNzVjaDRm?=
 =?utf-8?B?bU50SmZUdGk1NEpLai9LLzJXRGgrRnA3Vmt2amRIY1pmMi8yQy82aER0Q09h?=
 =?utf-8?B?RzRqSWh2dUJBRDNxSXhPNUV2MWo3UmY1SWpUUVM5aDNlWndhMGJkaW5GM1Q3?=
 =?utf-8?B?VU05angwcU5vcFhDYmFRTmd2TDlNQmlYL0NTM2NDbHJNc0FIa2NxcmZEeUor?=
 =?utf-8?B?SVgxUW02czJlcUhMOHFBanRRMzk0Z2p3RFJhSXR1ckVNcHF5d2pyQ1g2YUdJ?=
 =?utf-8?B?REpqN1p4Tkx2SzF1d0hsT1d2MTNtTHdNSmRua2VzdmsrVHdyVWkreTkwWnNw?=
 =?utf-8?B?Y2dwcm02a2ZZdjBJSzg2WGtWc1cyajlPblphOWFYYlBJS29JM2pOVTN6cnFy?=
 =?utf-8?B?cEVXTFJNbnNqUUhNOHlvTnVqb2l2aHMzWm4vTTJsRjhyU1M3a25GdWJlQUw1?=
 =?utf-8?B?di9CL3BxMzdxNmEwdmsxTWthQkxxaDlDcE53R0ZaYW1UOGtwMHBqZ28xQml4?=
 =?utf-8?B?Qk9RUHdrQ0lybENoc0g0SjBTOVI5SU4vRUlWdEpwbHhWVEowSEVxV2JjOFVl?=
 =?utf-8?Q?cDXbDLYebsKlAI9xvY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288888ca-c8d0-4b5a-1f73-08defc369e02
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 08:07:44.4918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFOti+Xh7VJfYFxf3vK02hipjFOQj/yiMUeoGtoGhNULbYHPU8j6B7h8UVwKvN7h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
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



On 16-Aug-26 10:56 PM, Priya Hosur wrote:
> This patch adds heavy-weight TLB flush after MES queue eviction/suspension
> to fix SVM page migration hangs on gfx1151 with XNACK mode enabled.
> 
> v4:
>    - Dropped userq TLB flush patch per Felix/Lijo feedback: TLB flush is only
>      needed after batch unmap in amdgpu_userq_unmap_all(), not per-queue unmap
> 

Sorry, that was not the intention. I was thinking there is a unmap_all 
API in MES in which case this could be done within FW itself instead.

I believe Alex was also asking to check about batch unmap cases of user 
queue. Ex: - amdgpu_eviction_fence_suspend_worker there could still be 
inflight transactions similar to KFD case.

Thanks,
Lijo

> v3:
>    - Split into 2 patches per Alex's review
>    - Added userq TLB flush in amdgpu_userq_unmap_helper() (amdgpu_userq.c)
> 
> v2:
>    - Removed "SDMA" from comment as this affects all in-flight memory
>      accesses, not just SDMA (Felix Kuehling)
>    - Added Reviewed-by tag
> 
> Priya Hosur (1):
>    drm/amdkfd: Add TLB flush after MES queue eviction/suspension
> 
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 

