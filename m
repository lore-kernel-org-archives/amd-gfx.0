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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D129C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 10:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0306F610E6
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 10:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0306F610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 950F289A62;
	Thu, 26 Aug 2021 10:01:32 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9D5F89A62
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 10:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6P9nU1+Kcj10D9zu4fS5HxvllQFnORgatQHANS6rPcJNK+kF3qsoWpcPootRlu9kUhWGYCxw/XKYAoa3bnQUKPjnpSWVxIQqbxC0ETuMqfkAxVN5DJ02JPAmeh3CqI+8S1bFgLkncMVIzgxlxO7iiiCnYQi8InU4pPP5Y5TlecAyY3k2+icFTJIAHm+FXj0hxVRcs2QV1a4nCt+SCUfnpnlL6xQff2+3An0TbqfpfIFUpfgfNHOFfnZr7jlTrba7SjL1pjQaZ4NUwNkVUl+tk2qX7gYEBTLFqv+FbOtypK/E0VjWI5baZ5fwwKfNkNlzyAnTS8/jiMUA01n3GXmDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eg/761FyQ1itdDQgYwP2bLvTabM49sp5p77pVRAPU7g=;
 b=lKOdMq9/03gOooK0pg0mFXzLVyEFeuhXKehJWUMo1gcTBz1nT3GyMUiGu6ltXj8tDIQ8mW+Vs6zvGhMU6lz4/lqRRSCmgap6yWB1YvVyn6tn0rJU4EA+kVdStH4IrWcLodQleQjOH3Tgy1N+AtiO7wKGaoPt6ZDhneG5HwScdN6mHVFEncGrvBpOu6yc8+kcPYutUBve+mZHDYLDNbkkeu43zkxg2h3Oi+Mh1mEsXJoko+Uk/KxJQQzhUxTe/TccVCu8zM+HejyX/PKqYA/M6z7HEDIgOFx8d06dOnLTAbHT/ZF5V5bU/orF4qcS/kzpbFlBslxXwbKI2LzvcrBdZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eg/761FyQ1itdDQgYwP2bLvTabM49sp5p77pVRAPU7g=;
 b=EkyC+y3vRD7drc0BMfWJadTYTJQs+3PpeZtc36pU/jxgv/4c30Yrhlf83ewjG+Se4+k9gWNPOGZS8cX/QisYDRm+FCAV1xaQ8nTOilIMEryiIgTMJNqMm6rSlr0lMV8wal4ayezc/+DPlwBXAMNplCxZWIVXhMRTzycjL7kz0bM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 10:01:29 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%7]) with mapi id 15.20.4457.019; Thu, 26 Aug 2021
 10:01:29 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: detach ring priority from gfx priority
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: satyajit.sahu@amd.com
References: <20210825154233.4882-1-nirmoy.das@amd.com>
 <b2a5e7d5-5fa1-ec27-8244-98a4a1e0a125@amd.com>
 <dca37b0b-3520-6e6a-706c-bfec244182c5@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <e9629c3a-34b7-aa30-afea-b93e76fc3b9f@amd.com>
Date: Thu, 26 Aug 2021 12:01:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <dca37b0b-3520-6e6a-706c-bfec244182c5@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR3P191CA0051.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::26) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f22:2800:79bc:ffe:47ba:625e]
 (2003:c5:8f22:2800:79bc:ffe:47ba:625e) by
 PR3P191CA0051.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Thu, 26 Aug 2021 10:01:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d68d3195-dd4d-482b-6741-08d968787965
X-MS-TrafficTypeDiagnostic: DM4PR12MB5168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB51689AFB92F315980C14846D8BC79@DM4PR12MB5168.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: If24/6KMdZinqMsais/SiZGoR9ZnPQtE+/i/ChvtCivLCTaTgXo4cRDKTlQq7NCWq9mp/37xmuoox6hbGhaRfllrhHD4quS+5mCZzyuW55oxlq1AEvazilTtSIKF3qT3qvMiYPXVBlP+Y/IJPmQIsFJjeVuZMikoTekUNODN7oafofT1+JIiW3HNLe1iNduNQQD3EmXCoJAIc3/AMWcGbWAb8UO6pspSn/s/y0Sv8dvR2Pd0uFxw9FAao431NMwu9Qo1gEOeUnr3Hg85G3iDWoisXQrWkyANt63g8xIBeRXelbPKw8WS8zOWbH7ldDoGZHB32WiaUbYdnFogIESNkrP5VcODWA5NF8sMW6H/ndrFrwngvJUn18LTwopwLPhJMIC9sapLMIYHnSLHGhW41THJikiVfz5bJgZPwM04BK6+KEvPPkeK9s6pDxiRm6na0QHsI1ciUK8pLrMbZqIuMvaBmViLedcm3ZsHVlGvNGlVKOr8HCq3ubBXpBu2/F+h/QpwSwV1G4SCl43u8909b64H1nsG9cK6VghEuBpurIaK5rkEoTrhaL8Gn+TbclzFvcJk7eL6+O2/Z6DmsuGa36+qSZeP5USy+S+BMoHDYU9MgQJsBpOfW3jf7cWVHbX+ZXwYcs6GvJ7DWztHly7ktfizyzELLE5swXNhYXVCCPPPifvbJqC4uvK/XSMpZNJ0huGyQ3CaqX24pjhNoJ6v4h6ouQL//YBbuWKKEiAqJi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(36756003)(478600001)(8936002)(4326008)(8676002)(316002)(38100700002)(2616005)(110136005)(31686004)(5660300002)(86362001)(53546011)(6486002)(6666004)(31696002)(83380400001)(52116002)(66556008)(66946007)(66476007)(186003)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUdFbzYvQUd4YkQ2TW51eUs4cUl4ZHZ1SDQ1Q25tVzR2dXhBN1l3c3FCZjhv?=
 =?utf-8?B?TVFtR1lDWDUrYkFtdXhRdnQ4TDRsd1VnYm9WTnZPWkFxclUraTQvSlZwZGRJ?=
 =?utf-8?B?Y0hTZEZVNmtiTzBESkxPaEhPREQrTzQwb0s2TG82U2xmdk90b0hXSmlaMExP?=
 =?utf-8?B?a28zdzZrdloxRmlXMkxqeTN1dHBLVGRwelJyWG9PVXZVb0gxTFJGNUtEUHF0?=
 =?utf-8?B?UHZKaVFKM0FGVTQ1akd3TTJtQXkzTXZTWjdwem92ZlNTZzFVdzhKYUNJNlVL?=
 =?utf-8?B?S0ZDSlFhWFNsY1dJNmhHNjhvMjNwT0JORkdUbGxLMG93KzFBZloxL0xnNk55?=
 =?utf-8?B?Y3hLNTJsbEZnS1k4OGdmemlicEVJTGszYWpsTGZ2cm96K3F6eFpMeVJiOWlB?=
 =?utf-8?B?aFFidWlCUVduUGh5dDNvRFVmR3lmVlBEWTVWbUUzWjJGajU0VmlrVHYzZVRE?=
 =?utf-8?B?OVhINW13NmIzTlBMUHFFVUNhckpHM2h5NExLWWNFdnRWWDNaY1l3T1podnNx?=
 =?utf-8?B?R1crQ2dIU0MxTXJMRkxheHhqRU5ESU12NWYva3dCeDQrRkxaUHRUWFltQW9Q?=
 =?utf-8?B?RU9LRmg1MU1PcExYTkpiN2pMM01EN0laQ1NaQ3luV1RjTDk0UWg5a0VKQzhE?=
 =?utf-8?B?Q3hxMG5pUnErVmhFNEtQWG15UGhjZTdNUFMwWnA3UkZ4VXJMQittNGc2Q2Rm?=
 =?utf-8?B?NU5ERkNNeEVQcTByeTUvemxFNFJ0dXZBdUMrSU9qQkhVdGZ0empVSEU2Ukxl?=
 =?utf-8?B?aUovZU5GNW9wZFdUWStydTkwd2h1OTg3THgrTTZNMVFHRjBmTmlvSXU3SmNT?=
 =?utf-8?B?V0hHNEFMaTZRVld0WUtWMk9RdlZvOGRsdG1kNm9ZQ00zRk1SSVNzNDFHZVZu?=
 =?utf-8?B?amx3YWxuRThydzFhVVRzMW43ckNKY2x6dGk3UVZROXJ6ZzZXSlNkcjh3Y09o?=
 =?utf-8?B?N21LTjg1d3dJNlpoaUdUNTlvTHpwMXVXTlJkalUwcjBtaXM2MHhONlZjR0wx?=
 =?utf-8?B?U3lzcVN3TlVRNE4ybzhkZGcwZzRERGZOMzRjbndJemVlRm5FOFlpaTBaaUtn?=
 =?utf-8?B?MXl0NDh3VytReXN5enVtbHBiTHdnemxndWxqMmZZbmRaWWVocTJPN3dqTWRS?=
 =?utf-8?B?YVpuS3Y1QnBtVWZRdWFqOUZMbmJHUytFSTI1dzhTZjJCN3J2YzNxeTZMRHZO?=
 =?utf-8?B?QnlBK0NpS0x5QzBLdHErVkJTbFQxVW5LMWl4VXlTaS9UaVNxcmpKK3dYQVJq?=
 =?utf-8?B?QzU3NGJPNWxUSHpoVGprTVI0SmxZaVl5Z0dEaERma1pzZDAyS1RndkNCa2Vq?=
 =?utf-8?B?OU5HeEo4emlmemdwT0Q2N3pWQk8wK2d2VmlRbDBBMjJWN25ZYjZuTlNhRTFt?=
 =?utf-8?B?aTFpYzE4UzFaNHBlRFFMdGsxNk5YY3pUd0t5QzBwK1lrKzgxMjIwdXJxMUd0?=
 =?utf-8?B?ZVlTVkR1bWxNWFdadndMRWxnNDg4SFdYVjdLL1R1UmZRMkZHZlJLM1RqTTNk?=
 =?utf-8?B?ZFl2OTBIT0tadm4wcjBETkVLSWxaemU4MThCdEdiUkRaZHhuSVFLVS9PeDFa?=
 =?utf-8?B?SzNTYzhDYXNoN3NIV1kzdndvMjFtRjNvbG14ZkUyQ0ZWL0toVDBJUVBOeTZM?=
 =?utf-8?B?TTBhbWFTb3VxdHkyTnVEN3dCWUNNUzh3MUJ4RDlWSjlDR0o0ZHg1VHRjNlp3?=
 =?utf-8?B?VzBwSEhuNWkvSTdOV2ZWVG9NVEtMVVhTQ2liMzVNdlN4Z0RvUCtqa1hIOUxm?=
 =?utf-8?B?T2NiWEdLMWhINUNITHdhOVY3TUZITDl1cjRZUG9YSmNWSW1XQThQdmdERWxJ?=
 =?utf-8?B?UE5EWDNJZHJLS3ZTMEp3UHV4b3JLM1MvanJpYUZnQmtXcWZVb3I0SXo5L2VH?=
 =?utf-8?Q?9wWuySvVL58D+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68d3195-dd4d-482b-6741-08d968787965
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 10:01:29.2714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QXwaK8WcBmDPXI3d0CIDpkrdcupFpLeSwfVT3RQN4SzRebYCGfKaCHDabPR1jNCUa6OVegEtvlGlttcuT5++Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5168
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


On 8/26/2021 11:54 AM, Christian König wrote:
> Am 26.08.21 um 11:27 schrieb Lazar, Lijo:
>> On 8/25/2021 9:12 PM, Nirmoy Das wrote:
>>> Currently AMDGPU_RING_PRIO_MAX is redefinition of a
>>> max gfx hwip priority, this won't work well when we will
>>> have a hwip with different set of priorities than gfx.
>>> Also, HW ring priorities are different from ring priorities.
>>>
>>> Create a global enum for ring priority levels which each
>>> HWIP can use to define its own priority levels.
>>>
>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  6 +++---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 10 ++++++++--
>>>   2 files changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> index d43fe2ed8116..937320293029 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> @@ -43,9 +43,9 @@
>>>   #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES
>>>     enum gfx_pipe_priority {
>>> -    AMDGPU_GFX_PIPE_PRIO_NORMAL = 1,
>>> -    AMDGPU_GFX_PIPE_PRIO_HIGH,
>>> -    AMDGPU_GFX_PIPE_PRIO_MAX
>>> +    AMDGPU_GFX_PIPE_PRIO_NORMAL = AMDGPU_RING_PRIO_1,
>>> +    AMDGPU_GFX_PIPE_PRIO_HIGH = AMDGPU_RING_PRIO_2,
>>> +    AMDGPU_GFX_PIPE_PRIO_MAX = AMDGPU_RING_PRIO_3
>>
>> Is this a valid priority level? If not, better avoid it.
>>
>> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Is the _MAX define even used here any more? As far as I can see you 
> removed the only use case for that below.


Yes, not used anymore. Sending a v2.

>
> If it's unused just drop it completely.
>
> Christian.
>
>>
>>>   };
>>>     /* Argument for PPSMC_MSG_GpuChangeState */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index e713d31619fe..85541005c1ad 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -36,8 +36,14 @@
>>>   #define AMDGPU_MAX_VCE_RINGS        3
>>>   #define AMDGPU_MAX_UVD_ENC_RINGS    2
>>>   -#define AMDGPU_RING_PRIO_DEFAULT    1
>>> -#define AMDGPU_RING_PRIO_MAX        AMDGPU_GFX_PIPE_PRIO_MAX
>>> +enum amdgpu_ring_priority_level {
>>> +    AMDGPU_RING_PRIO_0,
>>> +    AMDGPU_RING_PRIO_1,
>>> +    AMDGPU_RING_PRIO_DEFAULT = 1,
>>> +    AMDGPU_RING_PRIO_2,
>>> +    AMDGPU_RING_PRIO_3,
>>> +    AMDGPU_RING_PRIO_MAX
>>> +};
>>>     /* some special values for the owner field */
>>>   #define AMDGPU_FENCE_OWNER_UNDEFINED    ((void *)0ul)
>>>
>
