Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53394EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 17:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E262A10E5C3;
	Fri,  7 Jul 2023 17:15:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E5C10E5C3
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 17:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOTLFRiUKPTeZoGr/iJvjRUon/1dQ7NpUICmv5VUZckW5wK7Tm4YVtc8GsfcT3rBIQM1KfnqIq8+/k6Zt9MYmUVrYZzuVJNF96i2tY75ZVdY1ghdyIL6cSCMWe8sRcTBOCIV7Cv1cW+Zkux5pHAQDlrggj5F/ehmEn/r8UxND+Ha3+wB9UXrmnjDHdRVnRcP4s66PgF00pn8UaxMz8wpURJ6vzbBXsZI0F4ICQZ+kpAkrKoZnvHv/D6NrRTH1zCV+3Eo3n7CJaIgwqDafs5A7oyTx6hc6aUpkFCbdFbrEEO2wj6mrGA7W+zke1T8DZjHj4P62LJp8TZm0htAxr0OuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vPdh/M5ywYD7dfPULPiQgTbDsjiQpEoMcQxeojx4j8=;
 b=i1KoOkd4V1cR+3ROQ+/gXm1OMVkEua6x0LFr4TSvI8fm7wCfI1K8IEWeSGYqPIhjfEObXDWKtQtl1Aiw3VtQX+BC4LSYLj3NWbAr7q/Ly6Vv0RRm4YwHkZCo1zV5KDDVc3lnTt17VjKpZSMx86AbJHLTmxn6QnZLMO0tG6EEiumDd3+RdNPhI5HKI36AV40FDZSlmWE+yg+dXRoUMDl6MccueG8FqjLYV37PBERQFhLEhr67WH+NCmYUVfbPfb2W8K5rZc3UFkF/Hf1ZahWMCoO3Nnz2q7vJjlTmANFlTl909/KhQgaQYFYFnHRzBCAaQ+jy4tExjbSiz7MP2dhXvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vPdh/M5ywYD7dfPULPiQgTbDsjiQpEoMcQxeojx4j8=;
 b=3aojQTDmeFPO+Ja0kYclqovUXb3KkvyZiJxozSWSpZ6varyOggSweTlruGEXFe5RhTKoUDIWwCDj7rVwjv+KURfDLwByNo8NgJfCOwHgERah/LQC9HSG0ALClg6KHNf/Ux9ZrlpaZ6/uwdzwwHftoMolsUO+vPZagQI10coDQz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 7 Jul
 2023 17:15:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 17:15:40 +0000
Message-ID: <2f659574-3ef8-fd74-33a5-9f7c7dac7a60@amd.com>
Date: Fri, 7 Jul 2023 13:15:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdgpu: Increase soft IH ring size
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230707154901.29568-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230707154901.29568-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0242.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b2dcd90-726a-440f-f686-08db7f0dca24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDNeGpTzYkLh9WKEY/3iVOxeXMkSROwAFnRQWhyjQS3FNk/F0eCqJdgBhV00oM9tGcDiwpQpA/rCVJRQYBph7GpCDgtcZK8sru6k6eFm3RCjJHmhjy2c8YuEO+Tdn9oemxSJvjsUqx4jv4EVaPLAD6aWliRyIj8SBuiQfQf9/TmP9Cq3ErhAoYrPbLxRMfp7/nEYMfhp+2S7t89YKhvSt4UWPr1fcYvLHy3lONmvRI1uS6YqlpST5PiAVemqTCzu0b9px4sR2dwSmNRbheWJLe9ZIMwuibVOCZfLwMbqQl5R1NvhAsJDbjWmlq7KMN9l2KNlGJ71mwknCqiUOzO853hOJd2Hfxssu+i0s8z52h1JbCyr2zXVLMRMsLoHR4D5U4K/4q26Q06GPH0tKOTbQifx8fN8k+XSQpISL4WJqUZw88JfL3amLbvl92p3cEqfggCAKqgvcsXILzpYGjiJ9dviTzyWpYDfTMp7DiklgqtxAKfXm8VRat1jzLy9uUaMDhRmFXAQAsbDNpWUJ7A0h0hs8QRniYVzojRF0xBr+MyYv3mQYZWPkeCPMhZGrx860DS++Wdl6L8B4mY4QqNZX5I5JIyYElK+YIXKctVfaHKVTNDN3B3F7tOe41sFiY6NYpjGqvok7Cpd/aANGXZQag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199021)(186003)(478600001)(8936002)(8676002)(36756003)(5660300002)(31686004)(4326008)(6486002)(66476007)(66556008)(66946007)(36916002)(316002)(6512007)(41300700001)(38100700002)(83380400001)(53546011)(2616005)(6506007)(86362001)(31696002)(26005)(44832011)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVBtSldWVGIvajEzeWZDREFuR3UrQTh4Z1YyTkppR2lXdUQvLzhFV1dLaStN?=
 =?utf-8?B?V25nWGdtUFBIN3lzQXRBMFk2Mndoc0tzajBPRU4xQWJ2bFZGT0I0dWNJYzNo?=
 =?utf-8?B?MkNFWXczSDdjMWRuaU93TDNmUnVQOGZGdWlpdlV3elNXdXJhekhxRDROWXZl?=
 =?utf-8?B?NENzQVN6R3VyVmxqNXRyVHEyRGthOTh0THlhL3RVRG1xSjBaSXN1VHZzYUFT?=
 =?utf-8?B?VDFhSWhvYVVqTXJabHBESnVWSXYwWGppTktrNTlFTU55emVTdDJyYVcyMjF5?=
 =?utf-8?B?eDJnUkMvU3lwL2dxeHJ3TGllcmVlV1VqKzloMExPSUJXWDEySGlwTjlYek5F?=
 =?utf-8?B?SjU3M1prdENtMko2U0g1ajM0azZSbEl1YmFSZUtKVjhIWVZGY3RyRVQ1SXRv?=
 =?utf-8?B?Y3hLd0RadDRUcklmVWg2WkUrTHN1WittOGFTRmkySTByd3BlWEFWM0RUNThG?=
 =?utf-8?B?WEREZjJ3bVJ4OXZ1WmNtNlBiQnRkeElxOURGSWRHN3NRc3oxblVtRUxxTnAy?=
 =?utf-8?B?ZXVwNk1wNUR5UmV2dzE3WUlTc0t6dSs5bkQ5bHlDN2NtWDI3aFBXQTM1bWdQ?=
 =?utf-8?B?V1lJVEpubG5WV1REUCtGVVZTOXNuS2EzdFFRZHRPTnFyS3JLTXhjNFlsaUEv?=
 =?utf-8?B?NkZmZG92ZVZ4Z3N2d0lHbUt6NXUxSGZUbFM0TzI3QXUwTEVDcDEyMmcwWFRp?=
 =?utf-8?B?RkdyNkd0NnJ4YUdUY05sYzQxdVEvWHMxaGFlMHNMRTdHSlpjeHpOd2lVOUVS?=
 =?utf-8?B?OGgrTThWdHRORUJXaVdZSzBCYTZMQUhvM1dNNzI5Uy9RRW9xeWlDV2tRV1U4?=
 =?utf-8?B?OE9hZkJUdW4yR1duNWVSTUZ6ZGFza09UTzlRejV1REliRUVENGZrNThkREFK?=
 =?utf-8?B?MlY0TjZqN3kzOEZYY05rU1AwK29KVXdPWDBtWkpTQmowTHFOd1NMTlJXY3Jw?=
 =?utf-8?B?bnZLd3hpbTNPZThzT25zYVpDNGVsaXA1NUtQWHMrdGRjZ2xpbGFKVUdNcTUx?=
 =?utf-8?B?UTBsZHM5Qm9JWDNtdm9KbUluQ0xTSHpqODVMUmxQWjFBYXpTL2xrYk1XdStH?=
 =?utf-8?B?NjlZUTFFcmxhK0lodFJReFFXVkVqaHB6ek5jUU9iMWtENW1kNnlla25WcGR4?=
 =?utf-8?B?RHZsY0JIWUs0dTVXUi9qSldUUmZzK0l4bkM0eFU5ZTFzVldqaGpTb0lQZjRE?=
 =?utf-8?B?di9tRzBhVDJIWGtlZThSQitoUm4ybW8rTXRkVktPQXJhcWpFdzNETHFBL3kx?=
 =?utf-8?B?MmQrOGYvZGUwbnRKRFpML0RYRVphVGxwTE1GVkFvcTQ2WHNiaTdmV1o3dkFv?=
 =?utf-8?B?NWxCaHpYN0k3R2FKbFBZTTlobWhvbCtGUFdxMmhDYVd1V3ZUSzBKOHFHeEgw?=
 =?utf-8?B?eDRUZklZY0xHR2NxdDdVcHppQ1YwRzFCbnUxek1Lc1dYTUlvV0NjeXhkMlpj?=
 =?utf-8?B?Um5BbXp2bVhFaEJab3VZY1JZRm5tK1JFNVNpV3BTdllaeFNHd1p1NEM4WkE1?=
 =?utf-8?B?bnp4YUpyVlZvVUowL3lyTnl4ZmgwQzZ5NTE0RGNWcFFtRjNzaFZsYkRwV2Nz?=
 =?utf-8?B?cFpaYmg4dzZLRW0yRkhJRVZiMDh0T1JNV1dsa2NNZ0pVVzlIbFNYaWNLNStK?=
 =?utf-8?B?dG9GZGxVbWZIMEUxMjVXcUk3Nkl1aVdDLzJhM1AzUDJtRXBzb0xjOStjNWJz?=
 =?utf-8?B?VVg0WlMyUlZQSFRWWXpLcnd0dUptUE9obkVMdERlOUpoYkNWK3BWUGhhL2s3?=
 =?utf-8?B?RFVSc3Q2eDVjVFFLSWVxWm5aMXJmbk4xNDl3SXJKRlc1Q3pqVm5tbXExakNq?=
 =?utf-8?B?NTVDM0YzdjNXVXJWSlRDWXU4dU9QLyt6Qnl6V0xTTnNqeC9XYVplVDJ0bEpj?=
 =?utf-8?B?SVJnZWJhRHY1ZjQ3RElOTlFHOXVJRHdGVEwybDMvTm9QVXZYRlNYYXpBK1pa?=
 =?utf-8?B?WVZHRjJ6L2xzUjVnVVplemlHZVY4WE90MlVLM24zckVVM0NtNDNaWStsblln?=
 =?utf-8?B?SHlZeWc1S1pGc3dOQ2ZISUNJNkVyTitndHJtRjA5c1g2aGRWa0MvTXYrNnJz?=
 =?utf-8?B?U2psSGpiS0FGakF2NW8wZnhQeVhGNjNER3N5VlRRSGphYVEwWXJDd0pDMjFx?=
 =?utf-8?Q?+KVrDBjS8h5IvQHyH2bphuO+b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2dcd90-726a-440f-f686-08db7f0dca24
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 17:15:40.7997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/k6kS/JyoHnVIl4fCMlFaKXr1gH+PjRLEmuqm1xJ18geU4WihMDtlemFMc4a9RQX3ucIRsoZlbhtvaDxWfZjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754
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
Cc: mukul.joshi@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-07-07 11:49, Philip Yang wrote:
> Retry faults are delegated to soft IH ring and then processed by
> deferred worker. Current soft IH ring size PAGE_SIZE can store 128
> entries, which may overflow and drop retry faults, causes HW stucks
> because the retry fault is not recovered.
>
> Increase soft IH ring size to 8KB, enough to store 256 CAM entries
> because we clear the CAM entry after handling the retry fault from soft
> ring.
>
> Define macro IH_RING_SIZE and IH_SW_RING_SIZE to remove duplicate
> constant.
>
> Show warning message if soft IH ring overflows because this should not
> happen.

It would indicate a problem with the CAM or it could happen on older 
GPUs that don't have a CAM. See below.


>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 8 ++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 7 +++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c    | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c  | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c  | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 4 ++--
>   7 files changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index fceb3b384955..51a0dbd2358a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -138,6 +138,7 @@ void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>   /**
>    * amdgpu_ih_ring_write - write IV to the ring buffer
>    *
> + * @adev: amdgpu_device pointer
>    * @ih: ih ring to write to
>    * @iv: the iv to write
>    * @num_dw: size of the iv in dw
> @@ -145,8 +146,8 @@ void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>    * Writes an IV to the ring buffer using the CPU and increment the wptr.
>    * Used for testing and delegating IVs to a software ring.
>    */
> -void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
> -			  unsigned int num_dw)
> +void amdgpu_ih_ring_write(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
> +			  const uint32_t *iv, unsigned int num_dw)
>   {
>   	uint32_t wptr = le32_to_cpu(*ih->wptr_cpu) >> 2;
>   	unsigned int i;
> @@ -161,6 +162,9 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>   	if (wptr != READ_ONCE(ih->rptr)) {
>   		wmb();
>   		WRITE_ONCE(*ih->wptr_cpu, cpu_to_le32(wptr));
> +	} else {
> +		dev_warn(adev->dev, "IH soft ring buffer overflow 0x%X, 0x%X\n",
> +			 wptr, ih->rptr);

If this happens, it's probably going to flood the log. It would be a 
good idea to apply a rate-limit, or use dev_warn_once. With that fixed, 
the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index dd1c2eded6b9..6c6184f0dbc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -27,6 +27,9 @@
>   /* Maximum number of IVs processed at once */
>   #define AMDGPU_IH_MAX_NUM_IVS	32
>   
> +#define IH_RING_SIZE	(256 * 1024)
> +#define IH_SW_RING_SIZE	(8 * 1024)	/* enough for 256 CAM entries */
> +
>   struct amdgpu_device;
>   struct amdgpu_iv_entry;
>   
> @@ -97,8 +100,8 @@ struct amdgpu_ih_funcs {
>   int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>   			unsigned ring_size, bool use_bus_addr);
>   void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
> -void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
> -			  unsigned int num_dw);
> +void amdgpu_ih_ring_write(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
> +			  const uint32_t *iv, unsigned int num_dw);
>   int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
>   					    struct amdgpu_ih_ring *ih);
>   int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 5273decc5753..fa6d0adcec20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -493,7 +493,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
>   			 struct amdgpu_iv_entry *entry,
>   			 unsigned int num_dw)
>   {
> -	amdgpu_ih_ring_write(&adev->irq.ih_soft, entry->iv_entry, num_dw);
> +	amdgpu_ih_ring_write(adev, &adev->irq.ih_soft, entry->iv_entry, num_dw);
>   	schedule_work(&adev->irq.ih_soft_work);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> index b02e1cef78a7..980b24120080 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -535,7 +535,7 @@ static int ih_v6_0_sw_init(void *handle)
>   	 * use bus address for ih ring by psp bl */
>   	use_bus_addr =
>   		(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) ? false : true;
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
>   	if (r)
>   		return r;
>   
> @@ -548,7 +548,7 @@ static int ih_v6_0_sw_init(void *handle)
>   	/* initialize ih control register offset */
>   	ih_v6_0_init_register_offset(adev);
>   
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index eec13cb5bf75..b6a8478dabf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -565,7 +565,7 @@ static int navi10_ih_sw_init(void *handle)
>   		use_bus_addr = false;
>   	else
>   		use_bus_addr = true;
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
>   	if (r)
>   		return r;
>   
> @@ -578,7 +578,7 @@ static int navi10_ih_sw_init(void *handle)
>   	/* initialize ih control registers offset */
>   	navi10_ih_init_register_offset(adev);
>   
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index 1e83db0c5438..d364c6dd152c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -485,7 +485,7 @@ static int vega10_ih_sw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, true);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, true);
>   	if (r)
>   		return r;
>   
> @@ -510,7 +510,7 @@ static int vega10_ih_sw_init(void *handle)
>   	/* initialize ih control registers offset */
>   	vega10_ih_init_register_offset(adev);
>   
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index 4d719df376a7..544ee55a22da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -539,7 +539,7 @@ static int vega20_ih_sw_init(void *handle)
>   	    (adev->ip_versions[OSSSYS_HWIP][0] == IP_VERSION(4, 4, 2)))
>   		use_bus_addr = false;
>   
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
>   	if (r)
>   		return r;
>   
> @@ -565,7 +565,7 @@ static int vega20_ih_sw_init(void *handle)
>   	/* initialize ih control registers offset */
>   	vega20_ih_init_register_offset(adev);
>   
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, use_bus_addr);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, use_bus_addr);
>   	if (r)
>   		return r;
>   
