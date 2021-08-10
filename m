Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DD5C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 12:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6442A60EE7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 12:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6442A60EE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7BAF89FC0;
	Tue, 10 Aug 2021 12:13:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 590AC89FD1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 12:13:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfU3c6Bmrco4/9E9fRwMin4fbgoo+rWorOQ/gWU3BgN6baG6oGhEiNjzyvDFIqo+oVdYMn6om+4tcZepqAQvNiJFyB2KBCBjwvNokv27Aa2kRoPBcz3454mziW7F2NIuYtzSgpY0xSpRRSN4cDIqt66ULvqnE1OenUJ6YqJgvrq3YcUUGNx96r8tDOkU9jdw7VHV0chN3G8hpQay6rrzQ30bWGP54bf8vONaGZv1nwhFT+fAe0024T/Dxr4Y200jhDmmz/QEnnRYrpsaXLMYdX0roS+r3ESxdoZPOQop3lMQ14X/F7NDk3eTOxGq8NW6uvaSn9St/m0B73GnWX5aiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E43KIY0wNuP1Ye7bkqJ6c3wte5xdkO8ye+cYEvCTESQ=;
 b=PTBGTbdwi57C7hZGvJMR8t/1MlHE0QTajsq8LEQHRuIooQ5qwqxvns3il/hiPb1aRd4EbI17q/nzglidal9zMxhV8rSSUeWTJfAt9w0WATXr9BBJIMPlCQZOWumEPkO74YElDR3n/scyo8FtWoNzkXmhfh9n6/KUoC9vFOSCyQIiIf0ukwEYoSmGK5jiDZpMCwlO10prhjFnf/fjdOjAxTLx+tNUoOM0/kmUKNcsQdl2tvKiYQ+2gtv74KC1A75RHtlDGH2pdEMrJ4bEgogAOJkszYx+ZaFU1pneIfregMm9gGo1h0utCorjCjY992rHs8YTo+D6OLs9RA/DGG+J2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E43KIY0wNuP1Ye7bkqJ6c3wte5xdkO8ye+cYEvCTESQ=;
 b=W2QuwmW9ADwrQfD7La2P3VaKWUBPdE4s4o08Twqeuv8Npim5bElV3hCPu5WcKu6lEbmkrvhBX+06hrX/EVM3jv1X5x8ofkjkM1nq1ydAGD/mUM1yaIzf5RCObI1PJg0s5GwnWJ1Me7Ug8FcAqE59kawOn+LyFvGcx6v9t/nZGtc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Tue, 10 Aug
 2021 12:13:23 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%3]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 12:13:22 +0000
Subject: Re: [PATCH] drm/amdgpu: handle VCN instances when harvesting (v2)
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: James Zhu <James.Zhu@amd.com>
References: <20210810030313.997451-1-alexander.deucher@amd.com>
 <7630c832-caea-b78d-8e3f-a945a8a5afa9@amd.com>
Message-ID: <12f24be2-1e5b-868b-03d7-751cc2e13252@amd.com>
Date: Tue, 10 Aug 2021 17:43:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <7630c832-caea-b78d-8e3f-a945a8a5afa9@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR0101CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::31) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 BM1PR0101CA0045.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend
 Transport; Tue, 10 Aug 2021 12:13:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9088d48-9236-4a2a-b574-08d95bf83f3e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52378EE87B5D69D214E3534E97F79@BL1PR12MB5237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pa7oJsYSzjRRD0iAv8k7RmXYfDRhgUFbrtnXw1oTYG6wtMJZjT2WmwmG6IWzHWd+1n4w8jHKd/8VYdGIPxtbwklD4HM2cvgbNTgi+qC3z0dS3LnhcIV3J4DuNWYxuim/acgQTrCflq2ZN3awYpzPJRVMoEqNp3BkXeMDyV88MjH3JyvVSmgzLDMtJYMqwosxGoCsXkCyhHjvtYIbNv257SZoAm+xMOp8dUIyD+p4Rm1qpqYMekWZyFbSkYdGpZR/lpRaAgG2k94WJHI0Wqv4TT1VZ1RypAlW8SbDh+FrCX4hBIH+F7kpsyvE9JITLFcRQI9wLwF+E5HnIgdRrdnZ+VIPsnKpwF9S8E3+fLP/GMdkIn9aR9MsvxhndGWSIho1cY/MekG1dlr03yGxuw9tYW/hADncOGVSqLTHKwhIHYsxNdxkzqiu10nKWeOhs0QIdPFZ42+hbi5F09e/q2GjNfweZSmLR3Q35gq2RA4wmEyKcNnje/qmjv2lGnf+Fcr3zo69Fwvk3fQeCtFQDzlWfMlcEV51hjSdszMyoBmw36VE3ZY7mRNSNbU2zrOCaGEv0EnWdAoIliCJco+udI9sQbgTjO2tRXVO3ZKtU+m2ffc8wyr+Osdd/iJRJLZZ9ZBxvCqxIeVRb30lmaK7sxt+PAJAm0vRD2Qv3Q/lznmTSsQYEyZTpowz+7e+AnAuf43c3qJz0xjQC64bLs6PFjrdzPZRMsr/LBpxNPpBhJytpSw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(2906002)(16576012)(26005)(66946007)(478600001)(53546011)(31686004)(316002)(83380400001)(45080400002)(186003)(966005)(8676002)(8936002)(6666004)(5660300002)(6486002)(31696002)(4326008)(38100700002)(36756003)(86362001)(2616005)(956004)(66556008)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGlkSVVpeXVUaDF4WVF2OGNheThIR2lrUU1ySm55WUk2RUJIN1BXajg3T3hC?=
 =?utf-8?B?NFNLeGx2b1ZnR1ZFOGFXM2ErSEhVVUMzL21XOUdHU1ZPVDRUSitFR09TNEdI?=
 =?utf-8?B?elBQOWxWMW5yU0MrYVJTNHJJcnkrYi9OK2xWa2pkSmlleUNFcUQraThNSlpu?=
 =?utf-8?B?OWNFaExxZXYzLzBNek5zcmJQeDdzdmdiSVp3NEw2REFNNlhEZVd1c01yZUxi?=
 =?utf-8?B?WG50Sk9vUEwwVnB0VndSR1M3VFNxeUhjY1ZWaHdsaGZuOGlSdGtpalQ5c2p4?=
 =?utf-8?B?Z0l2WWFBQWlDd1dLbkRIY0VYa3poWFNMSlZqNUp2RjNJR3IxNldmaFVlWEZG?=
 =?utf-8?B?eERidDRob3Bzamh6QXJBeGp1VkZPRTI2NDlMNHp0Um1ZYW0rcDlGQXh3V20y?=
 =?utf-8?B?aDhlbjhVaDJ4QzBBU3hmWklUMjBwSTlZREorRHFrVHRJOFp2WWQ1QVBRcmdr?=
 =?utf-8?B?aUxUL3A3MFhyc3FiWHQ4VEhiK3laRkZNZnhkZFlUMVVMOWdLbmtGSnByQVk0?=
 =?utf-8?B?bTBoVmpEWkZEM3I0UXZBK3JJL2xaSGZ4K1A5Nlgzdlp0bHRTRGtaSTBDRGc2?=
 =?utf-8?B?M3VGaGQzSHRVN0sxa3RyV3VKRUZpR1JmQXN2NG85d1FLMW5mTmdJSVUwell3?=
 =?utf-8?B?THFTSUFUL2hZdXk5Ui82b0pUQzk3OE9zRS9EN29sWGZIaE9mcDRuQ295MnQz?=
 =?utf-8?B?L0dMTTlTNkhBOUcyK0t2S1hOUndSblMxdGgxZFV5aEgxa0lkYTRqMTc2NUlQ?=
 =?utf-8?B?czBpSUV5OHU0N2ZPQzhkMUNRZit2SFdJWDR0amc5cTlEZm1RSDNaRVkzOGVj?=
 =?utf-8?B?U0NRcUppUlNBcFdpRHppcGUyRmV0bUJ6YWtLS1hvQ0lCeW1odmhub2VXRjdk?=
 =?utf-8?B?OWprWHNLQ245dGVjQW5ndmFZMU1mOHdXR1J5TG8zMGNIcUJucTE3MDY2NDVR?=
 =?utf-8?B?SzBqeHZldlBmMkdhTnVMLzZ6bmRwQ3Y3TUNicmRnUFNlUjRiOGp6WkRaVnlW?=
 =?utf-8?B?V2U5ajJqZEZnVVFKdFRYcE1YamNjalE2d3BwamcrRU1kYVZpSjZhZnd4YjdU?=
 =?utf-8?B?eWNIT3NvekRmdElTVnYybGJFNzBlZTFOSjhoMExNWG9zQnRvL0V0NDZ2eGRy?=
 =?utf-8?B?d2QvR2o3ME5Ib2E2LzRJTUQ5TU1Jb2hLbkg2UUxFL2lBcXQ4YVpxOFdWd0ls?=
 =?utf-8?B?SEpBcWlDTmh5MC9odklnZmhiTXBrcjZHbXl0R2tiellXRGdRSXhoREdBc3R0?=
 =?utf-8?B?ZGlQVVFHT01Ccml0TUNjZ2RjY2xKWWJSd202K1VxTXltaUw4aTd4dzRuLzYr?=
 =?utf-8?B?L1JCdHBiS1k4dVNOVmdkdm1TZE9sNWlKU1ZFT2ozSGY3RUZQUTVLTytSdWFV?=
 =?utf-8?B?SWZoa3Zwc0gyUFQxV1l5MW9jWjNJd29NZ1hIYXBWUzlqMk8xUDlBSC9YK2lU?=
 =?utf-8?B?QVMwOFZCY2R1bTJlbjJ2aFozNGRWUkRTaUxwc3lTbnBtbWhKYS9JbmZJcHFY?=
 =?utf-8?B?QVp6WUw3dlRRbm00Nml1L2dza09iaFZXb1czZm1QRjQvaXUrVkk1Zi9IcHli?=
 =?utf-8?B?T0R2b0lzS0FYc0ZsanNBVGdYdEFwUjRyRnhNV3ZQY1JkbVF0bkNZbUVDTEpF?=
 =?utf-8?B?MVg0djc3MjJpSGZPRis3dzBNVjZab2tJTjhSUDkrYnlDYmYvaU51ejZsdjRl?=
 =?utf-8?B?ZW81WnN0NklnNS9ZV1R6dThlVE0yTVNBWEpuUnB6SVFvcmRXSXN5M2tqM2pq?=
 =?utf-8?Q?XKoZLHmn0UywLSYxvAIN79A/ZLZirZx69V7tml+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9088d48-9236-4a2a-b574-08d95bf83f3e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 12:13:22.7567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMCpZ1icJZegUxUR41oCAGifZDw8J4hzXeT4jz5Ig61qmPRvaEJyvKclYz2E0uY4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5237
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

Please ignore the comment. Checked again - num_vcn_inst denotes the 
maximum VCN instances and not the actual number of instances.

Thanks,
Lijo

On 8/10/2021 5:34 PM, Lazar, Lijo wrote:
> 
> 
> On 8/10/2021 8:33 AM, Alex Deucher wrote:
>> There may be multiple instances and only one is harvested.
>>
>> v2: fix typo in commit message
>>
>> Fixes: 83a0b8639185 ("drm/amdgpu: add judgement when add ip blocks (v2)")
>> Bug: 
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1673&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C5c039172e2774c5f712f08d95bf70409%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637641938755361590%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=bQFWRroKIinbe2bBbpe85%2BrpwemUuVYLjB1Gz7keRTQ%3D&amp;reserved=0 
>>
>> Reviewed-by: James Zhu <James.Zhu@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index 43e7b61d1c5c..ada7bc19118a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -299,6 +299,9 @@ int amdgpu_discovery_reg_base_init(struct 
>> amdgpu_device *adev)
>>                     ip->major, ip->minor,
>>                     ip->revision);
>> +            if (le16_to_cpu(ip->hw_id) == VCN_HWID)
>> +                adev->vcn.num_vcn_inst++;
>> +
>>               for (k = 0; k < num_base_address; k++) {
>>                   /*
>>                    * convert the endianness of base addresses in place,
>> @@ -385,7 +388,7 @@ void amdgpu_discovery_harvest_ip(struct 
>> amdgpu_device *adev)
>>   {
>>       struct binary_header *bhdr;
>>       struct harvest_table *harvest_info;
>> -    int i;
>> +    int i, vcn_harvest_count = 0;
>>       bhdr = (struct binary_header *)adev->mman.discovery_bin;
>>       harvest_info = (struct harvest_table *)(adev->mman.discovery_bin +
>> @@ -397,8 +400,7 @@ void amdgpu_discovery_harvest_ip(struct 
>> amdgpu_device *adev)
>>           switch (le32_to_cpu(harvest_info->list[i].hw_id)) {
>>           case VCN_HWID:
>> -            adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
>> -            adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
>> +            vcn_harvest_count++;
>>               break;
>>           case DMU_HWID:
>>               adev->harvest_ip_mask |= AMD_HARVEST_IP_DMU_MASK;
>> @@ -407,6 +409,10 @@ void amdgpu_discovery_harvest_ip(struct 
>> amdgpu_device *adev)
>>               break;
>>           }
>>       }
>> +    if (vcn_harvest_count == adev->vcn.num_vcn_inst) {
>> +        adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
>> +        adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
>> +    }
> 
> If there is only one out of two harvested, I think we should add 
> something like
>      adev->vcn.num_vcn_inst -= vcn_harvest_count;
> 
> at the end to reflect the actual number of VCN instances available.
> 
> Thanks,
> Lijo
> 
>>   }
>>   int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
>>
