Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412CAC352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 12:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6CC206D7
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 12:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uliwCfNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6CC206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9171A6EE42;
	Tue, 11 Feb 2020 12:09:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56CF96EE42
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 12:09:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIiZRTFtpJeTTcnFZLZ/4K6QYEL6EwWL7CxnyHAqWIfPrME/Rk/T2Ja/ayAqnq89NufTsDG3+blP+pnJqEnZ1q8u7nHbKq9UQUmoU/LOOR2uU2dv9IDrOGV4W6oYdoSiD4weEieRE/75R/d5jiA0PKz1ud19sCQnpmpnToNcGoTqtDmidwSlg6Rsw3ya2lT30HL1Z++IM4ztnRP7Iqh5pqkXy/ufBZPqOAB4MkrueY6UP0Guw5+hLJbWKEx9//bzP5mwx01GfleYD2m9LyAzCMNK0kRFCAXepZ7O9VVYp/gsnygjm98XyfAwBM+9cihrmyyeQ86pRPLWwv3fye0viA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5k4Wbz/+cacSYZcEVf7lSgHHI8hicfcz/CoSB714WVM=;
 b=FiP92XoQd5muJX/VDVsgOSGJFPfcuIQGKXcWdu5ll+o9p4rBjsUkDNNjteTdqI5vocPkdo+r6xKexKToGUjl6jLTO2JQnhbR09yHfq/AzM5G0xwutHw8zNrNJxrtoJhibMae9qqzcLsMZolcv+k+jZ/xBxTHgy8G/H3wiqtNrBJHK06GowcUdLL3oyz7TIhI6oaWJ1JvaLlDRB0AHeImSJZSKjGr61/GJ0c0Ort9HhrCQTO8GaumEk6jr2Gr/iIVEIhRcVNdqtqe77bu+d1fARMuwKg1BZ/rxt78TUvr0q7fhsQppqHhcliaRFGKC8k5m+uj1WSrr3WMSYdFbOHh3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5k4Wbz/+cacSYZcEVf7lSgHHI8hicfcz/CoSB714WVM=;
 b=uliwCfNYsqXOLiJ2tNRM41eRIaDt4+Ip2omcXumJNG7KTDzbgtmFAqQpzGrj780ZmQNVhFx6UVQU3sQ9sLG1A8kOKRuMWMOHY/CCshhZEq1OiLTbgx/e1NY2wpC82O+Y3F1DKtG5djMkV1SD7s9xuAUdnD1vjCCaZ6u95aEmjN0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1468.namprd12.prod.outlook.com (10.172.40.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Tue, 11 Feb 2020 12:09:01 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3%6]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 12:09:01 +0000
Subject: Re: [RFC PATCH] drm/amdgpu: move ttm bo->offset to amdgpu_bo
To: Huang Rui <ray.huang@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>
References: <20200211111722.6372-1-nirmoy.das@amd.com>
 <20200211115413.GA18019@jenkins-Celadon-RN>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <b285ea9f-75ee-e6e0-7058-410213d04a55@amd.com>
Date: Tue, 11 Feb 2020 13:11:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <20200211115413.GA18019@jenkins-Celadon-RN>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::17) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f2b:9b00:46cb:968b:e998:10ca]
 (2003:c5:8f2b:9b00:46cb:968b:e998:10ca) by
 FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 12:08:59 +0000
X-Originating-IP: [2003:c5:8f2b:9b00:46cb:968b:e998:10ca]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3964319b-9c21-4d17-c2fe-08d7aeeb2e19
X-MS-TrafficTypeDiagnostic: DM5PR12MB1468:|DM5PR12MB1468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB146876EA9698247DD595E5078B180@DM5PR12MB1468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(189003)(199004)(4326008)(16526019)(186003)(2616005)(53546011)(52116002)(6666004)(110136005)(316002)(31696002)(81166006)(8936002)(81156014)(8676002)(45080400002)(478600001)(966005)(31686004)(6486002)(36756003)(2906002)(66946007)(66476007)(66556008)(5660300002)(30864003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1468;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2NPQEhlSqGSk5q7+aKg2h4i/Sz6cKLnpTYq8xiDREBzA83gmAWl+lv9Hs9vXSEWyXZyY0XCCh/mIvCxqFBGg3GER7kvofCN1U7Wwtfbk4pKKp7lYbpmdsuSPGZ06LzysX0IL7WRpMMn6zmdbECGhzzl1pgSyXjNuGu16vKqA8vwrx1c8DzQiN0iuqw06W9KdQ4PqexZECfxiui/vpMh38vPzLSgmU7SDp3hlQKoHWIXJXvTYd8aJHv2NgkMYii4m21dKBWXN9dPUhOA2fGe1VZF6HnQ66PKPv3W+OC6lzq2puLEML/pzf2Qlcy2SBntVwA3VojBWEtzrlnGGppy+V71wiXo9Jx54G9QEnNOGdRqxM+/gkeF0QpO9+NcxWJFv1qMvOmHAPyWOmuREhy/W+tYmfowdolVMBzodK8WuJ+bjYhgVFPAZQ5FCyK6Sg8oJI80mCs/KZSK5sNi+VVwJY+D23Ok07yhK5bD8W0pbMz1Kstft88cBYepefB+3cPERRVqBUZHgxtR3xpOaHoZcvw==
X-MS-Exchange-AntiSpam-MessageData: rxg5kBgcuW9sB0bJA4MdDEk0P+v1t3QNJBZxT6IhcvB2GU8xX3MeEE6z8xftuCc7dS+KNYot2lTHY2bKvMoC4mHhlgpWpIiGLHnJXvDxxAOUVBGqPt7IEk2c96qUPN04hOCXLzpn4cLF4HKyoteLF7oIN9TF/zg4/Nuz36noLgBsy2hxeCQCz7h64X8EtJnsJnO5IQeY0Ew5ZtYCrjGizw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3964319b-9c21-4d17-c2fe-08d7aeeb2e19
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 12:09:01.1371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTaePAhUHiuoT8KD2BDxE6ZYBd5hu7s6h6kKghRL0eRC0FOi1VhAMBzicxLYV692cmP9x316BBtNBIVafxnjEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1468
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
Cc: alexander.deucher@amd.com, nirmoy.das@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/11/20 12:57 PM, Huang Rui wrote:
> On Tue, Feb 11, 2020 at 12:17:22PM +0100, Nirmoy Das wrote:
>> GPU address should belong to driver not in memory management.
>> This patch moves ttm bo.offset and gpu_offset calculation to amdgpu driver.
>>
> Looks good for me. Yes, agree, the mc address should be got from amdgpu_bo.
>
> Acked-by: Huang Rui <ray.huang@amd.com>
>
> How about other hardware drivers which also use ttm?

Yes, my plan is to remove ttm bo->offset and gpu_offset completely from 
TTM and all other driver.

Once I get a positive review from here I will do the same for vmwgfx, 
only other driver I found using offset after a simple grep.

Regards,

Nirmoy

>
> Thanks,
> Ray
>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c        |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 22 ++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  3 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_test.c      |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 40 +++++++++----------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |  8 ++--
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
>>   12 files changed, 55 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 8609287620ea..613047ea9065 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -263,7 +263,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
>>   		goto allocate_mem_pin_bo_failed;
>>   	}
>>   
>> -	r = amdgpu_ttm_alloc_gart(&bo->tbo);
>> +	r = amdgpu_ttm_alloc_gart(bo);
>>   	if (r) {
>>   		dev_err(adev->dev, "%p bind failed\n", bo);
>>   		goto allocate_mem_kmap_bo_failed;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
>> index d9b35df33806..f29986231b27 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
>> @@ -98,7 +98,7 @@ static void amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
>>   		amdgpu_bo_unreserve(sobj);
>>   		goto out_cleanup;
>>   	}
>> -	r = amdgpu_ttm_alloc_gart(&sobj->tbo);
>> +	r = amdgpu_ttm_alloc_gart(sobj);
>>   	amdgpu_bo_unreserve(sobj);
>>   	if (r) {
>>   		goto out_cleanup;
>> @@ -117,7 +117,7 @@ static void amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
>>   		amdgpu_bo_unreserve(sobj);
>>   		goto out_cleanup;
>>   	}
>> -	r = amdgpu_ttm_alloc_gart(&dobj->tbo);
>> +	r = amdgpu_ttm_alloc_gart(dobj);
>>   	amdgpu_bo_unreserve(dobj);
>>   	if (r) {
>>   		goto out_cleanup;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 80ba6dfc54e2..921719d92ab1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -642,7 +642,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>>   	if (!r && p->uf_entry.tv.bo) {
>>   		struct amdgpu_bo *uf = ttm_to_amdgpu_bo(p->uf_entry.tv.bo);
>>   
>> -		r = amdgpu_ttm_alloc_gart(&uf->tbo);
>> +		r = amdgpu_ttm_alloc_gart(uf);
>>   		p->job->uf_addr += amdgpu_bo_gpu_offset(uf);
>>   	}
>>   
>> @@ -1676,5 +1676,5 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
>>   			return r;
>>   	}
>>   
>> -	return amdgpu_ttm_alloc_gart(&(*bo)->tbo);
>> +	return amdgpu_ttm_alloc_gart(*bo);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> index ca9056b0472a..3d0aa2b2926f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> @@ -199,7 +199,7 @@ int amdgpu_display_crtc_page_flip_target(struct drm_crtc *crtc,
>>   		}
>>   	}
>>   
>> -	r = amdgpu_ttm_alloc_gart(&new_abo->tbo);
>> +	r = amdgpu_ttm_alloc_gart(new_abo);
>>   	if (unlikely(r != 0)) {
>>   		DRM_ERROR("%p bind failed\n", new_abo);
>>   		goto unpin;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
>> index 143753d237e7..a02b1cbd006d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
>> @@ -174,7 +174,7 @@ static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
>>   		goto out_unref;
>>   	}
>>   
>> -	ret = amdgpu_ttm_alloc_gart(&abo->tbo);
>> +	ret = amdgpu_ttm_alloc_gart(abo);
>>   	if (ret) {
>>   		amdgpu_bo_unreserve(abo);
>>   		dev_err(adev->dev, "%p bind failed\n", abo);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 6f60a581e3ba..650758a5b3aa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -274,7 +274,7 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
>>   		goto error_unreserve;
>>   	}
>>   
>> -	r = amdgpu_ttm_alloc_gart(&(*bo_ptr)->tbo);
>> +	r = amdgpu_ttm_alloc_gart(*bo_ptr);
>>   	if (r) {
>>   		dev_err(adev->dev, "%p bind failed\n", *bo_ptr);
>>   		goto error_unpin;
>> @@ -917,7 +917,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>>   		bo->pin_count++;
>>   
>>   		if (max_offset != 0) {
>> -			u64 domain_start = bo->tbo.bdev->man[mem_type].gpu_offset;
>> +			u64 domain_start = amdgpu_bo_gpu_start(adev, mem_type);
>>   			WARN_ON_ONCE(max_offset <
>>   				     (amdgpu_bo_gpu_offset(bo) - domain_start));
>>   		}
>> @@ -1248,6 +1248,18 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
>>   	return 0;
>>   }
>>   
>> +uint64_t amdgpu_bo_gpu_start(struct amdgpu_device *adev, uint32_t type)
>> +{
>> +	switch(type) {
>> +		case TTM_PL_TT:
>> +			return adev->gmc.gart_start;
>> +		case TTM_PL_VRAM:
>> +			return adev->gmc.vram_start;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   /**
>>    * amdgpu_bo_move_notify - notification about a memory move
>>    * @bo: pointer to a buffer object
>> @@ -1278,6 +1290,10 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>>   	if (evict)
>>   		atomic64_inc(&adev->num_evictions);
>>   
>> +	if (new_mem)
>> +		abo->offset = (new_mem->start << PAGE_SHIFT) +
>> +			 amdgpu_bo_gpu_start(amdgpu_ttm_adev(bo->bdev), new_mem->mem_type);
>> +
>>   	/* update statistics */
>>   	if (!new_mem)
>>   		return;
>> @@ -1467,7 +1483,7 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
>>   	WARN_ON_ONCE(bo->tbo.mem.mem_type == TTM_PL_VRAM &&
>>   		     !(bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS));
>>   
>> -	return amdgpu_gmc_sign_extend(bo->tbo.offset);
>> +	return amdgpu_gmc_sign_extend(bo->offset);
>>   }
>>   
>>   /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> index 96d805889e8d..c7e1028fd31f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> @@ -94,6 +94,8 @@ struct amdgpu_bo {
>>   	unsigned			prime_shared_count;
>>   	/* per VM structure for page tables and with virtual addresses */
>>   	struct amdgpu_vm_bo_base	*vm_bo;
>> +	 /* GPU address space is independent of CPU word size */
>> +	uint64_t			offset;
>>   	/* Constant after initialization */
>>   	struct amdgpu_bo		*parent;
>>   	struct amdgpu_bo		*shadow;
>> @@ -294,6 +296,7 @@ int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
>>   uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
>>   					    uint32_t domain);
>>   
>> +uint64_t amdgpu_bo_gpu_start(struct amdgpu_device *adev, uint32_t type);
>>   /*
>>    * sub allocation
>>    */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>> index 476f1f89aaad..dfab64bbb5fa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>> @@ -103,7 +103,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
>>   			DRM_ERROR("Failed to pin GTT object %d\n", i);
>>   			goto out_lclean_unres;
>>   		}
>> -		r = amdgpu_ttm_alloc_gart(&gtt_obj[i]->tbo);
>> +		r = amdgpu_ttm_alloc_gart(gtt_obj[i]);
>>   		if (r) {
>>   			DRM_ERROR("%p bind failed\n", gtt_obj[i]);
>>   			goto out_lclean_unpin;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 2c1d1eb1a7e1..15d9e8f807b9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -103,7 +103,6 @@ static int amdgpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
>>   	case TTM_PL_TT:
>>   		/* GTT memory  */
>>   		man->func = &amdgpu_gtt_mgr_func;
>> -		man->gpu_offset = adev->gmc.gart_start;
>>   		man->available_caching = TTM_PL_MASK_CACHING;
>>   		man->default_caching = TTM_PL_FLAG_CACHED;
>>   		man->flags = TTM_MEMTYPE_FLAG_MAPPABLE | TTM_MEMTYPE_FLAG_CMA;
>> @@ -111,7 +110,6 @@ static int amdgpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
>>   	case TTM_PL_VRAM:
>>   		/* "On-card" video ram */
>>   		man->func = &amdgpu_vram_mgr_func;
>> -		man->gpu_offset = adev->gmc.vram_start;
>>   		man->flags = TTM_MEMTYPE_FLAG_FIXED |
>>   			     TTM_MEMTYPE_FLAG_MAPPABLE;
>>   		man->available_caching = TTM_PL_FLAG_UNCACHED | TTM_PL_FLAG_WC;
>> @@ -122,7 +120,6 @@ static int amdgpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
>>   	case AMDGPU_PL_OA:
>>   		/* On-chip GDS memory*/
>>   		man->func = &ttm_bo_manager_func;
>> -		man->gpu_offset = 0;
>>   		man->flags = TTM_MEMTYPE_FLAG_FIXED | TTM_MEMTYPE_FLAG_CMA;
>>   		man->available_caching = TTM_PL_FLAG_UNCACHED;
>>   		man->default_caching = TTM_PL_FLAG_UNCACHED;
>> @@ -270,7 +267,7 @@ static uint64_t amdgpu_mm_node_addr(struct ttm_buffer_object *bo,
>>   
>>   	if (mm_node->start != AMDGPU_BO_INVALID_OFFSET) {
>>   		addr = mm_node->start << PAGE_SHIFT;
>> -		addr += bo->bdev->man[mem->mem_type].gpu_offset;
>> +		addr += amdgpu_bo_gpu_start(amdgpu_ttm_adev(bo->bdev), mem->mem_type);
>>   	}
>>   	return addr;
>>   }
>> @@ -1086,27 +1083,28 @@ static int amdgpu_ttm_backend_bind(struct ttm_tt *ttm,
>>   /**
>>    * amdgpu_ttm_alloc_gart - Allocate GART memory for buffer object
>>    */
>> -int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>> +int amdgpu_ttm_alloc_gart(struct amdgpu_bo *bo)
>>   {
>> -	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>> +	struct ttm_buffer_object *tbo = &bo->tbo;
>> +	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>>   	struct ttm_operation_ctx ctx = { false, false };
>> -	struct amdgpu_ttm_tt *gtt = (void*)bo->ttm;
>> +	struct amdgpu_ttm_tt *gtt = (void*)tbo->ttm;
>>   	struct ttm_mem_reg tmp;
>>   	struct ttm_placement placement;
>>   	struct ttm_place placements;
>>   	uint64_t addr, flags;
>>   	int r;
>>   
>> -	if (bo->mem.start != AMDGPU_BO_INVALID_OFFSET)
>> +	if (tbo->mem.start != AMDGPU_BO_INVALID_OFFSET)
>>   		return 0;
>>   
>> -	addr = amdgpu_gmc_agp_addr(bo);
>> +	addr = amdgpu_gmc_agp_addr(tbo);
>>   	if (addr != AMDGPU_BO_INVALID_OFFSET) {
>> -		bo->mem.start = addr >> PAGE_SHIFT;
>> +		tbo->mem.start = addr >> PAGE_SHIFT;
>>   	} else {
>>   
>>   		/* allocate GART space */
>> -		tmp = bo->mem;
>> +		tmp = tbo->mem;
>>   		tmp.mm_node = NULL;
>>   		placement.num_placement = 1;
>>   		placement.placement = &placements;
>> @@ -1114,30 +1112,30 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>>   		placement.busy_placement = &placements;
>>   		placements.fpfn = 0;
>>   		placements.lpfn = adev->gmc.gart_size >> PAGE_SHIFT;
>> -		placements.flags = (bo->mem.placement & ~TTM_PL_MASK_MEM) |
>> +		placements.flags = (tbo->mem.placement & ~TTM_PL_MASK_MEM) |
>>   			TTM_PL_FLAG_TT;
>>   
>> -		r = ttm_bo_mem_space(bo, &placement, &tmp, &ctx);
>> +		r = ttm_bo_mem_space(tbo, &placement, &tmp, &ctx);
>>   		if (unlikely(r))
>>   			return r;
>>   
>>   		/* compute PTE flags for this buffer object */
>> -		flags = amdgpu_ttm_tt_pte_flags(adev, bo->ttm, &tmp);
>> +		flags = amdgpu_ttm_tt_pte_flags(adev, tbo->ttm, &tmp);
>>   
>>   		/* Bind pages */
>>   		gtt->offset = (u64)tmp.start << PAGE_SHIFT;
>> -		r = amdgpu_ttm_gart_bind(adev, bo, flags);
>> +		r = amdgpu_ttm_gart_bind(adev, tbo, flags);
>>   		if (unlikely(r)) {
>> -			ttm_bo_mem_put(bo, &tmp);
>> +			ttm_bo_mem_put(tbo, &tmp);
>>   			return r;
>>   		}
>>   
>> -		ttm_bo_mem_put(bo, &bo->mem);
>> -		bo->mem = tmp;
>> +		ttm_bo_mem_put(tbo, &tbo->mem);
>> +		tbo->mem = tmp;
>>   	}
>>   
>> -	bo->offset = (bo->mem.start << PAGE_SHIFT) +
>> -		bo->bdev->man[bo->mem.mem_type].gpu_offset;
>> +	bo->offset = (tbo->mem.start << PAGE_SHIFT) +
>> +		amdgpu_bo_gpu_start(adev, tbo->mem.mem_type);
>>   
>>   	return 0;
>>   }
>> @@ -2149,7 +2147,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>>   	}
>>   
>>   	if (bo->tbo.mem.mem_type == TTM_PL_TT) {
>> -		r = amdgpu_ttm_alloc_gart(&bo->tbo);
>> +		r = amdgpu_ttm_alloc_gart(bo);
>>   		if (r)
>>   			return r;
>>   	}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index f1ebd424510c..4f6e7ef2b004 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -100,7 +100,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>>   			struct dma_fence **fence);
>>   
>>   int amdgpu_mmap(struct file *filp, struct vm_area_struct *vma);
>> -int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>> +int amdgpu_ttm_alloc_gart(struct amdgpu_bo *bo);
>>   int amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>   
>>   #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>> index 4cc7881f438c..c810cda7a06e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>> @@ -37,12 +37,12 @@ static int amdgpu_vm_sdma_map_table(struct amdgpu_bo *table)
>>   {
>>   	int r;
>>   
>> -	r = amdgpu_ttm_alloc_gart(&table->tbo);
>> +	r = amdgpu_ttm_alloc_gart(table);
>>   	if (r)
>>   		return r;
>>   
>>   	if (table->shadow)
>> -		r = amdgpu_ttm_alloc_gart(&table->shadow->tbo);
>> +		r = amdgpu_ttm_alloc_gart(table->shadow);
>>   
>>   	return r;
>>   }
>> @@ -140,7 +140,7 @@ static void amdgpu_vm_sdma_copy_ptes(struct amdgpu_vm_update_params *p,
>>   
>>   	src += p->num_dw_left * 4;
>>   
>> -	pe += amdgpu_gmc_sign_extend(bo->tbo.offset);
>> +	pe += amdgpu_gmc_sign_extend(bo->offset);
>>   	trace_amdgpu_vm_copy_ptes(pe, src, count, p->direct);
>>   
>>   	amdgpu_vm_copy_pte(p->adev, ib, pe, src, count);
>> @@ -167,7 +167,7 @@ static void amdgpu_vm_sdma_set_ptes(struct amdgpu_vm_update_params *p,
>>   {
>>   	struct amdgpu_ib *ib = p->job->ibs;
>>   
>> -	pe += amdgpu_gmc_sign_extend(bo->tbo.offset);
>> +	pe += amdgpu_gmc_sign_extend(bo->offset);
>>   	trace_amdgpu_vm_set_ptes(pe, addr, count, incr, flags, p->direct);
>>   	if (count < 3) {
>>   		amdgpu_vm_write_pte(p->adev, ib, pe, addr | flags,
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 6786d34f7d04..277dbc6ba8ec 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -5212,7 +5212,7 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
>>   		return r;
>>   	}
>>   
>> -	r = amdgpu_ttm_alloc_gart(&rbo->tbo);
>> +	r = amdgpu_ttm_alloc_gart(rbo);
>>   	if (unlikely(r != 0)) {
>>   		amdgpu_bo_unpin(rbo);
>>   		ttm_eu_backoff_reservation(&ticket, &list);
>> -- 
>> 2.25.0
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C2d55974df6a543431af708d7aee3a25a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637170165033072494&amp;sdata=MXLAHsn8x4NFx8QUYQB6Vb%2B3lh%2ByW0oNs2TAnF5v1GI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
