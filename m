Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BD0C4320A
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 15:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB07260E97
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 15:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB07260E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49EE36E158;
	Wed, 11 Aug 2021 15:54:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD6F36E158
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 15:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rltrl0OMMERaxST3cCy4WNn+ZZ6ReJDR2Y0LMSyjXgwCX7Vdu1ZlAHPAdxcJ0z8bmJzBOLwdYjkrqjRzl6pNjtHpQz6x1Runs2y2pGh5+hePzwbzES2GV2Y+WHcP8faJ8MMEnH3TlJtXU/APFiCS7Ki+ztskTNIuTtBO5SLCm+Cggfaln7gD6ld8kvWoCtlal7Nos8nqPc1kJMbXk+0SEwcgg7U+pMBg/LtEOyhw754IVWVisjp46rGripudCJG4m5+JLCziNBL99fnN/1ZvnnC6+gRXUDnKgtvGPiBRwNk3ruf94MFgJHrIahbex6+Ko8r3rz1vFT3GR4QmWAW1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seXw8xd8KDGkIKFXu+jaDi4ryZLYk+h7+6fSqcYGk7M=;
 b=d0DoffY+6ZpA8TU8e5jl7t2E3bgdPCgJoRX9lP5p2CN0IhbXKtiZV6cReqPyGc3e4fgKW8I6s4pT14grDA9uxRdWvHeqezL1oVCcm4nj8PX+1wFOWoTMPiIQb5D+dLJm2v+G9QiYpedMCZJE/neuatEZuPBbk4BOboU5E8Eg2p9O0HSnVwyjRHY+FcbxhxpT3ixaEVyjLR2eA8NGcgF6XmFaZfKqI99R6sr4oIELacEPmOMlvWAzNzerpVGR+fk/dJSr8SLc+dn3Cf3NGC2ktbmr8oU/kuV32XoQQplNBgH+QuUU/jnlE22uSd+0Fcmyg232rZ7RHofBMkg7GensiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seXw8xd8KDGkIKFXu+jaDi4ryZLYk+h7+6fSqcYGk7M=;
 b=YjSjEqGwgolCOgffbK4er/eQK4AfJUK5NcsjQQtpowWG1CpGSXEtd2uzTl6d5cPwHRcf8e3YbGPoLFTcT0O6Yq9SU/daAJlFsHLP5S9UjWqsTDfJKeZa4CNUCPhkjBtSTYEKER9z8Uc2noc0+qyD4uYOHpKSCbqLbfpd0hsLHOQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5195.namprd12.prod.outlook.com (2603:10b6:408:11c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Wed, 11 Aug
 2021 15:54:23 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%4]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 15:54:23 +0000
Subject: Re: [PATCH v3] drm/amdkfd: AIP mGPUs best prefetch location for xnack
 on
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210802162806.12631-1-Philip.Yang@amd.com>
 <20210811143557.26042-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <051a03c0-8e80-6e47-c667-52752d51a07d@amd.com>
Date: Wed, 11 Aug 2021 11:54:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210811143557.26042-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.144.73) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend
 Transport; Wed, 11 Aug 2021 15:54:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2b21952-a794-4acc-b6ad-08d95ce04a10
X-MS-TrafficTypeDiagnostic: BN9PR12MB5195:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5195788D67241317840C954B92F89@BN9PR12MB5195.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XAP7l9B9R3j53MuJHoLmlAXBG5GhdEX9oekoAIAVLNE+H2wwFltlbp+1yXGIcEE/TV/O+eXgUFw1Omstfre8+SCWi/NgaJLh0AfzdOhipS2k099CSLyPxtH2LLKilovk9F3zYttjI/EMPIACu1ZIqg9Ai5Vk4w+1C+0ZFUUx5wFjZnRNJZsjeGvhAztx/BksTBb+eJNi7ovUImUhJznEROi3LI1GD6fbI0azrsA1gEYM/ZreeOQFuTXGs1XmeQXzlsadLxGUz2fRSbXgHKvmRkksH1luc9w5sLtghmeWWiDlVXYSe8gcA/6bVTzkfgsTDIa/MZmXAWPunfJwTQcSjR+5GYCAbDq25sDwsppuP+XjUSHMrKKKPzWaU43/IMNfgQ19Usi2ArSDNnUvH/1XsRClj3JbxG1AbJSz6IKrpMkLWcl6PWVmZPFbX7t6DTczOuoAVwcOOwzSx7Fvu3DDG/P0OtlnsyIvOLSelC21SJon/0PHoiQL0mX0/QP2/wW2QDH/OxGO/OQiFKFxe7FVqNimjOGoATwZLsZs4pRY4pGTrtbN/E7mzkoFqccRN+ofhOITqH8M1uw+u4pgspjHl3CPah2cnF1OHIhBlp48QOpQbMZlAt6tG89itEFV49MdU1x3kUQh9cgq5FqgyPanvoLlBb4hWik4u4XnzzdctT6yGOJZoKLf41m7y13W8hUxUkXj/hK8mMVZbNwnvi3fBOYCQLUdPjNaduhaUN4nBF70Yhr4L8hGUxLYQgzIRTh0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(66946007)(316002)(16576012)(38100700002)(66556008)(66476007)(31686004)(2906002)(26005)(5660300002)(186003)(956004)(2616005)(44832011)(478600001)(8936002)(31696002)(6486002)(36756003)(8676002)(86362001)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzN3SWgyemtRRm8yL2o3djg1eTcvSUdmNm4yWmJiL1l2SUhaQW5jaVFWdm9k?=
 =?utf-8?B?bkxMeDZPRTVzVVorUlpsbDc4MEY2dnRyRTg3S29Gb0ZrdEgrc01zdmtEYjlN?=
 =?utf-8?B?dEU1QVAwL2Z0cnk5eThUT0tXMG9PU2JjenhDOEswNFFpaWM4VFUyQUphNkdY?=
 =?utf-8?B?MEdDRVJxdktPM0oxYXMweG5oSW5xbkhnWVVwT3IyM0hVbThFUkpEazdiVito?=
 =?utf-8?B?NUtDSVU4Y1lBU1VKdEhSQSt1ZjRpMmdsTTdVK1RuN2VmQ2c3YU1OdnVZaUZV?=
 =?utf-8?B?Mmxjb2ZIQ3VRRGExZFhjMUI2aXlUQVhwQWN5TTcyejgyVmxQbDNLeVd2Ulhv?=
 =?utf-8?B?WllGaC9HTHpYRnJMK3RhMTliejlISWpXTk9lTWNRM1Eyby9XcjFJR1BWL3Bx?=
 =?utf-8?B?d2FNNUdYTWs2MmY0SUZldW9mZ3FzSVZVcGZISkpPMHpmN05ObEVDemxEQnEv?=
 =?utf-8?B?VTV6VU1FQWw2MHZURlV6aDhHRm11MDNFdVlWOENKTE5la2MvV3ZFa2R2SUxC?=
 =?utf-8?B?cVpHQ29qanpLSllucDFXMEJjVDhqWGRiTk0zS2oxZmd2YWlkL1BEY3Q2dmxh?=
 =?utf-8?B?OUpyZmozc20vTllkN3FERStJNmprcktvVHFGZERNdWRJTFI3dHJFNmNoYWZW?=
 =?utf-8?B?eDM1bE1xMWtvbFgyc0hnb0daSEJHWEdBNnNRZG44Zm93VWRQOCsrTTFCYmdj?=
 =?utf-8?B?U3cwc0FLZlE1SDdlbnY3RStSUWYyVUI4cldHVTFwbUNBYVYxWVRyUy9TczJz?=
 =?utf-8?B?bWNYejYxaElOTWNtcTRQK3U3MDMzTUhNeWNGUFVEaTdNSUFGRUZMdmRTa2Z0?=
 =?utf-8?B?aElmWlBPMVkzcGFHaXdsV2tkbGZwaEtzSEREMGNlZjNFRTFkc3RjRFplWVAz?=
 =?utf-8?B?bjF1Z3I1ZDhuYXlOTVlEMzdlVEFxTzlPZE01KzlSY0h5SFJNRy9xaUt1ODlW?=
 =?utf-8?B?dzRpMlJmWmZUYURYR09VUEFsM211Zzk2cHFlTGJIRjBmb29NdmF4NUlOTXlH?=
 =?utf-8?B?bUF5SWpqL2UvWnZLd3FDOW5HaXRyZ3drYlErOHVEdjN1WGhZZXByakVuNWZp?=
 =?utf-8?B?S2diYlBwSW4vS2VtUlhLZG50UWFGczBkNGRuQnpUUW1xWVduTGFmUGdhVXJB?=
 =?utf-8?B?RExEbzJWTEtROWVWa3FHaGdFQVY2amxIdFZxSmxObmU1eWtsMm1Ib0tUMVds?=
 =?utf-8?B?cGNkbW9BcWpEMndXQUk5UXE1eFBJamFzYVVtQk5ZVWFlTGVDZDlud2tmYWdt?=
 =?utf-8?B?RTdUNC9oQVYrY0JkWXRwRGNrZ1VkbWxka1NvTVdwaDM0ZHNZY1dFekhnallO?=
 =?utf-8?B?aURJR1c4YXJYUlZscmh4WTJuVEZ2SkV3K1VXRzRPWjJEcFE4VW14cXoxSnlG?=
 =?utf-8?B?Z2tsa3oycHNGWUpxdlZadld6OEpwRjYxZ1l4NVRydmxSYkhXeXNOZ1pCNzk1?=
 =?utf-8?B?YVBqY2FwVkN4VS9Yc1UvRDZpR2c4eldrazZwdVo1L1NneVBRaEp6Zlp0aFNP?=
 =?utf-8?B?Uk1zdUVCU2NhSHBoS205TmM3aVBUcXNIY09sVVcrRWpWOTgrMGIxYUZKd2VU?=
 =?utf-8?B?UTBWbUpnV21yODUvTzA5QnNOV2x5YWQvc3orTmNwNUZOM3B5K0dldjVXUjVR?=
 =?utf-8?B?ajk0ejBCRFN3aUhJcGE0dHFKcThTdWY0TUZ5cmRCZXZEMnhFdmJrdFFaUkVr?=
 =?utf-8?B?Ymo5ZVJTdnd4MkdQQWFSUisxSjNBU0FuWTVCR3RIc0lKeld0RC8rVWRhNnZo?=
 =?utf-8?Q?9GhznTNpFL8IcMuKnkJteeI6pNHOOiKtGBHfoG9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b21952-a794-4acc-b6ad-08d95ce04a10
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 15:54:23.5968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WZwx7G4J2JCrd58ASiAWaoCqf1KSupLt50W923/SeP2D9qy8eEB0McfzGgI3MGZE/2w9Y/D48KoMuthjxwDkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5195
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

Am 2021-08-11 um 10:35 a.m. schrieb Philip Yang:
> For xnack on, if range ACCESS or ACCESS_IN_PLACE (AIP) by single GPU, or
> range is ACCESS_IN_PLACE by mGPUs and all mGPUs connection on XGMI same
> hive, the best prefetch location is prefetch_loc GPU. Otherwise, the best
> prefetch location is always CPU because GPU does not have coherent
> mapping VRAM of other GPUs even with large-BAR PCIe connection.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 35 +++++++++++++++-------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index f811a3a24cd2..4cdca8604d69 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2719,22 +2719,26 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>  	return 0;
>  }
>  
> -/* svm_range_best_prefetch_location - decide the best prefetch location
> +/**
> + * svm_range_best_prefetch_location - decide the best prefetch location
>   * @prange: svm range structure
>   *
>   * For xnack off:
> - * If range map to single GPU, the best acutal location is prefetch loc, which
> + * If range map to single GPU, the best prefetch location is prefetch_loc, which
>   * can be CPU or GPU.
>   *
> - * If range map to multiple GPUs, only if mGPU connection on xgmi same hive,
> - * the best actual location could be prefetch_loc GPU. If mGPU connection on
> - * PCIe, the best actual location is always CPU, because GPU cannot access vram
> - * of other GPUs, assuming PCIe small bar (large bar support is not upstream).
> + * If range is ACCESS or ACCESS_IN_PLACE by mGPUs, only if mGPU connection on
> + * XGMI same hive, the best prefetch location is prefetch_loc GPU, othervise
> + * the best prefetch location is always CPU, because GPU can not have coherent
> + * mapping VRAM of other GPUs even with large-BAR PCIe connection.
>   *
>   * For xnack on:
> - * The best actual location is prefetch location. If mGPU connection on xgmi
> - * same hive, range map to multiple GPUs. Otherwise, the range only map to
> - * actual location GPU. Other GPU access vm fault will trigger migration.
> + * If range is not ACCESS_IN_PLACE by mGPUs, the best prefetch location is
> + * prefetch_loc, other GPU access will generate vm fault and trigger migration.
> + *
> + * If range is ACCESS_IN_PLACE by mGPUs, only if mGPU connection on XGMI same
> + * hive, the best prefetch location is prefetch_loc GPU, otherwise the best
> + * prefetch location is always CPU.
>   *
>   * Context: Process context
>   *
> @@ -2754,11 +2758,6 @@ svm_range_best_prefetch_location(struct svm_range *prange)
>  
>  	p = container_of(prange->svms, struct kfd_process, svms);
>  
> -	/* xnack on */
> -	if (p->xnack_enabled)
> -		goto out;
> -
> -	/* xnack off */
>  	if (!best_loc || best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED)
>  		goto out;
>  
> @@ -2768,8 +2767,12 @@ svm_range_best_prefetch_location(struct svm_range *prange)
>  		best_loc = 0;
>  		goto out;
>  	}
> -	bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
> -		  MAX_GPU_INSTANCE);
> +
> +	if (p->xnack_enabled)
> +		bitmap_copy(bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
> +	else
> +		bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
> +			  MAX_GPU_INSTANCE);
>  
>  	for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
>  		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
