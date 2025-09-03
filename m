Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A590CA0FF2
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 13:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC72A10E89E;
	Wed,  3 Sep 2025 13:58:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IJ2XIdGB";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1771810E89D
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 13:58:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNbev48+t+Hbr4Se9uvEX1U09RI1Ofnvd7PYXIX7CwbU4bM3KqPWAjIPzSM7/dj063sMolbreQTpk7gvjkOQyrNl6+wxuz7xLQhndZyz//qNv+MFhuhR6fJQ0T7JTR3tgxDjghLb1ThWxpwRGR8P9EPBO85cfW0UDmDjFDoxv/2TykZff26uiFhGi6zrrfZbJ9RDFDB43MfKehRu8twwnc7QSuUFLBYkcZ68L02+BlcaP/t115YovCkKOcffZWcXqM+LwzAkXW1aFBTTXcx68jPHwDAPxtPOXeuBmY5XUiscd3C+Mqy/Dsblr9d5JN3zMTH18E5TJu7wFK9G8xr53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haFC9bzVhi269FiCUQv5LmyPVxKqISWLhCyGTF8m1WY=;
 b=Ocglyp8qz5vR4nKFiFJrZ41rE9ae+OImUDplTCwE7FBMrlKY/4YMQXX8R8Qt7zh13d0BZ8WNVWNlFlHaGPy103UUzXnoiwFSToUXcCzJPes1w8KvDFlFadHYQbL+P/kvJ4meDL7nSQ/WY3PjUCxMyrp/qUX3wezieQfQ60E4kfdmIygqyqimxBnIY+agbfJ0D4i1ZRAmmMmgoF9kez8NVS1VEriuqDqp0E95AvoHJ4vdsynYHHmjdFK5KYJ/EvclujYpqudy59hocasp57KFbhXah+dRlxgJLuYaZQt+m7oLtORMasZEzJG05h7ztf4Vzq/2NVJZ+LGBc+ZVYOVMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haFC9bzVhi269FiCUQv5LmyPVxKqISWLhCyGTF8m1WY=;
 b=IJ2XIdGB9stmzAcU2BKVcy3hP6pp0zM7YB4CtLfC54EVTmlH+29O1nw4M9QMwEmWqr0XbA7AchR5SJgXI9/x2CNogBnGcDWdt/x96tmcS4jcVkSOglK9JDUE7H1W1bbtU5lRgfdmCglOafDcVSOn90KhS0yilvJb5baqAR8s4Tg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 13:58:56 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 13:58:56 +0000
Message-ID: <0281d019-8d06-4c69-88e4-5dc8cc81d317@amd.com>
Date: Wed, 3 Sep 2025 19:28:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: revert "Rename VM invalidate to status
 lock" v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil.Khatri@amd.com
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20250828150200.4035-1-christian.koenig@amd.com>
 <20250828150200.4035-3-christian.koenig@amd.com>
 <4149e06a-da7f-46d9-b8da-f0aacaf75758@amd.com>
 <bd5813fa-665c-4dd4-aa31-256487b92264@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <bd5813fa-665c-4dd4-aa31-256487b92264@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::17) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f8de1b-d428-4529-7a3c-08ddeaf20614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YitZV0NQTWU1OEhlalk4Y1RtWjUvckNFLzF3cWk2WnhXRjdIUXExb0hiNWFI?=
 =?utf-8?B?ZGs3WGZBQ25BbmRtVUd5N3J4VGNqYUdDZGRtSTc5blZVU29RV0x3eW5pSUdU?=
 =?utf-8?B?czJhMEpTbG9DVEpjOXl2YXhOUW1sV1J1azNOaWtGalFUMitjdk11VmR2c3VL?=
 =?utf-8?B?VEZ5YmRvdFB0c2NpVWxKaTdyeXh5eTdERGxobGhKbFlDVmh2cmxxREN0MktR?=
 =?utf-8?B?bXZDWmZDM1JXZEF5d2ZRbnF1dnBKejNtbWx4aEVVem52NEFyYzI0OVphUllk?=
 =?utf-8?B?MTdINVZzVkhiVEpMWmpTemR6bHBuSDdmcEUvcnZiWk9pTTRxQzhrNHZzakVj?=
 =?utf-8?B?RDdaMkZObGdUTTZyL3YvUHpoM2RPK0dCR0p4UW1PQ2lES0hDTVUzdTJETzA5?=
 =?utf-8?B?UkpwdkJTRFR3UWVoM0NxTWtkV2ExcHBxejMzZVlKV1ZhUEtOTjdRSjhZMk5u?=
 =?utf-8?B?N1gwc2VBR1hQRlZVOEs0VmkvRUpWTTdEUjF1L1FuWFlBbEVWWE1BL0YxZnpI?=
 =?utf-8?B?ZEN6MlQ2OW1zZXpVYS9kSUtVbWhtbmZtNU9JYUszYWJOQnA3ZDR3R1lKdkI2?=
 =?utf-8?B?YjhKVUFlRkxRT0ZBNk5XUEFwZGp6ZklJN1dEc2lIL015UmFtVzlIKzVrcUtq?=
 =?utf-8?B?Tk90WGVGcmR2dUZlSFpUcHVFYUQwRHJSU1RKbFZ4WHRaVjZIM3l3eVcwSHVI?=
 =?utf-8?B?Q2lvcjJqeDYyK2RXTXZXVEk2NFQzbEF3ZTU5dmVNdWFTbzg3R3dDRi9nMWZo?=
 =?utf-8?B?VEorb1JHVXp4cStYZENaUW1PempnOTFUekp2UmxJV24rNFIwSmJ4Y0FxQ09m?=
 =?utf-8?B?b0J3ZXprL2hhc3RKZ21KM0NnTTVjTXQxRVN1S0Q1S1h3NlpFajhJK3VkUkdL?=
 =?utf-8?B?eWYyQk8wd3Y5QkhnVXFyUlQ2Mm9kejlITFJZMm1pcXByVjRxV1FnY1gwQllz?=
 =?utf-8?B?bkxuS2d2S2ZBMk5yVmhQV2dQdU5yeEY2dFVOdTQzb282emxoUm1YNmFHSzIz?=
 =?utf-8?B?c1pIUG8valJaYUs5bEhyTWtFblZoZThPYnE0R0VCK2VBUjlkVXNEZ0xteWFv?=
 =?utf-8?B?SUxlVnhmOVlrcTFqTUg3bnJjdHBTZXFjbHE3N1lrcklpWE54Ym9EVlZPRTlp?=
 =?utf-8?B?YmN2NnFNV1BxM3k3eHo4d3B6a3FwdGg3SzJ1UXF2OHAvOWZ0QWJzNHFSbHZ0?=
 =?utf-8?B?NjNMVTVMM2krdUp2T1FqN2s0cG13RElEbDhzZ0xGcUt5VG1aL0ZqekRUckVH?=
 =?utf-8?B?RkZuU2g4UG1ZeU9qK0EyN25YenA1aS9rRG5Td2p6azdFUExWVm41OXRRL1lC?=
 =?utf-8?B?VjFJVStGNmg2eHBkdCtXQXVBWS94MEZlUElaSGpzV1NuSVJkTFJSVE85WUpj?=
 =?utf-8?B?NGhJNXI1Q29BMGNBVnFFQml6aGVqNlN3b1FkWGV0RVM4dWpOMzRidTBQalJr?=
 =?utf-8?B?MlVSOGZmTTZCRmRRMHR4cUZtZmVpemgwcEN0OEtnMHdHdTlsR04wUVU1blVn?=
 =?utf-8?B?bWs5Sy90SUgzb1ZEQ2Fmb2dVcmJSL1p3Y2Y1dmxaUTYyTitTMFpaaklVT21I?=
 =?utf-8?B?M2h0NFQvYVRYODNsbFloMStqbnRTL3Q4Z2pBK3UzRjM4Y2tCekxDQVZBc0Rm?=
 =?utf-8?B?MUlMd0dRNXFqTmF2c2tGYTVWN0ZJU0VYU0t4TVVMZCtKVmNmV2ExMlVvVG4w?=
 =?utf-8?B?SEk2MmRnY3V2OVlaSFNnek9ibEpjOE84NUFjbS9xOFlueG02L0pCMURjSFlB?=
 =?utf-8?B?aHpGY0F2UmtBcDVKUHcxME5Wb0dPbXVoRFR0dHlHSENqVEtUcmRaRk8xTVpq?=
 =?utf-8?B?ak9oRC9OaGp2TE5ORnBjZHorQ0J1bGY3VUpzQ3NGTm9oVm00OFllTmx2QVky?=
 =?utf-8?B?MFZKQXBRZEZibml1RWdtT2pqUnYveXJSQVFQY3ZCRHlTRzExZVJKWllOU1Rn?=
 =?utf-8?Q?eDcbVLMeYVA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUxJNzRSL3Y5RFlvWnZKQ3FPaDR3bi9sWEdnWGJaaVNXQkRWMm9CVDBoOGFY?=
 =?utf-8?B?R3hBZzRLSi9mdTByLzA2ajJ2Z3RJLzNPWGpUM2U4bEdzd2NTZEtPWXZkQVc4?=
 =?utf-8?B?cFJWVmk0d3BkY09uMmR5cUt0a2JOS3pDUVgyeVlXVk1ib3RCZi84YmdTa015?=
 =?utf-8?B?WEpXSktpRFo4OGV0T2dzbGFwb21RZGNxbU5UTnBuTUYxOUQzdE9UN0VKdkRK?=
 =?utf-8?B?NnV2c0kxakMwS2ZqMk94UzQvSGJ4czFtbGpSRVpLbERoczY5a1ArZW05ZWhG?=
 =?utf-8?B?VUlTaEVaZ3Mzdy9iWDdnVDZMV0RNQVpUVnFwaU1UWTdwcDd0NEVJbFRHTlZ4?=
 =?utf-8?B?UHdzdE43N2Z6Z1Y1bFN5bS81Uk5YQkZMUFBObFlQV1BENDVJeEJCZ1Z1ZkVh?=
 =?utf-8?B?ZDArUlJzSisreUpFLzE4aDJxRVpBTThwbThJUlMwTldhdElHdnRwK3ZjRXJm?=
 =?utf-8?B?dDZITEpsTmZ5VlpDeEMzTFBJVGsxU0N4dzJ2VnIvTmdBMFZzRmVNeU9TWG9Q?=
 =?utf-8?B?eCtkbDdDa3FZbk5Bcm9mR0xucFFDNDk5RTRpV014YjdHdnNoVHZzc0JxUlQr?=
 =?utf-8?B?OEFMLzZhY1VxM0RabURwZkN4M1drTU1MWk9CdDVkYjBKZXlUOXRtTDBsWjZD?=
 =?utf-8?B?ZWNZS1lVQ1hwYXVmZlBtSmFQV2JRcGV6UjBOMkQyVkhJZG5uMVQ0WjBmMkdh?=
 =?utf-8?B?YTU1d05XT2luUHo1aFV0N3BXaWVZTzd3R1ZqTkd1R3lRdGNnazd5eUlndGpi?=
 =?utf-8?B?bERXRDFBaG1HQk05OUpoMHBZYXJkZzQ0RkdJVkg5V2VKd0xTSHFOODZrbWtS?=
 =?utf-8?B?YVgwRldkQXltUWRoeHlpcDRIU0hpQXhnTTkwSDIrU01vSkMya3FzaEw2ZlV5?=
 =?utf-8?B?R0lXT21pVW1yV2hOZFZkNnhKZWVxNFN1eGVRWk9qaVpCVTBLUXdrUGVCeUJ2?=
 =?utf-8?B?V1R4anZtQ1QxSlpINFdPVHVVMDhFZkhpVWFYNkVEQzltL0dXK3VrVEEraEtw?=
 =?utf-8?B?SGlXVlltOHZySnlLRUFIMkx3UGQ2QTVkRTNiaE5UQzUwZVFMYkUwM0x6V2x1?=
 =?utf-8?B?MVFHdm42Q1dmc0FiYmlZYU1rZkJ5d0hXaTQ0ZVAzcThyMnRXMXMyT05XT2lX?=
 =?utf-8?B?cTFjZzJ4RFoyWGRCZ3FuWjBHVjZsL2NkS1ZhajhMQzUwN0VKYTRPZ1Vvelho?=
 =?utf-8?B?Vm1wUVZMZ00vWERqbENNWCtqVXIvWFg5T042dXdjVkNmUU9TQVFueHFJS1lU?=
 =?utf-8?B?Y0IxcUxOUWxTUnVpeUI2YTFNZW9Rckpzc24ySjNrZ3krNlVpVzM2M1VqR2Qy?=
 =?utf-8?B?d29XK0JaZlVPblFtUUR0cnRsUHFnNzZWSERHVzF4Zm0zQ1N6ZVZMS3FSOWl5?=
 =?utf-8?B?bDBMdWxrOFUxdkUxL2N4eitXY3l4b3dRSUlXWVhDQmtpdDdpWXprdm9KZkw1?=
 =?utf-8?B?L2xCMDQ1ZHMzZHpZOUhqdFdKczBWS3hzcWk3VGVzNG12VS93K0tBNUhoU3Vr?=
 =?utf-8?B?MkV3aFhiazVPdS9PZDEvTHY4ZzNGem5hSmlGZEEyNXp3Rnhwd3VPc3RmR0J3?=
 =?utf-8?B?OTdOeXNjUTVFa0szK3JVYTkxa3FRU1FQd08zUVVpR1B3S2dWV2o4eVNRWWVR?=
 =?utf-8?B?MW5Bai9XM3dLQnZkenhlYVd2UUtxaWExdjM5UldtRG5ZZ01jSU9ROVZQSVRM?=
 =?utf-8?B?ZHZYVVBhbWNSYlN6SjA5L3ArZm8vYXlhQkNhdzhsVHp1dmYrWXdWTVNxOVJH?=
 =?utf-8?B?b1NybGN0SlB3dzRTa1gxbDgvbyt6QUVlZngzbVJ1a0plL1RvQTluN1hleXVt?=
 =?utf-8?B?LzJ1QmY3Q1A2blRqRHJsUHBQRUlWTGM1VWxJeXZlSVdEWXppUXJZeksxVUNr?=
 =?utf-8?B?NzA2eEJhYWJsd2gxd24vc1AxREYvcG9MS0poMFByUEFnTnF2KzlNTFEwT1B0?=
 =?utf-8?B?WmpLa1dhNmh4RytSb1pVMTY3czUzRW9MUmYzdXZDbkdtZ1djNzZyTzVMT050?=
 =?utf-8?B?REF2NXp2ak1FTXdoK0VrS3BXc1pUNnhoMmJiUUtTOVM3S2F2UDI0anZJMUZY?=
 =?utf-8?B?YnRBc2VJZnEvYy9OeUZZenQ3UXFETzZIQ3VDS0NtZ3V5VnJQSldIdlVtMjVj?=
 =?utf-8?Q?myl5T/N/RLT/LbkYtQP3amCVU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f8de1b-d428-4529-7a3c-08ddeaf20614
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 13:58:56.5178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JfWKQD8kmUQMN3rmHMWHGdvtQuQMV3sNQCIhAlXEg64wXZ+tJgyPKZt4K7ufFywsSXqH5FmZpyXeB9IpO62LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
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


On 9/3/2025 7:16 PM, Christian König wrote:
> On 02.09.25 11:07, Khatri, Sunil wrote:
>> On 8/28/2025 8:32 PM, Christian König wrote:
>>> This reverts commit 0479956c94b1cfa6a1ab9206eff76072944ece8b.
>>>
>>> It turned out that protecting the status of each bo_va only with a
>>> spinlock was just hiding problems instead of solving them.
>>>
>>> Revert the whole approach, add a separate stats_lock and lockdep
>>> assertions that the correct reservation lock is held all over the place.
>>>
>>> While at it also re-order fields in the VM structure and try to improve
>>> the documentation a bit.
>>>
>>> v2: re-add missing check
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |   8 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 168 +++++++++++-----------
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  25 ++--
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |   4 -
>>>    4 files changed, 96 insertions(+), 109 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index abc2f96bea76..727dd2e27885 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -562,12 +562,12 @@ amdgpu_userq_validate_bos(struct amdgpu_device *adev, struct drm_exec *exec,
>>>        struct amdgpu_bo *bo;
>>>        int ret;
>>>    -    spin_lock(&vm->status_lock);
>>> +    spin_lock(&vm->invalidated_lock);
>>>        while (!list_empty(&vm->invalidated)) {
>>>            bo_va = list_first_entry(&vm->invalidated,
>>>                         struct amdgpu_bo_va,
>>>                         base.vm_status);
>>> -        spin_unlock(&vm->status_lock);
>>> +        spin_unlock(&vm->invalidated_lock);
>>>              bo = bo_va->base.bo;
>>>            ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
>>> @@ -584,9 +584,9 @@ amdgpu_userq_validate_bos(struct amdgpu_device *adev, struct drm_exec *exec,
>>>            if (ret)
>>>                return ret;
>>>    -        spin_lock(&vm->status_lock);
>>> +        spin_lock(&vm->invalidated_lock);
>>>        }
>>> -    spin_unlock(&vm->status_lock);
>>> +    spin_unlock(&vm->invalidated_lock);
>>>          return 0;
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index a0339187eccd..a25134790476 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -127,6 +127,17 @@ struct amdgpu_vm_tlb_seq_struct {
>>>        struct dma_fence_cb cb;
>>>    };
>>>    +/**
>>> + * amdgpu_vm_assert_locked - check if VM is correctly locked
>>> + * @vm: the VM which schould be tested
>>> + *
>>> + * Asserts that the VM root PD is locked.
>>> + */
>>> +static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
>>> +{
>>> +    dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>> +}
>>> +
>> So the caller is now responsible to make sure to hold the root bo locked while performing all the operations on vm ?
> Yes, that was always the case (with the exception of invalidation from fault handlers for HMM, but that is just one function).
> So the lock before was overload and could have been reason for potential deadlocks, and just a check that reservation lock is taken by caller is all we need. For HMM could it cause an probable assert or not ?
>
> Apart from that LGTM.
> Acked-by: Sunil Khatri <sunil.khatri@amd.com>
>
> Regards,
> Christian.
>
>> Regards
>> Sunil
>>
>>>    /**
>>>     * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
>>>     *
>>> @@ -143,6 +154,8 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>    {
>>>        int r;
>>>    +    amdgpu_vm_assert_locked(vm);
>>> +
>>>        if (vm->pasid == pasid)
>>>            return 0;
>>>    @@ -181,12 +194,11 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>>>        struct amdgpu_bo *bo = vm_bo->bo;
>>>          vm_bo->moved = true;
>>> -    spin_lock(&vm_bo->vm->status_lock);
>>> +    amdgpu_vm_assert_locked(vm);
>>>        if (bo->tbo.type == ttm_bo_type_kernel)
>>>            list_move(&vm_bo->vm_status, &vm->evicted);
>>>        else
>>>            list_move_tail(&vm_bo->vm_status, &vm->evicted);
>>> -    spin_unlock(&vm_bo->vm->status_lock);
>>>    }
>>>    /**
>>>     * amdgpu_vm_bo_moved - vm_bo is moved
>>> @@ -198,9 +210,8 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>>>     */
>>>    static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>>>    {
>>> -    spin_lock(&vm_bo->vm->status_lock);
>>> +    amdgpu_vm_assert_locked(vm_bo->vm);
>>>        list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
>>> -    spin_unlock(&vm_bo->vm->status_lock);
>>>    }
>>>      /**
>>> @@ -213,9 +224,8 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>>>     */
>>>    static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>>>    {
>>> -    spin_lock(&vm_bo->vm->status_lock);
>>> +    amdgpu_vm_assert_locked(vm_bo->vm);
>>>        list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
>>> -    spin_unlock(&vm_bo->vm->status_lock);
>>>        vm_bo->moved = false;
>>>    }
>>>    @@ -229,9 +239,9 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>>>     */
>>>    static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
>>>    {
>>> -    spin_lock(&vm_bo->vm->status_lock);
>>> +    spin_lock(&vm_bo->vm->invalidated_lock);
>>>        list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
>>> -    spin_unlock(&vm_bo->vm->status_lock);
>>> +    spin_unlock(&vm_bo->vm->invalidated_lock);
>>>    }
>>>      /**
>>> @@ -244,10 +254,9 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
>>>     */
>>>    static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
>>>    {
>>> +    amdgpu_vm_assert_locked(vm_bo->vm);
>>>        vm_bo->moved = true;
>>> -    spin_lock(&vm_bo->vm->status_lock);
>>>        list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
>>> -    spin_unlock(&vm_bo->vm->status_lock);
>>>    }
>>>      /**
>>> @@ -260,13 +269,11 @@ static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
>>>     */
>>>    static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
>>>    {
>>> -    if (vm_bo->bo->parent) {
>>> -        spin_lock(&vm_bo->vm->status_lock);
>>> +    amdgpu_vm_assert_locked(vm_bo->vm);
>>> +    if (vm_bo->bo->parent)
>>>            list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
>>> -        spin_unlock(&vm_bo->vm->status_lock);
>>> -    } else {
>>> +    else
>>>            amdgpu_vm_bo_idle(vm_bo);
>>> -    }
>>>    }
>>>      /**
>>> @@ -279,9 +286,8 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
>>>     */
>>>    static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
>>>    {
>>> -    spin_lock(&vm_bo->vm->status_lock);
>>> +    amdgpu_vm_assert_locked(vm_bo->vm);
>>>        list_move(&vm_bo->vm_status, &vm_bo->vm->done);
>>> -    spin_unlock(&vm_bo->vm->status_lock);
>>>    }
>>>      /**
>>> @@ -295,10 +301,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>>>    {
>>>        struct amdgpu_vm_bo_base *vm_bo, *tmp;
>>>    -    spin_lock(&vm->status_lock);
>>> +    spin_lock(&vm->invalidated_lock);
>>>        list_splice_init(&vm->done, &vm->invalidated);
>>>        list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
>>>            vm_bo->moved = true;
>>> +    spin_unlock(&vm->invalidated_lock);
>>> +
>>> +    amdgpu_vm_assert_locked(vm_bo->vm);
>>>        list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
>>>            struct amdgpu_bo *bo = vm_bo->bo;
>>>    @@ -308,14 +317,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>>>            else if (bo->parent)
>>>                list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
>>>        }
>>> -    spin_unlock(&vm->status_lock);
>>>    }
>>>      /**
>>>     * amdgpu_vm_update_shared - helper to update shared memory stat
>>>     * @base: base structure for tracking BO usage in a VM
>>>     *
>>> - * Takes the vm status_lock and updates the shared memory stat. If the basic
>>> + * Takes the vm stats_lock and updates the shared memory stat. If the basic
>>>     * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats need to be called
>>>     * as well.
>>>     */
>>> @@ -327,7 +335,8 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
>>>        uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
>>>        bool shared;
>>>    -    spin_lock(&vm->status_lock);
>>> +    dma_resv_assert_held(bo->tbo.base.resv);
>>> +    spin_lock(&vm->stats_lock);
>>>        shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>>>        if (base->shared != shared) {
>>>            base->shared = shared;
>>> @@ -339,7 +348,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
>>>                vm->stats[bo_memtype].drm.private += size;
>>>            }
>>>        }
>>> -    spin_unlock(&vm->status_lock);
>>> +    spin_unlock(&vm->stats_lock);
>>>    }
>>>      /**
>>> @@ -364,11 +373,11 @@ void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo)
>>>     *        be bo->tbo.resource
>>>     * @sign: if we should add (+1) or subtract (-1) from the stat
>>>     *
>>> - * Caller need to have the vm status_lock held. Useful for when multiple update
>>> + * Caller need to have the vm stats_lock held. Useful for when multiple update
>>>     * need to happen at the same time.
>>>     */
>>>    static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
>>> -                struct ttm_resource *res, int sign)
>>> +                      struct ttm_resource *res, int sign)
>>>    {
>>>        struct amdgpu_vm *vm = base->vm;
>>>        struct amdgpu_bo *bo = base->bo;
>>> @@ -392,7 +401,8 @@ static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
>>>             */
>>>            if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>>>                vm->stats[res_memtype].drm.purgeable += size;
>>> -        if (!(bo->preferred_domains & amdgpu_mem_type_to_domain(res_memtype)))
>>> +        if (!(bo->preferred_domains &
>>> +              amdgpu_mem_type_to_domain(res_memtype)))
>>>                vm->stats[bo_memtype].evicted += size;
>>>        }
>>>    }
>>> @@ -411,9 +421,9 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
>>>    {
>>>        struct amdgpu_vm *vm = base->vm;
>>>    -    spin_lock(&vm->status_lock);
>>> +    spin_lock(&vm->stats_lock);
>>>        amdgpu_vm_update_stats_locked(base, res, sign);
>>> -    spin_unlock(&vm->status_lock);
>>> +    spin_unlock(&vm->stats_lock);
>>>    }
>>>      /**
>>> @@ -439,10 +449,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>>>        base->next = bo->vm_bo;
>>>        bo->vm_bo = base;
>>>    -    spin_lock(&vm->status_lock);
>>> +    spin_lock(&vm->stats_lock);
>>>        base->shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>>>        amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
>>> -    spin_unlock(&vm->status_lock);
>>> +    spin_unlock(&vm->stats_lock);
>>>          if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>>>            return;
>>> @@ -500,10 +510,10 @@ int amdgpu_vm_lock_done(struct amdgpu_vm *vm, struct drm_exec *exec,
>>>        int ret;
>>>          /* We can only trust prev->next while holding the lock */
>>> -    spin_lock(&vm->status_lock);
>>> +    spin_lock(&vm->invalidated_lock);
>>>        while (!list_is_head(prev->next, &vm->done)) {
>>>            bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
>>> -        spin_unlock(&vm->status_lock);
>>> +        spin_unlock(&vm->invalidated_lock);
>>>              bo = bo_va->base.bo;
>>>            if (bo) {
>>> @@ -511,10 +521,10 @@ int amdgpu_vm_lock_done(struct amdgpu_vm *vm, struct drm_exec *exec,
>>>                if (unlikely(ret))
>>>                    return ret;
>>>            }
>>> -        spin_lock(&vm->status_lock);
>>> +        spin_lock(&vm->invalidated_lock);
>>>            prev = prev->next;
>>>        }
>>> -    spin_unlock(&vm->status_lock);
>>> +    spin_unlock(&vm->invalidated_lock);
>>>          return 0;
>>>    }
>>> @@ -610,7 +620,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>                   void *param)
>>>    {
>>>        uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
>>> -    struct amdgpu_vm_bo_base *bo_base;
>>> +    struct amdgpu_vm_bo_base *bo_base, *tmp;
>>>        struct amdgpu_bo *bo;
>>>        int r;
>>>    @@ -623,13 +633,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>                return r;
>>>        }
>>>    -    spin_lock(&vm->status_lock);
>>> -    while (!list_empty(&vm->evicted)) {
>>> -        bo_base = list_first_entry(&vm->evicted,
>>> -                       struct amdgpu_vm_bo_base,
>>> -                       vm_status);
>>> -        spin_unlock(&vm->status_lock);
>>> -
>>> +    list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
>>>            bo = bo_base->bo;
>>>              r = validate(param, bo);
>>> @@ -642,26 +646,21 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>                vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
>>>                amdgpu_vm_bo_relocated(bo_base);
>>>            }
>>> -        spin_lock(&vm->status_lock);
>>>        }
>>> -    while (ticket && !list_empty(&vm->evicted_user)) {
>>> -        bo_base = list_first_entry(&vm->evicted_user,
>>> -                       struct amdgpu_vm_bo_base,
>>> -                       vm_status);
>>> -        spin_unlock(&vm->status_lock);
>>>    -        bo = bo_base->bo;
>>> -        dma_resv_assert_held(bo->tbo.base.resv);
>>> -
>>> -        r = validate(param, bo);
>>> -        if (r)
>>> -            return r;
>>> +    if (ticket) {
>>> +        list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user,
>>> +                     vm_status) {
>>> +            bo = bo_base->bo;
>>> +            dma_resv_assert_held(bo->tbo.base.resv);
>>>    -        amdgpu_vm_bo_invalidated(bo_base);
>>> +            r = validate(param, bo);
>>> +            if (r)
>>> +                return r;
>>>    -        spin_lock(&vm->status_lock);
>>> +            amdgpu_vm_bo_invalidated(bo_base);
>>> +        }
>>>        }
>>> -    spin_unlock(&vm->status_lock);
>>>          amdgpu_vm_eviction_lock(vm);
>>>        vm->evicting = false;
>>> @@ -684,13 +683,13 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>>>    {
>>>        bool ret;
>>>    +    amdgpu_vm_assert_locked(vm);
>>> +
>>>        amdgpu_vm_eviction_lock(vm);
>>>        ret = !vm->evicting;
>>>        amdgpu_vm_eviction_unlock(vm);
>>>    -    spin_lock(&vm->status_lock);
>>>        ret &= list_empty(&vm->evicted);
>>> -    spin_unlock(&vm->status_lock);
>>>          spin_lock(&vm->immediate.lock);
>>>        ret &= !vm->immediate.stopped;
>>> @@ -981,16 +980,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>>                  struct amdgpu_vm *vm, bool immediate)
>>>    {
>>>        struct amdgpu_vm_update_params params;
>>> -    struct amdgpu_vm_bo_base *entry;
>>> +    struct amdgpu_vm_bo_base *entry, *tmp;
>>>        bool flush_tlb_needed = false;
>>> -    LIST_HEAD(relocated);
>>>        int r, idx;
>>>    -    spin_lock(&vm->status_lock);
>>> -    list_splice_init(&vm->relocated, &relocated);
>>> -    spin_unlock(&vm->status_lock);
>>> +    amdgpu_vm_assert_locked(vm);
>>>    -    if (list_empty(&relocated))
>>> +    if (list_empty(&vm->relocated))
>>>            return 0;
>>>          if (!drm_dev_enter(adev_to_drm(adev), &idx))
>>> @@ -1005,7 +1001,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>>        if (r)
>>>            goto error;
>>>    -    list_for_each_entry(entry, &relocated, vm_status) {
>>> +    list_for_each_entry(entry, &vm->relocated, vm_status) {
>>>            /* vm_flush_needed after updating moved PDEs */
>>>            flush_tlb_needed |= entry->moved;
>>>    @@ -1021,9 +1017,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>>        if (flush_tlb_needed)
>>>            atomic64_inc(&vm->tlb_seq);
>>>    -    while (!list_empty(&relocated)) {
>>> -        entry = list_first_entry(&relocated, struct amdgpu_vm_bo_base,
>>> -                     vm_status);
>>> +    list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
>>>            amdgpu_vm_bo_idle(entry);
>>>        }
>>>    @@ -1249,9 +1243,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>    void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>>>                  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
>>>    {
>>> -    spin_lock(&vm->status_lock);
>>> +    spin_lock(&vm->stats_lock);
>>>        memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
>>> -    spin_unlock(&vm->status_lock);
>>> +    spin_unlock(&vm->stats_lock);
>>>    }
>>>      /**
>>> @@ -1618,29 +1612,24 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>>>                   struct amdgpu_vm *vm,
>>>                   struct ww_acquire_ctx *ticket)
>>>    {
>>> -    struct amdgpu_bo_va *bo_va;
>>> +    struct amdgpu_bo_va *bo_va, *tmp;
>>>        struct dma_resv *resv;
>>>        bool clear, unlock;
>>>        int r;
>>>    -    spin_lock(&vm->status_lock);
>>> -    while (!list_empty(&vm->moved)) {
>>> -        bo_va = list_first_entry(&vm->moved, struct amdgpu_bo_va,
>>> -                     base.vm_status);
>>> -        spin_unlock(&vm->status_lock);
>>> -
>>> +    list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
>>>            /* Per VM BOs never need to bo cleared in the page tables */
>>>            r = amdgpu_vm_bo_update(adev, bo_va, false);
>>>            if (r)
>>>                return r;
>>> -        spin_lock(&vm->status_lock);
>>>        }
>>>    +    spin_lock(&vm->invalidated_lock);
>>>        while (!list_empty(&vm->invalidated)) {
>>>            bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
>>>                         base.vm_status);
>>>            resv = bo_va->base.bo->tbo.base.resv;
>>> -        spin_unlock(&vm->status_lock);
>>> +        spin_unlock(&vm->invalidated_lock);
>>>              /* Try to reserve the BO to avoid clearing its ptes */
>>>            if (!adev->debug_vm && dma_resv_trylock(resv)) {
>>> @@ -1672,9 +1661,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>>>                 bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
>>>                amdgpu_vm_bo_evicted_user(&bo_va->base);
>>>    -        spin_lock(&vm->status_lock);
>>> +        spin_lock(&vm->invalidated_lock);
>>>        }
>>> -    spin_unlock(&vm->status_lock);
>>> +    spin_unlock(&vm->invalidated_lock);
>>>          return 0;
>>>    }
>>> @@ -2203,9 +2192,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>>>            }
>>>        }
>>>    -    spin_lock(&vm->status_lock);
>>> +    spin_lock(&vm->invalidated_lock);
>>>        list_del(&bo_va->base.vm_status);
>>> -    spin_unlock(&vm->status_lock);
>>> +    spin_unlock(&vm->invalidated_lock);
>>>          list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
>>>            list_del(&mapping->list);
>>> @@ -2313,10 +2302,10 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
>>>        for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
>>>            struct amdgpu_vm *vm = bo_base->vm;
>>>    -        spin_lock(&vm->status_lock);
>>> +        spin_lock(&vm->stats_lock);
>>>            amdgpu_vm_update_stats_locked(bo_base, bo->tbo.resource, -1);
>>>            amdgpu_vm_update_stats_locked(bo_base, new_mem, +1);
>>> -        spin_unlock(&vm->status_lock);
>>> +        spin_unlock(&vm->stats_lock);
>>>        }
>>>          amdgpu_vm_bo_invalidate(bo, evicted);
>>> @@ -2582,11 +2571,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>        INIT_LIST_HEAD(&vm->relocated);
>>>        INIT_LIST_HEAD(&vm->moved);
>>>        INIT_LIST_HEAD(&vm->idle);
>>> +    spin_lock_init(&vm->invalidated_lock);
>>>        INIT_LIST_HEAD(&vm->invalidated);
>>> -    spin_lock_init(&vm->status_lock);
>>>        INIT_LIST_HEAD(&vm->freed);
>>>        INIT_LIST_HEAD(&vm->done);
>>>        INIT_KFIFO(vm->faults);
>>> +    spin_lock_init(&vm->stats_lock);
>>>          r = amdgpu_vm_init_entities(adev, vm);
>>>        if (r)
>>> @@ -3051,7 +3041,8 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>>>        unsigned int total_done_objs = 0;
>>>        unsigned int id = 0;
>>>    -    spin_lock(&vm->status_lock);
>>> +    amdgpu_vm_assert_locked(vm);
>>> +
>>>        seq_puts(m, "\tIdle BOs:\n");
>>>        list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
>>>            if (!bo_va->base.bo)
>>> @@ -3089,11 +3080,13 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>>>        id = 0;
>>>          seq_puts(m, "\tInvalidated BOs:\n");
>>> +    spin_lock(&vm->invalidated_lock);
>>>        list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
>>>            if (!bo_va->base.bo)
>>>                continue;
>>>            total_invalidated += amdgpu_bo_print_info(id++,    bo_va->base.bo, m);
>>>        }
>>> +    spin_unlock(&vm->invalidated_lock);
>>>        total_invalidated_objs = id;
>>>        id = 0;
>>>    @@ -3103,7 +3096,6 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>>>                continue;
>>>            total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
>>>        }
>>> -    spin_unlock(&vm->status_lock);
>>>        total_done_objs = id;
>>>          seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 0e3884dfdb6d..96d9b8947409 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -203,11 +203,11 @@ struct amdgpu_vm_bo_base {
>>>        /* protected by bo being reserved */
>>>        struct amdgpu_vm_bo_base    *next;
>>>    -    /* protected by vm status_lock */
>>> +    /* protected by vm reservation and status_lock */
>>>        struct list_head        vm_status;
>>>          /* if the bo is counted as shared in mem stats
>>> -     * protected by vm status_lock */
>>> +     * protected by vm BO being reserved */
>>>        bool                shared;
>>>          /* protected by the BO being reserved */
>>> @@ -344,18 +344,13 @@ struct amdgpu_vm {
>>>        bool            evicting;
>>>        unsigned int        saved_flags;
>>>    -    /* Lock to protect vm_bo add/del/move on all lists of vm */
>>> -    spinlock_t        status_lock;
>>> -
>>> -    /* Memory statistics for this vm, protected by status_lock */
>>> +    /* Memory statistics for this vm, protected by stats_lock */
>>> +    spinlock_t        stats_lock;
>>>        struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
>>>          /* Per-VM and PT BOs who needs a validation */
>>>        struct list_head    evicted;
>>>    -    /* BOs for user mode queues that need a validation */
>>> -    struct list_head    evicted_user;
>>> -
>>>        /* PT BOs which relocated and their parent need an update */
>>>        struct list_head    relocated;
>>>    @@ -365,15 +360,19 @@ struct amdgpu_vm {
>>>        /* All BOs of this VM not currently in the state machine */
>>>        struct list_head    idle;
>>>    -    /* regular invalidated BOs, but not yet updated in the PT */
>>> +    /* Regular BOs for KFD queues that need a validation */
>>> +    struct list_head    evicted_user;
>>> +
>>> +    /* Regular invalidated BOs, need to be validated and updated in the PT */
>>> +    spinlock_t        invalidated_lock;
>>>        struct list_head    invalidated;
>>>    +    /* Regular BOs which are validated and location has been updated in the PTs */
>>> +    struct list_head        done;
>>> +
>>>        /* BO mappings freed, but not yet updated in the PT */
>>>        struct list_head    freed;
>>>    -    /* BOs which are invalidated, has been updated in the PTs */
>>> -    struct list_head        done;
>>> -
>>>        /* contains the page directory */
>>>        struct amdgpu_vm_bo_base     root;
>>>        struct dma_fence    *last_update;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> index 30022123b0bf..f57c48b74274 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> @@ -541,9 +541,7 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>>>        entry->bo->vm_bo = NULL;
>>>        ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>>>    -    spin_lock(&entry->vm->status_lock);
>>>        list_del(&entry->vm_status);
>>> -    spin_unlock(&entry->vm->status_lock);
>>>        amdgpu_bo_unref(&entry->bo);
>>>    }
>>>    @@ -587,7 +585,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
>>>        struct amdgpu_vm_pt_cursor seek;
>>>        struct amdgpu_vm_bo_base *entry;
>>>    -    spin_lock(&params->vm->status_lock);
>>>        for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, cursor, seek, entry) {
>>>            if (entry && entry->bo)
>>>                list_move(&entry->vm_status, &params->tlb_flush_waitlist);
>>> @@ -595,7 +592,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
>>>          /* enter start node now */
>>>        list_move(&cursor->entry->vm_status, &params->tlb_flush_waitlist);
>>> -    spin_unlock(&params->vm->status_lock);
>>>    }
>>>      /**
