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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ED0C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:38:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF176109E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2FF176109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3C556E830;
	Thu, 26 Aug 2021 12:38:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B2E06E830
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 12:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtYkKROaFAJG2KzHDcl0Dt9mjWaIEYtjM4OU4Ws/XmRBxwt/9NsdU/NuKXnD9Pee4tp06ALv0wOSxQtgeExDiLupJGetb0Q7PzNMKtwfG84BFEPWq0UPbSH0n3xEob2Um8zdTl9cnFrGwViUdyr4edFsefavO4t+01hexMJYF16tRW/FcBysfXPpCzgmfvCqSa0DLp4kXJTLUYIKC0RIA4uurJepIgpG4MkYoRrRMb7hS7C8xAj9FSRefrURDSmY8LWnPwcV1SNjZFKfUdzb0z5N/6YvEOIDMq/tjDr3cOtV94SIdipwWkETdw/EHyYeXQu1uLoN2K1HA5sJFuIf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXmv4WxGzg0n9rlMpXJnzpjR7+TMaNpaanWLeH2RZnE=;
 b=PJV6WKFuCEl6e9KYipbwsvRB76sHiOk12A1hxlYAiD3SnVQBXwsCBjKDV3V9hZfKYlH2kj2wUJ3n79IZZlosHHHsSrar1KGRPk6ehqGfPgnI/3YU0QYuzt02poWC3OD54QJ7xmQWbA57zZGjWXqpaI/uUyZusy5BiDEI42txEG/tZ3/N6HRkbxOwga243fC+Utdqop3P1kc7ycbo9yzShwx/4yYbY13lO3pxoGduzBunwIbwuf7c+EX5XZyio1pgX53dqj91fdELUOcR/lzAHyZWfxXLTcfy7QmDIPQ+/p3z+lnUdjd0yAAkmmL4NCzIMKGAwFPqE+QkGPrC8D2rVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXmv4WxGzg0n9rlMpXJnzpjR7+TMaNpaanWLeH2RZnE=;
 b=Yn8tUvTOtJLtfUHsyS32a8oHlyy2vv9jLavHxIXzI4Ax6NNOasn2+oB2NAAgxJpOK2aHwsI7/41wqNxcXxoE1BvWFNPEISrLuOdbNGP8dyELnMy9PZjZ4bYhQTZJa+ltfTRTr1JCQum1Qk0h3XfIR0PfM9kZR4ryTUmr48E1RP8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 12:24:29 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 12:24:29 +0000
Subject: Re: [PATCH 2/5] drm/amdgpu/vcn:set vcn encode ring priority level
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, nirmoy.das@amd.com
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
 <20210826071307.136010-2-satyajit.sahu@amd.com>
 <2a818da4-dc8e-a9b6-c85e-9a6cfef8b537@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <82b91115-b2c8-f6bf-30bb-15da77e70d09@amd.com>
Date: Thu, 26 Aug 2021 14:24:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <2a818da4-dc8e-a9b6-c85e-9a6cfef8b537@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR3P193CA0043.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::18) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:1f1e:4529:2fc9:1857]
 (2a02:908:1252:fb60:1f1e:4529:2fc9:1857) by
 PR3P193CA0043.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:51::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.23 via Frontend Transport; Thu, 26 Aug 2021 12:24:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4740112c-3b03-48fc-2164-08d9688c735e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4566:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB456679E62DBF21FDF4A2561583C79@MN2PR12MB4566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ggOEAwEV23iVSc7Q4BSufqk85dq5Uc+17WToMPTyMBwGZcUvotyvLf0g5ehcuBWIsUd6K7FoB4lpHiITx2+nnf2N/8pmoWsCMyApCclS5qvAzO96HUpm6NmYU0PUCBIdh+ysUxcsuuLDJEs2aDU97TWy0PwcWWqgFNGcHzlhb0VMSnBOFfsJySUPMZ//apD6hULK2iA4/hMNhNyG/dp1JYSz7FxYXXaSblyl+L7FSb/nE8ssa012hyg6d62cV8RtZoLLsqyQD7QQ6QGO5TTm3KFCfhl91vRBFY8DqcBdhwcJawttn+CXDxz0ERn6pN48o6KQ9/v3+FeRdjaLjGgi3Nl4bJRdiaSFgF8ERgrERyKnOdRsE31T8FxRI2xkgqndmK1wOIoVxhDSyLh2eJznZw72zd1on+MMA12WOeybrEp6Jgw7kdBISNFZYSDNVwEKqSzuLq/uCd/eRWDF47Lv9Z6SvtTXNopuq+NjwngMfvNfnCEN2paAi0LOaNSVxGGgBvfT/GJMmAzKHrRMSUzyWOScTSZ1JzTZgSdLXn/o8svxp1udBHo2FactnKatWEzCM/DEV5IqIVopIuBt/ftDxHo7ChOzO39/vc2aGlyZywNoWYhq1tKCl9k97JssCnpOgGrsT1srd0f6S/6W7viZGLsEki0txrylD2eGSpBSnanHh3FGn1SHUd9E8gXpqf98lL2MDkBjLF8I3xLXE6skba+tRgiTce/FQJ8XZ6uX3PE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(31696002)(8676002)(53546011)(31686004)(110136005)(66476007)(66946007)(66556008)(6486002)(2906002)(36756003)(316002)(2616005)(186003)(5660300002)(83380400001)(8936002)(86362001)(4326008)(6666004)(38100700002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bklEODB6M09pVldnS2lEZzZmZ3NIdzl5cW5VZWtwa0l2WHhYUzRUT1pMcFJE?=
 =?utf-8?B?c2xHb29hWGZBY2E4TWlTOW8vUi9nU2lWemxVdTVnZEtCWWVwQVRLRWNvc214?=
 =?utf-8?B?REROejNZdXRpTW5QZU1SZWxvUjlhcStGek1PSXZNTlZhKzZ3WWZGTWUvME1H?=
 =?utf-8?B?TnUrNzNlQStGekRsbCtqdkl0N0c5RHJjV3VFUVVuZ1NreE13dkxuRGNHdUZh?=
 =?utf-8?B?UHo3WmV4YjhrTFB0RGRKbTB5K1FOMW8wNzMrdnM3ZWxTdWVSTEs1S0l4cmV3?=
 =?utf-8?B?VCtrclJWTFFlM3puSGVuNHo0anRzaG84aGpWQ01KRlVVQVM5UkJVeVpSSTha?=
 =?utf-8?B?M0tDSWl5SFpmMm1MK010WkVOMmZtRmdaQU9BL1V2UkxsWGlCenoyNC9hL3du?=
 =?utf-8?B?OE1Pb2c1bVQrbTJNVXdRT2M1RGNWMERJODQ0ek13enBtdjdhYUd0a1lvUDlz?=
 =?utf-8?B?ZzZPbFF4UDJxbFBQeXhQY3duRnVXdEpBL1I2azlGRXp2dnUvVGFUeTY0b2J4?=
 =?utf-8?B?VnlvYjdkTEF1bW5HRmxZVkN3am52eUVhUnhPQXlGcDd6ZUIzYzE4TGFnYkQ4?=
 =?utf-8?B?Qzd4dElrbjYvanNxcVRFOURsaytyVEhoakppWXY4WVN2cmJvdWdLdmxIT3k3?=
 =?utf-8?B?Qi9oRmg5QWJWSXQ4SXNPZnNJb21RT1pESm9aTm0ycStCaUV3Ti9WeklrTnlY?=
 =?utf-8?B?aFZ3SU5wcEZTTEYvQzNEeGcvU0h4Y1BkRnlrK2xPeEF5cHJYK1ZmdkUxTlpP?=
 =?utf-8?B?Nkpjc3NJUEdPNFNPWkN2aG5zaXJmNnBlNFgybGFWbWphY2EvUWhMTmNqRUVn?=
 =?utf-8?B?TDQ4ZjkraEh4clJlRm5sVDNJL2VNL0xtN0MxaHhEZ3kvV2xJV0did3FOb3Bk?=
 =?utf-8?B?a2NUa1d2RmZBOWtzNzExOE1Bc3ZCL212eXdxRUNzeXNhNytvN2Z5dDB3d2I5?=
 =?utf-8?B?eWp5ajhtK0hQRkYrQ3U2c1dDZTYvV1lMT1kwNjZDWDBqSnJXZWtLbG54VHpJ?=
 =?utf-8?B?eE1FYTBqMk1OcmZVYnk5Qy91TWFWWkRnVkxQcDFwNXJWNFpGMksyYngweStJ?=
 =?utf-8?B?WTZmWXdIMVg4eXhRcHE1MWEvdVU0c1ptZGpHQ1JhU1ZsdktaVjJvRjBnVlo3?=
 =?utf-8?B?dm5VVWF3U0graUhxY0hNSjUvK0FnMDFqcVYxSGpJdHdpd1pNakJOYzYwQUN2?=
 =?utf-8?B?bVB2WHEwRkZMTHErdm5ZeDVnVm95cW9tcmJCY0h5bmQ0Q3NwbmwzN3YxWVVT?=
 =?utf-8?B?RHZrcFU0S1hIV1I1QWNoSVB2NXl2aXJ4MDlEemZybGFmOTlQN21oQWdSUnpz?=
 =?utf-8?B?dnZNemNaTWh2eWZlQTZjYUw1RUNRUFh3OGRRN2dlWWNWQ3FGQlhLMGhZdjdC?=
 =?utf-8?B?WWFUS1FwUnhTRnBNY1JxUWQxRlNsOFpGaGFtQ1N2Qm5paHprWEEvZ043cmVH?=
 =?utf-8?B?aXVmSndYRzlZWXhoQUVadHVIYlVaOHhrdEpJZW9QY002R0dvWWlnWE52cWtT?=
 =?utf-8?B?U2tId09hYjlzdFlickdNVjIzaEZ1clcxQktIV3JkZXh0aEVXUUF3T1htSFZ2?=
 =?utf-8?B?RFprNDRRMEhvV1VjNmpub24zaEgzTGRpRTlMWmMxL0NQckkxL0E1TTl5MGMy?=
 =?utf-8?B?ZFUxWHdFOTI0NndWVGMrVWp4dkhvd1NyV0NPSHFqRUUyREtvMWVuank3cWJM?=
 =?utf-8?B?QkRqRnZ5OC81MlNOVFhONlVSbWFRekxobFFES2RBT2x1b0tUUHdnS2tKeUZa?=
 =?utf-8?B?NWZGSnZBWlZ6R29DY0pUY2tGNTZHdXBYdzFzUjBlM2lPbS8xcWpua1VkMTRE?=
 =?utf-8?B?L1NzcGovaGRVRXpGa3pEUFFiZVE3Q29JTkljNjVLWWhweXdzdnlxSFNVOVBo?=
 =?utf-8?Q?b5IniqM7O11IM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4740112c-3b03-48fc-2164-08d9688c735e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 12:24:29.1753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V02JZrFK1gxnUnsWOn45cna8aJ/y/Dqkzn2KEz3bOBDnUGu8jT6cALdzFVBQ8w1t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
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



Am 26.08.21 um 13:32 schrieb Sharma, Shashank:
> Hi Satyajit,
>
> On 8/26/2021 12:43 PM, Satyajit Sahu wrote:
>> There are multiple rings available in VCN encode. Map each ring
>> to different priority.
>>
>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 ++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  9 +++++++++
>>   2 files changed, 23 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index 6780df0fb265..ce40e7a3ce05 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -951,3 +951,17 @@ int amdgpu_vcn_enc_ring_test_ib(struct 
>> amdgpu_ring *ring, long timeout)
>>         return r;
>>   }
>> +
>> +enum vcn_enc_ring_priority amdgpu_vcn_get_enc_ring_prio(int index)
>> +{
>> +    switch(index) {
>> +    case 0:
>
> As discussed in the previous patches, its far better to have MACROS or 
> enums instead of having 0/1/2 cases. As a matter of fact, we can 
> always call it RING_0 RING_1 and so on.

I strongly disagree. Adding macros or enums just to have names for the 
numbered rings doesn't gives you any advantage at all. That's just extra 
loc.

We could use the ring pointers to identify a ring instead, but using the 
switch here which is then used inside the init loop is perfectly fine.

Regards,
Christian.

>
>
> If this is being done just for the traditional reasons, we can have a 
> separate patch to replace it across the driver as well.
>
> - Shashank
>
>
>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>> +    case 1:
>> +        return AMDGPU_VCN_ENC_PRIO_HIGH;
>> +    case 2:
>> +        return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
>> +    default:
>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>> +    }
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> index d74c62b49795..938ee73dfbfc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> @@ -290,6 +290,13 @@ enum vcn_ring_type {
>>       VCN_UNIFIED_RING,
>>   };
>>   +enum vcn_enc_ring_priority {
>> +    AMDGPU_VCN_ENC_PRIO_NORMAL = 1,
>> +    AMDGPU_VCN_ENC_PRIO_HIGH,
>> +    AMDGPU_VCN_ENC_PRIO_VERY_HIGH,
>> +    AMDGPU_VCN_ENC_PRIO_MAX
>> +};
>> +
>>   int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
>>   int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
>>   int amdgpu_vcn_suspend(struct amdgpu_device *adev);
>> @@ -308,4 +315,6 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct 
>> amdgpu_ring *ring, long timeout);
>>   int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring);
>>   int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long 
>> timeout);
>>   +enum vcn_enc_ring_priority amdgpu_vcn_get_enc_ring_prio(int index);
>> +
>>   #endif
>>

