Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63AAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 06:33:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 679EB611AD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 06:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 679EB611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19D8B6E974;
	Fri, 10 Sep 2021 06:33:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 121936E974
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 06:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAt2f6Mwwg88pefciVDdE0soy/NUd6gq0iEgzyaeJLx5KcIQcca2PAM4txICyXJN3qssBtWAGabqkqtXFOWmKtztDRhK9wYBLAeqUzIbJXFvGNGuqgJxmnFGR0dVv3aCIpaVSrMG5Dx3fhoc09XNoeAHmPdJcT+y97W+E151N3SjDLFJK223A4SEWkq/9zQ7bRUSIA3CtZB4Azlys3tMWTfPtrZ4XuzDcaP7HEb4klAiLbgYh2hvoLOetU2nRdrEljggO1xuWvoJ7oyVrrgZpm98+FvoTAQzFf3H2wDRpUPByUGfzDGDPIzSeqA6JTjSIomRRcMsE8FPP7gVZrHj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=qPdWbEJ26Wb5Jwho7wlH5rx5nLUbUteWX6pGYe90DFc=;
 b=Hlio39ju1Q+7WaPYgTffz3vjrEUDAdObPCM4Zw7GsvB9iIHtwyLJzxuiCTqgxF0RqOajHhNfd/hoXUaJg0L0867oJKWErmsPGDq7ufDvrGfgYVsHxnoxuCDm+PLjgAGqWQKzKBiDj67/9yX0ACdkBiZL7yv1Cr6QX9Xmz6j/5IMTWx/W2S8V0azttYjaygqY4y3RiyWFjEV1JMgXDD2a7iCs1GurmRtjuGMUr9Hm6zLYAtwx2JJjXTcaf5FKdAIj6xbP9ETGvdGTYPB6bsq2iHLkg7eEdkI3Ey9AZCanmESdP2cX8ccuLbTyxTguwqj2LV3Hig+eB/pbqtdnm0ieNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPdWbEJ26Wb5Jwho7wlH5rx5nLUbUteWX6pGYe90DFc=;
 b=266yswBmoyq6IpyU6zpNaBgDK43JQb0n59cCN6E2E0NMX7Rj7OkDJUb0Ts9d7vtGv+I7YKis1x7qLruWBrHiI6HyYSz466PyYdw+tq2YRorNYPAK3fgZOyu1s+ffAyzhjcjIWBxgiAsLMQ9C6hH38a6C90od38HxnGRpEOl/Kog=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4897.namprd12.prod.outlook.com (2603:10b6:208:17e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 06:33:46 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4500.015; Fri, 10 Sep 2021
 06:33:46 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu: VCN avoid memory allocation during IB test
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20210910003828.4013-1-xinhui.pan@amd.com>
 <20210910003828.4013-4-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <711c2835-85f8-db09-1f61-b1c5d392d774@amd.com>
Date: Fri, 10 Sep 2021 08:33:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210910003828.4013-4-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM9P250CA0012.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::17) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM9P250CA0012.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 06:33:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a071bf3-0398-4d19-ebf8-08d97424f11b
X-MS-TrafficTypeDiagnostic: BL0PR12MB4897:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB48970B8B230D32FFBCBEC0AE83D69@BL0PR12MB4897.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:248;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8aMyLe67+lJ+l9Ogv1fsii8bRIL+5A3vZmAz9BbRbL+RABmi0M8fqqEryDoV2QRglcwP9p9V9OMcN8ufUE/v4jJzW5v/cKdHfXbER5++E4f3G3UU0Aqxwsnpo6fg2CiLaNdTLg/43S7RkN/edoSybojt4YBrfn11lLxtNRN6pm5gzx/nyMKQ28vANaFaSNns8/WM8ijTXpwnp0iegb1Fqne8P4C7Jg+yCj3ITDPx3pBXkbtXjXhywo8fVq1SlLNoVqawued9PKqVRKDMJuOG7G+UdV+tbcnW3B7ATLQNpD7gifUn5pf9h953OfD8Gj0cRajR8jJBr+7ZhMiFBMI050+Wtzs/H6Knsruei8CsrRumtPVvCFhjGYopBl2lwMlSuYrXT3CqwapqYIIQNG0629ut1j4z8W70rtCFaJizapuwMJNhH3K5ZwTUWQ0XQ+JZqNCXiQHLS7J/vWLZpT27auEAPqiUcDaEDBp+SEEIT336+NMsQl4bQ7q8DXVHywOPhTOaZOVxA286cQjqJo8nidpz7QVw2xxOxfdvjljpGxQedMoIhACoq1T8Qh/EUYZi2cZNOJVgx3XNlOdcz/6t36lIywmZoL/8x49grkMR1CIvdwxZhPRLgfTw+ENmynuAgN54v8YCuKRU7wnkn08zIIy8wbK0E/xBaWU5qyJCBof5kvR7aJ0wyQOUKHymvQOj72L+fqWy0FcuCH/j+G+IaUGS3V+yBsprPiUHN24vFP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(86362001)(2616005)(478600001)(6486002)(36756003)(83380400001)(31696002)(956004)(31686004)(26005)(5660300002)(66476007)(316002)(6666004)(16576012)(186003)(4326008)(8936002)(38100700002)(8676002)(66556008)(66946007)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzVQWnhraTF4UVFXZldhNU1OK2F6NWgreWdFaG9KbEFDNEZONStLZkVrc0Rl?=
 =?utf-8?B?VlRGa2tuMTZIbDRzTzVNZWV6eGg2L1NrRXZZT09TZ3ZCL1lzSi9WZTBkbmU1?=
 =?utf-8?B?Ulo0djdWVFhET3FSMS90aUFTVGQvaDNBeGhFbVIvVXQ2bXFZUVNSZzUzRFZa?=
 =?utf-8?B?ZHVpb2xJNzdpOW1xSW5iQ0VCdWRyV1RKU2Ztc1dBUU94RE9JWktVRUtuSHRE?=
 =?utf-8?B?aDFGWlVEa1RrZ2JGQTcvdmJRMnFKK2Jjd0JzWEtCSHJoT3k1ejZGN2MrNm00?=
 =?utf-8?B?TVlWV0p4am9rV1I0ZVRiYnE1cXZMazhWQ1dveG5KeGFVZjlVa2IzemhSSWlE?=
 =?utf-8?B?dG0yc3NJMDZ2RnFWSTVqNWJWUW5QNWZXRjlaNitrYTBkdjIxWHE2Vyt5bGQx?=
 =?utf-8?B?MS9neU9jcmR6emhYU3JCYXJNNzlpQ1BWekxXS3U1RksveEJ0ZlBTcFYvTE5H?=
 =?utf-8?B?d1RPUFluN0NIUEd4YVpxUEhWSUdoelpMVXJmenVCemE4UFIvUU5zR1daZGtW?=
 =?utf-8?B?djRvRHVwUGVTa0dCTzNVVE1OK0hHcUJ3WlBnOWVrVXN2MWtDKzN2b2p4TmJh?=
 =?utf-8?B?UzhQL0NyMHI4ZDUybDU5cFRDM2diQi9rWE5wZXZhcnhXWjhRK3RZdS9DVGFz?=
 =?utf-8?B?NFRObnlSeDFBbVI4S1pjNXRINjgvYldBQXVOUENzSXFUcjJUbnpFWmE1czJF?=
 =?utf-8?B?V0RmZG0zd0hoQy9PZTdrQzFZMVF2TXluVmtyU1B1KzlmMzAwQkxxQTQ1QUJi?=
 =?utf-8?B?QlhGaVJlVEZ0TzZrQ1FYcC91T2pqRTUxOHE5dVJRWVpJYjRyTWF6YzIvUW1H?=
 =?utf-8?B?NmhaVXVaQ0N6SXpuQjIzV2RyU1lyQm0zK3RJMlVjcFB3MWRKQzVsbFpwZnAy?=
 =?utf-8?B?clAybGc4UVJhdW4yZ1h4cjhKNkd1NXBBUk9BcVFWMVpWSHd1SDBYcXVEUEpm?=
 =?utf-8?B?V3kybUdQTFd3Y1ZvUENpYmtQbjA1VEl1bGQzR3kreUh4dEdXQ201aU5CWlRV?=
 =?utf-8?B?bVpWYWdIWS9abHIycys4aUU3U3EwVjhXVFRTb3EyNzB2RC81ay9rT05Fa0pv?=
 =?utf-8?B?aE5QNC9vVXNaYVBBQktUQkRRQWQ3cmF1VXcydkF5THRONEttVFRlaGk0T25L?=
 =?utf-8?B?RG1iV3RsNkFLNXIxY2FTWFZYaXlwS1pGT2xzYTM0Nm8zM2FlZXloZDdzVlZ3?=
 =?utf-8?B?S05ZdElDQ3kreXFpckVlVzZGYUsxekZmSXJmVWh1bkpkall4VmViZGJiMFVV?=
 =?utf-8?B?alJXejlUVDYwOHVObFdaNkNPUFpBdXhHZEVidzNZNE1iNlZOTU9GNzZHWjI0?=
 =?utf-8?B?R1JlVHlPSWdrbjhid3k0MEVoVnpRSU12Nm1RZ01FMDBzR1kvMnRRcm9kMCtP?=
 =?utf-8?B?RC9Bb2krcG5tdFhQMkwrZFl2aS8xRTBCbm1tejhJdGE1RHBlN0xGaHljV0ph?=
 =?utf-8?B?YzIvQ1RFNFc3cWVVeFBzcFFFazRPOEhMMHcrKzZIV3gyQWFmcDJtbzVlRUNl?=
 =?utf-8?B?YjNPRWdDNWV3amJCMGh3N051YkgvMWpNbkxSZUlHMDl1TXpGOHowbXBzaG5n?=
 =?utf-8?B?ckxIUWtQZ2cxU0RlSmszNlRqWW9pYWFBWjcwMW5ZTWZDUGZWWHhNU3BuSWRi?=
 =?utf-8?B?TmFDZ1BONFR2T1psTEdUdnNlUU1XSElKWGhraHRyUndweVdjVm9Ha1RPenBn?=
 =?utf-8?B?SzJGekx1azFGWjVSTGE3S1dNb0sxZkIvKyttRmxQd2V4OXJrRFFoaHB0KzQr?=
 =?utf-8?Q?kOmOP2qpMgIJAlS7Wcux4voapOtTYVMJ85sJnol?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a071bf3-0398-4d19-ebf8-08d97424f11b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 06:33:46.3778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mp+jG8hGLhVTzJtVol+XDi445zEl/zQLCpghhPOJLs0m9JnAzsCSPP/6bDnDV0V6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4897
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



Am 10.09.21 um 02:38 schrieb xinhui pan:
> alloc extra msg from direct IB pool.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 99 +++++++++++--------------
>   1 file changed, 45 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 561296a85b43..b60d5f01fdae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -541,15 +541,14 @@ int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring)
>   }
>   
>   static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
> -				   struct amdgpu_bo *bo,
> -				   struct dma_fence **fence)
> +		struct amdgpu_ib *ib_msg,
> +		struct dma_fence **fence)

The parameter indentation here and at a few other places doesn't look 
correct to me, what editor are you using BTW?

Apart from that the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>.

Regards,
Christian.

>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	struct dma_fence *f = NULL;
>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
> -	uint64_t addr;
> -	void *msg = NULL;
> +	uint64_t addr = ib_msg->gpu_addr;
>   	int i, r;
>   
>   	r = amdgpu_job_alloc_with_ib(adev, 64,
> @@ -558,8 +557,6 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>   		goto err;
>   
>   	ib = &job->ibs[0];
> -	addr = amdgpu_bo_gpu_offset(bo);
> -	msg = amdgpu_bo_kptr(bo);
>   	ib->ptr[0] = PACKET0(adev->vcn.internal.data0, 0);
>   	ib->ptr[1] = addr;
>   	ib->ptr[2] = PACKET0(adev->vcn.internal.data1, 0);
> @@ -576,9 +573,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>   	if (r)
>   		goto err_free;
>   
> -	amdgpu_bo_fence(bo, f, false);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
> +	amdgpu_ib_free(adev, ib_msg, f);
>   
>   	if (fence)
>   		*fence = dma_fence_get(f);
> @@ -588,27 +583,26 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>   
>   err_free:
>   	amdgpu_job_free(job);
> -
>   err:
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
> +	amdgpu_ib_free(adev, ib_msg, f);
>   	return r;
>   }
>   
>   static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -					 struct amdgpu_bo **bo)
> +		struct amdgpu_ib *ib)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	uint32_t *msg;
>   	int r, i;
>   
> -	*bo = NULL;
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      bo, NULL, (void **)&msg);
> +	memset(ib, 0, sizeof(*ib));
> +	r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
> +			AMDGPU_IB_POOL_DIRECT,
> +			ib);
>   	if (r)
>   		return r;
>   
> +	msg = ib->ptr;
>   	msg[0] = cpu_to_le32(0x00000028);
>   	msg[1] = cpu_to_le32(0x00000038);
>   	msg[2] = cpu_to_le32(0x00000001);
> @@ -630,19 +624,20 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   }
>   
>   static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
> -					  struct amdgpu_bo **bo)
> +					  struct amdgpu_ib *ib)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	uint32_t *msg;
>   	int r, i;
>   
> -	*bo = NULL;
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      bo, NULL, (void **)&msg);
> +	memset(ib, 0, sizeof(*ib));
> +	r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
> +			AMDGPU_IB_POOL_DIRECT,
> +			ib);
>   	if (r)
>   		return r;
>   
> +	msg = ib->ptr;
>   	msg[0] = cpu_to_le32(0x00000028);
>   	msg[1] = cpu_to_le32(0x00000018);
>   	msg[2] = cpu_to_le32(0x00000000);
> @@ -658,21 +653,21 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_bo *bo;
> +	struct amdgpu_ib ib;
>   	long r;
>   
> -	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
> +	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &ib);
>   	if (r)
>   		goto error;
>   
> -	r = amdgpu_vcn_dec_send_msg(ring, bo, NULL);
> +	r = amdgpu_vcn_dec_send_msg(ring, &ib, NULL);
>   	if (r)
>   		goto error;
> -	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &bo);
> +	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &ib);
>   	if (r)
>   		goto error;
>   
> -	r = amdgpu_vcn_dec_send_msg(ring, bo, &fence);
> +	r = amdgpu_vcn_dec_send_msg(ring, &ib, &fence);
>   	if (r)
>   		goto error;
>   
> @@ -688,8 +683,8 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   }
>   
>   static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
> -				   struct amdgpu_bo *bo,
> -				   struct dma_fence **fence)
> +		struct amdgpu_ib *ib_msg,
> +		struct dma_fence **fence)
>   {
>   	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
>   	const unsigned int ib_size_dw = 64;
> @@ -697,7 +692,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	struct dma_fence *f = NULL;
>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
> -	uint64_t addr;
> +	uint64_t addr = ib_msg->gpu_addr;
>   	int i, r;
>   
>   	r = amdgpu_job_alloc_with_ib(adev, ib_size_dw * 4,
> @@ -706,7 +701,6 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   		goto err;
>   
>   	ib = &job->ibs[0];
> -	addr = amdgpu_bo_gpu_offset(bo);
>   	ib->length_dw = 0;
>   
>   	ib->ptr[ib->length_dw++] = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
> @@ -726,9 +720,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	if (r)
>   		goto err_free;
>   
> -	amdgpu_bo_fence(bo, f, false);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +	amdgpu_ib_free(adev, ib_msg, f);
>   
>   	if (fence)
>   		*fence = dma_fence_get(f);
> @@ -738,31 +730,29 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   
>   err_free:
>   	amdgpu_job_free(job);
> -
>   err:
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +	amdgpu_ib_free(adev, ib_msg, f);
>   	return r;
>   }
>   
>   int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_bo *bo;
> +	struct amdgpu_ib ib;
>   	long r;
>   
> -	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
> +	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &ib);
>   	if (r)
>   		goto error;
>   
> -	r = amdgpu_vcn_dec_sw_send_msg(ring, bo, NULL);
> +	r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, NULL);
>   	if (r)
>   		goto error;
> -	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &bo);
> +	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &ib);
>   	if (r)
>   		goto error;
>   
> -	r = amdgpu_vcn_dec_sw_send_msg(ring, bo, &fence);
> +	r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, &fence);
>   	if (r)
>   		goto error;
>   
> @@ -809,7 +799,7 @@ int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring)
>   }
>   
>   static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -					 struct amdgpu_bo *bo,
> +					 struct amdgpu_ib *ib_msg,
>   					 struct dma_fence **fence)
>   {
>   	const unsigned ib_size_dw = 16;
> @@ -825,7 +815,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   		return r;
>   
>   	ib = &job->ibs[0];
> -	addr = amdgpu_bo_gpu_offset(bo);
> +	addr = ib_msg->gpu_addr;
>   
>   	ib->length_dw = 0;
>   	ib->ptr[ib->length_dw++] = 0x00000018;
> @@ -863,7 +853,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   }
>   
>   static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
> -					  struct amdgpu_bo *bo,
> +					  struct amdgpu_ib *ib_msg,
>   					  struct dma_fence **fence)
>   {
>   	const unsigned ib_size_dw = 16;
> @@ -879,7 +869,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   		return r;
>   
>   	ib = &job->ibs[0];
> -	addr = amdgpu_bo_gpu_offset(bo);
> +	addr = ib_msg->gpu_addr;
>   
>   	ib->length_dw = 0;
>   	ib->ptr[ib->length_dw++] = 0x00000018;
> @@ -918,21 +908,23 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   
>   int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
> +	struct amdgpu_device *adev = ring->adev;
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_ib ib;
>   	long r;
>   
> -	r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &bo, NULL, NULL);
> +	memset(&ib, 0, sizeof(ib));
> +	r = amdgpu_ib_get(adev, NULL, 128 << 10,
> +			AMDGPU_IB_POOL_DIRECT,
> +			&ib);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_vcn_enc_get_create_msg(ring, 1, bo, NULL);
> +	r = amdgpu_vcn_enc_get_create_msg(ring, 1, &ib, NULL);
>   	if (r)
>   		goto error;
>   
> -	r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, bo, &fence);
> +	r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, &ib, &fence);
>   	if (r)
>   		goto error;
>   
> @@ -943,9 +935,8 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   		r = 0;
>   
>   error:
> +	amdgpu_ib_free(adev, &ib, fence);
>   	dma_fence_put(fence);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_free_kernel(&bo, NULL, NULL);
>   
>   	return r;
>   }

