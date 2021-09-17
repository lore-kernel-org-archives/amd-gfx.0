Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5547EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 07:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146C861130
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 07:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 146C861130
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C6686EC06;
	Fri, 17 Sep 2021 07:06:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8E66EC06
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 07:06:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwZy0Xr7fqXws6f88/i6ckxRUleJKcpJTjvbeWtfxjlz3KwQCUlySrhNS4ABEzmzh+5gkR9C022L6UL9MpyWEGdzCsdYbRsz0F0dVbsYeSCRXDAa9TgTt/r2wrSP16AVEvRlCk1uZbTVNrLJXL8qGonelaUQ+G6q+E5lX1GwCvhoRybEY8VLHGXs+u5qLIjyGGq5IqKUSVKvlbRizhKVy3TyL1hvVkPcxmaBSKAAMOQ99tlLUe/uQP7mODLltBnYclOdqS5B92gaV9lOrC/IlxvnETTbw7LLvwEPi7LzRbMU7zPv9FNNXw1DysB2jQ/BilQGbVOHBgZT/KeH+t+h+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=6EwcoddUhXeekx/LASZYIJJoaJR7ZFZCfbGndgJaFMM=;
 b=ef2fTKByI+0nVTb6EQrX8DFz1C26xzgHKxxSlp0wLn2i0jOqFjWhK4kNJ83lzS/rhv+Hq5I3wROhOZSjkVMr8z6vxTJCs4bcnlllSrBhX93j170RuWL+3phs6ZT8DhtdXc1MuA7Cedtf3aTB96jVtsnHsMpYyJXs19gvdQerfwCH9djePPU2PYhwByVKp8fF3SJljNIqT9sFiK33yi0nYavOISreVW/wXHQD33Yl5R0e2mY6V+nY0MvI93zINbaHLJVJCBS+MeSaxHa4WON8MFSHwKOYXG/ixkO7vZl28CQn5GMfI7QVy7rVVHbiecaMgx1auzf2GInNh3afN2XImg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EwcoddUhXeekx/LASZYIJJoaJR7ZFZCfbGndgJaFMM=;
 b=KgnalRhrAb2Ws5cDUq1qOop6D6PCatXGGJNR7nDaj2ZuBMxLN5CDMt3by1kVRkDt0CH6YXCcCFtA/UUcQicYjYluA4buRGMVxFqeM+C+wRG8KfEYmh2613fw5+/zk+hWMuEBtVtEjAYB89Zeewl9jmKwTH58zEYXDi+qH5zSj2Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2546.namprd12.prod.outlook.com (2603:10b6:207:3f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 07:06:22 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 07:06:22 +0000
Subject: Re: [PATCH] drm/amdgpu: Let BO created in its allowed_domain
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20210917070444.4867-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <59a231be-f623-196e-e547-8d5c75d0f314@amd.com>
Date: Fri, 17 Sep 2021 09:06:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210917070444.4867-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::24)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 FRYP281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.6 via Frontend Transport; Fri, 17 Sep 2021 07:06:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa38f151-c06e-42f5-fbcf-08d979a9a785
X-MS-TrafficTypeDiagnostic: BL0PR12MB2546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB25469038588E50529EDD632383DD9@BL0PR12MB2546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mg86fcJSq3+sTUbZTlC/9K6vRVz9/Z/BdAayojU5gudpTFcIGk6JYe8iTphacvx80iPZlLFpCciDBZF+nIozIFvnQLoSLh4hmJlBGUUSyZ8jjJ6a++QwWiEHWrYOlnimCf+6uGeoMKSqn8Tkf9N/bZ7Qzugyj52PeQZw3GbBHwKbFHjA95EJG2kUteTl1HPPQrIkRyK12vvkbxqK39ANKLtUXDLnlAuJeJueLOpcOk2cq5DRdWb8UQmT/nigh92ESa/PrNB9KCjLjrxz/smYcMYPKb7apufIN1FfSRObGqDZ6UcLqu92p6xtQF9QHJDTDDsCQP2vg4mCFmo6cvlVlpOga05eEJjPwk4FpLvq9rZbwbsUpDhWBZOp3sARiqNa24pmOQEvN1dSxTm0WF/D6rfp8EV2PUtUij9QBY+pPhfM4a5F7dvKRGobEwNBGKms9I5PFve51gXQS+InMcbmmwyGErTodFt14n26kB5DiSqaFqwzdvR40ZuuDELXWa9cnRFdSnGNxM8XpNeIENAQGy9H6ojNlyaC679m+gkSCEchqAxo89F792NXB8XIXkMHRx4/4GwAWkXEcs/fesCqJahwryUtpBgWiN//OOPqz19DU00/r/8xLw+dD2D8YtgnbjIgeXv7qHsp+33Ehr5m61mscLLUdaXF5zKOAkJT5iNUlSteh1SHGiHb6W3C7bPLbmI5X+UghbPx+JJv9zJG004QLCjqn5xXNOPAYuFegnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(478600001)(6486002)(66476007)(66556008)(31696002)(2906002)(86362001)(26005)(83380400001)(4326008)(36756003)(316002)(2616005)(16576012)(956004)(5660300002)(31686004)(186003)(8676002)(38100700002)(6666004)(8936002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmpvYnBCbkl6enpGYSt0U2lEd2h3cS80cXFwOEI1VEgxcDFxa3hJV2JvZlNF?=
 =?utf-8?B?YXJsY1Q4Q25aRTJRYXdvS1RXRnA4T0lOSitSK095M29pblAweWx6RXNqQVJ5?=
 =?utf-8?B?MGNxL01lOGluZUs1ak52NDBFUHZRa0VsQTUxTGdEWFFzSEF1bkN1L1dOQjI1?=
 =?utf-8?B?OWVwbjgvQnZ2TmJSM3lPdmFqbDBuN3BkUHlvNWRYM01nUE5BaWJIS0ZtNzMw?=
 =?utf-8?B?SHpkcHZUNFkrNkVFQ2U5aFpwRW4wdzhBRkVOcTRCM0sraExoQThobndIOGZS?=
 =?utf-8?B?ZWZ5U0tKSTVkUG1WYVVIWTU4QVQ4emhwY3FFRDhOalh3R3p1Mjg5Nm1uZndU?=
 =?utf-8?B?eHBmYzVqSUZCNmRBNkloUERuUXhyS2UrZWpDOHcxVkdZa0RGck9yZXMvRmtF?=
 =?utf-8?B?bDl6LzBHNUdteDIyZHpTTEQrbmFrekpaYXRiV3BiVlZKKy9jQ080aW1vR0U0?=
 =?utf-8?B?R2o5Nmh0c1QvdFdnVDUyRXQrdUptekFsbFhxWnZzU3NNSnNycmo3Q1orZGZT?=
 =?utf-8?B?SGV6bXltbC9GcndnNTQ1ZTZNK2R6Zm5VeFZkSDRYM1ZxaytwV1p2U2IxenZH?=
 =?utf-8?B?N2t1QnE1MjFLUUtUcnllRWx2aFN5Qm5DeEJwS3ZONW5iTjZZRWlzaW9CSXRW?=
 =?utf-8?B?cWJ0ZGNGY05ITDkwRGJyK3dYY3R6WFV3SG5ud1N0ZldYeTFuTFpuSEZFcis0?=
 =?utf-8?B?dVNkYitENWkyeGpjN2pJM24vN2E2NXRMREpOd1EzVHl4dGpkN0hQQVdEV1hV?=
 =?utf-8?B?aW9UZzdpMFVTU3JscFJSMTA0UERkVHFVdk9kTTJFa3NTVGpLUGhDR2NENUI0?=
 =?utf-8?B?b2VydnhERjNZbWxwcXpnWkNOc3ZhSFBUZ1YremdTOEhiNnc4RTh3WnJ2Tk1r?=
 =?utf-8?B?Wm41Z21JcGhuZ0hKbHZoMU1wZ3VaYXRHakh5ZlBwcldtVmpmcGtseGIzMGtt?=
 =?utf-8?B?UmVZbHR2d3RBWC9kSnpBTzMvcXpCYklsUzJkNkRCRmx6cXR3NUNmVEdST243?=
 =?utf-8?B?a1hOdS83NFQ1QU5aY0RVNkpEQ1U0SjNlVVFvMEhaWCtNQ1NVTHE0OTcxbXcz?=
 =?utf-8?B?aXdQMnpLZ2pRNklBL0ExZXAxWlhPNlFjdDlkN1RjWVhFUDJFeXlod1lIbVpM?=
 =?utf-8?B?M1N2dVRMRy8zQXdKd2RHSjlOMk9TYWJnd2RvYzZRMklJaXBZOHJiRDIxZnh4?=
 =?utf-8?B?TzVGdURjRHZZSGNFMFdRZzA4ZGVXbTZER2JuU21jZUtBQUhSVnVVb1NqeG5o?=
 =?utf-8?B?bjhnS3llZnVXYXVJNkZZd09RdVhlV1FOQjNwSGg3a3JIaEZROUFrSlhBdjZY?=
 =?utf-8?B?cVVIalVlZTJ3c2lRNnk1ejJjdHQ5RTdzR2U4dzJQd0l1NXkzYm81WHVQQ0NB?=
 =?utf-8?B?Q1N5MDJuVWhubk11ZjBNenlBL0RyRTVQK0k2dW9KTTdIcEtwdTNxR08wdFFO?=
 =?utf-8?B?TnlIRXU4RTBqUjBIN29LdFl2OHU2bU14ZWF2N2hHYWJ1R0lraWxVbmxsazZQ?=
 =?utf-8?B?OTR4Z3UyaE5ZeUE0RkplZW1jQUY3anE4VXMwWm9HcCtkZDcxZllGSW4xOTlU?=
 =?utf-8?B?NzJMYk1aNVo2NE92ZlQ2OTFPRE5iMWdaZ2FIZWVyNlh4UW1zbnRHejFHbS9S?=
 =?utf-8?B?MEJ0Z2hIZWVVQ0tuNjduUjkyOHlWcmgrTFRBTnR2M2JiMnphemJEelhHbmwz?=
 =?utf-8?B?bDRRZ0RMdlVIc1JMYmp6WU5QTVgzcThtOUZiaVRWNjRSTkg3Y1RZZk9PWHNV?=
 =?utf-8?Q?97J28yDclN+1GR5G8zA+/X3eZ8HdS9Ztp+l4SQE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa38f151-c06e-42f5-fbcf-08d979a9a785
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 07:06:21.8634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NS5sBwzAnGmRA7PbfJw/nhScQOSyObmN1/eUvGsLY8mL0rtx7GyGFH56dxo8qXv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2546
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

Am 17.09.21 um 09:04 schrieb xinhui pan:
> For any user BO, it is allowed to alloc memory in both GTT and VRAM
> domain. That means one VRAM BO could be eviced to GTT.
>
> Now if device is already lack of VRAM, this BO could alloc memory from
> GTT directly without evicting other VRAM BO. In this way we can reduce
> memory evictions.

NAK, that is intentional pressure on VRAM during allocation of new memory.

Christian.

>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 66bb8a53bb20..9a547bb38cda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -579,7 +579,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   			  AMDGPU_GEM_DOMAIN_GDS))
>   		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
>   	else
> -		amdgpu_bo_placement_from_domain(bo, bp->domain);
> +		amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
>   	if (bp->type == ttm_bo_type_kernel)
>   		bo->tbo.priority = 1;
>   

