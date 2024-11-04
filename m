Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0F4D1BDFF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 21:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05B0910E4EB;
	Mon,  4 Nov 2024 21:49:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zo2s4XaA";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A667810E4EB
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 21:49:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbRp+YdcIdzuOusgsl+waw8ojNqndS1r/twkZT+D9YeTaZYS+Q7CJuvfziHYxA/+DeHNxyuK0eee+EsF7QVep0RJD8riE5pjX9sSDwR8drJtZvnOimqbtPxk0K6BiU6kGar95WE75bFy0I9D78DT5Gals+oDcY4MWBeQDYomBthDaOtXHWw/7bbP5olwK5h8CtI+ccutMY817udj0ueUHqmPM+4RqppwOSZDhNHeobGL+yT6Kq/0ASk6krosHBdRqfzAb6GQ13t5VuFC5YZotdoG8ml2w4B2YDvjnOy2iQFEj/nZI9Ltr6YleDxI9kT06PggXRVT1AgGFen8wNxPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwYtcs75XlkHdDFJXO9naXRIc36EyCZbzReVpdu5maM=;
 b=Nb8Q3i88KeDKfbFaEUVtowGna/sZSjmdoMrcD9v4q5qBjCY6+npGFkwG2CAmquj2EZ4XHRkdhqWAurErONJ7PIAZvvuHW42gDJpzgCLrG2Mqe+K4nmgOXpAYT/rTU0g6e6Q4Wn4boY1Etx6x/vXJ4Kj+575xyl3G7TKSgaxWWI6FOAbzlZXy9PcmlCDDVcLxLJ4J7xP92/ulNQehrcC9kzkYDPpJtIVdoTPmV2IfVZjZDGIRjrw0FfDquEES9el473FUIETuU6Br0qQkKMqBz1EIg58JKPUF4cctZfjU4rMfBVf1XySWyoTggnFM3IE1hW53kRmL++2+3NZPXRQFig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwYtcs75XlkHdDFJXO9naXRIc36EyCZbzReVpdu5maM=;
 b=zo2s4XaAqiPyf7kwChYyn+Gk1dg12pgGtXZdS1U6vo1/7X6bisuyLQvcVbf/pY+L8IWneZc7IEKAGAMRKwhRKGFJZ8XHUXRjA8Aup+80DdhLR3Ds1u4xzXM+DetfxnqXDluRv0HvVfJVlI/hOtnm8vDwgU3wQqxj57cyBwnMjBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Mon, 4 Nov
 2024 21:49:49 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8114.031; Mon, 4 Nov 2024
 21:49:49 +0000
Message-ID: <17d259aa-9d44-47a4-8087-5cb9c3fb9a17@amd.com>
Date: Mon, 4 Nov 2024 16:49:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: Explicitly specify data type amdkfd_process_info
 in related functions
To: Zhu Lingshan <lingshan.zhu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241015035150.1477582-1-lingshan.zhu@amd.com>
 <db85737d-9489-453f-85c2-dbd740a98904@amd.com>
 <a938652f-b641-4afa-88a5-47308ffccecf@amd.com>
 <7521be7c-d597-4e23-9bb3-385c0b7dc458@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <7521be7c-d597-4e23-9bb3-385c0b7dc458@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0401.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: f63355c5-1e52-4f82-dd3a-08dcfd1a9b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjcrZVZyS1lqUURCZlJHMzljKzVTUzVwc0hEQ0kxTG9IME5KWHhxbXVFN2VI?=
 =?utf-8?B?TURHc3E3OTNKSVNETFlaTmxSWUhXWnJhOEpjeDEvWXUxMFFDK2QyeStBekow?=
 =?utf-8?B?OFFWaGtjSEhQSTRodm8vWThDL0lMRXpCeEV3YXd6cDJqd0w2UStqTU5jQzNV?=
 =?utf-8?B?MDNaUFZYK2lYSzU5Mm1aeDRmQ3k0WkZwcWw2Z29OcnZLY1BUOVpnQ3pCTlFI?=
 =?utf-8?B?VkZTbG44dlZWUytjR0JyS2dFaWtoWkYybzE3VGp2bkZjOTl0WWNvek1vZ044?=
 =?utf-8?B?Z0p3RXRpZ09LYUFwMGMxZVRrcDI1NE51RGlkKy95eXNNb3o1NmVlOWt3eUlF?=
 =?utf-8?B?Y2RqYXY3NDN1SXJPNy9MNVh4Mjc4RW9pVG1FdWhweTc2U0RES0VlTCt1RW5i?=
 =?utf-8?B?Q3RWS2Vqem4vZGRvekNHUVJZellHOU85UjNkaVU3Ti80anNaQTIvQ0w1bkhr?=
 =?utf-8?B?dGFoRFdXaEtJVnRORlVqWjBLY2JPYXh3bjVybTNaREozNDhjRVVsVlo1VytH?=
 =?utf-8?B?TGtSRTdXVzV0UVg1elNxN3dvcDBLV3BmOEJQQVBvcTFFREt4eGpkMVl3Y3ow?=
 =?utf-8?B?OVc1ankxM093UDIrVWtLUjcwdk52UnMzTXdSZlJ2Y3ZqdmM3dWUycWIrK0dJ?=
 =?utf-8?B?emppVzRCVHpDTzBKUnBlWVZlSWN0aTdvUlVYL0Q2SFFzQXVoVVdoTHVSeTBR?=
 =?utf-8?B?UFhCSEVLeW9iLzAxOGZnVlNWaUt1ZWJXTFhjQVcrY3Rjc2hweEZ6aitSZ0Zh?=
 =?utf-8?B?Q0YzbVBrS2xNSUJIZXFUU2lXelZhU254dEh5TFJ6M3lnOG1pa05WT2FJclMz?=
 =?utf-8?B?VlcyZTArWk1vWXpIRXpZN0IwdGVXWjd3N2F0SW83RlVoaE9UWkI0RmVlRU1H?=
 =?utf-8?B?VDMxeHlKdm5nUEtkYlpuQXVvS29ObGRKK0phaTFGcjNMbzVubVhSWGxTUWgw?=
 =?utf-8?B?SUdZSSt2eDZ3SXpFQ0kxZFk5L0VWaW9hSjdDQUZ5SW1PYisyTzFqdFFQcm5q?=
 =?utf-8?B?d0R4d1pnTkV3U3FpYjdGam1kL2hRVi9sczQrTkhVT3BlaHRZd1dzWllwQTVt?=
 =?utf-8?B?Kzg3S0hNMWUwUitEWVZIaldwK2NubWxsclEzTjdlRVBvUGFERXlpYlJJVHpu?=
 =?utf-8?B?Z3MydGlVYVFnY0lOYWY4U0hJbVdpSFN0K05Ua2FGOFRFM21mNnBZL2ozT09q?=
 =?utf-8?B?MllzVHBVREhlZ0VBSElYL1c5QnNJY2IvUnZQUFRCWFZhdVNmQUN3RVhVWFZv?=
 =?utf-8?B?MVc2SkRmMGRzYmpURnFVdnozVHp1VTRWSytiaVZhMlNwSC91VC85M3lQYTdr?=
 =?utf-8?B?NmxaZUVYalRkSHV3TVpIOGZzTXNnRkZ2UFZVUndPT3BPVlhSUUYwZjlkYlRP?=
 =?utf-8?B?TkNyZmZjSURVTjZXMlZNYXVVMkNucUNOM3k3MmE3OXdXMlFlNzVRNHhPYzRi?=
 =?utf-8?B?dEljTGtBY1Z0STdqQlZ1eXdEektvaCtqMisrL3VPNm1OYjQ2ZVlQUzhzNXRL?=
 =?utf-8?B?VCtIc2Z6WXpoSnI5Z0loc1lNK2h5M3M1Ylc4Sk9BS2RCanV0UTkvM0NLcSsv?=
 =?utf-8?B?WkpsRTlpYlEwaXM3eDNZK0ZXZkZ0R09tV0c5ODZ3OWJFSE44WkZBTWNvbkEy?=
 =?utf-8?B?dzNpYjFycnFwZmg3MFo2ZDhISEJWVGRYcVhHaUpTMjU1VUlsWHhwM3dzb2FD?=
 =?utf-8?B?aHlKMFpWL2VlNnJVMjVneE5HNVFiaG9rVjExanl6MVlGVkxmeVFxckJPZkcy?=
 =?utf-8?Q?zRnI4BTeWT1u7IEIjauVYrfNNCC/ytaN/D9Rtdb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHdqNWNxTEJZbFdRdlhIUlhDUitiWC9KY0RubjZnb3BxTjRqN0VaS0NuOFJG?=
 =?utf-8?B?UGR4WE5vb0hrLzY2Ylo2K21uMEdkd1hvZ0xmeVhvUFFsWDc1aHZoVURRWElR?=
 =?utf-8?B?Tk44SkUvMXhyWmdiUWs3Zy9icUxYdEhCSTI1RlkxTTkwcnlrN2Q2VEFLNThJ?=
 =?utf-8?B?M1ZHTVBwL2c2Zy9YOFdRZmVyaGVqeFR0bERPUUVYQmdwWXlraGEzVU9oMmNa?=
 =?utf-8?B?Y28ycmlBcU1sN1VjUy9nVHNZSlRzbGpiUXcwMkxKc1RudUNaTDhNalN4eGtP?=
 =?utf-8?B?a0s3dTZOeW9GMEdxUDN0T0gyMXNtTjVrd3gxQlVlTU9NSVd2M1d5LzZFWWwy?=
 =?utf-8?B?NklHNE9RWlJ2RXY3U3hvZmdYdUZmWUlJM2RqUEsxbHNTNGtxWENlVnpzME5D?=
 =?utf-8?B?RHRxL0U2OXpvUlhob055MEY4TnNGaDh5S0RFTTdsNVhHOVZyeVY5amNzdUFo?=
 =?utf-8?B?YThENlRjUlgrY0szbmk4aTZITU4wQkVlMVFTOElqMkZCdGpKMWJNWlNRRFNk?=
 =?utf-8?B?bkdFdUdhVld4SENUeWxzbXA0ZmtVZ0ZTK2F2b28xQnFXb2Z4S0FTbEExenNO?=
 =?utf-8?B?ckx0Sko1bmVCREhSM3czaXBzNXRjeDh5TjM4RGt0UkdmQ0hYck5ETjJiNmRk?=
 =?utf-8?B?dVF6bytUckhib2h3bm96ZEYwMDZSaFBpMnhxZGtTSGltalFUeVYzSEUxWk1Z?=
 =?utf-8?B?d2Noa3F6aTVzSHFZMTByNTR2cUVKUXJUZTJJK1NXOUdFKzFPSzROLytYYlNY?=
 =?utf-8?B?QXBjMHc1dXYrcmVNVFRQMEM4WUhzQ25wdEFhb1F2SEJwbEZmalpZQVA2QU14?=
 =?utf-8?B?QU5xbUxicWJJenhHK28yWFdsYXF4Vm5ieFdjeXZsbzFrZWtiRE5WaVJycUVa?=
 =?utf-8?B?QmlNRGtHTGZMaHp2UnNkVmptWGEzV3V1Vk44cEhVdll2aGp4aFJFZVJzcksr?=
 =?utf-8?B?dmJ0clNZQlJrWFpPcnhWWGtHRGhLaTlMdWozL3FOZ1MyK1pIRXpzajFyQU9N?=
 =?utf-8?B?Y3hGeFBLMUdpTlRmSVE3SVlaZnhjdVVmVUoyUUhLeTdLMmRUMDVycFpiY1Z5?=
 =?utf-8?B?Yi9xN0FHL1VZNE1hZ3R1SGNCbDZaanNWdG82RGVUUmRIbHdyTE5mUkJtYnpR?=
 =?utf-8?B?TnAvMWNmSTloQnVnaTBaN2hFa3h2dmYwN2lodkEyamluZjhJN2NnbGRyQkV1?=
 =?utf-8?B?K0t5dzUwNWdVaDIweFRTUFVKSFdmWWszdnlKRCsyTzkrMHpYdStEMVJlMlhU?=
 =?utf-8?B?NlhFeDlpbzJzSFNvdzcxeVI4bHRFRXFCSGhlVGtjNmxxSmJPYndrT2lvdzJ2?=
 =?utf-8?B?TURUYmhkUDE5YUdVSTFNSWJSbWVoZ1ZTUXhvL2Q2cnJXMnQ1UXRzNy9iVmFq?=
 =?utf-8?B?OC9Md2xIUTBuc09Ua0g2M2hyUFl4bFRBNld5QUFqNU92Vm5IK0RMVWRhdTlY?=
 =?utf-8?B?NFBzd05LMno0RVMvMVh1dG1lUUE4b1RKNTNXalB5TERTTjJRd2VPM1pJMHlq?=
 =?utf-8?B?WnhuQVJXRWsrN2dNVTk3R3ZSYm9UWmxybVg1OGg4c0ZDeEpYbHJjSTgzai9k?=
 =?utf-8?B?MGZDdkJSMDFDd0FGSVp2SjZJY3hYNVZZbWJvT2FwMWlzQkYxZThQYUNETzRa?=
 =?utf-8?B?ZElDTW0xcTlIU1dqRjlFcklHN0Z4Yy9wZW9YTXEvRUtNVVpHQ254REd1eWdw?=
 =?utf-8?B?WDhDNXN2ZmY3RVJYVE1wRFVCbjNMUGRUc3I2M0lqSVQyOGI2UlZ3cGxrd0Iw?=
 =?utf-8?B?L21SSmlhQmdabUxCUFE2eGZoNUR0MTdtRmFHZmFKMGk5QTcxUVkwcnBIV2xq?=
 =?utf-8?B?ZWE5clpvSkJxaXlwTVB1dmVGMEhGdGtDaUg2VmpNUXVWd2tvd21LUW4zcjBO?=
 =?utf-8?B?QjBhK29aNmxGczdmSDJDKzVjcEhoU3pLNmV1R096SmJ3dG80U0ViQ2NiVm82?=
 =?utf-8?B?b0FJMlpQMXU4OWlTMXZaNitGeUJ1c1pjK2svMEtzdG9Zd0ZyeTl2WEU2Yk05?=
 =?utf-8?B?K1NFRnhyc0ZQL3NmOEV4ZTEyR3pOZFhoUlczVCt1TVRGcUdxbEdqMnJjdEs1?=
 =?utf-8?B?UWJNU0xyS1ZCWUtsaVBWMTZqSmdhRmR1MzkvVmdiZDhxN1hhODVKZ1pTSGxa?=
 =?utf-8?Q?yDsziPyxyXewYRzgoUWQ9dgB1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63355c5-1e52-4f82-dd3a-08dcfd1a9b28
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 21:49:49.7549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tz80nC1VUBsXFVocuTz5EN2qHkspsfjnYyKEkBxYn9G7+kaLv0wjJwgo0tb144yKfDp8jG6hTAXVLC/0VSzkWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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


On 2024-10-31 23:20, Zhu Lingshan wrote:
> On 10/22/2024 4:01 PM, Zhu Lingshan wrote:
>>
>> On 10/22/2024 12:20 PM, Felix Kuehling wrote:
>>> On 2024-10-14 23:51, Zhu Lingshan wrote:
>>>> This commit specifies data type struct amdkfd_process_info
>>>> rather than general void* in ralted functions.
>>> Several interfaces in amdgpu_amdkfd.h use void * as opaque pointers, e.g. process_info, mem_obj, drm_priv. The reasons are partly historical because KFD used to be in its own kernel module. That said, there is nothing fundamentally wrong with opaque pointers when the upper layers doesn't need to see the contents in the objects returned by the lower layer.
>> void * is workable but imperfect, IMHO it representing a compromise that could ideally be improve especially when we know exactly the data structure type.
>> This change provides better readability, type safety, compiling checking, and avoid the castings
> shall I make any improvements on this patch?
>>> It makes me wonder, though, why you're singling out just process_info? Are you proposing to change more interfaces to eliminate opaque pointers?
>> That is because I just happen to read process_info related code, I can surely improve others if any individuals of them also represents a certain data type.
> do you want me to change all void * opaque pointer in a series or just this one for now?

I'd prefer to keep it consistent. If we decide we don't want opqaue pointers in our API, we should clean up all the APIs in that header file. Or we decide, opqaue pointers are OK, and we leave things the way they are. I'm OK with either of those two options. I want to avoid a piece-meal solution that leaves things inconsistent.

Regards,
  Felix

> 
> Thanks
> Lingshan
>>
>> Thanks
>> Lingshan
>>> Regards,
>>>   Felix
>>>
>>>> kfd_process->kgd_process_info is initialized
>>>> in init_kfd_vm() by such code:
>>>>
>>>> static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>>>>                        struct dma_fence **ef) {
>>>>         struct amdkfd_process_info *info = NULL;
>>>>
>>>>         if (!*process_info) {
>>>>                 info = kzalloc(sizeof(*info), GFP_KERNEL);
>>>>
>>>>         *process_info = info;
>>>> }
>>>>
>>>> That means kfd_process->kgd_process_info is type
>>>> struct amdkfd_process_info, therefore we should avoid using void*
>>>>
>>>> Using a specified data type other than void* can help improve
>>>> readability. There are other benifits like: type safety,
>>>> avoid casting and better compling chekings.
>>>>
>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 10 +++---
>>>>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 31 ++++++++-----------
>>>>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>>>>  3 files changed, 19 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> index f9d119448442..c1346b8c9ab7 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> @@ -239,8 +239,8 @@ void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
>>>>  int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
>>>>  				void **mem_obj);
>>>>  void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj);
>>>> -int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem);
>>>> -int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem);
>>>> +int amdgpu_amdkfd_add_gws_to_process(struct amdkfd_process_info *pinfo, void *gws, struct kgd_mem **mem);
>>>> +int amdgpu_amdkfd_remove_gws_from_process(struct amdkfd_process_info *pinfo, void *mem);
>>>>  uint32_t amdgpu_amdkfd_get_fw_version(struct amdgpu_device *adev,
>>>>  				      enum kgd_engine_type type);
>>>>  void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
>>>> @@ -299,7 +299,7 @@ int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
>>>>  				     struct amdgpu_vm *avm, u32 pasid);
>>>>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>>>>  					struct amdgpu_vm *avm,
>>>> -					void **process_info,
>>>> +					struct amdkfd_process_info **process_info,
>>>>  					struct dma_fence **ef);
>>>>  void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
>>>>  					void *drm_priv);
>>>> @@ -348,8 +348,8 @@ void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struct amdgpu_device *ad
>>>>  
>>>>  bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);
>>>>  bool amdgpu_amdkfd_bo_mapped_to_dev(void *drm_priv, struct kgd_mem *mem);
>>>> -void amdgpu_amdkfd_block_mmu_notifications(void *p);
>>>> -int amdgpu_amdkfd_criu_resume(void *p);
>>>> +void amdgpu_amdkfd_block_mmu_notifications(struct amdkfd_process_info *pinfo);
>>>> +int amdgpu_amdkfd_criu_resume(struct amdkfd_process_info *pinfo);
>>>>  int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>>>  		uint64_t size, u32 alloc_flag, int8_t xcp_id);
>>>>  void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> index ce5ca304dba9..2a1ee17e44a1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> @@ -1376,7 +1376,7 @@ static int process_update_pds(struct amdkfd_process_info *process_info,
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>>>> +static int init_kfd_vm(struct amdgpu_vm *vm, struct amdkfd_process_info **process_info,
>>>>  		       struct dma_fence **ef)
>>>>  {
>>>>  	struct amdkfd_process_info *info = NULL;
>>>> @@ -1552,7 +1552,7 @@ int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
>>>>  
>>>>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>>>>  					   struct amdgpu_vm *avm,
>>>> -					   void **process_info,
>>>> +					   struct amdkfd_process_info **process_info,
>>>>  					   struct dma_fence **ef)
>>>>  {
>>>>  	int ret;
>>>> @@ -1639,19 +1639,16 @@ uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv)
>>>>  	return avm->pd_phys_addr;
>>>>  }
>>>>  
>>>> -void amdgpu_amdkfd_block_mmu_notifications(void *p)
>>>> +void amdgpu_amdkfd_block_mmu_notifications(struct amdkfd_process_info *pinfo)
>>>>  {
>>>> -	struct amdkfd_process_info *pinfo = (struct amdkfd_process_info *)p;
>>>> -
>>>>  	mutex_lock(&pinfo->lock);
>>>>  	WRITE_ONCE(pinfo->block_mmu_notifications, true);
>>>>  	mutex_unlock(&pinfo->lock);
>>>>  }
>>>>  
>>>> -int amdgpu_amdkfd_criu_resume(void *p)
>>>> +int amdgpu_amdkfd_criu_resume(struct amdkfd_process_info *pinfo)
>>>>  {
>>>>  	int ret = 0;
>>>> -	struct amdkfd_process_info *pinfo = (struct amdkfd_process_info *)p;
>>>>  
>>>>  	mutex_lock(&pinfo->lock);
>>>>  	pr_debug("scheduling work\n");
>>>> @@ -3093,13 +3090,12 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>>>>  	return ret;
>>>>  }
>>>>  
>>>> -int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem)
>>>> +int amdgpu_amdkfd_add_gws_to_process(struct amdkfd_process_info *pinfo, void *gws, struct kgd_mem **mem)
>>>>  {
>>>> -	struct amdkfd_process_info *process_info = (struct amdkfd_process_info *)info;
>>>>  	struct amdgpu_bo *gws_bo = (struct amdgpu_bo *)gws;
>>>>  	int ret;
>>>>  
>>>> -	if (!info || !gws)
>>>> +	if (!pinfo || !gws)
>>>>  		return -EINVAL;
>>>>  
>>>>  	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
>>>> @@ -3110,8 +3106,8 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>>>>  	INIT_LIST_HEAD(&(*mem)->attachments);
>>>>  	(*mem)->bo = amdgpu_bo_ref(gws_bo);
>>>>  	(*mem)->domain = AMDGPU_GEM_DOMAIN_GWS;
>>>> -	(*mem)->process_info = process_info;
>>>> -	add_kgd_mem_to_kfd_bo_list(*mem, process_info, false);
>>>> +	(*mem)->process_info = pinfo;
>>>> +	add_kgd_mem_to_kfd_bo_list(*mem, pinfo, false);
>>>>  	amdgpu_sync_create(&(*mem)->sync);
>>>>  
>>>>  
>>>> @@ -3136,7 +3132,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>>>>  	if (ret)
>>>>  		goto reserve_shared_fail;
>>>>  	dma_resv_add_fence(gws_bo->tbo.base.resv,
>>>> -			   &process_info->eviction_fence->base,
>>>> +			   &pinfo->eviction_fence->base,
>>>>  			   DMA_RESV_USAGE_BOOKKEEP);
>>>>  	amdgpu_bo_unreserve(gws_bo);
>>>>  	mutex_unlock(&(*mem)->process_info->lock);
>>>> @@ -3149,7 +3145,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>>>>  bo_reservation_failure:
>>>>  	mutex_unlock(&(*mem)->process_info->lock);
>>>>  	amdgpu_sync_free(&(*mem)->sync);
>>>> -	remove_kgd_mem_from_kfd_bo_list(*mem, process_info);
>>>> +	remove_kgd_mem_from_kfd_bo_list(*mem, pinfo);
>>>>  	amdgpu_bo_unref(&gws_bo);
>>>>  	mutex_destroy(&(*mem)->lock);
>>>>  	kfree(*mem);
>>>> @@ -3157,17 +3153,16 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>>>>  	return ret;
>>>>  }
>>>>  
>>>> -int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
>>>> +int amdgpu_amdkfd_remove_gws_from_process(struct amdkfd_process_info *pinfo, void *mem)
>>>>  {
>>>>  	int ret;
>>>> -	struct amdkfd_process_info *process_info = (struct amdkfd_process_info *)info;
>>>>  	struct kgd_mem *kgd_mem = (struct kgd_mem *)mem;
>>>>  	struct amdgpu_bo *gws_bo = kgd_mem->bo;
>>>>  
>>>>  	/* Remove BO from process's validate list so restore worker won't touch
>>>>  	 * it anymore
>>>>  	 */
>>>> -	remove_kgd_mem_from_kfd_bo_list(kgd_mem, process_info);
>>>> +	remove_kgd_mem_from_kfd_bo_list(kgd_mem, pinfo);
>>>>  
>>>>  	ret = amdgpu_bo_reserve(gws_bo, false);
>>>>  	if (unlikely(ret)) {
>>>> @@ -3176,7 +3171,7 @@ int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
>>>>  		return ret;
>>>>  	}
>>>>  	amdgpu_amdkfd_remove_eviction_fence(gws_bo,
>>>> -			process_info->eviction_fence);
>>>> +			pinfo->eviction_fence);
>>>>  	amdgpu_bo_unreserve(gws_bo);
>>>>  	amdgpu_sync_free(&kgd_mem->sync);
>>>>  	amdgpu_bo_unref(&gws_bo);
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> index d6530febabad..b0426a1235b8 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> @@ -934,7 +934,7 @@ struct kfd_process {
>>>>  	bool signal_event_limit_reached;
>>>>  
>>>>  	/* Information used for memory eviction */
>>>> -	void *kgd_process_info;
>>>> +	struct amdkfd_process_info *kgd_process_info;>  	/* Eviction fence that is attached to all the BOs of this process. The
>>>>  	 * fence will be triggered during eviction and new one will be created
>>>>  	 * during restore
> 
