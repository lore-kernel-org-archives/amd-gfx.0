Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F9AC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 07:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E9BB611C2
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 07:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9BB611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE9DE6EB48;
	Fri, 23 Apr 2021 07:57:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DBD36EB48
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 07:57:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUdE9hv9uAgAmjrYFgSbBD7cgcBSZIfIvMd7p7fed8Xun7Or/Ptjs928tgReXPDbDkGm3doV1w8rk/qb1wXI5bzRGxAjyglpSL+ZwNDOlTCqzhi0myJ0wQjwLYskbDBV1ElZbADXDboUvtmr8FwYoJW+837nuf9YKtJBmkc4ujAIHkjI3Dt2+qpc34ZFCxE7swhA8TSAxZSyWKZMtXxOs1vTH9HYY3os+WrOVXMYS3/ysEbZO5Gv99PhQlzWZWky82M8wcSqWjhQiL8g4n1B8pM8T8SGNekvrUK2PxggD0YrCkb54bD2x73wT2+Tj3hMoRjgfy+/ZPt8Ds0N0QPJGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMrS21CeTCldJCRvZwFzVoMDIUieyZQ9N3YC3FQlmH4=;
 b=ByTRD9MxT61ZS+hwQP511zJy3MZtWUe9ucoYxp2SH28SIFY5EKu+/o/EFutMyMFh49QUwC8g8YmSzD1IOQSR2Ky3CrpI4wtzHOpGG8qvWY/LootphwwZEYLLhRQermmCLHjtK6o5rT4h+juDfQLcgiSO5mnvuVskqeFNsWPxdeCmh8luD+e8pTjH+pDgB+LGz1awI3qJuwcPIPEkCgEmCMRwSBwLK3Q1ponviDjW17RsBgKMjLlx1kgAeN9POUBdGWGK19ZTo0xDZxPinOj3SuL79d2QSSHj03n7XQHXsn0hytMYs0fXAtdPL5NkLR4SWltTT/BSvG9H4VabENZAcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMrS21CeTCldJCRvZwFzVoMDIUieyZQ9N3YC3FQlmH4=;
 b=cG2FWb0lpJGYyDxKCHlI3AmUsMNdLjesIRoT4YdRPQ2uJbLJ3/R9RXbYVC0izECbUDImptzKm6SiSGKjBh2wT2HlKtL/Y6CcC+GYP64h7LewoUN/5m6faWIljNK7orN/YeFY4gppzZTlPRiWIrVYwPAippi9Br66EjGTWcDciMA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3901.namprd12.prod.outlook.com (2603:10b6:208:16c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 07:57:19 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4065.022; Fri, 23 Apr 2021
 07:57:19 +0000
Subject: Re: [PATCH 6/6] drm/amdgpu: remove AMDGPU_GEM_CREATE_SHADOW flag
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210422154003.4048-1-nirmoy.das@amd.com>
 <20210422154003.4048-6-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <744d0ad8-21b8-01ee-6a90-b75c89216b34@amd.com>
Date: Fri, 23 Apr 2021 09:57:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210422154003.4048-6-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:509f:9ae8:ad1c:20a4]
X-ClientProxiedBy: AM0PR02CA0115.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::12) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:509f:9ae8:ad1c:20a4]
 (2a02:908:1252:fb60:509f:9ae8:ad1c:20a4) by
 AM0PR02CA0115.eurprd02.prod.outlook.com (2603:10a6:20b:28c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Fri, 23 Apr 2021 07:57:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8741371-16c7-4fca-55cd-08d9062d6b6a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3901:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39013D72E941798F042646D483459@MN2PR12MB3901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6YNOk/o+ZhFR9mEjHFWBnV8KB0/rH9Nyzud0I5h3JAJdQuyyFTRgWRhePdIX341QYDww6iPkBWj0BfspxWyDmVQhoXPB1Dai6pYqM7ZytKK6smoYG1r8ItMghO4Sf+bSkXgf9SygSE7/iFoXS0OepBTqdUFN/2iKXpxehD4noNXGMVKKwhPfy4oILV93dGNO89QZ/zC8/VTPsCz9SSsXnrZFld4ihexXNcIn4HlI4K7GecS2mfEyxpW6yhBPY8CfO7I00cujoQLdQkjGUXCdxX0w7hb9xKTA6W13XU7uUWbzZuheI15iMIkD8/oqNOdcpRP5EQETV28xiK3BM5VFJap2+7ykSVri1aWC/DoiD2BR+f3IUJmc4swSUxenM+jiKdenWowgeh0A8qGWSBarQ+IPWyHmIw6FnOB6xpgh84iqVy8uXmgJyJiIsGZZODhAGYkbOlQCPr7xqBf1IGGmYNzT0M3gkTOd10cYw7NCdZAUncbB3dvPM93mjb9KDS1tCAggKfkXm7qn/DOXRPw33Afu/+h+2TXHZdI5bYYLvGT1k2RHSyx6qw1cNZdlP1Fet0+0u6aACLwgHh3Jwm3uzKwk+mb7IfYW1VmxL2MgEtflgfwSuj67CmOmtIAorZe+Vj050ki+xz7Yf9OXSsFpP0Bvhf9I7UwI66qLy0PKFXEgToTb0vkRAP9YD1aX4o5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(38100700002)(2616005)(66556008)(31696002)(5660300002)(6666004)(316002)(86362001)(6486002)(66946007)(66476007)(478600001)(31686004)(6636002)(8676002)(36756003)(83380400001)(4326008)(8936002)(6862004)(2906002)(37006003)(16526019)(52116002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TCtwUmlITDRheVhLVHJXUjJhNTd2UTMrMXBmKzlrL0s2VUNDK2x6WDBPbkMv?=
 =?utf-8?B?UlhySmxubTZzSzczbGdwL0pkV1AvajB6NHBQeUJSSzZ3dTN2aEhxNDZMSHdw?=
 =?utf-8?B?UnprMEJzRlMxZTFFaFUvaTVCTitTdTltYS9FQWJqK0ZBS2NBRUtlbUVrMWwr?=
 =?utf-8?B?aDdsb1RGNjhHYjU1VE0yYlpkL2p0bXNyZ1FvT3h0UURQQUpEN0FyM1FPdEpG?=
 =?utf-8?B?NzByakF1RzVHdXRmdFArb2lZaDYvWWxlVUh3dFhMV0RLQ2w1UENZSUFHaWlK?=
 =?utf-8?B?ZmhwRElUTklMY1YrSEFvSm83b0hhMUdrYlpTSkorZXdkc1h0Vk9ySGErc2lq?=
 =?utf-8?B?MzI0bTVxclk3TkN4Nms1MmEvcG02YzdxZmh6ekJSOGxWS0ZUMmZpM0JjZzFU?=
 =?utf-8?B?UlFMMnR2cnRVUHZ6QUw5cFNkK2gzMXZjSjNmZ3RYWnc0SzFrUXdSZkJNaytW?=
 =?utf-8?B?ZGZ1RXY5VE9WOVFMblMydHZoZTIrMlpzZjIzME44d2tsNVNBSGZxT0grdUtI?=
 =?utf-8?B?UVlGeXZRVlV2RlFYZzhWcXY2K1Y0OGp3OXEzbGRBbXR0aGtQa2Y0OU1Ja3A2?=
 =?utf-8?B?dGVJM1AycklaRjNVNmhsdFk0NngyVTdpU2ZRZE4vMHNlSmpST0ttVFlSek93?=
 =?utf-8?B?U0JzUHMwZzUzbHVWVW5XQktqQjVKNHE0L3draURJVWpaVGUwNzI2L2E3d01n?=
 =?utf-8?B?YW82bUxscHRwd2NIVXVQSUxrWFBGR2JVTjBEdENaMzJZQlJGTGhEdzlldzhT?=
 =?utf-8?B?SDVHd2ZUQVI3d0J1NTNFb2VDNHh2MFFkNjl3UWNJaGF4YldlTmQwQ3pVK05L?=
 =?utf-8?B?L1FYeFl2ODlsTDFWLzkvVVcxbEhEL0xlRjJTV3JDeHUwYmlkUWVQY3BJSTYx?=
 =?utf-8?B?Zk1KZy9leDB1Q2ExKzZseEcwV2VWN1FwNmRtWmFVd24xTFhaTTJUY2gwY0NG?=
 =?utf-8?B?aGRqUEVyQTdRckZUMFlJM1A3RXNwOUtRdVdJeEcvYlFaeGV2VUZGV0RrUzdw?=
 =?utf-8?B?eFd6QmZGcnhRZUpEN2lOaXBPVjdGaDM5M20xZkhDLy9nbVR5K3htc1lPS1lx?=
 =?utf-8?B?cWJVaFozdVAzSmtZelNRZDI3RDRvMEtNMmIrUWdRL2UwOXduZFVYUVNHSkxj?=
 =?utf-8?B?MUJKWE5IUVdmVDVuOHVpMWREUnh2ZVhIanlYdTZoQTR0M1RTckhOYUtEWE1H?=
 =?utf-8?B?dHV0Y2tkWmpneFdtOUN5bFhXWUE0OGx4dS9OTGNDMHpmS015QWxsb2RwS3BJ?=
 =?utf-8?B?ZUpWdmFUc0MweTZyNzZUUUt0TzZnakhDZjNWTkJweW9HRjA4dXpGUUZCY0x3?=
 =?utf-8?B?VTN0Tng4YWhVaEJrbDlaQnJxQ0puaDhTeHAzWm1PdEFGS2daZGVKN05HOUlW?=
 =?utf-8?B?Mm1DRHpDOFkybXhjSVZvelQyQnYxWWM1ekc4RnVMSVhXODBWMWJRa0FiUEVE?=
 =?utf-8?B?ZWtacjV6eW41OWRQMWNUei92Y2orNk42SjN2WTVjdU9zTEF0R0NLQi93bm4w?=
 =?utf-8?B?VVl1L2poZitrMWM3ZHMyckhYQS9rVkRORno1WmYxTmZqVkVmWXlyZHg2blNQ?=
 =?utf-8?B?QnNJWVozMFlSdTlocnBJNXJLUExrcDQxbFVVYnVIRUxaN0krV2tHRWNFdDNM?=
 =?utf-8?B?WkxFeXQ1Z090a3RvaTRjNytPcWwvQmVSZkVTa1EzUFpMNkY3Um93c1FhWkp5?=
 =?utf-8?B?eUpqejBJUHlpZ0hrOEJzdVBnM3FKQWtHRlo0RXNobGlhTUlsc0cwRUxCa3BG?=
 =?utf-8?B?Sm5BSmIxUFVibzlXWVJvSTJSNWhiTmlkb1lySkIweS9HUHNiS3ora2UvQmsy?=
 =?utf-8?B?YWwrdWtFK0xsT0t3b3VSbkNaaGZuTHdhSllQZUhzRjZRYzNSb1NJT0VYZ2tp?=
 =?utf-8?Q?QNhqNDA7wR/Oy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8741371-16c7-4fca-55cd-08d9062d6b6a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 07:57:19.7470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIIY4ky3G2nZSd0hxpgkRkjSZf3DLXMtR1+RT7yKdBSzEgM0+NxeZX6lk+I0irZo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3901
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
Cc: felix.kuehling@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 22.04.21 um 17:40 schrieb Nirmoy Das:
> Remove unused AMDGPU_GEM_CREATE_SHADOW flag.

Please add "Userspace as never allowed to use this." to the commit message.

Christian.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 +----
>   include/uapi/drm/amdgpu_drm.h              | 2 --
>   2 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 39f88e4a8eb5..da6d4ee0a132 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -649,8 +649,7 @@ int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
>   	memset(&bp, 0, sizeof(bp));
>   	bp.size = size;
>   	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
> -	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC |
> -		AMDGPU_GEM_CREATE_SHADOW;
> +	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>   	bp.type = ttm_bo_type_kernel;
>   	bp.resv = bo->tbo.base.resv;
>   	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> @@ -685,7 +684,6 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
>   	struct amdgpu_bo *bo_ptr;
>   	int r;
>   
> -	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
>   	bp->bo_ptr_size = sizeof(struct amdgpu_bo_user);
>   	r = amdgpu_bo_create(adev, bp, &bo_ptr);
>   	if (r)
> @@ -1559,7 +1557,6 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
>   	amdgpu_bo_print_flag(m, bo, NO_CPU_ACCESS);
>   	amdgpu_bo_print_flag(m, bo, CPU_GTT_USWC);
>   	amdgpu_bo_print_flag(m, bo, VRAM_CLEARED);
> -	amdgpu_bo_print_flag(m, bo, SHADOW);
>   	amdgpu_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
>   	amdgpu_bo_print_flag(m, bo, VM_ALWAYS_VALID);
>   	amdgpu_bo_print_flag(m, bo, EXPLICIT_SYNC);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 8b832f7458f2..9169df7fadee 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -119,8 +119,6 @@ extern "C" {
>   #define AMDGPU_GEM_CREATE_CPU_GTT_USWC		(1 << 2)
>   /* Flag that the memory should be in VRAM and cleared */
>   #define AMDGPU_GEM_CREATE_VRAM_CLEARED		(1 << 3)
> -/* Flag that create shadow bo(GTT) while allocating vram bo */
> -#define AMDGPU_GEM_CREATE_SHADOW		(1 << 4)
>   /* Flag that allocating the BO should use linear VRAM */
>   #define AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS	(1 << 5)
>   /* Flag that BO is always valid in this VM */

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
