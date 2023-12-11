Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0056AC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 23:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 805AF10E523;
	Mon, 11 Dec 2023 23:43:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2033510E523
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 23:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAocwWBRErQPixxk/Ad0Ux7as4jO7+ddBhWL4BQi/ivnrkTHYK+VbpqnNN6CeXlM+xL+kvtNFpPTuWiMl547/vrhdCgB59gTUtuGQrTQdmzRklVGdGb0rpdFOXrC82hsgU/Er3mxnW4Spu6z6CG0bp8+mV4lHB9zbgHWXdZGqv1IiQdWlhte0vx8Nq+XNbyy+AOaDGzIaC0vKFYWDr5sBaqzS7LAZgyia+XoMlqENbq7yJ0Nc3vsZ1cGx2is4ixXRD9MlMUuiyl7jUQmgdvfeuB9HmBpJ5B6PsqkMBYU2sfjR3MgQlVtJApz4X7pU3BqVYjp25EXe4g8swnNi60Q1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hFHSpWtQijZ3bhrV2fiUHNinPxK3Dr7gW6IMsVvbD8=;
 b=C9agYayjq1jjj0bLM5Ao5tFFwljy8I6wN4aBKZ4/fzM8KinMCmu0yIfEUPxh5CxJVzGKSvby0zjvloLDTp5k1TgxcDS9LLSTb/fDpZW7pBtr6mUmo1olJqGrOdt81obPrUrvZhloTP/d5Mw1UZRrYYQ3RssZRBmT0oafViVQzebhHd8A2RYAJO0OICkGE5ivsFxxPQ9yecnowMHWBOzHOaFkQOvMJSlC/rdTV2X73wKe3XhCJoPy87U3zNfzACuC80zetERcZl53IkaM3n5YKhGgDWb2HrncUIpQcsooNo1IuGyBpT3nDlGHHbx49tbgIR82bRryQ/FNn+uuUeHE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hFHSpWtQijZ3bhrV2fiUHNinPxK3Dr7gW6IMsVvbD8=;
 b=4XUsKyyYe8McLKe90QibNCjOaZcHjBscAF2Z0e/sxQJN00J8yRQzXymYDHLbazjEtwkn74f7QrFj3H2gRJl2ZQ95JyUuuSMyMjp+d5c2Sg0JYQCSnE8HlypKth9nucM3HmcTemyXwcRg4HebAf1QC8N+OrulhXxJeCAbiPzpmhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV8PR12MB9271.namprd12.prod.outlook.com (2603:10b6:408:1ff::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 23:43:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 23:43:28 +0000
Message-ID: <952aa532-e82c-4e5a-8edd-1ebbf5c79ce3@amd.com>
Date: Mon, 11 Dec 2023 18:43:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: make an improvement on
 amdgpu_hmm_range_get_pages
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231208230105.733781-1-James.Zhu@amd.com>
 <20231208230105.733781-2-James.Zhu@amd.com>
 <a7821e98-8066-4870-b41d-a57e7f04a2f5@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <a7821e98-8066-4870-b41d-a57e7f04a2f5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0169.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV8PR12MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: efc9e31a-bac6-4d6a-5a0f-08dbfaa2f9c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rssLWSp/wKMg71oc2OTi6xGxd2NsaXm1rEJjE28CFXCMOUry6DNlHZZ9M5+tpWAnxh7/oTxFIzks91W/eJvt5e4J75BpAqd3EXMKrAEv7sgQ1k4Qe1rEeFxT9yH86OveDS8rtx0dM/C7AEP9oDxDk5qtHhzlyqjKSohI6P28VD0f4R405xF6iBdxlEgljWGVQzA5aBBYFjcuJRboI6xbnJrLVB8I+VK4NcEy6R7iuJY5vo9nePmRnPynEQFk2wSb6UazcdPO1jkrlOaJH72dEwo+gIUoXx/ycOIWbYLkK17pkimu5aOurqSOQiizBKLvhqlz2lIV5U17YQAAEwAhNMand+bvh6pk+DXPGiUGhdL+0EJNrLi0GhLDFks9BZRfzL3ymfCvi0GmZcAKFyrQXwni6dGHw4CB5NYxGnD/RCKAfpDt60g3NpISgaB8r9wk11IdsrHH3/is6ww7zE6bBCauOszaf4CxByccTM60Hw9hsEEb1l9ZpdSWs/DoInxtidMpdvuQzFXhCAgnBAdWgnqf7z3AkBMa7SvP7H2XjBRNcaMAMdlVWlSlTh4ZpvEjhwlyIfF/XfhNHVBKKfoMCtSp5cuIi9q3UgSHCFNHXG5jgyMabB7ov5iyX0NZaZZSRe953+bvqeHH+h58yY5PLu4VJgEj/xE6Perx7y13nnRImGdAi0Mg2h/QDM9nnPcw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(230273577357003)(230922051799003)(230173577357003)(186009)(1800799012)(64100799003)(451199024)(4001150100001)(2906002)(41300700001)(38100700002)(31696002)(110136005)(36756003)(86362001)(2616005)(83380400001)(26005)(478600001)(53546011)(6486002)(36916002)(6506007)(66574015)(966005)(6512007)(4326008)(5660300002)(44832011)(316002)(66946007)(66556008)(66476007)(8936002)(8676002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2VwSndHVUtERTgyQ0pJbFpwRis3L2tpMFFac21Nb0dmZlVKd1pOdHlmTTVP?=
 =?utf-8?B?d1dzclBOZkNkaEFpYmdkZjN1aUNKWUYwYXluRkpwTFZsR09LSXRpS2tZNk02?=
 =?utf-8?B?UVVZaGRNYXZVaHVqVkNBUDc4OXRacXlHVG9SNTlsZElvZStnWkRIRDVWZWFo?=
 =?utf-8?B?elovaG4rMlE2MjhLU1RiSlpabDYxUmFkekFIS09uR3NrUWJJZEtCUlUwbVVL?=
 =?utf-8?B?TnZlc0FaU3hlamJMeXgyOXIwcjc2Zm10ZjducW1Ia1NLTXNETURsb2x6TVln?=
 =?utf-8?B?Q2xYVERtRlZpTUlNbkFXbjhETE9rRTM3dzNzK0wyQnRiU25hMTIvMVZSM2E5?=
 =?utf-8?B?aC8zU254SDJTcFdMd2RPaTBJQXZFRm9NdStPSEZUYXVkZWNFK2g4RklRTnVo?=
 =?utf-8?B?ZlZYMkZtQ2krbDBKbGVKLy90SXRWRlh2ME9lWFc1N1k0aGJMTG10MC8ydlZY?=
 =?utf-8?B?UlpzZUtQd2lmRWxtR2MzcTlTTWFhc3FTRFNab2ptNUVnOFd6YXpySDR6VzMx?=
 =?utf-8?B?K2Y0QVZCR1VqQWdOeElaVXlxUUduYmJ0eEtoUndOY2EyMlBEQTdJUUlwWngy?=
 =?utf-8?B?dll1ZjAyRjZsckkwUzREL0ZsUEFJQWtKVFp3ZmQrTXhvVnlSRzltb3hKaWhi?=
 =?utf-8?B?MzRSNWlCZ3lQZ05oWnlPNm5JVERFM0pVL1VXSzh5SzFya1Y3ZFRVK0l1N0hT?=
 =?utf-8?B?TUFKdFJGcHkwNStvUFdpV0kyb3RDNGF6Q0R4cHQxb1l4QmlwUVNmZENUYkxj?=
 =?utf-8?B?NUFsNXpOTlNkSFFTTksyQmFxRkdFQy84RjNEZDU5dDN5eEF2YS9SWE9RZDM0?=
 =?utf-8?B?VUxSRUF2aDVubnV1OWJmT1o1aUdLRGVmaDZsK2NSSG4xUzY1K3J1ajhJT09U?=
 =?utf-8?B?cUFFNDYzditGMXNHTkh5MmNPdTk3YkRseXlkQWh2MnI5UTYxSmZWdmlwYmRV?=
 =?utf-8?B?aGdnOGdLZkJGZ1VPQ0hHK2trUXZpNXBNMHFMVjFZUFcrRFpPemdGaGhKM2hy?=
 =?utf-8?B?U1duRGdPNFg0dmpzQ1ovQVVjeXIyMHM4TFUxSWFGcStudzRtbzA1VVdDZG5Z?=
 =?utf-8?B?TkxJWTJIanlsTUM1bklIemVwa1o5TnhYSHhCcm5sejNTOXdnbzJ1NkRmSjhw?=
 =?utf-8?B?eDJJbWkxTkhDcTZzeUQwaW9BaFRLdDl3NldhL3pXYUpHUzFQVEhhU1NCb3J3?=
 =?utf-8?B?U1BnN0R0Vnd5OG93dTIrRkJYelNsK1BScHkvSUpORzBsQ0htS2k2MEZqaXVZ?=
 =?utf-8?B?dFN1b2J1cDV5SldkYTIzY3ExZnE4VjgybEdLSDRqS3VJZnVxcEw0TlJHV3ps?=
 =?utf-8?B?c1hEazB5ZVJ4S1hkd2NWN1A2V3lpMmlOdzU0REdISldGWVd3RDNPdkF5Q3ln?=
 =?utf-8?B?aVdibTRnenpHNDZHRWp3eTFQT0lYenJtdXB4eDhvNXkvUmROWDc1d3NnYktn?=
 =?utf-8?B?eVpLdkpxd21ESTFDQ05uRy8vcUZlZlM1WGZMZ3pjN2ZHOTUyYWR5TUw3Mlha?=
 =?utf-8?B?ZVBjR3FkZTJhVDA4QVp5b0pUNFEwV3lpTGJEMGtEby9QSEl2YTl0czRzTE54?=
 =?utf-8?B?TEtwaU81ZWV4TWcvU1E2WGpjUjZNMzNvNjFyRFFoS0pVU1k4VEcvWjVEZXZR?=
 =?utf-8?B?aFRWNkkySzZGdk13Q04wK0pXRDlJRDNzdEtaS0ljYS9adEE3RGwvM0dpZGNa?=
 =?utf-8?B?NnNZTlJsdnpLQTVVUjVYdGRTZkZvN05SdU5VRkxRdm55VmZSeGZmRGN0R1NF?=
 =?utf-8?B?MThKcW40WDZteFlrZXhJUDMvUDBIOE1yQnZBMW5hWnM1STBEcjR2eVYzZGty?=
 =?utf-8?B?Q21kQkFPUXA1KzU5anlMREQxaU5qWVl2VmtDT09jNFdlWFBZc3BOYWdjUnhT?=
 =?utf-8?B?eGdIUWNwTVowcldJenlESXlQbjR0UDVXdWtlYjhFSHNhbWVhWUk5QllvZ2Q1?=
 =?utf-8?B?UWhHbmJKazF5NzlQTkk4SWREVUx4Y0hjNFY0b2VGTzlkYWFCQjQ4MUZqOXA4?=
 =?utf-8?B?SkcvcEovVVIvalpGUDU5YVRGMGViaFJUeGhZK0ZtajRkRVlUbGxvWndBRjNh?=
 =?utf-8?B?blhETWFRZE9UejQ2K0t6c1V6T0JYbEJvb054MlQ5TFlpS3Z4dkFwdTBXZVRm?=
 =?utf-8?Q?syhSSY1TtYLZEEtCe2h/Tzmut?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc9e31a-bac6-4d6a-5a0f-08dbfaa2f9c1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 23:43:28.6254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlWRwyzJj9xr/r8dXWhOjGWNfFBQxsVNotrzugmAZzcI/xpwkfcyC6L6csqEpx7v2xWIsIuF4b+AN0lOEB2iEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9271
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
Cc: Philip.Yang@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-12-11 05:38, Christian König wrote:
> Am 09.12.23 um 00:01 schrieb James Zhu:
>> Needn't do schedule for each hmm_range_fault, and use cond_resched
>> to replace schedule.
>
> cond_resched() is usually NAKed upstream since it is a NO-OP in most 
> situations.

That's weird, because https://docs.kernel.org/RCU/stallwarn.html 
specifically recommends it to resolve RCU stall warnings. I previously 
told James to use that instead of schedule().

Regards,
   Felix


>
> IIRC there was even a patch set to completely remove it.
>
> Christian.
>
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> index b24eb5821fd1..c77c4eceea46 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> @@ -199,6 +199,7 @@ int amdgpu_hmm_range_get_pages(struct 
>> mmu_interval_notifier *notifier,
>>           hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
>>           r = hmm_range_fault(hmm_range);
>>           if (unlikely(r)) {
>> +            cond_resched();
>>               /*
>>                * FIXME: This timeout should encompass the retry from
>>                * mmu_interval_read_retry() as well.
>> @@ -212,7 +213,6 @@ int amdgpu_hmm_range_get_pages(struct 
>> mmu_interval_notifier *notifier,
>>               break;
>>           hmm_range->hmm_pfns += MAX_WALK_BYTE >> PAGE_SHIFT;
>>           hmm_range->start = hmm_range->end;
>> -        schedule();
>>       } while (hmm_range->end < end);
>>         hmm_range->start = start;
>
