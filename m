Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B646DC02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 12:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69ABF89C05;
	Fri, 14 Feb 2025 12:39:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5d4EKyc0";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E69B10E315
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 12:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHj3m1QN2wA8KiwJYwMBiVIDrFz2uVdVlbMi55SG8Ew5kpgjIPPMnHnrg1bbYaqGgftr/Zj4MwA7Dzp+cR6we51sUIQdsyC2Z5+UVUr1gMsJvrQsdADoD/X274MMiyQWwOduUy1BGPJ2HZefd6Ys22SMs0nGpvR47Q2ff/93KKJES0M3ihz5c6byRuNFsiGBC+aKh3eJlvRzpLERIcEu6gEJb4a8d0w8HIhRQpQ6kdIeB9hjaHN1byysHOA5QDWCWyV6ywLd0upskhVPY+aWeJUVQfbPZ4tBZatdfomy3pQI2BAC/9/jHUrm20xXSegyUEyn6I5c7JnVSQwd4NKIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7nmfJ0G9kbE/AVw/APjFJGhLtrE9ntqxbZTdnb3bzQ=;
 b=TateeuRW0H3oEJssmo35IGSGz4qJh31ZaQOR87lB3YqfKdgX4j518sTqzsyUyr5pwwdkOYOwY6jW+YdkC5UCUDTFcBXCv9975FS6ppqDSHuCUtyeyQTvOqBPBPMWTUbGKtfp23k9hMzNxwSWZL2FFaIKpob4EtrugR/HpZV7EKLr8qy6usx1M8ehlWMG3CAbrs69NZRUcjeEyPiEqepm7Cct3wCZDWlExja0zkSLHpDrLcfUqqgO9LCzjlOjhG5dGz9e0NKVlxMGn0yDlc2xGY5hyDfoCAy//oj8PVAOxK0LlPLwWZr+z0jV2DzPPldaHrvuY6UajjpyiWuf7k8ydA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7nmfJ0G9kbE/AVw/APjFJGhLtrE9ntqxbZTdnb3bzQ=;
 b=5d4EKyc0HpnK1Fm5HPldcoOia/yFBMIw84gQNJjzicUWEwkH4PD776mTJk3REd/Hc6eT204pS/9dn5+8LXnjnrXLKwZd4ZauixWMlxcZCGxQAaO29MSBEeLlyogU6EWEwCWhDHC0GvamLegFRu4gGwVCr/01mU+3l5wnV+nmmts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8143.namprd12.prod.outlook.com (2603:10b6:806:333::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 12:39:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 12:39:10 +0000
Message-ID: <432061f2-1695-4a18-bbdd-228949b73037@amd.com>
Date: Fri, 14 Feb 2025 13:39:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: fix the memleak caused by fence not
 released
To: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "Yadav, Arvind" <Arvind.Yadav@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
References: <20250214100718.2663073-1-le.ma@amd.com>
 <0e49dc7a-d932-403c-88b5-9b16ab9477d0@amd.com>
 <13d5afc4-4f97-8fe7-0c05-647bfb768abc@amd.com>
 <PH0PR12MB5420391BB3877E5DF10F1451E0FE2@PH0PR12MB5420.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <PH0PR12MB5420391BB3877E5DF10F1451E0FE2@PH0PR12MB5420.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: e8208fa5-5eeb-470b-68c3-08dd4cf49429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1N2WWN0d2taUjdhR09jajRPVmVJbFkxNGpQbTJidTFVVUl6OC9DME9NU09R?=
 =?utf-8?B?djQ4LzgzRTNVYVd1cnJlYlZIWG84R285Vlk2ZU01WW4zT0hVM1FXTmkweGVF?=
 =?utf-8?B?MXN2d0NJMzdPQnF5MnFlUWkxZVRJZVZBL1kwNDhXdGRsQytrMW9OTXZuL2dP?=
 =?utf-8?B?OElja0xGcW1hUW82QXpZSzU2eEVQODJQQUFyUDl0bTJ2MlJ4L1ZyS1JsQkEz?=
 =?utf-8?B?UG1EY2xCbG80T204cWhpRTZyVGMzZnVWTWZhNEhjbE1HbkJBOVlyK2RjTnJ4?=
 =?utf-8?B?TUVObFlzSjBRU1FXRm4yenpBek4yUTBZRmQrUm9IKzRGK1BBYWxuUG9CTXlV?=
 =?utf-8?B?SmpqUmh1Y0F1UVlwREJMZzRYaUMyMlZLcTlhcVQyZEhqTTZoaUNicG5haFNn?=
 =?utf-8?B?OXFGczJEanZLM05UQVlyMnQ5RWVZTnFoUmpOK0JaakdmZCt4bmFqYmF3WlRU?=
 =?utf-8?B?THhWVGR2THY5YW9CNENjejFCZ1JRK21KOVNXQlpKRy81Y2VnWCswNEdQTHRG?=
 =?utf-8?B?UUxLc3JrYloxS0QrNGJvMUVhNG9FZmZvVnhuT01qYlQxaHozeFlFNmtFdDg2?=
 =?utf-8?B?cERKSnlFU0VrSVd1OC9LMVQrd3ljOGQ0Tm5vS1djV1N3NFIxaXhZaEFBUFlv?=
 =?utf-8?B?ajY1VlFMWk1pK2s3WnAwMEtXN2hldTlMOWVTSW1FYUg0TDM5UEJzQW9JZk40?=
 =?utf-8?B?RDdsVE1SM1ZwUXk2UzhaOC9RUkFWVW5wOW9Db1ZyMUY4cWM2WnRBUHZpc0Ra?=
 =?utf-8?B?MGtzNFVqSk1aUGRhQ2Rpbk5lQStWZENGMzk5Y0VISTFwVW1NRHlGZW5FU1Fa?=
 =?utf-8?B?cnlwTXRVb0t3YVdadElRbUR6SVVlYUxPZG82OWxFb0N4cWtXNlVNNS9uTjg2?=
 =?utf-8?B?T2hnd2V5N3JaS0NkQ1k5MlhNTXQ5c2R3bnRlcW5zNnlWVTQwQStob1Y4VVln?=
 =?utf-8?B?VnhjR2tuZmFMa0lYckZDNnMzc3VQWGkwdDNIZk0wdERlbTlDbHRFWkpjb2ZG?=
 =?utf-8?B?UC85dWZGeWM4NDNCU0ZDQzBvV0o4TzdFNGhMU3VSdDhySFdWTXM3MVM5T2dK?=
 =?utf-8?B?VFJMamJocW80eU1ycFV5a1kwa1I0NENjQXNaZHBieU14MzR0VkNZazBpNUc5?=
 =?utf-8?B?dTV5cWpFSllKL2Q5YXk2cXRhcVVkNTZyaE9tbVNqMUJrdDFKZll3NGdDOUp0?=
 =?utf-8?B?Z0ExNUw2TmpXb29KanNlRVh4MlJhTXVVWTlJWTF2eXFMYlB2dE9ubHVPWFYx?=
 =?utf-8?B?emhYWndZc1ExcU4vZCs2SmlYYjVFRW8xUy9SL0VjSHIvdmNoU25jRU5NV1Y4?=
 =?utf-8?B?TmRDYUtETWNjVHJnOHdQV2JSbnducUlaMU9LMTJibDg3aHNPR1h2Z2lYSk9y?=
 =?utf-8?B?R09uN3lPaDJLLzJ1ZG9jTEZoaUk1dytVRjkxTStJN2dMaDF5S2lxY1NUVWh2?=
 =?utf-8?B?bVR6TkZ1V0ZzeFlCTlhNd0UwNHc3MlBrUG80Nzd6Z1NFYk1Hd1RvN1Bpc3Ba?=
 =?utf-8?B?WmhpRkVWWVZMSWM1bENjL3RhZkNZbEdqRVgwK0MxTFpXNlE4Y01EYWNoZ0ZI?=
 =?utf-8?B?cXV1aGdZTlpBRStkWHpsV2tyVEgwVmloZWhpTTN3c0Z1bGR4ZUszM2pzNUZI?=
 =?utf-8?B?dTFtUmtFQ3U1c05VNno4NE5TRFNsOTlhSmlOSjJIVVZIZTA5S2NCTnVBdmRw?=
 =?utf-8?B?djZDdldJT3dRQlRZbHRFUWs4a0Qxek9wNnl3RE93bTNuSXdNWC9LOHlUSFRM?=
 =?utf-8?B?Uk5PbWZ2dTN5UUhQcEpQK2VwdW5KK08yTVhHLzFvVUpnTk9ZdWVRclFkZG1k?=
 =?utf-8?B?Y2F0UmpHUVVJZkFab0NjV1JieXhyTFkxU293QU5uMjlkMEdBTVlvakQ2aXpt?=
 =?utf-8?Q?tkKHtmx/WkCuU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0NuLy91bnZ5Um04SThGUUpSODRkM21pS2FuS0diRFlteGZReVNkUzJIM0Ra?=
 =?utf-8?B?aS9pazBlNEcrQUZwTm1icThHK2RkR1dJdGU1THA5ZDdhaGFrVjhWWkRrMXhT?=
 =?utf-8?B?bHRORHRNYkZkc0RyQUp1a2N6VW9aeG9JTGFZakVQSVNuUEJoMGwwNGpGUlJG?=
 =?utf-8?B?Z2ZBeS9QRyt0dDU0NW45cWtYN0lpOGNtWlNUTGNyNHRkSmh1SU9nSEpMd1JG?=
 =?utf-8?B?SHB6TXVNQjJ6WE4xdDI5Q2ZhTTFiRjNUdVZraFBvUC9HQnlqckhIbTNmN0Zp?=
 =?utf-8?B?QVppdGU1d0xjc09pVVV6VjFxUFFKdjVqQVZ6b3pUWXdFM0pvbWo2dEVhNzZv?=
 =?utf-8?B?cG13SWJGNEpjVlNRMGdQK0xNZ0pNeDdHaEdxVkpBK1hOYzhwUUdXc3lrMkR2?=
 =?utf-8?B?aktkTTE4VWZBSmc3WDJ5QmNOMEhKOUJ2TzNlb2JlQk1LQk9HNW9ISkdjaHlz?=
 =?utf-8?B?Y2E3cDVZVWZzY1JzTlBiNm1hMXFORFZ6THBGQ2R0bFZndW02VHo5R2tOZlBj?=
 =?utf-8?B?STUrMCtxNGVIRHJBNlp6L2pLM2JuZWtKRm8zbnB6RnRSSk41UVUvWkFCMkhJ?=
 =?utf-8?B?YTlxV0prRlIzS05lOC80YW9MbEo0ckZoYXB6dTJQQzZVK0twbCtPRy8wYUxC?=
 =?utf-8?B?RGpKcENGNXJocGh6MnE2enhGaXp1TTFteU80YXJuN0pacWdGZUNadW1TUWNT?=
 =?utf-8?B?VFl6bURQenhPK056WWhiRHp4N3JGN00vZGMzUnorRlVDV3lxZDNLZ0tvcXFB?=
 =?utf-8?B?MjFWcDBZM21aWFV3cHpibXVNeVUwL04yOUw4Snp6aWpLbXNBSkt5WjBydnVo?=
 =?utf-8?B?c1ZrUVpLajJnVkU5VFRJYllEK1BRSExqQXo0R09CSzNHdEtFamcreGdSNE00?=
 =?utf-8?B?QVJ1OFBMUkVadjk4SzBCd2ZHODFWQ1Z1T0pQbDhZL0VrSmttVi80cVVKcG5z?=
 =?utf-8?B?NGJEQkNDajNvQ0RBYVQ4cEZVdWxSd3RPdjFmRElucGlza0dPdWpoTFBkdWV0?=
 =?utf-8?B?R3JUdGpza0twb2dNQ04zU1pjMVdHaWdlQzAyZmRtV1J2YVZWMFhVNElWdk43?=
 =?utf-8?B?SVgyQWVURXNRRnRJRGpKRnRCKzBYeU9tUmFIU3E2Z2Z2T2RaeEtFTjhxeUQ0?=
 =?utf-8?B?MmRlNzUwNVFvUm1Qc2JmU01MNlhxTFNDVTdXMlZlUytzVUFoZEFFN0FWLzBZ?=
 =?utf-8?B?RndoZnNlcU8yU25QL0s0K2tWeXB4RWJEM3ZoMmd1eDVseFNUQmtpZGN1OWVW?=
 =?utf-8?B?aHVIclBvdXM1WGpiM25PSTJtUmdDQ0JlS1BZWER6OVU3Y2RmUi92K1NxaVBq?=
 =?utf-8?B?ei9yWFgvNE1OQzJpWC9wVmU0YzM3dVpSMXcwMVBBbXlhWjFDK3k3UDJ4SmxU?=
 =?utf-8?B?RHFhQk1GTHl0ckJaZlo5WEtIcFB3YytSdG9zSDQ5eHNSNHhVaTRzQjI1U2RH?=
 =?utf-8?B?YUNDckFSTTBUK0dLcFBPdEhWNXVvMXAvQUtVa1dPaUZNN3YyNkhxcmdRZjZM?=
 =?utf-8?B?SVN5bjZWaWIvMDlVNGlTb1F3TW1FN3h2UW9LZFJrNk9RYkdGSUhOK0VHVUxR?=
 =?utf-8?B?aGh6d1ZxUXJlWlQ5enFMN0dNeFlZN1Q3YVFLeitheVY1WE1nNk04ZWR4RTdC?=
 =?utf-8?B?bkExYWxZWXFqMmF1UW0rNjFJUUx1ZTdwNVVaeVRDcHRsV3V4YytROG4xSDlB?=
 =?utf-8?B?N1ZKbWh2QVB0R3poTHJjUjIxRVpqSDl0YXg0L3NrWFhRRjZYeC9DNWp0S0lW?=
 =?utf-8?B?c2JSTzZWRWp4RzNWMzFmY2FwdUUzVlZXdXdvZFNXK2tILzFFbFdDd2ZoSXhZ?=
 =?utf-8?B?ZWxBbzFCT1kyWEgrYnpCMXA4VGtBVi9XdlJ6SU5scnhlSWVWdmtHamkwQjhD?=
 =?utf-8?B?R1lXclg3ZkJuY3VqZmw4bkhUbjdKK25SMFM2THFSbkJ2czJkSWtlNmoxaG4x?=
 =?utf-8?B?NzBUVTJxTjZqVklyaWJxNXVHeCtaNG4yZ0haYWFWS1VWbGJ0MXB4QU84Y2Rp?=
 =?utf-8?B?Mi94ZVFIREtMbkx6SG4wNlpBNFFtOFJaUW9sUjJDNFFKMFF2M1NsSG41aHBD?=
 =?utf-8?B?NllSUTcxT09ZMzl1QWlkWVp1dGl3M2YxdlZsWjJZMWM3SmFEcWtUVDFsTTdu?=
 =?utf-8?Q?WLdgw08CcoFQ904x6erM3spx0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8208fa5-5eeb-470b-68c3-08dd4cf49429
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 12:39:09.9348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQAkOb1CDbMhs/MhpwnQxP1AKZsFxeeim1MlbB+SKjisuwI5uYn8KXX9cwS1sv1b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8143
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

Yeah, completely agree.

But not checking the syncobj handle before doing the update is actually even more problematic than leaking the memory.

This could be used by userspace to put the kernel into a broken situation it can't come out any more.

Arvin can you take care of the complete fix?

Thanks,
Christian.

Am 14.02.25 um 13:14 schrieb YuanShang Mao (River):
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Better to put the fence outside amdgpu_gem_va_update_vm. Since it is passed to the caller, and the caller must keep one reference at least until this fence is no longer needed.
>
> Thanks
> River
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yadav, Arvind
> Sent: Friday, February 14, 2025 7:42 PM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Ma, Le <Le.Ma@amd.com>; amd-gfx@lists.freedesktop.org; Yadav, Arvind <Arvind.Yadav@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
> Subject: Re: [PATCH v2] drm/amdgpu: fix the memleak caused by fence not released
>
>
> On 2/14/2025 4:08 PM, Christian König wrote:
>> Adding Arvind, please make sure to keep him in the loop.
>>
>> Am 14.02.25 um 11:07 schrieb Le Ma:
>>> On systems with CONFIG_SLUB_DEBUG enabled, the memleak like below
>>> will show up explicitly during driver unloading if created bo without
>>> drm_timeline object before.
>>>
>>>      BUG drm_sched_fence (Tainted: G           OE     ): Objects remaining in drm_sched_fence on __kmem_cache_shutdown()
>>>      -----------------------------------------------------------------------------
>>>      Call Trace:
>>>      <TASK>
>>>      dump_stack_lvl+0x4c/0x70
>>>      dump_stack+0x14/0x20
>>>      slab_err+0xb0/0xf0
>>>      ? srso_alias_return_thunk+0x5/0xfbef5
>>>      ? flush_work+0x12/0x20
>>>      ? srso_alias_return_thunk+0x5/0xfbef5
>>>      __kmem_cache_shutdown+0x163/0x2e0
>>>      kmem_cache_destroy+0x61/0x170
>>>      drm_sched_fence_slab_fini+0x19/0x900
>>>
>>> Thus call dma_fence_put properly to avoid the memleak.
>>>
>>> v2: call dma_fence_put in amdgpu_gem_va_update_vm
>>>
>>> Signed-off-by: Le Ma <le.ma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 9 +++++++--
>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index 8b67aae6c2fe..00f1f34705c0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -759,7 +759,8 @@ static struct dma_fence *
>>>   amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>>>                      struct amdgpu_vm *vm,
>>>                      struct amdgpu_bo_va *bo_va,
>>> -                    uint32_t operation)
>>> +                    uint32_t operation,
>>> +                    uint32_t syncobj_handle)
>>>   {
>>>      struct dma_fence *fence = dma_fence_get_stub();
>>>      int r;
>>> @@ -771,6 +772,9 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>>>      if (r)
>>>              goto error;
>>>
>>> +    if (!syncobj_handle)
>>> +            dma_fence_put(fence);
>>> +
>> Having that check inside amdgpu_gem_update_bo_mapping() was actually correct. Here it doesn't make much sense.
> Agreed,
>
> Regards,
> ~Arvind
>
>>>      if (operation == AMDGPU_VA_OP_MAP ||
>>>          operation == AMDGPU_VA_OP_REPLACE) {
>>>              r = amdgpu_vm_bo_update(adev, bo_va, false); @@ -965,7 +969,8 @@
>>> int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>>                                                  &timeline_chain);
>> Right before this here is a call to amdgpu_gem_update_timeline_node() which is incorrectly placed.
>>
>> That needs to come much earlier, above the switch (args->operation)....
>>
>> Regards,
>> Christian.
>>
>>>              fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
>>> -                                            args->operation);
>>> +                                            args->operation,
>>> +                                            args->vm_timeline_syncobj_out);
>>>
>>>              if (!r)
>>>                      amdgpu_gem_update_bo_mapping(filp, bo_va,

