Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE22C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 03:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DFB606A5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 03:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 72DFB606A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFEDB6E0A1;
	Wed, 11 Aug 2021 03:52:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA81C6E09F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 03:52:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EO4l338FUyFNoROD1Re4dZ93tmZV2efXKSnnMoeVAuASEDO/VobGZoH1Uy78a88E58u8Bc6FoFRrddTYVkswPc2oWqnNr22ttUHxBWp0gCwOXPp/8JRQiuWRuiYpAmR5m5vcilkddRBUX6nOMKAR5KNicRZ1wDZZr48Ib/2uXk0lGxDPyEYhNLIrJdpG/x3ZemeYWs0Z6mVlunG62eJ72+X70yROOKiBRatdoXKxUBWO8uQk71nyL95eAsZAsGRw/ULF/OPBePL8Q0PoNrcXuSCbxjpw0H2bKmqKAjsZmqOyzWKURJRZgFSyHhP6vIeO6l6N+uOwGo5/rx12EVVIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHypq+ATpDf6f5NQJmOPCF3HzToEiz/H4EoNKFuP5vE=;
 b=hh/zMe+8HH2rik+/352afvhr80ifuOjOO2fJMuc6TAIm5zWYJVD2c2ijoviAbQakIjNZ8tmJzg2u7OxWF2IOynzeKQIN6f9mNZgEMjfpDh0q1LPT4pMKp/3llr7va3vl23ovs8tU4fcdun1m4rEjA/wGLZibTprivbKgw+hwgeGTnWeEQuDVxHg15pjFIySOzkPTpbbkDsuBJGcNQYFDLctImnyOWzKCHrJ2G7k6DET330WUhJs2heIV/183qs/pd5SP8r87Hhx+PiYmb6A9RoM8aUTQLyKUl15NoSf1RW4ZERnkFZkY1UTI5RhfX6lGNg79k/Ww9c31hXBu5Reuyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHypq+ATpDf6f5NQJmOPCF3HzToEiz/H4EoNKFuP5vE=;
 b=Tjz8HdzcocDv2GzJt/O5WKhPCAQiZ8wL3uvyZutGHUJVm/296JPjbP040quSJsHw6Ir//hxOUrNs+/KPoAQg/Q94pw5qGa7dUL7Lg0dBY4uzKfjQDQbvHzfEE+iAzirwM81wo0pjSi4nTAnpmwD1xBqgba94OxKwqBGuKU6eA34=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5035.namprd12.prod.outlook.com (2603:10b6:408:134::8)
 by BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Wed, 11 Aug
 2021 03:52:02 +0000
Received: from BN9PR12MB5035.namprd12.prod.outlook.com
 ([fe80::e8b5:25a3:551b:6fa7]) by BN9PR12MB5035.namprd12.prod.outlook.com
 ([fe80::e8b5:25a3:551b:6fa7%8]) with mapi id 15.20.4394.023; Wed, 11 Aug 2021
 03:52:02 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn:enable priority queues for encoder
To: "Das, Nirmoy" <nirmoy.das@amd.com>, leo.liu@amd.com,
 Christian.Koenig@amd.com
Cc: Alexander.Deucher@amd.com, amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20210810070954.4480-1-satyajit.sahu@amd.com>
 <782566d7-4b9b-9595-fd26-94dfb2406161@amd.com>
 <05a3c762-87a4-b5ca-23b1-771cc09d61b5@amd.com>
 <7491d253-7cc6-d115-4ab6-ace48af647ef@amd.com>
From: "Sahu, Satyajit" <satyajit.sahu@amd.com>
Message-ID: <fdee6466-44cd-ea14-df8f-2219e8387dc6@amd.com>
Date: Wed, 11 Aug 2021 09:21:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <7491d253-7cc6-d115-4ab6-ace48af647ef@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MA1PR0101CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::16) To BN9PR12MB5035.namprd12.prod.outlook.com
 (2603:10b6:408:134::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.31] (136.185.157.209) by
 MA1PR0101CA0006.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend
 Transport; Wed, 11 Aug 2021 03:52:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 870981c7-722c-4769-2dd8-08d95c7b60a5
X-MS-TrafficTypeDiagnostic: BN9PR12MB5306:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB530609A2E16821655724B96BF5F89@BN9PR12MB5306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6XN9FPMBpxA/SEYcTVPWrkyM51lbcyJlEfXhcBN9mC3eabQjistC4zazjV+I5hgqXwjmbWMxN8cyi2KzJ2J2U8v+9gBoSlBktJEUOU4HcV6BJsSNLzdG41UqNjKPtiJ8ohJvhcQm2jAqvUSs6Gq6No4OuVfg4cRc1WuDFVIevzmjpiIPMFEds/Cr0it0A6dMNrfahHtb96NsUa5EStRND7oXx3YWSVouRgq1zsgJCRt7GEGoMDZEdtya976pIlfRMVDPZg6EgShyD/TCV9DYVVhpYC8NJOqTMx8j+xzAi2wKHSQrsp0bAkgoyqK92lqrOdcQYN4Xr21Ec8Y5kJ0Mg/2JNH3sP2g3urFylOUfUULlyPnxusgaV9xSdLXaYgx056y+3vuRLGnYz9FxnGeOlPQgPLgX/bC8Um2S0m4vsQq5tdM+LtpnsuQ7myDSB50O/ooOvusZbLYmZmvkDeLZVcoiuTHeckZRKgZPJ11/uHAv9En4qB2Elv676yBxw89uGshintT07CAnAG9xInrtJKr76Sv9f+Hb6kH/5fWpO2PZK1tvEBxUAv8WJ0BNy++r3Zg9bP+wd6uHqAXkaVtzb5XmHNoOWo+e2kfRqlq1U5c9TTbJip2uFHlDsKORMRGz2vVRRWGLfLZRxAUgOkZ38R0H5pgQCxkBrXGih/MZ+0+d/L/9hGrhRX/QZOiy8DbdkZEO/dMJ/9npUKxHYJURiZvlfLb3oWxC28jjRxFA7sVxQglcOusB99N/hMlMLuE6IIJFPJ/WOFcc4kDdShaTltNhMoazHDI5wn/cTsEpUiXXC8WHna/CPGPi6sOmpO4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5035.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(8676002)(966005)(26005)(316002)(31686004)(8936002)(83380400001)(53546011)(38100700002)(16576012)(66476007)(66556008)(6486002)(36756003)(4326008)(31696002)(66946007)(6666004)(5660300002)(478600001)(2616005)(6636002)(186003)(2906002)(86362001)(956004)(30864003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVNYRUZTcG9OWnc2YlJNU3BRZk5WTnczbm1RWVlQVVAzSHN2T1E2NVJXRHFB?=
 =?utf-8?B?andCdlNhQzZDRm9SZEtmOHpCVVR3bTVoQ09LS0U2V0YyaVpTaWJIc3A5Vk1M?=
 =?utf-8?B?cHVVeGswUmhHZlZpemJSWFRyRHJxYitLWjIvaThFZGxvUVcvcFV3ZU42L3Fl?=
 =?utf-8?B?M0k3WCtHTXRQbG5nc3dJV2ZJOUdBTHNuWlJPaE1QSHUyM3c3WUJsN1JPT3N2?=
 =?utf-8?B?L3NtdUVJWTg4azNXckliaHlnWnRER0hxb3lqYU9xb0FRd2YyRWl2aXJlOVl5?=
 =?utf-8?B?Z3hGbEVnZzlCcmkvTFM0OGpnMGVJMGdVVHBCVytlU1VCaGx5UStDZjM2NFc2?=
 =?utf-8?B?aldFb1JFWCt6em11MndQQmJwbHJuQ3hhME55SVRBVUlwcDl6aWt3TEUrMGY0?=
 =?utf-8?B?cmptTDh3RWxUK0hqRlRoUkRVMXc3RkpqMlNGNklKc1JuckYraWw0N05zWXZD?=
 =?utf-8?B?ZkFXeU1rNC9paWU1WkxudGsvRm81UmQ5ME01K2hKMmZiVXVHK1BRSkZva3pN?=
 =?utf-8?B?WHc5RVhyU1pTcllEb2F2N3pqZWIvQ0VuVmsxcmt2TUpldmNlR1ZrWGVuemVB?=
 =?utf-8?B?ZWtuUGNoYmZEQk56UHBESXREYWpBeDZwbnN3WnRBVjk0VXF6SEtaNlVhejJq?=
 =?utf-8?B?eGxUaXRuUFRneXhaTzdWWEZsUUlwYm1lb2R1UmNrcnYrNzFpMjIzbng3TkpT?=
 =?utf-8?B?cDRoWkZYejlkbFQ3YUlhN2Z2WUk2RDZnYlorRTZxd0dzbE1nK2F1MHVDajcx?=
 =?utf-8?B?b3dpeTEvS1IyR29mZStXUG9obnlGNjFWZDc4OTVQcVJmVmpsbGNMZ1ByeUp2?=
 =?utf-8?B?cEMvc0tjRnFPazBoTEhXaTN4a3dMNGNramlmeGMybmY3bEZIeExvUEVudWo5?=
 =?utf-8?B?YkdEQlBQM2ZTT1lzWjhYbzcrMnhxWmdydDRqWm4zQk91RkN4NXQwd3VZcFFq?=
 =?utf-8?B?NkxWVWllelBucFVRc3N3Y01WYXhFa0xCWi9iTWdGLzRjTEdySkN1eXZyOTND?=
 =?utf-8?B?d2VCZFlCUjkvYTBkZXhyVlNzQy9xQkZkRG5ZSHRzS2o5eEYwSzF1cHNhZkFC?=
 =?utf-8?B?VVIrT0tuM0pKSHBnMkpqZG5nMVNLcm1va3BYcnRXcE1sZG9FY3l4TDdKcjVy?=
 =?utf-8?B?WFZzZldFV2dmRlRnS213ZnZKMzdtQklRQkNEeVFENzZ2QldnekxqM0wvdTdK?=
 =?utf-8?B?ZDV6STNkbXB1RFh3a3dDSnEya3U4ZzluNnNmQkVBZUxGYktPaGhKQ1QzL0Q3?=
 =?utf-8?B?dDRnbURuQ0dYTWV4T3FVdXpQWjhQdkhuZ213U01odVd4cmdlazJjQnJqUTA3?=
 =?utf-8?B?VVBET3l5L3BWc2JsQWE5N3BvTUNWTno2YzJtNmk3bzAva09QRFZneWY5eTJW?=
 =?utf-8?B?VTM1TWEwL2JjNUU3c3BCc1BMRVl0Q1VtR0w1SUpQbkoxcU9vZEt5RU1mdjFF?=
 =?utf-8?B?SzZrM0Z0Um1qdTR2Y3p3aVJJZmNxVFhURHRFQ3hNbXRQUXk3UDh4Y0xKRWY0?=
 =?utf-8?B?aWoxMk5GUHY1Z20rcWh1YTFLV0tXelBQNkFhU2NDS3hudDNTMVc3TVdWbDgy?=
 =?utf-8?B?aHdldmpXWkx5WHpCQXFVb1RKbENRelRiUFN5eDdVU2luVjVPdytpYSt3NFZZ?=
 =?utf-8?B?eUVES3dJTGMwNTNOTzY2WURUZ3k0Y0k3UWo5Z3FuOS9VVUdMK2FiV0VMRDRo?=
 =?utf-8?B?UzEyTFpOTEZCVEg1UVU4TnVRT0pkdnlHRDdWbVNMdWZLeW9wZG5TYU9qRlhF?=
 =?utf-8?Q?WH8TjJldErrBFEX/UoOmaR3y72SDqrUp+RaDXU5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870981c7-722c-4769-2dd8-08d95c7b60a5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 03:52:02.6625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwNi6khByGzNHYSYi+4PV05LuikuBDr4F97PV/3y/oOGu7bWO9d+HL8Qb74RqlfU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5306
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


On 8/10/2021 6:12 PM, Das, Nirmoy wrote:
>
> On 8/10/2021 11:38 AM, Sahu, Satyajit wrote:
>>
>> On 8/10/2021 2:01 PM, Das, Nirmoy wrote:
>>>
>>> On 8/10/2021 9:09 AM, Satyajit Sahu wrote:
>>>> VCN and VCE support multiple queues with different priority.
>>>> Use differnt encoder queue based on the priority set by UMD.
>>>>
>>>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 35 
>>>> +++++++++++++++++++++--
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |  2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c   | 14 +++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h   |  9 ++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   | 14 +++++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  8 ++++++
>>>>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c     |  4 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c     |  4 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c     |  4 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  4 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  4 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     |  4 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     |  5 ++--
>>>>   13 files changed, 99 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>>> index e7a010b7ca1f..b0ae2b45c7c3 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>>> @@ -73,15 +73,44 @@ static enum gfx_pipe_priority 
>>>> amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sch
>>>>       }
>>>>   }
>>>>   +static enum gfx_pipe_priority 
>>>> amdgpu_ctx_sched_prio_to_vcn_prio(enum drm_sched_priority prio)
>>>> +{
>>>> +    switch (prio) {
>>>> +    case DRM_SCHED_PRIORITY_HIGH:
>>>> +        return AMDGPU_VCN_ENC_PRIO_HIGH;
>>>> +    case DRM_SCHED_PRIORITY_KERNEL:
>>>> +        return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
>>>> +    default:
>>>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>>>> +    }
>>>> +}
>>>> +
>>>> +static enum gfx_pipe_priority 
>>>> amdgpu_ctx_sched_prio_to_vce_prio(enum drm_sched_priority prio)
>>>> +{
>>>> +    switch (prio) {
>>>> +    case DRM_SCHED_PRIORITY_HIGH:
>>>> +        return AMDGPU_VCE_ENC_PRIO_HIGH;
>>>> +    case DRM_SCHED_PRIORITY_KERNEL:
>>>> +        return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
>>>> +    default:
>>>> +        return AMDGPU_VCE_ENC_PRIO_NORMAL;
>>>> +    }
>>>> +}
>>>> +
>>>>   static unsigned int amdgpu_ctx_prio_sched_to_hw(struct 
>>>> amdgpu_device *adev,
>>>>                            enum drm_sched_priority prio,
>>>>                            u32 hw_ip)
>>>>   {
>>>>       unsigned int hw_prio;
>>>>   -    hw_prio = (hw_ip == AMDGPU_HW_IP_COMPUTE) ?
>>>> -            amdgpu_ctx_sched_prio_to_compute_prio(prio) :
>>>> -            AMDGPU_RING_PRIO_DEFAULT;
>>>> +    if (hw_ip == AMDGPU_HW_IP_COMPUTE)
>>>> +        hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(prio);
>>>> +    else if (hw_ip == AMDGPU_HW_IP_VCN_ENC)
>>>> +        hw_prio = amdgpu_ctx_sched_prio_to_vcn_prio(prio);
>>>> +    else if (hw_ip == AMDGPU_HW_IP_VCE)
>>>> +        hw_prio = amdgpu_ctx_sched_prio_to_vce_prio(prio);
>>>> +    else
>>>> +        hw_prio = AMDGPU_RING_PRIO_DEFAULT;
>>>>       hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
>>>>       if (adev->gpu_sched[hw_ip][hw_prio].num_scheds == 0)
>>>>           hw_prio = AMDGPU_RING_PRIO_DEFAULT;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>>> index b7d861ed5284..4087acb6b8bb 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>>> @@ -37,7 +37,7 @@ int amdgpu_to_sched_priority(int amdgpu_priority,
>>>>   {
>>>>       switch (amdgpu_priority) {
>>>>       case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>>>> -        *prio = DRM_SCHED_PRIORITY_HIGH;
>>>> +        *prio = DRM_SCHED_PRIORITY_KERNEL;
>>>
>>>
>>> This change looks unrelated to the patch. AFAIK KERNEL priority is 
>>> reserved for kernel tasks, userspace shouldn't be able to set this 
>>> privilege priority.
>>>
>>>
>>> Regards,
>>>
>>> Nirmoy
>>
>> VCE has 3 rings (General purpose, Low latency and Real time). From 
>> the user side when priority VERY_HIGH(1023) is set, real time should 
>> be chosen, if available. That is the reason i have mapped 
>> AMDGPU_CTX_PRIORITY_VERY_HIGH to DRM_SCHED_PRIORITY_KERNEL.
>
>
> How are low latency and real-time ring deffer ? Do we have usecase for 
> all three types of ring ?
>
>
> Apart from the priority name there is another issue with using 
> DRM_SCHED_PRIORITY_KERNEL, jobs with kernel priority will not be 
> punished[1]
>
> [1] 
> https://elixir.bootlin.com/linux/v5.13.9/source/drivers/gpu/drm/scheduler/sched_main.c#L939 
>
>
>
> May be we should have DRM_SCHED_PRIORITY_VERY_HIGH ?
>
>
> Regards,
>
> Nirmoy

Low latency and real time rings are different rings with different 
priorities. Adding DRM_SCHED_PRIORITY_VERY_HIGH sounds good. I will send 
the patch again with that modification.


regards,

Satyajit

>
>
>>
>> regards,
>>
>> Satyajit
>>
>>>
>>>>           break;
>>>>       case AMDGPU_CTX_PRIORITY_HIGH:
>>>>           *prio = DRM_SCHED_PRIORITY_HIGH;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>> index 1ae7f824adc7..9d59ca31bc22 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>> @@ -1168,3 +1168,17 @@ int amdgpu_vce_ring_test_ib(struct 
>>>> amdgpu_ring *ring, long timeout)
>>>>       amdgpu_bo_free_kernel(&bo, NULL, NULL);
>>>>       return r;
>>>>   }
>>>> +
>>>> +enum vce_enc_ring_priority get_vce_ring_prio(int index)
>>>> +{
>>>> +    switch(index) {
>>>> +    case 0:
>>>> +        return AMDGPU_VCE_ENC_PRIO_NORMAL;
>>>> +    case 1:
>>>> +        return AMDGPU_VCE_ENC_PRIO_HIGH;
>>>> +    case 2:
>>>> +        return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
>>>> +    default:
>>>> +        return AMDGPU_VCE_ENC_PRIO_NORMAL;
>>>> +    }
>>>> +}
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
>>>> index d6d83a3ec803..f5265f385890 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
>>>> @@ -32,6 +32,13 @@
>>>>     #define AMDGPU_VCE_FW_53_45    ((53 << 24) | (45 << 16))
>>>>   +enum vce_enc_ring_priority {
>>>> +    AMDGPU_VCE_ENC_PRIO_NORMAL = 1,
>>>> +    AMDGPU_VCE_ENC_PRIO_HIGH,
>>>> +    AMDGPU_VCE_ENC_PRIO_VERY_HIGH,
>>>> +    AMDGPU_VCE_ENC_PRIO_MAX
>>>> +};
>>>> +
>>>>   struct amdgpu_vce {
>>>>       struct amdgpu_bo    *vcpu_bo;
>>>>       uint64_t        gpu_addr;
>>>> @@ -72,4 +79,6 @@ void amdgpu_vce_ring_end_use(struct amdgpu_ring 
>>>> *ring);
>>>>   unsigned amdgpu_vce_ring_get_emit_ib_size(struct amdgpu_ring *ring);
>>>>   unsigned amdgpu_vce_ring_get_dma_frame_size(struct amdgpu_ring 
>>>> *ring);
>>>>   +enum vce_enc_ring_priority get_vce_ring_prio(int index);
>>>> +
>>>>   #endif
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>> index 6780df0fb265..ca6cc07a726b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>> @@ -951,3 +951,17 @@ int amdgpu_vcn_enc_ring_test_ib(struct 
>>>> amdgpu_ring *ring, long timeout)
>>>>         return r;
>>>>   }
>>>> +
>>>> +enum vcn_enc_ring_priority get_vcn_enc_ring_prio(int index)
>>>> +{
>>>> +    switch(index) {
>>>> +    case 0:
>>>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>>>> +    case 1:
>>>> +        return AMDGPU_VCN_ENC_PRIO_HIGH;
>>>> +    case 2:
>>>> +        return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
>>>> +    default:
>>>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>>>> +    }
>>>> +}
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>> index d74c62b49795..bf14ee54f774 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>> @@ -290,6 +290,13 @@ enum vcn_ring_type {
>>>>       VCN_UNIFIED_RING,
>>>>   };
>>>>   +enum vcn_enc_ring_priority {
>>>> +    AMDGPU_VCN_ENC_PRIO_NORMAL = 1,
>>>> +    AMDGPU_VCN_ENC_PRIO_HIGH,
>>>> +    AMDGPU_VCN_ENC_PRIO_VERY_HIGH,
>>>> +    AMDGPU_VCN_ENC_PRIO_MAX
>>>> +};
>>>> +
>>>>   int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
>>>>   int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
>>>>   int amdgpu_vcn_suspend(struct amdgpu_device *adev);
>>>> @@ -307,5 +314,6 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct 
>>>> amdgpu_ring *ring, long timeout);
>>>>     int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring);
>>>>   int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long 
>>>> timeout);
>>>> +enum vcn_enc_ring_priority get_vcn_enc_ring_prio(int index);
>>>>     #endif
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>>> index c7d28c169be5..2b6b7f1a77b9 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>>> @@ -431,10 +431,12 @@ static int vce_v2_0_sw_init(void *handle)
>>>>           return r;
>>>>         for (i = 0; i < adev->vce.num_rings; i++) {
>>>> +        unsigned int hw_prio = get_vce_ring_prio(i);
>>>> +
>>>>           ring = &adev->vce.ring[i];
>>>>           sprintf(ring->name, "vce%d", i);
>>>>           r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
>>>> -                     AMDGPU_RING_PRIO_DEFAULT, NULL);
>>>> +                     hw_prio, NULL);
>>>>           if (r)
>>>>               return r;
>>>>       }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>>> index 3b82fb289ef6..5ce182a837f3 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>>> @@ -440,10 +440,12 @@ static int vce_v3_0_sw_init(void *handle)
>>>>           return r;
>>>>         for (i = 0; i < adev->vce.num_rings; i++) {
>>>> +        unsigned int hw_prio = get_vce_ring_prio(i);
>>>> +
>>>>           ring = &adev->vce.ring[i];
>>>>           sprintf(ring->name, "vce%d", i);
>>>>           r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
>>>> -                     AMDGPU_RING_PRIO_DEFAULT, NULL);
>>>> +                     hw_prio, NULL);
>>>>           if (r)
>>>>               return r;
>>>>       }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>> index 90910d19db12..c085defaabfe 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>>> @@ -463,6 +463,8 @@ static int vce_v4_0_sw_init(void *handle)
>>>>       }
>>>>         for (i = 0; i < adev->vce.num_rings; i++) {
>>>> +        unsigned int hw_prio = get_vce_ring_prio(i);
>>>> +
>>>>           ring = &adev->vce.ring[i];
>>>>           sprintf(ring->name, "vce%d", i);
>>>>           if (amdgpu_sriov_vf(adev)) {
>>>> @@ -478,7 +480,7 @@ static int vce_v4_0_sw_init(void *handle)
>>>>                   ring->doorbell_index = 
>>>> adev->doorbell_index.uvd_vce.vce_ring2_3 * 2 + 1;
>>>>           }
>>>>           r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
>>>> -                     AMDGPU_RING_PRIO_DEFAULT, NULL);
>>>> +                     hw_prio, NULL);
>>>>           if (r)
>>>>               return r;
>>>>       }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>> index 121ee9f2b8d1..f471c65d78bc 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>> @@ -145,10 +145,12 @@ static int vcn_v1_0_sw_init(void *handle)
>>>>           SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
>>>>         for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>>> +        unsigned int hw_prio = get_vcn_enc_ring_prio(i);
>>>> +
>>>>           ring = &adev->vcn.inst->ring_enc[i];
>>>>           sprintf(ring->name, "vcn_enc%d", i);
>>>>           r = amdgpu_ring_init(adev, ring, 512, 
>>>> &adev->vcn.inst->irq, 0,
>>>> -                     AMDGPU_RING_PRIO_DEFAULT, NULL);
>>>> +                     hw_prio, NULL);
>>>>           if (r)
>>>>               return r;
>>>>       }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>>>> index f4686e918e0d..06978d5a93c7 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>>>> @@ -159,6 +159,8 @@ static int vcn_v2_0_sw_init(void *handle)
>>>>       adev->vcn.inst->external.nop = SOC15_REG_OFFSET(UVD, 0, 
>>>> mmUVD_NO_OP);
>>>>         for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>>> +        unsigned int hw_prio = get_vcn_enc_ring_prio(i);
>>>> +
>>>>           ring = &adev->vcn.inst->ring_enc[i];
>>>>           ring->use_doorbell = true;
>>>>           if (!amdgpu_sriov_vf(adev))
>>>> @@ -167,7 +169,7 @@ static int vcn_v2_0_sw_init(void *handle)
>>>>               ring->doorbell_index = 
>>>> (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + i;
>>>>           sprintf(ring->name, "vcn_enc%d", i);
>>>>           r = amdgpu_ring_init(adev, ring, 512, 
>>>> &adev->vcn.inst->irq, 0,
>>>> -                     AMDGPU_RING_PRIO_DEFAULT, NULL);
>>>> +                     hw_prio, NULL);
>>>>           if (r)
>>>>               return r;
>>>>       }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>>> index e0c0c3734432..fba453ca74fa 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>>> @@ -194,6 +194,8 @@ static int vcn_v2_5_sw_init(void *handle)
>>>>               return r;
>>>>             for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>>> +            unsigned int hw_prio = get_vcn_enc_ring_prio(i);
>>>> +
>>>>               ring = &adev->vcn.inst[j].ring_enc[i];
>>>>               ring->use_doorbell = true;
>>>>   @@ -203,7 +205,7 @@ static int vcn_v2_5_sw_init(void *handle)
>>>>               sprintf(ring->name, "vcn_enc_%d.%d", j, i);
>>>>               r = amdgpu_ring_init(adev, ring, 512,
>>>>                            &adev->vcn.inst[j].irq, 0,
>>>> -                         AMDGPU_RING_PRIO_DEFAULT, NULL);
>>>> +                         hw_prio, NULL);
>>>>               if (r)
>>>>                   return r;
>>>>           }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>>> index 3d18aab88b4e..f5baf7321b0d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>>> @@ -224,6 +224,8 @@ static int vcn_v3_0_sw_init(void *handle)
>>>>               return r;
>>>>             for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
>>>> +            unsigned int hw_prio = get_vcn_enc_ring_prio(j);
>>>> +
>>>>               /* VCN ENC TRAP */
>>>>               r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
>>>>                   j + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, 
>>>> &adev->vcn.inst[i].irq);
>>>> @@ -239,8 +241,7 @@ static int vcn_v3_0_sw_init(void *handle)
>>>>               }
>>>>               sprintf(ring->name, "vcn_enc_%d.%d", i, j);
>>>>               r = amdgpu_ring_init(adev, ring, 512, 
>>>> &adev->vcn.inst[i].irq, 0,
>>>> -                         AMDGPU_RING_PRIO_DEFAULT,
>>>> - &adev->vcn.inst[i].sched_score);
>>>> +                         hw_prio, &adev->vcn.inst[i].sched_score);
>>>>               if (r)
>>>>                   return r;
>>>>           }
