Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F35BD6E2B9
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 05:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9837A10E387;
	Wed, 20 Nov 2024 05:43:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bLi4yeFb";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBA8B10E387
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 05:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3TanINWoYlLZQHKTbKng3AV14fIxAe/XWk8OZzsVaohRJLqaHVbQPLmNhbXlSu1y7r9C746elxb+M6zbmAySayvFjzdQfdJNoT4WYH62/1xkMZFoX1mum1fG9RCfcMBXbif58RqyBIBbuPg/mPel6dGua2Qx9XdnooWQut40sR2deNVuVs9KP8CLo1+vwj2u/vEjje4enzlNXoGHBkYwtLB/DTFlRby8xKxfRJycIFwWUNyxiZIViGpgpdW7Q4XE7qbtOlDaMkwa7eOXPM74X+s5ChPb/s4SfI5SpjxtnVfWt/4Dc5BVcEwYjiZQxsOhsO72Atd4YkAvlzoiVbSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RE/PnEnptzjGGTG5HnZTGdRi3pjJGHyne7/M4SdUqEs=;
 b=MquMxiAt5hMT8hMZh2mjDY7PbbTXDr6/2vcWM80nQh3Q+0NhSMUHhrknzqpjEPdEGJ5uBBVOhuYNYdlmNCqYlebu9jYN+Wk+ETh2nd74Uy20JCjmK1gumHIRbtxbYC2nzeA6etTKteesZSNnN7Idd3WxBp8yt+8w4YIAB6eQbvP06hpdqV6Q1SGSa/lfIArf+GaczDw04XEKsSdpVyDbshMA4KAHxJIeaO22qDPN8ZHvgHn2fDd0ikoAbN0VQFW16EBbLbQwpmRnbbcBXh0QSuUDRSQU8KpXUkFe9eMDd66Z8ERyEXk4hEAyQ+l/b92tmYaIOPSoGhWhVkZAEeWlAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RE/PnEnptzjGGTG5HnZTGdRi3pjJGHyne7/M4SdUqEs=;
 b=bLi4yeFbamVO8mMpb0bOy9DA4NtZ+X6SnTjFu9NtCOioPelN4uPCSJjOTMHZnMxyO97tZnoVrluaf+EFT355KrwP9wyZJ46vJQas6yn00fOI8wDBJCW8vBpAEQe65w5qQ89RybAg25y/AIA2oLsd2K0k9Lfkw8BqlPnYg351hpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.24; Wed, 20 Nov 2024 05:43:49 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8182.013; Wed, 20 Nov 2024
 05:43:42 +0000
Message-ID: <cadb2407-7f9c-4850-b8b3-4c9eea91853d@amd.com>
Date: Wed, 20 Nov 2024 11:13:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Prefer RAS recovery for scheduler hang
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Tao.Zhou1@amd.com,
 yipeng.chai@amd.com
References: <20241118054422.3382434-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20241118054422.3382434-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 140dd68e-44d6-42d5-b5a6-08dd09264ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0NGNDk5M0pOQ3J1RTZzQVVQcXFsS3pnR0kwMExHVVVWUVg0cjdtZ2Rkb1pT?=
 =?utf-8?B?T3BHZTRpTis4OXQ2Vzc4aG4rUlNRKzJFSHcvNHJJcFJyUlpYRmpxOCtiejBn?=
 =?utf-8?B?ZGlLZHBuRWVxZmhUQ2xud3JOb0Y0VjJtYUxqSXVVWmRUbVFXVTdPNUZ3Qlds?=
 =?utf-8?B?RFhYK2dPRTVlM1lVVXlJOThMSnJpd3dQVFFvV0h3SDBjdG8vbXlnSTFzTVE4?=
 =?utf-8?B?aUZXbTA2aXY2TXlpcmtuVGl5V3BjaTVxalhDb1NkSi9KeEJKWTRkK0poVXR2?=
 =?utf-8?B?NEMrNFc0c0lwQmpWWnBMQXRYREhoMmE3NUtsMlZuMTQrVGFXYUtabkhsRUp1?=
 =?utf-8?B?Y1F4OHJEUnVuSTduQ2thSEZ1OG04cmlnTzZUdFZ2VnVXNVJWcC9Ob0U0NmNU?=
 =?utf-8?B?YmpPd3pLZEJrK01KYmJoWGo5ME1USlkrU2NXNWpoeHVmamNVT3VYU1F5NTR6?=
 =?utf-8?B?MmtsMDhjbU9FNzhRSkdxMFYxbERHMFQreldDanliMVV6VERLMU5lUXdoaHpI?=
 =?utf-8?B?dGF4cHJmUlNIRjMrTkh3d3dFRjVuZ0VLb1YwbXpuY3ROTmN6TzAva29kelJF?=
 =?utf-8?B?R2dhc2Z2MUE0NXk4VVUyVDVjbGtlOEFqbGJBbW51U2VDWUhUbmhGemRvcTc3?=
 =?utf-8?B?NmlKbEF6c2F1MlVpNXVmNHBrbWxjTmFuWGYxK21jcVBCcHZXT2VzNnA3eldt?=
 =?utf-8?B?enJiRnNaaVpkZWt3dTMxbU9oK3pBWlZnSGNGbGFQZ0dBV283ektNSDB1TzF1?=
 =?utf-8?B?eWFwSWRWR01KQlcyb2t4QzRGS2NDd0d1N0hCMTRkYXh0U2dWcUM4RXdaY2tU?=
 =?utf-8?B?QW13VnpMc0FFdkpSVG41RG1HY1F2aDRvd3RabFl3TExZQjU2RTRvVnFyeGNY?=
 =?utf-8?B?dWQ1YXhFMFBBeXc3ZlhGb0lzeURCRXpuSjMwZFBSUzBHYzlBeklXZUQwSVJh?=
 =?utf-8?B?bnFOenpPdmIyZFRQQ0hIb3ByZ09XV254NUd4Rllka2hQMlM0VVZsTEZPUUZH?=
 =?utf-8?B?SWtxaVpJQWtZbWNQNTMyT014dk1RbnR1aWpuTnQxWUtMV3ZkK1RydzBKVkJM?=
 =?utf-8?B?ZFVWUHhEY3BIbnd2UlF3YXJVTmY3OWJCZHBLZzV1dTlLdzRBcUlmZHQwMm1i?=
 =?utf-8?B?dS9zN1N5QmZ1cWxQaTFEQkJLNVBvNElaU2lLVVdrRWttVm1aZEUyL2JFS3Fq?=
 =?utf-8?B?dVRMSCtxZW5CdXNncVVMc3hYNnIxS08xYkZKamVIajF5b0czczRPUnFZWDFM?=
 =?utf-8?B?b05lbzFveDdHWXdoU0MzVFpFb3ZkYWcxYnhsRWFaTGh5K0NaMHdxb0VXTll6?=
 =?utf-8?B?czE5aVFWNE55OE5Nd0ZaZWNGRVN0TUxCUmpOelhHT05iNVhwem9GeWtDSkpZ?=
 =?utf-8?B?MUFLQ3RKRTNVR01GenZZNFZjcnJ5OFkrRjdxcVdVK09HZjdkM1pZbDJPVFNa?=
 =?utf-8?B?dVlmeURXeTFZMnMvYXd6UnlSLzFiZVhnWVROOGtGNiswREdwbTZ5N2ltbnZy?=
 =?utf-8?B?WVROTjVqQXU5SHllQmQ5R2x2SXZ5UEI0QURjQUgzWTRLVXRHa2E2Ri9ZQlly?=
 =?utf-8?B?ZUdwTTdEanFUVktqQUFQZ0VyNU5rNHpkcG9pcmppczJ1Sk5jT1dmazVyMEhh?=
 =?utf-8?B?VmlhOHU3K2IrbkhGNnRjNCswOTB6aENrWkUzVFFiMFZNQ3l3ZzI2OUZaN0NG?=
 =?utf-8?B?UTRKQlQzM2JxOEFYZFJnekRKU2RJdU1waGVtUDY0eHBnc3B0aVJYNjdDVU91?=
 =?utf-8?Q?Dlu8dDQadM3Tm56ypT1vpRA/DggX2AXXZtVX2Of?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGRDcVhUYTYrcTFxa0lOcTZiNjVpRDZZWURtQmZscnV2YlpURjRHSU9ZTkN3?=
 =?utf-8?B?eEd0ZWRocnZ5aURudS9MZFZnOFB1aDg0UkVla0hadE45UzFEdC9BcXB6akpy?=
 =?utf-8?B?RXYvSHBoTUYramVxRUc1clJnT3NYRGV2Um5xSGN2T2V2M2FTREg3UmdBdGJa?=
 =?utf-8?B?YWRTanVXekNXRTA1RGdiclJBY0hjWVJWcHlra0FaNzF2RXlmZVhzbys1bzc2?=
 =?utf-8?B?UmxVNVpDMnU1SjlBRE5NdVgwMjNRdmplZU9mWkF3Qk1ubVZGVkhpYWFmR2VU?=
 =?utf-8?B?RFNNVVVPZDV5UktPVC9IMWhGbnQyaWorU2V6YmpWamRwSmg0RE5ZcTBLOEpB?=
 =?utf-8?B?WGlaRXRVNjRWaTA0RXNacGY2bnU2TUxBVE5BYlJmaE1wVm0zRHNJdkNnWGoz?=
 =?utf-8?B?L0hKcklxWUgrdmRkanRqNmkzdDE5bndhblVaUU9RNFAweTVMY1NDejVERTV5?=
 =?utf-8?B?TkFvSU14NFNtZjFKYW1hVjg4Y1Frd3Vpb2hTdDd6STVONWc5NWR6VW9va1I0?=
 =?utf-8?B?MS81MlNTY2FmQmhLOUN1Y1NjdzNBRGo1MlVNN0NnNTYrUFNBZjI2Z25Hc3BZ?=
 =?utf-8?B?VWdiSnRBOFZhT1FoNkIvMEhlN3ZTSSt2R2IxQ1pZa0xPeUhBejdvZ0haaEgx?=
 =?utf-8?B?YnBuSWRLaGlrQVFGWitsa2l2dHhZTEJHY1lNZVZZMjFhUkxDeGR0K3hJY290?=
 =?utf-8?B?NE9Ndi9YdHVMVlVwa1VQcXI0dDlkS01JY2NvcUlxSE9PR0xCQnJTb0QvMERt?=
 =?utf-8?B?MlRJQjFTWEpHMUx0T3ZUdGxjVWZmWGdYaXZSMlI4VTUwUzBLdTJra0ExczVt?=
 =?utf-8?B?YkFUaHgwV2lMeThtVHNrVjdTTm9MRCt2S2ZWNUp2NW1uK2VyWkhoejNvMDVN?=
 =?utf-8?B?NkJlUzhScmdvWFNtMlNBUU9XaXdtKzIrbjBPdnI4dEZJL1B6bnVxWVBHWnpI?=
 =?utf-8?B?VjFyZUhMRk0zUnFqMGpvRjZ0c0tJZmw4TDU1cnZzcG9rWHJGQU11QnJVQ3Jo?=
 =?utf-8?B?OVB3YjVNd2EwS05lZHhvTEE5cExYNnlieENmWE9sK3RKMUFVYWgrcCsydWE0?=
 =?utf-8?B?QVU3Z09iUXdDSThJbXZENHpmK24zeEF6WFJ1UWxTOWErL3UySGUrakh6cHIw?=
 =?utf-8?B?RGMwYVlTY1hmYk1MbGFwYjJUN0lGWGxEMzFhWGJlTVAwOXFqdWx4WHhSTUov?=
 =?utf-8?B?TCtXY29zR2JzcC90R0FJdmM0VU4wQUliU2g4dHpLclNmMHVuc3NjdDIvOFRo?=
 =?utf-8?B?OUhqc3dXcG96clM4YWtDNDg4bis1aENsNjlWUjJ2TnBwQW1EeWVRREtJQkpF?=
 =?utf-8?B?S1VycWpJbDBMTDlqYjFtQjdPOGdienE5cUhnalF0SUhLdlNHcjFSbWhPQnVo?=
 =?utf-8?B?ZTQ3Y3J0Zm9adXZqLzhTNEFPT3NUY1VZSW5kOWpmL01HUmxIN1N0NHdkRVMy?=
 =?utf-8?B?ZTRvREUxZktFYzQ4eVppKzRlc3JaZlZnOHg4SWtVSkhGeFE1ejVBZDRJeDR6?=
 =?utf-8?B?Tmx5MEY3aktxRGtUdFpZNC9URmYvOFRrMXJtWXF2WUpnM05sN1F6Z1k5NFIr?=
 =?utf-8?B?aGFPZ3pNZjdFK1l4UlpEdFdZQ0p0eklIUy9TN3pKNkRCZXU1VXBYanIvZUVI?=
 =?utf-8?B?V1lOUXp4b1I2WWZUbHpmWmlMUFFMMEg4aUhEclhPNjFBVHdPTXM2anowTXZH?=
 =?utf-8?B?bmc2c0hIMmpvZ09NWjVzR0RwaDZkOFlTd2NlWkpvR2Q5RkozaitNT0NYMFUx?=
 =?utf-8?B?eG44NUNoSkEwTkxFRnZpWWhvS1NZM2FsSkE3RGRsNUV0NG83N3FnaFJvdi9G?=
 =?utf-8?B?b2xlRlpDejhWODdCMEZGQ2JmcG5yZWNTNG5wSmxEVEpOL1BYT0FHNForNVBJ?=
 =?utf-8?B?ZlYwV2lINFBhMU03S3JVSXo2b2ViSkdGeUtzc0lTdE0wYjF2UlhLSnRmdG5C?=
 =?utf-8?B?dFU3VzQzeWVIcXdFNW9nT0ZoOTcvZ01JRXpqZ0YrWmdkQzBYQXJ4U0tFaGo4?=
 =?utf-8?B?Um5ES2prUzcvZWJTdVN3NkhpL0JhM2R4QVpOempiTkEyYVpBZCtvYUVhZUpX?=
 =?utf-8?B?MHEyRW92bWpsRWd2b0szN3dPb0NJTEhXUmhKV3VQRThzMzd4ckZERnNueUVt?=
 =?utf-8?Q?0V4+lcNTqkENSNgEY8ovzvQVo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140dd68e-44d6-42d5-b5a6-08dd09264ac5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 05:43:42.7922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jx35M94D3U2KDksX2z4uLHE3yqkjrighc8kWk8ecq1g4ZLBCB4QvDaiLLcskV3KD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925
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

<Ping>

On 11/18/2024 11:14 AM, Lijo Lazar wrote:
> Before scheduling a recovery due to scheduler/job hang, check if a RAS
> error is detected. If so, choose RAS recovery to handle the situation. A
> scheduler/job hang could be the side effect of a RAS error. In such
> cases, it is required to go through the RAS error recovery process. A
> RAS error recovery process in certains cases also could avoid a full
> device device reset.
> 
> An error state is maintained in RAS context to detect the block
> affected. Fatal Error state uses unused block id. Set the block id when
> error is detected. If the interrupt handler detected a poison error,
> it's not required to look for a fatal error. Skip fatal error checking
> in such cases.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 15 ++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 55 ++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       | 11 +++-
>  .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |  2 +
>  5 files changed, 78 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index 3a588fecb0c5..6a2fd9e4f470 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -332,6 +332,8 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
>  	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
>  		dev_info(tmp_adev->dev,
>  			 "GPU reset succeeded, trying to resume\n");
> +		/*TBD: Ideally should clear only GFX, SDMA blocks*/
> +		amdgpu_ras_clear_err_state(tmp_adev);
>  		r = aldebaran_mode2_restore_ip(tmp_adev);
>  		if (r)
>  			goto end;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b3ca911e55d6..b4464f42d72a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5165,7 +5165,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>  	if (r)
>  		return r;
>  
> -	amdgpu_ras_set_fed(adev, false);
> +	amdgpu_ras_clear_err_state(adev);
>  	amdgpu_irq_gpu_reset_resume_helper(adev);
>  
>  	/* some sw clean up VF needs to do before recover */
> @@ -5460,7 +5460,7 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
>  		amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_DEFAULT);
>  		if (full_reset) {
>  			/* post card */
> -			amdgpu_ras_set_fed(tmp_adev, false);
> +			amdgpu_ras_clear_err_state(tmp_adev);
>  			r = amdgpu_device_asic_init(tmp_adev);
>  			if (r) {
>  				dev_warn(tmp_adev->dev, "asic atom init failed!");
> @@ -5786,6 +5786,17 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	bool audio_suspended = false;
>  	int retry_limit = AMDGPU_MAX_RETRY_LIMIT;
>  
> +	/*
> +	 * If it reaches here because of hang/timeout and a RAS error is
> +	 * detected at the same time, let RAS recovery take care of it.
> +	 */
> +	if (amdgpu_ras_is_err_state(adev, AMDGPU_RAS_BLOCK__ANY) &&
> +	    reset_context->src != AMDGPU_RESET_SRC_RAS) {
> +		dev_dbg(adev->dev,
> +			"Gpu recovery from source: %d yielding to RAS error recovery handling",
> +			reset_context->src);
> +		return 0;
> +	}
>  	/*
>  	 * Special case: RAS triggered and full reset isn't supported
>  	 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 1bc95b0cdbb8..e31b12144577 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2156,6 +2156,16 @@ void amdgpu_ras_interrupt_fatal_error_handler(struct amdgpu_device *adev)
>  	/* Fatal error events are handled on host side */
>  	if (amdgpu_sriov_vf(adev))
>  		return;
> +	/**
> +	 * If the current interrupt is caused by a non-fatal RAS error, skip
> +	 * check for fatal error. For fatal errors, FED status of all devices
> +	 * in XGMI hive gets set when the first device gets fatal error
> +	 * interrupt. The error gets propagated to other devices as well, so
> +	 * make sure to ack the interrupt regardless of FED status.
> +	 */
> +	if (!amdgpu_ras_get_fed_status(adev) &&
> +	    amdgpu_ras_is_err_state(adev, AMDGPU_RAS_BLOCK__ANY))
> +		return;
>  
>  	if (adev->nbio.ras &&
>  	    adev->nbio.ras->handle_ras_controller_intr_no_bifring)
> @@ -2185,6 +2195,7 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
>  	if (ret)
>  		return;
>  
> +	amdgpu_ras_set_err_poison(adev, block_obj->ras_comm.block);
>  	/* both query_poison_status and handle_poison_consumption are optional,
>  	 * but at least one of them should be implemented if we need poison
>  	 * consumption handler
> @@ -4083,16 +4094,56 @@ bool amdgpu_ras_get_fed_status(struct amdgpu_device *adev)
>  	if (!ras)
>  		return false;
>  
> -	return atomic_read(&ras->fed);
> +	return test_bit(AMDGPU_RAS_BLOCK__LAST, &ras->ras_err_state);
>  }
>  
>  void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status)
>  {
>  	struct amdgpu_ras *ras;
>  
> +	ras = amdgpu_ras_get_context(adev);
> +	if (ras) {
> +		if (status)
> +			set_bit(AMDGPU_RAS_BLOCK__LAST, &ras->ras_err_state);
> +		else
> +			clear_bit(AMDGPU_RAS_BLOCK__LAST, &ras->ras_err_state);
> +	}
> +}
> +
> +void amdgpu_ras_clear_err_state(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ras *ras;
> +
>  	ras = amdgpu_ras_get_context(adev);
>  	if (ras)
> -		atomic_set(&ras->fed, !!status);
> +		ras->ras_err_state = 0;
> +}
> +
> +void amdgpu_ras_set_err_poison(struct amdgpu_device *adev,
> +			       enum amdgpu_ras_block block)
> +{
> +	struct amdgpu_ras *ras;
> +
> +	ras = amdgpu_ras_get_context(adev);
> +	if (ras)
> +		set_bit(block, &ras->ras_err_state);
> +}
> +
> +bool amdgpu_ras_is_err_state(struct amdgpu_device *adev, int block)
> +{
> +	struct amdgpu_ras *ras;
> +
> +	ras = amdgpu_ras_get_context(adev);
> +	if (ras) {
> +		if (block == AMDGPU_RAS_BLOCK__ANY)
> +			return (ras->ras_err_state != 0);
> +		else
> +			return test_bit(block, &ras->ras_err_state) ||
> +			       test_bit(AMDGPU_RAS_BLOCK__LAST,
> +					&ras->ras_err_state);
> +	}
> +
> +	return false;
>  }
>  
>  static struct ras_event_manager *__get_ras_event_mgr(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 6db772ecfee4..b13debcf48ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -99,7 +99,8 @@ enum amdgpu_ras_block {
>  	AMDGPU_RAS_BLOCK__IH,
>  	AMDGPU_RAS_BLOCK__MPIO,
>  
> -	AMDGPU_RAS_BLOCK__LAST
> +	AMDGPU_RAS_BLOCK__LAST,
> +	AMDGPU_RAS_BLOCK__ANY = -1
>  };
>  
>  enum amdgpu_ras_mca_block {
> @@ -558,8 +559,8 @@ struct amdgpu_ras {
>  	struct ras_ecc_log_info  umc_ecc_log;
>  	struct delayed_work page_retirement_dwork;
>  
> -	/* Fatal error detected flag */
> -	atomic_t fed;
> +	/* ras errors detected */
> +	unsigned long ras_err_state;
>  
>  	/* RAS event manager */
>  	struct ras_event_manager __event_mgr;
> @@ -952,6 +953,10 @@ ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attribute *a
>  
>  void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status);
>  bool amdgpu_ras_get_fed_status(struct amdgpu_device *adev);
> +void amdgpu_ras_set_err_poison(struct amdgpu_device *adev,
> +			       enum amdgpu_ras_block block);
> +void amdgpu_ras_clear_err_state(struct amdgpu_device *adev);
> +bool amdgpu_ras_is_err_state(struct amdgpu_device *adev, int block);
>  
>  u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event_type type);
>  int amdgpu_ras_mark_ras_event_caller(struct amdgpu_device *adev, enum ras_event_type type,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index d46a13156ee9..0cb5c582ce7d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -184,6 +184,7 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>  		} else {
>  			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
>  		}
> +		amdgpu_ras_set_err_poison(dev->adev, AMDGPU_RAS_BLOCK__GFX);
>  		break;
>  	case SOC15_IH_CLIENTID_VMC:
>  	case SOC15_IH_CLIENTID_VMC1:
> @@ -213,6 +214,7 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>  		} else {
>  			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
>  		}
> +		amdgpu_ras_set_err_poison(dev->adev, AMDGPU_RAS_BLOCK__SDMA);
>  		break;
>  	default:
>  		dev_warn(dev->adev->dev,
