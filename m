Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC08BC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A624C610A4
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A624C610A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26CA36E82E;
	Thu, 26 Aug 2021 12:36:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4559B6E82E
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 12:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWAgaUfdvCR5e0z8DZNX8wlS2dbL5m57C1iMhkw2cbOTpaisr13YGw8ot73xLNr0mwmfMakGifXDb/QyeOI3K4EgkGPHFU5g3p7zByIUEzjL6+fD5LYpjeEdL2PPW3/pJ8MHFJF+hr2odOApWXIwJh/XgesDMuFkm9mp7BiI20rkLqCEiEV7f8YZXOk2pDvKOkRfOPJ81TqE+ga5Ey0/T38L1muru8O038zynIM5eE7Qu52nAu2XikCwt+lvyF7rXUpZn9JovPJNYh3WRJh4rcLZZb3Ga8NCnafNphidZxeZ/bt0UzWSdp0KoBUd6dKP3U/KQug44A2ZHb2ix6fk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/u4qQmY1EE6Ixkd14ysVN8+fh6WQSRtbKcrHzjchOJw=;
 b=HZUr9aznsXuXVpCTuvl8xm91o6rnaEuAH4+MqUjDEs52FKqnNhbDUcxUkqWPsWLTxOmpBz1c7vIKy64X7QFCpHdQLFkSeYoWEpHjoQGXBG5ko/VyhqTnp4R5HGF9MOw/AQFW4+eLBeBacHeZ71HIh3xRiU3uTTcR/rCfGPvgA9quR5zMH1d5vALobJxtbcIj0I9MIpLXXSYNnlzoTZWrFOZRP1cwgrZ5Ba2dBmerQAz6wYxs1TDOUX/CI1Itui5cqLbNnuHTUnb48k1KzurjD/vNn0AoEBR2SEBs1Qxxz49YsaSF7ilw4sm0xCY0TngpwyEXAuoXyitiDrg1FDZKug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/u4qQmY1EE6Ixkd14ysVN8+fh6WQSRtbKcrHzjchOJw=;
 b=aNLq4SA0F40Tp82xgWdLBbLOlFEL9EzdfBagvrOoa9oZeS7QDV0AXLC7G7MLCfxKZqQ774LQI2QkRBxSOxpbw64DNJV4iOVU3Q1K2GFWqi9gCM9y/1oMO7CMbtfU0kKplYZo+M39nCPcyg0IhO/w7m5SjHuDiZ8BRneBSQxWdxg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5135.namprd12.prod.outlook.com (2603:10b6:5:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Thu, 26 Aug
 2021 12:36:37 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b%7]) with mapi id 15.20.4457.021; Thu, 26 Aug 2021
 12:36:36 +0000
Subject: Re: [PATCH 2/5] drm/amdgpu/vcn:set vcn encode ring priority level
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, nirmoy.das@amd.com
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
 <20210826071307.136010-2-satyajit.sahu@amd.com>
 <2a818da4-dc8e-a9b6-c85e-9a6cfef8b537@amd.com>
 <82b91115-b2c8-f6bf-30bb-15da77e70d09@amd.com>
 <aa8797e7-175f-d5f4-969f-eacdaa23e65b@amd.com>
 <fc7fd983-483c-eff6-0129-9ea8e760edd0@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Message-ID: <499bdce8-4f01-1853-f564-a2cb3e90aa99@amd.com>
Date: Thu, 26 Aug 2021 18:06:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <fc7fd983-483c-eff6-0129-9ea8e760edd0@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR0101CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::18) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.68.104] (106.51.20.251) by
 MA1PR0101CA0008.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Thu, 26 Aug 2021 12:36:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25f629ea-a20a-4734-9df3-08d9688e2500
X-MS-TrafficTypeDiagnostic: DM4PR12MB5135:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5135F7A3CE2BB933773A71A5F2C79@DM4PR12MB5135.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ddkj/AuUpdRj4zdOIyOXaeBjuNMcrp5AMC22mpWK/4XhgAJ6h4/VhPzzPcEcQEkupl9Yt6KkiRHrXSQcMazPu/jd+fPghTxDRdEzwK2hQWrTOpZoFckHgtykozBfVmGCfyHQ7X6POwngy2YhjYYr7/52LKtIjsLPPDHi5IpP22TrIv0MI1xI4q1ubQ6BcGyuxGwsKNvw/JWgb6YupuDDcQjEQ7fzC4Cr7yub+X5TpFrXU63CFai/oLFqTl3RDfolT9/gG13xlOSXKLHKDy3tlf8colU8nKQbmP6sVx667bDJhV9uWVlGws6WEtu3aPMhkp119BddfcznmejSI1SaNZQr4bZuj6ObZgYo3th8JjJ/aymAVjatmaddUEuK3mW4JMoUFEhV1Aha2mH5miV33sh3YfXBa3aa6nM6ldyiJTYRHHacbcQkp+X4/4jCDbp9pAXGjLW0/Gorenty4Ifc8PR+tw9umm4HYTuEiTuz8zEuDFuj+VXgBWlIPaL7SJfREI/5lOsQHKhcPY+dNX2zVEJApy1OlGB+0uhYeguQc9qeVVFZnoLzvIiPQggOIsvsLGE2CtSPqHI/M3wqcP/cYp+DCJFcm3A3c2CcRG0rsbDyoaxZ4l7cCXr9JV0o5aXYZTkhDwwXuAHhFTetHBIjLP1Mumv9z4v0gjBkqFtebBvxgqF1MA8Aegcxo6KnpMyapm7Qbu5pV2GC+ycX75U8qz/5tir+MMAw+o1gS1LFljS2uyzE5JTg+l9qqkYzcfv7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(2906002)(55236004)(83380400001)(31696002)(956004)(2616005)(26005)(5660300002)(186003)(36756003)(6486002)(53546011)(6666004)(1006002)(66946007)(66476007)(66556008)(86362001)(8676002)(66574015)(4326008)(8936002)(38100700002)(110136005)(316002)(478600001)(16576012)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnBIYmZOQ1lvaGZtcWZkVXlxZGwxVmg2Q2U3K00rU2J0VnU1TFF0aWx2VEN3?=
 =?utf-8?B?aXJmQXdXZmpzVy9QZXBFRWdkQzBGRktlb01BMDZXbEo1eHJOdmo4ZWZSYlR0?=
 =?utf-8?B?ZHhjTUhZU2ZOTnF2U0ZER1hPYnozQVFsU3dLNDRRNUVPMHA0b1hGcGFBbnR6?=
 =?utf-8?B?VWErNGpBTXRMZVFkUmZTRzRYeFJZSWhPblVlaTNQMENzZWk3MER1MGVyNlRj?=
 =?utf-8?B?aENySXhwVnVzUmVzS092QmUxSjF3ZkNNaU5XRDZRenFNb1pJdC9GUzc2bEp3?=
 =?utf-8?B?eHpYTXEzSEN3NDU3YjZ3anZlN2NENEpGWlRjbUpEVjdsZlNmbXhoc21wUnJL?=
 =?utf-8?B?cGNFUEhBVmh4ZHg5bmlNMktvVVYySmdaZGd6U3pmZ1hmVWxnTDdaTTJBVTMx?=
 =?utf-8?B?a0xobTkrRXlPN1YzeEVXUm1FWFgvcEdxTUZDU0ZpRzJOMkpVRVBoOUlHdjZX?=
 =?utf-8?B?QUxnUm9EUnZRMHpDcGFrUFJZVGxBOEQrOHhESzc5eDYybGZwRjhLV2NVc1Z1?=
 =?utf-8?B?L1FITzBUUVlCQ3BaeHI1VnQ4WFN3RUFsdDhrQ0ZiTlJ6K0k2VWdmSEhYSTdo?=
 =?utf-8?B?cTEzbnY1MTYrWHNFUkpYcXU0Rk9KN1g1ZEUwLzdSYmFIZFVTMUNDTkh1Z0ww?=
 =?utf-8?B?cTJBZUJuanFRL2srMC9rclpQc0xYbk5lRGhmWjc4ZmVHMHBBd1h2OVRXQW9G?=
 =?utf-8?B?M2pHUmo2QnlhRTFXR3dRajdVc3NuVm5wNGhRTmxWSUtFSGxMME03ZU1EWXFk?=
 =?utf-8?B?ZWRxUERFYnc1TTJ4ZXh1aFk0dE5lclFmRC95Q3ExT0lyVWgyMDIyNEozYWlz?=
 =?utf-8?B?SmpEZmZBL0piY2VqS0lXTDlIZndEYzB1NERZa055L0pkZGd5L0NaanlzR3Bp?=
 =?utf-8?B?eERhcStHN25QSldTMko4Q3BGRWpYY0dqbTBVSnhzeDFiM3Vkek9FV20wNEk0?=
 =?utf-8?B?TlViV3pXTnpvSDFUcE0yNzN0dE40Mi9FQmNLMllNcE9icktMQ2hwT3N4RS9E?=
 =?utf-8?B?ZDVNclBIMWxlbjJ0ZWRCaTcxNExIS0NpQ29rWjlGWkJQZzZIckZGWnBmejkx?=
 =?utf-8?B?UFdRdk5FK1Mvc1ZDd0c1cW4ycVBRZ1NOKzEzTGk4VVQvd3Z2MUhDZnpXbTFq?=
 =?utf-8?B?ck5oYjFWL2NuMHk2N2tHQmx6R3FSK0JURzcxWU5yL2NkaFdBRGhhYWdzd3dW?=
 =?utf-8?B?RERrOGFqZ09DaWhGb0RjdnNpOVJDcHM1TFdmemFVNlBlN3lyK1lYV1Jta2Vn?=
 =?utf-8?B?cUcrc3FYSDc2UUhlTzdBR2lPMXVqNFhYWlRvd0I5OUhsSVBDcFVIdEEwYzFK?=
 =?utf-8?B?N3hnRVMyRlczWnZyYUt2T3diTDdGZTRKZS9UQ3ZwanB3Q3J5cHFHc1lWcVFt?=
 =?utf-8?B?REdwdTF4Z3ZDZEFJMDgrbE5VUitqRHFpQmpOTjU2VUFsTGZ2ZjRTalhuZ3BW?=
 =?utf-8?B?OE5JM3RvaHBaQmhlUGJiQXpGUHBSYmlybGNQZFZLQ1JyZHFhQldlUnozVHZV?=
 =?utf-8?B?YVVTVTJoczZWSDdMN1N0aTZaMVdSd20vTExqdDA5K2NTUjhBUWNTUmhmYWhh?=
 =?utf-8?B?VWtkKzYxako5aEk2SG9Cc3B6UGw5SmdORmVidGt0V0NnQTUrQ3JKS0kxbm9n?=
 =?utf-8?B?VGFaSlo1ajk0ZUg1TEdta0FhdTZ1KzlieXZ5MkpYaERibjY0MGI5Y1l6TVhL?=
 =?utf-8?B?RzRMblh1eUg4eThxd0dpTy9yTHUrQlc2am1saXRyOVp0c2ZLWHZGazBqVWN2?=
 =?utf-8?Q?FTnXQPMXbB9dtP13PHEq/lUn0iunHieogXyk8YR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f629ea-a20a-4734-9df3-08d9688e2500
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 12:36:36.6193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLAiiwzJth+3DhWuH+DIFsy3z84oLlpyAY2cx9fL8dALWhsr5ZxjTqQ11o40rLFLeOFJ+it48+HpveL7B7Ls5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5135
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



On 8/26/2021 6:04 PM, Christian König wrote:
> 
> Am 26.08.21 um 14:31 schrieb Sharma, Shashank:
>> On 8/26/2021 5:54 PM, Christian König wrote:
>>> Am 26.08.21 um 13:32 schrieb Sharma, Shashank:
>>>> Hi Satyajit,
>>>>
>>>> On 8/26/2021 12:43 PM, Satyajit Sahu wrote:
>>>>> There are multiple rings available in VCN encode. Map each ring
>>>>> to different priority.
>>>>>
>>>>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 ++++++++++++++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  9 +++++++++
>>>>>   2 files changed, 23 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>> index 6780df0fb265..ce40e7a3ce05 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>> @@ -951,3 +951,17 @@ int amdgpu_vcn_enc_ring_test_ib(struct 
>>>>> amdgpu_ring *ring, long timeout)
>>>>>         return r;
>>>>>   }
>>>>> +
>>>>> +enum vcn_enc_ring_priority amdgpu_vcn_get_enc_ring_prio(int index)
>>>>> +{
>>>>> +    switch(index) {
>>>>> +    case 0:
>>>>
>>>> As discussed in the previous patches, its far better to have MACROS 
>>>> or enums instead of having 0/1/2 cases. As a matter of fact, we can 
>>>> always call it RING_0 RING_1 and so on.
>>>
>>> I strongly disagree. Adding macros or enums just to have names for 
>>> the numbered rings doesn't gives you any advantage at all. That's 
>>> just extra loc.
>>>
>>
>> Honestly, when I just see case '0', its a magic number for me, and is 
>> making code less readable, harder for review, and even harder to 
>> debug. RING_0 tells me that we are mapping a ring to a priority, and 
>> clarifies the intention.
> 
> Well we should probably rename the variable then, e.g. like ring_idx or 
> just ring.
> 
> A switch on the variable named "ring" with a value of 0 has the same 
> meaning than RING_0, it's just not so much code to maintain.
> 
> Christian.

Perfect, sounds as good as anything.

- Shashank

> 
>>
>> - Shashank
>>
>>> We could use the ring pointers to identify a ring instead, but using 
>>> the switch here which is then used inside the init loop is perfectly 
>>> fine.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>>
>>>> If this is being done just for the traditional reasons, we can have 
>>>> a separate patch to replace it across the driver as well.
>>>>
>>>> - Shashank
>>>>
>>>>
>>>>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>>>>> +    case 1:
>>>>> +        return AMDGPU_VCN_ENC_PRIO_HIGH;
>>>>> +    case 2:
>>>>> +        return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
>>>>> +    default:
>>>>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>>>>> +    }
>>>>> +}
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>> index d74c62b49795..938ee73dfbfc 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>> @@ -290,6 +290,13 @@ enum vcn_ring_type {
>>>>>       VCN_UNIFIED_RING,
>>>>>   };
>>>>>   +enum vcn_enc_ring_priority {
>>>>> +    AMDGPU_VCN_ENC_PRIO_NORMAL = 1,
>>>>> +    AMDGPU_VCN_ENC_PRIO_HIGH,
>>>>> +    AMDGPU_VCN_ENC_PRIO_VERY_HIGH,
>>>>> +    AMDGPU_VCN_ENC_PRIO_MAX
>>>>> +};
>>>>> +
>>>>>   int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
>>>>>   int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
>>>>>   int amdgpu_vcn_suspend(struct amdgpu_device *adev);
>>>>> @@ -308,4 +315,6 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct 
>>>>> amdgpu_ring *ring, long timeout);
>>>>>   int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring);
>>>>>   int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long 
>>>>> timeout);
>>>>>   +enum vcn_enc_ring_priority amdgpu_vcn_get_enc_ring_prio(int index);
>>>>> +
>>>>>   #endif
>>>>>
>>>
> 
