Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADDBECAAD8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 21:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F8210E421;
	Thu, 22 Sep 2022 21:48:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF8710E421
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 21:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UO4ruCt2Fjgv3PLkbS4QIhulZ/M29LtUYVIjy7nF4Cx72PPGsX5e6hUlADn3/P6uqZJ30AIm2sGtN8ceGIbpM5U//LPKTIEQC3o+NgsPniPRRT7AMcSPEaRdKiACdKgmOmrTUeVZjZDO+JVpJnpkCKYAcUWV1XlobjkSQQctvOP/wEkT9uudm6xvktkr6ke4+VM8teYeASGrP0tWwEE7RFNufu+4bTfNl7XJwBTHxBjJq6N8oMiy9HYJb/kyPpPJQqN6JwLg26nHuVrbwyFL2hZyFlbfMonp4X5TG9MxG+XbZJKHkK6YzQOJQC8Chzz6qigI1eHobZZA6MIN+/7aow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+iC03snK/ruoFk0Zgjtm+KeCv8DKg6Y0DiEcNf1lfU=;
 b=m5pOIv22VGPJlL2wGcWlX5Gbv8vX7xbrzC6LED9brpdR3OAqeRi2w3nung4pYDTnrHfZb3JlOGGsSn9OyKpLuTzQR2QEaP0mKzgsWTLAkcmeVMwXxUZwYFTTt1Za2FPmCgrNqd/P0oQiOf1L38Gg335fUAIn4i5D/gJpQG7Obi8ss4Vg7rErAbGh2gCxcKaqFKG8eh2bSPsdPoDSm12UAHzisfxPHl25cBRWqqDvr9q/hOuyPsNCGR3Zk251MciDyv+pEYYhaC19s1YOsYOVCjkoBzg5ecWECAOPHgvH99sJXF1/Rz26H6+c7xC/lN43PcDiY+hSF9n+mCTkWwUanw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+iC03snK/ruoFk0Zgjtm+KeCv8DKg6Y0DiEcNf1lfU=;
 b=akPsnHFGhBILxZkYwV9wCjTOoca6njsD81U44RRw3TWb4rzc1GlYLrLTk+ZqcE54rQPjFuzjmWzHv16O/Rt36VEzzoMpnS5k2tJyjVIxgkLOBDcUe5syKghKeKjc9DwwGXC7QYHFt7JFup/2jsjHFgHWoxml92TLDQL24dtiYXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Thu, 22 Sep
 2022 21:48:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 21:48:51 +0000
Message-ID: <34dee1bd-f7f6-53a5-668e-2aea9ea37618@amd.com>
Date: Thu, 22 Sep 2022 17:48:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] drm/amdgpu: Enable SA software trap.
Content-Language: en-US
To: David Belanger <david.belanger@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220922213331.1092762-1-david.belanger@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220922213331.1092762-1-david.belanger@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e5ca39-c5cb-46bc-8ebb-08da9ce43c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8pBKfYvIT8rg0op/6zmh5F4Rp/4xva1AEjw4PC846pJvimy+/XB/nkClYOfNvVytpk2ry61CgZfayrauDQidi0U6306kOocXqBKyQ7A8Uy5llWPxrysk8n7p/NgKcB1Hcf6DABABnX/a46v0z8JbUsv+XIOcJxUFI6KiAeDd2JxkUksNcCuY5LO9Mmgood4y0jc0/sMDDSTsztLIWIMdpdMDEaaGIjAXNBoEKJxgFmi35ABqEq8eIkKVZnDXt3nnW6t8k2hSUTGbmatcWVxqbcebHZMWEepM/YtLo2k+2LGECM6Me1MA9ZA5vgfoFa8QFYAUuDpV2B6M/yQBdFMdQ7sA70j8hUGd1i0BGcVFdynQJ9VHxhC7DfIfBZKzafm5yccWOGDtD90H+AQCJnyMdq5djVhS+zxTOfLB4UxtQyucd104xoX1d04nJyXtCw4rf5Qbo17aJ27CRv7bCv846iMMyZuZdvSnr5iP0J/TYlvb9L2CzdGO4UV5bSS1FK+8/eXGWf6GKqqRAsOQu9quyafOtWYcuEc+LXLjkER2eGWwn0fdZfN8In08eOitp+5LH8kKFDTGyC7JIPxVwPj0lCU1kuUF1Mb/qi4beCAMikrqoVs5Zr7bD1WKBotITTzQT+en2pmeUE7BKmHRdVdMZjChK10U4Q40Gn/TPk/pgSQFbi85wHRKLYbCPgArDwIHv+QSiCUiISaCtLPJaMOSTmD9T4UWbm4cTjwAvRkmE/gnQBo5hakf7MBX1pMFMNAxTXJdVtwgfaWH7/DSgdddOGVeh2qZL6haWdL6HCgywjc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199015)(31686004)(83380400001)(2906002)(54906003)(8676002)(66946007)(44832011)(316002)(5660300002)(30864003)(4326008)(66476007)(478600001)(31696002)(6486002)(66556008)(86362001)(8936002)(6506007)(186003)(26005)(6512007)(36756003)(2616005)(41300700001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejN6Umw2Y0h0WEJHSjM1MDArZVhSbFJoY2Y0VjZQV2gyYmlTWFlpWXFWM0R0?=
 =?utf-8?B?a01kMlVBYU04OGo5amE0TWhFaVBKSWJlY0h5TVplQURrK0lMY2hROVcyelZG?=
 =?utf-8?B?MlZidDNMSDhoTHYyanVTVXlxcGdTa29taFAzZHdUalZNSThydkhqR2I2c3Mz?=
 =?utf-8?B?Q2QxWXRYb3ZJdXh3Q3hoZ3RqM1RuaTgycjBPdzhSTXJlTTNLT0NwVHZ5RmZV?=
 =?utf-8?B?UXVwWjl4cDhSZ0g1c3B6NEQzNStndEhrTWxtcEp4LzZzMVpPYytDSHRGYkl0?=
 =?utf-8?B?aHlJbkVpRjA2L1l3ZzFsWmpnVE8rdXR6TVlGNWVnKzh4UWdoZGdlcVYwSWZL?=
 =?utf-8?B?d2lQR05uWEpUN2t1KzJqdXdxTm1FMFRMM2xxWlN1UmVkYVNjeXF0V0VtdVcy?=
 =?utf-8?B?RkUza1ZmL3k5TWpPVlJ1SzkyR21CY3QrOXVsRTEwai9PbDd6L3V0VWhnUFNq?=
 =?utf-8?B?WDBONHNMVitTdlRGdGNRcWdYRzliMGpMMStvUm01NnN6M0EyUzNmbkpKREpC?=
 =?utf-8?B?ZkhkYlM4RElRQzBZZVhkNSs4OVpSU1J3Z0JMa3VVdHZBc1orMGo0aFlNcDhu?=
 =?utf-8?B?WklKY2xFcnB0b0FGMFlGWE42WGRJY3JmcWxYRGFKa1ZTTmgxZ1B0ZEdkWHhu?=
 =?utf-8?B?OWRrcXh6OW5rVGNEU25vUjNPcDNMRnhCUnVMQkZlOWdZSW1ORGRkYTdXSHRC?=
 =?utf-8?B?NjNJajZTUVBsN2FqTDZQUE9aaXJCUlpjMGVGSWZyRFV3d0FkYU4xNjV0OE96?=
 =?utf-8?B?Unh4bGNZM05xYndiNHpYeWQ3bWNPS3o1RmZLWEJzMTVTOXozOGZFREh1TnVI?=
 =?utf-8?B?VVNmUzlpd09pNWZzT29LNVJPZ1pkZjhrMTdDMFg5NjhnQkV5anN5TkU3R3E3?=
 =?utf-8?B?L3REYjlMM05KdFNxOUliZitBZlVGYXkzQVEzd3lsbHRGbXlEOHpFcXpWV3FE?=
 =?utf-8?B?WHE0dlE5bW13MjhhVzdPYjdTVU1KdmtWSVdvdXhoeTdtZ0xra3dSdVFETmdN?=
 =?utf-8?B?MzFNbi9JMWRSWlZBVVBuamtBSkJUQWhlU2J0MkppQVBxTXZRWXlRdU1ON211?=
 =?utf-8?B?allQSG5qTDNSdXpSY3VkQ3FGMzNGTXAvNCs5UFBrU2FpNXFwdE5KUFpUWEdS?=
 =?utf-8?B?ci9jTE9mSThVTjdiMm0wVzlHVzEzSEcxam1ic0MyMW9RY2lJa0tTVWp6dkxp?=
 =?utf-8?B?T2RSUDl4YzU5cjRtQ2NNdEVqSVZrdTZselBDNGNwTnRiN1p6M2w4SytCck1s?=
 =?utf-8?B?enVMbW5aRE12WFF5Y29oby9KYzdXS0JFbGpJR09BcDRWazZJdFBLdm83Mnly?=
 =?utf-8?B?TjZwVEt4T0xWbVNIZVRIQTZjb3huVGQvSjlRdTZpT0hHUTExMWpvNXNmUjdM?=
 =?utf-8?B?RDNKK2c0Y2VkZmN4RGNkVTMxUm9vS2dsOW1ER0xudFMrd0hYYzYxZHErM2pm?=
 =?utf-8?B?czdsQTh1dVNBZmNzUUhpd1I1VWE5WkVyN296N01tNmtsSjJMcFdpRlMreEF2?=
 =?utf-8?B?dklQSmZIajIrUFFoU1ZreW56N1B3clFlV2pFTmhPNlpaRE1JMVU3Q0UwVUJs?=
 =?utf-8?B?cDZ3dXlHeG9QQzZlZllZeWhZVXlvTjBUNC81V2N2WTVkcXZsNlJxTlVNaWhY?=
 =?utf-8?B?TUxJMmZ3aVZWMGdKeXNOYkY5VWZkL1A4SGRHZUFpS2NiZ2dHaDBTNGFVS0dz?=
 =?utf-8?B?Mk96SzhHR0tWTjFCUmpXU3hZY2FjTDVPOGNPUVNnVlFrZHM5N1dtS0t2c0RP?=
 =?utf-8?B?cy9INlFxMFVMY2gveFlOTGxNSDVYa0I4N1V4Z29iQytKR21aQlM1b0NWaXpV?=
 =?utf-8?B?Q3RZd3F4QVpuYzBYMkF3VGlMaFltQmk1SHJ6QWFySmRQb21KMDBnanJ3RHBw?=
 =?utf-8?B?bmJ5MnlMK1B0c1NVT3RlNWNubldQemJyR24wVVRFZVR0M2pjaTFtbVBqRW1k?=
 =?utf-8?B?c2QzQ1o0bVd2VzNQV0gxak9KSDNBeDNFeDdub2lvejQ1b0c3MWpwbk85Y1pX?=
 =?utf-8?B?TGJUZGZLeE9zS1plMXFLZVhOVFgvMUlSQ0FpcXlvTEN5dng2L2R5QVgxTUFh?=
 =?utf-8?B?cjI5MFBkWWpPamRIS21tVWdpakd5U2ZJaTN6ZndvWXdRd2ZuSE9vdm5tWkQ0?=
 =?utf-8?Q?hZb4WKQ56CIPYc6AtysU/mEQT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e5ca39-c5cb-46bc-8ebb-08da9ce43c7d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 21:48:50.9402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOKXbfRGTsSaQLAHZG/Y2jaAjoE3z4gNX8MyIKdhaw18WZMeeInNtolO988Obcxd/nwN0xAWge9aX/9lPQy0tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Jay Cornwall <Jay.Cornwall@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-09-22 um 17:33 schrieb David Belanger:
> Enables support for software trap for MES >= 4.
> Adapted from implementation from Jay Cornwall.
>
> v2: Add IP version check in conditions.
> v3: Remove debugger code changes.
>
> Signed-off-by: Jay Cornwall <Jay.Cornwall@amd.com>
> Signed-off-by: David Belanger <david.belanger@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Looks good to submit to amd-staging-drm-next.

Thanks,
   Felix


> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   6 +-
>   .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 771 +++++++++---------
>   .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |  21 +
>   3 files changed, 413 insertions(+), 385 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index b64cd46a159a..cbc506b958b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -185,7 +185,11 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
>   	mes_add_queue_pkt.trap_handler_addr = input->tba_addr;
>   	mes_add_queue_pkt.tma_addr = input->tma_addr;
>   	mes_add_queue_pkt.is_kfd_process = input->is_kfd_process;
> -	mes_add_queue_pkt.trap_en = 1;
> +
> +	if (!(((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 4) &&
> +		  (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0)) &&
> +		  (adev->ip_versions[GC_HWIP][0] <= IP_VERSION(11, 0, 3))))
> +		mes_add_queue_pkt.trap_en = 1;
>   
>   	return mes_v11_0_submit_pkt_and_poll_completion(mes,
>   			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> index 60a81649cf12..c7118843db05 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> @@ -742,7 +742,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
>   	0xbf88fffe, 0x877aff7f,
>   	0x04000000, 0x8f7a857a,
>   	0x886d7a6d, 0xb97b02dc,
> -	0x8f7b997b, 0xb97a2a05,
> +	0x8f7b997b, 0xb97a3a05,
>   	0x807a817a, 0xbf0d997b,
>   	0xbf850002, 0x8f7a897a,
>   	0xbf820001, 0x8f7a8a7a,
> @@ -819,7 +819,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
>   	0xbefe037c, 0xbefc0370,
>   	0xf4611c7a, 0xf8000000,
>   	0x80708470, 0xbefc037e,
> -	0xb9702a05, 0x80708170,
> +	0xb9703a05, 0x80708170,
>   	0xbf0d9973, 0xbf850002,
>   	0x8f708970, 0xbf820001,
>   	0x8f708a70, 0xb97a1e06,
> @@ -1069,7 +1069,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
>   	0xb9f9f816, 0x876f7bff,
>   	0xfffff800, 0x906f8b6f,
>   	0xb9efa2c3, 0xb9f3f801,
> -	0xb96e2a05, 0x806e816e,
> +	0xb96e3a05, 0x806e816e,
>   	0xbf0d9972, 0xbf850002,
>   	0x8f6e896e, 0xbf820001,
>   	0x8f6e8a6e, 0xb96f1e06,
> @@ -2114,7 +2114,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0x007a0000, 0x7e000280,
>   	0xbefe037a, 0xbeff037b,
>   	0xb97b02dc, 0x8f7b997b,
> -	0xb97a2a05, 0x807a817a,
> +	0xb97a3a05, 0x807a817a,
>   	0xbf0d997b, 0xbf850002,
>   	0x8f7a897a, 0xbf820001,
>   	0x8f7a8a7a, 0xb97b1e06,
> @@ -2157,7 +2157,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0x01000000, 0xe0704100,
>   	0x705d0100, 0xe0704200,
>   	0x705d0200, 0xe0704300,
> -	0x705d0300, 0xb9702a05,
> +	0x705d0300, 0xb9703a05,
>   	0x80708170, 0xbf0d9973,
>   	0xbf850002, 0x8f708970,
>   	0xbf820001, 0x8f708a70,
> @@ -2189,7 +2189,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0xbefe03ff, 0x0000ffff,
>   	0xbeff0380, 0xe0704000,
>   	0x705d0200, 0xbefe03c1,
> -	0xb9702a05, 0x80708170,
> +	0xb9703a05, 0x80708170,
>   	0xbf0d9973, 0xbf850002,
>   	0x8f708970, 0xbf820001,
>   	0x8f708a70, 0xb97a1e06,
> @@ -2475,7 +2475,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0xb9ef4803, 0x876f7bff,
>   	0xfffff800, 0x906f8b6f,
>   	0xb9efa2c3, 0xb9f3f801,
> -	0xb96e2a05, 0x806e816e,
> +	0xb96e3a05, 0x806e816e,
>   	0xbf0d9972, 0xbf850002,
>   	0x8f6e896e, 0xbf820001,
>   	0x8f6e8a6e, 0xb96f1e06,
> @@ -2494,438 +2494,441 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0xbf9f0000, 0xbf9f0000,
>   	0xbf9f0000, 0x00000000,
>   };
> -
>   static const uint32_t cwsr_trap_gfx11_hex[] = {
> -	0xbfa00001, 0xbfa0021b,
> +	0xbfa00001, 0xbfa0021e,
>   	0xb0804006, 0xb8f8f802,
> -	0x91788678, 0xb8fbf803,
> -	0x8b6eff78, 0x00002000,
> -	0xbfa10009, 0x8b6eff6d,
> -	0x00ff0000, 0xbfa2001e,
> -	0x8b6eff7b, 0x00000400,
> -	0xbfa20041, 0xbf830010,
> -	0xb8fbf803, 0xbfa0fffa,
> -	0x8b6eff7b, 0x00000900,
> -	0xbfa20015, 0x8b6eff7b,
> -	0x000071ff, 0xbfa10008,
> -	0x8b6fff7b, 0x00007080,
> -	0xbfa10001, 0xbeee1287,
> -	0xb8eff801, 0x846e8c6e,
> -	0x8b6e6f6e, 0xbfa2000a,
> +	0x9178ff78, 0x00020006,
> +	0xb8fbf803, 0xbf0d9f6d,
> +	0xbfa20006, 0x8b6eff78,
> +	0x00002000, 0xbfa10009,
>   	0x8b6eff6d, 0x00ff0000,
> -	0xbfa20007, 0xb8eef801,
> -	0x8b6eff6e, 0x00000800,
> -	0xbfa20003, 0x8b6eff7b,
> -	0x00000400, 0xbfa20026,
> -	0xbefa4d82, 0xbf89fc07,
> -	0x84fa887a, 0xf4005bbd,
> -	0xf8000010, 0xbf89fc07,
> -	0x846e976e, 0x9177ff77,
> -	0x00800000, 0x8c776e77,
> -	0xf4045bbd, 0xf8000000,
> -	0xbf89fc07, 0xf4045ebd,
> -	0xf8000008, 0xbf89fc07,
> -	0x8bee6e6e, 0xbfa10001,
> -	0xbe80486e, 0x8b6eff6d,
> -	0x01ff0000, 0xbfa20005,
> -	0x8c78ff78, 0x00002000,
> -	0x80ec886c, 0x82ed806d,
> -	0xbfa00005, 0x8b6eff6d,
> -	0x01000000, 0xbfa20002,
> -	0x806c846c, 0x826d806d,
> -	0x8b6dff6d, 0x0000ffff,
> -	0x8bfe7e7e, 0x8bea6a6a,
> -	0xb978f802, 0xbe804a6c,
> -	0x8b6dff6d, 0x0000ffff,
> -	0xbefa0080, 0xb97a0283,
> -	0xbeee007e, 0xbeef007f,
> -	0xbefe0180, 0xbefe4d84,
> -	0xbf89fc07, 0x8b7aff7f,
> -	0x04000000, 0x847a857a,
> -	0x8c6d7a6d, 0xbefa007e,
> -	0x8b7bff7f, 0x0000ffff,
> -	0xbefe00c1, 0xbeff00c1,
> -	0xdca6c000, 0x007a0000,
> -	0x7e000280, 0xbefe007a,
> -	0xbeff007b, 0xb8fb02dc,
> -	0x847b997b, 0xb8fa3b05,
> -	0x807a817a, 0xbf0d997b,
> -	0xbfa20002, 0x847a897a,
> -	0xbfa00001, 0x847a8a7a,
> -	0xb8fb1e06, 0x847b8a7b,
> -	0x807a7b7a, 0x8b7bff7f,
> -	0x0000ffff, 0x807aff7a,
> -	0x00000200, 0x807a7e7a,
> -	0x827b807b, 0xd7610000,
> -	0x00010870, 0xd7610000,
> -	0x00010a71, 0xd7610000,
> -	0x00010c72, 0xd7610000,
> -	0x00010e73, 0xd7610000,
> -	0x00011074, 0xd7610000,
> -	0x00011275, 0xd7610000,
> -	0x00011476, 0xd7610000,
> -	0x00011677, 0xd7610000,
> -	0x00011a79, 0xd7610000,
> -	0x00011c7e, 0xd7610000,
> -	0x00011e7f, 0xbefe00ff,
> -	0x00003fff, 0xbeff0080,
> -	0xdca6c040, 0x007a0000,
> -	0xd760007a, 0x00011d00,
> -	0xd760007b, 0x00011f00,
> +	0xbfa2001e, 0x8b6eff7b,
> +	0x00000400, 0xbfa20041,
> +	0xbf830010, 0xb8fbf803,
> +	0xbfa0fffa, 0x8b6eff7b,
> +	0x00000900, 0xbfa20015,
> +	0x8b6eff7b, 0x000071ff,
> +	0xbfa10008, 0x8b6fff7b,
> +	0x00007080, 0xbfa10001,
> +	0xbeee1287, 0xb8eff801,
> +	0x846e8c6e, 0x8b6e6f6e,
> +	0xbfa2000a, 0x8b6eff6d,
> +	0x00ff0000, 0xbfa20007,
> +	0xb8eef801, 0x8b6eff6e,
> +	0x00000800, 0xbfa20003,
> +	0x8b6eff7b, 0x00000400,
> +	0xbfa20026, 0xbefa4d82,
> +	0xbf89fc07, 0x84fa887a,
> +	0xf4005bbd, 0xf8000010,
> +	0xbf89fc07, 0x846e976e,
> +	0x9177ff77, 0x00800000,
> +	0x8c776e77, 0xf4045bbd,
> +	0xf8000000, 0xbf89fc07,
> +	0xf4045ebd, 0xf8000008,
> +	0xbf89fc07, 0x8bee6e6e,
> +	0xbfa10001, 0xbe80486e,
> +	0x8b6eff6d, 0x01ff0000,
> +	0xbfa20005, 0x8c78ff78,
> +	0x00002000, 0x80ec886c,
> +	0x82ed806d, 0xbfa00005,
> +	0x8b6eff6d, 0x01000000,
> +	0xbfa20002, 0x806c846c,
> +	0x826d806d, 0x8b6dff6d,
> +	0x0000ffff, 0x8bfe7e7e,
> +	0x8bea6a6a, 0xb978f802,
> +	0xbe804a6c, 0x8b6dff6d,
> +	0x0000ffff, 0xbefa0080,
> +	0xb97a0283, 0xbeee007e,
> +	0xbeef007f, 0xbefe0180,
> +	0xbefe4d84, 0xbf89fc07,
> +	0x8b7aff7f, 0x04000000,
> +	0x847a857a, 0x8c6d7a6d,
> +	0xbefa007e, 0x8b7bff7f,
> +	0x0000ffff, 0xbefe00c1,
> +	0xbeff00c1, 0xdca6c000,
> +	0x007a0000, 0x7e000280,
>   	0xbefe007a, 0xbeff007b,
> -	0xbef4007e, 0x8b75ff7f,
> -	0x0000ffff, 0x8c75ff75,
> -	0x00040000, 0xbef60080,
> -	0xbef700ff, 0x10807fac,
> -	0xbef1007d, 0xbef00080,
> -	0xb8f302dc, 0x84739973,
> -	0xbefe00c1, 0x857d9973,
> -	0x8b7d817d, 0xbf06817d,
> -	0xbfa20002, 0xbeff0080,
> -	0xbfa00002, 0xbeff00c1,
> -	0xbfa00009, 0xbef600ff,
> -	0x01000000, 0xe0685080,
> -	0x701d0100, 0xe0685100,
> -	0x701d0200, 0xe0685180,
> -	0x701d0300, 0xbfa00008,
> +	0xb8fb02dc, 0x847b997b,
> +	0xb8fa3b05, 0x807a817a,
> +	0xbf0d997b, 0xbfa20002,
> +	0x847a897a, 0xbfa00001,
> +	0x847a8a7a, 0xb8fb1e06,
> +	0x847b8a7b, 0x807a7b7a,
> +	0x8b7bff7f, 0x0000ffff,
> +	0x807aff7a, 0x00000200,
> +	0x807a7e7a, 0x827b807b,
> +	0xd7610000, 0x00010870,
> +	0xd7610000, 0x00010a71,
> +	0xd7610000, 0x00010c72,
> +	0xd7610000, 0x00010e73,
> +	0xd7610000, 0x00011074,
> +	0xd7610000, 0x00011275,
> +	0xd7610000, 0x00011476,
> +	0xd7610000, 0x00011677,
> +	0xd7610000, 0x00011a79,
> +	0xd7610000, 0x00011c7e,
> +	0xd7610000, 0x00011e7f,
> +	0xbefe00ff, 0x00003fff,
> +	0xbeff0080, 0xdca6c040,
> +	0x007a0000, 0xd760007a,
> +	0x00011d00, 0xd760007b,
> +	0x00011f00, 0xbefe007a,
> +	0xbeff007b, 0xbef4007e,
> +	0x8b75ff7f, 0x0000ffff,
> +	0x8c75ff75, 0x00040000,
> +	0xbef60080, 0xbef700ff,
> +	0x10807fac, 0xbef1007d,
> +	0xbef00080, 0xb8f302dc,
> +	0x84739973, 0xbefe00c1,
> +	0x857d9973, 0x8b7d817d,
> +	0xbf06817d, 0xbfa20002,
> +	0xbeff0080, 0xbfa00002,
> +	0xbeff00c1, 0xbfa00009,
>   	0xbef600ff, 0x01000000,
> -	0xe0685100, 0x701d0100,
> -	0xe0685200, 0x701d0200,
> -	0xe0685300, 0x701d0300,
> +	0xe0685080, 0x701d0100,
> +	0xe0685100, 0x701d0200,
> +	0xe0685180, 0x701d0300,
> +	0xbfa00008, 0xbef600ff,
> +	0x01000000, 0xe0685100,
> +	0x701d0100, 0xe0685200,
> +	0x701d0200, 0xe0685300,
> +	0x701d0300, 0xb8f03b05,
> +	0x80708170, 0xbf0d9973,
> +	0xbfa20002, 0x84708970,
> +	0xbfa00001, 0x84708a70,
> +	0xb8fa1e06, 0x847a8a7a,
> +	0x80707a70, 0x8070ff70,
> +	0x00000200, 0xbef600ff,
> +	0x01000000, 0x7e000280,
> +	0x7e020280, 0x7e040280,
> +	0xbefd0080, 0xd7610002,
> +	0x0000fa71, 0x807d817d,
> +	0xd7610002, 0x0000fa6c,
> +	0x807d817d, 0x917aff6d,
> +	0x80000000, 0xd7610002,
> +	0x0000fa7a, 0x807d817d,
> +	0xd7610002, 0x0000fa6e,
> +	0x807d817d, 0xd7610002,
> +	0x0000fa6f, 0x807d817d,
> +	0xd7610002, 0x0000fa78,
> +	0x807d817d, 0xb8faf803,
> +	0xd7610002, 0x0000fa7a,
> +	0x807d817d, 0xd7610002,
> +	0x0000fa7b, 0x807d817d,
> +	0xb8f1f801, 0xd7610002,
> +	0x0000fa71, 0x807d817d,
> +	0xb8f1f814, 0xd7610002,
> +	0x0000fa71, 0x807d817d,
> +	0xb8f1f815, 0xd7610002,
> +	0x0000fa71, 0x807d817d,
> +	0xbefe00ff, 0x0000ffff,
> +	0xbeff0080, 0xe0685000,
> +	0x701d0200, 0xbefe00c1,
>   	0xb8f03b05, 0x80708170,
>   	0xbf0d9973, 0xbfa20002,
>   	0x84708970, 0xbfa00001,
>   	0x84708a70, 0xb8fa1e06,
>   	0x847a8a7a, 0x80707a70,
> -	0x8070ff70, 0x00000200,
>   	0xbef600ff, 0x01000000,
> -	0x7e000280, 0x7e020280,
> -	0x7e040280, 0xbefd0080,
> -	0xd7610002, 0x0000fa71,
> -	0x807d817d, 0xd7610002,
> -	0x0000fa6c, 0x807d817d,
> -	0x917aff6d, 0x80000000,
> -	0xd7610002, 0x0000fa7a,
> -	0x807d817d, 0xd7610002,
> -	0x0000fa6e, 0x807d817d,
> -	0xd7610002, 0x0000fa6f,
> -	0x807d817d, 0xd7610002,
> -	0x0000fa78, 0x807d817d,
> -	0xb8faf803, 0xd7610002,
> -	0x0000fa7a, 0x807d817d,
> -	0xd7610002, 0x0000fa7b,
> -	0x807d817d, 0xb8f1f801,
> -	0xd7610002, 0x0000fa71,
> -	0x807d817d, 0xb8f1f814,
> -	0xd7610002, 0x0000fa71,
> -	0x807d817d, 0xb8f1f815,
> -	0xd7610002, 0x0000fa71,
> -	0x807d817d, 0xbefe00ff,
> -	0x0000ffff, 0xbeff0080,
> -	0xe0685000, 0x701d0200,
> -	0xbefe00c1, 0xb8f03b05,
> -	0x80708170, 0xbf0d9973,
> -	0xbfa20002, 0x84708970,
> -	0xbfa00001, 0x84708a70,
> -	0xb8fa1e06, 0x847a8a7a,
> -	0x80707a70, 0xbef600ff,
> -	0x01000000, 0xbef90080,
> -	0xbefd0080, 0xbf800000,
> -	0xbe804100, 0xbe824102,
> -	0xbe844104, 0xbe864106,
> -	0xbe884108, 0xbe8a410a,
> -	0xbe8c410c, 0xbe8e410e,
> -	0xd7610002, 0x0000f200,
> -	0x80798179, 0xd7610002,
> -	0x0000f201, 0x80798179,
> -	0xd7610002, 0x0000f202,
> -	0x80798179, 0xd7610002,
> -	0x0000f203, 0x80798179,
> -	0xd7610002, 0x0000f204,
> +	0xbef90080, 0xbefd0080,
> +	0xbf800000, 0xbe804100,
> +	0xbe824102, 0xbe844104,
> +	0xbe864106, 0xbe884108,
> +	0xbe8a410a, 0xbe8c410c,
> +	0xbe8e410e, 0xd7610002,
> +	0x0000f200, 0x80798179,
> +	0xd7610002, 0x0000f201,
>   	0x80798179, 0xd7610002,
> -	0x0000f205, 0x80798179,
> -	0xd7610002, 0x0000f206,
> +	0x0000f202, 0x80798179,
> +	0xd7610002, 0x0000f203,
>   	0x80798179, 0xd7610002,
> -	0x0000f207, 0x80798179,
> -	0xd7610002, 0x0000f208,
> +	0x0000f204, 0x80798179,
> +	0xd7610002, 0x0000f205,
>   	0x80798179, 0xd7610002,
> -	0x0000f209, 0x80798179,
> -	0xd7610002, 0x0000f20a,
> +	0x0000f206, 0x80798179,
> +	0xd7610002, 0x0000f207,
>   	0x80798179, 0xd7610002,
> -	0x0000f20b, 0x80798179,
> -	0xd7610002, 0x0000f20c,
> +	0x0000f208, 0x80798179,
> +	0xd7610002, 0x0000f209,
>   	0x80798179, 0xd7610002,
> -	0x0000f20d, 0x80798179,
> -	0xd7610002, 0x0000f20e,
> +	0x0000f20a, 0x80798179,
> +	0xd7610002, 0x0000f20b,
>   	0x80798179, 0xd7610002,
> -	0x0000f20f, 0x80798179,
> -	0xbf06a079, 0xbfa10006,
> -	0xe0685000, 0x701d0200,
> -	0x8070ff70, 0x00000080,
> -	0xbef90080, 0x7e040280,
> -	0x807d907d, 0xbf0aff7d,
> -	0x00000060, 0xbfa2ffbc,
> -	0xbe804100, 0xbe824102,
> -	0xbe844104, 0xbe864106,
> -	0xbe884108, 0xbe8a410a,
> -	0xd7610002, 0x0000f200,
> +	0x0000f20c, 0x80798179,
> +	0xd7610002, 0x0000f20d,
>   	0x80798179, 0xd7610002,
> -	0x0000f201, 0x80798179,
> -	0xd7610002, 0x0000f202,
> +	0x0000f20e, 0x80798179,
> +	0xd7610002, 0x0000f20f,
> +	0x80798179, 0xbf06a079,
> +	0xbfa10006, 0xe0685000,
> +	0x701d0200, 0x8070ff70,
> +	0x00000080, 0xbef90080,
> +	0x7e040280, 0x807d907d,
> +	0xbf0aff7d, 0x00000060,
> +	0xbfa2ffbc, 0xbe804100,
> +	0xbe824102, 0xbe844104,
> +	0xbe864106, 0xbe884108,
> +	0xbe8a410a, 0xd7610002,
> +	0x0000f200, 0x80798179,
> +	0xd7610002, 0x0000f201,
>   	0x80798179, 0xd7610002,
> -	0x0000f203, 0x80798179,
> -	0xd7610002, 0x0000f204,
> +	0x0000f202, 0x80798179,
> +	0xd7610002, 0x0000f203,
>   	0x80798179, 0xd7610002,
> -	0x0000f205, 0x80798179,
> -	0xd7610002, 0x0000f206,
> +	0x0000f204, 0x80798179,
> +	0xd7610002, 0x0000f205,
>   	0x80798179, 0xd7610002,
> -	0x0000f207, 0x80798179,
> -	0xd7610002, 0x0000f208,
> +	0x0000f206, 0x80798179,
> +	0xd7610002, 0x0000f207,
>   	0x80798179, 0xd7610002,
> -	0x0000f209, 0x80798179,
> -	0xd7610002, 0x0000f20a,
> +	0x0000f208, 0x80798179,
> +	0xd7610002, 0x0000f209,
>   	0x80798179, 0xd7610002,
> -	0x0000f20b, 0x80798179,
> -	0xe0685000, 0x701d0200,
> +	0x0000f20a, 0x80798179,
> +	0xd7610002, 0x0000f20b,
> +	0x80798179, 0xe0685000,
> +	0x701d0200, 0xbefe00c1,
> +	0x857d9973, 0x8b7d817d,
> +	0xbf06817d, 0xbfa20002,
> +	0xbeff0080, 0xbfa00001,
> +	0xbeff00c1, 0xb8fb4306,
> +	0x8b7bc17b, 0xbfa10044,
> +	0xbfbd0000, 0x8b7aff6d,
> +	0x80000000, 0xbfa10040,
> +	0x847b867b, 0x847b827b,
> +	0xbef6007b, 0xb8f03b05,
> +	0x80708170, 0xbf0d9973,
> +	0xbfa20002, 0x84708970,
> +	0xbfa00001, 0x84708a70,
> +	0xb8fa1e06, 0x847a8a7a,
> +	0x80707a70, 0x8070ff70,
> +	0x00000200, 0x8070ff70,
> +	0x00000080, 0xbef600ff,
> +	0x01000000, 0xd71f0000,
> +	0x000100c1, 0xd7200000,
> +	0x000200c1, 0x16000084,
> +	0x857d9973, 0x8b7d817d,
> +	0xbf06817d, 0xbefd0080,
> +	0xbfa20012, 0xbe8300ff,
> +	0x00000080, 0xbf800000,
> +	0xbf800000, 0xbf800000,
> +	0xd8d80000, 0x01000000,
> +	0xbf890000, 0xe0685000,
> +	0x701d0100, 0x807d037d,
> +	0x80700370, 0xd5250000,
> +	0x0001ff00, 0x00000080,
> +	0xbf0a7b7d, 0xbfa2fff4,
> +	0xbfa00011, 0xbe8300ff,
> +	0x00000100, 0xbf800000,
> +	0xbf800000, 0xbf800000,
> +	0xd8d80000, 0x01000000,
> +	0xbf890000, 0xe0685000,
> +	0x701d0100, 0x807d037d,
> +	0x80700370, 0xd5250000,
> +	0x0001ff00, 0x00000100,
> +	0xbf0a7b7d, 0xbfa2fff4,
>   	0xbefe00c1, 0x857d9973,
>   	0x8b7d817d, 0xbf06817d,
> -	0xbfa20002, 0xbeff0080,
> -	0xbfa00001, 0xbeff00c1,
> -	0xb8fb4306, 0x8b7bc17b,
> -	0xbfa10044, 0xbfbd0000,
> -	0x8b7aff6d, 0x80000000,
> -	0xbfa10040, 0x847b867b,
> -	0x847b827b, 0xbef6007b,
> -	0xb8f03b05, 0x80708170,
> -	0xbf0d9973, 0xbfa20002,
> -	0x84708970, 0xbfa00001,
> -	0x84708a70, 0xb8fa1e06,
> -	0x847a8a7a, 0x80707a70,
> -	0x8070ff70, 0x00000200,
> -	0x8070ff70, 0x00000080,
> -	0xbef600ff, 0x01000000,
> -	0xd71f0000, 0x000100c1,
> -	0xd7200000, 0x000200c1,
> -	0x16000084, 0x857d9973,
> +	0xbfa20004, 0xbef000ff,
> +	0x00000200, 0xbeff0080,
> +	0xbfa00003, 0xbef000ff,
> +	0x00000400, 0xbeff00c1,
> +	0xb8fb3b05, 0x807b817b,
> +	0x847b827b, 0x857d9973,
>   	0x8b7d817d, 0xbf06817d,
> -	0xbefd0080, 0xbfa20012,
> -	0xbe8300ff, 0x00000080,
> -	0xbf800000, 0xbf800000,
> -	0xbf800000, 0xd8d80000,
> -	0x01000000, 0xbf890000,
> -	0xe0685000, 0x701d0100,
> -	0x807d037d, 0x80700370,
> -	0xd5250000, 0x0001ff00,
> -	0x00000080, 0xbf0a7b7d,
> -	0xbfa2fff4, 0xbfa00011,
> -	0xbe8300ff, 0x00000100,
> -	0xbf800000, 0xbf800000,
> -	0xbf800000, 0xd8d80000,
> -	0x01000000, 0xbf890000,
> -	0xe0685000, 0x701d0100,
> -	0x807d037d, 0x80700370,
> -	0xd5250000, 0x0001ff00,
> -	0x00000100, 0xbf0a7b7d,
> -	0xbfa2fff4, 0xbefe00c1,
> -	0x857d9973, 0x8b7d817d,
> -	0xbf06817d, 0xbfa20004,
> -	0xbef000ff, 0x00000200,
> -	0xbeff0080, 0xbfa00003,
> -	0xbef000ff, 0x00000400,
> -	0xbeff00c1, 0xb8fb3b05,
> -	0x807b817b, 0x847b827b,
> -	0x857d9973, 0x8b7d817d,
> -	0xbf06817d, 0xbfa20017,
> +	0xbfa20017, 0xbef600ff,
> +	0x01000000, 0xbefd0084,
> +	0xbf0a7b7d, 0xbfa10037,
> +	0x7e008700, 0x7e028701,
> +	0x7e048702, 0x7e068703,
> +	0xe0685000, 0x701d0000,
> +	0xe0685080, 0x701d0100,
> +	0xe0685100, 0x701d0200,
> +	0xe0685180, 0x701d0300,
> +	0x807d847d, 0x8070ff70,
> +	0x00000200, 0xbf0a7b7d,
> +	0xbfa2ffef, 0xbfa00025,
>   	0xbef600ff, 0x01000000,
>   	0xbefd0084, 0xbf0a7b7d,
> -	0xbfa10037, 0x7e008700,
> +	0xbfa10011, 0x7e008700,
>   	0x7e028701, 0x7e048702,
>   	0x7e068703, 0xe0685000,
> -	0x701d0000, 0xe0685080,
> -	0x701d0100, 0xe0685100,
> -	0x701d0200, 0xe0685180,
> +	0x701d0000, 0xe0685100,
> +	0x701d0100, 0xe0685200,
> +	0x701d0200, 0xe0685300,
>   	0x701d0300, 0x807d847d,
> -	0x8070ff70, 0x00000200,
> +	0x8070ff70, 0x00000400,
>   	0xbf0a7b7d, 0xbfa2ffef,
> -	0xbfa00025, 0xbef600ff,
> -	0x01000000, 0xbefd0084,
> -	0xbf0a7b7d, 0xbfa10011,
> -	0x7e008700, 0x7e028701,
> -	0x7e048702, 0x7e068703,
> +	0xb8fb1e06, 0x8b7bc17b,
> +	0xbfa1000c, 0x847b837b,
> +	0x807b7d7b, 0xbefe00c1,
> +	0xbeff0080, 0x7e008700,
>   	0xe0685000, 0x701d0000,
> -	0xe0685100, 0x701d0100,
> -	0xe0685200, 0x701d0200,
> -	0xe0685300, 0x701d0300,
> -	0x807d847d, 0x8070ff70,
> -	0x00000400, 0xbf0a7b7d,
> -	0xbfa2ffef, 0xb8fb1e06,
> -	0x8b7bc17b, 0xbfa1000c,
> -	0x847b837b, 0x807b7d7b,
> -	0xbefe00c1, 0xbeff0080,
> -	0x7e008700, 0xe0685000,
> -	0x701d0000, 0x807d817d,
> -	0x8070ff70, 0x00000080,
> -	0xbf0a7b7d, 0xbfa2fff8,
> -	0xbfa00141, 0xbef4007e,
> -	0x8b75ff7f, 0x0000ffff,
> -	0x8c75ff75, 0x00040000,
> -	0xbef60080, 0xbef700ff,
> -	0x10807fac, 0xb8f202dc,
> -	0x84729972, 0x8b6eff7f,
> -	0x04000000, 0xbfa1003a,
> +	0x807d817d, 0x8070ff70,
> +	0x00000080, 0xbf0a7b7d,
> +	0xbfa2fff8, 0xbfa00146,
> +	0xbef4007e, 0x8b75ff7f,
> +	0x0000ffff, 0x8c75ff75,
> +	0x00040000, 0xbef60080,
> +	0xbef700ff, 0x10807fac,
> +	0xb8f202dc, 0x84729972,
> +	0x8b6eff7f, 0x04000000,
> +	0xbfa1003a, 0xbefe00c1,
> +	0x857d9972, 0x8b7d817d,
> +	0xbf06817d, 0xbfa20002,
> +	0xbeff0080, 0xbfa00001,
> +	0xbeff00c1, 0xb8ef4306,
> +	0x8b6fc16f, 0xbfa1002f,
> +	0x846f866f, 0x846f826f,
> +	0xbef6006f, 0xb8f83b05,
> +	0x80788178, 0xbf0d9972,
> +	0xbfa20002, 0x84788978,
> +	0xbfa00001, 0x84788a78,
> +	0xb8ee1e06, 0x846e8a6e,
> +	0x80786e78, 0x8078ff78,
> +	0x00000200, 0x8078ff78,
> +	0x00000080, 0xbef600ff,
> +	0x01000000, 0x857d9972,
> +	0x8b7d817d, 0xbf06817d,
> +	0xbefd0080, 0xbfa2000c,
> +	0xe0500000, 0x781d0000,
> +	0xbf8903f7, 0xdac00000,
> +	0x00000000, 0x807dff7d,
> +	0x00000080, 0x8078ff78,
> +	0x00000080, 0xbf0a6f7d,
> +	0xbfa2fff5, 0xbfa0000b,
> +	0xe0500000, 0x781d0000,
> +	0xbf8903f7, 0xdac00000,
> +	0x00000000, 0x807dff7d,
> +	0x00000100, 0x8078ff78,
> +	0x00000100, 0xbf0a6f7d,
> +	0xbfa2fff5, 0xbef80080,
>   	0xbefe00c1, 0x857d9972,
>   	0x8b7d817d, 0xbf06817d,
>   	0xbfa20002, 0xbeff0080,
>   	0xbfa00001, 0xbeff00c1,
> -	0xb8ef4306, 0x8b6fc16f,
> -	0xbfa1002f, 0x846f866f,
> -	0x846f826f, 0xbef6006f,
> -	0xb8f83b05, 0x80788178,
> -	0xbf0d9972, 0xbfa20002,
> -	0x84788978, 0xbfa00001,
> -	0x84788a78, 0xb8ee1e06,
> -	0x846e8a6e, 0x80786e78,
> +	0xb8ef3b05, 0x806f816f,
> +	0x846f826f, 0x857d9972,
> +	0x8b7d817d, 0xbf06817d,
> +	0xbfa20024, 0xbef600ff,
> +	0x01000000, 0xbeee0078,
>   	0x8078ff78, 0x00000200,
> -	0x8078ff78, 0x00000080,
> -	0xbef600ff, 0x01000000,
> -	0x857d9972, 0x8b7d817d,
> -	0xbf06817d, 0xbefd0080,
> -	0xbfa2000c, 0xe0500000,
> -	0x781d0000, 0xbf8903f7,
> -	0xdac00000, 0x00000000,
> -	0x807dff7d, 0x00000080,
> -	0x8078ff78, 0x00000080,
> -	0xbf0a6f7d, 0xbfa2fff5,
> -	0xbfa0000b, 0xe0500000,
> -	0x781d0000, 0xbf8903f7,
> -	0xdac00000, 0x00000000,
> -	0x807dff7d, 0x00000100,
> -	0x8078ff78, 0x00000100,
> -	0xbf0a6f7d, 0xbfa2fff5,
> -	0xbef80080, 0xbefe00c1,
> -	0x857d9972, 0x8b7d817d,
> -	0xbf06817d, 0xbfa20002,
> -	0xbeff0080, 0xbfa00001,
> -	0xbeff00c1, 0xb8ef3b05,
> -	0x806f816f, 0x846f826f,
> -	0x857d9972, 0x8b7d817d,
> -	0xbf06817d, 0xbfa20024,
> -	0xbef600ff, 0x01000000,
> -	0xbeee0078, 0x8078ff78,
> -	0x00000200, 0xbefd0084,
> -	0xbf0a6f7d, 0xbfa10050,
> +	0xbefd0084, 0xbf0a6f7d,
> +	0xbfa10050, 0xe0505000,
> +	0x781d0000, 0xe0505080,
> +	0x781d0100, 0xe0505100,
> +	0x781d0200, 0xe0505180,
> +	0x781d0300, 0xbf8903f7,
> +	0x7e008500, 0x7e028501,
> +	0x7e048502, 0x7e068503,
> +	0x807d847d, 0x8078ff78,
> +	0x00000200, 0xbf0a6f7d,
> +	0xbfa2ffee, 0xe0505000,
> +	0x6e1d0000, 0xe0505080,
> +	0x6e1d0100, 0xe0505100,
> +	0x6e1d0200, 0xe0505180,
> +	0x6e1d0300, 0xbf8903f7,
> +	0xbfa00034, 0xbef600ff,
> +	0x01000000, 0xbeee0078,
> +	0x8078ff78, 0x00000400,
> +	0xbefd0084, 0xbf0a6f7d,
> +	0xbfa10012, 0xe0505000,
> +	0x781d0000, 0xe0505100,
> +	0x781d0100, 0xe0505200,
> +	0x781d0200, 0xe0505300,
> +	0x781d0300, 0xbf8903f7,
> +	0x7e008500, 0x7e028501,
> +	0x7e048502, 0x7e068503,
> +	0x807d847d, 0x8078ff78,
> +	0x00000400, 0xbf0a6f7d,
> +	0xbfa2ffee, 0xb8ef1e06,
> +	0x8b6fc16f, 0xbfa1000e,
> +	0x846f836f, 0x806f7d6f,
> +	0xbefe00c1, 0xbeff0080,
>   	0xe0505000, 0x781d0000,
> -	0xe0505080, 0x781d0100,
> -	0xe0505100, 0x781d0200,
> -	0xe0505180, 0x781d0300,
>   	0xbf8903f7, 0x7e008500,
> -	0x7e028501, 0x7e048502,
> -	0x7e068503, 0x807d847d,
> -	0x8078ff78, 0x00000200,
> -	0xbf0a6f7d, 0xbfa2ffee,
> +	0x807d817d, 0x8078ff78,
> +	0x00000080, 0xbf0a6f7d,
> +	0xbfa2fff7, 0xbeff00c1,
>   	0xe0505000, 0x6e1d0000,
> -	0xe0505080, 0x6e1d0100,
> -	0xe0505100, 0x6e1d0200,
> -	0xe0505180, 0x6e1d0300,
> -	0xbf8903f7, 0xbfa00034,
> -	0xbef600ff, 0x01000000,
> -	0xbeee0078, 0x8078ff78,
> -	0x00000400, 0xbefd0084,
> -	0xbf0a6f7d, 0xbfa10012,
> -	0xe0505000, 0x781d0000,
> -	0xe0505100, 0x781d0100,
> -	0xe0505200, 0x781d0200,
> -	0xe0505300, 0x781d0300,
> -	0xbf8903f7, 0x7e008500,
> -	0x7e028501, 0x7e048502,
> -	0x7e068503, 0x807d847d,
> -	0x8078ff78, 0x00000400,
> -	0xbf0a6f7d, 0xbfa2ffee,
> -	0xb8ef1e06, 0x8b6fc16f,
> -	0xbfa1000e, 0x846f836f,
> -	0x806f7d6f, 0xbefe00c1,
> -	0xbeff0080, 0xe0505000,
> -	0x781d0000, 0xbf8903f7,
> -	0x7e008500, 0x807d817d,
> -	0x8078ff78, 0x00000080,
> -	0xbf0a6f7d, 0xbfa2fff7,
> -	0xbeff00c1, 0xe0505000,
> -	0x6e1d0000, 0xe0505100,
> -	0x6e1d0100, 0xe0505200,
> -	0x6e1d0200, 0xe0505300,
> -	0x6e1d0300, 0xbf8903f7,
> +	0xe0505100, 0x6e1d0100,
> +	0xe0505200, 0x6e1d0200,
> +	0xe0505300, 0x6e1d0300,
> +	0xbf8903f7, 0xb8f83b05,
> +	0x80788178, 0xbf0d9972,
> +	0xbfa20002, 0x84788978,
> +	0xbfa00001, 0x84788a78,
> +	0xb8ee1e06, 0x846e8a6e,
> +	0x80786e78, 0x8078ff78,
> +	0x00000200, 0x80f8ff78,
> +	0x00000050, 0xbef600ff,
> +	0x01000000, 0xbefd00ff,
> +	0x0000006c, 0x80f89078,
> +	0xf428403a, 0xf0000000,
> +	0xbf89fc07, 0x80fd847d,
> +	0xbf800000, 0xbe804300,
> +	0xbe824302, 0x80f8a078,
> +	0xf42c403a, 0xf0000000,
> +	0xbf89fc07, 0x80fd887d,
> +	0xbf800000, 0xbe804300,
> +	0xbe824302, 0xbe844304,
> +	0xbe864306, 0x80f8c078,
> +	0xf430403a, 0xf0000000,
> +	0xbf89fc07, 0x80fd907d,
> +	0xbf800000, 0xbe804300,
> +	0xbe824302, 0xbe844304,
> +	0xbe864306, 0xbe884308,
> +	0xbe8a430a, 0xbe8c430c,
> +	0xbe8e430e, 0xbf06807d,
> +	0xbfa1fff0, 0xb980f801,
> +	0x00000000, 0xbfbd0000,
>   	0xb8f83b05, 0x80788178,
>   	0xbf0d9972, 0xbfa20002,
>   	0x84788978, 0xbfa00001,
>   	0x84788a78, 0xb8ee1e06,
>   	0x846e8a6e, 0x80786e78,
>   	0x8078ff78, 0x00000200,
> -	0x80f8ff78, 0x00000050,
>   	0xbef600ff, 0x01000000,
> -	0xbefd00ff, 0x0000006c,
> -	0x80f89078, 0xf428403a,
> -	0xf0000000, 0xbf89fc07,
> -	0x80fd847d, 0xbf800000,
> -	0xbe804300, 0xbe824302,
> -	0x80f8a078, 0xf42c403a,
> -	0xf0000000, 0xbf89fc07,
> -	0x80fd887d, 0xbf800000,
> -	0xbe804300, 0xbe824302,
> -	0xbe844304, 0xbe864306,
> -	0x80f8c078, 0xf430403a,
> -	0xf0000000, 0xbf89fc07,
> -	0x80fd907d, 0xbf800000,
> -	0xbe804300, 0xbe824302,
> -	0xbe844304, 0xbe864306,
> -	0xbe884308, 0xbe8a430a,
> -	0xbe8c430c, 0xbe8e430e,
> -	0xbf06807d, 0xbfa1fff0,
> -	0xb980f801, 0x00000000,
> -	0xbfbd0000, 0xb8f83b05,
> -	0x80788178, 0xbf0d9972,
> -	0xbfa20002, 0x84788978,
> -	0xbfa00001, 0x84788a78,
> -	0xb8ee1e06, 0x846e8a6e,
> -	0x80786e78, 0x8078ff78,
> -	0x00000200, 0xbef600ff,
> -	0x01000000, 0xf4205bfa,
> +	0xf4205bfa, 0xf0000000,
> +	0x80788478, 0xf4205b3a,
>   	0xf0000000, 0x80788478,
> -	0xf4205b3a, 0xf0000000,
> -	0x80788478, 0xf4205b7a,
> +	0xf4205b7a, 0xf0000000,
> +	0x80788478, 0xf4205c3a,
>   	0xf0000000, 0x80788478,
> -	0xf4205c3a, 0xf0000000,
> -	0x80788478, 0xf4205c7a,
> +	0xf4205c7a, 0xf0000000,
> +	0x80788478, 0xf4205eba,
>   	0xf0000000, 0x80788478,
> -	0xf4205eba, 0xf0000000,
> -	0x80788478, 0xf4205efa,
> +	0xf4205efa, 0xf0000000,
> +	0x80788478, 0xf4205e7a,
>   	0xf0000000, 0x80788478,
> -	0xf4205e7a, 0xf0000000,
> -	0x80788478, 0xf4205cfa,
> +	0xf4205cfa, 0xf0000000,
> +	0x80788478, 0xf4205bba,
>   	0xf0000000, 0x80788478,
> +	0xbf89fc07, 0xb96ef814,
>   	0xf4205bba, 0xf0000000,
>   	0x80788478, 0xbf89fc07,
> -	0xb96ef814, 0xf4205bba,
> -	0xf0000000, 0x80788478,
> -	0xbf89fc07, 0xb96ef815,
> -	0xbefd006f, 0xbefe0070,
> -	0xbeff0071, 0x8b6f7bff,
> -	0x000003ff, 0xb96f4803,
> -	0x8b6f7bff, 0xfffff800,
> -	0x856f8b6f, 0xb96fa2c3,
> -	0xb973f801, 0xb8ee3b05,
> -	0x806e816e, 0xbf0d9972,
> -	0xbfa20002, 0x846e896e,
> -	0xbfa00001, 0x846e8a6e,
> -	0xb8ef1e06, 0x846f8a6f,
> -	0x806e6f6e, 0x806eff6e,
> -	0x00000200, 0x806e746e,
> -	0x826f8075, 0x8b6fff6f,
> -	0x0000ffff, 0xf4085c37,
> -	0xf8000050, 0xf4085d37,
> -	0xf8000060, 0xf4005e77,
> -	0xf8000074, 0xbf89fc07,
> -	0x8b6dff6d, 0x0000ffff,
> -	0x8bfe7e7e, 0x8bea6a6a,
> +	0xb96ef815, 0xbefd006f,
> +	0xbefe0070, 0xbeff0071,
> +	0x8b6f7bff, 0x000003ff,
> +	0xb96f4803, 0x8b6f7bff,
> +	0xfffff800, 0x856f8b6f,
> +	0xb96fa2c3, 0xb973f801,
> +	0xb8ee3b05, 0x806e816e,
> +	0xbf0d9972, 0xbfa20002,
> +	0x846e896e, 0xbfa00001,
> +	0x846e8a6e, 0xb8ef1e06,
> +	0x846f8a6f, 0x806e6f6e,
> +	0x806eff6e, 0x00000200,
> +	0x806e746e, 0x826f8075,
> +	0x8b6fff6f, 0x0000ffff,
> +	0xf4085c37, 0xf8000050,
> +	0xf4085d37, 0xf8000060,
> +	0xf4005e77, 0xf8000074,
> +	0xbf89fc07, 0x8b6dff6d,
> +	0x0000ffff, 0x8bfe7e7e,
> +	0x8bea6a6a, 0xb8eef802,
> +	0xbf0d866e, 0xbfa20002,
> +	0xb97af802, 0xbe80486c,
>   	0xb97af802, 0xbe804a6c,
>   	0xbfb00000, 0xbf9f0000,
>   	0xbf9f0000, 0xbf9f0000,
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> index 250ab007399b..0f81670f6f9c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> @@ -43,12 +43,14 @@
>   #define HAVE_XNACK (ASIC_FAMILY < CHIP_SIENNA_CICHLID)
>   #define HAVE_SENDMSG_RTN (ASIC_FAMILY >= CHIP_PLUM_BONITO)
>   #define HAVE_BUFFER_LDS_LOAD (ASIC_FAMILY < CHIP_PLUM_BONITO)
> +#define SW_SA_TRAP (ASIC_FAMILY >= CHIP_PLUM_BONITO)
>   
>   var SINGLE_STEP_MISSED_WORKAROUND		= 1	//workaround for lost MODE.DEBUG_EN exception when SAVECTX raised
>   
>   var SQ_WAVE_STATUS_SPI_PRIO_MASK		= 0x00000006
>   var SQ_WAVE_STATUS_HALT_MASK			= 0x2000
>   var SQ_WAVE_STATUS_ECC_ERR_MASK			= 0x20000
> +var SQ_WAVE_STATUS_TRAP_EN_SHIFT		= 6
>   
>   var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT		= 12
>   var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE		= 9
> @@ -183,6 +185,13 @@ L_SKIP_RESTORE:
>   
>   	s_getreg_b32	s_save_trapsts, hwreg(HW_REG_TRAPSTS)
>   
> +#if SW_SA_TRAP
> +	// If ttmp1[31] is set then trap may occur early.
> +	// Spin wait until SAVECTX exception is raised.
> +	s_bitcmp1_b32	s_save_pc_hi, 31
> +	s_cbranch_scc1  L_CHECK_SAVE
> +#endif
> +
>   	s_and_b32       ttmp2, s_save_status, SQ_WAVE_STATUS_HALT_MASK
>   	s_cbranch_scc0	L_NOT_HALTED
>   
> @@ -1061,8 +1070,20 @@ L_RESTORE_HWREG:
>   	s_and_b32	s_restore_pc_hi, s_restore_pc_hi, 0x0000ffff		//pc[47:32] //Do it here in order not to affect STATUS
>   	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
>   	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
> +
> +#if SW_SA_TRAP
> +	// If traps are enabled then return to the shader with PRIV=0.
> +	// Otherwise retain PRIV=1 for subsequent context save requests.
> +	s_getreg_b32	s_restore_tmp, hwreg(HW_REG_STATUS)
> +	s_bitcmp1_b32	s_restore_tmp, SQ_WAVE_STATUS_TRAP_EN_SHIFT
> +	s_cbranch_scc1	L_RETURN_WITHOUT_PRIV
> +
>   	s_setreg_b32	hwreg(HW_REG_STATUS), s_restore_status			// SCC is included, which is changed by previous salu
> +	s_setpc_b64	[s_restore_pc_lo, s_restore_pc_hi]
> +L_RETURN_WITHOUT_PRIV:
> +#endif
>   
> +	s_setreg_b32	hwreg(HW_REG_STATUS), s_restore_status			// SCC is included, which is changed by previous salu
>   	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
>   
>   L_END_PGM:
