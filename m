Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F90C3F2CE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 20:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23E7921556
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 20:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aasLa3bU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E7921556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C94EE6EB63;
	Wed,  4 Mar 2020 20:03:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEB2E6E0F6
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 20:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJ9uVxLXm8PGOk0r1FcTACAEE0jwaEotBTmM5J2Ul3ikTHGiVN+s/ow4KaoXjk+pqo1XNW3/I3qHPtBaqQ44fWTRPkXEiDt6veLbg9YjiwaccUSeMRdVLf+hG6dyGF3aw6qunkr+LI/sg5BkGDTFZVBTdT3+npqqEsM6e+2enWSNFACFZNOoPdbEUCXJYIzIbl6WD6V+0KuDzKVodYmNPJrnGknHVmi7zZjSrD7F08O2wI3nnzwFFqtBJm2uw+i+1MU2ak7od4GcO9YPaWaO5i+0k0c+FmLWepNwkMAbu8ZNbs6Be2yqLaVWv/5Lfq5wAIa9QZctPFzpwEv7dZHfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7HznSkhXniW9d/drwTKUe5I7gNrf7dK2knN88kSuKA=;
 b=fTbF6bkuJEAxtdVExwUgZnfFZoejb3KPFedpHWDzA65z24ctV+EYZCk7g6ALu4NG4e42DgFIX3LnZLH2IzPLyU7r6eZvVBQ8mm8ypb5d4BfnXEh8M0jWL7op83Ch0RvQbG8/lbD4PZX3jtVg+j4xksr1h0Gv08gsQhqcXDtX9DsXUgDNUGJTm8QtgU8j2J/YTMKYq8ZfcqaYIxVSwNqqm7dryOm8amJ2jpVRI/yr5305VGp1ZPVG1COjEK0B6pjqNlUuKNJzE7B/KQIMHgBJEO6Vk+t5zoxStjMsdZmHEccS9PbhxeP9JFvu1Sv42GuUlSEY+EsBWVKgfBzrGhcDJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7HznSkhXniW9d/drwTKUe5I7gNrf7dK2knN88kSuKA=;
 b=aasLa3bU3J3HPLbUsThajKe3XCYw/nxRbUXPJ2xl523gIYXxgJHO6YL7IUdNIqUt1xTLYt/ZIilCtUNfeE2XUlXOwdj5+8u1DrT5efycWAU1lLHwneBvRWrrwKalWpYP/iLVZMTKcQcI33x5XWUS7SuqqeKpLik7NoGRVTQ6lKw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Philip.Yang@amd.com; 
Received: from MN2PR12MB4030.namprd12.prod.outlook.com (2603:10b6:208:159::25)
 by MN2PR12MB3166.namprd12.prod.outlook.com (2603:10b6:208:106::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Wed, 4 Mar
 2020 20:03:54 +0000
Received: from MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::dcae:63d1:58e3:4c4]) by MN2PR12MB4030.namprd12.prod.outlook.com
 ([fe80::dcae:63d1:58e3:4c4%6]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 20:03:54 +0000
Subject: Re: [PATCH] drm/amdkfd: Add more comments on GFX9 user CP queue MQD
 workaround
To: Yong Zhao <Yong.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200304194051.9189-1-Yong.Zhao@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <1fcb7a55-474e-208f-4523-11d52219aa0d@amd.com>
Date: Wed, 4 Mar 2020 15:03:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200304194051.9189-1-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::27) To MN2PR12MB4030.namprd12.prod.outlook.com
 (2603:10b6:208:159::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Wed, 4 Mar 2020 20:03:53 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 17781046-da8e-410b-9431-08d7c0772a2c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3166:|MN2PR12MB3166:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3166823371BBCCB7EF8514C3E6E50@MN2PR12MB3166.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(199004)(189003)(53546011)(52116002)(316002)(16576012)(31696002)(36756003)(81156014)(8936002)(81166006)(8676002)(2616005)(66476007)(6486002)(5660300002)(66556008)(66946007)(956004)(478600001)(31686004)(26005)(2906002)(16526019)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3166;
 H:MN2PR12MB4030.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xBmYq2gjTcPvQ+rN8181SiwgirNxvtpT6H9t4M6FVxWMlHIE1S76wfEf8x0CFbfbqFiUJUZ3CGqGe31UfIb9Tj9k9Uou0jPJ1luZq9B8zoaN3qYcGA+IzT9wGSGiE+eoqlmtjWrpNnCwuc6aL7KMajyZv7WPk1uFjRAxaKWmzdRSDN37sB+RO2lmHrZ+6rxUXEHX5uf+4OdEHN5V964j8IUroX0iseRYPKGrYvJ9rBESWHvoPbC/gW3CDAG62KpAwNoYgZpkKAOy0cSk1TG2OPOODx3e58TlEDyTVf6+vcIR2FMY1Ov1oKGWWsVmeYVHVFocQGu//cXN6OZF40rKLafUSYTqKZEGLe4dGhM9RvAnq+mcyf7qv5zgNq4bcoKpzAfY2SsTXLBrcTnhoykgSBSoK5cPyXOUGCAAFlqN8/2f6+wuLqrxiZlawGmKhNOo
X-MS-Exchange-AntiSpam-MessageData: g6rd3I4ftf7ujpC9Qf1AkWwVxL/vxm9E98JEIh7gR70A/4Wr2dH+7Y78e7+7EGtc+DnF3piMuMFKoLuXzACTXmsSdkwn5zNVjcKM63+ntIyasI5n83dpZju86YPBwOECluUlPlYjOtxf4VEXtoZh+Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17781046-da8e-410b-9431-08d7c0772a2c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 20:03:53.9768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XcMGgfbIAfSlg/KI0G96xp6aaW9M2FQ2rocNePY5/LUBhtHTnTDe7U4S/APOvbE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3166
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Philip Yang <philip.yang@amd.com>

On 2020-03-04 2:40 p.m., Yong Zhao wrote:
> Because too many things are involved in this workaround, we need more
> comments to avoid pitfalls.
> 
> Change-Id: I5d7917296dd5f5edb45921118cf8e7d778d40de1
> Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c        |  5 ++++-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    | 18 +++++++++++++++---
>   2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 1947a326de57..10f6f4b21b44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1041,7 +1041,10 @@ int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>   		if (r)
>   			goto gart_bind_fail;
>   
> -		/* Patch mtype of the second part BO */
> +		/* The memory type of the first page defaults to UC. Now
> +		 * modify the memory type to NC from the second page of
> +		 * the BO onward.
> +		 */
>   		flags &= ~AMDGPU_PTE_MTYPE_VG10_MASK;
>   		flags |= AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 436b7f518979..5b11190ff6e6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -87,9 +87,21 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_dev *kfd,
>   	int retval;
>   	struct kfd_mem_obj *mqd_mem_obj = NULL;
>   
> -	/* From V9,  for CWSR, the control stack is located on the next page
> -	 * boundary after the mqd, we will use the gtt allocation function
> -	 * instead of sub-allocation function.
> +	/* For V9 only, due to a HW bug, the control stack of a user mode
> +	 * compute queue needs to be allocated just behind the page boundary
> +	 * of its regular MQD buffer. So we allocate an enlarged MQD buffer:
> +	 * the first page of the buffer serves as the regular MQD buffer
> +	 * purpose and the remaining is for control stack. Although the two
> +	 * parts are in the same buffer object, they need different memory
> +	 * types: MQD part needs UC (uncached) as usual, while control stack
> +	 * needs NC (non coherent), which is different from the UC type which
> +	 * is used when control stack is allocated in user space.
> +	 *
> +	 * Because of all those, we use the gtt allocation function instead
> +	 * of sub-allocation function for this enlarged MQD buffer. Moreover,
> +	 * in order to achieve two memory types in a single buffer object, we
> +	 * pass a special bo flag AMDGPU_GEM_CREATE_MQD_GFX9 to instruct
> +	 * amdgpu memory functions to do so.
>   	 */
>   	if (kfd->cwsr_enabled && (q->type == KFD_QUEUE_TYPE_COMPUTE)) {
>   		mqd_mem_obj = kzalloc(sizeof(struct kfd_mem_obj), GFP_KERNEL);
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
