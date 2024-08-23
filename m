Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BADC52D7C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 14:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D2410E03A;
	Fri, 23 Aug 2024 14:39:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xH8hbUkn";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E0910E03A
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 14:39:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sns4A3jWUUWeH4+EPjI4z4YYbV0sXBHitN/7igJjyFeZMvi4BLNEWXbi3rhtqsqKddYFsx0l8v7A4fHRWragxycOyM9/wtjtvh8NiDDDk9GsisRsqwDOLuP7T8dw6q30UqRV57+pEEd33V3VvjvA2HMYxTc7SU0xEQN61INgvWg/144XzSk66bIfCUd/Yqga2Gu5zoL7+gFkKzQnsrPiiDLimo9e85bngS50xuOAh1fMlHg3SYT5yp6FgOs6SUHhYUJ9hFnTitHyl1q1EWwNwi44pSBMCT4IzK3QjK1W8ajRPDauN0Q/jzPdhW9CY/QGqaqTJqRfIBnb2WWWMAVEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3dCrz4VGBriPVduzHkHRayr8H9XS9HbMLvWoDIqfdM=;
 b=lamGcwwF0GFV+wZMNsGdbLqjZ2vLwGkHrjTHHMtfalw873WgZywkZRTtwFLNo/eEaZJI4J4qG3rcZKZgpWdu81jculzWqnLTZS+auBGw9JJnJ9VfXODHK/u/InQn+FtfUZwsUAuJHEJQgz6JVzV+iA2zOky/Eqhoyny+zYxr0cbDMyHfxyNhDEIyhYsQPJkte0tLLxk6C6oCn7hZTKz1OthEBNpCx0iAIh+MdGH/cALHNS6VH4TNZduikJygFWNqKpbySUs3FNN62ed8N1lt2ku8n0TBU6DIpAvC5bKPNe/oBuRpMyYCiB98JF4zCt2U/lfOATGdPiiCp5g9m5KYuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3dCrz4VGBriPVduzHkHRayr8H9XS9HbMLvWoDIqfdM=;
 b=xH8hbUkn322ebjlH1NltMy2qu+Fp6MneLQUg42zGLvCibD0SqaSbLGKz2eUaXhEh/oRA1g05dC3skN+S2PaaqY6F/N0Ydt6mDRQ8xSDyYEw4Gaw9JbiS4y6nidXoQqKYVJLBlInABLDLCAyR151n7yqMYFuN91B+T377xJWF2Hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Fri, 23 Aug
 2024 14:39:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Fri, 23 Aug 2024
 14:39:37 +0000
Message-ID: <9efbc3a1-c43b-4f8a-a334-6ff77e6de283@amd.com>
Date: Fri, 23 Aug 2024 09:39:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Don't wake dGPUs while reading sensors
To: Alex Deucher <alexdeucher@gmail.com>, "Luke D. Jones" <luke@ljones.dev>
Cc: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
References: <20240820020435.472490-1-superm1@kernel.org>
 <CADnq5_O3uTj_Zu9+iY_k8i2MQhXH=Ac2+GhCe5DeW=CWY6jn4w@mail.gmail.com>
 <0e8d0a26-3dca-4669-96fc-d9f4bffbe5f6@amd.com>
 <CADnq5_OL=W_Uz9LCeoYAEZ=XX=1tu0=Hky=pjLmfz0x8vWUT-g@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_OL=W_Uz9LCeoYAEZ=XX=1tu0=Hky=pjLmfz0x8vWUT-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:408:f9::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a14ff97-5e8e-42fc-44f8-08dcc3816980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEgvcjZGUDRac0V6dEFnWnRIdVU5NmtZdmEvVWU0dGZKbXl5dFcxdndqT0dW?=
 =?utf-8?B?blFzcE5vNVYrQ0h5eWlzOVY3Z080dllsUTdUbWxWamt6QU93ekVzZGFwS0pH?=
 =?utf-8?B?S3Vmd1V0djdtTDh6QlVkS1RFZ1FqTS8vcmRSSkhBUzdxRjZxSFc4VUVjUXow?=
 =?utf-8?B?VS80NU5nRnJXOGtEbWN5d2dkZFFhQ1pwQ0ROMFZxT0w1bHJxa1hIbkhWOWgy?=
 =?utf-8?B?bDBvWjhTNk1RaGwrUFBnZ3A3Nk9DdXZjT3pSdXVaaEswRjdSQ3psejYrekQx?=
 =?utf-8?B?Y0FrUHdDUXB3d2VxTnJmOWpha2Q5ejVGTDRIT0xjSlJHN2RFa0dZUTBZSGFz?=
 =?utf-8?B?MTVkWkQrbnpFRlBhUUhtNEF4OXJJTldHMzdoNU9pR2NDTDdkNjhHTk9XMjh6?=
 =?utf-8?B?Q01UQlZKOG0ybmNXSlNYUzBNdENaK05CczFaWW82M25tck5sUk8rcDRuT0d2?=
 =?utf-8?B?MVd4T1Z3OCtQV3JKWHlUNWlLazVuS0NWWThsU0pCTml6UXNaM2t3R0JJODVw?=
 =?utf-8?B?b3VJdjdhRUM1d2NrcTVnYnplODU0dXNFN1JVbXkzYWFRdXNXQWpKUGJpd0xV?=
 =?utf-8?B?dll0KzhRNDAzRUFMamNSRk9EYlpMS2tuTHJRQ1JFVGcrdTlmVDErODM0VG1K?=
 =?utf-8?B?VnI0ZnhMZHRKWGxxNTN1S1U3REdFaTVYb2h5Q2M2Wk1aL2FBdWVwcVdYZWli?=
 =?utf-8?B?Q2ViRmROYTRacUdQWENPbG1tZnRuMVZkeHNFbk5IUzNBMFE3b2VQS3Zpb2Yy?=
 =?utf-8?B?T3BDTGMzeHZPRjRpbWV3NmpYeTZMV0lCSnZ6TWpvd0pBZllQV09GbnBYeHUv?=
 =?utf-8?B?OXhPbUJHalRhTTlBdWxZMEo2UHhxMC9meHd4N2huV1d6aUhNK2N1L0x3RW5O?=
 =?utf-8?B?ZThsUFJYZjRJbSs3aGxVQzlWNmV4QkZtKzlWWmRuUWtpcmk3aHA1MVMya3NW?=
 =?utf-8?B?OTRqQ051QlphQlc1azZicHIxRDRldE9vcEVNOW5HdExkbktuQXZwbmFLeURS?=
 =?utf-8?B?M1FCWHNBaDRONGNlU2E2Yi9rWnJhRjdtUmkxMTQ1cER3a3RmNkJBYzd5UU45?=
 =?utf-8?B?TFo5Q1UzcDJSeVU4eGgwNVNYMFhwVDJtdWtZTDZqa2VOeGZmV09ZKy9PejYw?=
 =?utf-8?B?elNiV05QdnFxSXlZOWxGQ2M4OXhLM1lZNzFBb0x6MzZKTVQwcFlyazhWVWRO?=
 =?utf-8?B?ZUlWb0R1K2drYTFpTkRYUVJVMWZTUjBsdUZCNk5qMk85UDdySzk2RHc3aVVw?=
 =?utf-8?B?ODNTL2M2M3ExV3pmc1p2QzF5Q044RFJSenphcnFOZW1ZYWM4WEYwY3dPaFlT?=
 =?utf-8?B?NlR1OTUyeElxWDlFTUtZOXNGc2FOaGFPUnk2M1c4a3FJbnRGcWhibVFESTJK?=
 =?utf-8?B?Z2d3bC9FeGNDYURZdEljOWMxWmtPampZRzFlUGZXaHJrRS96OS9PZ0lLMlIr?=
 =?utf-8?B?Z3RiZVVLZjdaSzNQVStwNVBaYmZsN1AvN21sc2JzQ2JWME1BakxuTGk3UEhR?=
 =?utf-8?B?OW41QzVhU0xiNnZLZkVneFBDTWdDaVZhQU1WY3Y5bnl5YnMrOHFJTU93cWRx?=
 =?utf-8?B?UHdTZU4wclVpZkNPNnFZYzhpM0w1Q0pSb3hyRWxRSC9BSkxVNHhkZ1FGT1k5?=
 =?utf-8?B?UXh6MFpKUlQ2SmNJQ3A3YlBrdGhTSDU0V1dqRU44S2dON1RwZmpjc085LzZa?=
 =?utf-8?B?ZE1pQzZLZ1JpYnZKSHdVdWRoMEJKOFpucTI4YXNEZHJjdDROUithWjRjdEVx?=
 =?utf-8?B?c1pHdStIZm9HYjBESWZ5NVpqaXVOcnZwZHlXQ3hrSDdiRm9hR2p5VE4xZG0w?=
 =?utf-8?Q?tYfrSgnsUIeH02OT22jOlZ/bZk0CD4ePi3W1w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enhncHA1SHpjb1duRVU3MlZIZlQ2U3NadS9sKzE2NzdRVmVSaHJKTDNhRFpG?=
 =?utf-8?B?UVRxa1ZtR3hSekJNYktqM3RTSTNYMWNWV0V4bXAxb1NPSnRjSmVxemd4ZmU1?=
 =?utf-8?B?bmR4YVp6ZXc3NTY5L3huRVpiOTVBVXhZMHR2Mk5iOHRKWjQ1UDNiS0RUcVds?=
 =?utf-8?B?cWlSdW5aUXBjY01yZFRvbi9ldklnNHlBWXd4a2d5bFYwYkdSVFA1eUk0a2Z2?=
 =?utf-8?B?NHhHdWdPSGhLTkVaQ0hlczE5d29NSjFLcGQ4RnpFaFhBZ2VnekQ1NmJlbkRk?=
 =?utf-8?B?NTE0bnUwamdPdDVMMmlYUmVmakxKLzVSMVhvbjR4TEZtRUZicXhRclQzaFZj?=
 =?utf-8?B?MEw3SHdFU0xmejRLYlFiTWZiVnN0VkU2eGljaGhxRFZSS3plVjgzVjZmU0Q5?=
 =?utf-8?B?Q0Rsd011UUlTdkI3L3doMHFSWERIemhFU2haZ2ZhSWRkQ3Z0bUx4UnZDUVVZ?=
 =?utf-8?B?UWtIc3o5Q21ocTNCZC81aVNMRi9qa2F5VERQTDA5QVVQa2cwV2lPTTlGWTRM?=
 =?utf-8?B?ME5mb3BzbEtWTFVIN2pUVDZRQ1FWYXJrSVRxemZFMFg1a2J1V3FPaXlQUVZJ?=
 =?utf-8?B?RlRlSGkwQWc2Zm9NemVuTm9sQlA0QzZDRm44dkhzVjZpcEsyby9qNGk0aTd2?=
 =?utf-8?B?Wm4yUUxlZ2J3MmxYdy8vVkovallhc2xNU0N0TWp2TGpBTmFyNVBCQ2tWQ3VH?=
 =?utf-8?B?NU9GeUl0T0paKy9Pd1MrTVZaMjlBcEJqSWxUV0dRTmlWQTBlVWU2MVkrWjVU?=
 =?utf-8?B?TzQzeVZPemZHTDVqditUV1kyZzNFVG5pTi85dWM5bWI1czlVTVpvcU5MUEVI?=
 =?utf-8?B?M3M1Zk1ZQm5PSm9Udi9VZGxrRmJKM01IT3FodktVcnJoUG82NkZrWHk1Z3Z3?=
 =?utf-8?B?S3k3aE5SeHh4WUoyaWVSY3laRlFoTmc2eUFEZkFRY2I0ZUlEK1pkQVpsaEJW?=
 =?utf-8?B?Y3BXR21xbEVYNTdIQ1FCbUhIUGRibFRnUHAyZE1RalhpT1JmTFBLWDQ0bngx?=
 =?utf-8?B?TnhRbGd3dnVubDVhcysvK3psblc5MXlSQXF1VmxIL01kaDViSDRUczMwY2RI?=
 =?utf-8?B?QjZQaS8xTmJ0VFZoUXJTSkswZFpmNkw4SDhhdFdhejVMRHVZWDhmWmtjUzlm?=
 =?utf-8?B?c2pYcklQRTRSMFQ0T25mOGdVRzhUMkJBYkR5amRoY2kvUmVvU1ZTUE9RZGtn?=
 =?utf-8?B?VlVzanorL0ZzbTlWY2dhUVlpRFBBWjlmN2RCN1RwVHpSdWZSNzVxT1A3L2JW?=
 =?utf-8?B?WHN2T3Vwa2RiTUMrME8xL1dySXlsTXlHbmg5NUtqb1RVWW93NWV5SHdWWEww?=
 =?utf-8?B?b1FxREw2Q3g3WEN2SFhGYmg4ZlNiakRacE16b2dRYW9ocDlEb0tyOUhUWnpC?=
 =?utf-8?B?d0tHOWl5c2pwS3NBd0dSQnVudkFUTWQ2NlRUMDBEYnlVc1djcDlkb0hjeVhY?=
 =?utf-8?B?UzFJZytPM1FycHZ2TllIVW14ejByZXBEM1YzY3FhK2YxUXJvZUNySjBPV2JG?=
 =?utf-8?B?b3lEQml0dy81Q1JnTk1kVEZtcnUyaFlXdzd2YVJkYWtteEpTZ2FHWXZCeE55?=
 =?utf-8?B?R21hT255eEhQRmtOT2lqOEdkT2lFeUxwdENMNGUwWEVENGdNNUxoNU9SeSt2?=
 =?utf-8?B?c2xlM1RIb3pRaUdjN1Z2SklsKzJDYm9rSm1xL1pQNG9NVk1uYXFlSXVhUWlH?=
 =?utf-8?B?anFqbzV2TkloOHRIWDdWVzVjM05kcFBsWFg1TlNYTkNLUURtZnpITkhvVjdN?=
 =?utf-8?B?K3ZyQ3gxUGROL0x0TlNrZ2xTTDk3a1pER3BHZGg0aS9xbnViUTdpVGkwaXF1?=
 =?utf-8?B?QVZidjVMQXhTRVpHcm1tNmdzNkhwRjhhZnpRRWtQaGZzejRBN1dOU2ZzbGNZ?=
 =?utf-8?B?OHlQTUwvOGx0Ymw3VzFjRU1vSmU4YkZTMWV6UWhNK1liNUtPdXJDOGNPMTl4?=
 =?utf-8?B?aXZtR3phVDBqSFFIVk9yV2F2R3VpajdjZXpGUWt5bmJXVEhiRG10TXlYMzRS?=
 =?utf-8?B?UlNzR2tBM0xwYk5VVDJlQ3dXZ2VBN3VrQlNkZDk0eTVTeno5OVNQeGpiblQ3?=
 =?utf-8?B?dUFkS0xxTFhjVHM0QWxmTXRTNWNabmFGQWx5TFZzVW52OC9ObEx6Ri9odHpN?=
 =?utf-8?Q?sSwtWP5v8WMJvY2aJc3dl5fFj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a14ff97-5e8e-42fc-44f8-08dcc3816980
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:39:36.9541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+Ds0cOH+qjau2h5Dz9HLQLJxBAqFtAC2k0GycCNr/M+luv3ZBF5YKyp4IROiwusoXZ6GIOUIGNIHkUZQqShRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
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

On 8/23/2024 09:31, Alex Deucher wrote:
> On Fri, Aug 23, 2024 at 10:13 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 8/23/2024 09:09, Alex Deucher wrote:
>>> On Mon, Aug 19, 2024 at 10:30 PM Mario Limonciello <superm1@kernel.org> wrote:
>>>>
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> If the dGPU is off, then reading the sysfs files with a sensor monitoring
>>>> application will wake it. Change the behavior to return an error when the
>>>> dGPU is in D3cold.
>>>
>>> I'm a little concerned that this will generate a flurry of bug reports
>>> if this now reports an error.  One more comment below.
>>>
>>
>> Do you have a particular app you're worried about, or just a general
>> worry?  I've had a lot of people reach out to me complaining about
>> battery life on A+A systems, and it comes down to the use of sensor
>> monitoring software waking the dGPU which people don't seem to expect.
> 
> Nothing in particular.  Just expecting reports of "I checked my GPU
> temperature and it returned an error.  It was working with the last
> kernel."
> 
>>
>> I did double check that software like 'sensors', 'mission center' and
>> 'nvtop' don't freak out from this change.
> 
> Do we know what other devices do?  

I'm not sure.  Let me CC Luke Jones, he might know.

> I wonder if it would make more
> sense to have the userspace tools check the runpm state before trying
> to access the device.  Of course there are a lot of them and fixing
> them all is non-trivial...

Yes that's another way to go about it.  But I've raised a bug with 
mission center folks 8 months ago [1] to tell them to stop querying 
dGPUs in runtime PM, and Luke Jones also raised it with them 4 months 
earlier [2] but it's still not sorted in their project.

[1] https://gitlab.com/mission-center-devs/mission-center/-/issues/143
[2] https://gitlab.com/mission-center-devs/mission-center/-/issues/30

I suspect we'll hit similar road blocks with the dozens of other 
softwares that do this.  So that's why I was thinking cut off the 
snake's head.

> 
> Alex
> 
>>
>> Here is what 'sensors' shows on my local workstation with this change.
>>
>> amdgpu-pci-6100
>> Adapter: PCI adapter
>> vddgfx:           N/A
>> ERROR: Can't get value of subfeature fan1_min: Can't read
>> ERROR: Can't get value of subfeature fan1_max: Can't read
>> fan1:             N/A  (min =    0 RPM, max =    0 RPM)
>> edge:             N/A  (crit = +97.0°C, hyst = -273.1°C)
>> ERROR: Can't get value of subfeature power1_cap: Can't read
>> PPT:              N/A  (cap =   0.00 W)
>>
>>>>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/pm/amdgpu_pm.c | 90 +++++++++++++++---------------
>>>>    1 file changed, 45 insertions(+), 45 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>> index c11952a4389bc..d6e38466fbb82 100644
>>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>> @@ -142,7 +142,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = pm_runtime_get_sync(ddev->dev);
>>>> @@ -173,7 +173,7 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           if (strncmp("battery", buf, strlen("battery")) == 0)
>>>> @@ -270,7 +270,7 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = pm_runtime_get_sync(ddev->dev);
>>>> @@ -309,7 +309,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           if (strncmp("low", buf, strlen("low")) == 0) {
>>>> @@ -371,7 +371,7 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = pm_runtime_get_sync(ddev->dev);
>>>> @@ -409,7 +409,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = pm_runtime_get_sync(ddev->dev);
>>>> @@ -448,7 +448,7 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           if (adev->pm.pp_force_state_enabled)
>>>> @@ -471,7 +471,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           adev->pm.pp_force_state_enabled = false;
>>>> @@ -541,7 +541,7 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = pm_runtime_get_sync(ddev->dev);
>>>> @@ -577,7 +577,7 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = pm_runtime_get_sync(ddev->dev);
>>>> @@ -760,7 +760,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           if (count > 127 || count == 0)
>>>> @@ -862,7 +862,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = pm_runtime_get_sync(ddev->dev);
>>>> @@ -922,7 +922,7 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = kstrtou64(buf, 0, &featuremask);
>>>> @@ -957,7 +957,7 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = pm_runtime_get_sync(ddev->dev);
>>>> @@ -1026,7 +1026,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = pm_runtime_get_sync(ddev->dev);
>>>> @@ -1095,7 +1095,7 @@ static ssize_t amdgpu_set_pp_dpm_clock(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = amdgpu_read_mask(buf, count, &mask);
>>>> @@ -1280,7 +1280,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = pm_runtime_get_sync(ddev->dev);
>>>> @@ -1309,7 +1309,7 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = kstrtol(buf, 0, &value);
>>>> @@ -1342,7 +1342,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = pm_runtime_get_sync(ddev->dev);
>>>> @@ -1371,7 +1371,7 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = kstrtol(buf, 0, &value);
>>>> @@ -1424,7 +1424,7 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = pm_runtime_get_sync(ddev->dev);
>>>> @@ -1463,7 +1463,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           tmp[0] = *(buf);
>>>> @@ -1517,7 +1517,7 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>>> @@ -1630,7 +1630,7 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           if (adev->flags & AMD_IS_APU)
>>>> @@ -1673,7 +1673,7 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           if (adev->unique_id)
>>>> @@ -1846,7 +1846,7 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = pm_runtime_get_sync(ddev->dev);
>>>> @@ -1887,7 +1887,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = pm_runtime_get_sync(ddev->dev);
>>>> @@ -2005,7 +2005,7 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           r = pm_runtime_get_sync(ddev->dev);
>>>> @@ -2227,7 +2227,7 @@ static ssize_t amdgpu_get_xgmi_plpd_policy(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           mode = amdgpu_dpm_get_xgmi_plpd_mode(adev, &mode_desc);
>>>> @@ -2250,7 +2250,7 @@ static ssize_t amdgpu_set_xgmi_plpd_policy(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = kstrtos32(buf, 0, &mode);
>>>> @@ -2652,7 +2652,7 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>>> @@ -2684,7 +2684,7 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           err = kstrtoint(buf, 10, &value);
>>>> @@ -2742,7 +2742,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           err = kstrtou32(buf, 10, &value);
>>>> @@ -2787,7 +2787,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>>> @@ -2817,7 +2817,7 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>>> @@ -2881,7 +2881,7 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>>> @@ -2912,7 +2912,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           err = kstrtou32(buf, 10, &value);
>>>> @@ -2956,7 +2956,7 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>>> @@ -2988,7 +2988,7 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           err = kstrtoint(buf, 10, &value);
>>>> @@ -3128,7 +3128,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>>> @@ -3209,7 +3209,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           if (amdgpu_sriov_vf(adev))
>>>> @@ -3663,7 +3663,7 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = pm_runtime_get_sync(adev->dev);
>>>> @@ -3747,7 +3747,7 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = parse_input_od_command_lines(in_buf,
>>>> @@ -4626,7 +4626,7 @@ static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>
>>> I'd prefer to keep the current behavior for debugfs.
>>
>> OK.  I'll exclude it for debugfs in the next spin.
>>
>>>
>>> Alex
>>>
>>>>
>>>>           r = pm_runtime_get_sync(dev->dev);
>>>> @@ -4671,7 +4671,7 @@ static ssize_t amdgpu_pm_prv_buffer_read(struct file *f, char __user *buf,
>>>>
>>>>           if (amdgpu_in_reset(adev))
>>>>                   return -EPERM;
>>>> -       if (adev->in_suspend && !adev->in_runpm)
>>>> +       if (adev->in_suspend || adev->in_runpm)
>>>>                   return -EPERM;
>>>>
>>>>           ret = amdgpu_dpm_get_smu_prv_buf_details(adev, &smu_prv_buf, &smu_prv_buf_size);
>>>> --
>>>> 2.43.0
>>>>
>>

