Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1702C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 22:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56BD2601FA
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 22:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 56BD2601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5F1D6E3F5;
	Wed, 20 Oct 2021 22:32:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 890FF6E3F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 22:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpcNjCMQ37lgLqtBwI6ccCStdLdQI13+KInD2IUoh14OZwq11zU0DgJCPEzkZSxqQEdCBUbrlZELzJkNlHuY2SyXB2fB+ZK7qMB3xb3BxdOHcpkY5cBO4YQWqzjBSzdP5wWF3ekZUr2d7qgX8vdXDowrN2NjOmaRr6/43UMq+iZnhxI1P6Xq8LWt3DX8VvidVRIDWP2v4y/DATr4JrhNVRzImbgWmEQibqr4tf30O7Xm26YS5jZkB2+fDzrl1Ws9kJB2oQ9FaZfectuoqDPKNmt94ovBvJArmDavdAa9O04Dd7S7HwtruhVnOlRIpFqpokx3Zos0PvDlpC9/T3njxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6vZSABAlfJYGygaM9KBKYeN6Ze064jZGJaoFmkFvWk=;
 b=J4KLP6EAystecmvAI3b3mUSBBW6EwVFwUr7UO/+KQFAWDFaO3hfY8dfITf1V8PaEEdAA+vbDE8WJex/PV21fQASDsyWxLS+zLtYDx/mfoE9zUW6uaqRtkhOZDTvuoF9UPi4kUvgTrcN7994D7SpOTQFVINphrt/AoWrAtUJR1fkkwcciIORkY3sB98DuF1r0te06/uUxOVx48cnLAD1hhk9ANnLpC3GPUQ483L1MenEEgyrBeHUemWLVNi0tNhFAstX3brd6v8fz+0bmzxhP0YB11lb2xUnLtQZwH8m8VmV9fbrlixOeoV3A7pB2msrMcR6IS/FTAkDDfIRUrbXwYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6vZSABAlfJYGygaM9KBKYeN6Ze064jZGJaoFmkFvWk=;
 b=SwA0umNiugt48+2qVwlVktexBnH5nt6YcL6rkK4Z1IDfTnP3IYHtEJiejlohPrNV2O2wM5ygjD7lEOkmzffJrOK0OensBTAq2j0RzR7O2Lz5OOtONOvkGMQfNv7lBLbkhUg3xxqKiOqrfTK3PfdTPM9TpiZzBbL7jp2uAkDM10Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 22:31:59 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4608.019; Wed, 20 Oct 2021
 22:31:59 +0000
Subject: Re: [PATCH 1/3] drm/amdgpu: Warn when bad pages approaches 90%
 threshold
From: Felix Kuehling <felix.kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org, "Russell, Kent" <Kent.Russell@amd.com>
Cc: Luben Tuikov <luben.tuikov@amd.com>, Mukul Joshi <Mukul.Joshi@amd.com>
References: <20211020163520.1167214-1-kent.russell@amd.com>
 <50882392-beb7-b7bc-01c9-04945ffdec00@amd.com>
Organization: AMD Inc.
Message-ID: <b61505ea-d736-8efc-5edf-b8d08f5bd60b@amd.com>
Date: Wed, 20 Oct 2021 18:31:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <50882392-beb7-b7bc-01c9-04945ffdec00@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: LO2P265CA0172.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::16) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 LO2P265CA0172.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 22:31:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87a3e3b6-0ce4-4032-66ed-08d994196df4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3737:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3737600531401A050FA14E5292BE9@DM6PR12MB3737.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRzz7/e28Pu8uEKatBSyxVHZqlGhaw9ZXBavY8/vuj1dMrSh9BnicxsseEVFEgFavrJHX+q1kEa3KmWJUrvKjFQ5ABDrWwSAZt0CfjUjijccMdSzseMw1bwbC1yRPV1BIq2rKmphLI/LTXRVd8bYnF4oyMpjFzHzytrLaRm+MHesrZP2YEpJFq32hzd2FYqIr/98qtrL5U7caxk5N88ngLN5jJWOjrI5cYpzRlkDG6g0KjBOwIQtGdd5M6BWIRUP88O7bhyDyxOYkiRRMkgvVcn2XkRgHcQs3MpjBIOIr+iE5n5rM3VEZojUmyQZh/ER7C7aycZ5eldrmVIc+sI2p2RmM2AyP8bonyvcCJ63dnx5POgYYSGGxZIAZXxIykrsiBujRVLYTZSxheyTbIJg/KDut/zZOfQaeafawlgMyaLSwfYCP6RujUVbZgCaMRwfmcSEUY0LIXcmNucypghDN9sCkobe038UvEDXU1J2ecltA5B2/HGFAqnllTXRI7L6EUX149cmPUeoPyX0sfJRxyVcFnsOVXkWpY2t1UkQ1419FdTHv/AG8xDUMPDGyZ+v8Rd+KOIGkOmw6prrYcyvfPVQgMhVhYqwyEGZzkWbmv1fHeK3nLnJFtS8/KbkYUeYx9vakEbTzOvLmD2hO0OOAg6tcBT7pNAok22x7vmYrnVX16IRQv0xKtEBqci+klC9Amm6G7p6/Ba8nvvPyNuL6nmRYBL7hIgXMpBbe2+QYcFL7rF0hT1zKh2hPMIpophG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(2906002)(36756003)(956004)(36916002)(6666004)(16576012)(83380400001)(4001150100001)(6862004)(53546011)(44832011)(8676002)(508600001)(2616005)(31696002)(26005)(6636002)(66476007)(66556008)(66946007)(186003)(37006003)(31686004)(38100700002)(316002)(8936002)(4326008)(5660300002)(86362001)(54906003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnpZY0hYZENMMUJ0RE5kRndMeWUrdDVueDRCcGsvNnR3Q1Z0Y1BFYUdDc3U2?=
 =?utf-8?B?MFNTSDRRVVBIRzY3R3FSSHI5R2FNU081U2tTcUpjS1llakFIazVqaitvKzVO?=
 =?utf-8?B?dGpZSTZUZFpqNXhMMElyampqWHAwMWRDelRjckZnRjk1NVJwZkVwRnVKK3dz?=
 =?utf-8?B?T2Q3ZklnQlBOdnRQd1JwVHpzOXVHQ0FIeFdmT3RsTTQrQlNqNzRSU1lNTFRL?=
 =?utf-8?B?MXNJWXBsQVZDUmIxWkJXK2dLczY2RjMyOFEwRE43QnFCVXR0THhOVWMzMjJL?=
 =?utf-8?B?TTkwODgrY0FpbTMxME5kUVdteWFOOUFtWStXYXJLdUZhbEJlemlxejZBamxX?=
 =?utf-8?B?ekpoTjk1cUZxZnF0OC85YmFRKzRDVGtRNnFxWVNBOVlLWk1nRTE5QWNnd0Yw?=
 =?utf-8?B?N2Eyb0xJM3ZtM2ZQVUZ2clhJUjZOVjdXS21oZ2hNcWtLMUt3SjFWTmdKNllC?=
 =?utf-8?B?RzBHR09yZS9Lbmd2ajVuaXRsUUlxWmpuaHJEWW53eTU4MDBHVUo1UlJiRE9F?=
 =?utf-8?B?WFNjamNrd3F3ZFpJdTROc0tHellWdjRuaUxUU05hYXgwdmRhc0RmV3RTVUxs?=
 =?utf-8?B?b3BSdzRncjdjZ251bUxOMDdiZnZUQU5QMGkzTy9MbFRuc2Q2WXIzQllFRGhO?=
 =?utf-8?B?cjRLRTBjdkc5WDFHeVlmTDl2YjhmeGJIZVRiVnAvOHBRQTRMdmhzVTU1NTla?=
 =?utf-8?B?dVNOaG1nWGpROTdLYm13VjZlT2l4dkFBYWFWVzZKRjFTMHlKWkpUNlBLM1pm?=
 =?utf-8?B?RHpCZ1RqU3o0U2JPdXI4OWVoVUtwV3NrQm1JR1ZVcEpBRENGQys5ZmJGYnFM?=
 =?utf-8?B?alJITjNnVXJ0SnZQc0hXbkFrZnBxQ2lwZUd3NmFSTHJLYmdPdjkvTlBvbUs1?=
 =?utf-8?B?NUFTY05TL2xEeDlsRlI4elBYU0R6RUpWd2oyc0pjZzJzMUQxRk1LNGNxZGVs?=
 =?utf-8?B?T25WeDN5OFdsWEFEU21zOWt6ZEN3cXd6a3o0VWp1V1BueDArSjZCeGJ2TGdC?=
 =?utf-8?B?RkZ6NlZrb2tGaWM5U2lIS3hoQUpIemc1MVRWYWxBbFUrK09Qb1liSGZkaTAr?=
 =?utf-8?B?TXB3OUtHdzg3YlYrd1piT2JXU1ZGaDFDZ1BYWS81TkpBK29SMTl0RzdYcE9l?=
 =?utf-8?B?cEhaa3pwN3M4d2RWdmZKWHNwNzdqb0N6MXI4cy9keUhXVklCNG0yYTE5Wmc0?=
 =?utf-8?B?MTQ2TW1SWGdtcnZKVzA2TTlld2ZpanJRUzJYdHhRUG5Ld0ZLR2xsclRUUWVq?=
 =?utf-8?B?bG1wRFYzNGFEdEtkT0RPVzlqeDRBUlBNaVozaWNXQ010QjVDSEtmYkJqekln?=
 =?utf-8?B?Ynk3TjlEYi9QbkwrMnRzeENwUnhQYzZQOGt0Q01ONzI2Tks0azhPR1pNdk5R?=
 =?utf-8?B?dFgxOEFsVzhjbnhCVTRINEpmcno4RTEvWHc1akZ5UzBwL0FVU0FpeW9aRUhQ?=
 =?utf-8?B?YkJvSG9sbDRzR2pCeHVta2EzdExoN1ovb1MraDlBN0FEV3VFQjE1VGFySnFS?=
 =?utf-8?B?dDhMMXAveWVMMDhVU3Ruazc1RXZDZ0hpWkNKTGVzdVhrRlVMN3JUSjhQNE1z?=
 =?utf-8?B?SHMra2oyNnFwdzhLYW9nV2o1Zml4bmZKaUhLQlRXQWJHZ3RoNkJzek5oNlho?=
 =?utf-8?B?T2VrUmF6VkV1VkZSSFMrMzJ1dklDVER1TXlRdWpHbHRmS3BoaGUxWHpqVDk1?=
 =?utf-8?B?OTR3bmxwb3ZJd0dYN2h4cjZXaGRIOUxIK1ZKc040RjVmYjVPaDVoSXRycyt3?=
 =?utf-8?Q?LFO9YoSHJ8opZZrAZn2GznSLxcUurKKU9T4DLf9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a3e3b6-0ce4-4032-66ed-08d994196df4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 22:31:59.2741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkuehlin@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
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

On 2021-10-20 5:50 p.m., Felix Kuehling wrote:
> On 2021-10-20 12:35 p.m., Kent Russell wrote:
>> Currently dmesg doesn't warn when the number of bad pages approaches the
>> threshold for page retirement. WARN when the number of bad pages
>> is at 90% or greater for easier checks and planning, instead of waiting
>> until the GPU is full of bad pages
>>
>> Cc: Luben Tuikov <luben.tuikov@amd.com>
>> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
>> Signed-off-by: Kent Russell <kent.russell@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> index f4c05ff4b26c..1ede0f0d6f55 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> @@ -1071,12 +1071,29 @@ int amdgpu_ras_eeprom_init(struct 
>> amdgpu_ras_eeprom_control *control,
>>       control->ras_fri = RAS_OFFSET_TO_INDEX(control, 
>> hdr->first_rec_offset);
>>         if (hdr->header == RAS_TABLE_HDR_VAL) {
>> +        int threshold = 0;
>
> ras->bad_page_cnt_threshold is uint32_t. I'd recommend using the same 
> type. Also add an empty line after the declaration to avoid a 
> checkpatch warning.
>
>
>>           DRM_DEBUG_DRIVER("Found existing EEPROM table with %d 
>> records",
>>                    control->ras_num_recs);
>>           res = __verify_ras_table_checksum(control);
>>           if (res)
>>               DRM_ERROR("RAS table incorrect checksum or error:%d\n",
>>                     res);
>> +
>> +        /* threshold = 0 means that page retirement is disabled, while
>> +         * threshold = -1 means default behaviour
>> +         */
>> +        if (amdgpu_bad_page_threshold == -1)
>> +            threshold = ras->bad_page_cnt_threshold;
>> +        else if (amdgpu_bad_page_threshold > 0)
>> +            threshold = amdgpu_bad_page_threshold;
>> +
>> +        /* Since multiplcation is transitive, a = 9b/10 is the same
>> +         * as 10a = 9b. Use this for our 90% limit to avoid rounding
>> +         */
>> +        if (threshold > 0 && ((control->ras_num_recs * 10) >= 
>> (threshold * 9)))
>
> Not sure how big these values can get, but you may need to cast to 
> (uint64_t) before the multiplications to avoid overflows. 
> Alternatively you could use (control->ras_num_recs / 9 >= threshold / 
> 10). It'll round, but never overflow.

Ignore this comment. If you follow Luben's recommendation to check 
ras->bad_page_cnt_threshold instead of the raw module parameter, the 
limit is small enough that multiplication will never overflow.

Regards,
   Felix


>
>
>> +            DRM_WARN("RAS records:%u exceeds 90%% of threshold:%d",
>
> Nitpick: I'd add space after the two colons for readability. The 
> threshold should use %u if you make it uint32_t. This can never be 
> negative.
>
> Regards,
>   Felix
>
>
>> + control->ras_num_recs,
>> +                    threshold);
>>       } else if (hdr->header == RAS_TABLE_HDR_BAD &&
>>              amdgpu_bad_page_threshold != 0) {
>>           res = __verify_ras_table_checksum(control);
