Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E333CD98E6
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 12:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F8C410EB62;
	Tue, 16 Jun 2026 12:48:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Eb7ClXKt";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013031.outbound.protection.outlook.com
 [40.93.196.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C78410EB62
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 12:48:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYEr8+jyChcyMOCSrkVzPFMQ1qMZo017v2o/SpsZNu+tTKCAIJHTUApwb/ABs1LVMl31jtSXXcqPnaPK1p3FhxVGuu+91DNkyjetogkRV4Fo2g3y9v8IHg6Oao8dB2WjQzL11fMy7FXbAR7AWAN/zzZrpuG6Z17GfXpUO/a7GmSvwntz56jSAEqnBARrcawEtNovy0G5AigrzT2cvTbtTNBqj2G/R2jCb9fodoGXaR0lb3XN0gyn3UvHFrdq4nGCzRLeTgNjyLPKIeJo++Mt74i1VnLmbG9KWYnu+F/qkQGnUn6cuHdl9vDikG2AF1o7uHpsc6R3hH6bj7s/DkfSsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZE8UKSzPehE/dV8L9iay9h7t9B2MJbP+O+4kxvVSQ0=;
 b=Wi+glyXuZtxd9Os8WPs5zixjdMNliEJRUSP5WrfcX+/UalZ/7qb0GhEOno2U4lUFHlKVo3SEvRzJhiO+kyzU4xDewe9zdaTpT/b7hbfQJsGBh7ZMWauSb6dFydQHPFSRknWHVdurApmZi6fCSmWnCQhiNmvaxX3MBcKCZBd4XkDxcQJUNAk5DnoBDmp2xeBPwm0Ca2K3zwuQhYCfabNzzSr5oiWrmPVu4hmmI7QpBt+7W56ZgLdIlPkZtct1JGx6qXMigIhCMS/FhTX+1vgOkZrIbMN/gDJIMr+qePRqworYD4JWt8JgzAjcC4/fxmn9a7qVA5sYe22FZe5fHY7g8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZE8UKSzPehE/dV8L9iay9h7t9B2MJbP+O+4kxvVSQ0=;
 b=Eb7ClXKtx6u2lXxw+STyTPpHlHgVohAMNJWvX1mZz8OxKPVi4gXSEdlOw/cDXcZder0WyFO6TvcMXDEdKaJDusiovVm8Q2tyI8RNIj6ssnvu6nOFzOhc1AY/GSF0GiU32Z1Yh1WDzdytlYzw3vVU1zYHgWnO5RydMc8o3s97PNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DSSPR12MB999213.namprd12.prod.outlook.com (2603:10b6:8:378::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:48:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 12:48:41 +0000
Message-ID: <420b30ab-e6c1-411a-be5f-ca9ed17cceb0@amd.com>
Date: Tue, 16 Jun 2026 14:48:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] drm/amdgpu/gmc: Don't compare page fault timestamps
 with other interrupts
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Natalie Vock
 <natalie.vock@gmx.de>, Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, "Yang, Philip" <Philip.Yang@amd.com>
References: <20260525114507.24566-1-timur.kristof@gmail.com>
 <c3f7ba5b-ce84-4626-b772-1e7d656aac93@ursulin.net>
 <eb84897e-f4b3-4638-b7e7-e8a9dc787297@amd.com>
 <2899310.lGaqSPkdTl@timur-hyperion>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2899310.lGaqSPkdTl@timur-hyperion>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0427.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DSSPR12MB999213:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c9d7e92-5a6c-4ed7-b8ac-08decba5980a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|921020|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BzNQ51K1IPWpAnHG3RJlxSEbmSICeXe7kK0gDMw45E8K0wt++Gxn9crgKTS1P46ija+ahcz6CC9hSFXipGzWz5DL2lAY3N3NP79rvrcmzFyWj1zboJD6W/HdwEfXxcM2bV/Z7zDqS1McpsraLVnEvZu0Cago161G0qMoJ3emvcZHWnzIbEbRath63EEmYlfEPz/ubgeQac1sMAtrLWvlDDaGGDvcHqn9uSdAS16EUJO38czcOQW0w+4/skjKm83mwPdduwaWMqB+7y3ya5mbO+50GTRETCFeIb1qZKpGWXsmFWdTwvPlkHgCjtJ19yt5YaER+c5ATfrnzGPgWRT+xbxls1LF7IcgB92L9RjTUfuTiMigUA/l/wUjJf5HGatQe2TDeIiUs/durtZaeG9MaqTOQwRKdx4n5JW9lrGYNk8K49LZ4tiJu7quUX2Kol8r0MoF6IvBavuyDF5NHaDAwWo0J4k+dPoz2OUhflAgtQn128am7GNZtvmiuMk88f46NEs7Gc/rP3+8VMoKOoBAzi6uUxrtZ920FAICR1B1Nv77ED/QsNnewWFN40rrTqEXrObEUyaArRNUC+ShBTo81rleOOLjQQAcdKiFRFghCu8HV0jWUC5Wu6uorZJa51jdMqmzwB6ZYg8wdXh6TypV2FBEHIPa6MeZwXYqhKpb3x79OT8sJv1wBwVw4ecsSocMY/7e3TIlP0btdQGzCirlVDeF6vIMHE7wov8JYYKpaNA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(921020)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWxwQ0dFRkxLMEdOMllUSy9PS0VrNFpkRjZ2bWpoSHpxTHM1bmpGVzQyOGRn?=
 =?utf-8?B?N242ODFMalRKUDRLZWZjWlVTZGtlWitqeHpMRTBSb2h2TG1vRDBTOGFtQjhP?=
 =?utf-8?B?SXJvVmV2ZlNSanVoYnFJTTIxQWFxa3ZYQXF2S0lpZUExR3NKU1o4WmhxSkRk?=
 =?utf-8?B?SEljZC9lSEs2MVd4aGtQaVJmVUV0MHU0L3liOU1pSFdjUTJwMWo3YWF4WGVV?=
 =?utf-8?B?aHRnVENtaUhWb3dWTUpoQ1pMUzhENGpOcms3eVZwbEJXbGZmYXFaL25yRWZz?=
 =?utf-8?B?WFVXSm93U3ltN3dBWFJQOUpQRjJPcEs0aUY0MHBKeGlmU0ZpcURsTmJDQlB2?=
 =?utf-8?B?YTdwanAranFKa2gwTGVlLytJZkVsRjYxSURhSUZBeGxmbGpjZUxHZkVPOGYr?=
 =?utf-8?B?RGkzNkFaUTRXTk4xc2tEWHVNTnUxMGw5bmV6QUcra1FEbEJjYjRKT1JhdVZF?=
 =?utf-8?B?YVdoQlcycTZwWEVBNDhHdUw1Q3gySWVtUFl4WFJyN3dWb0oxVzh6MWFBeDhn?=
 =?utf-8?B?NTZKUlhPQ3o4bHRQdWFPSi9zU2VoOTB3Rmp0NDhnRkxpdWVZa29OY3ZXaFZD?=
 =?utf-8?B?QTcwQnJIR200MTdrQ2N5Y1BubVk1dDJZRE1TRU9uSGVPZzZmcEI0RUo1Vnd0?=
 =?utf-8?B?WUI2UGMwUUZkelFFWjlEcEdTUzd2b3gyYmh2a2M0RCtZVjBFTEFMdUFRQjRo?=
 =?utf-8?B?OXpYQkg1RWhCZ3JaOHoyTVV3U3luNUlFZjRHcnJlMGpGRFJpeG5KNU1ZQzl2?=
 =?utf-8?B?dzdMOTlaZ2taQ1ZSa29MbVdNWk9hNzl1aG9lR3NxRGVBSXJxTFZUYnVZeEgv?=
 =?utf-8?B?Z0ZRckZ5SVFhY2RUWlNrM0dtajRJZ3hRS1N6Mm5ZSnV0Rnd0SnJWWDNEdlVh?=
 =?utf-8?B?ckFWcGJoaHNxZGtNc0hueER0OFcvdmVpTDBOK0tUSU5DREFrWlA3MnY0d1BP?=
 =?utf-8?B?cXgwR1FSL2djemFScWV0SlVUSWxkSTlWenR6U2lwcFBoOVZZOU1SWFV2SmpO?=
 =?utf-8?B?V2ZDNUVMcDJGYVNoeS8vMndzekpRWGV2WXR0SGtyc2dONkVMcUhVbUl3Q3Bk?=
 =?utf-8?B?TlVLc1psL2pBNTlnYWw5Skx2SUNJZFIxQ0R2NG9UTkQzd0FEd3JUNHQ2SXBT?=
 =?utf-8?B?d0J3RmpZUVdjVmtGbEpoeS8rS2VsT1Q3bEs4dkZKZVNRTUVveG9CZitUR0g0?=
 =?utf-8?B?Y0Q1VnZKNXB1TTJiaEVjK0d4VlROdEVoTUVQbjlLTVV3aWMxWHJtNmtRNVBT?=
 =?utf-8?B?VnF1dytyS1d6VGZaUURvU3VOZVEraXMwZmVCdmF0SzhvRFlJZE1uWU04ZlZx?=
 =?utf-8?B?bVgzeHdiYVdnUlRQQWN3a2NsUzBDaVVubWxYTU5WeUd2N2ZCY1pLYWtYQ2hj?=
 =?utf-8?B?WXRoVnk5MlkyVnY1T1ozYWJtYnJOWnFEdVZmVm14aU03RTlUUUhyYWVncnZ0?=
 =?utf-8?B?cGQ1Y1kwQXJQSWZDMmZHK0lOU0N5cHhLT01taXlwWDJVMDVKemJVd3Y1bFZR?=
 =?utf-8?B?aE5UUTZtdVZDUTl3TzdOWDM0NmQyQXpXeU9qUTVqN3R0U2tCbUVScGE0eDVG?=
 =?utf-8?B?WldQN3JHajVuWXFnU3kwT0ZkcTNFaWJwMWdpVE9HWVFZdFlIUExsNWF0MFZs?=
 =?utf-8?B?anM4N2NhVzh0K3BTUHBrYnZHWnBVcGN5TzNLV09Vc1Y4ZW9FUHhHVHExd2R5?=
 =?utf-8?B?bXRSMEhwVmxIb2xMVmthclNsNzY0QTMxbERaTW1mcHozd3BCR2loU295NGNU?=
 =?utf-8?B?eHpiVTNjdjk1emFKWW0yRC85TXlWcFl0OFU4b0NKRytkdHNIMDFqb0pMZmsr?=
 =?utf-8?B?Wm5IUkZ0N05PYjhhK3l6ZlUzZGtNZERaZHpjcjN1S2QvMERtVWpLUzZ2RjJm?=
 =?utf-8?B?bWp5akxSVVM0cWtyVkVIandaajhqcWF6L1V2cVF6TUN2OGVpYmFnK3JKdE8x?=
 =?utf-8?B?MU1JK1RNbWdpTmgwZE1PU3A0a2VXY0x1REprcUVhY256eWFSblNaYk4wbml4?=
 =?utf-8?B?Uzc5VVJrMTNySHJEVEFSMmJiWi83N3hMRjBvL0Y5QkZhcjhQd3J3VjdCZ1Vi?=
 =?utf-8?B?KzdDTHkrb1N3OHBjc2ZMWUZXK0Exb3Roc1RDZUpvNWF4Z3FYUzVET2t4ZGVh?=
 =?utf-8?B?OG5iUkFncHBTL2NBQ0FTTE41blkvaHE3M0NJQnhpQVZKSFhVNFMwMlpsM0xC?=
 =?utf-8?B?Q3dLc2dvYkVlWWxzcWZDblo0UWpJSjloYmM4K3cvQmVOQmhqaHhwQmdGbzFH?=
 =?utf-8?B?MFF1NmMyVEVuZkF4ZHd5QkEzd1FuN1l2VFJaM005YWhDaW1VQ0ZibWhCOVpH?=
 =?utf-8?Q?nmvRSrOxgS9tC3KvFL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9d7e92-5a6c-4ed7-b8ac-08decba5980a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:48:41.6540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0vGdZUnnXIVTjCnNk6bcqKDM7NprmgxA2fYDtsNG03ysuGkS+wDXBi4XZH/6+0O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999213
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

On 6/16/26 13:17, Timur Kristóf wrote:
> On Tuesday, June 16, 2026 12:15:12 PM Central European Summer Time Christian 
> König wrote:
...
>> The check was added with patch to make retry page faults more resilent to IH
>> ring buffer overflow: commit 3c2d6ea27955cfac8590884d207353eece8c2cee
>> Author: Philip Yang <Philip.Yang@amd.com>
>> Date:   Thu Nov 18 15:24:55 2021 -0500
>>
>>     drm/amdgpu: handle IH ring1 overflow
>>
>>     IH ring1 is used to process GPU retry fault, overflow is enabled to
>>     drain retry fault because we want receive other interrupts while
>>     handling retry fault to recover range. There is no overflow flag set
>>     when wptr pass rptr. Use timestamp of rptr and wptr to handle overflow
>>     and drain retry fault.
>>
>>     If fault timestamp goes backward, the fault is filtered and should not
>>     be processed. Drain fault is finished if processed_timestamp is equal to
>> or larger than checkpoint timestamp.
>>
>>     Add amdgpu_ih_functions interface decode_iv_ts for different chips to
>>     get timestamp from IV entry with different iv size and timestamp offset.
>> amdgpu_ih_decode_iv_ts_helper is used for vega10, vega20, navi10.
>>
>>     Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>     Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>     Acked-by: Christian König <christian.koenig@amd.com>
>>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> But as far as I can see the whole idea is completely broken. The timestamp
>> can also go backward in case of a reset for example.
>>
>> So having this check like this is clearly a bad idea.
>>
>> What we could do in amdgpu_gmc_filter_faults() is to check some range for
>> the timestamp, e.g. last seen timestamp (in amdgpu_gmc_filter_faults(),
>> e.g. only faults) - value X is considered a duplicate caused by ring buffer
>> wrap around.
>>
> 
> Hi,
> 
> I agree that filtering based on timestamps is not a good idea in general, and 
> we should probably re-think it. I wish someone had thought of that in 2021 
> when the above patch was accepted.

I remember that I brought up some concerns about that when we originally reviewed the patch, but it was quite an urgent fix (as always) so we accepted it in the end.

> Maybe this patch should be dropped and the timestamp check should be removed 
> instead. What do you guys think about that?

That's fine with me but adding Philip just in case we could run into regressions with that.

Regards,
Christian.

> 
> Best regards,
> Timur

