Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA6AC2BD05
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 11:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C8B810E402;
	Mon, 24 Jun 2024 11:53:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oB7NpCyo";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ED0610E402
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 11:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0UKXBkUGJNTkzverqCVlwjSH7yUmjJsfxMRvlM438JSB8ogGF52tTS0mlPFTdEWdY69cIioaHbhqA7qAxneFCJZpmhtBo0YNL0A6+ewtrldlPulii005La54iruO5kYOELx8T+uANxiY45vQtQypBx0T3WTAgCWciBvjCHVMjnXT8Qu/tt0F9qjvP8cDYlZYnuXXdhaQNRSoOenL10VYX8m1qvUdb/Jf6cp7M6CqE/2MWP6Pdk9Sk0UBfFFRhYms6ocixSqma8tAwcNmibDr6R2JPvCd4GToxM9VKGZhujBIb2jGjvO0DJQrLybP6OmFRrV7XfwXiFLaLUTwf5HOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fV/TIZ4rZmXqHocI4d2wT+g5uhEwfQ77RTM3fEMLdSM=;
 b=Z7woviCXoSHgJF10+hlJhzX+EHtGz9OiFv2lDBw4g5YWl76ViOyRJgMDK48jzWYXRMFHEbsoJgzcjrR+xmJOZS982V+R9Eskkc/zTq6ZHKnG65Ac+dYBoH46tBOt6aCvn3pzAlN38sHAtmlk+2YkmLeFhDX6YDn0XI7ERIIjZPLdlgng95o1jr/8dflJlrmhQY1fYB8PwqCaJT41UXCfacXuo/SuFkb7A4O6wnqKGnQS4EYUCBaLwXgVQHzbVQqqlZDLGNNj9t9EJssYADNdACfNWCburlGSb2o902/r68ueqinRaGEL5KT0omu3XLTOwBwfrIgXSWgI6lScCCv4Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fV/TIZ4rZmXqHocI4d2wT+g5uhEwfQ77RTM3fEMLdSM=;
 b=oB7NpCyofnd3VzQ40f1ITCmq2X6FmlKFpUDVHWUy3I6tMZFKoxqACNzgRB35FPj1dMhKWoFWcE4il9XSegWqk4e6jkUxhQPz7DZzaV4ONcRHcNmmr+xNH30LQ5egond6J1CslUeNlSuPqR7149/tyGhADLDZtSqCyrR7qHer+Rw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 11:52:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 11:52:54 +0000
Message-ID: <fbce85c2-ee05-42f3-bb04-b3db95f8e7ed@amd.com>
Date: Mon, 24 Jun 2024 13:52:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: normalize registers as local xcc to
 read/write under sriov in TLB flush
To: "Jian, Jane" <Jane.Jian@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240624091318.2487733-1-Jane.Jian@amd.com>
 <951495e9-06b3-4455-a394-e3a6312872dc@gmail.com>
 <PH0PR12MB5481814DEFD77EDD1EA34711FFD42@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <PH0PR12MB5481814DEFD77EDD1EA34711FFD42@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2f27df-f4e6-4ac0-e7a4-08dc94442ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkdFaXdtVkwwZWRoMWZEcVVEQlJieWR5TTNmbmdZcllFQngrbE5BQzNUa3dG?=
 =?utf-8?B?M3ZvSnBRRXlNUFc3a0xQMmxraVY3TWhoR3hHSnU5SFVGNU5wYXpmSWlycytL?=
 =?utf-8?B?dDVJTGNPRDBPRFNTS3Q4Slp5d1lyOWFZVVpHUlFjRFQ0dTM1dUFIbWJuOEdn?=
 =?utf-8?B?WWhBTG5NU1lydnBWcDVDc3Q4WVJXbnluQkNzTDkxRUJzL3JZWnhzN1NudHls?=
 =?utf-8?B?YkZFYSt0Z3hQako1Q2lHcGNkUFBPTngyTk1Na3lrQXNiU0RXaFF2SzlrSHNW?=
 =?utf-8?B?S3NTMzlQOUJrcG9LcnV6QkZYRDNPa1lpVWpqTlVicHJIaUg5VThtcHQ2MzA3?=
 =?utf-8?B?VEJIUE1YT2puUUxwWDlOU1ZKdnBCVmE1T2ErZWE1aW9SbkU2eUNpMTdIYktM?=
 =?utf-8?B?RDhHN1lSbW9hQjdFcW9YOUdiZHBheksxQ2lxUi9jQXl1b2RURHN3K2QvN0Iv?=
 =?utf-8?B?eUwrV2t2VmhlRnE0MmhpeEIycm1HbFRHbVgwbHJBTDF1ZHdVVWFVUnFhRHhk?=
 =?utf-8?B?VXZDdmIrSjdRaXZpdk5hSTQ4dUxRUVRaelFNcmkvdFFiaituQzk2K0hOTFZV?=
 =?utf-8?B?WVpIa1RsZXQ0bGhRZ3Q0Rk1TSmFjNTFyTXNPM3J0YnBiNkV4ZUNZbWlYbU01?=
 =?utf-8?B?Z3UwTmlBVDdzVHluR3d2QXdsQ3lxZzQ1VWZGN0grN0Y1c01LYnAyRjlzbzJK?=
 =?utf-8?B?YkRSMERpNlB4NkRJL0x1bHNxUExEWUd5QVlSUTNaNHdDTEN6TWdpRjdpZUc4?=
 =?utf-8?B?QjNISmM3RW9tUG9RM083OUUxdVFvVXdKajRqckYvOUpsczRvVWpZVEFZd0hF?=
 =?utf-8?B?L0prMlF1T1NVME4vcFVBNkJQVGU2MEVvRVowRE9zcDJUMWp2K3pCVkQrWG5J?=
 =?utf-8?B?em1ENzlwWTBzcVFUbHoyK0gyUjNSc0R6elN3c3JiaGRCUGdhbG8vdVB1YXJR?=
 =?utf-8?B?YW13OEFCUHpwUnhodk5aN25rektvb1N4ZEhMakhIYnpMdUU0MTZGaTkyZ0VY?=
 =?utf-8?B?WkpUR3QweFM2eERwQjRrQWIyUGxVcmdpMU9kaXk1aFBQZm95SU11WHhrNC9i?=
 =?utf-8?B?anR2VzhkTmVCVXBiZ1pIYkdoRERWYjI2OHg3d0ZTN2JPZ3o0Q2VWb0RtWWIy?=
 =?utf-8?B?YWh3cUdXQklWb3g2ano3N2w5Wnh1TFFHQW01VGFSemVCV1YvcEh6MXhiS0xZ?=
 =?utf-8?B?dk5mU1R5cExLUWE2MDNJVERMVEM2aHdPSWc4MkVlR1IxTWVTVjdDeW9iOEZG?=
 =?utf-8?B?Ynhqd2ppNVhKRng0MVdXeUs5N3ZYUnpNTVFnMGtBNzkyczdpWmszcWtsU2hM?=
 =?utf-8?B?Slo3OWhEUXUwcFlRMXM0ckthNzhud1RVcldHeE84YnZlQjVSeWZqK0loTThh?=
 =?utf-8?B?UndmeXpMVDhUTCtxV2NCeVZ2UnZwZElzRUtoeFdtN0ZkM0tMRXNiYk9UaWor?=
 =?utf-8?B?dXAyYXhaRVpmWVVhemRBZFZyR0ZrYTdETitvajJpd3RqamUrbWNGYUFmWmp5?=
 =?utf-8?B?VW9Bc0tldkJKdFJIRXNpcmp3NFp5T0NIUlFnY25OK3pvQmJSSlZmVmlBTzJ3?=
 =?utf-8?B?OTFja2Q3TU40VmRiNE4vWVhqUEZ3cGJqeGVFYUVaOGRDb0FaR0w2VFJMR3dI?=
 =?utf-8?B?QXlINEd1Qmx4S0F6U29xZW1xNUxBRTV2WGZHRDdueU96TnhzVzhZd2E5d2tU?=
 =?utf-8?B?SmdlamUzM2FZVlgwSXc4Rm9seE9lVlZlYzRDUmFTZHozdW5rUXpKeVZ6bGFW?=
 =?utf-8?Q?YV0x9Aoges/6yR+JqnlLmPNbFPWxT7+qmZuD4rn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk54TmM5TFBUT0VCaUhLNHE5WkdOOTBUZG5XL1ZRVjg4TU55YXNHTGFocHEv?=
 =?utf-8?B?MDZQb1lrR1lkblQ3NERKdDFSR1JwYmk3SDJQRkdzN1Jud0NWdUlqdnBMeS85?=
 =?utf-8?B?TGVxQWppMU9kVkljZXBoU0FvUzNnU2dJR3VjYnVOTWZXSUp1cXI4aERyV2Nw?=
 =?utf-8?B?S2ZYdklYWERUYXZkSkZQZHhrMW5BNHlIM1hsdXVlai8xM09oV2VUOTBwNVpL?=
 =?utf-8?B?ekZqZnFXamtMQ0lZQXhGb0tLZmtJcm5mckticTJGZ0IyQVliOEpMZkdaeW9z?=
 =?utf-8?B?TDNDbGlHRlRKTG0rczFEa2NNNTZLSVBlUE1uL1NId0VEUzN6N0NUWm13N09G?=
 =?utf-8?B?SWV5OUNhUGZUL3VEYkZrbE5obDh5c2lTSUVYRWlHV3NnOUprUmtPSXNLcU9Y?=
 =?utf-8?B?N3h4VHF0Y0VuYlU0RVVmUUFpOGw5eDhDdXVJTmJieW85Nm4rcFE1QTVSN0lw?=
 =?utf-8?B?bmRwQnpuaXJya2VNSW12M1I1bkZGYnZLbjAzcllaanNrM1VjSkhiL1dqaUhv?=
 =?utf-8?B?Sy9vdlc2WW4wWEhLM0hQbndocGtmVTdPakZNZVM0M000aWdLWGpNVWJTNmZn?=
 =?utf-8?B?MjhVQXplRmtlMUtMenpQK00rc3Y4ekh5U29yZkNYK1NHQmhRNmtOajhZRHB0?=
 =?utf-8?B?Z0VRTzROOG5jd2dqeXl2RThHdDFtMlRPSk5jMEg4Tk5ieHN5MmdPdGd2N1Jy?=
 =?utf-8?B?TWtRaTcxY3NXNDFFeTdCcGxqWUQrZ3FrekJNZmxxOVFsdGZnRXZTcXgwZzB3?=
 =?utf-8?B?RUxqU3NQNW51bzJmRW9HTGQyMW5oNUtwZDlvM0FsdlVJTXNXWXNuNkg2bzZX?=
 =?utf-8?B?U21laW5hU2FJM3Y4c0w4YnVVdEtFMk9KN2FwdWtsSGxxdk5GWlAvOWZLTTdK?=
 =?utf-8?B?WmY3aGt2cFVIS2hRRFoyTWI2S2ZLOUlIdFVMcVZJQnFwcnBTdC8yajExODBh?=
 =?utf-8?B?dXIwanEzNGpqK01JKzB5SUVqV3Y1QThDMW1jMFVOUFYvZEFyN0hlOXJ6UWFq?=
 =?utf-8?B?ekJHVG81bUtrNXFiTExuVXJMbVMwUXFFN0xOYmc4NWdrbitKRzUrdHBVclR5?=
 =?utf-8?B?N1Fsb29qYVNYa0dMRXJVakJYMm9reEl2dHVwckNiOC80YTFPNVM4SExPcE1q?=
 =?utf-8?B?VDhSY094cjh6Mnd0c3ltaW5WY215U0V6WnJhT3pnNzVUbWp6MEdpU3BiN1Nr?=
 =?utf-8?B?b05RN3JEQVJ0UFZ3b2FWT1duNkhGcXlJdlJaSFRHU1c4SDNpcHpVaTdOTEwz?=
 =?utf-8?B?bHo4NVBZSlFobWNuU01HRzhyVnU0b3ZoTWJWWnNsY0R1a0ZCeHpnL1EwQ045?=
 =?utf-8?B?Z3BDYWh2SC90OVZDWldPaWlMRDVOejBzOExvT3FCb1BNdWdFVWxRVWYwR0VI?=
 =?utf-8?B?T05GRGVxYTZVanUyRkhUWGJvK2xTYlBNMUQ5bWlENVA0NDdIUmJCTk15VWhF?=
 =?utf-8?B?bzlzM3dsWFVkZWpkTitmMkJBSXpuOVBpZUNEUnJCNXVlM1pTWlYxeFg2WGFl?=
 =?utf-8?B?cG55ZkVnSzJOeWxTeTZyK01jUEFOK3hkelorMk44YlM3QVRUSUUyUzRGMTFB?=
 =?utf-8?B?MXl0STIyL3RLNlZYV29ZRTJkQW4vMzlPRUVFVkNEaHN1RVNmbThnR2xDV0dS?=
 =?utf-8?B?L1h1OGl1eDZtNml4bVVHZ0xMazJ0ZURxTzJoODFLUFN4dkJIbTFKekpkc1VK?=
 =?utf-8?B?RWhteWFEd2E1bjhuR2RsVHVEY3RNTGtBNmlBUHdyTjZsQ0dhaUk1c25IY1hk?=
 =?utf-8?B?Y2s1M3MwRm03RTBueVdwT3FKV1MxNEtTQVJldWw3dVgrR2lQKzRVSTV6d2Fk?=
 =?utf-8?B?VkNMeVd2OWUvZU9vbi9OZWVNaFJ5bXkwblB3VWJSMThJYXdqenNnMC9FY3po?=
 =?utf-8?B?ckVwdDE0akdYYW1OOVo1Z3QyRFQ4Qm9JOW9UU1hmS0JKUjdCbGMrMStQeGhC?=
 =?utf-8?B?dW16RWo1SWZjVTVmWVJvWUlna2UzTXllU0ZRSG1PUmtDR1lZMy9WSXFjb2s3?=
 =?utf-8?B?RDhyTHY5ck5DaVJwNExwOXRxNHlVREZqKzBPQlRhdWordFdudjdBRjgzQ1Za?=
 =?utf-8?B?R1lVNTR0SWphcDlQbDZiNk1mL0dkUGZsZUhrNHdRTDU1TFlVeW9YSkF6T2RM?=
 =?utf-8?Q?vWICFuAGvFY8alh83yBrL6OyD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2f27df-f4e6-4ac0-e7a4-08dc94442ebd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 11:52:54.5168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9GFwOx0WSfCvtO8iINPoWTiabrHg/bQutlKkOGiK8j3WaBpKvn8ABYD/Pb96m4m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614
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

Am 24.06.24 um 11:56 schrieb Jian, Jane:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Christian,
> The reason that why I moved around amdgpu_asic_funcs because the new function that I declared in amdgpu_asic_funcs used the enum amd_hw_ip_block_type, therefore I move it after the definition of the amd_hw_ip_block_type.

Please don't do that in the first place. This looks like quite a hack to 
me and shouldn't be implemented this way.

If the KIQ is only able to access it's local XCD it needs to be handled 
in the KIQs read, write and read/write functions.

Regards,
Christian.

>
> Thanks,
> Jane
>
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Monday, June 24, 2024 5:35 PM
> To: Jian, Jane <Jane.Jian@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: normalize registers as local xcc to read/write under sriov in TLB flush
>
> Am 24.06.24 um 11:13 schrieb Jane Jian:
>> [WHY]
>> sriov has the higher bit violation when flushing tlb
>>
>> [HOW]
>> normalize the registers to keep lower 16-bit(dword aligned) to aviod
>> higher bit violation RLCG will mask xcd out and always assume it's
>> accessing its own xcd
>>
>> [TODO]
>> later will add the normalization in sriovw/rreg after fixing bugs
>>
>> v2
>> rename the normalized macro, add ip block type for further use move
>> asics func declaration after ip block type since new func refers ip
>> block type add normalization in emit flush tlb as well
>>
>> v3
>> declare the new func in the asic specific header
>>
>> Signed-off-by: Jane Jian <Jane.Jian@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 112 +++++++++++----------
>>    drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c |  17 ++++
>>    drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h |  28 ++++++
>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  32 ++++--
>>    drivers/gpu/drm/amd/amdgpu/soc15.c         |   2 +
>>    drivers/gpu/drm/amd/amdgpu/soc15_common.h  |   5 +-
>>    6 files changed, 130 insertions(+), 66 deletions(-)
>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 083f353cff6e..070fd9e601fe 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -583,61 +583,6 @@ struct amdgpu_video_codecs {
>>        const struct amdgpu_video_codec_info *codec_array;
>>    };
>>
>> -/*
>> - * ASIC specific functions.
>> - */
>> -struct amdgpu_asic_funcs {
>> -     bool (*read_disabled_bios)(struct amdgpu_device *adev);
>> -     bool (*read_bios_from_rom)(struct amdgpu_device *adev,
>> -                                u8 *bios, u32 length_bytes);
>> -     int (*read_register)(struct amdgpu_device *adev, u32 se_num,
>> -                          u32 sh_num, u32 reg_offset, u32 *value);
>> -     void (*set_vga_state)(struct amdgpu_device *adev, bool state);
>> -     int (*reset)(struct amdgpu_device *adev);
>> -     enum amd_reset_method (*reset_method)(struct amdgpu_device *adev);
>> -     /* get the reference clock */
>> -     u32 (*get_xclk)(struct amdgpu_device *adev);
>> -     /* MM block clocks */
>> -     int (*set_uvd_clocks)(struct amdgpu_device *adev, u32 vclk, u32 dclk);
>> -     int (*set_vce_clocks)(struct amdgpu_device *adev, u32 evclk, u32 ecclk);
>> -     /* static power management */
>> -     int (*get_pcie_lanes)(struct amdgpu_device *adev);
>> -     void (*set_pcie_lanes)(struct amdgpu_device *adev, int lanes);
>> -     /* get config memsize register */
>> -     u32 (*get_config_memsize)(struct amdgpu_device *adev);
>> -     /* flush hdp write queue */
>> -     void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
>> -     /* invalidate hdp read cache */
>> -     void (*invalidate_hdp)(struct amdgpu_device *adev,
>> -                            struct amdgpu_ring *ring);
>> -     /* check if the asic needs a full reset of if soft reset will work */
>> -     bool (*need_full_reset)(struct amdgpu_device *adev);
>> -     /* initialize doorbell layout for specific asic*/
>> -     void (*init_doorbell_index)(struct amdgpu_device *adev);
>> -     /* PCIe bandwidth usage */
>> -     void (*get_pcie_usage)(struct amdgpu_device *adev, uint64_t *count0,
>> -                            uint64_t *count1);
>> -     /* do we need to reset the asic at init time (e.g., kexec) */
>> -     bool (*need_reset_on_init)(struct amdgpu_device *adev);
>> -     /* PCIe replay counter */
>> -     uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
>> -     /* device supports BACO */
>> -     int (*supports_baco)(struct amdgpu_device *adev);
>> -     /* pre asic_init quirks */
>> -     void (*pre_asic_init)(struct amdgpu_device *adev);
>> -     /* enter/exit umd stable pstate */
>> -     int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
>> -     /* query video codecs */
>> -     int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
>> -                               const struct amdgpu_video_codecs **codecs);
>> -     /* encode "> 32bits" smn addressing */
>> -     u64 (*encode_ext_smn_addressing)(int ext_id);
>> -
>> -     ssize_t (*get_reg_state)(struct amdgpu_device *adev,
>> -                              enum amdgpu_reg_state reg_state, void *buf,
>> -                              size_t max_size);
>> -};
>> -
>>    /*
>>     * IOCTL.
>>     */
>> @@ -728,6 +673,63 @@ enum amd_hw_ip_block_type {
>>        MAX_HWIP
>>    };
>>
>> +/*
>> + * ASIC specific functions.
>> + */
>> +struct amdgpu_asic_funcs {
>> +     bool (*read_disabled_bios)(struct amdgpu_device *adev);
>> +     bool (*read_bios_from_rom)(struct amdgpu_device *adev,
>> +                                u8 *bios, u32 length_bytes);
>> +     int (*read_register)(struct amdgpu_device *adev, u32 se_num,
>> +                          u32 sh_num, u32 reg_offset, u32 *value);
>> +     void (*set_vga_state)(struct amdgpu_device *adev, bool state);
>> +     int (*reset)(struct amdgpu_device *adev);
>> +     enum amd_reset_method (*reset_method)(struct amdgpu_device *adev);
>> +     /* get the reference clock */
>> +     u32 (*get_xclk)(struct amdgpu_device *adev);
>> +     /* MM block clocks */
>> +     int (*set_uvd_clocks)(struct amdgpu_device *adev, u32 vclk, u32 dclk);
>> +     int (*set_vce_clocks)(struct amdgpu_device *adev, u32 evclk, u32 ecclk);
>> +     /* static power management */
>> +     int (*get_pcie_lanes)(struct amdgpu_device *adev);
>> +     void (*set_pcie_lanes)(struct amdgpu_device *adev, int lanes);
>> +     /* get config memsize register */
>> +     u32 (*get_config_memsize)(struct amdgpu_device *adev);
>> +     /* flush hdp write queue */
>> +     void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
>> +     /* invalidate hdp read cache */
>> +     void (*invalidate_hdp)(struct amdgpu_device *adev,
>> +                            struct amdgpu_ring *ring);
>> +     /* check if the asic needs a full reset of if soft reset will work */
>> +     bool (*need_full_reset)(struct amdgpu_device *adev);
>> +     /* initialize doorbell layout for specific asic*/
>> +     void (*init_doorbell_index)(struct amdgpu_device *adev);
>> +     /* PCIe bandwidth usage */
>> +     void (*get_pcie_usage)(struct amdgpu_device *adev, uint64_t *count0,
>> +                            uint64_t *count1);
>> +     /* do we need to reset the asic at init time (e.g., kexec) */
>> +     bool (*need_reset_on_init)(struct amdgpu_device *adev);
>> +     /* PCIe replay counter */
>> +     uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
>> +     /* device supports BACO */
>> +     int (*supports_baco)(struct amdgpu_device *adev);
>> +     /* pre asic_init quirks */
>> +     void (*pre_asic_init)(struct amdgpu_device *adev);
>> +     /* enter/exit umd stable pstate */
>> +     int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
>> +     /* query video codecs */
>> +     int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
>> +                               const struct amdgpu_video_codecs **codecs);
>> +     /* encode "> 32bits" smn addressing */
>> +     u64 (*encode_ext_smn_addressing)(int ext_id);
>> +
>> +     ssize_t (*get_reg_state)(struct amdgpu_device *adev,
>> +                              enum amdgpu_reg_state reg_state, void *buf,
>> +                              size_t max_size);
>> +     /* normalize offset to keep in lower 16-bit */
>> +     u32 (*normalize_reg_offset)(enum amd_hw_ip_block_type hwip, u32
>> +offset); };
>> +
> Why are you moving this definition around?
>
> Regards,
> Christian.
>
>>    #define HWIP_MAX_INSTANCE   44
>>
>>    #define HW_ID_MAX           300
>> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> index 2c9a0aa41e2d..7cdd4b9d08ba 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> @@ -29,6 +29,7 @@
>>    #include "gfx_v9_4_3.h"
>>    #include "gfxhub_v1_2.h"
>>    #include "sdma_v4_4_2.h"
>> +#include "aqua_vanjaram.h"
>>
>>    #define XCP_INST_MASK(num_inst, xcp_id)                                        \
>>        (num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0) @@
>> -1085,3 +1086,19 @@ ssize_t aqua_vanjaram_get_reg_state(struct
>> amdgpu_device *adev,
>>
>>        return size;
>>    }
>> +
>> +u32 aqua_vanjaram_normalize_reg_offset(enum amd_hw_ip_block_type
>> +hwip, u32 offset) {
>> +     u32 normalized_offset;
>> +
>> +     switch (hwip) {
>> +     case GC_HWIP:
>> +             normalized_offset = offset & 0xffff;
>> +             break;
>> +     default:
>> +             normalized_offset = offset;
>> +             break;
>> +     }
>> +
>> +     return normalized_offset;
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h
>> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h
>> new file mode 100644
>> index 000000000000..8d1b7a89cb71
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h
>> @@ -0,0 +1,28 @@
>> +/*
>> + * Copyright 2024 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person
>> +obtaining a
>> + * copy of this software and associated documentation files (the
>> +"Software"),
>> + * to deal in the Software without restriction, including without
>> +limitation
>> + * the rights to use, copy, modify, merge, publish, distribute,
>> +sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom
>> +the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> +included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> +EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> +MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
>> +SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>> +DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>> +OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
>> +OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +#ifndef __AQUA_VANJARAM_H__
>> +#define __AQUA_VANJARAM_H__
>> +
>> +u32 aqua_vanjaram_normalize_reg_offset(enum amd_hw_ip_block_type
>> +hwip, u32 offset);
>> +
>> +#endif
>> \ No newline at end of file
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 88b4644f8e96..19e4429db37c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -853,8 +853,12 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>         */
>>        if (adev->gfx.kiq[inst].ring.sched.ready &&
>>            (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
>> -             uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
>> -             uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>> +
>> +             /* Select lower 16 bits to write in local xcc */
>> +             if (AMDGPU_IS_GFXHUB(vmhub)) {
>> +                     req = NORMALIZE_XCC_REG_OFFSET(req);
>> +                     ack = NORMALIZE_XCC_REG_OFFSET(ack);
>> +             }
>>
>>                amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
>>                                                 1 << vmid, inst);
>> @@ -979,6 +983,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>>        struct amdgpu_vmhub *hub = &adev->vmhub[ring->vm_hub];
>>        uint32_t req = gmc_v9_0_get_invalidate_req(vmid, 0);
>>        unsigned int eng = ring->vm_inv_eng;
>> +     u32 low_distance, high_distance, req_offset, ack;
>>
>>        /*
>>         * It may lose gpuvm invalidate acknowldege state across
>> power-gating @@ -986,7 +991,18 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>>         * release after invalidation to avoid entering power gated state
>>         * to WA the Issue
>>         */
>> +     low_distance = hub->ctx0_ptb_addr_lo32 + (hub->ctx_addr_distance * vmid);
>> +     high_distance = hub->ctx0_ptb_addr_hi32 + (hub->ctx_addr_distance * vmid);
>> +     req_offset = hub->vm_inv_eng0_req + hub->eng_distance * eng;
>> +     ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>>
>> +     /* Select lower 16 bits to write in local xcc */
>> +     if (AMDGPU_IS_GFXHUB(ring->vm_hub)) {
>> +             low_distance = NORMALIZE_XCC_REG_OFFSET(low_distance);
>> +             high_distance = NORMALIZE_XCC_REG_OFFSET(high_distance);
>> +             req_offset = NORMALIZE_XCC_REG_OFFSET(req_offset);
>> +             ack = NORMALIZE_XCC_REG_OFFSET(ack);
>> +     }
>>        /* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
>>        if (use_semaphore)
>>                /* a read return value of 1 means semaphore acuqire */ @@ -994,18
>> +1010,14 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>>                                          hub->vm_inv_eng0_sem +
>>                                          hub->eng_distance * eng, 0x1, 0x1);
>>
>> -     amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
>> -                           (hub->ctx_addr_distance * vmid),
>> +     amdgpu_ring_emit_wreg(ring, low_distance,
>>                              lower_32_bits(pd_addr));
>>
>> -     amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
>> -                           (hub->ctx_addr_distance * vmid),
>> +     amdgpu_ring_emit_wreg(ring, high_distance,
>>                              upper_32_bits(pd_addr));
>>
>> -     amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
>> -                                         hub->eng_distance * eng,
>> -                                         hub->vm_inv_eng0_ack +
>> -                                         hub->eng_distance * eng,
>> +     amdgpu_ring_emit_reg_write_reg_wait(ring, req_offset,
>> +                                         ack,
>>                                            req, 1 << vmid);
>>
>>        /* TODO: It needs to continue working on debugging with semaphore
>> for GFXHUB as well. */ diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> index 8d16dacdc172..3a1fa2797f02 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> @@ -78,6 +78,7 @@
>>    #include "mxgpu_ai.h"
>>    #include "amdgpu_ras.h"
>>    #include "amdgpu_xgmi.h"
>> +#include "aqua_vanjaram.h"
>>    #include <uapi/linux/kfd_ioctl.h>
>>
>>    #define mmMP0_MISC_CGTT_CTRL0                                                                   0x01b9
>> @@ -927,6 +928,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
>>        .query_video_codecs = &soc15_query_video_codecs,
>>        .encode_ext_smn_addressing = &aqua_vanjaram_encode_ext_smn_addressing,
>>        .get_reg_state = &aqua_vanjaram_get_reg_state,
>> +     .normalize_reg_offset = &aqua_vanjaram_normalize_reg_offset,
>>    };
>>
>>    static int soc15_common_early_init(void *handle) diff --git
>> a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
>> b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
>> index 242b24f73c17..01afd1a24e8b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
>> @@ -210,4 +210,7 @@
>>    #define WREG64_MCA(ext, mca_base, idx, val) \
>>        WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) +
>> mca_base + (idx * 8), val)
>>
>> -#endif
>> +#define NORMALIZE_XCC_REG_OFFSET(offset) \
>> +     ((amdgpu_sriov_vf(adev) && adev->asic_funcs->normalize_reg_offset) ? \
>> +     adev->asic_funcs->normalize_reg_offset(GC_HWIP, offset) : offset)
>> +#endif
>> \ No newline at end of file

