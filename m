Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F2AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 23:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63FEB6E544;
	Fri, 19 Nov 2021 23:22:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7792C6E544
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 23:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6bH2AP7eY2iCnU2pZqxWkHdhVkPyyXa2yE1fYolBbOkJbPOn3OzlZF2TRIcHu72WM7X5V2zSRhc5hjWSPZ+rYOcegf3GEVSAHSLc9eR/+iQG4n9oAO3Wh9MwHi2Y7Sfo2DXKt4iULV3K9+DKS+eiDa3GFRzirH10NCmZzXLBOijjAnoNILGeuoqy+hhlWTQGcBRqhZucZEne+9+gGL4CQ3BQlHZ+Fw7uzbV/KUarOYp9ZSObL7IVhMpHHu4ct0VEUQTdzS7LCJ3EJOM6SFPOJE+nW5YoMjpN/XWrfvItWzOyQG28gRRsZ017xdzhIZbwe67tHrFq49f9mrAuUV7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXN+Wn9V76wwhQx1kvWFIbIXAoWMx/b67zFlsMphnXU=;
 b=Y0Pvh3H/XZ2r+EGV+bqE3b8kCwvHjRPiKyWP6/Q7tWwmohfK2vCBE//pr3fWRXi7yAWQ2W3/u7MR+j6d9ccZJnX9jyz7VRmNOrpQwpIf3yUfWz+ZIDnUvWeuWkhMumIjVrMYBOnm2gUcSWwb/ilDlUqKBUIJvI00ExvDloNwUKNevmfjUf8z2GPsVMnkqoxpK3BW0HTHHBuyy1Fh7HUwGp95gmUuKdbZ9xOriRfP0Il0QLRfBYcJMv4Rvkt6BGINsjBrqN/L3IIM0O2JcEYgO+9f7bYfgwzJDn7ZUFKxyiudS5zg1ES9O1DFI64vmt5Ad4DVYD6JKvzZbJU31r/zDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXN+Wn9V76wwhQx1kvWFIbIXAoWMx/b67zFlsMphnXU=;
 b=4L//Gt/mexvD+msnZWpjlFI2X6XR2iBaQnm5AUZyQWf+l4m2WxggcEvmUtIZbTkfyLqAtLMXvpLeOmoWgavndlWX++Ojlqa+/8inl32GNrypeOMqb0LIftpPCqu/tHLonWEAgJj1Tq9ZeUjmdYzsJIuVXQo2ByefejqSGUBaWA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5241.namprd12.prod.outlook.com (2603:10b6:408:11e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Fri, 19 Nov
 2021 23:22:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 23:22:25 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix double free of dmabuf
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211119101725.66619-1-xinhui.pan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <37c9343b-6865-b63d-c674-b8ad602bd44d@amd.com>
Date: Fri, 19 Nov 2021 18:22:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211119101725.66619-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BL0PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:207:3c::47) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 BL0PR02CA0034.namprd02.prod.outlook.com (2603:10b6:207:3c::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26 via Frontend Transport; Fri, 19 Nov 2021 23:22:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a08d6f3-47c5-4058-3ff0-08d9abb37254
X-MS-TrafficTypeDiagnostic: BN9PR12MB5241:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5241F2DA46D10B0327FB695A929C9@BN9PR12MB5241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nj3a9uybSPH4Opq7wsGenwBGH4f0M6OKW3y3d1EKRGcO2/rDvoVGGNSFhTeXhpNMLcy1kxJ5ZHLkbg15R0En3JI+AcIxx/bptvofiKXYsLszmCI2VPldvtuGnhBg5BO8V4JDTnllJYnag9DtG8oOAXkHYsa/F5cUE8mXt/p+6F7izMIKVEWVw6onlXWpzmnq+qWpBl9m1dD3kZ22n6v8MXLGKPeE+K/4RF1jYhQOF8p3yB+/QJSExkRdJakdUiKWGHg9Ws5MNB8v3U1dydnlwTlbpM/lOj9dvei86qJYc33DHP7LcGzvVrvTsc7I9MrN8T+YYzYrhXIJZNr/hYacmiQ+Vco++pTKuQnTx1VdLuznY3lwEL59M1DHTIZaGXLB4tl5+oKuaAUYMWBrDzBwK6nnMHbCoReSjExiuREvGlnNDwqmdpWXswEYZfCe0NI5OXEQhxOz+GSZtBp4gA+Y3nUBXEmqCpN8enhsQFC/2BrXzVlRzPaRGTPxJvEcS3gKGyBl8mDLOytkdaBw7OJ9H2zrbOU78AOR8rf264Fb5mR0NIPfZ0beVZ/JAmLyomEmTvkquqO0YXifgq8lomZGlwoAfXacmssupv75loW5ZmiEEkytnuBfvPYMGEAz5G7kvjCZhjSJMASSiHsj5I+Xw7PIiQmxhoRNj2L5Afxjb3i66f+Ng9/dELysYZkLkdeky4ouM5UGFky7FTfFbEudeJBSqlNa6q2k9bme9LCvVV/MpxwgcHZ04AU0JJBZqbRk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4001150100001)(8936002)(83380400001)(4326008)(6486002)(186003)(2906002)(66946007)(956004)(5660300002)(316002)(508600001)(31686004)(2616005)(66476007)(36756003)(53546011)(38100700002)(44832011)(31696002)(66556008)(36916002)(16576012)(86362001)(26005)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUwxcXZ2b1RhY21WT2hMN29DSm5VK1lCQW82SUJmVUFCRnExNy9rYWhsTUdm?=
 =?utf-8?B?MnFwTCtJbWJRdDk2dVZtT1JxQlkxZUNDQS80cVZKeGErZGxFaE1sd25SSUxy?=
 =?utf-8?B?aUFrb1VIZ3A0NzBybGtZVmR2dVYwK3N3dkNlT3diUEMvekludVgrVWx1Y2Mz?=
 =?utf-8?B?YWQ5YnU2WUQyaWxrQW9GN3pGNzh5MjVTeEVKcmwvN1YvOUtHQWtIMmtLendh?=
 =?utf-8?B?d0VyQUZlMFhCSVRkSW1RVFhKRWJVNmwvdzEvUG5aS2xGRDhVREhKY3FzdkN4?=
 =?utf-8?B?cnB2REtaWHFOK2ZuQkluU3JIc3Exb1VNT3pueDlDOXpRT3ByTkRjU1I4MUVY?=
 =?utf-8?B?bFN5aVVUMXpiSFZaVnJVOExobW1HSmlITTlNdGpsQ0plLzZWZVdHSm5jSEpK?=
 =?utf-8?B?K1J6LzNoNjVtbW42T29KajJhYUNiVWtmaFlzajhKVm1PK0ZsWTYvSkkxRUtz?=
 =?utf-8?B?bFRibDJXZml6ZWpZd0IxTlZFR0xtTjVYSW95OFQyQWkyUk8zS3ZjUjdGU1Ar?=
 =?utf-8?B?U05QSHBxWnR4Z1VNTHE1YzQ0aWJIVHVtWTdHcEVhUzlhVzc1S1IyWkQ1c2M3?=
 =?utf-8?B?WE1DT1U4ZUhmb2VZTSt6YjZ4OHNGZSt2ZUxiU3hHcTc3SUtZRXgrdk03aTV2?=
 =?utf-8?B?b1hxMWhkbUJTa0syR0NTNzFTaGE2MHRuZU1aVmhRaHFLU05OQWh5V1hxM0tO?=
 =?utf-8?B?b2t0L29sWjhHazZLc012RTcrMXJKUXROVGlQZUZZMVFOT0x3cUN6UHlyU1Fx?=
 =?utf-8?B?MHM0Y0NkdVo2Y2tNQkdDZUZzWFQwUXE1QjNTWWZtZ3Ewa3RmNnhoWHkxNVNW?=
 =?utf-8?B?V1A0a09HWnJXZzlKclBMZ1RZNTVsRDE3Tk8xTGppUGtOeG4yVkdkWjZOSG8x?=
 =?utf-8?B?SXpVcHdOS3d2aG5XRnE3VlJTLytCTWd0WXlHUGE1Yy9pcWJKQXRyQlJlbFQw?=
 =?utf-8?B?ekZpNmZ2MkFmWllBUzVXOHhJQ1ErY1lyelBLemdqVnR0MTZMcUdtUkJKcDVW?=
 =?utf-8?B?OXUyK0JjWGViWWlQdHoyaktnelNJMlZIN3NEeXp0UlJPREh4b0M5d21oZlhG?=
 =?utf-8?B?STh3dCtzOC94QlBjTTZRaWMxN0xFaFY0d1RKQ01SL2xNaW5EMHAxa3p5aUdX?=
 =?utf-8?B?TEsxb0NUZHVXNGY3OVBsZnJDT0RoYXlHanQ5T2lnYnd3QUx2dUVYai9tMTRk?=
 =?utf-8?B?ZnpXTlJ3Z0tBSW9sZjBXdUYwdFVVY0hrRy9wczY5UFVpWEliNXUxSThjbnRJ?=
 =?utf-8?B?ak5Ra1hYb1UrNG01Zkt1eFppb0Y1eHlESWhlRTQ4SU5sWVRDWjU4K216Z0l5?=
 =?utf-8?B?MGZwOUgxMG5IUkNzVjNvcW14bnZQWDhDblZ6SEZhcVBHckJHRStJdjJub3dt?=
 =?utf-8?B?cklVeCt5bG5rMHMrMDRWZmhPMTlXN1p2RVpYQXdlWWVJbnNNRUhmRmMxY3Mr?=
 =?utf-8?B?U1h1R3VWZXF4ZmVEaFVDbklWWjRsNmRnS0FRMHlzNnV5WWJPeW1ZNVpsYjN0?=
 =?utf-8?B?d2tuVVVXdC83MDlST0hmajFMZnF4SG0wSjFrWlBHQlZCTEdyRy9pL0Qza1RF?=
 =?utf-8?B?bTFlTXBud0NadEEvL0g0YTBZS2ZESW55a0M5dVgwbGs1SlpYNHdFZFg4L25D?=
 =?utf-8?B?WUpkNklhT2dwZWZWOGp5MldaM0NsWHZ1ZGlHN1hXYnlmcEJPMkRXcVJ1WjNC?=
 =?utf-8?B?VU1mRG1iT29hY3FCT3A0VHZPc2lYWVMwSG56cFNadGIzZXdTc3FCWmhYNkdJ?=
 =?utf-8?B?RVhETHpMN0NZaG1OWW5va1JLcllQdzFUdGRZMTdMN2hoU1VxdmYyZ2hldDBM?=
 =?utf-8?B?RHFPSUNnbldNcm9KV0pIQStYU0dOVFB0ZW1pTldaQU1veDZmc01rSEJrR3BE?=
 =?utf-8?B?cHpQYi9rNjFQSDdVdzRiM1VQc29CVFdzVzZkbkFZSDYzTmVTM0toK2hNWUlp?=
 =?utf-8?B?V2l5bmErNWVtMG14cUhpUitqaXNIWlVSTHNYV0Rpek9VQTd0WTBIQ0djTldP?=
 =?utf-8?B?WDE5OVBienlXN21kdU1ibzlaWTF4dHk4N2d6QmxsMmxXVGRyM2czU0haS3RO?=
 =?utf-8?B?dlE2NjZ5K2FKUWlrcFREc3NtRzJpY1VSZ1IzbDhiajJUK0E4SkI2dFNteDhT?=
 =?utf-8?B?SHVUYVhRVEtXakxFa0VlUk0zMTRsdlVNVDNZQ0ZMajZyUFV1WHh6Z0NHcWdV?=
 =?utf-8?Q?x7FQcXoKtRykxc8jI+VugqU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a08d6f3-47c5-4058-3ff0-08d9abb37254
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 23:22:25.6091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8iP1IdBr/xXSBzeVGd0/sIDfC4SUoumPEWZGVEVtefXCuBbHbdWLDSaIalpFgou6sBtfaKbj0KWDIxHJkjTtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5241
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-11-19 5:17 a.m., xinhui pan wrote:
> amdgpu_amdkfd_gpuvm_free_memory_of_gpu drop dmabuf reference increased in
> amdgpu_gem_prime_export.
> amdgpu_bo_destroy drop dmabuf reference increased in
> amdgpu_gem_prime_import.

OK. This was not obvious at all. The get_dma_buf in 
amdgpu_gem_prime_import could use a comment that it's balanced by the 
dma_buf_put in drm_prime_gem_destroy, which gets called from 
amdgpu_bo_destroy for any bo that has a bo->tbo.base.import_attach.

I confirmed the bug and tested the fix by running the following test on 
a 2-GPU system

     HSA_USERPTR_FOR_PAGED_MEM=0 run_kfdtest.sh 
--gtest_filter=KFDMemoryTest.MMBench


>
> So remove this extra dma_buf_put to avoid double free.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>

Tested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 6c6d5d994b5d..0f68d28e002e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -665,12 +665,6 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
>   	if (IS_ERR(gobj))
>   		return PTR_ERR(gobj);
>   
> -	/* Import takes an extra reference on the dmabuf. Drop it now to
> -	 * avoid leaking it. We only need the one reference in
> -	 * kgd_mem->dmabuf.
> -	 */
> -	dma_buf_put(mem->dmabuf);
> -
>   	*bo = gem_to_amdgpu_bo(gobj);
>   	(*bo)->flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
>   	(*bo)->parent = amdgpu_bo_ref(mem->bo);
