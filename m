Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E43C55822
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 22:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12AA710EBF8;
	Tue,  4 Aug 2026 22:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i+tRNBcE";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 240EF10EBF4
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 22:41:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6rhfhC1KRd+Gsr37LLljGtafH8/CUCPMOu231AUvghZTQNbCtt2psy2wRH3ffXz6bkSjQDk2ra08MYSMk6xEPGER9Z/Y5hDHCvgIHPX7lHC9wgMHA+s4Ixn9eBDX4L3edH4IkNMBDkkT2e8IL1jB5BxJyn5PdCjSjIS/1TXCMTVpsv71NPcT9/DzXipBjBKFQQ8FZSFShQ+7kK3YN2DxGhF4N7dFYibAnQjDnF8DSAqha0S7YFXf/7si8NDCjEujZdkg7oZzvfhvR0JHkV0UCy4P+blemeg72aC55IiYmENGODo/f322qN+y9TIx5WWrEDBcp0Z7N9eZJ/3g+57XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARj5anRMZ7GS9B1uCaFwjhwOpzmmq4m9WvD79wmq5aw=;
 b=TQRilJpo+eDi0LFTq7WVpr+ZdK0zdM+JEpyFnDqAt/to2m/taiLOJ200SBT+Rvz2ngoLGKZ5ytm5IrNDweXBFDV4cWjJiXF9OTbhPtMrKacUh6R5tKlpqZ+2a1gT2xuWkmirn++amSKNU82X863CMl6dtu71PRFPNxEHvN9Njs3BSgRpnMEQ7JSSrIUUsy2JzXftvU3wtWGewnP2yw9wQBeFe8Yh/6rqVmH+piVykFL6soMqDLMT+svU/+zGm16OL9leNOrDuQmEraDzDabl/XqgW3EnGAi0RjNKAWPOmB4V3BUco5F9tD3gDW3benO6fMm7r3tDk8Pwv8jW78FZvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARj5anRMZ7GS9B1uCaFwjhwOpzmmq4m9WvD79wmq5aw=;
 b=i+tRNBcEZwdJqBGvlW/1/RvYseUKhMnZiAPb4lON9Srk4pgBinqciWrmp1YFfL1fkTapGcS1N4Xmk0kXlLPIVkokJ/bFawdJT9Fh74sayN7RCuQd1Jn4tIKgdm1yBORNsgu0lTA8QkidOkezfzUpEjvW853Dcf9/BH5wL2MIsk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by DS7PR12MB8229.namprd12.prod.outlook.com
 (2603:10b6:8:ea::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 22:41:20 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852%8]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 22:41:20 +0000
Content-Type: multipart/alternative;
 boundary="------------IRrdPtyfwattjL0UmC8yENgv"
Message-ID: <b145850c-579f-4893-804a-ca4869440834@amd.com>
Date: Tue, 4 Aug 2026 18:41:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: fix deadlock in set_perfcount
To: Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, "Welton, Benjamin" <Benjamin.Welton@amd.com>
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260731095105.3529371-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260731095105.3529371-1-lingshan.zhu@amd.com>
X-ClientProxiedBy: YT2PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::8) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee4423f-5962-44e6-8d4c-08def27980a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|5023799004|11063799006|8096899003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: skQGwvnQPZT/lAXR0kk129qHYXNtVSPiNT05JJm26sBsmmSxuqNQoEFyBGhPxuGPQlIxL6BG9lxm6TX4NkCHs4hksp4QVd6kieyEKYtDpNx6SByY+XnO/qnQkrk/XCN2nGzdXAQUdJuIb9f/oA8ap0NXgPgFq2Faref9geJt8N1lNBLZnt3MuyGqzM1MNxDN48dzsyYrKRCv4/n+MykpuICFjdbCYmGpZBc1pe9XKNQLswW+Evn5aJHMGDXmNvswb8XazOqZBlhl+jI+vK6pcIyo5W4uj5bjWMAvzXXatphtZMVZlPDN69Q516hQ9ILKBOqhzN+Zv/KGCs/mQxLN8aZZr5nmDpeCYhdwD5BxJAW429vpK3HID+Box7PuKz2lE7DajRcowtTVEpIGYATO5YmJr5lAFPcaejtuvDUQYTa+Au5QOMPXP3VlmgxX1st4SPn9aaoQhql9BiSDPUEp1TG6w5lbH9AfF8Byl9MGvVR1YWzFrZqLdSCBja/2IB2mAOwOtUSw7pUuJz1DPQtQgLGAToSQ9xkm5OPD3MX5an0QqR5cGQvvjVof8dnvL8/IdR1bVFYJ5IF2fPJu7/0jZfi0noBYTuUp7LlIPymz+Q40M5hpTGy5uUCHXbDSXsJKLWpt2QQH0EhOZZaeqLGvv+ANYLrf9RAucQsTHyXJqHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(5023799004)(11063799006)(8096899003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW8yL3NjZnlra2ZPS3AyQTZ4VGIvdEx2dVV5YmVSRDRPQXJRdU1lWG5IWHJG?=
 =?utf-8?B?SkdDOUNMdEdaZHZxK1RtbGVhZDNUbWErV3JsQk5rVzJVNDNONTdVV09SRVVj?=
 =?utf-8?B?T1NPSjJXK243SE9KeXBIZE1qSmVRNnp3WVkvVW9Bc1VUbitrVkhNUGY5cFRC?=
 =?utf-8?B?cmV4VC9qWWVYN3hwYWJuaWpla1ViT0tMRGJZckpiNW5xT3pTMFE4MXVIUCta?=
 =?utf-8?B?ZmxLQWVyak45VmlMbXozcTkydmxZRGdDOWd5RTcyc283NmNSbFNCUVpPcXQz?=
 =?utf-8?B?UnA4cDV2cEtWUGErVFNzT0daTVhoMmM1Tms2ekZTTnhnOUFwMzhDalpHc1ZO?=
 =?utf-8?B?WmFzWDREQ0IxZ3V1dllwZkxwS1p6R2llbGtkdCtTVCs3VkwxNzYrRzk5NVBw?=
 =?utf-8?B?Q3UwVkczY3R2R0lZRWIxa2JuY3FrV3Z1Y2gxQXIvbExvYTJ2QVg5UGdRNWsy?=
 =?utf-8?B?QTZwNkM4VjJlVktzS3FTSDNsNjdBNXEwcW1RR2VVaXN0U0Y3ZlQ5OXpnallr?=
 =?utf-8?B?eVhNNVJHemtueFduRFZ5TFhTK2YxWWlLQjRSaStFbVE5M09sL21HTzdnN0hQ?=
 =?utf-8?B?UERVblZvMDcrQ3J6Q3dya0xWTndvRnZhU29VYjk0OTN1ck40MVQ5ODUvMnYz?=
 =?utf-8?B?cE16cXVrZ0U2dERYU0dVMWhXaFBUVUs3R0hoeTI0RnZVVFd2QU05cXMreEFp?=
 =?utf-8?B?NzIvK2JlT3JGY3dBdEFUUFYxQ3JFTzl3VlJ2bVFwYzM4ajFHaWFDVm01dzNt?=
 =?utf-8?B?V1JWT2ZyaVFQLy94OGE4SVowSnBSMVA0ZXN3dzVmRUVQMVhkalJLZ2JmR0NQ?=
 =?utf-8?B?YkNrNHY1ZEZOb3Q5REk5QTFJamtkUE42TjlkOHoxcmtDbk1ndlJDNEFFdHVy?=
 =?utf-8?B?L3FGK1JYcCtkZzVDRytHZzNaajNnUXRMckNTZXdtcFoyZXFhekw2WHZtRldh?=
 =?utf-8?B?b0JYenM2VTJJRTFadVFIYlN0WFdGdDUyNjRCNXdndCtKUFMzWXdHN2xuWXY5?=
 =?utf-8?B?VTdsY2phTE5yUklKbnBRSWFJTno0Wmt2TlVYUTJIT3JvbGJWYWhVTld6OHRp?=
 =?utf-8?B?MENvNVBubm5LMmZkNnY5bHQ2anl5dGFvdXhOWTdFdzVlVmgwRjhPZ3FXZEs3?=
 =?utf-8?B?b2RLclZMVm81MGdqL2xPUHdGNUFkamkzUEFHeWkrMm0wNFNSMGZQYVZkbzBP?=
 =?utf-8?B?bXhjUmxSd1Qya2RNSGtkVS9VSFBjczdUcmpaWXZSTjh3OFRnU1VhWFAvazBQ?=
 =?utf-8?B?MFVnZlNwVnBwYjNhTFMzZk1JNUd6dnEyRzdpMXpnRTJKRXo1VTV6YWR3MUpq?=
 =?utf-8?B?bGd0SHpDRUM1ZzVxdlBNekVoYkE4UDdob05saVczSTFvT2orOFl0azRnMFpU?=
 =?utf-8?B?ZThHZm5yZTBtU2NLTW50UnQxL3UyOEhac08wS09IdFlQdldQWHcxakxaaGpW?=
 =?utf-8?B?czFQQS92WTZaK1pwTDY4OTAyU2pPRmk5Yjl6TTYrVHVlak9JTVZ3QVZTWGsx?=
 =?utf-8?B?cW00YjdDbWg2VmM2bUlpVnJhY1o3NmdBQUhrVVBWY1J1WG1iWG52TVhVUDFh?=
 =?utf-8?B?L1E3dzJkRlZhbjB4aDVhTUtqVHphL3YwSnEvNmUwamQyTzVoRlB5cFA5bzRy?=
 =?utf-8?B?L3lpOUJXcnI5TlFycUU0enJCT2xYcEFRemNRY2k1ODRTTlFYQlhFaldzZkdD?=
 =?utf-8?B?b3pVL3o0SXpML1VDTW5BbVBIak5BRit0ZkNvVUh6R0MrTjFHNDBjZ01vS2Jo?=
 =?utf-8?B?blllZE5TbkxoOUJPZzJuNUdhM3VFMGtIUEJvcTV1am1RL1hlbEdMdDJjaGcv?=
 =?utf-8?B?ZGdseHR0MDBHN0dKWk9UZ0Exb0dTdHFaZzN4T0FnYTd0ekJ3THZ6dUxvRGpY?=
 =?utf-8?B?WENWaUtDdGsvWVduRmpOc3lhZ01aR2NKd2dhUkM2YkdqT21uVXNub1ZSMGtr?=
 =?utf-8?B?S0xMeGpMeG1BUDZ5dnh6R2pYamkrWHpJNkpNZm9WSlcvZG1ORmNoRHp3OGp3?=
 =?utf-8?B?QmwwUGFzcVM4T1NhN1Jmc01raThYbWVRek5uYmU4dysrUlB2K1NjdDV2YjNu?=
 =?utf-8?B?aGFvcS9yYlJVQlJxeU1lLzR3cng3YStIVmlCTXFHdlNkVitKZnFjMTA1clBr?=
 =?utf-8?B?cFpna1Nna2ZabC9CN2lWWEh1RG51ZFo2OSt1NnpVVzErTXBSNWFxTDZtNkRZ?=
 =?utf-8?B?SjRWaU0rNU1ycG4xcDVxQkd5a0tBSGh6OWtTdFArbG5PbEVhcW1zOE45L3JX?=
 =?utf-8?B?V21rRWpjaHR0OUcvZ294UnJPWHVCSEtJaFYyVW9ZTUZoa0hVa0hmNGl2TVpY?=
 =?utf-8?B?K1AvZm93UE9ySElpSUhPby9pSUpTR1lSSWdDc3hxYW91WXVaQTNTUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee4423f-5962-44e6-8d4c-08def27980a0
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 22:41:19.8032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvBLockhBvnPQKfNRmso1O9cIWijzctZqmFN3Dk3Lqf4t5gczOAQ94in+SuDNobVSZsxEbqxpzxKlY+ldGswhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229
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

--------------IRrdPtyfwattjL0UmC8yENgv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[+Benjamin]

On 2026-07-31 05:51, Zhu Lingshan wrote:
> set_perfcount holds the DQM lock (dqm_lock(dqm)
> while walking queues, but pqm_update_mqd
> calls update_queue, which acquires the
> same lock by dqm_lock(dqm), causing deadlocks.
>
> This commit introduces update_queue_locked which assumes
> the dqm lock is already held, and update_queue calls it
> with proper lockings.
>
> set_perfcount calls update_queue_locked instead of pqm_update_mqd,
> therefore the deadlock is fixed.

I think the patch looks fine to me. I'm just wondering how this bug was 
not noticed in developer testing of this feature. I see a very similar 
patch already exists on the DKMS branch but somehow it's missing in 
amd-staging-drm-next:

commit 5cd0710732a45527b6398f8b522289f9adca708b
Author:     Benjamin Welton<bewelton@amd.com>
AuthorDate: Mon Jan 6 10:30:01 2025 -0800
Commit:     Chengjun Yao<Chengjun.Yao@amd.com>
CommitDate: Mon Jun 22 12:51:06 2026 +0800

     amd/amdkfd: fix double lock aquisition in set_perfcount
     
     Seperates out locking from update_queue to allow updating
     of queues by code already holding the mqd lock. Fixes a
     hang in set_perfcount. This change was in the original
     mailing list commit for set_perfcount but was not included
     in gerrit.
     
     Fixes: b58289f0abf7 ("Add kfd_ioctl_profiler to contain profiler kernel driver changes")
     
     Signed-off-by: Benjamin Welton<benjamin.welton@amd.com>
     Acked-by: Kent Russell<kent.russell@amd.com>


Benjamin, do you know what's going on here? I think the above patch just 
needs to be ported to amd-staging-drm-next. But then I'm wondering what 
else is missing. Or maybe the whole feature was submitted to 
amd-staging-drm-next by mistake.

Regards,
   Felix


>
> Signed-off-by: Zhu Lingshan<lingshan.zhu@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 44 ++++++++++++-------
>   1 file changed, 27 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 51ee9c39104b..c34c5f6a5541 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -77,6 +77,9 @@ static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *
>   static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
>   			       struct qcm_process_device *qpd);
>   static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q);
> +static int update_queue_locked(struct device_queue_manager *dqm,
> +			       struct queue *q,
> +			       struct mqd_update_info *minfo);
>   
>   static inline
>   enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)
> @@ -341,8 +344,7 @@ static void set_perfcount(struct device_queue_manager *dqm, int enable)
>   	list_for_each_entry(cur, &dqm->queues, list) {
>   		qpd = cur->qpd;
>   		list_for_each_entry(q, &qpd->queues_list, list) {
> -			pqm_update_mqd(qpd->pqm, q->properties.queue_id,
> -						&minfo);
> +			update_queue_locked(dqm, q, &minfo);
>   		}
>   	}
>   	dqm_unlock(dqm);
> @@ -1059,8 +1061,9 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
>   	return retval;
>   }
>   
> -static int update_queue(struct device_queue_manager *dqm, struct queue *q,
> -			struct mqd_update_info *minfo)
> +static int update_queue_locked(struct device_queue_manager *dqm,
> +			       struct queue *q,
> +			       struct mqd_update_info *minfo)
>   {
>   	int retval = 0;
>   	struct device *dev = dqm->dev->adev->dev;
> @@ -1068,12 +1071,11 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
>   	struct kfd_process_device *pdd;
>   	bool prev_active = false;
>   
> -	dqm_lock(dqm);
> +	lockdep_assert_held(&dqm->lock_hidden);
> +
>   	pdd = kfd_get_process_device_data(q->device, q->process);
> -	if (!pdd) {
> -		retval = -ENODEV;
> -		goto out_unlock;
> -	}
> +	if (!pdd)
> +		return -ENODEV;
>   	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>   			q->properties.type)];
>   
> @@ -1089,14 +1091,12 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
>   			retval = remove_queue_mes(dqm, q, &pdd->qpd);
>   
>   		/* queue is reset so inaccessable  */
> -		if (pdd->has_reset_queue) {
> -			retval = -EACCES;
> -			goto out_unlock;
> -		}
> +		if (pdd->has_reset_queue)
> +			return -EACCES;
>   
>   		if (retval) {
>   			dev_err(dev, "unmap queue failed\n");
> -			goto out_unlock;
> +			return retval;
>   		}
>   	} else if (prev_active &&
>   		   (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
> @@ -1105,7 +1105,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
>   
>   		if (!dqm->sched_running) {
>   			WARN_ONCE(1, "Update non-HWS queue while stopped\n");
> -			goto out_unlock;
> +			return -EIO;
>   		}
>   
>   		retval = mqd_mgr->destroy_mqd(mqd_mgr, q->mqd,
> @@ -1115,7 +1115,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
>   				KFD_UNMAP_LATENCY_MS, q->pipe, q->queue);
>   		if (retval) {
>   			dev_err(dev, "destroy mqd failed\n");
> -			goto out_unlock;
> +			return retval;
>   		}
>   	}
>   
> @@ -1163,8 +1163,18 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
>   						   &q->properties, current->mm);
>   	}
>   
> -out_unlock:
> +	return retval;
> +}
> +
> +static int update_queue(struct device_queue_manager *dqm, struct queue *q,
> +			struct mqd_update_info *minfo)
> +{
> +	int retval;
> +
> +	dqm_lock(dqm);
> +	retval = update_queue_locked(dqm, q, minfo);
>   	dqm_unlock(dqm);
> +
>   	return retval;
>   }
>   
--------------IRrdPtyfwattjL0UmC8yENgv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>[+Benjamin]</p>
    <div class="moz-cite-prefix">On 2026-07-31 05:51, Zhu Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260731095105.3529371-1-lingshan.zhu@amd.com">
      <pre wrap="" class="moz-quote-pre">set_perfcount holds the DQM lock (dqm_lock(dqm)
while walking queues, but pqm_update_mqd
calls update_queue, which acquires the
same lock by dqm_lock(dqm), causing deadlocks.

This commit introduces update_queue_locked which assumes
the dqm lock is already held, and update_queue calls it
with proper lockings.

set_perfcount calls update_queue_locked instead of pqm_update_mqd,
therefore the deadlock is fixed.</pre>
    </blockquote>
    <p>I think the patch looks fine to me. I'm just wondering how this
      bug was not noticed in developer testing of this feature. I see a
      very similar patch already exists on the DKMS branch but somehow
      it's missing in amd-staging-drm-next:</p>
    <pre>commit 5cd0710732a45527b6398f8b522289f9adca708b
Author:     Benjamin Welton <a class="moz-txt-link-rfc2396E" href="mailto:bewelton@amd.com">&lt;bewelton@amd.com&gt;</a>
AuthorDate: Mon Jan 6 10:30:01 2025 -0800
Commit:     Chengjun Yao <a class="moz-txt-link-rfc2396E" href="mailto:Chengjun.Yao@amd.com">&lt;Chengjun.Yao@amd.com&gt;</a>
CommitDate: Mon Jun 22 12:51:06 2026 +0800

    amd/amdkfd: fix double lock aquisition in set_perfcount
    
    Seperates out locking from update_queue to allow updating
    of queues by code already holding the mqd lock. Fixes a
    hang in set_perfcount. This change was in the original
    mailing list commit for set_perfcount but was not included
    in gerrit.
    
    Fixes: b58289f0abf7 (&quot;Add kfd_ioctl_profiler to contain profiler kernel driver changes&quot;)
    
    Signed-off-by: Benjamin Welton <a class="moz-txt-link-rfc2396E" href="mailto:benjamin.welton@amd.com">&lt;benjamin.welton@amd.com&gt;</a>
    Acked-by: Kent Russell <a class="moz-txt-link-rfc2396E" href="mailto:kent.russell@amd.com">&lt;kent.russell@amd.com&gt;</a>
</pre>
    <p><br>
    </p>
    <p>Benjamin, do you know what's going on here? I think the above
      patch just needs to be ported to amd-staging-drm-next. But then
      I'm wondering what else is missing. Or maybe the whole feature was
      submitted to amd-staging-drm-next by mistake.</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260731095105.3529371-1-lingshan.zhu@amd.com">
      <pre wrap="" class="moz-quote-pre">

Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 44 ++++++++++++-------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 51ee9c39104b..c34c5f6a5541 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -77,6 +77,9 @@ static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *
 static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
 			       struct qcm_process_device *qpd);
 static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q);
+static int update_queue_locked(struct device_queue_manager *dqm,
+			       struct queue *q,
+			       struct mqd_update_info *minfo);
 
 static inline
 enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)
@@ -341,8 +344,7 @@ static void set_perfcount(struct device_queue_manager *dqm, int enable)
 	list_for_each_entry(cur, &amp;dqm-&gt;queues, list) {
 		qpd = cur-&gt;qpd;
 		list_for_each_entry(q, &amp;qpd-&gt;queues_list, list) {
-			pqm_update_mqd(qpd-&gt;pqm, q-&gt;properties.queue_id,
-						&amp;minfo);
+			update_queue_locked(dqm, q, &amp;minfo);
 		}
 	}
 	dqm_unlock(dqm);
@@ -1059,8 +1061,9 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
 	return retval;
 }
 
-static int update_queue(struct device_queue_manager *dqm, struct queue *q,
-			struct mqd_update_info *minfo)
+static int update_queue_locked(struct device_queue_manager *dqm,
+			       struct queue *q,
+			       struct mqd_update_info *minfo)
 {
 	int retval = 0;
 	struct device *dev = dqm-&gt;dev-&gt;adev-&gt;dev;
@@ -1068,12 +1071,11 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 	struct kfd_process_device *pdd;
 	bool prev_active = false;
 
-	dqm_lock(dqm);
+	lockdep_assert_held(&amp;dqm-&gt;lock_hidden);
+
 	pdd = kfd_get_process_device_data(q-&gt;device, q-&gt;process);
-	if (!pdd) {
-		retval = -ENODEV;
-		goto out_unlock;
-	}
+	if (!pdd)
+		return -ENODEV;
 	mqd_mgr = dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_type(
 			q-&gt;properties.type)];
 
@@ -1089,14 +1091,12 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 			retval = remove_queue_mes(dqm, q, &amp;pdd-&gt;qpd);
 
 		/* queue is reset so inaccessable  */
-		if (pdd-&gt;has_reset_queue) {
-			retval = -EACCES;
-			goto out_unlock;
-		}
+		if (pdd-&gt;has_reset_queue)
+			return -EACCES;
 
 		if (retval) {
 			dev_err(dev, &quot;unmap queue failed\n&quot;);
-			goto out_unlock;
+			return retval;
 		}
 	} else if (prev_active &amp;&amp;
 		   (q-&gt;properties.type == KFD_QUEUE_TYPE_COMPUTE ||
@@ -1105,7 +1105,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 
 		if (!dqm-&gt;sched_running) {
 			WARN_ONCE(1, &quot;Update non-HWS queue while stopped\n&quot;);
-			goto out_unlock;
+			return -EIO;
 		}
 
 		retval = mqd_mgr-&gt;destroy_mqd(mqd_mgr, q-&gt;mqd,
@@ -1115,7 +1115,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 				KFD_UNMAP_LATENCY_MS, q-&gt;pipe, q-&gt;queue);
 		if (retval) {
 			dev_err(dev, &quot;destroy mqd failed\n&quot;);
-			goto out_unlock;
+			return retval;
 		}
 	}
 
@@ -1163,8 +1163,18 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 						   &amp;q-&gt;properties, current-&gt;mm);
 	}
 
-out_unlock:
+	return retval;
+}
+
+static int update_queue(struct device_queue_manager *dqm, struct queue *q,
+			struct mqd_update_info *minfo)
+{
+	int retval;
+
+	dqm_lock(dqm);
+	retval = update_queue_locked(dqm, q, minfo);
 	dqm_unlock(dqm);
+
 	return retval;
 }
 
</pre>
    </blockquote>
  </body>
</html>

--------------IRrdPtyfwattjL0UmC8yENgv--
