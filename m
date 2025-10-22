Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C86CCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 06:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70E8810E6C1;
	Wed, 22 Oct 2025 06:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="glyrgq3y";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013035.outbound.protection.outlook.com
 [40.93.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC4C010E6C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 06:59:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1SMNpHUTM965npCEdFW2VYdijUKB9gWvyoS3dBnnRzaeIhu4FVxh/WOHQrSiW3Z7KyPqnK50APS2Ex9JHhHQEVutNZqFWqEfhEZqt6Wb8Q4KvITI59LHWI+NTp2WPzmVjvZ6SNkv3aWE3DjhBe8jS8newZuph52xg600yGnEWp4g/ae2mQ4PVRPvS+/gWnYg4y5Ag9PHDYE8zdaZ6hCTpCZrlQtWzQWDChMS8A7XjKCfYwwjZgd+ZEb4rP4yW+VDbk5ezPRdMvEwdjri9c4UVLRqa23sxaufwQjP9/QeGTlT551rxxBGRuaTGn81IBvmOWhZLK+CUwEt3f+rIdymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T16EwHvxDogcEss3/Pet0+jc7rSYRyapbNjNwLSf1Eg=;
 b=LDLlvoQ0AZfAXm4ncKBBGh9RdKAauosAHTrhx/g2i8E3ie47cRoEYoCf2+iPvTgqXBbLNfkJNIQSxugsYmv9P23nKjLQL3I6R5uxF45AkXAEhrZt9upQTWcSnkzofoojxFcz0nuuCWJuaw/7imlPvIDxfnMLEksivelyyYwCYLj7/ZitZ5A9dQF/lFw3BeyuYndj1suxkVBv2jM6RYWmG6XksxcgHvy1tpK32VP4iADNCG+NIoV+/UZcjr1wHr9wOmZYvikvBTLKtRKVaFYjyIpxVhbouXDjMOx0PYtGlZtWdgDrduanZnjbulMcIMALRUeTMVLeTi1B1lGNvzCamg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T16EwHvxDogcEss3/Pet0+jc7rSYRyapbNjNwLSf1Eg=;
 b=glyrgq3y+tEakuI2BJgUCN5/7OAEM9NbDvs6mURTMsqsLT4SZR2F0JUi9HkFJkj8jnHKCMFxr8zuigdhPgEeStgw7oyuadBJVMHj5FyyEMu7SogyyMY7xEPvSmjWagIF75jp0J/fiEd8sv4uyKEqbSV/329cR3Eja6HRlU6Cy1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by BN7PPF39B20C1D8.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 22 Oct
 2025 06:59:47 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%7]) with mapi id 15.20.9228.015; Wed, 22 Oct 2025
 06:59:46 +0000
Content-Type: multipart/alternative;
 boundary="------------PDl7kgp0smo4faMb01L7l8NO"
Message-ID: <d6dc732b-3926-4b54-9a52-90050d7bb1ac@amd.com>
Date: Wed, 22 Oct 2025 14:59:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 18/18] amdkfd: introduce new ioctl
 AMDKFD_IOC_CREATE_PROCESS
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
 <20251017084222.54721-19-lingshan.zhu@amd.com>
 <b545b31e-26ff-4b7a-be86-312d9aa96e97@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <b545b31e-26ff-4b7a-be86-312d9aa96e97@amd.com>
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|BN7PPF39B20C1D8:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f34df6-555f-4bbe-c5a7-08de113895ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YW9LVEpxaDVRcDhYVGhvZ0dNUGZZWU1wa1oxbE5vcFVPZVkrTm8rdXVKNEIx?=
 =?utf-8?B?dTlmUytIa3F1bW5JeW5XZnVmV1NzMHlQWVluY1JCWmZKWnVBNXhmM3B1cUpz?=
 =?utf-8?B?eUxPbTkybUM5aC9OOVR6dlJWcmJ6QWFvcmhXZzBYTXo0dW12NngvWWtHSVZF?=
 =?utf-8?B?WVpDOE94cURXbWRka3RjNTl0NEZSV1UySlBtQXJkcjJKQ29yUVViSWRlOWRD?=
 =?utf-8?B?WUdLTmt1cXh2ZUZmMis3ZlFTaFVRQzR5TnhrM1p2a0E0ZWhnYThWMkY1cWd4?=
 =?utf-8?B?M2lYVmdFSHRqSXZJd0tWb1g2UlNXNFZQeWFhK3QwZUVLQUp0TTV4aU95VHBr?=
 =?utf-8?B?bWFSZUhNWGdyTE1XNGtZcVZEYUphVFdHRFlWc3dEQWZXR05TTjY3YytWR01Y?=
 =?utf-8?B?RkRMNFZkL1phemVRWEZMaXN1WHd1N2tpbnVyTXVpSFRGVUREdzBLbVBUc01i?=
 =?utf-8?B?VXBhcWhFQ3BwY2Iwb0dsTEhvUVBsWVQ4bmozaWpkZDhoTEp6RUV6UkxIcHpt?=
 =?utf-8?B?RU92MEUvVGJuejNzUk0wN0hvbmd6NGVuQjhBb0Z2aEQ3ekVyTjFORU1EVmxV?=
 =?utf-8?B?bkpjYy9ZdytCclBveUhLTS9tdG5YQnJic0dKbEltTDROS1EyYTJrNFJDSnBL?=
 =?utf-8?B?Ty9rWGtKQm1qYWY2YWJjdVpvb1o1UUFTREZ6bWcwR1J5anVod3FsWG9naENz?=
 =?utf-8?B?QXJvd3p2dWM4M09velhGb284YkFRUHpKRVl3eE1mdGFDamZVS1IwN1p3azFt?=
 =?utf-8?B?d2tyOXFXTk4wZHVxN2QvWldNd3dRd0dhU01JZzdCTUhmeHJpanprelB6aU02?=
 =?utf-8?B?NjI1cGhaL3ZyWS9vVkpDQmM4eXN6NnpsU0RFS25QMWlWR3Z5WUZDNjNDSkxm?=
 =?utf-8?B?dThkK1d6b01WdkhiVmcveEJWQXVxVjlUbVhyR05RYjhSTzlUWDRoS1JsOTJX?=
 =?utf-8?B?TWxGaU50Vy93NFV0OXJxb3F5UXdkbGFGaHljSVhhZFdJRFhKYWZCZE1UZm5U?=
 =?utf-8?B?c3VoZ2VGenRsN1VCU0hrQ3NpWkFXZUdOaGszQzYyUUFnOE9sRGtBMThhc091?=
 =?utf-8?B?SWgyTi9XWTRlZXpGUTdnMGJyMXdpV09sbHorcWxOVHpDRWdRNEM4aXhBa2FF?=
 =?utf-8?B?VjFPa2xncjhWL21pR0F4RUZpbzFRR2gvY2hNNEVxMG44OHIrK29xT2ZjQzBv?=
 =?utf-8?B?eWFOTTFGRXBES3lRekEzRlNpWWNJcTJmZndqWTNCMC81UFRSYWc1b2RiS1ZD?=
 =?utf-8?B?QnFaVFBoSG0vbXRlVXl0UlAvRkJCaHhiKzE5ajVJd0hlcGxCUzNReTYxYWZL?=
 =?utf-8?B?Z1JZVmNzYnpXbkZIRnA2L2FiVFdoVFZtUFFueWVVNDVXTHBNWjd6Zzk2SWwy?=
 =?utf-8?B?YksxcGRCdG4zMXNQRUdFaXBxUjVGR29lUjgrcW1LMXFuUm9xc1U1NGF0NkVI?=
 =?utf-8?B?Ykd3dnBXaWVsc2RTYXVGNmhtK3Z4MTZUOUhlYk10azMzemNJajZ2VFk3T2lU?=
 =?utf-8?B?YUNHcEJIaUgyeTVuYmxLenljeVpFM0prL0U4M2Y1Lzh1YStvaytsUTd0RWxW?=
 =?utf-8?B?dTRwK2lpQ3EwUU5tWFVDM3p2R0h6aXAxYXN2Vkdyelp0WkJGb1I5RFRxZ011?=
 =?utf-8?B?eTFYb2hZYjM1K0FqMjd6YjgzcFFiQVBFcUZSQUd5cjJwWmkxUWJTN1JkYzVO?=
 =?utf-8?B?bXcvSjhnUUhSUy9LZnh0SURPZkU5bFBkT1FaMGNCLzIzRC9JNHR5cTBhTGZh?=
 =?utf-8?B?Qk5LaEdPOVZ0ZmtLQmdsNUQ3Z012NW5yckNOUkJWOWR2S2FTSkdncmpMSzVW?=
 =?utf-8?B?VWQ3cGcwZElaVER1RDFhbTZhUHlFVVBFVG1tSGk3ZkVGV1diU1l3VWFOMXNK?=
 =?utf-8?B?NFlVekFrc2EzVXRsYiszRnFOZy90dGlSS0tCYkJnQ1BzVzh2Tk9YUmxQazNJ?=
 =?utf-8?Q?2hRYbv19ZaZic1KxhuwddX1ZZSexgGP8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czJERkVaNE1GZmJyNUJlNnhJRmJkMTNGNXdOR2d3NFVGUm1DWlZCMVVuTGhp?=
 =?utf-8?B?aTFMRU0wd0NSQUE5bjFJQ1lnK3VFdG9qT25PSkFEQ0FuYndCVlBTdWorRTJs?=
 =?utf-8?B?cm8wL2M3cFZCRzZnWUZ2NDltTnZPL3ZUV2wyeFZuMElxQVNEM2I3bnpJMm1o?=
 =?utf-8?B?S1lXWlZwbGJFNVpjWDlRVkdTODZkNGtTQVZQYmhwTDNvSUxucFFjQ1dUY3Nj?=
 =?utf-8?B?ckZHdW1JWU1ORXZuNktqL1IzWWpISS9JL0NDK1Nwd0w0SktYSjdmSXIyOXJR?=
 =?utf-8?B?OG9BWkE2bEdZMDk4SldERTdkNEF1dlZmUXpWbXUyVzNKTkZmTnhsb2t4bUh5?=
 =?utf-8?B?aXo4U3dFbmhuNWFObkMxWWZiajZEZHBScVZsMFpKNDZETXNvdjJJbUY3TGxE?=
 =?utf-8?B?WWRMOGFuSTIzMHdVaFphaG5ma2NEdExqU1U1ZTBxcFk2TWU3SlJnYlcvWCtN?=
 =?utf-8?B?R0Q2cGRDV1VUaW1wamFOMWpvOVI3dWYyenhjc041Z1Y4Q3IzK1VyL252aFpK?=
 =?utf-8?B?VVNpQWNXZWlSeVJXcTFQaUQ2RWd0cGl2SDhVYVVDaXJ6S2VuTXpZbTRTVVph?=
 =?utf-8?B?VVYyakI3bngyOVBPWDhCYTBqR3NxWklPK1pvRmZjREx5eUl4QlVNZnRVWXpi?=
 =?utf-8?B?UjJzVzEvWmxTa1Vqd0RxRGlGZnkyamdLek5yVVZwcnYzRFVoUHN6Y2lQTU04?=
 =?utf-8?B?MDJGOEIrbFhiZGlqZy93eTk5LzdvcEI4L1p1TVFyMjNqQTJrcDl5V2hlbmd2?=
 =?utf-8?B?NlRCajNzcXhGczdkWGNZc3lGbEZBVmM4MmxWWXpkc2xXNlI5YkJDd0x6MlJo?=
 =?utf-8?B?di9IY3prNFhlRzNpY3JpNlpVeVhFQlhTN3dSenFjZTRqbHYweU1VOGEyTXdB?=
 =?utf-8?B?dTBSbngrUTFTdGlkVUV5NWRoRWd4czh1WTRjUWRydjVOZmQxK3UzcHZXdVBr?=
 =?utf-8?B?ZXFld1N6dmRreUxQRm81Z0ZNWll1eERuYnpzZHZQRHUxek9OOG41MCtRN2lx?=
 =?utf-8?B?eVlxeTh4MXdvNy9QU3o1N1l6WHI5bjV3Z2I3UnppSVJoVEM2RjNtb0plOEhT?=
 =?utf-8?B?RnBNazFwOCtTYjJ0dm5Na1NldFdZRmR5a043TGpBd2RXMHErVUNjaXRkdjRq?=
 =?utf-8?B?Y0Z6eGlQdXV5eDllQVU4RkYxbjBBYWVWWDBqWEZDQXR6ZU81WnJDTGEwR2Ev?=
 =?utf-8?B?Z055OEZldit4c1BMenJrekdpN3RRTjdsNi9sMnVONURBRXpRclNROE5MN0dK?=
 =?utf-8?B?RWJ2dHVIYU1LKzUzWHBvejFpbWtYbDd3Y2tlVS84ZG12TXg1TWRGSWNlamUz?=
 =?utf-8?B?b2JQVml0K0ovSnIxb2QzakU1THJ2bTVRN0lDYWRTV2JYdHlSVDBEZE00MTZ5?=
 =?utf-8?B?ZEs5czlJMm1zb2ZQMy9PRDBCN2pvK0RMSVJDWHJyb0JET1FrN3JORUN1RHZs?=
 =?utf-8?B?NUFpYzdxbHBsclBpRFZIaGxHK2ZaUExWL2w5ZWF5bmJWZ3N6T0xSRHZUQmk5?=
 =?utf-8?B?VlQxVDJ1dWtmMy8vNzVGMmRtYTgwdDFGZWxkakw0NGFFMzUwTDNlYk81VDFE?=
 =?utf-8?B?VEJhek5lRUJpU2xqcGlnaW1xSTFZN2hMMjlFdVBjZjBKeUcrN3pIVkxtMjNN?=
 =?utf-8?B?Q09zS2dlUEYxVW9ucEMvMnhIa0xFYTlpc3orRk04eFBJd05FUkU2dWpLa3Nv?=
 =?utf-8?B?ZFpwQlBiMXNYZWNlRHZpV0xxVS9GV3JoNWhOS1A3QTlQczU5bEZCaU1scUU2?=
 =?utf-8?B?NkZIRHBwNlFlUm9vVWQ4QXBsUXp5OWljY0U0RFRjaDM2OURJR3BucVZTVi80?=
 =?utf-8?B?RjdRRURQV09RZzRQR0hTYWw2dXRpMU0yc1FrSXI5YmVGVVVDTG1FY0FiMU5S?=
 =?utf-8?B?YUk2WXdDQzExN3gyS1NvbzU2TXRvbWFZbDMxUXVINFY5MnhhSkVISXBSR2dy?=
 =?utf-8?B?ckhTRnZiMTdRUnhraGRRdks2RVpJbnNQdm1ra21yWHZBVmg2bWxTWDVTNERm?=
 =?utf-8?B?aDViRm5sYmlSQlovQlYzK1FpR0JhZDg4K3RoNEdkNUkxS0tNTlZJNWRJb0J3?=
 =?utf-8?B?alFzSFliVzVRZVZ4RFZZOW0zWDEvdlp6cHF6OG9sT1VrWXlrOU8wcHdVbmY2?=
 =?utf-8?Q?En03NmXVASghk047VnxFRP33d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f34df6-555f-4bbe-c5a7-08de113895ab
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 06:59:46.2599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyTh5CzZIA1aiuth8SUAdv8cKFGZOkZucWnp/3N0nl7D0Y5sZT1Tui3bNpO7bUV6v873aMViwyVq8/i0j+lubQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF39B20C1D8
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

--------------PDl7kgp0smo4faMb01L7l8NO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/18/2025 7:55 AM, Felix Kuehling wrote:
> On 2025-10-17 04:42, Zhu Lingshan wrote:
>> This commit implemetns a new ioctl AMDKFD_IOC_CREATE_PROCESS
>> that creates a new secondary kfd_progress on the FD.
>>
>> To keep backward compatibility, userspace programs need to invoke
>> this ioctl explicitly on a FD to create a secondary
>> kfd_process which replacing its primary kfd_process.
>>
>> This commit bumps ioctl minor version.
>>
>> Signed-off-by: Zhu Lingshan<lingshan.zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 41 ++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  1 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c |  3 +-
>>   include/uapi/linux/kfd_ioctl.h           |  8 +++--
>>   4 files changed, 49 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 7c02e8473622..8fe58526bc3a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -3140,6 +3140,44 @@ static int kfd_ioctl_set_debug_trap(struct
>> file *filep, struct kfd_process *p, v
>>       return r;
>>   }
>>   +/* userspace programs need to invoke this ioctl explicitly on a FD to
>> + * create a secondary kfd_process which replacing its primary
>> kfd_process
>> + */
>> +static int kfd_ioctl_create_process(struct file *filep, struct
>> kfd_process *p, void *data)
>> +{
>> +    struct kfd_process *process;
>> +    int ret;
>> +
>> +    if (!filep->private_data || !p)
>> +        return -EINVAL;
>> +
>> +    if (p != filep->private_data)
>> +        return -EINVAL;
>> +
>> +    /* Each FD owns only one kfd_process */
>> +    if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&kfd_processes_mutex);
>> +    process = create_process(current, false);
>> +    mutex_unlock(&kfd_processes_mutex);
>
> There could be race conditions between multiple threads calling this
> ioctl on the same primary fd concurrently. We could use the
> kfd_processes_mutex to protect against this. You'd need to do some of
> the above checks and the assignment to filep->private_data under the
> lock to be safe, to allow only one thread to successfully create the
> secondary context. I think this would work:
>
>     /* Atomically create the secondary context and assign it to
> filep->private_data */
>     mutex_lock(&kfd_processes_mutex);
>     if (p != filep->private_data) {
>         /* Another thread already created a secondary context */
>         mutex_unlock(&kfd_processes_mutex);
>         return -EINVAL;
>     }
>     secondary = create_process(current, false);
>     if (!IS_ERR(process))
>         filep->private_data = secondary;
>     mutex_unlock(&kfd_processes_mutex);
>
>     if (IS_ERR(secondary))
>         return PTR_ERR(secondary);
>
>     /* Release the process reference that was held by
> filep->private_data */
>     kfd_unref_process(p);
>
>     ... 
>
will fix in V6, thanks!

> Regards,
>   Felix
>
>
>> +
>> +    if (IS_ERR(process))
>> +        return PTR_ERR(process);
>> +
>> +    /* Each open() increases kref of the primary kfd_process,
>> +     * so we need to reduce it here before we create a new secondary
>> process replacing it
>> +     */
>> +    kfd_unref_process(p);
>> +
>> +    filep->private_data = process;
>> +    ret = kfd_create_process_sysfs(process);
>> +    if (ret)
>> +        pr_warn("Failed to create sysfs entry for the kfd_process");
>> +
>> +    return 0;
>> +}
>> +
>>   #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
>>       [_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags =
>> _flags, \
>>                   .cmd_drv = 0, .name = #ioctl}
>> @@ -3258,6 +3296,9 @@ static const struct amdkfd_ioctl_desc
>> amdkfd_ioctls[] = {
>>         AMDKFD_IOCTL_DEF(AMDKFD_IOC_DBG_TRAP,
>>               kfd_ioctl_set_debug_trap, 0),
>> +
>> +    AMDKFD_IOCTL_DEF(AMDKFD_IOC_CREATE_PROCESS,
>> +            kfd_ioctl_create_process, 0),
>>   };
>>     #define AMDKFD_CORE_IOCTL_COUNT    ARRAY_SIZE(amdkfd_ioctls)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 4237c859050d..578f9f217e16 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -1055,6 +1055,7 @@ struct amdkfd_ioctl_desc {
>>   };
>>   bool kfd_dev_is_large_bar(struct kfd_node *dev);
>>   +struct kfd_process *create_process(const struct task_struct
>> *thread, bool primary);
>>   int kfd_process_create_wq(void);
>>   void kfd_process_destroy_wq(void);
>>   void kfd_cleanup_processes(void);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 629a706e2a13..bbb72a77bed5 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -68,7 +68,6 @@ static struct workqueue_struct *kfd_restore_wq;
>>   static struct kfd_process *find_process(const struct task_struct
>> *thread,
>>                       bool ref);
>>   static void kfd_process_ref_release(struct kref *ref);
>> -static struct kfd_process *create_process(const struct task_struct
>> *thread, bool primary);
>>     static void evict_process_worker(struct work_struct *work);
>>   static void restore_process_worker(struct work_struct *work);
>> @@ -1578,7 +1577,7 @@ void kfd_process_set_trap_debug_flag(struct
>> qcm_process_device *qpd,
>>    * On return the kfd_process is fully operational and will be freed
>> when the
>>    * mm is released
>>    */
>> -static struct kfd_process *create_process(const struct task_struct
>> *thread, bool primary)
>> +struct kfd_process *create_process(const struct task_struct *thread,
>> bool primary)
>>   {
>>       struct kfd_process *process;
>>       struct mmu_notifier *mn;
>> diff --git a/include/uapi/linux/kfd_ioctl.h
>> b/include/uapi/linux/kfd_ioctl.h
>> index 5d1727a6d040..84aa24c02715 100644
>> --- a/include/uapi/linux/kfd_ioctl.h
>> +++ b/include/uapi/linux/kfd_ioctl.h
>> @@ -44,9 +44,10 @@
>>    * - 1.16 - Add contiguous VRAM allocation flag
>>    * - 1.17 - Add SDMA queue creation with target SDMA engine ID
>>    * - 1.18 - Rename pad in set_memory_policy_args to misc_process_flag
>> + * - 1.19 - Add a new ioctl to craete secondary kfd processes
>>    */
>>   #define KFD_IOCTL_MAJOR_VERSION 1
>> -#define KFD_IOCTL_MINOR_VERSION 18
>> +#define KFD_IOCTL_MINOR_VERSION 19
>>     struct kfd_ioctl_get_version_args {
>>       __u32 major_version;    /* from KFD */
>> @@ -1671,7 +1672,10 @@ struct kfd_ioctl_dbg_trap_args {
>>   #define AMDKFD_IOC_DBG_TRAP            \
>>           AMDKFD_IOWR(0x26, struct kfd_ioctl_dbg_trap_args)
>>   +#define AMDKFD_IOC_CREATE_PROCESS        \
>> +        AMDKFD_IO(0x27)
>> +
>>   #define AMDKFD_COMMAND_START        0x01
>> -#define AMDKFD_COMMAND_END        0x27
>> +#define AMDKFD_COMMAND_END        0x28
>>     #endif
--------------PDl7kgp0smo4faMb01L7l8NO
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    On 10/18/2025 7:55 AM, Felix Kuehling wrote:
    <blockquote type="cite" cite="mid:b545b31e-26ff-4b7a-be86-312d9aa96e97@amd.com">On
      2025-10-17 04:42, Zhu Lingshan wrote:
      <br>
      <blockquote type="cite">This commit implemetns a new ioctl
        AMDKFD_IOC_CREATE_PROCESS
        <br>
        that creates a new secondary kfd_progress on the FD.
        <br>
        <br>
        To keep backward compatibility, userspace programs need to
        invoke
        <br>
        this ioctl explicitly on a FD to create a secondary
        <br>
        kfd_process which replacing its primary kfd_process.
        <br>
        <br>
        This commit bumps ioctl minor version.
        <br>
        <br>
        Signed-off-by: Zhu Lingshan<a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 41
        ++++++++++++++++++++++++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp; |&nbsp; 1 +
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c |&nbsp; 3 +-
        <br>
        &nbsp; include/uapi/linux/kfd_ioctl.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 8 +++--
        <br>
        &nbsp; 4 files changed, 49 insertions(+), 4 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        index 7c02e8473622..8fe58526bc3a 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        @@ -3140,6 +3140,44 @@ static int
        kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process
        *p, v
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; }
        <br>
        &nbsp; +/* userspace programs need to invoke this ioctl explicitly on
        a FD to
        <br>
        + * create a secondary kfd_process which replacing its primary
        kfd_process
        <br>
        + */
        <br>
        +static int kfd_ioctl_create_process(struct file *filep, struct
        kfd_process *p, void *data)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct kfd_process *process;
        <br>
        +&nbsp;&nbsp;&nbsp; int ret;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (!filep-&gt;private_data || !p)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (p != filep-&gt;private_data)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* Each FD owns only one kfd_process */
        <br>
        +&nbsp;&nbsp;&nbsp; if (p-&gt;context_id != KFD_CONTEXT_ID_PRIMARY)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; mutex_lock(&amp;kfd_processes_mutex);
        <br>
        +&nbsp;&nbsp;&nbsp; process = create_process(current, false);
        <br>
        +&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;kfd_processes_mutex);
        <br>
      </blockquote>
      <br>
      There could be race conditions between multiple threads calling
      this ioctl on the same primary fd concurrently. We could use the
      kfd_processes_mutex to protect against this. You'd need to do some
      of the above checks and the assignment to filep-&gt;private_data
      under the lock to be safe, to allow only one thread to
      successfully create the secondary context. I think this would
      work:
      <br>
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;/* Atomically create the secondary context and assign it to
      filep-&gt;private_data */
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;mutex_lock(&amp;kfd_processes_mutex);
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;if (p != filep-&gt;private_data) {
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Another thread already created a secondary context */
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;kfd_processes_mutex);
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;}
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;secondary = create_process(current, false);
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;if (!IS_ERR(process))
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; filep-&gt;private_data = secondary;
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;mutex_unlock(&amp;kfd_processes_mutex);
      <br>
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;if (IS_ERR(secondary))
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return PTR_ERR(secondary);
      <br>
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;/* Release the process reference that was held by
      filep-&gt;private_data */
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;kfd_unref_process(p);
      <br>
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;...&nbsp;<br>
      <br>
    </blockquote>
    <pre>will fix in V6, thanks!</pre>
    <blockquote type="cite" cite="mid:b545b31e-26ff-4b7a-be86-312d9aa96e97@amd.com">Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        +&nbsp;&nbsp;&nbsp; if (IS_ERR(process))
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return PTR_ERR(process);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* Each open() increases kref of the primary kfd_process,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * so we need to reduce it here before we create a new
        secondary process replacing it
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_unref_process(p);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; filep-&gt;private_data = process;
        <br>
        +&nbsp;&nbsp;&nbsp; ret = kfd_create_process_sysfs(process);
        <br>
        +&nbsp;&nbsp;&nbsp; if (ret)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_warn(&quot;Failed to create sysfs entry for the
        kfd_process&quot;);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags =
        _flags, \
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cmd_drv = 0, .name = #ioctl}
        <br>
        @@ -3258,6 +3296,9 @@ static const struct amdkfd_ioctl_desc
        amdkfd_ioctls[] = {
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IOCTL_DEF(AMDKFD_IOC_DBG_TRAP,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_ioctl_set_debug_trap, 0),
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; AMDKFD_IOCTL_DEF(AMDKFD_IOC_CREATE_PROCESS,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_ioctl_create_process, 0),
        <br>
        &nbsp; };
        <br>
        &nbsp; &nbsp; #define AMDKFD_CORE_IOCTL_COUNT&nbsp;&nbsp;&nbsp; ARRAY_SIZE(amdkfd_ioctls)
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        index 4237c859050d..578f9f217e16 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        @@ -1055,6 +1055,7 @@ struct amdkfd_ioctl_desc {
        <br>
        &nbsp; };
        <br>
        &nbsp; bool kfd_dev_is_large_bar(struct kfd_node *dev);
        <br>
        &nbsp; +struct kfd_process *create_process(const struct task_struct
        *thread, bool primary);
        <br>
        &nbsp; int kfd_process_create_wq(void);
        <br>
        &nbsp; void kfd_process_destroy_wq(void);
        <br>
        &nbsp; void kfd_cleanup_processes(void);
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        index 629a706e2a13..bbb72a77bed5 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        @@ -68,7 +68,6 @@ static struct workqueue_struct
        *kfd_restore_wq;
        <br>
        &nbsp; static struct kfd_process *find_process(const struct
        task_struct *thread,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ref);
        <br>
        &nbsp; static void kfd_process_ref_release(struct kref *ref);
        <br>
        -static struct kfd_process *create_process(const struct
        task_struct *thread, bool primary);
        <br>
        &nbsp; &nbsp; static void evict_process_worker(struct work_struct *work);
        <br>
        &nbsp; static void restore_process_worker(struct work_struct *work);
        <br>
        @@ -1578,7 +1577,7 @@ void
        kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
        <br>
        &nbsp;&nbsp; * On return the kfd_process is fully operational and will be
        freed when the
        <br>
        &nbsp;&nbsp; * mm is released
        <br>
        &nbsp;&nbsp; */
        <br>
        -static struct kfd_process *create_process(const struct
        task_struct *thread, bool primary)
        <br>
        +struct kfd_process *create_process(const struct task_struct
        *thread, bool primary)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *process;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mmu_notifier *mn;
        <br>
        diff --git a/include/uapi/linux/kfd_ioctl.h
        b/include/uapi/linux/kfd_ioctl.h
        <br>
        index 5d1727a6d040..84aa24c02715 100644
        <br>
        --- a/include/uapi/linux/kfd_ioctl.h
        <br>
        +++ b/include/uapi/linux/kfd_ioctl.h
        <br>
        @@ -44,9 +44,10 @@
        <br>
        &nbsp;&nbsp; * - 1.16 - Add contiguous VRAM allocation flag
        <br>
        &nbsp;&nbsp; * - 1.17 - Add SDMA queue creation with target SDMA engine ID
        <br>
        &nbsp;&nbsp; * - 1.18 - Rename pad in set_memory_policy_args to
        misc_process_flag
        <br>
        + * - 1.19 - Add a new ioctl to craete secondary kfd processes
        <br>
        &nbsp;&nbsp; */
        <br>
        &nbsp; #define KFD_IOCTL_MAJOR_VERSION 1
        <br>
        -#define KFD_IOCTL_MINOR_VERSION 18
        <br>
        +#define KFD_IOCTL_MINOR_VERSION 19
        <br>
        &nbsp; &nbsp; struct kfd_ioctl_get_version_args {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 major_version;&nbsp;&nbsp;&nbsp; /* from KFD */
        <br>
        @@ -1671,7 +1672,10 @@ struct kfd_ioctl_dbg_trap_args {
        <br>
        &nbsp; #define AMDKFD_IOC_DBG_TRAP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IOWR(0x26, struct kfd_ioctl_dbg_trap_args)
        <br>
        &nbsp; +#define AMDKFD_IOC_CREATE_PROCESS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IO(0x27)
        <br>
        +
        <br>
        &nbsp; #define AMDKFD_COMMAND_START&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x01
        <br>
        -#define AMDKFD_COMMAND_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x27
        <br>
        +#define AMDKFD_COMMAND_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x28
        <br>
        &nbsp; &nbsp; #endif
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------PDl7kgp0smo4faMb01L7l8NO--
