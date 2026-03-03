Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D798EC1444
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2026 13:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42AEA10E819;
	Tue,  3 Mar 2026 13:50:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M4E/lvlI";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012035.outbound.protection.outlook.com
 [40.107.200.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1BA610E819
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2026 13:50:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBjMjZ9X5y5kgh0L0dPQcxj/Abg9rC+JwL/FuKPOGvToQ5UMMIYIhALRRIc1SHUr+ZMhJFwcjWlI0ZVhZ2tPfUdc3vO0BsgVg/vqfzDN5VkmajoVFVIjJwFpFduq31yO8USA/CPPwUMsZaaJIasVK9ez1+I64+VNcpSXRZ/ySalJwRJ44OfKXnS4Pta8R03w8yrubaENTOF/o8tsYaCMYQ/Dm8CfVS1hMuxCucb/BG7Oh3j67R2AJcAewgaWy3pfAzLtoqEzhK+O64Nr/LTLUz5zvLTuzZDbP2hv9OSKr0FqDwyEyg61jDr0dnVi1Via5Ct8NDuD8XXWKxT6iR2+ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SJnBlzc2G93ioLKSq1t39H8juqcTxbdMpPegf7kQgE=;
 b=XwOusgkwWI47viUmzi5R4+Ez201qqSB0Xl3R4/EsODJakgH2fb7fun1H4537rRYZmv2M3JJievIfMAmwz3fKP9sWPPn8uSxKsG2dv2bnU2CSvGU3+Z788CZ7wzvqiOmdOFveaB3PdQk74muCCQz0JmBSBdNR7ShYyfUbGTQgFx0OdQAsxiMV83WZzRb67eHfwLhzaU78tpVOVx+VlRS6bwaVMTrsfjrB2UB+v1CdB/0/ERx55xz0TmSipyfvpOIaQ/sev26Qr29q4ojlc0O5wrrzGd6BfwynBl28qtp2ymCboFCaRCwTRCBy57Blshp/ZobldIvX9oiuwpajjWU9fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SJnBlzc2G93ioLKSq1t39H8juqcTxbdMpPegf7kQgE=;
 b=M4E/lvlI9CgOzZFB07m6r5YvflOSt07gDOr45wpfriFnGlzYuIYeDZ4UUOd/Z+qVVTgDi+Euh5d/YvO1UXHgKq+yVxhduOD+zZYdUOcj3MjKjJ8vkWMdHEZfxAbAMP5LWoOLt5+5sjEBzdLMrp0B/kRAUA61XGP0LBLRyr6kXck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 13:50:03 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 13:50:03 +0000
Message-ID: <aeafbd1a-49a4-4049-8523-b29f78344fd3@amd.com>
Date: Tue, 3 Mar 2026 19:19:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu/userq: refcount userqueues to avoid any
 race conditions
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260303120654.2582995-1-sunil.khatri@amd.com>
 <38ec1a98-d112-4345-9711-d023a3e10da9@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <38ec1a98-d112-4345-9711-d023a3e10da9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::8) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ccb46d-57a5-49d6-8626-08de792bc4ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: tbTXzoOaqxA/7/TiIB6zfLRNuoyLv8fxwYFVoeWQh9Acaf6c7EJeR3uoQ/TlNmVnRrIXNw5bs+sc/dx+11g1MeJVp03/tNoxu4roMUGPxaO8rQWLpZ7rxjBSf+ru93d+DL5BKe+55lTTC+2b2wLGvemUiT2bla0+NBp84BbeI3bE4l9FUV8paV4F6j/uJjufK0iwiZNBMykfxKUXWiyu1xKOEnAJlN+EgUXnJDE5AAkcXCL3g50OQ0arVgCocjEur3IhY5EcX6e2WvcwIPzyPbJUPbk21IOS47PTIrW7tkR5t1Utg6NMf7Sdty6F4/4/al8PxRKUFJ+jxdHLGHTtleowzvClVqeQ4LU28Bqc7WHWUlYmZwONW6C0ogtT379CHqsli2eePbuDZInTGVXDJu2anWm8wThiyLFGXOCzssHdKPpy0HYbzL79RqtCMBdevZBx9v/tPdoNdbGgCIa5s38/Ik9+ssyHHBTE1UYum2e83bVwIHxvxRx8zGH+0DcKf38JvbGxiEhw1co4zEI3w80CKIk4OtxZ8/YuVRJW78NC3r9bqKpPdDf/36+9ZiqzpqTI2FjjeA7Mq7CRCfEiGJovmgVa2Tn8M/bVp8akzvuszn7Qreh7o9T3qg0TfKX3h4utBloXH9auFBx25NuHUFsPvYt1Vton4eTaqDKrgNMuBf4Q/CRgixQ88l/Zg3xSdd7dK3CCbliEJoKHQhPVV3kP+gt0P5vTyki1d9pkn90=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0liYVE1MHdsM1RqM2d1ZVc0SFFiWkhBNzNteUtRMTVTZVNVMWFZNms4Z1Qv?=
 =?utf-8?B?SXhWc2pKL0hMd0ZnUExHazVtNm5Cc3BaK2hqajRUMGU0bnVhQ3VmMXg0Q0M1?=
 =?utf-8?B?UlpuWm9vcno1dzdoWnFGSVp2a0trQkVrVFNENlVmeENocGEwS01vTDR2ckdR?=
 =?utf-8?B?RXBpcGpqY3krTnF3em5XcUZ1ZmVLcXlmODAzdlhTTWF5VlZyM1hNNncySnhn?=
 =?utf-8?B?SDRLSDYxV3hIS2V5ODhuQi8zMzBNUW9ma1dTMU50cnB5b0EvQmRCWGFyL0NT?=
 =?utf-8?B?R3dLd3NFalI1Y1VQNldyMFV6bHpmdXRJM1V5ekVXLzhYWk0vRkdPUzRWQVA3?=
 =?utf-8?B?TWY4SVE5UFg3bDdVZ1NlQ2F1VW5MaGV2NnNjb0xYT3Blc2xsVnpLYzA4WkV0?=
 =?utf-8?B?eitUaEk2WFBuNGI1b29XN1dQelpxWEhlOXR4bnB1OGw1dkkyNW1BbHp1alcz?=
 =?utf-8?B?aGpjL0hrT3BCdFc2N3ozWXRRNExDRDZZWXBXQkFxcTkveUpQUit2bDhOV044?=
 =?utf-8?B?ZytpNlpwTEJGRkJMNEhGaUhSRjVWWURGWXlSbHExWlRTQU9nK0YxamxFenFh?=
 =?utf-8?B?TndsL01LYUR5ZTQ2a3Y1SDJmODJ6cDVaLzg3ZlhjYmVSUWhiK0YzZ04yNmtH?=
 =?utf-8?B?WVV0bmdoVFg0eVZVckwySGxaV25OV0oxazRxMnFWb3gzaEtCd1dtZzV3cmdW?=
 =?utf-8?B?V1RNdW9LR28xaGR4dWlERlcrOG10aW5ZK2FMejJDS3o1TVNDdmlCRnlraCtB?=
 =?utf-8?B?VEwrSlBrZmJrSU4rTUIvWWxTeU45UjZxeDFpRGZXWFVaSlRCYVpheTU2Nnl2?=
 =?utf-8?B?ODU0bUx4UXJicFJUeHQ3TTRkRmt5NUZhWGRZNnpaa1ZTWnRhVmtSRGtQQXNF?=
 =?utf-8?B?b0VwdUwwQ1ppbEphWVJHYUtsejc3ZjR6bERQdlFUSlBUakM4YzlLYVlyYXEz?=
 =?utf-8?B?U3BBZUliNzNaamJqL1NPN016NUQzU1RBaTV1MWt5NTlHSERUdXBNWklBNnFt?=
 =?utf-8?B?QUFNbVF1dlgyUTg3a1NDRHFtbnRUdStJK3JDZGRrditubmd6UkhkbU0wRzJG?=
 =?utf-8?B?aHpoYUZBQ1RNZVNMUDZjc3V6aGNMTTFrclV1cDhzSVJjWnNkcHJicFdxcE84?=
 =?utf-8?B?YTV2UjlFRlVYcmNHaGZMcnZDNXBjSTVNSU8rcHBmRmxGeml2bjNWdzJjUkM4?=
 =?utf-8?B?eFQrRE5oVDdab2VjeDFoVDM0MjJKS2s2ZjhuZUw2SEl6TncxVnRHc1hZc0gz?=
 =?utf-8?B?dTlzRm9XNWxRV3BZN0FqQk5ZS0dLNzFScUhjWEhJNUZSNlJjU0NYQ1ZzSlky?=
 =?utf-8?B?aXZmK0ppZy91UDdsYzVMVzdxRm8wZFZMcTJ5ZEloa3BzQkxweDErTHZZUU9E?=
 =?utf-8?B?MEVVbS9JSTYvNmFWQ1V0czZucndnT0hDTUNlbGZlWS8yT1FxV1F2N1I0cEdJ?=
 =?utf-8?B?azhnbTY2Ym5hZWlSaUVhd1AxS2VCdWszVTFxZlgvTFpSZUFaUGx5dkl1WmFZ?=
 =?utf-8?B?c2lvSmNiSFNWTkpvZHN2Y29oVUh0MlVtWjU1ZDdOZWpybnY1TlFuek11eVI3?=
 =?utf-8?B?NXp2T2hiMmEvb2luZ1JVNkNQQnJQZTdFdE9pVHEzZjFBMzEreXVYVjh0Qlll?=
 =?utf-8?B?VHVodTR1SnRpdml6Y1FGODY5ZXBjbVphbmFFcnhPTDMzVUR2eENGRVVmMmU1?=
 =?utf-8?B?Q2pidXdlN1JtQVhFM0orVmlYNXFIQW9PV3c4YysySmF3NHdNMGNBdjd1TXhz?=
 =?utf-8?B?dS93ZUxaa2pKOGQ2TDRINHZnTzdOTGUrdHVDeU1XZDlwK3dpNGdDSmJGcGlR?=
 =?utf-8?B?ZCtRNEhmYWVYT1k1NHMvSDV3YlIzRVl2c1NWMW1xR2QrQzR1VDQ1VHp4Tkpw?=
 =?utf-8?B?cmIxS051eUlqM0JoZFNqZ3dVaENvSkpuYmdoRUZYRnZLMlZNZjQ2MDdHUjh2?=
 =?utf-8?B?WnNFSGNKUDhJOFo4WHlTZlU0eEtMdi9KeVJla05DSE1pUk1YT1g3R0tsS3Ar?=
 =?utf-8?B?LzdSd0VxZEs5S2NIOGZYTnplaGhxSTZoTlBtaVBmT1BjUDVhUHVhek9YN1M3?=
 =?utf-8?B?aTlMbVFaNGJpL21RRFprekJGNDRSaDVGZTNlNEJCMTdhekRveXJUbWZWQnBP?=
 =?utf-8?B?c2xMYlUrck1xMnhFZ1djU0FkQkM2b0k1cTRGWjc4bHFULzR6N2hVdmdFMGhp?=
 =?utf-8?B?TlFkcUlZZlh4Z0lIQm9NV2dtL0NYcUVHN0F1U21nSHFOUGxKb3JYRkZmVFdQ?=
 =?utf-8?B?REpHeldZYTJibWVMVEFPQ3BsRDNiN3Y0ZGwrSVh5bnF5OWdMUkoyOXo3aHha?=
 =?utf-8?B?NWVZK0pUTGppY3BuOXRRdEo5NEgrWGhLTWcvQitxcCtVWkFUYnBhQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ccb46d-57a5-49d6-8626-08de792bc4ff
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 13:50:03.2064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkTXqRG3w8cSonnh8ylAoxgGRMUBnhpKLTriLm5mFRz4PsASoCg/H3kCqrpyAAdVOv71pvV55vOWvIFl9OzQBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277
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


On 03-03-2026 07:16 pm, Christian König wrote:
> On 3/3/26 13:06, Sunil Khatri wrote:
>> To avoid race condition and avoid UAF cases, implement kref
>> based queues and protect the below operations using xa lock
>> a. Getting a queue from xarray
>> b. Increment/Decrement it's refcount
>>
>> Every time some one want to access a queue, always get via
>> amdgpu_userq_get to make sure we have locks in place and get
>> the object if active.
>>
>> A userqueue is destroyed on the last refcount is dropped which
>> typically would be via IOCTL or during fini.
>>
>> v2: Add the missing drop in one the condition in the signal ioclt [Alex]
>>
>> v3: remove the queue from the xarray first in the free queue ioctl path
>>      [Christian]
>>
>> - Pass queue to the amdgpu_userq_put directly.
>> - make amdgpu_userq_put xa_lock free since we are doing put for each get
>>    only and final put is done via destroy and we remove the queue from xa
>>    with lock.
>> - use userq_put in fini too so cleanup is done fully.
>>
>> v4: Use xa_erase directly rather than doing load and erase in free
>>      ioctl. Also remove some of the error logs which could be exploited
>>      by the user to flood the logs [Christian]
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 110 ++++++++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   4 +
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  14 ++-
>>   3 files changed, 91 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index e07b2082cf25..ed6a9d779d1b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -446,8 +446,7 @@ static int amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
>>   	return ret;
>>   }
>>   
>> -static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
>> -				 u32 queue_id)
>> +static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>>   {
>>   	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>>   	struct amdgpu_device *adev = uq_mgr->adev;
>> @@ -461,7 +460,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
>>   	uq_funcs->mqd_destroy(queue);
>>   	amdgpu_userq_fence_driver_free(queue);
>>   	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
>> -	xa_erase_irq(&uq_mgr->userq_xa, queue_id);
>>   	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>>   	queue->userq_mgr = NULL;
>>   	list_del(&queue->userq_va_list);
>> @@ -470,12 +468,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
>>   	up_read(&adev->reset_domain->sem);
>>   }
>>   
>> -static struct amdgpu_usermode_queue *
>> -amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
>> -{
>> -	return xa_load(&uq_mgr->userq_xa, qid);
>> -}
>> -
>>   void
>>   amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>>   			     struct amdgpu_eviction_fence_mgr *evf_mgr)
>> @@ -625,22 +617,13 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>   }
>>   
>>   static int
>> -amdgpu_userq_destroy(struct drm_file *filp, u32 queue_id)
>> +amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>   {
>> -	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> -	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>>   	struct amdgpu_device *adev = uq_mgr->adev;
>> -	struct amdgpu_usermode_queue *queue;
>>   	int r = 0;
>>   
>>   	cancel_delayed_work_sync(&uq_mgr->resume_work);
>>   	mutex_lock(&uq_mgr->userq_mutex);
>> -	queue = amdgpu_userq_find(uq_mgr, queue_id);
>> -	if (!queue) {
>> -		drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queue id to destroy\n");
>> -		mutex_unlock(&uq_mgr->userq_mutex);
>> -		return -EINVAL;
>> -	}
>>   	amdgpu_userq_wait_for_last_fence(queue);
>>   	/* Cancel any pending hang detection work and cleanup */
>>   	if (queue->hang_detect_fence) {
>> @@ -672,13 +655,44 @@ amdgpu_userq_destroy(struct drm_file *filp, u32 queue_id)
>>   		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
>>   		queue->state = AMDGPU_USERQ_STATE_HUNG;
>>   	}
>> -	amdgpu_userq_cleanup(queue, queue_id);
>> +	amdgpu_userq_cleanup(queue);
>>   	mutex_unlock(&uq_mgr->userq_mutex);
>>   
>>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>   
>>   	return r;
>>   }
>> +static void amdgpu_userq_kref_destroy(struct kref *kref)
>> +{
>> +	int r;
>> +	struct amdgpu_usermode_queue *queue =
>> +		container_of(kref, struct amdgpu_usermode_queue, refcount);
>> +
>> +	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>> +
>> +	r = amdgpu_userq_destroy(uq_mgr, queue);
>> +	if (r)
>> +		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue\n");
>> +}
>> +
>> +struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
>> +{
>> +	struct amdgpu_usermode_queue *queue;
>> +
>> +	xa_lock(&uq_mgr->userq_xa);
>> +	queue = xa_load(&uq_mgr->userq_xa, qid);
>> +	if (queue)
>> +		kref_get(&queue->refcount);
>> +	xa_unlock(&uq_mgr->userq_xa);
>> +
>> +	return queue;
>> +}
>> +
>> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
>> +{
>> +	if (queue)
>> +		kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
>> +}
>>   
>>   static int amdgpu_userq_priority_permit(struct drm_file *filp,
>>   					int priority)
>> @@ -891,6 +905,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   
>>   	args->out.queue_id = qid;
>>   	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
>> +	/* drop this refcount during queue destroy */
>> +	kref_init(&queue->refcount);
>>   
>>   unlock:
>>   	mutex_unlock(&uq_mgr->userq_mutex);
>> @@ -985,6 +1001,8 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>   		       struct drm_file *filp)
>>   {
>>   	union drm_amdgpu_userq *args = data;
>> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +	struct amdgpu_usermode_queue *queue;
>>   	int r;
>>   
>>   	if (!amdgpu_userq_enabled(dev))
>> @@ -1000,11 +1018,14 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>>   			drm_file_err(filp, "Failed to create usermode queue\n");
>>   		break;
>>   
>> -	case AMDGPU_USERQ_OP_FREE:
>> -		r = amdgpu_userq_destroy(filp, args->in.queue_id);
>> -		if (r)
>> -			drm_file_err(filp, "Failed to destroy usermode queue\n");
>> +	case AMDGPU_USERQ_OP_FREE: {
>> +		queue = xa_erase(&fpriv->userq_mgr.userq_xa, args->in.queue_id);
> You need to have xa_lock around that or otherwise xa_load/kref_get can race.
__xa_erase is unlocked version, but xa_erase internally does have 
xa_lock, since there is nothing else but just erase here to it made more 
sense to have clear xa_erase.

Regards

Sunil Khatri
>
> Apart of that Reviewed-by: Christian König <christian.koenig@amd.com>
>
> Regards,
> Christian.
>
>> +		if (!queue)
>> +			return -ENOENT;
>> +
>> +		amdgpu_userq_put(queue);
>>   		break;
>> +	}
>>   
>>   	default:
>>   		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
>> @@ -1023,16 +1044,23 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>   
>>   	/* Resume all the queues for this process */
>>   	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>> +		queue = amdgpu_userq_get(uq_mgr, queue_id);
>> +		if (!queue)
>> +			continue;
>> +
>>   		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>>   			drm_file_err(uq_mgr->file,
>>   				     "trying restore queue without va mapping\n");
>>   			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
>> +			amdgpu_userq_put(queue);
>>   			continue;
>>   		}
>>   
>>   		r = amdgpu_userq_restore_helper(queue);
>>   		if (r)
>>   			ret = r;
>> +
>> +		amdgpu_userq_put(queue);
>>   	}
>>   
>>   	if (ret)
>> @@ -1266,9 +1294,13 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>>   	amdgpu_userq_detect_and_reset_queues(uq_mgr);
>>   	/* Try to unmap all the queues in this process ctx */
>>   	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>> +		queue = amdgpu_userq_get(uq_mgr, queue_id);
>> +		if (!queue)
>> +			continue;
>>   		r = amdgpu_userq_preempt_helper(queue);
>>   		if (r)
>>   			ret = r;
>> +		amdgpu_userq_put(queue);
>>   	}
>>   
>>   	if (ret)
>> @@ -1301,16 +1333,24 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>>   	int ret;
>>   
>>   	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>> +		queue = amdgpu_userq_get(uq_mgr, queue_id);
>> +		if (!queue)
>> +			continue;
>> +
>>   		struct dma_fence *f = queue->last_fence;
>>   
>> -		if (!f || dma_fence_is_signaled(f))
>> +		if (!f || dma_fence_is_signaled(f)) {
>> +			amdgpu_userq_put(queue);
>>   			continue;
>> +		}
>>   		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>>   		if (ret <= 0) {
>>   			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>>   				     f->context, f->seqno);
>> +			amdgpu_userq_put(queue);
>>   			return -ETIMEDOUT;
>>   		}
>> +		amdgpu_userq_put(queue);
>>   	}
>>   
>>   	return 0;
>> @@ -1361,20 +1401,24 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>   {
>>   	struct amdgpu_usermode_queue *queue;
>> -	unsigned long queue_id;
>> +	unsigned long queue_id = 0;
>>   
>>   	cancel_delayed_work_sync(&userq_mgr->resume_work);
>> +	for (;;) {
>> +		xa_lock(&userq_mgr->userq_xa);
>> +		queue = xa_find(&userq_mgr->userq_xa, &queue_id, ULONG_MAX,
>> +				XA_PRESENT);
>> +		if (queue)
>> +			__xa_erase(&userq_mgr->userq_xa, queue_id);
>> +		xa_unlock(&userq_mgr->userq_xa);
>> +
>> +		if (!queue)
>> +			break;
>>   
>> -	mutex_lock(&userq_mgr->userq_mutex);
>> -	amdgpu_userq_detect_and_reset_queues(userq_mgr);
>> -	xa_for_each(&userq_mgr->userq_xa, queue_id, queue) {
>> -		amdgpu_userq_wait_for_last_fence(queue);
>> -		amdgpu_userq_unmap_helper(queue);
>> -		amdgpu_userq_cleanup(queue, queue_id);
>> +		amdgpu_userq_put(queue);
>>   	}
>>   
>>   	xa_destroy(&userq_mgr->userq_xa);
>> -	mutex_unlock(&userq_mgr->userq_mutex);
>>   	mutex_destroy(&userq_mgr->userq_mutex);
>>   }
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> index f4d1d46ae15e..54e1997b3cc0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> @@ -74,6 +74,7 @@ struct amdgpu_usermode_queue {
>>   	struct dentry		*debugfs_queue;
>>   	struct delayed_work hang_detect_work;
>>   	struct dma_fence *hang_detect_fence;
>> +	struct kref		refcount;
>>   
>>   	struct list_head	userq_va_list;
>>   };
>> @@ -114,6 +115,9 @@ struct amdgpu_db_info {
>>   	struct amdgpu_userq_obj	*db_obj;
>>   };
>>   
>> +struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
>> +void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
>> +
>>   int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>>   
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 3c30512a6266..a7ded25346b8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -470,7 +470,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>   	struct drm_gem_object **gobj_write, **gobj_read;
>>   	u32 *syncobj_handles, num_syncobj_handles;
>>   	struct amdgpu_userq_fence *userq_fence;
>> -	struct amdgpu_usermode_queue *queue;
>> +	struct amdgpu_usermode_queue *queue = NULL;
>>   	struct drm_syncobj **syncobj = NULL;
>>   	struct dma_fence *fence;
>>   	struct drm_exec exec;
>> @@ -521,7 +521,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>   		goto put_gobj_read;
>>   
>>   	/* Retrieve the user queue */
>> -	queue = xa_load(&userq_mgr->userq_xa, args->queue_id);
>> +	queue = amdgpu_userq_get(userq_mgr, args->queue_id);
>>   	if (!queue) {
>>   		r = -ENOENT;
>>   		goto put_gobj_write;
>> @@ -612,6 +612,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>   free_syncobj_handles:
>>   	kfree(syncobj_handles);
>>   
>> +	if (queue)
>> +		amdgpu_userq_put(queue);
>> +
>>   	return r;
>>   }
>>   
>> @@ -626,7 +629,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>   	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>>   	struct drm_gem_object **gobj_write, **gobj_read;
>>   	u32 *timeline_points, *timeline_handles;
>> -	struct amdgpu_usermode_queue *waitq;
>> +	struct amdgpu_usermode_queue *waitq = NULL;
>>   	u32 *syncobj_handles, num_syncobj;
>>   	struct dma_fence **fences = NULL;
>>   	u16 num_points, num_fences = 0;
>> @@ -863,7 +866,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>   		 */
>>   		num_fences = dma_fence_dedup_array(fences, num_fences);
>>   
>> -		waitq = xa_load(&userq_mgr->userq_xa, wait_info->waitq_id);
>> +		waitq = amdgpu_userq_get(userq_mgr, wait_info->waitq_id);
>>   		if (!waitq) {
>>   			r = -EINVAL;
>>   			goto free_fences;
>> @@ -947,5 +950,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>   free_syncobj_handles:
>>   	kfree(syncobj_handles);
>>   
>> +	if (waitq)
>> +		amdgpu_userq_put(waitq);
>> +
>>   	return r;
>>   }
