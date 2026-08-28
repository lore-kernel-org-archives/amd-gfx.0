Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA131C61DCB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 16:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 522F2886A4;
	Fri, 28 Aug 2026 16:26:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OeQnrLh9";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C52A886A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 16:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1j5zBpFVRfoEuAQAhdHMAv5Rd1cnwjLqm25F3Iwgi7IQ38n/mk6z9wjmgR2mISs5aGOOGGdZIvg31FS6U5sWUSP3fI7NWXGflmw67YyLtlekVpn/W1MSm1C7Xtv81IWxxWVcwIJ9PkG/NhStqnPs5kO1q8SWUtnFr+RL62vsvDcTiAh2f8ZQwZt/czTLtkhCPchnpfUD7HYYPLrxAYkByBVo2TjxATV6ozAnbKyCsu0cpY1Rwq+j2jBAzlC/xlk28JdFvmCV6SCMYJshQabUq+YAgmpg54gXzNpoMbxqLdg9YFm8CMaz87KYt6ACg8jr5khGK93R+3V4N6////OWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2fERAcsKsafbrAhk0JA4mKIreL0vdCavb2P7gZHpy0=;
 b=C461liLkq7bbBEQiZDdh6fQg64OiYYNflmaHg1ak1MNv7flQU+0er8ugfbny/YvXszpeEE6jZ79X6qnhJFBH2Fe9aMsGukAA3wUIWFD4uEQ4LPvgdXkYCG0u42mHVZDjMGYiIbqSXZrSRIyHBcOBOozrIYFCANaG9b+zzisNa1E2ffCfCcYGvrl5+WNQmNYbRGa5YFPRszKt5oJgDg9E7iUzCXuxUyNA6D5TRExFLrGaaazAsl9RjlG/kcp+WTYQ62xA4szqfHkctJLFo6BHM81nz60cca5hgPdO3GUNIwhKPdIHeH2SxW2KkjC3kwjUCqPddsZWqvCHLqPxuWoESA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2fERAcsKsafbrAhk0JA4mKIreL0vdCavb2P7gZHpy0=;
 b=OeQnrLh9DYRC9S5bbJ+yGY/c1SopMZ5W0vUhtWY8NK+qoRPNsd5wc6uAkQrqCE7Ef/045vOD97nALGSULWhbANxPPGRpPCeKm3lXA+f29+BU/DBZC27ByypomSlMRxlAywMBscF4Ol7gpQtXShl3jU6xlNJIM7l8Fuq9i7KGlqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8017.namprd12.prod.outlook.com (2603:10b6:8:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 16:26:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Fri, 28 Aug 2026
 16:26:09 +0000
Message-ID: <847308aa-e4cb-405f-9e9c-dda3e4d28eef@amd.com>
Date: Fri, 28 Aug 2026 18:26:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] drm/amdgpu: keep the userq manager alive as long as
 its queues
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
 <20260828095349.9797-3-lingshan.zhu@amd.com>
 <18014f3c-5e0f-4ed7-b278-590cf60dfe03@amd.com>
 <7f53ac18-ecb5-4eaa-8692-67b9237447b2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7f53ac18-ecb5-4eaa-8692-67b9237447b2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ca993b-8780-4783-7df5-08df0521116a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: H8I2C/kHqYg+3Zd/p6yp07LxShxltzAGyKORdSnqAgR1S9eliwJRUGyMgoHXbiu37HabEFe/OunrCgMVlsYO6+hv6uJNxTm/VnEx8rZdlNUBM7JoEV0TiMMKwlGaQZDAS/NqOBoi6q30lFq/lcHaDBOUZCCFemZmtSWWNjnJQQcPaa4TK7QHqMQ254CGByl623f7+znwn+LFo7+7VDUy1vQbA73WgyoQCrD9zCBXjircQf5hFb5Z/nxFOjaENxAGW5Y+VQQ+JYld2kB6TQqTLlDGwBONCIW8RmBa8qy+D/NLzLyGdqo8RN5g61Hry0wV3nGlIEk9OflfxxFQfyzDpqnvmSPsah7JAPhInrfjzw80lnO8gpXOXy0o2Vh6d58/OiJ9J0XyH4/6/rR1/FwkW6VwL6CZVXYggmMZZ8SEhb/p9CnOcIZWE6disAEHks4VMKhE3kuOL6Z5EBK1m+0J5ncDM+zKmbqB8VtAXha4ygVJwVuNFpRq9I3eNkfZv/qniC2N7TpllZEguCi/QA+jOmNio1dqjLAphBRpJhaUWO0Sr4BJdUCfVG0H+rBXQMqv1yqT4K3WCgp7eVOcRxr53NIZScD5SBpJjTHEOBjdAxJEpiVsP+o6wodEvJvWtWP+DyV3TlrVxbDnb/C20uOXvfcDXw9+r/O5FciSSLunQAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3J3L2RGU1RNb0VkcmsxaFJIN0JNek5SenF2enNiNStRNlZTbndFWE1HL0xJ?=
 =?utf-8?B?bTdOTjUwVVVMV1FNL3B5MlA0RVJ2UWdORENNNE0reTV4a2FIc292MUFCWFBJ?=
 =?utf-8?B?SUtOZlY5WjcyZVRENmpOaGFTcW1mRnR3RE1qM0k3WWgwWnl6c1Jqak0vN1ZO?=
 =?utf-8?B?ajZ0WmpwKzJLQzJkV2hoRTArL1VHTUUyK3hOMlhSN2hyVm9PZmFHczBvR29m?=
 =?utf-8?B?YXRhWTRCMnA1Y0NHQ1JmYTA2aE9zcndnQis0REZMc2h4ZVFkbnQ3RE1VdHRn?=
 =?utf-8?B?UzFpZ2NkSUExbGlzQ2VRcW16ZkNJWm1QZ05OcWx2bVpzWEM2L1ZPeUlTVldN?=
 =?utf-8?B?WHY5UjFERlllMEdSYWVYNjFQL0RNY0dJdzFFNWtVODBCQWZvNkpEZ0wwbGFm?=
 =?utf-8?B?YW5xUEFveUZXWmxOTGVRRVZ4emx0eWljNWo4T3h3cUZ3ZkVJMkdYMjZ6dGh1?=
 =?utf-8?B?MzN3ZGFSOFlqS3dzWGlRWk5USkxkNkRQcXlRY2xQY2FSeUozMTZsSlgwYmlF?=
 =?utf-8?B?VnFwOFdXSTkrbEVqazdHZXA5eHhJdERJOFhKOGhEdTNPWkk3MENIZWVnMzVN?=
 =?utf-8?B?VnpiTUttQmR5aUExdjA3VGp3cmhWcHZkM2JHdVZEdVluVDN3QW92ZXhnODky?=
 =?utf-8?B?ZTBDWnpZcGk0dFk4SkVyRU5qdGluVFJzK0l5MFMwMXBCRjVXb3BSR3lUNkNU?=
 =?utf-8?B?R3lUakFsZ0dUZkp6dVYwUUNTenM4VzFiWkRrMnpaUUkxVVRudnhjMm9rUzFv?=
 =?utf-8?B?KzNyVm40UHl5eXBMYlFiZzd3RjNCZjVuV3lRWTJ0czB4WVNLdDE3elNkaXV3?=
 =?utf-8?B?WnJXLyttMHFMbmphTVZIeGpWQjduWDN0RVFCZzhka0doak05TmNDVE9TTmJY?=
 =?utf-8?B?d1owSTg3T2RPSkFkQ2k0anVCTXl4ME1PbWpOVnNEOUI5dDJQeVQ1LzIzR2Za?=
 =?utf-8?B?V2RCSDJYVDBWVW8zaThia0FGdW5jZ1BNUytFc3RrbjNEMkNhWHA3YmVWK21D?=
 =?utf-8?B?bU9rTHVxTEdpTFJOVVdoY0Z6cWFhcVBCRFc4TzZGRE5jdGZhZWhLbkZOZ0xh?=
 =?utf-8?B?ZUxrWU5Zc3kvVGtnbG5wRjVLVmg5S1dGZEV2VmpBN2tpZWQyQy9wNUw2V1dk?=
 =?utf-8?B?K0IrbVJVaVJXQ3ZUVDNXS0YxNFkrUEdkY2RHR0dSTTRUNVRoSyt4Z1l0a2FM?=
 =?utf-8?B?Sm5SbUhtdTQ0TEhZUTVwMk5kYTFTOTNXUTJ0VDJzVXFOWG8wY01pczNFVC9t?=
 =?utf-8?B?NGcvWEFFZk1BcktydE1XZStPWFNLd05sdmZ3VnRlQ0NSaEI5TVBCZGNiUk5T?=
 =?utf-8?B?bGxFVVhCa29Zem9Zd1RGSFJ6QWxZQVEwc0k5RVRuck1FVGVHN2VyZmJFNTNn?=
 =?utf-8?B?ekJsSG5RSHE0VUM5cDcxUW0rUDRYMWNIWWFheXdWTnFEczhoTWRiVEZNa045?=
 =?utf-8?B?eElRSDZUQU1pMEI2eGI5NmtZQXI2RDkzU01TZE9JQnovUXRtQTN4bHJoWE9a?=
 =?utf-8?B?QjdrcWVZYWZLOHpncXpWZjdPQjlLcTFLbmozSkVwWmJhRGUvbnVaMk9GeHk5?=
 =?utf-8?B?cmM3cjdsZ2UxN0JZQ252N2xOcTFUR0doQnhoWEVLR0k1RjJwblcyeDJ2VWFR?=
 =?utf-8?B?Zm5rdWk5WCtkaEVzdFlKMGdKcjRRc3FkNEJnd1lYQ01YODZydm5FV2o0VERJ?=
 =?utf-8?B?aWtrSWp4TjJEY0RQblB5TE1HUjNIMXZnaHAreEErNGZvTVk0V1JEWUFEUmxJ?=
 =?utf-8?B?d1hrRXcvOVpaaENjVmxUQjY3YW5yU0l3emxTdjRSNnBDaTROSS9SSnZLZHI0?=
 =?utf-8?B?Qkw2dGZNczhBRVlaV3ZySFh2dlpxbU8zMFpvRDJla2UwaXNhcEEya3M0MEV1?=
 =?utf-8?B?bEhRYW1vQjB2akFCSklkaDhnc0NFekNIbTYwQkJxVE9oZ2JlN082ZjZDVlNL?=
 =?utf-8?B?TlRWb1Bmc1c4Yll2MEZqVmJCN3BRc1JmUGU5MlFwMCs0SFNHSmVJWENuVEFZ?=
 =?utf-8?B?emRPR29PbzVaY01ub2JUaW9NamViTU5nU2lSbmM4eEZ4QWsyUGdOUFEvQ3hu?=
 =?utf-8?B?U1NVV2Y3VFhydjloM3g2aW1ib0xtaVgvaElnb1RJTGUweWtqdXN2MWRKNHg0?=
 =?utf-8?B?ODNqcEhyQW42UFprUDZ2QXpHQU1QcVNydVk5QzliRy9EZmxINkkxWXljbmVD?=
 =?utf-8?B?N0tZUjVtMjNhQUJweXFnaDVhdFNFRzBPU2FualVBZUljWm1kU255UVJlL3M0?=
 =?utf-8?B?VUlIenZSdzBsbmEvbEdOTmdScUd1WTgvZ1RFRVF4UHZHUDNrSEVjbmxwR0RQ?=
 =?utf-8?Q?yLyVPNlkyjAEnSw03H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ca993b-8780-4783-7df5-08df0521116a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 16:26:09.5884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: es+g0Vnb15uTXgVOOKPoP5a2XQFvESda4BUFzspJYn7KV8VO0mYAPSFXzIOsBiGC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8017
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

On 8/28/26 17:59, Zhu, Lingshan wrote:
> On 8/28/2026 9:09 PM, Christian König wrote:
> 
>> On 8/28/26 11:53, Zhu Lingshan wrote:
>>> The life cycle of a user queue is managed by its
>>> kref. However when destroy a userq manager,
>>> the kref_put of its queues in amdgpu_userq_mgr_fini
>>> may not be the last put, therefore the queues
>>> could be still alive after the userq manager
>>> has been destroyed, resulting in
>>> userq->userq_mgr use-after-free issues.
>>>
>>> This commit fixes this problem by introduce a new
>>> counter refs representing for the number of its queues,
>>> and only free the userq_manager when refs == 0
>> Clear NAK to that one as well, this is just nonsense.
> 
> It could be better to have some explanations.
> 
> I am not sure how to guarantee the put_kref in amdgpu_userq_mgr_fini
> is the last put and result in kref == 0, if not the last one,
> there can be userq->userq_mgr UAF bugs.

The rules are actually pretty simple:

The reference is for keeping the userq alive while IOCTLs happen. And IOCTL can only happen while the file and therefor the fpriv, userq_mgr etc... are still alive.

What can potentially be is that we also need to grab a reference from a work item, but in this case the fpriv/userq_mgr cleanup functions just need to cancel and wait for the work to finish.

There should *never* be a reference grabbed from interrupt context, explicitely because releasing that reference is also not possible from interrupt context. Instead xa_lock_irqsave() needs to be used to make sure that the userq stays alive while the interrupt processing happens.

Regards,
Christian.

> 
> Thanks
> Lingshan
> 
>> Christian.
>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  9 +++++++
>>>  2 files changed, 39 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index e0639f844a8e..f398986a61a5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -27,6 +27,7 @@
>>>  #include <linux/pm_runtime.h>
>>>  #include <linux/overflow.h>
>>>  #include <drm/drm_drv.h>
>>> +#include <linux/wait_bit.h>
>>>  
>>>  #include "amdgpu.h"
>>>  #include "amdgpu_reset.h"
>>> @@ -533,6 +534,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>>  	return r;
>>>  }
>>>  
>>> +static void amdgpu_userq_mgr_inc_refs(struct amdgpu_userq_mgr *uq_mgr)
>>> +{
>>> +	atomic_inc(&uq_mgr->refs);
>>> +}
>>> +
>>> +static void amdgpu_userq_mgr_dec_refs(struct amdgpu_userq_mgr *uq_mgr)
>>> +{
>>> +	if (atomic_dec_and_test(&uq_mgr->refs))
>>> +		wake_up_var(&uq_mgr->refs);
>>> +}
>>> +
>>>  static int
>>>  amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>>  {
>>> @@ -594,6 +606,8 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
>>>  	r = amdgpu_userq_destroy(uq_mgr, queue);
>>>  	if (r)
>>>  		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
>>> +
>>> +	amdgpu_userq_mgr_dec_refs(uq_mgr);
>>>  }
>>>  
>>>  struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
>>> @@ -707,6 +721,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>  	queue->xcp_id = (fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
>>>  				fpriv->xcp_id : 0;
>>>  	queue->userq_mgr = uq_mgr;
>>> +	amdgpu_userq_mgr_inc_refs(uq_mgr);
>>>  	INIT_DELAYED_WORK(&queue->hang_detect_work,
>>>  			  amdgpu_userq_hang_detect_work);
>>>  
>>> @@ -819,6 +834,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>  free_queue:
>>>  	trace_amdgpu_userq_create_end(queue, r);
>>>  	kfree(queue);
>>> +	amdgpu_userq_mgr_dec_refs(uq_mgr);
>>>  err_pm_runtime:
>>>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>  	return r;
>>> @@ -1331,6 +1347,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>>>  {
>>>  	mutex_init(&userq_mgr->userq_mutex);
>>>  	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
>>> +	atomic_set(&userq_mgr->refs, 0);
>>>  	userq_mgr->adev = adev;
>>>  	userq_mgr->file = file_priv;
>>>  	userq_mgr->proc_ctx_allocated = false;
>>> @@ -1380,6 +1397,19 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>>  		amdgpu_userq_put(queue);
>>>  	}
>>>  
>>> +	/*
>>> +	 * The above amdgpu_userq_put() may not be the last put
>>> +	 * of the kref of a user queue, therefore there could
>>> +	 * be some queues still alive even when the userq manager
>>> +	 * has been destroyed. This wait_evet() blocks
>>> +	 * amdgpu_userq_mgr_fini(), so keep userq_mgr alive
>>> +	 * while any queues holding it.
>>> +	 *
>>> +	 * This prevents queue->userq_mgr use-after-free issues.
>>> +	 */
>>> +	wait_var_event(&userq_mgr->refs,
>>> +		       !atomic_read_acquire(&userq_mgr->refs));
>>> +
>>>  	xa_destroy(&userq_mgr->userq_xa);
>>>  
>>>  	/*
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> index 8fc73862f64e..a13d8d4dd5c7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> @@ -126,6 +126,15 @@ struct amdgpu_userq_mgr {
>>>  	 */
>>>  	struct xarray			userq_xa;
>>>  	struct mutex			userq_mutex;
>>> +
>>> +	/**
>>> +	 * @refs:
>>> +	 *
>>> +	 * Each queue increases this counter when join this manager,
>>> +	 * and decreases it when leave this manager.
>>> +	 */
>>> +	atomic_t			refs;
>>> +
>>>  	struct amdgpu_device		*adev;
>>>  	struct delayed_work		resume_work;
>>>  	struct drm_file			*file;

