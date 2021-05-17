Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D94C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 17:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96087611BD
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 17:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96087611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 152ED6EA27;
	Mon, 17 May 2021 17:59:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02B376EA27
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 17:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmgdSlj1ICrFMPGu8eEluIFtTuNZSnGJZkapaPNMMaNFzlOiLMWMwsG+tlIQBdz8QHuvAZJV9fpzrFWtT+6XIRJMfflWTBD83FhfXkVrPJholYwBzL+a3GKnsYbzll+z8iPmYH/lpAZfuNsjQoOh4qTdP2vmDo557fy0LKw6gioKBY2x9CbeEKswi5oXpmkkHaAloXGg7HEYizo/5/IG0c7+KPIy5jGiEmi84zWwhlaLVY4NZKqMoZ7tue6gyQOjM3EYBVo376//RzJs1S27AyuV72Q/VTNTUG/Of6rb4+O5CV5HyP+nWPYUOI5D2Ors6hiD/6LYYdOGhQHh4W+8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvGfIsmABeKvES3cv1+kpzrdzSzYefs6YdsU8PX4rqo=;
 b=XU5qNRCnY0XyHDdA7+6zG/+cfxJioLFBbOb9d1wxuBaN1Pm0t0kJUwYeHowi5MpC7QsyoACb9L4Dlyo8/u1rklNt1KHp1p49h3o6zmf6bVGEx31ZcQRtYzxWVcjPeHRbWUMLDkD6ZuJooN06XXZTVCo7d/iwR+jmTo0TP0AqNUZyARsoZq5QDLpaCBi02+1OjVCmtbzXSu+gssQpjiMDTEdVlFx/We0ZVkOEf0DEnO/vHM2+wg327pnMMvP+LBbQq5Bi6ryeY3Htjp7VuEn39Ek3vwpZCZZW2aizDZ9UbWx/2ivcD1KqS4Iv0/0EQtriFXx1mYkBlVbfuxDeutRjFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvGfIsmABeKvES3cv1+kpzrdzSzYefs6YdsU8PX4rqo=;
 b=idswIZXQMXVEfzlGNKsdiaR6N3AQDXN7wLq00G7GHO29pP+Q6GRSHS4oplvf+2waT+Zq+xnVBCzlE1UGgfA3DJ3XtCdONJ9yt9R59x1ta7aGMpujSGif/vGAdq+Ve8+vV61yF9cIfW/kkQXbj0leFOe+ljf2CAdVcxQ8Dm8gtsY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB1900.namprd12.prod.outlook.com (2603:10b6:3:10f::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Mon, 17 May 2021 17:59:35 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 17:59:35 +0000
Subject: Re: [PATCH v2 1/2] drm/amdgpu: enhance amdgpu_vcn_suspend
To: Leo Liu <leo.liu@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1621263428-8631-1-git-send-email-James.Zhu@amd.com>
 <1621266752-11959-1-git-send-email-James.Zhu@amd.com>
 <85106a30-90ee-6e04-65cd-90f8e290c3d2@amd.com>
 <15dbc004-f5d6-6722-d7bf-40ade20d2cee@amd.com>
 <3c6a0bf3-b4b4-0a93-573e-fd9ae02f16a8@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <8659d46e-58b6-d090-f95f-2ad9d4533f0e@amd.com>
Date: Mon, 17 May 2021 13:59:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <3c6a0bf3-b4b4-0a93-573e-fd9ae02f16a8@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0073.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::12) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.230.192] (165.204.55.251) by
 YT1PR01CA0073.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Mon, 17 May 2021 17:59:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e292bcb8-8735-402b-dd1a-08d9195d87b6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1900:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB190076E0AE4EC1C34BA20BD4E42D9@DM5PR12MB1900.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DOpHIm5Lc/MHlexm51yAsqu+bibjuCpwixCcRY8n8y0Bd5wTErWx8ExTEYk/6ZKdZr42FpUIMzefby2Jxm9jUopUbSd3gQrBcNM/RXeh0T4ELWsBBzoCxzt7zWPSgTL68tMu166opwf+3hYCtII/gvo2LOd9CtKGhn7PsmHcAPgWLXp7a5EWZ4WzwTuKbd4HZpARRzBeI1Urb5DJolPvxLffo6Tr/IlCpUC/+qW8aVjbKaekKuzPI+pyX5A72M+ABjkwwCW7Sd1E8eoRtAK/kj9+o2mBgbprC8l2Bhu2Un/UYznlOGiyKFrID2nyea8JYbX1HSCPqLIZ1s2N7tviKx0Bi6/54i2nlD2RTMzBQ2yHf9pMdH2BGTA0KBjLbywwUk+r3qBMhpmp8pobvxbRdLHkJdjFK4fvLswOYu2puhkg25dBn73+xPTnYLIr4OQtldjIotiy5i82pH87G0q4NlGdso5vrdMiDUP/P6mQvBjBXJ6yP4sA3cfZjFQI0N2m/Gzhhy4m1ItZ0bp+igNuIPV+nZzzwQ4IAQijpKYNvR489ZpiMyCjMgFC+/OvkbQTk8ZXwk1uPk0o7OeVg92bxEwqG87LcMiUAH4YC89EepnfbLoptG8bcmKlwRzQ0Am+UbJf6KjIVOD5oLBO7yfQnwvC0MctBb7U206dqWyhMlLewWycNjHJ/OweriWmFd3kTGYYLQKH169/Up0/zeIPpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(110136005)(478600001)(31686004)(52116002)(66476007)(66556008)(66946007)(8676002)(6486002)(36756003)(36916002)(26005)(16576012)(8936002)(5660300002)(2616005)(38350700002)(38100700002)(186003)(16526019)(956004)(83380400001)(31696002)(316002)(33964004)(53546011)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b2twQ2tYUVZMUUx3VWxEMEZ2WnVyMFJhM3daNTRyMXk3V3Z0ZU84eURkS0tn?=
 =?utf-8?B?dWlkY1owWVNiQmJENVI2TmY1VE0zL21tV1FTcGIzdlF6bVdKMHFzamdHclNF?=
 =?utf-8?B?Z0VBcUduamJBWVg3MHNMb29hajl6V2xiQWNUYlpnckVwKzF3RHRWZW50SHFw?=
 =?utf-8?B?U3gyYm9PQ3A1dUo4NCtSTjVwL01ROUhLaGZkRExvU3A4MmowOHpDQUc1ZGJP?=
 =?utf-8?B?Y2FjbTB5Ukw5eEEwbE1PSndYSUtWS1pFYjIrN2hHQkMzVkpIT0dIUFhVbFEv?=
 =?utf-8?B?SGZsRXBXVUNidDJnOWFhN3Bad25lTjJxYnVIL2ZpV0xtdWk1blJ4NHc1alpi?=
 =?utf-8?B?M1hReTExMUgwNkt0TjFHYnJvanQrQ2JqM2RFV1IzZ2FNL0pPcElnUHNRUVdV?=
 =?utf-8?B?ZXoxQmFMblBJREMwQmRjNE9uV245dnkvemphd1FlWnZ1YzY5UUk3SEYvcUVn?=
 =?utf-8?B?cmttS3c4VlZ3ZUFSanBCQ0dWZzZxWi8ra001RTR5OFlVeXhQZ1ZidmVWMWx2?=
 =?utf-8?B?elNpS2gzYWRtOGxHUHVDZnhNdktURmt6ZTFicVE2WVljSnl6MllqaSsvRnQz?=
 =?utf-8?B?clNjUFBNbVVpMmFhNUhFUWFjNWo0bXpqYW95Y3J2RjdUeDZsNWxHRXM4WXlL?=
 =?utf-8?B?cmxnQ2ZOTDRVdDF6Mm5wTGhha2JmTlQ3eWVNaVRQTGFaVHhHMnMvYlptOStv?=
 =?utf-8?B?RW12MnFZa0grZmJUR2E2L1NOeTM0WTV4SVBsUnVKRU5pK003Yjd1engvc0Mr?=
 =?utf-8?B?OUNVeXBpbjRCMzVCRXBTNmZzeGxFMVFXMmhJRjhISnlobjFyUXA5bU1DeUxr?=
 =?utf-8?B?SjZ4T0NSTHRLZTVadDFxZTVFY3p5TFkyQ2sybGo2eklvVk1YYzd3NkNiQ3ha?=
 =?utf-8?B?NEhZYTJpaEttSkJFQ25WVjFXWWhjRklGbVBudEdJdWFzWi9odXIvTFhjc1NP?=
 =?utf-8?B?Z3RBTUVkNkEzWHdsWnJHVk15Y3B1RTFmalBGZlRreEtHWTNVTE9iK0NxUFdn?=
 =?utf-8?B?cGprbVlkUVIzUFlpY2VXUHFQelN5S3d4am5UUnB6ODZNT21kc1VkdUxid1RE?=
 =?utf-8?B?SGdEZEhKTkNwNFdQMmhLMlg4V1JQbTVvSVpYMktQK0ZDU3c1MWpSOTE2alRM?=
 =?utf-8?B?K1RUWXVKMmcrUVk0UEdCTTkrajljcE9HdzQwNnBmMEVtclZSVTNLc0lOa29E?=
 =?utf-8?B?a0N1Ylp2NGxOOGVSckk2ODVvU1c0eG5BV2piRy9wYk9Wc2xZRk9EWXFFRGw1?=
 =?utf-8?B?dWE1ajZuS284d25uR0ljeU42OWpqbzNlYUUyTDFweG13aHdOOFhlWW9yWTRq?=
 =?utf-8?B?VmlNUklIa0JRY0lxZGUxT0JDMGE3aG5EaXBEUGs5UVhzV2FlWmNVMWIra0lX?=
 =?utf-8?B?MFJNdkRyVy9zRHZEZERQVFQvMkdjNld0eWdIajl4MEN0N2w1SUh3L09Td3VT?=
 =?utf-8?B?UFJPdVFKN0ZTM2NGN1V1YlhFUC8xQWVnd08yN3E1eWZkSDNrWkFpaXhCNmVt?=
 =?utf-8?B?TXYvWTUvZ2pUeU56VjRGdWJETXVxVTdyNU1WU1UvQWg0NXRWcUt1ektJN3Fs?=
 =?utf-8?B?WVdPd2hNWGhDd0xDOTRoby9JKy93R0hTK3lGbEJ2SmhGRUR3Qi9iWXZuakZM?=
 =?utf-8?B?cE9qemxERTBCUXk1QlAvMlFpVTdUeVZZaEdqY1ZYWU1sZmhXenRqQndzNzZi?=
 =?utf-8?B?cysyWCtoejJRWmIxQitPSFJZNVhtUGJtMjM4azFkV2MraWkyT05iemZ2VFdS?=
 =?utf-8?Q?xvFM0Wv0hvpAOQVaCWxssRE9N6rO9CLvGaz9vNk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e292bcb8-8735-402b-dd1a-08d9195d87b6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 17:59:35.0866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvJyZhqB5M5gPU8iTbSfCsqvNGy+oiSmm7bFl9vZ1hKSboFROaK0BIe9st1ISG1b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1900
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
Content-Type: multipart/mixed; boundary="===============0489841147=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0489841147==
Content-Type: multipart/alternative;
 boundary="------------8AB91D3A6CA4A4DECAEE0B55"
Content-Language: en-US

--------------8AB91D3A6CA4A4DECAEE0B55
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Then we forgot the proposal I provided before.

I think the below seq may fixed the race condition issue that we are facing.

1. stop scheduling new jobs

     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
         if (adev->vcn.harvest_config & (1 << i))
             continue;

         ring = &adev->vcn.inst[i].ring_dec;
         ring->sched.ready = false;

         for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
             ring = &adev->vcn.inst[i].ring_enc[j];
             ring->sched.ready = false;
         }
     }

2.    cancel_delayed_work_sync(&adev->vcn.idle_work);

3. SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
          UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);

4. amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,   
AMD_PG_STATE_GATE);

5.  saved_bo

Best Regards!

James

On 2021-05-17 1:43 p.m., Leo Liu wrote:
>
> On 2021-05-17 12:54 p.m., James Zhu wrote:
>> I am wondering if there are still some jobs kept in the queue, it is 
>> lucky to check
>
> Yes it's possible, in this case delayed handler is set, so cancelling 
> once is enough.
>
>
>>
>> UVD_POWER_STATUS done, but after, fw start a new job that list in the 
>> queue.
>>
>> To handle this situation perfectly, we need add mechanism to suspend 
>> fw first.
>
> I think that should be handled by the sequence from 
> vcn_v3_0_stop_dpg_mode().
>
>
>>
>> Another case, if it is unlucky, that  vcn fw hung at that time, 
>> UVD_POWER_STATUS
>>
>> always keeps busy.   then it needs force powering gate the vcn hw 
>> after certain time waiting.
>
> Yep, we still need to gate VCN power after certain timeout.
>
>
> Regards,
>
> Leo
>
>
>
>>
>> Best Regards!
>>
>> James
>>
>> On 2021-05-17 12:34 p.m., Leo Liu wrote:
>>>
>>> On 2021-05-17 11:52 a.m., James Zhu wrote:
>>>> During vcn suspends, stop ring continue to receive new requests,
>>>> and try to wait for all vcn jobs to finish gracefully.
>>>>
>>>> v2: Forced powering gate vcn hardware after few wainting retry.
>>>>
>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 22 +++++++++++++++++++++-
>>>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>> index 2016459..9f3a6e7 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>> @@ -275,9 +275,29 @@ int amdgpu_vcn_suspend(struct amdgpu_device 
>>>> *adev)
>>>>   {
>>>>       unsigned size;
>>>>       void *ptr;
>>>> +    int retry_max = 6;
>>>>       int i;
>>>>   - cancel_delayed_work_sync(&adev->vcn.idle_work);
>>>> +    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>> +        if (adev->vcn.harvest_config & (1 << i))
>>>> +            continue;
>>>> +        ring = &adev->vcn.inst[i].ring_dec;
>>>> +        ring->sched.ready = false;
>>>> +
>>>> +        for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
>>>> +            ring = &adev->vcn.inst[i].ring_enc[j];
>>>> +            ring->sched.ready = false;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    while (retry_max-- && 
>>>> cancel_delayed_work_sync(&adev->vcn.idle_work))
>>>> +        mdelay(5);
>>>
>>> I think it's possible to have one pending job unprocessed with VCN 
>>> when suspend sequence getting here, but it shouldn't be more than 
>>> one, cancel_delayed_work_sync probably return false after the first 
>>> time, so calling cancel_delayed_work_sync once should be enough 
>>> here. we probably need to wait longer from:
>>>
>>> SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
>>>         UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>>
>>> to make sure the unprocessed job get done.
>>>
>>>
>>> Regards,
>>>
>>> Leo
>>>
>>>
>>>> +    if (!retry_max && !amdgpu_sriov_vf(adev)) {
>>>> +        if (RREG32_SOC15(VCN, i, mmUVD_STATUS)) {
>>>> +            dev_warn(adev->dev, "Forced powering gate vcn 
>>>> hardware!");
>>>> +            vcn_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>>>> +        }
>>>> +    }
>>>>         for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>           if (adev->vcn.harvest_config & (1 << i))

--------------8AB91D3A6CA4A4DECAEE0B55
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Then we forgot the proposal I provided before.</p>
    <p>I think the below seq may fixed the race condition issue that we
      are facing.<br>
    </p>
    <p>1. stop scheduling new jobs <br>
    </p>
    <p>&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {<br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))<br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; continue;<br>
      <br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring = &amp;adev-&gt;vcn.inst[i].ring_dec;<br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false;<br>
      <br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; for (j = 0; j &lt; adev-&gt;vcn.num_enc_rings; ++j) {<br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring = &amp;adev-&gt;vcn.inst[i].ring_enc[j];<br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false;<br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>
      &nbsp;&nbsp;&nbsp; }</p>
    <p>2.&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);</p>
    <p>3.&nbsp; &nbsp; <font size="2"><span style="font-size:11pt;">SOC15_WAIT_ON_RREG(VCN,
          inst_idx, mmUVD_POWER_STATUS, 1,<br>
          &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);</span></font></p>
    <p><font size="2"><span style="font-size:11pt;">4.&nbsp;&nbsp;&nbsp; </span></font>amdgpu_device_ip_set_powergating_state(adev,
      AMD_IP_BLOCK_TYPE_VCN,&nbsp;&nbsp; AMD_PG_STATE_GATE);</p>
    <p>5.&nbsp; saved_bo</p>
    <p>Best Regards!</p>
    <p>James<br>
    </p>
    <div class="moz-cite-prefix">On 2021-05-17 1:43 p.m., Leo Liu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:3c6a0bf3-b4b4-0a93-573e-fd9ae02f16a8@amd.com">
      <br>
      On 2021-05-17 12:54 p.m., James Zhu wrote:
      <br>
      <blockquote type="cite">I am wondering if there are still some
        jobs kept in the queue, it is lucky to check
        <br>
      </blockquote>
      <br>
      Yes it's possible, in this case delayed handler is set, so
      cancelling once is enough.
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        UVD_POWER_STATUS done, but after, fw start a new job that list
        in the queue.
        <br>
        <br>
        To handle this situation perfectly, we need add mechanism to
        suspend fw first.
        <br>
      </blockquote>
      <br>
      I think that should be handled by the sequence from
      vcn_v3_0_stop_dpg_mode().
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Another case, if it is unlucky, that&nbsp; vcn fw hung at that time,
        UVD_POWER_STATUS
        <br>
        <br>
        always keeps busy.&nbsp;&nbsp; then it needs force powering gate the vcn
        hw after certain time waiting.
        <br>
      </blockquote>
      <br>
      Yep, we still need to gate VCN power after certain timeout.
      <br>
      <br>
      <br>
      Regards,
      <br>
      <br>
      Leo
      <br>
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Best Regards!
        <br>
        <br>
        James
        <br>
        <br>
        On 2021-05-17 12:34 p.m., Leo Liu wrote:
        <br>
        <blockquote type="cite">
          <br>
          On 2021-05-17 11:52 a.m., James Zhu wrote:
          <br>
          <blockquote type="cite">During vcn suspends, stop ring
            continue to receive new requests,
            <br>
            and try to wait for all vcn jobs to finish gracefully.
            <br>
            <br>
            v2: Forced powering gate vcn hardware after few wainting
            retry.
            <br>
            <br>
            Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 22
            +++++++++++++++++++++-
            <br>
            &nbsp; 1 file changed, 21 insertions(+), 1 deletion(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
            <br>
            index 2016459..9f3a6e7 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
            <br>
            @@ -275,9 +275,29 @@ int amdgpu_vcn_suspend(struct
            amdgpu_device *adev)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned size;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *ptr;
            <br>
            +&nbsp;&nbsp;&nbsp; int retry_max = 6;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp;
            cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);
            <br>
            +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt;
            i))
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring = &amp;adev-&gt;vcn.inst[i].ring_dec;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j = 0; j &lt; adev-&gt;vcn.num_enc_rings; ++j)
            {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring = &amp;adev-&gt;vcn.inst[i].ring_enc[j];
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.ready = false;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; while (retry_max-- &amp;&amp;
            cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work))
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(5);
            <br>
          </blockquote>
          <br>
          I think it's possible to have one pending job unprocessed with
          VCN when suspend sequence getting here, but it shouldn't be
          more than one, cancel_delayed_work_sync probably return false
          after the first time, so calling cancel_delayed_work_sync once
          should be enough here. we probably need to wait longer from:
          <br>
          <br>
          SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
          <br>
          &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
          <br>
          <br>
          to make sure the unprocessed job get done.
          <br>
          <br>
          <br>
          Regards,
          <br>
          <br>
          Leo
          <br>
          <br>
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp; if (!retry_max &amp;&amp;
            !amdgpu_sriov_vf(adev)) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (RREG32_SOC15(VCN, i, mmUVD_STATUS)) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Forced powering gate
            vcn hardware!&quot;);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v3_0_set_powergating_state(adev,
            AMD_PG_STATE_GATE);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt;
            i))
            <br>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------8AB91D3A6CA4A4DECAEE0B55--

--===============0489841147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0489841147==--
