Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BD0C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 13:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F167206D5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 13:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PWfB1IBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F167206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC7576E0C9;
	Tue, 10 Dec 2019 13:00:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE1A6E0C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 13:00:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfPTw5p6XzIzL6nUuV/Q8PyHxbTtIKyD8AEBnxlEZDbuIiCk6wMV6WTqqzDzi44eew1f2rmR7QsLPQ2Pi9v7VHlTONb0FN7LrwQcgGhNZQ7Kzbl71lddRiWzn0Wrczw60njp1l5+cRu3b0SuYj9cyR8sVDgh7RB0RKqPwApoQzA8gSIXtvA1Vpdsro9pAtyS+qyFy8GDn/rcTOylrBHT33/wEIiOuu2+fliP6QHR/OOIrjKLutwvAg2XzOjZr5NGGyFGJmoV+0jhHDUUUb5tVR/TlqJufzg6TyPox0zc8H3kPXw3Xtp9WsAZseIQmEZFw6Htv0iB1udc9YC+LzAhxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHuyXVmuqpGIea9xeG9YN8lnaHoBUp+UNTI4HEEFH+k=;
 b=JYbvL1uyRGpEFWvsLdpRi6iG/sRnZsTeyOot8e/Iaz5vcvnVDLyeOxzPw0ov+1ltnP8KRzHCtxBBDQxN5Jkp1Nvpd6ncY7KrElvaDkEtlKpT6aMJQiCvdmXSD1UX4PKEsatMy2tGTk5FHriccWweP0uNzHmIlXUfv5ouIItPtB5uXRyciPsqlbyfw4iNPPd9TbSVeRc8PxYCPQOgVdiYAoPJ42p2UhT4CZRouWUc3K7UUU7Lo2InLunHWh3iEyy+e5E9/w97kcmzBKGSNfne6sDvtc5TTScw+K5h7ue2UeXkvrxXuFGSbDYHh/N83AEaBfaHoNVKXPAs1Q/aYgmwlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHuyXVmuqpGIea9xeG9YN8lnaHoBUp+UNTI4HEEFH+k=;
 b=PWfB1IBt30r+DGfh4CQ+Nd4JHvp4/aQ0EGCqXR9oWSJvUzxM7JrtnNE4BUzCDMWcN/On8OWHHPDjHxa54qC4qfQHsQXqv8zaTc2SWuXnryucM7xg25OFZE/+CMw79VWA3jPacJSR0zpCwar+VE7cu8rUpB1rFoxHi+KEXtNjE6o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2407.namprd12.prod.outlook.com (52.132.141.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Tue, 10 Dec 2019 13:00:55 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 13:00:54 +0000
Subject: Re: [PATCH 4/4] drm/scheduler: do not keep a copy of sched list
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, alexander.deucher@amd.com,
 kenny.ho@amd.com
References: <20191210125300.3800-1-nirmoy.das@amd.com>
 <20191210125300.3800-4-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <800c29bf-11dd-0ac9-32ad-ef3476f07643@amd.com>
Date: Tue, 10 Dec 2019 14:00:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191210125300.3800-4-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0119.eurprd07.prod.outlook.com
 (2603:10a6:207:7::29) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 03515dd1-b7e0-45bc-bb3e-08d77d70fe05
X-MS-TrafficTypeDiagnostic: DM5PR12MB2407:|DM5PR12MB2407:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24076A3B9171E4D5F58AF678835B0@DM5PR12MB2407.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 02475B2A01
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(199004)(189003)(81166006)(6666004)(81156014)(66476007)(66946007)(66556008)(8676002)(5660300002)(6512007)(4326008)(31696002)(8936002)(52116002)(86362001)(6486002)(31686004)(2616005)(36756003)(6506007)(478600001)(2906002)(316002)(6636002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2407;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ojdvlGLy8p8ULtYLhRkZIqaouoVxXWefjmmKxh5zsP00mkQYD3HMwMnatoktpPA8Gi7ge7ifN60ZXFcCPJ2NqFCINZsSes+lYfqRcof06LjUCMXeXZojIIGDZhTVEOhKTLS761mZZLE/t4Szoub38R2DdZad22OX8jSNlopHEVTsKj93jpvr/ynJebmoe5BSOGCP3YRK5ffRrhzctCWsz1zXfjZqFzYoOsRouoKMb5bGT9oDVm2rsoIr1zQvJyWYBxAGLc/CI8oBGvW7WZX2yHHJOliph00icN5tuLq7p67qh+WDTOlI0RZDp9xEE43/VTE8mM6166PwXXzcGK6FSv7YJKVgrkz7rdgI/LKdexyN+tBtw8E+pVXu0ncmUCiTjkkDVlhVmno1tqDOxg2TQAJuKKe7hY4/Y1YghNG60C4ewwR+ZOtKsoeTpQpV00Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03515dd1-b7e0-45bc-bb3e-08d77d70fe05
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 13:00:54.9771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8soZsbcoqMZBUDM0ec7//ARdCgIzc0dyM6CcZ0SvGPDiVOEdWvc3AZHcqR9A/Rw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2407
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
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.12.19 um 13:53 schrieb Nirmoy Das:
> entity should not keep copy and maintain sched list for
> itself.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index f9b6ce29c58f..a5f729f421f8 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -67,17 +67,10 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
>   	entity->guilty = guilty;
>   	entity->num_sched_list = num_sched_list;
>   	entity->priority = priority;
> -	entity->sched_list =  kcalloc(num_sched_list,
> -				      sizeof(struct drm_gpu_scheduler *), GFP_KERNEL);
> +	entity->sched_list =  sched_list;

Maybe make this "num_sched_list > 1 ? sched_list : NULL" to avoid 
accidentally dereferencing a stale pointer to the stack.

>   
> -	if(!entity->sched_list)
> -		return -ENOMEM;
>   
>   	init_completion(&entity->entity_idle);
> -
> -	for (i = 0; i < num_sched_list; i++)
> -		entity->sched_list[i] = sched_list[i];
> -
>   	if (num_sched_list)

That check can actually be dropped as well. We return -EINVAL when the 
num_sched_list is zero.

Regards,
Christian.

>   		entity->rq = &entity->sched_list[0]->sched_rq[entity->priority];
>   
> @@ -312,7 +305,6 @@ void drm_sched_entity_fini(struct drm_sched_entity *entity)
>   
>   	dma_fence_put(entity->last_scheduled);
>   	entity->last_scheduled = NULL;
> -	kfree(entity->sched_list);
>   }
>   EXPORT_SYMBOL(drm_sched_entity_fini);
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
