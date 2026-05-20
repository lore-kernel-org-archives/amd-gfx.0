Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E49CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 10:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C06F910E616;
	Wed, 20 May 2026 10:26:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oNXxXdAv";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D76E10E616
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 10:26:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhmNjS2fCGiuNyJym9jiuJfY5bFR5/BWfoUaYVdxQDD/7l8rqerEZ9Uuyca4Gbkx1niva/YDPeQ4xvntexHyLN8vCH3j3l0YgbJqEM0JK8s0wYNznBAI5EgjU1EcfuXJA1w9VOMYhvyiv/Qrz3WYrpxpqzgzD9alaVL1u9VWDWq982V4MrEFJ9AZeBVC7PFEnXPdeunEOjKSJV/dx6Ry9vIfeU/YMC7xv6+xZ6iJflPVFOzx45+rMWSduP7Pb7SGle1QoiKAlTKwsofphnrVQUqFdTx5XQYJwzxinUB01ctiPnrzNJ+WI96YB1UNZhAvo6aapDdLgXMwWNZtbEOtWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpFo4G/b/W3sykLXhkeFZEcSycL1AAo4z9TMeYxcTGI=;
 b=JHIzUt2Y6o04igbHqHVB6MzH6WTY9Ilj7FGLG8GXI4LCQTcqQWbmQGnavBtCYpDpgTm1RRa+qZm+DxBJXsN6qvOJbUDb9LT+FBLX8hUI6Q5jwIN6zHMxrGNKuqq/uSZoj3NkBMfP6nYG9GMTDK26HBPANmFbGMiV4aJX61fGqIyIaQug35YrAKZ22vldPHinKCSIf/syl3Ca1qyNORa7AJn1U1VMikp98xAWLLul6iShNbcgST9MALk7Re+qNyFqmFksp8bS1aLZK1hRphkJvNWcv7WpTr76cXAdiG7dsTKDqyofO6abvyTOTgj53Oijn65SVdDz3bwv+S62SllnTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpFo4G/b/W3sykLXhkeFZEcSycL1AAo4z9TMeYxcTGI=;
 b=oNXxXdAvf+kV7NRoRzsAEnryU7stXWArbKAYblRD3k9Xrq6n0AChB7sgEa00sV9bQwbgQeUyPv8Lq35ASMO/106bS6+ZJ0pTQ+DRdqm0B7V5KRDTnZD6MEZKW/9YfqmEIv2hpIAKyEB/LTRTBgQ4OeiH24FpUtBqlU/S7UZYaSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 10:26:24 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 10:26:24 +0000
Message-ID: <01492831-10f1-4ac2-8850-bc87da9328b9@amd.com>
Date: Wed, 20 May 2026 15:56:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu/userq: clean amdgpu_userq_destroy_object
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260520025258.1866776-1-sunil.khatri@amd.com>
 <508fac40-c387-47fe-aab0-d9bfadaa670e@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <508fac40-c387-47fe-aab0-d9bfadaa670e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::9) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|DM3PR12MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: 45fadb5f-6772-4dfd-0cab-08deb65a3e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: qlKaYPT0mE6VK5K48b0ws5WdCemmnFoFA1nW9NV9oRWonr94fwu1cw1qjKFZ79KHq4u0EPJXPj0u3WmBnvCYR6a8CTOddooQ4T5WIb7u2XHUpEyWa4/setDDKnUAeaz5fqR71icDQCLTFyBuRJ23kYo4IyhJ27ABPIK2qjeXYVwzBs4FXXdS8OWebYZNp8PQzsd1MREfX7PHe9Y4n53VUqDlIeRL7V/ssMmILGw8ArUjXe4a/Cm+L+jRw2ZN9wKk45KNypjBXXhTZx27R+xgEnyvTOktykz70fqztpcth+Sakipxv+hZQoZyYG/fz0mL589gQqyKf37eL2a3bxrk2IJmQYWk/jDJUMp8pZuqnYxU9RsuO0ShgvqPnIM86mc7yiDy8KsO9N6UWjAO0q/zRyMPklfkqe7KHF5Kr73MDf4NZrox7zYq4n9I9FkaV4foqfgVtGC2eSLUVjUqAnyNwAXSEqMiG20P3gFhWVTAgTA41fH50SsPhvi9hgpG2a+I8n34QG3HSAvLmiS9XAw9/UA9+aMR7g2fU8hBW5mvIbbLeADxVq7MgUlk9sUjoRTnPa4vCAP756hnuLtu6b0gNOKCIQIEXoTElBUejnUlJaYtL+VhPWsflUl0Z26hkne9H0WuBd+dXE4FsSQHnGLyMp22YJBZYeQEtsSiRECq041IvYX/uKkX+fXUPa/8k7r7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEp0ODRIaytIYm1rR3Y5bFA1TGNXNmpkOXJWWDdDbVdoZ05LYjJ3Ry8zUWdH?=
 =?utf-8?B?UUpsRnROdno3QVRielQrdFNUMG8ySVRGanY4aUR1TnJDWURJUGJMRTFuK1Y4?=
 =?utf-8?B?bG5ERUl6RE9CQnZPeUMvRTBnbGgySmlSL0Q1WFpTdG9UMTdEdXQwc0RPNGhs?=
 =?utf-8?B?TG9MOGVoZDA3dnNOczlOWklyYmNjN29va2g0UzU0OUN5VERIT1o2NGYwcGc0?=
 =?utf-8?B?dVZ5UlkxcDNrelNkdUdadWtRWThuYk5kRDNFT2dHT0V3ZTdpSDZJL2FUbHNZ?=
 =?utf-8?B?T242K244S3VNbWVURWoySmRmKzBlQUI4QVBDSUVqTWhnZjhqb1hhSkMwMUxK?=
 =?utf-8?B?UHg1cnVSV2NEV0dPSHZzUHo3UkJ5M1A0c1EyU1NYM3gzaENQSlRxOXN1N3Rs?=
 =?utf-8?B?ZjVzbjU2WVhSV05LWnRZbE54M3lXNWZ2SnRnbU5FV3VYNmRNdUlLZWJ4RG96?=
 =?utf-8?B?QjcrYVdnSVFSc051TDZrbmtQM1BlK1NicTM3ejhTQWMwb09tSEMvWVhNQmly?=
 =?utf-8?B?TzRnK1NQNkREaHNoSTdGaG1NOXFyendUMFUxSVRXMmQ3MTVWZktXWFk4dGVB?=
 =?utf-8?B?VDZyYW1Jc29YcVNXNVNxSktZM29TR3piK28wZWRteUlqa2xIU3hGRUZIWW5u?=
 =?utf-8?B?WS91YmJ1SXNBTHgxdWJGQU9HTFlObW12UXluT2NvRHZIQ3EzaGxsUmZ4SlhG?=
 =?utf-8?B?UTRDVVVJVnJ1YlRLOGNqeWE0ZHAzL3NtSkJ0bDkwQVRjQmR1OWMybTQwQnNi?=
 =?utf-8?B?bUFxMGJna2wyeEVjWlQwOTJkTG54OVUxOHEveHkvUkU1UkNpS2dnNjRSUHd6?=
 =?utf-8?B?dUxFWVoyUWkxQVBqM0ttcUNSU0N0Zml0WGVJdzVQUkUwNlVWNkt6cEY2TmI2?=
 =?utf-8?B?b1BpU2w2d0NjeGZ1TlhCZ3dhOTBuY2lUbnkyajUrNHkvdGNyczlTbms2UkM3?=
 =?utf-8?B?Y1grVDZBSFVRaTVLSytsejJ3SUJhVGpXdlRtNTVmY3gyckNaMzhnb3U2Y2Jt?=
 =?utf-8?B?cEw2Z2ZpM0s1V2diZDUzbUZia2R0TzBmQzVWYmpmNTBkNFFYMTNLcW9XZDB1?=
 =?utf-8?B?ckZZc3paNzRQT2dQL2NQN0dWdzBETWNuc2VVSFErdnFFQ3RXTDRVam1QQXRX?=
 =?utf-8?B?UCtsemFQVGdPVmVKZnNVbjAzdVNOa1lpRVczZUxNSmZrUFZUSmpOQlpIeXFH?=
 =?utf-8?B?Nk53UjFuMUtMMlQzaUswU05wNXdrRXZ5cEJXWmhFU2ZZaUNSWmlZRG9nU0RD?=
 =?utf-8?B?eU92WUNhMGdMMGxoSFRENjVsYkhHOVNIUGRXSDJkOUdqc3g2Z2RSek5HQmlM?=
 =?utf-8?B?RENUYnozL1UzK25wUFFSR1FGVVlUNVdualVLeHEvWVl6clZIVUEwaUcyTHps?=
 =?utf-8?B?Q3luTkZucDladjNYdGVINnM2NnhTMUh5d0dySktlSEdxaUtCam9NblVOR0pj?=
 =?utf-8?B?WThUZms0NUduWEZ5azl5eWNrWVd4L0N6WmUyc1NMM1lCdlBMTzJoM1NNTUhv?=
 =?utf-8?B?NGtYYTNpZmtIMEp4cEFVd3poZ3A4RUFtRDUvYXpSczA0dzJZYkhpckZnVUZw?=
 =?utf-8?B?WFkxaU9PSFFrTkhkZnlDM3ByUXh0V0VEN09Wa2MxMmZHWmczRG1vcWtrLzNv?=
 =?utf-8?B?bnZmQ3VmbGpXSDREWll6WU1MTUdBSFBrZG1QdzNYUmRFc0QwREFLR3k5UUdS?=
 =?utf-8?B?WURQaWRyRXNtWkgvRzdrTTllU0dZWDZxRHBzd1ZKeUVHR1hWNE9wQlRlaWZP?=
 =?utf-8?B?RHNZRU43K0laelVocVZiYWlPUFB3NUdOR2podU5kYitLN0RWYWVaODRLcXUy?=
 =?utf-8?B?bkFSbmdHUFJqbHMwT1AzcW8zTHpvUWxHR1k3S3NRaTlYMXZPMmtwVEdlc2d1?=
 =?utf-8?B?a0o4ekplRTRENUxJN2xMOHROUEsxazduV1JIS2VmN3loYXZJbitmTWkxV01N?=
 =?utf-8?B?OHJVWjhaZjNTTzIxb2pMTnFJM3BIcFRMSFJyVi9nQ3ZVSlc1NDBMNzBhTklw?=
 =?utf-8?B?OWFxeU9ISDNvQTRyTGtlc3RsUDd5WUI0a0dudDFsc1Fsc1cwZlo4d3ExZ0cr?=
 =?utf-8?B?RVpvaE1SQVE1TlN5QnFBWTlUbXFTb2h3bjRHS1BOVkZudTNtVG9hUHVpTGlW?=
 =?utf-8?B?NEhJL2pGQmxUeThrM3Nad2VOTWJ0c0JiYUthZDRwV1dCT0hscWNsZEpEbDg5?=
 =?utf-8?B?dE1tTXVDMEt5OFMvYmd3emxocUxkUjMxUTdHTE5zQzU4YjhVOVVTc3plakxj?=
 =?utf-8?B?WncvM2pzUEQ1TVkwR1VUNndnOERlcU94VnRBaCs0SUhMMFFTQmtzWlJ1VkE2?=
 =?utf-8?B?MW9TYUJ3bThwVmpFSlhQcnhWWGpzam1tQ1pmTDlhdzZTOERPM09Sdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45fadb5f-6772-4dfd-0cab-08deb65a3e40
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 10:26:24.3815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JOcd0iyb0mBn69hYitjNvAHBXgg7kgH3IVz9Y4OzZ+jSlHWiz4G+evS7md2YEr8wpHFmFTJGqwJj+9+ItRfHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391
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


On 20-05-2026 02:25 pm, Christian König wrote:
> On 5/20/26 04:52, Sunil Khatri wrote:
>> amdgpu_userq_destroy_object does not use userq_mgr
>> reference and hence cleaning that up.
> As far as I can see the whole amdgpu_userq_create_object() and amdgpu_userq_destroy_object() functions do the exact same thing as amdgpu_bo_create_kernel() and amdgpu_bo_free_kernel().
>
> So it looks like the two functions are completely superflous to begin with.
>
> Regards,
> Christian.

Sure let me have a loot at them and rework accordingly.

Regards
Sunil khatri

>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  3 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 +--
>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 10 ++++------
>>   3 files changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 798998d65e17..0607b7078518 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -526,8 +526,7 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
>>   	return r;
>>   }
>>   
>> -void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
>> -				 struct amdgpu_userq_obj *userq_obj)
>> +void amdgpu_userq_destroy_object(struct amdgpu_userq_obj *userq_obj)
>>   {
>>   	amdgpu_bo_kunmap(userq_obj->obj);
>>   	amdgpu_bo_unpin(userq_obj->obj);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> index 033b8a0de6b1..fe89e35b0d85 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> @@ -155,8 +155,7 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
>>   			       struct amdgpu_userq_obj *userq_obj,
>>   			       int size);
>>   
>> -void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
>> -				 struct amdgpu_userq_obj *userq_obj);
>> +void amdgpu_userq_destroy_object(struct amdgpu_userq_obj *userq_obj);
>>   
>>   void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> index 2d95203ec58e..69b36ebfe7ac 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> @@ -432,10 +432,10 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>   	return 0;
>>   
>>   free_ctx:
>> -	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
>> +	amdgpu_userq_destroy_object(&queue->fw_obj);
>>   
>>   free_mqd:
>> -	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
>> +	amdgpu_userq_destroy_object(&queue->mqd);
>>   
>>   free_props:
>>   	kfree(userq_props);
>> @@ -445,11 +445,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>>   
>>   static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
>>   {
>> -	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>> -
>> -	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
>> +	amdgpu_userq_destroy_object(&queue->fw_obj);
>>   	kfree(queue->userq_prop);
>> -	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
>> +	amdgpu_userq_destroy_object(&queue->mqd);
>>   }
>>   
>>   static int mes_userq_preempt(struct amdgpu_usermode_queue *queue)
