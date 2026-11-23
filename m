Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DAD606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XkMlvHWa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC87710EFD6;
	Mon, 23 Nov 2026 16:26:29 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7306910EFE8
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 16:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zp8xWxta7ErvcMH0EbjAfN5kRVdIX24k9JRAsmLIVA1ZfdVCkKgGWreQxF3uNTkID2slAujkMVye/FFWgwHD4/q7OqucwMTPoIDIIePzvNErWu/NEWbWpHpTmfddo7xKXgRCBx+5EEsHzm4sNKgoX9VhqVhtSTbfKYBId7GRYdGCgN6nGrYmncuBlmgfrfSeLwmWToezP62x8yWPEIufa06G5z30jNPm1zYCUGdHWoT0NCdIe4R/LqX4VDWrMJOjt99fXZuNzvy/kuICRZhxYbMzvwndSP35PQQV5PSiIsp9dAbTGLjaIw9Lr+PaeLGjprJrEs0fbELmjP/z2d+Cig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHpxvbY2ZVsbrPtQKA9chnvtTRBg6MdbbcqMpyPUaeU=;
 b=ubhOdFY/LW/MBcDU50vMoD4bnZ9CwkDV7Qa+4cebCiD/FZ/4HZgUyRbTQ4O8uWUotzRPMPIzcD0N4yT6PaMJR9YqCSd3qhUvrDOp3ZooxAX+TzV+fKwxkJ7fX1sIaTapbjJL2N2dL97gX52x75jbOi0bNg/ePSqsktE/70BEreg7jqHbL7U6gQep2glSldJOWQHJjvLlPNKidutAKuQm+t4i8hwcFsze3KIhKzmElLx0mX0iY6Katqla0gx9Z8lwjsyCsMstSnbVFvMqTtNK5dLWx+5oIZlEAIcif6kShoapYc5fAK3W27SiM25Ni8cslda3XitaZ+nU3ER5/lsT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHpxvbY2ZVsbrPtQKA9chnvtTRBg6MdbbcqMpyPUaeU=;
 b=XkMlvHWakCBOeuVb5/mUIv0cUNDewVtPyW9cnWjqrNMIV1EBYUcGZwXtkQZt9mZaZxqSX4cLjyBE/bVf4fbMjOEiPt2y6cURtzL3OfvUjN8MGMao+/zikxym1OiECpp6K/kvUDlIrdrC6sEmR/KCdFoJmUZsquZ8zDSN8LIit2o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 16:25:07 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 16:25:06 +0000
Content-Type: multipart/alternative;
 boundary="------------ESJhuD4reYZVipRoYXwU0rFu"
Message-ID: <55d76e0a-f2c0-402d-98ba-de9a54d569d6@amd.com>
Date: Mon, 23 Nov 2026 11:25:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: don't give a GPU access to SVM ranges when no VM
To: Zhu Lingshan <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20261123094229.12597-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261123094229.12597-1-lingshan.zhu@amd.com>
X-ClientProxiedBy: YQZPR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::16) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b71ecb-9a23-41f6-f199-08df497e55c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: J7ebIXdkEAdhhqspk9SvQsh/WQhff17B+om+5VxTmDT3VIqXHgy1qDEe8QXuC3w1cm1+KWrE8kQT7fYiJQ0qefFWB0Al3ilCe/3igY5TTLEIBmRecBQcyrc5jRL+/D+Y9XZ8f938IurPAoJNfnVSzNSOn9bOKPkfc+XbBAWhfrvRPFfBjIBvz2IHBX1gBhnQwNoJHOM897s5HoRDtFY6MNfX7deeAmtUzF75Af3q4xALBsIdMwAPf7g+WpDbp9H9ng/koHy4NTaurNdV1zoIwvFQBOKevtfTZdUStq7oZGMk1N+yox8Qy9AmFGTa8dDQR6o/wI2hMXtbmzD8vdn4gVsYNf19Za4pU/DK0cE71B+PTOpQ67ivKdq1tKNAXWy1lLgpWOkslx0okBc4MG2cTMwCiUyzKTkpaqCDVyq+yusPdyydYpRTGZx3Gr9C6Qwn3/3bAmHGuLRjBPVAQis5eCbPpFxTsEyABAeBgaZg1aSBNYlsxly2xDHPsKGdx7UhS8uT+DBdO+L+welw4sKddrHjjpZNEgg+Oe3xPw6Lc+SPrpFqzNw4FF0sV3nN30XxZlL31Zrz9V4T4VLfJhwX5Ena09omFuUwBu12/h9yo/TAjDecfIAkiriZC0MBtn0WbZcVhITBRWFK1FIkyUfUy0Dl0vRMTraRbsuU+F7gaaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0J2dkZBcnVxSENNZDVhbHFDUHlBTXFIRW1IcFREVGZXemxMZm9EKzNicW9u?=
 =?utf-8?B?TFRLdFlZSlMxVlpGUkRmSDFRSXF0NFpwelRESG1kdHBMbUxrR3Nmd2J5dEZF?=
 =?utf-8?B?TkxWTDdXYmRpZFRpbWxyZENFZjJVVWlsYmNvS0w1M2QvWGwxWmtGbjZ3cW5o?=
 =?utf-8?B?dVVHZXJEcERYcDJhcDF2TlVqaU9SK0pTVklUVm4zd0xDZGxhWG1yQ0hVeXZk?=
 =?utf-8?B?NjJwVE95OHZLb0lMbmtUYU1ETndtaDlTbUxnTmdnSFhEeDBVMURFQmVqa1o4?=
 =?utf-8?B?ZFJJQW5GQ2xtaDJPclljc3pSd2IwakhJT1FEdnp4MXNXS0NPRjBkWWZuRGl6?=
 =?utf-8?B?YWxVQm0rc1RpMUxuT3EyWFEvajNqN21FeThrZkxQUjBJQ1JrVEtjeFdlanlL?=
 =?utf-8?B?c2NCaFVxK21HZ092MmgwTGNyc2FEc01oRVRLSzdmTEdMQjBscVBQQ1pDLzM5?=
 =?utf-8?B?b1FYUjF5QjNhYVZXUitLOElPc3JDVDdLdGp0ZStUMW9aWi90TFllQ0sxNlNQ?=
 =?utf-8?B?akhlekNSSTVnZGFTelo1VzZ1MXZUWTd2U2RLb0FTL1V4anUydFM3SDRCT3Mr?=
 =?utf-8?B?eWIwdU1RNklOMHVYOHFkWUU5akhlbUpEVDY4TnVBQWxQY3o1Y2xOSHljeGtG?=
 =?utf-8?B?SENidlNId2MyaFVudnQ5MHhhMFFQZTN0U21uSU8vc3gyc0g0bXhGcG9URkVi?=
 =?utf-8?B?ZXBvOFUzVkUvWjlVTk5XaWNpV1VhMTFRZ0N0aExnVjYxcmlqWmFpbllUTC9K?=
 =?utf-8?B?N05WNlh0dHB4eUtSSUNXUlllSGZmUEdkSzJidzBlV1hlbUpPRUN0OSs3di9R?=
 =?utf-8?B?WU1PNXFtbWF3RUtxSWRRNFpBZUh4Qm9EV0l1VnluU092RGxPaDhDaElWanE3?=
 =?utf-8?B?QW9XamVLWkpTWDhSWUZzRzFFbENzQzF3aWZTSVlTbFdkYUNLdWlEa2ZobGo4?=
 =?utf-8?B?alFuMS94WkdQOXl3aEFzQ1pyNUtKRnVncXN1b3NPYyszNnEyMXBEZU8rdXVI?=
 =?utf-8?B?eWhwRUttN1VxY3hVeXlhenJGbzRHRk0wQWE3S1FTbTJ3SHViNmJlLzNUbStk?=
 =?utf-8?B?aWI1anp1cGdnWGZ0VHIvNkRBaEM1SS9XMEdOMGZScWhjRENJdDVXbU00NFRD?=
 =?utf-8?B?bndrVEQ5eVNDc0ZOME5LdDZzV3cwdm9OUTJWTyt5a0VsYUU2ZDQ3WXhQTk5j?=
 =?utf-8?B?MTVwY1YvT3UyMzk5cXNWak13QTl2YjVJWDVsd04rUnFBU2RGSWlTa1Zkc215?=
 =?utf-8?B?ZytmbzljL3VNZ2ZROUJwUTFhdks2aHl4c3hJQUJhMnlYYU9vekJydm9pT1N0?=
 =?utf-8?B?RWZ2dW51cWo1VVNId3MzanMwdVBiY2dEeXBiMFpnSlVvY1NNL2JISHY5RC9z?=
 =?utf-8?B?aEs0TzFQQ1cxS0t0NlVUQW5UVEdxL2dUNXlyYVJqdlJ0a0JlYzRpTXArUXJO?=
 =?utf-8?B?YTZKR2ZYZDl6WURZOWltTEFBbmhWWHVJL3N6MUYzNDJRZnNwRnR0NTFMOUtP?=
 =?utf-8?B?SXpNNXpaamM0bTlyWGR6OFJhdGh6cGJXc2NjK3Y5UXpBWlNSa3hxYlU3Qml5?=
 =?utf-8?B?MGZTTmFGZDdJTWJYSjkvWDc1eWtNbkF3djhaMkZkVDVZUE02TXBGVUhjbllK?=
 =?utf-8?B?VXRVU3hzeHdtYmRYck9mWnAwY0hJaTZPTmp1MUVjRHFLUFAxbldlOEtoa1h6?=
 =?utf-8?B?OE9xZEpDZ0JqMkNEOHlpZldXaGFKQTlrbUFYMVh2dGNTeTRoZ3h4U3JOK3pT?=
 =?utf-8?B?QUk0aUVBR3h3RHFIdk95ZndIYTNMbkF3VmpQWGFVNnNqSEtnY01taEhuOGdU?=
 =?utf-8?B?SGJ3bDVSOW5Tc3ZBUk5lVUxsWDUxSjRPbG9hMURQZjVoS2tZamEzMkJxVjNp?=
 =?utf-8?B?L0JaUDhKamlqNlp0OE9HUUoyS0pHVUt3L3gvS2psNzNZTFlRZW1GUFZFZ0lh?=
 =?utf-8?B?N1o4eURUSmo0L1I1ekpvUEE4Qlp0ZlJ2RGJicklmRjNZVTdDb3NHSlI5R0Rt?=
 =?utf-8?B?Ujg3U3Z3bVVvQzJjcW5hL0c1UnZHL29iY1BtUzE4eTlKSE9pdnpsK2o0SkZ3?=
 =?utf-8?B?SDk4NEE0VFdwYWFDaHRsUGROdk1senRScWg2VXREbmFpVmRwM0dPbldKNHE0?=
 =?utf-8?B?Q3JWdnRVYmx6c2FEd1h6dnUyd3pmbWlGWlVFNStBNDJLcDB6V3FzOHhHY1Nw?=
 =?utf-8?B?QVFFV1dLYnEyNkZlSCt2QnVYc1NYdWpENFJLT1BVYUFoZHdSSGNvRTRkWjc5?=
 =?utf-8?B?YUtRN2tOWDR2b1VmSDEyOUFMQ0ZNL3czVmROWVFBaTZTVlM0eFo5bUhQNWNq?=
 =?utf-8?Q?Loi7yq0CuMZctv3gyh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b71ecb-9a23-41f6-f199-08df497e55c0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 16:25:06.4963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gDIaPiBdOJBd9aSPIEkt2AGiq4fCbZPzvWOI6t6EZ9fq2GP2xQ+/vnEKeBRpyCc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------ESJhuD4reYZVipRoYXwU0rFu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-11-23 04:42, Zhu Lingshan wrote:
> If a kfd process does not perform ACQUIRE VM for its
> kfd_process_device, the VM of the pdd is NULL.
>
> This commit fails svm_range_check_attr() with -EINVAL,
> before it changes anything when VM is null of a pdd.
>
> When XNACK is enabled, this commit does not give GPUs that
> have not acquired a VM default access to new svm ranges.
>
> Signed-off-by: Zhu Lingshan<lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 7401b7fdcb57..6e42b358ad59 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -339,6 +339,7 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	uint64_t size = last - start + 1;
>   	struct svm_range *prange;
>   	struct kfd_process *p;
> +	int i;
>   
>   	prange = kzalloc_obj(*prange);
>   	if (!prange)
> @@ -367,9 +368,17 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	mutex_init(&prange->migrate_mutex);
>   	mutex_init(&prange->lock);
>   
> -	if (p->xnack_enabled)
> +	if (p->xnack_enabled) {
>   		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>   			    MAX_GPU_INSTANCE);
> +		for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
> +			if (!p->pdds[i]->drm_priv) {
> +				pr_debug("GPU %d has no VM acquired, skip mapping SVM range [0x%llx 0x%llx] to it\n",
> +					 p->pdds[i]->user_gpu_id, start, last);
> +				clear_bit(i, prange->bitmap_access);
> +			}
> +		}
> +	}
I suspect this issue is caused by a low-level test application that 
doesn’t initialize KFD through the Thunk.

Could we update svm_range_list_init() to check for drm_priv before 
marking SVM as supported? With that check in place, this change and the 
other related change below may no longer be necessary.

@@ -3468,7 +3468,8 @@ int svm_range_list_init(struct kfd_process *p)
         spin_lock_init(&svms->deferred_list_lock);

         for (i = 0; i < p->n_pdds; i++)
-               if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
+               if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev) &&
+                   p->pdds[i]->drm_priv)
                         bitmap_set(svms->bitmap_supported, i, 1);

          /* Value of default granularity cannot exceed 0x1B, the

Regards,
Philip

>   
>   	svm_range_set_default_attributes(svms, &prange->preferred_loc,
>   					 &prange->prefetch_loc,
> @@ -722,6 +731,13 @@ svm_range_check_attr(struct kfd_process *p,
>   			break;
>   		case KFD_IOCTL_SVM_ATTR_ACCESS:
>   		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
> +			gpuidx = kfd_process_gpuidx_from_gpuid(p, val);
> +			if (gpuidx >= 0 && !p->pdds[gpuidx]->drm_priv) {
> +				pr_debug("GPU %d has no VM acquired, so SVM does not work on it, please acquire VM for it first\n",
> +					 val);
> +				return -EINVAL;
> +			}
> +			break;
>   		case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
>   			gpuidx = kfd_process_gpuidx_from_gpuid(p, val);
>   			break;

--------------ESJhuD4reYZVipRoYXwU0rFu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-11-23 04:42, Zhu Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261123094229.12597-1-lingshan.zhu@amd.com">
      <pre wrap="" class="moz-quote-pre">If a kfd process does not perform ACQUIRE VM for its
kfd_process_device, the VM of the pdd is NULL.

This commit fails svm_range_check_attr() with -EINVAL,
before it changes anything when VM is null of a pdd.

When XNACK is enabled, this commit does not give GPUs that
have not acquired a VM default access to new svm ranges.

Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7401b7fdcb57..6e42b358ad59 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -339,6 +339,7 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	uint64_t size = last - start + 1;
 	struct svm_range *prange;
 	struct kfd_process *p;
+	int i;
 
 	prange = kzalloc_obj(*prange);
 	if (!prange)
@@ -367,9 +368,17 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	mutex_init(&amp;prange-&gt;migrate_mutex);
 	mutex_init(&amp;prange-&gt;lock);
 
-	if (p-&gt;xnack_enabled)
+	if (p-&gt;xnack_enabled) {
 		bitmap_copy(prange-&gt;bitmap_access, svms-&gt;bitmap_supported,
 			    MAX_GPU_INSTANCE);
+		for_each_set_bit(i, svms-&gt;bitmap_supported, p-&gt;n_pdds) {
+			if (!p-&gt;pdds[i]-&gt;drm_priv) {
+				pr_debug(&quot;GPU %d has no VM acquired, skip mapping SVM range [0x%llx 0x%llx] to it\n&quot;,
+					 p-&gt;pdds[i]-&gt;user_gpu_id, start, last);
+				clear_bit(i, prange-&gt;bitmap_access);
+			}
+		}
+	}</pre>
    </blockquote>
    I suspect this issue is caused by a low-level test application that
    doesn’t initialize KFD through the Thunk.<br>
    <br>
    Could we update svm_range_list_init() to check for drm_priv before
    marking SVM as supported? With that check in place, this change and
    the other related change below may no longer be necessary.<br>
    <br>
    @@ -3468,7 +3468,8 @@ int svm_range_list_init(struct kfd_process *p)<br>
    &nbsp; &nbsp; &nbsp; &nbsp; spin_lock_init(&amp;svms-&gt;deferred_list_lock);<br>
    &nbsp;<br>
    &nbsp; &nbsp; &nbsp; &nbsp; for (i = 0; i &lt; p-&gt;n_pdds; i++)<br>
    -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if
    (KFD_IS_SVM_API_SUPPORTED(p-&gt;pdds[i]-&gt;dev-&gt;adev))<br>
    +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if
    (KFD_IS_SVM_API_SUPPORTED(p-&gt;pdds[i]-&gt;dev-&gt;adev) &amp;&amp;<br>
    +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;p-&gt;pdds[i]-&gt;drm_priv)<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; bitmap_set(svms-&gt;bitmap_supported, i, 1);<br>
    &nbsp;<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Value of default granularity cannot exceed 0x1B, the<br>
    <br>
    Regards,<br>
    Philip<br>
    <br>
    <blockquote type="cite" cite="mid:20261123094229.12597-1-lingshan.zhu@amd.com">
      <pre wrap="" class="moz-quote-pre">
 
 	svm_range_set_default_attributes(svms, &amp;prange-&gt;preferred_loc,
 					 &amp;prange-&gt;prefetch_loc,
@@ -722,6 +731,13 @@ svm_range_check_attr(struct kfd_process *p,
 			break;
 		case KFD_IOCTL_SVM_ATTR_ACCESS:
 		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
+			gpuidx = kfd_process_gpuidx_from_gpuid(p, val);
+			if (gpuidx &gt;= 0 &amp;&amp; !p-&gt;pdds[gpuidx]-&gt;drm_priv) {
+				pr_debug(&quot;GPU %d has no VM acquired, so SVM does not work on it, please acquire VM for it first\n&quot;,
+					 val);
+				return -EINVAL;
+			}
+			break;
 		case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
 			gpuidx = kfd_process_gpuidx_from_gpuid(p, val);
 			break;
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------ESJhuD4reYZVipRoYXwU0rFu--
