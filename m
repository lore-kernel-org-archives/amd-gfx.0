Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFA7C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE48C6105A
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE48C6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D6E56E524;
	Wed,  6 Oct 2021 14:02:58 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D72D6E519
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 14:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hy+RXuhKlFgQ9sN2ngd/xHneklQ4oCVRrwbRB3M2OfrNjwpBJJdAn08EMaLDoMEPMIhWxU+Z4Q5XLTUgr2Rl4wUcZpXsnzhWkO+6hArVfk6wcz5JuQ/K3BloS5DiQ+rIh1emgFTZ2UWJSweRjwg1GLnNlAJA+ZlhnyRRDEKPv/hrcDFwzT50qIAFXs6DPTvJajHI6XzZUrGeVEQvTfu1o5L8dM3JMEk2VwlY6hghFFiJ2YDmzPegxtBkd9QqXx7SuT28sIdR1oxumohFralC72+C12cJL+0uPDQ+Ps5OcNZs/lZrt0rT+qY7lh4G7/Y165GCOj9et6OczGGrydXpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KNeahUoceR5zK7gbtZrsz/pSQrtEf2/X/2tTyZAhkA=;
 b=j5xQPLWHRqwjgCY1j0r2D14efIqRhKh0UFxGYn5acZ5byj3qpOjYEo8T4EVZULLgA8s/c7GMV8sqR70mXvCo1vGSrxOmX9ks9FKIbbtzyTvYmfP5YKJZjw2AJ1wRJNHTDUTVI9OgKivoTNnys1f5QgFiGuGw7jnMYkN51Srqn/mktVspWNWdXY7U94U+RZ2ZcHHkxewzr2SesGYk3VuwYIbS94WP6k07QJA/n2/KSZm/9yYq9pZtOaQ6CYGWBX6FLkuKSe39xX6wnlTvRvpcSGMe7z3+sCJLbIR2VNs5yZrJXtvr0MKyePbDB25c2Aa4cyQrAHEDoSW7JnlgMAcYwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KNeahUoceR5zK7gbtZrsz/pSQrtEf2/X/2tTyZAhkA=;
 b=QYT38hV55wZPgJ9G0nL3QZ4qVIrqrO5K2YdGfpGnTNpuzWvXjwbNlvKYGTDRF32eu94uyx4OWpDIN2WOrxqUOqAXBT1a2I57li/Y/QyqmyiiPCzaz89Q87PdEB3qSURHcXFOmuillWq7lf2dkbtwRlBVgaFixMagdpJAgU6Dbsg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5425.namprd12.prod.outlook.com (2603:10b6:303:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 6 Oct
 2021 14:02:54 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 14:02:54 +0000
Message-ID: <16f62843-883d-0ddf-8545-d2806a5ab82b@amd.com>
Date: Wed, 6 Oct 2021 10:02:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 19/23] drm/amd/display: Add debug flags for USB4 DP
 link training
Content-Language: en-US
To: "Lin, Wayne" <Wayne.Lin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>,
 "Shih, Jude" <Jude.Shih@amd.com>, "Kizito, Jimmy" <Jimmy.Kizito@amd.com>,
 "Somasundaram, Meenakshikumar" <Meenakshikumar.Somasundaram@amd.com>,
 "Lei, Jun" <Jun.Lei@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
 <20211005075205.3467938-20-Wayne.Lin@amd.com>
 <33774abc-c31d-e3d6-43ec-b80bc7e946c5@amd.com>
 <CO6PR12MB5489C5E88F098D2C6BC7AF69FCB09@CO6PR12MB5489.namprd12.prod.outlook.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CO6PR12MB5489C5E88F098D2C6BC7AF69FCB09@CO6PR12MB5489.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::19) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQXPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:15::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Wed, 6 Oct 2021 14:02:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2100440-9ae6-4509-17be-08d988d1fde7
X-MS-TrafficTypeDiagnostic: CO6PR12MB5425:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5425072449B445C284D95E0B8CB09@CO6PR12MB5425.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 54qCZHG7a61V8Nxlh6CYN8vYBgveZtKUAIbM3ZN5v1U7gm/bfhYBg6nhNC7jD2DTKKuRJZCiqd/Qrvs08qiswSKavukWr7Xt/7yR5iUR9nZk/SDnrang0HhOyCAbKiij0sYAPyckRabMMXWbK3AyMHyjV6iOuwrRgvmPL/GHUeBL3ovtXPjHK8Ycek/dSdFq9IRLh+PBfncUALwiLjh5gjMtAEttbZZnQpHS9/L6gsxKxuvDHoBcfoAc9Hkyy1CiTXhWrxLTBJNQp01vc+8Iu9Myc+Cz0kLLKzanht2qy85qnhFPXwFtoc8AKvwAapIwRF8LSvINGwteijJGGMpDCqx5to31zAv5grOjSGgk9lgIgwekJdc+bLbnCMJ78/Xwqg56Bf0+Xl/Lk8mxg8SPzLQ5RjLXVQSzKtxhDPumTXQnxlmLFfO7F1FaON/JJCJgCUTez8H8Smzc0bkWph4HvSWtBPHF0/0bdarj1YZQCIMP1spoTWvGvfw1caRlI26FePFkLv5rU4ztZ/Wumrlnk/rRS2n9zuWS0M1nvh7fucZym+FMuVGZgtfh929XL58XmXPXpDfPHUVMTCAVAV46Lgx5jwITE4TbdxPIeiCBv6xn8cesvTzZ52CFZEQH+VjI9aUGsCdW3sIp5znXN1Zjz1EbaNEJUKvZ0zuq62euCWxvcJ5aausqOShFifnxzs3BdPu+wFLgicQ+rVav0qaNk8tc2NxhODGnGV9irrMb7hg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(54906003)(316002)(16576012)(38100700002)(31686004)(5660300002)(110136005)(83380400001)(186003)(4326008)(6486002)(66946007)(31696002)(8676002)(956004)(66476007)(66556008)(2616005)(26005)(53546011)(6666004)(86362001)(2906002)(36756003)(44832011)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk1MMTNCTnRPTmxCSWY4M2FQWmZGeWNKQ3hIQ3lxeVJjMHltOWk5ZDRWUkV2?=
 =?utf-8?B?bDlROEN6QzBPK2xtNUgvMGs2VmUxMm5OOVlnc0VpOHZxVXBBTW5mSkxLaWph?=
 =?utf-8?B?dzE5dDB1bVZNVlE3cTZyT2JrV0ZDTzBGVGxzNGNuZmZiU0d2SE05V2dPd2ZB?=
 =?utf-8?B?Mjk0d1dOSjR2MHErS1ZNdGtnV1pjdy9rb1BLZ3ZGd0hHS251WVRheWxqZ0J1?=
 =?utf-8?B?cEpBWFA5OWlpWGRpeXpEYmNGTEpFb0NsRzF6YWNRL0ZsZ3pKaXA3Mk9DcnFo?=
 =?utf-8?B?cEMxVVROYjl6Mmw2elBhQnhxSEM1NHN6RGJIZ3Rka1ZaWWdLWSt0TEtBL2VD?=
 =?utf-8?B?cG5zeDcxalhNdGMyVDhMWFpqR1dGVEVWUmY1RzlVUC9HR3gzZjFGbys3aVhh?=
 =?utf-8?B?MHNCSUZtWGFnOHlEY2ZXaHBNbkU3RFZ4WnNwOVpZek1jMWtMTTE0R3Y1RDRL?=
 =?utf-8?B?dFJ1SzEzcTU3Znl2dnEwYmwxR3V4SHRxTmVMemtuRDA2NWlMTUNaNFIwZUFi?=
 =?utf-8?B?N2dyYXNlYjdmVHlVMDQxMjVYTFpOS1RPbHR0MnZ1T2V2eGV3OGM2U3dUWHIz?=
 =?utf-8?B?YXFkT24vK3lvbjZiS0xmOWU2WmZHcFIvYVhrdmZzajNLLzd1MEJTaGt3Vmk1?=
 =?utf-8?B?M1d1UnVSUjhBWWovM2QyWURPMlkrNnhpNExZNXkvWXRJdHJTSDRDZ2FBakQ0?=
 =?utf-8?B?bkVYKzgrTDFValN6MXdSSnpJM0dWdlkwSmw0RkZkR1R4S2NqMnUwMmY1TUY5?=
 =?utf-8?B?eFVUcWdyV253VHZwTkQ0aTRpUnoxY1cxZVMrMWpaN1QwTTd4a3JQT3IxV2hx?=
 =?utf-8?B?UVl3MXEvK0l3T2Z3aXBnV3ZoazRJTVRvb09KZStTZ1gxMU9KVWMxWEcwMk1i?=
 =?utf-8?B?dkEvaXVERVdTMW1objdLZG9WTENjODd4UVlTaUYzT1AzcHcyK2tRa3F0M2VP?=
 =?utf-8?B?ZkcyQlhFTEVzcUJmTml6MUMyajBvOWI1a1BPVklqK2pGU0lCbDhXOVJrVjI0?=
 =?utf-8?B?YlcrRDBoaTFoaEM1Y3d6TE02c2hsVGZUbDRiUmhlUXRqT3FMRDFkQjBVWkVE?=
 =?utf-8?B?Z1Vld2duR285cG1DalFnVk9adit6c2x4SkNNK1hDQXdTTUlrcERpRkJWOVNv?=
 =?utf-8?B?MXU5aHdqZmNER252SE9IZjJaTVh3WHJOYU5iNlEzNStnUkR5dFF4bEhPc3ha?=
 =?utf-8?B?MEpmWEwyR3BEWlN6YUNqcDJOcndxWUtNL0ZrWnphV2E0SGlyKzg3czNzNE9l?=
 =?utf-8?B?ZDRvTTk0Y0tKbEFlQlc3Q3REZm5FamQrTmhTdXE4ck5MUlZCTVdrNGdQNVZX?=
 =?utf-8?B?Q1hpNlVjb2cvaUsrLzBIekdRdll3MzdtSElXQjhqelNlMUNqQW85QVE1VzZz?=
 =?utf-8?B?YTJYeXZRQXd1T0wrVXhsRUZqWHZUTGxUYklCL1JrYzlrUkFjNlBiT0ErSFdp?=
 =?utf-8?B?djBjRWRkNmM3RFVpa2h5YVBmRFpRbTJ0cThHMmFyTm9KWExPQ1REajlOaDVt?=
 =?utf-8?B?eUsvR0YzWThjRnA0TVJFanc1ckJTd05iZzNsMGk3SjNjR0RJVHU4Z2UvTWw5?=
 =?utf-8?B?Q2pMVGdDVDMzVE9Gc1lxbEo3UzVWT3JOMXBEN2VLMC9GVUhhRGMySnZvUHp6?=
 =?utf-8?B?a2lJVXd1YW4rNm8rVmpkclJWOCtja2FVSmNHK3ZZUGUrMklPbkZaSVdxUll4?=
 =?utf-8?B?aWJzTnJwOUtkUjRFc0drZVVaYTlCc3lkNERhcGpPWWRPMnZtNzV3K0FHMzFv?=
 =?utf-8?Q?pkaDeW/ydFhr15ZfZ2J+Be8yaG0PbYeheLzJgF0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2100440-9ae6-4509-17be-08d988d1fde7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 14:02:54.5181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0gWIPSKNZkArbiGpVCHQw9o8ewfbLXib4r9O/0Q5+5u6a997nA5+bSqcI2DeEgWDrFEcUkey7yElizy+J3GzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5425
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



On 2021-10-06 06:14, Lin, Wayne wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Wentland, Harry <Harry.Wentland@amd.com>
>> Sent: Wednesday, October 6, 2021 1:11 AM
>> To: Lin, Wayne <Wayne.Lin@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Siqueira, Rodrigo
>> <Rodrigo.Siqueira@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Shih, Jude <Jude.Shih@amd.com>; Kizito, Jimmy
>> <Jimmy.Kizito@amd.com>; Somasundaram, Meenakshikumar <Meenakshikumar.Somasundaram@amd.com>; Lei, Jun <Jun.Lei@amd.com>
>> Subject: Re: [PATCH v2 19/23] drm/amd/display: Add debug flags for USB4 DP link training
>>
>>
>>
>> On 2021-10-05 03:52, Wayne Lin wrote:
>>> From: Jimmy Kizito <Jimmy.Kizito@amd.com>
>>>
>>> [Why & How]
>>> Additional debug flags that can be useful for testing USB4 DP link
>>> training.
>>>
>>> Add flags:
>>> - 0x2 : Forces USB4 DP link to non-LTTPR mode
>>> - 0x4 : Extends status read intervals to about 60s.
>>>
>>> Reviewed-by: Meenakshikumar Somasundaram
>>> <meenakshikumar.somasundaram@amd.com>
>>> Reviewed-by: Jun Lei <Jun.Lei@amd.com>
>>> Acked-by: Wayne Lin <Wayne.Lin@amd.com>
>>> Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>>> Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   | 6 ++++++
>>>  drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c | 6 ++++++
>>>  drivers/gpu/drm/amd/display/dc/dc.h                | 4 +++-
>>>  drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h  | 3 +++
>>>  4 files changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>>> b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>>> index bfba1d2c6a18..423fbd2b9b39 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>>> @@ -4528,6 +4528,12 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
>>>             else
>>>                     link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
>>>     }
>>> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>>
>> Why is this guarded with DC_DCN when all other DPIA code isn't?
>> It looks like it might be unnecessary.
> Thanks Harry.
> 
> Since declaration of dpia_debug variable is guarded by CONFIG_DRM_AMD_DC_DCN,
> we should keep this here.
> 

Ah, that's the one I was missing.

We could probably move it out of the DCN guard in patch 16 but
that can be done with a follow-up patch.

Technically DPIA only makes sense for DCN but there is no reason
to guard it specifically for DCN. The only reason we have the DCN
guard is to allow builds of our driver without floating point on
older HW. I wonder if that's even still needed since we now have
the fixups of the floating point stuff for PPC and ARM.

Harry

> Thanks!
>>
>>> +   /* Check DP tunnel LTTPR mode debug option. */
>>> +   if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
>>> +       link->dc->debug.dpia_debug.bits.force_non_lttpr)
>>> +           link->lttpr_mode = LTTPR_MODE_NON_LTTPR; #endif
>>>
>>>     if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT || link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
>>>             /* By reading LTTPR capability, RX assumes that we will enable diff
>>> --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
>>> b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
>>> index 7407c755a73e..ce15a38c2aea 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
>>> @@ -528,6 +528,12 @@ static uint32_t dpia_get_eq_aux_rd_interval(const struct dc_link *link,
>>>                             dp_translate_training_aux_read_interval(
>>>                                     link->dpcd_caps.lttpr_caps.aux_rd_interval[hop - 1]);
>>>
>>> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>>
>> Same here. Please drop this guard if we don't need it.
>>
>> Harry
>>
>>> +   /* Check debug option for extending aux read interval. */
>>> +   if (link->dc->debug.dpia_debug.bits.extend_aux_rd_interval)
>>> +           wait_time_microsec = DPIA_DEBUG_EXTENDED_AUX_RD_INTERVAL_US;
>>> +#endif
>>> +
>>>     return wait_time_microsec;
>>>  }
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h
>>> b/drivers/gpu/drm/amd/display/dc/dc.h
>>> index e3f884942e04..86fa94a2ef48 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dc.h
>>> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
>>> @@ -499,7 +499,9 @@ union root_clock_optimization_options {  union
>>> dpia_debug_options {
>>>     struct {
>>>             uint32_t disable_dpia:1;
>>> -           uint32_t reserved:31;
>>> +           uint32_t force_non_lttpr:1;
>>> +           uint32_t extend_aux_rd_interval:1;
>>> +           uint32_t reserved:29;
>>>     } bits;
>>>     uint32_t raw;
>>>  };
>>> diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
>>> b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
>>> index 790b904e37e1..e3dfe4c89ce0 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
>>> +++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
>>> @@ -34,6 +34,9 @@ struct dc_link_settings;
>>>  /* The approximate time (us) it takes to transmit 9 USB4 DP clock
>>> sync packets. */  #define DPIA_CLK_SYNC_DELAY 16000
>>>
>>> +/* Extend interval between training status checks for manual testing.
>>> +*/ #define DPIA_DEBUG_EXTENDED_AUX_RD_INTERVAL_US 60000000
>>> +
>>>  /** @note Can remove once DP tunneling registers in upstream
>>> include/drm/drm_dp_helper.h */
>>>  /* DPCD DP Tunneling over USB4 */
>>>  #define DP_TUNNELING_CAPABILITIES_SUPPORT 0xe000d
>>>
> --
> Regards,
> Wayne
> 

