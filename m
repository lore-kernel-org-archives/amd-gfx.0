Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91713C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 13:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D1EF10EE29;
	Thu, 30 Mar 2023 13:33:31 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C5F10EE31
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 13:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z727cb6aPatMy4uskgdMFfUrVLNezNRTsX2X9FA+6u1TKl4HTPHqci/n4R0EOQQExUVdUAij3pPsoo11lypOU8zRP8Y2/7aFWot2JYHEF7qL9iExXSD6ibi/gyUjh7gT1w/31kc4UYbAewS95spKd+rFxb23ApIT+QKQBx67ONU+RsC8V8HLsCIdjK8E+YHQC+kTaESblUOL9C2UOXkFaQok/WcLyWo2sOQz15Z0yhRDEbd1SfRilopY0rbcWVPTL/9wpuoSZywGm/4ExOIULfueJmkDb2u5QvSKaYdx11k4Aeob6Y5afmmXD0yxAWcGaGHtax3T46Lvft9IH3ghgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNeKx7b/HJJO1eB/2F8C4PesNtPrZeiW1AIqMG9GUjc=;
 b=IaoAXPWfe86+2YLgnSN0kpuYEH3+2/p/gknyqbmd/HBTuecua+Nd6BiXeBQsXFyEq52YH2OGPgxrg93QANSK0i811d94gYP8eNGEyX1Kt7zOfrOJmHbmpJqV37xPVqc8bx1HMlUPtqgf+ynIw/w4zE88f9amiVq8jnBmWZ+qvtT3O4dNbwJNev5RnHw5JIJ/2cQFPr7v3OOjhP0sxSWJGk9e874uMg+vtxg6BCCktqYgZgJjTD069FZ9nQGB5h5j30S+jbuo/IgNuOCyREFcgetdrHM0eTgQtxoyanUYNG5/DhvyHbfCIKQjhzE3ikoK1Trfdzt5AzTTXdwGy2GtyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNeKx7b/HJJO1eB/2F8C4PesNtPrZeiW1AIqMG9GUjc=;
 b=LbjmclfRdL7stiAF45AM/JLceSfaUm42QOJGezW+Z8GVjqxVIATij/QDu3yverkx6K5jQXlMWQRZ+d3oRERM+/kVLC66Y0/xUSLefENDMO4fZwlYRBsdC+bEEw0YVbLLrK+IgkpIhqp0QwcP/lPNuFZNWKV1noTKuUHrkqlXsQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 13:33:27 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 13:33:27 +0000
Message-ID: <5c8ca3a9-6f6a-fa4c-0a1e-8dc72a3ea959@amd.com>
Date: Thu, 30 Mar 2023 09:33:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 06/16] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-7-shashank.sharma@amd.com>
 <530dd02b-5b7b-db8c-8cb5-a69d7ea05758@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <530dd02b-5b7b-db8c-8cb5-a69d7ea05758@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0275.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::26) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b2403f2-8464-45d4-68dc-08db31235836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fAqiwfjkvzxK1E14qwCh5coteia4Zlsovq8w6wcJNzrJZglIa8hkb6wUJxqzu1x/Dg7URPGtM8tLo00lnoFHOIVjlfozquuWanWLHShrL4K46NTf+P56mUKlm7kVzz+PrtR45gou7BkxGAp/dfdsLE8M+l1hPX4IAm5StRmaefy7gXi9C05nOM/i3VvdgI1C716h8OuRmySyMIKN0DNs45c8Yumk+1IB4+M6dm9BKdLPbLky4QOJMmGV1oOOuAOvuOgxu5p9cgZaNb4rzmvESWUnUmRfFU5cL4pr/UnkYy8B86tUhV6KU6sWjapZI0aSouTmFXa3ZK2CH9orse1b8wKMHIowFW3JUFTRmAzuGd24k1jWPBHCdqQEwUEJZrXC4E3e1/fNtrj8UHmiO6bkZDVeL6iS78yVBkW1a95IugVlk1lSylpwgAbmNYbR5d+4r36fotPGAO1N4HbSunywpuaKpZpSavcgpMvyEVYMWH0eTCuPeskpWI4SpAoQI3eKcwU7OfLHgohj+VljV4d5blqijXT6Fp2nnQxmMQ5slFQjHC/3NNxfFPsYzsH4deYSkRrb3IdHT8d6CW83lskmQmqDRgMtAimP6H+IMDtBjzZBpS9/a/Ty6ikT1FUSPA8qx6OXxoxIT+i07EBtFQf5J4/ic6G5/+n/IkWHnOnFfciAK/GcUSK3S/7m3ALCpv8u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(6512007)(6486002)(53546011)(6666004)(6506007)(31686004)(26005)(316002)(54906003)(478600001)(110136005)(66574015)(66556008)(8676002)(66476007)(186003)(2616005)(83380400001)(66946007)(41300700001)(8936002)(2906002)(4326008)(5660300002)(44832011)(38100700002)(86362001)(31696002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFpyeHJZUURpc1ZyTnVLN3AyeUwxcEZxYVJsbEZiYXFnRzAyVTlJdk9ubm52?=
 =?utf-8?B?d28rY3FTSHdJTDE4eDgzcGd3R1BHTkExLy9mekd1UHRpNVdsUXdDSVVjOUFy?=
 =?utf-8?B?QTR2Wmt1RnIzMkwxenkxdW9kdFVjZ29lUTE4c2FpaXNOVXlnNmlqTVgxSTVz?=
 =?utf-8?B?WmdFbnRweDZwSDJjNFdzRy92Nkw0b3BPNUpvdEdFNjRXbmU4Q203MlRXeUM5?=
 =?utf-8?B?c25QeVRaUHpmMFg5cGlEN2ZQL1orTnhzTHhCeXpFVFFxWGl3WFhMUzBRS25M?=
 =?utf-8?B?YjBkQndycXpFWDRVeUhjMzN6cUxaWXFBMEVBS3ZZdkMxbWJodld5c05keHlM?=
 =?utf-8?B?b05FVWQxYWpZdUpwdUxvVmJLenZ6R3RCdjlqWDZ5V0tKWlZ5N0h4UnZZQmxC?=
 =?utf-8?B?MS9BcTcwekVXWG9UQjZ2TUM0SHhXRVp5bW50aGFMQVo1dmkrNTdKbEtONFVi?=
 =?utf-8?B?V3RrRm9rTG9iVWExNFBGL09uKzE4aUdjQk5mZS9HRjYxTDFwL1ZEaUNQelZB?=
 =?utf-8?B?dU95MktIVUVxVXc5ZFM5RnpWSEpLWFEzTWVYU1FIUWduNUxzMlFTK2hlbEhS?=
 =?utf-8?B?N2w2MUVnUzY1TzBhYXZsYjE0dFZJQXp1VTR0UkFYdEtST25JK2VFdXo2SzYr?=
 =?utf-8?B?MmdNN2RWNFBNSng4QTE3ZDFnR3BTM1RRME8rcXpmWE5VU3AwMUtTZGN6WU5Y?=
 =?utf-8?B?aGVmVTNmc29iNjFxM2pwZ1M5LzRPajVsZnRpOEZ6bVNKZFdCeS81dVljei9R?=
 =?utf-8?B?SnpwR1BIVDVSbE4vbm9xaHZRK1FUVHNSTGdpcy9uVG8zTnJvK0l4Y0RLRExZ?=
 =?utf-8?B?RkQyUXJlSDRnOWFnOVBsMDlYaGNReEdja1VYMzlLcmxlb3Nla292SEJ4WFR6?=
 =?utf-8?B?VFlmRkNoNjRhMFd4UjREUVhxaWFJaDhtUWJaNlhYYko4bXhCRVNQVXZOa3Bs?=
 =?utf-8?B?SVNITTdMc25LOCs0blIzTnRSck5nV1VrTU1xeFFhN1VTQ3JxNVFVeFNQRSt2?=
 =?utf-8?B?WVI1Uzd5TG5CdzJnQ2tid1NpeGNGUjl5UVJJZndvSDZRRlYycG9iVjJCeWl2?=
 =?utf-8?B?UGdnR1h2Q01GMTFqSlNPaDFKWkNLLzBlSlV0QzNZZ2F3OWtrb1ZrMCswNnVN?=
 =?utf-8?B?amc2VW9sUFRCRmxhWFRBNm9iZkxIRXduTEtJVmdBUnpQbFNYMnNvWXJNK0NJ?=
 =?utf-8?B?OGdKVWhOSHVCTERjWEw0cTVabk1xVVc5dWdNQ3QvQ0o2T0pxaUs5aFNseXpy?=
 =?utf-8?B?ejg5KzN1WmwrWmRrWjhua3dVMVl3bktmb2JyQWozNlg5Sy9BazRlRW1KeWF5?=
 =?utf-8?B?WTBVeUxrQjN4TlpXeFZVb3RXRGt2SGxUclBsa0NlWFZGSUh2TUdBMyt2bjFZ?=
 =?utf-8?B?MzBDdTdyM2swclIweXg3YVRRU3ZNakpldlhoZlI3c3ZUbGQ5ZkNlY2FCRHVH?=
 =?utf-8?B?d3FZQ25QVml0SE8za0NwN2ZYYVJoN2grczFTZVVDUk5MQjFnSjhUenpVQWlZ?=
 =?utf-8?B?dm5ia05Ba2hVS3hXenFkRTBwaHROR0Y1MTdReWMvczdFVXpWbjhzK3dweXpk?=
 =?utf-8?B?MzJ1cEFPNDF3c2t6K3VXYmwxRFJtU2h3ME1DVmR4U2lQazc3QzAxSFdaaVlz?=
 =?utf-8?B?K0VFYkZweFZkaFRlekZoUmNaRE1oRzhaS0FxdENVRS9hVTZUQ21LY0VtRS9v?=
 =?utf-8?B?SEMvOUx6K0JtcDJtdythdzJ1TW5mUlN1NlM4UnJIVWZVcFFBMXkvYUFia1d0?=
 =?utf-8?B?UjUzbDEzMmVHTWFGR1ZGeU54V1BldFhsbytBVVl2cXB0U2lYVTdBdjdnUnhx?=
 =?utf-8?B?YlpZMUF5NnA1NnE1OGtEc3dSeGhxM1NEREZpbXVlVmFQcDc4ck4yekttZVhS?=
 =?utf-8?B?OTFUYzNVZWwwMVhrT2NKekJTUjcyaUhjUU5WYkNqL3ZWVWptWk5UdXBVbWhu?=
 =?utf-8?B?RnB3VDFJcUliVitzMlBmb1M1OThMcnB0ZUdxRFVNOVY1YkVtZFoxT3NsOXNW?=
 =?utf-8?B?QmNCb0FhdzN6VGdLcm1xdlQwNEl1SHdEUVlMcmFjdzgvdzMxcWxJblYzak9m?=
 =?utf-8?B?K2dCYnFHd1hhc3JZUlh3bVZ2ZXVHR0JXVTNuODRGbkNHSDMwNGhmWU94Q3BX?=
 =?utf-8?Q?aKLHhhPOxYtaEDFIDJGF24U8w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2403f2-8464-45d4-68dc-08db31235836
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:33:27.8394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ro15mbujAy21dGczUVU51ddG+lWP6YyKLCndSUJFrbB6m5iCYrlglud17qPCxBwe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-30 07:14, Christian König wrote:
> Am 29.03.23 um 17:47 schrieb Shashank Sharma:
>> From: Alex Deucher <alexander.deucher@amd.com>
>>
>> This patch adds changes:
>> - to accommodate the new GEM domain DOORBELL
>> - to accommodate the new TTM PL DOORBELL
>>
>> in order to manage doorbell pages as GEM object.
>>
>> V2: Addressed reviwe comments from Christian
>>      - drop the doorbell changes for pinning/unpinning
>>      - drop the doorbell changes for dma-buf map
>>      - drop the doorbell changes for sgt
>>      - no need to handle TTM_PL_FLAG_CONTIGUOUS for doorbell
>>      - add caching type for doorbell
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Generally there are no empty lines in the tag list. Perhaps remove it?

Regards,
Luben

>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c     | 11 ++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c        | 16 +++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h        |  1 +
>>   4 files changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 4e684c2afc70..0ec080e240ad 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -147,6 +147,14 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>>   		c++;
>>   	}
>>   
>> +	if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
>> +		places[c].fpfn = 0;
>> +		places[c].lpfn = 0;
>> +		places[c].mem_type = AMDGPU_PL_DOORBELL;
>> +		places[c].flags = 0;
>> +		c++;
>> +	}
>> +
>>   	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>>   		places[c].fpfn = 0;
>>   		places[c].lpfn = 0;
>> @@ -466,7 +474,7 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>>   		goto fail;
>>   	}
>>   
>> -	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
>> +	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU,  AMDGPU_GEM_DOMAIN_DOORBELL */
>>   	return true;
>>   
>>   fail:
>> @@ -1013,6 +1021,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>>   	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>>   		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>>   	}
>> +
> 
> Unrelated newline, probably just a leftover.
> 
> Apart from that the patch is Reviewed-by: Christian König 
> <christian.koenig@amd.com>
> 
> Regards,
> Christian.
> 
>>   }
>>   
>>   static const char *amdgpu_vram_names[] = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
>> index 5c4f93ee0c57..3c988cc406e4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
>> @@ -90,6 +90,7 @@ static inline void amdgpu_res_first(struct ttm_resource *res,
>>   		cur->node = block;
>>   		break;
>>   	case TTM_PL_TT:
>> +	case AMDGPU_PL_DOORBELL:
>>   		node = to_ttm_range_mgr_node(res)->mm_nodes;
>>   		while (start >= node->size << PAGE_SHIFT)
>>   			start -= node++->size << PAGE_SHIFT;
>> @@ -152,6 +153,7 @@ static inline void amdgpu_res_next(struct amdgpu_res_cursor *cur, uint64_t size)
>>   		cur->size = min(amdgpu_vram_mgr_block_size(block), cur->remaining);
>>   		break;
>>   	case TTM_PL_TT:
>> +	case AMDGPU_PL_DOORBELL:
>>   		node = cur->node;
>>   
>>   		cur->node = ++node;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 55e0284b2bdd..6f61491ef3dd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
>>   	case AMDGPU_PL_GDS:
>>   	case AMDGPU_PL_GWS:
>>   	case AMDGPU_PL_OA:
>> +	case AMDGPU_PL_DOORBELL:
>>   		placement->num_placement = 0;
>>   		placement->num_busy_placement = 0;
>>   		return;
>> @@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>>   	if (old_mem->mem_type == AMDGPU_PL_GDS ||
>>   	    old_mem->mem_type == AMDGPU_PL_GWS ||
>>   	    old_mem->mem_type == AMDGPU_PL_OA ||
>> +	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
>>   	    new_mem->mem_type == AMDGPU_PL_GDS ||
>>   	    new_mem->mem_type == AMDGPU_PL_GWS ||
>> -	    new_mem->mem_type == AMDGPU_PL_OA) {
>> +	    new_mem->mem_type == AMDGPU_PL_OA ||
>> +	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>>   		/* Nothing to save here */
>>   		ttm_bo_move_null(bo, new_mem);
>>   		goto out;
>> @@ -586,6 +589,12 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
>>   		mem->bus.offset += adev->gmc.aper_base;
>>   		mem->bus.is_iomem = true;
>>   		break;
>> +	case AMDGPU_PL_DOORBELL:
>> +		mem->bus.offset = mem->start << PAGE_SHIFT;
>> +		mem->bus.offset += adev->doorbell.base;
>> +		mem->bus.is_iomem = true;
>> +		mem->bus.caching = ttm_uncached;
>> +		break;
>>   	default:
>>   		return -EINVAL;
>>   	}
>> @@ -600,6 +609,10 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
>>   
>>   	amdgpu_res_first(bo->resource, (u64)page_offset << PAGE_SHIFT, 0,
>>   			 &cursor);
>> +
>> +	if (bo->resource->mem_type == AMDGPU_PL_DOORBELL)
>> +		return ((uint64_t)(adev->doorbell.base + cursor.start)) >> PAGE_SHIFT;
>> +
>>   	return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
>>   }
>>   
>> @@ -1267,6 +1280,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
>>   		flags |= AMDGPU_PTE_VALID;
>>   
>>   	if (mem && (mem->mem_type == TTM_PL_TT ||
>> +		    mem->mem_type == AMDGPU_PL_DOORBELL ||
>>   		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
>>   		flags |= AMDGPU_PTE_SYSTEM;
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index e2cd5894afc9..761cd6b2b942 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -33,6 +33,7 @@
>>   #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
>>   #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
>>   #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
>> +#define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
>>   
>>   #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
>>   #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
> 

