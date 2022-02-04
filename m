Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD1DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 16:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3641110E8E9;
	Fri,  4 Feb 2022 16:27:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6D2010E8E9
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 16:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRfJ444PyZU8zdpyKbLDWSUqyryl4TO78VpSBNBQRygeLJQV05x3ejY0OaY7Gi2SZvfLDxbsJAf/1TuGjxawrPQeRv43MrquBZP9CPLXZ0LHUQJ11UuW8CbIPCG5yR0zFcndR9jpazAGKqiypLkTCeYE19H8HmehOLAgEoCJWRGwxjvw27Fy3eLKgeGIo/8vqHBytu0rhpzHu1A8JWf50jpx4LGDPMX5VWza1TNaoUsnzDub5ajCexctS555O1vvnajAOZ/ciKRCC2uq+DQ68i7m7srylpG9D13Ri6cqRVjFJ+P3ZbUfJUhX781icmpg0UDsqhQpnza0k7XhrSYwEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSkSMFaJsqk8rkCkiHftl13ZDnVmDib8q6AhzqRx61s=;
 b=WmyeWs2dgP8GH9ObG0RCTQ/U2/onlg0DDaZKYrni/J3oaDRLhrcvwAF8k0GR4qb347vwKuwwYVm76pFFSIMQLR6cv1Kc2Xe9UcvPKIi4wvT2gJ10zaiqiRcEMY9O1VESWXB8sRS3nvtEk5sIZICh/bOstMhunprz219LuT13soJscjgfe+d8WPRrY5ozubA8wTGiljZSJRvzwfHhLlhNz7RsgrxPjHteccQ/mo1QXzzjeO7L8JXGUsm3VCOGFj3g+74lPTtFtQWvUpxk6cop6Qlm3A2VIXkZmr86/anuWiAOT2F/3PvgAqbx45XKO5MUknyrv/KkSMkMeEuuzSehhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSkSMFaJsqk8rkCkiHftl13ZDnVmDib8q6AhzqRx61s=;
 b=ty6fcvhh8tHk8XnsyxKFvcM9/3wxNmMKupEOmAc9zNST3XFtNfSDVx/x2rH8s8mtzu9DMK99L0RiIAfc+Vh8SPSGLgqy5VM/jJlYgpprHfdBKG6dsZfgdHnc1SzbcQQGITbhUD8QhNv5hyHmGfQiG2fgfgMbb3Yo/uK6UFt0deY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN1PR12MB2445.namprd12.prod.outlook.com (2603:10b6:802:31::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 16:27:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%8]) with mapi id 15.20.4951.017; Fri, 4 Feb 2022
 16:27:47 +0000
Message-ID: <32b9cdf2-3d71-4228-3471-38584575f41b@amd.com>
Date: Fri, 4 Feb 2022 11:27:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: move lockdep assert to the right place.
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Rajneesh.Bhardwaj@amd.com, amd-gfx@lists.freedesktop.org
References: <20220204085201.30615-1-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220204085201.30615-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a8762e6-52b4-466d-7f26-08d9e7fb47c6
X-MS-TrafficTypeDiagnostic: SN1PR12MB2445:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2445A06DB9DAC7628797312792299@SN1PR12MB2445.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hpfc6ihKEKc3tL4GPKd89wUdcwlUanPUUQBKKdmJ+Ju3lm1r9sB/WtTLG42o55Dhso6bQE9YXg5IUolhoSyo4jtk9es1xZ7/CovmDnIIjRfi32erNQOYN2AR4iuIrkC+STtPHpoTveYCep4ZbSWq7Cp2eCri8iF/ju/Jp+5ti0TS3hNMSs1SR/Lk/4veRJsPmiUbf3mPDDbJoTK4/dSCx97fWvLT2bzk19wwLo36uzm/Ff7VyWocffQesh6FUCZ9CT2hpevMayMHQ/+e9knG7yYclsvg7i3+sbb7SpRT8tIfulH6pd0LM7tTcLwa9VLRmPAkoGuK/O7pLeGAP4Gf3wQ656Arpn0eVU/z0K6YUYSjVygipD4Hp6X/6Hayx4ry8GHRwrq0XGgH8GUuX1V9i8LPIKfy7wwwAuDmpi4bhmJPP4ZIgD+eO9RzJd8z0rx5LjI/dFMi4lQaTgzWhPPpz6c5IPSqniy1ri0vihBPbk8rmAmFPLMCCoK1mbpC3yKIeTZQ0lFvXvSygvfHdBge/KW2M9FbGkeh4VuUyc0v5eQJuriHYt/rrkKIS7NXw4yhjnCF5gRVPMtjtOGfdoiTHauzHT8XYQTGjrpKmNpYt+kt/Al8DF6ZOgZFB4sUyOHE15/1Cekq12epcRcMG1m3gRUS3F/ForAXqp+QbXLhA5+J5ogE8rKY9HUtwixUrbONQK+8+KlfB+HRIx0dJ1O7sNv+nILkfnAQJNO8a/sDlb48wy9td9IB6aBT37eF8503
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(31696002)(86362001)(5660300002)(44832011)(2616005)(26005)(38100700002)(186003)(83380400001)(316002)(508600001)(6506007)(6486002)(6512007)(66946007)(8676002)(66574015)(8936002)(31686004)(36756003)(66556008)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2tId0VYRVJhVWhVR0pnd1dvMHM1TWZSVTFoR3l0VWhsT3JsMHdheFJWNXZE?=
 =?utf-8?B?b1BUbG0yNXhMbkFmZXB3bUI2RklkQ0lnUzhVMGRmS2tFb05DTzhDQ2VCYVVI?=
 =?utf-8?B?TE55dEdrMWxQN0RnWmVHcUwvWWs0NkdIT0xzOVFPZkxJWFltZ2VaY2NFU3NC?=
 =?utf-8?B?TWJHeXRCeWh0M09aRFVrWjVBZ0ZndysxRDVtMDhQWmlITGo3dWIxbTlvdU9y?=
 =?utf-8?B?dDdCSnZBS0RLN0xjRElxdXRSZGdjMkREKzFMcHE1MXA4TmRtT21DN1ozU1Uy?=
 =?utf-8?B?ak8vRFRZeDBqdDFPQjdxYVJtU1FsUyswVnhuaVhCaU9rOERpeVI2STYyNXBV?=
 =?utf-8?B?L0EwNzhvZEIybXZWNkNmVzFZWEZ3ZjVrUkprWHQxTFBCWXJDaXVISVJnL0xN?=
 =?utf-8?B?WkNHTUdKNm9yUUgxOUlhZFJBZEpWVHgxSE1NaDBpQ1M4b285MmZXSTZTZWdT?=
 =?utf-8?B?V1FmNTFZMFJBMUVvaUlpblNjc2lOdFZ2K3pUeHVla0VFM2Z2U0pZeFpXVEVV?=
 =?utf-8?B?L2VteC9sY01mRHdTVDRpdUlHUnZ3aWp0cCtoRkROSGNtaFo4dGMxYk8yYkh4?=
 =?utf-8?B?N2dkUWdLZFB4Zk8xYWVoSkcrQ0lFNm53RXM1bTVTZk1VNlZzMUZLNElMRkZ4?=
 =?utf-8?B?QW5JV0lkMkVxbFo5NFRIS2V0VTlVUzhHYlE2b0x1dCtEbC8zUmxEZGd6Vmwx?=
 =?utf-8?B?M3ZvUk1VRXh1ZWI5ejFtV2F2UlZZOER1VXo0RnFLbmU2RDAwZnBqLzQxajV4?=
 =?utf-8?B?WHl2MG1XRFVUb2hZc0hMWURyWEsrbEF1NTQ0blpJck9PZnJHTlUzdXBqdlk0?=
 =?utf-8?B?dlNPYSttR2E4U0N5SjYxVFVWOFNOclBKdzNXdmQyLzJvVnM4THlMUHpqbVl4?=
 =?utf-8?B?RVBPckY1L1VEOHJ2aDg4TmpTWnAzZTlMOGtuRXZwaW42bE1sVFhoOXNWNnpq?=
 =?utf-8?B?MnlzRHp2OEw3dUZSVFdpZTNGZDNGTmFGdUUxNG1BOWdYRCtoVnk2TWoxMERW?=
 =?utf-8?B?WWZpWXowN1RzSUlGMEk0WEpKell1Vjgra1lJbXFKUEJEU1pHU29MNzVlR2Zs?=
 =?utf-8?B?VHBwQlU3Vy9BTW52b1c4TjJ3Si8ya2ZGSTlHSmN5QmhzRUszV3NwdWdtQUkw?=
 =?utf-8?B?WlZVdDJJRlpqM2lYZngramtiVTlqRlgrZDZoL0IyWHM3SUxVYzVuS3p2SXJt?=
 =?utf-8?B?dnlCb2gwbC9Pb0hmSVJBLzRsNG1GSktTS2VEZzM5ZVdwNDZaQ0N1UGFBKzhK?=
 =?utf-8?B?ZnlCamdtdEJlL3hSaTRocGdoNWRIYi9mQTBSNnhvNzhoMHlHWWxvRU8yNFBs?=
 =?utf-8?B?ZmNWUVN0Rnd5Zlh5K2Jaa2l6Z3JXeWhKVDA2UkdJTjFLcFFRZlRtWDlNQ25y?=
 =?utf-8?B?cXpKSVRJV1cyYlhxcGNDb2hrWFN6QW9wOGwwQysrZWQwUW1Ea1g3S1Raa29i?=
 =?utf-8?B?QjdXc2VlcEtna0F4Wk5ocjFNSmNtYjVTL05qWHJrYURQamlMODVMejg4WCti?=
 =?utf-8?B?T29BSEIwY01zc3Q4b3BwWWRmVXpra3c1N3gyTURUTER4WUtrREZ3eGtoTFZX?=
 =?utf-8?B?U1NNRTJuTWtpMnh0Qm9TVnd0YUVMWXY1c2p6RUcxL0hnb3hPWDZzSE9nQy9k?=
 =?utf-8?B?ejZTOU1LN1YvaW9kOStRbE5Ha0dScGwvTlUya2k4cEc5STc0cnpvUktJeVpl?=
 =?utf-8?B?WklYTXVpMnZOV0QxbjYxaWxNZkVFKzZKYUIrMDQzQ0dmWk9uNUQxOFJuVE1F?=
 =?utf-8?B?UEVkaGx5QXg0T2Nya2pRV2pWeWNsSzhEK2kwdTYrRmRVQXlxaUs1dnNpc1BI?=
 =?utf-8?B?RitsTEx3dlQwWnlZbnF3SUZmZkRzTm84NEVVZTg3WVJiNVQvWE9MVDZCaElj?=
 =?utf-8?B?ZjhHaUs3WURDYXFMbnFycllVcUpTWjhTMC9lMkl6TmIrMWtWeTFiSUpXK1VO?=
 =?utf-8?B?U2lMRnVORk52VU8vRHhPMWxCUTJHZXUxOHFsSVZUdHJlY3h4T3dWK1RYOEZB?=
 =?utf-8?B?eVAySFoxdUdMVkE2Y1ZGbjVWNTltVUMwd2xBUkhkYVZuREpKditkVjc1emdU?=
 =?utf-8?B?RWdBMUUwLyszSE5naktEeG04VXErazdTUVUvbklZeGl2N3FJT0t0WGVzMU9Z?=
 =?utf-8?B?OUhvT2JGa0M3QU1uTGtBV3Fkd1hqd0dsYlZ2Z1c0QWpYai9NbklieG1WelpQ?=
 =?utf-8?Q?xJggNu5dU9Gzgft1M0ab2aE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8762e6-52b4-466d-7f26-08d9e7fb47c6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 16:27:47.8196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNhtuNDS1GxUm2Kpauoj4MHKTth+ZU2tRWZWd55qFntz2a8gb+yym3lznMzbpHZiJLyUaQYE6UR7YoXZTND0bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2445
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


Am 2022-02-04 um 03:52 schrieb Christian König:
> Since newly added BOs don't have any mappings it's ok to add them
> without holding the VM lock. Only when we add per VM BOs the lock is
> mandatory.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reported-by: Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index fdc6a1fd74af..dcc80d6e099e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -375,6 +375,8 @@ static void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>   		return;
>   
> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> +
>   	vm->bulk_moveable = false;
>   	if (bo->tbo.type == ttm_bo_type_kernel && bo->parent)
>   		amdgpu_vm_bo_relocated(base);
> @@ -2260,8 +2262,6 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_bo_va *bo_va;
>   
> -	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> -
>   	bo_va = kzalloc(sizeof(struct amdgpu_bo_va), GFP_KERNEL);
>   	if (bo_va == NULL) {
>   		return NULL;
