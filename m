Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03DCCAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 23:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44E0210E810;
	Wed, 24 Sep 2025 23:14:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NdhFD9qe";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7556610E810
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 23:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+3Am5GGMgERY9P7AQc4FRtT2vi7A/7CuEI83MsFY6+d624OMPOz8gR4m9ostuwVIxUDsD4XgR5K9mafjwoRIoekZ1FWdRtPJx4IsB41gbR57iGyiS+PP38LFsTxR8+ZAWPtH0YT/TClN2f5avvuJIpL66XK6Tuo6KtERUzJOoxqcwWZ48spJYL3DjyJ2ZgdXevgOtp+vwx6pex4EB3tb2cMuPLfg9CmlVhazNddrErzqnWlfePwcONA9W3FQOv8Hq+QLAVnggHllF/qcc3hL4boELBEtslXLId/ffk5jplLrTOdZeGwPnPEWR0uoAU5Kg5QgpyXV6eMEY9BTKw5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtrJ7CKms45l0NpvF+M1tcYlAmvO09FURX5DMSwfVYY=;
 b=y7fYPq5CG/z6TEAJz5rJayEZNuzRimJKGrHMuRTikxAj/LEgFLgl8HHZONbfHcCmwK1fOboAc0rRDOCaw99bspvbUu+rg/Gzwq9mtawaRMEtBXy9rfStA/UaUNgKd+wh88a+s3GkrpjIy4jCe6LC9lPVuTwfNiC/biJygRgjYLei02drVN7nISTf2WanGD5FEuod8N6tNwg1URV6vdeDTnTFF4w5QrYFYyG9xWDoUl6CRtQnNX24BKXhSdJyaqAkdsshBJcaR0wVKKDqea6bwpHbzXhn0fvxROd6IzYh61bz+nKW/eyqClvTlY+ztFl8onvVUlhzIcZ5p+7+avVe1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtrJ7CKms45l0NpvF+M1tcYlAmvO09FURX5DMSwfVYY=;
 b=NdhFD9qerZ/47kpDQwmelOm9xbLX6vK2oYDc2r50vxKibeTJHDuEmS/Sbv3aiICB7nv4mnl5BVE8m2YIwoc0MH2Lwpu0G1gxg6/yRrg7+jNJYtUQpjRhVLdwcRM2AIw4klZWrxkIaRbbUMquO0QPcIqSvULT4KH4gfjcHie1AMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 23:14:20 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 23:14:20 +0000
Message-ID: <202cec01-311d-d34e-3472-0dd36cc4bdd6@amd.com>
Date: Wed, 24 Sep 2025 19:14:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/2] amd/amdkfd: enhance kfd process check in switch
 partition
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Philip.Yang@amd.com,
 Lijo.Lazar@amd.com
References: <20250924152929.2234747-1-yifan1.zhang@amd.com>
 <20250924152929.2234747-2-yifan1.zhang@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250924152929.2234747-2-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::26) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY8PR12MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: db960414-8dc9-4b5f-563c-08ddfbc01724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mm0xNFpqZWtYRWJWQjVGckduVXVUaitFZVQ3UWtURkRiWExZT09HNlVQamth?=
 =?utf-8?B?NW16djBCZXhWZTNrMG4wQ3pGcmJwQzc3SkpmVzVkZUMxUm9SWlZMYjk3MUxp?=
 =?utf-8?B?U1ZUTzdQSXZHNFNWb01VbEFKT1MvZTlRcGlza0lVYmNlQ3dPbkEzRExieGIy?=
 =?utf-8?B?ZW9mb2pZZWluWDJVUDFqMmw5RnNUb0I5c1hQMzNTZXd4cGJVRWJuMkRiWDdO?=
 =?utf-8?B?L0YyYkFkbDl4blVXbWtvVFFxRHdTVDBzR0ZTeWtTT1AvaG56cGRiUFhuY2xl?=
 =?utf-8?B?WTFOaWdaMGJHQ0FBNXc5MHpvZzVjWGN6WC96VEtkMEFLYm1mamx0Njk1NE5E?=
 =?utf-8?B?QnVXZTlZSHo2WS9PbGd6SWZTT1Nvd05rR1VXclFsSjlBR3VvMENYb1pSeVVs?=
 =?utf-8?B?REZEME9WM0EyT0VQYUlnTE1mZ25NYUdhaUJpWkhud3BtZTY3NkxYa2wvR0Vq?=
 =?utf-8?B?K3pjRUdNVzdMVjZWVlk1ak1sT3BvNWxMeURhWUUrbStmSWhkZHZuVlkwdWJR?=
 =?utf-8?B?N2pPdm00dzRMM21naFNJWUFlMFFsVGhnamZxazdCNmJCTGpoVDExU2J5clpv?=
 =?utf-8?B?ZUZvVVU2cjN6YUIyV084K2FlelNEaDE3bFRwVzg4RFNQZ1AzWDBxeWdrVnN3?=
 =?utf-8?B?UGFqdEd1SmZEVGpZbXN0Sk5vTldDaU9pL05PQ2paVDBqY3g4V3pJNEtYdnJw?=
 =?utf-8?B?enA2UEh1RXpXMDdoa1JPZGIrSzFxZFg0Vllpa1dkUHoyOGVvN2MrVGZ4anJG?=
 =?utf-8?B?ZGh4aC8zV3YxYi9UNGlVQjB6OGp4Q3ZZQzBTMmxhbU9BT1pvS0x3dEhLS1dT?=
 =?utf-8?B?azRSS2ZYd1l1R3o3YmxSejJYV0d5c2ZsYkpjaEpWSWNuaVc3N2FaMzJyUitp?=
 =?utf-8?B?N2pWajZiR1pVQVJwM2htUnROUkZ4RmRzbnp5VFNURlBFM2R2b1cwODdMTmdT?=
 =?utf-8?B?QnBKWFF6ZWhQMkR6NHM3MU02WFpLdk5nRHJ4YTU0TTdReGZTMWd3Z284akdj?=
 =?utf-8?B?b2tKYldXRndpMFQxQjdnR1lja3lzNGdqZGozRmNqT3FuQkZPRFFNbnFLVHh0?=
 =?utf-8?B?TDJXenVOb0sycGdZM21aT3RzN0NFbWpWV3BQNXpDK0VoY1d4TjZlRjNqR0dR?=
 =?utf-8?B?Nytqemx3dWhlZU5UYUpCMGZ5RVo5VEc2MVRxUW56eGpMUlVLa2tzVzZsRlZC?=
 =?utf-8?B?WUFiZHMzRXBWdXJCVjkzdXZyYmlyTmJTU0xYZ3RuQmlRNnJhUkNKKzdkZzEv?=
 =?utf-8?B?RitkdkVLbXlKaHVMQ1dCaTN4RUNESG5McWQzT3FkejlWNEdINmdLN2lFOHdD?=
 =?utf-8?B?NmRLb1ozUmtXMUJxemkvaTd3L0JTNjI4bnZQcHp4KzlvOUJxVzRGTEJpQ0lM?=
 =?utf-8?B?NVVIRXNUaFhBVk5qWUpHTGJjdmh4TUc5anRWaTBYc2FGQXVoNFFPVTdzRXlM?=
 =?utf-8?B?TjRvSWJQemVWSzRWMCtZRXdGaGlKMkJ3SHpIb09aVmlwZUlCbHNudTRENHJW?=
 =?utf-8?B?NjlOQmVKejhZNEk4ekNJMHVuRStqb0IvQWozc09YYmJkQ3k5Q0dHZ3hSNG8r?=
 =?utf-8?B?K1VSY3E3SjNNZ0c0VW1JN1MrYS82MGM0bFVRKzY3azVib04yK2htL09jeUdC?=
 =?utf-8?B?blpTYk5zKzVvLzUwOVNEVDRaODJia3FwVzc2eitGcFJmV3UzdDZmNzNTQXRj?=
 =?utf-8?B?aWt0OFltMkM2RU1xRWR3QS8rcFU1aHcrV0xGdWp6UktDV01SK1RCTmg0LzZC?=
 =?utf-8?B?RVpZeUcvU3dFMHVRbnlTVkxXNHNTcjY5cm5ZcHlrL2tJNW1rVGo5MlhING54?=
 =?utf-8?B?VXdyQTM1WjUxWk5FL2hpR2JzTWNZdEVCN3M4dmpvc0NGRFpZbGNmdXFoSVRs?=
 =?utf-8?B?L0lVNEtzRW9sM2NTVkJnVnp6TmQzSW1sUlMyeHE0dUpQaGFKQUI2NzRiVEhi?=
 =?utf-8?Q?1ReEb4Gv2uM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHdxL3ZlMEsyajlQdXNJZE4vWk1qKzJDWjhVekxjeWlwcEJGNmJBL0IydW1J?=
 =?utf-8?B?S3kzOWtIL2xtR1QvUUozb0FSRTBnaDlTRW84a1Q4YzY3Wk5MaEJoaVZua29D?=
 =?utf-8?B?ZWJ3eXRsUlRpekNPbWJhV05XK25Pc0tCVXJQUCtWNTZTRmVTdkpTZ3ZZQU9Y?=
 =?utf-8?B?R1BsWC9HUzhRaWxnU2s4TGQxZ0FaVjU3WmF4NE9XVE1PU1Z3MzlDQkE4ODM2?=
 =?utf-8?B?c2pUMDRXRms0ckxreDIzS0NtcEt0bEg5RG5DQlhTMWFrd0JuekRMOHQwZnUx?=
 =?utf-8?B?L3RuMktGRGMycDFINGVHVGQwNldrRnhRS3NGOWlrWGtjOGxKdUtMb0lZTzhT?=
 =?utf-8?B?T0hUTE1CZkZFY1Iyb1R2aDBXWnp4ZnF2YmJVamprTXF6TGZETjQxbVQ0aHM0?=
 =?utf-8?B?TEtkZ0NiYzhQWm1UNExLWnNzd0hZSVp6RXgwSHF4OXVraDRYTCs5UVc0Ykg2?=
 =?utf-8?B?cWF4Z0dBMHd2dlJxOWQ1dWJjamFFUkdtTXFLc2MxYUlDZEdsTEpOTGxoRkUy?=
 =?utf-8?B?b0lwU0htUHY2UGFNSXdiR1l3WlRaeGJ0MkVnVTRHcFdnWm94OC9ld0ZIK1Qz?=
 =?utf-8?B?UDVuUm5UZnFMUEtPL2hBS3BUK0djbEkxSHNZRHZvWUxFdTZxaGQxZEVRV1ZI?=
 =?utf-8?B?VEd3RXo5d3Zqb0tVYWl2UkpLVmpFclZpQ3dnK1Rkc05RVlBINEd6MllQYlpI?=
 =?utf-8?B?a2RuL0dPam0xd0NmZ0twOTYwMWpYVEJEc0ZTNWsreHdIc3JCMklEK3RWUmFM?=
 =?utf-8?B?TDFLUmF6NlVPbkZXcDRSVVpuN3FIdEJsZjMvZEpMbG5Ga2FrYXFRdDJRTGJD?=
 =?utf-8?B?K1BpdXQyVTN2bTk1b3F5c1g5bElZaTB6dlJHZ1NvUEtuSTM3NGJzZGRCUmIv?=
 =?utf-8?B?cEJ1aTlKblBabUVJWnpWSjRLdUJHT09GczZCMFA1K0c2QWovaGR2SzdXWWND?=
 =?utf-8?B?c3lmWWxyWDNRVm1CS011dU1XaTFZOEhwY2MxVjdOT1orZ0FKR3AvcnkvZ1VG?=
 =?utf-8?B?dG5pd1lkMWJwbnM4SlBqb0Y4TVBmQVBPY0NoME1vMzlSR3FzUjY0azVMcUlN?=
 =?utf-8?B?dGVaUWdDVHNkS0JpWjhoYzhDZTJ0YSs1UFlLc2hiTTE4SzVFaCsyTXIwOUZN?=
 =?utf-8?B?SmI5WDdlWEsyaTdTVUNxQllkbjZMNWE1RTFkcjFOTitKKzdzcW9BaFQySndK?=
 =?utf-8?B?YmNSNzFZc3lzdDZkSkNOdVRmUlpsd1l0clhyWVNGZVZOOUhNUTJuY3JmdTVv?=
 =?utf-8?B?WFJkSlVYQ2I3SlpaZ0tpQ3BTMEhocmVoVDN4bm1mc2xJamdiM3pmWUxQMm84?=
 =?utf-8?B?SndjNHRHd1dCVzd0SklrOU5Ya084bWUwN2JRYmYybkVXRTFsK0M5encwOS8v?=
 =?utf-8?B?WnU4S0doN2VLalRxRml2R283NHpLK3diY21WRVc2bXRHRHRsemxSMmhma3Qy?=
 =?utf-8?B?b3dQcGNQVlkxQjBOTGhYS2lRREZ4QkhpNHhlQ1QyVTN0bkNxdlRoWmZXQ2h3?=
 =?utf-8?B?ODVSc0dYUWdlTDE0TVJ1SlZyckJ2ZWllY0UwV0lOd2dEWjhhRFlSbU9pUVNM?=
 =?utf-8?B?eWxYSjJOdVVJRmRFM1VQbkowTmJrUU56MWMvMnM4TjFXK2Q1NDJLYnhEL1Y1?=
 =?utf-8?B?Q2Z5WVNKVWJnb1Mzb21RQXpQWmJHZEcydlMwY3pvWHdGN2s0Wm94RkcvWEVV?=
 =?utf-8?B?Y2ltTHlHTU9iUVMyK0JiT0xoR2JBVGRIVXRNcXhnSWZWMjBpRUU0VTNZdEZ5?=
 =?utf-8?B?bnJ1UGZ5SVRja3I0OE1UOWJ2OU1tdDlsN3B1MTQ2TzJNVGRKZDdpb1p2M3d3?=
 =?utf-8?B?R3NDNTRjSUdzbHpabVpXakJBRmFBRGtIZHFFZzc2MVRJdzU5c2JaWEFXdkxs?=
 =?utf-8?B?b0lUbWhiREJOL1B2Y1VNME04Tk9WanlKdDlDNnVFYitGMCtzSlh5eGRqdGlt?=
 =?utf-8?B?cjBWcm12R3R0REttYUdHN0YzRWNwTjJ4Tms1NW9iMG9kbEUvMW5wRVI2WTYx?=
 =?utf-8?B?SlBuYTB4aFVTakd5MElOM0p4bDFNcnJPVURWOGpwV0V3U3BaYlV2Z1RWMldj?=
 =?utf-8?B?cEg1S0IxV1ZQbXVoL2gyczAycDFyTUZ2ZXNVVXBkaVU1cVpJZlNNYW10dE9o?=
 =?utf-8?Q?BH7Fq8+e8wQS2q/9DUsRimdcP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db960414-8dc9-4b5f-563c-08ddfbc01724
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 23:14:19.8560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doDVoDUVg/ofOw6SXBZC1FNZBjQONWZvPykl7ycHYLow7ObK0uZUTI4hX0mlRnI1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732
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


On 2025-09-24 11:29, Yifan Zhang wrote:
> current switch partition only check if kfd_processes_table is empty.
> kfd_prcesses_table entry is deleted in kfd_process_notifier_release, but
> kfd_process tear down is in kfd_process_wq_release.
>
> consider two processes:
>
> Process A (workqueue) -> kfd_process_wq_release -> Access kfd_node member
> Process B switch partition -> amdgpu_xcp_pre_partition_switch -> amdgpu_amdkfd_device_fini_sw
> -> kfd_node tear down.
>
> Process A and B may trigger a race as shown in dmesg log.
>
> This patch is to resolve the race by adding an atomic kfd_process counter
> kfd_processes_count, it increment as create kfd process, decrement as
> finish kfd_process_wq_release.
>
> v2: Put kfd_processes_count per kfd_dev, move decrement to kfd_process_destroy_pdds
> and bug fix. (Philip Yang)
>
> [3966658.307702] divide error: 0000 [#1] SMP NOPTI
> [3966658.350818]  i10nm_edac
> [3966658.356318] CPU: 124 PID: 38435 Comm: kworker/124:0 Kdump: loaded Tainted
> [3966658.356890] Workqueue: kfd_process_wq kfd_process_wq_release [amdgpu]
> [3966658.362839]  nfit
> [3966658.366457] RIP: 0010:kfd_get_num_sdma_engines+0x17/0x40 [amdgpu]
> [3966658.366460] Code: 00 00 e9 ac 81 02 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 48 8b 4f 08 48 8b b7 00 01 00 00 8b 81 58 26 03 00 99 <f7> be b8 01 00 00 80 b9 70 2e 00 00 00 74 0b 83 f8 02 ba 02 00 00
> [3966658.380967]  x86_pkg_temp_thermal
> [3966658.391529] RSP: 0018:ffffc900a0edfdd8 EFLAGS: 00010246
> [3966658.391531] RAX: 0000000000000008 RBX: ffff8974e593b800 RCX: ffff888645900000
> [3966658.391531] RDX: 0000000000000000 RSI: ffff888129154400 RDI: ffff888129151c00
> [3966658.391532] RBP: ffff8883ad79d400 R08: 0000000000000000 R09: ffff8890d2750af4
> [3966658.391532] R10: 0000000000000018 R11: 0000000000000018 R12: 0000000000000000
> [3966658.391533] R13: ffff8883ad79d400 R14: ffffe87ff662ba00 R15: ffff8974e593b800
> [3966658.391533] FS:  0000000000000000(0000) GS:ffff88fe7f600000(0000) knlGS:0000000000000000
> [3966658.391534] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [3966658.391534] CR2: 0000000000d71000 CR3: 000000dd0e970004 CR4: 0000000002770ee0
> [3966658.391535] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [3966658.391535] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [3966658.391536] PKRU: 55555554
> [3966658.391536] Call Trace:
> [3966658.391674]  deallocate_sdma_queue+0x38/0xa0 [amdgpu]
> [3966658.391762]  process_termination_cpsch+0x1ed/0x480 [amdgpu]
> [3966658.399754]  intel_powerclamp
> [3966658.402831]  kfd_process_dequeue_from_all_devices+0x5b/0xc0 [amdgpu]
> [3966658.402908]  kfd_process_wq_release+0x1a/0x1a0 [amdgpu]
> [3966658.410516]  coretemp
> [3966658.434016]  process_one_work+0x1ad/0x380
> [3966658.434021]  worker_thread+0x49/0x310
> [3966658.438963]  kvm_intel
> [3966658.446041]  ? process_one_work+0x380/0x380
> [3966658.446045]  kthread+0x118/0x140
> [3966658.446047]  ? __kthread_bind_mask+0x60/0x60
> [3966658.446050]  ret_from_fork+0x1f/0x30
> [3966658.446053] Modules linked in: kpatch_20765354(OEK)
> [3966658.455310]  kvm
> [3966658.464534]  mptcp_diag xsk_diag raw_diag unix_diag af_packet_diag netlink_diag udp_diag act_pedit act_mirred act_vlan cls_flower kpatch_21951273(OEK) kpatch_18424469(OEK) kpatch_19749756(OEK)
> [3966658.473462]  idxd_mdev
> [3966658.482306]  kpatch_17971294(OEK) sch_ingress xt_conntrack amdgpu(OE) amdxcp(OE) amddrm_buddy(OE) amd_sched(OE) amdttm(OE) amdkcl(OE) intel_ifs iptable_mangle tcm_loop target_core_pscsi tcp_diag target_core_file inet_diag target_core_iblock target_core_user target_core_mod coldpgs kpatch_18383292(OEK) ip6table_nat ip6table_filter ip6_tables ip_set_hash_ipportip ip_set_hash_ipportnet ip_set_hash_ipport ip_set_bitmap_port xt_comment iptable_nat nf_nat iptable_filter ip_tables ip_set ip_vs_sh ip_vs_wrr ip_vs_rr ip_vs nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 sn_core_odd(OE) i40e overlay binfmt_misc tun bonding(OE) aisqos(OE) aisqos_hotfixes(OE) rfkill uio_pci_generic uio cuse fuse nf_tables nfnetlink intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common i10nm_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm idxd_mdev
> [3966658.491237]  vfio_pci
> [3966658.501196]  vfio_pci vfio_virqfd mdev vfio_iommu_type1 vfio iax_crypto intel_pmt_telemetry iTCO_wdt intel_pmt_class iTCO_vendor_support irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel rapl intel_cstate snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep snd_seq
> [3966658.508537]  vfio_virqfd
> [3966658.517569]  snd_seq_device ipmi_ssif isst_if_mbox_pci isst_if_mmio pcspkr snd_pcm idxd intel_uncore ses isst_if_common intel_vsec idxd_bus enclosure snd_timer mei_me snd i2c_i801 i2c_smbus mei i2c_ismt soundcore joydev acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad vfat fat
> [3966658.526851]  mdev
> [3966658.536096]  nfsd auth_rpcgss nfs_acl lockd grace slb_vtoa(OE) sunrpc dm_mod hookers mlx5_ib(OE) ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm mlx5_core(OE) mlxfw(OE)
> [3966658.540381]  vfio_iommu_type1
> [3966658.544341]  nvme mpt3sas tls drm nvme_core pci_hyperv_intf raid_class psample libcrc32c crc32c_intel mlxdevm(OE) i2c_core
> [3966658.551254]  vfio
> [3966658.558742]  scsi_transport_sas wmi pinctrl_emmitsburg sd_mod t10_pi sg ahci libahci libata rdma_ucm(OE) ib_uverbs(OE) rdma_cm(OE) iw_cm(OE) ib_cm(OE) ib_umad(OE) ib_core(OE) ib_ucm(OE) mlx_compat(OE)
> [3966658.563004]  iax_crypto
> [3966658.570988]  [last unloaded: diagnose]
> [3966658.571027] ---[ end trace cc9dbb180f9ae537 ]---
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Because kfd structure is kzalloc, on x86, atomic_set 0 is not needed, I 
don't know other platforms. To be safe,

@@ -495,6 +495,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device 
*adev, bool vf)
         mutex_init(&kfd->doorbell_mutex);

         ida_init(&kfd->doorbell_ida);
+       atomic_set(&kfd->kfd_processes_count, 0);

         return kfd;
  }

With this added, this patch is Reviewed-by: Philip.Yang<Philip.Yang@amd.com>

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c  | 9 +++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 4 ++++
>   3 files changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 051a00152b08..488c8c0e6ccd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1493,6 +1493,15 @@ int kgd2kfd_check_and_lock_kfd(struct kfd_dev *kfd)
>   
>   	mutex_lock(&kfd_processes_mutex);
>   
> +	/* kfd_processes_count is per kfd_dev, return -EBUSY without
> +	 * further check
> +	 */
> +	if (!!atomic_read(&kfd->kfd_processes_count)) {
> +		pr_debug("process_wq_release not finished\n");
> +		r = -EBUSY;
> +		goto out;
> +	}
> +
>   	if (hash_empty(kfd_processes_table) && !kfd_is_locked(kfd))
>   		goto out;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index d01ef5ac0766..70ef051511bb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -382,6 +382,8 @@ struct kfd_dev {
>   
>   	/* for dynamic partitioning */
>   	int kfd_dev_lock;
> +
> +	atomic_t kfd_processes_count;
>   };
>   
>   enum kfd_mempool {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 5be28c6c4f6a..ddfe30c13e9d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1088,6 +1088,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>   			pdd->runtime_inuse = false;
>   		}
>   
> +		atomic_dec(&pdd->dev->kfd->kfd_processes_count);
> +
>   		kfree(pdd);
>   		p->pdds[i] = NULL;
>   	}
> @@ -1649,6 +1651,8 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
>   	/* Init idr used for memory handle translation */
>   	idr_init(&pdd->alloc_idr);
>   
> +	atomic_inc(&dev->kfd->kfd_processes_count);
> +
>   	return pdd;
>   }
>   
