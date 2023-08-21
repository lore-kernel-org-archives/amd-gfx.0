Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077E3EE4996
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 20:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D8FF10E2A6;
	Mon, 21 Aug 2023 20:34:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C0010E2A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 20:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCUE56JUeytAiAWkuBbHJgg56xDVEsG6pX9jQyevzcGUadOKB4pdnw654ja0BXA2Uax6ErgXGIpScKR93UPEQ0y2LTWLAF2j7eJnshGmjaQY7zku5ExnzP42OOnQ6GMdPkLFWFno/3tW8G5ui50PEArWudbqVUdpmvf/DTJ1RAt0kRxhtyySUEPdx19B9O/06GvQ/pkdb/S8HXCAsE1E4+DxWG0/sGD5bOiBn2SpL0cxccSSjB5HcJ3w99gtypIZHBLfa1zmDzMt/LIOiOfGM1uyXK6PwRH67pS4Qy2Sxv5ZFvhZMSMT1y7SPoyCUVW7DbwUgbSrgRio3aBoef9ljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWQu+CPQwS9vXtu9iKmGfZABuockb85S/XDLnwePem4=;
 b=BCCESMQZYqqFJ4aDwTtcXaE7RElpAXfoSfNAIaKncvAYeeOCNNBLcAS7ZXohHhvUIuJsHrqyPJtjZte1E1nOZJDB6xOm/UqBm9Dh4YwbkmeSwmaqdhNdKbVPWWl4OT7+U/VK07Q4ZlkXXhcchSK+rseDyZ3KuM/gImf3iMk15b1AhHiumtB/7kO6wbYGrgwHHCBFP07PHc420byGDEGO4RjRyeZqM2V9OP/FXdmYP9PVnFCCJUxw6hz53JKO2hNlbVNQpKeS+Iwd0fKQWXMe8VQHLJMhLGodim0xdW36ddeBbzM4OWEf1/rjgOvmlRmrbX2QeUU8aZXr62J7LGGCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWQu+CPQwS9vXtu9iKmGfZABuockb85S/XDLnwePem4=;
 b=4GefrDGEX901TXKIEo0VZ5lRl0yIP7ySLd3+DkGNrp3JZI+AvByYRivpA9f6nuHc1EKI9vXniEQ91QpwNNuI93yaB1tN4EyZ10tKcRW+IaOyoTPoYDevjdK0VCdF9QGOFf0d0+0QfLGbfAY+YPa92qPEcG22VlLmaRaP5DoeNZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 20:34:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 20:34:47 +0000
Message-ID: <86e16bd7-fbad-bebf-96f6-4b8b4972ebb7@amd.com>
Date: Mon, 21 Aug 2023 16:34:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: Share the original BO for GTT mapping
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230821192912.1618-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230821192912.1618-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 63163b48-0240-4b4e-1d29-08dba2860f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WEqfFHX7/pcGuWkY8bO95vHm78zP80UGQDUw+OSbfeGj0oTIXVgs1b/q/PDsEAKIWvPe9fpGWaZtZmJkgvYRNKSqy0UoR/AXDeSLZhhDt4OiVnywnU05VGIpYX/1YLg4zxbhlpbYOFWtfy2dsJIeA1kWqiMpjDAXw+ugXlR2K5t7BAMIkXxY9TriGGH1H9qrWDb9qIXBqpsXxw7EHIpwQKfwx06N7j5y0s7pPaF1YRDah9HTV765UBY5FN1wlHrdqGotkIUjdl5PEFua8A6jDZ/JDmSSr5igSh+y8dF8lgTGtQC2/kJVEFvywRXrctUgl2HaYI3Ck9WEhmE2M9DNwe2pyNii5JK2xiLkvbTj8J8mMEJp+X89Aw1QP5a1I/c/84blMSovXMDbg7P1H7Bbsraqbz0NWJxNz922PdmpZ8rRPGAICipu3YfIiBdtHQHdF2U0g57LfAC4WjGLGpOnAPQA3RGzPGKVevLTb/Xnt+6/kOKh+QVO3mEyd4wlP9jcoYq2w9fqYl27dR5V3j2B6ry5KDCNWG0N/IQ/XkY2XdldVQ4Q/s+d+J1twIltSqcxEb0OzYi924ZYNw/rZGuyxSL1hS8Mlwu82gA1XvL5In7mbzwK58nCa8KOsHUCPy1F/zF9GJxIDraihNcJF68isw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199024)(1800799009)(186009)(86362001)(44832011)(5660300002)(2616005)(41300700001)(66556008)(66476007)(316002)(2906002)(66946007)(31686004)(8676002)(478600001)(8936002)(31696002)(6486002)(36916002)(53546011)(6506007)(38100700002)(6512007)(26005)(36756003)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTROMHdnKzVicmFzY282cEZ5Vi9SSkgvVWlRTVdpNjhWVGlraU1Kak1ZeDcr?=
 =?utf-8?B?ZzdYQ2dORWQyWiswYlgwOGdGWjNJMXp4OFVNWEdjeTI4SHBXU0U4ODlJUjE4?=
 =?utf-8?B?aEFEYkx5Z1N1UWd6dDFLVm1VenI1UEN3cnlOOEdEeC94SCt1K2NwcFEyOHFk?=
 =?utf-8?B?bUVWSnMwVlhHY3dUWGIvRTFoOFY0VEh1M1hXTWVFV1JsaXVZbFVuTFZueXAx?=
 =?utf-8?B?SnJRZ0V2Y2hTWU1xaHVIRlo0dEZsckNvUWtpbjlHZWlwTlZxckZuKzlhdEJZ?=
 =?utf-8?B?RTJjdnJ0WTRMRUpLeTROSHdTalZRVGJrUWE4WTM0UXgyZlZ0U1FSbWtuL3B2?=
 =?utf-8?B?Znh5c2RDalZVRW10WGhXRjM3V3RZeHo0bFB0aXJDNDJTMXJha3hsNXhvVWR1?=
 =?utf-8?B?ZUxHUUU5alJVQW1UZ0c4ampHUE93RkhSSXVkeEcvL0VvNCtBNGhMZ04yaEF0?=
 =?utf-8?B?TERvOUo0MUJCaTBGb3FFK01ldkVjT3JTbmxkNE9ITUZXd3NwZmtsL2FvaHBn?=
 =?utf-8?B?TnFmOTdZKzBJWUJleFNLRDVUbllQYnZJWG5pdGliTTlvOVJCcHZmN0NSSFVO?=
 =?utf-8?B?NzVnNWN3REdSVXFvemN0MlhhOXMyNXBxd00rV2l1WEhlNE82NXNrWEo3d0NP?=
 =?utf-8?B?c3UwUVBHaGdCcVJrTEo2YUNsMnZQNTBUTzEvSUdNSVM0TzJkYnloaHpYckkr?=
 =?utf-8?B?aElzbDhNN1BZdTJFakNiOFgvOWNGTEtkT3A5U3RsdXRROXhVQlc1TDB0Vnoz?=
 =?utf-8?B?eTNzQUFuZjlpWGhCT2RCdG5BdmFCaEpTSnNpZE9iUDdFZU9ZdExwcmZXNTJ5?=
 =?utf-8?B?ZmNjeTJiT0Z3WDZQYkpSWkJ6a2M5U251cXVMeTZBd0tkVlpTVTh4bGRkTUlt?=
 =?utf-8?B?VmJXSkN5RmxoYS8xWWNBWk1wQ3lTSm1RRllJVVlFRFhld2xLNGpTNktLU2tI?=
 =?utf-8?B?ekZRdHZRdUxQSE9yR3NENzFqSjkwVmlnR1JqYlk4QXlWVGN3cjUvZHBRcmh4?=
 =?utf-8?B?cGNZOFl3b3RvWXlyYUJFZ1hrTUxnWTBRSmlCZjl3Z1Y1V2p6QmlBTDcvbHVI?=
 =?utf-8?B?ZHY4SVZ5OUw2QlFkaTVNTzAwSWNVSUJLNWpJYnhETDljK0JZeTJTOUZaanE5?=
 =?utf-8?B?bVJQZzE3RjREUVVxQkMxTGE2bGhTVEEybWE3eUxBOGlWSFlBb09QUmRndlpC?=
 =?utf-8?B?ckN2aG1Fc3hTVEFPVDhWZExtMDNWVnkzSllnRSsrTzRaemd6a2FDUEtJNXAw?=
 =?utf-8?B?S3FuK0VUekVkb3RIazdRQXFZVVdaem81Y0E1OHJnaHI3MlNaZFdqbDZMRFo5?=
 =?utf-8?B?QVpJR3VUR3E5U3lZVVZIUlM3bHB4cU9YK1NuZS84OUdkdzA1dVl4NGFMVllD?=
 =?utf-8?B?T0I0dXNMRVV1WXpSc1VjVWwxOEVveFl6RnV4WW5TR3RBM3h4cUpESGZEMCtt?=
 =?utf-8?B?UHkwY1hnZENPdVZTL2Z2M0lWM1E4YzZQUEZ3WXFtbXJ3cEl3R3dGM2ZtSGM0?=
 =?utf-8?B?YW1veS9tNEw3b0twVVdZM2o5SkNiZlROc2NCdk1LUkpleXZCU2NXSE05dmVL?=
 =?utf-8?B?YTZCd2RLYWxNYXUxRzFJREcxNnJIRHQ5bVZuMWFUWTN0U09LMjdIUXFQOTNM?=
 =?utf-8?B?alNHaWcvQVgxdkhiQ2lZNFhnengzUlJ5RjFFeGQwM3EyL1pvSHFnTFJMVmdK?=
 =?utf-8?B?bThXaVJwZlFhbjcwd1NneXNTVUZBWHZKcnNsK2ZDdlRVZUtrZ013U2tjaXlx?=
 =?utf-8?B?NXNEMHMzMlhSTkI4eSsxdHNFYW1sSGhkSHp6dlZPMVF2UXhtZFZ2aTJtOFN4?=
 =?utf-8?B?OS9EeGlMdkFSWUlzRFc2ckRrV0dFWHB0aTRjamZ4RVRYbE5KVWk3azlMWEJK?=
 =?utf-8?B?cVBuVldGczNBMDBDN2cxWUlGRFl1ZkhNeG5OcDBZeHFOWUtWdm92cG9RaWlV?=
 =?utf-8?B?dWVGNFB4eHFxM3ZhOElSTURaTkdJZkNDbFJoRzgya3hTU0w0RURwMXFiSXdR?=
 =?utf-8?B?ZVZTZ1ZNdDN2b2tkVFBFVEZKUWdxbmw0ekhmbDdyYzJsb3d1eHJoQnkvcmRx?=
 =?utf-8?B?Uy9uVDBmNk81bTgxWC9ISUwrUHB6MDhvYXBhcTJPV2VueFZlQWpJWXVXTGk2?=
 =?utf-8?Q?7XatEBJ91Fl6ukuSTAGLe/2oj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63163b48-0240-4b4e-1d29-08dba2860f9a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 20:34:47.5272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yapGg90EPlbA9Z+7L51QSr+sWtX1I/roPlDfBlX+zCjoEhKl1y6AUyINHvwRMiGEerpaAtLPv8/dUQDMszkCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771
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


On 2023-08-21 15:29, Philip Yang wrote:
> If mGPUs is on same IOMMU group, or is ram direct mapped, then mGPUs
> can share the original BO for GTT mapping dma address, without creating
> new BO from export/import dmabuf.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 282879c3441a..b5b940485059 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -864,9 +864,10 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   
>   		if ((adev == bo_adev && !(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) ||
>   		    (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && reuse_dmamap(adev, bo_adev)) ||
> -			same_hive) {
> +		    (mem->domain == AMDGPU_GEM_DOMAIN_GTT && reuse_dmamap(adev, bo_adev)) ||
> +		    same_hive) {
>   			/* Mappings on the local GPU, or VRAM mappings in the
> -			 * local hive, or userptr mapping can reuse dma map
> +			 * local hive, or userptr, or GTT mapping can reuse dma map
>   			 * address space share the original BO
>   			 */
>   			attachment[i]->type = KFD_MEM_ATT_SHARED;
