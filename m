Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4730C021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 15:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F4D10E549;
	Wed, 19 Feb 2025 15:42:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QcHG7UT6";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48B3010E549
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 15:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nezz2fBQrY0sa+uLBxNnGZIcZARtTpkfxyVEKEs/XZkgss63+HcaYxtNCbpIoxIQpJRL3ihaBWzcqPvubKrw72jrrShH0p9OwUSz5ChYhXXq2lrKh5YqLx5j9OfHHK+mqE1HgDl4aObXCu9mCIzHpjrDu6wxtWQtIKIfABrz4McK8whnYe25gIQYuFLeSK8LCKcGpWJfnOBrfP6yjLu3ff5xo9XuD4HDNdxxae0gMjlXQYQPm06PXJ2+v4QPQANWbVhIkf3aqS5agXv4FSkzHUdI39YXtaZ91fJKiC5IS2ER4oECIYZIZCcUpR0OxorDigMj4XHaQl+tRAd2awaR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNaq2XCDUM+MPY3dAaaVoghuMmP3+gAXABiCX73vGW4=;
 b=Scf4KcD244Es8s6VSc4msokW3j+eyiZAw9+LzVPKVfjgigd/Iu2v6/MtBhr1VOF018ajBVYrEcwCayNcuohy8mlADO/AAte3UwkFQMpV3EXs6Tp+mkHNMpukPAOwp+QT/AfS03le+wZGOWoI9MNDtmsdxZheaLn7RbnscpP3s8khVex16XddFz/cPohcOoLf+MddIxy1OecIJc+/DT54xnFV4WKuWtO5AVR4iUgs8FlrPZXy7llgWhnkaajqxZZAHS2z5ISv5fJfk0woioeXaFW8Znwvt1bpVh2xPNnePmWWmlecL3p5XuKnSzRhTAvgFZ8FdmMo43l96qLTK9VQYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNaq2XCDUM+MPY3dAaaVoghuMmP3+gAXABiCX73vGW4=;
 b=QcHG7UT6bxEg9xyXMsxG1Ft7I0oQVeoevqj5Hs/Am91em1JJPsQnEyR5dZLVYjQ7yFL45G+z0R3sOeFrHYI0V9oEoCLX/vNmDwg4swsgX8U0tyKgngXsmveLM5nDuZzscor8PZsqKMqgplpNdfPPxXHyJFxtLC1hqJzO/zP0jsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 15:42:52 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 15:42:52 +0000
Message-ID: <264cae95-e28e-46af-b6e5-df9cafea2f28@amd.com>
Date: Wed, 19 Feb 2025 21:12:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: disable BAR resize on Dell G5 SE
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250218150829.2710795-1-alexander.deucher@amd.com>
 <c3626b4c-ce7e-494d-8c56-6d55869524b2@amd.com>
 <CADnq5_MZAuwCOBSfmLL5tddM0U-CmVN7Ca+nRSdKzAaZkC=dWA@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_MZAuwCOBSfmLL5tddM0U-CmVN7Ca+nRSdKzAaZkC=dWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 422198a1-e45d-4ebd-b620-08dd50fc11c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yk5NbzRmNFBJemNURjJFNkxvVjNBUDhPblhpWUFPeDlmTlM3UWthdVBRM3Ny?=
 =?utf-8?B?NDZZZWFlRTFYMVcwWCsxT2M1Z2RJTkRQMU5LaXFOSkZyR2h0SlZvQklmaFQ4?=
 =?utf-8?B?eW9FZnZBc3JIQ09Bd3lOclNXa1RERjZwVlZCZlkvN3RhdVlDbFFjOWxDTU9k?=
 =?utf-8?B?VXpzRXN1N0h0RGlVNWZDYk8xRWpGZUZyK21ZY3NwQ0hUa3lQUjlhdUZuSEVK?=
 =?utf-8?B?OGV0NlFjbC9FRWJ1c0E2TElnR2RvTjRzank1YTNtZWdRYzdqdFB2VjZNNldR?=
 =?utf-8?B?c2tWQ2ZadmUxWm04NGdtbndtaGl4U1hmclFidjYxVXR5eHRiTGxPTm1jK2xN?=
 =?utf-8?B?SmpzbWFjNlhmQ0xISUkyeE1wdnQ4dFpuVHhnVTBPa3hwaUwzZzUxa1ZmTkFP?=
 =?utf-8?B?V0k5MEZZWTh3OXpxVVlJOUZ0cmVMamJOenNaMXo3dGNURy92V3NhU3IvYzhn?=
 =?utf-8?B?SGUzWDBlenRHclN2SE1jUE9XVkVvcXlaSmpETzJvUFdmVDNBMS9PNUhIRGxs?=
 =?utf-8?B?aUtFV2ZvdXpQZVlxcFZxNHdQSHM5WVZTek1ySDlQd3NTN1VOSkpoMVhJdFJm?=
 =?utf-8?B?dzM0L2tHSmZwNkp1VkdwK05RVmpGRkVQV1V5OFdJd0E1TkszN05NUCszU1I4?=
 =?utf-8?B?U1piSlBManFBTi9KSnI3M1c5cERmbWJNK1hDanRobFlCeEFNL01mUGhxUUpP?=
 =?utf-8?B?Q3JjMVFRRGFUOUJ1NnBjV08yc3Jpd2hlZHBkeUJ4WElpdmh2NG80VDRUUWl4?=
 =?utf-8?B?ZXltVkRwcUtNTHRvSm5UcVRpTitDK1V1ZGtjTHZqTHdoVjNyUXpoWHZuRC9m?=
 =?utf-8?B?MmF6WkEwMnZjNmdNYXc2V21vczl0Um95ZVRuN2dDRVRua3RqbXp2TG9CM21y?=
 =?utf-8?B?bmV0Ry9RV0lqS2kxN1l4dFB1OHdiMWQrdVd0YXNqbWdjQ1FXbmZKLzlRSVVr?=
 =?utf-8?B?Q1krOUJCZnNRMUFvcFYrYlNBMVZVM1h3SnFKL09YcjVXLzFKNG9BK2Z2dEQ1?=
 =?utf-8?B?YzhEK3NCUFRWUy9KRFpHVW5QTHVyWEpOQjl4ZmZrVXNvSUNEelhkV05NMUp2?=
 =?utf-8?B?YmFKcUZxYXBOU3h5TjBTZE5PZFVqbmNTbk94U2lEa1l4SFVhZnhPMGhGellL?=
 =?utf-8?B?S25tWitHQWJ3ZVR6eEMvS2V6cG03c3V1L2ZaQ3JoM1VwUDNoeXNEREdDeUhh?=
 =?utf-8?B?WnJOdGpxSHBpcHFSTDdlUWg5RzE1WTJ6Rk9iU1FGeldLbGlhSWxwZUZqSEpY?=
 =?utf-8?B?azNHcVliT3I3RDMwZVVkcnFKbWI4ckpEM2F0ZEdpMVdTZ2xtMExwUUZSdUQ2?=
 =?utf-8?B?cTBIZ1pxYjU2VHBwTUY3QjZaODI4RXlyMDF6dFFTZVNxbEprb0U4ejhTYXh6?=
 =?utf-8?B?b05NekJrcDJwT3hsZEJRWVliYSs2TXBqeU5Id0V3MTlJWFFIK25qai9xY1N2?=
 =?utf-8?B?cGpqU2g2aFFqcWwyWVdxOUdoZnhma1hEK2dqQXAvcnk5dVE4OXM1YklQNXBC?=
 =?utf-8?B?ZDdtZFdEUlFQR3pncDFpY3lvd2xkbGtGa2QxbFEwUzNVTzBpVlJiYVBpMU9u?=
 =?utf-8?B?alEwNlpndXFQcGh3U1dPYW1LTjZHS0MydWVMUHh0QjNjNTVQQlpKTXBSYzYz?=
 =?utf-8?B?NnhQclJuQ3dPVzg2TjNBYUVDTm4wTGh0NFNnRDRiNUJnR1hlZjBKUm42V2kw?=
 =?utf-8?B?SlBNckR0cDZmbHkwZHNZMDhXWmtSOWNJSGdKd2xzT0tNRWdTQ0Jrck96bi82?=
 =?utf-8?B?TTd3cm90ZHlnajRnS3NkVFIrYkdwck5RODBpbHZwL2NFZmJiakcyWExiUll0?=
 =?utf-8?B?bHBMYWJ4ZjFPRDRNN3FSUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q25KWWlxNS9oLzJmS1RwN2NqaTdQeFNkdy9NbG9WSDlMVUd6dGs3Vk1Id284?=
 =?utf-8?B?SnFlNEZXcVgxV2FPbXlPTnoxejNOSHFKVjBoVzErbmVVVFlSZDhQTnRtMW1n?=
 =?utf-8?B?Y256NzhQRU1URUNKUlhVT20wdWtPaVQwNkRCZS9HblN4OG5FOU0yZUhDd05H?=
 =?utf-8?B?S1BmQTV3eS9zQ1VjZWV5QVZ5V1hsT3VRTkROZmJpRTZTOHVWZll4Q2p6UnY4?=
 =?utf-8?B?Zk1FVkRtbHJMRlRNM1dwUXR5cElFYzEvYkVRT0J1azZMVjdBNFN3cUY1S0cr?=
 =?utf-8?B?SklkamhtQWx0cy9teFdHZDExNWZyNUV3SDN5UG9aekxqRHVvWFJQNkUxOFN2?=
 =?utf-8?B?MVo1UUhIU2hSbUFNbUtSUCtKR1h6RXVtdUh1ZDBjWXUvcHpodHUzRGhqOWs2?=
 =?utf-8?B?T0JKSnJVOU01UGVkTGZuRU90R1NqTjZxdDI2OTNxSi81S0hydEwxVCtKelRz?=
 =?utf-8?B?NWxQc1M4Q1JlNzVKakFjVzRPSjFZd3hwbEUvNnRSc25HK2wrOXo5dkJhOVZo?=
 =?utf-8?B?Tm1FRW5SM1pIVlVPTUgwd3k4emtsa0J4MGtZWGtsUkp6TnlRMExNTjhveDVH?=
 =?utf-8?B?VFZkcFArYnlyRGlvMVRLV3ZvRjFnOGRzeFRFMjhRZE1wTG9URTE3SDBreW5y?=
 =?utf-8?B?b2ZyczhpbTYvQ3ZEQmFsLzRiYVZ6ZnhIS3JnNnVZQlJRZUozWEMxL2t6NXZp?=
 =?utf-8?B?ZkR5MUlOdFFmcDM0bmUyTmc4MVM5bWdHRDd5SGh1YXBzR3hRN09hM0tINzI3?=
 =?utf-8?B?Rk1qbEdiVXBydjk2QnJRem9CQ1VwaE5ocVYrdU5DZnBZSjZCM0dUWjMvVGlp?=
 =?utf-8?B?SjMxbk1pdi91Q1k4RmNOR0dGOVNtQ1dQOEVUZHpZbHU0TnVlUTJKUy9hRTRw?=
 =?utf-8?B?VFBGdjM2V0tVZmZieXpsTjc4SzVSRk8ycjc1N0JEWFRRMG8ySEY0YmJtTCta?=
 =?utf-8?B?VCs0ZTlHUmxWeHp3Sm5yQW5TOGthL2hjczVvUnFOKzNGaWZyNDAvdW9RYUYv?=
 =?utf-8?B?Y1JiOUVvK09CcEZDWm82UTJDNUV3clluOTZqaTBGd05oc2FpTXJvNTNjYlZZ?=
 =?utf-8?B?ZVc1UHN4bU44WjFMZmxOK1ZXT1hYNi9TelhCUjRaRXVxR1g5bURDemVyUTY4?=
 =?utf-8?B?ZUNjYVJnWHVlWkJnQlluUDR0c0pOWGNuWWJWVTNBQWpoQzlQOW9DZ1gvU0dk?=
 =?utf-8?B?cDZxS2JUc0xMQzZCT0R5amdHOFZ4TUJzV0tCdjFIODRaZHcwYUFpck9oRmdY?=
 =?utf-8?B?TFNEYzJtYXVQMEhWTUo0WjFDaUZZcUJvYjN2QnNwVm5OQTl3a3V1TStzMzhF?=
 =?utf-8?B?aDg2Y0R5dGZBKzlBS1FhR2VCaDdUMFVncFVpM2wvclROdUVpVmVrUy9OQWQ5?=
 =?utf-8?B?N0E4NWNXWCtoUk94TnkwR0EyRE5NeWdxRlV1cjgwby9hVExSVXN4S3p6NWZL?=
 =?utf-8?B?enVVdDlJTERJR0xpMWFHUEdzd1hha0FrN3BIVlhGaDUvL3BEakZiWUZ3aTFy?=
 =?utf-8?B?T2tOb0xxK0VSYlZ2L0FHMm80SUxmS01MZGViQ2FpRndYaWpmRzI4TjhpTDds?=
 =?utf-8?B?ZUpWRVhMWUV5OVdEbnVKYWg0QjVFdE5JUDVwTEpHeldUQXArL3ZZVURpMWpR?=
 =?utf-8?B?V1hUQVNWT3hLY0FwdGFSTDh0cXZ1d0JrMm5SRG9GbTNEUDZIVXAzdWxGbUpN?=
 =?utf-8?B?NG9UZ0RRN2JVdTlsdmJIdVJUQTlIVFNwaWN0QVUyV0JFbUs0VjhhQlpEdmp5?=
 =?utf-8?B?Um04R2FZZWliVnFvbDBNdmFDU2tkc0tpakpzZHZhOHdMSjVCSUN3TGZkS1RI?=
 =?utf-8?B?NmtPQmxVbkdlNlYzdWUvb25DS2VMblBNUFRLZVVJb05GL01RQ0F3NG9nMXho?=
 =?utf-8?B?VHh0eElaMFRQS3o3cFhrUWFSTytPOHdlYXNsLys3SWNtald4SmtCMzh5c01U?=
 =?utf-8?B?cmFIYk9ZRys4NmFSaW9xbElnU3U4ODBwMGFyRThzckF2SDRUNHpUTzNmeUdy?=
 =?utf-8?B?ZHFSQUJyUkpOTVgvZmlPcTg5RDQrMkxmUkhxSklFc1hFS0ExakVEdHYzbSty?=
 =?utf-8?B?em05Zzd3RnVZM2d1VjYwVjV1NnF5TUFJNGltaUhZVFZST0NFYjNHK1pxLzVw?=
 =?utf-8?Q?glYEFGwYI55dz1angARXTQ55T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 422198a1-e45d-4ebd-b620-08dd50fc11c3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 15:42:52.2486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgkrZ+yGY0i6VyaFpZCZMdA9oIVxVFLk/PDhiDOXlXrVLt5mk2mqFQwIqfRt4SkB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080
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



On 2/19/2025 8:02 PM, Alex Deucher wrote:
> On Tue, Feb 18, 2025 at 11:05 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 2/18/2025 8:38 PM, Alex Deucher wrote:
>>> There was a quirk added to add a workaround for a Sapphire
>>> RX 5600 XT Pulse that didn't allow BAR resizing.  However,
>>> the quirk casused a regression on Dell laptops using those
>>> chips, rather than narrowing the scope of the resizing
>>> quirk, add a quirk to prevent amdgpu from resizing the BAR
>>> on those Dell platforms.
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
>>> Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> As per the issue thread, issue happens when dGPU resumes from runpm. If
>> so, can't we disable runpm as the workaround (IMO, the current patch
>> also is a workaround)?
> 
> This seems like a better workaround than disabling runtime pm.
> Leaving the dGPU powered up all the time seems worse than limiting the
> BAR size on this platform.
> 

Probably, it's better to note down that as well in the description.
Also, check if the device has runpm enabled. If a user prefers
performance, say runpm disabled through driver option, then no need to
apply this.

Thanks,
Lijo

> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 512e642477a7e..56fd874a22de8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -1662,6 +1662,12 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>>>       if (amdgpu_sriov_vf(adev))
>>>               return 0;
>>>
>>> +     /* skip resizing on Dell G5 SE platforms */
>>> +     if (adev->pdev->vendor == PCI_VENDOR_ID_ATI &&
>>> +         adev->pdev->device == 0x731f &&
>>> +         adev->pdev->subsystem_vendor == PCI_VENDOR_ID_DELL)
>>> +             return 0;
>>> +
>>>       /* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
>>>       if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
>>>               DRM_WARN("System can't access extended configuration space, please check!!\n");
>>

