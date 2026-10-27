Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC445606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YjDGZVFt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26F3010E438;
	Tue, 27 Oct 2026 18:54:05 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F14310E438
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 18:53:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJxUj4lmsyM97ay/6o2n+/dyM7XIIHUmyxhDx9dvAXlxmOMnRxC2gVCFHF0kIqmS3Q1oLFJgw94Phu3GV9YVTz25i6v+yE069gdfV6PmoiAcagX3XHTOUyIOeklO/NybL0AidhwJDxI3KVwZrJmig60f6O8aXGtfgvlsEZ2cpAk4r84jVjOeQ+tBU3Rbk4DbRrr0DweDeLnv1SM5LUsm6biXu5uehsVDZzv5DQWw2j/OiLYuPVCYRsMUOZxbwN2p9ueKGNMEWyftHTd2AN9S1xG6wnm3ZbSo0PIKk4wXdKJhLMbxSHlojckFQOPApccvfjU3j7Fgzjmc03DrUb+49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyA9y1JpL4c8SqXl5XSmplmBEYQOE3cghPlC1FVbmwI=;
 b=LjPPGdWt3O9UxO6hB8IOTjDrT44W6rBkKUCIZhNdhU2bLCALR9UMv6DVpUICAEXznGIEiZgzJs5SWtvbZE1DgezxFK487debW4zYrn8E2dVVj0v89q7BlODBHXMHNC7fnCNRIoQ3kw4KM4GEMgvAYXX7mU5q/3KSaLy+sqbmSRVVJn+B0TwYhGT9vY0xqzw107k8NxDG8297ygUHJs+FYVP47RV732A5wTKWF4K9F4Q4/CPzg7taiIgX5rYQKb+qAcE7E8rnuDVAgNakBJRlMfQUjzFQyyaZfPlF/w+szUmedHelCE8ohXFpJMUKRJk6D6LOZtMX1HPR9oDQidMtRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyA9y1JpL4c8SqXl5XSmplmBEYQOE3cghPlC1FVbmwI=;
 b=YjDGZVFtS06GCI8PGvccSpNvmVWawQSWH8JWuuP7jLPdJ6pTec8BhBKX0ASgO68cUmGSJ75gk/FQRIlL5HSZaMJrBDYqMfscS3psX8xm3UH3qXHZVXm5WleOmRYYETU8FOhljGkgLuPgiwCU96lUKwXHeXp8ZVAgbYkMCTWEbf8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by SA3PR12MB9199.namprd12.prod.outlook.com
 (2603:10b6:806:398::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 18:53:47 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 18:53:47 +0000
Message-ID: <e41f4acf-2916-4a83-984c-03ec2e108365@amd.com>
Date: Tue, 27 Oct 2026 14:53:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/amdgpu: Emulate exporter->importer UALink
 messages in loopback
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261026230248.1597606-1-mukul.joshi@amd.com>
 <20261026230248.1597606-4-mukul.joshi@amd.com>
 <3b55caea-6908-406e-ae91-33e3b7814ed3@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <3b55caea-6908-406e-ae91-33e3b7814ed3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0326.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::14) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d629712-433c-46c6-986c-08df345ba1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261021123027099003|261009223027099003|261022105027099003|261021121427099003|10067099003|56012099006|261026121527099003|6133799003|22082099003|18002099003|4143699003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: PHhymUup2bXwj/q/L1+7lT/jXX7rya9GILkMCMfix/HN+wWoibvWwKGToVyvmAPqD8ztJJE/Yafy6tDgibHYhCZfBv7MO1+HahzsLrSW6OQK3JbZQQvc354hsOZx5wA4zNweefHzEPaNssXp5hVWhw21VQAvrGzJ1rbc8elZFc/DTnTb2kVDMg33FG/l/TgexIdNx52WJ05VhVvKIxvw5lM9H0WRa2UL1b+P1437q8EoNDfY0I8LIRpsIhaTkKaiyAEbiJ+LygY82rlKVOTgsmApI2Gn6hDGSjFVgBeUC+3ybPSCr1NviCx/p7tAGiJ4M94qEqQfb4cUwcLK5A24qh/4KEE6NZ9CBQyRRMJ7pt/0jONtAg6vA0sox6OQ8rjaxRwpIx5p9Kfv8yzcysTUcIQJCEySFVa6ZsadYRPhcO9twuGrhLciBh5PyOKYs++90t6C1sfUiuLGPwgu8iTKIDBLA/1+S1TcN5XsLH6+bRcC9VYF0hFIJrABPuJTF+6VxUpxGSKs/xZf+XP79aSidNgVVFdGnNQX1ZAxJpaiQDakNR5lMYmN4wqP0cpsNZ3y35Nfqf3z0bNfYJVEMZSxN0rq9O5FS5vcwL0AH7xJk7p+CXww5bl6LgJZDloimyj+N+unSA/wd/LnH6dcMGzmsOJ1XP9Cku+oWbrJ4ljfcSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261021123027099003)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3d2bDVvRnB3cE4zcDlQYW9LUm10eXN2Q1lWeHptVGJWSE1xbjdaR0JiUUxh?=
 =?utf-8?B?ZHd5eEVaS1EwSmFTTjdwUzNYWENLRTU1aUdFQUNHYWs2N3NlZG1QcGtKbTZk?=
 =?utf-8?B?RkJ1SmRsQUZEMmV4aFdTVnJRQ04weE9WSUtJWVlyN1RYUkVnUlptK2VFZVc1?=
 =?utf-8?B?enlhWjI2SVJ0Q0tuTThhVUlGd2RYKzU2emYwSkthZmtUOUFZQzNnemdvbDMw?=
 =?utf-8?B?bG1Yb2hyQVlLS0xhdXBBbGpOYVVIQ3ZIbkhSclBMM0NqNHhnN1JvWnBBRlhQ?=
 =?utf-8?B?bXdCVGZDWmQ3WDB5VXpGOXpWWi9PcTF4SC9DQ2lRd0hUK3p3VGtFQUlEa1FF?=
 =?utf-8?B?UENBbThqSkZ5Y1R0ZEtWZVllZnJhQVJBYUgrMktTdi9xcTgvQ1hTT01YQVdO?=
 =?utf-8?B?MDNPbktyc2lZZjBqRG1EMnRUOEM1OFBBRVBEMkNnejBmQWFnYXE5T2FPL09L?=
 =?utf-8?B?SHluTWZmTzFhQVdPRnU4dHNFa1lHOXhMNTBHUGtBUTluTzZHSXI2b0N3VjNm?=
 =?utf-8?B?N0hBTTliRGNQUlZDL2pBL0Z6VUJzYmtmeFV3anRmVEZDTU52OTFla1dLREhm?=
 =?utf-8?B?bURXYW9TbjlFS25JcnpDbkE2V1VRcmw2YU11ZWUyRFVwdEpnVjRkeWFkb1ZG?=
 =?utf-8?B?UGtIUGtKeDhuazd5dUx1MVZPVHF5amIxclNOWm9Sb243VTJsQ0RyYmFLK1lx?=
 =?utf-8?B?QnppaStIQUpJRXZuUDVPVTd2NVpQVHdXRmlDa2VDbGhKdGtYN3FUM2V5dmtO?=
 =?utf-8?B?TDYrQzZ6aGZEaHQrcjFTOUJFeFIvVnFBNFNtdkhtUHUrSTY1NFBOdUdaMFpr?=
 =?utf-8?B?SWk3M3VwcEU4UjZRc0pURHBlV0pVR1RFYnBqOU9yb0g3NXlRcW1aamV5UVZh?=
 =?utf-8?B?WG55cG9vUkIzZ0NMKytpb2NuRkE0dGxSSUxpMk9sMGRDSmFuUmJRMFN5SWky?=
 =?utf-8?B?eDJrUTV1Z3NqWk1RZkVjOU9ZVkRIL2xvTWpQT0RZMVo2WDN4VzdZREFnOWgx?=
 =?utf-8?B?UWFvbk90R1dzU3NiempNS0RIdlFyTmdTN1R1akRTVFpUOWVDQjMrK1laRUpX?=
 =?utf-8?B?OWoyYTEzTXdLTnV4N0YvQUNYZUFvTy9EWmdGVWdkdlB0aVhDYUdPMFY2cEdv?=
 =?utf-8?B?Tjh4MkxaZExicVBUSldjM1JTKzd6aklMK1A4NmdDOVppYmdXQWhUS3RHWC9r?=
 =?utf-8?B?VC9xSFZOdmlsN1o3S1MwWXgyQSs0Z21UMW44VmlLYWtBZTlMRmRXZ09uc2ht?=
 =?utf-8?B?UU1UcUVWcjc4MktBdGVLc3BUQ2V3dWRBeWhFTEpHY3AxTXhiWlFJNXFtVUo2?=
 =?utf-8?B?VjhPY3hQL3FuTFMrakM0WXhySUNZdUFGVUlDZ3BlVk1nR2QzZXEzU0laZkpa?=
 =?utf-8?B?VDBHVnJjaXZtYk5PMnVlMDRXYWtYY2pleWUvUDE4cStxeVdFOEFzOTNHK0dy?=
 =?utf-8?B?aW91dHdRZmRINVFVTVhibWpNaUE3QzFnUDU2aXZpMG5mR0ZQdjR3THd4M1M5?=
 =?utf-8?B?M0sxYTZCVUVzMGpGQVNaa1NLUUU0enVrcmF2Skl6UlBKV0IrU1FZKzhPbENr?=
 =?utf-8?B?cTJac1VpQVo4Z3g2cFUyVHhEamxKTEhzcG8vNmlSbEc4NDFrKzhjdkIyTVV3?=
 =?utf-8?B?VjJwcmtKc2d1TldJdkxBL1ErcXh5RkxZZFZFUkNjaHo3N3Q3ZUpZK1FLWWlG?=
 =?utf-8?B?RlpwTXJoZnd3VUU0UEJnREtaamJtSjJQaFEyMGdadzhXRTIyRUxKZUhoaTFW?=
 =?utf-8?B?eEFBbmJhU2lILzd5UHpQNkJKcFJxQTZ0bUpTQlFiQk96di9FcXdZQjdyYzJD?=
 =?utf-8?B?L2l0ek5VdWRhWlFWMnNESDEwdDFqcFZvSGVZZzdlVDNmTVVYaDVhR0tVRHVt?=
 =?utf-8?B?YnpKQmxoS3dwWTFlVUtSMkdmQjhGK3A5a3B2cHVHTTQ0T2hSSE5qWVBtNFc0?=
 =?utf-8?B?Y296K01ncXlsNnNjMFlFWmpDN25kWGpTWnhmTHM2U205bmcybHNxa0RlZ2Ja?=
 =?utf-8?B?cFQ3ZVZzUlVsM3o0Y2JVcTJaV1RJRXVMM1hkbTN5cTBDN3dUbU41aFRKWTEz?=
 =?utf-8?B?QnlRQS8zSVZlSFNEREJ6WGVybi9GemZaSDJ0YVE5Nmtyb0xFS01sbGF3MWlx?=
 =?utf-8?B?aFJVZXEvYnBJU2FPbS9HTCtnbTByZVdnV1pNYlFSL0xic1BLbW1WazYwSjNY?=
 =?utf-8?B?QVVZWVlCbkVLUzdOSUxWTEpaZ3E1cm1MeER5dkhhVTdJVVUyWGdwUUMzVnox?=
 =?utf-8?B?WDF0K0RSOUU1b2pqRXcrT1B3NHFZNUNyOWpOQTAvZEpocklhVW5sanVCODBo?=
 =?utf-8?B?c0lLN0FYU3dGMnJ5OVR6ZTV3MW9vVWZ1Rk9tU0IvZVRObDZPaCtLUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d629712-433c-46c6-986c-08df345ba1d1
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 18:53:47.2113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIFd6LTMfalN5xQ63pntQ5/b5E7i6fvu3nkiTHId8uOBefdv+iBvXlu/KclHyEkXHeI4AjLfqwjpSnJXRQSKKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/27/2026 2:25 AM, Lazar, Lijo wrote:
>
>
> On 27-Oct-26 4:29 AM, Mukul Joshi wrote:
>> In UALink loopback mode a single GPU acts as both the exporter and the
>> importer. The exporter is the one physical station, so the only path
>> the HW serves is importer -> exporter. A message the exporter sends to
>> the importer cannot be delivered by the MP nHT.
>>
>> Emulate that direction in SW: when loopback is enabled and a remote
>> interrupt is addressed to the importer, queue it on the loopback
>> ordered workqueue, which feeds it back into amdgpu_ualink_process_irq()
>> as if the exporter had sent it. The ordered workqueue keeps successive
>> messages in order and runs the (possibly sleeping) handlers outside
>> the sender's context.
>>
>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 82 ++++++++++++++++++++++
>>   1 file changed, 82 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> index 64a051242367..e40433bd79df 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> @@ -59,6 +59,9 @@ static void amdgpu_ualink_reset_peer_rings(struct
>> amdgpu_device *adev,
>>                          u32 remote_accel_id);
>>   static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>>                         u32 remote_accel_id);
>> +static int amdgpu_ualink_loopback_self_interrupt(struct
>> amdgpu_device *adev,
>> +                         u32 sender_accel_id, u32 dw0,
>> +                         u32 dw1, u32 dw2, u32 dw3);
>>     #define STRIP_NPA(addr)                        \
>>       (((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
>> @@ -6218,6 +6221,17 @@ static int
>> amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
>>       struct amdgpu_ualink_ring *ring;
>>       int r;
>>   +    /* UALink loopback: the single MP nHT can only deliver
>> messages addressed
>> +     * to the exporter accelerator. Messages addressed to the importer
>> +     * (exporter->importer direction) cannot be delivered by HW, so
>> emulate
>> +     * them by feeding the message back into our own IRQ handler.
>> +     */
>> +    if (adev->ualink.loopback.enabled &&
>> +        remote_accel_id == adev->ualink.loopback.importer_accel_id)
>> +        return amdgpu_ualink_loopback_self_interrupt(adev,
>> +                adev->ualink.loopback.exporter_accel_id,
>
> <nit> Wrapper functions in patch 1 may be used here.

ACK. Updated in the next version.

Thanks,

Mukul

>
> Thanks,
> Lijo
>
>> +                dw0, dw1, dw2, dw3);
>> +
>>       peer = &remote->peer[remote_accel_id];
>>       ring = &peer->interrupt;
>>   @@ -6639,6 +6653,74 @@ static int amdgpu_ualink_process_irq(struct
>> amdgpu_device *adev,
>>       return handled;
>>   }
>>   +/* Work item used to emulate an exporter->importer UALink
>> interrupt in
>> + * loopback mode (see amdgpu_ualink_loopback_self_interrupt()).
>> + */
>> +struct amdgpu_ualink_self_irq_work {
>> +    struct work_struct work;
>> +    struct amdgpu_device *adev;
>> +    u32 sender_accel_id;
>> +    u32 dw[4];
>> +};
>> +
>> +static void amdgpu_ualink_self_irq_worker(struct work_struct *w)
>> +{
>> +    struct amdgpu_ualink_self_irq_work *job =
>> +        container_of(w, struct amdgpu_ualink_self_irq_work, work);
>> +    struct amdgpu_device *adev = job->adev;
>> +    struct amdgpu_iv_entry entry = { };
>> +
>> +    /* Build an IH entry as if the message had been delivered by the
>> MP nHT
>> +     * from the exporter accelerator. amdgpu_ualink_process_irq()
>> consumes
>> +     * the sender accel_id from entry->pasid and the four context
>> dwords
>> +     * from entry->src_data[]. entry->ih must differ from
>> adev->irq.ih so
>> +     * the message is processed here instead of being delegated to the
>> +     * UALink soft ring.
>> +     */
>> +    entry.ih = NULL;
>> +    entry.pasid = job->sender_accel_id;
>> +    entry.src_data[0] = job->dw[0];
>> +    entry.src_data[1] = job->dw[1];
>> +    entry.src_data[2] = job->dw[2];
>> +    entry.src_data[3] = job->dw[3];
>> +
>> +    amdgpu_ualink_process_irq(adev, &adev->ualink.irq, &entry);
>> +    kfree(job);
>> +}
>> +
>> +/*
>> + * amdgpu_ualink_loopback_self_interrupt - deliver a UALink message
>> to ourselves
>> + *
>> + * Used in loopback mode for the exporter->importer direction, where
>> there is
>> + * no HW path. The message is processed asynchronously on an ordered
>> workqueue
>> + * so ordering between successive messages is preserved and the
>> (potentially
>> + * sleeping) message handlers do not run from the caller's context.
>> + */
>> +static int amdgpu_ualink_loopback_self_interrupt(struct
>> amdgpu_device *adev,
>> +                         u32 sender_accel_id, u32 dw0,
>> +                         u32 dw1, u32 dw2, u32 dw3)
>> +{
>> +    struct amdgpu_ualink_self_irq_work *job;
>> +
>> +    if (!adev->ualink.loopback.wq)
>> +        return -ENODEV;
>> +
>> +    job = kzalloc(sizeof(*job), GFP_KERNEL);
>> +    if (!job)
>> +        return -ENOMEM;
>> +
>> +    job->adev = adev;
>> +    job->sender_accel_id = sender_accel_id;
>> +    job->dw[0] = dw0;
>> +    job->dw[1] = dw1;
>> +    job->dw[2] = dw2;
>> +    job->dw[3] = dw3;
>> +    INIT_WORK(&job->work, amdgpu_ualink_self_irq_worker);
>> +    queue_work(adev->ualink.loopback.wq, &job->work);
>> +
>> +    return 0;
>> +}
>> +
>>   static int amdgpu_ualink_set_irq_state(struct amdgpu_device *adev,
>>                       struct amdgpu_irq_src *source,
>>                       u32 type,
>
