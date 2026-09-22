Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BB0C982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 07:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0861D10E3DD;
	Tue, 22 Sep 2026 07:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="siisuOEO";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F2510E3DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 07:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9CUVZzhbv2bX5BZ1oucg9ba23Lfb45pCLU+5vTfB7icqAnCMMelvdJIJD3QYGIab54ktgBdG0OKpY/A2UGNwz1+djwhgGP8ojiaGbROkqXPOVg7NZ0WYJu3l6CW0AxwCmWCUmBc42WWwK03zZ2xPOg4+A3ofo8j+f9UaoHZR3p9iHj/gHl6pWHx36OCOznr7KqVhwXU6wW17kwoZ0yleCojVZsZ+z65KzaGhmXy3Pz9IKXu7wJfN8sgaoxGgKDrgSpCxUhySPbeE2/7rjlhuhE5UYLHQ92E9tzGyFIDIu/0slK7t85H+f+S3DHtQkmjqFiPGZmiiSo1md82DYvh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsDhbieOuQFRRxt/iQCt7xlxePK+dcY9XkHR/bDefvI=;
 b=XPRK3t/Zv5Shzk8FS29DQuHJHLIIW0EXHo8X5XVx64EEm+CiBMq+UkiQT66+LEzjgHSBwjDvNV6QjRC4Mw3QfRyXrdgD7v6yAoh1ceKtvOoZJ80dMw8wmmQW7KqcOZ7QWxAcEvkdvfnpP1z51NoufG1HJocO1ysXj4rbZf2ZEuZAFcD4G7Fn2YE9/8e/8HwuPBflReqe/1rD68GbXM/6F9EMYA9c0mWWavDbXq9qSL/nYZwCxHS5hbsZRenhjFb4zRnl5Yptbh0f2+RXOWEswFk1jBmf7C9rpTAEY3ZCMRGhggxV9IuC36fNOImMl8kVdd6CB/NIprD1aU7/otj78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsDhbieOuQFRRxt/iQCt7xlxePK+dcY9XkHR/bDefvI=;
 b=siisuOEOOtzoC6BU3n/OXisSuaXwXOxMM239rttd5v7+jq4PhQx3GnymyO7rM3CaDTt2TV22diWFuBmBgQp3n6EuJSiQ/pMD79Sei5ae9o5Ij8WumPOXCWeJRMYTCZJrsPYcXwIFSHdp7j3KBW4yTlfZMb5fXvBxp60S6FKDEK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 07:51:16 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 07:51:15 +0000
Content-Type: multipart/alternative;
 boundary="------------YjeSQjOgMRsLa9Z8bJs004Bs"
Message-ID: <b76cc446-8626-4bd5-bae8-150d7fe34d32@amd.com>
Date: Tue, 22 Sep 2026 15:51:09 +0800
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
 <a34a1541-7f3a-4e0f-a225-f58b1292d6d2@amd.com>
 <5f576123-9f57-4da0-a6d5-fd0390e39f1b@amd.com>
 <f0d163a6-49cb-47d2-a042-d0e37bb7cdce@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <f0d163a6-49cb-47d2-a042-d0e37bb7cdce@amd.com>
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|SJ0PR12MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 9beca598-dc49-4b7c-7f7c-08df187e4773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|4143699003|56012099006|8096899003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ngzu8fgkDxkPK8rZLaPAQxNMzH0zTzXXmJLeMAapo4u7vLyt6FVWEd+4mgcevJfoJb0mJaT7wB7weXpt41VabPnJdLrzcO+pKmBDYEd4mbWGkzHqW8N/nUVfDPmY/LXzIepjvndB0H3KLuR35olq0u0FsLWUQTs9lAxlcwT0n4PmLYk4Yz/qWKl6EJFRpXvo7/o96ZA7+qdOWuXUDYKbETBSgBM/qiQ2tA0yJe+BETfLQKSv8icjYFvIpemXK7WA7VCCMTMJ+WMJ2jWCXcFxcpgajuUHbGHsMbKajx9itx5AIWdGQbPJNBVbY4RIB1jXlZoC0Kxf5+q6z00tV03sIrQMzdRKtScekXgQeaTHEJ22a/4gHkxfQr/oIL2gex3KHMSSg0LhImLNFjCs+2fipjjFBOmoEJ05E3FIabGXwkZeBjhfzYD7eyUt+jWxUMFFQ9D8omIkG6ZWxMnOAx0kun54rDZEI5T8BlcUAqdjIGGAcm/8GQrMC7XkwUO+KybKpvAoiARweAk+TxPxo6I+FT4cZEiPn5hRcDJ3D/UkzEGv1m/4K7ougbP51NiHK10VB+RvI2fnmUdjVjuuUnSR6ZiRYdT/diOGuS8lD8CGBZNmcZk0zsdinfsErLtV1UesaxS6l8vwtEkB3lS9+10F4ZqkDqMzujAjBR0f+Yi7AdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(8096899003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWgwQmM0SHR0RFE4MjQ5SEFwd2pLcnVDOE0rbFRqbG1YNHlXRVBjaTdCNWlo?=
 =?utf-8?B?UkRJbWtjWmlQZTA2b3RuOGxiN3J6cnZWQ1QvdUE1TEh1RDcwNXBEaDFkUml1?=
 =?utf-8?B?Ry9qM3Q5UUNHNmZIVDIvYzkzMW5BRlp6UXBhaWt2U0xMZlNEUVNoVm8xdVM1?=
 =?utf-8?B?TDFSWURvQTd1MkV3Y0ZmcmpSRXltbzZVUHVVVHpVdzNzMTVxdXUvTitKY1M0?=
 =?utf-8?B?eVpSWlZVcWU0bUxwWGI0MlJMcng1cFYxOE80SUxnV3dCa3hqY0F5dXBRMlND?=
 =?utf-8?B?RjgrY2p3TSsvaFROQ3NrZE8zTys0NFZ3clJ5YzQ3d1JwYTkrNTJkc0NYOEp6?=
 =?utf-8?B?Y0I5WmtOdkVBMHpPR2RBQ2tTZWZMK1h1WEZLUVF6dzZzaS9lMTFwL3dCb3py?=
 =?utf-8?B?MHY0VHJYY2xncTBOR1JoUVp5V1NhY0ttZnhIanZXYVQ4N3JvQ2NhMG1neU1n?=
 =?utf-8?B?bW8wRzBDRGNZaXh5UnlCQ1BRanQrQUljRjhKcUQvakk3dkxtem1DVDBRbmYv?=
 =?utf-8?B?NmRubUhtNCttV2R6bmNLVHZyQWVpdWhVUW5kRkdORm5EeUhYM1B5bUx5dnFG?=
 =?utf-8?B?UjlZdmRzeVkzZlRXWHFKLzRvV1dRRHVleFZLeXc2S2FLUk9YZ2hYZVhjVmg2?=
 =?utf-8?B?RjJjV3JSeEJKeHZObmgzQkgyK1VYaU1RZlp0WHRDbGtkeXFId0djZ2hwWllz?=
 =?utf-8?B?UnFUV1hqb3MwUHpYcjdJWW45VTJocjZXZlN4dXpja2hUZmVtUnF0ZjJxZlpE?=
 =?utf-8?B?ZHBlTTVjWVhrMmhHc0ZraURpS2NkSGVlWHpXelBiMWRXQTF4UDdXNkdqZCsv?=
 =?utf-8?B?MVlrQ0pmc2c2RlQweWVoT3hnWFIwQ040b3RXcEZsTmljU0J6emhIQzc5UGR0?=
 =?utf-8?B?ZFh6OFFUNTFkS0hVUTQxeVpDNHFYYzVJbDY0UnEzN1huamxCZWZwS1hSU05u?=
 =?utf-8?B?QWVOWkJKOTd2cDYrbHBXK2prV2NXZVhkWnUyek5GbEFSdmJpOUY5YmpTREs4?=
 =?utf-8?B?V2lqa1dsbHl2QjY3L01CaHF0QnNnaTBjZGkrd1k1dkZhbjl1VUtjMVVwamc4?=
 =?utf-8?B?bko0bGg4S0FCdTBTbm85a1E5WlAwQXJPWHdGVHlNb1lCbUF1bXB0ZEJGWHR0?=
 =?utf-8?B?eVhXQTR6YmFwM1RpSG9hUGE5RlY3R1V2aEttU0lPajNOV0FxSHkzalREdGk0?=
 =?utf-8?B?dyt5ZmkybjhHS1Z1Mm5LaFQ2MklaVTRGUGNheTNZYXBMd2wydkZ2TzI4c1Nv?=
 =?utf-8?B?WWRzVktjYWZ4TWViWCtJcE9RNmxoQWl5K2srb04xVko1RGFTcEVFSU5qQkZv?=
 =?utf-8?B?L2ZTVHJpMXJtZzB5YkVHOVhMUEp2cjZSTTcxTG9QeCtLOVd2aU1xakNabWVo?=
 =?utf-8?B?RXhlMlUvcDNkcFZzMUVYaHZFbVBVcHh1T0R2eURFVEVjNUZhcEJRUjJkZEpP?=
 =?utf-8?B?bVVWV2hPUXRycnYyQmpybkFwK2RxeTJ0dG5JNkNDU1JsS2R6UmpBRTVzVXZ5?=
 =?utf-8?B?Ync4Mm9TMWF4blhMdFdBeGdSUmJSMzl2bFlEd2p6TGloL1dKaytLeWtnaXgv?=
 =?utf-8?B?S0QzcVVtVzRSS0Zhb0FTODdrMU5pWUtWQnFieGRSaG8xL1VSQXRENkNlejBm?=
 =?utf-8?B?NTJzQ04yL1c0OEZYUnVxeFhpMUpnN2JCME5RbXhtREljdFRUeFRtRFJ6clZL?=
 =?utf-8?B?azd6L21qV2RzTXh0M29MSUFseTlUdzFsV1hJVmpQOHIzL1VEK1dSN0tTTWRL?=
 =?utf-8?B?VTlseVc4Z0tJcGN6YmU3QTJlVDVSYmpRRzRlTnBla2FQU3E5OWVNQm9ZeTN6?=
 =?utf-8?B?MzNlemtLSklJc0x6ZytNalFjUnJCUDVYRGRDYi91TkZmOVg0TGRLdUlFNm5X?=
 =?utf-8?B?SS9xSTBXRTBTOExQamdFQmhIZm1TckVZcmRPbHB3ZWxLMEc4Ym52VXVObHY2?=
 =?utf-8?B?amJIOWZyRzVWODFEUC9OeDRaL2JhakFXa21xRkFjaG9OYy9UWTQ1blRsNFh2?=
 =?utf-8?B?dXlsTmVZczhEL24zVnNOekNBQ1hLOGlmbWZ5QjVxdlBZWWlQS25Mb1VraGJI?=
 =?utf-8?B?T0NnUmtyOXdXcktPMEVuMGdwb2o3TEUvL25qdG1NV2h0bjNvaGNhMkVweFZW?=
 =?utf-8?B?d3NnVDJYaHZTUEhDOGluQmFaZWliL2szbktZSXVZTFVCVGJQY1dpWmIwbEs0?=
 =?utf-8?B?QjI5WGc2QzZUSHlsdCtneWVNQ3RDQ1FLSmd0d20rWFZUSzQydGt0VUdFYm9H?=
 =?utf-8?B?aUg1RWI5M0dTZmFzeE95SzZEdFBtSUp3Y1NLM1FRVzM1WHhNNWxBQ0NZUGRa?=
 =?utf-8?B?RXRrSzExTkplS2o0YmlLNFM0TFQ5SE9DUVVidGIyTHY1MDQ3ODhyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9beca598-dc49-4b7c-7f7c-08df187e4773
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 07:51:15.6846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVH+4/NjX2ne8kCsk8MBy8l8bAI64PsF3EFTHjL38vpqRYmXG26mi295/e5mbs8KrL6Rt3a0ZIq1Ll3p82SRNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927
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

--------------YjeSQjOgMRsLa9Z8bJs004Bs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/22/2026 3:35 PM, Christian König wrote:

> On 9/22/26 08:08, Zhu, Lingshan wrote:
>> On 9/1/2026 4:50 PM, Zhu, Lingshan wrote:
>>
>>> On 8/31/2026 4:21 PM, Christian König wrote:
>>>
>>>> On 8/28/26 17:59, Zhu, Lingshan wrote:
>>>>> On 8/28/2026 9:08 PM, Christian König wrote:
>>>>>
>>>>>> On 8/28/26 11:53, Zhu Lingshan wrote:
>>>>>>> This commit introduces a new helper
>>>>>>> amdgpu_lookup_queue_by_doorbell which helps
>>>>>>> look up a user queue with the given doorbell id
>>>>>>> in a xarray.
>>>>>>>
>>>>>>> This function takes a kref of the user space queue.
>>>>> Hello Christian
>>>>>
>>>>> Thanks for your comments.
>>>>>
>>>>>> Well absolutely clear NAK to the whole approach.
>>>>>>
>>>>>> This is the nonsense Sunil and I have worked quite hard to remove and we certainly shouldn't repeat such mistakes.
>>>>>>
>>>>>> When the userq needs to be used from interrupt context we need to hold the xa_lock_irqsave() or otherwise we don't have any guarantee that the userq, userq_mgr or associated fpriv went out of scope.
>>>>> Holding the spin lock by xa_lock_irqsave() can surely avoid racing with the destruction process, however, it does not apply to all scenarios, for example, you can not hold spin lock in mes_userq_reset_queue(),
>>>>> because it calls either amdgpu_mes_reset_queue_mmio or amdgpu_mes_reset_queue_mmio, both of them acquire the MES mutex through amdgpu_mes_lock.
>>>> Yeah which is exactly the reason why mes_userq_reset_queue() should *NOT* be called from non IOCTL context.
>>> I think it is not about whether called from IOCTL, it is a common racing we should fix, and holding a kref is a low haning fruit.
>>>
>>>>> Another thing, out of the topic is, holding xa_lock does not guarantee fpriv/userq_mgr alive, for example, when drm_device->unplugged is true, all amdgpu teardown paths in amdgpu_drm_release are skipped,
>>>>> and the fpriv/userq_mgr is freed, no matter whether holding the xa spin lock.
>>>> That would clearly be a massive bug. Those objects still need to be cleaned up independent of device hot plug.
>>> I agree, when unplugged == true, means can not access any HW registers, so this bug deserve another series to fix.
>>>
>>>>> So IMHO since we have userq->kref, lets use it to maintain the lifecycle of the queues. 
>>>>>
>>>>>> Grabbing references from this side would obviously result in circle dependencies.
>>>>> I am not sure, we should use the lock/unlock and kref_put/get in pairs in sequence, can you name some circle dependencies or AB-BA lockings as examples?
>>>> That is not AB-BA locking, but circle dependencies. E.g. A reference B, B referencing C, C referencing A again.
>>> A kref is an atomic counter, not a lock, that means we can try hold more than one kref in a thread, and a kref not
>>> depend on another. As far as I can see, current amdgpu driver does not have such problems, do you see any occurrences?
>> Hello Christian,
>>
>> I have not heard back from you for three weeks, I wonder whether you have any further comments for this series,
>> or shall I make any improvements?
> Well just completely drop that series. As I said this approach is a fundamental no-go from my side.
>
> As far as I can see we have solved the problems at hand and the rules how to handle the user queues should be pretty clear by now.

No, there are still some UAF issues. For example, what if the user space free a user queue while hang detector reseting it?

And, do you see any protections in mes_userq_reset_queue?

This series fixes these bugs.

>
> Regards,
> Christian.
>
>> Thanks
>> Lingshan 
>>
>>> Thanks
>>> Lingshan
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Thanks
>>>>> Lingshan
>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>>>>> ---
>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
>>>>>>>  2 files changed, 32 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>>> index 0a816b3c5ff9..e0639f844a8e 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>>>> @@ -609,6 +609,36 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
>>>>>>>  	return queue;
>>>>>>>  }
>>>>>>>  
>>>>>>> +/**
>>>>>>> + * amdgpu_lookup_queue_by_doorbell - look up a user queue by doorbell
>>>>>>> + * @xa: user queue XArray indexed by doorbell
>>>>>>> + * @doorbell: doorbell index
>>>>>>> + *
>>>>>>> + * Return: A queue with the doorbell indexed, or NULL if no such a queue found.
>>>>>>> + *
>>>>>>> + * This function increases kref of the queue, the caller
>>>>>>> + * must release the reference with amdgpu_userq_put().
>>>>>>> + */
>>>>>>> +struct amdgpu_usermode_queue *
>>>>>>> +amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell)
>>>>>>> +{
>>>>>>> +	struct amdgpu_usermode_queue *queue;
>>>>>>> +	unsigned long flags;
>>>>>>> +
>>>>>>> +	xa_lock_irqsave(xa, flags);
>>>>>>> +	queue = xa_load(xa, doorbell);
>>>>>>> +	if (!queue)
>>>>>>> +		goto out_unlock;
>>>>>>> +
>>>>>>> +	if (!kref_get_unless_zero(&queue->refcount))
>>>>>>> +		queue = NULL;
>>>>>>> +
>>>>>>> +out_unlock:
>>>>>>> +	xa_unlock_irqrestore(xa, flags);
>>>>>>> +
>>>>>>> +	return queue;
>>>>>>> +}
>>>>>>> +
>>>>>>>  void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
>>>>>>>  {
>>>>>>>  	if (queue)
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>>>> index 6412a7f7b6ef..8fc73862f64e 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>>>>>> @@ -151,6 +151,8 @@ struct amdgpu_db_info {
>>>>>>>  };
>>>>>>>  
>>>>>>>  struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
>>>>>>> +struct amdgpu_usermode_queue *
>>>>>>> +amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell);
>>>>>>>  void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
>>>>>>>  
>>>>>>>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
--------------YjeSQjOgMRsLa9Z8bJs004Bs
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 9/22/2026 3:35 PM, Christian König wrote:</pre>
    <blockquote type="cite" cite="mid:f0d163a6-49cb-47d2-a042-d0e37bb7cdce@amd.com">
      <pre wrap="" class="moz-quote-pre">On 9/22/26 08:08, Zhu, Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On 9/1/2026 4:50 PM, Zhu, Lingshan wrote:

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On 8/31/2026 4:21 PM, Christian König wrote:

</pre>
          <blockquote type="cite">
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
              <pre wrap="" class="moz-quote-pre">Hello Christian

Thanks for your comments.

</pre>
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">Well absolutely clear NAK to the whole approach.

This is the nonsense Sunil and I have worked quite hard to remove and we certainly shouldn't repeat such mistakes.

When the userq needs to be used from interrupt context we need to hold the xa_lock_irqsave() or otherwise we don't have any guarantee that the userq, userq_mgr or associated fpriv went out of scope.
</pre>
              </blockquote>
              <pre wrap="" class="moz-quote-pre">Holding the spin lock by xa_lock_irqsave() can surely avoid racing with the destruction process, however, it does not apply to all scenarios, for example, you can not hold spin lock in mes_userq_reset_queue(),
because it calls either amdgpu_mes_reset_queue_mmio or amdgpu_mes_reset_queue_mmio, both of them acquire the MES mutex through amdgpu_mes_lock.
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">Yeah which is exactly the reason why mes_userq_reset_queue() should *NOT* be called from non IOCTL context.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">I think it is not about whether called from IOCTL, it is a common racing we should fix, and holding a kref is a low haning fruit.

</pre>
          <blockquote type="cite">
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">Another thing, out of the topic is, holding xa_lock does not guarantee fpriv/userq_mgr alive, for example, when drm_device-&gt;unplugged is true, all amdgpu teardown paths in amdgpu_drm_release are skipped,
and the fpriv/userq_mgr is freed, no matter whether holding the xa spin lock.
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">That would clearly be a massive bug. Those objects still need to be cleaned up independent of device hot plug.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">I agree, when unplugged == true, means can not access any HW registers, so this bug deserve another series to fix.

</pre>
          <blockquote type="cite">
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">So IMHO since we have userq-&gt;kref, lets use it to maintain the lifecycle of the queues. 

</pre>
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">Grabbing references from this side would obviously result in circle dependencies.
</pre>
              </blockquote>
              <pre wrap="" class="moz-quote-pre">I am not sure, we should use the lock/unlock and kref_put/get in pairs in sequence, can you name some circle dependencies or AB-BA lockings as examples?
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">That is not AB-BA locking, but circle dependencies. E.g. A reference B, B referencing C, C referencing A again.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">A kref is an atomic counter, not a lock, that means we can try hold more than one kref in a thread, and a kref not
depend on another. As far as I can see, current amdgpu driver does not have such problems, do you see any occurrences?
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Hello Christian,

I have not heard back from you for three weeks, I wonder whether you have any further comments for this series,
or shall I make any improvements?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Well just completely drop that series. As I said this approach is a fundamental no-go from my side.

As far as I can see we have solved the problems at hand and the rules how to handle the user queues should be pretty clear by now.</pre>
    </blockquote>
    <pre>No, there are still some UAF issues. For example, what if the user space free a user queue while hang detector reseting it?

And, do you see any protections in mes_userq_reset_queue?

This series fixes these bugs.</pre>
    <blockquote type="cite" cite="mid:f0d163a6-49cb-47d2-a042-d0e37bb7cdce@amd.com">
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
          <pre wrap="" class="moz-quote-pre">Thanks
Lingshan

</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">Regards,
Christian.

</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">Thanks
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
          </blockquote>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------YjeSQjOgMRsLa9Z8bJs004Bs--
