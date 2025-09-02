Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964A8CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 08:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E28110E1C4;
	Tue,  2 Sep 2025 08:51:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vXEjW6/X";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5506110E1C4
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 08:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4kbBCjD3RUsz+MfaswkKITPcnQJ3hiJHQCVvY2u0mKm9/qVY4SwflDz86VU8VnN7nutJdq4HZc3UvxhsRRRrvzIQgM7PJBOKrwAS/C3FdyXwTqX199kjxeQ42sL1vNAaTM0t6SlrZ02gfUWTbNru0//xYNrSq2W7KUD7RI0qYIR37tqdBKDKHRsQyUmMVGcpBPzFaPmlmv7QYWtnXZOsmuN9cxRg4lNVtmqG5FhrQHVWNjTxdx2RZj88CneSYRh/A6VTh6snRsXSClkLDz18yNOz4S3xiSh7I4Osi513oQbgqAWT1LSQl3bj2a4z7/B60RjZ1V3TYQ4Z5hOCfmxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIIVADq89ehquY7v3P4bRTjiNnNHLHmuf03A/8ubMyM=;
 b=y8MtYoGTMyINqlnX9CXMbywijBo+NdN5MP9qqROabf3WuJkSndgrPKzNd6kupfJb5Zk83pfhdc5NThI60uD8NGITA7H0QeWSEtAy9hVe36a2HeJU4Iho7xYKm1SC6enLKNgMVnybWD86Wv+sTpUyCpTi1IdTmUs+NMcNhXgEU1+nRYN9G8Q4YWJZulHMoCRyZI82Pxa7fe38xbphivOu95himq5xFnx2IFhEkX8qjX4JV4+ULyG+vllPMESqJbLr4UYd7S6SQCq5RQ2SwafZv4hMSpQglEyAdWZoLBZSF5vPcKJwVJRTp9Wc+KZUUMKgUTtN274tgptXNmJAdk764g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIIVADq89ehquY7v3P4bRTjiNnNHLHmuf03A/8ubMyM=;
 b=vXEjW6/XB1v1Nb3oQHs2mCj0L+GF+Tk0u0WskWKT8uLw3/DPD2wyhyVFoIyV8Y+NLgt622m/H0MK8BN+HHXtIGr6/VTfzb9iwc2bBDUMKr8FTHia5sc7qo0boOOudwtJGGm2Hd0VPwa0CkXGGPYdjeb7ujhrIALfL1WmAF4fQSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:51:28 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 08:51:28 +0000
Message-ID: <e5be2653-f325-487e-b14e-208f4edb7306@amd.com>
Date: Tue, 2 Sep 2025 14:21:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: fix userq VM validation v3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Sunil.Khatri@amd.com
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20250828150200.4035-1-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250828150200.4035-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0102.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:278::9) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c15259-1d87-4418-755a-08dde9fde796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTlGcXN6WHhRRjFPVmU1d3Y4MXZQZDdCVm91SGFab2k0YjJ1YWpkaWNYUE5W?=
 =?utf-8?B?aVdjYUlYOVowQVZibUlSVlcrUDkweStKR2JPSGV2UytOMmJGUXpIMWhpTHN2?=
 =?utf-8?B?MkozVm16VExtWjVqN3V5T2Z2NE5vdjAwdmQ3TFg2V1RRejJlMEN6Z3gxS0Zn?=
 =?utf-8?B?Nm00TGRjaXptc2ZxRDJVc3JyZ1lqcXNWTVRNUGIzZFZDeG5Mb0hnT08za3Qw?=
 =?utf-8?B?dHpkbWRQeXhUelJ6dkJ0NkNlZFU4UXpVTVZHVnNzTURpbVFsRDRwV1FHWXk3?=
 =?utf-8?B?SGJFamk5ejV1c2tOd1NFYVcxaHdjaGdWdUZtZmdvOHYzblM0WVMxWDBnYlY2?=
 =?utf-8?B?d1JnakNuZjEvM09TUWNsMlg3SVAzSmE3V2V2eEEvWEZWemVrVEQzbnAxTHB0?=
 =?utf-8?B?cTdZWjI0WFFyL1lvWWJKOUhucWNibTF0ZStZV21KSmF3UUM0Z21ZeWIzd0NR?=
 =?utf-8?B?c3NhZ2tOcDV5NE9yeU5jQnV3OVNKTm1WMy94TkE1SVBPVHRnOE1qamxmU2ln?=
 =?utf-8?B?bGJZdmRQdW9JMVE4K1c5OHRqWXhXczRSR1A2cmZCRnlnOXF3Mm9maWFPNTVE?=
 =?utf-8?B?a0J0azFJZWIzdE0yYVJtN0NPT3Y4dDRzKzFTV2Jqd3M1K3EyYngxc09PYW9L?=
 =?utf-8?B?ZjRYb1lYV1lhVjhwclBVRjhsdzFUWkk3L3hic1B5dEc5Nm1mVWg5Ri84VDhL?=
 =?utf-8?B?RS9sbU9QaVpBWFNyNTBUZ3pqZytYRmI0d1o3djhWNC9kNnFvWWxhUUF1RVZB?=
 =?utf-8?B?KzBSOFBWWHVNU0pSUTBhbzF5aFRUMUFlZmk5OHNoWmpGY2ZFRmozc1ordyti?=
 =?utf-8?B?Vk0rUXEwMFU4NU0zRUhMYSt5VytOOEdERVBDdk12WVNyOGxDQnlYMjNPS1dM?=
 =?utf-8?B?Vk10bThtVzJsV1Z5OXhiUFVUQmJEYkxJdXhMUTRDKzA1dlFLRDFvZTVuYVpR?=
 =?utf-8?B?RFdsNFdDcW5nWHNEdWN2R0tESS9ERG15Tmt3ZUVpWmtoYk01Qk5xZzZQcld6?=
 =?utf-8?B?dURVRDN2Qk1hc0duVGV6VW9TU1pWeGd3L3k1VlNza3VnMURsRkJHOEtVMDQ1?=
 =?utf-8?B?SWw2OFBWbUlQWEhjSC9NU2gwNms4bkxmWFI1dXJ0c29lQTljSVp0M2o5ckFK?=
 =?utf-8?B?eTUvNXVUSFV1L2tHZHJ5Z2FoMDlGY0JDSS8zbndKdEpLK3pjTTBabzQxZE5B?=
 =?utf-8?B?bmtVVXhIMUpnUXlqdTY3bk9XMFJycncrNjEyNkpNSnY2c3JrNytHYTlLcEw5?=
 =?utf-8?B?ZEJwZWQ4Ym9HVTVWUnA3QkU4Mnd0bnVzZG1mUkJkSnBHMGhHWXlrM21ZQmJz?=
 =?utf-8?B?QjZ0SEYrUk1pUjhDcUdic3hMS2lad29pb21kdWx0M1lCUmxKNnk3SnFoK0JB?=
 =?utf-8?B?OWNDUW1mdzVLdzFmT0NFdHJ0QlVzR3JqOVZaNFBibVNRWUhzQ3FCcnJOWWxV?=
 =?utf-8?B?b1Q3Z0lkbmhQbWZiMllPNWNFcTFXOGVKN2tsQ1BvY2U5SGg0K3F2MGxZbk5i?=
 =?utf-8?B?TjI2N1FDRmo5R0dZVi9uSFZYaHNBOG55QVhPZHpRMnVjcVlYYlhaTlNDN2po?=
 =?utf-8?B?MFIvQXVrL3RZc0c2dUg0QXZIR0huTzlqdlpPVTB2L1Zka0IzenkwSGtNeTAy?=
 =?utf-8?B?NDFVcFNwZmdsblBYRlRQelNrZjhLNWl2alpiT0hvd0FsTWMzSkF0VHFvMnZl?=
 =?utf-8?B?SFdqQlladVVIek14WkFQZldmbjdONGQ1NHd3NVpBLzUrOVZYam5ZZEsrcUVO?=
 =?utf-8?B?NXVNeStLOVR0b1daMmdsVmNab0svNDBpeUFGRGcrL2NRZ0pieWFORldCQU54?=
 =?utf-8?B?d3V6K3VVZHFmK2xjdE5zQ2R2MU56VFE4QzZVZTRCUGdnNGdZVjlEM243MUpw?=
 =?utf-8?B?R3FIZTUrMzQvaEJ3UXF6QmNBaVBVY2Z2aFE0RVdvWUVXSVVQNkZnbkowZTY5?=
 =?utf-8?Q?UtmWKFvJWiw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlE1R0gyTGRFam9hQ2hOVTVzZ3kyZzFlcG5WSGVTR2Q1dnF6Q016VUtrSVN3?=
 =?utf-8?B?dndyV2pBQWRSWUdxR1RPS3lGMTBRNjZqSUZiVit1WXBsNGkvRk1pT2k4cHVR?=
 =?utf-8?B?NDI1Q1JUd01rZVFMSWl4TDFMQ1ROM21NbDIvREZuUUhpN3lqc0EyRm1FTFQz?=
 =?utf-8?B?LzlQM21lSmpIMjZNNUF0NDEvSkRRaHRVMDJSMDAwdTA5dnhpeTBlNjc2Zm9W?=
 =?utf-8?B?K2taYTlrL282WnZIdkE0S25LOC9sbHJaYmNPbmJIYURzR0tQUTRDcFpuOVFt?=
 =?utf-8?B?WU5MQUlWQ0UzbG9PMGtaZTg2cGQ5TXlvMU90K3psTGZ1NVJnQkJ4eFNhKzl0?=
 =?utf-8?B?c0doWWl3Z0FpYzR0cFREbVQzUlBGUjBKa2QzNXkxNE1ac1pwUzVMZ05xajFZ?=
 =?utf-8?B?SFJveWNoNDh0ODB3U0tnL2RPOVZZMUVjMlEzZ0IvdC9uOWZXRW1yRHFFajdS?=
 =?utf-8?B?KzBFS0RrcGtmcVpUQ1BibG9ab0R0ZWFucTllYk42SW1iTk5BdENiOXpSOUpy?=
 =?utf-8?B?R3YzMFdmcGlQU3BoWVRFeXNDMzdRSnhsdnhqdG1DVkVMNnA3SHRheEYwaTlY?=
 =?utf-8?B?MzJxNXpVM2V2ZjREclpGNGFXcmg0TDNxczJzSHhzaUEvMDNuQk1NZjVCODNE?=
 =?utf-8?B?c0FpYUZrNVY3eVBKRUNKMmpwUW0rSGtjdVNSSEJVcjBud1JOTWpVKzhFODZs?=
 =?utf-8?B?TkRWUFhhbTIrQjVZdkxicGhKbk8zcjNkRmNYR1E3VFd4bmZldGpEOE1jUm50?=
 =?utf-8?B?NEVCaDRNcWJpWFdNREMrOXdiR3N2bnpiNG5zL2d4MkVXeHllbDJCSVJicXhM?=
 =?utf-8?B?Y1dXV0RiODJrK3RzbmR3emtPaG5mMEk4aXYxMWRoMkV1dnQ2YjM5RXlSU01v?=
 =?utf-8?B?V01ZUnQ3azJYNXdscXR1Zjk3c0tvTG9KUy9aYllmUERpMkdERnZRaVBYZTZw?=
 =?utf-8?B?b2J0T05FR29TZ0ZzUWMvMW52VHBaZXRjd051bENnLytvR21ITGhEYmt6QnJh?=
 =?utf-8?B?YUVXcmpIcjdTcjJvRVU4YThibkdIOWs1cTZlc2o0TEo0c2VDc21qWWc5UUwz?=
 =?utf-8?B?WUh1dW5LV1gwM2EwYS93dHlhMU41UDAwUFFZNjBRbkhIK3F5dGZYOTFnYjdP?=
 =?utf-8?B?ZzZ3NVhIZWJBQzI0UXJYYTBjYWtubGxoRHBlcjlLTWdkVVlZOWhMbnIvVS9a?=
 =?utf-8?B?YkVVZVc3OG5lbzdYOFN3TC9NUnN1UDcwbTRqOW5sSXU4OHlZZFRXZllTNGdL?=
 =?utf-8?B?MUJMRW5wd3ArWTRYbHIvOFpEUWVpSnhjZkpyakI2OU4ydW9OdHdkTXFFKzND?=
 =?utf-8?B?VUdHUW9BSWc3VTlIZFkwR1JEa1V4WkpsaFVNVUpxOVRTT202RmpBMnJSTHVj?=
 =?utf-8?B?dklVMkNLRUVYT0FpVUh6V3grQ0phWnRDWXh6TmEwYmcySnpZUCs2eUpRRXVi?=
 =?utf-8?B?Y0plM0xkUWQ2aTA1STZwWUpzeFo0c3dCYXF6SWl4QkVaN1pqSjZINFhabS94?=
 =?utf-8?B?Y1pmSmdlZGFKWDR6biswUm1FRm1uS1BOSWxjdGk3UXpzdzNxVU9JQm15ckpK?=
 =?utf-8?B?aUlpVWxVeXZBSnJoK2NtUVhZelpTSkQvYnFicUY2akpZczNrWW1DcG0xc3Jy?=
 =?utf-8?B?ditvUGpCSGJWKyt2NmtKb0M4eGhsQUoxN0xuTWJGeXdZNkRXbUhBQWtSNjNX?=
 =?utf-8?B?MzNYZ2JpSmJRR1JZR0ZYcEtuZStPTTFHWkJ5Q2JHUVNwNzVGRXkvcm1qT0V5?=
 =?utf-8?B?MUtYbW0yQkg1N29jMGxCTWVDTW5BMG5yWEpiNWJSazMxbCtGbEVvQnN5d250?=
 =?utf-8?B?WjNBeXdaNFZscU9qbUswQ0NlMm1KeHhaaktkMDZHc09QK2hmb0VzZ1NUb2JF?=
 =?utf-8?B?eUlSQWp3U1o1WFZmaGxGaVJ4YnVZNko0aUJWY2ZISFZuUUE3K0w5QTVHKytK?=
 =?utf-8?B?YjRWMFJWRzBPRXVoNTlJK1lnK0tXdUVOTDl4bDhzanFybmR1bFVlTFozUUEx?=
 =?utf-8?B?MW5CczhHTTZ6cG5ZY2toK0E2ZkhRTjhkMWphbktIRUttOFZXV3k5NjRiMmxz?=
 =?utf-8?B?ZDhsN3hVa1JEdFZWR2p0ZmI4VU81MzViZTJKTUtITnZoc2JQaFFUejRSME5a?=
 =?utf-8?Q?zJ2afGxF6pkmkip55Ye2aqlUC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c15259-1d87-4418-755a-08dde9fde796
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:51:28.1519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rmeb+Pn1bKblBs2K0rHxuR0Mdab/MvfjOQrKoJCZ36yY6RiXQ8h7Hc2QsiSIOL5SP4LgkNSZJG7hzbyOsRn+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
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


On 8/28/2025 8:31 PM, Christian König wrote:
> That was actually complete nonsense and not validating the BOs
> at all. The code just cleared all VM areas were it couldn't grab the
> lock for a BO.
>
> Try to fix this. Only compile tested at the moment.
>
> v2: fix fence slot reservation as well as pointed out by Sunil.
>      also validate PDs, PTs, per VM BOs and update PDEs
> v3: grab the status_lock while working with the done list.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 136 ++++++++++------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  35 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |   2 +
>   3 files changed, 97 insertions(+), 76 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 424831997cb1..abc2f96bea76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -545,108 +545,92 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>   	return ret;
>   }
>   
> -static int
> -amdgpu_userq_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
> +static int amdgpu_userq_validate_vm(void *param, struct amdgpu_bo *bo)
>   {
>   	struct ttm_operation_ctx ctx = { false, false };
> -	int ret;
>   
>   	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> -
> -	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -	if (ret)
> -		DRM_ERROR("Fail to validate\n");
> -
> -	return ret;
> +	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>   }
>   
>   static int
> -amdgpu_userq_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
> +amdgpu_userq_validate_bos(struct amdgpu_device *adev, struct drm_exec *exec,
> +			  struct amdgpu_vm *vm)
>   {
> -	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
> -	struct amdgpu_vm *vm = &fpriv->vm;
> -	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct ttm_operation_ctx ctx = { false, false };
>   	struct amdgpu_bo_va *bo_va;
> -	struct ww_acquire_ctx *ticket;
> -	struct drm_exec exec;
>   	struct amdgpu_bo *bo;
> -	struct dma_resv *resv;
> -	bool clear, unlock;
> -	int ret = 0;
> -
> -	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
> -	drm_exec_until_all_locked(&exec) {
> -		ret = amdgpu_vm_lock_pd(vm, &exec, 2);
> -		drm_exec_retry_on_contention(&exec);
> -		if (unlikely(ret)) {
> -			drm_file_err(uq_mgr->file, "Failed to lock PD\n");
> -			goto unlock_all;
> -		}
> -
> -		/* Lock the done list */
> -		list_for_each_entry(bo_va, &vm->done, base.vm_status) {
> -			bo = bo_va->base.bo;
> -			if (!bo)
> -				continue;
> -
> -			ret = drm_exec_lock_obj(&exec, &bo->tbo.base);
> -			drm_exec_retry_on_contention(&exec);
> -			if (unlikely(ret))
> -				goto unlock_all;
> -		}
> -	}
> +	int ret;
>   
>   	spin_lock(&vm->status_lock);
> -	while (!list_empty(&vm->moved)) {
> -		bo_va = list_first_entry(&vm->moved, struct amdgpu_bo_va,
> +	while (!list_empty(&vm->invalidated)) {
> +		bo_va = list_first_entry(&vm->invalidated,
> +					 struct amdgpu_bo_va,
>   					 base.vm_status);
>   		spin_unlock(&vm->status_lock);
>   
> -		/* Per VM BOs never need to bo cleared in the page tables */
> +		bo = bo_va->base.bo;
> +		ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
> +		if (unlikely(ret))
> +			return ret;
> +
> +		amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> +		ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +		if (ret)
> +			return ret;
> +
> +		/* This moves the bo_va to the done list */
>   		ret = amdgpu_vm_bo_update(adev, bo_va, false);
>   		if (ret)
> -			goto unlock_all;
> +			return ret;
> +
>   		spin_lock(&vm->status_lock);
>   	}
> +	spin_unlock(&vm->status_lock);
>   
> -	ticket = &exec.ticket;
> -	while (!list_empty(&vm->invalidated)) {
> -		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
> -					 base.vm_status);
> -		resv = bo_va->base.bo->tbo.base.resv;
> -		spin_unlock(&vm->status_lock);
> +	return 0;
> +}
>   
> -		bo = bo_va->base.bo;
> -		ret = amdgpu_userq_validate_vm_bo(NULL, bo);
> -		if (ret) {
> -			drm_file_err(uq_mgr->file, "Failed to validate BO\n");
> -			goto unlock_all;
> -		}
> +static int
> +amdgpu_userq_update_vm(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct amdgpu_vm *vm = &fpriv->vm;
> +	struct drm_exec exec;
> +	int ret;
>   
> -		/* Try to reserve the BO to avoid clearing its ptes */
> -		if (!adev->debug_vm && dma_resv_trylock(resv)) {
> -			clear = false;
> -			unlock = true;
> -		/* The caller is already holding the reservation lock */
> -		} else if (dma_resv_locking_ctx(resv) == ticket) {
> -			clear = false;
> -			unlock = false;
> -		/* Somebody else is using the BO right now */
> -		} else {
> -			clear = true;
> -			unlock = false;
> -		}
> +	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
What difference does this makes changing value from 2 -> 1? Earlier we 
were fixing the slot 2 and now slot 1 ?
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(ret))
> +			goto unlock_all;
>   
> -		ret = amdgpu_vm_bo_update(adev, bo_va, clear);
> +		ret = amdgpu_vm_lock_done(vm, &exec, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(ret))
> +			goto unlock_all;
>   
> -		if (unlock)
> -			dma_resv_unlock(resv);
> -		if (ret)
> +		ret = amdgpu_vm_validate(adev, vm, NULL,
> +					 amdgpu_userq_validate_vm,
> +					 NULL);
> +		if (unlikely(ret))
>   			goto unlock_all;
>   
> -		spin_lock(&vm->status_lock);
> +		ret = amdgpu_userq_validate_bos(adev, &exec, vm);
After moving the invalidated bos to the done list, dont we need to go 
through the done list in the end once more to lock all the bo's that we 
need.
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(ret))
> +			goto unlock_all;
>   	}
> -	spin_unlock(&vm->status_lock);
> +
> +	ret = amdgpu_vm_handle_moved(adev, vm, NULL);
> +	if (ret)
> +		goto unlock_all;
> +
> +	ret = amdgpu_vm_update_pdes(adev, vm, false);
This was missing earlier or was done in any other indirect way ?
> +	if (ret)
> +		goto unlock_all;
>   
>   	ret = amdgpu_eviction_fence_replace_fence(&fpriv->evf_mgr, &exec);
>   	if (ret)
> @@ -667,7 +651,7 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>   
>   	mutex_lock(&uq_mgr->userq_mutex);
>   
> -	ret = amdgpu_userq_validate_bos(uq_mgr);
> +	ret = amdgpu_userq_update_vm(uq_mgr);
>   	if (ret) {
>   		drm_file_err(uq_mgr->file, "Failed to validate BOs to restore\n");
>   		goto unlock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index bf42246a3db2..16451c9bbe1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -484,6 +484,41 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
>   				    2 + num_fences);
>   }
>   
> +/**
> + * amdgpu_vm_lock_done - lock all BOs on the done list
> + * @exec: drm execution context
> + * @num_fences: number of extra fences to reserve
> + *
> + * Lock the BOs on the done list in the DRM execution context.
> + */
> +int amdgpu_vm_lock_done(struct amdgpu_vm *vm, struct drm_exec *exec,
> +			unsigned int num_fences)
num_fence not used and hence should be set as unused.
> +{
> +	struct list_head *prev = &vm->done;
> +	struct amdgpu_bo_va *bo_va;
> +	struct amdgpu_bo *bo;
> +	int ret;
> +
> +	/* We can only trust prev->next while holding the lock */
> +	spin_lock(&vm->status_lock);
> +	while (!list_is_head(prev->next, &vm->done)) {
> +		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
> +		spin_unlock(&vm->status_lock);
> +
> +		bo = bo_va->base.bo;
> +		if (bo) {
> +			ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 1);
> +			if (unlikely(ret))
> +				return ret;
> +		}
> +		spin_lock(&vm->status_lock);
> +		prev = prev->next;
> +	}
> +	spin_unlock(&vm->status_lock);
> +
> +	return 0;
> +}
> +
>   /**
>    * amdgpu_vm_move_to_lru_tail - move all BOs to the end of LRU
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f9549f6b3d1f..0e3884dfdb6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -492,6 +492,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
>   		      unsigned int num_fences);
> +int amdgpu_vm_lock_done(struct amdgpu_vm *vm, struct drm_exec *exec,
> +			unsigned int num_fences);
Since we aren't using them we should set as unused.
Regards
Sunil Khatri
>   bool amdgpu_vm_ready(struct amdgpu_vm *vm);
>   uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
