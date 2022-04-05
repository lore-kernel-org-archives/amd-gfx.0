Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B42CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Apr 2022 06:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDE7110EDC1;
	Tue,  5 Apr 2022 06:55:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE22410EDC1
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Apr 2022 06:55:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUbJUGMNf+NXsrY/SEdoypKHRlzN33kWtxMPINAn9NbJ4TKSFCyTNf2jUY0P33pCSGJb/mRQtHyOhmvt0ML/2pJsOss5vSAmjmI7VwjhJbr7uuUFmy0xdxSx7MWc4+wlGzgEFsXigWwgznK9n6Ok166N3dppRXjyEn3S6dNszVRd/TXVMgEx3RAskp6R2utyB9iRRgpAU8obKo4y3/E6wyTqmabPf/Pv39IapQI0Ui2cTuDzD3NbJqzLIByyeyEQIv39FIe2vQQ3Jx0WZa4aUkGt1iifqkUR0wAmvApySeUbhJORZ91rb0pQodW6AH6cwZtT4mtTQR7qnWArCO4vow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hFIuZairNTZxIqlqfBsuql/s3jzigDlVPZ/5FGJTO8=;
 b=dQitVH32XdopXghjd5flISNHLsLbiJSd0M3FoDSt+9RDKEsXZV8R4Z+QsxtmaMYytlgvgaxLY92x9YWQMihwOZGbVP3obCJ5PvPBQk6zLuwe3pl2e5phu4S2D1YGaqEThoYjsH7LAgyNgO9OZ6EOamwrTwRsdSypHMNjfBY4TYN0qnV/PeZ+pCR5A8v8gTLo4Zk3+5mDnLgKl3pt+Ujddok6nwGEtJ+jODKU07qfvJx4rVZ3bOKa740HUAnGRcbV/9LbR4neOEWqVai/XpamnkWoZeKdur2NDgPFFeojNYKMFgpUPtvd4ADE7GfRlAICIK/ycwnRO8Fe+H7zo9DH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hFIuZairNTZxIqlqfBsuql/s3jzigDlVPZ/5FGJTO8=;
 b=EDszrrOwS52Ls8cH3BjmAooIzqVDA7bxWoLHqSpgzQAMd5RHHIl4cwnj9wOJ859F4n2pV8dr4Rg7PfI3RieM4J2CYcSGteMtMMNRpJMw454JslCs3xUJgCK8SgfW3ZvE7ZvZqEELRnh4F3C9PGYa6j7PMloFcSJglupwiqn8rlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB4839.namprd12.prod.outlook.com (2603:10b6:610:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Tue, 5 Apr
 2022 06:55:04 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 06:55:04 +0000
Message-ID: <530f3735-9a82-54af-c090-cc8d5b1510cc@amd.com>
Date: Tue, 5 Apr 2022 08:54:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] drm/amdkfd: Add missing NULL check in
 svm_range_map_to_gpu
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>, Philip Yang <Philip.Yang@amd.com>
References: <20220404214255.11902-1-Philip.Yang@amd.com>
 <7a0e9d4c-257f-287e-9caf-f4161887ba39@molgen.mpg.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <7a0e9d4c-257f-287e-9caf-f4161887ba39@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0157.eurprd06.prod.outlook.com
 (2603:10a6:20b:45c::32) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fea4a39-7b09-4f4d-2621-08da16d13678
X-MS-TrafficTypeDiagnostic: CH2PR12MB4839:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4839742CE7A4925F5D3ABCF283E49@CH2PR12MB4839.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTHN+tZJtpk9VUkB4+CPqGGX8evZrRKHu5s+/ocj6k9FvdQHpF/rbrmsx1IX1aEHZWNr1JBjxVdRwAoEOjQ8pK03nidhXDQZFxhCe4eKCcZStj0ChckjuuXe6VIS4ZL5Xx7TbqA6ETpMGq+ABKbg0DV5P7xxZLRwGcaO+Q+ksk42x7KYa6ofvYiLiyG+lNV/nIaBq6hes2RQfJbVg0BB3R7EeX+O7w9HrXPnIyhbYFfn1A03gy4j4cxJ1ngwDdkmcL7hdxG+jsazhVPJ0yD6Va/6c2+q4zuX42xYni/6wn2px+tpwrzd28NnDHbHyz7zvgfLVewfgihkTpb2XCTTlo+cIt+21ib6ZY8Xv9+Chuxb53cH2sdivIY76H9N2nJnXpvhZtF5DFtsI3bma5Z6OzP0d+kXYqeAS91Q0ALYDMkZlAI3FKhp3yE/fjvOpiOaPdTXR7UofzD27ncV3nh/u6/TMVdp1Vq+VABTQuvlPLrH+bEBFjY4jsA8OTyRmo6q4koHYi9O12cv8sOx+i64B2ONK3ivfxZBa06jts9o0ciugaBbrnEyw/mNB+W7Gp5hrhzL7Vrk1bfEBtqxAQjcgvZcwYay6e2WMAwiZydU1lKXi2yLK2oRxLggHc37Ja424CvBmJwQlhzSNptcSPl+w/emTI1kYaL11Nud4w/XVwIf5Vf7J+Np/hyx12rs9j1vbGU0wzkrxVJyN8bd9cfswD++YW+deWdNrZ4wpH1FRt+Lc9CWf8hgE/rLyTy2+9jZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(31686004)(83380400001)(4326008)(8676002)(508600001)(6666004)(6486002)(6506007)(36756003)(6512007)(186003)(2616005)(6636002)(86362001)(8936002)(110136005)(38100700002)(66946007)(66476007)(66556008)(316002)(31696002)(5660300002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFRZMHd3ZUh4aml0cWF6bU94NDlBU005T0p2by9Pb05Bc3BFUmw5SEE0Mity?=
 =?utf-8?B?b0VNZWNCa0RacU9XM0QxcTU4MkI0SFc3RVVKNVJuWm9WdFBUN3ZBdHU0NUY3?=
 =?utf-8?B?dmNOZkpXcWhZaVpyUFplYUJTNHZoaVdFSWZHTEp2QXM1V1pvRlU1MXliVzFs?=
 =?utf-8?B?b2lVT3htZkt0ZE9Pd0x6Q3lLRG5vbzJwMTlleGlKRUovL0svZ0ZLYXdYRWh3?=
 =?utf-8?B?MjVMMmZXUVR1ck9NU3RKd0dKOWQ1NWJsQU15UEQ4aE5HQlE0QllTZ1lPY0pt?=
 =?utf-8?B?OUh3V1F4Sm55bEdFME5YVnpBb0NsSm9TekxqYSs0OFZaejFwY0RaUk9DdjFx?=
 =?utf-8?B?TEkyVHluTitHcDA2OW9keWpmN2xmQVZOcWNCMW5BZ1p5NEh1elNaM0oxQmsy?=
 =?utf-8?B?L3pjd0hwOUVFSWlPZ2JUK2haeDNCb1NqMnBHVy9WYXNlL2FJWCt0OXlRRkwx?=
 =?utf-8?B?TGY3ajFPaDZVS2RrV1lQa3pkUEJzdGxIMHZwT0w5SFJnZXUxSm93cHN0V2py?=
 =?utf-8?B?VVJUSTIydFpIaGxIZVlsQ3UrSUZDOEtSQ25STDFMSWJ0YmhBUHI3Y2NweThK?=
 =?utf-8?B?VFNrVFNoVC9MUmxoTms0QXRNcGloS2oydGhLdjNzSlQzVStPbzhvblJ5cTlo?=
 =?utf-8?B?OW9ma01SWmtlQmNQQTRiUkhvODNDdzJOaEZRaFJFODJSMC84UmVJSEZMVGNX?=
 =?utf-8?B?MWlpTTR6M2NRSWRnalpmSHBWRGJ2a2hxMEpDMzlpSzlOdlQ3cG14WU5yVkZP?=
 =?utf-8?B?ZnQwcCtnN2ZmVHBwZ2V4VXd4UGgzRmZUbE5aQzd1M01nWFdMWlZVcThnZjkw?=
 =?utf-8?B?TkZsNVdURWl6UkJDUkFVVi9najhWMDBOYmxOLytEUXBybTJ4dTVnSGNib0tn?=
 =?utf-8?B?ZXFDZUtDWmZtakVqdzJ6VlNoaW1PL0x4aVBqSDh3bVlLOVhQRjVHbWN2ekJq?=
 =?utf-8?B?WTZGZGkyZ0lZM3JSZjduL0hHNmprcy96Z2l6UzUrcG1pY0VGR3RBQ2tnTDRV?=
 =?utf-8?B?TCtXMU52NExqd0UyT0tzTVRBVHhpTVIxb3FiVlJVNks1LzBxS21IR3pJNEhN?=
 =?utf-8?B?bCtabVR4cjI1eExwci9iekhlZzV4Vk44b0RzRHhwYlYwK1FsQW5lbERMVDls?=
 =?utf-8?B?Tk1FTEg5MHpMU2xvZXBqT1dvVUpYdE1KMnZBOW11a2pVdnY3RGRCS1RrbFRv?=
 =?utf-8?B?cnhpWWhwaGVJK01jRVNYbWVxR1FiQ0RBN0d4VldRb1VrdnVQR1VEdjdXdDVm?=
 =?utf-8?B?OWJZZWxRTnYzeUh4RE1ESFduSDIreXQrMFRmVXN0NnErS0swcC82bk9VVENw?=
 =?utf-8?B?VUZORWVGYlF0alM1WC9UWDdMbkNNN2N4TVBzUysrNWFRek1tYmpISnUwM2pw?=
 =?utf-8?B?OEFOZFVkYWNZa1FXY0NXcFBlK1gyK3Nja0RpL1FXSHd2RGpqN0t2blhqWDFH?=
 =?utf-8?B?M2UvTmVQZHpHVVp0M2FGMTRTVFJoLzRJemtrYU93TTFjbzhNdTJZNklBVHQw?=
 =?utf-8?B?Y0FkcTQyanoyWXp1VjA1MzFoMlNlbG9vTm5PbGFuWmVXKzhGZDU1bDFnUWtC?=
 =?utf-8?B?MEIwVEhycFcrS2FtMWFnWmMzdTRveEJpWWRTK1IyTjc2MHZWbGx1Z281YWh0?=
 =?utf-8?B?R281cnlkRlgzUXVtaTlpRFdKTTh5RnY2RkZGU0FqVGlxNHJPNHgzbkxRVWxQ?=
 =?utf-8?B?bnpPQUczdnQ1NFZ2dk5lUUUzTUUzRHNoWHhuVUdUY2tSRGVLQlN6VlFMa2Ex?=
 =?utf-8?B?Um53eUpFTHZwRHFjKzBwbklKaWYzR2ZyZEk4NDZtbFQzQklUTkJFTDIvTlcv?=
 =?utf-8?B?V2dBV1VHN3hldmUyUExvYy93SHBqc09EZml0a2o0MWI4WUxDbW1LV3Z3SGY2?=
 =?utf-8?B?c3NaVngxVFlhTzNoRGpnU29lZ3FoU1ZCcmQrRkxOUlNSNkdJaGcyMWp6ZEZk?=
 =?utf-8?B?REpDZXVGODRRdklJZFBVZ1VpcEJDQlNQSHp1QXl2OStmb2ZHOFVYVkdDMXVC?=
 =?utf-8?B?aWcxS25OdG1MbFdLZUI4Z3g3Ti9MWCt3N3VydmxaRGJFU0E1WVp0M2sveGFL?=
 =?utf-8?B?Z09TOHA0VHlwREVKNFpzWUUzRzN4STI4bUh5RUh5QVIzL3VwbzNNWWlaQjJa?=
 =?utf-8?B?dGtuT2lxVk91dGZXbjlPa0tQR3ZCTWVPQStlUXZvQ2Y5dUd2N0JwRWZiSFNC?=
 =?utf-8?B?WXR2SEZkb1dMZThySk96ZlBqODNwOXl3QjRMaXdnRDcxZXpVQ1ZsSGQxdmx6?=
 =?utf-8?B?dE15QVhZQStvTGk2N1hzMG92UFlLNGhVY0lOejJCU1BPTm9KaUNxR3FyeGhY?=
 =?utf-8?B?OGZsSGdQT0ZBMGFFd25JWVpqcFJpZDFhTEh3QXZiRmpBR0JvRUdlUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fea4a39-7b09-4f4d-2621-08da16d13678
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 06:55:04.5728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/JY0ERGDH555SOPaHkWTCVLf7L0tbX/io1bL4zjvbZDrFmTuSQTOIUeAfUSM9PL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4839
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.04.22 um 08:45 schrieb Paul Menzel:
> Dear Philip,
>
>
> Am 04.04.22 um 23:42 schrieb Philip Yang:
>> bo_adev is NULL for system memory mapping to GPU.
>>
>> Fixes: 05fe8eeca92 (drm/amdgpu: fix TLB flushing during eviction)
>
> Sorry, where can I find that commit?

Well that's expected, the development branch is not public.

Regards,
Christian.

> I do not see it in drm-next from agd5f git archive 
> git@gitlab.freedesktop.org:agd5f/linux.git.
>
>     $ git log --oneline -1
>     e45422695c19 (HEAD, agd5f/drm-next) drm/amdkfd: Create file 
> descriptor after client is added to smi_clients list
>
>
> Kind regards,
>
> Paul
>
>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 907b02045824..d3fb2d0b5a25 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1281,7 +1281,7 @@ svm_range_map_to_gpu(struct kfd_process_device 
>> *pdd, struct svm_range *prange,
>>                          last_start, prange->start + i,
>>                          pte_flags,
>>                          last_start - prange->start,
>> -                       bo_adev->vm_manager.vram_base_offset,
>> +                       bo_adev ? 
>> bo_adev->vm_manager.vram_base_offset : 0,
>>                          NULL, dma_addr, &vm->last_update);
>>             for (j = last_start - prange->start; j <= i; j++)

