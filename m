Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B917C77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 08:56:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29E4E10E6CC;
	Tue, 25 Apr 2023 08:56:24 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21B0310E6CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 08:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3YGLDYxbTyXyK3Z8+7Z+iKzVW0+V9PvcDk+92sG+ERoxgSh2DX/zvRm6hMultsgRTvD8tWNo8zNIr1nhBtNPV8Anth5v3VziMnVPUxFAhrNjUdMgZeQ+KABdZUrBR+dE+8V5OJ0Nxsegv0kC0/q3OXrVR4wMoQzvbIZ9q8D8qF7CRf7r5N+gl6e0TIvkcI97YbBxJUE39Di34IRGmKREDuqMch0YWuuY8IXB6fVIaCu1uxJt3mkDXEd/JPpBnPes6pBzhMIJqjAEQ5EJu6pSXw4zhXNT87C/p6KX7CLxAUVBVjcVOh2Ir9wGmxSPv2E9IuI1fN5JbTzBoXazbwCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPGQIpXIFEp79EtWAFCqLZBQVYFRsS2HwVqtEWPjjsg=;
 b=IiCA7+t2LR0AFOnGxqObNS8ASg887DiqLbrImwe+db6K/hVzx6rPsKUcHEYZyLHokk77QO0PWsWZkP07s4zv0KMsL+9FEQUuCS+63MH3SABzhFStFZoGhu4apAiqL50kTeuz6hzSXbKeFvKU+BWAmJqXsPwzeLA8vvV7aGviKtLti1cSwQabTKcsPxt4PGD+GUfn5Q0CZkH4opuvSQeKrR45AZ2FnTJvK5OEHCK8wLhCsLSu+427QaYUd10/oDNh+SIoU15QjaZhkK44tv8YWQcqPMEewmROaNmsEC1gaYaUW/G8JBTQwRtAs8wAGeJSTRTD0SesmcUWWW21YPiOVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPGQIpXIFEp79EtWAFCqLZBQVYFRsS2HwVqtEWPjjsg=;
 b=Z5xXZlasvWVjUbU9X6jnwGR1yyfrYpjAxSwW2EYf4uw7oY3lknFn/ZPIAAyHQf3IAl0A57+2NqR+ZzkkBHWf/thap/iXOTmLWNGdcmECRF0+gnNNaxzjBAiu5OR0c2P5ygt6TLxkrNL0jaq4Q/LaKtIxdTMIzqSBFI4Ydrku6i0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB8115.namprd12.prod.outlook.com (2603:10b6:a03:4e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 25 Apr
 2023 08:56:19 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 08:56:19 +0000
Message-ID: <9c53cf2e-eafa-7e62-239d-0a6a8a593959@amd.com>
Date: Tue, 25 Apr 2023 10:56:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/3] drm/amdgpu: gfx_v11_0_cp_ecc_error_irq_funcs is
 not needed any more
Content-Language: en-US
To: Horatio Zhang <Hongkun.Zhang@amd.com>, hawking.zhang@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20230425063837.26701-1-Hongkun.Zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230425063837.26701-1-Hongkun.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3ed222-41d2-411d-0e70-08db456aef63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wj2V5qP+NLktFm+kyw8dOxyk3sjMkftDxQD0OEQnU2prUy4kK/aT50fI/VhhKnuhWq3zGo1yTaBunttzhFbacC5Xy3CbVZ2GUHYr9DjmtFNt73YaQ0T/1uw/2o9yHD9tvbCzGDLAfey5VnDfVTKafC4P7Kd+zWnWSIG3Ydncn6prIiKq48KTdPX6Ewo33Wd7ZcabnnbvOJVi0K8Y+lf7MiUA/Um+kzonuZAJvc2Qf6Znn4K5rZIUO3AXCDehBzmjImE8c83hzFUGqapJa4LlR6i4wNlb4eVV13AFMIlygBOAEPHz6J36T/eVTFTTT0irfYY859vA/Wc1Y2vYOZJjExZwOIjHoqVW0RZlHiWnOkJcSbUJPqjodKeOvLJMqB4HVfw7+2J7Z7Wt/mbAOnwbeGPYaemGSJHrtFKXdQWjj9PiQjxcX3xqy3NwNqTgaIDZePssR7pKcLkO60ulxtQFi4LvjLXCppWbVJEncpnv7jlyAEGGh7sMSPttPPJ7jWcYcjMvnEsRA0edE4kgIUrOFZp+FEub+jnzhb6ADtq1LZHcfg5f4XIapTGniJXFefyLLR7P5WbbCA6l3I0Ke+neYHu5ANfkZTt5/+Jq+aO7xz2eYUeKA61dCTLWS+yKbKo++aP21MEKjlDA/6RlhJX9YQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199021)(66476007)(478600001)(6666004)(8936002)(8676002)(316002)(4326008)(66946007)(41300700001)(66556008)(38100700002)(186003)(2906002)(6512007)(6506007)(83380400001)(36756003)(31696002)(31686004)(5660300002)(86362001)(2616005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2RJOVJ2UHZQL3gvcHVWOVY5eFhxSm5LRjRvMUYzb1VaMmZrbGNyOGdkdEdG?=
 =?utf-8?B?aUg3K2FEMytaYUVKa2ZZS20xcWw0S0FsY3EvY2VpenUwVGdLbzNTcFlIK0Fp?=
 =?utf-8?B?Ym1udzNjOFd5TzRJU1RTbWpCZ2M4T2krL2NVOVVwOGZDaFJPRFhWMDAyek5T?=
 =?utf-8?B?VFByOVJIZ0E3NS93ZHJQZ0ZuU28vYlBoMDFEOG44c3U3YzdXUzZ1V0RPSTRR?=
 =?utf-8?B?WUNOSHlxTzI4VEpWLzFlMVFzVWNZc1FHTDhZRWpTVTZGNVJUS1R5Q1ZDdUNJ?=
 =?utf-8?B?dExidExFU0gvWEFkcnh4OElla1ppZThDSGFNYVN5d1BhZkZVVXpPTk1JTWZh?=
 =?utf-8?B?VUJicFBVSmMydkdjdG5IR3dXWDQ1eWFXK2wzWVN5QkY1TU05dzRNVlZGampu?=
 =?utf-8?B?eTh0bWJnZS9xYk11UmdDY0hQYno0a1ZzVVNXOTltRnoyaGNaNm9qM3A1ajN2?=
 =?utf-8?B?c2VlcmZlcjZtREpVTVVaUEFHQVNsc3hWMEErZi9NenA1ZXV1Z0MyZ2NDSm16?=
 =?utf-8?B?UFJ5OUF2Q2FUanZhVzBXTUs4Y2JYTWgxU3VueEdsb1E5TTF5dkxXYmI3QkIx?=
 =?utf-8?B?TW8xL1IveDYza3YxSDRSM2F2VUVRL3dKSDgwMHhqTjdDeVN1dzB4U09LWDZV?=
 =?utf-8?B?VllyUzgyTDczRFpJRUE0bkt6Mm5XckN5WVFqWVkvdjIrRktxZzhTUU5LY1N5?=
 =?utf-8?B?SGQxQThoeEtxZGE3dVhWZVBxWDNaVlJxMkxndEhCODBVVGJMRTFCYmV6R2ZD?=
 =?utf-8?B?WW9kUHlzR2hEU2hub1NDLy8vMHZYK29pTE5jRXpSOHdXdEFvUHJSd2hNbGVO?=
 =?utf-8?B?elNuWTRBcHl4L3lWMnJVcjN0K3ZiY0V0MHo2c2dzaHpWUUlvUFh1bk5NQWgv?=
 =?utf-8?B?QkdOaWZtY3ZtTm84Nkd4ZlV5WHVpa2htZGR1RHp1WHlxQk43N3E1WWMxK3Ja?=
 =?utf-8?B?Z0kyNjgzRVZUVUNzNTdSSHZMWXdoSVlPb0Q5SVRvNmxLS1hOR2NrK2EvMXMr?=
 =?utf-8?B?UTBLaUxTRzdwaytXZ0pyZjUvWXFPSk5WV1EzVEJZUXBOWmk0TEdRc05MS3A1?=
 =?utf-8?B?Ry9Ic0VyUm9yQytpSENHMDNubmtZWHA5cXBaMlJRSysyMXNyMDZKclpLVGVa?=
 =?utf-8?B?RkkyVVhGRlFuZGRwdzZvTXpVQnNSSGxuWU4vUzdvZG8xdlU5aXZ6SjQwYUtq?=
 =?utf-8?B?S2FhcFQwTm9WclVaM2pScitDZ0k5dVNYK2tnVDFVZnNBMmFmaXBvRGwrdUlJ?=
 =?utf-8?B?YW1rbjBiT2lYMkpBckNmRVdkdDlJbysrdURjbk9vN3l0QW13RzRIWVdWdkpK?=
 =?utf-8?B?aWVrcTcvaUdsMmhFbDUwSHM2dUJndENKMzVTWStJUXhNU2dhem5hdkErMjhC?=
 =?utf-8?B?cXhERWRIVjdnYzAzclVNb2hiQTNxdG1NdDh1cktXZXRMVCszNWdhZjBJWDd4?=
 =?utf-8?B?bVlBQm5CUlZINTFNeFgwZk1PeDY0azlkd2dqZFg4SjhSOFBqZ2NnUmY0ZEtG?=
 =?utf-8?B?VGJVV2JURzloME90WDFyZ1JmSDZjWEZjOUFsdDYrVmNoYVE5U1M4Z3ljV1Fy?=
 =?utf-8?B?dnl1dnVRL25yTHRwSnpxNnVha1pZQ2Zxc2FnS1JiM3h4YUhyMGs2YTNBN1Ns?=
 =?utf-8?B?UWVTdmtHb0xxeVVYMHFzV0dPU1JCWEl6L1R2aEx6MXFIVVB0a05MNi9RSnZU?=
 =?utf-8?B?K2VvZE9Jcmg4b0I1cFdmTkhQY3N2cGk3eGVtaUV1b1VHR2pQTVNMbEVJL2Nh?=
 =?utf-8?B?WG9JdDhZODNVTVdyM2NzMUJkYWliei84RkV2Z2Q1K09oK0xMSHVYOUZGWExY?=
 =?utf-8?B?S2Izc0VUR0xvYXN6OVB3N0JyUXlDV2V3Nks2MS8vczdtcTU2aFVjczNWZURX?=
 =?utf-8?B?TklpNm5OdTVieStIVXV5bVIra0NXdWtKSmdxeC9mTjdhaWdFd2VNRVRLUGVB?=
 =?utf-8?B?b2FZWU5iWnNHY243WlM1VjlxbmUrNkxCRDhUNDdMYlRCcEUwNEFOcERYZHk2?=
 =?utf-8?B?bEFyR1M0cVl1UU5ualJJeEM5WmIxVjUydHd1OG9kUmY1V0pBckZFdStKWGdP?=
 =?utf-8?B?bUF2ekZqUWx5MUJhei90UXZFRnhtT3V1VkYyMEtyVjF3VGFzbDRSRlRZZ1JD?=
 =?utf-8?B?M3ovSkJORlZRbTZkc1kxT2MzdVQ0Qk1aZDIwRFVWQVZRMUFxS3RKc2Y4b2Qx?=
 =?utf-8?Q?MNPiPdXz/bSWevbHB6SN3/rZXSYxKHY1/QHN2ocxJoCh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3ed222-41d2-411d-0e70-08db456aef63
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 08:56:19.0632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1EXwDqbdjvIUPqQoyT0/83TLRX2j41rV9zBUBi4/HccaxheZNvoJIjxR7wL/b40
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8115
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
Cc: longlong.yao@amd.com, feifei.xu@amd.com, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.04.23 um 08:38 schrieb Horatio Zhang:
> The gfx.cp_ecc_error_irq is retired in gfx11. In gfx_v11_0_hw_fini still
> use amdgpu_irq_put to disable this interrupt, which caused the call trace
> in this function.
>
> [  102.873958] Call Trace:
> [  102.873959]  <TASK>
> [  102.873961]  gfx_v11_0_hw_fini+0x23/0x1e0 [amdgpu]
> [  102.874019]  gfx_v11_0_suspend+0xe/0x20 [amdgpu]
> [  102.874072]  amdgpu_device_ip_suspend_phase2+0x240/0x460 [amdgpu]
> [  102.874122]  amdgpu_device_ip_suspend+0x3d/0x80 [amdgpu]
> [  102.874172]  amdgpu_device_pre_asic_reset+0xd9/0x490 [amdgpu]
> [  102.874223]  amdgpu_device_gpu_recover.cold+0x548/0xce6 [amdgpu]
> [  102.874321]  amdgpu_debugfs_reset_work+0x4c/0x70 [amdgpu]
> [  102.874375]  process_one_work+0x21f/0x3f0
> [  102.874377]  worker_thread+0x200/0x3e0
> [  102.874378]  ? process_one_work+0x3f0/0x3f0
> [  102.874379]  kthread+0xfd/0x130
> [  102.874380]  ? kthread_complete_and_exit+0x20/0x20
> [  102.874381]  ret_from_fork+0x22/0x30
>
> Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>

This goes deeper than my understanding of the hw so I can't fully judge 
if this is correct or not.

But from the general idea looks good to me, so feel free to add my Acked-by.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 38 --------------------------
>   1 file changed, 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 8a4c4769e607..e9491aec3cae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1355,13 +1355,6 @@ static int gfx_v11_0_sw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	/* ECC error */
> -	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
> -				  GFX_11_0_0__SRCID__CP_ECC_ERROR,
> -				  &adev->gfx.cp_ecc_error_irq);
> -	if (r)
> -		return r;
> -
>   	/* FED error */
>   	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GFX,
>   				  GFX_11_0_0__SRCID__RLC_GC_FED_INTERRUPT,
> @@ -4483,7 +4476,6 @@ static int gfx_v11_0_hw_fini(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	int r;
>   
> -	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
>   	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>   	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>   
> @@ -5970,28 +5962,6 @@ static void gfx_v11_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev
>   		WREG32_SOC15_IP(GC, reg_addr, tmp); \
>   	} while (0)
>   
> -static int gfx_v11_0_set_cp_ecc_error_state(struct amdgpu_device *adev,
> -							struct amdgpu_irq_src *source,
> -							unsigned type,
> -							enum amdgpu_interrupt_state state)
> -{
> -	uint32_t ecc_irq_state = 0;
> -	uint32_t pipe0_int_cntl_addr = 0;
> -	int i = 0;
> -
> -	ecc_irq_state = (state == AMDGPU_IRQ_STATE_ENABLE) ? 1 : 0;
> -
> -	pipe0_int_cntl_addr = SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE0_INT_CNTL);
> -
> -	WREG32_FIELD15_PREREG(GC, 0, CP_INT_CNTL_RING0, CP_ECC_ERROR_INT_ENABLE, ecc_irq_state);
> -
> -	for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++)
> -		SET_ECC_ME_PIPE_STATE(pipe0_int_cntl_addr + i * CP_ME1_PIPE_INST_ADDR_INTERVAL,
> -					ecc_irq_state);
> -
> -	return 0;
> -}
> -
>   static int gfx_v11_0_set_eop_interrupt_state(struct amdgpu_device *adev,
>   					    struct amdgpu_irq_src *src,
>   					    unsigned type,
> @@ -6408,11 +6378,6 @@ static const struct amdgpu_irq_src_funcs gfx_v11_0_priv_inst_irq_funcs = {
>   	.process = gfx_v11_0_priv_inst_irq,
>   };
>   
> -static const struct amdgpu_irq_src_funcs gfx_v11_0_cp_ecc_error_irq_funcs = {
> -	.set = gfx_v11_0_set_cp_ecc_error_state,
> -	.process = amdgpu_gfx_cp_ecc_error_irq,
> -};
> -
>   static const struct amdgpu_irq_src_funcs gfx_v11_0_rlc_gc_fed_irq_funcs = {
>   	.process = gfx_v11_0_rlc_gc_fed_irq,
>   };
> @@ -6428,9 +6393,6 @@ static void gfx_v11_0_set_irq_funcs(struct amdgpu_device *adev)
>   	adev->gfx.priv_inst_irq.num_types = 1;
>   	adev->gfx.priv_inst_irq.funcs = &gfx_v11_0_priv_inst_irq_funcs;
>   
> -	adev->gfx.cp_ecc_error_irq.num_types = 1; /* CP ECC error */
> -	adev->gfx.cp_ecc_error_irq.funcs = &gfx_v11_0_cp_ecc_error_irq_funcs;
> -
>   	adev->gfx.rlc_gc_fed_irq.num_types = 1; /* 0x80 FED error */
>   	adev->gfx.rlc_gc_fed_irq.funcs = &gfx_v11_0_rlc_gc_fed_irq_funcs;
>   

