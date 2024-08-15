Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B872C3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 21:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AF2F10E487;
	Thu, 15 Aug 2024 21:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wAzxWOT8";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4F5910E401
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 21:19:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yl0Z4Uvl0mB9oNVSWXlDQxepTmqCpjayBcIPUVEYdBZhFjP/r5she5te8Eu6JBn28XPgOTaFCRZTdyP+t3nvcmV0K/umw48x7nRI5RrXPwB8YKQZp3Zj6CNahO9JUev2kf3dkeAgT78+0ZKV0BGyaXJaQSjnNUOGidfpi9E1u5is7c7jjUXrbG5dh/O+rLwOtqaiG/vN0n5Vo6SDK3mBC1FcTM7cH62JBRKdwPUSi1sRlfncdXIwQ6GMg2h6pdScp5xjWvaqkbpX223UBBspYR3WHmIL83A/gAbwYjgzP82tSPQk6Ckh1i03kCFR2wQsLi5PLjbOAOyjCY5YHADNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JmDqSnvAR+FD7PeFwQVw59aAwvVEcC6lxgRANr56z0=;
 b=h92jZpdnXiv48RBdOzAeuw4XtMndN2HqBQz8xrLIowc6H5n6sAzPckVUWd//Orq4w2ZaJ2zzRuCm5JFKYjl8ZwKIbIOccJhkUzj4gC3X3R1k2yMEK0+tcMb0b39Jh0IkDUfp9kABynk+ZxBjwqBpBBm32o8oNuPem9prYdwvGeLZl707IkPob9BVZ8kJlFuYCaB9n3ittWjn5GClckWOVyRwOqd69IoSadvZvhz4cgns3eAfVXrJjFKKsULbgHuegyNxrU8gPX6S1tIO5Aqt7PNLANH/aoZR+6K3VOCpUGLtSFhykWCtrOn1asP1Bcbd66jpF/7KRJ5Jd1rB0gNSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JmDqSnvAR+FD7PeFwQVw59aAwvVEcC6lxgRANr56z0=;
 b=wAzxWOT8CGd6aGESU8IsbNMiR1zg1U66pK90vFWr9vdCoizb03Pkxm0MC9yE+P+KEXNv7uCnb8fiH3fVkPiJJkXWpNx7VFLO6+spcoHoQYAYsqCAa3PvwduGKHjW7ShB4InrkVWepAix6s6LHX5kyDgGVnQxkiZ/Junnz/XyR5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 21:19:32 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8%4]) with mapi id 15.20.7875.018; Thu, 15 Aug 2024
 21:19:32 +0000
Message-ID: <73b523a5-81bc-40ac-b809-849ebdcd3935@amd.com>
Date: Thu, 15 Aug 2024 17:19:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/3] drm/amdkfd: Update queue unmap after VM fault with
 MES
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240814232754.1119319-1-mukul.joshi@amd.com>
 <20240814232754.1119319-2-mukul.joshi@amd.com>
 <e60025db-2cf9-4976-9351-67a69973f6b5@amd.com>
 <BL3PR12MB642552D8C303F61844BFAF8FEE802@BL3PR12MB6425.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <BL3PR12MB642552D8C303F61844BFAF8FEE802@BL3PR12MB6425.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::35) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|PH7PR12MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 2add9dd1-9551-4bec-9982-08dcbd6ff47c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MW91LzRXZ1NKSXczYTRmVm9KREFRNVJVZWhzRHM3czZsUGJzRk9iYlZSY3ZV?=
 =?utf-8?B?RzM2T0d5VnJoeUVEdUhOWTBBSjZvOXZlb1BKV243Z0p5YisyVTVrdmMxaFZT?=
 =?utf-8?B?U0dzL1ZRL3hZUHRTZDBKbldWNEdNNERQSTJ4QWhuT3ZhVXJUQnIzY1krM05K?=
 =?utf-8?B?aGZBTHVwSEs2WWQ0NTFHZWI4Vm9abzloczNReWQyQk8vSTV0RWJoZEc5ejVD?=
 =?utf-8?B?VDJzc1dReXNRbUptMk9ZLzZ3cDdFUEtVN1FITkh2cU9rNmVyNFNub2h0eWV1?=
 =?utf-8?B?bE0zekowVkpXZWxGaGV2WGVMbG56K0VCd0dmUlN6c0pPSUlnTzFMUmd1d0s4?=
 =?utf-8?B?dXZDbHhiYTlXbzgzZ09ZalRvMDMwVTdVQ0dDa3k5dFdNTkpXM3ZXb2V6MkVt?=
 =?utf-8?B?QzV0SjNTNm1GK1hDNVNpRTdvVTRRVDhLT1lqSy93WE9XSytZNlJpSllFSytW?=
 =?utf-8?B?UFQyQkd4WWlxZnJCTmlHdVZiNEVzbnNDanoweFBUT1RlWnNTYzh3N3Nxc3RV?=
 =?utf-8?B?K0EwTEtVejJvT3hKaW1pVzNiRFpZa3lBVVlaalpoSzF5cXlkZXV1MkxaRHZi?=
 =?utf-8?B?c0xMYVVYalZJM0tFNzhrSGd5eHordGlGZENERXNVanBDUkhrdnd5a3NlWWEw?=
 =?utf-8?B?cng2aGtrM0lQVHJnUmliRWtnYlJRMzR0RmxBVGpibW1TeW1rUWcxOEpZVFJ4?=
 =?utf-8?B?Z1JwNzlwdDl2REw4ZXNveVhCS0RhZER1b1hmQVVVSTJWQnd4NElmbXBmZlQ0?=
 =?utf-8?B?VlNtczFla2I0U0FPYmcxcFRsSXdXTjVMbm1JaEE0djQ0emZaODl5cnVsLzJq?=
 =?utf-8?B?SCs5MTdjeTB4ZGhvQTM3RzhuQ0NjMzdtMlQrTmMyTEhpRFByeUJVamlyMGN5?=
 =?utf-8?B?djNVbGJTOHFVSkpQVnJDY1lod0hJVmtIaUswa1JqMjRVS3hid1pESkNoMHUv?=
 =?utf-8?B?VWdHb3pBQW5QVVM2dERhaU5ScDZOTXkrS3hBNE9CWDRnSUZBdjFORTRia3k1?=
 =?utf-8?B?VjhuRlZSR1NOaW9mUXU3bEtSYktSY0Mrd2ZzR3RleEVQbmxKV05GdHQvV3Br?=
 =?utf-8?B?allSMWdZSDNGNmFqUWZVZnpoZjdlYW50MGlNenFlc3E4S2pWQ3NlMENDVUN3?=
 =?utf-8?B?aUVDT2UzRDRZUWdlNkl0enZlMk5tNXE5K0tOTG4zd3ZXVDllVG5Vd0gwUUZN?=
 =?utf-8?B?dnNrak9IOXc4Yk9XZXM4dlFiTVZqTDZmTGFxRFlIUFpPQ2hzRi9MbWhkSXhU?=
 =?utf-8?B?TE9BYU5lcGkzRndLRzVjRmZiNzFNZGdpOWFQYmU1dmpvR1ZndCt0SGgwNFRv?=
 =?utf-8?B?UkJQWmdkZXdxcHZ0dHpKMmhrd3dEaEpidDNiek9FNCttSEFIdml5YW8zT3hk?=
 =?utf-8?B?TzdGcXhTV2Rxb0Rlc1lVSVhaTXhra0VxVjVZU1k3VUFCR05IcDNCUEpZeUNN?=
 =?utf-8?B?U3FoNld1ZnpHU2pteGQ0T2hOM085NkdLVHNUV0R6a1kwTno3VGk4SjJhOGhw?=
 =?utf-8?B?QTV3MXZqR0xnWFpPT3V5eUVackp0RzVsRE8ydE5YUGgyOW55ZFVQV051UDV4?=
 =?utf-8?B?SCtkWklMcTZrRjRhVXU2Vk5FRk54Z3pzNFNTOFdPd21jRzhMZGNsYW02T29U?=
 =?utf-8?B?dVVqWDhrYURLemJyWGFJd1Q0VlFaZjQzSGVnc0NlcFRpRVJnbEZ0Ui9VbFFQ?=
 =?utf-8?B?bjRybnNRcUI5endIc2I2TUxWMXdndys2Nno5Q1lZT1NlT2RVUFFrd2JHRFVY?=
 =?utf-8?B?MzRiQlVnZDZWMXZsRFJabUJGeUREMVZwUkVYc3M5U3dSSVlhRFZHRDNhUEd1?=
 =?utf-8?B?NFNCbUY0amVDRVMvN3BGdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFBOaThzRkt4aUJpZXBucGtZdUo1RlBQWExFNktnVlF4NDBjM3JvYnpIL2tL?=
 =?utf-8?B?Z2FBaVZYOEJTUm9RMzRYTW9NVk8vcFhsNk0rcktGNE9JUjVlM0tmVXIxckQ5?=
 =?utf-8?B?cStySUx5T3NoODR6RDAwVzZxWXJYaktpb1lZdHVVc3h4SzhDcGNxMFIrZDFB?=
 =?utf-8?B?RXpuOXA0V2o2NkhjdmNCV2UrRXB3YXRMazBDd3BKLy9IWHhKajE3OW0wM1gz?=
 =?utf-8?B?NThVM21lOU84OXVYK00rdnAraXFiWm1ORlN5dlBRdnA2eUY5MXludFJwd1FS?=
 =?utf-8?B?RUZFTnBGa3lqRkU2Z0lMdWpiRmFtWGVEb0FKODkrM05BdFN1MHVKYVVWUmEy?=
 =?utf-8?B?MVJCRUdDZUZCWlJnMG5JOHZtR20xc0xmOHNsVnkwdS9ad2J5VlhJYkRCa3NE?=
 =?utf-8?B?M1phRExvV1lIZFZlSUltcDBKWEpJQitHN3pQdGt6alcxVFJ5U0xSOWV6MUFL?=
 =?utf-8?B?RlA3QlY2RUwrM2hXOVpjbVNqRUpPUWlTVkhKdUFkblh3ZFZvTnF1Nk5QM2Jy?=
 =?utf-8?B?R1hIKzJXWXdqMGc2VGU0VnI2TDNQa3EyRW14cjdNa2YxMEN6bGZTNHk0cmhB?=
 =?utf-8?B?K21TZm8vbGtveHRRNTR1YXZCcFRjR3g1WTFnbzRRdUduc3VFdTJFbGNWcm5W?=
 =?utf-8?B?cVdjcFk2cDBMVTN3TUFVOFBTN0tOWW4yRjJ1NGJxMjJXWllQSjlCZWtjQjlG?=
 =?utf-8?B?a2VsVjJhcWlGNXBLZmNIZGxMS3pjcWVHVWV4ZlZaUHlseGZWNXVrUWlrUWtx?=
 =?utf-8?B?dEhVaFJKdVE0eHVkMm1Kdm51UnlsTUZXQURScHVUblpzSzE5b2RURUQ4a3JL?=
 =?utf-8?B?ckJTSUpjN3Q3cXN6Mi8rMVlTY3FzMEV5Q3g4UXBmWXhRWHp6aW1vK3ZaKyty?=
 =?utf-8?B?VmsyZUxmek9wVnFNMTJxMHhPSXdYeGdDTExkN2VSTlVWOFAwVUJ0Qk5IRDRv?=
 =?utf-8?B?WTB0ODI2SWJkMms0dFdsNUVPbXFUeEI4My9nc0pmbmRyNXRFU0lsTzI1dXh0?=
 =?utf-8?B?RmRicG4zV3BDckZSL2dUcnRUQkJ3WXI1eUEyMXFsRnJjTE1DS1JsWG1Gcm1M?=
 =?utf-8?B?NFhXeEVDcGtRS3dvdjJxRmp6cEFrVkpENGJRa1NUbFpodFlGa2gvdTlOZXlD?=
 =?utf-8?B?YXJvZkFOZ1NoZytqWnY5Q01VeUhuSUxib0xxZmJ3RE4zUXJPcENmaUlJQzFM?=
 =?utf-8?B?ZWVLOVR2UHFlT1FqK3FCT3Uvclg1cjlJR0dHaE1reHdmZzkxQmVvNW5PK2hj?=
 =?utf-8?B?VFRGalYvakxzaTRlK2VhbHdrdlBnc2RYSFByMHg3Vnp3RENReDhQc090YXF2?=
 =?utf-8?B?N1Jway90aHBuMzFxK1FTTmx2WklqbEZKQm8zcHdjYVZkMk9taURmTHFiOXEw?=
 =?utf-8?B?MlY4dW01eTFMU0ZvQ05peG51ZXdWUlMzMFpIc0N5eU9kV2R4Q21YZEZsTTBO?=
 =?utf-8?B?aWhXczR5NjYxbjd0UnREVG5VaGUwSEZhZmc0c2t4blFyMk01eEdBVXZuemVa?=
 =?utf-8?B?dHQ0OG5ZYm1LTGRDK1E4MWh6alJLM0h1M1ZuakUvdHRzZEVGYnZvZ0NBdUY0?=
 =?utf-8?B?QkZXWmNrdVpXbGJtN3BDaU16S1RyOEw3Rk5GNFg5d3FnSDN4S21tQkpERDQ1?=
 =?utf-8?B?ZGNDdUFGczhuUDEzNEkycW1EbGZ5SGFwdmxVcDRuY0tKNVJjTTF4VElGbUxq?=
 =?utf-8?B?MEM3K3VFZUp0OVVKT1BKemJjMDlvcng1eGRJSm1qNnlxWW9PMURnc1lCOFdo?=
 =?utf-8?B?RGZrT21vT1Jrb281bzRsaUxTT0tkNWJSWUJDdjZMNDgwZkJ6dFhvR3UyRFU4?=
 =?utf-8?B?VmMxbmxaalQvMVZkc3ViMWZidzFXQzVad2lWbW5jSzJFS095Y3BXdER0VGJ1?=
 =?utf-8?B?U20ycWxVdWphUnAxd2ZXSHZWcEdBS2tpTWlHK05tcTczcVhwaS9WaDgyOGpB?=
 =?utf-8?B?UW5Rb1FVT2RKbEZiQzJRNGdlYXdra1A0aGV3eW15WHk4OUgrazJBUXNkQTFt?=
 =?utf-8?B?Y0xuNnlaN1U5cWtFMmFrZHFDTGNJdXpHMU5NOVFVellsRXVRZFRhd1lLbFc4?=
 =?utf-8?B?SUJWMDFOZ0cyNldyaTg3Ym5LM1hvVXBXTTQ5YmRVMmFLaWFZYjhQenlPZ1hL?=
 =?utf-8?Q?bGu5gOFUYkN0NBuafsKA28Hlt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2add9dd1-9551-4bec-9982-08dcbd6ff47c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 21:19:32.2199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFXUzRcicHtc5aC8pXEX/ZHsKxS/KDRxTXUbxo7xZWa496amLQe6ZFT8aeiq9xYOYLeRSfJP3WNCRYy1GKsq4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020
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


On 2024-08-15 17:08, Joshi, Mukul wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Felix,
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Thursday, August 15, 2024 2:25 PM
>> To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCHv2 2/3] drm/amdkfd: Update queue unmap after VM fault
>> with MES
>>
>> On 2024-08-14 19:27, Mukul Joshi wrote:
>>> MEC FW expects MES to unmap all queues when a VM fault is observed on
>>> a queue and then resumed once the affected process is terminated.
>>> Use the MES Suspend and Resume APIs to achieve this.
>>>
>>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>>> ---
>>> v1->v2:
>>> - Add MES FW version check.
>>> - Separate out the kfd_dqm_evict_pasid into another function.
>>> - Use amdgpu_mes_suspend/amdgpu_mes_resume to suspend/resume
>> queues.
>>>    .../drm/amd/amdkfd/kfd_device_queue_manager.c | 79
>> ++++++++++++++++++-
>>>    1 file changed, 77 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> index f6e211070299..cb5b866eee3b 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -319,6 +319,42 @@ static int remove_all_queues_mes(struct
>> device_queue_manager *dqm)
>>>      return retval;
>>>    }
>>>
>>> +static int suspend_all_queues_mes(struct device_queue_manager *dqm) {
>>> +   struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev-
>>> adev;
>>> +   int r = 0;
>>> +
>>> +   if (dqm->is_hws_hang)
>>> +           return -EIO;
>>> +
>>> +   r = amdgpu_mes_suspend(adev);
>>> +   if (r) {
>>> +           dev_err(adev->dev, "failed to suspend gangs from MES\n");
>>> +           dev_err(adev->dev, "MES might be in unrecoverable state,
>> issue a GPU reset\n");
>>> +           kfd_hws_hang(dqm);
>>> +   }
>>> +
>>> +   return r;
>>> +}
>>> +
>>> +static int resume_all_queues_mes(struct device_queue_manager *dqm) {
>>> +   struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev-
>>> adev;
>>> +   int r = 0;
>>> +
>>> +   if (dqm->is_hws_hang)
>>> +           return -EIO;
>>> +
>>> +   r = amdgpu_mes_resume(adev);
>>> +   if (r) {
>>> +           dev_err(adev->dev, "failed to resume gangs from MES\n");
>>> +           dev_err(adev->dev, "MES might be in unrecoverable state,
>> issue a GPU reset\n");
>>> +           kfd_hws_hang(dqm);
>>> +   }
>>> +
>>> +   return r;
>>> +}
>>> +
>>>    static void increment_queue_count(struct device_queue_manager *dqm,
>>>                                struct qcm_process_device *qpd,
>>>                                struct queue *q)
>>> @@ -2835,6 +2871,40 @@ void device_queue_manager_uninit(struct
>> device_queue_manager *dqm)
>>>      kfree(dqm);
>>>    }
>>>
>>> +static int kfd_dqm_evict_pasid_mes(struct device_queue_manager *dqm,
>>> +                              struct qcm_process_device *qpd) {
>>> +   struct device *dev = dqm->dev->adev->dev;
>>> +   int ret = 0;
>>> +
>>> +   /* Check if process is already evicted */
>>> +   dqm_lock(dqm);
>>> +   if (qpd->evicted) {
>>> +           dqm_unlock(dqm);
>>> +           goto out;
>> qpd->evicted is a reference count. Without this shortcut,
>> dqm->ops.evict_process_queues will increment the ref count. You probably
>> need to increment it here before dropping the lock. Otherwise two things can
>> go wrong:
>>
>>   1. The corresponding dqm->ops.restore_process_queues will underflow the
>>      reference count
>>   2. A race condition where the queues get restored too early
>>
> The intent here is to check if the process queues are already evicted or not. If its not, then we want
> to suspend all queues, evict all queues (which also updates the evicted refcount) of the affected process,
> and resume all queues.
> If I increment the refcount here, then dqm->ops.evict_process_queues will not evict the queues unless we
> change that function.
> And this function would be called only for the VM fault case, so the process is going to be terminated. Is it
> possible to have dqm->ops.restore_process_queues called on it? Even if it called, I don't think we can have
> underflow of the refcount with the current code.
>
> Can you please explain the case where the dqm->ops.restore_process_queues can cause an underflow
> with the current code? And the scenario for the race?

On GPUs with MES, you pair kfd_dqm_evict_pasid_mes with 
dqm->ops.restore_process_queues. For every call of 
kfd_dqm_evict_pasid_mes there will be a corresponding call of 
dqm->ops.restore_process_queues. If kfd_dqm_evict_pasid_mes doesn't 
increment the qpd->evicted refcount for some cases, the refcount will 
underflow in dqm->ops.restore_process_queues.

Regards,
   Felix


>
>
> Regards,
> Mukul
>
>> Regards,
>>     Felix
>>
>>
>>> +   }
>>> +   dqm_unlock(dqm);
>>> +
>>> +   ret = suspend_all_queues_mes(dqm);
>>> +   if (ret) {
>>> +           dev_err(dev, "Suspending all queues failed");
>>> +           goto out;
>>> +   }
>>> +
>>> +   ret = dqm->ops.evict_process_queues(dqm, qpd);
>>> +   if (ret) {
>>> +           dev_err(dev, "Evicting process queues failed");
>>> +           goto out;
>>> +   }
>>> +
>>> +   ret = resume_all_queues_mes(dqm);
>>> +   if (ret)
>>> +           dev_err(dev, "Resuming all queues failed");
>>> +
>>> +out:
>>> +   return ret;
>>> +}
>>> +
>>>    int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid)
>>>    {
>>>      struct kfd_process_device *pdd;
>>> @@ -2845,8 +2915,13 @@ int kfd_dqm_evict_pasid(struct
>> device_queue_manager *dqm, u32 pasid)
>>>              return -EINVAL;
>>>      WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
>>>      pdd = kfd_get_process_device_data(dqm->dev, p);
>>> -   if (pdd)
>>> -           ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd);
>>> +   if (pdd) {
>>> +           if (dqm->dev->kfd->shared_resources.enable_mes)
>>> +                   ret = kfd_dqm_evict_pasid_mes(dqm, &pdd->qpd);
>>> +           else
>>> +                   ret = dqm->ops.evict_process_queues(dqm, &pdd-
>>> qpd);
>>> +   }
>>> +
>>>      kfd_unref_process(p);
>>>
>>>      return ret;
