Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D39AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 07:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D0E60FC0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 07:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D2D0E60FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 669D16E982;
	Fri, 10 Sep 2021 07:55:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 850286E982
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 07:55:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQKy+y4+ruab0SZXO2eEj++LFd4lzToqI+a4kqS08GwEJlQ8SQoOPrHfxsiL/X1PfCzlOxF9OnsG4CQksFGDDAGPfFcPRELJYSoEpeIZYNegq171P271TKkDEl/PEu5MRf/IGddiXvXBhOUdk3AgA1r9WnkeuBTojl5qwMYnxy4AJROrbmJo8uwbpWmrisQs1ANRoFnLgmo0kX1zdLmcS4cZghS/VcFb6LVa+azYypnpIicS4Bvk6FKfHHLiKzUgCy+HhMzkvprm8JUzpkbZSU7L4sFzPcsraB5J1BO0RFNOlfq21Gg1/vB549lqYAcgHVmX41QonXkuBkNWC+Gc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=5Hfrxd09pAyYur2CxHw6UIutuB+9go56n+WpWfohgjU=;
 b=nsxzF6nslNz2HNPkPIUDDPAx2jxO/5UYHImMCdasngo/hgbp0JhIEnLwVtKvKqVQzVLT5WrpKhaxqNrsBaBgyeFeaOjLoSK28oig0lcblQwz70ccT1L/v7VNx/YEUQV/vMxbuZ3KfNgPbTQ3vO+VqctY12Wrt8Ob02apHyQLNvRb7/BKEdOm0oV0c56BxbIut1rF2iygYwQZyMeMcQBOpIR2c1/z8Uwp3MTXFgVMNj+kKhOhRXBzFBWdGa8Nn2wQ1/g9UW8OBOlCx/TV09y22UnwqYkio2aeRIJAr275aUr34ZUWITznu91KDKjNtAm7B4Em96ROcs2HW1U26cliGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Hfrxd09pAyYur2CxHw6UIutuB+9go56n+WpWfohgjU=;
 b=SLqNNekV/wrjuwNF7SA0YCR6clLQkW8grB4cdPQzz0nnYGMGgq4WiBv+zI2l9WO1QNj+KlKBjd3VobOFR3/t0v5A555J7qAvbkDq1wD0MVtxr+sxWL5zyic8kxWJlMxK51WYda1so0MI+nBWkYDAB/Ndsx8z5Up8iF4ApPfmPQw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BYAPR12MB2936.namprd12.prod.outlook.com (2603:10b6:a03:12f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Fri, 10 Sep
 2021 07:55:49 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::1d09:e72:91fd:ef05]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::1d09:e72:91fd:ef05%7]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 07:55:49 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIDQvNF0gZHJtL2FtZGdwdTogVkNOIGF2?=
 =?UTF-8?Q?oid_memory_allocation_during_IB_test?=
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210910003828.4013-1-xinhui.pan@amd.com>
 <20210910003828.4013-4-xinhui.pan@amd.com>
 <711c2835-85f8-db09-1f61-b1c5d392d774@amd.com>
 <DM4PR12MB51658D52B6B2F20D69749DE587D69@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <05062a68-581b-6fa5-bbee-3a7286d8309a@amd.com>
Date: Fri, 10 Sep 2021 09:55:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM4PR12MB51658D52B6B2F20D69749DE587D69@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0021.eurprd05.prod.outlook.com (2603:10a6:205::34)
 To BY5PR12MB3764.namprd12.prod.outlook.com
 (2603:10b6:a03:1ac::17)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM4PR05CA0021.eurprd05.prod.outlook.com (2603:10a6:205::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.16 via Frontend Transport; Fri, 10 Sep 2021 07:55:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24e641e7-251e-40a2-30d3-08d97430672a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2936:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB29363B6E04438957693018A383D69@BYAPR12MB2936.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: drKnkiUJ+pHwP6TjSWw3hxcnBH/TQYpj/zmL4ygIIOxqhf/O6Y+WqDExw61WXWewmYZHbnXOo+XjDzO3ARY1MRRgr2YLvKytDtyI6pzV5F22Wp0+4csJHEgVs6HXD/shT/K2IGpJWMBKa9nz/uEs7VgLX15c/tNXbDKTildBmt4xkXlEEz//qwPwbcVgj0wHx0n6+aOFpdPKswvH+QoWg2PGpMZwCRuH1eYaIq96a/vTJ9bocKatsWmus4hYJza1/nx1LVZIYpCXjQJNix0F9YQe+9Tfdgy4YnY5JcsDwfKDR+scim0lloV56YHb1RKbHnSZQqE6KrcvabW6rQb7YMKCEzPtGM+YtmeQfMXhAPf9Aq0h8hJ9NTKnCe3Mw+lgqglXUJCzqSzrLAX4NdcaqbDc3p7il9uj1hjs+JcJ1tP3s5JEsFD0pTMVgcsx+EDsnaw1dVSewU3xMzLf6r/0ZEfOLTPCSDEtTijIXyJ9ewKko9DaV/WKyVMChUF4UJGiOU8AEUZ2R0VFiTbxwNC37aO9WE4fMLxJJUyDdN4ovwJBl8UQz9IWyFmIltaGbaMw4QSTQHBf0Mr7MqzCt3Txan0mQbpceSNxlOKqNCLKvco/EGqf53vauBMNhd1UMjgvKi2UpI6PUummjSEeL+LUS8qJsYLTnuj8Rw/kVoTlIiWuvx2sZTKLgvWB3g8XXh2UkyXOgEwuxP5H2/MENrWhC4tg+mbrsIt4MiFZWL3TAVPkEnng83HCvCYYHqnZMaR0MEz7zhsYUJJtiaPhTbJgZYFEZdSAJsNOLQcxolPKd7kGBWj90i9yHeqDeya/Ud9u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(224303003)(36756003)(6666004)(83380400001)(5660300002)(16576012)(316002)(2616005)(31686004)(6486002)(186003)(508600001)(2906002)(38100700002)(66476007)(956004)(110136005)(4326008)(8936002)(31696002)(26005)(66556008)(66946007)(86362001)(966005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmFVd29DL3RtcFJseDRqRFZac2VSS0I1dklsU0JJaG1rSXphYUl5cTZycTNj?=
 =?utf-8?B?U21RZU9Xbmx4SC9JRUp1ZDIxN1JGcnlIZDVDM3BYQytUK3QvSk9IcHZpVVFN?=
 =?utf-8?B?TUNrT1pCWWZtemxGSTI1UzhhbHg4WGpIWS9HNWZRblp0c0RDajRDb2ZmdDg4?=
 =?utf-8?B?dUQyU084UnBRZ21RVmhKdGk2bERXcmdRMXB4R2svUmVhYnM5a1ZISzF4Y3Jz?=
 =?utf-8?B?VnZ5VmUvNDljdklHQi83K0wzaWo2ZU03Q3dURVk1OVI3TGVQTUp3WW95S3Uv?=
 =?utf-8?B?QnFxcGE4SjJMUDVydHZqRWUzYVN1TlNxQ1MwbEhKSTdXRDBkS1FkNzR1Tmti?=
 =?utf-8?B?V3BDeGNXYWpzdGM2NFpEU0FubWRRalBPVnYrcWlPTDRzWFZmUG1nTnhlRDJj?=
 =?utf-8?B?d0NBSnpvdXcxZ1FZYkdROXJzc1BOWjVoWDRLZWswWEFrT0xkZWs5VTUwREVy?=
 =?utf-8?B?b0U2aXBaTEJVanljdnRzRENqTDBXV0VMcG1YY3dqVzVTVFhHYm5XaGJZV2NF?=
 =?utf-8?B?bmhpMVhUd3F0Y05neGZiZzdKSG5XMEVPMnowRWNJR0VUTjFQb3FWUlFFV1B2?=
 =?utf-8?B?aTJiU3RZdW1yckYvYnNHLzE5aGxZZitKRjg0L3RGb254Y0NRRk52NmpSeStW?=
 =?utf-8?B?YVFUWFo4UEx6WjlESk9lRm5ZRjBIK3l1Vis0Skk2U1V1ZkVLdWFMNTZDU2tX?=
 =?utf-8?B?L1lwQ3NITENmTGQxd1oyRURlSldQUHlmcTJEZGhkbUtmcU1meG1tbE85ME9q?=
 =?utf-8?B?ZlJaa2VmcVN2WGpGR0dHMXJaS0tZWEVDdmJUamxSRWowTGxXTzE5YWVvemQx?=
 =?utf-8?B?WkFDVXFMR0RxSGkrbEVHYmUyN25MUWZ3ZURmTGYxWldTaTVJakpWbXBUUjNW?=
 =?utf-8?B?c1JwMTJaODVEL0Z0dHVNNDRFSTVDVHpzSThtSGVzbEVNZnFrc2lnR0VRYTRm?=
 =?utf-8?B?TGhHdElueG02OHc3eWpOdWxaTkh3VzJQT21Cb3RlOWpyMEJqUkNaRmNBdlk4?=
 =?utf-8?B?NXBHOGtxR3ZJTWw0U2FYY3hWU1JyQnhIdHBGS01hNWpKSUFEU3A0andZamc0?=
 =?utf-8?B?eEU0L1JyZEs4M3l6cVBZQ21tTHoxWmI1cVV0QXl1RzRNSTdzeDVJWm8xQ0g4?=
 =?utf-8?B?MnBOQzZsRDZyZWl3Y25TM3ZWN20vRXNzREVoRWFXdjlPWlg5RnZKNlJmT1FF?=
 =?utf-8?B?Z24wUDllcSszT0toeFZONlkxeFRDNm5wd0RiVFlDN0VDZ0MwRERIcmQyTFVv?=
 =?utf-8?B?V2M2Nlk0d1JaNStrVllHQWZ1cm1mNkJqWm0wQnpRQlFmZGJJUmwvSEJkMzVJ?=
 =?utf-8?B?UFIwR2s0L0dMZGZEUFdiU1d5RTNSYW9IemluSFRyVm50YUxsdUc0bWtYeVZL?=
 =?utf-8?B?UmhNM21VRzVQZENIdGwxR2xKUkswa1hvRGJ0RDBnZnF0b1lvVTlCMldHWHdm?=
 =?utf-8?B?OWhjT2RWUDAzRisvYlVpT1ZVbjR5dzF5SmlXdkhHUjUybjVpbFJrUzBvZVhp?=
 =?utf-8?B?ZWRhaTliWDIyOG5LMndIOWxBQ2NnUnVTTFBOS1Rpc04xejVaWkozUEt2TzFE?=
 =?utf-8?B?VG1lbkF0SVFQQ2ZralB2eEl3N2YraXlQMDUybkhlNzZ3LzR0UTFVUTRyRlNJ?=
 =?utf-8?B?UTNuQzN2Z01HWnl4RkV3UUlUYmxTSWlMdTUvcWtYTEdpUlh5T25vVXpmY0Zq?=
 =?utf-8?B?aVNzUERLQnd5NnJ0bmlrbmNMOEtJSWtjeWNBQ3hTdG55U3NudjA1aWtWOHha?=
 =?utf-8?Q?B8s+7XAA/YaDKwWiVjtSCyw5uaCPAWqeC3n8Xy5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e641e7-251e-40a2-30d3-08d97430672a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 07:55:49.0194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThSAX4UALvOf6uzRn8uUB2wHEiakSs9CTS5OCjchu44xfvuPdqF1tVVQzXlmz6k6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2936
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

Try that plugin here https://github.com/vivien/vim-linux-coding-style

I'm using it for years and it really helpful.

Christian.

Am 10.09.21 um 09:53 schrieb Pan, Xinhui:
> [AMD Official Use Only]
>
> I am using vim with
> set tabstop=8
> set shiftwidth=8
> set softtabstop=8
>
> ________________________________________
> 发件人: Koenig, Christian <Christian.Koenig@amd.com>
> 发送时间: 2021年9月10日 14:33
> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
> 抄送: Deucher, Alexander
> 主题: Re: [PATCH 4/4] drm/amdgpu: VCN avoid memory allocation during IB test
>
>
>
> Am 10.09.21 um 02:38 schrieb xinhui pan:
>> alloc extra msg from direct IB pool.
>>
>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 99 +++++++++++--------------
>>    1 file changed, 45 insertions(+), 54 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index 561296a85b43..b60d5f01fdae 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -541,15 +541,14 @@ int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring)
>>    }
>>
>>    static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>> -                                struct amdgpu_bo *bo,
>> -                                struct dma_fence **fence)
>> +             struct amdgpu_ib *ib_msg,
>> +             struct dma_fence **fence)
> The parameter indentation here and at a few other places doesn't look
> correct to me, what editor are you using BTW?
>
> Apart from that the patch is Reviewed-by: Christian König
> <christian.koenig@amd.com>.
>
> Regards,
> Christian.
>
>>    {
>>        struct amdgpu_device *adev = ring->adev;
>>        struct dma_fence *f = NULL;
>>        struct amdgpu_job *job;
>>        struct amdgpu_ib *ib;
>> -     uint64_t addr;
>> -     void *msg = NULL;
>> +     uint64_t addr = ib_msg->gpu_addr;
>>        int i, r;
>>
>>        r = amdgpu_job_alloc_with_ib(adev, 64,
>> @@ -558,8 +557,6 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>>                goto err;
>>
>>        ib = &job->ibs[0];
>> -     addr = amdgpu_bo_gpu_offset(bo);
>> -     msg = amdgpu_bo_kptr(bo);
>>        ib->ptr[0] = PACKET0(adev->vcn.internal.data0, 0);
>>        ib->ptr[1] = addr;
>>        ib->ptr[2] = PACKET0(adev->vcn.internal.data1, 0);
>> @@ -576,9 +573,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>>        if (r)
>>                goto err_free;
>>
>> -     amdgpu_bo_fence(bo, f, false);
>> -     amdgpu_bo_unreserve(bo);
>> -     amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
>> +     amdgpu_ib_free(adev, ib_msg, f);
>>
>>        if (fence)
>>                *fence = dma_fence_get(f);
>> @@ -588,27 +583,26 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>>
>>    err_free:
>>        amdgpu_job_free(job);
>> -
>>    err:
>> -     amdgpu_bo_unreserve(bo);
>> -     amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
>> +     amdgpu_ib_free(adev, ib_msg, f);
>>        return r;
>>    }
>>
>>    static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>> -                                      struct amdgpu_bo **bo)
>> +             struct amdgpu_ib *ib)
>>    {
>>        struct amdgpu_device *adev = ring->adev;
>>        uint32_t *msg;
>>        int r, i;
>>
>> -     *bo = NULL;
>> -     r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
>> -                                   AMDGPU_GEM_DOMAIN_VRAM,
>> -                                   bo, NULL, (void **)&msg);
>> +     memset(ib, 0, sizeof(*ib));
>> +     r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
>> +                     AMDGPU_IB_POOL_DIRECT,
>> +                     ib);
>>        if (r)
>>                return r;
>>
>> +     msg = ib->ptr;
>>        msg[0] = cpu_to_le32(0x00000028);
>>        msg[1] = cpu_to_le32(0x00000038);
>>        msg[2] = cpu_to_le32(0x00000001);
>> @@ -630,19 +624,20 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>>    }
>>
>>    static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>> -                                       struct amdgpu_bo **bo)
>> +                                       struct amdgpu_ib *ib)
>>    {
>>        struct amdgpu_device *adev = ring->adev;
>>        uint32_t *msg;
>>        int r, i;
>>
>> -     *bo = NULL;
>> -     r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
>> -                                   AMDGPU_GEM_DOMAIN_VRAM,
>> -                                   bo, NULL, (void **)&msg);
>> +     memset(ib, 0, sizeof(*ib));
>> +     r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
>> +                     AMDGPU_IB_POOL_DIRECT,
>> +                     ib);
>>        if (r)
>>                return r;
>>
>> +     msg = ib->ptr;
>>        msg[0] = cpu_to_le32(0x00000028);
>>        msg[1] = cpu_to_le32(0x00000018);
>>        msg[2] = cpu_to_le32(0x00000000);
>> @@ -658,21 +653,21 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>>    int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>    {
>>        struct dma_fence *fence = NULL;
>> -     struct amdgpu_bo *bo;
>> +     struct amdgpu_ib ib;
>>        long r;
>>
>> -     r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
>> +     r = amdgpu_vcn_dec_get_create_msg(ring, 1, &ib);
>>        if (r)
>>                goto error;
>>
>> -     r = amdgpu_vcn_dec_send_msg(ring, bo, NULL);
>> +     r = amdgpu_vcn_dec_send_msg(ring, &ib, NULL);
>>        if (r)
>>                goto error;
>> -     r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &bo);
>> +     r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &ib);
>>        if (r)
>>                goto error;
>>
>> -     r = amdgpu_vcn_dec_send_msg(ring, bo, &fence);
>> +     r = amdgpu_vcn_dec_send_msg(ring, &ib, &fence);
>>        if (r)
>>                goto error;
>>
>> @@ -688,8 +683,8 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>    }
>>
>>    static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>> -                                struct amdgpu_bo *bo,
>> -                                struct dma_fence **fence)
>> +             struct amdgpu_ib *ib_msg,
>> +             struct dma_fence **fence)
>>    {
>>        struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
>>        const unsigned int ib_size_dw = 64;
>> @@ -697,7 +692,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>>        struct dma_fence *f = NULL;
>>        struct amdgpu_job *job;
>>        struct amdgpu_ib *ib;
>> -     uint64_t addr;
>> +     uint64_t addr = ib_msg->gpu_addr;
>>        int i, r;
>>
>>        r = amdgpu_job_alloc_with_ib(adev, ib_size_dw * 4,
>> @@ -706,7 +701,6 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>>                goto err;
>>
>>        ib = &job->ibs[0];
>> -     addr = amdgpu_bo_gpu_offset(bo);
>>        ib->length_dw = 0;
>>
>>        ib->ptr[ib->length_dw++] = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
>> @@ -726,9 +720,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>>        if (r)
>>                goto err_free;
>>
>> -     amdgpu_bo_fence(bo, f, false);
>> -     amdgpu_bo_unreserve(bo);
>> -     amdgpu_bo_unref(&bo);
>> +     amdgpu_ib_free(adev, ib_msg, f);
>>
>>        if (fence)
>>                *fence = dma_fence_get(f);
>> @@ -738,31 +730,29 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>>
>>    err_free:
>>        amdgpu_job_free(job);
>> -
>>    err:
>> -     amdgpu_bo_unreserve(bo);
>> -     amdgpu_bo_unref(&bo);
>> +     amdgpu_ib_free(adev, ib_msg, f);
>>        return r;
>>    }
>>
>>    int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>    {
>>        struct dma_fence *fence = NULL;
>> -     struct amdgpu_bo *bo;
>> +     struct amdgpu_ib ib;
>>        long r;
>>
>> -     r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
>> +     r = amdgpu_vcn_dec_get_create_msg(ring, 1, &ib);
>>        if (r)
>>                goto error;
>>
>> -     r = amdgpu_vcn_dec_sw_send_msg(ring, bo, NULL);
>> +     r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, NULL);
>>        if (r)
>>                goto error;
>> -     r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &bo);
>> +     r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &ib);
>>        if (r)
>>                goto error;
>>
>> -     r = amdgpu_vcn_dec_sw_send_msg(ring, bo, &fence);
>> +     r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, &fence);
>>        if (r)
>>                goto error;
>>
>> @@ -809,7 +799,7 @@ int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring)
>>    }
>>
>>    static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>> -                                      struct amdgpu_bo *bo,
>> +                                      struct amdgpu_ib *ib_msg,
>>                                         struct dma_fence **fence)
>>    {
>>        const unsigned ib_size_dw = 16;
>> @@ -825,7 +815,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>>                return r;
>>
>>        ib = &job->ibs[0];
>> -     addr = amdgpu_bo_gpu_offset(bo);
>> +     addr = ib_msg->gpu_addr;
>>
>>        ib->length_dw = 0;
>>        ib->ptr[ib->length_dw++] = 0x00000018;
>> @@ -863,7 +853,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>>    }
>>
>>    static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>> -                                       struct amdgpu_bo *bo,
>> +                                       struct amdgpu_ib *ib_msg,
>>                                          struct dma_fence **fence)
>>    {
>>        const unsigned ib_size_dw = 16;
>> @@ -879,7 +869,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>>                return r;
>>
>>        ib = &job->ibs[0];
>> -     addr = amdgpu_bo_gpu_offset(bo);
>> +     addr = ib_msg->gpu_addr;
>>
>>        ib->length_dw = 0;
>>        ib->ptr[ib->length_dw++] = 0x00000018;
>> @@ -918,21 +908,23 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>>
>>    int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>    {
>> +     struct amdgpu_device *adev = ring->adev;
>>        struct dma_fence *fence = NULL;
>> -     struct amdgpu_bo *bo = NULL;
>> +     struct amdgpu_ib ib;
>>        long r;
>>
>> -     r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
>> -                                   AMDGPU_GEM_DOMAIN_VRAM,
>> -                                   &bo, NULL, NULL);
>> +     memset(&ib, 0, sizeof(ib));
>> +     r = amdgpu_ib_get(adev, NULL, 128 << 10,
>> +                     AMDGPU_IB_POOL_DIRECT,
>> +                     &ib);
>>        if (r)
>>                return r;
>>
>> -     r = amdgpu_vcn_enc_get_create_msg(ring, 1, bo, NULL);
>> +     r = amdgpu_vcn_enc_get_create_msg(ring, 1, &ib, NULL);
>>        if (r)
>>                goto error;
>>
>> -     r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, bo, &fence);
>> +     r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, &ib, &fence);
>>        if (r)
>>                goto error;
>>
>> @@ -943,9 +935,8 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>                r = 0;
>>
>>    error:
>> +     amdgpu_ib_free(adev, &ib, fence);
>>        dma_fence_put(fence);
>> -     amdgpu_bo_unreserve(bo);
>> -     amdgpu_bo_free_kernel(&bo, NULL, NULL);
>>
>>        return r;
>>    }

