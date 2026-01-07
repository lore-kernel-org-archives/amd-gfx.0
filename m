Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9F1CF6C12
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 09:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B635410E094;
	Wed,  7 Jan 2026 09:02:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="suGfbYob";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCA9610E094
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 09:02:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sErzWsEeMrLRnAy3qxCJoQrenAnEWV4nRG1QOVAEiyUGKEZZLQ+s64tYcZbE589DdXwg0WpIDQhWz4S08l+MF3gM0LSkMWDzAtKIQ0Ld8AzIiU2vJcwycnyXCAigmEFoLa268Wg6/Y7/PNc0Qm0qJ/lB6Daz9yWJzjP9Z6VNQ980wGJ7tIL5oVKjhLqD9vbrWLTa7xm/NXuy/ecPBShLzhuteuNQx8ToyH4G+AOOkh4Iydfa5h79U26rd5/EqdhREI6D6xukpZFQL2nGJoParcLr/Slcm0zPeVFmyqfd5djFrdEqZHjykQIVC+gYwnuY60ScRrLhKZ49SVyfAgPrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMcJagZBJjQO/Td+7B5qL3+iPnYaHvYBCggsC32UtHk=;
 b=JelFIVLK3RzxIWKsBZAbH38efhQ1thjU2ZSRnBNMMtHAv81PM6VoJbNYauFI/mepZwG1T1r6bA1MyZvz+bsORLyRqPSaP6W0+UFd35Z5icT11t0UmWu9E0ttt8pUCuWvx3NqpKnVI4fxy6izd2Oqmw0pdsfL9teQ/6jQ6ans2/3IFBzZ9t/c0CQGH6Ohn1cHRb3iWi/lTAJMpV88TVD1/38w9sVl7EOzGtT5mcbIkCEUvFiuB1YmPVPeuRY5vg+fnt5UqDW4RDUUaXMhd2Yglk0y0MPDhSuJ2wgkiZTgNSuKUb36SU6UR5ma8nZb7XM6gXLlBhmq8TLuehqq74e9tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMcJagZBJjQO/Td+7B5qL3+iPnYaHvYBCggsC32UtHk=;
 b=suGfbYob+w06a40z9Gw7NuLdtkNn/CbiszPoggt08wQKH4GRQoH3YiQaJFcfE2ls1BUT64n5U8DlVsrLHQWbLSWuHYUluPZL5dXt0axApGAk3BD4LoaWWxxTwKH5m6BQuf/BRzCxhKa9PKGNHr9CyS4D252k9l5Be6m50Ehf8Eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Wed, 7 Jan
 2026 09:02:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 09:02:15 +0000
Message-ID: <19080ac6-8fb5-4ab5-9dcf-de84440a9181@amd.com>
Date: Wed, 7 Jan 2026 10:02:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] drm/amdgpu: Remove arbitrary number of contexts
 limitation
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
 <20251219134205.25450-8-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251219134205.25450-8-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0398.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2a6342-cca8-49fa-04b6-08de4dcb73fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGNsSUNXRDIvQkJlcEVianlLa0ZRdnNrbGxPQW9iV1IxYXlyREFpSDBOMkNY?=
 =?utf-8?B?eTg4aGZHSjdTYlNHMjliTzU5TU9PdDQrTTVoQ1R6d2FLWG1SVXZGR3BwbWth?=
 =?utf-8?B?Sm9VdmNmbDlXU1E0eTFWazhKbGNEdWRoSWVzU3ZvYXBXeWozV3FkUTFuOHg5?=
 =?utf-8?B?clFSUWVOdHVCMGxnV3hidUdoV1ovcFJDdUVWMXhLV0hSRC8rd0dHbDNRWU1n?=
 =?utf-8?B?ckZpOHllMnNVN1lGOHBKL0Riem1kMHFUeWFzYlpHb2ZVejhCR09ESmJwbFBq?=
 =?utf-8?B?SzFrMXBkdzIweXVraTNqUUg1TDFXaW5UNUI1NmJMYUlrUnpIUG0wZkRmRmg5?=
 =?utf-8?B?eEl1aXhHa3JYcStrbzg3empxRWJtL0h3V2g2SVRwZXJUSTJPUFdsZU5XRUNZ?=
 =?utf-8?B?UDMyeHBmbTdBajVESVJsbEkxSVVhZEdMNHEzblZtM1RUWGRsVzFBejROTDBH?=
 =?utf-8?B?NjZ5Tmh1dFd5TUNFRU12am9yTG1QejBzOW1iSG0waC9SV1RkZGljZ0k0M0Ft?=
 =?utf-8?B?dHhPQVkzZkJOY0xPdVBsYzdkcU1uSjA4N2hYL0k1dEw0TmgxMWtSREpJZnpl?=
 =?utf-8?B?eDVzVTJ2T1gyVm9wY0oxQ3lWRDJIQWR5Z2o1UVlMQzN0VUlaY1pRWERJQ3FC?=
 =?utf-8?B?L1hSTFl1WHNNOU4zTkVNVlczd1hQM0pETjRZclByeWtYa0ZONWN3Yk1Bb1pi?=
 =?utf-8?B?VjhtTk5XVVZEUS8yNEFDTTRsNWF6UTlYV2pxbGtVZnVCMlljKzlLYVhTN2R3?=
 =?utf-8?B?cjJMRjlndVI5QWtwMzRQamYrL3o1WkhuLzFJNVVUZG03OS9HdjNrOXhYZGRs?=
 =?utf-8?B?LzJLS2NmSnp4MzBoaHByRjdmclNpS1h6SU8vWlQ4SFplV0M5amhCMFBZZTZt?=
 =?utf-8?B?Vnp5aDEzUkNENStYSTFJbFBMbjhTajlOYTBzWTZLWjI1MjVMOGptbkhaQ1dK?=
 =?utf-8?B?Q3hpNWNnZi9mSXVDbDRJOVNHTERiUjZkeTU4QWtidnAzZjFOY1JKSHRIdE9l?=
 =?utf-8?B?QmhnU0tyTnR2Qk9Ic0JjVWp0VEZMNkd0SHkwQlgvWnBidUx6VzVQMHh4bkNk?=
 =?utf-8?B?bnh5b0Fva3dHVTd4SjR0ZkJBTWRMQ3FGdG05Z3ZyWURuR0JVY0pSVXk2QXpD?=
 =?utf-8?B?MlNGWWV5bHBoRldKM3FkenBZcEJ5UVR0VmRTMll2QnNuM0x6ODhvWWRmK00z?=
 =?utf-8?B?azEva0JUU0ZvajhSZjlYd25MUHljWUlqSllnZ2YyR3ZNMmFNNWRDMUc4K0p1?=
 =?utf-8?B?Smt0OHRKUXc4Z3M0K2ZPT2lJTW8rbDVRY3JwSTdOc1dDZmhZNG9iN2FVR1JJ?=
 =?utf-8?B?eXB2WnpCS3JURDR4Q2ZhZC85Zzh0aXZtbWxwbk5vNm8xcXA1cUZ1MC8wREV1?=
 =?utf-8?B?cnVRdy9rNy9KcTJFVEpJQVJIclZ4MzdxTUxwajBmdnV4Z2x0NzNQRWJaNCty?=
 =?utf-8?B?ck1ubTYrUnpmdWdscC9iVnd2dDZpdzFmRnd4M2hITTk1WUplaHhNamYxSW04?=
 =?utf-8?B?OFFYZTg5TGlhblh5UXQ0TFJFMXBibHA4empjVmlIWitoSlozemI0cVVnRGRs?=
 =?utf-8?B?MUZTR2NraDQxUUpTVGFRRzRqM2ZxS0xaZ3BFb3NCL0dUL3ZKb1lWcGZjQ2FJ?=
 =?utf-8?B?V01GVkx6WEZYQlc3VFVKT1UybS9NdTFEbWxJUVllNC9xby92eTF0UWJFNlJO?=
 =?utf-8?B?M0Q4cnZ6bEw3RDhhWC9pWm1NaEhKVHFvbjRqNUJKVzRSZWZoQkJyZi96U0NT?=
 =?utf-8?B?aERTaGJzU1RBUWRWaFQ1aWsxOFJDK1NVRWsvckQzNXB4aGI5a1hEeXZxV2oz?=
 =?utf-8?B?cVE2NlpySnRLam51SjFUQVVUOG5HRE9BUTByakFoSTJTWmkvVXdBZnZnc0JR?=
 =?utf-8?B?eUd1MGh3RzQ1TkFucGppTkhubmREc2w4RW9McUtibVVpNTdualUyN1FqR21r?=
 =?utf-8?Q?a5HJisz7lJQKgjGWbZYF2D+xJkUPgdZl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUpyZjNTWXA4ajd6eGV2TDQ1bzh4RzR6SzJKdGZNUFZESkxoTG5vcm1VOEFN?=
 =?utf-8?B?cnd2TVNXK2NveVZ2Y29yelZqZEV4M2VOUTNFa0kxU2hyNEU5WCtvUW9EMW9K?=
 =?utf-8?B?bWZ0QXNEUm5DOFpKUmMvZGlZMnZncVkxZ3BnY1I3bjFpc2wwVU5oamxVRmZS?=
 =?utf-8?B?STF1TXpOallZNWhVdWxBcC9qRUVmQzdyRTVVOTlJajFnNk1mcHM1RGFMNU9v?=
 =?utf-8?B?SDMza0lkWGVIUlVJU1RSNkJaN1l0Y0RvMVBuK3kxTElVQmpjbVVsdlU2TTlG?=
 =?utf-8?B?MldLRHBVRWZva0lwc2pFblV4b1NSWjZvd05reXZCa1VwSVQ4MjBZM2EzWks3?=
 =?utf-8?B?NDQ1S2FYNm9PdWhMenlRRkFMaG1oZWJsWlhYTE5RUlAxK0hYNlpJaEc4OW9X?=
 =?utf-8?B?MEpVMkFjVWxaeVBUVVZvMDR5Vjl0ajRiaWphK2FCSExWbzhJL1FOSjJXTTZW?=
 =?utf-8?B?OS9FdWQ3N0RWVUVCUG9xc3NCOXZ6SmFxSmFJdWNvUkcwSElSSlBraGtvaDZO?=
 =?utf-8?B?K0JMenM3TmRtTFhEWFdaUlN1anpZNUp5emRQK2tHNVFMTnEzY0VEdjlYeFVS?=
 =?utf-8?B?K3VkSnlldDlaR3M1Wk9FZDd5d0NOR0NJRHJCTFpqUjFTc0xQL3I4a1FtUEVj?=
 =?utf-8?B?UmJiekFJNHk1NHY0ZHRySnJaMDd4Z2EwM29WY01GMlVibkRQQ3Y0M0RtNmo5?=
 =?utf-8?B?Z1JleHI1dXIwTlg2QjQ3Q1ZJVERYTHlYaHJTMStQdDcrdGdaYy9sT21qT3Z6?=
 =?utf-8?B?SVRRN2ZYRTltekdOTldDYzEzbWxQVVI1R3ovbkV3OXF5U1VBYWhqTVVJZUZr?=
 =?utf-8?B?MUU4VlRRdDJGeFZjQ0F5ZzRSWEF0RzE1R2IzdTZBc2FKU3JUUFVCTlZ4OGtO?=
 =?utf-8?B?aWFVczFrdW5KMGhLOXYzN0FWbmxFc3JxbTZpUjdjTjRUWURtejBFUkFOY2Vx?=
 =?utf-8?B?MXVWZVJlMXlmbEZudmdMeks4SS81Wkp3UDY4eWxvOWIrb1dMaHJKaDdSU1dD?=
 =?utf-8?B?bG5xc3V3SWhVNkI0amxaNytxTi9IbWw4K0FrVjQ5bXBLY1dKMGRjbDcwRS9L?=
 =?utf-8?B?a0ZFM3FsWTRtRGFaLzdvNkhLczN6c0REb0NKaVh0VFZ1NUk0MVFSbHllVXUx?=
 =?utf-8?B?SmdrRkpnajF0ZmpuTFVHQ2xUbEdJeUNlblUzRmFvOVArUWw1alJIL21QVnpo?=
 =?utf-8?B?MmhjbHZPZXhsbzFHN3JMRkhlc2tKTGtIUE4vUHJablVQSHJxNDBlQ0E0NGJw?=
 =?utf-8?B?ZHVzS1hUakVqU3JlczVlNmlrMzE4azRSM01RRFU2NDlPRHhrL0NTUkNzK0Nm?=
 =?utf-8?B?RVRYMldRN2VVNTRIMUxpZGM1OUlnTVJmMWt2eVkycTdRY1B4RWdJTVlsb2Fp?=
 =?utf-8?B?eWtWeXdBODdnTU05ejV1eDNJaFBpZEhjZGV5V1dxUForSFNGUkc1a09Hb2M0?=
 =?utf-8?B?V282N3ZDZXZya3VjNnk3MG52dzMyZXFHOGxjazFWSTRtL2hyNEErWm9LbUVT?=
 =?utf-8?B?aWtTN0JuMWpqT0pOYk1OWGpMVlhuSk5scmlGYU1mbHdNMGlwVWU4U0tUbUxN?=
 =?utf-8?B?dFJXUU52eTZ2ci9UTTdkdXJDTlFEaERQNGsvVVRBNTBJT1VBU1RpdHk1cTZJ?=
 =?utf-8?B?MVJOekZFTFhUd1BubHduK1FZWStpQXJhSnp1M29NUEhKR0lCSjY2cWFLRitQ?=
 =?utf-8?B?VTJSY3MrTDUxTXY4U0lWUXQ0bmlHMDJTbHVLNVdTRHlTQVRQRTFveUl4MXQ0?=
 =?utf-8?B?azZQOG1jYXRWZzg2YTh5K01OY1g3NUZlSHQvTDBESUdQdzhqNjQ3ZEJkVGJB?=
 =?utf-8?B?b2IxTWlmUXNLRFRhaFpBamgzNXNnNzFDTC9uUGVIbFNselp4bTcxRlkwdEt2?=
 =?utf-8?B?czVhaklsRXZvK3JlaEZFVkx1MFVaTERYN1J4Rms0SUlXWmxYYkoyUzNOQXN2?=
 =?utf-8?B?dWpkcmtTY1JwMnh5aUxQaHVQZmY5aldOeS8xMHdBUUpLQ2MrbW9ickt2UXFZ?=
 =?utf-8?B?NXdBRURFOUNGaHJPR3dWeUF6R3lMNGVMekEyRkc1QW9tK0pDWHI0cVBSQkgx?=
 =?utf-8?B?WkIrbDhTbWNkSmQySTZUWVlzZWNqVHUvcHZjaXBNTFJvd2JjcUZvaUlYRmZj?=
 =?utf-8?B?NEZqTENEcEVLZ0o0MmFPMERBcWl5MVJCbHN4V3pJZk16dkZsOFBmY0Vydm9Q?=
 =?utf-8?B?aUlDQlBDdHo1akFBdFZ4cFlWN2JsTk5DYTlKRXFWOG1GUVhjWGlJL3VpZ2p6?=
 =?utf-8?B?bTVCZkpBMzg0UnR5T0lWWkhrcmVXQURsNW9hc0QwcDh3L0FiRDNGUUltZ3I3?=
 =?utf-8?B?cW94VWFJZGIzN2lyaDRJUjVJSW8wWmlnQmVBUmpVN3cwRVo3RytEUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2a6342-cca8-49fa-04b6-08de4dcb73fe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:02:15.4503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3CbTfwLL0VC812Yky03hPsUbKbDd9wRbBo8JENdGCEb/q3cHEirT/tcfJn1C8g0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
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

On 12/19/25 14:42, Tvrtko Ursulin wrote:
> There is no need for an arbitrary limit to number of contexts userspace
> can be allowed to create. Remove the AMDGPU_VM_MAX_NUM_CTX (4096) and
> allow for full 32-bit of handles to be allocated.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 6 +++---
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9f9774f58ce1..80dba6276aa8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -274,7 +274,6 @@ extern int amdgpu_rebar;
>  extern int amdgpu_wbrf;
>  extern int amdgpu_user_queue;
>  
> -#define AMDGPU_VM_MAX_NUM_CTX			4096
>  #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
>  #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
>  #define AMDGPU_MAX_USEC_TIMEOUT			100000	/* 100 ms */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 41c05358d86d..dd1e562dbaed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -484,14 +484,14 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
>  		return -ENOMEM;
>  
>  	mutex_lock(&mgr->lock);
> -	r = idr_alloc(&mgr->ctx_handles, ctx, 1, AMDGPU_VM_MAX_NUM_CTX, GFP_KERNEL);
> -	if (r < 0) {
> +	*id = 1;
> +	r = idr_alloc_u32(&mgr->ctx_handles, ctx, id, UINT_MAX, GFP_KERNEL);
> +	if (r) {
>  		mutex_unlock(&mgr->lock);
>  		kfree(ctx);
>  		return r;
>  	}
>  
> -	*id = (uint32_t)r;
>  	r = amdgpu_ctx_init(mgr, priority, filp, ctx);
>  	if (r) {
>  		idr_remove(&mgr->ctx_handles, *id);

