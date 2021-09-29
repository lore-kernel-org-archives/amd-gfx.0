Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED21C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 15:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE5361406
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 15:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DFE5361406
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 643746EAB2;
	Wed, 29 Sep 2021 15:18:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D7126EAB2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 15:18:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBwn4Og35PdravcTgUAzpqCAQvc8T2LAwb4he3k65ZvPsaRdF3iz8Q+r8N186D0aiinU7Q8d75lt7mpaWR9N+o+dsou64QtWK982RtEFgVdZLplmyVYHMV621EWl7PZOauRL+iX8sbJ0J13dQab/FGl885I5IsIDcn8iiwXU8UV409bzppMoSH2aEJJ6BWoco97hDFoSOCI0Rranq0kuCyUPqCajV2Er5Hc70lOZbExhiz9vSZsp+hgk7vyX+GF0ZE9Y+vck7f7przVoqKPKk7GvHUWEBN88VklrrCrLz3H/g4wC/noJuc4+ho6vw7M/3jjPo0ZqUual5+ePpPL8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=qzgY3pqTgFCQL1Awtr1WC+XTvYjhVYFahS8erP4O8gk=;
 b=XgfKHFhgsdlZRk3+BUpdBklshZrxoJGaq/QskUGtCP5qKwzwzImWtl9LIRWaLLysCdvFTg9+Ry1Hzssmv3NHt1MM6/Cm8HbYlKQ1Nv73kiGVBz+dJqJem9GUoKUhYNgxsujHAys5mCyvfy94a4KuZr/xyXJJQODZYzNjCNbi3aZ7s4G6mBIahJjkNMV/m+Whz2NrAMSAJXDdBQK6cTKbtjoOlM2f+2uPpCmruwoSlax6vwZ3Kts9QF28WhSofqM54ESRxpQWdcStn9RAXt5FJ1WN9A3y99maTx0L2mmBAQ14YsNKVRwSRf1jvlyAiHMh+mtT6lSYx+Qh8hj/+Np94A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzgY3pqTgFCQL1Awtr1WC+XTvYjhVYFahS8erP4O8gk=;
 b=W8eN/PqXdPngymp6HdWUDZ/rWA1EHYOQFIpKMW1skPoqSz0BLngo2CyQgLhcw7Kh/vnpyrGH9RSjazRcERr+Kr+yZiTs/diWB+ct2odTUiMrEcXd6eqZa4oDK47Efmrk3JBZGKuyeTpUXp3mr6qhbpjxNkEVLexd14eDl8pl7pQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5258.namprd12.prod.outlook.com (2603:10b6:408:11f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 29 Sep
 2021 15:18:45 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%6]) with mapi id 15.20.4566.014; Wed, 29 Sep 2021
 15:18:45 +0000
Subject: Re: [PATCH] drm/amdkfd: fix a potential ttm->sg memory leak
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
References: <20210929081959.1805447-1-lang.yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <0446b277-f9f7-ae65-b120-18e92bb94d87@amd.com>
Date: Wed, 29 Sep 2021 11:18:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210929081959.1805447-1-lang.yu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::34) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT1PR01CA0095.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.13 via Frontend Transport; Wed, 29 Sep 2021 15:18:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b0ddac2-9c05-46ba-b949-08d9835c6d71
X-MS-TrafficTypeDiagnostic: BN9PR12MB5258:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5258DBCD86D65E014240F7AA92A99@BN9PR12MB5258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: THmtUBd8GZutSIfoD+sUGI/GxZzj87NmhtF4LSjZXbp868UbUp1RPojSDrstqFAV4S86Rhv7ANWopOzzQ1DJZec7Y7lX2RSFQ9zJcpBhadWoJD2iUOCbsN2xt9Dz4rmev/FmJVQXP51A+KnizMeOR3UeUB8Gvq4TrgS1mfBSoR+xiXPIbxNMoD9kFQChqgXcd3qbGzRdYKHY9dhUrPrpXC+at6saLeLSWvTV0ImGOtrei9e1+UiFnCcdzVomQtC2PN6AnJqU4LCN+3mbPl7jVSgOV4FYJ9QhWTSGF+Afdd2NKE5jxYzen9EhCUEGF6qWfRIlN3CRPRQDNeBKyx5P+qhruRYlh0ZX8G3wLVcXNJlklsgSe7Hl9PZPT2Yzb5icvhDYqdG08jnq0UpF+If/UQt9XzMNUqg0qX+nBV/avTgzPUrjw5dxqNUYb5QpvwyqVHfnhn599UitB+V4+76DzAuABHXtZJsHipMJAknRqJWJiCKthf3+yCK6lPHTeljlNAjCKP8mPey3DyAuYhuMZSrYN5605nmGjmIa/GKGjxXoyerCv6c+fl+q7q/yDq9p6Xbu+/Bf89JsyhHr2EnbpR1psj3xkqjji0U5QvHBzLHG8Qp5VCUSAYlyDqM3RCSpqEbbAUdg1KMH68EiKMEb7i1OVomNZYrUbil6Z0Ltn+GY6/DEA1alEji/b9wkKgGqew5o/VNndh0wxU4HrujYRd4bAtOrNiqaHO3xU6lBYSps4Z42XHFY1VcghP/hmLU0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(5660300002)(36756003)(54906003)(31696002)(8676002)(38100700002)(186003)(86362001)(956004)(2906002)(66946007)(66476007)(66556008)(6486002)(2616005)(8936002)(26005)(316002)(16576012)(4744005)(44832011)(31686004)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkNETFNraVRjalpUaDFibTFqM1VHM3BBeUFjKzRHTWNXRzFyckp2eFhQejl2?=
 =?utf-8?B?NHRJc2ljQThZZjROeFBySXcwMmlaTlM4SHJpZ1lBZW0wNWJjS1VndzUwSzlq?=
 =?utf-8?B?RkpNd050VWZNSjk5TkNUczZZazltTWU4TTJHd0Ztclprd0JTV1lXaHNPaTRs?=
 =?utf-8?B?eHp1cEFhc2d4aVI5NWhWeGQ5ckN6TjFXbkMyQ0o1R1hIeEx5UXd2Q21Eakhs?=
 =?utf-8?B?aFVJN2Q1SnhjZGlVTUVVMkpNdXM3SUZlVldtV0l6UXlBVGc5WHQ5YXdHdmpk?=
 =?utf-8?B?bURhSzRWbTE3QXJQWlJZY2cwbHFPNkRoWDd5RFA0TzRhUUhBMmtuM3h5OE5N?=
 =?utf-8?B?UTAvTFhEZFBsdGtIbFk4Tnl3bDVseUFFMFpaZXYvMjBCdGE4ZEYrYi9QM1Zm?=
 =?utf-8?B?RWxXVk5uMzJOZ3VyOFRhTU5ySSsvdGR6cWVIb05KSEhMd2N3RjNQRGZUakhL?=
 =?utf-8?B?N3hQZS9ldVFFOHh2RTZiakl6NVZzVXRRWjl4YjRGNkV1RE1YK1JnK1Q4WWRR?=
 =?utf-8?B?aWdWbWYyRFRoaS9TUTNrdVZPR3pFOExWaTBhb0pSUzkzYkIxTTkzdHEzYkd3?=
 =?utf-8?B?TVNZNHFheDFLSnB6Uk54NlFMcklxT0UySlV6SVRvOFhhbzFyZUhFTWRzcS9T?=
 =?utf-8?B?UkNlNk9ncldrTWVhcjNzQlFuMlQ0ekp0TmhJOEhBRWY2M0E5Mm1GWSsvcUNL?=
 =?utf-8?B?RWN0TGhYODNYMjR5Nk90UFpudnNtbkFMQXE3azhieXZmVjlsMFJXbC9NQnI1?=
 =?utf-8?B?K3JnbzQ0T1U0NnJVUmhDbTM5amdKQi9UNjJTa0ZZeGkyZTZ1dklIVkw1SDFw?=
 =?utf-8?B?dlh4V1ZBUy9GaFhZWTFGVk10VGZoQzhLQzg3M2cvYk5TUlM2Z2tZZDkyM2M2?=
 =?utf-8?B?UkVOZy9zR2NXY0hhMjhWRlVsTXRRK3dDcWp3M0paQ2k4VzIwK0hEa1VLQlhy?=
 =?utf-8?B?UHY1OWw5UVJHOG9TOTU0VWZCMklXakpNWnZ4SG1lZGNOcWlwSFNFUm9PU0Rl?=
 =?utf-8?B?RkpGTUQybi96OXJDa2Fka1JzMCt0ZTR4R0xkQ3dYL2dtNTJEMkE0ZXRHb0lu?=
 =?utf-8?B?VUwwdEM0akxzQ0ZyWWZ5ZSs2RzRReXBpL3RQYktpOXpQUTBwRVlnNkRjeTZ1?=
 =?utf-8?B?TldwN2hscmVLNGZ3djBSVThjZ2wvaUlPcVUzK1VHU1N6dm1uSUE1R2l4dERK?=
 =?utf-8?B?TlByUTV1TzIveHNyTXd0SjhGQVJTbEk1Unc4L2NmWlRQWlcxTFZMRFlkRGxx?=
 =?utf-8?B?L3ovK2xzNHN3ejZJcUFpTnplTjdjQ1hNUzIvQ0dUOXIwZ0xYYmg4NkpsWVEv?=
 =?utf-8?B?K3VtR0k0RHFjb0xPdldwTk95OGVpLzNmV3lwbUphaHFwZG1sWSt5U1lXSmNi?=
 =?utf-8?B?ZW9SeG1hZ0krOEZrVi9vUFJTZEc5N0FIUC91ZGRsWGoycVJtVDZPeld4am94?=
 =?utf-8?B?VmVDbVdOaytvZWF6OWJJN0p5SnRoRXZJbUJQQmhReHVTYVNZVHBvYnE5Q2p5?=
 =?utf-8?B?RlRJUGwzVW04NkluVnlPZmVUczRZSldvNFdVd2ZRMjc4ejhBbXlaZzZmMjMx?=
 =?utf-8?B?L2dtbXBSTXVXellqOEZTSXczblNhSVlvL2hDL1V4OE9WZS9iamQ1aGVEODhH?=
 =?utf-8?B?NFpnVVgrVFhtdGlzUzQvU2xpRnBKNWR0TFJ0bkN2UFovOFUrSTB4OHFza3Jq?=
 =?utf-8?B?SU9reGVoNDdlWnBORGNMdG16RFg1RGo1NnVsQVY3dTdCc3EvM0tsSHZyWm43?=
 =?utf-8?Q?A2vZb/Vi10qF4lou9dm6PB74pXd341JUqp/zfvO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0ddac2-9c05-46ba-b949-08d9835c6d71
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 15:18:45.1650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+Hvd8rs8o9NAyEn+R2LmgSQntD2NQNGroZM6bQW+oZcmLUWg78dH0eA7ho/fKV3oCtV88omPsThjIZ7zHmxbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5258
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

Am 2021-09-29 um 4:19 a.m. schrieb Lang Yu:
> Memory is allocated for ttm->sg by kmalloc in kfd_mem_dmamap_userptr,
> but isn't freed by kfree in kfd_mem_dmaunmap_userptr. Free it!
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>

Please add

Fixes: 264fb4d332f5 ("drm/amdgpu: Add multi-GPU DMA mapping helpers")

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 2d6b2d77b738..054c1a224def 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -563,6 +563,7 @@ kfd_mem_dmaunmap_userptr(struct kgd_mem *mem,
>  
>  	dma_unmap_sgtable(adev->dev, ttm->sg, direction, 0);
>  	sg_free_table(ttm->sg);
> +	kfree(ttm->sg);
>  	ttm->sg = NULL;
>  }
>  
