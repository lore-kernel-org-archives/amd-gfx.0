Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7849D606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RWTO+pYD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F21C110EEDB;
	Mon, 23 Nov 2026 14:49:38 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCFD210EC28
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 14:49:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnZyvmDh0PuBT0/PJ2wuavDN8Ey8u4BthEJUQEv5VWUOLfPtlbpuKNh67ldqijk7nbPAXR8TWSkuaf3y+qyKxf/q4p2jGTP7bTiKiLM1ibkGixGWahaX4IjKqMaF57gSZrKTzIGttbVpbFGsdL02fO8JfFDxTKAPHWk6C9CLQCj/dKjFel87rBg7W2OWEPxIbtnE4HXJNUVLwZ6puZyuD1QNGqQq2lVXF0AaUiemOZb5aNaYLg/giaHTALRk4OPWhkDLBTedNJaZZ3EyvvlazgMbTFds/5rfZ6E6NGKrFfYpPjIU2zWB6qumnY7QwzEPFdqaLaurj4HTR5fb4NdKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WteoHeZ7l7JH+B9D0Kqfe31M2q1/Q0cYOyvv6/XTWd4=;
 b=AajivmmHxudDetVuBg5TcNszTsPUH6dNYfuT0t3nwsv6kldDrvaynHwohbeOrjJoAbl3D/LCYyxHfQ+abLOg7vwRGBiIp7F0spkhSkR61Sc4P218eZvFxH5W8EvBW4j8FeG10Czy3eSueKPM7b3RgiH4/ZnrP9JhET5xF+Lyvy++jqXSKCtfrSrKKTa7shTYEqNr5s2gwKcJDzbaI1wMBDcS3A+wTtjKYq0Xe5Q4Ul70j96FcbhemBIWSAVZbsgzFNVqV4GD7/y3NDnfcPF0DRAxEuLzwSVumToQ08qpTtG0kaLnPMn7max9OH3J16ECzephzPzyPSeKzACniV8/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WteoHeZ7l7JH+B9D0Kqfe31M2q1/Q0cYOyvv6/XTWd4=;
 b=RWTO+pYDUSgLWlERxwpBui8ZvyXK887RnoXwyZEkQyE3v5RJs/cMuh//TCgxaaJ7W026C6sa3+gNOHNCZQj9UF1xzX7jjejxfJWawGgBq3Geb5njmJ7vqfZNlRcWk/D4vDYdQX+ZakiCLF47Ms9KfV6EMKz9QU9YBTuB7uRITwg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 14:49:28 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 14:49:28 +0000
Message-ID: <eb4995f0-4c57-455b-b081-46446cf8bfc1@amd.com>
Date: Mon, 23 Nov 2026 09:49:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: load-balance SDMA_BY_ENG_ID queue allocation
 across engines
To: amd-gfx@lists.freedesktop.org
References: <20261102154823.20736-1-jinhuieric.huang@amd.com>
 <c1fa1903-0822-4a2e-85a0-12c0244569ed@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <c1fa1903-0822-4a2e-85a0-12c0244569ed@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0161.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::29) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: db6d3ee7-c6fd-4f28-26e5-08df4970f97c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|4143699003|56012099006|261021121427099003|261021123027099003|261026121527099003|261022105027099003|261026140227099003|261009223027099003|261102123227099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YTZTNCS3ysDH95fGEeWKLKEdWY1Xk3uZLldnNrRRDHXDnapONa7OLiYtrOD4+O6SdxJrKTyCaPtEWVa3VOYx7dgvmYFn2vuCQw3mMJpFDs7sNJ/MqggbZGRmLGjJdUxGjbQKe4Ut/7913KisSB53piXfLMD6GIVItoCm3GBELYYlxbqCWxqwFQdXGNO9FYKxoKuhaOBbHmGB2nuQ+I4r1sjCAxndgspV8Nwq2seHGA3BPzC3NwoRddJeX7YLGRkQjqD2UKO5udEi8cPtLf56sSzbpCdPoYwwAcIu1W628Q11opcjEkzm5LlYhrHsr0by+W08brZR5g5Vq0NH9Xu+eezvE5B/Q+f0zKcrD7adpMDZTa/m9pmylsCcQ3YcbSkCjzhp4ED5mFVTLwsMmTpeob3vWWkPV8tCIuA9Sk+hBSaes1ygUonJPw9xi2C6S8jLLEmrNaTpnrlAxzlPDn/dyBUtyJXrBZLolDDR0TKJ7+yiDeVOLbWMUIjTyyRJkCHNg3Wc4AOfdODLDFlsArEhCrma2dGLuH5qb+JekcGIsu6YMteNOFJdt+CH/m+zheYO94bYOfXJHVr/BH7IP4rjwrljF8G3j8mZpbo5OyndLNVevu6ygUSYhXu17MgeQgxCAdlGril6scm1CQxH8d0ZJQPapT5UhaA6JT7wI3jFcrA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261026121527099003)(261022105027099003)(261026140227099003)(261009223027099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azRPY0VyL2VUc0ZMVGpLV0ZPZFhCZ05CbERGVnVTeCtibDkySWo3KzZKaE5j?=
 =?utf-8?B?VkQ1dDU2SmY4bkt0QnF4bmFHbjh0UzJVR0ViQ0ZNKzdZck5yWGJpNW5oSE9F?=
 =?utf-8?B?OWx4NEg2L3JQVVRYVFFKT2xjQUdSWTEzaWFubTd0NFdnY1hkN3BGa0FCZFo3?=
 =?utf-8?B?YWM5Mmd3VlJKT2c2b3VucTY5T2dIZElUcEY2c3BXVDJGVG9rWFZTaW5uaGdO?=
 =?utf-8?B?a1lkTVl3cTJ6RXl6TzlaT1FqMllUY01jYXVac1hWMXo1YVVMMXpEWndCTzhW?=
 =?utf-8?B?Nlh4K1Q1VkJNV1JUWFhWdS9QbW04Yy9Fd1RwcWNaNFVtMkZTb3BZS1hwVThY?=
 =?utf-8?B?cG5Oem5IejltTElmb21HZ0M2bXRUOGYzK3Y0UHdCODFwMHQ2cFlSYzgzTWFU?=
 =?utf-8?B?aFFYUDlicG9BTlFnTWpwRW5tUkNkczE0blYxZEhDNis4RDVzQ3FIWWRGZXNm?=
 =?utf-8?B?MDBiY2FnaFV2ZWpuenMyRGV1bmdVQ3gwcU83Smt0WnJMaDhxdFh6MjdFc2Yv?=
 =?utf-8?B?MzVXZDk3a1lzT09aektXTnErbm9oTmU2YWZwc0lNSDIrRGE1RGFGeXZVYXR6?=
 =?utf-8?B?TVNzeFBDb2d0d2RJb3pOMGM3dDhHbWFvb1FEdUJZRy82Q053MElnemN1dHNU?=
 =?utf-8?B?SGJPVHdJNlVXN296WmtIZkNOTGY3d00wRnhjK2RIYTFhajF1MFVOLzhaYm13?=
 =?utf-8?B?ZkZ4bW9GT2grWGtpNTlVWGZzYVhOQzBKckUrTEFBYnVQWHlEN3hNU3VnMjg2?=
 =?utf-8?B?THk1eitlR0dGdWIxUGJ5SkliMi96RC9TY0dJRWMxVlUyRDlraE94RnhITmpj?=
 =?utf-8?B?cDIzbzEraU1MWGlGL2JnMndlc01qRmpOWTFmbFFaVXZJNzlSZzh1UDRCYXJH?=
 =?utf-8?B?QkI1aG1OcVBCcU92Slprb29LeTdZTytYYUxXQlZVL29vWmpEanl0VUZmdzVj?=
 =?utf-8?B?SG9mbU13Z1lkUVppQVhsOVNBZTJGaEd1dXpvZHR2SWduYnZ1NlFreGtLRExj?=
 =?utf-8?B?M0pnUDZIZ1JVL1lpMWxtVVZ5cnA3NmRELzFGYVh3K3NMZjJYRm14Q05nYnBu?=
 =?utf-8?B?TVNpanFYYmZxVFVkZG81L1Z6VzRDS0xtRStCUTN0NDROejBIK2dQTTYwWU1m?=
 =?utf-8?B?bUN3UW1rdFZueXc0bU1VcHlUeXRLMVJHdjlpcEMwUE1OZllBbE9DU1dpdHJ2?=
 =?utf-8?B?elhnWU5RMFFRT21KdnNpSThpU1NzZysxeER4V1BMVUhLVXRmMmRIVWdtMnU1?=
 =?utf-8?B?NmNITGh5Q29ReUpWUktXbjdFWnZzUXlZYmRSU3ArYlIyemZCUUVmOTE5VDZC?=
 =?utf-8?B?aEd1ci84Q3c1aHJ1MS9JSjNqS25uVURIU1ovOGxjb081L3QxNEQzN0wwdC80?=
 =?utf-8?B?cExjS2xUc3ZTZ3FRNUFLQnd1VHV0azdXOFkyMmdSNlo3dUN3Sy9MZDJaTWNO?=
 =?utf-8?B?dTdMdlRBZnp0SndWSzZuNEphOHYxQ2dUOHg3ajBlZU45NEJGZUgrYjJUbXBX?=
 =?utf-8?B?aUZ0UjJDVHE3eVdleVVJelhCS3J0SWlOS3R3VXN4OVk5MXZyQUdNUUc3MFg2?=
 =?utf-8?B?N0pOZEc2aC9KdzJCblBlZm43VlFNZ3dwZTNPVUVJTzFCbDlIQ0YydCtPTktM?=
 =?utf-8?B?NmNCZG1KZEJ2YkhiS3ZQczVvcVRVazI2eG5kS2xZWDZiTWFVbDE5SkJrOU9G?=
 =?utf-8?B?MlhEL2lJUjRLa0xvNlZqeGFLcm9wNzBlZjQwc2xockgxb3NjTXVFRlRKd2tP?=
 =?utf-8?B?RytnWGZkdmorV0ZJTFRIWmlkZjRZYldFRlhxUDlqZ3dJM3N3MlB4WlJmcXRm?=
 =?utf-8?B?NWdLME9SU09Yam5aalVOSE8zQW1venpGaURSQzQ5RTNSZnZmL2RTaitNd3M5?=
 =?utf-8?B?Z0JIbXREZS85RFdXeHhxbFptUWJWUVowY1BvNnQ3dWpVL0pKYXZSZzFKcW9j?=
 =?utf-8?B?WGtYQUNZdlFidkw4R0NFVm9ZMmtvRzEvdnp2dEFBUjROUGFqZGVLMmh0S0Vl?=
 =?utf-8?B?bDNYWkdJN002WW5lbkw3YngxcTJIbktVV3lDQW4renNLN1kwNjRFM21HVWpH?=
 =?utf-8?B?cjlpMlBxUy9RaVIweXJkcEtqL08xTVowbW1kTVM4UldKazhjUWJTTUdHOWFH?=
 =?utf-8?B?eWs2VGhTL2EzTlhZcHJKaG9wUFkrc2oyZVpqeS9aK3NJWDJabmM1TlltZW5U?=
 =?utf-8?B?UGdFY3pxY0l5eXMxdVo2WUZtZjhoTUgyaVBaSUxIMVRuL1pKUlBMTzd6MXhQ?=
 =?utf-8?B?d1B3QlZGeE9NKzkyaTFLVnBpdUYvNlF0R29CUUJXellDTXlsM2JlVzlqV2Uy?=
 =?utf-8?B?RFdmemtmenUvTE5OaGtHRTEyR05ZdERocXVOc0diMnN2cDdvOC9mQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6d3ee7-c6fd-4f28-26e5-08df4970f97c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 14:49:28.5197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSw7iiFZfC3NflzgB+wLFwZhpRiilq+pn8hHasy8ufz5CJxj45Jqzb+IdJiGGZ0kq9PBA7PKmbEvoxDc/8uC/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ping ...

On 2026-11-06 14:25, Eric Huang wrote:
> Ping.
>
> On 2026-11-02 10:48, Eric Huang wrote:
>> ROCr picks a P2P SDMA engine independently per process, so many
>> processes sharing a GPU can converge on the same engine while sibling
>> engines idle. Use the existing per-engine sdma_bitmap/xgmi_sdma_bitmap
>> occupancy, already tracked across all processes, to redirect queue
>> creation to a less contended sibling engine when the requested one is
>> shared with another process or full. Prefers (in order): a fully idle
>> sibling, a sibling used only by this process, the requested engine if
>> it still has room, then any sibling with room.
>>
>> No uAPI change: KFD never reports the allocated sdma_engine_id back to
>> userspace, so this redirect is fully transparent to existing callers.
>>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>> ---
>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 147 +++++++++++++++++-
>>   1 file changed, 140 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index 7b2f6636ae0f..c8db35952e4b 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -70,7 +70,8 @@ static inline void deallocate_hqd(struct 
>> device_queue_manager *dqm,
>>                   struct queue *q);
>>   static int allocate_hqd(struct device_queue_manager *dqm, struct 
>> queue *q);
>>   static int allocate_sdma_queue(struct device_queue_manager *dqm,
>> -                struct queue *q, const uint32_t *restore_sdma_id);
>> +                struct queue *q, struct qcm_process_device *qpd,
>> +                const uint32_t *restore_sdma_id);
>>     static int reset_queues_on_hws_hang(struct device_queue_manager 
>> *dqm, bool is_sdma);
>>   static struct queue *find_queue_by_doorbell_offset(struct 
>> device_queue_manager *dqm,
>> @@ -807,7 +808,7 @@ static int create_queue_nocpsch(struct 
>> device_queue_manager *dqm,
>>               q->pipe, q->queue);
>>       } else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>>           q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>> -        retval = allocate_sdma_queue(dqm, q, qd ? &qd->sdma_id : NULL);
>> +        retval = allocate_sdma_queue(dqm, q, qpd, qd ? &qd->sdma_id 
>> : NULL);
>>           if (retval)
>>               goto deallocate_vmid;
>>           dqm->asic_ops.init_sdma_vm(dqm, q, qpd);
>> @@ -1923,8 +1924,125 @@ static int stop_nocpsch(struct 
>> device_queue_manager *dqm)
>>       return 0;
>>   }
>>   +/*
>> + * Count how many of one physical SDMA engine's queue slots are already
>> + * claimed by a queue, by any process sharing this device. 
>> Per-engine slots
>> + * are interleaved in the bitmap with a stride of num_engines, i.e. 
>> engine
>> + * "engine" owns bits {engine, engine + num_engines, engine + 
>> 2*num_engines, ...}.
>> + */
>> +static uint32_t sdma_engine_busy_slots(unsigned long *bitmap, 
>> uint32_t num_engines,
>> +                    uint32_t num_queues, uint32_t engine)
>> +{
>> +    uint32_t slot, busy = 0;
>> +
>> +    for (slot = engine; slot < num_queues; slot += num_engines)
>> +        if (!test_bit(slot, bitmap))
>> +            busy++;
>> +
>> +    return busy;
>> +}
>> +
>> +/*
>> + * Count how many of this engine's busy slots (per 
>> sdma_engine_busy_slots())
>> + * are already owned by the calling process itself, by walking its own
>> + * (typically short) queue list rather than every queue on the device.
>> + */
>> +static uint32_t sdma_engine_own_slots(struct qcm_process_device 
>> *qpd, uint32_t num_engines,
>> +                       bool is_xgmi, uint32_t engine)
>> +{
>> +    struct queue *cur;
>> +    uint32_t count = 0;
>> +
>> +    list_for_each_entry(cur, &qpd->queues_list, list) {
>> +        bool cur_is_xgmi = cur->properties.type == 
>> KFD_QUEUE_TYPE_SDMA_XGMI;
>> +
>> +        if (cur->properties.type != KFD_QUEUE_TYPE_SDMA &&
>> +            cur->properties.type != KFD_QUEUE_TYPE_SDMA_XGMI)
>> +            continue;
>> +        if (cur_is_xgmi != is_xgmi)
>> +            continue;
>> +        if ((cur->sdma_id % num_engines) == engine)
>> +            count++;
>> +    }
>> +
>> +    return count;
>> +}
>> +
>> +/*
>> + * KFD_QUEUE_TYPE_SDMA_BY_ENG_ID callers (ROCr in particular) always 
>> ask for
>> + * one concrete engine id, picked with no visibility into what other
>> + * processes sharing this GPU have already claimed. When several 
>> independent
>> + * processes make the same locally-reasonable choice -- e.g. each one's
>> + * round-robin or recommended-engine logic lands on "the first XGMI 
>> peer I
>> + * ever talked to" -- they collide on one physical SDMA engine while 
>> sibling
>> + * engines sit completely idle, splitting that one engine's 
>> bandwidth across
>> + * every colliding process instead of spreading the traffic out.
>> + *
>> + * dqm->sdma_bitmap / xgmi_sdma_bitmap already record per-engine slot
>> + * occupancy across every process on this device. Reuse that existing,
>> + * cross-process-shared state with redirecting preferred oder: 
>> requested
>> + * engine not foreign-shared and still has room, a fully idle sibling,
>> + * a sibling used only by this process, the requested engine if it 
>> still
>> + * has room, then any sibling with room.
>> + */
>> +static uint32_t pick_sdma_engine(struct qcm_process_device *qpd, 
>> unsigned long *bitmap,
>> +                  uint32_t num_engines, uint32_t num_queues, bool 
>> is_xgmi,
>> +                  uint32_t requested_engine)
>> +{
>> +    uint32_t eng, busy, own, slots_per_engine = num_queues / 
>> num_engines;
>> +    bool requested_has_room;
>> +    int fallback_own_eng = -1, fallback_any_eng = -1;
>> +
>> +    busy = sdma_engine_busy_slots(bitmap, num_engines, num_queues, 
>> requested_engine);
>> +    if (busy == 0)
>> +        return requested_engine;
>> +
>> +    requested_has_room = busy < slots_per_engine;
>> +    own = sdma_engine_own_slots(qpd, num_engines, is_xgmi, 
>> requested_engine);
>> +    if (own >= busy && requested_has_room)
>> +        return requested_engine;
>> +
>> +    /*
>> +     * Single pass over sibling engines: return an idle one 
>> immediately.
>> +     * Otherwise remember the first sibling with room, split into a
>> +     * same-process-only candidate and a general one, so a fallback 
>> that
>> +     * is merely shared with ourselves outranks one shared with another
>> +     * process.
>> +     */
>> +    for (eng = 0; eng < num_engines; eng++) {
>> +        uint32_t eng_busy, eng_own;
>> +
>> +        if (eng == requested_engine)
>> +            continue;
>> +
>> +        eng_busy = sdma_engine_busy_slots(bitmap, num_engines, 
>> num_queues, eng);
>> +        if (eng_busy == 0)
>> +            return eng;
>> +        if (eng_busy >= slots_per_engine)
>> +            continue;
>> +
>> +        if (fallback_any_eng < 0)
>> +            fallback_any_eng = eng;
>> +
>> +        if (fallback_own_eng < 0) {
>> +            eng_own = sdma_engine_own_slots(qpd, num_engines, 
>> is_xgmi, eng);
>> +            if (eng_own >= eng_busy)
>> +                fallback_own_eng = eng;
>> +        }
>> +    }
>> +
>> +    if (fallback_own_eng >= 0)
>> +        return (uint32_t)fallback_own_eng;
>> +
>> +    if (requested_has_room)
>> +        return requested_engine;
>> +
>> +    return fallback_any_eng >= 0 ? (uint32_t)fallback_any_eng : 
>> requested_engine;
>> +}
>> +
>>   static int allocate_sdma_queue(struct device_queue_manager *dqm,
>> -                struct queue *q, const uint32_t *restore_sdma_id)
>> +                struct queue *q, struct qcm_process_device *qpd,
>> +                const uint32_t *restore_sdma_id)
>>   {
>>       struct device *dev = dqm->dev->adev->dev;
>>       int bit;
>> @@ -1995,7 +2113,9 @@ static int allocate_sdma_queue(struct 
>> device_queue_manager *dqm,
>>               kfd_get_num_xgmi_sdma_engines(dqm->dev);
>>       } else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) {
>>           int i, num_queues, num_engines, eng_offset = 0, start_engine;
>> +        uint32_t requested_engine;
>>           bool free_bit_found = false, is_xgmi = false;
>> +        unsigned long *engine_bitmap;
>>             if (q->properties.sdma_engine_id < 
>> kfd_get_num_sdma_engines(dqm->dev)) {
>>               num_queues = get_num_sdma_queues(dqm);
>> @@ -2008,16 +2128,29 @@ static int allocate_sdma_queue(struct 
>> device_queue_manager *dqm,
>>               q->properties.type = KFD_QUEUE_TYPE_SDMA_XGMI;
>>               is_xgmi = true;
>>           }
>> +        engine_bitmap = is_xgmi ? dqm->xgmi_sdma_bitmap : 
>> dqm->sdma_bitmap;
>> +
>> +        /*
>> +         * Treat the caller's engine id as a preference, not a mandate:
>> +         * redirect onto an idle sibling engine if the requested one is
>> +         * already shared by another queue. See pick_sdma_engine().
>> +         */
>> +        requested_engine = q->properties.sdma_engine_id - eng_offset;
>> +        start_engine = pick_sdma_engine(qpd, engine_bitmap, 
>> num_engines, num_queues,
>> +                        is_xgmi, requested_engine);
>> +        if (start_engine != requested_engine)
>> +            pr_debug("SDMA engine %u busy, redirecting queue to idle 
>> engine %u\n",
>> +                 requested_engine + eng_offset, start_engine + 
>> eng_offset);
>>             /* Scan available bit based on target engine ID. */
>> -        start_engine = q->properties.sdma_engine_id - eng_offset;
>>           for (i = start_engine; i < num_queues; i += num_engines) {
>>   -            if (!test_bit(i, is_xgmi ? dqm->xgmi_sdma_bitmap : 
>> dqm->sdma_bitmap))
>> +            if (!test_bit(i, engine_bitmap))
>>                   continue;
>>   -            clear_bit(i, is_xgmi ? dqm->xgmi_sdma_bitmap : 
>> dqm->sdma_bitmap);
>> +            clear_bit(i, engine_bitmap);
>>               q->sdma_id = i;
>> +            q->properties.sdma_engine_id = start_engine + eng_offset;
>>               q->properties.sdma_queue_id = q->sdma_id / num_engines;
>>               free_bit_found = true;
>>               break;
>> @@ -2392,7 +2525,7 @@ static int create_queue_cpsch(struct 
>> device_queue_manager *dqm, struct queue *q,
>>           q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI ||
>>           q->properties.type == KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) {
>>           dqm_lock(dqm);
>> -        retval = allocate_sdma_queue(dqm, q, qd ? &qd->sdma_id : NULL);
>> +        retval = allocate_sdma_queue(dqm, q, qpd, qd ? &qd->sdma_id 
>> : NULL);
>>           dqm_unlock(dqm);
>>           if (retval)
>>               goto out;
>

