Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432D0C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 03:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C9710E051;
	Thu, 24 Nov 2022 03:10:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC57410E051
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 03:10:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dw7nSyfGEGvDwto/FfHCqrruGmLFejkYeOG/PjKmxTrV+4+ni1EAMvoiMLEyOrgdJQ+BDSse7L5b6yaLhTlGyeckLV0YER0FU1Y7lSbENSmvLIIjQCywPs3nhNgDp5MaV/x/vD0oQsKTXTUx+FGoZHWBSNCWd8DG7s6APaZSvJavj1TmKbbqG2p5tY03VqgMMGS+valbKb18iAcXoIsSg3WWMNIZTU3tw47YRV1XA/vjjwUr4+6FD7/diVN0SLAmGlvB3rX5DJw6/mLJoC/DvjHB9CjTYoxMd3/EtN6Uhzz3deevxbo3CcUBzE2gH6vyjeY/9fO6PS32OJTm80Hrug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+DckPL+QBqNTjYXzTnUH7y0Fn+a4ONNw3rLKF+YqNg=;
 b=NCDK8EcCm7t31gWnZRdmde9soTMsApuDNfJn3A48vkvwXf4j5C2YZlQt7Y2/RI4PGfx28C31U4oXg6FzCta8mrWeDPfyNmJacjMnFdxzlb/wZ2ZL0tcQJ9ICCst8Nbfqb9iG/rBozoGn/BFUczbtl8mfponHwiV4dbEJW3uOqvZDA2L/qtiP/UClblzKJrn3KQbxPikZRat4CyU7DKvdI9nAMKPz9czlfOBmyJo5YX+Gv3rKjHm1NXWd4XHWcbz5N5nvhRuY0aJz4kAKnIVVbduCMVDDYYSfJNM/qMkxvHFol8aMioy0VIta15oyc19BCniNtro/YeBJmn8ILZIqLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+DckPL+QBqNTjYXzTnUH7y0Fn+a4ONNw3rLKF+YqNg=;
 b=cxD2Foa3xcl2MknGvzfpgcjmw2v7eAXNc52I/QMNexmyceQdEYdEGwFsA8mlgoIPoniXUgBRRW4/FX17SlOUS6tDUiTkd6qThDFEDBTyHVewxOsJnNYJrUiDUErIahMg3pJX86CzCOou5sGBr+4iFtyxtwOGz+ehO6ZizZtdaAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4621.namprd12.prod.outlook.com (2603:10b6:805:e4::10)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 03:10:16 +0000
Received: from SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::f67c:12b7:6290:3b5f]) by SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::f67c:12b7:6290:3b5f%3]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 03:10:15 +0000
Message-ID: <cbfeb4a9-6fc1-e800-fec5-900e763d05d4@amd.com>
Date: Thu, 24 Nov 2022 08:40:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu/psp: always call psp_load_toc()
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221123140025.239843-1-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20221123140025.239843-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::23) To SN6PR12MB4621.namprd12.prod.outlook.com
 (2603:10b6:805:e4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB4621:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: 7986b874-2a46-4fd0-86d0-08dacdc968a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ou9a0+4lmAhEq21DXhwUJZZnXtUIZPRNq/i87UazN+LAZbDthZ2mIbholq0T4jnR+eZZheMEqGvk8B3hn0QwUXgMoJLtfaPXZaga3Cate+8m9P5+Tw6zTjfYG2CvTbzFXz0Bv/OR6dS38OyHUDL2i9rNa89EWmKMctfXDFmxfFsnTP2zb5sB6DCe9uk1ckdcdUprCt1+CRnmpc9u5pq10vIy5SG/WEPojMBFC4x8781rXjSvQxJU8A2SkvtrSmbgglQqqHgEs5Djt+sz64FdcTjm7BRBfiCWDXrA8dlEg8iaevW6x3a4bXZL5BgmmBDEGMpdEYRAcHkYbggULtEqKxsAAuLbTq8vMsBI9eV0PVdiT+2eOOJ3vZrlcdcD2zHGTN7jRGPjH8I6nSmLuQYRCr3ASoJV5qIyEtI21azQPMJrYEjj8jk71B2aV8Fydt6wH5WzjQeAnMs9Fpe5mDcTHklTPVIMe6XdWOmmpgxZ8F7BzVxYQ/cGTAd3SMdWdp4ojRmxi/o8ha/288yVEv9ZGd6e8r7Iut9PrJRpxM33dxdKI2g8UKaqm0u6tt86MeOytLSOkzUqhQKWj8PDHKw6JtWTbKi0LXvXGAHERcaBU4XCi7qQYQ0e7cXHt7aVRc2SCzPYq/u1x8eMuBHab6iR9sVQstzvOaejeB0xnFpOPCI+n95VJindoGaSJnztxEid8xvA9HrM4tpDfawBQaoJBBx2/Q2lknfgYXv0gNN3qPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4621.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199015)(31686004)(38100700002)(41300700001)(8936002)(5660300002)(36756003)(8676002)(2906002)(66946007)(6666004)(4326008)(186003)(66556008)(83380400001)(66476007)(6512007)(53546011)(2616005)(6506007)(26005)(6486002)(86362001)(478600001)(31696002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHdNb1YzeVFPQXlXYVloci8rSkZkdzRQdWtsRnhkN3p3ZjFqL0FudXJSZ2FB?=
 =?utf-8?B?WnF5ampnajR1b2ppUEhMcU9YcXhvemg3Vm11VUxTRE9XMXYrVzhka2lYN2Nv?=
 =?utf-8?B?NlB0S1RLalFwVVRuZHg2WEk5czhUVEE4RTZpeVFnZ2xtbDdSTkFycDNDR2ty?=
 =?utf-8?B?OHp3R1puRTZyUDBMT0c1MFM1ZHVaYmdaUDNHcGY5aTFDZlpGNE9CQzFJMW83?=
 =?utf-8?B?cmpiQnQ3eERmU2NJUUdvTUVKeDB1WmVZNzRvUjJWVkwycVc0Y1hLaTdITk1L?=
 =?utf-8?B?Ull1aStndXlqS2hBS0lqUDVncndGOXNPN3BsdCs4TktTV0gxMjRvTk8vcDZh?=
 =?utf-8?B?VE5Ec3liTXNqNXYzTWN4VUVTUE5JbS8rV3ZWNnVqMk50SVQxSytBcGxXR0tj?=
 =?utf-8?B?ZUxQNFZqYUlFNy91REJrTDMrNWNwbzZxR296QUp1RjNLcGFYNmNTU2pZd2dX?=
 =?utf-8?B?YUVSOVI2T1RrU1hyMVNERFRMZVhXU1g4VExHTGNYR0g4WE5zRTcvOE0yeDhi?=
 =?utf-8?B?TFRaRi9YaDMzbmxVdHRBb29WTjdRdE8wZlBXVG56bmlZRDR0YlBZWkxEaEcr?=
 =?utf-8?B?bVhxZ1k5ajNSZjJzSkE0Z3dVUEZRenMwZzUzNzNBOUNESVNzVGRNM1dObmFz?=
 =?utf-8?B?azc3Zm15cWp0ZUpyVnpkbHoyeHY2QUl6QVF5Vlh0d3JEY3RHMVVlcnU1OHRw?=
 =?utf-8?B?bHZPcjVXbEEyNlp0NzR1R21mbUFUSDhneUxKNGhBSit4TWRtbUtOOVY5aDVv?=
 =?utf-8?B?ZkRxRG1Ienh0bEtZdm9KWW9MTXUvYW5SS1pwbEoyaE54L3dic25OTzg3Nml1?=
 =?utf-8?B?R1AzQ3h6N0x2ZWFVdHV2cUVHb29oUWtMdWl1eUd1a1oxdnNxaUhndXpVQWtW?=
 =?utf-8?B?MElnZGR0SDFzaHF5QVk1b245akxQaGNDSDJYL242Q2ZRSHlMWVRJellSODZX?=
 =?utf-8?B?bzlTRERrZ0svRERQSGdockhxcXdjYm1ObVB0cXRDTWI3QjRSaWFLNFk2Z1Y5?=
 =?utf-8?B?VGlhZXlRdFdUVjdJR1NPUFVUZWY2M2JwNnJqbUR0ZkJ3TFlwWVpKUnc5VGFU?=
 =?utf-8?B?cHQ3UFZGTVlhbXRYM2IzdHB3MDIxRGxrdXhwdTF0TU1QSHIxQWszRndFQkxR?=
 =?utf-8?B?M0lDYnRoTEZLS1ppZys5S2F6ZEhiS0xmN1JwTllldFNScEloV2VyMGgzZ0JQ?=
 =?utf-8?B?empvMFRoYVBaV3J2SjZwNGlieE9lVE44amVFZlZlSGNBSVBMWEZtWHBvQ3da?=
 =?utf-8?B?K3dYK085M3ZwSitKaGwyTk5sU3pYY0tYbnRqNnFCZllPdnkvR3dFQlFGUUVB?=
 =?utf-8?B?blpQVDRNRE5CSnUwb2VPOXlCanlSRHF4TktSTUxCejU3YzcwMG9RYWVVcloy?=
 =?utf-8?B?VlFwTlA1VW1OcTVBS3lHZnpaYnF5Ujhuc25GYjlad1l5dUd6VWFFdXdKYzlw?=
 =?utf-8?B?aTdac2FPMlM0QW5PS29oZ1k3OURWMmtoVmRHQlQ0OWcxcjVFd3IxaVpjSDl6?=
 =?utf-8?B?NjQydWRGOVIwSlJNdURWa3VRMVo1dVV1WGN4dkZPOTVVWHM3am5zQmwrcmRX?=
 =?utf-8?B?UERjUUltZmx6UGNCQWZSeklLZ0ZBYjdmZUZ5L3labExFSEVUYi9PRFc3V3ZU?=
 =?utf-8?B?ZThnRXBqaDU3YmJyQmtSYlJxS2RtMUd4L1pLbmg3WndjR1ZEUE9Ub0RReDR6?=
 =?utf-8?B?dEQ2clpUQzdJUHlHcXZ3NDVkRnlZQzJsMmlvYktJQWNDY3JJenhOaWRSNjN5?=
 =?utf-8?B?d29tbmhyYk92b3dvMEZ3WHRTNURCcXljK3VTMVB1VWtuVG5VaVdpNWpKUW45?=
 =?utf-8?B?ZUg3K0RFbDA1aFYxREFINy80eGxmWDEwYWxjSzA1cndqY2twM2srcmlqR1Av?=
 =?utf-8?B?NW1LYTdwSTdqS3NsMDNlN1RmenFSZ045SlFvaVRrYUg0Q2RnNnl1MG1TMDJ3?=
 =?utf-8?B?RVZqZU5qSlIvTkRjZGg4QXJVVDlVM2tBTDY3aTkrTVRzZmRFRUQrdDM3QU50?=
 =?utf-8?B?Y0VmNGJRWUVlczlmWmdiTWVOK29iNFNQMm5BWG00YlA0Tm5KdTIyeHRlSnZt?=
 =?utf-8?B?RWU1b2tKR1NhbjdxYUhYWmprTmhSMmVBcG9oSzlKZkphSUdQMHhNejg2WVgr?=
 =?utf-8?Q?sYaiPQhJl+CEcpPKwjhO9B2AS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7986b874-2a46-4fd0-86d0-08dacdc968a1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 03:10:15.7633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qzl0IslQRbuN/n9eo6Xfc/sO93D8E8MTwxXog4tVXfSFxvqLqakS8pUn8YbWNXO5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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
Cc: Skikai Guo <shikai.guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/23/2022 7:30 PM, Alex Deucher wrote:
> We need to always call psp_load_toc() regardless of
> whether we re-allocate the TMR buffer or not. Fixes
> S4.

I guess this fixes all cases where psp_suspend is called (regression 
introduced by the fixes-tag patch) and not just S4. Suggest to refine 
the commit comment.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
	
> 
> Fixes: 36238df85ade ("drm/amdgpu/psp: don't free PSP buffers on suspend")
> Reported-by: Skikai Guo <shikai.guo@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 42 ++++++++++++-------------
>   1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 621723f510a9..7978307e1d6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -750,29 +750,29 @@ static int psp_tmr_init(struct psp_context *psp)
>   	void *tmr_buf;
>   	void **pptr;
>   
> -	if (!psp->tmr_bo) {
> -		/*
> -		 * According to HW engineer, they prefer the TMR address be "naturally
> -		 * aligned" , e.g. the start address be an integer divide of TMR size.
> -		 *
> -		 * Note: this memory need be reserved till the driver
> -		 * uninitializes.
> -		 */
> -		tmr_size = PSP_TMR_SIZE(psp->adev);
> -
> -		/* For ASICs support RLC autoload, psp will parse the toc
> -		 * and calculate the total size of TMR needed */
> -		if (!amdgpu_sriov_vf(psp->adev) &&
> -		    psp->toc.start_addr &&
> -		    psp->toc.size_bytes &&
> -		    psp->fw_pri_buf) {
> -			ret = psp_load_toc(psp, &tmr_size);
> -			if (ret) {
> -				DRM_ERROR("Failed to load toc\n");
> -				return ret;
> -			}
> +	/*
> +	 * According to HW engineer, they prefer the TMR address be "naturally
> +	 * aligned" , e.g. the start address be an integer divide of TMR size.
> +	 *
> +	 * Note: this memory need be reserved till the driver
> +	 * uninitializes.
> +	 */
> +	tmr_size = PSP_TMR_SIZE(psp->adev);
> +
> +	/* For ASICs support RLC autoload, psp will parse the toc
> +	 * and calculate the total size of TMR needed */
> +	if (!amdgpu_sriov_vf(psp->adev) &&
> +	    psp->toc.start_addr &&
> +	    psp->toc.size_bytes &&
> +	    psp->fw_pri_buf) {
> +		ret = psp_load_toc(psp, &tmr_size);
> +		if (ret) {
> +			DRM_ERROR("Failed to load toc\n");
> +			return ret;
>   		}
> +	}
>   
> +	if (!psp->tmr_bo) {
>   		pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
>   		ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_ALIGNMENT,
>   					      AMDGPU_GEM_DOMAIN_VRAM,
