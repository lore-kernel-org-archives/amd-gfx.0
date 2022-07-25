Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7348EC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 21:18:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CF178F7E6;
	Mon, 25 Jul 2022 21:18:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B25588F7BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 21:18:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U86EtP+oTRgyZSlqnomWMbx2Qp54aeVkU5UBYKXRqBQX/QwxGEJ86cNfgFyGTE4GVljcOf7dmTqRcG4N8mL49cu8yIzE+gMgRE4rdCpX2IykmaQ3BK8OoLDw3ybQlZPTrhmlpYFmfzMsvk/Us3kUCCuqGJ7BnNnwOUUwCshlLyvN0DnZ3weFTpVh5GEIgynDeD0WkDCHVyXTKrY9XwbLsenzcoLuDU+2dQR8rRUXjXbhwPpG9CwUY7Awef6BJ+DXZJcWDvlqWtTQ+8A9PzzceWEMjoz5uE0zmmsHB/JvFxdFdNK0eDmULkh3jHn0b5P/7mZpTo+bUbF/5/RJvNmVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxaPAV2NKAqiY5P9LFOO2ktsyQE50QehGavtDgxg1RY=;
 b=BB6Qc1B5fH5mns+K45ZKZmrtSRnC0yeP6eMgV2qB0PMmww3T3Yc8ksz+i79Ce8/HGjqlpG5B151yP9N5bot6iK18xY/PexEqwnotZaBDCg9lIO6cJjeFRj+9+zMgPhAaoMaeR5FxyF+scxWTAT1qvBObIxnXtTr5JRSzRv/wnvIJGfG2M0qZC47n/f/0uK7gNM/PuT5CjIIOCV5+oRvUF597qXzHsAMVdmMULPqaXQFxgVrFOrHL+R9nj2RdA4HcoeOVUuVnZaZ4lttYVM6AcZBwsAk9Gu7PNEKviQvlR1FvALJFFP5GLPY0ZhqK5xVy34dXX9cDqPWlEEyM7QYd9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxaPAV2NKAqiY5P9LFOO2ktsyQE50QehGavtDgxg1RY=;
 b=B5WsqT7a2sfpsDhy1BKNS7lvrU4uerPe84uvuTvyIRuekt2Vb4I2+EJOOpHWOS8wJ5e3zSeZpm3nGSppQ+vuf95iSMs/I4NXyGdOPbg+ZnBCMnogjNlS/o/mGwWVdxnpPFVe74sMWRA2rjQRLBMiOxs1ykR/fpST8iUXJ66dYNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM5PR12MB1164.namprd12.prod.outlook.com (2603:10b6:3:77::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 21:18:21 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 21:18:21 +0000
Message-ID: <25eeeec4-b15d-14ba-6b94-486228caf669@amd.com>
Date: Mon, 25 Jul 2022 17:18:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/5] drm/amdgpu: save and restore gc hub regs
Content-Language: en-US
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220722073403.5171-1-Victor.Zhao@amd.com>
 <20220722073403.5171-3-Victor.Zhao@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220722073403.5171-3-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::19) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ee0e5df-d882-4758-df83-08da6e8333b5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1164:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O2h50fgrngseveB9SUFLgZpx9m7nLHG9QG8MQKFB4jMrZAyxTWNsedPpRpklPxVg5zYXwS2/tpUnUY5StL4hed5lRa4L99NyjDCHpvIOjfFz/tsFkkyMIEeA0tv8B2kJzbeAFswQx4Zt5mfSQxcXjVEIFINLZ3ZcDoihGsx+/oDorQBP/LT4WK+p7O5mveD58ghmG7v2lhUUGnv3JgFxi+QD0qFrXYEikzIfk8QWHQjLxwqtlvM6JoDp9DTMqa3zCctmCKjui2si0TKS/hd4MGs7AghST+kzMBFWEQ/msawGZragHwuvW5vcq6fefjqB3jifXx9YoV18pVwM4KloFh4KWiWaCgxqJ06ZYMmdmsS5dn9HaqcwgGilhT5uX0XkhJ3tNajMonU7z2GramUQi+VHPKSoQhYimqmaETsdFcSB9vYBdKz849z8uUTnaMgscLB8SkXD7TXh/1IhoaIlq2LvWPbjHY0bxHW6CvMXHvSJRJLrEpGLNrMM4iyhkw2ag4CipfOFpIWkWJYmxTescRUP5I2qpOuy8uvDk5+eRGZrQuaSc7RSfw5b3VjOnGf2Fng2MUh1EY6LsGxEa6H5vrJcXf0X1BhWe5WDMcG2rFZjULSj+/qgi6RHpTW89PpidlhpHCXEX4EN8deYz7kGzcaXaTVtV/xbcj5cxVIF0ZWcxSsuxnuqeOLgPTh2H6NHc1wOHcYruVP/QvCJ/t6iiZKC1lNA8RixFegb/bLBojdEXd0M0ql2Kk5V1JRU2Q+1erNNT8CXGySATDwQ15SZTaadJLLRxwdGPIffPBKJJ85aJFXQLd+NMgcOWKnd1IC2m8j1vFng1hRrpnX5H/yJww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(6486002)(478600001)(41300700001)(6666004)(316002)(2906002)(66946007)(8676002)(66556008)(66476007)(5660300002)(30864003)(44832011)(4326008)(8936002)(83380400001)(31686004)(186003)(38100700002)(2616005)(53546011)(6506007)(36756003)(6512007)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmZnK2MzV0xDWXJqWWlPWDFWSGxVZmJBMnkzcElCZ0ROOTBzQ1ZHQmRFTHZt?=
 =?utf-8?B?NGlCZENmR2tDQXZQQXVyZmQvK0dRTEhvdzNoZUdsWnVYU1N4U2NyT2J4dXdt?=
 =?utf-8?B?TVF6M0c1c08vR2VlT2pyc3NRdWxTWGlwaUpOWjM0YlhFTUREdWlqZ2FHbGw5?=
 =?utf-8?B?T0FrNDlvWjhDSXhuZVIyVG9UK0I4SkNVbHJCUDNGMWRGU3NtcG9vYlZUVXVm?=
 =?utf-8?B?V1BuNkZnc2F6dldjemtldTdoNW9mWGtPM1kxem9VSlNPTmFRVks2bTIyU0hM?=
 =?utf-8?B?L0RJaHpHRGJuV3JvL1o4YldNZVJ5MFcrTU9BNXZSZHZGYVRkc3BGZ3czQm1L?=
 =?utf-8?B?dmc3bXZJZXZDSFBxemw5OEI1bWNIblZJR210VVpEWCtDQ3VqbnNOZGhxSlZa?=
 =?utf-8?B?cUdQenNwKzk5Rkx2M3gzbXBZY3lmWlppUzJnZTFJYkYxa0FVZUtUMGNHVHpU?=
 =?utf-8?B?elhSRXNEdFNOU01PSTArMi8vZW1VMzU2VXo1eFI3bjVNTm1TTkJLWTRiK3d4?=
 =?utf-8?B?TVZtYVFud1dIQ1M0M2hDMjJkQ3RWUVYycEZFZW03ZjdlTXVkUjdwTzFDVDhn?=
 =?utf-8?B?ZWxTTXExQ2RBVkJuTmpxR1RRVmRIUm51OUlHZ1BSSkF2SjhkTk00NFdCQkk4?=
 =?utf-8?B?SnlwSGw3dUlYN3ZuTHRuaUk5c2plVGxIWGlFRkFoQkhMMW04cGJERkVIanJC?=
 =?utf-8?B?UWFPVFM0U3U0OGFmbHNHendEQkVacklPcVRTQTBOTkRWTTNhNGZoZlZqVEtp?=
 =?utf-8?B?UXczN3VDTnJwRlIzalNtU3FkUGxEMTBYbGcrSjRMSzFOcGt0czVYamdYNitG?=
 =?utf-8?B?eG5TUHhEc0VnVndUTGQyMzdGOTlXUlhLK3VmaWZBTkRyNkJPQmVpNGFNbEZZ?=
 =?utf-8?B?Qyt1K0NaNHVhRzFWVXRQNXNid0hQdjlsYkJFcnUvdWZDVFp1ckFRZFBaY0dl?=
 =?utf-8?B?enpwKzJEMFM3SGlLUVRiSzhEaFRINnVRS1FoSnk5Wkp4VDU2cTRLaE91UkdK?=
 =?utf-8?B?TmdKNGFScG85cWE2MGE0RzM3R1liNU5oVzlCRHcvb3VHL2VtVDJBTjgyN0hB?=
 =?utf-8?B?MCtDbFBzeWJua1owaWNobEdKNXJwSldFVnZkQmhOUG9uVDVYOXlId0ErOTlq?=
 =?utf-8?B?S1AvWUpIQitBbno5RkJYWGZpdFdHWjFmdW5namw3RnhiUFBKT0JtSEgrS0VK?=
 =?utf-8?B?amhZNDJ1NndnQVNZNEVIcmZ5VzlqekhKZU4zNG5MQkRwWmlFTkxnQW1tNmZm?=
 =?utf-8?B?Ylg0TEhwVSs2Qk92RkNWM2FrdzArTDFSRDg4WXo1bmRYRFRraHE0aWtKZ0F6?=
 =?utf-8?B?VFhVN2tVdEVDeWtvMmRBRnBjeFNNb1JCUEU4VEk3VzhRU3VMUjRrcS9SRmlI?=
 =?utf-8?B?U2JTVUMrRGlveXF4NFRObVpLeC9BbHNjSFV2SG5RUUwwUXNzc0d2WVRiMWd6?=
 =?utf-8?B?QTdxM0FocWNsU09leTNkRGJnL3A0d0J1cXpwMzNsbEpHVmJDV0JyWjlUNEdZ?=
 =?utf-8?B?NlZMOFV3b0h1RlNISkgwNjFGenI3cUNOb1Z4WVJSV2xTbEwrNi9JR05kaFVG?=
 =?utf-8?B?OEsyRkY1QkQ2SHltSWs4cXVQTm1reTJUU21BNWpLWFRSb2xBRUdlZk41aFVv?=
 =?utf-8?B?Yllra0M3YjNacTBwbUJ4T0M5M1l1TDdIS25sVDZnYTZnOTdqbWZQdTZLWjFz?=
 =?utf-8?B?MzMwZzF0VldyZjNjUWx2cVhZL1hoVTl0emp6Y3BCcTNKb0o4UFNMWEJCUU9R?=
 =?utf-8?B?Mm5CRnVDVDNHYlRLSkh1ZXNqdVdabXE0eVl5Y3EyS1YxYnFTcnY3V0Y4eHR1?=
 =?utf-8?B?WEd1dmhCcmtVTG4yZ0oxNzk0bTRTWk5BVzdCTVNEdTVPUXFRczBDU1ZxenBz?=
 =?utf-8?B?emtTQU1sSmgwaVB3ZnU3K1FCckZSNHlzOE9LMXI1RGs2RG9mRFhNRzVETTVy?=
 =?utf-8?B?RDdJYmU0ZXlrRmVCd244Q1BiWnpKMVYwcm95S3E4VnZ2ck1QTFEzQjhMcHl0?=
 =?utf-8?B?c0FTL0ZtSDNLK2tMei84VjJCeWo5YUFFT082cFlTQnYyQUJaM3F1YWF5STdP?=
 =?utf-8?B?N0o0cktJV3RFV2EyN0tjMWtyZzgxaWhjSjgvbi9oamVINHhTazRLNEE0Z1V0?=
 =?utf-8?B?QS9hSE8wU21YTHVSSGVxVE5VZ0xCNnVCWDR0eEJCTFdMOG92K25pMkNaR3NI?=
 =?utf-8?Q?loJkWmjvxEiAY1qjzFgNe3JhXxcjgSZegs9BTFRFyKjP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee0e5df-d882-4758-df83-08da6e8333b5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 21:18:21.5237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTyKPUuscgWqMYT5+nfm/nggweNs6POM0Dkgy8+ejRfYAlpuM3fSJ4b6eq6ReSsG/GFPc4c4EaZ49pHSXjcvzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1164
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
Cc: Alexander.Deucher@amd.com, emily.deng@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2022-07-22 03:34, Victor Zhao wrote:
> Save and restore gfxhub regs as they will be reset during mode 2
>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h    |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       | 26 +++++++
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c      | 72 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |  7 +-
>   .../include/asic_reg/gc/gc_10_3_0_offset.h    |  4 ++
>   5 files changed, 110 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
> index beabab515836..f8036f2b100e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
> @@ -35,6 +35,8 @@ struct amdgpu_gfxhub_funcs {
>   	void (*init)(struct amdgpu_device *adev);
>   	int (*get_xgmi_info)(struct amdgpu_device *adev);
>   	void (*utcl2_harvest)(struct amdgpu_device *adev);
> +	void (*mode2_save_regs)(struct amdgpu_device *adev);
> +	void (*mode2_restore_regs)(struct amdgpu_device *adev);
>   };
>   
>   struct amdgpu_gfxhub {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 008eaca27151..0305b660cd17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -264,6 +264,32 @@ struct amdgpu_gmc {
>   	u64 mall_size;
>   	/* number of UMC instances */
>   	int num_umc;
> +	/* mode2 save restore */
> +	u64 VM_L2_CNTL;
> +	u64 VM_L2_CNTL2;
> +	u64 VM_DUMMY_PAGE_FAULT_CNTL;
> +	u64 VM_DUMMY_PAGE_FAULT_ADDR_LO32;
> +	u64 VM_DUMMY_PAGE_FAULT_ADDR_HI32;
> +	u64 VM_L2_PROTECTION_FAULT_CNTL;
> +	u64 VM_L2_PROTECTION_FAULT_CNTL2;
> +	u64 VM_L2_PROTECTION_FAULT_MM_CNTL3;
> +	u64 VM_L2_PROTECTION_FAULT_MM_CNTL4;
> +	u64 VM_L2_PROTECTION_FAULT_ADDR_LO32;
> +	u64 VM_L2_PROTECTION_FAULT_ADDR_HI32;
> +	u64 VM_DEBUG;
> +	u64 VM_L2_MM_GROUP_RT_CLASSES;
> +	u64 VM_L2_BANK_SELECT_RESERVED_CID;
> +	u64 VM_L2_BANK_SELECT_RESERVED_CID2;
> +	u64 VM_L2_CACHE_PARITY_CNTL;
> +	u64 VM_L2_IH_LOG_CNTL;
> +	u64 VM_CONTEXT_CNTL[16];
> +	u64 VM_CONTEXT_PAGE_TABLE_BASE_ADDR_LO32[16];
> +	u64 VM_CONTEXT_PAGE_TABLE_BASE_ADDR_HI32[16];
> +	u64 VM_CONTEXT_PAGE_TABLE_START_ADDR_LO32[16];
> +	u64 VM_CONTEXT_PAGE_TABLE_START_ADDR_HI32[16];
> +	u64 VM_CONTEXT_PAGE_TABLE_END_ADDR_LO32[16];
> +	u64 VM_CONTEXT_PAGE_TABLE_END_ADDR_HI32[16];
> +	u64 MC_VM_MX_L1_TLB_CNTL;
>   };
>   
>   #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index d8c531581116..51cf8acd2d79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -576,6 +576,76 @@ static void gfxhub_v2_1_utcl2_harvest(struct amdgpu_device *adev)
>   	}
>   }
>   
> +static void gfxhub_v2_1_save_regs(struct amdgpu_device *adev)
> +{
> +	int i;
> +	adev->gmc.VM_L2_CNTL = RREG32_SOC15(GC, 0, mmGCVM_L2_CNTL);
> +	adev->gmc.VM_L2_CNTL2 = RREG32_SOC15(GC, 0, mmGCVM_L2_CNTL2);
> +	adev->gmc.VM_DUMMY_PAGE_FAULT_CNTL = RREG32_SOC15(GC, 0, mmGCVM_DUMMY_PAGE_FAULT_CNTL);
> +	adev->gmc.VM_DUMMY_PAGE_FAULT_ADDR_LO32 = RREG32_SOC15(GC, 0, mmGCVM_DUMMY_PAGE_FAULT_ADDR_LO32);
> +	adev->gmc.VM_DUMMY_PAGE_FAULT_ADDR_HI32 = RREG32_SOC15(GC, 0, mmGCVM_DUMMY_PAGE_FAULT_ADDR_HI32);
> +	adev->gmc.VM_L2_PROTECTION_FAULT_CNTL = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL);
> +	adev->gmc.VM_L2_PROTECTION_FAULT_CNTL2 = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2);
> +	adev->gmc.VM_L2_PROTECTION_FAULT_MM_CNTL3 = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_MM_CNTL3);
> +	adev->gmc.VM_L2_PROTECTION_FAULT_MM_CNTL4 = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_MM_CNTL4);
> +	adev->gmc.VM_L2_PROTECTION_FAULT_ADDR_LO32 = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_ADDR_LO32);
> +	adev->gmc.VM_L2_PROTECTION_FAULT_ADDR_HI32 = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_ADDR_HI32);
> +	adev->gmc.VM_DEBUG = RREG32_SOC15(GC, 0, mmGCVM_DEBUG);
> +	adev->gmc.VM_L2_MM_GROUP_RT_CLASSES = RREG32_SOC15(GC, 0, mmGCVM_L2_MM_GROUP_RT_CLASSES);
> +	adev->gmc.VM_L2_BANK_SELECT_RESERVED_CID = RREG32_SOC15(GC, 0, mmGCVM_L2_BANK_SELECT_RESERVED_CID);
> +	adev->gmc.VM_L2_BANK_SELECT_RESERVED_CID2 = RREG32_SOC15(GC, 0, mmGCVM_L2_BANK_SELECT_RESERVED_CID2);
> +	adev->gmc.VM_L2_CACHE_PARITY_CNTL = RREG32_SOC15(GC, 0, mmGCVM_L2_CACHE_PARITY_CNTL);
> +	adev->gmc.VM_L2_IH_LOG_CNTL = RREG32_SOC15(GC, 0, mmGCVM_L2_IH_LOG_CNTL);
> +
> +	for (i = 0; i <= 15; i++) {
> +		adev->gmc.VM_CONTEXT_CNTL[i] = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_CNTL, i);
> +		adev->gmc.VM_CONTEXT_PAGE_TABLE_BASE_ADDR_LO32[i] = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32, i * 2);
> +		adev->gmc.VM_CONTEXT_PAGE_TABLE_BASE_ADDR_HI32[i] = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32, i * 2);
> +		adev->gmc.VM_CONTEXT_PAGE_TABLE_START_ADDR_LO32[i] = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32, i * 2);
> +		adev->gmc.VM_CONTEXT_PAGE_TABLE_START_ADDR_HI32[i] = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32, i * 2);
> +		adev->gmc.VM_CONTEXT_PAGE_TABLE_END_ADDR_LO32[i] = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32, i * 2);
> +		adev->gmc.VM_CONTEXT_PAGE_TABLE_END_ADDR_HI32[i] = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32, i * 2);
> +	}
> +
> +	adev->gmc.MC_VM_MX_L1_TLB_CNTL = RREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL);
> +}
> +
> +static void gfxhub_v2_1_restore_regs(struct amdgpu_device *adev)
> +{
> +	int i;
> +	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL, adev->gmc.VM_L2_CNTL);
> +	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL2, adev->gmc.VM_L2_CNTL2);
> +	WREG32_SOC15(GC, 0, mmGCVM_DUMMY_PAGE_FAULT_CNTL, adev->gmc.VM_DUMMY_PAGE_FAULT_CNTL);
> +	WREG32_SOC15(GC, 0, mmGCVM_DUMMY_PAGE_FAULT_ADDR_LO32, adev->gmc.VM_DUMMY_PAGE_FAULT_ADDR_LO32);
> +	WREG32_SOC15(GC, 0, mmGCVM_DUMMY_PAGE_FAULT_ADDR_HI32, adev->gmc.VM_DUMMY_PAGE_FAULT_ADDR_HI32);
> +	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, adev->gmc.VM_L2_PROTECTION_FAULT_CNTL);
> +	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2, adev->gmc.VM_L2_PROTECTION_FAULT_CNTL2);
> +	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_MM_CNTL3, adev->gmc.VM_L2_PROTECTION_FAULT_MM_CNTL3);
> +	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_MM_CNTL4, adev->gmc.VM_L2_PROTECTION_FAULT_MM_CNTL4);
> +	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_ADDR_LO32, adev->gmc.VM_L2_PROTECTION_FAULT_ADDR_LO32);
> +	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_ADDR_HI32, adev->gmc.VM_L2_PROTECTION_FAULT_ADDR_HI32);
> +	WREG32_SOC15(GC, 0, mmGCVM_DEBUG, adev->gmc.VM_DEBUG);
> +	WREG32_SOC15(GC, 0, mmGCVM_L2_MM_GROUP_RT_CLASSES, adev->gmc.VM_L2_MM_GROUP_RT_CLASSES);
> +	WREG32_SOC15(GC, 0, mmGCVM_L2_BANK_SELECT_RESERVED_CID, adev->gmc.VM_L2_BANK_SELECT_RESERVED_CID);
> +	WREG32_SOC15(GC, 0, mmGCVM_L2_BANK_SELECT_RESERVED_CID2, adev->gmc.VM_L2_BANK_SELECT_RESERVED_CID2);
> +	WREG32_SOC15(GC, 0, mmGCVM_L2_CACHE_PARITY_CNTL, adev->gmc.VM_L2_CACHE_PARITY_CNTL);
> +	WREG32_SOC15(GC, 0, mmGCVM_L2_IH_LOG_CNTL, adev->gmc.VM_L2_IH_LOG_CNTL);
> +
> +	for (i = 0; i <= 15; i++) {
> +		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_CNTL, i, adev->gmc.VM_CONTEXT_CNTL[i]);
> +		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32, i * 2, adev->gmc.VM_CONTEXT_PAGE_TABLE_BASE_ADDR_LO32[i]);
> +		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32, i * 2, adev->gmc.VM_CONTEXT_PAGE_TABLE_BASE_ADDR_HI32[i]);
> +		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32, i * 2, adev->gmc.VM_CONTEXT_PAGE_TABLE_START_ADDR_LO32[i]);
> +		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32, i * 2, adev->gmc.VM_CONTEXT_PAGE_TABLE_START_ADDR_HI32[i]);
> +		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32, i * 2, adev->gmc.VM_CONTEXT_PAGE_TABLE_END_ADDR_LO32[i]);
> +		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32, i * 2, adev->gmc.VM_CONTEXT_PAGE_TABLE_END_ADDR_HI32[i]);
> +	}
> +
> +	WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE, adev->gmc.vram_start >> 24);
> +	WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_TOP, adev->gmc.vram_end >> 24);
> +	WREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, adev->gmc.MC_VM_MX_L1_TLB_CNTL);
> +}
> +
>   const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs = {
>   	.get_fb_location = gfxhub_v2_1_get_fb_location,
>   	.get_mc_fb_offset = gfxhub_v2_1_get_mc_fb_offset,
> @@ -586,4 +656,6 @@ const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs = {
>   	.init = gfxhub_v2_1_init,
>   	.get_xgmi_info = gfxhub_v2_1_get_xgmi_info,
>   	.utcl2_harvest = gfxhub_v2_1_utcl2_harvest,
> +	.mode2_save_regs = gfxhub_v2_1_save_regs,
> +	.mode2_restore_regs = gfxhub_v2_1_restore_regs,
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> index 0512960bed23..51a5b68f77d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> @@ -94,8 +94,11 @@ sienna_cichlid_mode2_prepare_hwcontext(struct amdgpu_reset_control *reset_ctl,
>   	int r = 0;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
>   
> -	if (!amdgpu_sriov_vf(adev))
> +	if (!amdgpu_sriov_vf(adev)) {
> +		if (adev->gfxhub.funcs->mode2_save_regs)
> +			adev->gfxhub.funcs->mode2_save_regs(adev);
>   		r = sienna_cichlid_mode2_suspend_ip(adev);
> +	}
>   
>   	return r;
>   }
> @@ -152,6 +155,8 @@ static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
>   	}
>   
>   	/* Reinit GFXHUB */
> +	if (adev->gfxhub.funcs->mode2_restore_regs)
> +		adev->gfxhub.funcs->mode2_restore_regs(adev);
>   	adev->gfxhub.funcs->init(adev);
>   	r = adev->gfxhub.funcs->gart_enable(adev);
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> index f21554a1c86c..594bffce93a9 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> @@ -3129,6 +3129,8 @@
>   #define mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32_BASE_IDX                                          0
>   #define mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32                                                   0x15cc
>   #define mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32_BASE_IDX                                          0
> +#define mmGCVM_DEBUG                                                                                   0x15cd
> +#define mmGCVM_DEBUG_BASE_IDX                                                                          0
>   #define mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32                                             0x15ce
>   #define mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32_BASE_IDX                                    0
>   #define mmGCVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_HI32                                             0x15cf
> @@ -3151,6 +3153,8 @@
>   #define mmGCVM_L2_BANK_SELECT_RESERVED_CID2_BASE_IDX                                                   0
>   #define mmGCVM_L2_CACHE_PARITY_CNTL                                                                    0x15d8
>   #define mmGCVM_L2_CACHE_PARITY_CNTL_BASE_IDX                                                           0
> +#define mmGCVM_L2_IH_LOG_CNTL                                                                          0x15d9
> +#define mmGCVM_L2_IH_LOG_CNTL_BASE_IDX                                                                 0
>   #define mmGCVM_L2_CNTL5                                                                                0x15dc
>   #define mmGCVM_L2_CNTL5_BASE_IDX                                                                       0
>   #define mmGCVM_L2_GCR_CNTL                                                                             0x15dd
