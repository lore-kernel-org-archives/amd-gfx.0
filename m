Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66E7C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Dec 2022 23:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE88810E177;
	Mon, 12 Dec 2022 23:45:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B23C010E2AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Dec 2022 23:44:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KadiTSzqeDnHWXxNxngJjvzWGAEczK+Aiw2tBOKwQQTZUleVvzB8pCnPR0wLaFMy0rT9NJ1jHqa3pp5uLIHKunVqIxGl31UIOu069CyoE/GRzxEonf3WMP4FvKqAS1jCVlQMspuAyn70fclPojXKjWojo4rvxdS6AHD56upmFN4fmFjUIfdbip6pJoEsXKY6HeETTCIZnzaeZNeFVngmcansO1Duv0LZmheT5hVnD0vQ8bLPmJXU1pziYq7LpP2KBCKUmmRlJBv1pWP4Aq0VANluZ0vGs/Rc++3HT881z93KHoZz+6EqqOUIyfgL+guoH1R8VnZwdNok3Vy7WwTU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Umvjy0orMjldXN3TLKuCxlBk/+VY4EHn0CQNGzzcmec=;
 b=LYYHy0W1MaMM55k/fc8rN3CZYVT2kVDBaSRStexOQmC8fDcfr6jiyMvtujcwh+pqJu/d1s2eTktw6WYIIgP+EMoOBVDAANPRWgBt4W3zOQVeY4EFU6T+HDydL/DoPpeHm7tcgcaZSEq4XLjpJhcUAmKXXvN8juhev7Vq7CAjkh+vgLTkEmh1NjzT5QgiXX50qfrRvlZ9xB+q4AO2Ncl0K6OqKSwQ1PpnczvSHKavdyo77tcbbFxsPIT7vuijYIhsqBdd5RuJdA5AYmiJKx57z+IdB5Ld8icD20GOo8ckqxO2WYKAfqnx5gdgOceVNdhiQbZ6nvwgjVoxjdsk/EXE5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Umvjy0orMjldXN3TLKuCxlBk/+VY4EHn0CQNGzzcmec=;
 b=supntjGT1N5OqH2Bp9DqibmTraEKmNByvOBiDtuluNuvrfErKkESFfD6MVZZscDZebQjneqpYjSmJU0m1OYZEzxCNciZTgn/Zu2t+MDopCRjx048vjwOAJUkSrBg0sSs+BP1428fKSzddVot4uZbkf8klm+ca3O6UYqzWNKJd1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Mon, 12 Dec 2022 23:44:57 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 23:44:57 +0000
Message-ID: <fe09407d-9057-879b-be61-3bfbe74846db@amd.com>
Date: Mon, 12 Dec 2022 18:44:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20221210092419.16548-1-luben.tuikov@amd.com>
 <20221212174834.36544-1-luben.tuikov@amd.com>
 <802b6283-d015-eb67-18fd-cba6fb03c96a@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: Fix size validation for non-exclusive
 domains
In-Reply-To: <802b6283-d015-eb67-18fd-cba6fb03c96a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::29) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|CO6PR12MB5411:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c09fb38-6524-4e9d-6b3c-08dadc9ae042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqS3PSXFsSnAtC/GFyZfcgdrQa7Uk98qX6CV2TtNx/FceCN1cYvjH0JhUIsIzmbarndaKXX+e5NqzQRzovC0Ov2+NSJjZ3cotbOczoDyDFYmjoxLx2kdJAuAFLo5kmmJDDl4F9vrUYU8eLSx+drNHW/31qLPBK06mIgqqcBqkvKze05hXJ9GfFZLaNqSD/X5itjXxL34990JeTO58JjK0ziCFnLzSTP7jC/dO1hpPxKG4lVfpUhfxfqTCfn95OVfaEhrsz0WEZId4Uf0GUHRiy7tOqJ8f0LbJB+hIJF6wgGvFLTQ3NmeCXzbOd8QumcTBPfMjts3t6Nn4ZeE58hR571KM6yB9zOP25zKD1UVXWZp6z6YG4lGKZNcfRyd07ChOwX+nPX68t/Y9Lm+cf3XSRxZQiH8VF8kiNs6LwW2gJovZr32LaP/QIrXub23Jo+siorDLFDT5hZUBJe9+1unw0rh+/dpeSdzkzyYR9JuC2scU2TCTTjsuA8MPi+uIunxstMgk4Oe9Jch5OJSY4Yz3/nZa+PSxj2EMZLcl74b0C+qPr8P5q3B7ib86uMvjDUlbYCiPv48YbljPuylFyhhUDjwVi3lwwB5yBi15hp5MmcUCJVs2yjtTEtnbHThCM9u2KXKC8PsHZmTosDxw4xFMeWa/y73EieagMcmOUkZ72FoyMjqdlB6bXwimTMNcZEDh0IpNV49+0KcmDso+gpTa7SllHh5gL6BwgyjQTKGTeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199015)(31686004)(4001150100001)(44832011)(2906002)(31696002)(83380400001)(2616005)(86362001)(66946007)(36756003)(5660300002)(8936002)(38100700002)(41300700001)(316002)(4326008)(66556008)(66476007)(8676002)(66574015)(110136005)(186003)(6506007)(478600001)(53546011)(6486002)(6512007)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmFTRDUxeC9xaHZReHlzbXFDN0RWcGlDVnJUN2MxREllNU5xRHd1TWYwelNY?=
 =?utf-8?B?RzVCcVBJSzR1ZE11cllLUHU2TnVWNjZxVHU0TUpNVnN3WG1YNDNiaWFXL3dI?=
 =?utf-8?B?TW90dGRIL3RQMkFGQXM3M3hOaTJDWnFMcklaOE90eEliMkZiWlo1dHhWNHdS?=
 =?utf-8?B?U0lKUG1hV3pVMnlZYnltZmZnVkhwd1VIcmM1WnZKSGI2S1VtZy80dHgrMFBa?=
 =?utf-8?B?cEZwblRTM2VJakFRTlZLbDIwMDRwVTcrdnN0S2Y2R3lNTUdFeXI2ak5udU1m?=
 =?utf-8?B?cS9pQmM4a3dZcEpJQm8vRjBQTmpLQjhpQW9HMHRFQUJrdm9mUE5GalVnWHIx?=
 =?utf-8?B?WkhxUm5XeVQ0QmJ4ZHYxYTJkY3duaCtlbFRWb3ZZMU9YV1VrTHRuRVcrQzdM?=
 =?utf-8?B?UGpHNzNyZm1kL2pHMUQ1L0tMbWVURUhZOEVyQmk2eDhTNkFFaldZSTMvSTNV?=
 =?utf-8?B?OXJpd3BITHpqQmhwTU5YaXRNaUMzaHgwM0JPbFpsWHRKeitsNkF5MTc0ZmIz?=
 =?utf-8?B?clUzdklYNHJyOXc2OGtEMkVITm1MdWlmbnkwM1IrdnBqVm5oUjF6MUlIa0dJ?=
 =?utf-8?B?bUhZQytRVmlpd2doT3pzc2ZVQ3pNMytKVWVNTStCa0lyN1dJbURiWXAvVHI1?=
 =?utf-8?B?NDZyTGhOK2RlNlZXK085RExoSXFBWmJQcW1sQ002OENQNHRscy9PQ29KTzVl?=
 =?utf-8?B?YllGSDZtbzJUQ1VGWkRvN0liQ1c3T1RWWXpoNUphUkYzUGJtell1d2hRVHo3?=
 =?utf-8?B?anBhMGJxV2x3enNhZ1I5Mm5sTDFRQ3FsSEVreFl3YjVPL1VMNWE0YmpHOW5N?=
 =?utf-8?B?RUhsRlAzZk1CVDk5VjIvZDBJdDJLNkI4cE9zWGNQMmZsZllBUUN1NTdjUjV1?=
 =?utf-8?B?SzNoUTBzLzIxVlVVQlZsMTZDTm1hNnpzMjMwVDdsQzJ4SjFFTTBIcWpmL0Uv?=
 =?utf-8?B?aGQycGQ0a2RkRmptbVYwK3B5emhJRUcxTGtvLzgxRjBteFNUeW5JbFJEZ2lZ?=
 =?utf-8?B?ejJSOFYzNkhUcjl1Y3J3WmxWYUNhVUc1S3RwUVl5NS95UFRaY2ZsU3R4Rndx?=
 =?utf-8?B?TlZ4eHRBV0lLUzJwTFlNUXdHc3dRQkhhanpjYlR5Z2QzVGVWU1V6TldiY2Ey?=
 =?utf-8?B?Tng5K0dvWlpHOVZsY2RPZG1xeWR2dHRCQkVBVHhpUHZXdjhtaHcrUkpNem9y?=
 =?utf-8?B?YXRkWCt5dVd1TFdZaFpkOFlLdlVUaFZJN1VHZG8zQStCT0lPZEFYY2JFdmxR?=
 =?utf-8?B?QWRvdFhqbXFidU81NmQvNkdaMFZWdzlldU5EY2dBdjhBTnZPKzdvNUlVUUk4?=
 =?utf-8?B?MlVydS9EdzhMWGNLcTJibFZyTkxZUnZrMG5IZmZkTHhHRVB6V2lCUXpiNlll?=
 =?utf-8?B?b1Bsalp4TGJZSU9QWVpkcitWUUdJbm5VSmtzRFdIaUFLNGRjRlNvbGdWWHFQ?=
 =?utf-8?B?UTZNdTRhYk5yZzJVQmNLZFA1bXYrL2VIcDM3QUtuSHh6MG1PakF5ZU1tT1Ux?=
 =?utf-8?B?WHhwekVBMEZ0YlpZTzNMRjFpWWxaZ0lUZkc3WVQvZGlTaXJYeHhMYXU1SXRG?=
 =?utf-8?B?Z3pFUUtXQWVjMlkzbW5Td3o5Z1N3bGRZQkRwS3FhWXpoa1lDTGh6L1hQNklq?=
 =?utf-8?B?QTRQenlSNnRvSFY3SEVKZC9OT1ZRemF0UnM0VXh4K3E1RXYrOElpRTBvWGNn?=
 =?utf-8?B?RDVQUXN4bGlMZnIrRGN3dTh4dVBFczBhQkxtVDlWQ3htOWc4c1ZqNXB0elNM?=
 =?utf-8?B?cDNuRVQ0dWxkTkIrYnRUUzVBVm9RLy9ockgvTjAzWjBYdzFuc3loZEo3NnZX?=
 =?utf-8?B?V0E3UDFkQWd1SXVqUk82VTgrWTZVMWY3OGNTU3hHTjhlbVNxZ3l4bi90NUNU?=
 =?utf-8?B?aGM0N04yZkQyNWJOeGdHbXUxa0liOTRDcks3VFhaN00yS2lhaFlEeUN0WVlj?=
 =?utf-8?B?cU5pdmx4ZGV4MnlzcWJXTXZTNDJYTlVGYmlHS1Q3MitlRWUrSGpvbmorVW4y?=
 =?utf-8?B?T1FHZDkrVXp3RVV6dis5a0ZoaCt3TmpxMnkza2I2cExhdkJyVzdZS25nVkNW?=
 =?utf-8?B?Z3ZWUDVoU3RoTC81UVBLdEhISGxLTXZmd0ZXRGVKN05TeVRqSWowSnh2QVd4?=
 =?utf-8?Q?SdF9uWkKRxB6dxVdvgGJE1rcS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c09fb38-6524-4e9d-6b3c-08dadc9ae042
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 23:44:57.3901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KluiG8qAaUQJyL1CtteS4VKwVyj9x/3fbwTYxZfHpGmrv0M465KvavKPne0lDCr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5411
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-12-12 14:19, Christian König wrote:
> Am 12.12.22 um 18:48 schrieb Luben Tuikov:
>> Fix amdgpu_bo_validate_size() to check whether the TTM domain manager for the
>> requested memory exists, and to allow for non-exclusive domain allocations, as
>> there would be if the domain is a mask, e.g. AMDGPU_GEM_DOMAIN_VRAM |
>> AMDGPU_GEM_DOMAIN_GTT.
>>
>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19 +++++++------------
>>   1 file changed, 7 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index fd3ab4b5e5bb1f..e0f103f0ec2178 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -448,31 +448,26 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>>   
>>   	/*
>>   	 * If GTT is part of requested domains the check must succeed to
>> -	 * allow fall back to GTT
>> +	 * allow fall back to GTT.
>> +	 *
>> +	 * Note that allocations can request from either domain. For
>> +	 * this reason, check either in non-exclusive way, and if
>> +	 * neither satisfies, fail the validation.
> 
> That's not correct, the original logic was completely intentional.
> 
> If both VRAM and GTT are specified it's valid if the size fits only into 
> GTT.

Given that this patch fixes a kernel oops, should this patch then fail the validation,
i.e. return false?

This would then fail, in amdgpu_ttm_reserve_tmr():

	ret = amdgpu_bo_create_kernel_at(adev,
				adev->gmc.real_vram_size - adev->mman.discovery_tmr_size,
				adev->mman.discovery_tmr_size,
				AMDGPU_GEM_DOMAIN_VRAM |
				AMDGPU_GEM_DOMAIN_GTT,
				&adev->mman.discovery_memory,
				NULL);

Regards,
Luben

