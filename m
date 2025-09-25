Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2EBCAC5A5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 09:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DD2610E295;
	Thu, 25 Sep 2025 09:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="boTJsvXs";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BB410E295
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 09:33:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z20MqLoBLoqP0UEzBrx2wb88ZITLe2zzpuaBWkiYbdlIxf97tBI4hnxB6b5QqU2pujS1Bt+FIAyMIbDYfLSq9AOyf7Jv+1T10//JbFIRI9x08YLYNe77dCh9faDtuaL1gAEbFNutDtvRaIg1y8WbZHEF+agK1OJIu+d3YHzu/+ckgm4L1y9jR9TAY1bayFw3f7DZVNHodqlmHTMS51ecLF9JmgdLK/vgfjZwsrTNnSnXudxgVcGyJt7h7QlbvwUvja4RPEr60Cfd2woAMYQRpkRJ26XxLlfpZzoYBiv8uPFwcp8Rc2IjxqTl92/+BVi9Wfad61fuoUPjCWBZa8Iryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55zqtOh0hNOXZpD5m8KMHPVq0W7IklBy2gwoTTBvuMA=;
 b=dI6wZPcAUqGBpolSE0229hWOSHJTDsTGtuBhGUhVly8981kR9TQLN4Jf8y2kW1VNustpTsHiKcV8oitoSVNh+oJ2kWlrBtDoKk/yqyPo59SAjYoTYLqgV0hWNl28EIJipu9YfGhjJPuhOQW8i8wiY+TuivyzrR5YSyl3NZHNMAB/E+t9MuFW4RV9DrtsKn313BJkJ7hzCucESnhAoG7oGiVVoDBtBPjp4815IxCfddBZH/gK+qorYv36OLtAO182Xz2VxhCWULsZJheNCnDARw+5UqK4fd4Xv/0Z9ipNHAyoac4d9IoNUfa9wOkwUDM7x2XWLPpZkAgnH+guDEvb8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55zqtOh0hNOXZpD5m8KMHPVq0W7IklBy2gwoTTBvuMA=;
 b=boTJsvXs7EGE4GiSS5ZImnEF1yroMWIOzRSi1M2RD2OnowG2YBu8Nbnkgvtjfl7E1E/YN7RRtaAo3sPc5AE8sqNMeMD8bGE5s8gGhxMcAFRh1FTlwCZKfALXVo8slMUuXvAfmGY0ipkCWf4yFfB8J6TLu+EgjDsa8iJpUPJTB4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB8023.namprd12.prod.outlook.com (2603:10b6:806:320::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 09:33:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 09:33:41 +0000
Message-ID: <bdfada6a-c2a8-421a-9a98-7c3022486c5c@amd.com>
Date: Thu, 25 Sep 2025 11:33:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: block CE CS if not explicitely allowed by
 module option
To: timur.kristof@gmail.com, alexander.deucher@amd.com, Marek.Olsak@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20250923131025.3268-1-christian.koenig@amd.com>
 <20250923131025.3268-2-christian.koenig@amd.com>
 <1bf9dea32c916538866be9eccb424a28ed1f077d.camel@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <1bf9dea32c916538866be9eccb424a28ed1f077d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0128.namprd02.prod.outlook.com
 (2603:10b6:208:35::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4d0d80-8b43-42dc-9f77-08ddfc169d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXpRakVrV0N1V0tZdStLTXZjaEFvSXMrZks1V29oNGtRUTJPSnZBbnBXOEpU?=
 =?utf-8?B?S1JzdE9vL1ltK0MzWlptZ0hCSmRTaXdLcDRqclpLQWE5bnl1aC9Nd0k5Y1M1?=
 =?utf-8?B?RzRMaXFmM0hyZFg4N0cyU0JJZ0cwZ3V5YklIb3BHWDF3cjMxSEt4VHQ2TkJL?=
 =?utf-8?B?Qk5odGdEYkRxM2dRTEtrdmtyVGVOdzFvaWFPN2VJbWRFZkJlN2JsdHplK1Yy?=
 =?utf-8?B?OThwWmxJeWxsQWs0UTZkb3BFL01mbTdUTUhJeElwTkh4TytwVlBuU2ZveWNa?=
 =?utf-8?B?SDB2RnlObmRuVkt5U3ArbUZYOXJEdXRtcDJpMjIwckRXYmhaamNXRXNEOXpQ?=
 =?utf-8?B?bUphcVB6TXliSlZEUW9rUXpONWM4cWoxclZENnBHVi9YNTJZK295R3JId0ZU?=
 =?utf-8?B?VlkrbVJtTlpZZjBPb3ZvZ21PaTljemNJOFBOMlBZNzJSaHhTZG1DYmxwVHRX?=
 =?utf-8?B?dkg4SUNEWUVtQ1pLNSs0b04ranhVcXRzQnkrK1d0Q3RIMUcyU3ROVWxZZ2dy?=
 =?utf-8?B?VGsvNy9FQjlxYTV4VXcwVFlwajRKaGFmZzVsZG9YYnVzdjdTRVZOeXJmNnU1?=
 =?utf-8?B?WGZHMXIyZnFYaGNyQXQ3eDN4VlpkTlRsQ2V4NW5NNlZKSlQwRTNjZlhPUzdK?=
 =?utf-8?B?eHN6cUFVL3BqT3RXa1FIR2RBNUhUSTlTbGY3V0tvRkZJZnZJdHVSVVBzbmFw?=
 =?utf-8?B?VUxERE5ZMFNnTTBKZXdham9Gem8zUEtyY29kQzlBNm82OGpXdDJOVHI4UkNV?=
 =?utf-8?B?QXlZS3N1aHVuRCtzN1dpOVRERVRsZEhNSlpTNU1Ia0dSWnNmWlZEQ09EdTJj?=
 =?utf-8?B?OWdQd0hObnM3WFRSeGphWjhPNlRmbFJjMitLR1lGbm1LWnB3Y2hsRVgwZUww?=
 =?utf-8?B?UnJEaEhEV3c5VTlJTDVDYTd3TTdSc2pVbktDbFh6UTRFdm5BU0l2a25ZaFhi?=
 =?utf-8?B?WkcvY1dCYTF5cDEraXV5MmtMZnNlRWRMMHI2dzJCS1l6Y3g3RCs4ZVlOQTN6?=
 =?utf-8?B?aEZOdEJadlhhVG5mUmlqR01ON09MS3ZySkxGaTViZjZIZ0crUjltM1hVNWJE?=
 =?utf-8?B?WnRNWHh0am82VTV2TElsV3RSdzZ1MUk4OHlOQWxNWlBGU24ra1lOclExMnFV?=
 =?utf-8?B?WFhTWmpaQmV5UW1BNjVEQjFRQ2luMVdDTkJkU0VYNDEraks3a1plVndFZlVV?=
 =?utf-8?B?VHBvSkNieVhCcG1LQk5rcnpvZHZ6NFM2aFlIRk5abUhSQzc5dzdzdXF1MVRC?=
 =?utf-8?B?Zmd0WDRDbWxpSGl4aHhUSEthMUNxY1puTWt5VzdtMml5d1ArNExCcEFOdVU5?=
 =?utf-8?B?YUFjczVhZGo5NmhBVERjY0ZLa0lwSWFYVDVSTWV4QUlVdDEvdTBJdklhOEZt?=
 =?utf-8?B?eG1adEJOaGRkNDBwOUU1d1RxZWphMk93T1E4b0srWXlZZ2FLT0toRnRBMGhQ?=
 =?utf-8?B?OXJIemIvRDNHdEg0MmgrYVJ2ZVNRM1NDQjY2SExCUGtWL2F0SUFSMHNkQXln?=
 =?utf-8?B?eW9Ld0g0MWhoUmZJdVF0ZHMvVnZ3MW1lN3JrK0JCL2pWVkpHN3hHZWtsRWhW?=
 =?utf-8?B?S2duRkJUeUtSRGpFTmhHY0dLdFpHbk1IcFViaXlmMFZhLzVyOUhJNmI4U3BS?=
 =?utf-8?B?UXovaVVzL1VyWjNuaEFqK3gvU3NsNFBzVzFEemJIc1h1dGJzbXVRMmM5NnVw?=
 =?utf-8?B?M0g1Ykw0cGRnWVdUb1AySm5uTkVuZ2dMNDh6RG1Dd1BDRkppMmhEYVBYTUky?=
 =?utf-8?B?a2xYb2IxdVpNUTFlUFFiakVOS0dra1J1aytISVFQSGlwWlpUZmFYWmpwYmMy?=
 =?utf-8?B?WXl3YjZzQXdic2JHRng5TWt1Wm8wbGVMUlBWQUtZMGU4Ni9hcktTdjRvdFhY?=
 =?utf-8?B?L0lCTkFkZ2gvK1c2RGkyQlNVS2wvSnUzcjAxTTdqOS9SZUQvTnN1MnJ0TlpT?=
 =?utf-8?Q?YwgMzQdnF4E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlRKV1FNS0xtcERhQ2VwaWwzNEQ2bGFYRzBKby9MeDNsdGNKZ01rakZpNHE1?=
 =?utf-8?B?WitHUHBMRGtIcWxYVTdMcHR6SlB5K2wvUHh5R1BBcmNicldIdXpBZ0Z4Tms3?=
 =?utf-8?B?UFhPY2FQd3JId2Z0c0VCTXdWUVNDdk5TTnA5dGRyTTJEbXMyV1BhNEtzbk1H?=
 =?utf-8?B?TkNjLzkzWkNWOFJMSTFqN1VmNlFDUWs5Y3ovbDdKRlB0Y0QvV21qWE9TTjha?=
 =?utf-8?B?T3YvdTRPNE5lVXpNbEpYKzJXWTYzVmo4UkQwbTI2aVU0T3h4VEFiRVZCaW1K?=
 =?utf-8?B?YXlrT3pCbkVMZmNKUHdsZW5FTkxWYWx0QjQvNFVra05JRlFteHByS09YVkhr?=
 =?utf-8?B?SGFRMVprVHd3OGZFOWxGUTRRR2IxSXFBWnlUNHVXN1ZZdnVLZ2pqWXk5cVpC?=
 =?utf-8?B?Q3BERllVbHV3dnNaTTRiOXJLOHdJSmdDdU4yd0hIaWR3QVpldVU2ZTRucFkz?=
 =?utf-8?B?WnZ0UE5Tck91bG04dnlQa25XeW5LNllpNk9vaVg2c1lpSFNXVTdKb1QzTlYv?=
 =?utf-8?B?S2FoN2x6cDRidjlTc3MvT3dQRXFLR0VycVN3THVzTGN6MnU2MVp1S1YvWTFU?=
 =?utf-8?B?WStrNmxnd3dEejNKREpqaUhSRWh6MXYySW52UXRQVkpuRTN2azRqNkhRZDBI?=
 =?utf-8?B?dWlWQTRvM0cyZGwvU01qMkxuZ1NXK21NdDlXRm1LMzV1UGorNVk1ZWdQL2Z4?=
 =?utf-8?B?OEkrb2NwQndKRU9DLy8zR0dYNytsbTNFczVwZ1dJVHF4a3M3bWlQQ0hhbFph?=
 =?utf-8?B?M2NsblZMMVBNcWpWM0drZTFEcDhrNlY4MmpmR2J6Y0tnb3owQTZBbnE4UStY?=
 =?utf-8?B?MDB4eG1NT09BMzJ1bFVFeER2d29wVllkU1pPSHNNRkpsSnNRYXZnTnlvQ1VP?=
 =?utf-8?B?Y29sRng3MUtNYXRKMU5SR01LQm5HTlZWTEdQRXRpelRoNDFHUC9HMzdJWWRt?=
 =?utf-8?B?MWdjYXdUKzVvWnNXaUJuUFdXNWs2NVVyNnlMa3VHRkJGTm5YQXhBcmxRS083?=
 =?utf-8?B?bGVYOFg3cS9ua21waW9sZ2NiU2JHT1loR25QTXVXajUyTS9YOUV0anFtbm5M?=
 =?utf-8?B?d1JUNld2eUdYZUk0LzlwVFVFbDBqQ2tBczA0QlhSN1VNSkR4UHdUNS9OM2xH?=
 =?utf-8?B?b0dKVXQyWm9TTzkyU0RvNy9tSk92U3F3d21PZEVId0dZZ0N6elFxTUN1aVBp?=
 =?utf-8?B?b1orYUZYTS9va0dXaVhnRjdsK2tuUHZKQmkrdytJMUdZWkR5TDlBYW0zYzVR?=
 =?utf-8?B?TjZPVFYyYUlYQ3NpOS9kS1NKQmkwaDNPNWlMNHNMais3aGprNXduWStTdENN?=
 =?utf-8?B?RlJYN3NyQ3RZbzhFT0tSOFhVbDJEeUd3MERvbFp3WDJyVlBkcEhDMFFndFVZ?=
 =?utf-8?B?cU1jTGVIRmpCU1kzS1M0TVlVZmNEcmlKSUhjVWpYTlRLOUx0Uk9VbUpkVytY?=
 =?utf-8?B?VUZXRnZQTzMzN2RDaThnVkxTRk8raGN4U2tmamd4azNheEhCWE8zMUI2Nkxy?=
 =?utf-8?B?bmRVOGowQUU4dkhuckZXMmN2UGtaOGEvbTRSVm9HeHNQc282dXcxVVp1YVZJ?=
 =?utf-8?B?ZTZVV1ptU0hNZkNRMjFhQ3BwR2JTMEFXc3MwOVJkUFY1Zy9jOVVTanY5djg1?=
 =?utf-8?B?UGVaZXIxRkJBbHdmNzNZUXhTeW9PbE1Tci96VmFDT1owTk1QUVFUK3MzK3A0?=
 =?utf-8?B?enA1MmsvZUlVTm03d3BRSk9aV0xEeVJLaTQxVHc2VW9SZ21ISzYrQzRRSloy?=
 =?utf-8?B?K2RreVRFVHRJdGV6WHhSdXYrSDZhNDA0d1VMOHZyQ20zanFoNzJ6OTI4ZFIx?=
 =?utf-8?B?L0dpYlhrbXNIYUx0Z3lFOHhrV1JtTjNIdHBXdVJtUHBBckEybDBrTDBaa1h0?=
 =?utf-8?B?TlVSMSs4K3Z1OFYvWUxLRmR6Z0h0cVZoUlhubElocUVxeXQ3RVlneG9PT0dM?=
 =?utf-8?B?U3k5UUhBZVlrUHBDL1FmVWQxUi8rRlVJdDc1TkVoWGFwMnBzSy9ibDRhblhY?=
 =?utf-8?B?cmRYRi9qRGRqMDBGbkxWK2xQV0RNbTRyQitUNHZ5YnA2bXlVSnJqR1hsQ1pB?=
 =?utf-8?B?NEllWFFWNVQwU21GdlY1cjg1d09zZGtXV1hNaHdiU1J6RUpsR1g5OFYxbjM1?=
 =?utf-8?Q?OJmSAS/1CQj/7bD2xtSHWkE0I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4d0d80-8b43-42dc-9f77-08ddfc169d26
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:33:41.6208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgOXaZYSSuwq3GxID1oRWNIlqYN45C+bd7xkQgOTmDABk8+wHnsRLUtRZoYQP6CT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8023
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

On 24.09.25 01:00, timur.kristof@gmail.com wrote:
> On Tue, 2025-09-23 at 15:10 +0200, Christian König wrote:
>> The Constant Engine found on gfx6-gfx10 HW has been a notorious
>> source of
>> problems.
>>
>> RADV never used it in the first place, radeonsi only used it for a
>> few
>> releases around 2017 for gfx6-gfx9 before dropping support for it as
>> well.
>>
>> While investigating another problem I just recently found that
>> submitting
>> to the CE seems to be completely broken on gfx9 for quite a while.
>>
>> Since nobody complained about that problem it most likely means that
>> nobody is using any of the affected radeonsi versions on current
>> Linux
>> kernels any more.
>>
>> So to potentially phase out the support for the CE and eliminate
>> another
>> source of problems block submitting CE IBs unless it is enabled again
>> using a debug flag.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
> 
> Acked-by: Timur Kristóf <timur.kristof@gmail.com>
> 
> Hi Christian,
> 
> Would you be open to receiving a patch to stop emitting the CE related
> workarounds when the CE is not enabled?
> 
> Alternatively, could we stop emitting them altogether now that the CE
> is disabled by default?

Not yet. I want to push that upstream, wait for quite a while and when nobody complains just completely remove the CE support including all the extra overhead we currently do in the submission path for it.

> Also, should the new debug flag be documented?

Where should we put that? I already noted how to enable it again in the ratelimited error message printed when you try to use the CE.

Regards,
Christian.

> 
> Thanks & best regards,
> Timur
> 
> 
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 6 ++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 +++++++-
>>  3 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 2a0df4cabb99..6f5b4a0e0a34 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1290,6 +1290,7 @@ struct amdgpu_device {
>>  	bool                           
>> debug_disable_gpu_ring_reset;
>>  	bool                            debug_vm_userptr;
>>  	bool                            debug_disable_ce_logs;
>> +	bool                            debug_enable_ce_cs;
>>  
>>  	/* Protection for the following isolation structure */
>>  	struct mutex                    enforce_isolation_mutex;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 744e6ff69814..322890e2c899 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -364,6 +364,12 @@ static int amdgpu_cs_p2_ib(struct
>> amdgpu_cs_parser *p,
>>  	if (p->uf_bo && ring->funcs->no_user_fence)
>>  		return -EINVAL;
>>  
>> +	if (!p->adev->debug_enable_ce_cs &&
>> +	    chunk_ib->flags & AMDGPU_IB_FLAG_CE) {
>> +		dev_err_ratelimited(p->adev->dev, "CE CS is blocked,
>> use debug=0x400 to override\n");
>> +		return -EINVAL;
>> +	}
>> +
>>  	if (chunk_ib->ip_type == AMDGPU_HW_IP_GFX &&
>>  	    chunk_ib->flags & AMDGPU_IB_FLAG_PREEMPT) {
>>  		if (chunk_ib->flags & AMDGPU_IB_FLAG_CE)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index ece251cbe8c3..3b3fc734c0f8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -144,7 +144,8 @@ enum AMDGPU_DEBUG_MASK {
>>  	AMDGPU_DEBUG_DISABLE_GPU_RING_RESET = BIT(6),
>>  	AMDGPU_DEBUG_SMU_POOL = BIT(7),
>>  	AMDGPU_DEBUG_VM_USERPTR = BIT(8),
>> -	AMDGPU_DEBUG_DISABLE_RAS_CE_LOG = BIT(9)
>> +	AMDGPU_DEBUG_DISABLE_RAS_CE_LOG = BIT(9),
>> +	AMDGPU_DEBUG_ENABLE_CE_CS = BIT(10)
>>  };
>>  
>>  unsigned int amdgpu_vram_limit = UINT_MAX;
>> @@ -2289,6 +2290,11 @@ static void amdgpu_init_debug_options(struct
>> amdgpu_device *adev)
>>  		pr_info("debug: disable kernel logs of correctable
>> errors\n");
>>  		adev->debug_disable_ce_logs = true;
>>  	}
>> +
>> +	if (amdgpu_debug_mask & AMDGPU_DEBUG_ENABLE_CE_CS) {
>> +		pr_info("debug: allowing command submission to CE
>> engine\n");
>> +		adev->debug_enable_ce_cs = true;
>> +	}
>>  }
>>  
>>  static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev,
>> unsigned long flags)

