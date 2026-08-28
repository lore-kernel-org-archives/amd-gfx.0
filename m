Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DE3C61DDF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 15:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A9110F40C;
	Fri, 28 Aug 2026 15:59:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ezKqsmtu";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013020.outbound.protection.outlook.com
 [40.107.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A41F410F40B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 15:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UA/ULOeJFKJFDuvYUiYTAVgyDTL06U9Qy/zR/pTL9OFHm9p3E6kTjl307M8ST7N7mtdKOWxHV5SjkSQAKaNllMWNoM0imOFZfMnBrxVEJGGfsP25TCabmBUzKgiq3qIaT0b/KKopM2AhxZ7sgHlkoU6GJdkUXvI6IrZkUvxZXmP6gfR7nUbef2SnPh6pgh6a5SQXx36HjJEwK1yujJhu0A1L6zXbB5yEB7PpSEJ+tfA5i+2fK0FxHxWDClLCdxaoa43vIZhlSZeN5iosWCFHdSlDC1TcinTyXwHQwo8L6eQnq31WLeeQvyhwmneP+3fJWrBGHIpJf7lv0h6qzARSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZcsRuLLmvzQvWHR/FV1hHUFnvei3FEiXembWxPdhJY=;
 b=ecbNckhsK2n3VwO2DQxu7octDCeu2USf3nfXMTiJzU+Gsd/5GJVBp9c0Bvv3TSKPAbGaRZ9T3J2BLsTcWlHkp6kMNuA4yvRuH+RaAx/tvA69qbkXASAdlPDiVaHPpilFToaslm3hhz3reoi5pzLAAnox2YOZVYZ/F2PiyRR/amHXr0+81olL2bzL91MdhRAdVY9NfNnLKDMmWesA/eMnQl5kkdC1NKdeXyIjSNIbw3CgnHhbLuFZa1HGSLIhEBJOMMUbh2H1Tmyf+yzYCaEuwBpXFOSLzxMI5Rfbkpi/v+NVLcv9YClhu2P5/vFOAE6Cl3sqMX5y1ODJ/xp/ghYn1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZcsRuLLmvzQvWHR/FV1hHUFnvei3FEiXembWxPdhJY=;
 b=ezKqsmtuWqolyjLxQr6SG56hHHQ5TyMKZj9iw8y7pSfsuNyrBHrmPFGAEnOKGABUsohFYcAdzBdFY7ldPzTAe+CTI2/27DIv3GOKXJmrN7UTzLRvdkAJJnzH/fTaS0myyJ3svvsRMlJYQyXN8Ph/6GZcufTzY1rgm9rMGzv3AVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:59:52 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:59:52 +0000
Content-Type: multipart/alternative;
 boundary="------------g0MSvXvxWPwyzblItzFPgsDf"
Message-ID: <2687ad99-61da-457f-9705-766bf48b2d04@amd.com>
Date: Fri, 28 Aug 2026 23:59:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] drm/amdgpu: introduce
 amdgpu_lookup_queue_by_doorbell
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexander.Deucher@amd.com, felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
 <20260828095349.9797-2-lingshan.zhu@amd.com>
 <bd072438-32ee-42bc-bc06-ae29775cc2a5@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <bd072438-32ee-42bc-bc06-ae29775cc2a5@amd.com>
X-ClientProxiedBy: TPYP295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::14) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 901a296a-53f9-4ced-eb24-08df051d653e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006|8096899003;
X-Microsoft-Antispam-Message-Info: rSQDStV5+3bwf2LhEwmivmoiThYMfHlYBZyfB9bpABrtgujzCsjtzL2y+eMWOaDRGs88dj+fjR2qGrtVULHJX92zPWZHcRhxsjd/Hta2NYa2zVWjIiJH2vXVc7RsRTQP2ygRLsLDul3AfhTR0+ZUhpnooLVW5N0PHfMZDDcXX9OH7M8W9GUp8Qn0FXSmDD+rHIUMltbwqnC2Lxj/m/nRofJZRetjHZFOiV46bhN9cSSpFYya38WGYhRRNmIlQb/Ar0/b5QECHCnMsZ4oS+sMCLMcZNmXcIQJ8rfk5XrnIHkGOA7zaGs29LcW8NARgI8/j5LPJ67xLj4RGAfI00Ad8W1MldZScmnZBrGdVdlzAx1zTG8fVdSM02cWPsuMKiIo20itFv0ZkvyWL5UqVHof72E5IiBHpDyfn+bIFdfQfgNFfZDcRQjNNle1AcDPcUUJUsZGT6ta9hNPWbkjLJlMvNbKNj8gKC5rqp2fFFAXA2K7jOIQVQv6vkBO7S/bnfuzC0bCn+p0afusraNHG84JFkCYkyzp5HZPy7pQCS6ZcG49R9lX4Q6dqj9jxPdsFU5YH6RRtF1Rjhz3ft4zSUQwibM0U27S+TEDVs6sZ4himB8wYq54/X1N9wpicXScUdiOWsnXpaBUBQ0mQCN9hdF962KhmRY+JnyKDULiQgBhUZQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzV3K21XYlJGUHJncTZqZDBGL0o5THlHTFdRRDgvRFQzSXhwYVZ6S1hCaXhU?=
 =?utf-8?B?Yzc3NDJ2c3EvYXgwTDQ2RTJOb3AzSHhidHptcFlHa3hmV3dNQWNqUDBSV2Y0?=
 =?utf-8?B?alJLSzB4Z29uVHFpcWkvN3U5MWdsK2ZmcEY0S0owdnF6QTZmTmFKLzZ3NVVz?=
 =?utf-8?B?TlNxTzZPd1FSVG5mdXo3b3IvckZJQWdvR2QzOU9QUlNqTFhxUkVUaUsyV1ht?=
 =?utf-8?B?REFSLzRaRGhpSzNBVXFJaVdaYTUrdEYzM2hQbXBzYUVlNGJQcS9zZHNwMUg2?=
 =?utf-8?B?d0Jac2ljZ0dDNEhjMXJ5WG1YV2JzZmpqamxKMWZMUkw4M05iQUNRSi9LaFYr?=
 =?utf-8?B?d1JmcXNQMTNwQm94ZC9NUVdQNERsVE9JRGNwdjF1bGFWSTFSLzZtUUxyN1Rl?=
 =?utf-8?B?bndFbGFPVXhJb3dXVWVReGp0WFNtWmp4blVUN0lrcW9HVkJyS3FBclF6am14?=
 =?utf-8?B?MXZXbDZjOTJvRjVldW5kMVhuRllRM0o5NXJJaXFUN3RHU2NZeGlMMG9VRHR2?=
 =?utf-8?B?SnRhWXE4U3gxZFVxZ3VBK0dKSkZIcnFDVUhDMk1SMC9OdGZhT3BWYUtiRSto?=
 =?utf-8?B?K0d4UXBvRkZEOGZaeVZrUjNhdFJZQ0tCRy9jZmJFWWRRMHBPTmowTTI4VXV6?=
 =?utf-8?B?bDJraStiQ2MvRE9GQzZMWFZxWnBYM0xBTndrNlRNaG9ER2pJQzQwbHRzQ2lN?=
 =?utf-8?B?YVBCMUJKbTRoQzcwbW9vUEZzZEd0Yk43cklTUjk5WGhTQTdsekF4azY5K0ta?=
 =?utf-8?B?UjJibDVJV2k4aWpPQmE0cTdNeEx5UGtXMndHR2w4Q0RGOTlXdkQrWCswK01Q?=
 =?utf-8?B?cmt2QzA0Q1ZDOHIvb1VLWDNuNzlVemZkWE55L1Q5WFhxYTFDMDd0MzEvNjBk?=
 =?utf-8?B?dVByb1dxU3VpK281MUZBblQ5andHYkw5RnFNemtraklZdjVGSm55YlpRMWpu?=
 =?utf-8?B?NjIycWNHaDdCT2pPZHFzeHh4R2Frb1ZCSUcrQktMZ2FQd1Eva2twTGZJb0Mv?=
 =?utf-8?B?bk9ad2NjcjBXdEQ2SE9SUmt2YUw2S2laMmdaVjNSTTJ6YkdNdTRDZTE1NlY0?=
 =?utf-8?B?dkJYNjIzQUlUalVCRnBjUm1NYXpWbzdtUFFMOFRYL0x2di96K2pVdkQ3eUUy?=
 =?utf-8?B?OVVKRys5dGdmeFFlWksxVldCaExXZCtFRHBvODgraHQ0YTJ0VU5zNzRVTGQy?=
 =?utf-8?B?a05rSmRtSGFLNGJDSDREM1ZuL3JyelpHSCtBVlp2ZlZIeGhWT29QaVFGTUpX?=
 =?utf-8?B?TWFlQmE3djFHRmhiV3JTYmxodk1QOWRENEJqaVJvcjEyTlNwUlRwWGMxV25u?=
 =?utf-8?B?TVJ4QU41T0MwcWowM05lSzErQnpyc2xaZ1I3cGFPREgrbkNjOTJwYnZmK2cv?=
 =?utf-8?B?QU81NEFSVHBYT1ZYY01Na21XYjdmMDNtMmFYSS9RWjBVUnR3MmJqWSsxUXZY?=
 =?utf-8?B?c2NkVEluVnhHcGszdm1tL093a1RHQmNpWjZOZG11UnplblJKVUZaZGFnMlNT?=
 =?utf-8?B?VzlEclB6dWFPclZkK094aCtlVlIxT3d6TndYNURHWUxLbExaSytMMjMyL01v?=
 =?utf-8?B?b2Fha3p1bWd0RTJyc1AycTgyL0pHbWNpZHBUV0dMcEZ4Zm1seElhRGtvcW52?=
 =?utf-8?B?NWxzbmRKZytaQk8yelllMTJ2MVhsTFhXVW9Cd0xvcUxmOWZvUkcraGJGUVlo?=
 =?utf-8?B?M2VIaG1qV0YzUVpKM0FrVWFCVisxSXMzQVo4R0VSalA0S0NvTncydEJxV0Fx?=
 =?utf-8?B?dElKNWNDbFZtazdUL2RtaHZsRnprMU9PZmZ5K2dTNXV3aHptOTB1WTNiamxp?=
 =?utf-8?B?b1dVQVAyUmd4WCs2bzV6YldVYmlacU9lb2t5MHNrdVpianVpTTBGMmtHNXZN?=
 =?utf-8?B?cWJ5L0hrcC9mZmlRRWVvV044VytZNG5RbmZUeWxaWTdLS1hTbHhPTmhub1p1?=
 =?utf-8?B?TmFrMFp6bkwzRmdLdjF6RDFmVmxQV0huMmovK1BXVHlRb0hTaC9MaWkyQlJE?=
 =?utf-8?B?cmxzanl3S3NlWUc3Ym5VbGxCRnA0N3huUmpYb0tDTVYyODJ4R2VGWmFRMW93?=
 =?utf-8?B?bTlid0pBS1o4dHQzbnBreHdwSlRpVnhFYzcwWDEwUGg2anRLUDl4RXNCZi84?=
 =?utf-8?B?RmJOUDNUWW9MUURDN0JPMnpJS0p2WjUxTmpGUTRKOGhDQXd3OHF2R0JiZHdP?=
 =?utf-8?B?QVIyTWIrNmRTbUNWU2dLcUVZTzd0QVZKOFFaQVFNU3dhbFRBWU00eHF2WkxY?=
 =?utf-8?B?TVNVVk5FcTdHUmFBODJvSEpVY2VBck05QytnTXFZQ2hCYjArMlQwclVwS01S?=
 =?utf-8?Q?XgzOG1N0DgxvIQ58Tn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901a296a-53f9-4ced-eb24-08df051d653e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:59:52.2152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pj2aAiddoRkp2NxAfY/xxh3903+rguY5YrUmCyzvs/u30aoRzqji+UD9cT/JPqz06kYBMQy5ko1t33GEz7Z30w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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

--------------g0MSvXvxWPwyzblItzFPgsDf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/28/2026 9:08 PM, Christian König wrote:

> On 8/28/26 11:53, Zhu Lingshan wrote:
>> This commit introduces a new helper
>> amdgpu_lookup_queue_by_doorbell which helps
>> look up a user queue with the given doorbell id
>> in a xarray.
>>
>> This function takes a kref of the user space queue.

Hello Christian

Thanks for your comments.

> Well absolutely clear NAK to the whole approach.
>
> This is the nonsense Sunil and I have worked quite hard to remove and we certainly shouldn't repeat such mistakes.
>
> When the userq needs to be used from interrupt context we need to hold the xa_lock_irqsave() or otherwise we don't have any guarantee that the userq, userq_mgr or associated fpriv went out of scope.

Holding the spin lock by xa_lock_irqsave() can surely avoid racing with the destruction process, however, it does not apply to all scenarios, for example, you can not hold spin lock in mes_userq_reset_queue(),
because it calls either amdgpu_mes_reset_queue_mmio or amdgpu_mes_reset_queue_mmio, both of them acquire the MES mutex through amdgpu_mes_lock.

Another thing, out of the topic is, holding xa_lock does not guarantee fpriv/userq_mgr alive, for example, when drm_device->unplugged is true, all amdgpu teardown paths in amdgpu_drm_release are skipped,
and the fpriv/userq_mgr is freed, no matter whether holding the xa spin lock.

So IMHO since we have userq->kref, lets use it to maintain the lifecycle of the queues. 

>
> Grabbing references from this side would obviously result in circle dependencies.

I am not sure, we should use the lock/unlock and kref_put/get in pairs in sequence, can you name some circle dependencies or AB-BA lockings as examples?

Thanks
Lingshan

>
> Regards,
> Christian.
>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
>>  2 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 0a816b3c5ff9..e0639f844a8e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -609,6 +609,36 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
>>  	return queue;
>>  }
>>  
>> +/**
>> + * amdgpu_lookup_queue_by_doorbell - look up a user queue by doorbell
>> + * @xa: user queue XArray indexed by doorbell
>> + * @doorbell: doorbell index
>> + *
>> + * Return: A queue with the doorbell indexed, or NULL if no such a queue found.
>> + *
>> + * This function increases kref of the queue, the caller
>> + * must release the reference with amdgpu_userq_put().
>> + */
>> +struct amdgpu_usermode_queue *
>> +amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell)
>> +{
>> +	struct amdgpu_usermode_queue *queue;
>> +	unsigned long flags;
>> +
>> +	xa_lock_irqsave(xa, flags);
>> +	queue = xa_load(xa, doorbell);
>> +	if (!queue)
>> +		goto out_unlock;
>> +
>> +	if (!kref_get_unless_zero(&queue->refcount))
>> +		queue = NULL;
>> +
>> +out_unlock:
>> +	xa_unlock_irqrestore(xa, flags);
>> +
>> +	return queue;
>> +}
>> +
>>  void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
>>  {
>>  	if (queue)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> index 6412a7f7b6ef..8fc73862f64e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> @@ -151,6 +151,8 @@ struct amdgpu_db_info {
>>  };
>>  
>>  struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
>> +struct amdgpu_usermode_queue *
>> +amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell);
>>  void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
>>  
>>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
--------------g0MSvXvxWPwyzblItzFPgsDf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 8/28/2026 9:08 PM, Christian König wrote:</pre>
    <blockquote type="cite" cite="mid:bd072438-32ee-42bc-bc06-ae29775cc2a5@amd.com">
      <pre wrap="" class="moz-quote-pre">On 8/28/26 11:53, Zhu Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">This commit introduces a new helper
amdgpu_lookup_queue_by_doorbell which helps
look up a user queue with the given doorbell id
in a xarray.

This function takes a kref of the user space queue.
</pre>
      </blockquote>
    </blockquote>
    <pre>Hello Christian

Thanks for your comments.</pre>
    <blockquote type="cite" cite="mid:bd072438-32ee-42bc-bc06-ae29775cc2a5@amd.com">
      <pre wrap="" class="moz-quote-pre">
Well absolutely clear NAK to the whole approach.

This is the nonsense Sunil and I have worked quite hard to remove and we certainly shouldn't repeat such mistakes.

When the userq needs to be used from interrupt context we need to hold the xa_lock_irqsave() or otherwise we don't have any guarantee that the userq, userq_mgr or associated fpriv went out of scope.</pre>
    </blockquote>
    <pre>Holding the spin lock by xa_lock_irqsave() can surely avoid racing with the destruction process, however, it does not apply to all scenarios, for example, you can not hold spin lock in mes_userq_reset_queue(),
because it calls either amdgpu_mes_reset_queue_mmio or amdgpu_mes_reset_queue_mmio, both of them acquire the MES mutex through amdgpu_mes_lock.

Another thing, out of the topic is, holding xa_lock does not guarantee fpriv/userq_mgr alive, for example, when drm_device-&gt;unplugged is true, all amdgpu teardown paths in amdgpu_drm_release are skipped,
and the fpriv/userq_mgr is freed, no matter whether holding the xa spin lock.

So IMHO since we have userq-&gt;kref, lets use it to maintain the lifecycle of the queues. </pre>
    <blockquote type="cite" cite="mid:bd072438-32ee-42bc-bc06-ae29775cc2a5@amd.com">
      <pre wrap="" class="moz-quote-pre">

Grabbing references from this side would obviously result in circle dependencies.</pre>
    </blockquote>
    <pre>I am not sure, we should use the lock/unlock and kref_put/get in pairs in sequence, can you name some circle dependencies or AB-BA lockings as examples?

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:bd072438-32ee-42bc-bc06-ae29775cc2a5@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0a816b3c5ff9..e0639f844a8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -609,6 +609,36 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
 	return queue;
 }
 
+/**
+ * amdgpu_lookup_queue_by_doorbell - look up a user queue by doorbell
+ * @xa: user queue XArray indexed by doorbell
+ * @doorbell: doorbell index
+ *
+ * Return: A queue with the doorbell indexed, or NULL if no such a queue found.
+ *
+ * This function increases kref of the queue, the caller
+ * must release the reference with amdgpu_userq_put().
+ */
+struct amdgpu_usermode_queue *
+amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell)
+{
+	struct amdgpu_usermode_queue *queue;
+	unsigned long flags;
+
+	xa_lock_irqsave(xa, flags);
+	queue = xa_load(xa, doorbell);
+	if (!queue)
+		goto out_unlock;
+
+	if (!kref_get_unless_zero(&amp;queue-&gt;refcount))
+		queue = NULL;
+
+out_unlock:
+	xa_unlock_irqrestore(xa, flags);
+
+	return queue;
+}
+
 void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
 {
 	if (queue)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 6412a7f7b6ef..8fc73862f64e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -151,6 +151,8 @@ struct amdgpu_db_info {
 };
 
 struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
+struct amdgpu_usermode_queue *
+amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell);
 void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
 
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------g0MSvXvxWPwyzblItzFPgsDf--
