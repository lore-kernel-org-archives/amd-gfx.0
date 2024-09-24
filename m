Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F94CF9C69
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 17:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DBFD10E0CE;
	Tue, 24 Sep 2024 17:47:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NOVQV74s";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B839A10E0CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 17:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHFgghNFcNX/jqgwPgsiepH9NUaxB7NOxa/yWkeypV0aCZrM0DHCvnNqzbx53Bw+BbalXlLhZn06r4nyYFzSRJBDfLs7euPdpddh7sSyYbTj+pvB7Weh1yG1MiBIF89GsOc4HoilTKtCiU19RwmExlxAdg4rljStxEsdug6PYIccUgeb0w+jmR2Lh1xBAK6gPAL1ywM+8AgdpCAXU09mx+yTo8uLg1Z7cFp2aYD73qY569MA3bZ8UusfRLs8aufpzeStg52sxcc/1c/X5sxDppCp03ii0sM0QuMO3kdd5sMpO963P+GkQUoEKGyAOajIryhW6rVjp81IeOAWWMAwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vm8ZBt8MSxIbDGPLtgRjWKKVzI+KTADnQ2YxdxuY7sI=;
 b=yeO6dttydHy5mH2xB5ToS4t6zDfUwvoYshe00xK4cKuIfGTMBrJMw5zInxuhlINp3PokCKett56QRuVepIAEuIVJ9g/+niolgEjnt2frD4PoWHtBYvQHN0a+3Efwelqh3k8psJnXvUaN5P3/7XAssEQjFUT2JTu3eVAwqW6KniD/lxTBLMA7q1GycYrCn0fMaim1DUjDI22NjuHZN9klYdWHxe9QalIFDtlzJRXN0edBFlKndzKUqFDMGTyqQhNuwcb0nQ9JeNLKkujvD3QzUQk6XVzE9mfwyUGNoEd5KvT0huRyvIr8Hjck71Su93cDqIti48Ikl55g6qyB/hNGGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm8ZBt8MSxIbDGPLtgRjWKKVzI+KTADnQ2YxdxuY7sI=;
 b=NOVQV74sKKz+E9kGwVdOOVZ6gMUlOrpJMgkvcLTKdE0P5qV0XZU9pGzNfRDwLUF8ucSDXbcJFr/acWP+vjoc1uPBEiq+l8+WbrmiQSYb9uOxdu+I19dHdftKcypJp2oGYR0D5d2MXKJTaw6aJ0Xy3xxC7qr3PahqefjtlN5qAlc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.26; Tue, 24 Sep 2024 17:47:35 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::6f01:2f45:71e4:653d]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::6f01:2f45:71e4:653d%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 17:47:35 +0000
Message-ID: <e6253bfc-f2ac-4531-a24c-e8d71319c75a@amd.com>
Date: Tue, 24 Sep 2024 13:47:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/amdgpu: Add option to refresh NPS data
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Ramesh.Errabolu@amd.com
References: <20240924055652.2678433-1-lijo.lazar@amd.com>
 <20240924055652.2678433-2-lijo.lazar@amd.com>
Content-Language: en-US
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <20240924055652.2678433-2-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0004.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::17) To DS7PR12MB5933.namprd12.prod.outlook.com
 (2603:10b6:8:7c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5933:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eba3aa9-8477-452a-0250-08dcdcc0f95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVZQY0Rrc3RmeXdRLzkra0lLMGQ2bjJ6bXJueng5ZGdiVUhwRjBEWVRrNkd6?=
 =?utf-8?B?N1hrUVFiWnZlRm9HUTBaanV3UFFvemdmS0lhQjFqU1RPazM5UDFid01xUTF4?=
 =?utf-8?B?bkVuTnFqNGQ5bVA1bGRVUWdiYXhlMUx1TFBoS0FBMzluMGFJQ3JhaVFrY0sw?=
 =?utf-8?B?VkdtMndSNTFBTFFmRUttUHdYd1JDTUNnYTYwQm5GM2I4SWlDR25udTRHLzF2?=
 =?utf-8?B?OXo5SGVlNG1JeHhmTHRldlpKZmZEdG1xVlc1eTg5RUxibUZiY1IzWUFMU1Y4?=
 =?utf-8?B?SnA4cjY1d0M0OTgwbTUvNUJhQ01EMjU2ckN5dHZETGRGWE9CVUFlK2YwNG1o?=
 =?utf-8?B?MVNlK1crN0ZnYkkxYXBQVlIybzI0WVpab0hNdUpzbU1mS2ZOK1RyZ2tubXUw?=
 =?utf-8?B?djJMZUdvU2JtVktna2RRQzBTUStDR0NVM3VHcWtYM3gwWG1veVNUZ1c1OHhI?=
 =?utf-8?B?RmN4eEFESFB1cWp2cjFyRHlxRVRWTE1kTVphbEsyZGQzSUxmN3RuYUFpQmww?=
 =?utf-8?B?Yzk3VGlDMzNjaGhSTmJMRnZRZ1YxRnJ3cm0rV000b09xY3VESlhVMThhWmpj?=
 =?utf-8?B?SldYd3lIY0FEVUtvRkRqdWdNeitrMy9NMlBUZUVya3ZpWm5mNWpvU3JQS3VP?=
 =?utf-8?B?TU51ZWllVWNuQ1UzNjNPMVlPeFlqRDA0TUp2WDNNWnBuY3UxakhkZzNhT1Js?=
 =?utf-8?B?YTZkUktTeEtPN2Ntd0JOT3Q1YmlURzgrYm9POWpFOWZtNlVwNFRPOU9sTC9Z?=
 =?utf-8?B?N2FyS3B2TkcrMFZ0UGFzaWJ1QVgrSllTUFlnbVZRbWN0UDdVb1p4VXlMajln?=
 =?utf-8?B?ZzNhZHVjekZmSGVvWVRuMDdYYzM0d1Jwck5jalA5dmYyL2xIZHo0VjdiVlZx?=
 =?utf-8?B?ZGVzYzZld1cyc21UcXVmVW5VSytGTVVKbWt6MWJhOVhYUGF0QTZtRnFmU2Zp?=
 =?utf-8?B?R0p0VlJlUXBBcFU3dG1wUkp3YkkvYmxtMzdLTnpjUW5LNFBjaDdyV3djZmI4?=
 =?utf-8?B?VTRmOG1xU1ZOdS81QStUWXhWTkR5Z2w2ZlFiSG1icUExT1hYSTd2SjdXZ3Np?=
 =?utf-8?B?ZFhZSi8wQUw1WE1QQldRc0Q3N1ZSZWpodU9wZlNUT2ZBZm0renZ2UVNrRHNr?=
 =?utf-8?B?SU8zTFpOV1NwbUVOVjJrM245bDdoN3MvKy81bm5RTEZZNlkzUnNkZmpVVVpj?=
 =?utf-8?B?Zkxyem91M2szRGxpZ2pmeUNBaW5GWk9IbjBXUmU0RlVrcGJuN1MwUFgxMlZX?=
 =?utf-8?B?M1h4am9YOG8rY210MEhHaDRiejNQNm5LWVdPNkp1VnRXKzZpaXMwWWQxWFBv?=
 =?utf-8?B?UTZ2ZEo5eVpTS2JZR0thNE9KNVIzdzZwOXpnNUdaOE5vVEVhRVcxV1NDakRQ?=
 =?utf-8?B?NUdKcDkvY0tBQ0dKWHdyTG5DQmFpN0h6L1ArWkdUZSt0eDRub1VqTXE5eTJ0?=
 =?utf-8?B?bnNIU05iNjB3b1pYRUY0TjdldHZUM1pWZ0lqSUhxNkVGL2tYQk8wS0MrQm8w?=
 =?utf-8?B?SGJEQUxtZzVqUkhKdzZxcHFENk0vS2ExSGk0NWdKcjVqdlZ5TVFsdzRLSHQ0?=
 =?utf-8?B?YmhEdkJPU3lPYXhBS0JhRjBwM3V6UGw3T1VpMk5DWVdJYW5VcFA3OFBPUmEx?=
 =?utf-8?B?U2ZCUjlsQzlmUmRmekp0Tm9ITUl3WC9ReXNRc3J4c3pqcmgxQk5GMnRRUEJP?=
 =?utf-8?B?VHZiaVdWc0JtYXJkQURBVTZVcmpKMzgraytRcGN4VmxEOHUra3E4Y1RQQTVL?=
 =?utf-8?B?dmVlRTRWSHcwTkZVdStjbDZTbnN3Ky83SU5iMFhaQ1BuRTJzTk1rZnZTSUcy?=
 =?utf-8?B?a3pBdC9HdXcvYnJPQmJxUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE5oR2hSUVFrVCt2T0REQ09GOUFTZXdYYU5XM0ZMUDBmOEJNM1ZqdzNmUWdK?=
 =?utf-8?B?Q3dZWlY2Z1prZlVUTWxORlBiTnk0ZjNqaDkzbms4N1dIZzlSL2MzdTN2K3My?=
 =?utf-8?B?UHVVRHRjemxWbzBNWTZxdkYyMGVkMTUyVHpwR09ncGlrM3ZtZTJwZWtrbWJS?=
 =?utf-8?B?OUQwK0JmeUtuWUE1dG5sYTNBZkFJeFdsOURHWFNpQ2p6RHJ5TER5ZlNNbXlo?=
 =?utf-8?B?RGlCVStJb0tYOGJRMnZhb3NJRUtjS1JtMUFScUxzZXpEdWpSZWRHNCtVZXhX?=
 =?utf-8?B?ZFFUcUgrZFJNQXNYUEZacTNRWHdZTXlxbDh0SG9WRko4VlA0aEVtR1ZTYUpD?=
 =?utf-8?B?VVdRQUY0UDhMQlVGU0hCdG1yNG9QR1VwVFRmM1YwcG90VE1hVDJOZUd4dDRu?=
 =?utf-8?B?RnhoS0hmTDdjTnl3M0gyYXdRMDVGUlFLT1Z6YnZJczZnMGMxOGZFYUp2WUdD?=
 =?utf-8?B?ZUtrN2VVUll1aVd6aURrNzNTU2xQU0lZZjBDY21NSzRyZGFYQjRuTklSVkIx?=
 =?utf-8?B?TFRkcFprRDA2eVEzNjdVR1NqMmdlTWlFMkFaS1l1V0NFekFDVnFhUno1VDFl?=
 =?utf-8?B?eHo3Wk00aS9XcGNrdVE0bklZaXhtTDBXTjlSRzJTSGJpR0p4dzdaNEpXcXpJ?=
 =?utf-8?B?NlVudFlHc3o2SFI0dHBYWWxmSkduNzZQbXd5QUIyaE5tTFFGUE5uK2lNVnVY?=
 =?utf-8?B?c3NsRFdieGwvUzhIbmtUTG55NEp5REh3Y2xxSnVRNmFKYkFlZ2xRNUFOSmFk?=
 =?utf-8?B?eEYyd2NLeW1tVUNTeVFuZ0UvRlo1dzRub21RODh4S1JhdU9vQXNJYmxKbVVu?=
 =?utf-8?B?Mk96WFB3amZrdHYrdHgzNUhXdVhWdG9jcmZHWnoyWWYrdmpwQ3EyZ0FCaWFH?=
 =?utf-8?B?RXNaR3drajkwenAycmhDMnZzNmpnMnZySi9VeWpCK1kxMWEwUHhFVUE1RURN?=
 =?utf-8?B?dmJSRndlSWR1ejREN0ZmWGs5aExzL2dnNVI5Ui9aTjdjNnR1Y0NrN3BsczM2?=
 =?utf-8?B?eGdMZ3FQZkl0eE9CK0VheWpEa1VoSnUwY3lDUlJDU3dZbmF5Z2U5bXJnak1q?=
 =?utf-8?B?R0RtYnE0Z0RjSk54UGJQSXNrY0NyQ1Z2eXoySkowd2NUQ0g5bFV0RjJ6RlpP?=
 =?utf-8?B?MDRlUTJzQXZKV2RsSWJBQnN3M1EyR1JNZ0p6em9LYzkrQ0thTkxEM0ROcmgz?=
 =?utf-8?B?Y3o0UnNGMGU1ckp3WkxlOXczNm9lZkd4WmIyWFl5MUhoR1NVOTZPVW1Vb25O?=
 =?utf-8?B?RXd2TUhqam0xaXFzcWdPUncrMFpoa1hiUDNKaUc2M1R6L0N0Njd3Q050c1lQ?=
 =?utf-8?B?L2FERmNrZmhNU3hYcVhCUnRMb0RHYVg0dUZ0K3o2d2cvOVlMRDRGNHNjUXFU?=
 =?utf-8?B?Tmd1KzJSVDU2WkJHdmR2L2FTY2JHcnZNV2ZBQnlVNDRjZUljNFhva3JrQjVM?=
 =?utf-8?B?NmROblRNUmcxUjNlOVZKZ3F6TzVFQ1hubS9ISWEvblZCZzVMcWpYd3ZoYlRl?=
 =?utf-8?B?VkVUOU44WjlJcEJYTzc1S1Q4Lzdna1JDRk5KSnlybUhlTkc2NjlZa1RZZ1dw?=
 =?utf-8?B?b1E1TFkvbUdpSkR5Tm51SURvRDE2Wk9NWlA2eUVTbHdjL2JEVm1aK2NSQjE4?=
 =?utf-8?B?ZHhmM2tvRnNVLzdCdnBNbFFTMTloQmpSY1ZoRG5PdW9mQkZISU1RZHBOeW03?=
 =?utf-8?B?QlYydk81dzF4NDZJWk5WZWRuV1FHVkFLZ0pyYWN2bk13ZHVrcjJLKzhHQ1hK?=
 =?utf-8?B?MWovcEswcEo0TDZIcVU1NW8ranZueU5qU2VPTjBHTTZ2d09DZUZsRlZORVd3?=
 =?utf-8?B?a0xZZmhZbU1udlQvREpQMW5ldzUvSkFrUXNyNUFpY1c0dnFLck5EeGI2cGEw?=
 =?utf-8?B?ZUNOVktTSTgrYmRLMXBYUUFBR2xWMHZ3SHN0bVIwcHMydlVjNTVnMWRESDVk?=
 =?utf-8?B?V3lpRlFMWnBDcXFIeW5oNEpqUG10aGUyQTN4cnl2YUtvWklpcnVFOGxwaURU?=
 =?utf-8?B?RlNqMG0rSXpybEQ2UmVpSTN0Q25ZbUFOUnFKQkIzblI3eVVlOUFmYit6QjRr?=
 =?utf-8?B?THRTSnZkcnl4Yk5KRHJGeVEzdm1EUDNSNURwOWkyWldNV1p6THhJUXJNOHk2?=
 =?utf-8?Q?gLl4nfRavunVui00uTC2cafqK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eba3aa9-8477-452a-0250-08dcdcc0f95b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 17:47:35.6803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xc1qi5N5dYJDQSiEb4RNWYxYCYe8FCvQdxRDHJl3yP7FY1Fko+3HwVaP0UvDCRcHFECwhIFKbpANa0QlkiPOmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898
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

Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

On 9/24/2024 1:56 AM, Lijo Lazar wrote:
> In certain use cases, NPS data needs to be refreshed again from
> discovery table. Add API parameter to refresh NPS data from discovery
> table.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 68 +++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  2 +-
>   3 files changed, 55 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 4bd61c169ca8..9f9a1867da72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1723,37 +1723,75 @@ union nps_info {
>   	struct nps_info_v1_0 v1;
>   };
>   
> +static int amdgpu_discovery_refresh_nps_info(struct amdgpu_device *adev,
> +					     union nps_info *nps_data)
> +{
> +	uint64_t vram_size, pos, offset;
> +	struct nps_info_header *nhdr;
> +	struct binary_header bhdr;
> +	uint16_t checksum;
> +
> +	vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
> +	pos = vram_size - DISCOVERY_TMR_OFFSET;
> +	amdgpu_device_vram_access(adev, pos, &bhdr, sizeof(bhdr), false);
> +
> +	offset = le16_to_cpu(bhdr.table_list[NPS_INFO].offset);
> +	checksum = le16_to_cpu(bhdr.table_list[NPS_INFO].checksum);
> +
> +	amdgpu_device_vram_access(adev, (pos + offset), nps_data,
> +				  sizeof(*nps_data), false);
> +
> +	nhdr = (struct nps_info_header *)(nps_data);
> +	if (!amdgpu_discovery_verify_checksum((uint8_t *)nps_data,
> +					      le32_to_cpu(nhdr->size_bytes),
> +					      checksum)) {
> +		dev_err(adev->dev, "nps data refresh, checksum mismatch\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
>   				  uint32_t *nps_type,
>   				  struct amdgpu_gmc_memrange **ranges,
> -				  int *range_cnt)
> +				  int *range_cnt, bool refresh)
>   {
>   	struct amdgpu_gmc_memrange *mem_ranges;
>   	struct binary_header *bhdr;
>   	union nps_info *nps_info;
> +	union nps_info nps_data;
>   	u16 offset;
> -	int i;
> +	int i, r;
>   
>   	if (!nps_type || !range_cnt || !ranges)
>   		return -EINVAL;
>   
> -	if (!adev->mman.discovery_bin) {
> -		dev_err(adev->dev,
> -			"fetch mem range failed, ip discovery uninitialized\n");
> -		return -EINVAL;
> -	}
> +	if (refresh) {
> +		r = amdgpu_discovery_refresh_nps_info(adev, &nps_data);
> +		if (r)
> +			return r;
> +		nps_info = &nps_data;
> +	} else {
> +		if (!adev->mman.discovery_bin) {
> +			dev_err(adev->dev,
> +				"fetch mem range failed, ip discovery uninitialized\n");
> +			return -EINVAL;
> +		}
>   
> -	bhdr = (struct binary_header *)adev->mman.discovery_bin;
> -	offset = le16_to_cpu(bhdr->table_list[NPS_INFO].offset);
> +		bhdr = (struct binary_header *)adev->mman.discovery_bin;
> +		offset = le16_to_cpu(bhdr->table_list[NPS_INFO].offset);
>   
> -	if (!offset)
> -		return -ENOENT;
> +		if (!offset)
> +			return -ENOENT;
>   
> -	/* If verification fails, return as if NPS table doesn't exist */
> -	if (amdgpu_discovery_verify_npsinfo(adev, bhdr))
> -		return -ENOENT;
> +		/* If verification fails, return as if NPS table doesn't exist */
> +		if (amdgpu_discovery_verify_npsinfo(adev, bhdr))
> +			return -ENOENT;
>   
> -	nps_info = (union nps_info *)(adev->mman.discovery_bin + offset);
> +		nps_info =
> +			(union nps_info *)(adev->mman.discovery_bin + offset);
> +	}
>   
>   	switch (le16_to_cpu(nps_info->v1.header.version_major)) {
>   	case 1:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> index f5d36525ec3e..b44d56465c5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> @@ -33,6 +33,6 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
>   int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
>   				  uint32_t *nps_type,
>   				  struct amdgpu_gmc_memrange **ranges,
> -				  int *range_cnt);
> +				  int *range_cnt, bool refresh);
>   
>   #endif /* __AMDGPU_DISCOVERY__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 17a19d49d30a..4f088a5368d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1184,7 +1184,7 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
>   		return -EINVAL;
>   
>   	ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
> -					    &range_cnt);
> +					    &range_cnt, false);
>   
>   	if (ret)
>   		return ret;
