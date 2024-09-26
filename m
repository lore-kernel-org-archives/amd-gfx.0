Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6131CCCFA13
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 10:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0508E10EB9F;
	Thu, 26 Sep 2024 10:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W9ozPlwS";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2E7410EB9F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 10:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmtdSt5aGvFiXOpqR4OVnjpub79OCWtE5T6AZiKlUECxYKNU8XrVBaLK0oWOV7ujfwCIg5O7sA8YD/RXLig+zq6sECYPfARWTSnalqMXx2q0OOqtHIOnVuUHbOEoFnR2G0+ryo8NKvCl1/27A7ANp6/BXutYZ9l2dOfLu5dyVznJSSEUudde4SCl5WWwu9a9Y0+XgGdrtOYQGDCD83vpEh/54fhQMO4qS+fGRazzqHVBxNgP4a8yxTg4JZuLFP9aT4VuYZgBjOG35Gexim5ZMIiqUIsEYs4xBhpapQeD1zxa8Ko9KQZBwSUgEZ6AXLWTiy63kkDS5a7wZBvhCKX5dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5P/ZgppPSCR8jSZjmv/cDjZGmE04enspMwJqG8GFM0=;
 b=b2JcBc4a88LDGo+jPM5mYJrcjoF5u9aptlnpvXD/PCrGqj5mcQBqI4uc2bfsKGVimWkqclEiC7BJnTdG+BzCAdXT8CuxdDPVrWHRdn5RLlgR+wL5sSO9qoATHhiMF6pczDdfAC94trbHiXsIQ5xgNwnQuJ6GJ33jdnWUg1L9aLufe/nsq+fqtpWbtZB1q7MyScwYIOboPJRezEfpXJT4SXlfVbS66qbbjti7S4lCtAqv60xcGB3Sj8rVXsBnbFaRMkqwVj+7cDYYk8R9/O2Kjx7BXBUtrp4yG3S2YArfxLTSeyK03WLWpRihuX0OFit/GnVXWsVFf8Ng38fhGh0qUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5P/ZgppPSCR8jSZjmv/cDjZGmE04enspMwJqG8GFM0=;
 b=W9ozPlwSUSqD8DVX1hiU89HOZOpH8cJO/nciLWM6TezOMphQMd5RYx+u5jbS55AOPkzWuEGrcd+2WamxJ8Fd7/pGE7n2g3qFrNiVZxIt6BTgaEWk7fCBPeAj72jSNGuaQVNJy7PE+iA270NklYIQTITmzs+l9M7H+UoxW5b9QZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Thu, 26 Sep
 2024 10:26:36 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 10:26:36 +0000
Message-ID: <e37ec78b-2d1d-4cc6-8b3f-4e9e391275b8@amd.com>
Date: Thu, 26 Sep 2024 15:56:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/08] drm/amdgpu: Implement userqueue signal/wait IOCTL
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
 <3fe2c80e-565f-448c-9b7c-9e69fe175ab8@gmail.com>
 <04440164-8566-4ec0-98ce-c40f718a7575@amd.com>
 <ad931726-cfa8-4c60-83ef-ae164a8c3f66@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <ad931726-cfa8-4c60-83ef-ae164a8c3f66@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::14) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|MN0PR12MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b20616-86be-4bd1-8f4b-08dcde15b2f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGR6QWVLNm5VN0RpMkRkODRmc1FJWW9lS2xTbm1nOWFrMjlxYnJsblNjbmho?=
 =?utf-8?B?cE04OUF2UWk5b2NPVlNZZEVna1U2MUl1eDY2MS9NckxIbVNBSGFybUVtL2Rv?=
 =?utf-8?B?empwSGwrRjdWTUVhZ2YrYTBzcHJNY2VVYWtzc2Z2ckFBYzB6NStDN3RNWHZM?=
 =?utf-8?B?cDRJMWFDbTk4a3NiVnBSNU1Ca0dzYzBaRzI0SW04bmRHR1BzUGkrUmhYczJq?=
 =?utf-8?B?eUlueDhSVXZsMjVMR2pDaCtnbWN3dVVrK2ZxalY1REY5OWgwSzJJZEFkV0NR?=
 =?utf-8?B?NTYyRmlpUXhQMEpBemJBc2JjSDA5NGp1YWhnNmJoM0ovWFFOUXJiWDNjdVpH?=
 =?utf-8?B?dVozeFV6c056ZDV6VUNoczBwRHB6MlJoS2V6TzVERmdiSVpzeXM3Y2pBY1ow?=
 =?utf-8?B?djFpTURCbmNWNWxZYTV1b3ppTGhtcUFzaTR6TVVTdXBNei9XazI2c3B1dHVW?=
 =?utf-8?B?RkVQTkxJMGg3cW0yeVlRQVlBWk5RLzZJRWp3ekoxbFF2WWVCNy9ta1M2TUlp?=
 =?utf-8?B?a2xKcUtkUURPd29hK25oNldqR2JsREVnVTRvcGxiQXpuLzJLSjN5WGNRT2NQ?=
 =?utf-8?B?dWk5VnA4V01TME95RlBJdWhsbXJxaFBOdk05bWlyYXozL3BWdnREcVRxQlM3?=
 =?utf-8?B?WHZhd2lzSmpVQktxYmNEUlRoQXArbkJEZWVCZTZBdi9HaHYxYjNuUUhFR0h5?=
 =?utf-8?B?WWdwZFFnOU9ZcW1kdk1IdUtTYkVNZXVJVW9xM0hLdEVYQWVJTzhxUEc2QjRn?=
 =?utf-8?B?eGM5VjlaK01CK3E3NEd0UFU3WHFBUmlTTTBvM0h5MmVieW9veVBaZ0FvU09v?=
 =?utf-8?B?c2dNaFYvcWFWMVZoZTVnWWREWHFGVG5ENXZXZWpaYy84dVJ0Zi9CeWR0cERS?=
 =?utf-8?B?djVwUW5SQ08wdEx0dmdwbS9kMGpaTzVORWlsdTI4RHZMc2VlVFllMmE3Q0Zy?=
 =?utf-8?B?QXZxRTV4WVkyS0ZGSmVQN0F0aHBJRE5GK3JzbHh2QlpSQUlRVVdrbTY1ZWpk?=
 =?utf-8?B?YzQxSjJmbnM1MTJOYnNOdTU3M1U2MmtRUjF1RTdxRFRBNlhrdUFDbTN2bVI1?=
 =?utf-8?B?eHFTT2plVHhYanBrVDZEejdQd3M4aWp4K2szTFVDWFp6blVEVGhoVjNvaWlx?=
 =?utf-8?B?eW9VRkFPS0EyOXpVVTdhWnNjZWh1cmVzTEdlM2U3Z0RYOVg2aUtCQVJ5TDVv?=
 =?utf-8?B?VWtLWEdNWHBnNGdFOGQ3cEU1OXdQTFVOLzVXVWs4TmZ6YzlGMGJ0M3o4RVpt?=
 =?utf-8?B?VzNTRnFaWElYOVB5MTBJL0RQWEZBQ2taMUFlMEVTUHhoNExMK25qRTh0SHBE?=
 =?utf-8?B?REwxQzdGSStUT1lDZVpiYllieTVuWmRLbSs1VUJubGFtb2hhRmo1L2U3TVNz?=
 =?utf-8?B?aS91UG5SU0tRZ21aOW1POVVyNHVGcW1TbEROQ0N5bjlvOGFyYkY5bnV5TXlk?=
 =?utf-8?B?VStCNHlSUFdwbHV4QWJkTUMyYWNPRzMzSTV3cXlxYkIwTTFJQjVXVEJ4SWky?=
 =?utf-8?B?b0xCanphTU1vVVg4SlVGZ0NrK0FCWCtWOGhaeXAvMFRqbDd2MEV0NllJQlU3?=
 =?utf-8?B?NTJrbjQ2SW5VVGJNdzlRalB6cml6YzZJOE5FaGRNbjl5d05HZXR2MlFHU1dS?=
 =?utf-8?B?VzNxVUJHaEFTV3JZRHp1NjkzZXY2U3Q3MlRuQzM5WmdCbHRJc2hNbmhyQUxD?=
 =?utf-8?B?a2Ixb2ZGdkJNMzhBMnZ4NWFFNFU2Z1NtMXFYOHVvTFUxQnZvbFU4YlJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXY0QVA2ODExR0pZMlNmUEg0OEpMaWFtcmpWMEhCWE1IYzN0eTZRNjNqYzJa?=
 =?utf-8?B?RXlvRm1MZnFhLzNBbFVyUDE3VlFVOFdIcDdDTUNGVlZmbExIdkJkaXBqLzhj?=
 =?utf-8?B?Z0tTOEpDYmNRK0w1dkxSdmI1MDVrdHJ2QUtyci9FaXVDYjJIcUYzZmhuSmto?=
 =?utf-8?B?MnBoV0NmMzV0WWtNTFYwRlREZE5ZNk1jbUlsSzZnYURSaVBIcTJ4L2hXUGRN?=
 =?utf-8?B?aXo5RklIUG5UTy9vRlg2ZFovT2ZaVFprOWdFdHJQeUZ0clJCRHRxRW1tMCs3?=
 =?utf-8?B?bjZWSFFUYUNsMWlHbnNBcGEwRFNNekNDdHM4N29aZThwYzRYWVhReVlrcGFJ?=
 =?utf-8?B?U3I2SHpud0s4aE5HSGZaZC9BSGtnQk84N0xTOUxhQldsaUM0K2twQSt2STRG?=
 =?utf-8?B?bjcvTTVlSk1QZm1TN2JhQndpM3h0Sll5UExzL1ljSWtBZ2o3M09ETldLVjIy?=
 =?utf-8?B?aTlKSDk1Qk5MbVhPN09kTXZ4ZjJKUW1mYTJOWHR0NzY2cDhESnI2SFpLSHBF?=
 =?utf-8?B?SWhPc3kwZzRob2tVcVl0ckhkNkFMU0dIUFExNWE0bG8zOFVzU3U0WmFLeDVM?=
 =?utf-8?B?cmc5VlZRSHNqNitoZFBzbjFMZnBTMFFMcGUvTWxXc2IvcnRqMUxoRWtiZkxp?=
 =?utf-8?B?dFJCZDcvYXRnY3hDSWRDdUh1aWZUZEMzc0w2QVdFRW5oTDVZTmRKWHAxSTQ5?=
 =?utf-8?B?bjFRVFFZN244L2ZHVWU1bWVENU1VS3FHR0d0YjVCakREVHNOamM5TEhEYmRj?=
 =?utf-8?B?aFFjcThTaHhEZmZmeDFESlhucysxV0hkeVZ2b0pla21jMXJ0d1YwSTFCK3FF?=
 =?utf-8?B?SGpOK3VEdU9Rby9pOHEybVNmTk5STFF2bVlKS05sTEdEUkRWWlIwdkd5VGU5?=
 =?utf-8?B?bWNXUkdxdVRVOW0zRjBVTmNRQUkxRWpqcUY2SWxKOXFOdnkrWTB3bFY0L1VT?=
 =?utf-8?B?RlNvemRwTGZUMEpRbktCVG9qbHVpa2VTazhGSEEvQlpMYXNnaWhPaEc5Q3Ew?=
 =?utf-8?B?UzRVNTIrMHAyanBsRjJpYUIrK2RwNXNObXJmR000UHRrcXpIajJpY0xsWk5j?=
 =?utf-8?B?enBCcC9xQkM0SFhCRi96MWFGMThnM2lwblpuK3MvcUxONkZ6RHBKT0FybDRX?=
 =?utf-8?B?MHJZS0UzKzRua2VVTi9ra3duY2hEanVHdWFrUUMzV21KZmcwUmErV2hoYXRB?=
 =?utf-8?B?MGtxV2xweEZnMmpiZVlPNjM0bU04UmlWVm13dnY1NlVpTS9MOW5XbGN3NkZt?=
 =?utf-8?B?VDhpcldUQ2R4SHZSRk1LeVNsd3orbWFHdTZ5ay95ZHlPcFU1MEF1QnUvcTQy?=
 =?utf-8?B?aVJxTUUvMENNWDU3ZFMyL0JtMXdTTDE3dENDNVBFdzVmTEZTQklDY0Z6ek82?=
 =?utf-8?B?bmZ6NWJpeW0vbFdHY2JEMXB0MXk0WS9OOUlQWVJkUTZURGZPVDIycDBxWnJU?=
 =?utf-8?B?NjFlckFzaWZFR1JMcXNoUWFtUXdNb05oaGpyNnkzYjJVSjd3K0k2d1JEVnRL?=
 =?utf-8?B?dWp5elZYZHRqRlZiWWZiS1dFam5NTnhDMWlKeTdDMHBwWDVVT1lsdTgyakRN?=
 =?utf-8?B?ZDFBcHc4M24zbXFWUVBGUSswYTBIWHc4cjhhZ1RLTFBRNjN4UHJuVy96YUFh?=
 =?utf-8?B?SDU2aVVYZUtjRXhDbW0yL1dRV2F1UTlYUnpBTzZ0VVM1anQ3dVZiN3RSMmtR?=
 =?utf-8?B?TzNhN0tCSXM3UFBGejhJb01pRnBYK1QzdnRxUVJUNm9hREpHekh6YkVmMTN5?=
 =?utf-8?B?dTJOMTExenZZRklIa04vOTcrRC9pSkNWSUFBVksrQmtzTFdCMUpUT1hrbnFm?=
 =?utf-8?B?MHhEemM4UVVNcEZVdUR3ck1WaDlINXUyN05Dc3FxVyt4dE8rQk5qd0J5bWhR?=
 =?utf-8?B?WnRWcnN4UEhTbVNSRkVxTnBhUXdlRHZSUUpjUFNaekl5b0hYMFl4aSt6VDh4?=
 =?utf-8?B?ZngxSjJ6OFBkYzNoLzQxYW1TVEw0YVdSWHJpUkhnTmlSNUhxRXl2Qnp5K04x?=
 =?utf-8?B?Q0I0bm1ySXE5U2NXeXJFUVBiZS9nc25QUERUb0pULzZtU25xYWRQWXRTaXUy?=
 =?utf-8?B?cExSSGdRazdjTXJvc3gwY0xleS9IQ09Pd1UxRStnckZhUU5WT0luRDBDQTk2?=
 =?utf-8?Q?gIVvaCtRtnsZ5PF7G3xNN097c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b20616-86be-4bd1-8f4b-08dcde15b2f4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 10:26:36.1222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ej0pQkKq94HCn4u8gdAQB+c3waARR1yI+JnnoRj1vAURdT2XcYY7iNnlVthyGo5Ti4Ru8Q2ZhBdOg2JacltsBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127
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

Hi Christian,

On 9/26/2024 3:04 PM, Christian König wrote:
> Am 26.09.24 um 11:31 schrieb Paneer Selvam, Arunpravin:
>> Hi Christian,
>>
>> On 9/26/2024 2:57 PM, Christian König wrote:
>>> Am 25.09.24 um 21:59 schrieb Arunpravin Paneer Selvam:
>>>> [SNIP]
>>>> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>> +                struct drm_file *filp)
>>>> +{
>>>> +    struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>>>> +    struct drm_amdgpu_userq_wait *wait_info = data;
>>>> +    u32 *syncobj_handles, *bo_handles;
>>>> +    struct dma_fence **fences = NULL;
>>>> +    u32 num_syncobj, num_bo_handles;
>>>> +    struct drm_gem_object **gobj;
>>>> +    struct drm_exec exec;
>>>> +    int r, i, entry, cnt;
>>>> +    u64 num_fences = 0;
>>>> +
>>>> +    num_bo_handles = wait_info->num_bo_handles;
>>>> +    bo_handles = 
>>>> memdup_user(u64_to_user_ptr(wait_info->bo_handles_array),
>>>> +                 sizeof(u32) * num_bo_handles);
>>>> +    if (IS_ERR(bo_handles))
>>>> +        return PTR_ERR(bo_handles);
>>>> +
>>>> +    num_syncobj = wait_info->num_syncobj_handles;
>>>> +    syncobj_handles = 
>>>> memdup_user(u64_to_user_ptr(wait_info->syncobj_handles_array),
>>>> +                      sizeof(u32) * num_syncobj);
>>>> +    if (IS_ERR(syncobj_handles)) {
>>>> +        r = PTR_ERR(syncobj_handles);
>>>> +        goto free_bo_handles;
>>>> +    }
>>>> +
>>>> +    /* Array of GEM object handles */
>>>> +    gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
>>>> +    if (!gobj) {
>>>> +        r = -ENOMEM;
>>>> +        goto free_syncobj_handles;
>>>> +    }
>>>> +
>>>> +    for (entry = 0; entry < num_bo_handles; entry++) {
>>>> +        gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
>>>> +        if (!gobj[entry]) {
>>>> +            r = -ENOENT;
>>>> +            goto put_gobj;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
>>>> +    drm_exec_until_all_locked(&exec) {
>>>> +        r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 0);
>>>> +        drm_exec_retry_on_contention(&exec);
>>>> +        if (r) {
>>>> +            drm_exec_fini(&exec);
>>>> +            goto put_gobj;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    if (!wait_info->num_fences) {
>>>> +        /* Count syncobj's fence */
>>>> +        for (i = 0; i < num_syncobj; i++) {
>>>> +            struct dma_fence *fence;
>>>> +
>>>> +            r = drm_syncobj_find_fence(filp, syncobj_handles[i],
>>>> +                           0, 0, &fence);
>>>> +            dma_fence_put(fence);
>>>> +
>>>> +            if (r || !fence)
>>>> +                continue;
>>>> +
>>>> +            num_fences++;
>>>> +        }
>>>> +
>>>> +        /* Count GEM objects fence */
>>>> +        for (i = 0; i < num_bo_handles; i++) {
>>>> +            struct dma_resv_iter resv_cursor;
>>>> +            struct dma_fence *fence;
>>>> +
>>>> +            dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
>>>> + dma_resv_usage_rw(wait_info->bo_wait_flags &
>>>> +                        AMDGPU_USERQ_BO_WRITE), fence)
>>>> +                num_fences++;
>>>
>>> We should probably adjust the UAPI here once more.
>>>
>>> The problem is that we only provide the AMDGPU_USERQ_BO_WRITE for 
>>> the whole IOCTL instead of per BO.
>>>
>>> So the best approach would probably be to drop the 
>>> AMDGPU_USERQ_BO_WRITE flag and split up the array of BOs into 
>>> readers and writers.
>>>
>>> Can you work on that Arun? Shouldn't be more than a bit typing 
>>> exercise.
>> Sure, I will modify and send the next version of this file.
>
> Thanks.
>
> In the meantime I'm going to review the rest of the series, so there 
> could be more comments. But please update the UAPI first.

Can we have the bo_handles_read_array, num_read_bo_handles, 
bo_handles_write_array, num_write_bo_handles in both
signal IOCTL and wait IOCTL?

Thanks,
Arun.
>
> Regards,
> Christian.
>
>>
>> Thanks,
>> Arun.
>>>
>>> Thanks,
>>> Christian.
>>>
>>
>

