Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99816C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 20:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33B9C10EA86;
	Thu,  6 Mar 2025 20:45:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XfN+7Viq";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CAAC10EA58
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 20:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/f88Gp9oTcvm2HNg8i+JpuMhp/CWjCgH998AwZvZaOG1d+JjBNSMaoNNCtzCrBqJFEH+WH/cuwy9PJl/qXdLvsAfUZg8KrUFB9B6aA2Wv2OozduJjQd9Fj0uzRCB3gGcNJsKV7DnC0VqhWKXFcjX9BI6/2fOcVpMzTyVNu1v2641MuoSSuekpW9GCg4FWBsIntxuX7CZysaPRbUh8fmL7j0+ZkMC1GGK3YzpzUPE0RQwNQFifKdQ7eG8URhECbmoWK5xy+hP8wJeqQnMmv+0zgN7HpTBp5b0K82M2yqSBebTam76nTq5o/zSuibLl9WPNtT3Z/dsEFRyd+dcoEKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Sp5Jrc7DlPN0LgDq6t6a9W637AFR9+MJU45k39ddmE=;
 b=I8gQB15y4iSkup3uPV0KgSABQrPNxY97hvXpw+EbQSub0phzflLRZDTVobb/4aeqI1eaDwkjw6xswHmHe1uzIVDotQh5nXBGtNX8lo+P+JCLmWAj4H41EEmV7+UN7STCveIangVXuW4wTo6cyfE5C4kdRNR2Wsx9mMnKp05+L2g568x1F9xKfnXmNi6a0rLSLEtrsAaJsK/EWZ8XcgQTgRfTA4jUFzM3AEfmZJG+AlBcHwvGBnCw3/McZDi0lEwjoKnez+fOy53fwB9huwUro0Z1dcGmRueftIREB6H69EbXp+NMjhv5p136FeyiZNPgX8thZQ7zYNuIC8rqlLf7hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Sp5Jrc7DlPN0LgDq6t6a9W637AFR9+MJU45k39ddmE=;
 b=XfN+7ViqDqSmHhdzyp8WtPwWsmKpreaQv9NLTwEw5OLnPExEFZApC/ulVurP8MOoiK9bb3CRCDO4IRc9kUj41v4e16LGptH/89UelRktnN+OgP+IFo0cvTdYEonh4gpxW+gALSihnHBj2t4fLxydS1qzxBNEuN1qtqnrxS/8umg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 20:45:16 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::39f9:c340:9b03:c651]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::39f9:c340:9b03:c651%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 20:45:16 +0000
Message-ID: <b0a5b04a-ca3d-4574-9cbd-4ba468326c9d@amd.com>
Date: Thu, 6 Mar 2025 15:45:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] drm/amdkfd: Set per-process flags only once for
 gfx9/10/11/12
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250306195227.32765-1-Harish.Kasiviswanathan@amd.com>
 <20250306195227.32765-2-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <20250306195227.32765-2-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0385.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::24) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da5d821-86ae-4948-54c5-08dd5cefcd0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTNhQVdTMkppWVQ1akNvWFFHd1ljaEkwdUpxWmNMbGJDVmdBc3RMYm9PZXlD?=
 =?utf-8?B?czRQWTVjSDdtSzBHakkzVWlpWXlXRlNKVHN3blk3UjA5eUNHNmpzN3VLc1cz?=
 =?utf-8?B?c1dzZ1VkT3lrczZYRXhpNGR3aWFnWS9ESUpZMnZqSEIxQjdHYjZFZkFsM20r?=
 =?utf-8?B?eU0vUEV4MW1DVVRlSlo1Ny9UVHRzTmw1YVh4Q0FJVHJ4REtBdzQ5cTBKZGtD?=
 =?utf-8?B?dkpWL0xiWUpwL0s1b3QxOTNuOVNKT0huQ3phbmhFZHNUR0RmTmpoU1Z3cUpI?=
 =?utf-8?B?eHlscjJyZ2hRUHE3b2JZYmRyVDdLRTRjcW9xMXorajRuNFhUODQ2NzVUeXY3?=
 =?utf-8?B?Y0c5VFcxRWx6Q0xDc3E4S2dOTnNVYmc0TlhCZlZQQlNEMXZtQlVodE5YdlpR?=
 =?utf-8?B?bHZuUEJ2SVJobkZZaHdqQzdKWnpabkRDYU5KWGU4UHJxZVN5QlNLZTNmTEV0?=
 =?utf-8?B?T3VLWTJCZGF0cnZIcCt2M3A1RnRRZ2F2Q2FvN2JKZ3RhNXVFdXRzb1NQRlFz?=
 =?utf-8?B?QjNrWnlCcFVNQzI3aWgzU21JTzZTYSthU1NpNHE3cEM3ME04b2VaanFYSWNJ?=
 =?utf-8?B?MytCOTZwR3hkN2xjdWhqeFc0bVNIS01yWEtnd1ZXUU0vR25RV2lqMUFnSFla?=
 =?utf-8?B?OFBuNjk5dFN3enRQSzI2ME4xVTl2amNmTkkyT1NxZW1xQjM4dlZnMHFBcUNL?=
 =?utf-8?B?TVNnZ2psMWNHVTZaUE1sTE40eVpzN291aUVicm45TTR2NUxzaW4reUFxN0Jo?=
 =?utf-8?B?SUc2ckNPQ0VmenFCQjZ5UWNQb3NHVDRDK3I0R254TVRBclV4Ykg4dkZrZjBy?=
 =?utf-8?B?V3NTNVlCV3VEcmFCaDRYYkR2aTM5NEplZW0yZlZpbm9CRjBXVGJSdERJdkli?=
 =?utf-8?B?b3RFU3lOM1FrT0I1SFVpVjBxNEJYTEZ3cXRwVjQ2bjQ3TXBoY0lQU0ZOUVBq?=
 =?utf-8?B?dzkyL281K2tidFNNemtZajR5bHMvTUlCWUdkeTRGUk5teVgyVXNodEtpck1o?=
 =?utf-8?B?UGlCL2tDMlhMTGR4NEJZR1BYWmNwR0dDcSt6ejdFODBXd3M4Q0dmZW1QaTFu?=
 =?utf-8?B?WlNCZUZPeGRlNE5yM0MzbUFZM3QzYWIraTJaMWRXWDd5bHJYb3BlZ1pqSXpx?=
 =?utf-8?B?RWFGTFhNN0tsNnd0SjRKejNCTXRVQzNlUU9JMCtWRGNkQ3BiVFg3ZHB0aWxp?=
 =?utf-8?B?VEZJT0hvOURTU3VoR2g2OUFCZ2pWNm9TZmJnZ2FodExyRXprSDFkUERrYjdP?=
 =?utf-8?B?cXJEdUl0Nml0NHJobUFKdHlnWmJ2clVYUUwvSjkzaDhrZ0hyMnhNWEFweVFn?=
 =?utf-8?B?UnZBZ1dMRUh3VTZQNktvUkVneTB5NHZGSmFsaCtvL0tPOHdYbGhDR1kxeSt3?=
 =?utf-8?B?VHhqeEUrNGFoVTVkSlZNRnVWUWN2dm1OTU9FdnRrOEhlaWMzS0phT3owVldj?=
 =?utf-8?B?K2VmaUlVTHpmd1RieUZYVTBiUW1Md0QyWmhXa1lndmM5aE5hSllCSlRQS0Vv?=
 =?utf-8?B?cDNVaVlwUE9lTzRrY0QwZ0x1TGZZUVJ6cVYzbEJSZFdKcmhBZ1hKQ3JoYUpV?=
 =?utf-8?B?QTNEQ2FNWHh1YkwzelFEbEZsQk9aYlZxU0NGQ0U3UkdKbWpGNVJhc09rbGMy?=
 =?utf-8?B?RkZJTmltRkhGSXhxZnREenBmdWZ2WjUwazJQdC9lZmhzV3E3UkpINStGVzZ3?=
 =?utf-8?B?T2w2UTRZTHVFa1JOQWt0aWJxTUxPa1VoV2VKdFVjSlJKdG55dXo3NDNHY1Bt?=
 =?utf-8?B?THVueXZOK1dZUVdLV2hkWFpoSEIxMWlwUC94QUJ2d2VZRFJpOGNHVG5BY2VT?=
 =?utf-8?B?VHgrSFJQbXU0RjJNellmYnZHSUVsTUc4aU50Zm9TNDFoZi9BN21ZSjlyWkZp?=
 =?utf-8?Q?G3JTZi5nTLLkL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGNRTCsvZXVPeUEzelNHVWc2NHN3S2c0dCt3dHc2cTJ3ZmtOSUQ0a0FnVFF0?=
 =?utf-8?B?OFN3REJRSWRsa29YeFBGbS9FQk9BcjRoRTBBTXVLTHdIRzZpejcvUm1KT2Jn?=
 =?utf-8?B?dmtaSVpDRndsb1M0ZThjNytRbHVBK0hKV2RMN1RqQUJFRnhyWmRJa3hhU25G?=
 =?utf-8?B?b2J3bGw3d2cyaGY3RWJKVE1SOC9ZZUtUWVBjV0lYcERLMHk3SzI2QVpSbFp2?=
 =?utf-8?B?Yy9PR21xRkE2cXFuK3ZUaWpPMGxXbWJRekxtdE1Ob2xNdW83SHIrbWF6VGF2?=
 =?utf-8?B?b0JQNVQza0thMmpYV0NIaWlLZDJHV1BubG1YeGlLM1lMaUpnME9tVGJkd1VC?=
 =?utf-8?B?cERla01uakpvanByQW16eUVHWFRtTnhaQVJEZ0pkdGFUeG8vVW9DK3BJeDVW?=
 =?utf-8?B?S1ZhSzhkcGNsR0IyalcrRUI0d3dKTlc4M250Mm5seDNvK2FDRDVnQUFOMzBV?=
 =?utf-8?B?RERZMlQvZjZTa1NJcm92akN3UHBGdEZNc0lsTVdkVERFTlpVSldmTmZlQU9U?=
 =?utf-8?B?U2gvdWFaS2t0UWswR1JxcDM2M252MlpRb21oSGVwTzAzbVZBLytkbHI1QWF2?=
 =?utf-8?B?eHE5RE9QVm5rVkdZTHh1TDZjQ3F0V1lxNlVaVE04eWNQSzVDTUdtdFFWTm5Q?=
 =?utf-8?B?MTFET3JLNE1NWk1KY25YUUpRVGt5RGZWMVhBYU9XZGlGNWJzd3RZdjdydm5K?=
 =?utf-8?B?NHJrMUFxK1loNzVFWjJ1TlRaOG5hWVI1b1BmSm8xNFdvaTRScWFFbDEyZlps?=
 =?utf-8?B?bEIwZWxjSzJVbzF0dmRQT2RCaDBYczl0ZThvd0dNbUJ1c2dZNWtTdlJPak4v?=
 =?utf-8?B?aThJVDBpY3BiNEFNK3BjYXJlV2ptT3pjdE1OdXJyTi9Ic1BQbVNtZXpPb3ZL?=
 =?utf-8?B?R3gwaXUyNGtUaC9BYWJMemxGQnVQdk5DZFJXSFpIZkFPOU42d216SkZhQlFu?=
 =?utf-8?B?WjdkSTNwR1hkZjg5cWkxQldlZjNSWmo5TGhWVEJEMFRZanRoKzRjV1ZoNXhH?=
 =?utf-8?B?cS9HTElRSzY0UzlnQ2ZxQndvTklMTnhkUDVKbEozWkxRK3JBN3FCUS90RXZP?=
 =?utf-8?B?Mm5vSjVsR2NFeElIa0xSTXIrOTMrMURQYUc3U1JQbjZScHkzaXRsTDhTdGhC?=
 =?utf-8?B?czNKZ3BoRWVJaExvMER1ZHZBb1Njd2Z2QXdJc0JtdE1ML01EMml0TGw0Mk9O?=
 =?utf-8?B?ZGgzZUN1dkVrMG5GTXVUZndlYTNqUGVkeEU1elZuaDIvQU55cEh5TW92ZGpW?=
 =?utf-8?B?ZTExQ3BtOW9DWFlQZzdwMGUxM2hTajMzTGFwN0ZvZm85SVBTTWZHK3dWMkpa?=
 =?utf-8?B?K04zREFjNzdSYVdsYUE1OGg3QkdCbUFZM2RndnVvZFBNZGFXd2dvVGVUU01H?=
 =?utf-8?B?ZzBYeUFQeUpXMnRRK3FDR09SMGVJak9oTTh6NysyVnh5RXJsZlFmTXF3bUpJ?=
 =?utf-8?B?RmpuVUM0dVNFbjMwU0o3SFJ2T2ViNHFlZTdhZlFPNVN2Z2tNWEk2aXVvN0VF?=
 =?utf-8?B?Y0o1SFU3ZzhrWkowSG5PUEhOa1BQTUYwaHVrajY3RnhMY09ZSEExK1VqamFz?=
 =?utf-8?B?a0ZwakNkVXd6WklzcGk5dlZ5TWh5K2VEdlFCZS91cCtSZWs1L0dlOGxvbmFN?=
 =?utf-8?B?WlpnRUR6RVZnNWljVWlRUWw0bFl2L0FPdlNjTkpCb3NoUElvNllpWHRDSU1p?=
 =?utf-8?B?RnBkQWlLVjdRdkV5c0Iyc3pUdFhjRlFkejZBZ01YSTV1dVl5MkVubnZoWDhk?=
 =?utf-8?B?VStqQWFjNWczSFJzVnRZRGZFQVdJZ09QMVdZNVlUeklvSi9wMVRLUVlpa21Z?=
 =?utf-8?B?TE9ickZGSkJsdlowZXZVM3ZZWXVMTVBRV0tmZEV5N1lkL2hnajcvQnd2Uk40?=
 =?utf-8?B?WjdlSmhSbzVlTis5a2FRelVneGI2VmVuM1o1RW1YOEd1ZUZsR3N1WHpMN0g3?=
 =?utf-8?B?VkxvYWdTb1Z2ZEhsb25NOVltdmJNVlpvd0dpdE1RVHN4MlFzbmhRcU96bHpW?=
 =?utf-8?B?cEtDWHhhemNxZDJ5NTRqVkZLMm82OEdsZzcrblIxekorTkxHRUY4YURQZXoz?=
 =?utf-8?B?RUJhdnNPaG9EMzJZVnM4S1psYTdrU3J2SUdka1h2TzBnVUpOVS83L1IvZ2tK?=
 =?utf-8?Q?oZpfqc6QoQpXaV+MDe3mAtLBR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da5d821-86ae-4948-54c5-08dd5cefcd0e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 20:45:16.5721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+PiKAL6Fvv/95XsGXP1RwOjENVdcXUBgjaEeLY4Y9jIr5RG2r8RgYkrgN1IsZV7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344
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

Reviewed-by: Amber Lin <Amber.Lin@amd.com>

Regards,
Amber

On 3/6/25 14:52, Harish Kasiviswanathan wrote:
> Define set_cache_memory_policy() for these asics and move all static
> changes from update_qpd() which is called each time a queue is created
> to set_cache_memory_policy() which is called once during process
> initialization
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>   .../amd/amdkfd/kfd_device_queue_manager_v10.c | 41 +++++++++++--------
>   .../amd/amdkfd/kfd_device_queue_manager_v11.c | 41 +++++++++++--------
>   .../amd/amdkfd/kfd_device_queue_manager_v12.c | 41 +++++++++++--------
>   .../amd/amdkfd/kfd_device_queue_manager_v9.c  | 36 +++++++++++++++-
>   4 files changed, 107 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
> index 245a90dfc2f6..b5f5f141353b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
> @@ -31,10 +31,17 @@ static int update_qpd_v10(struct device_queue_manager *dqm,
>   			 struct qcm_process_device *qpd);
>   static void init_sdma_vm_v10(struct device_queue_manager *dqm, struct queue *q,
>   			    struct qcm_process_device *qpd);
> +static bool set_cache_memory_policy_v10(struct device_queue_manager *dqm,
> +				   struct qcm_process_device *qpd,
> +				   enum cache_policy default_policy,
> +				   enum cache_policy alternate_policy,
> +				   void __user *alternate_aperture_base,
> +				   uint64_t alternate_aperture_size);
>   
>   void device_queue_manager_init_v10(
>   	struct device_queue_manager_asic_ops *asic_ops)
>   {
> +	asic_ops->set_cache_memory_policy = set_cache_memory_policy_v10;
>   	asic_ops->update_qpd = update_qpd_v10;
>   	asic_ops->init_sdma_vm = init_sdma_vm_v10;
>   	asic_ops->mqd_manager_init = mqd_manager_init_v10;
> @@ -49,27 +56,27 @@ static uint32_t compute_sh_mem_bases_64bit(struct kfd_process_device *pdd)
>   		private_base;
>   }
>   
> -static int update_qpd_v10(struct device_queue_manager *dqm,
> -			 struct qcm_process_device *qpd)
> +static bool set_cache_memory_policy_v10(struct device_queue_manager *dqm,
> +				   struct qcm_process_device *qpd,
> +				   enum cache_policy default_policy,
> +				   enum cache_policy alternate_policy,
> +				   void __user *alternate_aperture_base,
> +				   uint64_t alternate_aperture_size)
>   {
> -	struct kfd_process_device *pdd;
> -
> -	pdd = qpd_to_pdd(qpd);
> -
> -	/* check if sh_mem_config register already configured */
> -	if (qpd->sh_mem_config == 0) {
> -		qpd->sh_mem_config =
> -			(SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
> -				SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
> -			(3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT);
> -		qpd->sh_mem_ape1_limit = 0;
> -		qpd->sh_mem_ape1_base = 0;
> -	}
> -
> -	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
> +	qpd->sh_mem_config = (SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
> +			      SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
> +			      (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT);
> +	qpd->sh_mem_ape1_limit = 0;
> +	qpd->sh_mem_ape1_base = 0;
> +	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(qpd_to_pdd(qpd));
>   
>   	pr_debug("sh_mem_bases 0x%X\n", qpd->sh_mem_bases);
> +	return true;
> +}
>   
> +static int update_qpd_v10(struct device_queue_manager *dqm,
> +			 struct qcm_process_device *qpd)
> +{
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v11.c
> index 2e129da7acb4..f436878d0d62 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v11.c
> @@ -30,10 +30,17 @@ static int update_qpd_v11(struct device_queue_manager *dqm,
>   			 struct qcm_process_device *qpd);
>   static void init_sdma_vm_v11(struct device_queue_manager *dqm, struct queue *q,
>   			    struct qcm_process_device *qpd);
> +static bool set_cache_memory_policy_v11(struct device_queue_manager *dqm,
> +				   struct qcm_process_device *qpd,
> +				   enum cache_policy default_policy,
> +				   enum cache_policy alternate_policy,
> +				   void __user *alternate_aperture_base,
> +				   uint64_t alternate_aperture_size);
>   
>   void device_queue_manager_init_v11(
>   	struct device_queue_manager_asic_ops *asic_ops)
>   {
> +	asic_ops->set_cache_memory_policy = set_cache_memory_policy_v11;
>   	asic_ops->update_qpd = update_qpd_v11;
>   	asic_ops->init_sdma_vm = init_sdma_vm_v11;
>   	asic_ops->mqd_manager_init = mqd_manager_init_v11;
> @@ -48,28 +55,28 @@ static uint32_t compute_sh_mem_bases_64bit(struct kfd_process_device *pdd)
>   		private_base;
>   }
>   
> -static int update_qpd_v11(struct device_queue_manager *dqm,
> -			 struct qcm_process_device *qpd)
> +static bool set_cache_memory_policy_v11(struct device_queue_manager *dqm,
> +				   struct qcm_process_device *qpd,
> +				   enum cache_policy default_policy,
> +				   enum cache_policy alternate_policy,
> +				   void __user *alternate_aperture_base,
> +				   uint64_t alternate_aperture_size)
>   {
> -	struct kfd_process_device *pdd;
> -
> -	pdd = qpd_to_pdd(qpd);
> -
> -	/* check if sh_mem_config register already configured */
> -	if (qpd->sh_mem_config == 0) {
> -		qpd->sh_mem_config =
> -			(SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
> -				SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
> -			(3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT);
> -
> -		qpd->sh_mem_ape1_limit = 0;
> -		qpd->sh_mem_ape1_base = 0;
> -	}
> +	qpd->sh_mem_config = (SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
> +			      SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
> +			      (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT);
>   
> -	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
> +	qpd->sh_mem_ape1_limit = 0;
> +	qpd->sh_mem_ape1_base = 0;
> +	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(qpd_to_pdd(qpd));
>   
>   	pr_debug("sh_mem_bases 0x%X\n", qpd->sh_mem_bases);
> +	return true;
> +}
>   
> +static int update_qpd_v11(struct device_queue_manager *dqm,
> +			 struct qcm_process_device *qpd)
> +{
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12.c
> index 4f3295b29dfb..62ca1c8fcbaf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12.c
> @@ -30,10 +30,17 @@ static int update_qpd_v12(struct device_queue_manager *dqm,
>   			 struct qcm_process_device *qpd);
>   static void init_sdma_vm_v12(struct device_queue_manager *dqm, struct queue *q,
>   			    struct qcm_process_device *qpd);
> +static bool set_cache_memory_policy_v12(struct device_queue_manager *dqm,
> +				   struct qcm_process_device *qpd,
> +				   enum cache_policy default_policy,
> +				   enum cache_policy alternate_policy,
> +				   void __user *alternate_aperture_base,
> +				   uint64_t alternate_aperture_size);
>   
>   void device_queue_manager_init_v12(
>   	struct device_queue_manager_asic_ops *asic_ops)
>   {
> +	asic_ops->set_cache_memory_policy = set_cache_memory_policy_v12;
>   	asic_ops->update_qpd = update_qpd_v12;
>   	asic_ops->init_sdma_vm = init_sdma_vm_v12;
>   	asic_ops->mqd_manager_init = mqd_manager_init_v12;
> @@ -48,28 +55,28 @@ static uint32_t compute_sh_mem_bases_64bit(struct kfd_process_device *pdd)
>   		private_base;
>   }
>   
> -static int update_qpd_v12(struct device_queue_manager *dqm,
> -			 struct qcm_process_device *qpd)
> +static bool set_cache_memory_policy_v12(struct device_queue_manager *dqm,
> +				   struct qcm_process_device *qpd,
> +				   enum cache_policy default_policy,
> +				   enum cache_policy alternate_policy,
> +				   void __user *alternate_aperture_base,
> +				   uint64_t alternate_aperture_size)
>   {
> -	struct kfd_process_device *pdd;
> -
> -	pdd = qpd_to_pdd(qpd);
> -
> -	/* check if sh_mem_config register already configured */
> -	if (qpd->sh_mem_config == 0) {
> -		qpd->sh_mem_config =
> -			(SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
> -				SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
> -			(3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT);
> -
> -		qpd->sh_mem_ape1_limit = 0;
> -		qpd->sh_mem_ape1_base = 0;
> -	}
> +	qpd->sh_mem_config = (SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
> +			      SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
> +			      (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT);
>   
> -	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
> +	qpd->sh_mem_ape1_limit = 0;
> +	qpd->sh_mem_ape1_base = 0;
> +	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(qpd_to_pdd(qpd));
>   
>   	pr_debug("sh_mem_bases 0x%X\n", qpd->sh_mem_bases);
> +	return true;
> +}
>   
> +static int update_qpd_v12(struct device_queue_manager *dqm,
> +			 struct qcm_process_device *qpd)
> +{
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> index 67137e674f1d..c734eb9b505f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> @@ -30,10 +30,17 @@ static int update_qpd_v9(struct device_queue_manager *dqm,
>   			 struct qcm_process_device *qpd);
>   static void init_sdma_vm_v9(struct device_queue_manager *dqm, struct queue *q,
>   			    struct qcm_process_device *qpd);
> +static bool set_cache_memory_policy_v9(struct device_queue_manager *dqm,
> +				   struct qcm_process_device *qpd,
> +				   enum cache_policy default_policy,
> +				   enum cache_policy alternate_policy,
> +				   void __user *alternate_aperture_base,
> +				   uint64_t alternate_aperture_size);
>   
>   void device_queue_manager_init_v9(
>   	struct device_queue_manager_asic_ops *asic_ops)
>   {
> +	asic_ops->set_cache_memory_policy = set_cache_memory_policy_v9;
>   	asic_ops->update_qpd = update_qpd_v9;
>   	asic_ops->init_sdma_vm = init_sdma_vm_v9;
>   	asic_ops->mqd_manager_init = mqd_manager_init_v9;
> @@ -48,10 +55,37 @@ static uint32_t compute_sh_mem_bases_64bit(struct kfd_process_device *pdd)
>   		private_base;
>   }
>   
> +static bool set_cache_memory_policy_v9(struct device_queue_manager *dqm,
> +				   struct qcm_process_device *qpd,
> +				   enum cache_policy default_policy,
> +				   enum cache_policy alternate_policy,
> +				   void __user *alternate_aperture_base,
> +				   uint64_t alternate_aperture_size)
> +{
> +	qpd->sh_mem_config = SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
> +				SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
> +
> +	if (dqm->dev->kfd->noretry)
> +		qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
> +
> +	if (KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 3) ||
> +		KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 4, 4) ||
> +		KFD_GC_VERSION(dqm->dev->kfd) == IP_VERSION(9, 5, 0))
> +		qpd->sh_mem_config |= (1 << SH_MEM_CONFIG__F8_MODE__SHIFT);
> +
> +	qpd->sh_mem_ape1_limit = 0;
> +	qpd->sh_mem_ape1_base = 0;
> +	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(qpd_to_pdd(qpd));
> +
> +	pr_debug("sh_mem_bases 0x%X sh_mem_config 0x%X\n", qpd->sh_mem_bases,
> +		 qpd->sh_mem_config);
> +	return true;
> +}
> +
>   static int update_qpd_v9(struct device_queue_manager *dqm,
>   			 struct qcm_process_device *qpd)
>   {
> -	struct kfd_process_device *pdd;
> +	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>   
>   	pdd = qpd_to_pdd(qpd);
>   

