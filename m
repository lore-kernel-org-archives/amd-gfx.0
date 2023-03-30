Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEF5C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 15:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D82410EED3;
	Thu, 30 Mar 2023 15:32:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C35910EED3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 15:32:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejccE1Q4jkZ6OkBD0+a75PdY6n1qJw5zdj6WarQHfn85/1hjU+EJh1VHm7hg4RVpnVJMI+BY5qCa0EVJpjVP7J1HIprByiuM4MVsuG9mlVhAs+4kwH6EjZLFvRYBeFwRglcQ78HTBKi7DWnxwtkgR4p0dU++gJGXtL0e6NfNbWvp7yRhtW9wwkD1FtUP2rEVKDdu5HJ7YRU2up3wcyHVanZEn16knrueeO/yDxVtjn8PMAFzFakETMrpdR7u+nY+eV9QAJSQBM15FPtL8mk5QhK59tDXrRhnZhtw14ovMvSjzffm6kyFvaXEsnp1H8BkHZ0ZVlcyEaU8PxGgqaOm8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvTJzTgzE9FloFA5BADMggg4t0Ue3BDUqcSd+FE16Mk=;
 b=CCwd6hO1/GsqNq4NHlAKwhV6YwIs7hyjRhDPfWk43WkJ1JLVhOoom1q0/UHleVzOa5N+St0PQsN095OELc794xubMgFmP3Q4Q9fBrt8OQK95UPwK1BqbjpbL5OdfCUj83kZkxKbt4bjFm6aLPJBwvV96j4PTrR0Hh6eo8TFaYl15nFOCLpLl1Kgju5NxujtQHIh9DUy1nQFzgrZa5nbg/BLyNbNlHdaT3NTAbfZhf45y+hdWCrLLRhKuvmZiUPhs5NqzmRciYmHKUx1ZHLV9nFK0ZNBqILBwN1OWK7c9YEv+FwDLM/2YK4/74XLAT0MzfmrnK80FgmGWJ7mw1Pa45g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvTJzTgzE9FloFA5BADMggg4t0Ue3BDUqcSd+FE16Mk=;
 b=yQZswuC/2b18bjp8wWWtCJ0RAjsdEY/+n/MUj+GEzxCsxKIfwd+ngDCVE0odXDSYb/W6KtEAMLIKDzOwtSta89pvnXLaDEnGXlUx31k9kCkKC5Tiz9I6EcuCkKeB3wrzTZjxBcC113mamGT+mh9ShuEffWFrxo/1ss1Z3+bBgYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN0PR12MB6247.namprd12.prod.outlook.com (2603:10b6:208:3c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 15:32:41 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 15:32:41 +0000
Message-ID: <a92e250b-4865-e6b2-e91c-fe83f54a4bd2@amd.com>
Date: Thu, 30 Mar 2023 17:32:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 06/16] drm/amdgpu: accommodate DOMAIN/PL_DOORBELL
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-7-shashank.sharma@amd.com>
 <530dd02b-5b7b-db8c-8cb5-a69d7ea05758@amd.com>
 <5c8ca3a9-6f6a-fa4c-0a1e-8dc72a3ea959@amd.com>
 <a6b38b89-c537-165c-d017-d1930c2ba2fa@amd.com>
 <274d9875-33dd-d9f4-ffd9-8a0b317af4d3@amd.com>
 <38c93185-7c06-4868-facc-2d107e60e8ea@amd.com>
 <a9a398e4-847c-fc99-370c-e641fc49ed80@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <a9a398e4-847c-fc99-370c-e641fc49ed80@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::16) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN0PR12MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: bc6f1269-8fec-40e7-7d26-08db31340024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q04YlQT4AbB5+el0EMqo6Flj8XHpChnb9+NERUIIXS1nB3ciN1tXRFaCyB5FkEyE/uS3cAUlPCsE281bFYN8bzwMJ2trD+NIewtSks5jPV0AQCnqh8owOHbE2jMavogR9IbGGxX+yjw+S6pOqWXkTm5bquiT47sS3f3laRbS4g8ChWKWop7jgICajXk5mxbM0JT3ViXlz/fXSOltLmjYu42LSFyAumsWsA5wHrsLe21tL+OHFQQLkKI9MvZywbvoJD5g0pjxoFqIWqJGCanFyUOSzQYLOBs3qgIiCe5kZvKw5BMV0sCwCkF9zFPhfe//WQgt5GZnLJM5qa13dCzZP8M5zRTMsArac8b2GYINRkwGVvBvw+hX5EoY6OqNaV1mvJCWyJWQiKJVTSG4awVdg30CdKNoiBafyx5jqL8jQX+8LKWjU/rRSxxMWXor6i/mCoJTGTH64WKgxsOoqQPahupilSny9HtiJFBngPZEyli0TM8jCs8TYnL8RwbbkhBSwWOMjqGOYXxa2vffoUE7eTCDtQR6l88NjSaWtMhoQ9Rlp0oe8ZiiWUZ4Xy2fDGEs9rfcFwqENTOlj5G/KcPmXf4FH1GvlFJNFrCwyy7BEPf6fvTDvkMCpuin9rSY/6DEo/Io+wcvu7qP1KuzaifrRXe2BpfAtKlaE1KPqBumRBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199021)(110136005)(54906003)(316002)(36756003)(478600001)(5660300002)(8936002)(38100700002)(2906002)(66946007)(66556008)(41300700001)(44832011)(4326008)(8676002)(66476007)(31696002)(2616005)(6506007)(6512007)(26005)(31686004)(53546011)(6666004)(186003)(83380400001)(66574015)(6486002)(966005)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3BpYjZqV1hZNW9mZWY0b01uOTBBR1cwcGJaaEkydzQxLy9hLzFYeU1NVWUv?=
 =?utf-8?B?WFp4Q2JiZnlCVk92NEJNcWR0M3ZLK0JaZDdVK2NZdEc2S2ZoSUhBM2RlTS85?=
 =?utf-8?B?UlVYT09QOEFidGRhUkZPaFd1RSt4akk2elBCaVNLMXdUcWoxQ1d3eFpHVkto?=
 =?utf-8?B?ZTRHcDZrMkNzZnlTR0JzZUxLMFhuY3gycDNHWTVEUUd2N053M1JiTUVQL3cz?=
 =?utf-8?B?SHBhRkNDT3AvanFXWHYwV0NYODZqSXZGeXJLbHAvdEhxMmZxTjkyUmYzTmdJ?=
 =?utf-8?B?YkZpSDl1NUV1M2NPWHlVRzFsNWYvSG9aSzE5NFdTdEhUbDNnbFpwMldYNlBK?=
 =?utf-8?B?bGY1L1dGV2F3STIyem1sd2IzTGhNMWl3c3ZFQUxPUDVQWDhHTFovYUxCTUti?=
 =?utf-8?B?UktDc3Y3dVJSV2pCQ1VLRFQ5NzB3VTN0SFlLMXFLMGZ3d1JkYnJsWnBpQnNq?=
 =?utf-8?B?dU1vK0wvRE9HU3QwRDk2ekdHam5uTE5FRkRnSHpHZzUxKzlGMVc2TDNRSlNL?=
 =?utf-8?B?VHZtcUZBZlY5djZQNHl3QTZDSFJOQ0dvUTJ6MFViQkdkNFhSbjlsUlVRS3hx?=
 =?utf-8?B?dlNwVlIwRHRLRkNEUUtSNXJ2LzU4U0hFUGpiNU5LTHkyTFlIMnpicFFBcy9E?=
 =?utf-8?B?ZnRUWXBIM3I2NWQvVGxzNVhTTjRXOVVlWVNuai83Rnl2dUdLTXZxZTZpdWMv?=
 =?utf-8?B?THNBUmUzRmhZTStIZitLbzJCRFpsaW1tcTJ0T2RDWEU1MHp2emY0Y2w2cmNB?=
 =?utf-8?B?S1gwTGltcTBFN3BJR3ArdmgyRU0rV0h3ejJKNjRXSXdrTGVFenlwWWEra0hq?=
 =?utf-8?B?a3JPL3FWaytVcWJ1aC9tMDgrM2FjbHU3ZkwyTEtwSkVacHpndmpEVjJXTWhL?=
 =?utf-8?B?bTNGRkUwTXhuUFUwMGhXQVNGcURsdTRnakVSOEloamlPbzBnR0VwN3pOeHdz?=
 =?utf-8?B?WUtyT3liMGVLZmwxYUxjQkJiZy9MT2puTDFSUytTRDcxYnJrNzVwWDFiQ1dN?=
 =?utf-8?B?ZWZ1MDVqVk5nZkNIWjd4UG83bHhzbCsxVkZPRDhuNUVvTnVlTE15dS9BbDhG?=
 =?utf-8?B?ZytveVA2Yk5kTkVQL0dsRnBDV3VUL1ZVYmJ5NTgwL3hxV1VwNC9QZ1AzM05T?=
 =?utf-8?B?bVVSZ1FNWDU2a2ZWZGNZUWF2RGJ3RWM5TFV5dU1QQ21vVEJoL0tpaGxvZ0gz?=
 =?utf-8?B?cEtpRThOVzRGU3ZHVElIaUdtb1pNRkFLYU9rUHdBTmlraUp1SVRwRUE5dEt5?=
 =?utf-8?B?Z3VmbmhudjNJOE1tN2p5dGgyY1dNZW45Q0toSCt6MGR1WHp2UVhVOUVRaHNx?=
 =?utf-8?B?SGtpN1ZDcUpzUy9YZHJ4YnlBRXFyWlg4WnZ5UmRuVmMrY3JaTFJiSGJHNEpt?=
 =?utf-8?B?S0NyN1JxT3pCb1lRMEhNUTltUFBYU01VSzNwUGduaEM5TC8xRGRNU1o3UTcx?=
 =?utf-8?B?WHRwNUcrbGQ3YmozODJ2d1NHeUlOTDVmM2IrbHI5enhqend2em81UGNhZDFL?=
 =?utf-8?B?RzNQNEhCY25hY0YzeEd3S2hScS83S1lVajRKdHhiZzJTNkF2WHUrUVo4ZFVy?=
 =?utf-8?B?MnpvSit1ejFjQXpxVE5LcTExZzN4RW5mUzdIT1FoTFJ2bEM3RTNxUDZyTUg0?=
 =?utf-8?B?T08zcGxLS2pwUUVzTko0Y1RPZEdFTlA3ajJRQllqS1A4WW9WTmVRMkZCRXI4?=
 =?utf-8?B?WXNneExFM3p6YzlQQzl4VHh6ZnBTZlVtQ2VWT0NQQjF6QmRsQXkycXo4ajNy?=
 =?utf-8?B?cW9qV0psQjBpSDVpaGZnWi81RDNQV28xcVJIQkJPNGVxSnpIa1ZDMk5IS2dE?=
 =?utf-8?B?QmpVTG1qd1VMVHZkWk51MWE3NitsczNMQjY2RjFCeWI2bkZZc3lwZ1JaU0hF?=
 =?utf-8?B?WElYSXR1ekxyYnp6OU8zdnJoeml6emNQc3hyVFVSak9oWUlqZVo5NWh6ZEhE?=
 =?utf-8?B?Q1pQTjhYaVBoUlRPYit5dkVlbitDQ3VUQnlvSDM4TGVkc3RYc0swaEVlSW5z?=
 =?utf-8?B?YzEzTTRTbzd6cW1FNlNVb1Z1bjhHTDc4WUo2elhGcktrTDNTUlExRXAwM1kr?=
 =?utf-8?B?WUxETkl4NkRxVnBDSUdCMmhSRTZDSzY0SUU5RHV4L2piY0FuVFNOc1h2N2NM?=
 =?utf-8?Q?8t6zcyyETd9dxRCEjwaq7kaIB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6f1269-8fec-40e7-7d26-08db31340024
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 15:32:41.6421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpKxeob2eyrOvatRNmXXBRHAp3e7cw7sOlfjOPsX5Nzv0zzctgxFiTXW1hg0cO4dN783mNMtE7CGShRpaAKkyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 16:12, Luben Tuikov wrote:
> On 2023-03-30 09:48, Shashank Sharma wrote:
>> On 30/03/2023 15:45, Luben Tuikov wrote:
>>> On 2023-03-30 09:43, Shashank Sharma wrote:
>>>> On 30/03/2023 15:33, Luben Tuikov wrote:
>>>>> On 2023-03-30 07:14, Christian König wrote:
>>>>>> Am 29.03.23 um 17:47 schrieb Shashank Sharma:
>>>>>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>
>>>>>>> This patch adds changes:
>>>>>>> - to accommodate the new GEM domain DOORBELL
>>>>>>> - to accommodate the new TTM PL DOORBELL
>>>>>>>
>>>>>>> in order to manage doorbell pages as GEM object.
>>>>>>>
>>>>>>> V2: Addressed reviwe comments from Christian
>>>>>>>         - drop the doorbell changes for pinning/unpinning
>>>>>>>         - drop the doorbell changes for dma-buf map
>>>>>>>         - drop the doorbell changes for sgt
>>>>>>>         - no need to handle TTM_PL_FLAG_CONTIGUOUS for doorbell
>>>>>>>         - add caching type for doorbell
>>>>>>>
>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>>>
>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>> Generally there are no empty lines in the tag list. Perhaps remove it?
>>>> I would prefer to keep it, to highlight the CC parts.
>>> I've never seen a commit with them separated. Perhaps follow Linux custom?
>> IIRC This is not against Linux patch formatting/message body guidelines.
> The tag list forms a block, a paragraph, which is easy to scan and separate out
> of the description of the patch, which in itself can have many paragraphs separated
> by white lines: subject line, paragraph 1, paragraph 2, ..., paragraph of tags.
> Furthermore these tags are added/appended by automated scripts/tools which wouldn't
> add an empty line.
>
> Check out the following resources:
> https://www.kernel.org/doc/html/v4.12/process/5.Posting.html#patch-formatting-and-changelogs
> https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html#the-canonical-patch-format
>
> "git log -- drivers/gpu/drm/." is also a very helpful reference to see some good patch formatting.
>
> Please remove the empty line between the Cc and Sob lines, so it forms a tag paragraph.

Certainly makes sense, agreed.

- Shashank

>
> Regards,
> Luben
>
>
>> - Shashank
>>
>>> Regards,
>>> Luben
>>>
>>>> - Shashank
>>>>
>>>>> Regards,
>>>>> Luben
>>>>>
>>>>>>> ---
>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_object.c     | 11 ++++++++++-
>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h |  2 ++
>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c        | 16 +++++++++++++++-
>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h        |  1 +
>>>>>>>      4 files changed, 28 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>>> index 4e684c2afc70..0ec080e240ad 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>>> @@ -147,6 +147,14 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>>>>>>>      		c++;
>>>>>>>      	}
>>>>>>>      
>>>>>>> +	if (domain & AMDGPU_GEM_DOMAIN_DOORBELL) {
>>>>>>> +		places[c].fpfn = 0;
>>>>>>> +		places[c].lpfn = 0;
>>>>>>> +		places[c].mem_type = AMDGPU_PL_DOORBELL;
>>>>>>> +		places[c].flags = 0;
>>>>>>> +		c++;
>>>>>>> +	}
>>>>>>> +
>>>>>>>      	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>>>>>>>      		places[c].fpfn = 0;
>>>>>>>      		places[c].lpfn = 0;
>>>>>>> @@ -466,7 +474,7 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>>>>>>>      		goto fail;
>>>>>>>      	}
>>>>>>>      
>>>>>>> -	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
>>>>>>> +	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU,  AMDGPU_GEM_DOMAIN_DOORBELL */
>>>>>>>      	return true;
>>>>>>>      
>>>>>>>      fail:
>>>>>>> @@ -1013,6 +1021,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>>>>>>>      	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>>>>>>>      		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>>>>>>>      	}
>>>>>>> +
>>>>>> Unrelated newline, probably just a leftover.
>>>>>>
>>>>>> Apart from that the patch is Reviewed-by: Christian König
>>>>>> <christian.koenig@amd.com>
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>      }
>>>>>>>      
>>>>>>>      static const char *amdgpu_vram_names[] = {
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
>>>>>>> index 5c4f93ee0c57..3c988cc406e4 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
>>>>>>> @@ -90,6 +90,7 @@ static inline void amdgpu_res_first(struct ttm_resource *res,
>>>>>>>      		cur->node = block;
>>>>>>>      		break;
>>>>>>>      	case TTM_PL_TT:
>>>>>>> +	case AMDGPU_PL_DOORBELL:
>>>>>>>      		node = to_ttm_range_mgr_node(res)->mm_nodes;
>>>>>>>      		while (start >= node->size << PAGE_SHIFT)
>>>>>>>      			start -= node++->size << PAGE_SHIFT;
>>>>>>> @@ -152,6 +153,7 @@ static inline void amdgpu_res_next(struct amdgpu_res_cursor *cur, uint64_t size)
>>>>>>>      		cur->size = min(amdgpu_vram_mgr_block_size(block), cur->remaining);
>>>>>>>      		break;
>>>>>>>      	case TTM_PL_TT:
>>>>>>> +	case AMDGPU_PL_DOORBELL:
>>>>>>>      		node = cur->node;
>>>>>>>      
>>>>>>>      		cur->node = ++node;
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>> index 55e0284b2bdd..6f61491ef3dd 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>> @@ -128,6 +128,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
>>>>>>>      	case AMDGPU_PL_GDS:
>>>>>>>      	case AMDGPU_PL_GWS:
>>>>>>>      	case AMDGPU_PL_OA:
>>>>>>> +	case AMDGPU_PL_DOORBELL:
>>>>>>>      		placement->num_placement = 0;
>>>>>>>      		placement->num_busy_placement = 0;
>>>>>>>      		return;
>>>>>>> @@ -500,9 +501,11 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>>>>>>>      	if (old_mem->mem_type == AMDGPU_PL_GDS ||
>>>>>>>      	    old_mem->mem_type == AMDGPU_PL_GWS ||
>>>>>>>      	    old_mem->mem_type == AMDGPU_PL_OA ||
>>>>>>> +	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
>>>>>>>      	    new_mem->mem_type == AMDGPU_PL_GDS ||
>>>>>>>      	    new_mem->mem_type == AMDGPU_PL_GWS ||
>>>>>>> -	    new_mem->mem_type == AMDGPU_PL_OA) {
>>>>>>> +	    new_mem->mem_type == AMDGPU_PL_OA ||
>>>>>>> +	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>>>>>>>      		/* Nothing to save here */
>>>>>>>      		ttm_bo_move_null(bo, new_mem);
>>>>>>>      		goto out;
>>>>>>> @@ -586,6 +589,12 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
>>>>>>>      		mem->bus.offset += adev->gmc.aper_base;
>>>>>>>      		mem->bus.is_iomem = true;
>>>>>>>      		break;
>>>>>>> +	case AMDGPU_PL_DOORBELL:
>>>>>>> +		mem->bus.offset = mem->start << PAGE_SHIFT;
>>>>>>> +		mem->bus.offset += adev->doorbell.base;
>>>>>>> +		mem->bus.is_iomem = true;
>>>>>>> +		mem->bus.caching = ttm_uncached;
>>>>>>> +		break;
>>>>>>>      	default:
>>>>>>>      		return -EINVAL;
>>>>>>>      	}
>>>>>>> @@ -600,6 +609,10 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
>>>>>>>      
>>>>>>>      	amdgpu_res_first(bo->resource, (u64)page_offset << PAGE_SHIFT, 0,
>>>>>>>      			 &cursor);
>>>>>>> +
>>>>>>> +	if (bo->resource->mem_type == AMDGPU_PL_DOORBELL)
>>>>>>> +		return ((uint64_t)(adev->doorbell.base + cursor.start)) >> PAGE_SHIFT;
>>>>>>> +
>>>>>>>      	return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
>>>>>>>      }
>>>>>>>      
>>>>>>> @@ -1267,6 +1280,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
>>>>>>>      		flags |= AMDGPU_PTE_VALID;
>>>>>>>      
>>>>>>>      	if (mem && (mem->mem_type == TTM_PL_TT ||
>>>>>>> +		    mem->mem_type == AMDGPU_PL_DOORBELL ||
>>>>>>>      		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
>>>>>>>      		flags |= AMDGPU_PTE_SYSTEM;
>>>>>>>      
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>>>> index e2cd5894afc9..761cd6b2b942 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>>>> @@ -33,6 +33,7 @@
>>>>>>>      #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
>>>>>>>      #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
>>>>>>>      #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
>>>>>>> +#define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
>>>>>>>      
>>>>>>>      #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
>>>>>>>      #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
