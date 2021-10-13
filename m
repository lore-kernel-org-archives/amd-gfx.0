Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3800C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 04:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A243660238
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 04:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A243660238
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 452CB6E081;
	Wed, 13 Oct 2021 04:14:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66A4F6E081
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 04:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3RSoDdNtrtma5tEJ+Oazc0zpEFaZY2qcvtblNJ1ik507yQiqmf3Z/RZtbnxYuKIns+NtXhzTaz4T8OgVA99dkt3vwVkYrezGTEIrwdjBbaJ00JKxDRZfcqX2sZv+BfJ7Vq5ni5soJOvNVKroUEFHtO4+OL82ayKCYXjN4JzpUS7N8HyI8/T0iol3UWoSTrrN8oJHVO9CHikvL5ikOZrBBLBsNbpVp8SWy/Bv36el6s7/V32BtVqSyF1Jg97SUC6pEAODa+f54OJKkePMJh/zulDQdk0lmYm0ywmXuAMg01cNGgG5M5xCJsxRXdSECVS/qbCFYQCVut/c8GhPJ1e9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZYksnVH98IGoNbcHfsPeKSoOzKI6ZuraAyhmv9r0v8=;
 b=EwxOvGPhPUswMJhkyAbmdBpDc66vrSG+KOcCgK5f4Fso/RLoQv9ZvxAKM1Bjc8nNBjmxyihHq7H/Pq8gsPBSHDQEBdj5gfVNexm67AWgUSjFD/ElF5b2LtJAz80okCbMV833vWkUNLXfthdnjQiQ1yYe44rd4CJZXnVUxU+wa7Cn1TIAMGTudg79RsmQrFt8Ot+gACNYuKMc9PrVNHPx/NNfDmBt8IUp3G2U2J0lTAEdAjk20hzM1GNz/EN1J9ZKK30Otu8JxWNq584fazhTYQfapVKLyLtaBCbpMAqS/+iZgPXZAQ+v7BRBUWJjrWT/suJ67/ovzru5ZUJGiEt3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZYksnVH98IGoNbcHfsPeKSoOzKI6ZuraAyhmv9r0v8=;
 b=p/oQsXyllTbcHdns8b8tVN6Ehsy+bbhswbsrUE8hdIG4z4/epRY6KJyDxtdB+dr/1FOpG+BpdLxlHzfRSzFhwrsNq1Vz+hnsTjEjJX75iyugziyvkh0ykjvtxZUE7TB5xA9z15IxwAw9tcpezdi4jzLDjU+rF32KrJ8wzhAVMAQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (10.255.174.19) by
 DM5PR12MB2584.namprd12.prod.outlook.com (52.132.139.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.22; Wed, 13 Oct 2021 04:14:27 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 04:14:27 +0000
Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <Alexander.Deucher@amd.com>
References: <20211013031042.53540-1-luben.tuikov@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <858da53c-7937-3ebf-360d-f20f30f825d9@amd.com>
Date: Wed, 13 Oct 2021 09:44:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211013031042.53540-1-luben.tuikov@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::34) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0119.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:27::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25 via Frontend Transport; Wed, 13 Oct 2021 04:14:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1273bc07-7d38-4428-4dce-08d98dfff200
X-MS-TrafficTypeDiagnostic: DM5PR12MB2584:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB25840932E5B0361C8C77903F97B79@DM5PR12MB2584.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ux1oiRDyRWCl2+N7u5LAw0D6OMLk1fiU3XW7OV0LVF9/scL8eyUmGQwR4oGlJkuni/32cl5NPt5h8UoP6chp3ZWZ1w9PWr3KuPgUSwh6BoymDwxoNSZGGEKCQ1mDyguOWSbqlB6LBUViv5yEK2TYTk7Lrrv/o/Q24aSC++La0AZTHmVpfVBR9q3w4xpzdt5K55OlsJtRwcwa4Mf0hNbSuhcx0DBXGotuWkTsT3NXgZNOHGVK/jxMZqzENukuOpO3thWjYqqGVSeyj6u7BqSKskiz5/tnLZe6VVWTaZTSmCWnGHXNCC+cn4BU/7wGhicT3PsIT4IGGM46Eiua/XeMaWvIusJMMzw7+qbxTrofBFLOiDWKv4Bw8APGb3ACwIskFsMxC7VJkaSKqc8W4jpZmGO8+RBsJkTnLeJR/zuG2b/50zZ9L/+wCQL/swhFBBvkoGp+P1cMSpcc5MMxqNfUN9YNh3XTReksqDCZzO0CpTz5/Id/SW4+PSYvqUukcvEbKvqr4CfmxHfHxkd0pcCd+KjopH3b2ly4KNeREIYeypIg3Y4ZoGXJZTWFkbtpc7sFdk9Z1X2ZMuFfpuSUstJwzRgv4Hr0dm037sp+bkLB9FOQxZaG9MWdOTDqhmQMEsF/dedXKZd4BD/E+VONqatW1u5NMbVBDb5EdZ+wmEQCn+nIJVemJZJXsHlbgskMvZID3m3Y/EskDAu7tppZlTLgmsKdtr0JE80NigLhv1WiO/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(8676002)(83380400001)(316002)(66476007)(66556008)(186003)(8936002)(31686004)(38100700002)(26005)(53546011)(16576012)(2906002)(36756003)(6486002)(86362001)(31696002)(956004)(508600001)(2616005)(6666004)(5660300002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0JXaEdmWkJ4dmhLdWxaRUxRaXlTWmdzTlEvY1JVM3ZCYXFiMEkyNmRldzFh?=
 =?utf-8?B?RmxBaWVuVTl1SnZCTzhTU095NGxjd1k3SnhENE1LZzhpT1k0RHhnRWQwb3h3?=
 =?utf-8?B?d3RZQ0RuQ2VnUmdHMm56a3VIVmZUUzRrR0lmTTRHcjNwM2R1alpzUWZIdjlo?=
 =?utf-8?B?R3ZoU1JGbE5zd2lYRzM5b1hlcFRJMGovczZwTkt2K2QzSi9rMll3RUNaekRC?=
 =?utf-8?B?YTMrR0dWczVxSEhuWVBWRUpsa3lMMGI0Mkt1M2xhTmloMVBqQ3JaRjdYTllj?=
 =?utf-8?B?U0ZDQXkvdStFb1ZITDVldDNWOHJWR25BNHBTTmlkdTVsY3B1S3FvWGg5MHNJ?=
 =?utf-8?B?MWtzZDgrWFNOVlpaRzk0RWU2Z0V5R1lrQ1NFMDhtRHBkZWxGY0V3VCtEekdW?=
 =?utf-8?B?aXk0TDM2Y2lnM0p3L0xobFBZR1NXU2htTFhtaStnRzNLRys1dDVYZzRzTDB3?=
 =?utf-8?B?TEs1UUVIa1dNK05yMVBvRG1sMHU4ZWxGQ3NhUHFzdEo3UlU0N2dnbksybW9X?=
 =?utf-8?B?NzFtaWpTV21nT2RvelNPTFhGOXp3L0lJcXdrNG4yaGlDNVQ1YURYUkFQaFZY?=
 =?utf-8?B?THc2MG9xZ1lGUzFuY2hSQ2JOamtYQ0UvM1Z0Z2ZEdkhwU3ZRdFFjWUFsQUlI?=
 =?utf-8?B?RTdIZkx6dVd3TGx3Qkl3KzhtY1Q0U1g0dEYxMFBrZFZSOVQycG95dDNLMFU5?=
 =?utf-8?B?MjhiUHpCVTI2bkZheGxXaFIxSTFQZzRpT0ovQ3VvQ1Y5MDNEanRyY1RqMmlQ?=
 =?utf-8?B?NGRCdm1XLzhBbVY2bEpNOUlnYmJaUHRpUmdybS9nZGdKNmg5OE9RaXUzaGc2?=
 =?utf-8?B?Rk11S0FlRTZqMTFrTkVra2FyMmMwUktFN3hmU3p6OVU3WFhxVmpDY1VvRnlm?=
 =?utf-8?B?c2FacGdjazExNUZZc2l1WWx5aXQ2UUFPTkVjWC9LNERUcmdteE91YkYwWEZ6?=
 =?utf-8?B?eGsrSkVMbTZXc21QNkRIa09PMDRrQzA4R2xSOFZZZnl2U29Cd2E0U0lYQnEw?=
 =?utf-8?B?TkxqakFhakFvUVdUbHFJeW1RQzZ1TDlUMlpYeG9HdVhlWXV1K00vZFlyWlRE?=
 =?utf-8?B?ZGNhS0pMN2FuTEpUTEVhb05naWE4SXNPd2c2VDYxc21pckU0aWZiK2JhSW5I?=
 =?utf-8?B?NjFOVDJEVERBdVk5ZUI4N095eWdFcEZjY29PbEQ2bmc0aDROUlNpT1N2RERp?=
 =?utf-8?B?V3lhd0Q5ZWVvdFFUeDBqTzNZVmpDMmxKUGNUcFc4N3RrdW02ZEhNOWd0SzFM?=
 =?utf-8?B?L2hSZW13SFRxenloYjhKL0JXaVhMWjFPaWR3aEVXWnViSE1HRFZjLzdvclB6?=
 =?utf-8?B?Nk9ZNXFqd2VuVUFPRjdSaHNLeUhTamtsUi9UazVlZkpMd1RiZ3laa1d3UDlr?=
 =?utf-8?B?ZG9PREVLMUtBcWtKYUxOL0loNXU0eXNtaHRaU1pPUUpmZG8xWjMvSjVyRTZn?=
 =?utf-8?B?Qk92MkFxQTIreEZ5NTl6UmFZTXVUbjVoam0yTkg5VmYySWVDbFMzQy9JYkxD?=
 =?utf-8?B?UitlMWJpRzdCSGlYK3hTTnVPSUdGTGtIT3o3M2FWMEFySStBTkpVd3VzUEtL?=
 =?utf-8?B?V1hYSkMvTUs4b3Zhb0FjS1lrbDZFb3F0SzZ2ZmM1KzJKUS9wSTFmZXRCeExx?=
 =?utf-8?B?a24wK1BnWjFwTlFLNzNJMTVoYUtQWDhZK1dEN29ibHRxUTJGUFI2UVhCNDhi?=
 =?utf-8?B?eUVMRXZUanZNdm5saEZ5aDhxbWJrNWwyZWFJc0JnZDhFTnpjQUxTcjYvL2Q0?=
 =?utf-8?Q?ScpzeKFiVBwnrVr1tt8v1a1i+tYoJsTqu6/e4u0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1273bc07-7d38-4428-4dce-08d98dfff200
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 04:14:26.9257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UP3B0jKhr0HJ1qDXSr3O15rbtuXVhW5uJo7Eb9Z7iqjfEKSdmBgNLzIQqrCS8LAm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2584
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



On 10/13/2021 8:40 AM, Luben Tuikov wrote:
> Some ASIC support low-power functionality for the whole ASIC or just
> an IP block. When in such low-power mode, some sysfs interfaces would
> report a frequency of 0, e.g.,
> 
> $cat /sys/class/drm/card0/device/pp_dpm_sclk
> 0: 500Mhz
> 1: 0Mhz *
> 2: 2200Mhz
> $_
> 
> An operating frequency of 0 MHz doesn't make sense, and this interface
> is designed to report only operating clock frequencies, i.e. non-zero,
> and possibly the current one.
> 
> When in this low-power state, round to the smallest
> operating frequency, for this interface, as follows,
> 

Would rather avoid this -

1) It is manipulating FW reported value. If at all there is an uncaught 
issue in FW reporting of frequency values, that is masked here.
2) Otherwise, if 0MHz is described as GFX power gated case, this 
provides a convenient interface to check if GFX is power gated.

If seeing a '0' is not pleasing, consider changing to something like
	"NA" - not available (frequency cannot be fetched at the moment).

Thanks,
Lijo

> $cat /sys/class/drm/card0/device/pp_dpm_sclk
> 0: 500Mhz *
> 1: 2200Mhz
> $_
> 
> Luben Tuikov (5):
>    drm/amd/pm: Slight function rename
>    drm/amd/pm: Rename cur_value to curr_value
>    drm/amd/pm: Rename freq_values --> freq_value
>    dpm/amd/pm: Sienna: 0 MHz is not a current clock frequency
>    dpm/amd/pm: Navi10: 0 MHz is not a current clock frequency
> 
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 60 +++++++++------
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 73 ++++++++++++-------
>   2 files changed, 86 insertions(+), 47 deletions(-)
> 
