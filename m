Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3D0D0BB6A
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 07:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D3810E104;
	Thu, 24 Oct 2024 07:19:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G7GzFuFB";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADA7810E104
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 07:19:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozOrZCQeGzIIdEPYwcL67t+n6Wh+RKfDsqP9+PbTXJsaUTuEHoN4CBf2xxAJstbheQSsGeeycmbokVeRLNQD0ZKDBrSX+SqrdwlkM4ik+qefwQa+EbLA5K4RyFjpLSXnAr9pGffrgkPBhfsK/IhbRo7wH4HhdYP1pfbSfZAVQwcQ/elLy5JkVv4ARjaBY4DIOcQ7aWFdUpU1sa7huYiUsu5T5BKDT2lMrTMW9yrIPKY5rabISPjtAnohzGVldYagh+sSrEvKg4kC7STg02goMIolspdhzihz0hZvlLp/RJKSs5vdmRNIelC73OuVrRYZjzqVon+yZabZPdkhPlEgoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkrmspkqRO7zP8vZtdzqSlW8Prx+fQ6TA+6F0b0psm0=;
 b=vIbRirfj365f1fNN52VN4rnCHxnfdFXpM7YRTBjNQJ0eoFpHcZ2l7JNShhoz8zPXcXGpilfHwquRqAGKOQvnAjSNuTDIG4qp7JkRHJhgDCpkT8JyemvNNdl/mtw9E2wehpt3J1Hsr+UW3/0GJkx+Q2zD8OVn6yxhQCZfsxv82rG9GtZhkcukSST3KWkJrg4wJTQSnBeBRVCH+S0jhEYvkfdJky2hIc2Bq2XSbYLEb2amjx8SKHHPebkEm1FIQCUCyXd7N+N5enxHGfNTUuUVBvQC5Em1Zg2WUwza6/tAm15v+oNhTr48+XLmLDs2CztU+GPlVQAxR+kQzPT1bAZuFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkrmspkqRO7zP8vZtdzqSlW8Prx+fQ6TA+6F0b0psm0=;
 b=G7GzFuFBCMiKFgvL7dNNC3w1wiO4k4XPzCEd7mtUxQehDf4ycQkSmmAmpID4XEJDn3JOsI+JW5o/xv/D6qITvIf+rnWzpPvgsVVczu21JmDBZIImZH3hXg5ux7H5Kus/CZMmHeu3UstGIWskTKlgnPL39KIpChH3sIc1haDUtv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.32; Thu, 24 Oct
 2024 07:19:30 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 07:19:30 +0000
Message-ID: <27dc3317-bac1-4327-b939-8e6db5520ae4@amd.com>
Date: Thu, 24 Oct 2024 12:49:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: clean up the suspend_complete
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20241014074902.1837757-1-Prike.Liang@amd.com>
 <20241014074902.1837757-2-Prike.Liang@amd.com>
 <8ea96dd2-260c-4fd6-a78b-4d491cd0338c@amd.com>
 <DS7PR12MB6005B9EE7961C317C9639193FB4E2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <2acb9e4b-6750-4800-9841-cf2da94558f7@amd.com>
 <DS7PR12MB6005BE51A4AD1F10AA9C8756FB4E2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DS7PR12MB6005BE51A4AD1F10AA9C8756FB4E2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b85121-662b-4ddf-58f4-08dcf3fc3352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2Z0ZUVsbklEZWV3L1F5b1F2cmRFTFZtZUloR3IwdVhydnFxZDV4N1FqeTVs?=
 =?utf-8?B?aEhYZFg5Rk04bTk3WDd3UW5sTVM5TmlvUUxUMWJaUHhycWVVREpmR2U1UHoy?=
 =?utf-8?B?TVNOcVJDKzM2MERrUWtMdDVON0lvYUtYRkZ3L1dPZ0dGQXZERkFIU3lGNU5L?=
 =?utf-8?B?dlcveER5djVsa3NjVjR3ZSswNms4OXlZdTA1V0ZnbmlEeGhEblJwbzAydFVR?=
 =?utf-8?B?Y1ZpRldkK2dIaWthS1JQalpDUytsNnpRRWF3clFyakpaMmhDZ1l5RkZCK2tT?=
 =?utf-8?B?TExyelNPQWhlSFV2UW5LOTNPMC80ak9pcG0vRk5VM0ZTU0xhWXl4MFhNR3Fs?=
 =?utf-8?B?WUZMNmRwaEc4MVRHTHFWTVZIajlKbjduSW4zY0U3RkhGN1JWRzFPMGhqMHpo?=
 =?utf-8?B?NG9DRHgwTFNtZEhQVDlOOEFIOW9iWUhjelp6K2NrVXcxUjY0K3BCdGtqZG9v?=
 =?utf-8?B?S1d4bFdjZ29lSDRMclRSNTFzRTNBZ0JnTDkwMVU4QTJQY2ZHQmRVTXYxVVNx?=
 =?utf-8?B?YWYvT3o2Qno0NXRxMFFKUExSQ1hqL2ZhMXNYVmV3L05qUEtJK2tPb3hxT1c3?=
 =?utf-8?B?MHZ5RmJrYmFCdnBDMHJ5SzkwQTlOVDBCMDg3eHZPQy9kN0Foc3A4Y3ovSDJY?=
 =?utf-8?B?Y0QxUVJWbmJlWjJpaENXRFpsbW83ZThaZTAvQzk3YmR2M2R2TmtwVC96Y2xq?=
 =?utf-8?B?S2E2Q1EvdzFSbjVMQjJZMWJxdVdOSmRhWk1XNTMyQ0pnQ1lTNUVTSGZkd2ZX?=
 =?utf-8?B?aGU1Z1A3N2Z1U2luNEsvakRKUW40bkhjREFiMnpya3U4alRiQlJsUXlYWUpN?=
 =?utf-8?B?V3Qvd2lJMXlIM2pTRTAzdTlzTTFoT3p5dGQwV1dyc1VrSUh6OGsxR1M0d3JR?=
 =?utf-8?B?WjdaZlE1NTk2SmZRZTRPTW9SR2xEYWQyZG1NbjljUmt4VFBZMmVxcUlzK2NQ?=
 =?utf-8?B?UENKc1hhK0U5bHp0bkRzNGZJZGROdjFGYUY1YVVVc2RtbGwzQ1h6MXM0bVRk?=
 =?utf-8?B?NTFia1VBeE5KU04xSFd2WkIxTUs0eTdSaFlTQWhoOEt0YktyWWZ6ZHQxNHFL?=
 =?utf-8?B?UnNYWjlYcmhrKzR0SXlUaVZHaVQwcWMycUN5R0lCMDQ3TTJnamtTcGZFTHkw?=
 =?utf-8?B?Rit5R0JIQm4wYWdsZzdhMXhPaGo3RDZDVkFhZEI0UlZiN01GMmdnbG9JTWZ2?=
 =?utf-8?B?R29SRlVJRFR4Z0UyQWRCbGlwanZodmg3NGFSK3BNcVQrenpRT3lxNXhSVlpT?=
 =?utf-8?B?bktiSnBzN3crTGdjc29EN0tMT21YZW5pN2VCRVc2UmhLUDZrSXRIZWpnb0o0?=
 =?utf-8?B?ZjFLTGlrMWV2VkNFc1JuNnhWRTQrOVRqdU50ZFFiK3N4dExXaHd2bjlQRjlJ?=
 =?utf-8?B?WlI1b2IzK1c3aHhBVE8wOElxODl5L2Q0TUkyVjRFZFUzNFIra2t1NmNiNldo?=
 =?utf-8?B?aHdkd2NJc2R3MjhSNHZCYm14MWt0VWY3SGhPb1hQRWZpTkFEMFE4QXhRVzR1?=
 =?utf-8?B?SHdQd0h6NlM1MXNZNm96c3A1YlcrZjJ5dWZDVzJPVHNvTGdTYWl0dGl3WFRS?=
 =?utf-8?B?dW10L3JyRUhOZzVuaWpKVFAwWDd0RWw5RHBsYnVsaXIvanRiSDROUFlQNkFa?=
 =?utf-8?B?RjRnaU80NUt2c2syclBCRnFqRldMYnBEWGJvU3NvZjVEYmFSS1IrTnA2Z0dl?=
 =?utf-8?B?ZUZzUDIyMm1rMkl1Nm8vTlVZVWxwNXF4Qi9uM0ZEQzh1LzRQNU9kaDdHVlhy?=
 =?utf-8?Q?4rJl1DqnWWdFBHmsL0AG3RhkaDrm+Msh65dWpcT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzdFekxXUXVSbDg1R0VNRlN2TkhEd3F2MXN5SkxoS0ZNZDE3NlM4TTYySjFK?=
 =?utf-8?B?TWNoazdONE85THpWeUhXTHNQTWR3SjA0eHYvNGF3UVlnWlRDL3AwL3pnNUp3?=
 =?utf-8?B?SXZvVG1CeDFvcVhvdXc0VmNhWVYxbXhTL3dybk9EYllxNDRCaXNFYnJWaVNC?=
 =?utf-8?B?M0RCSkpyUXN2aDRIaXhycGdnbmhuL0ExOUJMZnNycGRLRFFnaTJnN1BHUy9M?=
 =?utf-8?B?WGJQZis2SzArdlVGbmM3eDFHbk1iaTVjTXN6NWFyWkYvaERkS25oL2hGczJM?=
 =?utf-8?B?M01YY2lFaXJSKzgwNWlxTTBPdU4rdzQzYlpoUkRXVDR5dmFxZUY2Qzk5azdQ?=
 =?utf-8?B?Z09EZldRNHBFKzZQYW5GWEFaUCtVKzZHRHV5ZlZ3d3JncXpiNWltbTdtTG56?=
 =?utf-8?B?VHdLenIrUmhFenRnVEJWWEhIOHBqVzZKcU1oT1pyeGNrOG15REJCN1BMVXpn?=
 =?utf-8?B?RStpajRYb051bnlYZFlRNGF3OUlVM1dlZDRnWHJYdWs3MlpRd2hhUFpVNDFo?=
 =?utf-8?B?eitCSSt5UVFUdkZLclZHWjRDbDhiNlVFVXdqeWVLY0Z5WHY3bmtFWDBwYlEy?=
 =?utf-8?B?WmpFdXNOZHhFejlERjJva1JtbS9HQzQ0ZTkzano3QXZnVTZXa2dRZXBVQ0FF?=
 =?utf-8?B?MTA1azBlWHBsUi9aSG9lRU1kV3hTSTJBSHpET3cxM3poU3pxcVl0WXhwMml6?=
 =?utf-8?B?VEVQWG96MHBFYm5sR0ZMMUdPQjRwREw1NkhEa1lqZlhraEo2WnRabm93UnAv?=
 =?utf-8?B?RGJyM2ZIQVNWUC9UMlFSUEY3VnlZazZHR3FjYjVHRklodXZNVTRoMmE5blJh?=
 =?utf-8?B?YlBwWkNGNHMzQTFJMlNFS2kyQW1qYjJmODdHSU0vWDN4ZXFzelovaTdXVnU4?=
 =?utf-8?B?V0hUOUh5cmFtdmdtNGxDTzNnRTVOUkdsdGdFeDRMN2FHR3pYeHZxTm45M1hs?=
 =?utf-8?B?Z2xvRVUyZWlIaFhKMFU0NVJ2anlSZWt5YUgvaVM1VUE5dWtZek1xWUpBVkt6?=
 =?utf-8?B?dnZQVzh1N0l1NkxWTE03SmkxaE1jRThRaVAxN0h1bWNTNWJhN003d2F6L1ZZ?=
 =?utf-8?B?cTZZUmFEdWU4WHlZaVRjK1ZUVE5ZQ3ljZzFMSTNsR3lZVDNJSHByVjYwT2hW?=
 =?utf-8?B?WFRVRFg2cDhuNDNDZDcvaFU4RHFzSHpvTnhIYmYweEh6aENkemJFRE96MzZM?=
 =?utf-8?B?cHUxVk5STUZNbE9UTm9sUWR1c0szYWJWazlzNzVDVmdXaFBGazdsRUpxY2N5?=
 =?utf-8?B?OXpVVmtKVjFEazNOc0hqZ3NvaGt5K0tTTGxKVktraXdDRlhzWkVBakdNVEYw?=
 =?utf-8?B?TzhnUUxLd3dUQnU4NDFUbnpyK2F1cGZwc2JybGRvMWp2KzZVT1FvTmNybGdu?=
 =?utf-8?B?Uytqb1c1T0RvSkE0Yk42Vy85aUpVOExIMVpyQzVWMnJBNVVwSmViMjF6MzQw?=
 =?utf-8?B?YjBic0M0dFhPUzc4Z1RjVmlVWkRYLzhZUktOK3lPUXAwaFZ5VWlOeUZSUlBu?=
 =?utf-8?B?TExKZW5SUUxSOXhZZlBlWGh2VkJHVERmeUVOSjNzNCt1Z2VJQjIwVjFlSnI2?=
 =?utf-8?B?Nlh1YXo2TjVidDNqbmpxaU52czdONUhEUitJSzd4aHorNVdLa2pnTFQ4UEpI?=
 =?utf-8?B?cHArajFEaW1VVmZoTjgzVjZaeXo2SGJjdjhMMUNUZHdSS3N6TlhQcmJtSjB1?=
 =?utf-8?B?NDdlcXdKMHNCcXEyaWsyOXh5RkhhdHpyeDVYVmZsUEhTS0FXZ2F2b2ZXbW1N?=
 =?utf-8?B?aVVEWDFMRGJMTkpzMG5aUi9QSFc3dXFKclVqcjN5akN0TURMUVZOazdPaGJF?=
 =?utf-8?B?VEhCWHdsQW5mbzVkVW5PYkNLcWtoOEVuYXV1L1owd2dka1VnVlRhYlloZXlD?=
 =?utf-8?B?dEcvalV1QkxzRUMxVkRQV0ZiMXRLQ2lPaXA1U2RQL25qeWNuL01wQWZqMndP?=
 =?utf-8?B?S3A1K3ZJWncySSs5NllubERFSXdEbWNZNmFDaVhWQUNpWitRM3dKc0lJQzNG?=
 =?utf-8?B?bzNTWGZLeDNYLzdCeHRZcW1JZHlSakNSc0JBZGp6SDNCanVkOFdGT2FoMG91?=
 =?utf-8?B?Q2EzVU1mc2NEVGpmZ0xHVWthVnRIWmpFMlEyLzZDckNZYUtacTVucER5cGt2?=
 =?utf-8?Q?gtTgd/kF0lciYwlxvUeE3wEZs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b85121-662b-4ddf-58f4-08dcf3fc3352
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:19:30.1611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CazLBm7W2wDdSaqbdVap39UQZzc4d1sI3+BEX9u5PE7Gd8hNposKRtJF9nXIsb7X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235
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



On 10/24/2024 12:23 PM, Liang, Prike wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, October 24, 2024 11:39 AM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH v2 2/2] drm/amdgpu: clean up the suspend_complete
>>
>>
>>
>> On 10/24/2024 8:24 AM, Liang, Prike wrote:
>>> [Public]
>>>
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Wednesday, October 23, 2024 6:55 PM
>>>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Subject: Re: [PATCH v2 2/2] drm/amdgpu: clean up the suspend_complete
>>>>
>>>>
>>>>
>>>> On 10/14/2024 1:19 PM, Prike Liang wrote:
>>>>> To check the status of S3 suspend completion, use the PM core
>>>>> pm_suspend_global_flags bit(1) to detect S3 abort events. Therefore,
>>>>> clean up the AMDGPU driver's private flag suspend_complete.
>>>>>
>>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 --
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 --
>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 4 ++--
>>>>>  drivers/gpu/drm/amd/amdgpu/soc15.c      | 7 ++-----
>>>>>  drivers/gpu/drm/amd/amdgpu/soc21.c      | 2 +-
>>>>>  5 files changed, 5 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> index 48c9b9b06905..9b35763ae0a7 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> @@ -1111,8 +1111,6 @@ struct amdgpu_device {
>>>>>     bool                            in_s3;
>>>>>     bool                            in_s4;
>>>>>     bool                            in_s0ix;
>>>>> -   /* indicate amdgpu suspension status */
>>>>> -   bool                            suspend_complete;
>>>>>
>>>>>     enum pp_mp1_state               mp1_state;
>>>>>     struct amdgpu_doorbell_index doorbell_index; diff --git
>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> index 680e44fdee6e..78972151b970 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> @@ -2501,7 +2501,6 @@ static int amdgpu_pmops_suspend(struct device
>> *dev)
>>>>>     struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>>>     struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>>>
>>>>> -   adev->suspend_complete = false;
>>>>>     if (amdgpu_acpi_is_s0ix_active(adev))
>>>>>             adev->in_s0ix = true;
>>>>>     else if (amdgpu_acpi_is_s3_active(adev)) @@ -2516,7 +2515,6 @@
>>>>> static int amdgpu_pmops_suspend_noirq(struct device *dev)
>>>>>     struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>>>     struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>>>
>>>>> -   adev->suspend_complete = true;
>>>>>     if (amdgpu_acpi_should_gpu_reset(adev))
>>>>>             return amdgpu_asic_reset(adev);
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>>> index be320d753507..ba8e66744376 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>>> @@ -3276,8 +3276,8 @@ static int gfx_v9_0_cp_gfx_start(struct
>>>>> amdgpu_device
>>>> *adev)
>>>>>      * confirmed that the APU gfx10/gfx11 needn't such update.
>>>>>      */
>>>>>     if (adev->flags & AMD_IS_APU &&
>>>>> -                   adev->in_s3 && !adev->suspend_complete) {
>>>>> -           DRM_INFO(" Will skip the CSB packet resubmit\n");
>>>>> +                   adev->in_s3 && !pm_resume_via_firmware()) {
>>>>> +           DRM_INFO("Will skip the CSB packet resubmit\n");
>>>>>             return 0;
>>>>>     }
>>>>>     r = amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 +
>>>>> 3); diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>> index 12ff6cf568dc..d9d11131a744 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>> @@ -584,13 +584,10 @@ static bool soc15_need_reset_on_resume(struct
>>>> amdgpu_device *adev)
>>>>>      *    performing pm core test.
>>>>>      */
>>>>>     if (adev->flags & AMD_IS_APU && adev->in_s3 &&
>>>>> -                   !pm_resume_via_firmware()) {
>>>>> -           adev->suspend_complete = false;
>>>>> +                   !pm_resume_via_firmware())
>>>>>             return true;
>>>>> -   } else {
>>>>> -           adev->suspend_complete = true;
>>>>> +   else
>>>>>             return false;
>>>>> -   }
>>>>>  }
>>>>>
>>>>>  static int soc15_asic_reset(struct amdgpu_device *adev) diff --git
>>>>> a/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>>> index c4b950e75133..7a47a21ef00f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>>> @@ -904,7 +904,7 @@ static bool soc21_need_reset_on_resume(struct
>>>> amdgpu_device *adev)
>>>>>      * 2) S3 suspend got aborted and TOS is active.
>>>>>      */
>>>>>     if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
>>>>> -       !adev->suspend_complete) {
>>>>> +       !pm_resume_via_firmware()) {
>>>>
>>>> Looks like this will cover only ACPI based systems. Not sure if that
>>>> assumption is valid for dGPU cases.
>>>>
>>>> Thanks,
>>>> Lijo
>>>
>>> Yes, the pm_set_resume_via_firmware() function is only called during the
>> ACPI_STATE_S3 suspend process. However, ACPI-enabled systems are popular in
>> the desktop world. If there are concerns about ACPI configuration, one option could
>> be to check if the dGPU needs a reset by directly checking the SOL register. As far
>> as I can see, when the dGPU completes its suspend process, the SOL value will
>> remain zero until the dGPU is resumed. Conversely, in the case of a suspend abort,
>> the SOL value will be non-zero.
>>>
>>
>> in_s3 is set for dGPU in case of s0ix as well. Probably, that's the only case where
>> need the flag to avoid unnecessary reset. Otherwise SOL check could be sufficient.
>>
>> Thanks,
>> Lijo
>>
> Do you mean we need to include S0ix to reset the dGPU during an S0ix suspend abort? However, the in_s0ix state of the dGPU should always be false, and there is no specific suspension handler for the dGPU in S0ix. As a PCIe endpoint, the dGPU should be powered off during system-wide(S0ix and Sx) suspend, and the SOL will be reset to 0 during the suspend process. So, for the dGPU resume case, do you think it's enough to detect the suspend abort event by only checking SOL without any Sx filter?
> 
For S0ix, I don't think there is a requirement to turn off all endpoints
- for dGPUs that don't support D3 or runpm etc. Then even if S0ix entry
got aborted, but GPU is suspended properly there is no need to reset the
device.

Thanks,
Lijo

>>> Thanks,
>>> Prike
>>>>
>>>>>             sol_reg1 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
>>>>>             msleep(100);
>>>>>             sol_reg2 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
