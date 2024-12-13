Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25484E7717F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 20:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAEE610E0BE;
	Fri, 13 Dec 2024 20:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cMMqM+qL";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9668710E0BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 20:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcNBg+XOFy3cIlhqTv8mcrOY8u+0AvnmbvR1qpEu8PFW5AKdVS+lwdqkJzlkNwK8TDUhQ1as0z0U7RSjHPqOaySO9UmA3DRg90WRJXs6OIfyta13VisDENbfaZe4jskp9Y7QO9y7xL3/PoF8CCsFMrbgZU7x4DbP8cMALIlTvbcEHq1JUTwR+odwKwkVEfcZlZxIzx3qo7aCIMDg01kdnmxI1oMTWX4bVAyZ+D3QhKQjSJOgctCOVT8ZuMlxxnmXPhaUQWq+7djlll2mN9JKm795VbuUewWFZF/2L3UZLMxA/XjO6FHW7r+L3lBDfmVeRxta5Cu50Fn44y7gy/7BXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oP1xV1gEytUNk62SPP8rHjmOyfB218S6y6cxwcn+8CI=;
 b=lj7tALz/xfPcICwJL1cHzPr6f8gYLGESFou9hYGkk321TZmZSSroskqzGX3dzhxkqjJMvt8FOOKB7G+NHcQjqQ7wAGFVISMAT3L7NzcB8DLFFCEuSVynENNKsGubqSxcIcl7y2dvWNgsx3gFOy14F5xwlnQricVOeUUQQ9QuQV4kjqDvvUO97cUqjXxWJWpxvM+lUSM9GCdaBXaJUA5n14vI6wsH+tf/tIbw9FCxOmqj9EXu7DIyM7MBu1bT0yguVYG0m6LvWKwGsRM+4Zqz8pNZhOKPKfcCv9UoIJ9gnLDSRUj9FQt8HJjChQiBl8IsWG/g9ujIf/9IY5LGjcBKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP1xV1gEytUNk62SPP8rHjmOyfB218S6y6cxwcn+8CI=;
 b=cMMqM+qLBmhCYKSa5wBngR/cCKx7Y2WuJUXnrlH2T1nYRrzf1nQntpiEumr77hmJOCkHtGgFm1x2pMjVFwN3d7PJ5Bz6OeICqMGweRFOkXp/T/YtFk1AmYGlA5U7tBt1TRBkppcOus42STLq+qlav5HwDqvjazjEhP9ojj/Wjik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 20:22:21 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 20:22:21 +0000
Message-ID: <f6dea92e-79ac-4d1c-998e-7696ce01378f@amd.com>
Date: Fri, 13 Dec 2024 15:22:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] amdkfd: always include uapi header in priv.h
To: Zhu Lingshan <lingshan.zhu@amd.com>, "Lazar, Lijo" <lijo.lazar@amd.com>,
 alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241031104701.248234-1-lingshan.zhu@amd.com>
 <19443a63-e82b-444b-9f28-ff0b66929393@amd.com>
 <5072b301-2e9e-48c5-8404-cdea976c3182@amd.com>
 <e5bfe061-bd1e-4ce1-8c5d-a0de372ed75c@amd.com>
 <d3771cb9-124c-409b-afc5-1e6db3714504@amd.com>
 <ecdece2e-3a6a-41ee-8384-7b37a600e114@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <ecdece2e-3a6a-41ee-8384-7b37a600e114@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0047.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 044a72d7-f2dd-402c-8876-08dd1bb3d922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWV5YjY5SWE3YlFwU2JqTmhpbWZTMVpRbklqQThtMEgrVTdOZDk3RW9pT1JG?=
 =?utf-8?B?NHRUT2J1aVcwdTZCQVVpeEw0YUZtMjNqdXIwUmo2bDJ2Y1VGejJMRmdydHQ2?=
 =?utf-8?B?RHozZzRTWitOZ282UFFjbHBlNzBkVXd6WHRLM1cvVEFUcWx2Q2trbGM1aHlV?=
 =?utf-8?B?cktEaFkvVmFXRW5qcGhLY0g4REdhK2ZsRktLYmc1a1RCdE9DTW50QmFXREFH?=
 =?utf-8?B?bXlMMXhiVW15QkE2RldSMXcxTWZIa25LcktZWWtnNGR3OFU5bjBxMHpQclNs?=
 =?utf-8?B?eWx2N2hjUFZ2T2d3L2dxbkxEZXZhVmhuZk9rK092aUFMc0lrOEJxdkVlc1hC?=
 =?utf-8?B?d21Xa285SWJkcFMzWFdYUnh1MzBZdktzTGJ5WTd2dTcvSlZmVHo0bFEzNG5W?=
 =?utf-8?B?T3VFcTlVbHRhOThCWmtXNXNRbWI4THBacitIc2Z3RFM0S2xrMUN4dW9jbndF?=
 =?utf-8?B?TGZ4b0pCek8zc3Q0a2d3MGFlMGhMTFV3WE41SE9EL1NtdFlZdWt4WmVmWTJi?=
 =?utf-8?B?a3JTRmlOd1JmZklSS2hEakxyM09FN2t3R2VDelUvTXMyaC9BVUhJbC9yTE1X?=
 =?utf-8?B?Zko4LzlRN09KZFZsbmRuTlIxMi9lMnFEZytrYVYvNEJKZTVjNzIvMW9RMTVC?=
 =?utf-8?B?WnJPYkt2cWlFU1BDelFLVGdTY3A4aDhhNSs1Z0phQ2NTdHJZb2VNdnQwU051?=
 =?utf-8?B?U0RTQ1NTQ2FQbmI0b2RtWDhrOEtJazBRV0NQai9Ib0FYamVKYW8xZ0M3c28v?=
 =?utf-8?B?UW1vZUVEMGpCb2ljeXBRTTlCVm5rRERIT1BBYWNWQVc4NzlhZmFvY3Jnb09M?=
 =?utf-8?B?TERPL1lkbFZhQ3plT3l0OG9RUytyalFhdVJwSmIrb3hNMVFyYXJTV1oycjhL?=
 =?utf-8?B?K3RMUmZ3YnFBbERxVDFtVDZqVXMyK1JBOXIyMUVtUTU4VG1ZelVuaHAvdHkz?=
 =?utf-8?B?S2RSbFdQSDFqcVlEZDlDYlBEM0FCSzBWOEVxTmtUUXZJckRlaEVyMk1lOEFk?=
 =?utf-8?B?VEI5N3N0dUp5WmxlUGZTYkhubXZib09kRllNZk9QZVlBVy9LZVJCelJJU1VE?=
 =?utf-8?B?WUcxM2h4aU5rQW5jSXlGaHJuSnFxYWY3NXlaUWYzd2xQYTRnWWdHaHRPekpV?=
 =?utf-8?B?d1NLVmFoR0MvTEtCZElWQWNFMkUyRlJweHIybU45N3NuYWFnd2FZK0s3UjBK?=
 =?utf-8?B?NHJ4R1FyUWhOdFV0SnBMbU5Dbzc0bHU2RzRsTVBVV1JTVXJjYmZCOUxvdVF1?=
 =?utf-8?B?V2UwY2tEY21XOGVuV2xhcHNmbU8ycXZpT1IvSGoyMDR3UXFWTWZ0N3hoRjE3?=
 =?utf-8?B?TkN1SG13b1VmWThEbm9ZNXNxODRoZUF1WlI3K3FwNkFRRzdBQWRTRjlOSE5S?=
 =?utf-8?B?NXdxZ3FBYlFkRERiSm94bXIzbXR3TzI1UFhQcUo2MUtRd0FneVBTTlZnaUcw?=
 =?utf-8?B?c3BSMjlmdlV4TWhUczkxMHA0YnNhMm5YY1dVTmVqcVMxRkN2aDEyUy85bUFO?=
 =?utf-8?B?QjVLSU0vVzBwMTkwVkZSSkJDRmNWYWd0QWE0dTdWOUZXRmRod2I2ODdWOHRi?=
 =?utf-8?B?Y2xNV1p1TnR5Q2dnamJYY2J4d0xnajJhS0oxMEVxTU5BU0xEWUwvTzdFLytO?=
 =?utf-8?B?MTZ2bTV2VVpSakRwTi82bmlZbGUwOUJ5RTNENUpOR3NyN0p1ZkkzVnVBK01a?=
 =?utf-8?B?Ykd5Y2kyQjdhSE9Gdzc2WmVPaGVTbG9HWkV3SWlLMU9TUzgwUW9LbVI1R0xm?=
 =?utf-8?B?RHlzMm82WDBWNVpwYk14eUh6MjdRMFg0ZkJpZGhTeUNaV1BKaEhRNHdvQ3pa?=
 =?utf-8?B?UW92dHRVei9mek5oWmE3c2ZIYmxkMzBNTG9pVzdGcDVod05VSVNWUGJtOVdY?=
 =?utf-8?Q?AI5YT0Z7kcd9Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFJlUVpsUzNoZzAzYmtJSURGa1c2VjBxNjREMVh3M2xNUUZsUk1iNWdXYVEv?=
 =?utf-8?B?MkRKdEpvQ3EzS3NPMFlUcUQ4bkl6OEFFcHVaUnQ4bGlJUWs0U2lTcGlBR0Z6?=
 =?utf-8?B?MmlJbE5URVlURWVaY2ZOODU0U1VEOHM3SjI1WVltK3ltT215K3RUMUlEN2JX?=
 =?utf-8?B?U1RKR2dmTnlzeHpUS0kzQzN3cWVPR0tkbVgwSVlvczJ4OWxsKzNmdjhGM1Aw?=
 =?utf-8?B?U09LU0VGOTl2R3dxK3VLQnBPcTFLSXFyNVhQak5rQUd3Si9YcEtybFRPMFB1?=
 =?utf-8?B?MUd5MDBUV2xmZDY1amZLa2FNdTlUMko2bTRRV1RNeWd2bWprZ2dvbFRKQmg3?=
 =?utf-8?B?dndiMWM3emR1OXd6RWg5cEFIVUtkdjI5QU5WUGkzSG1GL0lvR2luSFQyWGVT?=
 =?utf-8?B?S3hDVXJmT08yeFZJdUREbTlHc3Ezc0xMNlNGWG1pamRDd3d2dENHQlJaWDgz?=
 =?utf-8?B?NVpOOUg3M2Q3cFROVlUyR0Z4b1U3dVBWaGtPSnVpUEcycm9iK1B5VmQ0U2pk?=
 =?utf-8?B?T0lucXRtc29KU1h2d1hTd3VINHpBcEw1KzkwUHRDSkRtaEthTjFOekdkcEdJ?=
 =?utf-8?B?QnJHSGNMWHFFeXA1dEY2bWNoTVFYWjNuZTRHNHJyZ3hlVUpXdlVtYWRhV3JS?=
 =?utf-8?B?SlhSZXg2dElYbmplSlpYb0s5RDM2MlNjZmFaQTJiOG9qUGJsNzRiRm1ja2RM?=
 =?utf-8?B?aTRWR3BhdzhRRHdjVTlxNEdkcC8xTVBjdkhNQXpjT2tJdzB4M0JSZGRQbml5?=
 =?utf-8?B?dVc3Z1QzVWlJTFVWZDNUQU9mOERqaW9GeFFJbFgzeW02cis3TlVLckxwMkYv?=
 =?utf-8?B?dE9HMmdDVmd0UnVVYVF4ZjVwWXJJNHZOWWRFbG9tb1dDbXlKZmFCSkk2ZGg0?=
 =?utf-8?B?SUtQTnZvNXBKdGdhZG1vWUNBUTV6N3pkNG1yNUQ5ZytpV2dMcytMTVlKeWtI?=
 =?utf-8?B?NFRFMndTQ2MvM3kvOEdZTmllRSsrUUlhQjZIOUFZZ0djNCtldEUwdWhlWTZ2?=
 =?utf-8?B?UnFFR0VUQ0U4d2RVa0RuejU1UG9FcHZFZmlmMEh3RW1ndFZNeHlmRVBmdktO?=
 =?utf-8?B?VlV6YW9uVk44bSs1YUhZK0FScnJmTGRNYWhISTBCcEtoZ2t5UGhDdFZzekYz?=
 =?utf-8?B?MDVncXQreG5aRkdUQ2VZc24xQWJlTHZ3QVU0NlBGVldoV2tZc1lNNjY2UmVB?=
 =?utf-8?B?aFNRVHpZNk1LSjA4QkhhY2Vabmx1QkxGT1YybXZqbStBblNsTjd1b1lYcnpO?=
 =?utf-8?B?bG5mbjNkOXlOWVF0ZGlpN3o3eWxkMENmNlIzdks1TkRFVjF3QTUrVjZVRlhu?=
 =?utf-8?B?bUtkcWVzRUk5eUVocnluUThYdXZoLzRyL0U2MnkyL0VKU3NrQ0N4ZkQ0UzAw?=
 =?utf-8?B?UzFpNTRCcWxDUUpMdHdVQ3RRWmh4RGo5bzhWZmtCWmF4Uk96RWp5eUhSN2FS?=
 =?utf-8?B?andTRzRHaythQmxZRVhBb0E5cGp0bG80SDJQUUVYOEpWeSt0VUdSa3ZMUkNJ?=
 =?utf-8?B?REs5eHNrdU45UVd5Z2JTZURlWThxb01WWURQTDN3R21OYzc2WER4alNwNVFj?=
 =?utf-8?B?SitCV09KZUpzRFlNNjI1S3lsaTJwRnJ2Yi83ZTZGKzc4bExmamZxRmhCRG9q?=
 =?utf-8?B?TVJUSWVRcE9HZWFZaUNaVkJqajJYSG0xR3FoTWxMamtzL1BVZkxONUd4TE4r?=
 =?utf-8?B?TzdwcVc3NkZ0a3VMV2t0WUpIVnlpb1VuZUErcmJ5UHhKSTI4QzhGUGlIZkJq?=
 =?utf-8?B?U0I2RW1BbXhmTk1MRi9WTjdTMmtPVXFEOEVYVTZUREFNTnNBN2FpMEV1TGVR?=
 =?utf-8?B?N1hJOElnU2o0WDZzcUd4anNaNHhLbEJWQ0RickhRZ0JucVh0cTRJS0lHdVE0?=
 =?utf-8?B?ZmhYa2xvNXlZV1Fsc0N2b0prend3cWxkN3Q4MWlPVUV4VTh6WEV3U0VhRExu?=
 =?utf-8?B?TUt4YzBsTTY1UW9ZeFRyK3IvUmVnS2szcDhHV3BjWXMwUHZ4eTF4ZUxhRVhq?=
 =?utf-8?B?cUhyTnBweHhwQWZJZUg3Y2N6dTE5M2p1VW8xMWl1VkZZVVFpU0w5UkpNMVdk?=
 =?utf-8?B?eTlXaHlkQW5wQk1WZ0kyVXlna0pod3VNMnFTcWpGRWcySGdtRWRPMjQxRGZV?=
 =?utf-8?Q?ZDn5IUcP3s0f9SiU/NPmpangS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044a72d7-f2dd-402c-8876-08dd1bb3d922
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 20:22:21.5218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mznvgu/M+BR2sjKKAM5fm59nUreR4GuZW69m3q9mwCbcbb0WqEM0yAhsGv12luyoJPQGVJjjPR9e6WMDPnq+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459
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

On 2024-12-13 04:03, Zhu Lingshan wrote:
> On 11/5/2024 6:35 PM, Lazar, Lijo wrote:
>> On 11/5/2024 2:13 AM, Felix Kuehling wrote:
>>> On 2024-10-31 22:15, Zhu Lingshan wrote:
>>>> On 10/31/2024 11:27 PM, Felix Kuehling wrote:
>>>>> On 2024-10-31 6:47, Zhu Lingshan wrote:
>>>>>> The header usr/linux/kfd_ioctl.h is a duplicate of uapi/linux/kfd_ioctl.h.
>>>>> I don't see usr/linux/kfd_ioctl.h. Which branch are you looking at?
>>>> The mainline master branch:
>>>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdkfd/kfd_priv.h#L35
>>>> #include <linux/kfd_ioctl.h>
>>>>>> And it is actually not a file in the source code tree.
>>>>> If it's a file that only there on your local working tree, maybe just clean up your working tree.
>>>> Yes, this is a file on the local working tree, it is generated when build, it is  not in source code tree.
>>>> The is even no folder usr/include/linux before building.
>>>>
>>>> For a quick verify:
>>>> 1) it is not a source code file from mainline:
>>>> $git blame ./usr/include/linux/kfd_ioctl.h
>>>> fatal: no such path 'usr/include/linux/kfd_ioctl.h' in HEAD
>>>>
>>>> 2) it is generated when build:
>>>> remove usr/include/linux/kfd_ioctl.h, then build.
>>>> If we remove a required header, kfd would not
>>>> build and there will be error messages.
>>>>
>>>> but here we will see these lines:
>>>> HDRINST usr/include/linux/kfd_ioctl.h
>>>> HDRTEST usr/include/linux/kfd_ioctl.h,
>>>> no build errors, and usr/include/linux/kfd_ioctl.h is
>>>> generated by duplicating the uapi one.
>>>>
>>>>
>>>> 2) linux/kfd_ioctl.h is usr/include/linux/kfd_ioctl.h
>>>> add random characters in usr/include/linux/kfd_ioctl.h, then build
>>>> we will see errors like this:
>>>>
>>>> In file included from <command-line>:
>>>> ./usr/include/linux/kfd_ioctl.h:65:9: error: expected ‘;’ before ‘struct’
>>>>     65 | abcd1234
>>>>        |         ^
>>>>        |         ;
>>>>     66 |
>>>>     67 | struct kfd_ioctl_create_queue_args {
>>>>        | ~~~~~~
>>>>>> Ideally, the usr version should be updated whenever the source code is recompiled.
>>>>> If the usr version is not in the git repository, it doesn't need to be updated. I don't know where this is coming from on your local tree.
>>>> the usr one would be installed to the system when run make install or install_headers,
>>>> it is for user space, we should include the uapi one instead of usr one in our source code files
>>> I did not see the folder in my tree because I build with O=... so usr/include/linux/kfd_ioctl.h shows up in my build output tree.
>>>
>>> The extra copy of the user mode headers seems to be an artifact of the Linux kernel build system. The fact that the build picks up user mode headers from <OUT>/usr/include/... seems intentional. If your tree has an outdated version of kfd_ioctl.h there, it's probably something broken with your build tree. Maybe broken file timestamps. It should be easy to fix with a "make mrproper" to force it to update all the build artifacts.
>>>
>>> I still don't think we need to change the code to fix a problem specific to your build system.
>>>
>> Looking at the number of occurrences with "#include <uapi/", it appears
>> like explicitly mentioning as uapi/linux for header location is a better
>> practice.
> Gentle ping, Felix

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>
> Thanks
> Lingshan
>> Thanks,
>> Lijo
>>
>>> Regards,
>>>    Felix
>>>
>>>> Thanks
>>>> Lingshan
>>>>> Regards,
>>>>>    Felix
>>>>>
>>>>>> However, I have noticed a discrepancy between the two headers
>>>>>> even after rebuilding the kernel.
>>>>>>
>>>>>> This commit modifies kfd_priv.h to always include the header from uapi to ensure
>>>>>> the latest changes are reflected. We should always include the source
>>>>>> code header other than the duplication.
>>>>>>
>>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>> index 26e48fdc8728..78de7ac09e8a 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>> @@ -32,7 +32,7 @@
>>>>>>   #include <linux/atomic.h>
>>>>>>   #include <linux/workqueue.h>
>>>>>>   #include <linux/spinlock.h>
>>>>>> -#include <linux/kfd_ioctl.h>
>>>>>> +#include <uapi/linux/kfd_ioctl.h>
>>>>>>   #include <linux/idr.h>
>>>>>>   #include <linux/kfifo.h>
>>>>>>   #include <linux/seq_file.h>
