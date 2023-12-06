Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD86C46CA3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 15:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43DB210E753;
	Wed,  6 Dec 2023 15:27:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7EFC10E753
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 15:27:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNKYC2TJdv1iNwwi2Gkw7UyMHoZE13CZ+zIbq+0Rb80YAtdVRNhzv4qsU0NQUBhjBjdLraYdbCSlNYAagRcfAIIJ8G4h5nAFFVD03D/JuewCi4BbpFHwxiM1qCyiyMSO3XEEkAscskuIpGzB6PxP5KRWX9Bx17Xv0inWM18+wyYOf2ttQ8a3qeZdgRMrsICC/xRxGyV2r446tpso7bddpZdNjht9w3vV/zHeLIJxRur8E51xQEJF+5wSfqUpB+LOm70V5w9ePoZ0wAPq+u2QVKddSQmeiqCHQ5fyIdv+xZf0OBGmgqglZ5PfSOiElg7U7d62WC/VMTJH7JCqZs+f2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRvnmv6KI3KNT3NVY0astJAA1KUIx7vTYVNF0d6pqAc=;
 b=QOl9gKruSz4ak3gPHiKxSbEE+IsLpEA6vwXHYtAz7OPUtMIzWMv7/E7orVIvcSY+S6r04BwU4DTv+Y/Doe0zpi4FJz3J5+PREo45ilnYEbsC1RBXlEW5ySLQCUFpPmJ1sbv04NQdREHuzZ/yOok4RjfjIvU3ZCJmNUk703cpQLxgipdIWeqYkkxSBoGsPHBZN+S8yI0Af4+eipC3vmjTwawLC1tw6ZDuI7pMoK22SK3t3Bk+NPdw9pqkSHfsLJ9smGwJ6AANdQqD9Q8vVtvVV6l5LGlpV4AkjF2kDu0PM5M5+JFOFGFzSH5FM6SVngurP3nTJg3kjXlXwMT9SEcJRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRvnmv6KI3KNT3NVY0astJAA1KUIx7vTYVNF0d6pqAc=;
 b=x/ZOKP3YToGyQ5t5dMvPnmze2/JaC3TiZktOHpKz6Tr5YEUmpmkR2TH9AcsnhV7cYeyX+qKhUahs8a4v7U1M2QMmVdJCWKkrJdPX4H+nBC2U6NtNUpKyV0Ze+5XJjNXRYBFt86ryERzVbcpIwF2Oi96EcZMPcSWC23f35EzRbfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 15:26:55 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::453c:b91b:f673:84bd]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::453c:b91b:f673:84bd%5]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 15:26:55 +0000
Message-ID: <f3bd5268-669f-c8e6-a963-64095b2942a8@amd.com>
Date: Wed, 6 Dec 2023 09:26:52 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] drm/amdkfd: Use partial hmm page walk during buffer
 validation in SVM
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231204202310.23834-1-xiaogang.chen@amd.com>
 <40849594-0ec2-b615-74df-597f5c5c667d@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <40849594-0ec2-b615-74df-597f5c5c667d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0126.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::15) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 006e36b9-460c-487d-4432-08dbf66fc792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kd2ta9jWb4hm1eZoEJsEnr+ADXnHzT/tHh205b+pig0L0F7Su34sVkFt1Lr6VGXrtjj2wUc+Q0NdVj0IC+LVfH863T3jd7kAKQs4aItcDi8y3FErXs7EUnRmFk6WhaUDAquXfY6v3QGgnmTaPtL5LOq5OUthG8HeccOUBGQXCBjWwaXUI9Rj0AdK/Z2rA6lRJolp3aQiJ60yybDizLiJU//TeW9c5rGHWfnPSN761UeXtVyfPEFn85TzlXeyDZe1a+PPJmD2pkosEZJ77wA7cjnWLKnMXLmqKUugwTXAA//Npv8qu7uDyqPP4wrWxd1XOWOPUKVY+ITGtebV8kmubf6B0Mi4i01DD/Ng3Qpv7PCtIwpYV1asoIvKqUyCKMw//yapZQ0s6Y2j5K8PW3n4M9Lj4Kjjs+ArlWcJ6R0JqCAOPQGZhTL4JzgnTkHHZSLVmBf4S9hXKWzOUm/bfrfjz8Ln0qPLOLKJmgnUOZTKque2d8rU3nXrBG5+Y6oR8kd8yscz/3X20wEtUXFTTuR86HS4XiF2KDEE4+wrCai4QcsFFa7TLTnwGMdfIdO0STQTNJ4/Kvyx8ZfqHz8hJAl637d41bF0RqUDpZ8puhW3Ft3vVVr5PAafs+Ro53SZYAmpE8D3hTwLp413M054fLKw7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(6512007)(53546011)(6506007)(8936002)(26005)(6666004)(2616005)(6486002)(66476007)(66556008)(8676002)(66946007)(4326008)(83380400001)(316002)(478600001)(38100700002)(30864003)(36756003)(2906002)(5660300002)(31696002)(86362001)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWYxL2pxWkhBbWtTUFVBUEJKZHpRR01FUjRaZEdpOHNsUXFqUTBxTTE3S2V6?=
 =?utf-8?B?SVFRY3ZnRWYrcWtiYUlXeCtRem4rTEJ3YzA0dTAza0ZiRzVDWHJjeVdVU1Js?=
 =?utf-8?B?WVZIbmRMaU83NE9yVDVDdWJPem8zcCtKblVDRGViWTFyN2NsZG10NU9DZWFm?=
 =?utf-8?B?ZWxGbUVpUmwrYkVwWWE0Ylc4UmxPdzVCSXhGVjZpRzZwK2ozYjBoYUZmTVFO?=
 =?utf-8?B?MEliRWRwaEVyalB1cDJlREN3bmhLWGh2VWRyWXQ1djFET09LeWdEUVdncGdy?=
 =?utf-8?B?eG1vTnF4MGduS2grMG5RbXJ1K0lrVDBDSHhSNjJHd0hqc2dYN3hSVXExYW9q?=
 =?utf-8?B?QmFpVWFDTlFsSzhjQVl2YzI2Y08xYnV5T3lYNHlRdFFycmNHSGM2VmRUZ3lW?=
 =?utf-8?B?YlhpTmZYZnRoNXl6MzJybWYyQTRZRXZLVEFVZHErOHh4VElHbmZFQXQ3Slk0?=
 =?utf-8?B?aGxkcXVvbFpCWTdEbUlsV2k5cWRDc0x0N1RrcWczRnZzcmE2S0oweUtTamEy?=
 =?utf-8?B?RWxFMEZ4TTRvRVl3T3E3STRDWDJMTS9PMjlQN0xNaVJmRlVmSTNIbWhtYUZY?=
 =?utf-8?B?cS9KSkw0clpKbEo0NkJtbHRKNXY2dGpRenVoamdSa0NQVGxFVWxHeXluenhL?=
 =?utf-8?B?QktkZ0o4TWQwQXZEM0xwNWdPTGdIVXVBeStMWGdxeE5QQ1NCUktDSWJYSEhm?=
 =?utf-8?B?OWRKWHJiNDByMUVUT2dRK25FTE15RDdVaWhmVkxEQWZUTHFoSHI0RXlOaURa?=
 =?utf-8?B?dmtWS0MwRmFvS2Y2c25EMjB3OTdicmlKOFhmY1Z1N3ZkdTZmRXV2WmxsRWh6?=
 =?utf-8?B?SmwxaHlNMGVFSDNXRWU2RkFCekY1RWhXSDhJWWFWQmhWbDBjRmh2N2ZtYTRC?=
 =?utf-8?B?dHQzSXhzdlpqVzdiWFZCdytLcXhHaUluV3VnT242bVhVZGhkazNoM2lDKzJt?=
 =?utf-8?B?bFc2RGlGZWhjMGhwT2E1OGQ1RC9iK0phc0FNaUFCdGRiaDJYTW5La0xNWmow?=
 =?utf-8?B?VnJ1ME91a0M4SWdoem5ibSsrZGp0OFhrdU8wcy9MRGRlQk1ndWVZdGMwMVhC?=
 =?utf-8?B?Wmx3NE1oQ21vTGlVeVZEdFRZVThVcmk1NExFOVhtTWw0SmlHMFVhc3kwNG5B?=
 =?utf-8?B?ZmhUcUp4VDRwVisvV2RldUtrRDZqejBsM3Q0bUZwRGZOWDZJT1FNdUNuY1Z5?=
 =?utf-8?B?VGwrY3hneFJBZWU3QTRSUHFWQzM2Q0g0bXZzbU91bTlqakdtMS9YemV5eVlX?=
 =?utf-8?B?VGFlNzBDM1dSL3Y4VmFQSkxzWlMwWnByZTU5YXA5QzkvVldKMlBkMzNzUkM3?=
 =?utf-8?B?aGFPUDdReHlQd2t0bW1JVHpiQXpjWHFPRE0wL1MwcW1IM2VpYjZCcDB6WU1w?=
 =?utf-8?B?cnpOdEdvQnptc0xQd0Z5TG9GSTkrUW9iU2x4ekNJRVh3UHk4MzNRbFV6QTdp?=
 =?utf-8?B?WlkzY0FpNkdzYURRbW9Dc1JacG9laGtSZVZFM1g1T0xHSHpnNnpXQnVLeWxo?=
 =?utf-8?B?Y3VRWkRLREd5Ris2eExBelROODkwVXRTcnYzWWIwRWVPMmtYNWx3WmZ5c2FO?=
 =?utf-8?B?bW1PWWhHZlIrdjNDVmdXRVNrb2lFdSt6RHdmYXpHOHEwZGRlL1NCbVdpRWdh?=
 =?utf-8?B?cVhIVHU3L09DeW9vN1ZsTDJDdzhUMUpUK2lLNkUvbzYrVGJrekM0NUw4V1Vz?=
 =?utf-8?B?SUhiYis0NkVONUVIdlJhSytIaVl4OHRLQWppeWJQengxODJqWkpZWWlTM05O?=
 =?utf-8?B?andkVDJ3THVJS1VWemQyWWN3OThtUXgzZzdEamNyQXhaR0tMS3ZOcHZNc0t6?=
 =?utf-8?B?Y3R5WFFvOXg0clFqSGZZVG1MT1p3RTN2Y3RuTExwRkdTTXdHR2xaTDBlUmZj?=
 =?utf-8?B?aVU0ekVBa2p4ODQ1ak5qaW5sZkI2KzdGbkh6WFZNVmxISUJDelVkdmRCR3VS?=
 =?utf-8?B?MFFBbm9tVjZiOG5CMTQ4eXJEbG5SeXlwNGRwcHp1K0ZWa0NWcmlzTFdKdndD?=
 =?utf-8?B?clBKY0tlREt5NVVNMzRURzZwMmRSVWZodUNMalFLbWRIc1dMclMzWWVnMHRn?=
 =?utf-8?B?REw1QURwNzFWUmtRRUIwRGNFdklMdERkQmkvM0kxMlMyd3dFUDdJN3BBYjd0?=
 =?utf-8?Q?IpiU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006e36b9-460c-487d-4432-08dbf66fc792
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 15:26:55.5393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3BgOcEFRhxkOGnqnjCPL5s6v1UpdJkhKet9X+UrxZxsvvB4lRgAfZ0+YtV90u9r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735
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
Cc: Philip.Yang@amd.com, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 12/5/2023 12:48 PM, Philip Yang wrote:
>
>
> On 2023-12-04 15:23, Xiaogang.Chen wrote:
>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>
>> v2:
>> -not need calculate vram page number for new registered svm range, only
>> do it for split vram pages.
>>
>> SVM uses hmm page walk to valid buffer before map to gpu vm. After have partial
>> migration/mapping do validation on same vm range as migration/map do instead of
>> whole svm range that can be very large. This change is expected to improve svm
>> code performance.
>
> Seems we could calculate old, new prange->vram_pages inside 
> svm_range_split_pages, using dma_addr & SVM_RANGE_VRAM_DOMAIN to 
> decide if it is vram or system memory pages. This will cover both 
> unmap from cpu and set_attr to split range cases, Thet the new 
> function svm_range_vram_pages is not needed.
>
ok, I use dma address to calculate split svm range vram page number, 
kfdtest passed. The new v3 patch includes it.
>
> prange->vram_pages update after migrating to vram should use mpages, 
> not cpages, the total collected pages.
>
It is from original code that used cpages as mpages. I think 
svm_migrate_successful_pages does not give correct migrate page number, 
then the original code used cpages. I updated this part by using 
svm_migrate_unsuccessful_pages, then mpages = cpages - 
svm_migrate_unsuccessful_pages(&migrate). The new v3 patch also includes 
this change. Please review it.

Regards

Xiaogang

> Regards,
>
> Philip
>
>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 149 ++++++++++++++++++++-------
>>   1 file changed, 109 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 2834fb351818..2f14cd1a3416 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -158,13 +158,12 @@ svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
>>   static int
>>   svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>>   		      unsigned long offset, unsigned long npages,
>> -		      unsigned long *hmm_pfns, uint32_t gpuidx, uint64_t *vram_pages)
>> +		      unsigned long *hmm_pfns, uint32_t gpuidx)
>>   {
>>   	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
>>   	dma_addr_t *addr = prange->dma_addr[gpuidx];
>>   	struct device *dev = adev->dev;
>>   	struct page *page;
>> -	uint64_t vram_pages_dev;
>>   	int i, r;
>>   
>>   	if (!addr) {
>> @@ -174,7 +173,6 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>>   		prange->dma_addr[gpuidx] = addr;
>>   	}
>>   
>> -	vram_pages_dev = 0;
>>   	addr += offset;
>>   	for (i = 0; i < npages; i++) {
>>   		if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
>> @@ -184,7 +182,6 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>>   		if (is_zone_device_page(page)) {
>>   			struct amdgpu_device *bo_adev = prange->svm_bo->node->adev;
>>   
>> -			vram_pages_dev++;
>>   			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
>>   				   bo_adev->vm_manager.vram_base_offset -
>>   				   bo_adev->kfd.pgmap.range.start;
>> @@ -201,14 +198,14 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>>   		pr_debug_ratelimited("dma mapping 0x%llx for page addr 0x%lx\n",
>>   				     addr[i] >> PAGE_SHIFT, page_to_pfn(page));
>>   	}
>> -	*vram_pages = vram_pages_dev;
>> +
>>   	return 0;
>>   }
>>   
>>   static int
>>   svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
>>   		  unsigned long offset, unsigned long npages,
>> -		  unsigned long *hmm_pfns, uint64_t *vram_pages)
>> +		  unsigned long *hmm_pfns)
>>   {
>>   	struct kfd_process *p;
>>   	uint32_t gpuidx;
>> @@ -227,7 +224,7 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
>>   		}
>>   
>>   		r = svm_range_dma_map_dev(pdd->dev->adev, prange, offset, npages,
>> -					  hmm_pfns, gpuidx, vram_pages);
>> +					  hmm_pfns, gpuidx);
>>   		if (r)
>>   			break;
>>   	}
>> @@ -982,11 +979,6 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
>>   	new->svm_bo = svm_range_bo_ref(old->svm_bo);
>>   	new->ttm_res = old->ttm_res;
>>   
>> -	/* set new's vram_pages as old range's now, the acurate vram_pages
>> -	 * will be updated during mapping
>> -	 */
>> -	new->vram_pages = min(old->vram_pages, new->npages);
>> -
>>   	spin_lock(&new->svm_bo->list_lock);
>>   	list_add(&new->svm_bo_list, &new->svm_bo->range_list);
>>   	spin_unlock(&new->svm_bo->list_lock);
>> @@ -1107,9 +1099,9 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
>>   
>>   static int
>>   svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
>> -		     struct list_head *insert_list, struct list_head *remap_list)
>> +		     struct list_head *insert_list, struct list_head *remap_list,
>> +		     struct svm_range *tail)
>>   {
>> -	struct svm_range *tail;
>>   	int r = svm_range_split(prange, prange->start, new_last, &tail);
>>   
>>   	if (!r) {
>> @@ -1122,9 +1114,9 @@ svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
>>   
>>   static int
>>   svm_range_split_head(struct svm_range *prange, uint64_t new_start,
>> -		     struct list_head *insert_list, struct list_head *remap_list)
>> +		     struct list_head *insert_list, struct list_head *remap_list,
>> +		     struct svm_range *head)
>>   {
>> -	struct svm_range *head;
>>   	int r = svm_range_split(prange, new_start, prange->last, &head);
>>   
>>   	if (!r) {
>> @@ -1573,7 +1565,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   	struct svm_validate_context *ctx;
>>   	unsigned long start, end, addr;
>>   	struct kfd_process *p;
>> -	uint64_t vram_pages;
>>   	void *owner;
>>   	int32_t idx;
>>   	int r = 0;
>> @@ -1642,15 +1633,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   		}
>>   	}
>>   
>> -	vram_pages = 0;
>> -	start = prange->start << PAGE_SHIFT;
>> -	end = (prange->last + 1) << PAGE_SHIFT;
>> +	start = map_start << PAGE_SHIFT;
>> +	end = (map_last + 1) << PAGE_SHIFT;
>>   	for (addr = start; !r && addr < end; ) {
>>   		struct hmm_range *hmm_range;
>>   		unsigned long map_start_vma;
>>   		unsigned long map_last_vma;
>>   		struct vm_area_struct *vma;
>> -		uint64_t vram_pages_vma;
>>   		unsigned long next = 0;
>>   		unsigned long offset;
>>   		unsigned long npages;
>> @@ -1677,13 +1666,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   		}
>>   
>>   		if (!r) {
>> -			offset = (addr - start) >> PAGE_SHIFT;
>> +			offset = (addr - (prange->start << PAGE_SHIFT)) >> PAGE_SHIFT;
>>   			r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
>> -					      hmm_range->hmm_pfns, &vram_pages_vma);
>> +					      hmm_range->hmm_pfns);
>>   			if (r)
>>   				pr_debug("failed %d to dma map range\n", r);
>> -			else
>> -				vram_pages += vram_pages_vma;
>>   		}
>>   
>>   		svm_range_lock(prange);
>> @@ -1716,19 +1703,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   		addr = next;
>>   	}
>>   
>> -	if (addr == end) {
>> -		prange->vram_pages = vram_pages;
>> -
>> -		/* if prange does not include any vram page and it
>> -		 * has not released svm_bo drop its svm_bo reference
>> -		 * and set its actaul_loc to sys ram
>> -		 */
>> -		if (!vram_pages && prange->ttm_res) {
>> -			prange->actual_loc = 0;
>> -			svm_range_vram_node_free(prange);
>> -		}
>> -	}
>> -
>>   	svm_range_unreserve_bos(ctx);
>>   	if (!r)
>>   		prange->validate_timestamp = ktime_get_boottime();
>> @@ -2037,6 +2011,81 @@ svm_range_split_new(struct svm_range_list *svms, uint64_t start, uint64_t last,
>>   	return 0;
>>   }
>>   
>> +static int
>> +svm_range_vram_pages(struct svm_range *prange)
>> +{
>> +	unsigned long start, end, addr;
>> +	struct svm_range_list *svms;
>> +	struct kfd_process *p;
>> +	struct mm_struct *mm;
>> +	struct page *page;
>> +	int32_t gpuidx;
>> +	void *owner;
>> +	int r = 0;
>> +
>> +	prange->vram_pages = 0;
>> +	svms = prange->svms;
>> +	p = container_of(svms, struct kfd_process, svms);
>> +	mm = get_task_mm(p->lead_thread);
>> +	if (!mm) {
>> +		pr_debug("svms 0x%p process mm gone\n", svms);
>> +		return -ESRCH;
>> +	}
>> +
>> +	/* prange->actual_loc should not be 0 here */
>> +	gpuidx = kfd_process_gpuidx_from_gpuid(p, prange->actual_loc);
>> +	if (gpuidx < 0) {
>> +		pr_debug("failed get device by id 0x%x\n", prange->actual_loc);
>> +		return -EINVAL;
>> +	}
>> +	owner = kfd_svm_page_owner(p, gpuidx);
>> +
>> +	start = prange->start << PAGE_SHIFT;
>> +	end = (prange->last + 1) << PAGE_SHIFT;
>> +	for (addr = start; addr < end; ) {
>> +		struct hmm_range *hmm_range;
>> +		struct vm_area_struct *vma;
>> +		unsigned long next = 0;
>> +		unsigned long npages;
>> +		bool readonly;
>> +
>> +		vma = vma_lookup(mm, addr);
>> +		if (!vma) {
>> +			mmput(mm);
>> +			return -EFAULT;
>> +		}
>> +
>> +		readonly = !(vma->vm_flags & VM_WRITE);
>> +		next = min(vma->vm_end, end);
>> +		npages = (next - addr) >> PAGE_SHIFT;
>> +		r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>> +					       readonly, owner, NULL,
>> +					       &hmm_range);
>> +		if (r) {
>> +			pr_debug("failed %d to get svm range pages\n", r);
>> +			mmput(mm);
>> +			return r;
>> +		}
>> +
>> +		for (int i = 0; i < npages; i++) {
>> +			page = hmm_pfn_to_page(hmm_range->hmm_pfns[i]);
>> +			if (is_zone_device_page(page))
>> +				prange->vram_pages++;
>> +		}
>> +
>> +		if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
>> +			pr_debug("hmm update the range, need validate again\n");
>> +			mmput(mm);
>> +			return -EAGAIN;
>> +		}
>> +
>> +		addr = next;
>> +	}
>> +
>> +	mmput(mm);
>> +	return 0;
>> +}
>> +
>>   /**
>>    * svm_range_add - add svm range and handle overlap
>>    * @p: the range add to this process svms
>> @@ -2109,6 +2158,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>   			 * will change. Clone and split it, apply updates only
>>   			 * to the overlapping part
>>   			 */
>> +			struct svm_range *head, *tail;
>>   			struct svm_range *old = prange;
>>   
>>   			prange = svm_range_clone(old);
>> @@ -2123,18 +2173,37 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>   
>>   			if (node->start < start) {
>>   				pr_debug("change old range start\n");
>> +				head = NULL;
>>   				r = svm_range_split_head(prange, start,
>> -							 insert_list, remap_list);
>> +							 insert_list, remap_list, head);
>>   				if (r)
>>   					goto out;
>>   			}
>>   			if (node->last > last) {
>>   				pr_debug("change old range last\n");
>> +				tail = NULL;
>>   				r = svm_range_split_tail(prange, last,
>> -							 insert_list, remap_list);
>> +							 insert_list, remap_list, tail);
>>   				if (r)
>>   					goto out;
>>   			}
>> +			/* cal each inserted svn pragen vram_pages */
>> +			if (prange->actual_loc && prange->ttm_res) {
>> +
>> +				if (head) {
>> +					r = svm_range_vram_pages(head);
>> +					if (r)
>> +						return r;
>> +					prange->vram_pages = prange->vram_pages  - head->vram_pages;
>> +				}
>> +
>> +				if (tail) {
>> +					r = svm_range_vram_pages(tail);
>> +					if (r)
>> +						return  r;
>> +					prange->vram_pages = prange->vram_pages - tail->vram_pages;
>> +				}
>> +			}
>>   		} else {
>>   			/* The node is contained within start..last,
>>   			 * just update it
