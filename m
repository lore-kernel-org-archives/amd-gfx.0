Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9A6C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A9A61881
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 76A9A61881
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 352926ECCD;
	Thu, 21 Oct 2021 16:46:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D376ECCD
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 16:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2J24dtiyChYmp+H68Yr6R4MVuUo42v0/Nfse+BGHZbtKxp+w6qWY64u7BDkN3uVP3iw3lDSu74OIkcclulcop/L+6Who3QcbMZjNeA/HPcHG6FAyetS5olNl5+A5pTtWD647kFLBlyGqXBQIO9aJ8bBdYvwANFQ3Et+YpJroCYlaO4b2AZp72VE32iMYULpjU7ku9AkBfBJ2US7tfjXjHR6rP/o/NtrkN4JYtvsJAzj1lddcMMRnrjYJZ8D5kf5F0VAFO5wqYYrdSHPw5XKAW/YKKYydZT9V6Aeaa9NmIChm1PqA6xX/gmZVxzAgNYnMLTJn79Y8O5jpcgJXYlAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+zhtwv54UCAG5EfChc7BVCfU1B2CSEtoWQ0IKM6Ksk=;
 b=IYea8mAEXNaEjmlPi3YLmoboo73Ua4hLytPdKvT/yW+KTNtLnXpkpo2Hn//BXJJv7zZLjkZNds24/a5aSL4GKcXt9jv8cO30Mkr+QyQ0WuPnEztfDFfn1UsFoBi/7pzjW9D1PogCZC5UUxC/7QcAtwOmXvN/urhssQvXrDmJtzJ8HA4yTgguXU7R4KYc6ZweX9L83DAU97o8iJGuiTOT7neZLwXlyf1s06k8DMUyqRpSEpUMPDLy7G10NgKFjxzhPdGgZX75NT3y73ybejxdhPChj4emDwCLQmuncjgAOO8BTlDNkEphr5r62hwCBr5ImgQcCBca4uGatQYkJpmDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+zhtwv54UCAG5EfChc7BVCfU1B2CSEtoWQ0IKM6Ksk=;
 b=zz0Ynz55a32Ia4A369IPScLlXB+SW7zVgEBVs/srJVvsdDN4BpZ7B9hNsFULFfeRvgE8kxx73MAxFV7vT7uyg8O/2oPpMqXoVD+bELYxkKbnzi3Wl34uvpS7a7Z1lnk3K+pmUW1dNcIztXHglR04Mew8z6+EaYZB6F0HkrRZNQs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3957.namprd12.prod.outlook.com (2603:10b6:610:2c::17)
 by CH2PR12MB3669.namprd12.prod.outlook.com (2603:10b6:610:27::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 16:46:43 +0000
Received: from CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::9cc9:5edf:91ad:93d9]) by CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::9cc9:5edf:91ad:93d9%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 16:46:43 +0000
Message-ID: <57a2fca7-0da8-55d6-d545-7c0dcf598628@amd.com>
Date: Thu, 21 Oct 2021 12:46:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 2/2] drm/amdgpu: Add kernel parameter support for ignoring
 bad page threshold
Content-Language: en-CA
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20211021155711.1191830-1-kent.russell@amd.com>
 <20211021155711.1191830-2-kent.russell@amd.com>
 <b6e919fb-f4f6-299d-c0c9-de15b16b7b47@amd.com>
 <DM6PR12MB332402EACCE9F2EC589B2DF285BF9@DM6PR12MB3324.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <DM6PR12MB332402EACCE9F2EC589B2DF285BF9@DM6PR12MB3324.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::22) To CH2PR12MB3957.namprd12.prod.outlook.com
 (2603:10b6:610:2c::17)
MIME-Version: 1.0
Received: from [10.254.34.99] (165.204.84.11) by
 YT1PR01CA0083.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 16:46:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef63ce61-13f2-415c-b0bc-08d994b25cfe
X-MS-TrafficTypeDiagnostic: CH2PR12MB3669:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB36692B40FCC1D951FD1CA2DD99BF9@CH2PR12MB3669.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hecdWuHkVPS0eOLoN+9CoO+urePk9Sxiam12n6ZwctKnoXSIRj3pasWLGqdykE8pJl8s6/JZUUuSj1AYp+G9NGlKpS0mXw2M6c/EChgskvnoj+B+aNPGVMUV7l452e2O0faQC+rFONZSSGfOMHDceg9edmKaeaBDmLRU8HT47HqhjsMeXRoPzsDLJNGBQkmvq7Jt9Gbx6iEJ7lAyFbqSZtE/iBNYf4jtm7leolsfeUMppamWSZeShJJlwVHnTkIHS2IuWtVmsl81uZj34DTFwvdjK+v9i02SPDLj4r4ok12bbmfm9lcCLtO/MKcptYov1QB//F+E/XWEdX6IHhM0Xr0ZNf+oj+Re27g9JfuocpTjOCkuZR2DB6V1OPXHvvwpBAWkN5u1RhfpIZRkUHHLNAAYV0oWquXiZqoarNWMnEjqrrS9ZVkHviI60m+EpQQ47I5hK1MOSrohpTCBn06F+Q6SA0vTCMv5hVitv4UZz8cdN1vMvTPQOsX6oOLJ9jHOE5OjsAXATwT/4QhNNabqxeAx5JeoolyfywD+4lQcEv1H4+Cuw7Pdg2blvjWU4Pi/qZl4SQ7/+pAN7CM04Hx02N3CLtRH7VaYdRFEWiMySQ7XiJyPmRJO/R949KwCKmOVhSw8+82ULC/cK6Q++ff2tOTnS7E097UOxKX8/ZKOSL+1bLbnwx/bgdPF02obUC8cmriRA0fmptBK7SOWDlF2kNMH//4hWApwKJuuIMj/6t6RepH02AoEhOHHlr1zXzDd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3957.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(53546011)(26005)(83380400001)(31686004)(2616005)(2906002)(54906003)(44832011)(16576012)(6486002)(316002)(38100700002)(186003)(508600001)(86362001)(5660300002)(66476007)(956004)(4001150100001)(4326008)(36756003)(8676002)(8936002)(66556008)(31696002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1h2S1NHS0dVV2VWVllXZjFybVI2VVRhYzRWeDlRS0VHK0hxeXA4T1JaZC9P?=
 =?utf-8?B?clpjNkdOckRxNWt3aFFoWXorazd0cGdLTWtNZDVCL0JYOTQ4WFVqYXBPMHNQ?=
 =?utf-8?B?dzlSSEgyNXdCeWEvRFJMQjg1eEFjOTJsVWNqSk1NWEN2TWtrd0pCYXJoZVR1?=
 =?utf-8?B?bkdSOHRHelFFcXkvUDF6VCtRZC95NzVVcnRXaGZiZ1hMQ1FYQTQzcXpOZGNG?=
 =?utf-8?B?QlVTcW40OUZvQmJWUG5pS0FJVW50WVRmZ3o1SFB2REJzWWNsVnVNNnJOZjhw?=
 =?utf-8?B?Slh4eEwrU1dNTkNOMUppQ3ZWSDVjRkNMOU5kTCt0Vm9mckRLbHo1M2lWa1NE?=
 =?utf-8?B?d2ZOR09TakdteU5RYzFvSCtDRVd4cm5YS0Qyc0JlT3F3MDBUZUpVT2dNbUVR?=
 =?utf-8?B?cEVoQjE0ZldwaGk3YjlrdFprcEE5emNHQU1jL3hoaVBaa3JtVmZTcWZDUHdZ?=
 =?utf-8?B?dE9TcDhWVkpVb3pZdWY3UGpibGovc1pGMS9mZkJYQzhkbXE0ZXE0cHVpUkpQ?=
 =?utf-8?B?ZWhJdXJyOE41WEdvMlJZcGQ5a2lZRjBCVWdQM1JRTklVZW4rR2QxM1V5OTdq?=
 =?utf-8?B?SjBkNklzTGYycG1Wb0VJZ1h4YnBqYXVIWWRPOUhnYTV2MWEyclk1RUxnMHpB?=
 =?utf-8?B?cFN4VWFXdmx2Y1grK1ZSZnkvZ0w0TjZ1S1lBcTI1WnVmSjBublh0OGdxRGlw?=
 =?utf-8?B?WmRuWkFxZ3dkdWFtaUhXUkNHakxxQWZYTk9VdUJJdjFROVo2Q1BKa21UQUJw?=
 =?utf-8?B?L0E4SGVuWXpCNkoxVGRscVJRczV4R3ZDaW90Tm1OTFZ1ZldqaVh3QzdrOHBE?=
 =?utf-8?B?dmdXckJtRlVFSHhVV3pMTElvK2M3MTA1N1NVa3BubGN4MHVOV0lXbHpaaW81?=
 =?utf-8?B?Z1JPRzRYcFRZdTZDSjdpZG5jVjI1UWVhZXdZTWpRL3R5dGhEd1Q4VGlBRS9N?=
 =?utf-8?B?T2xEQ2Uvak5VbTRPeDh4U3JaWStCT3BFR3VJN3E0NlNIczZmZEtGZDIramZy?=
 =?utf-8?B?TzI4cVFjWjNuK2tCZTlkUm14SjdEQlJGdmxpMFc5ZGFmWGdybm9TQ2pOOW13?=
 =?utf-8?B?ZTE1aDNTR1NYZkNCM09ZQjNEZTNaWmJWaWJaVHR5a3Y4YndLa3JMaC9VSGZ6?=
 =?utf-8?B?WjZxL1pnbWJENjNCeU9FQTFVUC96ODNBeVdqTUV1OEdRbEt6bXE4a2pMN1RG?=
 =?utf-8?B?WVVBcm5TaGJxbHFxMlBubjkwMzMvQTNJeXlkT2tseEtjSklJZ0RMcDc1U1NU?=
 =?utf-8?B?dmRMUnFjbldtUXovVGNVeGZYMGh2UEFWRlJ0QW1sNTQ0OFk1SHpvRzR1cWND?=
 =?utf-8?B?ZzBFaE1NU0F1WmlpRy91eGY0VHJsQkpad2dVRStGa1J2cy96dmp3UlNrZE9w?=
 =?utf-8?B?TDQ3MGVSNVJxR1VSZlFOK2V3TlFkemE0U2s5L0oxR1hRQVJDaDAvUXp3TSs2?=
 =?utf-8?B?SDNhQUdJaWpWVHdQaVBaQ3d6RGpvN3lZRXEvNlNqUEJKbDdFamlMdVBDU3Y1?=
 =?utf-8?B?QmJDU2ZzeStCWENjb3U2MGFKUkcvUE1JSnpJblo4NzR5Wm1iMjhVNS9iS05B?=
 =?utf-8?B?RmZGemVOVUJvR3B0N0xZUGFHZlYxby9jamRHNWZFSmhkSkQ0bFJuR0dCY1JE?=
 =?utf-8?B?eDFJVlhobUdXVjNJWkdmTmtBclhWSUd1M2hwWm5MZll0S2p2azNTV1RpN1Za?=
 =?utf-8?B?eXhIVktsNnNPaEpRcDE2Y2RLY0g5ZXQ5aWU4RnBwOGE5dCs0bTJ3TzZrY0k5?=
 =?utf-8?Q?h/mJqv9DMi3WoZL8TQ3sIxhzVhE+x/qZfclpCLU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef63ce61-13f2-415c-b0bc-08d994b25cfe
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:46:43.8008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltuikov@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3669
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

On 2021-10-21 12:42, Russell, Kent wrote:
> [AMD Official Use Only]
>
>
>
>> -----Original Message-----
>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
>> Sent: Thursday, October 21, 2021 12:21 PM
>> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
>> Tuikov, Luben <Luben.Tuikov@amd.com>
>> Subject: Re: [PATCH 2/2] drm/amdgpu: Add kernel parameter support for ignoring bad page
>> threshold
>>
>> On 2021-10-21 11:57, Kent Russell wrote:
>>> When a GPU hits the bad_page_threshold, it will not be initialized by
>>> the amdgpu driver. This means that the table cannot be cleared, nor can
>>> information gathering be performed (getting serial number, BDF, etc).
>>>
>>> If the bad_page_threshold kernel parameter is set to -2,
>>> continue to initialize the GPU, while printing a warning to dmesg that
>>> this action has been done
>>>
>>> Cc: Luben Tuikov <luben.tuikov@amd.com>
>>> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
>>> Signed-off-by: Kent Russell <kent.russell@amd.com>
>>> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h            |  1 +
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c        |  2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 12 ++++++++----
>>>  3 files changed, 10 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index d58e37fd01f4..b85b67a88a3d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -205,6 +205,7 @@ extern struct amdgpu_mgpu_info mgpu_info;
>>>  extern int amdgpu_ras_enable;
>>>  extern uint amdgpu_ras_mask;
>>>  extern int amdgpu_bad_page_threshold;
>>> +extern bool amdgpu_ignore_bad_page_threshold;
>>>  extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
>>>  extern int amdgpu_async_gfx_ring;
>>>  extern int amdgpu_mcbp;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 96bd63aeeddd..eee3cf874e7a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -877,7 +877,7 @@ module_param_named(reset_method, amdgpu_reset_method,
>> int, 0444);
>>>   * result in the GPU entering bad status when the number of total
>>>   * faulty pages by ECC exceeds the threshold value.
>>>   */
>>> -MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default
>> value), 0 = disable bad page retirement)");
>>> +MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default
>> value), 0 = disable bad page retirement, -2 = ignore bad page threshold)");
>>>  module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
>>>
>>>  MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup
>> (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>> index ce5089216474..bd6ed43b0df2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>> @@ -1104,11 +1104,15 @@ int amdgpu_ras_eeprom_init(struct
>> amdgpu_ras_eeprom_control *control,
>>>  			res = amdgpu_ras_eeprom_correct_header_tag(control,
>>>  								   RAS_TABLE_HDR_VAL);
>>>  		} else {
>>> -			*exceed_err_limit = true;
>>> -			dev_err(adev->dev,
>>> -				"RAS records:%d exceed threshold:%d, "
>>> -				"GPU will not be initialized. Replace this GPU or increase the
>> threshold",
>>> +			dev_err(adev->dev, "RAS records:%d exceed threshold:%d",
>>>  				control->ras_num_recs, ras->bad_page_cnt_threshold);
>> I thought this would all go in a single set of patches. I wasn't aware a singleton patch went
>> in already which changed just this line--this change was always a part of a patch set.
>>
> Ah sorry. When you reviewed the original patch2 clarifying the message, I merged it and then re-submitted the remaining 3 (which pared down to 2) for review. Sorry for the confusion, I was trying to minimize the number of moving parts.

Admittedly, now you have 3 patches, one singleton and two coming in. Would've probably be best to submit only the current two.

No worries for now--for the future.

Regards,
Luben

>
>  Kent
>
>> Regards,
>> Luben
>>
>>> +			if (amdgpu_bad_page_threshold == -2) {
>>> +				dev_warn(adev->dev, "GPU will be initialized due to
>> bad_page_threshold = -2.");
>>> +				res = 0;
>>> +			} else {
>>> +				*exceed_err_limit = true;
>>> +				dev_err(adev->dev, "GPU will not be initialized. Replace this
>> GPU or increase the threshold.");
>>> +			}
>>>  		}
>>>  	} else {
>>>  		DRM_INFO("Creating a new EEPROM table");

