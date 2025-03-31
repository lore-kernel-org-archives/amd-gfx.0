Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC986C3600B
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Mar 2025 12:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57D6C10E3FA;
	Mon, 31 Mar 2025 12:13:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZXVRLbSz";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C3610E3EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 12:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjvJpYmJYEFexKSw1KO7qnsjnsEAxKnAvYo7xR0El9akyvGmHYADitqDT0O0abzgTXtizkmOmq9BDyhC5IUGLN2SN50hNLYSXzEBGfVs4dyPmpTySYhpxIIMicX9oRBvdOOcU0Nm/Jtq1llNU69dh+xMnKVufjm5McsgUtRWyU+xWrlqxORWzdWpkOEQuaLO/K5lNxUsqHav5DBkv93CGrPBGwT5v7rNiRRTGYbepaA1+Nyw/UTLfw3eEPpTL12VvxbNnNnlMEKtcMfp/+XnFfRfihFp9YIQ9I6PtUe5JQoYHygpuPxW27P8KA3UsqN6KNXMg4UMTY0mu9HjohO6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+JL0uJv9/5h3JskVld/FFAa9Sk68xtzDnQYXM4sOuk=;
 b=Maoli4XE/S8xXP+w/fn/7e/1N9+I/jFQ3FD+xt+F/5BqxFU1X7EEpX1086NX1J0XUViZ1oH7Cm/BlWOr5bXMb37waT8wVSk9e05kznzN0Y8KaFSEx3SOy5T2f1kg2YnECnE0y2VOUirtsMST5pSmyvZCHMtUJrXYUqTui/d9IVy3eb7HSlVWsPv+mhW448FXVYIlFoq00AA4/10I5P5u2VsHC8JIa+pDrUAZib6ebEdUv86aN8qugp3i+9uyOeb8ujDLZAOJnl53KGOXuv9SRhh8Xbqi1gT8qPnYl67dQNQYJkuspYTqYLlesYfxGMoxUebesoOaIR19FS4YxGw5hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+JL0uJv9/5h3JskVld/FFAa9Sk68xtzDnQYXM4sOuk=;
 b=ZXVRLbSzz7COC00xKjWfltQXj9fhmZvwJHpPnmveiIUDFVqFnP5EVvzeKkE6iSfy6mhcj+2TFWxqDWwPSyDNJLhr7vPyKirXnrj8TaCabCelrOHnIZbkvrVa5KI7x4zjI0Xfa3mqMRoB/eFD40jIZhW4GssSwRLY/lpTeRmURwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9315.namprd12.prod.outlook.com (2603:10b6:610:1cf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 12:13:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 12:13:04 +0000
Message-ID: <5617daeb-f5d4-4dbc-9eb5-8685d5dab11a@amd.com>
Date: Mon, 31 Mar 2025 14:12:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/amdgpu: Adding amdgpu CRIU ioctl
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, David.YatSin@amd.com, Chris.Freehill@amd.com,
 tvrtko.ursulin@igalia.com, dcostantino@meta.com, sruffell@meta.com
References: <20250328180652.2108029-1-David.Francis@amd.com>
 <20250328180652.2108029-3-David.Francis@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250328180652.2108029-3-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0252.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b29785c-80ea-4292-a7e8-08dd704d635c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2lFeTMzcEl3dWMyMFFIWXpibWpmZEc5T1pzclNadVFGdkFYc1dvdDIxT2Q0?=
 =?utf-8?B?cjFCUlpnR29RbklpNlRXY243L0g3cDRFWFRHVk5SOENDVmlOSUpWamF3UXE2?=
 =?utf-8?B?dUZLSHhvTnltNnVEU0hKTHVPU21hS01LUXMvdVV6amN1YlBBRWdmcm5IRE1B?=
 =?utf-8?B?SkIwOHN6RENjMXJyd09JRWk4ejVvZytYaFRCT1VnZTRDbGNTU0FhdWFJL1kw?=
 =?utf-8?B?K1JvRHVZWFVBckR3U0lsQkgrSnhXOUVrQnZPNTlaOUp0OENrUjBzQzRrS1or?=
 =?utf-8?B?SldPY3NZMFp6OHpkbzh5b3VWUyt1SzFSYW0zaEs4cTJFaXpMN2E5YVpxK1BO?=
 =?utf-8?B?TE81WDBKcXNqUi9rcUZkMDM0WEUwRXJ2a2lveUN4cHE3M05PSzg1UEptQkdt?=
 =?utf-8?B?ZVRpQmdGb0RIYU5SRHg2RDh6dlB0QVRzYkZ6ZEJDWm45YjdhR1hSZk5jNGhh?=
 =?utf-8?B?VXNxc2hUN2VpN3U3dSs2V2piSDBEcm5wbjdNQjlkaUdySnY0TjJRTkpwekFD?=
 =?utf-8?B?RWwwOWdsMGhxOHFYZUZvVUVuQ2hFN2VZelEwOGZISGY0dVJ3d1lrTXROY1FI?=
 =?utf-8?B?eVlXc2Jjd2RkeGkzbTkxRUtZSDAzUzY4VUpRSmhmNnZnNlVpQnN1OXBlTFd5?=
 =?utf-8?B?R2R6N0hwQzdCa1kzNytkeTM4c3QzVUc3QjUyMC93VlFRUVR1bmVRSm1xUEVr?=
 =?utf-8?B?Rys1cHdkMStheiswbGxIQlpmVVNoUEVDTWxaUjlWYkdBWEhHY3NyMXpLUGZK?=
 =?utf-8?B?UWd6Y3kyNlU3dkdpTTBibzI1WmJkRVBRbkI0N2pZM0VWZWVkNWhqVVFnQTIr?=
 =?utf-8?B?VkR3b1RMeWVEejcwM3cxWGh1UkRxU1pIYjVOM2E2Zi9GdU9XN3kzUmJQdURz?=
 =?utf-8?B?VzNVL2RvN3lkbmJTRnpwdWo1ZnM2U0JNVWQ3UVFLQ3M5YkdwN2UyZUV0ZU91?=
 =?utf-8?B?ajJlaEdPZk9tQXJCQk1VWUFRemdCWmF5R2p1SEM2T0ZLQXRuaGNCcjhJK09C?=
 =?utf-8?B?dlZyZHVpaFU2QU1ZcURXVnVFUU5UaytHNEZER1hJUUo1YzV2RUZzMWkyQS9O?=
 =?utf-8?B?Skx4ZEVDMTU4OXhNYS9YS3E0ZGJvbWlZektMcFhwY0xRajV4ci81eVhaalg4?=
 =?utf-8?B?UW9QdkQraHNKYVBjdnNlRFlJMG5mNHE2SjUxcnpXeUZrLzBzUEV1UVpsemQ0?=
 =?utf-8?B?VDhjUHd4dVkvZURzV3lqU0ZCdWtIWGNaem5meVhqc0hsK1RwOEVDNXE3bEtS?=
 =?utf-8?B?Sk5BaVUwOFVnUWpxZFY1dFpVd0dLYUlyQXB3RVowZXpyVk1CRGJRWDJNWXo0?=
 =?utf-8?B?T3g5RzA3YnQvM0pPQWttREhWb3h1ampxZVgrV0xGb1VtWjVTWE9sSm5jZHYx?=
 =?utf-8?B?T0gvRU50S3hKWHI1Ri8zQkR3ZXk0aExDN3k0RkxrZTBaNWxUVEtYY1VlTnB1?=
 =?utf-8?B?NlgzcVg5TU5mNEVEMFZBZ3Y4em9FTHp6T0xDQ2k1NGhOS2hOUjJKcU45MXBk?=
 =?utf-8?B?V25PVE5TbU9FUFc5NHh1Q0IyUUp6SjlkaTdaUE9BZTlRSGRROWRCRmJGK01m?=
 =?utf-8?B?SnR3ZDJrSmNiUXRvVUNlY01EUllzVTdEanB3RVpkVjZYbm94ejBVT3N5MkxU?=
 =?utf-8?B?bHg3VGRveEFMSkIyR1AyaEh0VUM1dUtxS0NKMkVTVkZIb293bUZqOTI2VGF6?=
 =?utf-8?B?dXFMLy9TTzd4N21ocUErUjFpUlBVd3lqYW93N082cFZtYmhSRlZ0L0k3RkFi?=
 =?utf-8?B?b0h0TUVxQ001aG1DSCtMeTF4UjJEUnA0WERSZXoyN05naFFtbVFLSVEvTnVm?=
 =?utf-8?B?ZzlLTkFMNW5PSlBITWRrclBWZ1NrNEpIRTlGc0NMb1lSSGxKR0lDajNIR2tT?=
 =?utf-8?Q?pI3/gegStZQfm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlhISDl3ZkFwQ3k5QTM5cDBmdjhoeGdrZUJMV21Vc1JTWlQvTXRPc1I0SDlQ?=
 =?utf-8?B?SXdjV05QQnJsN0tHT2hvKzlyMHRaY3pXTFRUT1pYUWNMNDF1dHdvbTlZak91?=
 =?utf-8?B?Vm9uY1RxRllmWDQ4Nm1mdTJKWWF6NDFUZkh5VlBQVW8vNExDcG12VlNhTmgv?=
 =?utf-8?B?TFlQemFOZ2p1bWtJckJvZUJDSXB0N0FsZFZ2UjRsMzlDdFd2NWpuTzNyeXFm?=
 =?utf-8?B?aHA2NWJldlpFS0xqZVhYTGpDRTZFZ0VxeG5hb2ZjSGhEbWhjV1c2V2hYd2ww?=
 =?utf-8?B?N3NJamJmditCbXZ1S1FRWEdneWY3SU5LTEJuMFZ4OEpoeFpCbmIxWXVBSmRM?=
 =?utf-8?B?NUIzUTBQR0JxZmN3ZXZSakd2eWt4am1pWGZWNUJxbE5TL3NPT09JQnBxZUJ3?=
 =?utf-8?B?QUJNRWFjWDkwR2R4ZVFLQ21PNzJqL21oYWtkUUZ1eVpwaTV4bnNoTVNvbDlu?=
 =?utf-8?B?TFlGOTJnUTdGVWRZZ2c1UFk0MHdoNG93V3lIVHZwQmN6ME90SENqaE9ubE00?=
 =?utf-8?B?WFl4VTdJaE51ajd5azQ4QUlVQWIwWEd1RmxPcjBUUzE1UUtLVVkveFR2QlhN?=
 =?utf-8?B?ZVlYL0RKdER3OEN4YTFjY3p2VnRQYWNRYzRHQUgxdUFCMGZCSlY3Q1NTVGlj?=
 =?utf-8?B?QnpnV3ZJV0dWb0lWVmpJVklJYXZUWlY2czUwYkt0SEN0TFlueXN4VTgvdkdS?=
 =?utf-8?B?aXphc1R4a1JXbnNaakx1S3BTR0FpdjBNRGhadmthZlM4S3pEUXlHRkZWQVB1?=
 =?utf-8?B?bnY1dC9SMlZZTUJwTnFmTEE0WkdpbXAvcHlrckd3c29wV2pQak5Dd2NVMGdn?=
 =?utf-8?B?ckpWQ2NrTzdhNncyZ1MyQnN6R0MreUJNKytDN0lFVzdJY3JMWGQwUVRKTC9n?=
 =?utf-8?B?akVSVC9rM0J6MlBpR001dXY4OEE0NUR0NkllUkZBVWxXbXBPNm1xWDloU0V1?=
 =?utf-8?B?c3k2WEhmS0VhS3JCTTFlZjdJVFgydzVaaTk1NkVjT1hib2RDWTdZSnFtdFRK?=
 =?utf-8?B?YVlhQ1VDNCtyZTltSzRKSDJNWkRaV0U0eS9velltcXd0YWVpOGRMTXFUZE54?=
 =?utf-8?B?R1A4Uk51U1VwenJYZXpuYW5LUys1WG8zTlBLdGFXTlpJS1hpcTRDWGJIWGFK?=
 =?utf-8?B?aG04N2hPVnBtQ3VQbVJlSFc2eW1jQmVCZThiTGJNL094S2orTTBzTTFjaURu?=
 =?utf-8?B?WmIrRHpyd2trVzBpeW8zYUpOVGNWOG92WHMwRjkyK0hmYnU4MmdyQW91UnFD?=
 =?utf-8?B?djlUelYxZ0psTnpUdXlWQ1c5b1lvYjFEdkFiSEk2R04zWmcyNjVMUkhnU1A1?=
 =?utf-8?B?MmtzUHdZUGNiOFZNTXdYZnprWS9xbWdoRDlvbERDR3BIN0hsenRRUWg1b01B?=
 =?utf-8?B?bUg4VHNZeXNFQVdpVDBEczMyNTZzNmw1Skd1Mm9VYVFvakR2akhCelhNaDdl?=
 =?utf-8?B?dWhNdGJXZlBISEpmd2RJcHJrVlU1dURkSXlEdFRoSnJqWS92NVMzR20vaEJS?=
 =?utf-8?B?cDVsUmUvNnl4azk2ckZ1dTNic2QwZWVESk5FdFNRQ1JJNkptcUdja2FPdmRU?=
 =?utf-8?B?QmpGd0RmbVA2RTMzTDdEeUMvWktwMUxaSDZVS3ovQU9MN2RjTG9kL2p4OWNy?=
 =?utf-8?B?WlVzOTV1KzhsTGxOZFd6NWN1blk0Qjl5MTBqMi9MQkZlYzU2bnRnVWE3OWFQ?=
 =?utf-8?B?K3FMMzdNZzlvUTl4ck5MUTRycmpWQTU5Ylh1RHBFY0dBMDZTZ3d2S0FkZ21o?=
 =?utf-8?B?QU8wU0gwWjBVcWRwb1N5NEFNRExaczhCVDJnNnNuZ3d3WStOV3pxempYMko5?=
 =?utf-8?B?QjJBWVozVE5jcXp3VTNFcElPWklhdU1QS2MxR0JBNFBmNTYrM3gyTUFlTzhD?=
 =?utf-8?B?OXZTYXgvRWQyeGhiaWJNZnJlQWNNazJqNU96eWRYR3lPZUpzOCt0bjVHY0s5?=
 =?utf-8?B?bWk1TEd1M1VaeFZjRjFoWlEzRlQ4a1NVM2h4N2MybnREN2oveXhpOVB0bGpE?=
 =?utf-8?B?OWpiNm1uWFdUNmtPRmh0Ri9UN09SYnNDNk14b0pDdGoxU1VlY0NqNXEvaXZM?=
 =?utf-8?B?MllGYVpIdzl4cmZGTDV0eVpiclZQVnVNQytKRjRFSkJGa25oSnUvOVRGMzBJ?=
 =?utf-8?Q?vmzgCFnmhurlfui7UrX+/JbjI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b29785c-80ea-4292-a7e8-08dd704d635c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 12:13:04.1672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgUL6wFxQgkg/RhJjeWjk0FdYLajm4C5XDemhh4Sk3tGDPuo0F9U09XDkpHUkRf9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9315
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

Am 28.03.25 um 19:06 schrieb David Francis:
> amdgpu CRIU requires an amdgpu CRIU ioctl. This ioctl
> has a similar interface to the amdkfd CRIU ioctl.

That seems to assume a single IOCTL to restore the BOs and mapping which as far as I can see is a clear no-go from the design perspective.

Restore must use the same IOCTLs who were used to originally create or import the BOs. Otherwise the we have separate code paths for creating and restoring things.

Please organize a meeting with me and eventually Alex and Felix on how to approach this.

Regards,
Christian.

>
> The objects that can be checkpointed and restored are bos and vm
> mappings. Because a single amdgpu bo can have multiple mappings.
> they must be a separate object.
>
> Includes handling of restore retries and skips. Because some of the
> buffer objects restored by amdgpu may be imported from amdkfd,
> the work may need to be done in multiple stages. The skip
> field identifies bos that should not be restored in the
> current stage.
>
> The new ioctls live in a new file amdgpu_criu.c with its own
> header amdgpu_criu.h
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile      |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c | 462 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h |  47 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   2 +
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |   2 +
>  include/uapi/drm/amdgpu_drm.h            |  48 +++
>  6 files changed, 562 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 6cb3a2b2725a..eac5a455e6de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -63,7 +63,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
>  	amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
>  	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
>  	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
> -	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
> +	amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_criu.o \
>  	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>  	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
>  	amdgpu_userq_fence.o amdgpu_eviction_fence.o
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c
> new file mode 100644
> index 000000000000..234c29c1b2a1
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c
> @@ -0,0 +1,462 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> +* Copyright 2025 Advanced Micro Devices, Inc.
> +*
> +* Permission is hereby granted, free of charge, to any person obtaining a
> +* copy of this software and associated documentation files (the "Software"),
> +* to deal in the Software without restriction, including without limitation
> +* the rights to use, copy, modify, merge, publish, distribute, sublicense,
> +* and/or sell copies of the Software, and to permit persons to whom the
> +* Software is furnished to do so, subject to the following conditions:
> +*
> +* The above copyright notice and this permission notice shall be included in
> +* all copies or substantial portions of the Software.
> +*
> +* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> +* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> +* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> +* THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> +* OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> +* ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> +* OTHER DEALINGS IN THE SOFTWARE.
> +*/
> +
> +#include <linux/dma-buf.h>
> +#include <linux/hashtable.h>
> +#include <linux/mutex.h>
> +#include <linux/random.h>
> +
> +#include <drm/amdgpu_drm.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_file.h>
> +
> +#include "amdgpu_criu.h"
> +
> +#include <drm/amdgpu_drm.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_exec.h>
> +#include <drm/drm_gem_ttm_helper.h>
> +#include <drm/ttm/ttm_tt.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_display.h"
> +#include "amdgpu_dma_buf.h"
> +#include "amdgpu_hmm.h"
> +#include "amdgpu_xgmi.h"
> +
> +static bool is_import(struct amdgpu_bo *bo)
> +{
> +	if (bo->tbo.base.import_attach)
> +		return &bo->tbo.base != (struct drm_gem_object *)bo->tbo.base.import_attach->dmabuf->priv;
> +	return false;
> +}
> +
> +static int reserve_bo_and_vm(struct amdgpu_bo *bo,
> +			      struct amdgpu_vm *vm,
> +			      struct drm_exec *exec)
> +{
> +	int ret;
> +
> +	WARN_ON(!vm);
> +
> +	drm_exec_init(exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +	drm_exec_until_all_locked(exec) {
> +		ret = amdgpu_vm_lock_pd(vm, exec, 2);
> +		drm_exec_retry_on_contention(exec);
> +		if (unlikely(ret))
> +			goto error;
> +
> +		ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 1);
> +		drm_exec_retry_on_contention(exec);
> +		if (unlikely(ret))
> +			goto error;
> +	}
> +	return 0;
> +
> +error:
> +	pr_err("Failed to reserve buffers in ttm.\n");
> +	drm_exec_fini(exec);
> +	return ret;
> +}
> +
> +static void unreserve_bo_and_vm(struct drm_exec *exec)
> +{
> +	drm_exec_fini(exec);
> +}
> +
> +static int amdgpu_criu_process_info(struct drm_device *dev, struct drm_file *data,
> +			    struct drm_amdgpu_criu_args *args)
> +{
> +	struct drm_gem_object *gobj;
> +	int id;
> +	int num_bos = 0;
> +	int num_vm_mappings = 0;
> +	struct amdgpu_vm *avm = &((struct amdgpu_fpriv *)data->driver_priv)->vm;
> +
> +	spin_lock(&data->table_lock);
> +	idr_for_each_entry(&data->object_idr, gobj, id) {
> +		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> +		struct amdgpu_vm_bo_base *vm_bo_base;
> +
> +		num_bos += 1;
> +
> +		vm_bo_base = bo->vm_bo;
> +
> +		while (vm_bo_base) {
> +			struct amdgpu_bo_va *bo_va = container_of(vm_bo_base, struct amdgpu_bo_va, base);
> +			struct amdgpu_bo_va_mapping *mapping;
> +
> +			if (vm_bo_base->vm == avm) {
> +
> +				list_for_each_entry(mapping, &bo_va->invalids, list) {
> +					num_vm_mappings += 1;
> +				}
> +				list_for_each_entry(mapping, &bo_va->valids, list) {
> +					num_vm_mappings += 1;
> +				}
> +			}
> +
> +			vm_bo_base = vm_bo_base->next;
> +		}
> +	}
> +	spin_unlock(&data->table_lock);
> +
> +	args->num_bos = num_bos;
> +	args->priv_data_size = sizeof(struct drm_amdgpu_criu_bo_priv_data) * num_bos + sizeof(struct drm_amdgpu_criu_vm_mapping_priv_data) * num_vm_mappings;
> +	args->num_objs = num_vm_mappings;
> +	args->pid = avm->task_info->pid;
> +
> +	return 0;
> +}
> +
> +static int amdgpu_criu_checkpoint(struct drm_device *dev, struct drm_file *data,
> +			    struct drm_amdgpu_criu_args *args)
> +{
> +
> +	struct amdgpu_vm *avm = &((struct amdgpu_fpriv *)data->driver_priv)->vm;
> +	struct drm_amdgpu_criu_bo_bucket *bo_buckets;
> +	struct drm_amdgpu_criu_bo_priv_data *bo_privs;
> +	struct drm_amdgpu_criu_vm_mapping_priv_data *vm_privs;
> +	struct drm_gem_object *gobj;
> +	int vm_priv_index = 0;
> +	int bo_index = 0;
> +	int num_bos = 0;
> +	int fd, id, ret;
> +
> +	spin_lock(&data->table_lock);
> +	idr_for_each_entry(&data->object_idr, gobj, id)
> +		num_bos += 1;
> +	spin_unlock(&data->table_lock);
> +
> +	if (args->num_bos != num_bos) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	bo_buckets = kvzalloc(num_bos * sizeof(*bo_buckets), GFP_KERNEL);
> +	if (!bo_buckets) {
> +		ret = -ENOMEM;
> +		goto free_buckets;
> +	}
> +
> +	bo_privs = kvzalloc(num_bos * sizeof(*bo_privs), GFP_KERNEL);
> +	if (!bo_privs) {
> +		ret = -ENOMEM;
> +		goto free_privs;
> +	}
> +
> +	vm_privs = kvzalloc(args->num_objs * sizeof(*vm_privs), GFP_KERNEL);
> +	if (!vm_privs) {
> +		ret = -ENOMEM;
> +		goto free_vms;
> +	}
> +
> +	idr_for_each_entry(&data->object_idr, gobj, id) {
> +		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> +		struct drm_amdgpu_criu_bo_bucket *bo_bucket;
> +		struct drm_amdgpu_criu_bo_priv_data *bo_priv;
> +		struct amdgpu_vm_bo_base *vm_bo_base;
> +
> +		bo_bucket = &bo_buckets[bo_index];
> +		bo_priv = &bo_privs[bo_index];
> +
> +		bo_bucket->size = amdgpu_bo_size(bo);
> +		bo_bucket->offset = amdgpu_bo_mmap_offset(bo);
> +		bo_bucket->alloc_flags = bo->flags;
> +		bo_bucket->preferred_domains = bo->preferred_domains;
> +
> +		bo_priv->idr_handle = id;
> +
> +		if (is_import(bo))
> +			bo_bucket->flags |= AMDGPU_CRIU_BO_FLAG_IS_IMPORT;
> +
> +		drm_gem_prime_handle_to_fd(dev, data, id, 0, &fd);
> +		if (fd)
> +			bo_bucket->dmabuf_fd = fd;
> +
> +		vm_bo_base = bo->vm_bo;
> +
> +		while (vm_bo_base) {
> +			struct amdgpu_bo_va *bo_va = container_of(vm_bo_base, struct amdgpu_bo_va, base);
> +			struct amdgpu_bo_va_mapping *mapping;
> +
> +			if (vm_bo_base->vm == avm) {
> +				list_for_each_entry(mapping, &bo_va->invalids, list) {
> +					vm_privs[vm_priv_index].start = mapping->start;
> +					vm_privs[vm_priv_index].last = mapping->last;
> +					vm_privs[vm_priv_index].offset = mapping->offset;
> +					vm_privs[vm_priv_index].flags = mapping->flags;
> +					vm_privs[vm_priv_index].idr_handle = id;
> +					vm_priv_index += 1;
> +
> +					bo_bucket->addr = mapping->start * AMDGPU_GPU_PAGE_SIZE;
> +				}
> +				list_for_each_entry(mapping, &bo_va->valids, list) {
> +					vm_privs[vm_priv_index].start = mapping->start;
> +					vm_privs[vm_priv_index].last = mapping->last;
> +					vm_privs[vm_priv_index].offset = mapping->offset;
> +					vm_privs[vm_priv_index].flags = mapping->flags;
> +					vm_privs[vm_priv_index].idr_handle = id;
> +					vm_priv_index += 1;
> +
> +					bo_bucket->addr = mapping->start * AMDGPU_GPU_PAGE_SIZE;
> +				}
> +			}
> +
> +			vm_bo_base = vm_bo_base->next;
> +		}
> +
> +		bo_index += 1;
> +	}
> +
> +	ret = copy_to_user((void __user *)args->bos, bo_buckets, num_bos * sizeof(*bo_buckets));
> +	if (ret) {
> +		pr_debug("Failed to copy BO information to user\n");
> +		ret = -EFAULT;
> +		goto free_vms;
> +	}
> +
> +	ret = copy_to_user((void __user *)args->priv_data, bo_privs, num_bos * sizeof(*bo_privs));
> +	if (ret) {
> +		pr_debug("Failed to copy BO PRIV information to user\n");
> +		ret = -EFAULT;
> +		goto free_vms;
> +	}
> +	ret = copy_to_user((void __user *)(args->priv_data + sizeof(struct drm_amdgpu_criu_bo_priv_data) * num_bos), vm_privs, args->num_objs * sizeof(*vm_privs));
> +	if (ret) {
> +		pr_debug("Failed to copy VM PRIV information to user\n");
> +		ret = -EFAULT;
> +		goto free_vms;
> +	}
> +
> +free_vms:
> +	kvfree(vm_privs);
> +free_privs:
> +	kvfree(bo_privs);
> +free_buckets:
> +	kvfree(bo_buckets);
> +exit:
> +
> +	return ret;
> +}
> +
> +static int amdgpu_criu_unpause(struct drm_device *dev, struct drm_file *data,
> +			    struct drm_amdgpu_criu_args *args)
> +{
> +	return 0;
> +}
> +
> +static int amdgpu_criu_restore(struct drm_device *dev, struct drm_file *data,
> +			    struct drm_amdgpu_criu_args *args)
> +{
> +	struct amdgpu_vm *avm = &((struct amdgpu_fpriv *)data->driver_priv)->vm;
> +	struct drm_amdgpu_criu_bo_bucket *bo_buckets;
> +	struct drm_amdgpu_criu_bo_priv_data *bo_privs;
> +	struct drm_amdgpu_criu_vm_mapping_priv_data *vm_privs;
> +	struct amdgpu_fpriv *fpriv = (struct amdgpu_fpriv *)data->driver_priv;
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct amdgpu_bo *restored_bo;
> +	int ret, i, j;
> +
> +	bo_buckets = kvzalloc(args->num_bos * sizeof(*bo_buckets), GFP_KERNEL);
> +	if (!bo_buckets) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +	ret = copy_from_user(bo_buckets, (void *)args->bos, args->num_bos * sizeof(*bo_buckets));
> +	if (ret) {
> +		ret = -EINVAL;
> +		goto free_buckets;
> +	}
> +
> +	bo_privs = kvzalloc(args->num_bos * sizeof(*bo_privs), GFP_KERNEL);
> +	if (!bo_privs) {
> +		ret = -ENOMEM;
> +		goto free_buckets;
> +	}
> +	ret = copy_from_user(bo_privs, (void *)args->priv_data, args->num_bos * sizeof(*bo_privs));
> +	if (ret) {
> +		ret = -EINVAL;
> +		goto free_privs;
> +	}
> +
> +	vm_privs = kvzalloc(args->num_objs * sizeof(*vm_privs), GFP_KERNEL);
> +	if (!vm_privs) {
> +		ret = -ENOMEM;
> +		goto free_privs;
> +	}
> +
> +	ret = copy_from_user(vm_privs, (void *)(args->priv_data + sizeof(struct drm_amdgpu_criu_bo_priv_data) * args->num_bos), args->num_objs * sizeof(*vm_privs));
> +	if (ret) {
> +		ret = -EINVAL;
> +		goto free_vms;
> +	}
> +
> +	for (i = 0; i < args->num_bos; i++) {
> +		struct drm_amdgpu_criu_bo_bucket *bo_bucket = &bo_buckets[i];
> +		struct drm_amdgpu_criu_bo_priv_data *bo_priv = &bo_privs[i];
> +		struct amdgpu_bo *bo;
> +
> +		/* Either this bo is waiting for a dmabuf_fd to be restored or it has already been restored */
> +		if (bo_bucket->flags & AMDGPU_CRIU_BO_FLAG_SKIP)
> +			continue;
> +
> +		if (!(bo_bucket->flags & AMDGPU_CRIU_BO_FLAG_IS_IMPORT)) {
> +			struct drm_gem_object *obj;
> +			enum ttm_bo_type type = ttm_bo_type_device;
> +			int xcp_id = -1;
> +			int prime_fd, handle;
> +
> +			if (bo_bucket->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM) {
> +				xcp_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ?
> +							0 : fpriv->xcp_id;
> +			}
> +			ret = amdgpu_gem_object_create(adev, bo_bucket->size, 1, bo_bucket->preferred_domains,
> +				bo_bucket->alloc_flags, type, NULL, &obj, xcp_id + 1);
> +			if (ret)
> +				goto free_vms;
> +
> +			restored_bo = gem_to_amdgpu_bo(obj);
> +
> +			drm_gem_handle_create(data, obj, &handle);
> +			drm_prime_change_buf_handle(data, obj, bo_priv->idr_handle);
> +
> +			bo_bucket->restored_offset = amdgpu_bo_mmap_offset(restored_bo);
> +
> +			ret = drm_gem_prime_handle_to_fd(dev,
> +			       data, bo_priv->idr_handle,
> +			       DRM_RDWR,
> +			       &prime_fd);
> +
> +			bo_bucket->dmabuf_fd = prime_fd;
> +		} else {
> +			struct drm_gem_object *obj;
> +			int ret, handle = -1;
> +
> +			bo = gem_to_amdgpu_bo(obj);
> +
> +			if (bo->kfd_bo) {
> +				ret = drm_gem_prime_fd_to_handle(dev, data, bo_bucket->dmabuf_fd, &handle);
> +
> +				if (ret < 0)
> +					goto free_vms;
> +
> +				obj = idr_find(&data->object_idr, handle);
> +				if (!obj)
> +					goto free_vms;
> +
> +				ret = drm_prime_change_buf_handle(data, obj, bo_priv->idr_handle);
> +				if (ret < 0)
> +					goto free_vms;
> +
> +				if (obj != &bo->tbo.base)
> +					restored_bo = gem_to_amdgpu_bo(obj);
> +				else
> +					restored_bo = bo;
> +
> +				bo_bucket->restored_offset = amdgpu_bo_mmap_offset(restored_bo);
> +			}
> +		}
> +
> +
> +		for (j = 0; j < args->num_objs; j++) {
> +			struct drm_amdgpu_criu_vm_mapping_priv_data *vm_priv = &vm_privs[j];
> +			struct amdgpu_bo_va *bo_va;
> +			struct drm_exec exec;
> +
> +			if (vm_priv->idr_handle != bo_priv->idr_handle)
> +				continue;
> +
> +			reserve_bo_and_vm(restored_bo, avm, &exec);
> +
> +			bo_va = amdgpu_vm_bo_find(avm, restored_bo);
> +			if (!bo_va)
> +				bo_va = amdgpu_vm_bo_add(adev, avm, restored_bo);
> +
> +			amdgpu_vm_bo_map(adev,
> +			     bo_va,
> +			     vm_priv->start * AMDGPU_GPU_PAGE_SIZE, vm_priv->offset,
> +			     (vm_priv->last - vm_priv->start + 1) * AMDGPU_GPU_PAGE_SIZE, vm_priv->flags);
> +
> +			ret = amdgpu_vm_bo_update(adev, bo_va, false);
> +
> +			ret = amdgpu_vm_update_pdes(adev, avm, false);
> +
> +			unreserve_bo_and_vm(&exec);
> +
> +		}
> +	}
> +
> +	ret = copy_to_user((void *)args->bos, bo_buckets, args->num_bos * sizeof(*bo_buckets));
> +	if (ret) {
> +		pr_debug("Failed to copy BO information to user\n");
> +		ret = -EFAULT;
> +		goto free_vms;
> +	}
> +
> +free_vms:
> +	kvfree(vm_privs);
> +free_privs:
> +	kvfree(bo_privs);
> +free_buckets:
> +	kvfree(bo_buckets);
> +exit:
> +
> +	return ret;
> +}
> +
> +static int amdgpu_criu_resume(struct drm_device *dev, struct drm_file *data,
> +			    struct drm_amdgpu_criu_args *args)
> +{
> +	return 0;
> +}
> +
> +int amdgpu_criu_op_ioctl(struct drm_device *dev, void *data,
> +			    struct drm_file *filp)
> +{
> +	struct drm_amdgpu_criu_args *args = data;
> +	int ret;
> +
> +	switch (args->op) {
> +	case AMDGPU_CRIU_OP_PROCESS_INFO:
> +		ret = amdgpu_criu_process_info(dev, filp, args);
> +		break;
> +	case AMDGPU_CRIU_OP_CHECKPOINT:
> +		ret = amdgpu_criu_checkpoint(dev, filp, args);
> +		break;
> +	case AMDGPU_CRIU_OP_UNPAUSE:
> +		ret = amdgpu_criu_unpause(dev, filp, args);
> +		break;
> +	case AMDGPU_CRIU_OP_RESTORE:
> +		ret = amdgpu_criu_restore(dev, filp, args);
> +		break;
> +	case AMDGPU_CRIU_OP_RESUME:
> +		ret = amdgpu_criu_resume(dev, filp, args);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h
> new file mode 100644
> index 000000000000..e1d22d14a23a
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> +* Copyright 2025 Advanced Micro Devices, Inc.
> +*
> +* Permission is hereby granted, free of charge, to any person obtaining a
> +* copy of this software and associated documentation files (the "Software"),
> +* to deal in the Software without restriction, including without limitation
> +* the rights to use, copy, modify, merge, publish, distribute, sublicense,
> +* and/or sell copies of the Software, and to permit persons to whom the
> +* Software is furnished to do so, subject to the following conditions:
> +*
> +* The above copyright notice and this permission notice shall be included in
> +* all copies or substantial portions of the Software.
> +*
> +* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> +* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> +* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> +* THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> +* OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> +* ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> +* OTHER DEALINGS IN THE SOFTWARE.
> +*/
> +
> +#ifndef __AMDGPU_CRIU_H__
> +#define __AMDGPU_CRIU_H__
> +
> +#include <drm/amdgpu_drm.h>
> +
> +int amdgpu_criu_op_ioctl(struct drm_device *dev, void *data,
> +			    struct drm_file *filp);
> +
> +struct amdgpu_bo *bo_from_criu_global_handle(uint8_t *handle);
> +int insert_bo_at_criu_global_handle(struct amdgpu_bo *bo, uint8_t *handle);
> +
> +struct drm_amdgpu_criu_bo_priv_data {
> +	uint32_t idr_handle; // IDR for drm gem idr
> +};
> +
> +struct drm_amdgpu_criu_vm_mapping_priv_data {
> +	uint64_t start;
> +	uint64_t last;
> +	uint64_t offset;
> +	uint64_t flags;
> +	uint32_t idr_handle;
> +};
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index acb9dc3705ac..12d844598efc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -53,6 +53,7 @@
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_userqueue.h"
>  #include "amdgpu_userq_fence.h"
> +#include "amdgpu_criu.h"
>  #include "../amdxcp/amdgpu_xcp_drv.h"
>  
>  /*
> @@ -2909,6 +2910,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_CRIU_OP, amdgpu_criu_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  };
>  
>  static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 065d87841459..9c1e4c2ba110 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -45,6 +45,8 @@
>  #include "amdgpu_dma_buf.h"
>  #include "kfd_debug.h"
>  
> +#include "amdgpu_criu.h"
> +
>  static long kfd_ioctl(struct file *, unsigned int, unsigned long);
>  static int kfd_open(struct inode *, struct file *);
>  static int kfd_release(struct inode *, struct file *);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 8191d0bd0c00..d0a46b27e1a8 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -57,6 +57,7 @@ extern "C" {
>  #define DRM_AMDGPU_USERQ		0x16
>  #define DRM_AMDGPU_USERQ_SIGNAL		0x17
>  #define DRM_AMDGPU_USERQ_WAIT		0x18
> +#define DRM_AMDGPU_CRIU_OP		0x19
>  
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -77,6 +78,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>  #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
> +#define DRM_IOCTL_AMDGPU_CRIU_OP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CRIU_OP, struct drm_amdgpu_criu_args)
>  
>  /**
>   * DOC: memory domains
> @@ -1585,6 +1587,52 @@ struct drm_color_ctm_3x4 {
>  	__u64 matrix[12];
>  };
>  
> +/* CRIU ioctl
> + *
> + * When checkpointing a process, the CRIU amdgpu plugin will perform:
> + * 1. INFO op to get information about state that needs to be saved. This
> + *    pauses execution until the checkpoint is done.
> + * 2. CHECKPOINT op to save state (BOs for now, TODO: CS contexts)
> + * 3. UNPAUSE op to resume execution when the checkpoint is done.
> + *
> + * When restoring a process, the CRIU amdgpu plugin will perform:
> + *
> + * 1. RESTORE op to restore state
> + * 2. RESUME op to restore userptr mappings (TODO)
> + */
> +enum drm_amdgpu_criu_op {
> +	AMDGPU_CRIU_OP_PROCESS_INFO,
> +	AMDGPU_CRIU_OP_CHECKPOINT,
> +	AMDGPU_CRIU_OP_UNPAUSE,
> +	AMDGPU_CRIU_OP_RESTORE,
> +	AMDGPU_CRIU_OP_RESTORE_RETRY,
> +	AMDGPU_CRIU_OP_RESUME,
> +};
> +
> +struct drm_amdgpu_criu_args {
> +	__u64 bos; /* user pointer to bos array */
> +	__u64 priv_data; /* user pointer to private data */
> +	__u64 priv_data_size;
> +	__u32 num_bos;
> +	__u32 num_objs;
> +	__u32 pid;
> +	__u32 op;
> +};
> +
> +#define AMDGPU_CRIU_BO_FLAG_IS_IMPORT	(1 << 0)
> +#define AMDGPU_CRIU_BO_FLAG_SKIP	(1 << 1)
> +
> +struct drm_amdgpu_criu_bo_bucket {
> +	__u64 addr;
> +	__u64 size;
> +	__u64 offset;
> +	__u64 restored_offset;    /* During restore, updated offset for BO */
> +	__u64 alloc_flags;
> +	__u32 preferred_domains;
> +	__u32 dmabuf_fd;
> +	__u32 flags;
> +};
> +
>  #if defined(__cplusplus)
>  }
>  #endif

