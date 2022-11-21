Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17B5C43217
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 08:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AAEC10E15C;
	Mon, 21 Nov 2022 08:24:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CCBC10E15C
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 08:24:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0tIv8WAnUnoeFZAO2G/BRr9nN/91n93Ht4Hc4pjCZTyXCgVd+kQZgGacv4Zt/qnWWM95jzSINP+vgO/yTRBu5WNTDKiOWKuz2T4V8Fh5VTQpzcVWmnlGGnfbwH+gx1rgn5J3qBg7QnIK/uSmP0KnHY6kjuubuNHgocaCy1TCSN8WrazrypTvBNYpYq5RUosKBc0wXVCb5kgM2FUsMer/D0muiq6pEj0zXBI9PEjVYdqZ+ET3li1O3jiToG+ywc4SQj/MgOtlEyMcwQ2ZbjyJw7jXS0i4p5BKOBuUl6EU1taasJaFLBYNotvLEqlp5yvAbJQ7gcsX+2l89vAFJBp/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/qGchAiSUxvbhnDrrZjyH/e1pTCFaCzzNkPhk0Lvhg=;
 b=L4ONKe8zo8TwV9kSxnp599QIqfFFIexEACoVJv0S9Aur+0SJmxO1MJbj+x1sS9KgiULSznSg2ndTFar6lQD4DM+U8Hg1rSaihwYvarW9QxkqipRUf1jxw+puLFV1IMt+PUFQI3GMM+gV5UeRRv8t103plzpUqs7Nm/JEuCd66geTNLkPXSsg3/makWZg/lsh8ayw2Kq0JmTgWeEGxt6B2f+ed1VmieknTw+srAIoPUIeoVSq2pHg3btQ/jcUoS/9upBAUlcxAuU8Fkq67wv60jSfKDajnyROxcha8K4WnoUKoy0E89vSMIcRgezNxidJySBWuDlMFeFawOMdEQSXcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/qGchAiSUxvbhnDrrZjyH/e1pTCFaCzzNkPhk0Lvhg=;
 b=ReVm3EugbtCMjO9ZKylevqQuz+YtJ3HdluPuPfokSa1rRKKioq+JOh6tjrjaj5nDOZKsPs5kor7/npAcX5OSbfAyZfG/RR3/BuQ70Gb/6IMccpq+L7tHPbIwkdxrDHkiNtn5MRRslhNUf+z3lNBchzJnfAeHH66ed5VyzSUHHSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Mon, 21 Nov
 2022 08:24:15 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 08:24:14 +0000
Message-ID: <cc27db74-09c4-7b38-f120-acbfa833eca7@amd.com>
Date: Mon, 21 Nov 2022 09:24:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: add drv_vram_usage_va for virt data exchange
Content-Language: en-US
To: Tong Liu01 <Tong.Liu01@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221118025608.612986-1-Tong.Liu01@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221118025608.612986-1-Tong.Liu01@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::22) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f7f6e3-7533-469d-59fc-08dacb99c675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: miNJcEBqnPF/2gZbCSdajIIDO7yiQVZ8K4PuZkROmKThQIamB9nRxy6HG+0wwvjOklvKHNrAN33IZkt/b5K1IsL8SC6KJThQhxRMqDgaT88ZyUVnI3tGyuvUQLCRU86pliGF3og+q2sHgFV5jUskc8Aah4tWbhnL1bnutQbQFATqlC/6fw4ktXKpoNiXQEiDLyKX6sE3efS0CekALsYvsUI9tACU+bGotDbi/C9sA/PBoERmi3nYaOesXgz1yI/gqaBEyI6TdFvt++EYmua2BJWCarWSVKmBarR2t9qo4d9da0PyC/BCNfXaDXIy1f4asU6e5h89SNYyPo8eKWSiEBewvzh6Ff1sSMWmlJ9dIz4RW/ldRr4fXfoiQgvYuEY8RSOc4qvcVouI+RVFqDC8xbD27myGiB5o0fKAtSCxu6fVMdMRohYbJxVvP+kDDsQ67Z30GBuJLur/bCnl9Qn3TU/CpQEYiKhDWWP0FyBYe9XB7/73hXQ/jRqqVvWK25j2yCIUVyGqr8AiTybQ3m7ytN++QAVKBxG/xaUQJaLHjNUEKOGDHqjYymVZFEmfjOip+9bYFDU7l0F1oSC3rBfQUM9yGRUJWpIUgFDx+D/8mgj0YySADeMBuRP5jh07U2VS5KJYQikst9MUvj13f4Fh4/YpdaXhgU3YHX5d2KNuytwPj4B3tJLvRGKkF28DYiHK7BvKit9H8JKCdK96ZnmeTcrOEbIDj7DEUQMZnzbnVfQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199015)(66946007)(6512007)(66556008)(8676002)(66476007)(26005)(6506007)(316002)(4326008)(54906003)(41300700001)(2616005)(36756003)(6666004)(478600001)(6486002)(38100700002)(2906002)(83380400001)(8936002)(186003)(5660300002)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmRkeVg0OHRGUGl3TVVKbVF3dWZoZnpmNHdORWx4YnE5MGRWYXJBRjdPbVpJ?=
 =?utf-8?B?eXVIMGhUZXpyQlhQQjRNZ01MTlZzSnYwUWsrUy9zYUNNM2dTcnZZWldzTlB5?=
 =?utf-8?B?c2crMkhWK2NVblRIdFpTT2dVUkhCbGZRVWNQRlU2MVhDM1pDbzZEZTd6QStG?=
 =?utf-8?B?RGd5dWVYdmhqeWZoYTJIYWtpZXdpaDYxMitrSzdPWU1OWkRqTXlMaUdKS2J5?=
 =?utf-8?B?ekZHRU5DZzNXYVNhV052OW43OERBZk1iZks1RFNPSFh6M0NZOVQ1ci80d3lT?=
 =?utf-8?B?K0NxWWkxL0JQT1N3U256MUQyVlRXc2h5Y3BxeFVhcTVDSHNUVWFKRG54SFNs?=
 =?utf-8?B?a1luN1dNaEkrOHZCaWRvcGYwNVY3SGd4eStSamIzbHJmT05rb0lGcGc2endH?=
 =?utf-8?B?bStSQ1RRTHcwYllKWE1obVgvbFdwQ1JjTXQ2L2VxMnFtb1hlNUduVmtDMkI4?=
 =?utf-8?B?TWlQN3B5UTd1Y21Nam5mUEhNSk50aVBPZ0xYWE5NLytGSG5BM0FyYTJ3c3p0?=
 =?utf-8?B?NUo2Zml5dUVtUVdMSDNCTUNLL2VBNC9FVnppUHpvQjFsTVhPL1hKUUJoc2Vj?=
 =?utf-8?B?U29vWGIyMVdnNmR3U3RnUk5EQnVvaVpTN282TEdJZjlMZEJ1UEN3YzZ4YlVQ?=
 =?utf-8?B?UHBZbTd3UmMxUW5obGhVNEVWZVI3cDZhWDc3TG4yMWw0ajlwL3ZuNUk3TzJh?=
 =?utf-8?B?TTRucDIyL0pzRWR2UGxmNzkvWDhXaVJubWNnTXc4Vzl5ZklJU3VjQ3pua0tl?=
 =?utf-8?B?eFhZMEs4L2F6ckdENnN1R002OHBrMUZDZjFxNzV3V2NKME9oV0pKYUtLWHdV?=
 =?utf-8?B?cUs3MEhEYjNGZ2xsNGNhVU5UWVgrSVZVN2dtR01CczhNYytWU2RYeEFMVytq?=
 =?utf-8?B?NnlRQjlISFRXL1Mvc1lLV3R2MUNLWEg3d3VYT25tTjB1MjZPNnd2WFRTV1lj?=
 =?utf-8?B?eG9RNnJVU0VQanVQSmp4OERhUlprcEc4MWk2NW5URjEwdzUzaGl2dkFDdmV1?=
 =?utf-8?B?WW8xaUphUFM3bTJtYzh3c1o2NWVDOGM3Q3pwZHZDaWwzVDdTQUdlM1VjYVVL?=
 =?utf-8?B?TkllcG1tc3V6Nyt4eURsOGZWamJ6dkpVVzAyUXBBM1drblNNUDNUVm5PQjls?=
 =?utf-8?B?a2lmZmhYSjJEM2RheFVHZTFSMmFleHMwQmV0allHckVJVEE1UWI2dXFsV1Fx?=
 =?utf-8?B?SkU4K2YyK3lGMTQ3QUJla3Jva1FycXVCN1d2WmRQa2dzWDg1SmZ2RUZZbnJE?=
 =?utf-8?B?L0g1OTNQQlI5S3pmSXZBaEw1ZkE3RkpXQUFnays4YXAyeGlFWGpuYU9VbTQv?=
 =?utf-8?B?KzBLSWkzRkFlN1JzQ3F1bHBQUTIxVXZrUHMyZWNlSjVoL2w1S2t0RWozZmJU?=
 =?utf-8?B?aGx5MnlWS3ozZ0lsTHhjREtLeWVoTkErRzFveExzd2g2UnlhMUU0OUpkcnNm?=
 =?utf-8?B?eTdzWHlHUUsvWHRJMGtJZzArMFZnNHZBVEJ4VHpWWXpXcXBVcEhUbGc2cFFN?=
 =?utf-8?B?SlRJQ1VxZ3VaRHlrNCt6Ri92TDl3QlFzTytGbmpzS0xMWG1IWkxFYjFtYzlR?=
 =?utf-8?B?SHYzaUhKSC9zYUhXWWNUSmhaZFAvRTYxclAxWTlreGxWOStBODBBVWtTcGpz?=
 =?utf-8?B?VG5FeGZncUJRbjlFS2h4eDNFQVY0dGFTTnBmdFRVZ3hERWh0bkpXSTJ3Yi9O?=
 =?utf-8?B?V2xpQkFBZEtiR2tXdkgzN2F0R0IzTnRSZE0zSkdST00ycjJSR05LZWpwRFoy?=
 =?utf-8?B?ekRGQlRTZzRNTmhRUUV5S3FHQzE5dUFYVDRJK1duN3FVQm95TldqSStzZmpJ?=
 =?utf-8?B?V25peXBjRXBaRXduWDlweTlGc3pBYjNQUU95aitpeExnZ2ovdlE2V29OVjM0?=
 =?utf-8?B?R2lZMjRJVDNEdWZxajQ0V1czWHkzNjRQVnRvejVwUnFSNTlkRk10em1hL2FV?=
 =?utf-8?B?MlloMnk3WDRPR0NnT1NuR2ZDeFpNUUVwQW56UEhtcnJiQnd2Rkp5LytPYjBT?=
 =?utf-8?B?dzVGckI2Tk9lNkJENlZDZnk0ZXArZHE0Ni81NGhCNmcvb1NrbVFWOWQ0RkZW?=
 =?utf-8?B?d1l3YUxIb1Y0bWJwMzNRSm5HTDdHK1VncE90ZmRtSDRBSWI1VGJSSzBrTWxT?=
 =?utf-8?Q?MrM7Z5inpVTaNlkCUoSu9i/we?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f7f6e3-7533-469d-59fc-08dacb99c675
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 08:24:14.9173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjZWknkb+DW5sGlh0TtaPBzIje83kbe99uuIXCR6h7oPoPS58je6SvddFzhmar3o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, yifan.zha@amd.com,
 Evan Quan <Evan.Quan@amd.com>, Monk Liu <Monk.Liu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.11.22 um 03:56 schrieb Tong Liu01:
> For vram_usagebyfirmware_v2_2, fw_vram_reserve is not used. So
> fw_vram_usage_va is NULL, and cannot do virt data exchange
> anymore. Should add drv_vram_usage_va to do virt data exchange
> in vram_usagebyfirmware_v2_2 case. And refine some code style
> checks in pre add vram reservation logic patch
>
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 16 ++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 59 +++++++++++++------
>   4 files changed, 54 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 9b97fa39d47a..e40df72c138a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -104,7 +104,7 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev)
>   static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
>   	struct vram_usagebyfirmware_v2_1 *fw_usage, int *usage_bytes)
>   {
> -	uint32_t start_addr, fw_size, drv_size;
> +	u32 start_addr, fw_size, drv_size;
>   
>   	start_addr = le32_to_cpu(fw_usage->start_address_in_kb);
>   	fw_size = le16_to_cpu(fw_usage->used_by_firmware_in_kb);
> @@ -116,7 +116,7 @@ static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
>   			  drv_size);
>   
>   	if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
> -		(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
> +		(u32)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>   		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
>   		/* Firmware request VRAM reservation for SR-IOV */
>   		adev->mman.fw_vram_usage_start_offset = (start_addr &
> @@ -133,7 +133,7 @@ static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
>   static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
>   		struct vram_usagebyfirmware_v2_2 *fw_usage, int *usage_bytes)
>   {
> -	uint32_t fw_start_addr, fw_size, drv_start_addr, drv_size;
> +	u32 fw_start_addr, fw_size, drv_start_addr, drv_size;
>   
>   	fw_start_addr = le32_to_cpu(fw_usage->fw_region_start_address_in_kb);
>   	fw_size = le16_to_cpu(fw_usage->used_by_firmware_in_kb);
> @@ -147,14 +147,16 @@ static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
>   			  drv_start_addr,
>   			  drv_size);
>   
> -	if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
> +	if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
> +		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0) {
>   		/* Firmware request VRAM reservation for SR-IOV */
>   		adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
>   			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>   		adev->mman.fw_vram_usage_size = fw_size << 10;
>   	}
>   
> -	if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
> +	if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
> +		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0) {
>   		/* driver request VRAM reservation for SR-IOV */
>   		adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
>   			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> @@ -172,8 +174,8 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
>   						vram_usagebyfirmware);
>   	struct vram_usagebyfirmware_v2_1 *fw_usage_v2_1;
>   	struct vram_usagebyfirmware_v2_2 *fw_usage_v2_2;
> -	uint16_t data_offset;
> -	uint8_t frev, crev;
> +	u16 data_offset;
> +	u8 frev, crev;
>   	int usage_bytes = 0;
>   
>   	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 52f2282411cb..dd8b6a11db9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1570,7 +1570,7 @@ static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device *adev)
>   {
>   	amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
>   						  NULL,
> -						  NULL);
> +						  &adev->mman.drv_vram_usage_va);

Your indentations of the second like with "if"s and function parameters 
like here still looks completely off.

>   }
>   
>   /**
> @@ -1608,8 +1608,9 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>    */
>   static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
>   {
> -	uint64_t vram_size = adev->gmc.visible_vram_size;
> +	u64 vram_size = adev->gmc.visible_vram_size;
>   
> +	adev->mman.drv_vram_usage_va = NULL;
>   	adev->mman.drv_vram_usage_reserved_bo = NULL;
>   
>   	if (adev->mman.drv_vram_usage_size == 0 ||
> @@ -1621,7 +1622,7 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
>   					  adev->mman.drv_vram_usage_size,
>   					  AMDGPU_GEM_DOMAIN_VRAM,
>   					  &adev->mman.drv_vram_usage_reserved_bo,
> -					  NULL);
> +					  &adev->mman.drv_vram_usage_va);
>   }
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index b391c8d076ff..b4d8ba2789f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -90,6 +90,7 @@ struct amdgpu_mman {
>   	u64		drv_vram_usage_start_offset;
>   	u64		drv_vram_usage_size;
>   	struct amdgpu_bo	*drv_vram_usage_reserved_bo;
> +	void		*drv_vram_usage_va;
>   
>   	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>   	struct amdgpu_bo	*sdma_access_bo;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index a226a6c48fb7..e80033e24d48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -428,11 +428,18 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
>   	struct eeprom_table_record bp;
>   	uint64_t retired_page;
>   	uint32_t bp_idx, bp_cnt;
> +	void *vram_usage_va = NULL;
> +
> +	if (adev->mman.fw_vram_usage_va != NULL) {
> +		vram_usage_va = adev->mman.fw_vram_usage_va;
> +	} else {
> +		vram_usage_va = adev->mman.drv_vram_usage_va;
> +	}

Please no {} for single line "if"s.

Apart from that looks sane of hand, but I'm not the right person to 
fully judge the technical implementation.

Luben can you tale a look as well?

Thanks,
Christian.

>   
>   	if (bp_block_size) {
>   		bp_cnt = bp_block_size / sizeof(uint64_t);
>   		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
> -			retired_page = *(uint64_t *)(adev->mman.fw_vram_usage_va +
> +			retired_page = *(uint64_t *)(vram_usage_va +
>   					bp_block_offset + bp_idx * sizeof(uint64_t));
>   			bp.retired_page = retired_page;
>   
> @@ -643,7 +650,11 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
>   	adev->virt.fw_reserve.p_vf2pf = NULL;
>   	adev->virt.vf2pf_update_interval_ms = 0;
>   
> -	if (adev->mman.fw_vram_usage_va != NULL) {
> +	if (adev->mman.fw_vram_usage_va != NULL &&
> +		adev->mman.drv_vram_usage_va != NULL) {
> +		DRM_WARN("Currently fw_vram and drv_vram should not have values at the same time!");
> +	} else if (adev->mman.fw_vram_usage_va != NULL ||
> +		adev->mman.drv_vram_usage_va != NULL) {
>   		/* go through this logic in ip_init and reset to init workqueue*/
>   		amdgpu_virt_exchange_data(adev);
>   
> @@ -666,32 +677,42 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
>   	uint32_t bp_block_size = 0;
>   	struct amd_sriov_msg_pf2vf_info *pf2vf_v2 = NULL;
>   
> -	if (adev->mman.fw_vram_usage_va != NULL) {
> -
> -		adev->virt.fw_reserve.p_pf2vf =
> -			(struct amd_sriov_msg_pf2vf_info_header *)
> -			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
> -		adev->virt.fw_reserve.p_vf2pf =
> -			(struct amd_sriov_msg_vf2pf_info_header *)
> -			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
> +	if (adev->mman.fw_vram_usage_va != NULL ||
> +		adev->mman.drv_vram_usage_va != NULL) {
> +
> +		if (adev->mman.fw_vram_usage_va != NULL) {
> +			adev->virt.fw_reserve.p_pf2vf =
> +				(struct amd_sriov_msg_pf2vf_info_header *)
> +				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
> +			adev->virt.fw_reserve.p_vf2pf =
> +				(struct amd_sriov_msg_vf2pf_info_header *)
> +				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
> +		} else if (adev->mman.drv_vram_usage_va != NULL) {
> +			adev->virt.fw_reserve.p_pf2vf =
> +				(struct amd_sriov_msg_pf2vf_info_header *)
> +				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
> +			adev->virt.fw_reserve.p_vf2pf =
> +				(struct amd_sriov_msg_vf2pf_info_header *)
> +				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
> +		}
>   
>   		amdgpu_virt_read_pf2vf_data(adev);
>   		amdgpu_virt_write_vf2pf_data(adev);
>   
>   		/* bad page handling for version 2 */
>   		if (adev->virt.fw_reserve.p_pf2vf->version == 2) {
> -				pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
> +			pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
>   
> -				bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
> -						((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
> -				bp_block_size = pf2vf_v2->bp_block_size;
> +			bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
> +				((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
> +			bp_block_size = pf2vf_v2->bp_block_size;
>   
> -				if (bp_block_size && !adev->virt.ras_init_done)
> -					amdgpu_virt_init_ras_err_handler_data(adev);
> +			if (bp_block_size && !adev->virt.ras_init_done)
> +				amdgpu_virt_init_ras_err_handler_data(adev);
>   
> -				if (adev->virt.ras_init_done)
> -					amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
> -			}
> +			if (adev->virt.ras_init_done)
> +				amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
> +		}
>   	}
>   }
>   

