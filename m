Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FB4C4321E
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Nov 2022 03:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A7DE10E0A5;
	Sat, 26 Nov 2022 03:19:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EDE010E0A5
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Nov 2022 03:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/rrE04KFh1eGQvxUPvlMY8gQB+PxIOesgSpW5BsT2nyc514BMQcOjfs0UtovqCqmy7L8JpsppLerMeNWa1kwdt9RP90wHRcVDRaHssBCXQYx08HnccQ7n6wo4mNqbiZT+mecgX4yXB00kBpwFQPC4j8UG/BC/rKAEK/t/524TqmllL0qCG/pvpSj5IqYd96JmDtnDMECqpylA5NdF0eFz71oxOWFlTqLtCBy+EwzvuzAtJne2qv1KUEw5ZlGyusudSBql4fMVnSTCf1URfyQEFI33ypeyHTadbj3rXHw0d7YmfgIQV7tuRlmR2lQhvIL6nmTnNwLTUxr4khXmMpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIEnr8ova5MjPKkWHu4tbLrIAZYqCi1Gz4wYlLRNebM=;
 b=ivlfvYwde43o+O91El6ihnPjlveabT4osGxPkEzqcHAsPiOTt26io8NpaN8Oc6gJzdXCbDT5eMC3zSBwPgoViTonraXPbCLnPWKx0zru9L1hXnNGZwPSi2OOF/5NmmiVMKlO7nIzXNsXwXSLGAFe/1vNQtc+jWoffgSZJPYVp5jo0ypU836EKZzK8gKS3B/c1HOh2tW2GNW112C8dPM2+0NjYFEQ4UHPYgaz85NBnEcKVgWRa7aLJbRueG+PIcJF5Kf7CySTEQdtCBB7KMAPQOCVtncmEKC02+g2mrQstSMH6z7lwzT4/4R2HNV8cn4mYR+8J21u1Disi8/HIzGSyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIEnr8ova5MjPKkWHu4tbLrIAZYqCi1Gz4wYlLRNebM=;
 b=yCJkh02/0uOM2rfPNneQ8027ZVpBSBLksNvV4wjs2yAvxznQckAKcag1UTDNcR/Do9F4lIPua7XUzHLJXF7pfxqZ7kuVmbz4Zmxn14BWTcRrLOBrqEobHoIgHBNlY0MC1hVmfRJPvJxl8KmSYGxGDZKgfbWOr3dUH6xfjB6kem4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Sat, 26 Nov
 2022 03:19:49 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5857.018; Sat, 26 Nov 2022
 03:19:49 +0000
Message-ID: <a01c48cc-f8e9-9687-1b9a-95ceeca0920b@amd.com>
Date: Fri, 25 Nov 2022 22:19:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] drm/amdgpu: Fix minmax error
Content-Language: en-CA
To: James Zhu <jamesz@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20221124211956.264282-1-luben.tuikov@amd.com>
 <3333dfb6-cc7b-ff6b-e416-62c07cf62740@amd.com>
 <5319277f-5841-4051-2684-93b3a985197a@amd.com>
 <fc5238a2-b30d-579e-ec7d-3686238f8b12@amd.com>
 <52eed51e-e234-aa36-3d74-3a4f39bb1dad@amd.com>
 <22425c61-9a95-a650-d113-396aa35e52cc@gmail.com>
 <856f03cb-a226-1525-bccb-79bab4c6f6df@amd.com>
 <575b89e1-7960-170f-4a50-89f030f19c52@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <575b89e1-7960-170f-4a50-89f030f19c52@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0048.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::25) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|BL1PR12MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: a069e521-96ea-47de-e575-08dacf5d1384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +DpU48/GgG+5iBEk0I/AZrsRdUpsg5OpHzuLb4wtP2nkgtrBSiy/cUMU4esTsF+YNYAcTJMkew46hIcJtzGcfxZOKEyRxbhmKdi4pCOx6OzEvmFgJSXNEcNPUD6Gwv3fSi1C5Nn0n1Kcag7E3ywBQGElvMqwL0+qZh+mkBtVt79z2KNNlCh3lJ4sxSDj1p7/4QsoHhx6+n6CUxuiGgwsYBCHIC/3XLoaEDB30zjwBOBGew+fTC7ufmaWWNRtheRvOxkGcz9D0dnbiMxj0GI3YUaicRBOd473nq4uLtUsMcTbFMrpyB22OEGpT3nxLyM9SRqiOeoprmjr1rZux2sEwGusuNkv05FWFaXcArQUIWGkPmgVM1RaygoC17p3IXibiHvYR++WzhvzIpSABQXGTXsFwqH+sNUZgax4xY/RUjc3Wc2MDZnuxqKIaIPnuki3mb9sdMll4eZfEkm33y8fXSlLcmcuPtiiy5ILVkpsYqWAYlEQczb/W23rqd5tSAbpEqKYg/wxzBvuuLNt3xKwmW9RCvLaFFS1cTWGmwbc/c0a0YFbCYKZRoky+ptV7OOUnuWHCbQjDlyQiNTkxu61h0OFqYRArAphAAdVOj4Uy4sDtDPEDm2F8qnqj2j86yoQVcrV1ry5vQbFVs0tyEpyl/q/9fsncmkucDFdPOytgpPBnfzR6bAXKQd/Q43w3ISrOpjOO7ZzmC+WK5Fhj52qOl/v+dx4f1N7dUmOFL9RmrVvBV/K0hWOnNDns297L29yxGiu/qKMFDrTnosBD2hh2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199015)(83380400001)(38100700002)(4001150100001)(2906002)(41300700001)(8676002)(4326008)(8936002)(5660300002)(44832011)(26005)(6512007)(6506007)(478600001)(53546011)(186003)(66574015)(2616005)(316002)(66946007)(66556008)(66476007)(54906003)(6486002)(110136005)(31686004)(36756003)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGFsNVRTZTVaNmNjdmhNdXAzTzU3cVRsaGNsdk1jK0ZoVFNZTWhDZThvYmZk?=
 =?utf-8?B?TW9CUGkwcnY3a1lIeE5rZXJVOFZkNGpRK2JPVUN1bVpVU1I1MlJBOFM3OTY1?=
 =?utf-8?B?SHJoTWFVTENtcHhvUFBvRWtXSGJpWlpJZnY3S3FjdmptelZEUCtTeFgrS0RB?=
 =?utf-8?B?NzYrNjhWN2p2TFZrQ1lyQkZ4TWwxVFNXY2xpVmIrM1BRR2tvUVNoamtyMlQ4?=
 =?utf-8?B?QnpxZVJVTGhYY2EyQlN0eVBDcE51VUtISmRwdGtKQUFOa0dDdHZWalBmWG9H?=
 =?utf-8?B?cExSelNUVHlkem9NalozbnJZOG9DcTZzdS9TbmVFeUZlRXc0ZkNRSlNZb05G?=
 =?utf-8?B?ZDdXc0hqaHB0ZlZ1bmxKVEZ5c1lucno2S2VnK3Y2V2dWQlVHajJZYVVvRnM5?=
 =?utf-8?B?OW44b2RKK1hTN3gxa3ptVU5kUWJwUGIrQURUYlBrZk82NGpmb3FEVnVYT0xv?=
 =?utf-8?B?cWNldlVIRUZPWjNYclgyQlFicXZsN3dTMlNCd0dYRzJIUFEzdlFtS0ZNUWpr?=
 =?utf-8?B?bVBrWmdSRHpESkxGK1M3MnVucW9QeFVYYmVZUlFiaWp1dUxnTFFHSTRkNGhC?=
 =?utf-8?B?bFFHbUJ0cWJKNmI2M1YzUGF6TVBraGNBTGZ6cFRsRFNPZnZwczZ5STdHSWE0?=
 =?utf-8?B?b2w4ME9YOHdFaHExWlI3Wmt4aVFyN05VN2dVOG5yUkdvbDN3ajhySkFzTGlQ?=
 =?utf-8?B?L0c4SXdHZXU2c1hMNjUvaDBWZXhoR1BpRWVnV29hYjZ1dGRWTTQwOEk2NThF?=
 =?utf-8?B?Qzh2bkorNWlqZm4ycHlaSU40Q09LdGp2RjIydmU1M2tMNndKZGd4Q2thcUVa?=
 =?utf-8?B?SjF4WGVObEV6OUxoRkJiMkQzSnRtN3dFRDNjdXVRcmFZcklmWElHZEh2d0U1?=
 =?utf-8?B?OEluVHBFRjNvSE54bmNuRXlwSFJ5SXVqcnorOEdwVFhWR3BvWDBrRjlCbmFS?=
 =?utf-8?B?bUhvakxYWW9CSG5rTWtSVk1rMVd4M25UNjVtTGZFZzhZYzNsSXR2Rm9Va2hE?=
 =?utf-8?B?TTAyZ2U1R0t3NlM1WFVoNXNqM21XdytnTHZJRndxUkVuZmpQTzY5bDRNOUVN?=
 =?utf-8?B?bTVlNG5qYVlUUGI3NldLWDFrazRSaUtKZnRkL3V3Nm1XU2JwZHV0YmhpcEpv?=
 =?utf-8?B?OUE2dGRWeUlOYWU0amZ6YmVuMjBnSWdQZWRMQmhvVC9DS0VmZEl1dXhjd3pQ?=
 =?utf-8?B?NTNkZ0x4WFFZcVl0ZDBmOEVIK3I5bSt6bndIRjhUTGZvVFo1b01mQmZJT3lZ?=
 =?utf-8?B?VXYrb2tDNGVxeGI0Y0J2eXVQdm11WXJKclFQUHo3U0pIQ1ZXK0J3WGJONTlF?=
 =?utf-8?B?WEpnRkRweFNIUldibzRia0tRb2JNVzh0dVdmSlBBVVNubFczUGRvZXZoZERT?=
 =?utf-8?B?NFJKQlpLNVhUK2o4T3hZUXRCaGMyUnFQV2kwYmlGS3F2V1h0L1M3VSsrOXcv?=
 =?utf-8?B?RlFjSW40citLUHZaYTdUMWNCMk5yRURPTkFzQndCUnNiSnRMWTNURXQ0ZnhJ?=
 =?utf-8?B?Y0xRZ01wTjVqYTRlM3J3VVBNQmYvMHQzMlZvYTFEcXFDbjFuQWZOaFQvN2ts?=
 =?utf-8?B?aklCaDZDaG9mb1NpNUJjejA5VmNBVVBrcnhZWTdRdmZSdHFYNGVLVGZuVlNq?=
 =?utf-8?B?MzVhRXJNTDRIbVJWVnNidmlJeU4vQkJ6a0ZNZDF5SmJ3OTAvTGNkT29yK3dK?=
 =?utf-8?B?cjM0b0NSNWRDSHZMZ2JXT3pXQ3c0Nlk5SGRTL1JuSC9lZTNiejNqa21LUTFr?=
 =?utf-8?B?V0ttNHdpVW1sTERJUytzZ3NZamI5dHhVZ1hXbThMRzI0dVZGbzRVajhpblZq?=
 =?utf-8?B?dTNhckFTY01hMzZ4dGlyT3V4NDVtWnRVNWljYnJpdFBWUW0rcmtDakdKTHh1?=
 =?utf-8?B?NHJpTkkxOTBmRDNaZjFiOXBscjdBbWFNSWxwUEo0UkNXb1JZRW9qcFZxbWFX?=
 =?utf-8?B?Y3YxN1UxVVh4ZTVXSTZUM0VIRUFQOFhiek1BT045alRTUi9QZDRUcWNnVGxz?=
 =?utf-8?B?dENTaFJpUVFHREd3L2FSUjJEbkJ3aUJtdERFdDFNc1crWjBqck1JU2Mxa0d2?=
 =?utf-8?B?eDBxNWdYYU52RHFSZkxPWU44VC9PMVdEUjM0ajhOMDI1aTZBbG1naGRHcXFW?=
 =?utf-8?Q?tiuoGo7KNkBTJzkcwQsmMVi+h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a069e521-96ea-47de-e575-08dacf5d1384
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 03:19:49.4918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKKW9LrXjaxfp2Ds4PC59MeEazlPy07oJjgGvsJzqjOLQbalYsn972y2bOBgJ6K4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-11-25 16:03, James Zhu wrote:
> 
> On 2022-11-25 14:42, Luben Tuikov wrote:
>> On 2022-11-25 04:57, Christian König wrote:
>>>
>>> Am 25.11.22 um 09:33 schrieb Luben Tuikov:
>>>> On 2022-11-25 02:59, Christian König wrote:
>>>>> Am 25.11.22 um 08:56 schrieb Luben Tuikov:
>>>>>> On 2022-11-25 02:45, Christian König wrote:
>>>>>>> Am 24.11.22 um 22:19 schrieb Luben Tuikov:
>>>>>>>> Fix minmax compilation error by using min_t()/max_t(), of the assignment type.
>>>>>>>>
>>>>>>>> Cc: James Zhu <James.Zhu@amd.com>
>>>>>>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>>>> Fixes: 58170a7a002ad6 ("drm/amdgpu: fix stall on CPU when allocate large system memory")
>>>>>>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 10 +++++++---
>>>>>>>>      1 file changed, 7 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>>>>> index 8a2e5716d8dba2..d22d14b0ef0c84 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>>>>> @@ -191,14 +191,18 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>>>>>>>      	hmm_range->dev_private_owner = owner;
>>>>>>>>      
>>>>>>>>      	do {
>>>>>>>> -		hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
>>>>>>>> +		hmm_range->end = min_t(typeof(hmm_range->end),
>>>>>>>> +				       hmm_range->start + MAX_WALK_BYTE,
>>>>>>>> +				       end);
>>>>>>> Since end is a local variable I would strongly prefer to just have it
>>>>>>> use the correct type for it.
>>>>>>>
>>>>>>> Otherwise we might end up using something which doesn't work on all
>>>>>>> architectures.
>>>>>> They all appear to be "unsigned long". I thought, since we assign to
>>>>>> hmm_range->end, we use that type.
>>>>> Mhm, then why does the compiler complain here?
>>>> Right... so MAX_WALK_BYTE is 2^36 ULL (diabolically defined as 64ULL<<30 :-) ),
>>>> and this is why the minmax check complains.
>>>>
>>>> So, since the left-hand expression is unsigned long,
>>>> i.e.,
>>>> 	hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
>>>> is,
>>>> 	unsigned long = min(unsigned long long, unsigned long);
>>>> The compiler complains.
>>>>
>>>> I'd really prefer MAX_WALK_BYTE be less than or equal to ULONG_MAX,
>>> That's not only a preference, but a must have. Otherwise the code maybe
>>> won't work as expected on 32bit architectures.
>> Well, I don't know what to change MAX_WALK_BYTE to, and given the suggestion
>> below to change to min_t(u64, ...), I wonder if messing with MAX_WALK_BYTE
>> even matters--it wouldn't matter so long as the type in min_t() is u64.
>> It's a macro at the moment.
>>
>> However, the LHS--struct hmm_range's members are all
>> unsigned long and then we're essentially doing (unsigned long) = (u64),
>> which on 32-bit is (u32) = (u64).
> [JZ]MAX_WALK_BYTE can be reduce to #define MAX_WALK_BYTE (2UL<<30)

Hi James--okay, I'll prep up a patch.

Regards,
Luben

