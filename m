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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19F8C43216
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 12:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927A260EFF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 12:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 927A260EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F10C89819;
	Tue, 10 Aug 2021 12:43:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27E4689819
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 12:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7DDLhgiNrrb3l+bx3Xul4G8txUFKE4W65Fjqe8q24Gtbn76I5dppIHI+mvxvekbfnPFB/Eqel62fAN0R+HbNwHU5D3AsRr4O+o8zgcLRSf9KOGSFa8lG2WleoZHsVhntGXBBinQXVD1ef3wbIAniWVWWG6Fb8NAguUB2WciWJ3j6+Sc7KcvdrRPwfD4EvXDZTTHejFuY6sA1GQlCqJsDep6q+AtyedA0yPsPdbgNrwBVMA5x4tOHyJwjY1TXAeAD+iioUBv/cioRXpz8oBNRM9LcGAPehhlXi7xHsusM7Hx6aFpviqWIqxsVfJKAvL5EWiBKQ3IlpwQaz8GCsce1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40thv6Ia03Addtm99ymOr0L3RuzQyM+0MVD44Ofslb0=;
 b=LRUvhG1Tr5M0+0xdF36MYRx+Vi4NHRjnWSRjc6PSdNhKkqkQY4PDR5Knu/D5EyWjdWrg2LdzxR/oKyYmGkC06krcbvudaLOuT4VEZfqgZOmzp2gcSmsJRh3TTXfvM+3fNuFAm3Ots7RlMOmrVj8A52QGi5wVdaTf++rwatYOGz4ej3iMRmVhSHy6l6tQGuUkRqXEUL+FkBhpvvc7F4i7yfCfm+bnjxES0VnuP9jU7Fs+bPgHlxdO7YKeWC8Fvc/RQpm1t2XeCE9L0f96LKD89PUsJjVlet8iTBlI0whZV+IZInzbbQutkvqc6wT3xmfxvgyPFlFWOUmEqodZa2pnyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40thv6Ia03Addtm99ymOr0L3RuzQyM+0MVD44Ofslb0=;
 b=1+Vggo8oT5YmeCNrTxTt9aKjSSnWLXBQb8CXleZwQWHYtdYoEIM9sCxBWPcw54T85L4rSjFlnp0OlD4mtuAHvSkfED+k4YxPeWSvjKnTKOjccEfjKf1k1rG/PFwdQIFHB1hq2VQbHScLIaYTth9Jm3BwrG9xfLaB1TcEO77Uz5s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Tue, 10 Aug
 2021 12:43:00 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::688a:7dc6:322e:bfdb]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::688a:7dc6:322e:bfdb%7]) with mapi id 15.20.4415.014; Tue, 10 Aug 2021
 12:43:00 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn:enable priority queues for encoder
To: "Sahu, Satyajit" <satyajit.sahu@amd.com>, leo.liu@amd.com,
 Christian.Koenig@amd.com
Cc: Alexander.Deucher@amd.com, amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20210810070954.4480-1-satyajit.sahu@amd.com>
 <782566d7-4b9b-9595-fd26-94dfb2406161@amd.com>
 <05a3c762-87a4-b5ca-23b1-771cc09d61b5@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <7491d253-7cc6-d115-4ab6-ace48af647ef@amd.com>
Date: Tue, 10 Aug 2021 14:42:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <05a3c762-87a4-b5ca-23b1-771cc09d61b5@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0501CA0049.eurprd05.prod.outlook.com
 (2603:10a6:200:68::17) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.54.68] (165.204.72.6) by
 AM4PR0501CA0049.eurprd05.prod.outlook.com (2603:10a6:200:68::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Tue, 10 Aug 2021 12:42:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a2c40be-96f9-4628-2a82-08d95bfc631b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5165:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5165741C3ABEA7A47665A12A8BF79@DM4PR12MB5165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iwLJONKUhMYk85WMP7Gc2yHjzXFUYhgOI8zmTSQvIEZQEbipIcOBs2HO/8MjLVkJb3AAQtkjUzPzB7FGpQTD4nAmri9aFhUjo7E/Rmrbx/SFd2wAcz/he9kEbpNw4VHBDuUGa8rLreZTH/SgsNgeE172N/oZCiICBYRaWrHdD4ddlHZ3zrU8AjSIPWpzLWx5z7sc9+Edpo+xTVT3+9dGpVDNa4j9/fHXm4ZQHDv0iV6qvqSBzDFEH7SJUEqwo2di9BcPOg7OtZkj36wOIDbVUIKRyOGLgDFFVoupo2iJOKzrVK1qIpx3B6SNG5iGRnxoLaL5XYUjVGnN6yK5AI2rZ94isLcjcSJ2DRjyylgAvup2xsIlRM4RJWuq9GuXa8GDcF2tmf5bK5FlTXnvUzMuuGiiPiEuHPm0IDXqEOyK+JVgMSNLYoZaI6HOw42jUSmhYiMYc/5TN6CRJarMGC2QOHgx5ETJf1ENLpTttwo7NcQilByQnAq18tMoDXHOKq4tJoRFFjR2No9lf2Ki7EkHN2Fj5IVV+3vR7DbAAkxzH9JTyHR9ypnVCC/S6KFCm3mhlVdSjTtWX6lScxWdcOGcjsW7ZLpm7O28pOkUbL1VYCSiGDb6DSqOeJOZ//k/+WF7uNmU66A8jQo7ZawCostK1xauIY4xJclRv76x87DYgp14Ig8XR4ZVpVu5kpY8KupsgbwPTSFLaaPjTcHnYfKAroF66Z2+AlVINfoIQYmG0hkHeUAYslOCR59Rv8hSn+BI6E5lsY7SPQaXJY0Hzwqzo9E5FTnFRhM9pkra0xywQwH1Y64xJaXaMifCWnR2g3+j9B7tQHSIAXE7DzMiG0MtOu+4D6Iz9yUnH/wDlhdCRW4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(956004)(86362001)(478600001)(26005)(53546011)(52116002)(31696002)(6666004)(38350700002)(6636002)(38100700002)(5660300002)(2616005)(30864003)(186003)(4326008)(316002)(66476007)(6486002)(36756003)(16576012)(966005)(66556008)(83380400001)(66946007)(31686004)(2906002)(8936002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlVnMmZFZ01JNllWWDRIVHhCNUhSRWRWMzQwQldFdjJPVjRyVThtVC9TSnRP?=
 =?utf-8?B?NXJIZGxqKzVWYzFUemphTEY1RDhDUkRKNTR1UGVtZzhnWjlZZVFtMTBCN0Qr?=
 =?utf-8?B?NWFpdi85MVE2aloxNitLb1pVbm1KaFhxOEpJWnFNTTZjaWw1aFh1eEhOdkp0?=
 =?utf-8?B?T2JSNzRxMmJMdG96K2dPdU5LN3hULzVWM21BU2ZMSzQyOEliVGU4bmJsVzJt?=
 =?utf-8?B?NW0xZmtvV2JNeHNkd1hnOGhlVDlYS05PSExGUHpUTzFydko4M043N0xYclE2?=
 =?utf-8?B?dTRRc293cERTaEpuZVYzbVQyNlFHNjhHbUJhZ0xieGg2RzZpWk1yUjNRN244?=
 =?utf-8?B?Undkd3ZreXpVWFowZVY3YnowTmIwZmhkSCtnWkYvNHlDVjVJTTNCV0d0TjRC?=
 =?utf-8?B?dDNxeWpWYkdtNEsxWlhMUy9Cb0pUNGdWdjJFcnAvNko4Z2ZDdFhNckMxSWR0?=
 =?utf-8?B?aTBWSkhveXE3aXJzc0FEbXdncE4vWmIvOWZXOUhqdG8rNUEvNm15eU53MFcz?=
 =?utf-8?B?b2Y5MGF3cWROWjViL25jQS9ST3RXOFNyYVJ1Q2RkNEUyeW5LbVB2cGZna0Qw?=
 =?utf-8?B?bDZvU00zeGxlUldDcktDNnFQRHhHQkVMWXF2TU5SWUhaMFY5UUZJY05PcjFY?=
 =?utf-8?B?ek9HSytCYkJldWFCdmpnOEwyYlN3bXRlQlRkWXoxZzNlTzNEdXlzWk9MOU9p?=
 =?utf-8?B?M1JBdHJFTEw3dnNCR3RwRk4wVGRacTh5VjFQU3V0a3ZwRk0wazJvRkxZeXQ2?=
 =?utf-8?B?R2FQNmoyN0orUVBhbGZlZ20wT21kSzA3VkZHSmNmWmhub01DNjZ4OHkwM0FF?=
 =?utf-8?B?R2IzTk41WVhlZTNEaWNHRGcvbW5uL3hDV2tWaUdPYVcvbG5Id2YvUDI0RWsz?=
 =?utf-8?B?b3BrcGx6NU45SUx4dDNGUXh4RC94aU91U0grSFBGeHptb1htYXJYTjVydEYw?=
 =?utf-8?B?bXdiNUU3MVJuNm9ibTZSQWY3WHNPRmlEcUl0bGppQVZwMmM1VTVvUVIrVEow?=
 =?utf-8?B?TFkzcUhSd2ZidVNHaFF3Y2dKUk9TdytGbWJYNVU2NGovZUxuNTFQSUkzckhk?=
 =?utf-8?B?ZngwQW1aVkRJYnczMk9FUHJJYWtIRGM0NHFkbnBnODVkeHpjRnR5eEQydEVL?=
 =?utf-8?B?ZlAvbGxNaWZtd3hGL3dIdFZqV1NkRHBsNzlLUjlMMGZpaUM5UEZDOGpOVzB5?=
 =?utf-8?B?eURjN3dieXlKd0oxZU9lb2hUcVBBOU1xV2NOcVErR2g2MFhvUGtYRER1d0Rr?=
 =?utf-8?B?YkhSNWp6Q3Y5SCtMcnI4TUxYV3U3L294aDdQSmZncUpSN0VjdU1WV29ZTFQ0?=
 =?utf-8?B?VTBhRnVNZHd4QURJcE1XdFF5K2d0UFRTckFlNGlqMXdjKysrWENyZmFCcGQy?=
 =?utf-8?B?YTJYSlFXV2VXRThLbXZ1UW5jdXRXVndjRjZocjcwWkN1Vmk5dmdEdTFyWTA5?=
 =?utf-8?B?MHZveHpuQTlyRmNnbE43N1FzYjYycndiN0c0bmt1dXR5Q3dKMjQ5SGwwbDBj?=
 =?utf-8?B?dVQrNHhWV05GYnl4d05oZGtxZ1liT2Rjblo4OS9lQUNWd0tIc0g2MUVLWlRp?=
 =?utf-8?B?Wm9tVjU3MjBJdCswSStqRm1tNjRRR1Rra1pwcmVpME5MT3JWdkd5dXVwd0RM?=
 =?utf-8?B?d2ZlVEpRWmduRk82Mi9iOUhCcGlMV0JybTJad29QU21tdXZMSE05ekJXbWVx?=
 =?utf-8?B?d3Jqek9leS9scVp0RmJjUFpSaFFLQnhsdjk2S1VKOFdCMUFxU0FWK1FqMUsy?=
 =?utf-8?Q?xoQMDxH6bxSXPfnSKUunnLOv94KuHT7LWO87Bai?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2c40be-96f9-4628-2a82-08d95bfc631b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 12:43:00.5592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEKJlB/8o2VpGPe0+02z0v5os1P/A+LA4b35vLkc8tlvN0RAlz1kJZX3gMHLBFYR4pXyrsYvOvwHdDk3UYkoyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5165
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


On 8/10/2021 11:38 AM, Sahu, Satyajit wrote:
>
> On 8/10/2021 2:01 PM, Das, Nirmoy wrote:
>>
>> On 8/10/2021 9:09 AM, Satyajit Sahu wrote:
>>> VCN and VCE support multiple queues with different priority.
>>> Use differnt encoder queue based on the priority set by UMD.
>>>
>>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 35 
>>> +++++++++++++++++++++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c   | 14 +++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h   |  9 ++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   | 14 +++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  8 ++++++
>>>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c     |  4 ++-
>>>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c     |  4 ++-
>>>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c     |  4 ++-
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  4 ++-
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  4 ++-
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     |  4 ++-
>>>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     |  5 ++--
>>>   13 files changed, 99 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> index e7a010b7ca1f..b0ae2b45c7c3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> @@ -73,15 +73,44 @@ static enum gfx_pipe_priority 
>>> amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sch
>>>       }
>>>   }
>>>   +static enum gfx_pipe_priority 
>>> amdgpu_ctx_sched_prio_to_vcn_prio(enum drm_sched_priority prio)
>>> +{
>>> +    switch (prio) {
>>> +    case DRM_SCHED_PRIORITY_HIGH:
>>> +        return AMDGPU_VCN_ENC_PRIO_HIGH;
>>> +    case DRM_SCHED_PRIORITY_KERNEL:
>>> +        return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
>>> +    default:
>>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>>> +    }
>>> +}
>>> +
>>> +static enum gfx_pipe_priority 
>>> amdgpu_ctx_sched_prio_to_vce_prio(enum drm_sched_priority prio)
>>> +{
>>> +    switch (prio) {
>>> +    case DRM_SCHED_PRIORITY_HIGH:
>>> +        return AMDGPU_VCE_ENC_PRIO_HIGH;
>>> +    case DRM_SCHED_PRIORITY_KERNEL:
>>> +        return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
>>> +    default:
>>> +        return AMDGPU_VCE_ENC_PRIO_NORMAL;
>>> +    }
>>> +}
>>> +
>>>   static unsigned int amdgpu_ctx_prio_sched_to_hw(struct 
>>> amdgpu_device *adev,
>>>                            enum drm_sched_priority prio,
>>>                            u32 hw_ip)
>>>   {
>>>       unsigned int hw_prio;
>>>   -    hw_prio = (hw_ip == AMDGPU_HW_IP_COMPUTE) ?
>>> -            amdgpu_ctx_sched_prio_to_compute_prio(prio) :
>>> -            AMDGPU_RING_PRIO_DEFAULT;
>>> +    if (hw_ip == AMDGPU_HW_IP_COMPUTE)
>>> +        hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(prio);
>>> +    else if (hw_ip == AMDGPU_HW_IP_VCN_ENC)
>>> +        hw_prio = amdgpu_ctx_sched_prio_to_vcn_prio(prio);
>>> +    else if (hw_ip == AMDGPU_HW_IP_VCE)
>>> +        hw_prio = amdgpu_ctx_sched_prio_to_vce_prio(prio);
>>> +    else
>>> +        hw_prio = AMDGPU_RING_PRIO_DEFAULT;
>>>       hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
>>>       if (adev->gpu_sched[hw_ip][hw_prio].num_scheds == 0)
>>>           hw_prio = AMDGPU_RING_PRIO_DEFAULT;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>> index b7d861ed5284..4087acb6b8bb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>> @@ -37,7 +37,7 @@ int amdgpu_to_sched_priority(int amdgpu_priority,
>>>   {
>>>       switch (amdgpu_priority) {
>>>       case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>>> -        *prio = DRM_SCHED_PRIORITY_HIGH;
>>> +        *prio = DRM_SCHED_PRIORITY_KERNEL;
>>
>>
>> This change looks unrelated to the patch. AFAIK KERNEL priority is 
>> reserved for kernel tasks, userspace shouldn't be able to set this 
>> privilege priority.
>>
>>
>> Regards,
>>
>> Nirmoy
>
> VCE has 3 rings (General purpose, Low latency and Real time). From the 
> user side when priority VERY_HIGH(1023) is set, real time should be 
> chosen, if available. That is the reason i have mapped 
> AMDGPU_CTX_PRIORITY_VERY_HIGH to DRM_SCHED_PRIORITY_KERNEL.


How are low latency and real-time ring deffer ? Do we have usecase for 
all three types of ring ?


Apart from the priority name there is another issue with using 
DRM_SCHED_PRIORITY_KERNEL, jobs with kernel priority will not be punished[1]

[1] 
https://elixir.bootlin.com/linux/v5.13.9/source/drivers/gpu/drm/scheduler/sched_main.c#L939 



May be we should have DRM_SCHED_PRIORITY_VERY_HIGH ?


Regards,

Nirmoy


>
> regards,
>
> Satyajit
>
>>
>>>           break;
>>>       case AMDGPU_CTX_PRIORITY_HIGH:
>>>           *prio = DRM_SCHED_PRIORITY_HIGH;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> index 1ae7f824adc7..9d59ca31bc22 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> @@ -1168,3 +1168,17 @@ int amdgpu_vce_ring_test_ib(struct 
>>> amdgpu_ring *ring, long timeout)
>>>       amdgpu_bo_free_kernel(&bo, NULL, NULL);
>>>       return r;
>>>   }
>>> +
>>> +enum vce_enc_ring_priority get_vce_ring_prio(int index)
>>> +{
>>> +    switch(index) {
>>> +    case 0:
>>> +        return AMDGPU_VCE_ENC_PRIO_NORMAL;
>>> +    case 1:
>>> +        return AMDGPU_VCE_ENC_PRIO_HIGH;
>>> +    case 2:
>>> +        return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
>>> +    default:
>>> +        return AMDGPU_VCE_ENC_PRIO_NORMAL;
>>> +    }
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
>>> index d6d83a3ec803..f5265f385890 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
>>> @@ -32,6 +32,13 @@
>>>     #define AMDGPU_VCE_FW_53_45    ((53 << 24) | (45 << 16))
>>>   +enum vce_enc_ring_priority {
>>> +    AMDGPU_VCE_ENC_PRIO_NORMAL = 1,
>>> +    AMDGPU_VCE_ENC_PRIO_HIGH,
>>> +    AMDGPU_VCE_ENC_PRIO_VERY_HIGH,
>>> +    AMDGPU_VCE_ENC_PRIO_MAX
>>> +};
>>> +
>>>   struct amdgpu_vce {
>>>       struct amdgpu_bo    *vcpu_bo;
>>>       uint64_t        gpu_addr;
>>> @@ -72,4 +79,6 @@ void amdgpu_vce_ring_end_use(struct amdgpu_ring 
>>> *ring);
>>>   unsigned amdgpu_vce_ring_get_emit_ib_size(struct amdgpu_ring *ring);
>>>   unsigned amdgpu_vce_ring_get_dma_frame_size(struct amdgpu_ring 
>>> *ring);
>>>   +enum vce_enc_ring_priority get_vce_ring_prio(int index);
>>> +
>>>   #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> index 6780df0fb265..ca6cc07a726b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> @@ -951,3 +951,17 @@ int amdgpu_vcn_enc_ring_test_ib(struct 
>>> amdgpu_ring *ring, long timeout)
>>>         return r;
>>>   }
>>> +
>>> +enum vcn_enc_ring_priority get_vcn_enc_ring_prio(int index)
>>> +{
>>> +    switch(index) {
>>> +    case 0:
>>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>>> +    case 1:
>>> +        return AMDGPU_VCN_ENC_PRIO_HIGH;
>>> +    case 2:
>>> +        return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
>>> +    default:
>>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>>> +    }
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>> index d74c62b49795..bf14ee54f774 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>> @@ -290,6 +290,13 @@ enum vcn_ring_type {
>>>       VCN_UNIFIED_RING,
>>>   };
>>>   +enum vcn_enc_ring_priority {
>>> +    AMDGPU_VCN_ENC_PRIO_NORMAL = 1,
>>> +    AMDGPU_VCN_ENC_PRIO_HIGH,
>>> +    AMDGPU_VCN_ENC_PRIO_VERY_HIGH,
>>> +    AMDGPU_VCN_ENC_PRIO_MAX
>>> +};
>>> +
>>>   int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
>>>   int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
>>>   int amdgpu_vcn_suspend(struct amdgpu_device *adev);
>>> @@ -307,5 +314,6 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct 
>>> amdgpu_ring *ring, long timeout);
>>>     int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring);
>>>   int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long 
>>> timeout);
>>> +enum vcn_enc_ring_priority get_vcn_enc_ring_prio(int index);
>>>     #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>> index c7d28c169be5..2b6b7f1a77b9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>> @@ -431,10 +431,12 @@ static int vce_v2_0_sw_init(void *handle)
>>>           return r;
>>>         for (i = 0; i < adev->vce.num_rings; i++) {
>>> +        unsigned int hw_prio = get_vce_ring_prio(i);
>>> +
>>>           ring = &adev->vce.ring[i];
>>>           sprintf(ring->name, "vce%d", i);
>>>           r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
>>> -                     AMDGPU_RING_PRIO_DEFAULT, NULL);
>>> +                     hw_prio, NULL);
>>>           if (r)
>>>               return r;
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>> index 3b82fb289ef6..5ce182a837f3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>> @@ -440,10 +440,12 @@ static int vce_v3_0_sw_init(void *handle)
>>>           return r;
>>>         for (i = 0; i < adev->vce.num_rings; i++) {
>>> +        unsigned int hw_prio = get_vce_ring_prio(i);
>>> +
>>>           ring = &adev->vce.ring[i];
>>>           sprintf(ring->name, "vce%d", i);
>>>           r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
>>> -                     AMDGPU_RING_PRIO_DEFAULT, NULL);
>>> +                     hw_prio, NULL);
>>>           if (r)
>>>               return r;
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>> index 90910d19db12..c085defaabfe 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>> @@ -463,6 +463,8 @@ static int vce_v4_0_sw_init(void *handle)
>>>       }
>>>         for (i = 0; i < adev->vce.num_rings; i++) {
>>> +        unsigned int hw_prio = get_vce_ring_prio(i);
>>> +
>>>           ring = &adev->vce.ring[i];
>>>           sprintf(ring->name, "vce%d", i);
>>>           if (amdgpu_sriov_vf(adev)) {
>>> @@ -478,7 +480,7 @@ static int vce_v4_0_sw_init(void *handle)
>>>                   ring->doorbell_index = 
>>> adev->doorbell_index.uvd_vce.vce_ring2_3 * 2 + 1;
>>>           }
>>>           r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
>>> -                     AMDGPU_RING_PRIO_DEFAULT, NULL);
>>> +                     hw_prio, NULL);
>>>           if (r)
>>>               return r;
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>> index 121ee9f2b8d1..f471c65d78bc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>> @@ -145,10 +145,12 @@ static int vcn_v1_0_sw_init(void *handle)
>>>           SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
>>>         for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>> +        unsigned int hw_prio = get_vcn_enc_ring_prio(i);
>>> +
>>>           ring = &adev->vcn.inst->ring_enc[i];
>>>           sprintf(ring->name, "vcn_enc%d", i);
>>>           r = amdgpu_ring_init(adev, ring, 512, 
>>> &adev->vcn.inst->irq, 0,
>>> -                     AMDGPU_RING_PRIO_DEFAULT, NULL);
>>> +                     hw_prio, NULL);
>>>           if (r)
>>>               return r;
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>>> index f4686e918e0d..06978d5a93c7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>>> @@ -159,6 +159,8 @@ static int vcn_v2_0_sw_init(void *handle)
>>>       adev->vcn.inst->external.nop = SOC15_REG_OFFSET(UVD, 0, 
>>> mmUVD_NO_OP);
>>>         for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>> +        unsigned int hw_prio = get_vcn_enc_ring_prio(i);
>>> +
>>>           ring = &adev->vcn.inst->ring_enc[i];
>>>           ring->use_doorbell = true;
>>>           if (!amdgpu_sriov_vf(adev))
>>> @@ -167,7 +169,7 @@ static int vcn_v2_0_sw_init(void *handle)
>>>               ring->doorbell_index = 
>>> (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + i;
>>>           sprintf(ring->name, "vcn_enc%d", i);
>>>           r = amdgpu_ring_init(adev, ring, 512, 
>>> &adev->vcn.inst->irq, 0,
>>> -                     AMDGPU_RING_PRIO_DEFAULT, NULL);
>>> +                     hw_prio, NULL);
>>>           if (r)
>>>               return r;
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>> index e0c0c3734432..fba453ca74fa 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>> @@ -194,6 +194,8 @@ static int vcn_v2_5_sw_init(void *handle)
>>>               return r;
>>>             for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>> +            unsigned int hw_prio = get_vcn_enc_ring_prio(i);
>>> +
>>>               ring = &adev->vcn.inst[j].ring_enc[i];
>>>               ring->use_doorbell = true;
>>>   @@ -203,7 +205,7 @@ static int vcn_v2_5_sw_init(void *handle)
>>>               sprintf(ring->name, "vcn_enc_%d.%d", j, i);
>>>               r = amdgpu_ring_init(adev, ring, 512,
>>>                            &adev->vcn.inst[j].irq, 0,
>>> -                         AMDGPU_RING_PRIO_DEFAULT, NULL);
>>> +                         hw_prio, NULL);
>>>               if (r)
>>>                   return r;
>>>           }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> index 3d18aab88b4e..f5baf7321b0d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> @@ -224,6 +224,8 @@ static int vcn_v3_0_sw_init(void *handle)
>>>               return r;
>>>             for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
>>> +            unsigned int hw_prio = get_vcn_enc_ring_prio(j);
>>> +
>>>               /* VCN ENC TRAP */
>>>               r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
>>>                   j + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, 
>>> &adev->vcn.inst[i].irq);
>>> @@ -239,8 +241,7 @@ static int vcn_v3_0_sw_init(void *handle)
>>>               }
>>>               sprintf(ring->name, "vcn_enc_%d.%d", i, j);
>>>               r = amdgpu_ring_init(adev, ring, 512, 
>>> &adev->vcn.inst[i].irq, 0,
>>> -                         AMDGPU_RING_PRIO_DEFAULT,
>>> - &adev->vcn.inst[i].sched_score);
>>> +                         hw_prio, &adev->vcn.inst[i].sched_score);
>>>               if (r)
>>>                   return r;
>>>           }
