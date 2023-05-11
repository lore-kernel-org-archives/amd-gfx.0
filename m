Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1199CC77B7F
	for <amd-gfx@archiver.kernel.org>; Thu, 11 May 2023 17:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A417010E5C0;
	Thu, 11 May 2023 17:54:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFEA810E5C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 May 2023 17:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHxOH4odIpQuMehWMjsdn5m/s90GMkRabQJ2e3VjThCxInv0nOwQsmbY31nQ7yHJuloEwR4HgUWPnzlj2Bbq8117JyNiMRxhfvGYgqSlMHzHzi5hG9MyU+LJ1wac7Mca2XlP6R1wlszEZWMQw4py74Pflh2ZDxh7MMN+0FOvoD33s0K8cLqkykWGmxvd96rD/MMLEBhH3xhro5AFXPzUZ3Jc4CukpqcoGrLGLRqdQ575AkVQcL26EJRaY9M3gap0HeLIfE2Gj53nEAZusVPbtpYTQmHbyPlYkyo16Y492IxYqByNGuXePVcFW6E0CIEkj6uLmO/txL816XalYH5uyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AHrfj35szbjFbKehU6eRNA7vQPKucoRzjPmlteEYRQ=;
 b=LySMdkDH3sijV47q0DT54fXJMT8mFdBR9AqPdTTQymkydC/dfTuQW3gME8HVKbAXielc19uCKjGryzpgB8zURP+pCETZ3mGp/l5HmHQ34PJiSwRxBZAUFtC5TL5W6712h92bMw3sRXzNLZYAJk4ImXYy1e3cjksOp2R2UqeAy+yD1NaYJQDHdN4th2yXQVDbNGBnxVVk5DgDo+VqvBOSo/Z3qmead0+wGKhvA32SUzLM+ANpHLTIdv+EYAhoJALFC5k/IqS+pngNlvn337Zn+WCLL6IcQcvjO63CkQAkVXGMaSuJKR5Er6yS4QAeSfVwFa+08gDXCm9EFvnh44BGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AHrfj35szbjFbKehU6eRNA7vQPKucoRzjPmlteEYRQ=;
 b=X2dIthfe2ebAyj8swUG1IGGZrnUu+eyM0G9RUzoQVJnvqhhmodBiXbXsQ6aZLYIa4y5lBWSO9fMS1RWiK5RQNDgcrhEGQb4Jj0z5pS6z/cmL+suUreATtN3l9Owv+AtLP9ixktntCmOkJRNAGFMNo92WQH/s5+HoM9WIp4jBrWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 17:54:14 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::3d88:4b4e:e0aa:3c36]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::3d88:4b4e:e0aa:3c36%4]) with mapi id 15.20.6387.019; Thu, 11 May 2023
 17:54:14 +0000
Message-ID: <f28ea469-40a8-7e0c-75d4-f108a88ef0f0@amd.com>
Date: Thu, 11 May 2023 11:54:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] drm/amd/display: enable low power mode for VGA memory
Content-Language: en-US
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230511153807.1154612-1-aurabindo.pillai@amd.com>
 <20230511153807.1154612-2-aurabindo.pillai@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230511153807.1154612-2-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0876.namprd03.prod.outlook.com
 (2603:10b6:408:13c::11) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|PH0PR12MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: a153a138-87e3-4ad5-7edb-08db5248bbc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b836eBVFlNIYU1triV4RpSM2zBgxE8bgID4QjBBB5NSNA3c+Hr7+zk37/4IqePOn6cJv0YZ4v5/t3CdgRutanp7vQD5UI5J1h+qUOQsvgAQjYz9EEAvGh1mBZVXpTPMeEK8FEZCBpy3q6x4q69aUzAdIqREYaNYbQTWgNYvWMsfGPCnw3AbmImo6fTedHKp5HdAYNAqRjSAwYyZ0firMvhHJkem46A7hyelrRflQNVdJR8SJjxhxkJPELy3CsBEDawGXlqjuT5gcNWH722h/fYu1D77EBeG7nYqh44x7UCNIesVjfBw/xVZAFuvL/ZAxdUWaRcDNaCo5bL7pqF1VJhQ3Zqhr+JoHOSncQky6fmdeDBCl34PlgeY+YCnWv2iiUftp8Kb3iX+n8i7WkaKxcTOUbH0zChyI4hk/syLw6S+iFYfgluAfwmEbz1FRtF+gL4B1JxrDW4x1laN3FkpdR+gC8dE2sotH+EJQp7HqHaaaKqE2m25vJFJ3dQzPZeT9d8svXvvtsTyY27VfFyMlPNjDo2rD1Iuvid7EKnfoFwHIsQYxZEbvjc1Vf2uc23RGov8ot7yUTpFSZJ0zPDopW1D3NQT7iK+guN+K9OmuZ4GaDIyVLEY6qHSm8b7viYTj7Cr+QRk/ejJpU2AU+X71Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(6486002)(2616005)(31696002)(86362001)(8936002)(8676002)(38100700002)(53546011)(36756003)(186003)(2906002)(5660300002)(6512007)(478600001)(6506007)(316002)(66946007)(31686004)(83380400001)(66556008)(66476007)(4326008)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QS92RG5pakNLK1JLNWIrMmdmYW9BQjJINGJ6YTVtQ3BGVlEzNDJYUlA2N0VP?=
 =?utf-8?B?Rk5uMzMzU0ZTV1A1KzEvUVc3MlFScDgyVHFuS3gwN0hLbXlkYTk5RS9uYUpw?=
 =?utf-8?B?MDVoNHBLb0pmTGwrK3oxZzY3V3VUNmN6OHViYmZRY3QwUTVHdkExZStGYml5?=
 =?utf-8?B?aE9SV0RKY0NrejFyUnRQcFRKTGpaSXZkckxNNy9OcFJwWWVFeHRiQjV6NGJI?=
 =?utf-8?B?V1k1YktrbW9hazBKNFFkV2dCaUFqcWxqcUl6bis2azJRcnltajZLSmVuVmRo?=
 =?utf-8?B?OUxjV2RJaUZmQkZ4RjBSd3gyMnUwaTZzWlBHTG0rZGorTFlLY3h5VnhCZHlW?=
 =?utf-8?B?YlYyUGZjbjEwNDhEanJyS1VKTU5wZEgxejl0c2QzclkxMEUvTyt5bE56ZDZG?=
 =?utf-8?B?R1oxaG5sc1g0bHZyN1hoSjAxZUNYOTZFcWpRU2dqU29UN012bFdsYWhkdEpM?=
 =?utf-8?B?RFhRYW5HUE1CMGhzYm1TY0hEa2FNYTFVb3NYM3dTSHViMU5JZFdQeXNhS0Q1?=
 =?utf-8?B?UHU3L1FFVWdxcXE2VER3Tk5TZXc4NHpaMng1L0c4ZHMrYnljbXhteDIxa1Ax?=
 =?utf-8?B?d3FPU3JPb0lVR2swaWVodUtmaFYxR2R0V0hpWVZjdDZnMDZHZkd2UDhWTnRB?=
 =?utf-8?B?VGJoM1hsc0ovUE5MU0RxUlFpTWtqSlI2QTVlMFJwMWt1dlVCRzZRYXdLcVQ1?=
 =?utf-8?B?Slh2RU9ON0xGeFhYb29RQUZIdXlXS2lKYnhobDNpamsrY1hLWlE0clJsQ2pK?=
 =?utf-8?B?cHlXUWIxeFpjSzNBY1NIZUp1RGk3Tjl2QzhhL0lLM1FVNkZ0Yk81VnZXZzVk?=
 =?utf-8?B?c2RwQlBGSUI2NVF6SFk0T2xoNC9vdVhKUFlOLzZrZ0RwUVdLR3Y5LzEvTitj?=
 =?utf-8?B?M05lQVoyZmdZV0xBbTA5ZklpUG56TmQ5Zi8xcFl3eTExVVZUNWo1SzZvTmVB?=
 =?utf-8?B?dVhiTGhXbXY2RkIrOEtzUUhBbXJsMzkxWHlaUUNNVnFtRHloV2NKbXNTbHdD?=
 =?utf-8?B?dlA5dHYveXplQjJDbGtNVGRqWUFmNk5jOVpLaDRDc0RzRWx3Y3JiQ3cwQ1Jh?=
 =?utf-8?B?K1gzVWtER0wxdW94bEVkQlp3Z0FMQS9hOFZ2R3VaM2FkMytteUpkaGxlb2RP?=
 =?utf-8?B?ZU1EeGtISkZrSmwwNFJzN1NKeUduSUtESitqUXVTUVNNS0pXZzFKWG1ReEts?=
 =?utf-8?B?SW42UUVrZk5hMlhnbW1PTW94Wm9zY3NIV05QclR5d201elRaR0NvOGdPZVA5?=
 =?utf-8?B?dkdscFR5RmVHbzhNSXJTS3hIVURMeHJsaGNsZEo1TEpMTWtXRnFUMlBxd2tU?=
 =?utf-8?B?NksvQjhXNzNPaW04b2YyUS8xNm05MTVmZEIrS0xIQjl3N0NIeC9pVVZRQnpM?=
 =?utf-8?B?TlRkNVY1RTA3N1pENnpPdHhLbXM0WEVRemZTYU1VY3B4WjBZNHB5RnluWVlD?=
 =?utf-8?B?SlI3UW0za1RESjlrWC9iekFwU1NXQ08zQmVzTjBDUkV4eTB4aFZyZlY5UnNz?=
 =?utf-8?B?WWlQU1RLTWNucHpXT1JYK3lqTGRBazlIR2dycStZTndmajllSnJSQXdaK3lh?=
 =?utf-8?B?bE1VNVJ3d2ZRUmF2VHB5ejBZMzByeDk3bHYzWFFiN1oveDRzeWNUMVN3Yzcz?=
 =?utf-8?B?aTZMSTJ6RFcwQnpzOWQxQ0xLT0xzVEdIK1ZleUlFN0hFNEVWSHZwUlhhKzVI?=
 =?utf-8?B?RytYRjgrVzVMNUVzT2tLVTVEM0c2Q1hLeVJnK05yVVRmS3BybG91R01UQUhS?=
 =?utf-8?B?VnRLUGJIT2NxWXFWeTBpeDViRW9YM2RxY0V5NzBodVZTeTlpdHY4UlJGdXdP?=
 =?utf-8?B?OFVEWC8xUU1RTXJkdU5XeVp6bWdLZFJaTG1IVkFIaEZXM29lb0t3dEY5Q0xt?=
 =?utf-8?B?eU1XNXBidWpMRlBYM25Qb1BMNUE0V0VhMkZNZ012VjR1Uk9ITFIxZEF2d3RH?=
 =?utf-8?B?aEFodTdDK1M2d2piZGl6dXVZUzZ0TTdEd0Q1ZHpiaWFHdHR0azVlYWVRcmpX?=
 =?utf-8?B?cTVhQk9rK0hGSzhhamhMdFRad0lPazI4MmJZK09sdmE5SEZvY01YdlVCelln?=
 =?utf-8?B?U3BsU3FvU0NSUld4VlhNRTA5ME1IcHA3MGZpK2hkck1VOUpva0Vqc1hDSEJh?=
 =?utf-8?B?dWJKY0FMYjZYVzg4OTFBSjlzdjdoY0VQSWt3T01QSVM4WFJCQjlLeGoxQXY4?=
 =?utf-8?Q?QDtyjnj9568dmKR1G8HTRGb3X70fCmtAr5T1b4j8nsrq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a153a138-87e3-4ad5-7edb-08db5248bbc1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 17:54:14.5219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m08svGuS0R8SrztMgsygv8Ep2JRhyK1BufT+3eYQzR2WlkWdKZvdew++cEv9+Q2h6pQ/vmhRrANm2IBsAPUiRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7093
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
Cc: harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/11/23 09:38, Aurabindo Pillai wrote:
> [Why]
> When unused, all memory blocks should be put in a low power state
> 
> [How]
> Check the value of enable_mem_low_power.bits.vga and set
> corresponding bit in the hardware register
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> index 3303c9aae068..c9ec158c5aa7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> @@ -487,6 +487,11 @@ void dcn30_init_hw(struct dc *dc)
>   		REG_SET_2(ODM_MEM_PWR_CTRL3, 0, ODM_MEM_UNASSIGNED_PWR_MODE, 3, ODM_MEM_VBLANK_PWR_MODE, 1);
>   	}
>   
> +	if (dc->debug.enable_mem_low_power.bits.vga) {
> +		// Power down VGA memory
> +		REG_UPDATE(MMHUBBUB_MEM_PWR_CNTL, VGA_MEM_PWR_FORCE, 1);
> +	}
> +
>   	if (dc->ctx->dc_bios->fw_info_valid) {
>   		res_pool->ref_clocks.xtalin_clock_inKhz =
>   				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
