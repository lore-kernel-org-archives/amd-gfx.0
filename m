Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9915C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 16:49:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A502710E062;
	Tue, 17 Jun 2025 16:49:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xGkkD7cr";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A36E910E062
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 16:49:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxeL1EEKxO3Jd6ZEd0i9SKo/8KgSQMHK3e5UDdMBdl3JdXRPJBATUanne0RQ8kEEf0or7bfjJfqgmp4aJmBYhRZp0/cpA/aR9YB5M4KVrHmQ4DRfTXg9UzwPMEJ8HlbPz8ruOx6osm2te/tPRcctL5dJcneGRYlSWvEkAoVRhIFBQsNP00sQFLyISQmAdqOU3zgQxDwt9aGKgVE5VbBGJzfUHNuCM/YtytcrW8LGo2xZidfRann3OELy/Au6z/Hmxvw8UTb05vxa5r4T2jjyfXZpcJOcbknGC1HHeo7SwFXXH38ZFtv4Tj3TONHYQQABn1YyNXbiD1y63pwnMWIOkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6qWckRlz88C6cks1tU696d8STk0eS6X2vKj0cW9JmA=;
 b=Vvo7642LS/KkT7nBMFx0E3Rf9bIaWjQ8izjikyrYOjH/pUrAu2w5Isc+svz0/SIpRG2ZiCfwpxRAh8F+TUQE9v70gbdycZhGr9ijdTNQMovKH7g9RQ4xYMAaWY3C1FpHJwOngMsVHWN1Da4tI4zA0o61WW+AR4+Kl+Y59df/MYoqS4yk8pvPkuF6coRBxYmL0jh6z/Rm84UnRTsQyhV5aQI+dacvrgB2exUWzcVyNBqrenSLUxuNgPRDza/Eb1vod5SMgoamhg48gzRxqaqimerWdVGFa+k60dQyoH/VVeGq+x5qe4Cu+r4hTvvHyuapaFKwDAsiyrMig1aOl/7K6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6qWckRlz88C6cks1tU696d8STk0eS6X2vKj0cW9JmA=;
 b=xGkkD7crhi33UnJLRyD3C7Jku7ZVhc+d0ZpFrGaSGU6XeBzpvrXFnJh50pRUYblNShT8QKjX1+5BSoXbFUrZlsy0wxQJHtJtQcZaoDq1wuPZULrhfpxpDH/qSIHnU5ZU0/NPI1M4fWYW5lQ/xjSMryNZ45ZMieq5rHcp72j9rrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by CY5PR12MB6597.namprd12.prod.outlook.com (2603:10b6:930:43::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 16:49:19 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 16:49:19 +0000
Message-ID: <8ce4feec-9770-4b79-a10c-9cdc44dda03d@amd.com>
Date: Tue, 17 Jun 2025 22:19:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/36] drm/amdgpu/vcn: add a helper framework for engine
 resets
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-34-alexander.deucher@amd.com>
 <351309f3-eb1e-4601-a2c4-51482bbeedda@amd.com>
 <575d165b-f587-4a58-9610-f40ce6f52017@amd.com>
 <CADnq5_M=iU_KaVfN_VmVySN9ZHFAzzHipTz+4cM8FSstAK+nRQ@mail.gmail.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <CADnq5_M=iU_KaVfN_VmVySN9ZHFAzzHipTz+4cM8FSstAK+nRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::9) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|CY5PR12MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: abbfe65f-12ad-4095-70b6-08ddadbee741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTFSaHdwQ2hUZ21ZRHd1Rkc4OFZ5VEhJT1h2VDYwZWsxK3NxdnJTMHEwcGxk?=
 =?utf-8?B?Vjc1YmFGUDJmNGtFRWJET1NPenNmaldaUDhlM3N3ajdWNC9FSUhtZWMrUU9V?=
 =?utf-8?B?Y2ZBSnZ5QVplS09tVnZyZG8xVUlQZFBDSCtoK1ZYN0JnWno1TGc3dTJtSjF3?=
 =?utf-8?B?SUswcloySDNQWkFMUlhRREZJYkhZZndBb1pvb1hYUHhweEU2OTVCVHg3Q3BC?=
 =?utf-8?B?eFBqdEVaek5WNjJwenpYZHlkTkZaRGNxNnpPVElHWjIzSFZ0UnBFN2t2a2Nx?=
 =?utf-8?B?TFlnRGRkRE5jRmtsUE5XY3lya2FIYldEUjN5V3JJRCtsM0pWNEMyTVlXQkk1?=
 =?utf-8?B?V2s0YnVJQVlwNnZ2MzRYcGt4OHZibHdwYmZxQUVqcm0vVHdMOUdwZW5wMzhr?=
 =?utf-8?B?cEFuVi9uNll5czR2eE1BZm4xY2xRMUZrc0pnMUVKVHlZTnEvellsZSt6OXVr?=
 =?utf-8?B?ZEVqQ2lMSjZpTkFGNnhrbExyTzN3M3pCaFlnVDZLczJaS1YyZjZMVTBYWS9T?=
 =?utf-8?B?bHQzQmxtRGJYaUpzaGluZE1RcjRwakttdkZnc1FTKzZ5N3dFQzBBUGM2ZnAz?=
 =?utf-8?B?NXZaOVh5NXFRQWJGdXR0UHpaM2F5UW03bm8wbWdkVGRzYVpFdVFsWW1QUzBH?=
 =?utf-8?B?U3VpS25zM3ZVUmZJSEpzSjNIOUFLWGhSeW8xcTYrZFF2d3pRSmRQckZYR21S?=
 =?utf-8?B?RHBubllwSzJ5dkdFbnVFK2VqeEVOdFNIVzN2cnliQm1rbE5DMGVhaHRLdDBw?=
 =?utf-8?B?cVY5bmdkNlJrVVNpK2NkM0ErSDZkbkZmeGxTU08yc21naHEveEdTQ1RqTzJR?=
 =?utf-8?B?RjVmOVAvSHFKdGVNMVFhTUNQTWpKek5YV3RKQmxwbnpzb01pL3huREE1ajFZ?=
 =?utf-8?B?NGYvT1JMWFNWRGsxam5palJzUDArRW42WC9PVnpiSEZiZFQzeXN0T1RYSGtr?=
 =?utf-8?B?dzIySnA5YUFRSnRGQ3BTUzBSc3E5OERLbytRSkpacEJlRlZNdi94NUJNVUV1?=
 =?utf-8?B?RmlMbVZUalEydFZ2dTJxYUVrWlMzY040d1pmVEZBbVJFTTFDc2xGUnRxZ1ZP?=
 =?utf-8?B?NTlMbThkK0tPTWJJN3ZZaERLZUM5QmpFZHA0VENZUjVjaDkwZFM3ODhFVGRL?=
 =?utf-8?B?T056eUFTRDBTRE1yVnl3QUFRb1k2ZVh0YkNzeC9vZzNkNlBDemtlMU4rK1FW?=
 =?utf-8?B?amxaSDlSTXBSS1pDNnp6Q2EvUklwSXlQUGc5YzJvSjFOY2xGeGJxOFR4WkN0?=
 =?utf-8?B?U0Y0TzVOMkZYOGdrS3NQeVYvVXV6NDJXc0IxWFlCRWNwZkJkcDdFNzhFVlZz?=
 =?utf-8?B?blFoMXFSbmRtQ2VnQzd5dkg2VTJ5S0loMkhMVGJBdStHc0tHSnRDWUZhY1J1?=
 =?utf-8?B?enV4dFBiZXF6Rkw5eWFxQlRxQlVsc25EWk96V09VbVFSdDR2ckE0cjlMTVZM?=
 =?utf-8?B?T2VjaFM4Yk1WRlhhcW5Yc3RsaGNPN3pndXozN084T1hRaTEyb3NCT3Mxekti?=
 =?utf-8?B?WTIzeldPL053UnZmY2JUR0ErZlVlY1hXS0tocTNoOGh5bndQNEhFVXRVYTNy?=
 =?utf-8?B?Uk1KKzJxUGdsQThiVjc4MEhxckYzZ0tibXNvSm5kYSt2TkNPL2MvbWtHbDUz?=
 =?utf-8?B?bVdLS0srMkV2ejZ5OS9NRG9obldEelNBVWU2eGNEZXdIVkZlSHNPc0IzcDRr?=
 =?utf-8?B?Y2o2cElXQ1YzcDdwS205bXlHZEhvOVVDWmJLYjJxeHZoUkdmaHhYK0NId1Zw?=
 =?utf-8?B?cWhlbnNlakJRdjQrYll3WkFqSURvMjNBaU43TUJmWEJ5b2RISjNmbEVwc3hD?=
 =?utf-8?B?ZHk0SHNBNG5DbUZiajI3VFppM0NUcEhXNVB4dGVXZUVGcWg4b2J6Zm9wYnVW?=
 =?utf-8?B?QlRIUjZvY09iSnNYWExtaktob3k1TG5sSHBLNFI2N2RydUlQeUR6MzNpR1Z4?=
 =?utf-8?Q?K7PSeVnUbQI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkt3NkJ5L1VNSUxkU1kxSGw5eitxZmlHUGdMSVhibytxSmIyWkF6eVRCbDhB?=
 =?utf-8?B?R3k4SmluTzFSUDNOQ2VVK1Q0VmRwY2tKUk5FQURtK1BiVnAxSXd3eHpMd2Uy?=
 =?utf-8?B?Mm1iVndzTSsxN0tLK1lqQ2E1WmdZdWNrclhydzZPaTlVc3ZPTThSeGRyTmdQ?=
 =?utf-8?B?QTZicU50ek5kWU5CNEhONHBMK29wVWxLdUhPTDZGMFdZRE0vem9VTGYweDNh?=
 =?utf-8?B?ejFtcmRkV0xGalZGZ3REU01HaEdZWjZVZjRGOFFyUWl6OEp2S2ZzN1FrSjhE?=
 =?utf-8?B?S3NMQWdRK21jMjlkYitmaE9qQldYUng2ZldkcW1zeXR2N0RRcFlRejdxK2g0?=
 =?utf-8?B?MHh2ZjVPdXVlRExoKytsZEoxYk1VV2hIZ1M4M1ZmcHpWQSs5L1MrblZHVmFj?=
 =?utf-8?B?UEl5aDdLTFZpQU5TRVpkNlN3cHFGenNyOEVFNkh5N1M2M2dRUXhRYk5DQTk3?=
 =?utf-8?B?M0h3UzIvYWozd0Nmemgraml4M0pwcXFCWkNVODdXMHcxTS9yUzJnSDVJVWgz?=
 =?utf-8?B?Yi9GN3VwYlRPVXhFNkJpbjduS3pCVFVWcENLR0xSM3F0VEtkc0ozVXdpYmlZ?=
 =?utf-8?B?SmkyZ1BSa3F1b29tUnpmTlErRm9YVnlJTEFvVytGVkZscFNQMlNJcDJUZkI2?=
 =?utf-8?B?RVVyaHhhYnF6UVJhcFlOb3ZIeStUMFNSRUV3T2xmL1pjWC80SVpFQUlmL2hL?=
 =?utf-8?B?YllSWjd5Q3F2TytHZFhEcHNzWkUxUmtTR0ZVQlFVRHg5TlhIbVM3UjFhZGRX?=
 =?utf-8?B?M2VpQ0s1OU42R21aMlc2Vmdod05GTmFkNU1HTHVpcEhEV2RwZkVJSTd3Zmpw?=
 =?utf-8?B?cnBmTnN5enkyd2NucGIrQlY5ZVRMN2RFdTFGcDdweW1JK0ovb1lYOHhCM1J0?=
 =?utf-8?B?c3NSL1N5d0d5N3crN2YvQ0lrZm9qbTZrQVZLWGNWWWVsN3BVSmxBVktqc09X?=
 =?utf-8?B?djdhMzBIaFdzcXc4R1R6c2g2SUl4N1FkL1hTTlhzeFZyUVFMVDhKZ25oUmlQ?=
 =?utf-8?B?RlhLVitlR0R3bGNSalZKV2FEUFJrWkd5ZUpOY3pqaEhHbnNjZ25adlAyaUZC?=
 =?utf-8?B?dUxkWUlOZWVZdGl6TzI3c1BXMTFualp1aHNwdGpmTjZmZGpzVHMvblFtSnEv?=
 =?utf-8?B?aHUxNnMrRkVDSmkxdlZkaTBuaCtvTlozeGpYL2h0bllWaTZBNjhaKzhqaHNV?=
 =?utf-8?B?cFVWd2lPSEpZeDl3cHdwdUE4VE9oVEF6ZzNMdVlGaHJkb2t5QmJZVjFJbUNO?=
 =?utf-8?B?Szc0SmNrcEJwaisxb3pwcG5KTzZhMVp5WUpJWGh4eUk2RGFSZUdHcDN0bllX?=
 =?utf-8?B?V3RIdzNpNFNyNXIydzNMWE04OHZqdnNKWnQxdjE5WWFNNDdJc05INjFXWkti?=
 =?utf-8?B?TlBhWFY3VzhMMm54RDRQcmpGUkVidWxuTEsyVW04VjZHd1U2UDFFaXJicFI5?=
 =?utf-8?B?T1MrQngrTWFCQVQwR0JMcmJmMFpuTUxIc2N6WVNkK1V2L2FmQi8vMjB2MFZT?=
 =?utf-8?B?QXdlZWpTK3dMaWJIUEZFcjR3MGo5WHo5aVlIZ1lyTlhGSUMvMHZFNUpLeEdG?=
 =?utf-8?B?ajFuQlhVNUNUQVAxeS9iQWlibTdaUktQa2RqbTNOMExzUkx2WlBqb0dmV0tX?=
 =?utf-8?B?bCtMV0gyLzZ3UTNkN3RkU3ZXUkZna3F5aklwbkRZci9DUmp0YVhscG5Pck82?=
 =?utf-8?B?L2ExdGVBejJ2MTNNTHQ0cVp6U1FZdGIzN1RzWjJ5Z1ZmSk5QM0NkWnA1UDhj?=
 =?utf-8?B?L21WTEQvK29JWmFyVDliOU1BaXZRVFpURHBRMnlMdDVrT0RUcE1MUGswNHFE?=
 =?utf-8?B?cTRkb05DTGFJMjNtVFVUdWEvU3BXWnNBbklralhhcG04anJEc0lma2ZOYmY2?=
 =?utf-8?B?OHJPd1dPQjhJVGZzbUJiTFUwODM0emNtRmFjVy9td1JjbmJZMmh6UTB6dWJF?=
 =?utf-8?B?dEpQVGo4THpOVVVJWFBoeHdMNi9XVnJxUDhIcHljVGtMWm9DVDVNUHNNV0pT?=
 =?utf-8?B?c21tbW1EVEk3YXVqZUtHN2JHQnJyOTE0ejR1clVibFZMMWRSckJkVUUvcGhs?=
 =?utf-8?B?WmJrM0l6TnBRUi9hWEc4cjJMNjVpT1Y3Qms3QXUyOFQ5LzZIVGN4VjVUTEZs?=
 =?utf-8?Q?mZ2ol70z+7Js5ut+kx6Kj7qJ1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbfe65f-12ad-4095-70b6-08ddadbee741
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 16:49:19.4655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YFN7Jomjy2EVqTzVN+T2vNM1RuW0b8YqvgsKrD4MXVRuNtELTBCPNxeq4Ckzgu60N50S7mYwKUHVXf2ZwP6LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6597
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



On 6/17/2025 6:39 PM, Alex Deucher wrote:
> On Tue, Jun 17, 2025 at 2:10 AM Sundararaju, Sathishkumar
> <sasundar@amd.com> wrote:
>> Please ignore my previous comments here, the new helper additions for
>> vcn non unified queues are good.
>>
>> But one concern, the vinst->reset(vinst) callback must take in ring
>> pointer to handle guilty/non-guilty
>> for appropriate re-emit part, else the guilty ring has to be tracked
>> within the ring structure or identified
>> by some query with in reset.
> I wasn't sure if we could handle the reemit properly on these VCN
> chips.
Your suspicion about it is right, I am not able to get the re-emit to work
on non-guilty ring ever (assuming the timed-out jobs ring as the hungone),
so eventually had to force complete on all queues anyway.

The only thing I was able to consistently get to work was re-emit and 
save good
context on the timed-out job's ring.
> So at least for the first iteration, I just killed all the
> queues.
Agree with you, thanks for explaining.
> Is there a way to know which ring caused the hang?  How does
> the VCN firmware handle the rings?
I haven't figured it out yet, like through some status registers.
I am assuming the timed-out jobs ring as the hung one always.

Regards,
Sathish

>
> Alex
>
>> Regards,
>> Sathish
>>
>>
>> On 6/17/2025 10:00 AM, Sundararaju, Sathishkumar wrote:
>>> Hi Alex,
>>>
>>> Would it be good to have this logic in the reset call back itself ?
>>>
>>> Adding common vinst->reset stops the flexibility of having separate
>>> reset functionality for enc rings and decode rings,
>>> can selectively handle the drm_sched_wqueue_start/stop and re-emit of
>>> guilty/non-guilty for enc and dec separately.
>>>
>>> And the usual vcn_stop() followed by vcn_start() isn't helping in
>>> reset of the engine for vcn3.
>>>
>>> I tried a workaround to pause_dpg and enable static clockgate and
>>> powergate, and then stop()/start() the engine
>>> which is working consistently so far.
>>>
>>> Regards,
>>> Sathish
>>>
>>> On 6/17/2025 8:38 AM, Alex Deucher wrote:
>>>> With engine resets we reset all queues on the engine rather
>>>> than just a single queue.  Add a framework to handle this
>>>> similar to SDMA.
>>>>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 64 +++++++++++++++++++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  6 ++-
>>>>    2 files changed, 69 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>> index c8885c3d54b33..075740ed275eb 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>> @@ -134,6 +134,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device
>>>> *adev, int i)
>>>> mutex_init(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
>>>>        mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
>>>> +    mutex_init(&adev->vcn.inst[i].engine_reset_mutex);
>>>>        atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
>>>>        INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work,
>>>> amdgpu_vcn_idle_work_handler);
>>>> atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
>>>> @@ -1451,3 +1452,66 @@ int vcn_set_powergating_state(struct
>>>> amdgpu_ip_block *ip_block,
>>>>          return ret;
>>>>    }
>>>> +
>>>> +/**
>>>> + * amdgpu_vcn_reset_engine - Reset a specific VCN engine
>>>> + * @adev: Pointer to the AMDGPU device
>>>> + * @instance_id: VCN engine instance to reset
>>>> + *
>>>> + * Returns: 0 on success, or a negative error code on failure.
>>>> + */
>>>> +static int amdgpu_vcn_reset_engine(struct amdgpu_device *adev,
>>>> +                   uint32_t instance_id)
>>>> +{
>>>> +    struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[instance_id];
>>>> +    int r, i;
>>>> +
>>>> +    mutex_lock(&vinst->engine_reset_mutex);
>>>> +    /* Stop the scheduler's work queue for the dec and enc rings if
>>>> they are running.
>>>> +     * This ensures that no new tasks are submitted to the queues while
>>>> +     * the reset is in progress.
>>>> +     */
>>>> +    drm_sched_wqueue_stop(&vinst->ring_dec.sched);
>>>> +    for (i = 0; i < vinst->num_enc_rings; i++)
>>>> + drm_sched_wqueue_stop(&vinst->ring_enc[i].sched);
>>>> +
>>>> +    /* Perform the VCN reset for the specified instance */
>>>> +    r = vinst->reset(vinst);
>>>> +    if (r) {
>>>> +        dev_err(adev->dev, "Failed to reset VCN instance %u\n",
>>>> instance_id);
>>>> +    } else {
>>>> +        /* Restart the scheduler's work queue for the dec and enc rings
>>>> +         * if they were stopped by this function. This allows new tasks
>>>> +         * to be submitted to the queues after the reset is complete.
>>>> +         */
>>>> +        drm_sched_wqueue_start(&vinst->ring_dec.sched);
>>>> +        for (i = 0; i < vinst->num_enc_rings; i++)
>>>> + drm_sched_wqueue_start(&vinst->ring_enc[i].sched);
>>>> +    }
>>>> +    mutex_unlock(&vinst->engine_reset_mutex);
>>>> +
>>>> +    return r;
>>>> +}
>>>> +
>>>> +/**
>>>> + * amdgpu_vcn_ring_reset - Reset a VCN ring
>>>> + * @ring: ring to reset
>>>> + * @vmid: vmid of guilty job
>>>> + * @guilty_fence: guilty fence
>>>> + *
>>>> + * This helper is for VCN blocks without unified queues because
>>>> + * resetting the engine resets all queues in that case.  With
>>>> + * unified queues we have one queue per engine.
>>>> + * Returns: 0 on success, or a negative error code on failure.
>>>> + */
>>>> +int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
>>>> +              unsigned int vmid,
>>>> +              struct amdgpu_fence *guilty_fence)
>>>> +{
>>>> +    struct amdgpu_device *adev = ring->adev;
>>>> +
>>>> +    if (adev->vcn.inst[ring->me].using_unified_queue)
>>>> +        return -EINVAL;
>>>> +
>>>> +    return amdgpu_vcn_reset_engine(adev, ring->me);
>>>> +}
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>> index 83adf81defc71..0bc0a94d7cf0f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>> @@ -330,7 +330,9 @@ struct amdgpu_vcn_inst {
>>>>                      struct dpg_pause_state *new_state);
>>>>        int (*set_pg_state)(struct amdgpu_vcn_inst *vinst,
>>>>                    enum amd_powergating_state state);
>>>> +    int (*reset)(struct amdgpu_vcn_inst *vinst);
>>>>        bool using_unified_queue;
>>>> +    struct mutex        engine_reset_mutex;
>>>>    };
>>>>      struct amdgpu_vcn_ras {
>>>> @@ -552,5 +554,7 @@ void amdgpu_debugfs_vcn_sched_mask_init(struct
>>>> amdgpu_device *adev);
>>>>      int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>>>                      enum amd_powergating_state state);
>>>> -
>>>> +int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
>>>> +              unsigned int vmid,
>>>> +              struct amdgpu_fence *guilty_fence);
>>>>    #endif

