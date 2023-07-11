Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD04EB64D9
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 02:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1D1B10E2AE;
	Tue, 11 Jul 2023 02:21:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 136C410E29A
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 02:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYt43UoEfoueAH6lWip0FTGu+UjQYLblVhYqGeHeap09J8PtEr+WGrfb2zxkPLFovOvxpjNZwBdp01skS+Q/xSagZtYQoMhhzeGFH+JhDuNsuUWbmb3wDakmQ7p2lid8lm7jbd+mgsTxw6oxO+15aBmUEFdlm04DvECq5gH1OH1IpGehpAxDuSu0pepSMZE0ZSlEq3c9mOkPXxKTEDca4aGuidJpVuwtbPqL+OsRM4hUm19wuISbYjo1lH6fnnzR7iyCu70tvMWQrhgYgaXdDlzggrMKiLa6ByEeOvxlMtJD5mPTLKcyYBdq1LXeSHpKVVeUWaln7J6VGXZQA2YO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8PzEk4vJTv+D+rLf3Q0Pc176xH0idO9S0RJCGfdGAo=;
 b=iBaL/yibfxlff09uxdFQrqzjeMe6wdKVA53zmL6hqnmOivc/9/TAfrZDyNWRF8/ettSfVcXxsuEYyssP9K+4BcsafdwKNSixCDSK4TYM/pL/9lPco5ujtKmnbDzwm5+MJLwmZbcLv/leQGXTVZMr+YmEWJDnr1NGIXon06M8pG8cI2S8Mm4Y+PIPuBERAnx7xI5ynh32KnRzXkp6zqNEChbXoCe3rXRXqen1lsMfA63hxHlTz8ETLd/o1REIJuMhYciZaFLN4a36EMadcux+eSjHUsfbf2TvZSmGP2dxhv6McenCv886nS7dWT1DT0nLU1SgvEfanYEN57JWUOTz0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8PzEk4vJTv+D+rLf3Q0Pc176xH0idO9S0RJCGfdGAo=;
 b=Y8KXvkCPFW8J6AMeq0gujxG1ZM312lgIsoqHJW+B/elyZE8hkYoBgGhsGBYWNXLRXGtBNMdwH0rgylFyZU1/JvdW2acb4UC8AnjS06P9gxYeVrAi02Fd8L5CT/e8ZgXhZNuyT6SEohMC+070tamsBQtMoAO+dwrEUwUcUKPfcZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.26; Tue, 11 Jul 2023 02:21:43 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::10e9:7f44:45ae:4f94]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::10e9:7f44:45ae:4f94%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 02:21:43 +0000
Message-ID: <0f754403-79d1-0dc1-46f7-20a405136b0a@amd.com>
Date: Mon, 10 Jul 2023 22:21:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/2] drm/amdgpu: update kernel vcn ring test
From: Leo Liu <leo.liu@amd.com>
To: "Jamadar, Saleemkhan" <Saleemkhan.Jamadar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>,
 "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>
References: <20230710165425.257696-1-saleemkhan.jamadar@amd.com>
 <DM8PR12MB53998C8B2790D5B1F80BD9E5E530A@DM8PR12MB5399.namprd12.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <DM8PR12MB53998C8B2790D5B1F80BD9E5E530A@DM8PR12MB5399.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0193.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::25) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:EE_|SA1PR12MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f8ed9c-5893-4b83-f484-08db81b5919b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tS7AfeJBMIAW7RjhyrusILtE/mJotHBg77+UKaeqqRl0JsoJraqalWFv4d4ZerrBGbsiFQrdVG2xJAlVZndrwTYjFbUQAj8c3hTR9J4qvb6gK0rIEAnpPp0bstRkKKr/fRIoZI04D1DOPf9xtoLnXCPPrI+l95nhZP4uKGxaLWllq3dcYHwDDHrCu2HZqpML6sIAi7B0NRigahogAurzYFUTB0kPIgDAaCfgG0P/5q45jB/ahShi5bJ83gOAcNUKnbgPhVzETYXc1DqtCsBlG/338qLl53wdRxSpH8ATIknBQpM2U9Lh5CZwX8jKyMKKWDf526cw7D92JCUa8mPrTehhfTkFVMLF9vi10DFzBX0RZfTpghpK+uJ6YlXRs3dC9jjBvfCHUFd5Vb9PumWgPB/fn8zVoP/QYTBhNPc1APt7WzjMQ+ygMkj+4DyIsQWS3vKK2XwxUTzAz/HvoPb9VphslI3xOylr4WSpdevVk6dbHg/LNdyUo1AUV+jYQ2bYgMCEtdnQSpOqdlPPIqw9+HKYaMaqbN3LlV10NPgtGCg9ncRGhiZPwDlwak0XituLSONpXWVbr1f+y8mQJtBrRy601tUxAneEgOvXkXmxP9xA0FX5ds35WEM0YcAHZ3B6dPt8qlybjaW75nfOExUavA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(4326008)(66556008)(6636002)(66946007)(66476007)(38100700002)(2616005)(186003)(86362001)(31696002)(6506007)(26005)(53546011)(83380400001)(36756003)(478600001)(54906003)(110136005)(41300700001)(44832011)(31686004)(5660300002)(15650500001)(8676002)(8936002)(6486002)(6512007)(316002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnZyaEd3Zzcwb21xMlAxQkVOUzFHTitLaWxUUkpLdGJNMlNDeE1mYk9KSVFr?=
 =?utf-8?B?U2pVQ3hrTm5Ib09BZEtpL2F2cjV4dU5pZmR3clY3cmtRZitFL2FSdDNkVHM1?=
 =?utf-8?B?M094REJxZG5nWGVxZjF0RjRwSXdjU1FJdGhTUWg1Tld4YWVmamtpdllxOHdv?=
 =?utf-8?B?TXlncDV3T2hFR0lhcXI3WWxqRlFSZ1lwYjgrN3pCbjVyK3lxQmpEVm5vam05?=
 =?utf-8?B?M05jWnJLQVROejQzd2Z0UGpCckFJRms1YURWeDJaRVhZRm1lMFdsWmJnTmhq?=
 =?utf-8?B?SUxZaEJMcTY1eHhOQlA3MExvbEdWaldJYmhYaDFCcWx4Z1ZiRUtZS0JOZ2JJ?=
 =?utf-8?B?ME9yRTU5NFFKOTBTTkhUc3JjRVJ2aStsaStHN3kxeWJWZFRNMGRueDNZc1ps?=
 =?utf-8?B?cTM4d0NrVTllUmZiUWIxY0JQWVlOWks2VmZld01jZHJ5ellDbHlNOXFwMG5Y?=
 =?utf-8?B?MUVjUGpEVzhiRE9mbExTd1RLb3BoUC9jM0IrM1hldUtGRmJvVy9DdkNQYUZG?=
 =?utf-8?B?QndyK1lRS0ZqSStPZFkySm1xOGtpbUdKS1JYdWpvV1NMRXVtZ3diUkpyT1hw?=
 =?utf-8?B?M2RRWkZ4QUUrMHlyUjduWFZlbGhkSEFSQ3lJNG94aXRVTVE4R1laSS9vbW5O?=
 =?utf-8?B?OGlhUzVBeXQ4eElQam5Femp6WS8rMFdaY3drS2lHQSt0ZE5sbmlKbFlsNmtV?=
 =?utf-8?B?ZmxwWFY5VjRNRnlsOXg2Z1E2N05IZDdleGlIYUFnUTdxSG5wU2lFaVErMlpW?=
 =?utf-8?B?c3djZ3pZaVBwMUV4NnJLOGZkanZCK3F1cnBmRVdCbG1sWjJQUlJlTjFya0Vk?=
 =?utf-8?B?TDhRNkZmTmh5REwzckN6MnY0cWhiY3FJNzRhY1ZZT1ZIMmRVeGppZXJVVFJD?=
 =?utf-8?B?clRTem1EL3BPVkdzQnNjb0JpNkZPd1lrNWhFUGNQRENpdDlpMVJnNzBLV0VM?=
 =?utf-8?B?ZTM0Zlk3TWVuVW9ZSlkzcy9KbHRKb2FYRmhmY3luRWRjaXhsYjdQcWVKbVVV?=
 =?utf-8?B?VnlNNmZGUHRiVXBFamgzM0taeVhMb0lwK1htQnRhL2N3ZUVjL1hyWmZ6MWs5?=
 =?utf-8?B?Z05pVEJDWElIV212MnFRNHFOUGRyMHZhWUFFakxFZmUwRHpaa1c0ZkJqa0Jo?=
 =?utf-8?B?ZXpwT3BaeFZDeWxYL2lqa2l3c0ppNDJGallVWmMxY1JNcnJ1d3BKOGRncnQ2?=
 =?utf-8?B?NlJyUUFTOEVXRWdnaVkzU0VOMVdGN2lKbnZZMEdFdjVWVXo3dEJBTE9rSzd4?=
 =?utf-8?B?TFh5UDdJYStCL0ZBWEhFVGpBT1Z0K0NQdXRlOE1PMFV5RXgvbmZpUTRDSUxy?=
 =?utf-8?B?WmNmNDBPVFJDMFozWUVZQkUwa2sxRDZmbnV4d0lHVHladGhXYU1ITGdnS01G?=
 =?utf-8?B?WHlWbmhRZHE0NnJwbWZET0tBMzR1WTBYOWtNU2FHZ2FCbDRuUGhrc1NFeEFK?=
 =?utf-8?B?VDBzWWRYSlIyNzBnc3pUNyt5N2NqazRGZVBXTW9reGJOSVZmZ1VqRGFuR05z?=
 =?utf-8?B?akN5cjRRSG85aW1peEVHUTRzalZCUTNNbjNDM0szQU1odDJoQUpKbTRrNENL?=
 =?utf-8?B?b2RXbVo3YnpIV0M1RVc4VjJHdy9NZkVxalBuejZuNGlpNUtBUW96NnlNV3Rh?=
 =?utf-8?B?aFM2Q1FTd1doMzJGMHZLZ2tvV1U2N1ArZjRiU3oxV0tKMDNuRmNYYmd4a0di?=
 =?utf-8?B?WXdSa0UwVmRmMkZwK2ZWYWsrQWUxNEg4NUt1NzdXaDlTcFZtcWVLSm5kbkdW?=
 =?utf-8?B?Y242YW9tam8rSmpyTmpIK210ViswNW9xUXp0UFRWY2RCMHdpaXBNU00rS09C?=
 =?utf-8?B?VDMvcXE5MmdubTk1ZVF5S2xKZFVCTkVac2tGamt6ZzZNV0M2T2psY2xPZGFI?=
 =?utf-8?B?dXplMG4zR1JhWHplNENMczQzZ3gyNjhBZWFLK3ZNRjkvWHBrWWpJcE44Ulk4?=
 =?utf-8?B?VVBCQkNENWdWb1lpUElUa0RNaCtHYUVLOEl3eHlPUzdtckZpNDJTeTY5dU8v?=
 =?utf-8?B?bmxHdTBVR0dsYlVXcnlmZ1VuNGd3VzByMjU2c2l1YU9iTGlqNFQrNnJCdVd3?=
 =?utf-8?B?UURvTFNKTFVQZkE2UVRBN3Z4TlVzbkRjeXNpMjdUaWFNSXVOaWF1c3JVbWh2?=
 =?utf-8?Q?i9HI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f8ed9c-5893-4b83-f484-08db81b5919b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 02:21:43.6717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWsKDeiADxXjAdt37IBjVF150JuTxXMvDfKVOzD7JyLbcULakYDiQHIZWKL7DvaV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Rao,
 Srinath" <Srinath.rao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-07-10 16:19, Liu, Leo wrote:
> [AMD Official Use Only - General]
>
> [AMD Official Use Only - General]
>
> -----Original Message-----
> From: Jamadar, Saleemkhan <Saleemkhan.Jamadar@amd.com>
> Sent: Monday, July 10, 2023 12:54 PM
> To: Jamadar, Saleemkhan <Saleemkhan.Jamadar@amd.com>; amd-gfx@lists.freedesktop.org; Liu, Leo <Leo.Liu@amd.com>; Gopalakrishnan, Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Rao, Srinath <Srinath.rao@amd.com>
> Subject: [PATCH v3 2/2] drm/amdgpu: update kernel vcn ring test
>
> add session context buffer to decoder ring test fro vcn v1 to v3.
>
> v3 - correct the cmd for sesssion ctx buf
> v2 - add the buffer into IB (Leo liu)
>
> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 76e9a2418286..4ee5f933e420 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -521,6 +521,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>                                     struct dma_fence **fence)
>   {
>          u64 addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
> +       uint64_t session_ctx_buf_gaddr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr + 8192);
>          struct amdgpu_device *adev = ring->adev;
>          struct dma_fence *f = NULL;
>          struct amdgpu_job *job;
> @@ -546,6 +547,19 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>          }
>          ib->length_dw = 16;
>
> This line above can be removed. With that the patch is:
> Reviewed-by: Leo Liu <leo.liu@amd.com>

I think we should rework the lines above of this line for msg buffer, 
put the session ctx buffer right behind it, and no need fill the nop 
command in between, so make the code cleaner.

Regards,

Leo


> +       ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.data0, 0);
> +       ib->ptr[ib->length_dw++] = lower_32_bits(session_ctx_buf_gaddr);
> +       ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.data1, 0);
> +       ib->ptr[ib->length_dw++] = upper_32_bits(session_ctx_buf_gaddr);
> +       /* session ctx buffer cmd */
> +       ib->ptr[ib->length_dw++] = PACKET0(adev->vcn.internal.cmd, 0xa);
> +       ib->ptr[ib->length_dw++] = 0;
> +       for (i = ib->length_dw; i < 32; i += 2) {
> +               ib->ptr[i] = PACKET0(adev->vcn.internal.nop, 0);
> +               ib->ptr[i+1] = 0;
> +       }
> +       ib->length_dw = 32;
> +
>          r = amdgpu_job_submit_direct(job, ring, &f);
>          if (r)
>                  goto err_free;
> --
> 2.25.1
>
