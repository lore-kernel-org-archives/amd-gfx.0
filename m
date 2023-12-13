Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE30C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 16:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B043110E2DF;
	Wed, 13 Dec 2023 16:23:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12F8C10E2C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 16:23:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEBHyGmhbKxUy7YQz+NQ+LDQP9u8UCdC64FvTsE7zHtGniTF7+8y9jWq+90KywAiNE9sTQauzWK4qinzywGgDFNqpJ0Hstlr5KL1oFZQz6Xg69MXjjKY5H54CQD6pkni2CELIIp7IQ1hJNzL5IkyN1N0Vs2Ft91Uh11xH0Ri7YunF1AHuj+SEStfqnSsZZO5xUf+xIHgcwiP2PNatZwtYJr+5kCUcHdqzIlkJDJeASU4Qxlf97v6Yd/DjtADGYNISdzBQQMy2VBI9Z7VzuZgcS2pOD+Q8+imArAx2k+0deSaSivb9bUkVb8O7F9dsioYWY3tW143aWQshWo7b+m6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJ/330+csyXenVvr3RLY77pBipnN9Uo4lvMdx5YzL4I=;
 b=JuU0pCQkhM4gQKjmB9GbLQc3Njch/xqmmkcg9vdyl/f1982qy2bd1dtN7a5iedgs4sqoMllDxMPCzjEH6LeuGI6maP5EvnCcMfV9gbhmzIIF9/+HDweek4R019z/lK5/XfqR43TfsmkxxB84CwJVaM7sIP5QGP9pAaAgSerReGtdTrV02WsdwWvCUED5ljn9mayFqgRVC6flalsGiO4SzauisTVgUbe3ipIM2MhbemchVV0dM/1xVYYrRimv+fz4KStdykMnwNYCt1Sja7Phvu5l2ZJqH6P9hPWhCvKFJBDVtCuw96bu75USieWdZmmw6tNhNABpEyeAk9HTjRlMqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJ/330+csyXenVvr3RLY77pBipnN9Uo4lvMdx5YzL4I=;
 b=jEX0kwePbwv11Hrl6UQEmv0AfHXHLf1DHWnLMPeSXla33HXJ8ead+ZsMi9bYrjZynxuldkOAZkd17PFxViZs5HD35AeKSjaW9vZ8rbt4iVufeixQgbKhd1pfgM+dTWMrtCPUVa+sVqpF2frAgMbQBfAEDUOFIuwKoGJxgn4dzGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 16:23:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 16:23:32 +0000
Message-ID: <f4490496-3f63-4251-abcb-4761d9124c53@amd.com>
Date: Wed, 13 Dec 2023 11:23:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: increase hmm range get pages timeout
Content-Language: en-US
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231208230105.733781-1-James.Zhu@amd.com>
 <bc0fee8f-9e10-406a-a001-d4bd37c42c43@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <bc0fee8f-9e10-406a-a001-d4bd37c42c43@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0248.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BN9PR12MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: e749948c-b326-4021-8126-08dbfbf7d94d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzPrhrO692iQTVEb9kB2HPAobWzPrysjgbyaJ4xebEYaoiCzBPaj3r+Wk8tlJcb9B0tRMdIrewLoquzOZJw8tIGzHr6AJdL55+NWtlT1lHFJ7WINvgTg1aR6HjkJ7BYCR012TTU13KT2yWnvhg6+Rdyp384ZU14MdiLD+aN7NSMZJDLm5fGP2ils+qeiSg+8Rmbc6NWOdmKdRqzqf2ss750z1jf/PMfgRcZ5y6D3StiNtfCN/7/ir+7A21C5HoXgo8690qtyRfvojeUMcLmA1NlDrnO4MOHpj1dGOTkOEU5pPyoWrpeQkxs62gb+Hfs6x4ZjZBed5CBfm+yIaU9GHqhkzjvJfPj3LUy9iYF5KDQGQjayN/umPlEBig1MOsZ+Ioz1UUtz6Dd+V/chMTQScoGQqXKQ6vQyifHY2viBi5VkyaR47bNJjSCd/jzxWqtWhpDutS56ssQccSuddybWiXIo6xiFgx1YaTeo/y3i2oxIGWWo4Z5LFWsuza6gdm62f9RgBoho62j8Kca1Vs/18R7S35kvr6g1I92dcgg6c675ftVYBhhVruop6SnHpnCs5zIJkIUbaWNpfEuBLsuGQrdseDYR6sFDnLAzRIYNulUwBZIP2FJ/IP/UoVTOCr65Bt42fAEiZTCc0tp0iYpJqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(366004)(136003)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(478600001)(6486002)(31696002)(36756003)(316002)(86362001)(66556008)(66476007)(66946007)(26005)(2616005)(110136005)(83380400001)(53546011)(6506007)(6512007)(38100700002)(41300700001)(4326008)(8676002)(8936002)(44832011)(5660300002)(4001150100001)(31686004)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjJiUkM3MXFjRC82RjlzSkFKdG9KaDVQYXdBYjhuSC9nQXBNRXgyTlZRaFJj?=
 =?utf-8?B?ZkRVYjQxUjVUZlYyRVp5RVU4TG9jVDNiUHZ2Q1lmb2x6a3RKWDVmenJkUlow?=
 =?utf-8?B?NHZ6TndGQkNLN0VpU2hWQVRGZVBpVElWcDFJdWRtbWNjMjJWSXNlOFdrOG5L?=
 =?utf-8?B?RVJ0WngvWklaeXFYcjl5RVN6WGdSWUIvdnFhMHQxdHliZkQ1Kzh1Sml6bVRC?=
 =?utf-8?B?aVhVaTJ6OE04aDJ4MXlCSVE4Rm54Ty9ucjdzdFdYQ0NsbmZKT3dHM29YWUhI?=
 =?utf-8?B?Z1poLzBLb0h1ZmhHdUJKT0pTTWtpUXRCSloxM3pKOTJWR2MyQXVMMUNDL2JI?=
 =?utf-8?B?dHU1SnJtSlBlalVpaFZ2ZDIvNENJdGdGeEpJUDFWMWZ1VnJ6YUpGUzVYeGN3?=
 =?utf-8?B?dU1WcjQvbEwzTUc4TjJkUzBmeXZWMXVkb1VZTXpFUFhVU2VwWmdqMWxqU2RQ?=
 =?utf-8?B?VUpKVTFzMzNrek5yRkc3VXJtUWZDUzNkRXhBSk1uaGNWVEFITGZaVFhEMUJ6?=
 =?utf-8?B?VHNnOU5SUG40K3YvWm1aQmFNSTlSRTlWQk9kYUlWT29PUVlMK3RtUnVwRnRa?=
 =?utf-8?B?YXlNTmhoMVU0clVSWlA0bDhjUENrSDFQaHRxbDhiRTFGR2J0cEpIWkVqN1Yz?=
 =?utf-8?B?M2QzaU9QNzJPOVNOYkRmYk5jV1BQUEE1VDJtV0tINEhKZlFDK2hxbndqYUVQ?=
 =?utf-8?B?bVpEMCtTUDlXdU0yeDZCQzVMUVlYNHVtcks5ZFI3MW1ubWZDUzZWSjlFdytk?=
 =?utf-8?B?dGNHUmIxbGdXTDJOdkNka0xzb3FGdnVHb1JXbGNJYUNMUm5uTzFsMWt4TWpq?=
 =?utf-8?B?RTRNWG96WitrNTlnSDk1OWQ0dmVYaEUyL2UrZWlmTXhRTVNsbnQ1V1pMRVV0?=
 =?utf-8?B?T1N1ZEhoUVVmelRoajdtVUdCbHpRUHcvVVR0SG8zakRYNFJ2L0dHUUtVYUZV?=
 =?utf-8?B?aHo4eFUrMEZHQ1ErdDkzZ1pReWFRS0cxdDNSdjRiOWJieVVGRWdHbnZKK1Y5?=
 =?utf-8?B?ZXUvYisydm5ySXlmaFZxQThFWG1HT0dJOFMxcEwvdDF0WjNYK1NXeHdoWkVj?=
 =?utf-8?B?bzdzRzVaYUV1WTNaZ1FLa3hudFdQaGFxaFlTd1BzeFhKRlozclhuaW1XS01O?=
 =?utf-8?B?dzBGQTE3dkNqcDd5RnFxMnRhdWFBTUQ4VUVXem8xa08ycnA1VFdXSDJpamM3?=
 =?utf-8?B?d0Q5VUc3Nkk3U1pCVTNmSkp0TVFXRS92b2ZheU1wdnV5R3JOSjZKNU9peHZh?=
 =?utf-8?B?Y2NYWHRSdDU1UWRUQkhWV1gxUnFGaUppY3dJcVdKZmk2UUh1cEtZVWpJejI5?=
 =?utf-8?B?Q1luRU9nM2lWTFhCb0l2L1p4MmFtMlNRc2xob29qWUs0d3RlNVlrVXF5Vkxa?=
 =?utf-8?B?ZG9wVmRBdmlWRit6NVROVS9ZRzYzU1pONHJzNTZTazlyRXpQeFY1U2U2aG1l?=
 =?utf-8?B?TnZBaVBYdUFrSzNVNXRIa2dGbGNCckRlL0p5QWJVZmtNb0VIOEdYRTFCb0hV?=
 =?utf-8?B?Y3JhdGpVcnBBdmxIbkdFZmVubi9Td21TdWNselExcW92YkdNVVpsazhyWGJU?=
 =?utf-8?B?RHFLN3cvdGxVTmxZT2lVTjJ3SVQrNEoyaGltV1VDUXozMTk1Z3FsRFpxWUpi?=
 =?utf-8?B?S295QnFiY1N4ekd1V3dKQ1FMUUdyVEVxRGRoTnYyb1gra05BREhLZ1lqREJr?=
 =?utf-8?B?VEJrN2tGNFRzZWpYSVJ0S3FLcHhCRm45bnZJZmdGbEloRHJlcXpibmVrQ0sw?=
 =?utf-8?B?TUJ6U09reUh5aDBXcTNGeGF2SkNnaHkycDIzMy9NZ1pkTTNEK0JzOWFZR0xR?=
 =?utf-8?B?RkdWTkJCVTMyN2p5R1RZeDVRenFxTEtsRGdJUlM2cjJ1ZHJITXk0TUNIR2No?=
 =?utf-8?B?YWVkRzErcHZwazdQUlA4amdxK3prTDRQd2lydks5bzQ4T2V4VE50amlkd0xh?=
 =?utf-8?B?Mnk5YUJKVDE0SmlRYUtOTHpBd3NBU2ZyREZFdnowSTUyZzdtZmYyUWIyUVFj?=
 =?utf-8?B?RS9Ock9aem41d0t3ZlpFQkZGcXphZThTVVd6TDJ1bmVFaEdUNEErREhWZzV1?=
 =?utf-8?B?enR2bWVrR3FWQ3BtcnZEUGJLREdIdVNTUHJiNTM1TVg3bEw5MStINVZycEhx?=
 =?utf-8?Q?ua+R+uT2pyjWyYfVaAKz3wn5X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e749948c-b326-4021-8126-08dbfbf7d94d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:23:32.5591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzcLgeHZtHu3Sjip/2JI2U5E9ePOP+dcvBIEJKtkCWGvEt+RVntvXnkCve1V799xOevRsQL4AqA5ZA4RfrkNYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226
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
Cc: Philip.Yang@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-12-13 10:24, James Zhu wrote:
> Ping ...
>
> On 2023-12-08 18:01, James Zhu wrote:
>> When application tries to allocate all system memory and cause memory
>> to swap out. Needs more time for hmm_range_fault to validate the
>> remaining page for allocation. To be safe, increase timeout value to
>> 1 second for 64MB range.
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>

This is not the first time we're incrementing this timeout. Eventually 
we should get rid of that and find a way to make this work reliably 
without a timeout. There can always be situations where faults take 
longer, and we should not fail randomly in those cases.

There are also some FIXMEs in this code that should be addressed at the 
same time.

That said, as a short-term fix, this patch is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> index 081267161d40..b24eb5821fd1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> @@ -190,8 +190,8 @@ int amdgpu_hmm_range_get_pages(struct 
>> mmu_interval_notifier *notifier,
>>           pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
>>               hmm_range->start, hmm_range->end);
>>   -        /* Assuming 128MB takes maximum 1 second to fault page 
>> address */
>> -        timeout = max((hmm_range->end - hmm_range->start) >> 27, 1UL);
>> +        /* Assuming 64MB takes maximum 1 second to fault page 
>> address */
>> +        timeout = max((hmm_range->end - hmm_range->start) >> 26, 1UL);
>>           timeout *= HMM_RANGE_DEFAULT_TIMEOUT;
>>           timeout = jiffies + msecs_to_jiffies(timeout);
