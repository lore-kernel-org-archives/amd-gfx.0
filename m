Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD99C2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 12:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9233E10E856;
	Thu, 15 May 2025 12:11:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="whOz81xR";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ED1710E856
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 12:11:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDHbVdHk/+erEZOPiPpmlIr9UV12aLGcQv2SI/AYof5xDIVD9tYt2zoJz1AeOPZ/JHAf9EmrvIBLO3bZpL1GuEdO860/ABO7JADYd/0PRNcpGmPVcWrg0N/VB5sRMhsKNMjGqniN0pYEh+kOs4qBMBEqfTLtIOt9EF8EhodzBfBzmTfWG7P2ID1YBzCqqPGcgq+JQu24hczxKKJVucVRJ5Ehwv5SOJsb3t9JYWz36ytKReS6GRjmiuVES200+6gf2nvxEdWPTSuvW4YhjzMX4lkV6kspRltEsNxv8/B24vN2ALpl0HOQLA6DpqyMog3xA9CGn+Y06wt8esGZYukUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6nNhAerm6jx4fcGYIxI+b+6DK/AQ9s/k3oHPXQIUV4=;
 b=c51ehar7WLSo265VZbLnc8ozHEwMbv6mSakopqaFo6xbBDy6KoJ/Ec3h3p1rX0vF63+nkI0g+vWHGRRealfAFjHR/SMp+Xxj+qv4rHccO0Als6gJWsFuVmfWKLKdo5WvjmyXRFehXrRX3muO8Dm5dwlwwZzQy+ivnvQf82nl3GxtivsI51YMiThkTJJJmks2xzh8yDIUM6wwCVFIoEl59ZRXz3tkw0F1F6p7vCxxilcV580hzQNZ1BjoQXYLhu50w3mzZ8LhPvt29khjZL31nihC5OjupfGyDZDEQowV2RgDgkffVGdGLuwuFmCb2jxXVeBbrvEc0IDU1xtPXp/umg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6nNhAerm6jx4fcGYIxI+b+6DK/AQ9s/k3oHPXQIUV4=;
 b=whOz81xRE/kLBundxVKzgl/zI0RwQGJbc24wvvjdXj2fuJjO83MR/jKzkO380bx3ztHJ27X3WXfBefVa3Os0tFnjJ2d54/+LvRvTMcXMqqbSl6wldYWlsYvtKsrTBJ2YQAEw8MLyB+pm7y0kWrakJ8oxImH6sem5GAsTgy9lnkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6422.namprd12.prod.outlook.com (2603:10b6:8:b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 12:11:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 12:11:43 +0000
Message-ID: <789dd14a-85bd-485e-a641-f41dd215439d@amd.com>
Date: Thu, 15 May 2025 14:11:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix eviction fence worker race during fd
 close
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250515094758.501650-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250515094758.501650-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0418.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 234c86cc-cf5d-41df-8756-08dd93a9a81f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czhsQngxUHZTckhqZDhSNVlZUUlCdjRVbElicnBnN1BPSFdNVHFvOTRyR1dL?=
 =?utf-8?B?SGJjTk9KcjVVUkFBaE9HZzNlN3dmNXNEZnRPa0dwK2NWV1dyN2hLQUtwenBv?=
 =?utf-8?B?VlhSZjBGbDhCdFcvaTgwTzh6dzZ1WnNOMUNISTgveDkvSjNraTZ5ODEwUzJQ?=
 =?utf-8?B?bnVhNmZDM1JrdnIwT0RzV2tKckdsU1FpNm4xYUFaVW9MNjRZMlA3OVU2T0Ex?=
 =?utf-8?B?L0djVDRmcFFJT0hKS0lsZVFZOE1NTVRhQWdHdVh5V1kyZU1aR1hLS0p2a3Vp?=
 =?utf-8?B?T3hBYkNNejNJbUU1bjRZd2RrT0haVzcvVTFOSmJBOG8zWDJlWXFyN2lYekJy?=
 =?utf-8?B?NG5wbGhVenVJaUhPdFFtbWc4b0IxeFI1bVoxY3NGVUVIQ2I0c3JtYXluSUpD?=
 =?utf-8?B?SEN0TlZoTzJ5eDlSVGtsUWlsTUVwdEFoTjFRdmxWSVEwWWFuRitTUlN4NVBT?=
 =?utf-8?B?QmJqcTc3M1c2U0YvQVpUVC9oOWIwbnFPam5MLzRGNVppMHpueWFlbGJZNHIz?=
 =?utf-8?B?U3Bzb0p0MXQrRHEyNXgzbmxSQVo0Ums3UndJeHZoRDdZblFtTWZUaWNBMHFP?=
 =?utf-8?B?d2RWLzBGSGluUTJ5N2FkSGhPOWI5R0NnWWswbUJpVlpiNVF2QUlJS0drdzJj?=
 =?utf-8?B?RjN1ZkhHM0NtTjVkK1Z0V2JnT05RS3UyM2loQXRXZmp0Um45VzdUbTZVU1ZC?=
 =?utf-8?B?bDEwQkNQZXlWUit4dWtmTlJWWVg4bG5na2JYZnBZanFhczZCTStiK0J4UVB4?=
 =?utf-8?B?YTdLNjZZUzFrOHRubkhTMjY1M1lsTGNRUlRNVWF2U3hDOWEwSUVNaW41REZM?=
 =?utf-8?B?Q1c5ekdEQVpUNE5MOVRsREdLbGloM1U3WG9xajFycU5URjByQ2lYbHdSZG9h?=
 =?utf-8?B?L2hZelk5elVvTFBBWCtqQkhGNlNkOW00YWlhYmdrYlMzYUNzUEI1Zm5SUTZt?=
 =?utf-8?B?RWZIZUIzOC95ZkcyaUtEU01WUjBKMmFuN2w4dmdRRHdEak1JUDJaUU1Fdi9E?=
 =?utf-8?B?VDZPVHRpdkJLVmNiOGJvT0JWcm8wQzhWNjdFd3AvOWQySlh1WmJsaFBDak1m?=
 =?utf-8?B?TjN6YnF5Wk1TbTVNdzJIM0pGSnQ1NlZYS3ppUlRrQlpGZExJTC9tL1RpNTVE?=
 =?utf-8?B?VW9IbjQ3cnI0Z3VIek5iRlhtb2RVaWRZZEFiZDRMSXJWV3NUdnR2eHpydDNX?=
 =?utf-8?B?aml1dEp6b1hQMDhZYnl4dnlKQUJSa3V3NHIyOWNUd3kzckE0Z3ZMM09ITm1v?=
 =?utf-8?B?dDBMbDBTMWFEVmtTOEhPdmpmLzR4VUM5MlhzSWF1QXloeTZFb0oyVHUwVFdy?=
 =?utf-8?B?ZXJVRjVlcXd1VkhlWGhNdWhKYUhTSFhLaDFlVGM4V01EZEFhK3Q5WG5CN2Yx?=
 =?utf-8?B?QXVRWExRcUMvWFlpVlFnOGZ1NFF0UUNtY3VMTWxkaU4vb3d5ZWRvV0gwMGlu?=
 =?utf-8?B?NS9pYmZ3dDVIY2tYeS96eVIzVWN4RlB5ZUNFSGh6TzdERWtScWZTZjN2S1Zl?=
 =?utf-8?B?K0JwOUJtOEkySjBVOWMzamJnRlp3VzFnbHNjWWRXYWlTTEZ3ekZyTHVKYTRJ?=
 =?utf-8?B?S1hyMWU4U1JqclZqaDI4QWpFVjVoTTNlU3hVS2wzcVNXallaTk5UNVJ3SFpl?=
 =?utf-8?B?bTNrVjVLQitDUEtqT2FQaDd5V21nK0hPQ0ZXTDJSZXphdm83REE3UnVhOVYw?=
 =?utf-8?B?RWI0cGR6VTh5djlIS0ROQnVpWlNFTTlxem1Hek1Sc0ZNTjRCZHZtUjFGRm1M?=
 =?utf-8?B?WE43cEZ3UFpVTDJOUERZLzlTbVkzUnZqSXhFMGhZWE5DYUxhZjZvRVlaY212?=
 =?utf-8?B?NmNRM2ZLblNIZHRGTDJuUTZoa0RHY0Z0cHEvanl4TUNGV1dkeFlJQWNaQTFR?=
 =?utf-8?B?QjVtZ21zc0FyMVhyYVVCaUlNdG03NnErTnBzckQ2b0dtaHA2V0lid3ZHZS81?=
 =?utf-8?Q?3eFCF6ibyD8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWRKWUhBUXFETS8rUHBlTVZXQlVWQWJpVlBnMzNVMnF3a3VNZCtOTEtBMUhl?=
 =?utf-8?B?RS9WdmlIWng3NERTNEJmUXhzaGJJNmhZNzdCUmkreVV2K3ZNSVlmN1lpTHZp?=
 =?utf-8?B?WTVYVjRmK2dia2VMWThqbWdoWXVpT2JxemZSMThWRGxWSnFXMFU0SFVvTjYz?=
 =?utf-8?B?cFBHZVRDb2grVTE4eTA2TXVsLzFCOElHMGtTVHBQTVdweGJIYzI4UnEzZ05k?=
 =?utf-8?B?UGhYUVl3eEt3cWZxdjJkRWkyUXNLbkI3YSt5MnZkWXA2VkVURGxLWUNkZGVi?=
 =?utf-8?B?NXQ0Zml2bGZWdDRUeSs3bHhKWDZ0eW1XdnF3RlVWMUhhTDMvTlFHWkY5RjZT?=
 =?utf-8?B?REc1QjVsaTFBL0ZjR1gzSDlFYnFDclJFbHFpUGlIMTY1eVlEdHdWS3c2dVZK?=
 =?utf-8?B?cXQyczU2UVRlMHA5Ymx6SzNvd28xRlpMMDYyUU9KYjBtclFyTHViU2gweVQ3?=
 =?utf-8?B?WnoyQ3FQV3ovTVpaNHBONjNDZTg0THF3MHlFMjZWbEV4Yml5bjFjSnlzVmVT?=
 =?utf-8?B?RmFBcDNCT25SVGhiUFZNTHgwd1cweUpaa21KUjRzUWQ0T0hKTnlhczhyOU1W?=
 =?utf-8?B?SG5qamptY1ZmVVMxU2xvWkMvd1F4TndNUisxNEF4T0RSQnQrZTZRYmdCYWNI?=
 =?utf-8?B?Z0ZjbjJSdkUzVGplWWVuTFllanl5ZWZrMlJqSkV4a0N1WXpLYU42SGlIalhN?=
 =?utf-8?B?WWdBUXlBRzIxb0xPd0ViYVp5eXBieWJPWWxMd3dRK0Y1cW9wT0l2VkdjQnBv?=
 =?utf-8?B?TjdBNTRBU0hsdEp2WHprWVRyN2ZPaVRZeCs0L3JPQURwSE1qZkdzei81YjJt?=
 =?utf-8?B?Ym5vMDlQanZuWS8yWFE3QmpqbWdHM1B1OTZ1SVVaVFlVQldvRDB5dUVwNll2?=
 =?utf-8?B?d1IxcGhzYUhQdmZYd1dQUjJXcmVtUDdkb0gyTXJJMmpXMGZ5Sm14cmhNWHZL?=
 =?utf-8?B?Uks3bFRyNVVyaHM1RXgwWTgrbzVzRmdKN21YTkhRTlc2VVNnRnhBK3pBdlVU?=
 =?utf-8?B?N1NITDJ1b2t5c3VKSTB4TW9OUkhXdERtY3drWlRTekp0ajVHTUdjQk14MlB6?=
 =?utf-8?B?V3ZQbDJkYjkvS1FiQ2hCWFRFM0VEeHlUSGVDdFFsL1hydnh5a1IyZy9XamhS?=
 =?utf-8?B?dXErQkVZZ0RTeElkZXZ1UFR4Nk9iNHpwSGJLVmFrWFl4RjZkOStSMWxIYjlV?=
 =?utf-8?B?WC9ySjZrcFRORkQwRnBSUjJFNXQ1L3l4MGtqTUVvNGQrOUt2R2JxZHQ0ZEJz?=
 =?utf-8?B?Q2UzcUtsZGNKem9Ma2Qrb2Y3YllFbUlFK0lzOVNaTUo3ZDIrNzg2Z1RBWWFF?=
 =?utf-8?B?TERVY1BNM1BkaU4rVkFBWHVwUUNvTkowQjJyOWcwU0xKYjF3WFJKcXkrUng1?=
 =?utf-8?B?bkU2L3BEa281cmwzcWFzN3l5Uzd3SncvQ1diWmtndGZvODVHMkxmL2M1bSt0?=
 =?utf-8?B?QW9ZTmZ5bkJ1VFM1VElkVyt2aDYxdWs1VFlsanpJWkR1cFYvUkUrOVQ5YlRC?=
 =?utf-8?B?bDN0cno2RjVlS1ArNFlobzhlaE9SaTlTRzAybU51NXpJN2NVeWtHMk91RmQ5?=
 =?utf-8?B?WDBtL044ZVVUbFlLbDgvS1E1eTNLMXhaT2RWcnpWSG52Q28rWG5HMmRhMUZh?=
 =?utf-8?B?YzY2QkRibU1tMXJmTzB6YTZRQUp2MEp2OC91VXhXK09odmwrczAwRTVkc1lY?=
 =?utf-8?B?ZE83eVJQZCtHSmJDTm9NRUcwczViRU5nTExzcGJzcXpDM2F5YTBnS2t1VklY?=
 =?utf-8?B?VXJ1TlhMTkdkdjFFdWlzZEZ0VmxvL1JPV2IzeE5XcEZlSElET1FzWDRqSEZT?=
 =?utf-8?B?UEc1SHhlblN2RGxoTjFIUDRKNWg1VGxzcXFObVhYejZ1S2EzVk5TK05aQ1pu?=
 =?utf-8?B?QlErRHJMN1ROVWJnKzl1amE5eWN2QVRjWi9qMnpwSEdjUVpaSGVlTzNUV0g1?=
 =?utf-8?B?eURZUjlPcVlKVGk4TysrUUpuUDJVS0NBQ0ZsNG1nMjdGVXlWbGdHZ2VWdHMx?=
 =?utf-8?B?M3B3WFU1QlhkM0VxZG9wYlZMYVBCNDJCWklWcDJ1bmx4WS80TStDWmtGTnIz?=
 =?utf-8?B?TmtBSkgzYm1LamVhQldVeWlxMG1Paml0RmxWOG10QXcwcXlnb2pacXV6WTds?=
 =?utf-8?Q?JHsGADoweGIll7+q9TQXrmRnx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234c86cc-cf5d-41df-8756-08dd93a9a81f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 12:11:43.8657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XX4rcnBIVMHT6MXd/+d+QhUmNrZLTqCd2Iz1MWZELH/LsScJHZm08ADRXyktm6et
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6422
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

On 5/15/25 11:46, Jesse.Zhang wrote:
> The current cleanup order during file descriptor close can lead to
> a race condition where the eviction fence worker attempts to access
> a destroyed mutex from the user queue manager:
> 
> [  517.294055] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> [  517.294060] WARNING: CPU: 8 PID: 2030 at kernel/locking/mutex.c:564
> [  517.294094] Workqueue: events amdgpu_eviction_fence_suspend_worker [amdgpu]
> 
> The issue occurs because:
> 1. We destroy the user queue manager (including its mutex) first
> 2. Then try to destroy eviction fences which may have pending work
> 3. The eviction fence worker may try to access the already-destroyed mutex
> 
> Fix this by reordering the cleanup to:
> 1. First mark the fd as closing and destroy eviction fences,
>    which flushes any pending work
> 2. Then safely destroy the user queue manager after we're certain
>    no more fence work will be executed
> 
> v2: remove the copy in amdgpu_driver_postclose_kms() (Christian)
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

We should probably clean that up further, but that is unecessary here.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 -----
>  2 files changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4ddd08ce8885..4db92e0a60da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2913,8 +2913,8 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>  
>  	if (fpriv) {
>  		fpriv->evf_mgr.fd_closing = true;
> -		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>  		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
> +		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>  	}
>  
>  	return drm_release(inode, filp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 9fbb04aee97b..d2ce7d86dbc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1502,11 +1502,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  		amdgpu_bo_unreserve(pd);
>  	}
>  
> -	if (!fpriv->evf_mgr.fd_closing) {
> -		fpriv->evf_mgr.fd_closing = true;
> -		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
> -		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
> -	}
>  	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>  	amdgpu_vm_fini(adev, &fpriv->vm);
>  

