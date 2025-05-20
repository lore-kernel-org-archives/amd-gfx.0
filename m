Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07CAC3ABDD
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 07:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4826310E17E;
	Tue, 20 May 2025 07:39:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u2IIMHiG";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7856910E17E
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 07:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBc4Qfd8jAke+3Dh/kixY0OjiChnDg/3VagwCFBDbYX0s/KvO0CdjLIAEJXUwQUjU1o1/0UiB0Z5lCz4YJMzqSPmHkJmcjRMUMePXQN79+3RnkVekZtcHyys4SjcS5pX1Yd29CKN6gHihMuaANanIGKj1NBvLuJOB1qXvY2ByRiMmrH2ExrPIlPhnzvgAGYP+89M8g1F8tsSeVOTJTz4L7R70W6+3u8WDuk5XpIkjEylrEcJq5MwAqzfimyXM10EJrIrXxbGsvYVzvKRzI0lHhBzFO/ZjWNeRpDyNwxXLF0HTZNeO0482nbziYIvI3gSbcU3zh7QrxqVUfdQ/vy63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gVnUHYFjzSbUBpI44yYMpfj5pG6pgvgpcCaZoTUaNs=;
 b=h9yQn+RE8vpiXOPrUzoSZaYL7BWRuTH9FCTdCwT2FGV/LLFgvWc58cW49hkoErBhtQBKuKKlpSwoOk/J/+XCQJyjElmVHSDCyESXcasCDbk1FG8WsIQ1P33Z7XepCj/5LIvlU6T6lxVis/QPqacvWcotuil0jkR2oL0AH9WFD5bq9Y/VhywoTYsrBV1FgPgB5i345kGX7VZn4cn7wiJOmcFDy/yhiyyWIx989uf5LPdOw3deNBXU4fGhPLq1s5P1XdmuvSgvlpBaCSnDm4LvXGf2UiAzlLuyfjW1Nuxk5ZYDjU7fbAGMXDzcY6qO2Qzbi60RVkmoJl+J4IvPYXVzTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gVnUHYFjzSbUBpI44yYMpfj5pG6pgvgpcCaZoTUaNs=;
 b=u2IIMHiG0JbpygasLUPMnabT4XXmcPQHAi6zjAiszf3XvMRExaY5XZWsam+2J4xbU6HpksAms8kUZCoIeAS01TzC1Q8tMunOMGNAFwmjcxE4mpHGGlcr56z9+kPuv2jBrDdOmB8CC6a4BXDoLXrLH2IacYopAd7daRT+uV4TiHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 07:39:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 20 May 2025
 07:39:51 +0000
Message-ID: <71accc22-29d1-47ff-909e-e8eb2bdd528a@amd.com>
Date: Tue, 20 May 2025 09:39:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/3] drm/amdgpu: Add locking to amdgpu_ctx_mgr_entity_fini()
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20250519163713.11367-1-tvrtko.ursulin@igalia.com>
 <20250519163713.11367-4-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250519163713.11367-4-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0306.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: ad235828-0084-4f0c-98ad-08dd97718176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEdJN1JGVVlGUGIwWjVwYjRGa052RnZPc3Y4MDlQNUt6S21tOUdYcENodUgx?=
 =?utf-8?B?SGcwNG4yMzJQc0F2VXFXY00yZy9XRndGbUR4R0NSS2RIUFlyZ083VkNETzBp?=
 =?utf-8?B?NDlad2dReWdUYUF6cGtKUzhFSiszcGhja0JrNURQNjNEYnByOHY0T3dqcENn?=
 =?utf-8?B?SDZqVnpENHZFbDdTbjZuNVVqNFNEd2wrM1FPbmwwcFpTY0RhUHE0cUtTSCsv?=
 =?utf-8?B?UC9JeHp2NjlWcnY4NW80NVpsRDNyM3h2UDRmWktTQTFRUFNrdGZ2dXdHcHZB?=
 =?utf-8?B?bzNGcVJZMUpScjUyK2tHTllpRTFvdFFQZ1ZrZk0zRnR3dGx5d2ZDcmU1Mk14?=
 =?utf-8?B?MEE5OTJxYWxFZkdpNTUwRkpzakRYQ05tZFFMVEJsengwcHYydWgxQWF6R1Np?=
 =?utf-8?B?QTJWN1hoV3lSeEZsUk5nVGZHcXM4M0NsZWs0NnJNby9IS0RXOW43TWFvcEVk?=
 =?utf-8?B?amFZTWNzeXo5M2lqUlpsdnhBdFVLVi9jSTdBWlFIV0hjU1JGSWxNMWpKeTlX?=
 =?utf-8?B?b2oxRTk4TjVWRDJkS0dDMHpQbTJiUEd5THNKVEwxQXovN01PNkJwMlVWVFEx?=
 =?utf-8?B?TTRPeWdRV0pUU3cvQlFkaWlGeFdpdmlXS1BobXVzbjVnZGliaTNlNndia2FX?=
 =?utf-8?B?ZjlQeHgxZHNYSXY4dHhvWUJ1U2NlZ2s4OUdtQ1lZem1leDE4NytGaU5keGds?=
 =?utf-8?B?bnE5bGc1bFJiNXdOY3pkc3hzQk9Jd0RUQ01IeDFtWHNja1AybWd4UkhCWW1V?=
 =?utf-8?B?NkNmaW1RQzdtZ2JMQkRGRGtyQ3liUHhiM0d3V1RYOTdxNDlIajhGZVpiYmJP?=
 =?utf-8?B?ZzZBcjEzakN0OXBGVGVqeFNhM3hsWjU2Uys4M0U5NnMzd04zcHFaQWJ2VlZO?=
 =?utf-8?B?ejNhVEpObGRiRXhZbEpFYzVDWkt2Y2hmU1hZY3BETlErVGdGK1BxRG1wbS8x?=
 =?utf-8?B?Y2wvakhyNXFmTEJhYVQ1c3RETmI5R0pKQWdJRm1SV1d1Qk4yK1VNUytTekhX?=
 =?utf-8?B?dXZ5d24xd0FieVVvZjZDTUszRjkyYWNCMFFlMU00TUQzQTJobjRUb28ycklh?=
 =?utf-8?B?OUVwS09DdVhyR1JuZjhQMGcwSUxUU0N1aUJnNDVMUE1XdzlMZlM3TFlSQXFR?=
 =?utf-8?B?RU5hM3RaTXBFa29PU2N2bzc5dkQ4OVlWZEpBQU9ZazhUZjd0UzFXaXVIY2M0?=
 =?utf-8?B?SktaaUpFWms2MVpCSnlpQ21taFBHRFNQdXBNV1RUMFpxenhScFgxRzAvQ0l3?=
 =?utf-8?B?bkJpWUVKY3dEWDhwR2liTjJRc3RURjlBTzErUUh1SUhOcGcxQUp0eXZPZE9N?=
 =?utf-8?B?WXIzcG0wZzFWQU1BdmRLMEUySUZLL0wvdG11ajVDME9DVU56WEcwNlo4NUtP?=
 =?utf-8?B?NkJYMUFiL3ZlM2E3QnJOYmQxVEk2UTNaT0lGTG9CU3Fpd2J4OUpWdWFVdk5V?=
 =?utf-8?B?NjhOT0FEZGxBNFNkdk1ia0RtcVhBNnZLRGt6ZlBXSnZMYlF2T05CdTBGZUkx?=
 =?utf-8?B?YXh0bWd4WjZEdnNuZ1M5cVp6SE1xQTlsQ1ZMaHdBOUJIdGZ5YnBwdE9abnBG?=
 =?utf-8?B?b1dtWXRMdzUzMnBrTCsrYlE4MlZ5eEZNbURaVEVqaWNTdEw5cHVHUDc3ckh4?=
 =?utf-8?B?cFMrOWwvYzZYY3p6azk2K2F4ZVAxV28rRHFoY2dxUGE5d2ZscHA2NE1XbVQ1?=
 =?utf-8?B?eG5WOHJnZE90OVhIVFNvVWx4U0IvczlFamovM2ZUVUtqbTVVNnJNNmZvZXVo?=
 =?utf-8?B?NkdjUTI3WCtnVityNklCQ1l3OWdodndmdFZkaXpVdG1JTWZTT1JVVWNRVVNo?=
 =?utf-8?B?NHNlaTkvSXd6ejZsMHdWbEFaVXlBU0g1NWQzOUlmZmJGYTI2OC9wZEp3N2RO?=
 =?utf-8?B?bVA5bTUzY2doaFZGbEZLa0VyV1pIWXM3b1luUzBxWU93Z3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VldKanUvbUNpTmFpR0dLSDdxeXhoQjRmNWpkUlRhMUtPV1VacWtEZzBRNitl?=
 =?utf-8?B?bVZrU3VJcEEwMjNrR2tHbENtR2xpTFRxdWJmdHdwRDlRUnlCa0xURjA1Z3Ju?=
 =?utf-8?B?aTNCZXlIZS9LeE93QXM0SFI2UWVmRnc1V0s1QUhvSEhwMnVmY1JwNWhzYU1D?=
 =?utf-8?B?aEVVYmlZVE1JY2w3c1VXZFVKZnhmYWNiZExSaUJkSkFRSFVPYzhLM3daZGMy?=
 =?utf-8?B?Z1RNOWo4NGhYRm9YRHNJV3NpMW81YU81eU9YYVdDMEVQM2o1L1l2SkRRR2tu?=
 =?utf-8?B?Mk1MUHU3ZmJQZnVwZlBKS0owd2Jac3BrMEhKUUhBNm5KNjJaT3kwYzJWeHRp?=
 =?utf-8?B?MUVwZVdiY2ZTekNxaVoxVWRpdnJDancvYUtDeFFPM0txc08wdVFnTFBxSGl2?=
 =?utf-8?B?U1dWeVAxK2t2eDdTb2ZHVGY3Q3MyejNxRmNxZ2g3Zk5ucElPK2ZvOUtaWFpY?=
 =?utf-8?B?TGtvQkFkUHBuVjFTZ0p1ZmRYcEV0OUg0clVidllSTlhaeXNkM2lBaklocEdJ?=
 =?utf-8?B?K2I4akJEYnhJdXZUV2M3eWVKa0xQVkQ1OGVuemJGWUduYkpTeWhxanZTeDla?=
 =?utf-8?B?U0JsTTl5bTJMOGxpRnlNQlJLU2ZJNjVKNEhDVzFWVktaRzN4NGViUFBMVFhN?=
 =?utf-8?B?djZPMWNwd1N2azhPZlJyMU93L0RVSXEvNVlJUjNrd05yQjNSNVBGMGNvSGRB?=
 =?utf-8?B?UFVXWWFiWFRmVU5pRnJFdWVuanBQNVdBSFpWN1BaQ3QwODVpUExEWktLUGR4?=
 =?utf-8?B?d1ZvSzVlOUhMRGhIMHlJOWZWNG13MW9Tanh5SUtTRU1VQkpuQUJ0Z0tGWEdv?=
 =?utf-8?B?NytTT0FmNllFVm1xYkpaSUFNQnVZUE5vYTNZSWs0R0xhWEU3REhWeWtZcGJH?=
 =?utf-8?B?TnJjVVJrY29pYVo2S002Zm92ZzNqVGRhaEZWaTZTNTZrWFJOSm9tQ2FzT0hr?=
 =?utf-8?B?K3JNSkd2ckxSUDhPbkJ6NlRxN200ODRVNWIzK2pVa251OWJtTnBkK0p1N2F6?=
 =?utf-8?B?TU9qNVRPaHk5QkRSMThlK0NVYk81dmxPUFN5WHFWR3dMUEY1U2J1U2pwMkZk?=
 =?utf-8?B?T0FVZEg4S09FQzl4VFpJWlNqdUlLQmsrME5mODJXU2FDdnlaUkZuSEhQVmZn?=
 =?utf-8?B?U05xWlFuS2JPKzhVZzdjVWsxVTNEQlVQd05haUNZV2ZoaEVRalE1MUpzN29K?=
 =?utf-8?B?Mm1FdjRKWWFKR2xYbnpEem0zSThOSVMwUWZLUnN5dlpGa1owYmt2aTFZM2ZC?=
 =?utf-8?B?ejBUdWVKWVpNMWUwdmFGclY1QkRXbHpZak1SNzk3SW1xQUUvYjZPV2d1SVRO?=
 =?utf-8?B?dHJxRGZKM0s1czNGSWpBdFk1RkRlN0xuM2Q4SzB3VXkrY29pYkJ6dGsrZHBY?=
 =?utf-8?B?c1dHV3QwNkxDbGNpQ2xmQWtFMFZheXZtQmdQd3Y2U0txOVJvUVBDWVZncGNT?=
 =?utf-8?B?MFQ4dGxwanVKSFdUVHVEMmdCYWdtbjhYcXpzQUJ3elpUQkwvNlFDWm1VdzVV?=
 =?utf-8?B?cE1jVU54czJyTlVndW0veURlRWxCTGN1MWNLRk50Z2pKb1Z3RHA0ck94bW4y?=
 =?utf-8?B?djA0U0hVcEtDaldNU0xlelRVTjU0WC9TVkxkQ1BhSFE3TXpRZW1ZL0dNQkI2?=
 =?utf-8?B?SXNsTjlmcW1PUlo0UURIZ3dsaHNoQkhMZGZQcWY4azVaZlBtdVMzZXBMQUV4?=
 =?utf-8?B?UHJ0WS9jOG5GQWdLUEMrMnYrSDRxV1UzZ3pFUmJEZktibWdtZ1U4a1VyLzE1?=
 =?utf-8?B?WEtjd3VhZWdTOFJpeG9WSGVvMWZIMnMwbEovTFc5OTh6elFLclM3VjB5Z25L?=
 =?utf-8?B?V2tRMUk2amVOTFFQd0g0dUFRdTFMaWlGek54MHZEZk5tRjN4bkNqeXV1eTN6?=
 =?utf-8?B?ZkxLSWhWR0k0NE90VWJjd0l4MlBXZHZwRGJOVjRqOEtLOGVWSUxZa2hwcHlE?=
 =?utf-8?B?VG5BT2ZUY1JuUGlSajBDUFNzbll4MVk2c1c2TUhZUVRWZS81VHJCQzRLTmV1?=
 =?utf-8?B?UDlVb1V2bzFJZHZDeVIxQWtZUXZyYVhwa085bzVrSmJyRGgwZVFLUURTekNr?=
 =?utf-8?B?K2J2M3VnWEM5Qlg5dDgvK3ZIOEhlVmhpa2tkb1Z0NXB5SzgvbDNGbTNtaU5B?=
 =?utf-8?Q?rkA0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad235828-0084-4f0c-98ad-08dd97718176
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 07:39:51.6945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2G+Cdkj0n+F7MVPGAkPnujrtjZLV7g12LXU6DveFsli9fzuBscBj5HhOWkq5kI/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016
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

On 5/19/25 18:37, Tvrtko Ursulin wrote:
> Amdgpu_ctx_mgr_entity_fini() walks the context IDR unlocked so question is
> could it in theory see a stale entry and attempt to destroy the
> drm_sched_entity twice?

No, when this function is called when the file descriptor is freed up.

So there should never ever be any concurrent user of this.

> Problem is I have hit this on a KASAN enabled kernel only _once_ and never
> since. In that case it reported amdgpu_ctx_ioctl() had freed the entity
> already which would mean the question is could we possibly go through the
> mutex_unlock() on one CPU, and another CPU to follow immediately with
> file->release (DRM postclose) and see the stale entry.

Mhm, it would basically mean that the file descriptor can be closed while some IOCTL on it is still ongoing.

I think that this would be extremely ugly and should never ever happen in the first place. Adding the mutex just band aids the issue, but not really fixes it.

> Throwing it out there not to forget about it, since I have manage to
> lose the KASAN trace already..

If you manage to trigger that again please send it to me ASAP.

Thanks,
Christian.

> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 85567d0d9545..95b005ed839e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -927,6 +927,7 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>  
>  	idp = &mgr->ctx_handles;
>  
> +	mutex_lock(&mgr->lock);
>  	idr_for_each_entry(idp, ctx, id) {
>  		if (kref_read(&ctx->refcount) != 1) {
>  			DRM_ERROR("ctx %p is still alive\n", ctx);
> @@ -945,6 +946,7 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>  			}
>  		}
>  	}
> +	mutex_unlock(&mgr->lock);
>  }
>  
>  void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)

