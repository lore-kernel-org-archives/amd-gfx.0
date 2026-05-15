Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3987CD343F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 04:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32A9E10E03E;
	Fri, 15 May 2026 04:52:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1LWAh+oy";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3DC510E03E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 04:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1Xz9Wz2Mb5469zIUCsANP2pG2jhD7Wt60VisgrlYGCswi4X6FZ7h1rKfubvR/k1CFjCR6LeSnvrewFmeSeWxZU2KVxkkszUgyr9RiYZ1oPdvrLiRw1h+ArkW5EDKJIrEy1E/we/WOTND37iOSu6tvAJ6LOslOYQF96sBWJtmiSv8UwKWiuJb4qdphhfdVKU8TDNRo9fWLjZk5vtV0TCIO/hvGhoQm18hBxKVZjw6tgwCczQBs18ZuBmcQw7MqSlcEaOFSJ4A1STGYGvswRvc/3n9pXz1pUE45YDTCL42osg7lUeOq7waJu7VQz20+TV1KcSkxpamFOKo1k3I2ViSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBzash7hCMAP8XxZOWQ6OvQMZuCNvD9MNzPU1HVdJNw=;
 b=PL4v+kdmmL8IgJCSI3HMycCeC/6sD18vkgVUqT0a3d3cSV+YHXnIvb/gRgkiCB6xZ4I/oNxHiQlsmKBrqOLlcTzbbtm298Bx3XdJl/i/ezFRSLPdvtgMJi15CrQYpiPwyajKHqFoVcjCCv2/Wdm023ePPGfzlqluqYXZMa/vW1/DjAmxHyDE5FR5IlFsRU0q61fNucmTyUoDywJhCxfTrr9xMaiHY4WJSkuIfGP9dEt5KMsHM2wDCkQPIlQcp6QqAOa97dYePwjt8OCp/rrE+uj+KBm94daixDZMXlxORzHLJdd+Q2/ACB4QQPUIg2sZR+hp9scJtTELtcJ+rVEqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBzash7hCMAP8XxZOWQ6OvQMZuCNvD9MNzPU1HVdJNw=;
 b=1LWAh+oyTQy5pMRGJwOTt+2ZDV4iDTg/YMQvAt7TF3eQSydMyb1l0JUShgI/6QDAvFFp8PLGJcGcZTSVrFTu6Ia3AnV7ue3OmtQrMbYbzU8dFVuSeJx8uJPvIun+sJrs9R0C5nTi7jls30hHZCdeNcOhJacnsq9khD/tcGk61Zc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Fri, 15 May
 2026 04:52:38 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 04:52:38 +0000
Message-ID: <82242212-0878-40c1-b6c4-73d02c25ad82@amd.com>
Date: Fri, 15 May 2026 10:22:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: unmap userq for evicting user queue
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20260514124250.3833711-1-Prike.Liang@amd.com>
 <20260514124250.3833711-2-Prike.Liang@amd.com>
 <DS7PR12MB60058DE56534CDD21A0817D3FB042@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <DS7PR12MB60058DE56534CDD21A0817D3FB042@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::16) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|CH1PR12MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: dd40add6-afb2-4a26-ba1e-08deb23dc9a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info: P95diqIgRxBVa0P3lF4I2yi0tPU4WITX1iO61U6VaI7OXYGSRI2g4QiBsuftJyO7dK/G9wLgGE/tuUCXKVousWApW4nBUUowfNk/bAIInDtJ/dvv26wjfqSGrwxUEyJDn7Y1jAzg3JRxUmP1Q9Zc2cxEKRn0mStGhlCDHiGY+ZXk0jyE5gnG5UbhRgdUlSkNvT2/myinRM9G3JjrD8LnS+JfNoioP/xckOsyd4sC2SShNxsha6V7yiJfDDRLn+IT3UeuChcH4iI6VZYNYMCtl45k/NuwNEM/1o7W2AxUncSBQtK4SK1i5PGcFWsIw/xFa6JP3oE01EwRgHxXWOVYoHvhE1JWk2R4IHT0vgQZwPLpUvRoqNcoCPI4v5B7X9NjppJs2PaPYDeCVKsuLt2Uon9VRnsDGW5seyVGKq+tcC1qUgK20tIMIyupc+8k1Vm6uSWq0/TY7Fec1hSQ8rvNCSbvHBvKxryhVHdvJuYuqw3Wwl0nmsvnkUcXT1CMpGacpKe+AD3KIFYhhG4a08ZqvmtzmFDc1t3anrrrVBxjGzkz6nOASn8wZ8ISfFzDvD/JwjCaW8F8w6o0J4JA3+nnR5cxw4uIJ5ZEyZ15GzKQyd81cT6quH2pnyKlScMe0R1L+9g8sCWudk07CceCwj++Y7E1/3U4FNUf+Z2MaYkPAGcV4z2Y+CZjrubD8xHB77ij
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmRESHRUVmxKMlhsdkRvbG92LzZPY010M1dEQS91STY5TXZvd0ZuWmI2MnJS?=
 =?utf-8?B?bTVrbFBnZWwzYUJ1blNIZjJyQzN1cEJjUGZvc0hIZkFCVnIreTNFeE93QkN6?=
 =?utf-8?B?S2NxVnR3eG9acEE2VktGMUZkeUV1R1pYMHZ6WHl0TEovTTNvTUFjanBxaGxQ?=
 =?utf-8?B?SzNibWNObUNmR0RjWDZ6M053dlVZTlFjdkRPem9IVUlieEVFdkdONVNpRHlM?=
 =?utf-8?B?TnFhSlpZVEI2WDh4a0NjeU5leTRKdlJFUm5BSiticzh2UkZzR2kxVGoyelNj?=
 =?utf-8?B?RnpPclZhbGNPbDhISm9kdEZRaHdvTFdPVDI5MHdoYmRMZ1pyTGhrbExZWEFC?=
 =?utf-8?B?L1pRZDkveXBBYXJzZ2dJSDJlRG43Vkk2Rm1NTGxCK3JlbHJybzNDVHg2Kzc3?=
 =?utf-8?B?ZnE2N2p5Q2xUU0lGZHBHVlJpR3p1SEtCQlRlQkVPNXZ5SG1BMkVvOEU3NldR?=
 =?utf-8?B?YkpoNmcrZnhvYVpYS3B4UFdTaXBwY09BWXhVYlFGbnpBaFo2VzV3ZkNxcDlY?=
 =?utf-8?B?Y0NuQVh4dU12UFBBNUNTMWdKdkVUM3U2ZjBpUWpCcnRoYmdQeGlIeHNkTTBw?=
 =?utf-8?B?d2JwV3N4eGZuRkk4b0RXMC9kL1k3alIxY2dBSkwrVnp5OEp6Y1FLR3RPcTVr?=
 =?utf-8?B?U1VMRkRiNVFaMlZ3Yy9hQXpaazFjMVdqdjM2MUl6NG5uTzZicUwra2RvT0Rn?=
 =?utf-8?B?dkJrWDdqU3pOUGgrUnVESzVjMDU0MGtnTDl6OE5ia01LVmVGRHlEWFZ6SjFY?=
 =?utf-8?B?d1l1a3pRTXlvZzRTNUZENEcwazE5N2NqRGVUNFdZRVNyaUdrNEFVVzNhL3Bv?=
 =?utf-8?B?bWdFV3dyOS8wTjdBMzFJZHpEV0Zud3Z1czM0cGl6ZlB4NFlsdytEdGVuRFVN?=
 =?utf-8?B?ejBFNDVjWVl0SU9NRzVLMlFDeGdNSWFtSU1rZ2tVUzl0MDlBdXVnTSt2dTNX?=
 =?utf-8?B?cWZMckx3RWZ3cGNQZk5OaUdZYlB2THZCeXgvRVpoM0JRQnIrM2g2RTdPRzlF?=
 =?utf-8?B?QS9mZkRuNnBiQXcvdUtiMG52OXRFazRWWDNVRlp3Vk9ZbnpVaXd5bmlHYUR6?=
 =?utf-8?B?WmQ0cXRlbmpiblVIdTlNQXZ6MjdKSHkwRlhLZ3ZQbDdiZkFYQWQ2VWVob3lw?=
 =?utf-8?B?cThWcW9mSjBkVVlNcVRoZG03SFA5SEtPYUNzeUl3c1RONW9CUlZvZE5KTTJl?=
 =?utf-8?B?UUlxU29oZEpWQ3RoWkZrcUl1Z3hPZDcvaXpudDBua1dZM01QeEpEd3l5b1Ex?=
 =?utf-8?B?YzBXTlJobjFYQ2tvRXlab0RrUnVyUlJldFZzNW51Zm5YZnJCWjFFRlpGWEVC?=
 =?utf-8?B?MmxUTU9xWm1SK0ZHT3EzWWFleE94cVBGTlVjQTM4d1dKc29BK0dQZ3BFVU04?=
 =?utf-8?B?K0lqMTFqYThVYlk1K3YvTEZsQXBkT2k2V3B5WmREc3FtTjJsOXhyZkVjRXll?=
 =?utf-8?B?R3BwSlBuRWhoRmljamRhcXM3dTZLM3FjLy95VDZYdEptSTFiTnN4ejZqV2o2?=
 =?utf-8?B?emIzTlo0WDNmMEVXVFhDcVlaaWxNWHZLN3NlbUdNL1lBQzlFYkJuc3pxakN4?=
 =?utf-8?B?SWQrTDU2M010ZGhUSDc4MU00aFJtLzZDWTNSZnlyTzFScTF3ZGJJbUJjOXV3?=
 =?utf-8?B?TjYreHoraS9ML3htVXYzaDZPTUNoaG5FQ2Zqd0RGakNrZU41WjY0MFdaaEZv?=
 =?utf-8?B?NEdPOXhlL2hPMHBLM3VVL0ZjSDFnVkdIb2J6bUt2VGRUczBlb2R1cTkxTi8v?=
 =?utf-8?B?T28xdytocTNwaldycXo0V0lQRXZJVXhTQ0N6YWNhR1FCN1U3NGdqK0N2N29V?=
 =?utf-8?B?QWdmZWYyaG5kK1QxTkFIeVdEc1U1K2RmM3NhU1RQSEVaWVRlTXM3ZlUyY2I3?=
 =?utf-8?B?SWhzZlQ1YkR2c3BtZGdHK0U1UnZ1UjFkdGg5Y2JCbnBtbjZlVWk2Z1NuNnNB?=
 =?utf-8?B?L1RVd0t0N3pVOVljTXA2OHV4WFp0NWpXZElhb0E4ekFYcmwzcCtyRTFYdGRG?=
 =?utf-8?B?cTRWdFJ6ZlluRWV0eDZwWmpJb2lCdEZZQWhGcDJsajRRYnUxVjE3ZU5ZNTM5?=
 =?utf-8?B?Y3pkdzd6V2d4UENPRGQxeTFwcjhCRVEyVGpkVHVPZ2o4N2NVWVFnT0l3aGto?=
 =?utf-8?B?NjJ6VkwxVlorcDZSNWxadFpCT29oV2F1YmV4VHZWSDN2SWRNQzNkd1VSTldU?=
 =?utf-8?B?bDVlRDZQdXdrWkFJRU9KMnk5TWdmUnZlSDYwekpVUWJ3TlMyUUtpMDR2TzM5?=
 =?utf-8?B?a0RyVWhZYW50bWhVRDFUT1QrVU5hUnAvc2FsYnhuRGE2Ri9rZHpBTlVYWTZy?=
 =?utf-8?B?aGwzd2REdnUwc05nc1RIaVVBUUhyditGTHh6dGYrRmtpYWhJdkFTdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd40add6-afb2-4a26-ba1e-08deb23dc9a2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 04:52:38.0712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHZfMMsgcpRMPtdd4ElOcgOsKTqV21/CF3C+g0UbIU08wr6azd9Js4TjmepSUtxbkWXTzelMHRrTdwA3l8A0tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623
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


On 15-05-2026 08:00 am, Liang, Prike wrote:
> AMD General
>
> Will resent a new version for updating the commit log.
>
> Regards,
>        Prike
>
>> -----Original Message-----
>> From: Liang, Prike <Prike.Liang@amd.com>
>> Sent: Thursday, May 14, 2026 8:43 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
>> Subject: [PATCH 2/2] drm/amdgpu: unmap userq for evicting user queue
>>
>> If the driver only preempts queues, there can still be inflight waves, pending dispatch
>> state, or resume/redispatch possibility tied to the same queue. Then the VM/TTM
>> side may proceed to move/unmap queue related BOs during evicting the queue
>> while shader TCP clients still need to access them.
>>
>> So for eviction, unmap is safer because it makes the queue nonrunnable before
>> memory backing is invalidated. Meanwhile, for a idle queue it's more sutiable for
>> unmapping it rather preempt and unmapping also safe more processing time than
>> preempt.
>>
>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 2e3edb6dd506..a63dfdfa4195 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -1048,7 +1048,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr
>> *uq_mgr)
>>                        continue;
>>                }
>>
>> -             r = amdgpu_userq_restore_helper(queue);
>> +             r = amdgpu_userq_map_helper(queue);
As per my understanding, we arent done for the queue and all the 
resources of the should remain intact. A queue ideally should only need 
" mapping/add new queue" when the queue is created and once that is done 
only the light process or suspend/resume should be good enough. We dont 
want to tear it down or rebuild again for anything transient.

Restore/evict in most of the cases is a transient stage and only a tear 
down should be unmapping it or during a GPU reset which reset all the hw 
states.
So the way it is seems logical to me but i leave that to Christian to 
confirm.

Regards
Sunil Khatri
>>                if (r)
>>                        ret = r;
>>
>> @@ -1285,7 +1285,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr
>> *uq_mgr)
>>
>>        /* Try to unmap all the queues in this process ctx */
>>        xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>> -             r = amdgpu_userq_preempt_helper(queue);
>> +             r = amdgpu_userq_unmap_helper(queue);
>>                if (r)
>>                        ret = r;
>>        }
>> --
>> 2.34.1
