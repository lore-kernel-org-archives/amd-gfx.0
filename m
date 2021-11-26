Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4FFC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 23:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9522A6E087;
	Fri, 26 Nov 2021 23:44:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 282EC6E087
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 23:44:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaixx0UbPG+dMHjGqzVWD1nEVOftOpCHJ7otY4PtRj0Y7dv5kTrk+tkSoGKvU7seZBy7cnDIEyKbbVTtHwtbWNacXZB/4ak+YlBklB/XK+oJ0tOKaUUkd2k3HzjXc+HRcUJYUpNCm2z9xtiz0xL7+H0hAriHZuMeLmkj4pIgt4wNYTJ9gnKS1jz5fbJ+rTW0OH8ob5ftjXnXte4kQEsAgxpr57A7sumQq9Xti3AET907Wrdd+aQndQq8Qotr0DFYRnMQttq0xRh3pMFfgugA9sZFTFwsanju8wn0O5Yt5wjpSqYMfq5q0EFwfKbGg92hcvZsDbvz2j679Hs7zy5ItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PRhoPxepOXdw30zFLqU2rZ7wlOOHgzpOXQ+utZxNAo=;
 b=nLHRcmVXQYZaWAiZBeWr+V7OrBI/kixK9ME2wwqnw+mbXvb7nk2XNw/y4Nm5ffesydHC0pvXb2hlXYznccd10Azn6zw65pziGFhyGOlIWPC7xTWKOsd+b+LCN2IL/oqFOvwOLmTPer2Sa/uFYhD+4IlpXzmFTZYUrHv0dDRCSZOUiquJtfw+LaaoN6sJ7VrL/FTB5f5BtWH4Ea4JfV2RMaBc5WQO3l3CXPpgFxz/y+4tfW6TucVMwfSasXXIX/Kzc9ZGUGB8YteDNpS9ucvkVd9kwQyuOS31dib0SYBklllGXhnc7t4RrYgV12CYY2Ms3P6JEs+uebuA2H85UdjFjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PRhoPxepOXdw30zFLqU2rZ7wlOOHgzpOXQ+utZxNAo=;
 b=h0GuWwwTOXZ3g3Y5d1UbIpIe8V06Da99U1A8WqQUHB16xhmT+7iFbDQolJ5lvpprLX28VNxT0K8YKZ99eZmuh2rcBpV6ALaECVCxV0pKIRE4BKx+PXmAdTU0mrPDw2JfotMt3AsWLN/0enQeLgxAhor7JnJ/5Ap00lS4J1qLoW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5066.namprd12.prod.outlook.com (2603:10b6:408:133::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 26 Nov
 2021 23:44:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%9]) with mapi id 15.20.4734.023; Fri, 26 Nov 2021
 23:44:40 +0000
Subject: Re: [PATCH] drm/amdkfd: set "r = 0" explicitly before goto
To: amd-gfx@lists.freedesktop.org, Philip Yang <Philip.Yang@amd.com>
References: <20211126184221.17598-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <a337a973-f682-f9e8-116b-241248bacb7e@amd.com>
Date: Fri, 26 Nov 2021 18:44:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211126184221.17598-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MN2PR17CA0035.namprd17.prod.outlook.com
 (2603:10b6:208:15e::48) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 MN2PR17CA0035.namprd17.prod.outlook.com (2603:10b6:208:15e::48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Fri, 26 Nov 2021 23:44:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6d5bb3a-2e6b-4ab0-3b2d-08d9b136b690
X-MS-TrafficTypeDiagnostic: BN9PR12MB5066:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5066CA83F424015DD3474DF192639@BN9PR12MB5066.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4P+19Pz8Ip/wJ0tkyXI8bljI3E+KRibFYoztTLWNY1LZ3CuaQl/sbGQWfSv8TpHUCP0SV625FZog6xDUNAieWN9q3NF/AE7icE3aPhnqqcUMPUfOdOee+9C5xjU51rBH8ynQ8zxpQBuIpEUjXiOiq4Bh5mI/KmodxtOLpu18CQAmbOjITw1Js1/RbwRJR1kSL2HdM/D1YW166ARn9FwCZv1C+s0N76OQ+1ZosbW8KtFGCFSZAmbd7yo5dMO624b/ryAUnFYVEgkma/I1yB3qp93Nj9rka0KG86tEvSPPqhtn4E6D+iaRzqQEMSyuzpAAbwo8yAia8aZLWVenTB24U1ENxE+MdchQ4Qg+PtzYxzn4OCyup5STz/DrnBzOBsdi7Pu6FBhBMDym5zcVEVA63nlfBCNE7Sd8e6+LpoiLMHGmZeseX7tzQyi2Y1yji9BG7Ek7z/wgibPnCe0sPf6JTQVXDV5i/jfvpIvdZO84oKkW1rkvIOMhNRitz8YDNWRoIA3iwU+6CIdtHKfBxAy75bls6j4ZNzWPuVAQaBW2wGC3Udx1kzbS+6m7ZqewanpoyvDkcfUnyQTOShJncSLuJb9tYdaGVzph0UHhztSDz8JCYnHP2S/QWAyWQeI4zxNnsnzWGo5gcR8knpKs0mPrU4IRHdo5C8orA7zhem88UYbkj9cMMEky7U/e0rNOxaFkLEG/USU5c29pupXncl0wuxRwduvxebJVzh6g23tI8T3TastAL7CeEtaUoGWrIgD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(86362001)(6636002)(36916002)(2616005)(66946007)(8676002)(83380400001)(38100700002)(31686004)(44832011)(36756003)(2906002)(16576012)(37006003)(4326008)(31696002)(316002)(508600001)(8936002)(66556008)(66476007)(53546011)(186003)(26005)(6862004)(956004)(6486002)(4001150100001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGU0RE9nMmVVY1NSblBqZ1VxVUlJd014b1Bsck5tcHlRZFN4R1hORzdPV1lj?=
 =?utf-8?B?aTRrbjB0MlJHcTRiYnluSjFwWWlFVWFHQXBiRi80aTRubzlMU1NoOGg3dUdy?=
 =?utf-8?B?NisxNHpRdzRlb2oyc3RsckxxR09EWjhWYzA3Qm9Yb3R3cGZvOHhEVTA1a2tl?=
 =?utf-8?B?d2t6SC83aWEvUDhtOWFpRXJ2MkZ6Z3dISE5EWnVxTGV1TDdaZHBrdVgva1ZG?=
 =?utf-8?B?TVdQY1pjbmxiblQ1K2hXYlk1RzBWeER6K2FXQ0lRb2JCWGdLdU5KeXhSSTB1?=
 =?utf-8?B?VGQyNHk0VnVJVE9sUU1nOFJDNjNGZ2IwT25uL0huQ3BjZG1RQVBKRzkwL003?=
 =?utf-8?B?TThrZXdGZUVIZEhHY0k3dGJVdzhZSFBIWDd6em0yWmpNVnU5ZGVVazRETVlj?=
 =?utf-8?B?Z2hEMTZ4Y0ZHZmp1S2JrWkF6akFFMUZvdld0ZllUbDRSTmpkQm9JU1RONW1r?=
 =?utf-8?B?NTVnUC93NFF2S2pYNURjVkJScXRhN3J2QThCNnltTG04WTExdVQ4SG1uRUNv?=
 =?utf-8?B?WG1DMUpXcHd1Kzlna3doLzlFdTJnbUFtSU1RQ3NZMDMycWNWczBmWDhDMmxz?=
 =?utf-8?B?TDBlM3FZYlNEZ3IybGlWUVl6WDIxYkE1ZFc5d01nSDZYNjR4L25NRGtIZEY3?=
 =?utf-8?B?V2MwUy9tUC9NYzFka0JTN3Q4eUNJQ3BrMnJQcG1SaHNDczZSeUdLMC9xSHNm?=
 =?utf-8?B?U0JBb20yN2xTZFZpTGs1SEp1ZWRkZG9wOHJMU0VqM0dDMVBuMkpLVTBGbzBr?=
 =?utf-8?B?TTB5bzBEZ2ZOemcyZnc1V0NaN1ZBbHkrb0tKNWYrQ1Bvd25NbGx2bVV0b3Z6?=
 =?utf-8?B?cTZuY1FGR2pQQmd1amUvNW9wRlMyQlN6ZzY1NUcrbGl3QnlmMmlFNmt3eUR0?=
 =?utf-8?B?MHBZZWVJOWovWHVCZmdyTy92L29FTGxmQi9QZkM3TzdQWm1QdGoweGdEdENq?=
 =?utf-8?B?cXJSY1E0UERQaG84TG5iWTFycXRYYUpCbUQ1U01SR3hyaVJsdTkzZ0ZGYXlF?=
 =?utf-8?B?c2NjTjBLZDVpR3BRV0taK0VvdU9TVzl6TzgxeWVhODhlN2JpbXpPNnV5Uzk4?=
 =?utf-8?B?SVU4WlhGcUN1ZFRGM3dHaSsyZEg5cTM3bEVGbjdtTDZPTWxEYnQwZDI0L3Jp?=
 =?utf-8?B?U0p6QVRuSmNWb2dEcnY2a1YyWHFhS1MwNVpZVXFjUzFrWTA2YXk3blpTcTk3?=
 =?utf-8?B?Rjdxb2Z5TEVrWmRPVjcxK0g4VSt5d3lFanE3TEZIWlFPS0VNS0dJaWxHRWtQ?=
 =?utf-8?B?Z0YvVFJvc3ZmNDYxV2hFcWZuMXlnbm5BMmt4MmFGUGtZOWx3ejFSRm9CT2hn?=
 =?utf-8?B?OXZTN2J3ZUxzUzlvR3ROZ3BKSitkRzFETHhDcWo5S1pIUlFscUw1cEliMHZY?=
 =?utf-8?B?dFU0eUFFWUtxV0xwUEVXcG5EZ2U3NWpQWG55RXpVckRGWndUa0dsYlBpRWVZ?=
 =?utf-8?B?NEl6UUQvR3NzNXBOdnBJSXlHUkhxNHBuY3BCZXF3RmJYSkhEZzJhTnpheFJx?=
 =?utf-8?B?R1ZST1BNU1A3Qm8wUW5jSmlkZ1BrYUt6WG1RSEIrMGY4cHI5U2k0L1J6Skt6?=
 =?utf-8?B?bWE2ZTdhUnN0Ny94U1BSbkRkKzkrQktLekQ2K2krazBaSXplOC9oR0NVRzJZ?=
 =?utf-8?B?ZWhaSDczem81dEZwYlVxcnN2V0JDUjBjVElzMEFXSGplUW9ad2lFMGd0bWxX?=
 =?utf-8?B?dWdsRGdFSEd3Qkdua1dMaSt4RmJoQXpSNU80TFduRXl0a1dmOVk0bVJTbUcv?=
 =?utf-8?B?VGN2eng1MUszd1N0OVA1ODFwMFhjM3FEb3FzNEVSa2xiNmU4Y1Fycml6ZVVm?=
 =?utf-8?B?WEM3bElzYVdGYkpSSEJvTkloYTB5VysrcUtMRlYxcXk1aGJmN3J0aWZjL1Nw?=
 =?utf-8?B?TWJ3QXBjdVR0S3ZWQVJ1VGwweXpET3YzbVZWZmFYQTBWYThnZXBSR1BVQlpJ?=
 =?utf-8?B?RmxCaW43T0owbHZ5NnJFMFNkRlhMcDc0Tjk5akVnTkJ2L2Jubi9nd0dSRmQ5?=
 =?utf-8?B?NkNQdnE0VmJJK1I2UWJNQ2pySEdtNmVrQWZIOGFicGpBQWRkQnhmcXlTdHdU?=
 =?utf-8?B?cG1TMUdJNHpyczBIejJ3ZHlLc29aVTNGaXduN3BSTHBLeXlpSk9Pd20zc1B3?=
 =?utf-8?B?NmhhS3RwT28ySkg2Ynhzci90WVZiTWxnamh0WU5PbjZEWWROZDE3bS9veC9p?=
 =?utf-8?Q?pbDmeMopbkMWdgcimc85nQc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d5bb3a-2e6b-4ab0-3b2d-08d9b136b690
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 23:44:40.3133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pl12G5UzTI49LZQI+B2E25qNevYo4sQyn6FQ+A2exnGVMhWeqfVcywrVFIY58qL89yHxFbXoj6SSz++H10ssA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5066
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
Cc: 'Dan Carpenter' <dan.carpenter@oracle.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[+Dan]

On 2021-11-26 1:42 p.m., Philip Yang wrote:

> To silence the following Smatch static checker warning:
>
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:2615
> svm_range_restore_pages()
> 	warn: missing error code here? 'get_task_mm()' failed. 'r' = '0'
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Please credit Dan Carpenter with a Suggested-by tag.

Dan pointed out two more success paths in the same function. I believe 
he meant, those should also set r = 0 explicitly.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 663489ae56d7..a74154c5aa05 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2603,6 +2603,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   
>   	if (atomic_read(&svms->drain_pagefaults)) {
>   		pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
> +		r = 0;
>   		goto out;
>   	}
>   
> @@ -2612,6 +2613,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	mm = get_task_mm(p->lead_thread);
>   	if (!mm) {
>   		pr_debug("svms 0x%p failed to get mm\n", svms);
> +		r = 0;
>   		goto out;
>   	}
>   
