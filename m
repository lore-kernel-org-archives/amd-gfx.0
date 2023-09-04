Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817A0C83F33
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Sep 2023 08:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2E0F10E2F9;
	Mon,  4 Sep 2023 08:46:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6BE610E2F9
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Sep 2023 08:46:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFKc96QjT8tLkq2Hy89caom2ql/rTxp+D8UvJvFC5/BZKoK68ZeQnhWXn+6BUP9jeNFfpnbkw+p4NqXS0pmqOBSG3Ll7r5Ih91yina3x7EQJy3Xe/xKnIIJBDDuMIUNLRgTDcNEEKwnB9heHu9un25xqN9fmW5ArCAFqWlF4AoZM0JL/aGWcuefUJhnw/b4ysTzBvOOsQAPhJNLe1vl2IShdVPk1LT+3/aYVGWJOcB6ThyioFCg2YdOonnib3Mj4FbnpGy0GtyaPlmdmPk3W+JHeZQqQRLBptJd6Gvd54inhpOK85WA03A1CeeTr+Lxk+9jlPNaxddIFcNnux7BhDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDm9qexPogN4d4qBR4O3crioaYTtlPOaIluwQqAF0Ro=;
 b=YMG3iEkYxOZm+emcojrZMRAHSHKGdJ9oDv130EANY2lGT4mwsOdQG5VP91Uyw8basjlG7TcV9FS/btYrq+svZf7sRrFTEYlU1EUa+jcWstcdVdRkLOPTzP20gH7Q6jxh+/PU3x0adsOtrUDynCgk4EWQdElF9YC6/DTqyarf9yUMP2bn011jq2F2UgiUWcVg8zC5EPwJe3TCLmmxxgrVsWVqmEmzJA8pYd1QkP9KPgiL7mXV66QtplP3ZwSTCRZnRiw9Wv0ypv88UvwGrFE0SPruU7kJ9JhxJ5YWLLklsVlgz4x8rcLIgmDBHGBW5y/NWws9tFMXq98fbANs/Ycs4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDm9qexPogN4d4qBR4O3crioaYTtlPOaIluwQqAF0Ro=;
 b=pu1iC6zCGEefiNje1r+HzF6tklgJZm2WhbMYcf+2YUDXbgoqPz+BfrWqShjdJAlIWdjTM46jwdSiaPUvrG84z5fbgJ8uDMWPV54pXIu/0NikM8G+9co25XDLVgF23RJ4BToWRV2H2xtse0afiidFvJBIkurOiSsvci7jiWlxEnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM8PR12MB5446.namprd12.prod.outlook.com (2603:10b6:8:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 08:46:35 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 08:46:35 +0000
Message-ID: <5259dfe3-c821-805e-bf4b-2ea7a48d3d6e@amd.com>
Date: Mon, 4 Sep 2023 10:46:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Use min_t to replace min
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230903065225.1976529-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230903065225.1976529-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM8PR12MB5446:EE_
X-MS-Office365-Filtering-Correlation-Id: c567cf1e-a5ce-4d61-bb34-08dbad2371c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRU03p+A62UaXYE9fM3HB+3TzngMseAIBR5A42jTXIsUgfuQpccqZ5aWsqn5M6U6/xEMh2Oy245u8rhh/H1KFzK2qLNJ4hOdNc0hwyOyKINOBXUXYrKnNfDjuE+ol3BrZmyJ3PhN0OJaOf+IfIynFVHS+DtB9fwxRoSdKkWTH75xElZsmn0AzWsN6yaRqaaxdXbUNiMAoQ3xUdSIJ3zwUjBAEdqQnL+sVLFbU54604bxb+DixYxBsivYvm/QErTCjezktYGmEvosw2l0P8d/rDPyI+9p76OH+uhREIlyR0vHsOyS0dK/u88wBkYLvYp8pERchZsIIhHedeoQokP7340cEGVZEFKe+9IfxclaWfeDakRJWVWxpRmZ6LgrjK0xxSy1vQoDPJFKMLCGdd5O+R2hn1aGOeRjksf+ag4V21YxFq7XQsGBVAd2uNbK8+K4exb0CzJe3FAvV1jwzq8f72cOOuCOIWwWuzds+Nmq8C3walWDY01Ua1omm8Ajvgk6p4ch4gwpeAkmMybVQTB+QuTJs93ALKA4nWDfhCt+pMcddOZlHqkegxzIoqFpIMg4be6ue5kakdZNJ92ss69BhphgOc/+0ERzFGRFT0ZEgySetsn0st0UmsE4A00HGhwo8P3oaxIavp1l5ByRkhxKNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(1800799009)(186009)(451199024)(5660300002)(41300700001)(2616005)(26005)(2906002)(66574015)(86362001)(31696002)(38100700002)(36756003)(4326008)(8936002)(8676002)(83380400001)(6512007)(6506007)(6666004)(6486002)(31686004)(478600001)(316002)(110136005)(6636002)(66946007)(66476007)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T29jcElXU1g0VTVwaXM0ZXRsdFIzV1VkaDJPaEZkZTdTTncvMzNaV0JxdUl2?=
 =?utf-8?B?SmdocDNPcVY1N0VDenFDNU82cTViTmJZcVdWVUxGSHhyZHVDaEZaZjU4L3ZL?=
 =?utf-8?B?YVFlSWhCSitBY0Q0WExBOXRYSWlrc2o2SjZkWFB6cm9ITXJsUHh4Tm4wY3Zm?=
 =?utf-8?B?N0V3WDRXUlpXM0dpSlV5MUdFUm1KdTBOV1FkcHJBRStxbXVWYi9ZRE9YUUUv?=
 =?utf-8?B?SzYyT3RYTnQvUUtnK09wTXMzbTF5SXZYaVVWeUxTUTVxVGtaNnlycEU1Slpa?=
 =?utf-8?B?L2VaM3hCNUpwZm9URlVPTDFoa3Q4ZldGMWZySHQ0UEh6UmNiNC9kZTBaeFpC?=
 =?utf-8?B?bjAzTzNFSTRIbGhCclFnVkFFT0hXK2l1aFpYY1piRmowR0N1WC85THNTcERM?=
 =?utf-8?B?MHBnUzR2WCtRMXBjZ1MrQWhJVU00MmV2bDlaQ1J2RDhBbHFMNzM0UENhREk1?=
 =?utf-8?B?VSs4WUk2cnVRdUNXenFrVFpoWktuU3Q4blZuZWlaU0gyUXNwT3Z5aW81N1dy?=
 =?utf-8?B?L2dKeWdNOUlMSUt2bG10VHpBbEQzcUNxQzJVcGRVK2UybWtkWTVKcVNadk44?=
 =?utf-8?B?ZGVBdVhjdmRuZEV0Q0pYWitFeDIxeE4zQnN0bGM4ZytTZW8vZXk4aXhjaTYr?=
 =?utf-8?B?UzNVSzA1MVM0Qm1jQlRUWDVack5nVHBkcHBaU0k1NzlvbndWZHVBYjcxYTNo?=
 =?utf-8?B?bWZkOXlPQU40eHlNZlN5OUJCOTZlcVM5RUhpMWVTVjh0NGYramtGNWFUa2N0?=
 =?utf-8?B?d0FHTnYzalJ4MzJUVU5FVUJUREpXWnpSUWhjdDBsVVdhWFJqQ3VRcVZPVGJG?=
 =?utf-8?B?L1VkYTg0cHNhNHJzZlc0QlcxaHk5aERkdXVDNTdmdFFPekFVOGRWSk1UZys2?=
 =?utf-8?B?eGp0dHZzODRKcDl4bnJZQTVNZm5DR1Rqc2psd2RLNXhOb0w1TkpET0R3dXdv?=
 =?utf-8?B?OEVpMEdZeWEzWGZqbXZuR01QMFUrdDM2b2k2eEI5WnpiRVZmby81TUJVWk9h?=
 =?utf-8?B?eXZvVHM2TGNrOUpvVGhZVjc0UG4yalpkaDRuSWVjNXNqUi9SbktqUjhFZmFV?=
 =?utf-8?B?ajBsU01QbU1EWHN3VTVUN2xTdFJmMy80K3FCZ2M5cnZrYTRQaFNBaS8wM05B?=
 =?utf-8?B?bHNOZTY1M2dMbjJHSzF1dDBkR1U4N01lWHhXL2dSSkNJYWpBRG50SGJuWWhr?=
 =?utf-8?B?akJMK0hpdW4rUmc4eWhiRXI4WXYxQ0ZKUWtqYU9wa3JQdnZFK2dLdFFZb1pD?=
 =?utf-8?B?Yzd5NDdWMFlvQ09oRTc5YkNqUVA4cVhCRTRlcyt2T0JPYit5cFdHQWRIc3p6?=
 =?utf-8?B?S29aQjY2eUVpVklZcUE2ZHplb0NIWHF3L0pJSm9wam9ackNIb3ZYOCtkZ3RX?=
 =?utf-8?B?NEcvT1Bnb3BWczZPNEVrWmVFUEZWVWM0cDRaMWk4K0FxdVQ3WFRnYnNQZUdk?=
 =?utf-8?B?aVg5RENYUXdmVktpdzRPcjgrT1FIdXVWNnVXSUlrVHdQNGVWbmRYTXBrOW9j?=
 =?utf-8?B?Tlk3OHNEaVltU0ZGMWxZbW9tS1ArbW1ZYmQ2bmRvd2xQMzcyVFZDa0lpZUtS?=
 =?utf-8?B?TE55S3UycUk1azdkUDJYelRtN2F5a2NicE11S3pTQkJrQTRHNmpiei9xYi92?=
 =?utf-8?B?d3Y3eUxJQ1B5TUxVTEJCRzlOZDB6T2FzcFJyeHlxemxjVUlSOGVvZ1BiRHVH?=
 =?utf-8?B?UUxQT0tKVDg4Vi9xQXpiSjVtdThHR0NQdFg0UGxTaFNreEpGUkd4OWxVWVNn?=
 =?utf-8?B?QWFhSXBPMHlvZExyNEVrZFdUTWN1ckNlekZVTzl4RTBTd0w1U3pZWHVvVDFa?=
 =?utf-8?B?YjMxMGFNMDNadjhRdm9aaG5LN25IWVVqem9MaTZLcjJiaXBwMUZjK1JVcVBW?=
 =?utf-8?B?SUZyOWFZZkNnRFFkSGpKc2ZIQUlMZ1NhUUl4SCswaUFKUGlPcWM5NVArQjJk?=
 =?utf-8?B?SFNKY21Yb0huckFRL0JyQ0tNMmhiY1lFRDNGMjlCbnRsK3pxQmh6UE9hN01W?=
 =?utf-8?B?U2VBTndGcllKNmtqMUNFRWZnSmVxOE5RL1Q5aDdob0hTU00vRW83andqVldJ?=
 =?utf-8?B?aERVZnQ0NFN3bGF5RmNXemJTU0dackpIemhnNE9iOTVYWHFDOVVidjNSN0d4?=
 =?utf-8?Q?TIWk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c567cf1e-a5ce-4d61-bb34-08dbad2371c1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 08:46:34.9849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdnW2R0wHo71ZWbiuyWFqaGc6BwciYAotnYxf2nCThq5NSEYj3y4hIHTY06jKIqS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5446
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.09.23 um 08:52 schrieb Srinivasan Shanmugam:
> Use min_t to replace min, min_t is a bit fast because min use
> twice typeof.

Well that is probably negligibly.

The point is that using min_t is cleaner here since the min/max macros 
do a typecheck while min_t()/max_t() to an explicit type cast.

>
> Fixes the below checkpatch warning:
>
> WARNING: min() should probably be min_t()
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 2 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c  | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c  | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c   | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c   | 6 +++---
>   6 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index f5793ec4b7c4..80bcbe744e58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1089,7 +1089,7 @@ static ssize_t amdgpu_debugfs_vcn_fwlog_read(struct file *f, char __user *buf,
>   
>   	if (write_pos > read_pos) {
>   		available = write_pos - read_pos;
> -		read_num[0] = min(size, (size_t)available);
> +		read_num[0] = min_t(size_t, size, available);
>   	} else {
>   		read_num[0] = AMDGPU_VCNFW_LOG_SIZE - read_pos;
>   		available = read_num[0] + write_pos - plog->header_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index f731f0a99bd8..edaebabc8e60 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1976,7 +1976,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>   	if (amdgpu_vm_block_size != -1)
>   		tmp >>= amdgpu_vm_block_size - 9;
>   	tmp = DIV_ROUND_UP(fls64(tmp) - 1, 9) - 1;
> -	adev->vm_manager.num_level = min(max_level, (unsigned)tmp);
> +	adev->vm_manager.num_level = min_t(unsigned int, max_level, tmp);
>   	switch (adev->vm_manager.num_level) {
>   	case 3:
>   		adev->vm_manager.root_level = AMDGPU_VM_PDB2;
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> index 584cd5277f92..bb666cb7522e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -1036,7 +1036,7 @@ static void dce_v10_0_program_watermarks(struct amdgpu_device *adev,
>   					    (u32)mode->clock);
>   		line_time = (u32) div_u64((u64)mode->crtc_htotal * 1000000,
>   					  (u32)mode->clock);
> -		line_time = min(line_time, (u32)65535);
> +		line_time = min_t(u32, line_time, 65535);
>   
>   		/* watermark for high clocks */
>   		if (adev->pm.dpm_enabled) {
> @@ -1066,7 +1066,7 @@ static void dce_v10_0_program_watermarks(struct amdgpu_device *adev,
>   		wm_high.num_heads = num_heads;
>   
>   		/* set for high clocks */
> -		latency_watermark_a = min(dce_v10_0_latency_watermark(&wm_high), (u32)65535);
> +		latency_watermark_a = min_t(u32, dce_v10_0_latency_watermark(&wm_high), 65535);
>   
>   		/* possibly force display priority to high */
>   		/* should really do this at mode validation time... */
> @@ -1105,7 +1105,7 @@ static void dce_v10_0_program_watermarks(struct amdgpu_device *adev,
>   		wm_low.num_heads = num_heads;
>   
>   		/* set for low clocks */
> -		latency_watermark_b = min(dce_v10_0_latency_watermark(&wm_low), (u32)65535);
> +		latency_watermark_b = min_t(u32, dce_v10_0_latency_watermark(&wm_low), 65535);
>   
>   		/* possibly force display priority to high */
>   		/* should really do this at mode validation time... */
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> index c14b70350a51..7af277f61cca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> @@ -1068,7 +1068,7 @@ static void dce_v11_0_program_watermarks(struct amdgpu_device *adev,
>   					    (u32)mode->clock);
>   		line_time = (u32) div_u64((u64)mode->crtc_htotal * 1000000,
>   					  (u32)mode->clock);
> -		line_time = min(line_time, (u32)65535);
> +		line_time = min_t(u32, line_time, 65535);
>   
>   		/* watermark for high clocks */
>   		if (adev->pm.dpm_enabled) {
> @@ -1098,7 +1098,7 @@ static void dce_v11_0_program_watermarks(struct amdgpu_device *adev,
>   		wm_high.num_heads = num_heads;
>   
>   		/* set for high clocks */
> -		latency_watermark_a = min(dce_v11_0_latency_watermark(&wm_high), (u32)65535);
> +		latency_watermark_a = min_t(u32, dce_v11_0_latency_watermark(&wm_high), 65535);
>   
>   		/* possibly force display priority to high */
>   		/* should really do this at mode validation time... */
> @@ -1137,7 +1137,7 @@ static void dce_v11_0_program_watermarks(struct amdgpu_device *adev,
>   		wm_low.num_heads = num_heads;
>   
>   		/* set for low clocks */
> -		latency_watermark_b = min(dce_v11_0_latency_watermark(&wm_low), (u32)65535);
> +		latency_watermark_b = min_t(u32, dce_v11_0_latency_watermark(&wm_low), 65535);
>   
>   		/* possibly force display priority to high */
>   		/* should really do this at mode validation time... */
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> index 7f85ba5b726f..143efc37a17f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -845,7 +845,7 @@ static void dce_v6_0_program_watermarks(struct amdgpu_device *adev,
>   					    (u32)mode->clock);
>   		line_time = (u32) div_u64((u64)mode->crtc_htotal * 1000000,
>   					  (u32)mode->clock);
> -		line_time = min(line_time, (u32)65535);
> +		line_time = min_t(u32, line_time, 65535);
>   		priority_a_cnt = 0;
>   		priority_b_cnt = 0;
>   
> @@ -906,9 +906,9 @@ static void dce_v6_0_program_watermarks(struct amdgpu_device *adev,
>   		wm_low.num_heads = num_heads;
>   
>   		/* set for high clocks */
> -		latency_watermark_a = min(dce_v6_0_latency_watermark(&wm_high), (u32)65535);
> +		latency_watermark_a = min_t(u32, dce_v6_0_latency_watermark(&wm_high), 65535);
>   		/* set for low clocks */
> -		latency_watermark_b = min(dce_v6_0_latency_watermark(&wm_low), (u32)65535);
> +		latency_watermark_b = min_t(u32, dce_v6_0_latency_watermark(&wm_low), 65535);
>   
>   		/* possibly force display priority to high */
>   		/* should really do this at mode validation time... */
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> index f2b3cb5ed6be..adeddfb7ff12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -975,7 +975,7 @@ static void dce_v8_0_program_watermarks(struct amdgpu_device *adev,
>   					    (u32)mode->clock);
>   		line_time = (u32) div_u64((u64)mode->crtc_htotal * 1000000,
>   					  (u32)mode->clock);
> -		line_time = min(line_time, (u32)65535);
> +		line_time = min_t(u32, line_time, 65535);
>   
>   		/* watermark for high clocks */
>   		if (adev->pm.dpm_enabled) {
> @@ -1005,7 +1005,7 @@ static void dce_v8_0_program_watermarks(struct amdgpu_device *adev,
>   		wm_high.num_heads = num_heads;
>   
>   		/* set for high clocks */
> -		latency_watermark_a = min(dce_v8_0_latency_watermark(&wm_high), (u32)65535);
> +		latency_watermark_a = min_t(u32, dce_v8_0_latency_watermark(&wm_high), 65535);
>   
>   		/* possibly force display priority to high */
>   		/* should really do this at mode validation time... */
> @@ -1044,7 +1044,7 @@ static void dce_v8_0_program_watermarks(struct amdgpu_device *adev,
>   		wm_low.num_heads = num_heads;
>   
>   		/* set for low clocks */
> -		latency_watermark_b = min(dce_v8_0_latency_watermark(&wm_low), (u32)65535);
> +		latency_watermark_b = min_t(u32, dce_v8_0_latency_watermark(&wm_low), 65535);
>   
>   		/* possibly force display priority to high */
>   		/* should really do this at mode validation time... */

