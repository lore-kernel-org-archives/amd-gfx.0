Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DCCC3ABBC
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 11:22:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F4D10EA1D;
	Fri,  9 May 2025 11:22:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t3zGmbiR";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67A2C10EA1D
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 11:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3RSnDYezBfZW6wyi+Dr7HlkJSz932r23RDGnWwGVuVxi3HJplRUN27XGSCVIOkmankWx7E/RZvcysmo/6znt+2m/eavZAL89HwCjJHCRGcFJSRxevhoYmcnXgsjA3U5bMv7FnA09PfA9mWbjwwty56kI0nO5Q/lL5XylTmeUW5IlAY5EBsL6+Wcw64ERQ8BalE4j+5aCkNG7pcsITPw+eZ6xN4U5Bxiu0CRl+lvVHf5bJTYeHbs0DxPa0nBONxb209u2uhjDUlC3mOwivSaNMku5GcapPzrDXaRURNVBg0IzCXq8rXsSUreSdjbIsMTa59ZeulMa19ufhOmHTzJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avP2fWdIhkP/VZFhwwYBfo3MfH+9txvD2uyF/yKqU+g=;
 b=up0mRmbC1722qExNHuZcGaNXzaCrVjdRG9lbV5gFigiIGEdlQR87333o2y5GBYUqTgtbcNV0pot1jW55WWTJ9LeUA+iwsmxrsKF5bZukIjcHf5mc2Z88D/KN8KIlwIRpd/lQsI8PLaNnWaYvSoQhA2B5SXN03MSpiFfHtyz5XKMh7jIo+5gDL2tUNYhMlj5nCTouwJ9DAW39RIMwQzAxkcynL90j+MimNjOw0Kg5DnuosRv1BxKof9tI0NoeWdaTMaiyyNT20K5q6FzUDt8uxRHrkQFbNM81SZf08zNFZ5vM6sldYKGyhI+BMvJNbuGmzZq8k7t6+o2lf7hdaJ77lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avP2fWdIhkP/VZFhwwYBfo3MfH+9txvD2uyF/yKqU+g=;
 b=t3zGmbiROeHpb/E2m7fqY+vaEg9Rg9N/j0EjSOVOGXg+aZk67/zX6YkENNn4hzlX+1kz+Ljhbmp/TT6m8NGh7sp3pIoNTQXcnA07/P+W2OhOMUksXaEDDxJwQ5jPqk4B22OOY1Nr+B/yjLmF79LQLI6p2DKyFz7JlTYbMg/HYjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by CY8PR12MB8340.namprd12.prod.outlook.com (2603:10b6:930:7a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 11:21:59 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%3]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 11:21:59 +0000
Message-ID: <446d9189-65ad-4a9b-a042-dbd2405055dd@amd.com>
Date: Fri, 9 May 2025 13:21:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix TTM validation warnings in user queue
 doorbell handling
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250509101015.3678143-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250509101015.3678143-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0014.namprd12.prod.outlook.com
 (2603:10b6:208:a8::27) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|CY8PR12MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 245ba597-e5cf-41e7-1845-08dd8eebb6b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1pOTEpzOWJZMjNhWjhGTWRZeDRKZXZ2UVB6MnUzSk80REZWTy9TR1VzNWFG?=
 =?utf-8?B?OXdnV0dpeTF4NUU0aVRXclVGc1ZCS1Jmc1FaQ3hoWkN5Nk5kNTdjNG9BaWpR?=
 =?utf-8?B?ZG5GUjQ2L2xESXFGZ2d5M0VPa0ptOUZkRGRiS01OSnFUUDBkSmIrQWJibUxu?=
 =?utf-8?B?OThEd3o0MVFUcDloRjNDRW9oQ3d0TmNYRnBRUkQ4YTY1eGFzaDJScnUwMkpy?=
 =?utf-8?B?cHpIWG1iRGVMbzRCdHB2MndOY3p1MzgyS3g0eXRWZ2NmSFplN213NS9oWmNa?=
 =?utf-8?B?ZlM3eXQxSTVIdWtJZFpOZGdXQm5UTXpjUDJ2WjVHRzd4SDBRSlpSTlpzd3Nq?=
 =?utf-8?B?TU10cDBaL3NCamM0M1FlQlFXRWdjNGRPRThVcU8ybk0wd1FZaVhoYUhnSHVl?=
 =?utf-8?B?cmRWM3RYM3lwVHZNUTJSZGtOT0J5UGUzZ0lxcERGYVltTGZCdWNxQWZHbG5G?=
 =?utf-8?B?dVlYdkdwQkVxNUVpTXFlRjdVRHhZcHZ4Z2ZrcXF6REpYb0tTbVRMdEZZd09U?=
 =?utf-8?B?VFliZHVIZVVZa2FtZGhoK2xkRkZvSFgwclRNSUdQd2VUaUFZdUQ2dWxwQkhI?=
 =?utf-8?B?RzJOb1RJM2JkNi9pWXRjb2toOXptcGZoTkJtZllGMC96eDVnQ0kxaTRVME04?=
 =?utf-8?B?TmhOYm5NMmZCbHdDQ3liL3psb2t1dlF4aGZjQThFelA5SzJFUFhaN0FZNXpi?=
 =?utf-8?B?MThJaW5KTGh2QlNzWVZMNUx0L2wrWUhtWHViejU1SWlEUUtnY1ZwTVhjNlF5?=
 =?utf-8?B?Vjg0UVg5ZUVzRkRkVkpaUHNPQ2t4em90VHZUNGJMSCtVUnYrV2JmSk0wb1NS?=
 =?utf-8?B?Nmx5azkySFRoUUFwNzZxWkZPTHJ1RXJsWTdkMFdJVUltUmh3QURBMzZvMlF0?=
 =?utf-8?B?SGlWMmFEd0dPdXlPSXdzdE9iUHlsVGkyK3dVcUhqTTZZNkV4Nm04cW0zTkZ4?=
 =?utf-8?B?dXBIYVBmc212dC8zUGdKbFpHaGp4MEliMmtQZEtQbjFGSnVuUFhKeEZnR2U5?=
 =?utf-8?B?Nml1RFkxbzdQWXczOXBDbU5rZHdsZ1pMTHcxbmthUGJXdHhTc0MwS3F3UEFz?=
 =?utf-8?B?cmdZaDU2T0pGcFJ1djFCTXdseng1SjFBbkRTcmNhY0puMXlkUjYvSTBvL1FP?=
 =?utf-8?B?ZTFyQUd1NDZlS2p5SkNqS3hDSnNVc2FBcE40YlRvaXpyMDJIdjBWUndLVTZC?=
 =?utf-8?B?d25CTGowQmxSR3IxTjdaeHNITFZ1TmNZUmFBeWdjOVM5R21ZbS8vaWp4aUpj?=
 =?utf-8?B?V05XRlZqQnhPU2N3ZVpsOVUzTFlVOEtwMzF0UjZKNmZ2YzE0MzlFQ2dxeWtl?=
 =?utf-8?B?SjhYSWlZMGNvR2dyZTQ3ZmJPOTlLeVpaVDVETVFjWkJRV0FrZm5wR2pLNVp3?=
 =?utf-8?B?b3d0SkZid1J4bVNzK0M4ZEFlTzkwYTBLeU16ZG9pRUZMUSt2ZlROazdCbmov?=
 =?utf-8?B?VVNKNnhRMkIrbHhLSHM4TXRmbjMzY3NQRlhMd1M2cE5WUnFIRGZrQ1BtOXF4?=
 =?utf-8?B?OEw5azM3Z2hDRnZjeVIxRnFPdkptTzlDaFkwbHB1SnFQWk5SbXRWUnV3UE54?=
 =?utf-8?B?eHFuSHlybHBQQTdiMVovRW81dWNUWXQ1SmNtY1hjWWJkbEF0TEp3TE5QY0FE?=
 =?utf-8?B?YmxON0NEY0d2RThaK210ay8ydkZTVkVXMCtNNU90aDdCaXhINFA0aU9OcWRQ?=
 =?utf-8?B?ZFNheHp3cUduRGg4MDcrZ0ZWTlBSMkhxcVVNQmU3VGYwUmV4QVl4T09vU1NW?=
 =?utf-8?B?eHBIRlBNZlZFMS80eThYaTlhZTV1cFowMmpFVEI3U3puajZoT3VmY1luVVFt?=
 =?utf-8?B?U3lEaTlNRGZzTlJnNE1oRkwzc2hVSDBiTkM2TlJ3MjdLS0RhSTk0RjFXYnVk?=
 =?utf-8?B?akxNQ2VOVzdXYi9HZzQ3bmJSRlpndS9MdzYyUHFBYVlQWFN3RjlDczRFclQ1?=
 =?utf-8?Q?I+Ncv44BafI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGpRak16Mndmc2pLZHdCS2xHZzVTZmEwRzFiUDhCNUxWNFlqb2MrRkZxUEMv?=
 =?utf-8?B?SW1pOXkxOUg5SXFLZjM4dGprVWVKam1pQXk0YmFIME10QnRnYlEwbHRpR25m?=
 =?utf-8?B?S0JpRURleEtyOWpob3pvVkZYVE9ZQmQxL3RxQ09HRFVONjlYWGZPMFp3QUdW?=
 =?utf-8?B?aGZCNGJYOUZKWkdPN1FHNkhZK2JWZ05VRmV4U0t5aFl1QjFBY3RhdmNEYldt?=
 =?utf-8?B?WURPM0NRL3ZNNjJGbi90a3lsS2NDTWpUekpJQWZGTHNkWlhPcGJnMmFobjFi?=
 =?utf-8?B?SDNWUk4wWEZpWFJKY0hkOEVaWTJ6SG9rMUZxaVRibjZJTGRLcEFpSnI1bjJM?=
 =?utf-8?B?a3hnR0R2YUlKKzhNS2pPNFhncGhnV0VhUmh1dE12WlRpRjFPZTltbFBUZmFU?=
 =?utf-8?B?cTlRZVRNUU4xK1JNTE9VWEk2YVd0ak1kODlZZzYzK1UvYzFpZEl6ZzRMU0pK?=
 =?utf-8?B?bHZRbCs3b014eDBrazJrYmxMd2tnM0c2bmlCazd4bi9CdWc1Y1pxNTd6Zllh?=
 =?utf-8?B?bXZ5WnNaOGlyZUg3bTd1YlhkTW9WUHgvVXBPUUlHNmZxVXozd3BXMmNwME13?=
 =?utf-8?B?bDJ1ckFGZGx1SzRoSlVsOUFKZDRZa0Jxd1ZGQ3hQbGpUZlZIQUd2L2hnb2V1?=
 =?utf-8?B?SWxBVzM3ZHBoQXBUdFA5NzQ5TFZPaE5teVZTTHJub1Y3N2xoQmZzTmhHeGNz?=
 =?utf-8?B?a3plMHdUbllldEE2a1JMWjlDbkYybEtDSVp1aFJxa3JmTCtjQWlvSFd0Z1V4?=
 =?utf-8?B?aEFza1ZkeFloVGp5RmJnaHRTcnZjUFVWNXVsNFBlaDFIZ3JLSFFGdFZ3Nk9u?=
 =?utf-8?B?TzhIOU9wSndqOXduTWlZdVVSSFREYk13YmdYeldPQmM2c01UbEc0SjExYkVm?=
 =?utf-8?B?dkNmQUM4V2FzL0ZKWHROZVkvVDdnMkVhcHFCUUN6Z1FkMm5qQnNBRHZFbWFJ?=
 =?utf-8?B?d2xaVGR4c3NtZWpQM0dqNHl6WEY4OFYrRUUvM0pJWkRNQ1hPbGlqa1RtQzdP?=
 =?utf-8?B?YVdxVEN3QzAxYTVCN2NIdTBWRE5yTTZqUjgveHBxeEUxU0VFc09aWnlDYjJs?=
 =?utf-8?B?eThaaGFSSUxaU25YeTBESkJUWWtLekowZ1JDV2VVaU00RjFCdXhhU1ZBTjhj?=
 =?utf-8?B?bWNJNFY0aUNJNUhURDgxTHpOeU9QNDhZR0YrTU1qL3dNMkFxNXIvbS8rQWNx?=
 =?utf-8?B?SWJ0cjk1b1BIMnZmVy8rVnd6RGF0M3NzekFzOG5lTEgyVjJUV3Z3Z2MzNmRS?=
 =?utf-8?B?VXlQTkorMUZwK1dOWHJmL2NNTm4vMWQ1ZmtYTmVxSjl0a0QxWlY2cGU0Nk85?=
 =?utf-8?B?b2syQk5vTGw4VVpWZFFkV1pLRThJQ1FTbmVmejJQMm5rdEQzWGtlRVljOFpM?=
 =?utf-8?B?SzR5K0JleEdhTWlCb2hwTjhKbUhXTkh5TkVQajB1a2lxVUJiRWExM0g0Y3JD?=
 =?utf-8?B?SEZCZnFLTHNBOGx6OU1uVjd4S2I4c2wzYUhjb1NGckszNU1nWjhDaU1iZzBL?=
 =?utf-8?B?VGVob3NhVFJnMEdtQlNZZ1VycUxOQnUzTG9ab0JzbGliY2FYa3FzM2VoM3dO?=
 =?utf-8?B?UUNoSnIra2psN2dQTmlwNzA4N3JZSUYxQzZ5ZnRwZzFQZlpNc1BtbHFuV1I5?=
 =?utf-8?B?Mlk5SkFQcVN6bk5vdU1JWmk3TWovb1ROWHR1eVpJWllrUTJGVjk2STdnZ1h5?=
 =?utf-8?B?NGhrN3d5WDVudVkzcWFLazFHQXFCY0E3WFV4VGVKeFl5OW04cUJzMm1tTFR0?=
 =?utf-8?B?cEFnOHp6OVpTZys4TDFjN0lSbVFxTWtkTVcyUklNbSt6N2lGMU53Q2FRWmxj?=
 =?utf-8?B?VEpaODMya3NqNE1sM2VWTXRXUCt5aUFTWWdTL3JJbGsramd6dE5wSTUxcFg4?=
 =?utf-8?B?aVJqRHRrYWdYVW9qRm5XenJJNitpRmYrOVFNUGZHcHFLMzI0a2pRbWJGcVlN?=
 =?utf-8?B?N2tLdzV5OHY2R282ZWlYb0R0QUNubHVNR1JYQXliaytjellYdmlQZ2FiVzVH?=
 =?utf-8?B?T3lHZkpvdFRpZU96NklCRW9VaVdJZEc3TjlnL2Z2Y1JDdS9pQ0tBaFVVUkJm?=
 =?utf-8?B?UDd1WlFYSXB5bkVBWVI5UlZaOUlHVFBaYWkvbTVRUkg2eElZdGRSaS8zU3hq?=
 =?utf-8?Q?yKkPOoTnXit9kjkosQPDoiv+f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245ba597-e5cf-41e7-1845-08dd8eebb6b7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 11:21:59.1573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G80Qo7p9Uz68VgrqziKD49xAfKp8lMTa7yunHk29lKHERN2nlFfzcYfc0Y2vV3oU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8340
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

On 5/9/25 12:10, Jesse.Zhang wrote:
> This patch resolves a kernel warning that occurs during user queue initialization:
> 
> [  428.714241] WARNING: CPU: 23 PID: 1965 at drivers/gpu/drm/ttm/ttm_bo.c:823 ttm_bo_validate+0x15c/0x1a0 [ttm]
> [  428.714758] Call Trace:
> [  428.714758]  amdgpu_bo_pin+0x1b5/0x310 [amdgpu]
> [  428.714915]  amdgpu_userq_get_doorbell_index+0x71/0x270 [amdgpu]
> 
> The warning occurs due to improper buffer object state management when
> setting up doorbells for user queues. The key issues addressed are:
> 
> 1. Incorrect locking sequence - pinning before reservation
> 2. Inadequate error handling paths
> 3. Race conditions during BO validation
> 
> Changes made:
> 1. Reordered operations to reserve BO before pinning
> 2. Added proper cleanup path for reservation failures
> 3. Improved error handling with separate unpin/unreserve paths

Looks correct to me, but IIRC I've already seen the same patch from Arun.

It's just that Arun probably hasn't committed it yet because he's on vacation this week.

Regards,
Christian.

> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 33 +++++++++++++----------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 0f1cb6bc63db..444a0f5d98ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -283,28 +283,31 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>  	uint64_t index;
>  	struct drm_gem_object *gobj;
>  	struct amdgpu_userq_obj *db_obj = db_info->db_obj;
> +	struct amdgpu_bo *bo;
>  	int r, db_size;
>  
>  	gobj = drm_gem_object_lookup(filp, db_info->doorbell_handle);
> -	if (gobj == NULL) {
> +	if (!gobj) {
>  		drm_file_err(uq_mgr->file, "Can't find GEM object for doorbell\n");
>  		return -EINVAL;
>  	}
>  
> -	db_obj->obj = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
> +	bo = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
>  	drm_gem_object_put(gobj);
> +	db_obj->obj = bo;
>  
> -	/* Pin the BO before generating the index, unpin in queue destroy */
> -	r = amdgpu_bo_pin(db_obj->obj, AMDGPU_GEM_DOMAIN_DOORBELL);
> +	/* First reserve the BO to ensure proper state */
> +	r = amdgpu_bo_reserve(bo, true);
>  	if (r) {
> -		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin doorbell object\n");
> +		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to reserve doorbell BO\n");
>  		goto unref_bo;
>  	}
>  
> -	r = amdgpu_bo_reserve(db_obj->obj, true);
> +	/* Validate and pin the BO */
> +	r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_DOORBELL);
>  	if (r) {
> -		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin doorbell object\n");
> -		goto unpin_bo;
> +		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin doorbell BO\n");
> +		goto unreserve_bo;
>  	}
>  
>  	switch (db_info->queue_type) {
> @@ -325,24 +328,26 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>  		break;
>  
>  	default:
> -		drm_file_err(uq_mgr->file, "[Usermode queues] IP %d not support\n",
> +		drm_file_err(uq_mgr->file, "IP %d not supported\n",
>  			     db_info->queue_type);
>  		r = -EINVAL;
>  		goto unpin_bo;
>  	}
>  
> -	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
> +	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, bo,
>  					     db_info->doorbell_offset, db_size);
>  	drm_dbg_driver(adev_to_drm(uq_mgr->adev),
>  		       "[Usermode queues] doorbell index=%lld\n", index);
> -	amdgpu_bo_unreserve(db_obj->obj);
> +
> +	amdgpu_bo_unreserve(bo);
>  	return index;
>  
>  unpin_bo:
> -	amdgpu_bo_unpin(db_obj->obj);
> -
> +	amdgpu_bo_unpin(bo);
> +unreserve_bo:
> +	amdgpu_bo_unreserve(bo);
>  unref_bo:
> -	amdgpu_bo_unref(&db_obj->obj);
> +	amdgpu_bo_unref(&bo);
>  	return r;
>  }
>  

