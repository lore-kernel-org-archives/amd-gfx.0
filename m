Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF29C531D0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 14:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 233AD10E3F2;
	Mon, 27 Jul 2026 14:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YdW27TSs";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011047.outbound.protection.outlook.com
 [40.93.194.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A02F310E3F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 14:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAqB0lOmuOfTw/+o1M64q32/+xXrOFIbMX5VY87bY1Wy5afzDu1tYS0PAVQBlkzRdWLTeIFFIihUjTz7KuK1/ofzoJ1PiT5x7lD7+iyL0sltOItCIvl/XxwDplSdVnfGxDV9Sxu4djdB8nOyllksE7onj4bRkcQktpEJlT+QDqGu3h84eDndDwwc/+ADtvk4UBzy7lf3gpUpo4K+0pg4in3kD6+cXoKeNYUWW3g5BhHWRQygSJLQvgKOIOWZoCHXiJt2AcsIJ9m+tiwxgQ6PntGESGTxQF3AswJL68K4hRUm1JGEGm5L8/B6y6H5MLpvWP+ejIE9RiCd11pdI/I1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAQfDNWqUjbpaLBpK+6FdMOVrWbqBqJ7I5wtn41rO1w=;
 b=ajFuzb4sCSjShd+lQma/fm0L9lIQ3atl3g7NDg6uB4NtQQ5P1TT+kcM9a6sqkfazUsbv9K9faOkWrEdy6moFR8pOemL+xtNFcHF4LwLoSgF8S/p7HXtZzb97IocyzQB3fITtTkhAi+I9TcAku3y6LHflSefvN/2SVdt2zDIYnPXFNV5Ycur0nq4xA67nA1Rw0ubNFioaoO3Rdp3HIce6WvyU0yYM+j0sIoslLi/k9asAKY6JlORYKOvRBzEKmF3Qb+Vl/SAwrl5wxLK5JM2Oyk+iEOSfbX97zAIU3dJ27W1gB46T3ArA+EpgN4h4bn0LJkzCDzu0QMMTUad8/mKBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAQfDNWqUjbpaLBpK+6FdMOVrWbqBqJ7I5wtn41rO1w=;
 b=YdW27TSsRHMMD0P2qlDashvBVmK96w36qCQ60Do0NYWSMGqQaoQ8IWp8WlbDpqFyPUH1n1oJUEXvUHySAKi1dqYxeaMyO2xbkcIkZrROIfuW8XoSE2X5T8bJUuBqtHYh71Gfe5+/S6g/q84PrArU5uFBS8ORdoS8g6sJCzHQPIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:31:36 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:31:36 +0000
Message-ID: <16739ad8-d49a-42a7-8cb0-cc7e01bc8c38@amd.com>
Date: Mon, 27 Jul 2026 20:01:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] drm/amd/pm/smu15: switch SMU v15.0.0 to DRAM-based
 accumulator metrics
To: "Milind Sardeshpande, Shubhankar" <Shubhankar.MilindSardeshpande@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Shubhankar.MilindsSardeshpande@amd.com"
 <Shubhankar.MilindsSardeshpande@amd.com>,
 "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>,
 "Guttula, Suresh" <Suresh.Guttula@amd.com>,
 "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
References: <20260727105020.3974047-1-Shubhankar.MilindSardeshpande@amd.com>
 <20260727105020.3974047-2-Shubhankar.MilindSardeshpande@amd.com>
 <4fe4d572-c3ba-4402-9d7b-fc7a3f36b907@amd.com>
 <PH7PR12MB81050E563EA4C632EB079DBFEFCC2@PH7PR12MB8105.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH7PR12MB81050E563EA4C632EB079DBFEFCC2@PH7PR12MB8105.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:266::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 901f403f-f130-4bb3-c337-08deebebc30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|56012099006|4143699003|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: xWeWUfPQK7uTrp6MbtwnO+OpB/eUaQvfNqHwWW8KCfdRsGz8lsn3Kx0x3To7tgSRDPT0NqfUpgwHGuVMPr3ga9aZejprlGlGfaTMaaQJRY4/woKLTNnr1YYJ5gBNxHjXaYHGIO4ro1ELiETpbKTXIwl6XPbAPPdp5HGLQm4lZwppozcGyyHyxnEB3tTONQULUYjLpal5rms78ndvAYEGn5L19Jv4urBOJ2ClEcqhqPCpggjEvj7GOLza/dRkLuoxbnPIItgqw68V3drQPJnET7yyEPIxhVmnsGiR4mFiQav+QxarBgW8lefAegUzcwW9ggPvKy1tTa6dPKnPyXzyJcf6tpjMgPcsL8yanRFHF4oW587AwhHtlWyP5NQ7CSTwejTTa8PvnTZtBjh0bgoQOABaQaRPzRD+/7ryikb0yJa2/dXDwAQwWZF1Kzp7wvik/v2/1lWlsLbFViPAtKCcPbJy7/y3ncJlfjBeCzRORuDAYEAgVgNd2us1wvx3mDgVE/Mfy0jFJbkDoeT9qbg8oBU/XDOycCXGMqu0iTzhpCB92Hk1HxdL6c8Q2gW6lM3fdVcpAKs62Lev+qKUGgTR4sBmM7+1dHpKCjsNOefpadHdnZCrFwaDzGKri+/PlDn+OFIwij2YrQtPRCK1N64yZGFIVMXbSv4O9imb9jSFXDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVJwaGtzMlVFZitEZDZ6TmV3Umpkam5kSHd2REZEWDBMdnBkWHZZT1VhdXRq?=
 =?utf-8?B?emZzdmV3aUVjVlI1ZDNDS3kycW93YXJmME03QUQ5Y0FaS1VWZ04zbHBzMUVB?=
 =?utf-8?B?TlJ0c0RmbFZ2NkZ0SUNkZlJUZzF5VmJ0MnNOZHRaUXZjeG9QUkpZSW56b1RF?=
 =?utf-8?B?dUR0RDRqcCtSYmFDZUhKZzZwRUZjY240REkxeWxjYTI5VHhJN0tCL1lKRXhH?=
 =?utf-8?B?cndJMWY1dlZFTkZRa2sxSllta3BralNDMTVXT3BLVkFFOERLKzNRZFpPdXJu?=
 =?utf-8?B?YWkveEQxNmc4em8wdnBHTVk0b040Q0x0TDY2QmwxejZtZTBHOXlzNExTMVNP?=
 =?utf-8?B?N2k1ditoeW0yZ09RNUpRZWZoWUh5d0xrOTA2a3RqSklETDBWSURjSmtQeHIv?=
 =?utf-8?B?UDhJVEIxMnkrTkJmUU13U3B6Vkhwam9wd2FLK1J5dzE4V3I4eUZ3LzluNERj?=
 =?utf-8?B?NFZ0MzlwYU0vNDFhNnlEdkxHVlNYdUlvUEJxMmpOZUdZbC9JZFkyZXBCeWMx?=
 =?utf-8?B?c3VjUFdoZWRuNmFETlVpWEUxeFRWZXJtQlhyVDZpRHZPeDNsOTkwVEx0YXpm?=
 =?utf-8?B?ZUtWS1ByZmtKWVRrZGRZSHhrd2E3bHYwUXZXTlpHbEFTc1ArT3IyU2hqQUhp?=
 =?utf-8?B?THNOdzlQTFZybUdmUmtrYXkvdTBVVnd5cUdJZWJYQXFvQ0Z1ay9BM1U1VHE5?=
 =?utf-8?B?VmhuYzRIcmRVc1p2VGtpY0pKRnZaOHpLbUh6dG42QmJtMCt0ZFRDdzRFVk1r?=
 =?utf-8?B?cktkeEdUOExqRThWNmN0akYydjUxaG9zNmQ0SXU3cjMvU3BPbEQ1WnBLelQv?=
 =?utf-8?B?dFhFZmRzRHZYaCtoRXR6cmZZZXhLTkF1WXh2TFNJMFI1MnJXRG1zRkMxTjhn?=
 =?utf-8?B?MFVya0xER0NXZnZXV2M5ZWxlQ2ZIM21hUDJTVjQ3YzRzL09ZbE5HUmJKbFVv?=
 =?utf-8?B?RVpKYlUvOEJZNlRSYlVTaVU2RnpadWdjYnFXS1ZrL1dlWlNmUkM0SXlhZGEy?=
 =?utf-8?B?MVd4dWg5WDlaVjRPd2QrL2xCZlVWZDhCSm03NXFyVU5hUmhYK2xkaEJpSUF6?=
 =?utf-8?B?WXNIcnpGQ3IvZXFNZ3RKTS9FOXduaVpHT25WMUxXWXZKL3l6ZXdHRjlkdTU1?=
 =?utf-8?B?RjAzeStaK2tRc0NleTlCQTRJUThualhTenprRTQ1b3RRVjFtdCtDcDF5anBE?=
 =?utf-8?B?MzQxNmVqVW5HQlhtV2hyYlN0SnpMZXRkNE13QXQrL2ZxbExHY2lDdWJ1KzJH?=
 =?utf-8?B?aEV0dnplMlh3N09jVkFLcU9pQzAxOEhoOFM2U1FJV1hvOWlWL2NMd2xWUnlY?=
 =?utf-8?B?c1IreHBlL2ticVNOV0Vhc1Y4enQxaXpPSTRpSEozYzJUUUFuelNaK2wwSGRk?=
 =?utf-8?B?S1Q1Q2RYYzBZWEF3ZGZKcjh6ZDFEblRiNXVMaWQwSmROT1BGcytXM2RaM3g3?=
 =?utf-8?B?KzZNY1Ywa1dSdzB2SjFjVHlSMGROTElSZU5MMGMreVl6SUZ0OWY4TVdzOXFP?=
 =?utf-8?B?SHJzblVQWVA5NTlPY0p0VEhBMCtETmF2VWtZbXZCRW9qbG0vZmJkU1F5dTMv?=
 =?utf-8?B?aGQ4RlpiTkVzSWtNQUhPUTI5S1dDcFQvaFlWclZqbDFGQnU1SkY5dlhmZnhy?=
 =?utf-8?B?ZWtUTWtuY2JnL1JJMzdyTXphc1A5ZlpaZCtBbnloVFRGK1N4bFg4UjZuY0pK?=
 =?utf-8?B?UmJpRm1HQ2g4bDBPaTdmSDhWK2FHQ2l6NGVNYUFEODNVQzdCcDRZNERkOVNt?=
 =?utf-8?B?U29tOWdoUk5jOWxLTlJUUzBaRVcrVWxBZTNJU2hlT1dtUVRnUGxUZHdwNm1t?=
 =?utf-8?B?N0pMWnMyUkthRHdFOXoxcnBtTTVnTG9VUFFOcDhXTFd1ZVo4T2wvMVNCWWc1?=
 =?utf-8?B?VEZ1b29TM28xNXl6eTNLbjQ1R1RxUlpPVlVERkFVR1Q5bkZaNC9XVkh2MkFH?=
 =?utf-8?B?b1ZRU2dLeFdBbDFvRGh1RlIzT1pBenVrb3U1cHNKcjRZeHZodjZ2ZHQ4ZEJN?=
 =?utf-8?B?SUgzWWpHUHl3ajUwVk9xTnViU0FvR1diY2Zobk1iM2NxS3YwK3RPdnNLaGlk?=
 =?utf-8?B?ZHhrTk1kRThaR0locXJTQXdQNkRmNWZJOHBTTlh1L0U0YjNnSk5YS3UzT29k?=
 =?utf-8?B?SUxjemhVaVBvQXc2TEpFQUUvSUd0WXpHWjQ0djNJK2tVVnJ4L3hsdk12U0R4?=
 =?utf-8?B?Yld2NTBTZnRucE1EOVNOVFNDalplYjNBSkt5M1VScWo0dzJhekVRdWNYdU1z?=
 =?utf-8?B?WHhIb0Z3OTJhc0NPeEVTaU1memRjZDdyWnVEeWZJUGNzYnJVQ1RkMjk1S0R0?=
 =?utf-8?B?S2JGcVNlZnFNd2xYaFZqekVFTjdkdHJhSlN6R0s2QWIxc2orR0RXdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901f403f-f130-4bb3-c337-08deebebc30c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:31:35.9491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGXg7m8twtsP1eiLPjQzNTA0/IOzh/awR+614RklweLmmK1GoQrUadVsDQxX0tGU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501
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



On 27-Jul-26 7:13 PM, Milind Sardeshpande, Shubhankar wrote:
> AMD General
> 
> 
> 
> 
> ------------------------------------------------------------------------
> *From:* Lazar, Lijo <Lijo.Lazar@amd.com>
> *Sent:* Monday, July 27, 2026 5:20 PM
> *To:* Milind Sardeshpande, Shubhankar 
> <Shubhankar.MilindSardeshpande@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Vishwakarma, Pratik 
> <Pratik.Vishwakarma@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org <amd- 
> gfx@lists.freedesktop.org>
> *Cc:* Shubhankar.MilindsSardeshpande@amd.com 
> <Shubhankar.MilindsSardeshpande@amd.com>; Gopalakrishnan, Veerabadhran 
> (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Guttula, Suresh 
> <Suresh.Guttula@amd.com>; Ramalingeswara Reddy, Kanala 
> <Kanala.RamalingeswaraReddy@amd.com>
> *Subject:* Re: [PATCH V4 2/2] drm/amd/pm/smu15: switch SMU v15.0.0 to 
> DRAM-based accumulator metrics
> 
> 
> 
> On 27-Jul-26 4:18 PM, Shubhankar Milind Sardeshpande wrote:
>  > Replace the legacy SMU table-copy metrics path with a DRAM-mapped,
>  > accumulator-based approach for SMU v15.0.0, using a ping-pong buffer
>  > to compute averaged metrics from deltas between consecutive samples.
>  >
>  > - Add GetMetricsTableVersion, GetMetricsTableLogSample and
>  >    GetMetricsTableLogDramAddr messages and their MSG_MAP entries.
>  > - Introduce SMU_15_0_0_MetricsInfo_t holding two MetricsTable_t
>  >    buffers, the mapped DRAM address, table size and pre-computed
>  >    avg_metric[] values.
>  > - Resolve and ioremap_wc() the firmware log DRAM address once in
>  >    init_smc_tables(); iounmap() it in fini_smc_tables().
>  > - Fetch samples into the inactive buffer, compute averaged clocks,
>  >    activity, power and temperature via wrapping_sub() accumulator
>  >    deltas, then swap the active index.
>  > - Rename the old get_metrics_table() to get_gpu_metrics_table() for
>  >    the gpu_metrics v3.0 export path.
>  > - Move AMDGPU_PP_SENSOR_SS_APU_SHARE, AMDGPU_PP_SENSOR_SS_DGPU_SHARE
>  >    to default case since they are not supported.
>  >
>  > Co-developed-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
>  > Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
>  > Co-developed-by: Suresh Guttula <Suresh.Guttula@amd.com>
>  > Signed-off-by: Suresh Guttula <Suresh.Guttula@amd.com>
>  > Co-developed-by: Kanala Ramalingeswara Reddy 
> <Kanala.RamalingeswaraReddy@amd.com>
>  > Signed-off-by: Kanala Ramalingeswara Reddy 
> <Kanala.RamalingeswaraReddy@amd.com>
>  > Signed-off-by: Shubhankar Milind Sardeshpande 
> <Shubhankar.MilindSardeshpande@amd.com>
> 
> Nit comment below. With that changed -
> 
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> 
> 
>  > ---
>  >   .../pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h  |   5 +-
>  >   drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +
>  >   .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 291 +++++++++++-------
>  >   .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h  |  13 +
>  >   4 files changed, 197 insertions(+), 115 deletions(-)
>  >
>  > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/ 
> smu_v15_0_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/ 
> smu_v15_0_0_ppsmc.h
>  > index bf216f83e689..9f627b5fef5b 100644
>  > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
>  > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
>  > @@ -100,7 +100,10 @@
>  >   #define PPSMC_MSG_DisableLSdma                  0x1F ///< Disable LSDMA
>  >   #define PPSMC_MSG_SetSoftMaxVpe                 0x20 ///<
>  >   #define PPSMC_MSG_SetSoftMinVpe                 0x21 ///<
>  > -#define PPSMC_Message_Count                     0x22 ///< Total 
> number of PPSMC messages
>  > +#define PPSMC_MSG_GetMetricsTableVersion        0x22
>  > +#define PPSMC_MSG_GetMetricsTableLogSample      0x23
>  > +#define PPSMC_MSG_GetMetricsTableLogDramAddr    0x24
>  > +#define PPSMC_Message_Count                     0x25 ///< Total 
> number of PPSMC messages
>  >   /** @}*/
>  >
>  >   /**
>  > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/ 
> gpu/drm/amd/pm/swsmu/inc/smu_types.h
>  > index acf03838d49d..d6675b4ee9be 100644
>  > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
>  > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
>  > @@ -297,6 +297,9 @@
>  >        __SMU_DUMMY_MAP(GetSmartShiftStatus), \
>  >        __SMU_DUMMY_MAP(EnableLSdma), \
>  >        __SMU_DUMMY_MAP(DisableLSdma), \
>  > +     __SMU_DUMMY_MAP(GetMetricsTableVersion), \
>  > +     __SMU_DUMMY_MAP(GetMetricsTableLogSample), \
>  > +     __SMU_DUMMY_MAP(GetMetricsTableLogDramAddr), \
>  >        __SMU_DUMMY_MAP(InitializeGfx), \
>  >        __SMU_DUMMY_MAP(SetSoftMaxFclk), \
>  >        __SMU_DUMMY_MAP(SetSoftMaxGl2clk), \
>  > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/ 
> drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
>  > index faa7d661f3bf..740bea549756 100644
>  > --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
>  > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
>  > @@ -33,6 +33,8 @@
>  >   #include "smu_v15_0_0_pmfw.h"
>  >   #include "smu_cmn.h"
>  >
>  > +#include <linux/overflow.h>
>  > +
>  >   /*
>  >    * DO NOT use these for err/warn/info/debug messages.
>  >    * Use dev_err, dev_warn, dev_info and dev_dbg instead.
>  > @@ -119,6 +121,9 @@ static struct cmn2asic_msg_mapping 
> smu_v15_0_0_message_map[SMU_MSG_MAX_COUNT] =
>  >        MSG_MAP(DisableLSdma,                   
> PPSMC_MSG_DisableLSdma,                         1),
>  >        MSG_MAP(SetSoftMaxVpe,                  
> PPSMC_MSG_SetSoftMaxVpe,                        1),
>  >        MSG_MAP(SetSoftMinVpe,                  
> PPSMC_MSG_SetSoftMinVpe,                        1),
>  > +     MSG_MAP(GetMetricsTableVersion,         
> PPSMC_MSG_GetMetricsTableVersion,               1),
>  > +     MSG_MAP(GetMetricsTableLogSample,       
> PPSMC_MSG_GetMetricsTableLogSample,             1),
>  > +     MSG_MAP(GetMetricsTableLogDramAddr,     
> PPSMC_MSG_GetMetricsTableLogDramAddr,   1),
>  >   };
>  >
>  >   static struct cmn2asic_mapping 
> smu_v15_0_0_feature_mask_map[SMU_FEATURE_COUNT] = {
>  > @@ -160,10 +165,37 @@ static struct cmn2asic_mapping 
> smu_v15_0_0_table_map[SMU_TABLE_COUNT] = {
>  >        TAB_MAP_VALID(DPMCLOCKS),
>  >   };
>  >
>  > +static int smu_v15_0_0_get_metrics_table_dram_addr(struct 
> smu_context *smu,
>  > +                                     SMU_15_0_0_MetricsInfo_t 
> *metrics_info)
>  > +{
>  > +     struct smu_msg_ctl *ctl = &smu->msg_ctl;
>  > +     struct smu_msg_args args = {
>  > +             .msg = SMU_MSG_GetMetricsTableLogDramAddr,
>  > +             .num_args = 0,
>  > +             .num_out_args = 3,
>  > +     };
>  > +     int ret;
>  > +
>  > +     ret = ctl->ops->send_msg(ctl, &args);
>  > +     if (ret)
>  > +             return ret;
>  > +
>  > +     metrics_info->addr = ((uint64_t)args.out_args[1] << 32) | 
> args.out_args[0];
>  > +     metrics_info->table_size = args.out_args[2];
>  > +
>  > +     metrics_info->cpu_addr = ioremap_wc(metrics_info->addr,
>  > +                                         metrics_info->table_size);
>  > +     if (!metrics_info->cpu_addr)
>  > +             return -ENOMEM;
>  > +
>  > +     return 0;
>  > +}
>  > +
>  >   static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
>  >   {
>  >        struct smu_table_context *smu_table = &smu->smu_table;
>  >        struct smu_table *tables = smu_table->tables;
>  > +     SMU_15_0_0_MetricsInfo_t *metrics_info;
>  >        int ret;
>  >
>  >        SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
>  > @@ -173,7 +205,7 @@ static int smu_v15_0_0_init_smc_tables(struct 
> smu_context *smu)
>  >        SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, 
> sizeof(SmuMetrics_t),
>  >                PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>  >
>  > -     smu_table->metrics_table = kzalloc_obj(SmuMetrics_t);
>  > +     smu_table->metrics_table = kzalloc_obj(SMU_15_0_0_MetricsInfo_t);
>  >        if (!smu_table->metrics_table)
>  >                goto err0_out;
>  >        smu_table->metrics_time = 0;
>  > @@ -192,8 +224,18 @@ static int smu_v15_0_0_init_smc_tables(struct 
> smu_context *smu)
>  >        if (ret)
>  >                goto err3_out;
>  >
>  > +     metrics_info = (SMU_15_0_0_MetricsInfo_t *)smu_table- 
>  >metrics_table;
>  > +
>  > +     if (metrics_info->addr == 0) {
>  > +             ret = smu_v15_0_0_get_metrics_table_dram_addr(smu, 
> metrics_info);
>  > +             if (ret)
>  > +                     goto err4_out;
>  > +     }
>  > +
>  >        return 0;
>  >
>  > +err4_out:
>  > +     smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
>  >   err3_out:
>  >        kfree(smu_table->watermarks_table);
>  >   err2_out:
>  > @@ -207,6 +249,14 @@ static int smu_v15_0_0_init_smc_tables(struct 
> smu_context *smu)
>  >   static int smu_v15_0_0_fini_smc_tables(struct smu_context *smu)
>  >   {
>  >        struct smu_table_context *smu_table = &smu->smu_table;
>  > +     SMU_15_0_0_MetricsInfo_t *metrics_info = smu_table->metrics_table;
>  > +
>  > +     if (metrics_info) {
>  > +             if (metrics_info->cpu_addr) {
>  > +                     iounmap(metrics_info->cpu_addr);
>  > +                     metrics_info->cpu_addr = NULL;
>  > +             }
>  > +     }
>  >
>  >        kfree(smu_table->clocks_table);
>  >        smu_table->clocks_table = NULL;
>  > @@ -299,7 +349,7 @@ static int 
> smu_v15_0_0_set_default_dpm_tables(struct smu_context *smu)
>  >                                    smu_table->clocks_table, false);
>  >   }
>  >
>  > -static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
>  > +static int smu_v15_0_0_get_gpu_metrics_table(struct smu_context *smu,
>  >                                                        void 
> *metrics_table,
>  >                                                        bool bypass_cache)
>  >   {
>  > @@ -329,115 +379,140 @@ static int 
> smu_v15_0_0_get_metrics_table(struct smu_context *smu,
>  >        return 0;
>  >   }
>  >
>  > +/*
>  > + * Fetch a fresh metrics sample into the inactive buffer.
>  > + * Returns 0 if a new sample was copied, 1 if the cached sample is still
>  > + * fresh (nothing copied), or a negative errno on failure.
>  > + */
>  > +static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
>  > +                                     SMU_15_0_0_MetricsInfo_t 
> *metrics_info)
>  > +{
>  > +     struct smu_table_context *smu_table = &smu->smu_table;
>  > +     void __iomem *cpu_addr = metrics_info->cpu_addr;
>  > +     struct smu_msg_ctl *ctl = &smu->msg_ctl;
>  > +     struct smu_msg_args args = {0};
>  > +     int table_size = metrics_info->table_size;
>  > +     int ret;
>  > +
>  > +     if (smu_table->metrics_time &&
>  > +         !time_after(jiffies, smu_table->metrics_time + 
> msecs_to_jiffies(1)))
>  > +             return 1;
>  > +
>  > +     if (!cpu_addr)
>  > +             return -ENOMEM;
>  > +
>  > +     args.msg = SMU_MSG_GetMetricsTableLogSample;
>  > +     args.num_args = 0;
>  > +     args.num_out_args = 0;
>  > +
>  > +     ret = ctl->ops->send_msg(ctl, &args);
>  > +     if (ret)
>  > +             return ret;
>  > +
>  > +     amdgpu_hdp_invalidate(smu->adev, NULL);//best to flush before copy
> 
> // commenting style is not followed. Please change such occurences.
> 
>  > +     if (table_size <= sizeof(MetricsTable_t))
>  > +             memcpy(&metrics_info->metrics[!metrics_info->active_idx],
>  > +                    cpu_addr, table_size);
>  > +     else
>  > +             memcpy(&metrics_info->metrics[!metrics_info->active_idx],
>  > +                    cpu_addr, sizeof(MetricsTable_t));
> 
> Ideally, from this point onwards active index is switched. The new index
> has the latest data.
> 
> Thanks,
> Lijo
> 
>  > +
>  > +     return 0;
>  > +}
>  > +
>  > +/*
>  > + * Accumulators monotonically increase and roll over at their type 
> width.
>  > + * Use the kernel wrapping_sub() API to compute the delta so the 
> subtraction
>  > + * wraps modulo 2^n (correct across a single rollover) without 
> tripping any
>  > + * wrap-around sanitizers.
>  > + */
>  > +static void smu_v15_0_0_compute_all_metrics(
>  > +             uint32_t *avg_metric,
>  > +             MetricsTable_t *prev,
>  > +             MetricsTable_t *curr)
>  > +{
>  > +     uint64_t counter, val;
>  > +     MetricsTable_IOD_t *p = &prev->IOD;
>  > +     MetricsTable_IOD_t *c = &curr->IOD;
>  > +
>  > +     counter = wrapping_sub(u32, c->AccumulationCounter, p- 
>  >AccumulationCounter);
>  > +     if (!counter)
>  > +             return;
>  > +
>  > +     /* Accumulator-based clock frequencies (fixed-point /1024) */
>  > +     val = wrapping_sub(u64, c->GfxclkFreqEffAcc, p->GfxclkFreqEffAcc);
>  > +     avg_metric[METRICS_AVERAGE_GFXCLK] = (val / counter) / 1024;
>  > +
>  > +     val = wrapping_sub(u64, c->SocclkFreqEffAcc, p->SocclkFreqEffAcc);
>  > +     avg_metric[METRICS_AVERAGE_SOCCLK] = (val / counter) / 1024;
>  > +
>  > +     val = wrapping_sub(u64, c->VclkFreqEffAcc, p->VclkFreqEffAcc);
>  > +     avg_metric[METRICS_AVERAGE_VCLK] = (val / counter) / 1024;
>  > +
>  > +     val = wrapping_sub(u64, c->MemclkFreqEffAcc, p->MemclkFreqEffAcc);
>  > +     avg_metric[METRICS_AVERAGE_UCLK] = (val / counter) / 1024;
>  > +
>  > +     val = wrapping_sub(u64, c->FclkFreqEffAcc, p->FclkFreqEffAcc);
>  > +     avg_metric[METRICS_AVERAGE_FCLK] = (val / counter) / 1024;
>  > +
>  > +     val = wrapping_sub(u64, c->NpuhclkFreqEffAcc, p- 
>  >NpuhclkFreqEffAcc);
>  > +     avg_metric[METRICS_AVERAGE_NPUCLK] = (val / counter) / 1024;
>  > +
>  > +     /* Activity (fixed-point /1024) */
>  > +     val = wrapping_sub(u64, c->GfxBusyAcc, p->GfxBusyAcc);
>  > +     avg_metric[METRICS_AVERAGE_GFXACTIVITY] = (val / counter) / 1024;
>  > +
>  > +     val = wrapping_sub(u64, c->VcnBusyAcc, p->VcnBusyAcc);
>  > +     avg_metric[METRICS_AVERAGE_VCNACTIVITY] = (val / counter) / 1024;
>  > +
>  > +     /* Power (fixed-point /1024) */
>  > +     val = wrapping_sub(u64, c->ApuPowerAcc, p->ApuPowerAcc);
>  > +     avg_metric[METRICS_AVERAGE_SOCKETPOWER] = (val / counter) / 1024;
>  > +
>  > +     val = wrapping_sub(u64, c->SystemPowerAcc, p->SystemPowerAcc);
>  > +     avg_metric[METRICS_CURR_SOCKETPOWER] = (val / counter) / 1024;
>  > +
>  > +     /* Temperature */
>  > +     val = wrapping_sub(u64, c->GFX_TempAcc, p->GFX_TempAcc);
>  > +     avg_metric[METRICS_TEMPERATURE_EDGE] = val / counter;
>  > +
>  > +     val = wrapping_sub(u64, c->STT_APU_HotSpotTempAcc, p- 
>  >STT_APU_HotSpotTempAcc);
>  > +     avg_metric[METRICS_TEMPERATURE_HOTSPOT] = val / counter;
>  > +
>  > +     /* Voltage(mV) */
>  > +     val = wrapping_sub(u64, c->VDDCR_GFX_TelemetryVoltage, p- 
>  >VDDCR_GFX_TelemetryVoltage);
>  > +             avg_metric[METRICS_VOLTAGE_VDDGFX] = (val / counter) / 
> 1000;
>  > +
>  > +     val = wrapping_sub(u64, c->VDDCR_SOC_TelemetryVoltage, p- 
>  >VDDCR_SOC_TelemetryVoltage);
>  > +             avg_metric[METRICS_VOLTAGE_VDDSOC] = (val / counter) / 
> 1000;
>  > +}
>  > +
>  >   static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
>  >                                            MetricsMember_t member,
>  >                                            uint32_t *value)
>  >   {
>  >        struct smu_table_context *smu_table = &smu->smu_table;
>  > +     SMU_15_0_0_MetricsInfo_t *metrics_info =
>  > +             (SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table;
>  > +     int ret;
>  >
>  > -     SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
>  > -     int ret = 0;
>  > -
>  > -     ret = smu_v15_0_0_get_metrics_table(smu, NULL, false);
>  > -     if (ret)
>  > +     ret = smu_v15_0_0_get_metrics_table(smu, metrics_info);
>  > +     if (ret < 0)
>  >                return ret;
>  >
>  > -     switch (member) {
>  > -     case METRICS_AVERAGE_GFXCLK:
>  > -             *value = metrics->GfxclkFrequency;
>  > -             break;
>  > -     case METRICS_AVERAGE_SOCCLK:
>  > -             *value = metrics->SocclkFrequency;
>  > -             break;
>  > -     case METRICS_AVERAGE_VCLK:
>  > -             *value = metrics->VclkFrequency;
>  > -             break;
>  > -     case METRICS_AVERAGE_DCLK:
>  > -             *value = 0;
>  > -             break;
>  > -     case METRICS_AVERAGE_UCLK:
>  > -             *value = metrics->MemclkFrequency;
>  > -             break;
>  > -     case METRICS_AVERAGE_FCLK:
>  > -             *value = metrics->FclkFrequency;
>  > -             break;
>  > -     case METRICS_AVERAGE_VPECLK:
>  > -             *value = metrics->VpeclkFrequency;
>  > -             break;
>  > -     case METRICS_AVERAGE_NPUCLK:
>  > -             *value = metrics->NpuclkFrequency;
>  > -             break;
>  > -     case METRICS_AVERAGE_GFXACTIVITY:
>  > -             if ((smu->smc_fw_version > 0x5d4600))
>  > -                     *value = metrics->GfxActivity;
>  > -             else
>  > -                     *value = metrics->GfxActivity / 100;
>  > -             break;
>  > -     case METRICS_AVERAGE_VCNACTIVITY:
>  > -             *value = metrics->VcnActivity / 100;
>  > -             break;
>  > -     case METRICS_AVERAGE_SOCKETPOWER:
>  > -     case METRICS_CURR_SOCKETPOWER:
>  > -             *value = (metrics->SocketPower / 1000 << 8) +
>  > -             (metrics->SocketPower % 1000 / 10);
>  > -             break;
>  > -     case METRICS_TEMPERATURE_EDGE:
>  > -             *value = metrics->GfxTemperature / 100 *
>  > -             SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>  > -             break;
>  > -     case METRICS_TEMPERATURE_HOTSPOT:
>  > -             *value = metrics->SocTemperature / 100 *
>  > -             SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>  > -             break;
>  > -     case METRICS_THROTTLER_RESIDENCY_PROCHOT:
>  > -             *value = metrics->ThrottleResidency_PROCHOT;
>  > -             break;
>  > -     case METRICS_THROTTLER_RESIDENCY_SPL:
>  > -             *value = metrics->ThrottleResidency_SPL;
>  > -             break;
>  > -     case METRICS_THROTTLER_RESIDENCY_FPPT:
>  > -             *value = metrics->ThrottleResidency_FPPT;
>  > -             break;
>  > -     case METRICS_THROTTLER_RESIDENCY_SPPT:
>  > -             *value = metrics->ThrottleResidency_SPPT;
>  > -             break;
>  > -     case METRICS_THROTTLER_RESIDENCY_THM_SOC:
>  > -             *value = metrics->ThrottleResidency_THM_SOC;
>  > -             break;
>  > -     case METRICS_VOLTAGE_VDDGFX:
>  > -             *value = 0;
>  > -             break;
>  > -     case METRICS_VOLTAGE_VDDSOC:
>  > -             *value = 0;
>  > -             break;
>  > -     case METRICS_SS_APU_SHARE:
>  > -             /* return the percentage of APU power with respect to 
> APU's power limit.
>  > -              * percentage is reported, this isn't boost value. 
> Smartshift power
>  > -              * boost/shift is only when the percentage is more than 
> 100.
>  > -              */
>  > -             if (metrics->StapmOpnLimit > 0)
>  > -                     *value = (metrics->ApuPower * 100) / metrics- 
>  >StapmOpnLimit;
>  > -             else
>  > -                     *value = 0;
>  > -             break;
>  > -     case METRICS_SS_DGPU_SHARE:
>  > -             /* return the percentage of dGPU power with respect to 
> dGPU's power limit.
>  > -              * percentage is reported, this isn't boost value. 
> Smartshift power
>  > -              * boost/shift is only when the percentage is more than 
> 100.
>  > -              */
>  > -             if ((metrics->dGpuPower > 0) &&
>  > -                 (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
>  > -                     *value = (metrics->dGpuPower * 100) /
>  > -                              (metrics->StapmCurrentLimit - metrics- 
>  >StapmOpnLimit);
>  > -             else
>  > -                     *value = 0;
>  > -             break;
>  > -     default:
>  > -             *value = UINT_MAX;
>  > -             break;
>  > +     if (ret == 0 &&
>  > +         metrics_info->metrics[metrics_info- 
>  >active_idx].IOD.AccumulationCounter !=
>  > +         metrics_info->metrics[!metrics_info- 
>  >active_idx].IOD.AccumulationCounter) {
>  > +             /* New sample: compute all accumulator-based metrics 
> and swap */
>  > +             smu_v15_0_0_compute_all_metrics(metrics_info->avg_metric,
>  > +                                             &metrics_info- 
>  >metrics[metrics_info->active_idx],
>  > +                                             &metrics_info- 
>  >metrics[!metrics_info->active_idx]);
>  > + metrics_info->active_idx = !metrics_info->active_idx;
>  >        }
>  >
>  > -     return ret;
>  > +     *value = metrics_info->avg_metric[member];
>  > +
>  > +     return 0;
>  >   }
> 
> Indexes are switched in the above highlighted line. 
> smu_v15_0_0_get_metrics_table() takes active_idx as 0 initially(first 
> time). New metrics are fetched in index 1. Then in 
>   smu_v15_0_0_get_smu_metrics_data() accumulation counter is compared 
> across both indexes and if it has changed, we compute all the metrics. 
> Then we change the active_idx to 0(highlighted line). So, next time when 
> smu_v15_0_0_get_smu_metrics_data() is called active_idx is 1 and new 
> metrics are fetched in index 0. That is how the metrics are switched 
> alternately.
> 

smu_v15_0_0_get_metrics_table will be called from multiple places. This 
is the place where data gets updated. The indication of which index to 
use for the latest data should ideally also be part of the same logic.

Thanks,
Lijo

>  >
>  >   static int smu_v15_0_0_read_sensor(struct smu_context *smu,
>  > @@ -512,18 +587,6 @@ static int smu_v15_0_0_read_sensor(struct 
> smu_context *smu,
>  >                                                       (uint32_t *)data);
>  >                *size = 4;
>  >                break;
>  > -     case AMDGPU_PP_SENSOR_SS_APU_SHARE:
>  > -             ret = smu_v15_0_0_get_smu_metrics_data(smu,
>  > -                                                    
> METRICS_SS_APU_SHARE,
>  > -                                                    (uint32_t *)data);
>  > -             *size = 4;
>  > -             break;
>  > -     case AMDGPU_PP_SENSOR_SS_DGPU_SHARE:
>  > -             ret = smu_v15_0_0_get_smu_metrics_data(smu,
>  > -                                                    
> METRICS_SS_DGPU_SHARE,
>  > -                                                    (uint32_t *)data);
>  > -             *size = 4;
>  > -             break;
>  >        default:
>  >                ret = -EOPNOTSUPP;
>  >                break;
>  > @@ -634,7 +697,7 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct 
> smu_context *smu,
>  >        SmuMetrics_t metrics;
>  >        int ret = 0;
>  >
>  > -     ret = smu_v15_0_0_get_metrics_table(smu, &metrics, false);
>  > +     ret = smu_v15_0_0_get_gpu_metrics_table(smu, &metrics, false);
>  >        if (ret)
>  >                return ret;
>  >
>  > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h b/ 
> drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
>  > index 8365b9fea77e..8471ba1a353e 100644
>  > --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
>  > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
>  > @@ -23,6 +23,19 @@
>  >   #ifndef __SMU_V15_0_0_PPT_H__
>  >   #define __SMU_V15_0_0_PPT_H__
>  >
>  > +#include "amdgpu_smu.h"
>  > +
>  > +#include "pmfw_if/smu_v15_0_0_metrics.h"
>  > +
>  > +typedef struct {
>  > +     MetricsTable_t metrics[2];
>  > +     bool active_idx;
>  > +     uint32_t table_size;
>  > +     uint64_t addr;
>  > +     void __iomem *cpu_addr;
>  > +     uint32_t avg_metric[METRICS_AVERAGE_NPUCLK+1];
>  > +} SMU_15_0_0_MetricsInfo_t;
>  > +
>  >   extern void smu_v15_0_0_set_ppt_funcs(struct smu_context *smu);
>  >
>  >   #endif
>  > \ No newline at end of file
> 

