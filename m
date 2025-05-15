Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8C5C2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 21:31:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46CF110E966;
	Thu, 15 May 2025 21:31:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2yEYUaEF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ADA410E966
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 21:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sC8x28DFKt4tu/GGEgoWHvnM1FJ00iEfTUDZVuZhpxVfW1ONuu6l/36EdUC0susBXr0oRH9EVKUSuNqKiL15Oqcm5bnfNcjZNYZ4+DtQY87l+Abnc2axBLSyUp/hktnYETs3RLUf/nf2Uyj/8j0qRjZCEiAE5DDLy6ZukYmu7gwksbscDZLB+rZw/nwV4WMfETfm5FN2JP7o8WRGYNM092cwQ/AxPNdNW6o8rE5IEcKAUkmEtDyDBH9PIzyZm1VVPls2DvBsHkjkqiHwup1E1tGBPqWqdSMuj7SMhLHFNrRxSyCTk5w392yzOnQonqUUOyPJ7DKqOHYKQCnTSpn6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=go1GfTnLTEAGej7CzKfh8qJpo+cLHdjiWZNCumZ92b0=;
 b=qvhl4tkbffh+9Udi5AmC4NWnxboxcIv8p6c6ckOfcrGNnSRDwQwUZKOAbrO0kstcOf8ar+4DG+Xm3dr9jViO12t19JiBXOSFqXf2Lk+5zYBy6X/tYthi5553f185Xt7FKuwaoQyYI4eJvJCWArWYpSRE8ciWgCyuF67LzK+bR/9zEkF0Sl4fwrERokmqRxIeMSZptYaQgZyR7qzbenQk14s7DHSTAs8Wzh4OSxcZgD2Mtl/qzZ0yHnDEzi/ZpYfxWAZ9SnLizraQwW3aiO5U65kM9LXj3FgkS6QPTdKYH6A21oN1BmEj9/JhSKNosIa4wDhbFbArK7nueDV4hqMNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=go1GfTnLTEAGej7CzKfh8qJpo+cLHdjiWZNCumZ92b0=;
 b=2yEYUaEFPycrr7q/YvKsBgFyRLdPM7AhF9p9HbW3ELRjDevvNepPwVACTSNUg9qJ5T1Fw3kqvjDtBUBBZ6o6o4v6GQnWrV9/2QfIX1tDz5wtGCPOgyv68xGa+J5A3eCwPPupl3SN2oOjqkLkhMlAnR0R55AFAWe3bz3H0f+HYLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 LV8PR12MB9619.namprd12.prod.outlook.com (2603:10b6:408:2a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 21:31:28 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 21:31:28 +0000
Message-ID: <8966fa75-4c46-45c0-b9c6-543f8d10f340@amd.com>
Date: Thu, 15 May 2025 16:31:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdkfd: destroy_pdds release pdd->drm_file at end
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com
References: <20250514171004.4259-1-Philip.Yang@amd.com>
 <20250514171004.4259-4-Philip.Yang@amd.com>
 <4a02537f-1ea3-471f-ae10-c85471a65402@amd.com>
 <18f1dafd-4f0b-9dac-2994-3e826f17e335@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <18f1dafd-4f0b-9dac-2994-3e826f17e335@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:5:3af::17) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|LV8PR12MB9619:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae4424f-3ce9-42ed-c4f7-08dd93f7d9f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eERKWkFyV1Y0bisvcVV2ajFLeFE2MnNwUWZ1TXNDRFlUMWNuQVBUQnlBbEV5?=
 =?utf-8?B?cnk3NEFrZmVuNDUxQzZEdWxkN3FnYUVNQ3ZzeU95dTNHRVNRQVJUSStxdVVZ?=
 =?utf-8?B?NW52d20rMUxrSlIvRGJORmJHRnY3MUpYOVQ0TkZkRGJ5WS90U21qRXVSZmxj?=
 =?utf-8?B?K0tYM2ZiWjVsanJVRlNLTVlLTXlaNWhtZlBuZEUzY0NDMlhsdm4xeVZHWm9p?=
 =?utf-8?B?K3M0RkxpQ1dtWkVlRnNKcWRHWkFlWDExZWVyWHdDcTg1aHU0b0E3em81M0sv?=
 =?utf-8?B?blcwZHhQcHdqQ29hb2dFY1BwQ2xJZVJteVp1dFV4VEVKNjRaYnNhUFhhYzZR?=
 =?utf-8?B?OURiUkhyM2tMdXcwV3poL1FxS1JMZEJySWhxQkdvcjc3ZkxaVXJmZGZhUUlH?=
 =?utf-8?B?WUlSNC9QSWdWelBrNklaTzlVUXpLMzVFVXgzb1BqdzhWYVR6MFcvMFVEK2M1?=
 =?utf-8?B?RUVPU3NucE1DeUFTK3RoYi9YeEhQeDJOSXBhMEdVcEV0UmFDeEs1dW5XZkVs?=
 =?utf-8?B?ODBVZU4vWU43MVZNc1lQZWJkTjV4NWlVdFd6UTNMeDJiSGs2cVAreHNyOGRI?=
 =?utf-8?B?dmJjSG9peUJLcEdrb0ZRSStZOTA3Sms3Q01ZV1hwOUhKaFliSzlTRXhkcjlP?=
 =?utf-8?B?bjdIc3pEOVRvMnEvQTV0V2pnb3NFeVI3bmFkSUQ5M2JEZjFVQzliMlZPb1Yz?=
 =?utf-8?B?NzlJTThWTTZhTUxSdHZIK05ZTjIvd1pCSzkrTXJ6aW5JTllqS2VTdHFjM2hE?=
 =?utf-8?B?ZXl4YjZGeUNMWGY4czFOOXl6M2ZCcHEwK3puWVdpZUJPRlY1bDM0emVKTVZH?=
 =?utf-8?B?WE1LMG9XR0VLVHN2TkJVWEdBblc1L3llMmcya1hWTldKb2pKM21PSnFCT2d0?=
 =?utf-8?B?UWFjdFBabXZuWFlSdjFtN2xTNHJnVzhQUUYzODNHOElxdTF5WW9nbDdDbFkz?=
 =?utf-8?B?cVpiVEk3TVQrd3o5QXg2VkZTUEZDbmVZeW5DOUsrR0xZcW5CU0I2Vmx1b25t?=
 =?utf-8?B?S0U4ZXVhT21KK212WVNEM3FoZ0hhakJrdkNKWUZOa0RQc2JpbDhIWk1SVklW?=
 =?utf-8?B?QUJqdWlydDFxcHRNWFVzNXlYeHIrTUwvZ0ExYXB3Q2M1UE5PTjBGT0dNc0ZO?=
 =?utf-8?B?cGE4d3NIZHdtMUdETVA4cVZJOHVidi9SajhsTWJrMVBHZm5WYmx5OCt5TXE0?=
 =?utf-8?B?LytuUHl0RURzVHEzRXZWb0lzYlBNb2tLQytwd0FLeC9OQVhPVlNrQ2FxODJm?=
 =?utf-8?B?REdSMnpySk54MWRta1ZJczFNb290aEtiY1BzTEF5STZXZDlLckUzMHZPYkNU?=
 =?utf-8?B?OVBLcHN5UER4ak4vWlZmK3dIeTAwalErdnllN2lNT2ZIOHQ4N1RneDBzVkR4?=
 =?utf-8?B?MjJsWFBTMGVuNUc5eWRwaHIzNlJpZS9VUUJGMUd3Sk1BMjhPbytUZjFydFpX?=
 =?utf-8?B?QzRWYVZpYUlPZ1RkWEVzMEpkQjhUYzd5RVI4cmdZdHJLU2lVUklrUk01VGE4?=
 =?utf-8?B?ejl1aHk0ejdrYUtiYmhsdkYxQlFhUHo0ZWhUUHVCZXpXMmxyeFI1SVlFclJp?=
 =?utf-8?B?N0hRMy9mZDAyUjJPWkgrLzk0bEZVenh0Zm5pZzIwcDNNaUY2Qkd4TGh1OHA4?=
 =?utf-8?B?Zkl5Y1djcHM1ZG1JdVNROVZKcEdTcENMNDRDUjRiNUgxYlBjcXg2cDRjZHl4?=
 =?utf-8?B?UXFyOUJtQmVXZ2RiWGdVYXNtbDBIbENTb0JoaGdQUzRxZ1gvQ2RxK0R2aWpW?=
 =?utf-8?B?amNkSWhlN2VOU044WTIrWC9pT21JdFVHMjA5R2NEZUFuMGo5K0RMai9lNGQ1?=
 =?utf-8?B?ZkRXbkZPMGc5Z0ZMd0piQis1ZE42RjNZSHpla0FzOFEyVTREWU9YendxbU92?=
 =?utf-8?B?NFAzQms2QnprTUdEMWd2bzlFZXNEU05NL3FMY1V3ZDhoaFNoTk8rdjJlZHZB?=
 =?utf-8?Q?Mun6FTFz2Cw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU9ZTDhSbTZqbDdkcTZvYjFWWEczZ1U1Z2dkaVBSUXo1ajB1ckNGRDd3VWM0?=
 =?utf-8?B?NFJ5NDRsZ3UyaHpKM1VIVk9jbVhnenRQaGJNOTZ6UHViZ2pzTkVwa01pRFZo?=
 =?utf-8?B?TG81YVRIM29NT0F2WTVVTnlmdGZxb2NVY2pvakk3NHpHYnc1UU1KKzZQRzM3?=
 =?utf-8?B?a1VVTyt0eldndFpPY1ZKOXJzckVpcmxObFdCQWRmN01pM0VoNkdMVVZ4U3U4?=
 =?utf-8?B?L2hXY1FWdk1YWmtyRitDTVVhMUZ5NG1MZHhiR0hCZEJrcWhURkF3Y0M1djRN?=
 =?utf-8?B?ZVllRjg4Y3lTUTlONzZ2RjVaeEVaOHhWWUtRTTFncFVqZGw0VXhaRStHTU9Y?=
 =?utf-8?B?K1huUjhTU1NuaUtFUWVFcSt3Q1RWbDFsd05JMXVIVi9HeWc0RmR3Y3VBd0Jj?=
 =?utf-8?B?WFlTdTNqelpoZ2VxQzB2dXBFUXFPQVVwL3dmV0c4T1VIUWQwWm9VeGYrKzZU?=
 =?utf-8?B?L3hzeHhrZUZzQlRzL1pLZTM4a2l3eCtZeHMzcE1jbCsrTGE3U0NtMnZoRFdC?=
 =?utf-8?B?dGl0K3hsOElyL2x1YXkrRU5UdWNkT05reUd4QXRSVkF3cGgxdlpwbENJTVhz?=
 =?utf-8?B?WXJUSTYxOUNvV09JQm1rdUtxYUJ0bXQ0VmgwNGlENjVNdWFQYmpWNHZVdlhE?=
 =?utf-8?B?eGFyTmRVMzI0V0lJM241OHhXQXF4QjM2a1ZobkRadDVrMUJiVnlsSGVnU2Zw?=
 =?utf-8?B?djBZbUhKaWdUbTdZc0dHYnpBVVZ3RGdrbHFzNVFYWmFra2tzelVxWFZOWStM?=
 =?utf-8?B?TUVPd2JRcVFaL0duOGNkN01jeHowSEZETFFTcGtUN2ZPMnhnbllUSVM5ZE8x?=
 =?utf-8?B?SFVZNmZtNHcrYWxlTjhid2RQK2svdE5DNmJZcU9MY0pOeTJZY0x1dUFLSEd4?=
 =?utf-8?B?dkNDVjBCSzBhN2ZOMEgxNlZDdFhnQ3kyY3JDTVFrNVhIV1RTc09heXNpMmd4?=
 =?utf-8?B?cHNXMi81OXh0SERCUzVadlFYaFJyeVJ4UzdFeGQwUFlsaHBDY3BVWTlHalc4?=
 =?utf-8?B?QW5hSVkycE4raFdLRTR1M3ZubEJnMG9Yc0NiK1M3eUJjYjRkcEk1aks3a2lp?=
 =?utf-8?B?ejdrMGYxV09LZmpJNG81aW1aWThRT00zYkI2aEZieWZYVC9NSFdKT0txWi8w?=
 =?utf-8?B?TEJkMGJVaFhIcE55UlVpQjhYdCs2Zlk4TVlnSHU2ZUNxMjZMWFlSbG15VURx?=
 =?utf-8?B?b3NsYzBmTHorYzUxblVWRlBCSUpUZTI2Kyt6VWRhRW9TR3FwSzlLMklmWndP?=
 =?utf-8?B?N0grVkp5bkpLRk02a1ZiaTJtWHJVS25pZnlMRW55aURsVzVhMmRVR0hleFZh?=
 =?utf-8?B?ZW9kblk3UzNJZ2dJcGdGOUEwaWR4K3dFd0sxWWpYWkFGN2ZWQmVyWGw3eHB2?=
 =?utf-8?B?Z0U5RWZUMm9JZ0NQVTFQR3ZNMlpDN3dEZXh5RWozTG1jWlhLWW44NjdUOWUx?=
 =?utf-8?B?VzFqUDQ5UE8yQ0xmOEF3djArc002S0lRSnVwNVJ4ZmZNWWQ3S1hZY0t1ZW1S?=
 =?utf-8?B?c0ZmR01VSEtZaHYwZXo4SExUcy9jekJwZmRiR1gvbWxSMnRIdVQrZE4rYS9m?=
 =?utf-8?B?WWZkMnc4OUZ1dE5NdGVyemlMZTc2eXBoSEcySTFkeE9Ca2dTK3IyMTZVTC9u?=
 =?utf-8?B?aTdkaSt1NmdBWWhSQStYT0dEZWdvZzZRT0dNU2w2alhMclNReHc5NHdBLzJv?=
 =?utf-8?B?aHRFS3JjYnFiOXJSV2tiVHZjQXpHTmE4dEVOUkkzVnFyK0Mzc0I2VlpndXht?=
 =?utf-8?B?M09mZlFITEVvZWRFVjgwVEtVVDRIc0M2UEdOQjJRd1RkY2JiZHBPSFZkMGtB?=
 =?utf-8?B?Z3RoSkJGNTV6Wmd5aEI5MWRoQUM5WFFrUnlmQkMyaENVQjV4NUtMZGlaSWdR?=
 =?utf-8?B?bkdLcjExRmw2aUNhSVFENnFaR1B1ZzI0aUZteWhQQ0Y3ZCtidEpxS2E3b0FQ?=
 =?utf-8?B?bWk3anlYRndBYXUwaC9Gck9kTmg1ZTJpa2hIYnFQS1hNajJZSk5BdUVmdTNk?=
 =?utf-8?B?cVA0dFpBaVFlSDI0YmZiT2MzZTUyQW40V0JmWXJyWjAvczU5L1dNSVRMWElV?=
 =?utf-8?B?OUV2N3NyQ2lHM0ZCZnY4NWc5bDlQRnB6N1FOYzJhVlBYNFdhQjNWUGt1bmdh?=
 =?utf-8?Q?qKGE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae4424f-3ce9-42ed-c4f7-08dd93f7d9f1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 21:31:28.0856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZvc/+2MJDfCyXPKLTLEhi/u8iK4U1UxCB/exJ231S/sMQCRCWrmofmssvJ9ggJd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9619
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


On 5/15/2025 3:45 PM, Philip Yang wrote:
>
> On 2025-05-15 10:29, Chen, Xiaogang wrote:
>>
>> Does this patch fix a bug or just make code look more reasonable? 
>> kfd_process_destroy_pdds releases pdd related buffers, not related to 
>> operations on vm. So vm tear down dose not affect this function.
>>
> This change doesn't fix anything currently, as fput(pdd->drm_file) to 
> free vm is right between free vm mapping qpd->cwsr_mem, qpd->ib_mem 
> and free kernel bo qpd->proc_doorbells, pdd->proc_ctx_bo, to make it 
> clear for future change.

Then the current place to do fput(pdd->drm_file) make more sense: unmap 
vm mapping of qpd->cwsr_mem, qpd->ib_mem is the last place where kfd 
process release procedure needs vm alive. After that the kfd process 
release does not need vm alive. It then releases remaining buffers. So 
release drm_file as soon as we do not need hold it.

Regards

Xiaogang

> Regards,
>
> Philip
>
>> Regards
>>
>> Xiaogang
>>
>> On 5/14/2025 12:10 PM, Philip Yang wrote:
>>> Release pdd->drm_file may free the vm if this is the last reference,
>>> move it to the last step after memory is unmapped.
>>>
>>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 10 +++++++---
>>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index e868cc8da46f..b009c852180d 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -1063,9 +1063,6 @@ static void kfd_process_destroy_pdds(struct 
>>> kfd_process *p)
>>>           kfd_process_device_destroy_cwsr_dgpu(pdd);
>>>           kfd_process_device_destroy_ib_mem(pdd);
>>>   -        if (pdd->drm_file)
>>> -            fput(pdd->drm_file);
>>> -
>>>           if (pdd->qpd.cwsr_kaddr && !pdd->qpd.cwsr_base)
>>>               free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
>>>                   get_order(KFD_CWSR_TBA_TMA_SIZE));
>>> @@ -1088,6 +1085,13 @@ static void kfd_process_destroy_pdds(struct 
>>> kfd_process *p)
>>>               pdd->runtime_inuse = false;
>>>           }
>>>   +        /*
>>> +         * This may release the vm if application already close the 
>>> drm node,
>>> +         * do it as last step after memory unmapped.
>>> +         */
>>> +        if (pdd->drm_file)
>>> +            fput(pdd->drm_file);
>>> +
>>>           kfree(pdd);
>>>           p->pdds[i] = NULL;
>>>       }
