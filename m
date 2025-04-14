Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF87CC369A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 17:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2735410E15E;
	Mon, 14 Apr 2025 17:51:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bt8W5b0L";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC53610E15E
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 17:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIxEXTxw3zrNfmQSW5a7F69ZYUegUw41rgC2N7nGESOw39neh/ZKdcyRCJMOaObEFrG2c2fRe3z/+0lqjqi+bA9KaNzVqXqaz3vkaThFZH5cmgCwIyFnk+QK9AXlSY44PeA1WE/eFA+3RYz1PsX9P6Gqux98bKZHB/vcgUdrTWMO522sfvU+Kh6btuR77P9TAfjfWiieVulKkHE8hEJt9Gf6J3pd8Ghvpiq8UMh1szlu0bJoSorDcLGFYAzvnUzOfH7CvrrS2npiLB/q538XZYGa++cxWLI+OQ5+rHbjkwCFBylmME9w0hrJAgTs54IplW6Si8VkCsR+GRdbw977Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PTYbiy64PYhHmEhckrmxjt7rfCjTA7LcdIhk3TrCwE=;
 b=yYKb+FAHjzmC8W30G3fzMN3+DAwruDk1emU9/R0Kp0m81RiG4YVcfCQqkmcP/bmSon0UbbRp+vsEihCCd00YTn+oJ92sSkvBKWZDWTNuM+4pTEKTj1pOjgWCehbEQUA7u8bEOppnoSWh6ru+u/jynlIpSJ8wE0oJeQS05uzvDx1KoF+labiBGSeqnxTsof0utK4iSs6qM8UXE+tYH3o2TLvNE11LZotum82fA0oCaD/esCDXI7noplFNWUfFnQ20/QMmhzN+s07eFUqszj5ZcGgUnCRV4hvsTk01YBRVyqF1hBHiAB30mRozBelEsvv6/ZAwjwgB3j9mjrp8ODxuLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PTYbiy64PYhHmEhckrmxjt7rfCjTA7LcdIhk3TrCwE=;
 b=Bt8W5b0L/KQLJ77xiDqYBbQxvXb8l4ij5CIRZ9byAef0U7zLbjDu5R/cKCXnSfk5btzo9AnVXU5xqF33Rm+kWzSzKLN+lJFlU4EnakkkrJjmoUsZxiN4wPmj6uuymwvvub28opU++2YfN5aEXU1sPj+wrKeao+aZd9vs8j9b3uQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 17:51:00 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 17:51:00 +0000
Message-ID: <b9d71139-f431-4c2a-b1c5-18e2d52cc004@amd.com>
Date: Mon, 14 Apr 2025 23:20:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu/userq: integrate with enforce isolation
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250414171259.2996574-1-alexander.deucher@amd.com>
 <20250414171259.2996574-4-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250414171259.2996574-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26e::12) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e03c3c-c2f1-48df-6fac-08dd7b7cead0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cG1aUHI1dVVab0J3WjJRdFNNbnhqR3kzb2V1ZURsQzNWc1hwaHEra1BYamZK?=
 =?utf-8?B?UmdJSDZqV0toUThQN0dDSWkxdGUybVF0ekNoRmFXSXhJMnN3Y0ZRdkFKVkIy?=
 =?utf-8?B?dEoxNk16dlZWNEZQb2pXa0QrMUY2TUo1OGFLdmVJWFUzUGtodmZReVBQekti?=
 =?utf-8?B?S2hQQkszYUQyRGRlbTRyTllyUHBwRjBWZzhTcWRNTy9nRWp2Vzhjc3FWMk9n?=
 =?utf-8?B?Y1B0VW91RjIrSm5vK2pYNmdXZlE2YkpybDZQenZnaUlIUjhVMHRtSzczN28y?=
 =?utf-8?B?SUFMZ05kTStmRUhVMVd2RG40U1hFaGRwdXJqNGRUbzJuMGl0SkV0OG5RUGNF?=
 =?utf-8?B?YWNmUXlHeWtQTjU4eWZYSUJNSHJIcHdpWUh0Nkt5dFdqQUk1bzB6ZzZlV3BS?=
 =?utf-8?B?NEVnWVRXUUIzSHIwSGp1RWRoQ1lXd3hSNktvUnkvTHVGZHU5MG9JVFovblZl?=
 =?utf-8?B?d3NWaEsyK2tmanZsTlYxNXZsMlcrRHFNUkhzYWx4b2tmc1NzcWVxa3FpcDg2?=
 =?utf-8?B?bCtJdWxqZ3B2YXVWekZjRzJmM3JBaERzRG9jbWxjbnNmY1E5dU1xNnh1OXZm?=
 =?utf-8?B?MERhMTkyN0hzWVIvL1lOZVh6RkVQalpEVXVJWDZIbkFTcHViWTNUR2VBT1N5?=
 =?utf-8?B?ZWUzTThLZEJBVjdBZXg5ZU12N2x4MEhTZVVmRHA5MC9rYnUvNzNMVHlUaXRu?=
 =?utf-8?B?WlB1SklxT0ZIdmw3VnZHa1FCbUVVS3l2M2YyTWF4TTlMY2puSXNtblo2SUpx?=
 =?utf-8?B?KzBwdzBoeUQ2S1NyUk9qUmJEWVpCUVQ4TmZNL0RtQUlZT0tDRVkyYllXcFl1?=
 =?utf-8?B?QnRtQkxBbURvUDZtMlV4TzdjQW9ldHpyYWQ0UllOd0FOc2xCeXVEMFFqemM5?=
 =?utf-8?B?MDJSeHhGNFpPRTdGYW80eS9mVStTcVBEQzMvQTlmcjh3aE5ia2pNcGtHN21B?=
 =?utf-8?B?T1dndkM2bmlqQTZLVlA2QlU1R20weHB2c0VTTTlqQllhb1E5STBXVUV5YmQ2?=
 =?utf-8?B?d3lHSDllRnVOcFVyY1MxeS9peWRVQUhidUUvdXlJNmVVT2pmVWt6Rm5IVnph?=
 =?utf-8?B?MURxQzZqY1Ntc2ZnT2lPMi9ndVZmZWltcW9vdXQzWTN1ZjY2UGpBZkVLcmhU?=
 =?utf-8?B?N2Q3clkyVUNPWm9NL3ZnWWtkK0hxR2RsWU0ySDZVVlFFUGo5d1lVTGc4R2ta?=
 =?utf-8?B?S1RCRjZNREZRWUpxa2x4Y2tLSWZudy9vckY1ZDJ0UHRqZ3VUVC9sdm01YmRX?=
 =?utf-8?B?YWt0a3RaY3hMbTdYeG5lNzAwTzB4cjg4WlVkN2RmSktLUHZWSUxPazJkUkwx?=
 =?utf-8?B?R1lCNnRTd1oyK1RvUWY5d2VUMW9VaXFqa2xxOWkwVHhmZG1aNFhFRldQa1hz?=
 =?utf-8?B?eEk1VjJZRk1NcGxhMlNhWmJIbnhRN0VpOGNOaWRrbEJQM2RKWGpLb0c2Rloz?=
 =?utf-8?B?ZUxZQnhEUXFuT1ViZitsZ0JNS3gvUEhEV3llZDFuR0x6OFF2dlZUZFpWdU15?=
 =?utf-8?B?S1NjYW5nUnpuRkViZ2dzUkZyMmdYcU5Lekk3eml3SVYrR25PWnNhajFBTnpv?=
 =?utf-8?B?cTMrME5XSjQ0K1pYZ3NLa255VG5WdW9waHIyWWs3UU9DN1B6cUFENkpVRW1i?=
 =?utf-8?B?T2g5aVFVNzFWUWd4VEMwWXVRVGJxY0hzWnNHWlk4ZHV3Y2hEeEZXdVcrUG83?=
 =?utf-8?B?MUgzT3NXWUdqUWdXOUV4RXorci9rM2ZhbmJBdUt2M0V2WlN6SHlTWVIwTkxL?=
 =?utf-8?B?SU12M1BVOWExdWYzWFNMT3BFQS9hMEtFa0YwbHZld2lHb3hiTUR0WUQyVTBX?=
 =?utf-8?B?MnQ5aGRzRVZQOGlzZWlBUHVxYUNZQXg3N2s0ZTUveFhFSUV0QTZuQTNNVi9J?=
 =?utf-8?B?NWpzVENjYVNWbjZmcC81S0hoQko5WVEycjNWU2didnlyS2VrL2JGZ1oxUk8w?=
 =?utf-8?Q?MLqpj2/S9b0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STErNzI2RnR6UjVLaVR5QXkzajZKamRMSTQzYnovTnR3L3FHWVczMnlTMVRj?=
 =?utf-8?B?ZXViMTdwY2IvbXFadW5vTDZ3Rjhxb0I1bCthekhDMm5ybU9jZTNySXh3UjV6?=
 =?utf-8?B?bGNlbmo1WmhWdkM2MVlBMVQzRDNib2owNzRISExwcXJXb0dMWW9iS0phcTNp?=
 =?utf-8?B?WTU4T1dIOXoxWGl4aGsxMDhXd1ZvWWdPT0RKai9CM1VnTWsrWVlmS29LRGVJ?=
 =?utf-8?B?dVBZME1UZWE1bnBGZ1lhRG1nK1MzaXh1bitiNkZsSG9LT09pRVB2WnQ1NGJu?=
 =?utf-8?B?WDdXenExeCs1aWFkb1hLOHNFSDI0bUdLYnlwYXhLbXd4cVZacUhhL3lyd09L?=
 =?utf-8?B?S2JhL1ZmMm5lMkJhamNERloyVWhGb3UvTUgyVUNIeEFNeVR6aEgzckdNWnRV?=
 =?utf-8?B?aDdNbVA2NmkwZlpWa01jYWp4c0VoQXBhWkQzbFU1dzRDejZrdGlueFJROEp0?=
 =?utf-8?B?V1JOM3NzZGtzNFV6VFZ1cTlia0ZVekl2Q2E3L0xsa3hOenhQSmdzTGNsNmRB?=
 =?utf-8?B?Ry9hbk1HaFZMKzVpanJ6VGdKRGdvb3U3ZVEvL1EwNHE0eHVGUCtDeWZBay9x?=
 =?utf-8?B?S3Z2RWZkZ1lBTW0zczJza01qa3dnY3J6M3ovYVFMVHRqMVExMVlucWp4K3RX?=
 =?utf-8?B?WmlIQzNzeFE4ck5ZTnM3Vkc3bE02RFhLZnVYV3lRcU9JZVJLaGYxVlpxbTNv?=
 =?utf-8?B?eHZmMWpweVVoS1JnYnNmTy9TcGVrYnR1NG9aZ2FNT0xlVFRNR25yU0REM0tH?=
 =?utf-8?B?U1UrQmgvVjlLZEQ2ZjBDZXE1OGRyWnFYZnlrVm1tcG5XZWRzZXdaRUlyTVFU?=
 =?utf-8?B?NThLd0ZwM3RHQ01obFExZkx4MXI5U0hleWIwTGx0S1QreEtaUVMxVFBWVFhv?=
 =?utf-8?B?NnFibDZBUW8wMFpMODhuUmFRdE91YmNFdWUxMGpyMWlQQjVWeGhvTGZnMmgw?=
 =?utf-8?B?Mm9JZ0lDWHdQaWFLSkVKU2pBMzhWZHZXQWxyMU05NU52c3B2L2FsWXdZZDds?=
 =?utf-8?B?WDJlYTg5TlZ1ZENxUlJ2QlJxS005QUNJY3p2VFRGQnZ4R2NOMW9SQkJXYzRy?=
 =?utf-8?B?Zm1jbVdGRXM2VEhwTVNuOWZzNHJqRFpzd0VhREtJUHlxWGhUTEZqK0JjVVhw?=
 =?utf-8?B?WE01UDdUbTFTUFRud2lRYXNBTnhNaEpXWVRNempPWFZGSTB0WmQ5dHROeDhy?=
 =?utf-8?B?NGFheG9wZWkwK3BXWlc5VWJhS1cwbmJwZmwvUjJ0R2kybjJ1OFFpUERaMzRp?=
 =?utf-8?B?enNjTU1ad3pFTnZHVEpRWVlQUVM3ZSt5aEVHN1hCclNnVFB1UCt1cUVNWTJs?=
 =?utf-8?B?bEJlQW02bmtvbENKcU0zUVBHVkg2M3BWUUZnd2hNYWx6SFZoNVRqandDUlM1?=
 =?utf-8?B?VW9pK2JsS2tTcmE2WkY1QStmKzBTVDl1RGZiNEV5cmQ5QzJUMk1EQmRiZU1y?=
 =?utf-8?B?UlV4THY3R2FtTlN3VHBrRlU1bDN0QVRTNmVhREpWTlc0TnVkdElveVNoU2hZ?=
 =?utf-8?B?SXZtWTRrS29QcjlGR3pqbmRETkFvODA3M1B0OHFLYVJDUGl4NGh3aHVSMjd5?=
 =?utf-8?B?WGdpcnJ5M3hDcUluWnlHRzRNeFJ1WENvdkZsN0laTXZOSmhlVHgyKzlTQ0gz?=
 =?utf-8?B?OHN2ZTh1dmJKeXhYdlBFOERORHJUVXhTdytxWGRCaTBMNEphQm5iYVIrVjd3?=
 =?utf-8?B?V1ZwYWlHcllhY3RZZHBib1FkY1ZLTDdmZDlqTFBiUE9xeWlYUXkzZkt4YklL?=
 =?utf-8?B?Y0dHL1dMbERldEVDa1d0Y052eWhSYjczMzgwL0RNejJubVRsa0txdkNhbno4?=
 =?utf-8?B?aitwYmM0RlJLa0lDVk9XVGFEUkpiWWpTeEd5ZXFzRHBZVTZXY3dFTzE5dmg2?=
 =?utf-8?B?OTNONnNrMlNwRHBlZXlKZUdHN0poZEVoUFBFVUVjRjJpaHBQRzJPcmJHMnRU?=
 =?utf-8?B?MVMxM0FLbGF0WkEzVENXWXlwNWNEZjRPQ2pDYlk0NUV1eS9YQzVBOUxPMXk5?=
 =?utf-8?B?eDRmY2xwby9VWEZsNWJxZkdxenhSeStMRGxnNHMyYnZsQlphLzVsQVdsalh5?=
 =?utf-8?B?LzJWM211Q01sS2gvU2xYV2hTSzZHZkpwTS9WbkRXZm4zZmpFWExkd1BUdFB5?=
 =?utf-8?Q?UvdFJmYYuaZVUEM4F9qwjOH4n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e03c3c-c2f1-48df-6fac-08dd7b7cead0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:51:00.6489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCGf7N0fMfO/HVwL7+ArMnF6jp6BhcvNlh3nMf43LBcucMPQYn0qjLplh1BB4/mZD7BQ/KmRF/0CZCrMNHtu4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943
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

If i am not wrong @arvind  is already having the patch to remove this 
config. Should we use the function pointer check as being used in EOP 
and SDMA functions ?

Regards
Sunil Khatri

On 4/14/2025 10:42 PM, Alex Deucher wrote:
> Enforce isolation serializes access to the GFX IP.  User
> queues are isolated in the MES scheduler, but we still
> need to serialize between kernel queues and user queues.
> For enforce isolation, group KGD user queues with KFD user
> queues.
>
> v2: split out variable renaming, add config guards
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index c58d32983c45e..71c8b30b1659c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1970,6 +1970,9 @@ static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_device *adev, u32 idx,
>   		if (adev->gfx.userq_sch_req_count[idx] == 0) {
>   			cancel_delayed_work_sync(&adev->gfx.enforce_isolation[idx].work);
>   			if (!adev->gfx.userq_sch_inactive[idx]) {
> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> +				amdgpu_userq_stop_sched(adev, idx);
> +#endif
>   				if (adev->kfd.init_complete)
>   					amdgpu_amdkfd_stop_sched(adev, idx);
>   				adev->gfx.userq_sch_inactive[idx] = true;
> @@ -2027,6 +2030,9 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
>   		/* Tell KFD to resume the runqueue */
>   		WARN_ON_ONCE(!adev->gfx.userq_sch_inactive[idx]);
>   		WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx]);
> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> +		amdgpu_userq_start_sched(adev, idx);
> +#endif
>   		if (adev->kfd.init_complete)
>   			amdgpu_amdkfd_start_sched(adev, idx);
>   		adev->gfx.userq_sch_inactive[idx] = false;
