Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A90C4452B
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 21:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBA9610EB78;
	Tue, 21 Jul 2026 21:20:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xfRqWzzM";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012014.outbound.protection.outlook.com [52.101.48.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA62510E2FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 21:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qq3QDcCJ334c3bG2c4k2xcsq8W5gLzmwgq1qtOz+pg7nIP9uYZ7k7bYWctys1qFNoLnUdvExEDSgCOeZz6dNn4yYY6rmeskGOgRr4mUKxxTlJEK42I7OMlGRyrCKoQwtOu4Vm4+ev9g1G4g6mze7F1KVZf8gqYr/8KYK7nnQOPI/b8yl482cvGOoXcWDp6rgh3ZCycW4FzSUNvW4GqFnUZGN2GzxrDOFofUTZin54vHsIMN6xZ0OQWjjgJn4xJHnaowj9UwkTPLfesyoJpSm42VZOW1qP9w4Rfciru6XOHlRu3Etl6GC/xJMhJPsHgS9Cv5O6yWwpomEVq+hzXuAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwvSh2gEWchu4YrHhfvFKQg70rWwuCep96YhuJon2hQ=;
 b=j4lCU4UzOeOHEhh/KEGph6BC2502ZE1IxKbzn19A6xZ5ObS1gQF4uUVyRPtepBXVYkhlcZpgxqG8i0tOGEc+48vxu2nhC3NWL1BpNGGI9b8ShGkxOzAJ0xMdxZ04sDM0PX/cwm1nxJAM2DUrfvVujKO/mKUGCKUIhgX5r7xjFF+ZBTqBSRw6KNMzMFZaOb0BzVbXRgGa+NDr18wiPqCcuDplcrNYkx/ZnezGe+amFEp37xRvjiJ6PB5I9lVRNFXfcEc4tLumUNnaZgliKBZq6dUdtYaVJSsjzZ3L5RvkjzVJtKnqEnNf9y8eGeApMYe+Zzn0D8dcEe6ObNifkKYRXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwvSh2gEWchu4YrHhfvFKQg70rWwuCep96YhuJon2hQ=;
 b=xfRqWzzMc8b2sfAn2TANs+XxeoEJwdEIgRpoc8Jqgq8+9QwHcKFEEQmbGEvxDXmsDknIXDHouevdJTW2Qqvm8pd4h/k6GO+tdO8US/PzuNo5OafbGtNBTUKqx6R6/p4PPac0shVMf/IHprNTHTO8sDpqJyF7C9eL1gOy1xI931k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by MW9PR12MB999209.namprd12.prod.outlook.com
 (2603:10b6:303:301::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 21 Jul
 2026 21:20:22 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 21:20:22 +0000
Content-Type: multipart/alternative;
 boundary="------------mwjnS2DnkQr6456ZLKiyxEdX"
Message-ID: <1b4941e0-b2dc-4506-a40c-937c3de37084@amd.com>
Date: Tue, 21 Jul 2026 17:20:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation when
 MQD is in VRAM
To: "Fan, Shikang" <Shikang.Fan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: "Yang, Philip" <Philip.Yang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhao, Victor" <Victor.Zhao@amd.com>,
 "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>
References: <20260715103056.3529178-1-shikang.fan@amd.com>
 <20260717085357.41610-1-shikang.fan@amd.com>
 <da934005-b10b-4e86-b8b0-a910e59b3d66@amd.com>
 <SA1PR12MB73439B22EB3FB6CFDCD16438EBC62@SA1PR12MB7343.namprd12.prod.outlook.com>
 <SA1PR12MB7343DCAFB25F4BA191AA3A6AEBC22@SA1PR12MB7343.namprd12.prod.outlook.com>
 <SA1PR12MB7343FE954902BF06C7996A90EBC22@SA1PR12MB7343.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <SA1PR12MB7343FE954902BF06C7996A90EBC22@SA1PR12MB7343.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::23) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|MW9PR12MB999209:EE_
X-MS-Office365-Filtering-Correlation-Id: 52034b55-9bd8-47ba-7a7a-08dee76ddf89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|6133799003|8096899003|5023799004|4143699003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: TvSgEyldf+inTgAPmf/EYigdbhvshC1+VaozbV4cIe2xFaD11PvCqO7tFirFwQjwh69rJeujzDIaL2OcmyShQoXIv8F1VOOt+N4JjDJwQjX3Gp8c8LfmsMPYhLYfgLKrsF7o4cJoygrEw3eBwB+GK7j1TanKA82cYylUllG10WlmI1BDGYE3ZH1lGrUb3QkQFB8vAM9KAheII3u7TWUI+x4MIHFDmL4X3ayCPaPu+palcD9nuSAxPC22qsp3YVKIaB0gIdQP4wN4ImdFJtmXJzB3OGf85wFe7lEsorjsMLYsHpJmuV1AH7EfvBMbOrPhekel6QuaiK41PP2emOa+iBEzO81JbOeEZu515oyquTyHWks8ahSQHKkjhwiSts3LX6/scPl8qu/2wDu/T6O9b8v1+Z2/W9VH+VnHq9RQHHzSKNPvWk7tVSE4kHS5zgkBvNwQF1XSSRS3iSmhGIh3kCipK5bEXIhLEX5Wia7h4vxMlKflv5hgPOu1+kHVPGpkbngWzB6lfRC3HNWUmUPB5Ppj8ihQ5ipVWsTbzNo/B+qa0CSLV0om+Sfu3aALBCY+0lbgFpfDlgeN+BHOf0oQGWEkBpL02qESYREjP7u0XH6XOfmdkNrK8GiJUWuRRE19kkbi4+tr7LFImMVLcTOfk1i8t/PMMwwpXl1U95QXHfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(6133799003)(8096899003)(5023799004)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW0wYjBQVnk0dFhBMGJVa2tseEhWekRtTTJQRDYrMEkvNE40TU1jQVhYSGJG?=
 =?utf-8?B?NUZBN1RGcUkvcFNDbzZVWnJ5OVZVRHM4d29FT1hveDR5SE9WVWo3dW9GZGg2?=
 =?utf-8?B?c0krWWVCcDQyL0xVQzhVdHJrOWhvelVXdFdxazVINHgwc1BMSzhsVlFvUW5Q?=
 =?utf-8?B?SjVVMng4NHcvcEk0aUU1elE4RTE1L2RCVW91L2p0b2EwWHh3Wk5ETTdQWVJh?=
 =?utf-8?B?Z09vTlNsckJMOFZiMkFtYXl2SEhYc2Vodi9Gd2UvM3VGeTNKKzdmZ1R5QjFC?=
 =?utf-8?B?bmxKZFdqbzBzVnlKbFlhSlFzcVQzOHRhaGxwUWpmbUdHNy91bGhHT3dkcEts?=
 =?utf-8?B?TGt3RWUwUTdtd3lXY1RJeXBhQVNyZm1wK1h1N1N1RHEzamFRWDdKSXdkdUJJ?=
 =?utf-8?B?Smttcm1EZUNxNWxOSFNNdUIxSmVlT1N4NUp4YTA2ZU9FUGhTU0RaUWxLYmdy?=
 =?utf-8?B?bE9FRlJweXIyWkxJUFAxMWJ6eEt2MEF5bHRQemtZSlNWM3krbUZTMFRzWG85?=
 =?utf-8?B?MTFQSkJnYmp0M3FSbTVsTXBzM1N4eStSTFV0WStzZnhzcVN5cndrYUx1N3k5?=
 =?utf-8?B?ZzBSdERReTZBMzRZRDVCcE1TZjZXVzVwTVk1d3lCUFd6Q3BudGg2YXVSL1JO?=
 =?utf-8?B?THJnUFUzOXlMTUp4Rzc1WTYzSjRZNHhIc09YeGs1SXM3Z2t3OUF3Qk5WSENR?=
 =?utf-8?B?amJpWWlXYXphTk1Ocllad3BJNEU3MzduSC9wd0NZdVRBamVVL050ZzFBNnk5?=
 =?utf-8?B?b3ZralRLOUo2UjdpVk0xb2xORVlpM21WZHdRWGFjZW1rbmJWZDhwMTNGSnl6?=
 =?utf-8?B?dFZYYVFSSXJaZ3VGUVlmVGhNNjZDUmNIc0ZPMmVIbnJiSHorWHNUTlRGZGdo?=
 =?utf-8?B?Q3ZHTzhSNWdGRnBqaHFwT1U1TW1sZ0pnczg4Kzc5RmNWLzRsK3BDaFZkeEtD?=
 =?utf-8?B?VVo0eG1KVHdSUEswdVprVk42SXhZOUt0WUc3aE5VUmQxOUwzSDhiSGVmTEtz?=
 =?utf-8?B?aWdIV1hzMk1KclByd0dPbHg4VDlzUVV1elhUY1hhNk50RmZTbGwwdFRnRkpL?=
 =?utf-8?B?MVZXZDJyZ3ZwWEpEeGFQeHR6d2NuNTFxRUZpNy82amJnZm04MTVldWhJYWJa?=
 =?utf-8?B?M0tJenY0VWc3bHgxSWFONW1LT1U2Uzk5bkF0ZGR4b0dUMGorOHdnUzVOaVNt?=
 =?utf-8?B?RHRMekNRNlY3WW1tY0lLeEhpM0hJdDFPay92QU9VWHlDVUdIcjhIaWg2K2RY?=
 =?utf-8?B?SjllWlFqbTJrdy9ha1NBSU0vRDdla2ExRDRCcnhmU3RyZytGbzQ1NUUza0xa?=
 =?utf-8?B?RXFqdGpydEFyZTF5Y29GMnBTS09CTE00MGRPYzZoWTNlL21WRzd3OC9qeFZx?=
 =?utf-8?B?dllRU2JaWFpoYUlsL1NsVElacEdHY3IrUjR6S3I1WDZLNjJHa3BEYUNlWkhJ?=
 =?utf-8?B?LzYwTjd2RjFKdmVlZ3MwRVA4bUJkUkRTRURDQ0dnclFrZk1kQzVuOUhHblU1?=
 =?utf-8?B?M2J4M2ErZzErZzNWdmtRRzhTckYrWVFPUXdpMmtkc05yL2JKanAzeFJVOXRq?=
 =?utf-8?B?TURidk5QYU1HQmIvVHNaR1E2NU9VcDRCbjdxVllCY1JTS1FuL3ZSOW5nMVRs?=
 =?utf-8?B?NXdEaVRWOEpPd2dhSENCMlRWeTh2aWtha3M4bGRmR3E3eVp2M0tIWFhoYnB1?=
 =?utf-8?B?QUdPam1FNE5TOUkrOVRlWDlmNFpTMHd6M2dQZUhGalZoUTJRcUdlOThQMzNI?=
 =?utf-8?B?SU8zR3ZZdUc2aWtORXdhQTNJR1pMdFQ5ME0rSnRjb1RuaEl2T1Uxb1RkM2pE?=
 =?utf-8?B?RERZei84Ymo0UFNJMEg0bmNrSkRxdkl2WFRrbUxNY0Jhd2liZkdqanJKeDhP?=
 =?utf-8?B?dWdUNTRHTnJvb29HMXNjUE9RUURSU3pmZDAxWC9BRWg0S1c2V1lCOVVzS25K?=
 =?utf-8?B?UmxKeDJXNjR2cE5yOHE0WWhnYW1UYUtJTDBXZFZ6Q3REYm1hcVYvQ1cvY3Iz?=
 =?utf-8?B?dkZDaS94YjF6cmR2YnVFTEJ2QUJyR0VZVFZQZW5xM0J5aU9NWCszeTBXa0ZO?=
 =?utf-8?B?SnBDSmVyUU10aE8wWkkwUWhhakdyYVR3amlzNjRhZUcxZTJPdlhFMlFQQWlw?=
 =?utf-8?B?bmtFdnBCckNsU0J0bm52KzdDNEt2Ym9oTUcyTXFySTNXdmpDOEdwVElGcWMv?=
 =?utf-8?B?Ti82cE1PREkvSnZyUnU3N1pzV0wyUTFrNjlCQ0pQZUwySFJ5SXdlbitrR3Uy?=
 =?utf-8?B?eXY2MU9yZE9uMUFyTFdlbjRIYnV6a3N6ejhQRkxYMVZaM3JJbmhXd3cwT01C?=
 =?utf-8?B?anJJamZzQjFLcjhLT2RKdUZJN1ZDNWJyeXJJa2swbnc3c1NqVmlUdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52034b55-9bd8-47ba-7a7a-08dee76ddf89
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 21:20:22.2461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Nvvh3ohvs2MF7z9mk1S/IMkL2Qr2LZyNFs/f22BjGuVU7BCMZgIiTckm6MYp1TN5yAudS7jlBhY2q+jtUnCSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999209
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

--------------mwjnS2DnkQr6456ZLKiyxEdX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

These are all server GPUs. Is system suspend really a requirement here? 
Or is this for runtime suspend? But runtime suspend shouldn't kick in 
while user mode queues exist.


Regards,
   Felix


On 2026-07-21 03:20, Fan, Shikang wrote:
> AMD General
>
> +@Zhao, Victor <mailto:Victor.Zhao@amd.com>, @Zhang, Tiantian (Celine) 
> <mailto:Tiantian.Zhang@amd.com>.  And also @Limonciello, Mario 
> <mailto:Mario.Limonciello@amd.com> to help with the review.
>
> Regards,
> Shikang
>
> ------------------------------------------------------------------------
> *From:* Fan, Shikang <Shikang.Fan@amd.com>
> *Sent:* Tuesday, July 21, 2026 11:25 AM
> *To:* Koenig, Christian <Christian.Koenig@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; 
> SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Kuehling, Felix 
> <Felix.Kuehling@amd.com>
> *Cc:* Yang, Philip <Philip.Yang@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>
> *Subject:* Re: [PATCH v2] drm/amdkfd: save/restore MQD across 
> hibernation when MQD is in VRAM
>
> AMD General
>
> +@SHANMUGAM, SRINIVASAN <mailto:SRINIVASAN.SHANMUGAM@amd.com> and 
> @Kuehling, Felix <mailto:Felix.Kuehling@amd.com> to the review 
> discussion as Christian is currently OOO.
>
> Regards,
> Shikang
>
> ------------------------------------------------------------------------
> *From:* Fan, Shikang <Shikang.Fan@amd.com>
> *Sent:* Friday, July 17, 2026 6:25 PM
> *To:* Koenig, Christian <Christian.Koenig@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Yang, Philip <Philip.Yang@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> *Subject:* Re: [PATCH v2] drm/amdkfd: save/restore MQD across 
> hibernation when MQD is in VRAM
>
> AMD General
>
>
> I do have a few thoughts on the unpin-repin approach and re-building 
> the MQD from housekeeping information.
>
> For unpin-repin: the MQD's GPU address may change after it's moved 
> back from GTT, and several places hold the original address, so we'd 
> need to update all of them and be careful not to miss any — but 
> overall it's doable.
>
> For re-build: the one thing we can't reconstruct is the control stack. 
> It resides in the same BO as the MQD, and the driver doesn't preserve 
> its contents.
>
> Separately, I'd like to raise a potential pre-existing issue I noticed 
> while writing the patch. mqd_on_vram() covers gfx942, gfx943, gfx944 
> and gfx950. gfx943/944/950 are all registered with the _v9_4_3 
> implementations, which call flush_hdp() in init_mqd, update_mqd and 
> restore_mqd. gfx942, however, uses the base MQD functions, which lack 
> the flush_hdp() call.
>
> Regards,
> Shikang
>
> ------------------------------------------------------------------------
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Friday, July 17, 2026 4:59 PM
> *To:* Fan, Shikang <Shikang.Fan@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Yang, Philip <Philip.Yang@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> *Subject:* Re: [PATCH v2] drm/amdkfd: save/restore MQD across 
> hibernation when MQD is in VRAM
>
> On 7/17/26 10:53, Shikang Fan wrote:
> > On gfx942/944 and gfx9.5.0, KFD compute-queue MQDs live in a pinned VRAM
> > BO (mqd_on_vram()). Pinned VRAM is skipped by TTM eviction and not saved
> > across S4 hibernation, so the MQD is garbage on resume and the first
> > submission faults. Save it to a system-RAM shadow at suspend and restore
> > it on resume, reusing the CRIU checkpoint_mqd/restore_mqd primitives.
> >
> > v2:
> >  - Also snapshot the MQD when a process is already runtime-evicted at
> >    hibernation start. The qpd->evicted refcount early-return previously
> >    skipped the save loop, losing the MQD across the VRAM wipe (both the
> >    cpsch and nocpsch evict paths).
> >
> > Signed-off-by: Shikang Fan <shikang.fan@amd.com>
> > ---
> >  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 120 +++++++++++++++++-
> >  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   9 ++
> >  drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |   2 +
> >  3 files changed, 129 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > index 51ee9c39104b..d168686ee324 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > @@ -65,6 +65,9 @@ static int map_queues_cpsch(struct 
> device_queue_manager *dqm);
> >  static void deallocate_sdma_queue(struct device_queue_manager *dqm,
> >                                struct queue *q);
> >
> > +static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, 
> struct queue *q);
> > +static void dqm_save_mqd_backup(struct device_queue_manager *dqm, 
> struct queue *q);
> > +
> >  static inline void deallocate_hqd(struct device_queue_manager *dqm,
> >                                struct queue *q);
> >  static int allocate_hqd(struct device_queue_manager *dqm, struct 
> queue *q);
> > @@ -802,6 +805,10 @@ static int create_queue_nocpsch(struct 
> device_queue_manager *dqm,
> >                mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
> > &q->gart_mqd_addr, &q->properties);
> >
> > +     retval = dqm_alloc_mqd_backup(dqm, q);
> > +     if (retval)
> > +             goto out_free_mqd;
> > +
> >        if (q->properties.is_active) {
> >                if (!dqm->sched_running) {
> >                        WARN_ONCE(1, "Load non-HWS mqd while stopped\n");
> > @@ -1263,8 +1270,16 @@ static int 
> evict_process_queues_nocpsch(struct device_queue_manager *dqm,
> >        int retval, ret = 0;
> >
> >        dqm_lock(dqm);
> > -     if (qpd->evicted++ > 0) /* already evicted, do nothing */
> > +     if (qpd->evicted++ > 0) { /* already evicted, do nothing */
> > +             /* A process already runtime-evicted when hibernation 
> starts
> > +              * skips the save loop below, so snapshot its VRAM 
> MQDs here
> > +              * before the S4 image is taken. dqm_save_mqd_backup() 
> is a
> > +              * no-op outside S4.
> > +              */
> > +             list_for_each_entry(q, &qpd->queues_list, list)
> > +                     dqm_save_mqd_backup(dqm, q);
> >                goto out;
> > +     }
> >
> >        pdd = qpd_to_pdd(qpd);
> >        pr_debug_ratelimited("Evicting process pid %d queues\n",
> > @@ -1297,6 +1312,8 @@ static int evict_process_queues_nocpsch(struct 
> device_queue_manager *dqm,
> >                         * maintain a consistent eviction state
> >                         */
> >                        ret = retval;
> > +
> > +             dqm_save_mqd_backup(dqm, q);
> >        }
> >
> >  out:
> > @@ -1304,6 +1321,88 @@ static int 
> evict_process_queues_nocpsch(struct device_queue_manager *dqm,
> >        return ret;
> >  }
> >
> > +/* MQD software-shadow save/restore across S4 hibernation, reusing 
> the CRIU
> > + * checkpoint_mqd/restore_mqd primitives.
> > + */
> > +static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, 
> struct queue *q)
> > +{
> > +     struct mqd_manager *mqd_mgr;
> > +     uint32_t mqd_size, ctl_stack_size = 0;
> > +
> > +     if (!mqd_on_vram(dqm->dev->adev))
> > +             return 0;
> > +     if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE)
> > +             return 0;
> > +     if (!q->mqd)
> > +             return 0;
> > +
> > +     mqd_mgr = 
> dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
> > +     if (!mqd_mgr->checkpoint_mqd || !mqd_mgr->restore_mqd)
> > +             return 0;
> > +
> > +     mqd_size = AMDGPU_MQD_SIZE_ALIGN(mqd_mgr->mqd_size) *
> > +                NUM_XCC(dqm->dev->xcc_mask);
> > +     if (mqd_mgr->get_checkpoint_info)
> > +             mqd_mgr->get_checkpoint_info(mqd_mgr, q->mqd, 
> &ctl_stack_size);
> > +
> > +     if (!q->mqd_backup) {
> > +             q->mqd_backup = kzalloc(mqd_size, GFP_KERNEL);
>
> Please note that you need to be super careful when allocating memory 
> during suspend. The amount available is really limited because both 
> swap and OOM killer are already stopped.
>
> Instead you should probably consider unpinning on suspend and 
> repinning on resume, for this we have memory put asside.
>
> Additional to that it could be that backing up the MQD is overkill, we 
> should be able to re-create the MQD after resume from the housekeeping 
> information we still have around.
>
> Regards,
> Christian.
>
>
> > +             if (!q->mqd_backup)
> > +                     return -ENOMEM;
> > +             q->mqd_backup_size = mqd_size;
> > +     }
> > +     if (ctl_stack_size && !q->ctl_stack_backup) {
> > +             q->ctl_stack_backup = kzalloc(ctl_stack_size, GFP_KERNEL);
> > +             if (!q->ctl_stack_backup) {
> > +                     kfree(q->mqd_backup);
> > +                     q->mqd_backup = NULL;
> > +                     q->mqd_backup_size = 0;
> > +                     return -ENOMEM;
> > +             }
> > +             q->ctl_stack_backup_size = ctl_stack_size;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void dqm_save_mqd_backup(struct device_queue_manager *dqm, 
> struct queue *q)
> > +{
> > +     struct mqd_manager *mqd_mgr;
> > +
> > +     /* in_s4 is reliably set at evict/suspend time; skip normal 
> runtime eviction
> > +      * (pinned VRAM MQD stays intact then).
> > +      */
> > +     if (!dqm->dev->adev->in_s4)
> > +             return;
> > +     if (!q->mqd_backup)
> > +             return;
> > +     if (!q->mqd || !q->mqd_mem_obj || !q->mqd_mem_obj->cpu_ptr)
> > +             return;
> > +
> > +     mqd_mgr = 
> dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
> > +     mqd_mgr->checkpoint_mqd(mqd_mgr, q->mqd, q->mqd_backup, 
> q->ctl_stack_backup);
> > +     q->mqd_backup_valid = true;
> > +}
> > +
> > +static void dqm_restore_mqd_backup(struct device_queue_manager 
> *dqm, struct queue *q)
> > +{
> > +     struct mqd_manager *mqd_mgr;
> > +
> > +     if (!q->mqd_backup_valid || !q->mqd_backup)
> > +             return;
> > +     if (!q->mqd_mem_obj)
> > +             return;
> > +
> > +     mqd_mgr = 
> dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
> > +     if (!mqd_mgr->restore_mqd)
> > +             return;
> > +
> > +     mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, 
> &q->gart_mqd_addr,
> > +                          &q->properties, q->mqd_backup, 
> q->ctl_stack_backup,
> > +                          q->ctl_stack_backup_size);
> > +     q->mqd_backup_valid = false;
> > +}
> > +
> >  static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
> >                                      struct qcm_process_device *qpd)
> >  {
> > @@ -1313,8 +1412,16 @@ static int evict_process_queues_cpsch(struct 
> device_queue_manager *dqm,
> >        int retval = 0;
> >
> >        dqm_lock(dqm);
> > -     if (qpd->evicted++ > 0) /* already evicted, do nothing */
> > +     if (qpd->evicted++ > 0) { /* already evicted, do nothing */
> > +             /* A process already runtime-evicted when hibernation 
> starts
> > +              * skips the save loop below, so snapshot its VRAM 
> MQDs here
> > +              * before the S4 image is taken. dqm_save_mqd_backup() 
> is a
> > +              * no-op outside S4.
> > +              */
> > +             list_for_each_entry(q, &qpd->queues_list, list)
> > +                     dqm_save_mqd_backup(dqm, q);
> >                goto out;
> > +     }
> >
> >        pdd = qpd_to_pdd(qpd);
> >
> > @@ -1350,6 +1457,8 @@ static int evict_process_queues_cpsch(struct 
> device_queue_manager *dqm,
> >                                goto out;
> >                        }
> >                }
> > +
> > +             dqm_save_mqd_backup(dqm, q);
> >        }
> >
> >        if (!dqm->dev->kfd->shared_resources.enable_mes) {
> > @@ -1423,6 +1532,7 @@ static int 
> restore_process_queues_nocpsch(struct device_queue_manager *dqm,
> >
> >                mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
> >                                q->properties.type)];
> > +             dqm_restore_mqd_backup(dqm, q);
> >                q->properties.is_active = true;
> >                increment_queue_count(dqm, qpd, q);
> >
> > @@ -1486,6 +1596,7 @@ static int restore_process_queues_cpsch(struct 
> device_queue_manager *dqm,
> >                if (!QUEUE_IS_ACTIVE(q->properties))
> >                        continue;
> >
> > +             dqm_restore_mqd_backup(dqm, q);
>
> Those are the wrong point to call those functions if I'm not 
> completely mistaken.
>
> Regards,
> Christian.
>
> >                q->properties.is_active = true;
> >                increment_queue_count(dqm, &pdd->qpd, q);
> >
> > @@ -2161,6 +2272,10 @@ static int create_queue_cpsch(struct 
> device_queue_manager *dqm, struct queue *q,
> >                mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
> > &q->gart_mqd_addr, &q->properties);
> >
> > +     retval = dqm_alloc_mqd_backup(dqm, q);
> > +     if (retval)
> > +             goto out_free_mqd;
> > +
> >        list_add(&q->list, &qpd->queues_list);
> >        qpd->queue_count++;
> >
> > @@ -2193,6 +2308,7 @@ static int create_queue_cpsch(struct 
> device_queue_manager *dqm, struct queue *q,
> >        list_del(&q->list);
> >        if (q->properties.is_active)
> >                decrement_queue_count(dqm, qpd, q);
> > +out_free_mqd:
> >        mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
> >        dqm_unlock(dqm);
> >  out_deallocate_doorbell:
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > index 88191a4c1657..1f728f13813e 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -637,6 +637,15 @@ struct queue {
> >        void *gang_ctx_cpu_ptr;
> >
> >        struct amdgpu_bo *wptr_bo_gart;
> > +
> > +     /* system-RAM shadow of a VRAM-resident MQD (+ control stack)
> > +      * for hibernation snapshot/restore
> > +      */
> > +     void *mqd_backup;
> > +     void *ctl_stack_backup;
> > +     uint32_t mqd_backup_size;
> > +     uint32_t ctl_stack_backup_size;
> > +     bool mqd_backup_valid;
> >  };
> >
> >  enum KFD_MQD_TYPE {
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> > index 98a5512b701b..cbc90bf87792 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> > @@ -83,6 +83,8 @@ int init_queue(struct queue **q, const struct 
> queue_properties *properties)
> >
> >  void uninit_queue(struct queue *q)
> >  {
> > +     kfree(q->mqd_backup);
> > +     kfree(q->ctl_stack_backup);
> >        kfree(q);
> >  }
> >
>
--------------mwjnS2DnkQr6456ZLKiyxEdX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>These are all server GPUs. Is system suspend really a requirement
      here? Or is this for runtime suspend? But runtime suspend
      shouldn't kick in while user mode queues exist.</p>
    <p><br>
    </p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-07-21 03:20, Fan, Shikang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:SA1PR12MB7343FE954902BF06C7996A90EBC22@SA1PR12MB7343.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <div>
        <div style="font-family: Calibri; text-align: left; color: rgb(0, 0, 255); margin-left: 5pt; font-size: 10pt;">
          AMD General</div>
        <br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
        +<a href="mailto:Victor.Zhao@amd.com" id="OWAAM420325" class="tWKOu mention ms-bgc-nlr ms-fcl-b" moz-do-not-send="true">@Zhao, Victor</a>,
        <a href="mailto:Tiantian.Zhang@amd.com" id="OWAAM394558" class="tWKOu mention ms-bgc-nlr ms-fcl-b" moz-do-not-send="true">
          @Zhang, Tiantian (Celine)</a>. &nbsp;And also&nbsp;<a href="mailto:Mario.Limonciello@amd.com" id="OWAAM671300" class="tWKOu mention ms-bgc-nlr ms-fcl-b" moz-do-not-send="true">@Limonciello, Mario</a>&nbsp;to help with
        the review.</div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
        Regards,</div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
        Shikang</div>
      <div><span style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"><br>
        </span></div>
      <hr style="display: inline-block; width: 98%;">
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <b>From:</b> Fan, Shikang <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com">&lt;Shikang.Fan@amd.com&gt;</a><br>
        <b>Sent:</b> Tuesday, July 21, 2026 11:25 AM<br>
        <b>To:</b> Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>;
        <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
        <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; SHANMUGAM, SRINIVASAN
        <a class="moz-txt-link-rfc2396E" href="mailto:SRINIVASAN.SHANMUGAM@amd.com">&lt;SRINIVASAN.SHANMUGAM@amd.com&gt;</a>; Kuehling, Felix
        <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a><br>
        <b>Cc:</b> Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>; Deucher,
        Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
        <b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD
        across hibernation when MQD is in VRAM
      </div>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="direction: ltr; text-align: left; margin-left: 5pt; font-family: Calibri; font-size: 10pt; color: rgb(0, 0, 255);">
        AMD General</div>
      <div style="direction: ltr;"><br>
      </div>
      <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
        +<a href="mailto:SRINIVASAN.SHANMUGAM@amd.com" id="OWAAM517752" class="x_tWKOu x_mention x_ms-bgc-nlr x_ms-fcl-b" moz-do-not-send="true">@SHANMUGAM, SRINIVASAN</a>&nbsp;and
        <a href="mailto:Felix.Kuehling@amd.com" id="OWAAM431627" class="x_tWKOu x_mention x_ms-bgc-nlr x_ms-fcl-b" moz-do-not-send="true">
          @Kuehling, Felix</a>&nbsp;to the review discussion as Christian is
        currently OOO.</div>
      <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
        Regards,</div>
      <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
        Shikang</div>
      <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <hr style="direction: ltr; display: inline-block; width: 98%;">
      <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <b>From:</b> Fan, Shikang <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com">&lt;Shikang.Fan@amd.com&gt;</a><br>
        <b>Sent:</b> Friday, July 17, 2026 6:25 PM<br>
        <b>To:</b> Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>;
        <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
        <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
        <b>Cc:</b> Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>; Deucher,
        Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling, Felix
        <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a><br>
        <b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD
        across hibernation when MQD is in VRAM</div>
      <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="direction: ltr; text-align: left; margin-left: 5pt; font-family: Calibri; font-size: 10pt; color: rgb(0, 0, 255);">
        AMD General</div>
      <div style="direction: ltr;"><br>
      </div>
      <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
        I do have a few thoughts on the unpin-repin approach and
        re-building the MQD from housekeeping information.</div>
      <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
        For unpin-repin: the MQD's GPU address may change after it's
        moved back from GTT, and several places hold the original
        address, so we'd need to update all of them and be careful not
        to miss any — but overall it's doable.</div>
      <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
        For re-build: the one thing we can't reconstruct is the control
        stack. It resides in the same BO as the MQD, and the driver
        doesn't preserve its contents.</div>
      <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
        Separately, I'd like to raise a potential pre-existing issue I
        noticed while writing the patch. mqd_on_vram() covers gfx942,
        gfx943, gfx944 and gfx950. gfx943/944/950 are all registered
        with the _v9_4_3 implementations, which call flush_hdp() in
        init_mqd, update_mqd and restore_mqd. gfx942, however, uses the
        base MQD functions, which lack the flush_hdp() call.</div>
      <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
        Regards,</div>
      <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
        Shikang</div>
      <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <hr style="direction: ltr; display: inline-block; width: 98%;">
      <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <b>From:</b> Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
        <b>Sent:</b> Friday, July 17, 2026 4:59 PM<br>
        <b>To:</b> Fan, Shikang <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com">&lt;Shikang.Fan@amd.com&gt;</a>;
        <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
        <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
        <b>Cc:</b> Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>; Deucher,
        Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling, Felix
        <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a><br>
        <b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD
        across hibernation when MQD is in VRAM</div>
      <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="direction: ltr; font-size: 11pt;">On 7/17/26 10:53,
        Shikang Fan wrote:<br>
        &gt; On gfx942/944 and gfx9.5.0, KFD compute-queue MQDs live in
        a pinned VRAM<br>
        &gt; BO (mqd_on_vram()). Pinned VRAM is skipped by TTM eviction
        and not saved<br>
        &gt; across S4 hibernation, so the MQD is garbage on resume and
        the first<br>
        &gt; submission faults. Save it to a system-RAM shadow at
        suspend and restore<br>
        &gt; it on resume, reusing the CRIU checkpoint_mqd/restore_mqd
        primitives.<br>
        &gt;<br>
        &gt; v2:<br>
        &gt;&nbsp; - Also snapshot the MQD when a process is already
        runtime-evicted at<br>
        &gt;&nbsp;&nbsp;&nbsp; hibernation start. The qpd-&gt;evicted refcount
        early-return previously<br>
        &gt;&nbsp;&nbsp;&nbsp; skipped the save loop, losing the MQD across the VRAM
        wipe (both the<br>
        &gt;&nbsp;&nbsp;&nbsp; cpsch and nocpsch evict paths).<br>
        &gt;<br>
        &gt; Signed-off-by: Shikang Fan <a class="moz-txt-link-rfc2396E" href="mailto:shikang.fan@amd.com">&lt;shikang.fan@amd.com&gt;</a><br>
        &gt; ---<br>
        &gt;&nbsp; .../drm/amd/amdkfd/kfd_device_queue_manager.c | 120
        +++++++++++++++++-<br>
        &gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 9 ++<br>
        &gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_queue.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
        &gt;&nbsp; 3 files changed, 129 insertions(+), 2 deletions(-)<br>
        &gt;<br>
        &gt; diff --git
        a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
        &gt; index 51ee9c39104b..d168686ee324 100644<br>
        &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
        &gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
        &gt; @@ -65,6 +65,9 @@ static int map_queues_cpsch(struct
        device_queue_manager *dqm);<br>
        &gt;&nbsp; static void deallocate_sdma_queue(struct
        device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue *q);<br>
        &gt;&nbsp;<br>
        &gt; +static int dqm_alloc_mqd_backup(struct
        device_queue_manager *dqm, struct queue *q);<br>
        &gt; +static void dqm_save_mqd_backup(struct
        device_queue_manager *dqm, struct queue *q);<br>
        &gt; +<br>
        &gt;&nbsp; static inline void deallocate_hqd(struct
        device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue *q);<br>
        &gt;&nbsp; static int allocate_hqd(struct device_queue_manager *dqm,
        struct queue *q);<br>
        &gt; @@ -802,6 +805,10 @@ static int create_queue_nocpsch(struct
        device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;init_mqd(mqd_mgr,
        &amp;q-&gt;mqd, q-&gt;mqd_mem_obj,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &amp;q-&gt;gart_mqd_addr, &amp;q-&gt;properties);<br>
        &gt;&nbsp;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; retval = dqm_alloc_mqd_backup(dqm, q);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_mqd;<br>
        &gt; +<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_active) {<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;sched_running) {<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE(1, &quot;Load non-HWS mqd while
        stopped\n&quot;);<br>
        &gt; @@ -1263,8 +1270,16 @@ static int
        evict_process_queues_nocpsch(struct device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval, ret = 0;<br>
        &gt;&nbsp;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);<br>
        &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) /* already evicted, do
        nothing */<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) { /* already evicted,
        do nothing */<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* A process already runtime-evicted when
        hibernation starts<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * skips the save loop below, so snapshot its
        VRAM MQDs here<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * before the S4 image is taken.
        dqm_save_mqd_backup() is a<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * no-op outside S4.<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(q,
        &amp;qpd-&gt;queues_list, list)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_save_mqd_backup(dqm, q);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt;&nbsp;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd = qpd_to_pdd(qpd);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug_ratelimited(&quot;Evicting process pid %d
        queues\n&quot;,<br>
        &gt; @@ -1297,6 +1312,8 @@ static int
        evict_process_queues_nocpsch(struct device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * maintain a consistent eviction
        state<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = retval;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_save_mqd_backup(dqm, q);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt;&nbsp;<br>
        &gt;&nbsp; out:<br>
        &gt; @@ -1304,6 +1321,88 @@ static int
        evict_process_queues_nocpsch(struct device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
        &gt;&nbsp; }<br>
        &gt;&nbsp;<br>
        &gt; +/* MQD software-shadow save/restore across S4 hibernation,
        reusing the CRIU<br>
        &gt; + * checkpoint_mqd/restore_mqd primitives.<br>
        &gt; + */<br>
        &gt; +static int dqm_alloc_mqd_backup(struct
        device_queue_manager *dqm, struct queue *q)<br>
        &gt; +{<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mqd_size, ctl_stack_size = 0;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_on_vram(dqm-&gt;dev-&gt;adev))<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type != KFD_QUEUE_TYPE_COMPUTE)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =
        dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_type(q-&gt;properties.type)];<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_mgr-&gt;checkpoint_mqd ||
        !mqd_mgr-&gt;restore_mqd)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_size =
        AMDGPU_MQD_SIZE_ALIGN(mqd_mgr-&gt;mqd_size) *<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NUM_XCC(dqm-&gt;dev-&gt;xcc_mask);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (mqd_mgr-&gt;get_checkpoint_info)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;get_checkpoint_info(mqd_mgr,
        q-&gt;mqd, &amp;ctl_stack_size);<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup) {<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup = kzalloc(mqd_size,
        GFP_KERNEL);<br>
        <br>
        Please note that you need to be super careful when allocating
        memory during suspend. The amount available is really limited
        because both swap and OOM killer are already stopped.<br>
        <br>
        Instead you should probably consider unpinning on suspend and
        repinning on resume, for this we have memory put asside.<br>
        <br>
        Additional to that it could be that backing up the MQD is
        overkill, we should be able to re-create the MQD after resume
        from the housekeeping information we still have around.<br>
        <br>
        Regards,<br>
        Christian.<br>
        <br>
        <br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_size = mqd_size;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ctl_stack_size &amp;&amp;
        !q-&gt;ctl_stack_backup) {<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;ctl_stack_backup =
        kzalloc(ctl_stack_size, GFP_KERNEL);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;ctl_stack_backup) {<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;mqd_backup);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup = NULL;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_size = 0;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;ctl_stack_backup_size = ctl_stack_size;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
        &gt; +}<br>
        &gt; +<br>
        &gt; +static void dqm_save_mqd_backup(struct
        device_queue_manager *dqm, struct queue *q)<br>
        &gt; +{<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* in_s4 is reliably set at evict/suspend time; skip
        normal runtime eviction<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (pinned VRAM MQD stays intact then).<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;dev-&gt;adev-&gt;in_s4)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd || !q-&gt;mqd_mem_obj ||
        !q-&gt;mqd_mem_obj-&gt;cpu_ptr)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =
        dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_type(q-&gt;properties.type)];<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;checkpoint_mqd(mqd_mgr, q-&gt;mqd,
        q-&gt;mqd_backup, q-&gt;ctl_stack_backup);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_valid = true;<br>
        &gt; +}<br>
        &gt; +<br>
        &gt; +static void dqm_restore_mqd_backup(struct
        device_queue_manager *dqm, struct queue *q)<br>
        &gt; +{<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup_valid || !q-&gt;mqd_backup)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_mem_obj)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =
        dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_type(q-&gt;properties.type)];<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_mgr-&gt;restore_mqd)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;restore_mqd(mqd_mgr, &amp;q-&gt;mqd,
        q-&gt;mqd_mem_obj, &amp;q-&gt;gart_mqd_addr,<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;q-&gt;properties,
        q-&gt;mqd_backup, q-&gt;ctl_stack_backup,<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;ctl_stack_backup_size);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_valid = false;<br>
        &gt; +}<br>
        &gt; +<br>
        &gt;&nbsp; static int evict_process_queues_cpsch(struct
        device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
        qcm_process_device *qpd)<br>
        &gt;&nbsp; {<br>
        &gt; @@ -1313,8 +1412,16 @@ static int
        evict_process_queues_cpsch(struct device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval = 0;<br>
        &gt;&nbsp;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);<br>
        &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) /* already evicted, do
        nothing */<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) { /* already evicted,
        do nothing */<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* A process already runtime-evicted when
        hibernation starts<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * skips the save loop below, so snapshot its
        VRAM MQDs here<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * before the S4 image is taken.
        dqm_save_mqd_backup() is a<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * no-op outside S4.<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(q,
        &amp;qpd-&gt;queues_list, list)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_save_mqd_backup(dqm, q);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt;&nbsp;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd = qpd_to_pdd(qpd);<br>
        &gt;&nbsp;<br>
        &gt; @@ -1350,6 +1457,8 @@ static int
        evict_process_queues_cpsch(struct device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_save_mqd_backup(dqm, q);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt;&nbsp;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
        (!dqm-&gt;dev-&gt;kfd-&gt;shared_resources.enable_mes) {<br>
        &gt; @@ -1423,6 +1532,7 @@ static int
        restore_process_queues_nocpsch(struct device_queue_manager *dqm,<br>
        &gt;&nbsp;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =
        dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_type(<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.type)];<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_restore_mqd_backup(dqm, q);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.is_active = true;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, qpd, q);<br>
        &gt;&nbsp;<br>
        &gt; @@ -1486,6 +1596,7 @@ static int
        restore_process_queues_cpsch(struct device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!QUEUE_IS_ACTIVE(q-&gt;properties))<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
        &gt;&nbsp;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_restore_mqd_backup(dqm, q);<br>
        <br>
        Those are the wrong point to call those functions if I'm not
        completely mistaken.<br>
        <br>
        Regards,<br>
        Christian.<br>
        <br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.is_active = true;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, &amp;pdd-&gt;qpd,
        q);<br>
        &gt;&nbsp;<br>
        &gt; @@ -2161,6 +2272,10 @@ static int create_queue_cpsch(struct
        device_queue_manager *dqm, struct queue *q,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;init_mqd(mqd_mgr,
        &amp;q-&gt;mqd, q-&gt;mqd_mem_obj,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &amp;q-&gt;gart_mqd_addr, &amp;q-&gt;properties);<br>
        &gt;&nbsp;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; retval = dqm_alloc_mqd_backup(dqm, q);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_mqd;<br>
        &gt; +<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;q-&gt;list, &amp;qpd-&gt;queues_list);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;queue_count++;<br>
        &gt;&nbsp;<br>
        &gt; @@ -2193,6 +2308,7 @@ static int create_queue_cpsch(struct
        device_queue_manager *dqm, struct queue *q,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;q-&gt;list);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_active)<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; decrement_queue_count(dqm, qpd, q);<br>
        &gt; +out_free_mqd:<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;free_mqd(mqd_mgr, q-&gt;mqd,
        q-&gt;mqd_mem_obj);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_unlock(dqm);<br>
        &gt;&nbsp; out_deallocate_doorbell:<br>
        &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
        &gt; index 88191a4c1657..1f728f13813e 100644<br>
        &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
        &gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
        &gt; @@ -637,6 +637,15 @@ struct queue {<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_cpu_ptr;<br>
        &gt;&nbsp;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo_gart;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* system-RAM shadow of a VRAM-resident MQD (+
        control stack)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for hibernation snapshot/restore<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; void *mqd_backup;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; void *ctl_stack_backup;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mqd_backup_size;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ctl_stack_backup_size;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool mqd_backup_valid;<br>
        &gt;&nbsp; };<br>
        &gt;&nbsp;<br>
        &gt;&nbsp; enum KFD_MQD_TYPE {<br>
        &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<br>
        &gt; index 98a5512b701b..cbc90bf87792 100644<br>
        &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<br>
        &gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<br>
        &gt; @@ -83,6 +83,8 @@ int init_queue(struct queue **q, const
        struct queue_properties *properties)<br>
        &gt;&nbsp;<br>
        &gt;&nbsp; void uninit_queue(struct queue *q)<br>
        &gt;&nbsp; {<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;mqd_backup);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;ctl_stack_backup);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(q);<br>
        &gt;&nbsp; }<br>
        &gt;&nbsp;<br>
        <br>
      </div>
    </blockquote>
  </body>
</html>

--------------mwjnS2DnkQr6456ZLKiyxEdX--
