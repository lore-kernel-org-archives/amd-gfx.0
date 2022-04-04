Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9EDC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Apr 2022 23:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3606010E096;
	Mon,  4 Apr 2022 23:48:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0186510E096
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Apr 2022 23:48:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vd7jM1kg9U4PXpnXsfQswF8JwkiHp6fVrdXP7+uZu5TH+i2hTH33vbK08tiW1wP/MNaskKjIzFMmXPxNOQjISbpo2hzvaOz7eJx0TC3xUwIKJgyUt9UMNhayLXKReEk1hGpIipnNA5snu7HNq6wiAv9YB/Uc+8fNtw7oMMLCuVCDxufmRx7skSgB9uIReXv609Tgtfw5s4S58SDyplIGkU4zAHyv9FtgHuUMy4X/0cUduuiJEaaoqID5dEJSaJLQzzp2jaeoDgY4kzpDbGfccKJk6JvJWNHYPpOnpsTaYReQd7MlXivuIGBbFXMD030UdjgqNBF8r2dkyTkvajIuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfqYAp0nKs2c8NY3D9oiORUbDXFGvmtPRY1MpdOAtVk=;
 b=eqN2MwzOeXSxqTREMNsCHY1Ps595vcyJ8mR0sHtYdm38g0qxXLFxz1qwZSvu1uzL6nJz4KC0tO17Pq3ROq2uWEgh1eUohUCp8Xh9YC4hyUq3z0eYJ+wcvy+wa/VpfZhj/D3JfzZitbsXTRmO2kQoNstR1+bK2TMARC75MVROVDfDycmJ77HMGl9lQAxdq+b/5JuoRCI++5LJLAxeUyMr5GK3jE9VQ1OQafyNKiX4TCoqLeMVXErsKi76LqnrPU2icNbTSvS3I7WbBZn814Bzhn34xWY1HV4kH9lGioorPoJPGvuNm9SlLJ+bG4lt3fuVT7z42Pve8GKkKG4PPMYsLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfqYAp0nKs2c8NY3D9oiORUbDXFGvmtPRY1MpdOAtVk=;
 b=r7rlpBAs5o55gs93h+D4oAJ7ggPj7LmGxaQK2+REEzXoxTwDUN08axwrhrvM8kAWZddn9gMP3w7GlUeyuBYTQJHZI1Rced/4OUL3oQ4K0XpPoTAtQDZY2t4uv9v1XsLo7BQKY/X0TYneeP53O8dPwCc4/OIGJf1pndCYRINus2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (13.101.157.78) by
 DM5PR1201MB0217.namprd12.prod.outlook.com (10.174.106.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Mon, 4 Apr 2022 23:47:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%3]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 23:47:59 +0000
Message-ID: <7721d5ba-6efb-301f-5219-cec6d4da08f3@amd.com>
Date: Mon, 4 Apr 2022 19:47:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] drm/amdkfd: Add missing NULL check in
 svm_range_map_to_gpu
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220404214255.11902-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220404214255.11902-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 255cf83c-4cd3-4686-47d1-08da16958cd7
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0217:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB021778D5440AB4816B13718292E59@DM5PR1201MB0217.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: swZ866WAG7RMygAGk27igcD/Cegi3pPlQ/EiOfqm+WWqE6lacKISqdQJgRpUnJucv6FOffR/jhm5FX6T+gQDBgzH/FuV+XimcaHvlm2lmc2UBKqwTaLICPhn7Pez6JRSCaIyMrdusqbIEIhL0z2ZTo2NHDshEI9wykwTPcQKLW9/a5emgDPRV1KKGu/nj48A3/4wBQzgp3WemjUoxwKtmfTD4ZE6FOIl70egnkbF4UcVtd+M/kb4fbEEU2Z+wqhLsTkxCPSXQXcz4YwJ8ntfM89vgQARJFHCym7Pd0wEqJ77BTEAnYVP/926YdupKFq4U039qCbECP10QnwCWJvGoltxhpdCycaQN8SiMyfgipupy3PJFt/k7izK6imgnranMug6gxkvqcJu7WKU2zWwFsbb0j44uKJLWOzQHCLHY5lMQnTi8OYzg5PTtIPROgU+0pHdOjSEnebsBbiZ8mPlEU01GaYX02YcbL5fySbxGRTzdyQISZKG5OuYyTmlfoNSzJtgBJlqlX9bbPlrgmn87Qwo0GWzETIxGOrl3gS2QExdcwt9dfLKrjNrZf/pvdNX/4diawmd/Va2GaPgR/fT2B1ClPPx0B1hFENX246DXwaTVrKgp71m7qRrXiEGRh6A31MMPdxwtesZTjcf6dZSaIaYsMoYt3F7LAHrPZZKtndlOoGyMgM5VG79vJDTy/QlZ0P3HXyCxTTGLXyzrAKS7C0M4UaQnnnJnh1/WQgzu/WMs5JMk7bt2tGQqwAx6ANg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(4744005)(36756003)(6506007)(5660300002)(8676002)(4326008)(66556008)(66476007)(66946007)(31686004)(83380400001)(316002)(44832011)(6512007)(86362001)(508600001)(38100700002)(8936002)(2616005)(31696002)(6486002)(186003)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkJSbFo2RWNpNlVuVEJXOEJObXZnV1FxRDFYeFB0MUtmNzh6QXV1b3dKcWkr?=
 =?utf-8?B?R2p0VTZhWVhnN1VKQm4vdFlrRGxzZzJmKzNabmwvZ2hMZXdyTDlROUxOTnlz?=
 =?utf-8?B?Q2FPdEF6dENjUkl4U0dma29pSVZ4eXZKVXZjTEk5U2V1aW9EeldCVWowelQy?=
 =?utf-8?B?SE9OZEtETUZJU1NQdi9YYjhPTmFQbjJJSGJPRnRJSVk0TXN5SU52SHNxTUR1?=
 =?utf-8?B?ZHBTUjB5eVhHblVDRDJDc2U2d1NpRUxpZG1mbm1XUi9hOXZCeXA3MmJlRTAx?=
 =?utf-8?B?UzdlWm4xenpSTUpHRVA0eG1Tc0puK01VNzBUb0YwSDMrUUVVTnJCQ0ZaTndt?=
 =?utf-8?B?Tnk2ZFBHOHNGVFpPRWt4THF4OVo5SjBzbGhxdDFNS0lLSDVQbDUrb2NQdWNF?=
 =?utf-8?B?dnR1VDVjbUZsOEFzZjNTTWFaMzljeG5EbWxka2Z0cGJhVkRCNEE0UmlxeDVG?=
 =?utf-8?B?S2s5ckkxZUkvVm91R1Y3dEZlbnp3dC9BUXBNaFpxa0Z4RDZKRjhiRVdjVUcz?=
 =?utf-8?B?VDNZOENDcHRTeEhZSWh3eEhYQVlBSWlUaGdlaVVNaG1PMVZaZG15bjVnRFV2?=
 =?utf-8?B?UlFLSWFYK2hPYnExZkRVSFRXeW9XRGQ2SVRjNHArbXYxTlVSR0RWeUwrUWxu?=
 =?utf-8?B?VVdJbVRjM1dqVnI3bVV1b1JPdDN1Z0dCQldHNW5aanNUdWR6ZU1zR2ZBVzNs?=
 =?utf-8?B?eEkyTkNldkF2MUtBcUxGSU1hb0ZWR1FGOHlLWXRyTnlUQzZqd3hvblh4NTVt?=
 =?utf-8?B?TS9qV09VT3piWXlqcElhL0FuZVA4eWphbFlMczA4b0d3QTdxYSszWEdrc3VU?=
 =?utf-8?B?WldVNnY2MVU4RDkxSXNBancyQjRlVEd0QkdqM1VZb1owcjBPOFF3YTBwdzlC?=
 =?utf-8?B?VU9GbTc1aXFvVzd5aUFsNU9BaXdJSlJtRFIwQUxhKzZLb0FxM1pqYkJRWmRD?=
 =?utf-8?B?Q3NYRlh4ZDhQcWpBcEZKalpINGdQbThqWGxxcjlGVlovRmRYZmp1Nks3WURj?=
 =?utf-8?B?RVVsNzJ1RWwzMGl6SUt4ZHBsYmFqUjlKdUs2UStXZmY5elJOdENjK1hwckNh?=
 =?utf-8?B?Z1hGN0VYWnByMDVkdWtxUy92WWZoVVJRcktvcmx6dTRHd1hmUm9PQ3ZWQ0hr?=
 =?utf-8?B?SnRFQ2g2Wi90dU9PMTMzRnAxTElkZHFHSjhaMDJCNFloWTV0QTVvU3VIWXkz?=
 =?utf-8?B?VFBLenA2eHRNb2I3WkNpa0ZqZ29COWU3alprSnpDWGoyRTQ4Y24xdUhYajEw?=
 =?utf-8?B?T3NKR2VpTGtMRTRiTnBzeG8vTEU4TC9ydTMvaHh1RDBkRXdBWWZGb0hFOFpF?=
 =?utf-8?B?NUlXZlA5bG1JN3pZVjRyS1IrU1RrS0hzSllTTXRlKzNwWmd0M2pLUEZTbGVL?=
 =?utf-8?B?YnNaRFNIY0ZLWHY0VkhsTXpHeHdUSXM4ZE1zK3g0QnJyaCsxdUIrZWZVeVRz?=
 =?utf-8?B?OUhmdHEwMUZRdVhWUzdmR0dhSFFpM1p4NWp4WnVEOVQ2OE5XRzRuWHUvRWpW?=
 =?utf-8?B?OHlvR3dSUndNS0FST0ZVQjQ1MjVYUzkrcDAvL0Z3bWJ6N0N5MEhacmxYRDRh?=
 =?utf-8?B?Qy9yNk95SkhFaEU4MVo3MldnVlVJU0kyMGpHQUlCSFVBQ2VQWUxxSTZSYTZt?=
 =?utf-8?B?YUduL0NoOHZ0eGRvTDBzOEhZSEZScjJNemhtY0lXNmFnc2kvRG1BM29mL1Qv?=
 =?utf-8?B?c1U1SHpOcWZyQW8zOENXYnRtYVVBeWoybmVpa0xqdGRaSkMrbFVoQ0I3WWhz?=
 =?utf-8?B?MllEYjNUU0VORGZ6TStFRUxCNS9XS2ZrSW5MUk1iRnBKUm5FdG03WDUwcFZS?=
 =?utf-8?B?ZTBhOXdQZldrbWFPVzNtbG1Yb3ZJcFh6VzV0RlBscU9HSWhvd254SXNqUjRO?=
 =?utf-8?B?bDNKV1FKMnIzV2ZKRUV4SFZQVDhWR01UbmZ1V0VwZjRFc1BsUnc4MmkvbGNu?=
 =?utf-8?B?WVJFRjM5VUJSUFR2Tnllb0NpRU9mbXpmazFXbm9mdUVZSnFxdVhxcmdrbjR6?=
 =?utf-8?B?bUlRQTQvakNuZmR0REJCZHNOcmVpbG9JTUR4UW1mVFh3VnZoN0RhY1FBL1Mx?=
 =?utf-8?B?MWJoUEZmbjhGbExmcURLOGpoT0NJZDhHQjBVYmJBOTZDcEdzd1QyakIxcmp1?=
 =?utf-8?B?dzNEazZJWTRka3pRdHBVVlRFakY3bXZZdnNIc2psbm5lWU5ZV2hraWEwVGxZ?=
 =?utf-8?B?b0IxOGRTRzQzUTE5TFpPS2Z2LzcxNkZmNE9QaHNqc2VuVUR3YllWdGc2T29V?=
 =?utf-8?B?a2ZpSmNtbXdCdFpIUzhsTy9aeU1RQnJHZi9QTzM2Mkh4TzFKSUlwRldSZGpv?=
 =?utf-8?B?aHRsZTFsQi9jVXlDZ2lHMnVjZDZISEVQTU1tSmZQaVZ1MzlNMGRCZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255cf83c-4cd3-4686-47d1-08da16958cd7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 23:47:59.6765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EU0vRFhvXDnk8yNOJphX8EWSTZQg12JdihViUQAmlIL0yuBQhDVNE1CxvHBzZtB0kVzyS8LjvbqbjuG3nb4LPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0217
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-04-04 um 17:42 schrieb Philip Yang:
> bo_adev is NULL for system memory mapping to GPU.
>
> Fixes: 05fe8eeca92 (drm/amdgpu: fix TLB flushing during eviction)
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 907b02045824..d3fb2d0b5a25 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1281,7 +1281,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   					   last_start, prange->start + i,
>   					   pte_flags,
>   					   last_start - prange->start,
> -					   bo_adev->vm_manager.vram_base_offset,
> +					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
>   					   NULL, dma_addr, &vm->last_update);
>   
>   		for (j = last_start - prange->start; j <= i; j++)
