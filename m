Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB77C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 07:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF856109F
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 07:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BCF856109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 703476EB69;
	Thu,  4 Nov 2021 07:58:39 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3F386EB69
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 07:58:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIYAe7O8Q0Xyucb1OqASbW4SfT4PUc5Rzlv6I3XqMh/7QATzjm6U+MEVPESo5tt/m4c30mATYpjYiOQFJKiKGod36h4b/sitvckNnRI5ejZ2KXZeYmynxbnU5saM6LkE1CORtL8tpSJPFIRsKmcoO2T2epxPnnX7T4OujT1S1wscJpNofCTlvZS1Tu7fiPEwfV0/8B8prn8wd8xi9PeQnD/RUbg4+JsV3lcy0VIO5cCS12FZa155gJU3SK1OVBJcz1WhxDUw/syAG//uwwr4LF3trN+teZSDs+51Y77FVHo/WMrVr41NkSC6Vdxy3H+aIn/wLC3/WLjgR9mD3ohOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2HBRFFZ4MOcEnWcI1EYdqeC4uss5v6ZCeVktIJMEPA=;
 b=PA3TLrKahx/0l+ooXVIdoP06K1oIiGf2dhcAGZ0sgcdJLmFw08g3CY1Lxbm7yNl770hs3aN0LFn0tIL/0330Zj9VFyiuTN3LL8MhRg2+eC99Zz5Ny5DTz7Ubgpulm3BNyCRhHjX1H0XwonEmeIpkfka1VhHRGSdEfGgDphO/ZlZHVPzlp0aqADN5Z3n8kmE7PGSRSSWffLGB/rd1RQu3MmjHz6wzJ63oP+ov8QLPVGq2RjJjuvfQIWSNaryqZoNjyUIQAHeji6PerZZC1rNQV8WTPNw+yy0hpQ/PlBkm4sgvhHToGIQAPmAyJlZs0FjFuXD0uReJvLc8i7w9XHf3aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2HBRFFZ4MOcEnWcI1EYdqeC4uss5v6ZCeVktIJMEPA=;
 b=gAZEVObuZq7gZGXa4vpEfNgAmsbsTmzNZzQP0i3lz/+FhmPCN5k7+sm17CqPYRkEf7gNNFwXuNL1+ta4/8enKYXysrzgMu3oDGw62KG+BJE47whWdbbBYtz0+WMrQXmlHbaAzQ2KzyI91cUajxW1210Rh4BtMxkz0n+hDt/igr8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1216.namprd12.prod.outlook.com
 (2603:10b6:300:10::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.19; Thu, 4 Nov
 2021 07:58:35 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769%5]) with mapi id 15.20.4649.020; Thu, 4 Nov 2021
 07:58:35 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: Avoid writing GMC registers under sriov
 in gmc9
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211104025506.533625-1-YuBiao.Wang@amd.com>
 <50daadfb-cb9a-b4a1-3729-0dd241778e1c@amd.com>
Message-ID: <4f34fc0f-521c-6983-9940-0db8386d6578@amd.com>
Date: Thu, 4 Nov 2021 08:58:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <50daadfb-cb9a-b4a1-3729-0dd241778e1c@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR07CA0013.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::26) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM0PR07CA0013.eurprd07.prod.outlook.com (2603:10a6:208:ac::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.5 via Frontend Transport; Thu, 4 Nov 2021 07:58:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1304d537-da41-46a1-c22a-08d99f68e6de
X-MS-TrafficTypeDiagnostic: MWHPR12MB1216:
X-Microsoft-Antispam-PRVS: <MWHPR12MB12167527F261708730A0E50E838D9@MWHPR12MB1216.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CkLX5orARf8OCx/Dna4IkWql2HA6G/Zi7Y1pDo4J/QRnyDFRk+AWdMM2pRSW4id/X685sWNR0BBgVe7tLnLxhJYMeaGlDrJSUxbuAFLmNUvMrXhC/CkXRwtROZGFBGy5B6dLD0EWc/Fvjt7V1JkyeqT31RsY6N3OZBF5iUZ1YX2Vow/ivVqwA/jdd7hh45qIxhknXZG0ZFl2HgPGyQRuddl+Xu+1TjMfM3yoDVie8CQdDXPRo9ait9gmk5olY6ahCBAtgnzHXq98YxQLChoW3/fxo8+WDQ3WtDmzYmeDWvPDXDDp7joptyUGFAOPt7WgDuq4NBGZ8eglR1b4VaY4aT0jOD0QhtMbL2BLsPNVF8zsb8op5NfX2N2cWCmYOIgCDkFq2cPNW8Dq8ofAd7OhFnGNflpLb2yHrZlgzP66ousoYgkqod/i//+e94akkXSDhZwpJbK1W9akR+a/ECQqP0ydbfNJDgbeKD07U0XjA++qaDfeQp/7zr3fPOOauOpDmMLqOnLomfbMi7fEnrrWk7iDqXsa0KpXb2c+8J60CzUOHJ7sCCjJ6C9AVEplT308KFiQRbd0jOOZp+sDc9lzbzcDm4dc46I9QA6+xBQaBe+A34UJFN4OtaWBvmbES8aqCFPodzDQ+1jGCRs/uESpQ6ESAUHVV5W8VdeVGFNc0T/AgqeeODLRonNG1NnPOP8XnlttTmqJR9sSSBna2fUTNfNBYlOKF9K0MgXzXpySu2OTjWfQo6TRFNeMWylghHgQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(31686004)(8676002)(2906002)(6666004)(86362001)(83380400001)(31696002)(38100700002)(54906003)(16576012)(956004)(4326008)(66556008)(66476007)(186003)(36756003)(8936002)(26005)(66946007)(2616005)(316002)(6486002)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0lZT1IzT0xjM2hzcHEzeE9RZk9sZWlkcUlTT1VCM1VrOGM4RlJ6TkVxaWZk?=
 =?utf-8?B?Q1RMQlJ5c1F3NGZMeFRLd0M3ZWtNejFxYjh2d29talVGQ3VpcGd0R2VjSjN6?=
 =?utf-8?B?MFBDSUVqcmcrdVNubFI5Y29Wb0xSNHlOT0hqc3UvbzZnZEp5bkloMXJJbVNq?=
 =?utf-8?B?VWxxREhQRml2QTBsVXNJRHdTbnNPS3hZNjlFZGVrKzVBK2drRlBGYUFtV2xQ?=
 =?utf-8?B?M2RDSElFVXJ5VkRQWWQvbVlBaXZMdDdwTkk3Y0U1SGxqbUo5cVhnR2FmRDBW?=
 =?utf-8?B?ZW55dEtGU2dkQXNOSklXWGtJZ1ErWGt1aWpaZk44NmU4WkhDR2RqSHVZTjdw?=
 =?utf-8?B?U3ltZTlqL1VJTlRiZUtpbGpJZm11SGpwYnRMajRISVQrcE9PQ0tnSVlkUkZD?=
 =?utf-8?B?UU9sZjcwZzAweSs0L3NDQWtVczBVNU5xc2VCWlY5bHhGZjNrQlNGR3ZuVFRh?=
 =?utf-8?B?dGVaR1owMDdhdWdrbUdUbll1aTRicEZHblRkaEJueVRxNjNKRHViU0ZpNk5x?=
 =?utf-8?B?d0lma0hhcXpta1ZNQkpCbVZWTzBrdWU1VXJSaTBWOEZCVWZlQ1ZRKyt1SUYv?=
 =?utf-8?B?S0ZaUzdzSUZVS1BTRCt4R3BoMGdDbEY4Z1gwSjI0eW1iVlpQRnU2OXY5azZq?=
 =?utf-8?B?ZURGaW52NWIrcDdSMzNRRGFEbUZINXJ2Z2xnSXpnVG04T0JtdTJnaHZHY2Zy?=
 =?utf-8?B?WCtmVC9DdWFzS3hUMUtDd1J5cmpzZTlGWS9FVjVudE8rbTdqNlNMRnk3b3ow?=
 =?utf-8?B?WHh5alF1UldjOHphUVQ1bnljRHlkaXRDc3FlM2Jzckg1d1FFUjZRQzZsWkt0?=
 =?utf-8?B?UDl4SXNRcTd2ZVh0NjJvUUxzekt0UDNldFF1MldaMHVGcTRNSG9Xc2N1aXc5?=
 =?utf-8?B?NU1kejYrZ0xJUjh1VmtjclVpS20yZ0RaSTY1QzRVYnhoeGE3UjRsSlNvRVR6?=
 =?utf-8?B?alE3TmJJNFZSUmpETkZFVzdiTjI4WW5ZOVYweTJzSTNDMFBPZ1FiTmlUNHFW?=
 =?utf-8?B?Y21Cejg2R2hQYktZQ0Q2TDdsNTNqMzlrMnBxemo0c2F4Wk9oNExncUJFMjlD?=
 =?utf-8?B?N2V3MXpMMWhIRWhXeHVYVW5XVXNvekJjekR5ZUVXTUl6MHE3bloveVc4VmJz?=
 =?utf-8?B?R3U5L1BaT2s2Z0pXWVFIUk1nVnpYcTd1ZzVlTkpNQWZEWGtncEt2RzBKVVph?=
 =?utf-8?B?SWErOTFRWEJwSTlwTWNhM2RhanZWQ2lGdnRtbHlXdzFmbllmUlJ4UEM2ekZ6?=
 =?utf-8?B?M0FYUzRIQWpaSWUxUHRtdzlremtLNm5HN1k3d3VscnRxanREam9jRDVucFNE?=
 =?utf-8?B?MnZaODJ4QkovUTZjSGM5enZHaHliQ0dhMUpBTHpLNUxZOERjVkFiQU5aV0Zi?=
 =?utf-8?B?azEwU25uemV2dzFwSXV5WU9IQjFvbWd6aStRNFlQQ3VwQm0xamlzczQ3YjY1?=
 =?utf-8?B?aWcrOHhEb2FjSTJadzVQdjhHQWkxajl2djNFVEJpaU1kVWRnT0xCOUVvWFlr?=
 =?utf-8?B?bi9YMEQ2UnMyYk9IZHpseWtKRkh1YklBOWQ5NEY2aXFPZUxnRTM1djhaSjRS?=
 =?utf-8?B?d2tWOVhwY0lpOGZaN1Y3SHlkc2x6QUtYMkxaejFLd1FQVUNDM1Z2U1NpcE5o?=
 =?utf-8?B?ZWk4Skw4MGwzTEZTMjZuSzg0UmkzcHl0ckhNNnpqNE5Mbzl4bUpnKzZOa3c5?=
 =?utf-8?B?VDhoQllybE5abmQxeU9YaTRpUGwzV1RnalQwNitmcHRhWkdvMnY3WURENEpr?=
 =?utf-8?B?eEpoRlU5T2J3TCtHcW8vQzUxVldKMzF5MlF4NjBpUXV1YmxXNGh2dWpmOUdh?=
 =?utf-8?B?THRYcUM4V2E1SytienJBdkJlRjViMkhiV2FlVXoxTWdYVnZRYklqbjZ0TUlM?=
 =?utf-8?B?VVB5eXZMZkZMMHgzUk1PNnFWR29UT25PR3N2c1VRdE5OdUZSeFBPc2xwU3VE?=
 =?utf-8?B?Y20yTEVueWxwaVZsQXo5UC9NOEtRb1RJVXJDM0M2UTBBLzIwYS93cFFrTGgy?=
 =?utf-8?B?UWNuZDNkUU0rZm0xTEdrSkM4TmZpbHhZUnFYU29SSFAwU01FTWg5R0w2T2xV?=
 =?utf-8?B?TWN5MXBGaU1qYnlxYTZQQ1FXZ05jZVo4NWRwN1BSTkxNOU4yM2tOeVFCK3Rs?=
 =?utf-8?Q?6fNQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1304d537-da41-46a1-c22a-08d99f68e6de
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 07:58:35.0468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ex08bRi3eXdNMMQpGCNwUSYQO3/QuV2c15FSKNaw5UPjkeiof7rSdvi1tFAB2Gok
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1216
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Jingwen Chen <Jingwen.Chen2@amd.com>, Monk Liu <Monk.Liu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.11.21 um 08:49 schrieb Christian König:
>
>
> Am 04.11.21 um 03:55 schrieb YuBiao Wang:
>> [Why]
>> For Vega10, disabling gart of gfxhub and mmhub could mess up KIQ and PSP
>> under sriov mode, and lead to DMAR on host side.
>>
>> [How]
>> Skip writing GMC registers under sriov.
>>
>> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 26 +++++++++++++-----------
>>   1 file changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
>> index bda1542ef1dd..f9a7349eb601 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
>> @@ -348,18 +348,20 @@ static void gfxhub_v1_0_gart_disable(struct 
>> amdgpu_device *adev)
>>           WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT0_CNTL,
>>                       i * hub->ctx_distance, 0);
>>   -    /* Setup TLB control */
>> -    tmp = RREG32_SOC15(GC, 0, mmMC_VM_MX_L1_TLB_CNTL);
>> -    tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 0);
>> -    tmp = REG_SET_FIELD(tmp,
>> -                MC_VM_MX_L1_TLB_CNTL,
>> -                ENABLE_ADVANCED_DRIVER_MODEL,
>> -                0);
>> -    WREG32_SOC15_RLC(GC, 0, mmMC_VM_MX_L1_TLB_CNTL, tmp);
>> -
>> -    /* Setup L2 cache */
>> -    WREG32_FIELD15(GC, 0, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>> -    WREG32_SOC15(GC, 0, mmVM_L2_CNTL3, 0);
>> +    if (!amdgpu_sriov_vf(adev)) {
>
> Maybe make that an "if (amdgpu_sriov_vf(adev)) return", but in general 
> feel free to add an Acked-by: Christian König 
> <christian.koenig@amd.com> to the patch.
>
> Additional to that the patch should probably be send to the public 
> mailing list instead.

Please forget that last comment, just noticed the public list is on CC 
as well.

Thanks,
Christian.

>
> Regards,
> Christian.
>
>> +        /* Setup TLB control */
>> +        tmp = RREG32_SOC15(GC, 0, mmMC_VM_MX_L1_TLB_CNTL);
>> +        tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, 
>> ENABLE_L1_TLB, 0);
>> +        tmp = REG_SET_FIELD(tmp,
>> +                    MC_VM_MX_L1_TLB_CNTL,
>> +                    ENABLE_ADVANCED_DRIVER_MODEL,
>> +                    0);
>> +        WREG32_SOC15_RLC(GC, 0, mmMC_VM_MX_L1_TLB_CNTL, tmp);
>> +
>> +        /* Setup L2 cache */
>> +        WREG32_FIELD15(GC, 0, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>> +        WREG32_SOC15(GC, 0, mmVM_L2_CNTL3, 0);
>> +    }
>>   }
>>     /**
>

