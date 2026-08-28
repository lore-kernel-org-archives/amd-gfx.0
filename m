Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FB1C61DDB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 15:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FC8F10F40A;
	Fri, 28 Aug 2026 15:59:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aPYnNUoP";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013020.outbound.protection.outlook.com
 [40.107.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6814010F40A
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 15:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBC8QM7PY6oXBtPrndnFlytlKJ1sko2414aoawdUfXotrvDSMge9CPBZiXcbrCWjubqbL4PP1WhzaQvnwRY733rTWlnIUpZ63w7+PUVbbJVzcZOC8NahjrLpFPBl5cERWskdrSPnj1ezIkC6liG44KeNdnF6HgWgszlR16PjxlqIauQdVFfHoAxbotLdG6YOgIPtwy56uQz5esnKI4ZWe7NnrOgfVzIR4RTE1VAZkoVlWi6qJzrMzmk7DdEbUqzZzCfyB17PTk+ECLXvaVRWDxGwTLrbf99TTCfbS5UnA5J/E0m4s2f/+x9ytVcgSDjruGOKSvtJSqS1Z4PBZ9NlSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaODb0jWXpdNUkqG+SqFQ96U+2aoGtp8swFVtCqq+9o=;
 b=bdpPvYW04jF4NtuY31FO+YvpBA7ek9K2ytLDLU0A/HLATrGw5A0EuBWvn5vGDC1LqQQLoEm6kolpYGIHRrV+K04sHjnlQahCSFyGi74xEmUvlQXo9jVomQMcnaxdDNz/bPEnUN5QcfhlSGeeM+CggpJlGBchhN/oxt0Zl2p9QfDnTZo8dlrKmygwdzsO9M53EJz6VTAYMnIyjlRJRonv7Ln9T84YBkwOXrDh6I1dNVff7r3OoOpCz1p6O/f4n7JN8xtigBUOnpafrWkYHAVTYTsfKLNJ6hf3GuT12FhgloExPZGdx2LfShrFe4HNT2pYDHWSt6L03R1L+hXSBAxW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaODb0jWXpdNUkqG+SqFQ96U+2aoGtp8swFVtCqq+9o=;
 b=aPYnNUoPmP6uKUema7HQJJguM9AxKXsNcUA2UdpbZcizA4qaCCpRAnOGKFnQRkxHDV9hlCXrQTxhiGEnluMG1cw4IIqsbJqHb/Ic1L9PvgSop8nzvwtPneogwzznAHY+3tKFp2Upu0MJ0XszmZIEj54ldOXELGnHGAJVj9z04WI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:59:49 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:59:49 +0000
Content-Type: multipart/alternative;
 boundary="------------9PUtMLkQovIElRxt71VyMfq3"
Message-ID: <7f53ac18-ecb5-4eaa-8692-67b9237447b2@amd.com>
Date: Fri, 28 Aug 2026 23:59:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] drm/amdgpu: keep the userq manager alive as long as
 its queues
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexander.Deucher@amd.com, felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
 <20260828095349.9797-3-lingshan.zhu@amd.com>
 <18014f3c-5e0f-4ed7-b278-590cf60dfe03@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <18014f3c-5e0f-4ed7-b278-590cf60dfe03@amd.com>
X-ClientProxiedBy: TPYP295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::14) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 231bb70b-8533-4889-1bfb-08df051d634a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006|8096899003;
X-Microsoft-Antispam-Message-Info: EqD2XiFGuNxHMiWFo2yd4b6VPEuZexW1w9OCr+lgCoJ9dqfReUjrVSpsKqXVnDQJBXkQDcL7H+OW9oY6c1YEIzJDBP2YZUnX8G9T7mWG0qIq085yY2QciNKVV19pvjLu4skRhxuu3kfq8k9F6fM9e+pPo0PojTtPW2m7hYnEc7za15V1rdL83i8ygBXvfi03MoUaxRpsCMXsvy2SSZ6aVUTLnCOQUorKN3zv/UOPU/qEk2MdYVYVKQm2UMf/JRwnO1A51XBgCMWKdxSCmTF0W8iFvwzYvgijWICH2TvLZOkEgFQj2MIFPVRSObfhfhIVuLksBvGtrqP/yRlp/HjLB1twTRG6dCp0c+xxEemEtI2YqANAfQfDYIoxpXGj9h6a1wT0GG3Aj78zgFf37TDq3lOhQ4JAaNe0t52njhZjdcTFd4i5TXbxJDv+vpjOwBXwfydY+6iNKCWorGC9hwFYWrWxOg8zrhMSl8NSlslA99xsdw5hDXdl9iJmy86zsCeGzJuZeK1SuxTgV7FoydTzTbVEfupMZIorMR3kcTEIZ1KdYL2DmdJs0uLkdfUI9vO2v9PnOHP6qhosKoaQNY8JyWewVW5nltG5xgmZl+Ux23Fd9a+lhYEpJYM/XbwMRBPSX+m/nw0Ix9ozV3jgxWZxDg7A5n+PKyn0COislRobeds=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkF4SEpJQllhSmJKL3ZaL3pCcDlzWjdIVTAvSnM4RjlETFI4bFplSGRJVXBr?=
 =?utf-8?B?R0traTdOZ2VoY05HdXM1NkxoVkp0eTVQYzFhVzFIOEdqS0ZaWVRCMWM4S0NU?=
 =?utf-8?B?UzZxQjdiNUJHTGt4UlVpdHBqQWZOTytJSDZONktsbyt1S3pnclo3M2xZTlF1?=
 =?utf-8?B?TnJhcHJWZjB6bE92eEoxamg1S3NFZkF5SmFiaGgreHZDZVZreEJmOTVhRWkv?=
 =?utf-8?B?S3AvWEg4TjdMeUwxUE5Hd2NoeGdEYTlmQU1tZ1p2TDBjQWo4T1MycWVybk1y?=
 =?utf-8?B?eVRTWVpFd1M2aXNSOTAyNjhFNExGMHl5c0RXajJrV3NnUFA4NzNJMUFMZTls?=
 =?utf-8?B?NXYwSnNaTmhpeWp2UzMwZm1IdWhIcjJDVkRTRmJ0blBOZTBxQ2haSHl0amZN?=
 =?utf-8?B?NDB5OGM0aEwzTXpDOEFIK09FbW9zTyt6Uy9haVFHN3h5dmpnVTAyMEZCdUpu?=
 =?utf-8?B?UlVBNjdVaEJsODBLMXdsekFoeEpHTzZrbCt0M2EvK0hvVkdjRElOZ0t2MW4v?=
 =?utf-8?B?UldSeDFzTk9qRm1uU3BJMlN3RlNrMmZEUTJ5QlBUdVl0UkFEK3BCZGNGL05Y?=
 =?utf-8?B?ajJiY1JwbVpDNG04K3ZjczJnQkU1T0lmcEo1ckZ5UEhmWDZoTGVEN0ZxYmlF?=
 =?utf-8?B?bXVTYlhDQ1pFZlc4RGZKNGRHMm1jOGNRajA0dzJhczdtUVZCR2pkakVOa3h6?=
 =?utf-8?B?cXVaSjJOM1VzQTYrNTRiMzdIbkphOHZqUjBLYUd0enE5cGZqaTZvWTZKNXdP?=
 =?utf-8?B?RXhidTRzZGViZEFUc1hMSW9LcTJzQklqNTBlQkVFcXRUQzdDbWZoVHAxRXND?=
 =?utf-8?B?Zno3Wi9SZVBjU3l0NzlkaTRIWGw2Qk9objRVdnZxaCs5dS9DTEZMRWtRYXh2?=
 =?utf-8?B?V3NxcGt3RkRCMlhyTEZZOWlQek93SjEvS1E2RnBWMG9sSnhGam5NdHl4bTI5?=
 =?utf-8?B?Nno1bW56eEVoNjMxQXNncG1FUnZ1cFRvNDU5bFgxYjF5ZFh0elFWQ1ZuWkhz?=
 =?utf-8?B?aGc3VnpBZS9VdzdnUk5LYXBoejlQNkNBMS9uTzZpZG8relhFdGIzVE5xWkph?=
 =?utf-8?B?ckM0YXZiV3pLS04zM0ZaemgzYnQxclpYeE4xUnRIV2EydjJ0RWNxNjgvYjU4?=
 =?utf-8?B?QnJ0d3hmNk44VU8wNGtaYktDZi9hSXVGa3pWQmkxK1o5dUhkZHRNcE1maitC?=
 =?utf-8?B?QVdodnUzMkdhMmJ2dFRnN3NKWWk4c1pUYzczTDdzU2hsOXUrRnc4aEc0SW9V?=
 =?utf-8?B?M2JOdFVQOU5ucnhic1dTTHJKN3F2Nlh3OU1CNnVBSGNkQkZ2YXdkR3FnaDFp?=
 =?utf-8?B?aTJIVWVvNlNLUnh4NVQ2QW9jKyt2ZHNaT2tsZFByR1RLT2RGenExVzRYd1kr?=
 =?utf-8?B?cy94ZmNMbFVxVExPUzlrSk14ZThBYlgxUzBpQ243Z01ibjhweGd4RVlEOTVT?=
 =?utf-8?B?b3N0d3BXbGJqdDlQeFltNWc1UnVzaWdUbm04VVhPeWk0MmU0czhENlVibC9u?=
 =?utf-8?B?SWlDY1B5Ulc5M3c0WjBBSHY5SHpId0xCdFFzRk5tckptNjhONDZpZnFxbUNU?=
 =?utf-8?B?c1NrZ0R0SUd0TnlwVHdqOFEwdHdEaHJvdWczdlp2ckJoclpXSUx4YkljTjdo?=
 =?utf-8?B?UUdFM3dPS3Z4dVhEMExTY3RiRzFhKzhWTVR1WkVvNzlVbUJ1cWtVV3pXVHVY?=
 =?utf-8?B?dXJ2dkl2b1h6cTBqRmZSRmMxMGFsWGVJL0JNeXFLaWl2UDZQOWdFektsdEdn?=
 =?utf-8?B?VzFiQlZsdjh2Z0FKUFhZZXFuU3lIWGpsRGhXdk9xczNnU0ZvN3Zsay9Ka1hG?=
 =?utf-8?B?elU0ejVjZ2hXb3hic1BvT3c5ZTRpVmFZd21UOGVrZktDRXB6aFVsY250TUJt?=
 =?utf-8?B?WFBKSXBVQk1rYnRpZnhibnRJWjF2eFNKZHE3TTJkN1dOR2NJcGlMakwrUEZZ?=
 =?utf-8?B?QmFRQ0gxdmUwS3B3UEtaeUdjK0JGNGhhMDBWQzg5T2w4eGV3NGhsS2xvbXBW?=
 =?utf-8?B?OHRBcTRhNXZnTVpueVYrUG5ROFJ6aVVEaEpvdTNQbXBjaUIwMCtha3R3SEZJ?=
 =?utf-8?B?WXo0bXIxZjVDVmpCV1F5bkwycGs5SGd3Y1BPOXA0c3kwZXowbWt2UWtDaUNK?=
 =?utf-8?B?Um9xNzZhV3pMYyttR0tKRVp6MXRTbStnMHpFREoxZU1qVmpKM2o3cTBUSmc0?=
 =?utf-8?B?RzQyZHFvOFZPYmtwTEVIL3dLK3IxQVFWM1hZVFdpUHQ2SUh6WXNBRkt0RUx4?=
 =?utf-8?B?QjBFSTlHOG16TVY3KzBXRm1yelFjdEZBRXV4WW9RbFpWbUtuZ0RKRE9XaUNY?=
 =?utf-8?Q?GVstNrrT8oihdMcX7H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231bb70b-8533-4889-1bfb-08df051d634a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:59:49.1110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDJGONEcZZn3xCMQLxzIslw8apM748bPJfe70HhndNsb6riM1ICKEg5s0+RXtyKQT9lT7g2GSf+koTYGo03nSA==
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

--------------9PUtMLkQovIElRxt71VyMfq3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/28/2026 9:09 PM, Christian König wrote:

> On 8/28/26 11:53, Zhu Lingshan wrote:
>> The life cycle of a user queue is managed by its
>> kref. However when destroy a userq manager,
>> the kref_put of its queues in amdgpu_userq_mgr_fini
>> may not be the last put, therefore the queues
>> could be still alive after the userq manager
>> has been destroyed, resulting in
>> userq->userq_mgr use-after-free issues.
>>
>> This commit fixes this problem by introduce a new
>> counter refs representing for the number of its queues,
>> and only free the userq_manager when refs == 0
> Clear NAK to that one as well, this is just nonsense.

It could be better to have some explanations.

I am not sure how to guarantee the put_kref in amdgpu_userq_mgr_fini
is the last put and result in kref == 0, if not the last one,
there can be userq->userq_mgr UAF bugs.

Thanks
Lingshan

>
> Christian.
>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  9 +++++++
>>  2 files changed, 39 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index e0639f844a8e..f398986a61a5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/pm_runtime.h>
>>  #include <linux/overflow.h>
>>  #include <drm/drm_drv.h>
>> +#include <linux/wait_bit.h>
>>  
>>  #include "amdgpu.h"
>>  #include "amdgpu_reset.h"
>> @@ -533,6 +534,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>  	return r;
>>  }
>>  
>> +static void amdgpu_userq_mgr_inc_refs(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +	atomic_inc(&uq_mgr->refs);
>> +}
>> +
>> +static void amdgpu_userq_mgr_dec_refs(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +	if (atomic_dec_and_test(&uq_mgr->refs))
>> +		wake_up_var(&uq_mgr->refs);
>> +}
>> +
>>  static int
>>  amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>  {
>> @@ -594,6 +606,8 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
>>  	r = amdgpu_userq_destroy(uq_mgr, queue);
>>  	if (r)
>>  		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
>> +
>> +	amdgpu_userq_mgr_dec_refs(uq_mgr);
>>  }
>>  
>>  struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
>> @@ -707,6 +721,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>  	queue->xcp_id = (fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
>>  				fpriv->xcp_id : 0;
>>  	queue->userq_mgr = uq_mgr;
>> +	amdgpu_userq_mgr_inc_refs(uq_mgr);
>>  	INIT_DELAYED_WORK(&queue->hang_detect_work,
>>  			  amdgpu_userq_hang_detect_work);
>>  
>> @@ -819,6 +834,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>  free_queue:
>>  	trace_amdgpu_userq_create_end(queue, r);
>>  	kfree(queue);
>> +	amdgpu_userq_mgr_dec_refs(uq_mgr);
>>  err_pm_runtime:
>>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>  	return r;
>> @@ -1331,6 +1347,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>>  {
>>  	mutex_init(&userq_mgr->userq_mutex);
>>  	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
>> +	atomic_set(&userq_mgr->refs, 0);
>>  	userq_mgr->adev = adev;
>>  	userq_mgr->file = file_priv;
>>  	userq_mgr->proc_ctx_allocated = false;
>> @@ -1380,6 +1397,19 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>  		amdgpu_userq_put(queue);
>>  	}
>>  
>> +	/*
>> +	 * The above amdgpu_userq_put() may not be the last put
>> +	 * of the kref of a user queue, therefore there could
>> +	 * be some queues still alive even when the userq manager
>> +	 * has been destroyed. This wait_evet() blocks
>> +	 * amdgpu_userq_mgr_fini(), so keep userq_mgr alive
>> +	 * while any queues holding it.
>> +	 *
>> +	 * This prevents queue->userq_mgr use-after-free issues.
>> +	 */
>> +	wait_var_event(&userq_mgr->refs,
>> +		       !atomic_read_acquire(&userq_mgr->refs));
>> +
>>  	xa_destroy(&userq_mgr->userq_xa);
>>  
>>  	/*
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> index 8fc73862f64e..a13d8d4dd5c7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> @@ -126,6 +126,15 @@ struct amdgpu_userq_mgr {
>>  	 */
>>  	struct xarray			userq_xa;
>>  	struct mutex			userq_mutex;
>> +
>> +	/**
>> +	 * @refs:
>> +	 *
>> +	 * Each queue increases this counter when join this manager,
>> +	 * and decreases it when leave this manager.
>> +	 */
>> +	atomic_t			refs;
>> +
>>  	struct amdgpu_device		*adev;
>>  	struct delayed_work		resume_work;
>>  	struct drm_file			*file;
--------------9PUtMLkQovIElRxt71VyMfq3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 8/28/2026 9:09 PM, Christian König wrote:</pre>
    <blockquote type="cite" cite="mid:18014f3c-5e0f-4ed7-b278-590cf60dfe03@amd.com">
      <pre wrap="" class="moz-quote-pre">On 8/28/26 11:53, Zhu Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The life cycle of a user queue is managed by its
kref. However when destroy a userq manager,
the kref_put of its queues in amdgpu_userq_mgr_fini
may not be the last put, therefore the queues
could be still alive after the userq manager
has been destroyed, resulting in
userq-&gt;userq_mgr use-after-free issues.

This commit fixes this problem by introduce a new
counter refs representing for the number of its queues,
and only free the userq_manager when refs == 0
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Clear NAK to that one as well, this is just nonsense.</pre>
    </blockquote>
    <pre>It could be better to have some explanations.

I am not sure how to guarantee the put_kref in amdgpu_userq_mgr_fini
is the last put and result in kref == 0, if not the last one,
there can be userq-&gt;userq_mgr UAF bugs.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:18014f3c-5e0f-4ed7-b278-590cf60dfe03@amd.com">
      <pre wrap="" class="moz-quote-pre">

Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  9 +++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e0639f844a8e..f398986a61a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -27,6 +27,7 @@
 #include &lt;linux/pm_runtime.h&gt;
 #include &lt;linux/overflow.h&gt;
 #include &lt;drm/drm_drv.h&gt;
+#include &lt;linux/wait_bit.h&gt;
 
 #include &quot;amdgpu.h&quot;
 #include &quot;amdgpu_reset.h&quot;
@@ -533,6 +534,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
+static void amdgpu_userq_mgr_inc_refs(struct amdgpu_userq_mgr *uq_mgr)
+{
+	atomic_inc(&amp;uq_mgr-&gt;refs);
+}
+
+static void amdgpu_userq_mgr_dec_refs(struct amdgpu_userq_mgr *uq_mgr)
+{
+	if (atomic_dec_and_test(&amp;uq_mgr-&gt;refs))
+		wake_up_var(&amp;uq_mgr-&gt;refs);
+}
+
 static int
 amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
 {
@@ -594,6 +606,8 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
 	r = amdgpu_userq_destroy(uq_mgr, queue);
 	if (r)
 		drm_file_err(uq_mgr-&gt;file, &quot;Failed to destroy usermode queue %d\n&quot;, r);
+
+	amdgpu_userq_mgr_dec_refs(uq_mgr);
 }
 
 struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
@@ -707,6 +721,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue-&gt;xcp_id = (fpriv-&gt;xcp_id != AMDGPU_XCP_NO_PARTITION) ?
 				fpriv-&gt;xcp_id : 0;
 	queue-&gt;userq_mgr = uq_mgr;
+	amdgpu_userq_mgr_inc_refs(uq_mgr);
 	INIT_DELAYED_WORK(&amp;queue-&gt;hang_detect_work,
 			  amdgpu_userq_hang_detect_work);
 
@@ -819,6 +834,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 free_queue:
 	trace_amdgpu_userq_create_end(queue, r);
 	kfree(queue);
+	amdgpu_userq_mgr_dec_refs(uq_mgr);
 err_pm_runtime:
 	pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);
 	return r;
@@ -1331,6 +1347,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
 {
 	mutex_init(&amp;userq_mgr-&gt;userq_mutex);
 	xa_init_flags(&amp;userq_mgr-&gt;userq_xa, XA_FLAGS_ALLOC);
+	atomic_set(&amp;userq_mgr-&gt;refs, 0);
 	userq_mgr-&gt;adev = adev;
 	userq_mgr-&gt;file = file_priv;
 	userq_mgr-&gt;proc_ctx_allocated = false;
@@ -1380,6 +1397,19 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 		amdgpu_userq_put(queue);
 	}
 
+	/*
+	 * The above amdgpu_userq_put() may not be the last put
+	 * of the kref of a user queue, therefore there could
+	 * be some queues still alive even when the userq manager
+	 * has been destroyed. This wait_evet() blocks
+	 * amdgpu_userq_mgr_fini(), so keep userq_mgr alive
+	 * while any queues holding it.
+	 *
+	 * This prevents queue-&gt;userq_mgr use-after-free issues.
+	 */
+	wait_var_event(&amp;userq_mgr-&gt;refs,
+		       !atomic_read_acquire(&amp;userq_mgr-&gt;refs));
+
 	xa_destroy(&amp;userq_mgr-&gt;userq_xa);
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 8fc73862f64e..a13d8d4dd5c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -126,6 +126,15 @@ struct amdgpu_userq_mgr {
 	 */
 	struct xarray			userq_xa;
 	struct mutex			userq_mutex;
+
+	/**
+	 * @refs:
+	 *
+	 * Each queue increases this counter when join this manager,
+	 * and decreases it when leave this manager.
+	 */
+	atomic_t			refs;
+
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------9PUtMLkQovIElRxt71VyMfq3--
