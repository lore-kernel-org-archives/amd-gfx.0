Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB4BCAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 20:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2399310E976;
	Fri,  3 Oct 2025 20:27:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DM+UcmJV";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011016.outbound.protection.outlook.com
 [40.93.194.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0032E10E976
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 20:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhU1Qqdp54OVaGUVvvPdwhP8XyLiev2/Fn1rg09nIQ6heVQ2cWpFa9kEURaFoDAuk97h1mFn7gd39n+ujFDKC8pXGH1Si3oZ9Xi6ivlLNvM1ZJcV5wSkHZmIK92Vl74qo8BINgmUn5X2MHKqgOnVU9U1AoXvgK8LHVaaChYl3kLcNnjkJSdoRwX92eA3mILwr+euuGwdScusxxcfcYknK5MnDGBEy3RTU7S2UcOHivCb4xBLu3jo2DQD4DN8jty02gcVB6XyPSoyl9gFFGIuaCE0ADzpY+LuH2YbToRvmousb96N7xffTZk2gy/67hs6+utG2Bg8vMpymMeniUJ1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOe0LLqAKxgFcdXFsTuAEapsSSNlfVWvh/SCE6Ztv5k=;
 b=P1g44TLL7xVmQm3Gw7gXD5yViIiJ5EIXLBBg9JCfvAhyyhUqOwPec6RjyKBDWh1lqI1/jhaBJ3yv0Vfbtzp6X1dOjt1QRMa4oRR32vGCGRsjWeimKQ7OY3g0EspNMjwtySCnsbZ/lOmnXEl4SyPAZdk833YqMUnsL3A3+2XYsfJftyqz9qhtSDkFJwerW5ILe1L2KGiK7P7Fw0rNnN2O2g+Z93SOzy6u0LS6s305YYyKtJy7CXL/uzpCsLAQeabJ0f7ih8HqWmMgzxw+DNonkeWplbjzwtraoe3g1qRQf4jY/JiT3/z9F9+qbZ4LJgVBGHBxloyJZnr0wTpTO9pi9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOe0LLqAKxgFcdXFsTuAEapsSSNlfVWvh/SCE6Ztv5k=;
 b=DM+UcmJVNplv5aqUPd0OLlUft2mlaK3PTtC+wa+EEjXVEATujjI46WYgZ7xycAIT9XdfAbl0sPhY/fOBMU/ZXo+PoR888gXFO6eDOAEWypl2zNcWhd/ni4R4Mk1B+5RVUlDzN5Ou/Kau0m+Iw1XSj+1DUi9aZkopDUw4fSJDgSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 20:27:06 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 20:27:06 +0000
Message-ID: <2ac6c9db-ea01-4598-ba4b-e264d973633a@amd.com>
Date: Fri, 3 Oct 2025 16:27:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/amdkfd: svm unmap use page aligned address
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: harish.kasiviswanathan@amd.com, Xiaogang.Chen@amd.com
References: <20251003181518.24270-1-Philip.Yang@amd.com>
 <20251003181518.24270-2-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20251003181518.24270-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d396c80-95ee-466c-29e9-08de02bb3821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWJJOXdUdHpEdEt6YXlqWlhSemFiNTliVExoQk9mc2NWSTBEa0VtNlJqSXR3?=
 =?utf-8?B?SkV4K09TRFl4OEhMU2d6Yzg4NnBDdHZaUnFXNTc4OHVtdzFObURCc3A4MGxK?=
 =?utf-8?B?MUk4TnRoenJsRC9HWG5wZXdDLytQbHFhZEtJYksvUmxkMTlIcUFUMWV1SGlj?=
 =?utf-8?B?T0JzVHUzWXhmKzlMTko1RFZRNy9mNko0djFXUTQ1eXZBdHNhT29TNUo0d0JC?=
 =?utf-8?B?dktuNEpIaEw4bStqNXltbk90VFpZQ3YxWlRwa1RWWklXbS9SVmxuaEpTNXZS?=
 =?utf-8?B?WWpHVDFKTjhOQkd3VnJsRzcrWURRY01ObmtiMlF3aWVVUDJFaVpuWTArS0xD?=
 =?utf-8?B?Vk9VR1prRkFGcnl5VEcvZGxOQ1dYbnV4bDMzMDkyZDVIN205eVcxT3BvNUpi?=
 =?utf-8?B?SUk4b0RVaWlwNFRmeVVXL0wyeDZ2TWs4M3FsWjBzazhhdnpQSlF6WXdlWWQ0?=
 =?utf-8?B?bVNsUFhHQnFYN0VtNTVUN3UzQUhpcThiVzhBQS94N0dZbWJMamJyMTlrRzA2?=
 =?utf-8?B?QU9WOWIxaUpvTTI5V2ljRmx4ZUlPZUkrMUQydENHZmUrRWlPMy8xZ2ZYT2Rs?=
 =?utf-8?B?eWdVVXFVZ3JDSEJNdkNJOVFvUldOUHp6NlFhTWI4bmo2RUlMcTFEWSt3SU8y?=
 =?utf-8?B?TU5HTFpCMzc0WFg0VDJ6QzltNUlzZ0ZMVTVzSkNaUUZybDNNUThrRHlOOFVy?=
 =?utf-8?B?ZE9kZURScWdZNG1KeVJHMzh5TStGaU5Jc3ZiTjdNZmc5UjZYNDM2VWs0OU5n?=
 =?utf-8?B?NmVHL0Y5cCs3TG5zeFQzQ2RMVFBLcGljbTF3bXVsRmlKL2oyTUE0VU1pNmgz?=
 =?utf-8?B?OFU1ZzhJa3hJdFFrYWxNZFgySnNrZzRkTEdNNzRwMHpORTJLSmNnSHd6YXVz?=
 =?utf-8?B?TWIxUUw1Z01FVmZBS2tIUU9DSnVmTkRmY2QzVlNHcmxsNW9PcmxyQ0xwbVFt?=
 =?utf-8?B?eTBmU2FEQXNMeTMweVcwZUUwT0tyNlJOdmJvakdzRnBlQUNYREg3WSswbkU4?=
 =?utf-8?B?QjB0KzBmZFhxTCswT2xrNUE3VnMxSStSUVYwTUJGUHk0U3Z2RVRmekZTbmp2?=
 =?utf-8?B?b2VUaUlPRDUySXdLb3pJQjFYenpyME1tdmh3Um1HN2g0NEJGNlNyQnovTGFH?=
 =?utf-8?B?NXM3SnBxM1VobEQreTJPWTF6eE1GOE5yWWNST2tYNm9xZ1B0UHNPKzZ2Rmw1?=
 =?utf-8?B?L0pmQVYzcU9EQ04xaFBkMExnRCtCVTdobW8rQU1EWllLbG9rekhWbDJQRU8y?=
 =?utf-8?B?RzhhYVlEampjSkZJdnZUV0xOSkUrbWZuL1hxZkZjSlJYKzUzZWgzWnRvbW9u?=
 =?utf-8?B?UnBGQ2c1VnZSTHBXU1RxWjMyU2Vpbm9vMUhSY3JpT1NQclBNY1l1REQvS3Av?=
 =?utf-8?B?Slc0QVR4TFJxZTlOakJRMzR5dWk2N3Q2WXhoVFhGajU2SDRDYkQvVUVwTFdK?=
 =?utf-8?B?Q1BtbThBTGRqUHgvVWVxNmNSek1DZ2E0TVlHYmpBVGM4cjhRUE9HalNseG92?=
 =?utf-8?B?UDc2ZDZBaUN5N00vb2Uyd1dmb3o1YnZma09kWlhrZW94SExxeUU3dFhOYk9t?=
 =?utf-8?B?N2RjU3pLYzJBTG5GRHZkTGw5VHdQcFlvcmRjQUdDM0R3aWI5YytmN2cwRG54?=
 =?utf-8?B?OWhtb2V4UXFrVUF0RFB3Wms0Qm5OWGxRRGxCNjdCNy9YZW01QlRzWmN1T3hr?=
 =?utf-8?B?ZkRVWXU4OFRpV1J6Tm9pOXJzRFExUEhpcjArbXVWNWM2UW1CQm4wOVUvNHhE?=
 =?utf-8?B?eW5ldWpiSDdJVFRKN2swRG9QRHdBWmpPblY4Qk9DQXMxYk9FOXBxTVAraXBI?=
 =?utf-8?B?eGUvY3FCNHVzay9LV0JGam51Vi9pUklJQlRSWmpyUUFUL3VsbGlnbFpmN2hI?=
 =?utf-8?B?OWE2bVpaZi9ydEJ0NmtVRmhZQkxjN3U4dXBJRHJsdVl4K2RaaEt2RWZFZy9W?=
 =?utf-8?Q?oZnQXe5xsk+623LG2s6J+eyvFgBt+n+K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2RSRjlrZitwN24vbnBoR1Bzcmp3T2pCSkhRVFU0T0hGbjUrRjV2ZTZoNHNF?=
 =?utf-8?B?YVBEWGo3Mm8yVWRKSW4vTWlZMTBpZDNxaTJoTW8vWUJzeHRpb1RzSHFNUnQy?=
 =?utf-8?B?a1JDdkJ0SVdUa3g0TkNCM1VCenlncENLSGZzdWRjelNRQ1ZyS0YwbWhHa1RX?=
 =?utf-8?B?b3NPTk53aW5SdEczc3JZeERkK2pEUjk5VXgvRlpIMHIzWnNxMDdSOVJxeTIv?=
 =?utf-8?B?Y25nM0UrcGFIcWUvYlFyRjdGdU1WVFI2ZTUwSFVWZGhCbVZVbnI1amlXTnFH?=
 =?utf-8?B?c1g5ekJoSm14eXZkcEczYm82UmJaVjJDR0tFR0FmbFRzVE9aRzRmQzgzblVr?=
 =?utf-8?B?Y2k3ak1Gc29aKytYUU9GNXhtTUNlV0V1Z1RPa0trUGdPalNVNjIycWwrZnNl?=
 =?utf-8?B?OE9oRFh4S016MCt5dm56enBNUUNlV1BkRzRvVnUrbnpTQ3pvbVFSNmExcmJL?=
 =?utf-8?B?ZDdxSzN3S0YxeGpPY0YwYmNFbFVjckpIQmVqS3RIVnNFWkhXNWhKS0NNbVBp?=
 =?utf-8?B?OUNTKytzclc0WEFOTUVaTTFySWZ0dzZqNnZsOXYyengycUZIYjBGb0lGaXZY?=
 =?utf-8?B?VmMvaXRSVGpNNCttd21DVVJMZllFNDhGMkVxalUxUDFnVGV4VitJL2dKeS9v?=
 =?utf-8?B?UStmcVZYSUtibW9oQVc5cXMyanRjdzNxdXhsUGxleDJFdHl5aHhXL1laNGtt?=
 =?utf-8?B?TWV2bW9laGk5d1IwWEg5Zm1CT0U0Q25kaDVMM0xsUGVqMElFSzhpMi9XVGRr?=
 =?utf-8?B?SXQ3MkVIUkNuUlM5YWtiRTFhdGdXeWFuZGFXb1l0UXpmbVNPcUlpd3RSRnR4?=
 =?utf-8?B?eFNkek85akw1R1Z0c2xwMHg2bXpkemVPSU15cFJUaEtGMVg0dlF2Z1hTcFgy?=
 =?utf-8?B?UGFSVy9samg1dTdpU3NwcWlmODFKY0dxT25NS2lPYkpCOUxGT0RMSWJnUWls?=
 =?utf-8?B?ZFdpL0t6UWNKTnhOdmh1SG5mZnNzTmUxWFFjbUNPNHJ0NUJlL0VsUy80MWpa?=
 =?utf-8?B?akJibEFBdWVKcDR5MEpZdkJycHVDckorQnVpMmlPNXNZSHNuTjVFTC9TeGpP?=
 =?utf-8?B?emxpVWR6aVl2TkVPYkN6eVZ4UWpKTWpIR0dVbTg4a3BucnVVMllXc1Q2cDIw?=
 =?utf-8?B?M1VoZi9oU0h2azlHcHQwSHg3RTBFTlNNWnl0MnZvZzlvcWkwMThrZ0hLem81?=
 =?utf-8?B?eDFlWTdEZUdoempWNHEvMGkycDJPaS9uaU5naE5acENHdjhpS0dSSzRJYjh4?=
 =?utf-8?B?Zm1FNmF1MHpXaUJqeklGTnJMTTE3R0hjeHlveWovOTBRYk90QjcyUW5wSkJs?=
 =?utf-8?B?SjZWWTZGbkphT3BjVG4rSFJ5clJjalpoM3crcGRIbHlKZTBEZWQ5WmE4Z1ZB?=
 =?utf-8?B?Z29LbnF0cFBFQVFhL2s0VjdMaVpCZVVudVRPbHlURFVPQ3NlNVBvSmthTkdw?=
 =?utf-8?B?dG1xNXhMTUZ0SllMUWQxeXNYSC9jUDAzbldtNjhIWmFuK05RaFB5QjF1eXhT?=
 =?utf-8?B?aVlqTTZKOTJLOEtpbHYzWmdQZjhac2xRVklnNklUZDJuNzRZRFZzbGRIZG1t?=
 =?utf-8?B?T3ZYWGVZRUgveGp2cU5vNzRyZXhGQzBrbmQwWmJWanVxangrejNEL0RTNklS?=
 =?utf-8?B?OVJRajdzUEQzWDZRWTIzVjViSVg0QnE1bmNvT28rQ0xyMlJ1WG5JYzRSREpq?=
 =?utf-8?B?SmM5UGd2Tk1udmlRcTlDWmdSb3M1YzY0ZzZjSXBESkVLV1NET2lsaHVEbVQ1?=
 =?utf-8?B?QzlYang5dTUzQU9IOWh6MXR3K1E5eTJYZ29JaHFwRjFZK1QzMUhJcFpKT2F0?=
 =?utf-8?B?S0lwbDNJM2N6aTBmbHdpTHNPaUIxajVQKzhUSTlQd2FkZVRyakR3RmUvZzI0?=
 =?utf-8?B?R1hIdDlTLzRPOWhwekIwWHVaeWcrdVk1b0o4UkxhYkdFRGJsSWdwQmdxWWRH?=
 =?utf-8?B?WmV0WFRwamkyZnlweXFJaXI0dms0Q2VTalFjU2ZKeFFIbDB2dEFYMk42bzFa?=
 =?utf-8?B?L3p3ajdFengwaDNXam9hYlJZNnBZdllWS0JMbWl6OUxiZWJEdmxqdk5uTmRy?=
 =?utf-8?B?MStCeWR1YjJ6eTBmUDNwelljM1M4TkNmYUpXY0VDVExIS3R3anUzKzBmRmpG?=
 =?utf-8?Q?mytUqfJXxNJ2pNsjcWBEXvsjM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d396c80-95ee-466c-29e9-08de02bb3821
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:27:05.9107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dx68p/xr7sKa0xoy+jIr3qh3xaXOmdSXvqKWRrtoItmDnmgmrSz2B/av7IffdyctY6aHBiSDxpl7wtdSDsiKjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962
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

On 2025-10-03 14:15, Philip Yang wrote:
> svm_range_unmap_from_gpus uses page aligned start, end address, the end
> address is inclusive.
>
> Fixes: 38c55f6719f7 ("drm/amdkfd: Handle lack of READ permissions in SVM mapping")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index e8a15751c125..0aadd20be56a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1723,10 +1723,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   				svm_range_lock(prange);
>   				if (vma->vm_flags & VM_WRITE)
>   					pr_debug("VM_WRITE without VM_READ is not supported");
> -				s = max(start, prange->start);
> -				e = min(end, prange->last);
> -				if (e >= s)
> -					r = svm_range_unmap_from_gpus(prange, s, e,
> +				s = max(addr >> PAGE_SHIFT, prange->start);
> +				e = s + npages - 1;

This is confusing. The old code was clamping prange->start/last with 
start/end. start/end are based on map_start/map_end. Your updated code 
uses npages, which comes from the VMA, which may not start at the same 
address as the prange or the map_start. So I think just using npages 
here is incorrect.

You also completely removed the condition that s >= e. I think that's 
OK, since all callers make sure that map_start/map_end fall inside 
prange->start/last.

What are you actually trying to unmap here? Do you want to unmap the 
entire prange, the part of prange inside map_start..map_end, or the part 
of prange that overlaps with the VMA, or something else?

Regards,
   Felix


> +				r = svm_range_unmap_from_gpus(prange, s, e,
>   						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
>   				svm_range_unlock(prange);
>   				/* If unmap returns non-zero, we'll bail on the next for loop
