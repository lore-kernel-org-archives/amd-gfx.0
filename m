Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96923C61DD6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 08:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16ED710E334;
	Tue,  1 Sep 2026 08:50:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G2fGT1K3";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011023.outbound.protection.outlook.com
 [40.93.194.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5854710E334
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 08:50:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EseCmId8WNM+Q7M4oFFk4UAu5R0YNgFjvVpFkzv0kIWwqDI1tinLjnhCwHVHjO7f5RSvByqwTW2ZcXZnfmtXH9vLSB6iuN6XJ2UOuhHlmPKiHJK9qjrohgbmq58Ht/SNw2svQ7dr+EO6SxrOEEa3gCYasCYJvRpyVv4e7XYC3obY/pAij5vYZXE+/XG1XIwKzYKwpyso1i+0ND5smup8r/X6BIPDzclGgLq4SQfK9fJMk4IbE8/Yjwl2094dN5F0uO/x7NsO4pFrurW2AWn9KkalJdIOqzuDtnn7Vym/DJH4YCS4no53IcBUdB+inPF7fMbd+8eGl0nJ4EIGNvoZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbPKB677JVXhzkDIjsDPJaUbUQbdPaYSIIIBL1itzt8=;
 b=Kz3bbBu6wiDijoCjSn2xqTCPyHi1gtO8eW11FngXhSbWJVW4B9Kbv1geYccBxyuxfY3qLry8uyKfpSU9N/zggD4VyvmamjvK6Vxi5GvYNmIsF5oa+0EVmPH1CYZV7DR1gRzvRaCHwlEYWY377PDk1VdJwxZNqhKt11Tm5yvXTmWtiMHzVfYbInlL63i8+kWB8Fla9934Qby6JKbkquDzoGvYEUT82pG0N4XSJYZchVIu2aaFaL7Iu31Lhfa7209JerJwRQOL66FuRGpsczpcT+VhbGH1d1i8ZqF2KN67lkBBLPp910ClF8hSc77naotuuA2ViLIl4SrkOI4kjc7B3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbPKB677JVXhzkDIjsDPJaUbUQbdPaYSIIIBL1itzt8=;
 b=G2fGT1K3A/IAc7JCf1RmypMTINbkBb4iRnoaCJzn2GRj4i+OXLTWvTahfPfCeHsrFpcVn7FVZ/1HJlXtRpU9xTNBG1NDYdtCWUMMekXb2qBusREM7dS/ZaLyZcfsEGJRrSusm/z4ACUfwroHN+wvMdj753JJRVCs//eNlkx+Z7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by DS4PR12MB9658.namprd12.prod.outlook.com (2603:10b6:8:280::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:50:52 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:50:52 +0000
Content-Type: multipart/alternative;
 boundary="------------YdCQXltHVqs7tvGsUkJKHS17"
Message-ID: <a34a1541-7f3a-4e0f-a225-f58b1292d6d2@amd.com>
Date: Tue, 1 Sep 2026 16:50:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] drm/amdgpu: introduce
 amdgpu_lookup_queue_by_doorbell
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexander.Deucher@amd.com, felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
 <20260828095349.9797-2-lingshan.zhu@amd.com>
 <bd072438-32ee-42bc-bc06-ae29775cc2a5@amd.com>
 <2687ad99-61da-457f-9705-766bf48b2d04@amd.com>
 <a46a12b8-d9df-4995-beaf-6d41150196bc@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <a46a12b8-d9df-4995-beaf-6d41150196bc@amd.com>
X-ClientProxiedBy: TPYP295CA0002.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::11) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|DS4PR12MB9658:EE_
X-MS-Office365-Filtering-Correlation-Id: af84230d-1a7e-4d70-8efb-08df08062078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|22082099003|18002099003|8096899003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: xdQb/dvlm5oznH1jjfO6iaN7bEaZvk4NF44GnEoJwroLP8Vh43A3nyLSpku/LJoxJitd/aqZ023hwm+F5xjfkJp4vs84wzdZ3GSE/71x/7KwbjrgrTsr8oer7HNmrn0WLnh79fkyA348Bz+OXBenaKZ1LydfGP2jdpycu+xlKVGjRaDi1F7238BCp/90rPTyUSCYotmYpkrqxN3pbZKa3AlGL1weVpDPemj24WjjlR0wGMiY6K4BJyi81Auk5ZW2eiVRno0FUCNorw2TZXhiGaIFx6bXRzYrqdJJXOaUJhVyon6B9p7q7sGiIrZiABG3MmGZc+VGRyuc2EsOzcMU9eT8eaheFIadoTsQX7L8z+BL3UdILooPYmg6pvarP77N2Oc9JFeGy3U8gc/WnPPKu4stF9qejw0e3N7xQZcaNXZs2VRx0YxBScihf+0qcJTuVgjbAhbarDoQL5DuaLC4HhYS2RSIopSCsOL3SjHX61sMBOPV02KnL/CZ0cdR2VaOSK9rlmLnctJwWCQQJeOfMN8L0YV/c9a0nW5K7myAlBohc6WZNVAR6tHLPTt2GASiwn4wpOxSRvg7qCMhSfPLsa2On8yz6DcgF0Q/rK3o6Xh9rKqch7XnGnpglfBuTQL1+6j11C85ZbNkxLmiAh5NDIpOMcexXU5XMv457pQNFoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(8096899003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFNWdHJHYVRiSzdIa0JlT1paekRvbUh0cXVGOHpBQisyakNoM1h4Njl0Mm0z?=
 =?utf-8?B?a0dwODVOcTM1bEVEenVtSGlCY0wrSEE4UDdwWjFWUHZHM2xCbVk5bnN5UnRr?=
 =?utf-8?B?dlczb2hkVHJZOTFEc1o2anhSN05aWWVraklNWm14ZU0zU0pWTE9xZ2FoT21F?=
 =?utf-8?B?SnRPMVcxRkJLaDZEaktYbFZVbGZTbW5BVzFud3Q3R3ZhU1V4QndyandPNDIw?=
 =?utf-8?B?QXE5M2Z0VldnRVp1VTRUL2xqVERPTWRDTm55YzBtaDRLL1pXOWlUb09FWGlw?=
 =?utf-8?B?OWp4cFdBS1JKQ3AvMjJQeFQvbGgzdXEwQVZOUkpkMU1VZ0U4cm43Zjk3MDVF?=
 =?utf-8?B?aWs4WjVGM2svVWsvY3VLOWZVWjB1MU5lOVBHMFhlY25la0JHNjN4anVJc2Zt?=
 =?utf-8?B?bm00RTJQeDZxLzVHTk9wWUEzTkUwaUk3WnU3YmNXSWhEQS85NGt6VHFwSmFu?=
 =?utf-8?B?Skk4VUloQnpnUGJMN3hnQmI1RHhVVk55a2s0blhWVkk3Yk5QN1hMbmNXcWNi?=
 =?utf-8?B?dk14YXZWTTE4Q09DMWNUclo4SEF3TlJQbHZka0JITFdRZmZma081Q0ZRSnhy?=
 =?utf-8?B?NFZPNjRpa0FacHNsb1hISGk5RXpodjRFc3orRXZQajFqMXE1eXkzbG14NUtr?=
 =?utf-8?B?MXBpaVU4cHR2WFgwUGM5cnNDaVF4K0RlT3RvU0RYaDQ0UGVSMVNrNnplVThQ?=
 =?utf-8?B?eiswc0NaN2J1SmZxamU3VkEyaDJwZUl2U252b3hoU0dJN3F2UUEwNWZ5TWQz?=
 =?utf-8?B?Wm1CTno0SkJZcklkVnczZnJUanVvZmF3MUFjRSt3d004aTREOHRpVExSSnNj?=
 =?utf-8?B?b3oyWXNTWlpWQVcrZHZ0KzhDZ294RHpDOHJibnhtWXFNUXk5TVVwdEZObkF2?=
 =?utf-8?B?cEpETnpwS0VqUnErMGNiR0JlVFR2bHh6a3JtSHVtV2tLOVBheFFOWjU3Y1E1?=
 =?utf-8?B?MWtURktJa0RLVzkzWitmY1dyRGk5QkkzWEUwMS9aVFNuNWRUSlhFaDhNNFN6?=
 =?utf-8?B?Y252RTR3Vnd3MittTzdHT0lyQktoMUs0VlM0ZWt3dHpJZUFRN05LVzBlODc5?=
 =?utf-8?B?dVZlUnhGWW0vM0txN2lNSWlLNExGZDBleE1MUW8yZldvWDlWK254ak1VYUdX?=
 =?utf-8?B?ZlFCb0RMM2tsa2pScDZvYnB2dG5KNHlQVkFSelFjTWFPVEppZlg1MHVKSFFH?=
 =?utf-8?B?SnB6dGY5UVVLQzhHSEtqQTlpc0dnS3lqdDI5cDY4ZFhhLzR5SzVrTEdWL1NC?=
 =?utf-8?B?Vnl6eWpZQkt6MHZCaE1qaWxpQWppYlJLa2F4UmZidWNiVFpGZEN6ZEZQQzhE?=
 =?utf-8?B?OG9oUTdWN1dCeGRhdmkrM05JY1k1dEZXL3BRTjQwWnNYcW5Jald2WTRtOWQ1?=
 =?utf-8?B?Uk1iSDR6VVljdGY1VDZEZldtQjJ2SS91MDFXVXZGUng4Ym9CYVk1b2MyQjZv?=
 =?utf-8?B?WXRTbzNCUWJueFRGUGZpd2luMTV1Q0syTElFM2JrNXp5KzVObjgxQmZDcG4x?=
 =?utf-8?B?ZDBaeHZRSkl0Z1hTYUQyZ3RncURrL0VMa1hnWi9JMitXU0QrOFNaTndxVVJL?=
 =?utf-8?B?REpOYWxFd2FzaWVBVnlRRWt5dFpmeFhpL3o5c21MSVhkZDJjanhBLzF6Z1ly?=
 =?utf-8?B?VVpUMEhqekZhck1WS0RrMWRZTkJvNHprMnRhMjBBemlHaWxkVlVQMjhaSk83?=
 =?utf-8?B?Qmd5UzV4elVObzRKSXFac1Ewank0N0ZrV3NKNW45ZTNBN2c0d1cvNGttOHlT?=
 =?utf-8?B?dk5rd1NKTjV4WnJyZk55bEFTcnZ6c1RGY08vVC8rcVowRlh3NFUzd2x2d2kr?=
 =?utf-8?B?UlNVK0g1SVMvaU8yRGNKZDdmNDUrcHBVRk5HSnI5WlRuM1FSZXFGN3FRdkhM?=
 =?utf-8?B?ekFCR0s2VjZxOVZjQ21iR3NxUHl5d2t5R0ZWOVN0WjdNY1crdXY4WGhuNDJ6?=
 =?utf-8?B?THgwTmxYL0tzL0l3K2JqN1g3UkpzRnB5RXhxQzdSV0VpNVd4SytLKzJWSjFt?=
 =?utf-8?B?VFJyQTUvbEFsNm1jYTF1ZmFKRFhUTjM2K0N6THlTaGNnRFFGTVppUm1tanVa?=
 =?utf-8?B?aVllQTREeng3WWRQb2JnZUVGSEVQcjJxQ0ZvcDZDajA1N0t2dzhqcHMyQUVF?=
 =?utf-8?B?Z1hhYXU5N1NyNUoxcFNVR1VXSHNtOXBibWZoM01EUDVTcGVtbXdieVJYWGda?=
 =?utf-8?B?U1QzMjZnVDRFZFQvcFZrSlk5ZUYremJ3andLa2M0RWVjcFlRakRlV2JZbUpi?=
 =?utf-8?B?UXp1SW95QVNoV1dJenJxNUNKSkRPTWg1YUtxUm8xMWFXTjQvU0szT3F4YkhU?=
 =?utf-8?B?b1ArUGs2enNzRzY3NndzUkNzTGU5UFF1aVQ1Q1RGekhzUjljc0JGUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af84230d-1a7e-4d70-8efb-08df08062078
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 08:50:51.8917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGHxve6ogOXtHTU0uR5uHZQX59mnmfwcHl5MjiuiaKGwVN+1/nw+3PLuMyW/1duzES+vgl0m7n8W+Rd3uAq3Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9658
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

--------------YdCQXltHVqs7tvGsUkJKHS17
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/31/2026 4:21 PM, Christian König wrote:

> On 8/28/26 17:59, Zhu, Lingshan wrote:
>> On 8/28/2026 9:08 PM, Christian König wrote:
>>
>>> On 8/28/26 11:53, Zhu Lingshan wrote:
>>>> This commit introduces a new helper
>>>> amdgpu_lookup_queue_by_doorbell which helps
>>>> look up a user queue with the given doorbell id
>>>> in a xarray.
>>>>
>>>> This function takes a kref of the user space queue.
>> Hello Christian
>>
>> Thanks for your comments.
>>
>>> Well absolutely clear NAK to the whole approach.
>>>
>>> This is the nonsense Sunil and I have worked quite hard to remove and we certainly shouldn't repeat such mistakes.
>>>
>>> When the userq needs to be used from interrupt context we need to hold the xa_lock_irqsave() or otherwise we don't have any guarantee that the userq, userq_mgr or associated fpriv went out of scope.
>> Holding the spin lock by xa_lock_irqsave() can surely avoid racing with the destruction process, however, it does not apply to all scenarios, for example, you can not hold spin lock in mes_userq_reset_queue(),
>> because it calls either amdgpu_mes_reset_queue_mmio or amdgpu_mes_reset_queue_mmio, both of them acquire the MES mutex through amdgpu_mes_lock.
> Yeah which is exactly the reason why mes_userq_reset_queue() should *NOT* be called from non IOCTL context.

I think it is not about whether called from IOCTL, it is a common racing we should fix, and holding a kref is a low haning fruit.

>
>> Another thing, out of the topic is, holding xa_lock does not guarantee fpriv/userq_mgr alive, for example, when drm_device->unplugged is true, all amdgpu teardown paths in amdgpu_drm_release are skipped,
>> and the fpriv/userq_mgr is freed, no matter whether holding the xa spin lock.
> That would clearly be a massive bug. Those objects still need to be cleaned up independent of device hot plug.

I agree, when unplugged == true, means can not access any HW registers, so this bug deserve another series to fix.

>
>> So IMHO since we have userq->kref, lets use it to maintain the lifecycle of the queues. 
>>
>>> Grabbing references from this side would obviously result in circle dependencies.
>> I am not sure, we should use the lock/unlock and kref_put/get in pairs in sequence, can you name some circle dependencies or AB-BA lockings as examples?
> That is not AB-BA locking, but circle dependencies. E.g. A reference B, B referencing C, C referencing A again.

A kref is an atomic counter, not a lock, that means we can try hold more than one kref in a thread, and a kref not
depend on another. As far as I can see, current amdgpu driver does not have such problems, do you see any occurrences?

Thanks
Lingshan

>
> Regards,
> Christian.
>
>> Thanks
>> Lingshan
>>
>>> Regards,
>>> Christian.
>>>
>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
>>>>  2 files changed, 32 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> index 0a816b3c5ff9..e0639f844a8e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>> @@ -609,6 +609,36 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
>>>>  	return queue;
>>>>  }
>>>>  
>>>> +/**
>>>> + * amdgpu_lookup_queue_by_doorbell - look up a user queue by doorbell
>>>> + * @xa: user queue XArray indexed by doorbell
>>>> + * @doorbell: doorbell index
>>>> + *
>>>> + * Return: A queue with the doorbell indexed, or NULL if no such a queue found.
>>>> + *
>>>> + * This function increases kref of the queue, the caller
>>>> + * must release the reference with amdgpu_userq_put().
>>>> + */
>>>> +struct amdgpu_usermode_queue *
>>>> +amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell)
>>>> +{
>>>> +	struct amdgpu_usermode_queue *queue;
>>>> +	unsigned long flags;
>>>> +
>>>> +	xa_lock_irqsave(xa, flags);
>>>> +	queue = xa_load(xa, doorbell);
>>>> +	if (!queue)
>>>> +		goto out_unlock;
>>>> +
>>>> +	if (!kref_get_unless_zero(&queue->refcount))
>>>> +		queue = NULL;
>>>> +
>>>> +out_unlock:
>>>> +	xa_unlock_irqrestore(xa, flags);
>>>> +
>>>> +	return queue;
>>>> +}
>>>> +
>>>>  void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
>>>>  {
>>>>  	if (queue)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>> index 6412a7f7b6ef..8fc73862f64e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>> @@ -151,6 +151,8 @@ struct amdgpu_db_info {
>>>>  };
>>>>  
>>>>  struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
>>>> +struct amdgpu_usermode_queue *
>>>> +amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell);
>>>>  void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
>>>>  
>>>>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
--------------YdCQXltHVqs7tvGsUkJKHS17
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 8/31/2026 4:21 PM, Christian König wrote:</pre>
    <blockquote type="cite" cite="mid:a46a12b8-d9df-4995-beaf-6d41150196bc@amd.com">
      <pre wrap="" class="moz-quote-pre">On 8/28/26 17:59, Zhu, Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On 8/28/2026 9:08 PM, Christian König wrote:

</pre>
        <blockquote type="cite">
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
        <pre wrap="" class="moz-quote-pre">
Hello Christian

Thanks for your comments.

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Well absolutely clear NAK to the whole approach.

This is the nonsense Sunil and I have worked quite hard to remove and we certainly shouldn't repeat such mistakes.

When the userq needs to be used from interrupt context we need to hold the xa_lock_irqsave() or otherwise we don't have any guarantee that the userq, userq_mgr or associated fpriv went out of scope.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Holding the spin lock by xa_lock_irqsave() can surely avoid racing with the destruction process, however, it does not apply to all scenarios, for example, you can not hold spin lock in mes_userq_reset_queue(),
because it calls either amdgpu_mes_reset_queue_mmio or amdgpu_mes_reset_queue_mmio, both of them acquire the MES mutex through amdgpu_mes_lock.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Yeah which is exactly the reason why mes_userq_reset_queue() should *NOT* be called from non IOCTL context.</pre>
    </blockquote>
    <pre>I think it is not about whether called from IOCTL, it is a common racing we should fix, and holding a kref is a low haning fruit.</pre>
    <blockquote type="cite" cite="mid:a46a12b8-d9df-4995-beaf-6d41150196bc@amd.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Another thing, out of the topic is, holding xa_lock does not guarantee fpriv/userq_mgr alive, for example, when drm_device-&gt;unplugged is true, all amdgpu teardown paths in amdgpu_drm_release are skipped,
and the fpriv/userq_mgr is freed, no matter whether holding the xa spin lock.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That would clearly be a massive bug. Those objects still need to be cleaned up independent of device hot plug.</pre>
    </blockquote>
    <pre>I agree, when unplugged == true, means can not access any HW registers, so this bug deserve another series to fix.</pre>
    <blockquote type="cite" cite="mid:a46a12b8-d9df-4995-beaf-6d41150196bc@amd.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">So IMHO since we have userq-&gt;kref, lets use it to maintain the lifecycle of the queues. 

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Grabbing references from this side would obviously result in circle dependencies.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
I am not sure, we should use the lock/unlock and kref_put/get in pairs in sequence, can you name some circle dependencies or AB-BA lockings as examples?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That is not AB-BA locking, but circle dependencies. E.g. A reference B, B referencing C, C referencing A again.</pre>
    </blockquote>
    <pre>A kref is an atomic counter, not a lock, that means we can try hold more than one kref in a thread, and a kref not
depend on another. As far as I can see, current amdgpu driver does not have such problems, do you see any occurrences?

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:a46a12b8-d9df-4995-beaf-6d41150196bc@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Thanks
Lingshan

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Regards,
Christian.

</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
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
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------YdCQXltHVqs7tvGsUkJKHS17--
