Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27231C00140
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Aug 2022 21:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A53278D9C3;
	Fri, 12 Aug 2022 21:27:30 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 503C718B647
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 21:27:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfdtROXPq80vbD/D4DuQxVN0oPagtGuOHgJBzSH1AqHvbBcF7vGOut6FuQImaUx7Pzi/zIi+ZCWi43VSASZAeSlFFuyAEe6tru++zij0iadWHt/6C3fF1zTJm+SLi8Gyshc6gLVtoNQRLolsD8VBXe9Arr6Dd6I4qp/ctbWeYiHMSNpcqTj03I8K4J2YjAJDIOyNmXoF9Y+FfpFTCD99HLSHDJ/uUAqesydUUcHNWvYjuLa8+tNakTgCV1erFGAF2PrIRY5yG1TCZwIU20nw0FFqqObfmFhP9h7+ZuVTJSKjEI1DAsHswfYQMHVHtdpQkBdEZcyHJRYcYKxrDZ7DMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubFvGPmK3m3mf3o/LU6E2mwzhB6WS17NA2vNVFX3DRs=;
 b=PAG7g2I3TgHdDMONnNwdSmCsMsV2M/2CHO7JM1uOeb74JS7CyRTPi69Ooug3u/les/OUlNjpcGwvfdLMVgk3XLAr7SaiAv2yexpUw+konEb+d+lASCz/AtDYSu3Ghv40yJDFqiFmfN+VIGaAN1QIdCsNPFSAiPLgDgur/bqaBOqJDvgpAODHuCxjMG/OEPhTZ/sCmlEExQtvWQfDDNt7246hVaeR+HsSmwsxteY9y6lz1EAXaDN5C+C0c4m7djBgVwoxiZ/KqdNH+uhr2yITZ34n8vxJa5/3Qk/I2r7dG4J6ycRIbDXG1LIaLyy86SDBuXl9vvjzHTqX0aBxBQxRPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubFvGPmK3m3mf3o/LU6E2mwzhB6WS17NA2vNVFX3DRs=;
 b=04iitticYX6zAbl2rxFL1zq3BrOlnCqz/wgf4Z0gs905O0Lt3+yRVdZMkr4Gb6az16FLoJQPhJGlQXX5314bwLIPOSeNyafS/tGK+L4w8WFYJgKtedOvGatDyAVMPoKkk/ZZLrp75F4f5pXoonZrDjlHB0dp6DSoRFWBVqmJDZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN8PR12MB3331.namprd12.prod.outlook.com (2603:10b6:408:45::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 21:27:22 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 21:27:22 +0000
Message-ID: <ea5dbe2b-12d0-7c21-e22a-25446b38027a@amd.com>
Date: Fri, 12 Aug 2022 17:27:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix interrupt handling on ih_soft ring
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220812205624.2902630-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220812205624.2902630-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:610:b1::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5d24803-7ed2-45fb-cf19-08da7ca97143
X-MS-TrafficTypeDiagnostic: BN8PR12MB3331:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKrqUpxG1nt6JXj/PY6K04C+Nnc+f3zM/s2V6OZ1IwhrZfCCuVDcQ75GQnOZW6RntcWc0GlEJD27Ldp5qHbs5LgEUTHwnMyjHVJ+tFZ9N86Ve2xjN9VPAEEt24C8Egb1WHOP6YIyXzxAE40SrSmZqAhHRZUCTg1RgAPRcGMxA6ytYFNXr5NT/19Kze4MS+VRhEWp5xNKYuBBCsiLXd6h2w3Lfy/15pbJF+pDa7uwXNmFiUWtOd1c7vmP4fdoC1looJoWn+8FYYQ6xQG59iit6PDpMFy6GdN1Qg/AeJssRiyfESAMXqzvM1XsBNGp2RSYaoIf5u8nSPdAhqOmqhunSieLrOzZONoD/dO5YEMCeTAqR2tyPVL6fyp5vw8gQ6GsvXsp4Tdc/SgicmnpkphYFiN8hDk4xxBFzKotHAlj2HtajHVgi3URZIOZVHF6TtD2uTvNQhkF6KtjxOmTe5V5n+4HPfHEJ87sA3NziFtq+cZtkOUxhHTRm7LPCfP9gRX+UGemXIXazs96lNdSuwobqA3H11ImPuQ8nP9abPk2AAmP299hEAfE8k+MdsRyhaemn9VnOwDtXNL3kNkg4y2ThkAKetXGkrYfjhjaHOolvE5zcwHmRiRs32wOB6Pqvf2MA/WhX4Wxz96tQRQk9SHPTN3NJUBaf0CTfTPffPEFh/NIPzv5h2L9BPxReIpomvfCox3N581wUcAQrFKKZwJ6qwNcgWNH3JTvDbGmhwbgly6Tru0/+krJxIuS2XYPuz513ujEGGojf8CWF243u50CHhc8vy8NbN+C4dBiuvHUNGnD/NCwZAz2DTuwbP+aIhPSHs0RKtQCaRbnmLFZiUT2ajptUeYL+o6iEJjjhQ2vyCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(44832011)(5660300002)(316002)(66556008)(41300700001)(53546011)(31696002)(36916002)(36756003)(86362001)(31686004)(66476007)(8936002)(2906002)(66946007)(8676002)(26005)(6512007)(83380400001)(186003)(2616005)(478600001)(6486002)(38100700002)(6506007)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkpvMEMySlhUWG1NM3Y4TkJlb2YzVmtvQ1ZpclRqWSt4bEpxRUYwQUZVbzV1?=
 =?utf-8?B?Zncwd1ZGSm1kZlpLbWwwLzhOSzVQU3JiM3NVTU4rVXJWTlVYNHZhbklXODhZ?=
 =?utf-8?B?SHM5R1YxZllVQk9QK0RMNkFXWVRmWkJWNXpzVXd5S2IzSVFqSUUyZ0FwV0tM?=
 =?utf-8?B?enQrYktmcDFuWkNWQk56Y2NqSnVDMDRUUUZZemVad0hnMWNvTk5JSlVEVWI5?=
 =?utf-8?B?TDRITndMbzlTUWRzOGVZa3dMeVBLQUg2K2o4a01Zc21CNVNnMGpuNXRudkRB?=
 =?utf-8?B?Q21wcGdJYk1mYTZYNnR2dzZoelVxbTlacmVWa3VQekNraE03VDBGenYvaWZZ?=
 =?utf-8?B?NmZDblRoME1aSzFmYjlYQ1FiNStOaTFPTGxhbzFFR1dVQW01STk5QnNwYlFj?=
 =?utf-8?B?YWVhL2FkOTRtNkc4MTFLSWxja1V3TSs2Z3VVd1FJSGlvRk9jL0VMRnVoOEhk?=
 =?utf-8?B?a290ays1N1hHeDJkY0NObG5nTUg1T3FQNzU0ZWZxMnBuYWZkaXg1VytBS2VM?=
 =?utf-8?B?MldPNUFOU3dEV2ZucmdoUnhUbTFuVnI3Szh6WGZJRDN5RU9LOTVQUkhrbnhT?=
 =?utf-8?B?VGowaTBKOVhtZVQ2VzB4bksyQW4wOTlZSEQrYUVtVEZ1T295T3lva1JLcVFQ?=
 =?utf-8?B?dDl4cy9CcnZSeUZPeFpjNjRFbVQrN1JzbE92bHdsTldrMDcvNUxiTDVjbCtS?=
 =?utf-8?B?WXZPMS90Q3lrKythNzBORkVwYk1QY096d1QybHc3RjUrMkpMMnhOdnRBcEJh?=
 =?utf-8?B?dHp6VElocVliSDh3R0ZRM0pIb2VlbHM3MlVEMnMxMkV4RlRZZHRGcUZOUktJ?=
 =?utf-8?B?M1NzeFBPZGo4WmZDRlh5MGJzVHk4RzRRYWMwVkgza2FteFlONlNzZTFSVVl5?=
 =?utf-8?B?VkZsYS9RdHg4Mzh5bGhxVWdmMktSSnhxSld4d2dGVDN3VkRqNkt0ME5zRUlI?=
 =?utf-8?B?OWJXSTlRdVliRUc0eUJwRDRUMW5oWUhvQUF1S0VFa3pmNlVtU3Jzd211WTdp?=
 =?utf-8?B?dUdOc3A2NytnMi83VUR2MENqZWVXSzlSR1NGMVpDamdFNlozdHhrMzlBL2lQ?=
 =?utf-8?B?ZjBjMWo5bGVJRDNDMUpLWlFIN2xsbnVTek9sc1BYVlhtZU8zWVhzT1Z3bGdP?=
 =?utf-8?B?ejhYeVdjR2kzeEtmTHovNXcyRE5Pd3RhNEMreWszUGFuMFVheGJiZmdRM1Jn?=
 =?utf-8?B?SmdCYVJJSU1DVVNsYzc5U29rcWdxcHNhOHhQeDNlRDJhSU0wYXVuN3k4SDNW?=
 =?utf-8?B?U29BcFFTZFQ1bWlmNURwbENpa3RmUFNEQk5FRVYwWGVCWHV0V1pac1FDR1JS?=
 =?utf-8?B?bHY2MGk2TEdvaHc3ZWtGK2NYSkI1Rm1vNDZ6VTlnK2t6blFpU1BQbVZuTjE3?=
 =?utf-8?B?SzhoMVNZblB1RzNhMGFZMWM1bnpxUVJqaUlvMDZOb29uWUJLdXRyV2hOUjlW?=
 =?utf-8?B?UzNYUXdCa0tIMjJwemdoMXV5bEJaMDVHMG9oWDZUQUtleGp1eDYvRjM1THlp?=
 =?utf-8?B?NklaRDVwSXFDMG5DUnR2T0dRd3g4RStlTlYwQmlZOWs1TkgyMFc1U1Fqam1y?=
 =?utf-8?B?L0EzajJKTlRqMmpwTXRoSWtWZUVDYzZ3bVQ1RFIrYVgyNm1kZmtFUW11SGZO?=
 =?utf-8?B?cGJDZGY3ZHFzYms2cVpRdEVTc0R0YzBDeEJYWGNFQ2JnMFJiYUJ6ajJ3NFFC?=
 =?utf-8?B?Qm1IakFBTXhjUkowekRTTkx4Y1N0QUh0dytVT3d2V1JkVU1ScFhURE1mT0tt?=
 =?utf-8?B?RFlMVVBzaEJZV1d4VGNaZEUyNHhlZ3U5djF1emtIWXFyT3U1eStWSm1Ud3RY?=
 =?utf-8?B?dVJOWHJYTU9PYU5VeHlpdkt5YXpnT1RiaXNxWmRSSHhWZU5HT3ZsN1BjVXBm?=
 =?utf-8?B?YnVBYk1LTmQ1MGdPUWlQcUJPTWRxQ2l5SHZaLzhCUE9WRGNUYVk2WmZtc3VH?=
 =?utf-8?B?TFg4VUx4N3NrVlljTXFXS0k2ZTlIczdCaUxlb2NvbzZuMTlWUEllRWNqVlNa?=
 =?utf-8?B?aUtLYXZxSXQyOXR4NDI4L3ZNZys0MzlLM3RLekZVOU9mNG8yUmRJb3NjU2Ry?=
 =?utf-8?B?bGtVai91cHRwVk5mSEF3RUQyTnBwSmhqR2VGeHFpaDRUb0ROa0NkbS90KzBN?=
 =?utf-8?Q?JS7PeltZ5zLB3pFxQ2peHMz7s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d24803-7ed2-45fb-cf19-08da7ca97143
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 21:27:22.0745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0fYSovgK4H0HyrD3bPZ6mOUUz5Q1ofKrwvGdJn8yI74mI1JcODCsXhQl+qWAnjqOmuyqLvczjv6/uzP1JoMwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3331
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


On 2022-08-12 16:56, Mukul Joshi wrote:
> There are no backing hardware registers for ih_soft ring.
> As a result, don't try to access hardware registers for read
> and write pointers when processing interrupts on the IH soft
> ring.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

The patch looks good to me. But you probably should apply the same 
changes to vega10_ih.c and navi10_ih.c as well.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index 3b4eb8285943..2022ffbb8dba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -385,9 +385,11 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
>   	u32 wptr, tmp;
>   	struct amdgpu_ih_regs *ih_regs;
>   
> -	if (ih == &adev->irq.ih) {
> +	if (ih == &adev->irq.ih || ih == &adev->irq.ih_soft) {
>   		/* Only ring0 supports writeback. On other rings fall back
>   		 * to register-based code with overflow checking below.
> +		 * ih_soft ring doesn't have any backing hardware registers,
> +		 * update wptr and return.
>   		 */
>   		wptr = le32_to_cpu(*ih->wptr_cpu);
>   
> @@ -461,6 +463,9 @@ static void vega20_ih_set_rptr(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_ih_regs *ih_regs;
>   
> +	if (ih == &adev->irq.ih_soft)
> +		return;
> +
>   	if (ih->use_doorbell) {
>   		/* XXX check if swapping is necessary on BE */
>   		*ih->rptr_cpu = ih->rptr;
