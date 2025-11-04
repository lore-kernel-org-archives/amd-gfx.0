Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56433CCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 16:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D55A810E63E;
	Tue,  4 Nov 2025 16:35:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B5RHAtJa";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013056.outbound.protection.outlook.com
 [40.93.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EFFB10E63E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 16:35:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0EKd4a0OwjnCyEAvGsasoaZNEr/uG36owyV3iSfBmAMuGoH4uSQQJbs99GHzBbgsvrVEe3R+HSlhNb5mUEXYTDniGaQwiUHIWPyJ9NBIMaoiBaeup48E53995DC3nvuqRZzTqkfB9YIPqNE+CWsYE6B7vCAvyZ9LKf67atMfYm1TrHvHWx0ddpcFk9R71VlgAhpEK4TWKD0f+zcZxSMzvobEDEDDxeH0iKG4LtaP/zjoKEtEkdZXF6BTEI1I4S42swnDEOgFFPs5D2ic1/G+pLZMEH+Ubxc85pCrlYD+04ZBtRb+aUM88ulNO3jNGLiaJkxJ2ryv2IiqAoiHDyr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njbluaLPsnRyYeqLjxh0g8+rR01cj9f/wS7Ikn/GkJo=;
 b=kG8/gmZ+49l+kO4o38iSDMdzXthaNmLONiuTrGBbOuQmCei28lZfNeuwZi5B+pcL5Mkjy7jV+xY0eutHlqPwY5oh6C+Q9NTUwiCcyRgJ8rGjn9N/IprF4ffHASfx6L2nK/s+YBMEV1U2ItpCfkqAtrKha7vCfyDnx5/ePS/b6+RS3YSb9+aXI9W+djJQIYAh68h5C/VemAzbPCRg9IThhZRiK7HTk75dMJVDoagG7i6ZXXG2rq3UV8lkxfYoLFi7uliKAirHd1KADmb0gUSHcfDiP5XtKs9Fmx1m/tk/MgwdhD75jIxJjxHXBBaHGhIi5tlne6DH1uqjJ2tWa81Jtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njbluaLPsnRyYeqLjxh0g8+rR01cj9f/wS7Ikn/GkJo=;
 b=B5RHAtJa2n/tQ8dqKXNnE99yGS/JBOYGGQJo1Q09mZA04uZpGQJZUlxL36DzSeI0fqZUwGKKb8FTCZmwjm+Sgo+ShBYbGoNU+LNUONhr19/LJy1sYNb3eMS2lhXax8PLTij+sWgtY/x/QFjOw3rfP6lurQuLOUXvwWHeVRSmFHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB7525.namprd12.prod.outlook.com (2603:10b6:8:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 16:35:27 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 16:35:27 +0000
Message-ID: <81e2acea-f45f-cda8-66a1-3c37f3aa2e9c@amd.com>
Date: Tue, 4 Nov 2025 11:35:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] drm/amdkfd: Fix GPU mappings for APU after prefetch
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Philip Yang <Philip.Yang@amd.com>
References: <20251103222127.3095970-1-Harish.Kasiviswanathan@amd.com>
 <d6a6ae67-6b7b-4cb0-83f2-d1f2624c2f4d@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <d6a6ae67-6b7b-4cb0-83f2-d1f2624c2f4d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0011.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::22) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM4PR12MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 709c4297-467d-4fb7-f614-08de1bc02938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2RrTWdYYlhrNGZUMkVSQjA5L0xBWWZQcW5QRlFqMDBTU2o3MWNXRlJRMzZp?=
 =?utf-8?B?RVo5RlJQd1cxcTBmR3FrQmNTWkY5QVd0VE40WmpoemViZkQ3VFdGS0dnaUlI?=
 =?utf-8?B?c2E3RW05RDJFeTNzalNPc1FJNU9PZHIyOWs4MnlxNmo0endvVFBmUkppd0RV?=
 =?utf-8?B?VFZ1Ymp2S3lhbXZ3TkdzazUxcUNDZHFpMW1vM25DUExLTzd5WTNhbE9OZjlT?=
 =?utf-8?B?YnVUQlpWSmJYNWQxSDF0OElQZjhjNkI2Unc5elZKZElBNDhoZUdKWUk0OXZ2?=
 =?utf-8?B?eHZpNUtGMXJ3NGF3K01JZzE0V3VlQks3Yjd2ZUhYNHE2MTBZbVczQ1UvdGVN?=
 =?utf-8?B?WGJkRnBOS1l2ZTQzNVpZZVJOR3hLQ05VaGVjTkM1d253U21Wb2VDeEpPSURM?=
 =?utf-8?B?K1pVMWI2c1JoUTZCZ1pQQWJGQ09mSmF5WE5VMGMrT1NHRzY1VWs5UkQzQUlx?=
 =?utf-8?B?MlpRVlRJUzZFZlpWdzdlU0J0b2xQemY1cEk3MlM3bS9MTVhHOXI5YlhXNzJa?=
 =?utf-8?B?NDl3S0RDMGlpYVFwRmpvam9nWHJPNmN4MGczSDhNaERFbGRqY0Z1OVJnNkFx?=
 =?utf-8?B?ZkNaWnN4SFlLRTRtNTNGcktnSkxjcklFZ3VXS1grUEM3V1AybTQ1NFJkRDI0?=
 =?utf-8?B?SWczODR4c2ZrZytPSjFmT215Z1J6ZThnN05TbHZXblUvcDBZN1VqU0lmblNB?=
 =?utf-8?B?bUtFRSswL1h0RTdSWDMyQTJpYmxYS24zSFJ3NUo3SzRoZzZxNEZHdVlzTzhD?=
 =?utf-8?B?MGlHQ3BOWG9wVllLdzZqVUxyT3kyTWpQNGE0TlFPckpBSWpyZ0tYdjJ2T29p?=
 =?utf-8?B?dXFYdXA3THM1TTFHenl4VlpNcVpxdk92SzNiVFZGQ2F6QUNRclhiRUM2ZjdN?=
 =?utf-8?B?NTdTUG85YkJoOGNiU1JHcVNpWWVxQnNqc3Y1SVJPNkkxVDg5NkxSR2xPbUFx?=
 =?utf-8?B?ajlQaHN1RERqa0pjMld2ZjEwSytvb2d5NmpOZWRidWdBSU1tTDdzWVhoQk1W?=
 =?utf-8?B?bVdGMER6S2dGcno1eDVsL1V5Q2xHZFlwTm11TWJBaitpZE8zQ2pydHFOODJo?=
 =?utf-8?B?Y1g5Z2kyTjVaandoQUdzanlRRWdhVTRwbDUvTlUwQkRyZW8vUVlRT05WQ3kw?=
 =?utf-8?B?RzUraFhSNjdCanNkVXB4WWRyZ2ZPRk5XWjFVNWk0MUhObHhGbEs0SW5BUHR1?=
 =?utf-8?B?ZVE5alBtWFkzd1FBeTQ1WTlMRDRvQU1SZ3YvR0xsOVJSZFI0TVduMTczUVZW?=
 =?utf-8?B?OVk3bmt1cmUxWlhSMy83L0VwWnduWFROb2hjOFM1WlJrdjE1QlA5S2NFSWNO?=
 =?utf-8?B?OVhHUlh3RWRvS0FtYytpK1J1Y1pqZ3JRYnhMQWM2RnhoakpBUGxneFZBTFhB?=
 =?utf-8?B?VnczdEFWYm5iTS9sWktsUCtGLzhDdFpiaW5CZmM1ZFdXbUJQeUx5ZWZkNHBt?=
 =?utf-8?B?RFR4czg5MWxhSlVqUHhBNWh3L1RuQVhjNmszdnF0azJIdUl0UkVyUCtNRmUy?=
 =?utf-8?B?STViUUdaM3RmWUVjZE4xempxNjVmUEJsQVRMd25VcmozQXkrY2pNTnJvNUJu?=
 =?utf-8?B?RHB3RU9yWHNBc3RZclowVkg4cjJEbHk2MjdwWmxQeW82QXErOHZFcjVKZFVY?=
 =?utf-8?B?bkpPM2QvWWhQUVhlUy9EeXd6OU5GR05mVXk4TzduZVF2MG1DU3c3b0RZaFdw?=
 =?utf-8?B?Ry9aZ1dCM3FpK3FnSlZUdjZNbi9obDNabW1EWktLaTRONm1KU3YwWkxIZE9z?=
 =?utf-8?B?S2VsSjJzckRQNlBVRjlJd0dwSTk4N3VCSlRCcVRFMFhtVWJjbkU0OHRjK1Zs?=
 =?utf-8?B?TVhBMWRwNFkvZ0tZbGNnK2RPUXJKQTVHakwyOE82dzRQVThLV2NMa0NaMElo?=
 =?utf-8?B?dkJ3MldRU3k1blhRcHVySkt3aDN4VDJBR3NVckdjbUdnUkFtdTdEWWlSM29l?=
 =?utf-8?Q?sCINda5BV+uuPmlK48iNZ4499GCrEHuZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1g0NG5DYjh3aUFHSUp4YWFjQzJtSHljMmxWVGszbXRkTEc3Tk94Q3RRUXFG?=
 =?utf-8?B?SndjWjE4b0E2bU15Vy8wTnpCKzVrWUJ3MDRSNnFvNWs4ODNFWTZwVCtvNFhG?=
 =?utf-8?B?c3l0bWtNUDA0UFVqbk0yemtVWWJhQUhiTEM3L2I2VWtxRHg3WkxrM2QvdmdU?=
 =?utf-8?B?aG1lcHk2THV0RGxQNXdXL21veW5aZmRHTU9ESzFVVVlxYzNuOW1MK0dxQWtQ?=
 =?utf-8?B?UFJjUzdLWVhscm5VVENSR0lwcG9aU1laM1I5MnlOZ1o4RXcydzFtdzIrUFBE?=
 =?utf-8?B?clBKT3htVFJ6bWIyV0s0R2tqb2NVRG1NL1dQVzExS2ZDQjFVbi93R0V0UEln?=
 =?utf-8?B?VHZEZ0l6RlBlYnd2SUdvcGY0N1dibkNDSUpvVFB6MWtaV1hBYkxIakI5eUNP?=
 =?utf-8?B?akx6WmI2akJxZTc3VXpXamxIV2p4eDlKVk8rMldlRjllR01YYUhaM3dhcHJM?=
 =?utf-8?B?d2xwOUloWDdrSEdzeXREZlRnbjZPanppWUFQUXdYY0dKMWRrZ24vNURJMStx?=
 =?utf-8?B?Zm1nODMxOHlFdUVEdFJhejJodmp6a1gwNFhRZVppUFNXTTFyMVlpVE5ETDdm?=
 =?utf-8?B?T01QUC9OUjlnRUxNTlFobXA0aWZMRnFOT2lyREpsaVJpRFNZZ1NqS3BvL3ht?=
 =?utf-8?B?UGtidUtuY2x3b3cwSkx4b21ZVmZ0Z0lqMkg2ZklENEZnK3A3dnduSEpPQ3NY?=
 =?utf-8?B?a1huOTBUZXNvd0lUc3JKbGM0TGdqaEw2ZVFGT1VxcmcySk51QlNrejlDaTFN?=
 =?utf-8?B?ZGZVKytpQ3R5ZEVESnhsWlRzcFFsejRZd1RmVUNVOEFOWDRkQXlyUThHbFpz?=
 =?utf-8?B?cUZ1N283bnlXaG8ybC92Z1FCTmIxaGtNb05EY0gycnBtTmdqeW1SZ1dRUnl2?=
 =?utf-8?B?VzVmRFNQbHJBQVpWck5DOVhJVk1jNzdDVXV5d0dNdE9LRU9XY0FWTUMvNEZz?=
 =?utf-8?B?RXpwVDlIQ3lDd2tCV0hyQ3lTY1EyOHluUW93QzNPYy9tdEVpRFVsTUErNXBO?=
 =?utf-8?B?dGNTNDkreUVaSjMvZnlSbXlUZW1UbVBaNnJOKytYRjIxaEZHeEJ2TWtlWXhM?=
 =?utf-8?B?WEhvMkZzS1Yzd1BMcHJLbkl4R1oweCtsakNqWGRmUlhqNzVYMlBucGZyOTBw?=
 =?utf-8?B?cWhrNnorb05KbWRXeU84Q08yTVI1VnpES3J4OXcvOVo5RUtCV2NhZzZJUWdZ?=
 =?utf-8?B?RDRKUjV2SFVrQnUvYU9hbE4xRFFmdGVTcDJSa0UxSXVHbmZ0RDNuTkdBVlU1?=
 =?utf-8?B?Wm1hYmNPdXk2aXdudG9EZ2M2cDN4T21hNE9HQzBqNnV3Wm1JbEd4cVYyNU5t?=
 =?utf-8?B?YnNqckY4c3lPZGNHdzIwYmpmdW16TjV2aG55L0NrQXhGUVRQSHBHdU42ckFu?=
 =?utf-8?B?VW5IRENDb0NIZ2xPTUcxMjk1cnRhN2c1OUE1OERHVWpna0ZJM1RRT3ZMRnA1?=
 =?utf-8?B?ZkdZSzRmcU1wdDhoa0wzQUFxK3BBMnh4UVNwOElaRVFCVEptUGFwK0NSOXdy?=
 =?utf-8?B?NGdobHZ0dnpLblg5NG9YY0JKSkJLWW5NMGkrbzAyNjRUOTBuSWNmaW5IR25Q?=
 =?utf-8?B?NkdyMHg3YnY5ZVJTd0k4Y1Jvc3lUQW91dkJzL2k3aWxiNEpWVDJjZmx4dXhW?=
 =?utf-8?B?VE1uUlJidGE3cms1dFFYZnBOQ3ZlZEFxRUROK2NVYXl4Y0FETDg3L2NhNldF?=
 =?utf-8?B?YnVDQXNRYTRqMFB5Z00rVHBLTWxwYi9PSHlCT0R4QitsaGk0QlNZMGRsOTly?=
 =?utf-8?B?NUJJOGZROUMwL0xoWERKZWs3Zy9zV0N1NldiOCs5Znpuc0pBNFhMSkQzZktm?=
 =?utf-8?B?S2ZHTklvcUgvMG9VdHJPQjdQaGhCVkczc3lvcWFRNUsyaHhBRVA0RC9oY3pv?=
 =?utf-8?B?OTBsOURETXIxQUdOLzcyN3JVemxDekREdmYrenJlQ2d3aEZKQ1hxQ3hSQU5Y?=
 =?utf-8?B?L3hNNDBxd3dySmpHV21wZ0FXYmlXQWhub3BTSEZTSGpCdHlsRnA1RWlocktm?=
 =?utf-8?B?REpuZWtUS2MzLzFaZFlBNitOQVQyUkF0b3oxNmpCalNJcEViMUJrTmZSY1dJ?=
 =?utf-8?B?ZnU0aUtNT2xndlpGc1pDdVlMTzRweTl6UjgvSzZJZGE3YThlZkVSYlpoamNV?=
 =?utf-8?Q?n4JcmH3TY0SiF7jUmg+kHR6Ff?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709c4297-467d-4fb7-f614-08de1bc02938
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 16:35:27.3930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gW3i9WMHWclCjcYLgWLI/zOdsfXuL474RRaXDJ+ha/BEa4rkmOIQeT+Sl/3Vu64M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7525
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


On 2025-11-03 18:25, Chen, Xiaogang wrote:
>
>
> On 11/3/2025 4:21 PM, Harish Kasiviswanathan wrote:
>> Fix the following corner case:-
>>   Consider a 2M huge page SVM allocation, followed by prefetch call for
>> the first 4K page. The whole range is initially mapped with single PTE.
>> After the prefetch, this range gets split to first page + rest of the
>> pages. Currently, the first page mapping is not updated on MI300A (APU)
>> since page hasn't migrated. However, after range split PTE mapping it not
>> valid.
>>
>> Fix this by forcing page table update for the whole range when prefetch
>> is called.  Calling prefetch on APU doesn't improve performance. If all
>> it deteriotes. However, functionality has to be supported.
>>
>> v2: Use apu_prefer_gtt as this issue doesn't apply to APUs with carveout
>> VRAM
>>
>> v3: Simplify by setting the flag for all ASICs as it doesn't affect dGPU
>>
>> Suggested-by: Philip Yang<Philip.Yang@amd.com>
>> Signed-off-by: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>
>> Reviewed-by: Philip Yang<Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index c30dfb8ec236..26eac89c90a8 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -768,6 +768,9 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>>   	int gpuidx;
>>   
>>   	for (i = 0; i < nattr; i++) {
>> +		if (!p->xnack_enabled)
>> +			*update_mapping = true;
>
> If you want always set update_mapping, set it outside loop, not need 
> set it during each attribution check.
>
> And I think the discussion is setting update_mapping when there is 
> split for prange. If change existing prange attributions without 
> split, not need update vm for 
> KFD_IOCTL_SVM_ATTR_PREFERRED_LOC/KFD_IOCTL_SVM_ATTR_PREFETCH_LOC.
>
Maybe change like this

@@ -3800,6 +3800,9 @@ svm_range_set_attr(struct kfd_process *p, struct 
mm_struct *mm,
                 svm_range_apply_attrs(p, prange, nattr, attrs, 
&update_mapping);
                 /* TODO: unmap ranges from GPU that lost access */
         }
+
+       update_mapping |= !p->xnack_enabled && !list_empty(&remap_list);
+
         list_for_each_entry_safe(prange, next, &remove_list, update_list) {
                 pr_debug("unlink old 0x%p prange 0x%p [0x%lx 0x%lx]\n",
                          prange->svms, prange, prange->start,

Regards,

Philip

> Regards
>
> Xiaogang
>
>> +
>>   		switch (attrs[i].type) {
>>   		case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
>>   			prange->preferred_loc = attrs[i].value;
>> @@ -778,8 +781,6 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>>   		case KFD_IOCTL_SVM_ATTR_ACCESS:
>>   		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
>>   		case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
>> -			if (!p->xnack_enabled)
>> -				*update_mapping = true;
>>   
>>   			gpuidx = kfd_process_gpuidx_from_gpuid(p,
>>   							       attrs[i].value);
