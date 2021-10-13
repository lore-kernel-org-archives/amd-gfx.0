Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FDBC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 14:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804E960EE9
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 14:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 804E960EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F23DD6EA67;
	Wed, 13 Oct 2021 14:30:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F6FA6EA67
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 14:30:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dg6cGFRulcF6jVAX744U+yRYNTDp2snKyjTKd05UFGy6Bdsu3at50tuI6Ybi9WasOOUIx/bg7R5m1n6psPRtwHNaK+nnvy+o5qmp6RPVpGh2T5gWYe09r2p6lnLBuWE1uy9It8O9U+Z41tplHJNNmVf/wATvTnYy7xiHDnvB5/WhRp0keHiHg50QFiqPNnQIYIJ4UhY6qt5hrF9I44PXoWz/DVrHLjItKqZsEzriNAqvXAfhFogUNPQMpK5X0ZfTR03mGwHfx9JaJEJbrAmUmX/7IHn5i5B6tEBgjzttBgDDB0CpkBHnBteUgZfhFt+JF9yplhHc4q01s8kXTWz1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lyqp3t4V+5htIx14DA9u2lpzlQTj4vNHpZn0JDBOcII=;
 b=mwanUNpYYl3ebx9JgVi3BDDBbvzSWmYyvPtDi+O3b+wXCSgALibnVxr7OnBxGSMVQKbveD+1kXLmfd5arrzJWFwpFj7qQrBT4Muv3/r5Ujxcqg8dYtq4DfFG5fxwuIKkp5nZTWYpDajAdJCC8h59SYJDxyf9fTcBxR/FV2Pt8n55h/vD+6e9VAxys8g67ypyVXWFrRdRN8GUFM49JGvC/pjD0BNfUC6tWa6xG+0hbEV4nRkQI24nh0370AfRYTTYZWlRWgob2eM2OolaT/D8FBZtRMOaWJ4HOaAJefU/cC3ME0f5VVH8e+R0nh8P9TvmDHGC8dAImvIjSY8j18NOoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lyqp3t4V+5htIx14DA9u2lpzlQTj4vNHpZn0JDBOcII=;
 b=DTyBV2Gsl7qGgwqh9YkFUknecCqTObiwri9knhFPLdak6hes8xsML4C23Zt8I9ztVXgYKKEK3G5jxC505pSeuNU1rk2rQMBm5YBTXrIffq2XDLXa6nxCYrTE+x4ubQfyGNQ5Uv8BSZAOSottVrxH7E0JmPBaww1o0LnSJfIngzQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Wed, 13 Oct 2021 14:30:55 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 14:30:55 +0000
Subject: Re: [PATCH] drm/amdkfd: Fix an inappropriate error handling in allloc
 memory of gpu
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
References: <20211013072824.985175-1-lang.yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <748808f3-f6c2-3cee-556a-584066de9e07@amd.com>
Date: Wed, 13 Oct 2021 10:30:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211013072824.985175-1-lang.yu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::20) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.14 via Frontend Transport; Wed, 13 Oct 2021 14:30:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c9a4328-a115-444a-0a53-08d98e5610a9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1657:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB165735F83843C9AD013E4E1192B79@DM5PR12MB1657.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3KSQCH8k1lCfo9/t1mp0IvaRuvW8oDZc+/K5ZfDQO6r9vQ9nPOY1BnK/Ws1ENFx5Bwn4SIrePJLmNtCuORqwdExDJYGVMDL3zQief5lyJ9uZQ3XfBgS60WHq70qNtT9WSb/5XI0G6E0YdwsweaSQEsiY81esoyDg2blvueM2YZBztsGzGHd3muGd5j25epx+SDhLFGQgrfp8h1pNC/HVcJkGx7240FWhZCR5HEgM30geuaa1CaVwFMwZYaLrye24a8j0BJa3rKipjJT1M5hYrd9b2oErdQ1+Y5XHsnKPeVYNOuiX+MTEi1riGoM+g3Y2jkijWAcZvfNp8vvsdveTKrPiHT4REfeG8Da0DNoFNX81b6u9TGe/Z3TxB9PZixpV5OcbqJwrKN/J4azNcTv7yqEd4hkqYiaauHtMserznHX5ayXSx0XpDJb6bnK5UmvekuIc14X5R5EMlPOQZOCc0ESGsH+fBNlVqdAcqhpRzwSkM2CzULS9vZtbN7Q05CBbG91gkWUFGHb9oxRslltt3QNgyn153HbQsgwIj7pc/YhEnwbvEuoQxozBoMEnYazMi4QHqcr2Zg4t3t1PRkKcYs03b4GBeGJ75FcNVBLvBBB00SG9nRgykTQql+jlmOIRe8tFGPiMaeQM5QADuGip0NFjDQeW+5IZ5bvnDmAlkq+Afk/xyth4rYY3vTDyrFQg6Q7ocvea375WShzmDgRHH739Fq/ZDHmOMAfBwHd6JwMoU9DagWXeJ9g7rN4hL9RG2lWWgGC/aiqQUS/LC64vpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(83380400001)(31696002)(38100700002)(36756003)(44832011)(4326008)(186003)(956004)(54906003)(31686004)(2616005)(6486002)(316002)(16576012)(86362001)(8936002)(66946007)(66556008)(5660300002)(66476007)(8676002)(4001150100001)(508600001)(2906002)(49343001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THMzZHlvSHF2d2E2M0xVSW9iSkdBWlFLWVpWR1Z5Qk91bnl4bFBXTEpYVmxx?=
 =?utf-8?B?K2M1YXFKNURob1gwVDY1U1A5QzVxdGZxWUN3SmJrbXROS1JWYnBjNDRxcDFa?=
 =?utf-8?B?VGwvaE54Rnc3YTZrZDNIQmxvSFdnYUtkMTFvdGRSblhWakNEODFJLzdGZjFk?=
 =?utf-8?B?N2xEY2hRWWxIcGx3cmJjejBieEN6bTVnNkVqNndIbXk0cTJhdGh4WGkraVNP?=
 =?utf-8?B?Qm1jTGZHU3c1cmNKZmFIUzJ4M1FKQjcxV1lyUEFycHNhQTZabDZzMlYrMTVl?=
 =?utf-8?B?b1RtSWYzWjI3dXNUUGg1M3JldW9YSmNpRUpBcWI3ZmNDNUw0VXdiekFEZmVZ?=
 =?utf-8?B?S0RwUDJwSitDMzA4Sit3dVh2Z2d0Vm5DbmU3L3RRQTYvTzcvQ0cyMXFaeVZu?=
 =?utf-8?B?OWRsWlRzTm1GVW9RN0MremVWcllNNnF6aURFbjJoSXlNT3lBK0RYZkRrSlRa?=
 =?utf-8?B?ZTl5eVQ0ODdpaHg3cTJPV3g3VkR3K2hEQll3SUFzUmNTd2xkaUM2QWZhUkV6?=
 =?utf-8?B?T1JkbUpERnVMcVlSSHVsSHhiUXY5N0NxMzNKOGRzKy9EcmhtbDFQOFBlQ0c1?=
 =?utf-8?B?QWxYOXNUZnExZWtFOGc5czdCZ3VHYi9QRG9XU2hwbHBIWjNxalFaV3lReFcr?=
 =?utf-8?B?akxZTG9iQ2MvQ2dNVFhFTDFVRmpoSEFXWmR4dFZmaG02WFgyNTgzbzNjcmsv?=
 =?utf-8?B?WUVxYjhsekphQ25waEZGOHF4RTFFOVVINVl4SXU2TEF5QWJNRkZWczJ2WWVE?=
 =?utf-8?B?NENsRC9YUG9OUEdJd1RSczcvZC8xSU9tNUVCUmlJSnpxM0x1ZTJEWnZnaXk3?=
 =?utf-8?B?ejltTlAvZmg1MzVFT2dqOUlqMWZ3UWMvOXRoc3JnNmpNZ0Y0RU5OU1dqRnZO?=
 =?utf-8?B?ZjdGN1FBR2VjZmhTcUpzQ0NhYzFTRzV3a3ZUL2RxcHdlQnYwV3Y3Tm1yTGlW?=
 =?utf-8?B?SE93cHk5c0JrQi9ONVlLWjFhNkpTV1pqbjlQN1pQN1VuemR3YmVGY2RhYzhx?=
 =?utf-8?B?L2hXbWNPRFNub2ZqQTZObkFheTBSelBVVXRod3R0TzFaekZyREFPbUNkSXEv?=
 =?utf-8?B?ZkJyZFkwYWNSU2ZrekcyUVpFeVp0WVRsNUxUeDc3RU9mcUo3MWdNeVBYenVl?=
 =?utf-8?B?dlo4R0dLdUVReHRCZkVzRU5Pelp3K0NUZmE0bEFkcUN3eHRJSXBCWEYya0FJ?=
 =?utf-8?B?MWUvRHN5RnM3b1EvTDFucllINTYyenRHTDRwMGI2d3QrUlpESkd3Mks2UkpG?=
 =?utf-8?B?MjVZaVNFOVBlSGxtT1Y0WEdBQ1BzV2oyQXEwWW5oNVFLQXZabSs5U0xJRjQ0?=
 =?utf-8?B?L2ZlN2o1M0VaNlk2RkNCSytlbkhkQnNYb1pFdGdwOXpZUlBuS2U2ZDdpbXp6?=
 =?utf-8?B?Vmw5TVhIejFNUGY0eG9BMGNyMDJPQTdRMVZiYTR2QkU2TGtRcEE2UmxNVStG?=
 =?utf-8?B?RDhnVHhZRHc2ZXVQSTFkZm40c1V0Y2EyS04razBDelBPQzQwVnhFMFpZWFZY?=
 =?utf-8?B?NmN5ejYvbnV3TEFMUEVZdmw3ckR3OHk1YnlKV3dnTVMzMWxsUTFFMU05VlND?=
 =?utf-8?B?L2RWS1pKZnVWOTdiM1hteXB1QStFcGJQT1ZFK1dpeVNZOGdTQ1BNSlMzMmRB?=
 =?utf-8?B?Z3VFRERaVkVCdEdIYXpLaitqRTg1ZTBSbzVXUHVPRmFDcmI4dWhrMWhkRTlm?=
 =?utf-8?B?SFNIQzJQa3I1SGYyL0dYU2hjbUh4dytndzV1bnlucWZhSWtnMitUajkxc3BJ?=
 =?utf-8?B?dEJRdmF6YUx2U2Q2bGpKbXZLT0I2VS9oMTdtOHhWb2dONjFtREFlN1Y0QUc2?=
 =?utf-8?B?R3lYYmF4NWM5bVo4NCtKUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9a4328-a115-444a-0a53-08d98e5610a9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 14:30:54.8840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sr2vcp5PYZz6TeC5ubpwNxO55gkuLpR6QsQuWH35a/c9voGmqqsxlD2yf8sK7n13Eo+oMgBLy7F7HkVCLIBwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1657
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


Am 2021-10-13 um 3:28 a.m. schrieb Lang Yu:
> We should unreference a gem object instead of an amdgpu bo here.
>
> Fixes: 5ae0283e831a ("drm/amdgpu: Add userptr support for KFD")

I think the Fixes tag is incorrect. At that time there was no gobj in
this function.

If anything I'd attribute the problem to fd9a9f8801de ("drm/amdgpu: Use
GEM obj reference for KFD BOs"), where I missed the error handling code
path.

Other than that, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 054c1a224def..cdf46bd0d8d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1503,7 +1503,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>  	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
>  	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
>  err_node_allow:
> -	amdgpu_bo_unref(&bo);
> +	drm_gem_object_put(gobj);
>  	/* Don't unreserve system mem limit twice */
>  	goto err_reserve_limit;
>  err_bo_create:
