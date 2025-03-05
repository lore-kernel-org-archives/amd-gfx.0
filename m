Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C499CC282E5
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 15:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAEBE10E4FD;
	Wed,  5 Mar 2025 15:22:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rbfXjyF1";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E698D10E4FD
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 15:22:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3K4cj+AMZdvXZ0rfH0VrOJ1yXG3vsYlxYi+2XM8NBM3NsmJwanRywd5s1fQODI+AaBlrvPC/Ps8IhTY5UCpUzQnZQ2qJh3F14ecGwer+cQ2UNkP83WkJAacG9/A1Hs8ZmvOwu1jiNw/1uhWi5mOploU8eXq/tz+MiNuJW5LJy4raxf3rSoKU/emGeCFj2FvRh+G+wq3s/XM194G6SWuCVc1SYbMdz2cLhYYyMk5HhVf3FrFDcG7pUSMed/CSFqlhl5rOashKVp+0+NcfELrXf/32t7RMUjGNB6P3imPtGAVaCSRtnVCLmi0leYiKt7RlZJBG/6HYNyOM71Fb6vorg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCrwYdKklLLtdXO7WqDqkOzYtn7fE27ssCgPacPU/d4=;
 b=cfZCbxSJvVsm4ZtchGNqWa7R3u0/MlEEVQzjPxh2WPRywbMHSXV2YLQgsZY/u4OjtKGFw1KK7dp+PvHDXTp4OZWQjusLqEA/jqwlhGeD/MnyF0k7x1bPlkj1z205NmKb7KRDRm4TtaMFa8LfaiBhv5nzb+0Awn+Syyns/cZhsKjzwDqFaHcHcBz/M4iuyx6OKLrfbWe4cUrEc34CexJQ9+Tzsbg9vpM3ZAO6guLCaDx+KfJe/vxaNHxjR3/U3jlnBZ2Uv5SM9HGfveCA0cYWZooRJDf2TB3r/jwQlpKcZZoJTHksZXBGNAkipYWO3x4039hEUW5IzKGf6kQbhhMDBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCrwYdKklLLtdXO7WqDqkOzYtn7fE27ssCgPacPU/d4=;
 b=rbfXjyF1SurUgOmM6squFg0v2Cl2YtZcfCFjRbVQ03UsRq86Leif1F7pxcz1UPBredNncBKq73CrEuGPQsb1lLZIqp4mWl8isDaxJnR4V22NaY7vl5Gxvgp+4NjGrBW5nX/WVXXyW6xUCzCMBMNCAfEGuWxUf6ZGbSc/GdO7ndc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ1PR12MB6195.namprd12.prod.outlook.com (2603:10b6:a03:457::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 15:22:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 15:22:42 +0000
Message-ID: <627b435e-0cbb-45ef-ac2a-5ff89dbdb8b9@amd.com>
Date: Wed, 5 Mar 2025 10:22:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: initialize svm lists at where they are defined
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250221092355.336312-1-lingshan.zhu@amd.com>
 <c0fd1f01-ed4f-494d-8e9e-ae092a6ef1e1@amd.com>
 <13836d37-3f09-4278-8599-ee8f3886e255@amd.com>
 <ea0821ce-11f0-4747-951e-2b9e8a35e549@amd.com>
 <7daf0e03-29be-486b-94b5-5cb77af3b892@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <7daf0e03-29be-486b-94b5-5cb77af3b892@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0029.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ1PR12MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 59025b87-d35c-4f53-c557-08dd5bf992fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVM4cG1LazFHZkVML0FBVy9HMHQ1Q2tmWkZ2RU5JUFhSQ1FFNFRjaWxnZnkv?=
 =?utf-8?B?blIydElwQ0RmelJwTEdIU3FJUTdNMTJJZThaV3FPRzRBbHloeSsxZjBCQWFH?=
 =?utf-8?B?K3JSZTViU2s0RHprVjMwNHJPY3psajBUa2Z0NU55NEU2RlVBY0VWNVgvRThK?=
 =?utf-8?B?LzZHczFybjZpeEVxQ3g4QkYwZGpDWkJCSnYwN09xZkQ4MzlZb0VpbmRuUHNw?=
 =?utf-8?B?Q2FUYzIwbVF0eURaMHdySmhmckZYSDVUdE5IbkY2eUY4UEtwclBYSzJtOVRX?=
 =?utf-8?B?TW9IZDlzNmVGQlNHWjVVUWNyUGFSUE5WckRnSXI1azYrb3U4QlZiRmRUbU00?=
 =?utf-8?B?UC9Fa05mV0xYM1lTT2FxNmJrU1prOS9uZWtkcnNSNkFuTjVTa0RJTWRFcnda?=
 =?utf-8?B?MXhWdC8ranU3UGMrdU5Yek1DTUdScWtDcUdGNHYwNTQ1RmVVS21ZM1JJaXI3?=
 =?utf-8?B?YVgyTEQ5OW5MYTJ3MHBKa0g5ZG1velRWNkxqdmd6b0dsQ1dVZ29rdENvZzRN?=
 =?utf-8?B?cGl5emRPTDliVE9sSXBGa2EzRVFNMXhjTjN3QVA4M2RVc0QrYzZ3L2l0VHFj?=
 =?utf-8?B?bEU2cjJGSGVCYnA2eUF1NXRZZEZwTjNHWXlxQ1lGeU9SZDRFYWRPYWxrcEtB?=
 =?utf-8?B?K2NlcjNKbENOUGhPZVU3NlBmU3YwMjVLWXBvR1RIaWE1N3I0RFBZcXIrZlcy?=
 =?utf-8?B?WXhqZm4xbjNYdmUzWFVuSmkwVUczVzYvSjltaUZUcm5PenE4VGhVak5ka3Jo?=
 =?utf-8?B?MVU3R1lNRkcyYU1WbVlpTmlPTjlSbkZXSXRZc2o4Y1hUc0pTalhWZG1vOXZV?=
 =?utf-8?B?L3ZvbW4vcVp4cjhBSTlyOWNkd3I2a0N4VFlHMk1yWDZBdjRqajl1ODdqK1ZJ?=
 =?utf-8?B?OEpvT2NPYW5GV085dk52cWRYT01WVE9odjhHSEdtQ2Q1QkVvNFc0RFFVWkpm?=
 =?utf-8?B?M1UwRVlERU1GSDM3Y3EvcVpuOVZsalRmVGlGendTaGhETTN1T3ZCNkErV3hB?=
 =?utf-8?B?c0g1N3ErcXRIMHlVdUk1dmZXL3M5alRHY1cyTGpzTWsrRHFYRXQwdVlyK21L?=
 =?utf-8?B?QVQvbDdKV250RGJJbldlOVRQRkFMY2I1MVJQU1NsclgzUTR0eHZPclpzeXdO?=
 =?utf-8?B?ZTBlZFZmcXRCNnNvWXZyVnVvR3Q1bnExbTlFb1VVTDEydncvT0M3aXd4VFVi?=
 =?utf-8?B?RmpRNjBYWjhaNGRnSHNEOHNCVENjcHpoYWRkRld6WTBjWDVqbytSR1cvYXhp?=
 =?utf-8?B?NlVPay9TNGpBYjVNMDh2cjl3bVF3eS9XNm0zdHlsS3lWWTBaZUxDWVpqcHZQ?=
 =?utf-8?B?L2NRa1JmbW9DVkpwMWNMeDFodk1KS2tPVU94cFh5aGRiWkxDQzFZZE96bTJo?=
 =?utf-8?B?SHBwMmFreCswR3dpdU1TaE8rcFkvZjNJNXhDZE02aXpOczdSVmM3VzNaRlpP?=
 =?utf-8?B?aG1LdmFjd3JGa0RWRXRURXZ0dEdjUllhQzZvSnNSejd6NUJrZjZCdXh5elpV?=
 =?utf-8?B?TnpqdUJ0VVdtamJuTDJnSjFJL0dydERabU1kbjl5d2tRMWNnRWxYcGZLV2tU?=
 =?utf-8?B?VmJaMitmdFZlNDRpeE4zenlJL25JRFQ2K2lOTUlkbDkzci9rQlBMenExT1Bw?=
 =?utf-8?B?ckRJZU1MdTFMcWEvcitsb1AyR202UHF3K1U5MCtPcnRQVmREOCtjL05nSGJ1?=
 =?utf-8?B?ejg2cjN6ak9Yelo0cFZ4R2pMdlNPU09tWUI0ck9ueE55TkROVnR6TGlrVFNL?=
 =?utf-8?B?MUZhZGV6UXhaSEdGS1hxWTlIb2ZCR0Q5MThuQmpWbGtTQ054UEY1Ym5oRFJB?=
 =?utf-8?B?azBTaG9iMTBiNjkzeG5DeEdVVUlXck1EZ0RyTVdqdmZnVGVMYTNNMlB5MjRC?=
 =?utf-8?Q?83CXNteHkprFM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVJVUGNPd3FrMU1sWElKb0RQdG9OMlNmdng1ZWpIbXdQOXVDcGRmOWM1SVZ3?=
 =?utf-8?B?RVdHazRIMjRwdnVTNFhsSTJGREJxR1c5Um9FQTFNWHkzNUtKSFZFQjl3QTdI?=
 =?utf-8?B?eXhHQThoK0R5ZDVaWU90OWFUanhJR0VtaGRqZ0d6MHNtM04xT2dBM21iSms3?=
 =?utf-8?B?RHdsODkyVUdZU1JTb2lFdXd4cWc1K0pGQ0NmaHVsT2tSZVNnMWNaNjJmZXlE?=
 =?utf-8?B?ZGNCM1hQYW00a2dDMG5tcGV6a3JkeVlQUE9MZ3NLUHN1Y0ZHTnEwOCtuYXFN?=
 =?utf-8?B?aURzT2d6c05Kay9NWEQ1NW8wYXB4YkJuaDYraUdRL3ZtS2l0UytVd3h3OGVR?=
 =?utf-8?B?Z2dwSVNEVElKM3IybUN3cVgrK2tmaDMxK0FsMFlXeFgzN08wMXVvMFpJNzdj?=
 =?utf-8?B?WWF5R0NBVjl5YlltWHFjMnZad2xGZGx6ZmF5T0U4TjZJODdZVSs5Y2R1aldz?=
 =?utf-8?B?Q3d2TVpaMTdzTXliZXhmZXZXMi9oVG5Xb0FnN0hham16a3NXSmQ5VHkzSDhw?=
 =?utf-8?B?NE9ZdTh5SGF3YjNqTG83YVZXTUdGWHMrcFBBK1oxTEhITjl2Q3BwOVRLRlI1?=
 =?utf-8?B?N0pZWkhtUTFOYlZLaDk4V3FZdTZtZFZqMFlBcTRMZEp0YlJ1cDJiSXE5QzV3?=
 =?utf-8?B?SXBVbDNVTk9peUdzckF2cnFTQmVWdlM1aFB1Vnl0aDZ0M3VKbit3YmxVcjIx?=
 =?utf-8?B?Sm96U3hxOUk0QmlSRks5bmhIelZnMWZERjlCdWZudnBHVldNeWpJa1JkcnN1?=
 =?utf-8?B?UHJZcmhDY1k5cUlZWE9makRiQW9OUS9NcEMvaGh1WEh0M1Z0bkpTVERaRS9W?=
 =?utf-8?B?U0NxL3NxUW1XYUs3QlltaHZoV2RjaEZNY2RVRWdiWndmOU9zbjlhTGZpSFFu?=
 =?utf-8?B?L1B6ZzNlczV4YUx1RmtHWWd0dERZYlBocFZlK3dsZFRBYnhibTcwVXMyRlpP?=
 =?utf-8?B?VFpPa3lxUzM3TnFZVmF3bS9OOFBoWFp6Q3IyRFFEU3ljdStQaWJWUWtDMmds?=
 =?utf-8?B?Q1ByNlA5Y291M3ZEYmdSOXBNNVdEaGprUHc0dk1IS1VGSUwvTGw1UHUwSmhw?=
 =?utf-8?B?Mmc5NVdobEtmQjljb1UwV1preFY4VDBya0ZlbUFxa1Y3amo3dWpDd0tsb2ZB?=
 =?utf-8?B?aGZoUm1kUnJteXZBRVJaQ0p0OWtOU3NQVGJ2NlZpVGVMK3ZDbDlSWXpUUWIv?=
 =?utf-8?B?UmJKY3FLNC9XU1hvNjIxSUkzcUp3cnZVSU04OExkS1FtT1pTbW0wVVMxalZt?=
 =?utf-8?B?U01ZaEpCRmFFeVFqT2R2aTQvbk00bFhqeW1vWiszaWdaa0xER1hWWmc4K0k3?=
 =?utf-8?B?WVIrc2dxZHFCM0RNZUlqaHRoRXJ0UHNERGhJVE9HTU9aU0tITEx6T2lWUlJB?=
 =?utf-8?B?UlNHL3hONGhvSDlDbHJUOW5IV0hiQi81OUExMHVod0Q5WXdVRjByZGNIL1Bu?=
 =?utf-8?B?V0FQYzhFU3BtekZmR21UbGZGd1RKLzA4MkEzcVZNZ202cHIrZWlhRGZUYTMz?=
 =?utf-8?B?NHJNK29FRmQ4YVRtblFaTmQ3cXJrTDRmQWxVeXRmenNXS2hlTUhFcGVMMk5s?=
 =?utf-8?B?bUpSTlY5OVlxWHJyUndGTXdncU12M2RVMnBYR2VLMEJzWmpUb1N4aFllYk82?=
 =?utf-8?B?WUFveWFTYnlvYTdzMmVOeVREYVhKOXZmN0hCTXpIWE53Um9sOHhTdUdIUFMy?=
 =?utf-8?B?c0dNRWRYVHNPcU5iek9BWnU1b0d0VDhQOVJwd0VUUDkzaDJxNmEwOUtEcFBt?=
 =?utf-8?B?UktsYzNKMWhzNWtwekJqTmtKb21wamlDTnREUXlxVmZiZUU5ZlYvUll6Y0tS?=
 =?utf-8?B?M1YwVi9iTlJpdVFYUHVDLzdIaWx5MHRjZXdnQjdQY0d6cWZHMFlsVURtMElF?=
 =?utf-8?B?bkdVUUF2VkJtTTVDZy9ZaHZlOHdJT3czRndOUFpxbWVwcHlKOGIyd3hHWWc1?=
 =?utf-8?B?M0xUczhjSGUxb1UyY2ppangzRE52SFdyZC90ZVRZeWE3UWpZMjFPS0VFSnFk?=
 =?utf-8?B?T2ppblZlZHluckhicjlVV0cvTUJrUnpkM2xsWWVvenk1UjkrU3kwcTdmYlZO?=
 =?utf-8?B?RDNVYjlxdjVKc2haemt3R3F5U3BIVVJmdFI1YzNmTmlMRm9zQzUvWkxxL1ov?=
 =?utf-8?Q?ozYZUNUxJRj3ojo/DsHYoe5zW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59025b87-d35c-4f53-c557-08dd5bf992fa
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 15:22:42.8897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Kz50XUaW7CnNPWidkcBTCdAuzJAPJhM9GeI64zWgG6P0pp+O30gKB9QktrqC90NVC8GycEswE2typBEqt/QKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195
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


On 2025-03-04 22:11, Zhu Lingshan wrote:
> On 3/4/2025 11:16 PM, Felix Kuehling wrote:
>> On 2025-03-04 2:40, Zhu Lingshan wrote:
>>> On 3/4/2025 1:49 PM, Felix Kuehling wrote:
>>>> On 2025-02-21 4:23, Zhu Lingshan wrote:
>>>>> This commit initialized svm lists at where they are
>>>>> defined. This is defensive programing for security
>>>>> and consistency.
>>>>>
>>>>> Initalizing variables ensures that their states are
>>>>> always valid, avoiding issues caused by
>>>>> uninitialized variables that could lead to
>>>>> unpredictable behaviros.
>>>> The lists are clearly documented as output parameters in the svm_range_add function definition. I think it's more readable to do the list initialization in svm_range_add to keep the logic of the caller more readable. One suggestion inline that would move the initialization to the caller without cluttering the calling function's code.
>>>>
>>>>
>>>>> And we should not assume the callee would always
>>>>> initialize them
>>>>>
>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++----
>>>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> index bd3e20d981e0..cbc997449379 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> @@ -2130,11 +2130,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>>>>  
>>>>>  	pr_debug("svms 0x%p [0x%llx 0x%lx]\n", &p->svms, start, last);
>>>>>  
>>>>> -	INIT_LIST_HEAD(update_list);
>>>>> -	INIT_LIST_HEAD(insert_list);
>>>>> -	INIT_LIST_HEAD(remove_list);
>>>>>  	INIT_LIST_HEAD(&new_list);
>>>>> -	INIT_LIST_HEAD(remap_list);
>>>>>  
>>>>>  	node = interval_tree_iter_first(&svms->objects, start, last);
>>>>>  	while (node) {
>>>>> @@ -3635,6 +3631,11 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>>>>  	if (r)
>>>>>  		return r;
>>>>>  
>>>>> +	INIT_LIST_HEAD(&update_list);
>>>>> +	INIT_LIST_HEAD(&insert_list);
>>>>> +	INIT_LIST_HEAD(&remove_list);
>>>>> +	INIT_LIST_HEAD(&remap_list);
>>>>> +
>>>> You could initialize these where they are defined by replacing the struct list_head ... definitions with
>>>>
>>>> 	LIST_HEAD(update_list);
>>>> 	LIST_HEAD(insert_list);
>>> Yes, this is better, I will use LIST_HEAD and remove the initialization in  svm_range_add because we don't need to init them twice
>>>
>>> By the way, I am not sure the lists are "output parameters", usually an output parameter should carry some information for other functions,
>>> but here the lists are just defined, even not initialized, and are on the stack. Actually the callee only fills the lists and the caller itself use
>>> the lists. I suggest to remove the "output parameters" in the code comments.
>> Input parameters send information from the caller to the called function. Output parameters return information to the caller. In this case the lists are that returned information. Therefore I think calling the list heads output parameters is perfectly valid.
>>
>> In fact, I could turn your argument on its head: If you move the initialization to the caller, you now rely on that initialization in the callee, which may be a problem if the caller forgets to initialize the list. In then end, it's just a matter of calling conventions. It doesn't really matter where the list heads are initialized as long as they are initialized in one place. In this case the function in question is a static function that's used exactly once. So there is really no point overthinking it.
>>
>> I'll give you two options: Leave the code as is, or move the list initialization to the definition as I suggested. I will not accept a change that "fixes" this non-issue at the expense of code readability. I disagree with branding this as a security issue in the commit message.
> I think it is just a simple issue of passing uninitialized variables  to a callee.
> Yes currently the callee initialized them, works perfect now.
>
> However, IMHO, I am not sure we can guarantee there is only one callee work on theses lists and every callee not forget to init them, most of the time the callees assume the input parameters are properly initialized and can use them safely, lets try not breaking this assumption by initializing them at where they are defined. This change actually provides better readability.
>
> Accessing uninitialized and random memory address can lead to unpredictable behaviors, for example overwriting others data or kernel panic. Therefore this is a security issue, but I agree not worthy mention security in the commit messages.

Good. It's just a minor cosmetic change. So let's not spend hours debating it, or blowing it out of proportion. If it improves readability, I'm OK with it. If it's just change for the sake of change, then I will NACK it.

Thanks,
  Felix


>
> Thanks
> Lingshan
>> Regards,
>>   Felix
>>
>>
>>> Thanks
>>> Lingshan
>>>> 	...
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>>  	svms = &p->svms;
>>>>>  
>>>>>  	mutex_lock(&process_info->lock);
