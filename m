Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00374C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 12:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A16610E5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 12:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B3A16610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44FDC6E1F5;
	Wed, 25 Aug 2021 12:29:20 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BCD86E1F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 12:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSQOUB/D54k2KLAFeJOw3GiHunmIbI3L+kVWVydcU/MuSrrEjpbcQph9KuZwEbKFcWj+66LbQY+9rRQGV4mvmNL9SCVe8jA3k4GCZ8rTTQG3i20wdT0F34BQ7739bMpD/4AECyQoZ8I2sJa3jNBZRwK5LUQd5spd0XnPED7gBGsQhFm34MM2eGJ6tyI5TAhK/TBwwgzW1msUdXqsyxPvB70hsl5W+Ya2KwegtEyrswG5ScAmPZjYVxpimETwW9xn86luX9iM9HT9amTmbndowIvtN45ACFQF1kfp+UFGHGuRFoaYI2vEB4OtbVX9v2TKChulpGxN0WhWKOHFVf99tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlSnmwAE1aVEYnaUKloTDZVZWrA+v/3IxsVtfAepMGE=;
 b=GqFSx3/FuTx5/4gBsHrynt64KkTcoX/ItTqwBwANpngI26r/LMsOTyR/aOIJopG1j0mW85qo/7+jH+8j8djGTRCAV/x36UWXYqmlzDLfce302CUWuKPvmuY5FYpz+a4vaYTJghC03USRYMfq22UVteJcGq5PcFXfXRLvlrgMBdRy3cRIQi7/nDgmqEFTAK+tkiCo5RK9lqHgRoZGpFXeSx6JZjxHRBESNwDugRXdT/TRD0s8UYSoKUhcZLXQweW4EHuGTZdrRyXKm0OLRRNEs0j5HpPuiDeL6zmVWg8sA1+1CVKjc+EHpTf0MCjyg5VTIQIKDVNOP6VbTtrfc2sh6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlSnmwAE1aVEYnaUKloTDZVZWrA+v/3IxsVtfAepMGE=;
 b=CMww6VDlp8mnwqO4nHi9GUwfnBgg1WIm5HYNMnLGsdX2OXtv3B9hPFA9PaznbqpWtmQqRV+LftW6EjQ3uaXzgmlZtcEP8XN3hlt32oQ6K8Ngcn6GNZIF7pcIWVkxvaeFhseeLclO30TIcSkA18e6oF2UlEyMkuUnKMzkghbfTYE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 12:29:15 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 12:29:15 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: rework context priority handling
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: satyajit.sahu@amd.com
References: <20210825112203.3806-1-nirmoy.das@amd.com>
 <bd435c95-4d7d-5b0e-b1c7-81ed4d883ff9@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9f4562fe-2c83-a0fa-5564-618db6a33c7c@amd.com>
Date: Wed, 25 Aug 2021 14:29:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <bd435c95-4d7d-5b0e-b1c7-81ed4d883ff9@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR3P193CA0057.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::32) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.21] (91.14.161.181) by
 PR3P193CA0057.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:51::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.22 via Frontend Transport; Wed, 25 Aug 2021 12:29:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 071d6259-72ba-4825-7dfe-08d967c3f36b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43027CD840F64FCA32404A3F83C69@MN2PR12MB4302.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8TDvFNonzloDlzZQsm7P1YYRL6RokltWhkN+9byHinAWUH+2qWWMlb4kWgYpQmA66UvywKYG90UCflQbZ1lP+vlQuo/IHC+5ssKHsUhcejRTFIeta4y5P/Obt4zcg43eC9l0pD3BmgPtb34xKJozUgIXCnRLtbxKzxDFj0GXN/3WBCcWL6rnTTQFEE1QSNk1AC41osyjwHqF2XqcD+Am4+MpHM8k3WR+6VmtZ9WuvEOho+6YAidFtC9VsqMthw514BFOS3IyfI5EDxLIFJNSN/HbtTYfqg2mCnh+54jrOzJgAH/ro8fiqgZL6odLfj5YZenbyYj9Jidh+FNayXHjjXkE6zcbv08zirJe677zr1DOkT/YQpB7ITtU5OAbiYOw0a3LGkwlxLl57bXQmBPuDpNMtVnHHGGJHgEsIT3nhs1fzO9agh11kC7ZEPRqs2erbZPZxKkIInJ82skVJWYn1C4EW2YD/TBsEUDt2LQIyOqL90l2p9E1BHk9JK6Mz5vT9S6zPu3s+nM6tC7LF8AWwblW69idGn+aIoJ0vomONNV2K2snNKeg1Am52L7K0QH0AJBMXF5zuk4Fq2yzrN6tomR1/kxgeUL4XsBrrHjwlRzL3gc3njhOV0Ntx+gI4biAgas02FaJeBA4xoIhfTY6XEnCzc9NW1OyfYt05xGw5cij24bhJyzVGtd1GyKJIogtWO9ovu7lB6ZIhhnUJ16N9iUT63rZ9UvNzwG1cKX/jw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(26005)(6486002)(5660300002)(110136005)(16576012)(316002)(83380400001)(186003)(36756003)(2616005)(956004)(2906002)(66556008)(66476007)(66946007)(38100700002)(8676002)(478600001)(53546011)(31686004)(30864003)(6666004)(86362001)(8936002)(31696002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjBZYzI5WHFzSHNkMnRBekhTQjFJLzZwMldIYk5SemppRUp3bVd4dGk3ODhk?=
 =?utf-8?B?dG9pN2JOMnRLY3ErQVFBMmtjZTVnc3pGbldzNndLaWVJSXBQMVh0N2lLTUxX?=
 =?utf-8?B?UE5SWVVZbGVIUU42ZjE3TFlQQ0NldlRkSkFabzFrVXNORFMrZStPNkx5Z21m?=
 =?utf-8?B?YW8xNmZacHdPM1o5aDZsdzhwMXNjU3JJNHlWcVh4bWhNb1ZjaHV5NzBUVEtm?=
 =?utf-8?B?a3VvQlVBS1d2ci9wU3R3TGNQNWR2N2JlR0g1Z0dKdUxVbFQ0MGwvMVBaVWl0?=
 =?utf-8?B?QkpteFc2R0pyRXViK1Q2R1Urd3lYSkpZWlpGb1NuNHRneGZVQ29wa21Gd3dB?=
 =?utf-8?B?cngxWVFOMTRXZmUvbU5hN0RiZVRNMFZTandBcnR2V29mVVUvMVVWTXFQL3ln?=
 =?utf-8?B?TVpONDNocmtaQ0RCOHpoa3lDQlNGa1ZUQ2llV0JBbFR1NEhNamw5OEtNWnBV?=
 =?utf-8?B?SkVFdzBkZE5wamx1OTBtVUo1MFFaNURKbVJuVkY2SXpPOWVQVjdKNVZrTnBu?=
 =?utf-8?B?ZWdUZ1puTlRyNjFlS29Sb3g1Uit1NHNzUFUyTnF1ekg4YVRoV2Vhd2xyb3dD?=
 =?utf-8?B?RGVkZmRBMm1YQ0tla0dwQS9FSWNtcHdHSnRLNnR3b2VYMmNDNG1qbEF0N2JT?=
 =?utf-8?B?VzRzMGtwSWZBdWJCMEkxUVBHVzlUWXNZYUJxYkVxaFBpSzliWHJ4dGF1Sndt?=
 =?utf-8?B?aERvaUZ1WXpKNnNRbDJWYWsvZWRoaUI1czlhaTBTbklwSXA1dk9xTzFXOGor?=
 =?utf-8?B?NkZvU3dTN0ZIRklpM1hHZ2FjUUYyODBCS1k0YlRBbmpGZXlZdUN1OW5TVHVu?=
 =?utf-8?B?Q0dYVEF2OXh2MC9WTHdtUnFyaWZVVUFOamo1UU5sL2tnS2ZQTk1LeWFaVnVX?=
 =?utf-8?B?eFNwYXVYVFhDQVpkWmgwdnJpQzUwK0JYYU1IN3dNZ21wdzJwT0dxU2pRTDhX?=
 =?utf-8?B?SGs0aG4wZnM5RGNTellsd1BYMlRabk5HWkhYTzV4NzIxaVpFb0M3aVh5S1Nt?=
 =?utf-8?B?ZHRRRXNsNmh3VEVudnpJcFMzNFYzMUlnNUoxQkx5VE9MUjlkNkZQU2pMdEtz?=
 =?utf-8?B?U1hvVld6UjlYYTRIb0c5NjVLUjYyYWRoRE85UjJKUkl5eC9ZMmhTT3UvSVN2?=
 =?utf-8?B?NTJMd09Cem9GZTdFSkhxTEtTUlAwR0JkMmtxTjYwa0VTeHAzR2RFNWpsTUMz?=
 =?utf-8?B?cnBobloweUZrV2dhRGo4ZE45TzVhZjBHMy83ZTdtaW13WEJPdnRpWk9KeGk3?=
 =?utf-8?B?eFJxSHg2Y3FPTlVTRUw4akVEZzNMNEtmaHdKRHZwOWc0dzhmanczVVA4andM?=
 =?utf-8?B?QUtWRkxVd0ZrQTlLM1VpbDk4SCtSQVRmL0tTdUV6MHNDRm1GdHArazBtSnJ5?=
 =?utf-8?B?Z3hkZ0pyZ0tEVW1DUHBVN2ZRUWNlb3I1bGkvb05OMm5oVy9aMHVzaDROcUYy?=
 =?utf-8?B?dVNMRWpTSUxzOStnTmRFNEtTclRWZXZnTHBIakFYZEVWcXZIaWQ1ak05T29H?=
 =?utf-8?B?UHo1U3dodUFrQWRqQ29SQkJ5THRyeXRSTkg5R2NpdlpSdUxWWERHRmI4QVU0?=
 =?utf-8?B?ZDk0UUZoQWZ5blVxR1E3VXNicGhObmwzckxOREZjTFd3ZVpsYzJtVHpaQi9M?=
 =?utf-8?B?RDRDNFgxRzdQaWFSSy8xeTZBSG0wOWN2MmZyK3pQQlNQS1hhdG43UzhFMUlx?=
 =?utf-8?B?bVhLUDhMUzlmWE13QWpaNFBOV1NCYjdhcjgvdEJjbXc1SGZ0ajVUcFA4UDlQ?=
 =?utf-8?Q?SsmPl6pt0tJAgaWVi/9FoD7MJV6ScrmCxhHFAe1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071d6259-72ba-4825-7dfe-08d967c3f36b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 12:29:15.3545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSp0uRPlkqY5cArlwFc1dG1a9/e+mwGZrvOKqR5ZvH9h70xEHC7UlBvGRDbtpFCM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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

Am 25.08.21 um 14:20 schrieb Lazar, Lijo:
> On 8/25/2021 4:52 PM, Nirmoy Das wrote:
>> To get a hardware queue priority for a context, we are currently
>> mapping AMDGPU_CTX_PRIORITY_* to DRM_SCHED_PRIORITY_* and then
>> to hardware queue priority, which is not the right way to do that
>> as DRM_SCHED_PRIORITY_* is software scheduler's priority and it is
>> independent from a hardware queue priority.
>>
>> Use userspace provided context priority, AMDGPU_CTX_PRIORITY_* to
>> map a context to proper hardware queue priority.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 127 ++++++++++++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h   |   8 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |  44 ++------
>>   3 files changed, 105 insertions(+), 74 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index e7a010b7ca1f..c88c5c6c54a2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -43,14 +43,61 @@ const unsigned int 
>> amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
>>       [AMDGPU_HW_IP_VCN_JPEG]    =    1,
>>   };
>>   +bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio)
>> +{
>> +    switch (ctx_prio) {
>> +    case AMDGPU_CTX_PRIORITY_UNSET:
>> +    case AMDGPU_CTX_PRIORITY_VERY_LOW:
>> +    case AMDGPU_CTX_PRIORITY_LOW:
>> +    case AMDGPU_CTX_PRIORITY_NORMAL:
>> +    case AMDGPU_CTX_PRIORITY_HIGH:
>> +    case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>> +        return true;
>> +    default:
>> +        return false;
>> +    }
>> +}
>> +
>> +static enum drm_sched_priority
>> +amdgpu_ctx_to_drm_sched_prio(int32_t ctx_prio)
>> +{
>> +    switch (ctx_prio) {
>> +    case AMDGPU_CTX_PRIORITY_UNSET:
>> +        return DRM_SCHED_PRIORITY_UNSET;
>> +
>> +    case AMDGPU_CTX_PRIORITY_VERY_LOW:
>> +        return DRM_SCHED_PRIORITY_MIN;
>> +
>> +    case AMDGPU_CTX_PRIORITY_LOW:
>> +        return DRM_SCHED_PRIORITY_MIN;
>> +
>> +    case AMDGPU_CTX_PRIORITY_NORMAL:
>> +        return DRM_SCHED_PRIORITY_NORMAL;
>> +
>> +    case AMDGPU_CTX_PRIORITY_HIGH:
>> +        return DRM_SCHED_PRIORITY_HIGH;
>> +
>> +    case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>> +        return DRM_SCHED_PRIORITY_HIGH;
>> +
>> +    /* This should not happen as we sanitized userspace provided 
>> priority
>> +     * already, WARN if this happens.
>> +     */
>> +    default:
>> +        WARN(1, "Invalid context priority %d\n", ctx_prio);
>> +        return DRM_SCHED_PRIORITY_NORMAL;
>> +    }
>> +
>> +}
>> +
>>   static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>> -                      enum drm_sched_priority priority)
>> +                      int32_t priority)
>>   {
>> -    if (priority < 0 || priority >= DRM_SCHED_PRIORITY_COUNT)
>> +    if (!amdgpu_ctx_priority_is_valid(priority))
>>           return -EINVAL;
>>         /* NORMAL and below are accessible by everyone */
>> -    if (priority <= DRM_SCHED_PRIORITY_NORMAL)
>> +    if (priority <= AMDGPU_CTX_PRIORITY_NORMAL)
>>           return 0;
>>         if (capable(CAP_SYS_NICE))
>> @@ -62,26 +109,35 @@ static int amdgpu_ctx_priority_permit(struct 
>> drm_file *filp,
>>       return -EACCES;
>>   }
>>   -static enum gfx_pipe_priority 
>> amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sched_priority prio)
>> +static enum gfx_pipe_priority 
>> amdgpu_ctx_prio_to_compute_prio(int32_t prio)
>>   {
>>       switch (prio) {
>> -    case DRM_SCHED_PRIORITY_HIGH:
>> -    case DRM_SCHED_PRIORITY_KERNEL:
>> +    case AMDGPU_CTX_PRIORITY_HIGH:
>> +    case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>>           return AMDGPU_GFX_PIPE_PRIO_HIGH;
>>       default:
>>           return AMDGPU_GFX_PIPE_PRIO_NORMAL;
>>       }
>>   }
>>   -static unsigned int amdgpu_ctx_prio_sched_to_hw(struct 
>> amdgpu_device *adev,
>> -                         enum drm_sched_priority prio,
>> -                         u32 hw_ip)
>> +static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, 
>> u32 hw_ip)
>>   {
>> +    struct amdgpu_device *adev = ctx->adev;
>> +    int32_t ctx_prio;
>>       unsigned int hw_prio;
>>   -    hw_prio = (hw_ip == AMDGPU_HW_IP_COMPUTE) ?
>> -            amdgpu_ctx_sched_prio_to_compute_prio(prio) :
>> -            AMDGPU_RING_PRIO_DEFAULT;
>> +    ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
>> +            ctx->init_priority : ctx->override_priority;
>> +
>> +    switch (hw_ip) {
>> +    case AMDGPU_HW_IP_COMPUTE:
>> +        hw_prio = amdgpu_ctx_prio_to_compute_prio(ctx_prio);
>> +        break;
>> +    default:
>> +        hw_prio = AMDGPU_RING_PRIO_DEFAULT;
>> +        break;
>> +    }
>> +
>>       hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
>>       if (adev->gpu_sched[hw_ip][hw_prio].num_scheds == 0)
>>           hw_prio = AMDGPU_RING_PRIO_DEFAULT;
>> @@ -89,15 +145,17 @@ static unsigned int 
>> amdgpu_ctx_prio_sched_to_hw(struct amdgpu_device *adev,
>>       return hw_prio;
>>   }
>>   +
>>   static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>> -                   const u32 ring)
>> +                  const u32 ring)
>>   {
>>       struct amdgpu_device *adev = ctx->adev;
>>       struct amdgpu_ctx_entity *entity;
>>       struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
>>       unsigned num_scheds = 0;
>> +    int32_t ctx_prio;
>>       unsigned int hw_prio;
>> -    enum drm_sched_priority priority;
>> +    enum drm_sched_priority drm_prio;
>>       int r;
>>         entity = kzalloc(struct_size(entity, fences, amdgpu_sched_jobs),
>> @@ -105,10 +163,11 @@ static int amdgpu_ctx_init_entity(struct 
>> amdgpu_ctx *ctx, u32 hw_ip,
>>       if (!entity)
>>           return  -ENOMEM;
>>   +    ctx_prio = (ctx->override_priority == 
>> AMDGPU_CTX_PRIORITY_UNSET) ?
>> +            ctx->init_priority : ctx->override_priority;
>>       entity->sequence = 1;
>> -    priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
>> -                ctx->init_priority : ctx->override_priority;
>> -    hw_prio = amdgpu_ctx_prio_sched_to_hw(adev, priority, hw_ip);
>> +    hw_prio = amdgpu_ctx_get_hw_prio(ctx, hw_ip);
>> +    drm_prio = amdgpu_ctx_to_drm_sched_prio(ctx_prio);
>>         hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
>>       scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
>> @@ -124,7 +183,7 @@ static int amdgpu_ctx_init_entity(struct 
>> amdgpu_ctx *ctx, u32 hw_ip,
>>           num_scheds = 1;
>>       }
>>   -    r = drm_sched_entity_init(&entity->entity, priority, scheds, 
>> num_scheds,
>> +    r = drm_sched_entity_init(&entity->entity, drm_prio, scheds, 
>> num_scheds,
>>                     &ctx->guilty);
>>       if (r)
>>           goto error_free_entity;
>> @@ -139,7 +198,7 @@ static int amdgpu_ctx_init_entity(struct 
>> amdgpu_ctx *ctx, u32 hw_ip,
>>   }
>>     static int amdgpu_ctx_init(struct amdgpu_device *adev,
>> -               enum drm_sched_priority priority,
>> +               int32_t priority,
>>                  struct drm_file *filp,
>>                  struct amdgpu_ctx *ctx)
>>   {
>> @@ -161,7 +220,7 @@ static int amdgpu_ctx_init(struct amdgpu_device 
>> *adev,
>>       ctx->reset_counter_query = ctx->reset_counter;
>>       ctx->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
>>       ctx->init_priority = priority;
>> -    ctx->override_priority = DRM_SCHED_PRIORITY_UNSET;
>> +    ctx->override_priority = AMDGPU_CTX_PRIORITY_UNSET;
>>         return 0;
>>   }
>> @@ -234,7 +293,7 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, 
>> u32 hw_ip, u32 instance,
>>   static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
>>                   struct amdgpu_fpriv *fpriv,
>>                   struct drm_file *filp,
>> -                enum drm_sched_priority priority,
>> +                int32_t priority,
>>                   uint32_t *id)
>>   {
>>       struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
>> @@ -397,19 +456,19 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, 
>> void *data,
>>   {
>>       int r;
>>       uint32_t id;
>> -    enum drm_sched_priority priority;
>> +    int32_t priority;
>>         union drm_amdgpu_ctx *args = data;
>>       struct amdgpu_device *adev = drm_to_adev(dev);
>>       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>         id = args->in.ctx_id;
>> -    r = amdgpu_to_sched_priority(args->in.priority, &priority);
>> +    priority = args->in.priority;
>>         /* For backwards compatibility reasons, we need to accept
>>        * ioctls with garbage in the priority field */
>> -    if (r == -EINVAL)
>> -        priority = DRM_SCHED_PRIORITY_NORMAL;
>> +    if (!amdgpu_ctx_priority_is_valid(priority))
>> +        priority = AMDGPU_CTX_PRIORITY_NORMAL;
>>         switch (args->in.op) {
>>       case AMDGPU_CTX_OP_ALLOC_CTX:
>> @@ -515,9 +574,9 @@ struct dma_fence *amdgpu_ctx_get_fence(struct 
>> amdgpu_ctx *ctx,
>>   }
>>     static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
>> -                        struct amdgpu_ctx_entity *aentity,
>> -                        int hw_ip,
>> -                        enum drm_sched_priority priority)
>> +                       struct amdgpu_ctx_entity *aentity,
>> +                       int hw_ip,
>> +                       int32_t priority)
>>   {
>>       struct amdgpu_device *adev = ctx->adev;
>>       unsigned int hw_prio;
>> @@ -525,12 +584,12 @@ static void 
>> amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
>>       unsigned num_scheds;
>>         /* set sw priority */
>> -    drm_sched_entity_set_priority(&aentity->entity, priority);
>> +    drm_sched_entity_set_priority(&aentity->entity,
>> +                      amdgpu_ctx_to_drm_sched_prio(priority));
>>         /* set hw priority */
>>       if (hw_ip == AMDGPU_HW_IP_COMPUTE) {
>> -        hw_prio = amdgpu_ctx_prio_sched_to_hw(adev, priority,
>> -                              AMDGPU_HW_IP_COMPUTE);
>> +        hw_prio = amdgpu_ctx_get_hw_prio(ctx, hw_ip);
>>           hw_prio = array_index_nospec(hw_prio, AMDGPU_RING_PRIO_MAX);
>
> Not related to this patch, but this kind of logic may break some day. 
> There is a HWIP specific priority and there is another RING_PRIO which 
> is unmapped to HWIP priority Ex: when a new priority is added for VCN 
> which is higher than any of the existing priorities.

Yes, that's something I've noticed as well.

Either we should leave the exact mapping to the engine or have a global 
definition of possible hw priorities (the later is preferable I think).

Christian.

>
> Thanks,
> Lijo
>
>>           scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
>>           num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
>> @@ -540,14 +599,14 @@ static void 
>> amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
>>   }
>>     void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>> -                  enum drm_sched_priority priority)
>> +                  int32_t priority)
>>   {
>> -    enum drm_sched_priority ctx_prio;
>> +    int32_t ctx_prio;
>>       unsigned i, j;
>>         ctx->override_priority = priority;
>>   -    ctx_prio = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
>> +    ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
>>               ctx->init_priority : ctx->override_priority;
>>       for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>>           for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> index 14db16bc3322..a44b8b8ed39c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> @@ -47,8 +47,8 @@ struct amdgpu_ctx {
>>       spinlock_t            ring_lock;
>>       struct amdgpu_ctx_entity 
>> *entities[AMDGPU_HW_IP_NUM][AMDGPU_MAX_ENTITY_NUM];
>>       bool                preamble_presented;
>> -    enum drm_sched_priority        init_priority;
>> -    enum drm_sched_priority        override_priority;
>> +    int32_t                init_priority;
>> +    int32_t                override_priority;
>>       struct mutex            lock;
>>       atomic_t            guilty;
>>       unsigned long            ras_counter_ce;
>> @@ -75,8 +75,8 @@ void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
>>   struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
>>                          struct drm_sched_entity *entity,
>>                          uint64_t seq);
>> -void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>> -                  enum drm_sched_priority priority);
>> +bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio);
>> +void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx, int32_t 
>> ctx_prio);
>>     int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
>>                struct drm_file *filp);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>> index b7d861ed5284..e9b45089a28a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>> @@ -32,37 +32,9 @@
>>   #include "amdgpu_sched.h"
>>   #include "amdgpu_vm.h"
>>   -int amdgpu_to_sched_priority(int amdgpu_priority,
>> -                 enum drm_sched_priority *prio)
>> -{
>> -    switch (amdgpu_priority) {
>> -    case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>> -        *prio = DRM_SCHED_PRIORITY_HIGH;
>> -        break;
>> -    case AMDGPU_CTX_PRIORITY_HIGH:
>> -        *prio = DRM_SCHED_PRIORITY_HIGH;
>> -        break;
>> -    case AMDGPU_CTX_PRIORITY_NORMAL:
>> -        *prio = DRM_SCHED_PRIORITY_NORMAL;
>> -        break;
>> -    case AMDGPU_CTX_PRIORITY_LOW:
>> -    case AMDGPU_CTX_PRIORITY_VERY_LOW:
>> -        *prio = DRM_SCHED_PRIORITY_MIN;
>> -        break;
>> -    case AMDGPU_CTX_PRIORITY_UNSET:
>> -        *prio = DRM_SCHED_PRIORITY_UNSET;
>> -        break;
>> -    default:
>> -        WARN(1, "Invalid context priority %d\n", amdgpu_priority);
>> -        return -EINVAL;
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>>   static int amdgpu_sched_process_priority_override(struct 
>> amdgpu_device *adev,
>>                             int fd,
>> -                          enum drm_sched_priority priority)
>> +                          int32_t priority)
>>   {
>>       struct fd f = fdget(fd);
>>       struct amdgpu_fpriv *fpriv;
>> @@ -89,7 +61,7 @@ static int 
>> amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
>>   static int amdgpu_sched_context_priority_override(struct 
>> amdgpu_device *adev,
>>                             int fd,
>>                             unsigned ctx_id,
>> -                          enum drm_sched_priority priority)
>> +                          int32_t priority)
>>   {
>>       struct fd f = fdget(fd);
>>       struct amdgpu_fpriv *fpriv;
>> @@ -124,7 +96,6 @@ int amdgpu_sched_ioctl(struct drm_device *dev, 
>> void *data,
>>   {
>>       union drm_amdgpu_sched *args = data;
>>       struct amdgpu_device *adev = drm_to_adev(dev);
>> -    enum drm_sched_priority priority;
>>       int r;
>>         /* First check the op, then the op's argument.
>> @@ -138,21 +109,22 @@ int amdgpu_sched_ioctl(struct drm_device *dev, 
>> void *data,
>>           return -EINVAL;
>>       }
>>   -    r = amdgpu_to_sched_priority(args->in.priority, &priority);
>> -    if (r)
>> -        return r;
>> +    if (!amdgpu_ctx_priority_is_valid(args->in.priority)) {
>> +        WARN(1, "Invalid context priority %d\n", args->in.priority);
>> +        return -EINVAL;
>> +    }
>>         switch (args->in.op) {
>>       case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:
>>           r = amdgpu_sched_process_priority_override(adev,
>>                                  args->in.fd,
>> -                               priority);
>> +                               args->in.priority);
>>           break;
>>       case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
>>           r = amdgpu_sched_context_priority_override(adev,
>>                                  args->in.fd,
>>                                  args->in.ctx_id,
>> -                               priority);
>> +                               args->in.priority);
>>           break;
>>       default:
>>           /* Impossible.
>>

